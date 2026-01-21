Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656E45BD5E;
	Wed, 21 Jan 2026 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037121; cv=none; b=KrtxHgpryyqbLMwM4ddpTkfOnin0MAWSVJFoUacaaR9U+dWZ3yEaNQ4e/Bhjj46IqM8V4WAaugtTzEvAYmrEPescWzQ5KSGzI4GUCAb6emqUHlN0fL3DilPXK99xpmOME4eW8WPrlumeeqNj+LnxZFGHMgMNt4vguM+nrgvO+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037121; c=relaxed/simple;
	bh=UU//ViveDPOhV+zWVdKi31rcgqNFW599+8FANj/mV8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uN3qKUIrnZKi4U7Zsy38fYGmb+JyWuonlqu1ZWsnF1ZDSiU27mTk1FD4riCxtqbNuejXnz/EOgCytCGucicU0CyXxfH1yiBkuSPIf/JrxE6xeC46i0Er7ZVL3VeyfvKkSeG+bLgoNJ1GM618c4j8R+/4TSoEGv0CG7wcbP6hN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfP9bLBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfP9bLBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBE8C4CEF1;
	Wed, 21 Jan 2026 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037119;
	bh=UU//ViveDPOhV+zWVdKi31rcgqNFW599+8FANj/mV8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QfP9bLBmvB1q9NmN2steHgtkEQxqArqx+yx8VbacUE7mQ7BzzJgTS1Hp3cBvNt56n
	 BREuvRvZ05YlQ9LtSJLebo+7geidp7FJK7fOabFiFPQwLKZkQ9r6F+Bt+UUtxt00u9
	 rqGEcBRuArYl1Qmr503BG3qK0/WxrEuw/TrDMNEvY3PqCDHqg164m7ovw3ZIBtUpVE
	 +i8otKs3E0Ilrypw+/5Y2FCNGhfOu2wZGNRe1f0/4Z1XgJpTMlui20YDj33CnotJyI
	 2/Y25M5+95dIe1d5w/4QQMs9i/KYT5xtEZYS9hN6fsP1OCdJDPNvdr5wrRIhoe0cW5
	 bZWxlTOxqyt5Q==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 17/34] sched_ext: Move bypass_dsq into scx_sched_pcpu
Date: Wed, 21 Jan 2026 13:11:23 -1000
Message-ID: <20260121231140.832332-18-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support bypass mode for sub-schedulers, move bypass_dsq from struct scx_rq
to struct scx_sched_pcpu. Add bypass_dsq() helper. Move bypass_dsq
initialization from init_sched_ext_class() to scx_alloc_and_attach_sched().
bypass_lb_cpu() now takes a CPU number instead of rq pointer. All callers
updated. No behavior change as all tasks use the root scheduler.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 50 +++++++++++++++++++------------------
 kernel/sched/ext_internal.h |  2 ++
 kernel/sched/sched.h        |  1 -
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e71fce857c6b..4af34a25e022 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -358,6 +358,11 @@ static const struct sched_class *scx_setscheduler_class(struct task_struct *p)
 	return __setscheduler_class(p->policy, p->prio);
 }
 
+static struct scx_dispatch_q *bypass_dsq(struct scx_sched *sch, s32 cpu)
+{
+	return &per_cpu_ptr(sch->pcpu, cpu)->bypass_dsq;
+}
+
 /*
  * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
  * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
@@ -1567,7 +1572,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	dsq = find_global_dsq(sch, p);
 	goto enqueue;
 bypass:
-	dsq = &task_rq(p)->scx.bypass_dsq;
+	dsq = bypass_dsq(sch, task_cpu(p));
 	goto enqueue;
 
 enqueue:
@@ -2349,7 +2354,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		goto has_tasks;
 
 	if (scx_rq_bypassing(rq)) {
-		if (consume_dispatch_q(sch, rq, &rq->scx.bypass_dsq))
+		if (consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu_of(rq))))
 			goto has_tasks;
 		else
 			goto no_tasks;
@@ -4015,11 +4020,12 @@ bool scx_hardlockup(int cpu)
 	return true;
 }
 
-static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
+static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 			 struct cpumask *donee_mask, struct cpumask *resched_mask,
 			 u32 nr_donor_target, u32 nr_donee_target)
 {
-	struct scx_dispatch_q *donor_dsq = &rq->scx.bypass_dsq;
+	struct rq *donor_rq = cpu_rq(donor);
+	struct scx_dispatch_q *donor_dsq = bypass_dsq(sch, donor);
 	struct task_struct *p, *n;
 	struct scx_dsq_list_node cursor = INIT_DSQ_LIST_CURSOR(cursor, 0, 0);
 	s32 delta = READ_ONCE(donor_dsq->nr) - nr_donor_target;
@@ -4035,7 +4041,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 	if (delta < DIV_ROUND_UP(min_delta_us, scx_slice_bypass_us))
 		return 0;
 
-	raw_spin_rq_lock_irq(rq);
+	raw_spin_rq_lock_irq(donor_rq);
 	raw_spin_lock(&donor_dsq->lock);
 	list_add(&cursor.node, &donor_dsq->list);
 resume:
@@ -4043,7 +4049,6 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 	n = nldsq_next_task(donor_dsq, n, false);
 
 	while ((p = n)) {
-		struct rq *donee_rq;
 		struct scx_dispatch_q *donee_dsq;
 		int donee;
 
@@ -4059,14 +4064,13 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 		if (donee >= nr_cpu_ids)
 			continue;
 
-		donee_rq = cpu_rq(donee);
-		donee_dsq = &donee_rq->scx.bypass_dsq;
+		donee_dsq = bypass_dsq(sch, donee);
 
 		/*
 		 * $p's rq is not locked but $p's DSQ lock protects its
 		 * scheduling properties making this test safe.
 		 */
-		if (!task_can_run_on_remote_rq(sch, p, donee_rq, false))
+		if (!task_can_run_on_remote_rq(sch, p, cpu_rq(donee), false))
 			continue;
 
 		/*
@@ -4096,9 +4100,9 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 		if (!(nr_balanced % SCX_BYPASS_LB_BATCH) && n) {
 			list_move_tail(&cursor.node, &n->scx.dsq_list.node);
 			raw_spin_unlock(&donor_dsq->lock);
-			raw_spin_rq_unlock_irq(rq);
+			raw_spin_rq_unlock_irq(donor_rq);
 			cpu_relax();
-			raw_spin_rq_lock_irq(rq);
+			raw_spin_rq_lock_irq(donor_rq);
 			raw_spin_lock(&donor_dsq->lock);
 			goto resume;
 		}
@@ -4106,7 +4110,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 
 	list_del_init(&cursor.node);
 	raw_spin_unlock(&donor_dsq->lock);
-	raw_spin_rq_unlock_irq(rq);
+	raw_spin_rq_unlock_irq(donor_rq);
 
 	return nr_balanced;
 }
@@ -4124,7 +4128,7 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 
 	/* count the target tasks and CPUs */
 	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
-		u32 nr = READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr);
+		u32 nr = READ_ONCE(bypass_dsq(sch, cpu)->nr);
 
 		nr_tasks += nr;
 		nr_cpus++;
@@ -4146,24 +4150,21 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 
 	cpumask_clear(donee_mask);
 	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
-		if (READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr) < nr_target)
+		if (READ_ONCE(bypass_dsq(sch, cpu)->nr) < nr_target)
 			cpumask_set_cpu(cpu, donee_mask);
 	}
 
 	/* iterate !donee CPUs and see if they should be offloaded */
 	cpumask_clear(resched_mask);
 	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
-		struct rq *rq = cpu_rq(cpu);
-		struct scx_dispatch_q *donor_dsq = &rq->scx.bypass_dsq;
-
 		if (cpumask_empty(donee_mask))
 			break;
 		if (cpumask_test_cpu(cpu, donee_mask))
 			continue;
-		if (READ_ONCE(donor_dsq->nr) <= nr_donor_target)
+		if (READ_ONCE(bypass_dsq(sch, cpu)->nr) <= nr_donor_target)
 			continue;
 
-		nr_balanced += bypass_lb_cpu(sch, rq, donee_mask, resched_mask,
+		nr_balanced += bypass_lb_cpu(sch, cpu, donee_mask, resched_mask,
 					     nr_donor_target, nr_target);
 	}
 
@@ -4171,7 +4172,7 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 		resched_cpu(cpu);
 
 	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
-		u32 nr = READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr);
+		u32 nr = READ_ONCE(bypass_dsq(sch, cpu)->nr);
 
 		after_min = min(nr, after_min);
 		after_max = max(nr, after_max);
@@ -5052,7 +5053,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 {
 	struct scx_sched *sch;
 	s32 level = parent ? parent->level + 1 : 0;
-	int node, ret;
+	s32 node, cpu, ret;
 
 	sch = kzalloc(struct_size(sch, ancestors, level), GFP_KERNEL);
 	if (!sch)
@@ -5094,6 +5095,9 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		goto err_free_gdsqs;
 	}
 
+	for_each_possible_cpu(cpu)
+		init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
+
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
 	if (IS_ERR(sch->helper)) {
 		ret = PTR_ERR(sch->helper);
@@ -5273,7 +5277,6 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		struct rq *rq = cpu_rq(cpu);
 
 		rq->scx.local_dsq.sched = sch;
-		rq->scx.bypass_dsq.sched = sch;
 		rq->scx.cpuperf_target = SCX_CPUPERF_ONE;
 	}
 
@@ -6209,9 +6212,8 @@ void __init init_sched_ext_class(void)
 		struct rq *rq = cpu_rq(cpu);
 		int  n = cpu_to_node(cpu);
 
-		/* local/bypass dsq's sch will be set during scx_root_enable() */
+		/* local_dsq's sch will be set during scx_root_enable() */
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL);
-		init_dsq(&rq->scx.bypass_dsq, SCX_DSQ_BYPASS, NULL);
 
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 16c1f0eb6c69..b38505109dcb 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -932,6 +932,8 @@ struct scx_sched_pcpu {
 	 * constructed when requested by scx_bpf_events().
 	 */
 	struct scx_event_stats	event_stats;
+
+	struct scx_dispatch_q	bypass_dsq;
 };
 
 struct scx_sched {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d30cca6870f5..dd4df9f7f104 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -808,7 +808,6 @@ struct scx_rq {
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
-	struct scx_dispatch_q	bypass_dsq;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
 
-- 
2.52.0

