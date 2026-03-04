Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF519ADB0;
	Wed,  4 Mar 2026 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661680; cv=none; b=J7gMHSiRdWM2CaLvQ2lyy8yZA8se7kS9y/wfqHjK+FkhaVCLMTsvCDJHFkLJgbOd2rFOf2D1+f1Lv3uvWO0EPeG2srvqTxa4xuGIiiFu7czKxvhGrsfoyywjOCftB3woAr6RtXvtU270sIR2QvDwctjTcWPWZwnour5x/W4CAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661680; c=relaxed/simple;
	bh=jZ/lmYEiagGPdIyaiV5ieMPlQJlt7JAfLtAxofY9gAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipDaLL7wrNLwWtASvvFDlfrsUTLTTFaL5uWYjdqYvRez8Za4InGAwPQa9eGznD8RTs2fCOok4A4flIllKyjfWIFfP1XTK8D5oW/me/pCRD3kXRHsCme8ZL6D55Bf7TU07BN24WIwOif03GEE//oCV2nfH0OaoHsiZqZPdva4nb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTs6rIJy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTs6rIJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC73C4CEF7;
	Wed,  4 Mar 2026 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661680;
	bh=jZ/lmYEiagGPdIyaiV5ieMPlQJlt7JAfLtAxofY9gAw=;
	h=From:To:Cc:Subject:Date:From;
	b=MTs6rIJy7aaiIKcltYdSDBnQflT6S1532c0rHqx47sIvMnaBqBjUYt2yrKobnGZI9
	 YMlUbgLkRsAmKcVkOc73jwEtfwcauWX8lj/BUe3nYXbJWbs2MEc6vNplBhTQLn2Dw0
	 FqJ/kn3ldtSGLbjwCjHWO4RJjG+0C4dHI7HNzai5ixESLDtJppHs2S+5cF2SNzO1wa
	 vx4u4/v3XPGjDAn3j71yHeZQE4+6/P1QEp1wysZf8hUQntYJW70PlxMn6zVXlixU/a
	 9G0utE6GzByGEsMGYlbXttSJ52bNI0sM701u+GulNfC/thh4cnwjnZs3CxaJ1BvpSP
	 fV0xyF2C0MxJA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v3 sched_ext/for-7.1] sched_ext: Implement cgroup sub-scheduler support
Date: Wed,  4 Mar 2026 12:00:45 -1000
Message-ID: <20260304220119.4095551-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset has been around for a while. I'm planning to apply this soon
and resolve remaining issues incrementally.

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

v3:
- Adapt to for-7.0-fixes change that punts enable path to kthread to avoid
  starvation. Keep scx_enable() as unified entry dispatching to
  scx_root_enable_workfn() or scx_sub_enable_workfn() (#6, #7, #29).

- Fix build with various config combinations (Andrea):
  - !CONFIG_CGROUP: add root_cgroup()/sch_cgroup() accessors with stubs
    (#7, #29, #31).
  - !CONFIG_EXT_SUB_SCHED: add null define for scx_enabling_sub_sched,
    guard unguarded references, use scx_task_on_sched() helper (#21, #23,
    #29).
  - !CONFIG_EXT_GROUP_SCHED: remove unused tg variable (#13).

- Note scx_is_descendant() usage by later patch to address bisect concern
  (#7) (Andrea).

v2: http://lkml.kernel.org/r/20260225050109.1070059-1-tj@kernel.org
v1: http://lkml.kernel.org/r/20260121231140.832332-1-tj@kernel.org

Based on sched_ext/for-7.1 (0e953de88b92). The scx_claim_exit() preempt
fix which was a separate prerequisite for v2 has been merged into for-7.1.

Git tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-sched-v3

 include/linux/cgroup-defs.h              |    4 +
 include/linux/cgroup.h                   |   65 +-
 include/linux/sched/ext.h                |   11 +
 init/Kconfig                             |    4 +
 kernel/cgroup/cgroup-internal.h          |    6 -
 kernel/cgroup/cgroup.c                   |   55 -
 kernel/fork.c                            |    6 +-
 kernel/sched/core.c                      |    2 +-
 kernel/sched/ext.c                       | 2388 +++++++++++++++++++++++-------
 kernel/sched/ext.h                       |    4 +-
 kernel/sched/ext_idle.c                  |  104 +-
 kernel/sched/ext_internal.h              |  248 +++-
 kernel/sched/sched.h                     |    7 +-
 tools/sched_ext/include/scx/common.bpf.h |    1 +
 tools/sched_ext/include/scx/compat.h     |   10 +
 tools/sched_ext/scx_qmap.bpf.c           |   44 +-
 tools/sched_ext/scx_qmap.c               |   13 +-
 17 files changed, 2321 insertions(+), 651 deletions(-)

--
tejun
