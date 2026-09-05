Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A127AC45
	for <sched-ext@lists.linux.dev>; Sat,  5 Sep 2026 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625345; cv=none; b=BUEeAmGXKrcgR5hAkNGGeA1yko+pEe9ZyXJPl63VC2iFLAldav9BADHvnY289+LdB3AvdC0Q/kZuFNwhqEXxqWedfIxn/vdIymrurkFdIcTLfo23QgVNYMGlnNe/76OixI6TdRa9LQTxIrleiiGfW2xHO8Xiaird/8GpfBgpUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625345; c=relaxed/simple;
	bh=YYDgakZIY9YHhU60O4k+HU3hOK6YaEGNdxVTKBY+2XA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oGJyANJCdL66XIQLFVlxyQCnhqQ7U1wFvND2xM+KYE975acyaQbhyw7KlgoWv/yDjiyqTrQQ2mu2A3z6yvAr5oeDM+9moBpixsA6/CTvJTSqJ7of1NIq306BFkCsloz+Avi333wqbf/znWwf+SvlwDUP1H6ETjhqk65zE/g2aX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1Zpql68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1Zpql68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF521F00A3A;
	Sat,  5 Sep 2026 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788625343;
	bh=9zfJ/EZn5LCeXQWBIHjTBUqv5Y5D+LcBad1+fwXteww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F1Zpql685X2Zr9SJlo5eDleRknnrRzLhaYyZ6jvDF70kqgD8vyZACCzi1l+nK1K4G
	 clgWBfq3XnA0JYtiGZ7m18ofE9Q1LnpTRrTV4esrOtLYhQ/RdyYVo2y65y0yHdF41u
	 UV6VH+dxGO9XUySp05kS2cJtXDQZybDBDdcd8STwYeRspKxj71MHk2E/rbZoDnFphW
	 wyIRDu68kE2z3OPZ9KwU8MajmOaJNci01cUSy8MKrJlZodzNy2ZRgxAIC7FS1M7m54
	 e6qCk5J2NPDjW/WOQRMuzdZjdSYNFQyDKWpb2jnFE0AXk0v84Od/c5OTrWzlWdG8pQ
	 VHMOkFXR5qLVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes 4/4] sched_ext: scx_qmap: Place
 only on cids whose caps are in effect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260905160958.1565156-5-tj@kernel.org>
References: <20260905160958.1565156-1-tj@kernel.org>
 <20260905160958.1565156-5-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 16:22:22 +0000
Message-Id: <20260905162223.6EF521F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Lockless readers observe transiently zeroed `qa.self_cids.mask`,=
 triggering spurious task rescues.
--

commit 64014633e68988338122fb067fb0377be3f61541
Author: Tejun Heo <tj@kernel.org>

sched_ext: scx_qmap: Place only on cids whose caps are in effect

This commit modifies scx_qmap to use a new usable_cids mask for task
placement, resolving issues where tasks were placed on CPUs whose
capabilities weren't yet in effect. It preserves the self_cids mask to
differentiate between stranded tasks and tasks just waiting for
capabilities to take effect.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index b0684747f06ca..94cd55dcd9ad6 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c

[ ... ]

> @@ -646,18 +649,23 @@ static bool scan_shared_dsq(bool from_timer)
>  		if (!(taskc =3D lookup_task_ctx(p)))
>  			return false;
> =20
> -		/* only run highpri tasks on cids this node holds, not delegated ones =
*/
> +		/* only run highpri tasks on cids this node can use right now */
>  		if (cmask_test(this_cid, &taskc->cpus_allowed) &&
> -		    cmask_test(this_cid, &qa.self_cids.mask))
> +		    cmask_test(this_cid, &qa.usable_cids.mask))
>  			cid =3D this_cid;
>  		else
>  			cid =3D cmask_next_and_set_wrap(&taskc->cpus_allowed,
> -						      &qa.self_cids.mask,
> +						      &qa.usable_cids.mask,
>  						      this_cid + 1);
>  		if (cid >=3D nr_cids) {
> -			/* stranded after the cull - rescue it from here */
> -			s32 c =3D cmask_next_set_wrap(&taskc->cpus_allowed, 0);
> +			s32 c;
> +
> +			/* self cids lack caps in effect yet, leave it queued */
> +			if (cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask))
> +				continue;

[Severity: Medium]
This is a pre-existing issue, but can lockless readers observe a transiently
zeroed qa.self_cids.mask here and incorrectly fall through to the rescue bl=
ock?

Looking at apply_partition(), qa.self_cids.mask is rebuilt non-atomically:

tools/sched_ext/scx_qmap.bpf.c:apply_partition() {
    ...
    /* turn the owner map into the rr pool, per-child excl, and self sets */
    cmask_init(&qa.rr_cids.mask, 0, nr_cids);
    cmask_init(&qa.self_cids.mask, 0, nr_cids);
    ...
    bpf_for(cid, 0, nr_cids) {
        s32 o =3D qa.part.cid_owner[cid];
        ...
        else if (o =3D=3D CID_SELF)
            cmask_set(cid, &qa.self_cids.mask);
    }
    ...
}

If scan_shared_dsq() reads qa.self_cids.mask while it is being zeroed and
rebuilt, cmask_intersects() could spuriously return false. This would cause
valid tasks to be mistakenly marked as stranded and diverted to the fallback
rescue scheduler.

> =20
> +			/* stranded after the cull - rescue it from here */
> +			c =3D cmask_next_set_wrap(&taskc->cpus_allowed, 0);
>  			if (c >=3D 0 && c < nr_cids) {
>  				__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
>  				scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | c,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905160958.1565=
156-1-tj@kernel.org?part=3D4
