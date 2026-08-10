Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32154331EBA
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377337; cv=none; b=j5JRrKMv9+zxNG2+pPcTeTXlPRZiSdTlKUw1aZwCiMC3PX6AcQYYKJltxssHh6w3hq+jqr/gf8VVgQywr3GJ1zbQWIhi8pwqF8TcT700CFB9UVY4oOAHLlrVb2aY0/O8QxMQ+ymzfguyTG4og1qjcFGrxgVW4LN3MihwVsFk6s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377337; c=relaxed/simple;
	bh=sukiAmRMFCKxSV6OWCKw9pNBUij3am/6MzoKozP5FYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CqKmcu7/O8z65se0tKK1Nusth3gprtCQw0e+MZDnjDpWhPRee7rOnKvO0RzeAHUxu172nxBT2MBIniW8ep7gAIz2RfuczBp3AW5wSBco34wyJuhgk5Ge5+yMCRBpjBSFZnt3PLnJ1mpZEfFq25mzO+XFxL75Hs+NF3ne+9r7Zg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBp1yAoX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBp1yAoX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27801F000E9;
	Mon, 10 Aug 2026 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786377335;
	bh=FBbwhpuKuq2NHl9SO5NvAb9cq83ubtY/OsMW0OwvIUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZBp1yAoXzguv2giwyS1ubbUiVOW7NSkeC1TTES//dEXbgpZhRqWu/KmhWJh1uGF4v
	 UFIrMoy+B9djZHD3L3mNR3EfSvkC+k3CAgVFHhV9VP5ChQs0G6JfMDVfOC+hlQvBFm
	 M+bRf7ZWFiSiQPi01lTFA1J01T4NPnAkThnIfPtwOUJdbT6hYsy4NXUrXyVm/4z2YG
	 cHcp0RyawCaqaPVYQy8ab9LL0vJ3G4dAkz8zNQxghzh9lSxCKZncA4cPkOXhheXbNw
	 04O402vTjB9gbvwookmy+cxvHBdKx/BdlEvv7eW96ImBQC1Uo0ano9LOh9nZl+Hd8T
	 nwhALC8vLt1Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] sched_ext: Generalize the reject DSQ reenqueue
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260810151523.86994-10-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
 <20260810151523.86994-10-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 15:55:34 +0000
Message-Id: <20260810155534.D27801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Re-rejecting a task triggers false-positive `WARN_ON_ONCE`s and pe=
rmanently loses the rejection reason due to conflicting mask management.
--

--- Patch [9]: [PATCH 09/15] sched_ext: Generalize the reject DSQ reenqueue=
 path ---
commit 0787bee4f7073d43925067d6fff35bd1a30ed061
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Generalize the reject DSQ reenqueue path

This commit generalizes the reject DSQ re-enqueue path by making it
unconditional and carrying the re-enqueue reason directly in p->scx.flags.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -4598,23 +4600,22 @@ static void scx_reenq_reject(struct rq *rq)
> =20
>  	lockdep_assert_rq_held(rq);
> =20
> -	if (!scx_has_subs() || list_empty(&rq->scx.reject_dsq.list))
> +	if (list_empty(&rq->scx.reject_dsq.list))
>  		return;
> =20
>  	/*
> -	 * Move to a private list so a task re-rejected by the
> +	 * Move tasks to a private list so a task re-rejected by
>  	 * scx_do_enqueue_task() below isn't revisited this round.
>  	 */
>  	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.n=
ode) {
> +		u32 reason =3D p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
> +
>  		/* migration_pending tasks should have bypassed to local DSQ */
> -		if (WARN_ON_ONCE(p->migration_pending))
> -			continue;
> +		WARN_ON_ONCE(p->migration_pending);
> +		WARN_ON_ONCE(!reason);

[Severity: High]
Will this WARN_ON_ONCE(!reason) trigger on the next tick if a task is
synchronously re-rejected during scx_do_enqueue_task()?

When a task is pushed back to the reject_dsq during the enqueue attempt,
its rejection reason mask seems to get cleared immediately after by the code
below, leaving the reason as 0 on the next drain.

> =20
>  		scx_dispatch_dequeue(rq, p);
> -
> -		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
> -			p->scx.flags &=3D ~SCX_TASK_REENQ_REASON_MASK;
> -		p->scx.flags |=3D SCX_TASK_REENQ_CAP;
> +		p->scx.flags |=3D reason;
> =20
>  		list_add_tail(&p->scx.dsq_list.node, &tasks);
>  	}
> @@ -4627,9 +4628,6 @@ static void scx_reenq_reject(struct rq *rq)
>  		p->scx.flags &=3D ~SCX_TASK_REENQ_REASON_MASK;

[Severity: High]
Does unconditionally clearing the mask here corrupt the state of newly
re-rejected tasks that were just put back on the reject_dsq?

If scx_do_enqueue_task() re-rejects the task, it gets pushed back via
scx_resolve_local_dsq().

Clearing the mask here wipes out the rejection reason while the task sits
on the reject_dsq. Without a valid rejection reason, the BPF scheduler
cannot correct the placement (e.g., missing capabilities).

Could this lead to repeated rejections until the task hits
SCX_REENQ_MAX_REPEAT, triggering __scx_exit() and crashing the BPF schedule=
r?

A similar issue seems to exist in reenq_local(), where the mask is also
unconditionally cleared after scx_do_enqueue_task() returns.

>  	}
>  }
> -#else
> -static void scx_reenq_reject(struct rq *rq) {}
> -#endif

[ ... ]

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -752,6 +752,9 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct s=
cx_sched *sch, struct rq *r
> =20
>  	p->scx.reenq_reason_caps =3D missing;
>  	p->scx.reenq_reason_cid =3D cid;
> +	if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
> +		p->scx.flags &=3D ~SCX_TASK_REENQ_REASON_MASK;
> +	p->scx.flags |=3D SCX_TASK_REENQ_CAP;

[Severity: High]
Will this WARN_ON_ONCE fire incorrectly on valid re-rejections?

scx_reenq_reject() deliberately preserves the reason mask prior to the
enqueue attempt. If a task gets synchronously re-rejected here, it will
still have its mask set, which triggers this warning.

> =20
>  	return &rq->scx.reject_dsq;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810151523.8699=
4-1-arighi@nvidia.com?part=3D9
