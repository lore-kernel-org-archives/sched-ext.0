Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC932853F1
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760578; cv=none; b=VS2KVAJAF7e7aJf7eKq+HTTREbAk0oAEJThmNuK2l0WRexev6GNn1y+HLyMKXGDq4o8m4UUBy8UuM7PZPajy1nhejjPMqe569F/QdCL6IX9oC6snf5LL+ivhlqfGH5TB4LrzbHJt7Ab+44+dQiuA+twieY8BXeD7d+c8GUrVttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760578; c=relaxed/simple;
	bh=ruqLsJjdIQxz7AVjcrQBfTCzdPG3yyrUqqSRjr9Ve8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIKLgYPNL3MztfGMv2jtHuQe+XnWUc7SbOg9bYsDeyd2S/ktEGbybthsVPOOsbIrm0Qm+lSS6CzwwgJweO2Yf3uH+q+UBKkDZBNCw6EPoY4um5LRSSb5HgCCLWKnz8ZJ7386N00VDuvPGdaONHT8IoF2B31T8+3p+cWAlLEA6BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ei6nvdkA; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ei6nvdkA"
Date: Mon, 10 Nov 2025 08:42:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762760572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CxdwBD01h+H+/g2ckIpFnqJSery2fQVOPvtSHzTtpvI=;
	b=ei6nvdkAQ79s//QsIokWni9i96YAyXK8JgQIWBftWA2hg6pvuUqvgiyFd1qO+zLjgU+WU3
	QqH3wYidbX/Yw4NtWri4f9X56HYwnKm9Hn5C0r0iR8YYt6qc6/BL1PcJcJbv1HKHPff3/M
	k1iDpubycgsttmOHNv30TdCfctCdAMY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] sched_ext: Use per-CPU DSQs instead of per-node
 global DSQs in bypass mode
Message-ID: <aRGXd0QwgqBVu7Gq@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-5-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Tejun,

On Sun, Nov 09, 2025 at 08:31:03AM -1000, Tejun Heo wrote:
> When bypass mode is activated, tasks are routed through a fallback dispatch
> queue instead of the BPF scheduler. Originally, bypass mode used a single
> global DSQ, but this didn't scale well on NUMA machines and could lead to
> livelocks. In b7b3b2dbae73 ("sched_ext: Split the global DSQ per NUMA node"),
> this was changed to use per-node global DSQs, which resolved the
> cross-node-related livelocks.
> 
> However, Dan Schatzberg found that per-node global DSQ can also livelock in a
> different scenario: On a NUMA node with many CPUs and many threads pinned to
> different small subsets of CPUs, each CPU often has to scan through many tasks
> it cannot run to find the one task it can run. With a high number of CPUs,
> this scanning overhead can easily cause livelocks.
> 
> Change bypass mode to use dedicated per-CPU bypass DSQs. Each task is queued
> on the CPU that it's currently on. Because the default idle CPU selection
> policy and direct dispatch are both active during bypass, this works well in
> most cases including the above.

Is there any reason not to reuse rq->scx.local_dsq for this?

Thanks,
-Andrea

> 
> However, this does have a failure mode in highly over-saturated systems where
> tasks are concentrated on a single CPU. If the BPF scheduler places most tasks
> on one CPU and then triggers bypass mode, bypass mode will keep those tasks on
> that one CPU, which can lead to failures such as RCU stalls as the queue may be
> too long for that CPU to drain in a reasonable time. This will be addressed
> with a load balancer in a future patch. The bypass DSQ is kept separate from
> the local DSQ to allow the load balancer to move tasks between bypass DSQs.
> 
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/sched/ext.h |  1 +
>  kernel/sched/ext.c        | 16 +++++++++++++---
>  kernel/sched/sched.h      |  1 +
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 9f5b0f2be310..e1502faf6241 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -57,6 +57,7 @@ enum scx_dsq_id_flags {
>  	SCX_DSQ_INVALID		= SCX_DSQ_FLAG_BUILTIN | 0,
>  	SCX_DSQ_GLOBAL		= SCX_DSQ_FLAG_BUILTIN | 1,
>  	SCX_DSQ_LOCAL		= SCX_DSQ_FLAG_BUILTIN | 2,
> +	SCX_DSQ_BYPASS		= SCX_DSQ_FLAG_BUILTIN | 3,
>  	SCX_DSQ_LOCAL_ON	= SCX_DSQ_FLAG_BUILTIN | SCX_DSQ_FLAG_LOCAL_ON,
>  	SCX_DSQ_LOCAL_CPU_MASK	= 0xffffffffLLU,
>  };
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index a29bfadde89d..4b8b91494947 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1301,7 +1301,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  
>  	if (scx_rq_bypassing(rq)) {
>  		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
> -		goto global;
> +		goto bypass;
>  	}
>  
>  	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
> @@ -1359,6 +1359,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  global:
>  	dsq = find_global_dsq(sch, p);
>  	goto enqueue;
> +bypass:
> +	dsq = &task_rq(p)->scx.bypass_dsq;
> +	goto enqueue;
>  
>  enqueue:
>  	/*
> @@ -2157,8 +2160,14 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
>  	if (consume_global_dsq(sch, rq))
>  		goto has_tasks;
>  
> -	if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
> -	    scx_rq_bypassing(rq) || !scx_rq_online(rq))
> +	if (scx_rq_bypassing(rq)) {
> +		if (consume_dispatch_q(sch, rq, &rq->scx.bypass_dsq))
> +			goto has_tasks;
> +		else
> +			goto no_tasks;
> +	}
> +
> +	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
>  		goto no_tasks;
>  
>  	dspc->rq = rq;
> @@ -5370,6 +5379,7 @@ void __init init_sched_ext_class(void)
>  		int  n = cpu_to_node(cpu);
>  
>  		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
> +		init_dsq(&rq->scx.bypass_dsq, SCX_DSQ_BYPASS);
>  		INIT_LIST_HEAD(&rq->scx.runnable_list);
>  		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 27aae2a298f8..5991133a4849 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -808,6 +808,7 @@ struct scx_rq {
>  	struct balance_callback	deferred_bal_cb;
>  	struct irq_work		deferred_irq_work;
>  	struct irq_work		kick_cpus_irq_work;
> +	struct scx_dispatch_q	bypass_dsq;
>  };
>  #endif /* CONFIG_SCHED_CLASS_EXT */
>  
> -- 
> 2.51.1
> 
