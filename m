Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300273B3884
	for <sched-ext@lists.linux.dev>; Fri,  7 Aug 2026 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786137754; cv=none; b=IborAi0V28K7UGT4MllkOKLNWkgBTOkF6fLeKnMlvdE0bx1Zx7ZWcsuCAfWJM543UQi5W41eFdSsxI25B9Rkj1oRufmym94naN5QhsEAV3vk4v4MATdJlNE3t4z/0qogHdnTW40WbjqZebQZ/u9XuWmI0fNH2oTiw1liYkiGpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786137754; c=relaxed/simple;
	bh=wgjrYs6smEXJh17mXKfyr0zAV4CpllW8UwCloNXI+GQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S089UMxsyTAkoTwGriUIYM8G0YH4eb+RA5wC9VMrCIyhyVSZzBHbUdF1lyL2BiV8rUo8tP4NJDDS0PDAQqejyBXA8WbO52Mdh9+YxbLYcyEadWVEuQpozEWRE1kSmdtQ5EMA82a/YBlQs58AyruUM7MZReRfhyIF00ZKxqAFMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ortNiqEQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ortNiqEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43FF1F000E9;
	Fri,  7 Aug 2026 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786137752;
	bh=rDF6R1k9c0ORkBXhQn1Hn3WxB0TNMZd1j6YScGed8z8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ortNiqEQ/W3D0e714HkeBfzoHp1WFF9HGNRx+lfibswKQQRx7WaCYA+SGYo9NQjjw
	 +xbuGa6GP5CoBQo6omRzt0la2E9c/hMEwKGsOolGnGp9YTD+9LkXWlJfTYyjmg50NL
	 t50LKJ3wGJ8ab//CFH1/KMqMTIvm0p695zN8g4ih6rdx5aBiDgjsjqEYhAUWyIHgNH
	 craD96LZ99DOH1KFI1LTxxQ7ul2sKZ1TTAMucH7NUKvmpfGQDhJG17n7xubyHXcADY
	 CimQGw79uySeUEhKNGq6x20U7A4kcozJJgENt0OtMy2gkny1Itc9v7ZEpRtaJyreun
	 Wf2PuCneZoNOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] sched_ext: Fix rq->core_pick corruption under core
 scheduling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260807210221.232543-7-tj@kernel.org>
References: <20260807210221.232543-1-tj@kernel.org>
 <20260807210221.232543-7-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 21:22:32 +0000
Message-Id: <20260807212232.B43FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Under core scheduling, a pending kick-sync operation is silently i=
gnored and lost when a sibling CPU performs the core-wide pick, breaking th=
e wait guarantees of the scx_bpf_kick_cpu() kfunc.
--

--- Patch [6]: [PATCH 6/6] sched_ext: Fix rq->core_pick corruption under co=
re scheduling ---
commit 80aba2ffb0bb3ad3c3cd2d54f2eb79683a1d623d
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix rq->core_pick corruption under core scheduling

This commit addresses an issue in sched_ext under core scheduling where
dispatching could drop the rq lock and corrupt the core-wide selection stat=
e.
It fixes this by restarting the selection when dispatch releases the lock,
ensuring picks are committed atomically.

Link: https://github.com/sched-ext/scx/issues/3715

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index ebe40953acf01..c704588854879 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -3241,6 +3242,70 @@ static enum scx_dsp_verdict dispatch_pick(struct r=
q *rq, struct rq_flags *rf,
>  	return verdict;
>  }
> =20
> +#ifdef CONFIG_SCHED_CORE
> +/*
> + * Dispatch for a pick when core scheduling is enabled. The selection pi=
cks for
> + * all SMT siblings and the rq_i->core_pick state it builds must stay at=
omic
> + * throughout. If the dispatch released the rq lock, anything can have h=
appened
> + * in between - return %SCX_DSP_RETRY to restart the selection against c=
urrent
> + * state.
> + */
> +static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_=
flags *rf,
> +					       struct task_struct *prev)
> +{
> +	enum scx_dsp_verdict verdict;
> +	u32 seq =3D rq->scx.lock_drop_seq;
> +
> +	/* another dispatch is in flight on @rq, let that handle it */
> +	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
> +		return SCX_DSP_NONE;
> +
> +	rq_unpin_lock(rq, rf);
> +
> +	verdict =3D balance_one(rq, prev);
> +
> +	if (cpu_of(rq) =3D=3D smp_processor_id()) {
> +		maybe_queue_balance_callback(rq);
> +
> +		/* see dispatch_pick() */
> +		if (unlikely(rq->scx.kick_sync_pending)) {
> +			rq->scx.kick_sync_pending =3D false;
> +			queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
> +					       kick_sync_wait_bal_cb);
> +		}
> +	} else if (unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {

[Severity: High]
Does this silently drop pending kick-syncs for remote sibling runqueues und=
er
core scheduling?

Because the kick_sync_pending check is under the cpu_of(rq) =3D=3D
smp_processor_id() branch, if a sibling CPU performs the core-wide pick for
this remote runqueue, the check is skipped.

The core picker then sets rq->core_pick for this runqueue. When the kicked
sibling CPU enters __schedule(), it hits the core-scheduling fast-path and
bypasses do_pick_task_scx(). As a result, dispatch_core_pick() is never
executed locally.

Could this lead to the kick_sync_wait_bal_cb balance callback never being
queued, breaking the synchronization guarantees of scx_bpf_kick_cpu() and
leaving the BPF scheduler operating on incorrect assumptions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807210221.2325=
43-1-tj@kernel.org?part=3D6
