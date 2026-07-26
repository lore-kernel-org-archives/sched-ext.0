Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693F29AAEA
	for <sched-ext@lists.linux.dev>; Sun, 26 Jul 2026 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785049110; cv=none; b=NzeyKSpqbiZ7OUNSG//i3W0NfnZkup08tIUisNOsWmGISaKBPY0wcI8ppyQ1pAU/hDJ0Ww7aaGMD6CGAU+UPtGW5UhbJpuw1ixSbeUzkFoZs3tvmylBnhvS5s5j9PU5oEiPFzavLZYz124rlCyx/FMz9fpHv54TqzdXZ0FcYHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785049110; c=relaxed/simple;
	bh=GdC4PEXklmvb8jMjYNBec1IGfdd/z9wiEnKnwh/Qn2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nEkWzBy4vQFs8tDp1nQAU3vyT0lqbOLWTjTQcgdQzxUpsN2e2aLSPW2KKwJvHuQBizrqwJ/rfY3b+SfHbHrFkX0oGh9DQvLJ+XmZdLmu3B5llmQw07DxtL5GIDjdpxesy7PQBbwah8stNt8+7dxH7N/wc5LBO0i5GqyGrXMdzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OY66Xjs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OY66Xjs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7868B1F000E9;
	Sun, 26 Jul 2026 06:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785049108;
	bh=zqK8YpkwbbZBWekRKz/gn24stdI1FRk8LmuZAuCfbbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OY66Xjs6vybT+9EX6nwaQp9yliB0U5ed9nLoFrmZdQaD7FHzOCwcwjHCQlODvBb0K
	 0m8GxHgPwqTqogngTQpYIuUguPcAvkoVkmAGIy39iyt7L8gKOfskc0MvO/a5jJcsOd
	 2FPuLGdltOMs3NE11wlVReYQxWPi3C/+BsyN9ep8dieX1wqSZlOX5jF9eiiVRrG4sE
	 ZSaWiOWSBC0ysBvTvotpH1aM1bnujBoEH3H0FJkE3iXRdClziVlE62v+zpq2pvj8rI
	 XITjwAjynGFyObKCdwyEavzbc0R5G/2PNbX85ifgQurf3dDqLnzRNMcVRGT6G2JOjB
	 uJKH8WGGcoNkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.2-fixes] selftests/sched_ext: Make
 allowed_cpus idle validation race-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260726064754.378671-1-arighi@nvidia.com>
References: <20260726064754.378671-1-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 06:58:28 +0000
Message-Id: <20260726065828.7868B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The selftest uses a fixed-size `cpu_set_t` for `sched_getaffinit=
y()`, which fails with `-EINVAL` on systems with a large number of configur=
ed CPUs (e.g., `nr_cpu_ids > 1024`), causing the test to fail unconditional=
ly.
- [Medium] The test's bootstrap phase incorrectly assumes full access to al=
l system CPUs, leading to false positive test failures when run in restrict=
ed environments (e.g., taskset or cgroups).
--

--- Patch [1]: [PATCH sched_ext/for-7.2-fixes] selftests/sched_ext: Make al=
lowed_cpus idle validation race-free ---
commit 2ede7dc703cde549d449386a7878e3392244c530
Author: Andrea Righi <arighi@nvidia.com>

selftests/sched_ext: Make allowed_cpus idle validation race-free

This patch updates the allowed_cpus sched_ext selftest to make idle CPU
validation race-free. It shifts validation to the stable local invariant in
ops.select_cpu() and adds a bootstrap phase to refresh the idle masks.

> diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c b/tools=
/testing/selftests/sched_ext/allowed_cpus.bpf.c
> index 35923e74a2ec3..4a14b05065453 100644
> --- a/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> +++ b/tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
[ ... ]
> @@ -13,17 +13,46 @@ char _license[] SEC("license") =3D "GPL";
>  UEI_DEFINE(uei);
> =20
>  private(PREF_CPUS) struct bpf_cpumask __kptr * allowed_cpumask;
> +volatile bool refresh_idle_masks;
> =20
>  static void
> -validate_idle_cpu(const struct task_struct *p, const struct cpumask *all=
owed, s32 cpu)
> +validate_local_idle_state(void)
>  {
> -	if (scx_bpf_test_and_clear_cpu_idle(cpu))
> -		scx_bpf_error("CPU %d should be marked as busy", cpu);
> +	struct task_struct *curr;
> +	s32 cpu =3D bpf_get_smp_processor_id();
> +	bool curr_is_idle;
> =20
> -	if (bpf_cpumask_subset(allowed, p->cpus_ptr) &&
> -	    !bpf_cpumask_test_cpu(cpu, allowed))
> +	bpf_rcu_read_lock();
> +	curr =3D scx_bpf_cpu_curr(cpu);
> +	curr_is_idle =3D curr && (curr->flags & PF_IDLE);
> +	bpf_rcu_read_unlock();
> +
> +	/*
> +	 * Unlike a remote selected CPU, the local CPU cannot go through an
> +	 * idle re-pick while this callback is running. If it is running a
> +	 * non-idle scheduling context, it must not be advertised as idle.
> +	 */
> +	if (!curr_is_idle && scx_bpf_test_and_clear_cpu_idle(cpu) && !refresh_i=
dle_masks)
> +		scx_bpf_error("running CPU %d should be marked as busy", cpu);

[Severity: Medium]
Could this validation fail if it runs on CPUs that userspace skips during t=
he
bootstrap phase?

Because the BPF scheduler is attached host-wide, background tasks waking up=
 on
the skipped CPUs could trigger ops.select_cpu(), executing this check. If
these CPUs were not refreshed because they weren't in the initial affinity
mask, their state might be stale and trigger a false positive error here.

> +}
[ ... ]
> diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c b/tools/tes=
ting/selftests/sched_ext/allowed_cpus.c
> index 093f285ab4bae..eb1708e55982b 100644
> --- a/tools/testing/selftests/sched_ext/allowed_cpus.c
> +++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
[ ... ]
> @@ -47,14 +48,51 @@ static int test_select_cpu_from_user(const struct all=
owed_cpus *skel)
>  	return 0;
>  }
> =20
> +/*
> + * Run this task once on every CPU while ops.running() repairs the boots=
trap
> + * idle state. Once a CPU has been refreshed, subsequent idle transition=
s keep
> + * its state up to date.
> + */
> +static int refresh_idle_masks(void)
> +{
> +	cpu_set_t original, one;
> +	int cpu, ret =3D 0;
> +
> +	if (sched_getaffinity(0, sizeof(original), &original))
> +		return -errno;

[Severity: Medium]
Will this fail unconditionally on systems with a large number of CPUs?

The sched_getaffinity() syscall explicitly checks if the provided buffer le=
ngth
in bits is less than nr_cpu_ids. Because cpu_set_t is typically fixed at 10=
24
bits, a system configured with nr_cpu_ids > 1024 would return -EINVAL here =
and
abort the test suite.

> +
> +	for (cpu =3D 0; cpu < CPU_SETSIZE; cpu++) {
> +		if (!CPU_ISSET(cpu, &original))
> +			continue;

[Severity: Medium]
Does skipping CPUs outside the initial affinity mask leave their idle state=
 out
of sync?

In environments that use cgroups or tasksets to restrict the test's CPU
affinity, these skipped CPUs won't have their idle masks refreshed, which
could lead to the false positive test failures in validate_local_idle_state=
()
mentioned above.

> +
> +		CPU_ZERO(&one);
> +		CPU_SET(cpu, &one);
> +		if (sched_setaffinity(0, sizeof(one), &one)) {
> +			ret =3D -errno;
> +			break;
> +		}
> +
> +		sched_yield();
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726064754.3786=
71-1-arighi@nvidia.com?part=3D1
