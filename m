Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40F2DF719
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384584; cv=none; b=QlMCNGWebK/JxkXGhwGvfm7xmkgta5uFFSs/5qUsGfQTgVuveytOkXmPdjy9F0Wn69Qc4w7LZTqFB/IIKdbYxbrvRwEMsU6peneqeoVZeE7cnBPXh+JhfA/qda7RSHbyEVzuca7nO+KsRAeblnDpqVhSw4DzqSIbDGMCvDW++2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384584; c=relaxed/simple;
	bh=776xOxJYIT5ghCurDBqHxWfdQrTNwjGJ1oSpFLtLHtI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NQfZLLgASbPda436cwefyterfZtYs5e7hoc9zMENvJnI510s6gRYnihf23Z937RyrhoofPs1dICtxZrblOR/mzbsrYbEFeczGG+HdmgiemvNuYohwtSjuDkGKmzLkaAuIUIJXH2jk4fx6tpP7PfhtkM+xov+5bjf8uJ7YYVP2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkbJcfxJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkbJcfxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22591F000E9;
	Tue,  7 Jul 2026 00:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384583;
	bh=NxhzOiM5AdvDArqtv3mODgO1+sBAuSThvnh8ZRNX2bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LkbJcfxJjCg3TkYebQhN/+JSXvERsxzN6xJ6kt59cvkTWIqrI/upLDsSxu8Bt7XaX
	 VPpdA2Ud+xmhBqJm6MWwcHG1dKAybjKrjuJVddL1eCAzcxDrkAkFAHcuOmz2F9vS2I
	 UOu1kDK3zEwse975IzOm1GjQgzSlI1RA9bMa2zg6piE9zWZn2DqdmF4NKm5mnd1zL8
	 Fv3XTH3gLkr36DO4QeEFSv5Sr66bGfy3N0Vxigq0dA/25p3O3RPGkWy/eZ7pCuppIA
	 /k2AqGa3RkqMRt/e6IEKcVJ5SVOqRuPel3DY13j21Xx30AsxbgVKUKn2KM+uBEPreA
	 X//QrpfkHxm3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 10/36] sched_ext: Add
 ops.init_cids() to finalize the cid layout before init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-11-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-11-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:36:22 +0000
Message-Id: <20260707003622.F22591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inconsistent ops.init() execution order and silent ignoring of o=
ps.init_cids() for sub-schedulers.
--

--- Patch [10]: [PATCH v3 sched_ext/for-7.3 10/36] sched_ext: Add ops.init_=
cids() to finalize the cid layout before init ---
commit 203e12db1eb59d2f31e8e189609af23a163797d2
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add ops.init_cids() to finalize the cid layout before init
   =20
This commit introduces an ops.init_cids() callback for cid-form schedulers
to finalize their layout prior to initialization. It allows enabling setup
that relies on the final cid layout to run after the layout is established,
and moves ops.init() execution to run after arena pool and cmask allocation=
s.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 150e74129266b..ee390d95cd2e3 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -6684,15 +6684,19 @@ static void scx_root_enable_workfn(struct kthread=
_work *work)
> =20
>  	scx_idle_enable(ops);
> =20
> -	if (sch->ops.init) {
> -		ret =3D SCX_CALL_OP_RET(sch, init, NULL);
> +	/*
> +	 * A cid-form scheduler finalizes its cid layout in ops.init_cids(),
> +	 * which may call scx_bpf_cid_override(). Run it before ops.init() so
> +	 * the final layout is in effect.
> +	 */
> +	if (sch->is_cid_type && sch->ops_cid.init_cids) {
> +		ret =3D SCX_CALL_OP_RET(sch, init_cids, NULL);
>  		if (ret) {
> -			ret =3D scx_ops_sanitize_err(sch, "init", ret);
> +			ret =3D scx_ops_sanitize_err(sch, "init_cids", ret);
>  			cpus_read_unlock();
> -			scx_error(sch, "ops.init() failed (%d)", ret);
> +			scx_error(sch, "ops.init_cids() failed (%d)", ret);
>  			goto err_disable;
>  		}
> -		sch->exit_info->flags |=3D SCX_EFLAG_INITIALIZED;
>  	}
> =20
>  	ret =3D scx_arena_pool_init(sch);
> @@ -6707,6 +6711,17 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
>  		goto err_disable;
>  	}
> =20
> +	if (sch->ops.init) {
> +		ret =3D SCX_CALL_OP_RET(sch, init, NULL);

[Severity: Medium]
Will this change cause an inconsistent initialization state for sub-schedul=
ers?

While scx_root_enable_workfn() has been updated to run ops.init() after=20
arena pool and cmask allocations and introduces ops.init_cids(), the
equivalent sub-scheduler setup path scx_sub_enable_workfn() in
kernel/sched/ext/sub.c appears to have been left unmodified.

As a result, in scx_sub_enable_workfn(), ops.init_cids() is silently
ignored, and ops.init() still executes before the arena and cmask
allocations. Should scx_sub_enable_workfn() be updated to maintain a
consistent initialization order and either support or explicitly reject
ops.init_cids()?

> +		if (ret) {
> +			ret =3D scx_ops_sanitize_err(sch, "init", ret);
> +			cpus_read_unlock();
> +			scx_error(sch, "ops.init() failed (%d)", ret);
> +			goto err_disable;
> +		}
> +		sch->exit_info->flags |=3D SCX_EFLAG_INITIALIZED;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D10
