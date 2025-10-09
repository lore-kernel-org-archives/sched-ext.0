Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300B82E9759
	for <sched-ext@lists.linux.dev>; Thu,  9 Oct 2025 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018333; cv=none; b=AQiBPRVEc624PcUDSd8VTOpeyjFyHAzO234kPPuk3OpEJI7JGtJrpOhm4QtMEwAOl7zCnY/VJPKL4II8HWMgScE/RA5mCujhYSJ52TvK4+9hXxNndlftcXHJ0lGRnY8YdtCmkj8oUfeXiE9d/I4hc+3aeq5ZZbo7++VSH2IVT2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018333; c=relaxed/simple;
	bh=mFDkA3eRwtzhsFJaBh7nx8oskCERd+ZxLdLjciLTNTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs7+zNbtMgmW0oRwWL//SVQz7fclqL175+XoN0gKfqKkNUvPiAy6ggXG3gHLrXXv5uBTAYeiCUIH1BhIfKIrGSkZusn/s17QkyA9gZoYUEdWF9GpwifAscIIIWrCuMH15UUtAa9ILN5j1Gc40KDLbRpoYBVXmSqZmfNexAMM0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=RTkgJefP; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="RTkgJefP"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6353e91a04aso1001574d50.2
        for <sched-ext@lists.linux.dev>; Thu, 09 Oct 2025 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1760018330; x=1760623130; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfooPXAeOAU1EAeHNqlfk3ucybzzfKIfk6lw1CAk8xo=;
        b=RTkgJefPBSqZQTb9NPOtjP7ZJyf2G4oQ434kooPxM9tP/9SYngJW/rrxwqqA/Ql6tr
         SYw1gKB9xrU6Nv2N3cYpfrvLJuGUvZaTLWCKBDZaqyjMCVACxykYvBdRzDrRPK5f1uYm
         68RVz2OzsGOz5yhWMGRvylt/fHhZqaQ8qtOi74fm/pg6ajP+qVjsArc3VqksQmkw7fHZ
         4ovw9/sALLBzhJ/yH1v1SjNpMI4ys1Hm/UsjvkKfCzXOKECCGCvxw9znVYMWYuoPT87x
         Ca/O51g3JzFL8L68N6eIxT2vkYdEUVkNWLgkyak8u9kFeK5sASQSTH8aZdS7FY6CvvTo
         l/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018330; x=1760623130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfooPXAeOAU1EAeHNqlfk3ucybzzfKIfk6lw1CAk8xo=;
        b=dAA1T5v8LM+P8RY+MsLMcsi39Py3m8CoF0uRxRd9i9kouHw3u+4lovC06Kiz7WR5hb
         5GE2qZF9TUpArvxDZk5O2mAcoCCcQbcXoweKMbD7lS37i5WGOHrdMMYXuBy6hNYMtHDr
         3llpHsSzHGF20BpnOvATroCE4WaWy5tkNn4iOmQL2Ub1WGCGr4MQlHV/pf1GSurmgkmS
         OD0kjBdKICkK0LpBNMYoivSw1F5CsVeFbWv9///8mgikTbku4BgBQhbxOYeo/1Qrh8Mo
         oHSmmqGWwdraHHPMdZAOqkVmG92vbIhQwl1aKk44eTrMyxFvZfU2yorpOZ6X+hTlrKv2
         niKA==
X-Forwarded-Encrypted: i=1; AJvYcCWNy13JhBlijlr1QHXDATk9Jh2gXpqTcPNmn32Dr2VWL/WyLo8l8kx0ZN5tqsprBiqJx1DwbTYAvkI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxkSVgDSa0nPNEQRLizZSk71qYdOkQUUeliyASOj0ZSHRhrIIiY
	ArbMHxqWQ0DloztIiFV3s7GPSD/KyVwAjyPLpNs4bZBY62FXiDkFIepFtFMcmteoVkATxXrIgK5
	bLTpHJa+PYdrvR1zb2CF0MlwfuYeZruJKleyMqiczeA==
X-Gm-Gg: ASbGncv1WHdRbYCZsd7ZiTWO5Hqyc71A7oMB+M8WW1tE0jahEsRcl9gDNrTA5MTDs0J
	br3+LQ62qHGqaOkH28Yf1W9tnfn3Po6Y3Tpx578a3TLjqOdkkc0SA3awafvc1weRrxQf4KebhUU
	XsYIMRVavVlfcjnx6tqJd6mr/a6KL8ZJB6p49wJfosRcslf6RlFjQEVcbACqwEmuG/TiNyXstPT
	zRT6TXfGw2E7hGHv68RgBg34ayBj2V8Cg==
X-Google-Smtp-Source: AGHT+IHkPGAxGlSPC8L2qbq4CZVTIrt640mZND+W++IoHDDHTQhtPenSIEwYh1FoFvuw/JvofJ355ETeoV3+Lss5AIo=
X-Received: by 2002:a05:690c:3206:b0:762:9a58:b334 with SMTP id
 00721157ae682-780e16d54b2mr124289457b3.42.1760018329661; Thu, 09 Oct 2025
 06:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007133523.GA93086@pauld.westford.csb> <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
 <aOYAV2ZQvMt5aZxu@gpd4> <aObPQF1-o-Uek7bd@slm.duckdns.org>
 <aObcIMFpUoMy7vJI@slm.duckdns.org> <aObkkKf_UCHySRGz@gpd4>
 <aOb1e7R1lAGVGH-2@slm.duckdns.org> <aOb3Hv0uPv9G7N33@slm.duckdns.org>
In-Reply-To: <aOb3Hv0uPv9G7N33@slm.duckdns.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Thu, 9 Oct 2025 09:58:37 -0400
X-Gm-Features: AS18NWB4fsi58i1BxtcyFkuka9DzyuC5iyFPdl7zmzx5eoymRK5EiuczOMtxtCs
Message-ID: <CABFh=a54KWB16BpaddpegzZjSY4bN8gfNvBA4DCj-fO2s4YR3w@mail.gmail.com>
Subject: Re: [PATCH v3] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily
 using kvzalloc()
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Phil Auld <pauld@redhat.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:43=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On systems with >4096 CPUs, scx_kick_cpus_pnt_seqs allocation fails durin=
g
> boot because it exceeds the 32,768 byte percpu allocator limit.
>
> Restructure to use DEFINE_PER_CPU() for the per-CPU pointers, with each C=
PU
> pointing to its own kvzalloc'd array. Move allocation from boot time to
> scx_enable() and free in scx_disable(), so the O(nr_cpu_ids^2) memory is =
only
> consumed when sched_ext is active.
>
> Use RCU to guard against racing with free. Arrays are freed via call_rcu(=
)
> and kick_cpus_irq_workfn() uses rcu_dereference_bh() with a NULL check.
>
> While at it, rename to scx_kick_pseqs for brevity and update comments to
> clarify these are pick_task sequence numbers.
>
> v2: RCU protect scx_kick_seqs to manage kick_cpus_irq_workfn() racing
>     against disable as per Andrea.
>
> v3: Fix bugs notcied by Andrea.
>
> Reported-by: Phil Auld <pauld@redhat.com>
> Link: http://lkml.kernel.org/r/20251007133523.GA93086@pauld.westford.csb
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Andrea Righi <arighi@nvidia.com>
> ---


Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c | 89 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 79 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..01010c3378b0 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -67,8 +67,19 @@ static unsigned long scx_watchdog_timestamp =3D INITIA=
L_JIFFIES;
>
>  static struct delayed_work scx_watchdog_work;
>
> -/* for %SCX_KICK_WAIT */
> -static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
> +/*
> + * For %SCX_KICK_WAIT: Each CPU has a pointer to an array of pick_task s=
equence
> + * numbers. The arrays are allocated with kvzalloc() as size can exceed =
percpu
> + * allocator limits on large machines. O(nr_cpu_ids^2) allocation, alloc=
ated
> + * lazily when enabling and freed when disabling to avoid waste when sch=
ed_ext
> + * isn't active.
> + */
> +struct scx_kick_pseqs {
> +       struct rcu_head         rcu;
> +       unsigned long           seqs[];
> +};
> +
> +static DEFINE_PER_CPU(struct scx_kick_pseqs __rcu *, scx_kick_pseqs);
>
>  /*
>   * Direct dispatch marker.
> @@ -3850,6 +3861,27 @@ static const char *scx_exit_reason(enum scx_exit_k=
ind kind)
>         }
>  }
>
> +static void free_kick_pseqs_rcu(struct rcu_head *rcu)
> +{
> +       struct scx_kick_pseqs *pseqs =3D container_of(rcu, struct scx_kic=
k_pseqs, rcu);
> +
> +       kvfree(pseqs);
> +}
> +
> +static void free_kick_pseqs(void)
> +{
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               struct scx_kick_pseqs **pseqs =3D per_cpu_ptr(&scx_kick_p=
seqs, cpu);
> +               struct scx_kick_pseqs *to_free;
> +
> +               to_free =3D rcu_replace_pointer(*pseqs, NULL, true);
> +               if (to_free)
> +                       call_rcu(&to_free->rcu, free_kick_pseqs_rcu);
> +       }
> +}
> +
>  static void scx_disable_workfn(struct kthread_work *work)
>  {
>         struct scx_sched *sch =3D container_of(work, struct scx_sched, di=
sable_work);
> @@ -3986,6 +4018,7 @@ static void scx_disable_workfn(struct kthread_work =
*work)
>         free_percpu(scx_dsp_ctx);
>         scx_dsp_ctx =3D NULL;
>         scx_dsp_max_batch =3D 0;
> +       free_kick_pseqs();
>
>         mutex_unlock(&scx_enable_mutex);
>
> @@ -4348,6 +4381,33 @@ static void scx_vexit(struct scx_sched *sch,
>         irq_work_queue(&sch->error_irq_work);
>  }
>
> +static int alloc_kick_pseqs(void)
> +{
> +       int cpu;
> +
> +       /*
> +        * Allocate per-CPU arrays sized by nr_cpu_ids. Use kvzalloc as s=
ize
> +        * can exceed percpu allocator limits on large machines.
> +        */
> +       for_each_possible_cpu(cpu) {
> +               struct scx_kick_pseqs **pseqs =3D per_cpu_ptr(&scx_kick_p=
seqs, cpu);
> +               struct scx_kick_pseqs *new_pseqs;
> +
> +               WARN_ON_ONCE(rcu_access_pointer(*pseqs));
> +
> +               new_pseqs =3D kvzalloc_node(struct_size(new_pseqs, seqs, =
nr_cpu_ids),
> +                                         GFP_KERNEL, cpu_to_node(cpu));
> +               if (!new_pseqs) {
> +                       free_kick_pseqs();
> +                       return -ENOMEM;
> +               }
> +
> +               rcu_assign_pointer(*pseqs, new_pseqs);
> +       }
> +
> +       return 0;
> +}
> +
>  static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *o=
ps)
>  {
>         struct scx_sched *sch;
> @@ -4490,15 +4550,19 @@ static int scx_enable(struct sched_ext_ops *ops, =
struct bpf_link *link)
>
>         mutex_lock(&scx_enable_mutex);
>
> +       ret =3D alloc_kick_pseqs();
> +       if (ret)
> +               goto err_unlock;
> +
>         if (scx_enable_state() !=3D SCX_DISABLED) {
>                 ret =3D -EBUSY;
> -               goto err_unlock;
> +               goto err_free_pseqs;
>         }
>
>         sch =3D scx_alloc_and_add_sched(ops);
>         if (IS_ERR(sch)) {
>                 ret =3D PTR_ERR(sch);
> -               goto err_unlock;
> +               goto err_free_pseqs;
>         }
>
>         /*
> @@ -4701,6 +4765,8 @@ static int scx_enable(struct sched_ext_ops *ops, st=
ruct bpf_link *link)
>
>         return 0;
>
> +err_free_pseqs:
> +       free_kick_pseqs();
>  err_unlock:
>         mutex_unlock(&scx_enable_mutex);
>         return ret;
> @@ -5082,10 +5148,18 @@ static void kick_cpus_irq_workfn(struct irq_work =
*irq_work)
>  {
>         struct rq *this_rq =3D this_rq();
>         struct scx_rq *this_scx =3D &this_rq->scx;
> -       unsigned long *pseqs =3D this_cpu_ptr(scx_kick_cpus_pnt_seqs);
> +       struct scx_kick_pseqs __rcu *pseqs_pcpu =3D __this_cpu_read(scx_k=
ick_pseqs);
>         bool should_wait =3D false;
> +       unsigned long *pseqs;
>         s32 cpu;
>
> +       if (unlikely(!pseqs_pcpu)) {
> +               pr_warn_once("kick_cpus_irq_workfn() called with NULL scx=
_kick_pseqs");
> +               return;
> +       }
> +
> +       pseqs =3D rcu_dereference_bh(pseqs_pcpu)->seqs;
> +
>         for_each_cpu(cpu, this_scx->cpus_to_kick) {
>                 should_wait |=3D kick_one_cpu(cpu, this_rq, pseqs);
>                 cpumask_clear_cpu(cpu, this_scx->cpus_to_kick);
> @@ -5208,11 +5282,6 @@ void __init init_sched_ext_class(void)
>
>         scx_idle_init_masks();
>
> -       scx_kick_cpus_pnt_seqs =3D
> -               __alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu=
_ids,
> -                              __alignof__(scx_kick_cpus_pnt_seqs[0]));
> -       BUG_ON(!scx_kick_cpus_pnt_seqs);
> -
>         for_each_possible_cpu(cpu) {
>                 struct rq *rq =3D cpu_rq(cpu);
>                 int  n =3D cpu_to_node(cpu);
> --
> 2.51.0
>
>
