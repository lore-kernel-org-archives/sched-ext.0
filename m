Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBB3F7AB4
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547241; cv=none; b=XluuAvdZldNREpj+RD06Y+obc2sQOCX+dfcs9CuhIBK/2+MhCHHujMT/NO9QDN2+jmC6T88sWxOXs/aq5qTgH8bkpynxcjgYdSzkOCiwujExWH88rSZ/OV40KqB4Qqc7XradNz802kEVujeLJlQLCzclMgmqRnslQf6PD74cEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547241; c=relaxed/simple;
	bh=x0lOZmznhAbTUB+D6QmfIwMuDZbL0XdW9UF/w5KGMEI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OnW5PvN6tCNwwoGfToy97mqZK+IZxkBhvbjttNnyg09P1Gc6li8kG952LoiO8XTQzkSqW6bh5+Lwnwn8uQoYMYgpjvw5Rxo53dANKHOWG2/edP/0k/sPWq3lK0jIhYVotRlKNePbrtjCfcUpPtpgO0qdc+xGdPzoxOSBOnBjERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf0EOlbj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf0EOlbj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193391F000E9;
	Wed,  8 Jul 2026 21:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783547240;
	bh=iEexQ/DY8Cyq/eWsAGb9T2rnsbAwlA8sGDBiSkvnJVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lf0EOlbjdbqZm6u0jvaIkf1/N6ES0ixStQQ+WJE/QpkYd3NLS7n6IL9d6UyqJLopw
	 cy70BHrkdJVHZhO8Gam/955vHUCrqWn4Y4nl82hCWEHX+YBfRAvreD05A66AkOWArE
	 gUnlpyLusYeqCmSc8vH2QvuyP1lVItq7Qu9D4pKmYkoo1s0UN+n6ATUUPa1ULSg6rY
	 lFRXfipmz6GuwcXRvIBWyZ5YpZ48d43b+p5YvEes+6MK4H/cIdVDHIo84lcBz54E7O
	 QX+5Z893ZDoa+gZ67XqslUcUQei6kVh+SK17Z8AOvTsczMuqz87Rliyo7Kd7BQzIJr
	 n9sLTUmD2p3/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 14/40] sched_ext: Defer scx_sched
 kobj sysfs add into the enable workfns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-15-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-15-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 21:47:19 +0000
Message-Id: <20260708214720.193391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Meaningful code and commit message mismatch: In sub-schedulers, =
scx_sched_sysfs_add() is called before ops.init(), contradicting the root s=
cheduler's behavior and the commit message's goal.
--

--- Patch [14]: [PATCH v4 sched_ext/for-7.3 14/40] sched_ext: Defer scx_sch=
ed kobj sysfs add into the enable workfns ---
commit 76fa4bf5abb621f0acd7524a77691d28f4fdf9b7
Author: Tejun Heo <tj@kernel.org>

sched_ext: Defer scx_sched kobj sysfs add into the enable workfns

This commit splits kobject initialization and addition for schedulers, movi=
ng
the sysfs addition to the enable work functions. This ensures the scheduler
is fully built before becoming visible in sysfs.

>     Prep so a future caps attribute can rely on @sch being fully built by
>     the time it's sysfs-visible.

Does the implementation in scx_sub_enable_workfn() match this description?
The commit message states that sysfs addition happens once the scheduler is
fully built and its sysfs-visible state is initialized.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index ce76ae141e0a9..9855a9a4e7095 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
[ ... ]
> @@ -363,6 +365,10 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  	if (ret)
>  		goto err_disable;
> =20
> +	ret =3D scx_sched_sysfs_add(sch);
> +	if (ret)
> +		goto err_disable;
> +
>  	if (sch->level >=3D SCX_SUB_MAX_DEPTH) {
>  		scx_error(sch, "max nesting depth %d violated",
>  			  SCX_SUB_MAX_DEPTH);

[Severity: Medium]
Is it intentional that scx_sched_sysfs_add() is called here in
scx_sub_enable_workfn(), before ops.init() is executed?

In scx_root_enable_workfn(), the sysfs addition is deferred until after
ops.init() runs and SCX_EFLAG_INITIALIZED is set. However, in this
sub-scheduler path, it is added to sysfs earlier, before ops.init() is
invoked.

Will this premature exposure cause issues for future caps attributes that
expect sub-schedulers to be fully initialized when visible in sysfs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D14
