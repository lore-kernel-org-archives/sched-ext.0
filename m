Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3637BE7C
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303589; cv=none; b=c4njyLE+6XVVoJ24UwdAAHCBIHhVzAHoVzmwx4P1em0brGhlCY6BVADWrXZFbhjri+5AQlwEn4ZHff2NgU64OCH89vdqcb8c7M68dzsGU23DT5Thfpyz/0z27QO6WcVfnx7bN5hXEee6T3dhRTN/1+NYr47m48hEKflo2lNvhMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303589; c=relaxed/simple;
	bh=Je4bPPJkAh2AhBT3f1dhcv/7kplt5qOreiBj1V9T81o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nDkH2cLD1YTDtr6Dp43SmfgNXpavyvYxAnyW2K/mT1qE8jB+sNMVvF8ouULqgElE/J2Fzc67qfSh2xbRGrEV/X76ATMlbITKTyJQ6hEiMSRA3e35Gr2W8VjzLONVDU9FijCmlHZl1PCpSmhqfdoI7Ofe81vBh742FRm9XRDJWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxKCjFL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxKCjFL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7D41F000E9;
	Mon,  6 Jul 2026 02:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303587;
	bh=vpqUyPjdv1ZJYt42a5C6FGzB0A71mHCgB5Km1vD8b/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CxKCjFL9yE1rwl1PInKBpvWVEWCc8e+/bQ+meqQfCJNoLyU+Rhj5YGvYflKkkMZ78
	 DoErlusUjY18gXPCQ3wQ+8gaLL5HM3d0eF3FVSgh6bnS5O5TCimnvn7+p5CgngVHhY
	 wdw1Ka5540f2yVselG8C5wy36SMtEMgkmv/1w2H/hu83kxWGJ0fb5MQy8wPaoC0If0
	 4QKfY4IP3MQKjQRvNUyzPumf2fW9E7C7Uqqh9eWdEoLsO1Cqdj+9iuC3N+D4ZOyDes
	 x1tddmV5Gn/AnaleHifgeM65QYbV/lgpmNH/9iGHluta72n/UEtFVlSSDgsOndgeWa
	 dNrFHkYc5Abfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 20/36] sched_ext: Add coalescing
 sub_caps_updated() notifier for sub-schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-21-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-21-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:06:24 +0000
Message-Id: <20260706020627.2A7D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing private stack request for recursive BPF callback `sub_caps=
_updated` leads to kernel stack exhaustion and local DoS.

Pre-existing issues:
- [High] Missing validation for BPF arena presence in sub-scheduler capabil=
ities kfuncs leading to NULL pointer dereference and page faults.
--

commit cc12df54223214d4986ce5a0d8bfbff818b17c70
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add coalescing sub_caps_updated() notifier for sub-schedulers

Wire up ops_cid.sub_caps_updated() to notify sub-scheds of cap changes.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index b00acbc3e16ae..1fa656e2bbb43 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -7501,6 +7503,7 @@ static struct sched_ext_ops_cid __bpf_ops_sched_ext=
_ops_cid =3D {
>  #endif
>  	.sub_attach		=3D sched_ext_ops__sub_attach,
>  	.sub_detach		=3D sched_ext_ops__sub_detach,
> +	.sub_caps_updated	=3D sched_ext_ops__sub_caps_updated,

[Severity: High]
Does this new callback need to request a private stack?

The commit message notes that a child receiving this notification can call
grant/revoke on its own children, which cascades recursively down its
subtree.

Because sub_caps_updated was not added to the switch statement in
kernel/sched/ext/ext.c:bpf_scx_check_member() to enable
prog->aux->priv_stack_requested =3D true, this recursive cycle executes on
the standard kernel stack.

With scx_bpf_sub_grant() allocating multiple SCX_CMASK_DEFINE_SHARD
structures (consuming roughly 320+ bytes per frame) plus the BPF program
stack overhead, can this unbounded synchronous C-stack recursion exhaust
the kernel stack for moderately deep cgroup hierarchies?

>  	.cid_online		=3D sched_ext_ops__cpu_online,
>  	.cid_offline		=3D sched_ext_ops__cpu_offline,

[ ... ]

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 36803b6df6318..5bd3b8a1da6b8 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -879,6 +990,7 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 =
caps,
>  		SCX_CMASK_DEFINE_SHARD(slice, 0, SCX_CID_SHARD_MAX_CPUS);
>  		struct scx_pshard *pps =3D parent->pshard[si];
>  		struct scx_pshard *cps =3D child->pshard[si];
> +		u64 granted_caps =3D 0;
>  		u32 cap_bit;
> =20
>  		scx_cmask_ref_shard(&ref, si, slice);

[Severity: High]
This is a pre-existing issue, but can these pshard pointers be NULL if
the BPF program does not define an arena?

In kernel/sched/ext/sub.c:scx_alloc_pshards(), if sch->arena_pool is NULL,
the pshard arrays are never allocated. Later, when scx_bpf_sub_grant() is
called, sub_cap_preamble() only verifies scx_is_cid_type(), allowing
execution to proceed even without an arena.

This leads to two potential issues:

1. When scx_cmask_ref_init() is called prior to this loop, passing a NULL
pointer because arena_kern_base is 0 causes a NULL pointer dereference at
READ_ONCE(kern_src->base).

2. Within this loop, parent->pshard[si] and child->pshard[si] are
unconditionally dereferenced, which would cause a NULL pointer dereference
since the pshard array is NULL.

Should sub_cap_preamble() or scx_alloc_pshards() ensure the arena is
fully initialized before permitting these sub-scheduler capability kfuncs
to execute?

> @@ -886,6 +998,9 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 =
caps,
>  			continue;
> =20
>  		SCX_CMASK_DEFINE_SHARD(granted_cids, slice->base, slice->nr_cids);
> +		SCX_CMASK_DEFINE_SHARD(changed_cids, slice->base, slice->nr_cids);
> +		SCX_CMASK_DEFINE_SHARD(delta, slice->base, slice->nr_cids);
> +
>  		scx_cmask_copy(granted_cids, slice);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D20
