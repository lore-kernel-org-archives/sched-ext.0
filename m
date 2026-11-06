Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981664;
	b=JZNfvSrHzYcXHDVNRMevO3iUnLi9zIQumSc9UiIqahHMBG6hL9BWZSdg5IDMpuf4igsX
	 UWNOI/Wf4W/Rs+Kdk8N9s+NTqsQLvnt7pWsqXjgeyxHrAjWD5oUbPl7IjP8tlCD1hE7gX
	 ++a5j2qOGYq0UjW/S9jamBXdr0GYUfkDBSnGdIgc1bTBBDF3yUhtq3j+Uw0jE/tJwjMA/
	 Hg0vws17cCuVD13Y5JehWHheNCLUhsL4JLMgkm1GiMs2/uk32oWHKHpaN6LapoMkiJAqG
	 LXYcrPm+ZTE6D+Bt2GBBO7pllRR6iT9WhiBGxi6LrVPnAsKkXNaB9Aoi+Lzqs+q+w+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981664;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vm5o4onyD5uDS8Z8SKPrjgrzVcJ9/BygDKtTcJ761wo=;
	b=AWshRfG8oaBDFvtl4butyUfRXcvubtqlSarY9kE2eQyiG+vwavGKO9gp9SGmof1MIp2u
	 OmlnOwZlxquircSNBFi3fM7QZqBF553LJfYnVFx4MPwsGDpQgS42DZ7Fhnj1X/Al9IjlW
	 HKcQyLaTtQKMeW+4bgY4I5coEGmENZQ++mPM7ALFiJqiJkHUHZREAPZA+KZmBLmx0wncu
	 2CgWcBeOMumXPL8QViwCRSMgLBRyAp702KmcKJe80hiLBTihu/EA3TI0PM3Ye4ClVx75X
	 DPQAY2vNyFiGjrKftT8dLrq2rnIytgXouW8+h2VTJ3a+EEnj807aFsNoiJVcZzQSkCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtO9ZcYl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03C606A326
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtO9ZcYl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BE61F0089F;
	Fri,  6 Nov 2026 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981663;
	bh=Vm5o4onyD5uDS8Z8SKPrjgrzVcJ9/BygDKtTcJ761wo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XtO9ZcYlp/OLWNEsxnLtkIDW9j0ifm/+mvZAlUPZ9Gs+22LLTf1LeAf9NeFUmTHpH
	 ywF51x/UrZQCWbAaBSyB986zDopYjc2edOggsZ/JauFE+CdNKZZYbxMLuVu0fONimg
	 rhSepRIYP7SU2zL6ctE6tZyEKrL+5yQ364yxfLf2eQufYmT77hp+mlJGSbOEgDb87z
	 kMvcb+zBUTB/xRDbHHg1DjGACBJXtG+t3y1yblIWgXOn49bmFBr4zhuX0QsJJC+yU8
	 eTY6YhzL3Kqzv+aOmY6fHO4Lr0iGEyWAFY9orMMGtPDjK06TaS/6fnI0dTZpF763l8
	 ZxX0NrWbBthFA==
Message-ID: <sashiko-outbox-201780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/20 v3] sched/eevdf: Push short slice task that are
 not picked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-15-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-15-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:14:23 +0000
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
- [High] sched/fair: fair_add_pushable_short() pushes running or blocked
  proxy tasks
- [Medium] sched/fair: set_next_task_fair() skips
  fair_queue_push_tasks() on SNT_REPICK
--

commit eb5888f994bf688f13c4e3add47c483f0c23831f
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/eevdf: Push short slice task that are not picked

This commit adds waking short-slice tasks to the cfs_rq pushable list in
wakeup_preempt_fair() so that they can be pushed to another CPU if they are
not picked to run next.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3923587b66e0e..894bee51b99ad 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10273,6 +10273,12 @@ static void fair_add_pushable_prev(struct rq *rq=
, struct task_struct *prev,
>  		__fair_add_pushable_task(rq, prev);
>  }
> =20
> +static void fair_add_pushable_short(struct rq *rq, struct task_struct *p)
> +{
> +	if (sched_push_task_enabled() && __check_pushable_fair_task(rq, p))
> +		__fair_add_pushable_task(rq, p);
> +}

[Severity: High]
With CONFIG_SCHED_PROXY_EXEC enabled, can fair_add_pushable_short() leave
an actively running proxy task or a mutex-blocked donor on
rq->cfs.pushable_tasks?

__check_pushable_fair_task() does not check !task_current(rq, p) or
!task_is_blocked(p).  If a short-slice mutex owner p wakes up and is added
to rq->cfs.pushable_tasks, and __schedule() picks a blocked donor D while
find_proxy_task() selects p as the execution context (rq->curr =3D p),
set_next_task_fair() only calls fair_remove_pushable_task(rq, D).  Likewise,
prio_changed_fair() and switched_to_fair() call wakeup_preempt_fair() when
p =3D=3D rq->curr !=3D rq->donor, adding rq->curr directly.

When fair_push_task() then calls pick_next_pushable_fair_task(), it hits
WARN_ON_ONCE(task_current(rq, p)) and still returns p, deactivating and
migrating rq->curr to another CPU while it is actively executing on
rq->cpu.  Similarly, when proxy_migrate_task() attaches a blocked donor via
wakeup_preempt(), fair_add_pushable_short() queues it to be pushed away
from its mutex owner's CPU and overwrites p->wake_cpu via set_task_cpu().

>  static int active_load_balance_cpu_stop(void *data);
> =20
>  /*
> @@ -10723,8 +10729,10 @@ static void wakeup_preempt_fair(struct rq *rq, s=
truct task_struct *p, int wake_f
>  preempt:
>  	cancel_protect_slice(se);
> =20
> -	if (preempt_action =3D=3D PREEMPT_WAKEUP_SHORT)
> +	if (preempt_action =3D=3D PREEMPT_WAKEUP_SHORT) {
>  		set_short_buddy(cfs_rq, pse);
> +		fair_add_pushable_short(rq, p);
> +	}
> =20
>  	resched_curr_lazy(rq);
>  }

[Severity: Medium]
Does set_next_task_fair() skip queuing the push callback when __schedule()
repicks the current donor (next =3D=3D prev)?

Before this change, tasks were only added to rq->cfs.pushable_tasks in
put_prev_task_fair(), which only runs when switching to a different task
(SNT_PICK).  When fair_add_pushable_short() adds p at wakeup and the
subsequent __schedule() repicks the current task (for example, if lazy
preemption delays __schedule() until pse is no longer eligible, or an
existing shorter-slice buddy in cfs_rq->next blocks before __schedule() and
curr has an earlier deadline), put_prev_set_next_task() calls
set_next_task_fair() with SNT_REPICK:

kernel/sched/fair.c:set_next_task_fair() {
	...
	if (type =3D=3D SNT_REPICK)
		goto repick;
	...
	fair_queue_push_tasks(rq);
repick:
	if (hrtick_enabled_fair(rq))
		hrtick_start_fair(rq, p);
}

Because SNT_REPICK jumps past fair_queue_push_tasks(rq), the unpicked
short-slice task remains on rq->cfs.pushable_tasks without queuing
fair_push_tasks().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D14
