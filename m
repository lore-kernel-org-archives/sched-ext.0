Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492BF1E32D6
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384392; cv=none; b=QeyCEiRPTPLei3GWPZmbtfUFgP7hvp4b8gNY2srYZuvPe0Rob9TUOqqGWNa32hS0pGcpxXfBX0AhUB/WheTv0gEykCoKcinadxO6wMRw+oecMp5Ho3jw5ivsTd8KaYbFuKxn29/AfxwjYolZaFKl+rOaVpiJ1S/3B2pmMpM1miA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384392; c=relaxed/simple;
	bh=XWH/zWij5VRArWoQDRlu94gLMyfh+YRPJy4+ZDc/lR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U7ybNEK6tHX6yrAPT4xeaEXUUgQ9mc21qDs9rrUm1E5DewwUTOfjR0nSkhry3DN0LoS9ItoKBTAferxFvry5gVzEehhecrsG/wWj52to4T+mvbPA55j6Y+VxCeC0jpTIERfaRCGO5Feub1f5QcfMDrJX3M4ywKk2IGIzzICCVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VItz7qNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VItz7qNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C271F000E9;
	Tue,  7 Jul 2026 00:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384388;
	bh=KMfo+0LPvCUtLGZg5LZeIIjKy1xGaxMF8ZzGruzx9yA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VItz7qNr0G6em2Q5E6qIRRU9UMzOjwa6b4wwguAaH2tX0r0lFNVg42vnew3fLXUNt
	 YyTuZAXbzJQQr1vvm5UdpDTBG26jWr6stXH/dVdvpI6cty3vo+6y1jns5v4Kr2Rlnb
	 J1kmddVgplydjgsB7fjyQV8eA9tT6SUiccFhdXaixqRO+0kY5xNTDOJeDQMK/xkSir
	 r5gFq59rYUpXb+/jEOZ46FGGCgLFbRQMiYw2TYjek2Ccnr2Fj62dEm6J+KUn5mUEEW
	 wpZjwiITP7WbWIPvSII2WZKriuDco+ZU7Xo5RPBH2ok/QdEdvp2qhhqyuDEADwJTuL
	 ec3wTxlAIfZmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 20/36] sched_ext: Add coalescing
 sub_caps_updated() notifier for sub-schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-21-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-21-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:33:07 +0000
Message-Id: <20260707003307.C6C271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] NULL pointer dereference in scx_bpf_sub_grant() and scx_bpf_sub_re=
voke() when a sub-scheduler is not a cid-form scheduler.
--

--- Patch [20]: [PATCH v3 sched_ext/for-7.3 20/36] sched_ext: Add coalescin=
g sub_caps_updated() notifier for sub-schedulers ---
commit 65f0b1ee489afa8a5521ffd4929c36ec04dc1300
Author: Tejun Heo <tj@kernel.org>
Subject: sched_ext: Add coalescing sub_caps_updated() notifier for sub-sche=
dulers

This commit wires up ops_cid.sub_caps_updated() to notify sub-schedulers of
cap changes. It introduces a coalesced notification mechanism to handle
high-frequency updates and deferred delivery to prevent deep recursion.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
[ ... ]
> @@ -887,6 +1010,7 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64=
 caps,
>  		SCX_CMASK_DEFINE_SHARD(slice, 0, SCX_CID_SHARD_MAX_CPUS);
>  		struct scx_pshard *pps =3D parent->pshard[si];
>  		struct scx_pshard *cps =3D child->pshard[si];

[Severity: High]
Can this result in a NULL pointer dereference if the sub-scheduler is not a
cid-form scheduler?

If a user loads a root scheduler that is cid-form, and then loads and attac=
hes
a sub-scheduler that is cpu-form (or lacks an arena pool), scx_alloc_pshard=
s()
might leave child->pshard as NULL.

Since sub_cap_preamble() only verifies that the root is cid-form without
checking the child's type, could dereferencing child->pshard[si] cause a cr=
ash
here?

> +		u64 granted_caps =3D 0;
>  		u32 cap_bit;
> =20
>  		scx_cmask_ref_shard(&ref, si, slice);
[ ... ]
> @@ -974,18 +1122,32 @@ __bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id,=
 u64 caps,
>  		pos =3D scx_next_descendant_pre(NULL, child);
>  		while (pos) {
>  			struct scx_pshard *ps =3D pos->pshard[si];

[Severity: High]
Similarly, can this dereference pos->pshard[si] when a descendant is a
cpu-form scheduler?

If pos->pshard is NULL for any descendant in the hierarchy, this loop would
dereference a NULL pointer.

> +			SCX_CMASK_DEFINE_SHARD(changed_cids, slice->base, slice->nr_cids);
> +			SCX_CMASK_DEFINE_SHARD(delta, slice->base, slice->nr_cids);
>  			u64 revoked_caps =3D 0;
>  			u32 cap_bit;
> =20
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D20
