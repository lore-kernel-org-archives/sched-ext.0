Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09935258EE9
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792251660; cv=none; b=hg+b4+ssySLYynVIAszewK4ANC7z8T0n3a+NtavlX/mW0Jdx/x+/33xIr8WxgVL2DHkM3BqR/zhjxAJNd04uiE7TipGRF8jyME4aL96r1ItIYK3yzUxey0Igje5hJykg6dq7L5V+8CO05ssVkUfWWf1nbWxSu3MSd1ezjQrUvf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792251660; c=relaxed/simple;
	bh=LZZDEd1N+tQuLbS5HFYfkf9vLGidQdg9xIDT+jcwzzg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IVM0pK9WJUx6yOiwqTQKjw2Ky0cc87hL5HO5AuqugaUWkAizY32lIp+1cJ8p2hhPDRyPfnq2SEwI2PE/Bh9TSYZkWwuVwBqWKm88m41UeB+RzKrb/h7GQIOPxkrzqR2jf9aG77USeIf7NrA77g5dGKspmCQDpaqBHU5DCOP75PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8Wpenpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8Wpenpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2811F000C4;
	Sat, 17 Oct 2026 15:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792251658;
	bh=dye/VW2xWz1QDH9USW34dYFEFSncCSx95b1aJrK8e4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y8Wpenpudllnf4nHI3ARfVMqGKyQn5SYzbqgS6Mpw+8kTykzbzvZhwYHYlUvnC++V
	 iyQH3UVvlcPzzBv3bUDlAtGXKDH/c/jgE3O7C2FfFuWqu/pvG9iEOkE7SLO580A38+
	 TOpN34ohT80dnCJV7+/KyP0W4d5ECzQnokwePWFl7nBCsey9jTQseqhxvbvStcadOl
	 xbI9H/RHsm98YdMyNsCearMJ2wAszSKgHXVXyCkgH/6a3OoFJuzg9/Np2QCIG0SZLx
	 ni4I++XCKeaXDAm0yZVam9d01BB1ZC8SlInW2l7eyGxDMUo9xt8yss4+IMFA3gQyL8
	 Kavy3h6SLOxSQ==
Message-ID: <sashiko-outbox-175614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3-fixes] sched_ext: Don't leave
 balance callbacks queued across a pick retry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261017152226.3690249-1-arighi@nvidia.com>
References: <20261017152226.3690249-1-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 15:40:58 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched_ext: balance callbacks queued before core-sched pick is final
--

commit 859b8e499322d8a16b0b359431e360cdd5ae7494
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Don't leave balance callbacks queued across a pick retry

This commit moves the queueing of rq->scx.deferred_bal_cb and
rq->scx.kick_sync_bal_cb to the exit path of do_pick_task_scx() so that
balance callbacks are only queued when do_pick_task_scx() returns a final
task rather than RETRY_TASK or a NULL dl_server pick.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 0403c46342813..e19961164cb01 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -3342,16 +3331,8 @@ static enum scx_dsp_verdict dispatch_core_pick(str=
uct rq *rq, struct rq_flags *r
> =20
>  	verdict =3D dispatch_one(rq, prev);
> =20
> -	if (cpu_of(rq) =3D=3D smp_processor_id()) {
> -		maybe_queue_balance_callback(rq);
> -
> -		/* see dispatch_pick() */
> -		if (unlikely(rq->scx.kick_sync_pending)) {
> -			rq->scx.kick_sync_pending =3D false;
> -			queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
> -					       kick_sync_wait_bal_cb);
> -		}
> -	} else if (unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
> +	if (cpu_of(rq) !=3D smp_processor_id() &&
> +	    unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
>  		/*
>  		 * Balance callbacks must run in the context that queued them,
>  		 * so they can't be queued on another CPU's rq. Run the deferred
> @@ -3394,8 +3375,10 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *r=
f, bool force_scx)
>  	else
>  		verdict =3D dispatch_pick(rq, rf, prev);
> =20
> -	if (verdict =3D=3D SCX_DSP_RETRY)
> -		return RETRY_TASK;
> +	if (verdict =3D=3D SCX_DSP_RETRY) {
> +		p =3D RETRY_TASK;
> +		goto out;
> +	}

[ ... ]

> @@ -3437,6 +3422,38 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *r=
f, bool force_scx)
>  		}
>  	}
> =20
> +out:
> +	if (cpu_of(rq) !=3D smp_processor_id())
> +		return p;
> +
> +	/*
> +	 * Balance callbacks must be consumed before the rq lock is released, so
> +	 * queue them only when the pick is final. On RETRY_TASK, or after a
> +	 * NULL pick from the dl_server, the core continues picking and can
> +	 * release the rq lock (e.g., prev_balance() or another dispatch). In
> +	 * that case, run the deferred work from irq_work, which doesn't depend
> +	 * on the current rq lock section, and leave the kick sync wait pending
> +	 * for the next pick.
> +	 */
> +	if (p !=3D RETRY_TASK && (p || !force_scx)) {
> +		maybe_queue_balance_callback(rq);
> +
> +		/*
> +		 * Defer to a balance callback which can drop rq lock and enable
> +		 * IRQs. Waiting directly in the pick path would deadlock against
> +		 * CPUs sending us IPIs (e.g., TLB flushes) while we wait for
> +		 * them.
> +		 */
> +		if (unlikely(rq->scx.kick_sync_pending)) {
> +			rq->scx.kick_sync_pending =3D false;
> +			queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
> +					       kick_sync_wait_bal_cb);
> +		}
> +	} else if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
> +		rq->scx.flags &=3D ~SCX_RQ_BAL_CB_PENDING;
> +		schedule_deferred(rq);
> +	}
> +
>  	return p;
>  }

[Severity: High]
Under CONFIG_SCHED_CORE, can a non-RETRY_TASK return from
do_pick_task_scx() on the local rq still be followed by further picks that
release the shared core lock before the core-wide pick is final?

In kernel/sched/core.c:pick_next_task(), a single shared core lock is held
across all SMT siblings, and pick_task() can be called multiple times after
the local rq pick succeeds:

1. In the !need_sync fastpath, pick_task(rq, rf) runs on the local rq:

kernel/sched/core.c:pick_next_task() {
	if (!need_sync) {
		next =3D pick_task(rq, rf);
		...
		if (!next->core_cookie) {
			...
			goto out_set_next;
		}
	}
}

If do_pick_task_scx() returns a cookied SCX task (next->core_cookie !=3D 0),
the out: block sees p !=3D RETRY_TASK && (p || !force_scx) and queues
rq->scx.deferred_bal_cb and/or rq->scx.kick_sync_bal_cb on
rq->balance_callback. Because next->core_cookie is non-zero,
pick_next_task() then falls through into the for_each_cpu_wrap(i, smt_mask,
cpu) loop to re-pick across all siblings.

2. In the for_each_cpu_wrap(i, smt_mask, cpu) loop in pick_next_task(),
iteration starts at i =3D cpu (where cpu_of(rq_i) =3D=3D smp_processor_id()=
):

kernel/sched/core.c:pick_next_task() {
	for_each_cpu_wrap(i, smt_mask, cpu) {
		rq_i =3D cpu_rq(i);
		...
		p =3D pick_task(rq_i, rf);
		if (unlikely(p =3D=3D RETRY_TASK)) {
			...
			goto restart;
		}
	}
}

Once do_pick_task_scx() on the local rq succeeds and queues the balance
callbacks on rq->balance_callback, the loop proceeds to call
pick_task(rq_i, rf) on the remaining SMT siblings (i !=3D cpu). When
dispatch_core_pick(rq_i, rf, prev) runs for a sibling rq_i,
dispatch_one(rq_i, prev) or run_deferred(rq_i) can drop the shared core
lock and return SCX_DSP_RETRY, causing pick_next_task() to jump to restart
with rq->balance_callback already queued on the local rq. Any CPU acquiring
the core lock during that window will trigger the warning in
assert_balance_callbacks_empty() via rq_pin_lock() or flush the callback
early.

3. Also in dispatch_core_pick(), if an SMT sibling already has an in-flight
dispatch on the local rq:

kernel/sched/ext/ext.c:dispatch_core_pick() {
	/* another dispatch is in flight on @rq, let that handle it */
	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
		return SCX_DSP_NONE;
}

Previously, returning SCX_DSP_NONE here bypassed callback queueing in
dispatch_core_pick(). With the callback handling moved to the out: label in
do_pick_task_scx(), won't this early return now fall through to out: and
consume SCX_RQ_BAL_CB_PENDING and rq->scx.kick_sync_pending while the
sibling's dispatch_one() on rq is still in flight?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017152226.3690=
249-1-arighi@nvidia.com?part=3D1
