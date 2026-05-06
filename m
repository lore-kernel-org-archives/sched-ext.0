Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F71C861D
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100755; cv=none; b=ezO58w6kgPLTMOzhIZaMlltKb7aijD9DPcu1fjEBucSpjTMB6k5tM2SogrYMAfTn878rIEfUmFnj1Fa45pjiYFth6hIjO9fxskqPb8cq6gJALvho8PxOzvMpV6NBios9KpZogVv0NsSvpA7WuNzFkDAnIuinCSQqZPTq+8lliYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100755; c=relaxed/simple;
	bh=uPVLO2b4h4pe+2rGqT2lkee8Fi2jywT5NBjsm27F/aQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s9kgrdLE6rUz4/Nj3IsBBzcc4aEUGtzYX6529P9j0IK7pRyUrhje7zaUIkfQkhv7zZ3i4qyLLpKl0GHcdWT/51C/OqTLypTkZOuFOc2bPuS7Qj8njMnSbmc2r5wVfgfzsBcHv4AuQbDKidghdDA7dx8Asoe/gc++PyBtMvQ5GXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0qDu53f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0qDu53f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6240C2BCB0;
	Wed,  6 May 2026 20:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778100755;
	bh=uPVLO2b4h4pe+2rGqT2lkee8Fi2jywT5NBjsm27F/aQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=D0qDu53feUch49EQSaES09TSngtQUsk6e/NTWs70NtVe68IVpNT5+o1jo5GBfBoUl
	 cFrPeCzcDejCM0JBxC3iFzAr7DAc9p9Eb7Z1FiNqV/35t2A6Ov8efNdypEiHS8YH6c
	 E4AzlzY0KeWP4D64snCPESkr7L3UPZGZ6nOHXP2cGfxPpOcZ/HPuLv3EtNWHxQVPL6
	 fGMUz9MrUk9L3jgvmpVXyif3TWB+k2pPZdsz4d6PZn4B3t3N7pYS6PG3Ob+rPe0Vnx
	 lYy1lpIXvdDM1FUW29NLzfwpcgxKeD1NvYG7q9tr1gPG5M2sxkldhn2GdZvLtAGOZZ
	 CsbRZCkkje6YQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] selftests/sched_ext: Add dispatch_cookie test
Reply-To: sashiko@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260506160412.522199-3-yphbchou0911@gmail.com>
References: <20260506160412.522199-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:52:34 +0000
Message-Id: <20260506205234.E6240C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Failing an assertion in the run() function leaks the bpf_link and =
leaves the BPF scheduler permanently attached.
- [Medium] The BPF program incorrectly drops the kernel-provided enq_flags =
when calling scx_bpf_dsq_insert_with_cookie().
- [Medium] The return value of fork() is not checked for errors, leading to=
 incorrect waitpid() behavior.
--

commit de7f9ee9893bdc6cb049e25475e095b028e1ed26
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>
selftests/sched_ext: Add dispatch_cookie test

This commit adds a new sched_ext selftest to verify the behavior of
scx_bpf_task_get_cookie() and scx_bpf_dsq_insert_with_cookie(). It captures
a cookie before dispatch and verifies that userspace accurately reflects
the cookie-based dispatch activity.

> diff --git a/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c b/to=
ols/testing/selftests/sched_ext/dispatch_cookie.bpf.c
> new file mode 100644
> index 0000000000000..cb198a5f50e89
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
[ ... ]
> +void BPF_STRUCT_OPS(dispatch_cookie_enqueue, struct task_struct *p,
> +		    u64 enq_flags)
> +{
> +	u64 cookie =3D scx_bpf_task_get_cookie(p);
> +
> +	if (scx_bpf_dsq_insert_with_cookie(p, SCX_DSQ_GLOBAL, 0, cookie))

Does this code unintentionally drop the enq_flags provided by the kernel?

The fallback branch correctly passes enq_flags to scx_bpf_dsq_insert(),
but hardcoding 0 here might alter task placement context by dropping
directives like SCX_ENQ_WAKEUP.

> +		__sync_fetch_and_add(&nr_cookie_dispatched, 1);
> +	else
> +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> +}
[ ... ]
> diff --git a/tools/testing/selftests/sched_ext/dispatch_cookie.c b/tools/=
testing/selftests/sched_ext/dispatch_cookie.c
> new file mode 100644
> index 0000000000000..f799b5828f9d6
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dispatch_cookie.c
[ ... ]
> +static enum scx_test_status run(void *ctx)
> +{
> +	struct dispatch_cookie *skel =3D ctx;
> +	struct bpf_link *link;
> +	pid_t pids[NUM_CHILDREN];
> +	int i, status;
> +
> +	link =3D bpf_map__attach_struct_ops(skel->maps.dispatch_cookie_ops);
> +	SCX_FAIL_IF(!link, "Failed to attach scheduler");
> +
> +	for (i =3D 0; i < NUM_CHILDREN; i++) {
> +		pids[i] =3D fork();

Should the return value of fork() be checked here?

If fork() fails and returns -1, waitpid() in the subsequent loop will be
called with -1, causing it to wait for any child process rather than the
specific process. This could lead to out-of-order reaping and confusing
test failures.

> +		if (pids[i] =3D=3D 0)
> +			exit(0);
> +	}
> +
> +	for (i =3D 0; i < NUM_CHILDREN; i++) {
> +		SCX_EQ(waitpid(pids[i], &status, 0), pids[i]);
> +		SCX_EQ(status, 0);

Can this cause a resource leak that affects other tests?

SCX_EQ() forces an immediate return upon failure. If a check fails here,
the function will return before reaching bpf_link__destroy(link).

Leaving the BPF scheduler attached could cause subsequent tests in the
runner to fail with -EBUSY, since sched_ext only allows one active
scheduler globally.

> +	}
> +
> +	bpf_link__destroy(link);
> +
> +	SCX_GT(skel->bss->nr_cookie_dispatched, 0);
> +
> +	return SCX_TEST_PASS;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506160412.5221=
99-1-yphbchou0911@gmail.com?part=3D2
