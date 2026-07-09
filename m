Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654F390CB3
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 05:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575231; cv=none; b=VhIipgKbk4NeqWWVvnt6fW7m3C72wyDaFRFdqTxWKG23DjlJHqoDdUmaplVDZGolpH2pUsAC0aSij5DPDm7X0fx0WuSMSi2W3IqF/PI/neHgtMJndDPXxE1jHmHVbfbnjZ5xSlkb/o5OMoLxrzrWqXCYolFfgGgvmhE14qbczLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575231; c=relaxed/simple;
	bh=Ff6YRwP3YKxh+3olIAtlE9Yw3vRshnWljQB2Khk/By0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VM1vFQgZQIzJMH7W6g5vpkV0nHkaPVxC4+cE0p4p1AgCsl+bDg5ycH4x0L3qNaZpDbftvis8Tu+ch48HestymkWYMGEJpbKOYDtCXutSefrQSf7OugFMmobtILkHUbgjbkYyUeLT/3fsGbI/mU2b3gwqTSMaJkUmgTV9LhLAxf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI2w/u3b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI2w/u3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905291F000E9;
	Thu,  9 Jul 2026 05:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783575229;
	bh=PhQRlbIuzDPPJPOAOFnEt9hDVrDaZSEg1yWv/UQVHas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bI2w/u3b0I908YS/7xgg3qaQih44Tj1wqtB6LM+MIVZzGvcPwvWsVcOMO5OfEgdjw
	 Ebq6wRjpHwA0IDvq6ANZ9z2HWYJwrI+99YhMw23hbi6FmWDLjRBIVwR5YpkAAipen9
	 5yr4+rM0tCHPGFFzyh3OJ0s/OoSdgXUIrwtJ9dGE8aeIq8sjswnEtaouOK3elcZtTy
	 3IIk3Wg5Op4l34tuoj7fSCo5xrexX3Pn+E2xWuJPjA6JiqlgdYOluTF4SgQ2f1HDGf
	 +9tmmpmsfldJ1QWD8mz6TulSNJdPsUThCpDWCnGoXyliraI8rqsKSNG3zodbXEoKCT
	 pqcKd6j2TeN0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3] sched_ext: Keep rq tracking accurate
 in the consume path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260709051708.306636-1-arighi@nvidia.com>
References: <20260709051708.306636-1-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 05:33:48 +0000
Message-Id: <20260709053349.905291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `scx_locked_rq_state` tracking will be left permanently stale =
on the successful task migration path, directly contradicting the commit me=
ssage's claim.
- [Low] The patch introduces calls to an undefined function or macro `switc=
h_rq_lock()`, causing a compilation error.
--

--- Patch [1]: [PATCH sched_ext/for-7.3] sched_ext: Keep rq tracking accura=
te in the consume path ---
commit 0f65257c6efec221d0687e563233c82e3c63e9c8
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Keep rq tracking accurate in the consume path

This commit attempts to fix a stale BPF runqueue lock tracking issue in
consume_remote_task() by introducing a new switch_rq_lock() helper. It
aims to ensure that scx_locked_rq() correctly follows the lock transitions
between this_rq and src_rq during remote task consumption.

Link: https://lore.kernel.org/all/455e701bca66bdecde530d225f4dba0a@kernel.o=
rg

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 691d53fe0f648..9644c37c87c58 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -2386,20 +2387,22 @@ static bool task_can_run_on_remote_rq(struct scx_=
sched *sch,
>   * On return, @dsq is unlocked and @src_rq is locked. Returns %true if @=
p is
>   * still valid. %false if lost to dequeue.
>   */
> -static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
> -				       struct scx_dispatch_q *dsq,
> -				       struct rq *src_rq)
> +static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
> +					  struct scx_dispatch_q *dsq,
> +					  struct rq *locked_rq,
> +					  struct rq *src_rq)
>  {
>  	s32 cpu =3D raw_smp_processor_id();
> =20
>  	lockdep_assert_held(&dsq->lock);
> +	lockdep_assert_rq_held(locked_rq);
> =20
>  	WARN_ON_ONCE(p->scx.holding_cpu >=3D 0);
>  	task_unlink_from_dsq(p, dsq);
>  	p->scx.holding_cpu =3D cpu;
> =20
>  	raw_spin_unlock(&dsq->lock);
> -	raw_spin_rq_lock(src_rq);
> +	switch_rq_lock(locked_rq, src_rq);

[Severity: Low]
Are we missing the definition of switch_rq_lock() in this patch?

Compiling this throws an implicit declaration error since switch_rq_lock()
doesn't seem to exist.

[ ... ]

> @@ -2410,14 +2413,11 @@ static bool consume_remote_task(struct rq *this_r=
q,
>  				struct task_struct *p, u64 enq_flags,
>  				struct scx_dispatch_q *dsq, struct rq *src_rq)
>  {
> -	raw_spin_rq_unlock(this_rq);
> -
> -	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
> +	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
>  		move_remote_task_to_local_dsq(p, enq_flags, src_rq, this_rq);

[Severity: High]
Does this leave the lock tracking state permanently stale on the success pa=
th?

In move_remote_task_to_local_dsq(), the physical lock is swapped from src_rq
to dst_rq (which is this_rq) using raw spinlocks:

kernel/sched/ext/ext.c:move_remote_task_to_local_dsq()
    ...
    raw_spin_rq_unlock(src_rq);
    raw_spin_rq_lock(dst_rq);
    ...

If unlink_dsq_and_switch_rq_lock() updates the tracking state to src_rq,
but move_remote_task_to_local_dsq() doesn't update it back to this_rq, won't
scx_locked_rq() falsely claim src_rq is still held when returning to the BPF
program?

>  		return true;
>  	} else {
> -		raw_spin_rq_unlock(src_rq);
> -		raw_spin_rq_lock(this_rq);
> +		switch_rq_lock(src_rq, this_rq);
>  		return false;
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709051708.3066=
36-1-arighi@nvidia.com?part=3D1
