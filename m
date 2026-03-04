Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FAA3D7D63;
	Wed,  4 Mar 2026 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661708; cv=none; b=aGm+MHc9bJ12N3G99emFS/Q3G2/CAiMPSWB+tZaZhMjLwK25qZzyUf2PFtup+PK0oFujWum54LnxHm8AfjDh/k4pXS5/8t2XYlvUGbi2kkvLPfmFe2cCTlSFxX6oLD1n9SybW03Kz2/KWwAfUMy8hVx6c8ZKhXt8GDaODA7veM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661708; c=relaxed/simple;
	bh=AzIR2o/PWSD9Cw+qV9wsGA/VKd7GAalrgkdG6nEkyHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLAYhKs3ITEYdtG8cmCUFHYgniECECiMGnXjm4ojyrYcioCHwvYFE/nddhExjX0DqYik0gdi/E+BnruKFYcqiqVNXt/lrR7TrS+ntiwdhcLZ+a8N7coZDZjzY5coFwNqmOiEEtP8spNTbpB9BQjnM4DFW83PJ8l2fMXv8ygmdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6DbgRqF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6DbgRqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD02C4CEF7;
	Wed,  4 Mar 2026 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661707;
	bh=AzIR2o/PWSD9Cw+qV9wsGA/VKd7GAalrgkdG6nEkyHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6DbgRqFOv4158RRe5G9R4cwX8d0xAzS+DFrQ1CP0P8Ds7x8AXTz6R5SObOL+QTBK
	 awOFEfwAAisDQPZzjrBs0YVA/gn02QAa5khRaEgzi4M4QOZHgjIILeeQehphYJoY/I
	 3744GnK60DiXiL+HL882pI/jQf4c1tYprcnCG2xdLi+88dx3xVGcmD+pqNE+0KVmRh
	 hEmZcAboVktAyuGfZL0Q6PS90Pg5bEt15j9Rxw5GXhjClTOhHEOiNtOdUruttLjbTD
	 e4gxOG0IrQK/8KQ49cDs++lkvKQebOvvv2KCcvi63wK4fRoqAgjzkBMtaFvS8ULeEN
	 3Qut4UC5PlIUg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 26/34] sched_ext: Make watchdog sub-sched aware
Date: Wed,  4 Mar 2026 12:01:11 -1000
Message-ID: <20260304220119.4095551-27-tj@kernel.org>
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

Currently, the watchdog checks all tasks as if they are all on scx_root.
Move scx_watchdog_timeout inside scx_sched and make check_rq_for_timeouts()
use the timeout from the scx_sched associated with each task.
refresh_watchdog() is added, which determines the timer interval as half of
the shortest watchdog timeouts of all scheds and arms or disarms it as
necessary. Every scx_sched instance has equivalent or better detection
latency while sharing the same timer.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 74 ++++++++++++++++++++++++-------------
 kernel/sched/ext_internal.h |  7 ++++
 2 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9e48196f05df..8e2f919d3ec3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -59,11 +59,10 @@ static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_enable_seq = ATOMIC_LONG_INIT(0);
 
 /*
- * The maximum amount of time in jiffies that a task may be runnable without
- * being scheduled on a CPU. If this timeout is exceeded, it will trigger
- * scx_error().
+ * Watchdog interval. All scx_sched's share a single watchdog timer and the
+ * interval is half of the shortest sch->watchdog_timeout.
  */
-static unsigned long scx_watchdog_timeout;
+static unsigned long scx_watchdog_interval;
 
 /*
  * The last time the delayed work was run. This delayed work relies on
@@ -3038,10 +3037,11 @@ static bool check_rq_for_timeouts(struct rq *rq)
 		goto out_unlock;
 
 	list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node) {
+		struct scx_sched *sch = scx_task_sched(p);
 		unsigned long last_runnable = p->scx.runnable_at;
 
 		if (unlikely(time_after(jiffies,
-					last_runnable + READ_ONCE(scx_watchdog_timeout)))) {
+					last_runnable + READ_ONCE(sch->watchdog_timeout)))) {
 			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
 
 			scx_exit(sch, SCX_EXIT_ERROR_STALL, 0,
@@ -3058,6 +3058,7 @@ static bool check_rq_for_timeouts(struct rq *rq)
 
 static void scx_watchdog_workfn(struct work_struct *work)
 {
+	unsigned long intv;
 	int cpu;
 
 	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
@@ -3068,28 +3069,31 @@ static void scx_watchdog_workfn(struct work_struct *work)
 
 		cond_resched();
 	}
-	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
-			   READ_ONCE(scx_watchdog_timeout) / 2);
+
+	intv = READ_ONCE(scx_watchdog_interval);
+	if (intv < ULONG_MAX)
+		queue_delayed_work(system_unbound_wq, to_delayed_work(work),
+				   intv);
 }
 
 void scx_tick(struct rq *rq)
 {
-	struct scx_sched *sch;
+	struct scx_sched *root;
 	unsigned long last_check;
 
 	if (!scx_enabled())
 		return;
 
-	sch = rcu_dereference_bh(scx_root);
-	if (unlikely(!sch))
+	root = rcu_dereference_bh(scx_root);
+	if (unlikely(!root))
 		return;
 
 	last_check = READ_ONCE(scx_watchdog_timestamp);
 	if (unlikely(time_after(jiffies,
-				last_check + READ_ONCE(scx_watchdog_timeout)))) {
+				last_check + READ_ONCE(root->watchdog_timeout)))) {
 		u32 dur_ms = jiffies_to_msecs(jiffies - last_check);
 
-		scx_exit(sch, SCX_EXIT_ERROR_STALL, 0,
+		scx_exit(root, SCX_EXIT_ERROR_STALL, 0,
 			 "watchdog failed to check in for %u.%03us",
 			 dur_ms / 1000, dur_ms % 1000);
 	}
@@ -4760,6 +4764,26 @@ static void free_kick_syncs(void)
 	}
 }
 
+static void refresh_watchdog(void)
+{
+	struct scx_sched *sch;
+	unsigned long intv = ULONG_MAX;
+
+	/* take the shortest timeout and use its half for watchdog interval */
+	rcu_read_lock();
+	list_for_each_entry_rcu(sch, &scx_sched_all, all)
+		intv = max(min(intv, sch->watchdog_timeout / 2), 1);
+	rcu_read_unlock();
+
+	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
+	WRITE_ONCE(scx_watchdog_interval, intv);
+
+	if (intv < ULONG_MAX)
+		mod_delayed_work(system_unbound_wq, &scx_watchdog_work, intv);
+	else
+		cancel_delayed_work_sync(&scx_watchdog_work);
+}
+
 #ifdef CONFIG_EXT_SUB_SCHED
 static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
 
@@ -4798,6 +4822,8 @@ static void scx_sub_disable(struct scx_sched *sch)
 	list_del_rcu(&sch->all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	mutex_unlock(&scx_enable_mutex);
 
 	/*
@@ -4932,12 +4958,12 @@ static void scx_root_disable(struct scx_sched *sch)
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, exit, NULL, ei);
 
-	cancel_delayed_work_sync(&scx_watchdog_work);
-
 	raw_spin_lock_irq(&scx_sched_lock);
 	list_del_rcu(&sch->all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	/*
 	 * scx_root clearing must be inside cpus_read_lock(). See
 	 * handle_hotplug().
@@ -5473,6 +5499,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	sch->ancestors[level] = sch;
 	sch->level = level;
 
+	if (ops->timeout_ms)
+		sch->watchdog_timeout = msecs_to_jiffies(ops->timeout_ms);
+	else
+		sch->watchdog_timeout = SCX_WATCHDOG_MAX_TIMEOUT;
+
 	sch->slice_dfl = SCX_SLICE_DFL;
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
 	init_irq_work(&sch->error_irq_work, scx_error_irq_workfn);
@@ -5615,7 +5646,6 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	struct scx_sched *sch;
 	struct scx_task_iter sti;
 	struct task_struct *p;
-	unsigned long timeout;
 	int i, cpu, ret;
 
 	mutex_lock(&scx_enable_mutex);
@@ -5667,6 +5697,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	list_add_tail_rcu(&sch->all, &scx_sched_all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	scx_idle_enable(ops);
 
 	if (sch->ops.init) {
@@ -5697,16 +5729,6 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_disable;
 
-	if (ops->timeout_ms)
-		timeout = msecs_to_jiffies(ops->timeout_ms);
-	else
-		timeout = SCX_WATCHDOG_MAX_TIMEOUT;
-
-	WRITE_ONCE(scx_watchdog_timeout, timeout);
-	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
-	queue_delayed_work(system_unbound_wq, &scx_watchdog_work,
-			   READ_ONCE(scx_watchdog_timeout) / 2);
-
 	/*
 	 * Once __scx_enabled is set, %current can be switched to SCX anytime.
 	 * This can lead to stalls as some BPF schedulers (e.g. userspace
@@ -5928,6 +5950,8 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	list_add_tail_rcu(&sch->all, &scx_sched_all);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	refresh_watchdog();
+
 	if (sch->level >= SCX_SUB_MAX_DEPTH) {
 		scx_error(sch, "max nesting depth %d violated",
 			  SCX_SUB_MAX_DEPTH);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 1d633cc9e001..524bd7afbfe6 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1019,6 +1019,13 @@ struct scx_sched {
 	bool			sub_attached;
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
+	/*
+	 * The maximum amount of time in jiffies that a task may be runnable
+	 * without being scheduled on a CPU. If this timeout is exceeded, it
+	 * will trigger scx_error().
+	 */
+	unsigned long		watchdog_timeout;
+
 	atomic_t		exit_kind;
 	struct scx_exit_info	*exit_info;
 
-- 
2.53.0

