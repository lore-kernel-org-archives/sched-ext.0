Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8F490BFE
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792325703; cv=none; b=EsJPZ4bgowQn+5Vor/qbeZnQhgjEMbb6ogrB4GZy4mzUYhaevQ9E21EiwMOjLB3k5SSU8MvfTfY7MSqb9Sfx6fDuQfaI7hWOMPc6mvPcXmEQDMwCHYn9r2z/NVr37jp5+42fpAQ/7gJD0bMuuCXUvDjYb9zg9tyhgbPSDIzYOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792325703; c=relaxed/simple;
	bh=UxjNk5uYSfx/E2gN0ht+iOoT2oc1pgXeBDd9V0fyIt0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OnH1qsm5d1obqpcqJhCcD7KnzD9XoiQBtgrj/QV6mSDIR56mySblNhz/6PZ2z3BwmHmHHU5HmAU5tlFUPY3QkbYqFOwNGYIDHlPjgFRwczQyNxS6Mv4SbXgwHCLzLcS6cPZvcNqK34ImzrG1c093hUNng6AmJ3iFfin4E4w8jCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDBlhB5f; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDBlhB5f"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1cf5e7012so10221015e9.2
        for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792325700; x=1792930500; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OyLJ1fPr/NVzbEHVO60EnzIzzO/ppvi8bngayEfvgMs=;
        b=dDBlhB5fnoDhTKxdAKTEsTlL3rRbqjeBdhxM6y9BKRhWxfT4Y3rS3zz8BT27oATRCm
         lGagGFX1RSWqHCUmQNilKdV7Ln6laNa3hlnsZvwvIulAZ8/a+zqxqv8Wn8TvDLH3EpeV
         9PCKBc6ON+ZdMp+ypwcqvLultf9S9AOxo4IIBLlbzdU2X2CaifTky8L/ziXjZ+/1IUzx
         XJu1np/HGe/MVS+ceA2+kiUpWfqxPEIIaGM3Fy8KcjnFE3fR7Pwtap12DKXd9BJUEMJM
         E1szRWMLaIuJfYFJWNG3d540tjRdRw8LhE+20GT262H2zAzxCUL1TUHdCPCd9XFbDHNF
         oBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792325700; x=1792930500;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OyLJ1fPr/NVzbEHVO60EnzIzzO/ppvi8bngayEfvgMs=;
        b=o1mIjLecBNd9OoAdTTbU6BxrHuCHgobxyTdN414h7oniTqYnQRMRmjC7ulkrmSgnYd
         0GU3Jz24qVxhZjE90MigOZ60sf0TaumwIT3GmtTYh43UyXb0gOl9VGFjyEuQybGNMAtG
         IFmsHQbVzzqUhT6WMMkPj1t0m07NqdPjTYQoOgK04EiZyP5zzcnl290j20HseppQndc+
         i2KZqDe2quNopwRBZEHapZK2MAzgeLp3YNQhDMWfDOjHXzbenbP1S+xFtMdRPyGRtbxZ
         Bt8KM6bWXvL0ejD1fx6ZQivvW1PKZyagJ+ooR3pgmpncJ6dtQb6dqx0k6/bOiiX5q5ZG
         vqFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwI7hPSKJ6VlxtZ3Iz49yXNsXL/shWMuxaeAw0/6ZnE+D7fbFYITrqJ08QppMy+d9T+NGfpxM/np+s=@lists.linux.dev
X-Gm-Message-State: AFq9FYLx1U1Mtb/pJm8F+yysgZz3DXZvVl+y69rjJWeV/KHlo5u877+K
	bHtrRjJacKGitjaGKVX/8LadTt0UapxvbuUxMWTwMS1wDsvSqv/m1zuSYwio8UCDKoEdpWVOVPX
	LKysJRzf3xBxaNw==
X-Received: from wmbdn26.prod.google.com ([2002:a05:600c:655a:b0:4a1:aef5:769c])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba6:b0:4a1:cef3:622e with SMTP id 5b1f17b1804b1-4a1d75e6f17mr121936875e9.6.1792325699781;
 Sun, 18 Oct 2026 05:14:59 -0700 (PDT)
Date: Sun, 18 Oct 2026 12:14:44 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <cover.1792248922.git.jpiecuch@google.com>
Subject: [RFC PATCH sched_ext/for-7.4 0/5] sched_ext: Make ops.cpu_acquire/release()
 reliable
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

ops.cpu_acquire() and ops.cpu_release() are meant to tell the BPF
scheduler when a CPU becomes available to it and when it's taken away.
As they are now, they can't be used to reliably track that:

- An RT task waking up on an idle CPU doesn't trigger ops.cpu_release().
  The release is only emitted from put_prev_task_scx(), i.e. when an SCX
  task is switched out.

- A running SCX task moving to a higher class through
  sched_setscheduler() or a PI boost doesn't trigger it either, as no
  context switch takes place.

- ops.cpu_acquire() is emitted speculatively from dispatch_one(). If a
  higher class task wins the pick afterwards (dispatch dropped the rq
  lock, RETRY_TASK, core-sched picking for a sibling), the CPU stays
  acquired while an RT task runs on it.

- rq->scx.cpu_released carries over from one scheduler to the next and
  CPU hotplug isn't handled.

Commit a3f5d4822253 ("sched_ext: Allow scx_bpf_reenqueue_local() to be
called from anywhere") deprecated the callbacks, as closing these gaps
was thought to require a hook invoked regardless of sched class. This
series shows that it doesn't.

Whether a CPU is available to the BPF scheduler only depends on the
class of rq->donor: the CPU is available while an SCX task or the idle
task runs on it and released while a stop, DL, RT or fair (partial
mode) task does. Every change of availability has an SCX task or the
idle task on one side of the switch, so the ext and idle classes' own
put_prev_task() and set_next_task() see all of them. Switches between
higher class tasks never change availability. The one remaining case, a
running task leaving SCX without a context switch, is caught by
switched_from_scx().

kernel/sched/core.c is left untouched. The idle class gets two calls
next to its existing scx_update_idle() calls and sched.h gets one new
scx_rq flag.

Points worth discussing:

- Core-sched forced idle counts as available. Whether a task can be
  placed on a forced idle CPU depends on that task's cookie, which is
  for the BPF scheduler to judge.

- ops.cpu_acquire() moves from before ops.dispatch() to the point where
  the CPU actually switches to an SCX task or idle, so ops.dispatch()
  may now run on a released CPU. A speculative acquire before dispatch
  can't be made reliable without hooks in every class.

- The callbacks may be invoked for a remote CPU, with that CPU's rq
  locked: sched_setscheduler() or a PI boost of a task running on
  another CPU, and scheduler enable. Patch 1 makes the legacy
  scx_bpf_reenqueue_local() re-enqueue the locked rq's local DSQ instead
  of assuming smp_processor_id().

- Every CPU starts out released, and each available online CPU is
  acquired when the scheduler is enabled. The callbacks are only
  invoked between ops.cpu_online() and ops.cpu_offline(). Because
  rq_online_scx() runs before ops.cpu_online() when a CPU comes up,
  this uses a new SCX_RQ_OPS_ONLINE flag rather than SCX_RQ_ONLINE.

- Schedulers which don't implement the callbacks only pay for a static
  branch.

- The callbacks stay cpu-form only, which makes them root-only by
  construction. cid-form variants and fan-out to sub-schedulers (gated
  on SCX_CAP_BASE, like ops.update_idle()) could follow if there's
  interest.

Patch 1 makes the legacy scx_bpf_reenqueue_local() target the locked
rq. Patch 2 emits the callbacks on actual transitions and handles
scheduler enable/disable and CPU hotplug. Patch 3 releases the CPU when
its running task leaves SCX. Patch 4 un-deprecates the callbacks and
documents the contract. Patch 5 adds selftests.

Testing was done in virtme-ng with PROVE_LOCKING, DEBUG_ATOMIC_SLEEP,
SCHED_CORE and EXT_SUB_SCHED enabled. The full sched_ext selftest suite
passes without splats. The new cpu_avail test checks the reported state
on every context switch through a sched_switch tracepoint and covers
idle -> RT, remote class changes, the legacy re-enqueue from a remote
release, PI boosting, hotplug, scheduler reloads and partial mode. It
fails on the base kernel (idle -> RT) and with only patches 1-2 applied
(remote class change). cpu_avail_core, run in an SMT VM, checks that
core-sched forced idle doesn't release a CPU while an RT task with a
matching cookie does.

Not included:

- tools/sched_ext/include/scx/*autogen* isn't regenerated for the new
  SCX_CPU_PREEMPT_FAIR and SCX_CPU_PREEMPT_CLASS_CHANGE values. I'll add
  that as a separate patch in a non-RFC posting.

- Unrelated to this series: the comment on SCX_RQ_ONLINE in sched.h says
  it tracks the ops.cpu_online()/cpu_offline() state, but as noted above
  rq_online_scx() runs before ops.cpu_online() on hotplug. I can send a
  separate fix if that's useful.

Kuba Piecuch (5):
  sched_ext: Make legacy scx_bpf_reenqueue_local() target the locked rq
  sched_ext: Emit ops.cpu_acquire/release() on actual CPU transitions
  sched_ext: Release the CPU when its running task leaves SCX
  sched_ext: Un-deprecate ops.cpu_acquire/release()
  selftests/sched_ext: Add cpu_avail tests

 kernel/sched/ext/ext.c                        | 265 +++++--
 kernel/sched/ext/ext.h                        |  19 +
 kernel/sched/ext/internal.h                   |  69 +-
 kernel/sched/idle.c                           |   4 +
 kernel/sched/sched.h                          |   6 +
 tools/testing/selftests/sched_ext/Makefile    |   2 +
 .../selftests/sched_ext/cpu_avail.bpf.c       | 218 ++++++
 tools/testing/selftests/sched_ext/cpu_avail.c | 717 ++++++++++++++++++
 tools/testing/selftests/sched_ext/cpu_avail.h | 237 ++++++
 .../selftests/sched_ext/cpu_avail_core.c      | 256 +++++++
 .../testing/selftests/sched_ext/maximal.bpf.c |  10 +
 11 files changed, 1706 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/cpu_avail.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/cpu_avail.c
 create mode 100644 tools/testing/selftests/sched_ext/cpu_avail.h
 create mode 100644 tools/testing/selftests/sched_ext/cpu_avail_core.c


base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
-- 
2.56.0.176.g3575e65682-goog

