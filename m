Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6037701F;
	Fri, 13 Mar 2026 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401478; cv=none; b=c4LfhM4PN7uqe6Ru9PNnE8n1qb9UabNC3LxbylWExDYLLaf4jv7LEQefmsRUQxMnqkT25PWHXmfQPKTjyoQTNcGpuXuO4w1bC9b96YoBJXlcKtHdsJTn8/ZmikvOYSVN1K3YAbfJtmGtSCXT5LUuSTB/V16gZcJFLgYD8svPGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401478; c=relaxed/simple;
	bh=S+xmrgaydifA/bA95vQB5BVlx6H6dEH7GrQbqqc3gI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMswsXsNg4qpwjncDnXn5fQLFcbVchPVdM6IPFiDPwjdnyWRpW3H3TjLmENXv3mgjVjzipyJHcgZXFd+o3YTX3TOaMYhdk5sNOZxiDVWsjdJuliqAl7sfdqRwaG0QiDIknSsy0uZiYhnb2qjJYXGnOuNArv86WiJ4QTbxwhzSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmH6kAvO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmH6kAvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F94DC2BC86;
	Fri, 13 Mar 2026 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773401478;
	bh=S+xmrgaydifA/bA95vQB5BVlx6H6dEH7GrQbqqc3gI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmH6kAvO54zrq6vXMPXEq/SAwQStP85y8FhZ8gJFng8yi1kg2IWiMECFY5aj1p6aB
	 MhQ18ZzFPxgf1eSbtP2aLnsgYELwAaLW0S+qml9xgeN86FrH41mzXfJyBtP5m6/HmW
	 tTX8ctQnQjbODEKCGxKdOrotZB6hBykVCc18MP2Dral2iXd6IxlK+gP/uRv7+E/NCw
	 sVfUMH1blBTdOPXU/dUABdupMuj6WH9btyKZcJ6jP20MrlRc+Ti12grE+JEzld5O7G
	 sMBaMtPXK4NJbc8chwXLfY1ty3uKnOEr4ERCJPIbpc5O0WGqEOghal/gY19BdLFxKy
	 khpuvLHsrII7Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] sched_ext: Implement SCX_ENQ_IMMED
Date: Fri, 13 Mar 2026 01:31:11 -1000
Message-ID: <20260313113114.1591010-4-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313113114.1591010-1-tj@kernel.org>
References: <20260313113114.1591010-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add SCX_ENQ_IMMED enqueue flag for local DSQ insertions. Once a task is
dispatched with IMMED, it either gets on the CPU immediately and stays on it,
or gets reenqueued back to the BPF scheduler. It will never linger on a local
DSQ behind other tasks or on a CPU taken by a higher-priority class.

rq_is_open() uses rq->next_class to determine whether the rq is available,
and wakeup_preempt_scx() triggers reenqueue when a higher-priority class task
arrives. These capture all higher class preemptions. Combined with reenqueue
points in the dispatch path, all cases where an IMMED task would not execute
immediately are covered.

SCX_TASK_IMMED persists in p->scx.flags until the next fresh enqueue, so the
guarantee survives SAVE/RESTORE cycles. If preempted while running,
put_prev_task_scx() reenqueues through ops.enqueue() with
SCX_TASK_REENQ_PREEMPTED instead of silently placing the task back on the
local DSQ.

This enables tighter scheduling latency control by preventing tasks from
piling up on local DSQs. It also enables opportunistic CPU sharing across
sub-schedulers - without this, a sub-scheduler can stuff the local DSQ of a
shared CPU, making it difficult for others to use.

v2: - Rewrite is_curr_done() as rq_is_open() using rq->next_class and
      implement wakeup_preempt_scx() to achieve complete coverage of all
      cases where IMMED tasks could get stranded.
    - Track IMMED persistently in p->scx.flags and reenqueue
      preempted-while-running tasks through ops.enqueue().
    - Bound deferred reenq cycles (SCX_REENQ_LOCAL_MAX_REPEAT).
    - Misc renames, documentation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h                |   5 +
 kernel/sched/ext.c                       | 271 +++++++++++++++++++++--
 kernel/sched/ext_internal.h              |  47 ++++
 kernel/sched/sched.h                     |   2 +
 tools/sched_ext/include/scx/compat.bpf.h |   5 +
 5 files changed, 311 insertions(+), 19 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 60a4f65d0174..602dc83cab36 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -100,6 +100,7 @@ enum scx_ent_flags {
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
+	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
 
 	/*
 	 * Bits 8 and 9 are used to carry task state:
@@ -125,6 +126,8 @@ enum scx_ent_flags {
 	 *
 	 * NONE		not being reenqueued
 	 * KFUNC	reenqueued by scx_bpf_dsq_reenq() and friends
+	 * IMMED	reenqueued due to failed ENQ_IMMED
+	 * PREEMPTED	preempted while running
 	 */
 	SCX_TASK_REENQ_REASON_SHIFT = 12,
 	SCX_TASK_REENQ_REASON_BITS = 2,
@@ -132,6 +135,8 @@ enum scx_ent_flags {
 
 	SCX_TASK_REENQ_NONE	= 0 << SCX_TASK_REENQ_REASON_SHIFT,
 	SCX_TASK_REENQ_KFUNC	= 1 << SCX_TASK_REENQ_REASON_SHIFT,
+	SCX_TASK_REENQ_IMMED	= 2 << SCX_TASK_REENQ_REASON_SHIFT,
+	SCX_TASK_REENQ_PREEMPTED = 3 << SCX_TASK_REENQ_REASON_SHIFT,
 
 	/* iteration cursor, not a task */
 	SCX_TASK_CURSOR		= 1 << 31,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2f59265b9b57..85cdb65a5a66 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -406,6 +406,62 @@ static bool bypass_dsp_enabled(struct scx_sched *sch)
 	return unlikely(atomic_read(&sch->bypass_dsp_enable_depth));
 }
 
+/**
+ * rq_is_open - Is the rq available for immediate execution of an SCX task?
+ * @rq: rq to test
+ * @enq_flags: optional %SCX_ENQ_* of the task being enqueued
+ *
+ * Returns %true if @rq is currently open for executing an SCX task. After a
+ * %false return, @rq is guaranateed to invoke SCX dispatch path at least once
+ * before going to idle and not inserting a task into @rq's local DSQ after a
+ * %false return doesn't cause @rq to stall.
+ */
+static bool rq_is_open(struct rq *rq, u64 enq_flags)
+{
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * A higher-priority class task is either running or in the process of
+	 * waking up on @rq.
+	 */
+	if (sched_class_above(rq->next_class, &ext_sched_class))
+		return false;
+
+	/*
+	 * @rq is either in transition to or in idle and there is no
+	 * higher-priority class task waking up on it.
+	 */
+	if (sched_class_above(&ext_sched_class, rq->next_class))
+		return true;
+
+	/*
+	 * @rq is either picking, in transition to, or running an SCX task.
+	 */
+
+	/*
+	 * If we're in the dispatch path holding rq lock, $curr may or may not
+	 * be ready depending on whether the on-going dispatch decides to extend
+	 * $curr's slice. We say yes here and resolve it at the end of dispatch.
+	 * See balance_one().
+	 */
+	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
+		return true;
+
+	/*
+	 * %SCX_ENQ_PREEMPT clears $curr's slice if on SCX and kicks dispatch,
+	 * so allow it to avoid spuriously triggering reenq on a combined
+	 * PREEMPT|IMMED insertion.
+	 */
+	if (enq_flags & SCX_ENQ_PREEMPT)
+		return true;
+
+	/*
+	 * @rq is either in transition to or running an SCX task and can't go
+	 * idle without another SCX dispatch cycle.
+	 */
+	return false;
+}
+
 /*
  * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
  * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
@@ -1220,6 +1276,16 @@ static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 	}
 }
 
+static void schedule_reenq_local(struct rq *rq, u64 reenq_flags)
+{
+	struct scx_sched *root = rcu_dereference_sched(scx_root);
+
+	if (WARN_ON_ONCE(!root))
+		return;
+
+	schedule_dsq_reenq(root, &rq->scx.local_dsq, reenq_flags);
+}
+
 /**
  * touch_core_sched - Update timestamp used for core-sched task ordering
  * @rq: rq to read clock from, must be locked
@@ -1296,10 +1362,58 @@ static bool scx_dsq_priq_less(struct rb_node *node_a,
 	return time_before64(a->scx.dsq_vtime, b->scx.dsq_vtime);
 }
 
-static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
+static void dsq_inc_nr(struct scx_dispatch_q *dsq, struct task_struct *p, u64 enq_flags)
 {
 	/* scx_bpf_dsq_nr_queued() reads ->nr without locking, use WRITE_ONCE() */
-	WRITE_ONCE(dsq->nr, dsq->nr + delta);
+	WRITE_ONCE(dsq->nr, dsq->nr + 1);
+
+	/*
+	 * Once @p reaches a local DSQ, it can only leave it by being dispatched
+	 * to the CPU or dequeued. In both cases, the only way @p can go back to
+	 * the BPF sched is through enqueueing. If being inserted into a local
+	 * DSQ with IMMED, persist the state until the next enqueueing event in
+	 * do_enqueue_task() so that we can maintain IMMED protection through
+	 * e.g. SAVE/RESTORE cycles and slice extensions.
+	 */
+	if (enq_flags & SCX_ENQ_IMMED) {
+		if (unlikely(dsq->id != SCX_DSQ_LOCAL)) {
+			WARN_ON_ONCE(!(enq_flags & SCX_ENQ_GDSQ_FALLBACK));
+			return;
+		}
+		p->scx.flags |= SCX_TASK_IMMED;
+	}
+
+	if (p->scx.flags & SCX_TASK_IMMED) {
+		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
+
+		if (WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL))
+			return;
+
+		rq->scx.nr_immed++;
+
+		/*
+		 * If @rq already had other tasks or the current task is not
+		 * done yet, @p can't go on the CPU immediately. Re-enqueue.
+		 */
+		if (unlikely(dsq->nr > 1 || !rq_is_open(rq, enq_flags)))
+			schedule_reenq_local(rq, 0);
+	}
+}
+
+static void dsq_dec_nr(struct scx_dispatch_q *dsq, struct task_struct *p)
+{
+	/* see dsq_inc_nr() */
+	WRITE_ONCE(dsq->nr, dsq->nr - 1);
+
+	if (p->scx.flags & SCX_TASK_IMMED) {
+		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
+
+		if (WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL) ||
+		    WARN_ON_ONCE(rq->scx.nr_immed <= 0))
+			return;
+
+		rq->scx.nr_immed--;
+	}
 }
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
@@ -1458,7 +1572,7 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	WRITE_ONCE(dsq->seq, dsq->seq + 1);
 	p->scx.dsq_seq = dsq->seq;
 
-	dsq_mod_nr(dsq, 1);
+	dsq_inc_nr(dsq, p, enq_flags);
 	p->scx.dsq = dsq;
 
 	/*
@@ -1512,7 +1626,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 	}
 
 	list_del_init(&p->scx.dsq_list.node);
-	dsq_mod_nr(dsq, -1);
+	dsq_dec_nr(dsq, p);
 
 	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
 		struct task_struct *first_task;
@@ -1723,10 +1837,18 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
 
-	/* rq migration */
+	/* internal movements - rq migration / RESTORE */
 	if (sticky_cpu == cpu_of(rq))
 		goto local_norefill;
 
+	/*
+	 * Clear persistent TASK_IMMED for fresh enqueues, see dsq_inc_nr().
+	 * Note that exiting and migration-disabled tasks that skip
+	 * ops.enqueue() below will lose IMMED protection unless
+	 * %SCX_OPS_ENQ_EXITING / %SCX_OPS_ENQ_MIGRATION_DISABLED are set.
+	 */
+	p->scx.flags &= ~SCX_TASK_IMMED;
+
 	/*
 	 * If !scx_rq_online(), we already told the BPF scheduler that the CPU
 	 * is offline and are just running the hotplug path. Don't bother the
@@ -2032,6 +2154,30 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 		return false;
 }
 
+static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_flags)
+{
+	/*
+	 * Preemption between SCX tasks is implemented by resetting the victim
+	 * task's slice to 0 and triggering reschedule on the target CPU.
+	 * Nothing to do.
+	 */
+	if (p->sched_class == &ext_sched_class)
+		return;
+
+	/*
+	 * Getting preempted by a higher-priority class. Reenqueue IMMED tasks.
+	 * This captures all preemption cases including:
+	 *
+	 * - A SCX task is currently running.
+	 *
+	 * - @rq is waking from idle due to a SCX task waking to it.
+	 *
+	 * - A higher-priority wakes up while SCX dispatch is in progress.
+	 */
+	if (rq->scx.nr_immed)
+		schedule_reenq_local(rq, 0);
+}
+
 static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 					 struct scx_dispatch_q *src_dsq,
 					 struct rq *dst_rq)
@@ -2049,7 +2195,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 	else
 		list_add_tail(&p->scx.dsq_list.node, &dst_dsq->list);
 
-	dsq_mod_nr(dst_dsq, 1);
+	dsq_inc_nr(dst_dsq, p, enq_flags);
 	p->scx.dsq = dst_dsq;
 
 	local_dsq_post_enq(dst_dsq, p, enq_flags);
@@ -2257,6 +2403,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 			dst_dsq = find_global_dsq(sch, task_cpu(p));
 			dst_rq = src_rq;
+			enq_flags |= SCX_ENQ_GDSQ_FALLBACK;
 		}
 	} else {
 		/* no need to migrate if destination is a non-local DSQ */
@@ -2385,7 +2532,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	if (src_rq != dst_rq &&
 	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
 		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
-				 enq_flags | SCX_ENQ_CLEAR_OPSS);
+				 enq_flags | SCX_ENQ_CLEAR_OPSS | SCX_ENQ_GDSQ_FALLBACK);
 		return;
 	}
 
@@ -2738,6 +2885,19 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	return false;
 
 has_tasks:
+	/*
+	 * @rq may have extra IMMED tasks without reenq scheduled:
+	 *
+	 * - rq_is_open() can't reliably tell when and how slice is going to be
+	 *   modified for $curr and allows IMMED tasks to be queued while
+	 *   dispatch is in progress.
+	 *
+	 * - A non-IMMED HEAD task can get queued in front of an IMMED task
+	 *   between the IMMED queueing and the subsequent scheduling event.
+	 */
+	if (unlikely(rq->scx.local_dsq.nr > 1 && rq->scx.nr_immed))
+		schedule_reenq_local(rq, 0);
+
 	rq->scx.flags &= ~SCX_RQ_IN_BALANCE;
 	return true;
 }
@@ -2859,11 +3019,17 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * If @p has slice left and is being put, @p is getting
 		 * preempted by a higher priority scheduler class or core-sched
 		 * forcing a different task. Leave it at the head of the local
-		 * DSQ.
+		 * DSQ unless it was an IMMED task. IMMED tasks should not
+		 * linger on a busy CPU, reenqueue them to the BPF scheduler.
 		 */
 		if (p->scx.slice && !scx_bypassing(sch, cpu_of(rq))) {
-			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p,
-					 SCX_ENQ_HEAD);
+			if (p->scx.flags & SCX_TASK_IMMED) {
+				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
+				do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
+				p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
+			} else {
+				dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, SCX_ENQ_HEAD);
+			}
 			goto switch_class;
 		}
 
@@ -3682,8 +3848,6 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
 	scx_disable_task(scx_task_sched(p), p);
 }
 
-static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_flags) {}
-
 static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
 
 int scx_check_setscheduler(struct task_struct *p, int policy)
@@ -3725,9 +3889,45 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 	}
 }
 
+/*
+ * Determine whether @p should be reenqueued from a local DSQ.
+ *
+ * @reenq_flags is mutable and accumulates state across the DSQ walk:
+ *
+ * - %SCX_REENQ_TSR_NOT_FIRST: Set after the first task is visited. "First"
+ *   tracks position in the DSQ list, not among IMMED tasks. A non-IMMED task at
+ *   the head consumes the first slot.
+ *
+ * - %SCX_REENQ_TSR_RQ_OPEN: Set by reenq_local() before the walk if
+ *   rq_is_open() is true.
+ *
+ * An IMMED task is kept (returns %false) only if it's the first task in the DSQ
+ * AND the current task is done — i.e. it will execute immediately. All other
+ * IMMED tasks are reenqueued. This means if a non-IMMED task sits at the head,
+ * every IMMED task behind it gets reenqueued.
+ *
+ * Reenqueued tasks go through ops.enqueue() with %SCX_ENQ_REENQ |
+ * %SCX_TASK_REENQ_IMMED. If the BPF scheduler dispatches back to the same local
+ * DSQ with %SCX_ENQ_IMMED while the CPU is still unavailable, this triggers
+ * another reenq cycle. Repetitions are bounded by %SCX_REENQ_LOCAL_MAX_REPEAT
+ * in process_deferred_reenq_locals().
+ */
 static bool local_task_should_reenq(struct task_struct *p, u64 *reenq_flags, u32 *reason)
 {
+	bool first;
+
+	first = !(*reenq_flags & SCX_REENQ_TSR_NOT_FIRST);
+	*reenq_flags |= SCX_REENQ_TSR_NOT_FIRST;
+
 	*reason = SCX_TASK_REENQ_KFUNC;
+
+	if ((p->scx.flags & SCX_TASK_IMMED) &&
+	    (!first || !(*reenq_flags & SCX_REENQ_TSR_RQ_OPEN))) {
+		__scx_add_event(scx_task_sched(p), SCX_EV_REENQ_IMMED, 1);
+		*reason = SCX_TASK_REENQ_IMMED;
+		return true;
+	}
+
 	return *reenq_flags & SCX_REENQ_ANY;
 }
 
@@ -3739,6 +3939,11 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 
 	lockdep_assert_rq_held(rq);
 
+	if (WARN_ON_ONCE(reenq_flags & __SCX_REENQ_TSR_MASK))
+		reenq_flags &= ~__SCX_REENQ_TSR_MASK;
+	if (rq_is_open(rq, 0))
+		reenq_flags |= SCX_REENQ_TSR_RQ_OPEN;
+
 	/*
 	 * The BPF scheduler may choose to dispatch tasks back to
 	 * @rq->scx.local_dsq. Move all candidate tasks off to a private list
@@ -3792,11 +3997,14 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 
 static void process_deferred_reenq_locals(struct rq *rq)
 {
+	u64 seq = ++rq->scx.deferred_reenq_locals_seq;
+
 	lockdep_assert_rq_held(rq);
 
 	while (true) {
 		struct scx_sched *sch;
 		u64 reenq_flags;
+		bool skip = false;
 
 		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
 			struct scx_deferred_reenq_local *drl =
@@ -3811,15 +4019,31 @@ static void process_deferred_reenq_locals(struct rq *rq)
 			sch_pcpu = container_of(drl, struct scx_sched_pcpu,
 						deferred_reenq_local);
 			sch = sch_pcpu->sch;
+
 			reenq_flags = drl->flags;
 			WRITE_ONCE(drl->flags, 0);
 			list_del_init(&drl->node);
+
+			if (likely(drl->seq != seq)) {
+				drl->seq = seq;
+				drl->cnt = 0;
+			} else {
+				if (unlikely(++drl->cnt > SCX_REENQ_LOCAL_MAX_REPEAT)) {
+					scx_error(sch, "SCX_ENQ_REENQ on SCX_DSQ_LOCAL repeated %u times",
+						  drl->cnt);
+					skip = true;
+				}
+
+				__scx_add_event(sch, SCX_EV_REENQ_LOCAL_REPEAT, 1);
+			}
 		}
 
-		/* see schedule_dsq_reenq() */
-		smp_mb();
+		if (!skip) {
+			/* see schedule_dsq_reenq() */
+			smp_mb();
 
-		reenq_local(sch, rq, reenq_flags);
+			reenq_local(sch, rq, reenq_flags);
+		}
 	}
 }
 
@@ -4208,10 +4432,6 @@ static void scx_cgroup_unlock(void) {}
 /*
  * Omitted operations:
  *
- * - wakeup_preempt: NOOP as it isn't useful in the wakeup path because the task
- *   isn't tied to the CPU at that point. Preemption is implemented by resetting
- *   the victim task's slice to 0 and triggering reschedule on the target CPU.
- *
  * - migrate_task_rq: Unnecessary as task to cpu mapping is transient.
  *
  * - task_fork/dead: We need fork/dead notifications for all tasks regardless of
@@ -4580,6 +4800,8 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_DISPATCH_KEEP_LAST);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_EXITING);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_REENQ_IMMED);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_REENQ_LOCAL_REPEAT);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_REFILL_SLICE_DFL);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DURATION);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
@@ -6019,6 +6241,8 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	scx_dump_event(s, &events, SCX_EV_DISPATCH_KEEP_LAST);
 	scx_dump_event(s, &events, SCX_EV_ENQ_SKIP_EXITING);
 	scx_dump_event(s, &events, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
+	scx_dump_event(s, &events, SCX_EV_REENQ_IMMED);
+	scx_dump_event(s, &events, SCX_EV_REENQ_LOCAL_REPEAT);
 	scx_dump_event(s, &events, SCX_EV_REFILL_SLICE_DFL);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DURATION);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
@@ -7532,6 +7756,13 @@ void __init init_sched_ext_class(void)
  */
 static bool scx_vet_enq_flags(struct scx_sched *sch, u64 dsq_id, u64 enq_flags)
 {
+	if ((enq_flags & SCX_ENQ_IMMED) &&
+	    unlikely(dsq_id != SCX_DSQ_LOCAL &&
+		     (dsq_id & SCX_DSQ_LOCAL_ON) != SCX_DSQ_LOCAL_ON)) {
+		scx_error(sch, "SCX_ENQ_IMMED on a non-local DSQ 0x%llx", dsq_id);
+		return false;
+	}
+
 	return true;
 }
 
@@ -9101,6 +9332,8 @@ static void scx_read_events(struct scx_sched *sch, struct scx_event_stats *event
 		scx_agg_event(events, e_cpu, SCX_EV_DISPATCH_KEEP_LAST);
 		scx_agg_event(events, e_cpu, SCX_EV_ENQ_SKIP_EXITING);
 		scx_agg_event(events, e_cpu, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
+		scx_agg_event(events, e_cpu, SCX_EV_REENQ_IMMED);
+		scx_agg_event(events, e_cpu, SCX_EV_REENQ_LOCAL_REPEAT);
 		scx_agg_event(events, e_cpu, SCX_EV_REFILL_SLICE_DFL);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DURATION);
 		scx_agg_event(events, e_cpu, SCX_EV_BYPASS_DISPATCH);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index c78dadaadab8..2ef855f7c861 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -31,6 +31,8 @@ enum scx_consts {
 	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
 	SCX_BYPASS_LB_BATCH		= 256,
 
+	SCX_REENQ_LOCAL_MAX_REPEAT	= 256,
+
 	SCX_SUB_MAX_DEPTH		= 4,
 };
 
@@ -887,6 +889,24 @@ struct scx_event_stats {
 	 */
 	s64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
 
+	/*
+	 * The number of times a task, enqueued on a local DSQ with
+	 * SCX_ENQ_IMMED, was re-enqueued because the CPU was not available for
+	 * immediate execution.
+	 */
+	s64		SCX_EV_REENQ_IMMED;
+
+	/*
+	 * The number of times a reenq of local DSQ caused another reenq of
+	 * local DSQ. This can happen when %SCX_ENQ_IMMED races against a higher
+	 * priority class task even if the BPF scheduler always satisfies the
+	 * prerequisites for %SCX_ENQ_IMMED at the time of enqueue. However,
+	 * that scenario is very unlikely and this count going up regularly
+	 * indicates that the BPF scheduler is handling %SCX_ENQ_REENQ
+	 * incorrectly causing recursive reenqueues.
+	 */
+	s64		SCX_EV_REENQ_LOCAL_REPEAT;
+
 	/*
 	 * Total number of times a task's time slice was refilled with the
 	 * default value (SCX_SLICE_DFL).
@@ -951,6 +971,8 @@ struct scx_dsp_ctx {
 struct scx_deferred_reenq_local {
 	struct list_head	node;
 	u64			flags;
+	u64			seq;
+	u32			cnt;
 };
 
 struct scx_sched_pcpu {
@@ -1074,6 +1096,24 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_PREEMPT		= 1LLU << 32,
 
+	/*
+	 * Only allowed on local DSQs. Guarantees that the task either gets
+	 * on the CPU immediately and stays on it, or gets reenqueued back
+	 * to the BPF scheduler. It will never linger on a local DSQ or be
+	 * silently put back after preemption.
+	 *
+	 * The protection persists until the next fresh enqueue - it
+	 * survives SAVE/RESTORE cycles, slice extensions and preemption.
+	 * If the task can't stay on the CPU for any reason, it gets
+	 * reenqueued back to the BPF scheduler.
+	 *
+	 * Exiting and migration-disabled tasks bypass ops.enqueue() and
+	 * are placed directly on a local DSQ without IMMED protection
+	 * unless %SCX_OPS_ENQ_EXITING and %SCX_OPS_ENQ_MIGRATION_DISABLED
+	 * are set respectively.
+	 */
+	SCX_ENQ_IMMED		= 1LLU << 33,
+
 	/*
 	 * The task being enqueued was previously enqueued on a DSQ, but was
 	 * removed and is being re-enqueued. See SCX_TASK_REENQ_* flags to find
@@ -1098,6 +1138,7 @@ enum scx_enq_flags {
 	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
 	SCX_ENQ_DSQ_PRIQ	= 1LLU << 57,
 	SCX_ENQ_NESTED		= 1LLU << 58,
+	SCX_ENQ_GDSQ_FALLBACK	= 1LLU << 59,	/* fell back to global DSQ */
 };
 
 enum scx_deq_flags {
@@ -1127,6 +1168,12 @@ enum scx_reenq_flags {
 	__SCX_REENQ_FILTER_MASK	= 0xffffLLU,
 
 	__SCX_REENQ_USER_MASK	= SCX_REENQ_ANY,
+
+	/* bits 32-35 used by task_should_reenq() */
+	SCX_REENQ_TSR_RQ_OPEN	= 1LLU << 32,
+	SCX_REENQ_TSR_NOT_FIRST	= 1LLU << 33,
+
+	__SCX_REENQ_TSR_MASK	= 0xfLLU << 32,
 };
 
 enum scx_pick_idle_cpu_flags {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 60627119d0ab..5b93f6190d31 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -800,6 +800,7 @@ struct scx_rq {
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
 	bool			cpu_released;
 	u32			flags;
+	u32			nr_immed;		/* ENQ_IMMED tasks on local_dsq */
 	u64			clock;			/* current per-rq clock -- see scx_bpf_now() */
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
@@ -810,6 +811,7 @@ struct scx_rq {
 	struct task_struct	*sub_dispatch_prev;
 
 	raw_spinlock_t		deferred_reenq_lock;
+	u64			deferred_reenq_locals_seq;
 	struct list_head	deferred_reenq_locals;	/* scheds requesting reenq of local DSQ */
 	struct list_head	deferred_reenq_users;	/* user DSQs requesting reenq */
 	struct balance_callback	deferred_bal_cb;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 704728864d83..cba37432eec0 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -404,6 +404,11 @@ static inline void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags)
 		scx_bpf_error("kernel too old to reenqueue foreign local or user DSQs");
 }
 
+/*
+ * v7.1: %SCX_ENQ_IMMED.
+ */
+#define SCX_ENQ_IMMED	__COMPAT_ENUM_OR_ZERO(enum scx_enq_flags, SCX_ENQ_IMMED)
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.53.0

