Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D927A107
	for <sched-ext@lists.linux.dev>; Thu, 14 May 2026 05:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734941; cv=none; b=EU6neMAd5x36b/p9k0mrYXClHhE2bFM4oXiGUlhgXpX1EqJADd+2JvsDYNfo9bx4x8yC8z8jllW+rfaEcUgyP5XMJeiH+KSTu3BdPOyJAWMbdN2EcRdH/RrM510DynPh+H71zOe1kHbK1XMo/mWb/yi3QJAmSgZ4a+oFLAJFzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734941; c=relaxed/simple;
	bh=czfP+0UGSm6E7tfJ2wD8iBsRJztQ5K/p2vb0DwC8zRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lIjpk2Mh1lkR8ap2OJ1Zer4Adq/uvpHjtneD4E3UgZNBa3KwwVf03C3bLFEH8jpujgDeyCY0JyDkaBUBnPFQAHBi3Do+P/xJnRqdp5g+cn5L49EBsHQuwKQHDrQC9bNCnKdrqjk/V04kIinJqK3/Yh1OmFPpIPzGWKRsA0QmmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOrbAjad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOrbAjad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56321C2BCB7;
	Thu, 14 May 2026 05:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734941;
	bh=czfP+0UGSm6E7tfJ2wD8iBsRJztQ5K/p2vb0DwC8zRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZOrbAjadkklq4zsK1GUPPf6VaVdj/SY1p3FWilq5XIQFYMdFC8juDogKf917MDCns
	 T7o0lTXqE5S1paUn1oYWY9kSCpZc1LxaaCW2WBeN/V1/zoCe+J3LPKtR8snT0JA2xU
	 uQ30tG0KfiBFeM6sHruwz+5rRNrZDdsq9uI98lVBI3cUd7oc/vVvGsAP6xwOubRQUA
	 +VIxtVipA93/vIbt0ChaVqThlFNH+yPz5Tn+WmRi4KJyULLm+MVPLW8cfEzNUf1DS9
	 px4yxNo7/9n5KqojYej92DRAYM5rPBdlXjRp/gytd6HPo4LuOBXpGENZf2RnSbYUi9
	 Mzsibk2WF0H7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.0.y] sched_ext: Skip tasks with stale task_rq in
 bypass_lb_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260513130111.689740-1-arighi@nvidia.com>
References: <20260513130111.689740-1-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 05:02:20 +0000
Message-Id: <20260514050221.56321C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unbounded lock hold time with IRQs disabled when skipping tasks in=
 `bypass_lb_cpu()`.
- [Low] Obsolete comment contradicts the new task_rq lock constraints.
--

commit 68327c3a383140f9157a96a24a7b23be2c135ac5
Author: Tejun Heo <tj@kernel.org>

sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu()

This commit updates bypass_lb_cpu() to skip tasks whose task_rq() does not
match the donor rq. These tasks were placed on the donor DSQ from a differe=
nt
CPU but haven't been consumed yet, preventing their migration without the
proper rq lock.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c

[ ... ]

>  	while ((p =3D n)) {
>  		struct rq *donee_rq;

[ ... ]

> +		/*
> +		 * If an earlier pass placed @p on @donor_dsq from a different
> +		 * CPU and the donee hasn't consumed it yet, @p is still on the
> +		 * previous CPU and task_rq(@p) !=3D @rq. @p can't be moved
> +		 * without its rq locked. Skip.
> +		 */
> +		if (task_rq(p) !=3D rq)
> +			continue;

Because this uses continue, does it bypass the lock-yielding check at the
bottom of the loop (if (!(nr_balanced % SCX_BYPASS_LB_BATCH)))?

If there is a large batch of unconsumed tasks left over from previous passe=
s,
could skipping them without incrementing nr_balanced result in an unbounded
loop?

Traversing a long list here while holding the rq lock and donor_dsq lock
with IRQs disabled could potentially cause latency spikes or trigger the
soft lockup watchdog.

>  		donee =3D cpumask_any_and_distribute(donee_mask, p->cpus_ptr);
>  		if (donee >=3D nr_cpu_ids)
>  			continue;
> =20
>  		donee_rq =3D cpu_rq(donee);
>  		donee_dsq =3D &donee_rq->scx.bypass_dsq;
> =20
>  		/*
>  		 * $p's rq is not locked but $p's DSQ lock protects its
>  		 * scheduling properties making this test safe.
>  		 */

This isn't a bug, but is this comment still accurate?

Since the function initially acquires raw_spin_rq_lock_irq(rq) and the
newly added check guarantees task_rq(p) =3D=3D rq, it appears the task's rq=
 is
actually locked when it reaches this point.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513130111.6897=
40-1-arighi@nvidia.com?part=3D1
