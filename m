Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E5440638
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554079; cv=none; b=QMJsd7RfkOynvAHt/EznItkNkL4eODcBfK6xZvLm557XjBw86ekdR7tiJP6DiTLjkbpUKhqT5ZnAALJt6cgHUO4/ndWJF41vE3aug/axbcax7A5PajHox+W4h7ryl5pRuXRXObwUUj0xBJXN7DcC9DJxpak1bNuKj1Od9Odfu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554079; c=relaxed/simple;
	bh=FEmHL4ns9V3gmlMD8kb15PT2KX7I0sVOm/3uGlLmRUs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Iu14Kh6Q8dGztSgL1RXwouzB6c9P9jmpYVK7+OZGMn5UPUwwCl3P7OlXCfRoK1I2pJgPfxlp4B69cfIewqBfUrHI/UAGne6GrnEYY72nRJSCMy4oof9iEDmad/Jww+lpreeASaOMLEARgF/G70pXcifWSPZbT6cRXL02FizBdRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBDfMRap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBDfMRap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667CD1F000FF;
	Fri,  9 Oct 2026 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554076;
	bh=ARh/lx04vXuxxbU+74HHyjtYpA3STDOnzog3kJ3NOTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBDfMRapr56ZN3TxXjo1T3GYELusJh4hmRllny7xMFSpRY/d2Zu7rVUNhnwTzOJ02
	 aFYRtAphNOvP/KbQo+J1T2+CwRyN/TwyxK9ZNMuRtNMl+WJrILNCtFcVxwE09bX77Z
	 CfyKaOyWWZiw1XLlIWbBqJX+E8G3uR97V493ZHQsOEBaUGKCMYgOn0iyCTkBNdPxv0
	 /SlnymA/QrM2/zs0Eceka4utIdAcoMl56tffnyHfUOVnppNLe5ZM83d4WoRFaEOaHv
	 Gfq3zS7e6U6XRvrdXpR049WSbDRxnTuaLSv3hcNneo1nwi2hRyFqVP73AQiDxz8rdK
	 JSs8QjsFQDQrw==
Message-ID: <sashiko-outbox-165680@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] selftests/sched_ext: Fail loudly when EXIT_KIND is
 missing from BTF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261009134104.296891-4-cui.tao@linux.dev>
References: <20261009134104.296891-1-cui.tao@linux.dev>
 <20261009134104.296891-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:54:35 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/sched_ext: EXIT_KIND() hidden return bypasses cleanup =
and leaks spinning threads
--

commit 083f03de0fcd50d9c9ef1d52267ab98872def3d2
Author: Tao Cui <cuitao@kylinos.cn>

selftests/sched_ext: Fail loudly when EXIT_KIND is missing from BTF

The patch updates EXIT_KIND() in the sched_ext selftests to fail explicitly=
 via
__COMPAT_read_enum() when a BTF enum is missing, avoiding silent failures w=
here
SCX_EXIT_NONE is returned. It changes the polling helpers in kick and nohz_=
tick
to use UEI_EXITED() to retain their original semantics without requiring a =
BTF
lookup.

> diff --git a/tools/testing/selftests/sched_ext/kick.c b/tools/testing/sel=
ftests/sched_ext/kick.c
> index 7f01602c75b29..591c250d475db 100644
> --- a/tools/testing/selftests/sched_ext/kick.c
> +++ b/tools/testing/selftests/sched_ext/kick.c

[ ... ]

> @@ -421,6 +421,7 @@ static enum scx_test_status invalid_one(struct kick_c=
tx *ctx, u32 scenario)
>  	enum scx_test_status ret =3D SCX_TEST_FAIL;
>  	int cpu =3D ctx->target_cpu;
>  	int i;
> +	u64 error_kind;
> =20
>  	victim =3D scx_test_spawn_gated_worker(cpu, false);
>  	if (victim.pid < 0)
> @@ -435,12 +436,13 @@ static enum scx_test_status invalid_one(struct kick=
_ctx *ctx, u32 scenario)
>  	bpf_program__set_autoload(skel->progs.kick_wait_callback, false);
>  	if (kick__load(skel))
>  		goto out;
> +	error_kind =3D EXIT_KIND(SCX_EXIT_ERROR);

[Severity: Medium]
Does this code leak the spawned gated worker and skeleton object on BTF loo=
kup
failure?

The new EXIT_KIND() macro embeds SCX_FAIL(), which performs a hidden functi=
on
return. If the BTF lookup fails here, invalid_one() returns directly and
bypasses the goto out; cleanup path below.

This leaks the skel object and leaves the victim gated worker spinning
indefinitely in the background, which can corrupt the environment for
subsequent tests in the runner.

This pattern of leaking threads also appears in
tools/testing/selftests/sched_ext/cyclic_kick_wait.c:run() where EXIT_KIND(=
) is
called after background pthreads have been started.

>  	ops_link =3D bpf_map__attach_struct_ops(skel->maps.kick_ops);
>  	if (!ops_link || !scx_test_start_gated_worker(&victim))
>  		goto out;
> =20
>  	for (i =3D 0; i < WAIT_LOOPS; i++) {
> -		if (skel->data->uei.kind =3D=3D EXIT_KIND(SCX_EXIT_ERROR)) {
> +		if (UEI_EXITED(skel, uei) =3D=3D error_kind) {
>  			ret =3D SCX_TEST_PASS;
>  			break;
>  		}

[ ... ]

> diff --git a/tools/testing/selftests/sched_ext/scx_test.h b/tools/testing=
/selftests/sched_ext/scx_test.h
> index 90b8d6915bb7e..fe0e6dabe7a48 100644
> --- a/tools/testing/selftests/sched_ext/scx_test.h
> +++ b/tools/testing/selftests/sched_ext/scx_test.h

[ ... ]

> @@ -18,7 +19,21 @@ enum scx_test_status {
>  	SCX_TEST_FAIL,
>  };
> =20
> -#define EXIT_KIND(__ent) __COMPAT_ENUM_OR_ZERO("scx_exit_kind", #__ent)
> +/*
> + * EXIT_KIND - Resolve an scx_exit_kind enum value from kernel BTF.
> + *
> + * __COMPAT_ENUM_OR_ZERO() silently maps a missing enum to 0, which for
> + * exit kinds is indistinguishable from SCX_EXIT_NONE and would make
> + * every EXIT_KIND() comparison pass vacuously. Fail the test loudly
> + * instead, mirroring SCX_ECODE_VAL() and SCX_KIND_VAL() below.
> + */
> +#define EXIT_KIND(__ent) ({							\
> +	u64 __val =3D 0;								\
> +										\
> +	if (!__COMPAT_read_enum("scx_exit_kind", #__ent, &__val))		\
> +		SCX_FAIL("scx_exit_kind.%s not found in kernel BTF", #__ent);	\

[Severity: Medium]
Could this hidden return cause resource leaks?

SCX_FAIL() expands to a direct return SCX_TEST_FAIL;. Because EXIT_KIND() is
used as an expression, this introduces a hidden control flow branch that
silently returns from the caller, bypassing explicit explicit cleanup paths.

> +	__val;									\
> +})
> =20
>  struct scx_test {
>  	/**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134104.2968=
91-1-cui.tao@linux.dev?part=3D3
