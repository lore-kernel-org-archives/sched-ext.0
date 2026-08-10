Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB6360EC5
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377881; cv=none; b=gw/r3GrkDooS2UOt0m1wJvcowmT13wchHOTUYFdPgm7jd4YB8LLPV9FyFuK/Tr5mRoIsimMvEIkZ9YxXzMx/0Grj4wOWrE5XbwIXnEiO6u/BdSzYIV0f78HO/u2anCaj7F6oCEeiB1u3HM1wjRFQCDtCfv2ku44Na3MwP60X+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377881; c=relaxed/simple;
	bh=WlJZK1egBXbgAJQKxuZXidYiy88GMXSsYu6CDmC507A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cj3FmmVYcnh+RofkI5OLEIvZv906Jd7G0K2Ae/V8pbx4Ps0Kegp6DhLiFJrtFkVRIPQIa8uJRGXYizrkWTMrp3VB1ywRE6TBH51BB8weZiA113v0zRd7MzhWSo9WhmbJ0r092Wl6rkDLA1rascfVGvkQ4lXWdpDkee6SigqQHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+8+ysNk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+8+ysNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4341F000E9;
	Mon, 10 Aug 2026 16:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786377879;
	bh=g9tIClDR4O6mLWAJyfl7Hbe25rtCrvHUoHsF+fGnW7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P+8+ysNkGhNUb+Lqf4aEGUCqHTACw+X35EWt218/j58tesz3pYp7W8XKtQLil5RoR
	 qzh9wx5G4+AXbHRyU8KmOidWq/N8JDbUmi+DkM00u8dwFmggGuQ9xtQ67I212s/eTI
	 dI5tSMPcGutcWt0CKKCPC+6l5z5vNv3zH0foE80PK4Db0rac0tEY42urTo9FRO5FBc
	 hXarIe5768tCkgbyw89z5j7vg0hxGYaFwmeN/582wcL1P+qpldtbvwVrUjxolR706f
	 o0w5VPzL5Y/Orq1r+uFioWArOZ2Lm6VmKQ4FG+iypNWwQ2noQfxIxsaXakpsqGKupM
	 0rQfBT9vaOCcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] sched_ext: Handle proxy-exec races in remote DSQ
 transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260810151523.86994-11-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
 <20260810151523.86994-11-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 16:04:38 +0000
Message-Id: <20260810160439.3B4341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Tasks can be permanently starved because migration-disabled state =
is conflated with active proxy execution, bypassing deferred work and BPF s=
cheduler failsafes.
--

--- Patch [10]: [PATCH 10/15] sched_ext: Handle proxy-exec races in remote =
DSQ transfers ---
commit 4a7a0caa08e0bdff136179deb5a687b13392995f
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Handle proxy-exec races in remote DSQ transfers

This commit handles proxy execution races during remote DSQ transfers
by re-evaluating task execution and migration-disabled states under the
source rq lock. Tasks that can no longer proceed are parked on the
source rq's reject DSQ to be re-enqueued later, maintaining placement
policies.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index b43b2834141e6..7b467b666212b 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -2573,6 +2585,60 @@ static bool task_can_run_on_remote_rq(struct scx_s=
ched *sch,
>  	return true;
>  }
> =20
> +/*
> + * Proxy execution can change @p's execution and migration-disabled state
> + * without touching its DSQ entry or clearing holding_cpu. Check those s=
tates
> + * with @p's rq locked. Without proxy execution, the holding_cpu handsha=
ke is
> + * sufficient and this must not affect the existing migration path.
> + *
> + * A BPF-directed transfer to a remote local DSQ performs a normal task
> + * migration and thus cannot move a migration-disabled task. In contrast,
> + * proxy_migrate_task() moves only a blocked donor's scheduling context =
towards
> + * the mutex owner and preserves its execution home in wake_cpu. The lat=
ter is
> + * therefore allowed even when the donor is migration-disabled.
> + */
> +static bool task_move_proxy_raced(struct task_struct *p)
> +{
> +	struct rq *src_rq =3D task_rq(p);
> +
> +	lockdep_assert_rq_held(src_rq);
> +
> +	if (!sched_proxy_exec())
> +		return false;
> +
> +	/* @p may be rq->curr under another task's scheduling context. */
> +	if (task_on_cpu(src_rq, p))
> +		return true;
> +
> +	if (is_migration_disabled(p))
> +		return true;

[Severity: High]
Does returning true unconditionally for migration-disabled tasks conflate t=
hem
with active proxy execution?=20

If a task is migration-disabled but not actively proxying, it will be rejec=
ted
with SCX_TASK_REENQ_PROXY. Since rq_owned_post_enq() skips calling
schedule_deferred_locked() for SCX_TASK_REENQ_PROXY rejects:

	if (dsq->id =3D=3D SCX_DSQ_REJECT) {
		if ((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) =3D=3D
		    SCX_TASK_REENQ_PROXY)
			rq->scx.flags |=3D SCX_RQ_PROXY_REENQ;
		else
			schedule_deferred_locked(rq);
	}

And scx_proxy_resolved() is never called for a task that isn't actively
proxying, could this leave the task permanently stranded on the reject DSQ =
if
the source rq is idle?

> +
> +	/* Don't move an active scheduling context off its source rq. */
> +	if (task_current_donor(src_rq, p))
> +		return true;
> +
> +	return false;
> +}

[ ... ]

> @@ -2660,6 +2740,7 @@ static struct rq *move_task_between_dsqs(struct scx=
_sched *sch,
>  					 struct scx_dispatch_q *dst_dsq)
>  {
>  	struct rq *src_rq =3D task_rq(p), *dst_rq;
> +	bool proxy_raced;
> =20
>  	BUG_ON(src_dsq->id =3D=3D SCX_DSQ_LOCAL);
>  	lockdep_assert_held(&src_dsq->lock);
> @@ -2667,6 +2748,13 @@ static struct rq *move_task_between_dsqs(struct sc=
x_sched *sch,
> =20
>  	if (dst_dsq->id =3D=3D SCX_DSQ_LOCAL) {
>  		dst_rq =3D container_of(dst_dsq, struct rq, scx.local_dsq);
> +		proxy_raced =3D src_rq !=3D dst_rq && task_move_proxy_raced(p);
> +		if (unlikely(proxy_raced)) {
> +			dispatch_dequeue_locked(p, src_dsq);
> +			raw_spin_unlock(&src_dsq->lock);
> +			scx_reject_task(sch, src_rq, p, enq_flags);
> +			return src_rq;
> +		}

[Severity: High]
If a BPF scheduler incorrectly attempts to migrate a migration-disabled tas=
k to
a remote local DSQ, task_move_proxy_raced() intercepts the dispatch here.

Can this prevent task_can_run_on_remote_rq() from detecting the illegal
migration and triggering scx_error(), bypassing the BPF scheduler failsafe
while leaving the task permanently starved?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810151523.8699=
4-1-arighi@nvidia.com?part=3D10
