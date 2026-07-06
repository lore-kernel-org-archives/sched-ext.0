Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FA32C9D
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304004; cv=none; b=FHuxreRcMvOOl3oRYb6ASqbhxNWiZ8x9vSrS1YkLlTVLo5YEZ1PYI+H6InffptGD/tA4I69zQ0fn0C/KCqjNZVtLqykq/vArjCNxasTFR34OExvyFdzIvpor7Q8R9vd6qvYBH/EspGBdBHIDUB3rR8KXZS6dmrCfTWBOQEH56Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304004; c=relaxed/simple;
	bh=D1Ly1nv0m1sQyjYw5PhRajS1rS0MbZBhYfr928DaRuE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NSYd/KvohSyS9qKHl/fKCtzIeIh13stpmj3+vTeuKOfPyS6RNrJ02G4BBBncX2btSuWrnhLPYx+3TPzW3al96Q+S6PU4dcP/eNHcPjhgCcqz8eiS8pjDhgOLRS1/whi6teox8Z6Il4QHnOu6ydx6d+KH1otzztfWATxVY6nZ+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf28NphP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf28NphP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F731F000E9;
	Mon,  6 Jul 2026 02:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783304002;
	bh=OlLqIIKiIYog5OfJl3ekdUmMtfDh1kPiOMiIlWKbIz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uf28NphPnfqHb/UvLwwb4k0SSOYHyTJuQhcqCEeCQc01Tv4Tp5ivuj2D2v+IquQpw
	 mEr8leYqndOx7e2TZeNSmwB9u+gA3EJzcqe8jZrXbqdscrg1yKjE3zuzhLDLj4G9EO
	 Kw6SB/Ls1Phv8AtTEZP4P6mN5KGPCXW66XD27HKHmV0Ylm88lc4EnvmE/bxGLUtS2b
	 etaTh1spfc0Dsw6d5XMzNgfVz+0CnawlUNskQKycytDyJEHVeTaBXAbuqmSnW5hRbT
	 ykFZpoJoOiaRh8BOg5iASWREmwVNXUvmfqzktNj8QVwJh1VPEvq2y7NXaYC3sh8col
	 6krYnj/CMjImw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 19/36] sched_ext: Add per-shard cap
 delegation for sub-schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-20-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-20-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:13:20 +0000
Message-Id: <20260706021322.72F731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent BPF execution can trigger a NULL pointer dereference in=
 scx_bpf_sub_caps() during scheduler initialization.
--

commit 1c8e81a3938a3d80669e9d95ad976bab30a8473a
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add per-shard cap delegation for sub-schedulers

This commit adds a framework for sub-scheduler capability delegation with
per-shard locking. The enable path is reordered so pshards are allocated
before the scheduler becomes reachable, and several new BPF kfuncs are
introduced to manage and query capabilities.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index eb9056f21ce8a..36803b6df6318 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -737,6 +791,281 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id=
, const struct bpf_prog_aux *

[ ... ]

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
Can this lead to a NULL pointer dereference during scheduler initialization?

If a concurrent BPF syscall program calls scx_bpf_sub_caps() while
scx_alloc_pshards() is still executing, target->pshard could be non-NULL
but individual elements like target->pshard[si] might not be initialized ye=
t.

In scx_root_enable_workfn(), the scheduler can be published via
rcu_assign_pointer(scx_root, sch) before scx_alloc_pshards() finishes
allocating the individual shard elements.=20

The target->pshard array allocation would pass the check above, but=20
dereferencing target->pshard[si]->caps[cap_bit] here could crash if that
specific index is still NULL.

Could the scheduler publication be delayed until all pshard array elements
are fully populated, or should this iteration verify each array element?

> +		scx_cmask_ref_copy(&ref, local_out);
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D19
