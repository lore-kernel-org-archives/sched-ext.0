Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96993C4169;
	Sat, 17 Oct 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255563; cv=none; b=kpi6+BM3QVyeCeoAE6VEoOlOTHbhRTKH6IOxMwA9wUgCfILiC9r+dNCkMlvbD92VhlO4bIqTpSUas4M4P4RUWfRQnGl8bzdc7G2YFkviR/uM3Hg+DE3vuycOQm1VSXZYWPK+mJwV/BmXvd86xjp5dKPP8IurSAKubQXXeelYCeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255563; c=relaxed/simple;
	bh=gbVd0grbXszK/WnbtgreUw9LHQunjIXKM8sX85FG6r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXapTIDhqCQKLEda2vNIbSycWkSVs5neArHYf1AyWIvtIOIcq9v5D6TZ9pui05/d+txI6wxGgiSHiLRdyjeu89L39/+rfz4VzfVjT9DBX5j1VY2xF7ohp8jaYN6B0ep5pwxUZ7EkVTJUys4YjfNGJqOpyShuIuX3274tWYFa0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtk1fEf2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtk1fEf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BFD1F000C5;
	Sat, 17 Oct 2026 16:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792255560;
	bh=AWLTsUsX5TbTYjGAwS5cC3m3DTk9zdt+lS+78MEuoJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gtk1fEf2YHI0QBFhxPREcLeOk9OC2WTjFhMLkEEJdfSnJZMhkUTb3i4VPxdINupyr
	 iQ0Lu2YkQG2c5LMV5H3mfcl6eHlvo5X3BjWjpYQw9ruCTv5rXVi4MEXmPneRurMP5i
	 Ij9NslAfLSEqzAYeh6btRSJjpAAe+cc805rWfTnNGtYgYZ2ISSlkLxXvxkCsAOImBs
	 TPJyUee/AiRn4ZGf+BIyP2c0Zhs7VE920EX6C4idsspWZJmYFyc+hiNHFPzORiZ4XL
	 bfNlpRqnWZ3FD7pcrmIDRBf+fPbt/nCN/8m63lNlV9QY/ZjjmYshEwsOyPjX2ktwWT
	 tyain+eAOxJEg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] sched_ext: Report a sub-scheduler's ecaps on attach and detach
Date: Sat, 17 Oct 2026 06:45:53 -1000
Message-ID: <20261017164556.4136807-4-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017164556.4136807-1-tj@kernel.org>
References: <20261017164556.4136807-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sub-scheduler learns which cids it holds through ops.sub_ecaps_updated(),
but the caps granted from ops.sub_attach() reach it only after its enable
bypass lifts, when it is already scheduling its tasks.

Report the caps at the end of the enable, before bypass lifts. On disable,
report their loss before any task goes back to the parent, so that the
parent hears of the loss of every cap it was told of. ops.sub_detach()
remains where the parent cleans up after the sub-scheduler. Deliveries no
longer depend on bypass, so ops.sub_ecaps_updated() and
ops.sub_child_ecaps_updated() also run while a scheduler bypasses. The
replay at unbypass goes, and the enable's bypass returns to after
ops.sub_attach().

A sub-scheduler's ecaps now change only with the deliveries that report
them, so that whenever its ops run under the rq lock, its caps are the ones
it was last told of. A sync before the attach report leaves them alone, and
the detach report zeroes them as it delivers the loss. A cpu going offline
still drops its caps without a report, and those are the only changes not
delivered. clear_all_caps() drops that unreported loss on inactive cpus.

A report reschedules only the cpus the sub-scheduler was ever granted a cap
on. Rescheduling every cpu would disrupt a large machine split many ways,
and which cpus still owe a delivery can't be read off the caps.

The report waits on an rcuwait woken from hard irq work. On PREEMPT_RT, a
regular irq_work queued by a cpu going down can be left behind when hotplug
parks the irq_work thread, and a hard irq can't take a wait queue's lock.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |   7 +-
 kernel/sched/ext/internal.h |  50 ++++++-
 kernel/sched/ext/sub.c      | 253 ++++++++++++++++++++++++++----------
 kernel/sched/ext/sub.h      |   2 -
 4 files changed, 228 insertions(+), 84 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index d28902dc48ff..3deda2d1f7f8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6746,6 +6746,9 @@ static void unbypass_renotify_idle(struct rq *rq, struct scx_sched *pos,
  *
  * - ops.dispatch() is ignored.
  *
+ * - ops.sub_ecaps_updated() and ops.sub_child_ecaps_updated() are still called.
+ *   The bypassed tasks are on the bypass DSQs, out of their reach.
+ *
  * - dispatch_one() does not report %SCX_DSP_PREV on non-zero slice as slice
  *   can't be trusted. Whenever a tick triggers, the running task is rotated to
  *   the tail of the queue.
@@ -6825,10 +6828,8 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 				pcpu->flags |= SCX_SCHED_PCPU_BYPASSING;
 			} else {
 				pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
-				if (was_bypassing) {
+				if (was_bypassing)
 					unbypass_renotify_idle(rq, pos, pcpu);
-					scx_unbypass_replay_ecaps(rq, pos);
-				}
 			}
 		}
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index b408993af794..8532c58ddbfa 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -878,9 +878,13 @@ struct sched_ext_ops {
 	 * @args: argument container, see the struct definition
 	 *
 	 * The sub-scheduler holds no caps by this point and can no longer
-	 * affect any cid. Its caps went away without a
-	 * sub_child_ecaps_updated() report, so whatever was delegated to it,
-	 * e.g. cpuperf targets, is the parent's to restore here.
+	 * affect any cid. Every cap reported through
+	 * ops.sub_child_ecaps_updated() was also reported lost there before the
+	 * sub-scheduler's tasks came back to this sched. Nothing is reported
+	 * for a sub-scheduler whose enable failed before its tasks were handed
+	 * over. If this sched is being disabled too, it can miss these reports.
+	 * On a cpu whose loss wasn't reported, whatever was delegated, e.g.
+	 * cpuperf targets, is the parent's to restore here.
 	 */
 	void (*sub_detach)(struct scx_sub_detach_args *args);
 
@@ -914,6 +918,14 @@ struct sched_ext_ops {
 	 * change is in effect on the cpu. Runs in dispatch context with rq lock
 	 * held, and can perform all operations allowed in ops.dispatch()
 	 * including inserting/moving tasks.
+	 *
+	 * Deliveries start after this sched's tasks are handed to it and before
+	 * it makes its first scheduling decision. The caps granted from
+	 * ops.sub_attach() and any change since are reported then. A cpu that
+	 * isn't online at that point reports them once it comes online.
+	 * Deliveries continue while this sched bypasses. Its tasks are then on
+	 * the bypass DSQs, where this op can't insert or move them. Deliveries
+	 * stop once this sched is being disabled.
 	 */
 	void (*sub_ecaps_updated)(s32 cid, u64 before, u64 after);
 
@@ -940,11 +952,16 @@ struct sched_ext_ops {
 	 * @before: the child's effective caps as of the last delivery
 	 * @after: the child's effective caps now
 	 *
-	 * Invoked right after the child's sub_ecaps_updated(), once a grant or
-	 * revoke is in effect on the cpu. From here on the parent can act on a
+	 * Invoked right after the child's ops.sub_ecaps_updated(), once a
+	 * change is in effect on the cpu. From here on the parent can act on a
 	 * cap the child lost, e.g. reset the cpuperf target or schedule on the
-	 * cid. A detaching child's caps go away without a report, see
-	 * sub_detach(). A cpu going offline drops caps without a report.
+	 * cid. A disabling child gets no ops.sub_ecaps_updated(), so only this
+	 * op is invoked for its loss. A cpu going offline drops caps without a
+	 * report.
+	 *
+	 * Deliveries start as for the child's ops.sub_ecaps_updated(), continue
+	 * while either sched bypasses and stop once this sched is being
+	 * disabled.
 	 *
 	 * Runs in dispatch context with rq lock held, and can perform all
 	 * operations allowed in ops.dispatch() including inserting/moving
@@ -1414,6 +1431,10 @@ struct scx_sched;
 
 enum scx_sched_pcpu_flags {
 	SCX_SCHED_PCPU_BYPASSING	= 1LLU << 0,
+	/* ecaps deliveries are enabled, see ecaps_enable() */
+	SCX_SCHED_PCPU_ECAPS_ENABLED	= 1LLU << 1,
+	/* a report is pending, see ecaps_report() */
+	SCX_SCHED_PCPU_ECAPS_REPORT	= 1LLU << 2,
 };
 
 /* dispatch buf */
@@ -1474,6 +1495,16 @@ struct scx_sched_pcpu {
 	struct llist_node	ecaps_to_sync_node;
 	/* owed a forced update_idle() re-notify on this cpu */
 	bool			idle_renotify;
+	/*
+	 * The sched was granted a cap on this cpu at some point. ecaps_report()
+	 * reschedules only these cpus, as rescheduling every cpu on each
+	 * sub-sched enable and disable would disrupt a large machine split many
+	 * ways. Exactly which cpus owe a delivery is hard to track, as
+	 * deliveries are asynchronous and reading caps[] and ecaps doesn't
+	 * tell. A cpu granted a cap at some point is a simple superset. Written
+	 * under pshard->lock.
+	 */
+	bool			had_caps;
 	/*
 	 * ecaps as of the last sub_ecaps_updated() and
 	 * sub_child_ecaps_updated() delivery. See __scx_process_sync_ecaps().
@@ -1751,6 +1782,11 @@ struct scx_sched {
 
 	bool			linked;		/* on ->children, see scx_link_sched() */
 	bool			sub_attached;
+	/* ecaps_enable() has run, under scx_enable_mutex */
+	bool			ecaps_enabled;
+
+	/* marked cpus whose sync is pending, see ecaps_report() */
+	atomic_t		nr_ecaps_reports;
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
 	/*
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 1923bdc33d6b..46b13a1767bb 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -42,6 +42,16 @@ static s64 scx_rescue_sat_delta_ns;
 static unsigned long scx_rescue_decay_halflife;
 static unsigned long scx_rescue_overload_after;
 
+/*
+ * ecaps_report() waits here for its marked syncs. A cpu going down can clear
+ * its mark, and on PREEMPT_RT a regular irq_work queued there can be left
+ * behind when hotplug parks the irq_work thread, so the wakeup is hard irq
+ * work. A hard irq can't take a wait queue's lock, which sleeps on PREEMPT_RT.
+ * scx_enable_mutex serializes the reports, so the single waiter sleeps on an
+ * rcuwait.
+ */
+static struct rcuwait ecaps_report_wait = __RCUWAIT_INITIALIZER(ecaps_report_wait);
+
 /**
  * scx_skip_subtree_pre - Skip @pos's subtree in a pre-order walk
  * @pos: current position
@@ -964,7 +974,7 @@ static void caps_updated_deliver(struct list_head *to_deliver)
 			 * so !has_op means the op is absent or the sched isn't
 			 * live yet - e.g. caps grant from ops.sub_attach().
 			 * Either way don't consume - leave for
-			 * scx_sub_seed_caps() to deliver once live.
+			 * scx_sub_seed_caps() to deliver once has_op is set.
 			 */
 			scoped_guard (raw_spinlock, &cu->lock) {
 				if (cu->caps && SCX_HAS_OP(sch, sub_caps_updated) &&
@@ -992,8 +1002,8 @@ static void caps_updated_deliver(struct list_head *to_deliver)
 
 /*
  * Deliver caps owed to @sch that couldn't be delivered earlier (e.g. a grant
- * taken during its sub_attach(), before has_op was set). Called once @sch is
- * enabled.
+ * taken during its sub_attach(), before has_op was set). Called once has_op is
+ * set.
  */
 static void scx_sub_seed_caps(struct scx_sched *sch)
 {
@@ -1069,14 +1079,31 @@ static struct scx_pshard *cid_pshard(struct scx_sched *sch, s32 cid)
 	return sch->pshard[rcu_dereference_all(scx_cid_to_shard)[cid]];
 }
 
+static void ecaps_report_irq_workfn(struct irq_work *irq_work)
+{
+	rcuwait_wake_up(&ecaps_report_wait);
+}
+
+static struct irq_work ecaps_report_irq_work = IRQ_WORK_INIT_HARD(ecaps_report_irq_workfn);
+
+/*
+ * @pcpu's marked sync has been processed. The waiter in ecaps_report() can't be
+ * woken under the rq lock, so the last completion wakes it through irq_work.
+ */
+static void ecaps_report_done(struct scx_sched_pcpu *pcpu)
+{
+	pcpu->flags &= ~SCX_SCHED_PCPU_ECAPS_REPORT;
+	if (atomic_dec_and_test(&pcpu->sch->nr_ecaps_reports))
+		irq_work_queue(&ecaps_report_irq_work);
+}
+
 /**
  * __scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
  * @rq: the cid's cpu rq
  * @prev: @rq's previous task from the in-progress dispatch
  *
  * pshard->caps[] is the target configuration. pcpu->ecaps is the effective
- * transposed copy owned by the cid's cpu and written only here under @rq's
- * lock.
+ * transposed copy owned by the cid's cpu and written under @rq's lock.
  *
  * A sched that newly gains baseline access here is owed an update_idle() so it
  * learns the cid's idle state. Such a gain arms the per-rq
@@ -1113,6 +1140,7 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		struct scx_sched_pcpu *pcpu =
 			container_of(pos, struct scx_sched_pcpu, ecaps_to_sync_node);
 		struct scx_pshard *ps = cid_pshard(pcpu->sch, cid);
+		bool report = pcpu->flags & SCX_SCHED_PCPU_ECAPS_REPORT;
 		u64 old, ecaps, lost, gained;
 
 		init_llist_node(pos);
@@ -1120,8 +1148,17 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		/* pairs with smp_mb() in queue_sync_ecaps(), see there */
 		smp_mb();
 
+		/*
+		 * Before the sched's has_op is set, only the parent's op would
+		 * run, and the change would never reach the sched.
+		 * ecaps_enable() enables deliveries on each cpu once has_op is
+		 * set. Until then, a sync leaves the ecaps alone.
+		 */
 		old = READ_ONCE(pcpu->ecaps);
-		ecaps = calc_effective_caps(ps, cid);
+		if (pcpu->flags & SCX_SCHED_PCPU_ECAPS_ENABLED)
+			ecaps = calc_effective_caps(ps, cid);
+		else
+			ecaps = old;
 		WRITE_ONCE(pcpu->ecaps, ecaps);
 
 		lost = old & ~ecaps;
@@ -1139,25 +1176,28 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		 * up there. The rq recorded in it keeps the dispatches
 		 * targeting @rq.
 		 *
-		 * Bypass propagates down the hierarchy, so a sched that isn't
-		 * bypassing has no bypassing parent. The child's bypass state
-		 * gates both deliveries. Both report the same before value, so
-		 * one reported_ecaps covers them.
+		 * Both report the same before value, so one reported_ecaps
+		 * covers them.
 		 */
-		if (ecaps != pcpu->reported_ecaps && !scx_bypassing(pcpu->sch, cpu)) {
+		if (ecaps != pcpu->reported_ecaps &&
+		    (pcpu->flags & SCX_SCHED_PCPU_ECAPS_ENABLED)) {
 			struct scx_sched *parent = scx_parent(pcpu->sch);
 			struct scx_dsp_ctx *dspc;
 
 			/* stash @prev so nested dispatches can access it */
 			rq->scx.sub_dispatch_prev = prev;
-			if (SCX_HAS_OP(pcpu->sch, sub_ecaps_updated)) {
+
+			/* a disabling sched's ops are not called */
+			if (SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
+			    likely(!READ_ONCE(pcpu->sch->aborting))) {
 				dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
 				dspc->rq = rq;
 				SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq,
 					    scx_cpu_arg(cpu), pcpu->reported_ecaps, ecaps);
 				scx_flush_dispatch_buf(pcpu->sch, rq);
 			}
-			if (SCX_HAS_OP(parent, sub_child_ecaps_updated)) {
+			if (SCX_HAS_OP(parent, sub_child_ecaps_updated) &&
+			    likely(!READ_ONCE(parent->aborting))) {
 				dspc = &this_cpu_ptr(parent->pcpu)->dsp_ctx;
 				dspc->rq = rq;
 				SCX_CALL_OP(parent, sub_child_ecaps_updated, rq,
@@ -1169,6 +1209,9 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 			pcpu->reported_ecaps = ecaps;
 		}
 
+		if (report)
+			ecaps_report_done(pcpu);
+
 		/*
 		 * Gaining baseline access owes an update_idle() so the sched
 		 * learns the cpu's idle state. Arm the per-rq gate so the next
@@ -1191,41 +1234,6 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		scx_schedule_reenq_local(rq, SCX_REENQ_CAP_REVOKE);
 }
 
-/**
- * scx_unbypass_replay_ecaps - Replay a bypass-suppressed ecaps notification
- * @rq: rq of the cpu leaving bypass
- * @sch: scheduler that just left bypass on @rq's cpu
- *
- * scx_process_sync_ecaps() consumes syncs while bypassing without delivering
- * ops.sub_ecaps_updated(), leaving reported_ecaps stale. Nothing re-queues a
- * sync when bypass lifts, so without a replay a cid that never changes again
- * would never be notified. The attach-time initial grants are the acute case
- * as they are consumed during the enable bypass window. Re-queue a sync for
- * any undelivered delta so the next dispatch delivers it.
- */
-void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch)
-{
-	s32 cpu = cpu_of(rq);
-	struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
-	struct scx_pshard *ps;
-	s32 cid;
-
-	lockdep_assert_rq_held(rq);
-
-	/* root holds every cap and never uses ecaps */
-	if (!sch->level)
-		return;
-
-	if (READ_ONCE(pcpu->ecaps) == pcpu->reported_ecaps)
-		return;
-
-	cid = __scx_cpu_to_cid(cpu);
-	ps = sch->pshard[rcu_dereference_all(scx_cid_to_shard)[cid]];
-
-	guard(raw_spinlock)(&ps->lock);
-	queue_sync_ecaps(sch, cid);
-}
-
 /*
  * A cpu came back. Re-seed each sub-sched's ecaps on the cpu's cid. The sync
  * recomputes effective caps from the pshard and fires ops.sub_ecaps_updated()
@@ -1281,24 +1289,32 @@ void scx_offline_ecaps(struct rq *rq)
 	root = scx_root_protected();
 
 	scx_for_each_descendant_pre(pos, root) {
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
+
 		/* root holds every cap and never uses ecaps */
 		if (!pos->level)
 			continue;
 
-		WRITE_ONCE(per_cpu_ptr(pos->pcpu, cpu)->ecaps, 0);
+		WRITE_ONCE(pcpu->ecaps, 0);
+
+		/* deliveries have stopped on this cpu, clear its mark */
+		if (pcpu->flags & SCX_SCHED_PCPU_ECAPS_REPORT)
+			ecaps_report_done(pcpu);
 	}
 }
 
 /*
- * Clear every cap @sch holds. The pshard caps go first as they are the source a
- * pending sync recomputes ecaps from. ecaps are then zeroed directly for the
- * cap checks.
+ * Clear every cap @sch holds in the pshards. The report that follows delivers
+ * the loss and zeroes the ecaps. The caller holds off cpu hotplug across this
+ * and the report.
  */
 static void clear_all_caps(struct scx_sched *sch)
 {
 	s32 si, cpu;
 	u32 cap_bit;
 
+	lockdep_assert_cpus_held();
+
 	/* enable may have failed before scx_alloc_pshards() */
 	if (!sch->pshard)
 		return;
@@ -1312,8 +1328,13 @@ static void clear_all_caps(struct scx_sched *sch)
 	}
 
 	for_each_possible_cpu(cpu) {
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
 		guard(rq_lock_irqsave)(cpu_rq(cpu));
-		WRITE_ONCE(per_cpu_ptr(sch->pcpu, cpu)->ecaps, 0);
+
+		/* drop an unreported loss, as the report skips inactive cpus */
+		if (!cpu_active(cpu))
+			pcpu->reported_ecaps = 0;
 	}
 }
 
@@ -1331,6 +1352,9 @@ void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
 
 	guard(rq_lock_irqsave)(rq);
 
+	/* ecaps_report() waited for every mark it set */
+	WARN_ON_ONCE(pcpu->flags & SCX_SCHED_PCPU_ECAPS_REPORT);
+
 	if (!llist_on_list(&pcpu->ecaps_to_sync_node))
 		return;
 
@@ -1657,6 +1681,76 @@ static inline s32 scx_cgroup_claim_subtree(struct scx_sched *sch) { return 0; }
 static inline void scx_cgroup_return_subtree(struct scx_sched *sch) {}
 #endif
 
+/*
+ * Enable @sch's ecaps deliveries on every possible cpu, so that a cpu inactive
+ * during the attach report delivers from the reseed at its activation.
+ */
+static void ecaps_enable(struct scx_sched *sch)
+{
+	s32 cpu;
+
+	for_each_possible_cpu(cpu) {
+		guard(rq_lock_irqsave)(cpu_rq(cpu));
+		per_cpu_ptr(sch->pcpu, cpu)->flags |= SCX_SCHED_PCPU_ECAPS_ENABLED;
+	}
+	sch->ecaps_enabled = true;
+}
+
+/**
+ * ecaps_report - Report @sch's ecaps and wait
+ * @sch: sub-scheduler to report
+ *
+ * Mark every cpu @sch was ever granted a cap on, deliver its pending change
+ * through the dispatch path and wait for it. An inactive cpu is skipped. A cpu
+ * going down meanwhile has its mark cleared by scx_offline_ecaps().
+ *
+ * Called with scx_enable_mutex held. A sched's attach and detach reports must
+ * not overlap, as the mark is one bit per pcpu.
+ */
+static void ecaps_report(struct scx_sched *sch)
+{
+	s32 cpu;
+
+	lockdep_assert_held(&scx_enable_mutex);
+
+	for_each_possible_cpu(cpu) {
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+		struct rq *rq = cpu_rq(cpu);
+		struct scx_pshard *ps;
+		s32 cid;
+
+		guard(rq_lock_irqsave)(rq);
+
+		/* syncs on an inactive cpu are discarded */
+		if (!cpu_active(cpu))
+			continue;
+
+		cid = __scx_cpu_to_cid(cpu);
+		ps = cid_pshard(sch, cid);
+		guard(raw_spinlock)(&ps->lock);
+
+		if (!pcpu->had_caps)
+			continue;
+
+		pcpu->flags |= SCX_SCHED_PCPU_ECAPS_REPORT;
+		atomic_inc(&sch->nr_ecaps_reports);
+		queue_sync_ecaps(sch, cid);
+
+		/*
+		 * The report needs an ext dispatch on this cpu. A kick is
+		 * dropped while the root bypasses, e.g. for PM, so reschedule
+		 * directly. A fair task can hold the cpu, so also start the ext
+		 * server, which picks the ext class within its period.
+		 */
+		update_rq_clock(rq);
+		dl_server_start(&rq->ext_server);
+		resched_curr(rq);
+	}
+
+	rcuwait_wait_event(&ecaps_report_wait, !atomic_read(&sch->nr_ecaps_reports),
+			   TASK_UNINTERRUPTIBLE);
+}
+
 void scx_sub_disable(struct scx_sched *sch)
 {
 	struct scx_sched *parent = scx_parent(sch);
@@ -1678,6 +1772,24 @@ void scx_sub_disable(struct scx_sched *sch)
 	 * disable ops.
 	 */
 	mutex_lock(&scx_enable_mutex);
+
+	/*
+	 * Clear @sch's caps and report the loss before any task goes back to
+	 * the parent. A disabling sched is granted nothing, so the caps stay
+	 * cleared. Hold off cpu hotplug across both. The report covers every
+	 * active cpu and the clear drops the unreported loss on the rest, so
+	 * that no loss reaches the parent after ops.sub_detach().
+	 *
+	 * An enable that failed before its attach report has nothing to report.
+	 * If it failed before scx_link_sched(), the root's disable doesn't wait
+	 * for it and may have retired the cid tables that the report reads.
+	 */
+	scoped_guard(cpus_read_lock) {
+		clear_all_caps(sch);
+		if (sch->ecaps_enabled)
+			ecaps_report(sch);
+	}
+
 	percpu_down_write(&scx_fork_rwsem);
 	scx_cgroup_lock();
 
@@ -1785,12 +1897,6 @@ void scx_sub_disable(struct scx_sched *sch)
 
 	scx_unlink_sched(sch);
 
-	/*
-	 * The parent restores what it delegated in ops.sub_detach(). @sch must
-	 * hold no caps by then.
-	 */
-	clear_all_caps(sch);
-
 	mutex_unlock(&scx_enable_mutex);
 
 	/*
@@ -1950,15 +2056,6 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_disable;
 
-	/*
-	 * Bypass before @sch is linked and grants can reach it. The parent's
-	 * delivery advances reported_ecaps, so a sync consumed before @sch's
-	 * ops are registered would reach the parent and never be replayed to
-	 * @sch. While bypassed, the syncs are consumed without a delivery and
-	 * replayed to both at unbypass.
-	 */
-	scx_bypass(sch, true);
-
 	ret = scx_link_sched(sch);
 	if (ret)
 		goto err_disable;
@@ -2004,6 +2101,8 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	}
 	sch->sub_attached = true;
 
+	scx_bypass(sch, true);
+
 	for (i = SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
 		if (((void (**)(void))ops)[i])
 			set_bit(i, sch->has_op);
@@ -2145,10 +2244,16 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
-	scx_bypass(sch, false);
-
-	/* @sch is enabled; deliver any caps owed since its sub_attach() */
+	/*
+	 * Report the caps granted from ops.sub_attach() before bypass lifts and
+	 * @sch makes its first scheduling decision. The report can wait, so it
+	 * runs outside the fork rwsem.
+	 */
 	scx_sub_seed_caps(sch);
+	ecaps_enable(sch);
+	ecaps_report(sch);
+
+	scx_bypass(sch, false);
 
 	pr_info("sched_ext: BPF sub-scheduler \"%s\" enabled\n", sch->ops.name);
 	kobject_uevent(&sch->kobj, KOBJ_ADD);
@@ -2578,8 +2683,12 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
 				 * the cid gains baseline access, so the holder
 				 * learns of an already-idle cid.
 				 */
-				scx_cmask_for_each_cid(cid, changed_cids)
+				scx_cmask_for_each_cid(cid, changed_cids) {
+					s32 cpu = __scx_cid_to_cpu(cid);
+
+					per_cpu_ptr(child->pcpu, cpu)->had_caps = true;
 					queue_sync_ecaps(child, cid);
+				}
 			}
 		}
 
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index b76d750463f0..63769205c013 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -32,7 +32,6 @@ void scx_free_pshards(struct scx_sched *sch);
 s32 scx_alloc_pshards(struct scx_sched *sch);
 void scx_init_root_caps(struct scx_sched *sch);
 void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev);
-void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch);
 void scx_online_ecaps(struct rq *rq);
 void scx_offline_ecaps(struct rq *rq);
 void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu);
@@ -110,7 +109,6 @@ static inline void scx_free_pshards(struct scx_sched *sch) {}
 static inline s32 scx_alloc_pshards(struct scx_sched *sch) { return 0; }
 static inline void scx_init_root_caps(struct scx_sched *sch) {}
 static inline void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev) {}
-static inline void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch) {}
 static inline void scx_online_ecaps(struct rq *rq) {}
 static inline void scx_offline_ecaps(struct rq *rq) {}
 static inline void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu) {}
-- 
2.56.0

