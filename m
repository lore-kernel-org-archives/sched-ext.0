Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778183;
	b=tD6hJUbgp2lii98ccfci6L+wtVm4FEyHzL2tHmMK+scHYZKYpjJkQcF3mQPQ/k4mHd7c
	 jOwSKjVJF5xVeZMFYnRNjexMzVrWvwBvh+aeVnfMALs1xfXE5k96OGbrsMf89YneQYL4X
	 IV9Mb5OVVuC6cKQE4XJxgnaIKSnha2LYZ0pOFR/vguTLpCHf/81RtXzJLNDuCCcSwqhto
	 K/1mbklyI+9Q7DjPExhinZClHsVJMwapAkmkh4UzJiMWrN/ZWSm+4Ts2Yu5f7y6ANspOH
	 wip7EZuUBMEOC0N/iB/wStK17Bqkj7muc6ffJ6H74tPehaolygWpja2E8faN0O8IWHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778183;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=14CT94+z8/9MqLzlxjosl8Q2bYXMhiZHbDa9qNa3xoU=;
	b=A0t9Ov+wT0xq5kToTJQhXIo2SywbWzyrEGpT9Wz6AsxzcNh9sYipiPqK2X8vPnWzhYlM
	 Y2mxFrm+KopyjD/mC6v2KzWvPHwoaQ+eRQrL46kG5HoYP70A15CgdpG8wH+wFlgx/YbIh
	 BQFULk9t4BSZQUbzMTpN2VuGFSPBJnbxbs3GnMQa1LOqTSrdOSYF7Xp8f3qiASFq3BpTJ
	 pyh+/+7WNmdEMwj/undOlZRehHkdVnOmI1XsUGLzzUk1qYMaj51yT5mkcqXckju8rcSVS
	 nd8BRRyOxKGkbqeo8xwj9Le4Kv16zZBz6jhdqa0ZRtyg0LvI2VFTXoJ6Mysdj0kSLFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCdc8Z0h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE160A383B;
	Fri, 23 Oct 2026 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCdc8Z0h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA8B1F031EA;
	Fri, 23 Oct 2026 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778183;
	bh=14CT94+z8/9MqLzlxjosl8Q2bYXMhiZHbDa9qNa3xoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aCdc8Z0hMq3DsLwauvB1LCw7FtIbbTRzZCK23oQ+FQ3yvs7v9G/OrWJHHSQzXMWXN
	 BOq+5IrG1y+tYJ3dr5XBnTiztOOv2EYgwsh56WSF/YuYxY9q6p5kEuIgVsAl6fcHR/
	 8czhXaG8jWaXqAhZ2NfKnmCUpYoTAjqYbfklo5yOxzhwwbJCQ/lw0H7y3xPnDODkOn
	 rHxOREMr0SqxJPMuHau4A0TAymcxtdG4CUR88CCfEF/MmY2OWl3LXzc1GIvZc1ceyU
	 I4QytHk/heBeDdpXJA/bOZ9vcUeJ6LUjLQzqmZVuk8643uqasbgnWQ8n5xgksNrOmx
	 DopPgGmr2vPMw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/17] sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE
Date: Fri, 23 Oct 2026 07:56:04 -1000
Message-ID: <20261023175608.4120910-14-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023175608.4120910-1-tj@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org>
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

Fixes: 147d1885f390 ("sched_ext: Add the SCX_CAP_ENQ_IMMED cap")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 40 +++++++++++++++++++++++++++++++++++-----
 kernel/sched/ext/sub.c | 19 ++++++++++---------
 kernel/sched/ext/sub.h |  9 +++++++++
 3 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 6dc6ab2cb29c..54150fdc3bbd 100644
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
@@ -2322,7 +2347,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	dsq = find_global_dsq(sch, task_cpu(p));
 	goto enqueue;
 bypass:
-	dsq = bypass_enq_target_dsq(sch, task_cpu(p));
+	dsq = bypass_enq_target_dsq(sch, rq, p, &enq_flags);
 	goto enqueue;
 
 enqueue:
@@ -3683,8 +3708,13 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 25d8d457668f..60b35cf2f96d 100644
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
@@ -492,8 +492,8 @@ void scx_rescue_end(struct rq *rq)
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
@@ -501,8 +501,7 @@ bool scx_rescue_keep(struct rq *rq, struct task_struct *p)
 
 	lockdep_assert_rq_held(rq);
 
-	if (!remaining || !(p->scx.flags & SCX_TASK_QUEUED) ||
-	    scx_bypassing(scx_task_sched(p), cpu_of(rq)))
+	if (!remaining || !(p->scx.flags & SCX_TASK_QUEUED))
 		return false;
 
 	/* never called on a protected rescuee, so the write can't be refused */
@@ -860,9 +859,11 @@ void scx_rescue_init(struct rq *rq)
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
@@ -905,7 +906,7 @@ struct scx_dispatch_q *__scx_resolve_local_dsq(struct scx_sched *sch, struct rq
 	scx_divert_strip_flags(p, enq_flags);
 
 	/* the enqueuer opted for rescue instead of rejection and reenqueue */
-	if ((*enq_flags & SCX_ENQ_RESCUE) && likely(scx_rescue_bw_1024)) {
+	if (scx_rescue_enabled() && (*enq_flags & SCX_ENQ_RESCUE)) {
 		__scx_add_event(sch, SCX_EV_SUB_RESCUE, 1);
 		if (scx_rescue_try_admit(rq, p))
 			return &rq->scx.local_dsq;
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 223c34309b5a..acd7b4210906 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -14,6 +14,8 @@
 
 #ifdef CONFIG_EXT_SUB_SCHED
 
+extern s32 scx_rescue_bw_1024;
+
 struct scx_sched *scx_skip_subtree_pre(struct scx_sched *pos, struct scx_sched *root);
 struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root);
 void scx_cid_sched_update(struct rq *rq, struct scx_sched *sch);
@@ -48,6 +50,12 @@ void scx_rescue_dump(struct seq_buf *s, struct rq *rq);
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
@@ -122,6 +130,7 @@ static inline void scx_rescue_end(struct rq *rq) {}
 static inline bool scx_rescue_keep(struct rq *rq, struct task_struct *p) { return false; }
 static inline void scx_rescue_flush(struct rq *rq) {}
 static inline void scx_rescue_dump(struct seq_buf *s, struct rq *rq) {}
+static inline bool scx_rescue_enabled(void) { return false; }
 static inline void scx_rescue_set_knobs(struct scx_sched *sch) {}
 static inline void scx_rescue_init(struct rq *rq) {}
 static inline void scx_dec_has_subs(struct scx_sched *sch) {}
-- 
2.56.0

