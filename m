Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E1145FE0
	for <sched-ext@lists.linux.dev>; Fri, 22 May 2026 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473793; cv=none; b=HYe/VxvBBHfBh7LjCgl8FfqeI3e+Hdeaboks5C80pntPMJTVSohFSwiCMGPrph8cjgInLqybjcVsbPZp2fc3eGYm2ZQtiG4/xFJGtTfOEJq5VMoJzUSSAJifckSXqAOku/a848xQ1ZE+6gsMYfqZR53dCOpq/7v/+4ANSZ66+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473793; c=relaxed/simple;
	bh=G1s7qdwgMkjLZd7VmHh9B59BFEW2YTA6fx7Cq7FyNfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YBz8E7XdDbgCSubVremZ1Klul3sRZeHwI0SzCVR06/o+JERRav9VYfUsx7gCsaxL8d5YqT+xBhluRSiVqtIaCX8Q81P5TXG3kFBPHKIbo0WBJ7IcbL1Gbfh1K8ODxA877TI/jBMefji4EX3U9GgDdGAsjGbVp4a1TDn35iNXKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le45UpRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le45UpRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03191F000E9;
	Fri, 22 May 2026 18:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779473791;
	bh=a3Pm33POUOdn/PPH9HqiRm0KEdpBySlnUZTru5vc0J0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Le45UpRpdmcG0Qo0HKPjpQ6SI8JoDQ0LgLZvaZoUt3IU8Vi+rHrhrgAEmBjlN/oKo
	 6wXAuUd3+7sQvnKNfTFbq2LOmN5PjSYV7e8wvPcXItU0tyXdjQ//fnlYKc+I2I5jj3
	 PtmMyEXFEKKg7pyUSYlanuCzstXDfKM5zJCrXA3bjj3QaGAQouDDrsJgjlMeerbo3h
	 HoBIGGZDuN/t67rXGAxniEqSGnviQC08I4/boR9oKG+bpAW8/kbljhedvOzW5MV9x9
	 MpBcMcX8ZRnVKTRvabS7jff6l5P3F5D5THBmlz72jpe+7IpuBbUCitKLlJM+O7wrz6
	 U4/aaY1LH9ZYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tools/sched_ext: scx_qmap: fix arena stores
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260522171406.2171819-3-yphbchou0911@gmail.com>
References: <20260522171406.2171819-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 18:16:30 +0000
Message-Id: <20260522181630.D03191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete refactoring leaves arena field stores using the dead sc=
alar alias, causing BPF verifier rejection.
--

commit fcbdf79612bdb874457d684cdbba45646312d3d5
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

tools/sched_ext: scx_qmap: fix arena stores

This patch addresses a BPF verifier rejection in scx_qmap when compiled
with __BPF_FEATURE_ADDR_SPACE_CAST. It introduces bpf_addr_space_cast()
and a barrier_var() to ensure LLVM preserves the PTR_TO_ARENA alias for
arena pointer stores, fixing errors across spin-lock and unlock calls.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 7e77f22674eaa..a6019e8fe0ccb 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c

[ ... ]

> @@ -762,6 +784,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_task, struct t=
ask_struct *p,
>  			     struct scx_init_task_args *args)
>  {
>  	struct task_ctx_stor_val *v;
> +	struct task_ctx *__tc;
>  	task_ctx_t *taskc;
> =20
>  	if (p->tgid =3D=3D disallow_tgid)
> @@ -779,10 +802,13 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_task, struct=
 task_struct *p,
>  		return -ENOMEM;
>  	}
> =20
> -	taskc->next_free =3D NULL;
> -	taskc->q_next =3D NULL;
> -	taskc->q_prev =3D NULL;
> -	taskc->fifo =3D NULL;
> +	__tc =3D (struct task_ctx *)taskc;
> +	barrier_var(__tc);
> +	bpf_addr_space_cast(__tc, 0, 1);
> +	__tc->next_free =3D NULL;
> +	__tc->q_next =3D NULL;
> +	__tc->q_prev =3D NULL;
> +	__tc->fifo =3D NULL;
>  	taskc->tid =3D p->scx.tid;
>  	taskc->pid =3D p->pid;
>  	taskc->force_local =3D false;

[Severity: High]
This isn't a bug introduced by this patch, but does this incomplete refacto=
ring
leave the remaining field stores vulnerable to the same BPF verifier reject=
ion?

The patch applies the __tc cast to the first four pointer fields (next_free,
q_next, q_prev, fifo), but leaves tid, pid, force_local, highpri,
core_sched_seq, and cpus_allowed using the original taskc pointer.

Since LLVM tracks liveness at the register level, will the original taskc
pointer still use the dead scalar alias for these remaining stores, causing
the verifier to continue rejecting the program?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522171406.2171=
819-1-yphbchou0911@gmail.com?part=3D2
