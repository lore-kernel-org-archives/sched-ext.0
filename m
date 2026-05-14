Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1E3A785A
	for <sched-ext@lists.linux.dev>; Thu, 14 May 2026 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731238; cv=none; b=uNpeuOguQRht7cKNGG9r/fg1vyd2Fj7laaVzP0PuHnKOtABeBN6pGPNzlysahufhb0IJVfITX9eTR2EUlVFe2t8vUzAdgZDW8h/gXhdEeCtrrXz8zIk0m7WP+L8Mc8tQ++Vxm+oZNmQK9jc62t6/b74eQJUgWdANi6jhUX/DXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731238; c=relaxed/simple;
	bh=p86kCMhh9dV7MSnwGW+Mf3fPNrvq2LR1NsNorDvzD48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LY/Yugf1Q0aQI1K12WZ8I/v0YivZByIv2yYYb2QwOkcEmsBSMIb5vbishFzX4HeEs2jDzN4IHc28OVsfymZilT1vrXIxYSQLpeO2RDESefiI/odLQW9xyRtOC4F5pe1iAD1cNALDsauxXrMjok7lhhGSC8teN4EUcKi/++NncBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6Pa+Kfl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6Pa+Kfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6D5C2BCB7;
	Thu, 14 May 2026 04:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778731238;
	bh=p86kCMhh9dV7MSnwGW+Mf3fPNrvq2LR1NsNorDvzD48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=b6Pa+KflSaTSsHPacORcPxUOxKMzyGIlzca3dU/mc6EOiSrKpayvEkau+4k9vXW76
	 W1B1e1pHScBfeuE2PJJeZpi+bhrCFM3QNR5JFPN0XTT1uWk/gDg4GwKYM0m2I50EM1
	 Pafe+zp22US4NZdvpmvkB7TIZsVqyGhm6eukMPkNeDnXPtVqdXsWZIDw2BjMdk3iae
	 gbpSBbuuXtIdzaMJoS1ZpUWCTMyuI4IdHw1/vUxbFVFLPVMMUuwcqZ2DomVZVwppgm
	 rYNz499AjrnV6x6DnIwnjjp0gbeArlJ7vGHI7FOFHFCZNWkpOVCCe8TiYJX3PvfGER
	 RO3+zN6ilLlBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Fix spurious WARN on stale ops_state in
 ops_dequeue()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samuele Mariotti" <smariotti@disroot.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260513095329.4029345-1-smariotti@disroot.org>
References: <20260513095329.4029345-1-smariotti@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 04:00:37 +0000
Message-Id: <20260514040038.4C6D5C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Concurrent plain read and write of `p->scx.flags` without proper=
 annotations constitutes a C data race.
- [Low] The newly added `goto retry;` loop lacks a `cpu_relax()` call.
--

commit e9d6f8408ebc8ea1acdd33de496b607223fd733b
Author: Samuele Mariotti <smariotti@disroot.org>

sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue()

This commit resolves a spurious warning in ops_dequeue() caused by a race
with finish_dispatch(). It introduces a retry loop that re-evaluates
ops_state if SCX_TASK_IN_CUSTODY is cleared while the task is still seen
as SCX_OPSS_QUEUED.

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
[ ... ]
> @@ -2035,7 +2036,9 @@ static void ops_dequeue(struct rq *rq, struct task_=
struct *p, u64 deq_flags)
>  		BUG();
>  	case SCX_OPSS_QUEUED:
>  		/* A queued task must always be in BPF scheduler's custody */
> -		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
> +		if (!(p->scx.flags & SCX_TASK_IN_CUSTODY))

The commit message mentions that this read can execute concurrently with
finish_dispatch() on another CPU performing a non-atomic read-modify-write
that clears SCX_TASK_IN_CUSTODY.

Since a plain read racing with a plain write constitutes a C data race,
can this trigger KCSAN splats or allow compiler optimizations like load
tearing?

Should this read use READ_ONCE() or data_race(), and the lockless writer
be appropriately annotated as well?

> +			goto retry;

Since the goto retry creates a spin-wait loop waiting for the other CPU's
memory writes to propagate, is it necessary to include a cpu_relax() call
here?

Standard kernel practice usually requires a cpu_relax() in polling loops to
yield execution resources to HyperThreading siblings and prevent the CPU
from hogging power during a tight spin.

> +
>  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>  					    SCX_OPSS_NONE))
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513095329.4029=
345-1-smariotti@disroot.org?part=3D1
