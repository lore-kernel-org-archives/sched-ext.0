Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C93CBE79;
	Sat, 17 Oct 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255565; cv=none; b=g6Usogp3OaFDy0RgjWDbrh2pYhE7xcaQmg5gX5p1CqsPcIqh0ITLOxYfj+VtBhUj5nCPtwXvvkvGtfSxq0u2RSW+5lH5NNUhPMruP+eSH9TPwE4DgT19UGg3M3SDE9QEbo2LZDNNaaSItnFzmRzZUldzN0lJsC2SDOdvSjnPuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255565; c=relaxed/simple;
	bh=B+3/HDDw3bOLoImRZ3VQDCKx7MLil+XBqQs0juyFAhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aooRb365z7Q/kOX3wd1wDR9Xau6wDMPzW04p4xh1A5r/UG/ToZZnLB4k9ynQnjxgz5erSrQ0UguDZk4PNlPqWwqKiBdfcAaboWide/okt7U7Mq1bT/CAcTmEIsz0xLzWiUSZAXizR/ZaFnjjBsEXiI/wv3TnXy8ZpNWKa9zty0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhAdtjtx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhAdtjtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0391F000C7;
	Sat, 17 Oct 2026 16:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792255563;
	bh=2V/wwAtBbjOxF+al3oTKStPGiEuU3C3eALUd4vfnmRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PhAdtjtxSNW9Ce8XDGE89SsP1BuChvGaUwSwQUcGnFMssj5UjPMVGwAaCsVYOGEx9
	 aOZt6KTh48qKvQmZySjKBJSpM532fj4iNNUM8ge1PfObFJZDCv8GRh6pZyL0G9S8vG
	 zq+mpTXw3dObJ38ZtFNo6hEqL+Wk7AfsI0KEfbP+nHZGccrIFiYJcpGkF79p1+JfxO
	 UcYh/3qMiXsjEHDnr5CUReKTjPs5+iWI4y6b0eqgPkE5yyjSXrYOEREK/FLrP2DV8f
	 r6gr/2mqHrrlN6P+1RmL5CSBLrAve5gw33eMbD+Kb9+CJXUAPbtsl68wsEnXxTinPn
	 mCbmrxtnLLgPA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] sched_ext: Leave suspend and hibernation out of the ecaps reports
Date: Sat, 17 Oct 2026 06:45:56 -1000
Message-ID: <20261017164556.4136807-7-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017164556.4136807-1-tj@kernel.org>
References: <20261017164556.4136807-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suspend and hibernation take down every non-boot cpu and bring them back. A
loss and a regain per cpu to every sub-scheduler would be noise. Leave them
out: a cpu they take down reports no loss and keeps the caps last delivered,
and the reseed after resume reports only the net change. They are the downs
with cpuhp_tasks_frozen set between the PM notifications. A kexec jump sets
the flag too but sends no PM notification.

Two things need care. A cpu that suspend or hibernation takes down doesn't
wait for its syncs, and a pending ecaps_report() mark on it is processed by
its last pick before the stopper takes it down.

The detach report reaches only active cpus, and the loss on a cpu that
suspend or hibernation took down was never delivered. The detach waits for
those cpus to come back, so every loss is delivered. They come back before
the tasks thaw, so the wait doesn't hold up the freezer. If one fails to
come back, the hierarchy is aborted at the end of the PM cycle.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  15 ++++
 kernel/sched/ext/internal.h |   5 +-
 kernel/sched/ext/sub.c      | 143 +++++++++++++++++++++++++++++++++---
 kernel/sched/ext/sub.h      |   6 ++
 4 files changed, 156 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b7a24ff34483..4e6ac45634b1 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4105,6 +4105,7 @@ static void handle_hotplug(struct rq *rq, bool online)
 	s32 cpu_or_cid = cpu;
 
 	atomic_long_inc(&scx_hotplug_seq);
+	scx_update_frozen_cpus(cpu, online);
 
 	/*
 	 * scx_root updates are protected by cpus_read_lock() and will stay
@@ -9407,6 +9408,20 @@ static int scx_pm_handler(struct notifier_block *nb, unsigned long event, void *
 {
 	struct scx_sched *sch;
 
+	/* track the PM cycle whether or not a root is loaded */
+	switch (event) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
+		scx_sub_pm_begin();
+		break;
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+	case PM_POST_RESTORE:
+		scx_sub_pm_end();
+		break;
+	}
+
 	guard(rcu)();
 
 	sch = rcu_dereference(scx_root);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 0d20661fa4eb..50eb4e54435b 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -934,7 +934,10 @@ struct sched_ext_ops {
 	 * Deliveries for a cid happen only while the root considers the cid's
 	 * cpu online, never before the root's ops.cpu_online() or after its
 	 * ops.cpu_offline() for the cpu. A cpu going offline reports the loss
-	 * of every cap on it, and a cpu coming back reports the regain.
+	 * of every cap on it, and a cpu coming back reports the regain. A cpu
+	 * that suspend or hibernation takes down reports no loss and keeps its
+	 * caps while down. Only its net change, if any, is reported once it is
+	 * back.
 	 */
 	void (*sub_ecaps_updated)(s32 cid, u64 before, u64 after);
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 5395d6f2a17b..b248fcfafe4c 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -55,6 +55,19 @@ static struct rcuwait ecaps_report_wait = __RCUWAIT_INITIALIZER(ecaps_report_wai
 /* a cpu going down waits here for its marked syncs, see scx_offline_ecaps() */
 static DECLARE_WAIT_QUEUE_HEAD(ecaps_offline_waitq);
 
+/*
+ * The cpus that suspend or hibernation took down and that haven't come back.
+ * Their losses are not delivered, see scx_offline_ecaps(). Hotplug updates the
+ * set under cpus_write_lock(), and scx_sub_pm_end() clears it under
+ * cpus_read_lock(). A cpu that fails to come back stays in the set until
+ * regular hotplug brings it back or the PM cycle ends.
+ */
+static struct cpumask scx_frozen_cpus;
+static DECLARE_WAIT_QUEUE_HEAD(scx_frozen_cpus_waitq);
+
+/* between the PREPARE and POST notifications of a PM cycle */
+static bool scx_pm_in_progress;
+
 /**
  * scx_skip_subtree_pre - Skip @pos's subtree in a pre-order walk
  * @pos: current position
@@ -1121,6 +1134,17 @@ static void ecaps_offline_done(struct rq *rq, struct scx_sched_pcpu *pcpu)
 		irq_work_queue(&ecaps_offline_irq_work);
 }
 
+/*
+ * Test whether the hotplug operation in progress is suspend or hibernation
+ * taking a cpu down or bringing it back. A kexec jump also sets
+ * cpuhp_tasks_frozen but sends no PM notification, so outside a PM cycle its
+ * cpu downs deliver their losses as in regular hotplug.
+ */
+static bool scx_pm_frozen(void)
+{
+	return cpuhp_tasks_frozen && READ_ONCE(scx_pm_in_progress);
+}
+
 /**
  * __scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
  * @rq: the cid's cpu rq
@@ -1175,6 +1199,8 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		 * An inactive cpu that can deliver is going down and reads as
 		 * capless. A delivery below can drop the rq lock and the cpu's
 		 * active state can change between syncs, so test it per sync.
+		 * Suspend and hibernation don't deliver the loss of a cpu they
+		 * take down, see scx_offline_ecaps().
 		 *
 		 * A sync that can't deliver leaves the ecaps alone. It may
 		 * still carry a mark that is cleared below. Don't skip the rest
@@ -1186,6 +1212,8 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 			ecaps = old;
 		else if (cpu_active(cpu))
 			ecaps = calc_effective_caps(ps, cid);
+		else if (scx_pm_frozen())
+			ecaps = old;
 		else
 			ecaps = 0;
 		WRITE_ONCE(pcpu->ecaps, ecaps);
@@ -1260,6 +1288,63 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		scx_schedule_reenq_local(rq, SCX_REENQ_CAP_REVOKE);
 }
 
+void scx_sub_pm_begin(void)
+{
+	WRITE_ONCE(scx_pm_in_progress, true);
+}
+
+/*
+ * Called on every cpu down and up whether or not a root is loaded, so that the
+ * set stays exact when a root is enabled or disabled during a PM cycle. A cpu
+ * that failed to come back from suspend or hibernation can come back through
+ * regular hotplug before the PM cycle ends, e.g. through the SMT control. The
+ * reseed at its activation reports the net change, so any up removes the cpu
+ * from the set.
+ */
+void scx_update_frozen_cpus(s32 cpu, bool online)
+{
+	if (online) {
+		if (!cpumask_test_cpu(cpu, &scx_frozen_cpus))
+			return;
+		__cpumask_clear_cpu(cpu, &scx_frozen_cpus);
+		if (cpumask_empty(&scx_frozen_cpus))
+			wake_up_all(&scx_frozen_cpus_waitq);
+	} else if (scx_pm_frozen()) {
+		__cpumask_set_cpu(cpu, &scx_frozen_cpus);
+	}
+}
+
+/*
+ * The PM cycle is over. A cpu still in the set failed to come back, and its
+ * loss can't be delivered anymore. That breaks the guarantee that every ecaps
+ * change reaches the sub-scheds and their parents, so abort every sched. A root
+ * without sub-scheds is owed no reports and keeps running.
+ *
+ * Abort before clearing the set and waking the detaches in scx_sub_disable(),
+ * so that no parent's ops.sub_detach() runs with that loss unreported. No exit
+ * cpu is recorded, as the cpu running this isn't the one that failed.
+ */
+void scx_sub_pm_end(void)
+{
+	/* hotplug updates the set under cpus_write_lock() */
+	guard(cpus_read_lock)();
+
+	if (unlikely(!cpumask_empty(&scx_frozen_cpus)) && scx_has_subs()) {
+		struct scx_sched *root;
+
+		guard(rcu)();
+		root = rcu_dereference(scx_root);
+		if (root)
+			__scx_exit(root, SCX_EXIT_ERROR, 0, -1,
+				   "%u cpu(s) failed to come back after suspend or hibernation",
+				   cpumask_weight(&scx_frozen_cpus));
+	}
+
+	WRITE_ONCE(scx_pm_in_progress, false);
+	cpumask_clear(&scx_frozen_cpus);
+	wake_up_all(&scx_frozen_cpus_waitq);
+}
+
 /*
  * Called with cpus_read_lock() held before the root is published. The cpus
  * active now are online to the root without ops.cpu_online(), so they can
@@ -1350,6 +1435,11 @@ void scx_online_ecaps(struct rq *rq)
  * resched_sync_ecaps(). Only the marked syncs count, so a flood of changes on
  * the cid can't hold up the hotplug. After the wait, every sub-sched's ecaps on
  * the cpu are zero, and the later syncs have nothing to deliver.
+ *
+ * The loss on a cpu that suspend or hibernation takes down is not delivered, so
+ * that the scheds don't see a PM cycle as cpus leaving and coming back. The cpu
+ * keeps the caps last delivered until it comes back, and the reseed then
+ * reports the net change.
  */
 void scx_offline_ecaps(struct rq *rq)
 {
@@ -1364,7 +1454,7 @@ void scx_offline_ecaps(struct rq *rq)
 	 * processed and the wait would never end. scx_enabled() can't change
 	 * during hotplug.
 	 */
-	if (scx_enabled()) {
+	if (scx_enabled() && !scx_pm_frozen()) {
 		scoped_guard (rq_lock_irqsave, rq) {
 			root = scx_root_protected();
 			cid = __scx_cpu_to_cid(cpu);
@@ -1797,11 +1887,16 @@ static void ecaps_enable(struct scx_sched *sch)
  * through the dispatch path and wait for it. An inactive cpu is skipped. It may
  * already be offline, where the mark would never be processed and the wait
  * would never end. On attach, the reseed at its activation reports its caps. On
- * detach, its loss was reported as it went down.
+ * detach, its loss was reported as it went down. A cpu that suspend or
+ * hibernation took down is back by then, or the hierarchy is aborting, see
+ * scx_sub_disable().
  *
  * If a marked cpu goes down meanwhile, it clears the mark while still online,
- * as ecaps_report_irq_work would never run on an offline cpu. A cpu going down
- * waits for the marked sync in scx_offline_ecaps().
+ * as ecaps_report_irq_work would never run on an offline cpu. A regular down
+ * waits for the marked sync in scx_offline_ecaps(). Suspend and hibernation
+ * don't wait, but the last pick on the cpu before the stopper takes it down, or
+ * a core scheduling sibling's pick of its rq, goes through the ext class and
+ * processes the marked sync.
  *
  * Called with scx_enable_mutex held. A sched's attach and detach reports must
  * not overlap, as the mark is one bit per pcpu.
@@ -1869,15 +1964,39 @@ void scx_sub_disable(struct scx_sched *sch)
 	 * skips has finished going down. Its loss was reported as it went down,
 	 * see scx_offline_ecaps().
 	 *
-	 * An enable that failed before its attach report has nothing to report.
-	 * If it failed before scx_link_sched(), the root's disable doesn't wait
-	 * for it and may have retired the cid tables that the report reads.
+	 * The loss on a cpu that suspend or hibernation took down is not
+	 * delivered. Wait for such cpus to come back so that the report reaches
+	 * them. They go down only after the freezer has frozen the tasks and
+	 * come back before the tasks thaw, so the wait doesn't hold up the
+	 * freezer. If one fails to come back, the wait lasts until the PM cycle
+	 * ends, and scx_sub_pm_end() aborts every sched first.
+	 *
+	 * The check and the report run in one cpus_read_lock() section so that
+	 * no cpu goes down for PM between them. The report also needs
+	 * scx_enable_mutex, see ecaps_report(). A cpu coming back takes
+	 * cpus_write_lock(), so the wait drops cpus_read_lock(). It drops
+	 * scx_enable_mutex too so that other enables and disables don't wait
+	 * behind the PM cycle, and retakes both in order.
+	 *
+	 * An enable that failed before its attach report has nothing to report
+	 * and doesn't wait. If it failed before scx_link_sched(), the root's
+	 * disable doesn't wait for it and may have retired the cid tables that
+	 * the report reads.
 	 */
-	scoped_guard(cpus_read_lock) {
-		clear_all_caps(sch);
-		if (sch->ecaps_enabled)
-			ecaps_report(sch);
-	}
+	cpus_read_lock();
+	while (sch->ecaps_enabled && !cpumask_empty(&scx_frozen_cpus)) {
+		cpus_read_unlock();
+		mutex_unlock(&scx_enable_mutex);
+		/* lockless hint, the loop retests under cpus_read_lock() */
+		wait_event_idle(scx_frozen_cpus_waitq,
+				data_race(cpumask_empty(&scx_frozen_cpus)));
+		mutex_lock(&scx_enable_mutex);
+		cpus_read_lock();
+	}
+	clear_all_caps(sch);
+	if (sch->ecaps_enabled)
+		ecaps_report(sch);
+	cpus_read_unlock();
 
 	percpu_down_write(&scx_fork_rwsem);
 	scx_cgroup_lock();
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 46c7e2a578d1..eb1dba6d51e2 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -32,6 +32,9 @@ void scx_free_pshards(struct scx_sched *sch);
 s32 scx_alloc_pshards(struct scx_sched *sch);
 void scx_init_root_caps(struct scx_sched *sch);
 void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev);
+void scx_sub_pm_begin(void);
+void scx_update_frozen_cpus(s32 cpu, bool online);
+void scx_sub_pm_end(void);
 void scx_init_rq_ops_online(void);
 void scx_online_ecaps(struct rq *rq);
 void scx_offline_ecaps(struct rq *rq);
@@ -110,6 +113,9 @@ static inline void scx_free_pshards(struct scx_sched *sch) {}
 static inline s32 scx_alloc_pshards(struct scx_sched *sch) { return 0; }
 static inline void scx_init_root_caps(struct scx_sched *sch) {}
 static inline void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev) {}
+static inline void scx_sub_pm_begin(void) {}
+static inline void scx_update_frozen_cpus(s32 cpu, bool online) {}
+static inline void scx_sub_pm_end(void) {}
 static inline void scx_init_rq_ops_online(void) {}
 static inline void scx_online_ecaps(struct rq *rq) {}
 static inline void scx_offline_ecaps(struct rq *rq) {}
-- 
2.56.0

