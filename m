Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D621F328600;
	Tue, 11 Nov 2025 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888707; cv=none; b=pjIZVnQ053Awca/jFxaJfZ73e4CtTMSoUJ9gL/QX0CVys0sQXqJEKfUdHsRDtE92HtVa/fomylcoDwVmuU/POxWzgkuVFFWQOfcrYVNf97h8AZnYGYqroHJFvi+RclbBezpFrGFjTPzb8iNT4/RnvvlWVes8d83rHJ/m25lczfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888707; c=relaxed/simple;
	bh=XHnnNXq+F81VDZ1BIclAa27BVcC/GfWHXhbrivuH9og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1PQdDSX8eh7saFB9OFa3LzzSKEeGsDuiMDydvCDu94OiKBaig299WfJ1Eaz5EBEuoXdTNUe4qSqNuZf+3TCJGoCC1ACQEBtAS1bG5MvCNCUcooznJGYhBQtoIi13rxQPmxbdw9ed+8wi1JANMTH0yvxPG1kXof9qlD2gRzNrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avVTEjzi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avVTEjzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411FEC19422;
	Tue, 11 Nov 2025 19:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888707;
	bh=XHnnNXq+F81VDZ1BIclAa27BVcC/GfWHXhbrivuH9og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avVTEjziMvR3P53yILajPkIZRjMfsJTEhiGIA9y5sUArFCbZdMVrIOsM3p0kFin7S
	 LSE/+6aUOtHvLVQl6ZryOsLaNP5EPjiDqsyHyR8qWQOUDV8XYKzVShL2ShCQ4IE13H
	 oJCJXDH5j54Ftz4B+xj/Mai2Si6j25BfKSME2aWQUFa+jyFt7K8tklsbFpIeCzUyGR
	 sL3vyy/Dg9SVtfd1dWuQi4seVc/i7A1he6sBsesm/tMYCcJV5NGAqw7Q2+iCMcm4NJ
	 e3mRfAZU1GOyUHFgPqAsK1dU8Du9x8bF7OFOto9pwPSN1W/atrrLFL+dt2JtgqeVCD
	 eYtAlt8NV4TCw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH 09/13] sched_ext: Hook up hardlockup detector
Date: Tue, 11 Nov 2025 09:18:12 -1000
Message-ID: <20251111191816.862797-10-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A poorly behaving BPF scheduler can trigger hard lockup. For example, on a
large system with many tasks pinned to different subsets of CPUs, if the BPF
scheduler puts all tasks in a single DSQ and lets all CPUs at it, the DSQ lock
can be contended to the point where hardlockup triggers. Unfortunately,
hardlockup can be the first signal out of such situations, thus requiring
hardlockup handling.

Hook scx_hardlockup() into the hardlockup detector to try kicking out the
current scheduler in an attempt to recover the system to a good state. The
handling strategy can delay watchdog taking its own action by one polling
period; however, given that the only remediation for hardlockup is crash, this
is likely an acceptable trade-off.

v2: Add missing dummy scx_hardlockup() definition for
    !CONFIG_SCHED_CLASS_EXT (kernel test bot).

Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  2 ++
 kernel/sched/ext.c        | 18 ++++++++++++++++++
 kernel/watchdog.c         |  9 +++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 3d3216ff9188..d6c152475f5b 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -223,6 +223,7 @@ struct sched_ext_entity {
 void sched_ext_dead(struct task_struct *p);
 void print_scx_info(const char *log_lvl, struct task_struct *p);
 void scx_softlockup(u32 dur_s);
+bool scx_hardlockup(void);
 bool scx_rcu_cpu_stall(void);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
@@ -230,6 +231,7 @@ bool scx_rcu_cpu_stall(void);
 static inline void sched_ext_dead(struct task_struct *p) {}
 static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 static inline void scx_softlockup(u32 dur_s) {}
+static inline bool scx_hardlockup(void) { return false; }
 static inline bool scx_rcu_cpu_stall(void) { return false; }
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 85bb052459ec..b5c87a03f112 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3711,6 +3711,24 @@ void scx_softlockup(u32 dur_s)
 			smp_processor_id(), dur_s);
 }
 
+/**
+ * scx_hardlockup - sched_ext hardlockup handler
+ *
+ * A poorly behaving BPF scheduler can trigger hard lockup by e.g. putting
+ * numerous affinitized tasks in a single queue and directing all CPUs at it.
+ * Try kicking out the current scheduler in an attempt to recover the system to
+ * a good state before taking more drastic actions.
+ */
+bool scx_hardlockup(void)
+{
+	if (!handle_lockup("hard lockup - CPU %d", smp_processor_id()))
+		return false;
+
+	printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
+			smp_processor_id());
+	return true;
+}
+
 /**
  * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
  * @bypass: true for bypass, false for unbypass
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5b62d1002783..8dfac4a8f587 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -196,6 +196,15 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 #ifdef CONFIG_SYSFS
 		++hardlockup_count;
 #endif
+		/*
+		 * A poorly behaving BPF scheduler can trigger hard lockup by
+		 * e.g. putting numerous affinitized tasks in a single queue and
+		 * directing all CPUs at it. The following call can return true
+		 * only once when sched_ext is enabled and will immediately
+		 * abort the BPF scheduler and print out a warning message.
+		 */
+		if (scx_hardlockup())
+			return;
 
 		/* Only print hardlockups once. */
 		if (per_cpu(watchdog_hardlockup_warned, cpu))
-- 
2.51.2

