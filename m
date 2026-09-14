Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188A4779A8
	for <sched-ext@lists.linux.dev>; Mon, 14 Sep 2026 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397968; cv=none; b=auvnJnVppL3bDvu6WnW0LJyoHTJSx9dwrpHNsGnbW4vxdIH2zQ2TaIihdsoSsiHgKrkVPPoGNm6q2RSWzV85d43kJNTtR1rtq0yWdHKC2bVXUA+TWBAd7rVOQUlQjrIpdE+PH7WFyP0yV+rbe5NKM0IOqQMVwild3ZOWqWvlQnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397968; c=relaxed/simple;
	bh=5fofTbYN35pCB5eba2s6esOfF5IY7fODgz4mnlpxsDY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OOMIPMesfgWt5tciI2umxCMkd0M2YH6w/CPBOx1oDTMZ8NDvLIoYh4k3e+bm2BKukThDzbwa0CPHxaWTSjm7KLUfOmtf6dpQesEBZGkosVLlhKDAPniHtRJyPQLGuSw9XLomfvuQpI2NYE6xwB7pi+IdJ9mv3u+yOsFyDzw8thg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxjghqI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxjghqI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49B91F008A7;
	Mon, 14 Sep 2026 14:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397966;
	bh=CG55sEWExhXJWniI0gBhZVmI2/qoDXCRK07ANhAWtPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxjghqI6Sm0aQE/BWe+XTxaARFy77SqH519iFDplbaLoGMFA28aluOUwUT+Xmi2gB
	 YN1RE5nNEgOUOu9LsRkXPmPInm3yBRvrhIYW74H+BeVZuZg2Z5TTNyIO98OaNktkGw
	 HQYksszs7TgiaPAYsddxr9iHrqp/GyloE8G9fyCRljduSlVeU+CI1NWiQO2IM0WaBP
	 l94cjw0ZDfZuBh9MtImnv6JH9JwcTeD7s/l/hdYoHyOKHCRpvjd6MAQg2okZGU2lul
	 p7M8ZSL66W2z45GYe7FPQchtoe3FukIzskpP84NphrJc5RXkTGNaVvssIhCoa+qRHT
	 HJzOb8Wkrv6xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add lazy preemption tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260914144620.2032614-3-arighi@nvidia.com>
References: <20260914144620.2032614-1-arighi@nvidia.com>
 <20260914144620.2032614-3-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:59:25 +0000
Message-Id: <20260914145925.E49B91F008A7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The ENQ_BOTH scenario in the `kick` selftest hangs indefinitely =
on single-CPU systems due to starvation of the main test process.
--

commit 54a68e6d559e121241b4e1714f59dcb8d2d45246
Author: Andrea Righi <arighi@nvidia.com>

selftests/sched_ext: Add lazy preemption tests

This commit adds trace-based coverage for immediate and lazy preemption.
It exercises kick requests individually and combined, and extends the
NO_HZ_FULL test with infinite-slice victims.

> diff --git a/tools/testing/selftests/sched_ext/kick.bpf.c b/tools/testing=
/selftests/sched_ext/kick.bpf.c
> new file mode 100644
> index 0000000000000..03ddc44faf5c4
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/kick.bpf.c
[ ... ]
> +void BPF_STRUCT_OPS(kick_enqueue, struct task_struct *p, u64 enq_flags)
> +{
> +	switch (scenario) {
> +	case ENQ_BOTH:
> +		if (p->pid =3D=3D victim_pid) {
> +			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_INF,
> +					   enq_flags);
[Severity: Medium]
Will this assignment of SCX_SLICE_INF to the victim task starve the main
test process and hang the test indefinitely on single-CPU systems?

When the main test process shares the CPU with the victim, its usleep()
timer wakeup inadvertently consumes the KICK_STATE_QUEUED state, advancing
the test state to KICK_STATE_DONE. When it sleeps again inside
wait_for_state(), it is awoken but enqueued into the global DSQ without
preemption flags (since the state is no longer QUEUED). Because the victim
task runs with SCX_SLICE_INF, it is never preempted by the tick, starving
the main test process forever.

> +		} else if (state =3D=3D KICK_STATE_QUEUED) {
> +			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
> +					   enq_flags | SCX_ENQ_PREEMPT |
> +					   SCX_ENQ_PREEMPT_LAZY);
> +		} else {
[ ... ]
> diff --git a/tools/testing/selftests/sched_ext/kick.c b/tools/testing/sel=
ftests/sched_ext/kick.c
> new file mode 100644
> index 0000000000000..b7af2683c2728
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/kick.c
[ ... ]
> +static enum scx_test_status trace_one(u32 scenario, u64 ops_flags,
> +				      s32 slice_expiry_override,
> +				      struct observation *obs)
> +{
> +	struct bpf_link *ops_link =3D NULL;
> +	struct kick *skel =3D NULL;
> +	struct victim challenger =3D { .pid =3D -1, .start_fd =3D -1 };
> +	struct victim victim;
> +	enum scx_test_status ret =3D SCX_TEST_FAIL;
> +	int cpu =3D pick_target_cpu();
[Severity: Medium]
Should we migrate the main test process away from this target CPU, or skip
the test if a second housekeeping CPU is unavailable (similar to the
behavior in nohz_tick.c)?

If the main test process runs on the same CPU as the victim task, it can be
starved by the victim task receiving an infinite time slice during the
ENQ_BOTH scenario, causing the test to hang indefinitely.

> +
> +	if (cpu < 0) {
> +		SCX_ERR("No available CPU");
> +		return SCX_TEST_FAIL;
> +	}
> +	victim =3D spawn_victim(cpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914144620.2032=
614-1-arighi@nvidia.com?part=3D2
