Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C073BBFAB
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623330; cv=none; b=LDjA71Yjy9mTrDSKvlPU5wzpH62s+UU7Y48t+gBUHpKdoHbY/QKo5BAyrG+5d7KwvrUXBVxlCFNEhjmYdpEIRTzXc4fXFGNNuSHaspSdgRw+zIbeQ96lUDFVlU65d5nYtiX6qiAxmQb6bmB8b4HmWKn7kK4nEdCr022akbZrvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623330; c=relaxed/simple;
	bh=j2xM6zZ4ujW50pjFkbFnHICXgSPKXgWCFwMkPs224Jk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r4UeBa/B2gqbUuViSXgssk/aWnIGEY0AZFQiTg+fFSUwX/9RgCdhHjVeeFHgHBCqGTrBWD43Sy3AXT5aYEQakKEyOBZG4nxIpGh2aI2DWCYzvuDmcmSBGIzZBorKDy348jS6capQ49JY1TjS+cZH9oYt9OirlFcavzXcjpbZeeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drcrHEBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drcrHEBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B751F000E9;
	Tue, 21 Jul 2026 08:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784623328;
	bh=m5552/a78XE6Po4yI2Ezsk3meCi2d6ekeQVmNsY2toQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=drcrHEBgziARRvuzbYUHrKg3ByzYLAKKvBkX65WZ9RHCJOS7jOKWYIocZulJQEBjj
	 ms3jntsg844cTlhM1Iuz8RUXaheccHYw/M5/ybZyrBTKnb1ZaUgGZUotazHSnABiQj
	 ak/4SDVeyJuENEf6nwHad+OOiIo6J/7dTH3+/G2becmEPX6DlzPGz/26hQGRakXN41
	 +bM392T1C5ToiYEuy+GFAumg5+SMFmo81dTFeB0yFjXuODFxOD1gvW7dv6cmersUkc
	 PKacyQWc6rdvFQy9EMbv7LiNQVaZqCbDsNqHxxeNlyCfjHDLr4h0UuqCZYNLBt5ty2
	 UUI4mKuI83KDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] sched_ext: Handle blocked donor migration with
 proxy execution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260721063242.552774-9-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
 <20260721063242.552774-9-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:42:08 +0000
Message-Id: <20260721084208.C1B751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The newly added proxy-execution handling for blocked donors in put=
_prev_task_scx() is unreachable for sched_ext tasks, completely breaking pr=
oxy execution for this class.
- [Medium] Blocked proxy donors are enqueued to the tail of the local DSQ i=
nstead of the head, causing priority inversion when other tasks are batched.
--

--- Patch [8]: [PATCH 08/12] sched_ext: Handle blocked donor migration with=
 proxy execution ---
commit 6380b59c7e35fb635b7bc11e5fa121a8296ed2b7
Author: John Stultz <jstultz@google.com>

sched_ext: Handle blocked donor migration with proxy execution

With proxy execution enabled, mutex-blocked donors stay runnable so
their scheduling context can execute the lock owner.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index a466adf8e1548..bf53f2be77f05 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -3122,6 +3126,25 @@ static void put_prev_task_scx(struct rq *rq, struc=
t task_struct *p,
>  	if (p->scx.flags & SCX_TASK_QUEUED) {
>  		set_task_runnable(rq, p);
> =20
> +		/*
> +		 * Mutex-blocked donors stay queued on the runqueue under proxy
> +		 * execution, but the donor never runs as itself, proxy-exec
> +		 * walks the blocked_on chain on the next __schedule() and runs
> +		 * the lock owner in its place.
> +		 *
> +		 * Put the donor on the local DSQ directly so pick_next_task()
> +		 * can still see it. find_proxy_task() will either run the chain
> +		 * owner or deactivate the donor so the wakeup path can return it
> +		 * and let BPF make a new dispatch decision once it is unblocked.
> +		 *
> +		 * This is preparatory code: a later patch will delegate blocked-donor
> +		 * admission to the BPF scheduler.
> +		 */
> +		if (p->is_blocked) {
> +			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);

[Severity: High]
Is this newly added proxy execution handling for blocked donors reachable f=
or
sched_ext tasks?

When a sched_ext task blocks on a mutex, try_to_block_task() checks
!task_is_blocked(prev) || !scx_allow_proxy_exec(prev) to decide if it
should be fully dequeued. scx_allow_proxy_exec() unconditionally returns
false for ext_sched_class:

kernel/sched/ext/ext.c:scx_allow_proxy_exec() {
        return p->sched_class !=3D &ext_sched_class;
}

Since should_block evaluates to true, the task is passed to block_task(),
which unconditionally dequeues it via dequeue_task_scx(). Dequeuing clears
SCX_TASK_QUEUED.

When put_prev_task_scx() is then called by __schedule() during the task
switch, the task is no longer queued (p->scx.flags & SCX_TASK_QUEUED is
false), meaning this entire block of newly added proxy donor retention
logic seems to be bypassed as dead code.

[Severity: Medium]
Will enqueuing the blocked proxy donor to the tail of the local DSQ cause a
priority inversion?

If the BPF scheduler has previously dispatched a batch of tasks to the local
DSQ, using 0 (tail enqueue) places the blocked donor behind them.
pick_next_task() will pop and execute the batched tasks before the donor,
delaying the execution of the lock owner.

Should this use SCX_ENQ_HEAD instead, similar to slice-preempted tasks, so
the lock owner can execute immediately to release the contended mutex?

> +			goto switch_class;
> +		}
> +
>  		/*
>  		 * If @p has slice left and is being put, @p is getting
>  		 * preempted by a higher priority scheduler class or core-sched

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721063242.5527=
74-1-arighi@nvidia.com?part=3D8
