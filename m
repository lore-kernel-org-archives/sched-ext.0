Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765C25776;
	Mon, 13 Jul 2026 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978148; cv=none; b=qvm+EYfwFenw3oWykG1+usui2Zh6y6YCF7xJhmbLMSyGjRS3SjYkonhxLVR1FbzCtdQnwZquN42IkmSaLkzj5FeFH/lTtHvYe4lxJW4FyRZDE7wHFxUM7SsjGWg/gZk/3tuRXWOUVI5f88rRsAKY16YK1rzr3rWSMUXGkWXS/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978148; c=relaxed/simple;
	bh=mKXJYOk1BVvgiuI57SvuFnWYP7KzAlEc3uBIDkJ3wZo=;
	h=Date:Message-ID:From:To:Cc:Subject; b=j7LGq/M2hALVjt8cviNv11okdZFKoDkKMNgj9aIJmVoxHfCUCfYlno1ChLUtRvOTzmNNMKpcHrtW12tVUh8uva+7CWpuzP/tjhP6RT33swwYvXV7lg8RaTXt8MvFWiajRqsG6dZcpRWy27YXvHn0Px1xh/GfqgDF5sMG4WVu0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Odic77HG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Odic77HG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746B61F00A3A;
	Mon, 13 Jul 2026 21:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783978146;
	bh=3KgDJ0cft/vYX8L7cTMuigwKoDFIx6YxI+emQxS3Csw=;
	h=Date:From:To:Cc:Subject;
	b=Odic77HGA0lM3OjFHc0Bnw2X0CQDFlCesJtH694nLxlysyuEFQrhpJGR6YqxZdaBJ
	 J193A9YJR45slGb+QiCxICK/dRUez7YUyEb3G+95rJus/GgOvYZLU7I5o6FpzbT3f9
	 a7Wrgb2ciQi2ltrbYgPnyI9LNFQBsd/ST5gHOY/SE3CerjSCJp/EvPjVWZCqYxT53t
	 YUJbf+pq0K5KgGdowMCCZogsQw0ftWuKUd8qutgSdrOssBE2/RogUHNTmcE89TC9PI
	 RPNERoY6WUtVPxeLpW+kMssrs42sZ4QtVYhthdYgi0DgJ0MLwcYJvejBuiSWLzCIcp
	 KBVbIW23txvEg==
Date: Mon, 13 Jul 2026 11:29:05 -1000
Message-ID: <876d09cb8d47617d382a7e2af7a7fd6b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [GIT PULL] sched_ext: Fixes for v7.2-rc3
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi Linus,

The following changes since commit f0e6f20cb52b14c2c441f04e21cef0c95d498cac:

  Merge tag 'ntfs3_for_7.2' of https://github.com/Paragon-Software-Group/linux-ntfs3 (2026-06-24 10:05:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2-rc3-fixes

for you to fetch changes up to 0e2f4ab68a89fad42e0f5a9ff4b740738e7aa1d6:

  sched_ext: Skip ops.set_weight() for disabled tasks (2026-07-10 06:41:28 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.2-rc3

- Lifecycle fixes for the new sub-scheduler support: two use-after-frees
  and an enable-failure path that left a half-initialized sub-scheduler
  linked.

- Two dispatch-path locking bugs: a spurious scheduler abort from a
  migration race, and a lockdep splat from stale runqueue-lock tracking.

- Callback and task-state fixes: stale scheduler-owned state on a task
  leaving SCX, a weight callback running after disable, and a bogus
  warning on core-scheduling forced idle.

- On nohz_full, finite-slice tasks could miss the tick that expires their
  slice. Enable it when such a task is picked, with a selftest.

- Smaller fixes: userspace CPU-mask helpers, ratelimited deprecation
  warnings, docs and a sparse annotation.

----------------------------------------------------------------
Andrea Righi (4):
      sched_ext: Reset dsq_vtime and slice when a task leaves SCX
      sched_ext: Preserve rq tracking across local DSQ dispatch
      sched_ext: Enable tick for finite slices on nohz_full
      selftests/sched_ext: Verify nohz_full tick behavior

Breno Leitao (1):
      sched_ext: Avoid flooding the log with deprecation warnings

Kuba Piecuch (2):
      sched_ext: Check remote rq eligibility under task's rq lock
      sched_ext: Skip ops.set_weight() for disabled tasks

Liang Luo (1):
      sched_ext: Documentation: Fix ops table header reference

Tejun Heo (6):
      sched_ext: Annotate ksyncs with __rcu in alloc/free_kick_syncs()
      sched_ext: Pin parent scx_sched across a child sub-scheduler's lifetime
      sched_ext: Don't warn on core-sched forced idle in put_prev_task_scx()
      sched_ext: Record an error on errno-only sub-enable failure
      sched_ext: Fix premature ops->priv publication in scx_alloc_and_add_sched()
      tools/sched_ext: scx - Fix cmask_subset(), cmask_equal() and cmask_weight()

 Documentation/scheduler/sched-ext.rst             |   8 +-
 kernel/sched/ext/ext.c                            | 177 ++++++++---
 kernel/sched/ext/internal.h                       |  23 +-
 tools/sched_ext/include/scx/cid.bpf.h             |  88 ++++--
 tools/testing/selftests/sched_ext/Makefile        |   1 +
 tools/testing/selftests/sched_ext/nohz_tick.bpf.c |  65 ++++
 tools/testing/selftests/sched_ext/nohz_tick.c     | 347 ++++++++++++++++++++++
 7 files changed, 614 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/nohz_tick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/nohz_tick.c

Thanks.

--
tejun
