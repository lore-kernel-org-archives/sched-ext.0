Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C23362157
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377992; cv=none; b=jqUHqqwX/CLcc/1RlANiJTULd+A5GW5McUrjVS+8jnBd+hvsEqahh+mdeFsUOgwpjTOgieIjP2GcQoUXJ2BzpTq3tLGk+2PVngq+61SjgsqE+OnjN6y/WELDZp06wS3RqbtzvWfybmXl9ztG3A2XGzbphLRYzwhoht+/5NVA9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377992; c=relaxed/simple;
	bh=ziIBgZ6ugC021nMsnD0+dRHQgdjwbwnsZsy9j804EUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lku2DuK9Cr97mZkfYwVtB55QjDc/SvKPQaXFSBtqTrwE5JOMvpvP8yUh3RkYdi13cBBnBsAiomInkJ2C4bKqjMD/UQCVxxPPjoOtBsFDqqqIr6kCOqkLPfKQ8Ai1oq/FVNuNwcoFi4pTZHny0RuCJtvOAftyS//+Nk8MRSkQIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS2pKq0w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS2pKq0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F1C1F000E9;
	Mon, 10 Aug 2026 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786377990;
	bh=vyHKZziOZcN+gl+LW5lFIZ+pl6VgcIj1+F+KEVQAb98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GS2pKq0wG8VwhQ4BvGCWkvPp75G27s89T7UAq2Vli8pcQY/0QPP9hIgPFQPe55xCl
	 xRXP4iEZxKYbmrc2ImeDsq2dyLINacy7BAzRqKed/cwZDsMg2YkE444dz+yL36xyB7
	 7xJrRGUwyE8CqDv9hxEbvzDlhh4bpQh3vHSsGTWkypLDicxjWx7v0c18+UHgSnwN0L
	 +bMCiBUc1tf6fjx5elcX9hRzjGshThddq1E5JPk47wW1amdmtiNyjpnCJkLUgVr+nU
	 /7WX1iezyAVx1LCEKmLh1AnQclGHwnkXACbMMl02ohKlHT7PZeZrx+9WkdxYqOBpEP
	 ObgUfIhPQs+0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] sched_ext: Split curr|donor references properly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260810151523.86994-12-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
 <20260810151523.86994-12-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 16:06:29 +0000
Message-Id: <20260810160630.58F1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] rq_is_open() incorrectly inspects rq->curr instead of rq->donor wh=
en evaluating SCX_ENQ_PREEMPT constraints.
- [High] scx_rescue_charge() misattributes rescue execution time by derefer=
encing scx_task_sched(rq->curr) instead of rq->donor.
- [Medium] dequeue_task_scx() and scx_bypass() incorrectly evaluate task_cu=
rrent() instead of task_current_donor().
- [Medium] Blocked proxy donors incorrectly enter ops.running() and ops.sto=
pping() sessions, directly contradicting documentation.
--

--- Patch [11]: [PATCH 11/15] sched_ext: Split curr|donor references proper=
ly ---
commit 85eb7af3f37babba254fc28b03cd51fb5e7deb18
Author: Andrea Righi <arighi@nvidia.com>
sched_ext: Split curr|donor references properly

This commit updates sched_ext to correctly differentiate between the physic=
al=20
execution task (rq->curr) and the scheduling context donor (rq->donor) duri=
ng=20
proxy execution. It modifies scheduling policy and accounting paths to rely=
 on=20
rq->donor, resolving discrepancies when the two tasks differ. It also exten=
ds=20
scx_dump_state() to explicitly report both contexts.

> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/schedu=
ler/sched-ext.rst
> index ad2fff3c05937..db1ef89ed8f2a 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -487,6 +487,12 @@ and edge cases, to name a few examples:
>    class, in which case it will exit the tick-dispatch loop even though i=
t is runnable
>    and has a non-zero slice.
> =20
> +* Under proxy execution, sched_ext continues to observe the donor as the=
 current
> +  scheduling context. A blocked donor does not enter an ``ops.running()`=
` /
> +  ``ops.stopping()`` session because it does not execute itself, and the=
 lock
> +  owner executing on its behalf is intentionally not reported through th=
ese
> +  callbacks.
> +

[Severity: Medium]
Will blocked proxy donors incorrectly enter ops.running() and ops.stopping(=
)=20
sessions, contradicting this documentation?

In set_next_task_scx(), when restoring a previously resolved context (!firs=
t):

    if ((p->scx.flags & SCX_TASK_QUEUED) && (!p->is_blocked || !first))
        scx_start_task_running(rq, p);

And in scx_proxy_donor_start():

    if (donor->sched_class =3D=3D &ext_sched_class &&
        (donor->scx.flags & SCX_TASK_QUEUED))
        scx_start_task_running(rq, donor);

Does calling scx_start_task_running() unconditionally for queued donors her=
e=20
mark the task with SCX_TASK_RUN_TRACKED and invoke the BPF running callback=
s,=20
violating the API contract that blocked donors do not execute themselves?

>  See the "Scheduling Cycle" section for a more detailed description of how
>  a freshly woken up task gets on a CPU.
> =20
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 7b467b666212b..39d3e3af05f90 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1438,23 +1438,30 @@ static void apply_slice_vtime(struct task_struct =
*p, u64 slice, u64 vtime, u64 e
> =20
>  static void update_curr_scx(struct rq *rq)
>  {
> -	struct task_struct *curr =3D rq->curr;
> +	struct task_struct *donor;
>  	s64 delta_exec;
> =20
> +	/*
> +	 * update_curr_scx() is selected through rq->donor->sched_class, not
> +	 * rq->curr->sched_class, so @donor is always an EXT task here. If an E=
XT
> +	 * owner executes for a FAIR donor, FAIR's update_curr() runs instead.
> +	 */
> +	donor =3D rq->donor;
> +
>  	/* apply even on 0 delta_exec, callers may still act on the slice */
> -	apply_task_slice_oob(rq, curr);
> +	apply_task_slice_oob(rq, donor);
> =20
>  	delta_exec =3D update_curr_common(rq);
>  	if (unlikely(delta_exec <=3D 0))
>  		return;
> =20
> -	if (curr->scx.slice !=3D SCX_SLICE_INF) {
> -		curr->scx.slice -=3D min_t(u64, curr->scx.slice, delta_exec);
> -		if (!curr->scx.slice)
> -			touch_core_sched(rq, curr);
> +	if (donor->scx.slice !=3D SCX_SLICE_INF) {
> +		donor->scx.slice -=3D min_t(u64, donor->scx.slice, delta_exec);
> +		if (!donor->scx.slice)
> +			touch_core_sched(rq, donor);
>  	}
> =20
> -	if (unlikely(curr =3D=3D scx_rescuee(rq)))
> +	if (unlikely(donor =3D=3D scx_rescuee(rq)))
>  		scx_rescue_charge(rq, delta_exec);

[Severity: High]
Does scx_rescue_charge() misattribute rescue execution time by dereferencin=
g=20
scx_task_sched(rq->curr) instead of rq->donor?

When a proxy donor is placed in the rescue DSQ and consumes time,=20
scx_rescue_charge() is called here, but internally it does:

    pcpu =3D per_cpu_ptr(scx_task_sched(rq->curr)->pcpu, cpu_of(rq));
    pcpu->rescue_avg =3D scx_rescue_decay_avg(pcpu) + delta_exec;

If rq->curr is a non-ext task (like fair), scx_task_sched() could return=20
incorrect scheduler contexts or default structures. Can this lead to accoun=
ting=20
corruption or potential pointer dereferences when it charges the consumed=20
budget to the physical execution task's scheduler instead of the ext donor?

> =20
>  	dl_server_update(&rq->ext_server, delta_exec);

[ ... ]

> @@ -1634,9 +1641,9 @@ static void rq_owned_post_enq(struct scx_sched *sch=
, struct rq *rq,
>  	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
>  		return;
> =20
> -	if ((enq_flags & SCX_ENQ_PREEMPT) && p !=3D rq->curr &&
> -	    rq->curr->sched_class =3D=3D &ext_sched_class) {
> -		if (likely(scx_set_task_slice(rq->curr, 0)))
> +	if ((enq_flags & SCX_ENQ_PREEMPT) && p !=3D rq->donor &&
> +	    rq->donor->sched_class =3D=3D &ext_sched_class) {
> +		if (likely(scx_set_task_slice(rq->donor, 0)))
>  			resched_curr(rq);
>  		else
>  			__scx_add_event(sch, SCX_EV_SLICE_DENIED, 1);

[Severity: High]
Does rq_is_open() also need to check rq->donor instead of rq->curr when=20
evaluating SCX_ENQ_PREEMPT constraints?

Currently, rq_is_open() evaluates the physical execution task (rq->curr):

    struct task_struct *curr =3D rq->curr;
    return curr->sched_class !=3D &ext_sched_class ||
        likely(!(curr->scx.flags & SCX_TASK_PROTECTED));

Under proxy execution, if rq->curr is a fair task while the donor (rq->dono=
r)=20
is an ext task with a protected slice, rq_is_open() would return true, caus=
ing=20
dsq_inc_nr() to queue an immed task assuming immediate preemption.

However, since rq_owned_post_enq() here correctly checks rq->donor and refu=
ses=20
preemption, could this leave the newly queued task stranded on the local DS=
Q=20
without a reschedule kick, causing starvation?

[ ... ]

> @@ -2212,13 +2219,14 @@ static void enqueue_task_scx(struct rq *rq, struc=
t task_struct *p, int core_enq_
>  		rq->scx.flags |=3D SCX_RQ_IN_WAKEUP;
> =20
>  	/*
> -	 * Restoring a running task will be immediately followed by
> -	 * set_next_task_scx() which expects the task to not be on the BPF
> +	 * Restoring the current scheduling context will be immediately followed
> +	 * by set_next_task_scx() which expects the task to not be on the BPF
>  	 * scheduler as tasks can only start running through local DSQs. Force
>  	 * direct-dispatch into the local DSQ by setting the sticky_cpu. Mark
>  	 * IGNORE_CAPS to force entry into the local DSQ.
>  	 */
> -	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p)) {
> +	if (unlikely(enq_flags & ENQUEUE_RESTORE) &&
> +	    task_current_donor(rq, p)) {
>  		sticky_cpu =3D cpu_of(rq);
>  		enq_flags |=3D SCX_ENQ_IGNORE_CAPS;
>  	}

[Severity: Medium]
Are there other places that should use task_current_donor() instead of=20
task_current() to avoid stripping the slice from the active proxy donor=20
prematurely?

For example, in dequeue_task_scx():

    if (!((deq_flags & DEQUEUE_SAVE) && task_current(rq, p)))
        scx_task_slice_ended(rq, p);

If a proxy donor is dequeued with DEQUEUE_SAVE (e.g. for a priority change)=
,=20
the task_current(rq, p) check will fail because the physical execution task=
 is=20
not the donor, causing the donor to lose its slice protection.

Similarly in scx_bypass():

    if (bypass && task_current(rq, p))
        scx_task_slice_ended(rq, p);

Could this fail to clear the slice for the active proxy donor because=20
task_current() evaluates to false?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810151523.8699=
4-1-arighi@nvidia.com?part=3D11
