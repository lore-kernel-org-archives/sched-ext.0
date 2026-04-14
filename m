Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C72F28FF
	for <sched-ext@lists.linux.dev>; Tue, 14 Apr 2026 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187146; cv=none; b=sIkyCYOehxkiRSZUgCdyWqLHgCDIl4rteqQEH2AepOT1HhZ+noWDT/LBCSM/WUg2o1m+n0zWkj+7173Klxv8t+PnqFu8nBPDyhKAKYYUDoFNLwx8YglJNm+731wi1Z1jejTG/Z+U0vv10Nv4JBiu4RY5JGEdSOzVZfzG2L3458U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187146; c=relaxed/simple;
	bh=0kKmCuAycD4RClSEXdDOKo82lsxJ2n0hhLnnNHmRuOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHXYnGsUFUJpY+YcXjdkX8lt/kaR8pwdXlzW5G4MPZJZxPGW5ivgPrWympOTpp6PFW6EbQJ6svg9YKTX3k7ra0E+vMsZM+gsN8YBt2sleUxkR+ZNp+y5Lj4VwUkJ7AmO6Es+rg90bibMBGrCCOLv+0CPFQA4YQFUWP9TeLmvFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2dYe1uQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2dYe1uQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10933C19425;
	Tue, 14 Apr 2026 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776187146;
	bh=0kKmCuAycD4RClSEXdDOKo82lsxJ2n0hhLnnNHmRuOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2dYe1uQ5xA9aH5TgHkgMJsbz13bhRJwCbDZMxRYb+W3dKPuBPUQ3BOdLuT17IuEb
	 0neSG/iUvZ5wO9JVdjnDTlGxSm/wS6V6B282Jqm3+ECoeB0XwJzDmgiQEe3DV8JLDf
	 0NngCwYd17eZo9/Umoma1d91uaDH+ONKZpEIA2XzHw2bifnuC/g3ewAw1buHY6pk6J
	 TGXm2X2OKtNAssXKK7T6jINkd4BZFlBcQForKzBy5Lhb4pOD9707JsxUFldcsLfgWh
	 MQ+MKjFsRZTKmGVQYQLVGmm+rCj1vhb1kpxHFuunrrmvmWV+1qWTLRikzqmS7Z7qMS
	 dcD5kjRDWE+7A==
Date: Tue, 14 Apr 2026 07:19:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Handle pinned tasks in scx_central
Message-ID: <ad53CFXVxTha3EQu@slm.duckdns.org>
References: <20260413110453.357198-1-yphbchou0911@gmail.com>
 <DHS4U9BLRCPG.1S9E4BT1UIHQT@google.com>
 <s3khi4ec55rog6tgbgxip5skqjdhimcemhwzf3h7pbbvxslnu7@5r4v7jbv4w7z>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s3khi4ec55rog6tgbgxip5skqjdhimcemhwzf3h7pbbvxslnu7@5r4v7jbv4w7z>

Hello,

On Tue, Apr 14, 2026 at 11:45:59AM +0800, Cheng-Yang Chou wrote:
> diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
> index 4efcce099bd5..67b160a7ce18 100644
> --- a/tools/sched_ext/scx_central.bpf.c
> +++ b/tools/sched_ext/scx_central.bpf.c
> @@ -96,7 +96,13 @@ s32 BPF_STRUCT_OPS(central_select_cpu, struct task_struct *p,
>  	 * disturbing other CPUs. It's safe to blindly return the central cpu as
>  	 * select_cpu() is a hint and if @p can't be on it, the kernel will
>  	 * automatically pick a fallback CPU.
> +	 *
> +	 * For tasks pinned to a single CPU, return the current CPU to avoid
> +	 * an unnecessary fallback.
>  	 */
> +	if (p->nr_cpus_allowed == 1)
> +		return scx_bpf_task_cpu(p);
> +

This isn't necessary. select_cpu() isn't called if nr_cpus_allowed == 1.

> @@ -107,12 +113,17 @@ void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
>  	__sync_fetch_and_add(&nr_total, 1);
>  
>  	/*
> -	 * Push per-cpu kthreads at the head of local dsq's and preempt the
> -	 * corresponding CPU. This ensures that e.g. ksoftirqd isn't blocked
> -	 * behind other threads which is necessary for forward progress
> -	 * guarantee as we depend on the BPF timer which may run from ksoftirqd.
> +	 * Push tasks pinned to a single CPU or with migration disabled at
> +	 * the head of local dsq's and preempt the corresponding CPU. This
> +	 * ensures that e.g. ksoftirqd isn't blocked behind other threads
> +	 * which is necessary for forward progress guarantee as we depend on
> +	 * the BPF timer which may run from ksoftirqd.
> +	 *
> +	 * p->nr_cpus_allowed is not updated until migrate_disable_switch()
> +	 * runs during context switch, which happens after ops.enqueue(). Check
> +	 * is_migration_disabled() directly to catch tasks in this window.
>  	 */
> -	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
> +	if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {

Let's not expand the condition here. This is to guarantee forward progress
of the scheduler itself.

> @@ -155,6 +166,13 @@ static bool dispatch_to_cpu(s32 cpu)
>  		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {

Instead, can you expand the condition above to "if this task can't run on
the target CPU for whatever reason"?

Thanks.

-- 
tejun
