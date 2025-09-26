Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE68BEC;
	Fri, 26 Sep 2025 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758915627; cv=none; b=BbRpF7gKJ3SRbu4xzHeO5meowNg/NygYRWE95H7/oX5S3/k9ecf7xP+crWPfgr7C/UTg5WzqSFyvq9I6cPEjHS/Qk0UcOaDZi7klKb2mHLL2KwjTfzoCPWbe4HCgCs2c6xkfLuXI/AXByjBgJzdOeiFlCXci1T0B1kX+/X2jwGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758915627; c=relaxed/simple;
	bh=k+pYHKvALO7H7JunEYN+ZjiaP1NCTuZAw69yNbSsrDg=;
	h=Date:Message-ID:From:To:Cc:Subject; b=GvQJ+qUCrJCEM+xw/bFlS9XcgqKS3sMR46hCL1yiBWPRxRJzAPb6tTSqsb1G5LrxajmNkzvLNrOxauNq+5MfQOf+uAqf9AbndpMGJ9tyTEWuedKvlG1CgJ3pHXcqPZjvdKkdDonxxdgZs8cFE6nA4JWRc4P8X4nRghfJr2INmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe+bovMr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe+bovMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFCBC4CEF4;
	Fri, 26 Sep 2025 19:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758915627;
	bh=k+pYHKvALO7H7JunEYN+ZjiaP1NCTuZAw69yNbSsrDg=;
	h=Date:From:To:Cc:Subject:From;
	b=Qe+bovMrjQURS3DpcEfWtqXHoLaFekzHXbWSlhLSImiNxg21ZZNm+JXIPuMdt0+8Q
	 oczPAXK83QE1Y7ee5tFXH2plCAR+xb7l+h7asYkxYzxE1W8LY9IkJ4sXbF0+skzr+t
	 KOoo7Z4qiUNh4GQK4zB8Pd5Cq3cVxahlxLf5S6747A2lbq5qIkBtHocae5RAki4wqw
	 Px3JBSYubCIBPvgl3gz9qg56QZWp60kz9YiSot4YTHnmq5OPgcvBGYQ0FCQP3diCmx
	 kq5O9pnI0qqMnsL75+z457ALg6BUs+6oZ11lI4cASWN9xgJfrRqLY4UkzIVk2KA/Zw
	 Pxg6Kb3XwRwqw==
Date: Fri, 26 Sep 2025 09:40:26 -1000
Message-ID: <41d26de7756d571845b9feb04a4e8e9d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: [GIT PULL] sched_ext: Changes for v6.18
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The following changes since commit 55ed11b181c43d81ce03b50209e4e7c4a14ba099:

  sched_ext: idle: Handle migration-disabled tasks in BPF code (2025-09-22 06:24:44 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18

for you to fetch changes up to df10932ad740ba1f871b6dd2ddafc7dc8cea944f:

  Revert "sched_ext: Use rhashtable_lookup() instead of rhashtable_lookup_fast()" (2025-09-23 20:38:23 -1000)

----------------------------------------------------------------
sched_ext: Changes for v6.18

- Code organization cleanup. Separate internal types and accessors to
  ext_internal.h to reduce the size of ext.c and improve maintainability.

- Prepare for cgroup sub-scheduler support by adding @sch parameter to
  various functions and helpers, reorganizing scheduler instance handling,
  and dropping obsolete helpers like scx_kf_exit() and kf_cpu_valid().

- Add new scx_bpf_cpu_curr() and scx_bpf_locked_rq() BPF helpers to provide
  safer access patterns with proper RCU protection. scx_bpf_cpu_rq() is
  deprecated with warnings due to potential race conditions.

- Improve debugging with migration-disabled counter in error state dumps,
  SCX_EFLAG_INITIALIZED flag, bitfields for warning flags, and other
  enhancements to help diagnose issues.

- Use cgroup_lock/unlock() for cgroup synchronization instead of
  scx_cgroup_rwsem based synchronization. This is simpler and allows
  enable/disable paths to synchronize against cgroup changes independent of
  the CPU controller.

- rhashtable_lookup() replacement to avoid redundant RCU locking was
  reverted due to RCU usage warnings. Will be redone once rhashtable is
  updated to use rcu_dereference_all().

- Other misc updates and fixes including bypass handling improvements,
  scx_task_iter_relock() improvements, tools/sched_ext updates, and
  compatibility helpers.

----------------------------------------------------------------
Andrea Righi (5):
      tools/sched_ext: Receive updates from SCX repo
      tools/sched_ext: Add compat helper for scx_bpf_cpu_curr()
      sched_ext: Fix NULL dereference in scx_bpf_cpu_rq() warning
      sched_ext: Add migration-disabled counter to error state dump
      sched_ext: Verify RCU protection in scx_bpf_cpu_curr()

Christian Loehle (3):
      sched_ext: Introduce scx_bpf_locked_rq()
      sched_ext: Introduce scx_bpf_cpu_curr()
      sched_ext: deprecation warn for scx_bpf_cpu_rq()

Tejun Heo (21):
      sched_ext: Make explicit scx_task_iter_relock() calls unnecessary
      sched_ext: Keep bypass on between enable failure and scx_disable_workfn()
      sched_ext: Move internal type and accessor definitions to ext_internal.h
      sched_ext: Put event_stats_cpu in struct scx_sched_pcpu
      sched_ext: Use cgroup_lock/unlock() to synchronize against cgroup operations
      sched_ext: Use rhashtable_lookup() instead of rhashtable_lookup_fast()
      sched_ext: Improve SCX_KF_DISPATCH comment
      sched_ext: Fix stray scx_root usage in task_can_run_on_remote_rq()
      sched_ext: Use bitfields for boolean warning flags
      sched_ext: Add SCX_EFLAG_INITIALIZED to indicate successful ops.init()
      sched_ext: Make qmap dump operation non-destructive
      tools/sched_ext: scx_qmap: Make debug output quieter by default
      sched_ext: Separate out scx_kick_cpu() and add @sch to it
      sched_ext: Add the @sch parameter to __bstr_format()
      sched_ext: Add the @sch parameter to ext_idle helpers
      sched_ext: Drop kf_cpu_valid()
      sched_ext: Add the @sch parameter to scx_dsq_insert_preamble/commit()
      sched_ext: Drop scx_kf_exit() and scx_kf_error()
      sched_ext: Misc updates around scx_sched instance pointer
      sched_ext: Merge branch 'for-6.17-fixes' into for-6.18
      Revert "sched_ext: Use rhashtable_lookup() instead of rhashtable_lookup_fast()"

 include/linux/sched/ext.h                          |    6 +-
 kernel/sched/build_policy.c                        |    1 +
 kernel/sched/core.c                                |    2 -
 kernel/sched/ext.c                                 | 1556 ++++----------------
 kernel/sched/ext.h                                 |   25 -
 kernel/sched/ext_idle.c                            |  146 +-
 kernel/sched/ext_internal.h                        | 1078 ++++++++++++++
 tools/sched_ext/include/scx/bpf_arena_common.bpf.h |  175 +++
 tools/sched_ext/include/scx/bpf_arena_common.h     |   33 +
 tools/sched_ext/include/scx/common.bpf.h           |  104 +-
 tools/sched_ext/include/scx/common.h               |    5 +-
 tools/sched_ext/include/scx/compat.bpf.h           |   22 +
 tools/sched_ext/include/scx/user_exit_info.bpf.h   |   40 +
 tools/sched_ext/include/scx/user_exit_info.h       |   49 +-
 .../sched_ext/include/scx/user_exit_info_common.h  |   30 +
 tools/sched_ext/scx_central.bpf.c                  |    2 +-
 tools/sched_ext/scx_central.c                      |    1 +
 tools/sched_ext/scx_flatcg.bpf.c                   |    2 +-
 tools/sched_ext/scx_flatcg.c                       |    2 +
 tools/sched_ext/scx_qmap.bpf.c                     |   98 +-
 tools/sched_ext/scx_qmap.c                         |   12 +-
 tools/sched_ext/scx_simple.c                       |    2 +
 22 files changed, 1992 insertions(+), 1399 deletions(-)
 create mode 100644 kernel/sched/ext_internal.h
 create mode 100644 tools/sched_ext/include/scx/bpf_arena_common.bpf.h
 create mode 100644 tools/sched_ext/include/scx/bpf_arena_common.h
 create mode 100644 tools/sched_ext/include/scx/user_exit_info.bpf.h
 create mode 100644 tools/sched_ext/include/scx/user_exit_info_common.h
