Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D936073E;
	Mon, 13 Apr 2026 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104853; cv=none; b=liXm0nikpyPL652Q7SFCEFELIpJs6+jcbnJdtMsTh9vQDFQ7ymQk6nMC1TFSEGZAwqgA6nvFJQDW9w/WN9s3TdKkU0gJaifRQi5Oi5n+gw0wYC8hsRvYDoAHTOrDagbw8rzTkifuiVIx0SKdHl1SVcoEXRc1pDWXQ3IETLpa1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104853; c=relaxed/simple;
	bh=3r6CgjzY7X8UX7U4zFaccuggfFK3XJt6gquWEBMuymk=;
	h=Date:Message-ID:From:To:Cc:Subject; b=pc7K/i0zmUY50SbFNZyZ3+BiMzb4GCLCIJoqDYwxWkQelZCFHaXXpVpAfcBg9booGHOKG2osCSZgsIbt4h7fFCJuffag/4H5DkM5yL2HOvfQ4iks5qix4UN+QSUlypEFx9f/UF6yIdB+FW1Lr3z22NnePUc6XJQqH7y54Pr9zgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjlneUZE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjlneUZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CA2C2BCAF;
	Mon, 13 Apr 2026 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776104853;
	bh=3r6CgjzY7X8UX7U4zFaccuggfFK3XJt6gquWEBMuymk=;
	h=Date:From:To:Cc:Subject:From;
	b=TjlneUZEwBrd6mE6G6S4ao06NGeZhhwdQ4bufCGe7ywXxxOfi7D7LCbFAHWbMmpXB
	 s3qvnqdzowm8nElKxIry3tcNwPbivHGdQiqoWbUHL3W9gWNS191zJmLN9a0rylhO54
	 l5M5gcHdbrwAkgygnB6LOt/w3FVYEq2SPrJhWNslO6c4yEaCGDi37ROfd1cz53i/OL
	 sXL2nY+KyEhtMZlSKpqylwWFcrLJmXNwD/shZn7IJ+VEvE6CTyJxGeqso7WNr+hyHR
	 cL+Jr2f3GthmQkM1tZGavbMf/WAt8P/sUsS0oI4cvOEIU2XOsG6Ngzvnke2m9lPDVZ
	 tBfpYAcn8QFeQ==
Date: Mon, 13 Apr 2026 08:27:32 -1000
Message-ID: <d9b4c8a00c64192691e22954d09574d1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext changes for v7.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

This depends on tip/sched-core and cgroup/for-7.1 and should be pulled
after both.

The following changes since commit 7e0ffb72de8aa3b25989c2d980e81b829c577010:

  sched_ext: Fix stale direct dispatch state in ddsp_dsq_id (2026-04-03 07:14:49 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1

for you to fetch changes up to 7e311bafb9ad3a4711c08c00b09fb7839ada37f0:

  tools/sched_ext: Add explicit cast from void* in RESIZE_ARRAY() (2026-04-13 06:14:11 -1000)

----------------------------------------------------------------
sched_ext: Changes for v7.1

- Cgroup sub-scheduler groundwork. Multiple BPF schedulers can be
  attached to cgroups and the dispatch path is made hierarchical. This
  involves substantial restructuring of the core dispatch, bypass,
  watchdog, and dump paths to be per-scheduler, along with new
  infrastructure for scheduler ownership enforcement, lifecycle
  management, and cgroup subtree iteration. The enqueue path is not yet
  updated and will follow in a later cycle.

- scx_bpf_dsq_reenq() generalized to support any DSQ including remote
  local DSQs and user DSQs. Built on top of this, SCX_ENQ_IMMED
  guarantees that tasks dispatched to local DSQs either run immediately
  or get reenqueued back through ops.enqueue(), giving schedulers tighter
  control over queueing latency. Also useful for opportunistic CPU
  sharing across sub-schedulers.

- ops.dequeue() was only invoked when the core knew a task was in BPF
  data structures, missing scheduling property change events and skipping
  callbacks for non-local DSQ dispatches from ops.select_cpu(). Fixed to
  guarantee exactly one ops.dequeue() call when a task leaves BPF
  scheduler custody.

- Kfunc access validation moved from runtime to BPF verifier time,
  removing runtime mask enforcement.

- Idle SMT sibling prioritization in the idle CPU selection path.

- Documentation, selftest, and tooling updates. Misc bug fixes and
  cleanups.

- Merges from tip/sched-core, cgroup/for-7.1, and for-7.0-fixes to
  resolve dependencies and conflicts for the above changes.

----------------------------------------------------------------
Andrea Righi (11):
      sched_ext: Properly mark SCX-internal migrations via sticky_cpu
      sched_ext: Add rq parameter to dispatch_enqueue()
      sched_ext: Fix ops.dequeue() semantics
      selftests/sched_ext: Add test to validate ops.dequeue() semantics
      sched_ext: Pass full dequeue flags to ops.quiescent()
      selftests/sched_ext: Update scx_bpf_dsq_move_to_local() in kselftests
      sched_ext: idle: Prioritize idle SMT sibling
      sched_ext: Guard cpu_smt_mask() with CONFIG_SCHED_SMT
      tools/sched_ext: Add compat handling for sub-scheduler ops
      sched_ext: Documentation: Clarify ops.dispatch() role in task lifecycle
      sched_ext: Documentation: Add ops.dequeue() to task lifecycle

Cheng-Yang Chou (19):
      sched_ext: Fix scx_bpf_reenqueue_local() silently reenqueuing nothing
      sched_ext: Fix incomplete help text usage strings
      sched_ext: Fix uninitialized ret in scx_alloc_and_add_sched()
      sched_ext/selftests: Fix incorrect include guard comments
      sched_ext: Update demo schedulers and selftests to use scx_bpf_task_set_dsq_vtime()
      sched_ext: Update selftests to drop ops.cpu_acquire/release()
      sched_ext: Fix slab-out-of-bounds in scx_alloc_and_add_sched()
      selftests/sched_ext: Show failed test names in summary
      sched_ext: Fix build errors and unused label warning in non-cgroup configs
      tools/sched_ext: Add scx_bpf_sub_dispatch() compat wrapper
      sched_ext: Fix invalid kobj cast in scx_uevent()
      selftests/sched_ext: Skip rt_stall on older kernels and list skipped tests
      tools/sched_ext: Regenerate autogen enum headers
      sched_ext: Fix missing return after scx_error() in scx_dsq_move()
      sched_ext: Fix missing SCX_EV_SUB_BYPASS_DISPATCH aggregation in scx_read_events()
      sched_ext: Document why built-in DSQs are unsupported sources in scx_bpf_dsq_move_to_local()
      tools/sched_ext: Fix off-by-one in scx_sdt payload zeroing
      selftests/sched_ext: Improve runner error reporting for invalid arguments
      sched_ext: Remove runtime kfunc mask enforcement

David Carlier (2):
      sched_ext: Optimize sched_ext_entity layout for cache locality
      selftests/sched_ext: Add missing error check for exit__load()

Ke Zhao (1):
      tools/sched_ext: Update stale scx_ops_error() comment in fcg_cgroup_move()

Kuba Piecuch (3):
      sched_ext: Documentation: improve accuracy of task lifecycle pseudo-code
      sched_ext: Make string params of __ENUM_set() const
      tools/sched_ext: Add explicit cast from void* in RESIZE_ARRAY()

Philipp Hahn (1):
      sched: Prefer IS_ERR_OR_NULL over manual NULL check

Samuele Mariotti (1):
      sched_ext: Fix missing warning in scx_set_task_state() default case

Tejun Heo (92):
      Merge branch 'for-7.0-fixes' into for-7.1
      Merge branch 'for-7.1' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup into for-7.1
      sched_ext: Implement cgroup subtree iteration for scx_task_iter
      sched_ext: Add @kargs to scx_fork()
      sched/core: Swap the order between sched_post_fork() and cgroup_post_fork()
      sched_ext: Update p->scx.disallow warning in scx_init_task()
      sched_ext: Reorganize enable/disable path for multi-scheduler support
      sched_ext: Introduce cgroup sub-sched support
      sched_ext: Introduce scx_task_sched[_rcu]()
      sched_ext: Introduce scx_prog_sched()
      sched_ext: Enforce scheduling authority in dispatch and select_cpu operations
      sched_ext: Enforce scheduler ownership when updating slice and dsq_vtime
      sched_ext: scx_dsq_move() should validate the task belongs to the right scheduler
      sched_ext: Refactor task init/exit helpers
      sched_ext: Make scx_prio_less() handle multiple schedulers
      sched_ext: Move default slice to per-scheduler field
      sched_ext: Move aborting flag to per-scheduler field
      sched_ext: Move bypass_dsq into scx_sched_pcpu
      sched_ext: Move bypass state into scx_sched
      sched_ext: Prepare bypass mode for hierarchical operation
      sched_ext: Factor out scx_dispatch_sched()
      sched_ext: When calling ops.dispatch() @prev must be on the same scx_sched
      sched_ext: Separate bypass dispatch enabling from bypass depth tracking
      sched_ext: Implement hierarchical bypass mode
      sched_ext: Dispatch from all scx_sched instances
      sched_ext: Move scx_dsp_ctx and scx_dsp_max_batch into scx_sched
      sched_ext: Make watchdog sub-sched aware
      sched_ext: Convert scx_dump_state() spinlock to raw spinlock
      sched_ext: Support dumping multiple schedulers and add scheduler identification
      sched_ext: Implement cgroup sub-sched enabling and disabling
      sched_ext: Add scx_sched back pointer to scx_sched_pcpu
      sched_ext: Make scx_bpf_reenqueue_local() sub-sched aware
      sched_ext: Factor out scx_link_sched() and scx_unlink_sched()
      sched_ext: Add rhashtable lookup for sub-schedulers
      sched_ext: Add basic building blocks for nested sub-scheduler dispatching
      Merge branch 'for-7.0-fixes' into for-7.1
      sched_ext: Relocate scx_bpf_task_cgroup() and its BTF_ID to the end of kfunc section
      sched_ext: Wrap global DSQs in per-node structure
      sched_ext: Factor out pnode allocation and deallocation into helpers
      sched_ext: Change find_global_dsq() to take CPU number instead of task
      sched_ext: Relocate run_deferred() and its callees
      sched_ext: Convert deferred_reenq_locals from llist to regular list
      sched_ext: Wrap deferred_reenq_local_node into a struct
      sched_ext: Introduce scx_bpf_dsq_reenq() for remote local DSQ reenqueue
      sched_ext: Add reenq_flags plumbing to scx_bpf_dsq_reenq()
      sched_ext: Add per-CPU data to DSQs
      sched_ext: Factor out nldsq_cursor_next_task() and nldsq_cursor_lost_task()
      sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs
      sched_ext: Optimize schedule_dsq_reenq() with lockless fast path
      sched_ext: Simplify task state handling
      sched_ext: Add SCX_TASK_REENQ_REASON flags
      Revert "sched_ext: Use READ_ONCE() for the read side of dsq->nr update"
      tools/sched_ext/include: Remove dead sdt_task_defs.h guard from common.h
      tools/sched_ext/include: Sync bpf_arena_common.bpf.h with scx repo
      tools/sched_ext/include: Add missing helpers to common.bpf.h
      tools/sched_ext/include: Add __COMPAT_HAS_scx_bpf_select_cpu_and macro
      tools/sched_ext/include: Add libbpf version guard for assoc_struct_ops
      tools/sched_ext/include: Regenerate enum_defs.autogen.h
      Merge branch 'for-7.0-fixes' into for-7.1
      Merge branch 'sched/core' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into for-7.1
      sched_ext: Replace system_unbound_wq with system_dfl_wq in scx_kobj_release()
      sched_ext: Fix sub_detach op check to test the parent's ops
      sched_ext: Add scx_dump_lock and dump_disabled
      sched_ext: Always bounce scx_disable() through irq_work
      sched_ext: Fix scx_sched_lock / rq lock ordering
      sched_ext: Reject sub-sched attachment to a disabled parent
      sched_ext: Split task_should_reenq() into local and user variants
      sched_ext: Add scx_vet_enq_flags() and plumb dsq_id into preamble
      sched_ext: Implement SCX_ENQ_IMMED
      sched_ext: Plumb enq_flags through the consume path
      sched_ext: Add enq_flags to scx_bpf_dsq_move_to_local()
      sched_ext: Add SCX_OPS_ALWAYS_ENQ_IMMED ops flag
      sched_ext: Use schedule_deferred_locked() in schedule_dsq_reenq()
      sched_ext: Fix cgroup double-put on sub-sched abort path
      sched_ext: Use kobject_put() for kobject_init_and_add() failure in scx_alloc_and_add_sched()
      sched_ext: Use irq_work_queue_on() in schedule_deferred()
      tools/sched_ext: Remove redundant SCX_ENQ_IMMED compat definition
      Revert "docs: Raise minimum pahole version to 1.26 for KF_IMPLICIT_ARGS kfuncs"
      Revert "selftests/sched_ext: Add tests for SCX_ENQ_IMMED and scx_bpf_dsq_reenq()"
      Merge branch 'for-7.0-fixes' into for-7.1
      Merge branch 'for-7.0-fixes' into for-7.1
      sched_ext: Drop TRACING access to select_cpu kfuncs
      sched_ext: Add select_cpu kfuncs to scx_kfunc_ids_unlocked
      sched_ext: Track @p's rq lock across set_cpus_allowed_scx -> ops.set_cpumask
      sched_ext: Fix ops.cgroup_move() invocation kf_mask and rq tracking
      sched_ext: Decouple kfunc unlocked-context check from kf_mask
      sched_ext: Drop redundant rq-locked check from scx_bpf_task_cgroup()
      sched_ext: Add verifier-time kfunc context filter
      sched_ext: Rename scx_kf_allowed_on_arg_tasks() to scx_kf_arg_task_ok()
      sched_ext: Warn on task-based SCX op recursion
      sched_ext: Drop spurious warning on kick during scheduler disable
      tools/sched_ext: Kick home CPU for stranded tasks in scx_qmap

Zhao Mengmeng (3):
      sched_ext: remove SCX_OPS_HAS_CGROUP_WEIGHT
      tools/sched_ext: scx_pair: fix pair_ctx indexing for CPU pairs
      scx_central: Defer timer start to central dispatch to fix init error

Zqiang (1):
      sched_ext: Choose the right sch->ops.name to output in the print_scx_info()

fangqiurong (2):
      sched_ext: Documentation: Fix scx_bpf_move_to_local kfunc name
      selftests/sched_ext: Fix wrong DSQ ID in peek_dsq error message

zhidao su (5):
      sched_ext: Fix typos in comments
      sched_ext: Documentation: Document events sysfs file and module parameters
      selftests/sched_ext: Return non-zero exit code on test failure
      selftests/sched_ext: Add tests for SCX_ENQ_IMMED and scx_bpf_dsq_reenq()
      docs: Raise minimum pahole version to 1.26 for KF_IMPLICIT_ARGS kfuncs

 Documentation/scheduler/sched-ext.rst              |  205 +-
 include/linux/cgroup-defs.h                        |    4 +
 include/linux/sched/ext.h                          |  109 +-
 init/Kconfig                                       |    4 +
 kernel/fork.c                                      |    6 +-
 kernel/sched/core.c                                |    2 +-
 kernel/sched/ext.c                                 | 4199 +++++++++++++++-----
 kernel/sched/ext.h                                 |    4 +-
 kernel/sched/ext_idle.c                            |  199 +-
 kernel/sched/ext_idle.h                            |    2 +
 kernel/sched/ext_internal.h                        |  344 +-
 kernel/sched/sched.h                               |   12 +-
 tools/sched_ext/include/scx/bpf_arena_common.bpf.h |    8 +-
 tools/sched_ext/include/scx/common.bpf.h           |  277 ++
 tools/sched_ext/include/scx/common.h               |    5 +-
 tools/sched_ext/include/scx/compat.bpf.h           |   57 +-
 tools/sched_ext/include/scx/compat.h               |   52 +-
 tools/sched_ext/include/scx/enum_defs.autogen.h    |   61 +-
 tools/sched_ext/include/scx/enums.autogen.bpf.h    |   11 +
 tools/sched_ext/include/scx/enums.autogen.h        |    4 +
 tools/sched_ext/include/scx/enums.h                |    2 +-
 tools/sched_ext/scx_central.bpf.c                  |   66 +-
 tools/sched_ext/scx_central.c                      |   26 +-
 tools/sched_ext/scx_cpu0.bpf.c                     |    2 +-
 tools/sched_ext/scx_flatcg.bpf.c                   |   24 +-
 tools/sched_ext/scx_pair.c                         |   16 +-
 tools/sched_ext/scx_qmap.bpf.c                     |  214 +-
 tools/sched_ext/scx_qmap.c                         |   29 +-
 tools/sched_ext/scx_sdt.bpf.c                      |    5 +-
 tools/sched_ext/scx_sdt.c                          |    2 +-
 tools/sched_ext/scx_simple.bpf.c                   |    8 +-
 tools/sched_ext/scx_userland.c                     |    2 +-
 tools/testing/selftests/sched_ext/Makefile         |    1 +
 tools/testing/selftests/sched_ext/dequeue.bpf.c    |  389 ++
 tools/testing/selftests/sched_ext/dequeue.c        |  274 ++
 tools/testing/selftests/sched_ext/exit.bpf.c       |    2 +-
 tools/testing/selftests/sched_ext/exit.c           |    2 +-
 tools/testing/selftests/sched_ext/exit_test.h      |    2 +-
 tools/testing/selftests/sched_ext/maximal.bpf.c    |   17 +-
 tools/testing/selftests/sched_ext/maximal.c        |    3 +
 tools/testing/selftests/sched_ext/numa.bpf.c       |    2 +-
 tools/testing/selftests/sched_ext/peek_dsq.bpf.c   |   10 +-
 tools/testing/selftests/sched_ext/reload_loop.c    |    3 +
 tools/testing/selftests/sched_ext/rt_stall.c       |    5 +
 tools/testing/selftests/sched_ext/runner.c         |   40 +-
 .../selftests/sched_ext/select_cpu_vtime.bpf.c     |    8 +-
 tools/testing/selftests/sched_ext/util.h           |    2 +-
 47 files changed, 5356 insertions(+), 1365 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c

--
tejun
