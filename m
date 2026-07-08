Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679D3F8246
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547260; cv=none; b=ECduNQ6essgVSGFWsc+Hv0TflQQhdyfPEP2hd/4E7K57RJlKQTXPB0jGJb/B5lWDwHBwvHEZOWzMTA4GUYxjY1j9onLfTYYbFtbhz/UJMJgc3gxCygJWpkVSlSXG3QNuwdFMLIQjV3aExnpA68j7FuXuBNP3KziojxmDyzU+2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547260; c=relaxed/simple;
	bh=aWw4ipcM/pl9U7mCOTBTEQywFMFOHiSmAXoorI0LHP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DlY6gDHgKKxYg38Pi7aVfkwFu4iGFcJCe1tvdq20Hh3q0HA6fapPFaFgipEhW6c8ft+aiyl8gQ2WtqnjbhEmbGmfq7MBnJJ9/eji1rVvFTKWwkCNjiaH/ytWlZpWZigvzBsRuDkDXnBNrW+geAOmPCZdQyXW3Hpr6Ytp0X/n3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqdbC2Eb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqdbC2Eb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1811F000E9;
	Wed,  8 Jul 2026 21:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783547258;
	bh=z/8cdW+XoyzQ2Tvwk5NsF53J8AbVKJDfek4VFPCVOzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HqdbC2Eb2E3O8bM67jeeXqkFEHZQRC/KXgPxNW8Pnm98oARdgt5UhVKDOTGuweh+A
	 3+rHo74KlYXqsjq+38/Jw6P0aqBqqZ4Dh5XS3lUHtgUAEyHH7px6Icb6F3KTZSkKcy
	 UOqceq3nGtAvrMMXD/PyxIfJJSdYyOQj89KEb9k/Dj9pXyo8RR6hsYGYBwrO3H05Nb
	 gg1oor71AroWeGSW9Rj5DdIwKFuR3tnnWpLyXZSRNuUCWA2dCECQDSjEcbN3Q4l51H
	 3bkdPU3SuGZXnzHkTXk85bUlmzKtZmZxf5bR9wV4KebCS3+L/8yz8ehEGurpmJAcni
	 uKpwf++EooYSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 13/40] sched_ext: Add shard
 boundaries to scx_bpf_cid_override()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-14-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-14-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 21:47:38 +0000
Message-Id: <20260708214738.7A1811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unbounded allocation sizes for kmemdup before validation trigger=
 kernel warnings and allocation failures.
--

--- Patch [13]: [PATCH v4 sched_ext/for-7.3 13/40] sched_ext: Add shard bou=
ndaries to scx_bpf_cid_override() ---
commit d662162dc44b1de0465d793b6ec2418996af7aef
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add shard boundaries to scx_bpf_cid_override()

This commit extends scx_bpf_cid_override() to accept explicit shard boundar=
ies.
It also snapshots the caller's arrays before validating them to prevent
concurrent mutations from altering the data between validation and use.

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index f3c54f4223b43..6a22bead4c601 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
[ ... ]
> @@ -392,29 +392,66 @@ void scx_cpumask_to_cmask(const struct cpumask *src=
, struct scx_cmask *dst)
[ ... ]
>  	/*
> -	/* GFP_KERNEL alloc must happen before the rcu read section */
> +	 * GFP_KERNEL allocs must happen before the rcu read section. Snapshot
> +	 * the BPF-supplied arrays so a concurrent map mutation can't change
> +	 * them between validation and use.
> +	 */
>  	alloced =3D zalloc_cpumask_var(&seen, GFP_KERNEL);
> +	node_counts =3D kcalloc(nr_node_ids, sizeof(*node_counts), GFP_KERNEL);
> +	cpu_to_cid =3D kmemdup(cpu_to_cid_src, cpu_to_cid_src__sz, GFP_KERNEL);
> +	shard_start =3D kmemdup(shard_start_src, shard_start_src__sz, GFP_KERNE=
L);

[Severity: Medium]
Can a BPF program trigger a page allocator warning here by passing an
unbounded size for cpu_to_cid_src__sz or shard_start_src__sz?

The sizes are passed directly to kmemdup() before the length validation che=
cks
occur below. Would it be safer to validate the expected array sizes before
attempting to allocate memory for the snapshots?

> =20
>  	guard(rcu)();
> =20
> @@ -422,17 +459,57 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cp=
u_to_cid, u32 cpu_to_cid__sz,
>  	if (unlikely(!sch))
>  		return;
> =20
> -	if (!alloced) {
> -		scx_error(sch, "scx_bpf_cid_override: failed to allocate cpumask");
> +	if (!alloced || !node_counts || !cpu_to_cid || !shard_start) {
> +		scx_error(sch, "scx_bpf_cid_override: allocation failed");
>  		return;
>  	}
> =20
> -	if (cpu_to_cid__sz !=3D nr_cpu_ids * sizeof(s32)) {
> -		scx_error(sch, "scx_bpf_cid_override: expected %zu bytes, got %u",
> -			  nr_cpu_ids * sizeof(s32), cpu_to_cid__sz);
> +	if (cpu_to_cid_src__sz !=3D nr_cpu_ids * sizeof(s32)) {
> +		scx_error(sch, "scx_bpf_cid_override: cpu_to_cid expected %zu bytes, g=
ot %u",
> +			  nr_cpu_ids * sizeof(s32), cpu_to_cid_src__sz);
> +		return;
> +	}
> +
> +	if (!shard_start_src__sz || shard_start_src__sz % sizeof(s32)) {
> +		scx_error(sch, "scx_bpf_cid_override: invalid shard_start size %u",
> +			  shard_start_src__sz);
> +		return;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D13
