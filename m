Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F002868AD
	for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532108; cv=none; b=tdpY1i1NzFTpCkVFOxS7xnetgOBdPtjlETEvacJtn1MRqmndbHP5Kcpg3Erj05ILS2kjAq7EGfW6E2Fq/nY7MXEwL6Z1Lnpqskg/iPytNp86S3Mg3ggdVcSrfqWq1pmmITcFDnjHBkMXiMX67XDce54uBUGkqwznWB2rDwfOjOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532108; c=relaxed/simple;
	bh=URXUzAygmVNdt1MjcXYIS9s2H98bx2GMfepiZDO6cCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fe5tKX2HysNwSe3MLJQDntwkKzbTYKsdz8zl78Wt9ll1iaHfNloWFgRm0ov7xQizKZLkiDmBgIt/yNX7aU+jfRpc4M7+zLylHL9COaLWq0lTbnAZ8X09r5ZJOD9O8wQXR9iK5OvvZ/CkVa4jEebQ8mbkznwQxa7YfUMVf/yKO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OU3kewEz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OU3kewEz"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-480600391e2so22949715e9.0
        for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 08:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769532104; x=1770136904; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8n4m2cqGToMpzprOMUS/3fnVyMhkMNiM/1+g1yv7M78=;
        b=OU3kewEz4dy/3tLg6AqhD+PJQW16/IyDO3lvfPB9mT//Z5sz5TmCvff5WaCqInzNW4
         qhi7rMknCtsL1Zd0bcmdqkCJyh1IlMgKakmgZi9iKRL2RwAiIyjQn6hjxqR0+Unw/M7R
         P/qe7qiBVk2dry2Ibz+5gGcr/YCA5shzCWt3v1eOW4oE3Yi16TvJnWTId+q6AAP3z7M6
         xW5J5c3CjQKEQhtTxf41V3S9H4Gai8NjmMhQY29xRu5squeKBn4iopsvCwDdwTr90rtM
         iKgJsHlryF8OwHsMSoJ1MV0vrKxrSmmX3iBoyIEWniQqRyeRXaUvWEJHsfIMfwhW/IMq
         94Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769532104; x=1770136904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8n4m2cqGToMpzprOMUS/3fnVyMhkMNiM/1+g1yv7M78=;
        b=niofBqP/VW0RrOrB2fzFZBS9dtMquX4LjcaiVmQm0a7W4kRbYDzzaPZ8V70ykPB3OK
         WnGDx/oZ+P76zeH4cJ5AofgfpKvUlRc0+dlgs28kap8Ljor233L/5RIKdbkJZkyQOjqQ
         SU4XyD8De68981CfV9adicwJC02p8ZrjG0OsRIyFtqeHuO3SUecKnnIicOr8hkgcfCzK
         TfMe+DWmxcfdab+FPoyh/vGzNkCAvNfp3M4VaL1vP0UKX2WMf909Fnr0CTXjuTKz6PIt
         yV7R8lMa01GJqPILk8wf3/zwm8QK4kKJodnjcarWRkkczkXmTJLPj+1Gv+/xPdgHdcA9
         UJJA==
X-Forwarded-Encrypted: i=1; AJvYcCWDQoGo21Xk6QRP9vMWgpywa9qPMN8yEV6+NPtT9+bmsQs1F5sbWfeGDlzVLkhiDBMd99hw7jUNSe4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyHMnw1w8Q8FzVU/EZqvq/cTKIF1eEZQKfKqxb5drZ32SYVt3Yg
	JRFDVtyqxnQ4EHhCMWmh9gJk/lEbAVfgpHzJQpCFqEMEn11o0iOgs2p51LOVmk5hqWSyvTe52Zi
	gCsTwZmoKMg/44A==
X-Received: from wmor14.prod.google.com ([2002:a05:600c:458e:b0:480:6ceb:eb1b])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6388:b0:47d:4fbe:e6cc with SMTP id 5b1f17b1804b1-48069c20f86mr31321335e9.13.1769532104284;
 Tue, 27 Jan 2026 08:41:44 -0800 (PST)
Date: Tue, 27 Jan 2026 16:41:43 +0000
In-Reply-To: <20260126084258.3798129-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126084258.3798129-1-arighi@nvidia.com> <20260126084258.3798129-2-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DFZIS1RRE219.3EWCQVQBFIWHZ@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Mon Jan 26, 2026 at 8:41 AM UTC, Andrea Righi wrote:
> Currently, ops.dequeue() is only invoked when the sched_ext core knows
> that a task resides in BPF-managed data structures, which causes it to
> miss scheduling property change scenarios. As a result, BPF schedulers
> cannot reliably track task state.
>
> In addition, some ops.dequeue() callbacks can be skipped (e.g., during
> direct dispatch), so ops.enqueue() calls are not always paired with a
> corresponding ops.dequeue(), potentially breaking accounting logic.
>
> Fix this by guaranteeing that every ops.enqueue() is matched with a
> corresponding ops.dequeue(), and introduce the %SCX_DEQ_SCHED_CHANGE
> flag to distinguish dequeues triggered by scheduling property changes
> from those occurring in the normal dispatch/execution workflow.
>
> New semantics:
> 1. ops.enqueue() is called when a task enters the BPF scheduler
> 2. ops.dequeue() is called when the task leaves the BPF scheduler in
>    the following cases:
>    a) regular dispatch workflow: task dispatched to a DSQ,
>    b) core scheduling pick: core-sched picks task before dispatch,
>    c) property change: task properties modified.
>
> A new %SCX_DEQ_SCHED_CHANGE flag is also introduced, allowing BPF
> schedulers to distinguish between:
> - normal dispatch/execution workflow (dispatch, core-sched pick),
> - property changes that require state updates (e.g.,
>   sched_setaffinity(), sched_setscheduler(), set_user_nice(),
>   NUMA balancing, CPU migrations, etc.).
>
> With this, BPF schedulers can:
> - reliably track task ownership and lifecycle,
> - maintain accurate accounting of enqueue/dequeue pairs,
> - distinguish between execution events and property changes,
> - update internal state appropriately for each dequeue type.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Emil Tsalapatis <emil@etsalapatis.com>
> Cc: Kuba Piecuch <jpiecuch@google.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  Documentation/scheduler/sched-ext.rst         | 33 +++++++
>  include/linux/sched/ext.h                     | 11 +++
>  kernel/sched/ext.c                            | 89 ++++++++++++++++++-
>  kernel/sched/ext_internal.h                   |  7 ++
>  .../sched_ext/include/scx/enum_defs.autogen.h |  2 +
>  .../sched_ext/include/scx/enums.autogen.bpf.h |  2 +
>  tools/sched_ext/include/scx/enums.autogen.h   |  1 +
>  7 files changed, 142 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 404fe6126a769..ed6bf7d9e6e8c 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -252,6 +252,37 @@ The following briefly shows how a waking task is scheduled and executed.
>  
>     * Queue the task on the BPF side.
>  
> +   Once ``ops.enqueue()`` is called, the task enters the "enqueued state".
> +   The task remains in this state until ``ops.dequeue()`` is called, which
> +   happens in the following cases:
> +
> +   1. **Regular dispatch workflow**: when the task is successfully
> +      dispatched to a DSQ (local, global, or user DSQ), ``ops.dequeue()``
> +      is triggered immediately to notify the BPF scheduler.
> +
> +   2. **Core scheduling pick**: when ``CONFIG_SCHED_CORE`` is enabled and
> +      core scheduling picks a task for execution before it has been
> +      dispatched, ``ops.dequeue()`` is called with the
> +      ``SCX_DEQ_CORE_SCHED_EXEC`` flag.
> +
> +   3. **Scheduling property change**: when a task property changes (via
> +      operations like ``sched_setaffinity()``, ``sched_setscheduler()``,
> +      priority changes, CPU migrations, etc.), ``ops.dequeue()`` is called
> +      with the ``SCX_DEQ_SCHED_CHANGE`` flag set in ``deq_flags``.
> +
> +   **Important**: ``ops.dequeue()`` is called for *any* enqueued task,
> +   regardless of whether the task is still on a BPF data structure, or it
> +   has already been dispatched to a DSQ. This guarantees that every
> +   ``ops.enqueue()`` will eventually be followed by a corresponding
> +   ``ops.dequeue()``.

Not sure I follow this paragraph, specifically the first sentence
(starting with ``ops.dequeue()`` is called ...).
It seems to imply that a task that has already been dispatched to a DSQ still
counts as enqueued, but the preceding text contradicts that by saying that
a task is in an "enqueued state" from the time ops.enqueue() is called until
(among other things) it's successfully dispatched to a DSQ.

This would make sense if this paragraph used "enqueued" in the SCX_TASK_QUEUED
sense, while the first paragraph used the SCX_OPSS_QUEUED sense, but if that's
the case, it's quite confusing and should be clarified IMO.

> +
> +   This makes it reliable for BPF schedulers to track the enqueued state
> +   and maintain accurate accounting.
> +
> +   BPF schedulers can choose not to implement ``ops.dequeue()`` if they
> +   don't need to track these transitions. The sched_ext core will safely
> +   handle all dequeue operations regardless.
> +
>  3. When a CPU is ready to schedule, it first looks at its local DSQ. If
>     empty, it then looks at the global DSQ. If there still isn't a task to
>     run, ``ops.dispatch()`` is invoked which can use the following two
> @@ -319,6 +350,8 @@ by a sched_ext scheduler:
>                  /* Any usable CPU becomes available */
>  
>                  ops.dispatch(); /* Task is moved to a local DSQ */
> +
> +                ops.dequeue(); /* Exiting BPF scheduler */
>              }
>              ops.running();      /* Task starts running on its assigned CPU */
>              while (task->scx.slice > 0 && task is runnable)
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index bcb962d5ee7d8..59446cd0373fa 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -84,8 +84,19 @@ struct scx_dispatch_q {
>  /* scx_entity.flags */
>  enum scx_ent_flags {
>  	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
> +	/*
> +	 * Set when ops.enqueue() is called; used to determine if ops.dequeue()
> +	 * should be invoked when transitioning out of SCX_OPSS_NONE state.
> +	 */
> +	SCX_TASK_OPS_ENQUEUED	= 1 << 1,
>  	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
>  	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
> +	/*
> +	 * Set when ops.dequeue() is called after successful dispatch; used to
> +	 * distinguish dispatch dequeues from property change dequeues and
> +	 * prevent duplicate dequeue calls.
> +	 */

What counts as a duplicate dequeue call? Looking at the code, we can clearly
have ops.dequeue(SCHED_CHANGE) called after ops.dequeue(0) without an
intervening call to ops.enqueue().

> +	SCX_TASK_DISPATCH_DEQUEUED = 1 << 4,
>  
>  	SCX_TASK_STATE_SHIFT	= 8,	  /* bit 8 and 9 are used to carry scx_task_state */
>  	SCX_TASK_STATE_BITS	= 2,
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index afe28c04d5aa7..18bca2b83f5c5 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1287,6 +1287,20 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
>  
>  	p->scx.ddsp_enq_flags |= enq_flags;
>  
> +	/*
> +	 * The task is about to be dispatched. If ops.enqueue() was called,
> +	 * notify the BPF scheduler by calling ops.dequeue().
> +	 *
> +	 * Keep %SCX_TASK_OPS_ENQUEUED set so that subsequent property
> +	 * changes can trigger ops.dequeue() with %SCX_DEQ_SCHED_CHANGE.
> +	 * Mark that the dispatch dequeue has been called to distinguish
> +	 * from property change dequeues.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
> +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
> +		p->scx.flags |= SCX_TASK_DISPATCH_DEQUEUED;
> +	}
> +
>  	/*
>  	 * We are in the enqueue path with @rq locked and pinned, and thus can't
>  	 * double lock a remote rq and enqueue to its local DSQ. For
> @@ -1391,6 +1405,16 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
>  	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
>  
> +	/*
> +	 * Mark that ops.enqueue() is being called for this task.
> +	 * Clear the dispatch dequeue flag for the new enqueue cycle.
> +	 * Only track these flags if ops.dequeue() is implemented.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue)) {
> +		p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> +		p->scx.flags &= ~SCX_TASK_DISPATCH_DEQUEUED;
> +	}
> +
>  	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
>  	WARN_ON_ONCE(*ddsp_taskp);
>  	*ddsp_taskp = p;
> @@ -1523,6 +1547,34 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  
>  	switch (opss & SCX_OPSS_STATE_MASK) {
>  	case SCX_OPSS_NONE:
> +		if (SCX_HAS_OP(sch, dequeue) &&
> +		    p->scx.flags & SCX_TASK_OPS_ENQUEUED) {
> +			/*
> +			 * Task was already dispatched. Only call ops.dequeue()
> +			 * if it hasn't been called yet (check DISPATCH_DEQUEUED).
> +			 * This can happen when:
> +			 * 1. Core-sched picks a task that was dispatched
> +			 * 2. Property changes occur after dispatch
> +			 */
> +			if (!(p->scx.flags & SCX_TASK_DISPATCH_DEQUEUED)) {
> +				/*
> +				 * ops.dequeue() wasn't called during dispatch.
> +				 * This shouldn't normally happen, but call it now.
> +				 */

Should we add a warning here?

> +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> +						 p, deq_flags);
> +			} else if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC))) {
> +				/*
> +				 * This is a property change after
> +				 * dispatch. Call ops.dequeue() again with
> +				 * %SCX_DEQ_SCHED_CHANGE.
> +				 */
> +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> +						 p, deq_flags | SCX_DEQ_SCHED_CHANGE);
> +			}
> +			p->scx.flags &= ~(SCX_TASK_OPS_ENQUEUED |
> +					  SCX_TASK_DISPATCH_DEQUEUED);
> +		}

If I understand the logic correctly, ops.dequeue(SCHED_CHANGE) will be called
for a task at most once between it being dispatched and taken off the CPU,
even if its properties are changed multiple times while it's on CPU.
Is that intentional? I don't see it documented.

To illustrate, assume we have a task p that has been enqueued, dispatched, and
is currently running on the CPU, so we have both SCX_TASK_OPS_ENQUEUE and
SCX_TASK_DISPATCH_DEQUEUED set in p->scx.flags.

When a property of p is changed while it runs on the CPU,
the sequence of calls is:
  dequeue_task_scx(p, DEQUEUE_SAVE) => put_prev_task_scx(p) =>
  (change property) => enqueue_task_scx(p, ENQUEUE_RESTORE) =>
  set_next_task_scx(p).

dequeue_task_scx(p, DEQUEUE_SAVE) calls ops_dequeue() which calls
ops.dequeue(p, ... | SCHED_CHANGE) and clears
SCX_TASK_{OPS_ENQUEUED,DISPATCH_DEQUEUED} from p->scx.flags.

put_prev_task_scx(p) doesn't do much because SCX_TASK_QUEUED was cleared by
dequeue_task_scx().

enqueue_task_scx(p, ENQUEUE_RESTORE) sets sticky_cpu because the task is
currently running and ENQUEUE_RESTORE is set. This causes do_enqueue_task() to
jump straight to local_norefill, skipping the call to ops.enqueue(), leaving
SCX_TASK_OPS_ENQUEUED unset, and then enqueueing the task on the local DSQ.

set_next_task_scx(p) calls ops_dequeue(p, SCX_DEQ_CORE_SCHED_EXEC) even though
this is not a core-sched pick, but it won't do much because the ops_state is
SCX_OPSS_NONE and SCX_TASK_OPS_ENQUEUED is unset. It also calls
dispatch_dequeue(p) which the removes the task from the local DSQ it was just
inserted into.


So, we end up in a state where any subsequent property change while the task is
still on CPU will not result in ops.dequeue(p, ... | SCHED_CHANGE) being
called, because both SCX_TASK_OPS_ENQUEUED and SCX_TASK_DISPATCH_DEQUEUED are
unset in p->scx.flags.

I really hope I didn't mess anything up when tracing the code, but of course
I'm happy to be corrected.

>  		break;
>  	case SCX_OPSS_QUEUEING:
>  		/*
> @@ -1531,9 +1583,24 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  		 */
>  		BUG();
>  	case SCX_OPSS_QUEUED:
> -		if (SCX_HAS_OP(sch, dequeue))
> -			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> -					 p, deq_flags);
> +		/*
> +		 * Task is still on the BPF scheduler (not dispatched yet).
> +		 * Call ops.dequeue() to notify. Add %SCX_DEQ_SCHED_CHANGE
> +		 * only for property changes, not for core-sched picks.
> +		 */
> +		if (SCX_HAS_OP(sch, dequeue)) {
> +			u64 flags = deq_flags;
> +			/*
> +			 * Add %SCX_DEQ_SCHED_CHANGE for property changes,
> +			 * but not for core-sched picks or sleep.
> +			 */
> +			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
> +				flags |= SCX_DEQ_SCHED_CHANGE;
> +
> +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
> +			p->scx.flags &= ~(SCX_TASK_OPS_ENQUEUED |
> +					  SCX_TASK_DISPATCH_DEQUEUED);
> +		}
>  
>  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>  					    SCX_OPSS_NONE))
> @@ -2107,6 +2174,22 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
>  
>  	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
>  
> +	/*
> +	 * The task is about to be dispatched. If ops.enqueue() was called,
> +	 * notify the BPF scheduler by calling ops.dequeue().
> +	 *
> +	 * Keep %SCX_TASK_OPS_ENQUEUED set so that subsequent property
> +	 * changes can trigger ops.dequeue() with %SCX_DEQ_SCHED_CHANGE.
> +	 * Mark that the dispatch dequeue has been called to distinguish
> +	 * from property change dequeues.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
> +		struct rq *task_rq = task_rq(p);
> +
> +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, task_rq, p, 0);
> +		p->scx.flags |= SCX_TASK_DISPATCH_DEQUEUED;
> +	}
> +
>  	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, p);
>  
>  	if (dsq->id == SCX_DSQ_LOCAL)
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 386c677e4c9a0..befa9a5d6e53f 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -982,6 +982,13 @@ enum scx_deq_flags {
>  	 * it hasn't been dispatched yet. Dequeue from the BPF side.
>  	 */
>  	SCX_DEQ_CORE_SCHED_EXEC	= 1LLU << 32,
> +
> +	/*
> +	 * The task is being dequeued due to a property change (e.g.,
> +	 * sched_setaffinity(), sched_setscheduler(), set_user_nice(),
> +	 * etc.).
> +	 */
> +	SCX_DEQ_SCHED_CHANGE	= 1LLU << 33,
>  };
>  
>  enum scx_pick_idle_cpu_flags {
> diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
> index c2c33df9292c2..8284f717ff05e 100644
> --- a/tools/sched_ext/include/scx/enum_defs.autogen.h
> +++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
> @@ -21,6 +21,7 @@
>  #define HAVE_SCX_CPU_PREEMPT_UNKNOWN
>  #define HAVE_SCX_DEQ_SLEEP
>  #define HAVE_SCX_DEQ_CORE_SCHED_EXEC
> +#define HAVE_SCX_DEQ_SCHED_CHANGE
>  #define HAVE_SCX_DSQ_FLAG_BUILTIN
>  #define HAVE_SCX_DSQ_FLAG_LOCAL_ON
>  #define HAVE_SCX_DSQ_INVALID
> @@ -48,6 +49,7 @@
>  #define HAVE_SCX_TASK_QUEUED
>  #define HAVE_SCX_TASK_RESET_RUNNABLE_AT
>  #define HAVE_SCX_TASK_DEQD_FOR_SLEEP
> +#define HAVE_SCX_TASK_DISPATCH_DEQUEUED
>  #define HAVE_SCX_TASK_STATE_SHIFT
>  #define HAVE_SCX_TASK_STATE_BITS
>  #define HAVE_SCX_TASK_STATE_MASK
> diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
> index 2f8002bcc19ad..5da50f9376844 100644
> --- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
> +++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
> @@ -127,3 +127,5 @@ const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
>  const volatile u64 __SCX_ENQ_DSQ_PRIQ __weak;
>  #define SCX_ENQ_DSQ_PRIQ __SCX_ENQ_DSQ_PRIQ
>  
> +const volatile u64 __SCX_DEQ_SCHED_CHANGE __weak;
> +#define SCX_DEQ_SCHED_CHANGE __SCX_DEQ_SCHED_CHANGE
> diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
> index fedec938584be..fc9a7a4d9dea5 100644
> --- a/tools/sched_ext/include/scx/enums.autogen.h
> +++ b/tools/sched_ext/include/scx/enums.autogen.h
> @@ -46,4 +46,5 @@
>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
> +	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
>  } while (0)

Thanks,
Kuba

