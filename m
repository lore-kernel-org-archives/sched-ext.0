Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087813909B5
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258198; cv=none; b=j5UXBjPG6ocvVB7vCzsuEhGzsT9oi203PLk7fkeytWNVkBKETdA6OZTxl6zRgX4hmR61NMQ+j/1Ci7PcCwB01IUjCjhtwM5T14vXCZfgxRXQyZQREhOxBqECb7wEOJqmNMe4gp2gvhrXIztNjxp4iIf+/PPUTgyx7MzAL82wFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258198; c=relaxed/simple;
	bh=heLN6BdLQt0c3Aaz06FxmBQjHOPkpHLMq5NTUh3bPtQ=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=dmtros/t4tHP6tvwks5ClrQptNNahx8sFm0WZBxt+8OP2btuM7dCmMTa8f2M0rE/0+nqkaJjD+HGZWQFUbAvHzRVBKom1+T0Y2og1ZMlTUW7V12RPmjUGfmBMNhFA4hkp37Px1kKaO2+iqRqP/cql2r5Y9UN9Bfh0qF55j7aKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKD5mY9W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKD5mY9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A89F1F000C5;
	Sat, 17 Oct 2026 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792258196;
	bh=zM69MozAdLR858gHy5OUnuUTaEuEN5MJqcoNzr0bazA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hKD5mY9Wv1ord4gWXa7Uru86GsjUjf6e24SdZ+/XmGjS04eCqWOpfbXbWpgkMohgL
	 YOiyZYcNILaza2Ipamm15OsT5K6fb4xKK5kFO5aM0INSjgugvSsD5a4gG8m697JQ0e
	 a98Nf/J8lNBXi0x6g/ZnPY91m5/UiCWRzOuSg1uw4TXznYaHjoB2rWiLJg87XyJTYL
	 +GzGImg890fb3muJcPugVvizHDVzcDLJULd7JiMVdHQnLixBNB3L0gye0SRZF8NFSW
	 uBwEKObqATbZfIl5LMV108ZyWlCKlpBF6f79aQjssYoYxWTQwLxmIS3CCnRsIO29sP
	 uO1AZRR4IFlAA==
Message-ID: <sashiko-outbox-175706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] sched_ext: Report a sub-scheduler's ecaps on attach
 and detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261017164556.4136807-4-tj@kernel.org>
References: <20261017164556.4136807-1-tj@kernel.org>
 <20261017164556.4136807-4-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:29:56 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched_ext: lost reschedule in ecaps_report() causes uninterruptibl=
e hang
--

commit 5335600717ec4a41d30d235361731881672efc03
Author: Tejun Heo <tj@kernel.org>

sched_ext: Report a sub-scheduler's ecaps on attach and detach

This commit reports a sub-scheduler's effective capabilities synchronously =
on
attach (before bypass lifts) and on detach (before tasks return to the pare=
nt)
by queuing an ecaps sync on active CPUs that ever held capabilities and
waiting on an rcuwait for dispatch to process them.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 41d5453a1d6f5..c595e6f6195f1 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -1654,6 +1678,76 @@ static inline s32 scx_cgroup_claim_subtree(struct =
scx_sched *sch) { return 0; }
>  static inline void scx_cgroup_return_subtree(struct scx_sched *sch) {}
>  #endif
> =20
> +/*
> + * Enable @sch's ecaps deliveries on every possible cpu, so that a cpu i=
nactive
> + * during the attach report delivers from the reseed at its activation.
> + */
> +static void ecaps_enable(struct scx_sched *sch)
> +{
> +	s32 cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		guard(rq_lock_irqsave)(cpu_rq(cpu));
> +		per_cpu_ptr(sch->pcpu, cpu)->flags |=3D SCX_SCHED_PCPU_ECAPS_ENABLED;
> +	}
> +	sch->ecaps_enabled =3D true;
> +}
> +
> +/**
> + * ecaps_report - Report @sch's ecaps and wait
> + * @sch: sub-scheduler to report
> + *
> + * Mark every cpu @sch was ever granted a cap on, deliver its pending ch=
ange
> + * through the dispatch path and wait for it. An inactive cpu is skipped=
. A cpu
> + * going down meanwhile has its mark cleared by scx_offline_ecaps().
> + *
> + * Called with scx_enable_mutex held. A sched's attach and detach report=
s must
> + * not overlap, as the mark is one bit per pcpu.
> + */
> +static void ecaps_report(struct scx_sched *sch)
> +{
> +	s32 cpu;
> +
> +	lockdep_assert_held(&scx_enable_mutex);
> +
> +	for_each_possible_cpu(cpu) {
> +		struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(sch->pcpu, cpu);
> +		struct rq *rq =3D cpu_rq(cpu);
> +		struct scx_pshard *ps;
> +		s32 cid;
> +
> +		guard(rq_lock_irqsave)(rq);
> +
> +		/* syncs on an inactive cpu are discarded */
> +		if (!cpu_active(cpu))
> +			continue;
> +
> +		cid =3D __scx_cpu_to_cid(cpu);
> +		ps =3D cid_pshard(sch, cid);
> +		guard(raw_spinlock)(&ps->lock);
> +
> +		if (!pcpu->had_caps)
> +			continue;
> +
> +		pcpu->flags |=3D SCX_SCHED_PCPU_ECAPS_REPORT;
> +		atomic_inc(&sch->nr_ecaps_reports);
> +		queue_sync_ecaps(sch, cid);
> +
> +		/*
> +		 * The report needs an ext dispatch on this cpu. A kick is
> +		 * dropped while the root bypasses, e.g. for PM, so reschedule
> +		 * directly. A fair task can hold the cpu, so also start the ext
> +		 * server, which picks the ext class within its period.
> +		 */
> +		update_rq_clock(rq);
> +		dl_server_start(&rq->ext_server);
> +		resched_curr(rq);
> +	}
> +
> +	rcuwait_wait_event(&ecaps_report_wait, !atomic_read(&sch->nr_ecaps_repo=
rts),
> +			   TASK_UNINTERRUPTIBLE);
> +}

[Severity: High]
Can the reschedule issued by ecaps_report() be lost if the target CPU is
already inside dispatch_one() and temporarily drops rq->lock, causing
ecaps_report() to hang in rcuwait_wait_event() while holding scx_enable_mut=
ex
(and cpus_read_lock() in scx_sub_disable())?

On the target CPU, dispatch_one() drains rq->scx.ecaps_to_sync once at entr=
y:

kernel/sched/ext/ext.c:dispatch_one() {
	lockdep_assert_rq_held(rq);
	rq->scx.flags |=3D SCX_RQ_IN_DISPATCH;

	scx_process_sync_ecaps(rq, prev);
	...
	verdict =3D scx_dispatch_sched(root_sch, rq, prev, false);
}

After __scx_process_sync_ecaps() calls llist_del_all(&rq->scx.ecaps_to_sync=
),
rq->lock can be dropped and re-acquired via switch_rq_lock() during
scx_flush_dispatch_buf() -> finish_dispatch() -> dispatch_to_local_dsq() or
during scx_dispatch_sched() (for example in consume_remote_task(),
dispatch_to_local_dsq(), or scx_dsq_move()).

If ecaps_report() acquires rq->lock during that window, it queues
pcpu->ecaps_to_sync_node onto rq->scx.ecaps_to_sync and calls
dl_server_start(&rq->ext_server) and resched_curr(rq). Because the target C=
PU
is still in pick_next_task(), rq->curr is still prev. When dispatch_one()
finishes without re-checking rq->scx.ecaps_to_sync and pick_next_task()
returns to __schedule(), __schedule() clears the reschedule request:

kernel/sched/core.c:__schedule() {
picked:
	clear_tsk_need_resched(prev);
	clear_preempt_need_resched();
}

Similarly, under CONFIG_SCHED_CORE, if an SMT sibling's core-wide pick in
pick_next_task() already set rq->core_pick and rq->core->core_pick_seq =3D=
=3D
rq->core->core_task_seq before ecaps_report() runs on rq, ecaps_report() do=
es
not advance core_task_seq or clear rq->core_pick, so pick_next_task() can t=
ake
the core_pick fastpath without calling dispatch_one() and then clear
TIF_NEED_RESCHED at picked:.

In either case, starting rq->ext_server does not guarantee another
dispatch_one() call: if the selected next task is rq->idle,
dl_server_update_idle() sets dl_defer_idle and dl_server_timer() stops
ext_server without calling resched_curr(rq); if the selected next task is an
ext_sched_class task with SCX_SLICE_INF, task_tick_scx() does not reschedule
it and update_curr_scx() -> dl_server_update() keeps pushing ext_server's
timer forward. Could that leave sch->nr_ecaps_reports non-zero indefinitely?

([ ... ])

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017164556.4136=
807-1-tj@kernel.org?part=3D3
