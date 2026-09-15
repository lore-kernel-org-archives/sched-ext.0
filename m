Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8944189C3;
	Tue, 15 Sep 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789497617; cv=none; b=HnLjEi+/p0HJhfdXH39nsZnOVGNf8SgmKvPn9ngp1BPJZf9vuj7RlQi5ZH6dOfsP0SQYx16hx9yAZUIxLMAFDYJFOnmM6z0O5grYtvN0cLnv3rzKzbVR1BoqX+od4fQ2Mi0+0pDqQ8D7+1rWApfd5jM40gFzti3QXKT8tR5986o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789497617; c=relaxed/simple;
	bh=c6mfU+sOuiO5rL2mGLrsnIWQBc4pM+qhMVV13HCgHOU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=VycBO2ZsFBMK5tVtN4QpXb/aJJ8VSkVQNqsCzV1gc7EhjZT6AVtiE837lxMU7UpyRak2kqzHJhYoKE6lBKIpcusjFSYiF94lzXL8NIzbeS6KNTxkovMwAEafOxrktdmwUx35tAxrdSQhd4/vM0VnvzhQr6ldn5xD28UdinJZqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8juqj3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8juqj3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217DF1F00893;
	Tue, 15 Sep 2026 18:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789497616;
	bh=bAZJlaWUaIC9ATqe/uzoAUFcM0qeIxwjJqAiIphRJkw=;
	h=Date:From:To:Cc:Subject;
	b=I8juqj3q3istWJHE2gshfIIcR62DVFV+pVozPW+qGfGqxD78izbGAiGSSuyXtlxJ/
	 8KNQJo282icE6u9UjVbTS420k/Xb5QJLhq84xePohyJfrE3MFvL/pXb/FbhfdzLRgL
	 5a+Q3Qvlj926iJqHouRjeocobc7g2kHJ2cTkiF7L2d28hG/Bxo8whc/wcSxXchvc0g
	 YkaTbnC4UAzqfeHdMH10kO58FoJ8/ZqICxGDXXAL6XfyWBIjEIGS/qAixXAkhECpaz
	 MzyxR4VA+WdjBjZO0L4M/LAi2qUKornskw+ee9T4bx3na9n0Tpr6wSzhV/6hYNX9Mb
	 Jdo/80HSg9P+w==
Date: Tue, 15 Sep 2026 08:40:15 -1000
Message-ID: <77a248741e07bbe690582f3c31442b7f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.3-rc3
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The following changes since commit 068e5a0bc57e57d24cbf38def29cc5fb4db9a0df:

  sched_ext: Fix missing @slice and @vtime descriptions in finish_dispatch() kernel-doc (2026-08-31 07:28:04 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc3-fixes

for you to fetch changes up to a9e3760b0838299649c0d57cca44daaf40ba3c33:

  sched_ext: Maintain an online cid mask in the scheduler arena (2026-09-15 06:57:20 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.3-rc3

- An error raised by a BPF program before the scheduler finished enabling
  was consumed by the disable path's pre-enable shortcut, leaving a
  running scheduler that couldn't be disabled and was later freed while
  in use.

- Two compat kfuncs dereferenced a NULL scheduler when handed an exited
  or idle task, oopsing the kernel.

- Keep-running decisions in the dispatch path used the root scheduler's
  flags for tasks belonging to a sub-scheduler, causing warnings and
  stalls.

- Schedulers with their own CPU ID mapping had no way to learn which IDs
  are online. Add a kernel-maintained online mask to plug the hole.

- Cgroup idle state: the initial cpu.idle state wasn't passed on cgroup
  init and same-value rewrites delivered spurious callbacks.

- Example scheduler fixes for a reenqueue loop on attach, placements on
  CPUs without effective grants, stalled partition work and stale idle
  tracking.

----------------------------------------------------------------
Tao Cui (2):
      sched_ext: Pass the initial cpu.idle state in scx_cgroup_init_args
      sched_ext: Don't deliver duplicate ops.cgroup_set_idle() for same value

Tejun Heo (7):
      sched_ext: Rename sch to root_sch in dispatch_one()
      sched_ext: Use @prev's scheduler for the keep decisions in dispatch_one()
      sched_ext: scx_qmap: Do not add IMMED to rescue inserts
      sched_ext: scx_qmap: Place only on cids whose caps are in effect
      sched_ext: scx_qmap: Fix pending partition work handoff
      sched_ext: scx_qmap: Restore unused idle claims from ops.dispatch()
      sched_ext: Maintain an online cid mask in the scheduler arena

Wanwu Li (1):
      sched_ext: Fix NULL sched deref in kfunc sub-sched error paths

fangqiurong (1):
      sched_ext: Close the pre-enable ops error claim window

 kernel/sched/ext/ext.c                   | 142 +++++++++++++++++++++------
 kernel/sched/ext/idle.c                  |  11 ++-
 kernel/sched/ext/internal.h              |  12 ++-
 kernel/sched/ext/sub.c                   |  12 ++-
 tools/sched_ext/include/scx/common.bpf.h |   1 +
 tools/sched_ext/scx_qmap.bpf.c           | 162 +++++++++++++++++++++----------
 tools/sched_ext/scx_qmap.h               |   3 +
 7 files changed, 254 insertions(+), 89 deletions(-)

--
tejun
