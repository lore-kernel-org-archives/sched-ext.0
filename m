Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9813EB818;
	Tue, 14 Jul 2026 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070567; cv=none; b=JNmDItKhK1shkFWZjlXp0+OV1y15pXs9neqyXKzn9/b/4ij+1G+If3vq/8B5qVVuVKzv9Ab7Ws1HTX9jllwdTNnwmICFaL3mQCOcPyDRNp1Ndw2qTuMW9I0B53kboNRddQnFircNVrWCyH5/KCiDffbxfs0DYgskgxTw+xKi8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070567; c=relaxed/simple;
	bh=1xnnH4wgQ1hBeZYWmo6oryAaX6MNhzUM4UdsDmTaFNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbl2bTlCH2C1bYt4bW2lNz8TaIhS0Jz78sze5U9mJQne7SjPt9daD751yvhzrCpuX1rtiw/LKkgpIgG+v4KQfNPfgCKZvJujvYfGB10X2feWXsQMnbiNc/ONqSWjD9WofT8yqKPqGGF7zf8Kgt5Uh+5Ia5wTAGtu+fcprIQ2szM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLRFIUfs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLRFIUfs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC0A1F00AC4;
	Tue, 14 Jul 2026 23:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784070562;
	bh=Y+z57dlxBGDAmtKHepJ39AJA/7V/+arUBd1TwKHw2Nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PLRFIUfsjnQnF5yflFpTSv5+9kUsAw8T0VnGQFpJvNhV02+q3drAFuMTAjvFcfbkW
	 jyQRd7uu4bet6uoV8qWKehyTUm9rhGXz1DtvK8mXoJbDOMYTkrLwXAE5WtQBfusGyk
	 hySk4YS1ZyqqZsjkad9BzYYcLMVFvQg2IQDUgPI7PZarEXRAVNEg62OS4e/t8B/c2A
	 p9Gor00UdaUdhbQJREEbPbHm+hgX8xWAvz0Kk1XvmGBQtbB/DrpsAw6MVLwwLQWBDh
	 pKzc3rRWc2aE7TCOcrPcBy5lWB07kQIMPaVPSrT7jZ3W+zSXTNKNBl3RPeFRrryGra
	 J7mRhRXtnvlag==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] sched_ext: Add the scx_has_subs static key and gate sub-sched hot paths
Date: Tue, 14 Jul 2026 13:09:17 -1000
Message-ID: <20260714230917.84158-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714230917.84158-1-tj@kernel.org>
References: <20260714230917.84158-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_EXT_SUB_SCHED=y but no sub-scheduler attached - the common case
- hot paths still pay for sub-sched bookkeeping. Gate it behind
__scx_has_subs, a static key counting live sub-schedulers, so that a
root-only system stops paying.

Most conversions are simple skip-if-no-sub tests. scx_idle_notify() is
special - it's a hierarchy walk, so give it a fast path which notifies the
root directly using the same tests as the walk. A pending
SCX_RQ_SUB_IDLE_RENOTIFY can be ignored as no sub can be owed one and the
caller clears the flag either way.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  4 ++++
 kernel/sched/ext/idle.c     | 10 ++++++++++
 kernel/sched/ext/internal.h | 19 +++++++++++++++++--
 kernel/sched/ext/sub.c      | 21 +++++++++++++++++++--
 kernel/sched/ext/sub.h      | 15 +++++++++++++++
 5 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 428f2bfb2cda..baf5a3daf7db 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4919,6 +4919,10 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	scx_arena_pool_destroy(sch);
 	if (sch->arena_map)
 		bpf_map_put(sch->arena_map);
+
+	/* @sch is completely inactive by now */
+	scx_dec_has_subs(sch);
+
 	kfree(sch);
 }
 
diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 16ebe3ab8647..d08166de03d8 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -746,6 +746,16 @@ static void scx_idle_notify(struct rq *rq, bool idle, bool do_notify, bool root_
 
 	lockdep_assert_rq_held(rq);
 
+	/* with no sub-sched, only the root can be owed a notification */
+	if (!scx_has_subs()) {
+		struct scx_sched *sch = scx_root;
+
+		if ((do_notify || root_renotify) &&
+		    SCX_HAS_OP(sch, update_idle) && !scx_bypassing(sch, cpu))
+			SCX_CALL_OP(sch, update_idle, rq, cid, idle);
+		return;
+	}
+
 	pos = scx_next_descendant_pre(NULL, scx_root);
 	while (pos) {
 		bool forced = false;
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 8c940be9278d..e69aa04c6739 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2110,7 +2110,7 @@ do {										\
  */
 #define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
 do {										\
-	WARN_ON_ONCE((sch) != scx_task_sched_rcu(task));			\
+	WARN_ON_ONCE(scx_has_subs() && (sch) != scx_task_sched_rcu(task));	\
 	__SCX_CALL_OP_TASK((sch), ops, op, locked_rq, task, ##args);		\
 } while (0)
 
@@ -2125,7 +2125,7 @@ do {										\
 #define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
 ({										\
 	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
-	WARN_ON_ONCE((sch) != scx_task_sched_rcu(task));			\
+	WARN_ON_ONCE(scx_has_subs() && (sch) != scx_task_sched_rcu(task));	\
 	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
 	current->scx.kf_tasks[0] = task;					\
 	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task, ##args);		\
@@ -2165,6 +2165,19 @@ static inline bool scx_bypassing(struct scx_sched *sch, s32 cpu)
 }
 
 #ifdef CONFIG_EXT_SUB_SCHED
+DECLARE_STATIC_KEY_FALSE(__scx_has_subs);
+
+/**
+ * scx_has_subs - Whether any sub-scheduler exists
+ *
+ * Gates the sub-sched portions of hot paths so that a root-only system doesn't
+ * pay for them. See scx_sub_enable_workfn() and scx_sched_free_rcu_work().
+ */
+static inline bool scx_has_subs(void)
+{
+	return static_branch_unlikely(&__scx_has_subs);
+}
+
 /**
  * scx_task_sched - Find scx_sched scheduling a task
  * @p: task of interest
@@ -2259,6 +2272,8 @@ static inline struct scx_sched *scx_parent(struct scx_sched *sch)
 		return NULL;
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
+static inline bool scx_has_subs(void) { return false; }
+
 static inline struct scx_sched *scx_task_sched(const struct task_struct *p)
 {
 	return rcu_dereference_protected(scx_root,
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 198063a78a3a..d92fae5888ac 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -21,6 +21,12 @@
 
 #ifdef CONFIG_EXT_SUB_SCHED
 
+/*
+ * On while any sub-scheduler exists so that a root-only system doesn't pay for
+ * the sub-sched portions of hot paths. See scx_has_subs().
+ */
+DEFINE_STATIC_KEY_FALSE(__scx_has_subs);
+
 /**
  * scx_skip_subtree_pre - Skip @pos's subtree in a pre-order walk
  * @pos: current position
@@ -235,6 +241,9 @@ void scx_init_root_caps(struct scx_sched *sch)
 struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq,
 					       struct task_struct *p, u64 *enq_flags)
 {
+	if (!scx_has_subs())
+		return &rq->scx.local_dsq;
+
 	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
 	struct scx_sched *asch = rq->scx.remote_activate_sch ?: sch;
 	u64 needed = scx_caps_for_enq(*enq_flags);
@@ -313,7 +322,7 @@ void scx_reenq_reject(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
-	if (list_empty(&rq->scx.reject_dsq.list))
+	if (!scx_has_subs() || list_empty(&rq->scx.reject_dsq.list))
 		return;
 
 	/*
@@ -496,7 +505,7 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 
 	lockdep_assert_rq_held(rq);
 
-	if (likely(llist_empty(&rq->scx.ecaps_to_sync)))
+	if (!scx_has_subs() || likely(llist_empty(&rq->scx.ecaps_to_sync)))
 		return;
 
 	/*
@@ -1015,10 +1024,18 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	kobject_get(&parent->kobj);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	/*
+	 * Flip the hot-path gates before ops->priv is published - the sub's
+	 * programs can e.g. kick cpus from that point on. The matching dec is
+	 * at the end of scx_sched_free_rcu_work().
+	 */
+	static_branch_inc(&__scx_has_subs);
+
 	/* scx_alloc_and_add_sched() consumes @cgrp whether it succeeds or not */
 	sch = scx_alloc_and_add_sched(cmd, cgrp, parent);
 	kobject_put(&parent->kobj);
 	if (IS_ERR(sch)) {
+		static_branch_dec(&__scx_has_subs);
 		ret = PTR_ERR(sch);
 		goto out_unlock;
 	}
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index d06bf24aee83..d5f377d35352 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -45,6 +45,13 @@ static inline const char *sch_cgrp_path(struct scx_sched *sch)
 	return sch->cgrp_path;
 }
 
+/* a dying sub's hot-path influence ends in scx_sched_free_rcu_work() */
+static inline void scx_dec_has_subs(struct scx_sched *sch)
+{
+	if (sch->level)
+		static_branch_dec(&__scx_has_subs);
+}
+
 #else	/* CONFIG_EXT_SUB_SCHED */
 
 static inline struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
@@ -67,6 +74,7 @@ static inline void scx_discard_stale_ecaps_syncs(void) {}
 static inline struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq, struct task_struct *p, u64 *enq_flags) { return &rq->scx.local_dsq; }
 static inline bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p) { return false; }
 static inline void scx_reenq_reject(struct rq *rq) {}
+static inline void scx_dec_has_subs(struct scx_sched *sch) {}
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -97,6 +105,10 @@ static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed)
 {
 	u64 ecaps;
 
+	/* no sub-scheds, no missing caps */
+	if (!scx_has_subs())
+		return 0;
+
 	/* root holds every cap on every cpu */
 	if (!sch->level)
 		return 0;
@@ -157,6 +169,9 @@ static inline u64 scx_caps_implied(u64 cap)
 /* may @p keep running on @rq's cpu? requires baseline cpu access */
 static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p)
 {
+	if (!scx_has_subs())
+		return true;
+
 	/* a migration-disabled task is let in without caps, keep it likewise */
 	if (unlikely(is_migration_disabled(p)))
 		return true;
-- 
2.55.0

