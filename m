Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6FD35AC13
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376128; cv=none; b=Hr8UWhKqaKnrAvlBdkVPnpp0+imevXXY4JDjg544ABnudREXh09MwQfNeg/9V8ebva4QkptKx7ETRWF9sEaHBbNdr8RlKkua7lVbIavIxLzim6mdp980M2A35AlOljgocIcKWW1Ljh5rZj/UdGpNakpXU/RQF7mqmVldz3uAcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376128; c=relaxed/simple;
	bh=sC1zCjtCdGqDJ2HJ6lHn2ERhUPZwGas5gCMVb4LvWas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pG/GVJXT39Tbw0EfD9Gg3vDtq6/5I7ge7yrfHLRVnq1v+25L+BAPikBXMRN3FnfJ8JuV2iwbGCSFUwofrUQpCVZnqupyR+DVzSrSxziAMRTT1Te+B6EMzAS3Q5kHdTDT3SSOp6sxp+K2UUJ0NlD5vb5YGZmBaxPr9vteW0LDVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJWLBe/w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJWLBe/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E911F000E9;
	Mon, 10 Aug 2026 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786376126;
	bh=r5Tq7oA8BTjSF+5bcy8TVMJ6PohNRczDzjYkBMCsYWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mJWLBe/wodeo1HpiNXTw8dtZ8ReWla0YcIo836hT1MFZm80U1OqG9+9rL4OzIhEn0
	 RxnycrhCak9E7p74GGggTJNR1VjNT7KAt4hQwQ5/WaQ9TjeRJ1ockxb1j7kd/jjKAn
	 eJMu4Ol8eMGAdUfVrQO9JfLS8Ch5XOw9AuSbE8DHcqVmdfNo4jKXkooxt0TXmN0lIm
	 Did0jmpWKEV/kJiMDsxU5+e1X5qxvuEbSRvZaaIg7RlFlmLQRUJDvxOZvCeC/lIkJT
	 VyP7ozfa9mdDLkNWyVMj4sQhWK5J0QvlIEMjIASQx81zKT0nJvx+DqjMR1chNFsmxk
	 baHsjYjvdSWaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/15] sched: Make NOHZ CFS bandwidth checks follow
 proxy donor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260810151523.86994-2-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
 <20260810151523.86994-2-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 15:35:25 +0000
Message-Id: <20260810153526.95E911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] NOHZ_FULL isolation is broken for RT tasks that preempt a constrai=
ned FAIR task because the tick dependency is erroneously kept active.
--

--- Patch [1]: [PATCH 01/15] sched: Make NOHZ CFS bandwidth checks follow p=
roxy donor ---
commit 4ed25113b5b2751dc0d63ef337fd5d561e7a7554
Author: Andrea Righi <arighi@nvidia.com>

sched: Make NOHZ CFS bandwidth checks follow proxy donor

This commit updates the NOHZ CFS bandwidth checks to evaluate the proxy
donor rather than the physical execution context. This ensures that a
retained proxy donor correctly enforces bandwidth accounting even when
the lock owner is queued in another scheduling class.

Link: https://lore.kernel.org/r/20260713164807.E5ED21F00A3A@smtp.kernel.org

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0697ed0f1c3d2..6e835d2780cfd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c

[ ... ]

> @@ -1431,6 +1428,14 @@ bool sched_can_stop_tick(struct rq *rq)
>  	if (rq->dl.dl_nr_running)
>  		return false;
> =20
> +	/*
> +	 * The selected scheduling context can be a constrained FAIR donor even
> +	 * when rq->curr is an RT task. Check it before the RT fast paths below,
> +	 * which may report that the tick can stop for a throttled RT context.
> +	 */
> +	if (__need_bw_check(rq->donor) && cfs_task_bw_constrained(rq->donor))
> +		return false;
> +

[Severity: High]
Does evaluating rq->donor here during enqueue cause an issue when an RT task
wakes up on a NOHZ_FULL CPU that is currently running a bandwidth-constrain=
ed
FAIR task?

During the RT task wakeup, the enqueue path reaches this check before the
context switch:

enqueue_task_rt() -> add_nr_running() -> sched_update_tick_dependency() ->
sched_can_stop_tick()

At this point, rq->donor has not yet been updated and still points to the
currently running FAIR task. This causes the check to return false, which
keeps the TICK_DEP_BIT_SCHED dependency set.

After the context switch to the RT task, rq->donor is updated, but
sched_update_tick_dependency() is not called again on context switch, and
set_next_task_rt() does not actively clear the tick dependency.

Could this cause the incoming RT task to run with the timer tick erroneously
enabled, breaking NOHZ_FULL isolation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810151523.8699=
4-1-arighi@nvidia.com?part=3D1
