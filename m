Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A83587D5
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033407; cv=none; b=TbLk12Plr0I8mrJKLILPDtFKl1C6mvseRlNcEC3Ds6ggogwkSxS00ImMUVO5YVTwxTeQwKmnwjwMWUuIq0ERN3oyVIAMQAZ8iX7D0EXYQ2c7LYCWAgNU6XX+QppQvoryL878lqB86PD8P6MozSOEGpA9cFF2wxsD/VpC4636Sfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033407; c=relaxed/simple;
	bh=SqjFn3qAKLYSqCuKCyb7oRXsC9IqVUuDCkk0+QQBstk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iJGNKBhOQz2AAIrqEjU1TrmdmyQ67I+Ma+rOmbyUvediAUrWChvLj/2U82fsuZ8c8F5TbE8zr5oCLOZTlBnh4KmI8NF4uLSlo61nKxCaoS2K1e+ds8E86wyG5J7eAnYPFyRLrp+I68U8WcHdkUT7fIR1+VOWZ7rEwFRYgndXktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rzb3v4MB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rzb3v4MB"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4801d21c280so31898675e9.1
        for <sched-ext@lists.linux.dev>; Mon, 02 Feb 2026 03:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770033404; x=1770638204; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZUoYy8IEkA31ohPOBBy58Tlll3q5I6OE1tZ/Ea3DyI=;
        b=rzb3v4MBjTk7z4A/cbVWuJK3YEJ5RL18P3uDPHkf5yB/Ptk7uLiyRZRrNj0cAHFcbd
         HQAeTVVKkPeohIlsso7H1Ot0rr9XawQVNzq7icwHMyA9SaKrqSqcWbP0LgzoyIt9rwKz
         zw1jLErrJYX7s7gjSwt89jzCr0NUL8IJxL044ySjlASPRIiGZKAUmZdHjX7s+01q/Q/X
         K974MC/8VDPe6hotbhbVHw0lKL6xjPnJK0nE8I1vfxar3kMRUxzmBgT9h4SZkVpqLh2y
         Yoz/4ZmW0+krhAcQ4HokUTzknZdqhO5soWqCzWttm9F0ofh0TNundjvnD7hukQwOSlK3
         XbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770033404; x=1770638204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZUoYy8IEkA31ohPOBBy58Tlll3q5I6OE1tZ/Ea3DyI=;
        b=bp2q5BWMjRWN2Cg+mGSGqAYwYtGqzFu09wbl8WipRRKDl/8qdVli0uxg3fZqJHrayD
         eeCpb6hoKhhJ+2N3rItOD03FPsdsyIWWtWy6bgkEhw7GXfGZtb5uO1gb8nA69vsCVJSE
         9U90ML940Isbee+BbmxsBnYRf4cb/MrZhaQFedOrMTrorycPCyENWDAhvPvcllBJ39DB
         MsuFl2Nym9+OKgWOCXWXOAcctZ1RH8LUbj6DBOIvDDmrxfRuCfbB3kkliTNBTwAHjsqY
         mvw0fqhIUdxdUV5UakFVhupVzSwo2HUNvLGgpexHc/Crb2bIo9b/KRcKeAY6guXL+h5m
         5DwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4e6WwG9QzCVBwNYBdvKnOBeduXdJjGyhkq1CO81EGKWHvtIan3j55CZTYI0hEiUuw1fXk8HKOzj0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw43E9pEhMXZuj/Xr3NcJELcNNjIMxann71F6jC2ZR/EhTXQdt1
	N0Yby5Gvmg/35LdzNzgZETMYUkFj8t1YF/YprwJTEOOzBKpN9orD+b8qTcRNDNFYP0aIEmTkAiz
	mxhCPd6kIWzh5jA==
X-Received: from wmxa5-n2.prod.google.com ([2002:a05:600d:6445:20b0:480:6b05:6b8e])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:b99:b0:480:1e40:3d2 with SMTP id 5b1f17b1804b1-482db49a4a6mr159401605e9.29.1770033404519;
 Mon, 02 Feb 2026 03:56:44 -0800 (PST)
Date: Mon, 02 Feb 2026 11:56:43 +0000
In-Reply-To: <20260201091318.178710-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260201091318.178710-1-arighi@nvidia.com> <20260201091318.178710-2-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG4GH47JCNH5.36CX78QFOYVS6@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Christian Loehle <christian.loehle@arm.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

Looks good overall, but we need to settle on the global DSQ semantics, plus
some edge cases that need clearing up.

On Sun Feb 1, 2026 at 9:08 AM UTC, Andrea Righi wrote:
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 404fe6126a769..6d9e82e6ca9d4 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -252,6 +252,80 @@ The following briefly shows how a waking task is scheduled and executed.
>  
>     * Queue the task on the BPF side.
>  
> +   **Task State Tracking and ops.dequeue() Semantics**
> +
> +   Once ``ops.select_cpu()`` or ``ops.enqueue()`` is called, the task may
> +   enter the "BPF scheduler's custody" depending on where it's dispatched:
> +
> +   * **Direct dispatch to local DSQs** (``SCX_DSQ_LOCAL`` or
> +     ``SCX_DSQ_LOCAL_ON | cpu``): The task bypasses the BPF scheduler
> +     entirely and goes straight to the CPU's local run queue. The task
> +     never enters BPF custody, and ``ops.dequeue()`` will not be called.
> +
> +   * **Dispatch to non-local DSQs** (``SCX_DSQ_GLOBAL`` or custom DSQs):
> +     the task enters the BPF scheduler's custody. When the task later
> +     leaves BPF custody (dispatched to a local DSQ, picked by core-sched,
> +     or dequeued for sleep/property changes), ``ops.dequeue()`` will be
> +     called exactly once.
> +
> +   * **Queued on BPF side**: The task is in BPF data structures and in BPF
> +     custody, ``ops.dequeue()`` will be called when it leaves.
> +
> +   The key principle: **ops.dequeue() is called when a task leaves the BPF
> +   scheduler's custody**. A task is in BPF custody if it's on a non-local
> +   DSQ or in BPF data structures. Once dispatched to a local DSQ or after
> +   ops.dequeue() is called, the task is out of BPF custody and the BPF
> +   scheduler no longer needs to track it.
> +
> +   This works correctly with the ``ops.select_cpu()`` direct dispatch
> +   optimization: even though it skips ``ops.enqueue()`` invocation, if the
> +   task is dispatched to a non-local DSQ, it enters BPF custody and will
> +   get ``ops.dequeue()`` when it leaves. This provides the performance
> +   benefit of avoiding the ``ops.enqueue()`` roundtrip while maintaining
> +   correct state tracking.
> +
> +   The dequeue can happen for different reasons, distinguished by flags:
> +
> +   1. **Regular dispatch workflow**: when the task is dispatched from a
> +      non-local DSQ to a local DSQ (leaving BPF custody for execution),
> +      ``ops.dequeue()`` is triggered without any special flags.

Maybe add a note that this can happen asynchronously, without the BPF
scheduler explicitly dispatching the task to a local DSQ, when the task
is on a global DSQ? Or maybe make that case into a separate dequeue reason
with its own flag, e.g. SCX_DEQ_PICKED_FROM_GLOBAL_DSQ?

> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index bcb962d5ee7d8..0d003d2845393 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -84,6 +84,7 @@ struct scx_dispatch_q {
>  /* scx_entity.flags */
>  enum scx_ent_flags {
>  	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
> +	SCX_TASK_OPS_ENQUEUED	= 1 << 1, /* under ext scheduler's custody */

Nit: I think "in BPF scheduler's custody" would be a bit clearer, as
"ext scheduler" could potentially be interpreted to mean SCHED_CLASS_EXT
as a whole.

> @@ -1523,6 +1603,30 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  
>  	switch (opss & SCX_OPSS_STATE_MASK) {
>  	case SCX_OPSS_NONE:
> +		/*
> +		 * Task is not in BPF data structures (either dispatched to
> +		 * a DSQ or running). Only call ops.dequeue() if the task
> +		 * is still in BPF scheduler's custody
> +		 * (%SCX_TASK_OPS_ENQUEUED is set).
> +		 *
> +		 * If the task has already been dispatched to a local DSQ
> +		 * (left BPF custody), the flag will be clear and we skip
> +		 * ops.dequeue()
> +		 *
> +		 * If this is a property change (not sleep/core-sched) and
> +		 * the task is still in BPF custody, set the
> +		 * %SCX_DEQ_SCHED_CHANGE flag.
> +		 */
> +		if (SCX_HAS_OP(sch, dequeue) &&
> +		    p->scx.flags & SCX_TASK_OPS_ENQUEUED) {
> +			u64 flags = deq_flags;
> +
> +			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
> +				flags |= SCX_DEQ_SCHED_CHANGE;

I think this logic will result in ops.dequeue(SCHED_CHANGE) being called for
tasks being picked from a global DSQ being migrated from a remote rq to the
local rq, which, while technically correct since the task is migrating rqs,
may be confusing, since it fits two cases in the documentation:

* Since the task is leaving BPF custody for execution, ops.dequeue() should be
  called without any special flags.
* Since the task is being migrated between rqs, ops.dequeue() should be called
  with SCX_DEQ_SCHED_CHANGE.

> +
> +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
> +			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> +		}
>  		break;
>  	case SCX_OPSS_QUEUEING:
>  		/*

Thanks,
Kuba

