Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5202EEE94
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217258; cv=none; b=YoqPSV7hcK7SjJCl30TRRL4Og7Ay+ooGq1BL9/etBiOn5r+woLRig73Ppx7fiADp4Sr5fDCSzFR9dFKL+XWkrU2VkqLE0y00DoIdg19QbaVThRVf9eYrmXF3k2LK0Rd82ciIvdIFIdaZaNNT3wRRz0lbONKoR1UrWxNtfSJdUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217258; c=relaxed/simple;
	bh=htrrnqS80SLY/yzlwK8BULdM1MtSKPFcYfLpVSGSjFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I8NDRPmE/RDPQIXP6/WNgwDz9cMRRg0UctObMHwiiogeL7Xxe0ROwmHmPYix70RjNjI0Xif0KjvdU28+8wte9cDd1mtfadHLN+Df/NaEtCLTOSKfNpQJGVD3bSJ+WBu6K0Xx+v6sU8BoE+B+/tF3weT2uj2ATVygoerrT/uUEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWVz0TbI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWVz0TbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA841F000E9;
	Thu, 16 Jul 2026 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784217252;
	bh=HItd6hanhhG9ns17yYLYdQi+SCxPbhirzX68EiV71tI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HWVz0TbISjXfbHWvisWtIm5hnBq/wZ5aeq7B8gNb65YKIMxWAnkmGW6yJsD7cS65d
	 38vYOeSSTf8qPFMF8cCV+adBvozs1IJlEtau+y3zh25uYcvfmGvIbO1oFvPArovzSu
	 1hn6oZrGUj3mS09+ybLgcPODi+K00D1FVOC45JUZAA5efp+F00pD6zgvTZyAX+Yurt
	 c3B0LfPm2aAK1ffx9V9PFDPDcMUmugWteTd+t0XOzvz1bbia2tfpUNIMZZjzxp/NbZ
	 CSElmUXeVQPdTghXuvdjQv7Ezq+9zS8TDXmesWuS71pbbCDFEvAnvuGNMAzLXLztUG
	 zXPvQIZUGeH/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] sched_ext: scx_qmap: Add proxy execution support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260716132229.61603-11-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-11-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:54:12 +0000
Message-Id: <20260716155412.7DA841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Redundant !(enq_flags & SCX_ENQ_REENQ) checks left behind after mov=
ing the early return handler.
--

--- Patch [10]: [PATCH 10/11] sched_ext: scx_qmap: Add proxy execution supp=
ort ---
commit fb0f1d9957f7124711aadbe323f38da6fa6e3857
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: scx_qmap: Add proxy execution support

This commit adds a -B option to scx_qmap to opt into queueing mutex-blocked
tasks for proxy execution. It dispatches blocked donors directly to the
local DSQ of their current cid with a fresh slice and SCX_ENQ_PREEMPT.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 09aee49120c28..ab14325a07b6d 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -451,6 +451,40 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct=
 *p, u64 enq_flags)
>  	 */
>  	taskc->core_sched_seq =3D qa.core_sched_tail_seqs[idx]++;
> =20
> +	/*
> +	 * If the task was re-enqueued due to the CPU being preempted by a
> +	 * higher priority scheduling class, just re-enqueue the task directly
> +	 * on the global DSQ. As we want another CPU to pick it up, find and
> +	 * kick an idle cid.
> +	 */
> +	if (enq_flags & SCX_ENQ_REENQ) {
> +		taskc->force_local =3D false;
> +		scx_bpf_dsq_insert(p, SHARED_DSQ, 0, enq_flags);
> +		cid =3D cmask_next_and2_set_wrap(&taskc->cpus_allowed,
> +					       &qa.idle_cids.mask,
> +					       &qa.self_cids.mask, 0);
> +		if (cid < scx_bpf_nr_cids())
> +			scx_bpf_kick_cid(cid, SCX_KICK_IDLE);
> +		return;
> +	}

[Severity: Low]
Since the early return block for SCX_ENQ_REENQ was moved higher up in
qmap_enqueue(), are the later checks for !(enq_flags & SCX_ENQ_REENQ)
now redundant?

For example, further down in the same function:

        if (qa.nr_sub_scheds && !(enq_flags & SCX_ENQ_REENQ) &&
            !cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {

It seems SCX_ENQ_REENQ will never be set when reaching this code now, making
the condition safely removable.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132229.6160=
3-1-arighi@nvidia.com?part=3D10
