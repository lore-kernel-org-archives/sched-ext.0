Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE96E2DEA7A
	for <sched-ext@lists.linux.dev>; Sat, 31 Jan 2026 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877963; cv=none; b=hrcYBEjNMDJA+PTXQj9Zi4gzA/s8DU1Avi2acxfAJP98YzaHeMvMSek9l/w8ZQITekixH9tu1wJqdWHVo0djaWHhTLvWDX4jKL+Ml2B+KOVPX0fw0EQavfqWsfO3ie7B4rcQphcbLqoTJn7DhFZfuUaTBNvGPtZqGZGvJ1GeiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877963; c=relaxed/simple;
	bh=uxbjOkLqeYCMTmCcfMDbgpe3ZSO79v7Q5hUxfyX7pQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CirdgeUwUY85YNxMKr4riT6RTiOO57LCzueT3aEWk34jkfUnFaiLhHi33lwHzVL4rmR5hZurjas+q1dXqyEOqNEq2u+OtwPhwXLB8AoZNPqce6ERCigwmJNW9JXkpxsAp/zLawBOGfGizko3Ai7kxlzW/oMA694B1gYdRDRkmzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSrtly9z; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSrtly9z"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-658bd4186b2so3853267a12.1
        for <sched-ext@lists.linux.dev>; Sat, 31 Jan 2026 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769877960; x=1770482760; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBBsbAIOyi1VcwSxx1zjgVn+/GP2kKw+AUM9hD7kTsk=;
        b=MSrtly9zTtU3Eh3Qp8kmDwfV7/IfZOFI+v00ERXrHirnAYS27GqvlEzI41D4menGk3
         2W3WzO49BYVjO89RFVv3rA3jG/JtxIKzF92pqTVGul0ZSWD4Vu2q5LOL/yKpFZfng6gy
         tjSsO+bRyThbYAknwWExZ42EJg7AjuqEvUAT85xs6VERcK0LmcSI+8VMFeJhElSPjoDH
         oWIXWhNr2xZaGFMRFUJfeuyyYmPslITC598GT1+o9ZxHpxas/lUQthndEg1jIbKekFHM
         ooredOU+zM0NQzxE7cUEgoVy8L2UUgcEutliv2cMKQmOMfg2dCIduMwRpWGZjsEHkM/a
         +M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769877960; x=1770482760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBBsbAIOyi1VcwSxx1zjgVn+/GP2kKw+AUM9hD7kTsk=;
        b=ov3lyRMb6vKEKvnoTBdp/PVzCjju1ZVrpgixUiUzG4EJwz4Oy/cI491+T49bxHKXPq
         1hdgxXD8PmRZfl6/RbFn3hQPAkvTy/1ZBNcKL5s3HDu8mIrxNxos2nwpkvzs/gIX4MIg
         eUyUVDOLrWgAcr1okdsvt3s9w1seEbbHyT3p3O6M4GVtkDxE7NlSC0CPgzPihFuXuwSq
         RBttc846EvTvb84Gd8qgVe8RbFg19BvoliPyjZkwcND0lSdjSLYi/T2djO3wtDFqn+1T
         23gb68KrqARXpwDSJ3+l3cv7AAGMzQSYVNOcVZn/ju671fgJCimaSHCj/md/007oKNhQ
         ps1g==
X-Forwarded-Encrypted: i=1; AJvYcCURYH2XKqDc/2LZt01b3aanEyuyLKqoKTWnLjodV0Ximjrlmv0Pu86kis6cKL41KXH5KxCHH4R2jEw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwAH1mW4maWByG5K3IY8QijA2r4hy6tw4q1DwyTWRGhB4AwUaPe
	D3O3T9DyW/zt8pAiwmv3D4ddYGDVwCXNWiXCRXO4qGyGAjzl0woGTETYJOzziUUvay8zcDGlYlA
	BY8eW1p6y11QOrA==
X-Received: from edbif6.prod.google.com ([2002:a05:6402:5d86:b0:655:b1e2:8246])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:f09:b0:655:a20a:a258 with SMTP id 4fb4d7f45d1cf-658de573b59mr3191384a12.10.1769877960241;
 Sat, 31 Jan 2026 08:46:00 -0800 (PST)
Date: Sat, 31 Jan 2026 16:45:59 +0000
In-Reply-To: <aX2nFSL5QilKsGsm@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126084258.3798129-1-arighi@nvidia.com> <20260126084258.3798129-2-arighi@nvidia.com>
 <DFZIS1RRE219.3EWCQVQBFIWHZ@google.com> <aXxfBnzs5Xnwm8PS@gpd4>
 <DG1Y8XVKWV9O.24LWXW2G4RF63@google.com> <aX2nFSL5QilKsGsm@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG2XDI382JPD.6GDH6BO96EXY@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Sat Jan 31, 2026 at 6:54 AM UTC, Andrea Righi wrote:
>> >> If I understand the logic correctly, ops.dequeue(SCHED_CHANGE) will be called
>> >> for a task at most once between it being dispatched and taken off the CPU,
>> >> even if its properties are changed multiple times while it's on CPU.
>> >> Is that intentional? I don't see it documented.
>> >> 
>> >> To illustrate, assume we have a task p that has been enqueued, dispatched, and
>> >> is currently running on the CPU, so we have both SCX_TASK_OPS_ENQUEUE and
>> >> SCX_TASK_DISPATCH_DEQUEUED set in p->scx.flags.
>> >> 
>> >> When a property of p is changed while it runs on the CPU,
>> >> the sequence of calls is:
>> >>   dequeue_task_scx(p, DEQUEUE_SAVE) => put_prev_task_scx(p) =>
>> >>   (change property) => enqueue_task_scx(p, ENQUEUE_RESTORE) =>
>> >>   set_next_task_scx(p).
>> >> 
>> >> dequeue_task_scx(p, DEQUEUE_SAVE) calls ops_dequeue() which calls
>> >> ops.dequeue(p, ... | SCHED_CHANGE) and clears
>> >> SCX_TASK_{OPS_ENQUEUED,DISPATCH_DEQUEUED} from p->scx.flags.
>> >> 
>> >> put_prev_task_scx(p) doesn't do much because SCX_TASK_QUEUED was cleared by
>> >> dequeue_task_scx().
>> >> 
>> >> enqueue_task_scx(p, ENQUEUE_RESTORE) sets sticky_cpu because the task is
>> >> currently running and ENQUEUE_RESTORE is set. This causes do_enqueue_task() to
>> >> jump straight to local_norefill, skipping the call to ops.enqueue(), leaving
>> >> SCX_TASK_OPS_ENQUEUED unset, and then enqueueing the task on the local DSQ.
>> >> 
>> >> set_next_task_scx(p) calls ops_dequeue(p, SCX_DEQ_CORE_SCHED_EXEC) even though
>> >> this is not a core-sched pick, but it won't do much because the ops_state is
>> >> SCX_OPSS_NONE and SCX_TASK_OPS_ENQUEUED is unset. It also calls
>> >> dispatch_dequeue(p) which the removes the task from the local DSQ it was just
>> >> inserted into.
>> >> 
>> >> 
>> >> So, we end up in a state where any subsequent property change while the task is
>> >> still on CPU will not result in ops.dequeue(p, ... | SCHED_CHANGE) being
>> >> called, because both SCX_TASK_OPS_ENQUEUED and SCX_TASK_DISPATCH_DEQUEUED are
>> >> unset in p->scx.flags.
>> >> 
>> >> I really hope I didn't mess anything up when tracing the code, but of course
>> >> I'm happy to be corrected.
>> >
>> > Correct. And the enqueue/dequeue balancing is preserved here. In the
>> > scenario you describe, subsequent property changes while the task remains
>> > running go through ENQUEUE_RESTORE, which intentionally skips
>> > ops.enqueue(). Since no new enqueue cycle is started, there is no
>> > corresponding ops.dequeue() to deliver either.
>> >
>> > In other words, SCX_DEQ_SCHED_CHANGE is associated with invalidating the
>> > scheduler state established by the last ops.enqueue(), not with every
>> > individual property change. Multiple property changes while the task stays
>> > on CPU are coalesced and the enqueue/dequeue pairing remains balanced.
>> 
>> Ok, I think I understand the logic behind this, here's how I understand it:
>> 
>> The BPF scheduler is naturally going to have some internal per-task state.
>> That state may be expensive to compute from scratch, so we don't want to
>> completely discard it when the BPF scheduler loses ownership of the task.
>> 
>> ops.dequeue(SCHED_CHANGE) serves as a notification to the BPF scheduler:
>> "Hey, some scheduling properties of the task are about to change, so you
>> probably should invalidate whatever state you have for that task which depends
>> on these properties."
>
> Correct. And it's also a way to notify that the task has left the BPF
> scheduler, so if the task is stored in any internal queue it can/should be
> removed.

Right, unless the task has already been dispatched, in which case it's just
an invalidation notification.

>
>> 
>> That way, the BPF scheduler will know to recompute the invalidated state on
>> the next ops.enqueue(). If there was no call to ops.dequeue(SCHED_CHANGE), the
>> BPF scheduler knows that none of the task's fundamental scheduling properties
>> (priority, cpu, cpumask, etc.) changed, so it can potentially skip recomputing
>> the state. Of course, the potential for savings depends on the particular
>> scheduler's policy.
>> 
>> This also explains why we only get one call to ops.dequeue(SCHED_CHANGE) while
>> a task is running: for subsequent calls, the BPF scheduler had already been
>> notified to invalidate its state, so there's no use in notifying it again.
>
> Actually I think the proper behavior would be to trigger
> ops.dequeue(SCHED_CHANGE) only when the task is "owned" by the BPF
> scheduler. While running, tasks are outside the BPF scheduler ownership, so
> ops.dequeue() shouldn't be triggered at all.
>

I don't think this is what the current implementation does, right?

>> 
>> However, I feel like there's a hidden assumption here that the BPF scheduler
>> doesn't recompute its state for the task before the next ops.enqueue().
>
> And that should be the proper behavior. BPF scheduler should recompute a
> task state only when the task is re-enqueued after a property change.
>

That would make sense if ops.enqueue() was called immediately after a property
change when a task is running, but I believe that's currently not the case,
see my attempt at tracing the enqueue-dequeue cycle on property change in my
first reply.

>> What if the scheduler wanted to immediately react to the priority of a task
>> being decreased by preempting it? You might say "hook into
>> ops.set_weight()", but then doesn't that obviate the need for
>> ops.dequeue(SCHED_CHANGE)?
>
> If a scheduler wants to implement preemption on property change, it can do
> so in ops.enqueue(): after a property change, the task is re-enqueued,
> triggering ops.enqueue(), at which point the BPF scheduler can decide
> whether and how to preempt currently running tasks.
>
> If a property change does not result in an ops.enqueue() call, it means the
> task is not runnable yet (or does not intend to run), so attempting to
> trigger a preemption at that point would be pointless.
>

IIUC a dequeue-enqueue cycle on a running task during property change doesn't
result in a call to ops.enqueue(), so if the BPF scheduler recomputed its state
only in ops.enqueue(), then it wouldn't be able to react immediately.

>> 
>> I guess it could be argued that ops.dequeue(SCHED_CHANGE) covers property
>> changes that happen under ``scoped_guard (sched_change, ...)`` which don't have
>> a dedicated ops callback, but I wasn't able to find any such properties which
>> would be relevant to SCX.
>> 
>> Another thought on the design: currently, the exact meaning of
>> ops.dequeue(SCHED_CHANGE) depends on whether the task is owned by the BPF
>> scheduler:
>> 
>> * When it's owned, it combines two notifications: BPF scheduler losing
>>   ownership AND that it should invalidate task state.
>> * When it's not owned, it only serves as an "invalidate" notification,
>>   the ownership status doesn't change.
>
> When it's not owned I think ops.dequeue() shouldn't be triggered at all.
>
>> 
>> Wouldn't it be more elegant to have another callback, say
>> ops.property_change(), which would only serve as the "invalidate" notification,
>> and leave ops.dequeue() only for tracking ownership?
>> That would mean calling ops.dequeue() followed by ops.property_change() when
>> changing properties of a task owned by the BPF scheduler, as opposed to a
>> single call to ops.dequeue(SCHED_CHANGE).
>
> We could provide an ops.property_change(), but honestly I don't see any
> practical usage of this callback.
>

Neither do I, I just made it up for the sake of argument :-)

Thanks,
Kuba
