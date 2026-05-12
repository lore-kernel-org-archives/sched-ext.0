Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C72222CC
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549204; cv=none; b=HmpFLeaDFFEjR2Q06vY0oB4qJkmNXeaLcGYwCrtQnGkbbOkSBoHoGOe8hvuIUPzZX00aPm/8UBcs7td+W3LHOiO43aHY3+YaO8Fod3FgRYnkfGEKJzN7DPFBYW3mPeITSxAGl0T3/LDrDMaamQmDMv3fd1vhXR2Z0bH47Ddirjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549204; c=relaxed/simple;
	bh=px9/cwPcGQRDKBliEVc7mHim3jd90ptfC1qZth2Z/zM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aNiO3gp8fCSS/TYMesMOnKk1JwWf0MuDK0G+HUXHHrxVamyLimp5ed8LjBD35zlnutA7a41p+orKp32tDME/HjYlk8FijgRpN/HaPSF9n8Q9BIKZaEynyYWtNbuhEwkyheRjzJoL+5t0UMHJ5MbZGLiGx4aok3rbwKwlFCk3o+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT/FtqOs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT/FtqOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1292AC2BCB0;
	Tue, 12 May 2026 01:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778549204;
	bh=px9/cwPcGQRDKBliEVc7mHim3jd90ptfC1qZth2Z/zM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LT/FtqOsPIUVxWI44RbF3mANBBAA+JWKTbZJtkbxtRbP7qkUxmR84ToyZ+VFB2yOL
	 FEMFe4ML3HzphHzwl03aFHaCEXDygPINRgeEjY3P7rG1mk0pJk+XW2F18CSN6TQtIH
	 KcjL1xBwfJYXD6MrZIy3rze9vfeZldr+dHmlP3+Dknd5RUf90M772ekCxLUGDGDI62
	 XYocNzO1qG8s3wYDoyIQ4KwAA6PlDNjd/uuuK0k6NVuwk34vT3iCECgHcY4D3qtjsL
	 XhzI447KpLnYz0sA7NSaoQfZRCOZboezUWJL6Ud8cJcv0wH7u32tBdTLwQwhr0F22D
	 vj8TupJkVuO7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Clear ops->priv on
 scx_alloc_and_add_sched() error paths
Reply-To: sashiko@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260511083130.3174880-1-arighi@nvidia.com>
References: <20260511083130.3174880-1-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 01:26:43 +0000
Message-Id: <20260512012644.1292AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free in error path due to synchronous free of an RCU-pub=
lished scheduler object.
--

commit d7deeed41c3e10702cde2a93eca3d9b6aba8924d
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Clear ops->priv on scx_alloc_and_add_sched() error paths

This commit addresses an issue where a failed attach leaves a dangling poin=
ter
in ops->priv, preventing future attach attempts. It adds code to clear the
pointer on the failure paths in scx_alloc_and_add_sched() so the data retur=
ns
to its pre-attach state.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 1d7f206941f0c..535bbb678cc5b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6824,6 +6824,7 @@ static struct scx_sched *scx_alloc_and_add_sched(st=
ruct scx_enable_cmd *cmd,
>  		ret =3D kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
> =20
>  	if (ret < 0) {
> +		RCU_INIT_POINTER(ops->priv, NULL);

Could this lead to a use-after-free for concurrent RCU readers?

The scheduler object is published to lockless RCU readers earlier in the
function via rcu_assign_pointer(ops->priv, sch).

If an initialization step fails after that point, the pointer is correctly
cleared here, but the object and its inner allocations are then synchronous=
ly
freed in the teardown chain (for example, via kobject_put() or kfree(sch))
without waiting for an RCU grace period. Concurrent BPF programs could still
be accessing the freed memory as RCU readers.

Would it be safer to defer the rcu_assign_pointer() publication until the
very end of the function, ensuring the object is only published once all
fallible initializations have succeeded? This might also naturally
eliminate the need to clear ops->priv on these error paths.

>  		kobject_put(&sch->kobj);
>  		return ERR_PTR(ret);
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511083130.3174=
880-1-arighi@nvidia.com?part=3D1
