Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792734468;
	b=PHTt3t0QB4qIZ5P5vz17OC/BFd1XpUTqkAtLq5WQf+7sJ62PQRPQ6HyOyWYkCWCZvjW2
	 MMuHn8flkWC0grBorN8SlrIfS1JxfT4K5vnAbY2ZF0EW8ipoxxsFQLtBosGFoCyhnG3ap
	 W4vpqfa70l/QJhk2t4AKfYinmXgl31NCa7J/PpfpOyeiBgY1huOAzeH/i2Wu+qKDHJ9Sy
	 scYAJyAEbW9FNNSMr89vsMUGZONzYjud7H1GSAa9oSyWVo3HSniELiw8iIF4ZlLqqRsVE
	 Dh3ncWHIT0RcE3TNIxP2gi7cNXCegtRx0F7idZy7F2cA9YW9GprLtFqSlFva7Iys7nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734468;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J05GD76mQLoBOkvk9WsVrgAdZcrnfGrJOuVXsboJupA=;
	b=k3Rce0xUQbe+3L2CZkh2Sryb6YJ3MhazVVeUccoNyQj8iRZ33qTOFFL+zSnjT23Lb0/1
	 IfmuDuBClSgpQQAHrnAIeSk7AX+0uOsqaoeBiD/5GlVWiNpDMBnkE9XjT1EhVwtejwC+9
	 edUktzj4SZLnGECY9SfD7dhf878knfXMulhoyO6mNErYTlYARt7WvAKWKgU7kKmT7jylq
	 RDidy/piUcdmuZJDuNMqc5luEDLZE9xOGWXzx1FKcEIqAkCs6bDpzc4KnaHrRGLzBliIA
	 rYDyfJdTTjhVUWVGHuSCbTyCRgl+xywE5vkk4WMJst6FrI14567CM7x2P5cAbEzvTZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikOLElSd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1796606A31A
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikOLElSd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325BC1F01825;
	Fri, 23 Oct 2026 05:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792734467;
	bh=J05GD76mQLoBOkvk9WsVrgAdZcrnfGrJOuVXsboJupA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ikOLElSdOS2QRqoZfd1rMnTKajiQke8XB57bRDdzCNliRl0nwawV0p8MnlJJ+BKm4
	 lPGZaVoqLWY3JfDj3EmKEDthPkigSPEF5biulHj8rjJRyNg3YYetob/tkd72DZiwlU
	 1sbRQUMDPnhyqpTuk/h8u8DHOlucVDDAJvaQykYqae870sb/ZPTr3PAl6E8NMvQHT/
	 HxLxodhyfhE+x4WNw9HjlO8LJaO4QE6WHKZtgbUqfbkBvZv7ypyxnv5O+Bh/X/egHQ
	 yy0rwBTGiEBn0i6YRcBv+0MToD0vpAaeKoMNGu1rk9P2ZIcAfkRmRgwjvAE3yXCVnP
	 Ks/R0m2alfz7A==
Message-ID: <sashiko-outbox-182331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] sched_ext: Fix queued bypassed tasks stalling
 when the host loses SCX_CAP_BASE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261023052452.2889061-16-tj@kernel.org>
References: <20261023052452.2889061-1-tj@kernel.org>
 <20261023052452.2889061-16-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 05:47:46 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched_ext: bypass_lb_reenq_home() strands tasks and ejects wrong s=
cheduler
--

commit d55be0297257c9718ad7fd18c39f7e2d5c53c076
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_B=
ASE

This commit updates the bypass load balancer to drain bypass DSQs on CPUs
where the host scheduler loses SCX_CAP_BASE, reenqueuing tasks at their home
CPU when no donee CPU can accept them or when a move is refused. It also ki=
cks
the balancer timer immediately upon SCX_CAP_BASE loss and uses timer_reduce=
()
when arming the timer to preserve pending kicks.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 562213f371a61..38d1b9176bd56 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -6515,36 +6515,57 @@ bool scx_hardlockup(int cpu)
>  	return true;
>  }
> =20
> +/**
> + * bypass_lb_reenq_home - Reenqueue a task at its home from the balancer
> + * @rq: @p's home rq, locked
> + * @p: task off any DSQ, taken from the bypass DSQ of @dsq_cpu
> + * @dsq_cpu: cpu whose bypass DSQ gave up @p
> + *
> + * @p came off the bypass DSQ of @dsq_cpu with no donee able to take it.=
 The
> + * enqueue sends @p to rescue when the host lacks %SCX_CAP_BASE at home =
and to
> + * the home's bypass DSQ otherwise, see bypass_enq_target_dsq(). No DSQ =
lock may
> + * be held, as the enqueue takes one.
> + */
> +static void bypass_lb_reenq_home(struct rq *rq, struct task_struct *p, s=
32 dsq_cpu)
> +{
> +	lockdep_assert_rq_held(rq);
> +
> +	WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
> +	p->scx.flags |=3D SCX_TASK_REENQ_CAP;
> +	p->scx.reenq_reason_caps =3D SCX_CAP_BASE;
> +	p->scx.reenq_reason_cid =3D __scx_cpu_to_cid(dsq_cpu);
> +	scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
> +}

[Severity: High]
Can calling scx_do_enqueue_task() with SCX_ENQ_REENQ from
bypass_lb_reenq_home() permanently strand p off all DSQs while p is already
in bypass mode, and target the wrong scheduler for SCX_EXIT_ERROR_REENQ?

In bypass_lb_move(), p is unlinked from donor_dsq (setting p->scx.dsq =3D N=
ULL)
before calling bypass_lb_reenq_home(). Inside scx_do_enqueue_task(), sch is
initialized to scx_task_sched(p), and the SCX_ENQ_REENQ repeat check runs
before the scx_bypassing() check:

kernel/sched/ext/ext.c:scx_do_enqueue_task() {
    ...
	if (enq_flags & SCX_ENQ_REENQ) {
		if (++p->scx.reenq_cnt > 1)
			__scx_add_event(sch, SCX_EV_REENQ_REPEAT, 1);

		if (unlikely(p->scx.reenq_cnt > SCX_REENQ_MAX_REPEAT)) {
			__scx_exit(sch, SCX_EXIT_ERROR_REENQ, 0, cpu_of(rq),
				   "%s[%d] reenqueued %u times without running",
				   p->comm, p->pid, p->scx.reenq_cnt);
			goto out;
		}
	}

	if (!scx_rq_online(rq))
		goto local;

	if (scx_bypassing(sch, cpu_of(rq))) {
		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
		goto bypass;
	}
    ...
}

When p->scx.reenq_cnt exceeds SCX_REENQ_MAX_REPEAT, scx_do_enqueue_task()
jumps to out with action =3D=3D ENQ_ACTION_NONE, leaving p off all DSQs whi=
le
SCX_TASK_QUEUED and p->on_rq remain set.

In normal operation, stranding p at goto out relies on __scx_exit()
subsequently running scx_disable_workfn() -> scx_bypass(sch, true), where
inc_bypass_depth(sch) transitions sch->bypass_depth from 0 to 1 and sweeps
rq->scx.runnable_list to place p onto a bypass DSQ:

kernel/sched/ext/ext.c:scx_bypass() {
    ...
	if (bypass) {
		changed =3D inc_bypass_depth(sch);
		if (changed)
			enable_bypass_dsp(sch);
	} else {
		changed =3D dec_bypass_depth(sch);
	}
    ...
	if (!changed)
		goto unlock;
    ...
}

However, any task queued on a bypass DSQ already has its owning scheduler
sch =3D scx_task_sched(p) in bypass mode (sch->bypass_depth >=3D 1). This a=
ppears
to cause two issues when bypass_lb_reenq_home() is called:

1. Immediate stranding on the first bypass_lb_reenq_home() call:
If a task triggered SCX_EXIT_ERROR_REENQ in normal operation (leaving
p->scx.reenq_cnt =3D=3D SCX_REENQ_MAX_REPEAT + 1) or entered scx_bypass(sch=
, true)
with p->scx.reenq_cnt =3D=3D SCX_REENQ_MAX_REPEAT, scx_bypass(sch, true) cy=
cles p
through dequeue_task_scx() -> ops_dequeue() -> clr_task_runnable(p, false) =
and
enqueue_task_scx(). Because clr_task_runnable() only resets p->scx.reenq_cnt
when reset_runnable_at is true:

kernel/sched/ext/ext.c:clr_task_runnable() {
	list_del_init(&p->scx.runnable_node);
	WRITE_ONCE(p->scx.runnable_cpu, -1);
	if (reset_runnable_at) {
		p->scx.flags |=3D SCX_TASK_RESET_RUNNABLE_AT;
		p->scx.reenq_cnt =3D 0;
	}
}

p is placed onto the bypass DSQ with p->scx.reenq_cnt >=3D SCX_REENQ_MAX_RE=
PEAT.
If bypass_lb_reenq_home() is then called on p (even once to send p to the
rescue DSQ when the host loses SCX_CAP_BASE, or when a donee refuses the
move), ++p->scx.reenq_cnt > SCX_REENQ_MAX_REPEAT triggers before reaching
goto bypass and strands p off all DSQs.

2. Wrong scheduler ejection and stranding after SCX_REENQ_MAX_REPEAT passes:
Because the root scheduler never lacks SCX_CAP_BASE, a host scheduler whose
bypass DSQ is drained due to losing SCX_CAP_BASE is a non-bypassing ancestor
sub-scheduler (host =3D scx_exec_sched(sch, cpu_of(rq)) !=3D sch), while
sch =3D scx_task_sched(p) is an already-bypassing descendant (for example, =
in
scx_sub_disable(sch) where sch->exit_kind is already SCX_EXIT_DONE and
scx_bypass(sch, true) has already completed).

When p is repeatedly reenqueued by bypass_lb_reenq_home() (for instance, on=
 a
capless host CPU without rescue, or when task_can_run_on_remote_rq()
repeatedly refuses a move), __scx_exit(sch, SCX_EXIT_ERROR_REENQ, ...) targ=
ets
the already-bypassing descendant sch rather than the host scheduler that la=
cks
SCX_CAP_BASE. Neither sch nor host sweeps rq->scx.runnable_list for p
afterwards (if sch is disabling, __scx_exit() is a no-op and scx_bypass()
already ran; if sch is in bypass via PM or enable, a later scx_bypass(sch,
true) sees changed =3D=3D false and skips the runnable_list sweep).

If p is stranded while holding a lock or inside a cgroup operation, could t=
his
also block scx_sub_disable() or scx_root_disable() when waiting on
drain_descendants(), scx_enable_mutex, scx_fork_rwsem, or scx_cgroup_lock()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023052452.2889=
061-1-tj@kernel.org?part=3D15
