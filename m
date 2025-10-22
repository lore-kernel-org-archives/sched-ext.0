Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08850302173;
	Wed, 22 Oct 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166593; cv=none; b=NWUxjnezddTDl95AlTG4j8O0FtMbFhXaqktQZuzNEj0Jqr8DeEFJhU7vliCT124k/E3JIQ9144wJILw2zy6e4W6h01TdFdlZkn5vfei1ZhEneFMld4LZzPZcaQLF81LEVs1g2uPW/gHUxe3jqGYFJKkIP5fb41NMyvoyk5CmbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166593; c=relaxed/simple;
	bh=wiFsAGfPQZS6AbrzF3ZX5VDhSPVim2QDxPty3IbTSkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pihuGDYQTNAPHQeX98Yhs+S4xRav9Shb6nPSp0lXFWV2EGN0hbKzEsyWE9Fa1lgXik6w3fmYi78dMJHoNQm4G0Y6UJ2NPfu5mMQNiYbRK2Yf1xTi9mp7WqMOgbYLWs5KHlHr+S3zvEG6iXF5ZmX+7CBnmwERY0ZgEEV2mabzfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSUSz/Vp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSUSz/Vp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81920C4CEE7;
	Wed, 22 Oct 2025 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761166592;
	bh=wiFsAGfPQZS6AbrzF3ZX5VDhSPVim2QDxPty3IbTSkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSUSz/VpzZzpZ+iteTpRRScwwTsIIyjPk3PAEMUxvz7O7YEixzOKQyTzgslbXss2p
	 wfRF0Zazp6i2Ba+dsY8k4Z/CHfHLKxTfn45fCHe8fGPsj3X+1Y/pmFJoanIadPglN+
	 fwfWtSJd0rMKefYQD7v2xavPAZt3n1cONpQFI92rAf9c35TC14nHudvFsoKLsIIBF3
	 DEBLMzuvdoeJSUPSQXlQXKdzWv71xIMBNBaHiD0D2FkBukZ192gNiw37kJjkdgj0Io
	 QjynxEXbYAb+DQrWxU6ovcEAwc9PfaleXyisjIKUaCC4dZKans2/Zfhp29UwuAeNnO
	 h3lfjNUL59nWg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	peterz@infradead.org,
	Tejun Heo <tj@kernel.org>,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: [PATCH RESEND v2 2/3] sched_ext: Fix SCX_KICK_WAIT to work reliably
Date: Wed, 22 Oct 2025 10:56:28 -1000
Message-ID: <20251022205629.845930-3-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251022205629.845930-1-tj@kernel.org>
References: <20251022205629.845930-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 46 +++++++++++++++++++++----------------
 kernel/sched/ext_internal.h |  6 +++--
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7db43a14a6fc..3f87f3d31ccd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2260,12 +2260,6 @@ static void switch_class(struct rq *rq, struct task_struct *next)
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
 
@@ -2305,6 +2299,10 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			      struct task_struct *next)
 {
 	struct scx_sched *sch = scx_root;
+
+	/* see kick_cpus_irq_workfn() */
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
@@ -2358,6 +2356,9 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf)
 	bool keep_prev, kick_idle = false;
 	struct task_struct *p;
 
+	/* see kick_cpus_irq_workfn() */
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+
 	rq_modified_clear(rq);
 
 	rq_unpin_lock(rq, rf);
@@ -5144,8 +5145,12 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *pseqs)
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
@@ -5206,18 +5211,19 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
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
index 87e5e22bfade..21c0ccaf9c71 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -997,8 +997,10 @@ enum scx_kick_flags {
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
2.47.1

