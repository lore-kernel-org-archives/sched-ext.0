Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC0314A73
	for <sched-ext@lists.linux.dev>; Thu, 23 Oct 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228276; cv=none; b=cxHMbNkzK9dVzYQr7yQ0YhIir4JYRzMbA4g0yz0orvPS8eT6lTOU4tzTEG3JdVZ3XGQJ/iA6Xsxs0MStKaQ73SJnJ/+k9mT5fyuALOC9MUOPo3gSxWLGOkewhu7MlaZp2RuGEiWcEnCSAXLEAbN6JkM/jY2PlPwOwNqpuRiqSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228276; c=relaxed/simple;
	bh=5GiTTJ/V4N6ZMDGl9YJyFnN1W24wDkPrKk2JEhAebdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=il3yM/Nkcc4DgT5qWFTWg9zmWI6RnY4yT2xbQGVxkDJ2Rlg6H8ZvV/gfnWPO9S/w8b2++xiD1ssy6Ai2LCks5OIPyb5cHZwKsRGfkmpxfBXL8LJ0gGD2uSX7ZinNfOFEcG8vbhlGM3o8ZaJ56UKa71pZ1CrBSORwEEFTRBYEclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=wdKlHEnX; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="wdKlHEnX"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63e1c0fd7ddso914995d50.0
        for <sched-ext@lists.linux.dev>; Thu, 23 Oct 2025 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1761228273; x=1761833073; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8J8W/4L7ibTLS0Bia7yvTTNJ+W7TrnhRbawnUFjqqNQ=;
        b=wdKlHEnXnvurvd7TdIx8DB2i+D7A5LcN5ka867JV+NDE8Eji4vtsq0iRqJeTt7ctGk
         eRVX71BN1dZAC0Eiw7yKcfMqG8Z3N+Ta38J/1d0+xK3xIL67zoQoZC6wtHV2hwedYz2R
         hfeboFmUa4WYcf9Omb2yYAHTaHa71C5UUw+A3bccQWRkbGxfh4P4tFuJDkyTi1evsCf9
         Rb03sthiG+3WSuvMkTrlX0A5e9CAPScKmEyNRgxYvEAG6al+6Gtuxpx7Wr8vXXq4pLdw
         sd190L7DzWU5xQOScmVo4kRbEJ1swphkiHbw3g9t0NtTWAivf9tEAsJEYzGbiJ/Wsh/i
         QayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228273; x=1761833073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8J8W/4L7ibTLS0Bia7yvTTNJ+W7TrnhRbawnUFjqqNQ=;
        b=Nkgyd4+RFZZKWTeG2FfCjDdzwP8OuXW1XhLAx4uTUYIYJ2vBnr0R1Y8Dw8kg4Ec9Yh
         CUn43dHqClOBDasE1822wYj2bmNv6vW//X+vokTASxqi1B0+k2v8mOAr9iNC7AOiVsUo
         Uovs78WjPPIF3P0Hzmhv89JublsYzbsGsRUWzDFy6ByLDstfIIL/PCo7g1px5uBdEQ9W
         DmkI0jyoAe7vMkD3MPBmDlcwtu/9tvxHKJab5ohZ4jjA/C0DoTjDno8ZE79vsttHGiWE
         a49CVquh27WZ+BmzZ1nLe1iXtvYkO3bMTkzjCN/Y/mIeAb/r53XuXZeu5m9egHqkxqEy
         cXLA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0pj3vQbXayWuTaJfzMgFSO5RTJlw4pvDL/Nmcxs3JXusno6zRNqaAAQ4CRskaz8i35SA+pOMeZQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzemZ2BpuK+QCA1SU06niu5J6FRtO337dCP7eZByksHRMpjIw6z
	MjCKouvd44lH7QVk7JmcWQmjbV3+ge+YkE1TATbI8o1gK9AGoTfoGp8tmJq+MtbFhNbb3KDT3B0
	R34qeQZC7d5XzqWQgSrKaC1tcUa1jw4GH/tZmoTGjGw==
X-Gm-Gg: ASbGncukUqjglUID3/jUg164oMgSMDRJ4S7OL6AdOmFpYFhDARfH4ee0B+IThhyvwe9
	zO+PaG0ABHdRv0cvuZE9un7igAWaocncUd0ArKeV1KkOuvMOq7YhcbdB2X9P+FSiajlB82YhTe2
	C+ENKP2UzS+4sO6Rc+TsKiLcWG3CwxlMWhlmAORy2Ho8tAl5u2vJxdRJSjEE3ReL9ljINgHfkNs
	GhXuDCYhBWnKSTiJyiQIS2p5wMJYSpt8Y9FAapiQjYAgQhBIdViyk12+NNFXHA=
X-Google-Smtp-Source: AGHT+IGjkj4Vq+RYZ1BNhqghj1MG0T/9n6DAldT6/wV4FPLBWGPt1qZo28oeUBDysRpcui7hFmQ1+8o6Ij5ujeyDl6k=
X-Received: by 2002:a05:690e:1699:b0:63e:27e6:87a2 with SMTP id
 956f58d0204a3-63e27e68918mr13009967d50.46.1761228249887; Thu, 23 Oct 2025
 07:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023080130.76761-1-arighi@nvidia.com>
In-Reply-To: <20251023080130.76761-1-arighi@nvidia.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Thu, 23 Oct 2025 10:03:58 -0400
X-Gm-Features: AWmQ_bkyx9eKFwXSoUOomaXE-OysM83cIrNTnVb2dOkFLwm_-z0p1_rPmf4bW7c
Message-ID: <CABFh=a7EZQanSX+=of5A41Kwy83YDmu-AoGJ5hCns8YNkJ2FxA@mail.gmail.com>
Subject: Re: [PATCH v3 sched_ext/for-6.19] sched_ext/tools: Add compat layer
 for kfuncs using struct *_args
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:01=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> Commit c0d630ba347c7 ("sched_ext: Wrap kfunc args in struct to prepare
> for aux__prog") introduced new kfuncs that take their scalar arguments
> packed into dedicated *_args structs.
>
> However, these new kfuncs need to coexist with the previous scalar
> variants, which causes build failures in sched_ext schedulers when
> building against older kernels.
>
> To address this, mirror the struct definitions adding a __COMPAT prefix,
> ensuring schedulers can still build also on old kernels that don't have
> the BTF definitions for these structs.
>
> Moreover, add a __COMPAT_bpf_ksym_exists() helper, which extends
> bpf_ksym_exists() to handle static inline kfunc wrappers and fall back
> to the *___compat() variants, where available.
>
> Fixes: c0d630ba347c7 ("sched_ext: Wrap kfunc args in struct to prepare fo=
r aux__prog")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

Tested the patch on a 6.17 and a 6.19 system, binaries run on both
when compiled on either.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> Changes v2 -> v3:
>  - Drop the ___v2() suffix from the new kfuncs (Tejun)
>  - Add __COMPAT_bpf_ksym_exists() to handle kfunc detection with static
>    inline wrappers
>  - Link to v2: https://lore.kernel.org/all/20251022153610.20111-1-arighi@=
nvidia.com/
>
> ChangeLog v1 -> v2:
>  - Introduce __COMPAT_* struct to fix build error with v6.19 (thanks Emil=
)
>
>  tools/sched_ext/include/scx/common.bpf.h |  3 --
>  tools/sched_ext/include/scx/compat.bpf.h | 36 +++++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index e65b1eb668ea5..64e5411d04c04 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -60,9 +60,6 @@ static inline void ___vmlinux_h_sanity_check___(void)
>
>  s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
>  s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake=
_flags, bool *is_idle) __ksym;
> -s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask=
 *cpus_allowed,
> -                            struct scx_bpf_select_cpu_and_args *args) __=
ksym __weak;
> -bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_ds=
q_insert_vtime_args *args) __ksym __weak;
>  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>  void scx_bpf_dispatch_cancel(void) __ksym;
>  bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index a023b71991a6a..d534cacb94066 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -15,6 +15,13 @@
>         __ret;                                                           =
       \
>  })
>
> +/*
> + * Extended version of bpf_ksym_exists() that handles static inline kfun=
c
> + * wrappers, falling back to the *___compat versions.
> + */
> +#define __COMPAT_bpf_ksym_exists(sym) \
> +       (__builtin_constant_p(!!sym) ? bpf_ksym_exists(sym##___compat) : =
!!sym)
> +
>  /*
>   * v6.15: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
>   *
> @@ -161,6 +168,27 @@ static inline struct task_struct *__COMPAT_scx_bpf_c=
pu_curr(int cpu)
>         return rq ? rq->curr : NULL;
>  }
>
> +/*
> + * v6.19: Mirror the following _args structs, to prevent build errors in
> + * kernels that don't have these structs defined yet.
> + *
> + * The kernel will carry these __COMPAT_* structs until v6.23 (see below=
).
> + */
> +#define scx_bpf_select_cpu_and_args __COMPAT_scx_bpf_select_cpu_and_args
> +struct __COMPAT_scx_bpf_select_cpu_and_args {
> +       s32 prev_cpu;
> +       u64 wake_flags;
> +       u64 flags;
> +};
> +
> +#define scx_bpf_dsq_insert_vtime_args __COMPAT_scx_bpf_dsq_insert_vtime_=
args
> +struct __COMPAT_scx_bpf_dsq_insert_vtime_args {
> +       u64 dsq_id;
> +       u64 slice;
> +       u64 vtime;
> +       u64 enq_flags;
> +};
> +
>  /*
>   * v6.19: To work around BPF maximum parameter limit, the following kfun=
cs are
>   * replaced with variants that pack scalar arguments in a struct. Wrappe=
rs are
> @@ -170,9 +198,15 @@ static inline struct task_struct *__COMPAT_scx_bpf_c=
pu_curr(int cpu)
>   * compatibility. After v6.23 release, remove the compat handling and mo=
ve the
>   * wrappers to common.bpf.h.
>   */
> +s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask=
 *cpus_allowed,
> +                            struct scx_bpf_select_cpu_and_args *args) __=
ksym __weak;
>  s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu,=
 u64 wake_flags,
>                                     const struct cpumask *cpus_allowed, u=
64 flags) __ksym __weak;
> -void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id=
, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
> +
> +bool __scx_bpf_dsq_insert_vtime(struct task_struct *p,
> +                               struct scx_bpf_dsq_insert_vtime_args *arg=
s) __ksym __weak;
> +void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p,
> +                               u64 dsq_id, u64 slice, u64 vtime, u64 enq=
_flags) __ksym __weak;
>
>  /**
>   * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
> --
> 2.51.1
>
