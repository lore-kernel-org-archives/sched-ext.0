Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF65319AD90
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384775; cv=none; b=PMBW/feqrwlH1Tr7GggbZHQFuipj6mpb+vl7LkG8IXOj66ccS4/ntsnoWf0OdL70vndJPQkgf2MWd0fEPGrcBPx3QlYp6xZEMzv+HTlPAvvHmPItJpmoXSS38qaKh9i4ar658OiPesOppU3RitF1npLA6mFjHZkZMQRn7Q02/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384775; c=relaxed/simple;
	bh=+XgPHu24K20uSijWthWOl2yDmZScYJQdNbtK6g80AMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=geI+vmUFwIOs+1RIr+BDePjxoG5qrMVxgJMlhbJykLXVjku6FweVePJa7UdGZ4sqdDvax33JtinVgUtecGaAPKXUcbZkdY3dp06HD7ffui183r292y+Lv53rqolZstKIyhS27lX7dLx5UlVIVfw76Y3Mqtze5bufKUqB3diynCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeVghhsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeVghhsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC381F000E9;
	Tue,  7 Jul 2026 00:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384774;
	bh=1yT6pRir2Q5TtDMzFEGYiwhkqlwTzb0cezG17kgpOE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eeVghhsEU7GKoJ6/ZDO7R+53HrJugckJQiYy4kXqnEmOlbkfncqDwqlVzbPISEQNd
	 Xp1hyC/o9O3wfmGuDMgs0/wf9p/gpQZH8/7AQXPineKrdZW9GAaegIlc7UI50Qo8Dz
	 aVcZ9bRbBHCReT2xRK0GmspHSQ0L9ZGNLz25ghGmhEBBb+NJKcCJkux26/XxzZw+rK
	 P0nNGlRGy/pxa84UDZCh4+x8Wonw+hBHoib6KkprO4Z9EdUdQFKXMpm+0F9ZOqZmLA
	 kMyUtYojQGnJnu9WOVSZ6Zoc8KG9bVUubL9OJ94veQLddbR46pe1x2aRhTO2NSShsd
	 pr4fhEHPUlJpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 19/36] sched_ext: Add per-shard cap
 delegation for sub-schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-20-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-20-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:39:33 +0000
Message-Id: <20260707003934.3FC381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing bounds check on the shard index `si` against `target->nr_p=
shards` in `scx_bpf_sub_caps()` leads to an out-of-bounds array access on t=
he `pshard` array.
--

--- Patch [19]: [PATCH v3 sched_ext/for-7.3 19/36] sched_ext: Add per-shard=
 cap delegation for sub-schedulers ---
commit 4ef150e106489066d9726027ae3dce353775a7d4
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add per-shard cap delegation for sub-schedulers

This commit introduces the framework for per-shard capability delegation
for sub-schedulers in sched_ext. It allows parents to grant or revoke
capabilities per-cid locally via scx_bpf_sub_grant() and related functions.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -737,6 +799,284 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id=
, const struct bpf_prog_aux *

[ ... ]

> +__bpf_kfunc s32 scx_bpf_sub_caps(u64 cgroup_id, u64 caps, struct scx_cma=
sk *out__ign,
> +				 const struct bpf_prog_aux *aux)
> +{

[ ... ]

> +	for (si =3D ref.shard_first; si < ref.shard_end; si++) {
> +		const struct scx_cid_shard *shard =3D &scx_cid_shard_ranges[si];
> +		SCX_CMASK_DEFINE_SHARD(local_out, shard->base_cid, shard->nr_cids);
> +		u32 cap_bit;
> +
> +		scx_for_each_cap_bit(cap_bit, caps)
> +			scx_cmask_or(local_out, &pshard[si]->caps[cap_bit].cmask);

[Severity: High]
Is it possible for si to exceed the bounds of the pshard array here?

If an old root scheduler is unlinked but its BPF programs are kept alive
by a user-space held file descriptor, those programs can execute later.
If a new root scheduler is subsequently loaded and uses scx_bpf_cid_overrid=
e()
to increase the global scx_nr_cid_shards, ref.shard_end (which tracks the
global layout) will reflect this new, larger value.

When the old scheduler's BPF program calls scx_bpf_sub_caps(), this loop
could iterate past the size of its originally allocated pshard array, causi=
ng
an out-of-bounds pointer read when accessing pshard[si]. Should this loop
bounds check si against target->nr_pshards to prevent this?

> +		scx_cmask_ref_copy(&ref, local_out);
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D19
