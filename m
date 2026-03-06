Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2811837883D
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831165; cv=none; b=CI2ejlkeuokClUrDe6M/56TFnDBbfhzk0IRiw9O7E2iGQ2WNJm0PK+zIX4wZm8c96FKncWuyN2zrqgQpT7P4funQfFGUYpN9cAEFkzfEOZL5HwP+rcuxX2FoYCm1cRSmVdHR+8HlSL7nMDvsmXTcAWQv6tTjgAR5//7FIBjdvuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831165; c=relaxed/simple;
	bh=aKeJ+jYVnSc6aUnP88KbsRy2JyOR0iRgjAr+Ltsv00Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=t0J+0iHv61T5csDCxWUGUzQPrQ1L2of73Pfa6ITPO7ZybgDZcUM075m/M3w+DYRhujr551ZOSivty5uWcoJBZpeqgv5o2UXUSdfF60DbGBGSynx9p5r5yo/z0HSWUmqS7lISRna1pVyq2uXgcsmCmf/ckZalHFKZI9xWpGW8O54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Dx0Up5ma; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Dx0Up5ma"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5069df1dea8so77162281cf.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 13:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772831163; x=1773435963; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8AhaB/v+2orrJY8LzngoycEWy1G/a6AEmgCr67UnpM=;
        b=Dx0Up5ma5JTqaVVD/TO/e5RjWxHe4cKLqLq2gMTEySHHEHPjYxMXmoU02BLVncPO0h
         WD8Xa5aZeaxrOzUSjUs77uydau512xn1hx8f0qL9BZo3T1EmWsjcPwrmHyFQrFMDzn39
         xQJ3ivND2Hj8rWWLmfSCVCrx1EEKOsjYGnMeKx8SmHLPmOSCvuFQUqPND11HjQ40reJZ
         XrixSQHCfdOyQ31Ke27cYFv346Gu6gq7foDuiJOeq6f3zC2SeSeQ0ZbOZYao+wLBQKle
         8cyEmuZ6rpwhC5SbZL60iaN4oGgEacOohZMbbwU5xBNmVqQSZQZ6UMBa+udyvSiokbSH
         DwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831163; x=1773435963;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k8AhaB/v+2orrJY8LzngoycEWy1G/a6AEmgCr67UnpM=;
        b=P8454VurU389JOYExZZZBhtbjXz2+Cx0Cb+AXr3iDIzQk2NCvewW846pa1DZcuVFlc
         4FFYCqpW19XY7c/7BatV21MLoN2vhn+HQwi9qym6dgkL5byjrc87ppezu7gHc6zkWV6P
         WZQn4AhPjfhYM7ripPOpl5JHc0ZZBkyBkkK0jMMQP2aaSKEDNvxLC1ATKKg0hjLBKdr5
         XrFDCVSJYMjda+uqhpRcLTH+DECzOw8p5Mr/G0AvHl1A0Cfaju2CeX2YyxCJySFzib2W
         WzcT9PmCW8DUuYvbOvRQa+KpiG2Jg5zGPgSRh+ompG9noWbKXTAxuRVc0cvcwFvGIxOU
         X6gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXERwE3srZeqPk4uEkyDSfwivAxJZRT4c5r6fhhHSdIJIlnfruTc9/BTKU76YHP67wn8H9LIlvqvqA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+QhKykOUYLToiyL9lHKeJ0vMiEsWIf1vwKRwyCpX39Y65G7x3
	yWnRVL3/RZLM03WJcF7z7ij2/IcKUBWxOs8w9zBEmN03E72RSj5z8FX+8re5MqWiGho=
X-Gm-Gg: ATEYQzyiE+OgIV6x2vAQVEc413BACTugyjc2KXg1aiK8FNGO8kccerJe8FtjrCNAty5
	19R+//bzRlP9VvHlT2Mex4mZc/uMAz5hOkTv+4EpQHauJb/v7ZGrJdIS4l5e5n+IoXiZUPKeTUb
	6CHgk4sT3/agPiQcEPsDExBOGoSVUd1HvLn/mHpbGSUEYpm88Xe2g2QobypK2kciXzbcbKhUn1S
	xHLCiIjayHpulSSRH3VFVJCxhji8NTXuB7XICBWZHXvcBhmHTXW8U2MMDsVw9/MlNQ6Ewd2c5n2
	B7yFYvfWsrlLKNpTUaOMoN1CpfC+jARZQ2c1/rbcErCa7yjz69rsL9L9q9jdhvignoKIV2N1Bvb
	vdYmTndFQZ59T1MpJVp8zuJSswgSiSgnIjZ8XlmKiJ8aGzdlndo5FFcy5jZH7EyrTdMcvjQFy/8
	HCye4rDyElU2tQq+vPJMMo6MM=
X-Received: by 2002:a05:622a:1aa1:b0:4e8:baad:9875 with SMTP id d75a77b69052e-508f46c84a0mr48281651cf.4.1772831162900;
        Fri, 06 Mar 2026 13:06:02 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f6695738sm20402271cf.16.2026.03.06.13.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 13:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 16:06:01 -0500
Message-Id: <DGW0747O0XMX.1ORTAC5SUVU6Z@etsalapatis.com>
Cc: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>
Subject: Re: [PATCH 04/15] sched_ext: Change find_global_dsq() to take CPU
 number instead of task
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <sched-ext@lists.linux.dev>
X-Mailer: aerc 0.20.1
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-5-tj@kernel.org>
In-Reply-To: <20260306190623.1076074-5-tj@kernel.org>

On Fri Mar 6, 2026 at 2:06 PM EST, Tejun Heo wrote:
> Change find_global_dsq() to take a CPU number directly instead of a task
> pointer. This prepares for callers where the CPU is available but the tas=
k is
> not.
>
> No functional changes.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c36d399bca3e..c44893878878 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -341,10 +341,9 @@ static bool scx_is_descendant(struct scx_sched *sch,=
 struct scx_sched *ancestor)
>  	for ((pos) =3D scx_next_descendant_pre(NULL, (root)); (pos);		\
>  	     (pos) =3D scx_next_descendant_pre((pos), (root)))
> =20
> -static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch,
> -					      struct task_struct *p)
> +static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch, s32=
 tcpu)

Nit: Maybe rename tcpu to cpu? It's only a task's CPU because we currently =
use it
that way, and the name is no longer obvious.

>  {
> -	return &sch->pnode[cpu_to_node(task_cpu(p))]->global_dsq;
> +	return &sch->pnode[cpu_to_node(tcpu)]->global_dsq;
>  }
> =20
>  static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 d=
sq_id)
> @@ -1266,7 +1265,7 @@ static void dispatch_enqueue(struct scx_sched *sch,=
 struct rq *rq,
>  			scx_error(sch, "attempting to dispatch to a destroyed dsq");
>  			/* fall back to the global dsq */
>  			raw_spin_unlock(&dsq->lock);
> -			dsq =3D find_global_dsq(sch, p);
> +			dsq =3D find_global_dsq(sch, task_cpu(p));
>  			raw_spin_lock(&dsq->lock);
>  		}
>  	}
> @@ -1474,7 +1473,7 @@ static void dispatch_dequeue_locked(struct task_str=
uct *p,
> =20
>  static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sc=
h,
>  						    struct rq *rq, u64 dsq_id,
> -						    struct task_struct *p)
> +						    s32 tcpu)
>  {
>  	struct scx_dispatch_q *dsq;
> =20
> @@ -1485,20 +1484,19 @@ static struct scx_dispatch_q *find_dsq_for_dispat=
ch(struct scx_sched *sch,
>  		s32 cpu =3D dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
> =20
>  		if (!ops_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
> -			return find_global_dsq(sch, p);
> +			return find_global_dsq(sch, tcpu);
> =20
>  		return &cpu_rq(cpu)->scx.local_dsq;
>  	}
> =20
>  	if (dsq_id =3D=3D SCX_DSQ_GLOBAL)
> -		dsq =3D find_global_dsq(sch, p);
> +		dsq =3D find_global_dsq(sch, tcpu);
>  	else
>  		dsq =3D find_user_dsq(sch, dsq_id);
> =20
>  	if (unlikely(!dsq)) {
> -		scx_error(sch, "non-existent DSQ 0x%llx for %s[%d]",
> -			  dsq_id, p->comm, p->pid);
> -		return find_global_dsq(sch, p);
> +		scx_error(sch, "non-existent DSQ 0x%llx", dsq_id);
> +		return find_global_dsq(sch, tcpu);
>  	}
> =20
>  	return dsq;
> @@ -1540,7 +1538,7 @@ static void direct_dispatch(struct scx_sched *sch, =
struct task_struct *p,
>  {
>  	struct rq *rq =3D task_rq(p);
>  	struct scx_dispatch_q *dsq =3D
> -		find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
> +		find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, task_cpu(p));
> =20
>  	touch_core_sched_dispatch(rq, p);
> =20
> @@ -1683,7 +1681,7 @@ static void do_enqueue_task(struct rq *rq, struct t=
ask_struct *p, u64 enq_flags,
>  	dsq =3D &rq->scx.local_dsq;
>  	goto enqueue;
>  global:
> -	dsq =3D find_global_dsq(sch, p);
> +	dsq =3D find_global_dsq(sch, task_cpu(p));
>  	goto enqueue;
>  bypass:
>  	dsq =3D bypass_enq_target_dsq(sch, task_cpu(p));
> @@ -2140,7 +2138,7 @@ static struct rq *move_task_between_dsqs(struct scx=
_sched *sch,
>  		dst_rq =3D container_of(dst_dsq, struct rq, scx.local_dsq);
>  		if (src_rq !=3D dst_rq &&
>  		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> -			dst_dsq =3D find_global_dsq(sch, p);
> +			dst_dsq =3D find_global_dsq(sch, task_cpu(p));
>  			dst_rq =3D src_rq;
>  		}
>  	} else {
> @@ -2269,7 +2267,7 @@ static void dispatch_to_local_dsq(struct scx_sched =
*sch, struct rq *rq,
> =20
>  	if (src_rq !=3D dst_rq &&
>  	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> -		dispatch_enqueue(sch, rq, find_global_dsq(sch, p), p,
> +		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
>  				 enq_flags | SCX_ENQ_CLEAR_OPSS);
>  		return;
>  	}
> @@ -2407,7 +2405,7 @@ static void finish_dispatch(struct scx_sched *sch, =
struct rq *rq,
> =20
>  	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
> =20
> -	dsq =3D find_dsq_for_dispatch(sch, this_rq(), dsq_id, p);
> +	dsq =3D find_dsq_for_dispatch(sch, this_rq(), dsq_id, task_cpu(p));
> =20
>  	if (dsq->id =3D=3D SCX_DSQ_LOCAL)
>  		dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
> @@ -2647,7 +2645,7 @@ static void process_ddsp_deferred_locals(struct rq =
*rq)
> =20
>  		list_del_init(&p->scx.dsq_list.node);
> =20
> -		dsq =3D find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
> +		dsq =3D find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, task_cpu(p)=
);
>  		if (!WARN_ON_ONCE(dsq->id !=3D SCX_DSQ_LOCAL))
>  			dispatch_to_local_dsq(sch, rq, dsq, p,
>  					      p->scx.ddsp_enq_flags);
> @@ -7410,7 +7408,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_ke=
rn *kit,
>  	}
> =20
>  	/* @p is still on $src_dsq and stable, determine the destination */
> -	dst_dsq =3D find_dsq_for_dispatch(sch, this_rq, dsq_id, p);
> +	dst_dsq =3D find_dsq_for_dispatch(sch, this_rq, dsq_id, task_cpu(p));
> =20
>  	/*
>  	 * Apply vtime and slice updates before moving so that the new time is

