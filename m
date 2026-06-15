Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB503BB116;
	Mon, 15 Jun 2026 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564193; cv=none; b=ZgLqspuADiupWsrb222xT1v4m+k8/rcBnscAW1/6CnEvgGmjWjaVtz+7ezvs7Hrg54wY6l+CWUWL/Id0Z5vuAFjR6yuUyXvyIREhuzGL25YezmW5dnDJ6wx24Gm1VYRaxW4HZClMijkgXWMMvVEgx/+AVVOB3konIILqiIGn7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564193; c=relaxed/simple;
	bh=m/G96n0d0aJxXRfWj+4j5Yx2qFPT4dF+nmSJ754C4F0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=CWQwgs8RrpSj0KQtm1olmjOOM2ObQGyDIkzjcqrGjn2tBYUv+9MOMQ2qk7ue2bWkBdUyMHC3Ouu7lWbNIBabZoxNNmuwmuQuJZjM2sH8NKvk+O8uFPenTrPlcs4Xq/UDQSfOXmzf08l3RuPjmPOTTxub4p8Tw+MWjTMXkZaTN4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHpATBpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHpATBpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680AF1F000E9;
	Mon, 15 Jun 2026 22:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781564191;
	bh=At5mzGkvW6X31LThfZ3ggZqWKvk/yXVbZy25QjfplwA=;
	h=Date:From:To:Cc:Subject;
	b=QHpATBpTH4134R6ZGsz2YXGUWnfUJ33MeClyFv04080pl8J9TIHcKwavOClehJ3Q8
	 TjxZwGii4GCcet82i24haNeLTvk8D9PuzsffjiVTHewmeN3s/JEao6vZnTDaXeLds7
	 i7KEQHBB4uFOQkpXjx5HMUUisdns110eUvostXbgeB62/1bvcf+3gVUHumBfnQYZMR
	 ToNl4UDK+RiGdeKXp1mQuu7RlV3frHtOfdjLChqBYEJSA8COC1u5E7LDz/AG/FTjU+
	 4iLQhrTpLceflNVWgzJr0QvTtP6wn8KfFt1mgarWp/snALlBo3fRopZwOtQFVY18RM
	 FaZFQgg9Hk9UQ==
Date: Mon, 15 Jun 2026 12:56:30 -1000
Message-ID: <6a0da8f90fd3890f734555f1632a3a0f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext changes for v7.2
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The following changes since commit 53cc12a2dc88c2c6f62f507548640885a70a56a8:

  bpf/arena: Add bpf_arena_map_kern_vm_start() and bpf_prog_arena() (2026-05-23 01:50:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2

for you to fetch changes up to 2e05f2fd0dd72aa8aa56cf355e1e39a3f565b4ca:

  sched_ext: Add scx_arena_to_kaddr() / scx_kaddr_to_arena() (2026-06-03 23:57:03 -1000)

----------------------------------------------------------------
sched_ext: Changes for v7.2

This depends on the BPF arena work in bpf-next and should be pulled after
it. for-7.1-fixes was merged in a few times to avoid conflicts with the
feature changes.

- Most of this continues the in-development sub-scheduler support, which
  lets a root BPF scheduler delegate to nested sub-schedulers. The
  dispatch-path building blocks landed in 7.1. A follow-up patchset in
  development will complete enqueue-path support for hierarchical
  scheduling. This cycle adds most of that infrastructure:

  - Topological CPU IDs (cids): a dense, topology-ordered CPU numbering
    where the CPUs of a core, LLC, or NUMA node form contiguous ranges,
    so a topology unit becomes a (start, length) slice. Raw CPU numbers
    are sparse and don't track topological closeness, which makes them
    clumsy for sharding work across sub-schedulers and awkward in BPF.

  - cmask: bitmaps windowed over a slice of cid space, so a sub-scheduler
    can track, for example, the idle cids of its shard without a full
    NR_CPUS cpumask.

  - A struct_ops variant that cid-form sub-schedulers register with,
    along with the cid-form kfuncs they call.

  - BPF arena integration, which sub-scheduler support is built on. The
    bpf-next additions let the kernel read and write the BPF scheduler's
    arena directly, turning it into a real kernel/BPF shared-memory
    channel. Shared state like the per-CPU cmask now lives there.

  - scx_qmap is reworked to exercise the new arena and cid interfaces.

- Exit-dump improvements: dump the faulting CPU first, expose the exit
  CPU to BPF and userspace, and normalize the dump header.

- Misc kfuncs and cleanups: a task-ID lookup kfunc, __printf checking on
  the error and dump formatters, header reorganization, and assorted
  fixes.

----------------------------------------------------------------
Andrea Righi (1):
      sched_ext: Replace tryget_task_struct() with get_task_struct()

Changwoo Min (3):
      sched_ext: Extract scx_dump_cpu() from scx_dump_state()
      sched_ext: Dump the exit CPU first
      sched_ext: Expose exit_cpu to BPF and userspace

Cheng-Yang Chou (9):
      tools/sched_ext: Handle migration-disabled tasks in scx_central
      tools/sched_ext: Remove dead -d option in scx_flatcg
      sched_ext: Documentation: clarify arena-backed doubly-linked lists in scx_qmap
      tools/sched_ext: Remove unused nr_cpus in scx_cpu0
      sched_ext: Normalize exit dump header to "on CPU N"
      selftests/sched_ext: Fix select_cpu_dfl link leak on early return
      tools/sched_ext: scx_qmap: Fix qa arena placement
      sched_ext: idle: Fix errno loss in scx_idle_init()
      selftests/sched_ext: Fix dsq_move_to_local check

Kuba Piecuch (1):
      sched_ext: Documentation: add note about multiple ops.enqueue() calls in a row

Tejun Heo (50):
      sched_ext: scx_qmap: rename tctx to taskc
      sched_ext: scx_qmap: move globals and cpu_ctx into a BPF arena map
      sched_ext: scx_qmap: move task_ctx into a BPF arena slab
      sched_ext: scx_qmap: replace FIFO queue maps with arena-backed lists
      sched_ext: Document the ops compat strategy in compat.h/compat.bpf.h
      Merge branch 'for-7.1-fixes' into for-7.2
      sched_ext: add p->scx.tid and SCX_OPS_TID_TO_TASK lookup
      Merge branch 'for-7.1-fixes' into for-7.2
      Merge branch 'for-7.1-fixes' into for-7.2
      Merge branch 'for-7.1-fixes' into for-7.2
      Merge branch 'for-7.1-fixes' into for-7.2
      sched_ext: Collect ext_*.c include headers in build_policy.c
      sched_ext: Add ext_types.h for early subsystem-wide defs
      sched_ext: Rename ops_cpu_valid() to scx_cpu_valid() and expose it
      sched_ext: Move scx_exit(), scx_error() and friends to ext_internal.h
      sched_ext: Shift scx_kick_cpu() validity check to scx_bpf_kick_cpu()
      sched_ext: Relocate cpu_acquire/cpu_release to end of struct sched_ext_ops
      sched_ext: Make scx_enable() take scx_enable_cmd
      sched_ext: Add topological CPU IDs (cids)
      sched_ext: Add scx_bpf_cid_override() kfunc
      tools/sched_ext: Add struct_size() helpers to common.bpf.h
      sched_ext: Add cmask, a base-windowed bitmap over cid space
      sched_ext: Add cid-form kfunc wrappers alongside cpu-form
      sched_ext: Add bpf_sched_ext_ops_cid struct_ops type
      sched_ext: Forbid cpu-form kfuncs from cid-form schedulers
      tools/sched_ext: scx_qmap: Restart on hotplug instead of cpu_online/offline
      tools/sched_ext: scx_qmap: Add cmask-based idle tracking and cid-based idle pick
      tools/sched_ext: scx_qmap: Port to cid-form struct_ops
      sched_ext: Require cid-form struct_ops for sub-sched support
      sched_ext: Add __printf format attributes to scx_vexit() and bstr formatters
      sched_ext: Use offsetofend on both sides of the ops_cid layout assert
      sched_ext: Fix ops_cid layout assert
      sched_ext: Add scx_task_iter_relock() and use it in scx_root_enable_workfn()
      Merge branch 'for-7.1-fixes' into for-7.2
      sched_ext: Mark !CONFIG_EXT_SUB_SCHED dummy stubs static inline
      Merge branch 'for-7.1-fixes' into for-7.2
      Merge branch 'for-7.1-fixes' into for-7.2
      sched_ext: Rename scx_cmask.nr_bits to nr_cids
      sched_ext: Track bits[] storage size in struct scx_cmask
      sched_ext: Add cmask mask ops
      Merge branch 'arena_direct_access' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next into for-7.2
      sched_ext: Require an arena for cid-form schedulers
      sched_ext: Sub-allocator over kernel-claimed BPF arena pages
      sched_ext: Convert ops.set_cmask() to arena-resident cmask
      sched_ext: Guard BPF arena helper calls to fix 32-bit build
      sched_ext: Order single-cid cmask helpers as (cid, mask)
      tools/sched_ext: Order single-cid cmask helpers as (cid, mask)
      sched_ext: Add scx_cmask_test() and scx_cmask_for_each_cid()
      sched_ext: Make scx_bpf_kick_cid() return s32
      sched_ext: Add scx_arena_to_kaddr() / scx_kaddr_to_arena()

Zhao Mengmeng (3):
      tools/sched_ext: Add missing -c option in scx_qmap help
      sched_ext: Print sub-scheduler disabled log and reason
      selftests/sched_ext: Include common.bpf.h to avoid build failure

Zqiang (1):
      sched_ext: Remove redundant rcu_read_lock/unlock() in sysrq_handle_sched_ext_reset()

 Documentation/scheduler/sched-ext.rst              |    7 +-
 include/linux/sched/ext.h                          |    9 +
 kernel/sched/build_policy.c                        |    9 +
 kernel/sched/ext.c                                 | 1261 ++++++++++++++++----
 kernel/sched/ext_arena.c                           |  131 ++
 kernel/sched/ext_arena.h                           |   18 +
 kernel/sched/ext_cid.c                             |  707 +++++++++++
 kernel/sched/ext_cid.h                             |  271 +++++
 kernel/sched/ext_idle.c                            |   23 +-
 kernel/sched/ext_internal.h                        |  280 ++++-
 kernel/sched/ext_types.h                           |  144 +++
 tools/sched_ext/README.md                          |    6 +-
 tools/sched_ext/include/scx/cid.bpf.h              |  678 +++++++++++
 tools/sched_ext/include/scx/common.bpf.h           |   28 +
 tools/sched_ext/include/scx/compat.bpf.h           |   30 +-
 tools/sched_ext/include/scx/compat.h               |   23 +-
 tools/sched_ext/include/scx/user_exit_info.bpf.h   |    3 +
 tools/sched_ext/include/scx/user_exit_info.h       |    2 +
 .../sched_ext/include/scx/user_exit_info_common.h  |    5 +
 tools/sched_ext/scx_central.bpf.c                  |   10 +-
 tools/sched_ext/scx_cpu0.bpf.c                     |    2 -
 tools/sched_ext/scx_cpu0.c                         |    2 -
 tools/sched_ext/scx_flatcg.c                       |   12 +-
 tools/sched_ext/scx_qmap.bpf.c                     |  890 ++++++++------
 tools/sched_ext/scx_qmap.c                         |  107 +-
 tools/sched_ext/scx_qmap.h                         |   73 ++
 .../selftests/sched_ext/non_scx_kfunc_deny.bpf.c   |    7 +-
 tools/testing/selftests/sched_ext/peek_dsq.bpf.c   |    2 +-
 tools/testing/selftests/sched_ext/select_cpu_dfl.c |   54 +-
 29 files changed, 4090 insertions(+), 704 deletions(-)
 create mode 100644 kernel/sched/ext_arena.c
 create mode 100644 kernel/sched/ext_arena.h
 create mode 100644 kernel/sched/ext_cid.c
 create mode 100644 kernel/sched/ext_cid.h
 create mode 100644 kernel/sched/ext_types.h
 create mode 100644 tools/sched_ext/include/scx/cid.bpf.h
 create mode 100644 tools/sched_ext/scx_qmap.h

--
tejun
