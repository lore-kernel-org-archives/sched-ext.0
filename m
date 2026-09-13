Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90536BCD7
	for <sched-ext@lists.linux.dev>; Sun, 13 Sep 2026 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282108; cv=none; b=fwsaqVapFM+6RWG+zDDAJYvzCTkmE7Q3DepxBSiFlDM24xouQWN+Lv1PNoyhovHL9rwnoA+MFcidansN8iSGvKE5ggw/vKUPQFd7qkHvK59qloztRjifb6FkTA+vCbvA5BoHzG1uTskM9B9L/zdpcm7X9degG59kGm/8gZCIjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282108; c=relaxed/simple;
	bh=9mMiQOw8U0G19b+vr2PVHFWq5kT98PYpQA9pvwG21DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gg5EWUfRdJrWfXwNl7B7VhiQpx5ZU4V47jTho950OEhgM654PzhbuFJcFezOMF+hab/QY+uFQR7uvI0G/P9bW3MbKqtE7ZfnJQHywX5prX0lw7gsEE4DN5Vs6BFts2MmV8jZf7Dv8BHYGBF1rKADZF7TRC0nZ7dGoJ6lPedIM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HruOhVy9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HruOhVy9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mY
	k33ME0xBHs5d9qvvC1DwhqFT9RdVTw6xajF06W/BE=; b=HruOhVy9LG4klLTNcx
	shyz9Pk4Bc1qm2vMMWEns+yK7QLHQi8V2NPYHyHKXpoOSp1tRViUyPLvUaeq97sp
	LBFDvjMZE+fZJWTIrtCNOs9fBHr1ECxl3eNPKX4mgqdO6tPpdv3bmbnG3AEL/3cO
	jTx1zIye+N1XDk81mM5mg8xSI=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXKosCR6ZqNeXCPw--.41105S2;
	Sun, 13 Sep 2026 14:47:31 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: peterz@infradead.org,
	soolaugust@gmail.com,
	arighi@nvidia.com
Cc: mingo@redhat.com,
	kprateek.nayak@amd.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	connoro@google.com,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH v5 1/4] sched: Dispatch task ticks for donor and execution classes
Date: Sun, 13 Sep 2026 15:47:19 +0900
Message-ID: <20260913064722.1534766-2-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913064722.1534766-1-sh_def@163.com>
References: <20260913064722.1534766-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXKosCR6ZqNeXCPw--.41105S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3ur43Zr1ftFy8Jw1kKF4DArb_yoWDtFWDpF
	WDXasxGa1DJa1YgryxArWkZ3WfWwn3Xa4agFZ3tw4FkF15tr1FqF1qqF42vr45JrW0vFy2
	vrWq93y7Kr18G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UthL5UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6gMWdWqmRwMqkQAA35

Proxy execution can run a task from one scheduling class on behalf of a
donor from another. Scheduler ticks therefore need to reach both the class
which owns the scheduling context and the class which owns the execution
context.

Remove the task argument from sched_class::task_tick() and let each class
select the state it owns through the runqueue. Add a common task_tick()
dispatcher which calls the donor class first and, when proxy execution
splits the classes, the execution class afterwards.

Calling the donor first preserves the existing runtime-accounting order for
execution-context consumers. Keep the existing class-specific tick behavior
donor-gated in this patch, so the change only introduces the new interface
and dispatch mechanism.

In particular, keep task_tick_scx() explicitly gated on the donor class.
If the callback is reached only because the execution context belongs to
sched_ext while another class supplies the donor, it must not perform SCX
scheduling-context work. This aligns the dispatcher with the ownership
direction used by the pending sched_ext proxy-execution work. Full
sched_ext/proxy-execution integration is not enabled by the current
Kconfig; that accounting conversion remains outside this patch.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20260908104407.GD687043@noisy.programming.kicks-ass.net
Link: https://lore.kernel.org/r/aqGa0J1_LM99oDkP@gpd4
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/core.c      | 22 +++++++++++++++++++---
 kernel/sched/deadline.c  | 10 +++++++---
 kernel/sched/ext/ext.c   | 22 +++++++++++++++++-----
 kernel/sched/fair.c      | 25 +++++++++++++++----------
 kernel/sched/idle.c      |  8 ++++----
 kernel/sched/rt.c        | 13 +++++++++----
 kernel/sched/sched.h     |  2 +-
 kernel/sched/stop_task.c |  5 ++---
 8 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b998ef6b87af..05e599665fdd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -892,6 +892,22 @@ void update_rq_clock(struct rq *rq)
 	update_rq_clock_task(rq, delta);
 }
 
+/*
+ * Run the scheduling-context class first so its runtime update precedes
+ * execution-context tick work. A different execution class runs second.
+ * Same-class proxy execution gets one callback; ownership-specific work
+ * can select rq->donor or rq->curr as appropriate.
+ */
+static inline void task_tick(struct rq *rq, int queued)
+{
+	const struct sched_class *curr_class = rq->curr->sched_class;
+	const struct sched_class *donor_class = rq->donor->sched_class;
+
+	donor_class->task_tick(rq, queued);
+	if (sched_proxy_exec() && curr_class != donor_class)
+		curr_class->task_tick(rq, queued);
+}
+
 #ifdef CONFIG_SCHED_HRTICK
 /*
  * Use HR-timers to deliver accurate preemption points.
@@ -923,7 +939,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->donor->sched_class->task_tick(rq, rq->donor, 1);
+	task_tick(rq, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -5799,7 +5815,7 @@ void sched_tick(void)
 	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
 		resched_curr(rq);
 
-	donor->sched_class->task_tick(rq, donor, 0);
+	task_tick(rq, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
@@ -5895,7 +5911,7 @@ static void sched_tick_remote(struct work_struct *work)
 				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
 				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
 			}
-			curr->sched_class->task_tick(rq, curr, 0);
+			task_tick(rq, 0);
 
 			calc_load_nohz_remote(rq);
 		}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0663c00c41c0..da7613acab18 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2873,11 +2873,15 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_s
  *
  * NOTE: This function can be called remotely by the tick offload that
  * goes along full dynticks. Therefore no local assumption can be made
- * and everything must be accessed through the @rq and @curr passed in
- * parameters.
+ * and all state must be accessed through @rq.
  */
-static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
+static void task_tick_dl(struct rq *rq, int queued)
 {
+	struct task_struct *p = rq->donor;
+
+	if (p->sched_class != &dl_sched_class)
+		return;
+
 	update_curr_dl(rq);
 
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 1);
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 51de1d8b72a1..8c389852be6e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3789,9 +3789,21 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, int queued)
 {
-	struct scx_sched *sch = scx_task_sched(curr);
+	struct task_struct *donor = rq->donor;
+	struct scx_sched *sch;
+
+	/*
+	 * task_tick() may also invoke this callback as the execution class
+	 * after dispatching the donor class. SCX scheduling state belongs to
+	 * the scheduling context, so there is nothing to do here unless the
+	 * donor itself belongs to sched_ext.
+	 */
+	if (donor->sched_class != &ext_sched_class)
+		return;
+
+	sch = scx_task_sched(donor);
 
 	update_curr_scx(rq);
 
@@ -3800,11 +3812,11 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * management.
 	 */
 	if (scx_bypassing(sch, cpu_of(rq)))
-		scx_set_task_slice(curr, 0);
+		scx_set_task_slice(donor, 0);
 	else if (SCX_HAS_OP(sch, tick))
-		SCX_CALL_OP_TASK(sch, tick, rq, curr);
+		SCX_CALL_OP_TASK(sch, tick, rq, donor);
 
-	if (!curr->scx.slice)
+	if (!donor->scx.slice)
 		resched_curr(rq);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ade1eceb39b8..6f1777799371 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15057,12 +15057,17 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
  *
  * NOTE: This function can be called remotely by the tick offload that
  * goes along full dynticks. Therefore no local assumption can be made
- * and everything must be accessed through the @rq and @curr passed in
- * parameters.
+ * and all state must be accessed through @rq.
  */
-static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_fair(struct rq *rq, int queued)
 {
-	struct sched_entity *se = &curr->se;
+	struct task_struct *donor = rq->donor;
+	struct sched_entity *se;
+
+	if (donor->sched_class != &fair_sched_class)
+		return;
+
+	se = &donor->se;
 
 	if (se->on_rq) {
 		unsigned long weight = NICE_0_LOAD;
@@ -15075,7 +15080,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 			weight = __calc_prop_weight(cfs_rq, se, weight);
 		}
 
-		se = &curr->se;
+		se = &donor->se;
 		reweight_eevdf(cfs_rq, se, weight, se->on_rq);
 	}
 
@@ -15083,14 +15088,14 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		return;
 
 	if (static_branch_unlikely(&sched_numa_balancing))
-		task_tick_numa(rq, curr);
+		task_tick_numa(rq, donor);
 
-	task_tick_cache(rq, curr);
+	task_tick_cache(rq, donor);
 
-	update_misfit_status(curr, rq);
-	check_update_overutilized_status(task_rq(curr));
+	update_misfit_status(donor, rq);
+	check_update_overutilized_status(task_rq(donor));
 
-	task_tick_core(rq, curr);
+	task_tick_core(rq, donor);
 }
 
 /*
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index eb73b65ce6c4..c1e597b0912a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -532,12 +532,12 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
  *
  * NOTE: This function can be called remotely by the tick offload that
  * goes along full dynticks. Therefore no local assumption can be made
- * and everything must be accessed through the @rq and @curr passed in
- * parameters.
+ * and all state must be accessed through @rq.
  */
-static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_idle(struct rq *rq, int queued)
 {
-	update_curr_idle(rq);
+	if (rq->donor->sched_class == &idle_sched_class)
+		update_curr_idle(rq);
 }
 
 static void switching_to_idle(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 85303add726d..dd058a6ca06b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2535,12 +2535,17 @@ static inline void watchdog(struct rq *rq, struct task_struct *p) { }
  *
  * NOTE: This function can be called remotely by the tick offload that
  * goes along full dynticks. Therefore no local assumption can be made
- * and everything must be accessed through the @rq and @curr passed in
- * parameters.
+ * and all state must be accessed through @rq.
  */
-static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
+static void task_tick_rt(struct rq *rq, int queued)
 {
-	struct sched_rt_entity *rt_se = &p->rt;
+	struct task_struct *p = rq->donor;
+	struct sched_rt_entity *rt_se;
+
+	if (p->sched_class != &rt_sched_class)
+		return;
+
+	rt_se = &p->rt;
 
 	update_curr_rt(rq);
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e656c7059bf8..6a8deddc725b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2718,7 +2718,7 @@ struct sched_class {
 	 * sched_tick: rq->lock
 	 * sched_tick_remote: rq->lock
 	 */
-	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
+	void (*task_tick)(struct rq *rq, int queued);
 	/*
 	 * sched_cgroup_fork: p->pi_lock
 	 */
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index c909ca0d8c87..87b46fc74f81 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -68,10 +68,9 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct t
  *
  * NOTE: This function can be called remotely by the tick offload that
  * goes along full dynticks. Therefore no local assumption can be made
- * and everything must be accessed through the @rq and @curr passed in
- * parameters.
+ * and all state must be accessed through @rq.
  */
-static void task_tick_stop(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_stop(struct rq *rq, int queued)
 {
 }
 
-- 
2.55.0

