Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6274A1E19
	for <sched-ext@lists.linux.dev>; Sat, 26 Sep 2026 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790458479; cv=none; b=sOif9aqnm2e6m1cFyk+ghnjtRWNpGopm0nKqq39ckDB9fCkTqW2BfPfzu19u1zqqaiyV2OoXvlbqEMCQMSWH0mWBu0ueZY6idffOf8HMJol500A+F4ijk9RFgWS036HEh0/+RDdMsaOJC+S7iQZOozJ4lC3FMZU5RzxvjwKyAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790458479; c=relaxed/simple;
	bh=csTlj2CQvtCLcEazms/N+YLNevAPh0mNg5+Trdvf5Ds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e+4nxbs9xFb/gj43Y25QcJtapTZeKzuNvqlmomJt4NMmzerVh8SG/3ZNVGUtldn0pvt3u+id+bGfcvoNEfDMSyT3Uq3fjszBf8Ml8hXWnhMkdnS802j9Eyvoe3sxG/XGHB50/cE9iJ2LwJrSKVqfdHtlONdqXWvq0DvUC1HJk5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfmSI5bz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfmSI5bz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAC91F000FF;
	Sat, 26 Sep 2026 21:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790458477;
	bh=ehcV7oeFiU/r1RfjM7AONx3J+AHP/4ZAyH6GiHvcpaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kfmSI5bzGGPr+YmXQiRJs4o0qi6qyeCu1KUmbt+RgA4HPv4EkGVOSqJ95kWFUtoYa
	 6KAxHQQ7Ejz+zeF3mWifqYLfK77VkS21sx5RUuh5Leat9wB8nHSedB4rAx4GGq/G6y
	 QGOnfQ/RmNftf98HYRYqJz0Tet/tHEUGSon5qkxa1mQ1pYj4D7kvFqnaoV1HJtWpwq
	 JtksF61Hhl2mIr46sPgviSzdxWpjuQD9tq6v4vFlq1tpkegI7pOdmqHGCwVsg4yDai
	 IdZhxhbdQ7MPEiHAGZ7RZMA+1rBC4LvGxFGqkMQRPJLizigW0O5tkVdQs4qXFUN3TE
	 D4/TyHeTopszg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4] sched_ext: cid: Represent clusters
 explicitly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260926212017.3351797-1-arighi@nvidia.com>
References: <20260926212017.3351797-1-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 21:34:37 +0000
Message-Id: <20260926213437.5FAC91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: scx_bpf_cid_topo UAPI break due to struct scx_cid_topo si=
ze change
--

commit fb59a730e3e34d8a0c1fda134fb4459d8183c802
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: cid: Represent clusters explicitly

This commit adds explicit cluster representation to the sched_ext CID
topology. It modifies the cid calculation logic and updates
struct scx_cid_topo to include cluster_cid and cluster_idx.

Link: https://lore.kernel.org/r/20260926152306.3190774-1-arighi@nvidia.com

> diff --git a/kernel/sched/ext/types.h b/kernel/sched/ext/types.h
> index 943d8d429a2c9..765d7b9208144 100644
> --- a/kernel/sched/ext/types.h
> +++ b/kernel/sched/ext/types.h

[ ... ]

> @@ -88,6 +95,8 @@ struct scx_cid_topo {
>  	s32 node_idx;
>  	s32 shard_cid;
>  	s32 shard_idx;
> +	s32 cluster_cid;
> +	s32 cluster_idx;
>  };

[Severity: Critical]
Will adding cluster_cid and cluster_idx break existing BPF schedulers that
call scx_bpf_cid_topo()?

By increasing the size of struct scx_cid_topo from 32 to 40 bytes, the
expected argument size for the kfunc changes. Since scx_bpf_cid_topo()
lacks a size-aware __sz parameter or compatibility wrapper:

kernel/sched/ext/cid.c:scx_bpf_cid_topo() {
    ...
    *out__uninit =3D topo[cid];
}

Could the BPF verifier strictly reject older BPF schedulers passing a
32-byte allocation because out__uninit demands the current kernel's BTF siz=
e?

Furthermore, if the check were somehow bypassed, would the assignment cause
an 8-byte out-of-bounds write into BPF stack or map memory?

Does this constitute a hard ABI break for existing userspace binaries since
they lack a deprecation path or versioning wrapper?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926212017.3351=
797-1-arighi@nvidia.com?part=3D1
