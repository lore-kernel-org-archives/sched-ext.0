Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429F5208CB
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984491; cv=none; b=i6V+/9J5zbrX6Bo1Ux5yVk3aNp6Lz0uvi3KESV9dmGBeRf2oEamhai8193//l6grZLTfNEeW9OzmTp4CmkEStI9azchAIkCzFNtBu1MOmFMR+/jWIF8Fkv2hc9Xu8M45T7wocNtbQfADJUL8pHjW0nBtSwXv92HXkR9VaWD6AdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984491; c=relaxed/simple;
	bh=XnFw6o6zclq7Sye5xp7E77GAbq/tdXjlusok90auGyI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rgvNpSTTq05RwKNntCDWc7tyYfOqA9QbOSPaAcsme6LhlGzrAn1wCqTS4j1l5Vm49o5TWxuT5sJEsWgS6w9WmJl+7kzJQV2bqHS5un9UbGM5ptumxcl2muMrwX3W234uYVp8KY7Lh1heiu5h8hisObcku78JFzUEriIbUMoZCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZfcRhRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZfcRhRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301691F000FF;
	Wed, 14 Oct 2026 13:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984484;
	bh=eu1wgmFZkfW/FHtVPj58z2VrnHtbVvQuKFzaltlYRx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZfcRhRaH7zf/+t7ropRP12SOV/S+i1loIfyWOuvmcegULukfoxSZ4rPsB1/ZGp3n
	 K+4N9azklvBPtSCyyGYfnRPoXFoCjdXOYEiLWaW4gLfpxy5Fq82npS5lxGMDys1WdI
	 uV9oBhxdo11y4iMDxfu4ZbU23EElfHb49SGZS5CWyXZ80vhFdZrECx3J9OIsDckiqb
	 XwJVEQbGwue/u5kxaf0NNRjIx9rN6hKWcdAferzsLI0zeIqQRh50FoHUuBsIwoMBS3
	 fau/69/5UxytBxsgoNv4VOZxfchlXpUnUnY0w7C8KvcBw2gyn+7EiV/VDWtPfp8CLs
	 Qoev6GU6TV4Hw==
Message-ID: <sashiko-outbox-171354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] selftests/sched_ext: Fail loudly when EXIT_KIND
 is missing from BTF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261014131325.793640-4-cui.tao@linux.dev>
References: <20261014131325.793640-1-cui.tao@linux.dev>
 <20261014131325.793640-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 13:28:03 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/sched_ext: EXIT_KIND() early return leaks bpf_link and=
 breaks test suite
--

commit dc88ff2863ae13f6a94ae129f38a8ba739ac1964
Author: Tao Cui <cuitao@kylinos.cn>
   =20
selftests/sched_ext: Fail loudly when EXIT_KIND is missing from BTF

EXIT_KIND() resolved scx_exit_kind values through
__COMPAT_ENUM_OR_ZERO(), which maps a missing enumerator to 0 (=3D=3D
SCX_EXIT_NONE). struct scx_exit_info carries the enum itself, so the
BTF of any loaded scheduler always has the type, and every enumerator
the tests resolve today exists on all sched_ext kernels: the fallback
got the value right, and the single comparison that could pass
vacuously was the kick.c error poll.

> diff --git a/tools/testing/selftests/sched_ext/scx_test.h b/tools/testing=
/selftests/sched_ext/scx_test.h
> index 90b8d6915bb7e..319e67f19b6dd 100644
> --- a/tools/testing/selftests/sched_ext/scx_test.h
> +++ b/tools/testing/selftests/sched_ext/scx_test.h
[ ... ]
> @@ -119,13 +117,25 @@ void scx_test_register(struct scx_test *test);
>  	(s64)__val;								\
>  })
> =20
> +/*
> + * SCX_KIND_VAL - Resolve an scx_exit_kind enumerator from kernel BTF.
> + *
> + * Unlike __COMPAT_ENUM_OR_ZERO(), a missing enumerator fails the test
> + * loudly instead of silently resolving to 0 (=3D=3D SCX_EXIT_NONE), whi=
ch
> + * would make the comparison vacuous.
> + */
>  #define SCX_KIND_VAL(__kind) ({							\
> -        u64 __val =3D 0;								\
> -	bool __found =3D false;							\
> +	u64 __val =3D 0;								\
>  										\
> -	__found =3D __COMPAT_read_enum("scx_exit_kind", #__kind, &__val);		\
> -	SCX_ASSERT(__found);							\
> +	if (!__COMPAT_read_enum("scx_exit_kind", #__kind, &__val))		\
> +		SCX_FAIL("scx_exit_kind.%s not found in kernel BTF", #__kind);	\
>  	__val;									\
>  })
> =20
> +/*
> + * EXIT_KIND - Alias of SCX_KIND_VAL() for resolving scx_exit_kind
> + * enumerator values, kept for readability at the EXIT_KIND() call sites.
> + */
> +#define EXIT_KIND(__ent) SCX_KIND_VAL(__ent)
> +
>  #endif  // # __SCX_TEST_H__

[Severity: Medium]
When EXIT_KIND() fails to resolve the enum, SCX_FAIL() triggers a hidden
return SCX_TEST_FAIL. Does this early return leak resources and break the
test suite?

For example, in tools/testing/selftests/sched_ext/exit.c:run():

		link =3D bpf_map__attach_struct_ops(skel->maps.exit_ops);
		if (!link) {
			SCX_ERR("Failed to attach scheduler");
			exit__destroy(skel);
			return SCX_TEST_FAIL;
		}

		/* Assumes uei.kind is written last */
		while (skel->data->uei.kind =3D=3D EXIT_KIND(SCX_EXIT_NONE))
			sched_yield();

		SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG_BPF));
		SCX_EQ(skel->data->uei.exit_code, tc);
		sprintf(buf, "%d", tc);
		SCX_ASSERT(!strcmp(skel->data->uei.msg, buf));
		bpf_link__destroy(link);
		exit__destroy(skel);

If EXIT_KIND() fails inside the SCX_EQ() assertion or the while loop, it
returns early and bypasses bpf_link__destroy() and exit__destroy(), leaking
both the BPF link and skeleton.=20

Since runner.c executes tests serially in a single process, could the open
BPF link keep the scheduler active in the kernel, causing all subsequent te=
sts
to fail with -EBUSY?

This issue also appears to affect multiple other tests, such as
ddsp_bogus_dsq_fail.c, prog_run.c, and enq_select_cpu.c, where EXIT_KIND() =
is
used inside assertions while a struct bpf_link *link is held. While follow-=
up
patches in this series refactor loops to use SCX_TIMED_WAIT_UEI, they do not
seem to resolve these specific assertion leaks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014131325.7936=
40-1-cui.tao@linux.dev?part=3D3
