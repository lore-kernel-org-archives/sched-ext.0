Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5643C4557
	for <sched-ext@lists.linux.dev>; Mon,  8 Jun 2026 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927874; cv=none; b=IOZzcZXdOT0j1WwppllU8F+lrZlZ8OXZ4l5+ZDY8Ap9/yf3Tp0JsMBdWrlHijTtRNdtO5VCh1Ya9+9uW6NYpH/9tomApESnugpWtMSqA09bcznZRr9wwEZOWEHuryaOOUM1/yrphlbtp+q0Bl6lWYnUdFogtJnlry7UsbMFrvcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927874; c=relaxed/simple;
	bh=MTdeWwq5rM4/E6maR0dPPZnp9KXiSYrrOfJ1uZIahCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r8439u418YFKRn3jE3PAIbRyloZego9Ot9RFJL1VjQWyMkh4dChHAEp4NDh4Jam4beFCeEe45H8McJLMDVKDmhwLujdit5Dr/wjaVLTCLqTZClcS5SAFDE9tUbJ+o/KQpt+s2pOiabT48uDtKmuZqwEU9snjqvhQYi1MfAbUuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi0NcZ5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi0NcZ5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A621F00893;
	Mon,  8 Jun 2026 14:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780927872;
	bh=u92cG9e7+7hdUt6XY1wt5Av6WSO4TdBiynCepx5jWyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qi0NcZ5IH+KvosCiPyVYhilgldPxbyDhf9kgQkiQ+DIlCoFmOu9VTnCHhBN2GPlZZ
	 W2dMoow3aAGl/ETPiVhsFusDhxe3OGFOjgQYeu+WA4ZO5ulFOm5A+oF95RxaP/AyUK
	 GPSip9H5EiZE5qgVcQNKUfpn7UsXDrA3NenZ0renocteZ+brROntoNfn+wLs6NiZDY
	 HhvCV81Phoa6JWzoYMy0F9iC36O3/ipAZ3kXlrKcdnAWeqISpEUPr2BR46DHEAe520
	 Vn+Ib9qtNfHiz1LE+0svd/Di3DrJtJZtsFUwy/qWcf0y0uG1qJ7L6bzaXgTNmH3rZl
	 e8/YDZ1S1ss4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Reset dsq_vtime and
 slice when a task leaves SCX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260608134908.3232097-1-arighi@nvidia.com>
References: <20260608134908.3232097-1-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 14:11:11 +0000
Message-Id: <20260608141112.56A621F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Tasks returning to the SCX scheduling class receive a zero slice, =
violating the intended baseline and causing immediate slice expiration.

Pre-existing issues:
- [High] Tasks with an explicit SCHED_EXT policy retain a stale `dsq_vtime`=
 across global BPF scheduler unloads and reloads, leading to corrupted task=
 prioritization.
--

commit 7f8eecaba1a8e23922f489ed563df593e55f3478
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Reset dsq_vtime and slice when a task leaves SCX

When a task switches out of the sched_ext class, p->scx.dsq_vtime and
p->scx.slice keep whatever values they last held. This patch zeroes
dsq_vtime and slice in switched_from_scx() after scx_disable_task() so
the fields are reset to the same baseline a freshly forked task has.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index bd8a3332999f4..38157af00fb77 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
[ ... ]
> @@ -4097,10 +4097,11 @@ static void switched_from_scx(struct rq *rq, stru=
ct task_struct *p)
>  	 * scx_disable_task() would WARN on the non-%ENABLED state and trigger a
>  	 * NONE -> READY validation failure.
>  	 */
> -	if (scx_get_task_state(p) =3D=3D SCX_TASK_NONE)
> -		return;
> +	if (scx_get_task_state(p) !=3D SCX_TASK_NONE)
> +		scx_disable_task(scx_task_sched(p), p);
> =20
> -	scx_disable_task(scx_task_sched(p), p);
> +	p->scx.dsq_vtime =3D 0;
> +	p->scx.slice =3D 0;

[Severity: High]
Does zeroing the slice here mean a task returning to the SCX scheduling cla=
ss
will receive a zero slice?

If neither switched_to_scx() nor __scx_enable_task() resets it to
SCX_SLICE_DFL, it seems this violates the commit's intent of restoring the
baseline of a freshly forked task.

Will entering the BPF scheduler with a 0 slice cause the core to emit a
warned_zero_slice warning and trigger immediate slice exhaustion upon
dispatch (falling back to a 1 nanosecond slice)?

[Severity: High]
This isn't a bug introduced by this patch, but does the approach of clearing
dsq_vtime here miss tasks during global BPF scheduler unloads and reloads?

If tasks have an explicit SCHED_EXT policy, they remain in the ext_sched_cl=
ass
when a custom BPF scheduler is unloaded. During scx_root_disable() and
scx_root_enable(), old_class =3D=3D new_class evaluates to true, so
switched_from_scx() is never invoked and dsq_vtime is never cleared.

When the new BPF scheduler is loaded, will these tasks retain the dsq_vtime
from the previous scheduler, causing incorrect sorting and prioritization in
vtime-sorted dispatch queues?

>  }
> =20
>  static void switched_to_scx(struct rq *rq, struct task_struct *p) {}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608134908.3232=
097-1-arighi@nvidia.com?part=3D1
