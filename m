Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6019AD90
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384702; cv=none; b=US6u7+HN6P2TAItCcRNXkaes38Yo8vTpNSyX2hsT4AA6NccdAdllQs9Hx66Al+ZuaSbg+I0ZG7oKez4uCpy/KzPIQU5aAw03zh1GA/LevWYO7uwDCdSjUuYEt7NQU1lB1FBgQscVue6iBQQmYKj4fgByja92oRP4mVIbwqWfcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384702; c=relaxed/simple;
	bh=JeYBbiS/6oH2ooVptr6iCmUXqodHVLfvRmxLV+Pg6O4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fjX+NlI7GnLDBhaPripEHmjnw0Ni/HokHR0rWZCqtQX1vkTDEd2dLgtHWgqmZB/hXBdDDUK2X3nCYEvR3GK47hPuDWkFsZU0pJ7S9RR3mpiqBJNYtypAJjA/epM2Z8b3FR9dLD5jORdUSeIiAhHxric3pYBOpUxzK3ndAtmEdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYXc1hlO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYXc1hlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF11F000E9;
	Tue,  7 Jul 2026 00:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384700;
	bh=I2ddDyB27Psxs7PNoaoptZwCQyoNL02LFjrpSkhXbF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kYXc1hlOx9/Iykyb/wY//ZkXsT2CtnrRb8PJRlR/pk+ykSK3DenI0G6WtXlJxrZkX
	 hQ/GLxx4pXuVHDtgZqOUewiqqwTdiBdC6xJ8CTKLiMa18IUVTkIvaqet+azpYiVnjs
	 pjQSJNxo3fXOrg5eXIOHvMaCYfGHhv4+RB60IY+OFdwcmQ2bh/gLqB0K/YpRUqgCqM
	 TirG/7cJNcGoen12k8rdWkwZqyQtgvCa0UVx5mhN/7ir9LvD+oQjBf+HdgeqjoJgBz
	 V6K9x3qc5hihgrkXO/AIH/5wIHDi2sEBmcNQmaz1U882LzctRaXPpi9L8rcopvjNcd
	 RINcESGfMlVxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 21/36] sched_ext: Maintain per-cpu
 effective cap copies for single-read checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-22-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-22-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:38:20 +0000
Message-Id: <20260707003820.B2BF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional dereference of global CID routing tables in `scx_pro=
cess_sync_ecaps()` leads to NULL pointer dereference on error paths and out=
-of-bounds reads during layout updates.
--

--- Patch [21]: [PATCH v3 sched_ext/for-7.3 21/36] sched_ext: Maintain per-=
cpu effective cap copies for single-read checks ---
commit c2d60606de278d78c865d3844ddc3d528eebcab1
Author: Tejun Heo <tj@kernel.org>

sched_ext: Maintain per-cpu effective cap copies for single-read checks

This commit introduces a per-cpu effective caps copy for a scheduler to
avoid awkward race conditions when checking multiple cap bits. The new
effective copy, ecaps, is updated safely under the rq lock and can be read
locklessly.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index a1c061b6e7be4..4e96234379bb0 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> +/**
> + * scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
> + * @rq: the cid's cpu rq
> + *
> + * pshard->caps[] is the target configuration. pcpu->ecaps is the effect=
ive
> + * transposed copy owned by the cid's cpu and written only here under @r=
q's
> + * lock.
> + */
> +void scx_process_sync_ecaps(struct rq *rq)
> +{
> +	s32 cid =3D __scx_cpu_to_cid(cpu_of(rq));
> +	s32 shard =3D scx_cid_to_shard[cid];

[Severity: High]
Can this result in a NULL pointer dereference or an out-of-bounds read?

If loading the first SCX scheduler fails due to memory constraints in
scx_cid_arrays_alloc(), scx_cpu_to_cid_tbl remains NULL. The cleanup path
scx_sched_free_rcu_work() unconditionally invokes scx_process_sync_ecaps()
via scx_discard_ecaps_to_sync(), which would dereference the NULL table her=
e.

Additionally, when rapidly replacing an active scheduler, the new scheduler=
's
scx_cid_init() temporarily resets scx_cpu_to_cid_tbl entries to -1:

	/* -1 sentinels for sparse-possible cpu id holes (0 is a valid cid) */
	for (cpu =3D 0; cpu < nr_cpu_ids; cpu++)
		scx_cpu_to_cid_tbl[cpu] =3D -1;

If the old scheduler's asynchronous RCU cleanup work invokes
scx_process_sync_ecaps() concurrently, it reads the -1 value and uses it to
index scx_cid_to_shard[-1], resulting in an out-of-bounds read.

Would it be safer to move the cid and shard evaluation after the
llist_empty() check below?

> +	struct llist_node *batch, *pos, *tmp;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (likely(llist_empty(&rq->scx.ecaps_to_sync)))
> +		return;
> +
> +	batch =3D llist_del_all(&rq->scx.ecaps_to_sync);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D21
