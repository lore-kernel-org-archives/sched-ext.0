Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1463D5C0B
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083467; cv=none; b=gq5tj53+hg5iJeQfDNUMhvpU7sw3sXzhRMo6f6ybwEP+1eJdkAgRY8gYhAfZInFHBkx0jepx++15AB1ADkNBdg47qQYmnZuHRPe8yzUTLb22MxEYI91iR0EIi2ljkTVGSBTzdftZrsWixPDhOlos4Yh6mVzezhnrKD0GtQse5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083467; c=relaxed/simple;
	bh=PV6K8EdOj0KLLUDq/R3GjUKlo9htG6vEbIsD6wz+otU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yaqu8xUTINrsaxLg8inO513P02jFOY78dYF929YjP5x//weTM6MS14LtwtbYAPf4Q0o2eszupC+7+lpNeFaUbGOTd0DTZTTEr1SaBtAXNrTmx0fYfYippkPcTQaX/SsqpSVcYqexdhUj4xg4QHrnuqLvqFUlm5wx9tKQk3E6g8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St7KgDGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St7KgDGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8371F000E9;
	Fri,  3 Jul 2026 12:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783083466;
	bh=m7q9uMr95voLs8o51QvZ2XMMRhYoRooU8HmKU0X4RF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=St7KgDGyr8v1O9Or1MOQPrV70tUHsn1izYmrfyLMLYf7iXJHoSZMoYwh96XnsBulM
	 3Iim7RFNEYeDoJ9mWXOG+xDqiC+2moXVhWvzSS2rKiqLIIiHsOXBUVJm4FFoN4SuIl
	 p9V5XK9gq8f/O79fam3m/6OmCO353fJfgGsPu7wpIxTexfavnV2IyGfccH72oZnEGf
	 1iOdGcfQJmGBDjKPv5AHn/A0zIWjVL4A2/jnHwG0JMGVm4jWlj8ZqaSdmeXGHPl+JA
	 UlkmjLfRQdI0EFN5UtqABbpv+UgkEoi3U0rw0R+lfOv6nGR08iBY/YGAwVd6W7fjrp
	 DGle2q1Rgodyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 21/32] sched_ext: Add reject DSQ for
 cap-rejected dispatches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-22-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-22-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:57:44 +0000
Message-Id: <20260703125746.0D8371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Infinite loop of deferred requeues for exiting tasks or tasks on o=
ffline CPUs when the sub-scheduler lacks capabilities.
- [High] Tasks undergoing migration (with p->migration_pending set) are inc=
orrectly rejected to reject_dsq and then skipped during reenqueuing, leavin=
g them stranded indefinitely.
--

commit a1844a55d6fd4ac62f0bf384be1b2b5048f269d7
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add reject DSQ for cap-rejected dispatches

When a sub-scheduler dispatches a task to a CPU it lacks the required
capability on, the task must be rejected rather than allowed to run.
This patch adds a reject DSQ to divert these tasks and hand them back
to the BPF scheduler to re-decide.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 55437f1d1965f..aea63484edc5a 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -204,6 +204,116 @@ void scx_init_root_caps(struct scx_sched *sch)
>  	}
>  }
> =20
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
> +
> +	/*
> +	 * A migration-disabled task must run on this CPU. Let it run and count
> +	 * the violation.
> +	 */
> +	if (unlikely(is_migration_disabled(p))) {
> +		__scx_add_event(sch, SCX_EV_SUB_FORCED_ADMIT, 1);
> +		return &rq->scx.local_dsq;
> +	}

[Severity: High]
Could this create an infinite loop of deferred requeues for exiting tasks
or tasks on offline CPUs?

If a task is exiting (PF_EXITING) or enqueued on an offline CPU while
the sub-scheduler lacks capabilities on that CPU, scx_do_enqueue_task()
routes it directly to the local DSQ:

scx_do_enqueue_task() {
    if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
        unlikely(p->flags & PF_EXITING)) {
        __scx_add_event(sch, SCX_EV_ENQ_SKIP_EXITING, 1);
        goto local;
    }
}

Since these tasks aren't forcefully admitted here in scx_local_or_reject_ds=
q()
like migration-disabled tasks are, they are diverted to the reject_dsq.

Then scx_reenq_reject() attempts to re-enqueue them, which triggers the
same goto local path in scx_do_enqueue_task(), resulting in an endless cycl=
e.

> +
> +	p->scx.reenq_reason_caps =3D missing;
> +	p->scx.reenq_reason_cid =3D cid;

[ ... ]

> +void scx_reenq_reject(struct rq *rq)
> +{
> +	LIST_HEAD(tasks);
> +	struct task_struct *p, *n;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (list_empty(&rq->scx.reject_dsq.list))
> +		return;
> +
> +	/*
> +	 * Move to a private list so a task re-rejected by the
> +	 * scx_do_enqueue_task() below isn't revisited this round.
> +	 */
> +	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.n=
ode) {
> +		/* migration_pending tasks should have bypassed to local DSQ */
> +		if (WARN_ON_ONCE(p->migration_pending))
> +			continue;

[Severity: High]
Are we permanently stranding tasks that have p->migration_pending set?

During an active migration, a task with p->migration_pending might be
routed to a new CPU. If the sub-scheduler lacks capabilities on that CPU,
scx_local_or_reject_dsq() does not forcefully admit it, and instead
diverts the task to the reject_dsq.

When this list is processed here, the task triggers this warning and is
skipped via the continue statement, meaning it never gets re-enqueued
and is left stranded indefinitely.

> +
> +		scx_dispatch_dequeue(rq, p);
> +
> +		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D21
