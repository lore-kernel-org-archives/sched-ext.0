Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1338737E;
	Fri, 13 Mar 2026 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433718; cv=none; b=m5t/8oe2eXaefDYAFlxzc6toxbTFf2ENdIZ0EvJ/1nX07o83YWQJWIDgAk4IYBV94SQ68E9LNInPTKBJOOq9adYri2mJa8phxD9ciYnQEsHgwfOMIG7q6B6FsZJW32XwW0U2hfdd2wsL3ijI129t6wf/tHQw8f5j8W2HYcL+ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433718; c=relaxed/simple;
	bh=vIo+7wiTDuBi9wwq7aGjOq9uWsy0qcP5URt9u13O8xI=;
	h=Date:Message-ID:From:To:Cc:Subject; b=AISr2GhN2YfFI+2Ee7deVq/vHuMP/xAaR9COy+aLGj/KYOxh/nBrKMNQXjuTEZJbvRx1hloykByPN0zJ+xwPRbSVTkiF6SA0dmLWzXtl9gACjZ4x5/eX0NPkOKcDZgRveXdbmkYYZmqNxUGsylDM+zuZ9b54epbuwStMycVKv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mb9sI25B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb9sI25B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47750C19421;
	Fri, 13 Mar 2026 20:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773433718;
	bh=vIo+7wiTDuBi9wwq7aGjOq9uWsy0qcP5URt9u13O8xI=;
	h=Date:From:To:Cc:Subject:From;
	b=mb9sI25B1KTuiJeZBVA6T6iFnogFbA/pPXS7rUvHVJFoswj1Vfa6H+RIhiZVHXLLV
	 xuq69Lyk6qG97BKWU3xa34J9BQkptx6PhtRwqP/kgnNPkOKjM7MKIw6xC7aHUI38X+
	 0530PJVthqpgqW030ku15d40MewqwrnYQJRmC0JWQGsZT65NUPGyLcfZ1yS/pT2R08
	 Ewfz0U0K+LDIn+QDOaS7al8Ssg4Lz2LG4PTYY74bbiXKkznlbGqe19hUTPH84F/iWj
	 4E2AqaQXD4Qeh6LQsILP6P88guJxed/r40uO2iO/Bf520BkJySsQ7qcV4dpfZKh1RA
	 iRXZ/kvYpbmdg==
Date: Fri, 13 Mar 2026 10:28:37 -1000
Message-ID: <00374b06f5f22a6c7af1edd5652bcc60@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.0-rc3
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The following changes since commit 0031c06807cfa8aa51a759ff8aa09e1aa48149af:

  Merge tag 'cgroup-for-7.0-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2026-03-03 14:25:18 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-rc3-fixes

for you to fetch changes up to 2fcfe5951eb2e8440fc5e1dd6ea977336ff83a1d:

  sched_ext: Use WRITE_ONCE() for the write side of scx_enable helper pointer (2026-03-09 06:08:26 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.0-rc3

- Fix data races flagged by KCSAN: add missing READ_ONCE()/WRITE_ONCE()
  annotations for lock-free accesses to module parameters and dsq->seq.

- Fix silent truncation of upper 32 enqueue flags (SCX_ENQ_PREEMPT and
  above) when passed through the int sched_class interface.

- Documentation updates: scheduling class precedence, task ownership
  state machine, example scheduler descriptions, config list cleanup.

- Selftest fix for format specifier and buffer length in
  file_write_long().

----------------------------------------------------------------
Andrea Righi (1):
      sched_ext: Document task ownership state machine

Cheng-Yang Chou (2):
      sched_ext/selftests: Fix format specifier and buffer length in file_write_long()
      sched_ext: Documentation: Update sched-ext.rst

Christian Loehle (1):
      sched_ext: Documentation: Mention scheduling class precedence

David Carlier (1):
      sched_ext: Use READ_ONCE() for scx_slice_bypass_us in scx_bypass()

Tejun Heo (1):
      sched_ext: Fix enqueue_task_scx() truncation of upper enqueue flags

zhidao su (3):
      sched_ext: Use WRITE_ONCE() for the write side of dsq->seq update
      sched_ext: Use READ_ONCE() for lock-free reads of module param variables
      sched_ext: Use WRITE_ONCE() for the write side of scx_enable helper pointer

 Documentation/scheduler/sched-ext.rst    |  30 +++++++-
 kernel/sched/ext.c                       |  22 +++---
 kernel/sched/ext_internal.h              | 114 ++++++++++++++++++++++++++-----
 tools/testing/selftests/sched_ext/util.c |   4 +-
 4 files changed, 138 insertions(+), 32 deletions(-)

Thanks.

--
tejun
