Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA4332EC5
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960893; cv=none; b=TeKizhznmpy4X/kqWbMcwajhA/POXHDETreTpupyby8lL+CDSuuEGxgyc4fiPQD8qt6ovSagnHVA/4GnTvm5h3iHhlKiYV+2n3Gd0mLDuzuMWyiiplWaZfnF0cMkAh+1P+2POh6sjGeBsDLLJ4aM2+iMhIOqerosIemTwo/XN7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960893; c=relaxed/simple;
	bh=1PjEHBhU6M3QHAtaVKuKCciFAUwZ3N4tPp8zB2OKaCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ButhbjfTLFNpG5GHxVGgcwHCSTLmSOiAllFve73BvgPl3k24+l6JkThXmYy8/L/bLoNfZh6xp4ZfpRLeZn0ArBl8VMKWcO6ygNyCgZraBejx2x5ufLcJ4Mn9NMZHFSS1+igW4gqlnTUhbC3sPGApFaOsQRxXZQ2bdZs/o9TDhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COV4bp3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COV4bp3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906F41F000E9;
	Mon, 13 Jul 2026 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783960891;
	bh=a7CFdiL+qJlMJIbwEeg7f9XAiXWTNJ7031gYM1erWnw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=COV4bp3cs6N6acbvXXTgjrColAd/YOYAr+0+DaUmAK3IOcRWr+YBN6cuOWdWtK5yt
	 027BOAOW7AVDshrtU2wXtVtYYr2rgycwm8ohXHKHiBaTXuLLRmj+oXeLohrirhOVNH
	 hLq9btgzJ6jSz5IO/XITgXQDpaGxGhbFZeUom9tohpbIWKMAg9bjMaTlB8kbveB4N+
	 NSLEH04954k9Sz6CsY6LBErvPi071wlZEOsSai3G9xrhdtfSo7ps+AlxhKdi2MppP/
	 rRwmBOBuZ7qEsjAh7DzZ+vVFclyh+ApKLlu8oGLpUlgzGrU/YkMehbNuspkNsYepYb
	 8Uk7HvtuOXyVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] sched_ext: Block proxy donors across scheduler
 transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260713162112.26785-3-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
 <20260713162112.26785-3-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:41:31 +0000
Message-Id: <20260713164131.906F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched_ext activation and PI de-boosting bypass scx_prepare_setsche=
duler(), leaking retained proxy donors into the BPF scheduler.
--

--- Patch [2]: [PATCH 02/10] sched_ext: Block proxy donors across scheduler=
 transitions ---
commit 824f6d5806618a51db9777883b9153164c747f32
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Block proxy donors across scheduler transitions

This patch makes sched_ext reject retained proxy donors by default. It forc=
es
blocked tasks through the regular block path in schedule() and fully
deactivates a retained donor before sched_setscheduler() moves it into the
EXT class.

[ ... ]

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index b215b0ead9a60..2bbba3dc8c890 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -678,6 +678,9 @@ int __sched_setscheduler(struct task_struct *p,
>  	if (prev_class !=3D next_class)
>  		queue_flags |=3D DEQUEUE_CLASS;
> =20
> +	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS))
> +		scx_prepare_setscheduler(p, next_class);
> +

[Severity: High]
Can retained proxy donors leak into the ext_sched_class without the BPF
scheduler opting in during global activation or PI de-boosting?

Looking at scx_root_enable_workfn() in kernel/sched/ext/ext.c, tasks
transition to ext_sched_class without invoking scx_prepare_setscheduler():

kernel/sched/ext/ext.c:scx_root_enable_workfn() {
...
		if (old_class !=3D new_class)
			queue_flags |=3D DEQUEUE_CLASS;

		scoped_guard (sched_change, p, queue_flags) {
			p->scx.slice =3D READ_ONCE(sch->slice_dfl);
			p->sched_class =3D new_class;
		}
...
}

A similar transition occurs during PI de-boosting:

kernel/sched/core.c:rt_mutex_setprio() {
...
	prev_class =3D p->sched_class;
	next_class =3D __setscheduler_class(p->policy, prio);

	if (prev_class !=3D next_class)
		queue_flag |=3D DEQUEUE_CLASS;

	scoped_guard (sched_change, p, queue_flag) {
...
}

If a task is blocked on a mutex and retained as a proxy donor, would missing
this check cause the task to bypass the blocking logic? Could this cause
runqueue corruption when the BPF scheduler receives a blocked task it assum=
es
is runnable?

>  	scoped_guard (sched_change, p, queue_flags) {
> =20
>  		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713162112.2678=
5-1-arighi@nvidia.com?part=3D2
