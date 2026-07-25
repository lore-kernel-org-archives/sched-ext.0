Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F237E5D6
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784996802; cv=none; b=flOmYcwar7RFoYCtRXl3KBpqV2SyYqGDGErxHbT6hLHrswOUKK+TSH42F8WzWyjeqdQJTZyJeju0iElAqvX7NF/vr3mYV+z4tIpxZv1RAxXKx1h945wJN7nLQ0nPtNhZjmJhMm1y3spzv6gvNQ4CqUWTvrJ2vEEwh3EZc9UW0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784996802; c=relaxed/simple;
	bh=6izCjpIV/hq50sFzMrSeEY02A3luSYBw4eiH/NurCWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xew2DOzqb+x/WWtLVrsmEnI/p5yEqXogq0g+PCzdEX39Siy7Vr7UL8/I23YBKKyJF/S7+vBVc/0Atub1A0W7jXxthwrBSdWLvN8G18+oXxlcPW+nS/UANzrsCh1BuDMX/xeGniauscgOqO0yCnuFgOvkD4f649RHP6kr6dR9/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXH/bcMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXH/bcMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CE51F000E9;
	Sat, 25 Jul 2026 16:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784996800;
	bh=ZWBpcfwDxm/fjp8Kk9Z/Cc0L24kImYLljcxfVZdlw2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXH/bcMaHgGkdQcnDnjFcs8DgTieFr+7mmkjSuMn92S1r1YIl1iTFBQizcQUtk8gA
	 fsPyIa/51Jzyv8hViLAJhLn1AWg+LVFvi6SCp6BbARnEwA4BSGOAZiaCgHNYRtuFtN
	 Ry2h2DNvUNUB7u2VsKk5cgqgFFTib4MSZg0v80hldMSESdHeO2WghFjFar9iV0jbnT
	 2OrNQ9ZKNnYXzMGiCNoQMrxpAwV3uBkAKntERUXzF/w6dLCVELSX6N/kR5oJ3dpQgd
	 WsPBPWfzQ2UCfV9EVxFIV+PPb25iLWp/urKEfcEbonqfVzIB9xlNneAWpTXDr2CKav
	 WyUwHYmCxTeaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/14] sched: Make NOHZ CFS bandwidth checks follow
 proxy donor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260725160513.57477-3-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
 <20260725160513.57477-3-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 16:26:39 +0000
Message-Id: <20260725162640.36CE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The newly added donor bandwidth check in `sched_can_stop_tick()` i=
s bypassed by early returns when a FAIR donor delegates execution to a thro=
ttled RT task.
--

--- Patch [2]: [PATCH 02/14] sched: Make NOHZ CFS bandwidth checks follow p=
roxy donor ---
commit 18e332090abc5adb7229eaf795a740846b882ae9
Author: Andrea Righi <arighi@nvidia.com>

sched: Make NOHZ CFS bandwidth checks follow proxy donor

This commit modifies sched_can_stop_tick() and sched_fair_update_stop_tick()
to check the CFS bandwidth constraints of the selected donor scheduling con=
text
rather than the physical execution context. This prevents constrained FAIR
donors from evading bandwidth enforcement during proxy execution.

Link: https://lore.kernel.org/r/20260713164807.E5ED21F00A3A@smtp.kernel.org

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f38332274f8fe..ef0563970d412 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c

[ ... ]

> @@ -1462,14 +1459,17 @@ bool sched_can_stop_tick(struct rq *rq)
>  		return false;
> =20
>  	/*
> -	 * If there is one task and it has CFS runtime bandwidth constraints
> -	 * and it's on the cpu now we don't want to stop the tick.
> +	 * If the selected scheduling context has CFS runtime bandwidth
> +	 * constraints, don't stop the tick. With proxy execution, rq->donor is
> +	 * the selected scheduling context while rq->curr is the task physically
> +	 * executing on its behalf.
> +	 *
>  	 * This check prevents clearing the bit if a newly enqueued task here is
> -	 * dequeued by migrating while the constrained task continues to run.
> +	 * dequeued by migrating while the constrained donor continues to run.
>  	 * E.g. going from 2->1 without going through pick_next_task().
>  	 */
> -	if (__need_bw_check(rq, rq->curr)) {
> -		if (cfs_task_bw_constrained(rq->curr))
> +	if (__need_bw_check(rq->donor)) {
> +		if (cfs_task_bw_constrained(rq->donor))
>  			return false;
>  	}

[Severity: High]
This is a pre-existing issue, but does this placement still allow a CFS
bandwidth-constrained FAIR task to evade its quota if it donates its context
to a throttled RT task?

If a FAIR task with CFS bandwidth constraints blocks on a mutex held by an
RT task, and the RT task exceeds its global RT runtime (becoming throttled),
the RT task's own context becomes ineligible. Proxy execution would then
select the FAIR donor's scheduling context (rq->donor), while the RT task
serves as the execution context (rq->curr).

During global RT throttling, dequeue_top_rt_rq() unsets rt_queued but does
not decrement rt_nr_running, leaving rq->rt.rt_nr_running > 0.

Because sched_can_stop_tick() has early checks for RT tasks (which can
return true when fifo_nr_running > 0), wouldn't the function return early
and completely bypass this newly added __need_bw_check(rq->donor) logic at
the bottom of the function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725160513.5747=
7-1-arighi@nvidia.com?part=3D2
