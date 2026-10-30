Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371771;
	b=xUFVuiotLzt5sXLgSQY3ui7OhvgQtVssrHRiu7Y3X+r6XCvEZz7NzB+H26LkO93Yg0L6
	 uZjsaFO+nt+CTZLwmeh37GSTlxwOvg/teylOWNVp/4WWX8NfKD61rrotpxErHLIfq0LEX
	 Eog9+AcKInZbp26nAGNbA4ovm5iopIPHlDMTYvmKEq/EZ5bBN/d1zmlcDBwBGR6WVVRrw
	 z3fTzhtgT4wef+t9KzR6487+3TX9Zp1ZKPs95AT+ZqZ4izEqMeON08gzjEFkAadaG725t
	 IbXkzO8Kw1cSYBqHUSPAb4LBPisxzNZlP0BCncwKsL2Elc9CxLDkyutqrhgjcL/YX5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Opr0XGpufpr/NWqLRMH+kEuUc6ihVi53K1PaoJ26+EE=;
	b=0qYvXSm1V9YexF0ovU8vVtr3jakgp6QFG5opQBN/cFR9ojFs71r4heaCrPMYoB8wDxon
	 3iyGa9uFugcNsC5WYGOuU6M7Mwr49mzSK4Uwmw8lRDMcmTRkgh2ZaOWPK73X2FxcBux8p
	 y4qM9TvF3Mm1VU99AOngItM7L4Nayoi8j/jytM1xK9LJspQO6ihJYTRCPdu5E07akpcf7
	 qi1AsUbqGxzF1jz7QMTHv9N3MXGPwsEEBSyls74CDtjI99AODH+k+GRYM+R30/c/swZ1o
	 PJNjS+WpQF/OE1MYDD0t2sYhKvFALN+IUA4kyG7iatWULi+up8A6g0uKhfr6KKBLHzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3OAO35l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EFF606A324
	for <sched-ext@lists.linux.dev>; Fri, 30 Oct 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3OAO35l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EBB1F00A16;
	Fri, 30 Oct 2026 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793371770;
	bh=Opr0XGpufpr/NWqLRMH+kEuUc6ihVi53K1PaoJ26+EE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=C3OAO35lmNBmMXLbqgVVEsbqiaMJxN6blfaup8hbIeXWI4wrLnbL8azWk97NRtFZD
	 OcH9CeJMM8ibIgsare4lWXWhOMsGeHYEmIN2byesyYCAYQ1KyPqtH49YjSvzODGjz9
	 m1zyATE/SVRTbjQEVrtFSfwdjgc3WvmoNfKlMURVA0yIzXI3L9MgJp3ZDLfESzMxSD
	 oSd8F3XwXkWloBPuQ3zVQAoV2YJrWnU8RJ2pu2iaoPd7FLNe3Q7qlqLT05QJxXl4wB
	 WTOEp71REKtLATztsqtRe8An9sHuD1KGRsGqqgPWlHz7/bNulIxdQvkH/6868SkvlF
	 IDiPDYh6ryDLA==
Message-ID: <sashiko-outbox-191122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Fix stale pick when
 a wakeup resets the donor during dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261030142338.3453484-1-tj@kernel.org>
References: <20261030142338.3453484-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 14:49:29 +0000
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
- [High] sched_ext: stale prev and donor use in dispatch_one() after rq loc=
k drop
- [Medium] sched: stale rq->dl_server across RETRY_TASK in __pick_next_task=
()
--

commit 2376377a1091277fdc742a85c71efe512084aeba
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix stale pick when a wakeup resets the donor during dispatch

When proxy execution is enabled, a concurrent wakeup while dispatch_one()
releases the runqueue lock can reset rq->donor to rq->curr and migrate the
previous donor to another CPU. This commit checks whether prev !=3D rq->don=
or
in dispatch_pick() after dispatch_one() returns and restarts the pick with
SCX_DSP_RETRY.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 904627ef909cb..c3f2f631dfafb 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3919,6 +3919,16 @@ static enum scx_dsp_verdict dispatch_pick(struct r=
q *rq, struct rq_flags *rf,
>  	verdict =3D dispatch_one(rq, prev);
>  	rq_repin_lock(rq, rf);
> =20
> +	/*
> +	 * With proxy execution, @prev is the donor and need not be the running
> +	 * task. A wakeup while dispatch_one() has the rq lock released can
> +	 * reset the donor and move @prev to another CPU. The verdict was
> +	 * computed for @prev and doesn't apply once the donor changed. Restart
> +	 * the pick.
> +	 */
> +	if (unlikely(prev !=3D rq->donor))
> +		return SCX_DSP_RETRY;

[Severity: High]
Because dispatch_pick() checks prev !=3D rq->donor only after dispatch_one()
has completed, can a donor change during an internal rq->__lock drop inside
dispatch_one() cause dispatch_one() and scx_dispatch_sched() to operate on a
stale prev task and a mismatched rq->donor before returning?

In dispatch_one(), scx_process_sync_ecaps() -> __scx_process_sync_ecaps() ->
scx_flush_dispatch_buf() can drop and reacquire rq->__lock:

kernel/sched/ext/ext.c:dispatch_one() {
	scx_process_sync_ecaps(rq, prev);
	...
	if (prev->sched_class =3D=3D &ext_sched_class) {
		update_curr_scx(rq);
		...
		if (scx_bypassing(scx_task_sched(prev), cpu))
			expire_task_slice(prev);
}

If another CPU wakes the blocked donor prev during that window,
proxy_needs_return() resets rq->donor to rq->curr and try_to_wake_up() can
migrate and enqueue prev on a remote CPU. When scx_process_sync_ecaps()
returns:

1. dispatch_one() tests prev->sched_class =3D=3D &ext_sched_class on the old
   donor and calls update_curr_scx(rq), which reads donor =3D rq->donor (now
   rq->curr). If rq->curr is not in ext_sched_class, update_curr_scx() runs
   apply_task_slice_oob() and update_curr_common() on the non-scx rq->curr
   and charges its execution delta to rq->ext_server.

2. scx_task_sched(prev) is called without holding prev->pi_lock or
   task_rq(prev)->__lock, triggering the rcu_dereference_protected() check,
   and expire_task_slice(prev) -> set_task_slice_keep_oob(prev, 0) trips
   lockdep_assert_rq_held(task_rq(p)) while zeroing prev->scx.slice on a
   remote runqueue.

Similarly, if rq->__lock is dropped there or inside scx_dispatch_sched()
(via scx_consume_global_dsq(), scx_consume_dispatch_q(), or
scx_flush_dispatch_buf()):

kernel/sched/ext/inlines.h:scx_dispatch_sched() {
		SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
			    prev_on_sch ? prev : NULL);
}

kernel/sched/ext/ext.c:dispatch_one() {
	if (prev->scx.flags & SCX_TASK_QUEUED) {
		struct scx_sched *prev_sch =3D scx_task_sched(prev);
		...
	}
	...
has_tasks:
	if (unlikely((rq->scx.local_dsq.nr > 1 || verdict =3D=3D SCX_DSP_PREV) &&
		     rq->scx.nr_immed))
		scx_schedule_reenq_local(rq, 0);
}

Wouldn't scx_dispatch_sched() pass the migrated prev pointer to ops.dispatc=
h,
dispatch_one() call scx_task_sched(prev) unlocked when prev is queued on its
new CPU, and the has_tasks path schedule a spurious local DSQ re-enqueue for
a lone SCX_ENQ_IMMED task if a stale SCX_DSP_PREV verdict was reached before
dispatch_pick() turns it into SCX_DSP_RETRY?

[Severity: Medium]
Also, when dispatch_pick() returns SCX_DSP_RETRY during a deadline server
pick (do_pick_task_scx() called from ext_server_pick_task() with
sched_core_enabled(rq) false), could returning RETRY_TASK leave a stale
rq->dl_server pointer across the restart in __pick_next_task()?

In __pick_task_dl(), a RETRY_TASK return from server_pick_task() is non-NUL=
L,
so rq->dl_server is set before returning RETRY_TASK:

kernel/sched/deadline.c:__pick_task_dl() {
	if (dl_server(dl_se)) {
		p =3D dl_se->server_pick_task(dl_se, rf);
		if (!p) {
			dl_server_stop(dl_se);
			goto again;
		}
		rq->dl_server =3D dl_se;
	}
}

In __pick_next_task(), jumping to restart bypasses rq->dl_server =3D NULL:

kernel/sched/core.c:__pick_next_task() {
	rq->dl_server =3D NULL;

	if (scx_enabled())
		goto restart;
	...
restart:
	prev_balance(rq, rf);

	for_each_active_class(class) {
		p =3D class->pick_task(rq, rf);
		if (unlikely(p =3D=3D RETRY_TASK))
			goto restart;
		if (p) {
			put_prev_set_next_task(rq, rq->donor, p);
			return p;
		}
	}
}

If the retry pass ends up picking a non-server task (for instance, if the
migrated donor was the last scx task so ext_server_pick_task() returns NULL
and stops ext_server, or a higher-priority task became runnable while the rq
lock was dropped), wouldn't put_prev_set_next_task() ->
__put_prev_set_next_dl_server() assign the stale &rq->ext_server pointer to
next->dl_server on that task?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030142338.3453=
484-1-tj@kernel.org?part=3D1
