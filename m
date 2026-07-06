Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5A381AF0;
	Mon,  6 Jul 2026 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302087; cv=none; b=GlNzmwlZj/6jquTwRsjx3pEKzp/M6pMM1xUFQmotVfzkGO+kbVgMrncEFFWGPUJnPiGwz2/CEwFj37XA0EPP1I/cpx34KIPj+JRMFmwbX8RTPlcCxKF4d9BszIEF45x6Lijh7W4yxmdTiYD0jhEX/Q/Grw3PvZ4o66xgFvPqam8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302087; c=relaxed/simple;
	bh=hLZ9nsbTwH5OO4xTbqV5+j8P9mI/CQTFPfGPhvo+Ilk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHtZr/g/QS4ycq7ypLvZThfccj1sFraK64NaG0w8Q1DI8utU8JMcT+P3bvJxYhb+yTiD0N6EY6eEVWJKELjNPWl6rT+XcW9XG/ufQ1K0fZN1p8F8A3XvvSW3Bk2IBO+Ae8DcuF+HBryHmzm935sB2AG3AnD5GuuwzNKnmngQEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V367SQPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V367SQPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FB31F00A3A;
	Mon,  6 Jul 2026 01:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302083;
	bh=TVihpg3b2hFuOJb8u1yrQHrGHpPIV6B731i6btldFHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V367SQPW/lJ24xGjnoM+UHUtkBOExYURZ2TpW5xYIWBoTuIvDlQ4ZidwGt9WTVOBY
	 7Qgcf9wCoKudLeM/j2A0wvVc7i6T2cxr9GTlqric3XbUari8OLaOHwchPVhO7xPo12
	 y26uO7MAh0SDUXjjd5jb0wDe4T3IUBUrXfhdHo4+mnQuxrE+HpzrMXhl3iaPeu2TH9
	 cDCfVInW8dWlXOgHEnDjoejb+vIccpM8NAWw70mcVQ+CWrEKlEBzsatsOAiSLtI5u5
	 kQcNw34sC8MHk/6Jn0It6qKES1s2zBOqKbFE829FZS7VAX1QOsNmwvplqiGSKFfIh1
	 m7ZXrjvkUkpNw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 24/36] sched_ext: Add reject DSQ for cap-rejected dispatches
Date: Sun,  5 Jul 2026 15:40:46 -1000
Message-ID: <20260706014058.439853-25-tj@kernel.org>
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

When a sub-scheduler dispatches a task to a CPU it lacks the required
capability on, the task must be rejected rather than allowed to run.

Add the machinery for that. Each rq gets a reject DSQ, a kernel-internal
holding queue that is never run and that the BPF scheduler cannot reach. An
insert that must be refused is diverted there instead of the local DSQ, and
a deferred requeue then hands the parked tasks back to the BPF scheduler to
re-decide. A cap revoke extends this to already-queued tasks. When the
revoke reaches the cpu's effective caps, the cpu scans its local DSQ and
reenqueues the tasks that no longer qualify.

A migration-disabled task must run on its cpu, so a capless one is admitted
anyway and counted in the new SCX_EV_SUB_FORCED_ADMIT event.

This is preparation for the actual sub-sched cap enforcement. The divert is
wired but inert here.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h   |  15 ++++-
 kernel/sched/ext/ext.c      |  42 ++++++++++--
 kernel/sched/ext/internal.h |  19 +++++-
 kernel/sched/ext/sub.c      | 125 +++++++++++++++++++++++++++++++++++-
 kernel/sched/ext/sub.h      |  49 ++++++++++++++
 kernel/sched/sched.h        |   3 +
 6 files changed, 242 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 75cb8b119fb7..7e3f6b33f4a8 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -58,6 +58,7 @@ enum scx_dsq_id_flags {
 	SCX_DSQ_GLOBAL		= SCX_DSQ_FLAG_BUILTIN | 1,
 	SCX_DSQ_LOCAL		= SCX_DSQ_FLAG_BUILTIN | 2,
 	SCX_DSQ_BYPASS		= SCX_DSQ_FLAG_BUILTIN | 3,
+	SCX_DSQ_REJECT		= SCX_DSQ_FLAG_BUILTIN | 4,	/* internal - see find_dsq_for_dispatch() */
 	SCX_DSQ_LOCAL_ON	= SCX_DSQ_FLAG_BUILTIN | SCX_DSQ_FLAG_LOCAL_ON,
 	SCX_DSQ_LOCAL_CPU_MASK	= 0xffffffffLLU,
 };
@@ -124,7 +125,7 @@ enum scx_ent_flags {
 	SCX_TASK_DEAD		= 5 << SCX_TASK_STATE_SHIFT,
 
 	/*
-	 * Bits 12 and 13 are used to carry reenqueue reason. In addition to
+	 * Bits 12 to 14 are used to carry reenqueue reason. In addition to
 	 * %SCX_ENQ_REENQ flag, ops.enqueue() can also test for
 	 * %SCX_TASK_REENQ_REASON_NONE to distinguish reenqueues.
 	 *
@@ -132,15 +133,17 @@ enum scx_ent_flags {
 	 * KFUNC	reenqueued by scx_bpf_dsq_reenq() and friends
 	 * IMMED	reenqueued due to failed ENQ_IMMED
 	 * PREEMPTED	preempted while running
+	 * CAP		sub-sched cap miss, see p->scx.reenq_reason_*
 	 */
 	SCX_TASK_REENQ_REASON_SHIFT = 12,
-	SCX_TASK_REENQ_REASON_BITS = 2,
+	SCX_TASK_REENQ_REASON_BITS = 3,
 	SCX_TASK_REENQ_REASON_MASK = ((1 << SCX_TASK_REENQ_REASON_BITS) - 1) << SCX_TASK_REENQ_REASON_SHIFT,
 
 	SCX_TASK_REENQ_NONE	= 0 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_KFUNC	= 1 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_IMMED	= 2 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_PREEMPTED = 3 << SCX_TASK_REENQ_REASON_SHIFT,
+	SCX_TASK_REENQ_CAP	= 4 << SCX_TASK_REENQ_REASON_SHIFT,
 
 	/* iteration cursor, not a task */
 	SCX_TASK_CURSOR		= 1 << 31,
@@ -239,6 +242,14 @@ struct sched_ext_entity {
 	 */
 	u64			dsq_vtime;
 
+	/*
+	 * Sub-sched cap rejected reenq context, valid only while
+	 * %SCX_TASK_REENQ_CAP is set. @reenq_reason_caps is the SCX_CAP_* bits
+	 * that were needed but missing. @reenq_reason_cid is the target cid.
+	 */
+	u64			reenq_reason_caps;
+	s32			reenq_reason_cid;
+
 	/*
 	 * If set, reject future sched_setscheduler(2) calls updating the policy
 	 * to %SCHED_EXT with -%EACCES.
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5cac5af757a0..9f41f77cfb17 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -101,6 +101,7 @@ static bool dsq_is_rq_owned(struct scx_dispatch_q *dsq)
 {
 	switch (dsq->id) {
 	case SCX_DSQ_LOCAL:
+	case SCX_DSQ_REJECT:
 		return true;
 	default:
 		return false;
@@ -1275,6 +1276,12 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 {
 	call_task_dequeue(sch, rq, p, 0);
 
+	/* rejected: kick the deferred reenq, skip wakeup/preemption */
+	if (unlikely(dsq->id == SCX_DSQ_REJECT)) {
+		schedule_deferred_locked(rq);
+		return;
+	}
+
 	/*
 	 * Note that @rq's lock may be dropped between this enqueue and @p
 	 * actually getting on CPU. This gives higher-class tasks (e.g. RT)
@@ -1332,7 +1339,12 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 				 struct scx_dispatch_q *dsq, struct task_struct *p,
 				 u64 enq_flags)
 {
-	bool is_rq_owned = dsq_is_rq_owned(dsq);
+	bool is_rq_owned = false;
+
+	if (dsq->id == SCX_DSQ_LOCAL) {
+		dsq = scx_local_or_reject_dsq(sch, rq, p, &enq_flags);
+		is_rq_owned = true;
+	}
 
 	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
 	WARN_ON_ONCE((p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) ||
@@ -1478,7 +1490,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 	}
 }
 
-static void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
+void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 {
 	struct scx_dispatch_q *dsq = p->scx.dsq;
 	bool is_rq_owned = dsq && dsq_is_rq_owned(dsq);
@@ -1568,6 +1580,10 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 	else
 		dsq = find_user_dsq(sch, dsq_id);
 
+	/*
+	 * Built-in DSQs are never inserted into dsq_hash, so REJECT hits the
+	 * error below. It cannot be reached with an ID.
+	 */
 	if (unlikely(!dsq)) {
 		scx_error(sch, "non-existent DSQ 0x%llx", dsq_id);
 		return find_global_dsq(sch, tcpu);
@@ -1693,8 +1709,8 @@ bool scx_rq_online(struct rq *rq)
 	return likely((rq->scx.flags & SCX_RQ_ONLINE) && cpu_active(cpu_of(rq)));
 }
 
-static void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
-				int sticky_cpu)
+void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
+			 int sticky_cpu)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
@@ -2063,7 +2079,7 @@ static void move_local_task_to_local_dsq(struct scx_sched *sch,
 					 struct scx_dispatch_q *src_dsq,
 					 struct rq *dst_rq)
 {
-	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
+	struct scx_dispatch_q *dst_dsq = scx_local_or_reject_dsq(sch, dst_rq, p, &enq_flags);
 
 	/* @dsq is locked and @p is on @dst_rq */
 	lockdep_assert_held(&src_dsq->lock);
@@ -3781,7 +3797,8 @@ static void process_ddsp_deferred_locals(struct rq *rq)
  * another reenq cycle. Repetitions are bounded by %SCX_REENQ_LOCAL_MAX_REPEAT
  * in process_deferred_reenq_locals().
  */
-static bool local_task_should_reenq(struct task_struct *p, u64 *reenq_flags, u32 *reason)
+static bool local_task_should_reenq(struct rq *rq, struct task_struct *p,
+				    u64 *reenq_flags, u32 *reason)
 {
 	bool first;
 
@@ -3797,6 +3814,12 @@ static bool local_task_should_reenq(struct task_struct *p, u64 *reenq_flags, u32
 		return true;
 	}
 
+	if ((*reenq_flags & SCX_REENQ_CAP_REVOKE) &&
+	    scx_task_reenq_on_cap_revoke(rq, p)) {
+		*reason = SCX_TASK_REENQ_CAP;
+		return true;
+	}
+
 	return *reenq_flags & SCX_REENQ_ANY;
 }
 
@@ -3840,7 +3863,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		if (!scx_is_descendant(task_sch, sch))
 			continue;
 
-		if (!local_task_should_reenq(p, &reenq_flags, &reason))
+		if (!local_task_should_reenq(rq, p, &reenq_flags, &reason))
 			continue;
 
 		scx_dispatch_dequeue(rq, p);
@@ -4036,6 +4059,8 @@ static void run_deferred(struct rq *rq)
 
 	if (!list_empty(&rq->scx.deferred_reenq_users))
 		process_deferred_reenq_users(rq);
+
+	scx_reenq_reject(rq);
 }
 
 #ifdef CONFIG_NO_HZ_FULL
@@ -7834,6 +7859,9 @@ void __init init_sched_ext_class(void)
 
 		/* local_dsq's sch will be set during scx_root_enable() */
 		BUG_ON(init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL));
+#ifdef CONFIG_EXT_SUB_SCHED
+		BUG_ON(init_dsq(&rq->scx.reject_dsq, SCX_DSQ_REJECT, NULL));
+#endif
 
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 93c24c5d7515..7cc7e10457d7 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1135,6 +1135,13 @@ struct scx_event_stats {
 	 * from sub_bypass_dsq's.
 	 */
 	s64		SCX_EV_SUB_BYPASS_DISPATCH;
+
+	/*
+	 * The number of times a migration-disabled task lacking the cap for its
+	 * cid was allowed onto the local DSQ. It must run on its pinned CPU, so
+	 * it can't be rejected. The violation is counted here.
+	 */
+	s64		SCX_EV_SUB_FORCED_ADMIT;
 };
 
 #define SCX_EVENTS_LIST(SCX_EVENT)					\
@@ -1150,7 +1157,8 @@ struct scx_event_stats {
 	SCX_EVENT(SCX_EV_BYPASS_DISPATCH);				\
 	SCX_EVENT(SCX_EV_BYPASS_ACTIVATE);				\
 	SCX_EVENT(SCX_EV_INSERT_NOT_OWNED);				\
-	SCX_EVENT(SCX_EV_SUB_BYPASS_DISPATCH)
+	SCX_EVENT(SCX_EV_SUB_BYPASS_DISPATCH);				\
+	SCX_EVENT(SCX_EV_SUB_FORCED_ADMIT)
 
 struct scx_sched;
 
@@ -1270,6 +1278,9 @@ enum scx_cap_flags {
 	__SCX_CAP_ALL			= BIT_U64(__SCX_NR_CAPS) - 1,
 
 	SCX_CAP_DUMMY			= BIT_U64(__SCX_CAP_DUMMY),
+
+	/* caps whose loss strands queued tasks, see scx_process_sync_ecaps() */
+	SCX_CAPS_REENQ_ON_LOSS		= 0,
 };
 
 #ifdef CONFIG_EXT_SUB_SCHED
@@ -1582,6 +1593,9 @@ enum scx_reenq_flags {
 	/* low 16bits determine which tasks should be reenqueued */
 	SCX_REENQ_ANY		= 1LLU << 0,	/* all tasks */
 
+	/* internal: kernel-issued on cap revoke, not accepted from BPF */
+	SCX_REENQ_CAP_REVOKE	= 1LLU << 1,
+
 	__SCX_REENQ_FILTER_MASK	= 0xffffLLU,
 
 	__SCX_REENQ_USER_MASK	= SCX_REENQ_ANY,
@@ -1834,6 +1848,9 @@ void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp);
 void scx_task_iter_unlock(struct scx_task_iter *iter);
 void scx_task_iter_stop(struct scx_task_iter *iter);
 struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
+void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
+void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
+			 int sticky_cpu);
 bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			    struct scx_dispatch_q *dsq, u64 enq_flags);
 bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index deb4c802af83..e79d30aba0cc 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -208,6 +208,116 @@ void scx_init_root_caps(struct scx_sched *sch)
 	}
 }
 
+/**
+ * scx_local_or_reject_dsq - Pick the local or reject DSQ for an insert
+ * @sch: enqueuing sub-sched
+ * @rq: rq whose local DSQ @p targets
+ * @p: task being inserted
+ * @enq_flags: in/out; %SCX_ENQ_IMMED is cleared when diverting to reject
+ *
+ * Return @rq's local DSQ if @sch holds the required caps on @rq's cid,
+ * otherwise @rq's reject DSQ after recording the reenq reason on @p.
+ *
+ * Bypass doesn't need special-casing as a bypassing sched's tasks are enqueued
+ * to and run by its nearest non-bypassing ancestor. If root is bypassing, it
+ * always holds all caps.
+ */
+struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq,
+					       struct task_struct *p, u64 *enq_flags)
+{
+	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
+	u64 missing = scx_missing_caps(sch, cpu_of(rq), scx_caps_for_enq(*enq_flags));
+
+	/* requirements met */
+	if (likely(!missing))
+		return &rq->scx.local_dsq;
+
+	/*
+	 * A migration-disabled task must run on this CPU. Let it run and count
+	 * the violation.
+	 */
+	if (unlikely(is_migration_disabled(p))) {
+		__scx_add_event(sch, SCX_EV_SUB_FORCED_ADMIT, 1);
+		return &rq->scx.local_dsq;
+	}
+
+	p->scx.reenq_reason_caps = missing;
+	p->scx.reenq_reason_cid = cid;
+
+	/*
+	 * Only local DSQ can honor IMMED and dsq_inc_nr() WARNs on IMMED into
+	 * others. Strip both the enq flag and the sticky task flag - the
+	 * latter can carry in from an earlier admitted IMMED insert.
+	 */
+	*enq_flags &= ~SCX_ENQ_IMMED;
+	p->scx.flags &= ~SCX_TASK_IMMED;
+
+	return &rq->scx.reject_dsq;
+}
+
+/* @p lost the caps needed to stay on @rq's local DSQ? Record reason if so. */
+bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p)
+{
+	u64 missing;
+
+	/* migration-disabled tasks are admitted regardless of caps */
+	if (is_migration_disabled(p))
+		return false;
+
+	missing = scx_missing_caps(scx_task_sched(p), cpu_of(rq), scx_caps_for_task(p));
+	if (likely(!missing))
+		return false;
+
+	p->scx.reenq_reason_caps = missing;
+	p->scx.reenq_reason_cid = __scx_cpu_to_cid(cpu_of(rq));
+	return true;
+}
+
+/*
+ * Drain @rq->scx.reject_dsq, reenqueueing each task so the BPF re-decides
+ * from p->scx.reenq_reason_*.
+ *
+ * A task can be re-rejected repeatedly, and there's no repeat limit here.
+ * Rejection can't happen for root, and sub-scheds can be safely ejected after
+ * triggering the stall watchdog.
+ */
+void scx_reenq_reject(struct rq *rq)
+{
+	LIST_HEAD(tasks);
+	struct task_struct *p, *n;
+
+	lockdep_assert_rq_held(rq);
+
+	if (list_empty(&rq->scx.reject_dsq.list))
+		return;
+
+	/*
+	 * Move to a private list so a task re-rejected by the
+	 * scx_do_enqueue_task() below isn't revisited this round.
+	 */
+	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
+		/* migration_pending tasks should have bypassed to local DSQ */
+		if (WARN_ON_ONCE(p->migration_pending))
+			continue;
+
+		scx_dispatch_dequeue(rq, p);
+
+		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
+			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+		p->scx.flags |= SCX_TASK_REENQ_CAP;
+
+		list_add_tail(&p->scx.dsq_list.node, &tasks);
+	}
+
+	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
+		list_del_init(&p->scx.dsq_list.node);
+
+		scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
+
+		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+	}
+}
+
 /* record a caps change, see struct scx_caps_updated */
 static void caps_updated_record(struct scx_pshard *ps, const struct scx_cmask *cids, u64 caps,
 				struct list_head *to_deliver)
@@ -351,6 +461,7 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 	s32 cpu = cpu_of(rq);
 	s32 cid, shard;
 	struct llist_node *batch, *pos, *tmp;
+	u64 lost_all = 0;
 
 	lockdep_assert_rq_held(rq);
 
@@ -379,16 +490,20 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		struct scx_sched_pcpu *pcpu =
 			container_of(pos, struct scx_sched_pcpu, ecaps_to_sync_node);
 		struct scx_pshard *ps = pcpu->sch->pshard[shard];
-		u64 ecaps;
+		u64 old, ecaps, lost;
 
 		init_llist_node(pos);
 
 		/* pairs with smp_mb() in queue_sync_ecaps(), see there */
 		smp_mb();
 
+		old = READ_ONCE(pcpu->ecaps);
 		ecaps = calc_effective_caps(ps, cid);
 		WRITE_ONCE(pcpu->ecaps, ecaps);
 
+		lost = old & ~ecaps;
+		lost_all |= lost;
+
 		/* tell the sched its effective caps on this cid changed */
 		if (ecaps != pcpu->reported_ecaps &&
 		    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
@@ -405,6 +520,14 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 			pcpu->reported_ecaps = ecaps;
 		}
 	}
+
+	/*
+	 * Losing a cap can strand already-queued tasks. Schedule a reenq scan
+	 * to move the now-capless ones off the local DSQ. The scan tests
+	 * against the effective caps and thus must come after the ecaps sync.
+	 */
+	if (lost_all & SCX_CAPS_REENQ_ON_LOSS)
+		scx_schedule_reenq_local(rq, SCX_REENQ_CAP_REVOKE);
 }
 
 /*
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 1f0cef59302c..89d1458ff450 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -33,6 +33,10 @@ void scx_online_ecaps(struct rq *rq);
 void scx_offline_ecaps(struct rq *rq);
 void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu);
 void scx_discard_stale_ecaps_syncs(void);
+struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq,
+					       struct task_struct *p, u64 *enq_flags);
+bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p);
+void scx_reenq_reject(struct rq *rq);
 
 #else	/* CONFIG_EXT_SUB_SCHED */
 
@@ -51,6 +55,9 @@ static inline void scx_online_ecaps(struct rq *rq) {}
 static inline void scx_offline_ecaps(struct rq *rq) {}
 static inline void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu) {}
 static inline void scx_discard_stale_ecaps_syncs(void) {}
+static inline struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq *rq, struct task_struct *p, u64 *enq_flags) { return &rq->scx.local_dsq; }
+static inline bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p) { return false; }
+static inline void scx_reenq_reject(struct rq *rq) {}
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -69,12 +76,54 @@ static inline void scx_discard_stale_ecaps_syncs(void) {}
 
 #ifdef CONFIG_EXT_SUB_SCHED
 
+/**
+ * scx_missing_caps - The caps in @needed that @sch lacks on @cpu
+ * @sch: sched to test
+ * @cpu: cpu to test on
+ * @needed: bitmask of SCX_CAP_* values
+ *
+ * Return the caps in @needed that @sch lacks for @cpu, 0 if it holds them all.
+ */
+static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed)
+{
+	u64 ecaps;
+
+	/* root holds every cap on every cpu */
+	if (!sch->level)
+		return 0;
+
+	ecaps = READ_ONCE(per_cpu_ptr(sch->pcpu, cpu)->ecaps);
+
+	return needed & ~ecaps;
+}
+
+/*
+ * Cap semantics: which caps an action requires, and which caps a cap implies.
+ * Keep all such mappings collected here.
+ */
+
+/* map @enq_flags to the SCX_CAP_* bit required for the local-DSQ insert */
+static inline u64 scx_caps_for_enq(u64 enq_flags)
+{
+	return 0;
+}
+
+/* map queued @p to the SCX_CAP_* bit required to stay on its local DSQ */
+static inline u64 scx_caps_for_task(struct task_struct *p)
+{
+	return 0;
+}
+
 /* caps implied by holding @cap */
 static inline u64 scx_caps_implied(u64 cap)
 {
 	return 0;
 }
 
+#else	/* CONFIG_EXT_SUB_SCHED */
+
+static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed) { return 0; }
+
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 72299c105487..c0a4699a6c0a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -794,6 +794,9 @@ enum scx_rq_flags {
 
 struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
+#ifdef CONFIG_EXT_SUB_SCHED
+	struct scx_dispatch_q	reject_dsq;		/* staging for cap-rejected tasks */
+#endif
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
 	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
 	unsigned long		ops_qseq;
-- 
2.54.0

