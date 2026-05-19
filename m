Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16FB3EFD0D
	for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180512; cv=none; b=LhHyUWjraqzP4IBzxaXbCCz0nIon+tXiaCNh8L6nvQGaS1z/CpQW5JPKiqaefsZJ1v0ylOgNwdICjuMFfYmO07jULDlrK53GVaHuK8bIrzlV1ucDC0yR3Vi5GtntggfJk3ORmX9AKhubglLqxmkfncft7bvJeKTRfoTzbQOL3L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180512; c=relaxed/simple;
	bh=A8NurAjVai1rXpe8+GFUNJmbcElMs4DSQAQrUeWGOWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QQqIlZd+MYEFO9IyzBeBI2OmZSUYYUpaA6VA53TZE601aZCvROuCxBjLYpZH0rBllkuwoEeEFqfQ+xbbohgAOSQMisQSRwRwY0K5byFS6q/ZPJbHE4/z/wiLNWKKDnTzpwa5RF2vv2fJ7etDJ6x4DwIb0j8F23YC508EabhhngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkB9m73H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkB9m73H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59B9C2BCB3;
	Tue, 19 May 2026 08:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779180512;
	bh=A8NurAjVai1rXpe8+GFUNJmbcElMs4DSQAQrUeWGOWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dkB9m73HiS+OWqck7EPQX5rX9kkW/rjmhVT/z4LwV6WXdwA6YLef/VZpsZBP2tnEL
	 hRfzmk+lyDrghYt1+9mv413Bbq7t6Rd4H90vSpLueckF6xPTj6Ec13tzpjz/aK6Z/A
	 5OCz0nAb5pKLT2+/kWwlzNg9Epz392cfuiZUH6WX1i9oKs7j1izhFQjYzL3WvR8u1k
	 4iGmzHqCUW9tEZVgM6y9d3FawesdTWfFjY6p3P00zkheTXfxe678lV/yWcON+0wyCX
	 nPqGZHaW3pjr+w2B8U8pQPGC3b7du1WkdlHuN+eEbjR8IV45uQspejwe8dz7uUTlU3
	 VlLRd9KyIwrdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] sched_ext: Track bits[] storage size in struct
 scx_cmask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260519075838.2706712-3-tj@kernel.org>
References: <20260519075838.2706712-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 08:48:30 +0000
Message-Id: <20260519084831.D59B9C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The `__SCX_CMASK_DEFINE` macro leaves the `bits[]` flexible array =
uninitialized, causing subsequent operations to operate on stack garbage.
- [Medium] The BPF helper `__cmask_init()` returns early on failure without=
 initializing the structure, exposing uninitialized memory to the executing=
 BPF program.
- [Medium] BPF `__cmask_init()` does not validate `alloc_cids` against `CMA=
SK_MAX_WORDS`, leading to inconsistent state and truncated operations.
- [Medium] Integer wrap-around in `cmask_reframe()` and `scx_cmask_reframe(=
)` leaves tail padding uncleared when `nr_cids` is near `U32_MAX`.
--

commit af0adccc546dd475652f096375ea97f8c951b0f6
Author: Tejun Heo <tj@kernel.org>

sched_ext: Track bits[] storage size in struct scx_cmask

This commit adds tracking of the allocated word count to scx_cmask, splits
the bit-range API into explicit-capacity and tight-capacity helpers, and
provides equivalent BPF mirror functions. It also adds clear and fill
helpers to manage the active-range bits safely.

diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
--- a/kernel/sched/ext_cid.h
+++ b/kernel/sched/ext_cid.h
[ ... ]
> +static inline void scx_cmask_reframe(struct scx_cmask *m, u32 base, u32 =
nr_cids)
> +{
> +	if (WARN_ON_ONCE(SCX_CMASK_NR_WORDS(nr_cids) > m->alloc_words))
> +		return;
> +
> +	if (nr_cids) {
> +		u32 last_word =3D ((base & 63) + nr_cids - 1) / 64;

The commit message states:
"Widen SCX_CMASK_NR_WORDS()/CMASK_NR_WORDS() to compute in u64 so that
@nr_cids near U32_MAX no longer wraps to a small value and bypasses
the bounds check in cmask_reframe()."

Despite this, could the last_word calculation here still wrap around?

If nr_cids is near U32_MAX, ((base & 63) + nr_cids - 1) might overflow the
32-bit u32, resulting in a small last_word value (potentially 0). This would
cause the head word to be cleared again instead of the intended tail word,
leaving tail padding uncleared.

diff --git a/kernel/sched/ext_types.h b/kernel/sched/ext_types.h
--- a/kernel/sched/ext_types.h
+++ b/kernel/sched/ext_types.h
[ ... ]
> +#define __SCX_CMASK_DEFINE(NAME, BASE, NR_CIDS, ALLOC_CIDS)			\
> +	_DEFINE_FLEX(struct scx_cmask, NAME, bits, SCX_CMASK_NR_WORDS(ALLOC_CID=
S), \
> +		     =3D { .base =3D (BASE),					\
> +			 .nr_cids =3D (NR_CIDS),					\
> +			 .alloc_words =3D SCX_CMASK_NR_WORDS(ALLOC_CIDS) })

Does _DEFINE_FLEX with a designated initializer fully zero-initialize the
flexible array members?

In C, initializing specific struct members does not necessarily zero out
the remaining padding or flexible array bytes. The documentation mentions
this macro aliases zero-initialized storage, but without the explicit
memset() that was previously handled by scx_cmask_init(), could the bits
array end up containing stack garbage?

diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/includ=
e/scx/cid.bpf.h
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
[ ... ]
> +static __always_inline void __cmask_init(struct scx_cmask __arena *m, u3=
2 base,
> +					 u32 nr_cids, u32 alloc_cids)
>  {
> -	u32 nr_words =3D CMASK_NR_WORDS(nr_cids), i;
> +	u32 alloc_words, i;
> +
> +	if (unlikely(nr_cids > alloc_cids)) {
> +		scx_bpf_error("__cmask_init: nr_cids=3D%u exceeds alloc_cids=3D%u",
> +			      nr_cids, alloc_cids);
> +		return;
> +	}

Because scx_bpf_error() schedules an asynchronous abort rather than halting
the BPF program synchronously, will the program continue executing with an
uninitialized mask?

The kernel counterpart __scx_cmask_init() safely clamps the value to
alloc_cids instead of returning early. Would clamping the value or zeroing
the memory here prevent subsequent BPF logic from operating on uninitialized
memory?

> +	alloc_words =3D CMASK_NR_WORDS(alloc_cids);
> =20
>  	m->base =3D base;
>  	m->nr_cids =3D nr_cids;
> +	m->alloc_words =3D alloc_words;
> =20
>  	bpf_for(i, 0, CMASK_MAX_WORDS) {
> -		if (i >=3D nr_words)
> +		if (i >=3D alloc_words)
>  			break;
>  		m->bits[i] =3D 0;
>  	}
>  }

If alloc_cids is very large, could alloc_words exceed CMASK_MAX_WORDS?

If so, this initialization loop will stop at CMASK_MAX_WORDS (129), leaving
the remaining words uninitialized. However, m->alloc_words will still record
the larger size. Should there be a validation check against CMASK_MAX_WORDS
to prevent silent truncation in this and other bitmask operations?

[ ... ]
> +static __always_inline void cmask_reframe(struct scx_cmask __arena *m, u=
32 base, u32 nr_cids)
> +{
> +	if (CMASK_NR_WORDS(nr_cids) > m->alloc_words) {
> +		scx_bpf_error("cmask_reframe: nr_cids=3D%u exceeds alloc_words=3D%u",
> +			      nr_cids, m->alloc_words);
> +		return;
> +	}
> +	if (nr_cids) {
> +		u32 last_word =3D ((base & 63) + nr_cids - 1) / 64;

Similar to the kernel helper scx_cmask_reframe(), could this calculation wr=
ap
around 32-bit limits if nr_cids is near U32_MAX, resulting in last_word bei=
ng
calculated incorrectly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519075838.2706=
712-1-tj@kernel.org?part=3D2
