Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142927FD5B
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521712; cv=none; b=BmhV1mRfDIep9N360QHIKcjG5AxtfSuBZRBegLnpb18vtQqqMHO8EC1SyV2LdNdmkUq4hfNPQjtVqpv1llvOOOTkdLviKpCmYJiBOQ988D2i3tJROKqzpPtd7n/YbjuFznvajIsfwc/9T8BAxNRA79B/6aD2tJm3+JfhL20NwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521712; c=relaxed/simple;
	bh=Y85qgKy1UilNrc8QcHOELw6DEbYxE4hQYtrWZhEiLE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FPQZ/GTHZKP02eGf6N8EtroKFwP8GP1N0D/SFykBhGdB3abRZMA9irvcCVzA+NbSEP4O2YkfhBLgF08joUARLEsQm93hTBEzoQPL9Z+aDmbWuDlYnsKlHsus4bq+CEYqELtsCdUmtWQE9lPuQxzMiOYuKM0rrZ4g9oadWd71fDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=DzYhhSET; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="DzYhhSET"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1789521217;
	bh=Y85qgKy1UilNrc8QcHOELw6DEbYxE4hQYtrWZhEiLE8=;
	h=From:Date:Subject:To:Cc:From;
	b=DzYhhSETAevsQsBwhHW7i3LrlMel/oCrLRumyMN6N9XzhWfXRiAwpMbkyP+n5TyDM
	 FFEHcDjTdtYv4QLJL1jz+T9jJnJbgDvSwxYmIbLjXL91EQsoR/BYtQZLIADWe1NZSk
	 4Pg2Qq0nDsouR350QwL4uQSkBE+nBVIsAAMk/8L8=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id D71904014B;
	Tue, 15 Sep 2026 18:13:36 -0700 (PDT)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Tue, 15 Sep 2026 18:13:18 -0700
Subject: [PATCH v3] sched: Restart fair hrtick after same-task repicks
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-sched-fair-hrtick-restart-v3-1-7517f388f0c8@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAC7tqWoC/43NywrCMBCF4VcpWTvSSUovrnwPcZHLtA1CK5MQl
 dJ3N+1G3IjL/8B8s4hA7CmIU7EIpuSDn6cc6lAIO+ppIPAut5ClrMsWFQQ7koNee4aRo7c3YAp
 RcwRtOqdc1VDftCLf35l6/9ztyzX36EOc+bW/Srit/6gJAaGSqnRI2PbGnAea4mM+zjyIjU3yQ
 3WIvyiZqdKpyhlZk3X4Ra3r+gZdD3TcDgEAAA==
X-Change-ID: 20260813-sched-fair-hrtick-restart-ab9d3d47ef78
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
 Christoph Lameter <cl@gentwo.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
 "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789521216; l=10236;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=Y85qgKy1UilNrc8QcHOELw6DEbYxE4hQYtrWZhEiLE8=;
 b=FrjprSHNP755QtPGKs0yn1lHRZAfCY0NftCsImG75jhyvcJao1CR3MAgHD67DI6Bo9CpnY79e
 TZzkPo1QwE1CXjMv0H5tVMSw9EcynEAmt4P7qQu6JafoaDMcK/oxMfU
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

Fair hrticks are one-shot timers. A same-task repick after hrtick expiry
skips set_next_task_fair() and leaves no hrtick armed for the next fair
preemption point:

    hrtick()
      -> task_tick_fair(..., queued=1)
         -> entity_tick()
            -> resched_curr()
      -> schedule()
         -> pick_task_fair() selects current
         -> put_prev_set_next_task(rq, prev, next)
            -> next == prev
            -> return

Introduce SNT_REPICK for the next == prev path:

    put_prev_set_next_task(rq, prev, next)
      -> next == prev
      -> next->sched_class->set_next_task(rq, next, SNT_REPICK)
         -> set_next_task_fair()
            -> hrtick_start_fair()

set_next_task_fair() skips task-transition work for SNT_REPICK and
restarts the fair hrtick. hrtick_start() records the delay during
schedule(), and hrtick_schedule_exit() rearms the timer.

Do not restart the DL hrtick for SNT_REPICK. put_prev_task_dl() is
skipped for next == prev, so dl_se->runtime may be stale.

Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
Testing:
    - HRTICK and DELAY_DEQUEUE enabled, base_slice_ns=3000000:
        p90:  3.998ms baseline -> 3.053ms v3
        p99:  5.144ms baseline -> 4.533ms v3
        >4ms: 7.89% baseline -> 2.26% v3
        >6ms: 0.309% baseline -> 0.013% v3
    - HRTICK_DL stress-ng smoke test: baseline and v3 completed 2691
      bogo ops with no new dmesg warnings.
    - Also built with CONFIG_HIGH_RES_TIMERS=n, which disables
      CONFIG_SCHED_HRTICK and CONFIG_HRTIMER_REARM_DEFERRED. The kernel
      booted successfully; a 30-second stress-ng --cpu 2 run completed
      without new dmesg warnings.
---
Changes in v3:
  - Drop the SCHED_DEADLINE SNT_REPICK hrtick rearm from v2.

Link to v2: https://lore.kernel.org/r/20260911-sched-fair-hrtick-restart-v2-1-0d34db26ecd1@gentwo.org

Changes in v2:

 - Replace the fair-specific hrtick rearm state with SNT_REPICK.
 - Restart hrticks for both fair and SCHED_DEADLINE same-task repicks.
 - Remove the delayed-dequeue runnable-count condition.

Link to v1: https://lore.kernel.org/r/20260813-sched-fair-hrtick-restart-v1-1-4230d1e18fbb@gentwo.org
---
 kernel/sched/core.c      |  2 +-
 kernel/sched/deadline.c  |  7 +++++--
 kernel/sched/ext/ext.c   |  5 ++++-
 kernel/sched/fair.c      | 15 ++++++++++-----
 kernel/sched/idle.c      |  5 ++++-
 kernel/sched/rt.c        |  7 +++++--
 kernel/sched/sched.h     | 16 ++++++++++++----
 kernel/sched/stop_task.c |  5 ++++-
 8 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7885ff76e69f28e1c81d72d87e5ceef0562ccea9..4f7d2139f29d5e6a9241e0bb87369bc20359955c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7222,7 +7222,7 @@ static void __sched notrace __schedule(int sched_mode)
 			 * on_cpu.
 			 */
 			donor->sched_class->put_prev_task(rq, donor, donor);
-			donor->sched_class->set_next_task(rq, donor, true);
+			donor->sched_class->set_next_task(rq, donor, SNT_PICK);
 		}
 	} else {
 		rq_set_donor(rq, next);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0663c00c41c04213fda2ebaf16a0bdf34e0849a8..1502a45d76aaf44079d618d8ae193c9b213fc401 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2773,11 +2773,14 @@ static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
  * DL keeps current in tree, because ->deadline is not typically changed while
  * a task is runnable.
  */
-static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
+static void set_next_task_dl(struct rq *rq, struct task_struct *p, enum snt_e type)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
 	struct dl_rq *dl_rq = &rq->dl;
 
+	if (type == SNT_REPICK)
+		return;
+
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_dl_rq(&p->dl))
 		update_stats_wait_end_dl(dl_rq, dl_se);
@@ -2788,7 +2791,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	WARN_ON_ONCE(dl_rq->curr);
 	dl_rq->curr = dl_se;
 
-	if (!first)
+	if (type != SNT_PICK)
 		return;
 
 	if (rq->donor->sched_class != &dl_sched_class)
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 51de1d8b72a1ede6d16c07b58defb1284285b8a6..31a300f2d3b202d588ca666d6b8f6d4705ee6c79 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3003,10 +3003,13 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	return verdict;
 }
 
-static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+static void set_next_task_scx(struct rq *rq, struct task_struct *p, enum snt_e type)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 
+	if (type == SNT_REPICK)
+		return;
+
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
 		 * Core-sched might decide to execute @p before it is
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7455a83a6a9907b4fd18c3a99df707438818709b..b46b180d363cf8a0e8fd1ad330c1cd36b71b313b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15253,14 +15253,18 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 	}
 }
 
-static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
+static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e type)
 {
 	struct sched_entity *se = &p->se;
-	bool throttled = false;
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	unsigned long weight = NICE_0_LOAD;
+	bool first = type == SNT_PICK;
+	bool throttled = false;
 	bool on_rq = se->on_rq;
 
+	if (type == SNT_REPICK)
+		goto repick;
+
 	clear_buddies(cfs_rq, se);
 
 	if (on_rq)
@@ -15304,11 +15308,12 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 
 	WARN_ON_ONCE(se->sched_delayed);
 
-	if (hrtick_enabled_fair(rq))
-		hrtick_start_fair(rq, p);
-
 	update_misfit_status(p, rq);
 	sched_fair_update_stop_tick(rq, p);
+
+repick:
+	if (hrtick_enabled_fair(rq))
+		hrtick_start_fair(rq, p);
 }
 
 void init_cfs_rq(struct cfs_rq *cfs_rq)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index eb73b65ce6c4714db1e07066c86a8cf39adbc328..76f3c84ca6846afc30609fdc512553c6797e9557 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -487,8 +487,11 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
 	update_rq_avg_idle(rq);
 }
 
-static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
+static void set_next_task_idle(struct rq *rq, struct task_struct *next, enum snt_e type)
 {
+	if (type == SNT_REPICK)
+		return;
+
 	update_idle_core(rq);
 	scx_update_idle(rq, true, true);
 	schedstat_inc(rq->sched_goidle);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 85303add726df4c2da846c427aab2d627fca9589..1535046a23ffa0705d90dce301fa4c5b015703a1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1654,11 +1654,14 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 		check_preempt_equal_prio(rq, p);
 }
 
-static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
+static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, enum snt_e type)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 	struct rt_rq *rt_rq = &rq->rt;
 
+	if (type == SNT_REPICK)
+		return;
+
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_rt_rq(&p->rt))
 		update_stats_wait_end_rt(rt_rq, rt_se);
@@ -1666,7 +1669,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
 
-	if (!first)
+	if (type != SNT_PICK)
 		return;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e656c7059bf864d1ed91d4ec3d4624850aded7e0..defcf7fd023fa5bb3c34c3c29f99afe3c42a87de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2621,6 +2621,12 @@ struct affinity_context {
 
 extern s64 update_curr_common(struct rq *rq);
 
+enum snt_e {
+	SNT_NORMAL,
+	SNT_PICK,
+	SNT_REPICK,
+};
+
 struct sched_class {
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -2678,7 +2684,7 @@ struct sched_class {
 	 * __schedule: rq->lock
 	 */
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
-	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
+	void (*set_next_task)(struct rq *rq, struct task_struct *p, enum snt_e type);
 
 	/*
 	 * select_task_rq: p->pi_lock
@@ -2781,7 +2787,7 @@ static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 
 static inline void set_next_task(struct rq *rq, struct task_struct *next)
 {
-	next->sched_class->set_next_task(rq, next, false);
+	next->sched_class->set_next_task(rq, next, SNT_NORMAL);
 }
 
 static inline void
@@ -2802,11 +2808,13 @@ static inline void put_prev_set_next_task(struct rq *rq,
 
 	__put_prev_set_next_dl_server(rq, prev, next);
 
-	if (next == prev)
+	if (next == prev) {
+		next->sched_class->set_next_task(rq, next, SNT_REPICK);
 		return;
+	}
 
 	prev->sched_class->put_prev_task(rq, prev, next);
-	next->sched_class->set_next_task(rq, next, true);
+	next->sched_class->set_next_task(rq, next, SNT_PICK);
 }
 
 /*
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index c909ca0d8c87c1055ad5ffe58ae9f044194ee358..1e0109ec36b3f9b84f6f7290e584e38257db701c 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -27,8 +27,11 @@ wakeup_preempt_stop(struct rq *rq, struct task_struct *p, int flags)
 	/* we're never preempted */
 }
 
-static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool first)
+static void set_next_task_stop(struct rq *rq, struct task_struct *stop, enum snt_e type)
 {
+	if (type == SNT_REPICK)
+		return;
+
 	stop->se.exec_start = rq_clock_task(rq);
 }
 

---
base-commit: f6e7b42bf05b2427fb8a7a1d1c387a86638bb413
change-id: 20260813-sched-fair-hrtick-restart-ab9d3d47ef78

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

