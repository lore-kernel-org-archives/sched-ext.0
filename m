Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAF3321C9
	for <sched-ext@lists.linux.dev>; Mon, 29 Dec 2025 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033354; cv=none; b=QjcTbVhPgNe+8V9jx9dVMqTTpu56kRS9zwv1grElRjMRa6iF3d4pdE7bJM/fgocVIWnGIb5M+WCx4UoA7iSRgP4yV6NSWnu4Nrsv4BBA1uapRzQ7zjHfrNajoasWImbRtdmpjckZvgGuukbXrw+vcDTH0bR+EBcwyXiwK2fm0Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033354; c=relaxed/simple;
	bh=2mpzrJYDcDzhZNP0MrLrAI829PXibzAKnuINBnqKRuc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CJc3RmVPkkoZnrumfZnCG2NTQYUoU3c9rXUuvJOhdo5eu4JFdRSswrCZUVfP6YvOy9ilwL81yYDwUh0xbYEwna2v8aEqL6ptBlL0Eq7W2HQP6Ulaz3jqEjo9tmpvx3MALPfhU70qt95iT5HPQpCCaRMys5MxfxR7EETdAu0AxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=i3U6izEg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="i3U6izEg"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee158187aaso101898661cf.0
        for <sched-ext@lists.linux.dev>; Mon, 29 Dec 2025 10:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767033350; x=1767638150; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1Z4Xwk/MnUvV7RJ+ef2IcHl1dRozqXO6pZZsK94G58=;
        b=i3U6izEgCfcmP12WFrOWx0XLN944vDPAxRnG1S5rXk0SRw8LSIryktM8uWbbSfVid7
         P/DbmqpxWSGFhYs/qwhvuZQfCMTTyTPhU2xKKmoXtWKfiPWbtUxfF/U+Au+Hlrme9R5p
         Fk/ZIzm9wGayG2636UaryIE3dd3Zs+O+mnrHccpCzfU5JjCNE4LTAWKxQjck3JYemZQD
         mVjUXWysvD9qAXDdwSoM9q3VLp4J57qYe1u3W6C5Eevhwp9di25/S+tovermZpsH+GFi
         qUbO42O/asjjn7tC9urpfr7miFNDyDP0DSa2rOX3C65nncnomtUe+ENqNIzPyrwkfGjK
         UKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033350; x=1767638150;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1Z4Xwk/MnUvV7RJ+ef2IcHl1dRozqXO6pZZsK94G58=;
        b=J3wxTb8ssJYWjI01Int14bYYNkcmSddVo9v1mpS8HX9XX8HmPGXgj63bWufDyOZd49
         t3V4N5GWN58o1Fvw6kxzw3sap+ESw5CILfJpFnYoBFmgPoJ9pM4pwDcubfXpoIUzBISU
         HAlOX9RRorzNNHP3KFvNdAfHBOXhIh4AKTz5GQOSR6CJWPqAIqcpat7j3sfpEk+OPWlH
         xRcxk2iKjm6yZ/s13RymckKhC+ii5EZRahbaCs8MQ8J3o1Emgf9gL1bgkT6kjEfvW7wO
         4VexcF0RCKTnq/GoMV1zZ3X7d9XXVS+LPMUPuQGk0bwFPsZUnF+mRMI9VBPgIr9+9uGo
         I59g==
X-Forwarded-Encrypted: i=1; AJvYcCVQC2pALmm3IOMPvnUMEDgINU1I+oZgREsdQh8GXK0ubkpkJMXWDwcxFbhdSCGs7j+9zOFr8yhkf7I=@lists.linux.dev
X-Gm-Message-State: AOJu0YyTYyOoR2ElaXoUiU6T5nnxl5RbAWfHqeKPaU/oB5i9J2E+dLj0
	s0oe/4LrDAbeZ1eZ19NhGOnqhua5Ozr+eyzB0th2dbu0756TvfH9SK3ybAxGnGSYwGM=
X-Gm-Gg: AY/fxX6pRnGH8tUBDU4ZVw6tiqzdpXm9EBZW7S1TUXa2xP37yNfvR86sOdjkYmdBuY0
	4jbINhdrhNuPrNHxVmjWzSHuwNBdnbDdFWHeTWq7jUl+lvR/jS66vzzaP8igIDiUQUNMeUAaztu
	uep9WAjlAaRwhCpNmyiG4XMdl01zyM2MqkEvvKzYuf11U5idvEedXLDSvQJxZXRVfZy+buVEDwx
	x4aw1uHT4NO76ciaqIZkWIyPbGNTkymZnFBpeR0M9imL3xfloXdtOuORAmuak8uhE+4U+uiwP16
	Aix6fW9yAnkM9mr+aOTHYatWehIEypJYn3EwvZy7rCddyvIwKp4SlyNRY3+VCpz8a52WswMOEO+
	M8e/Qm5wd+LsL/wnZqnak3ehcQLfwis9xMGGXz79/LCehOSS6ovoOkFClOtw02zlESdP/HyMgp6
	jDw9V4fMP6wjQ=
X-Google-Smtp-Source: AGHT+IE4hvby59bsTgVBDvTR95T/y39usDTUhtVM3vLLobaSJ4T850X2sCv3O0HZAANs0kCp2vWKTw==
X-Received: by 2002:a05:622a:344:b0:4f3:4ec0:9032 with SMTP id d75a77b69052e-4f4abdd5bb4mr452859051cf.72.1767033350382;
        Mon, 29 Dec 2025 10:35:50 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fdfdsm235782236d6.5.2025.12.29.10.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 10:35:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Dec 2025 13:35:48 -0500
Message-Id: <DFAX1LUAMTP9.J043T7TQQKXX@etsalapatis.com>
Cc: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Changwoo Min" <changwoo@igalia.com>, "Daniel Hodges" <hodgesd@meta.com>,
 <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>
X-Mailer: aerc 0.20.1
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
 <DF9IXXXOIXP7.LILBQBLDYVM7@etsalapatis.com> <aVKt-cmkOxPe3MI6@gpd4>
In-Reply-To: <aVKt-cmkOxPe3MI6@gpd4>

On Mon Dec 29, 2025 at 11:36 AM EST, Andrea Righi wrote:
> Hi Emil,
>
> On Sat, Dec 27, 2025 at 10:20:06PM -0500, Emil Tsalapatis wrote:
>> On Fri Dec 19, 2025 at 5:43 PM EST, Andrea Righi wrote:
>> > Properly implement ops.dequeue() to ensure every ops.enqueue() is
>> > balanced by a corresponding ops.dequeue() call, regardless of whether
>> > the task is on a BPF data structure or already dispatched to a DSQ.
>> >
>> > A task is considered enqueued when it is owned by the BPF scheduler.
>> > This ownership persists until the task is either dispatched (moved to =
a
>> > local DSQ for execution) or removed from the BPF scheduler, such as wh=
en
>> > it blocks waiting for an event or when its properties (for example, CP=
U
>> > affinity or priority) are updated.
>> >
>> > When the task enters the BPF scheduler ops.enqueue() is invoked, when =
it
>> > leaves BPF scheduler ownership, ops.dequeue() is invoked.
>> >
>> > This allows BPF schedulers to reliably track task ownership and mainta=
in
>> > accurate accounting.
>> >
>> > Cc: Emil Tsalapatis <emil@etsalapatis.com>
>> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
>> > ---
>>=20
>>=20
>> Hi Andrea,
>>=20
>> 	This change looks reasonable to me. Some comments inline:
>>=20
>> >  Documentation/scheduler/sched-ext.rst | 22 ++++++++++++++++++++++
>> >  include/linux/sched/ext.h             |  1 +
>> >  kernel/sched/ext.c                    | 27 ++++++++++++++++++++++++++=
-
>> >  3 files changed, 49 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/sch=
eduler/sched-ext.rst
>> > index 404fe6126a769..3ed4be53f97da 100644
>> > --- a/Documentation/scheduler/sched-ext.rst
>> > +++ b/Documentation/scheduler/sched-ext.rst
>> > @@ -252,6 +252,26 @@ The following briefly shows how a waking task is =
scheduled and executed.
>> > =20
>> >     * Queue the task on the BPF side.
>> > =20
>> > +   Once ``ops.enqueue()`` is called, the task is considered "enqueued=
" and
>> > +   is owned by the BPF scheduler. Ownership is retained until the tas=
k is
>> > +   either dispatched (moved to a local DSQ for execution) or dequeued
>> > +   (removed from the scheduler due to a blocking event, or to modify =
a
>> > +   property, like CPU affinity, priority, etc.). When the task leaves=
 the
>> > +   BPF scheduler ``ops.dequeue()`` is invoked.
>> > +
>>=20
>> Can we say "leaves the scx class" instead? On direct dispatch we
>> technically never insert the task into the BPF scheduler.
>
> Hm.. I agree that'd be more accurate, but it might also be slightly
> misleading, as it could be interpreted as the task being moved to a
> different scheduling class. How about saying "leaves the enqueued state"
> instead, where enqueued means ops.enqueue() being called... I can't find =
a
> better name for this state, like "ops_enqueued", but that's be even more
> confusing. :)
>

I like "leaves the enqueued state", it implies that the task has no
state in the scx scheduler.

>>=20
>> > +   **Important**: ``ops.dequeue()`` is called for *any* enqueued task=
,
>> > +   regardless of whether the task is still on a BPF data structure, o=
r it
>> > +   is already dispatched to a DSQ (global, local, or user DSQ)
>> > +
>> > +   This guarantees that every ``ops.enqueue()`` will eventually be fo=
llowed
>> > +   by a ``ops.dequeue()``. This makes it reliable for BPF schedulers =
to
>> > +   track task ownership and maintain accurate accounting, such as per=
-DSQ
>> > +   queued runtime sums.
>> > +
>> > +   BPF schedulers can choose not to implement ``ops.dequeue()`` if th=
ey
>> > +   don't need to track these transitions. The sched_ext core will saf=
ely
>> > +   handle all dequeue operations regardless.
>> > +
>> >  3. When a CPU is ready to schedule, it first looks at its local DSQ. =
If
>> >     empty, it then looks at the global DSQ. If there still isn't a tas=
k to
>> >     run, ``ops.dispatch()`` is invoked which can use the following two
>> > @@ -319,6 +339,8 @@ by a sched_ext scheduler:
>> >                  /* Any usable CPU becomes available */
>> > =20
>> >                  ops.dispatch(); /* Task is moved to a local DSQ */
>> > +
>> > +                ops.dequeue(); /* Exiting BPF scheduler */
>> >              }
>> >              ops.running();      /* Task starts running on its assigne=
d CPU */
>> >              while (task->scx.slice > 0 && task is runnable)
>> > diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
>> > index bcb962d5ee7d8..334c3692a9c62 100644
>> > --- a/include/linux/sched/ext.h
>> > +++ b/include/linux/sched/ext.h
>> > @@ -84,6 +84,7 @@ struct scx_dispatch_q {
>> >  /* scx_entity.flags */
>> >  enum scx_ent_flags {
>> >  	SCX_TASK_QUEUED		=3D 1 << 0, /* on ext runqueue */
>> > +	SCX_TASK_OPS_ENQUEUED	=3D 1 << 1, /* ops.enqueue() was called */
>>=20
>> Can we rename this flag? For direct dispatch we never got enqueued.
>> Something like "DEQ_ON_DISPATCH" would show the purpose of the
>> flag more clearly.
>
> Good point. However, ops.dequeue() isn't only called on dispatch, it can
> also be triggered when a task property is changed.
>
> So the flag should represent the "enqueued state" in the sense that
> ops.enqueue() has been called and a corresponding ops.dequeue() is
> expected. This is a lifecycle state, not an indication that the task is i=
n
> any queue.
>
> Would a more descriptive comment clarify this? Something like:
>
>   SCX_TASK_OPS_ENQUEUED =3D 1 << 1, /* Task in enqueued state: ops.enqueu=
e()
>                                      called, ops.dequeue() will be called
>                                      when task leaves this state. */
>

That makes sense, my reasoning was that we actually use the flag for
is not whether the task is enqueued, but rather whether whether we=20
need to call the dequeue callback when dequeueing from the SCX_OPSS_NONE=20
state. Can the comment maybe more concretely explain this?

As an aside, I think this change makes it so we can remove the _OPSS_ state=
=20
machine with some more refactoring.=20

>>=20
>> >  	SCX_TASK_RESET_RUNNABLE_AT =3D 1 << 2, /* runnable_at should be rese=
t */
>> >  	SCX_TASK_DEQD_FOR_SLEEP	=3D 1 << 3, /* last dequeue was for SLEEP */
>> > =20
>> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> > index 94164f2dec6dc..985d75d374385 100644
>> > --- a/kernel/sched/ext.c
>> > +++ b/kernel/sched/ext.c
>> > @@ -1390,6 +1390,9 @@ static void do_enqueue_task(struct rq *rq, struc=
t task_struct *p, u64 enq_flags,
>> >  	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) !=3D SCX_OPSS_NONE)=
;
>> >  	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
>> > =20
>> > +	/* Mark that ops.enqueue() is being called for this task */
>> > +	p->scx.flags |=3D SCX_TASK_OPS_ENQUEUED;
>> > +
>>=20
>> Can we avoid setting this flag when we have no .dequeue() method?
>> Otherwise it stays set forever AFAICT, even after the task has been
>> sent to the runqueues.
>
> Good catch! Definitely we don't need to set this for schedulers that don'=
t
> implement ops.dequeue().
>
>>=20
>> >  	ddsp_taskp =3D this_cpu_ptr(&direct_dispatch_task);
>> >  	WARN_ON_ONCE(*ddsp_taskp);
>> >  	*ddsp_taskp =3D p;
>> > @@ -1522,6 +1525,21 @@ static void ops_dequeue(struct rq *rq, struct t=
ask_struct *p, u64 deq_flags)
>> > =20
>> >  	switch (opss & SCX_OPSS_STATE_MASK) {
>> >  	case SCX_OPSS_NONE:
>> > +		/*
>> > +		 * Task is not currently being enqueued or queued on the BPF
>> > +		 * scheduler. Check if ops.enqueue() was called for this task.
>> > +		 */
>> > +		if ((p->scx.flags & SCX_TASK_OPS_ENQUEUED) &&
>> > +		    SCX_HAS_OP(sch, dequeue)) {
>> > +			/*
>> > +			 * ops.enqueue() was called and the task was dispatched.
>> > +			 * Call ops.dequeue() to notify the BPF scheduler that
>> > +			 * the task is leaving.
>> > +			 */
>> > +			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
>> > +					 p, deq_flags);
>> > +			p->scx.flags &=3D ~SCX_TASK_OPS_ENQUEUED;
>> > +		}
>> >  		break;
>> >  	case SCX_OPSS_QUEUEING:
>> >  		/*
>> > @@ -1530,9 +1548,16 @@ static void ops_dequeue(struct rq *rq, struct t=
ask_struct *p, u64 deq_flags)
>> >  		 */
>> >  		BUG();
>> >  	case SCX_OPSS_QUEUED:
>> > -		if (SCX_HAS_OP(sch, dequeue))
>> > +		/*
>> > +		 * Task is owned by the BPF scheduler. Call ops.dequeue()
>> > +		 * to notify the BPF scheduler that the task is being
>> > +		 * removed.
>> > +		 */
>> > +		if (SCX_HAS_OP(sch, dequeue)) {
>>=20
>> Edge case, but if we have a .dequeue() method but not an .enqueue() we
>> still make this call. Can we add flags & SCX_TASK_OPS_ENQUEUED as an=20
>> extra condition to be consistent with the SCX_OPSS_NONE case above?
>
> Also good catch. Will add that.
>
>>=20
>> >  			SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq,
>> >  					 p, deq_flags);
>> > +			p->scx.flags &=3D ~SCX_TASK_OPS_ENQUEUED;
>> > +		}
>> > =20
>> >  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>> >  					    SCX_OPSS_NONE))
>>=20
>
> Thanks,
> -Andrea

