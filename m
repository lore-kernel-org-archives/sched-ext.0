Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606F145355
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384230; cv=none; b=ZwtwV6pV9cCdgM/rjybEYMsTt6TBHnupu9YPfqiiBlSwdGqsUg461twyH+2Bih3nVpFxXrSHBsNV+68qgW6ZDofoEqLJqk7AUdco6VmqN+xzpYODBVhti0SEWOlXD29MfSzt6rKglIZ0dvZTjRTrO3/EsShFD2ZQRDyf2/WDKdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384230; c=relaxed/simple;
	bh=Bwd5Kb3ws0yUB1ptWNOXn3LLLmeobPwVema4reJbMfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W2DyLxOdlZOR6vdCT11YtYtUBiqyGA6R0AJt/1YkqjLoAsO9p20P/ls6BBZcvZxQXQPvgv58G9LL1jVgPIk8BDVACsX3TVRmtOebfQ6ky3ZbI0aoD0TXAMfS/UkgoS1/Ta8qWCF79F1zWvA7/PsEaRirNdeEmeeDdaVlI7OqkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HogZH9hR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HogZH9hR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D7A1F000E9;
	Tue,  7 Jul 2026 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384228;
	bh=IcbvtKNQptGmbLRNZ3ntaNMhHsAtxTqIE0gLrqi8AWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HogZH9hR75m8Pky/IyXayPVBRiyS+2bBdtH2L9bqWRgEuHVCikpvBClz3uWGAhi3a
	 Ja6hS/DhQbZmIN+j8hgXzKJaZC6zTnhyv3Z1dFrb62ztltGHgNxSoaPwp0DLP7WQpv
	 RMvpsKuE9PVExP8+3LBRnXORcLjmyfOvSh8XD2ARJRJQxJTmm23UqYFHnMlTUnCXZb
	 w6hr9s3rZRw+IkJNI44sfxlew9LVURzO1taEFH9/L3SfSc9uqlS6vx53yqA3rG+F9j
	 GuclsFOx+OcdWRGxYUraa1QNR6lfpoErhOmi2J41WjX0r/6yHzosInmaOHuCd2evpY
	 7YBZJYqh3+C7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 16/36] sched_ext: Build the
 set_cmask scratch from trusted geometry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-17-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-17-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:30:28 +0000
Message-Id: <20260707003028.82D7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The functions `scx_cpumask_to_cmask` and `scx_cmask_clear` were lef=
t in the codebase despite being completely unused after this patch.
--

--- Patch [16]: [PATCH v3 sched_ext/for-7.3 16/36] sched_ext: Build the set=
_cmask scratch from trusted geometry ---
commit aafcbdb12be7e475e0dfdb8c0906f3356f2353dd
Author: Tejun Heo <tj@kernel.org>

sched_ext: Build the set_cmask scratch from trusted geometry

scx_call_op_set_cpumask() builds a per-cpu cmask in the set_cmask scratch,
which lives in BPF-writable arena. A scheduler can corrupt the scratch's
inline header (base, nr_cids, alloc_words) from another cpu, so sizing and
indexing the write from it risks an out-of-bounds write.

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

[Severity: Low]
With this removal of the call to scx_cpumask_to_cmask(), it looks like
scx_cpumask_to_cmask() and its helper scx_cmask_clear() are now completely
unused.

Should their definitions and declarations in kernel/sched/ext/cid.c and
kernel/sched/ext/cid.h be removed as well to avoid leaving dead code?

> +		scx_cmask_ref_init_kern(sch, kern_va, 0, num_possible_cpus(), &ref);
> +		scx_cmask_ref_from_cpumask(&ref, cpumask);
>  		SCX_CALL_CID_OP_TASK(sch, set_cmask, rq, task,
>  				     scx_kaddr_to_arena(sch, kern_va));
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D16
