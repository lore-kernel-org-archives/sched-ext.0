Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13626ED4F;
	Mon, 17 Aug 2026 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003405; cv=none; b=MqO0olXxiFeEIQYqT4FHs4JRYFbSHDucHSJTmJppGf4S30iPY+YSVlSQntQDhfXmwLzBLj4ZQ3ty+USGy1jOlr7zFmuMbIYKA69RJxqWAMgZVcSpPBISFKrcGeSGi7duNHvmuWm9kLPS/mEJmnF1GigbzI0T34NaW8Jr7Et0m7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003405; c=relaxed/simple;
	bh=fgtLtth6hlDcAFx5tNhQ2Wl1mLz8yEzDeOA7iqutiWU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=BksFTHHm6255K2oTwost65ZS6au7dfT+hF2pTDPIQb3qVvgcAm+I1ueNLG9lX2YfZQ3BNo9omQk8WnSkzpQnWOyr7b1Y4855t9svRSgohMXXkpKJCdz6uusE9UxzEnWe3SWO5vR8OyUeMR2mFd86IlKlDpEheSmZmW6ItDkv5Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k34LIjQl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k34LIjQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7411F000E9;
	Mon, 17 Aug 2026 21:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787003403;
	bh=Kqylp4d3CsgUd7ZIPU6gsyf8TAPtInM6cs7eEJy0vLQ=;
	h=Date:From:To:Cc:Subject;
	b=k34LIjQl1MESUGJrgVUHEhT89WOqZlj9O+Qtf8lDY673R/HhsfXzDN1XQkM4Y5gzG
	 P5NvF1gIM/Ne6T61eZhTZcvlXgzHEUltmZdGh1Xot4kz4lIr2azQOKgYA3j94vkXE9
	 BGAxVqT7GtpU5EKPNHYlOHJDIGFVmTkGE+Ko6I9M3OCJ6Fmf8MQhCVJZXFvuoYSx37
	 yGdGJnyD/d2YmXTtY9mOI4v8t6fIF/Q7TWw5t+x++0KzO1udoEtnuxn2enfkLmhJ0O
	 a213AT3TW9FWM9l7/6qBCN6UZjOmb6ElJh7VQ/daSG9wq25RkGo5qtpE9tVtuieLnI
	 KQWq0EpD3BZtg==
Date: Mon, 17 Aug 2026 11:50:02 -1000
Message-ID: <29c6986172b4eb9ba292643ab4ad9583@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Changes for v7.3
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The following changes since commit d114bb98936770c501c958bf2bc5fb6b7c0bad7b:

  Merge branch 'add-arena-argument-support-to-kfuncs-and-struct_ops' (2026-08-08 03:03:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3

for you to fetch changes up to fab183d632628381b466a41479489541ac0e29a0:

  sched_ext: Merge branch 'for-7.3-arena-args' into for-7.3 (2026-08-17 11:20:34 -1000)

----------------------------------------------------------------
sched_ext: Changes for v7.3

This depends on the arena argument support in the BPF tree and should be
pulled after the scheduler core and BPF pulls. The patches based on bpf-next
were kept on a separate branch which was merged into for-7.3 just now. The
same merged result was in linux-next for several days.

Most of this cycle completes the enqueue-path support for hierarchical
sub-scheduling, which makes sub-scheduler support feature complete: a root
BPF scheduler can now hand a cgroup subtree over to a nested sub-scheduler
together with revocable CPU grants, and the sub-scheduler owns all
scheduling decisions for its tasks on those CPUs.

Development volume was high and a number of changes plugging holes in the
new support landed late in the cycle. Also included are core scheduling
fixes that were completed too late for the v7.2 release and are routed
through this pull request.

- Sub-scheduler CPU delegation:

  - Parent schedulers now grant and revoke per-CPU capabilities (enqueueing,
    preemption, CPU frequency control) on their children, enforced on every
    path a scheduler can reach a CPU through. Previously only dispatching
    could be delegated; this lets sub-schedulers fully schedule their CPUs.

  - Rescue execution: a task whose scheduler doesn't have access to the CPUs
    the task needs to run on starved until the watchdog ejected the whole
    scheduler. The kernel now runs such tasks directly on a small bandwidth
    budget, turning a scheduler-killing failure into bounded degradation.

  - Cgroup integration: tasks migrating across a sub-scheduler boundary
    weren't re-homed to the new owner, causing wrong-scheduler scheduling
    and a use-after-free. Sub-schedulers now take over their cgroup subtree
    and receive its cgroup callbacks.

  - Arena objects now cross the kernel/BPF boundary as typed pointer
    arguments, translated transparently by the BPF tree's new arena argument
    support, replacing untyped arguments with manual translation.

  - scx_qmap now demonstrates full hierarchical sub-scheduling.

- Robustness improvements: the abort path is now NMI-safe, fixing deadlocks
  when errors are raised from NMI context and making hardlockup recovery
  direct. Reenqueue loops that could monopolize a CPU ahead of the watchdog
  now eject the offending scheduler, and stalls are blamed on the scheduler
  actually responsible.

- Hardening: BPF-writable arena memory is validated before kernel use, and
  task slice and vtime writes got explicit synchronization rules, closing
  corruption vectors open to buggy or malicious schedulers.

- Core scheduling: sched_ext dispatching can drop the rq lock inside the
  core-wide pick, which let interleaving selections corrupt each other's
  state and hard-hang the machine. The selection now restarts when the lock
  was released. The task ordering callback was also invoked with its
  arguments swapped, and the default ordering is updated to work across
  sub-scheduler boundaries. The fixes are marked for stable.

- Other fixes headed for stable: a task init leak on fork failure during
  enable, tooling compat macros that silently failed to detect newer
  kernels, and a crash on reenqueueing against a destroyed dispatch queue.

- Tooling: scx_pair moves off deprecated callbacks, and the deprecated
  scx_bpf_cpu_rq() kfunc is removed.

----------------------------------------------------------------
Andrea Righi (3):
      sched_ext: Keep rq tracking accurate in the consume path
      sched_ext: Initialize idle masks as busy
      selftests/sched_ext: Make allowed_cpus idle validation race-free

Cheng-Yang Chou (7):
      sched_ext: Fix exit_cpu accuracy for lockup paths
      sched_ext, rcu: Upgrade RCU stall paths to report cpumask of stalled CPUs
      sched_ext: Convert scx_arena_grow() to use scx_arena_to_kaddr()
      sched_ext: Replace open-coded event lists with SCX_EVENTS_LIST
      sched_ext: Parenthesize local SCX_EVENT defines to fix checkpatch error
      tools/sched_ext: scx_pair: Convert to sched_switch TP
      selftests/sched_ext: Make numa idle validation race-free

Christian Loehle (1):
      sched_ext: Remove deprecated scx_bpf_cpu_rq()

Cui Jian (1):
      sched_ext: Fix stale errno in scx_sub_enable_workfn()

Liang Luo (10):
      tools/sched_ext: fix getopt() option variable signedness
      tools/sched_ext: use btf_vlen() helper in compat.h
      sched_ext: Fix typo in scx_bpf_dsq_insert() comment
      selftests/sched_ext: Fix bpf_link leak on early return in prog_run
      tools/sched_ext: scx_flatcg: Fix uninitialized stats on allocation failure
      tools/sched_ext: scx_qmap: Fix stale API name in comment
      sched_ext: Fix incorrect SCX_PICK_IDLE_CPU_* flag prefix in kernel-doc
      sched_ext: Fix stale @cgroup_id in sched_ext_ops kernel-doc
      sched_ext: Set errno on ENABLING -> ENABLED transition failure
      selftests/sched_ext: Check skeleton open failure in exit test

Michal Blaszczyk (1):
      selftests/sched_ext: Fix flaky ddsp failure tests on busy systems

Pat Somaru (1):
      sched_ext: Add tracepoint for scheduler exit

Randy Dunlap (1):
      sched_ext: Repair kernel-doc comments

Tao Cui (5):
      Documentation: sched_ext: fix events sysfs path and show_state example
      sched_ext: fix stale references in doc comments
      sched_ext/scx_flatcg: expire cached hweights on weight changes
      sched_ext: Don't BUG_ON a destroyed DSQ in process_deferred_reenq_users
      sched_ext/scx_flatcg: Fix cvtime true-up on slice expiry

Tejun Heo (117):
      sched_ext: Merge branch 'for-7.2-fixes' into for-7.3
      sched_ext: Prefix file-local ext.c helpers exposed by the sub.c split
      sched_ext: Expose the ext.c internals used by the sub.c split
      sched_ext: Inline small ext.c helpers shared across the sub.c split
      sched_ext: Split sub-scheduler implementation into sub.c
      Merge branch 'for-7.2-fixes' into for-7.3
      sched_ext: Use READ_ONCE/WRITE_ONCE in cmask word ops and drop _RACY variants
      sched_ext: Add SCX_CALL_CID_OP_TASK() for cid-form op dispatch
      sched_ext: Rename extra_enq_flags to remote_activate_enq_flags
      tools/sched_ext: scx_qmap - Use bare u64/u32/s32 integer types
      sched_ext: Reject direct slice and dsq_vtime writes for cid-form schedulers
      sched_ext: Make scx_bpf_kick_cid() return void
      sched_ext: Assert per-task ops run on the task's owner
      sched_ext: Make the kick machinery per-sched
      sched_ext: Add ops.init_cids() to finalize the cid layout before init
      sched_ext: Add CID sharding
      sched_ext: Add shard boundaries to scx_bpf_cid_override()
      sched_ext: Defer scx_sched kobj sysfs add into the enable workfns
      sched_ext: Add per-shard scx_sched storage scaffolding
      sched_ext: Add scx_cmask_ref for validated arena cmask access
      sched_ext: Build the set_cmask scratch from trusted geometry
      sched_ext: RCU-protect the sub-sched tree's children/sibling lists
      sched_ext: Add scx_skip_subtree_pre()
      sched_ext: Stop resolving a disabled scheduler's programs
      sched_ext: Add per-shard cap delegation for sub-schedulers
      sched_ext: Add coalescing sub_caps_updated() notifier for sub-schedulers
      sched_ext: Maintain per-cpu effective cap copies for single-read checks
      sched_ext: Add sub_ecaps_updated() effective-cap change notifier
      sched_ext: Generalize local-DSQ handling to rq-owned DSQs
      sched_ext: Add reject DSQ for cap-rejected dispatches
      sched_ext: Add SCX_ENQ_IGNORE_CAPS for in-place restore
      sched_ext: Add the SCX_CAP_ENQ_IMMED cap
      sched_ext: Assign a unique id to each scheduler instance
      sched_ext: Route task slice writes through set_task_slice()
      sched_ext: Track the cpu a task is runnable on
      sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice
      sched_ext: Add the SCX_CAP_ENQ cap
      sched_ext: Gate kicks on SCX_CAP_BASE and preemption on SCX_CAP_PREEMPT
      sched_ext: Authorize remote-move inserts against the placing scheduler
      sched_ext: Route ops.update_idle() to sub-schedulers and re-notify owed scheds
      sched_ext: Replay ecaps notifications suppressed by bypass
      sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler
      tools/sched_ext: Add three-mask cmask intersection iterator
      tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling
      tools/sched_ext: scx_qmap - Add sub-sched cap fault injection
      sched_ext: Remove queued ecaps syncs directly on sched teardown
      sched_ext: Move scx_dispatch_sched() to a new inlines.h
      sched_ext: Gate sub_dispatch_prev with CONFIG_EXT_SUB_SCHED
      sched_ext: Add the scx_has_subs static key and gate sub-sched hot paths
      Merge branch 'for-7.2-fixes' into for-7.3
      cgroup: Add cgroup_task_notifier and task migration events
      sched_ext: Factor out scx_rehome_task() and scx_punt_task()
      sched_ext: Relocate scx_cgroup_enabled
      sched_ext: Re-home tasks on cgroup migration
      sched_ext: Deliver cgroup ops to each task_group's sched
      sched_ext: Hand over cgroups at sub-scheduler enable/disable
      tools/sched_ext: scx_qmap - Consume cgroup weights through set_weight
      tools/sched_ext: scx_qmap - Add init fault injection modes
      tools/sched_ext: Add SCX_OPS_CID_OPEN for cid-form schedulers
      sched_ext: Rename the cid-form cgroup ops to cpuctl_*
      sched_ext: Blame the DSQ's owning scheduler for a runnable stall
      sched_ext: Skip the default CPU selection while bypassing
      sched_ext: Drop unused scx_cpumask_to_cmask()
      sched_ext: Build the cid tables privately and publish them with RCU
      tools/sched_ext: Don't restart over a pending exit request
      sched_ext: Gate local DSQ reenq on baseline cid access
      sched_ext: Count kicks denied for lacking baseline cid access
      sched_ext: Factor out scx_cpuperf_set()
      sched_ext: Gate scx_bpf_cidperf_set() behind a new SCX_CAP_PERF
      sched_ext: Add scx_cgroup_sched() for cgrp->scx_sched reads
      sched_ext: Resolve most remaining scx_root accesses
      sched_ext: Use rcu_access_pointer() for the first_task comparison
      sched_ext: Bound per-task reenqueues and eject the owning scheduler
      tools/sched_ext/include: Regenerate enum_defs.autogen.h
      sched_ext: Make exit claiming lock-free
      sched_ext: Format bstr exit messages after claiming the exit
      sched_ext: Report NMI kicks with scx_error()
      sched_ext: Abort directly from the hardlockup handler
      sched_ext: Report scx_link_sched() failures inline
      sched_ext: Rename scx_local_or_reject_dsq() to scx_resolve_local_dsq()
      sched_ext: Make several ext.c helpers available outside ext.c
      sched_ext: Factor out __scx_bpf_now()
      sched_ext: Reject internal enq_flags in the dsq move kfuncs
      sched_ext: Make SCX_ENQ_IGNORE_CAPS waive the preemption cap too
      sched_ext: Synchronize slice and dsq_vtime writes
      sched_ext: Add SCX_TASK_PROTECTED
      sched_ext: Add bandwidth-limited rescue execution for stranded tasks
      sched_ext: Eject the top rescue consumer on overload
      sched_ext: Sync tools autogen enum headers
      sched_ext: scx_qmap - Idle-check pinned tasks before direct dispatch
      sched_ext: scx_qmap - Add rescue support
      Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next into for-7.3-arena-args
      sched/core: Handle pick_task() releasing the rq lock
      sched/core: Make core-sched flips wait for in-flight selections
      sched_ext: Replace SCX_RQ_BAL_KEEP with a dispatch verdict return
      sched_ext: Fix this_rq() assumptions in dispatch kfuncs
      sched_ext: Count rq lock releases in rq->scx.lock_drop_seq
      sched_ext: Fix rq->core_pick corruption under core scheduling
      sched_ext: Merge branch 'for-7.2-fixes' into for-7.3
      Merge branch 'for-7.3' into for-7.3-arena-args
      sched_ext: Pass kernel arena pointers to ops_cid callbacks
      sched_ext: Convert sub-cap kfuncs to __arena cmask arguments
      sched_ext: Convert scx_bpf_cid_override() to __arena array arguments
      sched_ext: Set up ops.sub_ecaps_updated() dispatch context on the executing CPU
      sched_ext: Fix scx_bpf_dsq_reenq___compat kfunc extern prototype
      sched_ext: Drop unlocked scx_rq_clock_invalidate() from scx_root_disable()
      sched_ext: Make scx_bpf_events() read the calling scheduler's counters
      sched_ext: Make SCHED_CLASS_EXT select GENERIC_ALLOCATOR
      sched_ext: Keep kick_sync waiting on the rq's own CPU
      sched_ext: Drop the stale keep_prev fixup in dispatch_pick()
      sched_ext: Rename balance-era identifiers to dispatch terms
      sched_ext: Move the config-off sub-cap kfunc stubs into sub.c
      sched_ext: Fix inverted ops.core_sched_before() invocation
      sched_ext: Use runnable_at for the default core-sched task ordering
      sched_ext: Make core-sched task ordering hierarchy-aware
      sched_ext: Drop the dead SCX_DEQ_CORE_SCHED_EXEC test in dequeue_task_scx()
      sched_ext: Merge branch 'for-7.3-arena-args' into for-7.3

Wanwu Li (1):
      sched_ext/scx_flatcg: Fix cvtime_delta race and add hweight scaling to bypass charging

fangqiurong (3):
      sched_ext: Gate cid kfuncs behind the SCX struct_ops check
      sched_ext: Fix exit_task leak on fork failure during enable
      sched_ext: Fix scx_bpf_dsq_move_to_local___v2 compat detection

 Documentation/scheduler/sched-ext.rst              |   17 +-
 include/linux/cgroup.h                             |   26 +
 include/linux/sched/ext.h                          |   61 +-
 include/trace/events/sched_ext.h                   |   28 +
 init/init_task.c                                   |    1 +
 kernel/Kconfig.preempt                             |    1 +
 kernel/cgroup/cgroup.c                             |   93 +-
 kernel/rcu/tree.c                                  |    3 +
 kernel/rcu/tree_exp.h                              |    5 +-
 kernel/rcu/tree_stall.h                            |   13 +-
 kernel/sched/build_policy.c                        |    3 +
 kernel/sched/core.c                                |   49 +-
 kernel/sched/ext/arena.c                           |   16 +-
 kernel/sched/ext/cid.c                             |  726 +++-
 kernel/sched/ext/cid.h                             |   72 +-
 kernel/sched/ext/ext.c                             | 4043 ++++++++++----------
 kernel/sched/ext/idle.c                            |  117 +-
 kernel/sched/ext/inlines.h                         |  138 +
 kernel/sched/ext/internal.h                        |  804 +++-
 kernel/sched/ext/sub.c                             | 2681 +++++++++++++
 kernel/sched/ext/sub.h                             |  232 ++
 kernel/sched/ext/types.h                           |   88 +-
 kernel/sched/idle.c                                |    8 +-
 kernel/sched/sched.h                               |   40 +-
 tools/sched_ext/include/scx/cid.bpf.h              |   77 +
 tools/sched_ext/include/scx/common.bpf.h           |   32 +-
 tools/sched_ext/include/scx/compat.bpf.h           |   42 +-
 tools/sched_ext/include/scx/compat.h               |   51 +-
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   69 +-
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |    9 +-
 tools/sched_ext/include/scx/enums.autogen.h        |    3 +-
 tools/sched_ext/scx_central.c                      |    2 +-
 tools/sched_ext/scx_cpu0.c                         |    4 +-
 tools/sched_ext/scx_flatcg.bpf.c                   |   22 +-
 tools/sched_ext/scx_flatcg.c                       |    6 +-
 tools/sched_ext/scx_pair.bpf.c                     |  136 +-
 tools/sched_ext/scx_pair.c                         |    2 +-
 tools/sched_ext/scx_qmap.bpf.c                     | 1018 ++++-
 tools/sched_ext/scx_qmap.c                         |  336 +-
 tools/sched_ext/scx_qmap.h                         |  153 +-
 tools/sched_ext/scx_sdt.c                          |    4 +-
 tools/sched_ext/scx_simple.c                       |    4 +-
 tools/sched_ext/scx_userland.c                     |   13 +-
 .../testing/selftests/sched_ext/allowed_cpus.bpf.c |   49 +-
 .../selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c  |   20 +-
 .../selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c |   13 +-
 tools/testing/selftests/sched_ext/exit.c           |    1 +
 tools/testing/selftests/sched_ext/numa.bpf.c       |   28 +-
 tools/testing/selftests/sched_ext/prog_run.c       |   34 +-
 49 files changed, 8805 insertions(+), 2588 deletions(-)
 create mode 100644 kernel/sched/ext/inlines.h
 create mode 100644 kernel/sched/ext/sub.c
 create mode 100644 kernel/sched/ext/sub.h

-- 
tejun
