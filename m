Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982467;
	b=jmVn3HP5XY1D6cz3hiPcMIWW8J/RWYwVZRSQuGNmDGWaf6I8uk6ZulUcIgHvKmQdgpiP
	 7xaXX83PnGTfJzPNBbP/qx3AE1Tv164J+T5bLLF0OqsoYA9gqL4qbEWOATdHh+TkkWPHc
	 qwpV+1MdycPS/0pq7xoLsKRFVgj70owzvqrgNTMoQp7O+UlkpBtQJEaftFyZE2u9bQf5o
	 23DjRj/lo+1rk1yKcHZaGjCS2PZfVwLVKUm+Cz6wTej+MpZwGKL3ScdmvE5m5SATTyxxY
	 0dQgdpmmyrHwZz0MfGLgDIrw1TTAO4Jk4jBNryFLrIOl+cZ3DYi6eD+tW839mx9jAIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4zXgnlUrVNwAwumRiubsOV4YAwLWufZlYI9+ZSDRl8g=;
	b=twtX6VqJdfJxhJoe6UvETSE9TMd5yWJlbjcO7JItQXIBUZq1lZ3k9pi4E422j1bP04at
	 MsUtQl/Rx5QaM+qPzMN0vC7Lta4heLJoGz9iaAPzP1gdFuxGgI8Kmgt9Svp+GZQ1uMoCQ
	 PZ7Jib3bE3q7P2SH16NLzd1p9EDgA8cRW/l+vnv5tKDF1lYRM7pBUyZFQHKgFbtkYECCo
	 hyJo1UPfnV+T9ED0gEzozF4RET0l6iVSQEMcZ25y9tLIZ/j3fHyo9p1MiJ9FVIwFIDPb2
	 r3gKYw1CY+D4FArxAbQjWgMiESIaS8I/IRahLrAIdHEo9mtrnRxaYgftVB7dfZAyDnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPrNjGRD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F6606A326
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPrNjGRD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4811F0089F;
	Fri,  6 Nov 2026 16:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982466;
	bh=4zXgnlUrVNwAwumRiubsOV4YAwLWufZlYI9+ZSDRl8g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dPrNjGRDIHDrmgU37ZUYU2YjGTtSOSmZ02aeXYMl12ILRvhHGAY/KWyFWIX4KDB4d
	 nZcwWJ+CwRhjMQKQKLRNhCRvnLVeYKm9i4Ek1WKxL0b8PruI1fdV8d2/RD00q9nn7j
	 dnp314dc/4029AIKLOXUeQ4ii0CSUPjdV1oQKUdI6rB8PcMROEExnDxNosRKkmJ7oS
	 hIacR1Z2FmM9odnMe0aFZ8nRvZ3ORAElITWVJkZy3ZiVFdVlHlAeYUrv1aFHTT2M37
	 CR569nTyC9JU/RLfAjJCwyOoNbXqFt7PJLsoOw2gRYnRsswQsIXA0bhXxZf/sZY+qJ
	 Y+LWqMTQUBioA==
Message-ID: <sashiko-outbox-201811@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/20 v3] sched/fair: Enable push task for preempt short
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-16-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-16-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:27:45 +0000
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
- [High] sched/fair: enabling sched_push_task pushes throttled or active
  proxy tasks
- [Medium] sched/topology: sched_push_task not enabled at boot in
  sched_init_domains()
- [Medium] sched/topology: sched_push_task never disabled when
  PREEMPT_SHORT is off
- [Medium] sched/fair: missing rq_lock() and clock flag handling in
  fair_push_task()
--

commit eb9f484eef47f92f3c12dabb60d19453a2d64efa
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/fair: Enable push task for preempt short

This commit enables the sched_push_task static branch in
partition_sched_domains_locked() when the PREEMPT_SHORT scheduler feature
is set.

> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 919d0fb00bd9f..5481f2472e175 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -3497,6 +3497,9 @@ static void partition_sched_domains_locked(int ndom=
s_new, cpumask_var_t doms_new
>  	sched_energy_set(has_eas);
>  #endif
> =20
> +	if (sched_feat(PREEMPT_SHORT) && !static_branch_likely(&sched_push_task=
))
> +		static_branch_enable_cpuslocked(&sched_push_task);

[Severity: High]
Can enabling sched_push_task cause throttled or proxy-executing tasks to be
queued onto rq->cfs.pushable_tasks and pushed to another CPU?

In put_prev_task_fair(), fair_add_pushable_prev() is called even when
se->on_rq is 0, and __check_pushable_fair_task() only checks
task_on_rq_queued(p) without checking p->se.on_rq, !task_is_throttled(p),
!task_is_blocked(p), or !task_on_cpu(rq, p):

kernel/sched/fair.c:put_prev_task_fair() {
	...
	if (se->on_rq)
		__enqueue_entity(cfs_rq, se);

	if (next) {
		if (next !=3D prev)
			fair_add_pushable_prev(rq, prev, next);
	...
}

Under CONFIG_CFS_BANDWIDTH, throttle_cfs_rq_work() dequeues a task with
DEQUEUE_SLEEP | DEQUEUE_THROTTLE, clearing p->se.on_rq and setting
p->throttled while leaving p->on_rq =3D=3D TASK_ON_RQ_QUEUED.  When that ta=
sk
schedules out, put_prev_task_fair() can add it to rq->cfs.pushable_tasks.
If fair_push_task() then migrates it to an unthrottled cfs_rq,
activate_task() -> enqueue_task_fair() -> enqueue_throttled_task() clears
p->throttled and bypasses the CFS bandwidth quota; if the throttled task is
instead dequeued by sched_move_task() or do_set_cpus_allowed(),
dequeue_task_fair() returns early via dequeue_throttled_task() without
calling fair_remove_pushable_task(), leaving p->pushable_tasks corruptly
linked on rq->cfs.pushable_tasks.

Similarly, under CONFIG_SCHED_PROXY_EXEC, proxy_needs_return() calls
dequeue_block_task(rq, p, TASK_WAKING) before proxy_reset_donor() calls
put_prev_set_next_task(), which can link the waking task onto
rq->cfs.pushable_tasks before try_to_wake_up() migrates it to another CPU,
and switching rq->donor away from a mutex owner that remains rq->curr
allows fair_push_task() to deactivate and migrate a task that is actively
executing on the CPU.

[Severity: Medium]
Does fair_push_task() miss RQCF_UPDATED clearing and rq_lock()/rq_unlock()
pinning when migrating a task?

kernel/sched/fair.c:fair_push_task() {
	...
	deactivate_task(rq, next_task, 0);
	set_task_cpu(next_task, new_cpu);
	raw_spin_rq_unlock(rq);

	raw_spin_rq_lock(new_rq);
	WARN_ON_ONCE(task_cpu(next_task) !=3D new_cpu);
	activate_task(new_rq, next_task, 0);
	wakeup_preempt(new_rq, next_task, 0);
	raw_spin_rq_unlock(new_rq);

	/* Restore rq lock state */
	raw_spin_rq_lock(rq);
}

When __balance_callbacks() runs fair_push_task() at the end of
__schedule(), rq_unpin_lock(rq, &rf) has already unpinned rq->__lock and
invalidated the sched_ext clock, but RQCF_UPDATED remains set on
rq->clock_update_flags.  Calling deactivate_task(rq, next_task, 0) without
DEQUEUE_NOCLOCK (or clearing RQCF_UPDATED) calls update_rq_clock(rq) again,
triggering WARN_DOUBLE_CLOCK and re-setting SCX_RQ_CLK_VALID on
rq->scx.flags after rq_unpin_lock().  In addition, locking new_rq with
raw_spin_rq_lock() and raw_spin_rq_unlock() instead of rq_lock() and
rq_unlock() skips rq_pin_lock() and rq_unpin_lock() on new_rq, triggering
WARN_DOUBLE_CLOCK in activate_task() and leaving SCX_RQ_CLK_VALID set on
new_rq after unlock.

[Severity: Medium]
Does sched_push_task remain disabled after boot on systems that only build
domains through sched_init_domains()?

During boot, smp_init() brings secondary CPUs online before
sched_smp_initialized is set, and sched_init_smp() then initializes domains
via sched_init_domains() -> build_sched_domains() without calling
partition_sched_domains_locked().  On systems that do not later rebuild
scheduler domains (for example via Energy Model registration, ITMT, CPU
hotplug, or cpuset updates), sched_push_task is never enabled even though
PREEMPT_SHORT is on by default.

[Severity: Medium]
What disables sched_push_task (or stops check_pushable_short_task()) when
PREEMPT_SHORT is disabled at runtime via /sys/kernel/debug/sched/features?

partition_sched_domains_locked() only enables sched_push_task and has no
corresponding disable path when !sched_feat(PREEMPT_SHORT), and
check_pushable_short_task() does not test sched_feat(PREEMPT_SHORT).  Also,
note that fair_remove_pushable_task() gates plist_del() on
sched_push_task_enabled(), so disabling the static branch while tasks are
queued on rq->cfs.pushable_tasks would skip unlinking them on dequeue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D15
