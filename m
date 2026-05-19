Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B7B343892
	for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213152; cv=none; b=f0Hg/w11NeqhCElRgskZ7yGbe7gcxI0gF/wCJksKdqO/UG8pbePDYoUSWGmP6wLbc/3MMsz+j/ax5H40PaXp6/MB3j6xq6AkGWEgcbA86p3NoQ5rUseKuNF+KP4VyvL6d6fFELYzc8jpknYmjSC4o+snPlG42BunpwNMyVLn6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213152; c=relaxed/simple;
	bh=PLC0L7SsHhTW77HiaeMjx7oo+/CgDFAVJttg9jWN8gk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jiTKkU5TwIiLcgDD+b7zO8uWUypNJyYnwZydfU12u9ZQpWsvJ7mn3HINKFFmwAfXUUGRSxBq8dXgtg6FU/rlFiGAJc4SH5Tv5rceY5d2QYIjayejrR9YXgkBmrXkDXfZs7kgwesZoj4/2EcgTD04GGy524ZQ+1l09NM2vk5h+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8hX2oFS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8hX2oFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520A0C2BCB3;
	Tue, 19 May 2026 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779213151;
	bh=PLC0L7SsHhTW77HiaeMjx7oo+/CgDFAVJttg9jWN8gk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=R8hX2oFS+C4zMk+Dqa8FVizhiEwO/MKxM68gI0Yj1Z4Xv9i5f7UwW8SB6zmxlFPKL
	 8euRtO1nMG2oHUlReXTOHSfeXCa2lZBjSs3l7tfdoITi3oCVXZxQg25QTKECFkGwpT
	 fncQjQgPzxNpu5CFofpuqZHmX7bBwyHbotLlsoniR6u2PBPlHgo4ECYOspjLLGBaMm
	 p94iZOaqVxuGWu2diWDfLZBK+FBUY1ydcesLZeckvukC1TCU2l0HWG9VdfwGyC2TWX
	 uxLuqZ5yK4kFh3D+dmg7HpZgy192pPbqOQP4lVhYoxcCxxViqLWW6d+4HimJU4x9o9
	 Pdi4jGxxdBCLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260519171745.1551340-3-yphbchou0911@gmail.com>
References: <20260519171745.1551340-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 17:52:29 +0000
Message-Id: <20260519175231.520A0C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Dynamic memory allocation (`GFP_ATOMIC`) in the RCU stall detector=
 path can cause a hard deadlock, masking the system hang instead of reporti=
ng it.
--

commit ffd18e78b03bfaba9705c61803e8bd0bb6325d38
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

sched_ext, rcu: Upgrade RCU stall paths to report cpumask of stalled CPUs

This commit updates the RCU stall paths to capture all stalled CPUs in a
cpumask rather than just the detecting CPU. The cpumask is passed through
the stall handlers and dumped first during a sched_ext state dump to avoid
losing the stalled CPUs to truncation.

> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 82cada459e5d0..b8f4ca984c1c9 100644
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
> +		have_mask =3D zalloc_cpumask_var(&stalled_mask, GFP_ATOMIC | __GFP_NOW=
ARN);
> +

[Severity: High]
Could this allocation cause a hard deadlock during an RCU stall?

If CONFIG_CPUMASK_OFFSTACK=3Dy is set, zalloc_cpumask_var() performs a dyna=
mic
memory allocation via kmalloc(). If the stalled CPU is stuck holding a memo=
ry
allocator lock (such as zone->lock or the SLUB list_lock), the detecting CPU
will deadlock trying to acquire it.

Additionally, GFP_ATOMIC includes __GFP_KSWAPD_RECLAIM, which can wake up
kswapd and acquire scheduler locks (pi_lock, rq->lock). If the stalled
CPU holds one of these scheduler locks, it could also deadlock here.

This would completely prevent the RCU stall warning from being printed
and mask the root cause of the hang. Would it be safer to use a
statically preallocated cpumask for stall reporting?

>  		nbcon_cpu_emergency_enter();
> =20
>  		j =3D jiffies;

[ ... ]

> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b67532cb87705..90d6eaf1b8415 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h

[ ... ]

> @@ -645,6 +647,8 @@ static void print_other_cpu_stall(unsigned long gp_se=
q, unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
> =20
> +	have_mask =3D zalloc_cpumask_var(&stalled_mask, GFP_ATOMIC | __GFP_NOWA=
RN);
> +

[Severity: High]
Can this dynamic allocation also trigger a hard deadlock?

print_other_cpu_stall() executes in a critical diagnostic context with
IRQs disabled (enforced by lockdep_assert_irqs_disabled()). Similar to
the issue in synchronize_rcu_expedited_wait(), allocating memory here
might deadlock if the stalled CPU holds a lock required by the memory
allocator or scheduler.

>  	nbcon_cpu_emergency_enter();
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519171745.1551=
340-1-yphbchou0911@gmail.com?part=3D2
