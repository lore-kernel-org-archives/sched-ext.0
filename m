Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE45266581;
	Fri, 24 Apr 2026 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061674; cv=none; b=H6IqxSAl6tuWUEiV+gs9SI2eLtMw4h6P1kFdWGbW2fEcyfnwAgPrgO0bM1AcQ8QvBrZ5wnkYlHP3gaSc8dqkV33Kx3ZBAR3ztCnvrDsonA20LNdeLXWMtbZxCgO7Ddtl21V0S4P7B9CN1zcVD0CNGdOkDYS9OBedsIX6p7YCQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061674; c=relaxed/simple;
	bh=TLHWBccd7iGRJcDkNtOUKznKXdnqbdlRIBdg9pVzdUI=;
	h=Date:Message-ID:From:To:Cc:Subject; b=l2KMOiNWstudplZnu46s1RSp6OMQyeMKQFyePMGT6xUka7c+GOgt25UTEK4x8OSOssecQ07dX/soF4tOUX1DXhuUqrDq1Y2x8zGWmDG2qMutQfVU5glh8JjrHOZe0Q5wV1gLVGRzydmaQHEkCJa9YqScHeiK7lVJgQsDm5sqDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWbE37DE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWbE37DE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7EDC19425;
	Fri, 24 Apr 2026 20:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777061673;
	bh=TLHWBccd7iGRJcDkNtOUKznKXdnqbdlRIBdg9pVzdUI=;
	h=Date:From:To:Cc:Subject:From;
	b=ZWbE37DEhDTV0XyyS64aNWS7e4OVm+jHdjbJAYCgfRlQ8i26kK069rwNcd3XF9SWx
	 SvaAghbmOXR3cLl3Mv9tKSv9O8Z9aQ4OTAFKfMCWD/UVLInOkRXB7Qhdr+m1gLQ+ri
	 xQyzmkStIiDkgA4Mk6gjYR1F4ly4tBTwxwoRTqsYbE8nXivRhISybwhtoVk9Tz6x7V
	 V5sJ1ng3J9MxgOiB3A2LcBaeMZAn8bWNg0xLCwLC5odYMjfosF+lA9tgNvSM/9cMgo
	 yxzZ2VFZLbGTlRwZeDe8vHdsNpSHxjrI/fFIsddZAraifWZaimC7tFU9TA15UcKi0P
	 Jn986M8mbcdFQ==
Date: Fri, 24 Apr 2026 10:14:32 -1000
Message-ID: <e78c625bf7ef51fef0e564d9c25482aa@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 emil@etsalapatis.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Defer scx_hardlockup() out of NMI
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_hardlockup() runs from NMI and eventually calls scx_claim_exit(),
which takes scx_sched_lock. scx_sched_lock isn't NMI-safe and grabbing
it from NMI context can lead to deadlocks.

The hardlockup handler is best-effort recovery and the disable path it
triggers runs off of irq_work anyway. Move the handle_lockup() call into
an irq_work so it runs in IRQ context.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5142,6 +5142,25 @@ void scx_softlockup(u32 dur_s)
 			smp_processor_id(), dur_s);
 }

+/*
+ * scx_hardlockup() runs from NMI and eventually calls scx_claim_exit(),
+ * which takes scx_sched_lock. scx_sched_lock isn't NMI-safe and grabbing
+ * it from NMI context can lead to deadlocks. Defer via irq_work; the
+ * disable path runs off irq_work anyway.
+ */
+static atomic_t scx_hardlockup_cpu = ATOMIC_INIT(-1);
+
+static void scx_hardlockup_irq_workfn(struct irq_work *work)
+{
+	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
+
+	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
+		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
+				cpu);
+}
+
+static DEFINE_IRQ_WORK(scx_hardlockup_irq_work, scx_hardlockup_irq_workfn);
+
 /**
  * scx_hardlockup - sched_ext hardlockup handler
  *
@@ -5150,17 +5169,19 @@ void scx_softlockup(u32 dur_s)
  * Try kicking out the current scheduler in an attempt to recover the system to
  * a good state before taking more drastic actions.
  *
- * Returns %true if sched_ext is enabled and abort was initiated, which may
- * resolve the reported hardlockup. %false if sched_ext is not enabled or
- * someone else already initiated abort.
+ * Queues an irq_work; the handle_lockup() call happens in IRQ context (see
+ * scx_hardlockup_irq_workfn).
+ *
+ * Returns %true if sched_ext is enabled and the work was queued, %false
+ * otherwise.
  */
 bool scx_hardlockup(int cpu)
 {
-	if (!handle_lockup("hard lockup - CPU %d", cpu))
+	if (!rcu_access_pointer(scx_root))
 		return false;

-	printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
-			cpu);
+	atomic_cmpxchg(&scx_hardlockup_cpu, -1, cpu);
+	irq_work_queue(&scx_hardlockup_irq_work);
 	return true;
 }

