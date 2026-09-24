Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E726485CEF
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261431; cv=none; b=kHkIbn4NCmR70hOqPM3jy+M+x4lRGB9Uocp31kCrWOpC+2/th54h+6mxWuoexrBdqP+svzGrluRcoMX0+7TbuYbLCFzhjNIT11eSd/PFMPSgdRk/J7rlziePUlPz4AJ0EiBxfAbJD2U8lnhEApaCL5XXibErrIFhsIc6Ud80EdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261431; c=relaxed/simple;
	bh=CK7t7v3wdRTGu7HloRp0djVb/amqSHNOJeoZgphu5HA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G4YK62dHixnX0WHOCAifreesK/MYXALHdim7h6rur4S+NiRJGmWCuNVMRoW145Qgf2AJi+eEdlBDipnntX2DFmXMMJyVJ66m+TUZsmvOfd/wD+kX3yWBSvFjLAP7iktfgwvYBsWo3wXU10MJtPHSuzpwnRV9yOt4+j6B+7U9qEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJZuzqm+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJZuzqm+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C295D1F000FF;
	Thu, 24 Sep 2026 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790261430;
	bh=1gUlur7PzvyG78kJn7G0PrhToJT6rGgU2IwVIvLsBNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EJZuzqm+kvz2X24JcYABqlJGzqopuc1shpz7xFlgxdGofjMPir8joCeZ9iTLG0KVv
	 22ZtRnUez5ApjnaDvTfcqJ6F+nRwnYGpj+6HvpvGDJ/dK3cX6G3OhB7rd9C5VF2umO
	 vGEeh5MFZPOM4PxbP3GBXNsEBaKHEKaEa04gez5O3UjOMgSWkWJ7cNSS1x8oI4lC/8
	 yWB3kU076Unkea19Z0fmd6EreE03rtkJcxu79QPwvDP9HWrU1UJKxyUGc+1MvDf3ba
	 t5cYUbqaJIR+aErhK2LyTM2Dmr6X/PSGnXlHNKqc5WetVBGyHQzlTZItuR/xtyrP62
	 yycxdwAYwIW7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] tools/sched_ext: scx_pair: Verify task cgroup
 before dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanwu Li" <liwanwu@kylinos.cn>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260924143659.268595-4-liwanwu@kylinos.cn>
References: <20260924143659.268595-1-liwanwu@kylinos.cn>
 <20260924143659.268595-4-liwanwu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 14:50:29 +0000
Message-Id: <20260924145029.C295D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched_ext: fatal abort in scx_pair due to scx_kf_arg_task_ok() vio=
lation
--

commit 79e8ca61bf0fbb13b0ca39d2236cec7b65f02134
Author: Wanwu Li <liwanwu@kylinos.cn>

tools/sched_ext: scx_pair: Verify task cgroup before dispatch

This commit modifies try_dispatch() to read the task's current cgroup after
looking it up from its pid. This ensures the task hasn't migrated to another
cgroup between enqueue and dispatch, dropping tasks that have migrated to
avoid dispatching them under the wrong cgroup context.

> diff --git a/tools/sched_ext/scx_pair.bpf.c b/tools/sched_ext/scx_pair.bp=
f.c
> index 906bb11d678f7..d29bb9fc6c92e 100644
> --- a/tools/sched_ext/scx_pair.bpf.c
> +++ b/tools/sched_ext/scx_pair.bpf.c
> @@ -519,6 +519,25 @@ static int try_dispatch(s32 cpu)
> =20
>  	p =3D bpf_task_from_pid(pid);
>  	if (p) {
> +		struct cgroup *task_cgrp;
> +		u64 task_cgid;
> +
> +		/*
> +		 * Without a .dequeue callback, a task that migrated to
> +		 * another cgroup after being enqueued leaves a stale pid
> +		 * behind. Dispatching it here would run it under the wrong
> +		 * cgroup. Drop it and retry.
> +		 */
> +		task_cgrp =3D scx_bpf_task_cgroup(p);

[Severity: High]
Will this cause a scheduler abort?

Looking at the kfunc implementation, scx_bpf_task_cgroup() internally
validates the task using scx_kf_arg_task_ok(), which requires that the
passed task matches current->scx.kf_tasks[0] (the task currently being
operated on by a task-specific SCX hook).

Because try_dispatch() is invoked from the .dispatch scheduler hook
(pair_dispatch) via SCX_CALL_OP() rather than SCX_CALL_OP_TASK(),
kf_tasks[0] is not populated and remains NULL during dispatch.

Since the looked-up task p is not NULL, won't scx_kf_arg_task_ok()
unconditionally fail and trigger scx_error(), causing a fallback to CFS
on the very first task dispatch?

> +		task_cgid =3D task_cgrp->kn->id;
> +		bpf_cgroup_release(task_cgrp);
> +
> +		if (task_cgid !=3D cgid) {
> +			bpf_task_release(p);
> +			__sync_fetch_and_add(&nr_missing, 1);
> +			return -EAGAIN;
> +		}
> +
>  		__sync_fetch_and_add(&nr_dispatched, 1);
>  		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
>  		bpf_task_release(p);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924143659.2685=
95-1-liwanwu@kylinos.cn?part=3D3
