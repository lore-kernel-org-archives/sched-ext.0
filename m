Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792734857;
	b=Ng7IrNZBHJTOOXxJEH2BKtf0kAhqeWo3k77UcvZWLOF7DJuzaclzrCNG7aVb/+11xitl
	 btq5ruxBkEDNbISqkNY3C2kL8LDE1yjasepJQfeH2KR5yEPzUWzDm97AZ7eok4PzeFIKi
	 j/YNZIvqjfCWsxhqQM6gdTGDwi7sAHMcd+DFzcqRNK0jIcXfPm6cy0cZBqXZi2lo5WXbk
	 WYUIghpqUsLg+9KIkqkRbaWdaOst07PP5zVUjdVmfiLFeq2ebOU1Bx+VftuUwS51RYK6F
	 dF4f9nG7oCmGRjSFlcAtXlw3Cc69FRE9e7pYvKH/Vx8+LYBzc57SiNikFuYD2Pnko8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734857;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GaOJzLhMj/3IDsnA/+cVxunkoDOGOLJe4lofb0N2kZo=;
	b=38dUwh3yLpDtTC58utm5zTekmWD337qeL0pbUFp+TJRL7IoV2WFXAlCd9Z6DcwPPSjA+
	 FKYan5PW/d6cwjsVkbuZuaWozui9Y9ckYASunbhSIKW1P/gYvxeYap1MrIFFeTPquuW7y
	 EyV2OCoXyCw6m0VlLhwYeYa9MRp38gpQdh2m2qXv+GUx6lx6QbldnDWByQzD4OTxFCAMg
	 7BZekN6Rwp8dfvyTItqjsreUdFi/5aXQTZOn7il201qXzCRK3XLEtDXx4a02rAzv2Z+3w
	 6bXm6jxCei382iuYq+TTBXkx5GNuxOjPUjiqCwmb5pA+WrT94ICbeqb642pc9XhgE9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PD1FLQId;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEBF606A31A
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 05:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PD1FLQId
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B167D1F01825;
	Fri, 23 Oct 2026 05:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792734856;
	bh=GaOJzLhMj/3IDsnA/+cVxunkoDOGOLJe4lofb0N2kZo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PD1FLQIdULl463kLLWEJ3PihNkv313V4EHSmCh6iY7AUqMSSHSybPmzIdjkdieA+B
	 5W7QThtX2mFlWwnl+ujFjRHREJmMOeMXTk0xpNjF/3uc48Re2nAnNQmtHhSzKi1rFG
	 68pacf5bSq4uLYmaLX3g3VqixjV5OyqsLiLMFwqGytCvBbrwRpKUXBEQucSwyEp+vG
	 iGF2kN9u9lUSispIPdcGeGBcQDaiU/bTieue7Pfc38QdK9vBcUOgU2TUAkpGC+B6ON
	 ZnDP/y5rGRZ9TUNiSuCdK8KCsxIianEWGrMWXoeoP4E1CMt2pdCbQSKv1yZk29oC4l
	 Nwv8lWijm0QVg==
Message-ID: <sashiko-outbox-182334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/15] sched_ext: Restore a rescuee's slice after
 ops.stopping()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261023052452.2889061-6-tj@kernel.org>
References: <20261023052452.2889061-1-tj@kernel.org>
 <20261023052452.2889061-6-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 05:54:16 +0000
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
- [High] sched_ext: put_prev_task_scx() enqueues protected rescuee with zer=
o slice
--

commit d80161fe3a4644f9489c3d34da621f95c5fb7047
Author: Tejun Heo <tj@kernel.org>

sched_ext: Restore a rescuee's slice after ops.stopping()

This commit moves the scx_rescue_keep() and scx_task_slice_ended() block in
put_prev_task_scx() after ops.stopping() and removes the scx_rescuee(rq)
special case from the local DSQ reinsertion condition.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 4eff83b9a841b..94a49e1ae95b2 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3558,17 +3558,6 @@ static void put_prev_task_scx(struct rq *rq, struc=
t task_struct *p,
> =20
>  	update_curr_scx(rq);
> =20
> -	/*
> -	 * If the slice is consumed, protection ends with it. A rescuee
> -	 * preempted beforehand keeps going, see scx_rescue_keep().
> -	 */
> -	if (!p->scx.slice) {
> -		if (unlikely(p =3D=3D scx_rescuee(rq)))
> -			rescue_keep =3D scx_rescue_keep(rq, p);
> -		if (!rescue_keep)
> -			scx_task_slice_ended(rq, p);
> -	}
> -
>  	/*
>  	 * Preserve the running session when proxy execution refreshes the same
>  	 * donor around an execution-context switch on this rq.
> @@ -3581,6 +3570,18 @@ static void put_prev_task_scx(struct rq *rq, struc=
t task_struct *p,
>  		p->scx.flags &=3D ~SCX_TASK_RUN_TRACKED;
>  	}
> =20
> +	/*
> +	 * If the slice is consumed, protection ends with it. A rescuee keeps
> +	 * going when a preemption or ops.stopping() zeroed its slice, see
> +	 * scx_rescue_keep().
> +	 */
> +	if (!p->scx.slice) {
> +		if (unlikely(p =3D=3D scx_rescuee(rq)))
> +			rescue_keep =3D scx_rescue_keep(rq, p);
> +		if (!rescue_keep)
> +			scx_task_slice_ended(rq, p);
> +	}
> +
>  	if (p->scx.flags & SCX_TASK_QUEUED) {
>  		if (proxy_block)
>  			goto switch_class;
> @@ -3605,12 +3606,8 @@ static void put_prev_task_scx(struct rq *rq, struc=
t task_struct *p,
>  		 * The exception is an IMMED donor put by proxy_resched_idle():
>  		 * the CPU isn't busy, proxy resolution is only retrying through
>  		 * idle, so keep the donor where it can be picked again.
> -		 *
> -		 * An open rescue must keep @p on the local DSQ even if the
> -		 * scheduler zeroed the slice in ops.stopping() above.
>  		 */
> -		if ((p->scx.slice || unlikely(p =3D=3D scx_rescuee(rq))) &&
> -		    !scx_bypassing(sch, cpu_of(rq))) {
> +		if (p->scx.slice && !scx_bypassing(sch, cpu_of(rq))) {

[Severity: High]
Can removing the p =3D=3D scx_rescuee(rq) check here allow a rescuee with
SCX_TASK_PROTECTED set to reach this branch with p->scx.slice =3D=3D 0 and =
fall
through to scx_do_enqueue_task() while still set as rq->scx.rescue.curr?

When a rescuee p is admitted in scx_rescue_admit(), it snapshots
rq->scx.rescue.exec_snap =3D p->se.sum_exec_runtime, and scx_rescue_timerfn=
()
can escalate the rescue by setting SCX_TASK_PROTECTED on p.

If p is a mutex-blocked proxy donor (p->is_blocked =3D=3D 1, rq->donor =3D=
=3D p) and
a mutex owner runs on its behalf (rq->curr !=3D rq->donor), update_curr_scx=
()
calls update_curr_common(rq) -> update_se(rq, &rq->donor->se) in
kernel/sched/fair.c, which credits delta_exec to rq->curr->se.sum_exec_runt=
ime
rather than p->se.sum_exec_runtime:

kernel/sched/fair.c:update_se() {
	...
	if (entity_is_task(se)) {
		struct task_struct *running =3D rq->curr;
		/*
		 * If se is a task, we account the time against the running
		 * task, as w/ proxy-exec they may not be the same.
		 */
		running->se.exec_start =3D now;
		running->se.sum_exec_runtime +=3D delta_exec;
	...
}

Meanwhile, update_curr_scx() decrements donor->scx.slice down to 0, while
scx_rescue_slice_remaining(rq) in kernel/sched/ext/sub.c still sees positive
remaining runtime because rq->scx.rescue.curr->se.sum_exec_runtime did not
advance:

kernel/sched/ext/sub.c:scx_rescue_slice_remaining() {
	s64 served =3D rq->scx.rescue.curr->se.sum_exec_runtime - rq->scx.rescue.e=
xec_snap;

	return max(rq->scx.rescue.slice - served, 0);
}

When put_prev_task_scx() runs for p with p->scx.slice =3D=3D 0, it calls
scx_rescue_keep(rq, p) in kernel/sched/ext/sub.c:

kernel/sched/ext/sub.c:scx_rescue_keep() {
	s64 remaining =3D scx_rescue_slice_remaining(rq);
	...
	if (!remaining || !(p->scx.flags & SCX_TASK_QUEUED) ||
	    scx_bypassing(scx_task_sched(p), cpu_of(rq)))
		return false;

	scx_set_task_slice(p, remaining);
	return true;
}

However, scx_set_task_slice(p, remaining) calls set_task_slice_keep_oob() in
kernel/sched/ext/ext.c, which refuses the slice update because
SCX_TASK_PROTECTED is still set on p:

kernel/sched/ext/ext.c:set_task_slice_keep_oob() {
	lockdep_assert_rq_held(task_rq(p));

	if (unlikely(p->scx.flags & SCX_TASK_PROTECTED))
		return false;

	p->scx.slice =3D slice;
	return true;
}

Because scx_rescue_keep() ignores that false return value and returns true,
put_prev_task_scx() skips scx_task_slice_ended(rq, p), leaving
rq->scx.rescue.curr =3D=3D p with p->scx.slice =3D=3D 0.

Without unlikely(p =3D=3D scx_rescuee(rq)) in the local DSQ reinsertion che=
ck in
put_prev_task_scx(), p now skips local DSQ reinsertion and falls through to
scx_do_enqueue_task(), which can enqueue p onto another DSQ (such as
rq->scx.rescue.dsq, rq->scx.reject_dsq, or a global/user DSQ) while
rq->scx.rescue.curr is still p. If scx_rescue_timerfn() in
kernel/sched/ext/sub.c subsequently fires, it assumes p->scx.dsq is
&rq->scx.local_dsq and unlinks p from the wrong DSQ:

kernel/sched/ext/sub.c:scx_rescue_timerfn() {
	...
	} else if (p->scx.dsq && rq->scx.rescue.budget > 2 * scx_rescue_quantum_ns=
) {
		scx_set_task_slice(p, scx_rescue_slice_remaining(rq));
		p->scx.flags |=3D SCX_TASK_PROTECTED;
		scx_task_unlink_from_dsq(p, &rq->scx.local_dsq);
	...
}

Should scx_rescue_keep() either bypass SCX_TASK_PROTECTED when restoring the
rescue slice or propagate the failure from scx_set_task_slice()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023052452.2889=
061-1-tj@kernel.org?part=3D5
