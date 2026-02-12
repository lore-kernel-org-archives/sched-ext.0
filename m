Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03025199FD3
	for <sched-ext@lists.linux.dev>; Thu, 12 Feb 2026 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770906727; cv=none; b=TFAc6rb/uqZUo1UX/nqL1w75DO8NN7NJsQyr6GooOLRq/hZwEI2LfvF4LaERXetm+n8jgV05QTNHhiWW7JacorH5treh4o8+vwiXum0xzHZpuZwNaKW5F5ZN5ulw8o8NzdC9OsmfRJqaeKdAZxMR6B2zYsNLGAcAJgxTKJrr2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770906727; c=relaxed/simple;
	bh=Ulzzn8HAg/zUPCGzjQ2Olgx2/O2micQdnqG667m7DX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWLB74GQw2iX7/D9QsHbVY3Sf+7ActOgHC4xtrzGVR+Athk9P4BchvBxai8qdc7OFIN1wgjz8DGkvQbVl1dySjh9y89vFR3VW5fhZd/FwMgxLOoDOanoFGyYk4GHUdcTz7Tij2XC3VV0vQ5tzgRcMGRwgrs9TfxybbgsyjxCVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD969339;
	Thu, 12 Feb 2026 06:31:58 -0800 (PST)
Received: from [10.1.34.88] (e127648.arm.com [10.1.34.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF6BF3F632;
	Thu, 12 Feb 2026 06:32:03 -0800 (PST)
Message-ID: <8dd4bc8d-83db-4812-b3e3-ea0bbbb24875@arm.com>
Date: Thu, 12 Feb 2026 14:32:02 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260210212813.796548-1-arighi@nvidia.com>
 <20260210212813.796548-2-arighi@nvidia.com>
 <aYu9KzKTMfNIFDwD@slm.duckdns.org> <aYyo_ALV_BT6WaE0@gpd4>
 <aYzc7ZVkSrtdeHnA@slm.duckdns.org> <aY0EDpFD1FSrigB6@gpd4>
 <aY0EmUnmo4gGitcW@slm.duckdns.org> <aY2ofYcZpni9L0px@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aY2ofYcZpni9L0px@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/26 10:16, Andrea Righi wrote:
> On Wed, Feb 11, 2026 at 12:37:13PM -1000, Tejun Heo wrote:
>> Hello,
>>
>> On Wed, Feb 11, 2026 at 11:34:54PM +0100, Andrea Righi wrote:
>>>> The end result is about the same because whenever we migrate we're sending
>>>> it to the local DSQ of the destination CPU, so whether we generate the event
>>>> on deactivation of the source CPU or activation on the destination doesn't
>>>> make *whole* lot of difference. However, conceptually, migrations are
>>>> internal events. There isn't anything actionable for the BPF scheduler. The
>>>> reason why ops.dequeue() should be emitted is not because the task is
>>>> changing CPUs (which caused the deactivation) but the fact that it ends up
>>>> in a local DSQ afterwards. I think it'll be cleaner both conceptually and
>>>> code-wise to emit ops.dequeue() only from dispatch_enqueue() and dequeue
>>>> paths.
>>>
>>> Does this include core scheduler migrations or just SCX-initiated
>>> migrations (move_remote_task_to_local_dsq())?
>>>
>>> Because with core scheduler migrations we trigger ops.enqueue(), so we
>>> should also trigger ops.dequeue(). Or we need to send the task straight to
>>> local to prevent calling ops.enqueue().
>>
>> I'm a bit lost. Can you elaborate on core scheduler migrations triggering
>> ops.enqueue()?
> 
> Alright, let me re-elaborate more on this with a (slightly) fresher brain.
> 
> We have two main classes of migrations:
> 
>  1) Internal SCX-initiated migrations: e.g.,
>     dispatch_to_local_dsq() -> move_remote_task_to_local_dsq(), or
>     consume_remote_task() -> move_remote_task_to_local_dsq(), these
>     are completely internal to SCX and shouldn't trigger
>     ops.dequeue/enqueue()
> 
>  2) Core scheduler migrations
>   - CPU affinity: sched_setaffinity, cpuset/cgroup mask change, etc.
>     affine_move_task -> move_queued_task migrates it -> we trigger
>     ops.dequeue(SCX_DEQ_SCHED_CHANGE) on the source and ops.enqueue() on
>     the target.
> 
>   - Core scheduling (CONFIG_SCHED_CORE): two different cases:
>     - Migration (task moved between runqueues via move_queued_task_locked()
>       to satisfy core cookie)
> 
>   - NUMA balancing: migrate_task_to() can move an SCX task to another CPU
> 
>   - CPU hotplug: on CPU down, runnable tasks are pushed off via
>     __balance_push_cpu_stop() -> __migrate_task()
> 
> If we want to skip ops.dequeue() only for internal SCX migrations (and
> maybe also for NUMA and hotplug?), then only checking
> task_on_rq_migrating(p) is not enough, because that's true for every
> migration listed above and we'd skip all of them.
> 
> So, we need a way to mark "this migration is internal to SCX", like a new
> SCX_TASK_MIGRATING_INTERNAL flag?
> 
> The alternative is to always trigger ops.dequeue/enqueue() on every
> migration (no flag): even for internal SCX migrations the BPF scheduler
> could use it to track task movements, though there's nothing it can do.
> That way we don't need the additional flag.
> 
> Does one of these directions fit better with what you have in mind?
IIUC one example might sway your opinion (or not):
Note that not receiving a ops.dequeue() for tasks leaving one LOCAL_DSQ
(and maybe being enqueued at another) prevents e.g. accurate PELT load
tracking on the BPF side.
Regular utilization tracking works through ops.running() and 
ops.stopping() but load I don't think load can be implemented accurately.
