Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77120372B4D;
	Wed,  4 Feb 2026 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243281; cv=none; b=osZa6f8R95/p/6jtEdgtE5SAcmZQWhHPvCd2IV1d/NwzxmagNZ+TR6/o1zgL8FZbixVBtjgZ0ed8GUotg1ISoWbQh/UUAnprbeuKEu6mKSQ/we/grbpUq35Y5WVmaiPWCbkASK8p/9YrxVSJh3881DTzGG4blK+z4Sg+JTYKIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243281; c=relaxed/simple;
	bh=A/X6aubQqWVtwz4N7jUKMXY89KHaTBUVZ+WqW/2WEzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAr0dzQ/XYyrCDCEzLQurchY96Pr040Yvt3mOkBceQDW+OrkGXW05/QFfkegMuEQvilYhHUfl0HoNq7MQCc1GC9R7H6YNAIk1kHG/s6okzcI0L5GnR7VjNoMJ0ZHSawPFooRZaN6MVfynAV/OO79+jVaXvWSu8f8fju82pYtkuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh4rM0rc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh4rM0rc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043E3C4CEF7;
	Wed,  4 Feb 2026 22:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770243281;
	bh=A/X6aubQqWVtwz4N7jUKMXY89KHaTBUVZ+WqW/2WEzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wh4rM0rc2Ye511E40c8MkzJyTbFJ46VfNsMsueQodHO+iKVzrnMNlKPo6my1hGX1w
	 xYk0asGD28oOu87q6DLU7PBd8Aw7ow0JT7HiJ6+xJbGo886n3EsaZkJYwS1pJJhvGu
	 y7QWeToEoNvEjihCjMNlknUVWIP6GtfRsTpmGdhME04qyHoxXGyz/DEBT4cK6Vr32u
	 IEsikuUk+yrON0pqorED4Gp+clqXo2t/EZ4mzgbQZQggXjeoXt3PPGEX6+2sEdNe6/
	 Hr+1bxVC8mZhyMxLTo17Hh9pvpClzucgHjOMUHNeMWD7coKHfDHmoUwZpbt/CMTApe
	 M69qlDH9yQYRg==
Date: Wed, 4 Feb 2026 12:14:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYPE0GRJEu5gdBVl@slm.duckdns.org>
References: <20260204160710.1475802-1-arighi@nvidia.com>
 <20260204160710.1475802-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204160710.1475802-2-arighi@nvidia.com>

Hello,

On Wed, Feb 04, 2026 at 05:05:58PM +0100, Andrea Righi wrote:
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
> 
> To identify dequeues triggered by scheduling property changes, introduce
> the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
> the dequeue was caused by a scheduling property change.
> 
...
> +   **Property Change Notifications for Running Tasks**:
> +
> +   For tasks that have left BPF custody (running or on terminal DSQs),
> +   property changes can be intercepted through the dedicated callbacks:

I'm not sure this section is necessary. The way it's phrased makes it sound
like schedulers would use DEQ_SCHED_CHANGE to process property changes but
that's not the case. Relevant property changes will be notified in whatever
ways they're notified and a task being dequeued for SCHED_CHANGE doesn't
necessarily mean there will be an associated property change event either.
e.g. We don't do anything re. on sched_setnuma().

> @@ -1102,6 +1122,18 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  	dsq_mod_nr(dsq, 1);
>  	p->scx.dsq = dsq;
>  
> +	/*
> +	 * Mark task as in BPF scheduler's custody if being queued to a
> +	 * non-builtin (user) DSQ. Builtin DSQs (local, global, bypass) are
> +	 * terminal: tasks on them have left BPF custody.
> +	 *
> +	 * Don't touch the flag if already set (e.g., by
> +	 * mark_direct_dispatch() or direct_dispatch()/finish_dispatch()
> +	 * for user DSQs).
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue) && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
> +		p->scx.flags |= SCX_TASK_OPS_ENQUEUED;

given that this is tied to dequeue, maybe a more direct name would be less
confusing? e.g. something like SCX_TASK_NEED_DEQ?

> @@ -1274,6 +1306,24 @@ static void mark_direct_dispatch(struct scx_sched *sch,
>  
>  	p->scx.ddsp_dsq_id = dsq_id;
>  	p->scx.ddsp_enq_flags = enq_flags;
> +
> +	/*
> +	 * Mark the task as entering BPF scheduler's custody if it's being
> +	 * dispatched to a non-terminal DSQ (i.e., custom user DSQs). This
> +	 * handles the case where ops.select_cpu() directly dispatches - even
> +	 * though ops.enqueue() won't be called, the task enters BPF custody
> +	 * if dispatched to a user DSQ and should get ops.dequeue() when it
> +	 * leaves.
> +	 *
> +	 * For terminal DSQs (local DSQs and SCX_DSQ_GLOBAL), ensure the flag
> +	 * is clear since the BPF scheduler is done with the task.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue)) {
> +		if (!is_terminal_dsq(dsq_id))
> +			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> +		else
> +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> +	}

Hmm... I'm a bit confused on why this needs to be in mark_direct_dispatch()
AND dispatch_enqueue(). The flag should be clear when off SCX. The only
places where it could be set is from the enqueue path - when a task is
direct dispatched to a non-terminal DSQ or BPF. Both cases can be reliably
captured in do_enqueue_task(), no?

>  static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
> @@ -1287,6 +1337,41 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
...
> +	if (SCX_HAS_OP(sch, dequeue)) {
> +		if (!is_terminal_dsq(dsq->id)) {
> +			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> +		} else {
> +			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
> +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
> +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> +		}
> +	}

And when would direct_dispatch() need to call ops.dequeue()?
direct_dispatch() is only used from do_enqueue_task() and there can only be
one direct dispatch attempt on any given enqueue event. A task being
enqueued shouldn't have the OPS_ENQUEUED set and would get dispatched once
to either a terminal or non-terminal DSQ. If terminal, there's nothing to
do. If non-terminal, the flag would need to be set. Am I missing something?

> @@ -1523,6 +1608,31 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
...
> +		if (SCX_HAS_OP(sch, dequeue) &&
> +		    p->scx.flags & SCX_TASK_OPS_ENQUEUED) {

nit: () around & expression.

> +			u64 flags = deq_flags;
> +
> +			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
> +				flags |= SCX_DEQ_SCHED_CHANGE;
> +
> +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
> +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> +		}
>  		break;
>  	case SCX_OPSS_QUEUEING:
>  		/*
> @@ -1531,9 +1641,24 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  		 */
>  		BUG();
>  	case SCX_OPSS_QUEUED:
> -		if (SCX_HAS_OP(sch, dequeue))
> -			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> -					 p, deq_flags);
> +		/*
> +		 * Task is still on the BPF scheduler (not dispatched yet).
> +		 * Call ops.dequeue() to notify. Add %SCX_DEQ_SCHED_CHANGE
> +		 * only for property changes, not for core-sched picks or
> +		 * sleep.
> +		 *
> +		 * Clear the flag after calling ops.dequeue(): the task is
> +		 * leaving BPF scheduler's custody.
> +		 */
> +		if (SCX_HAS_OP(sch, dequeue)) {
> +			u64 flags = deq_flags;
> +
> +			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
> +				flags |= SCX_DEQ_SCHED_CHANGE;
> +
> +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
> +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;

I wonder whether this and the above block can be factored somehow.

> @@ -1630,6 +1755,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
>  					 struct scx_dispatch_q *src_dsq,
>  					 struct rq *dst_rq)
>  {
> +	struct scx_sched *sch = scx_root;
>  	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
>  
>  	/* @dsq is locked and @p is on @dst_rq */
> @@ -1638,6 +1764,15 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
>  
>  	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
>  
> +	/*
> +	 * Task is moving from a non-local DSQ to a local DSQ. Call
> +	 * ops.dequeue() if the task was in BPF custody.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED)) {
> +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, dst_rq, p, 0);
> +		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> +	}
> +
>  	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
>  		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
>  	else
> @@ -2107,6 +2242,36 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
>  
>  	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
>  
> +	/*
> +	 * Handle ops.dequeue() based on destination DSQ.
> +	 *
> +	 * Dispatch to terminal DSQs (local DSQs and SCX_DSQ_GLOBAL): the BPF
> +	 * scheduler is done with the task. Call ops.dequeue() if it was in
> +	 * BPF custody, then clear the %SCX_TASK_OPS_ENQUEUED flag.
> +	 *
> +	 * Dispatch to user DSQs: task is in BPF scheduler's custody.
> +	 * Mark it so ops.dequeue() will be called when it leaves.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue)) {
> +		if (!is_terminal_dsq(dsq_id)) {
> +			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> +		} else {

Let's do "if (COND) { A } else { B }" instead of "if (!COND) { B } else { A
}". Continuing from earlier, I don't understand why we'd need to set
OPS_ENQUEUED here. Given that a transition to a terminal DSQ is terminal, I
can't think of conditions where we'd need to set OPS_ENQUEUED from
ops.dispatch().

> +			/*
> +			 * Locking: we're holding the @rq lock (the
> +			 * dispatch CPU's rq), but not necessarily
> +			 * task_rq(p), since @p may be from a remote CPU.
> +			 *
> +			 * This is safe because SCX_OPSS_DISPATCHING state
> +			 * prevents racing dequeues, any concurrent
> +			 * ops_dequeue() will wait for this state to clear.
> +			 */
> +			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
> +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
> +
> +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> +		}
> +	}

I'm not sure finish_dispatch() is the right place to do this. e.g.
scx_bpf_dsq_move() can also move tasks from a user DSQ to a terminal DSQ and
the above wouldn't cover it. Wouldn't it make more sense to do this in
dispatch_enqueue()?

> @@ -2894,6 +3059,14 @@ static void scx_enable_task(struct task_struct *p)
>  
>  	lockdep_assert_rq_held(rq);
>  
> +	/*
> +	 * Clear enqueue/dequeue tracking flags when enabling the task.
> +	 * This ensures a clean state when the task enters SCX. Only needed
> +	 * if ops.dequeue() is implemented.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue))
> +		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> +
>  	/*
>  	 * Set the weight before calling ops.enable() so that the scheduler
>  	 * doesn't see a stale value if they inspect the task struct.
> @@ -2925,6 +3098,13 @@ static void scx_disable_task(struct task_struct *p)
>  	if (SCX_HAS_OP(sch, disable))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
>  	scx_set_task_state(p, SCX_TASK_READY);
> +
> +	/*
> +	 * Clear enqueue/dequeue tracking flags when disabling the task.
> +	 * Only needed if ops.dequeue() is implemented.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue))
> +		p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;

If we make the flag transitions consistent, we shouldn't need these, right?
We can add WARN_ON_ONCE() at the head of enqueue maybe.

Thanks.

-- 
tejun
