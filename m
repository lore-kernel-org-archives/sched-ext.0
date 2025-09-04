Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15E31354F;
	Thu,  4 Sep 2025 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007576; cv=none; b=ZLIJ+7F+MezlR8AsFIuDlfcHLyq90Ebz+9pgob1v4m4SkfVY3LBz6na1Bv+8EwmYI4nHhdHx5XdABraBMmPTCDcX1KPmDaEV38qeHSbZjZFdk1j0XZBjMhbbr7SwEDSnvTypxUpAtFxov/nXWs8O47R2NQqgO0Zrxx5ta0c/dVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007576; c=relaxed/simple;
	bh=ZMi8STu4rwUVTI5LI7m6pQhVZR8qQSyjjKTnEsVSHL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiCeSskRulFHDP54V10gM44gEs6NKergr+0kQMCQ2odhthULqkCDIeXMhKNTe70v2rS/QNIs7XvTKupKuBCdzhl9zCjGotmOPNqRyigd+tTwLIUveqPExGcqgBSFpYYl0ufudNFNKV0XgpuYJ8gDaHfYwqP6AOiHvVdL4Aer1wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exGMUlsp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exGMUlsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8341DC4CEF0;
	Thu,  4 Sep 2025 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757007575;
	bh=ZMi8STu4rwUVTI5LI7m6pQhVZR8qQSyjjKTnEsVSHL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exGMUlspUpPITgayvmKL9lVku8eR2I9HlnZZwKCfT75tyBtCC+GYElaN/4vXKkfLI
	 pfDZexwqQnX0j+bfX8442jvFv8aSQZ2R6+kj6ScIgqHTNRT3Cd9K9x6tAm1dXlvMgx
	 SsnHabMld4s3aDl/vov+26Hw1UJEmqTV7nqykSeAxIxfZ0VSSfqoidapN0hMwaT/dY
	 n406TYTcz+NLe8Aq88SqwewnyQ7fTPjXVzonAi5MFmAD9wssdTcEVScxm+sL8JWcBN
	 eGgZxmtQY7YKBWeq6uzzb1skrgQnh4EkOlnYJ/f3rh2xfQKWfTFiiPJW4Aqex0rvBD
	 uW6RxF+f34i3A==
Date: Thu, 4 Sep 2025 07:39:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Jake Hillion <jakehillion@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Fix NULL dereference in
 scx_bpf_cpu_rq() warning
Message-ID: <aLnO1r5X265Knl0W@slm.duckdns.org>
References: <20250904125522.561737-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904125522.561737-1-arighi@nvidia.com>

On Thu, Sep 04, 2025 at 02:55:22PM +0200, Andrea Righi wrote:
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
> ---
>  kernel/sched/ext.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 489462290142a..04fefd34db238 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6362,17 +6362,20 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
>   */
>  __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>  {
> -	struct scx_sched *sch = scx_root;
> +	struct scx_sched *sch;
>  
>  	if (!kf_cpu_valid(cpu, NULL))
>  		return NULL;
>  
> -	if (!sch->warned_deprecated_rq) {
> +	rcu_read_lock();
> +	sch = rcu_dereference(scx_root);
> +	if (sch && sch->warned_deprecated_rq) {

This drops ! from the condition.

Thanks.

-- 
tejun
