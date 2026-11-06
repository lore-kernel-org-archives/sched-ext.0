Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984038;
	b=XgKsQ+8eCKnzuEORIXQJ3I6D9vXu+QDG+87IqKs99Ue9DfwCop/RbdZByHkTYVPyIUNU
	 GnBcyXbVqKJNiLKJHS4owjUb5OdbI7drTdh3bkTdYEntd8d7mxRHUDhYw7OAXO6ivrBO1
	 iBsrr1Y/slAMUDVrkZd1m+FahQgAPNO9aHvOTJ4+uEop6D1K7GYuQKxM+LdT4hGib6pXO
	 npfRBBDMPtgaxWZ+hKkpqNi7jFtrpJmUx7b8g8w9COf6FNWWlVCs9qTk0AORjVTrgSXU2
	 IIcgYXvZpjPMRBbG+dl3KAShxvPJUPg7QBXoSVMCi3867FQc1p055TDapFP2ZXjfa9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UIxgsPUfm2y3rQvsn5p2B7Vt3sUbraW3TOUhfrf4WB8=;
	b=fYoPbv8rTiV3u1Md95toB/FAwdselG+4JLpeUTgVZQ6pLD2zDtdZtsvhZ4CYv1A0NsaY
	 9+tkn3YjSop4e0jn3L1aCQKM4gxbwpLMdp2S9cREbkjmBgC1VvpZ57XZvHbxwJVNke7+v
	 24GpvUoFK2ddnioV47pJiX0DI4d/ZS4nhs9C6ZnnL9TxzLKoD/ZxkHZgZKCCvgVBiXtrl
	 zzBs9QN8JhDWzt8mFxa7Jf6Y8G5U+mjEnSTiiai/4+n2/COYyDP0vwG7hKN7ySWD1BmIj
	 4JeLpbof8wVb9E0y6VnsIX5gmKwQnCMYU9yVXmD0HtvqBV3RaGaMhwotBur2YJfk4jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hxp6nfYd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3F606A333
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hxp6nfYd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE5F1F0089F;
	Fri,  6 Nov 2026 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984037;
	bh=UIxgsPUfm2y3rQvsn5p2B7Vt3sUbraW3TOUhfrf4WB8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Hxp6nfYdwnalwDmnUP1AuYCe7XrXe0u6xbYWgYMcIBpdn9tEvNINhUy1bQFc7XUi6
	 WmKfXkr8FuOWHvCuN5xoxlDJ1jDSj0dtyifKL1mY6srXP+bgui0iygQTiROxaMrsSx
	 b2zKvWP/7LKYivllb9jj1hJT35H6AQtOnx45hsIUKWpHKmMQKjGFtlG5MM7UZC0exd
	 8Eq9zYNUOITPmtsKHFH4+Fx+oXAdfpInIv/M0ntAEMMfplGoCh8mZqicLA1E9K8YsZ
	 NwA3GLQf0CF2F8/1E95KwXftDGAtviFNySGmbRBoobsi44g+T4cQmvfz0/562USzdX
	 CFuxY8KUegLaw==
Message-ID: <sashiko-outbox-201870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/20 v3] sched/fair: Fix tasks stacking on same idle
 CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-21-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-21-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:53:57 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] sched/fair: throttled task added to pushable_tasks in
  wakeup_preempt_fair()
- [High] sched/fair: missing throttled check in
  __check_pushable_fair_task()
- [High] sched/fair: active proxy task and blocked donor pushed via
  wakeup_preempt_fair()
--

commit b3ffe0a34e21054c91665b78a86f2ced2b7f31de
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/fair: Fix tasks stacking on same idle CPU

This commit invokes wakeup_preempt() on the higher scheduling class during
cross-class wakeups and adds eligible fair tasks to the pushable list when
waking on a runqueue whose donor belongs to a lower scheduling class.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a1a3aa45ecf68..ef4cbcca24372 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2311,6 +2311,7 @@ void wakeup_preempt(struct rq *rq, struct task_stru=
ct *p, int flags)
>  		rq->next_class->wakeup_preempt(rq, p, flags);
>  		resched_curr(rq);
>  		rq->next_class =3D p->sched_class;
> +		rq->next_class->wakeup_preempt(rq, p, flags);
>  	}
> =20
>  	/*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da9c4416f1b5c..2626264554978 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10649,10 +10649,22 @@ static void wakeup_preempt_fair(struct rq *rq, =
struct task_struct *p, int wake_f
>  	/*
>  	 * XXX Getting preempted by higher class, try and find idle CPU?
>  	 */
> -	if (p->sched_class !=3D &fair_sched_class ||
> -	    donor->sched_class !=3D &fair_sched_class)
> +	if (p->sched_class !=3D &fair_sched_class)
>  		return;
> =20
> +	if (donor->sched_class !=3D &fair_sched_class) {
> +		/*
> +		 * When rq is idle, several tasks can select this rq at wakeup
> +		 * without knowing others did the same. Give another chance to
> +		 * select another rq if not picked.
> +		 */
> +		if (sched_class_above(&fair_sched_class, donor->sched_class) &&
> +		    entity_eligible(cfs_rq, pse))
> +			fair_add_pushable_short(rq, p);
> +
> +		return;
> +	}
> +
>  	if (unlikely(se =3D=3D pse))
>  		return;
> =20

[Severity: High]
Can this regression add a throttled task to rq->cfs.pushable_tasks because
the new donor->sched_class !=3D &fair_sched_class block runs before the
task_is_throttled(p) check further down in wakeup_preempt_fair()?

When move_queued_task(), attach_task(), sched_move_task(), or
prio_changed_fair() enqueues a throttled task onto an idle runqueue via
enqueue_throttled_task() and then calls wakeup_preempt(), p->on_rq remains
TASK_ON_RQ_QUEUED while p->se.on_rq is 0.  fair_add_pushable_short() passes
__check_pushable_fair_task() and links p into rq->cfs.pushable_tasks.  If p
is later dequeued while still throttled, dequeue_task_fair() returns early
via dequeue_throttled_task() without calling fair_remove_pushable_task(),
leaving p->pushable_tasks dangling on the old runqueue across migration or
task exit, or allowing fair_push_task() to migrate and prematurely
unthrottle p on another CPU.

[Severity: High]
Along the same lines, should __check_pushable_fair_task() added in commit
"sched/fair: Add push task mechanism for fair" also reject throttled tasks
(or tasks with !p->se.on_rq)?

kernel/sched/fair.c:__check_pushable_fair_task() {
	if (!task_on_rq_queued(p))
		return false;

	if (p->se.sched_delayed)
		return false;
    ...
}

When throttle_cfs_rq_work() throttles a running task prev, it places prev
on cfs_rq->throttled_limbo_list with prev->throttled =3D true and
prev->se.on_rq =3D 0 while leaving prev->on_rq as TASK_ON_RQ_QUEUED.  Both
wakeup_preempt_fair() -> fair_add_pushable_short() and put_prev_task_fair()
-> fair_add_pushable_prev() reach __check_pushable_fair_task() and add the
throttled task to rq->cfs.pushable_tasks, leading to the same premature
unthrottling in fair_push_task() or plist corruption when
dequeue_throttled_task() bypasses fair_remove_pushable_task().

[Severity: High]
Under CONFIG_SCHED_PROXY_EXEC, can this regression queue an actively
running proxy task or a mutex-blocked donor onto rq->cfs.pushable_tasks?

When a fair donor d is blocked on a mutex whose fair owner p was sleeping,
proxy_resched_idle() sets rq->donor to rq->idle.  When p wakes on that CPU,
wakeup_preempt_fair() sees donor->sched_class =3D=3D &idle_sched_class and =
adds
p to rq->cfs.pushable_tasks via fair_add_pushable_short().  In __schedule(),
pick_next_task_fair() picks the blocked donor d, so set_next_task_fair()
removes d (not p) from pushable_tasks and queues fair_push_tasks(), after
which find_proxy_task() selects p as rq->curr.  When fair_push_task() runs,
pick_next_pushable_fair_task() triggers WARN_ON_ONCE(task_current(rq, p))
and still returns p to fair_push_task(), which deactivates and migrates p
to another CPU while p is actively executing on rq.

Similarly, when proxy_migrate_task() attaches a blocked donor
(task_is_blocked(p)) to a runqueue whose donor is idle or ext_sched_class,
wakeup_preempt_fair() adds the blocked donor to pushable_tasks, allowing
fair_push_task() to migrate it away from its mutex owner's CPU and
overwrite p->wake_cpu.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D20
