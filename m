Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35596432BDA
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355876; cv=none; b=HvV7gxZSIaTf8/5ggTCE4AwV1tsix3aU6fWfZLtmafFrk5inl708DjODu0k9uiCi79R7wjCn7tEibFJqMmySx5c//5HBafjU427FGuAuPvX3pUt6nNwBRRc8kq0jNJfAnlIPdc3A2Z1sWLPLmPW9TxSxD+ah+AadDXHffPFbiBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355876; c=relaxed/simple;
	bh=jWBYVDypr9CPBWk43W8I2bopf/bXzcHLaIRybxKPtjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WpXN6K8CajkMM8P2TAjFMpjFfSZWhqKx/DfSX0FSkLjQInzbsbN2yG0qhitg2A9WmwG2zJ5zwB/D2FOWuCrx0We5R5OB8F0neAnLkl8c/GlqUMwJ/CSR3SNFFrcGlolSvIm4oZ1MbMLiXDaX2wwBtax++dtjWhu+zlfWo0Kci3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs3Fzuvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs3Fzuvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8311F000E9;
	Mon,  6 Jul 2026 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783355875;
	bh=K7WWLLfhsJUYHWgOPRIpL/b3wvmhALqnMZPyNlUP18U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xs3FzuvjtXeKBxz6AKycfwSrwXqdcgZlNi+hxDeimNlHi25w10iKNN6ez65JMwI47
	 3Hlpw8xbbLPxgAJp4gu5aerfPbbIppN65J22cfEvY3OZCJWeulFxBYKCR4jnz++zqE
	 jUn2sVeC1sFAX4+Ad6Ge7ItGqy3Vf9k7m5NBxjQMB8OHyUtsg5IOeKQdF8iK1UViHq
	 TIBPUs9M64VIJjdmmaNX4kaAFDImD+hTBJcuAW4atCM8cFSPxzJT1kN7Ly6jviBlRT
	 P4jRzwjNHGSb4Q095+QLScbe8cvESHShDs7tqBMJu0L5I7VF1rGlNoD2KvQqqwa7An
	 190SlM5v2Zbzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Verify nohz_full tick behavior
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706162819.650155-3-arighi@nvidia.com>
References: <20260706162819.650155-1-arighi@nvidia.com>
 <20260706162819.650155-3-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 16:37:53 +0000
Message-Id: <20260706163754.3C8311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Worker processes will spin indefinitely if the test terminates a=
bnormally.
--

commit 5f5f7d1cf8a2f7b2edb91658dc637840224ea1dd
Author: Andrea Righi <arighi@nvidia.com>

selftests/sched_ext: Verify nohz_full tick behavior

This commit adds a regression test to validate proper nohz_full behavior in
sched_ext. It verifies that a finite-slice EXT task restarts the periodic
scheduler tick when it follows an infinite-slice task on a NOHZ_FULL CPU.

> diff --git a/tools/testing/selftests/sched_ext/nohz_tick.c b/tools/testin=
g/selftests/sched_ext/nohz_tick.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/nohz_tick.c

[ ... ]

> +static pid_t start_worker(int cpu)
> +{
> +	struct sched_param param =3D {};
> +	cpu_set_t mask;
> +	pid_t pid;
> +
> +	pid =3D fork();
> +	if (pid !=3D 0)
> +		return pid;
> +
> +	/*
> +	 * Become EXT before touching the target so it stays idle until wakeup.
> +	 */
> +	if (sched_setscheduler(0, SCHED_EXT, &param))
> +		_exit(1);
> +
> +	CPU_ZERO(&mask);
> +	CPU_SET(cpu, &mask);
> +	if (sched_setaffinity(0, sizeof(mask), &mask))
> +		_exit(1);
> +
> +	for (;;)
> +		asm volatile("" ::: "memory");

[Severity: Medium]
If the test runner terminates abnormally before reaching stop_worker(), will
this orphaned child process continue to spin indefinitely?

Since the child runs under the SCHED_EXT policy and is pinned to a specific
CPU, an orphaned child would consume 100% of that CPU indefinitely and
potentially interfere with subsequent tests.

Would it be safer to use prctl(PR_SET_PDEATHSIG, SIGKILL) after forking so
the worker is automatically killed if the parent test process exits
unexpectedly?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706162819.6501=
55-1-arighi@nvidia.com?part=3D2
