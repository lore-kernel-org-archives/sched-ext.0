Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A514C10D1
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553718; cv=none; b=GdfbRXgMdOPYSLXAyNnnKqMNCNnZeAPmJk4J3YLVPhy39zYJXiz7yY0mHaoOPJmd3NDbqTIfrxOpT/82XFg4W06BQkAqidK7PsmewmgXnBC/iBjw1guuAlEDMs37KAui9XZtdMqrzIpwZqxWpqRAzyl9aE5Zdh3PA6FwH/DTpoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553718; c=relaxed/simple;
	bh=f4e080Uv4se/9o9XA5FD9/1KQ3et7nexwSED273TaO0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=N1+VqLgeNS90P5F2XnB0jeh3nPFIGi47rCmxHAfGmiiB48KG/tn1tUGDZNYJw6n7qv5CoyP682OgnoM70Ga72lItN3D3j6XiJWD5XCSA3S5TkRwvGotB1lnJ01qp4ZvdHhd8xIWGfFhUGCvlsqdS529idMOiNWWCjNrOfQPWmk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B85in/dr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B85in/dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5AB1F000FF;
	Fri,  9 Oct 2026 13:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791553717;
	bh=M/DYVCBH/MB/XyFsrhtmcUT+aF1KhLdPOqHbshKispc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B85in/drPfAhiOLLtg8xjOPqP4vF3VcpiMBHqxRYbMKG9m0O0YhWSZ5XOnhkqOWsb
	 xY28mXk3Jlp10WJ9ObAszCmj9Fkc38M7AvGTcQE5Rs1F917LIgrPlMzEKZ1k6GzofY
	 I0d+bUJbZn3P1Mow1M5axxCHpRomFyqVh3DcJem8NfFb+7cbvCZ0VGcwLYHRyiRs0Y
	 wzrBro0i7Yo1mshjdlxM4BFLxayIownhe2v2aYwqyEoqBtJBEPuT1A6pOI2o2bJnT2
	 B0ne+WpAyNiutUbZZBqjncrjYnt9mWxjJO4PmN50vVPvk9JJ/XD2kaERE1H+7pwl4j
	 55XYsNzvdvzIQ==
Message-ID: <sashiko-outbox-165673@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] selftests/sched_ext: Bound exit waits and report
 reload_loop failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261009134104.296891-6-cui.tao@linux.dev>
References: <20261009134104.296891-1-cui.tao@linux.dev>
 <20261009134104.296891-6-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:48:36 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/sched_ext: leak of BPF link and skeleton on timeout in=
 exit.c
- [Low] selftests/sched_ext: dead code in reload_loop failure reporting
--

commit b49c5aa1d20c7dfda172f19617a72ddbef7da918
Author: Tao Cui <cuitao@kylinos.cn>

selftests/sched_ext: Bound exit waits and report reload_loop failures

This commit replaces unbounded waits for scheduler exit in multiple tests
with an iteration-bound timeout using SCX_TIMED_WAIT_UEI(). It also updates
reload_loop to track and report attach failures, failing the test on
unexpected errors or if every attach attempt fails.

> diff --git a/tools/testing/selftests/sched_ext/exit.c b/tools/testing/sel=
ftests/sched_ext/exit.c
> index 01b17092d5c8f..9270d8e79eb63 100644
> --- a/tools/testing/selftests/sched_ext/exit.c
> +++ b/tools/testing/selftests/sched_ext/exit.c
> @@ -43,8 +43,8 @@ static enum scx_test_status run(void *ctx)
>  		}
> =20
>  		/* Assumes uei.kind is written last */
> -		while (skel->data->uei.kind =3D=3D EXIT_KIND(SCX_EXIT_NONE))
> -			sched_yield();
> +		SCX_FAIL_IF(!SCX_TIMED_WAIT_UEI(skel, uei, 10000),
> +			    "Timed out waiting for scheduler to exit");
> =20

[Severity: Medium]
Does this SCX_FAIL_IF() check leak the BPF link and skeleton on timeout?

In run(), skel and link are allocated locally inside the loop. If the wait
times out, SCX_FAIL_IF() will immediately return SCX_TEST_FAIL, bypassing
the bpf_link__destroy() and exit__destroy() calls at the end of the loop bl=
ock.

Failing to destroy the BPF link leaves the scheduler attached to the kernel,
which breaks test isolation. Subsequent tests in the runner might then fail
with -EBUSY because only one sched_ext scheduler can be attached at a time.

>  		SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG_BPF));
>  		SCX_EQ(skel->data->uei.exit_code, tc);

[ ... ]

> diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/test=
ing/selftests/sched_ext/reload_loop.c
> index ecff86f59e6c7..4ae6fb43b6c5c 100644
> --- a/tools/testing/selftests/sched_ext/reload_loop.c
> +++ b/tools/testing/selftests/sched_ext/reload_loop.c
[ ... ]
> @@ -60,7 +78,24 @@ static enum scx_test_status run(void *ctx)
>  	}
> =20
>  	SCX_FAIL_IF(pthread_join(threads[0], &ret), "thread 0 failed");
> +	failures +=3D (unsigned long)ret;
> +
>  	SCX_FAIL_IF(pthread_join(threads[1], &ret), "thread 1 failed");
> +	failures +=3D (unsigned long)ret;
> +
> +	SCX_FAIL_IF(unexpected_errno, "unexpected attach errno %d",
> +		    unexpected_errno);
> +
> +	if (failures) {
> +		printf("reload_loop: %lu attach failures%s\n",
> +		       (unsigned long)failures,
> +		       unexpected_errno ? ", unexpected errno" :
> +					  " (EBUSY: scheduler slot busy)");

[Severity: Low]
Is the true branch of this ternary condition dead code?

The SCX_FAIL_IF(unexpected_errno, ...) check slightly above will immediately
return from the function if unexpected_errno is non-zero. As a result, when
execution reaches this printf statement, unexpected_errno must evaluate to
false.

The true branch (", unexpected errno") can never be executed, preventing the
unexpected errno from being reported in the summary as intended.

> +		fflush(stdout);
> +	}
> +
> +	SCX_FAIL_IF(failures =3D=3D RELOAD_ITERS * RELOAD_THREADS,
> +		    "every attach failed");
> =20
>  	return SCX_TEST_PASS;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134104.2968=
91-1-cui.tao@linux.dev?part=3D5
