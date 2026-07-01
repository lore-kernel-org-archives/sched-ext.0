Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592B4C6EEB;
	Wed,  1 Jul 2026 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929452; cv=none; b=ET7l+DsEhSkhozIJQEjRpPjc55CC70vqvXp/9sRVKifxwAYA1rsQs7C0EZjpKv+wFm1CAeiflwiAYU26I9iiJODPTAK0s5t+37l2qVD11WU26JDPrORZpuRl/8aHzgmZJfd6id7fmSi9f0WjRHAxtgbde/9dkWmC8uVcZbgpK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929452; c=relaxed/simple;
	bh=Pt/ZWR/2tqKk/QpDWUIUvgCUUyLaTM9ZFdIyLGYDRqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dErFveJy82eYYERAmom2sknrW2rPTnqR80w9J5nEsGL0rpU2lXvsI5oS2swv3ZKGBK5y0R5KCLDRBN9S3UgsUS2ztR3EmDC/lMnEfq1QzxoWrEnmX7KjAqcPHLQ3nh8P57nEIcWiuixVpD7TFeahjBgqCNBYQ/SwQxCA6tdvRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9jrOlu5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9jrOlu5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2101F00A3A;
	Wed,  1 Jul 2026 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782929450;
	bh=c5bXW4jCNOKx+P0sqjp4z0bpmVNkmcAbFrk43kHq1Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E9jrOlu57f3421obF1hctxkQGfcdQVFkRzjSjl+ATrwgNQGXmjCGiJ4LiZn2ShHaz
	 evR/wUBJoGyqqKLGPsDhUX+QGSjlFB9PB+4FghSIMnqEGAlUx0raYkZOseYqYkdcQ3
	 qDi5aG3Y3a0auWnRE6vIBjDXQKFoYQu+AGeaUmuEkc8gtXtDgXJdNulZZoq9+WCd7r
	 PvE6ndpZYB11RQnjPmM4gKCZCr+t1q0ottXzoppFQUE6H+jt7HECcdtmmuScY4ZxF0
	 kLO46oSszo2hr+hug25kCOGwJMO4SgbuUGxsp+/pEDRHa5tmDMJIQUDGvr9tQYNJgJ
	 HHabY5o/pG7Qg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 2/4] sched_ext: Expose the ext.c internals used by the sub.c split
Date: Wed,  1 Jul 2026 08:10:44 -1000
Message-ID: <20260701181046.2490390-3-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701181046.2490390-1-tj@kernel.org>
References: <20260701181046.2490390-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sub-scheduler implementation is about to move into its own sub.c, from
where it calls a set of ext.c helpers and shares a few ext.c globals. Make
those reachable across the new file boundary ahead of the move.

No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 109 ++++++++++++------------------------
 kernel/sched/ext/internal.h |  77 +++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 73 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 56e6a13fd0f8..58856a429821 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -20,7 +20,7 @@
 #include "arena.h"
 #include "idle.h"
 
-static DEFINE_RAW_SPINLOCK(scx_sched_lock);
+DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 /*
  * NOTE: sched_ext is in the process of growing multiple scheduler support and
@@ -39,14 +39,14 @@ struct scx_sched __rcu *scx_root;
 static LIST_HEAD(scx_sched_all);
 
 #ifdef CONFIG_EXT_SUB_SCHED
-static const struct rhashtable_params scx_sched_hash_params = {
+const struct rhashtable_params scx_sched_hash_params = {
 	.key_len		= sizeof_field(struct scx_sched, ops.sub_cgroup_id),
 	.key_offset		= offsetof(struct scx_sched, ops.sub_cgroup_id),
 	.head_offset		= offsetof(struct scx_sched, hash_node),
 	.insecure_elasticity	= true,	/* inserted under scx_sched_lock */
 };
 
-static struct rhashtable scx_sched_hash;
+struct rhashtable scx_sched_hash;
 #endif
 
 /* see SCX_OPS_TID_TO_TASK */
@@ -68,9 +68,9 @@ static DEFINE_RAW_SPINLOCK(scx_tasks_lock);
 static LIST_HEAD(scx_tasks);
 
 /* ops enable/disable */
-static DEFINE_MUTEX(scx_enable_mutex);
+DEFINE_MUTEX(scx_enable_mutex);
 DEFINE_STATIC_KEY_FALSE(__scx_enabled);
-DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
+DEFINE_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
 static DEFINE_RAW_SPINLOCK(scx_bypass_lock);
 static bool scx_init_task_enabled;
@@ -101,7 +101,7 @@ static atomic64_t scx_tid_cursor = ATOMIC64_INIT(1);
  * tasks for the sub-sched being enabled. Use a global variable instead of a
  * per-task field as all enables are serialized.
  */
-static struct scx_sched *scx_enabling_sub_sched;
+struct scx_sched *scx_enabling_sub_sched;
 #else
 #define scx_enabling_sub_sched	(struct scx_sched *)NULL
 #endif	/* CONFIG_EXT_SUB_SCHED */
@@ -676,12 +676,12 @@ struct bpf_iter_scx_dsq {
 } __attribute__((aligned(8)));
 
 
-static u32 scx_get_task_state(const struct task_struct *p)
+u32 scx_get_task_state(const struct task_struct *p)
 {
 	return p->scx.flags & SCX_TASK_STATE_MASK;
 }
 
-static void scx_set_task_state(struct task_struct *p, u32 state)
+void scx_set_task_state(struct task_struct *p, u32 state)
 {
 	u32 prev_state = scx_get_task_state(p);
 	bool warn = false;
@@ -721,23 +721,6 @@ static void scx_set_task_state(struct task_struct *p, u32 state)
 	p->scx.flags |= state;
 }
 
-/*
- * SCX task iterator.
- */
-struct scx_task_iter {
-	struct sched_ext_entity		cursor;
-	struct task_struct		*locked_task;
-	struct rq			*rq;
-	struct rq_flags			rf;
-	u32				cnt;
-	bool				list_locked;
-#ifdef CONFIG_EXT_SUB_SCHED
-	struct cgroup			*cgrp;
-	struct cgroup_subsys_state	*css_pos;
-	struct css_task_iter		css_iter;
-#endif
-};
-
 /**
  * scx_task_iter_start - Lock scx_tasks_lock and start a task iteration
  * @iter: iterator to init
@@ -766,7 +749,7 @@ struct scx_task_iter {
  * All tasks which existed when the iteration started are guaranteed to be
  * visited as long as they are not dead.
  */
-static void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp)
+void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp)
 {
 	memset(iter, 0, sizeof(*iter));
 
@@ -805,7 +788,7 @@ static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
  * This function can be safely called anytime during an iteration. The next
  * iterator operation will automatically restore the necessary locking.
  */
-static void scx_task_iter_unlock(struct scx_task_iter *iter)
+void scx_task_iter_unlock(struct scx_task_iter *iter)
 {
 	__scx_task_iter_rq_unlock(iter);
 	if (iter->list_locked) {
@@ -848,7 +831,7 @@ static void scx_task_iter_relock(struct scx_task_iter *iter,
  * which is released on return. If the iterator holds a task's rq lock, that rq
  * lock is also released. See scx_task_iter_start() for details.
  */
-static void scx_task_iter_stop(struct scx_task_iter *iter)
+void scx_task_iter_stop(struct scx_task_iter *iter)
 {
 #ifdef CONFIG_EXT_SUB_SCHED
 	if (iter->cgrp) {
@@ -923,7 +906,7 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
  * whether they would like to filter out dead tasks. See scx_task_iter_start()
  * for details.
  */
-static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
+struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
 {
 	struct task_struct *p;
 
@@ -1186,8 +1169,8 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
-static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
-			       u64 reenq_flags, struct rq *locked_rq)
+void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
+			u64 reenq_flags, struct rq *locked_rq)
 {
 	struct rq *rq;
 
@@ -2491,8 +2474,8 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	return dst_rq;
 }
 
-static bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
-				   struct scx_dispatch_q *dsq, u64 enq_flags)
+bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
+			    struct scx_dispatch_q *dsq, u64 enq_flags)
 {
 	struct task_struct *p;
 retry:
@@ -2538,7 +2521,7 @@ static bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 	return false;
 }
 
-static bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq)
+bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq)
 {
 	int node = cpu_to_node(cpu_of(rq));
 
@@ -3548,7 +3531,7 @@ static struct cgroup *tg_cgrp(struct task_group *tg)
 
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 
-static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
+int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
 {
 	int ret;
 
@@ -3631,7 +3614,7 @@ static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);
 }
 
-static void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
+void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 {
 	__scx_enable_task(sch, p);
 	scx_set_task_state(p, SCX_TASK_ENABLED);
@@ -3665,8 +3648,7 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
 }
 
-static void __scx_disable_and_exit_task(struct scx_sched *sch,
-					struct task_struct *p)
+void __scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p)
 {
 	struct scx_exit_task_args args = {
 		.cancelled = false,
@@ -3700,7 +3682,7 @@ static void __scx_disable_and_exit_task(struct scx_sched *sch,
  * ran. The task state has not been transitioned, so this mirrors the
  * SCX_TASK_INIT branch in __scx_disable_and_exit_task().
  */
-static void scx_sub_init_cancel_task(struct scx_sched *sch, struct task_struct *p)
+void scx_sub_init_cancel_task(struct scx_sched *sch, struct task_struct *p)
 {
 	struct scx_exit_task_args args = { .cancelled = true };
 
@@ -3711,8 +3693,7 @@ static void scx_sub_init_cancel_task(struct scx_sched *sch, struct task_struct *
 		SCX_CALL_OP_TASK(sch, exit_task, task_rq(p), p, &args);
 }
 
-static void scx_disable_and_exit_task(struct scx_sched *sch,
-				      struct task_struct *p)
+void scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p)
 {
 	__scx_disable_and_exit_task(sch, p);
 
@@ -4525,7 +4506,7 @@ static struct cgroup *root_cgroup(void)
 	return &cgrp_dfl_root.cgrp;
 }
 
-static void scx_cgroup_lock(void)
+void scx_cgroup_lock(void)
 {
 #ifdef CONFIG_EXT_GROUP_SCHED
 	percpu_down_write(&scx_cgroup_ops_rwsem);
@@ -4533,7 +4514,7 @@ static void scx_cgroup_lock(void)
 	cgroup_lock();
 }
 
-static void scx_cgroup_unlock(void)
+void scx_cgroup_unlock(void)
 {
 	cgroup_unlock();
 #ifdef CONFIG_EXT_GROUP_SCHED
@@ -4851,7 +4832,7 @@ static void free_exit_info(struct scx_exit_info *ei);
 static const char *scx_exit_reason(enum scx_exit_kind kind);
 static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind);
 
-static s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch)
+s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch)
 {
 	size_t size = struct_size_t(struct scx_cmask, bits,
 				    SCX_CMASK_NR_WORDS(num_possible_cpus()));
@@ -5509,7 +5490,7 @@ static void enable_bypass_dsp(struct scx_sched *sch)
 }
 
 /* may be called without holding scx_bypass_lock */
-static void scx_disable_bypass_dsp(struct scx_sched *sch)
+void scx_disable_bypass_dsp(struct scx_sched *sch)
 {
 	s32 ret;
 
@@ -5557,7 +5538,7 @@ static void scx_disable_bypass_dsp(struct scx_sched *sch)
  *
  * - scx_prio_less() reverts to the default core_sched_at order.
  */
-static void scx_bypass(struct scx_sched *sch, bool bypass)
+void scx_bypass(struct scx_sched *sch, bool bypass)
 {
 	struct scx_sched *pos;
 	unsigned long flags;
@@ -5746,7 +5727,7 @@ static void refresh_watchdog(void)
 		cancel_delayed_work_sync(&scx_watchdog_work);
 }
 
-static s32 scx_link_sched(struct scx_sched *sch)
+s32 scx_link_sched(struct scx_sched *sch)
 {
 	const char *err_msg = "";
 	s32 ret = 0;
@@ -5795,7 +5776,7 @@ static s32 scx_link_sched(struct scx_sched *sch)
 	return 0;
 }
 
-static void scx_unlink_sched(struct scx_sched *sch)
+void scx_unlink_sched(struct scx_sched *sch)
 {
 	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
@@ -5816,13 +5797,13 @@ static void scx_unlink_sched(struct scx_sched *sch)
  * @sch. Once @sch becomes empty during disable, there's no point in dumping it.
  * This prevents calling dump ops on a dead sch.
  */
-static void scx_disable_dump(struct scx_sched *sch)
+void scx_disable_dump(struct scx_sched *sch)
 {
 	guard(raw_spinlock_irqsave)(&scx_dump_lock);
 	sch->dump_disabled = true;
 }
 
-static void scx_log_sched_disable(struct scx_sched *sch)
+void scx_log_sched_disable(struct scx_sched *sch)
 {
 	struct scx_exit_info *ei = sch->exit_info;
 	const char *type = scx_parent(sch) ? "sub-scheduler" : "scheduler";
@@ -6285,7 +6266,7 @@ static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
  * as a noop. Syncing the irq_work first is required to guarantee the
  * kthread work has been queued before waiting for it.
  */
-static void scx_flush_disable_work(struct scx_sched *sch)
+void scx_flush_disable_work(struct scx_sched *sch)
 {
 	int kind;
 
@@ -6739,31 +6720,13 @@ static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int node)
 	return pnode;
 }
 
-/*
- * scx_enable() is offloaded to a dedicated system-wide RT kthread to avoid
- * starvation. During the READY -> ENABLED task switching loop, the calling
- * thread's sched_class gets switched from fair to ext. As fair has higher
- * priority than ext, the calling thread can be indefinitely starved under
- * fair-class saturation, leading to a system hang.
- */
-struct scx_enable_cmd {
-	struct kthread_work	work;
-	union {
-		struct sched_ext_ops		*ops;
-		struct sched_ext_ops_cid	*ops_cid;
-	};
-	bool			is_cid_type;
-	struct bpf_map		*arena_map;	/* arena ref to transfer to sch */
-	int			ret;
-};
-
 /*
  * Allocate and initialize a new scx_sched. @cgrp's reference is always
  * consumed whether the function succeeds or fails.
  */
-static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
-						 struct cgroup *cgrp,
-						 struct scx_sched *parent)
+struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
+					  struct cgroup *cgrp,
+					  struct scx_sched *parent)
 {
 	struct sched_ext_ops *ops = cmd->ops;
 	struct scx_sched *sch;
@@ -7007,7 +6970,7 @@ static int check_hotplug_seq(struct scx_sched *sch,
 	return 0;
 }
 
-static int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
+int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 {
 	/*
 	 * It doesn't make sense to specify the SCX_OPS_ENQ_LAST flag if the
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 743980dc60b0..53a8aec8652e 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1535,6 +1535,41 @@ enum scx_ops_state {
 #define SCX_OPSS_STATE_MASK	((1LU << SCX_OPSS_QSEQ_SHIFT) - 1)
 #define SCX_OPSS_QSEQ_MASK	(~SCX_OPSS_STATE_MASK)
 
+/*
+ * SCX task iterator.
+ */
+struct scx_task_iter {
+	struct sched_ext_entity		cursor;
+	struct task_struct		*locked_task;
+	struct rq			*rq;
+	struct rq_flags			rf;
+	u32				cnt;
+	bool				list_locked;
+#ifdef CONFIG_EXT_SUB_SCHED
+	struct cgroup			*cgrp;
+	struct cgroup_subsys_state	*css_pos;
+	struct css_task_iter		css_iter;
+#endif
+};
+
+/*
+ * scx_enable() is offloaded to a dedicated system-wide RT kthread to avoid
+ * starvation. During the READY -> ENABLED task switching loop, the calling
+ * thread's sched_class gets switched from fair to ext. As fair has higher
+ * priority than ext, the calling thread can be indefinitely starved under
+ * fair-class saturation, leading to a system hang.
+ */
+struct scx_enable_cmd {
+	struct kthread_work	work;
+	union {
+		struct sched_ext_ops		*ops;
+		struct sched_ext_ops_cid	*ops_cid;
+	};
+	bool			is_cid_type;
+	struct bpf_map		*arena_map;	/* arena ref to transfer to sch */
+	int			ret;
+};
+
 extern struct scx_sched __rcu *scx_root;
 DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
@@ -1555,6 +1590,48 @@ __printf(5, 0) bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
 __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
 			       s64 exit_code, s32 exit_cpu, const char *fmt, ...);
 
+u32 scx_get_task_state(const struct task_struct *p);
+void scx_set_task_state(struct task_struct *p, u32 state);
+void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp);
+void scx_task_iter_unlock(struct scx_task_iter *iter);
+void scx_task_iter_stop(struct scx_task_iter *iter);
+struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
+bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
+			    struct scx_dispatch_q *dsq, u64 enq_flags);
+bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq);
+void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
+			u64 reenq_flags, struct rq *locked_rq);
+int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork);
+void scx_enable_task(struct scx_sched *sch, struct task_struct *p);
+void __scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p);
+void scx_sub_init_cancel_task(struct scx_sched *sch, struct task_struct *p);
+void scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p);
+#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
+void scx_cgroup_lock(void);
+void scx_cgroup_unlock(void);
+#endif
+s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch);
+void scx_disable_bypass_dsp(struct scx_sched *sch);
+void scx_bypass(struct scx_sched *sch, bool bypass);
+s32 scx_link_sched(struct scx_sched *sch);
+void scx_unlink_sched(struct scx_sched *sch);
+void scx_disable_dump(struct scx_sched *sch);
+void scx_log_sched_disable(struct scx_sched *sch);
+void scx_flush_disable_work(struct scx_sched *sch);
+struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
+					  struct cgroup *cgrp,
+					  struct scx_sched *parent);
+int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops);
+
+extern raw_spinlock_t scx_sched_lock;
+extern struct mutex scx_enable_mutex;
+extern struct percpu_rw_semaphore scx_fork_rwsem;
+#ifdef CONFIG_EXT_SUB_SCHED
+extern const struct rhashtable_params scx_sched_hash_params;
+extern struct rhashtable scx_sched_hash;
+extern struct scx_sched *scx_enabling_sub_sched;
+#endif
+
 #define scx_exit(sch, kind, exit_code, fmt, args...)				\
 	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
 #define scx_error(sch, fmt, args...)						\
-- 
2.54.0

