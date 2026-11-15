Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755942;
	b=gkFHJ9K60X/Y4pCtWR2UtwhiPmDxiHqTvGwUaFnF+bPUpIIzn3CWe78Ix7VQ2NfWDlP7
	 dEdRIlXo83nFhsYsqRkigFoRvq0Ov18vjGNXnLEftzKzjKfwGmyeArJqMUyl/NdH0HIEM
	 cfATY6iZaMwWr7luXXYKfw0mKdN86vdgdLFXr/PrzjEBt8nbjEifrPj5d8p+vyjrLPGlv
	 UFf/4csUGR5tkU4dbCEnHJ9bZ32dslU7hD5lBA6scntyorLXsbwXBQb0Fst0/lwKfFK0F
	 o+ZL/CrKfnAGzpYZCgdmu0y0SdKEXRDwH5MH50JcBcIv70WgvObEhxFHmJSnHlnswbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755942;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vm8hCuEHsQlj0UgUYi4kmfv8q/NdfOfeUm9F4E9DOyY=;
	b=fLlQcDEZ1B6TIisfB/1pU2tgnkmpZY5He2bf8ggPRpdfiTaTvc/OkIaQ84PuQhUKmAuI
	 0Bs5mUCFNW+NOEgHnhEmew+PxYnH/UeZZloahGkDS3CVc8de4HHfFC3DN6ls86M29bcPY
	 fich0QobeIEumxjAcRzYROWBxIwIaZ09sF4aF93ySWj5+er70UzIbJUfNfG0CYG4vehMR
	 hssih/ZUH60S331gFluRXiF7ywZJUKGTz0dqUU7uyu9bS8QM0dOUn+LTIAjUl9PuWU0Ok
	 SI6Nj3T5KKnb/6PogyRB/48UhGFDAwNX7ZlBYbzFynzCnCF6W5be+pM7FA04bRyEWJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SH5IpAMl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1477606A31D
	for <sched-ext@lists.linux.dev>; Sun, 15 Nov 2026 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SH5IpAMl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386A71F000C4;
	Sun, 15 Nov 2026 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794755942;
	bh=Vm8hCuEHsQlj0UgUYi4kmfv8q/NdfOfeUm9F4E9DOyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SH5IpAMldjeOhwocbjdDHr+b17uFDIKVozNGB4XvWlZh/cM5lAj49e7Fwxx6A3lBt
	 kK10+vUpj9XIZnIaUAipXEpqi6IhwmcT/YhApiJlTxp7aX29eZX209MtDCIxMWOU4M
	 B1Tv3HmoFWbW35siCjUZn3w0dNXjH9SpTi1IRgcn9VrZl5p+CCfAKCdtNLR2vI1jRQ
	 hX/Z1pTQ77lDN2bEtWXqadJiFtSyDwKMcQvvMUEDenRGT8ykFg272Zmln99fnkVHTG
	 Qv7/mOtadyr1IgFDPu/la42Rh6LjQ/NqxkjrWCTBcSxlRE6XtJeyoeioDelgsrrl77
	 Gp6+LPpPnDC1g==
Message-ID: <sashiko-outbox-215619@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext for-7.4-fixes v2] selftests/sched_ext: Fix
 flaky rt_stall measurement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jonathan Bastari Thamrin" <thamrinjonathan@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261115-scx-rt-stall-v2-1-926678b214c6@gmail.com>
References: <20261115-scx-rt-stall-v2-1-926678b214c6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 15:19:01 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/sched_ext: leak of BPF skeleton in setup() on affinity
  error
--

commit 24932bf17cf4d833030f3c4b3de4fdbf28e3d142
Author: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

selftests/sched_ext: Fix flaky rt_stall measurement

This commit fixes flaky runtime measurements in the rt_stall selftest by
measuring per-task CPU clock deltas around the sleep window and pinning the
parent process off the test CPU.

Link: https://github.com/kernel-patches/vmtest/issues/458

> diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing=
/selftests/sched_ext/rt_stall.c
> index a1552b38a6e8c..c5027fd6b6820 100644
> --- a/tools/testing/selftests/sched_ext/rt_stall.c
> +++ b/tools/testing/selftests/sched_ext/rt_stall.c

[ ... ]

> @@ -132,6 +149,9 @@ static enum scx_test_status setup(void **ctx)
> =20
>  	*ctx =3D skel;
> =20
> +	err =3D pin_parent_off_core();
> +	SCX_FAIL_IF(err =3D=3D -1, "Failed to pin parent CPU");
> +
>  	return SCX_TEST_PASS;
>  }

[Severity: Low]
Does this leak skel if pin_parent_off_core() fails?  run_test() returns
immediately when test->setup() does not return SCX_TEST_PASS without
calling test->cleanup(), leaving the opened and loaded BPF skeleton
undestroyed across subsequent tests in the runner process.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-scx-rt-sta=
ll-v2-1-926678b214c6@gmail.com?part=3D1
