Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775857;
	b=q8J0Bw/Yl0PrOOC4TkUlPjbZB0yJO6o2MWsG3AJ/vnvunRci47Xqx/tUdmSUVy8tzncl
	 JnMbFyBt+N3aSJ7vFO3KEKK5gvKnZp+P57iRVQau+NWaStlzn17vc40WezAq1NkK6oBuO
	 OAVPCUzWqCpE3Z3x8QL+sFV4aze77ryVr5sGvZ+uvhNQtD2xjBEyWdsXMmZh7xLZQg7WH
	 mQvxn0/4JGsZMxBLZq+FVaqG6U1M10Oa9wII5tDCH6h5N1J3ddo06K595WAzZBWUTHDIu
	 848bW2dvQWv07YKyvvT2Pgyu1d76Mk3iVVxMDhfPrn6EZaMqCrKglf+kHfV8t1fzhkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775857;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject;
	bh=fG29Zz44ZpJyCL0u2MxsfTicTkhiXGVFDmgDZC/UFuw=;
	b=QhYrj2CuXbquicTL/t57TThFYMCJx+EmeOi/hPfP4D3X8u8bh29BLcp4D+nHIfr2KduU
	 UXAzhcdMcw/ApeciiGQ8/Ck6zfkYSA16IrzxO7pxi/2n3V6HlVMSXnhoUryZ1BqycWrYr
	 W3UXClCBR7YKWMjInmxDMDEB3GIWHZyoJOiY9Pp/Z/IDJLIJeL3zrWhP/HEwkIbz+fv5b
	 8KFfs1G3cp8EheMUFgis+NbqNfKnnzdvvY1CO9VcFAK0wDE4oF2JBpfXhH+5dIDz9Yc1L
	 gLbREpQIsaWIvDgnOpFPEbUuoRzd56OjCaSzX5HMynVDmi+JTuBBaJysEj7/gjzy7rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEAqoXsx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDB606A31F;
	Sun, 15 Nov 2026 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEAqoXsx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46841F000C4;
	Sun, 15 Nov 2026 20:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794775857;
	bh=fG29Zz44ZpJyCL0u2MxsfTicTkhiXGVFDmgDZC/UFuw=;
	h=Date:From:To:Cc:Subject;
	b=WEAqoXsxFGvBKjxZWVdg6VBVJmt1MT3TzAy0w9yb5EJ12yNJdt6Ei/9kxZKL8zrF0
	 OCiIr1mULBbP8EFkbbKu41gzU6RKMCF2LjAZLx8kIzcMFXQrAkOLZ6a0doUBcdD7tI
	 9QFFkjHZNHCzpgrEV4T874vfsvctAYhftuDVL+jGeT8MoAnODQj2bhcCOyNKXQQ1eG
	 Yk0GrAILKD0GeDdI0Ua0oGLc6gUBftsNKHtDd0HxElW5Mr3gF3w8QgJ7W/6ZtJJkuB
	 xbxPozae9aFEGfDaDZy4qW6vGmoyNegif2BxDsrBIHE9+xF1afuNShhkg2ocuTTstE
	 ReyqozVDqHkRg==
Date: Sun, 15 Nov 2026 10:50:56 -1000
Message-ID: <ac8a34b2fcba5a00d2f779a0bcf71592@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sched_ext: Fixes for v7.4-rc2
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

The following changes since commit 4dd16e31135ea8437a720222df34e8745f385d6d:

  Merge tag 'net-7.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-10-29 08:17:05 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4-rc2-fixes

for you to fetch changes up to 700a332c3fe33014bbd5ae852d71ba679fc29e0a:

  sched_ext: Reject DSQ iterator kfuncs in tracing programs (2026-11-12 07:30:07 -1000)

----------------------------------------------------------------
sched_ext: Fixes for v7.4-rc2

- With proxy execution or core scheduling, a CPU could run a task that had
  been requeued on another CPU while dispatch had the rq lock dropped.

- Unregistering a scheduler could return while its teardown was still
  running, letting the teardown call into BPF code that was already freed.

- A CPU coming online could call into the BPF scheduler before the scheduler
  was told that the CPU is online.

- A parent scheduler could be asked to attach a sub-scheduler to a cgroup
  that was already removed.

- Hardening: more kfuncs that take a queue lock are rejected in tracing
  programs, where they could deadlock the CPU, and a queue iterator no
  longer restarts after reaching the end, which the BPF verifier assumes
  can't happen.

- Smaller fixes: tasks needlessly sent back to the BPF scheduler on idle
  CPUs, stale scheduling state carried into a task's next scheduler, and
  uneven CPU shards with partially populated SMT cores.

The branch merged mainline once, for a BPF dependency of a tools/sched_ext
header sync that is yet to be applied.

----------------------------------------------------------------
Andrea Righi (1):
      sched_ext: Avoid unnecessary IMMED reenqueues on idle CPUs

Kang Chen (1):
      sched_ext: make DSQ iterator stay drained after NULL

Kuba Piecuch (1):
      sched_ext: Read exit_kind before flushing in scx_flush_disable_work()

Rahad Bhuiya (1):
      sched_ext: Reset task fields on exit of an SCX_TASK_READY task

Shubhang Kaushik (Ampere) (1):
      sched_ext: Reject scx_bpf_destroy_dsq() in tracing programs

Tao Cui (1):
      sched_ext: Reject DSQ iterator kfuncs in tracing programs

Tejun Heo (6):
      sched_ext: Merge branch 'master' into for-7.4-fixes
      sched_ext: Fix scx_bpf_dsq_reenq() kerneldoc claiming NMI calls are allowed
      sched_ext: Call ops.sub_attach() only while the cgroup is online
      sched_ext: Fix stale pick when the donor changes during dispatch
      sched_ext: Factor out drain_offline_rq()
      sched_ext: Fix ops.enqueue/dispatch() calls before ops.cpu_online()

Zhang Qiao (1):
      sched_ext: Fix partial-SMT core counting in calc_shard_layout()

 kernel/sched/ext/cid.c      |   8 ++-
 kernel/sched/ext/ext.c      | 160 ++++++++++++++++++++++++++++++--------------
 kernel/sched/ext/inlines.h  |  39 +++++++++--
 kernel/sched/ext/internal.h |   4 ++
 kernel/sched/ext/sub.c      |  22 ++++--
 kernel/sched/sched.h        |  17 ++---
 6 files changed, 183 insertions(+), 67 deletions(-)

-- 
tejun
