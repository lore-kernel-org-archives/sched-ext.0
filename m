Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3C3C4176;
	Wed,  8 Jul 2026 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545872; cv=none; b=JLdhnEWOR37aYuLvanoGv+abiNybQ9GTQq5R6gyiSZbv1/trkum83uqI+dFBBpMUZowVueWPNRUwYliUHUhuAqOECmmeQCLBs2ijptM5g/26HefyDts12B2opS4Sb33KLfFGcP6anjw2J0gigFIGbeHhWSychqwAIH/1s2nwcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545872; c=relaxed/simple;
	bh=/wqdCzP46XlW3A1K+DCV6HxRfh/V12OC6PPjdSSBRd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhJenJNn3aEJ2BBs4CFyt/X/XnBdh1AYt9rjjIScV703OWIwGLjhb/G9Q/LU3pMV57YtBZfBCJjyS7AcjaD/lLD5n8oTNp+cOInn1MS/zg3bh22SBQcogjIf1+HtC7bypkDK1ntZftuhFkLzkUJKAcF2Cbi32soniAOa9WHBeo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ednJ7v8t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ednJ7v8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330701F000E9;
	Wed,  8 Jul 2026 21:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545870;
	bh=3MLVzINjpq4wNspwJNUhQfMjfaD5xCxDZev3unxPYw8=;
	h=From:To:Cc:Subject:Date;
	b=ednJ7v8tR6ubTKv110+94JLLdKfooHJPRLYvX699I518GOX+wwKqxed+KbglcxzQ0
	 xN13RWzDoCm7+9JJpi3CZXe8R7LnGYN8pJSJE8vT+OHjIhklu/i5d7yH9PkYO5XWrY
	 /KEQ49P0gfgJAIxXDGZy2qJ7qBjYdcmF7C5uPEcF7Sea0Ajf2xFhLOfkczjSUhVlZq
	 EFxmIks1y7ajYRlJjCi/vnY+rKEwJjRDTmnhKPwaiIete/VqQ4MV0FWMAcRnuc5i5n
	 S9J739RLB3yV1jQW3G6xfwmYaW6/Sg/cc5u9n+mpAaSd4Hu3wVe/zhg312NF6oYtDT
	 DYIf3C2kQkVow==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v4 sched_ext/for-7.3] sched_ext: Capability-based CPU delegation for sub-schedulers
Date: Wed,  8 Jul 2026 11:23:49 -1000
Message-ID: <20260708212429.3405787-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes in v4:

- New patch (01): record an error on errno-only sub-enable failures, so
  the disable path runs and a half-initialized sub-scheduler is torn down
  instead of left linked. Pre-existing bug, split out early with a Fixes:
  tag. (sashiko AI)

- New patch (20): stop scx_prog_sched() from resolving a disabled
  scheduler. A program that outlives disable (a timer it armed, a tracing
  program it loaded) could still operate on a torn-down generation; gating
  one choke point closes a cross-generation pshard[] out-of-bounds.
  (sashiko AI)

- Flush the pending kick irq_work in free_kick_syncs() before clearing the
  per-cpu kick state, so a late kick unlinks cleanly at teardown (10).
  (sashiko AI)

- New prep patch (30): track the cpu a task is runnable on
  (p->scx.runnable_cpu), stamped under the rq lock. The slice write path
  uses it to test rq ownership (31), closing a remote-wakeup TOCTOU where a
  cached task_rq() could stale-match a migrated sleeping task. (sashiko AI)

- scx_qmap demo (39): track every cid's idle state regardless of
  delegation and mask it with the node's own cids at the dispatch pick,
  instead of reseeding from a separate idle set. Fixes an already-idle
  reclaimed cid being missed and drops a reseed race. The three-mask cmask
  iterator it uses is split into its own patch (38). (sashiko AI)

- Introduce pshard[] in its final build-then-publish form in the patch
  that adds it rather than rewriting it a few patches later (15, 21).

- Document the remaining limitations for full sub-scheduling support below.
  (Andrea)

v3: https://lore.kernel.org/r/20260707001229.1410929-1-tj@kernel.org
v2: https://lore.kernel.org/r/20260706014058.439853-1-tj@kernel.org
v1: https://lore.kernel.org/r/20260703080159.2314350-1-tj@kernel.org

The existing sub-scheduler support only covers a part of scheduling. An
scx_sched can attach to a cgroup subtree under another scx_sched and detach,
and the dispatch path has programmatic delegation: dispatch runs as top-down
recursion via scx_bpf_sub_dispatch(), so a parent decides when a child gets
to pick tasks for the local cpu by calling into it.

The enqueue path is not implemented yet. Every scheduler in the hierarchy
can insert into every local DSQ, so a parent has no way to partition CPUs
among its children or protect its own share from them.

This patchset adds that control. Most importantly it enables sub-sched
support on the enqueue path, and it extends the same control to the other
paths that touch cpu access: occupancy, kicks and preemption, and idle
reporting.

The enqueue path cannot use the dispatch path's programmatic model.
Dispatch is top-down and the delegation is implicit in the call chain.
Enqueue starts at the other end: a leaf picks a cid for a task, and which
cids it may use is the cumulative result of its ancestors' delegation
decisions. Resolving that programmatically on every enqueue would mean a
cross-sched round-trip call chain, possibly retrying when a request
cannot be granted as-is. Delegation is therefore state, not calls:

- Ownership is tracked per (scheduler, cid) as a set of capabilities:

  - SCX_CAP_ENQ_IMMED: insert an IMMED task onto the cid's local DSQ.
    This is the baseline cap (SCX_CAP_BASE) required to make any use of
    a cpu.

  - SCX_CAP_ENQ: insert any task onto the cid's local DSQ.

  - SCX_CAP_PREEMPT: preempt a task outside the scheduler's own subtree.

  Higher caps imply the lower ones for the holder's own use.

- The root owns every cap on every cid. A parent delegates caps to a
  child with scx_bpf_sub_grant() and takes them back with
  scx_bpf_sub_revoke(). A child's cap set is always a subset of its
  parent's.

- The cap state is sharded. The cid space is split into topology-aligned
  shards, and each scheduler tracks its caps in per-shard cmasks with a
  per-shard lock. Operations are broken up on shard boundaries and different
  shards never contend. Shards are expected to serve as the locality unit
  when cids are handed out to schedulers, so lock granularity scales
  naturally with the allocation pattern.

- Hot paths check a per-cpu effective-caps copy with a single read.
  Grant/revoke rings a per-cpu doorbell and the owning cpu folds the new
  config in at the top of balance(). Cross-sched communication happens only
  when the delegation set changes.

Enforcement:

- An insert that lacks the required cap is diverted to a kernel-internal
  per-rq reject DSQ and handed back to the BPF scheduler to re-decide,
  tagged with SCX_TASK_REENQ_CAP and the missing caps.

- A revoke evicts already-queued and running tasks through the same
  reenqueue path.

- CPU occupancy is tied to the task slice. Extending a slice requires
  baseline access on the cpu.

- Kicks are enforced at delivery. Any kick needs baseline access on the
  target cid, and SCX_KICK_PREEMPT degrades to a plain reschedule if the
  victim is outside the kicker's subtree and the kicker lacks
  SCX_CAP_PREEMPT.

Notifications:

- ops.sub_caps_updated() reports config-level changes per shard with
  coalescing.

- ops.sub_ecaps_updated() reports per-cpu effective changes when they
  take effect.

- ops.update_idle() is routed to the cid's owner, with a re-notification
  when ownership changes while the cpu sits idle.

A parent can evict a misbehaving child with scx_bpf_sub_kill().

To make it concrete, consider a root scheduler R with a child A, which
in turn has a child A1:

- On enable, R owns every cap on every cid. A child starts with no caps
  and cannot use any cpu on its own, so a parent normally makes an
  initial grant when a child attaches.

- R grants cids 8-15 to A by calling scx_bpf_sub_grant() with A's cgroup
  id and a cmask. A grant is all-or-nothing per cid and can only hand
  down caps R holds literally.

- A learns of the grant through ops.sub_caps_updated(). As each cpu
  folds the change into its effective caps, A gets
  ops.sub_ecaps_updated() for that cid, and if the cpu is sitting idle,
  an ops.update_idle() re-notification so A can use it right away.

- Nesting chains through the same notifier: from its
  ops.sub_caps_updated(), A calls scx_bpf_sub_grant() to pass a subset, say
  cids 12-15, down to A1, whose own ops.sub_caps_updated() then fires. A1's
  cap set is a subset of A's, which is a subset of R's. Caps A holds only
  through implication cannot be re-delegated.

Using and then losing a cpu, from A's point of view, looks like this:

- Holding SCX_CAP_ENQ on cid 8, A inserts its tasks into cid 8's local
  DSQ from its enqueue and dispatch paths, extends their slices, and
  kicks the cpu as usual.

- R revokes cid 8. The revoke clears it across A's whole subtree, so A1
  loses whatever it held on the cid too.

- Once the revoke reaches the cpu's effective caps, A's tasks queued on
  cid 8 are handed back to A's ops.enqueue() tagged with
  SCX_TASK_REENQ_CAP and the missing caps, a running task is evicted by
  zeroing its slice, and new inserts are rejected and handed back the
  same way.

- A places the bounced tasks somewhere it still holds, and the notifiers
  tell it that its holdings shrank.

The final three patches expand the scx_qmap hierarchical demo: a qmap
instance splits the cpus it fully owns among itself and child qmaps in
proportion to cpu.weight, time-shares the rounding leftovers through a
round-robin pool, and can fault-inject dispatches to unheld cids to
demonstrate the kernel-side enforcement.

Known limitations:

After this series, sub-scheduling works as long as tasks stay within their
cgroup boundary and aren't affined away from the cpus their scheduler can
use. Two pieces are still missing for full support:

- cgroup migration doesn't move a task across sub-schedulers. A task moved
  between cgroups served by different sub-scheds keeps its original
  scheduler.

- there is no fallback when a sub-scheduler holds no cpu a task is allowed
  to run on. Such a task, e.g. one affined only to cids its scheduler was
  never granted or has had revoked, has nowhere to go. The likely
  direction is reserving a slice off the root scheduler to run tasks
  without cpu access.

Based on sched_ext/for-7.3 (daf8e166ba59).

This patchset contains the following 40 patches.

 0001 sched_ext: Record an error on errno-only sub-enable failure
 0002 sched_ext: Fix premature ops->priv publication in scx_alloc_and_add_sched()
 0003 tools/sched_ext: scx - Fix cmask_subset(), cmask_equal() and cmask_weight()
 0004 sched_ext: Use READ_ONCE/WRITE_ONCE in cmask word ops and drop _RACY variants
 0005 sched_ext: Add SCX_CALL_CID_OP_TASK() for cid-form op dispatch
 0006 sched_ext: Rename extra_enq_flags to remote_activate_enq_flags
 0007 tools/sched_ext: scx_qmap - Use bare u64/u32/s32 integer types
 0008 sched_ext: Reject direct slice and dsq_vtime writes for cid-form schedulers
 0009 sched_ext: Make scx_bpf_kick_cid() return void
 0010 sched_ext: Make the kick machinery per-sched
 0011 sched_ext: Add ops.init_cids() to finalize the cid layout before init
 0012 sched_ext: Add CID sharding
 0013 sched_ext: Add shard boundaries to scx_bpf_cid_override()
 0014 sched_ext: Defer scx_sched kobj sysfs add into the enable workfns
 0015 sched_ext: Add per-shard scx_sched storage scaffolding
 0016 sched_ext: Add scx_cmask_ref for validated arena cmask access
 0017 sched_ext: Build the set_cmask scratch from trusted geometry
 0018 sched_ext: RCU-protect the sub-sched tree's children/sibling lists
 0019 sched_ext: Add scx_skip_subtree_pre()
 0020 sched_ext: Stop resolving a disabled scheduler's programs
 0021 sched_ext: Add per-shard cap delegation for sub-schedulers
 0022 sched_ext: Add coalescing sub_caps_updated() notifier for sub-schedulers
 0023 sched_ext: Maintain per-cpu effective cap copies for single-read checks
 0024 sched_ext: Add sub_ecaps_updated() effective-cap change notifier
 0025 sched_ext: Generalize local-DSQ handling to rq-owned DSQs
 0026 sched_ext: Add reject DSQ for cap-rejected dispatches
 0027 sched_ext: Add the SCX_CAP_ENQ_IMMED cap
 0028 sched_ext: Assign a unique id to each scheduler instance
 0029 sched_ext: Route task slice writes through set_task_slice()
 0030 sched_ext: Track the cpu a task is runnable on
 0031 sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice
 0032 sched_ext: Add the SCX_CAP_ENQ cap
 0033 sched_ext: Gate kicks on SCX_CAP_BASE and preemption on SCX_CAP_PREEMPT
 0034 sched_ext: Authorize remote-move inserts against the placing scheduler
 0035 sched_ext: Route ops.update_idle() to sub-schedulers and re-notify owed scheds
 0036 sched_ext: Replay ecaps notifications suppressed by bypass
 0037 sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler
 0038 tools/sched_ext: Add three-mask cmask intersection iterator
 0039 tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling
 0040 tools/sched_ext: scx_qmap - Add sub-sched cap fault injection

The patches are organized as follows:

- 01-08: fixes and small prep.

- 09-20: plumbing. Per-sched kick machinery (09-10), ops.init_cids()
  (11), cid sharding (12-13), sysfs and per-shard storage prep (14-15),
  validated arena cmask access (16) and the trusted-geometry set_cmask
  build (17), RCU-safe tree walking (18-19), and gating a disabled
  scheduler's still-resolvable programs (20).

- 21-24: cap delegation. Per-shard caps with grant/revoke (21), the
  coalescing sub_caps_updated() notifier (22), per-cpu effective caps
  (23) and the sub_ecaps_updated() notifier (24).

- 25-34: enforcement. The reject DSQ (25-26), SCX_CAP_ENQ_IMMED (27),
  slice-based occupancy (28-31), SCX_CAP_ENQ (32), preemption and kick
  gating (33) and remote-move insert authorization (34).

- 35-37: idle routing and re-notification (35), bypass replay (36) and
  scx_bpf_sub_kill() (37).

- 38-40: scx_qmap hierarchical demo.

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-caps-v4

diffstat follows. Thanks.

 include/linux/sched/ext.h                |   33 +-
 init/init_task.c                         |    1 +
 kernel/sched/ext/cid.c                   |  563 ++++++++++++---
 kernel/sched/ext/cid.h                   |   19 +-
 kernel/sched/ext/ext.c                   |  915 +++++++++++++++++++-----
 kernel/sched/ext/idle.c                  |   86 ++-
 kernel/sched/ext/internal.h              |  340 ++++++++-
 kernel/sched/ext/sub.c                   | 1126 +++++++++++++++++++++++++++++-
 kernel/sched/ext/sub.h                   |  118 +++-
 kernel/sched/ext/types.h                 |   74 +-
 kernel/sched/idle.c                      |    8 +-
 kernel/sched/sched.h                     |   18 +-
 tools/sched_ext/include/scx/cid.bpf.h    |  165 ++++-
 tools/sched_ext/include/scx/common.bpf.h |   26 +-
 tools/sched_ext/include/scx/compat.bpf.h |   11 +-
 tools/sched_ext/scx_qmap.bpf.c           |  840 ++++++++++++++++++++--
 tools/sched_ext/scx_qmap.c               |  375 +++++++++-
 tools/sched_ext/scx_qmap.h               |  147 +++-
 18 files changed, 4365 insertions(+), 500 deletions(-)

--
tejun
