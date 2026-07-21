Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41362443A91
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621627; cv=none; b=WummIZyZorYu0m9TD2EDbdGmFvJ3fTAZOEGW4zEoVeT6Mj1A1kwMMECTamYMkL6C8XpfK5Nabr+ox3q3T9Jj59d1xEGwsPZDZOKxtNrzW0ywGdCVZ2FLGk5HlkJmwg2qhcDfG3UbhrgDStLdvqPQgV1XiKnICD9gUg5rZtbCCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621627; c=relaxed/simple;
	bh=AitbqSISC0yVd+ddXJNpgiJYjWqdgCcr47kU14MFfoA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p0dcnfaalstqQPtpBOg+1mrZLoWao3xeoYVTIq6PI7yr/qwmf4G7M+SAQ1Lzx6HBtNkHOVeyyyBsxmLB7uiyjA4X0/rSaBRH/KFsRuGaDHp8YxJOm6jThaO/xM9kyaYu+kd6VYh85ljM8i75Ep7tDSsUx+ybxsu/ASS02WchQKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBJKyg1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBJKyg1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A041F00A3A;
	Tue, 21 Jul 2026 08:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784621622;
	bh=LWBJilT6RVr4HTvrvYSy5IveNMacyxrqUj96/HzOYr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cBJKyg1dr4zinCiAhWZKQRrmNWsPASBfFgQgh0WHDVQivjlM/pr5mqD/wEwf8ElkS
	 JHW4Mo3uTcRYuaQZCfmPZvIdZC6S/G+M9vZxjOgHwtmtJ/e6xapYgQzHgtAgS6Ra3T
	 pO5mndxbTadKc2wt6xbB8DYUzqRej2lNX2KKq34feimkpqjyzz7RlxG0xr7CatIK6T
	 myQpMqDVmqO1aF9dUZNunT/mxb/lBWZXTAEjs5WKi/Eq0wiG3lL62Q3ZShgCHKiT0/
	 Ndq5QKKKTq70CQBUqH6hx9o3tVfB75g5gEm0xXUj/7CAN7+ssV3KxH9O3IioCzPuZB
	 lXRRrWalcr48Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] sched_ext: Split curr|donor references properly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260721063242.552774-8-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
 <20260721063242.552774-8-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:13:41 +0000
Message-Id: <20260721081342.20A041F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] task_tick_scx() unconditionally invokes ops.tick() for blocked pro=
xy donors, violating the BPF state machine contract.
- [Medium] Missing task_current_donor() check in enqueue_task_scx() violate=
s DSQ invariants for proxy donors.
--

--- Patch [7]: [PATCH 07/12] sched_ext: Split curr|donor references properl=
y ---
commit 0a1e9539e4e14034ca89a7b3b4988f413e2e416b
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Split curr|donor references properly

This commit updates the sched_ext scheduler class to distinguish between the
physical execution context and the scheduling context during proxy executio=
n.
It ensures that sched_ext policy, accounting, and various BPF kfuncs observe
the donor task instead of the physically executing task.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index b5fd91d9bca4f..a466adf8e1548 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -3566,9 +3577,9 @@ void scx_tick(struct rq *rq)
>  	update_other_load_avgs(rq);
>  }
> =20
> -static void task_tick_scx(struct rq *rq, struct task_struct *curr, int q=
ueued)
> +static void task_tick_scx(struct rq *rq, struct task_struct *donor, int =
queued)
>  {
> -	struct scx_sched *sch =3D scx_task_sched(curr);
> +	struct scx_sched *sch =3D scx_task_sched(donor);
> =20
>  	update_curr_scx(rq);
> =20
> @@ -3577,13 +3588,13 @@ static void task_tick_scx(struct rq *rq, struct t=
ask_struct *curr, int queued)
>  	 * we can't trust the slice management or ops.core_sched_before().
>  	 */
>  	if (scx_bypassing(sch, cpu_of(rq))) {
> -		set_task_slice(curr, 0);
> -		touch_core_sched(rq, curr);
> +		set_task_slice(donor, 0);
> +		touch_core_sched(rq, donor);
>  	} else if (SCX_HAS_OP(sch, tick)) {
> -		SCX_CALL_OP_TASK(sch, tick, rq, curr);
> +		SCX_CALL_OP_TASK(sch, tick, rq, donor);
>  	}

[Severity: High]
Does this code incorrectly call ops.tick() for a blocked donor?

The commit message explicitly states that a blocked donor does not enter an
ops.running() or ops.stopping() session. However, this unconditionally invo=
kes
ops.tick() for the donor without verifying if it is blocked or tracked as
running.

Since BPF schedulers may allocate per-CPU state upon ops.running(), could t=
his
crash or leak state when ops.tick() fires for a task the scheduler never
tracked as running?

[ ... ]

> @@ -9172,13 +9195,15 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct ta=
sk_struct *p, u64 slice,
>  		return false;
> =20
>  	/*
> -	 * Directly write only when we hold the lock of the rq @p is queued or
> -	 * running on. See the slice write rules above.
> +	 * Directly write only when we hold the lock of the rq @p is queued on =
or
> +	 * provides the current scheduling context for. Under proxy execution,
> +	 * rq->donor owns and consumes the slice while rq->curr executes on its
> +	 * behalf. See the slice write rules above.
>  	 */
>  	locked_rq =3D scx_locked_rq();
>  	if (!locked_rq ||
>  	    (READ_ONCE(p->scx.runnable_cpu) !=3D cpu_of(locked_rq) &&
> -	     !task_current(locked_rq, p))) {
> +	     !task_current_donor(locked_rq, p))) {
>  		set_task_slice_oob(sch, p, slice);
>  		return true;
>  	}

This patch updates several task_current() checks to task_current_donor(),
but it appears one was missed in enqueue_task_scx():

kernel/sched/ext/ext.c:enqueue_task_scx() {
    ...
	/*
	 * Restoring a running task will be immediately followed by
	 * set_next_task_scx() which expects the task to not be on the BPF
	 * scheduler as tasks can only start running through local DSQs. Force
	 * direct-dispatch into the local DSQ by setting the sticky_cpu. Mark
	 * IGNORE_CAPS to force entry into the local DSQ.
	 */
	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p)) {
		sticky_cpu =3D cpu_of(rq);
		enq_flags |=3D SCX_ENQ_IGNORE_CAPS;
	}
    ...
}

[Severity: Medium]
Should this use task_current_donor(rq, p) instead of task_current(rq, p)?

If a blocked proxy donor undergoes priority inheritance, it could be
dequeued and re-enqueued with ENQUEUE_RESTORE. Since the donor is not
physically rq->curr, task_current(rq, p) evaluates to false.

Would this bypass the local DSQ assignment and erroneously push the active
proxy donor into the BPF scheduler instead of the local DSQ?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721063242.5527=
74-1-arighi@nvidia.com?part=3D7
