Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13E340260
	for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869162; cv=none; b=enfJykNSNVgn636+Slf5HKNy5aIFHuGQoRAcZJjsgtIQr3vS6F06h8gVCKQux9MPVHkwk34CLnLhVAbS6NuMyReutYmd7pArg0uVROMx4OcuHUNxrVvw984lDOwKxSQetGeg0iUU1AhJ8rLHHtaLaKtLun3motkGhRMILrlE1Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869162; c=relaxed/simple;
	bh=r2nMjiqDT8YWUVHzax2E5uphUG9fS75M2OMmRMdvLWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EhIMel1Q7DbnGVNQbZwZiredeh2bjOPG65RXEcTMlJt4DLctydW86n3i790QocFVjHNbiyZD3TVP/nmdcMqmcK3fvdgpjIbO4zFpkmxoYiyTx4JhzrSgKmjoXhdZBTVgJI+Tqb4FC6pNMRcRU1X5fEPTvfRjeDrCq8qbt9MudxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFsuLHqY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFsuLHqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6739CC2BCB3;
	Fri, 15 May 2026 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778869162;
	bh=r2nMjiqDT8YWUVHzax2E5uphUG9fS75M2OMmRMdvLWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AFsuLHqYxidUsyoR2VW9/Q1dK+KrF9Pvjaha9Y+L2cAGIQAC4BR46YsjlAl6ZrDYT
	 sC6Ig78apGXF2eAK6TxtHcOxWO0tDnZy8+CozlTa5DP1EjvUmM8f562bX47RLIYq9V
	 pvcwztnG6vX6qkQRduLsVnOk6ljpVJKfFSeHmvihUwOLbbSsuGEk8mPHYUp/5BrLGi
	 QXDaAGJFRzL5BNJYq5O9lVlq30NJ8u4grBTMYUoT67pomLdvQtEbZABjV1tXAUHZ1C
	 u2m9Qa+QOTHasSxy0bHcMAIuvSP3Dk9IBIP4xOzub16E2Kt06cCzQPH5N7CHhQHrBn
	 mwA+GY/p/VL9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] selftests/sched_ext: Add dispatch_cookie test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260515172807.254804-4-yphbchou0911@gmail.com>
References: <20260515172807.254804-4-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 18:19:21 +0000
Message-Id: <20260515181922.6739CC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Child processes spin indefinitely and will leak if the parent te=
rminates unexpectedly.
- [Medium] The dispatch operation returns immediately without attempting to=
 dispatch another task if `bpf_task_from_pid()` fails, potentially leaving =
runnable tasks stranded.
--

commit 91ea259621d3c40168f6eb29f9526e50de76f0b2
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

selftests/sched_ext: Add dispatch_cookie test

This commit adds a new sched_ext selftest to exercise the dispatch
transaction API (scx_bpf_dsq_insert_begin and scx_bpf_dsq_insert_commit).
It uses a BPF scheduler with a queue map and a userspace program that forks
multiple spinning children, flipping their CPU affinities to trigger dequeue
and re-enqueue cycles.

> diff --git a/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c b/to=
ols/testing/selftests/sched_ext/dispatch_cookie.bpf.c
> new file mode 100644
> index 0000000000000..160a77ed9000f
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c

[ ... ]

> +void BPF_STRUCT_OPS(dispatch_cookie_dispatch, s32 cpu,
> +		    struct task_struct *prev)
> +{
> +	s32 pid;
> +	struct task_struct *p;
> +	u64 *stored, token;
> +
> +	if (bpf_map_pop_elem(&queue, &pid))
> +		return;
> +
> +	p =3D bpf_task_from_pid(pid);
> +	if (!p)
> +		return;

If a task exits and bpf_task_from_pid(pid) returns NULL, does returning
early here prevent other valid tasks in the queue from being dispatched?

Since ops.dispatch() expects a task to be inserted into a DSQ, would it be
better to loop and try popping another PID instead of returning immediately
and leaving the CPU idle?

[ ... ]

> diff --git a/tools/testing/selftests/sched_ext/dispatch_cookie.c b/tools/=
testing/selftests/sched_ext/dispatch_cookie.c
> new file mode 100644
> index 0000000000000..047d9ea1822b9
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dispatch_cookie.c

[ ... ]

> +	for (i =3D 0; i < NUM_CHILDREN; i++) {
> +		pids[i] =3D fork();
> +		if (pids[i] =3D=3D 0) {
> +			while (1)
> +				sched_yield();
> +		}
> +		if (pids[i] > 0)
> +			nforked++;
> +	}

If the test is interrupted (e.g., via SIGINT, SIGTERM, or a test framework
timeout) before reaching the cleanup code, will these spinning children be
leaked and consume 100% of the CPUs indefinitely?

Could this be prevented by calling prctl(PR_SET_PDEATHSIG, SIGKILL) in the
child processes immediately after fork()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515172807.2548=
04-1-yphbchou0911@gmail.com?part=3D3
