Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676530C146
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254436; cv=none; b=s//j9vOGXLwcJn5Rzy0VsyLu0nnMMJ0zXUpvU3DIbqC7xWjU8OhwgkGTr1ToObFT0LW9bbE470I7SOA2R7uspCZELjRmuuebKUXgRkLwAzXBoHJuXBBYGnNeMgVZEid7gl5uMhKrmWzvv/4lcnD08Cqy9bB7Zqo3WkTtbuuka/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254436; c=relaxed/simple;
	bh=kBdWl63aU05+mUvynttoyPGITp5YICweKueKiEBeYrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ss/4qb76kk1HvGcQ8Io6hlQujuww+ExbNByW+RxzUvetypz4biohJpgt6f2ZrXEUPWqaVz3Y3IvocgE2+PxJdRtnDUi654MCJwJ5apNVF+rIsu/gd7NuH0dFFtwn6v+gYuAkFZ1V1DCb1oIOPADVNdr+SDhg5qfucHQL7txHk1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhGFLyMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhGFLyMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192671F000E9;
	Tue, 28 Jul 2026 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785254435;
	bh=nEGiv5VaG/a12hjMgPzDNKcTjd8GUopa0W9vplR4sCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dhGFLyMHWtQj+VtW461OqPOrfUBZUXzcK651jAC8ZKM028S0XomepO8tUtkbQXawv
	 ZMEMnsTn6f9MPodYTLVNqw2IlqpGCAcJmT0PQ7T7txDhu4mtDUUQTEAmRL42/h1579
	 Ctk+6o/tcqBOtdroWC61R9/VX3Ed4Kf8eOzF65V2mEZEdc+hiDNtAQJAYkKDs/9dC1
	 yYmV80+DwhVAmDDfKYX1GkYGoEpNegCGhWzpdGKErqWhUlmbl5o+4y7cWZOIocNZrj
	 Q6ZXu6aEYSbZrrOhleIvGjETEo8H0X810+DJ/LRqH/QKSYIJuLDI6ReJ1m1kk6pNaY
	 FJntY4V/Y4cDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] sched_ext: Generalize the reject DSQ reenqueue
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260728154425.1549660-10-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-10-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:00:34 +0000
Message-Id: <20260728160035.192671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Transient failure to set a reject reason leaves the task permanent=
ly stranded on the reject DSQ.
--

--- Patch [9]: [PATCH 09/15] sched_ext: Generalize the reject DSQ reenqueue=
 path ---
commit b71cb24d29b22c40aa0f3482e228cd8cd043d267
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Generalize the reject DSQ reenqueue path

This commit makes the reject DSQ unconditional and moves its drain path into
the core sched_ext implementation. It also records the reenqueue reason on
each parked task to support future proxy execution features.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -4399,6 +4401,57 @@ static void process_deferred_reenq_users(struct rq=
 *rq)
[ ... ]
> +static void scx_reenq_reject(struct rq *rq)
> +{
[ ... ]
> +	/*
> +	 * Move tasks to a private list so a task re-rejected by
> +	 * scx_do_enqueue_task() below isn't revisited this round.
> +	 */
> +	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.n=
ode) {
> +		u32 reason =3D p->scx.reject_reason;
> +
> +		/* migration_pending tasks should have bypassed to local DSQ */
> +		if (WARN_ON_ONCE(p->migration_pending))
> +			continue;
> +		if (WARN_ON_ONCE(!reason))
> +			continue;

[Severity: High]
If !reason is true and this WARN_ON_ONCE triggers, will this continue
statement leave the task permanently stranded on the reject DSQ list?

Because the continue bypasses scx_dispatch_dequeue() and the subsequent
list_add_tail(), the task is never unlinked from rq->scx.reject_dsq.list.

Since the reject DSQ is just a staging list, the task won't be scheduled,
and every subsequent run of scx_reenq_reject() will hit this continue again.

Should this error path safely recover the task (perhaps by falling back to
the local DSQ) or at least unlink it instead of leaving it in an unrecovera=
ble
hung state?

> +
> +		scx_dispatch_dequeue(rq, p);
> +		p->scx.reject_reason =3D SCX_TASK_REENQ_NONE;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728154425.1549=
660-1-arighi@nvidia.com?part=3D9
