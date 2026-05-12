Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4819E7F7
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545311; cv=none; b=XIP8bmulT3+qLcBhDwOI3OkmnNtNz2ttE+ivvxYuqnRIMY4pH3XDurAwendsUeuUDzefwaK32Z96ZxHvZPkMJ6WhLT/l01Q+R2HiMwp/iiYsBt5cSv4Pl++gJ9/m1Ubw7hG0lJLc4g17Lj7PGOPx+6Nzi65LwYW29GDt231mDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545311; c=relaxed/simple;
	bh=M7IKiyua+P16wG11ZMhcZpGWLOeL1//am6Z9Aoc0qJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M3Dup4fC4Y2uJHv4WzWU+07vaz+UDBEU98jzcyXVTfsd3f3O+ob4rXzlGd0/FFiDKi+osZTMKg99gfPwS8cwfIEcC4gI+Jni3w+LsKkQJhnTUMoenTGCZyp9v4z1B5p6VGN+Hr7OF3hxGHLnw2bcA7jWHlQ59ecv7imiFZ/LEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev2bJlgY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev2bJlgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569F4C2BCB0;
	Tue, 12 May 2026 00:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545311;
	bh=M7IKiyua+P16wG11ZMhcZpGWLOeL1//am6Z9Aoc0qJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ev2bJlgYiTZMH5BkTDjZojHePiNX6d3fSxQx4mX9dEQS4OwDFG19JWg9co1pUkQKG
	 0H7VKhah/PVX8OjMeWqn/5byIL5t0/cRCVS+REE2r2baaKPtHY0YlE/MbDiTuPXEg2
	 lpcS3g8DXrGhEIGefCmQTf4lG7u/9vd5TA8qveFRP4dg5bkgOWuwXGpNxp2cFBhtrN
	 aZujrN5t2uVixfCp4DzKWLKcvIid086YDz4ud52G3juG0JiSXoXht+xQFOqQNRevog
	 U/F/vG61Wmqji7rzBlrCsa91FDmatr7TjKZk440YcyihlIQWJifhzbSwYvFvv9HAmC
	 C5QrvYAqNv1PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Fix ops->priv
 clobber on concurrent attach/detach
Reply-To: sashiko@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260511061812.2459458-1-arighi@nvidia.com>
References: <20260511061812.2459458-1-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 00:21:50 +0000
Message-Id: <20260512002151.569F4C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Error paths in `scx_alloc_and_add_sched()` leave `ops->priv` as a =
dangling pointer, causing the new `-EBUSY` check to permanently brick the B=
PF map and exposing a Use-After-Free.
--

commit 451a33ccc662950a2e5e3da8cd4a0309ed7f2725
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Fix ops->priv clobber on concurrent attach/detach

This commit addresses a NULL pointer dereference caused by a race condition
during concurrent attach and detach operations. It adds a check to reject
attempts to reuse a kdata that is still bound to a previous scheduler
instance.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6733,6 +6733,19 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
>  		goto err_unlock;
>  	}
> =20
> +	/*
> +	 * @ops->priv binds @ops to its scx_sched instance. It is set here by
> +	 * scx_alloc_and_add_sched() and cleared at the tail of bpf_scx_unreg(),
> +	 * which runs after scx_root_disable() has dropped scx_enable_mutex. If
> +	 * it's still non-NULL here, a previous attachment on @ops has not
> +	 * finished tearing down; proceeding would let the in-flight unreg's
> +	 * RCU_INIT_POINTER(NULL) clobber the @ops->priv we are about to assign.
> +	 */
> +	if (rcu_access_pointer(ops->priv)) {
> +		ret =3D -EBUSY;
> +		goto err_unlock;
> +	}

If scx_alloc_and_add_sched() fails during a subsequent attachment attempt,
does this leave ops->priv pointing to freed memory?

Looking at scx_alloc_and_add_sched(), the BPF operations map is bound to
the new scheduler instance early:

    rcu_assign_pointer(ops->priv, sch);

If a later initialization step in that function fails, such as allocating
cgrp_path or failing kobject_init_and_add, the error paths free sch via
kfree(sch) or kobject_put(&sch->kobj). However, the error paths do not
reset ops->priv to NULL.

Because ops->priv retains the dangling pointer to the freed memory, will
the new check added here permanently block any future attachments by always
returning -EBUSY?

Could this dangling ops->priv pointer also be accessed by a BPF program
running a sched_ext kfunc like scx_bpf_kick_cpu, resulting in a
use-after-free when scx_prog_sched() retrieves and dereferences it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511061812.2459=
458-1-arighi@nvidia.com?part=3D1
