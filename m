Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E62D37BE95
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303681; cv=none; b=D9v4XerbjpLB7xPsqm/fSBG7N4xvGcE9YLoCM6BhhpRZgTQZMOoPrriDrOFguJlB8HgmZI19pVCxPR7AuPAHWcgnXPXEe+AimAHa+OU1mr9CRTHdwoS5fezGP80YPPbRBNrGQE2nE5YedIzCXK2jOvahSLkmbpyfFRLMo7TLg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303681; c=relaxed/simple;
	bh=EKMS83MUh0v4a8WujgIhzPHVTJJhZvlO3hk9d2QFKzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=im9CYEKIHrQlhMcxKuL0oB3s2qFiV/eU4mL3D15v5dH3X2WNPIunZvbGMhgNPIMi+zJs5XuzaiowC0GiTBgS0HhIcjVlMntXf7VYNq0ToEPLT3BsUPgL+KgkZ+LN9jBEm/K1wyMRGJbdL8gV8SWgChInQQJ5Iwq99LkfhDx0c1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrHpwpTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrHpwpTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2101F000E9;
	Mon,  6 Jul 2026 02:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303680;
	bh=Dn1ETiHpNZmcakhkMnrdE5kw2hKKNxzoy+PvE/1NI+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZrHpwpTZs+XxGR5eLL/4+cYgMNyrIwY/OYkXEm3gJpB44QvYtGoBndTkjU6d/bqZf
	 yNk+F6Lurr/B6CgTTrIPTVDMBHx8LsKpHomwN6EYXdLfqU3r1Ppnls7daheIpJO6GC
	 01nRZtPsnoXjpGwCrt/x7RAMssKk5Q2G0GCJZturWQ1+fgDTBArc7alJu7gdRILsKn
	 1iDdkv7MQPz7n7F4AOTaZ0BRoOPn+Q7adGAbLBQQeyrS3h1B15XHi35q0vu8aNLfRj
	 TkJDAfyrvknswDEkoHNqwc/qi9NVSWEt5i0tU3jlohEP4jHAnYbQbn+N9OZECWXvRu
	 tZjeh1JyhhN/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 21/36] sched_ext: Maintain per-cpu
 effective cap copies for single-read checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-22-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-22-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:07:58 +0000
Message-Id: <20260706020759.4A2101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Asynchronous processing of `ecaps_to_sync` races with a new schedu=
ler's `scx_cid_init()`, causing slab out-of-bounds reads in `scx_process_sy=
nc_ecaps()`.
- [High] `queue_sync_ecaps()` causes a NULL pointer dereference by passing =
the global `scx_root` pointer to `scx_kick_cpu()` during scheduler teardown.
--

commit d27a6ceed9961e91cdb8abb928e2d28ddbbb826a
Author: Tejun Heo <tj@kernel.org>

sched_ext: Maintain per-cpu effective cap copies for single-read checks

This patch adds per-CPU effective capability copies (ecaps) to avoid testing
multiple bits or encountering race conditions with caps[]. Grant and revoke
operations queue a sync request for the target CPU, which is processed under
the runqueue lock.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -287,6 +287,125 @@ static void scx_sub_seed_caps(struct scx_sched *sch)
>  	caps_updated_deliver(&to_deliver);
>  }
> =20

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
During scheduler teardown, scx_ops_disable() clears the global scx_root
pointer via RCU_INIT_POINTER(scx_root, NULL). If an active BPF program
triggers queue_sync_ecaps() while scx_root is NULL, could passing scx_root
here cause a NULL pointer dereference in scx_kick_cpu()?

Since queue_sync_ecaps() already receives a valid struct scx_sched *sch
parameter, would it be safer to pass sch to scx_kick_cpu() instead of
scx_root?

> +}
> +
> +/* discard @rq's queued ecaps syncs */

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
When a new root scheduler is enabled, scx_cid_init() temporarily resets
scx_cpu_to_cid_tbl[cpu] =3D -1 for all CPUs. If scx_process_sync_ecaps() is
called concurrently (e.g., from an active scheduler's balance_one() or a
dying scheduler's scx_sched_free_rcu_work()), could cid be evaluated as -1?

If cid is -1, evaluating scx_cid_to_shard[cid] would result in an
out-of-bounds read. Even if we move the llist_empty() check above these
lookups, a concurrent BPF execution calling scx_bpf_sub_grant() could queue
a new sync, allowing execution to reach the lookups with cid still being -1
and resulting in garbage values being used to index ps->caps.

Can we defer the cid and shard evaluations until after we are sure we have
work to process, or add bounds checking for cid?

> +	struct llist_node *batch, *pos, *tmp;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (likely(llist_empty(&rq->scx.ecaps_to_sync)))
> +		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D21
