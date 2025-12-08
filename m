Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3B3B8D7E
	for <sched-ext@lists.linux.dev>; Mon,  8 Dec 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765193367; cv=none; b=AiVqQctGx2aVbpCHl4tkziWIYXIQd3DwuNeRoWCzT83a7I8BJxezS95TOI7umCF2vKbGTADdIG9KycxOMeTrRaY7PG4qY9AxdIHtI7wWNiAcFczDwkpr6MiROhx4ir85CbzW1FdYBiurPsCB+eUpcyVZhwJNf8HlDgF3uNI1lOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765193367; c=relaxed/simple;
	bh=gN7jRqir5oJVSskYzTXPxMhiR0PaTuh6jn7AZsrWhh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWGXSVWQuL9j+zVakeQy6CwuQTWHhSh7BL90HeUpwnKzgrIa/pQBDr+nQQYnoU7SNRAlE1RAbC+4yjDyeIr4MROXbQUBVRPXnsQiuISDTWPyZ2DV2jGlck1VAUS/GVqcduaNK14siXNNFwh1UGinQ1mwuNuw4g3E9ry9YUmDXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31AD21691;
	Mon,  8 Dec 2025 03:29:18 -0800 (PST)
Received: from [10.1.31.65] (e127648.arm.com [10.1.31.65])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40EB93F762;
	Mon,  8 Dec 2025 03:29:24 -0800 (PST)
Message-ID: <88d4bad3-213c-4486-b56f-da49ad458924@arm.com>
Date: Mon, 8 Dec 2025 11:29:22 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Fix lockdep warnings in the ops_dump_init()
To: Zqiang <qiang.zhang@linux.dev>, tj@kernel.org, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251208112320.27144-1-qiang.zhang@linux.dev>
 <20251208112320.27144-2-qiang.zhang@linux.dev>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251208112320.27144-2-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/25 11:23, Zqiang wrote:
> For builts with PREEMPT_RT=y kernel, the dump_lock convert to
> sleepable rt-spinlock and not disable-irq, the following lockdep
> warning will appear:
> 
> WARNING: CPU: 3 PID: 47 at kernel/sched/ext.c:4130 ops_dump_init+0x60/0xa0
> Modules linked in:
> CPU: 3 UID: 0 PID: 47 Comm: irq_work/3
> RIP: 0010:ops_dump_init+0x60/0xa0
> Call Trace:
> <TASK>
> scx_dump_state+0x1091/0x1620
> ? __schedule+0xf1c/0x3ec0
> ? rcu_is_watching+0x19/0xb0
> ? __pfx_scx_dump_state+0x10/0x10
> ? kvm_sched_clock_read+0x15/0x30
> ? __lock_acquire+0x98b/0x1ae0
> ? __this_cpu_preempt_check+0x17/0x20
> ? insn_get_modrm+0x107/0x6e0
> scx_error_irq_workfn+0xeb/0x120
> irq_work_single+0x113/0x260
> irq_work_run_list.part.7+0x44/0x70
> run_irq_workd+0x6b/0x90
> ? __pfx_run_irq_workd+0x10/0x10
> smpboot_thread_fn+0x34c/0xa50
> ? trace_preempt_on+0x54/0x120
> ? __pfx_smpboot_thread_fn+0x10/0x10
> kthread+0x411/0x8a0
> ? __pfx_kthread+0x10/0x10
> ? rt_spin_unlock+0x9f/0x210
> ? __pfx_kthread+0x10/0x10
> ret_from_fork+0x406/0x500
> ? __switch_to_asm+0x33/0x70
> ? __pfx_kthread+0x10/0x10
> ret_from_fork_asm+0x1a/0x30
> </TASK>
> 
> This commit therefore convert dump_lock to raw spinlock.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  kernel/sched/ext.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 59fa391636c7..2e19e3689f1c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4235,7 +4235,7 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
>  
>  static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
>  {
> -	static DEFINE_SPINLOCK(dump_lock);
> +	static DEFINE_RAW_SPINLOCK(dump_lock);
>  	static const char trunc_marker[] = "\n\n~~~~ TRUNCATED ~~~~\n";
>  	struct scx_sched *sch = scx_root;
>  	struct scx_dump_ctx dctx = {
> @@ -4251,7 +4251,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
>  	char *buf;
>  	int cpu;
>  
> -	spin_lock_irqsave(&dump_lock, flags);
> +	raw_spin_lock_irqsave(&dump_lock, flags);
>  
>  	seq_buf_init(&s, ei->dump, dump_len);
>  
> @@ -4375,7 +4375,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
>  		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
>  		       trunc_marker, sizeof(trunc_marker));
>  
> -	spin_unlock_irqrestore(&dump_lock, flags);
> +	raw_spin_unlock_irqrestore(&dump_lock, flags);
>  }
>  
>  static void scx_error_irq_workfn(struct irq_work *irq_work)

This is already part of Tejun's cgroup sub-scheduler support series:
https://lore.kernel.org/lkml/20250920005931.2753828-39-tj@kernel.org/
