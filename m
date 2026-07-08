Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EE5366546
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548286; cv=none; b=W4g7yzNJ+ZiQMvsAJciHhNrA13DPBiwRilTwXvbst5Dxv2g5K/Yx4zXMISOGtD3FAILe2zYmWZYWefwRjCGh0wDADaENLloAEHsSqrJt9u2wzcduNcyMCS4zcOm1gwf+V8ASbjaWJCwhsaNAC02a/pzdO5s0W8IY7wYuJg2N0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548286; c=relaxed/simple;
	bh=xzBgiVyZAW8pmGJ0/AKaJAPzCf21tPF0XJk6JscdLfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nB9QZlZr22iW8M7715K5UWwWF6qsau77yA4DGbkl5AdFtmmoSEiz/5RCWHIRWHPPr30jvm6yAo1QUW2ccaJXSvXFwbFCUk2Z8HD2G78rFOwgDTsW5svuxLcVgP1qnxXG3T6v2MaS/ClvQHdMmlbgX4YU85TcwVND8o7WoWC2eA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XufH8mz2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XufH8mz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA121F000E9;
	Wed,  8 Jul 2026 22:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783548285;
	bh=N7hVsbNyhmKXF6zJOCVRU1VVff0UCAGiO7I3xEymydc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XufH8mz2c2+Wuq4hLHA1ZNLcscXSMF5gRIAo55gC8iDf5q97TxNGUJYjMDiHyffvq
	 eo4Ax+THn7o/UWKHeyb/SSk93GHVP0CoCkiRYjzCYpEY/wDcF4tKKcDonUWERKZ8Yq
	 EMMzDbc0i2IkIqSojrdRYfLoc7sTHeHxh9Lqddfw6EqaYiSAMarYuaxTsAGokL6N+g
	 hqW+a+oSRhhPQwI3my3tyuaTJcKYWSpjo5S7v/EeumTcNeIp79uuM1RvHSKFdYGg7j
	 POyFeQfA5PBqTLTjNhVxgsh/sn20vBjD+gDm8jz/8c+gqHsWwDLI6Q87kzj4Y2rfKI
	 uTl9UnQlhbZeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 34/40] sched_ext: Authorize
 remote-move inserts against the placing scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-35-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-35-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:04:44 +0000
Message-Id: <20260708220444.DDA121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] scx_local_or_reject_dsq aborts the task owner when the placing sch=
eduler lacks capabilities, and scx_dispatch_enqueue conflates the owner and=
 placer causing misattributed errors and erroneous ops.dequeue invocations.
--

--- Patch [34]: [PATCH v4 sched_ext/for-7.3 34/40] sched_ext: Authorize rem=
ote-move inserts against the placing scheduler ---
commit aba6c3faa0482889b73037930ca34ba762b24887
Author: Tejun Heo <tj@kernel.org>

sched_ext: Authorize remote-move inserts against the placing scheduler

This commit addresses an issue in the remote-move path where tasks could
be spuriously rejected because capabilities were checked against the task's
owner rather than the placing scheduler. It stashes the placing scheduler
across the activate_task() boundary to correctly authorize against it.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index e15297c296176..896f8f9eea6fc 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -2533,7 +2537,7 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, =
struct rq *rq,
>  		}
> =20
>  		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
> -			if (likely(consume_remote_task(rq, p, enq_flags, dsq, task_rq)))
> +			if (likely(consume_remote_task(sch, rq, p, enq_flags, dsq, task_rq)))
>  				return true;
>  			goto retry;
>  		}

[Severity: High]
This is a pre-existing issue, but does passing the placing scheduler during
local moves cause issues with ops.dequeue?

For local moves going through scx_consume_dispatch_q() into
move_local_task_to_local_dsq(), the sch variable is the placing scheduler.

If call_task_dequeue() uses this, ops.dequeue is invoked on the placer
instead of the task's owner, leaving the owner unaware that the task left
custody.

[ ... ]

> @@ -2627,8 +2631,7 @@ static void dispatch_to_local_dsq(struct scx_sched =
*sch, struct rq *rq,
>  			scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
>  					     p, enq_flags | SCX_ENQ_GDSQ_FALLBACK);

[Severity: High]
This isn't a bug introduced by this patch, but it seems there is a similar
conflation in scx_dispatch_enqueue() regarding error attribution.

If the placer passes invalid enq_flags or an invalid DSQ ID to a built-in
DSQ, scx_dispatch_enqueue() triggers scx_error(sch, "cannot use vtime...").

For remote moves, sch here is the owner. Does this mean the owner scheduler
is unfairly aborted for the placer's error?

>  		} else {
> -			move_remote_task_to_local_dsq(p, enq_flags,
> -						      src_rq, dst_rq);
> +			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
>  			/* task has been moved to dst_rq, which is now locked */
>  			locked_rq =3D dst_rq;
>  		}

[ ... ]

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 9a1eac886928e..f66e97f08ce64 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -237,12 +237,17 @@ struct scx_dispatch_q *scx_local_or_reject_dsq(stru=
ct scx_sched *sch, struct rq
>  					       struct task_struct *p, u64 *enq_flags)
>  {
>  	s32 cid =3D __scx_cpu_to_cid(cpu_of(rq));
> +	struct scx_sched *asch =3D rq->scx.remote_activate_sch ?: sch;
>  	u64 needed =3D scx_caps_for_enq(*enq_flags);
>  	u64 missing;
> =20
> +	/*
> +	 * On a remote activation the scheduling sched (@asch) differs from
> +	 * @p's owner (@sch). Check caps against the scheduling sched.
> +	 */
>  	if (*enq_flags & SCX_ENQ_PREEMPT)
> -		needed |=3D scx_caps_for_preempt(sch, rq);
> -	missing =3D scx_missing_caps(sch, cpu_of(rq), needed);
> +		needed |=3D scx_caps_for_preempt(asch, rq);
> +	missing =3D scx_missing_caps(asch, cpu_of(rq), needed);

[Severity: High]
Does this incorrectly penalize the owner task if capabilities are missing?

If missing & SCX_CAP_BASE is true after this check, the subsequent error
handling in scx_local_or_reject_dsq() calls scx_error(sch, ...).

Since capabilities are now correctly checked against the scheduling
scheduler (asch), should the error attribution (and events like
SCX_EV_SUB_FORCED_ADMIT) use asch instead of sch so the descendant
scheduler isn't unfairly aborted when an ancestor lacks capabilities?

> =20
>  	/* requirements met */
>  	if (likely(!missing))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D34
