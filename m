Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95CB2C9D
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853116; cv=none; b=GLOw+4qiCYNAgNszx1ST7T8nY7X2C3oiSHl2IPGK69fTIz+yIm+wWJzMoEN59nslvKkCJvlBi1ts5UClNWJiqrhzURtCBidSvtF/QbmUujgRFHOOGvhiB9k4JQqdRw1BR3zjkZ1WVLilrmxbT6Lj5FFmCFnAZ7RNGQ4Cty9X2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853116; c=relaxed/simple;
	bh=DUEZ3N5Mux8Dv1oSjnxsiiySGYL11OfHPqWOdU1KrHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDisTboAhUO4eW/PzqF+XsiWWH4GltHIGnpHjNASk96lfbpWzrk4r4xk8XnuoJ3ZSdqsIc6XaulevnumDSntpBwvcdPm797YuWLgqxT0zeUW2bw0QLK5S+wq8zI+Jtu7aYweBrQtRku5lo4O2QzaTOugDSeS9J9dwE5TcyLn52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=eoxeaoxR; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="eoxeaoxR"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-633c1b740c5so7398155d50.3
        for <sched-ext@lists.linux.dev>; Tue, 07 Oct 2025 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1759853110; x=1760457910; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oim9J7oUUmK3bNFuatfCuSTgsVMvHsUNI9x/rK5JZOg=;
        b=eoxeaoxRETCCFfbhRq+XBWSUtg+/AxzSvwLy+86yuh5bIYMoMgxdjYNgXBzS+EhY3j
         QwRRFxBdQw2aT6krvyHIzACa+G5q6C/KOt2vLqbg5nbHKDXpC8cKdiuM0wRe4VTBt34W
         RvF0eoAICh5tK7l5wUkBq7/+c2kMtcvtUvyKbkB77kOg3/qZ6qLdGxneWea5s29RUJcB
         ligRL6q/I7WQo3ug6IGkSRM97nT1UHzvWLE+7JhL68GOR2TGYCnPlzq6bKkp9Gt4QGSN
         MQq+cupRrzsSlBvMpJNFtOepSgNUdkQKkIQ2Jiu88eiQV6H3IrstxsUfEey09PkYCpXe
         b8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853110; x=1760457910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oim9J7oUUmK3bNFuatfCuSTgsVMvHsUNI9x/rK5JZOg=;
        b=wtxoTPW6zIqSEeTRUHMTB1K9gpvQXFUmtCsYD56vlEFbFc9rhmgWC2CpI16vI+UCeq
         wyJJ/zSd7Ehm1Q/qxuEgSUvHBC2OeilT+o/QidEadMdYasimvfYLiXt31M41qwnnchTI
         gONRMeakNu8MVmRsWpmlTXRvjk62eqAS7duUYrKFDNrxOVBLjmW0cxBY8KsiJPc+bTPE
         x2QsGBcPD7HcnPfhsIovhEHAa6Un6qYS8ZIq3UR87gBC/JoRfYqIoQbCMXX2ryyhiiFb
         0LzwpaAV4/YDycmwQYG7qXfJpn9NFoVZ7aoTRZaa2Wsn94RBXNLDiIPZ50l9rY/NZjLD
         ML/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlsdo1zQtRR3DqStoTomjSNK9DEQNhPUG0h+PlzxbVpLCOQ8J86Z3skTV1kVNZl8rAgzr2wqL8Z7s=@lists.linux.dev
X-Gm-Message-State: AOJu0YyesLK8T0ptVt5QFIJfFivNu0PpF3R6XOzavqZDBgPqFTzruScA
	4b0eTu3sOo8Ya2oMxgqvpnjwuh/f59rAMH3Cw6cfBW5KsiTVMWzM1HkHhECLVssphJyPhyCVoF5
	+A1tJJN5Yxp8tFC8D7ZtlHIcoFVlG2I8hWmLkYm8lrQ==
X-Gm-Gg: ASbGncvMx043twlV7cMGihGvAWkEfFbu6HhASoBSebgneP4hOEZ0LEknEH44TrTfHJb
	2lmtW9tJre7AZVpMdIFoQK8sFBnob6vak3Yzfv6FHHrYrKGL++iJOYN8vzwlBXxVFheQ/rKChrr
	zBTemHnUgS0Lz+ZRM7oNfhIJtTdQwh7BDBWm5MZRF8cmFBkA5PKiiXgkCo5/eUE9M=
X-Google-Smtp-Source: AGHT+IE+eDUa+80DrutEtRKJ/RpGPOfOJrSB0Eawgudncno0Fuzdzo7rIFG8Lqw1G1h8q3HyrIJ03aWJ33jC6k8uSSs=
X-Received: by 2002:a05:690e:2519:10b0:633:a7cf:bb4a with SMTP id
 956f58d0204a3-63ccb8a370dmr170573d50.23.1759853107994; Tue, 07 Oct 2025
 09:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007015147.2496026-1-tj@kernel.org> <20251007015147.2496026-4-tj@kernel.org>
In-Reply-To: <20251007015147.2496026-4-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Tue, 7 Oct 2025 12:04:56 -0400
X-Gm-Features: AS18NWCXkvGwLXfK2SfnGPYGcWgu28HQaN6iLQBJ0s2QVPEC4mYAffM-jY5ynYE
Message-ID: <CABFh=a4CQ0dJOKKDZPVEMPbFRtmY7z=0Bn00HY7JEke35GQy0g@mail.gmail.com>
Subject: Re: [PATCH 3/4] sched_ext: Wrap kfunc args in struct to prepare for aux__prog
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:51=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and() currently have 5
> parameters. An upcoming change will add aux__prog parameter which will ex=
ceed
> BPF's 5 argument limit.
>
> Prepare by adding new kfuncs __scx_bpf_dsq_insert_vtime() and
> __scx_bpf_select_cpu_and() that take args structs. The existing kfuncs ar=
e
> kept as compatibility wrappers. BPF programs use inline wrappers that det=
ect
> kernel API version via bpf_core_type_exists() and use the new struct-base=
d
> kfuncs when available, falling back to compat kfuncs otherwise. This allo=
ws
> BPF programs to work with both old and new kernels.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c                       | 82 ++++++++++++++++++------
>  kernel/sched/ext_idle.c                  | 43 +++++++++++--
>  tools/sched_ext/include/scx/common.bpf.h |  6 +-
>  tools/sched_ext/include/scx/compat.bpf.h | 72 +++++++++++++++++++++
>  4 files changed, 173 insertions(+), 30 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6d76efaaa9b2..a34e731229de 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5345,54 +5345,94 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_s=
truct *p, u64 dsq_id, u64 slice
>         scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
>  }
>
> +static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_stru=
ct *p,
> +                                u64 dsq_id, u64 slice, u64 vtime, u64 en=
q_flags)
> +{
> +       if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> +               return;
> +
> +       if (slice)
> +               p->scx.slice =3D slice;
> +       else
> +               p->scx.slice =3D p->scx.slice ?: 1;
> +

Though the ?:1 logic is already in the code: I assume the rationale is
that we want the slice to be immediately exhausted so that the BPF
scheduler refills it with the right value, which makes sense.

> +       p->scx.dsq_vtime =3D vtime;
> +
> +       scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRI=
Q);
> +}
> +
> +struct scx_bpf_dsq_insert_vtime_args {
> +       /* @p can't be packed together as KF_RCU is not transitive */
> +       u64                     dsq_id;
> +       u64                     slice;
> +       u64                     vtime;
> +       u64                     enq_flags;
> +};
> +
>  /**
> - * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queu=
e of a DSQ
> + * __scx_bpf_dsq_insert_vtime - Arg-wrapped vtime DSQ insertion
>   * @p: task_struct to insert
> - * @dsq_id: DSQ to insert into
> - * @slice: duration @p can run for in nsecs, 0 to keep the current value
> - * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> - * @enq_flags: SCX_ENQ_*
> + * @args: struct containing the rest of the arguments
> + *       @args->dsq_id: DSQ to insert into
> + *       @args->slice: duration @p can run for in nsecs, 0 to keep the c=
urrent value
> + *       @args->vtime: @p's ordering inside the vtime-sorted queue of th=
e target DSQ
> + *       @args->enq_flags: SCX_ENQ_*
>   *
> - * Insert @p into the vtime priority queue of the DSQ identified by @dsq=
_id.
> - * Tasks queued into the priority queue are ordered by @vtime. All other=
 aspects
> - * are identical to scx_bpf_dsq_insert().
> + * Wrapper kfunc that takes arguments via struct to work around BPF's 5 =
argument
> + * limit. BPF programs should use scx_bpf_dsq_insert_vtime() which is pr=
ovided
> + * as an inline wrapper in common.bpf.h.
>   *
> - * @vtime ordering is according to time_before64() which considers wrapp=
ing. A
> - * numerically larger vtime may indicate an earlier position in the orde=
ring and
> - * vice-versa.
> + * Insert @p into the vtime priority queue of the DSQ identified by
> + * @args->dsq_id. Tasks queued into the priority queue are ordered by
> + * @args->vtime. All other aspects are identical to scx_bpf_dsq_insert()=
.
> + *
> + * @args->vtime ordering is according to time_before64() which considers
> + * wrapping. A numerically larger vtime may indicate an earlier position=
 in the
> + * ordering and vice-versa.
>   *
>   * A DSQ can only be used as a FIFO or priority queue at any given time =
and this
>   * function must not be called on a DSQ which already has one or more FI=
FO tasks
>   * queued and vice-versa. Also, the built-in DSQs (SCX_DSQ_LOCAL and
>   * SCX_DSQ_GLOBAL) cannot be used as priority queues.
>   */
> -__bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq=
_id,
> -                                         u64 slice, u64 vtime, u64 enq_f=
lags)
> +__bpf_kfunc void
> +__scx_bpf_dsq_insert_vtime(struct task_struct *p,
> +                          struct scx_bpf_dsq_insert_vtime_args *args)
>  {
>         struct scx_sched *sch;
>
>         guard(rcu)();
> +
>         sch =3D rcu_dereference(scx_root);
>         if (unlikely(!sch))
>                 return;
>
> -       if (!scx_dsq_insert_preamble(sch, p, enq_flags))
> -               return;
> +       scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice, args->vti=
me,
> +                            args->enq_flags);
> +}
>
> -       if (slice)
> -               p->scx.slice =3D slice;
> -       else
> -               p->scx.slice =3D p->scx.slice ?: 1;
> +/*
> + * COMPAT: Will be removed in v6.23.
> + */
> +__bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq=
_id,
> +                                         u64 slice, u64 vtime, u64 enq_f=
lags)
> +{
> +       struct scx_sched *sch;
>
> -       p->scx.dsq_vtime =3D vtime;
> +       guard(rcu)();
>
> -       scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRI=
Q);
> +       sch =3D rcu_dereference(scx_root);
> +       if (unlikely(!sch))
> +               return;
> +
> +       scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
>  }
>
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
> +BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
>
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index d2434c954848..3d9d404d5cd2 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -995,26 +995,56 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_=
struct *p, s32 prev_cpu,
>         return prev_cpu;
>  }
>
> +struct scx_bpf_select_cpu_and_args {
> +       /* @p and @cpus_allowed can't be packed together as KF_RCU is not=
 transitive */
> +       s32                     prev_cpu;
> +       u64                     wake_flags;
> +       u64                     flags;
> +};
> +
>  /**
> - * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p,
> - *                         prioritizing those in @cpus_allowed
> + * __scx_bpf_select_cpu_and - Arg-wrapped CPU selection with cpumask
>   * @p: task_struct to select a CPU for
> - * @prev_cpu: CPU @p was on previously
> - * @wake_flags: %SCX_WAKE_* flags
>   * @cpus_allowed: cpumask of allowed CPUs
> - * @flags: %SCX_PICK_IDLE* flags
> + * @args: struct containing the rest of the arguments
> + *       @args->prev_cpu: CPU @p was on previously
> + *       @args->wake_flags: %SCX_WAKE_* flags
> + *       @args->flags: %SCX_PICK_IDLE* flags
> + *
> + * Wrapper kfunc that takes arguments via struct to work around BPF's 5 =
argument
> + * limit. BPF programs should use scx_bpf_select_cpu_and() which is prov=
ided
> + * as an inline wrapper in common.bpf.h.
>   *
>   * Can be called from ops.select_cpu(), ops.enqueue(), or from an unlock=
ed
>   * context such as a BPF test_run() call, as long as built-in CPU select=
ion
>   * is enabled: ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDL=
E
>   * is set.
>   *
> - * @p, @prev_cpu and @wake_flags match ops.select_cpu().
> + * @p, @args->prev_cpu and @args->wake_flags match ops.select_cpu().
>   *
>   * Returns the selected idle CPU, which will be automatically awakened u=
pon
>   * returning from ops.select_cpu() and can be used for direct dispatch, =
or
>   * a negative value if no idle CPU is available.
>   */
> +__bpf_kfunc s32
> +__scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cp=
us_allowed,
> +                        struct scx_bpf_select_cpu_and_args *args)
> +{
> +       struct scx_sched *sch;
> +
> +       guard(rcu)();
> +
> +       sch =3D rcu_dereference(scx_root);
> +       if (unlikely(!sch))
> +               return -ENODEV;
> +
> +       return select_cpu_from_kfunc(sch, p, args->prev_cpu, args->wake_f=
lags,
> +                                    cpus_allowed, args->flags);
> +}
> +
> +/*
> + * COMPAT: Will be removed in v6.22.
> + */
>  __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_c=
pu, u64 wake_flags,
>                                        const struct cpumask *cpus_allowed=
, u64 flags)
>  {
> @@ -1383,6 +1413,7 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_R=
CU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
> +BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_idle)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index 505231b7b7ae..b1c2a0dde76e 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -60,10 +60,10 @@ static inline void ___vmlinux_h_sanity_check___(void)
>
>  s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
>  s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake=
_flags, bool *is_idle) __ksym;
> -s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake=
_flags,
> -                          const struct cpumask *cpus_allowed, u64 flags)=
 __ksym __weak;
> +s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask=
 *cpus_allowed,
> +                            struct scx_bpf_select_cpu_and_args *args) __=
ksym __weak;
>  void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u6=
4 enq_flags) __ksym __weak;
> -void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 sli=
ce, u64 vtime, u64 enq_flags) __ksym __weak;
> +void __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_ds=
q_insert_vtime_args *args) __ksym __weak;
>  u32 scx_bpf_dispatch_nr_slots(void) __ksym;
>  void scx_bpf_dispatch_cancel(void) __ksym;
>  bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index d979f16a3ae2..e172de696f99 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -143,6 +143,78 @@ static inline struct task_struct *__COMPAT_scx_bpf_c=
pu_curr(int cpu)
>         return rq ? rq->curr : NULL;
>  }
>
> +/*
> + * v6.19: To work around BPF maximum parameter limit, the following kfun=
cs are
> + * replaced with variants that pack scalar arguments in a struct. Wrappe=
rs are
> + * provided to maintain source compatibility.
> + *
> + * The kernel will carry the compat variants until v6.23 to maintain bin=
ary
> + * compatibility. After v6.23 release, remove the compat handling and mo=
ve the
> + * wrappers to common.bpf.h.
> + */
> +s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu,=
 u64 wake_flags,
> +                                   const struct cpumask *cpus_allowed, u=
64 flags) __ksym __weak;
> +void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id=
, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
> +
> +/**
> + * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
> + * @p: task_struct to select a CPU for
> + * @prev_cpu: CPU @p was on previously
> + * @wake_flags: %SCX_WAKE_* flags
> + * @cpus_allowed: cpumask of allowed CPUs
> + * @flags: %SCX_PICK_IDLE* flags
> + *
> + * Inline wrapper that packs scalar arguments into a struct and calls
> + * __scx_bpf_select_cpu_and(). See __scx_bpf_select_cpu_and() for detail=
s.
> + */
> +static inline s32
> +scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_fla=
gs,
> +                      const struct cpumask *cpus_allowed, u64 flags)
> +{
> +       if (bpf_core_type_exists(struct scx_bpf_select_cpu_and_args)) {
> +               struct scx_bpf_select_cpu_and_args args =3D {
> +                       .prev_cpu =3D prev_cpu,
> +                       .wake_flags =3D wake_flags,
> +                       .flags =3D flags,
> +               };
> +
> +               return __scx_bpf_select_cpu_and(p, cpus_allowed, &args);
> +       } else {
> +               return scx_bpf_select_cpu_and___compat(p, prev_cpu, wake_=
flags,
> +                                                      cpus_allowed, flag=
s);
> +       }
> +}
> +
> +/**
> + * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queu=
e of a DSQ
> + * @p: task_struct to insert
> + * @dsq_id: DSQ to insert into
> + * @slice: duration @p can run for in nsecs, 0 to keep the current value
> + * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> + * @enq_flags: SCX_ENQ_*
> + *
> + * Inline wrapper that packs scalar arguments into a struct and calls
> + * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for de=
tails.
> + */
> +static inline void
> +scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u=
64 vtime,
> +                        u64 enq_flags)
> +{
> +       if (bpf_core_type_exists(struct scx_bpf_dsq_insert_vtime_args)) {
> +               struct scx_bpf_dsq_insert_vtime_args args =3D {
> +                       .dsq_id =3D dsq_id,
> +                       .slice =3D slice,
> +                       .vtime =3D vtime,
> +                       .enq_flags =3D enq_flags,
> +               };
> +
> +               __scx_bpf_dsq_insert_vtime(p, &args);
> +       } else {
> +               scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime=
,
> +                                                 enq_flags);
> +       }
> +}
> +
>  /*
>   * Define sched_ext_ops. This may be expanded to define multiple variant=
s for
>   * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
> --
> 2.51.0
>
>
