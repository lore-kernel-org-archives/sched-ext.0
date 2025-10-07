Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACCB2AF1B
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 02:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759805818; cv=none; b=TSbcEdI9THuhS5gg1sM4JaHYS8Enz2PrRfsvqZowFTMC56d/VjziVS4i3fkrgASOATOagYcX58VJlezWsHSi3BpX/5INLoO3mXzgj5V02rV7WOtK56a8Bk6nznzWpXR4B8UzrGpPHtrD6+Sl74vau9+lZDSiv/nCZ0nOb/oOZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759805818; c=relaxed/simple;
	bh=uspfdtTaDhkJUQm/yAezGJrTMY+RD/jIJYxf/L1GW8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iX2k6lX+aOwtjxX9fNwcYLpYniHy8YqL91tTatSWMNih8IKG1DALesiFjEMn1gCoCkDTUBm8+xDHsrQHv3FG3HX7wZCvzFwYNPCg7yp42idoMsCO8Z+mTWcZkIu3qVe2gmBb6n5MEQtPsAo4vlDOXS4+MUgeMWCHYqvDo1PJ3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=BwycHZLC; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="BwycHZLC"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63605f6f926so4818943d50.0
        for <sched-ext@lists.linux.dev>; Mon, 06 Oct 2025 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1759805816; x=1760410616; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0etW7tDD+ezyFVfURVfPVOchiUp9/ZB1Sfa7QB/jdw=;
        b=BwycHZLCnc3k/wgBPZqF9DOCcMA9vLndWFqHjlsw2cM7er4SlAk0FMmcQT5QLmJ+iw
         qcLAdOeTuCwTKPQW7v2B7N2fd2x92+LawwsWopGFMMS25+CGid2OO5kW8yeDM7wnY34w
         M11Cse/xnYQHML54lMqVI3Qad5wOKnmxQ0MsIFyPmGhlS5tjY5AgGVTejnq0AzBmqwVD
         6taTxclo6l4/67Xb2P63zxj8+qk0DluXh61pJ7NB3wlAyBvPbtrJIDT64LfFnU3I7zm/
         ujyeUaxMKjXse/4fzIs4NjYaJz1LB19C55CHtdOUbVy0UpaQnWKnpIe4uAKSFM7vvgwW
         Vqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759805816; x=1760410616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0etW7tDD+ezyFVfURVfPVOchiUp9/ZB1Sfa7QB/jdw=;
        b=oEl8ZanVNAlGgtiWQaTGM0uq8yYmFF/5Ufj1hrlzmIz/ikxrllsUS0HSWeGzHqlRaC
         2IsW1BsAMmMLTcbrVdGhsnWmbIULqLHNtor0qSXqzUoxVOluQYWcwb0VdUDhX/l2MVik
         cuszKu7inukMuit4w4XooGGJxtGMxZ0nHGD0BELy7fDcUh7ps+JRwdeSxJp4UgDQUN0v
         UN6OGrpjx/ZjPQ+KeJkqz/RsyN/049B0s9KT6y0xMn/EFzVoFEVWbhnJuMgsLLkhDE4U
         XGlDd7taVcmcb8Ihf/k4MdFuuvb90bqPOsSKCgCw5UhekIlspCHeGNQBvBX5C5iSPfnL
         TpUg==
X-Forwarded-Encrypted: i=1; AJvYcCVSLLcd7N2hhvqwlBU15SN1S9ApzMIl4ay3B69TIWLwDOEsCNNY8UYznYBKawDgBdmMgeMiM3x4yxw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwHXbdwPy2aiYxROd/0vgZpql/IElX+9ataR+DH4Vb4TNlpCL5/
	SRAZDVFpMt1NQYxT0yUYkOYgPwRTaGRL+0relYJVEwOejtcgph44r5RbG1ujxyGGx1ejT3pWPbY
	99PrZDZcNYCC1edamzpp693rHMS4y1NNHAukgf9x/bg==
X-Gm-Gg: ASbGnct7RDigOHKPZIrNfW7jrnS9yOQMl1txUTGPbnQab4v3nQssdkk2k3SbL8RijdO
	8uUzU3KGdsz0ERrttxiW7PidUcnhCqMgprHMtAxRIuKe/spoYJ1yuE6F7rKGzBEVYouY4+wBSUP
	eS1MHT21PAANGWikDUJBBJFlwwOZ41Ut8L+eFdx2ax3VtMz/NNJXW+zEqHc+S4KWLnIq+KgcBzJ
	d4K0ZF754TxeAOMdjCWLjLoeV9Ur2VA3pVoBf9j2TxL
X-Google-Smtp-Source: AGHT+IFdqbag5HgfjQTHNl5po7tX36fDlgEw7+kZWksobAK4eI93HyVNZW7Vx6eJ9W0L0BjaX53PhNOO08hHTMWDU2w=
X-Received: by 2002:a53:cc0a:0:b0:636:1844:104 with SMTP id
 956f58d0204a3-63b9a0741a7mr11080265d50.12.1759805815625; Mon, 06 Oct 2025
 19:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007015147.2496026-1-tj@kernel.org> <20251007015147.2496026-3-tj@kernel.org>
In-Reply-To: <20251007015147.2496026-3-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 6 Oct 2025 22:56:45 -0400
X-Gm-Features: AS18NWATK6ERxIwq7Iob48PlkQqB7xmTrgtnIuWuPAHb8jhRv5fLhmnK9wvfCfQ
Message-ID: <CABFh=a7LA2MZHH-PeiDw_2VRdfqXbrimTsY=yeR7gsmg94doAA@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched_ext: Add scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime()
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 9:51=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> With the planned hierarchical scheduler support, sub-schedulers will need=
 to
> be verified for authority before being allowed to modify task->scx.slice =
and
> task->scx.dsq_vtime. Add scx_bpf_task_set_slice() and
> scx_bpf_task_set_dsq_vtime() which will perform the necessary permission
> checks.
>
> Root schedulers can still directly write to these fields, so this doesn't
> affect existing schedulers.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c                       | 30 ++++++++++++++++++++++++
>  tools/sched_ext/include/scx/common.bpf.h |  2 ++
>  2 files changed, 32 insertions(+)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index fc353b8d69f7..6d76efaaa9b2 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5833,6 +5833,34 @@ static const struct btf_kfunc_id_set scx_kfunc_set=
_unlocked =3D {
>
>  __bpf_kfunc_start_defs();
>
> +/**
> + * scx_bpf_task_set_slice - Set task's time slice
> + * @p: task of interest
> + * @slice: time slice to set in nsecs
> + *
> + * Set @p's time slice to @slice. Returns %true on success, %false if th=
e
> + * calling scheduler doesn't have authority over @p.
> + */
> +__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice=
)
> +{
> +       p->scx.slice =3D slice;
> +       return true;
> +}
> +

Q: Do we care about protecting slice/dsq_vtime these fields with a
lock (e.g., to let them be atomically changed w/ other
proc/DSQ state? If so, should we limit them with the kf_mask to be
callable from specific BPF ops?

> +/**
> + * scx_bpf_task_set_dsq_vtime - Set task's virtual time for DSQ ordering
> + * @p: task of interest
> + * @vtime: virtual time to set
> + *
> + * Set @p's virtual time to @vtime. Returns %true on success, %false if =
the
> + * calling scheduler doesn't have authority over @p.
> + */
> +__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 v=
time)
> +{
> +       p->scx.dsq_vtime =3D vtime;
> +       return true;
> +}
> +
>  static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
>  {
>         struct rq *this_rq;
> @@ -6638,6 +6666,8 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_st=
ats *events,
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(scx_kfunc_ids_any)
> +BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_RCU);
> +BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/i=
nclude/scx/common.bpf.h
> index 06e2551033cb..505231b7b7ae 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -102,6 +102,8 @@ s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_a=
llowed, int node, u64 flags
>  s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksy=
m;
>  bool scx_bpf_task_running(const struct task_struct *p) __ksym;
>  s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
> +bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice) __ksym __w=
eak;
> +bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime) __ksym=
 __weak;
>  struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
>  struct rq *scx_bpf_locked_rq(void) __ksym;
>  struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
> --
> 2.51.0
>
>
