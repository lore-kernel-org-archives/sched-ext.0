Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77319199385
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808726; cv=none; b=BvVez98YFdm3/SCUOzIqIKJkFMNjo/1lJ+4BLO3uuqplivLRQ21vEU/cz5ovPkgk3GEdfPlPRQy7SmaLuy4119BOxAJzJMxQpeBW4SIF+yTmIjIa5wzRieCVod7Qzv9QGYbi8bEjyGqXomvP9ntniGiGGMjKOqLIvtnouvHXPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808726; c=relaxed/simple;
	bh=86a0X9RLvGRZoENMwIW2PVBq/D8NQxusQTazzjBZAJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mf9OMmBSWu7IC/pO0QgMEc8m3/0NnOLK6w7lz2ykkhA+1su8VGl8jlsXhBbpruaehr8H0X0/FGY+Lv2ET/N1qm0Kp27wVkZmMzeeCg73jNEyinO3HD25X1doj+l63YZGe4+dwaI1rwCV+73vAZvOnhTRgjZQHrDsYudaeRgQ0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPoOV0t/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPoOV0t/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A50F1F000E9;
	Tue, 26 May 2026 15:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808725;
	bh=3oVeiMv9aSKu20mPfOPyVphAgdDmUJUZDd4cEiWz79I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPoOV0t/p5XIQ5q6OryE8+nXgM2BxxpACNUsAYskTjRDyG44gkDOYDNlQ0TJpbhMX
	 /s/AP4Z38xI31CQS+oTeeXYUsN5xbyE4vi/Qeyny2i2UrfHSfihzkMDWQmc0vQB9sd
	 HrPjT9mEmUDEty8S+MU5dRnb27hlFZa+UNoQXGLDiVd97Utd+Jmh0zNio0/++R6MO7
	 INTzY7zs0J0xFTmBSBYZwaRU/6FExsUldv1mFZXbD14rxZIXAYV+1mhAmFiVeQGqaJ
	 vPKTi8Y0lQQ0iQ4OtlUPsAsEGlKK/C3lwx0i0VPD2sayTlj/ImzFtuJhj3VbKy3rBR
	 Z4GM8l3tK8xdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Rebuild fair weight when disabling BPF
 scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zicheng Qu" <quzicheng315@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260526135211.1892261-1-quzicheng315@gmail.com>
References: <20260526135211.1892261-1-quzicheng315@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 15:18:44 +0000
Message-Id: <20260526151845.0A50F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stale p->se.load weights when transitioning tasks from SCHED_EXT t=
o SCHED_NORMAL via sys_sched_setscheduler()
--

commit d672e37dd0f7bb43fb8f1a521e9d70c91ecf303e
Author: Zicheng Qu <quzicheng@huawei.com>

sched_ext: Rebuild fair weight when disabling BPF scheduler

This commit fixes an issue where tasks switching from the BPF scheduler back
to the fair scheduler during scx_root_disable() retain stale load weights.
It rebuilds the fair weight by calling set_load_weight() so that CFS gets
the correct load_weight derived from the task's current policy.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 345aa11b84b28..3126125968d67 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5872,6 +5872,10 @@ static void scx_root_disable(struct scx_sched *sch)
> =20
>  		scoped_guard (sched_change, p, queue_flags) {
>  			p->sched_class =3D new_class;
> +
> +			if (old_class =3D=3D &ext_sched_class &&
> +			    new_class =3D=3D &fair_sched_class)
> +				set_load_weight(p, false);

[Severity: High]
This isn't a bug introduced by this patch, but does this same stale weight
problem happen when a task is moved from the BPF scheduler to the fair
scheduler via sys_sched_setscheduler()?

In __sched_setscheduler(), __setscheduler_params() is called before
p->sched_class is updated to the new class. __setscheduler_params() calls
set_load_weight(p, true).

Because p->sched_class is still ext_sched_class at this point,
set_load_weight() invokes reweight_task_scx(). reweight_task_scx() updates
p->scx.weight but completely ignores p->se.load.

Immediately after, p->sched_class is set to fair_sched_class, and the task
is enqueued into the CFS runqueue with its old, stale load weight. Could
tasks transitioning via sys_sched_setscheduler() also run with the wrong
scheduling priority and monopolize CPU time?

>  		}
> =20
>  		scx_disable_and_exit_task(scx_task_sched(p), p);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526135211.1892=
261-1-quzicheng315@gmail.com?part=3D1
