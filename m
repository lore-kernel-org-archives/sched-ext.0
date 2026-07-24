Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5652E2E738D
	for <sched-ext@lists.linux.dev>; Fri, 24 Jul 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917858; cv=none; b=VX/93gNfiPtMHZCFTeb6LL7fmE3i/SIhEmZG6conb8X8/GDkwj0JBkt5aSt7hGvN1ozbriavX+1sh1pq1JjD6E216XpHWspbarceUeiowlh/8lUA2rOFVIgBol8PvDYlkVUB/H3xlWK/fyPXRv8Iz00qeMU6xxzEjjQBX+yP274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917858; c=relaxed/simple;
	bh=4si0GvI8/7zULtB6bLDcO1TgcxLag8dFmTjJXsKLPN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OPtIJbQ/paqyusZXBLuWE1jVAceAIDMLYcEbDSa0eHJ5X4vH2Vgs9qNDENongVE4piUtm9vuUyLIWHs4a9CkAqm/pDOgbkaib7BW3ZY0gVwuD0az0MCizqqKzO2tmmVSLnqFliwOAymuvg7u9BUSUoGpG5kOMFfW0sdcZtWgEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf3y5h+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf3y5h+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DC41F000E9;
	Fri, 24 Jul 2026 18:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784917857;
	bh=7NZoC6ZKwyqGSFadeqHN/l+l4c6fIB/fS7tdVbsoxlQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hf3y5h+7e/bZ0Vr35oZQjryIrt8yiw2OOj0O2oQhd6OCmdBJyLl6f7kAYFEJt2Fdc
	 E8SLp/QRHrxfAe0B2iPJgn+c0epTFTy+HLVY5jpYxl1lOJrcJVVC0LRq2ZpFWpqHQH
	 wFfrtuS5jAITmF9i3AP22zrLLeJsdJAIF5Yb1KcvX1CTfhU/KTIsvlMhkU7qyENelY
	 HL+jy+jUNrXZB6BnEAUewscI7WMXGzQ79BvtqbY5i5ysgcRPp8KiIcKkEJnUur4t+f
	 8ATBnvgj6+x1bCxNO1+7lOMAs56QzE8klUyR6FrSeksPAAroI6Mu3YxC9t5fKBuYIm
	 bJLmIxYo00J/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] sched_ext: Factor out scx_cpuperf_set()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260724182125.985061-5-tj@kernel.org>
References: <20260724182125.985061-1-tj@kernel.org>
 <20260724182125.985061-5-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:30:56 +0000
Message-Id: <20260724183056.C9DC41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Kernel-doc comment disconnected from its intended function.
--

--- Patch [4]: [PATCH 4/5] sched_ext: Factor out scx_cpuperf_set() ---
commit b27126d56fa54ad2d995a8ef1399b04f6ce7c044
Author: Tejun Heo <tj@kernel.org>

sched_ext: Factor out scx_cpuperf_set()

This commit factors out the CPU performance target write from
scx_bpf_cpuperf_set() into a new internal scx_cpuperf_set() helper. It also
flattens the nested validation into early returns to prepare for future
changes.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index d78b28d39d46c..00fe8490050df 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -9793,49 +9793,60 @@ __bpf_kfunc u32 scx_bpf_cidperf_cur(s32 cid, cons=
t struct bpf_prog_aux *aux)
>   * use. Consult hardware and cpufreq documentation for more information.=
 The
>   * current performance level can be monitored using scx_bpf_cpuperf_cur(=
).
>   */
> -__bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf=
_prog_aux *aux)
> +static s32 scx_cpuperf_set(struct scx_sched *sch, s32 cpu, u32 perf)

[Severity: Low]
Does this disconnect the kernel-doc comment from its intended function?

By placing the new static helper scx_cpuperf_set() directly under the
kernel-doc block for scx_bpf_cpuperf_set(), kernel-doc will parse this as
the documentation for the helper instead of the kfunc.

This will trigger kernel-doc warnings during documentation builds about
mismatched function names and arguments (such as missing @sch and @aux),
and leaves the public kfunc scx_bpf_cpuperf_set() undocumented in the
generated kernel documentation.

>  {
> -	struct scx_sched *sch;
> -
> -	guard(rcu)();
> -
> -	sch =3D scx_prog_sched(aux);
> -	if (unlikely(!sch))
> -		return;

[ ... ]

> +	if (!locked_rq)
> +		rq_unlock_irqrestore(rq, &rf);
> +
> +	return 0;
> +}
> +
> +__bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf=
_prog_aux *aux)
> +{
> +	struct scx_sched *sch;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724182125.9850=
61-1-tj@kernel.org?part=3D4
