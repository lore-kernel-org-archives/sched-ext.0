Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659842C9D
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303767; cv=none; b=iMzGSgBNjnrgX2P+zGOe+66qWDkQbbcM/dfSM8y78Nspvz7tQ1iz+RQ2tgZx/kvtD1oas9fe1bLzgMXgrVxgGTog6eeby/MRT6G+4kWr6aRwxeMxqROuJ5esGnXPyJA/bW6KQ44VHAMTizQQt1QQ9AkG61qZTABMfERjf4dxgXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303767; c=relaxed/simple;
	bh=HpZUplxwEQh1Jm4dH+I8Kjx1CHGhoLf5J1lnHZuDvBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OEkANryszU6dneWF4pBypgxMa+KXwyPnLIolCVRTP3NKpKRZO+E5Gk5y/Ri2sQ7VQAufvYVz9J5ti9N6GScjMXZW6nvcD9CKOdHNFUxxVk+y35d6S6p3HBGU9NQxMx7DDH8TXIRzJxsaU6o1/ni1fOae8KS0O7PJpoxz1rsqoqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBuJMhfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBuJMhfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422B21F00A3A;
	Mon,  6 Jul 2026 02:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303766;
	bh=Xbl+OkX6fAHx4oihvwwZaPePqg0C7xfEAmro1xDERQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBuJMhfDI01CqNWuFFV26+3lBQAPph0AMzhw2RuRPFLLMWRnqXpdC4b2o5ZRfXMPs
	 qH86phOBofPx/qomTzAYxyMge+aH9Bepn1NfJy8VibJHiIhzBmCiDNWYGhYMVG08Qn
	 MubBfN5Gy6htBPIsgiS9SXV3qHhTukcJ22EipJwzAS5WIcbUK24tMrm6CRDx8GRcqK
	 H2QKc1af/f1m58ayy3nxl1x1tDpCeTOJB8zQOXDxNOjqQMxzwkbrOjeH+4cBG3kUzC
	 Zhx8qfXDsN4G46Wc0e2guh1Ptp/VtQneTWWJViWbAlxkkPbHTwOgifibFYe4SpYNas
	 Pt+6QqQxX9pBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 22/36] sched_ext: Add
 sub_ecaps_updated() effective-cap change notifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-23-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-23-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:09:23 +0000
Message-Id: <20260706020925.422B21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Use-After-Free of `pcpu` in `scx_process_sync_ecaps` due to `r=
q_lock` being dropped
--

commit 93fedaa49ec9781e4eea1aa5bfcf150af020301b
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add sub_ecaps_updated() effective-cap change notifier

This commit adds a sub_ecaps_updated() callback to notify sub-schedulers
when effective caps change on a CPU. It runs in dispatch context so the
scheduler can directly insert or preempt tasks, and is hooked up with the
CPU hotplug machinery.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 3d488c1b0d599..deb4c802af83a 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -355,33 +357,140 @@ void scx_process_sync_ecaps(struct rq *rq)
>  	if (likely(llist_empty(&rq->scx.ecaps_to_sync)))
>  		return;
> =20
[ ... ]
> +		ecaps =3D calc_effective_caps(ps, cid);
> +		WRITE_ONCE(pcpu->ecaps, ecaps);
> +
> +		/* tell the sched its effective caps on this cid changed */
> +		if (ecaps !=3D pcpu->reported_ecaps &&
> +		    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
> +		    !scx_bypassing(pcpu->sch, cpu)) {
> +			struct scx_dsp_ctx *dspc =3D &pcpu->dsp_ctx;
> +
> +			dspc->rq =3D rq;
> +			/* stash @prev so nested dispatches can access it */
> +			rq->scx.sub_dispatch_prev =3D prev;
> +			SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq, scx_cpu_arg(cpu),
> +				    pcpu->reported_ecaps, ecaps);
> +			rq->scx.sub_dispatch_prev =3D NULL;
> +			scx_flush_dispatch_buf(pcpu->sch, rq);
> +			pcpu->reported_ecaps =3D ecaps;

[Severity: Critical]
Can this write cause a use-after-free of pcpu if scx_flush_dispatch_buf()
temporarily drops the rq lock?

If the sub_ecaps_updated() callback dispatches a task from a remote
runqueue, scx_flush_dispatch_buf() -> dispatch_to_local_dsq() can
temporarily drop the local rq lock:

kernel/sched/ext/ext.c:dispatch_to_local_dsq() {
    ...
    if (locked_rq !=3D src_rq) {
        raw_spin_rq_unlock(locked_rq);
        locked_rq =3D src_rq;
        raw_spin_rq_lock(src_rq);
    }
    ...
}

If a concurrent detachment is waiting in scx_discard_ecaps_to_sync(), it
could observe the node off-list while the rq lock is dropped here:

> @@ -371,11 +480,29 @@ void scx_discard_ecaps_to_sync(s32 cpu, struct scx_=
sched_pcpu *pcpu)
>  {
> -	scoped_guard (rq_lock_irqsave, cpu_rq(cpu))
> -		scx_process_sync_ecaps(cpu_rq(cpu));
> +	struct rq *rq =3D cpu_rq(cpu);
> =20
> -	WARN_ON_ONCE(llist_on_list(&pcpu->ecaps_to_sync_node));
> +	while (true) {
> +		scoped_guard (rq_lock_irqsave, rq) {
> +			/*
> +			 * scx_process_sync_ecaps() takes the node off the list
> +			 * before it is done accessing @pcpu but does all of it
> +			 * under the rq lock. Off-list observed under the rq
> +			 * lock guarantees that the sync is complete.
> +			 */
> +			if (!llist_on_list(&pcpu->ecaps_to_sync_node))
> +				return;

If scx_discard_ecaps_to_sync() returns and frees pcpu while the rq lock
is dropped, the assignment to pcpu->reported_ecaps upon returning from
scx_flush_dispatch_buf() will write to freed memory.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D22
