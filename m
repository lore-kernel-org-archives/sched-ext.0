Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D41495043
	for <sched-ext@lists.linux.dev>; Fri, 18 Sep 2026 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765834; cv=none; b=cxiRWtQHk6jtxTbE10icSxKvqv8e+WpbdTdFeao3BPfKG5EHr+akEwHOV8hN0Haq8+Yw+/ZpNoz89OBivDyo/STHCAyBSSvAR3PjEN3Zb7X2mNiIftE4IMUeeW6YmLajcl1Ehe9CPbp4wXNf5mNQCEfOrn5NSJY9wv+o8ED/OWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765834; c=relaxed/simple;
	bh=upvUcz/ssKLFt3/ZBANdYNQtXhTQzXlqMWD8eXfNFCI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LQ8RvYhr3okHTtQxyQXoH6fW5fmivJ4Upv1lkpCP34ovK+/nwlVegnuML8xFdUWXdXNgl0DyShosFAWBcrrXiJllpb8R0lPM/CeXkAcKBk+7LiEbN+LE5+Fr5cDb6rUFV13BKznJFuEJytksmNst1KxukhUftBKMpvNroTF6hok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9SilzxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9SilzxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C2E1F00898;
	Fri, 18 Sep 2026 21:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765832;
	bh=gpwUG/6E6R93wzMFJLfX6TF7Os7v6J+OT9Mm5humYD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X9SilzxBgUN37a/dly8UXuZdw+rXah9zMWRCyq13JBebwE0UGKzllO1/7aE/vghNK
	 m2Mb/GY5//2Cile40HG5il9wvBYm3bLrXHx8o/4+ypEsKZ/6oyL5n8AAd5oJ92gAcg
	 66HtUCu/nFBZU+go/phtSRZOEwfsDXwzDWrMiOJtkQ89NPc77bn13fyH2eQbf+Uwpr
	 AM1NDeZTShfZGz1aKDXd2D7G/tuVvixBNX473YtydSUJBiYF57ovGrvKWpCP2OtIIJ
	 1vStjRF+yjYwdXLEYGWEMFiOYVwT44Hnm+5HrnNScPiHe+ISqOF1dN5OStr65atjQo
	 K0HN8BF7tkpXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Pass the initial
 cmask to cid-form ops.enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <c8343c2e457508a6cd3fcab66b0823b6@kernel.org>
References: <c8343c2e457508a6cd3fcab66b0823b6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:10:32 +0000
Message-Id: <20260918211032.95C2E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched_ext: Type confusion in scx_enable_args.cmask causes kernel p=
anic
--

commit 68c6e46ced10fbf4dca95b3687b46574af4872a5
Author: Tejun Heo <tj@kernel.org>
Subject: sched_ext: Pass the initial cmask to cid-form ops.enable()

This commit adds `struct scx_enable_args` to pass the initial `cmask` to
cid-form `ops.enable()` callbacks. This avoids relying on `init_task()` to
seed the affinity mask, allowing schedulers to track affinity entirely with=
in
`set_cmask()`.

> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 6d369b6487a3c..b053a11163c6f 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
[ ... ]
> @@ -250,6 +250,24 @@ struct scx_exit_task_args {
>  	bool cancelled;
>  };
> =20
> +/**
> + * struct scx_enable_args - Argument container for cid-form ops.enable()
> + * @cmask: cids the task may run on, as a BPF arena pointer
> + *
> + * @cmask is the task's affinity as it enters the scheduler. set_cmask()
> + * delivers the same mask after enable() and before the task is first en=
queued,
> + * then every affinity change afterwards, and is never called before ena=
ble(). A
> + * scheduler may therefore track affinity in set_cmask() alone.
> + *
> + * The kernel builds @cmask in the scheduler arena from its own geometry=
, so the
> + * header is valid regardless of what the scheduler last wrote there. Th=
e memory
> + * is per-cpu scratch reused once the callback returns: copy the bits ou=
t, don't
> + * keep the pointer. The set_cmask() argument follows the same rules.
> + */
> +struct scx_enable_args {
> +	const struct scx_cmask	*cmask;
> +};

[Severity: High]
Does this struct field need an arena BTF tag (e.g., __arena)?

Because it is currently typed as a regular kernel pointer, the verifier mig=
ht
treat `args->cmask` as a regular kernel pointer (`PTR_TO_BTF_ID`) rather th=
an
a 32-bit arena offset.

[ ... ]
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index a7005deda6d87..99e660649d15a 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -3944,11 +3956,28 @@ static void __scx_enable_task(struct scx_sched *s=
ch, struct task_struct *p)
> =20
>  	p->scx.weight =3D sched_weight_to_cgroup(weight);
> =20
> -	if (SCX_HAS_OP(sch, enable))
> -		SCX_CALL_OP_TASK(sch, enable, rq, p);
> +	if (SCX_HAS_OP(sch, enable)) {
> +		if (scx_is_cid_type()) {
> +			struct scx_cmask *cmask =3D scx_fill_cmask_scratch(sch, p->cpus_ptr);
> +			struct scx_enable_args args =3D {
> +				.cmask =3D scx_kaddr_to_arena(sch, cmask),
> +			};
> +
> +			SCX_CALL_CID_OP_TASK(sch, enable, rq, p, &args);

[Severity: High]
Could this assignment cause a kernel panic when accessed by the BPF program?

The kernel address is converted to a 32-bit arena offset via
scx_kaddr_to_arena() before being assigned to args.cmask, explicitly bypass=
ing
the struct_ops trampoline rebasing.

If the verifier treats this field as a standard pointer (due to the missing
arena tag mentioned above), dereferencing it in the BPF program might cause
the JIT to omit the arena base addition. This would result in a raw 32-bit
memory access and trigger a kernel page fault.

Furthermore, if the BPF program attempts to cast it to an arena pointer usi=
ng
bpf_addr_space_cast, the verifier would subtract the arena base a second ti=
me,
resulting in an invalid offset.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/c8343c2e457508a6cd3=
fcab66b0823b6@kernel.org?part=3D1
