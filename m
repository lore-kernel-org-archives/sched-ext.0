Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778169;
	b=yu+1jXxzggdKlqDOJoJJsf8L9XoTDeMdwdCJF+dq4mj5fxvyewKUE0VgGDdCRtrLFKf4
	 4JXSZBN+Tqy89SroJV86S43duFUjKbe0rhCbW/rg7cbLms5ifervdZUMOLWq6N8kdYxhk
	 vT6D0Bb6tzKvKyjrMBs459EvoCveuewALyJRE786U/SHAWlSG7mPKotm+4hk7tGkInRsF
	 17uOF1ZJ5XyATVGNB2BXW1URRsmQIgCQ4XyzIgDXcSCQlqB0wf32wuRA6JK7/9Rspv0Y6
	 MwHiV8KgVj7ygAIJ+dfgA/a4VnZGTFPhsnzJYzVeEzlGxF/I95Rv4STOZRqClRS7RhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778169;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yKXQJ+AMWdsdLPTDL51p0t7Z7tnNgBJLUEU0GDQLzgU=;
	b=5QfIVlhLPT4MEy6YMGH7eLzQcw9m6luubk1MC7c78Cs5LCjhyAAUH1DqHPTq/vVx2Qy8
	 wyDisEAyyPvAfnr3I8QawQdC6cR1+CAOMm5C9H/bc+iBggVspmajqcPYHf1oFWtt4cihm
	 PIWmA7xSlkQJvBe9nY0jME27SjF9IN0c+Wib879kg4oJTaw35rAn9YBRe0CCuj9za4n27
	 rYbKuvjDyHyAt37oDBMXrH47/8F/rR5QlaU2uM2k1M10hLEukhOyNmAfhuUd6F7eFXL4/
	 kK8RtDeYldxSeazEJP1hxsX5Iy6L4Ugi97VZW9sKmg7KZiR5bsrgG9NbkM+Vi8WWXbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htE0YsSS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91E606A31A;
	Fri, 23 Oct 2026 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htE0YsSS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2110E1F01825;
	Fri, 23 Oct 2026 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778169;
	bh=yKXQJ+AMWdsdLPTDL51p0t7Z7tnNgBJLUEU0GDQLzgU=;
	h=From:To:Cc:Subject:Date;
	b=htE0YsSSqBNQ6D/+6mvDBagMOkhCsTth50iO/k3qcFhqyKk+/DBuRUqH7RAKTLdnD
	 AHMCZLuaEftveqDaWLdSvXz7E23y77u9NAZpWcNdFPMu+9DW9TYwxchaCFouknoukX
	 8w2W47XFM1wPPprErCevfnGmdWr9IvDxyaeoRNTWxvZ75dm8PxLUiOpyQVI5XfMpMM
	 Uul7OzUbHaiWsrsQtnLPBQAV3N7WCHYbeJ57SejsnG/1ghgfT3vFw02EA/RNapF0+n
	 i6RHkz7b0i90Y2tbaEnzSDJ79YcWOVFM5CCHyDMLbDT+NV0no4sj4LY4yTRidFrWHk
	 11zkYW0l6JtFg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v3 sched_ext/for-7.4] sched_ext: Fix bypassed sub-scheduler tasks stalling when the host lacks caps
Date: Fri, 23 Oct 2026 07:55:51 -1000
Message-ID: <20261023175608.4120910-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v3 (uncounted reenqueues under bypass, served time from the charge):
- Add a patch testing bypass before the reenqueue count in
  scx_do_enqueue_task(). A bypassing scheduler's reenqueues are the kernel's
  placements, and counting them could strand a bypassed task and deadlock
  the disable, which relies on bypass keeping every task running (#3,
  sashiko).
- Add a patch counting rescue served time from the charged runtime. The
  rescuee's sum_exec_runtime follows the mutex owner under proxy execution
  while the slice follows the donor, so the two disagreed in both
  directions. scx_rescue_keep() now WARNs and ends the rescue if its restore
  is refused (#6, sashiko).
- With rescue disabled, admit a migration-disabled or migration-pending task
  to the local DSQ on a cpu where the host lacks BASE instead of leaving it
  on the unconsumed bypass DSQ (#13).
- Update descriptions and comments, among them #17's rescue-off and
  zero-interval cases (#4, #7, #9, #10, #11, #16, #17).

v2 (keep a bypassed rescuee in dispatch_one()):
- Add a patch expiring a bypassing prev's slice in dispatch_one() before
  its keep test and dropping the bypass test from it. A bypassed rescuee
  now keeps the cpu on its kernel slice and scx_dispatch_sched()'s
  post-dispatch test no longer keeps a prev that dispatch_one() declined
  (#10, sashiko).
- Cover a rescuee that passes the keep-last test in the dispatch_one()
  comment and description (#6, sashiko).
- Update the descriptions and correct the refusal causes listed in #15
  (#11, #15).

v2: https://lore.kernel.org/r/20261023052452.2889061-1-tj@kernel.org
v1: https://lore.kernel.org/r/20261022213836.2259069-1-tj@kernel.org

A bypassing sub-scheduler's tasks run through the per-cpu bypass DSQs of
its host, the nearest ancestor that is not bypassing. Caps are per cpu, and
a cpu's dispatch descends into a scheduler only where it holds
SCX_CAP_BASE, so a bypass DSQ on a cpu where the host lacks BASE is never
consumed. Bypass placement and the bypass load balancer ignored that. A
bypassed task could be queued or moved onto such a cpu and sit there until
the host regained the cap or the bypass window ended, and a host holding
BASE but not ENQ looped a bypassed task between its bypass DSQ and the
reject drain instead of running it.

The fixes make SCX_CAP_BASE the one cap a bypassed task needs and keep
bypassed tasks off the cpus where the host lacks it. A bypass consume puts
the task on the cpu being dispatched for, to run right away, which is what
BASE grants. Where the host lacks BASE on a task's cpu, the task runs under
rescue at bounded bandwidth instead of waiting for a dispatch that can't
reach it. The bypass load balancer spreads tasks over the cpus where the
host holds BASE only, and when the host loses BASE on a cpu it drains that
cpu's bypass DSQ to the cpus that can still run the tasks, or sends them
home to be placed again.

Running bypassed tasks under rescue leans on the rescue slice harder than
before and exposed gaps there: a cpu could go idle with a runnable rescuee
queued on it, the kernel's own slice writes under bypass served the grant a
tick at a time, and a scheduler could extend the grant past the rescue's
bandwidth. The grant is now a kernel-owned slice that the kernel's slice
housekeeping leaves alone and schedulers can shorten but not extend, and a
cpu no longer idles over a runnable rescuee.

Tested with a three-level hierarchy cycling bypass under pinned spinners,
fork and context-switch storms, with caps revoked under queued tasks. The
balancer's remote move and the drain were exercised, and the holding_cpu
handshake, the cap-revoke placement and the rescue keep were model checked
for small cpu counts.

Based on sched_ext/for-7.4 (1f5dde349ac2).

This patchset contains the following 17 patches.

 0001 sched_ext: Pack scx_ent_flags' multi-bit fields at the top
 0002 sched_ext: Clear holding_cpu where the claim is confirmed
 0003 sched_ext: Fix bypassed tasks stranded by the reenqueue limit
 0004 sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
 0005 sched_ext: Move refill_task_slice_dfl() below apply_slice_vtime()
 0006 sched_ext: Fix rescue served time disagreeing with the slice under proxy execution
 0007 sched_ext: Restore a rescuee's slice after ops.stopping()
 0008 sched_ext: Fix a cpu idling with a runnable rescuee
 0009 sched_ext: Mark the rescue grant as a kernel slice with SCX_TASK_KERNEL_SLICE
 0010 sched_ext: Refuse extending a kernel slice
 0011 sched_ext: Fix a cpu idling after put_prev_task_scx() queues its task on the local DSQ
 0012 sched_ext: Expire prev's slice in dispatch_one() under bypass
 0013 sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE
 0014 sched_ext: Fix the bypass load balancer stranding tasks on cpus where the host lacks SCX_CAP_BASE
 0015 sched_ext: Factor out bypass_lb_move() and insert with the donor DSQ unlocked
 0016 sched_ext: Let the bypass load balancer move tasks homed on other cpus
 0017 sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_BASE

The patches are organized as follows:

- 0001-0002 prepare: pack scx_ent_flags' multi-bit fields at the top so that
  the single-bit flags stay contiguous, and clear holding_cpu where the
  claim is confirmed.
- 0003 keeps a bypassing scheduler's reenqueues out of the reenqueue limit,
  as the kernel places its tasks and a strand under bypass can deadlock the
  disable.
- 0004 consumes bypass DSQs with SCX_ENQ_IMMED, so that a host with BASE but
  not ENQ runs its bypassed tasks instead of looping them.
- 0005-0010 fix the rescue slice handling that bypassed tasks under rescue
  depend on: count served time from the charge, restore the remainder after
  ops.stopping(), keep a cpu from idling with a runnable rescuee, mark the
  grant as a kernel slice that the kernel's slice writes leave alone, and
  refuse extending it.
- 0011 reschedules a cpu after put_prev_task_scx() queues its task on the
  local DSQ through the plain insert too.
- 0012 expires a bypassing prev's slice in dispatch_one() before its keep
  test instead of refusing to keep it, so a bypassed rescuee keeps the cpu
  on its kernel slice and the post-dispatch test can't keep a declined prev.
- 0013 sends a bypassed task to rescue when the host lacks BASE on its cpu.
- 0014-0017 make the bypass load balancer cap-aware: capacity and donees
  from BASE cpus only, a factored-out move that inserts with the donor DSQ
  unlocked, moves of tasks homed on other cpus, and the drain of a cpu's
  bypass DSQ when the host loses BASE there.

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git bypass-caps-v3

diffstat follows. Thanks.

 include/linux/sched/ext.h                       |  22 +-
 kernel/sched/ext/ext.c                          | 575 +++++++++++++++++-------
 kernel/sched/ext/inlines.h                      |  15 +-
 kernel/sched/ext/internal.h                     |  18 +-
 kernel/sched/ext/sub.c                          |  75 ++--
 kernel/sched/ext/sub.h                          |  16 +
 kernel/sched/sched.h                            |   2 +-
 tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
 tools/sched_ext/include/scx/enums_abi.autogen.h |  29 +-
 9 files changed, 541 insertions(+), 212 deletions(-)

--
tejun
