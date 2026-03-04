Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5993988F9;
	Wed,  4 Mar 2026 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661713; cv=none; b=UqBUY5dHQQii8sxnMaPN4tRDGluLCqLKDbtH3brj+TPoeljRvm6ob1zJpqt9jQuW+Po6LSsNnZUs16RL14XydptstxZUyaJKXxqetYiBYUPddIH3PLduZdzxCnPDwdBz1cy++tHTkWssfSZh0JoanJJHt+0DQYI4tqAaxjRkQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661713; c=relaxed/simple;
	bh=BuhKlormWzxtzLrKSJX4BbyU2BvTnVe7+YNANGb4NmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmJEg3hw/tacpn+cETLXofnjWDzPzuW5hk9n83YBOe8t6aK9LlhfAai9bjdzx6O5uy+f4Nojvr/q2pNWAd3baUeeaS7CM0QHqyEX12FrjAMwBnEs0jiJC4CSGeTZ+2hFP3lWrf1Cb9qYgUTFb5iD25R25uyKsogZkhEpXI3uSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9b6zZ/F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9b6zZ/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A38DC2BC86;
	Wed,  4 Mar 2026 22:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661713;
	bh=BuhKlormWzxtzLrKSJX4BbyU2BvTnVe7+YNANGb4NmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9b6zZ/F661FcvG2BLmKbB//l41+c6GxLvVadcvwL/2+G3zX/wCeOTR6Zak7b6JMD
	 iWq9qev/EHoLeBnme24PEeRhYs7XJnLovUx2PSpJVs8OL1Qw3sjyAXClS9mGxWytg8
	 OyUPqQe0rm80nfVKK0DTsZWxs6IselX9UsFBEotXW/usE+P60t5GKYI3awv+nYtUPM
	 Q9mFc2++rBR+lnvc3rRJiu+WMqPn/LIgqgIBMYlrtMWVhL+ks8bUWwoYg1jEicTEuX
	 g5w0QRDOUCryr2DKIP6BO8Mvp7WYCdGJLWV72tIA0NBHJ3nzlXkwi/7QndC4z0U10n
	 Y6PY2HIqq91sw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 31/34] sched_ext: Make scx_bpf_reenqueue_local() sub-sched aware
Date: Wed,  4 Mar 2026 12:01:16 -1000
Message-ID: <20260304220119.4095551-32-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_reenqueue_local() currently re-enqueues all tasks on the local DSQ
regardless of which sub-scheduler owns them. With multiple sub-schedulers,
each should only re-enqueue tasks it owns or are owned by its descendants.

Replace the per-rq boolean flag with a lock-free linked list to track
per-scheduler reenqueue requests. Filter tasks in reenq_local() using
hierarchical ownership checks and block deferrals during bypass to prevent
use on dead schedulers.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 73 ++++++++++++++++++++++++++++++-------
 kernel/sched/ext_internal.h |  1 +
 kernel/sched/sched.h        |  2 +-
 3 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c7651f40ff86..946cf4c946fd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -185,7 +185,7 @@ MODULE_PARM_DESC(bypass_lb_intv_us, "bypass load balance interval in microsecond
 
 static void process_ddsp_deferred_locals(struct rq *rq);
 static bool task_dead_and_done(struct task_struct *p);
-static u32 reenq_local(struct rq *rq);
+static u32 reenq_local(struct scx_sched *sch, struct rq *rq);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
 static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
@@ -991,9 +991,16 @@ static void run_deferred(struct rq *rq)
 {
 	process_ddsp_deferred_locals(rq);
 
-	if (local_read(&rq->scx.reenq_local_deferred)) {
-		local_set(&rq->scx.reenq_local_deferred, 0);
-		reenq_local(rq);
+	if (!llist_empty(&rq->scx.deferred_reenq_locals)) {
+		struct llist_node *llist =
+			llist_del_all(&rq->scx.deferred_reenq_locals);
+		struct scx_sched_pcpu *pos, *next;
+
+		llist_for_each_entry_safe(pos, next, llist,
+					  deferred_reenq_locals_node) {
+			init_llist_node(&pos->deferred_reenq_locals_node);
+			reenq_local(pos->sch, rq);
+		}
 	}
 }
 
@@ -4082,7 +4089,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	struct scx_sched *sch = container_of(rcu_work, struct scx_sched, rcu_work);
 	struct rhashtable_iter rht_iter;
 	struct scx_dispatch_q *dsq;
-	int node;
+	int cpu, node;
 
 	irq_work_sync(&sch->error_irq_work);
 	kthread_destroy_worker(sch->helper);
@@ -4094,6 +4101,17 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		cgroup_put(sch_cgroup(sch));
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
+	/*
+	 * $sch would have entered bypass mode before the RCU grace period. As
+	 * that blocks new deferrals, all deferred_reenq_locals_node's must be
+	 * off-list by now.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
+		WARN_ON_ONCE(llist_on_list(&pcpu->deferred_reenq_locals_node));
+	}
+
 	free_percpu(sch->pcpu);
 
 	for_each_node_state(node, N_POSSIBLE)
@@ -5655,8 +5673,12 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	for_each_possible_cpu(cpu)
 		init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
 
-	for_each_possible_cpu(cpu)
-		per_cpu_ptr(sch->pcpu, cpu)->sch = sch;
+	for_each_possible_cpu(cpu) {
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
+		pcpu->sch = sch;
+		init_llist_node(&pcpu->deferred_reenq_locals_node);
+	}
 
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
 	if (IS_ERR(sch->helper)) {
@@ -6955,6 +6977,7 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
+		init_llist_head(&rq->scx.deferred_reenq_locals);
 		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
 		rq->scx.kick_cpus_irq_work = IRQ_WORK_INIT_HARD(kick_cpus_irq_workfn);
 
@@ -7526,7 +7549,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
 	.set			= &scx_kfunc_ids_dispatch,
 };
 
-static u32 reenq_local(struct rq *rq)
+static u32 reenq_local(struct scx_sched *sch, struct rq *rq)
 {
 	LIST_HEAD(tasks);
 	u32 nr_enqueued = 0;
@@ -7541,6 +7564,8 @@ static u32 reenq_local(struct rq *rq)
 	 */
 	list_for_each_entry_safe(p, n, &rq->scx.local_dsq.list,
 				 scx.dsq_list.node) {
+		struct scx_sched *task_sch = scx_task_sched(p);
+
 		/*
 		 * If @p is being migrated, @p's current CPU may not agree with
 		 * its allowed CPUs and the migration_cpu_stop is about to
@@ -7555,6 +7580,9 @@ static u32 reenq_local(struct rq *rq)
 		if (p->migration_pending)
 			continue;
 
+		if (!scx_is_descendant(task_sch, sch))
+			continue;
+
 		dispatch_dequeue(rq, p);
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
@@ -7597,7 +7625,7 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux)
 	rq = cpu_rq(smp_processor_id());
 	lockdep_assert_rq_held(rq);
 
-	return reenq_local(rq);
+	return reenq_local(sch, rq);
 }
 
 __bpf_kfunc_end_defs();
@@ -8168,20 +8196,39 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 
 /**
  * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Iterate over all of the tasks currently enqueued on the local DSQ of the
  * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called from
  * anywhere.
  */
-__bpf_kfunc void scx_bpf_reenqueue_local___v2(void)
+__bpf_kfunc void scx_bpf_reenqueue_local___v2(const struct bpf_prog_aux *aux)
 {
+	unsigned long flags;
+	struct scx_sched *sch;
 	struct rq *rq;
+	struct llist_node *lnode;
 
-	guard(preempt)();
+	raw_local_irq_save(flags);
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		goto out_irq_restore;
+
+	/*
+	 * Allowing reenqueue-locals doesn't make sense while bypassing. This
+	 * also blocks from new reenqueues to be scheduled on dead scheds.
+	 */
+	if (unlikely(sch->bypass_depth))
+		goto out_irq_restore;
 
 	rq = this_rq();
-	local_set(&rq->scx.reenq_local_deferred, 1);
+	lnode = &this_cpu_ptr(sch->pcpu)->deferred_reenq_locals_node;
+	if (!llist_on_list(lnode))
+		llist_add(lnode, &rq->scx.deferred_reenq_locals);
 	schedule_deferred(rq);
+out_irq_restore:
+	raw_local_irq_restore(flags);
 }
 
 /**
@@ -8606,7 +8653,7 @@ BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2)
+BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_set, KF_IMPLICIT_ARGS)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 9029fa4695c0..b94b615f8d94 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -965,6 +965,7 @@ struct scx_sched_pcpu {
 	 */
 	struct scx_event_stats	event_stats;
 
+	struct llist_node	deferred_reenq_locals_node;
 	struct scx_dispatch_q	bypass_dsq;
 #ifdef CONFIG_EXT_SUB_SCHED
 	u32			bypass_host_seq;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 596f6713cf7e..7f3b07872e15 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -805,7 +805,7 @@ struct scx_rq {
 	cpumask_var_t		cpus_to_preempt;
 	cpumask_var_t		cpus_to_wait;
 	unsigned long		kick_sync;
-	local_t			reenq_local_deferred;
+	struct llist_head	deferred_reenq_locals;
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
-- 
2.53.0

