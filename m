Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733094;
	b=Eb6FWPlq0P2gxciyq41uf94O6amAJkoLa5O/W0gtVUL/eybQB915ztliIUEoFtjjnd4x
	 3Lw7WjQnwIP0rl0R93i0Z/8Ei8P7mCQdYNJwHikQmRJJeoRsKLgy6Xi33HsGVmQ8pIxFh
	 YIbWSU2zCRrnkPFAvOWZFIiU4siE4HNgREHQHr1/lPrA3ycPzOGWiur2Sq4GTGz2rQPzO
	 1R38FRHiCMBdMZ5u750+pVfxOiHDMSBz5LBjlko3DKv0Fj2M8PtXYaQ2W6vz32gCDMjgI
	 achR8WdVSjQrhAKfFTWUme40w0WdhFSj1BilEz+P1vrPN0npt1mI072Oj5e4c3HHvMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733094;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YnAljd2ySNsbiBHjSMmXM2oDmBbNkNQ4sGxao1JM8Z8=;
	b=y+SfJ78sdZ5zL5yDC0xrupNuTOlxGs6W6nYossThM7I/fhRgHZIshsgGDdQ1fR4Zqc49
	 dLg26SErV/JBfJLXe7Z57YeiSf7HYC5Bgv6Qv7l+fyRWQS73HuhVr04gTqCfesM/yfSZ1
	 INht905mO8kTIIAY1FIMuGJX1/V8g4fGKUi1xu8UQsK1/p89JCK6dLPe8UxqKGb+RDYmy
	 HKZF0u2hjMlCDk63+oTNKhEXjEv4Oc8oFwpeQOk+HBU3OhkpYarq1D3acdOOqM9ukdI1Q
	 fIsf3Cf7uya2HcuUDfv+4cVwMeg+DTujINL2HJCH4OCfM/XPcOh5xg6ldQQTfbFI6dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKjgMtqB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58504606A319;
	Fri, 23 Oct 2026 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKjgMtqB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDAD1F01825;
	Fri, 23 Oct 2026 05:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733093;
	bh=YnAljd2ySNsbiBHjSMmXM2oDmBbNkNQ4sGxao1JM8Z8=;
	h=From:To:Cc:Subject:Date;
	b=iKjgMtqBt9AKaNHUyzkkISY8EUhJQu42/YnGqI7n2RK39k4YOHmVMKn4mqeJXo6Kd
	 KOwsSw9X2qgCRts9YZQqTqJnhUFqWayYt2pyoaZQi8eSajCp6iYCgrrkxM43epzm7D
	 f70SQXLNAkpbt9upGzKMZzg2s/Cf+CGk4sV8UsoBxmgdbSxqTtwq9JrcUT6YVmf0NR
	 9ldfyWAjeT/570uHOLgYty4myn9jqD4pc6XfcbwYftuAf8Jn9aiDdA24NBQHEzcCYh
	 MsBSjotFiLPbQuuvn+9cwa4zY6pg6IBUwMKyQCKeGZ4i/EmYBJKCWvSmW64CMm5JSs
	 X6GK4KgM6I+/A==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.4] sched_ext: Fix bypassed sub-scheduler tasks stalling when the host lacks caps
Date: Thu, 22 Oct 2026 19:24:37 -1000
Message-ID: <20261023052452.2889061-1-tj@kernel.org>
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

This patchset contains the following 15 patches.

 0001 sched_ext: Pack scx_ent_flags' multi-bit fields at the top
 0002 sched_ext: Clear holding_cpu where the claim is confirmed
 0003 sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
 0004 sched_ext: Move refill_task_slice_dfl() below apply_slice_vtime()
 0005 sched_ext: Restore a rescuee's slice after ops.stopping()
 0006 sched_ext: Fix a cpu idling with a runnable rescuee
 0007 sched_ext: Mark the rescue grant as a kernel slice with SCX_TASK_KERNEL_SLICE
 0008 sched_ext: Refuse extending a kernel slice
 0009 sched_ext: Fix a cpu idling after put_prev_task_scx() queues its task on the local DSQ
 0010 sched_ext: Expire prev's slice in dispatch_one() under bypass
 0011 sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE
 0012 sched_ext: Fix the bypass load balancer stranding tasks on cpus where the host lacks SCX_CAP_BASE
 0013 sched_ext: Factor out bypass_lb_move() and insert with the donor DSQ unlocked
 0014 sched_ext: Let the bypass load balancer move tasks homed on other cpus
 0015 sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_BASE

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
- 0010 expires a bypassing prev's slice in dispatch_one() before its keep
  test instead of refusing to keep it, so a bypassed rescuee keeps the cpu
  on its kernel slice and the post-dispatch test can't keep a declined
  prev.
- 0011 sends a bypassed task to rescue when the host lacks BASE on its cpu.
- 0012-0015 make the bypass load balancer cap-aware: capacity and donees
  from BASE cpus only, a factored-out move that inserts with the donor DSQ
  unlocked, moves of tasks homed on other cpus, and the drain of a cpu's
  bypass DSQ when the host loses BASE there.

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git bypass-caps-v2

diffstat follows. Thanks.

 include/linux/sched/ext.h                       |  22 +-
 kernel/sched/ext/ext.c                          | 527 +++++++++++++++++-------
 kernel/sched/ext/inlines.h                      |  15 +-
 kernel/sched/ext/internal.h                     |  12 +-
 kernel/sched/ext/sub.c                          |  57 ++-
 kernel/sched/ext/sub.h                          |  16 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
 tools/sched_ext/include/scx/enums_abi.autogen.h |  29 +-
 8 files changed, 489 insertions(+), 190 deletions(-)

--
tejun
