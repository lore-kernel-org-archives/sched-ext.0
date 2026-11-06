Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981817;
	b=CX7IFJ4F+rqlOkSqy7tKzVch0O0DbmLrHFcNQVyRworMhVdeg9XE2nEeiVK/ch6SYSZR
	 vRRc9w+HSjlMkgyTE4pu6lVq2hU66Qin2vEgt/1mQa4H1VyjUEnLRn9ZToRyseeydyr9h
	 MgPBEATAyDCZQQot6VWSFnQQ1ViT6vGKUPbVNC0Q5Y5udfg/i5436MCx67LF5FyGZ75lN
	 EBQcu9kTXSrQ/KmOyRYv2H0dsrmXJNx3Je5n9jnU+lb9hw6dsDULRNafeepOQNyRjsg8V
	 3Wyv6c7ycmClTAbR1z+1qRK0GSvlR9W+OZYEW2O3beJXIaJLDkNrwV0PaNQFPuB6RYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VonbMyFhnA2i7SQjUmvxB1jy/oGcJr4XxKuHj3TbwZI=;
	b=u37ij3nHVPfhIj1ev6lC2SAzmkZQrKdX/vYCArZEDHTNkTc6g2cy/C/eDkCQ+lLQ2Z8I
	 aCSSO+JkfxKL/MQ2lb5IxrXIy2bqfrCb4qZ3IZ/OuvhJGEMAlGFzCTknVN8BDo3w9f/JN
	 nNoFMkXCezw+Emzha9tkEC6Q89LOAPiSdDzgeHHGUm96SNDOn33Ty+hrHo9Vy2gDBmN6e
	 flTrIwUYBRt4LXyBaDmyDCFnuOggxMnJntEeTxRIxLrt7SidjwWBYSw4T2ekJuqHG+zdR
	 jFd9QIA3RZS2AKRuVS8ePlpWmMJCXugUW192JXWZH1J3kX/zwFr+Ib+uCqwxM/Jge5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJM1l8Ms;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F0606A330
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJM1l8Ms
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A771F008A4;
	Fri,  6 Nov 2026 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981816;
	bh=VonbMyFhnA2i7SQjUmvxB1jy/oGcJr4XxKuHj3TbwZI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hJM1l8MsRwZqEEu0p+fu+w0aLOdmVrU4RRopmBIAZdMFHldYup5PA+G3YGHLLltsc
	 tGUcGZ5ncSZ72O1ZZeIsg46jUdrKPN1+IrG2qJzHX6C9O6ll5/fwUw/RvrYmOWnL1S
	 a8k3jajxsGWGtNzkSbYiqpFTk1XF623n82PaSWL3o68n3vXVX0GKXxsGlltrPfDatG
	 SaeGAQYEhhiw+kp+hiR60DZgEacNgtWkxNF4FxysKAS3E9l45TbbOEY/0/byKhpjWQ
	 8LZ6WTus41g6zsOYB88YzTzrf9uolnhDBON0AnKZSIkoBiAPYgh0VZpSVrfQKa9ZiS
	 RUWxdt8SEzwVw==
Message-ID: <sashiko-outbox-201788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/20 v3] sched/fair: Add force push task mechanism for
 fair
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-12-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-12-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:16:55 +0000
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
- [Medium] sched/fair: invalid context-analysis lock annotations in
  tick_push_task()
--

commit 812d6d21d9e8beba5616aab34cbd01968025de29
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/fair: Add force push task mechanism for fair

This commit adds tick_push_task() to task_tick_fair() so a single runnable
task on a CPU can be pushed to a better CPU via active load balance on
the scheduler tick.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3bcb663ebcde2..f2a0d2c2bb632 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10233,6 +10233,75 @@ static void fair_add_pushable_prev(struct rq *rq=
, struct task_struct *prev,
>  		__fair_add_pushable_task(rq, prev);
>  }
> =20
> +static int active_load_balance_cpu_stop(void *data);
> +
> +/*
> + * See if the alone task running on the CPU should migrate on a better t=
han
> + * the local one.
> + */
> +static inline bool tick_push_task(struct task_struct *p, struct rq *rq, =
struct rq_flags *rf)
> +	__releases(__rq_lockp(rq))
> +	__acquires(__rq_lockp(rq))
> +{
> +	int new_cpu, cpu =3D cpu_of(rq);
> +
> +	if (!sched_push_task_enabled())
> +		return false;

[ ... ]

> +	preempt_disable();
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +	stop_one_cpu_nowait(cpu,
> +			    active_load_balance_cpu_stop, rq,
> +			    &rq->active_balance_work);
> +	preempt_enable();
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);
> +
> +	return true;
> +}
> +
>  /*
>   * select_task_rq_fair: Select a target runqueue for the task.
>   * There are 2 ways to select the target runqueue:
> @@ -15713,8 +15782,10 @@ static void task_tick_fair(struct rq *rq, struct=
 task_struct *curr, struct rq_fl
> =20
>  	task_tick_cache(rq, curr);
> =20
> -	update_misfit_status(curr, rq);
> -	check_update_overutilized_status(task_rq(curr));
> +	if (!tick_push_task(curr, rq, rf)) {
> +		update_misfit_status(curr, rq);
> +		check_update_overutilized_status(task_rq(curr));
> +	}
> =20
>  	task_tick_core(rq, curr);
>  }

[Severity: Medium]
Should tick_push_task() be annotated with __must_hold(__rq_lockp(rq))
instead of pairing __releases(__rq_lockp(rq)) with
__acquires(__rq_lockp(rq))?

Under CONFIG_WARN_CONTEXT_ANALYSIS=3Dy (enabled for fair.o via
CONTEXT_ANALYSIS_fair.o :=3D y), __releases() requires the lock to be held
on entry and unlocked on exit, while __acquires() requires the lock to be
unlocked on entry and held on exit.  Applying both to __rq_lockp(rq) on a
function that enters and exits with the rq lock held (including on the
early return paths that never drop the lock) triggers Clang
-Wthread-safety warnings.

Like sched_balance_newidle(), tick_push_task() and its caller
task_tick_fair() need __must_hold(__rq_lockp(rq)) (or
lockdep_assert_rq_held(rq) in task_tick_fair()) to satisfy context
analysis.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D11
