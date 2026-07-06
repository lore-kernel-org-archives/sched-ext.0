Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5339936B
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322522; cv=none; b=sc1RBa7GOP7bQSXb7JiDrtenPjR+OBfRuTQEiCROAD6Lo1/1puK9RlAG9dBKWI0LW3ui29gqGUcNlqU0jbktwR6FJnAaQuFF/U79LUdIJNV5Ag07GSypmtkz46lJgqaEdUGxQolAyTFx3etrQKl+chI4A+fmym3zlN9hYRtiQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322522; c=relaxed/simple;
	bh=Ogzkg0q2k2qZtJnvlwBIQnJQRUbgX7S7msEltJeecGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F1415LMfycZozyGXplSp0l+IwynBQMk5quk8mWRz4FcATiUQBqRCkJzao525G5h1hvNT0UtJEAB3fyk7JRVbrPDAbXFqoJFIAuC5AdlbSAOC++/LBMg+fhMlGGiS5QZsItGniR59W+tKnMXqw75hRii5NvxIC1lmqBBQCvR4Fwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9O1Bua9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9O1Bua9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7107F1F000E9;
	Mon,  6 Jul 2026 07:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783322515;
	bh=65P+zEmCsa0VzKAV8+zoxP0G5+7AAB1EmP7g62T//uc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9O1Bua96Zuq3I4y/Ro+h1oDzLnXGXwY8dNN5syKgIZLlJIvhXmQmIFuklj5Mz//N
	 tyF21aYPRCHWQQygE7W9/8rdHwn2/K6c9A8imEU2pPm4dnCtwt5AhL3lhjQDM5y7FR
	 E7vu2jl5cMZ2a57T9H1dQHBn1/oGkFHSmsDeFS33N95tOWkfLXxXtR4vgeX2kCi02j
	 YoKewuMRdli0rZBZDwoho5gJR++/e/rWb1nI2lSDOorHflB4bRGjltFnzMTvboDi66
	 r8R1YpBuCYZ0pASNuA5rKnGToipagTsaabzM04uzEb5zaTsEHhlQ+PIRI5TQjFQU6x
	 2Ap7tXu0HtGcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] sched_ext: Handle blocked donor migration with
 proxy execution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706070410.282826-5-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
 <20260706070410.282826-5-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 07:21:55 +0000
Message-Id: <20260706072155.7107F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Plain data race on `rq->donor` in `task_current_donor()` during =
lockless evaluation triggers KCSAN warnings.
--

commit 6a880849b19162c80e0a10e017da8716e5ef3566
Author: John Stultz <jstultz@google.com>

sched_ext: Handle blocked donor migration with proxy execution

With proxy execution enabled, mutex-blocked donors stay runnable so
their scheduling context can execute the lock owner. This commit allows
normal sched_ext migration of blocked donors unless the donor is active
on its rq.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 4c6cd694c86db..e7cf88b2be7f6 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -2156,6 +2156,18 @@ static bool task_can_run_on_remote_rq(struct scx_s=
ched *sch,
>  	if (task_on_cpu(task_rq(p), p))
>  		return false;
> =20
> +	/*
> +	 * A blocked donor may be moved normally to select a new callback rq.
> +	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
> +	 * callback home, even if the donor was previously proxy-migrated.
> +	 *
> +	 * Don't move an active donor while the source rq still references it f=
or
> +	 * scheduling and accounting. The migration can be retried after the do=
nor
> +	 * is switched out.
> +	 */
> +	if (task_is_blocked(p) && task_current_donor(task_rq(p), p))

[Severity: Medium]
Will this trigger KCSAN warnings due to a data race on rq->donor?

When consume_dispatch_q() calls task_can_run_on_remote_rq() with enforce=3D=
false
as an opportunistic lockless check, it only holds dsq->lock, not the runque=
ue
lock for task_rq(p).

This causes task_current_donor() to perform a plain read of rq->donor:

kernel/sched/sched.h:task_current_donor() {
    return rq->donor =3D=3D p;
}

Since rq->donor can be concurrently modified by the runqueue's owner CPU,
the plain read violates the memory model. Even if it is logically safe
because the condition is re-evaluated later with the lock held, should
this be annotated with READ_ONCE() or data_race() to avoid KCSAN warnings?

> +		return false;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706070410.2828=
26-1-arighi@nvidia.com?part=3D4
