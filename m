Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413153;
	b=DzoA61SF0dua3xaTLpU4+vicgz7nREBc5hJ3WrO0jQ55qhd1zPVMODUUC08zraON0hRH
	 KJSfPcdHPCplBWu149KR9JhdIxAKOc0V+FfFDcEkcc/XU0gVZHVN9d2u6G8kDQFcEfMNW
	 TrVNuaOwLsvlYk2r84oRgMxj6aEdxO7uRdWyvx9jY1EhU1UJJBNp5esKL/tciIHhFz+1T
	 4pljhg1oGb8hX3aEAlPMXMs5gkug2o6ot9cTFnAUEW68e2OYKZgc8Cis6uyA946xKGgpG
	 w2omNEOQhBH610ulgi3z77wxrGr7lTZS6PPmNkB1gpJ4tl3C+JbzWhUk05rFIpPI0jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413153;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GdzYnR0OzGyn9fwGgMWzraBLzT/6bya/HWDC+o514Ec=;
	b=BIPjuB1kvoJNO0Zdk9WDKmYDnE0Xdc/WzUl6khn4/2Xct1a0xOzxUndBa7jNV/4VLd7V
	 fY6iKgxPuAyiwR2p/JfDzSHAqyMoR59j9nNUbETyAk64DgqBvGMU4HX1B74BPkscVUr3g
	 BDkgFGuPCVkzCEf1/AECZhV3POZoiGMV0kVGCM3Yclnaj0xy70A8167o4Q8aFNUbO2aqw
	 eSdZITnSS3ooV+iw93ogJ8bgHMrENKMxXENcRt/tGYdBGF5p8IkIOR0gBRxx1A9bhFc1O
	 8PNCQ4R5UflUP2wQhlN5wOxD31s8FEt09Z08Hdpg5wiS6RiKP5NZCToZd1tSPNz//gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcOB016m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBDB606A31A
	for <sched-ext@lists.linux.dev>; Sat, 31 Oct 2026 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcOB016m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9861F000C1;
	Sat, 31 Oct 2026 02:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793413152;
	bh=GdzYnR0OzGyn9fwGgMWzraBLzT/6bya/HWDC+o514Ec=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RcOB016mN39Hv7eyjP6dkSey7B8DRRqT3/hiee9JI7FLk1894oWnGJrM244Yr/TPp
	 Py+eJemYtcJNNv2YQdjU18uwc9FftOs5x7lueeYbww8sEilw8f5wlFrYwXSY0bzaOC
	 JgcbkpnRCu5h4YXwdN6rbonwy89jHnIIE7VkpfZf47J0Hbmz52LNCzacAajpCKtRXq
	 Nyg+kEjIOWzlPT1V+FiguFx0cB0aKeLy5aLrMt2HMiw3dQdojQJwitSna3UyKGjngs
	 lnERl7kDbrJR9DsnYQv8PTK1IybOQzjSmLc0r0Gn2JbHniOJmhoyYVsBa9NIYtu+Ss
	 zys8W5u7LUSYg==
Message-ID: <sashiko-outbox-191703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.4-fixes] sched_ext: Fix stale pick
 when a wakeup resets the donor during dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261031015414.219280-1-tj@kernel.org>
References: <20261031015414.219280-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:19:12 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sched: stale rq->dl_server across RETRY_TASK in __pick_next_task=
()
--

commit e0269d8eaf30fac4dcf0d1178a69b8f7a54ecfe2
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix stale pick when a wakeup resets the donor during dispatch

This commit restarts the sched_ext pick when the proxy execution donor pass=
ed
as prev to dispatch_one() is reset to rq->curr while the rq lock is dropped,
and avoids passing a stale prev to ops.dispatch() or keeping it afterwards.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index ffaab9fafca87..fe1be3d9444dd 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3407,6 +3407,12 @@ static enum scx_dsp_verdict dispatch_one(struct rq=
 *rq, struct task_struct *prev
>  		rq->scx.cpu_released =3D false;
>  	}
> =20
> +	/* the ecaps sync may have dropped the rq lock */
> +	if (scx_dsp_prev_stale(rq, prev)) {
> +		verdict =3D SCX_DSP_RETRY;
> +		goto out;
> +	}
> +
>  	if (prev->sched_class =3D=3D &ext_sched_class) {
>  		update_curr_scx(rq);
> =20
> @@ -3449,8 +3455,19 @@ static enum scx_dsp_verdict dispatch_one(struct rq=
 *rq, struct task_struct *prev
>  	}
> =20
>  	verdict =3D scx_dispatch_sched(root_sch, rq, prev, false);
> -	if (verdict !=3D SCX_DSP_NONE)
> +
> +	/* scx_dispatch_sched() may have dropped the rq lock */
> +	if (scx_dsp_prev_stale(rq, prev))
> +		verdict =3D SCX_DSP_RETRY;
> +
> +	switch (verdict) {
> +	case SCX_DSP_RETRY:
> +		goto out;

[Severity: Medium]
As reported by Andrea Righi on v1 [1], can returning SCX_DSP_RETRY from
dispatch_one() leave a stale rq->dl_server pointer across a pick restart in
__pick_next_task()?

When __pick_next_task() calls pick_task_dl() -> __pick_task_dl() ->
ext_server_pick_task() -> do_pick_task_scx() -> dispatch_pick() ->
dispatch_one(), returning SCX_DSP_RETRY causes do_pick_task_scx() to return
RETRY_TASK even when force_scx is true:

kernel/sched/ext/ext.c:do_pick_task_scx() {
	...
	if (verdict =3D=3D SCX_DSP_RETRY) {
		p =3D RETRY_TASK;
		goto out;
	}
	...
}

In __pick_task_dl(), server_pick_task() is only checked for NULL, so
RETRY_TASK causes rq->dl_server to be assigned before returning RETRY_TASK:

kernel/sched/deadline.c:__pick_task_dl() {
	...
	if (dl_server(dl_se)) {
		p =3D dl_se->server_pick_task(dl_se, rf);
		if (!p) {
			dl_server_stop(dl_se);
			goto again;
		}
		rq->dl_server =3D dl_se;
	}
	...
	return p;
}

Unlike pick_task() under CONFIG_SCHED_CORE, __pick_next_task() clears
rq->dl_server before the restart label:

kernel/sched/core.c:__pick_next_task() {
	rq->dl_server =3D NULL;

	if (scx_enabled())
		goto restart;
	...
restart:
	prev_balance(rq, rf);

	for_each_active_class(class) {
		p =3D class->pick_task(rq, rf);
		if (unlikely(p =3D=3D RETRY_TASK))
			goto restart;
		if (p) {
			put_prev_set_next_task(rq, rq->donor, p);
			return p;
		}
	}
}

If the restarted pass picks a non-server task (for example, if the woken
donor was the only sched_ext task on rq and migrated away so
ext_server_pick_task() returns NULL, or if a stopper or earlier-deadline DL
task is picked), put_prev_set_next_task() -> __put_prev_set_next_dl_server()
will attach the stale rq->dl_server (&rq->ext_server) to next->dl_server on=
 a
non-server task.

Should __pick_next_task() clear rq->dl_server =3D NULL after the restart la=
bel
(or should __pick_task_dl() avoid setting rq->dl_server when server_pick_ta=
sk
returns RETRY_TASK)?

[1] https://lore.kernel.org/r/auTNPtiaPyO9R5NG@gpd4

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031015414.2192=
80-1-tj@kernel.org?part=3D1
