Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF16332EBB
	for <sched-ext@lists.linux.dev>; Sat,  1 Aug 2026 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575205; cv=none; b=lRxZbUxhRIkmfWc3sq1VNmbNVxjtoT7YOUsqg7b6x3zq0k9dA+nFrmT02wLG5U5Tlm9f/zUJ9zLEm0QSAe+kDQUZkTXVkpWMtG2lz+vyCvX+6VogZF+m+iS381Wv+PDeANf92drjmwuyaKP3P9fKkJnD6qz7nnN8YFyaAUUZLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575205; c=relaxed/simple;
	bh=Xc63XVvvc5rmmCjv12DzFQfwXYELRN0AMK3kUJgemlI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YTJ54U84Gg1X9Npe/xvhtoGHjvFtqYBU8mnwgPxlv7QKDvUtOpSQ/aKjeiBDYEhxTGgGvJ4kdHS9BPwJJ9A0/LICHcAAjFFtdI4ByK3dNHAwleLGHiG/uMMLYdVl03ra2L2Fzm6+Hg99nXrURAqfFfv/mkE72yTfzabXoqzRUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6zTNgrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6zTNgrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EB11F00AC4;
	Sat,  1 Aug 2026 09:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785575204;
	bh=4d+9h70Ph0wvMWXsolVe8XPlwJVSqLYkCZSnESSFsDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O6zTNgrfyEHeJ19jcdn2HUx4Q8wYTgtZeXllEzJBwa0YIiHt2J378W8lyVXS27CXl
	 FUedSR2BUYLGsKceZH0wK4pRMi0uhecKAsqYMf2tQHRJBcfKW0L50AWj4H7tCEVszl
	 AALFflIcpCF2e6aSR5U1d0L/0K3fTutLy7Uewlq7k6x9vGU4R9/iIppJyZUnqa7WGa
	 QfLjq3qNMMhEiRGcWIUlASYxpd4tn7In6f1I/TvhQiRImWcnRClIP9/Tmy1voto7fb
	 3IGljwDyAxaCyLwwyZViib9HQnnxCFdtw0w/KwNP2DfMcpTrAE6BCo8h4wswtp9zgv
	 Vh83mp07+vVmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] sched_ext: scx_qmap - Idle-check pinned tasks
 before direct dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260801085150.2697653-12-tj@kernel.org>
References: <20260801085150.2697653-1-tj@kernel.org>
 <20260801085150.2697653-12-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 09:06:43 +0000
Message-Id: <20260801090644.47EB11F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The BPF rodata variable `always_enq_immed` was made unused by the p=
atch and remains as dead code.
--

--- Patch [11]: [PATCH 11/12] sched_ext: scx_qmap - Idle-check pinned tasks=
 before direct dispatch ---
commit 8281293388fde26e27e2d80b5bd65cbae1161f07
Author: Tejun Heo <tj@kernel.org>

sched_ext: scx_qmap - Idle-check pinned tasks before direct dispatch

This commit updates pick_direct_dispatch_cid() to perform idle checks on
pinned tasks before direct dispatching. Previously, pinned tasks were sent
straight to their only CPU without an idle check, which could lead to bounce
loops if the CPU was busy.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 8822ed11c0d8b..9a0321e84e88f 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -230,9 +230,6 @@ static s32 pick_direct_dispatch_cid(struct task_struc=
t *p, s32 prev_cid,
>  	s32 cid;
>  	u32 i;
> =20
> -	if (!always_enq_immed && p->nr_cpus_allowed =3D=3D 1)
> -		return prev_cid;
> -

[Severity: Low]
With the removal of this check, the BPF rodata variable always_enq_immed is
no longer read anywhere in the BPF program.

Should the declaration and its userspace assignment also be removed to clean
up the remaining dead code?

tools/sched_ext/scx_qmap.bpf.c:
    const volatile bool always_enq_immed;

tools/sched_ext/scx_qmap.c:main()
    ...
    case 'I':
        skel->rodata->always_enq_immed =3D true;
    ...

>  	if (cmask_test(prev_cid, &qa.self_cids.mask) &&
>  	    cmask_test_and_clear(prev_cid, &qa.idle_cids.mask))
>  		return prev_cid;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801085150.2697=
653-1-tj@kernel.org?part=3D11
