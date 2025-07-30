Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1619139B;
	Wed, 30 Jul 2025 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753917453; cv=none; b=qCrwr4NU4Bm2R/joMoAa9DEgYbQxOwgCOHWxVL7D9MRxmDCcDA4z7Y7FW2/KRa0Du5ywSQo1xwW1qGa65Z/qCncQNJ3u6Ehw0K+AGE30qaaFC8EeEDnpVCO2oRgTbSuf4jy/ufE6oPvyvFa65KeZ6s0rRDYwAyi3lWZ+O/KNITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753917453; c=relaxed/simple;
	bh=usQeiladO4SDE2xY1rjGtFzjou57Fgbm4iDs/oYuVYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jrwTLtT8ADymYGaWpfjoq9v4gzQ/YiIK9NDlxZ25iLBy1KNKK/lY3ny+YOAuiqePDqovfOVw7r+cY0v4vIpx6sR5cCp9tXZdToycT9XbmB+uFY3izwCQYz+qzKWQ6krV7z+P+1Nk/e2dwEdTPEw3NsWL/ju/CWFYdhQoQQTjil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lh4pmISM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lh4pmISM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EA7C4CEE3;
	Wed, 30 Jul 2025 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753917452;
	bh=usQeiladO4SDE2xY1rjGtFzjou57Fgbm4iDs/oYuVYw=;
	h=Date:From:To:Cc:Subject:From;
	b=lh4pmISMJ9uQsx6lpzVyKgHL86k7TmFOC3v8kxaGj6UDv9240/C3o/xKwD19bdPKv
	 29DXGEdi2gujlGZIrUhGWWZnkGlhRGP7m8UFytHbSau65uC5Es+TJgYPm4OCQ61KB2
	 6MS3BlZQf0SIf/8hDpLlzF8g79N0ueVXFixOJ3IpHO7DD3XmpxGDeXxarWo8/ovCND
	 EDQz3bMRcbI1sxzb4wQrk/Z3hUnOicIptGfUnhWWzrFpM2l6rEZk8oj5BM1R1cWPD1
	 QN2On2clWjGddwZINqsh0Wh2jXn5tpUl+JtWh9eajlvLsj7rKdspas9HbvrXBpdWMb
	 tUkk1cNPT2Aeg==
Date: Wed, 30 Jul 2025 13:17:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: [GIT PULL] sched_ext: Changes for v6.17
Message-ID: <aIqoCzHb5yRoQsER@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5bc34be478d09c4d16009e665e020ad0fcd0deea:

  sched/core: Reorganize cgroup bandwidth control interface file writes (2025-06-18 13:59:57 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.17

for you to fetch changes up to ae96bba1ca0000ebb3f3ced64c9367e2a223d69e:

  sched_ext: Fix scx_bpf_reenqueue_local() reference (2025-07-17 08:17:26 -1000)

----------------------------------------------------------------
sched_ext: Changes for v6.17

- Add support for cgroup "cpu.max" interface.

- Code organization cleanup so that ext_idle.c doesn't depend on the
  source-file-inclusion build method of sched/.

- Drop UP paths in accordance with sched core changes.

- Documentation and other misc changes.

----------------------------------------------------------------
Andrea Righi (5):
      sched_ext: idle: Remove unnecessary ifdef in scx_bpf_cpu_node()
      sched_ext: idle: Make local functions static in ext_idle.c
      sched_ext: Make scx_rq_bypassing() inline
      sched_ext: Make scx_locked_rq() inline
      sched_ext: Documentation: Clarify time slice handling in task lifecycle

Cheng-Yang Chou (5):
      sched_ext: Always use SMP versions in kernel/sched/ext.c
      sched_ext: Always use SMP versions in kernel/sched/ext.h
      sched_ext: Always use SMP versions in kernel/sched/ext_idle.c
      sched_ext: Always use SMP versions in kernel/sched/ext_idle.h
      sched_ext: Return NULL in llc_span

Christian Loehle (1):
      sched_ext: Fix scx_bpf_reenqueue_local() reference

David Dai (1):
      sched_ext, rcu: Eject BPF scheduler on RCU CPU stall panic

Jake Hillion (1):
      sched_ext: Drop kfuncs marked for removal in 6.15

Ke Ma (1):
      kernel/sched/ext.c: fix typo "occured" -> "occurred" in comments

Tejun Heo (5):
      Merge branch 'sched/core' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into for-6.17
      sched_ext: Merge branch 'sched/core' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into for-6.17
      sched_ext: Merge branch 'for-6.16-fixes' into for-6.17
      sched_ext, sched/core: Factor out struct scx_task_group
      sched_ext: Add support for cgroup bandwidth control interface

 Documentation/scheduler/sched-ext.rst           |  11 +-
 MAINTAINERS                                     |   2 +-
 arch/powerpc/platforms/book3s/vas-api.c         |   9 +
 arch/powerpc/platforms/powernv/memtrace.c       |   8 +-
 include/linux/key.h                             |   2 +-
 include/linux/sched/ext.h                       |  23 ++-
 init/Kconfig                                    |   5 +
 kernel/rcu/tree_stall.h                         |   7 +
 kernel/sched/core.c                             |  33 ++-
 kernel/sched/ext.c                              | 261 ++++++++++++------------
 kernel/sched/ext.h                              |  22 +-
 kernel/sched/ext_idle.c                         |  45 +---
 kernel/sched/ext_idle.h                         |  12 --
 kernel/sched/sched.h                            |   9 +-
 mm/damon/Kconfig                                |   1 -
 security/keys/gc.c                              |   4 +-
 security/keys/key.c                             |   5 +-
 tools/sched_ext/scx_qmap.bpf.c                  |  23 +++
 tools/testing/selftests/sched_ext/maximal.bpf.c |   5 +
 19 files changed, 275 insertions(+), 212 deletions(-)

-- 
tejun
