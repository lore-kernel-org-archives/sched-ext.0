Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFDD40DFD0
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815688; cv=none; b=lYSKhWLNaK06A0hKzdse+WI74lrxvgl2C/Oz0P7jXegMW/gnWlk5nCFW5XCjtUSiHnZ8ZjKeiJS0672DfesqOGXzgwWHhP3cefs+ox/C4/GCI7H5ArFVvcMlyNruhIBUc9EJm0U9P+UIf6Qu27Bp1ka14XbrHYr38UHW5S0GUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815688; c=relaxed/simple;
	bh=HK655DXyivJHFfehO/fAQvmDi4Tlp4HRweEqNgHcjJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JtLmP6SR7ZC45j+PeBRCjHUO5L+REaaMjCgAKI08vA1hRoud40WHu2zO7JKk4yK/VhkjqyyqZ4ktTlFbKIS6SzRnTYQVC+XfBIb8zfZsVm3HIKIuRtFeWSD+uNGKas5wln1dYzZlS4PdAnjW6CeGRiTN3h7Zv890mp8RJzAohAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxXpzRsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxXpzRsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3B91F00A3A;
	Tue, 26 May 2026 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815686;
	bh=LC+KCsEUxnJqIB0Qp6fVBEO3DS/LWyFYcfdUbMtqzNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dxXpzRsy7LvfiPR1pQcNJUBkvWG1OLJiUZdVIpl18n8pz77+g/awzsy679SoGTdB8
	 KXcfF751WAaRBusnRZNkkFNlZkXqtoTA9/V38Obywn3TSxhpGEGQDbYAHTLmHIjzu/
	 BKMODDLZMMA+xgm+phIs4h6UO44V+TtrI1cYmOOocpI0GTRLDb8mKTZIEdHejvngNG
	 2F6tF5plhFht5AxSLGbvygg3+/mVyQyPg7nN/lN202fJURx3c5N2ZduinUFwsSMrlj
	 lPs1RJeNWR3sZCT5m9BxqI4MR16DqlA1X8Cf/W+Y66ZyphUSlGv4dcZVS70w78+mGI
	 UFeE+Qou1ya4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Auto-register/unregister dl_server
 reservations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260526164420.638711-2-arighi@nvidia.com>
References: <20260526164420.638711-2-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 17:14:46 +0000
Message-Id: <20260526171446.AE3B91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying a deadline server's parameters via debugfs while its CPU=
 is inactive (offline) corrupts the root domain's bandwidth accounting and =
can trigger a divide-by-zero kernel panic.
--

commit 81a64c3f8b34ea0965999ebcdc61714354b79af3
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Auto-register/unregister dl_server reservations

This commit makes deadline server bandwidth reservations dynamic by attachi=
ng
or detaching them based on whether a BPF scheduler is loaded. This prevents
inactive scheduling classes from artificially holding capacity.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index ddfd6bc63ab1d..90f6589297ac5 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -1893,7 +1904,8 @@ void __dl_server_attach_root(struct sched_dl_entity=
 *dl_se, struct rq *rq)
> =20
>  int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u=
64 period, bool init)
>  {
> -	u64 old_bw =3D init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
> +	u64 old_bw =3D (init || !dl_se->dl_bw_attached) ? 0 :
> +		     to_ratio(dl_se->dl_period, dl_se->dl_runtime);
>  	u64 new_bw =3D to_ratio(period, runtime);
>  	struct rq *rq =3D dl_se->rq;
>  	int cpu =3D cpu_of(rq);
> @@ -1913,7 +1925,8 @@ int dl_server_apply_params(struct sched_dl_entity *=
dl_se, u64 runtime, u64 perio
>  	if (init) {
>  		__add_rq_bw(new_bw, &rq->dl);
>  		__dl_add(dl_b, new_bw, cpus);
> -	} else {
> +	} else if (dl_se->dl_bw_attached) {
>  		__dl_sub(dl_b, dl_se->dl_bw, cpus);

[Severity: High]
This is a pre-existing issue, but can modifying a deadline server's
parameters via debugfs while its CPU is offline trigger a divide-by-zero
panic here?

Looking at dl_server_apply_params(), it retrieves the number of active CPUs
via dl_bw_cpus(cpu) and then passes that to __dl_sub() and __dl_add() when
the server is attached:

dl_server_apply_params() {
    ...
    cpus =3D dl_bw_cpus(cpu);
    ...
    if (init) {
        ...
    } else if (dl_se->dl_bw_attached) {
        __dl_sub(dl_b, dl_se->dl_bw, cpus);
        __dl_add(dl_b, new_bw, cpus);
        ...
}

If the CPU is offline, dl_bw_cpus() can return 0. The helpers __dl_sub()
and __dl_add() perform a division by cpus:

__dl_sub() {
    ...
    __dl_update(dl_b, (s32)tsk_bw / cpus);
}

Wouldn't this result in a direct divide-by-zero if the debugfs file for an
inactive CPU is written to?

Additionally, even if cpus > 0, since inactive CPUs are skipped during
root domain bandwidth rebuilds, does subtracting dl_se->dl_bw from
dl_b->total_bw without a cpu_active() check subtract a value that was
never added, resulting in accounting corruption?

>  		__dl_add(dl_b, new_bw, cpus);
> =20
>  		dl_rq_change_utilization(rq, dl_se, new_bw);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526164420.6387=
11-1-arighi@nvidia.com?part=3D1
