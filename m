Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0A33AD99
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067603; cv=none; b=EHeXlpRCosfN1/qi9eNey93lS3GvJFWLkYAZ+m8ZaC17g1rmX+udJE3udkNWZoiwhsXRa0fz5Gpd3S5ctOhJuOWzJR1Pwf6abUwDyA4SjZPuAPtnq9byy1dSsTTXD2e1WPIDrndsbLZsE0R8UJKBNxdF/oy1ovGTDY3YeSuUsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067603; c=relaxed/simple;
	bh=5gQyENPots7xL86/vFXPb21nK0qh7kY7T5yrGLQ34UM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DHPSKpwoeHyNJ8G30pxbEjgeZOBbWALMyuzMo6Qk2HJDJa4IDXmPYsvdNXsZ0ENTVezV02+mx6i9dsFro1SaC5Aou+V83aIJ1OJJMBjOWLHBLNFKUV08ZRlims41DIMloUChEMou7i+R9cq1wCJnEJWJu3ZAARKcO6TYMSMdLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D22KjYtM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D22KjYtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691901F000E9;
	Fri,  3 Jul 2026 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783067601;
	bh=KOJqXPG5BXK6N2RzWDFjJxHVNTeaQktZ4FHsDAL3cuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D22KjYtMlzxBPFvb0jmoYh7tWzKvchIafGce7L1jkQinUYOewDrx/pHtJaBM14NAc
	 f8ANvphwtbwAL65RKxoPD0bdaXX4bFweNNetrXjtPf0EEGVlyRfayMlvBUQQE3w0O3
	 IKy0+HQWxuRM9uR7ePkhXOCnfPUpONR7CMNlEKexcc+OLZIzhauOS/TM99uqd4pWPO
	 QjyrcxsepbLO+UBiQT7hbCSOG2LpnsCCnaQLaCuEIz5la9imB/t3/7bjOBny2j+1/+
	 rPZzgZgJA/hDtVbbAO7ilHzNuK7zJYLAzAE/k4V135y6Hi8I1HNfKtw5dDtNo79h5A
	 VabxEPLqalCQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 03/32] sched_ext: Use
 READ_ONCE/WRITE_ONCE in cmask word ops and drop _RACY variants
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-4-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-4-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:33:20 +0000
Message-Id: <20260703083321.691901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Missing READ_ONCE() in cmask_word_op1 leaves scx_cmask_empty() a=
nd the boundary checks of scx_cmask_subset() vulnerable to data races.

Pre-existing issues:
- [Critical] The kernel trusts inline metadata (nr_cids, base) from BPF are=
na cmasks without bounds checking, allowing userspace or BPF to trigger mas=
sive out-of-bounds zeroing of kernel memory.
--

commit dff79ba0834e741aea85b2036409e261619d8a3c
Author: Tejun Heo <tj@kernel.org>

sched_ext: Use READ_ONCE/WRITE_ONCE in cmask word ops and drop _RACY varian=
ts
   =20
The cmask ops can operate on BPF-arena cmasks which BPF programs may read
and write concurrently. The _RACY op variants existed to make such lockless
reads explicit but this turned out to be too restrictive. Mark the word
accesses in all the two-cmask ops with READ_ONCE/WRITE_ONCE instead and drop
the _RACY variants.

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index af83084ec740a..4b7279ca740f4 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
[ ... ]
> @@ -422,28 +420,22 @@ static __always_inline bool cmask_word_op2(u64 *av,=
 const u64 *bp, u64 mask,
>  {
>  	switch (op) {
>  	case CMASK_OP2_AND:
> -		*av &=3D ~mask | *bp;
> +		WRITE_ONCE(*av, *av & (~mask | READ_ONCE(*bp)));
>  		return false;
>  	case CMASK_OP2_OR:
> -		*av |=3D *bp & mask;
> -		return false;
> -	case CMASK_OP2_OR_RACY:
> -		*av |=3D data_race(*bp) & mask;
> +		WRITE_ONCE(*av, *av | (READ_ONCE(*bp) & mask));
>  		return false;
>  	case CMASK_OP2_COPY:
> -		*av =3D (*av & ~mask) | (*bp & mask);
> -		return false;
> -	case CMASK_OP2_COPY_RACY:
> -		*av =3D (*av & ~mask) | (data_race(*bp) & mask);
> +		WRITE_ONCE(*av, (*av & ~mask) | (READ_ONCE(*bp) & mask));
>  		return false;
>  	case CMASK_OP2_ANDNOT:
> -		*av &=3D ~(*bp & mask);
> +		WRITE_ONCE(*av, *av & ~(READ_ONCE(*bp) & mask));
>  		return false;
>  	case CMASK_OP2_SUBSET:
>  		/* stop on the first bit in @sub not set in @super */
> -		return (*bp & ~*av) & mask;
> +		return (READ_ONCE(*bp) & ~READ_ONCE(*av)) & mask;
>  	case CMASK_OP2_INTERSECTS:
> -		return (*av & *bp) & mask;
> +		return (READ_ONCE(*av) & READ_ONCE(*bp)) & mask;
>  	}
>  	unreachable();
>  }

[Severity: Medium]
Since READ_ONCE() was added to cmask_word_op2() to prevent data races and l=
oad
tearing when reading BPF-arena cmasks locklessly, shouldn't it also be adde=
d to
cmask_word_op1() in kernel/sched/ext/cid.c?

For example, when scx_cmask_subset() checks the boundaries:

    if (sub->base < super->base &&
        cmask_any_set_in_range(sub, sub->base, min(super->base, sub_end)))
        return false;

This triggers a lockless cmask_word_op1() on sub, which can be an arena cma=
sk
mutated by BPF:

    case CMASK_OP1_ANY_SET:
        return *ap & mask;

Could this unprotected read leave scx_cmask_empty() and the boundary checks=
 of
scx_cmask_subset() vulnerable to data races?

[ ... ]
> diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
> index 9c4f4b907f12d..54b10df32fd50 100644
> --- a/kernel/sched/ext/cid.h
> +++ b/kernel/sched/ext/cid.h
> @@ -57,9 +57,7 @@ void scx_cmask_clear(struct scx_cmask *m);

[Severity: Critical]
This is a pre-existing issue, but does scx_cmask_clear() blindly trust inli=
ne
metadata from BPF arena cmasks without bounds checking?

When the kernel allocates set_cmask_scratch in the BPF arena using
scx_arena_alloc(), and later calls scx_cpumask_to_cmask() in
kernel/sched/ext/ext.c:scx_call_op_set_cpumask():

    struct scx_cmask *kern_va =3D *this_cpu_ptr(sch->set_cmask_scratch);
    ...
    scx_cpumask_to_cmask(cpumask, kern_va);

This eventually calls scx_cmask_clear(kern_va) in kernel/sched/ext/cid.c, w=
hich
calculates the memset size based on the cmask's inline fields:

    nr_words =3D (m->base + m->nr_cids - 1) / 64 - m->base / 64 + 1;
    memset(m->bits, 0, nr_words * sizeof(u64));

If an untrusted BPF program or userspace process concurrently overwrites
m->nr_cids or m->base with a massive value, could this trigger an out-of-bo=
unds
memset that zeroes out kernel memory adjacent to the arena allocation?

>  void scx_cmask_fill(struct scx_cmask *m);
>  void scx_cmask_and(struct scx_cmask *dst, const struct scx_cmask *src);
>  void scx_cmask_or(struct scx_cmask *dst, const struct scx_cmask *src);
> -void scx_cmask_or_racy(struct scx_cmask *dst, const struct scx_cmask *sr=
c);
>  void scx_cmask_copy(struct scx_cmask *dst, const struct scx_cmask *src);
> -void scx_cmask_copy_racy(struct scx_cmask *dst, const struct scx_cmask *=
src);
>  void scx_cmask_andnot(struct scx_cmask *dst, const struct scx_cmask *src=
);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D3
