Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706651;
	b=JeYStFr2SzwdZ7zd4EhxCzGyUouT/YnibETeOfw3H5ZTsONgNZAdz4QgSZHLCTl4U4M+
	 YHYIXJV/XXu3EKHzDBzUBER68kGClPVye1LJ7UI0gC/9RE7bJIKHHS2+VwQb0Ld3SLaq8
	 vGiELCNnHvACHKPxH4SDSZH0taa7BFnSGllykw2VTl32CLgx/5KU5elOJiLavJ0hbjALn
	 MpiKaSrAZsnptF3LCFJCrPb8qy9e2/03CKlan4uz+9cKr/rhTK5vp/MI97Z6zStr8BGeo
	 sLANPRrRy10TXlO0FzJpeFsKfYIS50jWkSVk6GeCIjBB4MYy7SvFjib/TNVnY/a97uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LujmqZ8Cf9sDa7suI9h9/b6AmF3j0yaxHN3cNjVsW4k=;
	b=5Fxa5rfkRJ5Yp9hvWCtUrsw6uFtYm6WTTFlqlXDdUp+/ae9sK4NrpJn3r98I4KFZRRwW
	 XXlLAq1goLRQBBdU9Dcl5nK75iRc0CdoTTlrdbkd5nStlvrx4WvzOsyuoTJZSDtdaaUUJ
	 jcHicpeHz2zmbprRlcNDlokrs4671QzYEmmu6fcsRqXOMTJ4EfDgk64GpNMniNFvfpoGf
	 wjj/FfcOfKbekC5xVgQjUQCSbXyJw2OkP88Wp3S89nCfaIlV7RXIRaNvFCie9JmRY58FQ
	 IyQkvVYvGgEuRQY6Omfmp5Jm5RtmAMqw2hjptqmOFj47hufkI/dY+et2e4NkHOmI/cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KGFMC6/J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E757606A319
	for <sched-ext@lists.linux.dev>; Thu, 22 Oct 2026 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGFMC6/J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C1F1F01825;
	Thu, 22 Oct 2026 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706650;
	bh=LujmqZ8Cf9sDa7suI9h9/b6AmF3j0yaxHN3cNjVsW4k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KGFMC6/Jjo+HLOMrW6OQnYKD3zSHgXLKZQ5rVYWiW5ndNR3mudTCM6/JaYL7dCcW8
	 OVe8MLTQuH30T2ShIBq8FmzxahdYw4ddQAnjW54YUN6NSaPETDy9Xey8PEW3pDz1Hx
	 ggLQoOITDvPcRm8LdgKFsEkxYnYdBx2dY8MxsnaQSpdYX6BpbJfQVPxssFfE/upBf5
	 mjq694seQPF6AUx3WTbr7nk1UGGG4VNFcGzd4LbluxpbhkhM08kqd7AZeszbmF5r5p
	 6fp2mIJm8psLmJbcMFDjytvzRPbVre91zk8B2W/GpGoMxKu9JgRLpJoMalcXncGKpw
	 D4t2EPngVg4Kw==
Message-ID: <sashiko-outbox-182095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/14] sched_ext: Fix bypassed tasks looping on a host
 without SCX_CAP_ENQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261022213836.2259069-4-tj@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org>
 <20261022213836.2259069-4-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 22:04:10 +0000
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
- [High] sched_ext: bypassed tasks stranded on IMMED reenqueue in scx_do_en=
queue_task()
- [Medium] sched_ext: IMMED bypass task not reenqueued in dispatch_one() on=
 SCX_DSP_PREV
--

commit b04a1e4f05e2438aeebad95d1faba49149a6c6e2
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ

This commit updates bypass dispatch queue consumption in scx_dispatch_sched=
()
to pass SCX_ENQ_IMMED so that a host scheduler holding only SCX_CAP_ENQ_IMM=
ED
can consume bypassed tasks onto the local DSQ without rejecting them for
lacking SCX_CAP_ENQ.

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

[Severity: High]
Can consuming bypassed tasks with SCX_ENQ_IMMED here cause a bypassed task =
to
be stranded off all dispatch queues in scx_do_enqueue_task() when it gets
reenqueued from the local DSQ?

When scx_consume_dispatch_q() moves a bypassed task to rq->scx.local_dsq wi=
th
SCX_ENQ_IMMED, dsq_inc_nr() marks the task with SCX_TASK_IMMED. If the task
cannot run right away (for example, due to a higher-priority wakeup, a head
insert, or a parent scheduler queueing its own task ahead of
scx_bpf_sub_dispatch()), reenq_local() dequeues it from rq->scx.local_dsq a=
nd
calls scx_do_enqueue_task() with SCX_ENQ_REENQ.

In kernel/sched/ext/ext.c:scx_do_enqueue_task(), sch is resolved as
scx_task_sched(p) (the bypassing scheduler that owns p, rather than the host
scheduler), and the reenqueue limit is checked before scx_bypassing():

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

This appears to break in two ways:

1. If a task previously triggered SCX_EXIT_ERROR_REENQ, it enters bypass wi=
th
   p->scx.reenq_cnt already at SCX_REENQ_MAX_REPEAT + 1 because cycling the
   task in scx_bypass() via dequeue_task_scx() -> ops_dequeue() ->
   clr_task_runnable(p, false) does not reset p->scx.reenq_cnt. On the very
   first local DSQ reenqueue during bypass, p->scx.reenq_cnt increments aga=
in
   and hits the goto out path before reaching goto bypass. Because
   scx_bypass(sch, true) in scx_sub_disable() or scx_root_disable() has
   already run, nothing picks the task back up, leaving it stranded off all
   DSQs while teardown waits for forward progress.

2. Even if p->scx.reenq_cnt starts at 0, if a bypassed task is reenqueued
   more than SCX_REENQ_MAX_REPEAT times (for example, because a parent
   scheduler repeatedly queues a task before calling scx_bpf_sub_dispatch()=
),
   __scx_exit() is called on the already-bypassing descendant sch instead of
   the host scheduler, and goto out strands the task off all DSQs.

Should scx_do_enqueue_task() check scx_bypassing(sch, cpu_of(rq)) before the
SCX_ENQ_REENQ handling, or attribute and handle reenqueues of bypassed tasks
against the host scheduler without stranding the task?

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
>  		__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
>  		return SCX_DSP_LOCAL;
>  	}

[Severity: Medium]
What happens if a child host holding only SCX_CAP_ENQ_IMMED consumes a sing=
le
bypassed task with SCX_ENQ_IMMED during scx_bpf_sub_dispatch() while
rq->scx.local_dsq is empty, and the parent scheduler's ops.dispatch() also
extends prev->scx.slice?

During dispatch_one(), SCX_RQ_IN_DISPATCH is set on rq->scx.flags, so
rq_is_open() returns true:

	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
		return true;

When the child consumes one bypassed task onto the empty rq->scx.local_dsq,
dsq_inc_nr() sees dsq->nr =3D=3D 1 and rq_is_open() =3D=3D true, so it incr=
ements
rq->scx.nr_immed to 1 without calling scx_schedule_reenq_local().

When control returns to the parent's scx_dispatch_sched(), extending
prev->scx.slice causes it to return SCX_DSP_PREV before checking
rq->scx.local_dsq.nr:

		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
			return SCX_DSP_PREV;
		if (rq->scx.local_dsq.nr)
			return SCX_DSP_LOCAL;

Then at has_tasks in kernel/sched/ext/ext.c:dispatch_one(), the post-dispat=
ch
check only schedules a local reenqueue when rq->scx.local_dsq.nr > 1:

has_tasks:
	if (unlikely(rq->scx.local_dsq.nr > 1 && rq->scx.nr_immed))
		scx_schedule_reenq_local(rq, 0);

Because prev is rq->donor and not on rq->scx.local_dsq, rq->scx.local_dsq.nr
is 1, so scx_schedule_reenq_local() is not called. Doesn't this leave the
single bypassed task waiting on rq->scx.local_dsq behind prev without holdi=
ng
SCX_CAP_ENQ and without being reenqueued back to the bypass DSQ?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022213836.2259=
069-1-tj@kernel.org?part=3D3
