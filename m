Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235AC3A6B76;
	Mon,  3 Aug 2026 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793002; cv=none; b=oEN3Y3Iwb7iLh5RCMimlckAQ8Ny8bIEZHaImaT7kr45EsAFSAgtmWMR2QVgFctVfF5qpz2FrehKVWYFfns1orvboOTOCJyNGIaPG1gIlwBKAZcy50UrQiRsMKz5CXRBqU+nYHWK+p4qyGxEQExCR/i/gbsJmdR9DoglcP9y/nZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793002; c=relaxed/simple;
	bh=6esQK1OGXjLuxOHhMjvuyqSIOjQckRvwdkenYBtyNqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA5+Yp6+pOyQttAEYT0HVEZGt/WRAENZrAm9XdMaNptriC62/6mOCtdOGFrOJApyQ95nsaMkc6lj5JrlgMvpeE3o/bpcRgYGTRYSDX7uGmxpPO9Ez5ofpouWX6IigCKmE+cwwuQn9MXRRZCVTAgXRUY/JtSt6X7Ua5w9ZTv+nOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFTFQlCB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFTFQlCB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EAF1F000E9;
	Mon,  3 Aug 2026 21:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785793000;
	bh=rHqF9vBnJF70uwbppwC4s/xkgI+4rzp709RG0P7K/b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RFTFQlCBy/7k4vlUlW9dJ6arUKP/z/8RmEBykJ8YU5gV5y3obWMgKNwaGbqMYwYlq
	 uzOgBSrj4M5OcBU19qACSZV/80vS/VaZ+T4oN+FvJCYJDL9oN00ktry7/49dUVv73c
	 6fXStUsCM0x5WBE+/lfQwTJLf9ddjkNQJagCaDMbO5wZlj53eYKdvGV2Qny0OVmhtu
	 uP0y3lTJMBXlsxPnhYLnk9Jx30MCR+F+fteUD22CBM0r+ae3Rr5UpyRhruTOoB9wyz
	 3b6AIqj5p5bkkejQvTisLdMeFebx2qG5c/vJB0uU30MqP+DFgwfWOXtXmSYHVLAiYH
	 7ZRorDLoNursw==
Date: Mon, 3 Aug 2026 11:36:39 -1000
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
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] sched_ext: Handle proxy-exec races in remote DSQ
 transfers
Message-ID: <anEJ5xj2bhXg5GSf@slm.duckdns.org>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-11-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728154425.1549660-11-arighi@nvidia.com>

Hello,

On Tue, Jul 28, 2026 at 05:43:28PM +0200, Andrea Righi wrote:
...
> @@ -135,6 +135,9 @@ enum scx_ent_flags {
> @@ -145,6 +148,8 @@ enum scx_ent_flags {
>  	SCX_TASK_REENQ_IMMED	= 2 << SCX_TASK_REENQ_REASON_SHIFT,
>  	SCX_TASK_REENQ_PREEMPTED = 3 << SCX_TASK_REENQ_REASON_SHIFT,
>  	SCX_TASK_REENQ_CAP	= 4 << SCX_TASK_REENQ_REASON_SHIFT,
> +	SCX_TASK_REENQ_MIGRATION_DISABLED = 5 << SCX_TASK_REENQ_REASON_SHIFT,
> +	SCX_TASK_REENQ_PROXY	= 6 << SCX_TASK_REENQ_REASON_SHIFT,

Given that MIGRATION_DISABLED can only happen with proxy execution, it may
be better to name it accordingly. Maybe that's too long. Do we have to
distinguish between PROXY and MIGRATION_DISABLED? We can count both as
PROXY, no?

> +/*
> + * Proxy execution can change @p's execution and migration-disabled state
> + * without touching its DSQ entry or clearing holding_cpu. Check those states
> + * with @p's rq locked. Without proxy execution, the holding_cpu handshake is
> + * sufficient and this must not affect the existing migration path.
> + */
> +static u32 task_move_reject_reason(struct task_struct *p)
> +{
> +	struct rq *src_rq = task_rq(p);
> +
> +	lockdep_assert_rq_held(src_rq);
> +
> +	if (!sched_proxy_exec())
> +		return SCX_TASK_REENQ_NONE;
> +
> +	/* @p may be rq->curr under another task's scheduling context. */
> +	if (task_on_cpu(src_rq, p))
> +		return SCX_TASK_REENQ_PROXY;
> +
> +	/*
> +	 * Reject only BPF-directed migration. proxy_migrate_task() may still
> +	 * move a blocked donor's scheduling context to its lock owner's CPU.
> +	 */

I have a hard time understanding this comment. Can you explain a bit more?

> +	if (is_migration_disabled(p))
> +		return SCX_TASK_REENQ_MIGRATION_DISABLED;
> +
> +	/* Don't move an active scheduling context off its source rq. */
> +	if (task_current_donor(src_rq, p))
> +		return SCX_TASK_REENQ_PROXY;
> +
> +	return SCX_TASK_REENQ_NONE;
> +}
> +
> +/*
> + * Park a task whose remote transfer raced with proxy execution. Reenqueueing
> + * from the source rq makes the task's owning scheduler choose its placement
> + * again and preserves sub-scheduler containment.
> + */
> +static void scx_reject_task(struct scx_sched *sch, struct rq *rq,
> +			    struct task_struct *p, u64 enq_flags, u32 reason)
> +{
> +	lockdep_assert_rq_held(rq);
> +	WARN_ON_ONCE(reason != SCX_TASK_REENQ_MIGRATION_DISABLED &&
> +		     reason != SCX_TASK_REENQ_PROXY);
> +	WARN_ON_ONCE(p->scx.reject_reason);
> +
> +	p->scx.holding_cpu = -1;
> +	p->scx.reject_reason = reason;
> +	p->scx.flags &= ~SCX_TASK_IMMED;
> +	enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT);

SCX_ENQ_HEAD likely needs clearing too. After applying the rescue patchset,
scx_resolve_local_dsq() has:

	/*
	 * Diverting to rescue or reject, neither of which honors IMMED, PREEMPT
	 * or HEAD - a diversion has no priority and IMMED is not allowed on
	 * non-local DSQs. Strip the enq and task flags along with the slice.
	 */
	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_HEAD |
			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
	p->scx.flags &= ~SCX_TASK_IMMED;

We should probably factor that out and use that whenever we're diverting.

> @@ -2533,6 +2617,15 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
>  
>  	if (dst_dsq->id == SCX_DSQ_LOCAL) {
>  		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
> +		reject_reason = src_rq != dst_rq ?
> +			task_move_reject_reason(p) : SCX_TASK_REENQ_NONE;
> +		if (unlikely(reject_reason)) {
> +			dispatch_dequeue_locked(p, src_dsq);
> +			raw_spin_unlock(&src_dsq->lock);
> +			scx_reject_task(sch, src_rq, p, enq_flags,
> +					reject_reason);
> +			return src_rq;
> +		}

I wonder whether it'd be cleaner if we just mark the task for rejection and
then make scx_resolve_local_dsq() resolve that to reject dsq instead of
directly inserting from each site. I guess the problem is that the rejection
has to be on the source rq, not the destination one. I hope there's a neater
way to do this.

>  /*
> - * Drain @rq->scx.reject_dsq and reenqueue each task so that its owning BPF
> - * scheduler chooses placement again.
> + * Drain ready tasks from @rq->scx.reject_dsq and reenqueue them so that their
> + * owning BPF schedulers choose placement again. Proxy-active tasks remain
> + * parked until proxy resolution schedules another drain after switch-out.
>   *
>   * A task can be re-rejected repeatedly. Reenqueues are bounded per task by
>   * SCX_REENQ_MAX_REPEAT in scx_do_enqueue_task(), which ejects the owning
> - * scheduler. The private list below prevents a task from being revisited in
> - * the same round.
> + * scheduler.
>   */
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
>  		u32 reason = p->scx.reject_reason;
>  
>  		/* migration_pending tasks should have bypassed to local DSQ */
> -		if (WARN_ON_ONCE(p->migration_pending))
> -			continue;
> +		WARN_ON_ONCE(p->migration_pending);

Why this change? Also, wouldn't this now be allowed to happen? During task
move, if it hits migration_pending due to proxy exec, the task would be put
on reject DSQ, right? Reenq can trigger from other sources before
migration_pending is cleared and then would see the migration_pending set.
Shouldn't it just continue?

>  		if (WARN_ON_ONCE(!reason))
>  			continue;
>  
> +		if (reason == SCX_TASK_REENQ_PROXY &&
> +		    (task_on_cpu(rq, p) || task_current_donor(rq, p))) {
> +			proxy_pending = true;
> +			continue;
> +		}

ie. Shouldn't migration_pending() be one of the || conditions above? And
then if it's still migraiton_pending, that should trigger a warning?

Thanks.

-- 
tejun
