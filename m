Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9D283FDD;
	Thu, 27 Nov 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258497; cv=none; b=ZcLwd6DXS5tzWL2K0BgRTICHudrVI/iF9vKbZ0KAvYZO+TJ93GFgV0i11hLvYZYE3xED2UWYkHcT7LUMVMUXdIxJJwLg2n2e9BNMNa9WH4cScm42Du8M+uVuasQgLh6QjZmOJq5Gcp8Vd+CQWQNiDg6kvHAhkkj/3yiCGNtUbqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258497; c=relaxed/simple;
	bh=xmEqkC3YipgevIYMNw66YaEDxWzZ3PQOrWEalsnHLtU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LrQ8EqCrY5QQXFIRrQD9R7eiXUW6DGMa8kOnenruOJZ683wUlljygtKJsaDke/gD8vcKfAHgzXbINl88u7Ro32gQ4jQjY5zYKotSkuUqPXR3E6mIRrihBNPACX6ZsMhwEOF9ZJX821a0M3AELzytQfaPCfn8ILCNOucKZeo/u5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FrcriYB4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FrcriYB4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=4xyCKXDciurpk25f2SJLDqqyooNcBU/Lb7GEBZsLGXA=; b=FrcriYB4l+WDBZnhw3YdSytxSt
	Kp5xvXqLhRtp0s5trfTqMnXWzq5ZrhYFcy4xFQbNdwqro/999LjoGvNBubnh9Z8LkW2YF7zfkbJW/
	nMxariogP+dFCvAMdwTjg0UCONdgoYBif/AI5vQJF7l/MJ6UOdtFkA1VGFkCO5lo2c6UI2MVao9hZ
	zkT3Rhzgeb/r3A5LHP8htdDizI5FUU/I4XOGkYpZsh1GOEPTJqVxbeU3qN1zbFj5RQjt9j7WrvgUl
	KH4I/GeE2n/X/lmUwaCkg7VtKzdwSbckX94NG5K9kXb7xumnPIy41XU1NWW/h+Bw8WTtNdwyA5gBT
	VKIlR6UA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdMU-0000000AP21-2DO8;
	Thu, 27 Nov 2025 14:52:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id B8926302FD9; Thu, 27 Nov 2025 16:48:06 +0100 (CET)
Message-ID: <20251127154725.901391274@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 27 Nov 2025 16:39:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 sched-ext@lists.linux.dev
Subject: [PATCH 5/5] sched: Rework sched_class::wakeup_preempt() and rq_modified_*()
References: <20251127153943.696191429@infradead.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Change sched_class::wakeup_preempt() to also get called for
cross-class wakeups, specifically those where the woken task is of a
higher class than the previous highest class.

In order to do this, track the current highest class of the runqueue
in rq::next_class and have wakeup_preempt() track this upwards for
each new wakeup. Additionally have set_next_task() re-set the value to
the current class.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |   32 +++++++++++++++++++++++---------
 kernel/sched/deadline.c  |   14 +++++++++-----
 kernel/sched/ext.c       |    9 ++++-----
 kernel/sched/fair.c      |   17 ++++++++++-------
 kernel/sched/idle.c      |    3 ---
 kernel/sched/rt.c        |    9 ++++++---
 kernel/sched/sched.h     |   26 ++------------------------
 kernel/sched/stop_task.c |    3 ---
 8 files changed, 54 insertions(+), 59 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2090,7 +2090,6 @@ void enqueue_task(struct rq *rq, struct
 	 */
 	uclamp_rq_inc(rq, p, flags);
 
-	rq->queue_mask |= p->sched_class->queue_mask;
 	p->sched_class->enqueue_task(rq, p, flags);
 
 	psi_enqueue(p, flags);
@@ -2123,7 +2122,6 @@ inline bool dequeue_task(struct rq *rq,
 	 * and mark the task ->sched_delayed.
 	 */
 	uclamp_rq_dec(rq, p);
-	rq->queue_mask |= p->sched_class->queue_mask;
 	return p->sched_class->dequeue_task(rq, p, flags);
 }
 
@@ -2174,10 +2172,14 @@ void wakeup_preempt(struct rq *rq, struc
 {
 	struct task_struct *donor = rq->donor;
 
-	if (p->sched_class == donor->sched_class)
-		donor->sched_class->wakeup_preempt(rq, p, flags);
-	else if (sched_class_above(p->sched_class, donor->sched_class))
+	if (p->sched_class == rq->next_class) {
+		rq->next_class->wakeup_preempt(rq, p, flags);
+
+	} else if (sched_class_above(p->sched_class, rq->next_class)) {
+		rq->next_class->wakeup_preempt(rq, p, flags);
 		resched_curr(rq);
+		rq->next_class = p->sched_class;
+	}
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
@@ -6797,6 +6799,7 @@ static void __sched notrace __schedule(i
 pick_again:
 	next = pick_next_task(rq, rq->donor, &rf);
 	rq_set_donor(rq, next);
+	rq->next_class = next->sched_class;
 	if (unlikely(task_is_blocked(next))) {
 		next = find_proxy_task(rq, next, &rf);
 		if (!next)
@@ -8646,6 +8649,8 @@ void __init sched_init(void)
 		rq->rt.rt_runtime = global_rt_runtime();
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
+		rq->next_class = &idle_sched_class;
+
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
@@ -10771,10 +10776,8 @@ struct sched_change_ctx *sched_change_be
 		flags |= DEQUEUE_NOCLOCK;
 	}
 
-	if (flags & DEQUEUE_CLASS) {
-		if (p->sched_class->switching_from)
-			p->sched_class->switching_from(rq, p);
-	}
+	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
+		p->sched_class->switching_from(rq, p);
 
 	*ctx = (struct sched_change_ctx){
 		.p = p,
@@ -10827,6 +10830,17 @@ void sched_change_end(struct sched_chang
 			p->sched_class->switched_to(rq, p);
 
 		/*
+		 * If this was a class promotion; let the old class know it
+		 * got preempted. Note that none of the switch*_from() methods
+		 * know the new class and none of the switch*_to() methods
+		 * know the old class.
+		 */
+		if (ctx->running && sched_class_above(p->sched_class, ctx->class)) {
+			rq->next_class->wakeup_preempt(rq, p, 0);
+			rq->next_class = p->sched_class;
+		}
+
+		/*
 		 * If this was a degradation in class someone should have set
 		 * need_resched by now.
 		 */
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2499,9 +2499,16 @@ static int balance_dl(struct rq *rq, str
  * Only called when both the current and waking task are -deadline
  * tasks.
  */
-static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
-				  int flags)
+static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p, int flags)
 {
+	/*
+	 * Can only get preempted by stop-class, and those should be
+	 * few and short lived, doesn't really make sense to push
+	 * anything away for that.
+	 */
+	if (p->sched_class != &dl_sched_class)
+		return;
+
 	if (dl_entity_preempt(&p->dl, &rq->donor->dl)) {
 		resched_curr(rq);
 		return;
@@ -3304,9 +3311,6 @@ static int task_is_throttled_dl(struct t
 #endif
 
 DEFINE_SCHED_CLASS(dl) = {
-
-	.queue_mask		= 8,
-
 	.enqueue_task		= enqueue_task_dl,
 	.dequeue_task		= dequeue_task_dl,
 	.yield_task		= yield_task_dl,
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2338,12 +2338,12 @@ static struct task_struct *pick_task_scx
 	bool keep_prev, kick_idle = false;
 	struct task_struct *p;
 
-	rq_modified_clear(rq);
+	rq->next_class = &ext_sched_class;
 	rq_unpin_lock(rq, rf);
 	balance_one(rq, prev);
 	rq_repin_lock(rq, rf);
 	maybe_queue_balance_callback(rq);
-	if (rq_modified_above(rq, &ext_sched_class))
+	if (sched_class_above(rq->next_class, &ext_sched_class))
 		return RETRY_TASK;
 
 	keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
@@ -2967,7 +2967,8 @@ static void switched_from_scx(struct rq
 	scx_disable_task(p);
 }
 
-static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
+static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_flags) {}
+
 static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
 
 int scx_check_setscheduler(struct task_struct *p, int policy)
@@ -3216,8 +3217,6 @@ static void scx_cgroup_unlock(void) {}
  *   their current sched_class. Call them directly from sched core instead.
  */
 DEFINE_SCHED_CLASS(ext) = {
-	.queue_mask		= 1,
-
 	.enqueue_task		= enqueue_task_scx,
 	.dequeue_task		= dequeue_task_scx,
 	.yield_task		= yield_task_scx,
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8697,7 +8697,7 @@ preempt_sync(struct rq *rq, int wake_fla
 /*
  * Preempt the current task with a newly woken task if needed:
  */
-static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
+static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_flags)
 {
 	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_PICK;
 	struct task_struct *donor = rq->donor;
@@ -8705,6 +8705,12 @@ static void check_preempt_wakeup_fair(st
 	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
 
+	/*
+	 * XXX Getting preempted by higher class, try and find idle CPU?
+	 */
+	if (p->sched_class != &fair_sched_class)
+		return;
+
 	if (unlikely(se == pse))
 		return;
 
@@ -12872,7 +12878,7 @@ static int sched_balance_newidle(struct
 	t0 = sched_clock_cpu(this_cpu);
 	__sched_balance_update_blocked_averages(this_rq);
 
-	rq_modified_clear(this_rq);
+	this_rq->next_class = &fair_sched_class;
 	raw_spin_rq_unlock(this_rq);
 
 	for_each_domain(this_cpu, sd) {
@@ -12939,7 +12945,7 @@ static int sched_balance_newidle(struct
 		pulled_task = 1;
 
 	/* If a higher prio class was modified, restart the pick */
-	if (rq_modified_above(this_rq, &fair_sched_class))
+	if (sched_class_above(this_rq->next_class, &fair_sched_class))
 		pulled_task = -1;
 
 out:
@@ -13837,15 +13843,12 @@ static unsigned int get_rr_interval_fair
  * All the scheduling class methods:
  */
 DEFINE_SCHED_CLASS(fair) = {
-
-	.queue_mask		= 2,
-
 	.enqueue_task		= enqueue_task_fair,
 	.dequeue_task		= dequeue_task_fair,
 	.yield_task		= yield_task_fair,
 	.yield_to_task		= yield_to_task_fair,
 
-	.wakeup_preempt		= check_preempt_wakeup_fair,
+	.wakeup_preempt		= wakeup_preempt_fair,
 
 	.pick_task		= pick_task_fair,
 	.pick_next_task		= pick_next_task_fair,
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -534,9 +534,6 @@ static void update_curr_idle(struct rq *
  * Simple, special scheduling class for the per-CPU idle tasks:
  */
 DEFINE_SCHED_CLASS(idle) = {
-
-	.queue_mask		= 0,
-
 	/* no enqueue/yield_task for idle tasks */
 
 	/* dequeue is not valid, we print a debug message there: */
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1615,6 +1615,12 @@ static void wakeup_preempt_rt(struct rq
 {
 	struct task_struct *donor = rq->donor;
 
+	/*
+	 * XXX If we're preempted by DL, queue a push?
+	 */
+	if (p->sched_class != &rt_sched_class)
+		return;
+
 	if (p->prio < donor->prio) {
 		resched_curr(rq);
 		return;
@@ -2568,9 +2574,6 @@ static int task_is_throttled_rt(struct t
 #endif /* CONFIG_SCHED_CORE */
 
 DEFINE_SCHED_CLASS(rt) = {
-
-	.queue_mask		= 4,
-
 	.enqueue_task		= enqueue_task_rt,
 	.dequeue_task		= dequeue_task_rt,
 	.yield_task		= yield_task_rt,
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1119,7 +1119,6 @@ struct rq {
 	raw_spinlock_t		__lock;
 
 	/* Per class runqueue modification mask; bits in class order. */
-	unsigned int		queue_mask;
 	unsigned int		nr_running;
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
@@ -1179,6 +1178,7 @@ struct rq {
 	struct sched_dl_entity	*dl_server;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
+	const struct sched_class *next_class;
 	unsigned long		next_balance;
 	struct mm_struct	*prev_mm;
 
@@ -2426,15 +2426,6 @@ struct sched_class {
 #ifdef CONFIG_UCLAMP_TASK
 	int uclamp_enabled;
 #endif
-	/*
-	 * idle:  0
-	 * ext:   1
-	 * fair:  2
-	 * rt:    4
-	 * dl:    8
-	 * stop: 16
-	 */
-	unsigned int queue_mask;
 
 	/*
 	 * move_queued_task/activate_task/enqueue_task: rq->lock
@@ -2593,20 +2584,6 @@ struct sched_class {
 #endif
 };
 
-/*
- * Does not nest; only used around sched_class::pick_task() rq-lock-breaks.
- */
-static inline void rq_modified_clear(struct rq *rq)
-{
-	rq->queue_mask = 0;
-}
-
-static inline bool rq_modified_above(struct rq *rq, const struct sched_class * class)
-{
-	unsigned int mask = class->queue_mask;
-	return rq->queue_mask & ~((mask << 1) - 1);
-}
-
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
 	WARN_ON_ONCE(rq->donor != prev);
@@ -3899,6 +3876,7 @@ void move_queued_task_locked(struct rq *
 	deactivate_task(src_rq, task, 0);
 	set_task_cpu(task, dst_rq->cpu);
 	activate_task(dst_rq, task, 0);
+	wakeup_preempt(dst_rq, task, 0);
 }
 
 static inline
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -97,9 +97,6 @@ static void update_curr_stop(struct rq *
  * Simple, special scheduling class for the per-CPU stop tasks:
  */
 DEFINE_SCHED_CLASS(stop) = {
-
-	.queue_mask		= 16,
-
 	.enqueue_task		= enqueue_task_stop,
 	.dequeue_task		= dequeue_task_stop,
 	.yield_task		= yield_task_stop,


