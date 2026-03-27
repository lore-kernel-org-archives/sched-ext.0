Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11B7261C;
	Fri, 27 Mar 2026 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573108; cv=none; b=J3f5C+bJicQf/FmhUtfv8MGyKeEKeNjX6v6gAMm+Yc90kxozq2GFX/y4kNMcGxBl+w7I1HzXrNUbQ5VqIEwB6iaP2Vv4bPFqM5UILMXny07Y+/0WzXdkJlzr8PKHGH6jrz+ErnFDbFto2B9zTMlt0l7HrsqeZCJQ4VBk+G3MO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573108; c=relaxed/simple;
	bh=aOPrI3D7ASWNZz2hiCv2gqQraozLquus1sLRkwBXZus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWHSbzCMhCqWMkygtNp5hfASwJvVPhAldYcP4cJLIWkOLItsn36PO3ovDucMv5NX6UiC9AFzEvIxzSgKYTtliQZqxLcUXO4nqzmI2Ywp3Yan23bsmhrGT89zH5HCJBLVId/r/vRu+EYSVYS8f/jsLmeufbgwmlSGYciTKJ9sgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac/l3EQN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac/l3EQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22EFC116C6;
	Fri, 27 Mar 2026 00:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774573108;
	bh=aOPrI3D7ASWNZz2hiCv2gqQraozLquus1sLRkwBXZus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ac/l3EQNYesESO/IThSaeKJf4ITu8eobekwhgB/LoxG3/msg8FTKDXtqduWu6SDld
	 sCO+CR15aRmQ0SX8W4KV9cZ43cCqoAvOemc2KvEJVaXNXRHlpcIL2LSkLTFIPctv1C
	 ZMZd1car6etEi5cTtiBqVVfrImkkPs0LB+pUmwewf5l7nOJXQl8t9NhytYsxauSXlv
	 SZHc2li70XrNzkioh5qnPVrbZHwANoFUgJBp46CGepIg5LXC5UfZa3rSiFB+7yFSta
	 68xq1mi7Zb1BHdB4Fc2tw+bnbYn5dVJCDIWt6JwExv3UE3WerKyzvXwFVf1z3GQMhJ
	 Lc3kF5KxB+yzQ==
Date: Thu, 26 Mar 2026 14:58:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	emil@etsalapatis.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhaomengmeng@kylinos.cn
Subject: Re: [PATCH] tools/sched_ext: scx_central: start timer from central
 dispatch
Message-ID: <acXWMnYJPD_uGf_l@slm.duckdns.org>
References: <20260326091523.299333-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326091523.299333-1-zhaomzhao@126.com>

Hello, Zhao.

On Thu, Mar 26, 2026 at 05:15:23PM +0800, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> scx_central currently assumes that ops.init() runs on the selected
> central CPU and aborts otherwise. This is no longer true, as ops.init()
> is invoked from the scx_enable_helper thread, which can run on any
> CPU. As a result, sched_setaffinity() from userspace doesn't work, loading
> scx_central can fail with:
> 
> [ 1985.319942] sched_ext: central: scx_central.bpf.c:314: init from non-central CPU
> [ 1985.320317]    scx_exit+0xa3/0xd0
> [ 1985.320535]    scx_bpf_error_bstr+0xbd/0x220
> [ 1985.320840]    bpf_prog_3a445a8163fa8149_central_init+0x103/0x1ba
> [ 1985.321073]    bpf__sched_ext_ops_init+0x40/0xa8
> [ 1985.321286]    scx_root_enable_workfn+0x507/0x1650
> [ 1985.321461]    kthread_worker_fn+0x260/0x940
> [ 1985.321745]    kthread+0x303/0x3e0
> [ 1985.321901]    ret_from_fork+0x589/0x7d0
> [ 1985.322065]    ret_from_fork_asm+0x1a/0x30
> 
> DEBUG DUMP
> ===================================================================
> 
> central: root
> scx_enable_help[134] triggered exit kind 1025:
>   scx_bpf_error (scx_central.bpf.c:314: init from non-central CPU)
> 
> To fix it, initialize the BPF timer from ops.init(), but defer
> bpf_timer_start() to the first dispatch on the central CPU. This preserves
> the requirement that the timer be started from the central CPU when
> BPF_F_TIMER_CPU_PIN is used, without depending on the CPU affinity of
> the enable path.

Can you do the followings please?

- Remove now unnecessary sched_setaffinity() call.

- Do scx_bpf_kick_cpu(central_cpu, 0) so that we're guaranteed to enter the
  dispatch path on the central CPU immediately.

Thanks.

-- 
tejun
