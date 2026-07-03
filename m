Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64E3FB06D
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090646; cv=none; b=dsCZm/AT0Bm8n5Lt4NSuY5kkyotLdO16n6x+B56MQGfYcvaVgRdq6Z2/Buz4iPWbht/b9XxUO4VWn6GTNqkcl6+3X6Z86MtSZTIhq8/H9gar9Ez9NEC/cL/YFtKFnMOjA6bi2qawegC/2UJr4VJYJHd3+cyZkZqybgI4VdjfZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090646; c=relaxed/simple;
	bh=tiO2Tx691Pfinfe8qZiwPQ2A+OXTe9AH5xP21UYXAFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PE3skt8u8twkqs7A0NFHWlGk90hqQDNryPE4dkJqgvS08Gt2+x7m6R8OOQKtGCdvbXO8ACFiZz9r+GY6Nz4JyZAuUVY9VOfiG6JrMEsA70Lo4bMBnKeuiYVZk7iyzA3rKX/fVJ5duS8Mp+chFgLBKQsI3qCfkXooRDLP8arRrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESnhpojp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESnhpojp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006E11F000E9;
	Fri,  3 Jul 2026 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783090644;
	bh=48GqyqbZciLc0BLByKNlhuXQiFxOeyc6Qn/9qq+toDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESnhpojpKG0SrMd7EY5K9ou1VG5qCplhjzPwGCEHci8UlOmRDsJRhEe8w6puqmUWC
	 iSZL/nREkJZrDztWwGm8Bv/uHNSuNyXbCxPpL5eo/HyoO6efhlyRXhO2hwaMr8K3N9
	 4IReg0huNHW8aoH6JgOBOMjSMxQJm5gfARxpyBFtbi1ljjpXRWafhT8Ijbk/SojvWU
	 6cwI1wLMjsSf5J5mqHKyUsnsPAv8ED3Nnx0AEVG4Dw8Gwo+FH+uz8lvySkERr2661k
	 EngnMTbcYvnCqUEJpYrHZykdoOfh3rb1PRBgT+XIUuqvWGbw2+Ypz4oTfphXPdCFRu
	 aF/CuNs3Kx+LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 31/32] tools/sched_ext: scx_qmap -
 Expand hierarchical sub-scheduling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-32-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-32-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:57:23 +0000
Message-Id: <20260703145724.006E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing atomic increment for sub-scheduler dispatch counter (`nr=
_dsps`).
--

commit ce8113fd0fe8bd38281cc676e6e4f5bc5e262e96
Author: Tejun Heo <tj@kernel.org>

tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling

This commit expands scx_qmap to demonstrate cap-based cid delegation for
hierarchical sub-scheduling. It allows a parent to delegate exclusive cids
to child cgroup sub-schedulers based on cpu.weight. Remaining cids form a
shared pool that is round-robined among participants.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index f6cfe63425d36..938a32514b2f6 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
[ ... ]
> @@ -567,11 +627,34 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct =
task_struct *prev)
[ ... ]
> +	} else if (owner >=3D 0 && owner < MAX_SUB_SCHEDS &&
> +		   qa.sub_sched_ctxs[owner].cgroup_id) {
> +		if (scx_bpf_sub_dispatch(qa.sub_sched_ctxs[owner].cgroup_id))
> +			qa.sub_sched_ctxs[owner].nr_dsps++;

[Severity: Medium]
Since qmap_dispatch() can run concurrently on multiple CPUs delegated to the
same sub-scheduler owner, will this non-atomic increment lead to lost
updates?

When multiple CPUs update this counter simultaneously, it looks like data
races can cause lost increments, resulting in incorrect statistics and an
under-reporting of disp/s in the userspace tool. Would it be better to use
an atomic add here, similar to how other counters are handled?

> +		return;
> +	}
> =20
>  	if (!qa.nr_highpri_queued && scx_bpf_dsq_move_to_local(SHARED_DSQ, 0))
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D31
