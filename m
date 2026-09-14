Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A4313267
	for <sched-ext@lists.linux.dev>; Mon, 14 Sep 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376802; cv=none; b=s0A5tspmUXfWkfPyL/YOawedOF2NuEaKCJltrCnp9C/oGTFmfkuq+d0OXwSXO7A9RRIasJaQz8pnghFzW1wI2dAr7JranSDjOMSS+SolDXvl3yqnqPy6l4fgPLo+ANKO+SD02+487RaVxXTEoBrXzs3EfaYikESLFqpNIiTcJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376802; c=relaxed/simple;
	bh=EzYK9IwlK/IxYTismSnj+LMGC3tLPadz6L/BJHnb190=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dWfMaqKDdSzCMMQ2irilMYBtvGr3+jxQZ4LQkcy0uakc3KDvj5A4OiTTrMmlZ3f5J21Y/CCesFh17EOyi6flfeICe87BHMqY0YdFvJ0Tot/erEfLnroSTETPTVc8hWjtJzf8YNKBJvof5piUpO5Dutbz1N/1baBZdduPTXHE5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2ZOMU5D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2ZOMU5D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47A81F000FF;
	Mon, 14 Sep 2026 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789376800;
	bh=gs5/XPE3dg0pDAKhyAqACqzHA3LlVU9RLyYX7VK0Pgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X2ZOMU5DH8v56QwewWz8bbcF32ZjEyjY1f6jLpMaSyuBjNe2nXBjK4QEFJ/OIHcco
	 XvjcTZl+/3URKhzWR+yWgQs64M90aO4n7s15RLkheC/9QmOiOzXMfJgnTBLi9A59oE
	 sjrWxFhkx3eR7++SOI0YC4tlyKxfGIcRyK5bWFRmyj6d9/wvXbwJygTS0vlGOf8TN9
	 9nbTRiGAznirwVfAOMmNzwWppxvErVu9rivBrvdzI01M7fvc1WGE+I+53JUaXw+lrj
	 /0AIB5dQqwnhGkDDWUBd7LBmkzWFqcB8YbqqU5aBtmbmP8f93azxXd/CMtV5gJmhm3
	 McD5xfqcT0LkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add lazy preemption support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260914084955.1798562-2-arighi@nvidia.com>
References: <20260914084955.1798562-1-arighi@nvidia.com>
 <20260914084955.1798562-2-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:06:40 +0000
Message-Id: <20260914090640.A47A81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Calling update_rq_clock(rq) inside scx_resched_curr_lazy() trigg=
ers a WARN_DOUBLE_CLOCK warning because the runqueue clock has already been=
 updated in the calling contexts.
--

commit 6fc03e981449ffc8b39d02362a88e51ad755b27e
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Add lazy preemption support

The fair scheduling class can request lazy rescheduling, deferring an
in-kernel scheduling boundary until returning to user space or until the
next scheduler tick. sched_ext only exposes immediate preemption,
preventing BPF schedulers from making the same trade-off.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 11114a6daf387..6d39f715196dc 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -1515,6 +1515,23 @@ static void call_task_dequeue(struct scx_sched *sc=
h, struct rq *rq,
>  	p->scx.flags &=3D ~SCX_TASK_IN_CUSTODY;
>  }
> =20
> +/*
> + * A task with an infinite slice may be running with its tick stopped. L=
azy
> + * rescheduling doesn't send an IPI, so restore the tick dependency firs=
t to
> + * guarantee that the lazy request is promoted by a real scheduler tick.
> + */
> +static void scx_resched_curr_lazy(struct rq *rq)
> +{
> +	if (rq->scx.flags & SCX_RQ_CAN_STOP_TICK) {
> +		rq->scx.flags &=3D ~SCX_RQ_CAN_STOP_TICK;
> +		update_rq_clock(rq);
> +		update_other_load_avgs(rq);

[Severity: Medium]
Does this trigger a SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED)
double-clock update warning?

It looks like update_rq_clock() can be called from paths where the clock
has already been updated or the rq lock was taken without pinning.

For example, during a task enqueue, enqueue_task() updates the clock and
sets RQCF_UPDATED. The call chain then reaches rq_owned_post_enq() ->
scx_resched_curr_lazy(), calling update_rq_clock() while RQCF_UPDATED is
still set.

It also appears reachable via kick_one_cpu(), which acquires the runqueue
lock using raw_spin_rq_lock_irqsave() rather than rq_pin_lock(). This means
RQCF_UPDATED is not cleared from the previous lock hold, and calling
scx_resched_curr_lazy() here updates the clock without a valid pin context.

> +		sched_update_tick_dependency(rq);
> +	}
> +
> +	resched_curr_lazy(rq);
> +}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914084955.1798=
562-1-arighi@nvidia.com?part=3D1
