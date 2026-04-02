Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63D3876C0;
	Thu,  2 Apr 2026 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775160622; cv=none; b=udna+ll4X95AAuzjdB0zoeNM+f+uy75ZJp8lvi+wNLQFuzhtcVDaZE7huEpvxpmXZErQSy6+Im6DpFNzJF+NyMxgh/ugj5CqPqbTCDBLhJDoyj10Ok0rLQ+Gq4SZR79Hi5MFialIKQbvd1cIxTgxHCWnvD0ulk9/K4047GWnSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775160622; c=relaxed/simple;
	bh=zQDENnjec6ysDhDoURJTTpTFosFMLCXCK7oSTmuuzOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8QWsxxvGbMXL86lRBpxsSmvovcmLQQCnZlNfVNZMOS92d0Vctw6+6oE8+Uv/kBHpA1vU6EHU+eEfYfYd//m+5n+WtT+CgEvja2uMqAhe/LYf9eerqv6wvTyGa/gzEgqyxJ7OGsLMOy8VZuJmBS4PnuPDUjiEFeaNHzwI+TIN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqvf+Ekn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqvf+Ekn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009B9C19424;
	Thu,  2 Apr 2026 20:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775160622;
	bh=zQDENnjec6ysDhDoURJTTpTFosFMLCXCK7oSTmuuzOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqvf+EkncHFdVMJ8P67S7H14NL9dQkN0RiO/C6szruFia7+aM52OgwTr0MN+P44wa
	 Aj9Ptuf4dcpouOJH7J7Ps71DP0MiY/xLy9lFIYjHqowWEDblvnJu/wJGeqCPIW28/0
	 b9EHw7N7R/Ipq+/onqh81BweOvW4KddtPb9Xh6T09jOWdz70KKbrzmDDDu3WfDUSzv
	 cOZ8XlT0zhHX3CTLE4oUQs+zx23dHj2xAxPZjrXkziKQcgjlvvmjDY10k7yXzEmrCH
	 bgAXAjg5BMBS+JkkM4zWkZUqLBmQ+sjvkj5+5a6DmxAeNxjjb92whD0ZDg9+FsUHaj
	 MJRr1YaScqfRg==
Date: Thu, 2 Apr 2026 10:10:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Patrick Somaru <patsomaru@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Fix stale direct dispatch state in
 ddsp_dsq_id
Message-ID: <ac7NLDdANzT-t6FH@slm.duckdns.org>
References: <20260402085743.1410070-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402085743.1410070-1-arighi@nvidia.com>

Hello, Andrea.

On Thu, Apr 02, 2026 at 10:57:43AM +0200, Andrea Righi wrote:
> @p->scx.ddsp_dsq_id can be left set (non-SCX_DSQ_INVALID) triggering a
> spurious warning in mark_direct_dispatch() when the next wakeup's
> ops.select_cpu() calls scx_bpf_dsq_insert(), such as:
> 
>  WARNING: kernel/sched/ext.c:1273 at scx_dsq_insert_commit+0xcd/0x140
> 
> The root cause is that ddsp_dsq_id was only cleared in dispatch_enqueue(),
> which is not reached in all paths that consume or cancel a direct dispatch
> verdict. Instead, clear it at the right places:
> 
>  - direct_dispatch(): cache the direct dispatch state in local variables
>    and clear it before dispatch_enqueue() on the synchronous path. For
>    the deferred path, the direct dispatch state must remain set until
>    process_ddsp_deferred_locals() consumes them.
> 
>  - process_ddsp_deferred_locals(): cache the dispatch state in local
>    variables and clear it before calling dispatch_to_local_dsq(), which
>    may migrate the task to another rq.
> 
>  - do_enqueue_task(): clear the dispatch state on the enqueue path
>    (local/global/bypass fallbacks), where the direct dispatch verdict is
>    ignored.
> 
>  - dequeue_task_scx(): clear the dispatch state after dispatch_dequeue()
>    to handle both the deferred dispatch cancellation and the holding_cpu
>    race, covering all cases where a pending direct dispatch is
>    cancelled.
> 
>  - scx_disable_task(): clear the direct dispatch state when
>    transitioning a task out of the current scheduler. Waking tasks may
>    have had the direct dispatch state set by the outgoing scheduler's
>    ops.select_cpu() and then been queued on a wake_list via
>    ttwu_queue_wakelist(), when SCX_OPS_ALLOW_QUEUED_WAKEUP is set. Such
>    tasks are not on the runqueue and are not iterated by scx_bypass(),
>    so their direct dispatch state won't be cleared. Without this clear,
>    when the new scheduler calls scx_enable_task() for these tasks, any
>    subsequent ops.select_cpu() call that tries to direct dispatch the
>    task will trigger the WARN_ON_ONCE() in mark_direct_dispatch().

Can you add an abbreviated version of the above as functio comment on
clear_direct_dispatch()?

>  static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
>  			    u64 enq_flags)
>  {
...
> @@ -1303,6 +1301,12 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
>  	if (dsq->id == SCX_DSQ_LOCAL && dsq != &rq->scx.local_dsq) {
>  		unsigned long opss;
>  
> +		/*
> +		 * Update the direct dispatch state and keep it until
> +		 * process_ddsp_deferred_locals() consumes it.
> +		 */
> +		p->scx.ddsp_enq_flags = ddsp_enq_flags;

I know I suggested it but this looks kinda odd. How about we keep the
original p->scx.ddsp_enq_flags |= enq_flags above and then do

...

Cache enq_flags here?

> +	clear_direct_dispatch(p);
> +	dispatch_enqueue(sch, dsq, p, ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
>  }
>  
>  static bool scx_rq_online(struct rq *rq)
...
> @@ -3147,6 +3155,8 @@ static bool task_dead_and_done(struct task_struct *p)
>  
>  	lockdep_assert_rq_held(rq);
>  
> +	clear_direct_dispatch(p);

This is task_dead_and_done(), not scx_disable_task(). Is this intended?

Thanks.

-- 
tejun
