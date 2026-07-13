Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351FF43800C
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961289; cv=none; b=IXtYL4x4yU9I89ppiKcJUIqltcc+oq64VXDvOnPhPsIa6cVrJi7qRpcdbGp7QzUgJb30bvlMiEfmgzyVuVzqSVmkWqm//+mJUGLfNI4IjfS9eL6vXLL47/iAqS/NI6eh9Q4/FJUizCVWrLLjwzdzUBIzHKXIIZajE9CWtT561IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961289; c=relaxed/simple;
	bh=c+xhZJEE+cNisiO22oufonGdU37GYRoBCtwQzJREK+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lqYiij6hf2Y6tFWHoEWd79R29BszIjfHxkDJyuDsOV+kjneQTAq3u+pMJQpjFg3sdRX428tuVrXOsf8mC/ByEkCl7l3RjcSTtY5/hdCNw/1VjyaRPg0id5nFGsnZbnGclVHPLyUeXTQPaXDmmII/CO0/ufcRbEFHV/zls0FVIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhAVMnGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhAVMnGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5ED21F00A3A;
	Mon, 13 Jul 2026 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783961288;
	bh=r/Ydl/IRwIDgHBu9z34mTEdPmTGC1/Cacgl0MZUtD2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OhAVMnGFfnqbmVy2GGIOkFeGbcoYdxd0zRzciSftnAU9doAfVYRjeWqsxIt4P6jPr
	 BNIMQN49z4Y69O3/o04TbTUpb4IpADrOOOU8Nz8rQNMX30E4SOWuHtMPJyTgTbH7h8
	 JJf4XOEM+N1I19vbBHXPMu3jSIxbYpoMBjKcQVpkoGydgx1Zhxc8APM/Xy6LhWPvGT
	 OBINKDCO/uGXqgyTn4GI2/rT7W0wUfO4lIiizS5gn87N0t5a3MvwnI+iGq5KVb/rtC
	 s4/Gjw6lrhhmSgv6ooTE5wpHuzWJdq1s8a3dzjlYmC2hmWN2x0aNrNBDqP0MxYR7UM
	 3cxtyysF+ePsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] sched_ext: Split curr|donor references properly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260713162112.26785-5-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
 <20260713162112.26785-5-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:48:06 +0000
Message-Id: <20260713164807.E5ED21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Missing conversion from `task_current()` to `task_current_donor()`=
 in sched_ext task state management skips BPF callbacks and corrupts task s=
tate.
- [High] BPF kfuncs expose the physical execution context instead of the sc=
heduling context, violating the commit's design principle.
- [High] `dequeue_task_scx` unconditionally calls `update_curr_scx`, which =
steals execution time from non-EXT proxy donors and corrupts their accounti=
ng.
- [High] scx_can_stop_tick() stops the tick for FAIR donors executing via E=
XT owners, bypassing CFS bandwidth constraints.
--

--- Patch [4]: [PATCH 04/10] sched_ext: Split curr|donor references properl=
y ---
commit ed60d9105c70ea6983b5253a3067b0440935ec2f
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Split curr|donor references properly

With proxy execution, the task selected by the scheduler and the task
physically executing can differ. A blocked mutex waiter donates its
scheduling context to the lock owner.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 1412239d37f52..755ea5cc6169f 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1170,17 +1170,24 @@ static void touch_core_sched_dispatch(struct rq *=
rq, struct task_struct *p)
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

[Severity: High]
Does this steal execution time from non-EXT proxy donors?

If an EXT task executes on behalf of a FAIR donor, dequeuing the EXT owner
calls update_curr_scx() from dequeue_task_scx() because it evaluates
task_current(rq, p) which matches the EXT owner.

This code advances rq->donor->se.exec_start via update_curr_common() and
mutates the non-EXT donor's slice. Will this bypass CFS vruntime and
bandwidth (throttling) accounting, starving the FAIR task of its tracked
CPU time?

[ ... ]

> @@ -4081,14 +4092,14 @@ static void run_deferred(struct rq *rq)
>  #ifdef CONFIG_NO_HZ_FULL
>  bool scx_can_stop_tick(struct rq *rq)
>  {
> -	struct task_struct *p =3D rq->curr;
> +	struct task_struct *p =3D rq->donor;
>  	struct scx_sched *sch =3D scx_task_sched(p);
> =20
>  	if (p->sched_class !=3D &ext_sched_class)
>  		return true;

[Severity: High]
Does this incorrectly bypass CFS bandwidth constraints for FAIR donors?

If a CPU is running a bandwidth-constrained FAIR donor through an EXT owner
on a NOHZ CPU, this returns true.

This delegates tick responsibility to core generic checks, which mistakenly
evaluate the EXT owner (rq->curr) instead of the FAIR donor in
__need_bw_check. Can this allow the FAIR task to bypass CFS quota limits?

[ ... ]

[Severity: High]
Are we missing conversions from task_current() to checking the donor in the
enqueue and dequeue paths?

In dequeue_task_scx(), if we have a blocked EXT proxy donor task (where
rq->donor =3D=3D p but rq->curr !=3D p) that is dequeued, task_current(rq, =
p)
evaluates to false:

    if (task_current(rq, p) &&
        (p->scx.flags & SCX_TASK_RUN_TRACKED)) {

Does this incorrectly skip the BPF stopping() callback and leak the
SCX_TASK_RUN_TRACKED state?

Similarly, in enqueue_task_scx():

    if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p))
        sticky_cpu =3D cpu_of(rq);

Does this fail to preserve sticky_cpu for an actively running donor because
task_current(rq, p) is false, breaking the restore invariants?

[Severity: High]
Do the BPF kfuncs expose the physical execution context instead of the
scheduling context?

In scx_bpf_task_running():

    return task_rq(p)->curr =3D=3D p;

This returns false for an active EXT donor because it checks the owner
(rq->curr) instead of the donor.

In scx_bpf_cpu_curr():

    return rcu_dereference(cpu_rq(cpu)->curr);

And in scx_bpf_cid_curr():

    return rcu_dereference(cpu_rq(cpu)->curr);

Do these expose the physical non-EXT owner to the BPF scheduler instead
of the expected EXT donor, causing the BPF scheduler to make incorrect
load-balancing decisions based on invalid task states?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713162112.2678=
5-1-arighi@nvidia.com?part=3D4
