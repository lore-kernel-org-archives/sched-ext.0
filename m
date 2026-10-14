Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE74A0136;
	Wed, 14 Oct 2026 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017195; cv=none; b=ZtG8WFB4CBSYp+fVKb0KOjv0zmVoGGl2JvYWNv0HDAlxIIVe6/486w/TZ2h/fwvpEWLqz8pV6dsPG58LYaV3e4764bvCvDuo4mG/BQXUV2LjyXIzE6XunuiPquZXhkHUo1rf0KIe2n1pmejOkStHnaP1mxFa9YArrtA6DfGFTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017195; c=relaxed/simple;
	bh=rrRsBKyfT3t2sXH5rt7FE1kUDHXXWt+tXIhr4BEKfOs=;
	h=Date:Message-ID:From:To:Cc:Subject; b=dgbWMmkCLhkLwOCl0WjI79o2n095X6uKY5eohC3muEJ/R25d795W7ScAnf+o4l7r0mbpqHPPbzPnUou7pVS7DXFnuwDUIiRJ7UeEegRRRFvFxUPu0Z2dw9gbGLe1Dyf29ES/82UTQQXo9NHP4IL4iuCPYTJXIVNS8GxP8SR3YtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW1/c2px; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW1/c2px"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592831F000C4;
	Wed, 14 Oct 2026 22:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792017194;
	bh=GoSzVfZk9vh8sT14N1gEpgTZZnt6mmWx5fqr1y9AsvQ=;
	h=Date:From:To:Cc:Subject;
	b=SW1/c2pxKgF2Hz3QoXpxqvBrUDmc+L5a6Qn5NcVvnCfWB/oG+i6mPe6NuQhC5Yrz1
	 L0p/bB5bMIaDkyECyhy0qSNrtCgnyiuTqcAu0V6fWH3zYvm6ncfPdbKXxUsFAE0jOF
	 Pm2Ldxe5dtTLRw2hG/lX5khx9Ep+0GEMkUyJl/y8qnTc34vQLWwO7JF8FEgkH7FcwA
	 +xH3zqhkdL6YkQlDjx315ccmUybCbZpQtKX7fw/ryGqfhQ+Lz8vAT4hHKEaK3LEdx7
	 gwKIaBmHQi/DMvnhh5dMrfiKY3AudSwSZtZ//OXTcawX6ACBpPkbD7CqAzaxToziyn
	 oyRFKTedCZLkg==
Date: Wed, 14 Oct 2026 12:33:13 -1000
Message-ID: <3d82bc8d063a217f2d6583d285feca4b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.3-rc7
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The following changes since commit e6ac89b8b1c12e9104df45a14a26e2dfa96ded06:

  sched_ext: Generate qseq from a per-task counter (2026-10-03 13:23:31 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc7-fixes

for you to fetch changes up to 2935062be77113c1c4565ca9d0c72180449aafee:

  sched_ext: Wait for SCX_OPSS_DISPATCHING before moving tasks off DSQs (2026-10-13 09:55:19 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.3-rc7

- A task that skipped the BPF scheduler on its way back to its CPU's local
  queue could stall there until the watchdog fired, as the CPU had already
  decided to go idle.

- Use-after-free of a destroyed user dispatch queue by a deferred re-enqueue
  request.

- A task could be moved off a dispatch queue while the dispatching CPU was
  still running ops.dequeue() on it.

- Bypass mode mishandled a sub-scheduler bypass overlapping an ancestor's,
  as across a system suspend. Descendants could leave bypass mid-teardown
  and tasks could be stranded on bypass queues.

- The idle CPU selection helper could return a CPU outside the allowed CPUs
  of a pinned or migration-disabled task.

----------------------------------------------------------------
Hui Su (1):
      sched_ext: idle: Respect task affinity in restricted CPU selection

Kuba Piecuch (2):
      sched_ext: Rename scx_reenq_wait_dispatching() to scx_wait_dispatching()
      sched_ext: Wait for SCX_OPSS_DISPATCHING before moving tasks off DSQs

Tejun Heo (4):
      sched_ext: Fix stall when a task enqueued with SCX_ENQ_LAST lands back on its CPU's local DSQ
      sched_ext: Fix use-after-free of a destroyed user DSQ by a deferred reenqueue
      sched_ext: Propagate every bypass depth change to the descendants
      sched_ext: Fix the bypass dispatch claim for schedulers bypassed by an ancestor

 kernel/sched/ext/ext.c      | 123 +++++++++++++++++++++++++++++++-------------
 kernel/sched/ext/idle.c     |  50 ++++++++++++++----
 kernel/sched/ext/internal.h |   7 +--
 kernel/sched/ext/sub.c      |   2 +-
 4 files changed, 132 insertions(+), 50 deletions(-)

-- 
tejun
