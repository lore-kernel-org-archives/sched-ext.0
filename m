Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509792C9D
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303733; cv=none; b=f9R4RPje0o0dB46xhPEu5C9cGqcS0rip4t144GQOPOQAgidQ97t71EW5RqxR/nJetvTQhMU/FvNeif6a1++mYsKEv8E/hAWLS8zHG+lrNr+scLqhGhfkzARjuSMbYm+h+1sp8tM0duokWLDQhofellJAe0BX90Xgkc56FeaxsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303733; c=relaxed/simple;
	bh=rk6y4j6S30kWY+GTd3UL82eWMb5pOQmrG4itT9saNO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k1wukXwylUxwBq6xDLVZmJlrzBMp6qcDYIOSA+TI6gOAkcwEKu8RRXcGxQbempBDmFEIVeqmezh+3gOoWz1eVNtA+IiBL6k5jeolWA6P3ZH2YvE8LBZiYeqXtjmDfdCKheaQfN7LBZC71D67SlSAsP0NMTQgx+tc9T8hEAYnxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMTxDwLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMTxDwLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660721F000E9;
	Mon,  6 Jul 2026 02:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303731;
	bh=ikPRb71IyLIusL5cfZOLBevX4AQ+6UOYwKjJ4o+tN+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AMTxDwLhCV4md50S+pDt1PMTmY97JCaLTeLW4NPER+BSrrzH28+XPKh+XdfTLChmX
	 91lxVdW3sBbgc3YxADMVK7yjjVNRsOoKiKpzvzgAQSnYY3+Xs6M3OGZNCqpaQlHA7q
	 WeHPQGrbkGjZJvKET2L9P9ET9BFCY3/CKZ+31AzvJN8Ngyb6qcW7R/hlpxlsN6TPXs
	 HcR94403kKNZ9tnJG9jlUCF4VpB4nKWrRAVbRXWk8vZ6K4Ly9Lig2fGanZa0GWnNGW
	 EKwuHlhXWXiR/g2BGcuJ6j7/5jtD36UZp7yJzjYHZLiwqchycE6sOuc/zzu6iSn5sI
	 zVfam4rHXx30Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 24/36] sched_ext: Add reject DSQ
 for cap-rejected dispatches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-25-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-25-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:08:49 +0000
Message-Id: <20260706020851.660721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Kernel-forced bypass to the local DSQ on offline CPUs interact=
s with capability rejection to create an unrecoverable infinite scheduling =
loop.
- [High] Unbounded task re-rejection in `scx_reenq_reject()` creates a hard=
irq storm that can starve the stall watchdog and deadlock the system.
- [Medium] Missing `p->migration_pending` bypass in `scx_local_or_reject_ds=
q()` leads to spurious rejections and stranded migrating tasks.
--

commit cc43ff2d97ed53171db67ffa05cfd948c7786c2a
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add reject DSQ for cap-rejected dispatches

When a sub-scheduler dispatches a task to a CPU it lacks the required
capability on, the task must be rejected rather than allowed to run.
This patch adds the machinery for that with a reject DSQ.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index deb4c802af83a..e79d30aba0cc0 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -208,6 +208,116 @@ void scx_init_root_caps(struct scx_sched *sch)
> +struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, st=
ruct rq *rq,
> +					       struct task_struct *p, u64 *enq_flags)
> +{
> +	s32 cid =3D __scx_cpu_to_cid(cpu_of(rq));
> +	u64 missing =3D scx_missing_caps(sch, cpu_of(rq), scx_caps_for_enq(*enq=
_flags));
> +
> +	/* requirements met */
> +	if (likely(!missing))
> +		return &rq->scx.local_dsq;

[Severity: Critical]
Can this cause a permanent deadlock when offlining a CPU?

When a CPU goes offline, scx_offline_ecaps() clears ecaps to 0. If a task is
enqueued there, scx_do_enqueue_task() checks !scx_rq_online(rq) and forces
the task to the local DSQ before checking scx_bypassing().

scx_local_or_reject_dsq() will then deterministically reject the task becau=
se
missing will be non-zero. Does this create an infinite irq_work loop that
completely ignores the stall watchdog's bypass mode?

> +
> +	/*
> +	 * A migration-disabled task must run on this CPU. Let it run and count
> +	 * the violation.
> +	 */
> +	if (unlikely(is_migration_disabled(p))) {
> +		__scx_add_event(sch, SCX_EV_SUB_FORCED_ADMIT, 1);
> +		return &rq->scx.local_dsq;
> +	}

[Severity: Medium]
Should this capability check exemption also include p->migration_pending?

If a migrating task is routed to the local DSQ (e.g. via ENQUEUE_RESTORE)
and lacks capabilities, it gets diverted to the reject DSQ. When
scx_reenq_reject() processes it, it hits WARN_ON_ONCE(p->migration_pending)
and skips re-enqueueing, leaving the task stranded in the reject queue.

[ ... ]

> +void scx_reenq_reject(struct rq *rq)
> +{
> +	LIST_HEAD(tasks);
> +	struct task_struct *p, *n;

[ ... ]

> +	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
> +		list_del_init(&p->scx.dsq_list.node);
> +
> +		scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);

[Severity: High]
Does this code create an unbounded hardirq storm if the BPF scheduler
repeatedly dispatches to a local DSQ without the required capabilities?

When scx_local_or_reject_dsq() diverts to reject_dsq, it calls
rq_owned_post_enq() -> schedule_deferred_locked() to queue an irq_work,
which in turn calls scx_reenq_reject().

If the BPF scheduler deterministically dispatches back to the same local DS=
Q,
could it trap CPUs in an irq_work self-IPI loop and starve the stall watchd=
og
in process context?

> +
> +		p->scx.flags &=3D ~SCX_TASK_REENQ_REASON_MASK;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D24
