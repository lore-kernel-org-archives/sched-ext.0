Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37167142E83;
	Sun, 19 Apr 2026 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776623807; cv=none; b=TkcA3DcX3FjHJMPbj2WtUtyx6h7BPoL0IvEIP0dMQ+IA5Ib89YjToegmcciy9vxq2ZYI1wn1Hn8TfyVOcAlj3FTkasdIm1klyV6DiOyoqOp6XsDvHEPW/qSYbTuUPkkUpmqZS6XhMhw+uBw4ELcuZT+HJ9dhXE8/KXR80WgKsF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776623807; c=relaxed/simple;
	bh=vdv15msqQ5d3fHSKHuyXpmd9tfJSjdDCvNcXRUMve2Y=;
	h=Date:Message-ID:From:To:Cc:Subject; b=D/l8srs01bnNPI94h1/q3PjVd4fKmn8toiDEPt1tArL2pbcLSn2yG4qDOqzwBFjMmhAFWcVHoaw4Eh1XccaewHPlpHboaQ41o5rNj6dL+F5O9E9HV7tqe8KwdJa1nTtVz6jDqAfUbWovOSLthdpEYE93q8HBzZH9wUcYVhiXpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+H6Bvs9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+H6Bvs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DB6C2BCAF;
	Sun, 19 Apr 2026 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776623806;
	bh=vdv15msqQ5d3fHSKHuyXpmd9tfJSjdDCvNcXRUMve2Y=;
	h=Date:From:To:Cc:Subject:From;
	b=n+H6Bvs9J7qc/YHxdeAUHC32pPnFMrNAxG8ygYony2m74MFcaDrPCt3cpRiVCgAu2
	 1ANVr50FjMVjy5fQdgdbUgS89mvl+Quuu5x9xnwicF8DC3h4as+tuNMl/N2Yv9gMx+
	 Vunai/MECbzittjV96+tTnB4x1J9ZbB3SyvdqDZ++qKlb5rzxjFTtylwoYTvle8Ftq
	 hcAxhfuXonST0kVVduOmwCqVpo7EUpNa/2ycLFlWX71BNKbRoWpmi4605QK7eupDKl
	 0YlVUTAWQ9RL8O5EprQaDznbipuFWsONdbePCCEeVkdi6cndgSCKgLG9SFN2vZDYyD
	 iYuSM6XYsQmUQ==
Date: Sun, 19 Apr 2026 08:36:45 -1000
Message-ID: <c3069bb592d7d09790ca9ff6d9b7d3b2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: [PATCH v3 sched_ext/for-7.2] sched_ext: add p->scx.tid and
 SCX_OPS_TID_TO_TASK lookup
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

BPF schedulers that can't hold task_struct pointers (arena-backed ones in
particular) key tasks by pid. During exit, pid is released before the
task finishes passing through scheduler callbacks, so a dying task
becomes invisible to the BPF side mid-schedule. scx_qmap hits this: an
exiting task's dispatch callback can't recover its queue entry, stalling
dispatch until SCX_EXIT_ERROR_STALL.

Add a unique non-zero u64 p->scx.tid assigned at fork that survives the
full task lifetime including exit. scx_bpf_tid_to_task() looks up the
task; unlike bpf_task_from_pid(), it handles exiting tasks.

The lookup costs an rhashtable insert/remove under scx_tasks_lock, so
root schedulers opt in via SCX_OPS_TID_TO_TASK. Sub-schedulers that set
the flag to declare a dependency are rejected at attach if root didn't
opt in.

scx_qmap converted: keys tasks by tid and enables SCX_OPS_ENQ_EXITING.
Pre-patch it stalls within seconds under a non-leader-exec workload;
with the patch it runs cleanly.

v3: Warn on rhashtable_lookup_insert_fast() failure via new
    scx_tid_hash_insert() helper (Cheng-Yang Chou).

v2: Guard scx_root deref in scx_bpf_tid_to_task() error path. The kfunc
    is registered via scx_kfunc_set_any and reachable from tracing and
    syscall programs when no scheduler is attached (Cheng-Yang Chou).

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h                |    9 +
 kernel/sched/ext.c                       |  154 +++++++++++++++++++++++++++++--
 kernel/sched/ext_internal.h              |   20 +++-
 tools/sched_ext/include/scx/common.bpf.h |    1 
 tools/sched_ext/scx_qmap.bpf.c           |   13 +-
 5 files changed, 180 insertions(+), 17 deletions(-)

--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -203,6 +203,15 @@ struct sched_ext_entity {
 	u64			core_sched_at;	/* see scx_prio_less() */
 #endif
 
+	/*
+	 * Unique non-zero task ID assigned at fork. Persists across exec and
+	 * is never reused. Lets BPF schedulers identify tasks without storing
+	 * kernel pointers - arena-backed schedulers being one example. See
+	 * scx_bpf_tid_to_task().
+	 */
+	u64			tid;
+	struct rhash_head	tid_hash_node;	/* see SCX_OPS_TID_TO_TASK */
+
 	/* BPF scheduler modifiable fields */
 
 	/*
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -38,6 +38,15 @@ static const struct rhashtable_params sc
 static struct rhashtable scx_sched_hash;
 #endif
 
+/* see SCX_OPS_TID_TO_TASK */
+static const struct rhashtable_params scx_tid_hash_params = {
+	.key_len		= sizeof_field(struct sched_ext_entity, tid),
+	.key_offset		= offsetof(struct sched_ext_entity, tid),
+	.head_offset		= offsetof(struct sched_ext_entity, tid_hash_node),
+	.insecure_elasticity	= true,	/* inserted/removed under scx_tasks_lock */
+};
+static struct rhashtable scx_tid_hash;
+
 /*
  * During exit, a task may schedule after losing its PIDs. When disabling the
  * BPF scheduler, we need to be able to iterate tasks in every state to
@@ -58,10 +67,25 @@ static cpumask_var_t scx_bypass_lb_resch
 static bool scx_init_task_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
+static DEFINE_STATIC_KEY_FALSE(__scx_tid_to_task_enabled);
+
+/*
+ * True once SCX_OPS_TID_TO_TASK has been negotiated with the root scheduler
+ * and the tid->task table is live. Wraps the static key so callers don't
+ * take the address, and hints "likely enabled" for the common case where
+ * the feature is in use.
+ */
+static inline bool scx_tid_to_task_enabled(void)
+{
+	return static_branch_likely(&__scx_tid_to_task_enabled);
+}
 
 static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 
+/* Global cursor for the per-CPU tid allocator. Starts at 1; tid 0 is reserved. */
+static atomic64_t scx_tid_cursor = ATOMIC64_INIT(1);
+
 #ifdef CONFIG_EXT_SUB_SCHED
 /*
  * The sub sched being enabled. Used by scx_disable_and_exit_task() to exit
@@ -111,6 +135,17 @@ struct scx_kick_syncs {
 static DEFINE_PER_CPU(struct scx_kick_syncs __rcu *, scx_kick_syncs);
 
 /*
+ * Per-CPU buffered allocator state for p->scx.tid. Each CPU pulls a chunk of
+ * SCX_TID_CHUNK ids from scx_tid_cursor and hands them out locally without
+ * further synchronization. See scx_alloc_tid().
+ */
+struct scx_tid_alloc {
+	u64	next;
+	u64	end;
+};
+static DEFINE_PER_CPU(struct scx_tid_alloc, scx_tid_alloc);
+
+/*
  * Direct dispatch marker.
  *
  * Non-NULL values are used for direct dispatch from enqueue path. A valid
@@ -3665,6 +3700,33 @@ void init_scx_entity(struct sched_ext_en
 	scx->slice = SCX_SLICE_DFL;
 }
 
+/* See scx_tid_alloc / scx_tid_cursor. */
+static u64 scx_alloc_tid(void)
+{
+	struct scx_tid_alloc *ta;
+
+	guard(preempt)();
+	ta = this_cpu_ptr(&scx_tid_alloc);
+
+	if (unlikely(ta->next >= ta->end)) {
+		ta->next = atomic64_fetch_add(SCX_TID_CHUNK, &scx_tid_cursor);
+		ta->end = ta->next + SCX_TID_CHUNK;
+	}
+	return ta->next++;
+}
+
+static void scx_tid_hash_insert(struct task_struct *p)
+{
+	int ret;
+
+	lockdep_assert_held(&scx_tasks_lock);
+
+	ret = rhashtable_lookup_insert_fast(&scx_tid_hash,
+					    &p->scx.tid_hash_node,
+					    scx_tid_hash_params);
+	WARN_ON_ONCE(ret);
+}
+
 void scx_pre_fork(struct task_struct *p)
 {
 	/*
@@ -3682,6 +3744,8 @@ int scx_fork(struct task_struct *p, stru
 
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
+	p->scx.tid = scx_alloc_tid();
+
 	if (scx_init_task_enabled) {
 #ifdef CONFIG_EXT_SUB_SCHED
 		struct scx_sched *sch = kargs->cset->dfl_cgrp->scx_sched;
@@ -3717,9 +3781,11 @@ void scx_post_fork(struct task_struct *p
 		}
 	}
 
-	raw_spin_lock_irq(&scx_tasks_lock);
-	list_add_tail(&p->scx.tasks_node, &scx_tasks);
-	raw_spin_unlock_irq(&scx_tasks_lock);
+	scoped_guard(raw_spinlock_irq, &scx_tasks_lock) {
+		list_add_tail(&p->scx.tasks_node, &scx_tasks);
+		if (scx_tid_to_task_enabled())
+			scx_tid_hash_insert(p);
+	}
 
 	percpu_up_read(&scx_fork_rwsem);
 }
@@ -3770,17 +3836,19 @@ static bool task_dead_and_done(struct ta
 
 void sched_ext_dead(struct task_struct *p)
 {
-	unsigned long flags;
-
 	/*
 	 * By the time control reaches here, @p has %TASK_DEAD set, switched out
 	 * for the last time and then dropped the rq lock - task_dead_and_done()
 	 * should be returning %true nullifying the straggling sched_class ops.
 	 * Remove from scx_tasks and exit @p.
 	 */
-	raw_spin_lock_irqsave(&scx_tasks_lock, flags);
-	list_del_init(&p->scx.tasks_node);
-	raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &scx_tasks_lock) {
+		list_del_init(&p->scx.tasks_node);
+		if (scx_tid_to_task_enabled())
+			rhashtable_remove_fast(&scx_tid_hash,
+					       &p->scx.tid_hash_node,
+					       scx_tid_hash_params);
+	}
 
 	/*
 	 * @p is off scx_tasks and wholly ours. scx_root_enable()'s READY ->
@@ -5794,9 +5862,13 @@ static void scx_root_disable(struct scx_
 
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
 	static_branch_disable(&__scx_enabled);
+	if (sch->ops.flags & SCX_OPS_TID_TO_TASK)
+		static_branch_disable(&__scx_tid_to_task_enabled);
 	bitmap_zero(sch->has_op, SCX_OPI_END);
 	scx_idle_disable();
 	synchronize_rcu();
+	if (sch->ops.flags & SCX_OPS_TID_TO_TASK)
+		rhashtable_free_and_destroy(&scx_tid_hash, NULL, NULL);
 
 	if (ei->kind >= SCX_EXIT_ERROR) {
 		pr_err("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
@@ -6553,6 +6625,17 @@ static int validate_ops(struct scx_sched
 	}
 
 	/*
+	 * SCX_OPS_TID_TO_TASK is enabled by the root scheduler. A sub-sched
+	 * may set it to declare a dependency; reject if the root hasn't
+	 * enabled it.
+	 */
+	if ((ops->flags & SCX_OPS_TID_TO_TASK) && scx_parent(sch) &&
+	    !(scx_root->ops.flags & SCX_OPS_TID_TO_TASK)) {
+		scx_error(sch, "SCX_OPS_TID_TO_TASK requires root scheduler to enable it");
+		return -EINVAL;
+	}
+
+	/*
 	 * SCX_OPS_BUILTIN_IDLE_PER_NODE requires built-in CPU idle
 	 * selection policy to be enabled.
 	 */
@@ -6602,13 +6685,19 @@ static void scx_root_enable_workfn(struc
 	if (ret)
 		goto err_unlock;
 
+	if (ops->flags & SCX_OPS_TID_TO_TASK) {
+		ret = rhashtable_init(&scx_tid_hash, &scx_tid_hash_params);
+		if (ret)
+			goto err_free_ksyncs;
+	}
+
 #if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
 	cgroup_get(cgrp);
 #endif
 	sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
-		goto err_free_ksyncs;
+		goto err_free_tid_hash;
 	}
 
 	/*
@@ -6697,6 +6786,10 @@ static void scx_root_enable_workfn(struc
 	WARN_ON_ONCE(scx_init_task_enabled);
 	scx_init_task_enabled = true;
 
+	/* flip under fork_rwsem; the iter below covers existing tasks */
+	if (ops->flags & SCX_OPS_TID_TO_TASK)
+		static_branch_enable(&__scx_tid_to_task_enabled);
+
 	/*
 	 * Enable ops for every task. Fork is excluded by scx_fork_rwsem
 	 * preventing new tasks from being added. No need to exclude tasks
@@ -6740,6 +6833,17 @@ static void scx_root_enable_workfn(struc
 		scx_set_task_sched(p, sch);
 		scx_set_task_state(p, SCX_TASK_READY);
 
+		/*
+		 * Insert into the tid hash under scx_tasks_lock so we can't
+		 * race sched_ext_dead() and leave a stale entry for an already
+		 * exited task.
+		 */
+		if (scx_tid_to_task_enabled()) {
+			guard(raw_spinlock_irq)(&scx_tasks_lock);
+			if (!list_empty(&p->scx.tasks_node))
+				scx_tid_hash_insert(p);
+		}
+
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
@@ -6799,6 +6903,9 @@ static void scx_root_enable_workfn(struc
 	cmd->ret = 0;
 	return;
 
+err_free_tid_hash:
+	if (ops->flags & SCX_OPS_TID_TO_TASK)
+		rhashtable_free_and_destroy(&scx_tid_hash, NULL, NULL);
 err_free_ksyncs:
 	free_kick_syncs();
 err_unlock:
@@ -9288,6 +9395,34 @@ __bpf_kfunc struct task_struct *scx_bpf_
 }
 
 /**
+ * scx_bpf_tid_to_task - Look up a task by its scx tid
+ * @tid: task ID previously read from p->scx.tid
+ *
+ * Returns the task with the given tid, or NULL if no such task exists. The
+ * returned pointer is valid until the end of the current RCU read section
+ * (KF_RCU_PROTECTED). Requires SCX_OPS_TID_TO_TASK to be set on the root
+ * scheduler; otherwise an error is raised and NULL returned.
+ */
+__bpf_kfunc struct task_struct *scx_bpf_tid_to_task(u64 tid)
+{
+	struct sched_ext_entity *scx;
+
+	if (!scx_tid_to_task_enabled()) {
+		struct scx_sched *sch = rcu_dereference(scx_root);
+
+		if (sch)
+			scx_error(sch, "scx_bpf_tid_to_task() called without SCX_OPS_TID_TO_TASK");
+		return NULL;
+	}
+
+	scx = rhashtable_lookup(&scx_tid_hash, &tid, scx_tid_hash_params);
+	if (!scx)
+		return NULL;
+
+	return container_of(scx, struct task_struct, scx);
+}
+
+/**
  * scx_bpf_now - Returns a high-performance monotonically non-decreasing
  * clock for the current CPU. The clock returned is in nanoseconds.
  *
@@ -9470,6 +9605,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, scx_bpf_tid_to_task, KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_now)
 BTF_ID_FLAGS(func, scx_bpf_events)
 #ifdef CONFIG_CGROUP_SCHED
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -13,6 +13,9 @@ enum scx_consts {
 	SCX_DSP_MAX_LOOPS		= 32,
 	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
 
+	/* per-CPU chunk size for p->scx.tid allocation, see scx_alloc_tid() */
+	SCX_TID_CHUNK			= 1024,
+
 	SCX_EXIT_BT_LEN			= 64,
 	SCX_EXIT_MSG_LEN		= 1024,
 	SCX_EXIT_DUMP_DFL_LEN		= 32768,
@@ -138,7 +141,8 @@ enum scx_ops_flags {
 	 * To mask this problem, by default, unhashed tasks are automatically
 	 * dispatched to the local DSQ on enqueue. If the BPF scheduler doesn't
 	 * depend on pid lookups and wants to handle these tasks directly, the
-	 * following flag can be used.
+	 * following flag can be used. With %SCX_OPS_TID_TO_TASK,
+	 * scx_bpf_tid_to_task() can find exiting tasks reliably.
 	 */
 	SCX_OPS_ENQ_EXITING		= 1LLU << 2,
 
@@ -189,6 +193,17 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_ALWAYS_ENQ_IMMED	= 1LLU << 7,
 
+	/*
+	 * Maintain a mapping from p->scx.tid to task_struct so the BPF
+	 * scheduler can recover task pointers from stored tids via
+	 * scx_bpf_tid_to_task().
+	 *
+	 * Only the root scheduler turns this on. A sub-sched may set the flag
+	 * to declare a dependency on the lookup; if the root scheduler hasn't
+	 * enabled it, attaching the sub-sched is rejected.
+	 */
+	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -196,7 +211,8 @@ enum scx_ops_flags {
 					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
-					  SCX_OPS_ALWAYS_ENQ_IMMED,
+					  SCX_OPS_ALWAYS_ENQ_IMMED |
+					  SCX_OPS_TID_TO_TASK,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -99,6 +99,7 @@ s32 scx_bpf_task_cpu(const struct task_s
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct rq *scx_bpf_locked_rq(void) __ksym;
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
+struct task_struct *scx_bpf_tid_to_task(u64 tid) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
 
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -127,7 +127,8 @@ struct task_ctx {
 	struct task_ctx __arena	*q_next;	/* queue link, NULL if tail */
 	struct task_ctx __arena	*q_prev;	/* queue link, NULL if head */
 	struct qmap_fifo __arena *fifo;		/* queue we're on, NULL if not queued */
-	s32			pid;
+	u64			tid;
+	s32			pid;	/* for dump only */
 	bool			force_local;	/* Dispatch directly to local_dsq */
 	bool			highpri;
 	u64			core_sched_seq;
@@ -547,7 +548,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 c
 			if (!taskc)
 				break;
 
-			p = bpf_task_from_pid(taskc->pid);
+			p = scx_bpf_tid_to_task(taskc->tid);
 			if (!p)
 				continue;
 
@@ -598,8 +599,6 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 c
 			if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
 				scx_bpf_kick_cpu(scx_bpf_task_cpu(p), 0);
 
-			bpf_task_release(p);
-
 			batch--;
 			cpuc->dsp_cnt--;
 			if (!batch || !scx_bpf_dispatch_nr_slots()) {
@@ -724,6 +723,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_t
 	taskc->q_next = NULL;
 	taskc->q_prev = NULL;
 	taskc->fifo = NULL;
+	taskc->tid = p->scx.tid;
 	taskc->pid = p->pid;
 	taskc->force_local = false;
 	taskc->highpri = false;
@@ -776,7 +776,7 @@ void BPF_STRUCT_OPS(qmap_dump, struct sc
 	/*
 	 * Walk the queue lists without locking - kfunc calls (scx_bpf_dump)
 	 * aren't in the verifier's kfunc_spin_allowed() list so we can't hold
-	 * a lock and dump. Best-effort; racing may print stale pids but the
+	 * a lock and dump. Best-effort; racing may print stale tids but the
 	 * walk is bounded by bpf_repeat() so it always terminates.
 	 */
 	bpf_for(i, 0, 5) {
@@ -785,7 +785,7 @@ void BPF_STRUCT_OPS(qmap_dump, struct sc
 		bpf_repeat(4096) {
 			if (!taskc)
 				break;
-			scx_bpf_dump(" %d", taskc->pid);
+			scx_bpf_dump(" %d:%llu", taskc->pid, taskc->tid);
 			taskc = taskc->q_next;
 		}
 		scx_bpf_dump("\n");
@@ -1159,6 +1159,7 @@ void BPF_STRUCT_OPS(qmap_sub_detach, str
 }
 
 SCX_OPS_DEFINE(qmap_ops,
+	       .flags			= SCX_OPS_ENQ_EXITING | SCX_OPS_TID_TO_TASK,
 	       .select_cpu		= (void *)qmap_select_cpu,
 	       .enqueue			= (void *)qmap_enqueue,
 	       .dequeue			= (void *)qmap_dequeue,
