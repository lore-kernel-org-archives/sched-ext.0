Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981744;
	b=Vbgab7Kvd29497MvDiFuXz2KMXtdy4QjWi3DFlEAmgjr2g83G4gfZlcM/BDHH3872e7h
	 KBLXOaPBtwvpVuJhmMn31Tc8kWMysAK9aDwFcfN4oWVmq5sdta8XGFTjLIhH+rw6loWjF
	 59UjyAeeN5aMXcE+oIh5uxi/xkYh8Pah0rJyJQs29MTz5Z1YVY5TdU4CFjP1BNUnRuoId
	 eZBvq0izp2LOxeUo9WyaVzRkeLhwJ1IbpJLwAlaeaXT0cRD1rGo78Gsl68KpTUrbTMIz3
	 u6ks+1/z7jy9m5oHPT0CS7yuEIvuhQ6Si2Rlh0i1OPsGPvr6hOhN/o8PUkWTtMeX6Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981744;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XA8nRmOjSMBClXpRvmsoAr2ITpUNS/ESr73w3N+nIP4=;
	b=sKR4yXF4DNEkPQ88Z6Xq6eMEHbGqipbnaelvNqseWhM8O0Lgzocw3fQFb/s0XtKGqW/H
	 rfm+VF7KHYPbs1hnQK12Wcs24TBJ0TovgjhkauqGWrA2dhX3qfg/nWGj/fVKtuVbrwnz9
	 0GajnTOEW/J/gXKR9L5WNTBHs4G1mX44hMzLrojP7ES45v4y2R+dSwZOejTZ9/j3oadY9
	 10jTNoE/ZStQTzMTbaBqnUXdkTzDPfYdVqhMpQ+nT4R139hsgiGuWjtZDFHR5lbk5+mRy
	 E/HXeUKLOS5OBZtYpmmVDZuNrhNvu46piYeQqVgcjm+EMt612/JFmoopRuKTpfyZj5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWYiZao6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6B606A32F
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWYiZao6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF501F0089F;
	Fri,  6 Nov 2026 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981744;
	bh=XA8nRmOjSMBClXpRvmsoAr2ITpUNS/ESr73w3N+nIP4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FWYiZao6qBwX9hnYu7E+KJgMj8DX4YO2llmHLxtCplLJfXliSv+YuHFyo5rvS5DtR
	 ppWMH4agdSg/M71sM0gGgdEVJFbMrBljdsqSqsuF//TDuKCyQ8OKT0P3uA7gyb3VvZ
	 IQEr6ArL9qdSFQCfMmkjKdj0Zi/L4uMqgpNQP1kFgam2pTDd8NprpHVXZ5XfwF6hol
	 UU6LQ5RSDHS6skmdOuUSjqWZFX6yZv2OYkCLr2a+KEQzbfiXw/j/7k2cHa1b5iozPx
	 68HGVM4K5d28A4MBx2XR0dU4k2Qafi+I/D1wsLNbjn6lq4kDzaIqtE4d8o5KOpZ8jM
	 o6R+RRtJvxRhw==
Message-ID: <sashiko-outbox-201785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-9-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:15:43 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] sched/fair: broken proxy execution handling in fair_push_task()
- [High] sched/fair: broken throttled task handling in cfs
  pushable_tasks
- [Medium] sched/fair: wrong util_est accounting in cpu_util() for
  fair_push_task()
- [Low] sched/fair: missing context analysis annotations in
  fair_push_tasks()
--

commit 7788037a9d21dee51af9b507ce742334ce7472a3
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/fair: Add push task mechanism for fair

This commit adds a pushable tasks mechanism to the fair scheduler so that
runnable tasks placed back on the runqueue in put_prev_task_fair() can be
evaluated and migrated via a balance callback.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8f99c8bf1a80d..e37f8b55a2934 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
[ ... ]
> @@ -10071,6 +10074,163 @@ static int find_energy_efficient_cpu(struct tas=
k_struct *p, int prev_cpu)
>  	return target;
>  }
> =20
> +DEFINE_STATIC_KEY_FALSE(sched_push_task);
> +
> +static inline bool sched_push_task_enabled(void)
> +{
> +	return static_branch_unlikely(&sched_push_task);
> +}
> +
> +static bool __check_pushable_fair_task(struct rq *rq, struct task_struct=
 *p)
> +{
> +	if (!task_on_rq_queued(p))
> +		return false;
> +
> +	if (p->se.sched_delayed)
> +		return false;
> +
> +	if (p->nr_cpus_allowed <=3D 1)
> +		return false;
> +
> +	return true;
> +}

[Severity: High]
Can a task throttled by cfs bandwidth control be queued onto
rq->cfs.pushable_tasks and corrupt the plist or bypass throttling?

When throttle_cfs_rq_work() throttles a running task, it calls
dequeue_task_fair() directly rather than deactivate_task(), clearing
p->se.on_rq and setting p->throttled =3D true while leaving
task_on_rq_queued(p) true.  On the subsequent schedule,
put_prev_task_fair() skips __enqueue_entity() because se->on_rq is zero,
but still calls fair_add_pushable_prev().  Because
__check_pushable_fair_task() does not check p->se.on_rq or
!task_is_throttled(p), the throttled task is added to
rq->cfs.pushable_tasks.

If fair_push_task() then migrates that limbo task to another CPU whose
cfs_rq is unthrottled, enqueue_throttled_task() clears p->throttled and
lets the task run past its bandwidth quota.  Furthermore, if
dequeue_task_fair() is later called on the throttled task (for example
during sched_move_task() or an affinity change), it returns early before
reaching __dequeue_task():

kernel/sched/fair.c:dequeue_task_fair() {
	...
	if (task_is_throttled(p)) {
		dequeue_throttled_task(p, flags);
		return true;
	}

	if (!p->se.sched_delayed)
		util_est_dequeue(&rq->cfs, p);

	if (!__dequeue_task(rq, p, flags))
		return false;
	...
}

That early return skips fair_remove_pushable_task(), leaving a dangling
p->pushable_tasks node linked in rq->cfs.pushable_tasks.

[ ... ]

> +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +	if (!has_pushable_tasks(rq))
> +		return NULL;
> +
> +	p =3D plist_first_entry(&rq->cfs.pushable_tasks,
> +			      struct task_struct, pushable_tasks);
> +
> +	WARN_ON_ONCE(rq->cpu !=3D task_cpu(p));
> +	WARN_ON_ONCE(task_current(rq, p));
> +	WARN_ON_ONCE(p->nr_cpus_allowed <=3D 1);
> +	WARN_ON_ONCE(!task_on_rq_queued(p));
> +
> +	/*
> +	 * Remove task from the pushable list as we try only once after that
> +	 * the task has been put back in enqueued list.
> +	 */
> +	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> +
> +	return p;
> +}

[Severity: High]
With proxy execution enabled, can fair_push_task() migrate the actively
running mutex owner or a mutex-blocked donor task?

In __schedule(), pick_next_task() calls put_prev_set_next_task(rq,
rq->donor, next) before find_proxy_task() resolves a blocked donor to its
mutex owner.  When a running mutex owner prev is preempted by a blocked
fair donor next that is blocked on prev, put_prev_task_fair() adds prev
to rq->cfs.pushable_tasks, and set_next_task_fair() only removes next
from pushable_tasks before queueing fair_push_tasks().  Immediately
afterwards, find_proxy_task() selects prev as rq->curr without calling
set_next_task_fair(rq, prev, ...).  When the balance callback runs
fair_push_tasks(), pick_next_pushable_fair_task() does not check
!task_on_cpu(rq, p) (unlike pick_next_pushable_task() in rt.c and
pick_next_pushable_dl_task() in deadline.c), so it triggers the
task_current(rq, p) warning and returns the actively running task to
fair_push_task() to be migrated while still executing on prev_cpu.

In addition, __check_pushable_fair_task() does not check
!task_is_blocked(p), allowing mutex-blocked donor tasks (which remain
queued on the rq) to be added to rq->cfs.pushable_tasks and pushed away
from their mutex owner's CPU while set_task_cpu() overwrites p->wake_cpu.

> +
> +static int
> +select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags);
> +
> +/*
> + * See if the non running fair tasks on this rq can be sent on other CPUs
> + * that fits better with their profile.
> + */
> +static bool fair_push_task(struct rq *rq)
> +	__releases(__rq_lockp(rq))
> +	__acquires(__rq_lockp(rq))
> +{
[ ... ]
> +	new_cpu =3D select_task_rq_fair(next_task, prev_cpu, 0);

[Severity: Medium]
When select_task_rq_fair() -> find_energy_efficient_cpu() runs from
fair_push_task(), does cpu_util() miscompute util_est across the
performance domain?

In fair_push_task(), next_task is already queued on prev_cpu
(task_on_rq_queued(next_task) is true and !next_task->se.sched_delayed),
so cpu_rq(prev_cpu)->cfs.avg.util_est already includes
_task_util_est(next_task).  However, cpu_util() adjusts util_est without
using add_task or sub_task:

kernel/sched/fair.c:cpu_util() {
	...
		if (dst_cpu =3D=3D cpu)
			util_est +=3D _task_util_est(p);
		else if (p && unlikely(task_on_rq_queued(p) || current =3D=3D p))
			lsub_positive(&util_est, _task_util_est(p));
	...
}

When find_energy_efficient_cpu() evaluates cpu =3D=3D prev_cpu with
dst_cpu =3D=3D prev_cpu, dst_cpu =3D=3D cpu is true and adds _task_util_est=
(p) a
second time.  When it evaluates any other CPU in the domain with
dst_cpu !=3D cpu (such as dst_cpu =3D=3D -1 in eenv_pd_busy_time() or a
non-target CPU in compute_energy()), task_on_rq_queued(p) is true without
checking task_cpu(p) =3D=3D cpu, subtracting _task_util_est(p) from every
other CPU's util_est and skewing capacity fitness and energy delta
calculations.

[ ... ]

> +static void fair_push_tasks(struct rq *rq)
> +{
> +	/* fair_push_task() will return true if it moved a fair task */
> +	while (fair_push_task(rq))
> +		;
> +}

[Severity: Low]
Does fair_push_tasks() need __must_hold(__rq_lockp(rq)) for clang context
analysis?

kernel/sched/Makefile enables context analysis on fair.o, and
fair_push_task() is annotated with __releases(__rq_lockp(rq)) and
__acquires(__rq_lockp(rq)).  Without __must_hold(__rq_lockp(rq)) on
fair_push_tasks() (matching balance_push() and sched_core_balance() in
core.c), building with clang context analysis enabled warns that
__rq_lockp(rq) is not held on entry to fair_push_task().  Inside
fair_push_task(), reassigning cur_rq =3D move_queued_task(...) without
context_unsafe_alias(cur_rq) and omitting __must_hold(__rq_lockp(rq)) on
the declaration of move_queued_task() in kernel/sched/sched.h also cause
context analysis warnings in this commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D8
