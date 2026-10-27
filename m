Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060273;
	b=T1On+zHwZmYBq2b9/9tzjnok7t2tCDF3YZPFQyVd3/xwccZKzDlwMgHp6SqmbvOdgSJL
	 kOaeqC99gpoIIN6HVXEPnojRArZuOPUVcfrXm4ZHf1QyOReHi7fyaAIrP5+MFUv+AC/9P
	 v4NCTJZV1Jorr409k4LwmgoQXI5o9Gc65GWb9NerWRtUnyJBK6zBYCQ5L2Ofh7TWWlUnJ
	 zERyXbLC/sX/C7J5Ww0+/LIadqbJ6vQL/5Tytgp8LLm3ukTaLKcqGiOjwdLr1L0kKks/x
	 eoWv9yxAUwRszn1M1rvNLqLGA5akVZKbG8JJ5ezbF0+q1dxZeB/Oz9OjnmL7SLmLvhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060273;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WIIR/IdFFOatmXFPLgDLDbzqyHXY2e/vmad0PcTIILM=;
	b=eJ/xmiy2GA2S2nu8vgneLbZ2IIuvskRqGjL0R/HJqw1a4rhChnoQZyjjzB2enNd1ZlbB
	 0gHdsoi+TfVnCoy3GZE4zlAlRkK+ADs8r62IvtMle7GfR3jCyOSuGIcqvklQH90PWqYvY
	 otujg8pDz205ap9emq+k4P9yPHyy03JhcTebUCTix9jt0N+5Als29CLaNCdFTKo+h0r2C
	 Du4v7zgDZ0MdboJ4SqbAtqu4TpDAicFxQsE+vPSZVMo1rxx7R+HAdc8PvuKaY7w72Nkmf
	 eOouKtRvlbM90P+kAWHdLADNti/ZT2MY8NqcuOTWKiqxd2o9Jsp62DABFDp2o+4kA2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1t7Cx35;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CD606A335;
	Tue, 27 Oct 2026 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1t7Cx35
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3C11F01825;
	Tue, 27 Oct 2026 00:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060273;
	bh=WIIR/IdFFOatmXFPLgDLDbzqyHXY2e/vmad0PcTIILM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N1t7Cx35ysDUmQzR/B746YG/U0wcsmnZOEm9IQ2mHu5oROPErvCEhxRiDBCB/RG2q
	 8x7HweLkcL2Y/Q5uIVEYW/ssFAwaAuCxHluMCZ/ySSeMec64rba6i0jJk2LoMT/hXl
	 HUkbfzxD+T8hIJ2kCPwjnkd/qIY0fCsBqZiUuTtjQoUFm+xPOgHgcUUKpNtFzbl9mQ
	 5d0Ko4v78I2K6XWLxe43Y7MiheMmJW2SCn9mfTVK2w9qPO7lfOVouVpGLxDBY3i+Qi
	 SkDTeSoNDkjn2F6OgtK1SLMWTPrsFOTsmDp3fJGvHYLGvcV4u0pEMdZDhofSgyF0om
	 9zuEshcymx0ug==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 03/18] sched_ext: Fix bypassed tasks stranded by the reenqueue limit
Date: Mon, 26 Oct 2026 14:17:34 -1000
Message-ID: <20261027001749.1821379-4-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
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

scx_do_enqueue_task() counts a task's reenqueues until the task runs. Past
SCX_REENQ_MAX_REPEAT it ejects the owning scheduler and leaves the task off
every DSQ for the scheduler's exit to requeue. The count comes before the
bypass test, so it also counts the reenqueues of a task whose scheduler is
bypassing.

Those reenqueues are not the scheduler's placements, and ejecting the
scheduler for them fixes nothing. Under bypass the kernel queues the
scheduler's tasks on the bypass DSQs. A host calling
scx_bpf_reenqueue_local() reenqueues a bypassed child's tasks on the cpu's
local DSQ along with its own, and the reject drain reenqueues a consumed
task that a cap check rejected.

In the following patches, the consume itself reenqueues a task it can't run
right away, and the bypass load balancer reenqueues a task at its home.

The count is reset only when the task runs or leaves sched_ext, so an
ejection can lead to a stranding the exit does not recover:

 1. the task's reenqueues pass the limit, which ejects its scheduler and
    strands the task
 2. the exit's scx_bypass() cycles the task through dequeue and enqueue,
    which requeues it on a bypass DSQ with the count still past the limit
 3. the task's next reenqueue under bypass strands it again
 4. scx_bypass() requeues stranded tasks only when the scheduler wasn't
    bypassing yet, so the task stays off every DSQ until the disable walks
    the tasks
 5. the disable takes scx_enable_mutex, the cgroup lock and scx_fork_rwsem
    before the walk, and a sub-scheduler's disable the cpu hotplug lock too.
    It hangs if the stranded task holds one of them, forking, attaching to a
    cgroup or doing a cpu hotplug

Test bypass before the count. A task reenqueued under bypass stays queued
until a later dispatch or balancer pass, so there is no tight loop to bound,
and the task's first run resets the count. The offline test moves up with it
to stay ahead of the bypass test. A reenqueue on an offline cpu goes to the
local DSQ and isn't counted either.

A host that keeps calling scx_bpf_reenqueue_local() could get a bypassed
child ejected, as the child's tasks on the local DSQ counted against the
child. The reenqueues are the host's, and its own tasks still count against
it.

v2: The description lists the cpu hotplug lock among the locks a
sub-scheduler's disable takes before the walk.

Fixes: 7706d6e4f2e3 ("sched_ext: Bound per-task reenqueues and eject the owning scheduler")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 0c0046766542..5d872a155800 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2216,11 +2216,31 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	p->scx.flags &= ~SCX_TASK_IMMED;
 
+	/*
+	 * If !scx_rq_online(), we already told the BPF scheduler that the CPU
+	 * is offline and are just running the hotplug path. Don't bother the
+	 * BPF scheduler.
+	 */
+	if (!scx_rq_online(rq))
+		goto local;
+
+	if (scx_bypassing(sch, cpu_of(rq))) {
+		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
+		goto bypass;
+	}
+
 	/*
 	 * A task reenqueued too many times without running means the scheduler
 	 * keeps re-deciding a placement it can't honor, e.g. re-inserting to a
 	 * cid it lacks caps on. Eject the owning scheduler and strand the task
 	 * to be picked up during sched exit.
+	 *
+	 * Bypass guarantees that every runnable task keeps running, and the
+	 * disable relies on that to take sleeping locks. The kernel places the
+	 * tasks of a bypassing scheduler and those on an offline rq, and
+	 * counting their reenqueues could strand a task under bypass and
+	 * deadlock the disable on a lock the task holds, so both tests stay
+	 * above the count.
 	 */
 	if (enq_flags & SCX_ENQ_REENQ) {
 		if (++p->scx.reenq_cnt > 1)
@@ -2234,19 +2254,6 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 		}
 	}
 
-	/*
-	 * If !scx_rq_online(), we already told the BPF scheduler that the CPU
-	 * is offline and are just running the hotplug path. Don't bother the
-	 * BPF scheduler.
-	 */
-	if (!scx_rq_online(rq))
-		goto local;
-
-	if (scx_bypassing(sch, cpu_of(rq))) {
-		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
-		goto bypass;
-	}
-
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
 
@@ -4993,7 +5000,8 @@ static void process_ddsp_deferred_locals(struct rq *rq)
  * %SCX_TASK_REENQ_IMMED. If the BPF scheduler dispatches back to the same local
  * DSQ with %SCX_ENQ_IMMED while the CPU is still unavailable, this triggers
  * another reenq cycle. Repetitions are bounded by %SCX_REENQ_MAX_REPEAT in
- * scx_do_enqueue_task(), which ejects the task's owning scheduler.
+ * scx_do_enqueue_task(), which ejects the task's owning scheduler. A bypassing
+ * scheduler's tasks are placed by the kernel instead and are not counted.
  */
 static bool local_task_should_reenq(struct rq *rq, struct task_struct *p,
 				    u64 *reenq_flags, u32 *reason)
@@ -5288,7 +5296,8 @@ static void process_deferred_reenq_users(struct rq *rq)
  *
  * A task can be re-rejected repeatedly. Reenqueues are bounded per task by
  * SCX_REENQ_MAX_REPEAT in scx_do_enqueue_task(), which ejects the owning
- * scheduler.
+ * scheduler. A bypassing scheduler's tasks are placed by the kernel instead and
+ * are not counted.
  */
 static void scx_reenq_reject(struct rq *rq)
 {
-- 
2.56.0

