Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB64301037
	for <sched-ext@lists.linux.dev>; Thu,  4 Sep 2025 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991710; cv=none; b=YqjUmqZWysQUYzGx0YNz3+B/eccNAXtQmuzXMUcb3j/c4EXokDW0jciL/gdHAOs5QP76cagt7prAQeOIA9/iwf1zietc6jSYnFsbN72MMqS0pfmrnoVjtkdKt4Et+EhcMPgBx84dTEA0TAvJrpLEQEUBqvpIrh9WbogdzEjbLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991710; c=relaxed/simple;
	bh=yuK2F22uNiu3WpPR/1wG4I0Pa9KpQmCvCZIlxl4EiVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tONoLju5s9DMRaZim2in4JNNyVZ1EfOLPuAJ0kA6OB8LYAhwhgZVi9NANbonTHb2rku9gH2GMs3Y5RPbVQIZaBYa8skk6bMbI5VR3uMhJQrxKF5wuceT0wRX35cj+eTf+kIjfVbFBeNIbvndc3/ON273qiKoFko2DuU5wqO83Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C84F1756;
	Thu,  4 Sep 2025 06:14:59 -0700 (PDT)
Received: from [10.1.26.85] (e127648.arm.com [10.1.26.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7213F6A8;
	Thu,  4 Sep 2025 06:15:06 -0700 (PDT)
Message-ID: <3dae6610-7a1f-459d-8280-3c8d00117495@arm.com>
Date: Thu, 4 Sep 2025 14:15:05 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Fix NULL dereference in
 scx_bpf_cpu_rq() warning
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Jake Hillion <jakehillion@meta.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250904125522.561737-1-arighi@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250904125522.561737-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 13:55, Andrea Righi wrote:
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
>  		printk_deferred(KERN_WARNING "sched_ext: %s() is deprecated; "
>  				"use scx_bpf_locked_rq() when holding rq lock "
>  				"or scx_bpf_cpu_curr() to read remote curr safely.\n", __func__);
>  		sch->warned_deprecated_rq = true;
>  	}
> +	rcu_read_unlock();
>  
>  	return cpu_rq(cpu);
>  }

Ah yes of course.
I guess the other ones that can happen during the actual lifetime
of the scheduler have a likely(sch) around it, which we could
add here as well.
