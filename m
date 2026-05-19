Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764F38F244
	for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181925; cv=none; b=KqfpZV8zii6VsCBc68AL0EaF5V255K3NuFmD3T40SirYuc2CY9q2mgjQZ1QQBH+PB/F1dBIpwix9T3jbkZhZjBg5CBDNje9UtarF/6dcqraXNXeit+VJeHb+KMs2jyW99LKOGLotZUCyEvTq/W6YM2NzSGuzG6Td1+uh8ys4Zb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181925; c=relaxed/simple;
	bh=eYsNWwZ1ikWKX2atI5hWcehxAzv0nJTcEimbsX7Hywc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sfSVnU6GZ0n18PkxN18fFJmICgbOGAjx0Q6yEPKtSh3pGRtMCeOJMhaN+PJC9bayy38vvvQlJ4OsoBHo0kAA8gf7PgAXAaDwJr6lzEDEIONT8Cxj+bvXEp2anz19PUblKYhjnf6PBxHY2Xc8NBrwb5FpgatgqttdowfXIOLQSD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIpSV4/x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIpSV4/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4015C2BCB3;
	Tue, 19 May 2026 09:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779181924;
	bh=eYsNWwZ1ikWKX2atI5hWcehxAzv0nJTcEimbsX7Hywc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JIpSV4/x4jvYAFPLtcRlB5zsy5hHc2avaUL+W8NPgyXut5SXJhAzCyOUIExfOjPmz
	 RbYzQgxTbFNVVqsTOAFu3/mhoJ4t7we2ZfWMtOOQfrk/+2bWDotJWJ7XF8zOH6uLOk
	 /t1JOtErALoDQOCuWuUJ+FBDSpctPeE/Siz0pq2lQdl6ttaCRlPPdgJVmxLzGss7Ne
	 rB+5FZb6OF9IkZdUCgWzZDKW0x9GkBaKfpk1powIGCrI2ufkzFcTZvB+rQlsBb6UbC
	 tkl1sz50+IFd8EO4YawDdncM9ESiEv95az8Il37feF+XCNZsOMjLuY9PDy3bIr2EB6
	 e4J7lr9bFhxfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] sched_ext: Add cmask mask ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260519075838.2706712-4-tj@kernel.org>
References: <20260519075838.2706712-4-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 09:12:01 +0000
Message-Id: <20260519091204.A4015C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] scx_cmask_and() and scx_cmask_copy() fail to clear destination bit=
s outside the source mask's range, breaking expected set semantics.
--

commit 009e14b778a21e3b2cdd8abbf60a8256e3cacb80
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add cmask mask ops

This commit introduces operations on cmasks, including mutating operations
like and/or/copy/andnot and predicates like subset/intersects/empty. It
implements cmask_walk_op2() to process the intersection of two mask ranges.

> diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
> index 44dd47a877090..0c91b951fd33c 100644
> --- a/kernel/sched/ext_cid.c
> +++ b/kernel/sched/ext_cid.c
[ ... ]
> +/*
> + * Set ops on cmasks. cmask_walk_op2() shares one walk across mutating
> + * (and/or/copy/andnot) and predicate (subset/intersects) two-cmask form=
s;
> + * cmask_walk_op1() does the same shape over a single cmask range. Every=
 public
> + * entry passes a compile-time-constant @op; cmask_walk_op{1,2}() and
> + * cmask_word_op{1,2}() are __always_inline so the inner switch collapse=
s to the
> + * selected op and cmask_op2_is_pred() folds the predicate early-exit ou=
t of
> + * mutating ops.
> + *
> + * Two-cmask ops only touch @dst bits inside the intersection of the two=
 ranges;
> + * bits outside stay untouched. In particular, scx_cmask_copy() does NOT=
 zero
> + * @dst bits that lie outside @src's range.
> + *
> + * The _RACY variants are otherwise identical to their non-racy counterp=
art but
> + * read @src word-by-word via data_race(). Memory ordering with concurre=
nt
> + * writers is the caller's responsibility.
> + */
[ ... ]
> +static __always_inline bool cmask_walk_op2(u64 *a_bits, u32 a_base, u32 =
a_nr_cids,
> +					   const u64 *b_bits, u32 b_base, u32 b_nr_cids,
> +					   const enum cmask_op2 op)
> +{
> +	u32 lo =3D max(a_base, b_base);
> +	u32 hi =3D min(a_base + a_nr_cids, b_base + b_nr_cids);
[ ... ]
> +void scx_cmask_and(struct scx_cmask *dst, const struct scx_cmask *src)
> +{
> +	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
> +		       src->bits, src->base, src->nr_cids, CMASK_OP2_AND);
> +}
[ ... ]
> +void scx_cmask_copy(struct scx_cmask *dst, const struct scx_cmask *src)
> +{
> +	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
> +		       src->bits, src->base, src->nr_cids, CMASK_OP2_COPY);
> +}

While the comment documents that bits outside the intersection stay untouch=
ed,
could exposing these as standard scx_cmask_and() and scx_cmask_copy()
operations cause regressions for callers expecting standard set semantics?

For scx_cmask_and(), any bits in dst outside src's bounds implicitly evalua=
te
to 0 in src, but since cmask_walk_op2() restricts its bounds to the
intersection, those bits in dst are left unmodified rather than being clear=
ed.

Similarly for scx_cmask_copy(), dst retains any previously set bits that fa=
ll
outside src's bounds.

Could callers relying on standard bitwise AND or COPY semantics end up with
stale bits in dst, leading to unexpected behavior in the scheduler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519075838.2706=
712-1-tj@kernel.org?part=3D3
