Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136013AEB2C;
	Thu,  9 Jul 2026 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637444; cv=none; b=QKuSj4mObGH+j1aF+fdPzwDgb8Z1IMB8XiEOQEAAHrifW38eWkkPFGmNWToPD+xl5+ovy5o7FuIX8frCMFQ17jY+t5IxHbwgozK8X8E1FDUlpe75RjYy1KG14oLNdhDZP9UuO0NLRP9u8ZZxxOkwp8KPEGRDjJPxAUtTAsKxyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637444; c=relaxed/simple;
	bh=720yl9POlo4Wf/x4FegvBkU/aGGd+99FTb+Se6rv9LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkMFJ0Bvfj87j4pla3UHC0aLMiHY+iKjNVT1YYHhtq7iHD3nlLgFgOUMUzxWpkmxTJqQf0a+R9xbYfE5UV1pkAvYCsSTfUMYsEhrL7Orsvzf39PS8RgylmY9fwhDpcL6bp59gwPJ3+n64W/XSYh9uzrPhE++ZnrHxRq9tERG118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ne4e0Aje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ne4e0Aje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0B11F000E9;
	Thu,  9 Jul 2026 22:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637442;
	bh=hJyDgp0IjusH7i1yctU4Qs459DvmCfEnnQ15XX+J7S0=;
	h=From:To:Cc:Subject:Date;
	b=Ne4e0AjeaE3FVFIRFb8qIFps8Mv+Etdx+K5k7/+c0ka2tl7fZHyuo2/B+aXxJgDAi
	 ExEFmJKTCzn/i+s0W6ByPD/R8XAU1XRGh9SFylGY9nR+L2X3tTnEnvG9UssPldZQ1D
	 O3ddbT0/bpt/FRkCnIZRLv4Qc1w4jLdIDArxMbxifFgblHcYVZwjYj4KE3MQlVbv/e
	 mQ4OI6oyiDVWwNFy4+kXGoTm3G0DcpcdtcreTqvNn/DFa5PuSjXuaMrxqQCKn7U1Ex
	 ScgZscDh7DH58N1P1V1bw1h33CvAMWtfnPCnlG0yy7pGt11fPmYQAlKdqKip50XQXe
	 6jzUJZx5tcUrA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v5 sched_ext/for-7.3] sched_ext: Capability-based CPU delegation for sub-schedulers
Date: Thu,  9 Jul 2026 12:50:08 -1000
Message-ID: <20260709225041.1695495-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes in v5:

- Patches 1-9 of v4 were applied to sched_ext/for-7.2-fixes and
  sched_ext/for-7.3 and are dropped. The series is rebased onto the
  updated for-7.3.

- New patch (01): WARN when a per-task op is dispatched on a scheduler
  other than the task's owner, with the two intentional non-owner call
  sites dispatching explicitly. Hardening out of the v4 placer-vs-owner
  review discussion. (sashiko AI)

- New prep patch (19): an in-place SAVE/RESTORE requeue of a running task
  re-ran cid admission and could bounce a task to the reject DSQ under a
  scheduler holding only SCX_CAP_ENQ_IMMED. Mark such enqueues with an
  internal IGNORE_CAPS flag which requires no caps. (sashiko AI)

- The CONFIG_EXT_SUB_SCHED=n scx_prog_sched() stub now also refuses a
  dead root scheduler, matching the =y behavior (12). (sashiko AI)

- scx_qmap: mask the highpri dispatch pick with the node's own cids and
  read the sub cgroup_id once in the dispatch path (32). (sashiko AI)

v4: https://lore.kernel.org/r/20260708212429.3405787-1-tj@kernel.org
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

Based on sched_ext/for-7.3 (3d1519011e39).

This patchset contains the following 33 patches.

 0001 sched_ext: Assert per-task ops run on the task's owner
 0002 sched_ext: Make the kick machinery per-sched
 0003 sched_ext: Add ops.init_cids() to finalize the cid layout before init
 0004 sched_ext: Add CID sharding
 0005 sched_ext: Add shard boundaries to scx_bpf_cid_override()
 0006 sched_ext: Defer scx_sched kobj sysfs add into the enable workfns
 0007 sched_ext: Add per-shard scx_sched storage scaffolding
 0008 sched_ext: Add scx_cmask_ref for validated arena cmask access
 0009 sched_ext: Build the set_cmask scratch from trusted geometry
 0010 sched_ext: RCU-protect the sub-sched tree's children/sibling lists
 0011 sched_ext: Add scx_skip_subtree_pre()
 0012 sched_ext: Stop resolving a disabled scheduler's programs
 0013 sched_ext: Add per-shard cap delegation for sub-schedulers
 0014 sched_ext: Add coalescing sub_caps_updated() notifier for sub-schedulers
 0015 sched_ext: Maintain per-cpu effective cap copies for single-read checks
 0016 sched_ext: Add sub_ecaps_updated() effective-cap change notifier
 0017 sched_ext: Generalize local-DSQ handling to rq-owned DSQs
 0018 sched_ext: Add reject DSQ for cap-rejected dispatches
 0019 sched_ext: Add SCX_ENQ_IGNORE_CAPS for in-place restore
 0020 sched_ext: Add the SCX_CAP_ENQ_IMMED cap
 0021 sched_ext: Assign a unique id to each scheduler instance
 0022 sched_ext: Route task slice writes through set_task_slice()
 0023 sched_ext: Track the cpu a task is runnable on
 0024 sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice
 0025 sched_ext: Add the SCX_CAP_ENQ cap
 0026 sched_ext: Gate kicks on SCX_CAP_BASE and preemption on SCX_CAP_PREEMPT
 0027 sched_ext: Authorize remote-move inserts against the placing scheduler
 0028 sched_ext: Route ops.update_idle() to sub-schedulers and re-notify owed scheds
 0029 sched_ext: Replay ecaps notifications suppressed by bypass
 0030 sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler
 0031 tools/sched_ext: Add three-mask cmask intersection iterator
 0032 tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling
 0033 tools/sched_ext: scx_qmap - Add sub-sched cap fault injection

The patches are organized as follows:

- 01: prep. Assert per-task ops run on the task's owner.

- 02-12: plumbing. Per-sched kick machinery (02), ops.init_cids() (03),
  cid sharding (04-05), sysfs and per-shard storage prep (06-07),
  validated arena cmask access (08) and the trusted-geometry set_cmask
  build (09), RCU-safe tree walking (10-11), and gating a disabled
  scheduler's still-resolvable programs (12).

- 13-16: cap delegation. Per-shard caps with grant/revoke (13), the
  coalescing sub_caps_updated() notifier (14), per-cpu effective caps
  (15) and the sub_ecaps_updated() notifier (16).

- 17-27: enforcement. The reject DSQ (17-18), the restore cap bypass
  (19), SCX_CAP_ENQ_IMMED (20), slice-based occupancy (21-24),
  SCX_CAP_ENQ (25), preemption and kick gating (26) and remote-move
  insert authorization (27).

- 28-30: idle routing and re-notification (28), bypass replay (29) and
  scx_bpf_sub_kill() (30).

- 31-33: scx_qmap hierarchical demo.

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-caps-v5

diffstat follows. Thanks.

 include/linux/sched/ext.h                |   33 +-
 init/init_task.c                         |    1 +
 kernel/sched/ext/cid.c                   |  508 +++++++++++++-
 kernel/sched/ext/cid.h                   |   17 +-
 kernel/sched/ext/ext.c                   |  852 ++++++++++++++++++-----
 kernel/sched/ext/idle.c                  |   86 ++-
 kernel/sched/ext/internal.h              |  334 ++++++++-
 kernel/sched/ext/sub.c                   | 1120 +++++++++++++++++++++++++++++-
 kernel/sched/ext/sub.h                   |  121 +++-
 kernel/sched/ext/types.h                 |   74 +-
 kernel/sched/idle.c                      |    8 +-
 kernel/sched/sched.h                     |   17 +-
 tools/sched_ext/include/scx/cid.bpf.h    |   77 ++
 tools/sched_ext/include/scx/common.bpf.h |   24 +
 tools/sched_ext/include/scx/compat.bpf.h |   11 +-
 tools/sched_ext/scx_qmap.bpf.c           |  852 ++++++++++++++++++++---
 tools/sched_ext/scx_qmap.c               |  355 +++++++++-
 tools/sched_ext/scx_qmap.h               |  115 ++-
 18 files changed, 4238 insertions(+), 367 deletions(-)

--
tejun
