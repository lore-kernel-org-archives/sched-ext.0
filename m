Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05063043DC
	for <sched-ext@lists.linux.dev>; Thu,  5 Feb 2026 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319785; cv=none; b=YqOih6T5dCdjeYkBZ/NvOUWfzTKVkRo3H5dyfv5pATq3jzB/9B194TgwDpwG/9zPQc6RngdkLt7yOy940WUUs+qTrt5edeqhZWzgmQUF2G5QuwYEplBTKZ0drXzgEhyUzhm8EpC19SWurhSn5wTry7fWGIet84q3R+XA9qT/zUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319785; c=relaxed/simple;
	bh=iVs60YvVcH6vRz38LrNJK7Pp2tMtDSIshmCgU8M+c4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ePd4XfzuqZqb2LjrvMfDh9UdvknGazCVLL0sfEcvrrht+/hauNJS9WbpIxxVSn30NrgLUB65pR/n1tzM1Alk+eMU/YR4ctdM+H0EqBboIu+/ZHo6cPz3+9NYZ11Hee/jIspLzFewfhXgQwv2CQ7HNeQtKYByRUmOjX9gx5/mLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZP4TfP0p; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZP4TfP0p"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47ee1fe7b24so16528335e9.1
        for <sched-ext@lists.linux.dev>; Thu, 05 Feb 2026 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770319783; x=1770924583; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/PSsC2C9YL3OstSXtz4FBc03t2IiUy/9H0E9jmLT4Q=;
        b=ZP4TfP0puuVzhiMQuEsMB0p7lyWtWga3TXho/MlrctD7SMIif+iczOjE9Y78AfbSDQ
         v6eHVt/HdnO7dWxDmC+cZCkOw+3HB6wd/KYnhS065aSZ8wOt7bYDj5YuCWXbbmxI+4qo
         KKFhEirqXYEuulPwfZoIaAVQMdYIgxLCn/0a0R57dWtcVgb9mmkhqGHEf4hiiOwGXlzJ
         0+IUEmwqyAMCYLK55TWxFYykvPA/6+BaP3p8k83zGWRkuIM/h5HrRXgHdNskK0/equ78
         a426zTw5F/kRzq/TH+BouJbnwFXtXJFMYr01gJqEOfyEPOmnzszGtgFhZN20+gvV2lvV
         f8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770319783; x=1770924583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/PSsC2C9YL3OstSXtz4FBc03t2IiUy/9H0E9jmLT4Q=;
        b=MpQhKDIvOwJqRKTF/Bzn959XbaCXGH/E+5N9FvmcCYra3ZqTj/k35gIjHUgjBW1ttj
         NkUClxLwnoaJ/JnOLad8nS6BfoTqB9t81Df/H4gKPdK/J71EYsJ/eqoD4i9/IA4aXo7z
         VbDfjuGxLSXIg8AF4HRgxlBXRAJ8GFGbqZU2TAWQAIo50VTZJnpzcDlMwxF4YCWeWOKt
         ILhwzmdbGmytO0JZZLX82WNuOumzHtaXlGP+IRy+HkaxwuRvWzw4VnFZctYTX8hbWAuS
         vnH/uf2dR8Kjn6/toRgS6L6hHsIUGEVIjhJBXce1UjqXdvsNFCpLmwj5OsGiyMHWI5gj
         Hj3A==
X-Forwarded-Encrypted: i=1; AJvYcCVzLjr6YMH0J2Vmxb6OBd+GD3ztAExwxzLdiQ0/aoVp+sZPkxXd+F+xQ50ih3T9OlM3uQRRb4e06rM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzXxgJXkLM5M02bF8FQ92dGlGBc/bsiYL8F+f/bMObsDYdhG1cY
	fKgD0TK8NNhVmg4xBvKIww51bvEAIj4lmWuNgC6bjuxpWKLmBlNhwapcc2K7tf7cmDagqvzu7Gi
	Xe4N6SEVZ5v6mjA==
X-Received: from wmat11.prod.google.com ([2002:a05:600c:6d0b:b0:480:6b05:6b98])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1387:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-4832022a235mr7877735e9.35.1770319783283;
 Thu, 05 Feb 2026 11:29:43 -0800 (PST)
Date: Thu, 05 Feb 2026 19:29:42 +0000
In-Reply-To: <20260205153304.1996142-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260205153304.1996142-1-arighi@nvidia.com> <20260205153304.1996142-2-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG79ZKS630EW.IUD2PSCREXDF@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Christian Loehle <christian.loehle@arm.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Thu Feb 5, 2026 at 3:32 PM UTC, Andrea Righi wrote:
> Currently, ops.dequeue() is only invoked when the sched_ext core knows
> that a task resides in BPF-managed data structures, which causes it to
> miss scheduling property change events. In addition, ops.dequeue()
> callbacks are completely skipped when tasks are dispatched to non-local
> DSQs from ops.select_cpu(). As a result, BPF schedulers cannot reliably
> track task state.
>
> Fix this by guaranteeing that each task entering the BPF scheduler's
> custody triggers exactly one ops.dequeue() call when it leaves that
> custody, whether the exit is due to a dispatch (regular or via a core
> scheduling pick) or to a scheduling property change (e.g.
> sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
> balancing, etc.).
>
> BPF scheduler custody concept: a task is considered to be in "BPF
> scheduler's custody" when it has been queued in user-created DSQs and
> the BPF scheduler is responsible for its lifecycle. Custody ends when
> the task is dispatched to a terminal DSQ (local DSQ or SCX_DSQ_GLOBAL),
> selected by core scheduling, or removed due to a property change.

Strictly speaking, a task in BPF scheduler custody doesn't have to be queued
in a user-created DSQ. It could just reside on some custom data structure.

>
> Tasks directly dispatched to terminal DSQs bypass the BPF scheduler
> entirely and are not in its custody. Terminal DSQs include:
>  - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
>    where tasks go directly to execution.
>  - Global DSQ (%SCX_DSQ_GLOBAL): the built-in fallback queue where the
>    BPF scheduler is considered "done" with the task.
>
> As a result, ops.dequeue() is not invoked for tasks dispatched to
> terminal DSQs, as the BPF scheduler no longer retains custody of them.

Shouldn't it be "directly dispatched to terminal DSQs"?

>
> To identify dequeues triggered by scheduling property changes, introduce
> the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
> the dequeue was caused by a scheduling property change.
>
> New ops.dequeue() semantics:
>  - ops.dequeue() is invoked exactly once when the task leaves the BPF
>    scheduler's custody, in one of the following cases:
>    a) regular dispatch: a task dispatched to a user DSQ is moved to a
>       terminal DSQ (ops.dequeue() called without any special flags set),

I don't think the task has to be on a user DSQ. How about just "a task in BPF
scheduler's custody is dispatched to a terminal DSQ from ops.dispatch()"?

>    b) core scheduling dispatch: core-sched picks task before dispatch,
>       ops.dequeue() called with %SCX_DEQ_CORE_SCHED_EXEC flag set,
>    c) property change: task properties modified before dispatch,
>       ops.dequeue() called with %SCX_DEQ_SCHED_CHANGE flag set.
>
> This allows BPF schedulers to:
>  - reliably track task ownership and lifecycle,
>  - maintain accurate accounting of managed tasks,
>  - update internal state when tasks change properties.
>
...
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 404fe6126a769..ccd1fad3b3b92 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -252,6 +252,57 @@ The following briefly shows how a waking task is scheduled and executed.
>  
>     * Queue the task on the BPF side.
>  
> +   **Task State Tracking and ops.dequeue() Semantics**
> +
> +   Once ``ops.select_cpu()`` or ``ops.enqueue()`` is called, the task may
> +   enter the "BPF scheduler's custody" depending on where it's dispatched:
> +
> +   * **Direct dispatch to terminal DSQs** (``SCX_DSQ_LOCAL``,
> +     ``SCX_DSQ_LOCAL_ON | cpu``, or ``SCX_DSQ_GLOBAL``): The BPF scheduler
> +     is done with the task - it either goes straight to a CPU's local run
> +     queue or to the global DSQ as a fallback. The task never enters (or
> +     exits) BPF custody, and ``ops.dequeue()`` will not be called.
> +
> +   * **Dispatch to user-created DSQs** (custom DSQs): the task enters the
> +     BPF scheduler's custody. When the task later leaves BPF custody
> +     (dispatched to a terminal DSQ, picked by core-sched, or dequeued for
> +     sleep/property changes), ``ops.dequeue()`` will be called exactly once.
> +
> +   * **Queued on BPF side**: The task is in BPF data structures and in BPF
> +     custody, ``ops.dequeue()`` will be called when it leaves.
> +
> +   The key principle: **ops.dequeue() is called when a task leaves the BPF
> +   scheduler's custody**.
> +
> +   This works also with the ``ops.select_cpu()`` direct dispatch
> +   optimization: even though it skips ``ops.enqueue()`` invocation, if the
> +   task is dispatched to a user-created DSQ, it enters BPF custody and will
> +   get ``ops.dequeue()`` when it leaves. If dispatched to a terminal DSQ,
> +   the BPF scheduler is done with it immediately. This provides the
> +   performance benefit of avoiding the ``ops.enqueue()`` roundtrip while
> +   maintaining correct state tracking.
> +
> +   The dequeue can happen for different reasons, distinguished by flags:
> +
> +   1. **Regular dispatch workflow**: when the task is dispatched from a
> +      user-created DSQ to a terminal DSQ (leaving BPF custody for execution),
> +      ``ops.dequeue()`` is triggered without any special flags.

There's no requirement for the task do be on a user-created DSQ.

> +
> +   2. **Core scheduling pick**: when ``CONFIG_SCHED_CORE`` is enabled and
> +      core scheduling picks a task for execution while it's still in BPF
> +      custody, ``ops.dequeue()`` is called with the
> +      ``SCX_DEQ_CORE_SCHED_EXEC`` flag.
> +
> +   3. **Scheduling property change**: when a task property changes (via
> +      operations like ``sched_setaffinity()``, ``sched_setscheduler()``,
> +      priority changes, CPU migrations, etc.) while the task is still in
> +      BPF custody, ``ops.dequeue()`` is called with the
> +      ``SCX_DEQ_SCHED_CHANGE`` flag set in ``deq_flags``.
> +
> +   **Important**: Once a task has left BPF custody (dispatched to a
> +   terminal DSQ), property changes will not trigger ``ops.dequeue()``,
> +   since the task is no longer being managed by the BPF scheduler.
> +
>  3. When a CPU is ready to schedule, it first looks at its local DSQ. If
>     empty, it then looks at the global DSQ. If there still isn't a task to
>     run, ``ops.dispatch()`` is invoked which can use the following two
...
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index bcb962d5ee7d8..35a88942810b4 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -84,6 +84,7 @@ struct scx_dispatch_q {
>  /* scx_entity.flags */
>  enum scx_ent_flags {
>  	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
> +	SCX_TASK_NEED_DEQ	= 1 << 1, /* task needs ops.dequeue() */

I think this could use a comment that connects this flag to the concept of
BPF custody, so how about something like "task is in BPF custody, needs
ops.dequeue() when leaving it"?

>  	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
>  	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
>  
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 0bb8fa927e9e9..9ebca357196b4 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
...
> @@ -1103,6 +1125,27 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>       dsq_mod_nr(dsq, 1);
>       p->scx.dsq = dsq;
>
> +     /*
> +      * Handle ops.dequeue() and custody tracking.
> +      *
> +      * Builtin DSQs (local, global, bypass) are terminal: the BPF
> +      * scheduler is done with the task. If it was in BPF custody, call
> +      * ops.dequeue() and clear the flag.
> +      *
> +      * User DSQs: Task is in BPF scheduler's custody. Set the flag so
> +      * ops.dequeue() will be called when it leaves.
> +      */
> +     if (SCX_HAS_OP(sch, dequeue)) {
> +             if (is_terminal_dsq(dsq->id)) {
> +                     if (p->scx.flags & SCX_TASK_NEED_DEQ)
> +                             SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue,
> +                                              rq, p, 0);
> +                     p->scx.flags &= ~SCX_TASK_NEED_DEQ;
> +             } else {
> +                     p->scx.flags |= SCX_TASK_NEED_DEQ;
> +             }
> +     }
> +

This is the only place where I see SCX_TASK_NEED_DEQ being set, which means
it won't be set if the enqueued task is queued on the BPF scheduler's internal
data structures rather than dispatched to a user-created DSQ. I don't think
that's the behavior we're aiming for.

> @@ -1524,6 +1579,24 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  
>  	switch (opss & SCX_OPSS_STATE_MASK) {
>  	case SCX_OPSS_NONE:
> +		/*
> +		 * Task is not in BPF data structures (either dispatched to
> +		 * a DSQ or running). Only call ops.dequeue() if the task
> +		 * is still in BPF scheduler's custody (%SCX_TASK_NEED_DEQ
> +		 * is set).
> +		 *
> +		 * If the task has already been dispatched to a terminal
> +		 * DSQ (local DSQ or %SCX_DSQ_GLOBAL), it has left the BPF
> +		 * scheduler's custody and the flag will be clear, so we
> +		 * skip ops.dequeue().
> +		 *
> +		 * If this is a property change (not sleep/core-sched) and
> +		 * the task is still in BPF custody, set the
> +		 * %SCX_DEQ_SCHED_CHANGE flag.
> +		 */
> +		if (SCX_HAS_OP(sch, dequeue) &&
> +		    (p->scx.flags & SCX_TASK_NEED_DEQ))
> +			call_task_dequeue(sch, rq, p, deq_flags);
>  		break;
>  	case SCX_OPSS_QUEUEING:
>  		/*
> @@ -1532,9 +1605,14 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  		 */
>  		BUG();
>  	case SCX_OPSS_QUEUED:
> +		/*
> +		 * Task is still on the BPF scheduler (not dispatched yet).
> +		 * Call ops.dequeue() to notify. Add %SCX_DEQ_SCHED_CHANGE
> +		 * only for property changes, not for core-sched picks or
> +		 * sleep.
> +		 */

The part of the comment about SCX_DEQ_SCHED_CHANGE looks like it belongs in
call_task_dequeue(), not here.

>  		if (SCX_HAS_OP(sch, dequeue))
> -			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> -					 p, deq_flags);
> +			call_task_dequeue(sch, rq, p, deq_flags);

How about adding WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_NEED_DEQ)) here or in
call_task_dequeue()?

Thanks,
Kuba
