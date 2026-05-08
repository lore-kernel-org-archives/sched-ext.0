Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E467262B
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255114; cv=none; b=n6yWZeb/TrhFpb3DH51Oi8/I9VVTszg8HRw1EkZ2p20TLd6o8XfVyiHwA4+MQrFfnC/GwjSzJ2qYj6UaDuJ5xxZbtcH/g5TQWaUZI++wcJu82BOeI3vRrgbSgCzQ4XzkrW6FAsI6r35xTe1xo8VojLhSjEsR//eXDjkeFkHL5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255114; c=relaxed/simple;
	bh=BCDppsayD1LF+e6alf9NM3ikedJHXqe7QXsUV1JiMtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7oLkhahpO0nQ3qQPQsS41yrRlUOwLeye52YX7Dq9vsIgtYeaasdyoR1hw/Q1sUX8Irt5wsYQyTdnsM6H58k4Y/09aUv/wx+BMABXfC/c4DF1n8V7lV2ItUYAJom/SXhdUi3ic3CLvZ6GOlN45CjA9T+h/UuiXKVNbdA+fR8H/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dUtBdkrJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dUtBdkrJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E405A1E7D;
	Fri,  8 May 2026 08:45:06 -0700 (PDT)
Received: from [10.57.89.57] (unknown [10.57.89.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE0F13F836;
	Fri,  8 May 2026 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778255112; bh=BCDppsayD1LF+e6alf9NM3ikedJHXqe7QXsUV1JiMtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dUtBdkrJky2acGdpZCokaLaHKlxSmM1pA27alYAcXroJNDLQmrNMP05BzLBTHRDx2
	 CP1XPMqXlxD1ja9yhw0qO1VT3nZPPIRecf3lRrPi4tVJ0afNtSKXvKjXr4L08YrDQy
	 JY9l4ozzioIj0EKKD44XTvSnPIfJnmVH4j+Rl0DA=
Message-ID: <993ad147-0cfe-4cc6-8a58-45845064db38@arm.com>
Date: Fri, 8 May 2026 16:45:08 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] sched_ext: Allow consuming local tasks when aborting
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, tj@kernel.org,
 void@manifault.com, changwoo@igalia.com
References: <20260507135642.692290-1-christian.loehle@arm.com>
 <af3vw6Sjh1dW8oEA@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <af3vw6Sjh1dW8oEA@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 15:14, Andrea Righi wrote:
> Hi Christian,
> 
> On Thu, May 07, 2026 at 02:56:42PM +0100, Christian Loehle wrote:
>> When aborting, consume_dispatch_q() breaks out of the task iteration
>> loop entirely for non-bypass DSQs. This prevents CPUs from consuming
>> even their own tasks (where rq == task_rq) from any DSQ.
>>
>> This causes a deadlock during CPU hotplug:
>>
>> 1. The BPF scheduler's cpu_offline callback calls scx_bpf_exit(),
>>    setting sch->aborting and queuing the disable_work on the helper
>>    kthread.
>>
>> 2. The helper kthread (and other tasks) are stuck on the global or
>>    user DSQs because bypass mode hasn't been entered yet.
>>
>> 3. No CPU can consume these tasks due to the aborting break, so the
>>    helper never runs scx_root_disable() -> scx_bypass().
>>
>> 4. The cpuhp thread is stuck in balance_hotplug_wait() because the
>>    dying CPU's rq never drains.
>>
>> Tasks on user DSQs are equally affected: BPF schedulers can dispatch
>> RCU and other critical kthreads to user DSQs, causing RCU stalls when
>> those tasks become unconsumable.
>>
>> The aborting check was added to prevent live-locks from the remote task
>> migration path (consume_remote_task() -> goto retry), but also avoid
>> holding the dsq->lock for too long.
>>
>> Change the break to skip only remote tasks via continue, allowing each
>> CPU to still consume tasks already on its own rq. This unblocks the
>> helper kthread, lets bypass mode activate, and allows both hotplug and
>> RCU grace periods to complete.
> 
> Have you been able to reproduce this stall condition?

Yes, the hotplug selftest reproduces this for me occasionally, I guess
with 100 iteration loop around the 4 test cases it's up to 100%. 

> 
> When the kernel forces bypass, scx_bypass() explicitly walks every CPU's
> runnable_list and cycles tasks through DEQUEUE_SAVE | DEQUEUE_MOVE so
> dispatching stops depending on BPF.
> 
> On CPU hotplug the helper kthread (and all the other critical kthreads) should
> be also in the runnable_list, so they should be moved to SCX_DSQ_BYPASS and
> consume_dispatch_q() should be able to consume them.
> 
> Maybe the problem is that in do_enqueue_task() we keep tasks on the local DSQ
> when !scx_rq_online(rq), instead we should prioritize the bypass condition.
> 
> Does something like the following make sense to you?
> 
> Thanks,
> -Andrea
> 
>  kernel/sched/ext.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 7ac7d10a41bef..277110d950c30 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1901,6 +1901,17 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	 */
>  	p->scx.flags &= ~SCX_TASK_IMMED;
>  
> +	/*
> +	 * Check bypass before testing the rq online state: bypass mode stops
> +	 * processing local DSQs, so tasks should be routed through
> +	 * SCX_DSQ_BYPASS rather than dispatched to the local DSQ during CPU
> +	 * hotplug events.
> +	 */
> +	if (scx_bypassing(sch, cpu_of(rq))) {
> +		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
> +		goto bypass;
> +	}
> +
>  	/*
>  	 * If !scx_rq_online(), we already told the BPF scheduler that the CPU
>  	 * is offline and are just running the hotplug path. Don't bother the
> @@ -1909,11 +1920,6 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	if (!scx_rq_online(rq))
>  		goto local;
>  
> -	if (scx_bypassing(sch, cpu_of(rq))) {
> -		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
> -		goto bypass;
> -	}
> -
>  	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
>  		goto direct;
>  
> 

Unfortunately that also locks up, let me go have another look.
