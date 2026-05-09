Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792B2F2607
	for <sched-ext@lists.linux.dev>; Sat,  9 May 2026 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778356195; cv=none; b=VRZ/GvHUX+6FdPBjyCieuGRqD7QSHqMNlFkIHEUpoop/bX9ejczK8MgPDLpboMs9AbWU3ycT7ISvY2nqksQ5dfC2wZOQY4fMpvcEYOS9N+RvwHziS01Bsa33fyqZzG4ZqSf39LjdnP0Rpsn4cuU4v5hiRpa4aqB8z5aRhEuplwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778356195; c=relaxed/simple;
	bh=s4WQH0FTo6u+jJTHNCj3wxLs3gNd/z+5FNZGDR7Nk0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QBI6dTkTOf0pQC0k2rLK7FS2e9B191yHGCPpCJyxqUZaShLU6G+X6BMxQFmQHn6qL/DO2VuwynVvoEfe0xDbX5oMkfUH+Y/CK1A+ikUkGQ7j8Zmvwwb9unQxdptj6BkoL3CF5u9ugkSCOCKmoBMmwj4cX49SXud/jI5osBx0sxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlmVyNQe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlmVyNQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87E0C2BCB2;
	Sat,  9 May 2026 19:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778356194;
	bh=s4WQH0FTo6u+jJTHNCj3wxLs3gNd/z+5FNZGDR7Nk0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IlmVyNQeIN2qEe8HeVwibGPGO/jzJAztKn6wJ4ULK3vsOYRvxQqPQUjLUCZVFcwB6
	 Zq2yfJAPs560uDHzLAvnGworu+gRJ/O1hgvcOCmgFzmUahFPfKemYmwaFpbAwJL2We
	 24MJWTxAVL1Odd+cUGjU5fOUaWM6sqDdv9RDmD8PXHjazea97cFoEVRTAy4cuyCPgH
	 2Cpvg89AHryTfwHhXT+F9q6q9zv6xItocK4oEO+AkZloLtqxVgmsHMeOAk6qSaT3yx
	 TaHaMFAwrngbd9PX1uDdfh8BgJdaEKZ8Q/fP4uO0X4BsVgbhbSmlDH+HyTrggNvD7E
	 mvtEdqil5XBVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] sched_ext: Add dispatch transaction API
Reply-To: sashiko@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260509191223.168648-2-yphbchou0911@gmail.com>
References: <20260509191223.168648-2-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 19:49:54 +0000
Message-Id: <20260509194954.C87E0C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] scx_bpf_dsq_insert_commit() writes to p->scx.slice before token va=
lidation, causing a data race if the task is running
- [Low] Duplicate kfunc ID registration for scx_bpf_dsq_insert_begin
--

commit 1b5ec039cdfb5b4d5077f7a5cfcc34f6f7393655
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

sched_ext: Add dispatch transaction API

This commit introduces scx_bpf_dsq_insert_begin() and
scx_bpf_dsq_insert_commit() to provide a dispatch transaction API.
It extends the race detection window for schedulers that perform BPF-side
validity checks without properly synchronized dequeue.

Link: https://lore.kernel.org/r/20260203230639.1259869-1-arighi@nvidia.com/

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 1d7f206941f0c..05704a6a812a2 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c

[ ... ]

> @@ -8518,13 +8520,72 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct =
task_struct *p, u64 dsq_id,
> +__bpf_kfunc bool scx_bpf_dsq_insert_commit(struct task_struct *p,
> +					    u64 dsq_id, u64 enq_flags,
> +					    u64 token,
> +					    const struct bpf_prog_aux *aux)
> +{
> +	struct scx_sched *sch;
> +
> +	guard(rcu)();
> +	sch =3D scx_prog_sched(aux);
> +	if (unlikely(!sch))
> +		return false;
> +
> +	if (!scx_dsq_insert_preamble(sch, p, dsq_id, &enq_flags))
> +		return false;
> +
> +	p->scx.slice =3D p->scx.slice ?: 1;

Since token validation happens asynchronously in finish_dispatch() after
ops.dispatch() returns, is it safe to write to p->scx.slice here?

If the transaction API is meant to handle cases where the task might be
claimed by another CPU between begin and commit, the task could be actively
running elsewhere when this function is called.

Could this lockless write race with the active CPU's timer tick executing
task_tick_scx() (which decrements the slice concurrently)?

It appears this could result in a read-modify-write that clobbers the
concurrent decrement and corrupts the task's slice accounting.

[ ... ]

>  BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_commit, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_begin, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)

[ ... ]

> @@ -10194,6 +10255,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEAS=
E)
>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_begin, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)

This isn't a bug, but is it intentional to register scx_bpf_dsq_insert_begin
in both kfunc ID sets?

Because scx_kfunc_context_filter() permits a kfunc if it is present in eith=
er
set, and both sets apply to the scheduler context, the duplicate registrati=
on
appears functionally redundant.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509191223.1686=
48-1-yphbchou0911@gmail.com?part=3D1
