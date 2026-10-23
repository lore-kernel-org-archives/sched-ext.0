Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782156;
	b=FKoXP+ii4dZGPdssT5igfnAhivISHtEvLZu26dJ1rxT+JbM4w8buSCVrzIrIPeK3Eoig
	 nA4THXfQeSHy9+pLzHlV9GOkc16tEt0gvW8QEji0Kk0imxvoH04zjIXTdmbp+B+fdHZiS
	 PhyrPVUE5Nd75ownHDMP/CZ12eJnyL0u9ccz2NpZJLYPvb1u2NtjUDot5BKRQ1rMyAFth
	 wJxTzWaa5lYxGucSqkPYBSWBJ2yA9w0wCOt+1X6BXzRohOsF+X5n35bp9y0bTzeoHgGKf
	 UgP+7JE/kihzQHWfH+2+DPHpR6ApyMyTL9IIPoWrcX+jfRAzoQbvRJr5wenD19Fgk+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782156;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OtN59w9iN9luB7tiFqQxKe4fjBJ5YDquXeZfC8kF1U4=;
	b=gpvkrYSL5AUm+q90N0K3kIniVK5xcZhc35lra17EsjSNukupymjJz/4Lcyi25xHqLqDZ
	 FAJ3Mo0cxw1EpHaR7PiaPOeME6MQhENZWXrgzCy1GtrXSwP8oWQlpYgIhOaE9l7MmrRwv
	 q67tp4lu0SHxNr2ljnG2+TyWX1B84qG3wSkwAk0zSlyKFbz5lLVoRQtXn7KoYVplT/oXJ
	 pgeuWIwWmf5WfE/prgChvSw+YNZgAjLsdvrqEgiLFnK8kSFtiBjjgpztw63tJE84e7lkX
	 fqKs4gpQMpnTRa1jwk7WWyGsu5DtDNgaMkBSYSsbIWcFQrW+DEhTKUibinKv716VIaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvW2Oguf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE0606A31A
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvW2Oguf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026F81F01825;
	Fri, 23 Oct 2026 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792782156;
	bh=OtN59w9iN9luB7tiFqQxKe4fjBJ5YDquXeZfC8kF1U4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fvW2OgufAmTBQPJZKjlUzaQt1Es5utVNzrK28vYhuG9GqDsCoIc8P/dDZKTy3CZ3S
	 raluPCYMd2K2G9IkSifUpEk9nUlWikoH4+wwPsrEYYJgr5UG3huR3x/ABTJRJbQLGp
	 /iAqXMl8XwWAn4fALDEoqNZaf5mt4CsBI/AILZWWObNcma9V3C21+mYETSJoMlpydk
	 n2M3xLznQ9kf5icKXRPFJSb2fwZGp2pmhTTkaLX+9yFsYMuV/pJ9Qt8xNKlG74DEy6
	 x5vYcA+V6NCqr3p2O+642sHdpm5MQCDmm4/7iARdNK4xdBvr8xuelGr/XXMYKyACps
	 sbv2GcUPR0xNw==
Message-ID: <sashiko-outbox-183097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/17] sched_ext: Fix bypassed tasks stalling when the
 host lacks SCX_CAP_BASE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261023175608.4120910-14-tj@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org>
 <20261023175608.4120910-14-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:02:35 +0000
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
- [Critical] sched_ext: unended rescue in switched_from_scx() for SCX_TASK_=
NONE tasks
- [High] sched_ext: bypassed rescue tasks charged and blamed on owner inste=
ad of host
--

commit 5f65e8f62e204ba71694acee35be35ae6d8a8a72
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE

This commit resolves bypassed tasks against their non-bypassing ancestor
(host) at enqueue time so that when the host lacks SCX_CAP_BASE on the CPU,
the task is sent to rescue or admitted to the local DSQ instead of stalling
on an unconsumed bypass DSQ. It also preserves kernel-slice rescuees on the
local DSQ across preemptions while bypassing.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index bd0dd07b5926d..8fe0bf5d2c0db 100644
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

[Severity: High]
When bypass_enq_target_dsq() diverts a bypassed task p owned by sch into
rescue on behalf of host =3D scx_exec_sched(sch, cpu_of(rq)), can rescue
overload accounting and watchdog stall attribution still blame sch instead =
of
host?

Because the root scheduler always holds SCX_CAP_BASE,
scx_missing_caps(host, cpu_of(rq), SCX_CAP_BASE) is non-zero only when host
is a non-bypassing ancestor sub-scheduler and sch =3D scx_task_sched(p) is a
bypassing descendant (sch !=3D host).

In kernel/sched/ext/sub.c, scx_rescue_charge() charges the running rescuee's
CPU time to scx_task_sched(rq->scx.rescue.curr) rather than
scx_exec_sched():

kernel/sched/ext/sub.c:scx_rescue_charge() {
	...
	/* per-cpu usage average feeds the overload victim pick */
	pcpu =3D per_cpu_ptr(scx_task_sched(rq->scx.rescue.curr)->pcpu,
			   cpu_of(rq));
	pcpu->rescue_avg =3D scx_rescue_decay_avg(pcpu) + delta_exec;
	...
}

When sch is bypassing during scx_sub_disable() after scx_disable_workfn() h=
as
set sch->exit_kind to SCX_EXIT_DONE, scx_rescue_check_overload() skips sch:

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
	...
}

Since host has no rescue_avg charged for those bypassed tasks, won't
scx_rescue_check_overload() either fail to find a victim and leave host
unejected, or eject an unrelated sub-scheduler on that CPU?

Similarly, if p stalls on rq->scx.rescue.dsq or rq->scx.local_dsq (where
dsq->sched is NULL, unlike scx_bypass_dsq(host, cpu) where dsq->sched is
host), check_rq_for_timeouts() in kernel/sched/ext/ext.c keeps
sch =3D scx_task_sched(p):

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
	...
}

If sch is already exiting, __scx_exit() becomes a no-op via scx_claim_exit()
while timed_out =3D true stops both the rq scan and scx_watchdog_workfn()'s
CPU scan without ejecting host. Should scx_rescue_charge() and
check_rq_for_timeouts() resolve through scx_exec_sched() when the task's
scheduler is bypassing on that CPU?

[Severity: Critical]
Can admitting a bypassed task into rescue here also leave a dangling
rq->scx.rescue.curr pointer if the task is in state SCX_TASK_NONE?

In a multi-level hierarchy (for example, root -> sub1 -> sub2 -> sub3), if
parent initialization fails during scx_sub_disable(sub3), scx_fail_parent()
bypasses sub2 and calls scx_punt_task(sub2, p):

kernel/sched/ext/sub.c:scx_punt_task() {
	...
	scoped_guard (sched_change, p,
		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
		scx_disable_and_exit_task(scx_task_sched(p), p);
		scx_set_task_sched(p, to);
	}
	...
}

This leaves p on ext_sched_class with scx_get_task_state(p) =3D=3D SCX_TASK=
_NONE
and scx_task_sched(p) =3D=3D sub2. When p is enqueued on a CPU where its ho=
st
(sub1 =3D scx_exec_sched(sub2, cpu)) lacks SCX_CAP_BASE,
bypass_enq_target_dsq() now sends p to scx_resolve_local_dsq(), which can
admit p as rq->scx.rescue.curr with SCX_TASK_KERNEL_SLICE.

If p then switches out of ext_sched_class while running as rq->donor with
p->scx.slice > 0 (via sched_setscheduler(), rt_mutex_setprio(), or
scx_root_disable()), sched_change_begin() runs with
DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_CLASS:

1. dequeue_task_scx() skips scx_task_slice_ended(rq, p):

kernel/sched/ext/ext.c:dequeue_task_scx() {
	...
	/* see scx_task_slice_ended() for the save/restore exception */
	if (!((deq_flags & DEQUEUE_SAVE) && task_current_donor(rq, p)))
		scx_task_slice_ended(rq, p);
	...
}

2. put_prev_task_scx() skips scx_task_slice_ended(rq, p) because
   p->scx.slice is non-zero.

3. switched_from_scx() (and __scx_disable_and_exit_task()) returns early for
   SCX_TASK_NONE without calling scx_disable_task() or
   scx_task_slice_ended(rq, p):

kernel/sched/ext/ext.c:switched_from_scx() {
	if (scx_get_task_state(p) =3D=3D SCX_TASK_NONE)
		return;

	scx_disable_task(scx_task_sched(p), p);
}

4. When p later exits, sched_ext_dead() also skips SCX_TASK_NONE tasks:

kernel/sched/ext/ext.c:sched_ext_dead() {
	if (scx_get_task_state(p) !=3D SCX_TASK_NONE) {
		...
	}
}

Wouldn't this leave rq->scx.rescue.curr pointing to p after p leaves
ext_sched_class and is eventually freed, wedging rescue on rq and causing a
use-after-free in scx_rescue_timerfn(), scx_rescue_dump(), or
scx_rescue_flush()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023175608.4120=
910-1-tj@kernel.org?part=3D13
