Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39C223DFF
	for <sched-ext@lists.linux.dev>; Sun,  4 Oct 2026 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791078125; cv=none; b=bQiCuAPB/c2DNBWTHdU21ZtNngDkSNyFjOPc2tzX7H8CmDUTARABI2/Hi4KRtfPI74dPnchfYyX7/ta0TuL2Eq4SgZqxBWeH0263yIKmIWADJC1cWb4G+LMIyv2oC6c826aWMMLzcqBWkOZYNv9fvGJLMax4I/YIaSoXRADEISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791078125; c=relaxed/simple;
	bh=qfHdPS7v6Q4cysWE6YSTa8T7aEmCV6mvFrLZKVJv6kA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G8H8HDamJI/HA+x/+giaOeowfuF+gp4WizRoxH80Szo6tcRQ4P4whZApm5u9HAjkcAhpYIPwQCz47c4Dqx55VxFX2fjIAqCQ2KLV7E3HcsM0Eux2zcFZLEZF1QoXwSxvptQCeTgj41nAxs9gsCcoXzDgKaUwMxStMOkmm0sLwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgxd8Qgs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgxd8Qgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F8A1F0089B;
	Sun,  4 Oct 2026 01:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791078123;
	bh=B8Sv3F9YlL9Xe0bpru42ffPSyL/xKtCO4gJxsXKzOg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zgxd8Qgs+Bf8BzcZoQ1n7x4kUCcuPuOxx1j2VTioEjaN1L1AXrBmhk+HnRnwxOM4s
	 2lMcjlJBSap6WLJ7p5h4gNWGzo5VjEyz7Xo+bIopHrs4d2mEV1PFENGYsvn+v20jK5
	 teTpejwZeIpa6jG+gQlXKFxvhXREFOiBgTSVtrxVcVFidKtExIlddR1njhdwzkfYng
	 T/Wj8JkLN9cVAGBM9XidxPTTFrVyCDqzwzgzXZDb+t+Rr2ljq9fMFu/Mdvk9FH7wyA
	 JVcDkslUgxA5Osu/kkn00527gQaxvsQP2HO5GlYgKfsVnlw97hjLFgdbYd96K57gcI
	 cYsA2VYFThcYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Reset cpuperf_target when a sub-scheduler
 loses SCX_CAP_PERF or dies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261004012721.615419-1-cui.tao@linux.dev>
References: <20261004012721.615419-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 01:42:02 +0000
Message-Id: <20261004014203.49F8A1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] sched_ext: UAF on scx_cid_to_cpu_tbl in scx_sub_reset_cpuperf() on=
 teardown
- [Medium] sched_ext: TOCTOU race in scx_cpuperf_queue_reset() triggers off=
line CPU WARN
- [Medium] sched_ext: offline CPUs retain stale cpuperf_target causing freq=
uency pinning
--

commit 8df3a4e837553ee14c5a70ecea2b4bec546c3881
Author: Tao Cui <cuitao@kylinos.cn>

    sched_ext: Reset cpuperf_target when a sub-scheduler loses SCX_CAP_PERF=
 or dies

This commit introduces a mechanism to reset rq->scx.cpuperf_target to the
neutral SCX_CPUPERF_ONE base when a sub-scheduler that wrote targets loses
its capabilities or dies. It queues per-CPU irq_works to perform the reset
under the target CPU's rq lock, and skips offline CPUs.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 0554448835bd0..38e48e4648da5 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -28,6 +28,57 @@
>   */
>  DEFINE_STATIC_KEY_FALSE(__scx_has_subs);
> =20
> +/*
> + * Reset rq->scx.cpuperf_target back to the neutral SCX_CPUPERF_ONE base
> + * when a sub-scheduler that wrote targets loses SCX_CAP_PERF or dies. T=
he

[ ... ]

> +/*
> + * Queue a reset of @cpu's cpuperf target. Idempotent: the work is alway=
s a
> + * plain restore of the neutral base, so concurrent queues collapse into=
 one
> + * run; CPUs that never had a sub-scheduler target no-op.
> + */
> +static void scx_cpuperf_queue_reset(s32 cpu)
> +{
> +	if (cpu < 0 || cpu >=3D nr_cpu_ids || !cpu_online(cpu))
> +		return;

[Severity: Medium]
If the CPU is already offline when this function is called, the early return
skips resetting the target. Does this leave the offline CPU with a stale
cpuperf_target in its rq, permanently pinning the CPU to a low frequency
when it comes back online?

> +	irq_work_queue_on(&per_cpu(scx_cpuperf_reset_iw, cpu), cpu);

[Severity: Medium]
Since cpu_online() is checked without preemption disabled or any hotplug
locks held, is there a TOCTOU race window here? If a concurrent CPU offline
operation clears cpu_online_mask immediately after this check, wouldn't
calling irq_work_queue_on() trigger a WARN_ON_ONCE(cpu_is_offline(cpu))?

> +}

[ ... ]

> +static void scx_sub_reset_cpuperf(struct scx_sched *sch)
> +{
> +	s32 si, cid;
> +
> +	if (!READ_ONCE(sch->pshard))
> +		return;
> +
> +	for (si =3D 0; si < sch->nr_pshards; si++) {
> +		struct scx_cmask *cm =3D &sch->pshard[si]->caps[__SCX_CAP_PERF].cmask;
> +
> +		scx_cmask_for_each_cid(cid, cm)
> +			scx_cpuperf_queue_reset(__scx_cid_to_cpu(cid));

[Severity: High]
This relies on __scx_cid_to_cpu(), which locklessly dereferences
scx_cid_to_cpu_tbl. Since scx_sub_reset_cpuperf() is called after dropping
scx_enable_mutex, if scx_root_disable() concurrently nulls and frees the
tables, wouldn't this cause a UAF or NULL pointer dereference?

> +	}
> +}

[ ... ]

> @@ -1631,6 +1715,13 @@ void scx_sub_disable(struct scx_sched *sch)
> =20
>  	mutex_unlock(&scx_enable_mutex);
> =20
> +	/*
> +	 * @sch can no longer receive grants or writes: queue a cpuperf reset
> +	 * for every CPU it held SCX_CAP_PERF on so schedutil doesn't keep
> +	 * consuming the targets it left behind.
> +	 */
> +	scx_sub_reset_cpuperf(sch);

[Severity: Medium]
This calls scx_sub_reset_cpuperf() with preemption enabled and without
any hotplug protection, exposing the cpu_online() TOCTOU race mentioned
above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004012721.6154=
19-1-cui.tao@linux.dev?part=3D1
