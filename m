Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D9224F3;
	Wed, 11 Feb 2026 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839278; cv=none; b=OESFhDID4NlXd3si3puVLoeri5tnKD1b6HksiqO4ZGAzmoiuWCjFbYPrD8rvr+Km5Npmk/j3YvyYXx15QU1ckrywVMoSayMzc+kZMQi0qo0LtBjqlY5K+/cFYAgC4B+/yr6DrcUvpbx/XHp2dxkHNkdRDUKuEp16FwF4wWgo7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839278; c=relaxed/simple;
	bh=BycrkdpbGsOJZrW1N8iVzYg4YRlIMlhAknfAts/zCTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZCQZGF7aKzcJaCGk+ctuQcghe7RO2+WqyuntTOzCq+rcqihXiw3kNI+ZOM4uyElUNeFnaHqWEaAJvmX4MvaKmohj3YQ0Sikpytm4Sc6nehmKGWNOpVoVbic6zFqatrWBik0hUizIWm/yVz07amk4KDzdgQrNuhwNyPAdYIN2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAn1k4fA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAn1k4fA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB9BC4CEF7;
	Wed, 11 Feb 2026 19:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770839278;
	bh=BycrkdpbGsOJZrW1N8iVzYg4YRlIMlhAknfAts/zCTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAn1k4fAI/029q4U9IKtM34NQ2o+iqbsLkTILmQiVkiZgm5D1qT8ZQMj8urMoukcs
	 jNkFMQHS2d/vlLD9WU8JStxhYDEvulQOdTLQ3mIsYt9v51tnGP2gAboMwVTVdcxxE/
	 IlE7QzqUWiY2goST2iVuJ1F5J/VVIZXYSiH6w7Y64hEd2qPUfYU9GJxZKvavp4d9yL
	 QIz+3YojMHz5GQr6hlJlcMxrr1b47CTaR3Ad8kWe3wRBeTv11htHuTowunnABC8RXI
	 bhQVBXvsksN677MLYfCv4j6rx4HdMJQA4gdlqeukcI9Gt7RT5TnIxSzM97A6bkbIrr
	 iIlcfY/VSyXSw==
Date: Wed, 11 Feb 2026 09:47:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYzc7ZVkSrtdeHnA@slm.duckdns.org>
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-2-arighi@nvidia.com>
 <aYu9KzKTMfNIFDwD@slm.duckdns.org>
 <aYyo_ALV_BT6WaE0@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYyo_ALV_BT6WaE0@gpd4>

Hello,

On Wed, Feb 11, 2026 at 05:06:20PM +0100, Andrea Righi wrote:
...
> > Please use () do clarify ordering between & and &&. It's just visually
> > confusing. I wonder whether it'd be cleaner to make it take @dsq instead of
> > @dsq_id and then it can just do:
> > 
> >         return dsq->id == SCX_DSQ_LOCAL || dsq->id == SCX_DSQ_GLOBAL;
> > 
> > because SCX_DSQ_LOCAL_ON is only used as the designator not as actual DSQ
> > id, and the above code positively identifies what's terminal.
> 
> Ok, but we also need to include SCX_DSQ_BYPASS, in that case maybe checking
> SCX_DSQ_FLAG_BUILTIN is more generic?

Ah, forgot about that. Hmm... we can do:

        switch (dsq->id) {
                case SCX_DSQ_LOCAL:
                case SCX_DSQ_GLOBAL:
                case SCX_DSQ_BYPASS:
                        return true;
                default:
                        return false;
        }

I just feel iffy about not being specific. Easier to make mistakes in the
future and more difficult to notice after doing so, but I think this point
is kinda moot. If we break up LOCAL and GLOBAL/BYPASS handling into separate
paths in dispatch_enqueue(), we won't need this function anyway.

> > > @@ -1524,6 +1590,12 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> > >  
> > >  	switch (opss & SCX_OPSS_STATE_MASK) {
> > >  	case SCX_OPSS_NONE:
> > > +		/*
> > > +		 * If the task is still in BPF scheduler's custody
> > > +		 * (%SCX_TASK_IN_CUSTODY is set) call ops.dequeue().
> > > +		 */
> > > +		if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> > > +			call_task_dequeue(sch, rq, p, deq_flags, true);
> > 
> > Hmm... why is this path necessary? Shouldn't the one that cleared OPSS be
> > responsible for clearing IN_CUSTODY too?
> 
> The path that clears OPSS to NONE doesn't always clear IN_CUSTODY: in
> dispatch_to_local_dsq(), when we're moving a task that was in DISPATCHING
> to a remote CPU's local DSQ, we only set ops_state to NONE, so a concurrent
> dequeue can proceed, but we only clear IN_CUSTODY when we later enqueue or
> move the task. So we can see NONE + IN_CUSTODY here and need to handle it.
> And we can't clear IN_CUSTODY at the same time we set NONE there, because
> we don't hold the task's rq lock yet and we can't trigger ops.dequeue().

I see. Can you please add a comment with the above?

...
> > I think a better place to put this would be inside local_dsq_post_enq() so
> > that dispatch_enqueue() and move_local_task_to_local_dsq() can share the
> > path. This would mean breaking out local and global cases in
> > dispatch_enqueue(). ie. at the end of dispatch_enqueue():
> > 
> >         if (is_local) {
> >                 local_dsq_post_enq(...);
> >         } else {
> >                 if (dsq->id == SCX_DSQ_GLOBAL)
> >                         global_dsq_post_enq(...);       /* or open code with comment */
> >                 raw_spin_unlock(&dsq->lock);
> >         }
> 
> Agreed, I'll move this into local_dsq_post_enq() and introduce
> a global_dsq_post_enq().

Yeah, and as you pointed out, BYPASS.

> > > +static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
> > > +			       struct task_struct *p,
> > > +			       struct scx_dispatch_q *dsq, struct rq *src_rq)
> > >  {
> > >  	raw_spin_rq_unlock(this_rq);
> > >  
> > >  	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
> > > +		/*
> > > +		 * Task is moving from a non-local DSQ to a local (terminal) DSQ.
> > > +		 * Call ops.dequeue() if the task was in BPF custody.
> > > +		 */
> > > +		if (p->scx.flags & SCX_TASK_IN_CUSTODY)
> > > +			call_task_dequeue(sch, src_rq, p, 0, false);
> > 
> > and this shouldn't be necessary. move_remote_task_to_local_dsq() deactivates
> > and reactivates the task. The deactivation invokes ops_dequeue() but that
> > should suppress dequeue invocation as that's internal transfer (this is
> > discernable from p->on_rq being set to TASK_ON_RQ_MIGRATING) and when it
> > gets enqueued on the target CPU, dispatch_enqueue() on the local DSQ should
> > trigger dequeue invocation, right?
> 
> Should we trigger ops.dequeue() when the task is dequeued inside
> move_remote_task_to_local_dsq() (in ops_dequeue() on the path triggered by
> deactivate_task() there) instead of suppressing it and invoking on the
> target in local_dsq_post_enq()?
> 
> That way the BPF sees dequeue on the source and then enqueue on the target,
> we avoid special-casing SCX_TASK_IN_CUSTODY in do_enqueue_task() and the
> "when to call dequeue" logic stays consistent in ops_dequeue and the
> terminal local/global post_enq paths.
> 
> Does it make sense or would you rather suppress it and only invoke on the
> target when the task lands on the local DSQ??

The end result is about the same because whenever we migrate we're sending
it to the local DSQ of the destination CPU, so whether we generate the event
on deactivation of the source CPU or activation on the destination doesn't
make *whole* lot of difference. However, conceptually, migrations are
internal events. There isn't anything actionable for the BPF scheduler. The
reason why ops.dequeue() should be emitted is not because the task is
changing CPUs (which caused the deactivation) but the fact that it ends up
in a local DSQ afterwards. I think it'll be cleaner both conceptually and
code-wise to emit ops.dequeue() only from dispatch_enqueue() and dequeue
paths.

Thanks.

-- 
tejun
