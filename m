Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3A14F98;
	Sat,  9 Aug 2025 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754766358; cv=none; b=BePcN/l8CGgIIOqJkVaH8L/hxo2Wgn5FEVMiNupqz+gMlwTCr20UuZ8qN30eT0H1TmVobGXSRMxgCDYPTFjLVPvSLna7ctuS76EiJpTm3Y69/UkOyB5AfnabOdbVsqrwnLXDKw/VdBYTxCWW8jukuKed304/xaxJUb0aG8SR7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754766358; c=relaxed/simple;
	bh=rExTbwvEF3xB6jxB/Z8+HO6SeihUoUr7IJLIc0lvJwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0L5rbZmwhv1YqJhnePAGWb7+0519KKCCsXClmNr9qN5bCVmA2ERHHWaUyrhCnHByxDQDC3oqvx2A3SGsvkIlKgIVj+RSizWfSzUY6aU+d+6DSVgJwwfIYXmub+0dlE2MfM6jEprJZGFEgiBcBqiw1wQGNnXyW0ha5u1zyCq/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbjmDOkk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbjmDOkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1DCC4CEE7;
	Sat,  9 Aug 2025 19:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754766358;
	bh=rExTbwvEF3xB6jxB/Z8+HO6SeihUoUr7IJLIc0lvJwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbjmDOkkVGFCuG2g+0VLhqtvdOjRHyx6BEk6ux9V5W+CTu3zhCa4VBvUmMPHA5jcx
	 g85uvST3LMXA4XS/WLzrHPcshfhZM0owuvn9OsN7fkBuvk0HXfUmCUMKpr6vMtG9wK
	 Flz4Jbo1ER3j47OyMed8zCx+V3OCkQlMrzSS+qDkUMMuK9XdmTW3qjF2zLfkPS5kzP
	 uqyosO82QAz5VAR4FKDW34AgnlYqoUvCZLIEBPy27/tajzgDfMACMuL60eUoRKY7JS
	 8tNIGLjvcpH/ZJUB/tFKSWOBvK0wHZ/FjhBa+5AIjztx3p+rJA/tn5QtkkZNhIUK8Q
	 D6n7prAxmj3gg==
Date: Sat, 9 Aug 2025 09:05:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/ext: Fix invalid task state transitions on class
 switch
Message-ID: <aJecFbsDcVQPVcwn@slm.duckdns.org>
References: <20250805085911.164956-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805085911.164956-1-arighi@nvidia.com>

On Tue, Aug 05, 2025 at 10:59:11AM +0200, Andrea Righi wrote:
> When enabling a sched_ext scheduler, we may trigger invalid task state
> transitions, resulting in warnings like the following (which can be
> easily reproduced by running the hotplug selftest in a loop):
> 
>  sched_ext: Invalid task state transition 0 -> 3 for fish[770]
>  WARNING: CPU: 18 PID: 787 at kernel/sched/ext.c:3862 scx_set_task_state+0x7c/0xc0
>  ...
>  RIP: 0010:scx_set_task_state+0x7c/0xc0
>  ...
>  Call Trace:
>   <TASK>
>   scx_enable_task+0x11f/0x2e0
>   switching_to_scx+0x24/0x110
>   scx_enable.isra.0+0xd14/0x13d0
>   bpf_struct_ops_link_create+0x136/0x1a0
>   __sys_bpf+0x1edd/0x2c30
>   __x64_sys_bpf+0x21/0x30
>   do_syscall_64+0xbb/0x370
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> This happens because we skip initialization for tasks that are already
> dead (with their usage counter set to zero), but we don't exclude them
> during the scheduling class transition phase.
> 
> Fix this by also skipping dead tasks during class swiching, preventing
> invalid task state transitions.
> 
> Fixes: a8532fac7b5d2 ("sched_ext: TASK_DEAD tasks must be switched into SCX on ops_enable")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.17-fixes.

Thanks.

-- 
tejun
