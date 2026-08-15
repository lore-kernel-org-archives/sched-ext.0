Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3427A1E32D6
	for <sched-ext@lists.linux.dev>; Sat, 15 Aug 2026 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786773839; cv=none; b=YrDdAl2ZOB3fnUGMC747Sb28tIwGJNH0TxE81+cM1l2cB6OenTROyu2VoPlC8zFDlTt+ojvvJy3TpPTNN1kDswUWDFK2SVNTR+RzFy2bIMJe+Q1hHphMycQ9NCRtfuwbCBTww95jgHtrjrZAyv0oZm0TYxVcraw8qco7MIu7QLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786773839; c=relaxed/simple;
	bh=pSJuGjlYWa2cYC3Ju7oh+eRwF36+fhC6PB4jF93TI+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ym7U5x4OSXPygkHwMXDp0Tyb1w1WFs1SRPK1/FlNJl3+AjOTzAwsmb1NTyGK9d4+o4Sq5fwvJY32w0SyF8kw0rE6lG1EXuSc2GEoMaSNzJPtAxmLdpSMthM8gY81DD8z2/UaNaDU8e5OyCUQhId0ZnT5LHaexawOPCVx/F8mG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqwhpE8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqwhpE8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C101F000E9;
	Sat, 15 Aug 2026 06:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786773837;
	bh=Wwai/yQA9wCBaLpd6yTepKlk5n/GqojdqGXKqc6xzIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gqwhpE8nDQyoDQGXIgdo177h/oO/Dv0IZ3EbEf8YvVjBqqyFRZeJh93FCF3LMNXdp
	 qmcLk0ijsytrX3ScAUODuUekpd5jRYjskK/s+mmyPAvv8TES2+PdZUOad2NlJuz9NH
	 3RqnNLx/8A9T4E5awdn8AY5DWW4eXXFXermkgu9CmuzpuiMku76lOSLu7BoY/C35Ya
	 kHP85aQiQGAM0LJkS1qLYc7uv/O7cbMq4zBels22EPcqzN9gw6kCGRV+U6e7bAMQCQ
	 sGLBgroS6ts2iOr7O/xkgodw+KUN1u/vVHONCkhIFwm4VbWAjcWhM9xaUa3gwPbAaB
	 fs2ygk3woADOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Drop unlocked scx_rq_clock_invalidate()
 from scx_root_disable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260815055107.115671-2-tj@kernel.org>
References: <20260815055107.115671-1-tj@kernel.org>
 <20260815055107.115671-2-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 06:03:56 +0000
Message-Id: <20260815060357.51C101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but `SCX_RQ_CLK_VALI=
D` can be permanently stranded as 1 during `scx_root_disable()`, causing th=
e next SCX scheduler to read a massively outdated clock via `scx_bpf_now()`.
--

--- Patch [1]: [PATCH 1/2] sched_ext: Drop unlocked scx_rq_clock_invalidate=
() from scx_root_disable() ---
commit c8d4a8f1095e17e1c662f243f67711302652b61f
Author: Tejun Heo <tj@kernel.org>

sched_ext: Drop unlocked scx_rq_clock_invalidate() from scx_root_disable()

This commit drops the unlocked scx_rq_clock_invalidate() call during
scx_root_disable(), relying instead on the rq lock cycle and unlock
path to clear the clock valid flags.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 18183062f751c..40c9467d8b186 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -6162,12 +6162,13 @@ static void scx_root_disable(struct scx_sched *sc=
h)
>  	percpu_up_write(&scx_fork_rwsem);
> =20
>  	/*
> -	 * Invalidate all the rq clocks to prevent getting outdated
> -	 * rq clocks from a previous scx scheduler.
> +	 * Re-balance the dl_server bandwidth reservations: detach ext_server
> +	 * (no more sched_ext tasks) and reinstate fair_server if it was
> +	 * previously detached because we were running in full mode.
>  	 *
> -	 * Also re-balance the dl_server bandwidth reservations: detach
> -	 * ext_server (no more sched_ext tasks) and reinstate fair_server if it
> -	 * was previously detached because we were running in full mode.
> +	 * The rq lock cycle also invalidates each rq's clock (rq_unpin_lock()
> +	 * clears SCX_RQ_CLK_VALID on unlock), preventing the next enable from
> +	 * seeing outdated rq clocks from this scheduler.

[Severity: High]
This problem wasn't introduced by this patch, but is it possible for the
SCX_RQ_CLK_VALID flag to be permanently stranded as 1 during
scx_root_disable()?

The commit message and comment note that rq_unpin_lock() clears the flag
on unlock, and __scx_enabled is turned off later. However, if a concurrent
CPU takes the rq lock after the cycle but before __scx_enabled is disabled,
it seems a race can occur:

CPU N (Normal scheduling):
Takes rq lock
update_rq_clock() sets SCX_RQ_CLK_VALID (since __scx_enabled is still true)

CPU 0 (scx_root_disable):
static_branch_disable(&__scx_enabled);

CPU N (Normal scheduling):
Releases rq lock -> rq_unpin_lock() -> scx_rq_clock_invalidate()
scx_rq_clock_invalidate() in kernel/sched/sched.h checks:
    if (!scx_enabled())
        return;

Because scx_enabled() now evaluates to false, the function returns early and
fails to clear SCX_RQ_CLK_VALID.

When a new BPF scheduler is loaded later, early hooks like ops.select_cpu
that run without holding the rq lock might call scx_bpf_now() and see
SCX_RQ_CLK_VALID =3D=3D 1. Will this cause them to use a massively outdated
clock from the previous scheduler's run?

>  	 *
>  	 * Unlike the enable path, this runs on a recovery path that cannot
>  	 * fail, so we use dl_server_swap_bw() to atomically free ext_server's
> @@ -6180,8 +6181,6 @@ static void scx_root_disable(struct scx_sched *sch)
>  	for_each_possible_cpu(cpu) {
>  		struct rq *rq =3D cpu_rq(cpu);
> =20
> -		scx_rq_clock_invalidate(rq);
> -
>  		scoped_guard(rq_lock_irqsave, rq) {
>  			update_rq_clock(rq);
>  			if (was_switched_all) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815055107.1156=
71-1-tj@kernel.org?part=3D1
