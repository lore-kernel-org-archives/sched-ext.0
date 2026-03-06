Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A896481641
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772830486; cv=none; b=ZrpqT1Tvqj5WpycVwcJrvRwH6t/oJdsJOZbJHo8kxmDtpTjUbllZ209JJR3ItYP1Cu8OxHOj0HrwIBEO0cHnTjYzvh2EA5jVaMhQlqUSIfVFAWP5qmmbLjYQ+7iTCVIwy1ZI+e+rbFlxNHCNWPJA286BVa7QRAPbNpBs06Jd4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772830486; c=relaxed/simple;
	bh=qNo4S1+WkJwdqp+tYHVLUssHQKKKZZAhD4/FolFcVuY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iQ53yTf87rch3ptwOSl7tB5TyOHBNqL53eICF+pdH4jPgcQjYeqlbWz2jMx/GY2QyCmoZNO5prmfEp/te+SEqPcFqLUn853T8MPnzzOEsqeP0T6y6mqFrGrcz7azyFK5yU80FLrpkXHGtdSBwjgeZlgiYIC5FGKJAjhWFzJxajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=ypk9TpGt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="ypk9TpGt"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd75abd09dso35108085a.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 12:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772830484; x=1773435284; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYYb3MTgue6ruqAtTWWQIpjzRV2dEjMOcxssr5ef14s=;
        b=ypk9TpGtouo347x99Vz3NFcCpiQOuK7amijfgv6VUCLffw5N+SMACPkCA7pnro5g+2
         U8I7VNI7he3LAE59PrmJI3Y0yJtqxRVsZSoy0cdR6n3UYpiusUA+lA8xwzucEUkTRbSi
         Om90cuMF6EpJBQ+qDjwQj5RqgF4w/zu/yoecsyJpKBvbTbtUiJc30tP2Veiy+V9EL7JN
         4VvPqADoTBZ3d/cYOuxYNfahtDe4QUJZXaT3xQBb43+LhcTH9Tp7aeeikOrkVSQzm5gm
         0XYwxtyZ3Dn7DWMxXIxclWFNLT+geTAP6rT90ZUS1wHYBdjHWfY98ydCG3KzoCPNkIe+
         Mk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772830484; x=1773435284;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYYb3MTgue6ruqAtTWWQIpjzRV2dEjMOcxssr5ef14s=;
        b=Frwo5wSXFulRPtT7yti71EK5+OKlPImQUtTOy9FLWWtNc3Wsz4IpwiJ+MZi9zRlW+L
         cpYXQZXt1grWHhIjfuPG72NJmigh4dEAZcbn8w0+gyZQR5UqgcDW7qM1HCJflZ00GOQj
         +8UoPhHXN4zzJktjj1aWkWYOJurb2NrB0v20NL7qbCq0Pkbzv/5chfv/ao/mEd79sXbB
         6uZBuzYrk+mW6sftrd5Zez2npJteZseH6VoFxODyHf4jdan3IR44GxM1DNd6dW8vLJV/
         554Ks4OjIaqWAi4ZJPoKn5fh/AS852+4w9I7s3Zxm8KXUzfkGlv1khw2adhhpI8EZNXk
         lsvw==
X-Forwarded-Encrypted: i=1; AJvYcCXA5IZy3dNy0d74URrIPni5jE8MsEZfTQSk7u1e4aitczPodM5Dnb/InnWEVooguIe7B93yKNLUvic=@lists.linux.dev
X-Gm-Message-State: AOJu0YzWJ/aX2IySGxkMaAyRoIQFJteUUAJuNMQxrDKmGbPBdZ0KTuP3
	tIR21FMgF//Z8YMRjgB+aW3xJrbN2DOVucERWiDNEy9UmXZ1VcNdt9AoI6G4pkpTwJ5jYOR9X7I
	LxuJS
X-Gm-Gg: ATEYQzwvqvUR0lgjBJK/7nWaX4l4ZaMntrSq8hg3ocRPFil1I0TNpgjxqfwBXqXw0bb
	Z8albd66SP6KOVBi99ma8NftxaP0ReZ4e1Lvooa158+r0LOL3N1Z6Uc6AONrr5I/vAvmHBiRM+l
	3b3A4evgfcPVyWurcwsXwlj12vK6TjqCfPTxo8Ss9AonGXZYG27kjRzlOKuBPZlScabvxN1WIa/
	WFrqNU6yiWXg8sZwu0QXK+yCW+1MBG5DHTgLgIe2llN4yWSJi7nDEpbdfriEjjLezbgw3B76+w+
	IrIPCgtdkkKId0VaHS0PeMexU4NS58NQAyQUH2JyvWs5Uq2tazUZZ4gmP8pf07EuLRNU77G/0U2
	r4TOFn7w/WuLsYXR1dRYY+I1DqbjFA1Cz1mixpSkEtDPzJX29J6Ipv+QMcXKo0FYGmgLNf1yvIf
	gadJ5RNSCoN0x0VkN66PAOYe5CJ1kSvxGxBQ==
X-Received: by 2002:a05:620a:2587:b0:8b5:5a33:22d2 with SMTP id af79cd13be357-8cd6d4b5a1bmr462953385a.46.1772830484213;
        Fri, 06 Mar 2026 12:54:44 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f566fd5sm188141285a.43.2026.03.06.12.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 12:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 15:54:42 -0500
Message-Id: <DGVZYGBK0H4B.1PT84O0TAQ13L@etsalapatis.com>
Cc: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>
Subject: Re: [PATCH 03/15] sched_ext: Factor out pnode allocation and
 deallocation into helpers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
 <sched-ext@lists.linux.dev>
X-Mailer: aerc 0.20.1
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-4-tj@kernel.org>
In-Reply-To: <20260306190623.1076074-4-tj@kernel.org>

On Fri Mar 6, 2026 at 2:06 PM EST, Tejun Heo wrote:
> Extract pnode allocation and deallocation logic into alloc_pnode() and
> free_pnode() helpers. This simplifies scx_alloc_and_add_sched() and prepa=
res
> for adding more per-node initialization and cleanup in subsequent patches=
.
>
> No functional changes.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/sched/ext.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9232abea4f22..c36d399bca3e 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4114,6 +4114,7 @@ static const struct attribute_group scx_global_attr=
_group =3D {
>  	.attrs =3D scx_global_attrs,
>  };
> =20
> +static void free_pnode(struct scx_sched_pnode *pnode);
>  static void free_exit_info(struct scx_exit_info *ei);
> =20
>  static void scx_sched_free_rcu_work(struct work_struct *work)
> @@ -4148,7 +4149,7 @@ static void scx_sched_free_rcu_work(struct work_str=
uct *work)
>  	free_percpu(sch->pcpu);
> =20
>  	for_each_node_state(node, N_POSSIBLE)
> -		kfree(sch->pnode[node]);
> +		free_pnode(sch->pnode[node]);
>  	kfree(sch->pnode);
> =20
>  	rhashtable_walk_enter(&sch->dsq_hash, &rht_iter);
> @@ -5685,6 +5686,24 @@ static int alloc_kick_syncs(void)
>  	return 0;
>  }
> =20
> +static void free_pnode(struct scx_sched_pnode *pnode)
> +{
> +	kfree(pnode);
> +}
> +
> +static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int no=
de)
> +{
> +	struct scx_sched_pnode *pnode;
> +
> +	pnode =3D kzalloc_node(sizeof(*pnode), GFP_KERNEL, node);
> +	if (!pnode)
> +		return NULL;
> +
> +	init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch);
> +
> +	return pnode;
> +}
> +
>  static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *o=
ps,
>  						 struct cgroup *cgrp,
>  						 struct scx_sched *parent)
> @@ -5714,16 +5733,11 @@ static struct scx_sched *scx_alloc_and_add_sched(=
struct sched_ext_ops *ops,
>  	}
> =20
>  	for_each_node_state(node, N_POSSIBLE) {
> -		struct scx_sched_pnode *pnode;
> -
> -		pnode =3D kzalloc_node(sizeof(*pnode), GFP_KERNEL, node);
> -		if (!pnode) {
> +		sch->pnode[node] =3D alloc_pnode(sch, node);
> +		if (!sch->pnode[node]) {
>  			ret =3D -ENOMEM;
>  			goto err_free_pnode;
>  		}
> -
> -		init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch);
> -		sch->pnode[node] =3D pnode;
>  	}
> =20
>  	sch->dsp_max_batch =3D ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH=
;
> @@ -5821,7 +5835,7 @@ static struct scx_sched *scx_alloc_and_add_sched(st=
ruct sched_ext_ops *ops,
>  	free_percpu(sch->pcpu);
>  err_free_pnode:
>  	for_each_node_state(node, N_POSSIBLE)
> -		kfree(sch->pnode[node]);
> +		free_pnode(sch->pnode[node]);
>  	kfree(sch->pnode);
>  err_free_hash:
>  	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);

