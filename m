Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873433955F9
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080312; cv=none; b=H2xgNa/PmyIHXD/T8e6s089/B2Nq6Tuq/pIpl18Etoha7GhaiGS1i8Lo9fAKZYs5LWWabYkAijJiGE7XCAYVwT/xzYUVXLCqKeC41QZQrJMYg/g1Yb+KgaUmJTlTS8I3hqeo9P5khTlLE0VHB6/K3WfDCoOXrJVAV3lLQfDu57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080312; c=relaxed/simple;
	bh=A1WlNA2dDug43A6jShG6C3JJI0fiSQNyxRT2xjtnFY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cJ8zBgVkkdeLhUvOv3PpDdIRGFMIsc5aoX0QdQWKYEPsY+SylY3SDtAUuUonadqkhJOv8qwHWQJCA+XxkyeYI4M1ueN6MsmegH/xC1oWONa9GKwCGa0zdPrOSVq7T9kbCD8fLx/8apV5YixZuQ/GkB3YOrGmQXsKZl90VnsxlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz4+mR+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz4+mR+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474CC1F000E9;
	Fri,  3 Jul 2026 12:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080311;
	bh=Eqfy9mPomb+GUrms6XKpLjeGLkhCetxRgxvT8WZQSEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bz4+mR+qkdkP9L5EsyT01Okqa95a6RPJGlFj1isxKk8oe/AUyZi1hPl+IGbUday6n
	 53RSbnJcq/wGk9dt4wNUOMA/rG35Ipw0GKQwnh5b9XgY+hhFolOYlju8yuaq7ViHLt
	 nDfKtoNMbtLYNuSWELfhiKBgSUHnPtDH1tp45E6CI2S9BVS0RrxofjV11rqlMiZwMK
	 dT3n/9t7m6t8EM4ApKtWNHhIvOfHJW6b3dWu/mt53pMdBY9DDzlyyQxGtyOlpo2PEq
	 Vk6+b0MRsulZ8W7phnH3HRVc//TqUUMqzNTP6vP3fFt0vtR953g9KEueaydFDiRZ5c
	 yCWU6dsL4NctQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 18/32] sched_ext: Maintain per-cpu
 effective cap copies for single-read checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-19-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-19-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:05:10 +0000
Message-Id: <20260703120511.474CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional array indexing with a potentially negative CID in `s=
cx_process_sync_ecaps()` causes out-of-bounds reads for CPUs without a vali=
d CID.
--

commit 8b6bde8377767baa9501eb855a3f0e41f5b5ad02
Author: Tejun Heo <tj@kernel.org>

sched_ext: Maintain per-cpu effective cap copies for single-read checks

This commit introduces scx_sched_pcpu->ecaps to maintain per-cpu effective
capability copies. Grant and revoke operations queue sync requests on the
target CPU's runqueue, which are then processed locklessly under the rq loc=
k.

[ ... ]
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index c821d604ac9da..08d9367cf2188 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
[ ... ]
> @@ -283,6 +283,125 @@ static void scx_sub_seed_caps(struct scx_sched *sch)
>  	caps_updated_deliver(&to_deliver);
>  }
> =20
[ ... ]
> +void scx_process_sync_ecaps(struct rq *rq)
> +{
> +	s32 cid =3D __scx_cpu_to_cid(cpu_of(rq));
> +	s32 shard =3D scx_cid_to_shard[cid];

[Severity: High]
Can this cause an out-of-bounds array access if the CPU does not have a val=
id
CID?

If scx_cid_init() fails, it can leave scx_cpu_to_cid_tbl with -1 sentinels
for some CPUs. The error handling then disables the scheduler, triggering
scx_sched_free_rcu_work() which iterates over all possible CPUs and calls
scx_process_sync_ecaps() on them.

Because scx_cid_to_shard[cid] is evaluated unconditionally here before the
llist_empty() check, a CID of -1 will index outside the scx_cid_to_shard
array and potentially cause a page fault.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D18
