Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB7426ED2;
	Fri,  6 Mar 2026 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823991; cv=none; b=gYfmaNdEHTanMoJCzuVwI2FeNhagW9rQcCHxHKXmeH9Bw8WTT5Mua2kVUcTVLwaLh1Xpysx0cdlEpGzKj3QDQmKQJq9PcrNkYPPWiAYdhqWOOyIYorSxMra9akA6IP/gHg4u4Pmat2/Er3/9GM2a9d9+IdUxkXpU3BG1bf9gIyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823991; c=relaxed/simple;
	bh=Yxy6K8LHteFrkXzFGbUbBU1CURCqQSYDjsdQbgenMPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mo7rdFMMwcwphUkByHTCQJX5j0PkaUdmA0nvwy8rMk6Dcmqto7dF9GhDlHzcZd77fnmJczOCg4rVoAyckVdMPa4hWFLpQyIYTkNgpo8JyG+sZBQTczdMJ2N32/TqtwpCq4h5SRF8N6bRxKeZgjOyBMxHPSEtONrUZ5FQHx5f7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWt0t3Rq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWt0t3Rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89CEC19425;
	Fri,  6 Mar 2026 19:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823990;
	bh=Yxy6K8LHteFrkXzFGbUbBU1CURCqQSYDjsdQbgenMPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWt0t3RqwDzSMmIabYp70TgcMs/fvCt3EvDXE/9nubnHRYWtKVaHSRvDqEFaNbL5x
	 wHTDd9AZCtarNn82ZM88m89h6iYeb598UpNYUini39OiW3ubuTSpWUixTCCux6jOlU
	 3rD1Re9OUvV0Np1SrzvUEz6aRMCTqwtE1XVna7XfdGuQElumTeLBIAJupgxX9w7D9F
	 86Iu3rAOFgb3ftb2OW9YE8JsCLQ8UIkbb+Y0RcaHlCcBqJWAB4SG7YOyeyhMsL1RdI
	 TwzkzySYiuaxxdkCImV+1KKdxLsN1GWKBic69Dc4ydRN8AnqdJQ0u7v37eIJ/Pq4Fa
	 7vAkfpJGMom4g==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/15] sched_ext: Convert deferred_reenq_locals from llist to regular list
Date: Fri,  6 Mar 2026 09:06:14 -1000
Message-ID: <20260306190623.1076074-7-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The deferred reenqueue local mechanism uses an llist (lockless list) for
collecting schedulers that need their local DSQs re-enqueued. Convert to a
regular list protected by a raw_spinlock.

The llist was used for its lockless properties, but the upcoming changes to
support remote reenqueue require more complex list operations that are
difficult to implement correctly with lockless data structures. A spinlock-
protected regular list provides the necessary flexibility.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 57 ++++++++++++++++++++++++-------------
 kernel/sched/ext_internal.h |  2 +-
 kernel/sched/sched.h        |  3 +-
 3 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1b6cd1e4f8b9..ffccaf04e34d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3640,23 +3640,37 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq)
 	return nr_enqueued;
 }
 
-static void run_deferred(struct rq *rq)
+static void process_deferred_reenq_locals(struct rq *rq)
 {
-	process_ddsp_deferred_locals(rq);
-
-	if (!llist_empty(&rq->scx.deferred_reenq_locals)) {
-		struct llist_node *llist =
-			llist_del_all(&rq->scx.deferred_reenq_locals);
-		struct scx_sched_pcpu *pos, *next;
+	lockdep_assert_rq_held(rq);
 
-		llist_for_each_entry_safe(pos, next, llist,
-					  deferred_reenq_locals_node) {
-			init_llist_node(&pos->deferred_reenq_locals_node);
-			reenq_local(pos->sch, rq);
+	while (true) {
+		struct scx_sched *sch;
+
+		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
+			struct scx_sched_pcpu *sch_pcpu =
+				list_first_entry_or_null(&rq->scx.deferred_reenq_locals,
+							 struct scx_sched_pcpu,
+							 deferred_reenq_local_node);
+			if (!sch_pcpu)
+				return;
+
+			sch = sch_pcpu->sch;
+			list_del_init(&sch_pcpu->deferred_reenq_local_node);
 		}
+
+		reenq_local(sch, rq);
 	}
 }
 
+static void run_deferred(struct rq *rq)
+{
+	process_ddsp_deferred_locals(rq);
+
+	if (!list_empty(&rq->scx.deferred_reenq_locals))
+		process_deferred_reenq_locals(rq);
+}
+
 #ifdef CONFIG_NO_HZ_FULL
 bool scx_can_stop_tick(struct rq *rq)
 {
@@ -4180,13 +4194,13 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 
 	/*
 	 * $sch would have entered bypass mode before the RCU grace period. As
-	 * that blocks new deferrals, all deferred_reenq_locals_node's must be
+	 * that blocks new deferrals, all deferred_reenq_local_node's must be
 	 * off-list by now.
 	 */
 	for_each_possible_cpu(cpu) {
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
-		WARN_ON_ONCE(llist_on_list(&pcpu->deferred_reenq_locals_node));
+		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local_node));
 	}
 
 	free_percpu(sch->pcpu);
@@ -5799,7 +5813,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
 		pcpu->sch = sch;
-		init_llist_node(&pcpu->deferred_reenq_locals_node);
+		INIT_LIST_HEAD(&pcpu->deferred_reenq_local_node);
 	}
 
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
@@ -7126,7 +7140,8 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
-		init_llist_head(&rq->scx.deferred_reenq_locals);
+		raw_spin_lock_init(&rq->scx.deferred_reenq_lock);
+		INIT_LIST_HEAD(&rq->scx.deferred_reenq_locals);
 		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
 		rq->scx.kick_cpus_irq_work = IRQ_WORK_INIT_HARD(kick_cpus_irq_workfn);
 
@@ -8358,7 +8373,6 @@ __bpf_kfunc void scx_bpf_reenqueue_local___v2(const struct bpf_prog_aux *aux)
 	unsigned long flags;
 	struct scx_sched *sch;
 	struct rq *rq;
-	struct llist_node *lnode;
 
 	raw_local_irq_save(flags);
 
@@ -8374,9 +8388,14 @@ __bpf_kfunc void scx_bpf_reenqueue_local___v2(const struct bpf_prog_aux *aux)
 		goto out_irq_restore;
 
 	rq = this_rq();
-	lnode = &this_cpu_ptr(sch->pcpu)->deferred_reenq_locals_node;
-	if (!llist_on_list(lnode))
-		llist_add(lnode, &rq->scx.deferred_reenq_locals);
+	scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
+		struct scx_sched_pcpu *pcpu = this_cpu_ptr(sch->pcpu);
+
+		if (list_empty(&pcpu->deferred_reenq_local_node))
+			list_move_tail(&pcpu->deferred_reenq_local_node,
+				       &rq->scx.deferred_reenq_locals);
+	}
+
 	schedule_deferred(rq);
 out_irq_restore:
 	raw_local_irq_restore(flags);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 9e5ebd00ea0c..80d40a9c5ad9 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -965,7 +965,7 @@ struct scx_sched_pcpu {
 	 */
 	struct scx_event_stats	event_stats;
 
-	struct llist_node	deferred_reenq_locals_node;
+	struct list_head	deferred_reenq_local_node;
 	struct scx_dispatch_q	bypass_dsq;
 #ifdef CONFIG_EXT_SUB_SCHED
 	u32			bypass_host_seq;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ebe971d12cb8..0794852524e7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -808,7 +808,8 @@ struct scx_rq {
 
 	struct task_struct	*sub_dispatch_prev;
 
-	struct llist_head	deferred_reenq_locals;
+	raw_spinlock_t		deferred_reenq_lock;
+	struct list_head	deferred_reenq_locals;	/* scheds requesting reenq of local DSQ */
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
-- 
2.53.0

