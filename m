Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4A27B32C
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303867; cv=none; b=oCzw8Y+/bvCp3riP4W0wKRGvEGyrBTPUhBqe2c1Ov0EbUZ7CZT/I8EQmUwrJc6mBdjZaMdw59qODiqPJ4VeiBD9aBpsgbkVZiRcvE3itcK9yav6TS5DnIjX6eIEKUUb1k5fWhW1gNsQhN9x70qPCaoEJjCbbc9Lmlj/duiO5Ojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303867; c=relaxed/simple;
	bh=QA81rQWAcb9QXBVeMd9OFrCnk4n3/leLSLjJMsobZPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SGFgz17sWbN0URxYsI++0Wa9F2qH5ieMKn1yGjgYlLHOVd0vqL4go8SqopKuEB80licYpuhCAm+Zjf3dyX26BJ05KrhTAZCfbfgLM7wafDZPS7it75nlHb5G0k1HB2nFR2Jrzx2i3WWILgeOsoRxsHdsUpUvEvO/miz0zo1Xkio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoD1wEVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoD1wEVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007E11F000E9;
	Mon,  6 Jul 2026 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303866;
	bh=wAh7a9gjYDsqJVPpdmFqnHVoQfX4q6+buMZgGPI5VLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GoD1wEVkHIbN/jUi4YHaB17UM8Rw68iaZj0aqw2i37iwWNDZ6wAKJUXJoaSH/q2FB
	 /7wykHnR9K1wEGT3zhOr1NTnEfOPvmUAKBtMgpHhuzkR0vRy0vs4P1r4pYPkEOBUJS
	 udENdVqwjXrjTpPI7qe2I+HicimmFTUiklltwCkeWBEih7fuhEL1QnrIsz/yePyz8P
	 rjdxpT0nRbCeuQzJ4l9k3IIRUIUtxKe9UZVNEG1ODj7tPDTHhBOWV5urLriEE9elo1
	 FiwlHHiJDV3j0+tw7ntiPWL9FYhfNOzLChDHg7wS5AfQh7TRQAmJyjxNlhWvstSWyB
	 6QLEYTgdTNRcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 33/36] sched_ext: Replay ecaps
 notifications suppressed by bypass
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-34-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-34-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:11:04 +0000
Message-Id: <20260706021106.007E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Sub-schedulers without an arena map will cause NULL pointer derefe=
rences on CPU hotplug and capability grants because `sch->pshard` is never =
allocated.
--

commit 7d7e301d9f2fb22c82eefd485e4446d8b008e0c6
Author: Tejun Heo <tj@kernel.org>

sched_ext: Replay ecaps notifications suppressed by bypass

This commit queues an ecaps sync when a CPU exits bypass mode. This ensures
that initial capabilities granted during the enable bypass window are corre=
ctly
delivered to the BPF scheduler.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 5a48304b72a67..9e0643e3cecba 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
[ ... ]
> @@ -562,6 +562,41 @@ void scx_process_sync_ecaps(struct rq *rq, struct ta=
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
> + * scx_process_sync_ecaps() consumes syncs while bypassing without deliv=
ering
> + * ops.sub_ecaps_updated(), leaving reported_ecaps stale. Nothing re-que=
ues a
> + * sync when bypass lifts, so without a replay a cid that never changes =
again
> + * would never be notified. The attach-time initial grants are the acute=
 case
> + * as they are consumed during the enable bypass window. Re-queue a sync=
 for
> + * any undelivered delta so the next balance delivers it.
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
This is a pre-existing issue, but can this dereference a NULL pointer if the
scheduler was loaded without an arena map?

If a BPF scheduler using bpf_sched_ext_ops_cid is loaded without defining an
arena map, scx_arena_pool_init() returns 0 without allocating a pool.=20

Then in scx_alloc_pshards(), it silently succeeds without allocating pshard:

kernel/sched/ext/sub.c:scx_alloc_pshards() {
    if (!sch->is_cid_type || !sch->arena_pool)
        return 0;
    ...
}

Since pshard is never allocated, unconditional dereferences of sch->pshard
like the one here, or during CPU hotplug in scx_online_ecaps(), or during
capability grants in scx_bpf_sub_grant(), will cause a kernel panic.

Should scx_alloc_pshards() return an error when the arena pool is missing,
or do these paths need NULL checks?

> +	queue_sync_ecaps(sch, cid);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D33
