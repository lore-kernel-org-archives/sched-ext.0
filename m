Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F23F7885
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547060; cv=none; b=SRLfL+v/Y+oCjJsyzT/1cTnfK3eXyCotEPEctmMIODnavJtLiuLETxU/lqzfXkIf7bC1TnA7M0VHbnDqdpF2HC7qNy9PpBpyywN4jzlUd5dtoiBnLXSQQtCpLTJ2Ym15h+qvC1fusTE+KfDnWbPy2QVbaXAYtU3ZeRq/IzxTxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547060; c=relaxed/simple;
	bh=PWkZ8ZkUYPVVJjjKKVBfbO0WGZRQqM68olfKP53xmN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ENhjgPPsSgLSu9zDw5s2rIn6kJIjmGhCP+3rtH66X4G5s4Sp9xZBDEUBMxhKCcYmThj+7D7KRdvGwZEiWAwNuhuSp8RiQKCzQR3AIct4Yn4cpFdgjH/lnm+YOOGkCJ2Da3TQbTUehrylvqdn3LFG883Of0/tk3+/nOgXYDfp4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnu0LkGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnu0LkGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D441F000E9;
	Wed,  8 Jul 2026 21:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783547059;
	bh=BvjpuZSKQxcBBcDJVi8YauhDaBAk+R2pYthqYlimx50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dnu0LkGTbQ0UBq95SCsFoozbBiuVsZ3cslSLHBORWXNa4xIzVUU1ttKIAbQKNogE+
	 q/IlLJSpJRf2IRZYM52t5KTMN916zX1skjylsJtKstUQ33jdJQuGRKS91LZwtK/B/6
	 OyINfW/DZaeVARceT7aeMQTVOgiue5csnVxx423EzQJFDHDhafv54xEJvcQjmcnYn7
	 D0ukBozunC5poAgD7SsyhPDVXELggloybUKUpDaeNDbOTMsV8rrR+bK0njklrVq/rA
	 WqznkfS5COGn2PQuMeo0anRapI8bDoL4yU/nn1YZHfmw4ArRdTLm7erXtywnniKTAp
	 vvT4LuVKcBv/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 15/40] sched_ext: Add per-shard
 scx_sched storage scaffolding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-16-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-16-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 21:44:18 +0000
Message-Id: <20260708214419.34D441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing scx_alloc_pshards() call for sub-schedulers in scx_sub_e=
nable_workfn(), breaking shard scaffolding.
--

--- Patch [15]: [PATCH v4 sched_ext/for-7.3 15/40] sched_ext: Add per-shard=
 scx_sched storage scaffolding ---
commit 3777e1c0aa64eae381accea1de5bddc71fe6cf2d
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add per-shard scx_sched storage scaffolding

This commit adds the scx_pshard structure and sch->pshard[] array indexed b=
y shard_idx, allocating each entry on its shard's NUMA node. The allocation=
 is intended for cid-type schedulers with an arena pool, serving as scaffol=
ding for upcoming shard-local state.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 1a8d62efb5c52..6892928b0acbe 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -6724,6 +6726,12 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
>  		goto err_disable;
>  	}
> =20
> +	ret =3D scx_alloc_pshards(sch);
> +	if (ret) {
> +		cpus_read_unlock();
> +		goto err_disable;
> +	}
> +

[Severity: Medium]
Is it intentional that scx_alloc_pshards() is called here for the root
scheduler, but omitted in scx_sub_enable_workfn() for sub-schedulers?

The commit message notes: "Only cid-type schedulers with an arena pool get
pshards." Sub-schedulers are cid-form and initialize an arena pool in
scx_sub_enable_workfn(), but appear to be missing the allocation call:

kernel/sched/ext/sub.c:scx_sub_enable_workfn() {
    ...
	ret =3D scx_arena_pool_init(sch);
	if (ret)
		goto err_disable;

	ret =3D scx_set_cmask_scratch_alloc(sch);
	if (ret)
		goto err_disable;

	if (scx_validate_ops(sch, ops))
		goto err_disable;
    ...
}

Could this cause sub-schedulers to fail to allocate the pshard array, leavi=
ng
sch->pshard as NULL and leading to crashes in follow-up patches that rely on
this scaffolding?

>  	if (sch->ops.init) {
>  		ret =3D SCX_CALL_OP_RET(sch, init, NULL);
>  		if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D15
