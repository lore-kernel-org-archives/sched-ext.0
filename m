Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6C1312815;
	Fri, 24 Jul 2026 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856559; cv=none; b=FOAsdIYxUUKO8S7oLL4MvBW+2C+LEn6ShgjoGaAHBGj/WzwDt+jP4QDJqAoOwGO2yzCq9yoGVJIwJcKBM/ar5HcyhiVq4Cy4H6Mcf716D95EHXBhbKWyOI2DDmeB4o68rkTMJfycnztNOsPmFT3fj7ukXc927i9/UNBW1BSZY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856559; c=relaxed/simple;
	bh=8sUsvXJ2qT4DFXJgD4rECTIPDnas6k2XdbHZ7oI5Uos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dw/yRNTZM48drcSO1+NaJunXtSr9bf5N6NygV6g+OuaI0MgbGTMTb3r4LKZgnUJQlovgK23EFgCQpoOIQlbTLcOer7JwJUA4GwF4dKvvGWZQHUc79VUiBk5hJfWqWUp+m/lHVS0Nnjl/r59Pd5M3mcgryTK0OAASFScXIxBIAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RirWtRP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RirWtRP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8811F000E9;
	Fri, 24 Jul 2026 01:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856557;
	bh=3hWIPxRl/ryi8hDf2PPOCXW+g6VlMUK9yokcytK1MxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RirWtRP8cjJ2w2s/bezXOVFDrn2ardLJ3x7OA1DuNOf9rYqtk2gDFI2zC0iCKc/bk
	 X8fCdKk8CFwv+McHFWPXS4VX4NVVwU8ZZeWq3InaDKL0M++bbfDmVkMFGuoDuPdG28
	 WrXYWTM0Fr+y9dQTnsACUTytGiiJ5XNA7Z6tXmVbp5mR+UcmgtucqmHrRY5g516ux+
	 90nK4PuXBIQ6JLntGzAWRcbSP9CaPCnMgKRme/YvJ67xcIEJunpL6HlLOVdIR/uath
	 Nd+F31AK+q9lWV0L2sJLGGq2GsWNyHAlTdU6vjoeNRRkbMJJYZ8dIqbGMHLy2U30eU
	 kOyyRILU4vuqQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] sched_ext: Resolve most remaining scx_root accesses
Date: Thu, 23 Jul 2026 15:29:13 -1000
Message-ID: <20260724012914.107823-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724012914.107823-1-tj@kernel.org>
References: <20260724012914.107823-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_root is __rcu and naked accesses were left as transitional markers for
the multi-scheduler transition, to be converted to accesses through the
associated scheduler instances. Most accesses have since been converted to
resolve the sched from the program or task at hand. The remaining naked
sites divide into ones that semantically always want the root sched, which
this patch resolves, and one that is left to a later patch.

The resolved sites:

- The SCX_OPS_TID_TO_TASK validation and the ecaps sync kick already hold a
  sched whose ancestors[] pins the root as entry 0 with plain pointers
  stable for the sched's lifetime. Reach the root through the sched at hand.

- The dispatch entry, class switch, idle notification and fork init paths
  only execute while the scheduler is live and scx_root never changes inside
  the live window, so no update can race them. Add scx_root_protected_live()
  which documents that invariant and resolves with a plain load.

- The hotplug path, including the ecaps reseeds, runs with the hotplug lock
  held, which excludes the scx_root writers. Add scx_root_protected(), which
  accepts either the hotplug lock or scx_enable_mutex.

- Is-root tests use a zero level instead of comparing against the global.

touch_core_sched_dispatch() stays naked, to be resolved by a later patch.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 12 ++++++------
 kernel/sched/ext/idle.c     | 15 +++++++--------
 kernel/sched/ext/internal.h | 27 +++++++++++++++++++++++++++
 kernel/sched/ext/sub.c      | 17 ++++++++++-------
 4 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index d172ff5f7dc3..95aadce7b104 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2786,7 +2786,7 @@ static inline void maybe_queue_balance_callback(struct rq *rq)
 
 static int balance_one(struct rq *rq, struct task_struct *prev)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_root_protected_live();
 	s32 cpu = cpu_of(rq);
 
 	lockdep_assert_rq_held(rq);
@@ -2942,7 +2942,7 @@ preempt_reason_from_class(const struct sched_class *class)
 
 static void switch_class(struct rq *rq, struct task_struct *next)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_root_protected_live();
 	const struct sched_class *next_class = next->sched_class;
 
 	if (!(sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT))
@@ -3333,7 +3333,7 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 
 static void handle_hotplug(struct rq *rq, bool online)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_root_protected();
 	s32 cpu = cpu_of(rq);
 	s32 cpu_or_cid = cpu;
 
@@ -3797,7 +3797,7 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 #ifdef CONFIG_EXT_SUB_SCHED
 		struct scx_sched *sch = scx_cgroup_sched(kargs->cset->dfl_cgrp);
 #else
-		struct scx_sched *sch = scx_root;
+		struct scx_sched *sch = scx_root_protected_live();
 #endif
 		scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 		ret = __scx_init_task(sch, p, NULL, true);
@@ -5728,7 +5728,7 @@ void scx_disable_bypass_dsp(struct scx_sched *sch)
 static void unbypass_renotify_idle(struct rq *rq, struct scx_sched *pos,
 				   struct scx_sched_pcpu *pcpu)
 {
-	if (pos == scx_root) {
+	if (!pos->level) {
 		rq->scx.flags |= SCX_RQ_ROOT_IDLE_RENOTIFY;
 		return;
 	}
@@ -7096,7 +7096,7 @@ int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 	 * enabled it.
 	 */
 	if ((ops->flags & SCX_OPS_TID_TO_TASK) && scx_parent(sch) &&
-	    !(scx_root->ops.flags & SCX_OPS_TID_TO_TASK)) {
+	    !(sch->ancestors[0]->ops.flags & SCX_OPS_TID_TO_TASK)) {
 		scx_error(sch, "SCX_OPS_TID_TO_TASK requires root scheduler to enable it");
 		return -EINVAL;
 	}
diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index d08166de03d8..ccfc35b1bba9 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -742,30 +742,29 @@ static void scx_idle_notify(struct rq *rq, bool idle, bool do_notify, bool root_
 {
 	s32 cpu = cpu_of(rq);
 	s32 cid = scx_cpu_arg(cpu);
+	struct scx_sched *root = scx_root_protected_live();
 	struct scx_sched *pos;
 
 	lockdep_assert_rq_held(rq);
 
 	/* with no sub-sched, only the root can be owed a notification */
 	if (!scx_has_subs()) {
-		struct scx_sched *sch = scx_root;
-
 		if ((do_notify || root_renotify) &&
-		    SCX_HAS_OP(sch, update_idle) && !scx_bypassing(sch, cpu))
-			SCX_CALL_OP(sch, update_idle, rq, cid, idle);
+		    SCX_HAS_OP(root, update_idle) && !scx_bypassing(root, cpu))
+			SCX_CALL_OP(root, update_idle, rq, cid, idle);
 		return;
 	}
 
-	pos = scx_next_descendant_pre(NULL, scx_root);
+	pos = scx_next_descendant_pre(NULL, root);
 	while (pos) {
 		bool forced = false;
 
 		if (unlikely(scx_missing_caps(pos, cpu, SCX_CAP_BASE))) {
-			pos = scx_skip_subtree_pre(pos, scx_root);
+			pos = scx_skip_subtree_pre(pos, root);
 			continue;
 		}
 
-		if (pos == scx_root) {
+		if (!pos->level) {
 			forced = root_renotify;
 		}
 #ifdef CONFIG_EXT_SUB_SCHED
@@ -777,7 +776,7 @@ static void scx_idle_notify(struct rq *rq, bool idle, bool do_notify, bool root_
 		if ((do_notify || forced) && SCX_HAS_OP(pos, update_idle) &&
 		    !scx_bypassing(pos, cpu))
 			SCX_CALL_OP(pos, update_idle, rq, cid, idle);
-		pos = scx_next_descendant_pre(pos, scx_root);
+		pos = scx_next_descendant_pre(pos, root);
 	}
 }
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index a9a853a71061..abe1e7653e1d 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1996,6 +1996,33 @@ extern struct scx_sched *scx_enabling_sub_sched;
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
 
+/**
+ * scx_root_protected_live - Root sched for paths that only run while live
+ *
+ * scx_root is published before the scheduler goes live and cleared only after
+ * it is fully drained, so a path that only executes while the scheduler is live
+ * can never race an update. Return the root sched with a plain load, never
+ * %NULL.
+ */
+static inline struct scx_sched *scx_root_protected_live(void)
+{
+	return rcu_dereference_protected(scx_root, true);
+}
+
+/**
+ * scx_root_protected - Root sched for contexts that exclude its updates
+ *
+ * Both scx_root updates run under the locks checked below, so holding one
+ * excludes them. Return the root sched with a plain load, %NULL if no scheduler
+ * is loaded.
+ */
+static inline struct scx_sched *scx_root_protected(void)
+{
+	return rcu_dereference_protected(scx_root,
+					 lockdep_is_cpus_held() ||
+					 lockdep_is_held(&scx_enable_mutex));
+}
+
 static inline struct scx_dispatch_q *scx_bypass_dsq(struct scx_sched *sch, s32 cpu)
 {
 	return &per_cpu_ptr(sch->pcpu, cpu)->bypass_dsq;
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 2a8c979c7976..824fe35f00ee 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -477,7 +477,7 @@ static void queue_sync_ecaps(struct scx_sched *sch, s32 cid)
 	if (llist_on_list(&pcpu->ecaps_to_sync_node))
 		return;
 	if (llist_add(&pcpu->ecaps_to_sync_node, &cpu_rq(cpu)->scx.ecaps_to_sync))
-		scx_kick_cpu(scx_root, cpu, 0);
+		scx_kick_cpu(sch->ancestors[0], cpu, 0);
 }
 
 /* discard @rq's queued ecaps syncs */
@@ -638,7 +638,7 @@ void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch)
  */
 void scx_online_ecaps(struct rq *rq)
 {
-	struct scx_sched *pos;
+	struct scx_sched *root, *pos;
 	s32 cid, shard;
 
 	/*
@@ -652,14 +652,15 @@ void scx_online_ecaps(struct rq *rq)
 
 	guard(rq_lock_irqsave)(rq);
 
+	root = scx_root_protected();
 	cid = __scx_cpu_to_cid(cpu_of(rq));
 	shard = rcu_dereference_all(scx_cid_to_shard)[cid];
 
-	scx_for_each_descendant_pre(pos, scx_root) {
+	scx_for_each_descendant_pre(pos, root) {
 		struct scx_pshard *ps;
 
 		/* root holds every cap and never uses ecaps */
-		if (pos == scx_root)
+		if (!pos->level)
 			continue;
 
 		ps = pos->pshard[shard];
@@ -679,13 +680,15 @@ void scx_online_ecaps(struct rq *rq)
 void scx_offline_ecaps(struct rq *rq)
 {
 	s32 cpu = cpu_of(rq);
-	struct scx_sched *pos;
+	struct scx_sched *root, *pos;
 
 	guard(rq_lock_irqsave)(rq);
 
-	scx_for_each_descendant_pre(pos, scx_root) {
+	root = scx_root_protected();
+
+	scx_for_each_descendant_pre(pos, root) {
 		/* root holds every cap and never uses ecaps */
-		if (pos == scx_root)
+		if (!pos->level)
 			continue;
 
 		WRITE_ONCE(per_cpu_ptr(pos->pcpu, cpu)->ecaps, 0);
-- 
2.55.0

