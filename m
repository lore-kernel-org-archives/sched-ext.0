Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B9405C54
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678656; cv=none; b=cPs8HXxY1wmnOO7kV+I3VGSUswnUy1orftZbMtpPxDARZEqCStwqTDgFYXvZ8hLA/UxgNgYKU2ViLoikQCOIqHlaEPaqv+5Koq7mWpsMl/muXsCTnmw7ff4jVRYT+yJc8m8GLLHVHTwZedTJpDDFL10DXZsrO/76U+76a2KxoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678656; c=relaxed/simple;
	bh=d+sf52g0FQvamOma3vIzbmg+tQV56fOn2CWBg7C9f5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GcLxiHu6gsghjLdyAd7dchvBLqJGjJHk5R91QJh9aEe1t0BqJ440oof1w1lyqo+PPldP3KKQaK7zQFiq4OgC/ihzHEZm/gpIu/lWTfevXPl8DBET3VEfqvSKTMTFusHxCYq+Dg+d/SRpPIdI2VDbp67kxI+3b1S7zYNDEUJ8ktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaHtIPnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaHtIPnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C481F000E9;
	Fri, 10 Jul 2026 10:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783678652;
	bh=oyc4gI0V9U3HhVkO6Vafx5cQE65lqWVRQRySNyWoQrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HaHtIPnWdEYsuxyOBJqMsQgnw3FnrJzS0vknLAIaVmyB6r6qX8ICvxskcQDd8dkCj
	 q54ly4s/CPVtb3WYSQuWhf2L46UXhXQ6FxKpe4N21WoOIgpmKmvHB+my1yGW/0Y0Gl
	 ltYjwxQLsjRgXzS8zEmFjK1OGO7gv+RBTca4JZ+DuyxnC4GPT3GzvszKHig8qMcF6m
	 L6AJ6VZNJb7rxVkSoaQ6HpgTMRKprQ/AVB3gxUKQAkgV9F3hTevkyG0LZK6kLmbW4K
	 /NrqAMr3KZ33aic3MafUYQTgN3M6TUmGOj1+FuFBXcRRYJ+zGRo9J4aoj4W+9xMoM1
	 65nPub1FxXJ+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Fix deadlock with PSI trigger creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Fleming" <matt@readmodwrite.com>
Cc: tj@kernel.org, sched-ext@lists.linux.dev, mkoutny@suse.com, hannes@cmpxchg.org
In-Reply-To: <20260710100441.2653477-1-matt@readmodwrite.com>
References: <20260710100441.2653477-1-matt@readmodwrite.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 10:17:31 +0000
Message-Id: <20260710101732.93C481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes an ABBA deadlock between `cgroup_mutex` and `scx_f=
ork_rwsem` in `scx_root_enable_workfn()`, but leaves the exact same lock in=
version unpatched in `scx_root_disable()`, `scx_sub_disable()`, and `scx_su=
b_enable_workfn()`.
--

--- Patch [1]: [PATCH] sched_ext: Fix deadlock with PSI trigger creation ---
commit aacffeaa1e10b05888e4970e698ee8d1863dbbbd
Author: Matt Fleming <mfleming@cloudflare.com>

sched_ext: Fix deadlock with PSI trigger creation

This commit fixes an ABBA deadlock between cgroup_mutex and scx_fork_rwsem
in scx_root_enable_workfn(). It prevents deadlocks that can occur when
concurrent writes to cgroup PSI trigger files attempt to create kthreads.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 691d53fe0f648..ba89eafe79643 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -7193,7 +7193,10 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
>  	/*
>  	 * Lock out forks, cgroup on/offlining and moves before opening the
>  	 * floodgate so that they don't wander into the operations prematurely.
> +	 * cgroup_mutex must nest outside scx_fork_rwsem because cgroup file
> +	 * operations may create kthreads while holding cgroup_mutex.
>  	 */
> +	scx_cgroup_lock();
>  	percpu_down_write(&scx_fork_rwsem);

[Severity: High]
This is a pre-existing issue, but does this same lock inversion still exist
in other scheduler functions?

For example, scx_sub_disable() takes scx_fork_rwsem before scx_cgroup_lock(=
):

kernel/sched/ext/ext.c:scx_sub_disable() {
    ...
    percpu_down_write(&scx_fork_rwsem);
    scx_cgroup_lock();
    ...
}

scx_root_disable() also takes the locks in the old order:

kernel/sched/ext/ext.c:scx_root_disable() {
    ...
    percpu_down_write(&scx_fork_rwsem);
    ...
    scx_cgroup_lock();
    ...
}

And scx_sub_enable_workfn() appears to do the same:

kernel/sched/ext/ext.c:scx_sub_enable_workfn() {
    ...
    percpu_down_write(&scx_fork_rwsem);
    scx_cgroup_lock();
    ...
}

Could a concurrent PSI trigger write still cause a deadlock if it races
with these other paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710100441.2653=
477-1-matt@readmodwrite.com?part=3D1
