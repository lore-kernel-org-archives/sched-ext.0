Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73898324B31
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254634; cv=none; b=f0fl1G5QYRIVKfPMbL5TCA112xqbJXvw8vOHcfo9nehyI4URU6NaIBX14Ur3pB3MdBimCgjlQyEwxy/qgCKezxy97muUzJPopu4xXbiZfthChWqm1Yjd3Bq240FU8DgEJRWbVkmY4/9VoqKZWdYfXfPcxSjtIJ/okZENSMzM7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254634; c=relaxed/simple;
	bh=ELl/BHys+wzKK4RG2W0nkUrBsKapTPzF/PMjShrWS2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NPCwV3q8dShXB5Viz5BmhhGABscbh6nGMLPKIR4CUYQJFc+UZwrnpCxPK7/fPYNfFh57mhyMWfLEowkDmLFIV5vIf37oR5I9L7rqTS4Z0X9wSmp5Yd2KOYduqHesmke7iJj9HlH/9tMi3uyZoU6GsPMh+irBDBN9zuKxWhJPMTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyY2w8Pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyY2w8Pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52571F000E9;
	Tue, 28 Jul 2026 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785254633;
	bh=mVjBNDRpLsItA0+kG3hD6GzldcVF7sntL6yTJQdt69g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CyY2w8PevXYa2kkJG9NIct/6a4J9QOHewuhAy5h3LoM7cfVs4BOiboZKLCaAJA6OJ
	 0MAnCCa2N4SX8GYQB/ViDnFKkEqUIJ+QKNNObdghnqUNhH5n4s4wbKdL33ciBzICuM
	 aYDHwp31K74tz0lyKpVSgeyNHv16aSDdxQ7z2eDQ5vy70msp1J8G1U7uPuJRkEEVdr
	 jfQP4c5JL7RlGwY78YA79lp0a28HFYZnW35oXqA7tFUu9uRItB6smUmws2lnxoTBA4
	 vklY2evlhSJLbrP/9fNke6Ih1tUIkL8KWzbqp6onNsDXSXfAhmnAq6d2TzN39LNMR6
	 SF3y/WdsnG1Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/15] sched: Skip class callbacks with
 SCHED_FLAG_KEEP_PARAMS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260728154425.1549660-5-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-5-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:03:52 +0000
Message-Id: <20260728160352.D52571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Using SCHED_FLAG_KEEP_PARAMS with a new SCHED_DEADLINE policy on a=
 non-deadline task causes a permanent deadline bandwidth leak in the root d=
omain.
--

--- Patch [4]: [PATCH 04/15] sched: Skip class callbacks with SCHED_FLAG_KE=
EP_PARAMS ---
commit 7456fab35f0046cf8daada3381577cde13d7dbe1
Author: Andrea Righi <arighi@nvidia.com>

sched: Skip class callbacks with SCHED_FLAG_KEEP_PARAMS

SCHED_FLAG_KEEP_PARAMS suppresses scheduler parameter and class changes,
but __sched_setscheduler() can still set DEQUEUE_CLASS when the class
computed from the requested policy differs from the task's current class.
This commit sets DEQUEUE_CLASS only when SCHED_FLAG_KEEP_PARAMS allows
the class to change.

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index b215b0ead9a60..903b47f5d0b74 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -675,7 +675,8 @@ int __sched_setscheduler(struct task_struct *p,
>  	prev_class =3D p->sched_class;
>  	next_class =3D __setscheduler_class(policy, newprio);
> =20
> -	if (prev_class !=3D next_class)
> +	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) &&
> +	    prev_class !=3D next_class)
>  		queue_flags |=3D DEQUEUE_CLASS;
> =20
>  	scoped_guard (sched_change, p, queue_flags) {

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but does using SCHED_FLAG_KEEP_PARAMS with a new SCHED_DEADLINE policy on a
non-deadline task cause a permanent deadline bandwidth leak in the root
domain?

When a user with CAP_SYS_NICE calls sched_setattr() with
attr.sched_policy =3D SCHED_DEADLINE and SCHED_FLAG_KEEP_PARAMS on a
non-deadline task, sys_sched_setattr() fetches the current parameters:

sys_sched_setattr()
    if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
        get_params(p, &attr, 0);

This can replace attr.sched_runtime with the task's current fair slice while
leaving attr.sched_period user-provided, constructing a valid deadline rati=
o.

Earlier in __sched_setscheduler(), this requested bandwidth is validated and
permanently added to the global root domain accounting via __dl_add() inside
sched_dl_overflow():

    if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, a=
ttr)) {

However, because SCHED_FLAG_KEEP_PARAMS is set, the parameter and class
transition is skipped further down inside the scoped_guard block:

    if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
        __setscheduler_params(p, attr);
        p->sched_class =3D next_class;
        p->prio =3D newprio;
        __setscheduler_dl_pi(newprio, policy, p, scope);
    }

Since the task remains non-deadline and p->dl.dl_bw remains 0, when the task
eventually exits, it will subtract its dl_bw (0) instead of the allocated
bandwidth, leaving the globally added bandwidth permanently leaked.

Is there a way to prevent sched_dl_overflow() from allocating bandwidth if =
we
know SCHED_FLAG_KEEP_PARAMS will skip the parameter updates?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728154425.1549=
660-1-arighi@nvidia.com?part=3D4
