Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793439C00E
	for <sched-ext@lists.linux.dev>; Thu, 30 Jul 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424752; cv=none; b=pl5oqRrBSNJgcWr9eRM4Ofnnszv3joOJ9Rccw33V2esrxg+hBcc8VIJH+xCeo4dVYHPL3xfgDvOqr5YBY65pt85kUjP8VvIgTKk3fABFbeF+yR1JDp8myPt9n8XaAhLXWuhwGPTmQ+MAdqybFrETjxg8wZ1fzND/KuOTPpAFEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424752; c=relaxed/simple;
	bh=fd5M9OmbQPhOdWuejOARpFOWjmzeIosCwTAvTgaHhmk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eGYXZE4wBXC5T/fwNo/VyhToerT+Qrx1Xhx6zOfk2yJC6xlx3CSuphn3zwYCBtIt55ApOuN7rSCfoDkYFjC/sH4v448c0l88z4uecEXuQQwkfh0az6U44TjplbsELgZ6JJD6kasf/LANS4/eMEoHiqtntfOHcAbpA7GSsBpHvz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mKLnw95B; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKLnw95B"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso22467685e9.1
        for <sched-ext@lists.linux.dev>; Thu, 30 Jul 2026 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785424749; x=1786029549; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGvleQ6yTArEHiwjmybD+ya8Kg2BrgsCqXa6zgKxiAg=;
        b=mKLnw95BGl4cbn0pfycq4rwg3kjcz90GUgRQeT+VgRbvR7BsPcBlnm7bY9pjEl/Vn/
         A0lEFv5jUklJpja/8HL8Y7HE1GHd0NtgRmQhKm69/t4u1EKGNa1XSKoOEEppgPAUHMDd
         40HlkjU4cx3xB1LNBdEptXWnMnbHqZAm+rHb22Ar0qp5NNYhi8AD7mJhr7HT2qLkx3FX
         AuJnnQ+jLFcp501WRDXDbImKF6nVGhyfaeQhC/e0VKh5VQVLYeweO693nxc2P7+RdQk5
         +eYf4aro3J250wn+hgwMugm8xyKw0pJJwIVWmFoDsEudtdLMg/vrZvwbtUuGC8QN3lWq
         5Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785424749; x=1786029549;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGvleQ6yTArEHiwjmybD+ya8Kg2BrgsCqXa6zgKxiAg=;
        b=mX6ZIY9FcN8FyHgM/t1rlP/DvinKcmRFl9oZtMif0CTlc6fMU9LKu73GqhFGMgQmbB
         GYIlbb3D341aQ0GCUshnATF6emN/SA8vhG3ksIyHV/TsIwJQsR6XxhDA2rBBLZxUxwlt
         yrVZ36jYWViQIttZTenPQLctM7AY5VOaUhIHgNDHibjETWlcYP3GuCOzyoWFN/mJasCV
         88ubjn8GFgEfHSEVMoNE9RkvWjEBhW/gAEWUkOgZxo2kl5eMtibwGZfJd3sYhzJPsQEc
         z+BqAKz40rApjlV99YBf2VYz+30sw42U93i4zH/mJegN0Pd/LuqRAXa5D9nnJ23erP8a
         8RkQ==
X-Forwarded-Encrypted: i=1; AHgh+RoczoDXoNmmjHsHji/cN77JuAF0i+TB+rxDWDwSgRc3XJt/XMZ3ls/tA0pNolkkYiO81fGRNLX1txo=@lists.linux.dev
X-Gm-Message-State: AOJu0YyhsrwlT0K0faOcSgw4cPiFEQldkeMc0/vVidoKStvfx5GuCnH+
	ImOsAvxmHcI8GixSsUxdpD5N+3adKrm1qoocDZj9I+cvPJTMRWo1TlJ9WBZPj1LqWXkmNDhtShv
	Edfbxw5nXJ3zNmA==
X-Received: from wmbhu21.prod.google.com ([2002:a05:600c:a295:b0:493:b636:4ee9])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c054:b0:495:4a34:16d9 with SMTP id 5b1f17b1804b1-49800ebec79mr27809245e9.31.1785424749025;
 Thu, 30 Jul 2026 08:19:09 -0700 (PDT)
Date: Thu, 30 Jul 2026 15:19:08 +0000
In-Reply-To: <20260726064754.378671-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260726064754.378671-1-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DKC06NICM5DQ.9OON50GZUAN3@google.com>
Subject: Re: [PATCH sched_ext/for-7.2-fixes] selftests/sched_ext: Make
 allowed_cpus idle validation race-free
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Sun Jul 26, 2026 at 6:47 AM UTC, Andrea Righi wrote:
> A remotely selected CPU can be re-advertised as idle by an idle-to-idle
> re-pick before the BPF program validates the selection. Checking that
> the selected CPU remains absent from the idle mask is therefore
> inherently racy.
>
> Validate the stable local invariant instead: a CPU running a non-idle
> scheduling context in ops.select_cpu() must not be advertised as idle.
> Also validate both the requested domain and task affinity for selected
> CPUs.
>
> Moreover, bootstrap the test by running a task on every active CPU while
> ops.running() refreshes the initial idle state. This ensures that the
> idle masks are properly initialized before strict validation begins.
>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  .../selftests/sched_ext/allowed_cpus.bpf.c    | 51 ++++++++++++++++---
>  .../selftests/sched_ext/allowed_cpus.c        | 38 ++++++++++++++
>  2 files changed, 82 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> index 35923e74a2ec3..4a14b05065453 100644
> --- a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> +++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> @@ -13,17 +13,46 @@ char _license[] SEC("license") = "GPL";
>  UEI_DEFINE(uei);
>  
>  private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
> +volatile bool refresh_idle_masks;
>  
>  static void
> -validate_idle_cpu(const struct task_struct *p, const struct cpumask *allowed, s32 cpu)
> +validate_local_idle_state(void)
>  {
> -	if (scx_bpf_test_and_clear_cpu_idle(cpu))
> -		scx_bpf_error("CPU %d should be marked as busy", cpu);
> +	struct task_struct *curr;
> +	s32 cpu = bpf_get_smp_processor_id();
> +	bool curr_is_idle;
>  
> -	if (bpf_cpumask_subset(allowed, p->cpus_ptr) &&
> -	    !bpf_cpumask_test_cpu(cpu, allowed))
> +	bpf_rcu_read_lock();
> +	curr = scx_bpf_cpu_curr(cpu);
> +	curr_is_idle = curr && (curr->flags & PF_IDLE);
> +	bpf_rcu_read_unlock();
> +
> +	/*
> +	 * Unlike a remote selected CPU, the local CPU cannot go through an
> +	 * idle re-pick while this callback is running. If it is running a
> +	 * non-idle scheduling context, it must not be advertised as idle.
> +	 */
> +	if (!curr_is_idle && scx_bpf_test_and_clear_cpu_idle(cpu) && !refresh_idle_masks)

I don't think it matters much in terms of correctness, but to me it would
be more intuitive to read refresh_idle_masks first to ensure we're bootstrapped,
and then check the idle bit.

> +		scx_bpf_error("running CPU %d should be marked as busy", cpu);
> +}
> +
> +static void
> +validate_selected_cpu(const struct task_struct *p, s32 cpu)
> +{
> +	const struct cpumask *allowed = cast_mask(allowed_cpumask);
> +
> +	if (!allowed) {
> +		scx_bpf_error("allowed domain not initialized");
> +		return;
> +	}
> +
> +	if (!bpf_cpumask_test_cpu(cpu, allowed))
>  		scx_bpf_error("CPU %d not in the allowed domain for %d (%s)",
>  			      cpu, p->pid, p->comm);
> +
> +	if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
> +		scx_bpf_error("CPU %d not in the affinity mask for %d (%s)",
> +			      cpu, p->pid, p->comm);
>  }
>  
>  s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
> @@ -42,8 +71,9 @@ s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
>  	 * Select an idle CPU strictly within the allowed domain.
>  	 */
>  	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, allowed, 0);
> +	validate_local_idle_state();
>  	if (cpu >= 0) {
> -		validate_idle_cpu(p, allowed, cpu);
> +		validate_selected_cpu(p, cpu);
>  		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
>  
>  		return cpu;
> @@ -71,11 +101,17 @@ void BPF_STRUCT_OPS(allowed_cpus_enqueue, struct task_struct *p, u64 enq_flags)
>  	 */
>  	cpu = scx_bpf_select_cpu_and(p, prev_cpu, 0, allowed, 0);
>  	if (cpu >= 0) {
> -		validate_idle_cpu(p, allowed, cpu);
> +		validate_selected_cpu(p, cpu);
>  		scx_bpf_kick_cpu(cpu, SCX_KICK_IDLE);
>  	}
>  }
>  
> +void BPF_STRUCT_OPS(allowed_cpus_running, struct task_struct *p)
> +{
> +	if (refresh_idle_masks)
> +		scx_bpf_test_and_clear_cpu_idle(bpf_get_smp_processor_id());

ops.running() doesn't have to run on the same CPU as @p, e.g. when changing
the priority of a task running on a remote CPU. I believe the correct thing
to do here is scx_bpf_test_and_clear_cpu_idle(scx_bpf_task_cpu(p)).

> +}
> +
>  s32 BPF_STRUCT_OPS_SLEEPABLE(allowed_cpus_init)
>  {
>  	struct bpf_cpumask *mask;
> @@ -138,6 +174,7 @@ SEC(".struct_ops.link")
>  struct sched_ext_ops allowed_cpus_ops = {
>  	.select_cpu		= (void *)allowed_cpus_select_cpu,
>  	.enqueue		= (void *)allowed_cpus_enqueue,
> +	.running		= (void *)allowed_cpus_running,
>  	.init			= (void *)allowed_cpus_init,
>  	.exit			= (void *)allowed_cpus_exit,
>  	.name			= "allowed_cpus",
> diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c b/tools/testing/selftests/sched_ext/allowed_cpus.c
> index 093f285ab4bae..eb1708e55982b 100644
> --- a/tools/testing/selftests/sched_ext/allowed_cpus.c
> +++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2025 Andrea Righi <arighi@nvidia.com>
>   */
>  #include <bpf/bpf.h>
> +#include <sched.h>
>  #include <scx/common.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
> @@ -47,14 +48,51 @@ static int test_select_cpu_from_user(const struct allowed_cpus *skel)
>  	return 0;
>  }
>  
> +/*
> + * Run this task once on every CPU while ops.running() repairs the bootstrap
> + * idle state. Once a CPU has been refreshed, subsequent idle transitions keep
> + * its state up to date.
> + */
> +static int refresh_idle_masks(void)
> +{
> +	cpu_set_t original, one;
> +	int cpu, ret = 0;
> +
> +	if (sched_getaffinity(0, sizeof(original), &original))
> +		return -errno;
> +
> +	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
> +		if (!CPU_ISSET(cpu, &original))
> +			continue;
> +
> +		CPU_ZERO(&one);
> +		CPU_SET(cpu, &one);
> +		if (sched_setaffinity(0, sizeof(one), &one)) {
> +			ret = -errno;
> +			break;
> +		}
> +
> +		sched_yield();
> +	}
> +
> +	if (sched_setaffinity(0, sizeof(original), &original) && !ret)
> +		ret = -errno;
> +
> +	return ret;
> +}
> +

This bootstrapping mechanism feels like a bit of a hack.
Couldn't we improve SCX itself to ensure the initial state of the idle masks
is accurate?

I was thinking we could enhance scx_idle_enable() by making it enable idle
tracking (currently idle tracking is controlled by the __scx_enabled static
branch), and then iterating over all CPUs, locking their rq locks and setting
their idle bit based on whether rq->curr == rq->idle. All this would happen
before calling ops.init(), so the BPF scheduler will be guaranteed to have an
accurate idle cpumask. WDYT?

>  static enum scx_test_status run(void *ctx)
>  {
>  	struct allowed_cpus *skel = ctx;
>  	struct bpf_link *link;
>  
> +	skel->bss->refresh_idle_masks = true;
>  	link = bpf_map__attach_struct_ops(skel->maps.allowed_cpus_ops);
>  	SCX_FAIL_IF(!link, "Failed to attach scheduler");
>  
> +	SCX_FAIL_IF(refresh_idle_masks(), "Failed to refresh idle CPU state");
> +	__atomic_store_n(&skel->bss->refresh_idle_masks, false, __ATOMIC_RELEASE);
> +

Won't a WRITE_ONCE() suffice here? test_and_clear_bit() implies a full memory
barrier, so I don't think we need any extra synchronization once the read of
refresh_idle_masks is moved before scx_bpf_test_and_clear_cpu_idle() in
validate_local_idle_state().

>  	/* Pick an idle CPU from user-space */
>  	SCX_FAIL_IF(test_select_cpu_from_user(skel), "Failed to pick idle CPU");
>  

Thanks,
Kuba

