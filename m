Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133096;
	b=a3JtmGNzEgd99HkWSGfPqqH7xP9XV8YL8FfVmOrF2tJqTzERqhc4ivVr5wGJI7IfrjFS
	 XzRz90OULNjI6VlWGMCCC+Duv2tQRKpq4gDsHm/xBaeA+A8tELqEx+6LjN95qa++U4OYE
	 EGJllHdgVpmzhN6t2XxYauQvjH1mez7lunAkHksm2ONB2LeFZnXEhBzeEOeA2txqg/pZF
	 2Mnldvkyroex+qPwAtlolOozXL7i0lvRSIhYioWG+YssV5rVf4Uvdq4+qBFnCUZmLcMMY
	 DYqI4aGirsWrOedkUQZtjexPBNbrzjp4hAKU0/15ORBg4O5E7Weli/3F605aRuaCU3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133096;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject;
	bh=b1DgRMR2Lcvcbb0t0PG6s8BYK3wrPTFv/pnY6rN0LvY=;
	b=16jv2v+I2D4fCHf/J/7yiyo7yfqbBQ0WKIgRkMJ7e0wwXMm78Jv7WkX+sMz95OXPT1Om
	 M69ExoQOl3xVyHmA1b2+PSN7kn+EnFYQdzZsRCVQT4ve7tId6KqpJ/6M5Eyq9d2XiJCZI
	 hN6c3ccYq9O90Sv0hHCBUyhfVz6dVamZbrf6jWM3MfDhtxMxN4T3jLt+wP5TbpmTGr/ys
	 h12vuGmmluoATYWKZ3JeTQsMiREHpHk+It+xHaTyqvrYgF1u26ugQuqMXOGj8dXVD8L3I
	 ixVYwT4E0rtNQsq2jq3I4uas4Sz1axO58FVubTICobaxNSgBn4Jtu6yBkzEvMw5/h2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1e2Elgk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B8606A327;
	Tue, 27 Oct 2026 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1e2Elgk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD84E1F01829;
	Tue, 27 Oct 2026 20:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133096;
	bh=b1DgRMR2Lcvcbb0t0PG6s8BYK3wrPTFv/pnY6rN0LvY=;
	h=Date:From:To:Cc:Subject;
	b=o1e2Elgky2LJqUT6D3VY+flBLSver3/z9spmItLsGhiP/JgwbqpFs0zQTzeEjY3d7
	 1XVQgnn3OdkjjVQh2n1RbQZVsOjOg47soN0g49ma93Xp6yXkPMCeusiA55gA7RMHwW
	 nkXa7CYydiLlbizp4Nl/5zhZAhGcTVZMCFzYVKJ3H5BCiDqFyOE5MwBvUNRz9W/gEC
	 vzrBFH0nSVetzysPUDPe0tlA4DG4KIJn5nEZmValNjMRBJsqPU+eKuwGfMU94YZ+qt
	 96As+LZt4e3MJKVZ4y1LC6VsdnAKivcmbPuWK6eJmrfSWrB48eZOAReQkwrri3kMY5
	 FFq+5k8PsI1PQ==
Date: Tue, 27 Oct 2026 10:31:34 -1000
Message-ID: <e5758e0a056fcef3e669b4d1f285a787@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.4
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

The following changes since commit 1f5dde349ac2fca1f119ae8de3f0d2f1c2a8d338:

  sched_ext: Drop the locks periodically while walking a user DSQ for re-enqueue (2026-10-17 20:18:02 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4-fixes

for you to fetch changes up to af4ed5682e62556beb399b76f2f1274ae1aad9e2:

  sched_ext: Reject scx_bpf_sub_grant/revoke() in tracing programs (2026-10-27 09:40:56 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.4

This is a big pull for fixes, but much of it was in the works before the
merge window. Most of these fixes are in sub-scheduler support, which nests
BPF schedulers under a parent that hands them CPUs. It was heavily reworked
over recent cycles and is now functionally complete. Porting real schedulers
on it drove the latest additions and keeps finding corner cases. For
example, once CPUs are shared and can be taken back, the kernel must keep
every task moving when its scheduler can't run it or is failing, and those
fallbacks interact subtly with each other and with other new core features.

- The fallback paths meant to keep a task moving when its scheduler can't
  run it or is failing could themselves leave it stuck.

- The stall watchdog could blame a scheduler for time it wasn't responsible
  for, even taking down all of sched_ext.

- Sub-schedulers were told late, or not at all, which CPUs they could use.

- Deferred callbacks could stay queued or be dropped under core scheduling
  and proxy execution, with a sched/core fix to the duplicate check.

- Hardening: tracing programs can no longer call kfuncs that could deadlock
  the CPU.

----------------------------------------------------------------
Andrea Righi (3):
      sched_ext: Queue the kick_sync wait from set_next_task_scx()
      sched_ext: Use irq_work for deferred actions with proxy execution
      sched/core: Avoid requeueing a singleton balance callback

Hui Su (1):
      sched_ext: Reject oversized automatic CID shards

Junbin Zhang (1):
      sched_ext: Reject rq-lock-taking kfuncs in tracing programs

Michal Blaszczyk (1):
      sched_ext: Reset runnable_at when a task leaves its scheduler

Tejun Heo (28):
      sched_ext: Factor out cid_pshard()
      sched_ext: Free a sub-scheduler a grace period after discarding its ecaps syncs
      sched_ext: Report a sub-scheduler's ecaps on attach and detach
      sched_ext: Deliver ecaps only while the root has the cpu online
      sched_ext: Report the ecaps loss when a cpu goes offline
      sched_ext: Leave suspend and hibernation out of the ecaps reports
      sched_ext: Fix the stall watchdog testing and blaming the wrong sched under bypass
      sched_ext: Pack scx_ent_flags' multi-bit fields at the top
      sched_ext: Clear holding_cpu where the claim is confirmed
      sched_ext: Fix bypassed tasks stranded by the reenqueue limit
      sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
      sched_ext: Move refill_task_slice_dfl() below apply_slice_vtime()
      sched_ext: Fix rescue served time disagreeing with the slice under proxy execution
      sched_ext: Restore a rescuee's slice after ops.stopping()
      sched_ext: Fix a cpu idling with a runnable rescuee
      sched_ext: Mark the rescue grant as a kernel slice with SCX_TASK_KERNEL_SLICE
      sched_ext: Refuse extending a kernel slice
      sched_ext: Fix a cpu idling after put_prev_task_scx() queues its task on the local DSQ
      sched_ext: Expire prev's slice in dispatch_one() under bypass
      sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE
      sched_ext: Fix the bypass load balancer stranding tasks on cpus where the host lacks SCX_CAP_BASE
      sched_ext: Factor out bypass_lb_move() and insert with the donor DSQ unlocked
      sched_ext: Let the bypass load balancer move tasks homed on other cpus
      sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_BASE
      sched_ext: Fix a lone IMMED task waiting behind a kept prev
      sched_ext: Fix use-after-free of a NONE rescuee leaving its sched while running
      sched_ext: Fix the rescue overload pick ejecting the wrong sub under bypass
      sched_ext: Reject scx_bpf_sub_grant/revoke() in tracing programs

 include/linux/sched/ext.h                       |  22 +-
 kernel/sched/ext/cid.c                          |   6 +
 kernel/sched/ext/ext.c                          | 933 +++++++++++++++++-------
 kernel/sched/ext/inlines.h                      |  15 +-
 kernel/sched/ext/internal.h                     |  90 ++-
 kernel/sched/ext/sub.c                          | 718 +++++++++++++-----
 kernel/sched/ext/sub.h                          |  26 +-
 kernel/sched/sched.h                            |  24 +-
 tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
 tools/sched_ext/include/scx/enums_abi.autogen.h |  29 +-
 tools/sched_ext/scx_qmap.bpf.c                  |  25 +-
 11 files changed, 1392 insertions(+), 497 deletions(-)

-- 
tejun
