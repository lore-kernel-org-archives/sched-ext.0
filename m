Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA643C07E
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961075; cv=none; b=pNxRywCj800PLiH8LsZ0Gt2tzGKGUXKpwK0XF8VOtbHoQrK+nJ5+jMxk6LT4OqKDoPyipzta3tQX9n6A+SuwQKwD/fbP+ggVJgKL2cCOxHvMg2DfX4hEe9+vK05WFmDE1ZSW7fkcBJlYkhTbedtCAu+JpiErVYN4hpyJpgfSe5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961075; c=relaxed/simple;
	bh=CE2cYyC4qXYqBgkR3Luctgrdl8rEfMrHAe6lyxttIas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bi9vt2Qb1tiGu5YWTc0xLzlN2AsCubqcHs3CxXDFm0lO1Hu8wZt6dIh0BkqHJ6MSzBhCi2r2x0HUw5YIidNByqq6kNiMUDFtyExy7CtRPHJHCgSgYXDMbww2WhU2iYf3GPye/pIWN7fuC1nKPJn3t0vdZjcpc7TZztP37LWx8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqjcJiAh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqjcJiAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93EE1F000E9;
	Mon, 13 Jul 2026 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783961074;
	bh=EaSQgrKtP06KIFrre7TKIAEldwY+VznOLIPD8buR4x8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DqjcJiAhvrHixzKV1DYiXG5y3ijfJElV/U+2O+kaMJ7Rux2n7i1vhizn0xrlBHO1N
	 OnGcGay5yPYBt1nykRWxXloPEkBGJOWiz9b1IHzyiaCeS6eVIM2FR27Q7S8UkEAeXe
	 z6ugJ32sCd5f5P506Xzh84Tzba+ovdcvkjee8C4fWQ3un/A2LNLB+5IEyrifOYEwfS
	 E/feG6tw9SGuCjhttmlEbGlS7rPSxCc0Lg8jaXqVGf+JMbdMM3Cj30YbrKW4mPLhVX
	 IgkyHJJnJnoof85ulPdLAqgqufqzeLP2dlH7oQSRr+nw/YQK4O/+wbPtGIWDExRIPs
	 j7t8VY5wCV/QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] sched_ext: Handle blocked donor migration with
 proxy execution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260713162112.26785-7-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
 <20260713162112.26785-7-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:44:33 +0000
Message-Id: <20260713164433.C93EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional enqueue of blocked proxy donors to the tail of the l=
ocal DSQ causes priority inversion, escapes BPF scheduling quotas, and trig=
gers kernel warnings.
--

--- Patch [6]: [PATCH 06/10] sched_ext: Handle blocked donor migration with=
 proxy execution ---
commit dce762461a67fc44d618711fc879bc542af59027
Author: John Stultz <jstultz@google.com>

sched_ext: Handle blocked donor migration with proxy execution

This commit enables sched_ext to handle the migration of blocked donors
under proxy execution. It allows normal migration of non-active blocked
donors and ensures they remain on the local DSQ when put, maintaining
visibility for the proxy pick path.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 840d61ee24e74..1f05f91e55192 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -2873,6 +2886,22 @@ static void put_prev_task_scx(struct rq *rq, struc=
t task_struct *p,
>  	if (p->scx.flags & SCX_TASK_QUEUED) {
>  		set_task_runnable(rq, p);
> =20
> +		/*
> +		 * Mutex-blocked donors stay queued on the runqueue under proxy
> +		 * execution, but the donor never runs as itself, proxy-exec
> +		 * walks the blocked_on chain on the next __schedule() and runs
> +		 * the lock owner in its place.
> +		 *
> +		 * Put the donor on the local DSQ directly so pick_next_task()
> +		 * can still see it. find_proxy_task() will either run the chain
> +		 * owner or deactivate the donor so the wakeup path can return it
> +		 * and let BPF make a new dispatch decision once it is unblocked.
> +		 */
> +		if (p->is_blocked) {
> +			scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);

[Severity: High]
By unconditionally passing 0 (tail enqueue) to scx_dispatch_enqueue() for
preempted proxy donors, does this cause a priority inversion by defeating
proxy execution priority inheritance?

Furthermore, if a donor task exhausts its slice and is preempted here, does
this bypass the do_enqueue_task() fallback path? It seems zero-slice donors
would get trapped in the local DSQ instead of returning to the BPF
scheduler via ops.enqueue(), potentially triggering a kernel warning in
do_pick_task_scx() and artificially granting an unmonitored slice_dfl refill
that bypasses BPF quotas.

> +			goto switch_class;
> +		}
> +
>  		/*
>  		 * If @p has slice left and is being put, @p is getting
>  		 * preempted by a higher priority scheduler class or core-sched

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713162112.2678=
5-1-arighi@nvidia.com?part=3D6
