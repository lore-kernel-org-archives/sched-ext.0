Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600F3C2D;
	Mon, 17 Aug 2026 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935727; cv=none; b=u4WXpkm+WE5CLBFrYa19c0Kj0F91JKeCb6SS+mLWdNv3BgV4Ye1io9ZxSB1dhN/tKa+JfWYcqzy2LYGt1tYnESXeGGQ74i9d7F58EqkIQ/sHGHNRJqqtTJPu47supG8uKfxojHHs6unCvGR8h5B1D6gnXDA/T4aSsqYlxe7UYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935727; c=relaxed/simple;
	bh=1bEBP9k2/QFTtnahFj1oFwRVlZeEhLqUwY09ezNhPtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/mEg/s0j6wg9CKDUTv4oru8uvszRGk0fMU40diwocqVc+zcRe0RiyH8Hvd5s/P/bLs3WlbJxxMifDPkCAuMkORo2tX1p2tVX33FhXyuxaTKM/OYuHHRYmhVuR+vDo0Gwyy/ciM2/I9Gd9nwQ9+20XSRK9DAs4v6malCZpFiBKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrT7/YAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrT7/YAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6491F000E9;
	Mon, 17 Aug 2026 03:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786935724;
	bh=x2YxlNF4S4enKvzZaTOEQOMCg0CTJ26I9VRi/Usj5LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hrT7/YAvxTW6lOxE+yINnPVYr1lTx1iAmbEzG4TYvpL83A9WPfIFnK6XH27w6FtS8
	 vKiAcUBnNILw2iOjCxrYgPohX1BL9GI2X6dezcA+GWfD2hrwh71ztaGQG/KnhJg5Lz
	 ZpOkXeLchNnSgS4HAeerb5muLyf1aktRDha6fIiya0xylKSvbJ9vuWncEmLQ0RIEkA
	 Sv9d75v0CPdqeXf3uuUOMuuiigZI4xlhpaSMu0IhIiKikxalUXSoOCC/+qX+4m8zYB
	 N4bGq1oSB/KfuZMqPPS86CiHLX1VcMR2qjK9IIsnW83tuO8KwvrnZR9XEA8vUiS6q2
	 lhrgnjUEzQk1A==
Date: Sun, 16 Aug 2026 17:02:03 -1000
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
Subject: Re: [PATCH 14/17] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <aoJ5q7HbSUOxlC1H@slm.duckdns.org>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-15-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816173732.17162-15-arighi@nvidia.com>

On Sun, Aug 16, 2026 at 07:35:12PM +0200, Andrea Righi wrote:
>  bool scx_allow_proxy_exec(const struct task_struct *p)
>  {
> -	return p->sched_class != &ext_sched_class;
> +	struct scx_sched *sch;
> +
> +	if (p->sched_class != &ext_sched_class)
> +		return true;
> +
> +	/*
> +	 * scx_enabled() may change while __schedule() holds only @p's rq lock.
> +	 * Once @p is associated with a scheduler, use that scheduler's policy
> +	 * even while the global enable state is transitioning.
> +	 */

I'm not sure this comment is necessary. scx_task_sched() is stable while
holding the task's rq lock.

> @@ -2059,19 +2086,25 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
>  		goto direct;
>  
> +	enq_blocked = (sch->ops.flags & SCX_OPS_ENQ_BLOCKED) &&
> +		      p->is_blocked && !(enq_flags & SCX_ENQ_WAKEUP);

Why not just test directly in the if statement? It's not like the test
result is used anywhere else. Is the intention giving the test result an
intuitive name? I guess is_blocked && WAKEUP is the condition is the donor
gaining execution back? Might be worthwhile to add a comment.

> +	if (enq_blocked) {
> +		enq_flags |= SCX_ENQ_BLOCKED;
> +	} else {
> +		/* see %SCX_OPS_ENQ_EXITING */
> +		if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
> +		    unlikely(p->flags & PF_EXITING)) {

While at it, can you swap the order? This is ordered this way because OPS
testing used to be static_key but now that these are regular tests, it makes
more sense to test the unlikely one first, or maybe that belongs in a
separate patch.

> @@ -2183,8 +2216,17 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
>  	int sticky_cpu = p->scx.sticky_cpu;
>  	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
>  
> -	if (enq_flags & ENQUEUE_WAKEUP)
> +	/*
> +	 * p->is_blocked is cleared after wakeup_preempt(), so remember whether
> +	 * this is a full wakeup activation. If wakeup_preempt_scx() isn't called,
> +	 * set_next_task_scx() or a subsequent non-wakeup enqueue clears the flag.
> +	 */

I can't make heads or tails of this comment. This doesn't seem to explain
what TASK_ENQ_WAKEUP is used for but just goes into how it's managed.

> +	if (enq_flags & ENQUEUE_WAKEUP) {
>  		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
> +		p->scx.flags |= SCX_TASK_ENQ_WAKEUP;
> +	} else {
> +		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
> +	}
>  
>  	/*
>  	 * Restoring the current scheduling context will be immediately followed
> @@ -2399,10 +2441,30 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
>  	/*
>  	 * Preemption between SCX tasks is implemented by resetting the victim
>  	 * task's slice to 0 and triggering reschedule on the target CPU.
> -	 * Nothing to do.
> +	 *
> +	 * A mutex waiter can remain on-rq as a proxy donor while logically
> +	 * blocked. If it wakes without having been proxy-migrated,
> +	 * ttwu_runnable() calls here without another enqueue_task_scx(). Request
> +	 * rescheduling so that ops.dispatch() can reconsider the task after
> +	 * ttwu_runnable() clears is_blocked.
> +	 *
> +	 * A proxy-migrated donor instead returns through the full activation
> +	 * path, which calls enqueue_task_scx() before arriving here.
> +	 * SCX_TASK_ENQ_WAKEUP records that the enqueue already happened and an
> +	 * additional reschedule isn't needed.
>  	 */
> -	if (p->sched_class == &ext_sched_class)
> +	if (p->sched_class == &ext_sched_class) {
> +		bool enq_wakeup = p->scx.flags & SCX_TASK_ENQ_WAKEUP;

Ditto with bouncing test result.

> +
> +		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;

I'm not a big fan of SCX_TASK_ENQ_WAKEUP. This is a roundabout way to detect
owner -> donor case, right? Doesn't the caller already know? If so, can't it
just pass in that as a wake_flag?

> +		if (!enq_wakeup && p->is_blocked) {
> +			struct scx_sched *sch = scx_task_sched(p);
> +
> +			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
> +				resched_curr(rq);
> +		}

It'd nice if we can gate the above behind proxy enabled.

> @@ -2517,6 +2579,20 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
>  
>  	WARN_ON_ONCE(task_cpu(p) == cpu);
>  
> +	/*
> +	 * A blocked donor may be moved normally to select a new callback rq.

What's "callback" rq?

> +	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
> +	 * callback home.
> +	 *
> +	 * proxy_set_task_cpu() instead preserves wake_cpu when moving a donor to
> +	 * its lock owner's CPU. Keep such a donor on the proxy rq until it wakes;
> +	 * otherwise normal BPF placement may repeatedly pull it back to its
> +	 * callback rq only for proxy execution to move it to the owner again.
> +	 */
> +	if (sched_proxy_exec() && p->is_blocked &&
> +	    task_cpu(p) != p->wake_cpu)

No need for line break. Can you elaborate the scenario this scenario is
needed for? Is this the exact condition? Let's say a donor is running the
owner on the same CPU, so task_cpu(p) == p->wake_cpu. Wouldn't you still
want to block scx from moving it to another CPU? What am I missing?

Thanks.

-- 
tejun
