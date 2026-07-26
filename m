Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87C2F8E9F
	for <sched-ext@lists.linux.dev>; Sun, 26 Jul 2026 22:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785103218; cv=none; b=Rt1lVIEWvIPuPJ8B0eoyltcnRWl9qR6YFsmTxa2sbyGi4W/klzmJSCCcZ00Uqq9jI7scz/4tZtCRr0dmKL53fWub5vgHWEpGwYJuwmt143TidFi9BAvWlgcUG35OZzb6vD1LwWt7NpDl6d+IVDhC9cBKEOo8cblxs8Nf4A6V8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785103218; c=relaxed/simple;
	bh=cUQlLOEdOh8DQIpQumxA2HZ6f467n8SewF7S7/kh4RU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uJJIr/n2F5h7kne3wblmkD9saj/riiSlibpVAhn0W3F0Zfb/KMrk2GrxdK60yp9Mu+e6D3Fhj40HwkyQYfVnbVD20adLifAY1HXFouOAoA8VmoCOYpBsbgdqBCMBw57AY+uPNOWqhgEU/1e7/PWd6WxKjzZoFpYIqTDft2EQRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVILJcvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVILJcvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D958B1F000E9;
	Sun, 26 Jul 2026 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785103217;
	bh=h/Cwl7JdH8iN89wdR/Cx3nC4znq3gnCqid3cGY2lfjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XVILJcvjq9Rq2Ahh+IibN14alnuOxQPO4LrOvGFckNkWiphs1Him2AiX3cCGktKcy
	 WsUUIw0f1Zk8PEpoBuPvlP5wa6ni0YjhOM9mYWtEHLB+Jyh76qHpuW4u0VMZxD3nHX
	 /HngieFQ1AfvIWgvtGAyTFDT0Amesew1gwvanxdcACiQ2Vmghncfv9YXMXr3jU3fNs
	 6t7LpnIK/oCAGBaszJdzshgd/yhBOM5zaSmJ5371VFa13/wbFUUfyJzs1YRqLC9Zss
	 AuLBbSwKbCn2aH1mqG1Lxh0DvDvIH0DfAHKQTNXH0f/xVrJBnze/XXXt29ZEQxJ0zN
	 P/h5VdSdGt+jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3] tools/sched_ext/include: Regenerate
 enum_defs.autogen.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <048d8cc6b8e9be48ec0e6e431afc75cd@kernel.org>
References: <6649066b805d5660b598f3155c30daac@kernel.org>
 <amZsEbZJdDgjstPF@gpd4> <048d8cc6b8e9be48ec0e6e431afc75cd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 22:00:16 +0000
Message-Id: <20260726220016.D958B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch updates `enum_defs.autogen.h` to replace `HAVE_SCX_REE=
NQ_LOCAL_MAX_REPEAT` with `HAVE_SCX_REENQ_MAX_REPEAT`, but the correspondin=
g enum rename is missing from the kernel C source code (`kernel/sched/ext/t=
ypes.h`).
--

--- Patch [1]: [PATCH sched_ext/for-7.3] tools/sched_ext/include: Regenerat=
e enum_defs.autogen.h ---
commit 87802be8777491b94ab77d3e645df530fc777b45
Author: Tejun Heo <tj@kernel.org>

tools/sched_ext/include: Regenerate enum_defs.autogen.h
   =20
Regenerate enum_defs.autogen.h from the current vmlinux.h to pick up the SCX
enum changes accumulated since the last regeneration.

Link: https://lore.kernel.org/all/amZsEbZJdDgjstPF@gpd4/

> Regenerate enum_defs.autogen.h from the current vmlinux.h to pick up the =
SCX
> enum changes accumulated since the last regeneration, including the
> SCX_REENQ_LOCAL_MAX_REPEAT to SCX_REENQ_MAX_REPEAT rename.

[Severity: Medium]
Is the SCX_REENQ_LOCAL_MAX_REPEAT to SCX_REENQ_MAX_REPEAT rename actually
present in this tree?

Looking at kernel/sched/ext/types.h, the old enum name is still present:

kernel/sched/ext/types.h:
	SCX_BYPASS_LB_BATCH		=3D 256,
=09
	SCX_REENQ_LOCAL_MAX_REPEAT	=3D 256,
=09
	SCX_SUB_MAX_DEPTH		=3D 4,

> diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sche=
d_ext/include/scx/enum_defs.autogen.h
> index da4b459820fdd..0379eff117c9e 100644
> --- a/tools/sched_ext/include/scx/enum_defs.autogen.h
> +++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
[ ... ]
> @@ -20,7 +37,7 @@
>  #define HAVE_SCX_BYPASS_LB_DONOR_PCT
>  #define HAVE_SCX_BYPASS_LB_MIN_DELTA_DIV
>  #define HAVE_SCX_BYPASS_LB_BATCH
> -#define HAVE_SCX_REENQ_LOCAL_MAX_REPEAT
> +#define HAVE_SCX_REENQ_MAX_REPEAT

[Severity: Medium]
Will this cause build failures for BPF schedulers that check for
HAVE_SCX_REENQ_MAX_REPEAT?

They might get an undeclared identifier if the actual kernel source still
exports SCX_REENQ_LOCAL_MAX_REPEAT in vmlinux.h instead of the new name.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/048d8cc6b8e9be48ec0=
e6e431afc75cd@kernel.org?part=3D1
