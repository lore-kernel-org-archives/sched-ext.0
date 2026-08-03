Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33598345EA5;
	Mon,  3 Aug 2026 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795532; cv=none; b=MfVy7PB04fd6KKFvdUpOFtFpJTCvejgT95Evg6cI9andKf5ik4ls71b6I/eH3IooV31NWM0DuyIof5KPv2eUFQmI3QKg+oHrGPIeNVJHeaep3BsZxRhaSqFwHRd4GuWn6ma2idlkmdXcONbUt9YYIMwGqprye4KPGipkErN1MLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795532; c=relaxed/simple;
	bh=a/KD1y1nVyvuGeUTJTOcmvwBiDxOB2S58rtTncWW+HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p++MfIhy+Aj9ra3B+bchb+TH6FHkrG3IyITZmIzzYw+E8u5h5rfIPQeM0Ik3seyec5I8ebwYKo/B+dDK3z7VIAQt8WCmhvjxndgxpTzoL/lw8PR0nxjFLzd07f73I813et7LScasEf5yLKm1uyKfh1WwUfMmEc34DegkgVmhVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSw8IQJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSw8IQJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994B21F000E9;
	Mon,  3 Aug 2026 22:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785795530;
	bh=D+/s8CYMZFfgk6lyG3RbmL7MleZOuV0Lfzpd4/S0X2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mSw8IQJRTuo48jUqbRinnRrwMqXWx4Gj2vPd9pTpkUh9TXDX2G9L9+IvAkEAGRrcJ
	 swjbBENFnRi/vy0xEpJ3vExyrHxe/xAXpwHVlmZuZ8CSx69ts7RBHme8y5nC+jjGbL
	 gzskqUBXeN97mamK3PIAkHs803JsQXD7yE+1MjM6kbr8KUAJIWDbxHHOyHUhLyR8QC
	 H1XgeNxIHnmRtFf7S1sBD0nGpCU79vXkzfDHjzsxOFlcCbvElwxHORYuHiqeFQBwvE
	 YLewHNMPM8WELzxItmcyNMo4AhsrGShnS7UIUjHwPk0NovJIgd0vOHQFyzgHxUjDgP
	 XKE6n4rdc8Xow==
Date: Mon, 3 Aug 2026 12:18:49 -1000
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
Subject: Re: [PATCH 12/15] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <anETyb93XUqBau6Y@slm.duckdns.org>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-13-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728154425.1549660-13-arighi@nvidia.com>

On Tue, Jul 28, 2026 at 05:43:30PM +0200, Andrea Righi wrote:
...
> +/*
> + * Called with @p's pi and rq locks held immediately before
> + * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
> + * is updated only once.
> + */
> +void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch)
> +{
> +	lockdep_assert_held(&p->pi_lock);
> +	lockdep_assert_rq_held(task_rq(p));
> +
> +	update_rq_clock(task_rq(p));
> +
> +	/* Block retained donors that the incoming scheduler cannot manage. */
> +	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
> +		sched_proxy_block_task(task_rq(p), p);
>  }

What are the cases that this one catches that scx_allow_proxy_exec() or
prepare_switch_scx() doesn't?

> @@ -2299,11 +2351,24 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
>  {
>  	/*
>  	 * Preemption between SCX tasks is implemented by resetting the victim
> -	 * task's slice to 0 and triggering reschedule on the target CPU.
> -	 * Nothing to do.
> +	 * task's slice to 0 and triggering reschedule on the target CPU. A
> +	 * mutex-blocked task is kept queued for proxy execution, so its wakeup
> +	 * doesn't go through enqueue_task_scx(). If the BPF scheduler manages
> +	 * blocked donors, reschedule explicitly so that it can reconsider a
> +	 * donor it declined to dispatch while blocked.

Can you make this a separate paragraph and is the comment uptodate? I'm
having a difficulty understanding what "if the BPF scheduler manages blocked
donors" mean.

>  	 */
> -	if (p->sched_class == &ext_sched_class)
> +	if (p->sched_class == &ext_sched_class) {
> +		bool enq_wakeup = p->scx.flags & SCX_TASK_ENQ_WAKEUP;
> +
> +		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
> +		if (!enq_wakeup && p->is_blocked) {
> +			struct scx_sched *sch = scx_task_sched(p);
> +
> +			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
> +				resched_curr(rq);
> +		}
>  		return;
> +	}

My understanding of what happens here is hazy. I suppose this is for the
case of an active proxy execution being preempted by another SCX task? I'm
not following why resched_curr() is needed here.

> @@ -3198,6 +3279,37 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  	if (p->scx.flags & SCX_TASK_QUEUED) {
>  		set_task_runnable(rq, p);
>  
> +		/*
> +		 * The rq lock has remained held since scx_allow_proxy_exec(), so
> +		 * @p's scheduler association cannot have changed. An associated
> +		 * donor stays queued only when its BPF scheduler enables
> +		 * %SCX_OPS_ENQ_BLOCKED; delegate its admission to that scheduler.
> +		 *
> +		 * If @sch is NULL, @p is transitioning into the root scheduler. The
> +		 * root is published before tasks enter EXT and cannot be cleared while
> +		 * this rq is locked. Preserve generic proxy execution by placing the
> +		 * donor directly on the local DSQ.
> +		 */
> +		if (p->is_blocked) {
> +			/*
> +			 * If the donor is the same and only the mutex owner
> +			 * changes, avoid triggering another ops.enqueue(): the
> +			 * BPF scheduler has already admitted the donor, so it
> +			 * can continue running.
> +			 */
> +			if (next == p)
> +				goto switch_class;
> +
> +			if (sch) {
> +				WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
> +				scx_do_enqueue_task(rq, p, 0, -1);
> +			} else {
> +				scx_dispatch_enqueue(scx_root, rq, &rq->scx.local_dsq,
> +						     p, 0);

Does this else arm actually happen? Can you describe the scenario? Oh, maybe
below is the counterpart.

> @@ -7758,6 +7875,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  
>  		if (old_class != new_class)
>  			queue_flags |= DEQUEUE_CLASS;
> +		if (old_class == new_class && new_class == &ext_sched_class) {
> +			scx_prepare_task_sched_change(p, sch);
> +			queue_flags |= DEQUEUE_NOCLOCK;
> +		}

I'd appreciate if there's more explanation of what happens during enable.
Wouldn't it be simpler if we just do sched_proxy_block_task() on all
transitions and start with a clean slate?

Thanks.

-- 
tejun
