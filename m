Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49CD33A005
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077468; cv=none; b=rItYJW5dt0gKVcymFF1f1bDyWx/Y/jsmrLuI5AbrTuvm+89Ts6triUAyAvMqu6woykwGxfB6PCK7CExxtV2Lqx1qpe0xu0fSBOksdMlD7DqzZROY+PIH+2ZK1byi6BBnDNG67o2GgHJAqiVZFknyZjdFmJt0wZK/e5B5sPd+82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077468; c=relaxed/simple;
	bh=DVN4EoudpfegSdSvqgRh2Igk5BqBQMqIs+V7IcKPbkQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BkUdKYOsaO2Dmsub+vb8WpRFwDn4Dg5WWGmY5Vdm7G4xtAUuYFeMwGC8jOUfROlqYGlUeYmCmKzsSqRbG/oWA5ARFuKDcDJ6M8kPUpOhd5SNJ8POWl/w8/L4YR08eGY6gAoeXy2JP/QhB7xkqpmjFWBB8xsGrhm+9/db3ipK9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz0c3XRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz0c3XRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F07A1F000E9;
	Fri,  3 Jul 2026 11:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783077466;
	bh=qSIGBmNy0rJhheTxfOsxldAy59x6iQZF3JUO3Z6BzWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hz0c3XRqCXnu3VCFnkpFxBuCF+qd3Bffmw3Cn4ajSJVvLcX0+9lg5KOIQ2sSP5/Yh
	 d+30+0VF0EGDGb+lns65ku+LoptAA+WwyRDbTOetL4v0Ef9tQxcUn+ft2LSppQS4MT
	 NcpeGt4D+AajERxxe3TrN4pp694EgsX56NwD2XLuyrUv/ehufTWWm5kteTcQ6GZ4Ff
	 aaXgHSTJb/COCc0o3R1mHbfA/0fZh5treM4Fso9w+D0nFYk5YJ5qrRoaw0AJ+79R76
	 0vPRN7hN2cImtLMrDPFWSUVe+axSdd7t8Qi5Ug3/cVdyls6C+zFFopTvnKbHt9qka5
	 UQ6tblKXKNGcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 16/32] sched_ext: Add per-shard cap
 delegation for sub-schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-17-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-17-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 11:17:45 +0000
Message-Id: <20260703111746.4F07A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Partial allocation failure in `scx_alloc_pshards()` leaves the `ps=
hard` array exposed, causing a NULL pointer dereference if the BPF `ops.exi=
t` hook reads its own caps.
--

commit 80fa600c75235b9a81ec7604c35ea00c8688f882
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add per-shard cap delegation for sub-schedulers

This patch introduces per-shard capability delegation for sub-schedulers in
sched_ext. It adds the framework and locking around shards.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 1e84f46201767..e7259623fa3c1 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
[ ... ]
> @@ -733,6 +782,281 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id=
, const struct bpf_prog_aux *
>  				  true);
>  }
> =20
[ ... ]
> +/**
> + * scx_bpf_sub_caps - Read self's or a direct child's cap cmasks
> + * @cgroup_id: 0 for self, or a direct child's cgroup id
> + * @caps: one or more SCX_CAP_* bits
> + * @out__ign: arena cmask to receive the union of @caps within its range
> + * @aux: implicit BPF argument
> + *
> + * Read the cap cmasks granted on each cid for self (@cgroup_id 0) or a =
direct
> + * child - the literal granted set. A sched can read only itself or a di=
rect
> + * child.
> + *
> + * Return 0, -ENODEV if @cgroup_id names no direct child, or -EINVAL on =
bad
> + * inputs.
> + */
> +__bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cma=
sk *out__ign,
> +				 const struct bpf_prog_aux *aux)
> +{
[ ... ]
> +	/*
> +	 * The target's caps storage may not be set up yet (e.g. a self-read
> +	 * during ops.init_cids()).
> +	 */
> +	if (unlikely(!target->pshard)) {
> +		scx_error(sch, "scx_bpf_sub_caps() called before caps storage is initi=
alized");
> +		return -ENODEV;
> +	}
> +
> +	ret =3D scx_cmask_ref_init(sch, out__ign, &ref);
> +	if (ret) {
> +		scx_error(sch, "invalid out (%d)", ret);
> +		return ret;
> +	}
> +
> +	for (si =3D ref.shard_first; si < ref.shard_end; si++) {
> +		const struct scx_cid_shard *shard =3D &scx_cid_shard_ranges[si];
> +		SCX_CMASK_DEFINE_SHARD(local_out, shard->base_cid, shard->nr_cids);
> +		u32 cap_bit;
> +
> +		scx_for_each_cap_bit(cap_bit, caps)
> +			scx_cmask_or(local_out, &target->pshard[si]->caps[cap_bit].cmask);

[Severity: High]
If alloc_pshard() fails inside scx_alloc_pshards(), will this leave
sch->pshard populated with some NULL elements?

kernel/sched/ext/sub.c:scx_alloc_pshards() {
...
	sch->pshard =3D kzalloc_objs(sch->pshard[0], scx_nr_cid_shards, GFP_KERNEL=
);
	if (!sch->pshard)
		return -ENOMEM;

	sch->nr_pshards =3D scx_nr_cid_shards;

	for (si =3D 0; si < scx_nr_cid_shards; si++) {
		sch->pshard[si] =3D alloc_pshard(sch, si, scx_shard_node[si]);
		if (!sch->pshard[si])
			return -ENOMEM;
	}
...
}

If this returns -ENOMEM, the err_disable path in scx_sub_enable_workfn() is
triggered, which eventually calls the scheduler's BPF ops.exit() hook.

If the BPF program then calls scx_bpf_sub_caps(0, ...) to read its own
capabilities, the earlier check for !target->pshard passes because the array
itself was successfully allocated.

Will this loop then unconditionally dereference target->pshard[si] and
trigger a NULL pointer dereference on the unallocated elements?

> +		scx_cmask_ref_copy(&ref, local_out);
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D16
