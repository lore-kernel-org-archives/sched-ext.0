Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979812;
	b=w6g5aXb/7ehodCdMtR0nF6gPE5x25i/h0wBjqrcIIyVB9dSH3qYvDZq6gnbKnSAp5s5l
	 tJtF0GhRLF6fZHLAlj4MS4r+n/ZDockfUb4DTsvvjoaNDr2cA5CsHBB8nFohDaLY/QSdy
	 ZHL+M02M7jO7JhnRpFLwD+Kn2KDhM1ydw0a064wKT7IEbYEMoqN0YMKsIOAJ4xvNA9T7a
	 CysZyhieJgPWP2hYhQGMljC1bLFpLJ1ETz0wsv+F0gGKsODdaAsBF26bZJLq6UFZimP8b
	 4xYFrYmK0jrtCPlPb7RMjxh+LYOrMpwPJi4pqN6dHVqIzTsbfiSYCCvDQDp/R2zwD7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979812;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AtWVKDZBwoPqftY86aAEdhaOHKhMZ6eqGCOf9h2MQhw=;
	b=Lw8o2bSXZibFJuW47Q7gvUJFcStjjMIm6FHrOp4a+GbQjE8hDvVv0RZh94x8h/yPC9S7
	 +ltybOYLw/9Db7GndBM1jsVFbeAkzCRQfCoA7oAILRotSNGUl1pnYjyh7+VR5pkSScUn/
	 wu2PPcVUU81z+VDlSDPQEAA88CgPR/9Q/sWaPaDkuOwC9q6tZxn+Xwy5h4BA3rRI0IsKG
	 UZCGXMnexjJoKAsIJN8BMbbSvgXXV5UWpGNZ1LeHWYYF6McmEyy7Z96k9jx/smiHr4+S1
	 ShpfarrzZV6hQUZI+qoeNG1YAocmJCMpd19Jpl9SawvVkCjFcaQJgNGuhkB0jqjYfeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfPuyYJ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B80606A32D
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfPuyYJ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940651F008A3;
	Fri,  6 Nov 2026 15:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979811;
	bh=AtWVKDZBwoPqftY86aAEdhaOHKhMZ6eqGCOf9h2MQhw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nfPuyYJ0pXPkdt0PEaOvlrmoEGvkD3ZpEW2KGJlRVtD1x0pDrsvCg+4AmbUiq/apN
	 LhLxCxArjbUip3TqhqJh4LmB6V7RLEhbXwkbsgLBuYEpCkySRoWZDV/+AP6GQjCMSW
	 6OcU3yqJ8cQEgcUoAqWC3KX6dtH0h5aIxWmA8wxM1PzNL7KvanEYJCUmsMaKngKXP2
	 liAieS/bYsYIM6SPKGv32UAydWfe/m2hDqvaBqeudhlyUpvrkGPxqj1tOp8oTim5Eu
	 V4JaFOiCblxZsQbodEWhBA0GoM+V7QPRN6GYpjhnYiqmgB+L6OK5X1NK384G6ruYQ8
	 sZLOC+hHjeAAQ==
Message-ID: <sashiko-outbox-201722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/20 v3] sched/eevdf: Decay positive lag of sleeping
 entities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-2-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:43:31 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] sched/eevdf: decay_entity_lag() uses stale PELT loads and
  h_load
- [Medium] sched/eevdf: decay_entity_lag() uses zero or cross-CPU
  exec_start
--

commit af61170f82add576c62982c6213d87ccfac0159f
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/eevdf: Decay positive lag of sleeping entities

This commit introduces decay_entity_lag() and calls it from
enqueue_task_fair() on wakeup to decay the positive virtual lag of sleeping
tasks based on their sleep duration and weight share on the previous
runqueue.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0feec172fd37e..5cd171f830d86 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct=
 sched_entity *se)
>  	return avruntime - vlag !=3D se->vruntime;
>  }
> =20
> +/*
> + * Signed add and clamp on underflow.
> + *
> + * Explicitly do a load-store to ensure the intermediate value never hits
> + * memory. This allows lockless observations without ever seeing the neg=
ative
> + * values.
> + */
> +#define add_positive(_ptr, _val) do {                           \
> +	typeof(_ptr) ptr =3D (_ptr);                              \
> +	__signed_scalar_typeof(*ptr) val =3D (_val);              \
> +	typeof(*ptr) res, var =3D READ_ONCE(*ptr);                \
> +								\
> +	res =3D var + val;                                        \
> +								\
> +	if (val < 0 && res > var)                               \
> +		res =3D 0;                                        \
> +								\
> +	WRITE_ONCE(*ptr, res);                                  \
> +} while (0)
> +
> +/*
> + * Remove and clamp on negative, from a local variable.
> + *
> + * A variant of sub_positive(), which does not use explicit load-store
> + * and is thus optimized for local variable updates.
> + */
> +#define lsub_positive(_ptr, _val) do {				\
> +	typeof(_ptr) ptr =3D (_ptr);				\
> +	*ptr -=3D min_t(typeof(*ptr), *ptr, _val);		\
> +} while (0)
> +
> +static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
> +static unsigned long task_h_load(struct task_struct *p);
> +
> +static __always_inline
> +void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int =
flags)
> +{
> +	struct sched_entity *se =3D &p->se;
> +	s64 delta_exec, vlag =3D se->vlag;
> +	unsigned long cfs_load;
> +	struct rq *rq;
> +
> +	WARN_ON_ONCE(se->on_rq);
> +
> +	/* Negative lag is managed by delayed dequeue path */
> +	if (vlag <=3D 0)
> +		return;
> +
> +	rq =3D rq_of(cfs_rq);
> +
> +	/* No fast access to prev rq task clock */
> +	if (flags & ENQUEUE_MIGRATED)
> +		return;
> +
> +	/* Compute sleep time */
> +	delta_exec =3D rq_clock_task(rq) - se->exec_start;

[Severity: Medium]
Can se->exec_start be zero or hold another CPU's task clock here even when
ENQUEUE_MIGRATED is not set?

When a task is migrated (for instance via proxy_migrate_task() or as a
sched_delayed task), enqueue_entity() clears se->exec_start to 0.  If that
task is then dequeued before being picked to run (such as by
proxy_needs_return() in ttwu_runnable(), or when pick_next_entity() finishes
the delayed dequeue) and wakes on the same CPU, ENQUEUE_MIGRATED is not set,
so rq_clock_task(rq) - se->exec_start equals the full CPU task clock since
boot and zeroes se->vlag.

Similarly, under CONFIG_CFS_BANDWIDTH, if a throttled task is migrated onto=
 a
destination cfs_rq that is also throttled, enqueue_task_fair() returns early
via enqueue_throttled_task(p) before enqueue_entity() can clear
se->exec_start, and tg_unthrottle_up() later calls enqueue_task_fair(rq, p,
ENQUEUE_WAKEUP) without ENQUEUE_MIGRATED.  decay_entity_lag() then subtracts
the previous CPU's se->exec_start from the new CPU's rq_clock_task(rq) and
subtracts an unattached task_h_load(p) from cfs_load.

> +	if (unlikely(delta_exec <=3D 0))
> +		return;
> +
> +	/* For anything above ~4 seconds, save computation and clear the lag */
> +	if (unlikely(delta_exec >> 32)) {
> +		se->vlag =3D 0;
> +		return;
> +	}
> +
> +	/*
> +	 * Use cfs' load and p's weight to estimate what would have been the
> +	 * share for p. task's load contribution to cfs' load is replaced by
> +	 * its weight.
> +	 */
> +	cfs_load =3D cfs_rq_load_avg(cfs_rq);
> +	lsub_positive(&cfs_load, task_h_load(p));
> +	if (cfs_load) {
> +		unsigned long weight =3D scale_load_down(se->h_load.weight);
> +
> +		delta_exec *=3D weight;
> +		delta_exec =3D div64_long(delta_exec, cfs_load + weight);
> +	}
> +
> +	vlag -=3D calc_delta_fair(delta_exec, se);
> +
> +	/* vlag can't become neg while sleeping */
> +	se->vlag =3D max(0, vlag);
> +}

[ ... ]

> @@ -8185,6 +8238,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct=
 *p, int flags)
>  	if (p->in_iowait)
>  		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> =20
> +	if (task_wake)
> +		decay_entity_lag(cfs_rq, p, flags);

[Severity: Medium]
Does calling decay_entity_lag() before enqueue_hierarchy() and
reweight_eevdf() use stale PELT load averages and a stale se->h_load.weight?

When p wakes on its previous CPU without sync_entity_load_avg() having run
(for example via the select_idle_sibling() fast path), p->se.avg.load_avg is
still at its pre-sleep value because update_load_avg() is only called inside
enqueue_hierarchy() -> enqueue_entity().  Meanwhile, if other tasks ran on =
rq
while p slept, p's blocked load contribution inside cfs_rq->avg.load_avg has
already decayed; subtracting the undecayed task_h_load(p) from the decayed
cfs_rq_load_avg(cfs_rq) eats into the active load of the other tasks (often
clamping cfs_load to 0) and over-decays p->se.vlag as if the CPU had been
idle.

Under CONFIG_FAIR_GROUP_SCHED, calling task_h_load(p) before
enqueue_hierarchy() also invokes update_cfs_rq_h_load() on unsynchronized
group PELT averages and caches that stale cfs_rq->h_load for the rest of the
current jiffy.  In addition, if p was reniced or had its group shares chang=
ed
while sleeping, reweight_task_fair() returned early while !se->on_rq, so
se->h_load.weight is not updated until enqueue_hierarchy() and
reweight_eevdf() run below.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D1
