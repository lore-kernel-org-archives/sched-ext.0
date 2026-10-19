Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428428;
	b=o9ez/DmOw70aiFtEpkrZ6+M0ZoxIz2lrpSQTe2O2+NAD9s1y+lejIpViqsKDqjPRB7xj
	 PyN7EQMlzCOpIEZMAvBeOcxedO8IoRW4DrHec9Sl4W3eNABXc43u7kxb6T7Vtk4ziWh+p
	 NqRUzR33cFraZgpgJTyZfcdGUgyVIlZd5y0CIrpD5G6nzqDCilYuu9AEy9+lXtqGUEfPQ
	 wG+M1phKBKULa9MP0UYHmOQg2XdVnz9qm3vfRr3vTlR4+VD4HLLoD+xuzdWKB1kXuYZHR
	 Q8xDKCzv/p/ZNI3/WaeD5mrw5lK6oLuEAwsEdwevOqsZSik8kYb0stbuaZlTjAIAJPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428428;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject;
	bh=sgeHBu93cL6lui8OFf/oE9agKd4rRXoqSWmLqX9PGBw=;
	b=KAIoXS0aW2UoCCsPQIkekdA4r0Ee2bgqzd8x8+3eK+hfwVotJH/hTVuOkaYlI2KRFWQa
	 R7vkWY9zuXczXR1idYB5Q/yDOjOejPcldQof222ezzRuDOTY7p/pKLtJXIcIFcYDSz9m6
	 RwFlYOawbAcGnUn/qEv/YuGw4kBKt+U6oLEpggZh/Y6fA4YyP21z0IJYMKKOLgOz3YSs+
	 k1GEeoChtjE9CMyztTntpTfQpakUhGLpCX0T/cPHNPKMBqWPwJoo4u8S5vZh9Mrvn+38Q
	 7CYek5YykFHNTaDBgu7fsTt+uFrJzRL+ad4it+x7G4VpwoYbFjAvSqN4ryq220etmBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E7h1pa/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98052606A324;
	Mon, 19 Oct 2026 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E7h1pa/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8841F000C4;
	Mon, 19 Oct 2026 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428427;
	bh=sgeHBu93cL6lui8OFf/oE9agKd4rRXoqSWmLqX9PGBw=;
	h=Date:From:To:Cc:Subject;
	b=E7h1pa/IIcEXZMao2r5Q2iKQiWTEaTgPQ/7ufrlPRkqEp3x1PLjLEWaBZV0Xsp0Fp
	 948A5q8pLCITpxHxzByRTdEOmZK1zyYqtCcKRN+YyhNRYvJvhSbwoNeeFJeBWCnLj4
	 HgwuhOfU3RWanSTSbdggHUf3AQilNUEcGApiwzKJDHAkmt0pKwZfdqoXBasvQCp8b3
	 JRYV5a63bIycEVtxU6HSKbXm4dJ1i4NhY+FyObD0F9Sqqr3cBRRskGE4HKwhVJA25d
	 JLl00dQNXtgxLMFKz8bleAO40IsXqkCMVXpqbnwDoeZccsyv2xYOgCxk+Y3eTFjVqK
	 G4YifhlATY7OQ==
Date: Mon, 19 Oct 2026 06:47:06 -1000
Message-ID: <d66695d960cabf99877acde0c533c03e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Changes for v7.4
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

The following changes since commit 2935062be77113c1c4565ca9d0c72180449aafee:

  sched_ext: Wait for SCX_OPSS_DISPATCHING before moving tasks off DSQs (2026-10-13 09:55:19 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4

for you to fetch changes up to 1f5dde349ac2fca1f119ae8de3f0d2f1c2a8d338:

  sched_ext: Drop the locks periodically while walking a user DSQ for re-enqueue (2026-10-17 20:18:02 -1000)

----------------------------------------------------------------
sched_ext: Changes for v7.4

This depends on sched/core, which carries the sched_ext hooks for proxy
execution, and should be pulled after it. The shortlog and diffstat are
against v7.3 with sched/core merged.

for-7.3-fixes was merged into for-7.4 six times during the cycle, once to
receive a change the CID cluster work built on and otherwise to resolve
conflicts with development here, mostly the proxy execution work.

Five fixes went into for-7.3-fixes in the days before v7.3 was cut and
missed the release. They come in through this pull, three of them marked for
stable: balance callbacks left queued across a pick retry, a use-after-free
on a CPU going offline, and bypass bugs that could stall a task.

- Proxy execution can now be enabled together with sched_ext. A BPF
  scheduler can opt in to receive mutex-blocked tasks that donate their
  scheduling context to the lock owner and place them itself.

- Lazy preemption: a BPF scheduler can preempt or kick a CPU lazily,
  deferring the switch to the next return to user space or tick, as the fair
  class can.

- Sub-schedulers: a parent now learns which child runs on each CPU it
  delegated and when a cap change takes effect. A detaching child loses its
  caps before the parent restores the CPUs.

- New kfuncs re-enqueue single tasks from a dispatch queue iteration and
  report a cgroup's CPU count and a CID's NUMA node. The CID topology now
  includes clusters.

- Hot path optimizations: dispatch queue and task lookups compare keys
  inline, remote task moves no longer take a dispatch queue lock twice, and
  sub-scheduler hooks cost nothing without sub-schedulers.

- Kfuncs callable from tracing programs are hardened against NMI and IRQ
  nesting, which could hard-lock the CPU or pick a wrong idle CPU.

- Built-in dispatch queues no longer allocate per-CPU state that grew with
  the square of the CPU count.

- Header syncs with the scx repo, a BTF workaround for pahole 1.32, and
  selftest fixes and coverage.

----------------------------------------------------------------
Andrea Righi (20):
      sched_ext: Add lazy preemption support
      selftests/sched_ext: Add lazy preemption tests
      sched_ext: Add a CID NUMA node lookup kfunc
      sched_ext: cid: Represent clusters explicitly
      sched_ext: Block proxy donors before taking control
      sched_ext: Fix ops.running/stopping() pairing for proxy-exec donors
      sched_ext: Move reject DSQ draining into core
      sched_ext: Generalize the reject DSQ reenqueue path
      sched_ext: Handle proxy-exec races in remote DSQ transfers
      sched_ext: Split curr|donor references properly
      sched_ext: Track proxy execution for NOHZ_FULL
      sched_ext: Delegate proxy donor admission to BPF schedulers
      sched_ext: Add selftest for blocked donor admission
      sched_ext: scx_qmap: Add proxy execution support
      sched: Allow enabling proxy exec with sched_ext
      sched_ext: Introduce scx_bpf_cgroup_nr_cpus()
      selftests/sched_ext: Test scx_bpf_cgroup_nr_cpus()
      sched_ext: Keep proxy donors with slice left on the local DSQ
      sched_ext: Don't leave balance callbacks queued across a pick retry
      sched_ext: Don't queue balance callbacks from a core-sched pick

Cheng-Yang Chou (4):
      tools/sched_ext: Drop the no-op -rdynamic from CFLAGS
      selftests/sched_ext: Drop -rdynamic and stop clobbering LDFLAGS
      sched_ext: Merge adjacent ifdefs in ext.h
      selftests/sched_ext: Fix rt_stall runner abort

Fuyu Zhao (1):
      tools/sched_ext: Add SCX_OPS_OPEN_OPTS for schedulers using open opts

Hemanth Selam (2):
      sched_ext: Fix typo "upto" in comments
      tools/sched_ext: Fix repeated word 'be' in comment

Samuele Mariotti (1):
      selftests/sched_ext: Fix build error in dequeue_remote selftest

Tao Cui (9):
      sched_ext: Rename tg->scx.idle to tg->scx.sched_idle
      sched_ext: Document the rolling-cursor requirement for dsq_vtime
      sched_ext/scx_flatcg: Make cgv_node_less() wraparound-safe
      selftests/sched_ext: Fix reload_loop error-path use-after-free
      sched_ext: Add SCX_ECODE_RSN_CGROUP_OFFLINE to user_exit_info.h
      selftests/sched_ext: Fail loudly when EXIT_KIND is missing from BTF
      selftests/sched_ext: Add SCX_ASSERT_ALIVE and adopt it
      selftests/sched_ext: Bound exit waits
      selftests/sched_ext: Report reload_loop attach failures

Tejun Heo (23):
      sched_ext: Merge branch 'for-7.3-fixes' into for-7.4
      sched_ext: Merge branch 'sched/core' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into for-7.4
      sched_ext: Work around pahole 1.32 dropping scx_bpf_task_set_lazy_resched() from BTF
      sched_ext: Merge branch 'for-7.3-fixes' into for-7.4
      sched_ext: Sync common and compat headers from the scx repo
      sched_ext: Sync tools autogen enum headers from the scx repo
      sched_ext: Clear a sub-scheduler's caps before ops.sub_detach()
      sched_ext: Add ops.sub_cid_sched_updated() to report the sched running on a cid
      sched_ext: scx_qmap: Size the cid range buffer for large machines
      sched_ext: scx_qmap: Show actual cid use per participant
      sched_ext: Add ops.sub_child_ecaps_updated() to report a child's effective cap changes
      sched_ext: scx_qmap: Reset a child's cpuperf targets once its PERF revoke takes effect
      sched_ext: Merge branch 'for-7.3-fixes' into for-7.4
      sched_ext: Merge branch 'for-7.3-fixes' into for-7.4
      sched_ext: Fix use-after-free of a local reenq node left on an inactive cpu
      sched_ext: Fix the running task keeping its protection into bypass
      sched_ext: Fix a bypassed task stalling on a cpu its scheduler has no caps on
      sched_ext: Merge branch 'for-7.3-fixes' into for-7.4
      sched_ext: Merge branch 'for-7.3-fixes' into for-7.4
      sched_ext: Factor out the rq lock switch of scx_dsq_move()
      sched_ext: Add scx_bpf_dsq_reenq_task() to re-enqueue single tasks from a DSQ iteration
      sched_ext: scx_qmap: Also re-enqueue stranded tasks with scx_bpf_dsq_reenq_task()
      sched_ext: Drop the locks periodically while walking a user DSQ for re-enqueue

Tianyi Chen (4):
      selftests/sched_ext: Fail interrupted test runs
      selftests/sched_ext: Handle CPU hotplug write failures
      selftests/sched_ext: Cover duplicate DSQ creation and ID reuse
      selftests/sched_ext: Validate select_cpu_and mask constraints

Usama Arif (8):
      sched_ext: Specialize the DSQ hashtable compare
      sched_ext: Specialize the TID hashtable compare
      sched_ext: Specialize the scheduler hashtable compare
      sched_ext: Avoid relocking DSQ during remote consumption
      sched_ext: Avoid relocking DSQ during remote DSQ moves
      sched_ext: Update scx_dispatch_dequeue() comments
      sched_ext: Place dsq_vtime next to dsq_priq
      sched_ext: Test scx_has_subs() inline before calling sub-sched hooks

Wanwu Li (3):
      sched_ext: Reject NMI calls to lock-taking kfuncs
      sched_ext: Make scx_locked_rq() return NULL from NMI
      sched_ext: Protect the idle-search scratch nodemask with irqsave

fangqiurong (1):
      sched_ext: Skip per-CPU data allocation for built-in DSQs

 Documentation/scheduler/sched-ext.rst              |   13 +
 include/linux/sched/ext.h                          |   39 +-
 init/Kconfig                                       |    2 -
 kernel/sched/ext/cid.c                             |   67 +-
 kernel/sched/ext/cid.h                             |   11 +-
 kernel/sched/ext/ext.c                             | 1271 ++++++++++++++++----
 kernel/sched/ext/ext.h                             |   32 +-
 kernel/sched/ext/idle.c                            |   14 +-
 kernel/sched/ext/internal.h                        |  196 ++-
 kernel/sched/ext/sub.c                             |  387 ++++--
 kernel/sched/ext/sub.h                             |   50 +-
 kernel/sched/ext/types.h                           |   28 +-
 kernel/sched/sched.h                               |   11 +-
 kernel/sched/syscalls.c                            |    2 +
 tools/sched_ext/Makefile                           |    2 +-
 tools/sched_ext/include/scx/cid.bpf.h              |  689 +++++++++--
 tools/sched_ext/include/scx/common.bpf.h           |   95 +-
 tools/sched_ext/include/scx/compat.bpf.h           |   90 ++
 tools/sched_ext/include/scx/compat.h               |   28 +-
 tools/sched_ext/include/scx/const-defs.h           |   20 +
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   10 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   21 +-
 tools/sched_ext/include/scx/enums.autogen.h        |   22 +-
 tools/sched_ext/include/scx/enums_abi.autogen.h    |   12 +-
 tools/sched_ext/include/scx/features.bpf.h         |   29 +
 tools/sched_ext/include/scx/user_exit_info.h       |    1 +
 tools/sched_ext/scx_flatcg.bpf.c                   |    2 +-
 tools/sched_ext/scx_qmap.bpf.c                     |  269 ++++-
 tools/sched_ext/scx_qmap.c                         |   60 +-
 tools/sched_ext/scx_qmap.h                         |   13 +
 tools/testing/selftests/sched_ext/.gitignore       |    4 +
 tools/testing/selftests/sched_ext/Makefile         |   13 +-
 .../testing/selftests/sched_ext/allowed_cpus.bpf.c |   24 +-
 tools/testing/selftests/sched_ext/allowed_cpus.c   |  129 +-
 .../selftests/sched_ext/cgroup_nr_cpus.bpf.c       |   60 +
 tools/testing/selftests/sched_ext/cgroup_nr_cpus.c |  419 +++++++
 tools/testing/selftests/sched_ext/config           |    3 +
 tools/testing/selftests/sched_ext/create_dsq.bpf.c |   43 +
 tools/testing/selftests/sched_ext/create_dsq.c     |    6 +-
 .../testing/selftests/sched_ext/cyclic_kick_wait.c |    2 +-
 tools/testing/selftests/sched_ext/dequeue_remote.c |    1 +
 .../testing/selftests/sched_ext/enq_blocked.bpf.c  |  116 ++
 tools/testing/selftests/sched_ext/enq_blocked.c    |  917 ++++++++++++++
 tools/testing/selftests/sched_ext/enq_blocked.h    |   28 +
 tools/testing/selftests/sched_ext/exit.c           |    8 +-
 tools/testing/selftests/sched_ext/hotplug.c        |   46 +-
 .../selftests/sched_ext/init_enable_count.bpf.c    |    8 +
 .../selftests/sched_ext/init_enable_count.c        |   13 +
 tools/testing/selftests/sched_ext/kick.bpf.c       |  164 +++
 tools/testing/selftests/sched_ext/kick.c           |  521 ++++++++
 tools/testing/selftests/sched_ext/kick_test.h      |   29 +
 tools/testing/selftests/sched_ext/maximal.bpf.c    |    6 +-
 tools/testing/selftests/sched_ext/maximal.c        |    2 +
 tools/testing/selftests/sched_ext/nohz_tick.bpf.c  |   57 +-
 tools/testing/selftests/sched_ext/nohz_tick.c      |  209 +++-
 tools/testing/selftests/sched_ext/nohz_tick_test.h |   13 +
 tools/testing/selftests/sched_ext/prog_run.c       |    7 +-
 tools/testing/selftests/sched_ext/reload_loop.c    |   49 +-
 tools/testing/selftests/sched_ext/rt_stall.c       |   80 +-
 tools/testing/selftests/sched_ext/runner.c         |    2 +-
 tools/testing/selftests/sched_ext/scx_test.h       |   57 +-
 .../selftests/sched_ext/test_modules/Makefile      |   13 +
 .../sched_ext/test_modules/scx_enq_blocked_test.c  |  195 +++
 tools/testing/selftests/sched_ext/util.c           |  143 +++
 tools/testing/selftests/sched_ext/util.h           |   12 +
 65 files changed, 6166 insertions(+), 719 deletions(-)
 create mode 100644 tools/sched_ext/include/scx/const-defs.h
 create mode 100644 tools/sched_ext/include/scx/features.bpf.h
 create mode 100644 tools/testing/selftests/sched_ext/cgroup_nr_cpus.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/cgroup_nr_cpus.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/kick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/kick.c
 create mode 100644 tools/testing/selftests/sched_ext/kick_test.h
 create mode 100644 tools/testing/selftests/sched_ext/nohz_tick_test.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c

-- 
tejun
