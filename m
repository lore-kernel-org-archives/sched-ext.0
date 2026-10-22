Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706645;
	b=mLeXPNi3Fg4fiHlhfP0jzA4lR8UxqO5eEuq663mN0Vohv39mHGDWJctT/G1WVoaRZ5S1
	 6koN1xQ6B60xAF3rTH49ryWsdxa6082nkVj6nHLLHuCcea29sa5tkaa5Is2oJ3etx0avX
	 SCT4me7ekffXpnHBzeVkVQ58I4x9LCsSjvYYgHiZEw3wEiN/xS0MlnPgSsWAyyq1q1Dsa
	 slGse+r8VlQI9WQ9dxREnS1zeoavzpPKJFuYLbdEof6BRf9q+OtQvnuR3iLs4nqNzeIP6
	 4/vy8mAyulX3F7QDxu64N7CCPQy5SwIPaIOKHwYjkzRAX/Dm9co1IDJsNXumhxbugbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706645;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hKF7zSJmJekh6vYlmBJ8ryuL/xyFXt8HgISnJ4u2xA8=;
	b=PygSjHhp4oF8TYCOtGVI9rvvMzSHv1jTpYF76UHTCI89CSjOe0bNFGD/J8/KeYfGRs2o
	 Xl5HyQrylqX/BrSXKHPc4vt+jRba2T9nefI1FzUiEl82HM32Lo8Eg+RwhDtb6rB5DT4ur
	 1rjqmQXgDHNsseWnQ5S45LC4RL2fE8aYH03n23FAUQbgk/ot4KI7ABh0gxHTS7076mwbJ
	 pepYuIVEy3SlRbYEI3dwLGcBKC2VhYu+IA6hebmg4UN9p1ZHECizIEOdSEQ7PXMtmcxe1
	 zwPEORrt96UDuONvUQvnAcs/MsIiYumGVkISJbp1NpnM5DBt7/17pYDAbM6cYZfUi1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SnJoWxT/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE83606A319
	for <sched-ext@lists.linux.dev>; Thu, 22 Oct 2026 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnJoWxT/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3941F01825;
	Thu, 22 Oct 2026 22:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706644;
	bh=hKF7zSJmJekh6vYlmBJ8ryuL/xyFXt8HgISnJ4u2xA8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SnJoWxT/VcIL96CzBnYhQeUwqiO6h7X0gB/pxPisp1QPM2qnoR6pXOufQBn83hQ4V
	 +lKX46eDlAsWUb+mvFttGqBFbIBZImtBDzY48TE8uczjQTgsO9c3ZkUJ4SVGEfZ/xK
	 lTrOyoqSXyxMLgg9uVqlhYkVhAiB5HSPxq7UP7ADpUoBNJHr2OpfjxAwy8rHOqkoQG
	 YY6X+/iBUhJsRwJ1CyKmFHy3S4EMwmp968IPJqp+rg/HzjQzla1zHtdf1AYltGk8Bt
	 giDIEQgpOV6FBPGn/K/2AHiP87xGfuV0rsMXlTseLi2FEhtsePruEna51YkYwTkvwL
	 Blcwwr4MCR7kw==
Message-ID: <sashiko-outbox-182094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/14] sched_ext: Fix queued bypassed tasks stalling
 when the host loses SCX_CAP_BASE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261022213836.2259069-15-tj@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org>
 <20261022213836.2259069-15-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 22:04:04 +0000
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
- [High] sched_ext: bypass_lb_reenq_home() strands tasks when reenq_cnt hit=
s limit
--

commit bed3a8daefa075e0cae6b942479850004d920042
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_B=
ASE

This commit drains bypass DSQs on CPUs where the host scheduler has lost
SCX_CAP_BASE, reenqueuing tasks at their home runqueue when no donee CPU can
take them or when a remote move is refused, and kicking the bypass load
balancer timer immediately upon SCX_CAP_BASE loss.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 1983ddaa0d605..aaa57143ff751 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -6575,36 +6575,57 @@ bool scx_hardlockup(int cpu)
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
Can passing SCX_ENQ_REENQ from bypass_lb_reenq_home() to
scx_do_enqueue_task() strand p off all DSQs when p->scx.reenq_cnt exceeds
SCX_REENQ_MAX_REPEAT?

In kernel/sched/ext/ext.c, bypass_lb_move() unlinks p from donor_dsq (leavi=
ng
p->scx.dsq =3D=3D NULL) and calls bypass_lb_reenq_home() when donee < 0 or
task_can_run_on_remote_rq() returns false.

In kernel/sched/ext/ext.c:scx_do_enqueue_task(), the SCX_ENQ_REENQ check ru=
ns
before the scx_bypassing() check:

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

When ++p->scx.reenq_cnt > SCX_REENQ_MAX_REPEAT, scx_do_enqueue_task() calls
__scx_exit() on sch =3D scx_task_sched(p) and jumps to goto out with
action =3D=3D ENQ_ACTION_NONE, returning without inserting p into any DSQ.

In normal operation, stranding p on rq->scx.runnable_list is recovered when
scx_sub_disable() or scx_root_disable() calls scx_bypass(sch, true), which
transitions sch->bypass_depth from 0 to 1 and re-enqueues all runnable tasks
onto the bypass DSQ.

However, a task on a bypass DSQ already has sch->bypass_depth >=3D 1:

kernel/sched/ext/ext.c:scx_bypass() {
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
}

Because sch is already in bypass mode, scx_bypass(sch, true) either already
ran or sees changed =3D=3D false and returns early without walking
rq->scx.runnable_list.

This appears to strand p in two ways:

1. If sch was previously ejected by SCX_EXIT_ERROR_REENQ, p enters
scx_bypass(sch, true) with p->scx.reenq_cnt =3D=3D SCX_REENQ_MAX_REPEAT + 1.
During scx_bypass(sch, true), dequeue_task_scx() -> ops_dequeue() calls
clr_task_runnable(p, false):

kernel/sched/ext/ext.c:clr_task_runnable() {
	list_del_init(&p->scx.runnable_node);
	WRITE_ONCE(p->scx.runnable_cpu, -1);
	if (reset_runnable_at) {
		p->scx.flags |=3D SCX_TASK_RESET_RUNNABLE_AT;
		p->scx.reenq_cnt =3D 0;
	}
}

Because reset_runnable_at is false until p actually runs in
set_next_task_scx(), p sits on the bypass DSQ with p->scx.reenq_cnt still
above SCX_REENQ_MAX_REPEAT. On the first call to bypass_lb_reenq_home()
before p runs, scx_do_enqueue_task() hits the limit and jumps to goto out
before reaching goto bypass, leaving p off all DSQs instead of sending it to
rescue or its home bypass DSQ.

2. Even if p->scx.reenq_cnt starts at 0, after SCX_REENQ_MAX_REPEAT + 1
passes in bypass mode (for instance, when rescue is disabled on a capless C=
PU
or when task_can_run_on_remote_rq() repeatedly refuses a move for a
proxy-migrated blocked donor), scx_do_enqueue_task() calls __scx_exit() on
the already-bypassing child sch =3D scx_task_sched(p) rather than the host
scheduler that lost SCX_CAP_BASE, and jumps to goto out. Since
sch->bypass_depth is already >=3D 1, nothing rescues p from
rq->scx.runnable_list, leaving p permanently off all DSQs and able to stall
scx_sub_disable() or scx_root_disable().

Should scx_do_enqueue_task() avoid stranding p (or check scx_bypassing() /
target the host scheduler) when reenqueuing a bypassed task?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022213836.2259=
069-1-tj@kernel.org?part=3D14
