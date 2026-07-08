Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4230D41D
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548142; cv=none; b=el4qWOvgw9iziaBeTMu35RUfhNFO7rd0sLhEUwOZbfVH0vR9d+xEfjEmO4MpYB2MDZycW8sHTHdnnNIt2P5O7bbpSgzHlpIe+QJQx0TT3BInftx6hk5+evz7CDL3W3G4TKoNd91pTznot5/BDHvkOS9NDBOCgjAsoDwtHk8mLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548142; c=relaxed/simple;
	bh=NqDGskIvmMsOZV97uaQkSMpRh6KBdQmJYVwQNuRQn8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Doo6xp1UZdOCOX0VaKh/WT3l48V3NaN+c0PgYmB8nqda0ci/0KZw6MSFBvfmqpumnAyZxEjmFwCQRmFZVdHussBqrqLj5LkmZJ79ZxIYyD0A8TxDQSo6NQFya1iX1OQa/McQXNd95uimvOe3qGQkvk3SpO8/poGslKFGUo55b7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejnwXdcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejnwXdcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C181F000E9;
	Wed,  8 Jul 2026 22:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783548140;
	bh=YuwpriCS9oXzasn7jcZO7aC49QR0VHDM7SYAb9vA3bQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ejnwXdclFWPqjQ9Xp7UpVTtTUf5TCTX6C30+9S24/1x160dYknkZvp3LdyYBOuxx6
	 qRRXDqPj/1xIjtocxyRAJLyy0foMWZJ/j5pDIvY1twO/VxU9pmWeUGLRzi0TFr6Wpk
	 mb23vH8U33atBXF1T78hyJjXC7RbM7h6dqoglYPllvlocxChuQCDPL54E4m4z2FBsg
	 NzKCoAn37H+tiDBqFq6won08QBBey45nyNKpDi+sLjSmUw8RQuWjb1DdNMTtd+Q07E
	 QrK4ntI2EmStLJ5REcu+Max8sIlB7pKGTELJMvChrhP9K9oBvcK4fnt1zcKZ9Pj/RE
	 VWi3jOfMuag4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 24/40] sched_ext: Add
 sub_ecaps_updated() effective-cap change notifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-25-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-25-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:02:19 +0000
Message-Id: <20260708220220.87C181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `scx_discard_ecaps_to_sync()` loops infinitely if the target CPU i=
s starved by RT/DL tasks, stalling scheduler teardown.
--

--- Patch [24]: [PATCH v4 sched_ext/for-7.3 24/40] sched_ext: Add sub_ecaps=
_updated() effective-cap change notifier ---
commit acc58dd0c8619664f61b598c2dccb6ac82d1cc5a
Author: Tejun Heo <tj@kernel.org>
Subject: sched_ext: Add sub_ecaps_updated() effective-cap change notifier

This patch adds a notifier for sub-scheduler effective capability
changes on a CPU. It queues syncs and processes them in dispatch
context, handling CPU hotplug by zeroing capabilities when offline and
re-syncing when online.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 80f74064ca781..f0ebf7c6e1425 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

>  void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
>  {
> -	scoped_guard (rq_lock_irqsave, cpu_rq(cpu))
> -		scx_process_sync_ecaps(cpu_rq(cpu));
> +	struct rq *rq =3D cpu_rq(cpu);
> =20
> -	WARN_ON_ONCE(llist_on_list(&pcpu->ecaps_to_sync_node));
> +	while (true) {
> +		scoped_guard (rq_lock_irqsave, rq) {
> +			/*
> +			 * scx_process_sync_ecaps() takes the node off the list
> +			 * before it is done accessing @pcpu but does all of it
> +			 * under the rq lock. Off-list observed under the rq
> +			 * lock guarantees that the sync is complete.
> +			 */
> +			if (!llist_on_list(&pcpu->ecaps_to_sync_node))
> +				return;
> +			/*
> +			 * Discard only when the cpu is truly down. cpu_active()
> +			 * is already set when scx_online_ecaps() queues an online
> +			 * resync while SCX_RQ_ONLINE is not - so test cpu_active(),
> +			 * or that resync would be dropped.
> +			 */
> +			if (!scx_enabled() || !cpu_active(cpu)) {
> +				discard_queued_syncs(rq);
> +				return;
> +			}
> +		}
> +		resched_cpu(cpu);
> +		msleep(1);
> +	}
>  }

[Severity: High]
Could this regression lead to an indefinite hang in
scx_discard_ecaps_to_sync() if the target CPU is starved by RT or DL tasks?

If a high-priority RT or DL task monopolizes the target CPU (for example,
if RT throttling is disabled), pick_next_task() may never fall through
to the ext_sched_class.

This prevents pick_task_scx() and balance_one() from being executed on
the target CPU, so pcpu->ecaps_to_sync_node is never processed and
removed from the list. The system_dfl_wq worker running
scx_sched_free_rcu_work() would then block forever in this while (true)
loop, leaking the scx_sched resources and stalling the sub-scheduler
teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D24
