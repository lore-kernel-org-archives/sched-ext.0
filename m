Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED432C8B
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778065108; cv=none; b=sVT408GWfwcRuQWP10RBARRvUwB0G7iMuNhk0QYU7VW30io4IeglSL6JK8NG2SYOo8Ets89LbcaBhwia0VVImS0kW0ezk+E8MdfxyC6hBGCPeaWZdBYRxBpbGkiqElKfErUXxYVX9hZ0uqXBDQUzLEuvAKF8EnMymSGfxHZ2mV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778065108; c=relaxed/simple;
	bh=ukVsAY4tQ3cIB8f4if0FgjRxfwXAwi+VI3e4lgCUnzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jpu+/00G6pOS5YmU0rNMJMHjXRS1uTjvKZtVHvIF8ylnLP9846I76YDKheOLD5Vr669DU01lAuEGOi7ZloWoJWkQ6+8ZlAOAY1a2GPDgf8Ka4zr3+6sfBRsd8X8wqgWflU2qulh6cLnmucl/+5VQzutaV5syPXlyiXxEBowa8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAJ4viGP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAJ4viGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3850C2BCB8;
	Wed,  6 May 2026 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778065107;
	bh=ukVsAY4tQ3cIB8f4if0FgjRxfwXAwi+VI3e4lgCUnzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XAJ4viGPKNIQTO/0/FSVcVs09b2xCjFDZhiq0rQGvV+lYEcdWHltjWwYrk6h07fLY
	 zv5laxKp3BgmiY3YlE17Ildr8QoNF1aDCNYpPFeiaF5CGvpxrCRkmePzBQr5WHZ/NX
	 h9aptBNRRqDUmTzi6BegPONM6+QQyS/x114Lq/uPNePFQacvxmYAqvRVCNqbjBl7bB
	 DuVCOPL+gZyO9rccXQMlEcLiPVJBMqboIFVDoyuXsUnQJmzTYySq5iumNbwW8xNBHv
	 sWO/fz+GedR5NxcC4IQ+7YXnjvOiV2zVC0UJBGdvBtQqeCbMnX/tnL4u//XMq7uv7z
	 bQdMltanaaH9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Add cookie API for early qseq capture
Reply-To: sashiko@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260506075925.371138-1-yphbchou0911@gmail.com>
References: <20260506075925.371138-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 10:58:27 +0000
Message-Id: <20260506105827.A3850C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unprotected task state mutation causing data race on slice
- [High] Missing acquire memory barrier in scx_bpf_task_get_cookie() defeat=
s sequence-lock protection
- [Medium] Missing API variant for PRIQ (vtime-ordered) DSQ insertion
--

commit c9d30798b70b7101ea880a0f906790c5875384ac
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

sched_ext: Add cookie API for early qseq capture

This commit introduces two new kfuncs, scx_bpf_task_get_cookie() and
scx_bpf_dsq_insert_with_cookie(), to allow BPF schedulers to capture a
task's qseq before performing pre-dispatch checks and safely insert it
if the sequence hasn't changed.

Link: https://lore.kernel.org/r/20260203230639.1259869-1-arighi@nvidia.com/

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5600618dcef8e..5ee74c964a971 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c

[ ... ]

> +/**
> + * scx_bpf_task_get_cookie - Get an opaque dispatch cookie for a task
> + * @p: task_struct to read cookie from
> + *
> + * Returns an opaque u64 cookie encoding @p's current qseq. Call this
> + * before pre-dispatch validity checks and pass the result to
> + * scx_bpf_dsq_insert_with_cookie() to extend the qseq protection window.
> + *
> + * For schedulers that do not implement properly synchronized dequeue on=
ly.
> + */
> +__bpf_kfunc u64 scx_bpf_task_get_cookie(struct task_struct *p)
> +{
> +	return atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK;

Should this use atomic_long_read_acquire() instead of a relaxed atomic read?

Since this conceptually starts a sequence-lock read-side critical section,
a relaxed read doesn't emit hardware memory barriers. On weakly-ordered
architectures, the CPU could reorder the subsequent BPF memory loads (the
validity checks) to execute before the ops_state read.

If a concurrent dequeue/re-enqueue race occurs, the BPF checks could be
evaluated using stale task data, but the delayed ops_state read captures
the new qseq. The protection window is defeated, and finish_dispatch()
would accept the dispatch despite violated constraints.

> +}
> +
> +/**
> + * scx_bpf_dsq_insert_with_cookie - Insert a task using an early-capture=
d cookie
> + * @p: task_struct to insert
> + * @dsq_id: DSQ to insert into
> + * @enq_flags: SCX_ENQ_*
> + * @cookie: cookie from scx_bpf_task_get_cookie()
> + * @aux: implicit BPF argument
> + *
> + * Like scx_bpf_dsq_insert() with slice=3D0, but uses @cookie's qseq ins=
tead
> + * of re-reading ops_state at insert time. A stale cookie causes
> + * finish_dispatch() to silently discard the dispatch. Use
> + * scx_bpf_task_set_slice() to set a non-default slice.
> + *
> + * Returns %true on success, %false on failure.
> + */
> +__bpf_kfunc bool scx_bpf_dsq_insert_with_cookie(struct task_struct *p,
> +						 u64 dsq_id, u64 enq_flags,
> +						 u64 cookie,
> +						 const struct bpf_prog_aux *aux)
> +{
> +	struct scx_sched *sch;
> +
> +	guard(rcu)();
> +	sch =3D scx_prog_sched(aux);
> +	if (unlikely(!sch))
> +		return false;
> +
> +	if (!scx_dsq_insert_preamble(sch, p, dsq_id, &enq_flags))
> +		return false;
> +
> +	p->scx.slice =3D p->scx.slice ?: 1;

Does modifying the slice here create a data race if the task is currently
running on another CPU?

Because this kfunc is meant for scenarios where the task reference might be
stale due to a concurrent dequeue/re-enqueue race, the task might be in the
TASK_RUNNING state elsewhere.

Modifying p->scx.slice without holding the task's current rq->lock can race
with update_curr_scx() on the other CPU, potentially overwriting the slice
decrement from the timer tick.

> +
> +	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags, (unsigned long)cookie);
> +
> +	return true;
> +}

Is there a missing API variant for inserting into PRIQ (vtime-ordered) DSQs
with a cookie?

To insert a task into a PRIQ DSQ, SCX_ENQ_DSQ_PRIQ must be set. However,
BPF schedulers cannot manually pass this flag in enq_flags because
scx_dsq_insert_preamble() rejects it as part of __SCX_ENQ_INTERNAL_MASK.
This prevents BPF schedulers from using the new cookie mechanism for
vtime-ordered priority queues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506075925.3711=
38-1-yphbchou0911@gmail.com?part=3D1
