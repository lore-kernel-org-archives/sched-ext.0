Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A403D9524
	for <sched-ext@lists.linux.dev>; Thu, 17 Sep 2026 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631589; cv=none; b=t0HX3jDoMHtMc1IF//NgeuhgHopZNVd6OY8qKkR+qEh3i6xusStB4IOCtVNPyvfYDTbRW2AIR4vhr1GK0X9jtq0WiILboAQWdR64kUVkEB5E7p0FDVsZW+9P8+3AAP4QzRe5yr00A/h0PbmuxZqFPw4WstNt1fTkGrsRv+9kfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631589; c=relaxed/simple;
	bh=YbuRMNv25pO8uYTZMKV9IgnMlSBCCJnpNRbS4ldH72E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I716YiWU8OtIm/YIEbsiSo9CwPVA6SrLq2R/qA0iMx7Sn9wcQdgSFJORheyN7sHSODZdJWYhrtXd9k6WzyINF4DK3LG/w3GAhcSdbyePGJZgcxBpvMtgvSKGlxm1F8RkEijfjqrn15GboveTNAxLoFxr9cbNMp/7w5KCvBH+e9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c932a452b26c11f19a56ed5b684f684d-20260917
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:23fae2e2-e473-4648-8dde-a0e12851e89d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:9f61a4e324dd8305f9cc9ea7758d02b3,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c932a452b26c11f19a56ed5b684f684d-20260917
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1425617148; Thu, 17 Sep 2026 15:52:52 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] sched_ext: Don't run ops.dequeue() with a DSQ lock held
Date: Thu, 17 Sep 2026 15:52:41 +0800
Message-Id: <20260917075242.2813147-2-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260917075242.2813147-1-fangqiurong@kylinos.cn>
References: <20260917075242.2813147-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

ops.dequeue() is invoked with the source user DSQ's lock still held on
the consume and move paths (scx_consume_dispatch_q(),
move_task_between_dsqs()). A BPF scheduler which locks the source user
DSQ from ops.dequeue() - e.g. by iterating it with bpf_iter_scx_dsq -
self-deadlocks.

ops.dequeue() can only call the "any" kfuncs and none of them can lock a
builtin DSQ, so the global and bypass paths can't deadlock; however,
all DSQ locks share one lockdep class, so iterating any user DSQ from
ops.dequeue() on those paths trips the recursion check.

Move the invocation after the DSQ unlock on all three paths.
SCX_TASK_IN_CUSTODY is cleared under the lock serializing the transfer
so that the callback is invoked exactly once.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Cc: stable@vger.kernel.org # v7.1+
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
---
 kernel/sched/ext/ext.c      | 44 ++++++++++++++++++-------------------
 kernel/sched/ext/internal.h |  3 +--
 kernel/sched/ext/sub.c      | 10 ++++-----
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 40fa1697bdb7..d62ee3e3ea60 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1499,27 +1499,22 @@ static inline bool task_scx_migrating(struct task_struct *p)
 	return p->scx.sticky_cpu >= 0;
 }
 
-/*
- * Call ops.dequeue() if the task is in BPF custody and not migrating.
- * Clears %SCX_TASK_IN_CUSTODY when the callback is invoked.
- */
-static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
-			      struct task_struct *p, u64 deq_flags)
+/* Must be called under the lock serializing @p's custody transfers. */
+static bool task_leave_custody(struct task_struct *p)
 {
 	if (!(p->scx.flags & SCX_TASK_IN_CUSTODY) || task_scx_migrating(p))
-		return;
-
-	if (SCX_HAS_OP(sch, dequeue))
-		SCX_CALL_OP_TASK(sch, dequeue, rq, p, deq_flags);
+		return false;
 
 	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+	return true;
 }
 
 static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 			      struct scx_dispatch_q *dsq, struct task_struct *p,
 			      u64 enq_flags)
 {
-	call_task_dequeue(sch, rq, p, 0);
+	if (task_leave_custody(p) && SCX_HAS_OP(sch, dequeue))
+		SCX_CALL_OP_TASK(sch, dequeue, rq, p, 0);
 
 	/*
 	 * Only local inserts get the wakeup treatment below. Rejects kick the
@@ -1705,20 +1700,28 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	if (is_rq_owned) {
 		rq_owned_post_enq(sch, rq, dsq, p, enq_flags);
 	} else {
+		bool call_dequeue = false;
+
 		/*
 		 * Global and bypass DSQs are terminal - the task leaves the
-		 * scheduler's custody, so ops.dequeue() fires here. It can run
+		 * scheduler's custody, so ops.dequeue() fires. It can run
 		 * without @p's rq lock (finish_dispatch() passes the dispatch
 		 * rq); that's safe because dequeue_task_scx() waits on
 		 * SCX_OPSS_DISPATCHING (see the ops_state note above) and so
 		 * can't race it. A non-terminal DSQ keeps the task in custody.
+		 * The custody transfer happens under @dsq->lock so that later
+		 * consumers see the flag clear; the callback runs after
+		 * @dsq->lock is dropped because it may lock a DSQ itself.
 		 */
 		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS)
-			call_task_dequeue(sch, rq, p, 0);
+			call_dequeue = task_leave_custody(p);
 		else
 			p->scx.flags |= SCX_TASK_IN_CUSTODY;
 
 		raw_spin_unlock(&dsq->lock);
+
+		if (call_dequeue && SCX_HAS_OP(sch, dequeue))
+			SCX_CALL_OP_TASK(sch, dequeue, rq, p, 0);
 	}
 
 	/*
@@ -2210,7 +2213,7 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		/*
 		 * A queued task must always be in BPF scheduler's custody. If
 		 * SCX_TASK_IN_CUSTODY is clear, finish_dispatch() on another
-		 * CPU has already passed call_task_dequeue() (which clears the
+		 * CPU has already passed task_leave_custody() (which clears the
 		 * flag), but has not yet written SCX_OPSS_NONE. That final
 		 * store does not require this rq's lock, so retrying with
 		 * cpu_relax() is bounded: we will observe NONE (or DISPATCHING,
@@ -2258,7 +2261,8 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	 * NONE but the task may still have %SCX_TASK_IN_CUSTODY set until
 	 * it is enqueued on the destination.
 	 */
-	call_task_dequeue(sch, rq, p, deq_flags);
+	if (task_leave_custody(p) && SCX_HAS_OP(sch, dequeue))
+		SCX_CALL_OP_TASK(sch, dequeue, rq, p, deq_flags);
 }
 
 static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_flags)
@@ -2374,14 +2378,10 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 }
 
 void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
-				      u64 enq_flags, struct scx_dispatch_q *src_dsq,
-				      struct rq *dst_rq)
+				      u64 enq_flags, struct rq *dst_rq)
 {
 	struct scx_dispatch_q *dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
 
-	/* @p is on @dst_rq, an rq-owned @src_dsq is covered by the rq lock */
-	if (!dsq_is_rq_owned(src_dsq))
-		lockdep_assert_held(&src_dsq->lock);
 	lockdep_assert_rq_held(dst_rq);
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
@@ -2629,8 +2629,8 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		/* @p is going from a non-local DSQ to a local DSQ */
 		if (src_rq == dst_rq) {
 			scx_task_unlink_from_dsq(p, src_dsq);
-			scx_move_local_task_to_local_dsq(sch, p, enq_flags, src_dsq, dst_rq);
 			raw_spin_unlock(&src_dsq->lock);
+			scx_move_local_task_to_local_dsq(sch, p, enq_flags, dst_rq);
 		} else {
 			raw_spin_unlock(&src_dsq->lock);
 			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
@@ -2680,8 +2680,8 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 
 		if (rq == task_rq) {
 			scx_task_unlink_from_dsq(p, dsq);
-			scx_move_local_task_to_local_dsq(sch, p, enq_flags, dsq, rq);
 			raw_spin_unlock(&dsq->lock);
+			scx_move_local_task_to_local_dsq(sch, p, enq_flags, rq);
 			return true;
 		}
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index eb608d23bf20..0e6a359ad316 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2068,8 +2068,7 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
 void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
-				      u64 enq_flags, struct scx_dispatch_q *src_dsq,
-				      struct rq *dst_rq);
+				      u64 enq_flags, struct rq *dst_rq);
 bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			    struct scx_dispatch_q *dsq, u64 enq_flags);
 bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 46359f12080b..463afbf0b275 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -555,8 +555,8 @@ static void scx_rescue_timerfn(struct timer_list *timer)
 				     scx.dsq_list.node);
 		scx_task_unlink_from_dsq(p, &rq->scx.rescue.dsq);
 		scx_rescue_admit(rq, p, slice);
-		scx_move_local_task_to_local_dsq(scx_task_sched(p), p, SCX_ENQ_IGNORE_CAPS,
-						 &rq->scx.rescue.dsq, rq);
+		scx_move_local_task_to_local_dsq(scx_task_sched(p), p,
+						 SCX_ENQ_IGNORE_CAPS, rq);
 		if (sched_class_above(&ext_sched_class, rq->curr->sched_class))
 			resched_curr(rq);
 	} else if (p->scx.dsq && rq->scx.rescue.budget > 2 * scx_rescue_quantum_ns) {
@@ -572,7 +572,7 @@ static void scx_rescue_timerfn(struct timer_list *timer)
 		scx_task_unlink_from_dsq(p, &rq->scx.local_dsq);
 		scx_move_local_task_to_local_dsq(scx_task_sched(p), p,
 					SCX_ENQ_HEAD | SCX_ENQ_PREEMPT | SCX_ENQ_IGNORE_CAPS,
-					&rq->scx.local_dsq, rq);
+					rq);
 	}
 out_arm:
 	scx_rescue_timer_arm(rq);
@@ -596,8 +596,8 @@ void scx_rescue_flush(struct rq *rq)
 	/* and flush out all pending ones */
 	list_for_each_entry_safe(p, n, &rq->scx.rescue.dsq.list, scx.dsq_list.node) {
 		scx_task_unlink_from_dsq(p, &rq->scx.rescue.dsq);
-		scx_move_local_task_to_local_dsq(scx_task_sched(p), p, SCX_ENQ_IGNORE_CAPS,
-						 &rq->scx.rescue.dsq, rq);
+		scx_move_local_task_to_local_dsq(scx_task_sched(p), p,
+						 SCX_ENQ_IGNORE_CAPS, rq);
 	}
 
 	timer_delete(&rq->scx.rescue.timer);
-- 
2.43.0

