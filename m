Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8D219D8A8
	for <sched-ext@lists.linux.dev>; Wed,  3 Jun 2026 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507885; cv=none; b=WHEG46GB4uv2/uqXb1FeXQ0Nia8w6e2/TXOYZ3pcsKGOhZOQeOjmRfDB+8Cyw+CyC5VWysti8WfxqWpiHmvSQxjjRWV3CaDjGNMHHPHk9XBKGcCNxLQa3pn15of8TpYuny7dDMB5UNOpc+06Ke0NOQvLLtRtHSjWq1bmcOGjrC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507885; c=relaxed/simple;
	bh=iJtusFDn8G6/kqM7NwdaLFu9G+GGunuYLp6loFuENA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B16llvv2TqAYOtDgVBit6AfXvTXGaZHM2Q5KBS32Ku6VFcdA0pMSO0gSF85njjRm9MNYMZWT1IGkVkIqeaCQ08vDrur8Gp6vs5fFs/qZlvBBoBJJb9OQLKPslr6bnuyBGgJEKnwXRwBIVnE8CRylWJt4ZBSWK7bIL2bTobGeOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuDtIP4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuDtIP4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312DC1F00893;
	Wed,  3 Jun 2026 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780507884;
	bh=nqz52gEr2QGu+Fk2Oa+PZamiAx0QodAkoOPGp13D5H8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fuDtIP4L0KRxg5eoR0iVTQ10ajE2Iz7dqNTWcXZg6p/FReAHnlj2dogewd24oJz2T
	 3tRnCphXavsNC3Q+N5Ixc+YFzxF8zWURriTnmhDrHIvylCE5DcseLoSfEk7UhAvzFQ
	 sP/lElJoiwPWO8OgmmQF4eWWF7AXN9YXkzPhoyyfEHaypGuzBcERwVk7QXlG6rDkZa
	 ErHkNWTRBUdtjjiRYlXDxZcyaVGnXSRHOTT14xhR5pW2mUIWn4PVrEcxoodpJRPZDJ
	 K2kTP0+ByFUSwb7gxrWAmfhdaLaWswnSu6m5ltOCheu683USaDLR8x7RTv09m1hGOd
	 fAT9oUNDeafVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] sched_ext: Order single-cid cmask helpers as (cid,
 mask)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260603172153.3081861-2-tj@kernel.org>
References: <20260603172153.3081861-2-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 17:31:23 +0000
Message-Id: <20260603173124.312DC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete refactoring of cmask helpers argument order, causing =
an API divergence between kernel and BPF implementations.
--

commit cae9caa6c3655ef0cb4c126820c635529b2d5e19
Author: Tejun Heo <tj@kernel.org>

sched_ext: Order single-cid cmask helpers as (cid, mask)

This commit reorders the parameters of single-cid cmask helpers to take the
cid before the mask. This change is intended to make the parameters consist=
ent
with standard kernel predicates like cpumask_test_cpu(cpu, mask).

> diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
> index abea22ba2cc25..46fd8eda04435 100644
> --- a/kernel/sched/ext_cid.h
> +++ b/kernel/sched/ext_cid.h

[ ... ]

> @@ -218,11 +218,11 @@ static inline void scx_cmask_reframe(struct scx_cma=
sk *m, u32 base, u32 nr_cids)
>  	m->nr_cids =3D nr_cids;
>  }
> =20
> -static inline void __scx_cmask_set(struct scx_cmask *m, u32 cid)
> +static inline void __scx_cmask_set(u32 cid, struct scx_cmask *m)
>  {
> -	if (!__scx_cmask_contains(m, cid))
> +	if (!__scx_cmask_contains(cid, m))
>  		return;
> -	*__scx_cmask_word(m, cid) |=3D BIT_U64(cid & 63);
> +	*__scx_cmask_word(cid, m) |=3D BIT_U64(cid & 63);
>  }
> =20

[Severity: Medium]
The commit message states the intent to reorder the cmask helpers for
consistency, but does this refactoring inadvertently omit the BPF-facing
helpers?

The kernel-side helpers in ext_cid.h are updated here to use the new
(cid, mask) order, but the equivalent functions in
tools/sched_ext/include/scx/cid.bpf.h appear to still use the old
(mask, cid) ordering:

tools/sched_ext/include/scx/cid.bpf.h:
static __always_inline void cmask_set(struct scx_cmask __arena *m, u32 cid)
static __always_inline bool cmask_test(const struct scx_cmask __arena *m, u=
32 cid)
static __always_inline bool __cmask_contains(const struct scx_cmask __arena=
 *m, u32 cid)

Could this introduce an API divergence between the kernel and BPF
implementations for developers writing BPF schedulers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603172153.3081=
861-1-tj@kernel.org?part=3D1
