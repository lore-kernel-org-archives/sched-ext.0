Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B842DFFA;
	Fri,  6 Mar 2026 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823997; cv=none; b=g/CzB2MhHI4OvDVLJOXKOz30NhEyaYbUTP45FUAIT4kt8/LAX2ygLKjB+qWue9eNceJKMLCxxF8apGcffI+ngIQJ0a0Uu0KD4WkP01odewbbApdPfOb6ghHE9ZpzyZCX3rjQeJm4EllzAjwry7rngY3J2qmH0d+oXWPEqdoYY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823997; c=relaxed/simple;
	bh=0bM1YJBwD3lzENdzzH2mnTPMbrn9q4hl71UuxEnFNPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8mcClxiVK4dhrcIsid6dvup8re3rdIyq0/3o9PTyKsZst72Ow+SU5eGQCJ0WD2ujQV10yR9uufr2SRNa5w/2cNfg5vj/+TrprVZ8ri4jiccpqJN7xqAcI035x1TSYDkiTkmptqes9R4UjEqP5lOD8Pt3aYBhIxLmoXaJ5M5+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcBsysR+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcBsysR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0387CC2BCB0;
	Fri,  6 Mar 2026 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823997;
	bh=0bM1YJBwD3lzENdzzH2mnTPMbrn9q4hl71UuxEnFNPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcBsysR+e2BTfFJc2wgw5WoIgB6sdCTcnARprdojyIGbDF2LQL57piL+X/IddIcs1
	 Ysk1Vnxw1w4SX/x+xL9Rps902wji0HOKkHYjEz24uD0Ot3snZMGKNL5Cy7LlUzScnf
	 9COnpRSU3TfJSrUdBlBZ+lRuj5ZeAbslZy2pDZZoWC3T4/2gupQtztGrlPqre5NETr
	 fbj75TzhKBDB6rZ1gMMVSCEE3K7H9RS+0myZCyeDNOS7GkD+y9ldWVDBE73DdgtJFz
	 +VXTJY3O0vKgZ+Dir96Nzjt+mv2SKdGj7cJcR4k9Ya0pJNa+DkOiQ8loaCUuv9jXUM
	 ZZ1Y+aLQx8Q7A==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/15] sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs
Date: Fri,  6 Mar 2026 09:06:20 -1000
Message-ID: <20260306190623.1076074-13-tj@kernel.org>
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

scx_bpf_dsq_reenq() currently only supports local DSQs. Extend it to support
user-defined DSQs by adding a deferred re-enqueue mechanism similar to the
local DSQ handling.

Add per-cpu deferred_reenq_user_node/flags to scx_dsq_pcpu and
deferred_reenq_users list to scx_rq. When scx_bpf_dsq_reenq() is called on a
user DSQ, the DSQ's per-cpu node is added to the current rq's deferred list.
process_deferred_reenq_users() then iterates the DSQ using the cursor helpers
and re-enqueues each task.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h      |   6 ++
 kernel/sched/ext.c             | 128 +++++++++++++++++++++++++++++++++
 kernel/sched/sched.h           |   1 +
 tools/sched_ext/scx_qmap.bpf.c |  57 ++++++++++++++-
 4 files changed, 190 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 303f57dfb947..e77504faa0bc 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -62,8 +62,14 @@ enum scx_dsq_id_flags {
 	SCX_DSQ_LOCAL_CPU_MASK	= 0xffffffffLLU,
 };
 
+struct scx_deferred_reenq_user {
+	struct list_head	node;
+	u64			flags;
+};
+
 struct scx_dsq_pcpu {
 	struct scx_dispatch_q	*dsq;
+	struct scx_deferred_reenq_user deferred_reenq_user;
 };
 
 /*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6e4f84d3c407..f58afbc69cb4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1180,6 +1180,18 @@ static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 			drl->flags |= reenq_flags;
 		}
 
+		schedule_deferred(rq);
+	} else if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN)) {
+		struct rq *rq = this_rq();
+		struct scx_dsq_pcpu *dsq_pcpu = per_cpu_ptr(dsq->pcpu, cpu_of(rq));
+		struct scx_deferred_reenq_user *dru = &dsq_pcpu->deferred_reenq_user;
+
+		scoped_guard (raw_spinlock_irqsave, &rq->scx.deferred_reenq_lock) {
+			if (list_empty(&dru->node))
+				list_move_tail(&dru->node, &rq->scx.deferred_reenq_users);
+			dru->flags |= reenq_flags;
+		}
+
 		schedule_deferred(rq);
 	} else {
 		scx_error(sch, "DSQ 0x%llx not allowed for reenq", dsq->id);
@@ -3785,12 +3797,108 @@ static void process_deferred_reenq_locals(struct rq *rq)
 	}
 }
 
+static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flags)
+{
+	struct rq *locked_rq = rq;
+	struct scx_sched *sch = dsq->sched;
+	struct scx_dsq_list_node cursor = INIT_DSQ_LIST_CURSOR(cursor, dsq, 0);
+	struct task_struct *p;
+	s32 nr_enqueued = 0;
+
+	lockdep_assert_rq_held(rq);
+
+	raw_spin_lock(&dsq->lock);
+
+	while (likely(!READ_ONCE(sch->bypass_depth))) {
+		struct rq *task_rq;
+
+		p = nldsq_cursor_next_task(&cursor, dsq);
+		if (!p)
+			break;
+
+		if (!task_should_reenq(p, reenq_flags))
+			continue;
+
+		task_rq = task_rq(p);
+
+		if (locked_rq != task_rq) {
+			if (locked_rq)
+				raw_spin_rq_unlock(locked_rq);
+			if (unlikely(!raw_spin_rq_trylock(task_rq))) {
+				raw_spin_unlock(&dsq->lock);
+				raw_spin_rq_lock(task_rq);
+				raw_spin_lock(&dsq->lock);
+			}
+			locked_rq = task_rq;
+
+			/* did we lose @p while switching locks? */
+			if (nldsq_cursor_lost_task(&cursor, task_rq, dsq, p))
+				continue;
+		}
+
+		/* @p is on @dsq, its rq and @dsq are locked */
+		dispatch_dequeue_locked(p, dsq);
+		raw_spin_unlock(&dsq->lock);
+		do_enqueue_task(task_rq, p, SCX_ENQ_REENQ, -1);
+
+		if (!(++nr_enqueued % SCX_TASK_ITER_BATCH)) {
+			raw_spin_rq_unlock(locked_rq);
+			locked_rq = NULL;
+			cpu_relax();
+		}
+
+		raw_spin_lock(&dsq->lock);
+	}
+
+	list_del_init(&cursor.node);
+	raw_spin_unlock(&dsq->lock);
+
+	if (locked_rq != rq) {
+		if (locked_rq)
+			raw_spin_rq_unlock(locked_rq);
+		raw_spin_rq_lock(rq);
+	}
+}
+
+static void process_deferred_reenq_users(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+
+	while (true) {
+		struct scx_dispatch_q *dsq;
+		u64 reenq_flags = 0;
+
+		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
+			struct scx_deferred_reenq_user *dru =
+				list_first_entry_or_null(&rq->scx.deferred_reenq_users,
+							 struct scx_deferred_reenq_user,
+							 node);
+			struct scx_dsq_pcpu *dsq_pcpu;
+
+			if (!dru)
+				return;
+
+			dsq_pcpu = container_of(dru, struct scx_dsq_pcpu,
+						deferred_reenq_user);
+			dsq = dsq_pcpu->dsq;
+			swap(dru->flags, reenq_flags);
+			list_del_init(&dru->node);
+		}
+
+		BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);
+		reenq_user(rq, dsq, reenq_flags);
+	}
+}
+
 static void run_deferred(struct rq *rq)
 {
 	process_ddsp_deferred_locals(rq);
 
 	if (!list_empty(&rq->scx.deferred_reenq_locals))
 		process_deferred_reenq_locals(rq);
+
+	if (!list_empty(&rq->scx.deferred_reenq_users))
+		process_deferred_reenq_users(rq);
 }
 
 #ifdef CONFIG_NO_HZ_FULL
@@ -4120,6 +4228,7 @@ static s32 init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id,
 		struct scx_dsq_pcpu *pcpu = per_cpu_ptr(dsq->pcpu, cpu);
 
 		pcpu->dsq = dsq;
+		INIT_LIST_HEAD(&pcpu->deferred_reenq_user.node);
 	}
 
 	return 0;
@@ -4127,6 +4236,23 @@ static s32 init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id,
 
 static void exit_dsq(struct scx_dispatch_q *dsq)
 {
+	s32 cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct scx_dsq_pcpu *pcpu = per_cpu_ptr(dsq->pcpu, cpu);
+		struct scx_deferred_reenq_user *dru = &pcpu->deferred_reenq_user;
+		struct rq *rq = cpu_rq(cpu);
+
+		/*
+		 * There must have been a RCU grace period since the last
+		 * insertion and @dsq should be off the deferred list by now.
+		 */
+		if (WARN_ON_ONCE(!list_empty(&dru->node))) {
+			guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
+			list_del_init(&dru->node);
+		}
+	}
+
 	free_percpu(dsq->pcpu);
 }
 
@@ -7306,6 +7432,7 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
 		raw_spin_lock_init(&rq->scx.deferred_reenq_lock);
 		INIT_LIST_HEAD(&rq->scx.deferred_reenq_locals);
+		INIT_LIST_HEAD(&rq->scx.deferred_reenq_users);
 		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
 		rq->scx.kick_cpus_irq_work = IRQ_WORK_INIT_HARD(kick_cpus_irq_workfn);
 
@@ -8352,6 +8479,7 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id,
  * supported:
  *
  * - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON | $cpu)
+ * - User DSQs
  *
  * Re-enqueues are performed asynchronously. Can be called from anywhere.
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0794852524e7..893f89ce2a77 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -810,6 +810,7 @@ struct scx_rq {
 
 	raw_spinlock_t		deferred_reenq_lock;
 	struct list_head	deferred_reenq_locals;	/* scheds requesting reenq of local DSQ */
+	struct list_head	deferred_reenq_users;	/* user DSQs requesting reenq */
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 83e8289e8c0c..a4a1b84fe359 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -26,8 +26,11 @@
 
 enum consts {
 	ONE_SEC_IN_NS		= 1000000000,
+	ONE_MSEC_IN_NS		= 1000000,
+	LOWPRI_INTV_NS		= 10 * ONE_MSEC_IN_NS,
 	SHARED_DSQ		= 0,
 	HIGHPRI_DSQ		= 1,
+	LOWPRI_DSQ		= 2,
 	HIGHPRI_WEIGHT		= 8668,		/* this is what -20 maps to */
 };
 
@@ -172,6 +175,9 @@ s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 	if (!(tctx = lookup_task_ctx(p)))
 		return -ESRCH;
 
+	if (p->scx.weight < 2 && !(p->flags & PF_KTHREAD))
+		return prev_cpu;
+
 	cpu = pick_direct_dispatch_cpu(p, prev_cpu);
 
 	if (cpu >= 0) {
@@ -242,6 +248,13 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
+	/* see lowpri_timerfn() */
+	if (__COMPAT_has_generic_reenq() &&
+	    p->scx.weight < 2 && !(p->flags & PF_KTHREAD) && !(enq_flags & SCX_ENQ_REENQ)) {
+		scx_bpf_dsq_insert(p, LOWPRI_DSQ, slice_ns, enq_flags);
+		return;
+	}
+
 	/* if select_cpu() wasn't called, try direct dispatch */
 	if (!__COMPAT_is_enq_cpu_selected(enq_flags) &&
 	    (cpu = pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p))) >= 0) {
@@ -873,6 +886,28 @@ static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 	return 0;
 }
 
+struct lowpri_timer {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct lowpri_timer);
+} lowpri_timer SEC(".maps");
+
+/*
+ * Nice 19 tasks are put into the lowpri DSQ. Every 10ms, reenq is triggered and
+ * the tasks are transferred to SHARED_DSQ.
+ */
+static int lowpri_timerfn(void *map, int *key, struct bpf_timer *timer)
+{
+	scx_bpf_dsq_reenq(LOWPRI_DSQ, 0);
+	bpf_timer_start(timer, LOWPRI_INTV_NS, 0);
+	return 0;
+}
+
 s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 {
 	u32 key = 0;
@@ -894,14 +929,32 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 		return ret;
 	}
 
+	ret = scx_bpf_create_dsq(LOWPRI_DSQ, -1);
+	if (ret)
+		return ret;
+
 	timer = bpf_map_lookup_elem(&monitor_timer, &key);
 	if (!timer)
 		return -ESRCH;
-
 	bpf_timer_init(timer, &monitor_timer, CLOCK_MONOTONIC);
 	bpf_timer_set_callback(timer, monitor_timerfn);
+	ret = bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
+	if (ret)
+		return ret;
 
-	return bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
+	if (__COMPAT_has_generic_reenq()) {
+		/* see lowpri_timerfn() */
+		timer = bpf_map_lookup_elem(&lowpri_timer, &key);
+		if (!timer)
+			return -ESRCH;
+		bpf_timer_init(timer, &lowpri_timer, CLOCK_MONOTONIC);
+		bpf_timer_set_callback(timer, lowpri_timerfn);
+		ret = bpf_timer_start(timer, LOWPRI_INTV_NS, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
-- 
2.53.0

