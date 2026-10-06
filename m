Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FAB3DDDDD
	for <sched-ext@lists.linux.dev>; Tue,  6 Oct 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298133; cv=none; b=r/cGrcxJeLWz1nSI0YnUsA2e8LSvsKPzTiHljmiwSam4tWQ6clsdiptQ+bDlJgNh/M6B1T93D2yUQJE64aiUaFAH2qh5G94cQT3I20/YuLtyfSnUIxIEJiUWhD7oKms5T2PubxwUoYZeGewtCg0onKh+jeN0Y0eoCb733nvn7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298133; c=relaxed/simple;
	bh=lh+lc2W3C2U0Q2oVFY/hQGFaUopibn3RYOSNgcqU6No=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XmAqSOekU+HujvU1ngeTYqR1Sas4yOhWNdAXsO7/xeK8N638Rjm169oY7J1ueilmUoJrEh/tp+Tb49bbI/KrHUDr386QabCs3qJ9nY+0fPv5DNhFXpjJEaqAU4qyhezmAOqKM6vXo2TL/mt/kKJmxElbA8q9sICbuZ4HW3uPtB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4T0jch/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4T0jch/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AA51F0089B;
	Tue,  6 Oct 2026 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791298132;
	bh=MTDCjwJ+vw0nHW57hHDXsIbFkFw7jE49CuTVTrCG67c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C4T0jch/h7zzw4Cq3WtA+VvWTYUzGyN2jFQumpnCf9QczEKVnpJYXwy+Uo6c17NiN
	 cmgt6JCr9ZzD1qcMB22KlTZ9AoKj4xJ4qTABkAUG9QaqCr42hCCuoeyCu6fFRyYC5F
	 TrbMdyaPD3/uyQYjnnSgRyWTPgikM6AXPaM8CZZpXH3icHfpaxqDR0ph2EqbSnunT7
	 qHGeSx8jTKxkFF/LdG8DN4m4pTXbT8T1PlylMlGErcsgUxde7MrZ8BLdhVXqjNdaSe
	 0/5+o21f+Jx23t0xNJJuUUTYH5a1T89QA53sVbjj548NnrVxJGXXc1DLVDXO5N0pn0
	 hCCad1+xmVPgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] sched_ext: Reset cpuperf_target when a sub loses
 SCX_CAP_PERF or dies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261006142834.2815197-1-cui.tao@linux.dev>
References: <20261006142834.2815197-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 14:48:51 +0000
Message-Id: <20261006144851.E8AA51F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: missing dying scheduler check in scx_bpf_cpuperf_set()
--

commit 44646e483943d4ebcaaab6b95abd7f0ef7f1bd41
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext: Reset cpuperf_target when a sub loses SCX_CAP_PERF or dies

This commit resets the cpuperf_target of a sub-scheduler when it loses
SCX_CAP_PERF or dies. It adds a dying scheduler check to scx_bpf_cidperf_se=
t()
to prevent late writes from polluting the state.

Link: https://lore.kernel.org/sched-ext/20261004012721.615419-1-cui.tao@lin=
ux.dev/

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 0917f05263a37..8b661e9bdf6bb 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -10958,6 +10960,15 @@ __bpf_kfunc s32 scx_bpf_cidperf_set(s32 cid, u32=
 perf,
>  	if (!scx_kf_allowed_ctx(sch))
>  		return -EDEADLK;
> =20
> +	/*
> +	 * Reject writes from a dying scheduler. Its targets have been or
> +	 * will be swept back to the neutral base, but ops.exit() and any
> +	 * late stragglers still run after that sweep - a write there would
> +	 * land after the final reset with nothing left to clean it up.
> +	 */
> +	if (unlikely(atomic_read(&sch->exit_kind) !=3D SCX_EXIT_NONE))
> +		return -EACCES;
> +

[Severity: High]
This correctly prevents a dying scheduler from repolluting targets via the
CID-addressed variant, but should the same check be applied to the
CPU-addressed variant, scx_bpf_cpuperf_set(), defined just above this
function?

Looking at scx_bpf_cpuperf_set() in kernel/sched/ext/ext.c:

    if (!scx_kf_allowed_ctx(sch))
            return;

    scx_cpuperf_set(sch, cpu, perf);

If a dying sub-scheduler executes BPF timers or tracers after the final
cpuperf sweep in scx_sub_disable() but before sch->dead is set, could it use
scx_bpf_cpuperf_set() to bypass this safety gate and repollute
rq->scx.cpuperf_target?

Since the root scheduler remains running, would schedutil permanently consu=
me
this stale low-frequency target and pin the CPU?

>  	cpu =3D scx_cid_to_cpu(sch, cid);
>  	if (cpu < 0)
>  		return cpu;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006142834.2815=
197-1-cui.tao@linux.dev?part=3D1
