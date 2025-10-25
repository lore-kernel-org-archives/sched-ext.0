Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0665A2797B5
	for <sched-ext@lists.linux.dev>; Sat, 25 Oct 2025 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761434521; cv=none; b=SeXXHLkTw6nPtlLUV/oskMpc0YYDQvjIVW0Zm0GuhEdUCRcWNXzMplUkQe+2PbsjBpQi2JRh74qesUgDzJXZdWxEiNRCP83f+Q94qJJ+RsstbGqdxFzTk0CRDAY56XU1C15KzrYyaJVZ3SyjJltX4TCOHJGHJSMkxLoJQUtF0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761434521; c=relaxed/simple;
	bh=9fjXyu9uOlx9Boil8JIPaRzS9MzDT1EcBqLi9OTnrcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDOD0rZRY2vCFUWRiwbkaRnYEpPLX2UMi4LLXKWnn9VeiKszyLyESie2hhBX5pLUQwlnTnI8ruRCp0Ici9sXSAejF5+h4UU2tyO2OUy3n9xys5cSfAGqoDJTSKIgGRKnlmDwy5nDp5yvosy4LTNWu7oGfRAHM98H6YmOVWInubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=AQWa6glq; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="AQWa6glq"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63e393c4a8aso4016352d50.2
        for <sched-ext@lists.linux.dev>; Sat, 25 Oct 2025 16:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1761434518; x=1762039318; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT1AYIMXw3zvx720aG+zN8z/yfufifvlumEKQUokldE=;
        b=AQWa6glqjDIp+F7Atf05Q8ekSyfANaARDATgcTCaPOBn/bR7KAMKTF12ALdmfZC8RZ
         aGyovZ8OLt1UYsO5tvMGlPKlR3xK2aWMpsrNACbgQnRMXAwcgOLz1OjuJqlMuoZeBMBn
         v49/67+Hr0c/BIGpXTOWutKyE4KyxCH1PWDeVHnOFQQZH2gdjlHP3gg6vzDXpGLcuTEb
         bPaap64dSlxIhPZbUKVwVkZKiUjHSkxwqCoHHm72TdvnqxX+pQQkriScEeFgC5QkOIc7
         XqL2dKKsBiSpLfZYyzZqLsd8bMZYJz4FGVhT9lHSMkwMrRm9IVBmER6oiYbCMuk6pwFZ
         nJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761434518; x=1762039318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT1AYIMXw3zvx720aG+zN8z/yfufifvlumEKQUokldE=;
        b=ROFRD6/83k2Pm7/kTmXSHHVqquuZL55h3dKAT0nzNG+bYPP37xkNNC0Rr0TLGdevAS
         xlRBvTKCT55PEvH4CpPdaD7xWsCZDlfZV+3m7UgL6WIsbpwQJmZ76d0lulTwqNeyD6wf
         1Vli5o5qcKORtH2SxM20VweLwDmnLOauXhwYyfxtvtli4E5yr7WwIcLnr5wSG2TLeIdT
         xhtQJSbInrwPuc3T8RY/hvMoTUhqUUkyprF26hCaByXQ1sM4D3lL3AmdGujThzwSBaOG
         pyxsHg+sNJRHVTfaIgqR+fQMFDQJwoQvoqcZLLIkVX5/vJqD48WsbtOSdlfhwtMLlWcw
         Xhvg==
X-Forwarded-Encrypted: i=1; AJvYcCWwoLoVQYfrYsT3b+O4Bt+3FYBboFKKM90r+/N6UK4BRF1YKtW38Qllb0y5OgbneSjd1HYmwf0Qla8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxE3JBrlRQurVMUuQYKZeaK7u/uNdvuQulAo6r4Ca1Tl6tx6YLI
	94BinTlsQPO0pLIf7QWm6qxhgZkmPTkbRh7lBZfHhgXT1ekRZVutOdnuvRVwQdwbsrKYS819KSP
	JWo0cRiiOdqup4IlBR48tPiwKExb1L/S8rYgBQGxdfQ==
X-Gm-Gg: ASbGncv4RjInI+tshLhbwgoe9ruIhmuo6umYgjACS6mEq1o0myF5eNyb5I7BaFPZUWy
	eASnPZCNmU0/o4CNYPTGuVVxOXnxmbmY0RpdTFXoTGaT/2REVTBcxXxdY8zomuJut+CjkOY7vM3
	cXyLmpYqHtHcNBT87/D/NFI9HT+0+kTmwArbwZafQX4ZWgr4eXd1GSvf5Cj35MlD1tMpYyaFfOw
	A+ramQ7UV7I1pTIiJRL4XWgF34xexgPqfk8ATamxyPWuIuNoLakJb5Xhbvza13RL1NOl6V/abw8
	9ZnlvnTj
X-Google-Smtp-Source: AGHT+IFhxKlUF6Fiz73JRYYxd+P6t/tDTPK+t/aprswamomVEkvgq99WI5vKHuKlz2pksoYuOQQBQlHtRAzo2Wn+KGA=
X-Received: by 2002:a53:d251:0:b0:63c:f5a7:401 with SMTP id
 956f58d0204a3-63e16215840mr19598689d50.69.1761434517904; Sat, 25 Oct 2025
 16:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251025001849.1915635-1-tj@kernel.org> <20251025001849.1915635-4-tj@kernel.org>
In-Reply-To: <20251025001849.1915635-4-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Sat, 25 Oct 2025 19:21:47 -0400
X-Gm-Features: AWmQ_bm0dZg6N8y7k5-rvrwBCXnlYT-eZGKzVti1vfVt0BGoS5wHoDqt5TvI8jg
Message-ID: <CABFh=a4-5+SfNGTcjBP1_5bsN5HqdzoWE4F9P1K1yrNQt=k2yw@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Wen-Fang Liu <liuwenfang@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> The ops.cpu_acquire/release() callbacks are broken - they miss events und=
er
> multiple conditions and can't be fixed without adding global sched core h=
ooks
> that sched maintainers don't want. They also aren't necessary as BPF sche=
dulers
> can use generic BPF mechanisms like tracepoints to achieve the same goals=
.
>
> The main use case for cpu_release() was calling scx_bpf_reenqueue_local()=
 when
> a CPU gets preempted by a higher priority scheduling class. However, the =
old
> scx_bpf_reenqueue_local() could only be called from cpu_release() context=
.
>
> Add a new version of scx_bpf_reenqueue_local() that can be called from an=
y
> context by deferring the actual re-enqueue operation. This eliminates the=
 need
> for cpu_acquire/release() ops entirely. Schedulers can now use standard B=
PF
> mechanisms like the sched_switch tracepoint to detect and handle CPU pree=
mption.
>
> Update scx_qmap to demonstrate the new approach using sched_switch instea=
d of
> cpu_release, with compat support for older kernels. Mark cpu_acquire/rele=
ase()
> as deprecated. The old scx_bpf_reenqueue_local() variant will be removed =
in
> v6.23.
>
> Reported-by: Wen-Fang Liu <liuwenfang@honor.com>
> Link: https://lore.kernel.org/all/8d64c74118c6440f81bcf5a4ac6b9f00@honor.=
com/
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c                       | 31 ++++++++++++++++++++
>  kernel/sched/sched.h                     |  1 +
>  tools/sched_ext/include/scx/common.bpf.h |  1 -
>  tools/sched_ext/include/scx/compat.bpf.h | 23 +++++++++++++++
>  tools/sched_ext/scx_qmap.bpf.c           | 38 +++++++++++++++++-------
>  5 files changed, 83 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 222222222222..333333333333 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -147,6 +147,7 @@ static struct kset *scx_kset;
>  #include <trace/events/sched_ext.h>
>
>  static void process_ddsp_deferred_locals(struct rq *rq);
> +static u32 reenq_local(struct rq *rq);
>  static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
>  static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
>                       s64 exit_code, const char *fmt, va_list args);
> @@ -755,6 +756,11 @@ static int ops_sanitize_err(struct scx_sched *sch, s=
32 ret, s32 ops_err)
>  static void run_deferred(struct rq *rq)
>  {
>         process_ddsp_deferred_locals(rq);
> +
> +       if (local_read(&rq->scx.reenq_local_deferred)) {
> +               local_set(&rq->scx.reenq_local_deferred, 0);
> +               reenq_local(rq);
> +       }
>  }
>
>  static void deferred_bal_cb_workfn(struct rq *rq)
> @@ -4569,6 +4575,9 @@ static int validate_ops(struct scx_sched *sch)
>         if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
>                 pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a no=
op\n");
>
> +       if (ops->cpu_acquire || ops->cpu_release)
> +               pr_warn("ops->cpu_acquire/release() are deprecated, use s=
ched_switch TP instead\n");
> +
>         return 0;
>  }
>
> @@ -5931,6 +5940,9 @@ __bpf_kfunc_start_defs();
>   * Iterate over all of the tasks currently enqueued on the local DSQ of =
the
>   * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the n=
umber of
>   * processed tasks. Can only be called from ops.cpu_release().
> + *
> + * COMPAT: Will be removed in v6.23 along with the ___v2 suffix on the v=
oid
> + * returning variant that can be called from anywhere.
>   */
>  __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
>  {
> @@ -6490,6 +6502,24 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *data__str=
, u32 data__sz)
>  }
>
>  /**
> + * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
> + *
> + * Iterate over all of the tasks currently enqueued on the local DSQ of =
the
> + * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called=
 from
> + * anywhere.
> + */
> +__bpf_kfunc void scx_bpf_reenqueue_local___v2(void)
> +{
> +       struct rq *rq;
> +
> +       guard(preempt)();
> +
> +       rq =3D this_rq();
> +       local_set(&rq->scx.reenq_local_deferred, 1);
> +       schedule_deferred(rq);
> +}
> +
> +/**
>   * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
>   * @cpu: CPU of interest
>   *
> @@ -6902,6 +6932,7 @@ BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITE=
R_DESTRUCTOR)
>  BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 444444444444..555555555555 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -804,6 +804,7 @@ struct scx_rq {
>         cpumask_var_t           cpus_to_preempt;
>         cpumask_var_t           cpus_to_wait;
>         unsigned long           kick_sync;
> +       local_t                 reenq_local_deferred;
>         struct balance_callback deferred_bal_cb;
>         struct irq_work         deferred_irq_work;
>         struct irq_work         kick_cpus_irq_work;
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index 666666666666..777777777777 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -70,7 +70,6 @@ void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq=
 *it__iter, u64 slice) _
>  void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 v=
time) __ksym __weak;
>  bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_str=
uct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
>  bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct ta=
sk_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
> -u32 scx_bpf_reenqueue_local(void) __ksym;
>  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
>  s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
>  void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index 888888888888..999999999999 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -279,6 +279,29 @@ static inline void scx_bpf_task_set_dsq_weight(struc=
t task_struct *p, u32 weigh
>  }
>
>  /*
> + * v6.19: The new void variant can be called from anywhere while the old=
er v1
> + * variant can only be called from ops.cpu_release(). The double ___ pre=
fixes on
> + * the v2 variant need to be removed once libbpf is updated to ignore __=
_ prefix
> + * on kernel side. Drop the wrapper and move the decl to common.bpf.h af=
ter
> + * v6.22.
> + */
> +u32 scx_bpf_reenqueue_local___v1(void) __ksym __weak;
> +void scx_bpf_reenqueue_local___v2___compat(void) __ksym __weak;
> +
> +static inline bool __COMPAT_scx_bpf_reenqueue_local_from_anywhere(void)
> +{
> +       return bpf_ksym_exists(scx_bpf_reenqueue_local___v2___compat);
> +}
> +
> +static inline void scx_bpf_reenqueue_local(void)
> +{
> +       if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
> +               scx_bpf_reenqueue_local___v2___compat();
> +       else
> +               scx_bpf_reenqueue_local___v1();
> +}
> +
> +/*
>   * Define sched_ext_ops. This may be expanded to define multiple variant=
s for
>   * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
>   */
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index aaaaaaaaaaaa..bbbbbbbbbbbb 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -202,6 +202,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct =
*p, u64 enq_flags)
>         void *ring;
>         s32 cpu;
>
> +       if (enq_flags & SCX_ENQ_REENQ)
> +               __sync_fetch_and_add(&nr_reenqueued, 1);
> +
>         if (p->flags & PF_KTHREAD) {
>                 if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth=
))
>                         return;
> @@ -529,20 +532,35 @@ bool BPF_STRUCT_OPS(qmap_core_sched_before, struct =
task_struct *a,
>         return task_qdist(a) > task_qdist(b);
>  }
>
> -void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_ar=
gs *args)
> +SEC("tp_btf/sched_switch")
> +int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
> +            struct task_struct *next, unsigned long prev_state)
>  {
> -       u32 cnt;
> +       if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
> +               return 0;
>
>         /*
> -        * Called when @cpu is taken by a higher priority scheduling clas=
s. This
> -        * makes @cpu no longer available for executing sched_ext tasks. =
As we
> -        * don't want the tasks in @cpu's local dsq to sit there until @c=
pu
> -        * becomes available again, re-enqueue them into the global dsq. =
See
> -        * %SCX_ENQ_REENQ handling in qmap_enqueue().
> +        * If @cpu is taken by a higher priority scheduling class, it is =
no
> +        * longer available for executing sched_ext tasks. As we don't wa=
nt the
> +        * tasks in @cpu's local dsq to sit there until @cpu becomes avai=
lable
> +        * again, re-enqueue them into the global dsq. See %SCX_ENQ_REENQ
> +        * handling in qmap_enqueue().
>          */
> -       cnt =3D scx_bpf_reenqueue_local();
> -       if (cnt)
> -               __sync_fetch_and_add(&nr_reenqueued, cnt);
> +       switch (next->policy) {
> +       case 1: /* SCHED_FIFO */
> +       case 2: /* SCHED_RR */
> +       case 6: /* SCHED_DEADLINE */
> +               scx_bpf_reenqueue_local();
> +       }
> +
> +       return 0;
> +}
> +
> +void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_ar=
gs *args)
> +{
> +       /* see qmap_sched_switch() to learn how to do this on newer kerne=
ls */
> +       if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
> +               scx_bpf_reenqueue_local();
>  }
>
>  s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
> --
> 2.47.1
>
