Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3630D41D
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548235; cv=none; b=KlnkIzIbhsWhh/RdGQnPSUVyjqvlnN61KBxTqwJCYKtLVAK63wuNCVizWCpQFvBPyFQqJ6It1WPZsKxrfz5Xkz6wklkTNUVmo0er790hRphW62FWsYNPyEw3xOkBC3MbHW7LsXkh/yjk9EuRZMQLF+IGffebvxXlY7Em7DN0dAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548235; c=relaxed/simple;
	bh=CB3s/5Eb77Qm8HHTlQ8+oL3pUi+piFvjv0OaNw/IGSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B/bgKecIFhwHOyKK+dLN/X4TfGdL+4sKp4R/Z5iQ8pPLFBzN63A3kgCAwuxh4Zh27T1PZC5TLRpEXEM1P6jpThwPBFAhdprj60v1swUtKeXX1ztWb3uJs+8+sndoRGN5a3HCaSv5dlxaHQXrYxigoAFjQJT2hP667rhO1Lkl6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwTEaw9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwTEaw9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392CD1F000E9;
	Wed,  8 Jul 2026 22:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783548233;
	bh=Gc39mWbkp/jyfUDWLLPRM4kh/Qt+vCPc7o5koXDgmmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TwTEaw9Rh03cAolPqQtpdC+WVuQdZ1bqGCuzo3DFlHQm63CrhwHLBo2Z8K6f20JkC
	 wyn1G7SvwJBJydKPjUJODElt+gaOHusK1XnKqiIg7qF/rIl5geuwMMwjLSyuBOvbsf
	 ChEM+C74CvF664nr5WkV+lc0Szc2a2vVOnuxmyHOEC4M5IL1m6Y0vXrZ9Og2IRA4o7
	 7uDX5eFDddEvM7ZBZXQqU3qIQdDaug2d28QSWlhBGf1acfq5q5wS3OomSsy3qu/3pU
	 3nOroSj6zWSCGzEgtd84UG8d9SjnKBajJWaSU7j52qRKi5I40WWBGgUSq3WaEnDf8m
	 fGDTknSNKZ28g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 39/40] tools/sched_ext: scx_qmap -
 Expand hierarchical sub-scheduling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-40-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-40-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:03:52 +0000
Message-Id: <20260708220353.392CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] `dispatch_highpri()` ignores hierarchical CID delegation, allowi=
ng the parent scheduler to dispatch its high-priority tasks to CPUs exclusi=
vely delegated to child schedulers.
- [Medium] Unsynchronized modification of `qa.sub_sched_ctxs` array during =
`qmap_sub_attach` and `qmap_sub_detach` causes data races with partition re=
building.
- [Medium] Double read (TOCTOU race) of `qa.sub_sched_ctxs[owner].cgroup_id=
` in `qmap_dispatch` can pass 0 to `scx_bpf_sub_dispatch`.
- [Medium] Userspace `feed_weights()` overwrites child weight with stale da=
ta due to concurrent sub-scheduler detach/attach (TOCTOU).
- [Medium] Negative error codes from `scx_bpf_task_cid()` are used directly=
 as array and bitmask indices without bounds checking.
--

--- Patch [39]: [PATCH v4 sched_ext/for-7.3 39/40] tools/sched_ext: scx_qma=
p - Expand hierarchical sub-scheduling ---
commit d8ef8ae12fe2035b97cf3007ec38b1e29eef5a35
Author: Tejun Heo <tj@kernel.org>

tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling

This commit expands the scx_qmap test scheduler to demonstrate hierarchical
sub-scheduling. It allows a parent to delegate exclusive and shared CPUs
(cids) to child cgroups based on cpu.weight.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index f6cfe63425d36..5b1c3b10ac746 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
[ ... ]
> @@ -416,7 +476,8 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct =
*p, u64 enq_flags)
>  	 */
>  	if (taskc->force_local) {
>  		taskc->force_local =3D false;
> -		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice_ns,
> +				   enq_flags | needs_immed(scx_bpf_task_cid(p)));
>  		return;
>  	}

[Severity: Medium]
The core kernel kfunc scx_bpf_task_cid() can return an s32 negative error=20
code (such as -EINVAL) if the CID table is uninitialized or the CPU mapping=
=20
is missing.

When this return value is passed directly to needs_immed(), the negative=20
value is used to index into the qa.cid_shared array without bounds checking=
.=20
Can this lead to an out-of-bounds memory read within the BPF arena?

Similarly, in pick_direct_dispatch_cid(), prev_cid is passed to bitmask=20
operations like cmask_test_and_clear() and cmask_test(). Should there be a=
=20
check to ensure the returned CID is >=3D 0 before using it as an index?

[ ... ]
> @@ -541,7 +604,7 @@ static bool dispatch_highpri(bool from_timer)
[ ... ]
>  		if (scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | cid,
> -				     SCX_ENQ_PREEMPT)) {
> +				     SCX_ENQ_PREEMPT | needs_immed(cid))) {
>  			if (cid =3D=3D this_cid) {
>  				dispatched =3D true;

[Severity: Medium]
In qmap_dispatch(), dispatch_highpri(false) is called unconditionally befor=
e=20
checking qa.part.cid_owner.=20

Inside dispatch_highpri(), tasks are moved to the local DSQ without verifyi=
ng=20
if the target cid is restricted by qa.self_cids.mask.

Does this sequence allow the parent scheduler's high-priority tasks to be=20
dispatched to CPUs that are exclusively delegated to child sub-schedulers,=
=20
thereby violating the delegation policy?

[ ... ]
> @@ -567,12 +630,35 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct =
task_struct *prev)
[ ... ]
> +	} else if (owner >=3D 0 && owner < MAX_SUB_SCHEDS &&
> +		   qa.sub_sched_ctxs[owner].cgroup_id) {
> +		if (scx_bpf_sub_dispatch(qa.sub_sched_ctxs[owner].cgroup_id))
> +			__sync_fetch_and_add(&qa.sub_sched_ctxs[owner].nr_dsps, 1);
> +		return;
> +	}

[Severity: Medium]
The cgroup_id is read twice without protection here. The first read evaluat=
es=20
qa.sub_sched_ctxs[owner].cgroup_id as a condition for the if statement.=20

Immediately after, the same memory location is re-read to be passed to=20
scx_bpf_sub_dispatch().

Because qa.sub_sched_ctxs can be concurrently modified by qmap_sub_detach()=
=20
without locks, could the value become 0 between the condition check and the=
=20
function call, causing scx_bpf_sub_dispatch() to be invoked with an invalid=
=20
cgroup ID?

[ ... ]
> @@ -1219,15 +1831,37 @@ void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_s=
ub_detach_args *args)
>  	s32 i;
> =20
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
During qmap_sub_detach() and qmap_sub_attach(), the global array=20
qa.sub_sched_ctxs is modified directly (clearing cgroup_id and zeroing=20
granted_cids.mask via cmask_init).=20

These modifications occur without acquiring the part_try_start() /=20
part_end() synchronization guard used in apply_partition() and rr_advance()=
.=20

If apply_partition() runs concurrently from the timer callback or sys_bpf=20
calls, can this cause a data race that corrupts the partition state trackin=
g=20
masks?

> diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
> index 9124183bffecc..1efffaaa8fe85 100644
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
[ ... ]
> @@ -62,6 +92,213 @@ static void sigint_handler(int dummy)
[ ... ]
> +/* read each direct child's cpu.weight into the arena, true if any chang=
ed */
> +static bool feed_weights(struct qmap_arena *qa)
> +{
> +	bool changed =3D false;
> +	int i;
> +
> +	for (i =3D 0; i < MAX_SUB_SCHEDS; i++) {
> +		u64 cgid =3D qa->sub_sched_ctxs[i].cgroup_id;
> +		u32 w;
> +
> +		if (!cgid)
> +			continue;
> +		w =3D read_cgroup_weight(cgid);
> +		if (w && w !=3D qa->sub_sched_ctxs[i].weight) {
> +			qa->sub_sched_ctxs[i].weight =3D w;
> +			changed =3D true;
> +		}
> +	}
> +	return changed;
> +}

[Severity: Medium]
In feed_weights(), userspace reads the cgroup_id from the BPF arena memory=
=20
and then performs a blocking sysfs read via read_cgroup_weight().

During this file I/O operation, the original child cgroup could detach and =
a=20
new one could attach to the same slot. Will the userspace daemon then=20
blindly overwrite the newly attached child's qa->sub_sched_ctxs[i].weight=20
with the stale weight read from the previous child's sysfs file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D39
