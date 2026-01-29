Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644E3783A5
	for <sched-ext@lists.linux.dev>; Thu, 29 Jan 2026 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678767; cv=none; b=L2KkWk+W2bJoT8pok5ryQBIoN8eQjnHBI54B1TgzWanSQHLfxZipq6iqbUHt6teelh3kd57OL8RYSp6A4VtIVCEZKogxDa6JK2ZUXGU0h7BP+AAS97RmLgzBXBXys5BRQEMgIHgIEWGgMoVd37EpWHq7NWkQO5F02ChcXKtmIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678767; c=relaxed/simple;
	bh=BmIb9S0/2tcoL8kGs+4kMQvymt/6iFbYwRlAgQibhMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TFrbSfvmear15bUkqlIBu5EpYmg3i7FDUUqvnin7iTsTb7OnCDpBT+ueQf48u4Pke+brLDATE4LF0A/34FVaPw5sgbjrfYnWHjsa02zNSRvAt9dEVbYc0YcZIvEkJYI87VXtE6lp+m+lm0JCaQEhHxKQbw8l02mj6p3LFaRVH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484841516;
	Thu, 29 Jan 2026 01:25:59 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.33.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0FB033F73F;
	Thu, 29 Jan 2026 01:26:03 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org,
	tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	sched-ext@lists.linux.dev,
	Wen-Fang Liu <liuwenfang@honor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 2/2] sched_ext: Fix SCX_KICK_WAIT to work reliably
Date: Thu, 29 Jan 2026 09:25:46 +0000
Message-Id: <20260129092546.49128-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129092546.49128-1-christian.loehle@arm.com>
References: <20260129092546.49128-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

commit a379fa1e2cae15d7422b4eead83a6366f2f445cb upstream.

SCX_KICK_WAIT is used to synchronously wait for the target CPU to complete
a reschedule and can be used to implement operations like core scheduling.

This used to be implemented by scx_next_task_picked() incrementing pnt_seq,
which was always called when a CPU picks the next task to run, allowing
SCX_KICK_WAIT to reliably wait for the target CPU to enter the scheduler and
pick the next task.

However, commit b999e365c298 ("sched_ext: Replace scx_next_task_picked()
with switch_class()") replaced scx_next_task_picked() with the
switch_class() callback, which is only called when switching between sched
classes. This broke SCX_KICK_WAIT because pnt_seq would no longer be
reliably incremented unless the previous task was SCX and the next task was
not.

This fix leverages commit 4c95380701f5 ("sched/ext: Fold balance_scx() into
pick_task_scx()") which refactored the pick path making put_prev_task_scx()
the natural place to track task switches for SCX_KICK_WAIT. The fix moves
pnt_seq increment to put_prev_task_scx() and also increments it in
pick_task_scx() to handle cases where the same task is re-selected, whether
by BPF scheduler decision or slice refill. The semantics: If the current
task on the target CPU is SCX, SCX_KICK_WAIT waits until the CPU enters the
scheduling path. This provides sufficient guarantee for use cases like core
scheduling while keeping the operation self-contained within SCX.

v2: - Also increment pnt_seq in pick_task_scx() to handle same-task
      re-selection (Andrea Righi).
    - Use smp_cond_load_acquire() for the busy-wait loop for better
      architecture optimization (Peter Zijlstra).

Reported-by: Wen-Fang Liu <liuwenfang@honor.com>
Link: http://lkml.kernel.org/r/228ebd9e6ed3437996dffe15735a9caa@honor.com
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c          | 46 +++++++++++++++++++++----------------
 kernel/sched/ext_internal.h |  6 +++--
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3d53b2232937..2ff7034841c7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2306,12 +2306,6 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 	struct scx_sched *sch = scx_root;
 	const struct sched_class *next_class = next->sched_class;
 
-	/*
-	 * Pairs with the smp_load_acquire() issued by a CPU in
-	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
-	 * resched.
-	 */
-	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
 	if (!(sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT))
 		return;
 
@@ -2351,6 +2345,10 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			      struct task_struct *next)
 {
 	struct scx_sched *sch = scx_root;
+
+	/* see kick_cpus_irq_workfn() */
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
@@ -2404,6 +2402,9 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 	bool keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
 	bool kick_idle = false;
 
+	/* see kick_cpus_irq_workfn() */
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+
 	/*
 	 * WORKAROUND:
 	 *
@@ -5186,8 +5187,12 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *pseqs)
 		}
 
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_wait)) {
-			pseqs[cpu] = rq->scx.pnt_seq;
-			should_wait = true;
+			if (cur_class == &ext_sched_class) {
+				pseqs[cpu] = rq->scx.pnt_seq;
+				should_wait = true;
+			} else {
+				cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
+			}
 		}
 
 		resched_curr(rq);
@@ -5248,18 +5253,19 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 	for_each_cpu(cpu, this_scx->cpus_to_wait) {
 		unsigned long *wait_pnt_seq = &cpu_rq(cpu)->scx.pnt_seq;
 
-		if (cpu != cpu_of(this_rq)) {
-			/*
-			 * Pairs with smp_store_release() issued by this CPU in
-			 * switch_class() on the resched path.
-			 *
-			 * We busy-wait here to guarantee that no other task can
-			 * be scheduled on our core before the target CPU has
-			 * entered the resched path.
-			 */
-			while (smp_load_acquire(wait_pnt_seq) == pseqs[cpu])
-				cpu_relax();
-		}
+		/*
+		 * Busy-wait until the task running at the time of kicking is no
+		 * longer running. This can be used to implement e.g. core
+		 * scheduling.
+		 *
+		 * smp_cond_load_acquire() pairs with store_releases in
+		 * pick_task_scx() and put_prev_task_scx(). The former breaks
+		 * the wait if SCX's scheduling path is entered even if the same
+		 * task is picked subsequently. The latter is necessary to break
+		 * the wait when $cpu is taken by a higher sched class.
+		 */
+		if (cpu != cpu_of(this_rq))
+			smp_cond_load_acquire(wait_pnt_seq, VAL != pseqs[cpu]);
 
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
 	}
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b3617abed510..601cfae8cc76 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -986,8 +986,10 @@ enum scx_kick_flags {
 	SCX_KICK_PREEMPT	= 1LLU << 1,
 
 	/*
-	 * Wait for the CPU to be rescheduled. The scx_bpf_kick_cpu() call will
-	 * return after the target CPU finishes picking the next task.
+	 * The scx_bpf_kick_cpu() call will return after the current SCX task of
+	 * the target CPU switches out. This can be used to implement e.g. core
+	 * scheduling. This has no effect if the current task on the target CPU
+	 * is not on SCX.
 	 */
 	SCX_KICK_WAIT		= 1LLU << 2,
 };
-- 
2.34.1

