Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D53373C00;
	Mon,  6 Jul 2026 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302061; cv=none; b=KUleDtiO3pfD6d049u8oFU2xgiNVLPLhPuH4picFB9idCBi5GsExiZLK44shBoMHdmrT76lyp0LnpEUKt3bZsf1ZJX7KISxLsEbzc8ObpNLphvEz1IcJWZGOzh+mdthtW9qp5sO/LeswDooDOjYt3V3Wo16mLu8tigXXOsbrBsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302061; c=relaxed/simple;
	bh=P8jktxlnW6VNeXXfetmhiAc9UTl2GR4B/H7+PJarKok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzJMfF5I7XWF3U29vnRdNziG2v54MUDvliFN574ILiR/HCd3eshtGFpMH2XjaMXsojyr2qwpwC+kq+9aiPZrpapgNyTXYpQQq20b1kzAWshl6RSbtIEwP51zxTxk9LZ33oHhe7Iy2E/HBDFWuy5Y/K44rNkOS0oMPFQG0VZN4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2PQPkvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2PQPkvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421DB1F000E9;
	Mon,  6 Jul 2026 01:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302059;
	bh=Fvgp/gLa2OxtaXGvOFJk6Z34qy/pr40bxXKG3RoLkVY=;
	h=From:To:Cc:Subject:Date;
	b=m2PQPkvHVmQVaucCKhMRGBrnVtcjsxO8OWQBdfcJgA85tG0ScvVbJtw3sYVKxnvUd
	 NhKF4K69Z99rh5YIglxnKHeLIYrKTCNO1hZKfFNb/cZhVCe8PwBLGDq3olcKrMJTiB
	 DYlKU3Vhk1xwvwTdArAf9K1Bgrq/UER6w/Fk0LfahGQZJHbn8mzsrJcfcTOQcnb0mm
	 gtSTuQxTehAsU5tlS77ZdI01tokg6BqlY9v0WeVVTukJFE3gDUHY1W71Qo7sQ7WPqL
	 +31L/996uz3n9zodE2Zp19/5TtfgjdMmjctg3QFTI4/FicR0AtbHRFyBXF3HTQc/qH
	 tv1nSaUrVEwEQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Capability-based CPU delegation for sub-schedulers
Date: Sun,  5 Jul 2026 15:40:22 -1000
Message-ID: <20260706014058.439853-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes in v2:

- Four new patches: SCX_CALL_CID_OP_TASK() for cid-form op dispatch (01),
  rename extra_enq_flags to remote_activate_enq_flags (02), build the
  set_cmask scratch from trusted geometry rather than the BPF-writable
  arena header (16), and authorize remote-move inserts against the placing
  scheduler (31).

- Fixes from sashiko AI's review: READ_ONCE the cmask word read (05),
  snapshot the scx_bpf_cid_override() arrays before validating (12), free a
  partial pshard array on failure (14), validate ops before publishing the
  sub (19), move the cid computation below the active-cpu guard and discard
  syncs on !cpu_active() (22), restrict direct slice writes to queued tasks
  (28), gate the idle catch-up to avoid a double ops.update_idle() (32), and
  an atomic nr_dsps counter in the demo (36).

- Warn on scx_bpf_kick_cpu() from NMI (09); inherit bypass_depth before
  publishing the sub (17).

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

From A's point of view, using and then losing a cpu looks like this:

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

The final two patches expand the scx_qmap hierarchical demo: a qmap
instance splits the cpus it fully owns among itself and child qmaps in
proportion to cpu.weight, time-shares the rounding leftovers through a
round-robin pool, and can fault-inject dispatches to unheld cids to
demonstrate the kernel-side enforcement.

Based on sched_ext/for-7.3 (daf8e166ba59).

This patchset contains the following 36 patches.

 0001 sched_ext: Add SCX_CALL_CID_OP_TASK() for cid-form op dispatch
 0002 sched_ext: Rename extra_enq_flags to remote_activate_enq_flags
 0003 sched_ext: Fix premature ops->priv publication in scx_alloc_and_add_sched()
 0004 tools/sched_ext: scx - Fix cmask_subset(), cmask_equal() and cmask_weight()
 0005 sched_ext: Use READ_ONCE/WRITE_ONCE in cmask word ops and drop _RACY variants
 0006 tools/sched_ext: scx_qmap - Use bare u64/u32/s32 integer types
 0007 sched_ext: Reject direct slice and dsq_vtime writes for cid-form schedulers
 0008 sched_ext: Make scx_bpf_kick_cid() return void
 0009 sched_ext: Make the kick machinery per-sched
 0010 sched_ext: Add ops.init_cids() to finalize the cid layout before init
 0011 sched_ext: Add CID sharding
 0012 sched_ext: Add shard boundaries to scx_bpf_cid_override()
 0013 sched_ext: Defer scx_sched kobj sysfs add into the enable workfns
 0014 sched_ext: Add per-shard scx_sched storage scaffolding
 0015 sched_ext: Add scx_cmask_ref for validated arena cmask access
 0016 sched_ext: Build the set_cmask scratch from trusted geometry
 0017 sched_ext: RCU-protect the sub-sched tree's children/sibling lists
 0018 sched_ext: Add scx_skip_subtree_pre()
 0019 sched_ext: Add per-shard cap delegation for sub-schedulers
 0020 sched_ext: Add coalescing sub_caps_updated() notifier for sub-schedulers
 0021 sched_ext: Maintain per-cpu effective cap copies for single-read checks
 0022 sched_ext: Add sub_ecaps_updated() effective-cap change notifier
 0023 sched_ext: Generalize local-DSQ handling to rq-owned DSQs
 0024 sched_ext: Add reject DSQ for cap-rejected dispatches
 0025 sched_ext: Add the SCX_CAP_ENQ_IMMED cap
 0026 sched_ext: Assign a unique id to each scheduler instance
 0027 sched_ext: Route task slice writes through set_task_slice()
 0028 sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice
 0029 sched_ext: Add the SCX_CAP_ENQ cap
 0030 sched_ext: Gate kicks on SCX_CAP_BASE and preemption on SCX_CAP_PREEMPT
 0031 sched_ext: Authorize remote-move inserts against the placing scheduler
 0032 sched_ext: Route ops.update_idle() to sub-schedulers and re-notify owed scheds
 0033 sched_ext: Replay ecaps notifications suppressed by bypass
 0034 sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler
 0035 tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling
 0036 tools/sched_ext: scx_qmap - Add sub-sched cap fault injection

The patches are organized as follows:

- 01-07: fixes and small prep.

- 08-18: plumbing. Per-sched kick machinery (08-09), ops.init_cids()
  (10), cid sharding (11-12), sysfs and per-shard storage prep (13-14),
  validated arena cmask access (15) and the trusted-geometry set_cmask
  build (16), RCU-safe tree walking (17-18).

- 19-22: cap delegation. Per-shard caps with grant/revoke (19), the
  coalescing sub_caps_updated() notifier (20), per-cpu effective caps
  (21) and the sub_ecaps_updated() notifier (22).

- 23-31: enforcement. The reject DSQ (23-24), SCX_CAP_ENQ_IMMED (25),
  slice-based occupancy (26-28), SCX_CAP_ENQ (29), preemption and kick
  gating (30) and remote-move insert authorization (31).

- 32-34: idle routing and re-notification (32), bypass replay (33) and
  scx_bpf_sub_kill() (34).

- 35-36: scx_qmap hierarchical demo.

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-caps-v2

diffstat follows. Thanks.

 include/linux/sched/ext.h                |   32 +-
 kernel/sched/ext/cid.c                   |  560 +++++++++++++---
 kernel/sched/ext/cid.h                   |   19 +-
 kernel/sched/ext/ext.c                   |  867 +++++++++++++++++++-----
 kernel/sched/ext/idle.c                  |   86 ++-
 kernel/sched/ext/internal.h              |  327 ++++++++-
 kernel/sched/ext/sub.c                   | 1087 +++++++++++++++++++++++++++++-
 kernel/sched/ext/sub.h                   |  117 +++-
 kernel/sched/ext/types.h                 |   72 +-
 kernel/sched/idle.c                      |    8 +-
 kernel/sched/sched.h                     |   18 +-
 tools/sched_ext/include/scx/cid.bpf.h    |   88 ++-
 tools/sched_ext/include/scx/common.bpf.h |   26 +-
 tools/sched_ext/include/scx/compat.bpf.h |   11 +-
 tools/sched_ext/scx_qmap.bpf.c           |  821 ++++++++++++++++++++--
 tools/sched_ext/scx_qmap.c               |  375 ++++++++++-
 tools/sched_ext/scx_qmap.h               |  147 +++-
 17 files changed, 4171 insertions(+), 490 deletions(-)

--
tejun
