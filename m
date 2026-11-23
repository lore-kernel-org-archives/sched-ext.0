Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453838;
	b=i+1CQRNIlJpB2asN2gizNCInR67FKtv/tKsFE9exW0Y4KzdGp2acYf2UGsJ++/gJbfTf
	 LGRLwSZT3gk0/1gCV0wQzF4igjSkm3OV93K7Jy6ejh39BJeqg4ZQ1M2K3UaSUJg1akCrF
	 YEZPiRAtKUst6T+51pcqluEOXzBI+ASQu74gsD9qWmdSbsD3xCWoqQEYTddVjY/qTBDM/
	 itBK0SsDhxd8ngwq4kKMXSGHrDOHevSfOFYKr6iUZMuVsIWLUpz2Si4keegttnOWAUozQ
	 ziSOPAAt30EQDozipPMcxXOzhNs6+mWcMTQXHG8Yx7yMdrIq9thYgP/KD4euQ1rlEVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=U1uhsLK+1BijDwudl9VT8kedueaPR4CUdht7qwZBvlk=;
	b=1GpAlw5E21RyLhHoOi3qbkpqvncIX3oLtMP1WP6M3B+NTIlNSMq0YkHgolkSK5JzluI8
	 YlHOH8NkXMoDnYgmiW+DnaZGBGMuIA2sir1UBwMa9Cn4sU2o/ED0PryFPwQiiHx+wt+tP
	 EXL8yXDYKUCxj20DHugRWqBKdC7fpU5aMGzIW13kmytJrWvRLAWuwx64J6UaNzXTcQiFD
	 25yvoSUYVsByLz0bSPcgoqsetDTPM8guWcpTmHrCRCzm79H1KGhATtnwFYfeplA38RZMw
	 QAoyelsdwDRxrP0e68oAAVFUffDLs1Au/d85STC7kxHykC1qTpIjmeYNCOQTNQtIBvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KoDKogXh;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174A606A339
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 17:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F174A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KoDKogXh
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4ad3d35e899so29258115e9.1
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 09:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795453836; x=1796058636; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1uhsLK+1BijDwudl9VT8kedueaPR4CUdht7qwZBvlk=;
        b=KoDKogXhkqaHz0TBwlC0c+tBqCDsELql+SB4HjbiGGsDXlo6XnqkY06p6W5/QW8PBe
         jv5CRCRmazUBT9+zBSgg2mZB10HB8z3fIvbPYxgfVs1UjzxQkfEBXPAkXFnXl222jBmv
         rRf0/De4SbOvomtreWq5qW25hcb2pY7g0wJmafXhmQC5SMyz8trp6YNkgGFMfqnvj3sv
         ba/rRoIoBYsX63H+OmRqVNQPz/kK7VQeLktkavB8acIRTs0jZjae+3dSY1x2vjwSMtN1
         9lA3XLlqN1cR3EA+L0WHu4iLnUNW2kOoQa5zmFvAUChtctexKfV+CL6SwZpAvU6il5O8
         m09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453836; x=1796058636;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1uhsLK+1BijDwudl9VT8kedueaPR4CUdht7qwZBvlk=;
        b=U5OpEbKPB7FQIlY412tY95QzxgrP9/9O7oPr8LLAh/IlH62LuRJ5FvwOAK04ozd2rJ
         hicpkMk+JVtjHHOQr87Q+NOg7r0nUvF3iSFqyVZ7Hoh/2yXrP7nndHLV8YMcIOq/6wZ4
         Ro6kwmsGLX2B4c/vHJGXie15wzGWOk18MXQLmud4+3KH8KVMZxqB1/+vZsG/i02nWsPj
         n7VbEWMoUpcg2Nbg0S8rAI/GjhHTZoMlKWXFNgrma6Tx4O1X5rsd04urQc9SV/J8YbtT
         kFPXIlNg+e6BtqicV0/MvUKLd0XmXWaTrsvl3P5j1ncTHPeQ3ac4r6/eLjjsR/R4rsed
         +pXA==
X-Forwarded-Encrypted: i=1; AL+hErGfD41NA+PUkOZGTiXAhxefKWcLt5LuAqH7xJ3X0ntWaYGQQo0KTq+HUHL25zvl6uKF9H1U4Uv8uQ8=@lists.linux.dev
X-Gm-Message-State: APuU4Z8VxTDNgvuFi0d3C21XyEjn3fgu42jxb0fgigF3EO0c5G+WePG5
	s1kxyp5kF4uX/VqGhx1txwOrOYiPe9Y1Q6oqZT2CGzls3Zi913/AeyMyxZtwW9tDgQsz01VP54e
	6lTOhdOXNHtJF/g==
X-Received: from wma5.prod.google.com ([2002:a05:600c:8905:b0:4b6:fd58:3209])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c1b:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4bb887e2677mr292493835e9.4.1795453836207;
 Mon, 23 Nov 2026 09:10:36 -0800 (PST)
Date: Mon, 23 Nov 2026 17:10:32 +0000
In-Reply-To: <20261123170846.3165648-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123170846.3165648-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123170846.3165648-2-jpiecuch@google.com>
Subject: [PATCH 1/3] sched_ext: Fix ops_state and ops.dequeue() locking races
 in dispatch
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, fangqiurong <fangqiurong@kylinos.cn>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When finish_dispatch() inserts a task into a non-local DSQ, the task
becomes visible on the DSQ while still SCX_OPSS_DISPATCHING: ops_state
is only cleared after the DSQ is unlocked and, for terminal DSQs, after
ops.dequeue() returns. A CPU that takes the task off the DSQ in that
window can requeue it, and the late store then overwrites the new
QUEUED state, so the task is never dispatched again. Commit 7de9a6fb44ea
("sched_ext: Wait for SCX_OPSS_DISPATCHING before reenqueueing a task")
and commit 2935062be771 ("sched_ext: Wait for SCX_OPSS_DISPATCHING before
moving tasks off DSQs") work around this by spinning wherever a task is
taken off a DSQ.

Also, for a remote task dispatched to SCX_DSQ_GLOBAL (or to a destroyed
user DSQ, which falls back to the global DSQ), scx_dispatch_enqueue()
runs with only the dispatching CPU's rq locked. task_leave_custody() then
does an unlocked RMW of p->scx.flags, which can lose concurrent updates
made under the task's rq lock (e.g. SCX_TASK_SUB_INIT). ops.dequeue()
also runs with scx_locked_rq() set to the wrong rq, so for example
scx_bpf_cpuperf_set(scx_bpf_task_cpu(p), ...) aborts the scheduler with
"Invalid target CPU".

Fix both:

- Clear ops_state while the DSQ (or rq) is still locked and before
  ops.dequeue().

- Insert a remote task into the global DSQ under its rq lock, using the
  holding_cpu handoff from dispatch_to_local_dsq(), factored out into
  release_dispatching_and_lock_task_rq(). scx_dispatch_enqueue() now
  returns false on a destroyed user DSQ if the caller doesn't hold the
  task's rq lock, so finish_dispatch() can take the same path.

- Only set SCX_TASK_IN_CUSTODY with the task's rq locked, and add
  lockdep assertions where p->scx.flags is updated and ops.dequeue() is
  called. Drop the now impossible QUEUED && !IN_CUSTODY retry from
  ops_dequeue() and the scx_bypass() comment about unlocked
  p->scx.flags writes by an in-flight dispatch.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Fixes: cb86607ada73 ("sched_ext: Don't run ops.dequeue() with a DSQ lock held")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 237 +++++++++++++++++++++++++----------------
 1 file changed, 145 insertions(+), 92 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e8c30a21e03e..6d8483fb8304 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1778,6 +1778,8 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 			      struct scx_dispatch_q *dsq, struct task_struct *p,
 			      u64 enq_flags)
 {
+	lockdep_assert_rq_held(rq);
+
 	if (task_leave_custody(p) && SCX_HAS_OP(sch, dequeue))
 		SCX_CALL_OP_TASK(sch, dequeue, rq, p, 0);
 
@@ -1852,11 +1854,22 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	}
 }
 
-static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
+/*
+ * Insert @p into @dsq with @rq locked. Unless finish_dispatch() is inserting a
+ * remote task into a user DSQ, @rq must be @p's rq.
+ *
+ * If @dsq was destroyed and @rq is not @p's rq, leave @p untouched and return
+ * %false. Falling back to the global DSQ ends custody and requires @p's rq
+ * lock, so the caller must switch to @p's rq lock and fall back there. Return
+ * %true otherwise.
+ */
+static bool scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 				 struct scx_dispatch_q *dsq, struct task_struct *p,
 				 u64 slice, u64 vtime, u64 enq_flags)
 {
-	bool is_rq_owned = dsq_is_rq_owned(dsq);
+	bool is_rq_owned = dsq_is_rq_owned(dsq), call_dequeue = false;
+
+	lockdep_assert_rq_held(rq);
 
 	if (dsq->id == SCX_DSQ_LOCAL)
 		dsq = scx_resolve_local_dsq(sch, rq, p, &enq_flags);
@@ -1871,8 +1884,10 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 
 		if (unlikely(dsq->id == SCX_DSQ_INVALID)) {
 			scx_error(sch, "attempting to dispatch to a destroyed dsq");
-			/* fall back to the global dsq */
 			raw_spin_unlock(&dsq->lock);
+			if (rq != task_rq(p))
+				return false;
+			/* fall back to the global dsq */
 			dsq = find_global_dsq(sch, task_cpu(p));
 			raw_spin_lock(&dsq->lock);
 		}
@@ -1960,45 +1975,49 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	p->scx.dsq = dsq;
 
 	/*
-	 * Update custody and call ops.dequeue() before clearing ops_state:
-	 * once ops_state is cleared, waiters in ops_dequeue() can proceed
-	 * and dequeue_task_scx() will RMW p->scx.flags. If we clear
-	 * ops_state first, both sides would modify p->scx.flags
-	 * concurrently in a non-atomic way.
+	 * Global and bypass DSQs are terminal - the task leaves the scheduler's
+	 * custody, so ops.dequeue() fires. A non-terminal DSQ keeps the task in
+	 * custody. The custody transfer happens under @dsq->lock so that later
+	 * consumers see the flag clear; the callback runs after @dsq->lock is
+	 * dropped because it may lock a DSQ itself.
+	 *
+	 * @p->scx.flags is protected by @p's rq lock. finish_dispatch() may
+	 * insert a remote task without it but only into a user DSQ and only
+	 * with %SCX_TASK_IN_CUSTODY already set, so @p->scx.flags is updated
+	 * only when @p's rq is locked.
 	 */
-	if (is_rq_owned) {
-		rq_owned_post_enq(sch, rq, dsq, p, enq_flags);
-	} else {
-		bool call_dequeue = false;
-
-		/*
-		 * Global and bypass DSQs are terminal - the task leaves the
-		 * scheduler's custody, so ops.dequeue() fires. It can run
-		 * without @p's rq lock (finish_dispatch() passes the dispatch
-		 * rq); that's safe because dequeue_task_scx() waits on
-		 * SCX_OPSS_DISPATCHING (see the ops_state note above) and so
-		 * can't race it. A non-terminal DSQ keeps the task in custody.
-		 * The custody transfer happens under @dsq->lock so that later
-		 * consumers see the flag clear; the callback runs after
-		 * @dsq->lock is dropped because it may lock a DSQ itself.
-		 */
-		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS)
+	if (!is_rq_owned) {
+		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS) {
+			lockdep_assert_rq_held(task_rq(p));
 			call_dequeue = task_leave_custody(p);
-		else
+		} else if (rq == task_rq(p)) {
 			p->scx.flags |= SCX_TASK_IN_CUSTODY;
-
-		raw_spin_unlock(&dsq->lock);
-
-		if (call_dequeue && SCX_HAS_OP(sch, dequeue))
-			SCX_CALL_OP_TASK(sch, dequeue, rq, p, 0);
+		}
 	}
 
 	/*
 	 * We're transitioning out of QUEUEING or DISPATCHING. store_release to
 	 * match waiters' load_acquire.
+	 *
+	 * Do it while @dsq is still locked and before ops.dequeue() so that @p
+	 * is never visible on a DSQ while still owned by the dispatcher.
+	 * Anyone who finds @p on @dsq can take it off without waiting on
+	 * DISPATCHING. Updating @p->scx.flags and calling ops.dequeue() after
+	 * the transition is safe as both are done under @p's rq lock.
 	 */
 	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
 		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
+
+	if (is_rq_owned) {
+		rq_owned_post_enq(sch, rq, dsq, p, enq_flags);
+	} else {
+		raw_spin_unlock(&dsq->lock);
+
+		if (call_dequeue && SCX_HAS_OP(sch, dequeue))
+			SCX_CALL_OP_TASK(sch, dequeue, rq, p, 0);
+	}
+
+	return true;
 }
 
 void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq)
@@ -2528,7 +2547,6 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	 */
 	clr_task_runnable(p, false);
 
-retry:
 	/* acquire ensures that we see the preceding updates on QUEUED */
 	opss = atomic_long_read_acquire(&p->scx.ops_state);
 
@@ -2542,20 +2560,6 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
-		/*
-		 * A queued task must always be in BPF scheduler's custody. If
-		 * SCX_TASK_IN_CUSTODY is clear, finish_dispatch() on another
-		 * CPU has already passed task_leave_custody() (which clears the
-		 * flag), but has not yet written SCX_OPSS_NONE. That final
-		 * store does not require this rq's lock, so retrying with
-		 * cpu_relax() is bounded: we will observe NONE (or DISPATCHING,
-		 * handled by the fallthrough) on a subsequent iteration.
-		 */
-		if (unlikely(!(READ_ONCE(p->scx.flags) & SCX_TASK_IN_CUSTODY))) {
-			cpu_relax();
-			goto retry;
-		}
-
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
 			break;
@@ -2580,18 +2584,13 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	}
 
 	/*
-	 * Call ops.dequeue() if the task is still in BPF custody.
+	 * Call ops.dequeue() if @p is still in BPF custody. @p can be in
+	 * %SCX_OPSS_NONE with %SCX_TASK_IN_CUSTODY set in two cases:
 	 *
-	 * The code that clears ops_state to %SCX_OPSS_NONE does not always
-	 * clear %SCX_TASK_IN_CUSTODY: in dispatch_to_local_dsq(), when
-	 * we're moving a task that was in %SCX_OPSS_DISPATCHING to a
-	 * remote CPU's local DSQ, we only set ops_state to %SCX_OPSS_NONE
-	 * so that a concurrent dequeue can proceed, but we clear
-	 * %SCX_TASK_IN_CUSTODY only when we later enqueue or move the
-	 * task. So we can see NONE + IN_CUSTODY here and we must handle
-	 * it. Similarly, after waiting on %SCX_OPSS_DISPATCHING we see
-	 * NONE but the task may still have %SCX_TASK_IN_CUSTODY set until
-	 * it is enqueued on the destination.
+	 * - @p is on, or being moved off, a user DSQ.
+	 * - release_dispatching_and_lock_task_rq() cleared ops_state to let a
+	 *   racing dequeue proceed, before locking @p's rq to finish the
+	 *   dispatch.
 	 */
 	if (task_leave_custody(p) && SCX_HAS_OP(sch, dequeue))
 		SCX_CALL_OP_TASK(sch, dequeue, rq, p, deq_flags);
@@ -3166,6 +3165,48 @@ bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq)
 	return scx_consume_dispatch_q(sch, rq, &sch->pnode[node]->global_dsq, 0);
 }
 
+/**
+ * release_dispatching_and_lock_task_rq - Release DISPATCHING and lock task_rq
+ * @p: task being dispatched, owned by the caller (e.g. through
+ *     %SCX_OPSS_DISPATCHING)
+ * @locked_rq: currently locked rq
+ * @src_rq: @p's rq, stable while the caller owns @p
+ *
+ * @p is on a possibly remote @src_rq which we need to lock. If dequeue is in
+ * progress, it'd be locking @src_rq and waiting on DISPATCHING, so we can't
+ * grab @src_rq lock while holding DISPATCHING.
+ *
+ * As @p is wholly ours, we can pretend that we're moving from a DSQ and use the
+ * same mechanism - mark the task under transfer with holding_cpu, release
+ * DISPATCHING and then follow the same protocol. See
+ * unlink_dsq_and_switch_rq_lock().
+ *
+ * On return, @src_rq is locked. Return %true if @p is still ours, with
+ * holding_cpu cleared. Return %false if @p was lost to a dequeue.
+ */
+static bool release_dispatching_and_lock_task_rq(struct task_struct *p,
+						 struct rq *locked_rq,
+						 struct rq *src_rq)
+{
+	p->scx.holding_cpu = raw_smp_processor_id();
+
+	/* store_release ensures that dequeue sees the above */
+	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
+
+	if (locked_rq != src_rq)
+		switch_rq_lock(locked_rq, src_rq);
+
+	/* task_rq couldn't have changed if we're still the holding cpu */
+	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
+	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		/* the handshake is over, see unlink_dsq_and_switch_rq_lock() */
+		p->scx.holding_cpu = -1;
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * dispatch_to_local_dsq - Dispatch a task to a local dsq
  * @sch: scx_sched being operated on
@@ -3203,36 +3244,11 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		return;
 	}
 
-	/*
-	 * @p is on a possibly remote @src_rq which we need to lock to move the
-	 * task. If dequeue is in progress, it'd be locking @src_rq and waiting
-	 * on DISPATCHING, so we can't grab @src_rq lock while holding
-	 * DISPATCHING.
-	 *
-	 * As DISPATCHING guarantees that @p is wholly ours, we can pretend that
-	 * we're moving from a DSQ and use the same mechanism - mark the task
-	 * under transfer with holding_cpu, release DISPATCHING and then follow
-	 * the same protocol. See unlink_dsq_and_switch_rq_lock().
-	 */
-	p->scx.holding_cpu = raw_smp_processor_id();
-
-	/* store_release ensures that dequeue sees the above */
-	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
-
 	/* switch to @src_rq lock */
-	if (locked_rq != src_rq) {
-		switch_rq_lock(locked_rq, src_rq);
-		locked_rq = src_rq;
-	}
-
-	/* task_rq couldn't have changed if we're still the holding cpu */
-	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
-	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
+	locked_rq = src_rq;
+	if (release_dispatching_and_lock_task_rq(p, rq, src_rq)) {
 		bool fallback = false;
 
-		/* the handshake is over, see unlink_dsq_and_switch_rq_lock() */
-		p->scx.holding_cpu = -1;
-
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
@@ -3268,6 +3284,36 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		switch_rq_lock(locked_rq, rq);
 }
 
+/**
+ * dispatch_remote_task_to_global_dsq - Dispatch a remote task to the global DSQ
+ * @sch: scx_sched being operated on
+ * @rq: current rq which is locked, not @p's rq
+ * @p: task to dispatch
+ * @slice: slice carried by the insert verdict, 0 keeps the current value
+ * @vtime: vtime carried by the insert verdict
+ * @enq_flags: %SCX_ENQ_*
+ *
+ * Inserting @p into the global DSQ takes @p out of the BPF scheduler's custody,
+ * which clears %SCX_TASK_IN_CUSTODY and calls ops.dequeue(). Both must be done
+ * under @p's rq lock. Switch to it the same way dispatch_to_local_dsq() does
+ * and switch back to @rq lock afterwards.
+ *
+ * The caller must have exclusive ownership of @p through %SCX_OPSS_DISPATCHING.
+ */
+static void dispatch_remote_task_to_global_dsq(struct scx_sched *sch,
+					       struct rq *rq,
+					       struct task_struct *p, u64 slice,
+					       u64 vtime, u64 enq_flags)
+{
+	struct rq *src_rq = task_rq(p);
+
+	if (release_dispatching_and_lock_task_rq(p, rq, src_rq))
+		scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
+				     p, slice, vtime, enq_flags | SCX_ENQ_APPLY_SLICE);
+
+	switch_rq_lock(src_rq, rq);
+}
+
 /**
  * finish_dispatch - Asynchronously finish dispatching a task
  * @sch: the scheduler
@@ -3350,11 +3396,22 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq, struct task_st
 
 	dsq = find_dsq_for_dispatch(sch, rq, dsq_id, task_cpu(p));
 
-	if (dsq->id == SCX_DSQ_LOCAL)
+	if (dsq->id == SCX_DSQ_LOCAL) {
 		dispatch_to_local_dsq(sch, rq, dsq, p, slice, vtime, enq_flags);
-	else
-		scx_dispatch_enqueue(sch, rq, dsq, p, slice, vtime,
-				     enq_flags | SCX_ENQ_APPLY_SLICE | SCX_ENQ_CLEAR_OPSS);
+		return;
+	}
+
+	/*
+	 * A remote task can enter a user DSQ without its rq lock. Inserting
+	 * into the global DSQ (including the destroyed-DSQ fallback) ends
+	 * custody and requires @p's rq lock.
+	 */
+	if ((dsq->id != SCX_DSQ_GLOBAL || rq == task_rq(p)) &&
+	    scx_dispatch_enqueue(sch, rq, dsq, p, slice, vtime,
+				 enq_flags | SCX_ENQ_APPLY_SLICE | SCX_ENQ_CLEAR_OPSS))
+		return;
+
+	dispatch_remote_task_to_global_dsq(sch, rq, p, slice, vtime, enq_flags);
 }
 
 void scx_flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
@@ -7316,10 +7373,6 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 				 * that sched. Restart the wait unless @owner is
 				 * the root, which runs its own tasks bypassing
 				 * or not.
-				 *
-				 * A dispatch in flight writes p->scx.flags
-				 * without @p's rq lock. The dequeue waits it
-				 * out, so set the flag after it.
 				 */
 				if (scx_parent(owner))
 					p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
-- 
2.56.1.750.gf70dc682cf-goog

