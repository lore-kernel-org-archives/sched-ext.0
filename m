Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882354E36EA
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778269; cv=none; b=bNmp+iNtdr91F/sIR27MgU3llD5x4ADxi9GxW2nmU+r3l9gl6h21GbF8VJHtxaypqhDcYnHINb7Wkoy5B6RYd5nSHu4mIdhT3ruJCxiOFvHSH+jK8aT/PLf2JPzb1U+TqWVKdvnDBdYmJrjxVeA9MkSpwa0Pnc66OKHJUY/bKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778269; c=relaxed/simple;
	bh=w+DtvmeialJB9x9SRkQEK0OYx1mc4mEYZ03OWytTkIE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lSVg8ew2H8YlvOa3AvvRoV3aT1MR/NCzaMluzb+PrdV2g0AznXQEFJA0l2VZhvxiyTcF6f8AiNRQ1nRtPBntnfQd30Ld6P0e5ojpifGfpEgGkZYVG0kHnVG9WmjCQ3luPzWu8N9ZZQWqUdSTdoBiGB/kul4HR2RxfsvxIgr4k34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YgEE9XZl; arc=none smtp.client-ip=209.85.208.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgEE9XZl"
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6aaff9e86b0so4842621a12.1
        for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790778254; x=1791383054; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfUv3bn823RJxdA8KgRrASglO9ITKlt+SqGbcVInGAg=;
        b=YgEE9XZl2HYIpl1anMXFpLALRf2xDR+GJjJ4oJIttlg6w9TH0CPqvMHbbiXdm0eon/
         p10RM3QF1K6AvK28Bt+FD41IbKTxGExpQcJG1OOjLwn8DTXL+yGdigcSUt3ig2uvicLL
         USfKPqeG1k72kN2Lv+tym7Z8eXbstWiZsn87PbQjsZIq9u8UiDCCrIbrYC9K1FC7DB/J
         tBnBPkcykmb0TmYFKkDgDHM+otvYsz6cEWZcegUFAl2U2pMMEG7wCWwJ3h2ga8RbnCfX
         AaqVXfAKNtHxVIb7bIWd6jyP/AC+xzKvFrDjotRDlIja87WOBnEHDjcHy6uDe1FpiTKG
         2/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778254; x=1791383054;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfUv3bn823RJxdA8KgRrASglO9ITKlt+SqGbcVInGAg=;
        b=fYQveIh4YbxAF+4B4ENgSw9+c3JCR/eJWTPODLlr3qWFnnojuJQlpcOOhzYDq8QB7V
         5c5KCjVGL91ixYWKGgNDO9T5iXC2EBaWV998yDLc9u14gbcXTjZHw8u49c/0TYw6iDdS
         wN+8/R1JYLGDxP5RkNsA9AXyJ6sDrRgNEO2X8iCR0PAummPjROcjcLpjmwc5wh14jcCR
         JB8eM2JY2VPgMHlYmZ2bNcPmlMQq6qZ+RCd/77EntXjfy0KTXm5Fc4n6dBlspRuJjfBM
         YlBv1Kq6yPkLh+8xgbe4CGPqd7nt9LKADyOA8qPExrHQ/g8u4NjTXQgtW0yD5SDz0Iyx
         Yxhg==
X-Forwarded-Encrypted: i=1; AKwUvBzW2x14Wthnu14zyM9dSSku0JkYok/1xtSlqamEquEy8l7uCZOr3DgXWa64l26NSsg8wEWECC2Ny20=@lists.linux.dev
X-Gm-Message-State: AFq9FYJkCymOH/Yfx2m+pV0dQ42P7b88OBFZpQvkHTTH/nmthTWICMmo
	yMkhayAB0rbFb2QUyojl1hrHrBJnclfJSpZvaBbSktVigoNxMyrHlT7S92g2ErcGRQZOFD85pRv
	pgP+5J4TXmcRp+Q==
X-Received: from edyb9.prod.google.com ([2002:aa7:df89:0:b0:6aa:fc50:1dde])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2082:20b0:6ae:1a0a:ae9b with SMTP id 4fb4d7f45d1cf-6ae1a0ab0e4mr904441a12.25.1790778253694;
 Wed, 30 Sep 2026 07:24:13 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:23:57 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930142412.552765-1-jpiecuch@google.com>
Subject: [PATCHSET v3 sched_ext/for-7.3-fixes] sched_ext: Fix missing
 ops.dequeue() on remote local DSQ moves
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

When a task in the BPF scheduler's custody is moved to another CPU's
local DSQ, ops.dequeue() is deferred until the task is picked and then
reported with SCX_DEQ_CORE_SCHED_EXEC, instead of being called without
flags when the task is inserted into the destination DSQ. Patch 1 fixes
this by reverting the enqueue side of b75aaea24c9f ("sched_ext: Properly
mark SCX-internal migrations via sticky_cpu"). Patch 2 adds a selftest.

For 7.1.y, patch 1 also needs 18d62044cda7 ("sched_ext: Preserve rq
tracking across local DSQ dispatch"), as noted in its stable tags.

This is based on sched_ext/for-7.3-fixes (d35a535d3e3e). Merging it into
sched_ext/for-next gives a trivial conflict in the selftests Makefile,
where enq_blocked was added next to dequeue_remote; keep both.

Testing was done on x86_64 in virtme-ng with 4 vCPUs in an SMT topology
(2 cores x 2 threads) and CONFIG_SCHED_CORE=y. Without patch 1,
dequeue_remote fails in every run (30/30), e.g.:

  sched_ext: dequeue_remote: dequeue_remote.bpf.c:141: 15 (rcu_preempt): late ops.dequeue() with SCX_DEQ_CORE_SCHED_EXEC (enq_cpu=3 cpu=2 seq=1)
     ...
     ops_dequeue+0x114/0x170
     set_next_task_scx+0x104/0x1e0
     __pick_next_task+0xc7/0x180
     __schedule+0x154/0x1870

and the full sched_ext selftest suite reports 31 passed, 1 skipped
(nohz_tick), 1 failed (dequeue_remote).

With patch 1, dequeue_remote passes in every run (30/30), with ~140k
custody enqueues per run, ~90k of them followed by the task running on
another CPU. The full suite reports 32 passed, 1 skipped (nohz_tick),
0 failed. dequeue_remote also passes 10/10 with the runner and its
workers sharing a core cookie, where legitimate core-sched picks out of
custody do happen.

v3:
 - Test: kick the dispatching CPU if ops.dispatch() runs out of pops while
   the queue isn't empty, reset enqueue_seq in ops.init_task() and clear
   the exit record before each scenario (Andrea). Added Andrea's
   Reviewed-by.

v2:
 - Reordered to put the fix first and folded the Makefile entry into the
   test patch (Tejun, Andrea).
 - Fix: clear p->scx.sticky_cpu right after reading it, making the fix a
   revert of the enqueue side of b75aaea24c9f (Andrea). Reworded the
   comment and shortened the description (Tejun). Noted 18d62044cda7 as
   a 7.1.y prerequisite (Tejun, Andrea). Added Andrea's Reviewed-by.
 - Test: check p->core_cookie on SCX_DEQ_CORE_SCHED_EXEC instead of
   skipping when core scheduling is in use (Tejun).
 - Test: count CPUs with sched_getaffinity() (Tejun), pop past stale queue
   entries in ops.dispatch(), reset and print all counters per scenario
   (Tejun), destroy the struct_ops link and reap workers on error paths
   (Sashiko).
 - Test: deduplicated the descriptions and lowercased single-line
   comments (Tejun).

v2: https://lore.kernel.org/r/20260930114725.331370-1-jpiecuch@google.com
v1: https://lore.kernel.org/r/20260929161730.185271-1-jpiecuch@google.com

Thanks,
Kuba

Assisted-by: Claude:claude-opus-5.5

Kuba Piecuch (2):
  sched_ext: Call ops.dequeue() when a task arrives on a remote local
    DSQ
  selftests/sched_ext: Add a test for ops.dequeue() on remote local DSQ
    moves

 kernel/sched/ext/ext.c                        |  10 +-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/dequeue_remote.bpf.c  | 270 ++++++++++++++++++
 .../selftests/sched_ext/dequeue_remote.c      | 204 +++++++++++++
 4 files changed, 482 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_remote.c


base-commit: d35a535d3e3e71f92a051d94e415f43612c4edfc
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

