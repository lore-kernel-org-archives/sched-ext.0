Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF83148B4;
	Wed, 21 Jan 2026 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037103; cv=none; b=bFkiXXysltDisOlZon1m2USofoZnMCwNdOEabskX5BjQ/cjGzBs+tZcLm6VMJg7mRNP3NjG/V3rHNDmX3pgh8Mpwct/s0CHO8lg3DrQheJbDbiqR5Uxu3QIZNOJpcrccbkIAonSLAjYJ06oP4lVNlqs8vfcBasa7D2XKG4F5tZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037103; c=relaxed/simple;
	bh=3FO73mI+QUlQfuCkkBmtOzsoQDO2UzbticMjosw5/gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmFVUvsxWd/fxK8vWfBAEToaRVMAnRXqnzzibd3Y1S5AcI+Izk1ldnZ/zwjYUk4HjpcKlkua9I2T7ijrYGa5A62KnffGKyxNQZLQ1Cqig71hEp7z6O4B0mSgS00cR9I8H9fd4rywcZQvAbAVIv7f5D8mMlbANtY6PCwoCzcV2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5ru0Ujq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5ru0Ujq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15101C4CEF1;
	Wed, 21 Jan 2026 23:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037101;
	bh=3FO73mI+QUlQfuCkkBmtOzsoQDO2UzbticMjosw5/gQ=;
	h=From:To:Cc:Subject:Date:From;
	b=K5ru0Ujqv/5K/dH0Xyg4RGgtmxiG5v0UtItwEHa718yDid++ywy2Wz7vOGf4h9aJF
	 OYHflPesXGT35fyWGpfXl0B3BteTgtuAug4PLGF0gkXFBe0SrlKXgP+0v2qIXiCDpK
	 +dfWDofMbZ8XIHrWtj8UZw9dBb8YuZivAMCEaLLQdMBFX+EpqLHqHUjQojd7jsuaSd
	 6wrbyMWA5eOnx7DsKvgc4LUCsM3KsQKEJtLiP6aOIFCEBkgaMCMbzDLBGV9655xiKQ
	 tLiXWXuWZ3P0UOiV9kNrUUsNb49XxYiJhm79BpUtUy+ACu+3pziU9Q6kic22xlf9uC
	 f/Bmf0pH4LuYw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v1 sched_ext/for-6.20] sched_ext: Implement cgroup sub-scheduler support
Date: Wed, 21 Jan 2026 13:11:06 -1000
Message-ID: <20260121231140.832332-1-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset implements cgroup sub-scheduler support for sched_ext, enabling
multiple scheduler instances to be attached to the cgroup hierarchy. This is a
partial implementation focusing on the dispatch path - select_cpu and enqueue
paths will be updated in subsequent patchsets. While incomplete, the dispatch
path changes are sufficient to demonstrate and exercise the core sub-scheduler
structures.

Motivation
==========

Applications often have domain-specific knowledge that generic schedulers cannot
possess. Database systems understand query priorities and lock holder
criticality. Virtual machine monitors can coordinate with guest schedulers and
handle vCPU placement intelligently. Game engines know rendering deadlines and
which threads are latency-critical.

On multi-tenant systems where multiple such workloads coexist, implementing
application-customized scheduling is difficult. Hard partitioning with cpuset
lacks the dynamism needed - users often don't care about specific CPU
assignments and want optimizations enabled by sharing a larger machine:
opportunistic over-commit, improving latency-critical workload characteristics
while maintaining bandwidth fairness, and packing similar workloads on the same
L3 caches for efficiency.

Sub-scheduler support addresses this by allowing schedulers to be attached to
the cgroup hierarchy. Each application domain runs its own BPF scheduler
tailored to its needs, while a parent scheduler dynamically controls CPU
allocation to children without static partitioning.

Structure
=========

Schedulers attach to cgroup nodes forming a hierarchy up to SCX_SUB_MAX_DEPTH
(4) levels deep. Each scheduler instance maintains its own state including
default time slice, watchdog, and bypass mode. Tasks belong to exactly one
scheduler - the one attached to their cgroup or the nearest ancestor with a
scheduler attached.

A parent scheduler is responsible for allocating CPU time to its children. When
a parent's ops.dispatch() is invoked, it can call scx_bpf_sub_dispatch() to
trigger dispatch on a child scheduler, allowing the parent to control when and
how much CPU time each child receives. Currently only the dispatch path supports
this - ops.select_cpu() and ops.enqueue() always operate on the task's own
scheduler. Full support for these paths will follow in subsequent patchsets.

Kfuncs use the new KF_IMPLICIT_ARGS BPF feature to identify their calling
scheduler - the kernel passes bpf_prog_aux implicitly, from which scx_prog_sched()
finds the associated scx_sched. This enables authority enforcement ensuring
schedulers can only manipulate their own tasks, preventing cross-scheduler
interference.

Bypass mode, used for error recovery and orderly shutdown, propagates
hierarchically - when a scheduler enters bypass, its descendants follow. This
ensures forward progress even when nested schedulers malfunction. The dump
infrastructure supports multiple schedulers, identifying which scheduler each
task and DSQ belongs to for debugging.

Patches
=======

0001-0004: Preparatory changes exposing cgroup helpers, adding cgroup subtree
iteration for sched_ext, passing kernel_clone_args to scx_fork(), and reordering
sched_post_fork() after cgroup_post_fork().

0005-0006: Reorganize enable/disable paths in preparation for multiple scheduler
instances.

0007-0009: Core sub-scheduler infrastructure introducing scx_sched structure,
cgroup attachment, scx_task_sched() for task-to-scheduler mapping, and
scx_prog_sched() for BPF program-to-scheduler association.

0010-0012: Authority enforcement ensuring schedulers can only manipulate their
own tasks in dispatch, DSQ operations, and task state updates.

0013-0014: Refactor task init/exit helpers and update scx_prio_less() to handle
tasks from different schedulers.

0015-0018: Migrate global state to per-scheduler fields: default slice, aborting
flag, bypass DSQ, and bypass state.

0019-0023: Implement hierarchical bypass mode where bypass state propagates from
parent to descendants, with proper separation of bypass dispatch enabling.

0024-0028: Multi-scheduler dispatch and diagnostics - dispatching from all
scheduler instances, per-scheduler dispatch context, watchdog awareness, and
multi-scheduler dump support.

0029: Implement sub-scheduler enabling and disabling with proper task migration
between parent and child schedulers.

0030-0034: Building blocks for nested dispatching including scx_sched back
pointers, reenqueue awareness, scheduler linking helpers, rhashtable lookup, and
scx_bpf_sub_dispatch() kfunc.

scx_qmap Demonstration
======================

scx_qmap is updated to demonstrate sub-scheduler functionality. As a parent
scheduler, it implements ops.sub_attach() and ops.sub_detach() callbacks to
track child schedulers by their cgroup IDs. In qmap_dispatch(), after exhausting
its own queues, it iterates through registered children calling
scx_bpf_sub_dispatch() on each, demonstrating how a parent controls CPU time
allocation to children.

scx_qmap can also run as a sub-scheduler itself using the new -c option which
specifies a cgroup path to attach to. This allows testing nested configurations
where one qmap instance serves as the root scheduler and another as a
sub-scheduler under a specific cgroup.

This is a refined implementation based on the RFC posted earlier:

  http://lkml.kernel.org/r/20250919194519.1503124-1-tj@kernel.org

This version completes the implementation for basic nested sub-scheduler
dispatching.

Based on sched_ext/for-6.20 + bpf-next/master (2481e7ab46c9).

Git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-sched-v1

 include/linux/cgroup-defs.h              |    4 +
 include/linux/cgroup.h                   |   65 +-
 include/linux/sched/ext.h                |   11 +
 init/Kconfig                             |    4 +
 kernel/cgroup/cgroup-internal.h          |    6 -
 kernel/cgroup/cgroup.c                   |   55 -
 kernel/fork.c                            |    6 +-
 kernel/sched/core.c                      |    2 +-
 kernel/sched/ext.c                       | 2349 +++++++++++++++++++++++-------
 kernel/sched/ext.h                       |    4 +-
 kernel/sched/ext_idle.c                  |  104 +-
 kernel/sched/ext_internal.h              |  248 +++-
 kernel/sched/sched.h                     |    7 +-
 tools/sched_ext/include/scx/common.bpf.h |    1 +
 tools/sched_ext/include/scx/compat.h     |   10 +
 tools/sched_ext/scx_qmap.bpf.c           |   44 +-
 tools/sched_ext/scx_qmap.c               |   13 +-
 17 files changed, 2292 insertions(+), 641 deletions(-)

--
tejun
