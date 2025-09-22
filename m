Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695B223DD0;
	Mon, 22 Sep 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528566; cv=none; b=qwIggl4Jw3gFhXOKpqpAWeeJcs9sC2sIYoub91m0sh73uxim3P/AldM5IgC3bKpCygsmIXFSLjVeLDfUHjD6ziAWzRPSWnVPejU0T8nYuhL0et49yFFvmLdKhIta8mM8KVo/NW3fTp9DtZJqg65Pm/hOgI0kJb5RVsiMmqCKR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528566; c=relaxed/simple;
	bh=tFJAYx8iCRO4IuHF43fqatmMtKS0XzHqlTjrG4E9mCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2V1qpXh2+we+LpeAZG++U+FFLyLG4LfEgT0C/YQqx/gorR3/Ftv8YhHPsU4jHtYZ190ZF0JlEO0yoxklApslWQQ2v+v8hCjZAS/A+3wvxNZHu35D2KUSwzJOTrc8VOOipH0iDUyVSpYfJ6KrPg9yw5SbtM17CxRusYxeHm4p6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rEl1MSWl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rEl1MSWl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PoVV++hQZ1kQ8uCI68ntdXi9N0or6tZseUbNVH5Dgi8=; b=rEl1MSWlH/A2cXBofngXg0hX6y
	3cyUT/XiP0MDlIp0RCkabmIz7FbhDp/S90LWxm81tEVDAj3joZWRnMm0ftN9C0fD3tp6irof0lReo
	Enh5Zcl//CRDev9rlb8fDv8AuE8w8jxCn5FssezDS+6DuGefJtx01fDVR5C2HZrLJr1R5vsKpPB1E
	zOE7C2atmtfXMEI4mQAOPDeUw73StTICjRXhj/ab1/wDfsWV4iYGMKt9ZkZWheJCH6GQ4zqTCJsi5
	8rXTLqlC6wfUrczb+mb2KkHVzMYaTJRq1MJq/VAjMHILSdK6hUMtScNmb1CP107FX4AufPc+ic8vE
	6uS6egKA==;
Received: from [106.101.10.220] (helo=[192.168.126.21])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1v0bbj-00Fed9-Ft; Mon, 22 Sep 2025 10:09:11 +0200
Message-ID: <0c49ca67-a105-48d9-a848-39996e0cf467@igalia.com>
Date: Mon, 22 Sep 2025 17:09:04 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: idle: Handle migration-disabled tasks in BPF
 code
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250920132621.16263-1-arighi@nvidia.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20250920132621.16263-1-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is a nice catch. Looks good to me.

Acked-by: Changwoo Min <changwoo@igalia.com>

On 9/20/25 22:26, Andrea Righi wrote:
> When scx_bpf_select_cpu_dfl()/and() kfuncs are invoked outside of
> ops.select_cpu() we can't rely on @p->migration_disabled to determine if
> migration is disabled for the task @p.
> 
> In fact, migration is always disabled for the current task while running
> BPF code: __bpf_prog_enter() disables migration and __bpf_prog_exit()
> re-enables it.
> 
> To handle this, when @p->migration_disabled == 1, check whether @p is
> the current task. If so, migration was not disabled before entering the
> callback, otherwise migration was disabled.
> 
> This ensures correct idle CPU selection in all cases. The behavior of
> ops.select_cpu() remains unchanged, because this callback is never
> invoked for the current task and migration-disabled tasks are always
> excluded.
> 
> Example: without this change scx_bpf_select_cpu_and() called from
> ops.enqueue() always returns -EBUSY; with this change applied, it
> correctly returns idle CPUs.
> 
> Fixes: 06efc9fe0b8de ("sched_ext: idle: Handle migration-disabled tasks in idle selection")
> Cc: stable@vger.kernel.org # v6.16+
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>   kernel/sched/ext_idle.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 942fd1e2ed44c..e8ca71cbd0d47 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -880,6 +880,32 @@ static bool check_builtin_idle_enabled(void)
>   	return false;
>   }
>   
> +/*
> + * Determine whether @p is a migration-disabled task in the context of BPF
> + * code.
> + *
> + * We can't simply check whether @p->migration_disabled is set in a
> + * sched_ext callback, because migration is always disabled for the current
> + * task while running BPF code.
> + *
> + * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) respectively
> + * disable and re-enable migration. For this reason, the current task
> + * inside a sched_ext callback is always a migration-disabled task.
> + *
> + * Therefore, when @p->migration_disabled == 1, check whether @p is the
> + * current task or not: if it is, then migration was not disabled before
> + * entering the callback, otherwise migration was disabled.
> + *
> + * Returns true if @p is migration-disabled, false otherwise.
> + */
> +static bool is_bpf_migration_disabled(const struct task_struct *p)
> +{
> +	if (p->migration_disabled == 1)
> +		return p != current;
> +	else
> +		return p->migration_disabled;
> +}
> +
>   static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>   				 const struct cpumask *allowed, u64 flags)
>   {
> @@ -922,7 +948,7 @@ static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_f
>   	 * selection optimizations and simply check whether the previously
>   	 * used CPU is idle and within the allowed cpumask.
>   	 */
> -	if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {
> +	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
>   		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
>   		    scx_idle_test_and_clear_cpu(prev_cpu))
>   			cpu = prev_cpu;

