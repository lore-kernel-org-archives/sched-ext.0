Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781446;
	b=tJCpzsIG56WD46cYq8e7LR0At0f44eZgez7YKEc1c/R7ssYjkHTAGG0TpX5K6+LGgSq5
	 SAlHi3eSRkhYlkLgs/l+Wpu/SvryHrBkP2n28Iy02Rn37Ac8wkKv/kJ1ySeJHv3eJJrA0
	 UK9vNfQ9SscaPdfBwtOvqtJsIR43GumJcAY4DpZWA6ySm0mSspzRK1PxinM7kkJo+ssVF
	 bz5xd+dOy+SFhQCCubq87sLIS8XhxgcqkTG4UQ66UapkNqxmhFT9hXtARh7gv2rvVOvg0
	 6tmYrp+HJT5sIkIufN9SOUOYZjsQg2/vv7qWhSXWXlYd2HsnVHuU0nGgcGIwO9g4u3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n0ZIObocX5p5s3NUuEov2jCXbFsbpB/taTQX1bPErao=;
	b=O6KVlvuiEAO17Un+DPSt+1usqyHMjRisVJtTSqV2/bLVhvhPZoAN5k7uDEf8RCudv5s3
	 6s08anO5nqSvHkU8gug36Ckq1tfrwlJc/G2W0VFFLxSMImyGNFp4jCjJC6n0BPu7bT13i
	 vo+uAwIwNPuHN/81wZhP92rixnejFDfKm3edHzKn4PAweZm0//7va0FPzskbwXjPOD81q
	 57SuvtliTxUTf4d4KqwayMAt+UrnupWW22hm1fXxNIsxnjODKK3gZdcZBX+aNcrj70z8w
	 uurawVxbBJBRSy2TXFf3pUp/Rx/WUsV56iot2OPgYCdW73JhcDU6Z9Fh21to+pEruFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKIgu50y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162E606A31F
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKIgu50y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE2F1F01825;
	Fri, 23 Oct 2026 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792781445;
	bh=n0ZIObocX5p5s3NUuEov2jCXbFsbpB/taTQX1bPErao=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oKIgu50yJgLlWEHrWhAOcIFigKl0VbvHBvufBZ6au6haqgZnJeHrbWZKr4SnsPK18
	 6fiUZVda5UKtDbKCML0+cxaU/AQATAruIb/N1gg0rZAM/q6Jfvd9KmJRxrgHski9J3
	 72yCahuCwcNDyDKg7yjr2WZpDpEIeHn2EeOBu9VYz7zoiRStCg2gWTHCFML9qSl9JC
	 /R6vhgPywktllaLRhpAhvfAh0vUkMUJYCt6Z1EKEYRkqqSs+ytDiMApbE5TtnTiXpK
	 NTgpHlA+tYoonSG/kX0gZRezpiaBd+50trZJ6nxJBuWn8IMyyyO7YWCg/g76Z61CPc
	 gXDm7OFQ0RQRA==
Message-ID: <sashiko-outbox-183085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/17] sched_ext: Fix bypassed tasks looping on a host
 without SCX_CAP_ENQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261023175608.4120910-5-tj@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org>
 <20261023175608.4120910-5-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 18:50:45 +0000
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
- [Medium] sched_ext: missing IMMED reenqueue in dispatch_one() on SCX_DSP_=
PREV
--

commit 8162142ab19efe38b37c48e80241c382a88435ec
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ

This commit updates scx_dispatch_sched() to pass SCX_ENQ_IMMED when consumi=
ng
tasks from a scheduler's bypass DSQ so that a host holding only
SCX_CAP_ENQ_IMMED (SCX_CAP_BASE) can run bypassed tasks without needing
SCX_CAP_ENQ.

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

[Severity: Medium]
Can a bypassed task consumed with SCX_ENQ_IMMED get left waiting on
rq->scx.local_dsq without being reenqueued when dispatch_one() finishes with
SCX_DSP_PREV?

During dispatch_one(), SCX_RQ_IN_DISPATCH is set on rq->scx.flags, which ma=
kes
rq_is_open() unconditionally return true so that resolution of whether prev
keeps running is deferred until the end of dispatch_one():

kernel/sched/ext/ext.c:rq_is_open() {
	...
	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
		return true;
	...
}

If a parent scheduler's ops.dispatch() calls scx_bpf_sub_dispatch() on a ch=
ild
while rq->scx.local_dsq is empty and scx_dispatch_sched() consumes a single
task from scx_bypass_dsq(child, cpu) with SCX_ENQ_IMMED (or if
scx_process_sync_ecaps() queues a single SCX_ENQ_IMMED task during its
callbacks), dsq_inc_nr() sees dsq->nr =3D=3D 1 and rq_is_open() =3D=3D true=
, so it
does not call scx_schedule_reenq_local():

kernel/sched/ext/ext.c:dsq_inc_nr() {
	...
	if (p->scx.flags & SCX_TASK_IMMED) {
		...
		rq->scx.nr_immed++;

		if (unlikely(dsq->nr > 1 || !rq_is_open(rq, enq_flags)))
			scx_schedule_reenq_local(rq, 0);
	}
}

If the parent's ops.dispatch() also extends prev->scx.slice (or prev already
had slice left after scx_process_sync_ecaps()), scx_dispatch_sched() returns
SCX_DSP_PREV before checking rq->scx.local_dsq.nr:

kernel/sched/ext/inlines.h:scx_dispatch_sched() {
	...
		scx_flush_dispatch_buf(sch, rq);

		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
			return SCX_DSP_PREV;
		if (rq->scx.local_dsq.nr)
			return SCX_DSP_LOCAL;
	...
}

At the has_tasks label in dispatch_one(), the check only tests whether
rq->scx.local_dsq.nr > 1:

kernel/sched/ext/ext.c:dispatch_one() {
	...
has_tasks:
	if (unlikely(rq->scx.local_dsq.nr > 1 && rq->scx.nr_immed))
		scx_schedule_reenq_local(rq, 0);

	rq->scx.flags &=3D ~SCX_RQ_IN_DISPATCH;
	return verdict;
}

Because prev is not on local_dsq, rq->scx.local_dsq.nr is 1, so
scx_schedule_reenq_local() is not called, and do_pick_task_scx() keeps runn=
ing
prev while the single SCX_TASK_IMMED task remains queued on local_dsq (even
when its scheduler lacks SCX_CAP_ENQ).

Should the check at has_tasks in dispatch_one() also trigger
scx_schedule_reenq_local() when verdict =3D=3D SCX_DSP_PREV and rq->scx.nr_=
immed
is non-zero, such as checking (rq->scx.local_dsq.nr > 1 || verdict =3D=3D
SCX_DSP_PREV) && rq->scx.nr_immed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023175608.4120=
910-1-tj@kernel.org?part=3D4
