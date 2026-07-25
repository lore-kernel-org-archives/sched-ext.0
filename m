Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA403126B9;
	Sat, 25 Jul 2026 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940625; cv=none; b=Va62J9dLF6dpod0HkcukPOdO4Hq6cGWaU9p+E24kRcQdjP/SzgiPZqtQYcQ7dbioLj/T9g9S8Wy5T8RMz/Y2EXMepZIx7y0dMVCczwMEQkkjfgR05kqdtGPSsKgRMEUXp+Z5kJ9xh4kfuZ2i7BFkhW3UF8aaD898sM1Fxi2XcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940625; c=relaxed/simple;
	bh=5R1oNpuxwnD/mLYU4R0LbsnTyBo60Hrk6tzhi8mhvJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KywSGXjngeT5DEJ1B3uTytsnNM4tWzUC5Rqna9OfvVl0iXUzDxgQ6ibFtgUPwC23XjjlyaLLuJSwR7IvDTBMIbC6O+A7iBfI/A/T7wS7apZJrNmOstq0uOh6ZNg4486pOlS+6ZECBcfWk7s7Yzsho9ks02V9TXGCs9pKEz+aSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRtq4o+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRtq4o+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EC41F00A3D;
	Sat, 25 Jul 2026 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784940624;
	bh=afQgCkiGzgAbX7OCYcm0u9z4G7NSoUP6hhZ8nWHzcYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bRtq4o+uBt+UtBFJFMJt3WeLFJmAh/iX7zPz0MGxfLNp/9LBfXrAUdNK0eGBo/C7G
	 ZgzNeJg0BF3ezwyy2bLrnNQyakKhva57Buz4m1Evbs2Jy+dZyK482tjggtj8oUiXAB
	 s2GCJFgPh2ZCiQ7WBUQt4Hek+8G/Xiw6admzEBVNYDAMhXKj39ZwJF/k7auM7fybvC
	 5id6ysb9EFVa6M2WYtZ1oUUyyAYpDihLP/6brkCrOMvDqXM+cUiiSBHD0obKDeoNfm
	 +/QfeSryVnwgkTAhUW+8txGtRfo/bxeKWsr64s6Tkzyei6FrGCgQOfokDXV6vcbpDV
	 8lHJu3n3FVTKQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] sched_ext: Abort directly from the hardlockup handler
Date: Fri, 24 Jul 2026 14:50:18 -1000
Message-ID: <20260725005019.1297049-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725005019.1297049-1-tj@kernel.org>
References: <20260725005019.1297049-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_hardlockup() defers the abort to an irq_work because exit claiming used
to take scx_sched_lock and couldn't run from NMI. The deferral is now
unnecessary - claiming is NMI-safe and asserting ->aborting is exactly what
breaks the live-locks that hard-lock CPUs. Call handle_lockup() directly and
drop the irq_work. This also makes the self-detected case recoverable: the
perf watchdog fires on the hard-locked CPU itself, where a queued irq_work
never runs with IRQs off.

Also fix the return value: %true used to be returned whenever sched_ext was
loaded, suppressing the kernel's hardlockup report even when the abort was
refused. Return %true only when this call initiated the abort.

Fixes: bd2d76455b65 ("sched_ext: Defer scx_hardlockup() out of NMI")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4338dc6a3f3a..9f5729c2c5e2 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5382,25 +5382,6 @@ void scx_softlockup(u32 dur_s)
 			cpu, dur_s);
 }
 
-/*
- * scx_hardlockup() runs from NMI and eventually calls scx_claim_exit(),
- * which takes scx_sched_lock. scx_sched_lock isn't NMI-safe and grabbing
- * it from NMI context can lead to deadlocks. Defer via irq_work; the
- * disable path runs off irq_work anyway.
- */
-static atomic_t scx_hardlockup_cpu = ATOMIC_INIT(-1);
-
-static void scx_hardlockup_irq_workfn(struct irq_work *work)
-{
-	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
-
-	if (cpu >= 0 && handle_lockup(cpu, "hard lockup - CPU %d", cpu))
-		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
-				cpu);
-}
-
-static DEFINE_IRQ_WORK(scx_hardlockup_irq_work, scx_hardlockup_irq_workfn);
-
 /**
  * scx_hardlockup - sched_ext hardlockup handler
  * @cpu: the target CPU
@@ -5410,19 +5391,21 @@ static DEFINE_IRQ_WORK(scx_hardlockup_irq_work, scx_hardlockup_irq_workfn);
  * Try kicking out the current scheduler in an attempt to recover the system to
  * a good state before taking more drastic actions.
  *
- * Queues an irq_work; the handle_lockup() call happens in IRQ context (see
- * scx_hardlockup_irq_workfn).
+ * Called from NMI. Aborting the scheduler sets ->aborting throughout the
+ * hierarchy before returning, which is what breaks the dispatch-path live-locks
+ * that can hard-lock CPUs.
  *
- * Returns %true if sched_ext is enabled and the work was queued, %false
- * otherwise.
+ * Returns %true if sched_ext is enabled and abort was initiated, which may
+ * resolve the lockup. %false if sched_ext is not enabled or abort was already
+ * initiated by someone else.
  */
 bool scx_hardlockup(int cpu)
 {
-	if (!rcu_access_pointer(scx_root))
+	if (!handle_lockup(cpu, "hard lockup - CPU %d", cpu))
 		return false;
 
-	atomic_cmpxchg(&scx_hardlockup_cpu, -1, cpu);
-	irq_work_queue(&scx_hardlockup_irq_work);
+	printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
+			cpu);
 	return true;
 }
 
-- 
2.55.0

