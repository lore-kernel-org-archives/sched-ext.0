Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0BA37BE6C;
	Tue,  6 Oct 2026 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308150; cv=none; b=E9bnJ98WbmwjRAZiQcjwqPQGrQvTuX7jm5iXjTsctobzvV5eO5kBpmmg/2+82Kmf5PWLRhMFuCVvSNMgR9GWWz6dm8EtH0n/ZRcs6b+a+zeTf2XvnL1Rl2kpwGy7R2Ioj2aqRsiBoqrmmN2R+nhqEWi5WekO314Lf1NTjjLS+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308150; c=relaxed/simple;
	bh=OX6bTkjW435HjZTTDnLi7uxynbt01c5GL0krywFEV44=;
	h=Date:Message-ID:From:To:Cc:Subject; b=hqlPoFEQO6oAapdPk6gbB77bP8EBxK1kFNgYfvZzN9FnBPdK1L+apDEk08fuVhtQfqpDu4az+Z69P+50YCt5IO9Yg0obo7fNcCw3R6Rm10GhjWaMPzLYVdFa4iF/3ermtLRH+OsZeO2pBbc2e6MBl35ZYgVDeRr+viInVAN8Lb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lpc/Oh5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lpc/Oh5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E781F0089C;
	Tue,  6 Oct 2026 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791308148;
	bh=kmNLW4KbcdzJkHKfY0fQiOgHN9xXurWExpZhYUJHQr4=;
	h=Date:From:To:Cc:Subject;
	b=Lpc/Oh5x/N9NhYtyhX4Ac9Ny6sNeqAMtHmcrND87cS9UcjByLWa13oIkxpiriTILM
	 9pVlWP3Ukzo7/ksp6OQYuhYg43gv60Io4WZC/IOWYFROJdrI7tv/3iogaCD1YcJ/76
	 NcRs9btwMhaihnW2rvfIWKdlL9hsJ6VP2UJfZejZ8MJi5PgX5CsoQwToQBXVNSqhUj
	 wFHrjfkBefxXJbNBPltG/IvS9u9NY2oBKdTGXXtqnWvNrDmGvdicxU3hd+HLs/F1GE
	 qgCfDpJSYKBIBg2G1zWwFheZ/zfv//eOElQJoDMhA0Pev5mhDTzDRvQyigBk96T3Y2
	 7QBLcn5lHf5NA==
Date: Tue, 06 Oct 2026 07:35:47 -1000
Message-ID: <afa1dcf110d0a6c081e1232c6ae2c989@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.3-rc6
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The following changes since commit 94480606a677deb68d5622cf0ded88626514b3f2:

  sched_ext: Add a size argument to scx_bpf_cid_topo() so struct scx_cid_topo can grow (2026-09-26 10:09:12 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc6-fixes

for you to fetch changes up to e6ac89b8b1c12e9104df45a14a26e2dfa96ded06:

  sched_ext: Generate qseq from a per-task counter (2026-10-03 13:23:31 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.3-rc6

- Taking a CPU offline could hang, or stall until the watchdog ejected the
  BPF scheduler, when tasks on the dying CPU were still held by the
  scheduler or sitting on a user dispatch queue. Re-enqueue them onto the
  local queue when the runqueue goes offline so that the CPU pushes them off
  like the other sched classes.

- The sequence number guarding against stale dispatches was per runqueue, so
  a task re-enqueued on another CPU could get the same number and a dispatch
  meant for its earlier instance was applied to the new one. Use a per-task
  counter.

- A task dispatched to another CPU's local queue got its ops.dequeue() only
  when picked to run and flagged as a core-sched pick. Call it at insertion
  like for same-CPU dispatches.

----------------------------------------------------------------
Kuba Piecuch (3):
      sched_ext: Call ops.dequeue() when a task arrives on a remote local DSQ
      selftests/sched_ext: Add a test for ops.dequeue() on remote local DSQ moves
      sched_ext: Generate qseq from a per-task counter

Tejun Heo (1):
      sched_ext: Fix CPU hotplug hang when a dying CPU's tasks sit in the BPF scheduler

 include/linux/sched/ext.h                          |   1 +
 kernel/sched/ext/ext.c                             |  46 +++-
 kernel/sched/ext/inlines.h                         |   8 +-
 kernel/sched/ext/internal.h                        |   5 +
 kernel/sched/ext/sub.c                             |   4 -
 kernel/sched/sched.h                               |   6 +-
 tools/testing/selftests/sched_ext/Makefile         |   1 +
 .../selftests/sched_ext/dequeue_remote.bpf.c       | 270 +++++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue_remote.c | 204 ++++++++++++++++
 9 files changed, 528 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_remote.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue_remote.c

-- 
tejun
