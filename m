Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5B3F8238
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496336; cv=none; b=pTviGri/yWxw1IKt2E+nQJ7kzR2Caf2pR0tV9p4DDfUcelzGwJYuw68zJrdHz0C+ZbSbdYCJ94bwTLOjkt34sXjC3zHxWATsbvj6BSMXn4wTS/9S+U5P6I6WgJJvQzJL/K1VgCsl+I3bKiCKYyOxw3xvYOP+r5VFmfFhs5ivMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496336; c=relaxed/simple;
	bh=QzWEhFcKhO0e4qRJ/LHEvEK4BtbdKWSWXO9zVn4Fncg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f4Iu1ABBvq6tkPCjSZ7S1iEq/R+NRxpenfEtGXX+rocch8WD6YjaQrZVoVNqUpFDRcI0rjrgBBVRPNswlcLdVBbYgkB7hMNZM/gAIE9ngYK1QgMfYJ0+DOqde1VvwNu6AvdFoPv/1/M+8w4zS2HPBIjbaxJiIcDMB6RLuJCRh4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POe3SoMn; arc=none smtp.client-ip=209.85.208.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POe3SoMn"
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-69e70c286ecso1006607a12.0
        for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785496331; x=1786101131; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pD8k9zobesqtu4t2Jn8mMkH3qczBbKJ7iRqFWm6pnxI=;
        b=POe3SoMnzBqj2llVXRFt6zra/uJXQFRuzlD4uJkxvgo9czNdMIE655Lrwt6jCrnYy+
         ZAONevRUwHAi/OkxgK3WpQjLsHuN9LWCqxRsW99/HEUuzMRKP1XzwP1kmYVP0u0IG9Js
         U79lv/B1lQJ3liBS4R2MnIAazIBbJhOZwWi9XzJ6FF3zjJgNA0/hnOtWalmrnthmQtch
         7DMHSAlRtGbtIO3bEWwdB65GYW5+3iEi1yMZ4YrCpidbSYoLjeJ2oZ/LiA62hT9VWfBq
         RSZD3wckjcRbvnvErOYlFy1EMrkjPxe9JCn+F6bA0fNN4y7XyAxHuYIVRsmRKieDobzR
         ax2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785496331; x=1786101131;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pD8k9zobesqtu4t2Jn8mMkH3qczBbKJ7iRqFWm6pnxI=;
        b=Ehr4xJTDcCO53evSAPsaeyshjHMwDQ1FUglMGODELVZ7qfTRatf6xAnUJDD50v1+B5
         c6cpHLBMG+0B63DGBjnX65thslmeoN/Yl/x/TVLZP2n/MnFpAJ8EOtMl6ShB1IJ7Enlp
         KfuCXYVhsHpgVXTOehZ+jI/DaXP1YOp9x2IkU4e2NWmNliieBAfd1uVLYemI1YP48WG4
         kH4njCXQua61KO06V/2VaEIXTyeQNoxJs9N2xCUlB0jZxyuY+ASr1DXa51bNUkiKe0im
         SixmvHST+tcVS4rLCZgobnjTVv70SsApyiuBkeU4O6xITyA00wO4SZzdOybGhALp1riG
         loOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBR7LVLLAp9/5R0Ibe6ZVSyCmQn6BH/kk9vvG1UZo4Yrdn5bM43gH5LtHQr1E7KEsWb5O27APimP4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxGIdNpOg1vM9JsWuabX4uPuWtUinNQmB8E3T9XjdJLeeBCFGUD
	zDBy5DIe9bgebYKUZjDsqWuoeuQrsTo0lBZ5nDMMXd9wOuDj0mmo6H/5OEH6rL+Q0ehzF154JT/
	HrIkRVlUJmwCO3w==
X-Received: from wmor3.prod.google.com ([2002:a05:600c:4583:b0:493:f87d:7786])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:21d0:b0:698:de64:6ab3 with SMTP id 4fb4d7f45d1cf-6a0984e02a9mr773845a12.12.1785496330523;
 Fri, 31 Jul 2026 04:12:10 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:12:09 +0000
In-Reply-To: <20260731090334.2911948-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260731090334.2911948-1-arighi@nvidia.com> <20260731090334.2911948-3-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DKCPMDMRE6FN.3EII6EE13O4SY@google.com>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Make allowed_cpus idle
 validation race-free
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Fri Jul 31, 2026 at 8:59 AM UTC, Andrea Righi wrote:
> A remotely selected CPU can be re-advertised as idle by an idle-to-idle
> re-pick before the BPF program validates the selection. Checking that
> the selected CPU remains absent from the idle mask is therefore
> inherently racy.
>
> Validate the stable local invariant instead: a CPU running a non-idle
> scheduling context in ops.select_cpu() must not be advertised as idle.

That invariant sounds like it should hold in many contexts, not just in
ops.select_cpu(). Is there something preventing us from checking it in
ops.enqueue() as well?

> Also validate both the requested domain and task affinity for selected
> CPUs.
>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  .../selftests/sched_ext/allowed_cpus.bpf.c    | 43 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> index 35923e74a2ec3..411a7edcb9605 100644
> --- a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> +++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> @@ -15,15 +15,43 @@ UEI_DEFINE(uei);
>  private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
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
> +	if (!curr_is_idle && scx_bpf_test_and_clear_cpu_idle(cpu))
> +		scx_bpf_error("running CPU %d should be marked as busy", cpu);

Could we check a stronger invariant by also checking that the bit in the idle
mask is set if we're running an idle task? We can get the idle cpumask through
scx_bpf_get_idle_cpumask() and check bits without clearing them using
bpf_cpumask_test_cpu().

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
> @@ -42,8 +70,9 @@ s32 BPF_STRUCT_OPS(allowed_cpus_select_cpu,
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
> @@ -71,7 +100,7 @@ void BPF_STRUCT_OPS(allowed_cpus_enqueue, struct task_struct *p, u64 enq_flags)
>  	 */
>  	cpu = scx_bpf_select_cpu_and(p, prev_cpu, 0, allowed, 0);
>  	if (cpu >= 0) {
> -		validate_idle_cpu(p, allowed, cpu);
> +		validate_selected_cpu(p, cpu);
>  		scx_bpf_kick_cpu(cpu, SCX_KICK_IDLE);
>  	}
>  }

Thanks,
Kuba
