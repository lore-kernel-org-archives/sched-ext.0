Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792734493;
	b=XZuVp4pGo8mb4sBfM2lfzTW9JCS7G8R5nqxWhFtogKNaoMaEONl8nrWKW1WFJigs31PT
	 TcgM1pqdpAQ1ObZ+k2ZhjvRZg9pj4GHmCNOvAaQAqDqNOZvK8yph8O3z65SHFpi3SGqgM
	 u6lZ9fgV2Sb3h58t287J4O1A3F3HpWBXDgzSWTeyqICye/pMsteHEI4ZyTGZOTu5W0m2k
	 6dojvTHGWs0fxBYXSFYU1GA10SJa7AbLJPKBCC+XnAMzcl3TL5cNuZLPZS+kIkOr+Ewrr
	 9Yz665Z6BkLroqbY1mLFki+GOVnXSe6/ldcVT3k+omwunK+HXmWzZUNosMink52ETVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734493;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SwaZyGAlbvloXAd49Imaw5i4VlVhEojB57VW5PyjUQE=;
	b=nc+QGKtEsv5ndYNeLMYLw7s8npOgjpbFvF+pV/GOfhkBZtxYNivHGXj4VjwmNoAlLdQf
	 jIFp0hXo181MdzjzcYCH9dfddk32V9KDeKswO+BuwBwJU/C6GobtWNXASJsWoGSAQoVcJ
	 MHLKVOKsAdxLZVLsvRYGyd1SxvAalXxdTzT0DBN42+aKyXZpBgW0EBdXF2NLeW/K+w8v7
	 eVEN28Y4/f39QVjBObVPyUglhvuFiM3+z3xJIAPR9c2n1dfI92lLie8Y6A20L3LoPwWi+
	 PkJaIU2OGP2hkJxP3T8Fbz1jtzSwv5QiwzT5XAQ0dCBjGXeBlxv/cT8d8BCiyTSgEAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiuJ0gBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B39606A31A
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiuJ0gBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B194B1F01825;
	Fri, 23 Oct 2026 05:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792734492;
	bh=SwaZyGAlbvloXAd49Imaw5i4VlVhEojB57VW5PyjUQE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IiuJ0gBvfxL2jlHk7DEBS5Jv2g7H4uAEtCUwt7453AcXYmdDE/tY3RNVahTYHUmA3
	 9iEGQs+wxggnWkIZFBRSRVvdohBrVrM3VcxsNTy5jS11wneQ4OEzppV3sn/DgLoBcO
	 5ryNfYXkRmudsd6AyfmTayymCzKp+8ICacilTBa2g89GSwuGihKEW/pycgON6fruK7
	 nzhIgC49qE3MKw6jat9X71j1EKRbvsaUpsKgi2vp0dde5/w+rsKTLNNTe62lEERJ9i
	 UpnBOFinCJZKvP2feTGR/+wzOBnLGZM/BhHMP9Fv7N2Ut+UrZcwQJz5txZtUpeBEDD
	 qQvzmhy9lCuEg==
Message-ID: <sashiko-outbox-182332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/15] sched_ext: Fix bypassed tasks looping on a host
 without SCX_CAP_ENQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261023052452.2889061-4-tj@kernel.org>
References: <20261023052452.2889061-1-tj@kernel.org>
 <20261023052452.2889061-4-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 05:48:12 +0000
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
- [High] sched_ext: bypassed task stranding in scx_do_enqueue_task() on SCX=
_ENQ_IMMED
--

commit 51c04312bb9dbd18b0f365aada46b01365632700
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ

This commit updates scx_dispatch_sched() to pass SCX_ENQ_IMMED when consumi=
ng
tasks from a scheduler's bypass DSQ so that a host scheduler holding only
SCX_CAP_ENQ_IMMED can dispatch bypassed tasks onto the local DSQ.

> diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
> index 8de9d8fb4b25f..1e39d12678c4d 100644
> --- a/kernel/sched/ext/inlines.h
> +++ b/kernel/sched/ext/inlines.h
> @@ -39,10 +39,18 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *=
rq,
>  	if (scx_consume_global_dsq(sch, rq))
>  		return SCX_DSP_LOCAL;
> =20
> +	/*
> +	 * A bypass consume puts a task on the cpu being dispatched for, to run
> +	 * right away. That is an IMMED insert and needs only
> +	 * %SCX_CAP_ENQ_IMMED, the base cap. Dispatch descends into @sch only on
> +	 * a cpu where @sch holds the base cap, so @sch holds it here. The same
> +	 * holds for the consume at the end of this function.
> +	 */
>  	if (scx_bypass_dsp_enabled(sch)) {
>  		/* if @sch is bypassing, only the bypass DSQs are active */
>  		if (scx_bypassing(sch, cpu)) {
> -			if (scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0))
> +			if (scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu),
> +						   SCX_ENQ_IMMED))
>  				return SCX_DSP_LOCAL;
>  			return SCX_DSP_NONE;
>  		}
> @@ -63,7 +71,8 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
>  		struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(sch->pcpu, cpu);
> =20
>  		if (!(pcpu->bypass_host_seq++ % SCX_BYPASS_HOST_NTH) &&
> -		    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0)) {
> +		    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu),
> +					   SCX_ENQ_IMMED)) {
>  			__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
>  			return SCX_DSP_LOCAL;
>  		}
> @@ -135,7 +144,7 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *=
rq,
>  	 * scheduler's ops.dispatch() doesn't yield any tasks.
>  	 */
>  	if (scx_bypass_dsp_enabled(sch) &&
> -	    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0)) {
> +	    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), SCX_ENQ_I=
MMED)) {

[Severity: High]
Can passing SCX_ENQ_IMMED to scx_consume_dispatch_q() here cause bypassed
tasks to be permanently stranded off all dispatch queues in
scx_do_enqueue_task() when reenq_local() reenqueues them?

When a bypassed task p is consumed into rq->scx.local_dsq with
SCX_ENQ_IMMED, dsq_inc_nr() marks it with SCX_TASK_IMMED. If p cannot run
right away (for example, because a higher-priority scheduling class preempts
rq, a head insert occurs ahead of p, or a parent scheduler queues its own
task onto rq->scx.local_dsq before calling scx_bpf_sub_dispatch()),
reenq_local() dequeues p from rq->scx.local_dsq and calls
scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1).

In kernel/sched/ext/ext.c:scx_do_enqueue_task(), sch is set to
scx_task_sched(p) (the bypassing scheduler that owns p, rather than the host
scheduler scx_exec_sched(sch, cpu_of(rq))), and the reenqueue repeat check
runs before the scx_bypassing(sch, cpu_of(rq)) check:

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

Jumping to "goto out" leaves action at its initial value and returns without
inserting p into any DSQ, leaving p->scx.dsq =3D=3D NULL while p remains qu=
eued
in sched_ext.

This appears to break in two scenarios:

1. If p originally triggered SCX_EXIT_ERROR_REENQ, its p->scx.reenq_cnt is
257 (SCX_REENQ_MAX_REPEAT + 1). When scx_sub_disable() or scx_root_disable()
calls scx_bypass(sch, true), it cycles runnable tasks with
DEQUEUE_SAVE | DEQUEUE_MOVE, which calls:

dequeue_task_scx() -> ops_dequeue() -> clr_task_runnable(p, false)

kernel/sched/ext/ext.c:clr_task_runnable() {
	list_del_init(&p->scx.runnable_node);
	WRITE_ONCE(p->scx.runnable_cpu, -1);
	if (reset_runnable_at) {
		p->scx.flags |=3D SCX_TASK_RESET_RUNNABLE_AT;
		p->scx.reenq_cnt =3D 0;
	}
}

Because reset_runnable_at is false, p->scx.reenq_cnt is not reset and stays
at 257 on bypass_dsq. On the very first occasion p is consumed with
SCX_ENQ_IMMED and reenqueued by reenq_local(), ++p->scx.reenq_cnt becomes
258, __scx_exit() is a no-op because sch already exited, and "goto out"
strands p off all DSQs after scx_bypass(sch, true) has already finished.

2. Even when p->scx.reenq_cnt starts at 0, if p is reenqueued 257 times whi=
le
bypassing (for example, when a parent scheduler repeatedly queues its own
task before calling scx_bpf_sub_dispatch()), scx_do_enqueue_task() calls
__scx_exit() on the bypassing task owner sch instead of the active host or
parent scheduler, and jumps to "goto out". Because sch is already in bypass
mode (bypass_depth >=3D 1), any subsequent scx_bypass(sch, true) sees
!changed in kernel/sched/ext/ext.c:scx_bypass():

	if (!changed)
		goto unlock;

and returns without cycling rq->scx.runnable_list, leaving p stranded off a=
ll
DSQs and potentially deadlocking kernel/sched/ext/sub.c:scx_sub_disable() or
scx_root_disable() if p holds a lock or resource waited on during teardown.

Should scx_do_enqueue_task() check scx_bypassing(sch, cpu_of(rq)) before the
SCX_ENQ_REENQ handling (or still route the task to "goto bypass" when the
reenqueue limit is hit), and should scx_bypass() also reset p->scx.reenq_cn=
t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023052452.2889=
061-1-tj@kernel.org?part=3D3
