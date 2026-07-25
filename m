Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20883009CB;
	Sat, 25 Jul 2026 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785005468; cv=none; b=tJAESS/51dqF4BT20ttCnm262KoNe7vztk6UBoPhdzR29DR3LR3EGbCybJzq19FjpySjuHP1rxPSUrTHOQ7x/1acc07s5+Z/j34GMwprvFkm42yR4KYWsjo/0pS/VXuw6OJmbIAAyhteOOx0upMra9Bhoi3pZLgqJ7znWpKrDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785005468; c=relaxed/simple;
	bh=xbmh9B7axmRUGEhseIxWIhlw74ryl7NoNZLGc9N6/FY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=bF67LMkEkMkwDAJoLgTRS5z5LG47MaC8XM9G+/rHKkw0lKR8PGuDt6kA3y8ymdBbU41jAaY6z3HFhyOTMPLIJ3oA+TrW68nisCPkBVZfGu/y4sWs3q7aeGuEQUTMXLl8gFBz8erkubK2I5hqnyy/sarV1BwNrqECb/9DG4/BvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZyVB6Mv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZyVB6Mv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C021F000E9;
	Sat, 25 Jul 2026 18:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785005466;
	bh=5+EeWz2Ak6A3Zcvi8sTKFnHB33dbw2gWKPfuuH/6NAk=;
	h=Date:From:To:Cc:Subject;
	b=CZyVB6MvdQZQ4/IBJ3lS5IMOBFKvmLMM8ddpP3JBdRACVVczJaiF3NiBOvSYOI4wB
	 YofPXMIfpHZCP8NwrQG9zpGJItJjkTV6aVTyzbuz913G/tU1ESQOqnaZtspkrPYkd9
	 5D9SIeaicsVHRorK1nBdqRIW0ezuzWoeXo6vpgNHfQuGefauoaSLuTL+7OIzI5STKd
	 zwIARy+OXZaIFQI0rSkN0DQRbttw6cH7pFj6F0u4328I6q1gTbligK1FV/iQqMTZwv
	 9GlA7d0hPjUGA69KdV2rClNtFX51HLYPqHja48NkGYCjvF1tHVrMSjd+safka9tluN
	 +d/KOanF7e2Hw==
Date: Sat, 25 Jul 2026 08:51:05 -1000
Message-ID: <7f80005b54904a9a037822c2df5bcbc2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
    Andrea Righi <arighi@nvidia.com>,
    Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
    Emil Tsalapatis <emil@etsalapatis.com>,
    linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3] sched_ext: Bound per-task reenqueues and eject the owning scheduler
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Unlike local reenqueues, cap rejections have no repeat limit. A
malfunctioning scheduler can keep re-inserting a task to a cid it lacks caps
on, cycling the task through reject and reenqueue. This was assumed safe
because a task that never runs trips the stall watchdog. However, the
reenqueue irq_work re-arms itself and outranks the timer vector, blocking
everything else on the CPU including stall detection and recovery, until the
NMI hardlockup detector fires.

Local reenqueues already have a repeat cap, SCX_REENQ_LOCAL_MAX_REPEAT,
which needs generalizing to cover all reenqueues. It also has an attribution
problem. Counted per-cpu on root, it tears down the whole hierarchy for a
sub-owned bounce.

Generalize by bounding every reenqueue with one per-task counter. reenq_cnt
is bumped in scx_do_enqueue_task() on each SCX_ENQ_REENQ, the single funnel
every reenqueue producer passes through, and cleared in clr_task_runnable()
when the task is picked to run. Past SCX_REENQ_MAX_REPEAT the task's owning
scheduler is ejected with a new SCX_EXIT_ERROR_REENQ and the task is left
stranded to be picked up during sched exit.

The SCX_EV_REENQ_LOCAL_REPEAT event becomes SCX_EV_REENQ_REPEAT, counting
reenqueues from all sources.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h   |    1
 kernel/sched/ext/ext.c      |   56 +++++++++++++++++++++++++-------------------
 kernel/sched/ext/internal.h |   19 ++++++--------
 kernel/sched/ext/sub.c      |    6 ++--
 kernel/sched/ext/types.h    |    2 -
 kernel/sched/sched.h        |    1 
 6 files changed, 45 insertions(+), 40 deletions(-)

--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -198,6 +198,7 @@ struct sched_ext_entity {
 	u32			dsq_flags;	/* protected by DSQ lock */
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
+	u32			reenq_cnt;	/* reenqueues since last run */
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	s32			selected_cpu;
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1892,6 +1892,23 @@ void scx_do_enqueue_task(struct rq *rq,
 	p->scx.flags &= ~SCX_TASK_IMMED;
 
 	/*
+	 * A task reenqueued too many times without running means the scheduler
+	 * keeps re-deciding a placement it can't honor, e.g. re-inserting to a
+	 * cid it lacks caps on. Eject the owning scheduler and strand the task
+	 * to be picked up during sched exit.
+	 */
+	if (enq_flags & SCX_ENQ_REENQ) {
+		__scx_add_event(sch, SCX_EV_REENQ_REPEAT, 1);
+
+		if (unlikely(++p->scx.reenq_cnt > SCX_REENQ_MAX_REPEAT)) {
+			__scx_exit(sch, SCX_EXIT_ERROR_REENQ, 0, cpu_of(rq),
+				   "%s[%d] reenqueued %u times without running",
+				   p->comm, p->pid, p->scx.reenq_cnt);
+			return;
+		}
+	}
+
+	/*
 	 * If !scx_rq_online(), we already told the BPF scheduler that the CPU
 	 * is offline and are just running the hotplug path. Don't bother the
 	 * BPF scheduler.
@@ -2013,8 +2030,10 @@ static void clr_task_runnable(struct tas
 {
 	list_del_init(&p->scx.runnable_node);
 	WRITE_ONCE(p->scx.runnable_cpu, -1);
-	if (reset_runnable_at)
+	if (reset_runnable_at) {
 		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
+		p->scx.reenq_cnt = 0;
+	}
 }
 
 static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_flags)
@@ -4053,8 +4072,8 @@ static void process_ddsp_deferred_locals
  * Reenqueued tasks go through ops.enqueue() with %SCX_ENQ_REENQ |
  * %SCX_TASK_REENQ_IMMED. If the BPF scheduler dispatches back to the same local
  * DSQ with %SCX_ENQ_IMMED while the CPU is still unavailable, this triggers
- * another reenq cycle. Repetitions are bounded by %SCX_REENQ_LOCAL_MAX_REPEAT
- * in process_deferred_reenq_locals().
+ * another reenq cycle. Repetitions are bounded by %SCX_REENQ_MAX_REPEAT
+ * in scx_do_enqueue_task(), which ejects the task's owning scheduler.
  */
 static bool local_task_should_reenq(struct rq *rq, struct task_struct *p,
 				    u64 *reenq_flags, u32 *reason)
@@ -4162,14 +4181,16 @@ static u32 reenq_local(struct scx_sched
 
 static void process_deferred_reenq_locals(struct rq *rq)
 {
-	u64 seq = ++rq->scx.deferred_reenq_locals_seq;
-
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * A task can be re-queued within this loop when a reenqueued task
+	 * bounces straight back to the local DSQ. That recursion is bounded by
+	 * the per-task reenqueue cap in scx_do_enqueue_task().
+	 */
 	while (true) {
 		struct scx_sched *sch;
 		u64 reenq_flags;
-		bool skip = false;
 
 		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
 			struct scx_deferred_reenq_local *drl =
@@ -4188,27 +4209,12 @@ static void process_deferred_reenq_local
 			reenq_flags = drl->flags;
 			WRITE_ONCE(drl->flags, 0);
 			list_del_init(&drl->node);
-
-			if (likely(drl->seq != seq)) {
-				drl->seq = seq;
-				drl->cnt = 0;
-			} else {
-				if (unlikely(++drl->cnt > SCX_REENQ_LOCAL_MAX_REPEAT)) {
-					scx_error(sch, "SCX_ENQ_REENQ on SCX_DSQ_LOCAL repeated %u times",
-						  drl->cnt);
-					skip = true;
-				}
-
-				__scx_add_event(sch, SCX_EV_REENQ_LOCAL_REPEAT, 1);
-			}
 		}
 
-		if (!skip) {
-			/* see schedule_dsq_reenq() */
-			smp_mb();
+		/* see schedule_dsq_reenq() */
+		smp_mb();
 
-			reenq_local(sch, rq, reenq_flags);
-		}
+		reenq_local(sch, rq, reenq_flags);
 	}
 }
 
@@ -5925,6 +5931,8 @@ static const char *scx_exit_reason(enum
 		return "scx_bpf_error";
 	case SCX_EXIT_ERROR_STALL:
 		return "runnable task stall";
+	case SCX_EXIT_ERROR_REENQ:
+		return "reenqueue limit";
 	default:
 		return "<UNKNOWN>";
 	}
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -56,6 +56,7 @@ enum scx_exit_kind {
 	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
 	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
 	SCX_EXIT_ERROR_STALL,	/* watchdog detected stalled runnable tasks */
+	SCX_EXIT_ERROR_REENQ,	/* a task hit the reenqueue repeat limit without running */
 };
 
 /*
@@ -1119,15 +1120,13 @@ struct scx_event_stats {
 	s64		SCX_EV_REENQ_IMMED;
 
 	/*
-	 * The number of times a reenq of local DSQ caused another reenq of
-	 * local DSQ. This can happen when %SCX_ENQ_IMMED races against a higher
-	 * priority class task even if the BPF scheduler always satisfies the
-	 * prerequisites for %SCX_ENQ_IMMED at the time of enqueue. However,
-	 * that scenario is very unlikely and this count going up regularly
-	 * indicates that the BPF scheduler is handling %SCX_ENQ_REENQ
-	 * incorrectly causing recursive reenqueues.
+	 * The number of times a task was reenqueued (%SCX_ENQ_REENQ) without
+	 * having run in between. This count climbing rapidly indicates that the
+	 * BPF scheduler keeps re-deciding placements it can't honor. A single
+	 * task reenqueued more than %SCX_REENQ_MAX_REPEAT times gets its owning
+	 * scheduler ejected.
 	 */
-	s64		SCX_EV_REENQ_LOCAL_REPEAT;
+	s64		SCX_EV_REENQ_REPEAT;
 
 	/*
 	 * Total number of times a task's time slice was refilled with the
@@ -1202,7 +1201,7 @@ struct scx_event_stats {
 	SCX_EVENT(SCX_EV_ENQ_SKIP_EXITING);				\
 	SCX_EVENT(SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);			\
 	SCX_EVENT(SCX_EV_REENQ_IMMED);					\
-	SCX_EVENT(SCX_EV_REENQ_LOCAL_REPEAT);				\
+	SCX_EVENT(SCX_EV_REENQ_REPEAT);					\
 	SCX_EVENT(SCX_EV_REFILL_SLICE_DFL);				\
 	SCX_EVENT(SCX_EV_SLICE_CLAMPED);				\
 	SCX_EVENT(SCX_EV_SLICE_DENIED);					\
@@ -1238,8 +1237,6 @@ struct scx_dsp_ctx {
 struct scx_deferred_reenq_local {
 	struct list_head	node;
 	u64			flags;
-	u64			seq;
-	u32			cnt;
 };
 
 struct scx_sched_pcpu {
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -319,9 +319,9 @@ bool scx_task_reenq_on_cap_revoke(struct
  * Drain @rq->scx.reject_dsq, reenqueueing each task so the BPF re-decides
  * from p->scx.reenq_reason_*.
  *
- * A task can be re-rejected repeatedly, and there's no repeat limit here.
- * Rejection can't happen for root, and sub-scheds can be safely ejected after
- * triggering the stall watchdog.
+ * A task can be re-rejected repeatedly. The reenqueue is bounded per task in
+ * scx_do_enqueue_task(), which ejects the owning sub past SCX_REENQ_MAX_REPEAT.
+ * Rejection can't happen for root.
  */
 void scx_reenq_reject(struct rq *rq)
 {
--- a/kernel/sched/ext/types.h
+++ b/kernel/sched/ext/types.h
@@ -41,7 +41,7 @@ enum scx_consts {
 	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
 	SCX_BYPASS_LB_BATCH		= 256,
 
-	SCX_REENQ_LOCAL_MAX_REPEAT	= 256,
+	SCX_REENQ_MAX_REPEAT		= 256,
 
 	SCX_SUB_MAX_DEPTH		= 4,
 };
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -823,7 +823,6 @@ struct scx_rq {
 	struct list_head	sched_pcpus_to_kick;	/* see kick_cpus_irq_workfn() */
 
 	raw_spinlock_t		deferred_reenq_lock;
-	u64			deferred_reenq_locals_seq;
 	struct list_head	deferred_reenq_locals;	/* scheds requesting reenq of local DSQ */
 	struct list_head	deferred_reenq_users;	/* user DSQs requesting reenq */
 	struct balance_callback	deferred_bal_cb;
