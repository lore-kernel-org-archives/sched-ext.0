Received: from mta0.migadu.com (out-238.mta0.migadu.com [91.218.175.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231B43B6FD
	for <sched-ext@lists.linux.dev>; Thu,  8 Oct 2026 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448632; cv=none; b=JF/FAq8DLQaHrm4KuGKVUygmFZydaWa3Bx/7Lvx2G4zPlxsQOaVqzaqkO49KHuY/rGG9uBnKuZX6BgvsQnMbsv/TiT0RONJcoShGBtSWIylsYl16gIochTSDvIXNBIPO7FHCGOmgkymdoFHoFyCZKt1yW9pU0SW2GPdxOcUtR74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448632; c=relaxed/simple;
	bh=DHTTVgODp6yUSc1x8tQK6NVV9QMxY64le1uUbe0521I=;
	h=Message-ID:Date:MIME-Version:Cc:To:From:Subject:Content-Type; b=Zstr97KUANeX7tmSX+uwLgRP6Krj6pxvA/wo55ObxSybLfnysvv3erhY/de5n2Kudij7Bv6MyZYdrU/lwWDwhcLyGAvVVTe860Wrg2VgAN0q7BZ6aotUGrSFONFwdkEgp5oaVtGTtJVDmVNZiEBGwOt1GDrdhJV4uqyYaYYyVeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OX/vYd5h; arc=none smtp.client-ip=91.218.175.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OX/vYd5h"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=DHTTVgODp6yUSc1x8tQK6NVV9QMxY64le1uUbe0521I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791448628; v=1; x=1792053428;
 b=OX/vYd5h0ooBZZOaiUp+VToYIl/E4129Vncp8pOgJe7oAEl93J8kHLkdQK+zrmdELhHYRLl3
 V3H8v4BZxV3INFC8ofw6/4fV1VenUpeX4gCi4NCWcT1d7OWzLnyLR/7MMn88HyB/2RjY5VDCAgy
 1Ii1po/OWY+jdBFNy01OmgIE=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 96be384c8d6a9df7;
	Thu, 08 Oct 2026 08:36:58 +0000
X-Mizu-Trace-ID: 96be384c8d6a9df7
X-Migadu-Flow: FLOW_OUT
Message-ID: <163e2397-0e3e-4cc0-842b-0d36598d13d7@linux.dev>
Date: Thu, 8 Oct 2026 16:36:49 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, David Vernet <void@manifault.com>,
 sched-ext@lists.linux.dev, Andrea Righi <arighi@nvidia.com>,
 linux-kernel@vger.kernel.org, Changwoo Min <changwoo@igalia.com>
To: Tejun Heo <tj@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
Subject: [REPORT] sched_ext: sub-scheduler tasks are severely under-scheduled
 vs root-owned tasks
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Tejun,

During recent testing of the sub-scheduler attach flow, I hit what
looks like a dispatch starvation for claimed tasks and want to check
whether it's a known limitation of the sub-sched dispatch model before
digging further.

Setup:

A kvm guest (4 vCPUs, HZ=1000) running a sched_ext/for-7.4 based tree
with the caps-clear patch applied. A pair of minimal cid-form test
schedulers: a parent that grants SCX_CAP_PERF | SCX_CAP_ENQ_IMMED over
a cgroup to a child, and the child writing cpuperf target 1 from
ops.tick(). A busy-loop task (`taskset 1 sh -c 'while :; do :; done'`)
is placed in the child's cgroup (pinned to cpu0), and
rq->scx.cpuperf_target plus per-task CPU time are sampled every second.

Two attach orders are tested:
(a) the busy-loop task is moved into the cgroup before the child
    attaches;
(b) the task is moved in after the child attaches.

Observation:

Order (a), 8 rounds: the child claims the task in every round
(verified: the enable walk's handover fires, p->scx.sched == child),
but the task then runs at ~0.3% duty cycle - it accumulates 0 or
~20-27 ticks per 10s window (one SCX_SLICE_DFL slice) while an
identical task owned by the parent runs at ~100% (1000 ticks/s).

Order (b), 8 rounds: the child claims the task via the migration path
and the task runs normally (no starvation observed in 16 rounds across
two parent-load conditions).

Based on the current test data, the disparity is ~300x: root-owned
tasks run at full duty while child-owned tasks get one slice and then
starve. The starvation is silent: attach succeeds, the grant succeeds,
the task's cgroup membership is correct - there is no error, warning,
or counter that indicates anything is wrong.

Probes and exclusions:

- ops.dispatch() for the child's cid is never invoked: a counter
  bumped in ops.dispatch() when cid == 0 stays 0 across entire runs,
  including rounds where the task is starved.
- ops.tick() for the child fires only when the task actually runs
  (the tick count matches the starved duty cycle).
- The parent's ops.dispatch() delegation via
  scx_bpf_sub_dispatch(cgroup_id) does not change the behavior.
- An explicit scx_bpf_kick_cid() on the task's cid in ops.enqueue()
  does not change the behavior.
- The enable walk's claim is verified: pass 1 (init) and pass 2
  (handover) both process the task, and a post-handover ownership
  check (scx_task_on_sched()) passes.
- Adding a root-owned busy task on another CPU raises the failure rate
  from ~25% to ~100%, which suggests the claimed task only gets to run
  when some unrelated event runs balance on its CPU.

This is independent of the caps-clear patch (it reproduces with and
without it). The root cause is likely in the sub-sched attach->dispatch
path itself, so any sub-scheduler deployment would be affected.

Questions:

1. Is this a known gap in the sub-sched dispatch model - claimed tasks
   on idle CPUs waiting for a delegation that only happens when the
   parent's dispatch runs for that CPU?
2. Is the intended pattern for parents to kick CPUs on the child's
   behalf (scx_bpf_kick_cid() after grant/claim), or should the core
   route the balance to the child?

The repro is deterministic (8/8 rounds with the starvation in order
(a) under root-side load).

Thanks.
--
Tao
