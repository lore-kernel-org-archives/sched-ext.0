Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602863;
	b=oJeDGqDHdADFcGbRM7RLvlxPRVUsz07vsHmHVbT2nQBVVt63urCCLIHlrtQqxxmbY0UW
	 QAU1mduznAWW9fSVtTbSY1DPlwRRWJk2oEv9u8+p25O68aO6YY3Jvu+5Ik9/5kK2n1zLZ
	 pyHY30j9/zIdcCrg6BILK8LqV0dq1beHzw6S4MH7Zz4XTy8T5gntaL3eQe+XJ6Rc+O1lj
	 mCxcz5VBw0lyu/5bYHMpPDK2W1ke5/GIDQOj6Tp97MzK8w+p7njceE6cqC+F5W/v2jkoz
	 NAg0ZjR6RFGML4iajvTCz/v+Fgjeyxn0LsUoziasAMAC0W0dkVsgaElAtS4uxmDXS7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zUrRCgKeUVxaha5wrs9xlWiMc/sk3rCpy8b58eUjFFE=;
	b=G6pU89MHSaw+OYsbpAec5gGuIpJ5uydRTwTUjbY+HHOPUiMEiiilXYDY1J29N/KyDL6w
	 mThOhcO3svJKGvKOBAxSZq5ayoD3X9cq895i8+Z1Zx3Qf1L2zKT0BfmdYjjInjLwWMo59
	 sGFBaRv0lYbjwmPUYE3PAXawMHz9JKpcVIp1i92bHt37f5SF96igqY/fbltb+xTSMBTwG
	 b5ru1/U6mhAvfvQQ96gONnN1wdyRPx66ixsCHgzbpgtj/CTEIHj/PP9UCxicpPcWwdJMN
	 vTsP2tTykNRrM46lKvX4aGtkjm4l/dGKvW5c4mXopEqqN7/dtvhoIEjwl3dhm95KfbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZ0mJW1b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8360A2603;
	Wed, 25 Nov 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZ0mJW1b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B2A1F0180C;
	Wed, 25 Nov 2026 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795602863;
	bh=zUrRCgKeUVxaha5wrs9xlWiMc/sk3rCpy8b58eUjFFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lZ0mJW1bA4Q4H/IvjO1v17DebtYXCAuWeZksxboxSsbQqk65BJCB7i/9J02ypvSrX
	 EOMMKWhfkQ3laU9alHA6bC0KXZ3walZPScwHfX2iKKTs/VIdZmTQd/X7Onv2WOqgOf
	 pqTk6fu3EMGL5rbAmA29X2hgUCChqnJit+7aZuxHgrCqM5hHuC2XyBHOOO1yk1kztb
	 tIcTKXEO86+/5aJEQhOMbVaoa0Z4H+jGG7MH4635CoZWHCLXpyMx4qtcTGJVCFlJ3a
	 mYq3mMCnq3LVb4AGT0rFKQWnxAIdACsP4Fg8hYFet+D111wUXn2v8qLkbGM5+q+StD
	 cZJXjrCRnoHYQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Start ext_server from the tick while a higher class holds the CPU
Date: Wed, 25 Nov 2026 00:34:19 -1000
Message-ID: <20261125103420.2785659-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125103420.2785659-1-tj@kernel.org>
References: <20261125103420.2785659-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext_server starts when the first task is enqueued on a CPU's rq and stops
when its pick finds no task. As the BPF scheduler can run a task on any CPU
whichever rq it is queued on, tasks can wait for a CPU whose ext_server has
stopped with no enqueue to start it again. A higher class task which keeps
the CPU then starves them until the watchdog fires.

Fix it by also starting ext_server from the tick while a higher class task
runs on the CPU. If the local DSQ has a task, start it right away.
Otherwise, if any task is runnable on SCX, start it at most once a server
period, as only ops.dispatch() can tell whether the CPU has a task to run.

Whether any task is runnable is a per-node count of rqs which have tasks and
a global count of such nodes, which the tick reads. A per-node timer
uncounts an rq after it has had no tasks for a second, so that an rq which
keeps running out of tasks doesn't write the counts each time.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c      |   4 +-
 kernel/sched/ext/ext.c   | 162 ++++++++++++++++++++++++++++++++++++++-
 kernel/sched/ext/ext.h   |   2 +
 kernel/sched/ext/types.h |   1 +
 kernel/sched/sched.h     |   2 +
 5 files changed, 167 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2f46922982f3..1ac779bb34f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8807,9 +8807,7 @@ int sched_cpu_dying(unsigned int cpu)
 		dump_rq_tasks(rq, KERN_WARNING);
 	}
 	dl_server_stop(&rq->fair_server);
-#ifdef CONFIG_SCHED_CLASS_EXT
-	dl_server_stop(&rq->ext_server);
-#endif
+	scx_rq_dying(rq);
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e3d1bb3fadd8..e081f853a155 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -213,6 +213,21 @@ static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
 
 static struct delayed_work scx_watchdog_work;
 
+/* per-node state */
+struct scx_pnode {
+	s32			node;
+
+	/* see ext_server_timerfn() */
+	raw_spinlock_t		lock;			/* protects the following */
+	u32			nr_populated_rqs;	/* %SCX_RQ_POPULATED rqs on node */
+	struct timer_list	ext_server_timer;	/* armed while the above isn't 0 */
+} ____cacheline_aligned_in_smp;
+
+static struct scx_pnode **scx_pnode;
+
+/* nodes with %SCX_RQ_POPULATED rqs, see ext_server_timerfn() */
+static atomic_t scx_nr_populated_nodes;
+
 /*
  * For %SCX_KICK_WAIT: Each CPU has a pointer to an array of kick_sync sequence
  * numbers. The arrays are allocated with kvzalloc() as size can exceed percpu
@@ -2441,6 +2456,20 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	if (rq->scx.nr_running == 1)
 		dl_server_start(&rq->ext_server);
 
+	/* see ext_server_timerfn() */
+	if (!(rq->scx.flags & SCX_RQ_POPULATED)) {
+		struct scx_pnode *pnode = scx_pnode[cpu_to_node(cpu_of(rq))];
+
+		rq->scx.flags |= SCX_RQ_POPULATED;
+
+		guard(raw_spinlock)(&pnode->lock);
+		if (!pnode->nr_populated_rqs++) {
+			atomic_inc(&scx_nr_populated_nodes);
+			timer_reduce(&pnode->ext_server_timer,
+				     round_jiffies_up(jiffies + SCX_EXT_SERVER_INTV));
+		}
+	}
+
 	scx_do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
@@ -2581,6 +2610,8 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 
 	p->scx.flags &= ~SCX_TASK_QUEUED;
 	rq->scx.nr_running--;
+	if (!rq->scx.nr_running)
+		rq->scx.empty_at = jiffies;
 	sub_nr_running(rq, 1);
 
 	scx_dispatch_dequeue(rq, p);
@@ -4247,6 +4278,31 @@ void scx_rq_deactivate(struct rq *rq)
 	handle_hotplug(rq, false);
 }
 
+/* see ext_server_timerfn() */
+static void clear_rq_populated(struct rq *rq)
+{
+	struct scx_pnode *pnode = scx_pnode[cpu_to_node(cpu_of(rq))];
+
+	lockdep_assert_rq_held(rq);
+
+	rq->scx.flags &= ~SCX_RQ_POPULATED;
+
+	guard(raw_spinlock)(&pnode->lock);
+	if (!--pnode->nr_populated_rqs)
+		atomic_dec(&scx_nr_populated_nodes);
+}
+
+/* @rq's CPU is going down and has no tasks */
+void scx_rq_dying(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+
+	dl_server_stop(&rq->ext_server);
+
+	if (rq->scx.flags & SCX_RQ_POPULATED)
+		clear_rq_populated(rq);
+}
+
 static void rq_online_scx(struct rq *rq)
 {
 	rq->scx.flags |= SCX_RQ_ONLINE;
@@ -4339,6 +4395,96 @@ static void scx_watchdog_workfn(struct work_struct *work)
 		queue_delayed_work(system_dfl_wq, to_delayed_work(work), intv);
 }
 
+/* whether @rq's %SCX_RQ_POPULATED is due for clearing */
+static bool rq_populated_expired(struct rq *rq)
+{
+	return (rq->scx.flags & SCX_RQ_POPULATED) && !rq->scx.nr_running &&
+		time_after(jiffies, rq->scx.empty_at + SCX_EXT_SERVER_INTV);
+}
+
+/**
+ * ext_server_timerfn - Unmark a node's rqs which have no tasks
+ * @timer: ext_server_timer of the node's scx_pnode
+ *
+ * ext_server_tick() needs to know whether any task is runnable on SCX. An rq is
+ * marked %SCX_RQ_POPULATED and counted in its node's ->nr_populated_rqs when a
+ * task is enqueued on it. The mark is cleared here, after the rq has had no
+ * tasks for %SCX_EXT_SERVER_INTV, so that an rq which keeps running out of
+ * tasks doesn't write the count each time.
+ *
+ * scx_nr_populated_nodes is the number of nodes which have populated rqs. A
+ * node is counted when its first rq becomes populated and uncounted when its
+ * last one is unmarked. ext_server_tick() tests it without a lock and can see a
+ * newly populated node a tick late.
+ *
+ * scx_rq_dying() clears the mark of an offline CPU, which isn't in
+ * cpumask_of_node().
+ */
+static void ext_server_timerfn(struct timer_list *timer)
+{
+	struct scx_pnode *pnode = timer_container_of(pnode, timer, ext_server_timer);
+	s32 cpu;
+
+	for_each_cpu(cpu, cpumask_of_node(pnode->node)) {
+		struct rq *rq = cpu_rq(cpu);
+
+		/* most rqs fail the test, try before taking the rq lock */
+		if (!data_race(rq_populated_expired(rq)))
+			continue;
+
+		guard(rq_lock_irqsave)(rq);
+
+		if (rq_populated_expired(rq))
+			clear_rq_populated(rq);
+	}
+
+	guard(raw_spinlock_irqsave)(&pnode->lock);
+	if (pnode->nr_populated_rqs)
+		mod_timer(timer, round_jiffies_up(jiffies + SCX_EXT_SERVER_INTV));
+}
+
+/**
+ * ext_server_tick - Start ext_server if tasks may be waiting for the CPU
+ * @rq: rq of the CPU the tick is for
+ *
+ * ext_server starts when the first task is enqueued on @rq and stops when its
+ * pick finds no task. While a higher class task runs on the CPU, ext_server can
+ * be stopped with tasks waiting for the CPU in two cases. Start it for both.
+ *
+ * - A task reached the local DSQ after the pick, without being enqueued on @rq.
+ *   Start ext_server right away.
+ *
+ * - The BPF scheduler can run a task on any CPU the task is allowed on,
+ *   whichever rq it is queued on. Only ops.dispatch() can tell whether this CPU
+ *   has a task to run. If any rq is populated, start ext_server so that the CPU
+ *   dispatches, at most once a server period.
+ */
+static void ext_server_tick(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->ext_server;
+
+	if (dl_server_active(dl_se) ||
+	    !sched_class_above(rq->donor->sched_class, &ext_sched_class))
+		return;
+
+	if (rq->scx.local_dsq.nr) {
+		dl_server_start(dl_se);
+		return;
+	}
+
+	/*
+	 * With no task known to be waiting for this CPU, wait for the deadline
+	 * of the last period. A start before it can queue ext_server right
+	 * away, and the higher class task would then be preempted for an empty
+	 * pick on every tick.
+	 */
+	if (dl_time_before(rq_clock(rq), dl_se->deadline))
+		return;
+
+	if (atomic_read(&scx_nr_populated_nodes))
+		dl_server_start(dl_se);
+}
+
 void scx_tick(struct rq *rq)
 {
 	struct scx_sched *root;
@@ -4362,6 +4508,7 @@ void scx_tick(struct rq *rq)
 	}
 
 	update_other_load_avgs(rq);
+	ext_server_tick(rq);
 }
 
 static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
@@ -9547,7 +9694,7 @@ static struct notifier_block scx_pm_notifier = {
 
 void __init init_sched_ext_class(void)
 {
-	s32 cpu, v;
+	s32 cpu, node, v;
 
 	/*
 	 * The following is to prevent the compiler from optimizing out the enum
@@ -9590,6 +9737,19 @@ void __init init_sched_ext_class(void)
 	register_sysrq_key('D', &sysrq_sched_ext_dump_op);
 	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
 
+	scx_pnode = kzalloc_objs(*scx_pnode, nr_node_ids);
+	BUG_ON(!scx_pnode);
+	for_each_node(node) {
+		struct scx_pnode *pnode;
+
+		pnode = kzalloc_node(sizeof(*pnode), GFP_KERNEL, node);
+		BUG_ON(!pnode);
+		pnode->node = node;
+		raw_spin_lock_init(&pnode->lock);
+		timer_setup(&pnode->ext_server_timer, ext_server_timerfn, 0);
+		scx_pnode[node] = pnode;
+	}
+
 #ifdef CONFIG_EXT_SUB_SCHED
 	BUG_ON(rhashtable_init(&scx_sched_hash, &scx_sched_hash_params));
 #endif	/* CONFIG_EXT_SUB_SCHED */
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index d32bc01071b0..366cc1d7089b 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -17,6 +17,7 @@ void scx_cancel_fork(struct task_struct *p);
 bool scx_can_stop_tick(struct rq *rq);
 void scx_rq_activate(struct rq *rq);
 void scx_rq_deactivate(struct rq *rq);
+void scx_rq_dying(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
 void scx_prepare_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(int policy);
@@ -70,6 +71,7 @@ static inline u32 scx_cpuperf_target(s32 cpu) { return 0; }
 static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void scx_rq_activate(struct rq *rq) {}
 static inline void scx_rq_deactivate(struct rq *rq) {}
+static inline void scx_rq_dying(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
 static inline void scx_prepare_setscheduler(struct task_struct *p, int policy) {}
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
diff --git a/kernel/sched/ext/types.h b/kernel/sched/ext/types.h
index 38514d6bf149..17d728c9cfbd 100644
--- a/kernel/sched/ext/types.h
+++ b/kernel/sched/ext/types.h
@@ -18,6 +18,7 @@ enum scx_consts {
 	SCX_DSP_DFL_MAX_BATCH		= 32,
 	SCX_DSP_MAX_LOOPS		= 32,
 	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
+	SCX_EXT_SERVER_INTV		= HZ,	/* see ext_server_timerfn() */
 
 	/* rescue knob defaults and limits, see scx_rescue_timerfn() */
 	SCX_RESCUE_DFL_BW_PPT		= 20,		/* parts per thousand, 2% */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9e7993256c81..57cbfe36e9af 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -804,6 +804,7 @@ enum scx_rq_flags {
 	SCX_RQ_PROXY_TICK	= 1 << 10, /* proxy execution requires the tick */
 	SCX_RQ_PROXY_PENDING	= 1 << 11, /* blocked donor awaits proxy resolution */
 	SCX_RQ_PROXY_BLOCKING	= 1 << 12, /* donor is being removed for sched change */
+	SCX_RQ_POPULATED	= 1 << 13, /* see ext_server_timerfn() */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_DISPATCH	= 1 << 17,
@@ -838,6 +839,7 @@ struct scx_rq {
 	bool			cpu_released;
 	u32			flags;
 	u32			nr_immed;		/* ENQ_IMMED tasks on local_dsq */
+	unsigned long		empty_at;		/* when nr_running last became 0 */
 #ifdef CONFIG_SCHED_CORE
 	u32			lock_drop_seq;	/* nr dispatch lock releases */
 #endif
-- 
2.56.1

