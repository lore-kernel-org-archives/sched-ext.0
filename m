Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357421257E
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759811298; cv=none; b=MHe+kOCPXXBqHG6w7NY8HS0Uxl7PRbhZT4l8F5OwpA6BYO7XXlikFJhrXPaSPQDM5XObVF4j2SpASYlmL3ZrttaenpZFPSf8J7wGFudE6b5xCU1Vm/ct6y6+QeqoZ1YrBh2Il90YnHvFC/m6FdNQW9AzWar5qBDhFwXpF+T+CLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759811298; c=relaxed/simple;
	bh=9yVzn3ZpIshopjvvzCxG+1nC99jPfO2oOkje86bLalw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nK/AAZW+hASVXfTpk07WfBUT6d2o0GOxyCNLeEU13mzTm/87+byJDLBsqgCvHuY5t8Z4DkxrevuW6o4fYLUQRG0KhzJoYvpn/oe2ZWy2tJ+0y+WykksvQ5kEYflbP+BLU7CaNVUl5zx7k/0iJz6PjHhbZL0YXD/DO6NQaRpPPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Yd7ChhS0; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Yd7ChhS0"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63bbf5f77daso3363225d50.3
        for <sched-ext@lists.linux.dev>; Mon, 06 Oct 2025 21:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1759811295; x=1760416095; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24nmEMKW5sAHhorNG5XT+pmsvvkx9tjAqyzOdDrY5Ik=;
        b=Yd7ChhS0MyXJvBYf+cLMhiG6FUzhZY/YZXA/wJxVegXL+RFL+sVBt6bHEOK7Fl8gXf
         xBIFOHNJj4NiNBo6sGxmLnch4NULImdgesiG2SEowSCVhU2ITWwezL3bLR+2LmCGUKI6
         zPYXPtMVYvCS+yFBfCPTpXmaNFB3PuBvyH6qq9t1oUWRXkQcZ924KqtLxkwdkPiwf+Yd
         n/uV6bwzDxUZktksSqwDQPyrcmXTs/HajVCnCSq/qtdVs7m/ftQ8TrwmyIFAgqsvYe0o
         uTYrRdtIJMTCzoVWwxsQUnPhg8a8W7l5uVuCpo3jcChdOlODFnlpNxk4QiaWJxQwXyMZ
         5oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759811295; x=1760416095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24nmEMKW5sAHhorNG5XT+pmsvvkx9tjAqyzOdDrY5Ik=;
        b=INS7yyKRU/XvA2fhaABhOk3khrcR7LdegKItCHGi4mPh4v+aiModj32vMxUs2VKUjy
         sPEdiBhcC9OLzFMLyGfKS61cY7tioyoqdlEvSIv88IRBG5NYRuXIKq/fOZFMyVEunvVF
         ITHQ6hp9O81b/9DoK1DDlDxbNIbPqSv/v6f4hwyaGsW5UNVP2K9N9f7J1ijw/aooiQuG
         jtyyadrWH8XEwxZQbtDgcWesh0XPpkiMPg3O0sSGDdXyHTADiljLmDN8wnkReAAq+O5s
         4zEba37W5KnsXklAIu4b/pkFev09wDLpCwvlzzINncI2nWrzq4FNImcrB2Q/Z2n0k/yW
         z6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJwX9uXPLLhuuoKu5brq7vpIsbFShVXp1Q24UPyRLQqWYj/WQFfCriXK1dta4ZZENU0trwiIKIEUM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzPPKzBgnuDGYADhpXPdPjuCPKIKlsXwmmxtIzbMiCWFLj5ZL3x
	PodXr9IaCF4lE0seRjbfu2D3Tec+PqCt9Y6iZ+Njqb3PWt1CXzgK57D0jpbrr+VZefWpmdItz2X
	sMLnnjHTtcyCWCstuA4GR/duY2zQ78DKp/qa6Jt45iA==
X-Gm-Gg: ASbGncuubSK7foLe7SP7FWWCv/2zCXVeC+mEm5YXK0RRvRCJlzQfvgDxp3Tl0gERz49
	qOo5QhNi92N9SdfEXlLeUrdM6b8DQfR39Ykg3W5IvQfKS4Uux/NSd55DKTBWTrFImjoNTX661++
	+LW/sZ0Hyx7XPwvMMDKD+nCMJ0Dyt15tH+lnMlsSRpGQfmHGTs6chVjSyJFuacEU+inIWl952SC
	31+3xK+94+3hCOKLCFXpGbzquN7/wXJdg==
X-Google-Smtp-Source: AGHT+IGhzTiWkfdI87vr+ql7n+ls2Q2mwQkq/hCmiGc/TFbmSh7pEvaPN+t3bx0U4a3klTVgRIv9BVvw0gk8VfEm9CA=
X-Received: by 2002:a53:b6ca:0:b0:62c:70de:7c9a with SMTP id
 956f58d0204a3-63b9a060c6bmr11169835d50.11.1759811294975; Mon, 06 Oct 2025
 21:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007015147.2496026-1-tj@kernel.org> <20251007015147.2496026-5-tj@kernel.org>
In-Reply-To: <20251007015147.2496026-5-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Tue, 7 Oct 2025 00:28:04 -0400
X-Gm-Features: AS18NWCFvNvrwtrBiaqOBKljQaSigyxHunXr9Ns6gQbxc73Qy4enNSRBK5aC_IM
Message-ID: <CABFh=a5wpYf-ZRTKqUhGQLynMXt4ABowfuqNS11cU6Yw-Pa5Jg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched_ext: Make scx_bpf_dsq_insert*() return bool
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:51=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> In preparation for hierarchical schedulers, change scx_bpf_dsq_insert() a=
nd
> scx_bpf_dsq_insert_vtime() to return bool instead of void. With
> sub-schedulers, there will be no reliable way to guarantee a task is stil=
l
> owned by the sub-scheduler at insertion time (e.g., the task may have bee=
n
> migrated to another scheduler). The bool return value will enable
> sub-schedulers to detect and gracefully handle insertion failures.
>
> For the root scheduler, insertion failures will continue to trigger sched=
uler
> abort via scx_error(), so existing code doesn't need to check the return
> value. Backward compatibility is maintained through compat wrappers.
>
> Also update scx_bpf_dsq_move() documentation to clarify that it can retur=
n
> false for sub-schedulers when @dsq_id points to a disallowed local DSQ.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c                       | 45 ++++++++++++++++++------
>  tools/sched_ext/include/scx/common.bpf.h |  3 +-
>  tools/sched_ext/include/scx/compat.bpf.h | 23 ++++++++++--
>  3 files changed, 56 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index a34e731229de..399e53c8939c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5323,8 +5323,12 @@ __bpf_kfunc_start_defs();
>   * exhaustion. If zero, the current residual slice is maintained. If
>   * %SCX_SLICE_INF, @p never expires and the BPF scheduler must kick the =
CPU with
>   * scx_bpf_kick_cpu() to trigger scheduling.
> + *
> + * Returns %true on successful insertion, %false on failure. On the root
> + * scheduler, %false return triggers scheduler abort and the caller does=
n't need
> + * to check the return value.
>   */
> -__bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u=
64 slice,
> +__bpf_kfunc bool scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u=
64 slice,
>                                     u64 enq_flags)
>  {
>         struct scx_sched *sch;
> @@ -5332,10 +5336,10 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_s=
truct *p, u64 dsq_id, u64 slice
>         guard(rcu)();
>         sch =3D rcu_dereference(scx_root);
>         if (unlikely(!sch))
> -               return;
> +               return false;
>
>         if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -               return;
> +               return false;
>
>         if (slice)
>                 p->scx.slice =3D slice;
> @@ -5343,13 +5347,24 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_s=
truct *p, u64 dsq_id, u64 slice
>                 p->scx.slice =3D p->scx.slice ?: 1;
>
>         scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
> +
> +       return true;
> +}
> +
> +/*
> + * COMPAT: Will be removed in v6.23.
> + */
> +__bpf_kfunc void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 =
dsq_id,
> +                                            u64 slice, u64 enq_flags)
> +{
> +       scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags);
>  }
>
> -static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_stru=
ct *p,
> +static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_stru=
ct *p,
>                                  u64 dsq_id, u64 slice, u64 vtime, u64 en=
q_flags)
>  {
>         if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -               return;
> +               return false;
>
>         if (slice)
>                 p->scx.slice =3D slice;
> @@ -5359,6 +5374,8 @@ static void scx_dsq_insert_vtime(struct scx_sched *=
sch, struct task_struct *p,
>         p->scx.dsq_vtime =3D vtime;
>
>         scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRI=
Q);
> +
> +       return true;
>  }
>
>  struct scx_bpf_dsq_insert_vtime_args {
> @@ -5394,8 +5411,12 @@ struct scx_bpf_dsq_insert_vtime_args {
>   * function must not be called on a DSQ which already has one or more FI=
FO tasks
>   * queued and vice-versa. Also, the built-in DSQs (SCX_DSQ_LOCAL and
>   * SCX_DSQ_GLOBAL) cannot be used as priority queues.
> + *
> + * Returns %true on successful insertion, %false on failure. On the root
> + * scheduler, %false return triggers scheduler abort and the caller does=
n't need
> + * to check the return value.
>   */
> -__bpf_kfunc void
> +__bpf_kfunc bool
>  __scx_bpf_dsq_insert_vtime(struct task_struct *p,
>                            struct scx_bpf_dsq_insert_vtime_args *args)
>  {
> @@ -5405,10 +5426,10 @@ __scx_bpf_dsq_insert_vtime(struct task_struct *p,
>
>         sch =3D rcu_dereference(scx_root);
>         if (unlikely(!sch))
> -               return;
> +               return false;
>
> -       scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice, args->vti=
me,
> -                            args->enq_flags);
> +       return scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice,
> +                                   args->vtime, args->enq_flags);
>  }
>
>  /*
> @@ -5432,6 +5453,7 @@ __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert___compat, KF_RCU)
>  BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
> @@ -5686,8 +5708,9 @@ __bpf_kfunc void scx_bpf_dsq_move_set_vtime(struct =
bpf_iter_scx_dsq *it__iter,
>   * Can be called from ops.dispatch() or any BPF context which doesn't ho=
ld a rq
>   * lock (e.g. BPF timers or SYSCALL programs).
>   *
> - * Returns %true if @p has been consumed, %false if @p had already been =
consumed
> - * or dequeued.
> + * Returns %true if @p has been consumed, %false if @p had already been
> + * consumed, dequeued, or, for sub-scheds, @dsq_id points to a disallowe=
d local
> + * DSQ.
>   */
>  __bpf_kfunc bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
>                                   struct task_struct *p, u64 dsq_id,
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index b1c2a0dde76e..522c90d0ced2 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -62,8 +62,7 @@ s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
>  s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake=
_flags, bool *is_idle) __ksym;
>  s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask=
 *cpus_allowed,
>                              struct scx_bpf_select_cpu_and_args *args) __=
ksym __weak;
> -void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u6=
4 enq_flags) __ksym __weak;
> -void __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_ds=
q_insert_vtime_args *args) __ksym __weak;
> +bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_ds=
q_insert_vtime_args *args) __ksym __weak;
>  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>  void scx_bpf_dispatch_cancel(void) __ksym;
>  bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index e172de696f99..33c26928f4e9 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -196,7 +196,7 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 pre=
v_cpu, u64 wake_flags,
>   * Inline wrapper that packs scalar arguments into a struct and calls
>   * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for de=
tails.
>   */
> -static inline void
> +static inline bool
>  scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u=
64 vtime,
>                          u64 enq_flags)
>  {
> @@ -208,10 +208,29 @@ scx_bpf_dsq_insert_vtime(struct task_struct *p, u64=
 dsq_id, u64 slice, u64 vtime
>                         .enq_flags =3D enq_flags,
>                 };
>
> -               __scx_bpf_dsq_insert_vtime(p, &args);
> +               return __scx_bpf_dsq_insert_vtime(p, &args);
>         } else {
>                 scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime=
,
>                                                   enq_flags);
> +               return true;
> +       }
> +}
> +
> +/*
> + * v6.19: scx_bpf_dsq_insert() now returns bool instead of void. Move
> + * scx_bpf_dsq_insert() decl to common.bpf.h and drop compat helper afte=
r v6.22.
> + */
> +bool scx_bpf_dsq_insert___new(struct task_struct *p, u64 dsq_id, u64 sli=
ce, u64 enq_flags) __ksym __weak;
> +void scx_bpf_dsq_insert___compat(struct task_struct *p, u64 dsq_id, u64 =
slice, u64 enq_flags) __ksym __weak;
> +
> +static inline bool
> +scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq=
_flags)
> +{
> +       if (bpf_ksym_exists(scx_bpf_dsq_insert___new)) {
> +               return scx_bpf_dsq_insert___new(p, dsq_id, slice, enq_fla=
gs);
> +       } else {
> +               scx_bpf_dsq_insert___compat(p, dsq_id, slice, enq_flags);
> +               return true;
>         }
>  }
>


> --
> 2.51.0
>
>
