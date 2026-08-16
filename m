Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0703769E4;
	Sun, 16 Aug 2026 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786924465; cv=none; b=NBbywJLOslolZEvNP9SnvE51ldwUoywS++3dBh8ldSrVUf2jEa4ROXDbyN/TFX20/0etexTMGuZ9O1oTZc19SXbL3RC3q5gj7NymWnaNDkaNxqIgnOKszuRrfCQzbxgWA3RJm3kOsDy77Rp2vF07BSUDyRnavgOpsKaPqIQb+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786924465; c=relaxed/simple;
	bh=JZmYx3nHYw0O5YNDnk2hBwWozsI74pcJv3dNDrkfSx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohpxrLY85asgwXPU+vC7L/7R2WFB0FzVLJ+BNFyVgFoRjkr0/WftyQhbhWF+53H2wrACn/Q+Ngf5tYjzOtqksODxbY2JubukZ3HsEHk7hXK6gIH3HYLgG5vOIe6AQZ/EQQ090BnMX2SSUk2mkjuAhEzo0XDAa4+vXCqcdiw1Cxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR836G/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR836G/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5051F000E9;
	Sun, 16 Aug 2026 23:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786924463;
	bh=wtNI9nRlaFyCJfyh2d4kuOmJb6sievEMrEadXU5z+7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mR836G/hwDmgp/ZAbj4Kcw7LSP2eLPTfMrkFacmBL1NtoszcpU6eCA44OC+lv6xtg
	 x19w3P6+njc0vpFOrh2JX7uUaTc2Rehjixx2+uT7/fzTS+mHJ5XNqU5zbJLIHYFLQ+
	 hSE4DnvU9xfaKXgBLtd0OgIBcx5bVOUzrYwfuqCezqD1Ub9iajT+lzEh4enb6+UEK0
	 U+16Jd0o+AAfU4P/YSsZivt9h/Ok7NGiEJSjLQexQE9TzZ0IeY1eY80hIf12V1RM8J
	 B16jGkUNJh+vVHReNEVtXPzYC5CqHHak+Insb9k8Z0d4cOKIdprGptFXOsXWee+UhR
	 7p7IQgvB4vWgw==
Date: Sun, 16 Aug 2026 13:54:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] sched_ext: Handle proxy-exec races in remote DSQ
 transfers
Message-ID: <aoJNrhYq_MjO1bDb@slm.duckdns.org>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-13-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816173732.17162-13-arighi@nvidia.com>

Hello,

On Sun, Aug 16, 2026 at 07:35:10PM +0200, Andrea Righi wrote:
> +/*
> + * Proxy resolution happens before rq->curr is switched. Queue deferred work
> + * on the rq so that an outgoing proxy owner has cleared on_cpu by the time
> + * reject_dsq is drained.
> + */

This doesn't make sense to me. Deferred operatoins can only execute after
the scheduling operations are complete no matter when they were queued. I
can see why you'd need this to kick rejected tasks that can't be queued yet.

>  void scx_proxy_resolved(struct rq *rq)
>  {
> +	lockdep_assert_rq_held(rq);
> +
> +	if (rq->scx.flags & SCX_RQ_PROXY_REENQ)
> +		schedule_deferred_locked(rq);
>  }
>  
>  void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
> @@ -1530,12 +1539,17 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
>  	call_task_dequeue(sch, rq, p, 0);
>  
>  	/*
> -	 * Only local inserts get the wakeup treatment below. Rejects kick the
> -	 * deferred reenq and rescue parks are paced by the rescue timer.
> +	 * Only local inserts get the wakeup treatment below. Proxy-active tasks
> +	 * and rescuees remain parked until their respective resolution paths.
> +	 * Other rejects can be reenqueued immediately.
>  	 */
>  	if (unlikely(dsq->id != SCX_DSQ_LOCAL)) {
> -		if (dsq->id == SCX_DSQ_REJECT)
> +		if (dsq->id == SCX_DSQ_REJECT) {
> +			if ((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) ==
> +			    SCX_TASK_REENQ_PROXY)
> +				rq->scx.flags |= SCX_RQ_PROXY_REENQ;

and if my reading above is correct, this wouldn't be necessary, right?

>  			schedule_deferred_locked(rq);
> +		}
>  		return;
>  	}
>  
...
> +static bool task_proxy_move_active(struct task_struct *p)

How about task_proxy_running_or_donating()

> +static bool task_move_proxy_raced(struct task_struct *p)

and task_proxy_unsafe_to_move() instead?

> +/*
> + * Park a task whose remote transfer raced with proxy execution. Reenqueueing
> + * from the source rq makes the task's owning scheduler choose its placement
> + * again and preserves sub-scheduler containment.
> + */
> +static void scx_reject_task(struct scx_sched *sch, struct rq *rq,
> +			    struct task_struct *p, u64 enq_flags)

and scx_proxy_reject_task().

> +{
> +	lockdep_assert_rq_held(rq);
> +	WARN_ON_ONCE((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) &&
> +		     !(enq_flags & SCX_ENQ_REENQ));

In the previous patch, is it possible to clear reason before reenqueueing
it and get rid of overwrite cases or does that quite not work out?

> +	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> +
> +	p->scx.holding_cpu = -1;
> +	p->scx.flags |= SCX_TASK_REENQ_PROXY;
> +	scx_prepare_dsq_divert(p, &enq_flags);
> +
> +	scx_dispatch_enqueue(sch, rq, &rq->scx.reject_dsq, p, 0, 0, enq_flags);
> +}
> +
>  /**
>   * unlink_dsq_and_switch_rq_lock() - Unlink task and switch to its rq lock
>   * @p: target task
> @@ -2596,6 +2667,20 @@ static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
>  				struct scx_dispatch_q *dsq, struct rq *src_rq)
>  {
>  	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
> +		/*
> +		 * Proxy execution may have changed @p's running or
> +		 * migration-disabled state while switching rq locks without
> +		 * clearing holding_cpu. Park it on the source rq and let its
> +		 * owning scheduler choose its placement again.
> +		 */
> +		if (unlikely(task_move_proxy_raced(p))) {
> +			p->scx.dsq = NULL;
> +			scx_reject_task(sch, src_rq, p,
> +					enq_flags | SCX_ENQ_CLEAR_OPSS);

No need for line break.

> +			switch_rq_lock(src_rq, this_rq);
> +			return false;
> +		}
> +
>  		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
>  		return true;
>  	} else {
> @@ -2626,6 +2711,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
>  					 struct scx_dispatch_q *dst_dsq)
>  {
>  	struct rq *src_rq = task_rq(p), *dst_rq;
> +	bool proxy_raced;
>  
>  	BUG_ON(src_dsq->id == SCX_DSQ_LOCAL);
>  	lockdep_assert_held(&src_dsq->lock);
> @@ -2633,6 +2719,19 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
>  
>  	if (dst_dsq->id == SCX_DSQ_LOCAL) {
>  		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
> +		/*
> +		 * Unlike the rq-lock handoff paths, @src_rq has been locked
> +		 * throughout this operation. Only active proxy state can race the
> +		 * move here; let the enforcing check below diagnose an ordinary
> +		 * migration-disabled task.
> +		 */
> +		proxy_raced = src_rq != dst_rq && task_proxy_move_active(p);
> +		if (unlikely(proxy_raced)) {

I don't know what bouncing through the local var buys. Out of curiosity, if
task_move_proxy_raced() is used here, does something break or is it just to
avoid unnecessary tests?

> +			dispatch_dequeue_locked(p, src_dsq);
> +			raw_spin_unlock(&src_dsq->lock);
> +			scx_reject_task(sch, src_rq, p, enq_flags);
> +			return src_rq;
> +		}
>  		if (src_rq != dst_rq &&
>  		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
>  			dst_dsq = find_global_dsq(sch, task_cpu(p));
> @@ -2788,7 +2887,9 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  	/* task_rq couldn't have changed if we're still the holding cpu */
>  	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
>  	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
> +		bool proxy_raced = src_rq != dst_rq && task_move_proxy_raced(p);
>  		bool fallback = false;
> +
>  		/*
>  		 * If @p is staying on the same rq, there's no need to go
>  		 * through the full deactivate/activate cycle. Optimize by
> @@ -2798,9 +2899,13 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  			p->scx.holding_cpu = -1;
>  			scx_dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
>  					     slice, vtime, enq_flags | SCX_ENQ_APPLY_SLICE);
> -		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> -			p->scx.holding_cpu = -1;
> +		} else if (unlikely(proxy_raced)) {

Ditto, I don't know what the bouncing through proxy_raced buysk. Alos, in
this else clause src_rq != dst_rq is already established.

>  			fallback = true;
> +			scx_reject_task(sch, src_rq, p, enq_flags);
> +		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq,
> +							       true))) {

No need for line break.

> +			fallback = true;
> +			p->scx.holding_cpu = -1;

fallback = true and p->scx.holding_cpu = -1 lines are swapped compared to
the original code making the diff look a bit confusing.

>  static void scx_reenq_reject(struct rq *rq)
>  {
>  	LIST_HEAD(tasks);
>  	struct task_struct *p, *n;
> +	bool proxy_pending = false;
>  
>  	lockdep_assert_rq_held(rq);
>  
> -	if (list_empty(&rq->scx.reject_dsq.list))
> +	if (list_empty(&rq->scx.reject_dsq.list)) {
> +		rq->scx.flags &= ~SCX_RQ_PROXY_REENQ;
>  		return;
> +	}
>  
>  	/*
> -	 * Move tasks to a private list so a task re-rejected by
> +	 * Move ready tasks to a private list so a task re-rejected by
>  	 * scx_do_enqueue_task() below isn't revisited this round.
>  	 */
>  	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
>  		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
>  
> -		/* migration_pending tasks should have bypassed to local DSQ */
> -		WARN_ON_ONCE(p->migration_pending);
>  		WARN_ON_ONCE(!reason);
>  
> +		/*
> +		 * The affinity machinery owns placement while a migration is
> +		 * pending and will dequeue and reactivate @p as necessary. Don't
> +		 * return it to BPF in the meantime. This isn't a proxy-resolution
> +		 * state and thus doesn't contribute to @proxy_pending.
> +		 */
> +		if (p->migration_pending) {
> +			WARN_ON_ONCE(reason != SCX_TASK_REENQ_PROXY);
> +			continue;
> +		}
> +
> +		if (reason == SCX_TASK_REENQ_PROXY &&
> +		    (task_on_cpu(rq, p) || task_current_donor(rq, p))) {
> +			proxy_pending = true;
> +			continue;
> +		}

Can you structure the code so that it's:

        if (proxy_exec_enabled() && reason == SCX_TASK_REENQ_PROXY) {
                ...
        else {
                WARN_ON_ONCE(p->migration_pending);
                ...
        }
              
>  		scx_dispatch_dequeue(rq, p);
>  		p->scx.flags |= reason;
>  
>  		list_add_tail(&p->scx.dsq_list.node, &tasks);
>  	}
>  
> +	if (proxy_pending)
> +		rq->scx.flags |= SCX_RQ_PROXY_REENQ;
> +	else
> +		rq->scx.flags &= ~SCX_RQ_PROXY_REENQ;

Hmm... this looks unconventional. Shouldn't the cosumer of the flag -
scx_proxy_resolved() - clear it?

> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 2b2dcde923600..8b0be25cda7d0 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -1758,6 +1758,14 @@ enum scx_enq_flags {
>  	SCX_ENQ_SLICE_DFL	= 1LLU << 62,	/* carried slice is a default refill */
>  };
>  
> +/* Strip priority and carried slice state when diverting from a local DSQ. */
> +static inline void scx_prepare_dsq_divert(struct task_struct *p, u64 *enq_flags)

How about scx_divert_strip_flags()?

Thanks.

-- 
tejun
