Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589C3672A0;
	Thu,  3 Sep 2026 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788475162; cv=none; b=Rg2uJW1uEFpAG9boM7WzQsiNHL7icJvYKi1qYTGffvIv9FAB81r4YiIP1+E3YywPwUYh28cdz4aW46iFCM8Y1GDKEW8a3fA2eXowyemu0K51dfTHO19zZ7nbqIy3+KEzjEmMcN3rWXhnTAjk62wil7cm60EyjqhJv7vx8TlXTj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788475162; c=relaxed/simple;
	bh=gbxOt26bQoeAwt5cGsuB/OnGgpoiR0U3lXzQXWTFMsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTa+XssjyHAs3/yFf1A8wcI0b806k3mwaGkNGRbKl8tyOagCWkaPmgHue7vzfi/6EpfzKYageztc0R+nCxi9jDixF3QDDkArTa+UrDEzLDS8ojN6ok14JjLBV/qadI/+AwICRonQJfx0EfLTSOjRgWrrmj8h075804N1N+MQK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqtSJ0SL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqtSJ0SL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E591F00A3E;
	Thu,  3 Sep 2026 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788475161;
	bh=FE7CoZIim/AFNristn24Z3J5voTLVFaS6R+eRkc4Q84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oqtSJ0SLqwvGnWqla3hph4AhrUDQWj6AZkdpGJan3zK/p6bICbp6flNa9u47isRl9
	 Uzcs4Ni42FI5myOEvVJwdMWMgvZ4ekOsjm0iaZ9Ft+Jd52i2cow+okXagyLAxSvQe8
	 QmmEAvEvtSMwWASd13hIvxPD+AFh83E16c9sbFvtR4dvmRk54hj3a4hlwhiIbqnjfk
	 kAO1HWe8FZVl5Pj+zwkDJuQkUL1o11JJAfqjdCljuoMPSbG46Vn8RGP3LSOR+L1rL+
	 kaskdIL8NeBW2x7yPrr23HqKBPsRYqmZ0SfD+h+AxGjSVgb0efUJiI3M8WrS5uWx4x
	 q9GxH8S3bT83A==
Date: Thu, 3 Sep 2026 12:39:20 -1000
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
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/18] sched_ext: Generalize the reject DSQ reenqueue path
Message-ID: <apn3GHPzhPZtGbSs@slm.duckdns.org>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-13-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-13-arighi@nvidia.com>

Hello,

Nits follow.

On Mon, Aug 31, 2026 at 03:42:22PM +0200, Andrea Righi wrote:
> @@ -1599,11 +1599,10 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
>  				 struct scx_dispatch_q *dsq, struct task_struct *p,
>  				 u64 slice, u64 vtime, u64 enq_flags)
>  {
> -	bool is_rq_owned = false;
> +	bool is_rq_owned = dsq_is_rq_owned(dsq);
>  
>  	if (dsq->id == SCX_DSQ_LOCAL) {
>  		dsq = scx_resolve_local_dsq(sch, rq, p, &enq_flags);
> -		is_rq_owned = true;
>  	}

No need for {}.

> @@ -2017,6 +2016,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  			__scx_exit(sch, SCX_EXIT_ERROR_REENQ, 0, cpu_of(rq),
>  				   "%s[%d] reenqueued %u times without running",
>  				   p->comm, p->pid, p->scx.reenq_cnt);
> +			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
>  			return;
>  		}
>  	}
> @@ -2067,6 +2067,8 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  
>  	SCX_CALL_OP_TASK(sch, enqueue, rq, p, enq_flags);
>  
> +	/* The reason is input to ops.enqueue(), not to the resulting placement. */
> +	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
>  	*ddsp_taskp = NULL;
>  	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
>  		goto direct;
> @@ -2085,9 +2087,11 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	return;
>  
>  direct:
> +	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
>  	direct_dispatch(sch, p, enq_flags);
>  	return;
>  local_norefill:
> +	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
>  	scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0, 0, enq_flags);
>  	return;
>  local:
> @@ -2101,6 +2105,7 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	goto enqueue;
>  
>  enqueue:
> +	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
>  	refill_task_slice_dfl(sch, p);
>  	clear_direct_dispatch(p);
>  	scx_dispatch_enqueue(sch, rq, dsq, p, 0, 0, enq_flags);

This is too messy. The clearing is scattered all over and sometimes done
twice. Can't you add one label that everyone jumps to for exit and clear it
there?

Thanks.

-- 
tejun
