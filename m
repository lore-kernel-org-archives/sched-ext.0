Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747923B62B
	for <sched-ext@lists.linux.dev>; Fri,  6 Feb 2026 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410137; cv=none; b=WJU+8FIIvSQw1i8W9Pwif1J4osaQAXi0bAMuXm3KYlqIlYjkVnhHjSCo09cireMSOtjZOrDvQ05ctJQQCg+ozzJtcmwRYDGym3RtE8q32FGKPqMMKPJ9eS6tpX+z5X5YVJMf3jGgDLmjjx3YeYcXlS/yPkj0ZDqzbkRaUQPL4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410137; c=relaxed/simple;
	bh=3kTZKn9B8kBn1liPMZZEIZII4l+0ndbmQDoWIDTEmQg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gVw04YA8zPKVGR028Aeri4PzBGRnXhTV87IjoJmjRh+/5cE7rV12YmyFk4QCDFpJUCKSk4f6xEAxTAQqTFAXgdMvzQxZ/HyphyI56W3HlSNqbwWA+INsGwfJ4+/312TD1a8DDfKcK8oSuvJLWOtciJQTxUErwlTMM00YX8AbZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=TJsSesWM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="TJsSesWM"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-894676e6863so27676876d6.2
        for <sched-ext@lists.linux.dev>; Fri, 06 Feb 2026 12:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770410136; x=1771014936; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unYB2rIEAW9rlnfxUIn2GgKSP8WoJ45ur/Fwo5yvoLE=;
        b=TJsSesWM+kH+Fz+2XhFsApPJRj25729sRtbxGG4QbJWDTV3acc01hDxCJQ7SfbnTBV
         2A5qHdkaZeYKSDtRsox22mHpES5HbvwPJUcuC0Lj6Yi/CretflKOb1SVLyikfJxlT8cu
         id/JNrsCFwbrBVkblMkoxUa+W4c9izBIv6do9DE7wMRJTcsympcQdD7YWxBCF262NrC3
         oRavzCqM4VHZ2hrLOD7qAccAZJux4ZN4m5zIOohjTsMvkKnLkLk8gbHxTum9yy4sxv15
         7kM/Z/TrgCFIW5/Y/9YFQIIBUy30ChD1UqufJCBlY6zppAM3ru/pN/aVm7VhQ1JMgg8a
         0R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770410136; x=1771014936;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unYB2rIEAW9rlnfxUIn2GgKSP8WoJ45ur/Fwo5yvoLE=;
        b=csWZZUy+iZ62A6ArXGJ0nauXbXQ2iycFBqavoZlgDn34C1FdCyU/J6vjy222mgvlY2
         ncDXufaacA2Sg5rUaDgqHOaAL2a4+oJ7CsftqyWWKlC2unKhMTdPtc+cRiG34cmpW885
         QZgR95zWb1Zf0+NSLdg1BH0C4x0EmNlO5wZ+9IsvB6/tZW2F9FrmSdRm/rSlgpLmwSRb
         /mWlo1vwu3t8ZRlIqDvDDhfMNyFO77yHq8kCILxm0j12U457rrgPL7CyxKJRvswi95n7
         +1ebzU9j31gkCfOEfD2StzquCfOk21jghm2jMOMpDSVxSp94o41dBRFvpc1YIrxjzdmc
         f52A==
X-Forwarded-Encrypted: i=1; AJvYcCX35enTQBldECfinQf0C8Y4BptioNZTSp6lhYOIHRZo0PQyjm1jkFYSEsDY9G0zA5X4DQ90xPoErH4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyskcJPDRozXLO4bicP3SWSn9qqhxMyDMuxBKntcV2qA76xUtjU
	AVvaEJKLGdKfOvqf1VbdmRtJ00Pl4oHMkPeChCex02KT+i5GBUOcHBgQvILd0zIiH2o=
X-Gm-Gg: AZuq6aJ+KkUVpgxOPBnvVFRFBJsOR1OUjsD8o2+3hwMZfb2iq7hBMrUwD+WobcRhIdi
	Exha6A5VsXUTUeOhfIy9Nv/EpyVIPdCCJUe488K59vHiVY1deDTNEZRLBBFgdRSQFw+pDFWCwte
	U/gEmld5UB3u4MVubntjS03Zqe24DmmHJNG92GOxDRm3/e45xAvLXlZkwnz7bHPlj3Xog7cN086
	Vtn0a7Mv5HRG7RiT044+/MR/IBnP0yI3ioLLz0mAxRIWouAuysQN74c8sNDry/g27ueKYImuC+m
	w3N/KaebnZ9C65JW+Hir0Qf4yyO9PDx2Z8723Yj3l1UW8gVDwqp43lQXg4DziqXkb5t5KZKhtnW
	TsYRrvuxE8smWU91I0IsoGUpL55fIbnRUyJ9ESkk2tygqBhazNRo4aRb/YYEvOv9pEc8S1coj2q
	OWIzkHagjZB+o=
X-Received: by 2002:a05:6214:1cc9:b0:894:71b0:6afd with SMTP id 6a1803df08f44-8953cd83f7bmr60876816d6.59.1770410136442;
        Fri, 06 Feb 2026 12:35:36 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf35102sm25270486d6.10.2026.02.06.12.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 12:35:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 15:35:34 -0500
Message-Id: <DG860JW64VVD.31BS2QTEB8XZQ@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>, "Tejun Heo" <tj@kernel.org>, "David
 Vernet" <void@manifault.com>, "Changwoo Min" <changwoo@igalia.com>
Cc: "Kuba Piecuch" <jpiecuch@google.com>, "Christian Loehle"
 <christian.loehle@arm.com>, "Daniel Hodges" <hodgesd@meta.com>,
 <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
X-Mailer: aerc 0.20.1
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-2-arighi@nvidia.com>
In-Reply-To: <20260206135742.2339918-2-arighi@nvidia.com>

On Fri Feb 6, 2026 at 8:54 AM EST, Andrea Righi wrote:
> Currently, ops.dequeue() is only invoked when the sched_ext core knows
> that a task resides in BPF-managed data structures, which causes it to
> miss scheduling property change events. In addition, ops.dequeue()
> callbacks are completely skipped when tasks are dispatched to non-local
> DSQs from ops.select_cpu(). As a result, BPF schedulers cannot reliably
> track task state.
>
> Fix this by guaranteeing that each task entering the BPF scheduler's
> custody triggers exactly one ops.dequeue() call when it leaves that
> custody, whether the exit is due to a dispatch (regular or via a core
> scheduling pick) or to a scheduling property change (e.g.
> sched_setaffinity(), sched_setscheduler(), set_user_nice(), NUMA
> balancing, etc.).
>
> BPF scheduler custody concept: a task is considered to be in the BPF
> scheduler's custody when the scheduler is responsible for managing its
> lifecycle. This includes tasks dispatched to user-created DSQs or stored
> in the BPF scheduler's internal data structures. Custody ends when the
> task is dispatched to a terminal DSQ (such as the local DSQ or
> %SCX_DSQ_GLOBAL), selected by core scheduling, or removed due to a
> property change.
>
> Tasks directly dispatched to terminal DSQs bypass the BPF scheduler
> entirely and are never in its custody. Terminal DSQs include:
>  - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
>    where tasks go directly to execution.
>  - Global DSQ (%SCX_DSQ_GLOBAL): the built-in fallback queue where the
>    BPF scheduler is considered "done" with the task.
>
> As a result, ops.dequeue() is not invoked for tasks directly dispatched
> to terminal DSQs.
>
> To identify dequeues triggered by scheduling property changes, introduce
> the new ops.dequeue() flag %SCX_DEQ_SCHED_CHANGE: when this flag is set,
> the dequeue was caused by a scheduling property change.
>
> New ops.dequeue() semantics:
>  - ops.dequeue() is invoked exactly once when the task leaves the BPF
>    scheduler's custody, in one of the following cases:
>    a) regular dispatch: a task dispatched to a user DSQ or stored in
>       internal BPF data structures is moved to a terminal DSQ
>       (ops.dequeue() called without any special flags set),
>    b) core scheduling dispatch: core-sched picks task before dispatch
>       (ops.dequeue() called with %SCX_DEQ_CORE_SCHED_EXEC flag set),
>    c) property change: task properties modified before dispatch,
>       (ops.dequeue() called with %SCX_DEQ_SCHED_CHANGE flag set).
>
> This allows BPF schedulers to:
>  - reliably track task ownership and lifecycle,
>  - maintain accurate accounting of managed tasks,
>  - update internal state when tasks change properties.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Emil Tsalapatis <emil@etsalapatis.com>
> Cc: Kuba Piecuch <jpiecuch@google.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

Hi Andrea,

>  Documentation/scheduler/sched-ext.rst         |  58 +++++++
>  include/linux/sched/ext.h                     |   1 +
>  kernel/sched/ext.c                            | 157 ++++++++++++++++--
>  kernel/sched/ext_internal.h                   |   7 +
>  .../sched_ext/include/scx/enum_defs.autogen.h |   1 +
>  .../sched_ext/include/scx/enums.autogen.bpf.h |   2 +
>  tools/sched_ext/include/scx/enums.autogen.h   |   1 +
>  7 files changed, 213 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/schedu=
ler/sched-ext.rst
> index 404fe6126a769..fe8c59b0c1477 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -252,6 +252,62 @@ The following briefly shows how a waking task is sch=
eduled and executed.
> =20
>     * Queue the task on the BPF side.
> =20
> +   **Task State Tracking and ops.dequeue() Semantics**
> +
> +   A task is in the "BPF scheduler's custody" when the BPF scheduler is
> +   responsible for managing its lifecycle. That includes tasks dispatche=
d
> +   to user-created DSQs or stored in the BPF scheduler's internal data
> +   structures. Once ``ops.select_cpu()`` or ``ops.enqueue()`` is called,
> +   the task may or may not enter custody depending on what the scheduler
> +   does:
> +
> +   * **Directly dispatched to terminal DSQs** (``SCX_DSQ_LOCAL``,
> +     ``SCX_DSQ_LOCAL_ON | cpu``, or ``SCX_DSQ_GLOBAL``): The BPF schedul=
er
> +     is done with the task - it either goes straight to a CPU's local ru=
n
> +     queue or to the global DSQ as a fallback. The task never enters (or
> +     exits) BPF custody, and ``ops.dequeue()`` will not be called.
> +
> +   * **Dispatch to user-created DSQs** (custom DSQs): the task enters th=
e
> +     BPF scheduler's custody. When the task later leaves BPF custody
> +     (dispatched to a terminal DSQ, picked by core-sched, or dequeued fo=
r
> +     sleep/property changes), ``ops.dequeue()`` will be called exactly o=
nce.
> +
> +   * **Queued on BPF side** (e.g., internal queues, no DSQ): The task is=
 in
> +     BPF custody. ``ops.dequeue()`` will be called when it leaves (e.g.
> +     when ``ops.dispatch()`` moves it to a terminal DSQ, or on property
> +     change / sleep).
> +
> +   **NOTE**: this concept is valid also with the ``ops.select_cpu()``
> +   direct dispatch optimization. Even though it skips ``ops.enqueue()``
> +   invocation, if the task is dispatched to a user-created DSQ or intern=
al
> +   BPF structure, it enters BPF custody and will get ``ops.dequeue()`` w=
hen
> +   it leaves. If dispatched to a terminal DSQ, the BPF scheduler is done
> +   with it immediately. This provides the performance benefit of avoidin=
g
> +   the ``ops.enqueue()`` roundtrip while maintaining correct state
> +   tracking.
> +
> +   The dequeue can happen for different reasons, distinguished by flags:
> +
> +   1. **Regular dispatch**: when a task in BPF custody is dispatched to =
a
> +      terminal DSQ from ``ops.dispatch()`` (leaving BPF custody for
> +      execution), ``ops.dequeue()`` is triggered without any special fla=
gs.
> +
> +   2. **Core scheduling pick**: when ``CONFIG_SCHED_CORE`` is enabled an=
d
> +      core scheduling picks a task for execution while it's still in BPF
> +      custody, ``ops.dequeue()`` is called with the
> +      ``SCX_DEQ_CORE_SCHED_EXEC`` flag.
> +
> +   3. **Scheduling property change**: when a task property changes (via
> +      operations like ``sched_setaffinity()``, ``sched_setscheduler()``,
> +      priority changes, CPU migrations, etc.) while the task is still in
> +      BPF custody, ``ops.dequeue()`` is called with the
> +      ``SCX_DEQ_SCHED_CHANGE`` flag set in ``deq_flags``.
> +
> +   **Important**: Once a task has left BPF custody (e.g. after being
> +   dispatched to a terminal DSQ), property changes will not trigger
> +   ``ops.dequeue()``, since the task is no longer being managed by the B=
PF
> +   scheduler.
> +
>  3. When a CPU is ready to schedule, it first looks at its local DSQ. If
>     empty, it then looks at the global DSQ. If there still isn't a task t=
o
>     run, ``ops.dispatch()`` is invoked which can use the following two
> @@ -319,6 +375,8 @@ by a sched_ext scheduler:
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
> index bcb962d5ee7d8..c48f818eee9b8 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -84,6 +84,7 @@ struct scx_dispatch_q {
>  /* scx_entity.flags */
>  enum scx_ent_flags {
>  	SCX_TASK_QUEUED		=3D 1 << 0, /* on ext runqueue */
> +	SCX_TASK_NEED_DEQ	=3D 1 << 1, /* in BPF custody, needs ops.dequeue() wh=
en leaving */

Can we make this "SCX_TASK_IN_BPF"? Since we've now defined what it means t=
o be
in BPF custody vs the core scx scheduler (terminal DSQs) this is a more
general property that can be useful to check in the future. An example:
We can now assert that a task's BPF state is consistent with its actual=20
kernel state when using BPF-based data structures to manage tasks.

>  	SCX_TASK_RESET_RUNNABLE_AT =3D 1 << 2, /* runnable_at should be reset *=
/
>  	SCX_TASK_DEQD_FOR_SLEEP	=3D 1 << 3, /* last dequeue was for SLEEP */
> =20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 0bb8fa927e9e9..d17fd9141adf4 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -925,6 +925,27 @@ static void touch_core_sched(struct rq *rq, struct t=
ask_struct *p)
>  #endif
>  }
> =20
> +/**
> + * is_terminal_dsq - Check if a DSQ is terminal for ops.dequeue() purpos=
es
> + * @dsq_id: DSQ ID to check
> + *
> + * Returns true if @dsq_id is a terminal/builtin DSQ where the BPF
> + * scheduler is considered "done" with the task.
> + *
> + * Builtin DSQs include:
> + *  - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON): per-CPU queues
> + *    where tasks go directly to execution,
> + *  - Global DSQ (%SCX_DSQ_GLOBAL): built-in fallback queue,
> + *  - Bypass DSQ: used during bypass mode.
> + *
> + * Tasks dispatched to builtin DSQs exit BPF scheduler custody and do no=
t
> + * trigger ops.dequeue() when they are later consumed.
> + */
> +static inline bool is_terminal_dsq(u64 dsq_id)
> +{
> +	return dsq_id & SCX_DSQ_FLAG_BUILTIN;
> +}
> +
>  /**
>   * touch_core_sched_dispatch - Update core-sched timestamp on dispatch
>   * @rq: rq to read clock from, must be locked
> @@ -1008,7 +1029,8 @@ static void local_dsq_post_enq(struct scx_dispatch_=
q *dsq, struct task_struct *p
>  		resched_curr(rq);
>  }
> =20
> -static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_=
q *dsq,
> +static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
> +			     struct scx_dispatch_q *dsq,
>  			     struct task_struct *p, u64 enq_flags)
>  {
>  	bool is_local =3D dsq->id =3D=3D SCX_DSQ_LOCAL;
> @@ -1103,6 +1125,27 @@ static void dispatch_enqueue(struct scx_sched *sch=
, struct scx_dispatch_q *dsq,
>  	dsq_mod_nr(dsq, 1);
>  	p->scx.dsq =3D dsq;
> =20
> +	/*
> +	 * Handle ops.dequeue() and custody tracking.
> +	 *
> +	 * Builtin DSQs (local, global, bypass) are terminal: the BPF
> +	 * scheduler is done with the task. If it was in BPF custody, call
> +	 * ops.dequeue() and clear the flag.
> +	 *
> +	 * User DSQs: Task is in BPF scheduler's custody. Set the flag so
> +	 * ops.dequeue() will be called when it leaves.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue)) {
> +		if (is_terminal_dsq(dsq->id)) {
> +			if (p->scx.flags & SCX_TASK_NEED_DEQ)
> +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue,
> +						 rq, p, 0);
> +			p->scx.flags &=3D ~SCX_TASK_NEED_DEQ;
> +		} else {
> +			p->scx.flags |=3D SCX_TASK_NEED_DEQ;
> +		}
> +	}
> +
>  	/*
>  	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
>  	 * direct dispatch path, but we clear them here because the direct
> @@ -1323,7 +1366,7 @@ static void direct_dispatch(struct scx_sched *sch, =
struct task_struct *p,
>  		return;
>  	}
> =20
> -	dispatch_enqueue(sch, dsq, p,
> +	dispatch_enqueue(sch, rq, dsq, p,
>  			 p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
>  }
> =20
> @@ -1407,13 +1450,22 @@ static void do_enqueue_task(struct rq *rq, struct=
 task_struct *p, u64 enq_flags,
>  	 * dequeue may be waiting. The store_release matches their load_acquire=
.
>  	 */
>  	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED | qseq);
> +
> +	/*
> +	 * Task is now in BPF scheduler's custody (queued on BPF internal
> +	 * structures). Set %SCX_TASK_NEED_DEQ so ops.dequeue() is called
> +	 * when it leaves custody (e.g. dispatched to a terminal DSQ or on
> +	 * property change).
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue))

Related to the rename: Can we remove the guards and track the flag
regardless of whether ops.dequeue() is present?

There is no reason not to track whether a task is in BPF or the core,=20
and it is a property that's independent of whether we implement ops.dequeue=
().=20
This also simplifies the code since we now just guard the actual ops.dequeu=
e()
call.

> +		p->scx.flags |=3D SCX_TASK_NEED_DEQ;
>  	return;
> =20
>  direct:
>  	direct_dispatch(sch, p, enq_flags);
>  	return;
>  local_norefill:
> -	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
> +	dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, enq_flags);
>  	return;
>  local:
>  	dsq =3D &rq->scx.local_dsq;
> @@ -1433,7 +1485,7 @@ static void do_enqueue_task(struct rq *rq, struct t=
ask_struct *p, u64 enq_flags,
>  	 */
>  	touch_core_sched(rq, p);
>  	refill_task_slice_dfl(sch, p);
> -	dispatch_enqueue(sch, dsq, p, enq_flags);
> +	dispatch_enqueue(sch, rq, dsq, p, enq_flags);
>  }
> =20
>  static bool task_runnable(const struct task_struct *p)
> @@ -1511,6 +1563,22 @@ static void enqueue_task_scx(struct rq *rq, struct=
 task_struct *p, int enq_flags
>  		__scx_add_event(sch, SCX_EV_SELECT_CPU_FALLBACK, 1);
>  }
> =20
> +/*
> + * Call ops.dequeue() for a task leaving BPF custody. Adds %SCX_DEQ_SCHE=
D_CHANGE
> + * when the dequeue is due to a property change (not sleep or core-sched=
 pick).
> + */
> +static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
> +			      struct task_struct *p, u64 deq_flags)
> +{
> +	u64 flags =3D deq_flags;
> +
> +	if (!(deq_flags & (DEQUEUE_SLEEP | SCX_DEQ_CORE_SCHED_EXEC)))
> +		flags |=3D SCX_DEQ_SCHED_CHANGE;
> +
> +	SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, flags);
> +	p->scx.flags &=3D ~SCX_TASK_NEED_DEQ;
> +}
> +
>  static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_fl=
ags)
>  {
>  	struct scx_sched *sch =3D scx_root;
> @@ -1524,6 +1592,24 @@ static void ops_dequeue(struct rq *rq, struct task=
_struct *p, u64 deq_flags)
> =20
>  	switch (opss & SCX_OPSS_STATE_MASK) {
>  	case SCX_OPSS_NONE:
> +		/*
> +		 * Task is not in BPF data structures (either dispatched to
> +		 * a DSQ or running). Only call ops.dequeue() if the task
> +		 * is still in BPF scheduler's custody (%SCX_TASK_NEED_DEQ
> +		 * is set).
> +		 *
> +		 * If the task has already been dispatched to a terminal
> +		 * DSQ (local DSQ or %SCX_DSQ_GLOBAL), it has left the BPF
> +		 * scheduler's custody and the flag will be clear, so we
> +		 * skip ops.dequeue().
> +		 *
> +		 * If this is a property change (not sleep/core-sched) and
> +		 * the task is still in BPF custody, set the
> +		 * %SCX_DEQ_SCHED_CHANGE flag.
> +		 */
> +		if (SCX_HAS_OP(sch, dequeue) &&
> +		    (p->scx.flags & SCX_TASK_NEED_DEQ))
> +			call_task_dequeue(sch, rq, p, deq_flags);
>  		break;
>  	case SCX_OPSS_QUEUEING:
>  		/*
> @@ -1532,9 +1618,14 @@ static void ops_dequeue(struct rq *rq, struct task=
_struct *p, u64 deq_flags)
>  		 */
>  		BUG();
>  	case SCX_OPSS_QUEUED:
> -		if (SCX_HAS_OP(sch, dequeue))
> -			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> -					 p, deq_flags);
> +		/*
> +		 * Task is still on the BPF scheduler (not dispatched yet).
> +		 * Call ops.dequeue() to notify it is leaving BPF custody.
> +		 */
> +		if (SCX_HAS_OP(sch, dequeue)) {
> +			WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_NEED_DEQ));
> +			call_task_dequeue(sch, rq, p, deq_flags);
> +		}
> =20
>  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>  					    SCX_OPSS_NONE))
> @@ -1631,6 +1722,7 @@ static void move_local_task_to_local_dsq(struct tas=
k_struct *p, u64 enq_flags,
>  					 struct scx_dispatch_q *src_dsq,
>  					 struct rq *dst_rq)
>  {
> +	struct scx_sched *sch =3D scx_root;
>  	struct scx_dispatch_q *dst_dsq =3D &dst_rq->scx.local_dsq;
> =20
>  	/* @dsq is locked and @p is on @dst_rq */
> @@ -1639,6 +1731,15 @@ static void move_local_task_to_local_dsq(struct ta=
sk_struct *p, u64 enq_flags,
> =20
>  	WARN_ON_ONCE(p->scx.holding_cpu >=3D 0);
> =20
> +	/*
> +	 * Task is moving from a non-local DSQ to a local (terminal) DSQ.
> +	 * Call ops.dequeue() if the task was in BPF custody.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue) && (p->scx.flags & SCX_TASK_NEED_DEQ)) {
> +		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, dst_rq, p, 0);
> +		p->scx.flags &=3D ~SCX_TASK_NEED_DEQ;
> +	}
> +
>  	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
>  		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
>  	else
> @@ -1879,7 +1980,7 @@ static struct rq *move_task_between_dsqs(struct scx=
_sched *sch,
>  		dispatch_dequeue_locked(p, src_dsq);
>  		raw_spin_unlock(&src_dsq->lock);
> =20
> -		dispatch_enqueue(sch, dst_dsq, p, enq_flags);
> +		dispatch_enqueue(sch, dst_rq, dst_dsq, p, enq_flags);
>  	}
> =20
>  	return dst_rq;
> @@ -1969,14 +2070,14 @@ static void dispatch_to_local_dsq(struct scx_sche=
d *sch, struct rq *rq,
>  	 * If dispatching to @rq that @p is already on, no lock dancing needed.
>  	 */
>  	if (rq =3D=3D src_rq && rq =3D=3D dst_rq) {
> -		dispatch_enqueue(sch, dst_dsq, p,
> +		dispatch_enqueue(sch, rq, dst_dsq, p,
>  				 enq_flags | SCX_ENQ_CLEAR_OPSS);
>  		return;
>  	}
> =20
>  	if (src_rq !=3D dst_rq &&
>  	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> -		dispatch_enqueue(sch, find_global_dsq(sch, p), p,
> +		dispatch_enqueue(sch, rq, find_global_dsq(sch, p), p,
>  				 enq_flags | SCX_ENQ_CLEAR_OPSS);
>  		return;
>  	}
> @@ -2014,9 +2115,21 @@ static void dispatch_to_local_dsq(struct scx_sched=
 *sch, struct rq *rq,
>  		 */
>  		if (src_rq =3D=3D dst_rq) {
>  			p->scx.holding_cpu =3D -1;
> -			dispatch_enqueue(sch, &dst_rq->scx.local_dsq, p,
> +			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
>  					 enq_flags);
>  		} else {
> +			/*
> +			 * Moving to a remote local DSQ. dispatch_enqueue() is
> +			 * not used (we go through deactivate/activate), so
> +			 * call ops.dequeue() here if the task was in BPF
> +			 * custody.
> +			 */
> +			if (SCX_HAS_OP(sch, dequeue) &&
> +			    (p->scx.flags & SCX_TASK_NEED_DEQ)) {
> +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue,
> +						 src_rq, p, 0);
> +				p->scx.flags &=3D ~SCX_TASK_NEED_DEQ;
> +			}
>  			move_remote_task_to_local_dsq(p, enq_flags,
>  						      src_rq, dst_rq);
>  			/* task has been moved to dst_rq, which is now locked */
> @@ -2113,7 +2226,7 @@ static void finish_dispatch(struct scx_sched *sch, =
struct rq *rq,
>  	if (dsq->id =3D=3D SCX_DSQ_LOCAL)
>  		dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
>  	else
> -		dispatch_enqueue(sch, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
> +		dispatch_enqueue(sch, rq, dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
>  }
> =20
>  static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
> @@ -2414,7 +2527,7 @@ static void put_prev_task_scx(struct rq *rq, struct=
 task_struct *p,
>  		 * DSQ.
>  		 */
>  		if (p->scx.slice && !scx_rq_bypassing(rq)) {
> -			dispatch_enqueue(sch, &rq->scx.local_dsq, p,
> +			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p,
>  					 SCX_ENQ_HEAD);
>  			goto switch_class;
>  		}
> @@ -2898,6 +3011,14 @@ static void scx_enable_task(struct task_struct *p)
> =20
>  	lockdep_assert_rq_held(rq);
> =20
> +	/*
> +	 * Verify the task is not in BPF scheduler's custody. If flag
> +	 * transitions are consistent, the flag should always be clear
> +	 * here.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue))
> +		WARN_ON_ONCE(p->scx.flags & SCX_TASK_NEED_DEQ);
> +
>  	/*
>  	 * Set the weight before calling ops.enable() so that the scheduler
>  	 * doesn't see a stale value if they inspect the task struct.
> @@ -2929,6 +3050,14 @@ static void scx_disable_task(struct task_struct *p=
)
>  	if (SCX_HAS_OP(sch, disable))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
>  	scx_set_task_state(p, SCX_TASK_READY);
> +
> +	/*
> +	 * Verify the task is not in BPF scheduler's custody. If flag
> +	 * transitions are consistent, the flag should always be clear
> +	 * here.
> +	 */
> +	if (SCX_HAS_OP(sch, dequeue))
> +		WARN_ON_ONCE(p->scx.flags & SCX_TASK_NEED_DEQ);
>  }
> =20
>  static void scx_exit_task(struct task_struct *p)
> @@ -3919,7 +4048,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, str=
uct rq *rq,
>  		 * between bypass DSQs.
>  		 */
>  		dispatch_dequeue_locked(p, donor_dsq);
> -		dispatch_enqueue(sch, donee_dsq, p, SCX_ENQ_NESTED);
> +		dispatch_enqueue(sch, donee_rq, donee_dsq, p, SCX_ENQ_NESTED);
> =20
>  		/*
>  		 * $donee might have been idle and need to be woken up. No need
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
> index c2c33df9292c2..dcc945304760f 100644
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

