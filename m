Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23773A543A
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462701; cv=none; b=TE0tMA4WZ1SPyaBBZvtohU1wPj8m2ksnsAUuJwGR+Gn8/PyttznX91qOOsC//tc6UY+3Xbi6YIk94T3X30FM7Uhxov4vc/SVcyvkMIjcu5XhZ2hF58Vh8ubgWgQjoLQdEfe+fWPHNGghTch+Bex3MLEKSKrLNW2OAoHfxOF0f1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462701; c=relaxed/simple;
	bh=b7l2j3iX9UNPXDgi2NkddszgZN46eKSX2k7BI0IwtKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LP1ZIUF3Z/2N0wcvyavSV8vXw90jWHEO+dL1y24ZI+HXDqPbvEBlBCTHRiKJBqAHSXy+ipwzaMXSP5WM7teEmmShczxEdL+b5tYTMhua1az4rwVJaPb+ycyWL+vegeNa2slXM+VoyJRozds9PtVYkp4uIXmkIJyEGD69bV6t7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJqbsO89; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJqbsO89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB991F000FF;
	Tue, 15 Sep 2026 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789462699;
	bh=6PXnB+5e87PtT/WcNSKHjRi/z0JZAZYOT2NgQJnHA4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CJqbsO89gI8nqWcTLnEDnnGDmYHFAhB3OFFYGpFMjZjiU0olHaFAWqEZFb+l/z0wR
	 0+4aAHmUbhoMLxaM8K4Oomb/KG2y5tdAqJZMoIDttuxUhwmAnhK0RGz+ch2meQO98F
	 Kff9n9Bp042OUPf6jyCov7Av5/jj02AurCbe4uEcXRMlafCZYCk2CIu2V1iXP6f/zM
	 3XCKvhpbD306f4N3ehSfVkmTMQPPDXLOF6YrmUdmx4wV8AyvDBt2qZf550mvY6cZ/8
	 m8pWas13n4aZ7nQzH/KRImFPHlcIXptCQoKfurNwKyYutvunOTRhbCpUa+8nzn5y5E
	 e0IVJM0NmryRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Maintain an online cid mask in the
 scheduler arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260915082725.3881071-3-tj@kernel.org>
References: <20260915082725.3881071-1-tj@kernel.org>
 <20260915082725.3881071-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:58:18 +0000
Message-Id: <20260915085819.5DB991F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sched_ext: bit corruption in online_cmask on 32-bit big-endian a=
rchitectures
--

commit caa3d27a5f1591e49ffdf405f84e61f1f37a10f5
Author: Tejun Heo <tj@kernel.org>

sched_ext: Maintain an online cid mask in the scheduler arena

This commit adds a kernel-maintained online cid mask in the scheduler's
arena for child schedulers. It populates this mask after the cid mapping
is finalized and tracks online/offline states based on hotplug notification=
s.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 10af28a9f2c0c..7fbef7f11d3ae 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -3663,8 +3663,20 @@ static void handle_hotplug(struct rq *rq, bool onl=
ine)
>  		s16 *tbl =3D rcu_dereference_check(scx_cpu_to_cid_tbl,
>  						 lockdep_is_cpus_held());
> =20
> -		if (tbl)
> +		if (tbl) {
> +			struct scx_sched *pos;
> +
>  			cpu_or_cid =3D tbl[cpu];
> +
> +			guard(raw_spinlock_irqsave)(&scx_sched_lock);
> +			list_for_each_entry(pos, &scx_sched_all, all) {
> +				struct scx_cmask *mask =3D pos->online_cmask;
> +
> +				if (mask)
> +					__assign_bit(cpu_or_cid, (unsigned long *)mask->bits,
> +						     online);

[Severity: Medium]
Does casting mask->bits to an unsigned long pointer corrupt the bitmask
layout on 32-bit big-endian architectures?

Since mask->bits is declared as a u64 array in struct scx_cmask, BPF
programs expect a standard 64-bit integer bit layout. However,
__assign_bit() operates on native words. On 32-bit big-endian systems,
the most significant 32 bits are at offset 0, meaning __assign_bit(0)
modifies bit 32 of the underlying u64 instead of bit 0.

This would cause BPF programs to observe bit cpu_or_cid + 32 toggled
instead of cpu_or_cid, which could lead to dispatching tasks to offline
CPUs or starving tasks on online CPUs.

> +			}
> +		}
>  	}
> =20
>  	if (online && SCX_HAS_OP(sch, cpu_online))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915082725.3881=
071-1-tj@kernel.org?part=3D2
