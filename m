Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C803F4106;
	Fri, 21 Aug 2026 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339640; cv=none; b=LNEeFQ69QUD8l6qpa2zN6WwGkjbOe51IfBf7uyI1ui0u7nEh8ViIdd40XgIunYg+FNXY+m7j377itCVOjdzAMfk/nsJZn1hyu2VtKnTyVziP1lJv2h+yxWN0Qpd7xsRNHTINEGog22DX3eV6faufhI/+ouSU+HIF8pSLO7hw8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339640; c=relaxed/simple;
	bh=L2S29FcB3Zo2qAxCAOuMRyVxwQwIx1BuSFd75ylx8+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9ooVNQFA4isOMxgvKA0bj76oFM2eN2BzoUueXt65bxRekkxincsKtPAiVg98PafaeiD8dvDfC6G1xkAUnTgtkuUlxfudsmaXfvpYbgfnxhaR4VX0/oVIu+VeVASR/fgEGp6kl3Ctl736NNTUxxh9g7Me46a9v8mqhdXVojhtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bel8PW5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bel8PW5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8563E1F000E9;
	Fri, 21 Aug 2026 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787339631;
	bh=3UDPZVJ/D8hltNMEwvqilnSzU9MDE59JrR1x+gSzOBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bel8PW5vaJ/sM3GtjIKQInM8d3N69aSreuRD3RlROUbLpMXcVV64Fxmic8j4LK5ra
	 0suHGosaxV8FAS+ADicQmQTLOIqXWMziwdI4XP9rjKUiA4a/owF/X+LJFygbayGb0l
	 RwxiLFZPfyhSxPQQ70v4jtdXIQAMElkRsvc+jq3ySptNnflEiEh7ZgMcNt8XZoICYG
	 NDIq1DHWflWDlEt1bLl9doa9PYrmQKxXXWxX1K7d4ceMzG0mUTkMeKGTe1EVRAtxNB
	 dTcCm6uoEsANi546doJ5PfVzs9PWaWJlXKd9yCnhS50G1y+2zO4iJiSG/L0rlAKkjM
	 nL5vXvzN+XNjQ==
Date: Fri, 21 Aug 2026 09:13:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] sched_ext: serialize concurrent cpu.max writers in
 scx_group_set_bandwidth()
Message-ID: <aoijbun-nKlNWoeL@slm.duckdns.org>
References: <20260821103519.535987-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821103519.535987-1-changwoo@igalia.com>

On Fri, Aug 21, 2026 at 07:35:19PM +0900, Changwoo Min wrote:
> Concurrent writes to a cgroup's cpu.max are not serialized by the cgroup or
> kernfs layer -- cgroup_file_write() calls cft->write without cgroup_mutex, and
> kernfs only serializes per open file -- so two writers to the same cgroup
> through separate open files can reach tg_set_bandwidth() concurrently.
> 
> tg_set_cfs_bandwidth() serializes the CFS side under cfs_constraints_mutex,
> but scx_group_set_bandwidth() runs afterwards with only
> percpu_down_read(&scx_cgroup_ops_rwsem) held, a read lock, so it does not
> serialize concurrent writers.
> 
> The ops.cgroup_set_bandwidth() callback and the cached tg->scx.bw_* stores can
> then interleave between writers:
> 
>   CPU1 (writer A)                 CPU2 (writer B)
>   scx_group_set_bandwidth()
>     SCX_CALL_OP(...)  /* A */
>                                   scx_group_set_bandwidth()
>                                     SCX_CALL_OP(...)  /* B */
>                                     tg->scx.bw_* = B
>     tg->scx.bw_* = A
> 
> The scheduler's cgroup_set_bandwidth() op is invoked out of order and the cached
> state is left inconsistent with the last writer; the 64-bit bw_* stores can also
> tear on 32-bit.
> 
> Serialize the SCX-side update with a new scx_cgroup_set_bw_mutex held across the
> callback and the stores, so each writer applies its update atomically and in one
> order -- the SCX counterpart to cfs_constraints_mutex on the CFS side.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/sched-ext/20260817172131.BCDA51F000E9@smtp.kernel.org/
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

I think the following is a better way to resolve this:

  http://lkml.kernel.org/r/20260821140818.1559100-1-michalblk@google.com

Thanks.

-- 
tejun
