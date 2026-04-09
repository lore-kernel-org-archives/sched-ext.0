Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7AC2FA0C6
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724367; cv=none; b=At58ST+Fzvb6Zj/BALQuaLkr+phEdE3T7J0muO0DU81SJgjpdKUftSjbEFRqOO+Ytnz0sQsyXMoxbb1tq3SLdBSIHl/ZkZJs3pFB7ZPegKXNayLY6Wpy7BEl9cpNe4d6I1l/DKtl3gfWzjVatpEfx3CRtVgQBu7n1BvHuZdCrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724367; c=relaxed/simple;
	bh=xxQA6Y/Qh+Iq7KTV8VwNq96lHDaLr2pAz/2A2UXnf0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GDo+S3OBjH3hVsxElqcvbefm7rektHOrwGsSHH0ZD8khGoq4bznZB4NR/VmJeSMwzdobo5aaRwYMaj2xekrpern/1sW90bBrbJHOhsUsFjU9LPARJChZviX1sChj2fyh6fce/PXY6cvP92GRqmjLYMHfvAPl4pkdGdW5jMv+A2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LMwFPmwZ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMwFPmwZ"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d03db814eso657469f8f.2
        for <sched-ext@lists.linux.dev>; Thu, 09 Apr 2026 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775724364; x=1776329164; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObTtBXO3DNJcc8+kZCdANqFs90n3AGRH6ssIW+CEXng=;
        b=LMwFPmwZhafKg2vpyMJk1nOPZWr6/Ytabvi5Y2Lv8ieQhvO8wfmGv7ANRDQdk3U9YG
         im44VOYxm5v9L5A2M/v410n8OiNNFR3vUsFYeqsWo/uT2ZupYcyjmikArCvK3Tm4S/6w
         13sv/YcSpf5tQ63qYLeyqyw+cN0HK+jiKv9h7itCwjmu5aVoqhY5QVMv94V0/WQEJVfK
         vxcYdCbQl5PIsKN+JwqilsqmFNk7/Qg0ep3UTRGc5QMvwsoHWn2LjR8KFwMDCRs2QUhJ
         yqxnbiP+bGy5oOSm4yXKijxSVVADtNOJxgVWfyH7CqtWHiK2w+He7jMg/fXed4v4kYFN
         Y+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775724364; x=1776329164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObTtBXO3DNJcc8+kZCdANqFs90n3AGRH6ssIW+CEXng=;
        b=CAikoxczIjen5uiiQr2Ht+5LmNuzZux9yB7GEbXcX07WUg0xqjRi7gJgPGTpX+5IMV
         8uihh1gNo9epX3xbEYntwklaV5P48xo6l+VuwHJ2+spgs53iTFRQJm3R0d21w79FCoFK
         p/9CztL7/+Pz7y/PFVw87K0QV431IrUVaTy5S/1nal1CE+mQwBhFlxgnB71eNX+9VhGF
         zX5xL3kVT7n6cYDbnTttXVvcOfkL6a0kqkR1Qj5Y7S6AHCgNTDJcbrW1RSQcfTn2V1VA
         N1qvV+v69SemM0dOzdOszYzV+3Ek6R0KekHU03TzyxwefIC2ccA10OVvao9KgqY12P7V
         HeHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhrRRJF8Bn1U19cPCbDW+WHXGX7GRWiEdPLp5EPpsusuEaqoK0O+kd8NCESeZHQzUQ9piySPuTNCU=@lists.linux.dev
X-Gm-Message-State: AOJu0YyCgyzJaqRjRd6Y6IguGugr+tKvOQoOxUtHFwxBt57RvTipfBqn
	Gzydzx/d1NiezJU7zlZ0a9qLwO43FSLDKdG3geyDF8ExfyfUBg3FZKdBbAp+pBL3AdfS+ioHtBb
	2W2Fo155ONTWYqA==
X-Received: from wrvf17.prod.google.com ([2002:a5d:5691:0:b0:43c:fb93:952])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d6:b0:488:bc6a:528d with SMTP id 5b1f17b1804b1-488bc6a550fmr146160665e9.22.1775724364416;
 Thu, 09 Apr 2026 01:46:04 -0700 (PDT)
Date: Thu, 09 Apr 2026 08:46:03 +0000
In-Reply-To: <adZsJZDFNgtod-Bd@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <adUxZ5Qp_vH6cBZj@gpd4> <20260408091821.91063-1-jpiecuch@google.com>
 <adY76wiI82pUBYkr@gpd4> <DHNS3RWRB1C5.29B8SXO481CHK@google.com>
 <adZc8caEfOZw8TLE@gpd4> <DHNU5YSWABWC.2B8Q38OKJGVDR@google.com> <adZsJZDFNgtod-Bd@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DHOHR34ZLGL6.2UIL2GRFLR53X@google.com>
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing
 calls to quiescent(), runnable()
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Apr 8, 2026 at 2:54 PM UTC, Andrea Righi wrote:
...
>> 
>> Another inaccuracy not related to direct dispatch: property changes can occur
>> while a task is running, while the psedocode only allows for property changes
>> while a task is queued.
>
> Sure... but again, modelling all the possible scenarios would make the
> pseudocode completely unreadable.

I'm not arguing we should cover all scenarios.

I'm ok with omitting scenarios whose existence depends on a configuration flag
or presence/absence of a callback, because:

a) Using the right configuration, one can actually write a scheduler where the
   pseudocode is an accurate representation of the task lifecycle;

b) The assumptions about the configuration can be clearly stated next to the
   pseudocode.

I'm less ok with omitting specific scenarios that can't be simply "turned off"
because they are triggered by the scheduled tasks themselves. A task's property
being changed while it's running is one example of such a scenario -- one can't
just prevent it from happening by setting a configuration flag, and sched_ext
schedulers implementing dequeue/quiescent/runnable/enqueue should be aware of
it.

What I especially don't like is giving the reader a partial picture that looks
like a complete one, as is the case with property changes here. We're letting
the reader know that it can happen, but the pseudocode makes it look like it
can only happen while a task is queued and not while it's running, giving the
reader a false impression that they can assume property changes apply only to
queued tasks.

>
> IMHO it'd be better to give an overview of the most common use cases here and
> clarify in the description that the diagram doesn't cover all the possible
> scenarios. This one is a special use case that, personally, I wouldn't cover in
> the pseudocode.
>
>> 
>> There's also preemption by a higher sched class, which is not covered in the
>> loop condition (task_is_runnable(task) && task->scx.slice > 0), unless we take
>> task_is_runnable() to return false if there's a higher-priority sched class
>> with runnable tasks on the CPU, though that would be in conflict with the
>> actual implementation of task_is_runnable() in include/linux/sched.h.
>
> Ditto.
>
>> 
>> >
>> >> 
>> >> A more general comment about the pseudocode: I think it can be useful to
>> >> introduce someone new to the general flow of the callbacks in sched_ext,
>> >> but the documentation should be clear that this is a simplified view that
>> >> makes assumptions about the behavior of the BPF scheduler itself (flags like
>> >> SCX_OPS_ENQ_LAST, whether the scheduler uses direct dispatch), as well as
>> >> the overall system (Can sched_ext be preempted by a higher-priority sched
>> >> class? Can scheduling properties of a task be changed while it's running?)
>> >> Without stating these assumptions clearly, we risk leaving the reader falsely
>> >> believing they have a complete understanding.
>> >
>> > Of course this schema is not a complete representation of the entire sched_ext
>> > state machine, if we put everything it'd become too big and complex. I think we
>> > should just cover the most common use cases here. Maybe we can clarify this in
>> > the description before this diagram.
>> 
>> Let's agree on what inaccuracies need to be fixed and I'll send a v2 with fixes
>> and attach an appropriate disclaimer to the pseudocode.
>
> If we move ops.dispatch() + ops.dequeue() inside the ops.enqueue() block I think
> the pseudocode becomes "fairly" accurate. At least more accurate than what we
> have right now. It won't be perfect, but it can help newer sched_ext devs having
> an overview the task lifecycle without going too much into implementation
> details.
>
> So, to recap, what do you think about this?
>
>     ops.init_task();            /* A new task is created */
>     ops.enable();               /* Enable BPF scheduling for the task */
>
>     while (task in SCHED_EXT) {
>         if (task can migrate)
>             ops.select_cpu();   /* Called on wakeup (optimization) */
>
>         ops.runnable();         /* Task becomes ready to run */
>
>         while (task_is_runnable(task)) {
>             if (task is not in a DSQ || task->scx.slice == 0) {
>                 ops.enqueue();  /* Task can be added to a DSQ */
>
>                 /* Task property change (i.e., affinity, nice, etc.)? */
>                 if (sched_change(task)) {
>                     ops.dequeue(); /* Exiting BPF scheduler custody */
>                     ops.quiescent();
>
>                     /* Property change callback, e.g. ops.set_weight() */
>
>                     ops.runnable();
>                     continue;
>                 }
>
>                 /* Any usable CPU becomes available */
>
>                 ops.dispatch();     /* Task is moved to a local DSQ */
>                 ops.dequeue();      /* Exiting BPF scheduler custody */
>             }
>
>             ops.running();      /* Task starts running on its assigned CPU */
>
>             while (task_is_runnable(task) && task->scx.slice > 0) {
>                 ops.tick();     /* Called every 1/HZ seconds */
>
>                 if (task->scx.slice == 0)
>                     ops.dispatch(); /* task->scx.slice can be refilled */
>             }
>
>             ops.stopping();     /* Task stops running (time slice expires or wait) */
>         }
>
>         ops.quiescent();        /* Task releases its assigned CPU (wait) */
>     }
>
>     ops.disable();              /* Disable BPF scheduling for the task */
>     ops.exit_task();            /* Task is destroyed */

I don't love it (and I probably never will), but I agree it's the best so far.
I'll send a v2 with the updated pseudocode and I'll put a bit of a disclaimer
before it.

Thanks,
Kuba
