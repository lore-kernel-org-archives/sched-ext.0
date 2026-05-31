Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F20345CBC
	for <sched-ext@lists.linux.dev>; Sun, 31 May 2026 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241281; cv=none; b=iyvaBu54zwrVWo+zyupHmnFrIiPzvrCQeKevHXhWTCQIlZIsIB07CE5XqC0yvBEyNzvCoQ8J8x3kC8kd7dq8usgYUMzENOIU5/zIvwyHw33ftmK57Ba/v3H+su+6hetzdaiRw9DDMuJTKvPU0R9lQ2sqeDbrtX6ZCJFuZXOgkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241281; c=relaxed/simple;
	bh=hI7xsPfQRHqSBJ530WQDxj0BvBgfadvWJBVKWqpD2ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8GTlDyG2+L0lSBEOZkEi+3aQ/ikSg0jmYXVHSM7sjRjmieqLdRIFh8KzZlVw6IitP7i4gClZmqehix2wImbJYEqaCmp9aVLEOd7dvX/U1bH/Yt/UmHksDkUwJHdkdIfaoQPnbwvMe1RLn6FCqVczt0/iCve6Y5/jdDD7MVgPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIox+X9T; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIox+X9T"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf77d4a4e2so4707395ad.1
        for <sched-ext@lists.linux.dev>; Sun, 31 May 2026 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780241279; x=1780846079; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFnhJcu6+WUXVGu6SJp5wFZKrd3XD1Qs6IIb1DLAUj0=;
        b=pIox+X9TqEw6aeHOpOVZjY0xBlIBGIQ+obYDHvR2ucTG5dUAmeXxgf4iPzXH7DoZ7y
         GjEpblWdaS6gqddYrTZfksFLWVHs4SOkIO3qVjWufOGeUZiMn7u1wThtU/RKpx5A47tW
         J5V+TdYdP1Y+RA6QxdKQ3mnVpl+5mZtSObN6xZc0nyGCBLG0lJJVewknQTb9/WLVYjej
         VBPIGZYH/vg8SGk+LYVsGL35H75Y6A3TMOZjo7huDMwNG9jWPHRC/uFj7EkAaWBS4Ghr
         ihkQiwETApQEYXOqvn6AkvFCDNm9p2bQx3jcp3Tl2Uh/GOx3lnLfwoArbPj6qxMg/pgd
         OmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241279; x=1780846079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YFnhJcu6+WUXVGu6SJp5wFZKrd3XD1Qs6IIb1DLAUj0=;
        b=Z4WNyPHWw2WS4Mz5CW0W876lrTRXjjaKhVlSKVJtZGfQQNvvJrasMHLOmgFym3f+6F
         Ew9WeF2niLUb67iZBPFrikCNkjF7Zh2P5bI3xH8ptBK0OCj/ivHqOSBjXh27d/DyezUO
         cg0jhidWI1H+446xabqVzrgwoDO4RS7PqQzS1ceGHNAFhJgJwJ/68rfl77jz5mT7kgot
         cd7CLbbMia+W2ZsMLQOPIbF7eorJaKWLvF9w2zcC1Wd4UxEgq3R6jqPTzDYSW6aEW9Kt
         kttC1GzcIJRbawv3Cy/guZY8BD5IRyHVUiVwnnHwGRd6IarKnkKCvEo2Q+pyvsHLUkNw
         vPAA==
X-Gm-Message-State: AOJu0YyVV0FSV5vLuQgNejgA4m7XgACrx8J8AYbC7cNgxcvvQHrBmwOZ
	OlH6Qnt/A+i9ReDdQ+57aKGIUE3If/zeuARTiZ9zknMYCtCkPbBOn8snVfmh/A==
X-Gm-Gg: Acq92OHGL5NE+SqvYNsh/73fL23TzSI5h3mlDDhrdYEmEn8O8K/axgPJz1/rn+lyY0F
	cbm+fdbDGPkDqUMHgD3HZ6/MRdwz1wClB3xlHlajzQYXU+/nHRbYp/XTxjAq5JZ2VLINnzKrDl+
	Su3sWW17o0AkdbF2Y4f6fSa9o9gFmP3HhU/EW3RIR2pdNTVbub2TG6mZpo8zdqNWYy7drbv6RVl
	dJI/nJ0nqPYT6UL/UCmdSN+1Ti3FOkpwRF5FJ++ltKS5C7N134EscWsAltHdq+ZXyFM47tyVVVJ
	tWNheK0DjxQDnmDeo+u6IDvgRqIBko7eVcZgaLRdj9ECX2C+/Q5CIL0snUiW7QYTFX3Awk0T9/5
	BrR5Zhzeck8kkBqQaNcYF/s+H+P8VpXohRQQ3p3XrehDrREv629aKYmsCJya2koclXn4yhFU8I9
	5wXVxwlUoYrUaWryhrGZXt19XY1sB/b1b6IiDYAs1eLGh6n/R9t5gapOI/DHd3c8I=
X-Received: by 2002:a17:902:e413:b0:2bf:21e6:bae1 with SMTP id d9443c01a7336-2bf21e6bd4bmr58445885ad.18.1780241278746;
        Sun, 31 May 2026 08:27:58 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:1fc8:a0da:7205:7281])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a00c13sm83921845ad.28.2026.05.31.08.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:27:58 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report cpumask of stalled CPUs
Date: Sun, 31 May 2026 23:25:27 +0800
Message-ID: <20260531152646.1206799-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260531152646.1206799-1-yphbchou0911@gmail.com>
References: <20260531152646.1206799-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_rcu_cpu_stall() previously recorded the detector CPU rather than the
stalled one, and the expedited grace period path had no stalled CPU to
report at all.

Thread a cpumask through panic_on_rcu_stall() and scx_rcu_cpu_stall()
to capture all stalled CPUs. Report cpumask_first() as exit_cpu and the
full CPU list in the exit message. Task-only stalls yield exit_cpu = -1.

Store the stall mask in scx_sched rather than scx_exit_info, keeping the
BPF-visible struct unchanged. scx_dump_state() reads sch->stall_cpus
directly and dumps all stalled CPUs first to avoid losing them to
truncation.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 include/linux/sched/ext.h   |  4 +-
 kernel/rcu/tree.c           |  3 ++
 kernel/rcu/tree_exp.h       |  5 ++-
 kernel/rcu/tree_stall.h     | 13 +++++--
 kernel/sched/ext.c          | 73 ++++++++++++++++++++++++++++++++-----
 kernel/sched/ext_internal.h |  1 +
 6 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 20b2343aa344..75cb8b119fb7 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -263,7 +263,7 @@ void sched_ext_dead(struct task_struct *p);
 void print_scx_info(const char *log_lvl, struct task_struct *p);
 void scx_softlockup(u32 dur_s);
 bool scx_hardlockup(int cpu);
-bool scx_rcu_cpu_stall(void);
+bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
@@ -271,7 +271,7 @@ static inline void sched_ext_dead(struct task_struct *p) {}
 static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 static inline void scx_softlockup(u32 dur_s) {}
 static inline bool scx_hardlockup(int cpu) { return false; }
-static inline bool scx_rcu_cpu_stall(void) { return false; }
+static inline bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask) { return false; }
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e..03c9651be5c0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4871,6 +4871,9 @@ static void __init rcu_dump_rcu_node_tree(void)
 
 struct workqueue_struct *rcu_gp_wq;
 
+static struct cpumask rcu_stall_cpumask;
+static struct cpumask rcu_exp_stall_cpumask;
+
 void __init rcu_init(void)
 {
 	int cpu = smp_processor_id();
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 82cada459e5d..46b6907f1b09 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -578,6 +578,7 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
 			if (!(READ_ONCE(rnp->expmask) & mask))
 				continue;
 			ndetected++;
+			cpumask_set_cpu(cpu, &rcu_exp_stall_cpumask);
 			rdp = per_cpu_ptr(&rcu_data, cpu);
 			pr_cont(" %d-%c%c%c%c", cpu,
 				"O."[!!cpu_online(cpu)],
@@ -665,6 +666,8 @@ static void synchronize_rcu_expedited_wait(void)
 		if (rcu_stall_is_suppressed())
 			continue;
 
+		cpumask_clear(&rcu_exp_stall_cpumask);
+
 		nbcon_cpu_emergency_enter();
 
 		j = jiffies;
@@ -675,7 +678,7 @@ static void synchronize_rcu_expedited_wait(void)
 
 		nbcon_cpu_emergency_exit();
 
-		panic_on_rcu_stall();
+		panic_on_rcu_stall(&rcu_exp_stall_cpumask);
 	}
 }
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..d0c4f193f17e 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -159,7 +159,7 @@ static int __init check_cpu_stall_init(void)
 early_initcall(check_cpu_stall_init);
 
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
-static void panic_on_rcu_stall(void)
+static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
 {
 	static int cpu_stall;
 
@@ -167,7 +167,7 @@ static void panic_on_rcu_stall(void)
 	 * Attempt to kick out the BPF scheduler if it's installed and defer
 	 * the panic to give the system a chance to recover.
 	 */
-	if (scx_rcu_cpu_stall())
+	if (scx_rcu_cpu_stall(stalled_mask))
 		return;
 
 	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
@@ -645,6 +645,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	cpumask_clear(&rcu_stall_cpumask);
+
 	nbcon_cpu_emergency_enter();
 
 	/*
@@ -660,6 +662,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 			for_each_leaf_node_possible_cpu(rnp, cpu)
 				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
 					print_cpu_stall_info(cpu);
+					cpumask_set_cpu(cpu, &rcu_stall_cpumask);
 					ndetected++;
 				}
 		}
@@ -701,7 +704,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	nbcon_cpu_emergency_exit();
 
-	panic_on_rcu_stall();
+	panic_on_rcu_stall(&rcu_stall_cpumask);
 
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
@@ -754,7 +757,9 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	nbcon_cpu_emergency_exit();
 
-	panic_on_rcu_stall();
+	cpumask_clear(&rcu_stall_cpumask);
+	cpumask_set_cpu(smp_processor_id(), &rcu_stall_cpumask);
+	panic_on_rcu_stall(&rcu_stall_cpumask);
 
 	/*
 	 * Attempt to revive the RCU machinery by forcing a context switch.
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0c37b5fd58b0..28009d08762b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4966,6 +4966,8 @@ static const struct attribute_group scx_global_attr_group = {
 
 static void free_pnode(struct scx_sched_pnode *pnode);
 static void free_exit_info(struct scx_exit_info *ei);
+static const char *scx_exit_reason(enum scx_exit_kind kind);
+static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind);
 
 static s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch)
 {
@@ -5022,6 +5024,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	timer_shutdown_sync(&sch->bypass_lb_timer);
 	free_cpumask_var(sch->bypass_lb_donee_cpumask);
 	free_cpumask_var(sch->bypass_lb_resched_cpumask);
+	free_cpumask_var(sch->stall_cpus);
 
 #ifdef CONFIG_EXT_SUB_SCHED
 	kfree(sch->cgrp_path);
@@ -5251,9 +5254,46 @@ static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
  * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
  * else already initiated abort.
  */
-bool scx_rcu_cpu_stall(void)
+bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
 {
-	return handle_lockup(-1, "RCU CPU stall detected!");
+	struct scx_sched *sch;
+	struct scx_exit_info *ei;
+	int exit_cpu;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return false;
+
+	switch (scx_enable_state()) {
+	case SCX_ENABLING:
+	case SCX_ENABLED:
+		break;
+	default:
+		return false;
+	}
+
+	exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
+	ei = sch->exit_info;
+
+	guard(preempt)();
+
+	if (!scx_claim_exit(sch, SCX_EXIT_ERROR))
+		return false;
+
+#ifdef CONFIG_STACKTRACE
+	ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
+#endif
+	scnprintf(ei->msg, SCX_EXIT_MSG_LEN, "RCU CPU stall on CPUs (%*pbl)",
+		  cpumask_pr_args(stalled_mask));
+	ei->kind = SCX_EXIT_ERROR;
+	ei->reason = scx_exit_reason(SCX_EXIT_ERROR);
+	ei->exit_cpu = exit_cpu;
+	cpumask_copy(sch->stall_cpus, stalled_mask);
+
+	irq_work_queue(&sch->disable_irq_work);
+	return true;
 }
 
 /**
@@ -6672,14 +6712,23 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	dump_line(&s, "----------");
 
 	/*
-	 * Dump the exit CPU first so it isn't lost to dump truncation, then
-	 * walk the rest in order, skipping the one already dumped.
+	 * Dump stalled CPUs first so they aren't lost to dump truncation, then
+	 * walk the rest in order. Fall back to exit_cpu if no stall mask set.
 	 */
-	if (ei->exit_cpu >= 0)
-		scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
-	for_each_possible_cpu(cpu) {
-		if (cpu != ei->exit_cpu)
+	if (!cpumask_empty(sch->stall_cpus)) {
+		for_each_cpu(cpu, sch->stall_cpus)
 			scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
+		for_each_possible_cpu(cpu) {
+			if (!cpumask_test_cpu(cpu, sch->stall_cpus))
+				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
+		}
+	} else {
+		if (ei->exit_cpu >= 0)
+			scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
+		for_each_possible_cpu(cpu) {
+			if (cpu != ei->exit_cpu)
+				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
+		}
 	}
 
 	dump_newline(&s);
@@ -6916,6 +6965,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		ret = -ENOMEM;
 		goto err_free_lb_cpumask;
 	}
+	if (!zalloc_cpumask_var(&sch->stall_cpus, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err_free_lb_resched_cpumask;
+	}
 	/*
 	 * Copy ops through the right union view. For cid-form the source is
 	 * struct sched_ext_ops_cid which lacks the trailing cpu_acquire/
@@ -6994,8 +7047,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 #ifdef CONFIG_EXT_SUB_SCHED
 err_free_lb_resched:
 	RCU_INIT_POINTER(ops->priv, NULL);
-	free_cpumask_var(sch->bypass_lb_resched_cpumask);
+	free_cpumask_var(sch->stall_cpus);
 #endif
+err_free_lb_resched_cpumask:
+	free_cpumask_var(sch->bypass_lb_resched_cpumask);
 err_free_lb_cpumask:
 	free_cpumask_var(sch->bypass_lb_donee_cpumask);
 err_stop_helper:
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 2f15a4d3c534..f48dfda3facb 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1199,6 +1199,7 @@ struct scx_sched {
 	struct timer_list	bypass_lb_timer;
 	cpumask_var_t		bypass_lb_donee_cpumask;
 	cpumask_var_t		bypass_lb_resched_cpumask;
+	cpumask_var_t		stall_cpus;
 	struct rcu_work		rcu_work;
 
 	/* all ancestors including self */
-- 
2.48.1

