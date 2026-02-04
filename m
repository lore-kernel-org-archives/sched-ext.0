Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDEE36E497;
	Wed,  4 Feb 2026 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770247897; cv=none; b=eQecxtfzkMX3jju3CgzCuq5K0/Vmh+V1Thkpmx9TW1yMDs650pRfn29a3rwTIqOTLINjCBYIPFVawXjtDl83lJ4Tlue3As2MABORIVIC30f2TS4N7pGLAFR3Z+4xGtzh5Uf/RWTjk36yTnZmBxDOKkjh+n3FydAgqqypdPZW7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770247897; c=relaxed/simple;
	bh=igKO5SuozCnR0wEEjodh+nj8+4GXDWCqi7Dfo1dQYGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfoQ2dGFPvCtRUGLRY6jISclF23sdq+AJ/NQkxDYKgYR31n+G0rq6RQqgCUIiF19JkXQeytGvEV092GnSispb4RcTEAf8Opw6Ay9ppGNuvQ1Q2iIQzCkE/J8uAF253eEG06682+5KRz0qS7uesYAUgzPbhl8ix3C3JEELFShPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElUsx5eb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElUsx5eb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8B9C16AAE;
	Wed,  4 Feb 2026 23:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770247896;
	bh=igKO5SuozCnR0wEEjodh+nj8+4GXDWCqi7Dfo1dQYGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElUsx5ebVSqg3dm85Vs/1wG9+++9pG3EQZrN3AjVJkFw913/bnDCVL2OZJGmVWVkM
	 LKtR+v/13ioRqgAoyRakoROVZl7sG5JAF+hCU0eTNq9sAJHLAusxWxqTFSY+/DC8Au
	 jI/3meyD8eSnVrRoDcOW81i2qoJ0fQlG48yyQii0HSh0updf+6FZo9VNuYlliqwbaS
	 /tQQp0tEvKUr96pbWeU6iQ+JX2Tj9Z8yUk18EeHOG6CuSG5bpEH+3VI0CodGx+oxmw
	 biZy/HXCewbsdLPKeasiz2KDRmbRLbV2E0GjRY2RVICTHxEgtwB9ytfnrCgyUpgzMB
	 UisnutFuq17CA==
Date: Wed, 4 Feb 2026 13:31:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity
 changes
Message-ID: <aYPW121Y6vGtmtST@slm.duckdns.org>
References: <20260203230639.1259869-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203230639.1259869-1-arighi@nvidia.com>

Hello,

On Wed, Feb 04, 2026 at 12:06:39AM +0100, Andrea Righi wrote:
...
>   CPU0                                      CPU1
>   ----                                      ----
>                                             task_rq_lock(p)
>   if (cpumask_test_cpu(cpu, p->cpus_ptr))
>                                             set_cpus_allowed_scx(p, new_mask)
>                                             task_rq_unlock(p)
>       scx_bpf_dsq_insert(p,
>               SCX_DSQ_LOCAL_ON | cpu, 0)
> 
> Fix this by extending the existing qseq invalidation mechanism to also
> cover CPU affinity changes, in addition to task dequeues/re-enqueues,
> occurring between dispatch decision and finalization.
> 
> When finish_dispatch() detects a qseq mismatch, the dispatch is dropped
> and the task is returned to the SCX_OPSS_QUEUED state, allowing it to be
> re-dispatched using up-to-date affinity information.

It shouldn't be returned, right? set_cpus_allowed() dequeues and
re-enqueues. What the seq invalidation detected is dequeue racing the async
dispatch and the invalidation means that the task was dequeued while on the
async buffer (to be re-enqueued once the property change is complete). It
should just be ignored.

>  static struct rq *move_task_between_dsqs(struct scx_sched *sch,
>  					 struct task_struct *p, u64 enq_flags,
> @@ -1845,9 +1846,13 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
>  	if (dst_dsq->id == SCX_DSQ_LOCAL) {
>  		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
>  		if (src_rq != dst_rq &&
> -		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> -			dst_dsq = find_global_dsq(sch, p);
> -			dst_rq = src_rq;
> +		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
> +			/*
> +			 * Task affinity changed after dispatch decision:
> +			 * drop the dispatch, caller will handle returning
> +			 * the task to its original DSQ.
> +			 */
> +			return NULL;
...
> @@ -1974,9 +1979,15 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  	}
>  
>  	if (src_rq != dst_rq &&
> -	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> -		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
> -				 enq_flags | SCX_ENQ_CLEAR_OPSS);
> +	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
> +		/*
> +		 * Task affinity changed after dispatch decision: drop the
> +		 * dispatch, task remains in its current state and will be
> +		 * dispatched again in a future cycle.
> +		 */
> +		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED |
> +					(atomic_long_read(&p->scx.ops_state) &
> +					 SCX_OPSS_QSEQ_MASK));

I don't quite follow why we need the above slippery behavior. The qseq
invalidation, if reliable, means that there's no race window if the BPF
scheduler correctly implements ops.dequeue() (after the kernel side fixes it
of course).

ie. The BPF scheduler is reponsible for synchronizing its
scx_bpf_dsq_insert() call against whatever it needs to do in ops.dequeue().
If ops.dequeue() wins, the task shouldn't be inserted in the first place. If
ops.dequeue() loses, the qseq invalidation should kill it while on async
buffer if it wins over finish_dispatch(). If finish_dispatch() wins, the
task will just be dequeued from the inserted DSQ or the property change will
happen while the task is running.

Now, maybe we want to allow BPF schedulre to be lax about ops.dequeue()
synchronization and let things slide (probably optionally w/ an OPS flag),
but for that, falling back to global DSQ is fine, no?

> @@ -2616,12 +2627,30 @@ static void set_cpus_allowed_scx(struct task_struct *p,
>  				 struct affinity_context *ac)
>  {
>  	struct scx_sched *sch = scx_root;
> +	struct rq *rq = task_rq(p);
> +
> +	lockdep_assert_rq_held(rq);
>  
>  	set_cpus_allowed_common(p, ac);
>  
>  	if (unlikely(!sch))
>  		return;
>  
> +	/*
> +	 * Affinity changes invalidate any pending dispatch decisions made
> +	 * with the old affinity. Increment the runqueue's ops_qseq and
> +	 * update the task's qseq to invalidate in-flight dispatches.
> +	 */
> +	if (p->scx.flags & SCX_TASK_QUEUED) {
> +		unsigned long opss;
> +
> +		rq->scx.ops_qseq++;
> +		opss = atomic_long_read(&p->scx.ops_state);
> +		atomic_long_set(&p->scx.ops_state,
> +				(opss & SCX_OPSS_STATE_MASK) |
> +				(rq->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT));
> +	}
> +

I wonder whether we should define an invalid qseq and use that instead. The
queueing instance really is invalid after this and it would help catching
cases where BPF scheduler makes mistakes w/ synchronization. Also, wouldn't
dequeue_task_scx() or ops_dequeue() be a better place to shoot down the
enqueued instances? While the symptom we most immediately see are through
cpumask changes, the underlying problem is dequeue not shooting down
existing enqueued tasks.

Thanks.

-- 
tejun
