Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0626E165
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961121; cv=none; b=TeK5arWiCMUxbAXe1mHOAY3nWmZlUWEISDQvFFIgYgtcY/PK4bvgR+0+hpHyVngRJ6VM17VODxbhp9MziVMeSqGlWaSoAbWOBBMvMImk1VNmC9DosrIcq/CIqPsiMWkVrhqLT6KhUrEExzC5oUmH9x6R4E0BoImOsWQs52u6eak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961121; c=relaxed/simple;
	bh=i1yIq+NXt1DTfVqqwjAj7o1HwcO0mTX08zdt93VUfTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q5kE8txSXVOf+LbV3FVm0TaiOMbqz7AGNmfdaY9DeizmSjVDO/279/WNE8V3JvszqbzfSkL20uT6HVoNI+V4KVGM+HRUXIGaeWhgMNp+RZHhPme6LXf5N0SMJ6+csa4bcfj1+8DK7gMoSStPWEesjp0arnwg3CUThZvS4eMaMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFKK6z5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFKK6z5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2821F000E9;
	Mon, 13 Jul 2026 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783961119;
	bh=vJOpD6O5majPSmn8mnfzZlilzW+uGMxw9071OJ8JxSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZFKK6z5yFDhF2w4sT6Yy73VMei0Id+3u+j0R0u97mAWx6UCtkDh7QLstWwsXqztUn
	 GNeBXVC/AkLlKCw/oqS6hbAIWpX7v1txhRxUt/4gtTE80oMG9SUp0PfZIOCdzUoHTT
	 ZsHb/RcDKT2xrTxnOJw1uDI8LyGvu1cKRTgteMzQ7pGomN+jwOWYREVGxc06Th/IcL
	 4fJQ1dA+k3BOHjOaGcTDV0dCqFdB+zGnAHK63IFnUefQOLmXK//K+shuTsZP5DvWkV
	 mWA3gWnC7/8J0kTQArhBhua0ot93XnL5C/WfmcfJ5YM3riz/+/xfKOALvwOxlFGjdK
	 9OCMuphkEkI4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260713162112.26785-8-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
 <20260713162112.26785-8-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:45:19 +0000
Message-Id: <20260713164519.AD2821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Blocked proxy donors can bypass admission checks and transition in=
to ext_sched_class while remaining queued during PI de-boost.
--

--- Patch [7]: [PATCH 07/10] sched_ext: Delegate proxy donor admission to B=
PF schedulers ---
commit 1b08b364547eb25f8929e3f17ff8248b2a3685d6
Author: Andrea Righi <arighi@nvidia.com>

    sched_ext: Delegate proxy donor admission to BPF schedulers
   =20
    Proxy execution keeps a blocked donor runnable so its scheduling context
    can execute the mutex owner. Dispatching sched_ext donors on a local
    DSQ bypasses the BPF scheduler ordering policy and can give donors
    more CPU priority than intended to perform the proxy execution handoff.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 1f05f91e55192..6418b4d478e40 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -2887,18 +2949,12 @@ static void put_prev_task_scx(struct rq *rq, stru=
ct task_struct *p,
>  		set_task_runnable(rq, p);
> =20
>  		/*
> -		 * Mutex-blocked donors stay queued on the runqueue under proxy
> -		 * execution, but the donor never runs as itself, proxy-exec
> -		 * walks the blocked_on chain on the next __schedule() and runs
> -		 * the lock owner in its place.
> -		 *
> -		 * Put the donor on the local DSQ directly so pick_next_task()
> -		 * can still see it. find_proxy_task() will either run the chain
> -		 * owner or deactivate the donor so the wakeup path can return it
> -		 * and let BPF make a new dispatch decision once it is unblocked.
> +		 * Mutex-blocked donors only stay queued when their BPF scheduler
> +		 * enables %SCX_OPS_ENQ_BLOCKED, so always delegate their admission.
>  		 */
>  		if (p->is_blocked) {
> -			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
> +			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));

[Severity: High]
Can a blocked proxy donor bypass admission checks and transition into
ext_sched_class while remaining queued during a PI de-boost?

If a task whose normal policy is SCHED_EXT acquires a mutex and is boosted
to RT priority via rt_mutex_setprio() (because a higher-priority RT task
blocked on it), it might subsequently block on a second mutex, becoming a
blocked donor.

When the higher-priority task gives up the first mutex or is killed, the
donor is de-boosted. In rt_mutex_setprio(), the task's policy is set back
to SCHED_EXT:

kernel/sched/core.c:rt_mutex_setprio() {
    ...
	prev_class =3D p->sched_class;
	next_class =3D __setscheduler_class(p->policy, prio);

	if (prev_class !=3D next_class)
		queue_flag |=3D DEQUEUE_CLASS;

	scoped_guard (sched_change, p, queue_flag) {
    ...
}

Because this doesn't invoke scx_prepare_setscheduler() or
sched_proxy_block_task(), wouldn't the blocked task remain queued on the
runqueue? This could pass the blocked task to a BPF scheduler that does
not have SCX_OPS_ENQ_BLOCKED enabled, triggering this WARN_ON_ONCE.

> +			scx_do_enqueue_task(rq, p, 0, -1);
>  			goto switch_class;
>  		}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713162112.2678=
5-1-arighi@nvidia.com?part=3D7
