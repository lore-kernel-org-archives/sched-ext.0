Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA823E347
	for <sched-ext@lists.linux.dev>; Thu,  9 Oct 2025 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046835; cv=none; b=UxhP2yKeDXE73c+gEe/3t1PsY2wBZQnLcizJCxvWU2X5S+z2rQgECiniZyq7Cg4U4O8O2KYxKEsO9H4CIhThwNx5tTgXgkdl5BUePBCA6G4DVsOzj/cXKamIau9CmhmICq9+ObG4GTrwpMWMoS/3HE60kp988vyEcmtKeRwrCBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046835; c=relaxed/simple;
	bh=AW7Hb00bPnineBB2a7Hzr+7drVoWRiHSLe0cplfSWPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bu/E6Rw5lxlobbChtJea/Pmc3IA5y2BbvRqAYnNTiEAQQsZRvg0DUDgqSfKfyASxXYUDEWhCrSqykN8TQjRgEHN5axJHQs3A3lbdAaarV/OR/RkbAWGM2m97LK+vU9aHciTzm0QSgJI13udouOi+Y8nj50aoj9kKZ8hVhgdijgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=iq3ncoWQ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="iq3ncoWQ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d60528734so14347057b3.2
        for <sched-ext@lists.linux.dev>; Thu, 09 Oct 2025 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1760046832; x=1760651632; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTaQX3suVq+ErhdjyOCbIcGN6OzaHtWn4FeZaH4Kl44=;
        b=iq3ncoWQ5EmGQAAGwZ3URl2kJDLJGWrTtKVzEKlYho5eC0o6GaTYTikNFZUEf9k7eU
         qxLDhVxK4DhvbxqXPPeIeg/5Ale3ajkPGrZiieddST6YjcL9UXgtYxBJXQoXftBNtrI6
         3gSbhSdjmI3v77bXLsm4WhOAkZ0cTbxFUaBu995CnhNVMMdEAvjv78R3FCAJVs+hKE47
         k//GZwn98VG2Yxm71PCQDsQ/zkbTOCwevhYIlANKjUdSRCbIhVq1dHOXrJssrvs1DWy0
         rCOcCtQIXkuXGzgs2W+DGFniUD1qdCR6hRNvEtk3fkbsTv0LpBHX5ICr5W5D2tvolKEj
         21gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760046832; x=1760651632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTaQX3suVq+ErhdjyOCbIcGN6OzaHtWn4FeZaH4Kl44=;
        b=TWlh36jyA2u6/EnTPPkG0WnIL6xGxcYRa7oXnfwPAGWiANO5zhjRCjfzcif6hboxfQ
         Pp5ABL9E9JMQa1wkow1bYvnwXJMI4Pi5l8SiZJY97BD4nn8MUpFidRfHLksr6otYqwIb
         L339bfhemMQnhe7OplBcuDeuruzkUwtwqnfJjMpekix9hy+KJgOb4ixBWLLwN00MMiX+
         B1NXJixPJsQ1js0aWXKgWHiRg196UoFWfJbo4FzRZRU2tIpPeZaeFJGQJPiejTvPSg1F
         SPSoCl1UAcMlPd5499hsDbb5wZWEd9ch9HAY1Uo6y15+W2rExyxKDlejpNj1FiWuVOVb
         DWKw==
X-Forwarded-Encrypted: i=1; AJvYcCWRnzFhkz4UZqXWaOjtFIygosUJTdhnw5a8u9L8UMdkDiyTXcaWnJXvFnDfyc72CPZrSsxfENByyM4=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywxd4fR56kpfnWLWrpvm8GSXiSkGTOjT8AKatLRRMK0Wf9M1g+H
	o4hXn00NeiCydVoOCF351Wt07lZnJ+/BpDvn3FbIrNyvmk9vAddvXrxlWwPAmdWZ5qZgtTkjYg4
	E8VXWpMbf4JWRll22n/DXOQIM/O8kOygeGrXLhNtgGg==
X-Gm-Gg: ASbGncvKgakzYama4a+eh+QZPo/QYC7FmEDvcyqZ8QSGieO6I/g+cKTUAPxqE5yWsfK
	VRNmr4SNGkG+ov6tABUaiWVn4TqQLJN941O2sl77lgJDT8bEa8bBso2RqgGrDhBkSzvzdL6G3xa
	TAwX8nJBx+0kMhJCgY4AM7yrmJ5ayBeS+GBzwdgWb74WGAbJ2vZivXyrkoGZUNn+2VelumLs4u4
	iT1QWlUIeMRM55J9HBzYdyi1j82
X-Google-Smtp-Source: AGHT+IFqdl2SaJJ3S+pttiAv9H7rf2Sik10JEMAb16iGplo2Xi3ML9LLUnor0BwJY0T4Q7WvQ3G2hWOTB8Nv4fwJOas=
X-Received: by 2002:a05:690e:2025:b0:635:4ece:2414 with SMTP id
 956f58d0204a3-63ccb93f1e2mr7517810d50.52.1760046831707; Thu, 09 Oct 2025
 14:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251009173620.1882642-1-etsal@meta.com> <aOgOxtHCeyRT_7jn@gpd4>
In-Reply-To: <aOgOxtHCeyRT_7jn@gpd4>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Thu, 9 Oct 2025 17:53:41 -0400
X-Gm-Features: AS18NWBgTCkcc23klxxq46vP3rhpQD5eiAfaWgn5PVdBtLpfw7OEgxchxlVt9EI
Message-ID: <CABFh=a5bjhVNbaKE42OYCVoMDV_FQiaWOq8J2Fm8HBC97JVsvg@mail.gmail.com>
Subject: Re: [PATCH] sched_ext: defer queue_balance_callback() until after ops.dispatch
To: Andrea Righi <arighi@nvidia.com>
Cc: Emil Tsalapatis <etsal@meta.com>, tj@kernel.org, void@manifault.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

Thank you for the feedback, answering inline:

On Thu, Oct 9, 2025 at 3:36=E2=80=AFPM Andrea Righi <arighi@nvidia.com> wro=
te:
>
> Hi Emil,
>
> On Thu, Oct 09, 2025 at 10:36:20AM -0700, Emil Tsalapatis wrote:
> > The sched_ext code calls queue_balance_callback() during .balance(),
>
> I think we call queue_balance_callback() from .enqueue_task(), right?
>

Ack, the text messes up the description of the actual race that is shown in
the diagram below.

> > to defer operations that drop multiple locks until we can unpin them.
> > The is call assumes that the rq lock is held until the callbacks are
>
> s/is//
>

Ack, will fix.

> > invoked, and the pending callbacks will not be visible to any other
> > threads. This is enforced by a WARN_ON_ONCE() in rq_pin_lock().
> >
> > However, balance_one() may actually drop the lock during a BPF dispatch
> > call. Another thread may win the race to get the rq lock and see the
> > pending callback. To avoid this, sched_ext must only queue the callback
> > after the dispatch calls have completed.
> >
> > CPU 0                   CPU 1           CPU 2
> >
> > scx_balance()
> >   rq_unpin_lock()
> >   scx_balance_one()
> >     |=3D IN_BALANCE     scx_enqueue()
> >     ops.dispatch()
> >       rq_unlock()
> >                         rq_lock()
> >                         queue_balance_callback()
> >                         rq_unlock()
> >                                         [WARN] rq_pin_lock()
> >       rq_lock()
> >     &=3D ~IN_BALANCE
> > rq_repin_lock()
> >
> > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> > ---
> >  kernel/sched/ext.c   | 28 ++++++++++++++++++++++++++--
> >  kernel/sched/sched.h |  1 +
> >  2 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 5f957cff5d17..35dfce06297a 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -780,13 +780,23 @@ static void schedule_deferred(struct rq *rq)
> >       if (rq->scx.flags & SCX_RQ_IN_WAKEUP)
> >               return;
> >
> > +     /* Don't do anything if there already is a deferred operation. */
> > +     if (rq->scx.flags & SCX_RQ_BAL_PENDING)
> > +             return;
> > +
> >       /*
> >        * If in balance, the balance callbacks will be called before rq =
lock is
> >        * released. Schedule one.
> > +      *
> > +      *
> > +      * We can't directly insert the callback into the
> > +      * rq's list: The call can drop its lock and make the pending bal=
ance
> > +      * callback visible to unrelated code paths that call rq_pin_lock=
().
> > +      *
> > +      * Just let balance_one() know that it must do it itself.
> >        */
> >       if (rq->scx.flags & SCX_RQ_IN_BALANCE) {
> > -             queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
> > -                                    deferred_bal_cb_workfn);
> > +             rq->scx.flags |=3D SCX_RQ_BAL_CB_PENDING;
> >               return;
> >       }
> >
> > @@ -2003,6 +2013,18 @@ static void flush_dispatch_buf(struct scx_sched =
*sch, struct rq *rq)
> >       dspc->cursor =3D 0;
> >  }
> >
> > +static inline void maybe_queue_balance_callback(struct rq *rq)
> > +{
> > +     lockdep_assert_rq_held(rq);
> > +
> > +     if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
> > +             queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
> > +                                    deferred_bal_cb_workfn);
> > +     }
> > +
> > +     rq->scx.flags &=3D SCX_RQ_BAL_CB_PENDING;
>
> Hm... this looks wrong. I think you want to clear SCX_RQ_BAL_CB_PENDING, =
so
> it should be:
>
>         rq->scx.flags &=3D ~SCX_RQ_BAL_CB_PENDING;
>

Ack, this is a rebase error from a previous version. I've retested
with the above line fixed
and everything still works as expected:
a) The rq_pin_lock warning goes away
b) The ratio of ddsp_process_deferred_locals() done using
deferred_irq_work() vs
queue_balance_callback()  does not change

> And while at it, just to better reflect the logic:
>
>         if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
>                 queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
>                                        deferred_bal_cb_workfn);
>                 rq->scx.flags &=3D ~SCX_RQ_BAL_CB_PENDING;
>         }
>

How about the following to avoid nesting:

if (!(rq->scx.flags & SCX_RQ_BAL_CB_PENDING))
    return;

queue_balance_callback(rq, &rq->scx.deferred_bal_cb, deferred_bal_cb_workfn=
);
rq->scx.flags &=3D ~SCX_RQ_BAL_CB_PENDING;

> > +}
> > +
> >  static int balance_one(struct rq *rq, struct task_struct *prev)
> >  {
> >       struct scx_sched *sch =3D scx_root;
> > @@ -2150,6 +2172,8 @@ static int balance_scx(struct rq *rq, struct task=
_struct *prev,
> >  #endif
> >       rq_repin_lock(rq, rf);
> >
> > +     maybe_queue_balance_callback(rq);
> > +
> >       return ret;
> >  }
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index be9745d104f7..8f3935785fc5 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -757,6 +757,7 @@ enum scx_rq_flags {
> >       SCX_RQ_BAL_KEEP         =3D 1 << 3, /* balance decided to keep cu=
rrent */
> >       SCX_RQ_BYPASSING        =3D 1 << 4,
> >       SCX_RQ_CLK_VALID        =3D 1 << 5, /* RQ clock is fresh and vali=
d */
> > +     SCX_RQ_BAL_CB_PENDING   =3D 1 << 6, /* must queue a cb after disp=
atching */
> >
> >       SCX_RQ_IN_WAKEUP        =3D 1 << 16,
> >       SCX_RQ_IN_BALANCE       =3D 1 << 17,
> > --
> > 2.47.3
> >
>
> Thanks,
> -Andrea

Thanks,
Emil
