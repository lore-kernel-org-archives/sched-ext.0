Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422237F72A
	for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535632; cv=none; b=YQK6dvIMzWq84iupO2oeD7JF83eOz4iv2xkuhubXuxsQv2LNzp2jpgc5zPSa8jR29R/2onyCPJQVymHJuasFcr+LI0lhmsEAsjfRwD8pUVZMiuyTZwFXVg3oDEw8bKzgMJxVaXmBOBKhqw+n5Ks7OmOZ02F81kWbY/sSBIK6ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535632; c=relaxed/simple;
	bh=mSCbuAjGmiqmeq46UQRBtRryj+x8LIXNhm/Q3ccHWmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jO13eadfaQ565GdpUbfo3kQfcRCEqOvhQwNl7kw6XRvXCKRmBXYDG95BunwcZ1mWaVEHI5ZMso5s6hH7q2gIEDMKJ1RF4URlgy1jb8Hfaj2az+dsvLG07bxwZbVXZrzIJahTm3OYMzGZHGq5ZUPRwVNGWHrgOS44/e0pZfIvFEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG/Hv7RW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG/Hv7RW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5E9C2BCB0;
	Mon, 11 May 2026 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778535631;
	bh=mSCbuAjGmiqmeq46UQRBtRryj+x8LIXNhm/Q3ccHWmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cG/Hv7RWwTVrG7OxWVg7pKPyBA2fTRyJsJH6tGH6O2ZCz3spABFp2qUZ6mrnUW003
	 RKNZKs6euoTYHUCil9qgpZofq85JkC5ySnpJte4FGdXa0LbFdWuejvnXInXcPkQrcG
	 IYHJclNi+f8ltybgBMfEuuCgY+Q9s6HdE2PmLV+BMm7GDJ2mgoC78eF9xfje5R1K5n
	 l46ndlJVjxzvl5LuMMHPfSKD+EFxT3JFcavAl24tuEjLMJdZ3BDyZ2LdiO7U6axABx
	 YrfTcRZttJeOvJTUApUpVe8woWWvOm+sJERgWgQz6PD173QT5RAumtfZxJmmhJjsxN
	 m5etjPTTJwerw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] sched_ext: Inline scx_init_task() and move
 RESET_RUNNABLE_AT into scx_set_task_state()
Reply-To: sashiko@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260510074113.2049514-3-tj@kernel.org>
References: <20260510074113.2049514-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 21:40:31 +0000
Message-Id: <20260511214031.AF5E9C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free (UAF) of task_struct fields `p->comm` and `p->pid` =
in the error path of `scx_root_enable_workfn()`.
--

commit ff748fbf4ba914d4e370692e8c52959bf3619890
Author: Tejun Heo <tj@kernel.org>

sched_ext: Inline scx_init_task() and move RESET_RUNNABLE_AT into scx_set_t=
ask_state()

This commit prepares for the SCX_TASK_INIT_BEGIN/DEAD work by collapsing the
scx_init_task() helper and moving the SCX_TASK_RESET_RUNNABLE_AT setting
into scx_set_task_state(). It also inlines scx_init_task() into scx_fork()
and scx_root_enable_workfn(), dropping the helper.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c

[ ... ]

> @@ -6884,8 +6870,8 @@ static void scx_root_enable_workfn(struct kthread_w=
ork *work)
> =20
>  		scx_task_iter_unlock(&sti);
> =20
> -		ret =3D scx_init_task(sch, p, false);
> -		if (ret) {
> +		ret =3D __scx_init_task(sch, p, false);
> +		if (unlikely(ret)) {
>  			put_task_struct(p);
>  			scx_task_iter_stop(&sti);
>  			scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
>  				  ret, p->comm, p->pid);

This isn't a bug introduced by this commit, but could this lead to a
use-after-free of the task struct?

If put_task_struct(p) drops the last reference (for example, if the task is
concurrently exiting), it will schedule the task struct for RCU-delayed
freeing.

Immediately after, scx_task_iter_stop() releases the task iterator locks,
which can re-enable preemption and interrupts. Since the thread holds
sleeping locks, an RCU grace period could potentially elapse before executi=
on
resumes.

If that happens, accessing p->comm and p->pid in scx_error() would
dereference freed memory.

Should put_task_struct(p) be moved after scx_error() to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510074113.2049=
514-1-tj@kernel.org?part=3D2
