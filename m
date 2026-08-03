Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D42D94B5;
	Mon,  3 Aug 2026 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785719608; cv=none; b=dLA6Sv8J45yXIzCMJ42Q/qoV1D02wdRRy3OKCN11GnNfI5z2E7FxII1fww8ehm+mMZZyHFItH625RrC8thwbhMiObxketLKWZCCP6GYVROe5zkxzNcAD7AKGtvpNART94CfH4uOCr5t2Fa3jCMl8USMeVG7Eeh6znY9fevJpIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785719608; c=relaxed/simple;
	bh=Exk1jgoWiWvNM5DAZZsMDIkAOlZgQd9Q21ZcmpQsYuk=;
	h=Date:Message-ID:From:To:Cc:Subject; b=gQDeEYkVeIDm64sTqpzyPWo7+rVj3K1pDTh2Bao+RAhWB3nw+Mall7YrJhOcaHalzAdrTxzrCA6aUO0QvhWPe+2UiAj83ciDISKb4EUC8Pos6dMaZ5XpYqBkIYMZFvprZ72fFXgPERXZeVIMWF3rozjRa2Gnh5wIX5LCo5m7cnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfXZpQDj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfXZpQDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AD31F000E9;
	Mon,  3 Aug 2026 01:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785719607;
	bh=bTs5izIYXVUt3fKZiC7f9EGb4rEDfC9BwjNrhbZx6HU=;
	h=Date:From:To:Cc:Subject;
	b=GfXZpQDjgE7R26taHLqhJgsEZtQHBKESDu95OC1w28xQs9clNjmtpcG4+gRoNCq2d
	 XbcbfTO7g2qEbqgWX/3hvGHT4pgG/SoF8Ijr0BsrVjEP7TxO3RRxmKRk+VIBL06RF7
	 8ea4/dX4ZlYXyYjgwPl9l1WRPoJxmchAwOIRWE5vO691/OznJoG0XOkCA4C/KkWdeO
	 n4BlQBA4dsDjUEDdz/p8hA9rasEYzPxFQjCujR2nczGG1hAZxd9np/urw2fYsf1vga
	 csPoWSgDvduMEA7jbncSJFEH7awIeaw67BuAr0UJiA4e/9df1qUhBa43Q/aUMZ+DdL
	 5LaAT6l5dvouw==
Date: Sun, 02 Aug 2026 15:13:26 -1000
Message-ID: <73f632a36560eddd78a0b82db78e4b8d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.2-rc6
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The following changes since commit 0e2f4ab68a89fad42e0f5a9ff4b740738e7aa1d6:

  sched_ext: Skip ops.set_weight() for disabled tasks (2026-07-10 06:41:28 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2-rc6-fixes

for you to fetch changes up to d4a00d61a5c2c24973175ace5368d1f6acf9bb0a:

  selftests/sched_ext: Handle sleeping task affinity changes in numa test (2026-07-23 07:50:37 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.2-rc6

- More lifecycle fixes for the new sub-scheduler support: a failed enable
  could tear down a never-linked sub-scheduler in a way that races the root
  scheduler's disable and leads to a use-after-free, tasks that were not on
  the ext class could still get the enable callback, and a policy-rejection
  path silently rewrote a running task's scheduling policy instead of
  aborting the scheduler.

- Scheduler enable/disable could deadlock with cgroup removal and a
  concurrent cgroup weight write through kernfs. Fixed by reordering lock
  acquisition.

- Sync wakeups could leave the waker CPU incorrectly marked idle in the
  built-in idle-CPU tracking.

- A selftest fix for sleeping tasks whose CPU affinity changes before
  wakeup.

----------------------------------------------------------------
Kuba Piecuch (2):
      sched_ext: Mark waker CPU busy when selected in WAKE_SYNC case
      selftests/sched_ext: Handle sleeping task affinity changes in numa test

Tejun Heo (4):
      sched_ext: Reject setting disallow from init_task outside the enable path
      sched_ext: Take cgroup_lock() first in scx_cgroup_lock()
      sched_ext: Skip sub-disable teardown for never-linked sub-schedulers
      sched_ext: Don't enable non-ext tasks in the sub-sched task loops

 include/linux/sched/ext.h                    | 10 +++---
 kernel/sched/ext/ext.c                       | 47 ++++++++++++++++++++++------
 kernel/sched/ext/idle.c                      |  4 ++-
 tools/testing/selftests/sched_ext/numa.bpf.c | 13 +++++++-
 4 files changed, 58 insertions(+), 16 deletions(-)

--
tejun
