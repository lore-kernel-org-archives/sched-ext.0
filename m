Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA49E175A8F;
	Fri, 13 Mar 2026 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401475; cv=none; b=ePnpQOvE4Jz12mukKHiQABWaJGTKSqLnGWKdsomgU64Ar1QdRWFnJIjp0XLqFzU9fsuCUQDih10bvO0O8yTNnTzQRZ1dcG1KdQ+faDBG6AOQoO2piXjRoDjawf+lv8xqKJ2YDmQz5ooLmvhZzbkU4CxuZs8h6YgLuDURFZVy5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401475; c=relaxed/simple;
	bh=FAkj7/ifGM8MQPYVpv6zqPOxS9ypWKJDMjEDAfNdTcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZEfZNdyoEn1MNj6Dyg03HWtzDtnNz2NnhS3osw3moUgCeIe233upqoutaL/MohXP9zABTVIVrGTMswg2fIuecjdFaIKhqn5WN4XLuYE5FDUh9H2NhB/qPrGrZJ8r2ALujYBl2DcOwRIul6l4YYU76KgsQwr3gBzqw1pilGWMqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+OubNmy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+OubNmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E30BC19421;
	Fri, 13 Mar 2026 11:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773401475;
	bh=FAkj7/ifGM8MQPYVpv6zqPOxS9ypWKJDMjEDAfNdTcM=;
	h=From:To:Cc:Subject:Date:From;
	b=a+OubNmyk2y7fw34HUPYymyqb7glEHQFQwJRoVBv+FWCOCaBlC4Sk8tc2tYDIrUSL
	 9XRiysDUKdfStmy+hOhJd+VAxLZbP3u7jizpst/DusIOUZOAwew9r6ewa9QAlDJtvW
	 FgNg3qysjdIqmW0lsu/xrN2vJUA5DrWkXIyEBBbdQPcI0KAeMrC0mORSIsOn10eo7b
	 WQhe4bL3Q6GP47bEDmHGteRIVeHV8grtwuFEOQ59taiyjHxAB0knzl9jkP83HMMsG9
	 MzoX37frrvJeWyk9HA/5P0dd3d3GZbRLGtHVapzMWQOWsUKxO0z2qwpesQqE0TKmRv
	 CEtlKKhVItr4A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.1] sched_ext: Implement SCX_ENQ_IMMED
Date: Fri, 13 Mar 2026 01:31:08 -1000
Message-ID: <20260313113114.1591010-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Currently, BPF schedulers that want to ensure tasks don't linger on local
DSQs behind other tasks or on CPUs taken by higher-priority scheduling
classes must resort to hooking the sched_switch tracepoint or implementing
the now-deprecated ops.cpu_acquire/release(). Both approaches are cumbersome
and partial - sched_switch doesn't handle cases where a local DSQ ends up
with multiple tasks queued, which can be difficult to control perfectly.
cpu_release() is even more limited, missing cases like a higher-priority
task waking up while an idle CPU is waking up to an SCX task. Neither can
atomically determine whether a CPU is truly available at the moment of
dispatch.

SCX_ENQ_IMMED replaces these with a single dispatch flag that provides a
kernel-enforced guarantee: a task dispatched with IMMED either gets on the
CPU immediately, or gets reenqueued back to the BPF scheduler. It will never
linger on a local DSQ behind other tasks or be silently put back after
preemption. This gives BPF schedulers comprehensive latency control directly
in the dispatch path.

The protection is persistent - it survives SAVE/RESTORE cycles, slice
extensions and higher-priority class preemptions. If an IMMED task is
preempted while running, it gets reenqueued through ops.enqueue() with
SCX_TASK_REENQ_PREEMPTED instead of silently placed back on the local DSQ.

This also enables opportunistic CPU sharing across sub-schedulers. Without
IMMED, a sub-scheduler can stuff the local DSQ of a shared CPU, making it
difficult for others to use. With IMMED, tasks only stay on a CPU when they
can actually run, keeping CPUs available for other schedulers.

Patches 1-2 are prep refactoring. Patch 3 implements SCX_ENQ_IMMED. Patches
4-5 plumb enq_flags through the consume and move_to_local paths so IMMED
works on those paths too. Patch 6 adds SCX_OPS_ALWAYS_ENQ_IMMED.

v2: - Split prep patches out of main IMMED patch (#1, #2).
    - Rewrite is_curr_done() as rq_is_open() using rq->next_class and
      implement wakeup_preempt_scx() for complete higher-class preemption
      coverage (#3).
    - Track IMMED persistently in p->scx.flags and reenqueue
      preempted-while-running tasks through ops.enqueue() (#3).
    - Drop "disallow setting slice to zero" patch - no longer needed with
      rq_is_open() approach.
    - Plumb enq_flags through consume and move_to_local paths (#4, #5).
    - Cover scx_bpf_dsq_move_to_local() in OPS_ALWAYS_IMMED (#6).
    - Remove obsolete sched_switch tracepoint and cpu_release handlers
      from scx_qmap, add IMMED stress test (#6) (Andrea Righi).

v1: https://lore.kernel.org/r/20260307002817.1298341-1-tj@kernel.org

Based on sched_ext/for-7.1 (bd377af09701).

 0001-sched_ext-Split-task_should_reenq-into-local-and-use.patch
 0002-sched_ext-Add-scx_vet_enq_flags-and-plumb-dsq_id-int.patch
 0003-sched_ext-Implement-SCX_ENQ_IMMED.patch
 0004-sched_ext-Plumb-enq_flags-through-the-consume-path.patch
 0005-sched_ext-Add-enq_flags-to-scx_bpf_dsq_move_to_local.patch
 0006-sched_ext-Add-SCX_OPS_ALWAYS_ENQ_IMMED-ops-flag.patch

Git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-enq-immed-v2

 include/linux/sched/ext.h                |   5 +
 kernel/sched/ext.c                       | 350 +++++++++++++++++++++++++++----
 kernel/sched/ext_internal.h              |  56 ++++-
 kernel/sched/sched.h                     |   2 +
 tools/sched_ext/include/scx/compat.bpf.h |  20 +-
 tools/sched_ext/include/scx/compat.h     |   1 +
 tools/sched_ext/scx_central.bpf.c        |   4 +-
 tools/sched_ext/scx_cpu0.bpf.c           |   2 +-
 tools/sched_ext/scx_flatcg.bpf.c         |   6 +-
 tools/sched_ext/scx_qmap.bpf.c           |  70 +++----
 tools/sched_ext/scx_qmap.c               |  13 +-
 tools/sched_ext/scx_sdt.bpf.c            |   2 +-
 tools/sched_ext/scx_simple.bpf.c         |   2 +-
 13 files changed, 435 insertions(+), 98 deletions(-)

--
tejun
