Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB238422F
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548672; cv=none; b=g/CR3RYHI8ekCybB2I36D34mGNOCDMGXt8KmQ85mGjswP5GN51VWyxsOSe06yUUCXIdYxTz41St8xlJ4BUHkKc91WDSbLZB3VS/j66/QUfgQBorM0sgZOINqMehy/4Ubf+uDgSWXztOoxP6tpSFlLyymIudkZtXjFllLv4BKSzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548672; c=relaxed/simple;
	bh=BlEgvccXT+ZYKvIpcsKmUukeCE9Zh2znidFVQoWns2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kO/LmvmTesQRDCSMI70RF7IjRC9lTI3yif5ImOL7raH8ZRgcXj4z7HDUNJTsUzISigxJ26KIEs2HqVo2I1vdvYzgRFUNKULVtIFIr5v8+EBNhYBkI4htvvLyseAS9VDz0eugIH+sLLgL6TbCODDsv+4O7gBTUfeLQg4zYUswrNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNxBXfXH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNxBXfXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3521F000E9;
	Wed,  8 Jul 2026 22:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783548671;
	bh=ovbqeoyLW/9GpQtsIuzchIcAK+8mS4trMdS861ZF8qU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mNxBXfXH2seQb0t09s+eJncg+mdL/NTf3HV4fol7JOfNGmqZDUlBWRPJdSF/o5FDM
	 8tmCOtDDgLOsv7fpfIlkLVmNqTmQFCOhRP35aqv12zPoN/TJ+JiAxvmYLhrd36Hcaf
	 Y80SmthLxievQco4Tdnwf2xaZI9mXqMRJEgw9iiF8FWqzQxIYOJmJMgKsDsLVLmGhM
	 O1tReXkQPM6JbvrxFe24lt2dN6ApZsQYqK29a+A7Op6Ji33P5SUFQKmipDnh0H80NF
	 FIsbKnSK/LLOk6+vG9s/2EUFxORBBr2Ddg7yhmv7/sCzR9AKRhloXlIAE4sPdlasuV
	 a161+4cebFGAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 37/40] sched_ext: Add
 scx_bpf_sub_kill() to evict a child sub-scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-38-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-38-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:11:10 +0000
Message-Id: <20260708221110.ED3521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `__str` suffix on the `fmt` parameter in `scx_bpf_sub_kill=
_bstr()` allows out-of-bounds kernel memory read.
--

--- Patch [37]: [PATCH v4 sched_ext/for-7.3 37/40] sched_ext: Add scx_bpf_s=
ub_kill() to evict a child sub-scheduler ---
commit dffeca7158a063ab8ec3cb4f59c9c43d77050c68
Author: Tejun Heo <tj@kernel.org>
sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler

This commit adds scx_bpf_sub_kill() to allow a cid-form scheduler to evict
a direct child sub-scheduler. The child is torn down asynchronously via the
exit kind SCX_EXIT_PARENT_KILL. It exposes bstr formatting infrastructure
to support this.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 44622dcc8b4f3..5c9cd3682f086 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -9362,7 +9358,7 @@ __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, c=
har *fmt,
>  	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
>  	sch =3D scx_prog_sched(aux);
>  	if (likely(sch) &&
> -	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >=3D 0)
> +	    scx_bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >=3D =
0)
>  		scx_exit(sch, SCX_EXIT_UNREG_BPF, exit_code, "%s", scx_exit_bstr_buf.l=
ine);

[Severity: High]
This is a pre-existing issue, but does scx_bpf_exit_bstr() allow an
out-of-bounds kernel memory read by omitting the __str suffix from the fmt
parameter?

Since fmt does not have the __str suffix (i.e. fmt__str), the BPF verifier
treats it as KF_ARG_PTR_TO_MEM instead of KF_ARG_PTR_TO_CONST_STR and does
not check for a NUL terminator at load time.

If a BPF program passes a non-NUL-terminated buffer, the fmt pointer is
ultimately passed to bpf_bprintf_prepare() in __bstr_format() with
fmt_size =3D UINT_MAX, which calls strnchr(fmt, UINT_MAX, 0). This could lo=
op
over unmapped memory boundaries and cause a page fault.

> @@ -9387,7 +9383,7 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsi=
gned long long *data,
>  	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
>  	sch =3D scx_prog_sched(aux);
>  	if (likely(sch) &&
> -	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >=3D 0)
> +	    scx_bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >=3D =
0)
>  		scx_exit(sch, SCX_EXIT_ERROR_BPF, 0, "%s", scx_exit_bstr_buf.line);

[Severity: High]
This is a pre-existing issue, but does scx_bpf_error_bstr() also suffer from
the same missing __str suffix on the fmt parameter?

[ ... ]

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 77cb7f3d7826b..b3e72fffb0f6c 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> +__printf(2, 0)
> +__bpf_kfunc s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt,
> +				      unsigned long long *data, u32 data__sz,
> +				      const struct bpf_prog_aux *aux)
> +{

[Severity: High]
Does scx_bpf_sub_kill_bstr() introduce the same vulnerability by missing the
__str suffix on the fmt parameter?

Could we change this parameter to fmt__str to ensure the BPF verifier
enforces a NUL-terminated constant string?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D37
