Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7C28E0F
	for <sched-ext@lists.linux.dev>; Mon, 18 May 2026 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111945; cv=none; b=l2hkaugJmEID9BrEemZQ0TWqzTHiRIxu9iIO2RntbcDmjpLEVv+UZvyvG5+eQgdoEP1vQYTlVzDcf3kecnpV1cPPxz+gZPH2pWg0mENAILzOjutRbyBubfhlTOUcNt/zghPJuHeFrCES5CyJifbhCvzbzcEhDnq18Tboh4kZWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111945; c=relaxed/simple;
	bh=K9Td6XC3NkbWMFETK3EHBOTnNWbw2/n1OVoMTf5K5d0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t/z47wIs6ahac3Rik+dH4KzeyS09Ent2hnPBH4YYyo0EXVcNUw2A2nqcswPKSkFxIUKX/5dLhTxMc0kqQcOjl5veyNkKOYnACLyNS7MpsbmrOgIpxGA05cKbTrwemkEFB5X6b3xkQuC9BztmuQJU645hsAnTzS+SArceuD+fMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFmSFide; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFmSFide"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9ADC2BCB8;
	Mon, 18 May 2026 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111945;
	bh=K9Td6XC3NkbWMFETK3EHBOTnNWbw2/n1OVoMTf5K5d0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jFmSFidei8cbpOVf/vid87XWrwKyCKNR3fG4ywLSY5qn3qYQSQMDAkpiF4xs5Mg/a
	 XZEDomxFjIls3ijummjAa9XbmdXrvTA+2M1jz2N5lcBk5U1Vt+K0uf0rXu7Lmadszw
	 igBsUQSjLPIoWmpiNVXhGebDQHIQjGBxuxG5qDy0+YyWSnn2ZKciSEUCtptOQywAzX
	 EfA5w9Z5a4Bdq3CKM5vYJFeP9E9oIQTswEHod31RqmbOjUbZnR1CP5eGXf+2hImyS5
	 F0bQXzhonGZsak6jlQwbeR00YCBdjEASgHkrF8BYS2Kycq/BiGo4q2dvvYM9U3G9BX
	 YXXJ0BXN//23A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] sched_ext, rcu: Upgrade RCU stall paths to
 report cpumask of stalled CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260518131311.1170786-3-yphbchou0911@gmail.com>
References: <20260518131311.1170786-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 13:45:44 +0000
Message-Id: <20260518134544.ED9ADC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Dynamic memory allocation in RCU stall reporting paths introduces =
deadlocks and degrades diagnostic reliability.
--

commit 97fc58777bb71d599b2d82e880aa479bdea14d1d
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: sched_ext, rcu: Upgrade RCU stall paths to report cpumask of stall=
ed CPUs

This commit updates the RCU stall reporting paths to thread a cpumask throu=
gh
panic_on_rcu_stall() and scx_rcu_cpu_stall() to capture and report all stal=
led
CPUs. It dynamically allocates the mask using zalloc_cpumask_var() with
GFP_KERNEL in the expedited path and GFP_ATOMIC in the normal stall path.

> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 82cada459e5d0..6199ca3cfb7d7 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h

[ ... ]

> @@ -659,23 +662,28 @@ static void synchronize_rcu_expedited_wait(void)
> =20
>  	for (;;) {
>  		unsigned long j;
> +		cpumask_var_t stalled_mask;
> +		bool have_mask;
> =20
>  		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
>  			return;
>  		if (rcu_stall_is_suppressed())
>  			continue;
> =20
> +		have_mask =3D zalloc_cpumask_var(&stalled_mask, GFP_KERNEL);

Since callers of synchronize_rcu_expedited() might hold arbitrary sleepable
locks, can this GFP_KERNEL allocation cause an AB-BA deadlock if the system
enters direct memory reclaim and attempts to acquire those same locks?

Additionally, if the allocation fails due to memory exhaustion (which is a
common cause of RCU stalls), this falls back to cpu_none_mask. This drops
the stalled CPU list exactly when diagnostic information is most needed.

Would a pre-allocated static mask be safer for these critical diagnostic
paths?

[ ... ]

> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b67532cb87705..b256095204184 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h

[ ... ]

> @@ -645,6 +647,8 @@ static void print_other_cpu_stall(unsigned long gp_se=
q, unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
> =20
> +	have_mask =3D zalloc_cpumask_var(&stalled_mask, GFP_ATOMIC);

When CONFIG_CPUMASK_OFFSTACK=3Dy is enabled, this dynamically allocates mem=
ory.

If the stalled CPU is stuck holding a memory allocator lock like a slab node
lock, will the detector CPU spin indefinitely trying to acquire that same
lock, entirely suppressing the stall warning and deadlocking the system?

Also, if this GFP_ATOMIC allocation fails, it emits a page allocation failu=
re
warning before nbcon_cpu_emergency_enter() is called.

If the stalled CPU happens to hold the console lock, could this standard
printk path deadlock the reporting CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518131311.1170=
786-1-yphbchou0911@gmail.com?part=3D2
