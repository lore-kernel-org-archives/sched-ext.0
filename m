Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158AE81ACD
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214174; cv=none; b=kGD9XxcX/1xfhjuB5s/b+0N07seIa9U/N/2fMZ9gSKTdmWoN2q5sxjYNPD7MVIscmNd7rdtwtFRlfFrLiip0j1QECVnlcJ6pPuwlQzkl1ecKqG9jjYxGR3HiAixMfkSnRFk+fODG+edjQ09pstFDn6fpCm6Q+ft6DXFRugpy+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214174; c=relaxed/simple;
	bh=iBmgCuY8N7FDL6U1rERzHgQsD3rLw8ai+TOpKr13vCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ku3+pn5y3aVvn3U9raSyMmv2b0fTmxAqq6kNmCeKEqrTkKSe2Sj4aP7UovJmxNjdGzqDM2iBosUcyrLfrhwLiDcE3bUe8or/Bz7pEUazMl+CqFJvVc+2A9CQHat8aisjdBY/RhjFVivqCLNF3cr3MKfhfd7/6BcsGmmqqixZAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhbcQr6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhbcQr6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BAD1F000E9;
	Thu, 16 Jul 2026 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784214172;
	bh=ObVfdYnaEcom0DZzYC6f7yiSO+JuSyujTKknHtb050U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dhbcQr6JUvU+pwn/MbbF7AdlxxXfCMdFB8DCHyIk+05s0N7lRTNmZwrKclYdXZAXJ
	 u2OWs4pcqSKyJy8KYN9X+JA4xeIcAsd28cnWdHWVMWNcgXAvqM9pHqqKMHzEW4i68I
	 XC6uZFhvns/QxcKcYPJUC4bXgf8DbiuO9SYf0qSvO+AVSs7h57J0r10gnqlA6u6uzi
	 AH6gTosC7M42ZwNshXRoid1Zgc3DsBJG8AcTGamR/LkfBuBmTBcGE5tD3kMGdObPnN
	 CAn1m/cSb8Y7WpHMIpPB9I3BeDL8BQz+992kpFiGDWIWJC8VS+Q4oB1is4IkNYOJv8
	 kR29vHD32PIZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] sched_ext: Split curr|donor references properly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260716132229.61603-7-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-7-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:02:51 +0000
Message-Id: <20260716150252.68BAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing TICK_DEP_BIT_SCHED protection for cross-class proxy execut=
ion causes remote NOHZ tick warnings and accounting corruption.
- [Medium] The ops.running() callback is never invoked for the physical loc=
k owner under proxy execution, violating the documented API contract.
--

--- Patch [6]: [PATCH 06/11] sched_ext: Split curr|donor references properl=
y ---
commit 4630a7edb1e1687e72cb21f49d2599ffe928b4de
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Split curr|donor references properly

This commit prepares sched_ext for proxy execution by differentiating
between the scheduling context provider (rq->donor) and the physically
executing task (rq->curr). It adjusts tick management, task selection,
and BPF helper functions to use the donor where appropriate.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -4370,14 +4381,14 @@ static void run_deferred(struct rq *rq)
>  #ifdef CONFIG_NO_HZ_FULL
>  bool scx_can_stop_tick(struct rq *rq)
>  {
> -	struct task_struct *p =3D rq->curr;
> +	struct task_struct *p =3D rq->donor;
>  	struct scx_sched *sch =3D scx_task_sched(p);
> =20
>  	if (p->sched_class !=3D &ext_sched_class)
>  		return true;

[Severity: High]
Does this missing check cause remote NOHZ tick warnings during cross-class
proxy execution?

If a FAIR task donates to an EXT task, rq->donor is FAIR but rq->curr is
EXT. When scx_can_stop_tick() is called, it checks p->sched_class (which
is FAIR) and immediately returns true. If the FAIR donor isn't bandwidth
constrained, this allows the tick to stop.

However, stopping the tick when rq->curr !=3D rq->donor violates core NOHZ
assumptions and triggers a WARN_ON_ONCE in sched_tick_remote().

Will this also corrupt time bandwidth accounting by charging the EXT owner
instead of the FAIR donor?

[ ... ]

> @@ -9932,10 +9955,14 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(const st=
ruct bpf_prog_aux *aux)
>  }
> =20
>  /**
> - * scx_bpf_cpu_curr - Return remote CPU's curr task
> + * scx_bpf_cpu_curr - Return remote CPU's current scheduling context
>   * @cpu: CPU of interest
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF pr=
ogs
>   *
> + * Under proxy execution, this returns the donor, which supplies the sch=
eduling
> + * policy and runtime budget, rather than the task whose code is physica=
lly
> + * executing. ops.running() continues to report physical task execution.
> + *

[Severity: Medium]
Is ops.running() actually invoked for the physical lock owner as documented
here?

When a task donates its context, the core scheduler calls
set_next_task_scx() for the blocked donor. However, set_next_task_scx()
explicitly skips ops.running() for blocked tasks:

set_next_task_scx() {
    ...
    if ((p->scx.flags & SCX_TASK_QUEUED) && !p->is_blocked) {
        if (SCX_HAS_OP(sch, running))
            SCX_CALL_OP_TASK(sch, running, rq, p);
    }
    ...
}

Since the core scheduler context-switches to the physical lock owner
without invoking its scheduling class callbacks, does this leave the BPF
scheduler completely blind to the physical task execution?

>   * Callers must hold RCU read lock (KF_RCU).
>   */
>  __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct b=
pf_prog_aux *aux)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132229.6160=
3-1-arighi@nvidia.com?part=3D6
