Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52B49B209
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326757; cv=none; b=KU2cObf7USWZzhWaPq/Zpg5FhwP0fl9hZyKmq64ny1ZKCm6pmUMkqsJLG3lPuaVRR+7PbpvMDiVX6FI82P5mw1YN7bIqc7DTcjYz2C0VFymjS4IEjdRelHsxDOHkM7+ATXgYT3QrQndY1fcB9NGnIweNToHzC7YuNbVYB8O/cos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326757; c=relaxed/simple;
	bh=7qortuGB/6W4WeKB54orZyZyMulFUWCv7qrTlTOS8bE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MAa/ro56zxac7RgXBClyTuTDJOT5iLeBLlaQ3q43bCWL9KZsvQSMbZ4h5eS6iyY55E6R3iOEvVB1+8MGzavZKrcOGMCyBr/FhofMmL0cmY3A0QbjcOi6jV99asvlsyP8W2mMdb9r7Xrc7a7YHmLG6amOh5fYZNpoiJKk2gB2zT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg4Oc0ey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg4Oc0ey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DE71F000C5;
	Sun, 18 Oct 2026 12:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792326754;
	bh=bkPTcZ4yRlkjM3v5Dpc5ggCXUaDiRShqL838OfPn0pA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fg4Oc0eyO/MmZNmDJpxy8St1lJTzC8wqeOEQdlRtm2V2s6+iFMdu8O0XozdptiU7W
	 jVyG7jhZ3ghS8K+oRc2SF2UN5Yns4A2bzDhMcqMa+dcUVyJ6MN8QnJChbn/dYVis0r
	 LYc2v33HYR1+APjjSd/Q/8oXMvDDBD9ccR+y+70oBOauj9uBn/sfq0yh6Eom/7wsjV
	 AgiIYVfScsCS/s3RVrlmNwOPY+Iz31HMrhV5mC60LMf+BLIkiIMgO52SxoBqEa6eyq
	 fMyVfolBbQCXaFS1QVaGhclahY+MPy1aSeeorVb4hMfrJwkZnE6Atp6uKV+UARh0CI
	 DNJshiUBeYQFg==
Message-ID: <sashiko-outbox-176109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/5] sched_ext: Emit ops.cpu_acquire/release() on
 actual CPU transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuba Piecuch" <jpiecuch@google.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <d77edd30310da694faa184001938a23da672c568.1792248922.git.jpiecuch@google.com>
References: <cover.1792248922.git.jpiecuch@google.com>
 <d77edd30310da694faa184001938a23da672c568.1792248922.git.jpiecuch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 12:32:33 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sched_ext: late cpu_avail init in scx_root_enable_workfn() misse=
s release
--

commit b20a6c69347521827673ce5c91d0ce10ed173b33
Author: Kuba Piecuch <jpiecuch@google.com>

sched_ext: Emit ops.cpu_acquire/release() on actual CPU transitions

This commit replaces switch_class() and the speculative acquire in
dispatch_one() with an edge-triggered state machine in
__scx_update_cpu_avail() invoked from the ext and idle classes'
put_prev_task() and set_next_task() callbacks. It also initializes CPU
availability state on scheduler enablement and adds SCX_RQ_OPS_ONLINE to
gate callbacks across hotplug.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index f644382902188..4d02d2d6e6d0d 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -7991,6 +8055,30 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
>  		goto err_disable;
>  	}
> =20
> +	/*
> +	 * Every CPU starts released. Once the hooks are live, acquire the
> +	 * available CPUs. CPUs which don't context switch (e.g. idle ones)
> +	 * wouldn't get there otherwise. scx_root_disable() turns the key off
> +	 * under scx_enable_mutex, so it can't race this.
> +	 */
> +	if (sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) {
> +		for_each_possible_cpu(cpu) {
> +			struct rq *rq =3D cpu_rq(cpu);
> +
> +			guard(rq_lock_irqsave)(rq);
> +			rq->scx.cpu_released =3D true;
> +		}
> +
> +		static_branch_enable(&__scx_cpu_avail_enabled);
> +
> +		for_each_possible_cpu(cpu) {
> +			struct rq *rq =3D cpu_rq(cpu);
> +
> +			guard(rq_lock_irqsave)(rq);
> +			__scx_update_cpu_avail(rq, rq->donor);
> +		}
> +	}
> +

[Severity: Medium]
Can this initialization ordering in scx_root_enable_workfn() miss
ops.cpu_release() and leave SCX tasks stranded on a local DSQ?

Earlier in scx_root_enable_workfn(), tasks are switched to ext_sched_class
and scx_bypass(sch, false) is called before __scx_cpu_avail_enabled is
turned on and before the initial ops.cpu_acquire() callbacks are emitted:

scx_root_enable_workfn()
  scoped_guard(sched_change, p, queue_flags)
    p->sched_class =3D new_class;
    sched_change_end()
      set_next_task_scx() -> ops.running()
  scx_bypass(sch, false)
    sched_change -> ops.enqueue() / ops.running()
    resched_curr(rq)

Because bypass mode is already lifted at this point, ops.running(),
ops.enqueue(), and ops.dispatch() can run on CPUs and populate
rq->scx.local_dsq before those CPUs are acquired.

If an RT, DL, or stop task preempts a CPU after scx_bypass(sch, false) and
before the second for_each_possible_cpu() loop runs __scx_update_cpu_avail()
for that CPU, put_prev_task_scx() puts the preempted SCX task back on
rq->scx.local_dsq and calls scx_update_cpu_avail(rq, next).

If that preemption happens before static_branch_enable(&__scx_cpu_avail_ena=
bled),
scx_update_cpu_avail() is a no-op. If it happens between
static_branch_enable(&__scx_cpu_avail_enabled) and the second loop,
scx_cpu_release() sees rq->scx.cpu_released =3D=3D true from the first loop:

	if (rq->scx.cpu_released || !(rq->scx.flags & SCX_RQ_OPS_ONLINE))
		return;

and returns without calling ops.cpu_release(). When the second loop then
calls __scx_update_cpu_avail(rq, rq->donor), rq->donor is already the higher
class task, so scx_cpu_release() again sees rq->scx.cpu_released =3D=3D tru=
e and
does nothing. As a result, ops.cpu_release() is never called and tasks in
rq->scx.local_dsq remain stranded while the higher class task runs.

Similarly, if an idle CPU wakes up to run an SCX task between
static_branch_enable(&__scx_cpu_avail_enabled) and the second loop reaching
that CPU, put_prev_task_idle() calls scx_update_idle(rq, false, true) before
scx_update_cpu_avail(rq, next) emits the initial ops.cpu_acquire().

Should rq->scx.cpu_released initialization and the initial
__scx_update_cpu_avail() pass happen before tasks are switched into SCX and
scx_bypass(sch, false) is called?

>  	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
>  		static_branch_enable(&__scx_switched_all);

[ ... ]

> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index eb73b65ce6c47..89313f6971244 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -484,12 +484,16 @@ static void put_prev_task_idle(struct rq *rq, struc=
t task_struct *prev, struct t
>  {
>  	update_curr_idle(rq);
>  	scx_update_idle(rq, false, true);
> +	/* idle -> stop/DL/RT/fair releases the CPU from the BPF scheduler */
> +	scx_update_cpu_avail(rq, next);
>  	update_rq_avg_idle(rq);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792248922.gi=
t.jpiecuch@google.com?part=3D2
