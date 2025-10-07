Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A72E229E
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849401; cv=none; b=UOxJkjo2hLFQVLuf1IHoIBPRAf3t+GfC5pt/52aypudWhPVkZ6j7q2cGzYHtmBJp6xk1CwLoqWgb4Nb/G7WEeVTHlfzDyHF2GGihwlhBX7aYv4pjfJOPX5fulgcwwnCMNLbY213M+oVerdgSwIvnDzAc1uyVRNKvYFcq4mvWPEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849401; c=relaxed/simple;
	bh=kU6fpvI3uzOF1mvu/jMoM2zv3/sCLcjwpUwS1EP9SoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpbFQ9xbSyDEjyxaooIK48DrfoAle8BdP6rytBFNIMLu3IIo04mQVyHsDp3CQC2drWkup3ele1b/vyLdY/+NtaWYBzjJTiK5nKUCQrPQklalUIFcVMtPgb+9KutM+p3m9JWcpaUfI4QtK9ifneCbc+w0/6d8L9YaJqmMCa3Ru4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Tv2bD+0i; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Tv2bD+0i"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-635283199a9so5858621d50.1
        for <sched-ext@lists.linux.dev>; Tue, 07 Oct 2025 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1759849397; x=1760454197; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUv3M5rYcywbh/fyw4pyVGk4NfIlmDJRqReJIDQqxcE=;
        b=Tv2bD+0iijHo7523TVhj0A2XbEGNlRWQjWwF2sNyWoAX3mqHMigi0gzwlESHKvVML4
         FilFcf73W6+v4UjQ4r40qBZilw0aznCPZJb3X74UMFicPnmVQVPEGG/uJjc+YlviGKoc
         2F852je6FEmMwFam/Evjk4rVPnruy+QXEuTNTCI/5fOanFYwW/SArJcvQgC4IFRNj6nr
         653HJLI3XAULXqsZ1EkZIBU/0J4KY/oaqHMhyDwmn27l7sIIiI/jlvR1kKZXDIlpc/xQ
         G8f3NGCLZ1vnJiyaIvTH1H9oD+PGQXksCo7r3/OOuRUM7MX/KLDJCgRcys2p8h+a+FJY
         neQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759849397; x=1760454197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUv3M5rYcywbh/fyw4pyVGk4NfIlmDJRqReJIDQqxcE=;
        b=GvMLdGZwL6UljwDzOVv9OozVmg/2VzZr6qM8xNEs5lrngcz9VjAOfIVUMrEI52uzT3
         F7Xd8AkJb9M8A8lEJQ8yj9zGIyk43ib50O+V7oIyQ8PoOzjjeKuBCTbI/lkIqcigA/lX
         5corp5jenpFqbIjLer+thO7HSYyd3VWAWJrtYj7inDS1UVsqt3IM4/40/k3V9/MelzKu
         AgMhG0qlYyYfzt7FWg404LGABABmUfUCs2FD9uyoC2CbZacWhzXUysnAoRn39FwB6P4x
         aNholIzEgKOvl5lsZsntlqz/FUuoE8ZPw+8hhs1GYnVxQfrFn2SByWUavdCTtP5VYPZe
         KAmA==
X-Forwarded-Encrypted: i=1; AJvYcCUz29+hFXrLQgUxTogopvdFid+/cGhotAqz4H+97g7w6GWtQg8EXVTCNebUZaj+lgKozYIuRRCRuy8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz970kZDrT56J+nMk+sqUYVdlKnF0Xsqb0g7f7KUZbAaNY/r94R
	q5yN/HHqfduiWPVJoC0AqXFgjU4mFSVmCWeD5JyBTAwilHkQp2mOlBIlwvglg99Zmo41ufptps+
	2ogDRWdGYrIeoQ+t0an4JNZ/mijflrtlf3/+yYpMPmg==
X-Gm-Gg: ASbGncsHZbz3QgaN/+NrbN17XcqPLF9rjE/PoJNGW3+Nr8NOYJR+46qaNiCYhRmJZMv
	7SHkRkqzJ/B1WAFiJeekGHZq7wQu46P823fPJNEGBLiMHvkzDDuHdRhaQUR3S+JE6qIgc8MhrEy
	EzNrxfVDKMPmyGKNzj1n2NjinNZ/Io948s6hV+/OuQHeSDzJyu+6wvfRY142v2yXzoyuSV5QSMC
	V3l/9OCq1TVqH6+ME4lqvZgQEDVdZ4ZBw==
X-Google-Smtp-Source: AGHT+IHjsqBELUrwEG6JQke3sUZMEJNlEshBRvaIDZBZ8JoqpnHyWFYfPCLhoLc5h9Uh2uzDIi40VVvsvSPXCyMN4Vo=
X-Received: by 2002:a53:5a01:0:b0:634:75c4:e487 with SMTP id
 956f58d0204a3-63b9a0e0ccbmr12386409d50.25.1759849397175; Tue, 07 Oct 2025
 08:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007015147.2496026-1-tj@kernel.org> <20251007015147.2496026-5-tj@kernel.org>
 <aOTgMIGoeBuOGldz@gpd4>
In-Reply-To: <aOTgMIGoeBuOGldz@gpd4>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Tue, 7 Oct 2025 11:03:04 -0400
X-Gm-Features: AS18NWDNvN4DgF0IdKKTZx7bTiNBFLHiKev-k03FDJ16uUdvGzGUlnRMfzPBtmo
Message-ID: <CABFh=a5QHpNh8CAmw5-REJuz1Qzg0wFEp1ZeArM9O1UCN5ebtQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched_ext: Make scx_bpf_dsq_insert*() return bool
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 5:41=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wro=
te:
>
> On Mon, Oct 06, 2025 at 03:51:47PM -1000, Tejun Heo wrote:
> > In preparation for hierarchical schedulers, change scx_bpf_dsq_insert()=
 and
> > scx_bpf_dsq_insert_vtime() to return bool instead of void. With
> > sub-schedulers, there will be no reliable way to guarantee a task is st=
ill
> > owned by the sub-scheduler at insertion time (e.g., the task may have b=
een
> > migrated to another scheduler). The bool return value will enable
> > sub-schedulers to detect and gracefully handle insertion failures.
> >
> > For the root scheduler, insertion failures will continue to trigger sch=
eduler
> > abort via scx_error(), so existing code doesn't need to check the retur=
n
> > value. Backward compatibility is maintained through compat wrappers.
> >
> > Also update scx_bpf_dsq_move() documentation to clarify that it can ret=
urn
> > false for sub-schedulers when @dsq_id points to a disallowed local DSQ.
> >
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
>
> ...
>
> >  kernel/sched/ext.c                       | 45 ++++++++++++++++++------
> >  tools/sched_ext/include/scx/common.bpf.h |  3 +-
> >  tools/sched_ext/include/scx/compat.bpf.h | 23 ++++++++++--
> >  3 files changed, 56 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index a34e731229de..399e53c8939c 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -5323,8 +5323,12 @@ __bpf_kfunc_start_defs();
> >   * exhaustion. If zero, the current residual slice is maintained. If
> >   * %SCX_SLICE_INF, @p never expires and the BPF scheduler must kick th=
e CPU with
> >   * scx_bpf_kick_cpu() to trigger scheduling.
> > + *
> > + * Returns %true on successful insertion, %false on failure. On the ro=
ot
> > + * scheduler, %false return triggers scheduler abort and the caller do=
esn't need
> > + * to check the return value.
> >   */
> > -__bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id,=
 u64 slice,
> > +__bpf_kfunc bool scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id,=
 u64 slice,
> >                                   u64 enq_flags)
> >  {
> >       struct scx_sched *sch;
> > @@ -5332,10 +5336,10 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task=
_struct *p, u64 dsq_id, u64 slice
> >       guard(rcu)();
> >       sch =3D rcu_dereference(scx_root);
> >       if (unlikely(!sch))
> > -             return;
> > +             return false;
> >
> >       if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> > -             return;
> > +             return false;
> >
> >       if (slice)
> >               p->scx.slice =3D slice;
> > @@ -5343,13 +5347,24 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task=
_struct *p, u64 dsq_id, u64 slice
> >               p->scx.slice =3D p->scx.slice ?: 1;
> >
> >       scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
> > +
> > +     return true;
> > +}
> > +
> > +/*
> > + * COMPAT: Will be removed in v6.23.
> > + */
> > +__bpf_kfunc void scx_bpf_dsq_insert___compat(struct task_struct *p, u6=
4 dsq_id,
> > +                                          u64 slice, u64 enq_flags)
> > +{
> > +     scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags);
> >  }
> >
> > -static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_st=
ruct *p,
> > +static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_st=
ruct *p,
> >                                u64 dsq_id, u64 slice, u64 vtime, u64 en=
q_flags)
> >  {
> >       if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> > -             return;
> > +             return false;
> >
> >       if (slice)
> >               p->scx.slice =3D slice;
> > @@ -5359,6 +5374,8 @@ static void scx_dsq_insert_vtime(struct scx_sched=
 *sch, struct task_struct *p,
> >       p->scx.dsq_vtime =3D vtime;
> >
> >       scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRI=
Q);
> > +
> > +     return true;
> >  }
> >
> >  struct scx_bpf_dsq_insert_vtime_args {
> > @@ -5394,8 +5411,12 @@ struct scx_bpf_dsq_insert_vtime_args {
> >   * function must not be called on a DSQ which already has one or more =
FIFO tasks
> >   * queued and vice-versa. Also, the built-in DSQs (SCX_DSQ_LOCAL and
> >   * SCX_DSQ_GLOBAL) cannot be used as priority queues.
> > + *
> > + * Returns %true on successful insertion, %false on failure. On the ro=
ot
> > + * scheduler, %false return triggers scheduler abort and the caller do=
esn't need
> > + * to check the return value.
> >   */
> > -__bpf_kfunc void
> > +__bpf_kfunc bool
> >  __scx_bpf_dsq_insert_vtime(struct task_struct *p,
> >                          struct scx_bpf_dsq_insert_vtime_args *args)
> >  {
> > @@ -5405,10 +5426,10 @@ __scx_bpf_dsq_insert_vtime(struct task_struct *=
p,
> >
> >       sch =3D rcu_dereference(scx_root);
> >       if (unlikely(!sch))
> > -             return;
> > +             return false;
> >
> > -     scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice, args->vti=
me,
> > -                          args->enq_flags);
> > +     return scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice,
> > +                                 args->vtime, args->enq_flags);
> >  }
> >
> >  /*
> > @@ -5432,6 +5453,7 @@ __bpf_kfunc_end_defs();
> >
> >  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
> >  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
> > +BTF_ID_FLAGS(func, scx_bpf_dsq_insert___compat, KF_RCU)
> >  BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
> >  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
> >  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
> > @@ -5686,8 +5708,9 @@ __bpf_kfunc void scx_bpf_dsq_move_set_vtime(struc=
t bpf_iter_scx_dsq *it__iter,
> >   * Can be called from ops.dispatch() or any BPF context which doesn't =
hold a rq
> >   * lock (e.g. BPF timers or SYSCALL programs).
> >   *
> > - * Returns %true if @p has been consumed, %false if @p had already bee=
n consumed
> > - * or dequeued.
> > + * Returns %true if @p has been consumed, %false if @p had already bee=
n
> > + * consumed, dequeued, or, for sub-scheds, @dsq_id points to a disallo=
wed local
> > + * DSQ.
> >   */
> >  __bpf_kfunc bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
> >                                 struct task_struct *p, u64 dsq_id,
> > diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext=
/include/scx/common.bpf.h
> > index b1c2a0dde76e..522c90d0ced2 100644
> > --- a/tools/sched_ext/include/scx/common.bpf.h
> > +++ b/tools/sched_ext/include/scx/common.bpf.h
> > @@ -62,8 +62,7 @@ s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
> >  s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wa=
ke_flags, bool *is_idle) __ksym;
> >  s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpuma=
sk *cpus_allowed,
> >                            struct scx_bpf_select_cpu_and_args *args) __=
ksym __weak;
> > -void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, =
u64 enq_flags) __ksym __weak;
> > -void __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_=
dsq_insert_vtime_args *args) __ksym __weak;
> > +bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_=
dsq_insert_vtime_args *args) __ksym __weak;
> >  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
> >  void scx_bpf_dispatch_cancel(void) __ksym;
> >  bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> > diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext=
/include/scx/compat.bpf.h
> > index e172de696f99..33c26928f4e9 100644
> > --- a/tools/sched_ext/include/scx/compat.bpf.h
> > +++ b/tools/sched_ext/include/scx/compat.bpf.h
> > @@ -196,7 +196,7 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 p=
rev_cpu, u64 wake_flags,
> >   * Inline wrapper that packs scalar arguments into a struct and calls
> >   * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for =
details.
> >   */
> > -static inline void
> > +static inline bool
> >  scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice,=
 u64 vtime,
> >                        u64 enq_flags)
> >  {
> > @@ -208,10 +208,29 @@ scx_bpf_dsq_insert_vtime(struct task_struct *p, u=
64 dsq_id, u64 slice, u64 vtime
> >                       .enq_flags =3D enq_flags,
> >               };
> >
> > -             __scx_bpf_dsq_insert_vtime(p, &args);
> > +             return __scx_bpf_dsq_insert_vtime(p, &args);
> >       } else {
> >               scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime=
,
> >                                                 enq_flags);
> > +             return true;
> > +     }
> > +}
> > +
> > +/*
> > + * v6.19: scx_bpf_dsq_insert() now returns bool instead of void. Move
> > + * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper af=
ter v6.22.
> > + */
> > +bool scx_bpf_dsq_insert___new(struct task_struct *p, u64 dsq_id, u64 s=
lice, u64 enq_flags) __ksym __weak;
> > +void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id, u6=
4 slice, u64 enq_flags) __ksym __weak;
> > +
> > +static inline bool
> > +scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 e=
nq_flags)
> > +{
> > +     if (bpf_ksym_exists(scx_bpf_dsq_insert___new)) {
>
> I'm confused... where is scx_bpf_dsq_insert___new() defined?
>

CO:RE relocation ignores suffixes if there is no match, so
scx_bpf_dsq_insert___new() defaults to scx_bpf_dsq_insert() in systems
with this patch. When I tested it the symbol resolved to
scx_bpf_dsq_insert(). We're not really matching the name, we're
matching the signature and trying to find a kfunc with the the
scx_bpf_dsq_insert prefix in its name.


> > +             return scx_bpf_dsq_insert___new(p, dsq_id, slice, enq_fla=
gs);
> > +     } else {
> > +             scx_bpf_dsq_insert___compat(p, dsq_id, slice, enq_flags);
> > +             return true;
> >       }
> >  }
> >
> > --
> > 2.51.0
> >
>
> Thanks,
> -Andrea
>
