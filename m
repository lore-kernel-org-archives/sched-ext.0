Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0737BE7C
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303507; cv=none; b=TbkQsiYgxk9qfFwDexWYyLubiRjxXM9KAkiS2NAqhw1SHd1Y3mHO+wanYZ0z8/tmsmEVRZnmsiSUhiQQtT1FtoOwHc30MhCKYOXVBVtWVt5Ziumcc8AW+fmIvUEF1Vi9NDW+8c68YS8nQkohZ+euVMH867rHd1/t2fsf9v9Phnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303507; c=relaxed/simple;
	bh=hCHt9JpA84RerK3T+OPrWevfEfDv7O+fcnvWL5+Rhxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pXuYoQUVS7BYOX1XMlqfYINnOo2zhF+TEuXyL7kiCnSkK9dryzdFkMGQJF6aR2IJrq23oEqrggcrMRTYA1B/NtVLUG1Bipjql7SPOolvlWyO6PculXjPyWMZLDV+N2AGFD87YHrp5nnO27DrT/aLP87uKO+sjJ6WLnr5NaT0j3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXiGBHyT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXiGBHyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8FD1F000E9;
	Mon,  6 Jul 2026 02:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303506;
	bh=jYXT5mfY7rGCTeUrJDBB7txqEkDCkv5N5RSKrnbGUDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mXiGBHyTDkGa/ZXEn3FdtKeU82CtxQ7xt+eYfxHBTjaKzYYgwk4TN7G6ws7OqqZon
	 t0rozYFZqKydEQmTuIO+WGQRDg6g9FpamP3umAIuho4Y6MALbYG2V8hy62Fl1oXt3G
	 k/M+HDKgL6g0371mOpmR7KDWKJqD/cbYurntZInfPJVcrzlfi74hKItVfvC4s1S2zj
	 MxUVgIoI251XBX+u8NFb+bfTEeRPxYgabkuhM8kBtzlmqyRsripFllPbQ0Fnue35HC
	 dwJZC7gVhTmPbUWgdf0rhF3Seu3eKuR/D6GPh+8Nc4uLNaOQrGkOMmfaVDER1D1wIM
	 Coe2iRINJaXcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 27/36] sched_ext: Route task slice
 writes through set_task_slice()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-28-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-28-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:05:03 +0000
Message-Id: <20260706020505.9B8FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Routing the lazy fallback assignment through set_task_slice() in s=
cx_bpf_dsq_insert___v2() and scx_dsq_insert_vtime() incorrectly drops pendi=
ng out-of-band slice requests when preserving the current slice.
--

commit 127371a444f95f70296cadcc3202bbe1233bead6
Author: Tejun Heo <tj@kernel.org>

sched_ext: Route task slice writes through set_task_slice()

This commit introduces set_task_slice() to centralize writes to p->scx.slic=
e.=20
It replaces direct assignments across the sched_ext code in preparation for=
=20
dropping pending out-of-band slice requests on slice writes.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 9fa4cfbc75c84..ff997ba881b02 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -8021,9 +8027,9 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct tas=
k_struct *p, u64 dsq_id,
>  		return false;
> =20
>  	if (slice)
> -		p->scx.slice =3D slice;
> +		set_task_slice(p, slice);
>  	else
> -		p->scx.slice =3D p->scx.slice ?: 1;
> +		set_task_slice(p, p->scx.slice ?: 1);

[Severity: High]
Will this unconditional call to set_task_slice() accidentally drop pending
out-of-band requests when slice =3D=3D 0 and p->scx.slice is already non-ze=
ro?

The commit message mentions that a later change will make every write
through set_task_slice() drop pending out-of-band slice requests. If a BPF
scheduler passes slice =3D=3D 0 to scx_bpf_dsq_insert___v2() intending to
preserve the current slice, routing this fallback through set_task_slice()
performs an explicit in-band write of the old slice.

Could this cause the task to lose its assigned slice budget from an
out-of-band request (e.g. set via scx_bpf_task_set_slice()), reverting to
its old slice or a 1ns slice and potentially causing starvation?

Should this avoid calling set_task_slice() if p->scx.slice is already
non-zero? For example: else if (!p->scx.slice) set_task_slice(p, 1);

> =20
>  	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
> =20
> @@ -8047,9 +8053,9 @@ static bool scx_dsq_insert_vtime(struct scx_sched *=
sch, struct task_struct *p,
>  		return false;
> =20
>  	if (slice)
> -		p->scx.slice =3D slice;
> +		set_task_slice(p, slice);
>  	else
> -		p->scx.slice =3D p->scx.slice ?: 1;
> +		set_task_slice(p, p->scx.slice ?: 1);

[Severity: High]
Similarly for scx_dsq_insert_vtime(), does unconditional use of
set_task_slice() here clear the pending out-of-band request when preserving
the existing slice?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D27
