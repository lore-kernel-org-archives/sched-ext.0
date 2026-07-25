Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB2331A7B;
	Sat, 25 Jul 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785012078; cv=none; b=uhLJIj+9pNdNyOeO7HdNO1N/Smn/QaKk0Q/AbiOtwchU2tQ6efArO3pSdnF1JgsXtvfQFVnruu6kdA+c7PypBwvrrdVV3rD3u++rhBv5Lr6zF6EQ2VL+cVnKuIQ4r8Thgk012vB3vQ3ZVvwat+TceDK77bWozqcXzHiGYfzfrMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785012078; c=relaxed/simple;
	bh=ku9sK3v3uxq18e9acjcVNTQThPX1XBl5C+RsHzuVh5c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=PzDKepdAqEdsaQuG4x8AHnthNTUe8GFjvIKITQvrOkpTSY21t2iyhRjUMHUiKnmNfNEWhIicrXVBKsog4vyEl+NrjUEnsVGAHDVfsBDT9GMyQ30mfRh3e8dvbyABQ64FllHQ/xYzE9/yBA7d3SYAFyUV851jqZImxbDCXyB5LLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC9mIhiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC9mIhiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF751F000E9;
	Sat, 25 Jul 2026 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785012076;
	bh=7HCsbHiQ7uvduv6CqZ85jypaoRcggdJt7YZAGdb+1YM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bC9mIhiwe8OLme7ebtx6/Wz1TmgNmrSTeXDMNDTaBL3fcVSQ6tUobcHMPZDGDHtOl
	 zInWnjmZQPDMv4mUtSRUz0RbHcXEfCUcgAzm5h5TbWN/GASQZlFIJMPEP9jZJERqnw
	 BbUj2ANbNKmdIqbzZ9udQiMZFivJyOX15qxoNXU/4UWYNdhEUlb8LEzMrTW2IN1lGu
	 UIZwGjam0udAxh7WdpkZMpzDhJn96pchH9uXRG7BXiup3AQImP2o0JsjiejiaG1oOa
	 /z0Ppl2DvyqgLle5DBMBN6WS0nCImcTM4fvenGd3/Vp45IAz1Y8jOxltB6o54qVKfT
	 yzxETmuSPvpbg==
Date: Sat, 25 Jul 2026 10:41:15 -1000
Message-ID: <5885fde630e3d096cfdfa345ca7f4e82@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3] sched_ext: Sparse annotation cleanups
In-Reply-To: <20260724012914.107823-1-tj@kernel.org>
References: <20260724012914.107823-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Tejun Heo (3):
>   sched_ext: Add scx_cgroup_sched() for cgrp->scx_sched reads
>   sched_ext: Resolve most remaining scx_root accesses
>   sched_ext: Use rcu_access_pointer() for the first_task comparison

Applied 1-3 to sched_ext/for-7.3.

Thanks.

--
tejun
