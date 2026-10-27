Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793061859;
	b=CscjRL0XWlu7b7wiB6/8oGCGJhQ3XERplRDymdD1s5rQY2IvY5rXoJrCJfKA3AbIxHxs
	 1aRUixvdkCzP1JV42GVkyTLKvdfCOCulixU+D3qwYRbIE+sPWYmfEyIFLBz+ra7oFlmtp
	 iVyPh2vkYUkjwqqYwhfVpeDonCz+wSlNu0FmCjbYqO8wICl6DKBf+hdlji3btETuiKj8K
	 eBdpTwKAqBly+71q4RUSQF3cavKUKThDAxgVQuHobCFhXaTDZsjhar/SwvrshYA5zfDYc
	 LXqqh4CP+8nNWurz29l4eROVM/f7hiHn/lWHTg2l0GECDlLfkEEiMCxS2YR1KQ6mjCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793061859;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MCLVcrtiHMDW35Uu5QUgRJ9jrhj6No1b8feIHxPartU=;
	b=S5HM2I5L1YeX7ByWVXkfkQUvtTLt8dDlL4QQ3qO0SXCQ1SCDUCbJzIwNLVQVrskwDuyU
	 9asl9INil72Mrn9xlE2C6NBtpFSahWz+djZ1mU7k9YfK/i4hT/EJd8t3GQTqm129TuHap
	 WIS0qxuu0XnqImpOBszLhZQbdGq9U7hvIu+/o527USJcxYWKhlZs5+D3AVUAaIi0Sqo5x
	 Jyi0KZfiApmERec1gUGH47kplfWTGwK0EZGeBbB2nKPbj34oYo9wHfnxCCoV6L90gjMxr
	 7IzQ6Bh9Saq7Bwo4OStPaiayE/L7oZtw0eTHriXr7lJ9cpK5T9JIL/pI/MGzTXgF/HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvfrVTRY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231BE606A31A
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvfrVTRY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E241F01825;
	Tue, 27 Oct 2026 00:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793061859;
	bh=MCLVcrtiHMDW35Uu5QUgRJ9jrhj6No1b8feIHxPartU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mvfrVTRYaTDZreQ+SyV/ojJKqgLXnpi/+/VBU6QfG4AbtmSlHMarM+t9LZERsDa05
	 yA3X/aVGoWATugtsvQtm15hhgPO/kfLau8Ynh9EacrchFZQFj5PgDn+OUJDeoTQcQ9
	 9/yNvk8WdGHTgw+XqiEE5SjHQle93BCnS2NET4QZGQZyTVZE6kxzEB33j9rdwI2Raf
	 WAkNVyTFTZ8EOiL4MMLQV1x0vtDcACN6WNlsFzEYs+/HpFrgy1LAd7xDv6YZAVTZg7
	 DAj1ksCBsVzzEgBy9KSo3mpg/c6dvxdMQCGXphUvrbvr/Z7gl6aHjNYUGdEZidVEys
	 DYQ37MPJ/phzA==
Message-ID: <sashiko-outbox-185966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/18] sched_ext: Fix bypassed tasks stalling when the
 host lacks SCX_CAP_BASE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261027001749.1821379-14-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
 <20261027001749.1821379-14-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:44:18 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] sched_ext: missing slice end for NONE tasks in __scx_disable_and_e=
xit_task()
- [High] sched_ext: misattributed rescue usage and stalls for bypassed tasks
--

commit 22b95f16249b92e8730c0989de8ef32cf7909110
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE

This commit fixes bypassed tasks stalling on a CPU where their non-bypassing
host ancestor lacks SCX_CAP_BASE by resolving them against the host with
SCX_ENQ_RESCUE at enqueue time and keeping preempted rescuees on the local
DSQ during bypass.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 75f863de565a2..985a9cc24db56 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -388,8 +388,12 @@ static const struct sched_class *scx_setscheduler_cl=
ass(struct task_struct *p)
>  	return __setscheduler_class(p->policy, p->prio);
>  }
> =20
> -static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sc=
h, s32 cpu)
> +static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sc=
h, struct rq *rq,
> +						    struct task_struct *p, u64 *enq_flags)
>  {
> +	struct scx_sched *host =3D scx_exec_sched(sch, cpu_of(rq));
> +	struct scx_dispatch_q *dsq;
> +
>  	/*
>  	 * If @sch is a sub-sched which is bypassing, its tasks should go into
>  	 * the bypass DSQs of the nearest ancestor which is not bypassing. The
> @@ -400,8 +404,29 @@ static struct scx_dispatch_q *bypass_enq_target_dsq(=
struct scx_sched *sch, s32 c
>  	 * Whenever a sched starts bypassing, all runnable tasks in its subtree
>  	 * are re-enqueued after scx_bypassing() is turned on, guaranteeing that
>  	 * all tasks are transferred to the right DSQs.
> -	 */
> -	return scx_bypass_dsq(scx_exec_sched(sch, cpu), cpu);
> +	 *
> +	 * A cpu's dispatch only descends into a host holding %SCX_CAP_BASE on
> +	 * it, so the bypass DSQ of a host without BASE here is never consumed.
> +	 * Send @p to rescue on this cpu instead, resolving against @host.
> +	 * scx_dispatch_enqueue() resolves a local DSQ again, against the
> +	 * bypassing @sch. %SCX_ENQ_IGNORE_CAPS makes that second resolution
> +	 * admit @p.
> +	 *
> +	 * A migration-disabled task can't leave this cpu, and a task with a
> +	 * migration pending must run here until the migration moves it. Either
> +	 * would wait on the unconsumed bypass DSQ until the host regains BASE.
> +	 * Resolve them too when rescue is disabled. The resolution admits both
> +	 * to the local DSQ, as it does any insert of such a task.
> +	 */
> +	if (unlikely(scx_missing_caps(host, cpu_of(rq), SCX_CAP_BASE)) &&
> +	    (scx_rescue_enabled() || is_migration_disabled(p) || p->migration_p=
ending)) {
> +		*enq_flags |=3D SCX_ENQ_RESCUE;
> +		dsq =3D scx_resolve_local_dsq(host, rq, p, enq_flags);
> +		*enq_flags |=3D SCX_ENQ_IGNORE_CAPS;
> +	} else {
> +		dsq =3D scx_bypass_dsq(host, cpu_of(rq));
> +	}
> +	return dsq;
>  }

[Severity: High]
When bypass_enq_target_dsq() resolves p against host via
scx_resolve_local_dsq(), p is placed on rq->scx.rescue.dsq or admitted to
rq->scx.local_dsq, whereas scx_task_sched(p) remains the bypassing child sch
(for instance during scx_sub_disable() where sch->exit_kind is already
SCX_EXIT_DONE, or after scx_fail_parent()).

In kernel/sched/ext/sub.c, scx_rescue_charge() charges the rescue runtime to
scx_task_sched(rq->scx.rescue.curr) rather than the executing host:

kernel/sched/ext/sub.c:scx_rescue_charge() {
	...
	/* per-cpu usage average feeds the overload victim pick */
	pcpu =3D per_cpu_ptr(scx_task_sched(rq->scx.rescue.curr)->pcpu,
			   cpu_of(rq));
	pcpu->rescue_avg =3D scx_rescue_decay_avg(pcpu) + delta_exec;
}

When rescue becomes overloaded, scx_rescue_check_overload() skips schedulers
whose exit_kind is not SCX_EXIT_NONE:

kernel/sched/ext/sub.c:scx_rescue_check_overload() {
	...
	list_for_each_entry_rcu(pos, &scx_sched_all, all) {
		u64 avg =3D scx_rescue_decay_avg(per_cpu_ptr(pos->pcpu, cpu));

		/* skip an already-exiting sub, else the ejection is wasted */
		if (pos->level && avg > max_avg &&
		    atomic_read(&pos->exit_kind) =3D=3D SCX_EXIT_NONE) {
			max_avg =3D avg;
			victim =3D pos;
		}
	}
}

Because the runtime was credited to the already-exiting sch instead of host,
host has avg =3D=3D 0 and is not selected, which can cause
scx_rescue_check_overload() to either eject an unrelated active sub-schedul=
er
on that CPU with a small non-zero rescue_avg or find no victim at all.

Similarly, while p waits on rq->scx.rescue.dsq or rq->scx.local_dsq,
dsq->sched is NULL (unlike scx_bypass_dsq(host, cpu), where dsq->sched is
host). In kernel/sched/ext/ext.c, check_rq_for_timeouts() only overrides
sch =3D scx_task_sched(p) when dsq->sched is non-NULL:

kernel/sched/ext/ext.c:check_rq_for_timeouts() {
	...
			if (dsq && dsq->sched && dsq->id !=3D SCX_DSQ_LOCAL)
				sch =3D dsq->sched;

			__scx_exit(sch, SCX_EXIT_ERROR_STALL, 0, cpu_of(rq),
				   "%s[%d] failed to run for %u.%03us",
				   p->comm, p->pid, dur_ms / 1000,
				   dur_ms % 1000);
			timed_out =3D true;
			break;
}

If p stalls there while sch is already exiting, __scx_exit(sch, ...) becomes
a no-op because scx_claim_exit() fails on sch, yet check_rq_for_timeouts()
sets timed_out =3D true and stops scanning the rest of rq->scx.runnable_list
and the remaining CPUs in scx_watchdog_workfn(). If the stalled task holds a
lock that scx_sub_disable(sch) waits on (such as cgroup_mutex or
scx_fork_rwsem), could this prevent host from being ejected and cause
scx_sub_disable() to hang?

Should scx_rescue_charge() and check_rq_for_timeouts() attribute a bypassed
task's rescue usage and stall timeouts to scx_exec_sched(sch, cpu_of(rq))?

[ ... ]

> @@ -4984,11 +5014,14 @@ static void switched_from_scx(struct rq *rq, stru=
ct task_struct *p)
>  	 * parent's own teardown). There is nothing to disable; calling
>  	 * scx_disable_task() would WARN on the non-%ENABLED state and trigger a
>  	 * NONE -> READY validation failure.
> +	 *
> +	 * @p can still be a rescuee under the parent. End its slice as
> +	 * scx_disable_task() does for an enabled task.
>  	 */
>  	if (scx_get_task_state(p) =3D=3D SCX_TASK_NONE)
> -		return;
> -
> -	scx_disable_task(scx_task_sched(p), p);
> +		scx_task_slice_ended(rq, p);
> +	else
> +		scx_disable_task(scx_task_sched(p), p);
>  }
> =20
>  static void switched_to_scx(struct rq *rq, struct task_struct *p) {}

[Severity: High]
What happens if a running SCX_TASK_NONE rescuee leaves its bypassing parent
without changing scheduler class, such as via scx_sub_disable() ->
scx_rehome_task(), scx_cgroup_task_migrated() -> scx_rehome_task(), or
another scx_fail_parent() -> scx_punt_task()?

When scx_fail_parent() punts p to parent at SCX_TASK_NONE, it has already
called scx_bypass(parent, true). When scx_sub_disable(parent) later calls
scx_bypass(parent, true), inc_bypass_depth() sees parent->bypass_depth > 1
and does not walk the CPUs to call scx_task_slice_ended(rq, rq->donor).

Then scx_rehome_task() and scx_punt_task() run under scoped_guard(sched_cha=
nge,
p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) without DEQUEUE_CLASS, so
switched_from_scx() is not invoked. For a running donor with p->scx.slice >=
 0,
dequeue_task_scx() skips scx_task_slice_ended() due to DEQUEUE_SAVE:

kernel/sched/ext/ext.c:dequeue_task_scx() {
	...
	/* see scx_task_slice_ended() for the save/restore exception */
	if (!((deq_flags & DEQUEUE_SAVE) && task_current_donor(rq, p)))
		scx_task_slice_ended(rq, p);
}

put_prev_task_scx() also skips scx_task_slice_ended() because p->scx.slice =
is
non-zero, and __scx_disable_and_exit_task() returns early for SCX_TASK_NONE:

kernel/sched/ext/ext.c:__scx_disable_and_exit_task() {
	...
	switch (scx_get_task_state(p)) {
	case SCX_TASK_NONE:
		return;
	case SCX_TASK_INIT:
		args.cancelled =3D true;
		break;
	case SCX_TASK_READY:
		break;
	case SCX_TASK_ENABLED:
		scx_disable_task(sch, p);
		break;
}

When sched_change_end() restores p via enqueue_task_scx() with
ENQUEUE_RESTORE, it takes the ENQ_ACTION_LOCAL_NOREFILL path, leaving
rq->scx.rescue.curr =3D=3D p and SCX_TASK_KERNEL_SLICE (and SCX_TASK_PROTEC=
TED if
set) active under the new scheduler.

If p is re-homed to scx_root and all sub-schedulers finish disabling (turni=
ng
off __scx_has_subs via scx_dec_has_subs()), scx_rescuee(rq) begins returning
NULL:

kernel/sched/ext/sub.h:scx_rescuee() {
	lockdep_assert_rq_held(rq);

	if (!scx_has_subs())
		return NULL;

	return rq->scx.rescue.curr;
}

At that point scx_task_slice_ended() can no longer call scx_rescue_end(rq) =
to
clear rq->scx.rescue.curr, leaving a dangling task_struct pointer in
rq->scx.rescue.curr after p exits that scx_rescue_timerfn() continues to
dereference.

Should __scx_disable_and_exit_task() also call scx_task_slice_ended() and
scx_set_task_slice(p, 0) when p is in SCX_TASK_NONE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027001749.1821=
379-1-tj@kernel.org?part=3D13
