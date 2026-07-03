Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084213E2773
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088902; cv=none; b=drOauEKqVIVlqUagGxPfEFKCrXMSrKss6MkKHUoUD8QjBucOifg/eqyb862KQaVXXG7FLih9VCHJjOAw44ZjBIgtFhXNgEqk5zYgR6Tlbwi8DMf1DsOTAGXBarTbm62e8XhvI49QfG6Z8G7l4IkhscbFaBs/Pefj4awu0BP1/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088902; c=relaxed/simple;
	bh=9k4bSA/To1c+noLGOo+uJ0E9zwrJo5NJ6rso7HaOiIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yr6a28c61U7mRZWGXEhJbpislJHM7wV0ioU0WnzQZiaTGIUtM3pIclK5Z+R1p+Lo5Nq/q1q0kGGxKCoK8g4QAbqV1uwm82+c4gmY9sCAh0auD+nb1+UtXkRcz3MlgNiGAzREYJYDIr7BKchnnDGbXx2wFlmdNgqAbAJtSYX0EHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6BQbW0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6BQbW0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C601F00A3D;
	Fri,  3 Jul 2026 14:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783088896;
	bh=laKGrYmK3Tv2vyvinKa2Xj63qxAarnhaglpyPe8+bNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6BQbW0HGIB8aIlnFG5rXeDVomiS8xlRiJyPnCAHH2F8uGq179TfYfQj418wpObB2
	 HBsvTpiX6jAU0CSrnrSOynAgHkj+3LB2mRs8+T63BzAR1AxliKkZqH0nYDi4VHEyi2
	 KvlpF8qbJV5EX8Lm8WTyY5Mua5QEG7siWPFMF1CxD95RkUKXwAeJM0L/cZk1ee4YxE
	 IOguH2Us39GygGfvXE5ponOpisSjt0nahupuyeZUWfWlUIrfPPOosEkj0K5jauc8Wa
	 Pnrm3wVVJc4A+pP7W1DddmYwxj3Md1tC3mDMpAAeV464uXBGlq1KnrzPIiwbOykzUf
	 Ki1EmiWm+114A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 29/32] sched_ext: Replay ecaps
 notifications suppressed by bypass
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-30-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-30-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:28:15 +0000
Message-Id: <20260703142816.30C601F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent CPU hotplug, bypass toggle, or scx_bpf_sub_grant() cras=
hes due to a NULL pshard dereference when a cpu-form sub-scheduler is linke=
d but not yet rejected.
--

commit 8e75c7343c899785bda5b0be0886c20991519a76
Author: Tejun Heo <tj@kernel.org>

sched_ext: Replay ecaps notifications suppressed by bypass

scx_process_sync_ecaps() consumes ecaps syncs while the sched is bypassing
without delivering ops.sub_ecaps_updated(), leaving reported_ecaps stale.
This patch re-queues a sync for every (sched, cpu) with an undelivered delta
at the per-cpu bypass exit in scx_bypass(), next to the idle renotify
catch-up.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 90caf76db8bf6..15edcf4f81ee2 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
[ ... ]
> @@ -550,6 +550,41 @@ void scx_process_sync_ecaps(struct rq *rq, struct ta=
sk_struct *prev)
>  		scx_schedule_reenq_local(rq, SCX_REENQ_CAP_REVOKE);
>  }
> =20
> +/**
> + * scx_unbypass_replay_ecaps - Replay a bypass-suppressed ecaps notifica=
tion
> + * @rq: rq of the cpu leaving bypass
> + * @sch: scheduler that just left bypass on @rq's cpu
> + *
[ ... ]
> + */
> +void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch)
> +{
> +	s32 cpu =3D cpu_of(rq);
> +	struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(sch->pcpu, cpu);
> +	struct scx_pshard *ps;
> +	s32 cid;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	/* root holds every cap and never uses ecaps */
> +	if (!sch->level)
> +		return;
> +
> +	if (READ_ONCE(pcpu->ecaps) =3D=3D pcpu->reported_ecaps)
> +		return;
> +
> +	cid =3D __scx_cpu_to_cid(cpu);
> +	ps =3D sch->pshard[scx_cid_to_shard[cid]];
> +
> +	guard(raw_spinlock)(&ps->lock);

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but this new function also appears to be affected by it. Can this cause a N=
ULL
pointer dereference if sch->pshard is NULL?

If a user attaches a cpu-form scheduler (where !sch->is_cid_type) as a
sub-scheduler, scx_alloc_pshards() returns 0 without allocating sch->pshard.
The scheduler is then added to the descendant tree via scx_link_sched().

Before it is rejected by scx_validate_ops() and unlinked, a concurrent
parent lifting bypass can trigger this new scx_unbypass_replay_ecaps()
path, unconditionally accessing sch->pshard.

This pre-existing issue also seems to affect scx_online_ecaps(),
scx_bpf_sub_grant(), and scx_bpf_sub_revoke() where pshard is accessed
unconditionally. Could this be triggered by a concurrent CPU hotplug or BPF=
 call
during this window?

> +	queue_sync_ecaps(sch, cid);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D29
