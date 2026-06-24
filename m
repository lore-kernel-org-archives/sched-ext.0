Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23B3AD525
	for <sched-ext@lists.linux.dev>; Wed, 24 Jun 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311238; cv=none; b=qEFK3akbihnnJr56oJsL7gtKW4cg87hMg1bZxRagUZJEo2DC7G3GJShCXMpm5rB9Q2DLZfapmN62w4bm0+W755TDuhrhUAQxuYgpNUJMLLtO9dzh5zPdUS+lPAWVYQy0NHn5121qZAEQLME9yBwqbtbRb+RRxIHuE2a5gpAzzKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311238; c=relaxed/simple;
	bh=585FsCYBPGHW+VeYrF6duev3wS5vMkN7D3rDd+Xylb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FEVRqXPulB4O1kTCVVomqEvkb7Lhzv1rWuqReE0gVBx2iUhHg3mtci+nCKzbZTnvuBg8W4LoBfncK0IRgBsbY2Bxi9/IcI8a0JnHTDuI3Ak+gTEOgfOe9+3LML/puShSNq9KBwt2ZGBNu0GC+qYN2rKEstgDe+lfGOyRRXg6b1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxL6zJtI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxL6zJtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B161F000E9;
	Wed, 24 Jun 2026 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782311237;
	bh=XzewmIYBXd7F69/jqg2yoN2hPg/yrfFMV3brH17Cnd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxL6zJtIgCPb6KoF9lMuv3kzGxOtjvxctHPPosd3OMdNKknpXAnBaCtB0rlQB3/3W
	 9GvDgAHSQSKXRN3QcW5KbMU/BOeEw18sp74GgzrmA5L8oYWp4tg38bIjABxD5CFTH0
	 qNm4id9GhWRO2qPVKw1kMLUlL7ag6i86/Bz+AGrRnHeZbgm3i4PYwnP+YqnkbiqGXy
	 M3PzpJbkUKUEJUVO3LanGvV3RGaMk2iyJexsMqoISmksqhVDRPLpqGRfFdhsCMKODd
	 fFvS2mN2oaJGi41Hghiu3Q5ZPWhuW4ocWk2eOjwGF7M5ExbUjnOs6HHq07GYutVyLU
	 cGIxeEWqy880w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] sched: Use WARN_ON.*_DEFERRED()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260623142650.265721-3-bigeasy@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 14:27:16 +0000
Message-Id: <20260624142717.25B161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The fallback definition of `WARN_ON_DEFERRED` in `include/asm-gener=
ic/bug.h` contains a syntax error due to missing semicolons. By broadly int=
roducing this macro in the scheduler, this commit breaks the build on archi=
tectures that lack `__WARN_FLAGS`.

Pre-existing issues:
- [High] The patch fails to replace `WARN()`, `WARN_ONCE()`, and several `W=
ARN_ON_ONCE()` macros within the scheduler, leaving critical paths vulnerab=
le to the exact AB-BA deadlock the patch claims to fix.
--

commit a6aa09c317e0b91e99c786c88d0107e256973560
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: sched: Use WARN_ON.*_DEFERRED()

This patch replaces WARN and WARN_ON_ONCE macros within the scheduler with
their DEFERRED variants. This aims to prevent AB-BA deadlocks with legacy
consoles that might wake ksoftirqd while the runqueue lock is held.

Link: https://lore.kernel.org/all/20260610183621.3915271-1-vlad.wing@gmail.=
com

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b8871449d3c69..0e282457abb91 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -853,7 +853,7 @@ void update_rq_clock(struct rq *rq)
>  		return;
> =20
>  	if (sched_feat(WARN_DOUBLE_CLOCK))
> -		WARN_ON_ONCE(rq->clock_update_flags & RQCF_UPDATED);
> +		WARN_ON_ONCE_DEFERRED(rq->clock_update_flags & RQCF_UPDATED);

[Severity: Low]
Does this broad replacement break the build on architectures without
__WARN_FLAGS (like standard ARM32, MIPS, or SPARC)?

The fallback definition of WARN_ON_DEFERRED in include/asm-generic/bug.h
contains a syntax error due to missing semicolons:

	printk_deferred_enter()					\
	__WARN();						\
	printk_deferred_exit()					\

Using this macro here could cause syntax errors on those architectures.

[ ... ]

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5d2d19473a82e..47d3a4c16455a 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1855,7 +1855,7 @@ static void direct_dispatch(struct scx_sched *sch, =
struct task_struct *p,
>  			break;
>  		}
> =20
> -		WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
> +		WARN_ON_ONCE_DEFERRED(p->scx.dsq || !list_empty(&p->scx.dsq_list.node)=
);
>  		list_add_tail(&p->scx.dsq_list.node,

[Severity: High]
This is a pre-existing issue, but since the goal is to prevent deadlocks
by replacing warnings while runqueue locks are held, did we miss the
WARN_ONCE right above this in the same function?

kernel/sched/ext.c:direct_dispatch() {
    ...
    default:
        WARN_ONCE(true, "sched_ext: %s[%d] has invalid ops state...",
                  p->comm, p->pid, opss);
        atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
        break;
    }

    WARN_ON_ONCE_DEFERRED(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
    ...
}

There are several other missed WARN and WARN_ONCE calls in the scheduler
that are also called with locks held. Could these trigger the same AB-BA
deadlock if they fire?

For example:
- finish_task_switch() in kernel/sched/core.c (with rq lock held)
- proxy_force_return() in kernel/sched/core.c (with pi_lock and rq_lock hel=
d)
- sched_cpu_dying() in kernel/sched/core.c (with rq lock held)
- sched_core_cpu_starting() in kernel/sched/core.c (with core_lock held)
- scx_set_task_state() in kernel/sched/ext.c (with rq lock held)
- assert_task_ready_or_enabled() in kernel/sched/ext.c (with rq lock held)

Would it be better to audit and replace these remaining macros as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623142650.2657=
21-1-bigeasy@linutronix.de?part=3D2
