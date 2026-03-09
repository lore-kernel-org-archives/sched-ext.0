Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5022D780A
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078483; cv=none; b=WG96le4SGrHJBrqbjZjP5sLHHUhHV6Kcu9eMEBBDqrFdxkzFkH0GiBrcavjKKYYPmFsl2guYcve2JkviUTU8WEvYnb8+5RgQUTgDA76dLoZIzUrl6BpU67bWgfOswkEZh2yeGolPFY8zF36IaCjal+vjunQMyFeul4frEgA8g5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078483; c=relaxed/simple;
	bh=AK+k1qV3vUGgBkhUMtURpvua9TmtQZljosk/cXxx0bc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oWjeSm+BqErEDHRefIjxXh1cvVjRFyfG/QMKG+zeEn3iaCd+cZVBdSpDNTbBhpspXnzZU1p4oj1vlEu3JIA61s1KG6BM5M1KM4wjQd7B62Rq2aaKMNv18Angs/R3R17PE/0aQ2Dvja1CqJkjdKw/WIDM0410ihFwj96s/cvtKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=jitmrwxJ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="jitmrwxJ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd8dbf4f2eso98603485a.2
        for <sched-ext@lists.linux.dev>; Mon, 09 Mar 2026 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773078480; x=1773683280; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCKTTr+L1FYL8d5Z4Ne3jyr/o8eaoC3+JTEqsPyvFTo=;
        b=jitmrwxJemV+XubvqaemmeK2GXu6g5YVSCmRs4xnMu2XINUC0MAQivFC6Dh03qV2Th
         ZIgalcaB8AzsEYQU5BxlWKODr/aYyox2fUZqr1A4H7nzFeKf8C5qBfngFWJOlyoWGEvl
         wNvKrUN657b96sUqzZfKpQIxpQRGdMBdC4BOjzOxHygVIrZYPd1N0Q3rXfqoAQo/T5km
         BFlyKrUNF9uCDUOYKjr29yv9WwOj0ZwhQU2apdgNXorJWiTe5n8IPzvBEYJYoIVrJnzJ
         aRw0ZqZYs7zM22shgxGWWiD09z6xGO0hAhVQB6AJYQOT1D6st4Ch1QXo4BIHWvPmF5Cd
         di2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078480; x=1773683280;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCKTTr+L1FYL8d5Z4Ne3jyr/o8eaoC3+JTEqsPyvFTo=;
        b=WJidxUONwuqhcFnCf/J+oytpcHgzGv/WlYpVLVF0++jMoJHNaq8Aq8SYhyXe/a054e
         Zyvr9YEtUj/Wsu2KKH7JW3A7HFolPeeC09gVLAu8ZXqIucrjktf8D3UaOtt4Sn8xxsHm
         nniQ3HfEGwM0Jvnm8fauCLAF9SadhHgACl4RG6pSQUkhrk32mRl7AJ8R4+Y9FhUKbObL
         0HHUT+NSS1qqd4W3XLkHYBxhpOzvz2/i36w/YY+NMFcgY7ffDozeBSiD9Tzkk+HFpNPR
         Y+LN0Ntxcqn54d4NM2RtPbaGo9fRr6F6MWuk34qPKtBjrB0jsvsM5FIiq4w3fMJWToNg
         GzHA==
X-Forwarded-Encrypted: i=1; AJvYcCVafcQWYVLNOetW47iivkQaM1XF4r885sxlRmlcRb0AFCpnAp1XMl2/spt7RqIzEkEZI687/IcIOqA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwL31CgclcoTZH0F6GFBiabLqzWQXET4b9ktwKOcjd4y8ASTRDK
	qALdcMUkvXH5FDYtelpyRPgSRekL1oNLcun+Mx7ioZKMVxAihjijfcxEgnvP45zfjLA=
X-Gm-Gg: ATEYQzwGh1k1fGZFqYO7JkfIu7+B07OjZr4OU63b7grOmj+zxiFR6GG5y631JogXk1H
	r/e2Q3flZJRl45xRQMHHeMRU2hvpnUv5YBwLbxxU1nhi3SkYPip7f07v4hfq9wM5e5Qz1X9ZzeS
	h3QpCcjbmLIiBsX+CpYzmg9R9baxX3ui1u28/F/wwIUge3/fRgluTUX7eYTjfie/53ja8ONXSCN
	G1MOgeI86k638+SrgSRmH49eOyG2RaypQDNGjxic9+Y+TE1dJA/0urscDoToIS4ZrcAoh33Vca1
	PATzgrXqv+luWBX8IY40kGMZ12kmGFQFTf8AmcYc69Z4ILJ0UAIMLGi+1m+ktAxVVLAPy76ToRV
	JL9BncAQXNwdLB4Wl2BuCLTYqn+rNelB9UHKa7GSROUf6qPhUF6SuunTUwfcFf88GgdYii+ZGD2
	fKcMab5d+UkoF1nRiKGR+wwCQ=
X-Received: by 2002:a05:620a:1723:b0:8cd:8ddd:26a3 with SMTP id af79cd13be357-8cd8ddd2bdbmr373075385a.48.1773078480378;
        Mon, 09 Mar 2026 10:48:00 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8641d344sm276812085a.31.2026.03.09.10.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 13:47:58 -0400
Message-Id: <DGYFV4CHVFBW.29DG4U4R14175@etsalapatis.com>
Cc: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>
Subject: Re: [PATCH 09/15] sched_ext: Add reenq_flags plumbing to
 scx_bpf_dsq_reenq()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <sched-ext@lists.linux.dev>
X-Mailer: aerc 0.20.1
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-10-tj@kernel.org>
In-Reply-To: <20260306190623.1076074-10-tj@kernel.org>

On Fri Mar 6, 2026 at 2:06 PM EST, Tejun Heo wrote:
> Add infrastructure to pass flags through the deferred reenqueue path.
> reenq_local() now takes a reenq_flags parameter, and scx_sched_pcpu gains=
 a
> deferred_reenq_local_flags field to accumulate flags from multiple
> scx_bpf_dsq_reenq() calls before processing. No flags are defined yet.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c          | 33 ++++++++++++++++++++++++++++-----
>  kernel/sched/ext_internal.h | 10 ++++++++++
>  2 files changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b02143b10f0f..c9b0e94d59bd 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1080,7 +1080,8 @@ static void schedule_deferred_locked(struct rq *rq)
>  	schedule_deferred(rq);
>  }
> =20
> -static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatc=
h_q *dsq)
> +static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatc=
h_q *dsq,
> +			       u64 reenq_flags)
>  {
>  	/*
>  	 * Allowing reenqueues doesn't make sense while bypassing. This also
> @@ -1097,6 +1098,7 @@ static void schedule_dsq_reenq(struct scx_sched *sc=
h, struct scx_dispatch_q *dsq
>  		scoped_guard (raw_spinlock_irqsave, &rq->scx.deferred_reenq_lock) {
>  			if (list_empty(&drl->node))
>  				list_move_tail(&drl->node, &rq->scx.deferred_reenq_locals);
> +			drl->flags |=3D reenq_flags;
>  		}
> =20
>  		schedule_deferred(rq);
> @@ -3618,7 +3620,14 @@ int scx_check_setscheduler(struct task_struct *p, =
int policy)
>  	return 0;
>  }
> =20
> -static u32 reenq_local(struct scx_sched *sch, struct rq *rq)
> +static bool task_should_reenq(struct task_struct *p, u64 reenq_flags)
> +{
> +	if (reenq_flags & SCX_REENQ_ANY)
> +		return true;
> +	return false;

Nit: (reenq_flags & SCX_REENQ_ANY) !=3D 0?

> +}
> +
> +static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_f=
lags)
>  {
>  	LIST_HEAD(tasks);
>  	u32 nr_enqueued =3D 0;
> @@ -3652,6 +3661,9 @@ static u32 reenq_local(struct scx_sched *sch, struc=
t rq *rq)
>  		if (!scx_is_descendant(task_sch, sch))
>  			continue;
> =20
> +		if (!task_should_reenq(p, reenq_flags))
> +			continue;
> +
>  		dispatch_dequeue(rq, p);
>  		list_add_tail(&p->scx.dsq_list.node, &tasks);
>  	}
> @@ -3671,6 +3683,7 @@ static void process_deferred_reenq_locals(struct rq=
 *rq)
> =20
>  	while (true) {
>  		struct scx_sched *sch;
> +		u64 reenq_flags =3D 0;
> =20
>  		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
>  			struct scx_deferred_reenq_local *drl =3D
> @@ -3685,10 +3698,11 @@ static void process_deferred_reenq_locals(struct =
rq *rq)
>  			sch_pcpu =3D container_of(drl, struct scx_sched_pcpu,
>  						deferred_reenq_local);
>  			sch =3D sch_pcpu->sch;
> +			swap(drl->flags, reenq_flags);
>  			list_del_init(&drl->node);
>  		}
> =20
> -		reenq_local(sch, rq);
> +		reenq_local(sch, rq, reenq_flags);
>  	}
>  }
> =20
> @@ -7817,7 +7831,7 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(const struc=
t bpf_prog_aux *aux)
>  	rq =3D cpu_rq(smp_processor_id());
>  	lockdep_assert_rq_held(rq);
> =20
> -	return reenq_local(sch, rq);
> +	return reenq_local(sch, rq, 0);
>  }
> =20
>  __bpf_kfunc_end_defs();
> @@ -8255,8 +8269,17 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64=
 reenq_flags,
>  	if (unlikely(!sch))
>  		return;
> =20
> +	if (unlikely(reenq_flags & ~__SCX_REENQ_USER_MASK)) {
> +		scx_error(sch, "invalid SCX_REENQ flags 0x%llx", reenq_flags);
> +		return;
> +	}
> +
> +	/* not specifying any filter bits is the same as %SCX_REENQ_ANY */
> +	if (!(reenq_flags & __SCX_REENQ_FILTER_MASK))
> +		reenq_flags |=3D SCX_REENQ_ANY;
> +
>  	dsq =3D find_dsq_for_dispatch(sch, this_rq(), dsq_id, smp_processor_id(=
));
> -	schedule_dsq_reenq(sch, dsq);
> +	schedule_dsq_reenq(sch, dsq, reenq_flags);
>  }
> =20
>  /**
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 1a8d61097cab..d9eda2e8701c 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -956,6 +956,7 @@ struct scx_dsp_ctx {
> =20
>  struct scx_deferred_reenq_local {
>  	struct list_head	node;
> +	u64			flags;
>  };
> =20
>  struct scx_sched_pcpu {
> @@ -1128,6 +1129,15 @@ enum scx_deq_flags {
>  	SCX_DEQ_SCHED_CHANGE	=3D 1LLU << 33,
>  };
> =20
> +enum scx_reenq_flags {
> +	/* low 16bits determine which tasks should be reenqueued */
> +	SCX_REENQ_ANY		=3D 1LLU << 0,	/* all tasks */
> +
> +	__SCX_REENQ_FILTER_MASK	=3D 0xffffLLU,
> +
> +	__SCX_REENQ_USER_MASK	=3D SCX_REENQ_ANY,
> +};
> +
>  enum scx_pick_idle_cpu_flags {
>  	SCX_PICK_IDLE_CORE	=3D 1LLU << 0,	/* pick a CPU whose SMT siblings are =
also idle */
>  	SCX_PICK_IDLE_IN_NODE	=3D 1LLU << 1,	/* pick a CPU in the same target N=
UMA node */

