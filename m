Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23168332EC8
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548209; cv=none; b=G8l2WnibohpmfxRT5BWFxiS41xFHv7jUcnz//wJFR7obZzwjP2OqvuxkLt/aaMjk/hX0iMc/MIkzedoPD4PQBf+d3ZRvR4689v/wktLnff5q7z2hM2aJ1kywvjnrjhYAm9o24CjkeeU1AN1MO0Q24BSl0YNIhCBJiXPfv8Xor8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548209; c=relaxed/simple;
	bh=9SXdoRGvfUyudPGVKz9uuusIgYxnUz3h9cRMlPLPMkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n+CkkVRUUy0iDIaQXOVSklMhbqSDZrMnxNk2L5k01ryYuGoLB5AkYWb7/bHnfiC+W3V0nBxKNNVAyarOQnifMMFlR6fgs7/G0+8Qb6aAWx9CxZPNL6jc42DZhHnqYzY9RxSqTJo9Ad2jPGbflzYK64chE2DOoFlHC8XxcRu5OmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPoPFIkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPoPFIkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA8B1F000E9;
	Wed,  8 Jul 2026 22:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783548207;
	bh=TjTjqfBaoauyuouO3swIlXMKcktZ8FO/D3kZOwaYOMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gPoPFIkSqJu8VDWxQYLlyW0t1BIup+2y3wx1g9mOu8PL1PHpXwZs7JwBs8RSJ11sN
	 ARG9vbdb/1je0JFGfcZojf28eoul/VklJiZNPCtpKUgjCGAVjz3r8WPKsdjAJTKMtw
	 +113l3DXQ4u1MZRCDwi1rtNAKEUzQiitniQRcE3DpOCcnlM9uGeRVMQAmbLPX/7TL1
	 DDw8xaXRT3V2DJR8hamuJlLIjXfe5mloUKuiD7X9YLm6wAKzvjxXC04YiE6j/P0aPc
	 OrqGZELQy7BLYKsegQDzQYrRwMsfTnKunFU5i4LRSPaRnJPkUZxT8a8NkjFyw23UcJ
	 fUiLUOKipDG0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 23/40] sched_ext: Maintain per-cpu
 effective cap copies for single-read checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-24-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-24-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:03:27 +0000
Message-Id: <20260708220327.7BA8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional evaluation of `__scx_cpu_to_cid(cpu_of(rq))` and `sc=
x_cid_to_shard[cid]` in `scx_process_sync_ecaps()` causes a kernel crash (N=
ULL pointer dereference) during initialization failures.
- [High] Naked and unchecked use of the global `scx_root` pointer in `queue=
_sync_ecaps()` causes a NULL pointer dereference if the root scheduler is c=
oncurrently disabled.
--

--- Patch [23]: [PATCH v4 sched_ext/for-7.3 23/40] sched_ext: Maintain per-=
cpu effective cap copies for single-read checks ---
commit 0633bda49e9d687035b71703d07c991f9fd41b6c
Author: Tejun Heo <tj@kernel.org>

sched_ext: Maintain per-cpu effective cap copies for single-read checks

This commit introduces per-cpu effective capability copies to optimize
capability checking in the scheduler. It collects the capabilities per cpu
so they can be accessed locklessly or under the runqueue lock. Grant and
revoke operations now queue sync requests which are processed by the target
cpu.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index ce2fa1409a205..80f74064ca781 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
[ ... ]
> +static void queue_sync_ecaps(struct scx_sched *sch, s32 cid)
> +{
> +	s32 cpu =3D __scx_cid_to_cpu(cid);
> +	struct scx_sched_pcpu *pcpu =3D per_cpu_ptr(sch->pcpu, cpu);
> +
> +	/*
> +	 * Pairs with smp_mb() in scx_process_sync_ecaps(). Either the check
> +	 * below sees the node off the list and queues it, or the in-flight sync
> +	 * sees the caps[] update made before this call.
> +	 */
> +	smp_mb();
> +
> +	/* @cid's pshard->lock excludes concurrent queueing attempts */
> +	if (llist_on_list(&pcpu->ecaps_to_sync_node))
> +		return;
> +	if (llist_add(&pcpu->ecaps_to_sync_node, &cpu_rq(cpu)->scx.ecaps_to_syn=
c))
> +		scx_kick_cpu(scx_root, cpu, 0);

[Severity: High]
Is it safe to pass scx_root directly here without checking for NULL?

If the root scheduler is concurrently being disabled, scx_root might be res=
et
to NULL. Because BPF kfuncs like scx_bpf_sub_grant() can still be executing
in sleepable or tracing contexts during unregistration, could this lead to a
NULL pointer dereference inside scx_kick_cpu()?=20

Would using the local sch parameter instead resolve this safely?

> +}
[ ... ]
> +void scx_process_sync_ecaps(struct rq *rq)
> +{
> +	s32 cid =3D __scx_cpu_to_cid(cpu_of(rq));
> +	s32 shard =3D scx_cid_to_shard[cid];

[Severity: High]
Can these array indexing operations cause a kernel crash during early
setup failures?

If the BPF scheduler enable path fails before scx_cid_init() completes
(e.g., due to memory allocation failure), the global pointers like
scx_cpu_to_cid_tbl and scx_cid_to_shard remain NULL.

The error recovery path invokes scx_discard_ecaps_to_sync(), which calls
scx_process_sync_ecaps(). Because the cid evaluation and scx_cid_to_shard
dereference happen unconditionally before the llist_empty() check below,
this looks like it will cause a NULL pointer dereference.

Would moving the cid and shard evaluations after the llist_empty() check
avoid this?

> +	struct llist_node *batch, *pos, *tmp;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (likely(llist_empty(&rq->scx.ecaps_to_sync)))
> +		return;
> +
> +	batch =3D llist_del_all(&rq->scx.ecaps_to_sync);
> +	llist_for_each_safe(pos, tmp, batch) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D23
