Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71AD41A795
	for <sched-ext@lists.linux.dev>; Mon, 14 Sep 2026 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376518; cv=none; b=tKuZlC/Sr6v/+GEcAUZleVW9lNd2WGOdT6VZjZZEri9F7rIBUCHBRtgBjlab5MYiodI/g+T4T11cqljdstP+KWr0WglMwiptX4/Jr6JWYMfVjevyZzKExuE/9eAHG2LB5PTqO35/q2QOhvSQJtOzGK0WIP3rXgU38NN7Uy0U/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376518; c=relaxed/simple;
	bh=T2MGmIXh2FyhXL2wfuFNxh/yfpGKGDMUIB0VWnPadfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sahSA1UBF/SwUqLeJs+UFpsUAsDTNrUiPRUYvLqGrDuyMfhx0Y2OMKq5ztwx06GcJnFSHEJCvd4oPpDe/OR8anEiMY5gwbbvK291frt98rMu0YFqGQFs1N2eMMv3fm8lFB5AXNT1pgFeWIjOUGe+fEiU/LBBKwKDJAnkd0pRv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF64YC41; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF64YC41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2901F000FF;
	Mon, 14 Sep 2026 09:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789376516;
	bh=I+6JGVfr3dv6ld6I8HLlTdbJIT/WkOrBe2FXg6D0vGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PF64YC41sDYVZg4lYIruuiqGHEuZU5TdrPtvnWAayOokxjLGr6JQ0fUEEBbdMwNQM
	 Rbq/rdjA/05z2D71JZfGN6fGGeLLqAW1lUnY9v3mvLo3NbWPiTYP1MLY60qOtPq23t
	 xQiJed5CYrLuHDsMQYe6GNba0Yoikqvw5n7SY9d7/A/WjUlJicSwJFXEPUn51Rxl3Y
	 K0UWd5MEFiFMcXeHQ5XcPgwmdzLOyk41/GDNUq4rALIic0W1/2kneE8hUeE+Ju9Bst
	 r7pT6DeqGb1ZOtODOxr/l60LOA+o3Mc61BkyLAIr0uOBNhCcywZK1oSQ5uOVORrIBb
	 sGCQk1ewkCf9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add lazy preemption tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260914084955.1798562-3-arighi@nvidia.com>
References: <20260914084955.1798562-1-arighi@nvidia.com>
 <20260914084955.1798562-3-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:01:55 +0000
Message-Id: <20260914090155.DE2901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing PR_SET_PDEATHSIG in spawned victim tasks leads to orphan=
ed tasks spinning at 100% CPU.
- [Medium] The wait condition for `nr_lazy_victim_running` hardcodes a targ=
et value without accounting for intermediate preemptions, causing test flak=
es.
--

commit 027a94072433d755727d58cbb128013210dcb223
Author: Andrea Righi <arighi@nvidia.com>

selftests/sched_ext: Add lazy preemption tests

This commit adds trace-based coverage for immediate and lazy preemption. It
tests kick requests individually and combined, and extends the NO_HZ_FULL
test with infinite-slice victims.

> diff --git a/tools/testing/selftests/sched_ext/kick.c b/tools/testing/sel=
ftests/sched_ext/kick.c
> new file mode 100644
> index 0000000000000..3fa112a1de607
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/kick.c
[ ... ]
> +static struct victim spawn_victim(int cpu)
> +{
[ ... ]
> +	victim.pid =3D fork();
> +	if (!victim.pid) {
> +		cpu_set_t mask;
> +
> +		close(ready[0]);
> +		close(start[1]);
> +		CPU_ZERO(&mask);
> +		CPU_SET(cpu, &mask);
> +		if (sched_setaffinity(0, sizeof(mask), &mask))
> +			_exit(1);
> +		if (write(ready[1], &byte, 1) !=3D 1)
> +			_exit(1);
> +		close(ready[1]);
> +		if (read(start[0], &byte, 1) !=3D 1)
> +			_exit(1);
> +		close(start[0]);
> +		for (;;)
> +			asm volatile("" ::: "memory");

[Severity: Medium]
Will this lead to orphaned tasks spinning at 100% CPU if the test runner
crashes?

If the test is forcefully terminated or crashes before stop_victim() is
called, the child processes will be orphaned and continue their infinite lo=
op
indefinitely.

Should prctl(PR_SET_PDEATHSIG, SIGKILL) be used here, similar to how it is
used in spawn_gated_worker() elsewhere in this patchset?

> +	}
[ ... ]
> diff --git a/tools/testing/selftests/sched_ext/nohz_tick.c b/tools/testin=
g/selftests/sched_ext/nohz_tick.c
> index 028f54391c2ca..a5266a5412935 100644
> --- a/tools/testing/selftests/sched_ext/nohz_tick.c
> +++ b/tools/testing/selftests/sched_ext/nohz_tick.c
[ ... ]
> +	/* Repeat with a lazy kick delivered from a housekeeping CPU. */
> +	__atomic_store_n(&skel->bss->phase, NOHZ_PHASE_LAZY_KICK,
> +			 __ATOMIC_RELEASE);
> +	victim =3D spawn_gated_worker(ctx->test_cpu);
> +	challenger =3D spawn_gated_worker(ctx->test_cpu);
> +	trigger =3D spawn_gated_worker(ctx->housekeeping_cpu);
> +	if (victim.pid < 0 || challenger.pid < 0 || trigger.pid < 0) {
> +		SCX_ERR("Failed to spawn lazy-kick workers");
> +		goto out;
> +	}
> +	skel->bss->victim_pid =3D victim.pid;
> +	skel->bss->challenger_pid =3D challenger.pid;
> +	skel->bss->trigger_pid =3D trigger.pid;
> +	if (!start_gated_worker(&victim) ||
> +	    !wait_for_counter(&skel->bss->nr_lazy_victim_running, 2,
> +			      PHASE_TIMEOUT_MS)) {

[Severity: Medium]
Could this wait condition cause the test to flake by relying on an absolute
counter value?

During the teardown of the previous phase (NOHZ_PHASE_LAZY_ENQ), stopping t=
he
challenger can allow the original victim to be rescheduled, incrementing
nr_lazy_victim_running to 2 before this new phase begins.

If that happens, wait_for_counter() will return immediately here, and the t=
est
will proceed to launch the new challenger before the new victim is running.=
 If
the new challenger is scheduled before the new victim, the subsequent check=
 on
nr_lazy_kick_running can fail.

Should this wait condition account for intermediate preemptions instead of
hardcoding 2?

> +		SCX_ERR("Lazy-kick victim was not scheduled");
> +		goto out;
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914084955.1798=
562-1-arighi@nvidia.com?part=3D2
