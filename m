Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C93D3338
	for <sched-ext@lists.linux.dev>; Sun, 17 May 2026 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043848; cv=none; b=QlSUqmw79uBXbCVnL5vdA0kRkkS3VWUY01wympr7qcWHYFLOZ2iAvGpetlJPm5ckGwBsVP8wrn137ryVWQU5L9TWPOghSaP7W8fnZGTFL4FO/GQ895dVbSkTSY/nCyRPbHHAwF1RF+7hnWBmbJChBh8IijWXIgby/NJBFX3PNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043848; c=relaxed/simple;
	bh=puHnA/QhD7+8bRLrgonh2TvhXA2csqlmj1FnBLFdXZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u4VuwZvXgAX2bwoJHJ3SpR8pofIr30KTpBqPa1o0sAKoEPTCylt3fz67aWdq5GtQ2mM75bLbaHFvZaqF0Np7ngUDlmPYdUD9WjSp9suNSy8Qw0Rok+EDe9+n6Jy6GFcyB2Tl+aw8UN4iwW5ywYuChXCVcnROaYCqP+1SKdYVIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5YbpccK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5YbpccK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E5FC2BCB0;
	Sun, 17 May 2026 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779043846;
	bh=puHnA/QhD7+8bRLrgonh2TvhXA2csqlmj1FnBLFdXZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=V5YbpccKNslGcHn/DqM6Mn0PitURg5OsygMqHegiVPLREIUirejTi/JPe8SIXirOE
	 OXGv+FoOQsWu5nt4SohwidOUKGgwgFQxVN40c7FEed8lh9PvEQ12Vzypyjmrj5z18S
	 SAcvPGQzqHpK/fQwpkbJtd6AwRrzRSC4sOJCX4DRvztTNqDbEaSb+OX/Vnu3mh3W65
	 BrrJ4bmEClb5B0xxL+ZOWxw9ATLUcG5P8SKNXJGs3k4a9iBll7QqI7PM2KFhnryci6
	 rMNzTMGUv3XI0gKf1ernD4nh+1ucMztzkO/wlYCnWMGY5LiABr1s1svQ+4hJ9TyNuP
	 RGjMTh+RxuZxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Track bits[] storage size in struct
 scx_cmask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260517181022.1184056-3-tj@kernel.org>
References: <20260517181022.1184056-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 18:50:46 +0000
Message-Id: <20260517185046.D2E5FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The per-CPU `scx_set_cmask_scratch` variable is never initialized,=
 causing `scx_cpumask_to_cmask()` to silently pass empty CPU masks to the B=
PF scheduler.
--

commit c63d115e3f87dfb00acdde042926edb85a5907eb
Author: Tejun Heo <tj@kernel.org>

sched_ext: Track bits[] storage size in struct scx_cmask

This commit adds an alloc_words field to struct scx_cmask to track the
allocation size of the bits[] array, and splits the bit-range API into=20
initialization, reframing, and clearing helpers.

> diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
> index bdd8ef8eae3dc..f50319c5c65e1 100644
> --- a/kernel/sched/ext_cid.c
> +++ b/kernel/sched/ext_cid.c

[ ... ]

> @@ -275,10 +275,10 @@ void scx_cpumask_to_cmask(const struct cpumask *src=
, struct scx_cmask *dst)
>  {
>  	s32 cpu;
> =20
> -	scx_cmask_init(dst, 0, num_possible_cpus());
> +	scx_cmask_clear(dst);

Can this regression cause scx_cpumask_to_cmask() to generate empty masks
when dst is scx_set_cmask_scratch?

Since scx_set_cmask_scratch is allocated zero-filled, its nr_cids defaults
to 0.

With scx_cmask_init() removed here, if scx_set_cmask_scratch is passed as
dst without being initialized elsewhere, scx_cmask_clear() will see
!dst->nr_cids and return immediately doing nothing.

The subsequent loop then calls __scx_cmask_set(dst, cid) for each CPU.
Because __scx_cmask_contains() evaluates to cid >=3D 0 && cid < 0, which is
always false, no bits are ever set.

Could this result in the BPF scheduler receiving an empty cmask for
operations like set_cpumask?

>  	for_each_cpu(cpu, src) {
>  		s32 cid =3D __scx_cpu_to_cid(cpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517181022.1184=
056-1-tj@kernel.org?part=3D2
