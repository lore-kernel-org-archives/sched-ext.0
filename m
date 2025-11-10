Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930623504B
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762824; cv=none; b=u9i2aqzzqlyzj7pzqEuqLHQFsH8QQseiepw712T8Hj3n3AUPbYnlGAip7XxKhmbGkFzZcngnuvyizdwXotyAQ31Hp/G7ktDmhYBtA3yEpb5o1RnIoRRbcnNXHWy8RMdjtMsDC8hPkdpoGDcRovOCHGSRCXJTEwQ/gUwxoT8dJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762824; c=relaxed/simple;
	bh=N2seGgamKVNJkxiemETbJGpGIEpLgQfWLsV3JObAZa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmniIAz0JXO194ljhtgK92RChPFvU7ehuHiXoloyZCvseq2Em5409pcETPdVTiStJOW55ejUt+R1KDT5MhW1cUXcEC0fNsoExzuVj6cd22LIH15le6ThWL4SxXp3x0pDeI7liMU1TL4YEI3FvO9IVIQIN5nrBNZiI8QaJR7uGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XIyEdig/; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XIyEdig/"
Date: Mon, 10 Nov 2025 09:20:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762762820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZN0nrp1CAT/vmr1lLJgZKJRO7oN7a+g/HfUBe+2ir8=;
	b=XIyEdig/KEOHtk1AD4na15CBWanjuuWeF3sTQFXQfK9U3cCIREGLGzr8BosTKOXxYNH7bf
	mdkFwue37BfhFLwfXq51iCOmVhJhFlwxmmOCH45QwS5eODHQXlKGsJOQuee72FsuIT0nsI
	LTnO0KiJwFHm236Csfe4l8uzAZCcs34=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] sched_ext: Exit dispatch and move operations
 immediately when aborting
Message-ID: <aRGgP4UQwgOdhgwj@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-7-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-7-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Tejun,

On Sun, Nov 09, 2025 at 08:31:05AM -1000, Tejun Heo wrote:
> 62dcbab8b0ef ("sched_ext: Avoid live-locking bypass mode switching") introduced
> the breather mechanism to inject delays during bypass mode switching. It
> maintains operation semantics unchanged while reducing lock contention to avoid
> live-locks on large NUMA systems.
> 
> However, the breather only activates when exiting the scheduler, so there's no
> need to maintain operation semantics. Simplify by exiting dispatch and move
> operations immediately when scx_aborting is set. In consume_dispatch_q(), break
> out of the task iteration loop. In scx_dsq_move(), return early before
> acquiring locks.
> 
> This also fixes cases the breather mechanism cannot handle. When a large system
> has many runnable threads affinitized to different CPU subsets and the BPF
> scheduler places them all into a single DSQ, many CPUs can scan the DSQ
> concurrently for tasks they can run. This can cause DSQ and RQ locks to be held
> for extended periods, leading to various failure modes. The breather cannot
> solve this because once in the consume loop, there's no exit. The new mechanism
> fixes this by exiting the loop immediately.
> 
> The bypass DSQ is exempted to ensure the bypass mechanism itself can make
> progress.
> 
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 62 ++++++++++++++--------------------------------
>  1 file changed, 18 insertions(+), 44 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 905d01f74687..afa89ca3659e 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1821,48 +1821,11 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
>  	return dst_rq;
>  }
>  
> -/*
> - * A poorly behaving BPF scheduler can live-lock the system by e.g. incessantly
> - * banging on the same DSQ on a large NUMA system to the point where switching
> - * to the bypass mode can take a long time. Inject artificial delays while the
> - * bypass mode is switching to guarantee timely completion.
> - */
> -static void scx_breather(struct rq *rq)
> -{
> -	u64 until;
> -
> -	lockdep_assert_rq_held(rq);
> -
> -	if (likely(!READ_ONCE(scx_aborting)))
> -		return;
> -
> -	raw_spin_rq_unlock(rq);
> -
> -	until = ktime_get_ns() + NSEC_PER_MSEC;
> -
> -	do {
> -		int cnt = 1024;
> -		while (READ_ONCE(scx_aborting) && --cnt)
> -			cpu_relax();
> -	} while (READ_ONCE(scx_aborting) &&
> -		 time_before64(ktime_get_ns(), until));
> -
> -	raw_spin_rq_lock(rq);
> -}
> -
>  static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
>  			       struct scx_dispatch_q *dsq)
>  {
>  	struct task_struct *p;
>  retry:
> -	/*
> -	 * This retry loop can repeatedly race against scx_bypass() dequeueing
> -	 * tasks from @dsq trying to put the system into the bypass mode. On
> -	 * some multi-socket machines (e.g. 2x Intel 8480c), this can live-lock
> -	 * the machine into soft lockups. Give a breather.
> -	 */
> -	scx_breather(rq);
> -
>  	/*
>  	 * The caller can't expect to successfully consume a task if the task's
>  	 * addition to @dsq isn't guaranteed to be visible somehow. Test
> @@ -1876,6 +1839,17 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
>  	nldsq_for_each_task(p, dsq) {
>  		struct rq *task_rq = task_rq(p);
>  
> +		/*
> +		 * This loop can lead to multiple lockup scenarios, e.g. the BPF
> +		 * scheduler can put an enormous number of affinitized tasks into
> +		 * a contended DSQ, or the outer retry loop can repeatedly race
> +		 * against scx_bypass() dequeueing tasks from @dsq trying to put
> +		 * the system into the bypass mode. This can easily live-lock the
> +		 * machine. If aborting, exit from all non-bypass DSQs.
> +		 */
> +		if (unlikely(READ_ONCE(scx_aborting)) && dsq->id != SCX_DSQ_BYPASS)
> +			break;
> +
>  		if (rq == task_rq) {
>  			task_unlink_from_dsq(p, dsq);
>  			move_local_task_to_local_dsq(p, 0, dsq, rq);
> @@ -5635,6 +5609,13 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
>  		return false;
>  
> +	/*
> +	 * If the BPF scheduler keeps calling this function repeatedly, it can
> +	 * cause similar live-lock conditions as consume_dispatch_q().
> +	 */
> +	if (unlikely(scx_aborting))

READ_ONCE(scx_aborting)?

Thanks,
-Andrea

> +		return false;
> +
>  	/*
>  	 * Can be called from either ops.dispatch() locking this_rq() or any
>  	 * context where no rq lock is held. If latter, lock @p's task_rq which
> @@ -5655,13 +5636,6 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  		raw_spin_rq_lock(src_rq);
>  	}
>  
> -	/*
> -	 * If the BPF scheduler keeps calling this function repeatedly, it can
> -	 * cause similar live-lock conditions as consume_dispatch_q(). Insert a
> -	 * breather if necessary.
> -	 */
> -	scx_breather(src_rq);
> -
>  	locked_rq = src_rq;
>  	raw_spin_lock(&src_dsq->lock);
>  
> -- 
> 2.51.1
> 
