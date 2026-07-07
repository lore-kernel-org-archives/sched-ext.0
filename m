Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155FF2DF719
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384863; cv=none; b=dzptGXZ9L3wQNM13P+x/RChle1+n1FrcmE0WC5l9xSjZB9Pt+lTaByPmfJ+MB43m3zTqoeLiQwULqAIXE1nZkc19euuTXyuoJHRMHbpR7QGLK9XOSvbT/WrngeLu2NqpyZ2LTOt3tp9Frb3/0HuDe4tjuQgKYATnaMJPLElcLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384863; c=relaxed/simple;
	bh=0g6eDb6AJ5CUDel4jDl3OsOF4feNYdOB47OH/nT0W80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QnCTxSaS2zSLGRPeztaa16o1WLUPp+k6aF719yk7S4hZdBpuQw/9uE1uHqyAZ+npK4Y9VP5dQ7ZMlpJWlY28QjtM+mCxNhw28APlWd+cTySurHC+GBxuVtcQu3cwKPjacwLFAOKO9+hQYUbCNavVbzIxggHcb+ymsiEz9d2va88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeCH5OrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeCH5OrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869821F000E9;
	Tue,  7 Jul 2026 00:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384861;
	bh=AsEqzDdOMmZVxCZjOMpTl/MOEsISmbpnsUTIwGvR5TA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PeCH5OrWDd9Mefgji+2IT68qP5E/N/LegKi2SXBEI+0iKhgfjVrmxf5wK5J2qKhhQ
	 xW4Mt8wAg0YFxQO/+rkH40AmPHWKscuq9ZA1juSyELMekHdIIAQiRwdcHU7axaUvHb
	 dahQrYnWHI8S9fAv2ayi3Pt3vA6nc1tUruJ9f3M6Opyv7IHSfBRFZDbjz18mkjZqCh
	 EMZW7xbsB+awxna3n+wFSyqlSpasdZjuN+U9AMlvQPals5hlMI+f963R/C2VNQYkE3
	 /mIWySdrb+jb0ockGu77p1lO+rkUUISoy5chuvzyCcxKWdM2pmtVjz/fDHRgUWclV1
	 aLcgO65p4uwRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 35/36] tools/sched_ext: scx_qmap -
 Expand hierarchical sub-scheduling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-36-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-36-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:41:01 +0000
Message-Id: <20260707004101.869821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Newly acquired exclusive CPUs are not added to `idle_cids.mask` =
if they were already idle when ownership changed, leading to lost wakeups.
- [Medium] Tasks pinned exclusively to delegated CPUs will be permanently s=
tranded in `SHARED_DSQ`.
- [Medium] `qmap_sub_attach` and `qmap_sub_detach` modify the `sub_sched_ct=
xs` array without synchronization, causing data races with timer-driven par=
tition updates.
--

--- Patch [35]: [PATCH v3 sched_ext/for-7.3 35/36] tools/sched_ext: scx_qma=
p - Expand hierarchical sub-scheduling ---
commit 1fbc1bc9a944e2dd17d65dc96b81e16ff548c984
Author: Tejun Heo <tj@kernel.org>
Subject: tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling

This commit expands scx_qmap to demonstrate hierarchical sub-scheduling
features in sched_ext, allowing a parent scheduler to delegate CPU
capacities to child cgroup schedulers. The parent splits exclusive
capabilities among itself and children based on weight, with leftovers
forming a time-shared pool.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index f6cfe63425d36..18afa975406de 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
[ ... ]
> @@ -567,12 +627,35 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct =
task_struct *prev)
>  	struct cpu_ctx __arena *cpuc;
>  	task_ctx_t *taskc;
>  	u32 batch =3D dsp_batch ?: 1;
> +	s32 owner;
>  	s32 i;
> =20
>  	if (dispatch_highpri(false))
>  		return;
> =20
> -	if (!qa.nr_highpri_queued && scx_bpf_dsq_move_to_local(SHARED_DSQ, 0))
> +	/*
> +	 * Sub-sched routing: a child-owned cid goes to its owner. Never run
> +	 * this node's own tasks on a delegated cid. Read without the guard.
> +	 */
> +	owner =3D qa.part.cid_owner[cid];
> +	if (owner =3D=3D CID_SHARED) {
> +		/* route to the live rr holder (0 =3D self, runs below) */
> +		s32 pos =3D qa.part.rr_pos;
> +		u64 holder_cgid =3D (pos >=3D 0 && pos < MAX_PARTS) ?
> +				  qa.part.rr_slots[pos] : 0;
> +
> +		if (holder_cgid) {
> +			scx_bpf_sub_dispatch(holder_cgid);
> +			return;
> +		}
> +	} else if (owner >=3D 0 && owner < MAX_SUB_SCHEDS &&
> +		   qa.sub_sched_ctxs[owner].cgroup_id) {
> +		if (scx_bpf_sub_dispatch(qa.sub_sched_ctxs[owner].cgroup_id))
> +			__sync_fetch_and_add(&qa.sub_sched_ctxs[owner].nr_dsps, 1);
> +		return;
> +	}

[Severity: Medium]
Could tasks pinned exclusively to delegated CPUs get permanently stranded on
SHARED_DSQ here?

If a task is pinned to a child's CPU mask, qmap_enqueue() nudges it to a
delegated CPU's local DSQ. Since the parent lacks the ENQ capability, the
kernel rejects it and re-enqueues it with SCX_ENQ_REENQ, placing it into
SHARED_DSQ.

However, when a delegated CPU executes qmap_dispatch(), it calls
scx_bpf_sub_dispatch() and returns immediately without ever pulling from
SHARED_DSQ. The parent's own CPUs cannot pull it because their cpus_allowed
mask does not match the task, which seems to leave the task stalled.

[ ... ]
> @@ -1065,6 +1149,486 @@ static int lowpri_timerfn(void *map, int *key, st=
ruct bpf_timer *timer)
[ ... ]
> +__noinline void apply_partition(void)
> +{
[ ... ]
> +	bpf_for(cid, 0, nr_cids) {
> +		s32 o =3D qa.part.cid_owner[cid];
> +
> +		if (cmask_test(cid, &qa.rr_cids.mask))
> +			continue;
> +		if (o >=3D 0 && o < MAX_SUB_SCHEDS)
> +			cmask_set(cid, &qa.sub_sched_ctxs[o].granted_cids.mask);
> +		else if (o =3D=3D CID_SELF)
> +			cmask_set(cid, &qa.self_cids.mask);
> +	}

[Severity: Medium]
Does this miss adding newly acquired exclusive CPUs to idle_cids.mask if
they were already idle?

When a child scheduler is detached, its delegated CPUs are returned to
self_cids.mask by apply_partition(). If a returned CPU happens to be
physically idle at that moment, qmap_update_idle() is not re-triggered by
the kernel. Because qmap_update_idle() ignores idle transitions for CPUs not
currently in self_cids.mask, the CPU remains missing from idle_cids.mask.

Will this cause tasks queued in the BPF FIFOs to stall, since subsequent
enqueues will fail to pick the CPU via pick_direct_dispatch_cid() and won't
kick it?

[ ... ]
> @@ -1219,12 +1827,37 @@ void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_s=
ub_detach_args *args)
[ ... ]
>  	for (i =3D 0; i < MAX_SUB_SCHEDS; i++) {
> -		if (qa.sub_sched_cgroup_ids[i] =3D=3D args->ops->sub_cgroup_id) {
> -			qa.sub_sched_cgroup_ids[i] =3D 0;
> -			bpf_printk("detaching sub-sched[%d] on %s",
> -				   i, args->cgroup_path);
> -			break;
> -		}
> +		if (qa.sub_sched_ctxs[i].cgroup_id !=3D args->ops->sub_cgroup_id)
> +			continue;
> +
> +		qa.sub_sched_ctxs[i].cgroup_id =3D 0;
> +		qa.sub_sched_ctxs[i].weight =3D 100;
> +		cmask_init(&qa.sub_sched_ctxs[i].granted_cids.mask, 0, qa.nr_cids);
> +		qa.nr_sub_scheds--;
> +		bpf_printk("detaching sub-sched[%d] on %s", i, args->cgroup_path);
> +		redistribute();
> +		break;
>  	}
>  }

[Severity: Medium]
Is it safe to modify the sub_sched_ctxs array locklessly here?

The kernel calls qmap_sub_detach() when a child cgroup is removed, zeroing
out granted_cids.mask and updating cgroup_id. Concurrently, userspace can
trigger repartition() or a BPF timer can trigger rr_advance(), both of which
call apply_partition().

Since apply_partition() reads and sets bits in these same masks concurrentl=
y:

apply_partition() {
    ...
    if (o >=3D 0 && o < MAX_SUB_SCHEDS)
        cmask_set(cid, &qa.sub_sched_ctxs[o].granted_cids.mask);
    ...
}

Can this data race corrupt the internal state and lead to skipped capability
revocations or invalid scheduling structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D35
