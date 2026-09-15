Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89803B1BD
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 00:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430591; cv=none; b=oluOmKiLhN5YcVmIJyFrbb5tQA+nUE3PVds436LyWuoGEX/VXzVok8W4t8fq9qW9w7RqXA6/sKOxqrrUiQDDpu4yt9T6aip6GHEPoqOzAwFarslbgpnrk6tqlmjenT0LbWW8B1Uj6SU+E1IacNFCZqQo3s6EJTtdIVCJCDlVCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430591; c=relaxed/simple;
	bh=G0UUu2qWWl10gDVcMKpvU7qyM6jRYk+6+MEz8UHwt2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hRqo3bkLQWUQOzEGGSJl2pPT1xK1/ZCquKVfLdVT/xtQw/+uhoGE68CbK6iFhBjndOxLDxah7khUCfRpfJoXuTYpiB4UKA3k1w5QRpaGhZGGwRHaclLZDm3NRC8MysbR44OgBsL70WhK38FWeGkyGd079uDzm2hiX+tgXHGnVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+CEFmvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+CEFmvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BAF1F000FF;
	Tue, 15 Sep 2026 00:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789430589;
	bh=zb0wQYkXdpox+gksvzjyeO0dREKJLp+KjHZkpmQr0Yo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S+CEFmvjwYzkayX9KtUoTnHFrThys+nqQ5KVN9AvVJ1RJu7GNHSvA/yyx/792+hNz
	 p/if+XYIFt0cKVvrVlLQsF1IoAd158vY3VFnLtMlAGP1T2EyLVz8d07geDBR+43jl6
	 ++dDNo00oGlH6NTUoHdZQ9a+FmeopzYLx+qTlXZhMBskVoIf6n2OSZ27BD4jvIgDfX
	 EnAWiY0fGuPNQXZ4A76oJtS1E7g1qHI/IvSHfIktWtiEVkUqtB53XnMcEyEnKagM2+
	 bgrymevqC3Tv/qlJyeuoztrfp2IUjdrb04Z//6te7y+1QTGHES+N0jalQzEyleA82O
	 GRjzO15V6sxSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Maintain an online cid mask in the
 scheduler arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260914234259.3585373-3-tj@kernel.org>
References: <20260914234259.3585373-1-tj@kernel.org>
 <20260914234259.3585373-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 00:03:08 +0000
Message-Id: <20260915000309.65BAF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cleanup: mixing goto-based error handling with scoped_guard
--

commit 60f284d9a4235976e8b99adae7dd47c5aa1ab1af
Author: Tejun Heo <tj@kernel.org>
Subject: sched_ext: Maintain an online cid mask in the scheduler arena

This commit adds a kernel-maintained online cid mask to the scheduler's
arena, which is allocated alongside per-CPU scratch masks. This mask is
updated during hotplug transitions, allowing custom-mapped schedulers to
accurately learn which cids are online without needing a restart.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1805,6 +1805,12 @@ void scx_sub_enable_workfn(struct kthread_work *wo=
rk)
>  		goto err_disable;
>  	}
> =20
> +	scoped_guard(cpus_read_lock) {
> +		ret =3D scx_alloc_kern_arena_objs(sch);
> +		if (ret)
> +			goto err_disable;

[Severity: Low]
Does this code mix goto-based error handling with scope-based cleanup in
scx_sub_enable_workfn()?=20

The cleanup subsystem guidelines specify that functions should either conve=
rt
all resources that need a goto cleanup to scope-based cleanup, or convert
none of them. Mixing goto error labels (like goto err_disable) with
scoped_guard within the same function creates confusing ownership semantics.

> +	}
> +
>  	if (sch->ops.init) {
>  		ret =3D SCX_CALL_OP_RET(sch, init, NULL);
>  		if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914234259.3585=
373-1-tj@kernel.org?part=3D2
