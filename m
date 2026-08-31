Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8DA443E53
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198549; cv=none; b=gYpqY4MniOmfnQgQ2Sh22NGq/HPvPzsqMqxUAlfy+8IVeUXJwCjs7GzQ5AIorsC/rlO8YP6029qXaNMKogq/vbzylWkiux1ZlpgiQKi5GIzfy0ZK/77yQ3H3F0nNmdNJUzdesiFTdgEBIzQA3Hzx5lOWiwyXfKbqiWXeHmgBTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198549; c=relaxed/simple;
	bh=J/GymL947ib10r33jDba6862McIbcHZEk4a+5bKinrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=We+AR52H81iZBPAaf7/TtG6+rY45GcYHDfmpeneGTJTrlnCNEbcuACrxN5/XJE5G86JZ0UCjhkdsfYPF7B1MP3iuhuWz3NG94yzpKfBIq8Z2ZJMwd873NsBysI0L8OP/3WTlIAa180GsDg8n4TsWY93U8g0WrEskq008nobSUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWrA9rPK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWrA9rPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F001F000E9;
	Mon, 31 Aug 2026 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788198548;
	bh=Iq2o0O8L3Q9Z7z2yJX/IUHKnyMOsdt1sRSp+sx1WqQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cWrA9rPKMnDOoLNEv0SlsfWYVtnanGhvvhGIOu2ba2komOltAKtYFl2z8plFGp0gh
	 w5JvmI+TasF3hUdQkjWvlukpCa4D0QNCkB7Tn58V6Q2xGD96tEDeEWn5rMa/vI5EYl
	 F2AVsiB6Z95I6CfnucjmtjUbs74x3GuieHC3p+8uXic+SUaaBdtxgJSSI0RXIBKfQz
	 7Cy0nXfHembSG5AYiNZPhHepl+PKT/PtL726RsObNvT69D/bzkTNspFYwS3hz98YAQ
	 wbPOnbcE5z8eHSY9xlryZaTuSrFy22n+dU0aIfgO8e+pM1UQd9/XrGx8qY/SFWHLyL
	 YaSMbhArCBUvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/18] sched_ext: Split curr|donor references properly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260831134338.1531664-15-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-15-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:49:07 +0000
Message-Id: <20260831174907.D6F001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The physical proxy execution owner is spuriously exposed to the BP=
F scheduler and loses its personal slice during SAVE/RESTORE cycles.
--

commit 9c0210f5a5bf78476570e1133b4136f7fc67852c
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Split curr|donor references properly

This commit separates the physical execution context (rq->curr) from the
scheduling context (rq->donor) to support proxy execution in sched_ext.
It updates various scheduler paths to use the donor where appropriate.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index b2e6be4a887de..f23e9f1ee2f3c 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -2170,13 +2177,14 @@ static void enqueue_task_scx(struct rq *rq, struc=
t task_struct *p, int core_enq_
>  		rq->scx.flags |=3D SCX_RQ_IN_WAKEUP;
> =20
>  	/*
> -	 * Restoring a running task will be immediately followed by
> -	 * set_next_task_scx() which expects the task to not be on the BPF
> +	 * Restoring the current scheduling context will be immediately followed
> +	 * by set_next_task_scx() which expects the task to not be on the BPF
>  	 * scheduler as tasks can only start running through local DSQs. Force
>  	 * direct-dispatch into the local DSQ by setting the sticky_cpu. Mark
>  	 * IGNORE_CAPS to force entry into the local DSQ.
>  	 */
> -	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p)) {
> +	if (unlikely(enq_flags & ENQUEUE_RESTORE) &&
> +	    task_current_donor(rq, p)) {

[Severity: High]
Does this check fail to recognize the physical execution context during
ENQUEUE_RESTORE?

During proxy execution, the currently executing task (rq->curr) and the don=
or
(rq->donor) are different. If a property change (such as sched_setscheduler=
 or
setpriority) is requested on the physically executing task while it is acti=
vely
running, it will undergo a DEQUEUE_SAVE / ENQUEUE_RESTORE cycle.

Because task_current_donor(rq, p) evaluates to false for the physically
executing task, wouldn't this bypass the SCX_ENQ_IGNORE_CAPS fast-path and
erroneously expose the actively executing task to ops.enqueue(), which viol=
ates
the constraint that physical execution contexts are not exposed to the BPF
scheduler?

[ ... ]
> @@ -2342,7 +2350,7 @@ static bool dequeue_task_scx(struct rq *rq, struct =
task_struct *p, int core_deq_
>  	p->scx.flags &=3D ~SCX_TASK_REENQ_REASON_MASK;
> =20
>  	/* see scx_task_slice_ended() for the save/restore exception */
> -	if (!((deq_flags & DEQUEUE_SAVE) && task_current(rq, p)))
> +	if (!((deq_flags & DEQUEUE_SAVE) && task_current_donor(rq, p)))
>  		scx_task_slice_ended(rq, p);

[Severity: High]
Similarly, does this fail to recognize the physical execution context during
DEQUEUE_SAVE?

If the physically executing task undergoes a DEQUEUE_SAVE cycle,
task_current_donor(rq, p) evaluates to false. Could this spuriously trigger
scx_task_slice_ended(), incorrectly zeroing out its personal slice while it=
 is
running on behalf of the donor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831134338.1531=
664-1-arighi@nvidia.com?part=3D14
