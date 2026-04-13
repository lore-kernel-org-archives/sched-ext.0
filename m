Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC911ACEDF;
	Mon, 13 Apr 2026 03:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776051054; cv=none; b=X1yIPQbMUsXBeJ6gEGQjWSiLftCfwP7mroNMags+5gxkd2TGps6/b2rLPFMqT26hGGuAHuhzKzH0TTI8EYLszyY3I5yrJyznHg1O6VMrTV+eMAyhLTsGNqnGol2k2bFEBPYz7T/5wXSsy8UuoFPBXTp5Z1ToMb3Fu73kL6J+AD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776051054; c=relaxed/simple;
	bh=YL3vR9Hu9PP8IDMf4DUizFbBFeDrctGrSeMUfk9ZJuQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ni7JOL8tw6RumFRMwPzG4YGfcA0tN+FS3yueJWdH2H8SqzAHylVxM3BB2OqiJtu2i7sAuU4VWhSw0T3jCnJvUxCDkqQWziuxB7BgRk0PLtQJFuGdJd9oQxhpkpsMh3yQPA/legJqKFfzJEgjVkIOGxivzGYgjZ2+VickaTBUKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVsMka+v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVsMka+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F9FC116C6;
	Mon, 13 Apr 2026 03:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776051053;
	bh=YL3vR9Hu9PP8IDMf4DUizFbBFeDrctGrSeMUfk9ZJuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVsMka+vnp6vjZKQV2hzE5tBPFjYlxfoWYqOCTe55Umo2QApKYhEznKnykaudAKO+
	 ZUC3FhPlY8J+tpzfNXu3P1zmdPZfclZemroYeCIXvQnx48XHUfAdgO9VIoOQ4wmpPV
	 /oRkbHOzce4H7rnXxFLyIQuxhYOUmqCV+e2ziK1j7c5iCTr6qPkMOoqbQqOgaoAh5v
	 m5fYAiS3ALlXkq7l36kV//fHgn45c4N0fMpHPS1PbrUy8riaLatnO6P0h+pviqPvDH
	 HJZPQIUkXeWDCtFCB6EveQ+d2YCiVmt+p4xyKwFmbr5aFFv+lHEyYSi0/OmA+uggi2
	 G3CgQn2zOA3QQ==
Date: Sun, 12 Apr 2026 17:30:52 -1000
Message-ID: <9e172bda49dade833db7118929332693@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1] tools/sched_ext: Kick home CPU for
 stranded tasks in scx_qmap
In-Reply-To: <de52a1c5537e2a130d19eb244b7606c1@kernel.org>
References: <de52a1c5537e2a130d19eb244b7606c1@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_qmap uses global BPF queue maps (BPF_MAP_TYPE_QUEUE) that any CPU's
ops.dispatch() can pop from. When a CPU pops a task that can't run on it
(e.g. a pinned per-CPU kthread), it inserts the task into SHARED_DSQ.
consume_dispatch_q() then skips the task due to affinity mismatch, leaving it
stranded until some CPU in its allowed mask calls ops.dispatch(). This doesn't
cause indefinite stalls -- the periodic tick keeps firing (can_stop_idle_tick()
returns false when softirq is pending) -- but can cause noticeable scheduling
delays.

After inserting to SHARED_DSQ, kick the task's home CPU if this CPU can't run
it. There's a small race window where the home CPU can enter idle before the
kick lands -- if a per-CPU kthread like ksoftirqd is the stranded task, this
can trigger a "NOHZ tick-stop error" warning. The kick arrives shortly after
and the home CPU drains the task.

Rather than fully eliminating the warning by routing pinned tasks to local or
global DSQs, the current code keeps them going through the normal BPF queue
path and documents the race and the resulting warning in detail. scx_qmap is an
example scheduler and having tasks go through the usual dispatch path is useful
for testing. The detailed comment also serves as a reference for other
schedulers that may encounter similar warnings.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
v2: Replaced the previous enqueue-side fix which kicked when a pinned task was
    enqueued. That was based on the theory that ops.select_cpu() being skipped
    meant the home CPU wouldn't be woken, which wasn't quite right --
    wakeup_preempt() kicks the target CPU regardless. Moved the fix to
    ops.dispatch() where the stranding is actually observable.

 tools/sched_ext/scx_qmap.bpf.c | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index f3587fb709c9..a4543c7ab25d 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -471,6 +471,46 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 			__sync_fetch_and_add(&nr_dispatched, 1);

 			scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, 0);
+
+			/*
+			 * scx_qmap uses a global BPF queue that any CPU's
+			 * dispatch can pop from. If this CPU popped a task that
+			 * can't run here, it gets stranded on SHARED_DSQ after
+			 * consume_dispatch_q() skips it. Kick the task's home
+			 * CPU so it drains SHARED_DSQ.
+			 *
+			 * There's a race between the pop and the flush of the
+			 * buffered dsq_insert:
+			 *
+			 *  CPU 0 (dispatching)      CPU 1 (home, idle)
+			 *  ~~~~~~~~~~~~~~~~~~~      ~~~~~~~~~~~~~~~~~~~
+			 *  pop from BPF queue
+			 *  dsq_insert(buffered)
+			 *                           balance:
+			 *                             SHARED_DSQ empty
+			 *                             BPF queue empty
+			 *                             -> goes idle
+			 *  flush -> on SHARED
+			 *  kick CPU 1
+			 *                           wakes, drains task
+			 *
+			 * The kick prevents indefinite stalls but a per-CPU
+			 * kthread like ksoftirqd can be briefly stranded when
+			 * its home CPU enters idle with softirq pending,
+			 * triggering:
+			 *
+			 *  "NOHZ tick-stop error: local softirq work is pending, handler #N!!!"
+			 *
+			 * from report_idle_softirq(). The kick lands shortly
+			 * after and the home CPU drains the task. This could be
+			 * avoided by e.g. dispatching pinned tasks to local or
+			 * global DSQs, but the current code is left as-is to
+			 * document this class of issue -- other schedulers
+			 * seeing similar warnings can use this as a reference.
+			 */
+			if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
+				scx_bpf_kick_cpu(scx_bpf_task_cpu(p), 0);
+
 			bpf_task_release(p);

 			batch--;
--
2.53.0
