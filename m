Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539DB285060
	for <sched-ext@lists.linux.dev>; Thu, 22 Jan 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074124; cv=none; b=pteEmEZVZapsJpf12u7ufnVdIN/Krhuz5+pj50Gu+1CO1u+kkA780l5N+ehrzKytUQs/zT7Yp83rKVJqnCuUDLmFbd20o3HdrO1CePND4VkYAsy2JxdR4Sifg+vaooIz5ShXCdqi5OkjOb46BpB6SF9/Gc7JgadWpqNMAWTueOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074124; c=relaxed/simple;
	bh=Cd/IbpnrX73vMEkOt1ewQva9AEO2RQVcddrBANb97WQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o96nfx80tvtDOUFiXf64UqcPBxqvGkDHCztS19dujpoqKTeuE1/FY7bb+eqKcWyfgCudFdEX0z9u6R1MDMZa3bGEaBPR8CMaHjNOziOSN8Rr4kf1MDb6mCuLhABCiM5zmXRA8HI9HUq2nXl0UEt4mVqArnqaKBL2nzTdpeBiJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rCjIZJ+Q; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCjIZJ+Q"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so14258455e9.0
        for <sched-ext@lists.linux.dev>; Thu, 22 Jan 2026 01:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769074120; x=1769678920; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y4ypKDsz7ui5lbR4h8ZdeIQiaRNT1DTOumna9FC0+Cc=;
        b=rCjIZJ+QT8KBvmK7V5PqmfC4qkdTzsOB0esn8OLus/neIFYbhpbMmPgyUX0KoMVRuY
         VVhC5P9xHQzSrbi71bzR1bhK47iGikD04jUN4A9CstzDXrbs2vRG8mLwjK4cp4VHOz+u
         kqc1QKyPITzDrAVtidvzwIveFY8lJ88iZGKZjZ/cuI48MMRydiQvsiVpdeYzJnB6TWHj
         ROIFvfcoLrvYEm3gvQadsb0XXv9I7BBwhJz4YytvTWDKwVqTCkhUX7C/6wkeNBE0ccKH
         o/C8Vj+Apw1S+D1eDeTyjaE741CNCP0nAZGpgkdDZF/++CTBKdVA+elF5joJ3d/dc2QK
         HJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769074120; x=1769678920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4ypKDsz7ui5lbR4h8ZdeIQiaRNT1DTOumna9FC0+Cc=;
        b=bHoEODz8Qi4qPadmJFv/OywLKdppOrJbmuDoPi7dZYFlp8LSrT45tZvmO27iSrDAVD
         ENt1DLRx1k9J1Xuv8U5ObDsdW7rpZlQ+XebGuHt5fuXTbje4PJ1BMdtDpdvdPOtAnSZR
         QkU2imtZ1XpfOqsmYFjdEomWeoNOI29anHFV9e47UAu5j8LdMwnwu80ZAIeJY+DsvSwG
         j38UBZwMcNuARbVzP8EiMnvobr4vaINnQhd103n/dPWfRf2ejUZ4s8B6axAM6Rcc4Mi6
         QbNaxIe4y3lKKDeWtmkH+uGP1Fzp+2yykjXCPF/VzG0W6X8y6ho6UG4ysX0KA14fzKZl
         cMcA==
X-Forwarded-Encrypted: i=1; AJvYcCXHGmvUe+lbTOhbPt5YcMPhkb3iP+W8CSDJ87hgn75u22b9UzcJ7X3tYe3AX7duytoI+2TiQXoDrYY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxXtCZVU31v2rq4LFL4LeZH/SZTaW0k0u1/dWnzrFdc7x5I8DDe
	SqsYiTippm2L/5rVj8zOdbVo1ogCadgT6YYgPz5VclkZ9bmf/CpPQokriuUIppAI8dGorGu0MM8
	PauEqiZwQtPHHgg==
X-Received: from wmbe7.prod.google.com ([2002:a05:600c:5907:b0:477:9801:6a64])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:540f:b0:479:2a3c:f31a with SMTP id 5b1f17b1804b1-4801eaae2b0mr304165495e9.1.1769074119966;
 Thu, 22 Jan 2026 01:28:39 -0800 (PST)
Date: Thu, 22 Jan 2026 09:28:39 +0000
In-Reply-To: <20260121123118.964704-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260121123118.964704-1-arighi@nvidia.com> <20260121123118.964704-2-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DFV0FQUGMEVB.321XK903AC0B9@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

[Resending with reply-all, messed up the first time, apologies.]

Hi Andrea,

On Wed Jan 21, 2026 at 12:25 PM UTC, Andrea Righi wrote:
> Currently, ops.dequeue() is only invoked when the sched_ext core knows
> that a task resides in BPF-managed data structures, which causes it to
> miss scheduling property change scenarios. As a result, BPF schedulers
> cannot reliably track task state.
>
> In addition, some ops.dequeue() callbacks can be skipped (e.g., during
> direct dispatch), so ops.enqueue() calls are not always paired with a
> corresponding ops.dequeue(), potentially breaking accounting logic.
>
> Fix this by guaranteeing that every ops.enqueue() is matched with a
> corresponding ops.dequeue(), and introduce the SCX_DEQ_ASYNC flag to
> distinguish dequeues triggered by scheduling property changes from those
> occurring in the normal dispatch workflow.
>
> New semantics:
> 1. ops.enqueue() is called when a task enters the BPF scheduler
> 2. ops.dequeue() is called when the task leaves the BPF scheduler,
>    because it is dispatched to a DSQ (regular workflow)
> 3. ops.dequeue(SCX_DEQ_ASYNC) is called when the task leaves the BPF
>    scheduler, because a task property is changed (sched_change)

What about the case where ops.dequeue() is called due to core-sched picking the
task through sched_core_find()? If I understand core-sched correctly, it can
happen without prior dispatch, so it doesn't fit case 2, and we're not changing
task properties, so it doesn't fit case 3 either.

> +     /*
> +      * Set when ops.dequeue() is called after successful dispatch; used to
> +      * distinguish dispatch dequeues from async dequeues (property changes)
> +      * and to prevent duplicate dequeue calls.
> +      */
> +     SCX_TASK_DISPATCH_DEQUEUED = 1 << 4,

I see this flag being set and cleared in several places, but I don't see it
actually being read, is that intentional?

> @@ -1529,6 +1553,17 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
> 
>       switch (opss & SCX_OPSS_STATE_MASK) {
>       case SCX_OPSS_NONE:
> +             if (SCX_HAS_OP(sch, dequeue) &&
> +                 p->scx.flags & SCX_TASK_OPS_ENQUEUED) {
> +                     bool is_async_dequeue =
> +                             !(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC));
> +
> +                     if (is_async_dequeue)
> +                             SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> +                                              p, deq_flags | SCX_DEQ_ASYNC);
> +                     p->scx.flags &= ~(SCX_TASK_OPS_ENQUEUED |
> +                                       SCX_TASK_DISPATCH_DEQUEUED);
> +             }
>               break;
>       case SCX_OPSS_QUEUEING:
>               /*
> @@ -1537,9 +1572,17 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>                */
>               BUG();
>       case SCX_OPSS_QUEUED:
> -             if (SCX_HAS_OP(sch, dequeue))
> +             /*
> +              * Task is in the enqueued state. This is a property change
> +              * dequeue before dispatch completes. Notify the BPF scheduler
> +              * with SCX_DEQ_ASYNC flag.
> +              */
> +             if (SCX_HAS_OP(sch, dequeue)) {
>                       SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> -                                      p, deq_flags);
> +                                      p, deq_flags | SCX_DEQ_ASYNC);
> +                     p->scx.flags &= ~(SCX_TASK_OPS_ENQUEUED |
> +                                       SCX_TASK_DISPATCH_DEQUEUED);
> +             }
> 

A core-sched pick of a task queued on the BPF scheduler will result in entering
the SCX_OPSS_QUEUED case, which in turn will call ops.dequeue(SCX_DEQ_ASYNC).
This seems to conflict with the is_async_dequeue check above, which treats
SCX_DEQ_CORE_SCHED_EXEC as a synchronous dequeue.

Thanks,
Kuba

