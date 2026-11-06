Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982386;
	b=sLFdDSjtdKe9ekxSu7XTxWmgt5pcRl7hx28zReV9L5B3bJktKd/1RiSWB5eyEtBwHVrF
	 S42joRHb+jqTW43RcxiCnYypwiiw40jWuAiosdSlXKFQ4/dBXTi2bV2Bqknt7WuCG18Tt
	 WlTxx+JxgPRTfUrX+0tHdGY9oOjEwHN6L5WEoLEy605u4ojgQ3sUu/WjS6HJ9SkCDlDnF
	 M0EwmAJXShD5OvGSixiWUlv7TlCnMIzW0sAyk7RqXjHvHw1e3JAZtyWnsuhTvK7XIw8Bi
	 hidsbi3rXv2q/BQp/mFb1dg89/EoB/oDPUrrz6Y/j8tf431gZADPtKqmquoe/Kt6M0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982386;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6+gwqdPWOIDjmUui4M6/kwgrUtcBEmWZC0K9ykQ0dJs=;
	b=Hrz/rJRUejaw7X5md6y0iCc3TWAiiRcO3asEuzDTeUYhi0FiNZhiapguC2xC9bcEbgRu
	 umQ9IcfVavlzHmwkRI9R9lkTBRs8sQHspXbED+zvo+5tomAohvU+G+a59FC9jRrdQ0vBd
	 nPdJOl6h362tLTGXdDRB6tzDrjTSJtIv9y9MtTb+AIP5xDF+gI50gT6/WOjFjYBkZZo7U
	 yWfhXZSJz9rvw40jVFCDIDIsNYjw1OpMAdVjq9x/9NY6Puk3qjYSefi6YMTg6bNMR7rlA
	 PFjBwQQBufGCsyF82lw6G2K9wE2rbXnrqeKbUSpmejoCxwy7a3f9jqnlROQmRPZ7CMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nv5LkjEg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D34606A326
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nv5LkjEg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B011F0089F;
	Fri,  6 Nov 2026 16:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982386;
	bh=6+gwqdPWOIDjmUui4M6/kwgrUtcBEmWZC0K9ykQ0dJs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nv5LkjEg5oHoFTrOLOpBumMbl3M1mtL+3AiTdVBQz403el3HkW5AKOVL/j/96sDrP
	 ZqxE7jsvEO+KvdipHxbn9SlRbVCqJJ2paMDPb2aSEy79JuOGSMgzYEssS+5GK9m303
	 6bgsJJhO/Qmrk/A85xN9fQdicYaM8pG8rjYZnqPOCzEkI+jrEB1oWaR2u4bBwyCLFf
	 9xuTf/egBnhHk019sSWOYsHjnnNdz7/bvW/LB/9rbe5fpqmHokZJO3Ogh+YgZj6ymx
	 wjFt0DzcYOE8b1eq5WxT6Qfr1PJMMSWhwlZaoDXuzzWduvX9xCR15ibQMmVyqFRGxR
	 TUe8TpQS5ngLg==
Message-ID: <sashiko-outbox-201803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/20 v3] sched/fair: Take into account slice in EAS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Guittot" <vincent.guittot@linaro.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261106151947.3991524-20-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-20-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:26:25 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] sched/fair: slice check on idle CPUs in update_best_cpu()
  prefers SCHED_IDLE
--

commit 94c14b8b01a87751cdea1dbf5bbcde621aa150bb
Author: Vincent Guittot <vincent.guittot@linaro.org>

sched/fair: Take into account slice in EAS

This commit updates update_best_cpu() in Energy Aware Scheduling to compare
the waking task's slice against each candidate runqueue's min_slice when
energy costs are equal.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ea117c3d0dd71..da9c4416f1b5c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9885,13 +9885,22 @@ static bool update_best_cpu(struct energy_cpu_sta=
t *target,
>  			    int prev, struct sched_domain *sd,
>  			    struct task_struct *p)
>  {
> +	unsigned long task_slice =3D p->se.slice;
>  	bool target_idle =3D choose_idle_cpu(target->cpu, p);
>  	bool min_idle =3D choose_idle_cpu(min->cpu, p);
> +	bool target_first, min_first;
> =20
>  	/*  Select the one which is idle */
>  	if (target_idle !=3D min_idle)
>  		return target_idle;
> =20
> +	target_first =3D task_slice < get_rq_min_slice(cpu_rq(target->cpu));
> +	min_first =3D task_slice < get_rq_min_slice(cpu_rq(min->cpu));
> +
> +	/*  Select the one where you can run first */
> +	if (target_first !=3D min_first)
> +		return target_first;

[Severity: Medium]
Can this slice comparison prefer a CPU running SCHED_IDLE tasks over a
completely empty idle CPU when both target_idle and min_idle are true?

choose_idle_cpu() returns true both for an empty CPU (available_idle_cpu())
and for a CPU running only SCHED_IDLE tasks (choose_sched_idle_rq()).  On
an empty runqueue, __update_rq_min_slice() resets rq->min_slice to 0, so
task_slice < get_rq_min_slice() is false.  On a CPU with a queued
SCHED_IDLE task, rq->min_slice holds that task's slice, so task_slice <
get_rq_min_slice() is true whenever p->se.slice is shorter.

When both candidate CPUs pass choose_idle_cpu(), execution falls through
if (target_idle !=3D min_idle) and returns at if (target_first !=3D min_fir=
st),
selecting the SCHED_IDLE CPU over a completely idle CPU and bypassing the
prev_cpu and nr_running checks below.  Should the slice check be skipped
when target_idle is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106151947.3991=
524-2-vincent.guittot@linaro.org?part=3D19
