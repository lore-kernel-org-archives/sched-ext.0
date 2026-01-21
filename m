Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AD428849;
	Wed, 21 Jan 2026 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037122; cv=none; b=j7//vKIBGWk+lWQNgUM7zjk5mFZdmeOEmxYwfkFAb5ZIo4cdJRsE47cf2jAmxKxIn76S7UDC7XX2mqMZCMNKSrwbQvuAmHt0drOUGPnE5elCEBFUZ+4Z3wpvZ4kQpMEgXhCYrDaWGo1UQ6GaeuueazQ4e8hPy3wqIZUMsLEGL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037122; c=relaxed/simple;
	bh=7istRQeuqEPRS8JysbcdHcM6bXt0mnZvfQWt28IOPgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSbx1qYqqSAAc0XsKiCoTfCjGHby9+4T2HRo0ogQJAu+qab1bh4D43wyknmzGew9N9brA44hqCDr4IZb+vQJaYhQqbVTF5Qbj3m6IKay4kc1hDxUuGWCDvc75P4kxfbUeVg/VcPrfNTChd1PXUGuPHnzvJ+2Vv61tgb5lvKQHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHCZ/SEq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHCZ/SEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA64C19425;
	Wed, 21 Jan 2026 23:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037121;
	bh=7istRQeuqEPRS8JysbcdHcM6bXt0mnZvfQWt28IOPgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHCZ/SEqSCx6GBA3vtkq1Ue8Kz+mxh5+Mb4erDfSQ604wuyaFYqMqb1wymnLbpGj9
	 GcqpCewS/7p5G/XlqHMZD1seEi6WS9jCW1Ukx1jn3FsA9/y+zwJ6I0eaPaAdef4vAs
	 wBINuRdh64YYNzMG1Be4yRiCBEBWgqUvw94E6gSJmizOculxiVxYkt7WlFneVb5G9D
	 5GTX/AR8nOdxzxhYCoXyL2vQ8P5m7qpI2ReUy+p9nK+D3P05YAoxrmqm9kKmRQT6oi
	 g9SvQSVU2tzk7rnhMwny4onEN76k9P8P/RdhO5JWdsssVl3vjaypOQ49uTYuCSG+od
	 wjT+7nXd2v1qg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 19/34] sched_ext: Prepare bypass mode for hierarchical operation
Date: Wed, 21 Jan 2026 13:11:25 -1000
Message-ID: <20260121231140.832332-20-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bypass mode is used to simplify enable and disable paths and guarantee
forward progress when something goes wrong. When enabled, all tasks skip BPF
scheduling and fall back to simple in-kernel FIFO scheduling. While this
global behavior can be used as-is when dealing with sub-scheds, that would
allow any sub-sched instance to affect the whole system in a significantly
disruptive manner.

Make bypass state hierarchical by propagating it to descendants and updating
per-cpu flags accordingly. This allows an scx_sched to bypass if itself or
any of its ancestors are in bypass mode. However, this doesn't make the
actual bypass enqueue and dispatch paths hierarchical yet. That will be done
in later patches.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 85 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ed7eee4907f9..42b177585972 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -41,6 +41,7 @@ static DEFINE_MUTEX(scx_enable_mutex);
 DEFINE_STATIC_KEY_FALSE(__scx_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
+static DEFINE_RAW_SPINLOCK(scx_bypass_lock);
 static cpumask_var_t scx_bypass_lb_donee_cpumask;
 static cpumask_var_t scx_bypass_lb_resched_cpumask;
 static bool scx_init_task_enabled;
@@ -4204,6 +4205,36 @@ static void scx_bypass_lb_timerfn(struct timer_list *timer)
 		mod_timer(timer, jiffies + usecs_to_jiffies(intv_us));
 }
 
+static bool inc_bypass_depth(struct scx_sched *sch)
+{
+	lockdep_assert_held(&scx_bypass_lock);
+
+	WARN_ON_ONCE(sch->bypass_depth < 0);
+	WRITE_ONCE(sch->bypass_depth, sch->bypass_depth + 1);
+	if (sch->bypass_depth != 1)
+		return false;
+
+	WRITE_ONCE(sch->slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
+	sch->bypass_timestamp = ktime_get_ns();
+	scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
+	return true;
+}
+
+static bool dec_bypass_depth(struct scx_sched *sch)
+{
+	lockdep_assert_held(&scx_bypass_lock);
+
+	WARN_ON_ONCE(sch->bypass_depth < 1);
+	WRITE_ONCE(sch->bypass_depth, sch->bypass_depth - 1);
+	if (sch->bypass_depth != 0)
+		return false;
+
+	WRITE_ONCE(sch->slice_dfl, SCX_SLICE_DFL);
+	scx_add_event(sch, SCX_EV_BYPASS_DURATION,
+		      ktime_get_ns() - sch->bypass_timestamp);
+	return true;
+}
+
 /**
  * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
  * @sch: sched to bypass
@@ -4238,22 +4269,17 @@ static void scx_bypass_lb_timerfn(struct timer_list *timer)
  */
 static void scx_bypass(struct scx_sched *sch, bool bypass)
 {
-	static DEFINE_RAW_SPINLOCK(bypass_lock);
+	struct scx_sched *pos;
 	unsigned long flags;
 	int cpu;
 
-	raw_spin_lock_irqsave(&bypass_lock, flags);
+	raw_spin_lock_irqsave(&scx_bypass_lock, flags);
 
 	if (bypass) {
 		u32 intv_us;
 
-		WRITE_ONCE(sch->bypass_depth, sch->bypass_depth + 1);
-		WARN_ON_ONCE(sch->bypass_depth <= 0);
-		if (sch->bypass_depth != 1)
+		if (!inc_bypass_depth(sch))
 			goto unlock;
-		WRITE_ONCE(sch->slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
-		sch->bypass_timestamp = ktime_get_ns();
-		scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
 
 		intv_us = READ_ONCE(scx_bypass_lb_intv_us);
 		if (intv_us && !timer_pending(&sch->bypass_lb_timer)) {
@@ -4262,15 +4288,25 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 			add_timer_global(&sch->bypass_lb_timer);
 		}
 	} else {
-		WRITE_ONCE(sch->bypass_depth, sch->bypass_depth - 1);
-		WARN_ON_ONCE(sch->bypass_depth < 0);
-		if (sch->bypass_depth != 0)
+		if (!dec_bypass_depth(sch))
 			goto unlock;
-		WRITE_ONCE(sch->slice_dfl, SCX_SLICE_DFL);
-		scx_add_event(sch, SCX_EV_BYPASS_DURATION,
-			      ktime_get_ns() - sch->bypass_timestamp);
 	}
 
+	/*
+	 * Bypass state is propagated to all descendants - an scx_sched bypasses
+	 * if itself or any of its ancestors are in bypass mode.
+	 */
+	raw_spin_lock(&scx_sched_lock);
+	scx_for_each_descendant_pre(pos, sch) {
+		if (pos == sch)
+			continue;
+		if (bypass)
+			inc_bypass_depth(pos);
+		else
+			dec_bypass_depth(pos);
+	}
+	raw_spin_unlock(&scx_sched_lock);
+
 	/*
 	 * No task property is changing. We just need to make sure all currently
 	 * queued tasks are re-queued according to the new scx_bypassing()
@@ -4282,18 +4318,20 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 	 */
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
-		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 		struct task_struct *p, *n;
 
 		raw_spin_rq_lock(rq);
 
-		if (bypass) {
-			WARN_ON_ONCE(pcpu->flags & SCX_SCHED_PCPU_BYPASSING);
-			pcpu->flags |= SCX_SCHED_PCPU_BYPASSING;
-		} else {
-			WARN_ON_ONCE(!(pcpu->flags & SCX_SCHED_PCPU_BYPASSING));
-			pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
+		raw_spin_lock(&scx_sched_lock);
+		scx_for_each_descendant_pre(pos, sch) {
+			struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
+
+			if (pos->bypass_depth)
+				pcpu->flags |= SCX_SCHED_PCPU_BYPASSING;
+			else
+				pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
 		}
+		raw_spin_unlock(&scx_sched_lock);
 
 		/*
 		 * We need to guarantee that no tasks are on the BPF scheduler
@@ -4314,6 +4352,9 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		 */
 		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
 						 scx.runnable_node) {
+			if (!scx_is_descendant(scx_task_sched(p), sch))
+				continue;
+
 			/* cycling deq/enq is enough, see the function comment */
 			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
 				/* nothing */ ;
@@ -4328,7 +4369,7 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 	}
 
 unlock:
-	raw_spin_unlock_irqrestore(&bypass_lock, flags);
+	raw_spin_unlock_irqrestore(&scx_bypass_lock, flags);
 }
 
 static void free_exit_info(struct scx_exit_info *ei)
-- 
2.52.0

