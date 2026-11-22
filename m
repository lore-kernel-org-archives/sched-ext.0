Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795319587;
	b=vOOAxjEEPf4U3WZll6aQVgbZ7SZONLIom07L8TFnaUrczqf0a2NBLKWVEuRH3dHJ3UUZ
	 MImZKZtLUmUYOkeeBj7JIn01Z0wn4EZXk8s90zjADfjg7GN5qLNqmhZ2CAGPmAiDJfvBp
	 Ei/+DJg1VMyzoNDCUM/PH8ypgEweMvRDnrICkEotU2uesGIPLd7RiXqKzWO3Gz8Wd1pAU
	 pwjV85GAroBSnbbamWj4LDiacer/15hzezKDhCHhZRDMZid7JVQSIrzRc+kEhURnNzdzu
	 fL/rrhr6on5ogLNX7tGGucHpnPvoTfbmlJpwKkr8jvaXZafOvAxihT+NO/XJREAtfPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795319587;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vJPu+Rf9SAXs59OQIOL4e17BQX7RVy3mdcL/ls6TVhU=;
	b=Crm5PwVsg5WvAIzeqR9v5u0sfVeyM3Ro0lC0aN4D1QaZH+KxQvWj6p+B8/ncBjlXqgA4
	 csttuJ/Ms+22rJOFqxUOfBDMXwaceggehZpoU9jJlb+KjwoLtpqkmDnKgMAE5zB+s8RE9
	 Sa5Pfwc8ZUT38a5hU0OGZCbLkEplxEEuAoKKtUaeVe9i+fTBR94blgFjV10Vv3XbXwM2H
	 j3/2C+tyh4uAvycg75wY5tzDsKev8w6Tn/wwRyWa7Jdi3JL7/n9Jcnt04+7oxhQ8HTG8t
	 J+aZBUWmxrzJC53Cg8MBa7OgPJ4t+Svbv2ntZHMpBSYzVMNPO3xkNOiDXYpIGKdEL7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5aZuu3L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C824606A32C
	for <sched-ext@lists.linux.dev>; Sun, 22 Nov 2026 03:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5aZuu3L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA591F000C0;
	Sun, 22 Nov 2026 03:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795319586;
	bh=vJPu+Rf9SAXs59OQIOL4e17BQX7RVy3mdcL/ls6TVhU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=g5aZuu3LKXQOuyD8nZaeH5zNaowGRsGzql6IBEgvzxF6BTB7XIkIUEeZXGkxfwT9+
	 Gs7YiAZPTomqAsaeFAJBESeBm//FsmuXmADHM1P7UMjjykSraZo32tTce66RyZD82c
	 6wOEbZJdMK2kRUU6rh2QCZ8LLiaQqSvhFFKpxAzVHjRcs/vpBCfNRO5iRqSWtNEFzt
	 5WS1bm3VjilsXVM+JsYpA70gFfIF1r5wmgv2NQu/XdF3HyHQOHpoclKLwDE0oY7mtt
	 tINEBG5Sj5XYDWksN6WjfFTigOVKi8Nt9DE/6R5O8ctBUljptkBqA+hkUhP16NSr4h
	 AiYD+l2/95CWw==
Message-ID: <sashiko-outbox-227686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Update other_load_avgs on set_next_task_scx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peng Huang" <penghuang@google.com>, sched-ext@lists.linux.dev
In-Reply-To: <20261122033316.2819845-1-penghuang@google.com>
References: <20261122033316.2819845-1-penghuang@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 03:53:06 +0000
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
- [Medium] sched_ext: set_next_task_scx() misses PELT decay on idle and
  in ops.running()
--

commit 06ffe41f90ea50855b518361481cd90702ee1876
Author: Peng Huang <penghuang@google.com>

sched_ext: Update other_load_avgs on set_next_task_scx

This commit updates RT, DL, IRQ, and HW pressure load averages in
set_next_task_scx() when picking a new SCX task (SNT_PICK) in addition to
when SCX_RQ_CAN_STOP_TICK toggles.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index a9e36b5bb0386..f46553d8eb3b9 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3553,6 +3553,7 @@ static void kick_sync_wait_bal_cb(struct rq *rq);
>  static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum=
 snt_e type)
>  {
>  	bool first =3D type =3D=3D SNT_PICK;
> +	bool update_load_avgs =3D first;
>  	bool can_stop_tick;
> =20
>  	/*
> @@ -3619,10 +3620,6 @@ static void set_next_task_scx(struct rq *rq, struc=
t task_struct *p, enum snt_e t
>  	 * @p is getting newly scheduled or got kicked after someone updated its
>  	 * slice. Update SCX_RQ_CAN_STOP_TICK to reflect whether the tick can be
>  	 * stopped. See scx_can_stop_tick().
> -	 *
> -	 * Moreover, refresh the load_avgs just when transitioning in and out of
> -	 * nohz. In the future, we might want to add a mechanism to update
> -	 * load_avgs periodically on tick-stopped CPUs.
>  	 */
>  	if (can_stop_tick) {
>  		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
> @@ -3634,13 +3631,12 @@ static void set_next_task_scx(struct rq *rq, stru=
ct task_struct *p, enum snt_e t
>  			 */
>  			rq->scx.flags |=3D SCX_RQ_CAN_STOP_TICK;
>  			sched_update_tick_dependency(rq);
> -
> -			update_other_load_avgs(rq);
> +			update_load_avgs =3D true;
>  		}
>  	} else {
>  		if (rq->scx.flags & SCX_RQ_CAN_STOP_TICK) {
>  			rq->scx.flags &=3D ~SCX_RQ_CAN_STOP_TICK;
> -			update_other_load_avgs(rq);
> +			update_load_avgs =3D true;
>  		}
> =20
>  		/*
> @@ -3651,6 +3647,15 @@ static void set_next_task_scx(struct rq *rq, struc=
t task_struct *p, enum snt_e t
>  		if (tick_nohz_full_cpu(cpu_of(rq)))
>  			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
>  	}
> +
> +	/*
> +	 * Refresh other-class (RT/DL/IRQ/HW) load averages when picking a new
> +	 * task or toggling nohz tick dependency while CFS PELT is dormant.
> +	 * In the future, we might want to add a mechanism to update load_avgs
> +	 * periodically on tick-stopped CPUs.
> +	 */
> +	if (update_load_avgs)
> +		update_other_load_avgs(rq);
>  }

[Severity: Medium]
Does calling update_other_load_avgs() only in set_next_task_scx() leave
rq->avg_rt, rq->avg_dl, rq->avg_irq, and rq->avg_hw undecayed when an SCX
task goes idle after an RT or DL interval?

On an RT/DL -> SCX switch, put_prev_set_next_task() calls
put_prev_task_rt() or put_prev_task_dl(), which updates avg_rt or avg_dl
at rq_clock_pelt(rq), and then immediately calls set_next_task_scx() at
the same clock timestamp where no time has elapsed to decay those averages.
When the SCX task later blocks and the CPU goes idle without an
intervening tick, put_prev_set_next_task() calls put_prev_task_scx() and
set_next_task_idle() without calling set_next_task_scx(), so
update_idle_rq_clock_pelt() and effective_cpu_util() still see the
undecayed utilization from before the SCX task ran.

In addition, within set_next_task_scx(), update_other_load_avgs() runs
after scx_start_task_running() invokes ops.running(), so a BPF scheduler
calling scx_bpf_cpuperf_set() or scx_bpf_cidperf_set() from ops.running()
triggers effective_cpu_util() before the averages are refreshed, and
same-task repicks (SNT_REPICK) return early without updating them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122033316.2819=
845-1-penghuang@google.com?part=3D1
