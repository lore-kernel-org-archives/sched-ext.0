Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CBD36D4EA;
	Mon,  1 Dec 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764632929; cv=none; b=iBGUG8sIcLs5yuRBjA9l4exQk9g/ItxXK2YqHPKel14i2QxPVaRKoj77nya4Ot5Sf0GJuDifjPRl5ICnCnsMe0B4J3Ms8GIOwi2Inr3u0VcpxzVnwiMWoGWg6ffm5+i2tB9OYjLHb1bi0gdaWPZPSjapWU0kdPUJ0umZri+JDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764632929; c=relaxed/simple;
	bh=mD1sn5jCtd8wpMuPDA3bquaZ+WJC5asepv9PtEUVMio=;
	h=Date:Message-ID:From:To:Cc:Subject; b=pX05w3o+Vl0qNicxIthug4KNk4IomNNqlEooJrgtzA/DdUTWx//+v1rkPIu4wMPC6lnaAZH8eEv3GxDvuJ8XQZvuz+UDZmLa1v3cFSITv6tFIb1Iv/K0mw9UWMqv/d2A4M+oMkE22ryAvfuITvQTzVgDZ2v4XJhCfG7S3SKLCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHDiSSoM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHDiSSoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D40C4CEF1;
	Mon,  1 Dec 2025 23:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764632928;
	bh=mD1sn5jCtd8wpMuPDA3bquaZ+WJC5asepv9PtEUVMio=;
	h=Date:From:To:Cc:Subject:From;
	b=BHDiSSoM4hYHvDLgdkWDgDPjHFovAV8dW86uBSMMDZJFXJ7Pojk4r5p85mUpsHwPx
	 k45XrtB3KCQx5oKRsfSe4sblrBo3L2w4nbG8QUWfreagmKhcmg8egQMdR36RWEtxKC
	 ZXG2SCQFz87l+eJ7THKeiw3194r0idtXw8LmQDvMMDzxzrCFai5oWv/N0cA5EmxW52
	 fHK5KvD7wKbZutBNRD74/HOGDTvXanppDo2VP01J4dLMc31H4QBaMwG7IWCTuarNoY
	 E2hdqG5zwmw8B+M2Qn+SQzjXRkxOjOXTnRhJ2VAxEd3Fj8Xj3BLUpoFvAbQZE8vtQM
	 JL6ic8hnH03Vw==
Date: Mon, 01 Dec 2025 13:48:47 -1000
Message-ID: <ca8ceefd49d27fa71aed4859c0037b2f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <multics69@gmail.com>, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Subject: [GIT PULL] sched_ext: Changes for v6.19
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The following changes since commit 81e839803f9355084bc78f9e0c350c4e2853c880:

  Merge tag 'cgroup-for-6.19' into pr-base-for-6.19 (2025-12-01 13:20:56 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19

for you to fetch changes up to 1dd6c84f1c544e552848a8968599220bd464e338:

  sched_ext: Fix incorrect sched_class settings for per-cpu migration tasks (2025-12-01 10:58:49 -1000)

Please note that sched_ext-for-6.19 is based on v6.18 + tip/sched-core-2025-12-01
+ cgroup/for-6.19.

When merging sched_ext-for-6.19 into the above base, there is a trivial merge
conflict in kernel/sched/ext.c around pick_task_scx(). Both sched_ext and tip
sched/core independently pulled in a8ad873113d3 ("sched_ext: defer
queue_balance_callback() until after ops.dispatch") resolving conflicts
slightly differently (whitespace only). 67fa319f5fff ("sched_ext: Allow
forcibly picking an scx task") then added further changes in the same area.
Resolve by taking the sched_ext side.

----------------------------------------------------------------
sched_ext: Changes for v6.19

- Improve recovery from misbehaving BPF schedulers. When a scheduler puts many
  tasks with varying affinity restrictions on a shared DSQ, CPUs scanning
  through tasks they cannot run can overwhelm the system, causing lockups.
  Bypass mode now uses per-CPU DSQs with a load balancer to avoid this, and
  hooks into the hardlockup detector to attempt recovery. Add scx_cpu0 example
  scheduler to demonstrate this scenario.

- Add lockless peek operation for DSQs to reduce lock contention for schedulers
  that need to query queue state during load balancing.

- Allow scx_bpf_reenqueue_local() to be called from anywhere in preparation for
  deprecating cpu_acquire/release() callbacks in favor of generic BPF hooks.

- Prepare for hierarchical scheduler support: add scx_bpf_task_set_slice() and
  scx_bpf_task_set_dsq_vtime() kfuncs, make scx_bpf_dsq_insert*() return bool,
  and wrap kfunc args in structs for future aux__prog parameter.

- Implement cgroup_set_idle() callback to notify BPF schedulers when a cgroup's
  idle state changes.

- Fix migration tasks being incorrectly downgraded from stop_sched_class to
  rt_sched_class across sched_ext enable/disable. Applied late as the fix is
  low risk and the bug subtle but needs stable backporting.

- Various fixes and cleanups including cgroup exit ordering, SCX_KICK_WAIT
  reliability, and backward compatibility improvements.

----------------------------------------------------------------
Andrea Righi (4):
      sched_ext: Exit early on hotplug events during attach
      sched_ext: Allow forcibly picking an scx task
      sched_ext: Fix scx_bpf_dsq_peek() with FIFO DSQs
      sched_ext: Update comments replacing breather with aborting mechanism

Rong Tao (1):
      sched_ext: tools: Removing duplicate targets during non-cross compilation

Ryan Newton (2):
      sched_ext: Add lockless peek operation for DSQs
      sched_ext: Add a selftest for scx_bpf_dsq_peek

Tejun Heo (34):
      tools/sched_ext: Strip compatibility macros for cgroup and dispatch APIs
      sched_ext: Add scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime()
      sched_ext: Wrap kfunc args in struct to prepare for aux__prog
      sched_ext: Make scx_bpf_dsq_insert*() return bool
      sched_ext/tools: Add compat wrapper for scx_bpf_task_set_slice/dsq_vtime()
      sched_ext: Fix scx_bpf_dsq_insert() backward binary compatibility
      sched_ext: Don't kick CPUs running higher classes
      sched_ext: Fix SCX_KICK_WAIT to work reliably
      sched_ext: Rename pnt_seq to kick_sync
      sched_ext: Use rhashtable_lookup() instead of rhashtable_lookup_fast()
      sched_ext: Add ___compat suffix to scx_bpf_dsq_insert___v2 in compat.bpf.h
      sched_ext: Use SCX_TASK_READY test instead of tryget_task_struct() during class switch
      sched_ext: Split schedule_deferred() into locked and unlocked variants
      sched_ext: Factor out reenq_local() from scx_bpf_reenqueue_local()
      sched_ext: Allow scx_bpf_reenqueue_local() to be called from anywhere
      sched_ext/tools: Restore backward compat with v6.12 kernels
      sched_ext: Fix cgroup exit ordering by moving sched_ext_free() to finish_task_switch()
      sched_ext: Move __SCX_DSQ_ITER_ALL_FLAGS BUILD_BUG_ON to the right place
      sched_ext: Minor cleanups to scx_task_iter
      sched_ext: Mark racy bitfields to prevent adding fields that can't tolerate races
      sched_ext: Use shorter slice in bypass mode
      sched_ext: Refactor do_enqueue_task() local and global DSQ paths
      sched_ext: Use per-CPU DSQs instead of per-node global DSQs in bypass mode
      sched_ext: Simplify breather mechanism with scx_aborting flag
      sched_ext: Exit dispatch and move operations immediately when aborting
      sched_ext: Make scx_exit() and scx_vexit() return bool
      sched_ext: Refactor lockup handlers into handle_lockup()
      sched_ext: Make handle_lockup() propagate scx_verror() result
      sched_ext: Hook up hardlockup detector
      sched_ext: Add scx_cpu0 example scheduler
      sched_ext: Factor out scx_dsq_list_node cursor initialization into INIT_DSQ_LIST_CURSOR
      sched_ext: Factor out abbreviated dispatch dequeue into dispatch_dequeue_locked()
      sched_ext: Implement load balancer for bypass mode
      sched_ext: Pass locked CPU parameter to scx_hardlockup() and add docs

Zqiang (2):
      sched_ext: Use kvfree_rcu() to release per-cpu ksyncs object
      sched_ext: Fix incorrect sched_class settings for per-cpu migration tasks

zhidao su (1):
      sched/ext: Implement cgroup_set_idle() callback

 include/linux/sched/ext.h                        |   27 +-
 include/trace/events/sched_ext.h                 |   39 +
 kernel/fork.c                                    |    1 -
 kernel/sched/core.c                              |    6 +
 kernel/sched/ext.c                               | 1068 ++++++++++++++++------
 kernel/sched/ext_idle.c                          |   43 +-
 kernel/sched/ext_internal.h                      |   29 +-
 kernel/sched/sched.h                             |    4 +-
 kernel/watchdog.c                                |    9 +
 tools/sched_ext/Makefile                         |    4 +-
 tools/sched_ext/include/scx/common.bpf.h         |   15 +-
 tools/sched_ext/include/scx/compat.bpf.h         |  314 ++++--
 tools/sched_ext/include/scx/compat.h             |   14 +
 tools/sched_ext/scx_cpu0.bpf.c                   |   88 ++
 tools/sched_ext/scx_cpu0.c                       |  106 +++
 tools/sched_ext/scx_flatcg.bpf.c                 |   10 +-
 tools/sched_ext/scx_qmap.bpf.c                   |   52 +-
 tools/testing/selftests/sched_ext/Makefile       |    1 +
 tools/testing/selftests/sched_ext/peek_dsq.bpf.c |  251 +++++
 tools/testing/selftests/sched_ext/peek_dsq.c     |  224 +++++
 20 files changed, 1894 insertions(+), 411 deletions(-)
 create mode 100644 tools/sched_ext/scx_cpu0.bpf.c
 create mode 100644 tools/sched_ext/scx_cpu0.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c

Thanks.

-- 
tejun
