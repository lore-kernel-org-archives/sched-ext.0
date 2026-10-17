Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D515E5BB
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260843; cv=none; b=omMiwlxACW8vpdu08JHrgP0hlAFQnHP+QrSx+j1H3RWGrqkcDQ9uI+aza1bwdOE3Vdz+XrMdBB3Op8SEgRNkgUkoCeOTEOCzIlDSVL/5eWid0KyPTyr5hkgEll35U2NDqBACivcDIUMTTx3oX7SLBPDOAE3WzVe+0598DGS335A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260843; c=relaxed/simple;
	bh=sfGNeMcUsQ73B2zif7B7LKAhF2+adXBQohtWhqWlSEA=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=fzjYy05sKUSYXbGwgtksZ+kA+j1/NCAxswsidfJqVF1ZA2/PwXpv9nC6CgfmY4fnk/0ASDnD/SKzdypWg3KS8mx7JDiqlVUCWXwFWTdx4LPysvF5BQw7JBz3pdDi2LbRtnpCEFb7QC17WJ+PwaHwQxrZlBzi4KCdjZyn2nQuEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G89Rl2FZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G89Rl2FZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2401F000C5;
	Sat, 17 Oct 2026 18:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792260842;
	bh=up8PGDtnuKrkF4IC5d0kipLvnO+YcJGSGAiMk4Wn8Pc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=G89Rl2FZd+7DWVplOJSZ4TimFWLVPjY34GhAfHpdJ8z+MKnXSdEQYSqrnSMA9E32/
	 5R8VsnFuf/IQLFAdRDYXR0qtyNbX34hX5C3nnTQnTPmLOcZpfBudTcQTB+FaJeSGu3
	 QB+Kye5L74fdMvCn9CKhTNwGWpb1LElsUMf57b/hSnqjPW3/VYE10Qy6PhZEMBxUlX
	 3rqooSXukE6SaR+LS9i43gKJM4D7HoAOOV5YRNQQ6igHbO01B8kNIhVAernTUmXZ8H
	 4UDwzfZ8+D8OByr9xxbCG7Mac5DJ42Xq7+3VobhkXRAJEX8p8aYnkhwxVWLbklhpjE
	 RQxOkPGZUAUHw==
Message-ID: <sashiko-outbox-175737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] sched_ext: Report the ecaps loss when a cpu goes
 offline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261017164556.4136807-6-tj@kernel.org>
References: <20261017164556.4136807-1-tj@kernel.org>
 <20261017164556.4136807-6-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:14:02 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched_ext: deadlock in scx_offline_ecaps() when scx_root_disable()=
 races hotplug
--

commit 7354181ddf2a55286ce8abbd0374e5b9d7fdb269
Author: Tejun Heo <tj@kernel.org>

sched_ext: Report the ecaps loss when a cpu goes offline

This patch reports the loss of effective caps on a cid to the sub-scheduler
and its parent before the root's ops.cpu_offline() runs, and reports the
regain after ops.cpu_online(). To ensure the loss is reported before the CPU
goes offline, scx_offline_ecaps() marks a sync for each sub-scheduler, star=
ts
the ext server, and waits for all marked syncs to be processed.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index ab9327b819304..ac86bd5ec21b7 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
[ ... ]
> @@ -1298,40 +1332,69 @@ void scx_online_ecaps(struct rq *rq)
[ ... ]
>  void scx_offline_ecaps(struct rq *rq)
>  {
>  	s32 cpu =3D cpu_of(rq);
>  	struct scx_sched *root, *pos;
> +	u32 nr =3D 0;
> +	s32 cid;
> =20
> -	guard(rq_lock_irqsave)(rq);
> +	/*
> +	 * ecaps and the tables need a live root, see scx_online_ecaps(). The
> +	 * ext class isn't picked without one, so the syncs wouldn't be
> +	 * processed and the wait would never end. scx_enabled() can't change
> +	 * during hotplug.
> +	 */
> +	if (scx_enabled()) {
> +		scoped_guard (rq_lock_irqsave, rq) {
> +			root =3D scx_root_protected();
> +			cid =3D __scx_cpu_to_cid(cpu);
> =20
> -	root =3D scx_root_protected();
> +			scx_for_each_descendant_pre(pos, root) {
> +				struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(pos->pcpu, cpu);
> +				struct scx_pshard *ps;
> =20
> -	scx_for_each_descendant_pre(pos, root) {
> -		struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(pos->pcpu, cpu);
> +				/* root holds every cap and never uses ecaps */
> +				if (!pos->level)
> +					continue;
> =20
> -		/* root holds every cap and never uses ecaps */
> -		if (!pos->level)
> -			continue;
> +				/*
> +				 * A batch that has yet to reach the sync sees
> +				 * the mark. A sync already being processed has
> +				 * left the list and is queued again below.
> +				 */
> +				pcpu->flags |=3D SCX_SCHED_PCPU_ECAPS_OFFLINE;
> +				nr++;
> +
> +				ps =3D cid_pshard(pos, cid);
> +				guard(raw_spinlock)(&ps->lock);
> +				queue_sync_ecaps(pos, cid);
> +			}
> =20
> -		WRITE_ONCE(pcpu->ecaps, 0);
> +			WRITE_ONCE(rq->scx.nr_ecaps_offline, nr);
> +			resched_sync_ecaps(rq);
> +		}
> =20
> -		/* deliveries have stopped on this cpu, clear its mark */
> -		if (pcpu->flags & SCX_SCHED_PCPU_ECAPS_REPORT)
> -			ecaps_report_done(pcpu);
> +		wait_event(ecaps_offline_waitq, !READ_ONCE(rq->scx.nr_ecaps_offline));
>  	}

[Severity: High]
Can scx_offline_ecaps() deadlock here if a CPU hotplug offline operation
races with scx_sub_disable() and scx_root_disable()?

The comment notes that scx_enabled() cannot change during hotplug, and that
without a live root the ext class will not be picked and the wait would nev=
er
end. However, static_branch_disable(&__scx_enabled) in scx_root_disable() r=
uns
before cpus_read_lock() is acquired.

In scx_sub_disable(), cpus_read_lock() is only held around clear_all_caps()
and ecaps_report(), and is dropped while sch remains linked on
parent->children until scx_unlink_sched(sch):

kernel/sched/ext/sub.c:scx_sub_disable() {
	scoped_guard(cpus_read_lock) {
		clear_all_caps(sch);
		if (sch->ecaps_enabled)
			ecaps_report(sch);
	}

	percpu_down_write(&scx_fork_rwsem);
	scx_cgroup_lock();
	...
	scx_unlink_sched(sch);
}

If the last sub-scheduler has passed that cpus_read_lock() block in
scx_sub_disable() when a CPU begins going offline (holding cpus_write_lock),
scx_offline_ecaps() sees scx_enabled() =3D=3D true and visits sch via
scx_for_each_descendant_pre(pos, root). It sets SCX_SCHED_PCPU_ECAPS_OFFLIN=
E,
sets rq->scx.nr_ecaps_offline =3D 1, starts rq->ext_server (which enters its
dl_defer zero-laxity wait if a fair task is running), and sleeps in
wait_event(ecaps_offline_waitq, ...).

Meanwhile, scx_sub_disable() does not take cpus_read_lock() again. It finis=
hes
scx_unlink_sched(sch) and wakes scx_unlink_waitq. If the root scheduler is
also disabling, scx_root_disable() wakes from drain_descendants(), detaches
rq->ext_server, and disables __scx_enabled before blocking on
cpus_read_lock():

kernel/sched/ext/ext.c:scx_root_disable() {
	drain_descendants();
	...
	for_each_possible_cpu(cpu) {
		struct rq *rq =3D cpu_rq(cpu);

		scoped_guard(rq_lock_irqsave, rq) {
			update_rq_clock(rq);
			if (was_switched_all) {
				if (WARN_ON_ONCE(dl_server_swap_bw(&rq->ext_server,
								   &rq->fair_server)))
					pr_warn("failed to re-attach fair_server on CPU %d\n", cpu);
			} else {
				dl_server_detach_bw(&rq->ext_server);
			}
		}
	}

	scx_ops_cid_sched_updated_disable(sch);

	/* no task is on scx, turn off all the switches and flush in-progress call=
s */
	static_branch_disable(&__scx_enabled);
	...
	scoped_guard(cpus_read_lock) {
		...
	}
}

If the offline CPU had not yet picked ext_sched_class before __scx_enabled =
was
disabled and ext_server was detached (for instance, while a fair or RT task
was running during ext_server's dl_defer window), __scx_process_sync_ecaps()
will never be called on that rq. Furthermore, scx_discard_ecaps_to_sync() is
only invoked from scx_sched_quiesce_rcu_work() after scx_kobj_release() when
the sub-scheduler's bpf_link is closed, so while the sub-scheduler's bpf_li=
nk
remains open (or if userspace is blocked in bpf_scx_unreg(root) ->
scx_flush_disable_work(root)), wouldn't the hotplug thread and
scx_root_disable() wait on each other forever?

> =20
> +	guard(rq_lock_irqsave)(rq);
>  	rq->scx.flags &=3D ~SCX_RQ_OPS_ONLINE;
>  }

[ ... ]

> @@ -1808,9 +1862,9 @@ void scx_sub_disable(struct scx_sched *sch)
>  	/*
>  	 * Clear @sch's caps and report the loss before any task goes back to
>  	 * the parent. A disabling sched is granted nothing, so the caps stay
> -	 * cleared. Hold off cpu hotplug across both. The report covers every
> -	 * active cpu and the clear drops the unreported loss on the rest, so
> -	 * that no loss reaches the parent after ops.sub_detach().
> +	 * cleared. Hold off cpu hotplug across both so that a cpu the report
> +	 * skips has finished going down. Its loss was reported as it went down,
> +	 * see scx_offline_ecaps().
>  	 *
>  	 * An enable that failed before its attach report has nothing to report.
>  	 * If it failed before scx_link_sched(), the root's disable doesn't wait

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017164556.4136=
807-1-tj@kernel.org?part=3D5
