Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599644;
	b=WnIQSEUrwnUvr3jMHi3USQki37akXWgpHHfuIwJSC3mUEEE7JDsEWgD7cToO5uowOKt0
	 bBb4JWM7NkyXMd8NvoeRMJPEs1kxJoDSh+83a5VxCBdkOJfoVIEpge+BgWCtCGy2Uqppw
	 MG9K20lJEQ1E13VrAHuKq09Uz9drZh2Ul72JgRugZ75ANl4r5Aa2NiGnZWCX0iY2+0eX5
	 G/Z0u+ERlnfHhhDtQRC9SgS4sYJQ6BX8RxEieeGdhqFZ3ylCvO8a6VJODe4vh+zM3ku/8
	 C7SDDdTz+ouXzLVaCM5M1yjrJFJibjkVb+aoF7++UYi+zabsVhTQzF3rFx+eNSkQJSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599644;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject;
	bh=q/bn7JNW7WF/yoxMGbb56dtgU/SAiPUVhrjJNbQWL38=;
	b=hjzf2evv8RR6GiLNXakBjuVzFlS8uO3CU2ee0b+b7yIeQQzk92vzgGCjnEj3y0PYBKTy
	 NGq0nnVMmfVA9X+vGBxOBo0JfVt8L5T5hP33NUZLcx3Ud6Tb3zZg5k03vMApHpv9DwYha
	 gsIM5ph7fye1kl6oo0rKlJcWSgjkF/3SincHX5wuZJUNSqOfspHx9iZsUQyVUfCfBgZOh
	 YhN9IMPweWgQLTJoW1A0ICStryOhjvZJw56dESB9b7rMPpPqUetfD+J8ZJZfLNABhpWSu
	 ytDLVIoiUk75+ooS+MNq7h+GSL5lSoR1j0IqqC1ei2iA3cvoq9BGacvasGy4b6aBzAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n0L9QsX/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A6606A31E;
	Wed, 25 Nov 2026 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0L9QsX/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3FD1F000C4;
	Wed, 25 Nov 2026 09:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599643;
	bh=q/bn7JNW7WF/yoxMGbb56dtgU/SAiPUVhrjJNbQWL38=;
	h=Date:From:To:Cc:Subject;
	b=n0L9QsX/d8kWjYqDTCBCY3HGUceaozyL96nVU165HqvClPdX/D02+Cee+0OHSwAvu
	 pbw0f/x2e3V1ZpKPZpyHGSp7RbHFrx9joyMlOwSL7wMZM3DLGAYwxohckV/sCSH4ZJ
	 a5b7deHc3jU0EGi738dN26LgcXzFM62aS85VC6fMH6oNVUsERG3rLNbkJnviTRooe7
	 T9uKmX3Qtmn/Kl/4oolO1cISUfbAT32Cz8Kjg2vfrgvzzoqgeWUcO1/Q6QejoTO2/3
	 vgcrbLcbB6zsRQI/cEfN7yq9+9SFChKqp8plASwx1Lel8nAubOK/zKbUdJD1gUznoL
	 sTYVkUXXaa7LQ==
Date: Tue, 24 Nov 2026 23:40:42 -1000
Message-ID: <64abac4b00009285ade1874468a34990@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.4-rc4
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

The following changes since commit 700a332c3fe33014bbd5ae852d71ba679fc29e0a:

  sched_ext: Reject DSQ iterator kfuncs in tracing programs (2026-11-12 07:30:07 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4-rc4-fixes

for you to fetch changes up to 97e1c7d467d07734f8f5c8c64730e1f7c415bd46:

  sched_ext: Attach fair_server before tasks fall back to fair on disable (2026-11-24 22:48:52 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.4-rc4

- Scheduler enable and disable could race with tasks changing class: on
  enable, a task could switch to sched_ext before the scheduler core started
  picking sched_ext tasks and be left runnable while its CPU went idle. On
  disable, an RT task could starve the tasks falling back to the fair class
  and stall the disable itself.

- BPF schedulers failed to load on architectures whose BPF JIT doesn't
  support private stacks, such as riscv64. Only sub-schedulers need them and
  are now refused there instead.

- The debug dump and CPU ID layout callbacks could call kfuncs that move
  tasks around. They are now rejected at load time.

- Smaller fixes: a task's first enqueue after fork didn't tell the BPF
  scheduler that CPU selection had already run, and two kfuncs raised a
  false RCU lockdep warning in BPF timer callbacks.

----------------------------------------------------------------
Cheng-Yang Chou (1):
      sched_ext: Don't request private stacks the JIT can't provide

Hang Zhengyang (1):
      sched_ext: Attach fair_server before tasks fall back to fair on disable

Kuba Piecuch (4):
      sched_ext: Don't route tasks to SCX before __scx_enabled is fully patched
      sched_ext: Fix suspicious RCU usage in KF_RCU_PROTECTED kfuncs
      sched_ext: Don't allow unlocked kfuncs from ops.dump() and ops.init_cids()
      selftests/sched_ext: Add unlocked_kfunc test

Tao Cui (1):
      sched/core: Pass ENQUEUE_RQ_SELECTED on initial enqueue

 kernel/sched/core.c                                |  5 +-
 kernel/sched/ext/ext.c                             | 79 +++++++++++++++-------
 kernel/sched/ext/sub.c                             |  6 ++
 tools/testing/selftests/sched_ext/Makefile         |  1 +
 .../selftests/sched_ext/unlocked_kfunc.bpf.c       | 69 +++++++++++++++++++
 tools/testing/selftests/sched_ext/unlocked_kfunc.c | 73 ++++++++++++++++++++
 .../selftests/sched_ext/unlocked_kfunc_cid.bpf.c   | 67 ++++++++++++++++++
 .../sched_ext/unlocked_kfunc_fail_dump.bpf.c       | 26 +++++++
 .../sched_ext/unlocked_kfunc_fail_init_cids.bpf.c  | 22 ++++++
 9 files changed, 323 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/unlocked_kfunc.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/unlocked_kfunc.c
 create mode 100644 tools/testing/selftests/sched_ext/unlocked_kfunc_cid.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/unlocked_kfunc_fail_dump.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/unlocked_kfunc_fail_init_cids.bpf.c

-- 
tejun
