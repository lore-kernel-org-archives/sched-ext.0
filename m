Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E734391E66
	for <sched-ext@lists.linux.dev>; Mon,  8 Jun 2026 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904606; cv=none; b=mxbQ6G8HphPKgDbaEu3MiooKQntzE8VYs+PgyadMn1oPN3zZ2nQmA9f4iOV95MVKbUvBxy4uTWbsPhreblXxoB0sfYcujuT802TYBW6ehwUyzuGtluZxwcUS1M/MUZiaQzEtke1+mZhqRXs6vC+BVVHk5g4mvCVkHEkjRQ6GJ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904606; c=relaxed/simple;
	bh=Uc2IPWmo1vBPV7GPJI3MvSIOlBAMTY4cNg8rRqUcBGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YElucztw1XcLPmP8zHy1zBQyj6t/369OKN7C46BuluGalQhv+5VesE3pgsZVK+VQo21VpReoZGGX5RYn/jXvkt2miBE0d0wSMZYKSmpdjNXRq0XX+5BfDAAURfgBpfvsDgL6QSrcIPnl9yUFbAFJqYyjFN+8ustsW1WRX5/wzuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCw4hcm6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCw4hcm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADC31F00893;
	Mon,  8 Jun 2026 07:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780904605;
	bh=EvgsvjVh0ACSGkFasTK4a/Ucn1nV1qE45iAfHU1rnbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UCw4hcm6wcOjgABt3lv/z1pXnaSGSo4bkQDleirkK2gTUfDzUe73yPOB0gGlqaxeY
	 Nl0+25VIvcskdAkIYygQKSD3titn6fUIn37wTOF1DLW1yHACf5nYufTdQXUhFzgOdh
	 MA9rPUjX+pj2X6OjelzJ8YXPTQNCMy9sUpcQF0GZBVb5Su8oxG+cnlGquVufuiNjMq
	 XuEIN9SaQvcZEIkbf3H36kmuzzKML0hxS6ZQblktMCMu7qVo99DseTZ6z+T54/s1g6
	 G9uOmbQDD7DPCZY7YYm5TAqTATGha8L9j5u5BmBBNujSTOg4Oha6Ic9ZsUHcPX+ATg
	 VBY6WwHVyCTFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] sched_ext/scx_flatcg: Fix cvtime_delta race and add
 hweight scaling to bypass charging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanwu Li" <liwanwu9113@163.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260608072457.3-1-liwanwu9113@163.com>
References: <20260608072457.3-1-liwanwu9113@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 07:43:23 +0000
Message-Id: <20260608074324.5ADC31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] In `fcg_dispatch()`, unused slice time is calculated with inve=
rted logic and unsigned division on a wrapped-around integer, severely corr=
upting cgroup virtual time.
--

commit 037c76e7851e9209a73d28f57c667ccb6303434e
Author: Wanwu Li <liwanwu@kylinos.cn>

sched_ext/scx_flatcg: Fix cvtime_delta race and add hweight scaling to bypa=
ss charging

Fixes a cvtime_delta atomic read-clear race in cgrp_cap_budget() by replaci=
ng=20
__sync_fetch_and_sub() with __sync_fetch_and_and(). It also scales execution
time by cgroup hweight in the fcg_stopping() bypass charging path.

> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatc=
g.bpf.c
> index fec3595818269..0fd214cc61dae 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
[ ... ]
> @@ -570,7 +570,8 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct =
*p, bool runnable)
>  	cgc =3D find_cgrp_ctx(cgrp);
>  	if (cgc) {
>  		__sync_fetch_and_add(&cgc->cvtime_delta,
> -				     p->se.sum_exec_runtime - taskc->bypassed_at);
> +				     (p->se.sum_exec_runtime - taskc->bypassed_at) *
> +				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
>  		taskc->bypassed_at =3D 0;
>  	}
>  	bpf_cgroup_release(cgrp);

While reviewing this fix, I noticed a similar pre-existing issue in fcg_dis=
patch():

tools/sched_ext/scx_flatcg.bpf.c:fcg_dispatch() {
    ...
		__sync_fetch_and_add(&cgc->cvtime_delta,
				     (cpuc->cur_at + cgrp_slice_ns - now) *
				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
    ...
}

[Severity: Critical]
This is a pre-existing issue, but does this calculate unused slice time with
inverted logic and an unsigned division on a wrapped-around integer?

In try_pick_next_cgroup(), a cgroup is charged its full slice upfront.=20
Here in fcg_dispatch(), unused time is seemingly refunded by adding=20
(expected_end - now) * ... to cvtime_delta.=20

However, if yielding early (expected_end > now), this adds a positive value=
 to=20
cvtime_delta, which ultimately increases cvtime, heavily penalizing the cgr=
oup=20
instead of refunding it.

Conversely, if a cgroup overuses its slice (now > expected_end), the unsign=
ed=20
subtraction underflows to a massive u64.=20

When multiplied by FCG_HWEIGHT_ONE and divided by hweight via unsigned divi=
sion,
it yields an enormous positive number. Adding this huge value to cvtime_del=
ta=20
pushes the cgroup's virtual time roughly 3.25 days into the future, permane=
ntly=20
starving it.

Should the time delta be properly ordered (e.g., now - expected_end) and bo=
th
operands to the multiplication and division be cast to signed 64-bit intege=
rs=20
(s64) to preserve negative values through the division?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608072457.3-1-=
liwanwu9113@163.com?part=3D1
