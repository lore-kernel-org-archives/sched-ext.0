Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060284;
	b=ZUKYHiN6yXL2GzF9O7yx+92M9HeLre7yJ+nBvht3ZZc0y5EmKqA9JzK1stcU4z9sk4GH
	 yWRfMI3tt7fQx3iMZxhdjhNDi2kCn6I5HHp+ePvDLHk30bVEnwaDT7Vb+x9yC6qlf2C2y
	 mnA53V533D/qkFSZLTMAlHoDwn3fkDSTvsqkhX/sPaD4dBvKDGFric7+3BivgGGAfQLJA
	 typ6xlyJSKKGBVsC+MFL3Kzs9MQgy2DqSHknyGeI5Q+dKMFc31+xOKdx9+SyaTYTzbvsF
	 ZBWp9+SQCYO+W3EaSKhZjviZHhvgM/pi9LvLsVVFeCdYjcpYs3DnH9utgMSxmHRBVZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SxViyOr5QpgGOYT8e+Wn5l6ia50QPFlkjeDPz8Xp/o0=;
	b=F4uqBMwuig89ZDdsL7nO69XJMUEdjEvTq0Q9yfiMpHngTWCrz0oPBqwh1uzFyHl3jY39
	 P9Xygdsw7PE8G6o5ypALeemk5iDNQIfh/6e7XMlIWBEuxJwIxBbOV1btxoWv9euvnEIsy
	 7qMFbsKzNTByGM6koZu0X9Tm6xKTquVfcFkDWszRrOjDjqFFLS6zQ21wZchAYx39G0Gqq
	 qKIkf+F3FPHtlTpaZTAPDWE22ms96A0M0lVq9WIKJOpZ6ujjdiWzVoxKnvOvPZkfbih74
	 jzBk5WCsfwQPo4BdBdBb345N+5HREcOCjUBKs35gwtbHnib03OEmQeVQOgBTlktbqUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtFYx9Is;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752C606A324;
	Tue, 27 Oct 2026 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtFYx9Is
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22381F01829;
	Tue, 27 Oct 2026 00:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060283;
	bh=SxViyOr5QpgGOYT8e+Wn5l6ia50QPFlkjeDPz8Xp/o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JtFYx9IswL4TqiNJ8l64SqiW0a2p7rBxRQZHqZmgXDhGn29B6L4irrZc2gHIZ/F2D
	 iq7hs+Age7siukDduYbSRQxy3r2xXh8fN3fZhnCvHKNGlDxAi+NXcRHAsgroeh/wl1
	 jAL3tDJklfkny4/hqNzDKqDCNGFkMKusV5bdn9hnTeCtScAdYRMJdHGByapU+foIX8
	 QigAMLeixEzuGPN6JkCgM+6B/EprFxqMqPkZnPXD7a6GWkmvu2A9/iJarBnn6ULcpl
	 jZhSn7bXPBOgfMTiYULnsXaeochDBRQacQn77/eR+2RuhMKwy5CksgjiWJuiNS/0Ds
	 bmpKvb4XhL1cw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/18] sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE
Date: Mon, 26 Oct 2026 14:17:44 -1000
Message-ID: <20261027001749.1821379-14-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bypassed task stalls on a cpu where its host lacks SCX_CAP_BASE. The host,
the nearest ancestor that is not bypassing, runs a bypassing sub-scheduler's
tasks through its per-cpu bypass DSQs. A cpu's dispatch only descends into
schedulers holding BASE on it, so the host's bypass DSQ on such a cpu is
never consumed until the host regains the cap.

Resolve a bypassed task against its host at enqueue time. If the host lacks
BASE on the cpu, send the task to rescue on that cpu, which runs it at
bounded bandwidth without the host's dispatch having to reach it.

The enqueue does not look above the host for an ancestor that holds BASE.
That ancestor would run the task on cpus it never granted the host.

With rescue disabled the task goes to the host's bypass DSQ as before and
stalls there until the host regains BASE or the bypass ends, or until the
stall watchdog ejects the host, which it blames for a task stuck on its DSQ.
A task that must run on the cpu, migration-disabled or with a migration
pending, is admitted to the local DSQ instead, as any insert of such a task
is.

Bypass also used to end a rescue, sending a preempted rescuee to the bypass
DSQ with every other preempted task. Now that rescue is how a bypassed task
runs while its host lacks BASE, keep a preempted rescuee on the local DSQ
under bypass too. dispatch_one() also keeps such a rescuee running, as an
earlier patch's bypass expiry leaves a kernel slice alone. The grant stays
bounded by served time.

A task scx_fail_parent() punted to its bypassing parent at NONE can be a
rescuee too. switched_from_scx() ends its slice as it does for an enabled
task, so that a NONE rescuee leaving sched_ext while running doesn't leave
rq->scx.rescue.curr pointing at it.

While at it, the rescue test in __scx_resolve_local_dsq() goes through the
new scx_rescue_enabled() helper.

v2:
- The description notes that dispatch_one() keeps a bypassed rescuee too,
  through the new patch before this one (sashiko).
- scx_rescue_keep()'s kerneldoc drops dispatch_one() declining a rescuee
  with slice left, which the new patch removes.

v3:
- With rescue disabled, a task that must run on the cpu is admitted to the
  local DSQ instead of waiting on the host's bypass DSQ.
- The description names the stall watchdog as the way out for a task stuck
  without rescue.

v4:
- switched_from_scx() ends the slice of a NONE task, which can now be a
  rescuee (sashiko).
- scx_punt_task()'s kerneldoc no longer says that switched_from_scx() skips
  a NONE task.
- scx_bypass()'s kerneldoc and the ops.sub_ecaps_updated() doc say where a
  bypassed task can be besides the bypass DSQs.

Fixes: 147d1885f390 ("sched_ext: Add the SCX_CAP_ENQ_IMMED cap")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 52 ++++++++++++++++++++++++++++++-------
 kernel/sched/ext/internal.h |  5 ++--
 kernel/sched/ext/sub.c      | 24 +++++++++--------
 kernel/sched/ext/sub.h      |  9 +++++++
 4 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index dafb40c75cbc..a75d3c3bfad9 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -388,8 +388,12 @@ static const struct sched_class *scx_setscheduler_class(struct task_struct *p)
 	return __setscheduler_class(p->policy, p->prio);
 }
 
-static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, s32 cpu)
+static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, struct rq *rq,
+						    struct task_struct *p, u64 *enq_flags)
 {
+	struct scx_sched *host = scx_exec_sched(sch, cpu_of(rq));
+	struct scx_dispatch_q *dsq;
+
 	/*
 	 * If @sch is a sub-sched which is bypassing, its tasks should go into
 	 * the bypass DSQs of the nearest ancestor which is not bypassing. The
@@ -400,8 +404,29 @@ static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, s32 c
 	 * Whenever a sched starts bypassing, all runnable tasks in its subtree
 	 * are re-enqueued after scx_bypassing() is turned on, guaranteeing that
 	 * all tasks are transferred to the right DSQs.
-	 */
-	return scx_bypass_dsq(scx_exec_sched(sch, cpu), cpu);
+	 *
+	 * A cpu's dispatch only descends into a host holding %SCX_CAP_BASE on
+	 * it, so the bypass DSQ of a host without BASE here is never consumed.
+	 * Send @p to rescue on this cpu instead, resolving against @host.
+	 * scx_dispatch_enqueue() resolves a local DSQ again, against the
+	 * bypassing @sch. %SCX_ENQ_IGNORE_CAPS makes that second resolution
+	 * admit @p.
+	 *
+	 * A migration-disabled task can't leave this cpu, and a task with a
+	 * migration pending must run here until the migration moves it. Either
+	 * would wait on the unconsumed bypass DSQ until the host regains BASE.
+	 * Resolve them too when rescue is disabled. The resolution admits both
+	 * to the local DSQ, as it does any insert of such a task.
+	 */
+	if (unlikely(scx_missing_caps(host, cpu_of(rq), SCX_CAP_BASE)) &&
+	    (scx_rescue_enabled() || is_migration_disabled(p) || p->migration_pending)) {
+		*enq_flags |= SCX_ENQ_RESCUE;
+		dsq = scx_resolve_local_dsq(host, rq, p, enq_flags);
+		*enq_flags |= SCX_ENQ_IGNORE_CAPS;
+	} else {
+		dsq = scx_bypass_dsq(host, cpu_of(rq));
+	}
+	return dsq;
 }
 
 /**
@@ -2353,7 +2378,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	dsq = find_global_dsq(sch, task_cpu(p));
 	goto enqueue;
 bypass:
-	dsq = bypass_enq_target_dsq(sch, task_cpu(p));
+	dsq = bypass_enq_target_dsq(sch, rq, p, &enq_flags);
 	goto enqueue;
 
 enqueue:
@@ -3735,8 +3760,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * The exception is an IMMED donor put by proxy_resched_idle():
 		 * the CPU isn't busy, proxy resolution is only retrying through
 		 * idle, so keep the donor where it can be picked again.
+		 *
+		 * A task with a kernel slice stays on the local DSQ even while
+		 * @sch bypasses. Under bypass, rescue runs @p when the host
+		 * lacks %SCX_CAP_BASE, see bypass_enq_target_dsq().
 		 */
-		if (p->scx.slice && !scx_bypassing(sch, cpu_of(rq))) {
+		if (p->scx.slice && (!scx_bypassing(sch, cpu_of(rq)) ||
+				     scx_task_has_kernel_slice(p))) {
 			if ((p->scx.flags & SCX_TASK_IMMED) && !proxy_put) {
 				p->scx.flags |= SCX_TASK_REENQ_PREEMPTED;
 				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
@@ -4987,11 +5017,14 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
 	 * parent's own teardown). There is nothing to disable; calling
 	 * scx_disable_task() would WARN on the non-%ENABLED state and trigger a
 	 * NONE -> READY validation failure.
+	 *
+	 * @p can still be a rescuee under the parent. End its slice as
+	 * scx_disable_task() does for an enabled task.
 	 */
 	if (scx_get_task_state(p) == SCX_TASK_NONE)
-		return;
-
-	scx_disable_task(scx_task_sched(p), p);
+		scx_task_slice_ended(rq, p);
+	else
+		scx_disable_task(scx_task_sched(p), p);
 }
 
 static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
@@ -6930,7 +6963,8 @@ static void unbypass_renotify_idle(struct rq *rq, struct scx_sched *pos,
  * - ops.dispatch() is ignored.
  *
  * - ops.sub_ecaps_updated() and ops.sub_child_ecaps_updated() are still called.
- *   The bypassed tasks are on the bypass DSQs, out of their reach.
+ *   The bypassed tasks are on the bypass DSQs, under rescue or admitted to a
+ *   local DSQ, out of their reach.
  *
  * - dispatch_one() expires prev's slice before its keep test as the slice can't
  *   be trusted. Each tick does the same and rotates the running task to the
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index ed63e29c9442..ecd677c4b561 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -924,8 +924,9 @@ struct sched_ext_ops {
 	 * ops.sub_attach() and any change since are reported then. A cpu that
 	 * isn't online at that point reports them once it comes online.
 	 * Deliveries continue while this sched bypasses. Its tasks are then on
-	 * the bypass DSQs, where this op can't insert or move them. Deliveries
-	 * stop once this sched is being disabled.
+	 * the bypass DSQs, under rescue or admitted to a local DSQ, where this
+	 * op can't insert or move them. Deliveries stop once this sched is
+	 * being disabled.
 	 *
 	 * Until this sched is being disabled, whenever an op of this sched runs
 	 * under a cid's rq lock, its effective caps on the cid are the @after
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 6fa8cea1ef88..01215384eaa5 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -36,7 +36,7 @@ static DEFINE_STATIC_KEY_FALSE(__scx_ops_cid_sched_updated_enabled);
 static s32 scx_nr_ops_cid_sched_updated;	/* such scheds, under scx_enable_mutex */
 
 /* latched at root enable before any rescue runs */
-static s32 scx_rescue_bw_1024;
+s32 scx_rescue_bw_1024;			/* 0 if disabled, see scx_rescue_enabled() */
 static s64 scx_rescue_quantum_ns;
 static s64 scx_rescue_sat_delta_ns;
 static unsigned long scx_rescue_decay_halflife;
@@ -519,8 +519,8 @@ void scx_rescue_end(struct rq *rq)
  * rescuee. dispatch_one() keeps it running and put_prev_task_scx() reinserts it
  * at the tail of the local DSQ, behind whatever preempted the rescuee.
  *
- * Return %false to end the rescue instead - the slice is already fully served,
- * @p is leaving the rq or bypass is dismantling rescues.
+ * Return %false to end the rescue instead - the slice is already fully served
+ * or @p is leaving the rq.
  */
 bool scx_rescue_keep(struct rq *rq, struct task_struct *p)
 {
@@ -528,8 +528,7 @@ bool scx_rescue_keep(struct rq *rq, struct task_struct *p)
 
 	lockdep_assert_rq_held(rq);
 
-	if (!remaining || !(p->scx.flags & SCX_TASK_QUEUED) ||
-	    scx_bypassing(scx_task_sched(p), cpu_of(rq)))
+	if (!remaining || !(p->scx.flags & SCX_TASK_QUEUED))
 		return false;
 
 	/* never called on a protected rescuee, so the write can't be refused */
@@ -887,9 +886,11 @@ void scx_rescue_init(struct rq *rq)
  * %SCX_ENQ_PREEMPT_LAZY are also cleared on a fallback migration-disabled
  * admission.
  *
- * Bypass doesn't need special-casing as a bypassing sched's tasks are enqueued
- * to and run by its nearest non-bypassing ancestor. If root is bypassing, it
- * always holds all caps.
+ * bypass_enq_target_dsq() also calls this with the host as @sch when the host
+ * lacks %SCX_CAP_BASE on @rq's cid, if rescue is enabled or @p must run on the
+ * cpu, migration-disabled or with a migration pending. The bypassed task is
+ * then admitted or diverted like a capless %SCX_ENQ_RESCUE insert by the host
+ * itself.
  */
 struct scx_dispatch_q *__scx_resolve_local_dsq(struct scx_sched *sch, struct rq *rq,
 					       struct task_struct *p, u64 *enq_flags)
@@ -932,7 +933,7 @@ struct scx_dispatch_q *__scx_resolve_local_dsq(struct scx_sched *sch, struct rq
 	scx_divert_strip_flags(p, enq_flags);
 
 	/* the enqueuer opted for rescue instead of rejection and reenqueue */
-	if ((*enq_flags & SCX_ENQ_RESCUE) && likely(scx_rescue_bw_1024)) {
+	if (scx_rescue_enabled() && (*enq_flags & SCX_ENQ_RESCUE)) {
 		__scx_add_event(sch, SCX_EV_SUB_RESCUE, 1);
 		if (scx_rescue_try_admit(rq, p))
 			return &rq->scx.local_dsq;
@@ -1656,8 +1657,9 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
  *
  * Used when @to must take over @p but failed to initialize it. Bypass keeps
  * scheduling decisions away from @to but @p can still trigger its task ops,
- * which may confuse the BPF side. @to is dying anyway. The exit paths skip
- * %NONE tasks (see __scx_disable_and_exit_task() and switched_from_scx()).
+ * which may confuse the BPF side. @to is dying anyway. The exit paths call no
+ * op on a %NONE task. __scx_disable_and_exit_task() skips it and
+ * switched_from_scx() only ends its slice.
  */
 static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
 {
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index de80a8af524c..b6d4a522a5a3 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -14,6 +14,8 @@
 
 #ifdef CONFIG_EXT_SUB_SCHED
 
+extern s32 scx_rescue_bw_1024;
+
 struct scx_sched *scx_skip_subtree_pre(struct scx_sched *pos, struct scx_sched *root);
 struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root);
 void scx_cid_sched_update(struct rq *rq, struct scx_sched *sch);
@@ -51,6 +53,12 @@ void scx_rescue_dump(struct seq_buf *s, struct rq *rq);
 void scx_rescue_set_knobs(struct scx_sched *sch);
 void scx_rescue_init(struct rq *rq);
 
+/* false only when the root disabled rescue, see scx_rescue_set_knobs() */
+static inline bool scx_rescue_enabled(void)
+{
+	return likely(scx_rescue_bw_1024);
+}
+
 /*
  * cgrp->scx_sched is written by root/sub enable/disable under all of
  * scx_enable_mutex, scx_fork_rwsem and cgroup_mutex. A new cgroup inherits the
@@ -128,6 +136,7 @@ static inline void scx_rescue_end(struct rq *rq) {}
 static inline bool scx_rescue_keep(struct rq *rq, struct task_struct *p) { return false; }
 static inline void scx_rescue_flush(struct rq *rq) {}
 static inline void scx_rescue_dump(struct seq_buf *s, struct rq *rq) {}
+static inline bool scx_rescue_enabled(void) { return false; }
 static inline void scx_rescue_set_knobs(struct scx_sched *sch) {}
 static inline void scx_rescue_init(struct rq *rq) {}
 static inline void scx_dec_has_subs(struct scx_sched *sch) {}
-- 
2.56.0

