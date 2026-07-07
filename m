Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001F28002B
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384416; cv=none; b=C4OAPONFCj7QXRTqTjUP6Uj4UoleXKq8bBye/SQNlwR+3PkNa0Qqs2ppErBgazg7oLjBUu2kxGgdxo+o+fYzcLqC21oUpYRNre4TCaunHvGsKGaD/I8jfDQADe/pZ4G0z3P+tpUyz38mwTdSZVRpbbeXBT2H4dl8IBzSwPuzNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384416; c=relaxed/simple;
	bh=7sLkZ7HdfpQ3GB6bv8hpvrvx3RnqiOW7lnnGzj54AWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qqAGnvpvQmkDjGoDsQ7yfYVyVbxT9FTr/2RiIAQoJD1si24TloFBlzJZicyZ9KzSlIf6eRT1PkFUgJsoSKtPUAKKdcNYeyyaoJ+4GEsDfsopiNGby5g8bJZCRzyBNe7l7S8lVHLWgzn4hK6fFfsok7RpJ0WFM43B0k1Tdeb+12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9MwbraZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9MwbraZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ACF1F000E9;
	Tue,  7 Jul 2026 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384414;
	bh=H2gMO6pKIlOeVFVBt9lH6tgyrLkmy6ES9o6E2E7fdaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O9MwbraZT+V/zRj2ROAiOPYXhuXqwRGyLsxmXcE8SVQc/afGFuuAVOQT148FxZl2J
	 L2x0DMUK6EHUfBKWZdWifrVrx4qFuqsp6UgTwoj6zA8LHYd65TINyYBBz7VwulwV0C
	 3MCTpXYPMMD7JQ5wpXT0FzhToDuHlhVnAGy3wohdTf9NcGnWqDQHiTBWk09NoqkZiA
	 0DXKsM6Jt55UaIpI1SfTf4hCubCLMFSvWTiyWN/ZCHAtBcD6mf0yXb6JJwjBk/1TIK
	 XHAO4r/YZeI6B/DD6p2WLUKQbyKmC4VM5uA/k982LSPX5Bc/BWMeySUmTlEiZfkSiH
	 c7aC8EMie4xrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 09/36] sched_ext: Make the kick
 machinery per-sched
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-10-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-10-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:33:33 +0000
Message-Id: <20260707003334.59ACF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Early return in `kick_cpus_irq_workfn()` skips removing `pcpu->to_=
kick_node` from `sched_pcpus_to_kick` if `ksyncs_pcpu` is NULL, leading to =
a Use-After-Free when the `pcpu` structure is later freed.
--

--- Patch [9]: [PATCH v3 sched_ext/for-7.3 09/36] sched_ext: Make the kick =
machinery per-sched ---
commit f524c2556374db5c875f61c03449ff025ad14859
Author: Tejun Heo <tj@kernel.org>
sched_ext: Make the kick machinery per-sched

This commit moves the kick masks into the per-sched per-cpu scx_sched_pcpu
and has scx_kick_cpu() link the sched onto a per-cpu list, allowing preempt
kicks to be scoped to the requesting scheduler.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 187754d0c3c84..150e74129266b 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4624,6 +4624,17 @@ static void scx_sched_free_rcu_work(struct work_st=
ruct *work)
>  		 */
>  		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
> =20
> +		/*
> +		 * Bypass blocks new kicks. Flush the kick irq_work so this
> +		 * pcpu's to_kick_node is off the list before it is freed.
> +		 */
> +		irq_work_sync(&cpu_rq(cpu)->scx.kick_cpus_irq_work);
> +		WARN_ON_ONCE(!list_empty(&pcpu->to_kick_node));
> +		free_cpumask_var(pcpu->cpus_to_kick);

[ ... ]

> @@ -7535,15 +7566,24 @@ static void kick_cpus_irq_workfn(struct irq_work =
*irq_work)
> =20
>  	ksyncs =3D rcu_dereference_bh(ksyncs_pcpu)->syncs;
> =20
> -	for_each_cpu(cpu, this_scx->cpus_to_kick) {
> -		should_wait |=3D kick_one_cpu(cpu, this_rq, ksyncs);
> -		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick);
> -		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick_if_idle);
> -	}
> +	/*
> +	 * Walk scheds with pending kicks on this cpu. scx_kick_cpu() adds to
> +	 * the list under local_irq_save() and only this irq_work consumes it.
> +	 * A plain list without locking is sufficient.
> +	 */
> +	list_for_each_entry_safe(pcpu, tmp, &this_scx->sched_pcpus_to_kick, to_=
kick_node) {
> +		list_del_init(&pcpu->to_kick_node);

[Severity: High]
Does this code risk a use-after-free on the scheduler disable path?

If a kick races with scx_root_disable(), free_kick_syncs() can set the
per-CPU scx_kick_syncs pointers to NULL. If kick_cpus_irq_workfn() executes
after this, it hits an early return just before the code above:

kernel/sched/ext/ext.c:kick_cpus_irq_workfn() {
    ...
	if (unlikely(!ksyncs_pcpu))
		return;
    ...
}

Because this early return bypasses the list_for_each_entry_safe() loop,
pcpu->to_kick_node remains on the rq->scx.sched_pcpus_to_kick list.

When scx_sched_free_rcu_work() later runs, it syncs the irq_work, triggers
the WARN_ON_ONCE(!list_empty(&pcpu->to_kick_node)) check added in this patc=
h,
and frees the pcpu structure via free_percpu() while it is still linked.

When a new scheduler is loaded and calls scx_kick_cpu(), will it corrupt the
list by calling list_add_tail() on this freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D9
