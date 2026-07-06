Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5485F41A774
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356567; cv=none; b=hW0LwVzVI4VfKNmy3FII8LJtsHopZEko9e6uCp13O4m32zD1xazmIlWXLgibxyCHixnCZN/Y/YxqDGes+7nirvhzlzJ1/U0HbauNeO9+e9VEHjjiyyJe+ulIPeVyvs4UPq2yVZ1ZRapTUifA9pakKNGtfTMKRNdPh1aSDl1iL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356567; c=relaxed/simple;
	bh=MJJvSTQkMS+PmFl/JxuZILh0ya0s5xWzMHXXHX5PV5E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yac7i+6A+zhORDBri7vOCTr1FHUuWkpnU5aQvFe9gVnyZBZMBq5T5t+QK8TQy7tUigvxUB1Mb1VB4XuVfu47Qo8kjgu25eGcQPfCsdG2/SZM1wN5nFIrGKCjXT31ZEcwOl6+cx6JbtAMTMz7PRjCeaeBbD4K948ahODfuwmGjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0DLdik0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0DLdik0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85BA1F000E9;
	Mon,  6 Jul 2026 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783356566;
	bh=H8uEFJxp5D4OZlIXYvP1EP7i84/VMEoo/pBAmWEfpqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a0DLdik0AXnyw3s24c9+9n7rIxd2vUtVCK4EqgMngSL9zbcurYbYhyKQQP1RlE8cm
	 ZnE3x86VF4Svrh+p55rpu/fslkt5X+uqTqNfHerBdm8vUe7GgKii0uSzNpRxR2BScV
	 3IUhOOnZ3bjIQY08ZR+rv165pG9GSXTWIweklhgiCPYT/jnolPJuj/Cj0zSGnpNre1
	 VmZB5Fhm9xPJz1IjBDXLwXKRkFwxxUilBP0WnSSlEe80NKD5CDgShTTz4bfMm1bvVR
	 +MLuUET+K3QTMoiHUeiKxlOoRqFNzMINFjbJmtIXZwtu1wDyJjOnS9pdkYooibq8EU
	 /CJNxZ+tOWa7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Enable tick for finite slices on
 nohz_full
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706162819.650155-2-arighi@nvidia.com>
References: <20260706162819.650155-1-arighi@nvidia.com>
 <20260706162819.650155-2-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 16:49:24 +0000
Message-Id: <20260706164925.C85BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch's fix for finite slices is incomplete: it fails to resto=
re the tick dependency when switching from a tick-stopped non-EXT task (suc=
h as idle) to an EXT task with a finite slice, if the last EXT task on that=
 CPU also had a finite slice.

Pre-existing issues:
- [High] The patch manually sets the tick dependency when transitioning to =
a finite-slice SCX task but fails to ensure it is cleared when transitionin=
g out to a non-EXT task (such as CFS or idle), causing a persistent leak th=
at breaks nohz_full isolation.
- [High] When transitioning to an infinite-slice task, the patch continues =
to call `sched_update_tick_dependency(rq)`. Because `scx_can_stop_tick()` e=
valuates the outgoing task (`rq->curr`), transitioning from a non-EXT task =
to an infinite-slice EXT task while in bypass mode will incorrectly clear t=
he tick dependency.
--

commit ed44446cf6110ce75b933d2ec6430b4cf1e80f2a
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Enable tick for finite slices on nohz_full

This commit addresses an issue where an incoming SCHED_EXT task with a fini=
te
slice could fail to receive the ticks needed to expire its slice. It changes
set_next_task_scx() to directly set the TICK_DEP_BIT_SCHED dependency for
finite-slice tasks, bypassing the normal sched_update_tick_dependency() che=
ck
that relies on the outgoing task state. For infinite-slice tasks, it contin=
ues
to use sched_update_tick_dependency().

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 691d53fe0f648..9b2399a1e9656 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2974,12 +2974,20 @@ static void set_next_task_scx(struct rq *rq, stru=
ct task_struct *p, bool first)
>  	 */
>  	if ((p->scx.slice =3D=3D SCX_SLICE_INF) !=3D
>  	    (bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {

[Severity: High]
Does this condition prevent the tick dependency from being restored when
switching from a tick-stopped non-EXT task (such as idle) to an EXT task
with a finite slice, if the last EXT task on that CPU also had a finite sli=
ce?

If a finite-slice EXT task previously cleared SCX_RQ_CAN_STOP_TICK, and the
CPU then transitions to a non-EXT state that clears the global tick depende=
ncy,
the false !=3D false evaluation here will bypass this entire block. This wo=
uld
cause the new finite-slice EXT task to run without a tick, potentially caus=
ing
it to monopolize the CPU since its slice won't expire.

> -		if (p->scx.slice =3D=3D SCX_SLICE_INF)
> +		if (p->scx.slice =3D=3D SCX_SLICE_INF) {
>  			rq->scx.flags |=3D SCX_RQ_CAN_STOP_TICK;
> -		else
> +			sched_update_tick_dependency(rq);

[Severity: High]
This isn't a bug introduced by this patch, but when transitioning from a
non-EXT task to an infinite-slice EXT task while in bypass mode, could call=
ing
sched_update_tick_dependency() here incorrectly clear the tick dependency?

Because scx_can_stop_tick() evaluates the outgoing task:

kernel/sched/ext/ext.c:scx_can_stop_tick() {
    ...
	if (p->sched_class !=3D &ext_sched_class)
		return true;
    ...
}

It will return true early for the outgoing non-EXT task. This bypasses the
scx_bypassing() check entirely, which could stall tasks queued in the bypass
DSQ indefinitely by incorrectly stopping the scheduler tick.

> +		} else {
>  			rq->scx.flags &=3D ~SCX_RQ_CAN_STOP_TICK;
> =20
> -		sched_update_tick_dependency(rq);
> +			/*
> +			 * The rq still references the outgoing scheduling context.
> +			 * A finite slice is sufficient by itself to require the tick.
> +			 */
> +			if (tick_nohz_full_cpu(cpu_of(rq)))
> +				tick_nohz_dep_set_cpu(cpu_of(rq),
> +							TICK_DEP_BIT_SCHED);

[Severity: High]
This is a pre-existing issue, but does setting the tick dependency here lea=
ve a
persistent leak when the task exits the SCX class?

When an EXT task with a finite slice blocks or exits on a nohz_full CPU,
dequeue_task() calls sub_nr_running(), which invokes
sched_update_tick_dependency(). At that moment, __schedule() hasn't updated
rq->curr, so scx_can_stop_tick() evaluates the outgoing finite-slice EXT
task and returns false.

This leaves the tick dependency set. Subsequent transitions to non-EXT tasks
like idle or CFS do not re-evaluate or clear this dependency, meaning the t=
ick
could run persistently on a nohz_full CPU, breaking isolation.

> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706162819.6501=
55-1-arighi@nvidia.com?part=3D1
