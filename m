Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981573;
	b=QgqHyEptgRiMBX7+hzq6Oqi2VzhngfxVCOjUW2RdAHP0JSgPdIig6Z3NN/CzPwzEJsWQ
	 CVtgymco2vMG2M49ddYIEZM+cT0XaA15g+BCOjt3vVevkZPPTVPOqu4In2kFYed43xYor
	 g0zz757ZBLh+LlJnmoF9fiKz8v3638E+8xnAhhtxumlB/BTJ+I3EA3WtxzfpSPpXTBuwS
	 1DBsg6B3SoCZF+HfpNDznkElFTH101lC9tye1daKBezyJaITN+SqvK+z3nSI999fpU5ZD
	 tny30IGE5RHoq8rWPU1wmWEut1XpkDhy9LlPv+JiOXN4EkP8WcfywhnzrtKcVMKuhPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ry8wZen0uQaxXABvXKQzDrKRnGYk95Yp3bqTaxwmut0=;
	b=KvueTUi7xCzeBQzR9Io8KHVraTs2pmVOG8ajSfDdd8+OwLas5cemF6nBn/uj+Edscahl
	 QKXOievIx8ChgxfE5+rIw5HiBb9yrtsT9fQSDmDtentJuyJ+AxsfM4C5arV6oFaS+U5pt
	 czBhkt3VmJOFztgMXP4bp1qjW4KnsQgCAZy7dUvc7RS73b47dtUzwQTevwCFWvPIWyUke
	 T7/SFa8kponEoewubkPdYtM/O4pa27pxQgTrd1x+6xM5Mu2pfmc+djtluXpPzKuyapuSv
	 E9dOCN4515uX17u67cxKD0tukPPPuswsliqlSyQ/8pwSz4SUzHd6V+8uuR/3J5g8vsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTZPZnJZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A9606A982
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTZPZnJZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230081F0089F;
	Fri,  6 Nov 2026 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981572;
	bh=ry8wZen0uQaxXABvXKQzDrKRnGYk95Yp3bqTaxwmut0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UTZPZnJZhToHOQwZNrHNAUD8uNohCdkz0A4GRVtoSFMGI4m+f5kWL7xRO8fHs2VU+
	 CtFfYR+yWe+/dpPT7FBlrNxQVscyBjPMesu8DlJK0UCmr1ArlRAxPsm6t3dNTy/eG2
	 CzUKjrPbKYAJgttjoOf1mnBd4sgIh79AQxnkeWRSJdaCSS2zXL05Q/hA11fVRh0Blq
	 luV//PpFnOy4wULXWjvuQutsbyknq/0iKLwl9qunZA1BqfNy1FCLU8Jf5/ss+1qgid
	 Ui5VNxa5trYkXHpGMw4k7P9biTu5h5bXvUzCr6Vt6edwPu993h+RqWOz1DWAwNqvgL
	 V3v/144sGaYHg==
Message-ID: <sashiko-outbox-201777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/20] sched/eevdf: Try to push short slice task on a
 better CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-14-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-14-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:12:51 +0000
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
- [High] sched/fair: fair_check_pushable_task() pushes !se.on_rq and
  idle-next tasks
- [High] sched/fair: fair_check_pushable_task() pushes proxy-exec owners
  and donors
--

commit 016c5e088e8b372064ad1e24d8191243bb3c5d70
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/eevdf: Try to push short slice task on a better CPU

This commit extends fair_check_pushable_task() to mark a fair task as
pushable when preempted by another scheduling class or when it is an
eligible short-slice task.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 980eda9c935a8..3923587b66e0e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10112,6 +10112,23 @@ static bool __check_pushable_fair_task(struct rq=
 *rq, struct task_struct *p)
>  	return true;
>  }
> =20
> +static bool check_pushable_short_task(struct rq *rq, struct task_struct =
*p)
> +{
> +	struct sched_entity *pse =3D &p->se;
> +	struct cfs_rq *cfs_rq =3D &rq->cfs;
> +
> +	if (cfs_rq->h_nr_runnable <=3D 1)
> +		return false;
> +
> +	if (!entity_eligible(cfs_rq, pse))
> +		return false;
> +
> +	if (pse->slice < cfs_rq_max_slice(cfs_rq))
> +		return true;
> +
> +	return false;
> +}
> +
>  static bool fair_check_pushable_task(struct rq *rq, struct task_struct *=
p, struct task_struct *next)
>  {
>  	if (!__check_pushable_fair_task(rq, p))
> @@ -10120,6 +10137,12 @@ static bool fair_check_pushable_task(struct rq *=
rq, struct task_struct *p, struc
>  	if (next =3D=3D p)
>  		return false;
> =20
> +	if (next && next->sched_class !=3D p->sched_class)
> +		return true;
> +
> +	if (check_pushable_short_task(rq, p))
> +		return true;
> +
>  	return false;
>  }

[Severity: High]
Can fair_check_pushable_task() queue a task onto rq->cfs.pushable_tasks
when p->se.on_rq is 0 or when next is rq->idle?

In put_prev_task_fair(), fair_add_pushable_prev() runs even when se->on_rq
is 0, and __check_pushable_fair_task() only checks task_on_rq_queued(p) and
p->se.sched_delayed.  When throttle_cfs_rq_work() throttles a running task,
it calls dequeue_task_fair() (clearing p->se.on_rq) while leaving p->on_rq
as TASK_ON_RQ_QUEUED.  Because next->sched_class !=3D p->sched_class also
matches idle_sched_class (instead of checking sched_class_above()),
switching to idle or another task queues the throttled task onto
rq->cfs.pushable_tasks.  fair_push_task() can then migrate it to an
unthrottled remote CPU where enqueue_throttled_task() clears p->throttled
and lets it escape CFS bandwidth enforcement, or dequeue_task_fair() can
take the early task_is_throttled() return and leave a dangling node in
pushable_tasks.

Similarly, under CONFIG_SCHED_PROXY_EXEC, proxy_needs_return() calls
dequeue_block_task() before proxy_reset_donor() -> put_prev_task_fair(),
re-adding p to pushable_tasks after dequeue_task_fair() has already run and
before __block_task() clears p->on_rq.

[Severity: High]
Under CONFIG_SCHED_PROXY_EXEC, can fair_check_pushable_task() cause
fair_push_task() to migrate a currently running mutex owner or a blocked
donor task?

If a running fair task p owns a mutex held across put_prev_set_next_task()
when a blocked waiter is picked as the next donor, put_prev_task_fair()
adds p to rq->cfs.pushable_tasks, and find_proxy_task() then selects p to
keep running as rq->curr without calling set_next_task_fair().  Because
pick_next_pushable_fair_task() only warns on task_current(rq, p) rather
than skipping task_on_cpu(rq, p), fair_push_task() deactivates and migrates
p to another CPU while it is actively executing on the local CPU.

In addition, __check_pushable_fair_task() does not check
task_is_blocked(p), so a mutex-blocked fair donor deselected in
put_prev_task_fair() can be pushed away from its mutex owner's CPU via
set_task_cpu(), clobbering p->wake_cpu.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D13
