Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023133876C6;
	Wed, 13 May 2026 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705996; cv=none; b=I6+tFiWItcQbSKsLXlkv6YN5SF2Gmte8ptKvAMnxB1CcxM2XyTG8Fqcz+rntm6tdyRwruzInZudMaRbWJnj7OV9Gdu65k4S/81DxlVPehnlk7DITWY2E9j1WAokkeKSzqKXAwpneZiAkD94yVDjUx0q9YMqrjjYBQhDSov3RjZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705996; c=relaxed/simple;
	bh=1g2+qAIHFU6GzY+1bNAsFwcYkLyoqVTGv1r5SeHQvF0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=RulZT0ocEW9RDAiN8dylCo9CwNGZg3ur7lOAMZSecwPcyF2cTAyqhJN+DZbEuyDL6G3Ojr3oHhP7CNM81ZRgTPt65Qr2XdUsVC2ONyV95B8eHo+NeUaxXHlEmQGTfA6M9PpUqxj3QEFQDRxecmZSEBAAsX/kOqiSXloVIv2igSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ6+Ucep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ6+Ucep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC84C19425;
	Wed, 13 May 2026 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778705995;
	bh=1g2+qAIHFU6GzY+1bNAsFwcYkLyoqVTGv1r5SeHQvF0=;
	h=Date:From:To:Cc:Subject:From;
	b=qQ6+Ucepk/j01piDQ4JRvD1lilTJ8fpGIYFL6v5mmWPVqNRnHYpLN3URQV9CmZxWj
	 JM3A2LZ/pj4GLDk/DCBGU+oiXFqvt089Ad+W39zVkKPVPGFmYpVNJC+HvK9/NN7Vfr
	 uhfEBSIOrsb5THrMxg3XL7kYDBbYRPLu4hYCH/ngMEP8dhLzHBQhj8E+2GOOEo4lzB
	 /pxjxEx9k7ckAooTD2TaGB7tyj2OODZm4ggCRSF6YRoccKCTcC/ZlgyxiiMc48VfhW
	 k63JVHMWrX2PX0my6BPKbjSLJrISwSxw0/5Lr8FQZKPZrfflP5elDuEgf86TjEnNS5
	 WJkTw7hL/xCpw==
Date: Wed, 13 May 2026 10:59:54 -1000
Message-ID: <4acd9d173508e386568e333a474d606e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.1-rc3
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Linus.

The following changes since commit b34c82777a2c0648ee053595f4b290fd5249b093:

  sched_ext: idle: Recheck prev_cpu after narrowing allowed mask (2026-05-04 11:01:04 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc3-fixes

for you to fetch changes up to 6ae315d37924435516d697ea7dde0b799a5928e0:

  sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation (2026-05-13 10:02:57 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.1-rc3

Bulk is hardening of the new sub-scheduler infrastructure.

- UAFs and lifecycle bugs on the sub-sched attach/detach paths: parent
  sub_kset freed under a racing child, list_del_rcu on an uninitialized
  list head, ops->priv stomped by concurrent attach/detach, and a UAF in
  the init-failure error path.

- Task state-machine reorg closing concurrent enable-vs-dead races: a
  task exiting during the unlocked init window could trip NULL ops
  derefs or skip exit_task() cleanup.

- A scx_link_sched() self-deadlock on scx_sched_lock.

- isolcpus: stop dereferencing the now-RCU-protected HK_TYPE_DOMAIN
  cpumask without RCU, and stop rejecting BPF schedulers when only
  cpuset isolated partitions are active.

- PREEMPT_RT: disable irq_work runs in hardirq context so dumps show the
  failing task rather than the irq_work kthread.

- Assorted !CONFIG_EXT_SUB_SCHED, randconfig, and selftest build fixes.

----------------------------------------------------------------
Andrea Righi (4):
      selftests/sched_ext: Fix build error in dequeue selftest
      sched_ext: Fix ops->priv clobber on concurrent attach/detach
      sched_ext: Clear ops->priv on scx_alloc_and_add_sched() error paths
      sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation

Tejun Heo (13):
      sched_ext: Move scx_error() out of scx_link_sched()'s lock region
      sched_ext: Drop unused scx_find_sub_sched() stub
      sched_ext: Fix !CONFIG_EXT_SUB_SCHED build warnings
      sched_ext: Cleanups in preparation for the SCX_TASK_INIT_BEGIN/DEAD work
      sched_ext: Inline scx_init_task() and move RESET_RUNNABLE_AT into scx_set_task_state()
      sched_ext: Replace SCX_TASK_OFF_TASKS flag with SCX_TASK_DEAD state
      sched_ext: Close root-enable vs sched_ext_dead() race with SCX_TASK_INIT_BEGIN
      sched_ext: Close sub-sched init race with post-init DEAD recheck
      sched_ext: Handle SCX_TASK_NONE in disable/switched_from paths
      sched_ext: Avoid UAF in scx_root_enable_workfn() init failure path
      sched_ext: Drop NONE early return in scx_disable_and_exit_task()
      sched_ext: INIT_LIST_HEAD() &sch->all in scx_alloc_and_add_sched()
      sched_ext: Defer sub_kset base put to scx_sched_free_rcu_work

Zqiang (1):
      sched_ext: Use IRQ_WORK_INIT_HARD() to initialize sch->disable_irq_work

 include/linux/sched/ext.h                   |  17 +-
 kernel/sched/ext.c                          | 277 ++++++++++++++++++++--------
 tools/testing/selftests/sched_ext/dequeue.c |   1 +
 3 files changed, 206 insertions(+), 89 deletions(-)

Thanks.

--
tejun
