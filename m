Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AB27FD4B;
	Thu,  4 Sep 2025 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017682; cv=none; b=o9ilnL6ewVz5dsO2KkNRf0ORnybJiG25ci8XBZY4Kbuc4ybGVxVOAm7MmUFBXGXapI4AGIg5Y/jmB+4jKjS2o+0GRMXI7ETtgQgY/l5g0ffHC0qkaijz1IdaGLXBB5cmHftqpy1Cl5qj16eKCb1t+A5lutz65FJ5dVwfLU6iHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017682; c=relaxed/simple;
	bh=nUxw2F99A5SVU4pIGmbQ8xdl9OE4cjF0PUxIIjz+/ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To/SXsPD3W8T+n48jtxHN3Oe6XnwQXx43DDkcvc0wYuDgYDBoQYvtts8d8JxbnTAQjecYvUyi/so1iBWF0GoIiNrbEqQrmEaKoguJJH/+fPaD9DqPAagTYGxjay0Weh3di8xNeKrFaV0+8pruM9aHN2W85Y7QAAztpKcJZkc5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z06lSuML; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z06lSuML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C169C4CEF0;
	Thu,  4 Sep 2025 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757017680;
	bh=nUxw2F99A5SVU4pIGmbQ8xdl9OE4cjF0PUxIIjz+/ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z06lSuML12fVHl12/wXUtMCeD+Vb3uDHkTwYsUMqCztx6f2/ZBKMmMXgqFKdP1rFL
	 op3vovSeH60QiPTjRkbdBKGhNGcfDW6JNIYkaGFv5kUrLihMVoSBbUIogiFG2VDEqe
	 Wj04RjgVMTRc5TwvhchbX6Yj3te/bcpHVMk8kWakKwJsd7ygmfkVxRlKrJQalusCAr
	 QA9p9uYc6HlyEE61Mby2EdXTUEqD6cw8oWZ9vocLuuVeTTIUcxeW0JGsrBD01zjoDs
	 f9xIMhkTK4B0wjRAIkTsWcIwUVYUrJ/JaSocAAUY2+7W+JvoJ3gRfSbahodNWQXbGc
	 umcCFTdmNPYkg==
Date: Thu, 4 Sep 2025 10:27:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Jake Hillion <jakehillion@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-6.18] sched_ext: Fix NULL dereference in
 scx_bpf_cpu_rq() warning
Message-ID: <aLn2T4LUePv9gAwc@slm.duckdns.org>
References: <20250904182348.107835-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904182348.107835-1-arighi@nvidia.com>

On Thu, Sep 04, 2025 at 08:23:48PM +0200, Andrea Righi wrote:
> When printing the deprecation warning for scx_bpf_cpu_rq(), we may hit a
> NULL pointer dereference if the kfunc is called before a BPF scheduler
> is fully attached, for example, when invoked from a BPF timer or during
> ops.init():
> 
>  [   50.752775] BUG: kernel NULL pointer dereference, address: 0000000000000331
>  ...
>  [   50.764205] RIP: 0010:scx_bpf_cpu_rq+0x30/0xa0
>  ...
>  [   50.787661] Call Trace:
>  [   50.788398]  <TASK>
>  [   50.789061]  bpf_prog_08f7fd2dcb187aaf_wakeup_timerfn+0x75/0x1a8
>  [   50.792477]  bpf_timer_cb+0x7e/0x140
>  [   50.796003]  hrtimer_run_softirq+0x91/0xe0
>  [   50.796952]  handle_softirqs+0xce/0x3c0
>  [   50.799087]  run_ksoftirqd+0x3e/0x70
>  [   50.800197]  smpboot_thread_fn+0x133/0x290
>  [   50.802320]  kthread+0x115/0x220
>  [   50.804984]  ret_from_fork+0x17a/0x1d0
>  [   50.806920]  ret_from_fork_asm+0x1a/0x30
>  [   50.807799]  </TASK>
> 
> Fix this by only printing the warning once the scheduler is fully
> registered.
> 
> Fixes: 5c48d88fe0049 ("sched_ext: deprecation warn for scx_bpf_cpu_rq()")
> Cc: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.18.

Thanks.

-- 
tejun
