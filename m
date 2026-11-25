Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602861;
	b=ztyh7HfBHyws8qQnSRDgZz63dE9c2rUY5ZawYrTolkDh5soE1XHdFSgLm2CKqAz5V9qo
	 Nu0uErJ9INL8XMXfOTI+KmMLz6lADO5nEx60DmfbcU/2v3tU/XkzjO3g/hO4UzL6mFM/P
	 KV0A57MYn7HyW8rkjLVk/D3D+bll0Zemt50422pcw8YUzJyL8ZeiZ2Xf+8c5tv22/KEzV
	 tYZ6/a19p2EfvIr9yz9o2UZOlTgyljobg4tL92AYxz6l2PUM4IVqnfgofYhBlLetXP+vC
	 Nt5/XhK8RJDeYoGlZ8MswR+uIyIQ5qTdLBHtvwFwkVbjLRRFNLAbsnzIRmyWTZOYHSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602861;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fcsJFJcknRlZ/8YDPikO/bwZDWpsgo0DLELzH4UzPU0=;
	b=0TnHPdoPp90HYCtfUHGQtYGX3xaJwTBF5qBK2p/amsTOsnnrHhnKypqEtY/BtdFaanm2
	 SB20SfKxh7l+N1Nxmfrv6eknHslUa1SAMyQfY1aXAQYT/PwhNZtouAG0zYqg2cn2I8M9X
	 WYTnwRQdS3SlYTyAHnnHxPWsouQE7sk84vNCmyCqCS3DbWZ4J2J4/EqeWciKWeWVnsEnt
	 jJWBk2Pj36Gv4yER/UvvpfRbssoIe0wDlVmo/EnS1VMFKIbw4G+dJpAuGGTCYBtedGlOi
	 YCAzmwVfSiq2sN5WxKfaNcZBF9dA4oGrhNhf/OpCgxCoZUctkad8D1y9cDSWAzXmtZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ngon4NJX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97418606A32A;
	Wed, 25 Nov 2026 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ngon4NJX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A58B1F0156E;
	Wed, 25 Nov 2026 10:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795602861;
	bh=fcsJFJcknRlZ/8YDPikO/bwZDWpsgo0DLELzH4UzPU0=;
	h=From:To:Cc:Subject:Date;
	b=Ngon4NJX3MUGRgLCnMvHJ7qWwKx/+k4qqIgY/SzWrK5W1UTjs3fG/Bj9l8bcZp0sz
	 vLui9WG+U+32MZxR73iYV3soymomox9VJ6dLE66agXAgYkXKfnN2y1NhI810hLUwnO
	 poMucdP08hKm+616FURO1SQzW0VssYAs02NOI6NykGKqJGZ+JbfEgxxe2D9jHBDxIa
	 xbHH/DIPuQE1c6zDhcgqlGxKAmdUzOCwU8HcdqX89wGHADNl6PIa3POnLj/C1n6w+v
	 gwqTx1dvVafYP69FaQ/bmVHr3MFvSacc64sg+liDMipaLeSKFwbT7ERgTKMbuJKkBL
	 VmZcXeouk15Pw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.5] sched_ext: Start ext_server from the tick
Date: Wed, 25 Nov 2026 00:34:18 -1000
Message-ID: <20261125103420.2785659-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.1
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

ext_server starts when the first task is enqueued on a CPU's rq and stops
when its pick finds no task. As the BPF scheduler can run a task on any CPU
whichever rq it is queued on, tasks can wait for a CPU whose ext_server has
stopped with no enqueue to start it again, and a higher class task which
keeps the CPU starves them until the watchdog fires. scx_central with a
SCHED_FIFO task spinning on a CPU shows it.

Peter pointed out the problem when ext_server was being added [1]. Hang's
recent patch which starts ext_server on every enqueue [2] helps but leaves
cases like the above.

This patchset also starts ext_server from the tick, while a higher class
task is running on the CPU:

- If the local DSQ has a task, right away. This covers a task which another
  CPU inserts after the pick came up empty.

- Otherwise, if any task is runnable on SCX, at most once a server period.
  Only ops.dispatch() can tell whether the BPF scheduler has a task for the
  CPU, and the server's pick calls it.

Whether any task is runnable comes from per-node counts of rqs which have
tasks, which a per-node timer lowers lazily, and a global count of such
nodes, which is all the tick reads.

This is a departure from how dl servers are usually driven and there may be
better ways to go about it, but it does seem to solve the problem properly
without adding much overhead.

With the patchset, a SCHED_EXT task sharing a CPU with a SCHED_FIFO hog gets
the server's share under both scx_simple and scx_central. The second patch
does the same from the remote tick for nohz_full CPUs.

Based on sched_ext/for-7.5 (cb31a095aab1).

This patchset contains the following 2 patches.

 0001 sched_ext: Start ext_server from the tick while a higher class holds the CPU
 0002 sched_ext: Start ext_server from the remote tick on nohz_full CPUs

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git ext-server-tick

diffstat follows. Thanks.

 kernel/sched/core.c      |   5 +-
 kernel/sched/ext/ext.c   | 174 ++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/ext/ext.h   |   4 ++
 kernel/sched/ext/types.h |   1 +
 kernel/sched/sched.h     |   2 +
 5 files changed, 182 insertions(+), 4 deletions(-)

[1] https://lore.kernel.org/r/20260202195035.GG1282955@noisy.programming.kicks-ass.net
[2] https://lore.kernel.org/r/20261123-scx-dlsrv-v1-2-87c342d8246e@gmail.com

--
tejun
