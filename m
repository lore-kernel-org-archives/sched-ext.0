Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BB36F8EE;
	Mon, 31 Aug 2026 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206633; cv=none; b=H68I5baT3aWARBPnLNKeDYNVYi9cOfB0FCHNnPb80EpYNlEyK4lxVM/lt0+L5Y3NX1Ci93Lsp98SU8Ay5HyVS8M1q6Z8LZolabv5AiJTO0++VbyA7M5cM5ibdCPL6ZGpD7/pooiuxzDGJSRPKQ8upTlznKc1duygjQ00WIucqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206633; c=relaxed/simple;
	bh=1QmfLgl3q+3NOcJO1V637zl4DBne7FcMn/KZI8PCokE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=XRRA/64z/+jE+LWB7Ln8ZwQR8s3Atv13ik8PD4/nGSvfusNhENUaBBJjRQTayMCZInJ6fPFNuFCor6C/mSsnQQIdEXG0EShItkQCs5Oa6OAMJYfdyw8bxabqpxIuIZFwkxtGDlqDtfrN6wjQBkKN3llNrkxZ7hTVCkXWLWiMsb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou4kylzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou4kylzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D271F000E9;
	Mon, 31 Aug 2026 20:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788206631;
	bh=uwEYev4hbQssCFX3Ajl7LJ+jjqNx2+bASQjQ+C45CfM=;
	h=Date:From:To:Cc:Subject;
	b=Ou4kylzsI7OJFum7mQcl2w0DgPcjIclRVHn8lID3VJYx03r/G82YRY2m/oOI4SUSd
	 7W72Jsvaziw/7Uiyg3IWiQxAiAiRb0TGXpL1hrbwYNPzhxLfG8B4Ppne2tCvfYdDY6
	 Kr3DnTiQE3bsQ1eZoGdykCXKeGN9nmVHc2TxZAVp6CzSIydxLfIbD6NwUcxEeB9oNq
	 FSF/7e/OXsA0Ymsy9ws1LkO0+o9x+gZH1HnI08nXLtn7mW1XbBRrD7QSHXiTLEyfRs
	 cv7oZ4xAlaxpvQ+GSybFn8xDYheZ0UgECCrRGGykI1S6tUBZ6Px9nmmPx09Dz2mdoa
	 1nuauHRFerz6Q==
Date: Mon, 31 Aug 2026 10:03:50 -1000
Message-ID: <0f59915200a4239f27a624250c58dd6c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [GIT PULL] sched_ext: Fixes for v7.3-rc1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Linus.

The following changes since commit fab183d632628381b466a41479489541ac0e29a0:

  sched_ext: Merge branch 'for-7.3-arena-args' into for-7.3 (2026-08-17 11:20:34 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc1-fixes

for you to fetch changes up to 068e5a0bc57e57d24cbf38def29cc5fb4db9a0df:

  sched_ext: Fix missing @slice and @vtime descriptions in finish_dispatch() kernel-doc (2026-08-31 07:28:04 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.3-rc1

- The task ownership check in the dispatch queue move operation raced
  against the task exiting or moving to a different sub-scheduler,
  spuriously triggering scheduler aborts. Fix by moving the check under
  the queue lock.

- The cgroup bandwidth change callback runs in a sleepable context but
  sleepable implementations were rejected at load time. Allow them and add
  a marker so userspace can detect the capability.

- Sync tooling headers with the scx repo for accumulated compatibility
  improvements.

- Example scheduler fixes: ignored timer re-arm failures and vtime credit
  loss on cgroup migration.

- Documentation and comment fixes.

----------------------------------------------------------------
Changwoo Min (1):
      sched_ext: Allow ops.cgroup_set_bandwidth() to be sleepable

Liang Luo (3):
      sched_ext: Fix nonexistent field in sched-ext.rst example
      Docs/admin-guide/cgroup-v2: document BPF scheduler callbacks for cpu.max and cpu.idle
      sched_ext: Fix missing @slice and @vtime descriptions in finish_dispatch() kernel-doc

Tao Cui (1):
      docs/sched_ext: document that cgroup CPU knobs are scheduler-dependent

Tejun Heo (3):
      sched_ext: Sync tools autogen enum headers from the scx repo
      sched_ext: Sync common and compat headers from the scx repo
      sched_ext: Fix spurious aborts in scx_bpf_dsq_move() on ownership change races

Wanwu Li (4):
      sched_ext: Fix timer pinning and return value in scx_central
      sched_ext: Fix vtime delta loss in scx_flatcg cgroup migration
      sched_ext: Check bpf_timer_start return values in scx_qmap
      sched_ext: Fix several comment issues

 Documentation/admin-guide/cgroup-v2.rst         |  16 +-
 Documentation/scheduler/sched-ext.rst           |  17 +-
 kernel/sched/ext/ext.c                          |  47 +++--
 kernel/sched/ext/internal.h                     |  25 ++-
 tools/sched_ext/include/scx/common.bpf.h        | 140 ++++++++++++---
 tools/sched_ext/include/scx/compat.bpf.h        |  68 ++++++--
 tools/sched_ext/include/scx/compat.h            |  97 +++++++++++
 tools/sched_ext/include/scx/enum_defs.autogen.h |   5 +-
 tools/sched_ext/include/scx/enums_abi.autogen.h | 223 ++++++++++++++++++++++++
 tools/sched_ext/scx_central.bpf.c               |   6 +-
 tools/sched_ext/scx_flatcg.bpf.c                |   2 +-
 tools/sched_ext/scx_qmap.bpf.c                  |   9 +-
 12 files changed, 597 insertions(+), 58 deletions(-)
 create mode 100644 tools/sched_ext/include/scx/enums_abi.autogen.h

Thanks.

-- 
tejun
