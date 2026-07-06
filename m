Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B553937C936;
	Mon,  6 Jul 2026 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302073; cv=none; b=qEjPl+hf6ovuWk+GMNo0arLx1Vbfwo7XhT/hsN1KL34tZaf7ChoDHv/a2VI1bnHk9odwbCCbKYRpjSZkdZYs3rmK/jMsSH+U3NryOsrdkverrtZPsJqeHvhKj9tK4r1HReNv1FRl90I78JL9Q7UNQTxUGkW2mSKJsLBRjWTRcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302073; c=relaxed/simple;
	bh=wIQOzrrFOxez2bmTX+olDwkHYR+iWKhdRFaAGUMS0JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEmj9tFVMqRVh1zh3yov99ILq5TkBv7XU3u7xlemR57lYg+F8ohwzeroRD2YmrpJdLLG2zFbsEErJHk5vN2eKQD3m6iMe1ojlQqjVJ9Xo8GOEE+zKPOi0W/+P6b32E8GDvrdkyAOEhgbYMSbxlwzlQmokCeoOG3sDa6+JGf28D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6AOVC3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6AOVC3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7271A1F000E9;
	Mon,  6 Jul 2026 01:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302068;
	bh=jVhXxLQS9qxy8Nz/vACRAfL6oIOqjrZDoawVUZ20BgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j6AOVC3I9AGRifyXUqN7fkqQghgrCBMIK/fFc5fCMbWd9eTZyZZkg8dUfZfyX8Mkd
	 +7BjhtNmGerstt4MJ7MhJyzdI3CBD4M7SmENUyQuzx8yzRZQhTeu6mnwDRGJhm/JaS
	 Vri9Ow21Lo3gB/t4sznw5c1zFLfE4N1mvxGGJt6aI1K6dTAvwSI2Hve58sA30nT8ZY
	 2nvZ+nx7lu8nreclLtYGWYFssKxL+JI4tN+Up+K3B6GOCggqZjOm0TcZog+cZ7XstL
	 fCezugV852rvEZoocBDdFpuxyYEWKUvXHViN7P+c0z5L2KScE69H1m6xNehZThQIav
	 mbaLH3HtTRXFQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 09/36] sched_ext: Make the kick machinery per-sched
Date: Sun,  5 Jul 2026 15:40:31 -1000
Message-ID: <20260706014058.439853-10-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kick machinery kept its targets in rq->scx shared by every sched on the
cpu. A preempt kick carried no record of which scheduler requested it.

A later patch needs preempt kicks scoped to the requesting scheduler so a
sub-scheduler can preempt only tasks in its own subtree. Move the kick masks
into the per-sched per-cpu scx_sched_pcpu and have scx_kick_cpu() link the
sched onto a per-cpu list (rq->scx.sched_pcpus_to_kick). The cpu's single
kick irq_work walks that list and kicks each sched's targets on its behalf,
so a kick stays attributed to its scheduler.

The SCX_KICK_WAIT sync set (cpus_to_sync, the kick_sync snapshot and the
balance-callback trigger) stays in rq->scx: the waiter is the cpu, not the
scheduler, and its only writers, the kick irq_work and the wait balance
callback, are cpu-local.

v2: Warn once per sched on scx_bpf_kick_cpu() from NMI.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 119 ++++++++++++++++++++++++++----------
 kernel/sched/ext/internal.h |  14 +++++
 kernel/sched/sched.h        |   6 +-
 3 files changed, 104 insertions(+), 35 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 187754d0c3c8..150e74129266 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4624,6 +4624,17 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		 */
 		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
 
+		/*
+		 * Bypass blocks new kicks. Flush the kick irq_work so this
+		 * pcpu's to_kick_node is off the list before it is freed.
+		 */
+		irq_work_sync(&cpu_rq(cpu)->scx.kick_cpus_irq_work);
+		WARN_ON_ONCE(!list_empty(&pcpu->to_kick_node));
+		free_cpumask_var(pcpu->cpus_to_kick);
+		free_cpumask_var(pcpu->cpus_to_kick_if_idle);
+		free_cpumask_var(pcpu->cpus_to_preempt);
+		free_cpumask_var(pcpu->cpus_to_wait);
+
 		exit_dsq(scx_bypass_dsq(sch, cpu));
 	}
 
@@ -5967,6 +5978,7 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 			 bool dump_all_tasks)
 {
 	struct rq *rq = cpu_rq(cpu);
+	struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 	struct rq_flags rf;
 	struct task_struct *p;
 	struct seq_buf ns;
@@ -5999,18 +6011,18 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	dump_line(&ns, "          curr=%s[%d] class=%ps",
 		  rq->curr->comm, rq->curr->pid,
 		  rq->curr->sched_class);
-	if (!cpumask_empty(rq->scx.cpus_to_kick))
+	if (!cpumask_empty(pcpu->cpus_to_kick))
 		dump_line(&ns, "  cpus_to_kick   : %*pb",
-			  cpumask_pr_args(rq->scx.cpus_to_kick));
-	if (!cpumask_empty(rq->scx.cpus_to_kick_if_idle))
+			  cpumask_pr_args(pcpu->cpus_to_kick));
+	if (!cpumask_empty(pcpu->cpus_to_kick_if_idle))
 		dump_line(&ns, "  idle_to_kick   : %*pb",
-			  cpumask_pr_args(rq->scx.cpus_to_kick_if_idle));
-	if (!cpumask_empty(rq->scx.cpus_to_preempt))
+			  cpumask_pr_args(pcpu->cpus_to_kick_if_idle));
+	if (!cpumask_empty(pcpu->cpus_to_preempt))
 		dump_line(&ns, "  cpus_to_preempt: %*pb",
-			  cpumask_pr_args(rq->scx.cpus_to_preempt));
-	if (!cpumask_empty(rq->scx.cpus_to_wait))
+			  cpumask_pr_args(pcpu->cpus_to_preempt));
+	if (!cpumask_empty(pcpu->cpus_to_wait))
 		dump_line(&ns, "  cpus_to_wait   : %*pb",
-			  cpumask_pr_args(rq->scx.cpus_to_wait));
+			  cpumask_pr_args(pcpu->cpus_to_wait));
 	if (!cpumask_empty(rq->scx.cpus_to_sync))
 		dump_line(&ns, "  cpus_to_sync   : %*pb",
 			  cpumask_pr_args(rq->scx.cpus_to_sync));
@@ -6302,8 +6314,17 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 	for_each_possible_cpu(cpu) {
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
+		node = cpu_to_node(cpu);
 		pcpu->sch = sch;
 		INIT_LIST_HEAD(&pcpu->deferred_reenq_local.node);
+		INIT_LIST_HEAD(&pcpu->to_kick_node);
+		if (!zalloc_cpumask_var_node(&pcpu->cpus_to_kick, GFP_KERNEL, node) ||
+		    !zalloc_cpumask_var_node(&pcpu->cpus_to_kick_if_idle, GFP_KERNEL, node) ||
+		    !zalloc_cpumask_var_node(&pcpu->cpus_to_preempt, GFP_KERNEL, node) ||
+		    !zalloc_cpumask_var_node(&pcpu->cpus_to_wait, GFP_KERNEL, node)) {
+			ret = -ENOMEM;
+			goto err_free_pcpu;
+		}
 	}
 
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
@@ -6448,6 +6469,14 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 err_stop_helper:
 	kthread_destroy_worker(sch->helper);
 err_free_pcpu:
+	for_each_possible_cpu(cpu) {
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
+		free_cpumask_var(pcpu->cpus_to_kick);
+		free_cpumask_var(pcpu->cpus_to_kick_if_idle);
+		free_cpumask_var(pcpu->cpus_to_preempt);
+		free_cpumask_var(pcpu->cpus_to_wait);
+	}
 	for_each_possible_cpu(cpu) {
 		if (cpu == bypass_fail_cpu)
 			break;
@@ -7461,7 +7490,8 @@ static bool can_skip_idle_kick(struct rq *rq)
 	return !is_idle_task(rq->curr) && !(rq->scx.flags & SCX_RQ_IN_BALANCE);
 }
 
-static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
+static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_rq,
+			 unsigned long *ksyncs)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct scx_rq *this_scx = &this_rq->scx;
@@ -7480,25 +7510,25 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 	 */
 	if ((cpu_online(cpu) || cpu == cpu_of(this_rq)) &&
 	    !sched_class_above(cur_class, &ext_sched_class)) {
-		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
+		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class)
 				rq->curr->scx.slice = 0;
-			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
+			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
 		}
 
-		if (cpumask_test_cpu(cpu, this_scx->cpus_to_wait)) {
+		if (cpumask_test_cpu(cpu, pcpu->cpus_to_wait)) {
 			if (cur_class == &ext_sched_class) {
 				cpumask_set_cpu(cpu, this_scx->cpus_to_sync);
 				ksyncs[cpu] = rq->scx.kick_sync;
 				should_wait = true;
 			}
-			cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
+			cpumask_clear_cpu(cpu, pcpu->cpus_to_wait);
 		}
 
 		resched_curr(rq);
 	} else {
-		cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
-		cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
+		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
+		cpumask_clear_cpu(cpu, pcpu->cpus_to_wait);
 	}
 
 	raw_spin_rq_unlock_irqrestore(rq, flags);
@@ -7525,6 +7555,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 	struct rq *this_rq = this_rq();
 	struct scx_rq *this_scx = &this_rq->scx;
 	struct scx_kick_syncs __rcu *ksyncs_pcpu = __this_cpu_read(scx_kick_syncs);
+	struct scx_sched_pcpu *pcpu, *tmp;
 	bool should_wait = false;
 	unsigned long *ksyncs;
 	s32 cpu;
@@ -7535,15 +7566,24 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 
 	ksyncs = rcu_dereference_bh(ksyncs_pcpu)->syncs;
 
-	for_each_cpu(cpu, this_scx->cpus_to_kick) {
-		should_wait |= kick_one_cpu(cpu, this_rq, ksyncs);
-		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick);
-		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick_if_idle);
-	}
+	/*
+	 * Walk scheds with pending kicks on this cpu. scx_kick_cpu() adds to
+	 * the list under local_irq_save() and only this irq_work consumes it.
+	 * A plain list without locking is sufficient.
+	 */
+	list_for_each_entry_safe(pcpu, tmp, &this_scx->sched_pcpus_to_kick, to_kick_node) {
+		list_del_init(&pcpu->to_kick_node);
+
+		for_each_cpu(cpu, pcpu->cpus_to_kick) {
+			should_wait |= kick_one_cpu(cpu, pcpu, this_rq, ksyncs);
+			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick);
+			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
+		}
 
-	for_each_cpu(cpu, this_scx->cpus_to_kick_if_idle) {
-		kick_one_cpu_if_idle(cpu, this_rq);
-		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick_if_idle);
+		for_each_cpu(cpu, pcpu->cpus_to_kick_if_idle) {
+			kick_one_cpu_if_idle(cpu, this_rq);
+			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
+		}
 	}
 
 	/*
@@ -7668,11 +7708,8 @@ void __init init_sched_ext_class(void)
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
 
-		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick, GFP_KERNEL, n));
-		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL, n));
-		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, n));
-		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_sync, GFP_KERNEL, n));
+		INIT_LIST_HEAD(&rq->scx.sched_pcpus_to_kick);
 		raw_spin_lock_init(&rq->scx.deferred_reenq_lock);
 		INIT_LIST_HEAD(&rq->scx.deferred_reenq_locals);
 		INIT_LIST_HEAD(&rq->scx.deferred_reenq_users);
@@ -8458,12 +8495,27 @@ __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
 
 void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 {
+	struct scx_sched_pcpu *pcpu;
 	struct rq *this_rq;
 	unsigned long irq_flags;
 
+	/*
+	 * The per-cpu kick list is guarded only by local_irq_save(), which does
+	 * not mask NMIs, so kicking from NMI could corrupt it and is unsupported.
+	 */
+	if (unlikely(in_nmi())) {
+		if (!sch->warned_nmi_kick) {
+			sch->warned_nmi_kick = true;
+			pr_warn("sched_ext: %s: scx_bpf_kick_cpu() from NMI ignored\n",
+				sch->ops.name);
+		}
+		return;
+	}
+
 	local_irq_save(irq_flags);
 
 	this_rq = this_rq();
+	pcpu = this_cpu_ptr(sch->pcpu);
 
 	/*
 	 * While bypassing for PM ops, IRQ handling may not be online which can
@@ -8477,6 +8529,9 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	 * Actual kicking is bounced to kick_cpus_irq_workfn() to avoid nesting
 	 * rq locks. We can probably be smarter and avoid bouncing if called
 	 * from ops which don't hold a rq lock.
+	 *
+	 * The kick masks are owned by @sch->pcpu, so that a preempt kick can be
+	 * attributed to @sch.
 	 */
 	if (flags & SCX_KICK_IDLE) {
 		struct rq *target_rq = cpu_rq(cpu);
@@ -8491,16 +8546,18 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 			}
 			raw_spin_rq_unlock(target_rq);
 		}
-		cpumask_set_cpu(cpu, this_rq->scx.cpus_to_kick_if_idle);
+		cpumask_set_cpu(cpu, pcpu->cpus_to_kick_if_idle);
 	} else {
-		cpumask_set_cpu(cpu, this_rq->scx.cpus_to_kick);
+		cpumask_set_cpu(cpu, pcpu->cpus_to_kick);
 
 		if (flags & SCX_KICK_PREEMPT)
-			cpumask_set_cpu(cpu, this_rq->scx.cpus_to_preempt);
+			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt);
 		if (flags & SCX_KICK_WAIT)
-			cpumask_set_cpu(cpu, this_rq->scx.cpus_to_wait);
+			cpumask_set_cpu(cpu, pcpu->cpus_to_wait);
 	}
 
+	if (list_empty(&pcpu->to_kick_node))
+		list_add_tail(&pcpu->to_kick_node, &this_rq->scx.sched_pcpus_to_kick);
 	irq_work_queue(&this_rq->scx.kick_cpus_irq_work);
 out:
 	local_irq_restore(irq_flags);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 5ca44ad88786..1da4c3fa1347 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1126,6 +1126,19 @@ struct scx_sched_pcpu {
 	struct scx_sched	*sch;
 	u64			flags;	/* protected by rq lock */
 
+	/*
+	 * Kick state owned by this cpu for this sched. scx_kick_cpu() records
+	 * targets here and links @to_kick_node onto the cpu's
+	 * rq->scx.sched_pcpus_to_kick. The cpu's single kick irq_work walks
+	 * that list and kicks each sched's targets on its behalf. Per-sched so
+	 * a kick stays attributed to its scheduler.
+	 */
+	cpumask_var_t		cpus_to_kick;
+	cpumask_var_t		cpus_to_kick_if_idle;
+	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_wait;
+	struct list_head	to_kick_node;
+
 	/*
 	 * The event counters are in a per-CPU variable to minimize the
 	 * accounting overhead. A system-wide view on the event counter is
@@ -1215,6 +1228,7 @@ struct scx_sched {
 	 */
 	bool			warned_zero_slice:1;
 	bool			warned_unassoc_progs:1;
+	bool			warned_nmi_kick:1;
 
 	struct list_head	all;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 80b72d934ff3..9e41a23ef49e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -806,14 +806,12 @@ struct scx_rq {
 	u32			flags;
 	u32			nr_immed;		/* ENQ_IMMED tasks on local_dsq */
 	u64			clock;			/* current per-rq clock -- see scx_bpf_now() */
-	cpumask_var_t		cpus_to_kick;
-	cpumask_var_t		cpus_to_kick_if_idle;
-	cpumask_var_t		cpus_to_preempt;
-	cpumask_var_t		cpus_to_wait;
 	cpumask_var_t		cpus_to_sync;
 	bool			kick_sync_pending;
 	unsigned long		kick_sync;
 
+	struct list_head	sched_pcpus_to_kick;	/* see kick_cpus_irq_workfn() */
+
 	struct task_struct	*sub_dispatch_prev;
 
 	raw_spinlock_t		deferred_reenq_lock;
-- 
2.54.0

