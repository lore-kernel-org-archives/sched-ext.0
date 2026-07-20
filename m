Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D97D23D7FB
	for <sched-ext@lists.linux.dev>; Mon, 20 Jul 2026 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537125; cv=none; b=eCD6YKrFCzzzqdVZHmTejEJRHWemZWA9cTEtQndNJ/lsTbMsrAdK2tpQyfdUGF3IerfaVB9Ga+4A5KEEbsNJwEtb3Kp2tXfJigdxGLdyeYXhT7cK1bL7mSrwLy6kRWjxVI0SdLKzLkiqqCDA7FTNoZfvenvSJOQh/0q5wKOophM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537125; c=relaxed/simple;
	bh=leUJ2kncsGbYqfoIOFMZy1z/hRX6sjHfPhxWACyihdY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pae9pdNAx23rdHLSVQINOmxFwajDjgVFXgiOJLP0r44CeKW44jMAgc3cvyPaa82a0Ncop9V3MdNOWoUs7OgpwejyCWjW0g1AJc7ApHA8dwAs4JUyxzpJamFpz2M+JYxULvZTGd94m4Q7fHiRs7SVc3P+uJ0JKpoR7r3w/KqChGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSM7EP9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSM7EP9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1582F1F000E9;
	Mon, 20 Jul 2026 08:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537124;
	bh=MhK9tCJUTJoB8YyUs8G15OZ1o8pzng6Sh5j3JA0D4hI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LSM7EP9Nin/IAY2SCmY19IAfFWMsRypkwPphrSvVc2lbDtQq+bUbXkP7ArR8MW2Y+
	 hiIpFd91UrZiEbJRyNWktb7mEYwZKnmBYIwhGTcEm+XNwQvRiAfi9FdgfK7/EmTwOI
	 Hy3TVCmLg3G617VViZO9FB2N3vVzuhDmV2bOnCMwaKrEYzGVuZrwiYIK5P57x4N4kN
	 AfqHi757XUP/b7zAL1tZcPfD2d/nAJGhp5d4KHZDJKYV9wdTYBd3CB21IgV+rR4No5
	 dewn8qRxDeVeyioLPFDt2r3oDWgbE8ujyDY4yppD0C2Grj+Qb2DBztAF1/Ge2fNFAn
	 yI4F46nmYs0IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] sched_ext: Guard the cid kfuncs against unallocated
 cid tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260720082605.1451945-4-tj@kernel.org>
References: <20260720082605.1451945-1-tj@kernel.org>
 <20260720082605.1451945-4-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 08:45:23 +0000
Message-Id: <20260720084524.1582F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] `__scx_cid_to_cpu()` is dead code after this patch.

Pre-existing issues:
- [High] Deterministic NULL pointer dereference in `__scx_cpu_to_cid()` dur=
ing the scheduler error disable path if CID tables fail to allocate. This p=
roblem wasn't introduced by this patch, but the commit message explicitly a=
nd incorrectly claims the tables are guaranteed to be allocated on the enab=
le path.
- [High] Information leak and data races due to early publication and non-a=
tomic writes to CID tables. This problem wasn't introduced by this patch, b=
ut the patch's attempt to fix the concurrent access window in `scx_bpf_cid_=
topo()` is incomplete.
--

--- Patch [3]: [PATCH 3/3] sched_ext: Guard the cid kfuncs against unalloca=
ted cid tables ---
commit 88c849437e9df48602b5417fe50640fa8c0c6abe
Author: Tejun Heo <tj@kernel.org>

sched_ext: Guard the cid kfuncs against unallocated cid tables

This commit adds NULL checks for the global CID tables in
scx_cid_to_cpu(), scx_cpu_to_cid(), and scx_bpf_cid_topo() to prevent
NULL pointer dereferences when BPF tracing programs execute during the
enable window.

> sched_ext: Guard the cid kfuncs against unallocated cid tables
>=20
> The cid tables are allocated by the first enable's scx_cid_init(), which
> runs after scx_alloc_and_add_sched() has published ops->priv. A TRACING or
> SYSCALL program associated with the enabling struct_ops map gets a non-NU=
LL
> sched from scx_prog_sched() as soon as ops->priv is set, so a cid kfunc
> called in that window dereferences the still-NULL table pointer. Only the
> first enable since boot is exposed as the tables are never freed.
>=20
> scx_bpf_this_cid() and scx_bpf_task_cid() already handle the window by
> testing the table pointer. Do the same in scx_cid_to_cpu(),
> scx_cpu_to_cid() and scx_bpf_cid_topo(), returning -EINVAL / all-(-1) topo
> as before any scheduler is enabled. __scx_cid_to_cpu() and
> __scx_cpu_to_cid() stay unchecked for callers with the tables guaranteed
> allocated - ops invocations on a live scheduler and the enable path itsel=
f.

[Severity: High]
This isn't a bug introduced by this patch, but the commit message explicitly
claims the tables are guaranteed to be allocated on the enable path. Is this
fully accurate if memory allocation fails?

If memory allocation fails in scx_cid_arrays_alloc() during scx_cid_init(),
it leaves the table pointers as NULL and returns -ENOMEM:

kernel/sched/ext/cid.c:scx_cid_arrays_alloc() {
    if (!cid_to_cpu || !cpu_to_cid || !cid_topo) {
        kfree(cid_to_cpu);
        kfree(cpu_to_cid);
        kfree(cid_topo);
        return -ENOMEM;
    }
}

The error handling path jumps to err_disable which calls scx_error(). This
queues an IRQ work that executes scx_dump_state(), which iterates over all
CPUs and calls scx_dump_cpu().

scx_dump_cpu() invokes the scheduler's dump_cpu op:

kernel/sched/ext/ext.c:scx_dump_cpu() {
    SCX_CALL_OP(sch, dump_cpu, rq, dctx, scx_cpu_arg(cpu), idle);
}

Because __scx_is_cid_type was already enabled via static_branch_enable()
prior to the failed initialization, scx_cpu_arg() calls __scx_cpu_to_cid(),
which unconditionally dereferences the NULL scx_cpu_to_cid_tbl.

Could this lead to a deterministic NULL pointer dereference during the
scheduler error disable path?

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index af83084ec740a..712920b79c9c7 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
> @@ -665,17 +665,18 @@ bool scx_cmask_empty(const struct scx_cmask *m)
>  __bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out__uni=
nit,
>  				  const struct bpf_prog_aux *aux)
>  {
> +	struct scx_cid_topo *topo =3D READ_ONCE(scx_cid_topo);
>  	struct scx_sched *sch;
> =20
>  	guard(rcu)();
> =20
>  	sch =3D scx_prog_sched(aux);
> -	if (unlikely(!sch) || !cid_valid(sch, cid)) {
> +	if (unlikely(!sch) || !cid_valid(sch, cid) || unlikely(!topo)) {
>  		*out__uninit =3D SCX_CID_TOPO_NEG;
>  		return;
>  	}
> =20
> -	*out__uninit =3D READ_ONCE(scx_cid_topo)[cid];
> +	*out__uninit =3D topo[cid];

[Severity: High]
This isn't a bug introduced by this patch, but does the patch's attempt to
fix the concurrent access window in scx_bpf_cid_topo() expose uninitialized
memory?

scx_cid_arrays_alloc() allocates scx_cid_topo without zeroing the memory
and immediately publishes it globally:

kernel/sched/ext/cid.c:scx_cid_arrays_alloc() {
    WRITE_ONCE(scx_cid_topo, cid_topo);
}

If a TRACING or SYSCALL BPF program executes concurrently before the array
is fully populated, the !topo check will pass, but topo[cid] may still
contain uninitialized kernel heap memory which is then copied to the BPF
output structure.

Additionally, scx_bpf_cid_override() modifies this structure:

kernel/sched/ext/cid.c:scx_bpf_cid_override() {
    scx_cid_topo[cid] =3D SCX_CID_TOPO_NEG;
}

Using non-atomic 16-byte writes while concurrent lockless readers can access
it could cause data races or tearing.

Should the array be zero-initialized or its population synchronized before
publishing?

>  }
> =20
>  __bpf_kfunc_end_defs();
> diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
> index 9c4f4b907f12d..4ac79f6d70566 100644
> --- a/kernel/sched/ext/cid.h
> +++ b/kernel/sched/ext/cid.h

[ ... ]

> @@ -117,13 +118,17 @@ static inline s32 __scx_cpu_to_cid(s32 cpu)
>   * Return the cpu for @cid or a negative errno on failure. Invalid cid t=
riggers
>   * scx_error() on @sch. The cid arrays are allocated on first scheduler =
enable
>   * and never freed, so the returned cpu is stable for the lifetime of th=
e loaded
> - * scheduler.
> + * scheduler. Return -EINVAL without triggering scx_error() if the table=
s are
> + * not allocated yet, which a prog-facing kfunc can observe while racing=
 the
> + * first enable.
>   */
>  static inline s32 scx_cid_to_cpu(struct scx_sched *sch, s32 cid)
>  {
> -	if (!cid_valid(sch, cid))
> +	s16 *tbl =3D READ_ONCE(scx_cid_to_cpu_tbl);
> +
> +	if (!cid_valid(sch, cid) || unlikely(!tbl))
>  		return -EINVAL;
> -	return __scx_cid_to_cpu(cid);
> +	return tbl[cid];

[Severity: Low]
Does replacing this call to __scx_cid_to_cpu() with a direct array read
leave the __scx_cid_to_cpu() inline function completely unused in the tree?
Could it be safely removed as dead code?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720082605.1451=
945-1-tj@kernel.org?part=3D3
