Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309352E6116
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151329; cv=none; b=grlkyIcv09VtKyW0HzUNJ2LdRiL5zCkhkF1Pvrn/veYvML+CNJDmfXbdupzdMH8PiqEOuPdnjmTtzpVjSMIcRm/XrwVFRLdszKoDaQwNXqLqX8BkbflzL/vRqSPn36hEtINLKA3pnPDbQoz2zsJ9P2ov/O4ke5N0iHslnEra7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151329; c=relaxed/simple;
	bh=nZBB7qLFM46Jq2bFzhWFVy3M67b+9UyF4ILsF7c72Ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q74WH4K0/mpv6jOUwvK+U2r4kUzTok2DPLkGeWmjt08Q/euSMlJYZK4PhcpJn9ZoZuaYuPx7p6yuRbtiut7qbvXeDR4OSXBT1QTKQXMKwxoMu1LQtzsTN2H+84xxtG+NFA/Z4o3X6f/Nuhm4f/qAiLWPBe8X2YcQpnz8Rf5MDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeTeyysP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeTeyysP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DB31F000E9;
	Wed, 15 Jul 2026 21:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151327;
	bh=KlxAHLBy/+CQ41ro+OT0VAr8KDuvhAK1PsteXZUnjKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GeTeyysPKthCjCH1tmnOr52fiM0ng+8SFgd1A+GaH9zktJXwHDufxTYytOjRtXl2+
	 /Q8yAYX5F+PwlEO3WS/WkVSVn2tShXk1YySFWJXohC08pz11uKCP13Inxlt9YuQtYW
	 VJUAJpBUyakFnTuTVVRXAInD0/gMn6xJJHJ6Yhmh0tQr7HYFOERs9Y5rNrPEYUYedO
	 OZDJ85I/UH3DD9H4Ej67bdP3PMHuo3TGfUM2raeUXY5zG3y20lg8NJvH4wMnEA34/E
	 bSozG6I57/7roc8376t0kddPrtTzqqnUzmnvsH4LoNwqBan3Q5X55s/y/st2A2qHAE
	 /MfT3JrfsxiuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] sched_ext: scx_qmap: Add proxy execution support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260715205622.276220-11-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
 <20260715205622.276220-11-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:35:27 +0000
Message-Id: <20260715213527.93DB31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Infinite re-enqueue loop (hard lockup) for blocked tasks when CPU =
capability is revoked.
--

--- Patch [10]: [PATCH 10/11] sched_ext: scx_qmap: Add proxy execution supp=
ort ---
commit 330898ee3998dc8e218d6fe5b7b813cf89e4a38d
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: scx_qmap: Add proxy execution support
   =20
Add a -B option to opt scx_qmap into queueing mutex-blocked tasks for
proxy execution. Blocked donors are dispatched directly to the local DSQ=20
of their current cid with a fresh slice and SCX_ENQ_PREEMPT.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 09aee49120c28..dd308d1c89e2e 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c

[ ... ]

> @@ -451,6 +451,22 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct=
 *p, u64 enq_flags)
>  	 */
>  	taskc->core_sched_seq =3D qa.core_sched_tail_seqs[idx]++;
> =20
> +	/*
> +	 * Insert a blocked mutex donor at the head of its current cid's local
> +	 * DSQ with a fresh slice and %SCX_ENQ_PREEMPT, requesting an immediate
> +	 * reschedule. Once selected, the core proxy-exec path can immediately
> +	 * run the mutex owner using the donor's scheduling context.
> +	 *
> +	 * This policy is intentionally unfair and can strongly prioritize tasks
> +	 * using contended mutexes; scx_qmap is a demonstration scheduler and
> +	 * this behavior makes proxy-exec support easy to observe.
> +	 */
> +	if (enq_flags & SCX_ENQ_BLOCKED) {
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cid(p),
> +				   slice_ns, enq_flags | SCX_ENQ_PREEMPT);
> +		return;
> +	}

[Severity: High]
Can this cause a hard lockup if a sub-scheduler dynamically loses CPU
capability?

When a sub-scheduler is used (via the -c option) and loses capability on the
task's current CPU, the kernel routes the task to the reject DSQ and
re-enqueues it with the SCX_ENQ_REENQ flag.

Since this check unconditionally handles SCX_ENQ_BLOCKED and returns early,
won't it bypass the SCX_ENQ_REENQ fallback logic later in qmap_enqueue
that normally routes rejected tasks to SHARED_DSQ?

If the sub-scheduler still lacks capability, the kernel will reject it
again. Because balance_scx() processes the reject DSQ synchronously until
empty, won't this create an infinite re-enqueue loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715205622.2762=
20-1-arighi@nvidia.com?part=3D10
