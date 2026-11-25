Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606124;
	b=v+e7nToBu5lCS/GafN26Znwu0ch03mKYeDjdSZ0lX5xrR9+c9mnAR30Ybxl/AhBo60uc
	 cx8tv/c+DdWtYe6eCNKasrqV8IKd2/OWJ4B/pMvrAI/OHi5vWsEBnRyhtVbM04jlucWIB
	 MA4xFTQxU/lqWIdECrEH0Fy2CkxxnJ38s/HbVWbh7pjg0D7f46AbXzjGC3Vv7vhfrRWNF
	 U4Y+/mjoSIUH+E9NEIrEKNI3hHDWQoz8qkjgFEyHS+dUNMT6pfWa1gnOaWorRWELX185G
	 LtMWrtC9aO0wakDlEurZGeSLZeh2XNcEDhzby1mTe1Q558pYjHAw7v6LZbK8MuE3xUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=xzjv0jNLLhlr1KABvbE2Nin1JLZXLYZHTd6aXMrIUXU=;
	b=36ngF0q/U4Et6DSGCc467uGibe+obDcFAmRWEgFy0CwzvpYT6+Lz0bXNejgml1p7TFcJ
	 mI3QBqgQWD39niCJkCdmRQjparaeYbvXMY0wp+KOVKCVlP2PbdcWjdRz3ofOxlHHmjQFH
	 nrXGpr4UCgPrfRHrKd+3tOYFuotqDqz7JCeioubStnpCtjI14jv1ewh8R3JYM39FJ8+vq
	 wijQyNzjo2XxLpjMYrV+fYl1jMUySLMBkaRQM1FvUl5rtu6G0G7hUrjFs6WhfhUeq+8EG
	 PDWYJ7v38YCikW8WdJREG+7DzohJewnjsSvAU6DKmVl5lxorz3ihY7sfozIlTMBksoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ho9zHZKJ;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CFB606A338
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 11:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77CFB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ho9zHZKJ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4bb6bbc025aso43898695e9.3
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 03:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795606122; x=1796210922; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xzjv0jNLLhlr1KABvbE2Nin1JLZXLYZHTd6aXMrIUXU=;
        b=ho9zHZKJ5of0ykFyE5n2rfkmQ7TrbW3Bg2Vq67NL0qrBQ+TecY9OZx4786obLNYsBc
         GdH7W4ZvMG3G6DvL1bLTPOpd4OccHZKGYiBC8gYEcr0Ukqj9j4XkJNa2B2mg683l6pyr
         f5wQHWvKJLLabMOHbyMzrz2e6Ee5lk/qJs1wR08XGwOmGd8/U1KCnEEXkTjy8ipNNzzi
         wgBYZJqB1WBz3Onz3IHmbDvlyHGUspNV3T2FYVT0ViauH6Cw6Kp1SDySam7A5KxWj4kQ
         lS+PsUqcPR6msg0wMxOU44iepHSFDZdtfCzomFtKHlil6gd9oGXZqTa9OZFp7AGcPHHr
         fcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606122; x=1796210922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xzjv0jNLLhlr1KABvbE2Nin1JLZXLYZHTd6aXMrIUXU=;
        b=kFsVD6Tpla3ux7d3aVLnCS1x7ISw/8fj1sMQ9jJAGajdWDJsSDu+affTIl1rOxoECT
         CrgXQfcvvk28tdYPoJsIofNqHfu6UqIgBUsgrZDjufL6mq6EnuF4NFtIAGl+522WkQ7I
         RGaCvhhQr1MfGPFuW7J0tmVd3tQE2koFkYvrfA6UnOATSrovgLTu9FQUiORVXToW9N4A
         NJnOg4NSUfj4t/XG3HZXpKtcUng949JMlzyUxvYlZCN7Knp28845yRF1nKCBAwP+2gWP
         a8EjRDYsjF/wnCn5lrVBuA7cUQp7/XKl7T7fbnNdutO2EC1JaXn8ul2Ika9hR1QltPxT
         TYQg==
X-Forwarded-Encrypted: i=1; AL+hErGYkCcNx+FYaLAFOkU9/HFaNzo1Ypqgiwd6NzP7nsjq+VKgu/xcaqASwEHKk+D29gspzZIccWl9YSQ=@lists.linux.dev
X-Gm-Message-State: APuU4Z+t7Wq8Krc8Z7M5rjlW4Mauy5jkSW/brSAAar+rJ2im9mUvsuC2
	OKAfZdXvsGmeVzgsXZfKls8olgI5AslIIQYV3lGqWbHuyj1idi6ZrYjuvXwS8dCBcFjoXG1FIjK
	cbKyYpQJwuhct9g==
X-Received: from wmbju12.prod.google.com ([2002:a05:600c:56cc:b0:4a1:a2ef:38dc])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:820c:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-4bb887876c0mr379562195e9.0.1795606121642;
 Wed, 25 Nov 2026 03:28:41 -0800 (PST)
Date: Wed, 25 Nov 2026 11:28:36 +0000
In-Reply-To: <20261125112553.1539758-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261125112553.1539758-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125112553.1539758-3-jpiecuch@google.com>
Subject: [PATCH v2 2/4] sched_ext: Fix ops_state and ops.dequeue() locking
 races in dispatch
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

- Insert a remote task into the global DSQ under its rq lock via
  dispatch_remote_task_to_global_dsq(), using
  release_dispatching_and_lock_task_rq(). On a destroyed user DSQ,
  the scheduler is already being ejected: clear ops_state and return
  from scx_dispatch_enqueue() without falling back to the global DSQ,
  leaving scx_bypass() to recover the task.

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
 kernel/sched/ext/ext.c | 167 +++++++++++++++++++++++++----------------
 1 file changed, 101 insertions(+), 66 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index d6505d90e2c6..8451eebbe2d1 100644
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
 
@@ -1852,11 +1854,17 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	}
 }
 
+/*
+ * Insert @p into @dsq with @rq locked. Unless finish_dispatch() is inserting a
+ * remote task into a user DSQ, @rq must be @p's rq.
+ */
 static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 				 struct scx_dispatch_q *dsq, struct task_struct *p,
 				 u64 slice, u64 vtime, u64 enq_flags)
 {
-	bool is_rq_owned = dsq_is_rq_owned(dsq);
+	bool is_rq_owned = dsq_is_rq_owned(dsq), call_dequeue = false;
+
+	lockdep_assert_rq_held(rq);
 
 	if (dsq->id == SCX_DSQ_LOCAL)
 		dsq = scx_resolve_local_dsq(sch, rq, p, &enq_flags);
@@ -1871,10 +1879,16 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 
 		if (unlikely(dsq->id == SCX_DSQ_INVALID)) {
 			scx_error(sch, "attempting to dispatch to a destroyed dsq");
-			/* fall back to the global dsq */
 			raw_spin_unlock(&dsq->lock);
-			dsq = find_global_dsq(sch, task_cpu(p));
-			raw_spin_lock(&dsq->lock);
+			/*
+			 * @sch is being ejected and scx_bypass() will cycle its
+			 * runnable tasks. Release ownership and let bypass
+			 * recover @p.
+			 */
+			if (enq_flags & SCX_ENQ_CLEAR_OPSS)
+				atomic_long_set_release(&p->scx.ops_state,
+							SCX_OPSS_NONE);
+			return;
 		}
 	}
 
@@ -1960,45 +1974,47 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
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
 }
 
 void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq)
@@ -2528,7 +2544,6 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	 */
 	clr_task_runnable(p, false);
 
-retry:
 	/* acquire ensures that we see the preceding updates on QUEUED */
 	opss = atomic_long_read_acquire(&p->scx.ops_state);
 
@@ -2542,20 +2557,6 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
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
@@ -2580,18 +2581,15 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	}
 
 	/*
-	 * Call ops.dequeue() if the task is still in BPF custody.
+	 * Call ops.dequeue() if @p is still in BPF custody. @p can be in
+	 * %SCX_OPSS_NONE with %SCX_TASK_IN_CUSTODY set in three cases:
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
+	 * - scx_dispatch_enqueue() aborted an insert into a destroyed user DSQ
+	 *   and left @p for scx_bypass() to recover.
 	 */
 	if (task_leave_custody(p) && SCX_HAS_OP(sch, dequeue))
 		SCX_CALL_OP_TASK(sch, dequeue, rq, p, deq_flags);
@@ -3285,6 +3283,36 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
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
@@ -3367,11 +3395,22 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq, struct task_st
 
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
+	 * into the global DSQ ends custody and requires @p's rq lock.
+	 */
+	if (dsq->id == SCX_DSQ_GLOBAL && rq != task_rq(p)) {
+		dispatch_remote_task_to_global_dsq(sch, rq, p, slice, vtime, enq_flags);
+		return;
+	}
+
+	scx_dispatch_enqueue(sch, rq, dsq, p, slice, vtime,
+			     enq_flags | SCX_ENQ_APPLY_SLICE | SCX_ENQ_CLEAR_OPSS);
 }
 
 void scx_flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
@@ -7333,10 +7372,6 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
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
2.56.1.839.g22a8290db9-goog

