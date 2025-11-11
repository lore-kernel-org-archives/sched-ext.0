Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80F34251C
	for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875073; cv=none; b=kSwNDJ5fWDmHHNVqLYcnsBTouCUvvicz/vlacTAry10ZJ6gyASZnfA30pQ0Z+Foni2zMqWtEruSOnkp0saN5PeQtWx8H0b9YlnKkghjNgrYYSvEiQ41PQfPMAL9IBwNahHUKQjlwaOHJBkO3OD+l/oSqPqPV9hx6jDIhp2XjxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875073; c=relaxed/simple;
	bh=QBAXJ78fohyt6k2DI/5d/7XOCgEhX0xfNpRwM+nrwR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh1kHzpDTNEqsNMlnuNJiLbd4uoXIa2UeQgNMUKq8XGXkZi50VfW9wQoIrm3v4UqiZtN7dcIXnD/Def1hpWfMIn461jLM6OaprguCtcPSYmjEagX2Us7waJ2wxpVogZeYyEc8rUHGXjlIhQV6pJIztwjfMdxwxsCcFEnuUBv4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqvmi+mP; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqvmi+mP"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-880576ebe38so41050096d6.2
        for <sched-ext@lists.linux.dev>; Tue, 11 Nov 2025 07:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762875070; x=1763479870; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSFVN0bHdAdRdoucgDhNJZXr+UXErbmutQRh+BOF22I=;
        b=fqvmi+mPQpdR80bT4IyXEwvwXM7oBwT4jbly/oxMdguRlBOqUlyIwnslS5hs1zDsPq
         p3emwxgE8Uhhe9EPeDvR1+prSNv2HeSoLFhEVdhfFWGXxSax+1B31sbE7bxb5hZuwHYj
         uouof4RLbq3UYhrw7KAINUDMdYwyw1B1lnCOhrsetl7iMym3F8CpK4R7/yAqgBN8F6vI
         jY6ZdLlIVfk0LAK4vFYFOsEfN6rExOteCsphMgBjIsUiOOJBI3wuPRVBU3SwAlXOPMJq
         kmNCqVwqEEO2+TJ/lxafBC9NFMYS3/+c/qXCDBME5AhAbIcEYDlp2ElNPOpXM0QGvzwv
         Jb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762875070; x=1763479870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSFVN0bHdAdRdoucgDhNJZXr+UXErbmutQRh+BOF22I=;
        b=Hnu5vbNOvxZp3NvPfyYwjUv/6Ow+dZvDXf6fcB7w6x0XYVirP50+fVTRzlVjGHGaLP
         tLfARgbnIsqXiQbTbZIehXpNxCmMuoibqNR+C6DZJiuq+zaQ9MdvELZaFbpPRUeIdF3K
         6zvGn6UJw2pdD/c7yMBxLPPlG9JAtl+evk94J9bLsvLSDnGrv1oSmYB5B9a9JWMbvNu3
         asXMSgglvAy98rSxwhMz3H+eRbC8R+Jsqt8iUH7TtKEPkLV/TBUU9/tSlWQE6Yxj72Jy
         PdGErzIm5Hniphp2c4M3yJ6A2MPbhhlyxOfN7uSvaXCiAr7wkGPeHS3uoa6yotx79W1V
         u/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdkyLSUvBeM+oF1iavkieDdgFsonCnm5QqhllTK1+js1KBgNex9GNB0qlgNwRvoiSjWfH95gVM+0A=@lists.linux.dev
X-Gm-Message-State: AOJu0YwsMKv/FmdP0hKLtOeOVuU0gChup7024PGn7Tcm82Ro2RcM0P6W
	RDDvjJA9K+6xdyBkMb5Qh8ib458FzCierNRsh5TtM/Um7m9e/og6jmOL
X-Gm-Gg: ASbGncvlbE2qt8x+H9XgTsa5zeJmJ3DC/sAPI7lydG81ka8KGZ2feEuskzfUJW3CmmL
	P7Xg/NrYr3JmuPp+kzybX85z44obxTI61wv0GC4Y+K2b36/eRG4SNNU7e99ehOgi/O8Xatdg5zU
	AzKZI8MjWZJcq8xQ28OTip7eb7QmLJB/Ec10FCeHLZs0k4amiZq1HOXdEK2nxO0Zgv4XcvvWHe3
	BZfIvNeTo6Kb4+Q8EfJDxs38Id3PlvWykEuEU/Ii9ASIImdPEujg9UVnxEq+rs2GHF0W3hesySH
	u26l497gT+5HWs/Bb9VA3HdAh9yowG7PlyneOCQ8jeOSK2Hgtlv5KQONHFHkSuUbYodK9oFoBIi
	0CWERO4MRSNB42tEVm0CH3OzRklWfCa4bd/JNqAb7BPJUTUwzQcelIVzXUsy2wFaZhYhmen7UY1
	KtzUImbmjmjAr7gQ==
X-Google-Smtp-Source: AGHT+IHC238rt8Ac7Kvuq6Q1invfKYeCwvKqRQul76p/dB7Feo7vavQWqduyRaZvfI5nNYth4NoU8w==
X-Received: by 2002:a05:6214:20ef:b0:87c:f97:7acf with SMTP id 6a1803df08f44-88238703304mr213297486d6.62.1762875069798;
        Tue, 11 Nov 2025 07:31:09 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:708f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b92c4csm74255436d6.57.2025.11.11.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:31:09 -0800 (PST)
Date: Tue, 11 Nov 2025 10:31:07 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] sched_ext: Use per-CPU DSQs instead of per-node
 global DSQs in bypass mode
Message-ID: <aRNWu_4F_wGRlM2Z@dschatzberg-fedora-PF3DHTBV>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-5-tj@kernel.org>

On Sun, Nov 09, 2025 at 08:31:03AM -1000, Tejun Heo wrote:
> When bypass mode is activated, tasks are routed through a fallback dispatch
> queue instead of the BPF scheduler. Originally, bypass mode used a single
> global DSQ, but this didn't scale well on NUMA machines and could lead to
> livelocks. In b7b3b2dbae73 ("sched_ext: Split the global DSQ per NUMA node"),
> this was changed to use per-node global DSQs, which resolved the
> cross-node-related livelocks.
> 
> However, Dan Schatzberg found that per-node global DSQ can also livelock in a
> different scenario: On a NUMA node with many CPUs and many threads pinned to
> different small subsets of CPUs, each CPU often has to scan through many tasks
> it cannot run to find the one task it can run. With a high number of CPUs,
> this scanning overhead can easily cause livelocks.
> 
> Change bypass mode to use dedicated per-CPU bypass DSQs. Each task is queued
> on the CPU that it's currently on. Because the default idle CPU selection
> policy and direct dispatch are both active during bypass, this works well in
> most cases including the above.
> 
> However, this does have a failure mode in highly over-saturated systems where
> tasks are concentrated on a single CPU. If the BPF scheduler places most tasks
> on one CPU and then triggers bypass mode, bypass mode will keep those tasks on
> that one CPU, which can lead to failures such as RCU stalls as the queue may be
> too long for that CPU to drain in a reasonable time. This will be addressed
> with a load balancer in a future patch. The bypass DSQ is kept separate from
> the local DSQ to allow the load balancer to move tasks between bypass DSQs.
> 
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/sched/ext.h |  1 +
>  kernel/sched/ext.c        | 16 +++++++++++++---
>  kernel/sched/sched.h      |  1 +
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 9f5b0f2be310..e1502faf6241 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -57,6 +57,7 @@ enum scx_dsq_id_flags {
>  	SCX_DSQ_INVALID		= SCX_DSQ_FLAG_BUILTIN | 0,
>  	SCX_DSQ_GLOBAL		= SCX_DSQ_FLAG_BUILTIN | 1,
>  	SCX_DSQ_LOCAL		= SCX_DSQ_FLAG_BUILTIN | 2,
> +	SCX_DSQ_BYPASS		= SCX_DSQ_FLAG_BUILTIN | 3,
>  	SCX_DSQ_LOCAL_ON	= SCX_DSQ_FLAG_BUILTIN | SCX_DSQ_FLAG_LOCAL_ON,
>  	SCX_DSQ_LOCAL_CPU_MASK	= 0xffffffffLLU,
>  };
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index a29bfadde89d..4b8b91494947 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1301,7 +1301,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  
>  	if (scx_rq_bypassing(rq)) {
>  		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
> -		goto global;
> +		goto bypass;
>  	}
>  
>  	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
> @@ -1359,6 +1359,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  global:
>  	dsq = find_global_dsq(sch, p);
>  	goto enqueue;
> +bypass:
> +	dsq = &task_rq(p)->scx.bypass_dsq;
> +	goto enqueue;
>  
>  enqueue:
>  	/*
> @@ -2157,8 +2160,14 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
>  	if (consume_global_dsq(sch, rq))
>  		goto has_tasks;
>  
> -	if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
> -	    scx_rq_bypassing(rq) || !scx_rq_online(rq))
> +	if (scx_rq_bypassing(rq)) {
> +		if (consume_dispatch_q(sch, rq, &rq->scx.bypass_dsq))
> +			goto has_tasks;
> +		else
> +			goto no_tasks;
> +	}
> +
> +	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
>  		goto no_tasks;
>  
>  	dspc->rq = rq;
> @@ -5370,6 +5379,7 @@ void __init init_sched_ext_class(void)
>  		int  n = cpu_to_node(cpu);
>  
>  		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
> +		init_dsq(&rq->scx.bypass_dsq, SCX_DSQ_BYPASS);
>  		INIT_LIST_HEAD(&rq->scx.runnable_list);
>  		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 27aae2a298f8..5991133a4849 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -808,6 +808,7 @@ struct scx_rq {
>  	struct balance_callback	deferred_bal_cb;
>  	struct irq_work		deferred_irq_work;
>  	struct irq_work		kick_cpus_irq_work;
> +	struct scx_dispatch_q	bypass_dsq;
>  };
>  #endif /* CONFIG_SCHED_CLASS_EXT */
>  
> -- 
> 2.51.1
> 

Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>
