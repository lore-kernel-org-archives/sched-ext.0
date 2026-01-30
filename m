Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A727472
	for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769778867; cv=none; b=nsMMPjj+JgIZSW8GDh5ceutvwsWgrCHXFy0r/d1DCinW770UC1cNgilJR9ZjyCE0k3t8Q8Nl/J0tzvEB1g85Xnwv0MpQTyHJ8oepD1BlNSZFE6rQ6gPqa0BNclRug4xfGrB2Lt1tWqCIP6cy3hlzY8f5NUrVtLoUDmuUMFGLfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769778867; c=relaxed/simple;
	bh=kgjraFd/b7bkVTZN9pBegmDt0NEaIf6AHFjbzb+JspA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dIHcer9vzOFnV+QgJh4cWS1X4t2LVbYy74A3DBX3HwvnhcL5SuxDiU09jgbw81hQXX493iFrCFGI3Xtv1mLRiYq+7vPAsKMqiiGWSvIaA0rsY0y/NNImupR1paj7jAIaPud41qZo/Ny4r+RV+waMvJB8CtUN/SVYrxSdn8d5wg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLkU212N; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLkU212N"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-64d3c4deb88so2059382a12.1
        for <sched-ext@lists.linux.dev>; Fri, 30 Jan 2026 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769778864; x=1770383664; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bsrSLDvphyJEXDIAqEtr8vQzt5FPr9nPxQw076RMPtA=;
        b=KLkU212NPfTRb6AbPPywntQqS0f6tcmjCWTnEJvpxN4iSmP7uk+DqRP5dEpmQvflKp
         XX7n1pPAATgTOEQH4T+zbq4w9+PXtnUQvCREE+huuznjx14LJluVqvROyFcWHUmIJAWy
         cetmvB85RGoVSJC9vZ5WSGsq8zL80Fb7Jaj3HRK/Lkv+KFshLdmuL5KKZZfAECgC2OJB
         kMWc/7NFyf10ZXE123o5ty3KvJBDWsSC3LBq9ds3x/WTlY4Dxjb2gSq87QJd3diBDo03
         GYC64Vj9AAicrK79aK/Oxha7jHiBWVSw83s42Q6qYtP3TjySc6+nzKNdI8QGSeDgsXlC
         xKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769778864; x=1770383664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsrSLDvphyJEXDIAqEtr8vQzt5FPr9nPxQw076RMPtA=;
        b=Cn0vBGoszKmvmDzoUYM3uEV2hFOPQZUWGJHhqO2W5SsilnJwC1HPjLS8CytjclHLaX
         0dMXhD/66Zyl0MzNTI5wihhlnm+DChe8eagdCz2kjShnYyo/hKCDiJbOfsGXPnHnvKTb
         BU37/74kvUtmDxgNCu5va2y8jPmTcFhiRZ+mJuJOGbWRlg2wgam5Ar9c2vZJcI6K5yCb
         Ye6B8bTLJXhGtOap4uKNmT+4pHRq5Zy+dTF3zqeYaZCs1P0P+yhiFCcM/XVbIwml2xDW
         y6TvNqhfqPFtEdVvgcs4N1ji40KQJjSgh7+NVriDoVc5n+QTXZlmTVItVbgcbXrrPWYE
         CqRg==
X-Forwarded-Encrypted: i=1; AJvYcCW+GFGEmXhesU/5kDIuIaW4d2FKnVO9au81rGK5gKNeYlBlt4Ldg4FH2wShvLilumOpi2nAAc5tQSg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw50fvKdJADIKtX8fcjJcOPOPyawgtC+IhLvrJtkZC3Z0un3bbQ
	7a2hZRTu9H+sHaFec65rWd9LO9PaQ61rl6dTMspYF0MQThZg/AB3QMvj6+UlLHUDRxaOJVTbHWg
	a50Ja7oI4q5oJ6w==
X-Received: from edwj17.prod.google.com ([2002:a05:6402:11d1:b0:658:a15:1c9a])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1ed5:b0:658:b76f:da7a with SMTP id 4fb4d7f45d1cf-658de5536femr1984724a12.12.1769778864187;
 Fri, 30 Jan 2026 05:14:24 -0800 (PST)
Date: Fri, 30 Jan 2026 13:14:23 +0000
In-Reply-To: <aXxfBnzs5Xnwm8PS@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126084258.3798129-1-arighi@nvidia.com> <20260126084258.3798129-2-arighi@nvidia.com>
 <DFZIS1RRE219.3EWCQVQBFIWHZ@google.com> <aXxfBnzs5Xnwm8PS@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG1Y8XVKWV9O.24LWXW2G4RF63@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Fri Jan 30, 2026 at 7:34 AM UTC, Andrea Righi wrote:
...
> Good point, the confusion is on my side, the documentation overloads the
> term "enqueued" and doesn't clearly distinguish the different contexts.
>
> In that paragraph, "enqueued" refers to the ops lifecycle (i.e., a task for
> which ops.enqueue() has been called and whose scheduler-visible state is
> being tracked), not to the task being queued on a DSQ or having
> SCX_TASK_QUEUED set.
>
> The intent is to treat ops.enqueue() and ops.dequeue() as the boundaries of
> a scheduler-visible lifecycle, regardless of whether the task is eventually
> queued on a DSQ or dispatched directly.
>
> And as noted by Tejun in his last email, skipping ops.dequeue() for direct
> dispatches also makes sense, since in that case no new ops lifecycle is
> established (direct dispatch in ops.select_cpu() or ops.enqueue() can be
> seen as a shortcut to bypass the scheduler).

Right, skipping ops.dequeue() for direct dispatches makes sense, provided
the task is being dispatched to a local/global DSQ. Or at least that's my
takeaway after reading Tejun's email.

...
>> 
>> If I understand the logic correctly, ops.dequeue(SCHED_CHANGE) will be called
>> for a task at most once between it being dispatched and taken off the CPU,
>> even if its properties are changed multiple times while it's on CPU.
>> Is that intentional? I don't see it documented.
>> 
>> To illustrate, assume we have a task p that has been enqueued, dispatched, and
>> is currently running on the CPU, so we have both SCX_TASK_OPS_ENQUEUE and
>> SCX_TASK_DISPATCH_DEQUEUED set in p->scx.flags.
>> 
>> When a property of p is changed while it runs on the CPU,
>> the sequence of calls is:
>>   dequeue_task_scx(p, DEQUEUE_SAVE) => put_prev_task_scx(p) =>
>>   (change property) => enqueue_task_scx(p, ENQUEUE_RESTORE) =>
>>   set_next_task_scx(p).
>> 
>> dequeue_task_scx(p, DEQUEUE_SAVE) calls ops_dequeue() which calls
>> ops.dequeue(p, ... | SCHED_CHANGE) and clears
>> SCX_TASK_{OPS_ENQUEUED,DISPATCH_DEQUEUED} from p->scx.flags.
>> 
>> put_prev_task_scx(p) doesn't do much because SCX_TASK_QUEUED was cleared by
>> dequeue_task_scx().
>> 
>> enqueue_task_scx(p, ENQUEUE_RESTORE) sets sticky_cpu because the task is
>> currently running and ENQUEUE_RESTORE is set. This causes do_enqueue_task() to
>> jump straight to local_norefill, skipping the call to ops.enqueue(), leaving
>> SCX_TASK_OPS_ENQUEUED unset, and then enqueueing the task on the local DSQ.
>> 
>> set_next_task_scx(p) calls ops_dequeue(p, SCX_DEQ_CORE_SCHED_EXEC) even though
>> this is not a core-sched pick, but it won't do much because the ops_state is
>> SCX_OPSS_NONE and SCX_TASK_OPS_ENQUEUED is unset. It also calls
>> dispatch_dequeue(p) which the removes the task from the local DSQ it was just
>> inserted into.
>> 
>> 
>> So, we end up in a state where any subsequent property change while the task is
>> still on CPU will not result in ops.dequeue(p, ... | SCHED_CHANGE) being
>> called, because both SCX_TASK_OPS_ENQUEUED and SCX_TASK_DISPATCH_DEQUEUED are
>> unset in p->scx.flags.
>> 
>> I really hope I didn't mess anything up when tracing the code, but of course
>> I'm happy to be corrected.
>
> Correct. And the enqueue/dequeue balancing is preserved here. In the
> scenario you describe, subsequent property changes while the task remains
> running go through ENQUEUE_RESTORE, which intentionally skips
> ops.enqueue(). Since no new enqueue cycle is started, there is no
> corresponding ops.dequeue() to deliver either.
>
> In other words, SCX_DEQ_SCHED_CHANGE is associated with invalidating the
> scheduler state established by the last ops.enqueue(), not with every
> individual property change. Multiple property changes while the task stays
> on CPU are coalesced and the enqueue/dequeue pairing remains balanced.

Ok, I think I understand the logic behind this, here's how I understand it:

The BPF scheduler is naturally going to have some internal per-task state.
That state may be expensive to compute from scratch, so we don't want to
completely discard it when the BPF scheduler loses ownership of the task.

ops.dequeue(SCHED_CHANGE) serves as a notification to the BPF scheduler:
"Hey, some scheduling properties of the task are about to change, so you
probably should invalidate whatever state you have for that task which depends
on these properties."

That way, the BPF scheduler will know to recompute the invalidated state on
the next ops.enqueue(). If there was no call to ops.dequeue(SCHED_CHANGE), the
BPF scheduler knows that none of the task's fundamental scheduling properties
(priority, cpu, cpumask, etc.) changed, so it can potentially skip recomputing
the state. Of course, the potential for savings depends on the particular
scheduler's policy.

This also explains why we only get one call to ops.dequeue(SCHED_CHANGE) while
a task is running: for subsequent calls, the BPF scheduler had already been
notified to invalidate its state, so there's no use in notifying it again.

However, I feel like there's a hidden assumption here that the BPF scheduler
doesn't recompute its state for the task before the next ops.enqueue().
What if the scheduler wanted to immediately react to the priority of a task
being decreased by preempting it? You might say "hook into
ops.set_weight()", but then doesn't that obviate the need for
ops.dequeue(SCHED_CHANGE)?

I guess it could be argued that ops.dequeue(SCHED_CHANGE) covers property
changes that happen under ``scoped_guard (sched_change, ...)`` which don't have
a dedicated ops callback, but I wasn't able to find any such properties which
would be relevant to SCX.

Another thought on the design: currently, the exact meaning of
ops.dequeue(SCHED_CHANGE) depends on whether the task is owned by the BPF
scheduler:

* When it's owned, it combines two notifications: BPF scheduler losing
  ownership AND that it should invalidate task state.
* When it's not owned, it only serves as an "invalidate" notification,
  the ownership status doesn't change.

Wouldn't it be more elegant to have another callback, say
ops.property_change(), which would only serve as the "invalidate" notification,
and leave ops.dequeue() only for tracking ownership?
That would mean calling ops.dequeue() followed by ops.property_change() when
changing properties of a task owned by the BPF scheduler, as opposed to a
single call to ops.dequeue(SCHED_CHANGE).

But honestly, when I put it like this, it gets harder to justify having this
callback over just using ops.set_weight() etc.

>
> I agree this distinction isn't obvious from the current documentation, I'll
> clarify that SCX_DEQ_SCHED_CHANGE is edge-triggered per enqueue/run cycle,
> not per property change.
>
> Do you see any practical use case where it'd be beneficial to tie
> individual ops.dequeue() calls to every property change, as opposed to the
> current coalesced behavior??

I don't know how practical it is, but in my comment above I mention a BPF
scheduler wanting to immediately preempt a running task on priority decrease,
but in that case we need to hook into ops.set_weight() anyway to find out
whether the priority was decreased.

Thanks,
Kuba

