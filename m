Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7733BBB5
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076612; cv=none; b=GnGd1Umb+oUPWnTPKglnHBnRi1olBtEIn+2ZkkKCHKeP1IKAp9doSp8YlATKjatNKGDV0WKKOzIDNMU/l8kWjEU09tK5wa6TZbQQU+2YWUJBm+a9c45VQhEalmC/KRRtwEjy3F7RVO2QbxxdW0dp2MsI0ZZvnvpC+eD538491w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076612; c=relaxed/simple;
	bh=98am/GX184aN/jxZILWqoYJpBgZpE8WfZH2WonIweo8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CJt5qXfXvDOW/ParQu9p1v5UXiL7rchj9Wch4ZWCQ+nSHfZEXqnfdbci0LZRIwgZjt2SWJjJiS9WbcbhSzar3Z0iCR92zzh6LeM0q1Lgd1EcY1B8jMbQ96cbeP/KpXGKwnzBSr/7YUc12Ehx2sGV0TaLKEMbSzB1NLdv+jfix5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=emk8dR4V; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="emk8dR4V"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cd8c6e365eso99623385a.0
        for <sched-ext@lists.linux.dev>; Mon, 09 Mar 2026 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773076610; x=1773681410; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ27IJuLI7VMJcZjmtOkWzEBuIgt/KJd26zrF5qP+ZQ=;
        b=emk8dR4V73dEdInI4N/spp0c0xhftqXqS0caOPdjPYB7wBHUP8cMOchJ4pww+DFmWf
         IW+ljhF2i/LarjwHRW921THMqa/AzBtaANiuP9yuzy0XT4r6iqQfEPHl4zLGpd/DckGQ
         ity+XFWJjM3mYba/VkyBIxYjYs2nM7NCqACgR/UKRgqJS6V0pvN38w05v1H/+Fv3IN2x
         qc+iJPl8KtuAgYfkustO5h2YqIMY3O+C0DrL/NvlnNxnC5DFCM1VMi34qy+yVv0N6C9+
         V2vhZ3SbYZbzd1oWNWY82ULvorFdA8CvCJS7qeotCgAe+kYOvK68Aa/xIrRwcmX2YQlP
         k69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076610; x=1773681410;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQ27IJuLI7VMJcZjmtOkWzEBuIgt/KJd26zrF5qP+ZQ=;
        b=CR21dss3OJFN2WE9IfgQ05Lt3kwQz+ZxwAsQ9t6CPY0vnKaICtpHLvV07remEdvWe3
         05mPx5z+/QLO3CAKCL4cLO8CQOLr7NioFafo6+gVhkjuzl25rbAq+lnq3uA7l21nRvWx
         bF+gXvlnCNhdMIIvyFxg6sb2jZzQ3VH4fNhNHE7zz25Fz4M1ktHUyLsOiqfecAWebyP9
         Di2DpKowwPPmIBSOHc8z7IZYSikt1xLFKCe/uJJmvrXuDN3HyHa5Ow5/oiixNUUiJkq6
         lC9g/y6kTaUSI1KtTztsUgPgC2rBOjL/A0mzyr7e/yGeQCoCb0v/6G4xC3z5cGyOoxeU
         Y5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXH+0A53cBhpLQJ6AyJqim595A0890xh2Tt1VPMz/kc6O8M9YEM5oJnSKzb1CC4yxVcO6TPyo4ApTI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxeAJLHJ4LA9wtS6E8sOvB9VDD1DZLq+l7C/qrt2cyiFnqmEfgg
	ok+UoVldXIEGbt1q+lVHn9VPhC355Kye676SBirUDjux7pMTRek7dYfDHPo0qZeF9co=
X-Gm-Gg: ATEYQzyBg2hUTpo9nkE4xOLMBPcPQ0wcrZbP7oakgZPZHM3sRi0+xqPzUTMTeIYefal
	bX+ZTpqUQrSUcQo7v0pXkQ7apOWFOGL5gw8mXFL0QZ+HiUv9k8r0L2zR05/jmiMd4nIwxcOwqN0
	OgwMBswbap3/KlevWD9S3zu84Q/bEltcOp0EAWJ1jQoRJsW3YglM6OwbDVshyTmHq+YlsAuGkYf
	8XGdYbasHk7U0lKGrk2m6Mo4qWeDDqndPoyKARtImuxWmpiuWrE04pnHudToujGDTA0z39mTjNq
	H6j6MZQybWqvBhvZgvXKjHq/ADTbBVI5b8ppabCwHeFM5njujjvvxjpn6bZK3b3IeKI8eSEY+OI
	UXHkhUFFncyNi7SNfhoTa6eYLBUyHMpveTv8mLIShhX5IeNXVaJ0ytmxisNgiQ3uE9t8yMtuAS0
	efh84S7oqtH06Wr/rFtyFFOr4=
X-Received: by 2002:a05:620a:4543:b0:8cb:71d4:d0fb with SMTP id af79cd13be357-8cd6d48496emr1467710885a.36.1773076610179;
        Mon, 09 Mar 2026 10:16:50 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8576db0esm301300685a.47.2026.03.09.10.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 13:16:45 -0400
Message-Id: <DGYF77XUIBT5.RJTOMX9QQMWM@etsalapatis.com>
Cc: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>
Subject: Re: [PATCH 07/15] sched_ext: Wrap deferred_reenq_local_node into a
 struct
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <sched-ext@lists.linux.dev>
X-Mailer: aerc 0.20.1
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-8-tj@kernel.org>
In-Reply-To: <20260306190623.1076074-8-tj@kernel.org>

On Fri Mar 6, 2026 at 2:06 PM EST, Tejun Heo wrote:
> Wrap the deferred_reenq_local_node list_head into struct
> scx_deferred_reenq_local. More fields will be added and this allows using=
 a
> shorthand pointer to access them.
>
> No functional change.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c          | 22 +++++++++++++---------
>  kernel/sched/ext_internal.h |  6 +++++-
>  2 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index ffccaf04e34d..80d1e6ccc326 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3648,15 +3648,19 @@ static void process_deferred_reenq_locals(struct =
rq *rq)
>  		struct scx_sched *sch;
> =20
>  		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
> -			struct scx_sched_pcpu *sch_pcpu =3D
> +			struct scx_deferred_reenq_local *drl =3D
>  				list_first_entry_or_null(&rq->scx.deferred_reenq_locals,
> -							 struct scx_sched_pcpu,
> -							 deferred_reenq_local_node);
> -			if (!sch_pcpu)
> +							 struct scx_deferred_reenq_local,
> +							 node);
> +			struct scx_sched_pcpu *sch_pcpu;
> +
> +			if (!drl)
>  				return;
> =20
> +			sch_pcpu =3D container_of(drl, struct scx_sched_pcpu,
> +						deferred_reenq_local);
>  			sch =3D sch_pcpu->sch;
> -			list_del_init(&sch_pcpu->deferred_reenq_local_node);
> +			list_del_init(&drl->node);
>  		}
> =20
>  		reenq_local(sch, rq);
> @@ -4200,7 +4204,7 @@ static void scx_sched_free_rcu_work(struct work_str=
uct *work)
>  	for_each_possible_cpu(cpu) {
>  		struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(sch->pcpu, cpu);
> =20
> -		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local_node));
> +		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
>  	}
> =20
>  	free_percpu(sch->pcpu);
> @@ -5813,7 +5817,7 @@ static struct scx_sched *scx_alloc_and_add_sched(st=
ruct sched_ext_ops *ops,
>  		struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(sch->pcpu, cpu);
> =20
>  		pcpu->sch =3D sch;
> -		INIT_LIST_HEAD(&pcpu->deferred_reenq_local_node);
> +		INIT_LIST_HEAD(&pcpu->deferred_reenq_local.node);
>  	}
> =20
>  	sch->helper =3D kthread_run_worker(0, "sched_ext_helper");
> @@ -8391,8 +8395,8 @@ __bpf_kfunc void scx_bpf_reenqueue_local___v2(const=
 struct bpf_prog_aux *aux)
>  	scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
>  		struct scx_sched_pcpu *pcpu =3D this_cpu_ptr(sch->pcpu);
> =20
> -		if (list_empty(&pcpu->deferred_reenq_local_node))
> -			list_move_tail(&pcpu->deferred_reenq_local_node,
> +		if (list_empty(&pcpu->deferred_reenq_local.node))
> +			list_move_tail(&pcpu->deferred_reenq_local.node,
>  				       &rq->scx.deferred_reenq_locals);
>  	}
> =20
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 80d40a9c5ad9..1a8d61097cab 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -954,6 +954,10 @@ struct scx_dsp_ctx {
>  	struct scx_dsp_buf_ent	buf[];
>  };
> =20
> +struct scx_deferred_reenq_local {
> +	struct list_head	node;
> +};
> +
>  struct scx_sched_pcpu {
>  	struct scx_sched	*sch;
>  	u64			flags;	/* protected by rq lock */
> @@ -965,7 +969,7 @@ struct scx_sched_pcpu {
>  	 */
>  	struct scx_event_stats	event_stats;
> =20
> -	struct list_head	deferred_reenq_local_node;
> +	struct scx_deferred_reenq_local deferred_reenq_local;
>  	struct scx_dispatch_q	bypass_dsq;
>  #ifdef CONFIG_EXT_SUB_SCHED
>  	u32			bypass_host_seq;

