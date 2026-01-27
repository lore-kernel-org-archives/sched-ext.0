Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34821CC7B
	for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531930; cv=none; b=uIJ8rc3Z+aAT0oPzpBrFTNAai8YcXLeRvCyVHjfdq/lUIcYhh6eVj5QI3pZCeJvZ+GgXVb93qeFY2omxbLlsgJEQ1H0EAjrLZ/V3/x3OIn4dBtyP3eyLiNHHAl0MbgkeYYzUYWT65GX66b2fT9uSXwZyxrUMjtSPu5Ypn4qYmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531930; c=relaxed/simple;
	bh=iy8YSUUuj12ts6CJX/cnVDbJ+7JsvT0cyk71Wn7pFWE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SE/ojSHjXVm7/ngQJDrN4hmR9k5+jjVuuA2QFgRRPzs5r8Fqg6BZH3wWG9FR7yg1SJy/bVwfjCwIIHZKnC/rWGkr8NBxSsc0SJCLWHeC7t/sk4ZrbmPTqeDrAufTJV+S/aKpktvpKyD1UTghtgbW2SydZtcg2VMOBuBC2jzbL0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=chwcmjR8; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="chwcmjR8"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88fca7bce90so94307536d6.3
        for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 08:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769531927; x=1770136727; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjaYCXUm+6+i5enNnm03i5yaG37SUIfrjyDNDrH3Dzo=;
        b=chwcmjR8pwkyQnSU/gPrrKZiC/S5nKmqBifMbEPfNmeWpDFpYLAwUDZE7Ju+xr37In
         f+PWrMAaEwKwbfdZ/j1h7tWbdv7GjHIhW5PwHmskoCChzlUtkXjFsUZRZfjiwj3SPesI
         N+HUS+kGJQXC6UOl+Cxc4MkIgkZcdyHvUn00LuXt4flpLNsv6ZnWCQKbu36yEdsceDmP
         w5IlUlF+J3L2gGLj4BJafFas2A+tzW3Mr50GGiCMcaCoRUTmwvm2AFBswmcTsGF5nFF/
         3pFbtUH95uWYcMPXOVwlKKsd+QbgVktXPZdHwp+lSPcU7RdOjbii8RVrV4XixnyldtV/
         sCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769531927; x=1770136727;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TjaYCXUm+6+i5enNnm03i5yaG37SUIfrjyDNDrH3Dzo=;
        b=joTDwmSwjbscbhzBDIYNwZgrA6GVGzBFwPun9z13w2fYQRMpUOrEIiiE0VbsGZ5aKZ
         bKThl4ZcH6LXJmHy4brzJSyAEiZSv53BZM0bv7bFAH1XN0/cVO7eMp7ANMkAVnBj8e7C
         pzPL14JbUEmZuCTIbmSJF2inrIH5zdOy+MNYkjoAleTDoUO0NwZTa8lbTRJL7QxFYppk
         5ykgEyCpmmCAJFtUOxbV/vR4O4gyXragXllNGQ9AbCb2079nUmKbXNKIAIhy/mv0rm7P
         OdQGwI9Se5Jcm4rQ+DSvJXxGO0CKboAAOolnfvI/E54+1pa/BwUwt0F0sUM48Z3VA+3f
         piEA==
X-Forwarded-Encrypted: i=1; AJvYcCXUa268ooDZqC47bXoXW/CpjB6Pj/wFuhKJqJDSR1XRAkcmjjL0ImImExQXkZSsREiqerC5f/RfcH0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1NEKgd0bvnQ0jAzAa0WJuQ3cuYPjLdWXusKjkp5vg9EerDifo
	oE5HQsQGN+KE1VwBqSFGDR4pj79PKVe/Rq1q9kcB8fJhkXusyMbMXxEm3oTP8Y9Q02U=
X-Gm-Gg: AZuq6aLStNL51rRdTfQvDL4p6ZojQJEIRtfS7eY3ldRj6OGlOW7tN6uxifmYPCDimtZ
	Ap9s13I+3pKQNBryHTJdYdxvfuZC2TTl8UOUiADKnR/AtnKrT/TLgXNGcQFIukCrf8scnGSAiDc
	+/NYB24gEcrSduL2cJO7mGpe71iyq4TpMKp2H+ieHsfGkAJAEAxq+2yWEagKW4od9t4XBLSQ8Nt
	IJhrbhpTBlJtHYtLNfA0eYKgaB+0LXCBZHEkYZFUZfO0nkF0/HRCXHmGXnczlK+mFVmpvc+4h9x
	pEvIG+BDFwyOKVBTNbTtiiDipeTOpKEoTiLOd8oIOD0H6FPXNFazppF8ITtmskwfB3WxZmyFZAr
	BGiQgfWsKMlolgegGMKP5deHrPcTWRdBzYfseaEObE1lnBTvTnoSsXJGgbYcjJxoNnUgFPcJ8bs
	nEfNpDyNFDuJA=
X-Received: by 2002:a05:6214:c82:b0:793:dce5:4540 with SMTP id 6a1803df08f44-894cc7e8b3amr35003896d6.2.1769531927051;
        Tue, 27 Jan 2026 08:38:47 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376da66sm250526d6.50.2026.01.27.08.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 08:38:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 11:38:45 -0500
Message-Id: <DFZIPS61X370.20SGA6J8WB9YW@etsalapatis.com>
Cc: "Kuba Piecuch" <jpiecuch@google.com>, "Christian Loehle"
 <christian.loehle@arm.com>, "Daniel Hodges" <hodgesd@meta.com>,
 <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>, "Tejun Heo" <tj@kernel.org>, "David
 Vernet" <void@manifault.com>, "Changwoo Min" <changwoo@igalia.com>
X-Mailer: aerc 0.20.1
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-2-arighi@nvidia.com>
In-Reply-To: <20260126084258.3798129-2-arighi@nvidia.com>

On Mon Jan 26, 2026 at 3:41 AM EST, Andrea Righi wrote:
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
> corresponding ops.dequeue(), and introduce the %SCX_DEQ_SCHED_CHANGE
> flag to distinguish dequeues triggered by scheduling property changes
> from those occurring in the normal dispatch/execution workflow.
>
> New semantics:
> 1. ops.enqueue() is called when a task enters the BPF scheduler
> 2. ops.dequeue() is called when the task leaves the BPF scheduler in
>    the following cases:
>    a) regular dispatch workflow: task dispatched to a DSQ,
>    b) core scheduling pick: core-sched picks task before dispatch,
>    c) property change: task properties modified.
>
> A new %SCX_DEQ_SCHED_CHANGE flag is also introduced, allowing BPF
> schedulers to distinguish between:
> - normal dispatch/execution workflow (dispatch, core-sched pick),
> - property changes that require state updates (e.g.,
>   sched_setaffinity(), sched_setscheduler(), set_user_nice(),
>   NUMA balancing, CPU migrations, etc.).
>
> With this, BPF schedulers can:
> - reliably track task ownership and lifecycle,
> - maintain accurate accounting of enqueue/dequeue pairs,
> - distinguish between execution events and property changes,
> - update internal state appropriately for each dequeue type.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Emil Tsalapatis <emil@etsalapatis.com>
> Cc: Kuba Piecuch <jpiecuch@google.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Looks great overall. Following up on our off-list chat about whether=20
SCX_TASK_DISPATCH_DEQUEUED is necessary: We need it for the new DEQ_STATE
change flag so no need to consider removing it imo.

> ---
>  Documentation/scheduler/sched-ext.rst         | 33 +++++++
>  include/linux/sched/ext.h                     | 11 +++
>  kernel/sched/ext.c                            | 89 ++++++++++++++++++-
>  kernel/sched/ext_internal.h                   |  7 ++
>  .../sched_ext/include/scx/enum_defs.autogen.h |  2 +
>  .../sched_ext/include/scx/enums.autogen.bpf.h |  2 +
>  tools/sched_ext/include/scx/enums.autogen.h   |  1 +
>  7 files changed, 142 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/schedu=
ler/sched-ext.rst
> index 404fe6126a769..ed6bf7d9e6e8c 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -252,6 +252,37 @@ The following briefly shows how a waking task is sch=
eduled and executed.
> =20
>     * Queue the task on the BPF side.
> =20
> +   Once ``ops.enqueue()`` is called, the task enters the "enqueued state=
".
> +   The task remains in this state until ``ops.dequeue()`` is called, whi=
ch
> +   happens in the following cases:
> +
> +   1. **Regular dispatch workflow**: when the task is successfully
> +      dispatched to a DSQ (local, global, or user DSQ), ``ops.dequeue()`=
`
> +      is triggered immediately to notify the BPF scheduler.
> +
> +   2. **Core scheduling pick**: when ``CONFIG_SCHED_CORE`` is enabled an=
d
> +      core scheduling picks a task for execution before it has been
> +      dispatched, ``ops.dequeue()`` is called with the
> +      ``SCX_DEQ_CORE_SCHED_EXEC`` flag.
> +
> +   3. **Scheduling property change**: when a task property changes (via
> +      operations like ``sched_setaffinity()``, ``sched_setscheduler()``,
> +      priority changes, CPU migrations, etc.), ``ops.dequeue()`` is call=
ed
> +      with the ``SCX_DEQ_SCHED_CHANGE`` flag set in ``deq_flags``.
> +
> +   **Important**: ``ops.dequeue()`` is called for *any* enqueued task,
> +   regardless of whether the task is still on a BPF data structure, or i=
t
> +   has already been dispatched to a DSQ. This guarantees that every
> +   ``ops.enqueue()`` will eventually be followed by a corresponding
> +   ``ops.dequeue()``.
> +
> +   This makes it reliable for BPF schedulers to track the enqueued state
> +   and maintain accurate accounting.
> +
> +   BPF schedulers can choose not to implement ``ops.dequeue()`` if they
> +   don't need to track these transitions. The sched_ext core will safely
> +   handle all dequeue operations regardless.
> +
>  3. When a CPU is ready to schedule, it first looks at its local DSQ. If
>     empty, it then looks at the global DSQ. If there still isn't a task t=
o
>     run, ``ops.dispatch()`` is invoked which can use the following two
> @@ -319,6 +350,8 @@ by a sched_ext scheduler:
>                  /* Any usable CPU becomes available */
> =20
>                  ops.dispatch(); /* Task is moved to a local DSQ */
> +
> +                ops.dequeue(); /* Exiting BPF scheduler */
>              }
>              ops.running();      /* Task starts running on its assigned C=
PU */
>              while (task->scx.slice > 0 && task is runnable)
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index bcb962d5ee7d8..59446cd0373fa 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -84,8 +84,19 @@ struct scx_dispatch_q {
>  /* scx_entity.flags */
>  enum scx_ent_flags {
>  	SCX_TASK_QUEUED		=3D 1 << 0, /* on ext runqueue */
> +	/*
> +	 * Set when ops.enqueue() is called; used to determine if ops.dequeue()
> +	 * should be invoked when transitioning out of SCX_OPSS_NONE state.
> +	 */
> +	SCX_TASK_OPS_ENQUEUED	=3D 1 << 1,
>  	SCX_TASK_RESET_RUNNABLE_AT =3D 1 << 2, /* runnable_at should be reset *=
/
>  	SCX_TASK_DEQD_FOR_SLEEP	=3D 1 << 3, /* last dequeue was for SLEEP */
> +	/*
> +	 * Set when ops.dequeue() is called after successful dispatch; used to
> +	 * distinguish dispatch dequeues from property change dequeues and
> +	 * prevent duplicate dequeue calls.
> +	 */
> +	SCX_TASK_DISPATCH_DEQUEUED =3D 1 << 4,
> =20
>  	SCX_TASK_STATE_SHIFT	=3D 8,	  /* bit 8 and 9 are used to carry scx_task=
_state */
>  	SCX_TASK_STATE_BITS	=3D 2,
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index afe28c04d5aa7..18bca2b83f5c5 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1287,6 +1287,20 @@ static void direct_dispatch(struct scx_sched *sch,=
 struct task_struct *p,
> =20
>  	p->scx.ddsp_enq_flags |=3D enq_flags;
> =20
> +	/*
> +	 * The task is about to be dispatched. If ops.enqueue() was called,
> +	 * notify the BPF scheduler by calling ops.dequeue().
> +	 *
> +	 * Keep %SCX_TASK_OPS_ENQUEUED set so that subsequent property
> +	 * changes can trigger ops.dequeue() with %SCX_DEQ_SCHED_CHANGE.
> +	 * Mark that the dispatch dequeue has been called to distinguish
> +	 * from property change dequeues.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED))=
 {
> +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
> +		p->scx.flags |=3D SCX_TASK_DISPATCH_DEQUEUED;
> +	}
> +
>  	/*
>  	 * We are in the enqueue path with @rq locked and pinned, and thus can'=
t
>  	 * double lock a remote rq and enqueue to its local DSQ. For
> @@ -1391,6 +1405,16 @@ static void do_enqueue_task(struct rq *rq, struct =
task_struct *p, u64 enq_flags,
>  	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) !=3D SCX_OPSS_NONE);
>  	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
> =20
> +	/*
> +	 * Mark that ops.enqueue() is being called for this task.
> +	 * Clear the dispatch dequeue flag for the new enqueue cycle.
> +	 * Only track these flags if ops.dequeue() is implemented.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue)) {
> +		p->scx.flags |=3D SCX_TASK_OPS_ENQUEUED;
> +		p->scx.flags &=3D ~SCX_TASK_DISPATCH_DEQUEUED;
> +	}
> +
>  	ddsp_taskp =3D this_cpu_ptr(&direct_dispatch_task);
>  	WARN_ON_ONCE(*ddsp_taskp);
>  	*ddsp_taskp =3D p;
> @@ -1523,6 +1547,34 @@ static void ops_dequeue(struct rq *rq, struct task=
_struct *p, u64 deq_flags)
> =20
>  	switch (opss & SCX_OPSS_STATE_MASK) {
>  	case SCX_OPSS_NONE:
> +		if (SCX_HAS_OP(sch, dequeue) &&
> +		    p->scx.flags & SCX_TASK_OPS_ENQUEUED) {
> +			/*
> +			 * Task was already dispatched. Only call ops.dequeue()
> +			 * if it hasn't been called yet (check DISPATCH_DEQUEUED).
> +			 * This can happen when:
> +			 * 1. Core-sched picks a task that was dispatched
> +			 * 2. Property changes occur after dispatch
> +			 */
> +			if (!(p->scx.flags & SCX_TASK_DISPATCH_DEQUEUED)) {
> +				/*
> +				 * ops.dequeue() wasn't called during dispatch.
> +				 * This shouldn't normally happen, but call it now.
> +				 */
> +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> +						 p, deq_flags);
> +			} else if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC))) =
{
> +				/*
> +				 * This is a property change after
> +				 * dispatch. Call ops.dequeue() again with
> +				 * %SCX_DEQ_SCHED_CHANGE.
> +				 */
> +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> +						 p, deq_flags | SCX_DEQ_SCHED_CHANGE);
> +			}
> +			p->scx.flags &=3D ~(SCX_TASK_OPS_ENQUEUED |
> +					  SCX_TASK_DISPATCH_DEQUEUED);
> +		}
>  		break;
>  	case SCX_OPSS_QUEUEING:
>  		/*
> @@ -1531,9 +1583,24 @@ static void ops_dequeue(struct rq *rq, struct task=
_struct *p, u64 deq_flags)
>  		 */
>  		BUG();
>  	case SCX_OPSS_QUEUED:
> -		if (SCX_HAS_OP(sch, dequeue))
> -			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> -					 p, deq_flags);
> +		/*
> +		 * Task is still on the BPF scheduler (not dispatched yet).
> +		 * Call ops.dequeue() to notify. Add %SCX_DEQ_SCHED_CHANGE
> +		 * only for property changes, not for core-sched picks.
> +		 */
> +		if (SCX_HAS_OP(sch, dequeue)) {
> +			u64 flags =3D deq_flags;
> +			/*
> +			 * Add %SCX_DEQ_SCHED_CHANGE for property changes,
> +			 * but not for core-sched picks or sleep.
> +			 */
> +			if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
> +				flags |=3D SCX_DEQ_SCHED_CHANGE;
> +
> +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
> +			p->scx.flags &=3D ~(SCX_TASK_OPS_ENQUEUED |
> +					  SCX_TASK_DISPATCH_DEQUEUED);
> +		}
> =20
>  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>  					    SCX_OPSS_NONE))
> @@ -2107,6 +2174,22 @@ static void finish_dispatch(struct scx_sched *sch,=
 struct rq *rq,
> =20
>  	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
> =20
> +	/*
> +	 * The task is about to be dispatched. If ops.enqueue() was called,
> +	 * notify the BPF scheduler by calling ops.dequeue().
> +	 *
> +	 * Keep %SCX_TASK_OPS_ENQUEUED set so that subsequent property
> +	 * changes can trigger ops.dequeue() with %SCX_DEQ_SCHED_CHANGE.
> +	 * Mark that the dispatch dequeue has been called to distinguish
> +	 * from property change dequeues.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_OPS_ENQUEUED))=
 {
> +		struct rq *task_rq =3D task_rq(p);
> +
> +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, task_rq, p, 0);
> +		p->scx.flags |=3D SCX_TASK_DISPATCH_DEQUEUED;
> +	}
> +
>  	dsq =3D find_dsq_for_dispatch(sch, this_rq(), dsq_id, p);
> =20
>  	if (dsq->id =3D=3D SCX_DSQ_LOCAL)
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 386c677e4c9a0..befa9a5d6e53f 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -982,6 +982,13 @@ enum scx_deq_flags {
>  	 * it hasn't been dispatched yet. Dequeue from the BPF side.
>  	 */
>  	SCX_DEQ_CORE_SCHED_EXEC	=3D 1LLU << 32,
> +
> +	/*
> +	 * The task is being dequeued due to a property change (e.g.,
> +	 * sched_setaffinity(), sched_setscheduler(), set_user_nice(),
> +	 * etc.).
> +	 */
> +	SCX_DEQ_SCHED_CHANGE	=3D 1LLU << 33,
>  };
> =20
>  enum scx_pick_idle_cpu_flags {
> diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sche=
d_ext/include/scx/enum_defs.autogen.h
> index c2c33df9292c2..8284f717ff05e 100644
> --- a/tools/sched_ext/include/scx/enum_defs.autogen.h
> +++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
> @@ -21,6 +21,7 @@
>  #define HAVE_SCX_CPU_PREEMPT_UNKNOWN
>  #define HAVE_SCX_DEQ_SLEEP
>  #define HAVE_SCX_DEQ_CORE_SCHED_EXEC
> +#define HAVE_SCX_DEQ_SCHED_CHANGE
>  #define HAVE_SCX_DSQ_FLAG_BUILTIN
>  #define HAVE_SCX_DSQ_FLAG_LOCAL_ON
>  #define HAVE_SCX_DSQ_INVALID
> @@ -48,6 +49,7 @@
>  #define HAVE_SCX_TASK_QUEUED
>  #define HAVE_SCX_TASK_RESET_RUNNABLE_AT
>  #define HAVE_SCX_TASK_DEQD_FOR_SLEEP
> +#define HAVE_SCX_TASK_DISPATCH_DEQUEUED
>  #define HAVE_SCX_TASK_STATE_SHIFT
>  #define HAVE_SCX_TASK_STATE_BITS
>  #define HAVE_SCX_TASK_STATE_MASK
> diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sche=
d_ext/include/scx/enums.autogen.bpf.h
> index 2f8002bcc19ad..5da50f9376844 100644
> --- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
> +++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
> @@ -127,3 +127,5 @@ const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
>  const volatile u64 __SCX_ENQ_DSQ_PRIQ __weak;
>  #define SCX_ENQ_DSQ_PRIQ __SCX_ENQ_DSQ_PRIQ
> =20
> +const volatile u64 __SCX_DEQ_SCHED_CHANGE __weak;
> +#define SCX_DEQ_SCHED_CHANGE __SCX_DEQ_SCHED_CHANGE
> diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ex=
t/include/scx/enums.autogen.h
> index fedec938584be..fc9a7a4d9dea5 100644
> --- a/tools/sched_ext/include/scx/enums.autogen.h
> +++ b/tools/sched_ext/include/scx/enums.autogen.h
> @@ -46,4 +46,5 @@
>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
> +	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
>  } while (0)

