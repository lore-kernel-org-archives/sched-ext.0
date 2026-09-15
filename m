Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316D3B6C13
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477443; cv=none; b=NKvA7DWAe+tt7ORrbi9N3PgMChoTwoV44hsIkgN8JdMszYv6cN1egQRg4gnOPbMwNan32z2AodyMDy6xM2yFRjwih+28y0OhB9YwaQ0stqCzJ6EvN/CT4l+oIJ/Ra5bC4a/HSYmRuI2vspsuZH0yoHYkTh6AOAPmRdeZLXdl7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477443; c=relaxed/simple;
	bh=jrXpJ/hnkP4bPrnUrT2dMme1TFKR5RsE0vgRRUPLXts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MaR+jB18+OZuBflkCebqoDRcB/iQ+KXBhS0DyDfWc40x0MPwHdz7Awkf42txfInR7g4tSjiqJn29wB9aa/RQC+QaucL154SDdJFJT0LN5JGHAidLlgPPY6ZELVo5h4yudiSCHO0X3VquzkKwqBdza32SrGVvjTg7fMAFe20EnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e5815a1cb10511f19a56ed5b684f684d-20260915
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:393e163d-886d-4b82-87b7-2f87ff33e354,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:12d433105d933a20fca121374aa7a597,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e5815a1cb10511f19a56ed5b684f684d-20260915
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1875957571; Tue, 15 Sep 2026 21:03:50 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] sched_ext: Don't run ops.dequeue() with a DSQ lock held
Date: Tue, 15 Sep 2026 21:03:33 +0800
Message-Id: <20260915130334.714388-2-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260915130334.714388-1-fangqiurong@kylinos.cn>
References: <aqkQ1MtqtqnS0wUs@gpd4>
 <20260915130334.714388-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

ops.dequeue() is called with the source user DSQ's lock still held on
the consume and move paths (scx_consume_dispatch_q(),
move_task_between_dsqs()) and with the terminal global/bypass DSQ's
lock still held in scx_dispatch_enqueue(). A BPF scheduler that locks
the same DSQ from ops.dequeue() - e.g. by iterating it with
bpf_iter_scx_dsq, which takes the DSQ lock on every step -
self-deadlocks.

Move the invocation after the DSQ unlock on all three paths.
SCX_TASK_IN_CUSTODY is cleared under the lock so that the callback is
invoked exactly once; it is not ordered against consumption of the
task and may run after the task has been moved to, or consumed from,
a terminal DSQ.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
---
 Documentation/scheduler/sched-ext.rst |  4 +-
 kernel/sched/ext/ext.c                | 67 +++++++++++++++++++++------
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 794ae80b3ba3..6e65d3b38951 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -361,7 +361,9 @@ The following briefly shows how a waking task is scheduled and executed.
    ``scx_bpf_dsq_reenq()``. The task stays in BPF custody the entire time.
 
    When a task leaves BPF scheduler custody, ``ops.dequeue()`` is invoked.
-   The dequeue can happen for different reasons, distinguished by flags:
+   The callback is not ordered against consumption of the task and may run
+   after the task has been moved to, or consumed from, a terminal DSQ. The
+   dequeue can happen for different reasons, distinguished by flags:
 
    1. **Regular dispatch**: when a task in BPF custody is dispatched to a
       terminal DSQ from ``ops.dispatch()`` (leaving BPF custody for
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 40fa1697bdb7..13efddb729e3 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1499,20 +1499,28 @@ static inline bool task_scx_migrating(struct task_struct *p)
 	return p->scx.sticky_cpu >= 0;
 }
 
+/* Must be called under the lock serializing @p's custody transfers. */
+static bool task_leave_custody(struct task_struct *p)
+{
+	if (!(p->scx.flags & SCX_TASK_IN_CUSTODY) || task_scx_migrating(p))
+		return false;
+
+	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+	return true;
+}
+
 /*
  * Call ops.dequeue() if the task is in BPF custody and not migrating.
- * Clears %SCX_TASK_IN_CUSTODY when the callback is invoked.
+ * Clears %SCX_TASK_IN_CUSTODY before the callback is invoked.
  */
 static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
 			      struct task_struct *p, u64 deq_flags)
 {
-	if (!(p->scx.flags & SCX_TASK_IN_CUSTODY) || task_scx_migrating(p))
+	if (!task_leave_custody(p))
 		return;
 
 	if (SCX_HAS_OP(sch, dequeue))
 		SCX_CALL_OP_TASK(sch, dequeue, rq, p, deq_flags);
-
-	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
 }
 
 static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
@@ -1705,20 +1713,28 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
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
+		 * The custody transfer happens under @dsq->lock so that
+		 * later consumers see the flag clear; the callback runs
+		 * unlocked - it must not run with a DSQ lock held.
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
@@ -2373,11 +2389,13 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 		scx_schedule_reenq_local(rq, 0);
 }
 
-void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
-				      u64 enq_flags, struct scx_dispatch_q *src_dsq,
-				      struct rq *dst_rq)
+static struct scx_dispatch_q *
+__scx_move_local_task_to_local_dsq(struct scx_sched *sch,
+				   struct task_struct *p, u64 *enq_flags,
+				   struct scx_dispatch_q *src_dsq,
+				   struct rq *dst_rq)
 {
-	struct scx_dispatch_q *dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
+	struct scx_dispatch_q *dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, enq_flags);
 
 	/* @p is on @dst_rq, an rq-owned @src_dsq is covered by the rq lock */
 	if (!dsq_is_rq_owned(src_dsq))
@@ -2386,14 +2404,25 @@ void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 
-	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+	if (*enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		dsq_insert_head(dst_dsq, p);
 	else
 		list_add_tail(&p->scx.dsq_list.node, &dst_dsq->list);
 
-	dsq_inc_nr(dst_dsq, p, enq_flags);
+	dsq_inc_nr(dst_dsq, p, *enq_flags);
 	p->scx.dsq = dst_dsq;
 
+	return dst_dsq;
+}
+
+void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
+				      u64 enq_flags, struct scx_dispatch_q *src_dsq,
+				      struct rq *dst_rq)
+{
+	struct scx_dispatch_q *dst_dsq;
+
+	dst_dsq = __scx_move_local_task_to_local_dsq(sch, p, &enq_flags,
+						     src_dsq, dst_rq);
 	rq_owned_post_enq(sch, dst_rq, dst_dsq, p, enq_flags);
 }
 
@@ -2628,9 +2657,14 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		/* @p is going from a non-local DSQ to a local DSQ */
 		if (src_rq == dst_rq) {
+			struct scx_dispatch_q *ldsq;
+
 			scx_task_unlink_from_dsq(p, src_dsq);
-			scx_move_local_task_to_local_dsq(sch, p, enq_flags, src_dsq, dst_rq);
+			ldsq = __scx_move_local_task_to_local_dsq(sch, p,
+								  &enq_flags,
+								  src_dsq, dst_rq);
 			raw_spin_unlock(&src_dsq->lock);
+			rq_owned_post_enq(sch, dst_rq, ldsq, p, enq_flags);
 		} else {
 			raw_spin_unlock(&src_dsq->lock);
 			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
@@ -2679,9 +2713,14 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			break;
 
 		if (rq == task_rq) {
+			struct scx_dispatch_q *ldsq;
+
 			scx_task_unlink_from_dsq(p, dsq);
-			scx_move_local_task_to_local_dsq(sch, p, enq_flags, dsq, rq);
+			ldsq = __scx_move_local_task_to_local_dsq(sch, p,
+								  &enq_flags,
+								  dsq, rq);
 			raw_spin_unlock(&dsq->lock);
+			rq_owned_post_enq(sch, rq, ldsq, p, enq_flags);
 			return true;
 		}
 
-- 
2.43.0

