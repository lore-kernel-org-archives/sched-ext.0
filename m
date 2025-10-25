Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804A2DEA68
	for <sched-ext@lists.linux.dev>; Sat, 25 Oct 2025 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761434358; cv=none; b=t316qytG+hBu4fue2GQq0y/ZkNUPcHYWb2DVCgDhm5/5ITjafnu/sU9FSa7/ZyDshNcGzQUKGBN1LC6JMpWX0D4AEwzp0vMVptTAbA5WiqRgsxd9Vz8mfmVjph75btuASNyoqrgdLqw2fFGmZuEcYlIL0bTXTx+P8CxCTKe7HJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761434358; c=relaxed/simple;
	bh=URJlCVicZhm+oeTzrJXAhhMSWhyRebViHBBjjqxzfZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZzvySCNuEHYsMR75DzvdhK75ZVmLcLXxIns4/tV+J+6P/O5muxtMxlWMbRsHIKe3q7ik6Lin7iKSz0gNNJyCGpnCjUAyxs3B8VWHSTyAa+I0Pfa0c1OI59QmXq0i3yxhHBb/yTsdqpr+uE0h/nz6H9njjCtAJTmMOasPAJN21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=BI9Y2iH2; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="BI9Y2iH2"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e0c6f0adfso3372409d50.3
        for <sched-ext@lists.linux.dev>; Sat, 25 Oct 2025 16:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1761434355; x=1762039155; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z65Za7rXC8MqpESbbemIcqGNq0y/exeyJvrr1tkhhcQ=;
        b=BI9Y2iH2kpcBYD4F+ewbylkntGtSSDslLNchf6RpgYoz3hwL1N90ZuZk9LwH3NRtHk
         VyX0F+BIbEminW9AXvgPvonvw42dMKvX3713R3D8qVLwmW6i6Aw9EyUbXOaLFpc5kSFt
         2KnPXG3/4nTTz0KW5KYN01034qSzPKgAHxnMVMEt1GHXw/FO5hVPFpriLnBBOY4Q7XxM
         fvPGE5hyRn8gKujUsipoXKbwEngp9KS8vKaPnB2SbA8ikeGZmqEXuGBAcSljFaGdXPcA
         Pc7HwYu02brKQi0DcsjI7exQ0jqIgj6FPxoqXH7LTND3xKkffDEY3sHMU30/CZ4ivqo0
         YzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761434355; x=1762039155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z65Za7rXC8MqpESbbemIcqGNq0y/exeyJvrr1tkhhcQ=;
        b=VfRrtT+ajDeLBVGXQhIAQKMxhvqg6i9/UJiW8zcWttp/vfYbeacx3Lqhiv35lYKFLQ
         rjT5xHOkdpyAIZSx1EfsMdKkcfUmnEGKAbIP55oF5QrQykBJ/BLf9w8uQVle4xlyh4/I
         GZol9o3C+wbuMAiK8sd3Jru0gIbFrWAFq8VmCTaMwFHqt1Bbi2f0bW16lvLJPvi4sZp+
         XLgfgseEJ7tN6vupP8/f05v6UCWu564wPvbkmilf0OkoUg2KkT52kWY5jZTL9z3EHLiT
         ol49gdrht984DUtXo6nmL3g53zbNF9y/umElwRO05eNnXukOi47YYWWtPvsbOYLnfDkA
         6/SA==
X-Forwarded-Encrypted: i=1; AJvYcCXqH+51SMZk/67pwru9WnkD5gdq6KDmExTabrcjkp2RJA7lVf5DU88cP/SsQDaxn8HJ8i8Z4NOri08=@lists.linux.dev
X-Gm-Message-State: AOJu0YzuJQAGGAliOILFpYQWzabofL7adbUT9CkF0FWyEpPq9RRUvTgS
	iSIdphySNy36UFeXW+zI5V1EnC7RgrH/2kzHdCPqLWKZ/NyMrn5Y4IlDdUH1attqznRcZzOBh2C
	c9+pvAJQkuVji9Qmcz66DyD/C7qiulnHbDdUobPkcZg==
X-Gm-Gg: ASbGncuSYCB+V14Di/vE/YOLNtRI6q4ocVXNCKzCw52ow1LLuQs4Uaqm6H0mg5Oe5ED
	N6eKgDQH4ls8XS5dI8LcyLvu/D6O8WsXSSM2tvKJCC2LIByhJcBBqWj2Pn+j76guN61AhlMy9Mj
	nnSyBXCsomqnQx5/XxAcQPdsDRKH1UsPCmBOB4+SmFG15BGbVoi3UTnyX/IBXSW+7YOChqUSZFB
	bvG4cOiSXRtfHJGxbGMfG7XNrDvfWpUwnv/omf8gjUAPLaVVDwBDuPkBrge1PDJVfiUk1bxpg==
X-Google-Smtp-Source: AGHT+IHXZu5cLWt/PiTOREaGquHeok6rGtaRuaSbXTkjGC2A+8z0JnQnXbkKFDEK+CktDKRCiWYdomoYKxeCE4eJg7E=
X-Received: by 2002:a05:690e:124c:b0:63f:580c:8b60 with SMTP id
 956f58d0204a3-63f580c8ccdmr575228d50.67.1761434355559; Sat, 25 Oct 2025
 16:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251025001849.1915635-1-tj@kernel.org> <20251025001849.1915635-3-tj@kernel.org>
In-Reply-To: <20251025001849.1915635-3-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Sat, 25 Oct 2025 19:19:05 -0400
X-Gm-Features: AWmQ_bkurP8V5hEnVqiEa2FzBR81gtLdBm2d_U5QRVaRHsjoZXcdo92K3TTXe_A
Message-ID: <CABFh=a4faAi0_GNQQrFQKfLFtKrOFDBEBoCFUC4dvHf2taCkFA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched_ext: Factor out reenq_local() from scx_bpf_reenqueue_local()
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Wen-Fang Liu <liuwenfang@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Factor out the core re-enqueue logic from scx_bpf_reenqueue_local() into =
a
> new reenq_local() helper function. scx_bpf_reenqueue_local() now handles =
the
> BPF kfunc checks and calls reenq_local() to perform the actual work.
>
> This is a prep patch to allow reenq_local() to be called from other conte=
xts.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/sched/ext.c | 50 +++++++++++++++++++++++++++++-------------------=
--
>  1 file changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 111111111111..222222222222 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5881,32 +5881,12 @@ static const struct btf_kfunc_id_set scx_kfunc_se=
t_dispatch =3D {
>         .set                    =3D &scx_kfunc_ids_dispatch,
>  };
>
> -__bpf_kfunc_start_defs();
> -
> -/**
> - * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
> - *
> - * Iterate over all of the tasks currently enqueued on the local DSQ of =
the
> - * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the n=
umber of
> - * processed tasks. Can only be called from ops.cpu_release().
> - */
> -__bpf_kfunc u32 scx_bpf_reenqueue_local(void)
> +static u32 reenq_local(struct rq *rq)
>  {
> -       struct scx_sched *sch;
>         LIST_HEAD(tasks);
>         u32 nr_enqueued =3D 0;
> -       struct rq *rq;
>         struct task_struct *p, *n;
>
> -       guard(rcu)();
> -       sch =3D rcu_dereference(scx_root);
> -       if (unlikely(!sch))
> -               return 0;
> -
> -       if (!scx_kf_allowed(sch, SCX_KF_CPU_RELEASE))
> -               return 0;
> -
> -       rq =3D cpu_rq(smp_processor_id());
>         lockdep_assert_rq_held(rq);
>
>         /*
> @@ -5943,6 +5923,34 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
>         return nr_enqueued;
>  }
>
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
> + *
> + * Iterate over all of the tasks currently enqueued on the local DSQ of =
the
> + * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the n=
umber of
> + * processed tasks. Can only be called from ops.cpu_release().
> + */
> +__bpf_kfunc u32 scx_bpf_reenqueue_local(void)
> +{
> +       struct scx_sched *sch;
> +       struct rq *rq;
> +
> +       guard(rcu)();
> +       sch =3D rcu_dereference(scx_root);
> +       if (unlikely(!sch))
> +               return 0;
> +
> +       if (!scx_kf_allowed(sch, SCX_KF_CPU_RELEASE))
> +               return 0;
> +
> +       rq =3D cpu_rq(smp_processor_id());
> +       lockdep_assert_rq_held(rq);
> +
> +       return reenq_local(rq);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(scx_kfunc_ids_cpu_release)
> --
> 2.47.1
>
