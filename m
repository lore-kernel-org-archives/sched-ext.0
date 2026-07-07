Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399E17D6
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384209; cv=none; b=b0Fx1d65q4UMgX9aiuIUrhR7aSzsYgihPumvHJPWEyhkSgsKQYMGcQm1FYdENUCZfo2m10e5ARlubKUdTSVqgg9MksWITJ5U8rAeSs4jjgU5GVdTuFvqr5L+S/BckJ3qtaAJWY3s+xzOR79CiK1O+IhG9QBrcj0QsNz6bn/0vcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384209; c=relaxed/simple;
	bh=3L3Ozh5YopscceQBarLy3X3n0bcaGiLi50g1rKbbLI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HQkQM7sEfCRpa2Jl0s4GtFncwU8ieGbWDB7ujbp0Gzj+A3NcqU0/0c1l/2jj/rJrQGbZ4bDDOPXjqldD4AdWii26+8aPLj/iDymZvNW4PBazoNWAT473BxvZoziEtTdGMuPSatTt7VgaXFUnJEGIYix9GVR8kwd7h8kelkreYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI38PglK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI38PglK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D081F000E9;
	Tue,  7 Jul 2026 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384207;
	bh=kn6dNv8YQw/HerU07X6wZTa8dP1flLnSt/JvUTWdZ9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JI38PglKJDlj0UnmaPzmSrwbxWTZUcKOS+V2yMUXZnVu2MjTmX5dYi1iKL9BagrFy
	 eW7taGkslORauPEjMdMtV0sKBADhuiSYi0YQWb890+YXjChmBmlwEwuP2ydOS3tI6g
	 M+9iqgwh1vhFe5/8hUDP+r2d/6BoAR9oGtybU19yULOEyOm4xrkdXJWlODQXkY8V5f
	 x+pvIuGVLYMAM3ItcpdDhdMrQYIRA1YdqYyEw98RG17MJy+gp0ZSIBZH8qKYWZIdrB
	 VnbGaTu7aJMpSL8Kg7cFbDKtkC3Vzj9so8p3NpOMzfO2V9P5N5DSOQh9EDpbJqJK0z
	 Op+IqQee+tRhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 11/36] sched_ext: Add CID sharding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-12-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-12-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:30:06 +0000
Message-Id: <20260707003007.49D081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `scx_bpf_cid_override()` leaves newly added shard tracking arrays =
stale and inconsistent.
--

--- Patch [11]: [PATCH v3 sched_ext/for-7.3 11/36] sched_ext: Add CID shard=
ing ---
commit 1415bf490cd13477d062d1f4478f7763736291ab
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add CID sharding

Sub-sched operations need a scalable locking / work domain smaller than the
whole cid space. Carve the cid space into topology-respecting shards: each
shard is a contiguous cid range that stays within one LLC, and LLCs larger
than the per-shard cap split into enough shards to fit. Also build
scx_cid_shard_ranges[] for O(1) shard-to-cid-range lookup and
scx_shard_node[] so callers can size or place work by NUMA without walking
cids.

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index b0ec4d76f8552..f3c54f4223b43 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
> @@ -18,13 +18,17 @@
>   * use scx_bpf_cid_override() to change the mapping. The mapping stays s=
table
>   * until the root is disabled.
>   */
> +u32 scx_nr_cid_shards;
>  s16 *scx_cid_to_cpu_tbl;
>  s16 *scx_cpu_to_cid_tbl;
> +s32 *scx_cid_to_shard;
> +s32 *scx_shard_node;
> +struct scx_cid_shard *scx_cid_shard_ranges;
>  struct scx_cid_topo *scx_cid_topo;

[Severity: High]
Should scx_bpf_cid_override() also be updated to clear or rebuild these new
shard tracking arrays when a BPF scheduler overrides the CID mapping?

Currently, scx_bpf_cid_override() only invalidates scx_cid_topo:

kernel/sched/ext/cid.c:scx_bpf_cid_override() {
    ...
	/* Invalidate stale topo info - the override carries no topology. */
	for (cid =3D 0; cid < num_possible_cpus(); cid++)
		scx_cid_topo[cid] =3D SCX_CID_TOPO_NEG;
}

If the newly added scx_cid_to_shard, scx_shard_node, and scx_cid_shard_rang=
es
arrays are not also cleared or updated, will a scheduler querying
scx_shard_node[scx_cid_to_shard[cid]] silently receive the NUMA node
corresponding to the old CPU that was mapped to that CID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D11
