Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812033993;
	Tue, 17 Feb 2026 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771309846; cv=none; b=fvcWOPgCLni2vIDrt83zNld2cD0x4KzCF2lTtuNKU9UDsIM9GZTPYuR8XJ9H7hSYR+2hsQNJTNr4GJmUBy81GKH188eKEYcWVXY1DzV6+QxXiiuPFVWY3w0Ft3yo9+jRURRftd2hcGdYuP4+5cSlWpKwlxSDVMEWT6wARHez+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771309846; c=relaxed/simple;
	bh=kyeVFZIz5f7VK8HNNpYoMeVbmyuvF0fYOKmqVsHkq1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFD1dbYorIvTpBgtNGiGZF9XVk+iDwVxyHcFDRc4x8l1r9DSWdJHGpv5ccNVmxPDcx5ZlKmrzfiBhKcEESouM+7bpZ7DsIUVzfxe+0pDRXnYevS2T/j7WS3tMx5JffQNPXAo3qz8+nttip85qMCGgfCeQm0iZ/BElBHvBV8+Fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjVnhv8o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjVnhv8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC1EC4CEF7;
	Tue, 17 Feb 2026 06:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771309845;
	bh=kyeVFZIz5f7VK8HNNpYoMeVbmyuvF0fYOKmqVsHkq1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjVnhv8o3GYD0e7XqVOxPsP9d/IIWDlYikHeZqWPq3nstB7ZaYL+nJZFHktkCctUh
	 Npgp/R4OVkLs2xlhKHcDABnmhzznRDrrLQ5/WCZ/AYxJANGeAe47K2RzXNBiz/aSFr
	 aCzOpRnkjCSOwAYYNLe+8uVpgS/cidK6Q19XvA63HRxCZ+HPUTAftLIR9vcU5emTW4
	 CdP+SZooXY0ghzPdWxVG7W9JuutKAdYeL9LeZoztiQh9ML/kiIt5iTmPs+ww2bVlCj
	 WYF5hsRdXKNpGWxRpK3hQuW+Ys0+cITeEysjiS4x6JWHwvJPHuLCDuG34GLeTEvvqh
	 nAGZk6sKQUfyw==
Date: Mon, 16 Feb 2026 20:30:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aZQLFBEBkbF23-K8@slm.duckdns.org>
References: <20260215191933.2358161-1-arighi@nvidia.com>
 <20260215191933.2358161-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215191933.2358161-4-arighi@nvidia.com>

Hello,

On Sun, Feb 15, 2026 at 08:16:55PM +0100, Andrea Righi wrote:
> +/*
> + * Return true if @p is moving due to an internal SCX migration, false
> + * otherwise.
> + */
> +static inline bool task_scx_migrating(struct task_struct *p)
> +{
> +	return task_on_rq_migrating(p) && p->scx.sticky_cpu >= 0;
> +}

Can you explain why testing task_on_rq_migrating() is necessary? What does
just testing p->scx.sticky_cpu miss?

> @@ -1106,6 +1153,12 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
>  	dsq_mod_nr(dsq, 1);
>  	p->scx.dsq = dsq;
>  
> +	/*
> +	 * Non-terminal DSQs: task enters BPF scheduler's custody.
> +	 */
> +	if (!is_terminal_dsq(dsq))
> +		p->scx.flags |= SCX_TASK_IN_CUSTODY;

Can't this be done in the local_dsq_post_enq() else block?

>  	/*
>  	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
>  	 * direct dispatch path, but we clear them here because the direct
> @@ -1122,10 +1175,23 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
>  	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
>  		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
>  
> -	if (is_local)
> +	if (is_local) {
>  		local_dsq_post_enq(dsq, p, enq_flags);
> -	else
> +	} else {
> +		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS) {
> +			/*
> +			 * Task is on the global or bypass DSQ: call
> +			 * ops.dequeue() if the task was in BPF custody and
> +			 * it's not an internal SCX migration.
> +			 */
> +			if ((p->scx.flags & SCX_TASK_IN_CUSTODY) &&
> +			    !task_scx_migrating(p)) {
> +				call_task_dequeue(sch, rq, p, 0);
> +				p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> +			}
> +		}

If you add else {} here, that'd catch the non-terminal DSQs, right? If that
works, I think that'd be more logical organization.

> @@ -1531,6 +1611,25 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  
>  	switch (opss & SCX_OPSS_STATE_MASK) {
>  	case SCX_OPSS_NONE:
> +		/*
> +		 * If the task is still in BPF scheduler's custody
> +		 * (%SCX_TASK_IN_CUSTODY is set) call ops.dequeue().
> +		 *
> +		 * The code that clears ops_state to %SCX_OPSS_NONE does
> +		 * not always clear %SCX_TASK_IN_CUSTODY: in
> +		 * dispatch_to_local_dsq(), when we're moving a task that
> +		 * was in %SCX_OPSS_DISPATCHING to a remote CPU's local
> +		 * DSQ, we only set ops_state to %SCX_OPSS_NONE so that a
> +		 * concurrent dequeue can proceed, but we clear
> +		 * %SCX_TASK_IN_CUSTODY only when we later enqueue or move
> +		 * the task. So we can see NONE + IN_CUSTODY here and we
> +		 * must handle it.
> +		 */
> +		if ((p->scx.flags & SCX_TASK_IN_CUSTODY) &&
> +		    !task_scx_migrating(p)) {
> +			call_task_dequeue(sch, rq, p, op_deq_flags);
> +			p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> +		}

Except for OPSS_QUEUED path, all call_task_dequeue() callers are using the
same code block and OPSS_QUEUED can too. Can't we move the whole block into
call_task_dequeue()?

>  		break;
>  	case SCX_OPSS_QUEUEING:
>  		/*
> @@ -1539,9 +1638,18 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  		 */
>  		BUG();
>  	case SCX_OPSS_QUEUED:
> -		if (SCX_HAS_OP(sch, dequeue))
> -			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> -					 p, deq_flags);
> +		/*
> +		 * Task is in BPF scheduler's custody (not dispatched yet).
> +		 * Call ops.dequeue() unless this is an SCX-initiated
> +		 * migration.
> +		 *
> +		 * A queued task must be always in BPF scheduler's custody.
> +		 */
> +		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
> +		if (!task_scx_migrating(p)) {
> +			call_task_dequeue(sch, rq, p, op_deq_flags);
> +			p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> +		}

This placement is a bit odd as before the following try_cmpxchg, this path
doesn't have the ownership of the task. Please see below.

>  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>  					    SCX_OPSS_NONE))
> @@ -1563,6 +1671,16 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  		 */
>  		wait_ops_state(p, SCX_OPSS_DISPATCHING);
>  		BUG_ON(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> +
> +		 /*
> +		  * After DISPATCHING completes, task may still be
> +		  * IN_CUSTODY (see the NONE case).
> +		  */
> +		if ((p->scx.flags & SCX_TASK_IN_CUSTODY) &&
> +		    !task_scx_migrating(p)) {
> +			call_task_dequeue(sch, rq, p, op_deq_flags);
> +			p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> +		}
>  		break;
>  	}
>  }

If you move QUEUED case after successful try_cmpxchg(), it's always calling
dequeue before breaking out of the switch block. Might as well do it in a
single spot right after the switch block?

Thanks.

-- 
tejun
