Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFA35A384
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201237; cv=none; b=HZJqz9Ut9oNutrmh/SO7ciOyRzyPTEYSVyXbeO5DofU6aSkP6D6TC/cACJz+XrscAkZCmZ1/c576ewisHL7r6+249L1xM8NaICT6Buc9Mez5M3WjNl/r7NuVf0QglLcA17McFJDIsRk70YcmkO2jev2cyQS9M0bRViZaLGukIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201237; c=relaxed/simple;
	bh=AeDx9FeM4wp0T8GvY3fx+0ENVVTWldmDOe3dXw9Ra60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=onjkprhRhf8b/sy37r86fl8+3Dcf9B7NESd8LqVhOrr6hvBszvtz5QVbrKgMupEuwsuSgl/3xBE0j9OvSO9uEMM5B9GPDzcwGdMu9wgxHKSsgPofnXfyFBJlihaUoeD4soKow9tSABobwW5PcBdLSysijJJOU2qIoR2hUht4su0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwZoYHTi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwZoYHTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E92E1F000E9;
	Mon, 31 Aug 2026 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201236;
	bh=SYZhQTdCOfVZzbkihxdQe24aCQ5CvCcrWIvsbWSmGNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RwZoYHTiACR1tRY74lNgYqUS3JHcLqtJbcu51IF/O+FSUdI7DrIP7cueK6kAVqI5i
	 axE7I5wzZDOqMhxn6oYKO6BdcQwmDx3qtHAEM8MWK9vLRXzeOdMJG9mkNI6PToerw+
	 uSo6W2BPtsS4oL/lDrIix15V82eO0WJsfRpTq72rz57jF5w5B8y/PPbfyHqyQOaX4s
	 /U1xToza9VOJ05AZULqHqaqCu4LlPcdl1TfxLDnScJr1TK6a5ZwoS0vLGiT9/DQB+5
	 Fc3SLqfBubkCQTv6r3GOrFLdOuLHOC12lx3AXaka920jwm0DlVZcEAt3DzQG46SKJi
	 kjcIdj3htbLbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/18] sched_ext: scx_qmap: Add proxy execution support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260831134338.1531664-18-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-18-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:33:56 +0000
Message-Id: <20260831183356.6E92E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing bounds check on `cid` returned from `cmask_next_and_set_wr=
ap()` due to a TOCTOU race with `qa.self_cids.mask` modifications.
--

commit 564b1258b3dc07e22341c55b61be164307b61870
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: scx_qmap: Add proxy execution support

Add a -X option to opt scx_qmap into queueing mutex-blocked tasks for proxy
execution. When scx_qmap receives a blocked donor, it selects an eligible c=
id
and dispatches the donor to that local DSQ.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 5bb8b90a275a3..21f8a9be9650c 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
[ ... ]
> @@ -460,6 +464,53 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct=
 *p, u64 enq_flags)
[ ... ]
> +	/*
> +	 * Insert a blocked mutex donor at the head of an eligible local DSQ wi=
th
> +	 * a fresh slice and %SCX_ENQ_PREEMPT, requesting an immediate reschedu=
le.
> +	 * The test above guarantees that cpus_allowed intersects self_cids, but
> +	 * the donor's current cid may have been delegated to a child. Search t=
he
> +	 * intersection starting at the current cid, preserving it when qmap st=
ill
> +	 * holds it and wrapping to another eligible self cid otherwise.
> +	 *
> +	 * A self cid may be held exclusively with SCX_CAP_ENQ or time-shared w=
ith
> +	 * only SCX_CAP_ENQ_IMMED. Add needs_immed() so either kind can accept =
the
> +	 * local insertion instead of rejecting and reenqueuing the donor for a
> +	 * capability miss. Once selected, the core proxy-exec path can run the
> +	 * mutex owner using the donor's scheduling context.
> +	 *
> +	 * This policy is intentionally unfair and can strongly prioritize tasks
> +	 * using contended mutexes; scx_qmap is a demonstration scheduler and
> +	 * this behavior makes proxy-exec support easy to observe.
> +	 */
> +	if (enq_flags & SCX_ENQ_BLOCKED) {
> +		cid =3D cmask_next_and_set_wrap(&taskc->cpus_allowed,
> +					      &qa.self_cids.mask,
> +					      scx_bpf_task_cid(p));
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cid, slice_ns,
> +				   enq_flags | needs_immed(cid) | SCX_ENQ_PREEMPT);
> +		return;
> +	}

[Severity: High]
Does this code risk an out-of-bounds access if the intersection becomes
empty?

In qmap_enqueue(), there is an earlier check for
cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask).

However, if apply_partition() modifies and zeroes qa.self_cids.mask
concurrently on another CPU after the check, the intersection might become
empty before cmask_next_and_set_wrap() executes.

If this happens, cmask_next_and_set_wrap() returns the out-of-bounds
sentinel scx_bpf_nr_cids().

This out-of-bounds cid is then used without a bounds check in:

    scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cid, ...)

which can cause scx_cpu_valid() to fail and forcefully eject the BPF
scheduler. It could also lead to an out-of-bounds read in needs_immed(cid).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831134338.1531=
664-1-arighi@nvidia.com?part=3D17
