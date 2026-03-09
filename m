Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2EA3D7D79
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076326; cv=none; b=PY8JaPqVZPPBWkIXDe/vVOMg77BYCuXHb5SuEH5pnGZfPQQGg7SD88VAM7fA0ygC2zfP3cxGIkNPb2dHx2czT+9dbFg9Zb5zM+xWaZbjc/Z0GuomQL8Yqp1uu3dNVFQZiAUwwemh/6FTFcxIv9uiyZfXEeYSCc3GejNcug5tsfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076326; c=relaxed/simple;
	bh=ioHCFboMJ8oqiphs6dv4kXb09hx9Se8yAQH/FPf6QrQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=F3znD/RstbDIrDPyf9upzOBeX5i03ZwFbwtEDwvu4U1Bv0VpavzElYKm4JOthbTgVNKiBAmFcFaLHaqqD7//S+0sNSHdqdnngalnbcdRB4QzoTghc+JA/jRV12iDjzRooM3m0Fjqgn53MaxVmkykWFwNadA89YQg3CIVCCGpkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=xh/UacLG; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="xh/UacLG"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899e43ae2e1so78095356d6.2
        for <sched-ext@lists.linux.dev>; Mon, 09 Mar 2026 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773076323; x=1773681123; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lYzqIn+FaOdD2SARBApjeq99xVzSR8Dt/kxB2M4ZAw=;
        b=xh/UacLGSvO0JT6aOIn2wGzmNejOQDH2c4YyLPMVYQ5SfOoSfEp26ff0Fz+a0yj16L
         2/lifZy5SWHLqM4L25jag2RbV3WH6acT0w9qBUMjshizKMAoTmsDmaEuiG6d+hycylgz
         8w+qJDWEYl6qmhHxmw15NFRHp/c9VymnvrxinxdC9jr9cLRT6D9zOmn6qzUpKpJAkYQA
         YFmH4VB28fcPmiuD1CF1ffmKlfC5hruYI6XLaPJdyFonYCTcvKuYXGIHBplbS/XNY9CB
         ZaBNC5k6ajv6wBmr3+QLfru0LBXwOOSWr5LEHhi3oe6L2vhZW5kPBz++BmgUMJf3ma5B
         211A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076323; x=1773681123;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lYzqIn+FaOdD2SARBApjeq99xVzSR8Dt/kxB2M4ZAw=;
        b=O7e8rpSn0E3n6u+x8P5ScrNFwd5Fk1LDj3v3hpo2v6oGlFW4pgMbupPoM4Ab0/RSvE
         qkvD1VQQqjdUHnxXI1Hjs2nnuPbjeaN5S1YITcHHq4d7163hduS8vmsavkCGwCyOiMMc
         DIn6VrzwGwAR2VbRntSNI5jsiKamS24nGNuzbO34xbG6u2C4M4ECDMu4fY4AGZv2KcdC
         RVZ8rm96+EqKrW1AroHG7KN1DGUD+Xk/8LjPsrNjYJPhGzHP2U0zRZQPxd6sQPYxec29
         GeuQJ5zWJBlprf9keiFt6v8OotEwdha834si64cXJlUXBYFw7/bBUvP4qivl1KB6PVeN
         zZEA==
X-Forwarded-Encrypted: i=1; AJvYcCUG8Km4a61cjzIdMEYwvNLe1J4dQncRh+ck0627Dftp9xoibWoHwzxA+vEa0bzVDo6x72KEOXP3d0k=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4Orbn+GtRLG2G8P3dSVsUMj9392CamPmaNagZAL+RTVv2Foda
	IrB04uMhzm9hdRxIQgEojtK7rJG2LNbMgI01Dsq/x80Z2tLXKtTSosAAi64k1t/mFRQDLJFV2Rz
	2L79t
X-Gm-Gg: ATEYQzz9+Pk1X7wMzZGevidP8M1sS9caJQYaovIhPv05/DS0UAKmaEJkTeDo95E8ZYl
	kgH+M30AkxKgBolyZmTVU2OqUNg/3s13k3fWn6PaRQDA/KIC3PoQZQW4xfrN+zR4TK2Om0/i63C
	OG5uYt/zr9XxK0QH69fQPalvOddf4clP46a95fcIxE0FvnFmyhm4Riu9WYHFE37jO4s5A1AzBej
	wDq6+AoGu9L2OP/5RPuO4ZMBUnPkoW7VfIMdYVT8N/zSlkUrdIdTqj2tDkfAPjOcz/5J3omKpu9
	7X7zIay6GCz0902dt9PECrdatCLEW+vJ2RsTYlIypgnlim3qsxIDet5e4e+sLwk3A2bJ5Q1hc14
	51g1kU87AfywWMFj1/PWpvdwZD1LkHFSdkSogdphA1UeH50PXVxAhGhqnKPLG2dRNXaT9Ug/18c
	4f3kIPehTyZ62CYI4f9XGi7ITkLHiGIf/6Vw==
X-Received: by 2002:a05:6214:d69:b0:89a:df:164 with SMTP id 6a1803df08f44-89a30a9e9c6mr163061756d6.39.1773076322528;
        Mon, 09 Mar 2026 10:12:02 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c4a0c6sm1967026d6.52.2026.03.09.10.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 13:12:01 -0400
Message-Id: <DGYF3L29QDRO.367HHV8YV77QW@etsalapatis.com>
Cc: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>
Subject: Re: [PATCH 06/15] sched_ext: Convert deferred_reenq_locals from
 llist to regular list
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <sched-ext@lists.linux.dev>
X-Mailer: aerc 0.20.1
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-7-tj@kernel.org>
In-Reply-To: <20260306190623.1076074-7-tj@kernel.org>

On Fri Mar 6, 2026 at 2:06 PM EST, Tejun Heo wrote:
> The deferred reenqueue local mechanism uses an llist (lockless list) for
> collecting schedulers that need their local DSQs re-enqueued. Convert to =
a
> regular list protected by a raw_spinlock.
>
> The llist was used for its lockless properties, but the upcoming changes =
to
> support remote reenqueue require more complex list operations that are
> difficult to implement correctly with lockless data structures. A spinloc=
k-
> protected regular list provides the necessary flexibility.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>


Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c          | 57 ++++++++++++++++++++++++-------------
>  kernel/sched/ext_internal.h |  2 +-
>  kernel/sched/sched.h        |  3 +-
>  3 files changed, 41 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 1b6cd1e4f8b9..ffccaf04e34d 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3640,23 +3640,37 @@ static u32 reenq_local(struct scx_sched *sch, str=
uct rq *rq)
>  	return nr_enqueued;
>  }
> =20
> -static void run_deferred(struct rq *rq)
> +static void process_deferred_reenq_locals(struct rq *rq)
>  {
> -	process_ddsp_deferred_locals(rq);
> -
> -	if (!llist_empty(&rq->scx.deferred_reenq_locals)) {
> -		struct llist_node *llist =3D
> -			llist_del_all(&rq->scx.deferred_reenq_locals);
> -		struct scx_sched_pcpu *pos, *next;
> +	lockdep_assert_rq_held(rq);
> =20
> -		llist_for_each_entry_safe(pos, next, llist,
> -					  deferred_reenq_locals_node) {
> -			init_llist_node(&pos->deferred_reenq_locals_node);
> -			reenq_local(pos->sch, rq);
> +	while (true) {
> +		struct scx_sched *sch;
> +
> +		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
> +			struct scx_sched_pcpu *sch_pcpu =3D
> +				list_first_entry_or_null(&rq->scx.deferred_reenq_locals,
> +							 struct scx_sched_pcpu,
> +							 deferred_reenq_local_node);
> +			if (!sch_pcpu)
> +				return;
> +
> +			sch =3D sch_pcpu->sch;

While both scx and sch_pcpu aren't used in this patch, they are useful
for subsequent patches.

> +			list_del_init(&sch_pcpu->deferred_reenq_local_node);
>  		}
> +
> +		reenq_local(sch, rq);
>  	}
>  }
> =20
> +static void run_deferred(struct rq *rq)
> +{
> +	process_ddsp_deferred_locals(rq);
> +
> +	if (!list_empty(&rq->scx.deferred_reenq_locals))
> +		process_deferred_reenq_locals(rq);
> +}
> +
>  #ifdef CONFIG_NO_HZ_FULL
>  bool scx_can_stop_tick(struct rq *rq)
>  {
> @@ -4180,13 +4194,13 @@ static void scx_sched_free_rcu_work(struct work_s=
truct *work)
> =20
>  	/*
>  	 * $sch would have entered bypass mode before the RCU grace period. As
> -	 * that blocks new deferrals, all deferred_reenq_locals_node's must be
> +	 * that blocks new deferrals, all deferred_reenq_local_node's must be
>  	 * off-list by now.
>  	 */
>  	for_each_possible_cpu(cpu) {
>  		struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(sch->pcpu, cpu);
> =20
> -		WARN_ON_ONCE(llist_on_list(&pcpu->deferred_reenq_locals_node));
> +		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local_node));
>  	}
> =20
>  	free_percpu(sch->pcpu);
> @@ -5799,7 +5813,7 @@ static struct scx_sched *scx_alloc_and_add_sched(st=
ruct sched_ext_ops *ops,
>  		struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(sch->pcpu, cpu);
> =20
>  		pcpu->sch =3D sch;
> -		init_llist_node(&pcpu->deferred_reenq_locals_node);
> +		INIT_LIST_HEAD(&pcpu->deferred_reenq_local_node);
>  	}
> =20
>  	sch->helper =3D kthread_run_worker(0, "sched_ext_helper");
> @@ -7126,7 +7140,8 @@ void __init init_sched_ext_class(void)
>  		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick_if_idle, GFP_KER=
NEL, n));
>  		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, =
n));
>  		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n))=
;
> -		init_llist_head(&rq->scx.deferred_reenq_locals);
> +		raw_spin_lock_init(&rq->scx.deferred_reenq_lock);
> +		INIT_LIST_HEAD(&rq->scx.deferred_reenq_locals);
>  		rq->scx.deferred_irq_work =3D IRQ_WORK_INIT_HARD(deferred_irq_workfn);
>  		rq->scx.kick_cpus_irq_work =3D IRQ_WORK_INIT_HARD(kick_cpus_irq_workfn=
);
> =20
> @@ -8358,7 +8373,6 @@ __bpf_kfunc void scx_bpf_reenqueue_local___v2(const=
 struct bpf_prog_aux *aux)
>  	unsigned long flags;
>  	struct scx_sched *sch;
>  	struct rq *rq;
> -	struct llist_node *lnode;
> =20
>  	raw_local_irq_save(flags);
> =20
> @@ -8374,9 +8388,14 @@ __bpf_kfunc void scx_bpf_reenqueue_local___v2(cons=
t struct bpf_prog_aux *aux)
>  		goto out_irq_restore;
> =20
>  	rq =3D this_rq();
> -	lnode =3D &this_cpu_ptr(sch->pcpu)->deferred_reenq_locals_node;
> -	if (!llist_on_list(lnode))
> -		llist_add(lnode, &rq->scx.deferred_reenq_locals);
> +	scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
> +		struct scx_sched_pcpu *pcpu =3D this_cpu_ptr(sch->pcpu);
> +
> +		if (list_empty(&pcpu->deferred_reenq_local_node))
> +			list_move_tail(&pcpu->deferred_reenq_local_node,
> +				       &rq->scx.deferred_reenq_locals);
> +	}
> +
>  	schedule_deferred(rq);
>  out_irq_restore:
>  	raw_local_irq_restore(flags);
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 9e5ebd00ea0c..80d40a9c5ad9 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -965,7 +965,7 @@ struct scx_sched_pcpu {
>  	 */
>  	struct scx_event_stats	event_stats;
> =20
> -	struct llist_node	deferred_reenq_locals_node;
> +	struct list_head	deferred_reenq_local_node;
>  	struct scx_dispatch_q	bypass_dsq;
>  #ifdef CONFIG_EXT_SUB_SCHED
>  	u32			bypass_host_seq;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ebe971d12cb8..0794852524e7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -808,7 +808,8 @@ struct scx_rq {
> =20
>  	struct task_struct	*sub_dispatch_prev;
> =20
> -	struct llist_head	deferred_reenq_locals;
> +	raw_spinlock_t		deferred_reenq_lock;
> +	struct list_head	deferred_reenq_locals;	/* scheds requesting reenq of l=
ocal DSQ */
>  	struct balance_callback	deferred_bal_cb;
>  	struct irq_work		deferred_irq_work;
>  	struct irq_work		kick_cpus_irq_work;

