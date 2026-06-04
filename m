Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248093D890E;
	Thu,  4 Jun 2026 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561753; cv=none; b=o4+0lp4NNIkRU9Wsc6iZhVKxg47fkfHlapMLNojWr4R4pCHXPkdiMrrTl1LNpa1g9XYpXDsNm7zOz/dRA5nEF1+SJFMDQD7gziRYCohYbxjA1Iq70wYV/rh8TGWsSCrwVOXCMy5iXynwmwewG6rvy5pbi2v88zXWHw/M3xLO4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561753; c=relaxed/simple;
	bh=PoW6Q2Z/3m7S+GBNT4dbuhAGzahFHhKwLgYh6axE4RA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=UJza32sByqFAVlq8o3c9xpvSHwhe/dGNZ8L0qkvi5VR8qhm4biq+Zl9/KHay5G1lAacB88P0aVDeVUF5IAWz6G+Q+SFQhMhxGq8UxbOoS7R4ScCxZcKJ4bnRQNkB+Xty2ePXc7bAcYyswv7FrA9NndPB6o60x8JG+J2E5AVk2V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiuJsWeT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiuJsWeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859351F00893;
	Thu,  4 Jun 2026 08:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780561751;
	bh=PoW6Q2Z/3m7S+GBNT4dbuhAGzahFHhKwLgYh6axE4RA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AiuJsWeT1PIDwQ5Fh339tJzpNVK2s/R0JSPR27Vopj3L0x3zPsqsrt7XRqBAtT9bW
	 IekaFNJg0aekpmz5qSgr4CIdTQ2bpHXZYfNND75ZxLNtrd7XWQmdvXQ21OAQNBKEmE
	 2QHAZDhulvAqHapOBDFKGc7qPLCSBWhrpITDwKchM4CMrCo3ztfaZa2AiGUHZtxTCs
	 7j6C87EDMmxEsyMfwgrYeeVrvzbdFxBI/0q5NxOmFMaqDj0ycvqNStvEDKu4icNy4C
	 cNuryIVvliHnRbnwL5UEVvdtBK27G37H3XGbepEuQ8d0hQMj1jKN47KsifkL3jJFMh
	 7Zw9tUMO3gUBQ==
Date: Wed, 03 Jun 2026 22:29:10 -1000
Message-ID: <c2c820b0287df816cae84763b9e757bc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	devnexen@gmail.com,
	yphbchou0911@gmail.com,
	zhaomengmeng@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: scx_flatcg: Document cgroup v2 requirement
In-Reply-To: <20260603090106.2494243-1-luoliang@kylinos.cn>
References: <20260603090106.2494243-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, Jun 03, 2026 at 05:01:06PM +0800, Liang Luo wrote:
> The BPF program relies on cgroup v2-specific features - specifically
> BPF_MAP_TYPE_CGRP_STORAGE and cgroup v2 kfuncs (bpf_cgroup_ancestor,
> bpf_cgroup_from_id, scx_bpf_task_cgroup, ...), none of which are
> available on cgroup v1. The current file header describes the
> algorithm but does not make this runtime requirement explicit, so
> users running on a cgroup v1-only system get a confusing BPF load
> error with no clear pointer to the cause.

This doesn't look accurate on current kernels. BPF_MAP_TYPE_CGRP_STORAGE is
registered unconditionally and its fd access goes through
cgroup_v1v2_get_from_fd(), and bpf_cgroup_ancestor(), bpf_cgroup_from_id()
and scx_bpf_task_cgroup() all take a plain struct cgroup with no v1/v2
gating. The program should load fine on cgroup1.

Did you actually hit a load failure, and on which kernel? cgrp_storage's
cgroup1 access was only enabled in v6.8 by 73d9eb340d2b ("bpf: Enable
bpf_cgrp_storage for cgroup1 non-attach case"). Before that it was cgroup2
only, which would explain a failure on an older kernel.

Thanks.

--
tejun
