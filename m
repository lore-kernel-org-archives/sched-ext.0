Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF94437846
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620290; cv=none; b=HbAqqKgvohRRO+79lcKDMapbfvAqKWgTUjIj5gq8xU2GYGc0lrPHWgodaoQU6bSTYqHohvGS4NgSEP72C7Yv46ZRrHBoHKbA+OSvU8MaTxj3KCgdVTCO2XfZONl+2DC/2PNRX3TgRmZRvj7/y20IoES1f20m1HIhkBLmtmk2xWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620290; c=relaxed/simple;
	bh=vIGh5Iizcq61/kCr4CTO+XCzBHHfBOvSavhMS/ZyYfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PZfI9kcXDlPXoDO3PubuMYmreO8q3kt6LqMQ0M7pCZhpJgln1dGpLf/x/YLEIVK50jAZ4KKuppZR74g1ZrHe+6BAVh1CVktM5sE2sCsf4pZx0fD8yQi5BP4Chbi+U19N79gxk4NAj/VArbLttl4YQE1ybHcnUIml3Rj5GbdxTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/iBwoNn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/iBwoNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB1F1F000E9;
	Tue, 21 Jul 2026 07:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620289;
	bh=6Tq6Ai3yGOKIAOeLqm7seF2Zk1rLSaF2VddEiYJIz9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X/iBwoNn6EGCc6kOEAZ1ItEsreGB9ujJmXasU3QDJ+zp7y7P2xwNJPaltPslvxHtM
	 mAYYO9eTYYQhye7A572mI/+rOB+ljEMoaAlEGTiaiFSxKviRzIgbJcFOAs4S1Lt8Kl
	 AQIwXuKzzWmRkklfj380FBvR7SMy0H7MBP/heuLP88fsyHgIPYmQcN5J7ii4iR2kV9
	 Sim71oSYkTG0fI5j0y/iB2rWyt+klPXMZiLJKdfWjxs33z7zCcfjyVpcDvvKUDuyq0
	 xTl26qmZ8o2J09bu/1PN3tDvg9wby9e3O4ZNau7HM+7pnvn5BqGsU8SyWq+AKuELAC
	 yWSGp4Cmn+u5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] sched_ext: Fix proxy-exec race in
 consume_remote_task()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260721063242.552774-7-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
 <20260721063242.552774-7-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:51:28 +0000
Message-Id: <20260721075129.2DB1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] task_can_move_from_locked_rq() fails to check if the task is the a=
ctive donor on the source runqueue under proxy execution.
--

--- Patch [6]: [PATCH 06/12] sched_ext: Fix proxy-exec race in consume_remo=
te_task() ---
commit 681e47b7800ef6cd6756031dfb833542e391c7df
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Fix proxy-exec race in consume_remote_task()

This patch addresses a proxy execution race where a task's state can change
without clearing holding_cpu. It introduces task_can_move_from_locked_rq()
to recheck the on-CPU and migration-disabled states after switching to the
source runqueue lock. If the state changed, the task is requeued on the
global DSQ instead of aborting the BPF scheduler.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 30d5965d09108..b5fd91d9bca4f 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -2432,6 +2429,28 @@ static bool task_can_run_on_remote_rq(struct scx_s=
ched *sch,
>  	return true;
>  }
> =20
> +/*
> + * Proxy execution can change @p's execution and migration-disabled state
> + * without touching its DSQ entry or clearing holding_cpu. Check those s=
tates
> + * with @p's rq locked. Without proxy execution, the holding_cpu handsha=
ke is
> + * sufficient and this must not affect the existing migration path.
> + */
> +static bool task_can_move_from_locked_rq(struct task_struct *p)
> +{
> +	struct rq *src_rq =3D task_rq(p);
> +
> +	lockdep_assert_rq_held(src_rq);
> +
> +	if (!sched_proxy_exec())
> +		return true;
> +
> +	/* @p may be rq->curr under another task's proxy scheduling context. */
> +	if (task_on_cpu(src_rq, p))
> +		return false;
> +

[Severity: High]
Is it possible for the active scheduling context (the donor) to be migrated
here?

When a task blocks on a mutex and becomes a proxy donor, it is retained on
the runqueue (p->on_rq =3D=3D 1) without being dequeued. put_prev_task_scx()
sees SCX_TASK_QUEUED and enqueues this blocked task onto a DSQ.

When another CPU attempts to consume from this DSQ, consume_remote_task()
invokes this new task_can_move_from_locked_rq(). Since the donor is
blocked, task_on_cpu(src_rq, p) evaluates to false.

Without a check for task_current_donor(src_rq, p), could this return true
and allow move_remote_task_to_local_dsq() to migrate the active donor,
corrupting the proxy execution PI chain?

> +	return !is_migration_disabled(p);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721063242.5527=
74-1-arighi@nvidia.com?part=3D6
