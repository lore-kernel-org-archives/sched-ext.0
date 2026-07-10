Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038D233927
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695755; cv=none; b=DKqppa2cWtFF4T9Wz4diYaHYi64cK+wpLBoges8+IC1Od1RAjPHdJcEHbKq0CLjJsSpnPT/TyA7Cy3IQSawSFlJgDbCxU1taLMAyKuGqcnO1REBIhw1aaJNIV8O7sN5SItoCaCWaCqqSicUYa+LL5T6SHqpr7Mfr38LLJNqdO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695755; c=relaxed/simple;
	bh=pydYEl7TyYMTym2BOxaLC6bH/9KmIXUlFjeIVfe2b/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BRBL3bnECdJdkiDSJ+xnAIhDLQGhgb4lgrCJ1hlfVHRjll18l1bWW2nItIqI7y1bwTdtlehqpxxd75rThim9uPme8pY2Qu1BA70EVcxERWfuDGTJwX3M9E4CQeUIyUihekYsptHV99WleD8i/hTVTQfStg8ooG/mKTtGZLMt+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFmoaRye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFmoaRye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4611F000E9;
	Fri, 10 Jul 2026 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783695753;
	bh=lxp1QCksAWhwBEesfpINBB/yGSsm+YwYytY0bZguhAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PFmoaRyeMTJHaRuPmjL3SDafDFlQAynTq6sHPruGz49Xf1HGvCUHMfhw3dyhBhnST
	 zhw3map6UlWhD4XBWxKC9fYQRIlOdc+1trWpWN/8qro073gpYNIVyrVDJbrkGmTfcm
	 b/EYMrfM55cEYGgEU2qidKicDc+fKhZQfAWWWM9S1p8buyHMsCS+CFMPA3iC2zk8rx
	 UsjMBX6krdOhZQIsycOTwYMuFAjuFKz+3ZLr5rBCsTvYiUoYSSacBkoIxgfJ/Myc9a
	 jjO6oO0Q6Yjc+KKzxCWftz95H15zB26pHwBAo4KOqV3DYUl7DG+ChOdKLE4BMbXzFI
	 0Cr0UpoL/BKbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3] sched_ext: skip ops.set_weight() for
 disabled tasks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuba Piecuch" <jpiecuch@google.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260710144342.3802587-1-jpiecuch@google.com>
References: <20260710144342.3802587-1-jpiecuch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 15:02:32 +0000
Message-Id: <20260710150233.7F4611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] reweight_task_scx() fails to update p->se.load, causing tasks to h=
ave permanently stale load weights when their priority changes or when tran=
sitioning from sched_ext back to sched_fair (CFS).
--

--- Patch [1]: [PATCH sched_ext/for-7.3] sched_ext: skip ops.set_weight() f=
or disabled tasks ---
commit 009696d9cb0a5605e8759533b00b9204ec011c72
Author: Kuba Piecuch <jpiecuch@google.com>

sched_ext: skip ops.set_weight() for disabled tasks

When switching a task's sched_class away from sched_ext, ops.set_weight()
is currently called after ops.disable(). This commit skips the weight
adjustment for disabled tasks to respect the expected callback semantics,
allowing the weight to be recalculated later if the task rejoins SCX.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 691d53fe0f648..ff22f31594c5c 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3925,6 +3925,17 @@ static void reweight_task_scx(struct rq *rq, struc=
t task_struct *p,
>  	if (task_dead_and_done(p))
>  		return;
> =20
> +	/*
> +	 * When switching sched_class away from SCX, reweight_task_scx()
> +	 * is called _after_ scx_disable_task(). Skip calling ops.set_weight()
> +	 * since the BPF scheduler may have already forgotten the task in
> +	 * ops.disable().
> +	 * p->scx.weight will be recalculated in scx_enable_task() if the task
> +	 * ever returns to SCX class.
> +	 */
> +	if (scx_get_task_state(p) !=3D SCX_TASK_ENABLED)
> +		return;
> +
>  	p->scx.weight =3D sched_weight_to_cgroup(scale_load_down(lw->weight));
>  	if (SCX_HAS_OP(sch, set_weight))
>  		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);

[Severity: High]
This is a pre-existing issue, but does reweight_task_scx() need to update
p->se.load as well?

Looking at set_load_weight() in kernel/sched/core.c, it delegates the load
weight update to the current scheduling class's callback if available:

kernel/sched/core.c:set_load_weight() {
	...
	if (update_load && p->sched_class->reweight_task)
		p->sched_class->reweight_task(task_rq(p), p, &lw);
	else
		p->se.load =3D lw;
	...
}

When a task's priority is modified while it is in the sched_ext class,
set_load_weight() calls reweight_task_scx(). Because reweight_task_scx()
only updates p->scx.weight and entirely skips updating p->se.load, does the
CFS entity end up with a permanently stale load weight?

If the task's scheduling policy is later switched back to sched_fair, it
seems it would enter CFS with this incorrect load weight. Could this bypass
nice limits and break CFS fairness since the load weight dictates the task's
share of CPU time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710144342.3802=
587-1-jpiecuch@google.com?part=3D1
