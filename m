Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659F3D5668
	for <sched-ext@lists.linux.dev>; Fri, 11 Sep 2026 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789166552; cv=none; b=DQpitc9gxf4xSucnt5q+L4LQaiCs+GRTVFbemTENlLNfL/jzKTNr0lefvCvTwT8RfMBcxbjO+rOJH8Gwm9lJVS6/KUrmqWjjVlihgtOmNuWtL6D4tNwMrZz8F+MANrHWMdI3cv2BaYHjZb58jsSXXHJ9F7tEpV57jd3OCBC6QQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789166552; c=relaxed/simple;
	bh=gUu8CYJvxWl+zpqb3I/dSyYbpwgEi4pMVXfYYMu6OCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wf3bk+y4QOAImyygAYlOOpZyc3RK9bJs8952aFA5yz/ch3JdGvZOGN6S+zxih1zce+eYLI3rsbn9/VZqClmBLqbUM3lnpvNSr1oZwupct9/b9bgOfWd+x8EOJWVUlhAVwZKcX9K3Am75mDDRhlKkDWFBghJ84JW3hZN7y4JvvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtZLN8fW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtZLN8fW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19611F000FF;
	Fri, 11 Sep 2026 22:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789166550;
	bh=NTwLZJOsRdwfLFyLq3oP6okexFWgioV6AA+nBNG9jRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UtZLN8fWhpqseuCcIp04Q1v8c1uyNsBh8NkYAFh+ruW9aKG1I7dGIXdPgdvmfTgYF
	 xa+QT0ehBQhGH4mmxIHbPE8QpLCggCn5tyOa9wffPISEzNqI1D66z0njzIj4mOpWld
	 /r55biOJp5/NJAA90EshFB04ov1+XhXVM8uHmFh6va9btGTLLcZ5FbxhrIv5Um/Mlx
	 Lc35OA5zjqJS/cHCX8yfMqqTiH8z/YM/G6As8p36Pml6jKGLF2FlTnZy/496so3Fs9
	 vu9mcgUeR2ukRYZtilyCg+eA0FdA4UEXs5cjMKd4EWsijIJz6bHUmSP2R45w2mZ+Jn
	 Pmf/rAuK1eHyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] sched: Restart hrtick after same-task repicks
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2h1YmhhbmcgS2F1c2hpayAoQW1wZXJlKQ==?= <sh@gentwo.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260911-sched-fair-hrtick-restart-v2-1-0d34db26ecd1@gentwo.org>
References: <20260911-sched-fair-hrtick-restart-v2-1-0d34db26ecd1@gentwo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:42:30 +0000
Message-Id: <20260911224230.A19611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Restarting the SCHED_DEADLINE hrtick on same-task repick uses a st=
ale `dl_se->runtime`, pushing the timer expiration into the future and allo=
wing bandwidth overruns.
--

commit fe44140b6abb0653f45d8368ffe6e56a2831b43c
Author: Shubhang Kaushik (Ampere) <sh@gentwo.org>
sched: Restart hrtick after same-task repicks

This commit introduces explicit hrtick restarts for same-task repicks in bo=
th
fair and deadline scheduling classes. It adds a new SNT_REPICK type to bypa=
ss
normal transition work while still rearming the timer.

Link: https://lore.kernel.org/r/20260813-sched-fair-hrtick-restart-v1-1-423=
0d1e18fbb@gentwo.org

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0663c00c41c04..6c17563f42a1d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> -static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool =
first)
> +static void set_next_task_dl(struct rq *rq, struct task_struct *p, enum =
snt_e type)
>  {
>  	struct sched_dl_entity *dl_se =3D &p->dl;
>  	struct dl_rq *dl_rq =3D &rq->dl;
> =20
> +	if (type =3D=3D SNT_REPICK)
> +		goto repick;
> +
>  	p->se.exec_start =3D rq_clock_task(rq);
[ ... ]
>  	deadline_queue_push_tasks(rq);
> =20
> +repick:
>  	if (hrtick_enabled_dl(rq))
>  		start_hrtick_dl(rq, &p->dl);
>  }

[Severity: High]
Does this code use a stale dl_se->runtime to arm the hrtick?

When a wake-up or other non-tick preemption check sets TIF_NEED_RESCHED
on a running SCHED_DEADLINE task without calling update_curr_dl(),
__schedule() might repick the same task (e.g., if the woken task was migrat=
ed
away before picking).

If that happens, put_prev_set_next_task() takes the SNT_REPICK path, which
skips put_prev_task():

kernel/sched/sched.h:put_prev_set_next_task() {
    ...
	if (next =3D=3D prev) {
		next->sched_class->set_next_task(rq, next, SNT_REPICK);
		return;
	}
    ...
}

Because put_prev_task() is skipped, its embedded update_curr_dl() call is
also skipped. As a result, dl_se->runtime is not decremented for the time
executed since the last update.

When start_hrtick_dl() is then invoked from the repick label above, the new
hrtick is erroneously scheduled using the un-updated runtime.

Can this allow SCHED_DEADLINE tasks to exceed their configured bandwidth bo=
unds
and starve other tasks?

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e656c7059bf86..defcf7fd023fa 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
[ ... ]
> @@ -2802,11 +2808,13 @@ static inline void put_prev_set_next_task(struct =
rq *rq,
> =20
>  	__put_prev_set_next_dl_server(rq, prev, next);
> =20
> -	if (next =3D=3D prev)
> +	if (next =3D=3D prev) {
> +		next->sched_class->set_next_task(rq, next, SNT_REPICK);
>  		return;
> +	}
> =20
>  	prev->sched_class->put_prev_task(rq, prev, next);
> -	next->sched_class->set_next_task(rq, next, true);
> +	next->sched_class->set_next_task(rq, next, SNT_PICK);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-sched-fair=
-hrtick-restart-v2-1-0d34db26ecd1@gentwo.org?part=3D1
