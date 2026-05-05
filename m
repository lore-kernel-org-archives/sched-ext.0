Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0815FA81;
	Tue,  5 May 2026 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018737; cv=none; b=SSC+sfcCn/6xnZDhxDzUr8UIZtReng16FytvNZuwdIhH7YBZSY/PJj1sQ1Lzl4T2thy9ij1D2tTdibpVJTouQg9/iAnU6SUy9A8Jl/HRpEXgsVM27RlH/v1M50JcJRV6mxHSJe0r+nOpXJE97gRUkYUgzPabUCD0IJZzN7mM9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018737; c=relaxed/simple;
	bh=fK6gxBNCui+BmvzweS85uhFYLVGOfdAJCyOt+PGbWKk=;
	h=Date:Message-ID:From:To:Cc:Subject; b=io/rG3ytQMm8Y03RLaCV7L4CzeHjzgD/TWglo0LJn9N6WFyUE15suoDwRTIrRP/U5x3Ji/J+hgKUnaW9bKvXJPJZze4nCLw80K6eowh458ELSr/MgW/u1rL0IdkvRRQPZWmD14EoVCsHmFiWRprkukOrXZQgBzwM6ZWxSrhoUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bblcNoif; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bblcNoif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC88C2BCC9;
	Tue,  5 May 2026 22:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778018737;
	bh=fK6gxBNCui+BmvzweS85uhFYLVGOfdAJCyOt+PGbWKk=;
	h=Date:From:To:Cc:Subject:From;
	b=bblcNoifmwoM2FfJtNg/xQJcC8mWO0gWWl5k41x2m9aK6mirNOcJuSa/EFpAMxA0X
	 LPn3jxHUpbJurTTIr65uA5Y/9V1l1CGVJ81vOJrDX18lbqQGT7tas+JP+xkOh1u/RM
	 LTddZw85ou01IVeQiJX9LWvXAuUiBcwcM3jHFI0NBNm6293p/7Hrpw/w5Lu7awqex2
	 DYdUWHPCrM/971DRUJSHs3z6ExL/dky2+oML7QbL/aP5D4RlX5mg3IoDxlS6VPl7da
	 0/leeWlgQ8dHg/uPqDx2tVIdIp6Y3qG2opdNpdD1VdIbaQky+3fGlETJkJjReHvayl
	 UtGQdRExu0wPQ==
Date: Tue, 05 May 2026 12:05:36 -1000
Message-ID: <0b691f25de6be993a3496962f91fa212@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [GIT PULL] sched_ext: Fixes for v7.1-rc2
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The following changes since commit d99f7a32f09dccbe396187370ec1a74a31b73d7e:

  sched_ext: Fix scx_flush_disable_work() UAF race (2026-04-28 07:40:03 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc2-fixes

for you to fetch changes up to b34c82777a2c0648ee053595f4b290fd5249b093:

  sched_ext: idle: Recheck prev_cpu after narrowing allowed mask (2026-05-04 11:01:04 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.1-rc2

- Fix idle CPU selection returning prev_cpu outside the task's cpus_ptr
  when the BPF caller's allowed mask was wider. Stable backport.

- Two opposite-direction gaps in scx_task_iter's cgroup-scoped mode
  versus the global mode:

  - Tasks past exit_signals() are filtered by the cgroup walk but kept by
    global. Sub-scheduler enable abort leaked __scx_init_task() state.
    Add a CSS_TASK_ITER_WITH_DEAD flag to cgroup's task iterator
    (scx_task_iter is its only user) and use it.

  - Tasks past sched_ext_dead() are still returned, tripping
    WARN_ON_ONCE() in callers or making them touch torn-down state. Mark
    and skip under the per-task rq lock.

----------------------------------------------------------------
David Carlier (1):
      sched_ext: idle: Recheck prev_cpu after narrowing allowed mask

Tejun Heo (2):
      cgroup, sched_ext: Include exiting tasks in cgroup iter
      sched_ext: Skip past-sched_ext_dead() tasks in scx_task_iter_next_locked()

 include/linux/cgroup.h    |  1 +
 include/linux/sched/ext.h |  1 +
 kernel/cgroup/cgroup.c    |  8 +++++---
 kernel/sched/ext.c        | 39 +++++++++++++++++++++++++++++----------
 kernel/sched/ext_idle.c   | 12 ++++++------
 5 files changed, 42 insertions(+), 19 deletions(-)

Thanks.

--
tejun
