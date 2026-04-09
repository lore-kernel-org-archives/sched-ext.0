Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8BB3B47FD
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775727974; cv=none; b=oyu+vR09sr/+FC/BjEgT5d8Go0PoEr45Es57n9GYCEKPc2sn3Vkh9ZyFTA3kF4wEOPRyhoGpp2/q5dgzh9h+tf2Ijf3gzsWCTfYOamfM9861J+LBfqjCgMUXiXbBkHJsVyxnh//rfeQMr1DYnga4h5m6RdHskW55Effiky5qMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775727974; c=relaxed/simple;
	bh=7CCsMeW4tAsrXgdH8+yfkR/SfUVxOYCARp9hf00jAe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6+f3auoedzQw5gYSCCwkPqOy8MjY1ts1rXv1b0K34BpNW+1Qub7YXHynNAmAMrNT2YwSV/vbcvKAwFxN+r7++uSt7jCwnIBXr+c6/17g4s0cB/Jh8GydJjM4Es+8f/IPz5SI/yktGCg4aq2dQzqNv0OnqE0a21gLGPSeJ7A3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LXv5M9lv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LXv5M9lv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D214C2923;
	Thu,  9 Apr 2026 02:46:05 -0700 (PDT)
Received: from [10.1.35.59] (e127648.arm.com [10.1.35.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D2943F641;
	Thu,  9 Apr 2026 02:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775727971; bh=7CCsMeW4tAsrXgdH8+yfkR/SfUVxOYCARp9hf00jAe4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LXv5M9lvT8tG8iFmdl5uQzMrrKHezvG3IsIvdlP/70S0piZE//2Y2fzq2YA4mcQ/6
	 FEHPgwjZbCxsjm5SnxzVW1KvuSPvjGrjGulS5T1Rld3e3umBq3EyuuYrivcijCPHAK
	 5Y7NWe4Wp2sIWRFQ/OnnL9Qk9xMRqd+L2m7vsRdE=
Message-ID: <0e2cb8a7-31fd-423b-8660-11357c08dab8@arm.com>
Date: Thu, 9 Apr 2026 10:46:09 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing
 calls to quiescent(), runnable()
To: Kuba Piecuch <jpiecuch@google.com>, Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <adUxZ5Qp_vH6cBZj@gpd4>
 <20260408091821.91063-1-jpiecuch@google.com> <adY76wiI82pUBYkr@gpd4>
 <DHNS3RWRB1C5.29B8SXO481CHK@google.com> <adZc8caEfOZw8TLE@gpd4>
 <DHNU5YSWABWC.2B8Q38OKJGVDR@google.com> <adZsJZDFNgtod-Bd@gpd4>
 <DHOHR34ZLGL6.2UIL2GRFLR53X@google.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <DHOHR34ZLGL6.2UIL2GRFLR53X@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 09:46, Kuba Piecuch wrote:
> On Wed Apr 8, 2026 at 2:54 PM UTC, Andrea Righi wrote:
> ...
>>>
>>> Another inaccuracy not related to direct dispatch: property changes can occur
>>> while a task is running, while the psedocode only allows for property changes
>>> while a task is queued.
>>
>> Sure... but again, modelling all the possible scenarios would make the
>> pseudocode completely unreadable.
> 
> I'm not arguing we should cover all scenarios.
> 
> I'm ok with omitting scenarios whose existence depends on a configuration flag
> or presence/absence of a callback, because:
> 
> a) Using the right configuration, one can actually write a scheduler where the
>    pseudocode is an accurate representation of the task lifecycle;
> 
> b) The assumptions about the configuration can be clearly stated next to the
>    pseudocode.
> 
> I'm less ok with omitting specific scenarios that can't be simply "turned off"
> because they are triggered by the scheduled tasks themselves. A task's property
> being changed while it's running is one example of such a scenario -- one can't
> just prevent it from happening by setting a configuration flag, and sched_ext
> schedulers implementing dequeue/quiescent/runnable/enqueue should be aware of
> it.
> 
> What I especially don't like is giving the reader a partial picture that looks
> like a complete one, as is the case with property changes here. We're letting
> the reader know that it can happen, but the pseudocode makes it look like it
> can only happen while a task is queued and not while it's running, giving the
> reader a false impression that they can assume property changes apply only to
> queued tasks.


Agreed FWIW, I've implemented a few schedulers that need to track state transitions
100% accurately and it was painful to get it 100% right.
I think it's either this or we add a sample BPF scheduler that actually does
track/validate all possible transitions per-task accurately to illustrate. (Maybe a
selftest?)
But that would mean the below becoming quite a bit more complex, too.


> 
>>
>> IMHO it'd be better to give an overview of the most common use cases here and
>> clarify in the description that the diagram doesn't cover all the possible
>> scenarios. This one is a special use case that, personally, I wouldn't cover in
>> the pseudocode.
>>
>>>
>>> There's also preemption by a higher sched class, which is not covered in the
>>> loop condition (task_is_runnable(task) && task->scx.slice > 0), unless we take
>>> task_is_runnable() to return false if there's a higher-priority sched class
>>> with runnable tasks on the CPU, though that would be in conflict with the
>>> actual implementation of task_is_runnable() in include/linux/sched.h.
>>
>> Ditto.
>>
>>>
>>>>
>>>>>
>>>>> A more general comment about the pseudocode: I think it can be useful to
>>>>> introduce someone new to the general flow of the callbacks in sched_ext,
>>>>> but the documentation should be clear that this is a simplified view that
>>>>> makes assumptions about the behavior of the BPF scheduler itself (flags like
>>>>> SCX_OPS_ENQ_LAST, whether the scheduler uses direct dispatch), as well as
>>>>> the overall system (Can sched_ext be preempted by a higher-priority sched
>>>>> class? Can scheduling properties of a task be changed while it's running?)
>>>>> Without stating these assumptions clearly, we risk leaving the reader falsely
>>>>> believing they have a complete understanding.
>>>>
>>>> Of course this schema is not a complete representation of the entire sched_ext
>>>> state machine, if we put everything it'd become too big and complex. I think we
>>>> should just cover the most common use cases here. Maybe we can clarify this in
>>>> the description before this diagram.
>>>
>>> Let's agree on what inaccuracies need to be fixed and I'll send a v2 with fixes
>>> and attach an appropriate disclaimer to the pseudocode.
>>
>> If we move ops.dispatch() + ops.dequeue() inside the ops.enqueue() block I think
>> the pseudocode becomes "fairly" accurate. At least more accurate than what we
>> have right now. It won't be perfect, but it can help newer sched_ext devs having
>> an overview the task lifecycle without going too much into implementation
>> details.
>>
>> So, to recap, what do you think about this?
>>
>>     ops.init_task();            /* A new task is created */
>>     ops.enable();               /* Enable BPF scheduling for the task */
>>
>>     while (task in SCHED_EXT) {
>>         if (task can migrate)
>>             ops.select_cpu();   /* Called on wakeup (optimization) */
>>
>>         ops.runnable();         /* Task becomes ready to run */
>>
>>         while (task_is_runnable(task)) {
>>             if (task is not in a DSQ || task->scx.slice == 0) {
>>                 ops.enqueue();  /* Task can be added to a DSQ */
>>
>>                 /* Task property change (i.e., affinity, nice, etc.)? */
>>                 if (sched_change(task)) {
>>                     ops.dequeue(); /* Exiting BPF scheduler custody */
>>                     ops.quiescent();
>>
>>                     /* Property change callback, e.g. ops.set_weight() */
>>
>>                     ops.runnable();
>>                     continue;
>>                 }
>>
>>                 /* Any usable CPU becomes available */
>>
>>                 ops.dispatch();     /* Task is moved to a local DSQ */
>>                 ops.dequeue();      /* Exiting BPF scheduler custody */
Is this true here? Any dispatch followed by a dequeue?

>>             }
>>
>>             ops.running();      /* Task starts running on its assigned CPU */
>>
>>             while (task_is_runnable(task) && task->scx.slice > 0) {
>>                 ops.tick();     /* Called every 1/HZ seconds */
>>
>>                 if (task->scx.slice == 0)
>>                     ops.dispatch(); /* task->scx.slice can be refilled */
>>             }
>>
>>             ops.stopping();     /* Task stops running (time slice expires or wait) */
>>         }
>>
>>         ops.quiescent();        /* Task releases its assigned CPU (wait) */
>>     }
>>
>>     ops.disable();              /* Disable BPF scheduling for the task */
>>     ops.exit_task();            /* Task is destroyed */
> 
> I don't love it (and I probably never will), but I agree it's the best so far.
> I'll send a v2 with the updated pseudocode and I'll put a bit of a disclaimer
> before it.



