Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCE1C862F;
	Tue, 28 Apr 2026 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777406116; cv=none; b=UGZ9WJUVrrtuD6yL/nx+VP2eu8Sx5lw3DGXtR5bHyJf7dDs3FK4s3WtJnRQBsN9gTgSW0+X7cZCTIkD0aVxASkALe6u7e5MGPK1HgM1V7BLLrukyFaIxA1gPRuHKFQEBUByWsdA7N/96gEUeTT9FU6dsRA61nQVQRureZEbNUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777406116; c=relaxed/simple;
	bh=9fGRcYD2lJVElyKOqO6dZlW5Y2Sit+f8XdeyLcj3xEU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=TjRzei4SlEMMDFKNRziVIUIXRd8BD/TgVvXkJi6Qxm+c0/97/Vxl+1Qq6HXN1z510UZOL3LnLPtywihFxG6FUolj1c42CeibHtoBF/vlb4MTQ6zDE+wztRhx+QaStP4O93P7blT716CLGeTYaa/Flqrhe7XdK/AUdwi4Vka8pc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2IAbbjt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2IAbbjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559ABC2BCB3;
	Tue, 28 Apr 2026 19:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777406116;
	bh=9fGRcYD2lJVElyKOqO6dZlW5Y2Sit+f8XdeyLcj3xEU=;
	h=Date:From:To:Cc:Subject:From;
	b=n2IAbbjtrnzLi+4+SmUkJ/GZVk2V8U/iuxwpy4cpxjSassPk+xlEs26CCEkiFwatE
	 +XFT6YM96woWi4oS1RRz7yCVe88XTagMHDx3nrHxZp4sA7gbomTsMPiBjWAilN32Vf
	 6dtCYgw28T2Oh8eXBmw5CboFpN4jUrWszCXSVFokCDBOD5ttjJkp8h4LVr9SgnDH0o
	 brtlt8/5SMJdNESlbWYMRUTsfaNFpxDJlIDYGDlohk43LiDIS41tvOJecsc7/9yr8g
	 tuNzjjR+vPYyQl8LrQAAPARRyHFwSB+Ayjt/QrQpzAMJRZwr1FB+kXrfO/Z2WfEilP
	 lcTzRouMgAN0g==
Date: Tue, 28 Apr 2026 09:55:15 -1000
Message-ID: <bb1b25a09c382529d9b9d9024b4721fa@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [GIT PULL] sched_ext: Fixes for v7.1-rc1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Linus.

The following changes since commit 3cd8b194bf3428dfa53120fee47e827a7c495815:

  Merge tag 'v7.1-rc-part1-smbdirect-fixes' of git://git.samba.org/ksmbd (2026-04-16 08:25:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc1-fixes

for you to fetch changes up to d99f7a32f09dccbe396187370ec1a74a31b73d7e:

  sched_ext: Fix scx_flush_disable_work() UAF race (2026-04-28 07:40:03 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.1-rc1

The merge window pulled in the cgroup sub-scheduler infrastructure, and
new AI reviews are accelerating bug reporting and fixing - hence the
larger than usual fixes batch.

- Use-after-frees during scheduler load/unload. The disable path
  could free the BPF scheduler while deferred irq_work / kthread work
  was still in flight; cgroup setter callbacks read the active
  scheduler outside the rwsem that synchronizes against teardown.
  Fixed both, and reused the disable drain in the enable error paths
  so the BPF JIT page can't be freed under live callbacks.

- Several BPF op invocations didn't tell the framework which runqueue
  was already locked, so helper kfuncs that re-acquire the runqueue
  by CPU could deadlock on the held lock. Fixed at the affected
  callsites, including recursive parent-into-child dispatch.

- The hardlockup notifier ran from NMI but eventually took a
  non-NMI-safe lock. Bounced through irq_work.

- A handful of bugs in the new sub-scheduler hierarchy: helper
  kfuncs hard-coded the root instead of resolving the caller's
  scheduler; the enable error path tried to disable per-task state
  that had never been initialized, and leaked cpus_read_lock on the
  way out; a sysfs object was leaked on every load/unload; the
  dispatch fast-path used the root scheduler instead of the task's;
  and a couple of CONFIG #ifdef guards were misclassified.

- Verifier-time hardening: BPF programs of unrelated struct_ops
  types (e.g. tcp_congestion_ops) could call sched_ext kfuncs - a
  semantic bug and, once sub-sched was enabled, a KASAN
  out-of-bounds read. Now rejected at load. Plus a few NULL and
  cross-task argument checks on sched_ext kfuncs, and a selftest
  covering the new deny.

- rhashtable (Herbert): restored the insecure_elasticity toggle and
  bounced the deferred-resize kick through irq_work to break a
  lock-order cycle observable from raw-spinlock callers. sched_ext's
  scheduler-instance hash is the first user of both.

- The bypass-mode load balancer used file-scope cpumasks; with
  multiple scheduler instances now possible, those raced. Moved
  per-instance, plus a follow-up to skip tasks whose recorded CPU is
  stale relative to the new owning runqueue.

- Smaller fixes: a dispatch queue's first-task tracking misbehaved
  when a parked iterator cursor sat in the list; the runqueue's
  next-class wasn't promoted on local-queue enqueue, leaving an SCX
  task behind RT in edge cases; the reference qmap scheduler stopped
  erroring on legitimate cross-scheduler task-storage misses.

----------------------------------------------------------------
Cheng-Yang Chou (3):
      sched_ext: Deny SCX kfuncs to non-SCX struct_ops programs
      selftests/sched_ext: Add non_scx_kfunc_deny test
      sched_ext: Fix scx_flush_disable_work() UAF race

Herbert Xu (1):
      rhashtable: Restore insecure_elasticity toggle

Kuba Piecuch (1):
      sched_ext: Call wakeup_preempt() in local_dsq_post_enq()

Richard Cheng (1):
      sched_ext: sync disable_irq_work in bpf_scx_unreg()

Tejun Heo (19):
      sched_ext: Mark scx_sched_hash insecure_elasticity
      rhashtable: Bounce deferred worker kick through irq_work
      tools/sched_ext: scx_qmap: Silence task_ctx lookup miss
      sched_ext: Defer scx_hardlockup() out of NMI
      sched_ext: Unregister sub_kset on scheduler disable
      sched_ext: Guard scx_dsq_move() against NULL kit->dsq after failed iter_new
      sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu()
      sched_ext: Don't disable tasks in scx_sub_enable_workfn() abort path
      sched_ext: Read scx_root under scx_cgroup_ops_rwsem in cgroup setters
      sched_ext: Resolve caller's scheduler in scx_bpf_destroy_dsq() / scx_bpf_dsq_nr_queued()
      sched_ext: Use dsq->first_task instead of list_empty() in dispatch_enqueue() FIFO-tail
      sched_ext: Save and restore scx_locked_rq across SCX_CALL_OP
      sched_ext: Pass held rq to SCX_CALL_OP() for dump_cpu/dump_task
      sched_ext: Pass held rq to SCX_CALL_OP() for core_sched_before
      sched_ext: Make bypass LB cpumasks per-scheduler
      sched_ext: Align cgroup #ifdef guards with SUB_SCHED vs GROUP_SCHED
      sched_ext: Refuse cross-task select_cpu_from_kfunc calls
      sched_ext: Reject NULL-sch callers in scx_bpf_task_set_slice/dsq_vtime
      sched_ext: Release cpus_read_lock on scx_link_sched() failure in root enable

zhidao su (1):
      sched_ext: Fix local_dsq_post_enq() to use task's scheduler in sub-sched

 include/linux/rhashtable-types.h                   |   5 +
 include/linux/rhashtable.h                         |   8 +-
 kernel/sched/ext.c                                 | 398 ++++++++++++++-------
 kernel/sched/ext_idle.c                            |  20 +-
 kernel/sched/ext_idle.h                            |   1 +
 kernel/sched/ext_internal.h                        |   2 +
 lib/rhashtable.c                                   |  36 +-
 tools/sched_ext/scx_qmap.bpf.c                     |  24 +-
 tools/testing/selftests/sched_ext/Makefile         |   1 +
 .../selftests/sched_ext/non_scx_kfunc_deny.bpf.c   |  44 +++
 .../selftests/sched_ext/non_scx_kfunc_deny.c       |  47 +++
 11 files changed, 436 insertions(+), 150 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/non_scx_kfunc_deny.c

Thanks.

--
tejun
