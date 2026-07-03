Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A64D3D1AA4
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081515; cv=none; b=FxioBfrVEvOPDxarNENv9JnxArsvoiGS95G6z6tM8zFGV13ZnvSQwZGn515g88GGYd+LQSH/YzGtaae/k/vXLdYm8mj7KzwZXnWFzSX2Q1Hb3knKcbwa2Ak2Nv1PQj8pPwTN53qbPbFoHMzlEz+L0N4vTNIUBLJ53DA8s/eqrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081515; c=relaxed/simple;
	bh=DuplWo4OO2aXpw7z8a28mT95iEHd+UG74BUetz7wXto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hnqCSmeEDSvGXuPd9lCJVO/YP6vJFnyJ/Xfs+4rH/Cz7DGiAeC8iwo/qsK7WxnXf+i0u4tbBF/C8JBPeYChDmBPQXdkOxPZAf7oxFRcGYS2N5HL6iE2vINM7WqBM3FGysszGDDfryiy9XGJj1zTgl21xGfmUZ1pZgHk0xY+2SE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg7Vyp/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg7Vyp/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E091F000E9;
	Fri,  3 Jul 2026 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783081514;
	bh=s0w/HiFH/XiVgJT9lb66Re65kLsjpbTu6KG6KzFRjOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dg7Vyp/dytL3ZaQkHPhHK/49LrxRtqAm0Kf+Qq1Xpxsbaxl3w3U61AgLTE4yqlL02
	 wfoQd1xsOfx5pjOit1zex4Jv5cFvnNYeInBtA0FRdpy6HfP0z5WJqv5OU8+SzEkSoQ
	 doRzgJ8ckzQ4y9aiKn+qbCR9jdARuY+auH8GwhmtXJdWKaoTspon0kVsMjrML8ChxA
	 2kIBstG4uyIf71euecCCnm1cYZpaxwUvWoyOXpBzjAgixhSS5TPXCcUPyKD7cxlE+Y
	 AsD2dpxU2uPXyZ4PALB0RNZQ7fKW3o3H4xG7vz1O2o/IAbuTEOG/VV52fuDWzTCwUh
	 NT8XUPZrInYyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 19/32] sched_ext: Add
 sub_ecaps_updated() effective-cap change notifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-20-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-20-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:25:13 +0000
Message-Id: <20260703122514.03E091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Concurrent freeing of a sub-scheduler can permanently discard ecap=
s syncs for all active sub-schedulers on a CPU that is coming online.
- [High] scx_discard_ecaps_to_sync() can hang indefinitely in a worker thre=
ad if the target CPU is continuously executing higher-priority tasks, locki=
ng up the system RCU workqueue.
- [High] Early clearing of `ecaps_to_sync_node` in `scx_process_sync_ecaps(=
)` causes a Use-After-Free of `pcpu` and `sch` during sub-scheduler teardow=
n.
--

commit f00aae3acf0710a9423504a897d70bfb5d9571f6
Author: Tejun Heo <tj@kernel.org>
Subject: sched_ext: Add sub_ecaps_updated() effective-cap change notifier

The patch adds an ops.sub_ecaps_updated() callback fired when a
sub-scheduler's effective caps on a cid change. CPU hotplug uses this
mechanism to zero caps when a CPU goes down, and to resync when coming
back online.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 08d9367cf2188..55437f1d1965f 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -351,33 +354,130 @@ void scx_process_sync_ecaps(struct rq *rq)
>  	if (likely(llist_empty(&rq->scx.ecaps_to_sync)))
>  		return;
> =20
> +	/*
> +	 * ecaps are zeroed while the cpu is inactive and must stay zero.
> +	 * Discard queued syncs instead of processing them - the
> +	 * scx_online_ecaps() reseed re-syncs every sched on activation.
> +	 * cpu_active() clears before the offline zeroing and sets before the
> +	 * reseed is queued, so this test can neither miss a racing sync nor
> +	 * eat the reseed.
> +	 */
> +	if (unlikely(!cpu_active(cpu))) {
> +		discard_queued_syncs(rq);
> +		return;
> +	}
> +
>  	batch =3D llist_del_all(&rq->scx.ecaps_to_sync);
>  	llist_for_each_safe(pos, tmp, batch) {
>  		struct scx_sched_pcpu *pcpu =3D
>  			container_of(pos, struct scx_sched_pcpu, ecaps_to_sync_node);
>  		struct scx_pshard *ps =3D pcpu->sch->pshard[shard];
> +		u64 ecaps;
> =20
>  		init_llist_node(pos);
> =20
>  		/* pairs with smp_mb() in queue_sync_ecaps(), see there */
>  		smp_mb();
> =20
> -		WRITE_ONCE(pcpu->ecaps, calc_effective_caps(ps, cid));
> +		ecaps =3D calc_effective_caps(ps, cid);
> +		WRITE_ONCE(pcpu->ecaps, ecaps);
> +
> +		/* tell the sched its effective caps on this cid changed */
> +		if (ecaps !=3D pcpu->reported_ecaps &&
> +		    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
> +		    !scx_bypassing(pcpu->sch, cpu)) {
> +			struct scx_dsp_ctx *dspc =3D &pcpu->dsp_ctx;
> +
> +			dspc->rq =3D rq;
> +			/* stash @prev so nested dispatches can access it */
> +			rq->scx.sub_dispatch_prev =3D prev;
> +			SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq, scx_cpu_arg(cpu),
> +				    pcpu->reported_ecaps, ecaps);
> +			rq->scx.sub_dispatch_prev =3D NULL;
> +			scx_flush_dispatch_buf(pcpu->sch, rq);
> +			pcpu->reported_ecaps =3D ecaps;

[Severity: High]
Does this sequence create a use-after-free of pcpu?

In scx_process_sync_ecaps(), the pcpu node is unlinked via init_llist_node(=
pos).
Later, scx_flush_dispatch_buf() might drop the runqueue lock if it dispatch=
es
to a remote CPU's local DSQ (e.g., via dispatch_to_local_dsq()).

If the lock is dropped, scx_discard_ecaps_to_sync() executing in the RCU wo=
rker
can acquire the lock, observe !llist_on_list(), and return, allowing the
pcpu structure to be freed.

When scx_flush_dispatch_buf() finishes and reacquires the lock,
scx_process_sync_ecaps() then writes to the freed pcpu:

    pcpu->reported_ecaps =3D ecaps;

> +		}
> +	}
> +}

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
> +			if (!scx_enabled() || !scx_rq_online(rq)) {

[Severity: High]
Could this destructively drop valid queued syncs for active sub-schedulers?

If a sub-scheduler is being freed via scx_sched_free_rcu_work() concurrently
with CPU hotplug (scx_online_ecaps()), scx_rq_online() checks SCX_RQ_ONLINE.
This flag is set by sched_set_rq_online() after the CPU comes online.

During the window where !scx_rq_online(rq) is true, discard_queued_syncs()
deletes all queued syncs for all sub-schedulers via llist_del_all().

Checking !cpu_active(cpu) instead (as in scx_process_sync_ecaps) might avoid
this race.

> +				discard_queued_syncs(rq);
> +				return;
> +			}
> +		}
> +		resched_cpu(cpu);
> +		msleep(1);

[Severity: High]
Can this loop hang indefinitely if the target CPU is saturated with higher
priority tasks?

The loop spins waiting for the target CPU to process the pending ecaps sync.
The node is removed when scx_process_sync_ecaps() runs on the target CPU,
which is called from balance_one().

Because ext_sched_class has a lower priority than FAIR or RT classes,
if the target CPU is continuously executing higher priority tasks,
balance_one() is never called. The RCU worker thread will spin forever
waiting for !llist_on_list().

> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D19
