Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BD379EEF
	for <sched-ext@lists.linux.dev>; Tue, 14 Jul 2026 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072152; cv=none; b=XyiPURYA7+nFvfZlh+elcVHJLBdW/lnQ8iWw2n3Laq8juAuc70ucQa5JVPD4zhZb8JpufN/qnE3KEa5+PH1rHBydQY0+Ez/MMk52ciSLXVFvRFDkFJJ8fAvXuo/m2xS77Zvm4tqra1KE9I/X8vL4ySDosCvZC2rUqL006dnmQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072152; c=relaxed/simple;
	bh=v7urvm9dkWzmHqLjhYGdcp60uz3VyAMlMq1vQbjS0Ns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JJO7Sd6DPuKbaU9IBUT1lscN7kLkBR/rNnTHJ+OTV3/cfSaY6Q/FdcQ6DmI9t3GcdkfloaXX4paWXYBl/YJHK2gR7OALK4EW0vTIjjVOXzLAVrbiaAOaaXtwTu5qvQJu/tA8TU7x1pkO9BEhLxLE5Oho/TfE9y8P4YGh1EADXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loillRIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loillRIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF1D1F000E9;
	Tue, 14 Jul 2026 23:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072150;
	bh=gO/aJwEczJbHyOEwjkMBBW1zUZkXb00PVX8UxiUg0pg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=loillRIe33OjKfHzfwxNkg3BHMfpvTPoxTTttkWbDXHqdnGrdnmdvUh96mdK7X4rW
	 Yt4GdO7lEnpQGfrjy0x8PCxfDuq4myrSOr1RZWuUpbgxe4GUox7ONWFI1SiKpL6hsC
	 7y/SS3B7rWiFlaGa7idhaWqzaNkhTjrF4oEWzLjUlGKt0JY4EwLQ0II2OUtzJ5HUHn
	 lMtCJcMaiSKgctqk3yzONl9H0g1+OClkR0w4xJcAHdUYiCFTTMdme8v2pW9krs8+pw
	 uTSS3XAI3yvS2OIK86OU22T6y1tAGtpkcULVlDpgTaRuQFcb0D0gndSN2PVMRRNvdv
	 /LvVOX0QltT6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] sched_ext: Move scx_dispatch_sched() from sub.h to
 internal.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260714230917.84158-3-tj@kernel.org>
References: <20260714230917.84158-1-tj@kernel.org>
 <20260714230917.84158-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:35:49 +0000
Message-Id: <20260714233549.EDF1D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Moving `scx_dispatch_sched()` to `internal.h` and including `cid.h`=
 at the end creates a circular header dependency. `cid.h` includes `interna=
l.h` at the top. When `cid.h` is included first by a C file, it triggers th=
e inclusion of `internal.h`. The `#include "cid.h"` at the end of `internal=
.h` is skipped by the include guard. Consequently, `scx_dispatch_sched()` i=
s parsed before the rest of `cid.h` has been processed, resulting in an 'im=
plicit declaration of function' compiler error for `scx_cpu_arg()`. This vi=
olates the kernel coding standard requiring headers to be self-contained an=
d independently compilable.
--

--- Patch [2]: [PATCH 2/4] sched_ext: Move scx_dispatch_sched() from sub.h =
to internal.h ---
commit 6f0aa181637de48d619823a3e1db41e281070615
Author: Tejun Heo <tj@kernel.org>

sched_ext: Move scx_dispatch_sched() from sub.h to internal.h

This commit moves scx_dispatch_sched() from sub.h to internal.h,
and includes cid.h at the end of internal.h to support scx_cpu_arg().

> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index d7a1d6a14ebf3..88b2a9b5d3ab2 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -2289,4 +2289,115 @@ static inline struct scx_sched *scx_prog_sched(co=
nst struct bpf_prog_aux *aux)
>  static inline struct scx_sched *scx_parent(struct scx_sched *sch) { retu=
rn NULL; }
>  #endif	/* CONFIG_EXT_SUB_SCHED */
> =20
> +#include "cid.h"

[Severity: Low]
Does this create a circular header dependency between internal.h and cid.h?

If a C file includes cid.h before internal.h, cid.h includes internal.h
at the top. When processing internal.h, the #include "cid.h" here is
skipped by the include guard.

This causes scx_dispatch_sched() to be parsed before the rest of cid.h is
processed, which would result in an implicit declaration error for
scx_cpu_arg() further down in this function.

Could this cause build failures if headers are included in a different order
in the future?

> +
> +/*
> + * One user of this function is scx_bpf_dispatch() which can be called
> + * recursively as sub-sched dispatches nest. Always inline to reduce sta=
ck usage
> + * from the call frame.
> + */
> +static __always_inline bool
> +scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714230917.8415=
8-1-tj@kernel.org?part=3D2
