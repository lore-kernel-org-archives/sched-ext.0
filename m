Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48F1448D5
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546678; cv=none; b=lA7LbIkrx8HbPzlQbNw6xwrN/jJTEbBhTofQgZThFmkOelA2rJNRn7to2hNN72l07nsKrI4c5BlAoyn6hrXzbcgw5JMhC3S9A2FXV7weis6DOpZm4cLpcUCCgbEyYYitpTqxcukADC57XufmY6yZVxyyJeJL1dvOfCXPh6XrGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546678; c=relaxed/simple;
	bh=09qdc32R+gpSDRLd/Ncng0aGMksh2Qkdn6a6xtDHcQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g9dK/VjvzcqmHgfJQqoelMZAc/EfsqBtg8ahUh+LbyMDx7fjrt9e6XSVesXAGE7zzpFFxNPwq9mWh76kuhnru0vQdbYcwFugnEKhoOSLmyXYPyBN9H5njuO3PIxEFhLneZ5OXiJuVVEL8+eCiUhneC39m/t3dqDyQguqoCC75uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lwmih1TQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lwmih1TQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23D7C2BCB0;
	Tue, 12 May 2026 00:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778546677;
	bh=09qdc32R+gpSDRLd/Ncng0aGMksh2Qkdn6a6xtDHcQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Lwmih1TQgwiauuT2RJHKdfuyKx3yYStP1qNy9moihenMCohaxoZdaVIBCBBELbOXU
	 /aa7tKO3wpr6AKY9vR7dfMW1UBW4i2bDRvtPQBZzAigeELfy1rqDqzQyE15BqNVWZE
	 EbLG6q4kk+9ATMFkf6ukSrTA42n1FX/iZ3iaL6hvIBVF4mGdvlbOHOwBJdoEkYJcjj
	 ibHqdb6EGHGiw0Vn5BDIOuR2pzz7pdTnsnl9DjqSQ7o9/Iy/nPFmzQAqsrte/EzIMp
	 J52Pt8PgW+8nc5QMSY2NgVejTvC7Q6hCGWaUhqwbanlbGY4jY443BedNbYLMlsZo0g
	 RAnR8++wCbSsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix ops->priv NULL
 pointer deref in bpf_scx_unreg()
Reply-To: sashiko@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260510224332.2011982-1-arighi@nvidia.com>
References: <20260510224332.2011982-1-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 00:44:36 +0000
Message-Id: <20260512004437.A23D7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Dangling pointer in scx_alloc_and_add_sched() leads to Use-Aft=
er-Free.
- [High] Spurious scx_error() triggers Denial of Service in multi-sched env=
ironments.
- [High] Early return in bpf_scx_unreg() introduces a permanent resource le=
ak and wedges the scheduler state.
- [High] Fallback to scx_root in scx_prog_sched() breaks isolation and allo=
ws cross-scheduler state corruption.
- [High] Using ops->priv to track the scheduler instance inherently breaks =
sub-schedulers.
--

commit 13d28bde689d42f58394dbdb0585d40676beacf4
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Fix ops->priv NULL pointer deref in bpf_scx_unreg()

Under heavy concurrent attach/detach operations, scx_claim_exit() can
trigger a NULL pointer dereference. This commit fixes it by falling back
to the scx_root path in scx_prog_sched() when ops->priv is NULL, and
returning early in bpf_scx_unreg() if the scheduler pointer is NULL.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 345aa11b84b28..11998530416fb 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7493,6 +7493,14 @@ static void bpf_scx_unreg(void *kdata, struct bpf_=
link *link)
>  	struct sched_ext_ops *ops =3D kdata;
>  	struct scx_sched *sch =3D rcu_dereference_protected(ops->priv, true);
> =20
> +	/*
> +	 * ops->priv can be NULL if scx_alloc_and_add_sched() failed before
> +	 * assigning it, or if bpf_scx_unreg() somehow re-entered. There's
> +	 * nothing to tear down in either case.
> +	 */
> +	if (!sch)
> +		return;
> +

Does this lockless check introduce a permanent resource leak when multiple
links are created for the same map?

Looking at bpf_struct_ops_map_link_dealloc(), it does not hold locks
preventing concurrent reg operations. If Thread 1 initiates unreg for a
detached link and executes scx_disable(), but is preempted before executing
RCU_INIT_POINTER(ops->priv, NULL):

Thread 1:
scx_disable()
... preempted ...

Thread 2 could successfully attach a new link for the same map, assigning i=
ts
new scheduler sch2 to ops->priv.

When Thread 1 resumes and executes RCU_INIT_POINTER(ops->priv, NULL), it
clears the pointer to Thread 2's active scheduler.

When Thread 2 subsequently detaches, would bpf_scx_unreg() read ops->priv,
see NULL, and return early here?

This would completely skip scx_disable() and kobject_put(), permanently
leaking sch2 and leaving scx_enable_state stuck at SCX_ENABLED. Would this
prevent new schedulers from being loaded until the system is rebooted?

Can a dangling pointer in scx_alloc_and_add_sched() lead to a use-after-free
with this ops->priv logic?

While not introduced by this patch, in scx_alloc_and_add_sched(),
rcu_assign_pointer(ops->priv, sch) is called before several fallible
allocations.

If a subsequent step like kobject_init_and_add() fails, the function jumps =
to
the error path and frees sch via kfree(), but fails to reset ops->priv to
NULL.

If a map was previously attached, ran, and armed a stray bpf_timer, could a
subsequent failed re-attach attempt leave ops->priv pointing to the freed s=
ch?

When the stray timer fires, would scx_prog_sched() dereference ops->priv and
return the freed pointer to BPF kfuncs?

> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index a075732d4430d..e468a7401ed83 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1433,11 +1433,21 @@ static inline bool scx_task_on_sched(struct scx_s=
ched *sch,
>  static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux=
 *aux)
>  {
>  	struct sched_ext_ops *ops;
> -	struct scx_sched *root;
> +	struct scx_sched *root, *sch;
> =20
>  	ops =3D bpf_prog_get_assoc_struct_ops(aux);
> -	if (likely(ops))
> -		return rcu_dereference_all(ops->priv);
> +	if (likely(ops)) {
> +		sch =3D rcu_dereference_all(ops->priv);
> +		if (likely(sch))
> +			return sch;
> +		/*
> +		 * @aux is associated with @ops but @ops->priv is NULL. This can
> +		 * be observed transiently under concurrent attach/detach (e.g.
> +		 * bpf_scx_unreg() clears @ops->priv before kdata is freed).
> +		 * Continue with the scx_root path so single-sched users keep
> +		 * working, sub-sched users see no scheduler.
> +		 */
> +	}

Does this fallback to scx_root trigger a denial of service in multi-sched
environments?

If root->ops.sub_attach is true, the fallback bypasses the return root; path
and instead hits scx_error(root, "Unassociated program executing with
sub-schedulers").

Because scx_error() is a macro that disables the BPF scheduler and forces
a system-wide fallback to CFS, could encountering this transient
ops->priv =3D=3D NULL state instantly crash the root scheduler?

Can this fallback to scx_root break isolation and allow cross-scheduler sta=
te
corruption?

When a scheduler is detached, bpf_scx_unreg() clears ops->priv to NULL.
However, asynchronous execution contexts like bpf_timer or workqueues armed
by the detached scheduler can still fire.

If this stray program calls a kfunc, it observes ops->priv =3D=3D NULL and =
now
falls back to returning the globally active scx_root.

If an entirely different scheduler has since been attached, would the stray
program bypass isolation boundaries and directly manipulate the new
scheduler's state? Prior to this patch, it safely returned NULL.

This isn't a bug introduced by this patch, but does using ops->priv to track
the scheduler instance inherently break sub-schedulers?

Because ops->priv is a single pointer on the shared struct_ops map (kdata),
attaching the same map to multiple cgroups will sequentially overwrite
ops->priv. It will only track the most recently attached scheduler.

If a BPF program executes for an older cgroup's scheduler, will it read
ops->priv, receive the newer cgroup's scheduler, and operate on the wrong
state?

> =20
>  	root =3D rcu_dereference_all(scx_root);
>  	if (root) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510224332.2011=
982-1-arighi@nvidia.com?part=3D1
