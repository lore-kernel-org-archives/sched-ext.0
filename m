Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622786;
	b=GVqSArRlDC3aHtfnGre0E/sKw+YZtluMM1mQj2osGXfjifq8Yfc99vHU+EdzKwrcgb6J
	 jOKYTJPxhKXqcr0bmWhERVAuRBGYWMvTMmwvqoQlKF2hMfKyeE2d2+Od4c8BWxjo0DiwF
	 5g3LZfShR4aDyiwd/HUAa16JiP7gE919kOqlT1Q4aA5VkgfiWUfxJPbq8+EenPdGg3lRo
	 qYeavTXEbo0Fj3skGbF+yF1xxhsUtA2jowZrEjndhyuSq862dB/k/yAR6pdGpIM0RNg9v
	 Dt0fKlfiPSbpIPnebWBqBHnx6ZMXjMpn6V4Whb76/mmNyrDaXaBrK+C4htCbc2IwaMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xNUmO451eOByjNFfpasrxW6IpYoo7J0z07fmpqy6G+Q=;
	b=4UWllW3cwu95a/Jfo1uS63gHFQzxfr0Jja3kUP+ad8WO+KnqwqTLCkxpnvAx/rOZmDdH
	 jSouiANUDh6ji7C8c16vA4KNajqjkLxKnM4DJs0E+gyhMnoLcZsxHSxPqaLEG3XVTFSLW
	 k6P5VRkaCDREeuT+kdXzxcBTKstw26BOndm8LRJos9P046TW2DrDReeKF8eYfv7wZxQjL
	 13tELRojJpTfWrpFIo8kq9nSrJIJc8vncNy0usl8H3j0v/jg4JhF/hDoLjj3ILdDU1J+0
	 m46Dg42Ouf3hmMfk4sHZesS41BLP6S9ywHv4Tj2pBRQx6g2/o0BuKIDROtW2bV4bBMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXUU43uX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8B606A31E
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXUU43uX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4791F000C4;
	Wed, 25 Nov 2026 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622785;
	bh=xNUmO451eOByjNFfpasrxW6IpYoo7J0z07fmpqy6G+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXUU43uXfZCvAy2VUll3ATw2KWJlc1VzJe6gHKJKxAtW+6mJA0HQhQQbPaGVGJbIO
	 K6BFbQLYMg/WXEEV4y8ARqJQHABehZI8DylTptXzyf60d2vJeTB0SYk5t8rRT+jyGi
	 Wt4PPY9EIohkwfp27KP+0cUl1tgeV/oczE0KtHNuckI2GU2fmvzRSgjtANL0gpZnNx
	 WvS7TJn7szH3ofA1QyEpxr8d57BEKq2DKXJRTXUv1JdTHctAL5mZVIsogdtRZBYYit
	 90FMCyWXXstcsncbU9LOBbU0dZCa4FT1EmHF+CYhhrb0eqnoTybQiMhrKhViACiPqV
	 rZAYT+zEo+MRA==
Message-ID: <sashiko-outbox-233710@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] selftests/sched_ext: Test that
 ops.sub_caps_updated() runs unlocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuba Piecuch" <jpiecuch@google.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261125153353.1364467-3-jpiecuch@google.com>
References: <20261125153353.1364467-1-jpiecuch@google.com>
 <20261125153353.1364467-3-jpiecuch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 16:06:25 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] selftests/sched_ext: colliding fixed map_extra arena mapping
  in sub_caps_ctx
- [Low] selftests/sched_ext: hardcoded /sys/fs/cgroup and hand-rolled
  I/O in setup()
- [Low] selftests/sched_ext: setup() leaks CGRP_PATH directory on error
  paths
- [Low] selftests/sched_ext: run() leaves worker child processes
  unreaped on failure
- [Low] selftests/sched_ext: silent SCX_TEST_SKIP returns in setup()
--

commit 4d12e206bd2b4220ed100124b368c1ee420871bc
Author: Kuba Piecuch <jpiecuch@google.com>

selftests/sched_ext: Test that ops.sub_caps_updated() runs unlocked

This commit adds the sub_caps_ctx selftest to verify that a child
sub-scheduler's ops.sub_caps_updated() callback runs without holding the
parent's rq lock when capabilities are granted or revoked from
ops.enqueue() and ops.select_cid().

> diff --git a/tools/testing/selftests/sched_ext/sub_caps_ctx.bpf.c b/tools=
/testing/selftests/sched_ext/sub_caps_ctx.bpf.c
> new file mode 100644
> index 0000000000000..e6613fc23d15e
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/sub_caps_ctx.bpf.c
> @@ -0,0 +1,136 @@

[ ... ]

> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 1 << 8);
> +#if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
> +	__ulong(map_extra, 0x1ull << 32);
> +#else
> +	__ulong(map_extra, 0x1ull << 44);
> +#endif
> +} arena SEC(".maps");

[Severity: Medium]
Does setting a fixed map_extra address cause the child skeleton's arena
mapping to collide with the parent's?

When map_extra is non-zero, libbpf maps the arena with MAP_FIXED at that
user virtual address.  Because setup() loads both test_ctx.parent and
test_ctx.child in the same process, loading test_ctx.child overwrites
test_ctx.parent's user arena mapping at the same address, and cleanup()
later calls munmap() twice on that range.  Also, 0x1ull << 44 exceeds the
user virtual address space on architectures such as riscv64 SV39, causing
skeleton load to fail.  Since userspace never accesses this arena, can
map_extra be omitted as in enable_cmask.bpf.c and unlocked_kfunc_cid.bpf.c?

[ ... ]

> diff --git a/tools/testing/selftests/sched_ext/sub_caps_ctx.c b/tools/tes=
ting/selftests/sched_ext/sub_caps_ctx.c
> new file mode 100644
> index 0000000000000..5881a6312cb65
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/sub_caps_ctx.c
> @@ -0,0 +1,165 @@

[ ... ]

> +#define CGRP_ROOT	"/sys/fs/cgroup"
> +#define CGRP_PATH	CGRP_ROOT "/sub_caps_ctx"
> +#define NR_WORKERS	8
> +
> +struct ctx {
> +	struct sub_caps_ctx *parent;
> +	struct sub_caps_ctx *child;
> +	struct bpf_link *parent_link;
> +	struct bpf_link *child_link;
> +};
> +
> +static struct ctx test_ctx;
> +
> +static void write_file(const char *path, const char *buf)
> +{
> +	FILE *f =3D fopen(path, "w");
> +
> +	if (!f)
> +		return;
> +	fputs(buf, f);
> +	fclose(f);
> +}

[Severity: Low]
Could this reuse cg_find_unified_root(), cg_write(), cg_create(), and
cg_destroy() from cgroup_util.h (as cgroup_nr_cpus.c does) instead of
hardcoding /sys/fs/cgroup and ignoring errors in write_file()?

If cgroup2 is mounted elsewhere and /sys/fs/cgroup is a tmpfs or cgroup v1
mount, write_file() silently fails or writes a regular file while mkdir()
and stat() in setup() still succeed, causing bpf_map__attach_struct_ops()
for the child in run() to fail with -ENOENT instead of skipping the test.

> +
> +static enum scx_test_status setup(void **ctx)
> +{
> +	struct sub_caps_ctx *skel;
> +	struct stat st;
> +
> +	if (!__COMPAT_struct_has_field("sched_ext_ops_cid", "sub_caps_updated"))
> +		return SCX_TEST_SKIP;
> +
> +	/* a single cid is always the parent's rq, which scx_bpf_cidperf_set() =
accepts */
> +	if (sysconf(_SC_NPROCESSORS_ONLN) < 2)
> +		return SCX_TEST_SKIP;

[Severity: Low]
Should these two skip paths print a reason message explaining which
prerequisite was missing before returning SCX_TEST_SKIP?

> +
> +	write_file(CGRP_ROOT "/cgroup.subtree_control", "+cpu");
> +	if (mkdir(CGRP_PATH, 0755) && errno !=3D EEXIST) {
> +		fprintf(stderr, "Failed to create %s (%s)\n", CGRP_PATH, strerror(errn=
o));
> +		return SCX_TEST_SKIP;
> +	}
> +	SCX_FAIL_IF(stat(CGRP_PATH, &st), "Failed to stat %s", CGRP_PATH);
> +
> +	skel =3D SCX_OPS_CID_OPEN(sub_caps_ctx_ops, sub_caps_ctx);
> +	SCX_OPS_LOAD(skel, sub_caps_ctx_ops, sub_caps_ctx, uei);
> +	test_ctx.parent =3D skel;
> +
> +	skel =3D SCX_OPS_CID_OPEN(sub_caps_ctx_ops, sub_caps_ctx);
> +	skel->struct_ops.sub_caps_ctx_ops->sub_cgroup_id =3D st.st_ino;
> +	SCX_OPS_LOAD(skel, sub_caps_ctx_ops, sub_caps_ctx, uei);
> +	test_ctx.child =3D skel;

[Severity: Low]
Does setup() leak the CGRP_PATH directory if stat() or skeleton loading
fails?  The test runner does not invoke cleanup() when setup() fails or
aborts via SCX_OPS_CID_OPEN() / SCX_OPS_LOAD(), leaving CGRP_PATH behind on
the host cgroup filesystem.

[ ... ]

> +	for (i =3D 0; i < NR_WORKERS; i++) {
> +		pids[i] =3D fork();
> +		SCX_FAIL_IF(pids[i] < 0, "Failed to fork");
> +		if (!pids[i])
> +			worker();
> +	}
> +	for (i =3D 0; i < NR_WORKERS; i++)
> +		SCX_FAIL_IF(waitpid(pids[i], &status, 0) !=3D pids[i] || status,
> +			    "Worker %d failed", i);

[Severity: Low]
If fork() fails after spawning some workers, or waitpid() fails on one
worker, does SCX_FAIL_IF() return without reaping the remaining children?
Because the runner executes all tests in a single process and cleanup()
does not wait on pids[], any remaining workers continue running into
cleanup() and subsequent tests and are left as zombies.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125153353.1364=
467-1-jpiecuch@google.com?part=3D2
