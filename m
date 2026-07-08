Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22B3F787B
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547616; cv=none; b=gbi9GZhciw6JvlLmlmPllQdzAPSTp9fWxPxwRd9v0zuMWcsrUNcLO+X8fkxCE/02RAdbuyuPJswpCM845ltSD9U2vbT1B0gYfhBuF5xlU6+gYLLeO5tQb/mJpwiYdcj45tVddi4WPrFZZUcmg4j9MGgzOPEHbWHiKD4e5TLPmZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547616; c=relaxed/simple;
	bh=7jZy96/Ne0nb49kXuzjXz6gZeOjdgEbNjLqVi73wakc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qg3GBJwd5fkS8TCg/YCY62jJH6pyTyn1yvG12CtNopllLGkPfZj45HsMvfdd638CdREAx9DmMUFbwecJ1+5wmIFIEgNvMWpJtti7wDjim7GCdFjh3592WVGDyCjxFUmQY8fWmSCPEYW7bKhbJyKM03sN+l/0NzbAX6a29s/7VRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWp1isKt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWp1isKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747381F000E9;
	Wed,  8 Jul 2026 21:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783547613;
	bh=kn4/oEWZNQPyJ+Xs/LB0E4nOIiM7P8nJk+tdvN6lX3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gWp1isKttBxzBa4vtELRC8OcuV8tYFqH4jK877ejV463Cbk99eacmG7otrv4HpJBr
	 FCoe4cFF+8LdJyo3APHCSq+EYUkXbAml51b0F9mdJgRvKxlHvWMKvOaBKicCIc2h/c
	 Pyg3KDHalIs2pErtXSFcx0riEBrKmJ6pRxmrPdkP/RZuWtgv2dcWJzDFoCN4CPS4PW
	 4PMdF+F44Z0UUvXB6qFIM04KvkuwSldzSQFCceG0iOSoOWszBR6iemWipfhyipUXFe
	 9nz6HK4IWbNU3C1AKjSoHyLP6QO7OJ3SRh682A+ibCbCt5K/sAa1hk6z4GNvA6txTR
	 8f2g+vLv2YoRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 29/40] sched_ext: Route task slice
 writes through set_task_slice()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-30-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-30-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 21:53:32 +0000
Message-Id: <20260708215333.747381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race on a running task's slice (`p->scx.slice`) between the k=
ernel runqueue update and concurrent BPF kfunc execution.
--

--- Patch [29]: [PATCH v4 sched_ext/for-7.3 29/40] sched_ext: Route task sl=
ice writes through set_task_slice() ---
commit 89b48440e365b5adf1131b995d2e06c22b4e11aa
Author: Tejun Heo <tj@kernel.org>

sched_ext: Route task slice writes through set_task_slice()

This commit introduces set_task_slice() and routes BPF-triggered writes
to p->scx.slice through it. This centralizes the writes in preparation for
a later change to handle pending out-of-band slice requests.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -8651,7 +8657,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task=
_struct *p, u64 slice,
>  	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
>  		return false;
> =20
> -	p->scx.slice =3D slice;
> +	set_task_slice(p, slice);

[Severity: High]
This is a pre-existing issue, but does this lockless write to the task's
slice create a dangerous data race with update_curr_scx()?

When a BPF program locklessly calls scx_bpf_task_set_slice() on a running
task, it races with the CPU executing update_curr_scx() under the runqueue
lock. In update_curr_scx(), the slice is updated using min_t():

    curr->scx.slice -=3D min_t(u64, curr->scx.slice, delta_exec);

Because the min_t() macro evaluates its arguments multiple times,
curr->scx.slice can be read once for the comparison, then concurrently
updated to a very small value by BPF, and read again for the subtraction.
This could result in an integer underflow, giving the task a near-infinite
slice and potentially monopolizing the CPU.

Since the commit message mentions this is in preparation for a later change
that handles out-of-band slice requests, does that subsequent change
mitigate this data race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D29
