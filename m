Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785513F7ABB;
	Tue, 31 Mar 2026 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986213; cv=none; b=Ay5QKkAwZFMQ8BrT90lkmKWlakKHwcJcn4+7QSzKe5eDy2ImVRT/LYgc8jZruxg9PflxQqatvL+BHmlrCHFJYJX2oWnFuuOUm5UYgzzznhusqPwDEvglyVqctj8gpaSparFM73IvNyDXdZIpXae5txfhtbqqhaOnMuSI9gB+dPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986213; c=relaxed/simple;
	bh=5xBactUkdUL61P2Bk60O7TTgtDJjDSwmA/zPVctkBHM=;
	h=Date:Message-ID:From:To:Cc:Subject; b=sfrpJwJdOtba3dFQ0oRtNsZOqQ7Wic4+nfxnHvdJvHrc7aHA3K/SqY4SP7XufXoJr9aFIuFrJfIDOoyFld8H7ZKIR1fK8hxMxSKw2Z9k9X31SC5Z8izZayepvbXcqmDVt09IzHEqUZIhc+D5pZ6fWHOoljqjHYUpp/uk6+BgFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjf7FV1X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjf7FV1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1F9C19424;
	Tue, 31 Mar 2026 19:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774986213;
	bh=5xBactUkdUL61P2Bk60O7TTgtDJjDSwmA/zPVctkBHM=;
	h=Date:From:To:Cc:Subject:From;
	b=pjf7FV1X3weEwK+RJ7kw6yeSAUvl6ZCeP0h4KWwHDu9nGVDA5lDgJ+4kfeGHTsrPJ
	 S9NsfWtuC34lpxlbCzPtMmTb8kDL1DzibfDtxgZIeEPJbrR6td5LrRazV3OtKK6S4e
	 s7xR4r9dqMNn0ulW+QM1Q5sC4coAU/Pi5mc5VmiGKb4VVUYQZQrE3EmN6xVL8ECQiQ
	 bBrkmphfBKSjFpi1sS2/GK21tzXFkdLm0733AvaOFR6fh8z82yMWOOxd31uYUar3H2
	 1LHLrJhXMtb2cyWoQTP2yLqkG3v14baEi5jJZ0n7nJ4fFS+8rdEhA82Lz7e2lRafoa
	 hmzqmAZ7nS85Q==
Date: Tue, 31 Mar 2026 09:43:32 -1000
Message-ID: <cee468347c00b1b5158d0c3e54fb9573@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.0-rc6
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The following changes since commit 2fcfe5951eb2e8440fc5e1dd6ea977336ff83a1d:

  sched_ext: Use WRITE_ONCE() for the write side of scx_enable helper pointer (2026-03-09 06:08:26 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-rc6-fixes

for you to fetch changes up to 090d34f0f0285124452373225bcc520a31e305e4:

  selftests/sched_ext: Add cyclic SCX_KICK_WAIT stress test (2026-03-30 08:37:55 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.0-rc6

- Fix SCX_KICK_WAIT deadlock where multiple CPUs waiting for each other in
  hardirq context form a cycle. Move the wait to a balance callback which
  can drop the rq lock and process IPIs.

- Fix inconsistent NUMA node lookup in scx_select_cpu_dfl() where the
  waker_node used cpu_to_node() while prev_cpu used
  scx_cpu_node_if_enabled(), leading to undefined behavior when per-node
  idle tracking is disabled.

----------------------------------------------------------------
Cheng-Yang Chou (1):
      sched_ext: Fix inconsistent NUMA node lookup in scx_select_cpu_dfl()

Tejun Heo (2):
      sched_ext: Fix SCX_KICK_WAIT deadlock by deferring wait to balance callback
      selftests/sched_ext: Add cyclic SCX_KICK_WAIT stress test

 kernel/sched/ext.c                                 |  95 +++++++---
 kernel/sched/ext_idle.c                            |   2 +-
 kernel/sched/sched.h                               |   3 +
 tools/testing/selftests/sched_ext/Makefile         |   1 +
 .../selftests/sched_ext/cyclic_kick_wait.bpf.c     |  68 ++++++++
 .../testing/selftests/sched_ext/cyclic_kick_wait.c | 194 +++++++++++++++++++++
 6 files changed, 337 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/cyclic_kick_wait.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/cyclic_kick_wait.c

--
tejun
