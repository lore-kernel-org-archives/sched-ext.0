Received: from mta0.migadu.com (out-32.mta0.migadu.com [91.218.175.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805F309EEC
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983617; cv=none; b=XNz2nZMCM83hBsnA1SoFEAIcbBT/fLl2klKQJrT513XR++tgd2nGw5o1nkYkJXlKyXAkquqCrskLkSrxPzpG5pQeEe/dZw0w828cxwqvq0fAE+rHzi6+DqbfNDHK3e2csYwEnEz5z//tVCOMhqGPZ8uvCJtZv+K+hPDTMu7xhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983617; c=relaxed/simple;
	bh=Qud/y84Ji5GDQQInuXlFLlF0n8J8rV+DIa76LZ7G5n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nin9XpV3SAVOEY/8paS+fi3G+WX20MnJe3bUpmAeIwmMjZawOZ+mnxImtPjnuGY+vHWwj7FvYRrE8gj2ZHawDicd8K2KmaItJLMfvLHyZRZhxL9z1KnZnbns/OgCNHLX+/qmmLr26KFuyw3JHwo/6c3Ey9CeIW9ly580xkXeDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GOb3Uc/R; arc=none smtp.client-ip=91.218.175.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GOb3Uc/R"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Qud/y84Ji5GDQQInuXlFLlF0n8J8rV+DIa76LZ7G5n0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791983613; v=1; x=1792588413;
 b=GOb3Uc/Rqk0GhjK1kelHEa3GZmih/eOAbav64Qi2/2tZDwBrbBwJoFCLmR2aN9SSW2MZ2ltX
 o/rIt2ToVSWTM1vLjzcSs69f8IxQ/1I0c+UJG54qnXkz5ZCH8W9B7CSc5BAdfQRLJ9DC3he0GwD
 ZxPp0yMyl59Ja6431ciTkzxc=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id d4a7d5d4729e2af2;
	Wed, 14 Oct 2026 13:13:32 +0000
X-Mizu-Trace-ID: d4a7d5d4729e2af2
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Tao Cui <cuitao@kylinos.cn>,
	cui.tao@linux.dev
Subject: [PATCH v2 0/6] sched_ext: selftest infrastructure fixes
Date: Wed, 14 Oct 2026 21:13:19 +0800
Message-ID: <20261014131325.793640-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The sched_ext selftests pass vacuously or hang in several failure
scenarios: a scheduler that dies mid-test freezes the state the test
asserts on, EXIT_KIND() silently maps missing BTF enumerators to
SCX_EXIT_NONE, waits for scheduler exit are unbounded, attach
failures in the reload stress test are swallowed, and an error path
in reload_loop destroys the skeleton under a still-running thread.

This is v2 of the series posted as [1]; it applies the review
feedback from Tejun (and the sashiko bot findings, which overlapped):

  - P1: use SCX_FAIL() inside the error branch.
  - P2: name ebeca1f930ea in the description (and fix the wrong
    attribution the v1 description carried).
  - P3: the v1 premise was wrong - struct scx_exit_info carries the
    enum, so the BTF always has the type and the enumerators the
    tests use exist on all sched_ext kernels. The patch is kept but
    reshaped: EXIT_KIND() is now an alias of SCX_KIND_VAL() (single
    implementation), the remaining kind != EXIT_KIND(SCX_EXIT_NONE)
    sites are converted to UEI_EXITED(), invalid_one() resolves
    error_kind before spawning the gated worker, and the v1
    <unistd.h> include is not needed here.
  - P4: SCX_ASSERT_ALIVE() prints uei.msg too.
  - P5: split in two. exit.c now destroys the link and the skeleton
    on its timeout path (a scheduler stuck unexited no longer stays
    attached and makes every later test fail with EBUSY); reload_loop
    drops its dead reporting arm and the always-on EBUSY printf, and
    the failure bar is now "at least one successful attach per
    thread". The two #defines became an enum and stray blank lines
    after setup() are gone.

Base: tj/sched_ext for-next at 8ef2c4fe917a ("Merge branch
'for-7.3-fixes' into for-next"), rebased after the review round.
v1 was based on the then-tip f55a5ae74ca6; the rebase is a pure
replay (the only selftest-side upstream change in between is a
dequeue_remote.c build fix outside the files touched here).

Testing: full sched_ext selftest suite (QEMU/KVM x86_64, 4 vcpus,
serial console) on a kernel built from this base: a runner built from
this series and a runner built from the plain base pass identically,
38 passed / 2 skipped / 0 failed each (the skips are
environment-dependent: enq_blocked requires PROXY_EXEC and nohz_tick
requires NOHZ_FULL; kick_coalesce passes since the base kernel has
lazy preemption). On top of that, A/B checks: a scheduler whose exit
point never fires wedges a pre-series runner forever in exit's
unbounded wait, while with patch 5 the runner reports "Timed out
waiting for scheduler to exit" after ~10s, destroys the link and the
skeleton, and every subsequent test still attaches and passes (the
stuck A/B ran on the f55a5ae74ca6 pre-rebase base with identical
series content; the remaining A/Bs were run the same way on the v1
base and their code paths are unchanged here); a synthetic BTF
without the SCX_EXIT_UNREG_BPF enumerator fails loudly with patch 3
and passes silently without it; an injected scheduler death reports
kind, exit code and uei.msg through SCX_ASSERT_ALIVE(); under reload
stress with in-flight teardown, patch 6 classifies the observed
1125-1233 EBUSY failures and passes as long as each thread completed
at least one attach.

[1] https://lore.kernel.org/all/20261009134104.296891-1-cui.tao@linux.dev/

Tao Cui (6):
  selftests/sched_ext: Fix reload_loop error-path use-after-free
  sched_ext: Add SCX_ECODE_RSN_CGROUP_OFFLINE to user_exit_info.h
  selftests/sched_ext: Fail loudly when EXIT_KIND is missing from BTF
  selftests/sched_ext: Add SCX_ASSERT_ALIVE and adopt it
  selftests/sched_ext: Bound exit waits
  selftests/sched_ext: Report reload_loop attach failures

 tools/sched_ext/include/scx/user_exit_info.h  |  1 +
 .../selftests/sched_ext/allowed_cpus.c        |  2 +-
 .../selftests/sched_ext/cgroup_nr_cpus.c      |  2 +-
 .../selftests/sched_ext/create_dsq.bpf.c      |  8 +++
 .../testing/selftests/sched_ext/create_dsq.c  |  2 +
 .../selftests/sched_ext/cyclic_kick_wait.c    |  2 +-
 .../testing/selftests/sched_ext/enq_blocked.c |  2 +-
 tools/testing/selftests/sched_ext/exit.c      |  8 ++-
 tools/testing/selftests/sched_ext/hotplug.c   | 12 ++--
 .../sched_ext/init_enable_count.bpf.c         |  8 +++
 .../selftests/sched_ext/init_enable_count.c   | 13 +++++
 tools/testing/selftests/sched_ext/kick.c      |  8 ++-
 .../testing/selftests/sched_ext/maximal.bpf.c |  6 +-
 tools/testing/selftests/sched_ext/maximal.c   |  2 +
 tools/testing/selftests/sched_ext/nohz_tick.c |  6 +-
 tools/testing/selftests/sched_ext/prog_run.c  |  7 ++-
 .../testing/selftests/sched_ext/reload_loop.c | 49 +++++++++++++---
 tools/testing/selftests/sched_ext/scx_test.h  | 57 +++++++++++++++++--
 18 files changed, 162 insertions(+), 33 deletions(-)

-- 
2.53.0

