Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979629;
	b=B7x5uJmGNbCc2glX3QKI6WHLiWRHAiNtt92gqNvUh0LJnCnZihbBcFP6CQAL1t/g+TBL
	 0qXBzFbbL1+vCdj/kfDRSP8+iEjgfvCYkrbA3MpJCRIAoHy7px6bhQQulGjmK81nhM+ar
	 sslWH38Rg1gwRBEiLaeQPTyWCiTUqFbzG0tE1kESxLYgk3RIjF/cIC4ZflJvyxiULTfJn
	 VxzoY8Q1i0CmlLomnDq4fR1Xt/P3Ypkg2t08QC/KgCUZrBGdRVCWBDKRCBEyUg8bBnX8n
	 SRDgVWqZE7zzj+1CNRUcBNKfZ5cfOMPDcDN2p57Pmm/OyjmxooOxkZEQdHFWdVHae5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979629;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=apH/EhYm9c9k/UizJtRRsjt14DDwpxY9z8GRWCmP3gI=;
	b=DyfUJtABLUeGisQ8yIr1CvIUaMHZNsWOQvC+yIWCB/HnW7fc1kfWCMVreKsKyWG8TREm
	 C1l6gjGZoPpc5zMYDhS1ZGzJb9GVBdZW+8W6ojbprPWlot3Nqo8DjUjYoSPsFZGEqlT5y
	 ivbEUGWB2uyMmaTBwM9OeCP/gb515BVsim7CTYXZZTcSzfhxYuI0bSnG52+eUNCNjsilY
	 wqL8/21Z3kToAsA+fvsKb9Ww7JTyX9tEbu0NYXBafHkA/LPrcWeCgkTeJmELhUTa9w6oW
	 11sicLfWSYZ7prtSiYV+9p3oDItHiS5w/S0boeaEVE+tHYs6vfqRErGTGO9HCGeSGCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcHbXowN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5957606A326
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcHbXowN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D48C1F0089F;
	Fri,  6 Nov 2026 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979628;
	bh=apH/EhYm9c9k/UizJtRRsjt14DDwpxY9z8GRWCmP3gI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kcHbXowNSsxWq4txVCKbGqISjSXN8K7gAA9Ghb5RGF42zHe+wmkRj3Y7xz9PlTVHx
	 H6eJ6mm9iTLY5nW+uCbR4oqPBkLkpd3iwD3YSMb9EEbkqCvROSsnba/Hc8RdOHjrkY
	 AF6XavZ/8uuRwWU0mRxA86fYUWSRPyqC18+mZqB2wlKApZ/il84sJaxnTr0L+a8OaZ
	 E3sq2MfAOfRqBO/JBGKEb+JHM14eELAzAyJhyPWR2FjuSuFObY/Ee4UMBH2yeuBWOW
	 mmJfYhwHDIDkkKMdlJc8buJ+sorj66y5kug4lV1gLu6jZrn3ESZSgmDq8aWKIKiq5Q
	 +MUNfLHCmOTFw==
Message-ID: <sashiko-outbox-201717@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when
 selecting CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-7-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-7-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:40:27 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] sched/fair: broken busy CPU ranking and SMT bias in
  select_idle_capacity()
--

commit 67b6addf19b77860d43186abca2f383d2cb45b72
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/eevdf: Add min slice check when selecting CPU

This commit adds a fallback CPU selection tier in select_idle_cpu(),
select_idle_core(), and select_idle_capacity() that picks a CPU whose
runqueue min_slice is larger than the waking task's slice when no idle CPU
is found.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cfc99b94d9ce9..039dce244aaaf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
[ ... ]
> @@ -9091,24 +9123,26 @@ static int select_idle_cpu(struct task_struct *p,=
 struct sched_domain *sd, bool
>   *   ASYM_IDLE_THREAD_MISFIT          0   thread  Busy SMT sibling; capa=
city
>   *                                                does not fit.
>   *
> - * ASYM_IDLE_CORE_BIAS (-3) is an offset, not a state. On an idle core,
> + * ASYM_IDLE_CORE_BIAS (-4) is an offset, not a state. On an idle core,
>   * fits +=3D ASYM_IDLE_CORE_BIAS rebases thread-tier ranks into the core=
 tier:
>   *
> - *   ASYM_IDLE_THREAD_UCLAMP_MISFIT (-1) + BIAS -> ASYM_IDLE_UCLAMP_MISF=
IT   (-4)
> - *   ASYM_IDLE_THREAD_MISFIT         (0) + BIAS -> ASYM_IDLE_COMPLETE_MI=
SFIT (-3)
> + *   ASYM_IDLE_THREAD_UCLAMP_MISFIT (-1) + BIAS -> ASYM_IDLE_UCLAMP_MISF=
IT   (-5)
> + *   ASYM_IDLE_THREAD_MISFIT         (0) + BIAS -> ASYM_IDLE_COMPLETE_MI=
SFIT (-4)
>   *
> - * ASYM_IDLE_THREAD_FITS (-2) is never rebased because a fully-fitting i=
dle-core
> + * ASYM_IDLE_THREAD_FITS (-3) is never rebased because a fully-fitting i=
dle-core
>   * candidate early-returns from select_idle_capacity().
>   */
>  enum asym_fits_state {
> -	ASYM_IDLE_UCLAMP_MISFIT =3D -4,
> +	ASYM_BUSY_FITS =3D -6,
> +	ASYM_IDLE_UCLAMP_MISFIT,
>  	ASYM_IDLE_COMPLETE_MISFIT,
>  	ASYM_IDLE_THREAD_FITS,
> +	ASYM_BUSY_THREAD_FITS,
>  	ASYM_IDLE_THREAD_UCLAMP_MISFIT,
>  	ASYM_IDLE_THREAD_MISFIT,
> =20
>  	/* util_fits_cpu() bias for idle core */
> -	ASYM_IDLE_CORE_BIAS =3D -3,
> +	ASYM_IDLE_CORE_BIAS =3D -4,
>  };
[ ... ]
> @@ -9160,42 +9196,49 @@ select_idle_capacity(struct task_struct *p, struc=
t sched_domain *sd, int target)
>  		if (!has_idle_core && --nr <=3D 0)
>  			return best_cpu;
> =20
> -		if (!choose_idle_cpu(cpu, p))
> -			continue;
> -
>  		fits =3D util_fits_cpu(task_util, util_min, util_max, cpu);
> =20
> -		/*
> -		 * Perfect fit: capacity satisfies util + uclamp and the CPU
> -		 * sits on a fully-idle SMT core, this is a !SMT system, or
> -		 * there is no idle core to find.
> -		 * Short-circuit the rank-based selection and return
> -		 * immediately.
> -		 */
> -		if (fits > 0 && preferred_core)
> -			return cpu;
> -		/*
> -		 * Only the min performance hint (i.e. uclamp_min) doesn't fit.
> -		 * Look for the CPU with best capacity.
> -		 */
> -		else if (fits < 0)
> +		if (choose_idle_cpu(cpu, p)) {
> +			/*
> +			 * Perfect fit: capacity satisfies util + uclamp and the CPU
> +			 * sits on a fully-idle SMT core, this is a !SMT system, or
> +			 * there is no idle core to find.
> +			 * Short-circuit the rank-based selection and return
> +			 * immediately.
> +			 */
> +			if (fits > 0 && preferred_core)
> +				return cpu;
> +			/*
> +			 * Only the min performance hint (i.e. uclamp_min) doesn't fit.
> +			 * Look for the CPU with best capacity.
> +			 */
> +			else if (fits < 0)
> +				cpu_cap =3D get_actual_cpu_capacity(cpu);
> +			/*
> +			 * fits > 0 implies we are not on a preferred core, but the util
> +			 * fits CPU capacity. Set fits to ASYM_IDLE_THREAD_FITS
> +			 * so the effective range becomes
> +			 * [ASYM_IDLE_THREAD_FITS, ASYM_IDLE_THREAD_MISFIT], where:
> +			 *    ASYM_IDLE_THREAD_MISFIT - does not fit
> +			 *    ASYM_IDLE_THREAD_UCLAMP_MISFIT - fits with the exception of UCL=
AMP_MIN
> +			 *    ASYM_BUSY_THREAD_FITS - fits with the exception of idleness
> +			 *			      but can preempt current
> +			 *    ASYM_IDLE_THREAD_FITS - fits with the exception of preferred_co=
re
> +			 */
> +			else if (fits > 0)
> +				fits =3D ASYM_IDLE_THREAD_FITS;
> +
> +		} else if (fits > 0 && task_slice < get_rq_min_slice(cpu_rq(cpu))) {
> +			fits =3D ASYM_BUSY_THREAD_FITS;
>  			cpu_cap =3D get_actual_cpu_capacity(cpu);
> -		/*
> -		 * fits > 0 implies we are not on a preferred core, but the util
> -		 * fits CPU capacity. Set fits to ASYM_IDLE_THREAD_FITS
> -		 * so the effective range becomes
> -		 * [ASYM_IDLE_THREAD_FITS, ASYM_IDLE_THREAD_MISFIT], where:
> -		 *    ASYM_IDLE_THREAD_MISFIT - does not fit
> -		 *    ASYM_IDLE_THREAD_UCLAMP_MISFIT - fits with the exception of UCLA=
MP_MIN
> -		 *    ASYM_IDLE_THREAD_FITS - fits with the exception of preferred_core
> -		 */
> -		else if (fits > 0)
> -			fits =3D ASYM_IDLE_THREAD_FITS;
> +		} else {
> +			continue;
> +		}
> =20
>  		/*
>  		 * If we are on a preferred core, translate the range of fits
> -		 * of [ASYM_IDLE_THREAD_UCLAMP_MISFIT, ASYM_IDLE_THREAD_MISFIT] to
> -		 * [ASYM_IDLE_UCLAMP_MISFIT, ASYM_IDLE_COMPLETE_MISFIT].
> +		 * of [ASYM_BUSY_THREAD_FITS, ASYM_IDLE_THREAD_MISFIT] to
> +		 * [ASYM_BUSY_FITS, ASYM_IDLE_COMPLETE_MISFIT].
>  		 * This ensures that an idle core is always given priority over
>  		 * (partially) busy core.
>  		 *
> @@ -9219,15 +9262,17 @@ select_idle_capacity(struct task_struct *p, struc=
t sched_domain *sd, int target)
> =20
>  	/*
>  	 * A value in the [ASYM_IDLE_UCLAMP_MISFIT, ASYM_IDLE_COMPLETE_MISFIT]
> -	 * range means the chosen CPU is in a fully idle SMT core. Values above
> -	 * ASYM_IDLE_COMPLETE_MISFIT mean we never ranked such a CPU best.
> +	 * range mean the chosen CPU is in a fully idle SMT core. Values
> +	 * ASYM_BUSY_FITS or above ASYM_IDLE_COMPLETE_MISFIT mean we never
> +	 * ranked such a CPU best.
>  	 *
>  	 * The asym-capacity wakeup path returns from select_idle_sibling()
>  	 * after this function and never runs select_idle_cpu(), so the usual
>  	 * select_idle_cpu() tail that clears idle cores must live here when the
>  	 * idle-core preference did not win.
>  	 */
> -	if (has_idle_core && best_fits > ASYM_IDLE_COMPLETE_MISFIT)
> +	if (has_idle_core && (best_fits > ASYM_IDLE_COMPLETE_MISFIT ||
> +			      best_fits =3D=3D ASYM_BUSY_FITS))
>  		set_idle_cores(target, false);
> =20
>  	return best_cpu;

[Severity: High]
Does select_idle_capacity() rank busy CPUs ahead of idle CPUs and idle SMT
cores?

In select_idle_capacity(), lower fits values are more preferred
(fits < best_fits), and preferred_core is computed as
!has_idle_core || is_core_idle(cpu).  is_core_idle() assumes its argument
was already checked for idleness and only tests SMT siblings:

kernel/sched/fair.c:is_core_idle() {
	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
		if (cpu =3D=3D sibling)
			continue;

		if (!idle_cpu(sibling))
			return false;
	}

	return true;
}

On a partially busy SMT core where thread A is busy (fits > 0 and
task_slice < get_rq_min_slice(cpu_rq(A))) and its sibling thread B is idle,
is_core_idle(A) returns true while is_core_idle(B) returns false.  Busy
thread A therefore gets preferred_core =3D=3D true and is biased from
ASYM_BUSY_THREAD_FITS (-2) by ASYM_IDLE_CORE_BIAS (-4) to
ASYM_BUSY_FITS (-6), whereas its idle sibling B gets
ASYM_IDLE_THREAD_FITS (-3), so select_idle_capacity() stacks the waking
task onto the busy thread instead of its idle sibling on the same core.

Even on !SMT systems (or when has_idle_core is false), preferred_core is
true for every CPU, biasing any fitting busy CPU with a larger min_slice to
ASYM_BUSY_FITS (-6) so it beats completely idle cores/CPUs ranked at
ASYM_IDLE_UCLAMP_MISFIT (-5) or ASYM_IDLE_COMPLETE_MISFIT (-4).  When
has_idle_core is true and a candidate with ASYM_BUSY_FITS (-6) outranks an
idle core (-5 or -4), best_fits =3D=3D ASYM_BUSY_FITS also calls
set_idle_cores(target, false) while fully idle cores still exist in the
domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D6
