Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891E39E6F1;
	Mon,  9 Feb 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665577; cv=none; b=O5Z1t4OhpORJhHA3Nvb3Cc3owoh5EJTs9FVgBxZpHaBWxMczWTrqCwIKCFsdxIAPXLs6kJrntBiWF9/q5oJ1M/yIQ5qsD+gEsio81ZupPDrxZssD4dbVSWVQZMhPrcWXPqrisrN1Aen3J7rJKCpW1mxmbZlwylhLYg3wNkjdPfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665577; c=relaxed/simple;
	bh=B8Ay8stAS/3Gnk38rwyMulmEBVGc0Oyyw21NSjZh6Z0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=hnXE05HrG0hWNt4WcGCD/3aNQQCE7CoXYSl0Qi9gHdOSDRCsDtYmgJWcbFbMX+OUsnLKn//f1njsjMoCf4/YtuF323JvQjyb5vRw/4J8Dx6WCD7L5hPFWik8iziDu0Fa2XRA1dJKlRDZ1Mxouwc5g1tD3f6OMIlTXJIT8BphRAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOYRSLVi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOYRSLVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03691C116C6;
	Mon,  9 Feb 2026 19:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770665577;
	bh=B8Ay8stAS/3Gnk38rwyMulmEBVGc0Oyyw21NSjZh6Z0=;
	h=Date:From:To:Cc:Subject:From;
	b=eOYRSLViO+N21tS7ao9EINa85G2a34fu39tqjf5qiLQ0kttfrrZTavKIt5xIDBjqq
	 sls6jhySz8P/de5NYMi5sDG/jvEJQIde2MErs0I9dP7NxzzUSMEl9OLp5ptDVc/U90
	 0HfmZL1zRKFo7U4u8NWIoHmLiD0Gyv0EfDXZxV6xDoXpP3KraryROAwkDH3CpAGzfi
	 O6Tu9IWBF3DlzHwwP7FqFNKTTPZN42o1NxN7aI8FR5RqTV9mR979Gcd+vGmdxIJInh
	 QSiKbyHNQDuvTpi39CaTm0ZGUbcvWLQ52x/e+PVxamXuf5x+iLOj2D5wdJLH4o5F7f
	 1L35emBgOyy1A==
Date: Mon, 09 Feb 2026 09:32:56 -1000
Message-ID: <b9f4cf5db168c619bbb67f05d3c61109@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Changes for v6.20
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi, Linus.

The following changes since commit ccaeeb585c7c2a0ac67ee1af9acb4d1411dc409e:

  sched_ext: Use the resched_cpu() to replace resched_curr() in the bypass_lb_node() (2025-12-22 17:51:51 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.20

for you to fetch changes up to 4544e9c4ec9a5955a37fdd8204a3d98106f97ab7:

  selftests/sched_ext: Fix init_enable_count flakiness (2026-02-02 09:45:09 -1000)

----------------------------------------------------------------
sched_ext: Changes for v6.20

- Move C example schedulers back from the external scx repo to
  tools/sched_ext as the authoritative source. scx_userland and scx_pair
  are returning while scx_sdt (BPF arena-based task data management) is
  new. These schedulers will be dropped from the external repo.

- Improve error reporting by adding scx_bpf_error() calls when DSQ
  creation fails across all in-tree schedulers.

- Avoid redundant irq_work_queue() calls in destroy_dsq() by only
  queueing when llist_add() indicates an empty list.

- Fix flaky init_enable_count selftest by properly synchronizing
  pre-forked children using a pipe instead of sleep().

----------------------------------------------------------------
Emil Tsalapatis (4):
      tools/sched_ext: add scx_userland scheduler
      tools/sched_ext: add scx_pair scheduler
      tools/sched_ext: add arena based scheduler
      tools/sched_ext: Fix data header access during free in scx_sdt

George Guo (1):
      sched_ext: Add error logging for dsq creation failures

Tejun Heo (1):
      selftests/sched_ext: Fix init_enable_count flakiness

Zqiang (1):
      sched_ext: Avoid multiple irq_work_queue() calls in destroy_dsq()

zhidao su (1):
      tools/sched_ext: Add error logging for dsq creation failures in remaining schedulers

 kernel/sched/ext.c                                 |   4 +-
 tools/sched_ext/Makefile                           |   2 +-
 tools/sched_ext/scx_central.bpf.c                  |   4 +-
 tools/sched_ext/scx_cpu0.bpf.c                     |  10 +-
 tools/sched_ext/scx_flatcg.bpf.c                   |  14 +-
 tools/sched_ext/scx_pair.bpf.c                     | 610 ++++++++++++++++++
 tools/sched_ext/scx_pair.c                         | 180 ++++++
 tools/sched_ext/scx_pair.h                         |   9 +
 tools/sched_ext/scx_qmap.bpf.c                     |   8 +-
 tools/sched_ext/scx_sdt.bpf.c                      | 716 +++++++++++++++++++++
 tools/sched_ext/scx_sdt.c                          | 101 +++
 tools/sched_ext/scx_sdt.h                          | 113 ++++
 tools/sched_ext/scx_simple.bpf.c                   |  10 +-
 tools/sched_ext/scx_userland.bpf.c                 | 344 ++++++++++
 tools/sched_ext/scx_userland.c                     | 437 +++++++++++++
 tools/sched_ext/scx_userland.h                     |  17 +
 .../selftests/sched_ext/init_enable_count.c        |  34 +-
 17 files changed, 2592 insertions(+), 21 deletions(-)
 create mode 100644 tools/sched_ext/scx_pair.bpf.c
 create mode 100644 tools/sched_ext/scx_pair.c
 create mode 100644 tools/sched_ext/scx_pair.h
 create mode 100644 tools/sched_ext/scx_sdt.bpf.c
 create mode 100644 tools/sched_ext/scx_sdt.c
 create mode 100644 tools/sched_ext/scx_sdt.h
 create mode 100644 tools/sched_ext/scx_userland.bpf.c
 create mode 100644 tools/sched_ext/scx_userland.c
 create mode 100644 tools/sched_ext/scx_userland.h

--
tejun
