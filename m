Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D073E5A08
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698654; cv=none; b=WLl6KFaDSMWHBn3Mcf2VO3LIJrHR1/MXFBAdzS44jHYbceCf+6SyXnk1lgOzXSJHHugRGkcIA1v+RIsT2euDkjaLf00GnaZnoS4trC9edxNC0L/gEwYhNA1T/kf0GKR6QM1mDXb/mSq+txle/0xR8/QTsfyhUuiumu2Cq7o/zBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698654; c=relaxed/simple;
	bh=YdjoKtP1em+LNFUenaaFDnwTq/qBHkbg2KuVHSCYjyE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZY37mpVAj/zP4SCsRvWvEOgNtC8Op70z8A2iXeC6DOa6xmtbplCU7qd2zPItaP22J0UxLp3xuCKflvT/2XehZYcPkX31CWrgqQWeDRjC4Hv/D8N2v5Dos6tSjp4UnwwLnRH2R344xVm+qAZX8o71KMRXsnwbHkZQyeJe729/xFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7LzaEh2; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7LzaEh2"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a013ea30c0so1727825e9.0
        for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790698651; x=1791303451; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0azr8zZg0nRvm5mZWbQlZBuE34GAu+5gLcWr9Qc6JlQ=;
        b=O7LzaEh2oKim8mRiD74Ecn+JTGv8njP/2ys2NddEBbQcpvmyi/M2vkjX2AAXdhUIBp
         q/cVgfrzqlyJTnlJbYPRGAaKzdM7NLBkTmkn9WxgllUZr9m9e8BbZuumQo9su2S83UAJ
         2ySafvW943vLQGsb4kS13uzUdqddOo75IyC+VNX3ufvRMU0TC1Snkpeb+syezC1D23VY
         k7udCgKA+yv60Fum+Y5xaejd3K38kNnL1WGOSdANINinxLzWCLG6iUGlYtQyPmKhdUwb
         6aLSuQvQa+1E3bo3iaZ2W2dh2c7A6gcOSs6X6FovMFynHv9t0Sp9FyHcLRQuUecGmzd8
         lOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698651; x=1791303451;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0azr8zZg0nRvm5mZWbQlZBuE34GAu+5gLcWr9Qc6JlQ=;
        b=QrK0mxcCFn22Y3MVYo8vqsrHwXjrnrExVZ/zfHk5H6mKuy6Pev2OGxFc5j7LE5BTrj
         CrM9eHAWsTKHcGUrTB1d264sIRrGcM3HpAhwIDyTL8zxVFimW3f098oz7zowZ+gyCddK
         8uuyg4VdkPoyojBA5udL0zj5GCFOOf/NmL8BuUv8zQFmwdj1Mj7gOgmY8jw4mL6OtYUD
         QWNuo0K3zZp5hlSmUboEnNNhTyYCxcbxjZxlKItjrUIEkeNkz3z85L1/g2cvtk1nvKFY
         8x5N48zgmluII8VCrUbQGFx/rn1GGD5kWGsAX/tmC7Jsg65B9FM5nJwkk17TN35tQaLb
         BMxA==
X-Forwarded-Encrypted: i=1; AKwUvBwhuZpxKjraAJdcMFPgc9K6hspEFZ7pQKDu5CI47edAEDseRgS0MZJXMmrbyk6i6S36PHO1MzI2Ua4=@lists.linux.dev
X-Gm-Message-State: AFuF++km+OMp9m8Doa8cdYgzNXsE/aok9MkQqDGww/SbVeBnwxg1KR/T
	cQ3mvAf73lVrTbrWr3b2dqGhRGz+60AOgb627kBhC60H2q56PYNK2ZmfoE6Qp8y0SRxg4xWMEDM
	SfNnOEw5JGjrzow==
X-Received: from wmbil3.prod.google.com ([2002:a05:600c:a583:b0:4a0:146f:133b])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:698d:b0:49d:1df6:2592 with SMTP id 5b1f17b1804b1-49ff06e504dmr237604865e9.21.1790698651301;
 Tue, 29 Sep 2026 09:17:31 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:17:23 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929161730.185271-1-jpiecuch@google.com>
Subject: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix missing
 ops.dequeue() on remote local DSQ moves
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Since ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics"), every task
entering the BPF scheduler's custody gets exactly one ops.dequeue() when
it leaves it. A dispatch to a terminal DSQ ends custody with a flag-less
ops.dequeue() at insertion time.

That doesn't happen when the task is moved to the local DSQ of a CPU other
than the one whose rq it's on (SCX_DSQ_LOCAL_ON dispatch,
scx_bpf_dsq_move_to_local(), scx_bpf_dsq_move*()).
move_remote_task_to_local_dsq() sets p->scx.sticky_cpu to mark the
internal migration, but enqueue_task_scx() only clears it after the task
has been inserted into the destination local DSQ. task_leave_custody()
thus skips the custody exit on insertion, and the task sits on the local
DSQ with SCX_TASK_IN_CUSTODY still set. The BPF scheduler is only told
later, either:

 - when the task is picked, via ops.dequeue(SCX_DEQ_CORE_SCHED_EXEC) from
   set_next_task_scx(), even though core scheduling isn't involved, or

 - on a property change while the task waits on the local DSQ, via
   ops.dequeue(SCX_DEQ_SCHED_CHANGE) for a task already out of custody.

The existing dequeue selftest doesn't notice because it treats the late
SCX_DEQ_CORE_SCHED_EXEC dequeue like a regular dispatch dequeue, and it
still arrives before ops.running().

Patch 1 adds a dequeue_remote selftest that makes remote moves the common
case and fails on a SCX_DEQ_CORE_SCHED_EXEC dequeue, on a task running
without a preceding ops.dequeue(), or on unbalanced ops.enqueue() /
ops.dequeue() calls. Since core scheduling can legitimately pick tasks
straight out of custody, the test is skipped if any task has a core
scheduling cookie when it starts. It isn't added to auto-test-targets
since it fails on the current tree. Patch 2 fixes the bug by clearing
p->scx.sticky_cpu before scx_do_enqueue_task(). Patch 3 enables the test.

This is based on sched_ext/for-7.3-fixes (94480606a677) and also applies
cleanly to sched_ext/for-next. Testing was done on x86_64 in virtme-ng
with 4 vCPUs in an SMT topology (2 cores x 2 threads) and
CONFIG_SCHED_CORE=y, with no core scheduling cookies in use.

Without patch 2, dequeue_remote fails in every run (30/30), within the
first few custody enqueues after the scheduler is loaded:

  sched_ext: dequeue_remote: dequeue_remote.bpf.c:143: 156 (runner): late ops.dequeue() with SCX_DEQ_CORE_SCHED_EXEC (enq_cpu=1 cpu=3 seq=1)
     ...
     ops_dequeue+0x114/0x170
     set_next_task_scx+0x104/0x1e0

and the full sched_ext selftest suite reports:

  PASSED:  31
  SKIPPED: 1  (nohz_tick)
  FAILED:  1  (dequeue_remote)

With patch 2, dequeue_remote passes in every run (30/30). A typical run
does ~140k custody enqueues across both variants, each matched by exactly
one ops.dequeue(), with ~90k of them followed by the task running on a
CPU other than the one it was enqueued on. The full suite reports:

  PASSED:  32
  SKIPPED: 1  (nohz_tick)
  FAILED:  0

With a core scheduling cookie in use, dequeue_remote is skipped as
expected.

Thanks,
Kuba

Assisted-by: Claude:claude-opus-5.5

Kuba Piecuch (3):
  selftests/sched_ext: Add a test for ops.dequeue() on remote local DSQ
    moves
  sched_ext: Call ops.dequeue() when a task arrives on a remote local
    DSQ
  selftests/sched_ext: Enable the dequeue_remote test

 kernel/sched/ext/ext.c                        |  16 +-
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/dequeue_remote.bpf.c  | 272 ++++++++++++++++++
 .../selftests/sched_ext/dequeue_remote.c      | 243 ++++++++++++++++
 4 files changed, 527 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_remote.c


base-commit: 94480606a677deb68d5622cf0ded88626514b3f2
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

