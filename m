Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69DB3C1F59
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150097; cv=none; b=omusFaWH0PkWv+pyEMPQNMbemX4EQUUzbRB4pEu7uI8skYm49ObZPuNxslP5bMv9hkd5Z920iyof/x4Z9ewOP9Kfwyq5wAImaEIf1JqKJcPPmL3Aq0OqwsG2YFxh7ebvRHNxyGhUg6voSI7KfqrnKsB6FDCdvIJJpPFY+Z1eISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150097; c=relaxed/simple;
	bh=oRjdUeTy9Bk1PMFFdIcbx2Y/USw+VfGlkLtXzn9VDOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W2Yw1qllzUIuFpgNUQbPNooO0kwLrdMqIKLd7NXjNWM1gRxtYx6v1wfvl9wwarste+/q4tfrG8Bbia3m2cqdgJ0rWHjhUERLITBrFC7775Ns5MrBm4ad3BITqxe9VZNhpDAbCUKZAmU5vNmGOAfrshWR3M9GSKAXGIQ2TmvO/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYqxSPDd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYqxSPDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981AF1F000E9;
	Wed, 15 Jul 2026 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784150095;
	bh=CV25sk46wzcwUhPsMwUdRsVWcoJDLeIplllKNx99FYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LYqxSPDdG5drwKbU6GWO3LlZ6yW0GQr6cX4FHQFvUfUj9BnR3YV1KjUs71xnqrk4E
	 wGA0oWEQLznagYpq+Aosjqp3LiZVOe0tD+SzCAIqLtpPIczY0X+T2n3JLkkTuKGPyB
	 xN6T6Ar1TjwS0fx9vWgSCYc4+xFaaGS6qqmq9WjLF0DHRJcgB5qODEgeBO1aHzMqiW
	 chh4IijerKM/jxayJZYzPO15jnV5Ot/M2uBM6VH8bL+DAKDAnwCiRVbqrKAEPHv+PW
	 lR65gbgvuTcqLnQoK+NjIDaTSN8fKHa7BvkUrV6nXI5O20ACOQeWxEY6lxORsY33VR
	 FyRlQx0va3pMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] sched_ext: Fix TOCTOU race in
 consume_remote_task()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260715205622.276220-6-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
 <20260715205622.276220-6-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:14:55 +0000
Message-Id: <20260715211455.981AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Lost wakeup / scheduler stall when a task is skipped during DSQ co=
nsumption.
- [High] List corruption and state machine violation due to enqueuing an ac=
tively executing task to the global DSQ.
--

--- Patch [5]: [PATCH 05/11] sched_ext: Fix TOCTOU race in consume_remote_t=
ask() ---
commit b2d369cbc11d2586ba8175f09e54ae5417c87ff8
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Fix TOCTOU race in consume_remote_task()

This commit addresses a TOCTOU race when migrating a task during DSQ
consumption. It re-evaluates task_can_run_on_remote_rq() after locking the
source runqueue and falls back to enqueuing the task on the global DSQ if
the task is no longer eligible to migrate.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 04fc34a7ded65..8d8057b80d544 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -2382,6 +2384,10 @@ static bool task_can_run_on_remote_rq(struct scx_s=
ched *sch,
> =20
>  	WARN_ON_ONCE(task_cpu(p) =3D=3D cpu);
> =20
> +	/* Don't migrate a task which is running on a CPU. */
> +	if (task_on_cpu(task_rq(p), p))
> +		return false;
> +

[Severity: High]
Could returning false here cause a lost wakeup or scheduler stall?

When a task is preempted and enqueued to a non-local DSQ, an idle CPU might
attempt to consume it from scx_consume_dispatch_q() before the previous CPU
completes finish_task_switch() (which clears p->on_cpu).

Since scx_consume_dispatch_q() evaluates task_can_run_on_remote_rq()
locklessly, it would return false, causing the consuming CPU to skip the
task and potentially go back to sleep. Once the previous CPU finally clears
p->on_cpu, is there a mechanism to generate a new kick, or will the task
remain stranded on the dispatch queue indefinitely?

>  	/*
>  	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
>  	 * the pinned CPU in migrate_disable_switch() while @p is being switched

[ ... ]

> @@ -2480,6 +2486,27 @@ static bool consume_remote_task(struct scx_sched *=
sch, struct rq *this_rq,
>  				struct scx_dispatch_q *dsq, struct rq *src_rq)
>  {
>  	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
> +		/*
> +		 * Eligibility may have changed while switching rq locks. This is a
> +		 * kernel-side race, not an invalid BPF placement request, so don't
> +		 * abort the scheduler on failure. Fall back to the global DSQ, where
> +		 * normal consumption filters can select an eligible CPU without
> +		 * forcing the task onto the source local DSQ.
> +		 */
> +		if (unlikely(!task_can_run_on_remote_rq(sch, p, this_rq, false))) {
> +			p->scx.dsq =3D NULL;
> +			p->scx.holding_cpu =3D -1;
> +			scx_dispatch_enqueue(sch, src_rq,
> +					     find_global_dsq(sch, task_cpu(p)), p,
> +					     enq_flags | SCX_ENQ_CLEAR_OPSS |
> +					     SCX_ENQ_GDSQ_FALLBACK);

[Severity: High]
Can this fallback path lead to list corruption if the task is actively
executing?

If a donor task in a DSQ becomes active (task_on_cpu() is true) during proxy
execution, the re-evaluation of task_can_run_on_remote_rq() correctly detec=
ts
it as executing and returns false.

However, this fallback path will then clear p->scx.dsq and unconditionally
enqueue the actively executing task to the global DSQ. When the task is lat=
er
preempted, put_prev_task_scx() will attempt to enqueue it again, which seems
like it would trigger the WARN_ON_ONCE(p->scx.dsq || !list_empty(...)) and
corrupt the DSQ list.

> +			if (sched_class_above(p->sched_class,
> +					      src_rq->donor->sched_class))
> +				resched_curr(src_rq);
> +			switch_rq_lock(src_rq, this_rq);
> +			return false;
> +		}
> +
>  		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
>  		return true;
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715205622.2762=
20-1-arighi@nvidia.com?part=3D5
