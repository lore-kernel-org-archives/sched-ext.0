Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237E2F85B
	for <sched-ext@lists.linux.dev>; Sun, 28 Dec 2025 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766892012; cv=none; b=bAn6A0V6VbxQ/k/Fk0f/Iq1pGbi3yKIYMWRCQc8BH9m7pCJiPKJgs9I/gvnLpwgOOqrGT6Yfrhr4mElp/qinFZ5VAXXhq+vPHAvYPZ6PgN7apxljxhlVKk+0+fSSh1G/wHNP+LAmQ7f22vInloK2sxnnmLkxSGJ8A4wY6ib3tHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766892012; c=relaxed/simple;
	bh=cpCTMbAcPnQZsioZKbMUtxol7JbAiUWx/Oakn47Ha5g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ORP+uwsUbiqQ20ZSDl48OBMAyHWI7T/SDBxvW14gWWBEb0Ni6UMTFZCiOtcDvCi1tfdbww4S+q8pZhS43pTnJVQ23dlTZhqhRvX0Zd+er9XmxzqRi6p3SxwnQaTjJndm1WlQ649DeVxr+SmUTB/tga9LyIARKWhiYaPCYIn90Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=rdizOJwn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="rdizOJwn"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88fe44cce7eso29629556d6.3
        for <sched-ext@lists.linux.dev>; Sat, 27 Dec 2025 19:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1766892007; x=1767496807; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfrEOhtEBr1ie3VfDCrv0YEmwUSpSaCz6Ve5l6JncRY=;
        b=rdizOJwnlvUsoUF/ra57REdOxLt/36+BCNopRdYYmNjfKG3pY6809BMDEgzOb6MTT5
         TgmsC0smh0KnDGrk3z21bni5V9woElTlljCTVPCMfv+5UEgszhD4psc+qFS8SyR/PXO7
         D2g3Vsvat/27i922IBc7IKOz9pJdhzNq0jJh97Y3rl6WERL1UGePDURbQ1iw7iDPKkDj
         de/kBrh7+j+92RpQyOvBArEBZhm9Sv6HI7fUdTWx+hqfKiBPURcqIRMQEfYDSXdGFN7t
         ThisU2f6qfM0zURQVpgbiLXHjw0YBob4FSYk0ekaS/1fE8MTvhG3fvRtFVUhZNmin31i
         O9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766892007; x=1767496807;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfrEOhtEBr1ie3VfDCrv0YEmwUSpSaCz6Ve5l6JncRY=;
        b=UNJq871gRQM342yiWVsznNOE8s0MC7ni/feDqA5Cca9w55Atg2U4PDSasWvpAF3SMS
         tIJVGVoD/oCNDnrGs9Bx3tDoe9kokoUWMPrK1KAqjstrlALqSy+Ia/H4CdPT4aOG/wVv
         07o4/ucbJlteplrgRs770QObvObti384GQQCBRFPK4SVvQf64UmUyjgfmmCrforOyHWM
         D/ac3F/TJJsrfIW8xFe/XfueeqvrCJocJ8qgF4dEVuk4zBQfUyI55yg1jCD5/IFC+WoN
         y0IGnmONEKQswwRUoOFeVg1/8lOUxUJLZ1I6qxkXviIJ82whBaDCTn1xA3hKjM/aTedt
         zfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+SFydhuQA/d2WWxZrMgTqTFKpmfCgsEuBhonEQhEZcSC2f7Wrk40EmoBRXHarVAIQ4b6z/S29z4A=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq26BajloymnnMwLiEOVAn5zzYPHkjU/hLNuNW0M/Ean/T94kx
	uewjiNitK+Sv7OnCfH0Q8VhlVE3+bK1P6I7HVOtgu5k09HHrTrqr3MCyfHsYkBNBpm4=
X-Gm-Gg: AY/fxX4ZTAMFMYRiTgq3Ho/KpoZpTTJyHgHcxKEyw+ou+umkNgCk1p4QN1OFpkPhQCJ
	2XPjgGRQbN46T6lbXnLQNVj8ceWJ4mmIAc45c6gKjLBuaXBEXo7FM4dHZ9svJuZrIyWLIwp7uk3
	z8B9BlTUlVbgEI3zjl9/ghuNGVfx2X3Orx9k+FVGYZcfS7HoIPqNf/44GhbOdtHAfiAMc5yHk01
	8ZPA8o6U/2X9sIcdIcrSTAxEO8YIMLiy9YUohHpxGv5nTMuJZ0Hbf5N1kw72k8qiSacrT7F/lB6
	0sWEyjfVrepusIMl5C6UBmnZIiFnH1skq4Iju89x/x8idQPXDzS0AnjzfebHzu0jyiSBsLVBtjj
	jynQ/FdSc9zbLwkB2CDepeOg9NxevBC+a9WFiwuF9BnwwbMSO3TG6OA7D6fOLRd6dVDLg4VnhAS
	YXNhDU40SF10g=
X-Google-Smtp-Source: AGHT+IGF6QooQDK1+5jHPTftG1Uk1gASgacdOvVV8T31Sr9ut3FsF9ejF1ygJ4rdqjGuJxBIHJ4WIQ==
X-Received: by 2002:a05:6214:5346:b0:88a:577b:fa4f with SMTP id 6a1803df08f44-88d816677dbmr363334056d6.12.1766892007469;
        Sat, 27 Dec 2025 19:20:07 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7dbdcsm201315296d6.43.2025.12.27.19.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 19:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Dec 2025 22:20:06 -0500
Message-Id: <DF9IXXXOIXP7.LILBQBLDYVM7@etsalapatis.com>
Cc: "Daniel Hodges" <hodgesd@meta.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>, "Tejun Heo" <tj@kernel.org>, "David
 Vernet" <void@manifault.com>, "Changwoo Min" <changwoo@igalia.com>
X-Mailer: aerc 0.20.1
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
In-Reply-To: <20251219224450.2537941-2-arighi@nvidia.com>

On Fri Dec 19, 2025 at 5:43 PM EST, Andrea Righi wrote:
> Properly implement ops.dequeue() to ensure every ops.enqueue() is
> balanced by a corresponding ops.dequeue() call, regardless of whether
> the task is on a BPF data structure or already dispatched to a DSQ.
>
> A task is considered enqueued when it is owned by the BPF scheduler.
> This ownership persists until the task is either dispatched (moved to a
> local DSQ for execution) or removed from the BPF scheduler, such as when
> it blocks waiting for an event or when its properties (for example, CPU
> affinity or priority) are updated.
>
> When the task enters the BPF scheduler ops.enqueue() is invoked, when it
> leaves BPF scheduler ownership, ops.dequeue() is invoked.
>
> This allows BPF schedulers to reliably track task ownership and maintain
> accurate accounting.
>
> Cc: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---


Hi Andrea,

	This change looks reasonable to me. Some comments inline:

>  Documentation/scheduler/sched-ext.rst | 22 ++++++++++++++++++++++
>  include/linux/sched/ext.h             |  1 +
>  kernel/sched/ext.c                    | 27 ++++++++++++++++++++++++++-
>  3 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/schedu=
ler/sched-ext.rst
> index 404fe6126a769..3ed4be53f97da 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -252,6 +252,26 @@ The following briefly shows how a waking task is sch=
eduled and executed.
> =20
>     * Queue the task on the BPF side.
> =20
> +   Once ``ops.enqueue()`` is called, the task is considered "enqueued" a=
nd
> +   is owned by the BPF scheduler. Ownership is retained until the task i=
s
> +   either dispatched (moved to a local DSQ for execution) or dequeued
> +   (removed from the scheduler due to a blocking event, or to modify a
> +   property, like CPU affinity, priority, etc.). When the task leaves th=
e
> +   BPF scheduler ``ops.dequeue()`` is invoked.
> +

Can we say "leaves the scx class" instead? On direct dispatch we
technically never insert the task into the BPF scheduler.

> +   **Important**: ``ops.dequeue()`` is called for *any* enqueued task,
> +   regardless of whether the task is still on a BPF data structure, or i=
t
> +   is already dispatched to a DSQ (global, local, or user DSQ)
> +
> +   This guarantees that every ``ops.enqueue()`` will eventually be follo=
wed
> +   by a ``ops.dequeue()``. This makes it reliable for BPF schedulers to
> +   track task ownership and maintain accurate accounting, such as per-DS=
Q
> +   queued runtime sums.
> +
> +   BPF schedulers can choose not to implement ``ops.dequeue()`` if they
> +   don't need to track these transitions. The sched_ext core will safely
> +   handle all dequeue operations regardless.
> +
>  3. When a CPU is ready to schedule, it first looks at its local DSQ. If
>     empty, it then looks at the global DSQ. If there still isn't a task t=
o
>     run, ``ops.dispatch()`` is invoked which can use the following two
> @@ -319,6 +339,8 @@ by a sched_ext scheduler:
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
> index bcb962d5ee7d8..334c3692a9c62 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -84,6 +84,7 @@ struct scx_dispatch_q {
>  /* scx_entity.flags */
>  enum scx_ent_flags {
>  	SCX_TASK_QUEUED		=3D 1 << 0, /* on ext runqueue */
> +	SCX_TASK_OPS_ENQUEUED	=3D 1 << 1, /* ops.enqueue() was called */

Can we rename this flag? For direct dispatch we never got enqueued.
Something like "DEQ_ON_DISPATCH" would show the purpose of the
flag more clearly.

>  	SCX_TASK_RESET_RUNNABLE_AT =3D 1 << 2, /* runnable_at should be reset *=
/
>  	SCX_TASK_DEQD_FOR_SLEEP	=3D 1 << 3, /* last dequeue was for SLEEP */
> =20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 94164f2dec6dc..985d75d374385 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1390,6 +1390,9 @@ static void do_enqueue_task(struct rq *rq, struct t=
ask_struct *p, u64 enq_flags,
>  	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) !=3D SCX_OPSS_NONE);
>  	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
> =20
> +	/* Mark that ops.enqueue() is being called for this task */
> +	p->scx.flags |=3D SCX_TASK_OPS_ENQUEUED;
> +

Can we avoid setting this flag when we have no .dequeue() method?
Otherwise it stays set forever AFAICT, even after the task has been
sent to the runqueues.

>  	ddsp_taskp =3D this_cpu_ptr(&direct_dispatch_task);
>  	WARN_ON_ONCE(*ddsp_taskp);
>  	*ddsp_taskp =3D p;
> @@ -1522,6 +1525,21 @@ static void ops_dequeue(struct rq *rq, struct task=
_struct *p, u64 deq_flags)
> =20
>  	switch (opss & SCX_OPSS_STATE_MASK) {
>  	case SCX_OPSS_NONE:
> +		/*
> +		 * Task is not currently being enqueued or queued on the BPF
> +		 * scheduler. Check if ops.enqueue() was called for this task.
> +		 */
> +		if ((p->scx.flags & SCX_TASK_OPS_ENQUEUED) &&
> +		    SCX_HAS_OP(sch, dequeue)) {
> +			/*
> +			 * ops.enqueue() was called and the task was dispatched.
> +			 * Call ops.dequeue() to notify the BPF scheduler that
> +			 * the task is leaving.
> +			 */
> +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
> +					 p, deq_flags);
> +			p->scx.flags &=3D ~SCX_TASK_OPS_ENQUEUED;
> +		}
>  		break;
>  	case SCX_OPSS_QUEUEING:
>  		/*
> @@ -1530,9 +1548,16 @@ static void ops_dequeue(struct rq *rq, struct task=
_struct *p, u64 deq_flags)
>  		 */
>  		BUG();
>  	case SCX_OPSS_QUEUED:
> -		if (SCX_HAS_OP(sch, dequeue))
> +		/*
> +		 * Task is owned by the BPF scheduler. Call ops.dequeue()
> +		 * to notify the BPF scheduler that the task is being
> +		 * removed.
> +		 */
> +		if (SCX_HAS_OP(sch, dequeue)) {

Edge case, but if we have a .dequeue() method but not an .enqueue() we
still make this call. Can we add flags & SCX_TASK_OPS_ENQUEUED as an=20
extra condition to be consistent with the SCX_OPSS_NONE case above?

>  			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
>  					 p, deq_flags);
> +			p->scx.flags &=3D ~SCX_TASK_OPS_ENQUEUED;
> +		}
> =20
>  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>  					    SCX_OPSS_NONE))

