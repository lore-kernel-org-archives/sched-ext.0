Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261E39098C
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387826; cv=none; b=qbbDLKrs0b+9KFBi3Zhq7uYgl5LFAU7wic4DFosI/TKweWLmqjUs+ok/xCD7AqPDxNXfzGyw9JRKZuH2lf+VonpRfCEMiHNEObHt6OLwvRE8ZXbD3xfVUFwZZuIlkOSjPSkOaGMWkNPoK2a5rMy+GkKoyvQTjgZUHOruhJmmcsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387826; c=relaxed/simple;
	bh=w9TOMHiexRDDQC6Q18iKHmJb2etT+4JVfgVL8UBj2Fc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QAqDTKqfQZDcjNfl9q5YqeNVTLy2g5L8sBuGOJM3eHfYj4pJGvkByvTWpOKF38GpeFczfW12G34Xk6Pj4dFP+ENIsSUT0ezCxxCBgyu1pH9Y/1tOId5zTRA06EtJ9hJ3QJgqrZ2T7vLWl5XgfGYqWszKibP3SK4m5q2xob4WueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjqI7HEz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjqI7HEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E671F000E9;
	Thu, 21 May 2026 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779387824;
	bh=/NjEGbU73J97MX8nQGdFcfANYH35TP9WlDXGe6OXqKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AjqI7HEz5AZV+8wpZLsx2yG1wFJB9hKUJXJ8MlYXtzl0m1N7MFyMO+afHyd3CjG0r
	 hps3rsRhtwHpkmr2cxzGYp//195pqfhRrF6+FOoVZDn2gz07YLSb+cA1HpUXTI8j2F
	 aSUMvPZEH6oK9keboQzpnVKAXUwH6TwK+ju2QTEuEj6RGQNSxFOdTfAIaqs+XMuHIy
	 QkofIVJBgogNXGP6XYvz7Nb3/gwFGiLJ+ve0AKRKMJqJVtuxxMOdCIC0ldHh/KKYUF
	 TXBG7SaDppIPBBk7y+B+L6//sJAX/w32SwviMwFUc1VmA0LqxyE1O2lenD9crAyzoi
	 duBJKUC4IisuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Auto-register/unregister dl_server
 reservations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260521174509.1534623-2-arighi@nvidia.com>
References: <20260521174509.1534623-2-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 18:23:43 +0000
Message-Id: <20260521182344.77E671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Deferring the ext_server bandwidth reservation to sched_ext load t=
ime allows deadline bandwidth overcommit, breaking real-time guarantees.
- [High] Dropping `dl_b->lock` between detaching and attaching deadline ser=
vers allows concurrent tasks to steal bandwidth, permanently breaking starv=
ation protection.
- [High] `dl_server_detach_bw()` and `dl_server_attach_bw()` fail to update=
 local runqueue bandwidth (`rq->dl.this_bw`), breaking GRUB reclamation and=
 causing CPU overcommit.
--

commit c14e78e1decaa133b4b018a638661ae8c0968dc2
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Auto-register/unregister dl_server reservations

This commit changes the deadline server bandwidth reservations for sched_ext
and fair servers to be dynamic. Rather than statically reserving bandwidth
for both at boot, it attaches and detaches the bandwidth reservations
based on whether the BPF scheduler is loaded and operating in full or
partial mode.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> +int dl_server_attach_bw(struct sched_dl_entity *dl_se)
> +{
> +	struct rq *rq =3D dl_se->rq;
> +	int cpu =3D cpu_of(rq);
> +	struct dl_bw *dl_b;
> +	unsigned long cap;
> +	int cpus;
> +
> +	if (dl_se->dl_bw_attached)
> +		return 0;
> +
> +	dl_b =3D dl_bw_of(cpu);
> +	guard(raw_spinlock)(&dl_b->lock);
> +
> +	cpus =3D dl_bw_cpus(cpu);
> +
> +	/*
> +	 * If there's no active CPU in this root domain (e.g., @cpu is offline),
> +	 * just record the intent, so dl_server_add_bw() honors it when CPUs
> +	 * come back.
> +	 */
> +	if (!cpus) {
> +		dl_se->dl_bw_attached =3D 1;
> +		return 0;
> +	}
> +
> +	cap =3D dl_bw_capacity(cpu);
> +
> +	if (__dl_overflow(dl_b, cap, 0, dl_se->dl_bw))
> +		return -EBUSY;
> +
> +	__dl_add(dl_b, dl_se->dl_bw, cpus);
> +	dl_se->dl_bw_attached =3D 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * Detach @dl_se's bandwidth from the root domain's total_bw accounting.
> + *
> + * Use to dynamically unregister a dl_server's bandwidth reservation whi=
le
> + * preserving its configured @dl_runtime / @dl_period. No-op if @dl_se is
> + * not currently attached.
> + */
> +void dl_server_detach_bw(struct sched_dl_entity *dl_se)
> +{
> +	struct rq *rq =3D dl_se->rq;
> +	int cpu =3D cpu_of(rq);
> +	struct dl_bw *dl_b;
> +	int cpus;
> +
> +	if (!dl_se->dl_bw_attached)
> +		return;
> +
> +	dl_b =3D dl_bw_of(cpu);
> +	guard(raw_spinlock)(&dl_b->lock);
> +
> +	cpus =3D dl_bw_cpus(cpu);
> +
> +	/*
> +	 * If no active CPUs in this root domain, the bandwidth isn't in
> +	 * @dl_b right now; only clear the flag so dl_server_add_bw() skips
> +	 * the server on the next root-domain rebuild.
> +	 */
> +	if (cpus)
> +		__dl_sub(dl_b, dl_se->dl_bw, cpus);
> +	dl_se->dl_bw_attached =3D 0;
> +}

[Severity: High]
Does this miss updating the local runqueue bandwidth?

While the global root domain bandwidth (dl_b->total_bw) is updated here
and in dl_server_attach_bw(), rq->dl.this_bw doesn't appear to be updated
via __sub_rq_bw() and __add_rq_bw().=20

During boot, ext_server is initialized and its bandwidth is added to
this_bw, but the subsequent dl_server_detach_bw() does not subtract it.

Could this permanently inflate this_bw, which then causes the GRUB
reclamation algorithm to incorrectly calculate inactive utilization and
allow active DL tasks to consume more CPU time than admitted?

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c

[ ... ]

> @@ -6136,10 +6144,24 @@ static void scx_root_disable(struct scx_sched *sc=
h)
>  	/*
>  	 * Invalidate all the rq clocks to prevent getting outdated
>  	 * rq clocks from a previous scx scheduler.
> +	 *
> +	 * Also re-balance the dl_server bandwidth reservations: detach
> +	 * ext_server (no more sched_ext tasks) and reinstate fair_server
> +	 * if it was previously detached because we were running in full
> +	 * mode. Detach before attach to avoid a transient overflow of the
> +	 * root domain's bandwidth capacity.
>  	 */
>  	for_each_possible_cpu(cpu) {
>  		struct rq *rq =3D cpu_rq(cpu);
> +
>  		scx_rq_clock_invalidate(rq);
> +
> +		scoped_guard(rq_lock_irqsave, rq) {
> +			dl_server_detach_bw(&rq->ext_server);
> +			if (was_switched_all &&
> +			    WARN_ON_ONCE(dl_server_attach_bw(&rq->fair_server)))

[Severity: High]
Can a concurrent task steal the bandwidth during this transition?

Because dl_server_detach_bw() and dl_server_attach_bw() each acquire and
release the root domain's dl_b->lock independently, the lock is dropped
between the two calls.

If another CPU executes sched_setattr(SCHED_DEADLINE) during this window,
can it consume the newly freed bandwidth, causing the attach operation to
fail and permanently leaving the CPU without its starvation protection
server?

> +				pr_warn("failed to re-attach fair_server on CPU %d\n", cpu);
> +		}
>  	}

[ ... ]

> @@ -7314,6 +7336,27 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
>  	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
>  		static_branch_enable(&__scx_switched_all);
> =20
> +	/*
> +	 * Re-balance the dl_server bandwidth reservations.
> +	 *
> +	 * In full mode (!SCX_OPS_SWITCH_PARTIAL) no task will ever run in
> +	 * the fair class, so detach the fair_server reservation and give
> +	 * that bandwidth back to the RT class. Always attach the
> +	 * ext_server reservation since sched_ext tasks are now possible.
> +	 *
> +	 * Detach before attach to avoid a transient overflow of the root
> +	 * domain's bandwidth capacity.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct rq *rq =3D cpu_rq(cpu);
> +
> +		guard(rq_lock_irqsave)(rq);
> +		if (scx_switched_all())
> +			dl_server_detach_bw(&rq->fair_server);
> +		if (WARN_ON_ONCE(dl_server_attach_bw(&rq->ext_server)))

[Severity: High]
Does this allow deadline bandwidth overcommit?

In partial mode (!scx_switched_all()), the system attempts to attach
ext_server while fair_server is still attached. If user deadline tasks
have already consumed the remaining root domain bandwidth prior to loading
the BPF scheduler, dl_server_attach_bw() will fail with -EBUSY.

Since this error only triggers a warning and proceeds to load the scheduler,
ext_server remains active and will throttle other DL tasks. Does this
silently bypass DL admission control and break real-time guarantees?

> +			pr_warn("failed to attach ext_server on CPU %d\n", cpu);
> +	}
> +
>  	pr_info("sched_ext: BPF scheduler \"%s\" enabled%s\n",
>  		sch->ops.name, scx_switched_all() ? "" : " (partial)");
>  	kobject_uevent(&sch->kobj, KOBJ_ADD);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521174509.1534=
623-1-arighi@nvidia.com?part=3D1
