Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A429ACCD
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984291; cv=none; b=D+xcY4WH5Z6h4Q9S9kw3alXVOIBY3ADXLz4XOOjf/iQ9Z7vUXyTEHZ4pnssSLHyuBeokIAO6PMrzlWHK+C32JJhAp0k91LIaz2LJj7VXLtjAuOqpOE1h6bfzC6/D2zKoGYlGqA0COyw3gE4xPLLgnX2ui/W34+x+Gun5wXWPRvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984291; c=relaxed/simple;
	bh=mu+I5RDQHuu0IzZoAfIyHPsS7PhO50eYvLSs0XjVBgk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IHM6WoM2zz8dP0Hyu+Ryep0FFgB10Sj2OYre1mSpN5e/P7p8tXeyULaYZ+1tqyW82RuDTOvt3gWPvOJW3uKNCjG6YDshDJ0cIt8Lp7b0rXfTEINQ2S6+qwwdLj6Wwtqvj6ObDQV9aH03zIzK1vycdrbXjb+MpoqniI+6Dft5sac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNPTMD/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNPTMD/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719561F00893;
	Wed, 14 Oct 2026 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984290;
	bh=sv9eTbdvhpGgQp0HDBmfj1CBa1w+3c3o83T+BnGSg0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BNPTMD/9PETHpO1dRxWdz3pppYORbfsC1FOaUysnLXD6+3rXP4R/CSTir9Iq3irZ5
	 QaX6KbQDHWPsKXy1DkqJo2Y72yKaIVaCmZtOaRLlIefOnBfQnDPtzCK0bsgLZGO9Za
	 CHK9vhesOVLIEPWZM4+biCTPMBJzKp4Xwgb8WXJHuHFrsAiWKtC4Z8mtWF4YH9/UI5
	 w3bt/IEh8Y1iMsc7W2xZGrkmTAR8WIs6CUJU5g6BU/lhCHDAXEY5n2FqPcIj7FNiSk
	 c8glKnhclc36TeKfnlV9im+2xOMkReXWeKc0qXZuSeiiulc55rCmW5EakJwjXM+8Ig
	 qfEwpnNKTzd0Q==
Message-ID: <sashiko-outbox-171348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] selftests/sched_ext: Report reload_loop attach
 failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261014131325.793640-7-cui.tao@linux.dev>
References: <20261014131325.793640-1-cui.tao@linux.dev>
 <20261014131325.793640-7-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 13:24:50 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: flaky reload_loop test due to strict iteration limit
--

commit 8a9da64f2647d703dd026bef834ba09325868dbc
Author: Tao Cui <cuitao@kylinos.cn>

selftests/sched_ext: Report reload_loop attach failures

This commit updates the reload_loop test to record the number of EBUSY
attach failures per thread. It fails the test if an unexpected errno is
encountered or if any thread fails to attach the link on every iteration.

> diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/test=
ing/selftests/sched_ext/reload_loop.c
> index a00f3964dba05..7d8880fa1a032 100644
> --- a/tools/testing/selftests/sched_ext/reload_loop.c
> +++ b/tools/testing/selftests/sched_ext/reload_loop.c

[ ... ]

> @@ -31,22 +38,33 @@ static enum scx_test_status setup(void **ctx)
> =20
>  static void *do_reload_loop(void *arg)
>  {
> -	u32 i;
> +	u32 i, failures =3D 0;
> =20
> -	for (i =3D 0; i < 1024 && !force_exit; i++) {
> +	for (i =3D 0; i < RELOAD_ITERS && !force_exit; i++) {
>  		struct bpf_link *link;
> =20
> +		errno =3D 0;
>  		link =3D bpf_map__attach_struct_ops(skel->maps.maximal_ops);
> -		if (link)
> -			bpf_link__destroy(link);
> +		if (!link) {
> +			int e =3D errno;
> +
> +			if (e !=3D EBUSY)
> +				__atomic_store_n(&unexpected_errno, e,
> +						 __ATOMIC_RELAXED);
> +			failures++;
> +			continue;

[Severity: Medium]
Because this loop does not yield the CPU (e.g., via sched_yield() or usleep=
())
when receiving -EBUSY, can a thread rapidly spin through all 1024 iterations
while the other thread holds the link or is preempted?

> +		}
> +
> +		bpf_link__destroy(link);
>  	}
> =20
> -	return NULL;
> +	return (void *)(unsigned long)failures;
>  }

[ ... ]

> @@ -60,7 +78,18 @@ static enum scx_test_status run(void *ctx)
>  	}
> =20
>  	SCX_FAIL_IF(pthread_join(threads[0], &ret), "thread 0 failed");
> +	failures[0] =3D (unsigned long)ret;
> +
>  	SCX_FAIL_IF(pthread_join(threads[1], &ret), "thread 1 failed");
> +	failures[1] =3D (unsigned long)ret;
> +
> +	SCX_FAIL_IF(unexpected_errno, "unexpected attach errno %d",
> +		    unexpected_errno);
> +
> +	for (i =3D 0; i < RELOAD_THREADS; i++)
> +		SCX_FAIL_IF(failures[i] =3D=3D RELOAD_ITERS,
> +			    "thread %d: every attach failed (%lu EBUSY)",
> +			    i, failures[i]);

[Severity: Medium]
Could this assertion cause spurious test failures on loaded systems?

Since 1024 syscalls returning -EBUSY execute extremely fast, if one thread
successfully attaches the link and is temporarily preempted before destroyi=
ng
it, the other thread can easily exhaust its RELOAD_ITERS and hit this failu=
re
condition.

> =20
>  	return SCX_TEST_PASS;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014131325.7936=
40-1-cui.tao@linux.dev?part=3D6
