Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B844D37DA
	for <sched-ext@lists.linux.dev>; Mon,  5 Oct 2026 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223815; cv=none; b=EImxyPk+bAMQPE0PBZi6vey/PZQcRv//MnMhK4OZtBhOF6Cb1eGmBOhO3+LK1z6jx6TG7khcKx0/Qyq8zIS9wbeGoPRD1xWXijfoSZpq8g/b8YKOLd2PQqibdUzJyuPrkKN/mP95HkoF/fP2cLMFNOdcAcsiMArONmkqbtDDajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223815; c=relaxed/simple;
	bh=gTJZmdpCurjkUHjw3izyVlwCNVUpx5u3q/ZOl8eJgO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TnDTPbqH+O+v1EHQWZ+a8AtcZ10jWOzQBz9FJLptNeMcS3x5H85cWCsE6UidPJGVqBsmvintk8zI+1HoTm7YuOLeelcS2LrGTliKQejZZWOknKgkiFSwnQ2i3Tm1LdIutiotjg9IfWuVG0wXNEyJS7IbRPFAqaAQOqBOHx6e3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFqHO5tj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFqHO5tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E6B1F000FF;
	Mon,  5 Oct 2026 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791223813;
	bh=ILKMJFgSdS8PtzdG9hyAg8gqnIb5Gx2Nkm55IZ2f6ws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fFqHO5tjvreS7Zh8HINz5EZqpfUlvoB0paXzwMzVs8Q8gVRWZQ+nEX5OJA2Ad27sX
	 FroJuj+KILHmBs4wNYY0uUdks/9R7Wom9G1rMYaR+M8k1BRyu2z4dshIVsUcZojpPC
	 f7i4Of/Sgm+JCcPxMinOf5fjIykf6SjiRcWEwyQCMi9nhxRUMJdjXXm0XwsolibQcV
	 z2/a89M6UeaRv14Sv6QNWTchJiiCeXaBpNYc7CsMGjxE5e7zYUDHwsdZtldibevIRh
	 cWC0pxWPiT2DoXu+3T6KEaW6vAFL6gvBlvRbdI4jOMl8tScXJOB+h4ZxIE4fzV/0L0
	 LYdIYzZkEFaHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] sched_ext: Add ops.sub_cid_sched_updated() to
 report the sched running on a cid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261005175520.2756986-2-tj@kernel.org>
References: <20261005175520.2756986-1-tj@kernel.org>
 <20261005175520.2756986-2-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 18:10:12 +0000
Message-Id: <20261005181013.43E6B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sched_ext: skipped NONE notification for the last active schedul=
er
--

commit 24e8930bf2fb59df3460d85d232da97c8cc5102f
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add ops.sub_cid_sched_updated() to report the sched running on a=
 cid

This commit adds ops.sub_cid_sched_updated() to report changes in the
scheduler running on a specific cgroup ID. It maintains the notification
state using a static key that is disabled when the last interested scheduler
goes away.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 6b964743cab9b..59fc506af817e 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -92,6 +99,161 @@ struct scx_sched *scx_next_descendant_pre(struct scx_=
sched *pos, struct scx_sche

[ ... ]

> +void scx_cid_sched_update(struct rq *rq, struct scx_sched *sch)
> +{
> +	struct scx_sched *prev =3D rq->scx.sched;
> +	s32 level, common =3D -1;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (!static_branch_unlikely(&__scx_ops_cid_sched_updated_enabled) || pr=
ev =3D=3D sch)
> +		return;

[ ... ]

> +void scx_ops_cid_sched_updated_disable(struct scx_sched *sch)
> +{
> +	bool last;
> +	s32 cpu;
> +
> +	lockdep_assert_held(&scx_enable_mutex);
> +
> +	last =3D SCX_HAS_OP(sch, sub_cid_sched_updated) && !--scx_nr_ops_cid_sc=
hed_updated;
> +	if (last)
> +		static_branch_disable(&__scx_ops_cid_sched_updated_enabled);
> +
> +	/*
> +	 * Re-homing restarts a running task's session under its new sched. A
> +	 * task that blocked while its cpu's dispatch had the rq lock dropped is
> +	 * put and set next again without a restart, so rq->scx.sched keeps @sch
> +	 * until the pick completes:
> +	 *
> +	 *   cpu 0, __schedule()                 cpu 1, scx_sub_disable(@sch)
> +	 *   T of @sch blocks, stops running
> +	 *   dispatch drops the rq lock
> +	 *                                       re-home T, nothing to restart
> +	 *                                       this sweep
> +	 *   pick N, N's session opens
> +	 *
> +	 * Closing the session here reports NONE to @sch and its ancestors now
> +	 * and lets the pick report N's sched from NONE instead of from @sch.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct rq *rq =3D cpu_rq(cpu);
> +
> +		guard(rq_lock_irqsave)(rq);
> +		if (rq->scx.sched =3D=3D sch)
> +			scx_cid_sched_update(rq, NULL);

[Severity: Medium]
When disabling the last active scheduler, does this disable the static bran=
ch
too early?

In scx_ops_cid_sched_updated_disable(), if this is the last scheduler, the
static branch is turned off before the loop:

    last =3D SCX_HAS_OP(sch, sub_cid_sched_updated) && !--scx_nr_ops_cid_sc=
hed_updated;
    if (last)
        static_branch_disable(&__scx_ops_cid_sched_updated_enabled);

Then, the loop calls scx_cid_sched_update(rq, NULL). However,
scx_cid_sched_update() starts with an early return if the static branch is
disabled:

    if (!static_branch_unlikely(&__scx_ops_cid_sched_updated_enabled) || pr=
ev =3D=3D sch)
        return;

Will this cause the final NONE state notification to be silently dropped for
the last BPF scheduler unloaded?

> +		if (last)
> +			rq->scx.sched =3D NULL;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005175520.2756=
986-1-tj@kernel.org?part=3D1
