Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE9A175A8B;
	Sun, 16 Aug 2026 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838731; cv=none; b=ZMH9G2Gdr+52M90WuCgfbn6t5wREqyjzbcvJy9J6oG/1JHNaxfsIuDNIOYp1I1Q6t/jA08N89tjSfg3OEbsqZTfJlh+ggfjFwR4JRqFBVjTeo5RFwfwbxBOVGFWDalUytqdsZsl3EjZZ+0K7R5uIOPMgkbJL2I8KVDo6d1jHehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838731; c=relaxed/simple;
	bh=MhSgFCW/763q4trYgncxtz8H1VeTyaIDpP7GKQhhgbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t41tnzWewcsmYi1+s6mOLVOEHQhljLiZ1zCL8ZX/47ku4oa7vDs8xHqKN8Qu6eMQzTfC+AdJ5qmGhsxyl6GDfz8KDHXd/KNisUtkwBziYMGNIH+K6CQ171WCiuzSfAhc03E2p0OywpxWOqSiYkqBFFj5ct0AATthY3VCNptNH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etLcHH6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etLcHH6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B874B1F000E9;
	Sun, 16 Aug 2026 00:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786838729;
	bh=0QUTh52fq1uqH6PxyCa+anYJGc9s+qP8JcforFFb0ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=etLcHH6ch2DqavLAMuJqHGdr4bQ0lUwSVSq4kRn9PXZIl2TtYz44c7u+1k0/zVJzR
	 YYfXevnDDcQxI1KaWIrFTii4PN7jq8BV9KldwgkmhaJz/eO9SHoMpehiDFQ+Cs/vIW
	 y85wa5CkxHrP0x4IF920jjW1YC2eCtVtuUeHJxCHOq5tk9MR4OIG2jH2hG2ON7wdmE
	 1xDkFoRajbztvAQLkwC8eiGK/2GmL2WR81uZ0p4WumBQjqFzfvmROJS4Remaof/LOs
	 ow7t5xWuDRxoqG2mKA9HN6MDS4hQLbpL6rc7qIsu+bLZW7QwCSm6pA+5eLK9AHM154
	 9kgVilkuQUgRg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] sched_ext: Use runnable_at for the default core-sched task ordering
Date: Sat, 15 Aug 2026 14:05:25 -1000
Message-ID: <20260816000527.988170-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816000527.988170-1-tj@kernel.org>
References: <20260816000527.988170-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default core-sched ordering runs the longest waiting task first by
comparing p->scx.core_sched_at stamps. The stamp is maintained under two
rules. touch_core_sched() stamps when a task starts waiting for a CPU and
when its slice runs out. If the scheduler implements
ops.core_sched_before(), touch_core_sched_dispatch() re-stamps on every
dispatch.

A comparison can see one stamp taken under each rule, which isn't a
meaningful ordering. The dispatch rule also buys little - it only aligns
bypass-mode comparisons with the local DSQ order. Multiple schedulers make
the mixed comparisons more common.

Wait time is what p->scx.runnable_at already tracks for the stall watchdog.
Delete core_sched_at with both touch functions and compare runnable_at in
the scx_prio_less() fallback.

runnable_at is refreshed only on enqueue and goes stale while a task keeps
occupying its CPU. Instead of re-stamping, order a running task after every
waiting task as it is the most recently serviced.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |   3 --
 kernel/sched/ext/ext.c    | 105 +++++++++-----------------------------
 2 files changed, 25 insertions(+), 83 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index a3ec980e2925..582d7cd4a983 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -212,9 +212,6 @@ struct sched_ext_entity {
 	struct list_head	runnable_node;	/* rq->scx.runnable_list */
 	unsigned long		runnable_at;
 
-#ifdef CONFIG_SCHED_CORE
-	u64			core_sched_at;	/* see scx_prio_less() */
-#endif
 #ifdef CONFIG_EXT_SUB_SCHED
 	unsigned long		rescue_at;	/* queued on a rescue DSQ at, jiffies */
 #endif
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ddf448d526e4..3df2e084d580 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1155,53 +1155,6 @@ void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 		schedule_deferred(rq);
 }
 
-/**
- * touch_core_sched - Update timestamp used for core-sched task ordering
- * @rq: rq to read clock from, must be locked
- * @p: task to update the timestamp for
- *
- * Update @p->scx.core_sched_at timestamp. This is used by scx_prio_less() to
- * implement global or local-DSQ FIFO ordering for core-sched. Should be called
- * when a task becomes runnable and its turn on the CPU ends (e.g. slice
- * exhaustion).
- */
-static void touch_core_sched(struct rq *rq, struct task_struct *p)
-{
-	lockdep_assert_rq_held(rq);
-
-#ifdef CONFIG_SCHED_CORE
-	/*
-	 * It's okay to update the timestamp spuriously. Use
-	 * sched_core_disabled() which is cheaper than enabled().
-	 *
-	 * As this is used to determine ordering between tasks of sibling CPUs,
-	 * it may be better to use per-core dispatch sequence instead.
-	 */
-	if (!sched_core_disabled())
-		p->scx.core_sched_at = sched_clock_cpu(cpu_of(rq));
-#endif
-}
-
-/**
- * touch_core_sched_dispatch - Update core-sched timestamp on dispatch
- * @rq: rq to read clock from, must be locked
- * @p: task being dispatched
- *
- * If the BPF scheduler implements custom core-sched ordering via
- * ops.core_sched_before(), @p->scx.core_sched_at is used to implement FIFO
- * ordering within each local DSQ. This function is called from dispatch paths
- * and updates @p->scx.core_sched_at if custom core-sched ordering is in effect.
- */
-static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
-{
-	lockdep_assert_rq_held(rq);
-
-#ifdef CONFIG_SCHED_CORE
-	if (unlikely(SCX_HAS_OP(scx_root, core_sched_before)))
-		touch_core_sched(rq, p);
-#endif
-}
-
 /*
  * p->scx.slice_oob packs an out-of-band slice request into one atomic64. A zero
  * word means no request. Otherwise the fields are:
@@ -1446,11 +1399,8 @@ static void update_curr_scx(struct rq *rq)
 	if (unlikely(delta_exec <= 0))
 		return;
 
-	if (curr->scx.slice != SCX_SLICE_INF) {
+	if (curr->scx.slice != SCX_SLICE_INF)
 		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
-		if (!curr->scx.slice)
-			touch_core_sched(rq, curr);
-	}
 
 	if (unlikely(curr == scx_rescuee(rq)))
 		scx_rescue_charge(rq, delta_exec);
@@ -1963,8 +1913,6 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 		find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, task_cpu(p));
 	u64 ddsp_enq_flags, slice, vtime;
 
-	touch_core_sched_dispatch(rq, p);
-
 	p->scx.ddsp_enq_flags |= enq_flags;
 
 	/*
@@ -2143,12 +2091,6 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	goto enqueue;
 
 enqueue:
-	/*
-	 * For task-ordering, slice refill must be treated as implying the end
-	 * of the current slice. Otherwise, the longer @p stays on the CPU, the
-	 * higher priority it becomes from scx_prio_less()'s POV.
-	 */
-	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
 	clear_direct_dispatch(p);
 	scx_dispatch_enqueue(sch, rq, dsq, p, 0, 0, enq_flags);
@@ -2226,9 +2168,6 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p))
 		SCX_CALL_OP_TASK(sch, runnable, rq, p, enq_flags);
 
-	if (enq_flags & SCX_ENQ_WAKEUP)
-		touch_core_sched(rq, p);
-
 	/* Start dl_server if this is the first task being enqueued */
 	if (rq->scx.nr_running == 1)
 		dl_server_start(&rq->ext_server);
@@ -2886,7 +2825,6 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq, struct task_st
 	struct scx_dispatch_q *dsq;
 	unsigned long opss;
 
-	touch_core_sched_dispatch(rq, p);
 retry:
 	/*
 	 * No need for _acquire here. @p is accessed only after a successful
@@ -3521,13 +3459,10 @@ void ext_server_init(struct rq *rq)
  * usual sched_class'es and needs to find out the expected task ordering. For
  * SCX, core-sched calls this function to interrogate the task ordering.
  *
- * Unless overridden by ops.core_sched_before(), @p->scx.core_sched_at is used
- * to implement the default task ordering. The older the timestamp, the higher
- * priority the task - the global FIFO ordering matching the default scheduling
- * behavior.
- *
- * When ops.core_sched_before() is enabled, @p->scx.core_sched_at is used to
- * implement FIFO ordering within each local DSQ. See pick_task_scx().
+ * Unless overridden by ops.core_sched_before(), the default task ordering runs
+ * the task which has been waiting longer first. A running task counts as the
+ * most recently serviced and orders after every waiting task. Waiting tasks are
+ * compared by @p->scx.runnable_at.
  *
  * Return: %true if @a should run after @b.
  */
@@ -3536,6 +3471,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 {
 	struct scx_sched *sch_a = scx_task_sched(a);
 	struct scx_sched *sch_b = scx_task_sched(b);
+	bool a_running, b_running;
 
 	/*
 	 * scx_prio_less() returns whether @a should run after @b while
@@ -3552,8 +3488,19 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 					      task_rq(a),
 					      (struct task_struct *)b,
 					      (struct task_struct *)a);
-	else
-		return time_after64(a->scx.core_sched_at, b->scx.core_sched_at);
+
+	/*
+	 * runnable_at is refreshed only on enqueue, so a task which keeps
+	 * occupying its CPU carries a stale stamp. A running task is the most
+	 * recently serviced whatever its stamp says. Order it after every
+	 * waiting task.
+	 */
+	a_running = a->on_cpu;
+	b_running = b->on_cpu;
+	if (a_running != b_running)
+		return a_running;
+
+	return time_after(a->scx.runnable_at, b->scx.runnable_at);
 }
 #endif	/* CONFIG_SCHED_CORE */
 
@@ -3824,15 +3771,13 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	update_curr_scx(rq);
 
 	/*
-	 * While disabling, always resched and refresh core-sched timestamp as
-	 * we can't trust the slice management or ops.core_sched_before().
+	 * While disabling, always resched as we can't trust the slice
+	 * management.
 	 */
-	if (scx_bypassing(sch, cpu_of(rq))) {
+	if (scx_bypassing(sch, cpu_of(rq)))
 		scx_set_task_slice(curr, 0);
-		touch_core_sched(rq, curr);
-	} else if (SCX_HAS_OP(sch, tick)) {
+	else if (SCX_HAS_OP(sch, tick))
 		SCX_CALL_OP_TASK(sch, tick, rq, curr);
-	}
 
 	if (!curr->scx.slice)
 		resched_curr(rq);
@@ -6085,14 +6030,14 @@ static void unbypass_renotify_idle(struct rq *rq, struct scx_sched *pos,
  *
  * - dispatch_one() does not report %SCX_DSP_PREV on non-zero slice as slice
  *   can't be trusted. Whenever a tick triggers, the running task is rotated to
- *   the tail of the queue with core_sched_at touched.
+ *   the tail of the queue.
  *
  * - pick_next_task() suppresses zero slice warning.
  *
  * - scx_kick_cpu() is disabled to avoid irq_work malfunction during PM
  *   operations.
  *
- * - scx_prio_less() reverts to the default core_sched_at order.
+ * - scx_prio_less() reverts to the default runnable_at order.
  */
 void scx_bypass(struct scx_sched *sch, bool bypass)
 {
-- 
2.55.0

