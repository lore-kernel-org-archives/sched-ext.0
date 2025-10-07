Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53FC15B971
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759804947; cv=none; b=d6TGJwMCXudyPmWQszVN/V9Zx/oqHBhnQ0bx8MVFVH6Ws17pqLIjuov7WhhvrnC8Fjct0OCVIRyA5DjFCBUn1prcDFGiZ4Ur/PF1G/GEDkIUN6wCD9/tztuTqZ0Hkxq4YMF9o8h6cDF24XymHDxJtiySUWWg6B+ieKbEBbzZV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759804947; c=relaxed/simple;
	bh=vQ3kfThJ+B6FqlBGFOYIbrGpqC6cpR27alGZUPVQcuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUf8s9TuWYDJlVk4z61M3Ar4n0WCSmBu/fl6wtZe0ZrI1QuWpt60jAT6CU7HpWBNib33P/hFczXTvM9U8min2/Df2sU7U+dFNq+FuBJM28JRHc10QkMXoW02e0R1CS11KqAmcknNAKtxTpyUXbF5PeHvYWnxSsvfOiE4nnXCoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=wVxKejPk; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="wVxKejPk"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-77f9fb3bea0so34535667b3.3
        for <sched-ext@lists.linux.dev>; Mon, 06 Oct 2025 19:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1759804943; x=1760409743; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJJXSocIAL6d/Bpq3kH86vAsjqJcY+URr6JsazLoh9w=;
        b=wVxKejPki0gln79Gw4fDkbQ6PWAeYK/wtC6ndYNkXEOZn3Fgk3Rp9sKosGv92qg7xx
         doa6a9Fmc8DItpKHsmAhxMdrDMdiK5pzVsty4NkKtr4u8Qzq53/LWxMLABsaHHSorrWb
         puHGG+Hf7Om7Pxex/JlZAFK+qWCNlAPezx1/ZW9R3noPLsFRWyJ/bsGTHGqEIMY/SbfE
         Kvf1f1faFmdSFrA4EorTxo51rINqcaHpUdMMjd8ughOkv9Uow3QL0K099I1mMOk73beK
         zK5bWa/G3SEG6ahw2Z+HEPS9y2+qFjH9XrrnIcIR4J9L1GE86ESUJfma1MFitYKAsImq
         SM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759804943; x=1760409743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJJXSocIAL6d/Bpq3kH86vAsjqJcY+URr6JsazLoh9w=;
        b=C+IieglepiRaIRohSzbsop+TnLWORls2sJWyLSm7sm619YBPYhIQpK7oVrGOwFlO4g
         4dvCHzbhsR6qq+GfAyycaQOpmQK/U1UrgG+x62HOzTwTybFfOU81IyqInHOrEnkOsflx
         V9jX39AJahQjivt0FruVoXs126GIhY82rwoogfh22N2bvCyHaTAco2uPtRz4cvx3o6hx
         FkjzN+FTeh1Xc/pOHgrpUJTESoNsy70AM5IWYQWIsJ9QeBNGWUK78OqP0pJGhtVWvacb
         7SXksK57LNKXYa35yVEf2uCfxtvBbj8NeHz2E0jhVhOZ6cA9ZG2eYL2ZcwOZIzcYbhLY
         L3xw==
X-Forwarded-Encrypted: i=1; AJvYcCXun+jKuqeDK2IhO8yK7nCZeq+WDYj7/zrGC/92RtGGDg4+nriSzC+Ku4OSSnA1DefW5i1LjE+krYY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+U3kihJmwreNduYKYfA6rmxkK6RGu73QqU/4KZtRgU2eeq5ix
	du/2JoHHvyZTF0OiM7auF6eLZdoDHgr0AAPNeG/M/zb0eKZkUQCJb34Y3+ZW3+NEWuOTVyoccv6
	vY7j9rtsNX4xybt8/KBXmHx5FZA1IPX9eIMKUlM7r5w==
X-Gm-Gg: ASbGncuRuG9PTfEBv7ceJf5LO+Rkf5emJr6uCkddlTqMozIJLdyt64VetQk4U9NJ+YU
	uJQXVOCNsumrIIBz26F9s3SgkbA4I2IyjdgVXwm9rvkeW3PhJbd+eVPs57dAFi2LCEuqXbCtf43
	eBFjw+kvdcXSet3MUqJBrS785SHtlemsogvknsSBnMKdzS5JL0a4RCosxX2spfy5yi+NYw8XSKW
	7Tg2SR1gt3dbJBlq1F1eg2Dmq42fm/gqCrm7WCvnTOh
X-Google-Smtp-Source: AGHT+IGJpWVaWiCCLJHDTuo/2QqJfnkxwBXkxj3XLILimYnoTb3zX9QH506JbcG27eoF9Wld41tbm4ThiBtF0WiBlig=
X-Received: by 2002:a05:690e:441:b0:635:4ece:240c with SMTP id
 956f58d0204a3-63b9a0f33a9mr12290886d50.44.1759804943412; Mon, 06 Oct 2025
 19:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007015147.2496026-1-tj@kernel.org> <20251007015147.2496026-2-tj@kernel.org>
In-Reply-To: <20251007015147.2496026-2-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 6 Oct 2025 22:42:12 -0400
X-Gm-Features: AS18NWDgiH8Eos9Y-ZZcXRMwCnor5NEXACLShcYZCCEM5_Ffxa0ul2-gzBsFcBE
Message-ID: <CABFh=a6XD5jD1e1OS=W6iPMOdGYK7rjGvc8cZ=E7-mtvtyXnKQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools/sched_ext: Strip compatibility macros for
 cgroup and dispatch APIs
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:51=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Enough time has passed since the introduction of scx_bpf_task_cgroup() an=
d
> the scx_bpf_dispatch* -> scx_bpf_dsq* kfunc renaming. Strip the compatibi=
lity
> macros.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/sched_ext/include/scx/compat.bpf.h | 108 +----------------------
>  tools/sched_ext/scx_flatcg.bpf.c         |  10 +--
>  tools/sched_ext/scx_qmap.bpf.c           |  14 ++-
>  3 files changed, 12 insertions(+), 120 deletions(-)
>
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index dd9144624dc9..d979f16a3ae2 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -15,121 +15,17 @@
>         __ret;                                                           =
       \
>  })
>
> -/* v6.12: 819513666966 ("sched_ext: Add cgroup support") */
> -#define __COMPAT_scx_bpf_task_cgroup(p)                                 =
               \
> -       (bpf_ksym_exists(scx_bpf_task_cgroup) ?                          =
       \
> -        scx_bpf_task_cgroup((p)) : NULL)
> -
>  /*
> - * v6.13: The verb `dispatch` was too overloaded and confusing. kfuncs a=
re
> - * renamed to unload the verb.
> - *
> - * Build error is triggered if old names are used. New binaries work wit=
h both
> - * new and old names. The compat macros will be removed on v6.15 release=
.
> + * v6.15: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
>   *
> - * scx_bpf_dispatch_from_dsq() and friends were added during v6.12 by
> - * 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq=
()").
> - * Preserve __COMPAT macros until v6.15.
> + * Compat macro will be dropped on v6.19 release.
>   */
> -void scx_bpf_dispatch___compat(struct task_struct *p, u64 dsq_id, u64 sl=
ice, u64 enq_flags) __ksym __weak;
> -void scx_bpf_dispatch_vtime___compat(struct task_struct *p, u64 dsq_id, =
u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
> -bool scx_bpf_consume___compat(u64 dsq_id) __ksym __weak;
> -void scx_bpf_dispatch_from_dsq_set_slice___compat(struct bpf_iter_scx_ds=
q *it__iter, u64 slice) __ksym __weak;
> -void scx_bpf_dispatch_from_dsq_set_vtime___compat(struct bpf_iter_scx_ds=
q *it__iter, u64 vtime) __ksym __weak;
> -bool scx_bpf_dispatch_from_dsq___compat(struct bpf_iter_scx_dsq *it__ite=
r, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
> -bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *i=
t__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
>  int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz)=
 __ksym __weak;
>
> -#define scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags)                 =
               \
> -       (bpf_ksym_exists(scx_bpf_dsq_insert) ?                           =
       \
> -        scx_bpf_dsq_insert((p), (dsq_id), (slice), (enq_flags)) :       =
       \
> -        scx_bpf_dispatch___compat((p), (dsq_id), (slice), (enq_flags)))
> -
> -#define scx_bpf_dsq_insert_vtime(p, dsq_id, slice, vtime, enq_flags)    =
       \
> -       (bpf_ksym_exists(scx_bpf_dsq_insert_vtime) ?                     =
       \
> -        scx_bpf_dsq_insert_vtime((p), (dsq_id), (slice), (vtime), (enq_f=
lags)) : \
> -        scx_bpf_dispatch_vtime___compat((p), (dsq_id), (slice), (vtime),=
 (enq_flags)))
> -
> -#define scx_bpf_dsq_move_to_local(dsq_id)                               =
       \
> -       (bpf_ksym_exists(scx_bpf_dsq_move_to_local) ?                    =
       \
> -        scx_bpf_dsq_move_to_local((dsq_id)) :                           =
       \
> -        scx_bpf_consume___compat((dsq_id)))
> -
> -#define __COMPAT_scx_bpf_dsq_move_set_slice(it__iter, slice)            =
       \
> -       (bpf_ksym_exists(scx_bpf_dsq_move_set_slice) ?                   =
       \
> -        scx_bpf_dsq_move_set_slice((it__iter), (slice)) :               =
       \
> -        (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_slice___compat) ?=
       \
> -         scx_bpf_dispatch_from_dsq_set_slice___compat((it__iter), (slice=
)) :   \
> -         (void)0))
> -
> -#define __COMPAT_scx_bpf_dsq_move_set_vtime(it__iter, vtime)            =
       \
> -       (bpf_ksym_exists(scx_bpf_dsq_move_set_vtime) ?                   =
       \
> -        scx_bpf_dsq_move_set_vtime((it__iter), (vtime)) :               =
       \
> -        (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_vtime___compat) ?=
       \
> -         scx_bpf_dispatch_from_dsq_set_vtime___compat((it__iter), (vtime=
)) :   \
> -         (void) 0))
> -
> -#define __COMPAT_scx_bpf_dsq_move(it__iter, p, dsq_id, enq_flags)       =
       \
> -       (bpf_ksym_exists(scx_bpf_dsq_move) ?                             =
       \
> -        scx_bpf_dsq_move((it__iter), (p), (dsq_id), (enq_flags)) :      =
       \
> -        (bpf_ksym_exists(scx_bpf_dispatch_from_dsq___compat) ?          =
       \
> -         scx_bpf_dispatch_from_dsq___compat((it__iter), (p), (dsq_id), (=
enq_flags)) : \
> -         false))
> -
> -#define __COMPAT_scx_bpf_dsq_move_vtime(it__iter, p, dsq_id, enq_flags) =
               \
> -       (bpf_ksym_exists(scx_bpf_dsq_move_vtime) ?                       =
       \
> -        scx_bpf_dsq_move_vtime((it__iter), (p), (dsq_id), (enq_flags)) :=
       \
> -        (bpf_ksym_exists(scx_bpf_dispatch_vtime_from_dsq___compat) ?    =
       \
> -         scx_bpf_dispatch_vtime_from_dsq___compat((it__iter), (p), (dsq_=
id), (enq_flags)) : \
> -         false))
> -
>  #define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)          \
>         (bpf_ksym_exists(bpf_cpumask_populate) ?                        \
>          (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
>
> -#define scx_bpf_dispatch(p, dsq_id, slice, enq_flags)                   =
       \
> -       _Static_assert(false, "scx_bpf_dispatch() renamed to scx_bpf_dsq_=
insert()")
> -
> -#define scx_bpf_dispatch_vtime(p, dsq_id, slice, vtime, enq_flags)      =
       \
> -       _Static_assert(false, "scx_bpf_dispatch_vtime() renamed to scx_bp=
f_dsq_insert_vtime()")
> -
> -#define scx_bpf_consume(dsq_id) ({                                      =
       \
> -       _Static_assert(false, "scx_bpf_consume() renamed to scx_bpf_dsq_m=
ove_to_local()"); \
> -       false;                                                           =
       \
> -})
> -
> -#define scx_bpf_dispatch_from_dsq_set_slice(it__iter, slice)           \
> -       _Static_assert(false, "scx_bpf_dispatch_from_dsq_set_slice() rena=
med to scx_bpf_dsq_move_set_slice()")
> -
> -#define scx_bpf_dispatch_from_dsq_set_vtime(it__iter, vtime)           \
> -       _Static_assert(false, "scx_bpf_dispatch_from_dsq_set_vtime() rena=
med to scx_bpf_dsq_move_set_vtime()")
> -
> -#define scx_bpf_dispatch_from_dsq(it__iter, p, dsq_id, enq_flags) ({   \
> -       _Static_assert(false, "scx_bpf_dispatch_from_dsq() renamed to scx=
_bpf_dsq_move()"); \
> -       false;                                                           =
       \
> -})
> -
> -#define scx_bpf_dispatch_vtime_from_dsq(it__iter, p, dsq_id, enq_flags) =
({  \
> -       _Static_assert(false, "scx_bpf_dispatch_vtime_from_dsq() renamed =
to scx_bpf_dsq_move_vtime()"); \
> -       false;                                                           =
       \
> -})
> -
> -#define __COMPAT_scx_bpf_dispatch_from_dsq_set_slice(it__iter, slice)   =
       \
> -       _Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq_set_sli=
ce() renamed to __COMPAT_scx_bpf_dsq_move_set_slice()")
> -
> -#define __COMPAT_scx_bpf_dispatch_from_dsq_set_vtime(it__iter, vtime)   =
       \
> -       _Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq_set_vti=
me() renamed to __COMPAT_scx_bpf_dsq_move_set_vtime()")
> -
> -#define __COMPAT_scx_bpf_dispatch_from_dsq(it__iter, p, dsq_id, enq_flag=
s) ({  \
> -       _Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq() renam=
ed to __COMPAT_scx_bpf_dsq_move()"); \
> -       false;                                                           =
       \
> -})
> -
> -#define __COMPAT_scx_bpf_dispatch_vtime_from_dsq(it__iter, p, dsq_id, en=
q_flags) ({  \
> -       _Static_assert(false, "__COMPAT_scx_bpf_dispatch_vtime_from_dsq()=
 renamed to __COMPAT_scx_bpf_dsq_move_vtime()"); \
> -       false;                                                           =
       \
> -})
> -
>  /**
>   * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
>   * in a compatible way. We will preserve this __COMPAT helper until v6.1=
6.
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatc=
g.bpf.c
> index 2c720e3ecad5..43126858b8e4 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -382,7 +382,7 @@ void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *=
p, u64 enq_flags)
>                 return;
>         }
>
> -       cgrp =3D __COMPAT_scx_bpf_task_cgroup(p);
> +       cgrp =3D scx_bpf_task_cgroup(p);
>         cgc =3D find_cgrp_ctx(cgrp);
>         if (!cgc)
>                 goto out_release;
> @@ -508,7 +508,7 @@ void BPF_STRUCT_OPS(fcg_runnable, struct task_struct =
*p, u64 enq_flags)
>  {
>         struct cgroup *cgrp;
>
> -       cgrp =3D __COMPAT_scx_bpf_task_cgroup(p);
> +       cgrp =3D scx_bpf_task_cgroup(p);
>         update_active_weight_sums(cgrp, true);
>         bpf_cgroup_release(cgrp);
>  }
> @@ -521,7 +521,7 @@ void BPF_STRUCT_OPS(fcg_running, struct task_struct *=
p)
>         if (fifo_sched)
>                 return;
>
> -       cgrp =3D __COMPAT_scx_bpf_task_cgroup(p);
> +       cgrp =3D scx_bpf_task_cgroup(p);
>         cgc =3D find_cgrp_ctx(cgrp);
>         if (cgc) {
>                 /*
> @@ -564,7 +564,7 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct =
*p, bool runnable)
>         if (!taskc->bypassed_at)
>                 return;
>
> -       cgrp =3D __COMPAT_scx_bpf_task_cgroup(p);
> +       cgrp =3D scx_bpf_task_cgroup(p);
>         cgc =3D find_cgrp_ctx(cgrp);
>         if (cgc) {
>                 __sync_fetch_and_add(&cgc->cvtime_delta,
> @@ -578,7 +578,7 @@ void BPF_STRUCT_OPS(fcg_quiescent, struct task_struct=
 *p, u64 deq_flags)
>  {
>         struct cgroup *cgrp;
>
> -       cgrp =3D __COMPAT_scx_bpf_task_cgroup(p);
> +       cgrp =3D scx_bpf_task_cgroup(p);
>         update_active_weight_sums(cgrp, false);
>         bpf_cgroup_release(cgrp);
>  }
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 3072b593f898..c67dac78a4c6 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -320,12 +320,9 @@ static bool dispatch_highpri(bool from_timer)
>
>                 if (tctx->highpri) {
>                         /* exercise the set_*() and vtime interface too *=
/
> -                       __COMPAT_scx_bpf_dsq_move_set_slice(
> -                               BPF_FOR_EACH_ITER, slice_ns * 2);
> -                       __COMPAT_scx_bpf_dsq_move_set_vtime(
> -                               BPF_FOR_EACH_ITER, highpri_seq++);
> -                       __COMPAT_scx_bpf_dsq_move_vtime(
> -                               BPF_FOR_EACH_ITER, p, HIGHPRI_DSQ, 0);
> +                       scx_bpf_dsq_move_set_slice(BPF_FOR_EACH_ITER, sli=
ce_ns * 2);
> +                       scx_bpf_dsq_move_set_vtime(BPF_FOR_EACH_ITER, hig=
hpri_seq++);
> +                       scx_bpf_dsq_move_vtime(BPF_FOR_EACH_ITER, p, HIGH=
PRI_DSQ, 0);
>                 }
>         }
>
> @@ -342,9 +339,8 @@ static bool dispatch_highpri(bool from_timer)
>                 else
>                         cpu =3D scx_bpf_pick_any_cpu(p->cpus_ptr, 0);
>
> -               if (__COMPAT_scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p,
> -                                             SCX_DSQ_LOCAL_ON | cpu,
> -                                             SCX_ENQ_PREEMPT)) {
> +               if (scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_=
ON | cpu,
> +                                    SCX_ENQ_PREEMPT)) {
>                         if (cpu =3D=3D this_cpu) {
>                                 dispatched =3D true;
>                                 __sync_fetch_and_add(&nr_expedited_local,=
 1);
> --
> 2.51.0
>
>
