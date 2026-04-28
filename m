Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8D131282C;
	Tue, 28 Apr 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408560; cv=none; b=jpyGRj9h7hZ1AaYZdC8ikJjc0y1SXjKODMDPzJFLbNEMcXbed479cXhmbKoD4qQ0IiDwxdjI/2KL92VzZ1H4HZ+zXrHBuFK7L4oJIgg+A0XtmOrscv0NT6hwohgyGN7GzBwa1JuAL+ltzjwPwepUwRR3q0BD71dW5d2nAf/gRF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408560; c=relaxed/simple;
	bh=AnztjU1Z6mMFpLP4q5qo6qjGjRrvcjN9vbE9Q50v6e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6Hjp7/OWnRp8XxWubDbcLpoZwnE9e0HI7IeXDadRhDvuPvwsKLP0EDzN1epcS8n0D7VJXDNKmmD9g+IHrvnJdcECquB+bPj5v58850Q412cIKJU/TTc41mXip8aC0tT2QR/0X2BBs2zeafASdKUrisf2Ulc4ixphprnoiack0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyVy8uH6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyVy8uH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FF9C2BCAF;
	Tue, 28 Apr 2026 20:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408559;
	bh=AnztjU1Z6mMFpLP4q5qo6qjGjRrvcjN9vbE9Q50v6e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyVy8uH6AG68vBFLCRDPXA+eMjJQqlSe/HE8ddFcM0ttGV+fsWkUh0QxT0OAMBlWv
	 Bo9x7EMANaURCsqs0m0hv9zhyGjnsHJTmtgb91G7RDGla8GaI3jS29biJvqrFDfb8u
	 srLK2SwCeb2EJHPz5j2gQdOwUe5EcrZmzuvt5E4n0FxeLqoG8X+0IBPku+w3wG333Q
	 iEB2l8Du/tr86NZdGJQRwl0KoeC63nlfLQLKiNLOap0dCkaCWIva3M3chM7JZC4Y1I
	 rFdgJJ/nI/D0OerlfNKIoxIOuRLot7bwEQh70E/jtU3fGfDI+zuqXhGGx9W9Z0lKN3
	 GtMgVPP0Fx/mg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 12/17] sched_ext: Add bpf_sched_ext_ops_cid struct_ops type
Date: Tue, 28 Apr 2026 10:35:40 -1000
Message-ID: <20260428203545.181052-13-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428203545.181052-1-tj@kernel.org>
References: <20260428203545.181052-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpumask is awkward from BPF and unusable from arena; cid/cmask work in
both. Sub-sched enqueue will need cmask. Without a full cid interface,
schedulers end up mixing forms - a subtle-bug factory.

Add sched_ext_ops_cid, which mirrors sched_ext_ops with cid/cmask
replacing cpu/cpumask in the topology-carrying callbacks.
cpu_acquire/cpu_release are deprecated and absent; a prior patch
moved them past @priv so the cid-form can omit them without
disturbing shared-field offsets.

The two structs share byte-identical layout up to @priv, so the
existing bpf_scx init/check hooks, has_op bitmap, and
scx_kf_allow_flags[] are offset-indexed and apply to both.
BUILD_BUG_ON in scx_init() pins the shared-field and renamed-callback
offsets so any future drift trips at boot.

The kernel<->BPF boundary translates between cpu and cid:

- A static key, enabled on cid-form sched load, gates the translation
  so cpu-form schedulers pay nothing.
- dispatch, update_idle, cpu_online/offline and dump_cpu translate
  the cpu arg at the callsite.
- select_cpu also translates the returned cid back to a cpu.
- set_cpumask is wrapped to synthesize a cmask in a per-cpu scratch
  before calling the cid-form callback.

All scheds in a hierarchy share one form. The static key drives the
hot-path branch.

v2: Use struct_size() for the set_cmask_scratch percpu alloc. Move
    cid-shard fields and assertions into the later cid-shard patch.

v3: Drop `static` on scx_set_cmask_scratch; add extern in ext_internal.h.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c                       | 281 +++++++++++++++++++++--
 kernel/sched/ext_cid.c                   |  37 ++-
 kernel/sched/ext_cid.h                   |   9 +
 kernel/sched/ext_idle.c                  |   2 +-
 kernel/sched/ext_internal.h              | 109 ++++++++-
 tools/sched_ext/include/scx/compat.bpf.h |  12 +
 6 files changed, 429 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3f77e83044a1..8e3c60affc0b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -513,6 +513,33 @@ do {										\
 		update_locked_rq(__prev_locked_rq);				\
 } while (0)
 
+/*
+ * Flipped on enable per sch->is_cid_type. Declared in ext_internal.h so
+ * subsystem inlines can read it.
+ */
+DEFINE_STATIC_KEY_FALSE(__scx_is_cid_type);
+
+/*
+ * scx_cpu_arg() wraps a cpu arg being handed to an SCX op. For cid-form
+ * schedulers it resolves to the matching cid; for cpu-form it passes @cpu
+ * through. scx_cpu_ret() is the inverse for a cpu/cid returned from an op
+ * (currently only ops.select_cpu); it validates the BPF-supplied cid and
+ * triggers scx_error() on @sch if invalid.
+ */
+static s32 scx_cpu_arg(s32 cpu)
+{
+	if (scx_is_cid_type())
+		return __scx_cpu_to_cid(cpu);
+	return cpu;
+}
+
+static s32 scx_cpu_ret(struct scx_sched *sch, s32 cpu_or_cid)
+{
+	if (cpu_or_cid < 0 || !scx_is_cid_type())
+		return cpu_or_cid;
+	return scx_cid_to_cpu(sch, cpu_or_cid);
+}
+
 #define SCX_CALL_OP_RET(sch, op, locked_rq, args...)				\
 ({										\
 	struct rq *__prev_locked_rq;						\
@@ -574,6 +601,41 @@ do {										\
 	__ret;									\
 })
 
+/**
+ * scx_call_op_set_cpumask - invoke ops.set_cpumask / ops_cid.set_cmask for @task
+ * @sch: scx_sched being invoked
+ * @rq: rq to update as the currently-locked rq, or NULL
+ * @task: task whose affinity is changing
+ * @cpumask: new cpumask
+ *
+ * For cid-form schedulers, translate @cpumask to a cmask via the per-cpu
+ * scratch in ext_cid.c and dispatch through the ops_cid union view. Caller
+ * must hold @rq's rq lock so this_cpu_ptr is stable across the call.
+ */
+static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
+					   struct task_struct *task,
+					   const struct cpumask *cpumask)
+{
+	WARN_ON_ONCE(current->scx.kf_tasks[0]);
+	current->scx.kf_tasks[0] = task;
+	if (rq)
+		update_locked_rq(rq);
+
+	if (scx_is_cid_type()) {
+		struct scx_cmask *cmask = this_cpu_ptr(scx_set_cmask_scratch);
+
+		lockdep_assert_irqs_disabled();
+		scx_cpumask_to_cmask(cpumask, cmask);
+		sch->ops_cid.set_cmask(task, cmask);
+	} else {
+		sch->ops.set_cpumask(task, cpumask);
+	}
+
+	if (rq)
+		update_locked_rq(NULL);
+	current->scx.kf_tasks[0] = NULL;
+}
+
 /* see SCX_CALL_OP_TASK() */
 static __always_inline bool scx_kf_arg_task_ok(struct scx_sched *sch,
 							struct task_struct *p)
@@ -1679,7 +1741,7 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 		return &rq->scx.local_dsq;
 
 	if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
-		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+		s32 cpu = scx_cpu_ret(sch, dsq_id & SCX_DSQ_LOCAL_CPU_MASK);
 
 		if (!scx_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
 			return find_global_dsq(sch, tcpu);
@@ -2761,11 +2823,13 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		dspc->nr_tasks = 0;
 
 		if (nested) {
-			SCX_CALL_OP(sch, dispatch, rq, cpu, prev_on_sch ? prev : NULL);
+			SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
+				    prev_on_sch ? prev : NULL);
 		} else {
 			/* stash @prev so that nested invocations can access it */
 			rq->scx.sub_dispatch_prev = prev;
-			SCX_CALL_OP(sch, dispatch, rq, cpu, prev_on_sch ? prev : NULL);
+			SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
+				    prev_on_sch ? prev : NULL);
 			rq->scx.sub_dispatch_prev = NULL;
 		}
 
@@ -3260,7 +3324,9 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		*ddsp_taskp = p;
 
 		this_rq()->scx.in_select_cpu = true;
-		cpu = SCX_CALL_OP_TASK_RET(sch, select_cpu, NULL, p, prev_cpu, wake_flags);
+		cpu = SCX_CALL_OP_TASK_RET(sch, select_cpu, NULL, p,
+					   scx_cpu_arg(prev_cpu), wake_flags);
+		cpu = scx_cpu_ret(sch, cpu);
 		this_rq()->scx.in_select_cpu = false;
 		p->scx.selected_cpu = cpu;
 		*ddsp_taskp = NULL;
@@ -3310,7 +3376,7 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 	 * designation pointless. Cast it away when calling the operation.
 	 */
 	if (SCX_HAS_OP(sch, set_cpumask))
-		SCX_CALL_OP_TASK(sch, set_cpumask, task_rq(p), p, (struct cpumask *)p->cpus_ptr);
+		scx_call_op_set_cpumask(sch, task_rq(p), p, (struct cpumask *)p->cpus_ptr);
 }
 
 static void handle_hotplug(struct rq *rq, bool online)
@@ -3332,9 +3398,9 @@ static void handle_hotplug(struct rq *rq, bool online)
 		scx_idle_update_selcpu_topology(&sch->ops);
 
 	if (online && SCX_HAS_OP(sch, cpu_online))
-		SCX_CALL_OP(sch, cpu_online, NULL, cpu);
+		SCX_CALL_OP(sch, cpu_online, NULL, scx_cpu_arg(cpu));
 	else if (!online && SCX_HAS_OP(sch, cpu_offline))
-		SCX_CALL_OP(sch, cpu_offline, NULL, cpu);
+		SCX_CALL_OP(sch, cpu_offline, NULL, scx_cpu_arg(cpu));
 	else
 		scx_exit(sch, SCX_EXIT_UNREG_KERN,
 			 SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
@@ -3919,7 +3985,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	 * different scheduler class. Keep the BPF scheduler up-to-date.
 	 */
 	if (SCX_HAS_OP(sch, set_cpumask))
-		SCX_CALL_OP_TASK(sch, set_cpumask, rq, p, (struct cpumask *)p->cpus_ptr);
+		scx_call_op_set_cpumask(sch, rq, p, (struct cpumask *)p->cpus_ptr);
 }
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
@@ -5945,6 +6011,7 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
 	static_branch_disable(&__scx_enabled);
+	static_branch_disable(&__scx_is_cid_type);
 	if (sch->ops.flags & SCX_OPS_TID_TO_TASK)
 		static_branch_disable(&__scx_tid_to_task_enabled);
 	bitmap_zero(sch->has_op, SCX_OPI_END);
@@ -6360,7 +6427,7 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 		used = seq_buf_used(&ns);
 		if (SCX_HAS_OP(sch, dump_cpu)) {
 			ops_dump_init(&ns, "  ");
-			SCX_CALL_OP(sch, dump_cpu, rq, &dctx, cpu, idle);
+			SCX_CALL_OP(sch, dump_cpu, rq, &dctx, scx_cpu_arg(cpu), idle);
 			ops_dump_exit();
 		}
 
@@ -6516,7 +6583,11 @@ static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int node)
  */
 struct scx_enable_cmd {
 	struct kthread_work	work;
-	struct sched_ext_ops	*ops;
+	union {
+		struct sched_ext_ops		*ops;
+		struct sched_ext_ops_cid	*ops_cid;
+	};
+	bool			is_cid_type;
 	int			ret;
 };
 
@@ -6524,10 +6595,11 @@ struct scx_enable_cmd {
  * Allocate and initialize a new scx_sched. @cgrp's reference is always
  * consumed whether the function succeeds or fails.
  */
-static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
+static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 						 struct cgroup *cgrp,
 						 struct scx_sched *parent)
 {
+	struct sched_ext_ops *ops = cmd->ops;
 	struct scx_sched *sch;
 	s32 level = parent ? parent->level + 1 : 0;
 	s32 node, cpu, ret, bypass_fail_cpu = nr_cpu_ids;
@@ -6619,7 +6691,18 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		ret = -ENOMEM;
 		goto err_free_lb_cpumask;
 	}
-	sch->ops = *ops;
+	/*
+	 * Copy ops through the right union view. For cid-form the source is
+	 * struct sched_ext_ops_cid which lacks the trailing cpu_acquire/
+	 * cpu_release; those stay zero from kzalloc.
+	 */
+	if (cmd->is_cid_type) {
+		sch->ops_cid = *cmd->ops_cid;
+		sch->is_cid_type = true;
+	} else {
+		sch->ops = *cmd->ops;
+	}
+
 	rcu_assign_pointer(ops->priv, sch);
 
 	sch->kobj.kset = scx_kset;
@@ -6756,7 +6839,12 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
-	if (ops->cpu_acquire || ops->cpu_release)
+	/*
+	 * cid-form's struct is shorter and doesn't include the cpu_acquire /
+	 * cpu_release tail; reading those fields off a cid-form @ops would
+	 * run past the BPF allocation. Skip for cid-form.
+	 */
+	if (!sch->is_cid_type && (ops->cpu_acquire || ops->cpu_release))
 		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
 
 	return 0;
@@ -6792,12 +6880,15 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 #ifdef CONFIG_EXT_SUB_SCHED
 	cgroup_get(cgrp);
 #endif
-	sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
+	sch = scx_alloc_and_add_sched(cmd, cgrp, NULL);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
 		goto err_free_tid_hash;
 	}
 
+	if (sch->is_cid_type)
+		static_branch_enable(&__scx_is_cid_type);
+
 	/*
 	 * Transition to ENABLING and clear exit info to arm the disable path.
 	 * Failure triggers full disabling from here on.
@@ -7119,7 +7210,7 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	raw_spin_unlock_irq(&scx_sched_lock);
 
 	/* scx_alloc_and_add_sched() consumes @cgrp whether it succeeds or not */
-	sch = scx_alloc_and_add_sched(ops, cgrp, parent);
+	sch = scx_alloc_and_add_sched(cmd, cgrp, parent);
 	kobject_put(&parent->kobj);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
@@ -7570,6 +7661,13 @@ static int bpf_scx_reg(void *kdata, struct bpf_link *link)
 	return scx_enable(&cmd, link);
 }
 
+static int bpf_scx_reg_cid(void *kdata, struct bpf_link *link)
+{
+	struct scx_enable_cmd cmd = { .ops_cid = kdata, .is_cid_type = true };
+
+	return scx_enable(&cmd, link);
+}
+
 static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 {
 	struct sched_ext_ops *ops = kdata;
@@ -7701,6 +7799,73 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
 	.cfi_stubs = &__bpf_ops_sched_ext_ops
 };
 
+/*
+ * cid-form cfi stubs. Stubs whose signatures match the cpu-form (param types
+ * identical, only param names differ across structs) are reused; only
+ * set_cmask needs a fresh stub since the second argument type differs.
+ */
+static void sched_ext_ops_cid__set_cmask(struct task_struct *p,
+					 const struct scx_cmask *cmask) {}
+
+static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
+	.select_cid		= sched_ext_ops__select_cpu,
+	.enqueue		= sched_ext_ops__enqueue,
+	.dequeue		= sched_ext_ops__dequeue,
+	.dispatch		= sched_ext_ops__dispatch,
+	.tick			= sched_ext_ops__tick,
+	.runnable		= sched_ext_ops__runnable,
+	.running		= sched_ext_ops__running,
+	.stopping		= sched_ext_ops__stopping,
+	.quiescent		= sched_ext_ops__quiescent,
+	.yield			= sched_ext_ops__yield,
+	.core_sched_before	= sched_ext_ops__core_sched_before,
+	.set_weight		= sched_ext_ops__set_weight,
+	.set_cmask		= sched_ext_ops_cid__set_cmask,
+	.update_idle		= sched_ext_ops__update_idle,
+	.init_task		= sched_ext_ops__init_task,
+	.exit_task		= sched_ext_ops__exit_task,
+	.enable			= sched_ext_ops__enable,
+	.disable		= sched_ext_ops__disable,
+#ifdef CONFIG_EXT_GROUP_SCHED
+	.cgroup_init		= sched_ext_ops__cgroup_init,
+	.cgroup_exit		= sched_ext_ops__cgroup_exit,
+	.cgroup_prep_move	= sched_ext_ops__cgroup_prep_move,
+	.cgroup_move		= sched_ext_ops__cgroup_move,
+	.cgroup_cancel_move	= sched_ext_ops__cgroup_cancel_move,
+	.cgroup_set_weight	= sched_ext_ops__cgroup_set_weight,
+	.cgroup_set_bandwidth	= sched_ext_ops__cgroup_set_bandwidth,
+	.cgroup_set_idle	= sched_ext_ops__cgroup_set_idle,
+#endif
+	.sub_attach		= sched_ext_ops__sub_attach,
+	.sub_detach		= sched_ext_ops__sub_detach,
+	.cid_online		= sched_ext_ops__cpu_online,
+	.cid_offline		= sched_ext_ops__cpu_offline,
+	.init			= sched_ext_ops__init,
+	.exit			= sched_ext_ops__exit,
+	.dump			= sched_ext_ops__dump,
+	.dump_cid		= sched_ext_ops__dump_cpu,
+	.dump_task		= sched_ext_ops__dump_task,
+};
+
+/*
+ * The cid-form struct_ops shares all bpf_struct_ops hooks with the cpu form.
+ * init_member, check_member, reg, unreg, etc. process kdata as the byte block
+ * verified to match by the BUILD_BUG_ON checks in scx_init().
+ */
+static struct bpf_struct_ops bpf_sched_ext_ops_cid = {
+	.verifier_ops = &bpf_scx_verifier_ops,
+	.reg = bpf_scx_reg_cid,
+	.unreg = bpf_scx_unreg,
+	.check_member = bpf_scx_check_member,
+	.init_member = bpf_scx_init_member,
+	.init = bpf_scx_init,
+	.update = bpf_scx_update,
+	.validate = bpf_scx_validate,
+	.name = "sched_ext_ops_cid",
+	.owner = THIS_MODULE,
+	.cfi_stubs = &__bpf_ops_sched_ext_ops_cid
+};
+
 
 /********************************************************************************
  * System integration and init.
@@ -8912,7 +9077,7 @@ __bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id, const struct bpf_prog_aux *aux
 		ret = READ_ONCE(this_rq()->scx.local_dsq.nr);
 		goto out;
 	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
-		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+		s32 cpu = scx_cpu_ret(sch, dsq_id & SCX_DSQ_LOCAL_CPU_MASK);
 
 		if (scx_cpu_valid(sch, cpu, NULL)) {
 			ret = READ_ONCE(cpu_rq(cpu)->scx.local_dsq.nr);
@@ -10019,8 +10184,15 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 
 	/*
 	 * Non-SCX struct_ops: SCX kfuncs are not permitted.
-	 */
-	if (prog->aux->st_ops != &bpf_sched_ext_ops)
+	 *
+	 * Both bpf_sched_ext_ops (cpu-form) and bpf_sched_ext_ops_cid
+	 * (cid-form) are valid SCX struct_ops. Member offsets match between
+	 * the two (verified by BUILD_BUG_ON in scx_init()), so the shared
+	 * scx_kf_allow_flags[] table indexed by SCX_MOFF_IDX(moff) applies to
+	 * both.
+	 */
+	if (prog->aux->st_ops != &bpf_sched_ext_ops &&
+	    prog->aux->st_ops != &bpf_sched_ext_ops_cid)
 		return -EACCES;
 
 	/* SCX struct_ops: check the per-op allow list. */
@@ -10050,6 +10222,73 @@ static int __init scx_init(void)
 {
 	int ret;
 
+	/*
+	 * sched_ext_ops_cid mirrors sched_ext_ops up to and including @priv.
+	 * Both bpf_scx_init_member() and bpf_scx_check_member() use offsets
+	 * from struct sched_ext_ops; sched_ext_ops_cid relies on those offsets
+	 * matching for the shared fields. Catch any drift at boot.
+	 */
+#define CID_OFFSET_MATCH(cpu_field, cid_field)					\
+	BUILD_BUG_ON(offsetof(struct sched_ext_ops, cpu_field) !=		\
+		     offsetof(struct sched_ext_ops_cid, cid_field))
+	/* data fields used by bpf_scx_init_member() */
+	CID_OFFSET_MATCH(dispatch_max_batch, dispatch_max_batch);
+	CID_OFFSET_MATCH(flags, flags);
+	CID_OFFSET_MATCH(name, name);
+	CID_OFFSET_MATCH(timeout_ms, timeout_ms);
+	CID_OFFSET_MATCH(exit_dump_len, exit_dump_len);
+	CID_OFFSET_MATCH(hotplug_seq, hotplug_seq);
+	CID_OFFSET_MATCH(sub_cgroup_id, sub_cgroup_id);
+	/* shared callbacks: the union view requires byte-for-byte offset match */
+	CID_OFFSET_MATCH(enqueue, enqueue);
+	CID_OFFSET_MATCH(dequeue, dequeue);
+	CID_OFFSET_MATCH(dispatch, dispatch);
+	CID_OFFSET_MATCH(tick, tick);
+	CID_OFFSET_MATCH(runnable, runnable);
+	CID_OFFSET_MATCH(running, running);
+	CID_OFFSET_MATCH(stopping, stopping);
+	CID_OFFSET_MATCH(quiescent, quiescent);
+	CID_OFFSET_MATCH(yield, yield);
+	CID_OFFSET_MATCH(core_sched_before, core_sched_before);
+	CID_OFFSET_MATCH(set_weight, set_weight);
+	CID_OFFSET_MATCH(update_idle, update_idle);
+	CID_OFFSET_MATCH(init_task, init_task);
+	CID_OFFSET_MATCH(exit_task, exit_task);
+	CID_OFFSET_MATCH(enable, enable);
+	CID_OFFSET_MATCH(disable, disable);
+	CID_OFFSET_MATCH(dump, dump);
+	CID_OFFSET_MATCH(dump_task, dump_task);
+	CID_OFFSET_MATCH(sub_attach, sub_attach);
+	CID_OFFSET_MATCH(sub_detach, sub_detach);
+	CID_OFFSET_MATCH(init, init);
+	CID_OFFSET_MATCH(exit, exit);
+#ifdef CONFIG_EXT_GROUP_SCHED
+	CID_OFFSET_MATCH(cgroup_init, cgroup_init);
+	CID_OFFSET_MATCH(cgroup_exit, cgroup_exit);
+	CID_OFFSET_MATCH(cgroup_prep_move, cgroup_prep_move);
+	CID_OFFSET_MATCH(cgroup_move, cgroup_move);
+	CID_OFFSET_MATCH(cgroup_cancel_move, cgroup_cancel_move);
+	CID_OFFSET_MATCH(cgroup_set_weight, cgroup_set_weight);
+	CID_OFFSET_MATCH(cgroup_set_bandwidth, cgroup_set_bandwidth);
+	CID_OFFSET_MATCH(cgroup_set_idle, cgroup_set_idle);
+#endif
+	/* renamed callbacks must occupy the same slot as their cpu-form sibling */
+	CID_OFFSET_MATCH(select_cpu, select_cid);
+	CID_OFFSET_MATCH(set_cpumask, set_cmask);
+	CID_OFFSET_MATCH(cpu_online, cid_online);
+	CID_OFFSET_MATCH(cpu_offline, cid_offline);
+	CID_OFFSET_MATCH(dump_cpu, dump_cid);
+	/* @priv tail must align since both share the same data block */
+	CID_OFFSET_MATCH(priv, priv);
+	/*
+	 * cid-form must end exactly at @priv - validate_ops() skips
+	 * cpu_acquire/cpu_release for cid-form because reading those fields
+	 * past the BPF allocation would be UB.
+	 */
+	BUILD_BUG_ON(sizeof(struct sched_ext_ops_cid) !=
+		     offsetofend(struct sched_ext_ops, priv));
+#undef CID_OFFSET_MATCH
+
 	/*
 	 * kfunc registration can't be done from init_sched_ext_class() as
 	 * register_btf_kfunc_id_set() needs most of the system to be up.
@@ -10100,6 +10339,12 @@ static int __init scx_init(void)
 		return ret;
 	}
 
+	ret = register_bpf_struct_ops(&bpf_sched_ext_ops_cid, sched_ext_ops_cid);
+	if (ret) {
+		pr_err("sched_ext: Failed to register cid struct_ops (%d)\n", ret);
+		return ret;
+	}
+
 	ret = register_pm_notifier(&scx_pm_notifier);
 	if (ret) {
 		pr_err("sched_ext: Failed to register PM notifier (%d)\n", ret);
diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
index 607937d9e4d1..bdd8ef8eae3d 100644
--- a/kernel/sched/ext_cid.c
+++ b/kernel/sched/ext_cid.c
@@ -7,6 +7,14 @@
  */
 #include <linux/cacheinfo.h>
 
+/*
+ * Per-cpu scratch cmask used by scx_call_op_set_cpumask() to synthesize a
+ * cmask from a cpumask. Allocated alongside the cid arrays on first enable
+ * and never freed. Sized to the full cid space. Caller holds rq lock so
+ * this_cpu_ptr is safe.
+ */
+struct scx_cmask __percpu *scx_set_cmask_scratch;
+
 /*
  * cid tables.
  *
@@ -46,6 +54,7 @@ static s32 scx_cid_arrays_alloc(void)
 	u32 npossible = num_possible_cpus();
 	s16 *cid_to_cpu, *cpu_to_cid;
 	struct scx_cid_topo *cid_topo;
+	struct scx_cmask __percpu *set_cmask_scratch;
 
 	if (scx_cid_to_cpu_tbl)
 		return 0;
@@ -53,17 +62,22 @@ static s32 scx_cid_arrays_alloc(void)
 	cid_to_cpu = kzalloc_objs(*scx_cid_to_cpu_tbl, npossible, GFP_KERNEL);
 	cpu_to_cid = kzalloc_objs(*scx_cpu_to_cid_tbl, nr_cpu_ids, GFP_KERNEL);
 	cid_topo = kmalloc_objs(*scx_cid_topo, npossible, GFP_KERNEL);
+	set_cmask_scratch = __alloc_percpu(struct_size(set_cmask_scratch, bits,
+						       SCX_CMASK_NR_WORDS(npossible)),
+					   sizeof(u64));
 
-	if (!cid_to_cpu || !cpu_to_cid || !cid_topo) {
+	if (!cid_to_cpu || !cpu_to_cid || !cid_topo || !set_cmask_scratch) {
 		kfree(cid_to_cpu);
 		kfree(cpu_to_cid);
 		kfree(cid_topo);
+		free_percpu(set_cmask_scratch);
 		return -ENOMEM;
 	}
 
 	WRITE_ONCE(scx_cid_to_cpu_tbl, cid_to_cpu);
 	WRITE_ONCE(scx_cpu_to_cid_tbl, cpu_to_cid);
 	WRITE_ONCE(scx_cid_topo, cid_topo);
+	WRITE_ONCE(scx_set_cmask_scratch, set_cmask_scratch);
 	return 0;
 }
 
@@ -208,6 +222,27 @@ s32 scx_cid_init(struct scx_sched *sch)
 	return 0;
 }
 
+/**
+ * scx_cpumask_to_cmask - Translate a kernel cpumask into a cmask
+ * @src: source cpumask
+ * @dst: cmask to write
+ *
+ * Initialize @dst to cover the full cid space [0, num_possible_cpus()) and
+ * set the bit for each cid whose cpu is in @src.
+ */
+void scx_cpumask_to_cmask(const struct cpumask *src, struct scx_cmask *dst)
+{
+	s32 cpu;
+
+	scx_cmask_init(dst, 0, num_possible_cpus());
+	for_each_cpu(cpu, src) {
+		s32 cid = __scx_cpu_to_cid(cpu);
+
+		if (cid >= 0)
+			__scx_cmask_set(dst, cid);
+	}
+}
+
 __bpf_kfunc_start_defs();
 
 /**
diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
index c3c429d2c8e2..f41d48afb7d1 100644
--- a/kernel/sched/ext_cid.h
+++ b/kernel/sched/ext_cid.h
@@ -53,6 +53,7 @@ extern struct btf_id_set8 scx_kfunc_ids_init;
 
 s32 scx_cid_init(struct scx_sched *sch);
 int scx_cid_kfunc_init(void);
+void scx_cpumask_to_cmask(const struct cpumask *src, struct scx_cmask *dst);
 
 /**
  * cid_valid - Verify a cid value, to be used on ops input args
@@ -127,6 +128,14 @@ static inline s32 scx_cpu_to_cid(struct scx_sched *sch, s32 cpu)
 	return __scx_cpu_to_cid(cpu);
 }
 
+/**
+ * scx_is_cid_type - Test whether the active scheduler hierarchy is cid-form
+ */
+static inline bool scx_is_cid_type(void)
+{
+	return static_branch_unlikely(&__scx_is_cid_type);
+}
+
 static inline bool __scx_cmask_contains(const struct scx_cmask *m, u32 cid)
 {
 	return likely(cid >= m->base && cid < m->base + m->nr_bits);
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 860c4634f60e..41785f65bbb2 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -788,7 +788,7 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 	 */
 	if (SCX_HAS_OP(sch, update_idle) && do_notify &&
 	    !scx_bypassing(sch, cpu_of(rq)))
-		SCX_CALL_OP(sch, update_idle, rq, cpu_of(rq), idle);
+		SCX_CALL_OP(sch, update_idle, rq, scx_cpu_arg(cpu_of(rq)), idle);
 }
 
 static void reset_idle_masks(struct sched_ext_ops *ops)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 919d4aa08656..e5f52986d317 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -847,6 +847,93 @@ struct sched_ext_ops {
 	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
 };
 
+/**
+ * struct sched_ext_ops_cid - cid-form alternative to struct sched_ext_ops
+ *
+ * Mirrors struct sched_ext_ops with cpu/cpumask substituted with cid/cmask
+ * where applicable. Layout up to and including @priv matches sched_ext_ops
+ * byte-for-byte (verified by BUILD_BUG_ON checks at scx_init() time) so
+ * shared field offsets work for both struct types in bpf_scx_init_member()
+ * and bpf_scx_check_member(). The deprecated cpu_acquire/cpu_release
+ * callbacks at the tail of sched_ext_ops are omitted here entirely.
+ *
+ * Differences from sched_ext_ops:
+ *   - select_cpu       -> select_cid (returns cid)
+ *   - dispatch         -> dispatch (cpu arg is now cid)
+ *   - update_idle      -> update_idle (cpu arg is now cid)
+ *   - set_cpumask      -> set_cmask (cmask instead of cpumask)
+ *   - cpu_online       -> cid_online
+ *   - cpu_offline      -> cid_offline
+ *   - dump_cpu         -> dump_cid
+ *   - cpu_acquire/cpu_release  -> not present (deprecated in sched_ext_ops)
+ *
+ * BPF schedulers using this type cannot call cpu-form scx_bpf_* kfuncs;
+ * use the cid-form variants instead. Enforced at BPF verifier time via
+ * scx_kfunc_context_filter() branching on prog->aux->st_ops.
+ *
+ * See sched_ext_ops for callback documentation.
+ */
+struct sched_ext_ops_cid {
+	s32 (*select_cid)(struct task_struct *p, s32 prev_cid, u64 wake_flags);
+	void (*enqueue)(struct task_struct *p, u64 enq_flags);
+	void (*dequeue)(struct task_struct *p, u64 deq_flags);
+	void (*dispatch)(s32 cid, struct task_struct *prev);
+	void (*tick)(struct task_struct *p);
+	void (*runnable)(struct task_struct *p, u64 enq_flags);
+	void (*running)(struct task_struct *p);
+	void (*stopping)(struct task_struct *p, bool runnable);
+	void (*quiescent)(struct task_struct *p, u64 deq_flags);
+	bool (*yield)(struct task_struct *from, struct task_struct *to);
+	bool (*core_sched_before)(struct task_struct *a,
+				   struct task_struct *b);
+	void (*set_weight)(struct task_struct *p, u32 weight);
+	void (*set_cmask)(struct task_struct *p,
+			   const struct scx_cmask *cmask);
+	void (*update_idle)(s32 cid, bool idle);
+	s32 (*init_task)(struct task_struct *p,
+			  struct scx_init_task_args *args);
+	void (*exit_task)(struct task_struct *p,
+			   struct scx_exit_task_args *args);
+	void (*enable)(struct task_struct *p);
+	void (*disable)(struct task_struct *p);
+	void (*dump)(struct scx_dump_ctx *ctx);
+	void (*dump_cid)(struct scx_dump_ctx *ctx, s32 cid, bool idle);
+	void (*dump_task)(struct scx_dump_ctx *ctx, struct task_struct *p);
+#ifdef CONFIG_EXT_GROUP_SCHED
+	s32 (*cgroup_init)(struct cgroup *cgrp,
+			    struct scx_cgroup_init_args *args);
+	void (*cgroup_exit)(struct cgroup *cgrp);
+	s32 (*cgroup_prep_move)(struct task_struct *p,
+				 struct cgroup *from, struct cgroup *to);
+	void (*cgroup_move)(struct task_struct *p,
+			     struct cgroup *from, struct cgroup *to);
+	void (*cgroup_cancel_move)(struct task_struct *p,
+				    struct cgroup *from, struct cgroup *to);
+	void (*cgroup_set_weight)(struct cgroup *cgrp, u32 weight);
+	void (*cgroup_set_bandwidth)(struct cgroup *cgrp,
+				      u64 period_us, u64 quota_us, u64 burst_us);
+	void (*cgroup_set_idle)(struct cgroup *cgrp, bool idle);
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+	s32 (*sub_attach)(struct scx_sub_attach_args *args);
+	void (*sub_detach)(struct scx_sub_detach_args *args);
+	void (*cid_online)(s32 cid);
+	void (*cid_offline)(s32 cid);
+	s32 (*init)(void);
+	void (*exit)(struct scx_exit_info *info);
+
+	/* Data fields - must match sched_ext_ops layout exactly */
+	u32 dispatch_max_batch;
+	u64 flags;
+	u32 timeout_ms;
+	u32 exit_dump_len;
+	u64 hotplug_seq;
+	u64 sub_cgroup_id;
+	char name[SCX_OPS_NAME_LEN];
+
+	/* internal use only, must be NULL */
+	void __rcu *priv;
+};
+
 enum scx_opi {
 	SCX_OPI_BEGIN			= 0,
 	SCX_OPI_NORMAL_BEGIN		= 0,
@@ -1003,7 +1090,18 @@ struct scx_sched_pnode {
 };
 
 struct scx_sched {
-	struct sched_ext_ops	ops;
+	/*
+	 * cpu-form and cid-form ops share field offsets up to .priv (verified
+	 * by BUILD_BUG_ON in scx_init()). The anonymous union lets the kernel
+	 * access either view of the same storage without function-pointer
+	 * casts: use .ops for cpu-form and shared fields, .ops_cid for the
+	 * cid-renamed callbacks (set_cmask, select_cid, cid_online, ...).
+	 */
+	union {
+		struct sched_ext_ops		ops;
+		struct sched_ext_ops_cid	ops_cid;
+	};
+	bool			is_cid_type;	/* true if registered via bpf_sched_ext_ops_cid */
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
 
 	/*
@@ -1360,6 +1458,15 @@ enum scx_ops_state {
 extern struct scx_sched __rcu *scx_root;
 DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
+extern struct scx_cmask __percpu *scx_set_cmask_scratch;
+
+/*
+ * True when the currently loaded scheduler hierarchy is cid-form. All scheds
+ * in a hierarchy share one form, so this single key tells callsites which
+ * view to use without per-sch dereferences. Use scx_is_cid_type() to test.
+ */
+DECLARE_STATIC_KEY_FALSE(__scx_is_cid_type);
+
 int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);
 
 bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where);
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 6b9d054c3e4f..87f15f296234 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -446,4 +446,16 @@ static inline void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags)
 		__VA_ARGS__,							\
 	};
 
+/*
+ * Define a cid-form sched_ext_ops. Programs targeting this struct_ops type
+ * use cid-form callback signatures (select_cid, set_cmask, cid_online/offline,
+ * dispatch with cid arg, etc.) and may only call the cid-form scx_bpf_*
+ * kfuncs (kick_cid, task_cid, this_cid, ...).
+ */
+#define SCX_OPS_CID_DEFINE(__name, ...)						\
+	SEC(".struct_ops.link")							\
+	struct sched_ext_ops_cid __name = {					\
+		__VA_ARGS__,							\
+	};
+
 #endif	/* __SCX_COMPAT_BPF_H */
-- 
2.54.0

