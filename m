Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCB52DE711
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027004; cv=none; b=S6NzA4jGdlhO21II8MGxVy5rtxwfSl3NiPO8nJRVQaN3bL9jN7lq8mLFLsvaff1tJiVxY/YuDWnQ5d++N7KpoyPUQ3d8s6iiAoSCqUBnzP6bybZBHUDIStU7DvYaXsIDa08DAgDXRVEtTWRGQcSvH5cxZjPEK9wahub2vIa1ML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027004; c=relaxed/simple;
	bh=zHV3AVkQfQNpdCRtdan6ywHwfhiVVK7ghWaBze67hPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QydoJwii0vpwPnYIgj7yubVNhguqYON9Xxjt7p49nt2ZTll+/ku/lMd6LauWSSysWH8BrnO+9JV7Dvzk2UqIYvTAOV5fr3NgsByhAvy00NKnZLkouyul82Z9u0QyjkkVyyZFkTmDfWm39w/0s8jBW+mF45cDgx6N9EzFeWE1Qzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C60B6339;
	Mon,  2 Feb 2026 02:09:55 -0800 (PST)
Received: from [10.1.35.46] (unknown [10.1.35.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAC563F740;
	Mon,  2 Feb 2026 02:10:00 -0800 (PST)
Message-ID: <bc4be033-74f6-4370-8848-1944e8ba143c@arm.com>
Date: Mon, 2 Feb 2026 10:09:59 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Kuba Piecuch <jpiecuch@google.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260201091318.178710-1-arighi@nvidia.com>
 <20260201091318.178710-2-arighi@nvidia.com>
 <b868ee48-4545-4b1b-b313-d5863d65608d@arm.com> <aYBWAzFDX8Rv-paN@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aYBWAzFDX8Rv-paN@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 07:45, Andrea Righi wrote:
> Hi Christian,
> 
> On Sun, Feb 01, 2026 at 10:47:22PM +0000, Christian Loehle wrote:
>> On 2/1/26 09:08, Andrea Righi wrote:
>>> Currently, ops.dequeue() is only invoked when the sched_ext core knows
>>> that a task resides in BPF-managed data structures, which causes it to
>>> miss scheduling property change events. In addition, ops.dequeue()
>>> callbacks are completely skipped when tasks are dispatched to non-local
>>> DSQs from ops.select_cpu(). As a result, BPF schedulers cannot reliably
>>> track task state.
>>>
>>> Fix this by guaranteeing that each task entering the BPF scheduler's
>>> custody triggers exactly one ops.dequeue() call when it leaves that
>>> custody, whether the exit is due to a dispatch (regular or via a core
>>> scheduling pick) or to a scheduling property change (e.g.
>>> sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
>>> balancing, etc.).
>>>
>>> BPF scheduler custody concept: a task is considered to be in "BPF
>>> scheduler's custody" when it has been queued in BPF-managed data
>>> structures and the BPF scheduler is responsible for its lifecycle.
>>> Custody ends when the task is dispatched to a local DSQ, selected by
>>> core scheduling, or removed due to a property change.
>>>
>>> Tasks directly dispatched to local DSQs (via %SCX_DSQ_LOCAL or
>>> %SCX_DSQ_LOCAL_ON) bypass the BPF scheduler entirely and are not in its
>>> custody. As a result, ops.dequeue() is not invoked for these tasks.
>>>
>>> To identify dequeues triggered by scheduling property changes, introduce
>>> the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
>>> the dequeue was caused by a scheduling property change.
>>>
>>> New ops.dequeue() semantics:
>>>  - ops.dequeue() is invoked exactly once when the task leaves the BPF
>>>    scheduler's custody, in one of the following cases:
>>>    a) regular dispatch: task was dispatched to a non-local DSQ (global
>>>       or user DSQ), ops.dequeue() called without any special flags set
>>>    b) core scheduling dispatch: core-sched picks task before dispatch,
>>>       dequeue called with %SCX_DEQ_CORE_SCHED_EXEC flag set
>>>    c) property change: task properties modified before dispatch,
>>>       dequeue called with %SCX_DEQ_SCHED_CHANGE flag set
>>>
>>> This allows BPF schedulers to:
>>>  - reliably track task ownership and lifecycle,
>>>  - maintain accurate accounting of managed tasks,
>>>  - update internal state when tasks change properties.
>>>
>>
>> So I have finally gotten around updating scx_storm to the new semantics,
>> see:
>> https://github.com/cloehle/scx/tree/cloehle/scx-storm-qmap-insert-local-dequeue-semantics
>>
>> I don't think the new ops.dequeue() are enough to make inserts to local-on
>> from anywhere safe, because it's still racing with dequeue from another CPU?
> 
> Yeah, with this patch set BPF schedulers get proper ops.dequeue()
> callbacks, but we're not fixing the usage of SCX_DSQ_LOCAL_ON from
> ops.dispatch().
> 
> When task properties change between scx_bpf_dsq_insert() and the actual
> dispatch, task_can_run_on_remote_rq() can still trigger a fatal
> scx_error().
> 
> The ops.dequeue(SCX_DEQ_SCHED_CHANGE) notifications happens after the
> property change, so it can't prevent already-queued dispatches from
> failing. The race window is between ops.dispatch() returning and
> dispatch_to_local_dsq() executing.
> 
> We can address this in a separate patch set. One thing at a time. :)
> 
>>
>> Furthermore I can reproduce the following with this patch applied quite easily
>> with something like
>>
>> hackbench -l 1000 & timeout 10 ./build/scheds/c/scx_storm
>>
>> [   44.356878] sched_ext: BPF scheduler "simple" enabled
>> [   59.315370] sched_ext: BPF scheduler "simple" disabled (unregistered from user space)
>> [   85.366747] sched_ext: BPF scheduler "storm" enabled
>> [   85.371324] ------------[ cut here ]------------
>> [   85.373370] WARNING: kernel/sched/sched.h:1571 at update_locked_rq+0x64/0x6c, CPU#5: gmain/1111
> 
> Ah yes! I think I see it, can you try this on top?
> 
> Thanks,
> -Andrea
> 
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6d6f1253039d8..d8fed4a49195d 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2248,7 +2248,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
>  			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
>  		} else {
>  			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
> -				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, task_rq(p), p, 0);
> +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
>  
>  			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
>  		}

Yup, that fixes it!
