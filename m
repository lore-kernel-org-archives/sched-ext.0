Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6429F33B6CB
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215349; cv=none; b=C5NE6prRRaHdJAVG/UhFLLkrQG4vuRuqwZnLkg2fGZhy2NFo/wmBPaJOjrlpOM36uXpMuL7J5CfwHvmrUYRxMTDGdHZTFCybYnTCVG31/PT1nAhVzeS878PJqAD6i36TKr+OLwkv2ZSCalWEVcu5EKWWU1XE88g577ezAVeLQvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215349; c=relaxed/simple;
	bh=9fv3tzbc5zrbsBPMbukldF4CL4yLDlC3+zPw58499WQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XukVG3sNCpNe/8iI+rjnc3V+acyo/bljqpkMjU9ODFt7Bqe+1hZHZbcEDKt8ZaBFUfmyHhJiVUSrqHMKd5+9W8MUkBpFPYhI4/oVikHle0yeqFFK+x2Yow0fvncYYCHQ3ppqbfpOm6xdASzB1gRPygGwSbaKcXpOtWlfhx9nXfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYPSR92/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYPSR92/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE631F000E9;
	Thu, 16 Jul 2026 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215348;
	bh=vpUypAIMY5iOVgCV+ibxs6D8oGTPsfWn9un/W6eYrdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYPSR92/osMVnurSn9/uWle0vWXwSi0MP9940KQ42DKfX70HwXYDqIkY94ertjoYc
	 AG7BQa5MJ62exXV49Y6maglORgCSVWjrfd+lSWahe0Eyxaqh8AFUPQNpML+khjxDqm
	 iWmOC1ez65k7czZ5zdAb0tUUtjx3ks066IeNTuBAIPAgIMWGrltXtm2zu78lXgf8+C
	 NFwcRCO9CQcv9FZ82Vk3z+58i2CE4u+YM5PvG2qZVP09Gl4NoDNa3qMtGJEyHzOjR4
	 gIxPNGlJ9bbgDSbTFSwWRRc5TZDyCzP21ltEWGul0Vts6Xuj1GxQ72TRoOJys3k4k+
	 1ZiJMpRbGjcgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] sched_ext: Handle blocked donor migration with
 proxy execution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260716132229.61603-8-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-8-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:22:27 +0000
Message-Id: <20260716152227.DBE631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Woken proxy donors can be migrated while still referenced by `rq->=
donor`, causing data corruption.
- [High] Blocked proxy donors are enqueued to the tail of the local DSQ, de=
feating priority inheritance and bypassing SCX_ENQ_HEAD for preempted tasks=
 with remaining slice.
--

--- Patch [7]: [PATCH 07/11] sched_ext: Handle blocked donor migration with=
 proxy execution ---
commit e2d80964c94aa96c6517c0aa914235417a9eb814
Author: John Stultz <jstultz@google.com>

sched_ext: Handle blocked donor migration with proxy execution

With proxy execution enabled, mutex-blocked donors stay runnable so their
scheduling context can execute the lock owner. This patch ensures that
active donors are not migrated by the BPF scheduler while the source
runqueue still references them. It also keeps blocked donors on the local
dispatch queue when they are put so they remain visible to the proxy pick
path.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 4af2a7a651b9f..92ab74547b693 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2443,6 +2443,10 @@ static bool task_can_move_from_locked_rq(struct sc=
x_sched *sch,
>  	if (task_on_cpu(src_rq, p))
>  		return false;
> =20
> +	/* Don't move a donor while its source rq still references it. */
> +	if (p->is_blocked && rcu_access_pointer(src_rq->donor) =3D=3D p)
> +		return false;
> +

[Severity: High]
Does checking p->is_blocked here leave a race window where the task can be
migrated while still referenced by src_rq->donor?

If the mutex is unlocked, waking up the donor task clears its blocked state
via ttwu_do_wakeup(). If the lock owner is still running and src_rq hasn't
rescheduled yet, src_rq->donor will still point to the task.

When the BPF scheduler picks the task for migration, this check might
erroneously pass because p->is_blocked is now 0. If the task is transferred
to dst_rq, a subsequent update_curr_scx() could modify p->scx.slice while
holding src_rq's lock, racing with dst_rq which now owns the task.

Should this only check rcu_access_pointer(src_rq->donor) =3D=3D p to prevent
the race?

>  	return task_can_run_on_remote_rq(sch, p, dst_rq, enforce);
>  }

[ ... ]

> @@ -3092,6 +3096,22 @@ static void put_prev_task_scx(struct rq *rq, struc=
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
> +		 */
> +		if (p->is_blocked) {
> +			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
> +			goto switch_class;
> +		}
> +

[Severity: High]
Does passing 0 as the enqueue flag here put the blocked donor at the tail
of the local DSQ instead of the head?

When a lock owner running on behalf of a blocked donor is preempted, this
code unconditionally uses 0 and skips the remaining slice check via the
goto. Enqueuing with flag 0 places the donor at the tail of the built-in
FIFO local DSQ instead of the head (SCX_ENQ_HEAD).

Could this cause priority inversion, as any tasks previously dispatched to
the local DSQ would run before the lock owner can resume, even if the
preempted donor still has slice remaining?

>  		/*
>  		 * If @p has slice left and is being put, @p is getting

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132229.6160=
3-1-arighi@nvidia.com?part=3D7
