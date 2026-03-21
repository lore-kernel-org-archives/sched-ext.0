Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0422F1FEA;
	Sat, 21 Mar 2026 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120204; cv=none; b=Qk/tHkChKirC4+kLwBrQPRMWW9nGANyHylGNgxRK4WckaRNgMtz5MC2i+5CH5e8Kjoyj3RBFzNlY7O73Tw7TkgAPMIikhK1inObQZ/p3uVkGkPGrGpvvHwgwh5mnpjKPED5Pp6U586WQGBZY5+Van1GawOHludkX+F2aQMvoqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120204; c=relaxed/simple;
	bh=lWDEFIwoUj7wYF0Bf4PAmjlxkDpmVIi7azAylufz8VE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=B0YI4iEYLpv6SLTf2T9Yshxe41mv8IvLqJdmejkd2PmKkk4/BIeduU1v3QaDmsaaQNmIp1x7JWhzLiybh26GXEUjjVVoEJiHEuHaKArqh2HvS2eicis3V40+M8CMKI24VH7L4miB0As/SmYym78v/CDiiqdAmVEiGE4lp+ofEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF0f3yZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF0f3yZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E753C2BC87;
	Sat, 21 Mar 2026 19:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774120204;
	bh=lWDEFIwoUj7wYF0Bf4PAmjlxkDpmVIi7azAylufz8VE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IF0f3yZk3vBhinvqgSgmqGhLSplgOc0YuNcgniVdO6y78vY5DYuSEe6XYvZ9UZGOm
	 N9l10Lr8FCCmwq5nBdl4z2LX+73ZFsBerbjO8ksXRcbua3GhO6Axzl7ZtltZ/jmv/Z
	 H56GA+JXMM2grPVdzjgANVyZS0j4u8z2WWzgLSUdqXq0t1wIUsTY1UTHym3AJWsxfz
	 wbuJxN4Ept9gLcBjqqK1xqArwXzvJ3yFnnUbMLD0BXF089Nwq1PRqn/XH01MNFipFf
	 IyZ6TsXmQTb9HK+3zXS9RGwJu/ZL43pOxnJ48t4eh9JC9aiT6p8XnJM8ycPhXsgQwg
	 gdpbzIYDwEgJw==
Date: Sat, 21 Mar 2026 09:10:03 -1000
Message-ID: <49aeada41a0e78e9673f053806321df3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 kernel test robot <lkp@intel.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix build errors and unused label warning
 in non-cgroup configs
In-Reply-To: <ab6sqIW4p8QKYQXA@gpd4>
References: <20260321070605.691776-1-yphbchou0911@gmail.com>
 <ab6sqIW4p8QKYQXA@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Sat, Mar 21, 2026 at 03:35:20PM +0100, Andrea Righi wrote:
> This looks like a false positive, the kernel test robot likely tested
> with a manually crafted config, so I think we shouldn't apply this
> patch.

It's not a false positive. CONFIG_SCHED_CLASS_EXT doesn't depend on
CONFIG_CGROUPS in Kconfig, so SCHED_CLASS_EXT=y with CGROUPS=n is a
valid config. I reproduced the build failure using the bot's config.

The issue is that CONFIG_EXT_SUB_SCHED is def_bool y depending only on
SCHED_CLASS_EXT, so it's always on. But EXT_SUB_SCHED fundamentally
needs cgroups (cgroup_path, cgroup_get, cgroup_put, cgroup_id, etc.),
so the missing dependency is there.

Cheng-Yang, can you send a v2 with the following approach?

1. Add CGROUPS dependency to EXT_SUB_SCHED in init/Kconfig:

    config EXT_SUB_SCHED
            def_bool y
   -        depends on SCHED_CLASS_EXT
   +        depends on SCHED_CLASS_EXT && CGROUPS

2. Guard err_stop_helper with #ifdef CONFIG_EXT_SUB_SCHED (only
   jumped to from within CONFIG_EXT_SUB_SCHED code):

   +#ifdef CONFIG_EXT_SUB_SCHED
    err_stop_helper:
            kthread_destroy_worker(sch->helper);
   +#endif
    err_free_pcpu:

3. Guard cgroup_get/cgroup_put in common paths with the existing
   CONFIG_EXT_GROUP_SCHED || CONFIG_EXT_SUB_SCHED pattern (matching
   the root_cgroup() / sch_cgroup() stubs):

    err_put_cgrp:
   +#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
            cgroup_put(cgrp);
   +#endif

   and:

   +#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
            cgroup_get(cgrp);
   +#endif
            sch = scx_alloc_and_add_sched(ops, cgrp, NULL);

I verified this builds clean with both CGROUPS=y and CGROUPS=n.

Thanks.

--
tejun
