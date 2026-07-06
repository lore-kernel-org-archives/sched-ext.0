Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F427B32C
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303817; cv=none; b=K4aNHMSt8fkZgdER/79EafzGp0JvFySOC8mlj/O0tnR1waV+gXfyWi+lVimCtwSpuF14i5AOxO3hfQTmopfpFSAnDZQvs7uS3bkGdohxDPflrVFKpsmUKL8NTS7WijQTdBCUDbpxQl/wGE8wPXU8eQTKVSq6sDZzCEAJvuiigGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303817; c=relaxed/simple;
	bh=bty7GzsjTjd5GTGJJ0+t6z+C3oDGHg6fEBc7X+l2qRE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RLWt0sI14f5h0U76Zd+jVxrpyATx+98mi1Va/G72gI+qvMivq8qgKiOo3wp60I6lnAN9UUX8N0I90XnkWWu6yBYHO9djxhFZ8XSC4eHEpQ9O+2FPHmVcKZQ2cZO6yGfB/8qYFRiFFJ4iik/gm8Hq22b/PaVwzt1P478OJhL2fWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZV+vaMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZV+vaMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB9F1F000E9;
	Mon,  6 Jul 2026 02:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303816;
	bh=qAaE3luVj7un5F/8UIbJNbOmGpUSGbeOnpeJTZM7rRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cZV+vaMx8hBySak8JZUJ/Uq0ouSOg0BbnbOmBt15Zz0cy7IHXNF7/H7iVUHAKa0r9
	 6mBalmkfu9cJ2u1IMhztEDGsuiQBleesmlwkeVPUYuhASQi1ZFXbFQ3uaWWHw3sv1P
	 GLdCRPdQPwScHabr63u45iTmjs01hcZUFWorcoDm6mTZMCci1lQ6eeoeFIYgyleRSk
	 2XhxVfXe9k1/pzR/2oANhI9BPH3rNkzBF1VcWR6+aqYKijQ0TvDhylNAMsgd5tyTf7
	 PI4hy9v1kXwkzMrpMzi2e88A3jcOeqFjpgHXGDXQ4g50xIBRDHmbrOU4Uj/9HhyTBu
	 YXn62KVNhr/hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 35/36] tools/sched_ext: scx_qmap -
 Expand hierarchical sub-scheduling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-36-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-36-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:10:12 +0000
Message-Id: <20260706021014.BEB9F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Tasks dispatched to time-shared CIDs via `qmap_dispatch` lack the =
required `SCX_ENQ_IMMED` flag, causing the kernel to reject them and trigge=
r an infinite bounce loop.
- [High] Concurrent modifications to `qa.sub_sched_ctxs[i].cgroup_id` durin=
g attach/detach race with `compute_partition()`, causing `nr_shared` to wra=
p negative or overflow `MAX_PARTS` and triggering a fatal `scx_bpf_error()`=
 crash.
- [Medium] In `redistribute()`, elapsed time is incorrectly charged to the =
newly computed partition layout rather than the outgoing one, resulting in =
corrupt allocation statistics.
--

commit 93bb924468eaef8590cfd599f15e87393f92eaa9
Author: Tejun Heo <tj@kernel.org>

tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling

This patch expands the scx_qmap demonstration scheduler to support=20
capacity-based hierarchical sub-scheduling delegation. It introduces logic=
=20
to split exclusive CIDs and a shared round-robin pool among child cgroups=20
based on CPU weight.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index f6cfe63425d36..64422e9e1db88 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
[ ... ]
> @@ -567,11 +627,34 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct =
task_struct *prev)
>  	struct cpu_ctx __arena *cpuc;
>  	task_ctx_t *taskc;
>  	u32 batch =3D dsp_batch ?: 1;
> +	s32 owner;
>  	s32 i;
> =20
>  	if (dispatch_highpri(false))
>  		return;

[Severity: High]
Does this dispatch logic need to include the SCX_ENQ_IMMED flag when moving=
=20
tasks to a time-shared CID?

When a child scheduler receives a time-shared CID, it is only granted the
SCX_CAP_ENQ_IMMED capability for it. However, the subsequent calls to
scx_bpf_dsq_move_to_local() in qmap_dispatch() pass 0 as the enq_flags.

Similarly, in dispatch_highpri(), scx_bpf_dsq_move() passes SCX_ENQ_PREEMPT.

If a task is moved to the local DSQ of a time-shared CID without including
the SCX_ENQ_IMMED flag (for instance, via needs_immed(cid)), the kernel will
reject the local DSQ insert because the child lacks the stronger SCX_CAP_ENQ
and SCX_CAP_PREEMPT capabilities. This rejection bounces the task back to t=
he
global DSQ with SCX_TASK_REENQ_CAP, which can cause an endless bounce loop=
=20
and a spike in CPU utilization.

[ ... ]
> +static void redistribute(void)
> +{
> +	s32 i;
> +
> +	__sync_fetch_and_or(&part_pending, 1);
> +
> +	if (!part_try_start())
> +		return;
> +
> +	bpf_for(i, 0, 1024) {
> +		__sync_fetch_and_and(&part_pending, 0);
> +		compute_partition();
> +		apply_partition();

[Severity: Medium]
Is the elapsed time being incorrectly charged to the newly computed partiti=
on
layout instead of the outgoing one?

Inside this loop, compute_partition() overwrites the qa.part layout,
including the owners and round-robin positions. Then, apply_partition() is
called, which in turn calls account_alloc().

Because account_alloc() executes after the layout has already been mutated,
it uses the new qa.part structure to calculate the time delta for the
outgoing layout. This could lead to time being attributed to the wrong CIDs
or sub-schedulers, resulting in corrupted allocation statistics. Should=20
account_alloc() be invoked before the qa.part structure is overwritten?

> +		if (!__sync_fetch_and_or(&part_pending, 0))
> +			break;
> +	}
> +
> +	part_end();
> +}
[ ... ]
> @@ -1202,13 +1793,20 @@ s32 BPF_STRUCT_OPS(qmap_sub_attach, struct scx_su=
b_attach_args *args)
>  {
>  	s32 i;
> =20
> +	/* as long as there is at least one excl cpu, children can attach */
> +	if (!cmask_weight(&qa.held_excl.mask))
> +		return -ENOSPC;
> +
>  	for (i =3D 0; i < MAX_SUB_SCHEDS; i++) {
> -		if (!qa.sub_sched_cgroup_ids[i]) {
> -			qa.sub_sched_cgroup_ids[i] =3D args->ops->sub_cgroup_id;
> -			bpf_printk("attaching sub-sched[%d] on %s",
> -				   i, args->cgroup_path);
> -			return 0;
> -		}
> +		if (qa.sub_sched_ctxs[i].cgroup_id)
> +			continue;
> +
> +		qa.sub_sched_ctxs[i].cgroup_id =3D args->ops->sub_cgroup_id;

[Severity: High]
Could these concurrent modifications to the cgroup_id cause a race condition
with compute_partition()?

In qmap_sub_attach() and qmap_sub_detach(), the cgroup_id is modified direc=
tly
without acquiring the part_busy synchronization guard. If a userspace proce=
ss
triggers a repartition (via BPF_PROG_RUN) at the same time the cgroup core
calls ops.sub_attach or ops.sub_detach, compute_partition() could observe
inconsistent state.

Specifically, the first loop in compute_partition() calculates sum_w based =
on
one state of the cgroup_id array, while the second loop allocates total_excl
based on a potentially different state. This mismatch could cause total_excl
to exceed nr_excl (resulting in a negative nr_shared that wraps around) or
fall short (making nr_shared > MAX_PARTS), which would then trigger a fatal
scx_bpf_error("-ERANGE") in apply_partition() and force a revert to CFS.

> +		qa.sub_sched_ctxs[i].weight =3D 100;	/* until userspace feeds it */
> +		qa.nr_sub_scheds++;
> +		bpf_printk("attaching sub-sched[%d] on %s", i, args->cgroup_path);
> +		redistribute();
> +		return 0;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D35
