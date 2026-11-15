Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794766633;
	b=yDaOeBGuIhOvGWhwv5VMCdywMt8G65apVVGZ2RfhErLaU4u8z5FYlAhPZyCWNRxAvE7C
	 NgP8kcBihj3LuQklRMOkxfsdeNQInFU1/SJKjHVm6deJK3kb23bO/plrUfTPHUhb4jaR7
	 fDTpxJ7lWzhMIwT8XFLEo1fBWSZpggNR46WLnpHWheJZ3eqyHq0KwHT27oErmikJcPzDA
	 bPoTzUYukpTAffbxvufAmfw6Jlrmp6qfZE3LHX6ffHSVqNtrAGNzWXiZaWRB/UgAlykud
	 YlSqDaMDgQ/K10iG6yziRxnWuv3vbyTvCmmNLSL3TGnrYLPejotf3DHcrerCe+XG9TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794766633;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yyoQehRhbAIaPRaGK0e/RfCgKgQZvcNXbSm5VWy0/zE=;
	b=fOq+eRijUc9cJ0sTFX6HOvAbmR7sDzJbpJtZE2TRj1G1tcXO60w3nzWnXti+d5m1oCg9
	 s0LgO9t3bejYIYvYzhfZ2o6dV8gsDAMb3yPTz+Cg9/uHOdzbrukZXLLJOQYHDEQAiuDzv
	 wO+VSgOqaqcFH7K4dbTLN8KKyiPw3CK1ywwqh3wd0IW7VgvEoFF8rUeeOL8L2jmGPRuP4
	 5RvX5awP2txeY5B02HQtId6hwXKpSJtoYHTlUgCEzCU4RoZ0SenDQPv8lgwQTVSDhOY0q
	 O7w3WxeScvqtwcScMPpN/C7euHeHf4Zp+0MeiPersxzLkvuglgjlvZAHiW6MwbCaGmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWhY8Vxl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9A606A31A
	for <sched-ext@lists.linux.dev>; Sun, 15 Nov 2026 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWhY8Vxl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE991F000C4;
	Sun, 15 Nov 2026 18:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794766633;
	bh=yyoQehRhbAIaPRaGK0e/RfCgKgQZvcNXbSm5VWy0/zE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWhY8Vxld8G6lU2o5x/BqeMy7Zti58Y5I78MumXf4mdHDf6lNEgwYHapYNmPTrxSQ
	 czkRfbcYz0L/fNnTt8Fx94Ps4Oumb3Jl/BC4RlzLqKKc53tDPTKt/rthi3pb5NWl6a
	 V/dBts3ucvBQ9gtcOqADBkgwpakxSZBPrBZ4GTbjovsj7Mh2DHTfh7elKe9/edqRJ+
	 rv0GXASYFfvAdQNZ3LubMoulaL9eF8MFUNxUNeZiMjQKR+u7Rq4PoeAftlkwFyCmsF
	 mPPEUAX3BwhTSASd2kaOy3XUfOt9trj6OCUvKn5s+CENrYCodKk9lO7ouWjameaI4w
	 o4QhVptJBK83A==
Message-ID: <sashiko-outbox-215705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext for-7.4-fixes v3] selftests/sched_ext: Reduce
 rt_stall measurement noise
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jonathan Bastari Thamrin" <thamrinjonathan@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261116-scx-rt-stall-v3-1-8dd2d150c4aa@gmail.com>
References: <20261116-scx-rt-stall-v3-1-8dd2d150c4aa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 18:17:12 +0000
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
- [Low] selftests/sched_ext: BPF skeleton leak on error return in
  setup()
--

commit 460edb58a551fd13069d6da200d43512c93cb197
Author: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

selftests/sched_ext: Reduce rt_stall measurement noise

This commit reduces runtime measurement noise in the rt_stall selftest by
measuring task CPU time deltas across the sleep window with
clock_getcpuclockid() and pinning the parent process off CORE_ID.

Link: https://github.com/kernel-patches/vmtest/issues/458

> diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing=
/selftests/sched_ext/rt_stall.c
> index a1552b38a6e8c..7be801b1fa2bd 100644
> --- a/tools/testing/selftests/sched_ext/rt_stall.c
> +++ b/tools/testing/selftests/sched_ext/rt_stall.c

[ ... ]

> @@ -132,6 +149,9 @@ static enum scx_test_status setup(void **ctx)
> =20
>  	*ctx =3D skel;
> =20
> +	err =3D pin_parent_off_core();
> +	SCX_FAIL_IF(err =3D=3D -1, "Failed to pin parent CPU");

[Severity: Low]
Does this leak skel if pin_parent_off_core() fails?

setup() has already opened and loaded skel via rt_stall__open() and
rt_stall__load() (which also leaks skel on load failure).  When
test->setup() does not return SCX_TEST_PASS, run_test() in runner.c
returns immediately without calling test->cleanup(), leaving skel and its
BPF program and map file descriptors open for the rest of the multi-test
runner process.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-scx-rt-sta=
ll-v3-1-8dd2d150c4aa@gmail.com?part=3D1
