Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B0432E73
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618040; cv=none; b=KUnlft4zVy4FwdBijwROgKUGVPKiWnWuT+iKQM/e69oTuJNeFmqXRuJ7upebpx19dhGIWa1Plnt0DeHEgE2jv1CiRIHWBTmnG1z/BdfUkM0lgDx5L4ysvJE0j9vBJJrW0AtRKb/RcdJ6yxqNOLN+gozL2bsOsA4JIQF8bGfcVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618040; c=relaxed/simple;
	bh=PBKJ4ULdIv925MDmdgfUENHulo7mt6LZEYiR11lmJu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P/hA2kXdVfVuWeUoKdL2q2bYYnw8jLoPz7IeN6bhZpmJeNQFBRm6/yB1xNSoyhJeaHsIgnAgaEvyBdrZqPdPszZU9Jg5C2h57Xx8l86PCOXRzfcIKQ/O43Yrf09Ci5GEn2gLuPm+jukzaqkkjaJkqaAcfkUOXGR0kyM7SGstqaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC6+Fb/p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC6+Fb/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44411F000E9;
	Tue, 21 Jul 2026 07:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618039;
	bh=ILS5yCXGeuFO/gDT46agrQ3y/6RM9sybVofSY+vaSRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SC6+Fb/phtvg2wGyx1UEz7or/8JkkqWvxSCdEAi4iwcgHra8UzCbZJXB4mdsebFWU
	 FtYQkuEvemq3KxCAFttXWm2WUsDH0DtCQL+SrB6FAzHNM8MPx/jmIWtOTRV2LlKUU1
	 JemTlyALURiO8ZG26idCsms8wglH3IbBCagHbhUDVQuqVfGzNFGaSmeP413/QFMkhz
	 sI3rnK3B+rexjQ6omDXcLaQLMBYJ48sFosbnuYmtK1Ec6GpWQ+vljDWH9QiiLJWdJI
	 HcB20slgoKIn77kJ2AAAuuWY61HoPZ/a+zgTFgJv1MYQ6kabuoj7JSwZiuWJCJpfoX
	 Ewbeh1VDqeDFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] sched: Make NOHZ CFS bandwidth checks follow
 proxy donor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260721063242.552774-3-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
 <20260721063242.552774-3-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:13:58 +0000
Message-Id: <20260721071358.E44411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to remove the `rq->nr_running !=3D 1` restriction =
from `sched_fair_update_stop_tick()`, leaving proxy execution bandwidth enf=
orcement broken during context switches.
--

--- Patch [2]: [PATCH 02/12] sched: Make NOHZ CFS bandwidth checks follow p=
roxy donor ---
commit 4af18b2dbe3d9116ee4049aa70ca4c8662c0104c
Author: Andrea Righi <arighi@nvidia.com>

sched: Make NOHZ CFS bandwidth checks follow proxy donor

Proxy execution separates the scheduling context in rq->donor from the
physical execution context in rq->curr. sched_can_stop_tick() checks the
latter for CFS bandwidth constraints and only does so when nr_running is
one. A retained proxy donor keeps both the donor and mutex owner queued,
so this patch checks the selected donor instead and removes the
nr_running restriction.

Link: https://lore.kernel.org/r/20260713164807.E5ED21F00A3A@smtp.kernel.org

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f788b72d1bfff..35d41d45e365e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1409,11 +1409,8 @@ static void nohz_csd_func(void *info)
>  #endif /* CONFIG_NO_HZ_COMMON */
> =20
>  #ifdef CONFIG_NO_HZ_FULL
> -static inline bool __need_bw_check(struct rq *rq, struct task_struct *p)
> +static inline bool __need_bw_check(struct task_struct *p)
>  {
> -	if (rq->nr_running !=3D 1)
> -		return false;
> -

[Severity: High]
This is a pre-existing issue, but does removing this restriction here fully
resolve the proxy execution bandwidth enforcement bug?

Looking at sched_fair_update_stop_tick() in kernel/sched/fair.c, there is an
identical check that prevents tick updates when nr_running !=3D 1:

kernel/sched/fair.c:sched_fair_update_stop_tick() {
	if (rq->nr_running !=3D 1)
		return;
	...
}

If a constrained FAIR task donates its scheduling context to a lower-priori=
ty
task (like an SCX task) via proxy execution, nr_running becomes >=3D 2 while
h_nr_queued remains 1.

During enqueue, sched_can_stop_tick() evaluates against the old rq->donor
(e.g., the idle task) and may clear the tick dependency. When the scheduler
picks the FAIR donor, sched_fair_update_stop_tick() returns early because
rq->nr_running !=3D 1.

Can this result in the tick remaining cleared, allowing a constrained FAIR
task to bypass its CFS bandwidth quota?

Should the nr_running restriction in sched_fair_update_stop_tick() also be
removed or updated to properly account for proxy execution?

>  	if (p->sched_class !=3D &fair_sched_class)
>  		return false;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721063242.5527=
74-1-arighi@nvidia.com?part=3D2
