Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706984;
	b=L5nQ5wjralLuhB55wMTinTjXXgG2VEGTA8vzR8I5zeSMe71LLVafB3imn+0ZL/4vDWMg
	 qEbJXWoecBjG5lxLyeJNuRdGVx3HHqxq5Nk4rgGVGllahU5rwX1JbWMD+zvdnonOS3fty
	 PaClk/HRJlOlRcFeXOdsJASie6l1i41HmzT2A4cM0/QGf954pVChwDLKshuwyH6bejWYG
	 iPqKtx9CKMBIGIFUpTMqg1xBJSIQJVf/fpxdhi72j3KddPO9moCg0t2kjwOIsjg2W0whr
	 J0shY81odu99xrjzWrMb6HZW1ragdZe5h/9KC/h6gU/i+3TvXFIpbZ3QRRWBGejFysA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706984;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5AjZrL3ksiyI3v3eRF2j6gnyYQMh+syaspVV6SLlAV0=;
	b=1Adt6CcAv5eUP7D/ZZa2tbUOt37wpVxDbWwLREtzstN98Zz8UuGC8fKJUFkOomFl5tJ9
	 28qiMOvnlxAYQBlH4SZoo3yarO/6Sq7gmC0K9/B3fzPbTNsaqUnW5HtEpMqxLV87s5rO9
	 nCA/iGDAMMS9g+gwaJyrG//YNqzGfo5I+G7cQmPb/yDGAn0HHdUQMA0kBkJHllv1Px/W0
	 qnHZcbkT20P6oP3yjcpyt9lVJLrjIrTzQI9KL3QvDs5oeuV7qF8xM6/mD6RwH9CygOlvg
	 684SDH6pjSer9jzZ1+jf+dB0ctIEjPT3KE8ne531z2UCEoSavorJKFYDPLQc9DyNpsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kc8/0z0U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D05606A319
	for <sched-ext@lists.linux.dev>; Thu, 22 Oct 2026 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kc8/0z0U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9761F01825;
	Thu, 22 Oct 2026 22:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792706983;
	bh=5AjZrL3ksiyI3v3eRF2j6gnyYQMh+syaspVV6SLlAV0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kc8/0z0Uv0dLmynl/iEDhl1yBqDlaTcydUzuUAFVV4ybCa29DuInRFdoBU5KPVKc3
	 B433Q2kVx4ZRSXKPbVnbZpoAhR4Bt2VmFvwRZoF1pipxJX2SjZjv45Oc2yl87xH+pA
	 GzMzwO8j0bgjjUkwtEVVG2mi6fHr7O/e1nG3FWnaPv5kWd8v2wMe+MAZ7uAXVAzKHW
	 MicZ1vbCcklpc29XzR6c3Vy07sdRDrr3dW0hz7NSTHWiVmLu39GpGg0MX+ZfOU/Dwn
	 f2oOloQA2Q+NXJVz9+upSYK/QczBeCcg/QJhGtMnxZjl6DkcO9ARKGEkYGSpWJfhkf
	 Ka0EnC4XaiL4Q==
Message-ID: <sashiko-outbox-182098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/14] sched_ext: Fix bypassed tasks stalling when the
 host lacks SCX_CAP_BASE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261022213836.2259069-11-tj@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org>
 <20261022213836.2259069-11-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 22:09:43 +0000
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
- [High] sched_ext: dispatch_one() ignores kernel slice on bypassing rescuee
--

commit e6fff75e63771c430a8a9775b8c5a361c1a44262
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE

This commit prevents bypassed tasks from stalling on a CPU where their
non-bypassing host scheduler lacks SCX_CAP_BASE by routing them to rescue
on that CPU at enqueue time. It also updates put_prev_task_scx() and
scx_rescue_keep() so that a rescuee with a kernel slice stays on the local
DSQ under bypass.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index bc2ce76c8578a..f19161a0b4d7f 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -3704,8 +3723,13 @@ static void put_prev_task_scx(struct rq *rq, struc=
t task_struct *p,
>  		 * The exception is an IMMED donor put by proxy_resched_idle():
>  		 * the CPU isn't busy, proxy resolution is only retrying through
>  		 * idle, so keep the donor where it can be picked again.
> +		 *
> +		 * A task with a kernel slice stays on the local DSQ even while
> +		 * @sch bypasses. Under bypass, rescue runs @p when the host
> +		 * lacks %SCX_CAP_BASE, see bypass_enq_target_dsq().
>  		 */
> -		if (p->scx.slice && !scx_bypassing(sch, cpu_of(rq))) {
> +		if (p->scx.slice && (!scx_bypassing(sch, cpu_of(rq)) ||
> +				     scx_task_has_kernel_slice(p))) {
>  			if ((p->scx.flags & SCX_TASK_IMMED) && !proxy_put) {
>  				p->scx.flags |=3D SCX_TASK_REENQ_PREEMPTED;
>  				scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index f2718a761fe7e..dc9374d42f796 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -509,12 +509,14 @@ void scx_rescue_end(struct rq *rq)
>   * this when nothing else is runnable and put_prev_task_scx() when anoth=
er task
>   * won the pick. scx_rescue_charge() ends the rescue the moment the admi=
tted
>   * slice is fully served, so arriving here with the rescue still open me=
ans @p
> - * was preempted. Restore the unserved remainder and return %true. @p st=
ays the
> - * rescuee. dispatch_one() keeps it running and put_prev_task_scx() rein=
serts it
> - * at the tail of the local DSQ, behind whatever preempted the rescuee.
> + * was preempted or, under bypass, that dispatch_one() declined to keep =
it
> + * running although it had slice left. Restore the unserved remainder an=
d return
> + * %true. @p stays the rescuee. dispatch_one() keeps it running and
> + * put_prev_task_scx() reinserts it at the tail of the local DSQ, behind
> + * whatever preempted the rescuee.
>   *
> - * Return %false to end the rescue instead - the slice is already fully =
served,
> - * @p is leaving the rq or bypass is dismantling rescues.
> + * Return %false to end the rescue instead - the slice is already fully =
served
> + * or @p is leaving the rq.
>   */
>  bool scx_rescue_keep(struct rq *rq, struct task_struct *p)
>  {
> @@ -522,8 +524,7 @@ bool scx_rescue_keep(struct rq *rq, struct task_struc=
t *p)
> =20
>  	lockdep_assert_rq_held(rq);
> =20
> -	if (!remaining || !(p->scx.flags & SCX_TASK_QUEUED) ||
> -	    scx_bypassing(scx_task_sched(p), cpu_of(rq)))
> +	if (!remaining || !(p->scx.flags & SCX_TASK_QUEUED))
>  		return false;
> =20
>  	scx_set_task_slice(p, remaining);

[Severity: High]
Should the initial slice check in dispatch_one() also allow a task with
scx_task_has_kernel_slice(prev) to keep running while its scheduler is
bypassing, matching put_prev_task_scx()?

In kernel/sched/ext/ext.c, dispatch_one() still checks:

	if (prev->sched_class =3D=3D &ext_sched_class) {
		update_curr_scx(rq);

		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice &&
		    !scx_bypassing(scx_task_sched(prev), cpu)) {
			verdict =3D SCX_DSP_PREV;
			goto has_tasks;
		}
	}

When a sub-scheduler is bypassing on a CPU where its host lacks
SCX_CAP_BASE, bypass_enq_target_dsq() routes the task to rescue and
scx_rescue_admit() grants it SCX_TASK_KERNEL_SLICE (and scx_rescue_timerfn()
sets SCX_TASK_PROTECTED when escalating a starved rescuee). If a reschedule
occurs that does not zero prev->scx.slice (such as a non-preempting kick,
a denied SCX_KICK_PREEMPT in kick_one_cpu(), queue_sync_ecaps(), or a
deferred reenq_local IPI), declining SCX_DSP_PREV at the top of
dispatch_one() appears to cause a couple of regressions:

1. If rq->scx.local_dsq.nr is non-zero (for example, after
scx_rescue_timerfn() escalated prev with SCX_TASK_PROTECTED ahead of a
queued task on local_dsq, or after an ancestor enqueued a task whose
SCX_ENQ_PREEMPT was refused due to SCX_TASK_PROTECTED), dispatch_one()
immediately returns SCX_DSP_LOCAL:

	if (rq->scx.local_dsq.nr) {
		verdict =3D SCX_DSP_LOCAL;
		goto has_tasks;
	}

do_pick_task_scx() then picks the head of local_dsq instead of prev. In
put_prev_task_scx(), because p->scx.slice is still non-zero, the
scx_rescue_keep() block is skipped and prev is reinserted at the head of
local_dsq without rescheduling, evicting the SCX_TASK_PROTECTED rescuee.

2. If rq->scx.local_dsq.nr is zero, dispatch_one() calls
scx_dispatch_sched(root_sch, rq, prev, false) while prev->scx.slice is still
non-zero. In kernel/sched/ext/inlines.h, scx_dispatch_sched() checks
prev->scx.slice before checking rq->scx.local_dsq.nr:

		scx_flush_dispatch_buf(sch, rq);

		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
			return SCX_DSP_PREV;
		if (rq->scx.local_dsq.nr)
			return SCX_DSP_LOCAL;

If ops.dispatch() queues a task onto local_dsq without zeroing
prev->scx.slice, scx_dispatch_sched() still returns SCX_DSP_PREV. If that
newly dispatched task had SCX_ENQ_IMMED set, dsq_inc_nr() skipped
scx_schedule_reenq_local() because SCX_RQ_IN_DISPATCH was set and dsq->nr
was 1, while the has_tasks label in dispatch_one() only checks
rq->scx.local_dsq.nr > 1, leaving the single IMMED task stranded on
local_dsq while prev continues running. Any nested scx_bpf_sub_dispatch()
call will also return true because SCX_DSP_PREV !=3D SCX_DSP_NONE, even if =
the
sub-scheduler dispatched no tasks.

Would updating the top of dispatch_one() to check
(!scx_bypassing(scx_task_sched(prev), cpu) || scx_task_has_kernel_slice(pre=
v))
avoid falling through with a non-zero slice on a bypassing rescuee?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022213836.2259=
069-1-tj@kernel.org?part=3D10
