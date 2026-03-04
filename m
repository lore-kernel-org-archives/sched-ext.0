Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C813909A8;
	Wed,  4 Mar 2026 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661701; cv=none; b=QXL0+lvLV1Xnxc0B6GP2UG0HFwux80lM0EISe7FExui1dcGDmWJLxWpit319vze/cLSb++Jh+AvRF46RxNB+dyq7XnR6VKp/n4/zVKP2OSyhODPoZH6ZtMxlnLubfTrHWUMo6rO37au3YpEh7TnR5H4id78oADdtDdm8itJQbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661701; c=relaxed/simple;
	bh=9P2quEF1UCZyex7DDojzU1vHyfOFFrs3ka9UDJRnxc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMtPRRQnCipFH8je2mqLa7uBlwkvLrWbHixkES4wCjBHACswN7sFnNgl/RIIRobowAZsLZA+tnwkggQRR7nj7agwgPnMmrqkeX2BCE7QI2LMk0gIwpXuY1NRY56ZQFv0DYpYLxZ1zOJmIeKOHZj688KuR7FUCIkIpt7vWpPa0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk1MetB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk1MetB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA6BC2BC86;
	Wed,  4 Mar 2026 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661700;
	bh=9P2quEF1UCZyex7DDojzU1vHyfOFFrs3ka9UDJRnxc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dk1MetB9av5E7MuoNr/OwSLL/ueKoPiGeUbG0AEeuq6eETjep5NMniDZWbeKsRkeo
	 yRpKVVtP1ZQaow0Z7+Ra+vIe/TClpOEIfDMTWy62nSL5ywG9JkW7tY4Yqj1n/5Skzq
	 g1/MWBFPzp6AjgDPTKjnGrQ7rc7Kc8BJNlrUpZ0J4e0tJ+UxnLqBvdQT0xgDdAoPD5
	 HWfBX8I2qxkSoYS2RIcpD20kaZC+J6sP1A8AdJDnXiO7NF2xbrpguI0m/mN94CYbYG
	 AAS3xbqQv/nI75W4LSa12M3htfDd4xDkhmFa3KgdPm6yN228v4YyvVHB8VBo8cZ3B7
	 vlfW5CE0mhs+g==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 19/34] sched_ext: Prepare bypass mode for hierarchical operation
Date: Wed,  4 Mar 2026 12:01:04 -1000
Message-ID: <20260304220119.4095551-20-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
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
index 8fc9ef9c3214..8d3fbb0a89d8 100644
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
@@ -4399,6 +4400,36 @@ static void scx_bypass_lb_timerfn(struct timer_list *timer)
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
@@ -4433,22 +4464,17 @@ static void scx_bypass_lb_timerfn(struct timer_list *timer)
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
@@ -4457,15 +4483,25 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
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
@@ -4477,18 +4513,20 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
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
@@ -4509,6 +4547,9 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		 */
 		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
 						 scx.runnable_node) {
+			if (!scx_is_descendant(scx_task_sched(p), sch))
+				continue;
+
 			/* cycling deq/enq is enough, see the function comment */
 			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
 				/* nothing */ ;
@@ -4523,7 +4564,7 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 	}
 
 unlock:
-	raw_spin_unlock_irqrestore(&bypass_lock, flags);
+	raw_spin_unlock_irqrestore(&scx_bypass_lock, flags);
 }
 
 static void free_exit_info(struct scx_exit_info *ei)
-- 
2.53.0

