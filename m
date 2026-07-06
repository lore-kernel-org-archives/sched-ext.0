Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127091A3165
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 01:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303169; cv=none; b=RyY9KD6UGaY27xlqNu9aov8mA1EkAPCaPXFHFJCirrFAJq++y0NNersi0HbdjDTb0/cXxFuvh4v/Kx/QksRn5pJ4JpfSvInS7dS3zb4tquRZIlxB24Mo049n5tIO7Bh7U3JRv5sTOVw0YtxvYF7vhFh1cXACowGpsOXj7ke/N2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303169; c=relaxed/simple;
	bh=XfTeciRaH+E8K9D7QTvU7e2+L2Mylt/D5wAsYJvVHss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H/3pJEiw/vQ3gXsd71KqQvHErgNzTE9hsVPbiowXBTA3tVaByNE+jvssjV7TZB9LloxaFX4Hn/NeQZu3HRSx6bBWxlxUCDRrrIpnhx8RrDQjygb2bcaBSMFWHBHCSRCglz3x+wSl2u/Ja/ShPRzA1hCh7rPUcKqJI0z4TaYVmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKoAwnc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKoAwnc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4C81F000E9;
	Mon,  6 Jul 2026 01:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303167;
	bh=GN7beIazlLmFqAcqY84HKGA2+RQvlYxwxNuVPTbTiH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mKoAwnc6OMPGSVgV3j4rTzsjs3DPMw1wUJGc8zgXMI7zpENJ9Ifse/b1koCGFdkIr
	 UtEuZypMLxi/IY8iFKM4e8tfTj6AHsCB1IM0yz4GyHifJ6ZGvs91jwwCFtOGyrz2TZ
	 wAckfAsWjU8rRzYct8FGj+eteoLn163AmOpjLSO+x0CdHzCZwVgQ3E8VtXlsX47V8E
	 V8fGXfQtQ6DsoF5mQ4ODBscdXj+mUWOV2q7oxFE4rkjUpnxRU4/lQqqLOIbvJubgbe
	 u2IQeoRpjQWDcNee38bZdQ6n87tXnAyD7rKy6BRJ12dsElpW5U7UGn4b4O2f2nI31p
	 sO7Kl/ip+16nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 16/36] sched_ext: Build the
 set_cmask scratch from trusted geometry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-17-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-17-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 01:59:26 +0000
Message-Id: <20260706015927.2C4C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A concurrent BPF write to `alloc_words` triggers a kernel panic vi=
a the `__counted_by` compiler-inserted bounds check.
- [High] A BPF scheduler of cid-form can trigger a NULL pointer dereference=
 (with per-cpu offset) and arbitrary memory corruption by defining `set_cma=
sk` without providing an arena map.
--

commit dc47d369970061036c6652d545aa537ea7f9145d
Author: Tejun Heo <tj@kernel.org>

sched_ext: Build the set_cmask scratch from trusted geometry

This commit modifies scx_call_op_set_cpumask() to build the per-cpu cmask
from trusted kernel geometry rather than reading the BPF-writable arena
header. This prevents potential out-of-bounds writes if a concurrent BPF
program modifies the header.

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index 42fc8348b3b4c..465e4e7b06197 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c

[ ... ]

> @@ -1029,6 +1061,44 @@ void scx_cmask_ref_copy(const struct scx_cmask_ref=
 *ref, const struct scx_cmask
>  		       src->bits, src->base, src->nr_cids, CMASK_OP2_REF_COPY);
>  }
> =20
> +/**
> + * scx_cmask_ref_from_cpumask - Populate @ref's arena cmask from a cpuma=
sk
> + * @ref: kern-bound ref, see scx_cmask_ref_init_kern()
> + * @cpumask: cpus to translate into cids
> + *
> + * Write @ref's active range one word at a time, setting each cid's bit =
when
> + * its cpu is in @cpumask. Offsets and length come from @ref's trusted g=
eometry
> + * and stores use WRITE_ONCE since BPF may read concurrently, so the are=
na
> + * header is never read.
> + */
> +void scx_cmask_ref_from_cpumask(const struct scx_cmask_ref *ref,
> +				const struct cpumask *cpumask)
> +{
> +	struct scx_cmask *m =3D ref->src;
> +	u32 base =3D ref->base, nr_cids =3D ref->nr_cids;
> +	u32 wi, nr_words;
> +
> +	if (!nr_cids)
> +		return;
> +
> +	nr_words =3D (base + nr_cids - 1) / 64 - base / 64 + 1;
> +	for (wi =3D 0; wi < nr_words; wi++) {
> +		u32 word_first_cid =3D (base / 64 + wi) * 64;
> +		u64 word =3D 0;
> +		u32 bit;
> +
> +		for (bit =3D 0; bit < 64; bit++) {
> +			u32 cid =3D word_first_cid + bit;
> +
> +			if (cid < base || cid >=3D base + nr_cids)
> +				continue;
> +			if (cpumask_test_cpu(__scx_cid_to_cpu(cid), cpumask))
> +				word |=3D BIT_U64(bit);
> +		}
> +		WRITE_ONCE(m->bits[wi], word);

[Severity: High]
This isn't a bug introduced by this patch, but does this write still
implicitly read the BPF-writable arena header due to the __counted_by
attribute on the bits array in struct scx_cmask?

The struct scx_cmask definition in kernel/sched/ext/types.h is:
    struct scx_cmask {
        u32 base;
        u32 nr_cids;
        u32 alloc_words;
        u64 bits[] __counted_by(alloc_words);
    };

The __counted_by annotation instructs the compiler to insert runtime bounds
checks. Doesn't this mean the compiler will implicitly read m->alloc_words
during the WRITE_ONCE access?

If a concurrent BPF program modifies m->alloc_words to 0 in its BPF arena
while the kernel executes scx_cmask_ref_from_cpumask(), could this trigger a
kernel panic via the compiler-inserted bounds check?

> +	}
> +}
> +

[ ... ]

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index a5e782147bf40..8ee980f822aac 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -412,12 +412,15 @@ static inline void scx_call_op_set_cpumask(struct s=
cx_sched *sch, struct rq *rq,
>  {
>  	if (scx_is_cid_type()) {
>  		struct scx_cmask *kern_va =3D *this_cpu_ptr(sch->set_cmask_scratch);

[Severity: High]
This isn't a bug introduced by this patch, but can this dereference a NULL
pointer with a per-cpu offset if a BPF scheduler defines the set_cmask
callback without providing an arena map?

In scx_set_cmask_scratch_alloc(), if the arena pool is missing:
    if (!sch->is_cid_type || !sch->arena_pool)
        return 0;

This leaves sch->set_cmask_scratch as NULL instead of returning an error.

When scx_call_op_set_cpumask() calls this_cpu_ptr() on a NULL pointer, it
resolves to the raw per_cpu_offset, leading to reading a garbage pointer
which is then passed to scx_cmask_ref_init_kern() causing memory corruption.

Should the scheduler validate the presence of the arena map?

> +		struct scx_cmask_ref ref;
> +
>  		/*
> -		 * Build the per-CPU arena cmask and hand BPF its arena address.
> -		 * Caller holds the rq lock with IRQs disabled, which makes us
> -		 * the sole user of the scratch area.
> +		 * Build the per-cpu arena cmask from kernel geometry via @ref,
> +		 * never reading its BPF-writable header, and hand BPF the arena
> +		 * address. The rq lock makes this cpu the sole kernel writer.
>  		 */
> -		scx_cpumask_to_cmask(cpumask, kern_va);
> +		scx_cmask_ref_init_kern(sch, kern_va, 0, num_possible_cpus(), &ref);
> +		scx_cmask_ref_from_cpumask(&ref, cpumask);
>  		SCX_CALL_CID_OP_TASK(sch, set_cmask, rq, task,
>  				     scx_kaddr_to_arena(sch, kern_va));
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D16
