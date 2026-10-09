Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260504766A8
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553236; cv=none; b=qyIYA0nJkRC0CiEh8d/KM4RzqzOo5Qdm+80Pja0PcFZ86fmrU2CWX75l++Qda/31HRuTzGJ2dCj2BnnYSQQ+jp8ji/9hvjkvhHsiLTXHo30+ib54p0If/oRr6N1SFkQmS4DZ7uoImt+K8gs17pyGWCtHgg5Hhnt8XFRjM2VNfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553236; c=relaxed/simple;
	bh=gCdjZFwhGZ/EUK4Xd6SSN7hZ8GPt++/qjICTFixal/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=owvUs3022h9yWSc1KInhbDyBiB0F3oelKm4mRKU1ssT/dc6qiHuFqzOJS9up2MoUDfjqODwlkdH9HDkpVWzB3qgHXBwEbf6tMlJuVlmkC1FmCXtX5Ha5xUphBxuNlk/TaEbE65kL6hDmLlvES84Vrk7kOaJAQMfjdYxt8uedvTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pi3e0QTG; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pi3e0QTG"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=gCdjZFwhGZ/EUK4Xd6SSN7hZ8GPt++/qjICTFixal/4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791553230; v=1; x=1792158030;
 b=pi3e0QTGK/8bmM6HK/qHkcZMNognmmqDQ5GJViJnLMw48o7tGrOsyHZbGoDahkdI5NKVH61/
 c8yP+qOfbHEHo4iJ5bZ1+uti0lx/sAMM81dIzP/pqAgvHiW1TcWnPN4h4pN+KV70xPZ9FUKqj/t
 1JcpBjktVGAIQjByVcUegY7Y=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 71c37f6ce2736980;
	Fri, 09 Oct 2026 13:40:29 +0000
X-Mizu-Trace-ID: 71c37f6ce2736980
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/5] sched_ext: selftest infrastructure fixes
Date: Fri,  9 Oct 2026 21:40:14 +0800
Message-ID: <20261009134020.296763-1-cui.tao@linux.dev>
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
asserts on, EXIT_KIND() silently maps missing BTF enums to
SCX_EXIT_NONE, waits for scheduler exit are unbounded, attach
failures in the reload stress test are swallowed, and an error path
in reload_loop destroys the skeleton under a still-running thread.

  1. selftests/sched_ext: Fix reload_loop error-path use-after-free
     If the second pthread_create() fails, run() returns and the
     runner calls cleanup, which destroys the skeleton while the
     first reload thread is still running do_reload_loop() and
     dereferencing its maps. Set force_exit and join the first
     thread before failing.

  2. sched_ext: Add SCX_ECODE_RSN_CGROUP_OFFLINE to user_exit_info.h
     Sync the tools-side exit code enum with the kernel; without it
     userspace code has no name for this reason.

  3. selftests/sched_ext: Fail loudly when EXIT_KIND is missing from
     BTF. EXIT_KIND() resolves scx_exit_kind values through
     __COMPAT_ENUM_OR_ZERO(), which maps a missing enum to 0 (==
     SCX_EXIT_NONE), so on kernels whose BTF lacks the enum every
     EXIT_KIND() comparison is meaningless. Resolve the value with
     __COMPAT_read_enum() and fail the test when it is missing,
     matching SCX_ECODE_VAL() and SCX_KIND_VAL(). The kick and
     nohz_tick polling helpers switch to UEI_EXITED() so they keep
     their semantics without a BTF lookup.

  4. selftests/sched_ext: Add SCX_ASSERT_ALIVE and adopt it. A
     scheduler that dies mid-test freezes the state that the test is
     about to assert on, so the assertions can pass vacuously.

  5. selftests/sched_ext: Bound exit waits and report reload_loop
     failures. exit, prog_run and hotplug wait for the scheduler to
     exit with no time bound; a scheduler that never exits hangs the
     runner. Bound the waits to ~10s (iteration-based). reload_loop
     skips bpf_map__attach_struct_ops() failures silently: measured
     on a loaded host, 1125-1233 of 2048 iterations failed, all with
     EBUSY (the single scheduler slot changing hands between the two
     threads). Count the failures per thread and fail the test only
     on unexpected errnos or when every attach failed.


Tao Cui (5):
  selftests/sched_ext: Fix reload_loop error-path use-after-free
  sched_ext: Add SCX_ECODE_RSN_CGROUP_OFFLINE to user_exit_info.h
  selftests/sched_ext: Fail loudly when EXIT_KIND is missing from BTF
  selftests/sched_ext: Add SCX_ASSERT_ALIVE and adopt it
  selftests/sched_ext: Bound exit waits and report reload_loop failures

 tools/sched_ext/include/scx/user_exit_info.h  |  1 +
 .../selftests/sched_ext/create_dsq.bpf.c      |  8 +++
 .../testing/selftests/sched_ext/create_dsq.c  |  2 +
 tools/testing/selftests/sched_ext/exit.c      |  4 +-
 tools/testing/selftests/sched_ext/hotplug.c   | 12 +++--
 .../sched_ext/init_enable_count.bpf.c         |  8 +++
 .../selftests/sched_ext/init_enable_count.c   | 13 +++++
 tools/testing/selftests/sched_ext/kick.c      |  8 +--
 .../testing/selftests/sched_ext/maximal.bpf.c |  6 ++-
 tools/testing/selftests/sched_ext/maximal.c   |  2 +
 tools/testing/selftests/sched_ext/nohz_tick.c |  6 +--
 tools/testing/selftests/sched_ext/prog_run.c  |  7 ++-
 .../testing/selftests/sched_ext/reload_loop.c | 53 ++++++++++++++++---
 tools/testing/selftests/sched_ext/scx_test.h  | 48 ++++++++++++++++-
 14 files changed, 155 insertions(+), 23 deletions(-)

-- 
2.53.0

