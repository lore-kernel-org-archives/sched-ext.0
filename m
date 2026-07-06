Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486053A1C9
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302808; cv=none; b=ibBNMHOfHojGpi3yZG245qlBs933lzhO5kTgT1fCXHpd1CYWvPQqs09amb9W20BwdmtyupGvzlhg4zi9WhqtpSPDP17WgGfPdwUwtY8WmlktpeaTPdCcYIpiIrQ8a71jA6T2iP4CNVkDuldyBRPpkRlM7xW8pcDmleE0qD36dpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302808; c=relaxed/simple;
	bh=7Jm2kcMsgLO4d987T3Co86JS+qqY8DHSjHMD9M1P9jM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EyPIxtO5owDgl9mnvWb55VhqYWjlqWBZ5YIcH0g4jv7Zr/yrWpI0t/XiufROmWNAknv2J+Xdop8zYQ5fy93DlAO6s/JNQULxRF5AFjwEK6Dy9loGXlTVlnQkPpk/8rG7BuCBFb2Akc9sfJ4Bstt9jlJoAxJi6nweRt8solVHfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsdmn9ky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsdmn9ky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61741F000E9;
	Mon,  6 Jul 2026 01:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302806;
	bh=9Afj1XrAEUoAdK/PSd6oX5f5zJwB9qod5PYUOHGxgfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jsdmn9kyqyjG/REDM3RZ0xpG5xUnqbn/yeQRVDfB5WmJlIIJHp3xBModxhtYBOYaC
	 Wd43asm4HHUjEZBaDVHIToASywHS9rxgiQ19rjXoPmmFwraIjj+NbAfMYKu+yTYIRa
	 wb0LwJixLN2TrE3b5WIj830MadmPg+mBPLVxrPHc+tDfxYTURhd/0Hi+vEFiSkvt0O
	 ZLdVL3px+zt3gRbKOaVjv4D5X1/7TkIbPJWagLF72pwkhuwMHNX+5nAviO+wrl1fSv
	 aR/ONIw/fmnNXS3+JQUVGuLC56JBAN1AdFmgOFsOW6G6YfjyXXxKqEEQWPHg4lpgbB
	 ARhGkFCelXkMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 11/36] sched_ext: Add CID sharding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-12-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-12-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 01:53:26 +0000
Message-Id: <20260706015326.C61741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] When primary threads are offline, `calc_shard_layout` undercount=
s the number of unique cores in the LLC, leading to excessive shard fragmen=
tation.
--

commit dc6e5b38d1262d839593a2f89619eff217ae8a4f
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add CID sharding

This commit introduces CID sharding to partition the CID space into
topology-respecting domains for scalable sub-scheduler operations. Each
shard is a contiguous CID range within a last level cache, capped at a
configured size, with cores distributed evenly across them.

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index b0ec4d76f8552..f3c54f4223b43 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c

[ ... ]

> +static void calc_shard_layout(const struct cpumask *llc_cpus, u32 shard_=
size,
> +			      u32 *cores_per_shard_p, u32 *nr_large_p)
> +{
> +	u32 nr_cores =3D 0, nr_cpus =3D 0, nr_shards;
> +	int cpu;
> +
> +	for_each_cpu(cpu, llc_cpus) {
> +		nr_cpus++;
> +		if (cpumask_first(topology_sibling_cpumask(cpu)) =3D=3D cpu)
> +			nr_cores++;

[Severity: Medium]
Does this loop undercount nr_cores if the primary SMT threads are offline?

If cpumask_first(topology_sibling_cpumask(cpu)) returns an offline primary
thread, it will not match the current online cpu being evaluated in llc_cpu=
s.

This can result in nr_cores evaluating to 0, which would then cause
*cores_per_shard_p to be 0. Later in scx_cid_init(), this would force every
core into a separate shard, creating excessive shard fragmentation.

> +	}
> +
> +	nr_shards =3D max_t(u32, 1, DIV_ROUND_UP(nr_cpus, shard_size));
> +	nr_shards =3D max_t(u32, nr_shards,
> +			  DIV_ROUND_UP(nr_cpus, SCX_CID_SHARD_MAX_CPUS));
> +
> +	*cores_per_shard_p =3D nr_cores / nr_shards;
> +	*nr_large_p =3D nr_cores % nr_shards;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D11
