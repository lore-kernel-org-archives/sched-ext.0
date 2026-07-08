Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE043E16A9
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546883; cv=none; b=bBn5lvoD0knmRlz7Wa2m2XQTbtklRfGoveinMOD3hhusHtX4S04UeVb6fOLwad9sTcQROp6QhADfdT8k8GOXBYbKkXpDaIOq1vXwPC0P0q20UClnh40Zp5LXH7+wGbdpgNllRVJKZP4BSoWvWALfbx2VjhhvRQrTAtIFYm7FuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546883; c=relaxed/simple;
	bh=8tnF7DnSzBqeoDQI0YihXM2u96IOHV3qcvJOq6MiQ5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BjuKxia0dnYrXWAo6Z1lXtXxZQWPtLmpCI00NobJMiGvODu7f7VdGK1VfYkYibJYmuTxz2wcyK5mM4FxmHiCWiTKH20hRcr+77gTvSlLBGrlAU0lUMtXGsaW2CNPuXBl6Zx51jfXZ9qaedr17eKeVbcUeAW0Jzt3EZFFfYAZMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3BQYinJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3BQYinJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDD61F000E9;
	Wed,  8 Jul 2026 21:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783546881;
	bh=ei98btHseDTdikTlqOF4m0o2H+/wuIKQD0f4GBjOQzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I3BQYinJbdtl2k2oANVizqwcuw8IiJWoYzAjFfJT3g8W5KPh+0ZXoNoQ0+OokDDXR
	 Zy408mTmJsYXCUTYs1uqHI3AU2kzKcL4Kb/i9C5GqDT8emZ7/0vdOAW72QLGOM1aAV
	 Sxe6MAabfr/vQY9bdk6AggpTZy4baljBzmx9I7vPPSpJVE1bqS+Zt6r20NvHPijhMs
	 G28yWR4ROAu790VPi5DvfxEAzoe+bmoAM0E/7r+sDnNGe8pewzOOUiXeuyC8B+26ex
	 IfnkRfYNu6AnlkVjzrj7dx3+9mewxfxeqXF3SVQIVdwrKP0MAue64tuJyw+nDIq+X9
	 TzPYhpcvom1jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 08/40] sched_ext: Reject direct
 slice and dsq_vtime writes for cid-form schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-9-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-9-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 21:41:20 +0000
Message-Id: <20260708214121.ABDD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bpf_scx_btf_struct_access_common permits BPF_WRITE to PTR_TO_B=
TF_ID | PTR_UNTRUSTED pointers, allowing arbitrary kernel memory writes.
--

--- Patch [8]: [PATCH v4 sched_ext/for-7.3 08/40] sched_ext: Reject direct =
slice and dsq_vtime writes for cid-form schedulers ---
commit b5bf42bcb4f4546f3eb981870b33d4470cf01c02
Author: Tejun Heo <tj@kernel.org>

sched_ext: Reject direct slice and dsq_vtime writes for cid-form schedulers

This commit introduces a separate verifier ops struct for cid-form schedule=
rs
to reject direct writes to p->scx.slice and p->scx.dsq_vtime. The cpu-form
schedulers retain direct writes and drop the previous deprecation warning.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index be75bdc9ada23..bd3cb59b1dbf9 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -6995,6 +6995,21 @@ static bool bpf_scx_is_valid_access(int off, int s=
ize,
>  	return btf_ctx_access(off, size, type, prog, info);
>  }
> =20
> +/* common to both forms: only scx.disallow is writable */
> +static int bpf_scx_btf_struct_access_common(const struct bpf_reg_state *=
reg,
> +					    int off, int size)
> +{
> +	const struct btf_type *t;
> +
> +	t =3D btf_type_by_id(reg->btf, reg->btf_id);
> +	if (t =3D=3D task_struct_type &&
> +	    off >=3D offsetof(struct task_struct, scx.disallow) &&
> +	    off + size <=3D offsetofend(struct task_struct, scx.disallow))
> +		return SCALAR_VALUE;

[Severity: Critical]
This is a pre-existing issue, but does this function permit arbitrary kernel
memory writes if the register has the PTR_UNTRUSTED flag set?

If an attacker loads a BPF STRUCT_OPS program and forges an arbitrary addre=
ss
into a PTR_TO_BTF_ID | PTR_UNTRUSTED pointer, they can attempt to write to
the scx.disallow field of this pointer. The BPF verifier's
check_ptr_to_btf_access unconditionally calls this btf_struct_access callba=
ck
for BPF_WRITE if the pointer is not program-allocated.

Since this callback returns SCALAR_VALUE without verifying the PTR_UNTRUSTED
flag on reg->type, the write is approved. The JIT will then emit a direct
BPF_MEM store instruction that silently overwrites the target address becau=
se
fixups skip BPF_PROBE_MEM conversion for BPF_WRITE on untrusted pointers.

Should we explicitly check for the PTR_UNTRUSTED flag in reg->type here?

	if (type_flag(reg->type) & PTR_UNTRUSTED)
		return -EACCES;

> +
> +	return -EACCES;
> +}
> +
>  static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
>  				     const struct bpf_reg_state *reg, int off,
>  				     int size)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D8
