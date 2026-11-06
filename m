Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982658;
	b=RBfiKBIYqtntwzee9hBUjwVrBs3jE1sCxSqCwpbX+7q9bUYpdV+2oTSVxVdwPLlT0KsP
	 toNdAEEFdULbqNDcQfWiNwhtkApfSjAzkpQqNhshh2E0tAEyIaWc+d+TzSa8eJ30IUoOa
	 otVSNzOj6XvmCp6YaWtznvpcyobdIpA/3ZjkshiXrrm+0mVA977fgLWLfMY/V2eiYPvlc
	 FhRzR2ZTsh6mgaO4J02O1cEEBnQRDVzEkx0b0z11Q/FrMT/z5pzgtOYvXfnWNxed6/PWu
	 Gpj9caZdgunmmEnqspxIIow7bHQQKK7HlSXezCGEtIeGzDJ9aXBWfYXgnzfiRC99kYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982658;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PMSHn6KKjJLPpY/JASRX8lSNCWgHneRhA9pxaI+02Hw=;
	b=y0KspeRVKVy2uFv0O9/1kmKpSvjuXPy6AiRHvD9raemH+rTTFEYzn7OUtaJ+1fbjMsUc
	 U2JLnZfAMWwVibZigy3VqitGW3iBxCrm6ntFI3XIF+saxv7HV0jFFFGrieiMSOSLAK3q6
	 rvD0JhG+xAA4hDA9EZD87SlEzeMrg56ePA7QhaRx6B9jXPjv6AX4DDM0Wo+wzel4ziY3c
	 4pD92Qmtz/NHmOo6qWJyyeDjqtlt1w2jf/te+zKf3kgozOIGB8Ci+59zB9uxUS0MOHwMw
	 SC/NpLivadvxQQDJysZJvvWeIs65YdxhQSsFYBcN3OAq+bJaLeb4T++/YVpn9Pi0psA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFxCugWA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7D606A326
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFxCugWA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57D91F0089F;
	Fri,  6 Nov 2026 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982657;
	bh=PMSHn6KKjJLPpY/JASRX8lSNCWgHneRhA9pxaI+02Hw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JFxCugWA4UUtthkBSkC9f1UssQbf1/dcxtgE7/n3U291cMGiFVPyy6XOGlBNPCzaE
	 a4Ax5VPmQvmZ6l7SGZZHE9MP7ZRqiVFqIGQw8x2tpvqy2/4B63M5yaKDly0EUuDw3f
	 /M8w9cipIqxgZK0+8EUvWoyDw6aYhuzlQj/ZONDmunZdq25kKoO1xdMbQfYnfX5by4
	 Th8fOD46oed3c2vMs94Nt7nClrVKy8GnmAz8EGkOVUBy2p5hUs0KEp3VQ6wP5sHVX/
	 0ugtKTlEQCP5JBtIqgzMBNxHnS88POMC/7K3t/L9YbZ8Toq6KhaHhepb/cURHwOFyr
	 qJx8R+nz5gW9w==
Message-ID: <sashiko-outbox-201823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/20 v3] sched/fair: Rework feec() to use cost instead
 of spare capacity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-18-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-18-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:30:57 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] sched/fair: missing task argument in update_best_cpu() call
  breaks build
- [High] sched/fair: underestimated energy delta in
  find_energy_efficient_cpu()
- [Medium] sched/fair: min_stat not reset on better fits in
  find_energy_efficient_cpu()
- [Medium] sched/fair: find_energy_efficient_cpu() picks smallest PD
  when fits is -1
- [Medium] sched/fair: find_energy_efficient_cpu() migrates 0-util tasks
  to first PD
- [Medium] sched/fair: off-by-one OPP boundary checks in
  find_energy_efficient_cpu()
- [Low] sched/fair: unreachable prev_cpu nr_running adjustment in
  update_best_cpu()
- [Low] sched/fair: wrong base max_cost in find_energy_efficient_cpu()
  when uclamp_max is 0
--

commit d227a3eb8d24b8112f9074f06edbce339ce827bc
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/fair: Rework feec() to use cost instead of spare capacity

This commit reworks find_energy_efficient_cpu() to select the lowest-cost
CPU within each performance domain using OPP cost and performance tie-break=
ers
rather than maximum spare capacity.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 894bee51b99ad..ea117c3d0dd71 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[ ... ]

> @@ -9762,124 +9768,161 @@ static inline void eenv_task_busy_time(struct e=
nergy_env *eenv,

[ ... ]

> +/* Find the cost of a performance domain for the estimated utilization */
> +static inline void find_pd_cost(struct em_perf_domain *pd,
> +				unsigned long max_util,
> +				struct energy_cpu_stat *stat)
> +{
> +	struct em_perf_table *em_table;
> +	struct em_perf_state *ps;
> +	int i;
> =20
> -			/*
> -			 * If there is no active max uclamp constraint,
> -			 * directly use task's one, otherwise keep max.
> -			 */
> -			if (uclamp_rq_is_idle(cpu_rq(cpu)))
> -				max =3D uclamp_eff_value(p, UCLAMP_MAX);
> -			else
> -				max =3D max(max, uclamp_eff_value(p, UCLAMP_MAX));
> -		}
> +	/*
> +	 * Find the lowest performance state of the Energy Model above the
> +	 * requested performance.
> +	 */
> +	em_table =3D rcu_dereference_all(pd->em_table);
> +	i =3D em_pd_get_efficient_state(em_table->state, pd, max_util);
> +	ps =3D &em_table->state[i];
> =20
> -		eff_util =3D sugov_effective_cpu_perf(cpu, eff_util, min, max);
> -		max_util =3D max(max_util, eff_util);
> +	/* Save the cost and performance range of the OPP */
> +	stat->max_perf =3D ps->performance;
> +	stat->cost =3D ps->cost;
> +	i =3D em_pd_get_previous_state(em_table->state, pd, i);
> +	if (i < 0) {
> +		stat->min_perf =3D 0;
> +	} else {
> +		ps =3D &em_table->state[i];
> +		stat->min_perf =3D ps->performance;
>  	}
> +}

[ ... ]

> +static bool update_best_cpu(struct energy_cpu_stat *target,
> +			    struct energy_cpu_stat *min,
> +			    int prev, struct sched_domain *sd,
> +			    struct task_struct *p)
>  {
> -	unsigned long max_util =3D eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
> -	unsigned long busy_time =3D eenv->pd_busy_time;
> -	unsigned long energy;
> +	bool target_idle =3D choose_idle_cpu(target->cpu, p);
> +	bool min_idle =3D choose_idle_cpu(min->cpu, p);
> +
> +	/*  Select the one which is idle */
> +	if (target_idle !=3D min_idle)
> +		return target_idle;
> =20
> -	if (dst_cpu >=3D 0)
> -		busy_time =3D min(eenv->pd_cap, busy_time + eenv->task_busy_time);
> +	/* Favor previous CPU */
> +	if (target->cpu =3D=3D prev)
> +		return true;
> +	if (min->cpu =3D=3D prev)
> +		return false;
> =20
> -	energy =3D em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> +	/*  Select the one with the least number of running tasks otherwise */
> +	if (target->nr_running < min->nr_running)
> +		return true;
> +	if (target->nr_running > min->nr_running)
> +		return false;

[ ... ]

> @@ -9945,19 +9985,19 @@ static int find_energy_efficient_cpu(struct task_=
struct *p, int prev_cpu)
>  	target =3D prev_cpu;
> =20
>  	sync_task_load_avg(p);
> -	if (!task_util_est(p) && p_util_min =3D=3D 0)
> -		return target;
> -
> -	eenv_task_busy_time(&eenv, p, prev_cpu);
> +	task_util =3D task_busy_time(p, prev_cpu);

[Severity: Medium]
Does removing the !task_util_est(p) && p_util_min =3D=3D 0 early return cau=
se a
regression where zero-utilization tasks are migrated to the first
performance domain in rd->pd instead of staying on prev_cpu?

When task_util_est(p) is 0 and p_util_min is 0, task_util is 0 and
min_stat.cost does not exceed max_cost, so delta_nrg evaluates to 0 for
every performance domain.  The first fitting domain sets best_nrg =3D 0 and
every subsequent domain is skipped by delta_nrg >=3D best_nrg, placing the
task on the head of rd->pd (typically the highest-capacity domain built by
build_perf_domains()).

[ ... ]

> @@ -9980,113 +10016,115 @@ static int find_energy_efficient_cpu(struct ta=
sk_struct *p, int prev_cpu)
>  			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>  				continue;
> =20
> -			util =3D cpu_util(cpu, p, cpu, 0);
> -			cpu_cap =3D capacity_of(cpu);
> +			target_stat.fits =3D check_cpu_with_task(p, cpu);
> =20
> -			/*
> -			 * Skip CPUs that cannot satisfy the capacity request.
> -			 * IOW, placing the task there would make the CPU
> -			 * overutilized. Take uclamp into account to see how
> -			 * much capacity we can get out of the CPU; this is
> -			 * aligned with sched_cpu_util().
> -			 */
> -			if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
> -				/*
> -				 * Open code uclamp_rq_util_with() except for
> -				 * the clamp() part. I.e.: apply max aggregation
> -				 * only. util_fits_cpu() logic requires to
> -				 * operate on non clamped util but must use the
> -				 * max-aggregated uclamp_{min, max}.
> -				 */
> -				rq_util_min =3D uclamp_rq_get(rq, UCLAMP_MIN);
> -				rq_util_max =3D uclamp_rq_get(rq, UCLAMP_MAX);
> +			if (!target_stat.fits)
> +				continue;
> =20
> -				util_min =3D max(rq_util_min, p_util_min);
> -				util_max =3D max(rq_util_max, p_util_max);
> -			}
> +			/* 1st select the CPU that fits best */
> +			if (target_stat.fits < min_stat.fits)
> +				continue;
> +
> +			/* Then select the CPU with lowest cost */
> +
> +			/* Get the performance of the CPU w/ the waking task */
> +			target_perf =3D find_cpu_max_util(cpu, p, cpu);
> +			target_perf =3D min(target_perf, cpu_actual_cap);
> =20
> -			fits =3D util_fits_cpu(util, util_min, util_max, cpu);
> -			if (!fits)
> +			/* Needing a higher OPP means a higher cost */
> +			if (target_perf > min_stat.max_perf)
>  				continue;

[Severity: Medium]
Can a CPU with target_stat.fits =3D=3D 1 be rejected in favor of an earlier=
 CPU
in the same performance domain that only had min_stat.fits =3D=3D -1?

Because check_cpu_with_task() aggregates per-rq UCLAMP_MIN on non-idle
runqueues and get_actual_cpu_capacity() accounts for per-CPU hw_load_avg,
an earlier CPU in the domain can record min_stat.fits =3D -1 while a later
CPU returns target_stat.fits =3D 1.  When target_stat.fits > min_stat.fits,
min_stat is not reset, so the better-fitting CPU can be skipped here if
target_perf > min_stat.max_perf or rejected below by update_best_cpu().

> -			lsub_positive(&cpu_cap, util);
> +			/*
> +			 * At this point, target's cost can be either equal or
> +			 * lower than the current minimum cost.
> +			 */
> =20
> -			if (cpu =3D=3D prev_cpu) {
> -				/* Always use prev_cpu as a candidate. */
> -				prev_spare_cap =3D cpu_cap;
> -				prev_fits =3D fits;
> -			} else if ((fits > max_fits) ||
> -				   ((fits =3D=3D max_fits) && ((long)cpu_cap > max_spare_cap))) {
> -				/*
> -				 * Find the CPU with the maximum spare capacity
> -				 * among the remaining CPUs in the performance
> -				 * domain.
> -				 */
> -				max_spare_cap =3D cpu_cap;
> -				max_spare_cap_cpu =3D cpu;
> -				max_fits =3D fits;
> -			}
> +			/* Gather more statistics */
> +			target_stat.cpu =3D cpu;
> +			target_stat.runnable =3D cpu_runnable(cpu_rq(cpu));
> +			target_stat.capa =3D capacity_of(cpu);
> +			target_stat.nr_running =3D cpu_rq(cpu)->cfs.h_nr_runnable;
> +			if (p->on_rq && !p->se.sched_delayed && cpu =3D=3D prev_cpu)
> +				target_stat.nr_running--;

[Severity: Low]
Is this target_stat.nr_running decrement for prev_cpu reachable when
update_best_cpu() compares nr_running?

update_best_cpu() returns early whenever target->cpu =3D=3D prev or
min->cpu =3D=3D prev before reaching the nr_running comparison, so this
adjustment is dead code and a non-idle prev_cpu is always chosen over
another non-idle CPU at the same OPP cost regardless of how many other
tasks are runnable on prev_cpu.

> +
> +			/* If the target needs a lower OPP, then look up for
> +			 * the corresponding OPP and its associated cost.
> +			 * Otherwise at same cost level, select the CPU which
> +			 * provides best performance.
> +			 */
> +			if (target_perf < min_stat.min_perf)
> +				find_pd_cost(pd->em_pd, target_perf, &target_stat);

[Severity: Medium]
Should this check handle target_perf =3D=3D min_stat.min_perf when
min_stat.min_perf > 0?

In find_pd_cost(), em_pd_get_efficient_state() selects the lowest state
with ps->performance >=3D max_util, and min_perf is set to the previous
state's performance.  A candidate with target_perf =3D=3D min_stat.min_perf
therefore fits in the previous lower-cost OPP, but strict < skips
find_pd_cost() and treats it as having the higher OPP's cost.  In addition,
if em_update_performance_limits() caps pd->max_perf_state below
cpu_actual_cap, find_pd_cost() sets min_stat.max_perf to the capped state's
performance, causing later CPUs with target_perf > min_stat.max_perf to be
skipped even though they would clamp to the same maximum OPP.

> +			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
> +				continue;

[Severity: High]
Does this call to update_best_cpu() fail to compile because the 5th argument
p is missing?

update_best_cpu() is defined above with five parameters, including struct
task_struct *p, so omitting p here breaks compilation until a later patch
in the series, commit "sched/fair: Take into account slice in EAS", passes
p.

> +
> +			/* Save the new most efficient CPU of the PD */
> +			min_stat =3D target_stat;
>  		}
> =20
> -		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
> +		if (min_stat.cpu =3D=3D -1)
>  			continue;
> =20
> -		eenv_pd_busy_time(&eenv, cpus, p);
> -		/* Compute the 'base' energy of the pd, without @p */
> -		base_energy =3D compute_energy(&eenv, pd, cpus, p, -1);
> -
> -		/* Evaluate the energy impact of using prev_cpu. */
> -		if (prev_spare_cap > -1) {
> -			prev_delta =3D compute_energy(&eenv, pd, cpus, p,
> -						    prev_cpu);
> -			/* CPU utilization has changed */
> -			if (prev_delta < base_energy)
> -				return target;
> -			prev_delta -=3D base_energy;
> -			prev_actual_cap =3D cpu_actual_cap;
> -			best_delta =3D min(best_delta, prev_delta);
> -		}
> +		if (min_stat.fits < best_fits)
> +			continue;
> =20
> -		/* Evaluate the energy impact of using max_spare_cap_cpu. */
> -		if (max_spare_cap_cpu >=3D 0 && max_spare_cap > prev_spare_cap) {
> -			/* Current best energy cpu fits better */
> -			if (max_fits < best_fits)
> -				continue;
> +		/* Idle system costs nothing */
> +		target_stat.max_perf =3D 0;
> +		target_stat.cost =3D 0;
> =20
> -			/*
> -			 * Both don't fit performance hint (i.e. uclamp_min)
> -			 * but best energy cpu has better capacity.
> -			 */
> -			if ((max_fits < 0) &&
> -			    (cpu_actual_cap <=3D best_actual_cap))
> -				continue;
> +		/* Estimate utilization and cost without p */
> +		for_each_cpu(cpu, cpus) {
> +			unsigned long target_util;
> =20
> -			cur_delta =3D compute_energy(&eenv, pd, cpus, p,
> -						   max_spare_cap_cpu);
> -			/* CPU utilization has changed */
> -			if (cur_delta < base_energy)
> -				return target;
> -			cur_delta -=3D base_energy;
> +			/* Accumulate actual utilization w/o task p */
> +			pd_actual_util +=3D find_cpu_actual_util(cpu, p);
> =20
> -			/*
> -			 * Both fit for the task but best energy cpu has lower
> -			 * energy impact.
> -			 */
> -			if ((max_fits > 0) && (best_fits > 0) &&
> -			    (cur_delta >=3D best_delta))
> +			/* Get the max utilization of the CPU w/o task p */
> +			target_util =3D find_cpu_max_util(cpu, p, -1);
> +			target_util =3D min(target_util, cpu_actual_cap);
> +
> +			/* Current OPP is enough */
> +			if (target_util <=3D target_stat.max_perf)
>  				continue;
> =20
> -			best_delta =3D cur_delta;
> -			best_energy_cpu =3D max_spare_cap_cpu;
> -			best_fits =3D max_fits;
> -			best_actual_cap =3D cpu_actual_cap;
> +			/* Compute and save the cost of the OPP */
> +			find_pd_cost(pd->em_pd, target_util, &target_stat);
> +			max_cost =3D target_stat.cost;
>  		}

[Severity: Low]
Does target_util <=3D target_stat.max_perf leave max_cost at 0 when a busy
performance domain is capped with uclamp_max =3D 0?

When pd_actual_util > 0 but active tasks on the domain have UCLAMP_MAX =3D 0
(and UCLAMP_MIN =3D 0 with no IRQ or DL pressure), find_cpu_max_util()
returns 0 for every CPU.  Because target_stat.max_perf is initialized to 0,
find_pd_cost() is never called and max_cost stays 0 instead of the minimum
OPP cost, inflating delta_nrg by pd_actual_util * min_stat.cost below.

> +
> +		/* Add the energy cost of p */
> +		delta_nrg =3D task_util * min_stat.cost;
> +
> +		/*
> +		 * Compute the energy cost of others running at higher OPP
> +		 * because of p.
> +		 */
> +		if (min_stat.cost > max_cost)
> +			delta_nrg +=3D pd_actual_util * (min_stat.cost - max_cost);
> +
> +		/* Delta energy with p */
> +		trace_sched_compute_energy_tp(p, min_stat.cpu, delta_nrg,
> +					      min_stat.max_perf,
> +					      pd_actual_util + task_util);

[Severity: High]
Does computing delta_nrg =3D task_util * min_stat.cost underestimate the
energy cost when another CPU in the performance domain is already running
at a higher OPP (max_cost > min_stat.cost)?

min_stat.cost is derived from min_stat.cpu in isolation, whereas all CPUs
in the performance domain share the same frequency and run at
max(min_stat.cost, max_cost).  When a sibling CPU in a big domain is busy
at a high OPP and min_stat.cpu is idle, task p will execute at max_cost,
not min_stat.cost, so using min_stat.cost causes find_energy_efficient_cpu()
to underestimate the big domain's energy delta and misplace tasks onto it.
In addition, candidate CPUs in the first loop whose target_perf exceeds
min_stat.max_perf but remains at or below the domain's base OPP are skipped
even though they would not raise the domain's OPP cost above max_cost.

> +
> +		/*
> +		 * The probability that delta energies are equals is almost
> +		 * null. PDs being sorted by max capacity, keep the one with
> +		 * highest max capacity if this happens.
> +		 * TODO: add a margin in energy cost and take into account
> +		 * other stats.
> +		 */
> +		if (min_stat.fits =3D=3D best_fits &&
> +		    delta_nrg >=3D best_nrg)
> +			continue;
> +
> +		best_fits =3D min_stat.fits;
> +		best_nrg =3D delta_nrg;
> +		best_cpu =3D min_stat.cpu;
>  	}

[Severity: Medium]
When no performance domain satisfies uclamp_min (min_stat.fits =3D=3D -1 and
best_fits =3D=3D -1), does comparing delta_nrg >=3D best_nrg pick the small=
est
domain instead of the highest-capacity one?

Previously, when fits < 0 across candidate domains,
find_energy_efficient_cpu() compared cpu_actual_cap against best_actual_cap
and prev_actual_cap to come as close as possible to the uclamp_min request.
Because target_perf is clamped to cpu_actual_cap, a little domain clamps a
boosted task to a lower OPP and smaller delta_nrg than a big domain with
slight thermal pressure, so comparing delta_nrg places the boosted task on
the lowest-capacity domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D17
