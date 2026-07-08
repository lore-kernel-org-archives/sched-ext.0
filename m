Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6630D41D
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548058; cv=none; b=RyHlrhNrRxK4wDimMfotSNwMKycOZQPdu3EQDQH4nAYoOIBoj22WdSqzjIhUu4kfwNVBMDQBmPvCvdT7SNqRs6NShjsdBAv/3X1fDhSYUS2rpe79YiiSg1bO2hkwSsgIHan1bW/GwQboQnWROLoaabQhF64EfdNAYEAdFFzcpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548058; c=relaxed/simple;
	bh=026KcZ24AeP8Ko8hJD6Sz2dtKlla5eFbC7y6qJ1Vsy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fne89ciZD1+kCGKAo3zi1y/1HbY+/LDK50O4tK5Ww/PwXWBS1kmgaLGzyhFJ2idOjXsMKwfinC4rJjQjI0SnQgj0UlbJYlqZuhWboUVq1uB2Vd+jlcM+4YSKcgBM+sAO8SvE2LHlkvN5qVQ9uhRDwrKZz3/Wyd9BZT8bEFB19NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek0HqvdC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek0HqvdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F581F000E9;
	Wed,  8 Jul 2026 22:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783548057;
	bh=oxqtKg8ZR8w3n3xXB3aPWI+iatvlg7jTpUvvZBoa7SE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ek0HqvdCXUYk7mlhh3Mph1SaKeON+CT8g0xw/f8g6IB4mz2ccYURPBHnOjUqyMWft
	 hJB06FGuPrfSXdADqogmB4HZxTqF87VuacIgcbwpK9uUMQVCLzmakXJWJb4P9S70Ne
	 0aCKNTYdwAEyWnUdj/Tm4J+SFDIzr7ZehRNsVpdKFruCDkzoFg6hb0cZGZ8vid7fer
	 f9lL1myO4TMQvcN2Ek5X4AXMAHPIH9ktobzZO0TczTqse6EZrrq5u5/hBm3ZHRib1V
	 KC9crDpUuvRu7v3MGUP3QwzOX1LxiaQAxB7COp5HX7vqvoOhEZtNa1ej2SqzHbXuAc
	 FJBkl848EMDSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 21/40] sched_ext: Add per-shard cap
 delegation for sub-schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-22-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-22-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:00:56 +0000
Message-Id: <20260708220057.20F581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing validation for unallocated `pshard` arrays and missing are=
na maps in `scx_bpf_sub_grant()`, `scx_bpf_sub_revoke()`, and `scx_bpf_sub_=
caps()` leads to NULL pointer dereferences and invalid memory access Oops.
--

--- Patch [21]: [PATCH v4 sched_ext/for-7.3 21/40] sched_ext: Add per-shard=
 cap delegation for sub-schedulers ---
commit 809108a1ad8d6e1bc475090c3e5ff6fba86f6bad
Author: Tejun Heo <tj@kernel.org>
sched_ext: Add per-shard cap delegation for sub-schedulers

Caps are per-cid permissions parents delegate to direct children via
scx_bpf_sub_grant() / scx_bpf_sub_revoke(). A child's cap set is always a
subset of its parent's. Sub-scheds check their caps locally, and cross-sched
communication is needed only when the delegation set itself changes.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 8d98250936497..d0ffc3a8550cf 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
[ ... ]
> @@ -760,6 +808,284 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id=
, const struct bpf_prog_aux *
>  				  true);
>  }
> =20
> +/* Validate common inputs. On success, *parent_out and *child_out are se=
t. */
> +static s32 sub_cap_preamble(u64 cgroup_id, u64 caps, const struct bpf_pr=
og_aux *aux,
> +			    struct scx_sched **parent_out, struct scx_sched **child_out)
> +{
[ ... ]
> +	*parent_out =3D parent;
> +	*child_out =3D child;
> +	return 0;
> +}
> +
> +/**
> + * scx_bpf_sub_grant - Grant @caps on @cmask__ign's cids to a direct chi=
ld
[ ... ]
> +__bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
> +				  const struct scx_cmask *cmask__ign,
> +				  struct scx_cmask *denied_out__ign,
> +				  const struct bpf_prog_aux *aux)
> +{
[ ... ]
> +	/* apply the grant one shard at a time */
> +	for (si =3D ref.shard_first; si < ref.shard_end; si++) {
> +		SCX_CMASK_DEFINE_SHARD(slice, 0, SCX_CID_SHARD_MAX_CPUS);
> +		struct scx_pshard *pps =3D parent->pshard[si];
> +		struct scx_pshard *cps =3D child->pshard[si];

[Severity: High]
Does this code dereference a NULL pointer if the child scheduler was created
without a BPF arena?

If the child scheduler has no arena pool, scx_alloc_pshards() skips allocat=
ing
the pshard array and leaves it as NULL. When scx_bpf_sub_grant() accesses
child->pshard[si], it would attempt to dereference that NULL pointer.

> +		u32 cap_bit;
> +
> +		scx_cmask_ref_shard(&ref, si, slice);
> +		if (scx_cmask_empty(slice))
> +			continue;
[ ... ]
> +__bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
> +				    const struct scx_cmask *cmask__ign,
> +				    const struct bpf_prog_aux *aux)
> +{
[ ... ]
> +		guard(raw_spinlock)(&parent->pshard[si]->lock);
> +		pos =3D scx_next_descendant_pre(NULL, child);
> +		while (pos) {
> +			struct scx_pshard *ps =3D pos->pshard[si];

[Severity: High]
Can pos->pshard be NULL here if one of the descendant schedulers was created
without an arena map?

If a descendant scheduler lacks an arena, pos->pshard is NULL, leading to a
NULL pointer dereference when accessing pos->pshard[si].

> +			u64 revoked_caps =3D 0;
> +			u32 cap_bit;
> +
> +			scoped_guard (raw_spinlock_nested, &ps->lock) {
> +				scx_for_each_cap_bit(cap_bit, caps) {
[ ... ]
> +__bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cma=
sk *out__ign,
> +				 const struct bpf_prog_aux *aux)
> +{
[ ... ]
> +	pshard =3D READ_ONCE(target->pshard);
> +	if (unlikely(!pshard)) {
> +		scx_error(sch, "scx_bpf_sub_caps() called before caps storage is initi=
alized");
> +		return -ENODEV;
> +	}
> +
> +	ret =3D scx_cmask_ref_init(sch, out__ign, &ref);

[Severity: High]
Can this lead to an invalid memory access oops if the calling scheduler (sc=
h)
has no arena?

If sch does not have an arena map, its arena_kern_base is 0.=20
scx_cmask_ref_init() uses this base when resolving the out__ign arena point=
er,
resulting in a read from a user-space address and causing a kernel page fau=
lt.

> +	if (ret) {
> +		scx_error(sch, "invalid out (%d)", ret);
> +		return ret;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D21
