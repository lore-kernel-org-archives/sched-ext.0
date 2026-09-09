Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790103AFAFF
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946278; cv=none; b=nGP/y+nLJKOPCybH8Sg+Vcx3BrL9i5oaAc/CMXxauV6ebNwarJceqphHBUlzCKfX/Xqd5+am4oVcp8n9GooHcDwZx8KAtqf7lRLKo5Mf7v3tWyD2fjfFIRLHeJPa4hnXHPi1yQU+Tyfo4CNVaXwceE1TY0G8BT09rtT44qclt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946278; c=relaxed/simple;
	bh=IoWeGBdGvnDIYBYlTg5e5KCt5rnvAX3mhuJfEFpdbB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQt+YCsPum9iVUrnaBNzMhw54/s3e4njofmACoIVfZwi7fa/nf2lwmFfIqdww0v+JUMnCDejA0kFph/OxEM20gfR53BvchZ/ZGfTwBHp8n4rZRDMk7FIORaDdkbQb49rXVwYBuxl7Ve/6rSpSNJfM5jjNvUhdc3uycN9L+hYzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nfF+uV1j; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nfF+uV1j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rh
	FFwsHpcmge2L38izgNldpMrnUT4j5IDnTv3DlM0og=; b=nfF+uV1jVP+ic2jGGj
	3ekJKQQ10mSS6cR1zQpFWcfwNOUqBHewG9p4rdZAVhdRDz1G60H7F2GtuitdaHF4
	naoiJBinGNjefyRGOGh+pV0SlK100RFn59Pao2AzZ9AK1KIm7ylIhJW9I2S8euhP
	AWJkw8aiuTaiJ2yQGXPbmBLow=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXECQQJ6Fq+iIwQw--.14950S2;
	Wed, 09 Sep 2026 17:29:53 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com,
	kprateek.nayak@amd.com
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	connoro@google.com,
	jstultz@google.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH v4 1/5] sched: Dispatch task ticks for donor and execution classes
Date: Wed,  9 Sep 2026 18:28:57 +0900
Message-ID: <20260909092901.2989564-2-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909092901.2989564-1-sh_def@163.com>
References: <20260909092901.2989564-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXECQQJ6Fq+iIwQw--.14950S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFW3JFWrXFy8CF4rWryUKFg_yoWftry7pF
	WDXayDGa1DJa1jgryxArWkZa1fWwn3Xa4agFZ3tw4FkF1rKr1FqF1qqF42vr45JrW0vFy2
	vrWj9rW7Kr18Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaq2NUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6hHQMGqhJxFlHwAA3c

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

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20260908104407.GD687043@noisy.programming.kicks-ass.net
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/core.c      | 22 +++++++++++++++++++---
 kernel/sched/deadline.c  | 10 +++++++---
 kernel/sched/ext/ext.c   | 10 ++++++++--
 kernel/sched/fair.c      | 25 +++++++++++++++----------
 kernel/sched/idle.c      |  8 ++++----
 kernel/sched/rt.c        | 13 +++++++++----
 kernel/sched/sched.h     |  2 +-
 kernel/sched/stop_task.c |  5 ++---
 8 files changed, 65 insertions(+), 30 deletions(-)

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
index 51de1d8b72a1..70815bef5296 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3789,9 +3789,15 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, int queued)
 {
-	struct scx_sched *sch = scx_task_sched(curr);
+	struct task_struct *curr = rq->donor;
+	struct scx_sched *sch;
+
+	if (curr->sched_class != &ext_sched_class)
+		return;
+
+	sch = scx_task_sched(curr);
 
 	update_curr_scx(rq);
 
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

