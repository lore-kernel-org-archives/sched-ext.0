Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6D27BF93;
	Tue, 11 Nov 2025 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886015; cv=none; b=be1cd+X7rUOzyS5FI4TE3exazuakS4S7HTJawJrKKobosgrXYfZMf/4lE1/VhrLhuLR7LIC3pXsjqsJRNlORBGmDqGwRApwHzsHaI4WBjfPGza8/KjJs+QukAx+jGlbgD/CP6L1cyV2TmHeUrNHeER8qcWvf3srQt6zn9B0+R6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886015; c=relaxed/simple;
	bh=1HJcV7GZrAw9eMCs6+wFo3dRZZnMGcmNJU1ail4BGp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnu7Gca2NwmO+kyoLtO8SrHFMuQS5lppZ8IUnLaC9qMhYRpAOljwnLKG1c9LP+uEDWyyTZh2KUlS3R9OEahwCBqVUSbk/sL5tGDLp4lxrUS7pJCXAuQXKqMpWWgwoKG3p5j8ntLxVSVWsxOuI0AAvDZmcTOFUqUOxt0Jk+O3Yhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn0NoQOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn0NoQOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2F3C113D0;
	Tue, 11 Nov 2025 18:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886015;
	bh=1HJcV7GZrAw9eMCs6+wFo3dRZZnMGcmNJU1ail4BGp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nn0NoQOJnS5qyu8gutBMsOeaTkVv0dOS7K9JIz/EVJ1p8YErnnTEvDbNrVmMJ346K
	 XGELB5AalwHMKlMeIR00TX90gkFtDkZ0WCjzXDAzrZ80m/8GS6jgZeaflc6iECO6n6
	 hH2pJAGgR36rB7GeWq2YP4xhVYty37Zyvr1ziiWXZtHJzDMGfSYH9eeNWjrNhhVYvF
	 oreqwtA3Zo4zlRPJwU1HBKlo9PHG5Tx7rJ6xxol4JI63YJyn0X4oJ+qnpqVrTPuilM
	 8oN3sYgAdBKkIYZIT2o7OVNqPkScEWJs9j31fOzKWzPhy1QQAZkLcZobQByQAOgzFN
	 d7tPcOFKirfaA==
Date: Tue, 11 Nov 2025 08:33:34 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH UPDATED 10/14] sched_ext: Hook up hardlockup detector
Message-ID: <aROBfmtos9_3RX9a@slm.duckdns.org>
References: <20251110205636.405592-1-tj@kernel.org>
 <20251110205636.405592-11-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110205636.405592-11-tj@kernel.org>

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
 include/linux/sched/ext.h |    2 ++
 kernel/sched/ext.c        |   18 ++++++++++++++++++
 kernel/watchdog.c         |    9 +++++++++
 3 files changed, 29 insertions(+)

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
+static inline bool scx_hardlockup(void) {}
 static inline bool scx_rcu_cpu_stall(void) { return false; }
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3712,6 +3712,24 @@ void scx_softlockup(u32 dur_s)
 }
 
 /**
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
+/**
  * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
  * @bypass: true for bypass, false for unbypass
  *
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -196,6 +196,15 @@ void watchdog_hardlockup_check(unsigned
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
