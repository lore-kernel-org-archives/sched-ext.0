Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705118;
	b=VULxZ0468a9aYyHRnWNtrkrS7Q0UFZT+Yd4P4xK1zQ+cwuPeY9m+LZIsF4LsQv2ZwoXC
	 tzv9/RVL25BHgHIReYCvDSoIKmtDK1zNJvr6mTCO4VGWn+OBYqDb/xoGiheoxBVtjDxTL
	 4DarEtlelG/+bOiTNVliPXw3Lr40oCf03ne7QCAo6tcvErPKEZ1xcQE6mUmiH9htR4rph
	 GPxLtCH8SkWRP5erEyKlqJONCJX7GJAsLNgkdY7tcBXldCeb1Gbg9pRRx/6Q97FqlDiFn
	 2gaa+6qmwZKyUlAXKbwzc/kYS2TvDz4LvH/mQcEl6wYjWLQVRvVEnXDyYI3PjcBsI7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n+YjkxMsXC9SlMtlyl+JGAKtKmpwYJYkOLfhktvnxxE=;
	b=Cz8oe+Ie9K/R6xAIfbUjTAAt5j3rYDsKeW0/RLNrkpuT9IXAgXgH/cbRQZ0bU/NaGPpI
	 zokCOwS++9Gnt/JFhiGQQ2dmlMT3ucCIFrMSc3U+40/X0IAGOA3iigfWDEZgVQ9cnzkKu
	 u3Dfs+IOoI2qFep7krjM/LHm6QtR6lADpHk6jpKz3IOZUJuXYBPCIBiNbs4R/98jucJ94
	 6CM+oBVvnf4EPZH7GDEjGs8GZRv7ZYYyPu+MHeqHEVAuay9GXoYJoLMOQ/HupJyoQumuv
	 RKwO+To89+LEVjiOj/8Gc5NNZfEblRs+RW6n9xkfu4bdvUUGHdOKd2M0ZmZyII3/IMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZElVSnH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B67606A31A;
	Thu, 22 Oct 2026 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZElVSnH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8441F01825;
	Thu, 22 Oct 2026 21:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705117;
	bh=n+YjkxMsXC9SlMtlyl+JGAKtKmpwYJYkOLfhktvnxxE=;
	h=From:To:Cc:Subject:Date;
	b=MZElVSnHTfzHt4OpTfMLAlQjib5EjoblP8NjWM/qqRGdUf+t5qgea+7J13aAMJwTk
	 zMIko2sjPGBfmn8ccOi0csqimCHX2fhoDDPyRyJw/k8zBgr48xU2ISHEpvrIa3oRKF
	 g6EzniDpp1ot2sKoedczJW0EXZo35gUAujaBxneL84k0tTdS3cr+xrgPgDSDKvBjgS
	 CMbZnz98Bh2C1DKTzGn26bqJVkPMCTcXrp/H7TDts1SgPkKAHLyWAcVhiv0da0ya53
	 8EoRrmzr34SIhgDRDD8/mcAn83Jlh/sDQC5aEfoFR6DGnTPn1evJmKl9q4dmY43V5u
	 r960/+1RjxrIA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.4] sched_ext: Fix bypassed sub-scheduler tasks stalling when the host lacks caps
Date: Thu, 22 Oct 2026 11:38:22 -1000
Message-ID: <20261022213836.2259069-1-tj@kernel.org>
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

This patchset contains the following 14 patches.

 0001 sched_ext: Pack scx_ent_flags' multi-bit fields at the top
 0002 sched_ext: Clear holding_cpu where the claim is confirmed
 0003 sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
 0004 sched_ext: Move refill_task_slice_dfl() below apply_slice_vtime()
 0005 sched_ext: Restore a rescuee's slice after ops.stopping()
 0006 sched_ext: Fix a cpu idling with a runnable rescuee
 0007 sched_ext: Mark the rescue grant as a kernel slice with SCX_TASK_KERNEL_SLICE
 0008 sched_ext: Refuse extending a kernel slice
 0009 sched_ext: Fix a cpu idling after put_prev_task_scx() queues its task on the local DSQ
 0010 sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE
 0011 sched_ext: Fix the bypass load balancer stranding tasks on cpus where the host lacks SCX_CAP_BASE
 0012 sched_ext: Factor out bypass_lb_move() and insert with the donor DSQ unlocked
 0013 sched_ext: Let the bypass load balancer move tasks homed on other cpus
 0014 sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_BASE

The patches are organized as follows:

- 0001-0002 prepare: pack scx_ent_flags' multi-bit fields at the top so
  that the single-bit flags stay contiguous, and clear holding_cpu where
  the claim is confirmed.
- 0003 consumes bypass DSQs with SCX_ENQ_IMMED, so that a host with BASE
  but not ENQ runs its bypassed tasks instead of looping them.
- 0004-0008 fix the rescue slice handling that bypassed tasks under rescue
  depend on: restore the remainder after ops.stopping(), keep a cpu from
  idling with a runnable rescuee, mark the grant as a kernel slice that
  the kernel's slice writes leave alone, and refuse extending it.
- 0009 reschedules a cpu after put_prev_task_scx() queues its task on the
  local DSQ through the plain insert too.
- 0010 sends a bypassed task to rescue when the host lacks BASE on its cpu.
- 0011-0014 make the bypass load balancer cap-aware: capacity and donees
  from BASE cpus only, a factored-out move that inserts with the donor DSQ
  unlocked, moves of tasks homed on other cpus, and the drain of a cpu's
  bypass DSQ when the host loses BASE there.

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git bypass-caps

diffstat follows. Thanks.

 include/linux/sched/ext.h                       |  22 +-
 kernel/sched/ext/ext.c                          | 487 +++++++++++++++++-------
 kernel/sched/ext/inlines.h                      |  15 +-
 kernel/sched/ext/internal.h                     |  12 +-
 kernel/sched/ext/sub.c                          |  57 ++-
 kernel/sched/ext/sub.h                          |  16 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
 tools/sched_ext/include/scx/enums_abi.autogen.h |  29 +-
 8 files changed, 458 insertions(+), 181 deletions(-)

--
tejun
