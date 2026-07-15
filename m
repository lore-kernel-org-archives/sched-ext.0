Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE173D890C;
	Wed, 15 Jul 2026 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159500; cv=none; b=pDOW5DvbceX0Rf4876U6gjvk3/SMjdc2aRilcBIq3iGaxZPgstabryCvCDOKwMig9AZTyFppuraOm8EVo+9UdMmQqCDsv/0lQJ1QxlWWpo4WV41nqCYsMGpuM2hKmHKgfPtVuYZcmiidfmAiKohv7VnDgJmqSSUIPfRd7bEeBGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159500; c=relaxed/simple;
	bh=eth3c5d4kCUiSrwocH57y3r/tOG8mjTgNLh45a/cgyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6TPxWQsZ203OXFro06+l1xhh7dOwlc2nvM7+/jDMCrqBuOfjT54ObW64UgCzpDDflU3LufzOWG3CoLXOiVfZIS7jLMs6YzuLJ2aKV6wMANkHPE41o97Wbhpo9bS8SP6pxdxrLRR/vzUGxWzjTTKobvq4gz9+8wDtq+GfY7ZJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbYWc8jg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbYWc8jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D18F1F000E9;
	Wed, 15 Jul 2026 23:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159498;
	bh=3FNit7c2b6v5DM5WAC1NUe5289fBUQfEiKTFoKa5f8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JbYWc8jgX4tiPPzkqlrm8/tDNLl8D3lB4fp38ueedI++Iwf5TJ5uu11n8xAxrI97D
	 3B+Vm2TagmFnFJLHVsTqHl3YMFVj+TUxxdaY51JwxsnfUhZZwjTItNu1i1BUUdkklw
	 lRXVF05zYE4moBzmQ2wZqf9Wr/4dcaIcGVyzJiQrJjyfqWgiOmaPkP5Js7d/aT/JhS
	 NwhCmpZcfJXmPPcCGogHw/Zhex5yurLnUWRfuxIGPd8icZuGa2pB8hSLWSNKpjH3jz
	 5133tgaoms18bUcrOLScXVdNekz9Mr/ODPVdmsBmNDAdZ8Fga3MQT9DPhpv418t1QU
	 uOev0NWHDycFg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] sched_ext: Add the scx_has_subs static key and gate sub-sched hot paths
Date: Wed, 15 Jul 2026 13:51:33 -1000
Message-ID: <20260715235133.810434-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715235133.810434-1-tj@kernel.org>
References: <20260715235133.810434-1-tj@kernel.org>
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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c      |  4 ++++
 kernel/sched/ext/idle.c     | 10 ++++++++++
 kernel/sched/ext/internal.h | 19 +++++++++++++++++--
 kernel/sched/ext/sub.c      | 21 +++++++++++++++++++--
 kernel/sched/ext/sub.h      | 15 +++++++++++++++
 5 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f9958b8bd8f4..b3b8cf95e0f7 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4920,6 +4920,10 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
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
index d7a1d6a14ebf..4f4130f0d121 100644
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
index 0875659d43c7..3cc6d2633f73 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -22,6 +22,12 @@
 
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
@@ -236,6 +242,9 @@ void scx_init_root_caps(struct scx_sched *sch)
 struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq,
 					       struct task_struct *p, u64 *enq_flags)
 {
+	if (!scx_has_subs())
+		return &rq->scx.local_dsq;
+
 	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
 	struct scx_sched *asch = rq->scx.remote_activate_sch ?: sch;
 	u64 needed = scx_caps_for_enq(*enq_flags);
@@ -314,7 +323,7 @@ void scx_reenq_reject(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
-	if (list_empty(&rq->scx.reject_dsq.list))
+	if (!scx_has_subs() || list_empty(&rq->scx.reject_dsq.list))
 		return;
 
 	/*
@@ -497,7 +506,7 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 
 	lockdep_assert_rq_held(rq);
 
-	if (likely(llist_empty(&rq->scx.ecaps_to_sync)))
+	if (!scx_has_subs() || likely(llist_empty(&rq->scx.ecaps_to_sync)))
 		return;
 
 	/*
@@ -1016,10 +1025,18 @@ void scx_sub_enable_workfn(struct kthread_work *work)
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
index 0db2d2ea0fd1..625d7ce334aa 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -44,6 +44,13 @@ static inline const char *sch_cgrp_path(struct scx_sched *sch)
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
@@ -66,6 +73,7 @@ static inline void scx_discard_stale_ecaps_syncs(void) {}
 static inline struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq, struct task_struct *p, u64 *enq_flags) { return &rq->scx.local_dsq; }
 static inline bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p) { return false; }
 static inline void scx_reenq_reject(struct rq *rq) {}
+static inline void scx_dec_has_subs(struct scx_sched *sch) {}
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -96,6 +104,10 @@ static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed)
 {
 	u64 ecaps;
 
+	/* no sub-scheds, no missing caps */
+	if (!scx_has_subs())
+		return 0;
+
 	/* root holds every cap on every cpu */
 	if (!sch->level)
 		return 0;
@@ -156,6 +168,9 @@ static inline u64 scx_caps_implied(u64 cap)
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

