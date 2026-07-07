Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D572DF719
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384702; cv=none; b=sThI5MoHOY84gixR5K0EPTCw+WuNWu20FRDELbBPMPa1qRsid6pYVKwfPiNYw6Se6MttZ8R4bGnyF32QddlMEOaSBCsfxG4uFlLh7KczVUxv6Ct804Cq7Ci3fcZJRcbEqhPb9kRwCDE05Ju3gWn+ag8umQ32gynAGSftLs+N1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384702; c=relaxed/simple;
	bh=sDW1RhmopGG4d1Oaj3iHDcE6iTAbZKqZgTw+hoSktt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OMnF2jGH307CHMFudPm3g/3RtfpohYR1Iue57U1qNDUF8Wp0Syzvd9jzuXHzyzXpxrJmvcyrF+pRUSP52zf8Siy2RnaAYdvX01fMy5/JqFAC0uhv7mGG7tb61vSnvlzTsZGopFdeKIcCYhcnjT17jGi3zdUQCjNgqeLPt/nWl5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu0HEWY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu0HEWY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682BC1F00A3A;
	Tue,  7 Jul 2026 00:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384701;
	bh=CMMZ3heE/tuXPs5Iyl5WYqsgyvKKMq9ISJa1G1xbavc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yu0HEWY6m1cxwa9ugEQ+JQaUC7v7iY6izqR6ETYpcK+vs75KGcOK8yiq1NIKwbGhe
	 zLBKdwFDMbh7+ouEoQ9/MdVA6H8gQOnGflm8U6JDJ+zf8qihYNti/9yxN/tqGzeP9y
	 ib9V0U1NZbm+CDZoEl0H2IHfCowIpcc5SVUSYHpJzmOC25pE3+6wQOE+K3t9JrvlyP
	 YD/yKeP/ZsKYn6xPlEYJCt0QtMJGQZ2Rabu5Cww0HqCeC+DkGAf+PNNgIGIvEzCck0
	 S5xIB4UKO9yzmERI7i+YaENYFzbs07jU2KtRijRvDMKyVQIuvqbxaddaFohBZko/Ee
	 zeJA0XqiJwo1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 28/36] sched_ext: Tie cpu occupancy
 to SCX_CAP_BASE through the task slice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-29-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-29-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:38:21 +0000
Message-Id: <20260707003821.682BC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A TOCTOU race in `scx_bpf_task_set_slice()` allows a BPF scheduler=
 to corrupt a task's CPU slice and bypass capability revocation.
--

--- Patch [28]: [PATCH v3 sched_ext/for-7.3 28/36] sched_ext: Tie cpu occup=
ancy to SCX_CAP_BASE through the task slice ---
commit 8aeba2787a919bb08e865800095c6140014e82bf
Author: Tejun Heo <tj@kernel.org>

sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice

This commit ties CPU occupancy to SCX_CAP_BASE through the task slice to
ensure sub-schedulers respect revocable capabilities. It introduces out-of-=
band
slice requests when the runqueue lock is not held.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index dd605acf0f572..1428630d2dd4c 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -8634,20 +8786,45 @@ __bpf_kfunc_start_defs();
>   * @slice: time slice to set in nsecs
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF pr=
ogs
>   *
> - * Set @p's time slice to @slice. Returns %true on success, %false if the
> - * calling scheduler doesn't have authority over @p.
> + * Set @p's time slice. @p must be on the calling scheduler. The value is
> + * applied whether or not the caller holds @p's rq lock - see the slice =
write
> + * rules above for the ownership model.
> + *
> + * Raising the slice is honored only while the scheduler holds %SCX_CAP_=
BASE on
> + * @p's cpu, otherwise it is counted in %SCX_EV_SLICE_DENIED. Shortening=
 is
> + * always allowed. On the stashed path the slice is packed into an atomi=
c64_t
> + * with the scheduler id and a flag bit, so a slice too large to fit is =
clamped
> + * and counted in %SCX_EV_SLICE_CLAMPED. %SCX_SLICE_INF is preserved.
> + *
> + * Return %true on success, %false if @p is not on the calling scheduler.
>   */
>  __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
>  					const struct bpf_prog_aux *aux)
>  {
>  	struct scx_sched *sch;
> +	struct rq *rq =3D task_rq(p);
> =20
>  	guard(rcu)();
>  	sch =3D scx_prog_sched(aux);
>  	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
>  		return false;
> =20
> -	set_task_slice(p, slice);
> +	/*
> +	 * Directly write only when we are the owner of @p. See the slice write
> +	 * rules above.
> +	 */
> +	if (scx_locked_rq() !=3D rq || !task_on_rq_queued(p)) {

[Severity: High]
Can a Time-of-Check to Time-of-Use (TOCTOU) race happen here with remote
wakeups?

If a BPF program on CPU 0 calls scx_bpf_task_set_slice() on a sleeping task
that last ran on CPU 0 while CPU 0 holds its runqueue lock:

1. rq =3D task_rq(p) locklessly reads p->cpu as 0, caching CPU 0's runqueue.

2. Concurrently, CPU 1 wakes up the task, updates p->cpu =3D 1, takes CPU 1=
's
   runqueue lock, and sets p->on_rq =3D TASK_ON_RQ_QUEUED.

3. CPU 0 checks scx_locked_rq() !=3D rq (false, as both are CPU 0's runqueu=
e)
   and !task_on_rq_queued(p) (false, since CPU 1 just enqueued it).

4. CPU 0 incorrectly believes it safely holds the lock for the task's curre=
nt
   runqueue, and proceeds to the direct write path.

> +		set_task_slice_oob(sch, p, slice);
> +		return true;
> +	}
> +
> +	/* under the rq lock: apply now, extensions gated on baseline access */
> +	if (slice > p->scx.slice &&
> +	    unlikely(scx_missing_caps(sch, cpu_of(rq), SCX_CAP_BASE)))

[Severity: High]
If the race described above occurs, won't cpu_of(rq) check capabilities
against the stale CPU 0 instead of CPU 1?

Furthermore, wouldn't the subsequent set_task_slice() call execute
concurrently while the task is actually running on CPU 1, potentially
corrupting the time slice and bypassing capability revocation?

> +		__scx_add_event(sch, SCX_EV_SLICE_DENIED, 1);
> +	else
> +		set_task_slice(p, slice);
> +
>  	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D28
