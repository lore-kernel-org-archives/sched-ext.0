Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979582;
	b=oVxIsgYEzYDSW6z/pltAuTLK9IOOHNR4EhPRC7j0rhkm7/4LxhmsQXy01YJRYGlu8F07
	 wDuwxrHPvLD7PiU7NbxaqiEm5AsOztW2c/yNO+8bhzoiLC1pEcJjclDhgvXd9kqTOk80l
	 kLlx19swrG5ONc9Zigc7syDF6Y0qvxo1HyLkNeJA+P2tks2ALMxHFbRCwK/pGZF0/88xg
	 OnC6q07cdLnyXsE8WyZOqblud7QQiHFh2EJW7j5gCeSmk4HSKwl2fxLIfNIXhc2LVRYSA
	 1lAbBW/YP7xnte/zcSljFxKN1cpMNCSc2F7x1fPy3TrPXckRQNeuJHMhSzj/jMLCmOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979582;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m2MOwziZgOA/mLSX0c95iPjgK4yw2bfTBfiBdo3jZ18=;
	b=pXAdc0H4+qIwm/xyki3rHTqoEdpPKrM9ICa18zAs0Th1Wf5GfRA1sYlnHT4u60vz+hef
	 yhMth/lCu5ut128L/+V2Y2sBP3GDeijSJynJK6afV21ownSrQTVSO7xB+8yVxMazxjpOL
	 288kqSXMeWDcVLPWn18jCacmnoelXZjL7oVs2QENmPZObA9RzzR7UddC/7RxEcYzsozm3
	 9Ojl689bf/B1d89/eTkNNrvp9LQgcN4bF5+WEIGHneSb0vm02Oub+bz4eVuv4r1vZtAg6
	 90rmjO7OwhIvilkvLY/9Bm8S82tn7i2LxX5VR/FDthx78vkaRkuKfTsQ1L5oo6ZcMYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lg+TTFqO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686C606A326
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lg+TTFqO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43291F0089F;
	Fri,  6 Nov 2026 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979581;
	bh=m2MOwziZgOA/mLSX0c95iPjgK4yw2bfTBfiBdo3jZ18=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Lg+TTFqOxPiBhIreIQHgio5BFii4cMALUB59/LnKEarx58MzqjZME4WT0wXO8+x7B
	 OX2FaWOjn+iEaOnbAKGXf5jvMUlkvHQzvKZRxVK/pazv8Fe9PoLeBaP3yNRAIWhjfF
	 UPs+4W5yB5t9HeWkzt5o5+mVULsbPVzLu+TU7V3KI/s4dgBLKF5EUUOb8wB1yLyfaG
	 sQgubv0I2Et+yHKK+gOuTlpQ9/n3KDfQHZS6Kx4oOpOF4+r6DRmKlpIrUFabDuM1xE
	 5eVvoiJ9UKt8jTa0hEUbyOIvxEhU6whNbQnyEYs0x6NKmWRQUrmyygetQqbirKIx/Q
	 ktY4iWjMHwljg==
Message-ID: <sashiko-outbox-201714@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/20 v3] sched/fair: Prepare select_task_rq_fair() to
 be called for new cases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-8-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-8-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:39:41 +0000
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
- [Medium] sched/fair: wrong util_est accounting in cpu_util() for
  queued tasks in EAS
--

commit f7c7d33efb0b25325db58a563bdf908f556cfdaa
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/fair: Prepare select_task_rq_fair() to be called for new cases

This commit updates select_task_rq_fair() and its helpers so that runqueue
selection can be invoked for already-queued runnable tasks outside of
wake-up, exec, and fork, routing those cases through EAS and
select_idle_sibling().

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 039dce244aaaf..8f99c8bf1a80d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
[ ... ]
> @@ -9912,7 +9924,7 @@ static int find_energy_efficient_cpu(struct task_st=
ruct *p, int prev_cpu)
> =20
>  	target =3D prev_cpu;
> =20
> -	sync_entity_load_avg(&p->se);
> +	sync_task_load_avg(p);
>  	if (!task_util_est(p) && p_util_min =3D=3D 0)
>  		return target;
> =20
> @@ -10060,46 +10072,55 @@ static int find_energy_efficient_cpu(struct tas=
k_struct *p, int prev_cpu)
[ ... ]
> -		if (!is_rd_overutilized(this_rq()->rd)) {
> -			new_cpu =3D find_energy_efficient_cpu(p, prev_cpu);
> -			if (new_cpu >=3D 0)
> -				return new_cpu;
> -			new_cpu =3D prev_cpu;
> -		}
> +	/*
> +	 * We don't want EAS to be called for exec or fork but it should be
> +	 * called for any other case such as wake up or push callback.
> +	 */
> +	if (!is_rd_overutilized(this_rq()->rd) && want_sibling) {
> +		new_cpu =3D find_energy_efficient_cpu(p, prev_cpu);
> +		if (new_cpu >=3D 0)
> +			return new_cpu;
> +	}

[Severity: Medium]
When find_energy_efficient_cpu() is called for a task that is already
queued on prev_cpu, does cpu_util() miscalculate util_est across the
performance domain?

find_energy_efficient_cpu(), eenv_pd_busy_time(), and eenv_pd_max_util()
evaluate each CPU in the performance domain by calling cpu_util(cpu, p,
dst_cpu, ...).  While cpu_util() guards util_avg and runnable_avg updates
with add_task and sub_task, its UTIL_EST handling assumes EAS is only
called on wake-up (when p is dequeued) and that a queued task is only
passed for its own CPU via cpu_util_without():

kernel/sched/fair.c:cpu_util() {
    ...
		if (dst_cpu =3D=3D cpu)
			util_est +=3D _task_util_est(p);
		else if (p && unlikely(task_on_rq_queued(p) || current =3D=3D p))
			lsub_positive(&util_est, _task_util_est(p));
    ...
}

When p is queued on prev_cpu, cfs_rq->avg.util_est on prev_cpu already
includes _task_util_est(p).  Evaluating cpu =3D=3D prev_cpu with dst_cpu =
=3D=3D
prev_cpu adds _task_util_est(p) a second time, and evaluating any other
CPU in the performance domain with dst_cpu !=3D cpu subtracts
_task_util_est(p) from that unrelated CPU's util_est, skewing capacity
fitness checks and energy estimates in EAS.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D7
