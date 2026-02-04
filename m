Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA702773DA
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211254; cv=none; b=q/xz4XmXeiV2ZCywoi0iEWaJ8vGx34/IbezR7iyQ2WW4xi42lK9uHXsgsETA8hEJOXO4pIQzFeZKg6jTrzbGBqWvyc9x/+yvcsQx9fYQ0btdr1/MXyN9t8QoKddBSeIR5X72V5NNGCYLzyi3b2Vv8GMWi9bW8trLFFAY0dC06Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211254; c=relaxed/simple;
	bh=E+tRdIza0uH7+GcbMKAdHVJfzr8XQp3vQ1IsQsFZfxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E4kJ+p2FA3VAo+p2LwRVXYihG3V6nY8tHyqyAdnUH/vc8w1V9RgqDJA10dTiyh5MzC0SoJ0yRA8HO3V5/HLyR/+bSxClYuGy25eC+wnvbaOs1hRr4TCsInyqckmzmCDupAgEi5ncIjLBUGVMeOff1ytHSMG0sUea8seahLSBoOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSbDf0bs; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSbDf0bs"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso6341425e9.2
        for <sched-ext@lists.linux.dev>; Wed, 04 Feb 2026 05:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770211253; x=1770816053; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymv65Xyno+7NjCaHi9XmRO2wu7ALnGGTcPzb/GjzNQc=;
        b=pSbDf0bsuQy8fneWJmDWV/ymVbc3LwHfxw0PqsPZIp+BDlLClw5QJCHukL2zjfGrUs
         eGwqktuvmBU+GN4gATFCQYKm2jSjFWTdQ/QP2Cutb3AmsFkAFP4j4kH7IhOhTBjVCS/i
         BH5HNEHzKjJNp6tyWV9uLBYNbFytnLg/a8fnPetISjushJKz/BFcru+u4D8iD4u1Y92c
         vWt1YQ9Hw+NiSD6AVqLxVXOuT/PuBSiTGj3RGFwI3gDwM6O4jgwViz6VoDysw5fqAVQ8
         peG+wxA2pxG5u0ZlCHzRCeekbDYhCYTJjFEa9nLKqCmWACdDqM25JXBmCNQIeha9I33X
         SFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770211253; x=1770816053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymv65Xyno+7NjCaHi9XmRO2wu7ALnGGTcPzb/GjzNQc=;
        b=Wh9+sLlnz7UhUDnxnf7SK4zJWVGDHkT5kS8sipSV1xZd2Zeyhe18azgPPsH6SFwHIo
         dYc0f7+X8zpNNQ1R4N0laTyqVMmAj6pDyp00sw9KMrAEBpe+5fe9ynBBCdZNq+bKZxwj
         LOgXOewbppVG2Q03dtMzGQBGQwjDOLAwprSsfcvprXWx8OO3JzpTGmpWDcx07fFbffZh
         Stz0q42vlbauKSdZE1Vjpt+j6ab2J8vtx/InsYbimG3RIb9cXNYS4Rz7Qv/6fvhRNgmT
         vfQjuF+rLbJW6ZoFmKcz8O6ZRx5wZWCCxutttCSj+D/zT24Yt+pkydTZIIns+epNJMle
         Y9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUkxT9DXdweeYIBF2RpaSeqQaOPCrGyeQ1LME3HFW16eOYi8dtvWUu+nZmzBQPDiOrIJIj0DqQ2Clk=@lists.linux.dev
X-Gm-Message-State: AOJu0YygqVQckCO7RAx5SHAOIdpOcS4z1yjAXiBV5uvP8AAyg9d2EK3z
	7vikI55Tb6SajoP6glpAm/cklCFJwYKakt5AJDXre59p8EYIlcujXwx5ILdFYtqY6wSVVHVoVgj
	xOEH2CobtkRE+Mg==
X-Received: from wmbd6.prod.google.com ([2002:a05:600c:58c6:b0:480:6afd:1fd0])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:844f:10b0:480:7162:fa48 with SMTP id 5b1f17b1804b1-4830e9492aamr29370825e9.13.1770211253116;
 Wed, 04 Feb 2026 05:20:53 -0800 (PST)
Date: Wed, 04 Feb 2026 13:20:52 +0000
In-Reply-To: <20260203230639.1259869-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203230639.1259869-1-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG67IMOVU2GX.2CKP769EXJS12@google.com>
Subject: Re: [PATCH] sched_ext: Invalidate dispatch decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Tue Feb 3, 2026 at 11:06 PM UTC, Andrea Righi wrote:
> A BPF scheduler may rely on p->cpus_ptr from ops.dispatch() to select a
> target CPU. However, task affinity can change between the dispatch
> decision and its finalization in finish_dispatch(). When this happens,
> the scheduler may attempt to dispatch a task to a CPU that is no longer
> allowed, resulting in fatal errors such as:
>
>  EXIT: runtime error (SCX_DSQ_LOCAL[_ON] target CPU 10 not allowed for stress-ng-race-[13565])
>
> This race exists because ops.dispatch() runs without holding the task's
> run queue lock, allowing a concurrent set_cpus_allowed() to update
> p->cpus_ptr while the BPF scheduler is still using it. The dispatch is
> then finalized using stale affinity information.
>
> Example timeline:
>
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

I'm not convinced this will prevent the exact race scenario you describe.
For the qseq increment inside set_cpus_allowed_scx() to be noticed, it needs
to happen _after_ scx_bpf_dsq_insert() reads the qseq and stores it in the
dispatch buffer entry.

We can still have the cpumask change and qseq increment on CPU1 happen between
cpumask_test_cpu() and scx_bpf_dsq_insert() on CPU0, and it will not be
detected because the dispatch buffer entry will contain the incremented value.

>
> When finish_dispatch() detects a qseq mismatch, the dispatch is dropped
> and the task is returned to the SCX_OPSS_QUEUED state, allowing it to be
> re-dispatched using up-to-date affinity information.

How will the scheduler know that the dispatch was dropped? Is the scheduler
expected to infer it from the ops.enqueue() that follows set_cpus_allowed_scx()
on CPU1?

>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 58 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 0ab994180f655..6128a2529a7c7 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1828,8 +1828,9 @@ static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
>   * will change. As @p's task_rq is locked, this function doesn't need to use the
>   * holding_cpu mechanism.
>   *
> - * On return, @src_dsq is unlocked and only @p's new task_rq, which is the
> - * return value, is locked.
> + * On success, @src_dsq is unlocked and only @p's new task_rq, which is the
> + * return value, is locked. On failure (affinity change invalidated the move),
> + * returns NULL with @src_dsq unlocked and task remaining in @src_dsq.
>   */
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
>  		}
>  	} else {
>  		/* no need to migrate if destination is a non-local DSQ */
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
>  		return;
>  	}
>  
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

Will we ever enter this if statement? IIUC set_cpus_allowed_scx() is always
called under `scoped_guard (sched_change, p, DEQUEUE_SAVE)`, so assuming the
task is on a runqueue, set_cpus_allowed_scx() will always be preceded by
dequeue_task_scx(), which clears SCX_TASK_QUEUED.

> +
>  	/*
>  	 * The effective cpumask is stored in @p->cpus_ptr which may temporarily
>  	 * differ from the configured one in @p->cpus_mask. Always tell the bpf
> @@ -6013,14 +6042,21 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  
>  	/* execute move */
>  	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
> -	dispatched = true;
> +	if (locked_rq) {
> +		dispatched = true;
> +	} else {
> +		/* Move failed: task stays in src_dsq */
> +		raw_spin_unlock(&src_dsq->lock);
> +		locked_rq = in_balance ? this_rq : NULL;
> +	}
>  out:
>  	if (in_balance) {
>  		if (this_rq != locked_rq) {
> -			raw_spin_rq_unlock(locked_rq);
> +			if (locked_rq)
> +				raw_spin_rq_unlock(locked_rq);
>  			raw_spin_rq_lock(this_rq);
>  		}
> -	} else {
> +	} else if (locked_rq) {
>  		raw_spin_rq_unlock_irqrestore(locked_rq, flags);
>  	}
>  

Thanks,
Kuba

