Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B6A480342
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830378; cv=none; b=PzCmLQb4zGcSqsVYY4/OGhlNoWysSxipjsbuHP3Xt34e5wb92lTbW5QTTVElckmiQt3HZtDDLNcXK49+oeHtV6StpFp5y6GoNEIDlBK+tTjLP53Ldq2dHcF4VPiJIQyH4AO2YpVYT2EiwvQXvWblz8vMhSLWqQSzxIe44T5AEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830378; c=relaxed/simple;
	bh=pBSrh7n9zfC4yRqe4M5RKyuj1n4ovuQev213YWPb1p0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Va7iTf+boZHVoNM0t2t485tLvSkOvQcaII5qiwNYgpVzC0a0LcPD0yWKDt7yb3yc4IGAIReDyg7MUKJc/bq63UsDArF4+Y1N7Egx7/AmaAyGdRyVjUIxpbSKmYbJDL+QcPeBykaVDLMYrhvCaFz3/6ve58nl4Q9qVeyF4r+c6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=fBfGqj+y; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="fBfGqj+y"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd759f502dso31964185a.3
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 12:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772830375; x=1773435175; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VDCfgcHJ+D4cblCuaPqSDuGNSSw2HHIqymIwPMAZ3s=;
        b=fBfGqj+y586uCh3okRnhbFA3tTPA0j0QPa4M9f5M1BuyfOphzBPOHJThDVC/RsF7Ci
         sK70UEOd7WWTgPbKTYJ8FAJ9yQCn/dbDbS0L87v//KBimdI5g6vTB0RDJI4iAelH6KJZ
         eR930Kay06K2AtKdoIEqkoe6/D8PstXntOzBSyldo1eP4evOaqlTeSGq+Y2zoGlGP1p2
         wEn05QOgkf+QihfMQeYhmsPRQClcVVVZ9NbpU6OHdUvT78tRlTjCwjQV/rT4326xjlRp
         xl6xwmikEANmh3DP1DgY5yspSKi3ACxcdBlIEahe+Ohu9gSSCk8raVzR4BCnBP3TlBWe
         qdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772830375; x=1773435175;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VDCfgcHJ+D4cblCuaPqSDuGNSSw2HHIqymIwPMAZ3s=;
        b=VF0Ao/6AW0W6pRtYLLAX08GlonekjbZ5FuB1B8Ga1ifdEGnQng0nYOfL3uZa1ShGLP
         T53WIqAxKexSKvmdB5Z6pXXRI9/DUAE3hbSCxgxKHpfyr5l/vBm9cffKUxej5jYVH16d
         mA6RuV4EpVIDCr7+0O12lue1gt8Wl5qpOJ2O4q3KL+x22FNh9du0zkMkFmJQFQNOa+ul
         wT7z+HlqzGctHNvvK94MZczcMLqZxZrkWGOs3V2cjbZZgC6LAjxdwjrYBCv2wsSCf8ug
         uQQFVE0Y4UoCXxWZ6UQg+/DKUM7Di6qE52Tz+tyTQbdGd8icfqU+OS5le9IQufYbDMny
         3c2g==
X-Forwarded-Encrypted: i=1; AJvYcCXCuhUfmMQtVGnBVaJpFiPBdao0HUZsHQBju4ar97/I6n3M57Sm0uBS4t9x7a0MPDQlPTr4rjjfj6o=@lists.linux.dev
X-Gm-Message-State: AOJu0YwAx0UejP4E3mg0Bky1n+BeYNMUfI3N98fG/ygSdSog9N7e3be9
	89eWrVKnzvxiOpmbDJDy2M+JME2mX5tfxt2yzh/jz1/s8QplDrlSvglMf7e+Gh+w68E=
X-Gm-Gg: ATEYQzy+no7saLUMFTknZRB7lmyHV1o0GKE09SP1stfFdTUufwhz7mg3eRDuX7Ioxev
	mAVLatCEB3fue/YhV11ZIu9+OzdkOiE/BrBmzGodkg3ssX2NQFUbRfsu6YTlRCC6X+dBCqzRdF1
	MtUf5iRPDBXm+qlSwt9yxs6Ecbhj3TfNU9jBEft6jgxoLsZWLPZGcpSbDKTjseD4Yw4sTjAhuku
	nqbVMEye7giZKRaUrp/Z38BgirerWMlY3SPadBUxYM6SLdMqedadR/qyLm7IA+gU24X7wVy1z1W
	4voaPZC8rmM2WUNS+Te+Twjdhy52N5hLJqAW+0kyzkkIfpZghLXUoRnNpCVZFunRnOi33uxcV9c
	Ni5xSf4UiZedrJiAlu0/9/43cdTkuQhh1fQYBSf58qZkXlR6errZYc5ulg0e94hv8/8CT9CB9q5
	9T5djlwqrmr7uP9hG7WGuJt/I=
X-Received: by 2002:a05:620a:3f85:b0:8ca:3175:cc72 with SMTP id af79cd13be357-8cd6d3d99c0mr452069985a.15.1772830375332;
        Fri, 06 Mar 2026 12:52:55 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f484288sm183999885a.7.2026.03.06.12.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 12:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 15:52:53 -0500
Message-Id: <DGVZX2DNAOAK.183TRISYDAWE5@etsalapatis.com>
Cc: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>
Subject: Re: [PATCH 02/15] sched_ext: Wrap global DSQs in per-node structure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <sched-ext@lists.linux.dev>
X-Mailer: aerc 0.20.1
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-3-tj@kernel.org>
In-Reply-To: <20260306190623.1076074-3-tj@kernel.org>

On Fri Mar 6, 2026 at 2:06 PM EST, Tejun Heo wrote:
> Global DSQs are currently stored as an array of scx_dispatch_q pointers,
> one per NUMA node. To allow adding more per-node data structures, wrap th=
e
> global DSQ in scx_sched_pnode and replace global_dsqs with pnode array.
>
> NUMA-aware allocation is maintained. No functional changes.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c          | 32 ++++++++++++++++----------------
>  kernel/sched/ext_internal.h |  6 +++++-
>  2 files changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index fe222df1d494..9232abea4f22 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -344,7 +344,7 @@ static bool scx_is_descendant(struct scx_sched *sch, =
struct scx_sched *ancestor)
>  static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch,
>  					      struct task_struct *p)
>  {
> -	return sch->global_dsqs[cpu_to_node(task_cpu(p))];
> +	return &sch->pnode[cpu_to_node(task_cpu(p))]->global_dsq;
>  }
> =20
>  static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 d=
sq_id)
> @@ -2229,7 +2229,7 @@ static bool consume_global_dsq(struct scx_sched *sc=
h, struct rq *rq)
>  {
>  	int node =3D cpu_to_node(cpu_of(rq));
> =20
> -	return consume_dispatch_q(sch, rq, sch->global_dsqs[node]);
> +	return consume_dispatch_q(sch, rq, &sch->pnode[node]->global_dsq);
>  }
> =20
>  /**
> @@ -4148,8 +4148,8 @@ static void scx_sched_free_rcu_work(struct work_str=
uct *work)
>  	free_percpu(sch->pcpu);
> =20
>  	for_each_node_state(node, N_POSSIBLE)
> -		kfree(sch->global_dsqs[node]);
> -	kfree(sch->global_dsqs);
> +		kfree(sch->pnode[node]);
> +	kfree(sch->pnode);
> =20
>  	rhashtable_walk_enter(&sch->dsq_hash, &rht_iter);
>  	do {
> @@ -5707,23 +5707,23 @@ static struct scx_sched *scx_alloc_and_add_sched(=
struct sched_ext_ops *ops,
>  	if (ret < 0)
>  		goto err_free_ei;
> =20
> -	sch->global_dsqs =3D kzalloc_objs(sch->global_dsqs[0], nr_node_ids);
> -	if (!sch->global_dsqs) {
> +	sch->pnode =3D kzalloc_objs(sch->pnode[0], nr_node_ids);
> +	if (!sch->pnode) {
>  		ret =3D -ENOMEM;
>  		goto err_free_hash;
>  	}
> =20
>  	for_each_node_state(node, N_POSSIBLE) {
> -		struct scx_dispatch_q *dsq;
> +		struct scx_sched_pnode *pnode;
> =20
> -		dsq =3D kzalloc_node(sizeof(*dsq), GFP_KERNEL, node);
> -		if (!dsq) {
> +		pnode =3D kzalloc_node(sizeof(*pnode), GFP_KERNEL, node);
> +		if (!pnode) {
>  			ret =3D -ENOMEM;
> -			goto err_free_gdsqs;
> +			goto err_free_pnode;
>  		}
> =20
> -		init_dsq(dsq, SCX_DSQ_GLOBAL, sch);
> -		sch->global_dsqs[node] =3D dsq;
> +		init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch);
> +		sch->pnode[node] =3D pnode;
>  	}
> =20
>  	sch->dsp_max_batch =3D ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH=
;
> @@ -5732,7 +5732,7 @@ static struct scx_sched *scx_alloc_and_add_sched(st=
ruct sched_ext_ops *ops,
>  				   __alignof__(struct scx_sched_pcpu));
>  	if (!sch->pcpu) {
>  		ret =3D -ENOMEM;
> -		goto err_free_gdsqs;
> +		goto err_free_pnode;
>  	}
> =20
>  	for_each_possible_cpu(cpu)
> @@ -5819,10 +5819,10 @@ static struct scx_sched *scx_alloc_and_add_sched(=
struct sched_ext_ops *ops,
>  	kthread_destroy_worker(sch->helper);
>  err_free_pcpu:
>  	free_percpu(sch->pcpu);
> -err_free_gdsqs:
> +err_free_pnode:
>  	for_each_node_state(node, N_POSSIBLE)
> -		kfree(sch->global_dsqs[node]);
> -	kfree(sch->global_dsqs);
> +		kfree(sch->pnode[node]);
> +	kfree(sch->pnode);
>  err_free_hash:
>  	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
>  err_free_ei:
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 4cb97093b872..9e5ebd00ea0c 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -975,6 +975,10 @@ struct scx_sched_pcpu {
>  	struct scx_dsp_ctx	dsp_ctx;
>  };
> =20
> +struct scx_sched_pnode {
> +	struct scx_dispatch_q	global_dsq;
> +};
> +
>  struct scx_sched {
>  	struct sched_ext_ops	ops;
>  	DECLARE_BITMAP(has_op, SCX_OPI_END);
> @@ -988,7 +992,7 @@ struct scx_sched {
>  	 * per-node split isn't sufficient, it can be further split.
>  	 */
>  	struct rhashtable	dsq_hash;
> -	struct scx_dispatch_q	**global_dsqs;
> +	struct scx_sched_pnode	**pnode;
>  	struct scx_sched_pcpu __percpu *pcpu;
> =20
>  	u64			slice_dfl;

