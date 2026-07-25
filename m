Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1E82FF657
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784996724; cv=none; b=kzGnEcmEimPczs9I4if77W8E+Is5tCx9lvrrjCkNklt5n50oXxWRxmVMLpTig70k95Ab6fm5zCgVw/ChQQzD+NjO+Ksq3++PC4ND98S1Juxa41aAwotW3nSnElYbtsiRjEcD7/XuGOtHYfsSLVkn6Xm1AwmCm87qJ1XWoLY9sRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784996724; c=relaxed/simple;
	bh=Xi798Zt5nWIGti3MPgaLyXBLBGKZP31IQ6dQFlOSgos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jVy9GLSu1KP8qcyVfIV9q7NVZnAz680j3SR02mLQ+mPd6wg2J0BSdBzL9tl8gqQxQRW8ya478Sne62R4d5rSgDUOME1qL/yOs/jhrrwl0wrki/fIdEmL+vaC3H1Iq7hSDbdqD9Cb3aF7D691EsgQWulwJ36kN9BKBMTAey+lWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNLTBaN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNLTBaN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F1A1F00A3A;
	Sat, 25 Jul 2026 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784996723;
	bh=KJXA+ACHY1kAvj9wRR54lRfHGo4SaNmvEyiZ4FpHJ5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NNLTBaN6pbx7VIHr+njTB7nkLd0m5aSdsrRlVJ3BTIoz2dZIA6llZZFcM3qsUfrss
	 8NgifE36H6X7zWPsae5sUqB0PXDkrjnuoB1xGgnZmWPfg5pC+lj/6X5kLWHtn2bhw2
	 Lien0SzIuThw46vYDcxndwM4TvvPxe7pi4Px/ZzN9wSawIGhbXhrul0L1w3nKUsy8a
	 w/mYprVc647PlHdKqL0E0QcTbj6u6Bz0eWShCbiEEJYU64FUpDIkIbhgHQAssbCVQk
	 yEpfYR0pA1SwmQG3Ktc2CB8clVDMi0qolsv0Xey1ehRZ1ICkZIU4lJYwp3wTEnePCW
	 Yz8MFXCxv9wqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/14] sched: Add prepare_switch() class callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260725160513.57477-5-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
 <20260725160513.57477-5-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 16:25:23 +0000
Message-Id: <20260725162523.85F1A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `prepare_switch()` callback is invoked on the incoming `next=
_class`, but the task may never actually transition to that class if `SCHED=
_FLAG_KEEP_PARAMS` is set, leaving the prepared state orphaned and leaking =
resources.
--

--- Patch [4]: [PATCH 04/14] sched: Add prepare_switch() class callback ---
commit f8056ba7bb47e84cdf2c8a5193c3485b3b2d44d0
Author: Andrea Righi <arighi@nvidia.com>

sched: Add prepare_switch() class callback

This commit introduces a prepare_switch() callback for scheduling classes.
It allows an incoming class to prepare a task while the state is still
live, before the normal dequeue and class transition take place.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 37c87783439f5..66e9ba50f5639 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
[ ... ]
> @@ -11221,7 +11221,9 @@ static inline void sched_mm_cid_fork(struct task_=
struct *t) { }
> =20
>  static DEFINE_PER_CPU(struct sched_change_ctx, sched_change_ctx);
> =20
> -struct sched_change_ctx *sched_change_begin(struct task_struct *p, unsig=
ned int flags)
> +struct sched_change_ctx *
> +sched_change_begin(struct task_struct *p, const struct sched_class *next=
_class,
> +		   unsigned int flags)
>  {
>  	struct sched_change_ctx *ctx =3D this_cpu_ptr(&sched_change_ctx);
>  	struct rq *rq =3D task_rq(p);
> @@ -11239,6 +11241,10 @@ struct sched_change_ctx *sched_change_begin(stru=
ct task_struct *p, unsigned int
>  		flags |=3D DEQUEUE_NOCLOCK;
>  	}
> =20
> +	if ((flags & DEQUEUE_CLASS) && next_class !=3D p->sched_class &&
> +	    next_class->prepare_switch)
> +		next_class->prepare_switch(rq, p);
> +
>  	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
>  		p->sched_class->switching_from(rq, p);
> =20
[ ... ]
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index b215b0ead9a60..bc32ce76ff4fe 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
[ ... ]
> @@ -678,7 +678,7 @@ int __sched_setscheduler(struct task_struct *p,
>  	if (prev_class !=3D next_class)
>  		queue_flags |=3D DEQUEUE_CLASS;
> =20
> -	scoped_guard (sched_change, p, queue_flags) {
> +	scoped_guard (sched_change, p, next_class, queue_flags) {
> =20
>  		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
>  			__setscheduler_params(p, attr);

[Severity: Medium]
Will this leak resources if a user calls sched_setattr() with a new policy =
and
sets attr.sched_flags =3D SCHED_FLAG_KEEP_PARAMS?

In __sched_setscheduler(), if SCHED_FLAG_KEEP_PARAMS is set, the class
assignment p->sched_class =3D next_class is explicitly skipped.

However, because queue_flags includes DEQUEUE_CLASS, the newly modified
sched_change_begin() unconditionally invokes next_class->prepare_switch(rq,=
 p)
for the incoming class.

Because the task never actually transitions to next_class, does this leave
the prepared state dangling and resources leaked since there won't be a
matching cleanup or transition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725160513.5747=
7-1-arighi@nvidia.com?part=3D4
