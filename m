Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6034F371049
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303638; cv=none; b=WrYmz+YVIjYtcBbs2YbNgIHL2h9uKBjSh9a2C4d5WB8eWLnvz5nziCA5rp3+nQejR0pXVtnxbMuEvqc9ceeHkJzxa2Qbf6jjIbqVEXto5FoabSm1k9AqCVgNhD7WmvU8n2wHeYwFR9ClCqHGpxFZFn7G+VWfh6HSEnscBuUXXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303638; c=relaxed/simple;
	bh=7CI1Ye6yeFTzgVevuW+vmEL/b8zP7yAU+tGIuRyKx50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k6+AhsXLhocfx4fF/tYJPUN7Kdp89L+WIC58jq43eaguYyYyEorcnr+WG8dWiAO/mCbRnUEfdHRr5r8iAnOekxohVsGL4Dozim4VAeAjGNFoI2jxrcts8isMNSTiYnyjH51hlBxrmcNRAV5lZZJnCmWCm2NCmbx1qElcoy7c6YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wmvi+Wo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmvi+Wo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CA41F000E9;
	Mon,  6 Jul 2026 02:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303636;
	bh=kIJ9PfNq0UXn4PVyLjgzB3BcyGonN76UyV+nu2QylX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wmvi+Wo+08yHxLhZBN3H7WaO5HaLEZnJHL11JwQpP0ZknzLQfLn/rLEUR6KaPjrYq
	 2Ypn3E4hyv4TSa2qWaDFL4wzRW6LyE8PXWHToZvoVuR98SfdKdxS32Msi3HjpowTua
	 zCYDDPaOmOaY6nxpNzkLFmLIM9q2q1BJuZxuondzEZMJ1JWkshQyKrQYFLJci1RNWA
	 K9P1XkhntzFhgT059dn91LBtejGC2AxN9P5Ed3wV8cWtMCYROA7x8xbC0N13aRXmNo
	 AOb2VJVGGRSFJR7J8nsYE9IubEemPbjjjGAVQ/B6xRHySLCZRRAMRpHxeZWrK9Z4NJ
	 cfPSNzDyONlJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 28/36] sched_ext: Tie cpu occupancy
 to SCX_CAP_BASE through the task slice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-29-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-29-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:07:15 +0000
Message-Id: <20260706020716.78CA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deferred out-of-band slice requests (slice_oob) are ignored and wi=
ped when a task is dispatched or picked, leading to silent loss of the requ=
ested slice and potential soft lockups.
--

commit 567d82c10c647e4c761cbfd427050c8d3df5c896
Author: Tejun Heo <tj@kernel.org>

sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice

This commit introduces SCX_CAP_BASE logic to enforce that a task's slice
extension is only allowed when its scheduler holds baseline CPU access.
It stashes out-of-band slice requests in a new slice_oob field to be
applied later under the task's runqueue lock.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -1164,6 +1283,9 @@ static void update_curr_scx(struct rq *rq)
>  	struct task_struct *curr =3D rq->curr;
>  	s64 delta_exec;
> =20
> +	/* apply even on 0 delta_exec, callers may still act on the slice */
> +	apply_task_slice_oob(rq, curr);
> +
>  	delta_exec =3D update_curr_common(rq);

[Severity: High]
Does this logic handle tasks that are dispatched before update_curr_scx()
is called?

If a BPF scheduler requests a finite time slice for a queued task via
scx_bpf_task_set_slice() without the rq lock, the request is stashed in
slice_oob.

If the task's old slice was SCX_SLICE_INF, set_next_task_scx() will
evaluate tick dependency based on that stale slice instead of applying
the slice_oob. If SCX_RQ_CAN_STOP_TICK is set and the CPU stops the tick,
update_curr_scx() might not be called, allowing the task to run indefinitely
and ignore the finite slice request.

Could apply_task_slice_oob() be called before tick dependency is evaluated?

[ ... ]

> @@ -2965,7 +3090,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf=
, bool force_scx)
>  		if (!p)
>  			return NULL;
> =20
> -		if (unlikely(!p->scx.slice)) {
> +		if (unlikely(!p->scx.slice) && scx_task_can_stay_on_cpu(rq, p)) {
>  			struct scx_sched *sch =3D scx_task_sched(p);
> =20
>  			if (!scx_bypassing(sch, cpu_of(rq)) &&

[Severity: High]
Will this silently drop an out-of-band slice request?

When do_pick_task_scx() picks a task with an old slice of 0, it eventually
calls refill_task_slice_dfl(). That function calls set_task_slice(), which
unconditionally clears slice_oob.

Since slice_oob is cleared before the out-of-band request can be applied,
the stashed slice request is lost. Should we apply the slice_oob before
checking if the slice is 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D28
