Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980842;
	b=k46FHN7cYJJ4T0m0ZCOBxvhqTO6/y7BGlofMXCSTlDFwkgTPIxPERjh8f2uhQIIhJuab
	 ZeakC74ZZ4lIfdOR0Vej/rrIDO0KOvZJZi3s0msd3UfKYpoEuSNRGG1PhYL/oz6SvzUAy
	 VUAteV6MQPD65QL9p98Pht1D5pJOMXaBXbwrc9Tj6viGWQzdn0m2exZaMre9sFww0vjWl
	 rNZqi810/uJ6Fs38BKAFbbNc8rBsrUWZXAhOuAT6L4X6DQqrc7wi5ubeGeRjA5MzqopO7
	 MDvFwsKWk3NxHViCuEctNh3dUGaWtoTX0xfiJGW1P6FxubhO5ZWQ58QZZy7f/icNWjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U2fj1wx7x/MZTHzkaYY/7/zDMysPCxckUPzh+29/95o=;
	b=zv5jD/lBOl+LwmGE66ZofEnFLgodT9gAeaUULWpziAH2WSU1rEIxgVOmT5r47aesaDPL
	 2Vjre4MgIL7bWZwKlU2M5aw7DdRbqqc/0Wb2v/qE6KQ7iyAZhP+O4XP9v+IQk+htJouEN
	 +U2VULTqn7FA+04M7/Q/gnNiq/pchc/1MnYNnkkjVMN8D7PJx2F82Lw5k6vIPySOSUaUd
	 abb9Rp90dSofDiVpQCIIW0Qq+QyMF95eUSum20PS7ghR7+JKtqpjZsdX+Cf1aeajgWJ5n
	 Hf+Jc2clzRJQWtX5r4b32t4ATPB3lzSdIpOChUu4B+MEHSdmh2ScPD+or5tX4/mdsAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLTsW2Go;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3A606A326
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLTsW2Go
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1A41F0089F;
	Fri,  6 Nov 2026 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980841;
	bh=U2fj1wx7x/MZTHzkaYY/7/zDMysPCxckUPzh+29/95o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KLTsW2Go+KWh7kys6afalHN7+aGXpSN0ypnqY7HkiRmDQ3M1HCjsNCQoyIW7vWT7o
	 dJDkvOx9bhfurHiCoTV/hDHUweQhKJSMfmRrIl8etkzfuuN0ZvINCiWu9NuGTOPLpp
	 vCQtwbPG89dcuUqISRtEkcNTemmn4/C8gM1xhdYW7ewO31oSTk3HuS5tGcLL1AMpWu
	 YM0rk0yZa4bx8Y7W4lVsGUwW71B9rimncIjzIQZZKyZO2Hji7OsVgKrksJ0lAAAguS
	 BFdws89CpvXz6P1ZPB9UVUVIsgOqjl6ZA03rWj3IblFbz3pd33ac05qzocmd6P99/L
	 Bn6qylH2HkDhw==
Message-ID: <sashiko-outbox-201755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/20 v3] sched/fair: Optimize push task mechanism for
 fair
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-10-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-10-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:00:40 +0000
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
- [Medium] sched/fair: unpinned rq lock and double clock update in
  fair_push_task()
--

commit 9e72e6e57764d3850fa10b1a2d1c221ab1149151
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/fair: Optimize push task mechanism for fair

This commit replaces the runqueue unlock and task_rq_lock() sequence in
fair_push_task() with a raw_spin_trylock() on next_task->pi_lock and
open-coded task migration to new_rq.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e37f8b55a2934..e2999d3f88e46 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10148,8 +10148,7 @@ static bool fair_push_task(struct rq *rq)
>  {
>  	struct task_struct *next_task;
>  	int prev_cpu, new_cpu;
> -	struct rq_flags rf;
> -	struct rq *cur_rq;
> +	struct rq *new_rq;
> =20
>  	next_task =3D pick_next_pushable_fair_task(rq);
>  	if (!next_task)
> @@ -10158,38 +10157,41 @@ static bool fair_push_task(struct rq *rq)
>  	if (is_migration_disabled(next_task))
>  		return true;
> =20
> -	/* We might release rq lock */
> -	get_task_struct(next_task);
> -
>  	prev_cpu =3D rq->cpu;
> =20
>  	/*
> -	 * We need to release rq lock and take both task and rq w/o
> -	 * triggering a deadlock.
> +	 * The safe lock ordering for task and rq is task 1st then rq but we
> +	 * already get the rq so just try to get task too. If task is already
> +	 * locked, it is waiting for the rq's lock and it is about to change
> +	 * task state so skipping the push sequence in order to speed up the
> +	 * release of the lock is the best choice.
>  	 */
> -	raw_spin_rq_unlock(rq);
> -
> -	cur_rq =3D task_rq_lock(next_task, &rf);
> -
> -	/* Task already migrated */
> -	if (cur_rq->cpu !=3D prev_cpu)
> -		goto skip_push;
> +	if (!raw_spin_trylock(&next_task->pi_lock))
> +		return true;
> =20
>  	new_cpu =3D select_task_rq_fair(next_task, prev_cpu, 0);
> =20
>  	/* Task doesn't need to migrate */
>  	if (new_cpu =3D=3D prev_cpu)
> -		goto skip_push;
> +		goto no_push;
> +
> +	new_rq =3D cpu_rq(new_cpu);
> =20
> -	update_rq_clock(cur_rq);
> -	cur_rq =3D move_queued_task(cur_rq, &rf, next_task, new_cpu);
> +	deactivate_task(rq, next_task, 0);
> +	set_task_cpu(next_task, new_cpu);
> +	raw_spin_rq_unlock(rq);
> =20
> -skip_push:
> -	task_rq_unlock(cur_rq, next_task, &rf);
> +	raw_spin_rq_lock(new_rq);
> +	WARN_ON_ONCE(task_cpu(next_task) !=3D new_cpu);
> +	activate_task(new_rq, next_task, 0);
> +	wakeup_preempt(new_rq, next_task, 0);
> +	raw_spin_rq_unlock(new_rq);
> =20
> -	/* Restore rq state */
> +	/* Restore rq lock state */
>  	raw_spin_rq_lock(rq);

[Severity: Medium]
Does replacing move_queued_task() with open-coded locking and
deactivate_task(rq, next_task, 0) trigger double-clock-update warnings and
skip runqueue lock pinning?

fair_push_task() runs from __balance_callbacks() after the caller has
updated rq's clock (setting RQCF_UPDATED in rq->clock_update_flags) and
called rq_unpin_lock(), which leaves RQCF_UPDATED set.  Calling
deactivate_task(rq, next_task, 0) without DEQUEUE_NOCLOCK calls
dequeue_task() -> update_rq_clock(rq) while RQCF_UPDATED is still set,
triggering WARN_ON_ONCE(rq->clock_update_flags & RQCF_UPDATED) under
WARN_DOUBLE_CLOCK and setting SCX_RQ_CLK_VALID after rq_unpin_lock() has
already invalidated it.

On new_rq, using raw_spin_rq_lock() and raw_spin_rq_unlock() instead of
rq_lock()/rq_unlock() (or attach_one_task()) skips rq_pin_lock() and
rq_unpin_lock().  Because the previous lock holder on new_rq also left
RQCF_UPDATED set upon rq_unpin_lock(), activate_task() -> enqueue_task() ->
update_rq_clock(new_rq) triggers the same RQCF_UPDATED warning on new_rq,
bypasses lockdep pinning and assert_balance_callbacks_empty(), and leaves
SCX_RQ_CLK_VALID set after unlocking new_rq.

Passing DEQUEUE_NOCLOCK to deactivate_task() (since rq's clock was updated
before __balance_callbacks()) and using attach_one_task(new_rq, next_task)
would avoid both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D9
