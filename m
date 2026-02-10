Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F056226D18;
	Tue, 10 Feb 2026 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770765614; cv=none; b=FWa4QaHxvVD+8rZTJCDyfkpiADCVRMJgQkvBRlMeuR94VX7fJFr/NEm2ZD3RjBOpTRMJ41/U9vilmIUbz5FbJYonkNkqeuO+6WIWsu1X4CKdkRosG3Tm2lnh+2+eKeRx14w86Hg1GcLp+PH+uiTRFKGyAY9uxRAHOvjDdlTVZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770765614; c=relaxed/simple;
	bh=5aI6ya8ZqMP2uMeb6Q+O3TDEbVgLE7Kxs39VFjKQnRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvTenR066TJ4/SJs05QZrpoLUUQC4bkOHJ0F6ZWoqK0ksvYEX7hlonghOVvR6vkO66vWHQGpPfE0AVHy8TWlzNPufOB+185YV5GrAY476Nk9hjpMLhjVZQ2NcUFvqEiLFuGYpK2TH41sBpafZFLoQ9vBVQKNaOw+Zanl+PZENDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r137UkaV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r137UkaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE50AC19423;
	Tue, 10 Feb 2026 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770765613;
	bh=5aI6ya8ZqMP2uMeb6Q+O3TDEbVgLE7Kxs39VFjKQnRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r137UkaVxYZm8FAGWWtUMYCTyZy3eK5s6xmJKV70tblJZ33pj3wAc5WXjkmhWfrwQ
	 0iVzpmOKno5jAIa6zVOh+AUnKKkU9lNs6C8x9eiGPRiDXo4jxcEz8pBKo+kPa/uLGo
	 UljZy/DC/ikxn0Ln4vSh44Wx4KlwjLE+/T310zPZkAl1U/wVAF5ceoRuHhg4GDbxMa
	 6kIq6gRJdZWfYzVsbg1GyStZYSSb4e3f5O5/02zQT7RT80s5t8TVkZMqEXDyjOB5vz
	 MkgXalR6ADkqqIJ3bTnJFdVP3cIXTs62XUlERgogpfsEaywAXRT8GlgktZIwrb8ggV
	 uEbNd139JGGzg==
Date: Tue, 10 Feb 2026 13:20:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYu9KzKTMfNIFDwD@slm.duckdns.org>
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210212813.796548-2-arighi@nvidia.com>

On Tue, Feb 10, 2026 at 10:26:04PM +0100, Andrea Righi wrote:
> +/**
> + * is_terminal_dsq - Check if a DSQ is terminal for ops.dequeue() purposes
> + * @dsq_id: DSQ ID to check
> + *
> + * Returns true if @dsq_id is a terminal/builtin DSQ where the BPF
> + * scheduler is considered "done" with the task.
> + *
> + * Builtin DSQs include:
> + *  - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
> + *    where tasks go directly to execution,
> + *  - Global DSQ (%SCX_DSQ_GLOBAL): built-in fallback queue,
> + *  - Bypass DSQ: used during bypass mode.
> + *
> + * Tasks dispatched to builtin DSQs exit BPF scheduler custody and do not
> + * trigger ops.dequeue() when they are later consumed.
> + */
> +static inline bool is_terminal_dsq(u64 dsq_id)
> +{
> +	return dsq_id & SCX_DSQ_FLAG_BUILTIN && dsq_id != SCX_DSQ_INVALID;
> +}

Please use () do clarify ordering between & and &&. It's just visually
confusing. I wonder whether it'd be cleaner to make it take @dsq instead of
@dsq_id and then it can just do:

        return dsq->id == SCX_DSQ_LOCAL || dsq->id == SCX_DSQ_GLOBAL;

because SCX_DSQ_LOCAL_ON is only used as the designator not as actual DSQ
id, and the above code positively identifies what's terminal.

> -static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
> +static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
> +			     struct scx_dispatch_q *dsq,
>  			     struct task_struct *p, u64 enq_flags)

While minor, this patch would be easier to read if the @rq addition were
done in a separate patch.

> +static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
> +			      struct task_struct *p, u64 deq_flags,
> +			      bool is_sched_change)

Isn't @is_sched_change a bit of misnomer given that it needs to exclude
SCX_DEQ_CORE_SCHED_EXEC. I wonder whether it'd be easier if @deq_flags
handling is separated out. This part is ops_dequeue() specific, right?
Everyone else statically knows what DEQ flags to use. That might make
ops_dequeue() calculate flags unnecessarily but ops_dequeue() is not
particularly hot, so I don't think that'd matter.

> +{
> +	if (SCX_HAS_OP(sch, dequeue)) {
> +		/*
> +		 * Set %SCX_DEQ_SCHED_CHANGE when the dequeue is due to a
> +		 * property change (not sleep or core-sched pick).
> +		 */
> +		if (is_sched_change &&
> +		    !(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
> +			deq_flags |= SCX_DEQ_SCHED_CHANGE;
> +
> +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, deq_flags);
> +	}
> +	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;

Let's move flag clearing to the call sites. It's a bit confusing w/ the
function name.

>  static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  {
>  	struct scx_sched *sch = scx_root;
> @@ -1524,6 +1590,12 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  
>  	switch (opss & SCX_OPSS_STATE_MASK) {
>  	case SCX_OPSS_NONE:
> +		/*
> +		 * If the task is still in BPF scheduler's custody
> +		 * (%SCX_TASK_IN_CUSTODY is set) call ops.dequeue().
> +		 */
> +		if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> +			call_task_dequeue(sch, rq, p, deq_flags, true);

Hmm... why is this path necessary? Shouldn't the one that cleared OPSS be
responsible for clearing IN_CUSTODY too?

> @@ -1631,6 +1706,7 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
>  					 struct scx_dispatch_q *src_dsq,
>  					 struct rq *dst_rq)
>  {
> +	struct scx_sched *sch = scx_root;
>  	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
>  
>  	/* @dsq is locked and @p is on @dst_rq */
> @@ -1639,6 +1715,16 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
>  
>  	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
>  
> +	/*
> +	 * Task is moving from a non-local DSQ to a local (terminal) DSQ.
> +	 * Call ops.dequeue() if the task was in BPF custody.
> +	 */
> +	if (p->scx.flags & SCX_TASK_IN_CUSTODY) {
> +		if (SCX_HAS_OP(sch, dequeue))
> +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, dst_rq, p, 0);
> +		p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> +	}

I think a better place to put this would be inside local_dsq_post_enq() so
that dispatch_enqueue() and move_local_task_to_local_dsq() can share the
path. This would mean breaking out local and global cases in
dispatch_enqueue(). ie. at the end of dispatch_enqueue():

        if (is_local) {
                local_dsq_post_enq(...);
        } else {
                if (dsq->id == SCX_DSQ_GLOBAL)
                        global_dsq_post_enq(...);       /* or open code with comment */
                raw_spin_unlock(&dsq->lock);
        }

> @@ -1801,12 +1887,19 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
>  		!WARN_ON_ONCE(src_rq != task_rq(p));
>  }
>  
> -static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
> -				struct scx_dispatch_q *dsq, struct rq *src_rq)
> +static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
> +			       struct task_struct *p,
> +			       struct scx_dispatch_q *dsq, struct rq *src_rq)
>  {
>  	raw_spin_rq_unlock(this_rq);
>  
>  	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
> +		/*
> +		 * Task is moving from a non-local DSQ to a local (terminal) DSQ.
> +		 * Call ops.dequeue() if the task was in BPF custody.
> +		 */
> +		if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> +			call_task_dequeue(sch, src_rq, p, 0, false);

and this shouldn't be necessary. move_remote_task_to_local_dsq() deactivates
and reactivates the task. The deactivation invokes ops_dequeue() but that
should suppress dequeue invocation as that's internal transfer (this is
discernable from p->on_rq being set to TASK_ON_RQ_MIGRATING) and when it
gets enqueued on the target CPU, dispatch_enqueue() on the local DSQ should
trigger dequeue invocation, right?

> @@ -1867,6 +1960,13 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
>  						     src_dsq, dst_rq);
>  			raw_spin_unlock(&src_dsq->lock);
>  		} else {
> +			/*
> +			 * Moving to a local DSQ, dispatch_enqueue() is not
> +			 * used, so call ops.dequeue() here if the task was
> +			 * in BPF scheduler's custody.
> +			 */
> +			if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> +				call_task_dequeue(sch, src_rq, p, 0, false);

and then this becomes unnecessary too.

> @@ -2014,9 +2114,16 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  		 */
>  		if (src_rq == dst_rq) {
>  			p->scx.holding_cpu = -1;
> -			dispatch_enqueue(sch, &dst_rq->scx.local_dsq, p,
> +			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
>  					 enq_flags);
>  		} else {
> +			/*
> +			 * Moving to a local DSQ, dispatch_enqueue() is not
> +			 * used, so call ops.dequeue() here if the task was
> +			 * in BPF scheduler's custody.
> +			 */
> +			if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> +				call_task_dequeue(sch, src_rq, p, 0, false);

ditto.

Thanks.

-- 
tejun
