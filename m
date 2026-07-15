Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54F43F0BC
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150498; cv=none; b=lYANl14+lWLCyuLPlTzrUIUQil4G6Xy32MRgLfkXq0zwb4WB1vf3+QLIbmkfkj2c+RviL1llngVQspRTSZR3QCw/EqWRz1ZisIQHd7+NbdaUAtxWqP8ZksLNfLKNZ0S7xvMhPMnCP7d75Fg0ztE9bt/qSqd4sNzGgLINI3jF4AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150498; c=relaxed/simple;
	bh=7XXF6dCmxk3h0KdPBfCKfTASjIOpqiHp3VOGcCCkWOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QvOT3eBNXdaxz3ppaetrePQ23cQUqpkU44uUNhxMOnAOOwbAft6tCWA1cCfPsZXZgr7lSZXC3VVkuWKxLTqIhm81PL5iWAqbxH9OpNXF7OWiwLRUQmPsWW8e0fAzZbsYsB0P6sBU21hkp9utpnpKTOASe/EBE5w5SiX9dWUHggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaNu8sGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaNu8sGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E36D1F000E9;
	Wed, 15 Jul 2026 21:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784150496;
	bh=XijBCjX5EUkje8bdp/OuCBE3ouet9TsiS/eu0O0GY+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PaNu8sGJ8TC6HdQYZUrpYs/W207iywOMvPzTvHjSGS93r5UCezVukd0tJGQm7ta4a
	 eWna878ucGK7m5h0DhEG90EVqxhyWXn3e7V26ScMkUo8SV4gFT11+ZMH85tD2Ly86t
	 fj8W4b5NoWoBqM+578p/0Et+cSylF8pt41UKyEi2E7hcJwWf8XNGShO1uygyM/A/Sk
	 p65cjq6C3GxezSE6WcQ6z7ylgv9dicblyPQEjforE18bQ4DfcHUSaLm02j0oVPEGLW
	 z84Qy77r71tvqHmi8yIHB6DlAK2Kxt8x7RlhUpo1LCNFH9VkW3JK67nFgXdPI864VA
	 Ya/BYxLdaQ6og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] sched_ext: Handle blocked donor migration with
 proxy execution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260715205622.276220-8-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
 <20260715205622.276220-8-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:21:35 +0000
Message-Id: <20260715212136.4E36D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Blocked donors are enqueued at the tail of the local DSQ, causing =
priority inversion.
- [High] Migrated blocked donors are routed to the BPF scheduler, breaking =
proxy execution visibility.
- [Medium] Spurious zero-slice warning triggered for blocked proxy donors.
--

--- Patch [7]: [PATCH 07/11] sched_ext: Handle blocked donor migration with=
 proxy execution ---
commit 9cd5cbb0243a316aab34614eb668cef59ac84d98
Author: John Stultz <jstultz@google.com>

sched_ext: Handle blocked donor migration with proxy execution

With proxy execution enabled, mutex-blocked donors stay runnable so
their scheduling context can execute the lock owner. This patch
allows normal sched_ext migration of blocked donors unless the donor
is active on its rq, and keeps blocked donors on the local DSQ when
they are put.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 0d2f34c79083f..abf99c582eee1 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -2395,6 +2395,19 @@ static bool task_can_run_on_remote_rq(struct scx_s=
ched *sch,
>  	if (task_on_cpu(task_rq(p), p))
>  		return false;
> =20
> +	/*
> +	 * A blocked donor may be moved normally to select a new callback rq.
> +	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
> +	 * callback home, even if the donor was previously proxy-migrated.
> +	 *
> +	 * Don't move an active donor while the source rq still references it f=
or
> +	 * scheduling and accounting. The migration can be retried after the do=
nor
> +	 * is switched out.
> +	 */
> +	if (p->is_blocked &&
> +	    rcu_access_pointer(task_rq(p)->donor) =3D=3D p)
> +		return false;
> +

[Severity: High]
When a blocked donor is migrated, is there a risk it gets routed to the BPF
scheduler instead of the local DSQ?

If a blocked donor is migrated via sched_setaffinity(), set_task_cpu() migr=
ates
it and calls enqueue_task_scx() -> scx_do_enqueue_task() on the destination=
 CPU.

Since there doesn't appear to be a check for p->is_blocked in the enqueue p=
ath,
the donor would be handed to the BPF scheduler's ops.enqueue callback.

Could the BPF scheduler then place the donor into a user or global DSQ,
violating the requirement that the donor remain immediately visible on the =
local
DSQ? This could cause the proxy lock owner to starve until the BPF scheduler
arbitrarily decides to dispatch the donor.

>  	/*
>  	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
>  	 * the pinned CPU in migrate_disable_switch() while @p is being switched
[ ... ]
> @@ -3081,6 +3094,22 @@ static void put_prev_task_scx(struct rq *rq, struc=
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

[Severity: High]
Does enqueuing with enq_flags =3D 0 place the blocked donor at the tail of =
the
local DSQ?

If there are other tasks already in the local DSQ (for example, dispatched =
by
the BPF scheduler), the donor won't be picked by pick_task_scx() until all
preceding tasks are drained.

Since proxy execution requires pick_next_task() to return the donor before
find_proxy_task() can run the lock owner, will this delay the lock owner's
execution and cause unbounded priority inversion?

Should this use SCX_ENQ_HEAD instead?

[Severity: Medium]
Will this trigger a spurious zero-slice warning if the blocked donor has
consumed its time slice?

When a blocked proxy donor consumes its time slice, task_tick_scx() calls
resched_curr() to preempt it. put_prev_task_scx() will place the donor here
directly into the local DSQ with p->scx.slice =3D=3D 0.

When do_pick_task_scx() later picks it via first_local_task(), will the
unlikely(!p->scx.slice) check hit and trigger the KERN_WARNING, permanently
setting sch->warned_zero_slice to true? This would break a useful diagnostic
designed to catch BPF scheduler bugs, causing unnecessary kernel log pollut=
ion
and masking legitimate zero-slice issues.

> +			goto switch_class;
> +		}
> +
>  		/*
>  		 * If @p has slice left and is being put, @p is getting
>  		 * preempted by a higher priority scheduler class or core-sched

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715205622.2762=
20-1-arighi@nvidia.com?part=3D7
