Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F0329E73;
	Tue, 11 Nov 2025 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888714; cv=none; b=BIiLc1p96Uig0Qogt61Rzh0IXin6Ifr9etcaTGTXTTdz+stJHKErubaRJ7T87O4WVJ+hVx49m8n2dE7vlMgoYUepStXjkR4bWOZ8eEcARaYy4F2vAXbY8sqXlC1qkc4zdo9UODO5eECs09ySksQy1905JvbxFFIDs12b7EINAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888714; c=relaxed/simple;
	bh=O9/QROMqplkDLF8YhKD1Pp86zfv5z+91duJ83cghrAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOQzzmlQc3+HmhKrJzAkF394fHuEu4uaXaU+qzB4uXmtl+UnTnS0Wjk9MzmHI9xeN0/YrK8r09kZTrt4Fmse52rSKZEVXBf/SOTaGFjuSXyvPPqwdp/KjsxxvVFDLFpEXcjl59TSBlyEJ/7rUZbdUBOTXtA9i3SCDlSjokhV7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rte8dIe6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rte8dIe6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94245C4CEF5;
	Tue, 11 Nov 2025 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888711;
	bh=O9/QROMqplkDLF8YhKD1Pp86zfv5z+91duJ83cghrAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rte8dIe6sc7FnbCdRBQwSdfdqBu39Q+w530RIX+2A7MeqtgME05k6PbvW2hNxbq/B
	 StmYqoEpXxwmLvCQJNuH8QNZ3SOB45yqr+1n/vi8qChSjxgoRHRYvmEu4MS3p4KSnx
	 Eri0UP3A2E7R2izroQ451v7rOHiRJ6zRF30Pi7KsnLD5BbzGY7NmSON9X+uWUNfgVx
	 pA7wdgq4XKOBQWD4TQ2eTGspDIfEi9sT0sFJYFrhXlGg11bWmH4tr0huxgfJgdVylb
	 bPfMcJV/FsEikGbhRX79wdUcTgckGFLi+fVn9GFjIHjCvqdgiiaPmkkS5XKVe37EmW
	 tkKywAjNSyYnQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH 13/13] sched_ext: Implement load balancer for bypass mode
Date: Tue, 11 Nov 2025 09:18:16 -1000
Message-ID: <20251111191816.862797-14-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bypass mode, tasks are queued on per-CPU bypass DSQs. While this works well
in most cases, there is a failure mode where a BPF scheduler can skew task
placement severely before triggering bypass in highly over-saturated systems.
If most tasks end up concentrated on a few CPUs, those CPUs can accumulate
queues that are too long to drain in a reasonable time, leading to RCU stalls
and hung tasks.

Implement a simple timer-based load balancer that redistributes tasks across
CPUs within each NUMA node. The balancer runs periodically (default 500ms,
tunable via bypass_lb_intv_us module parameter) and moves tasks from overloaded
CPUs to underloaded ones.

When moving tasks between bypass DSQs, the load balancer holds nested DSQ locks
to avoid dropping and reacquiring the donor DSQ lock on each iteration, as
donor DSQs can be very long and highly contended. Add the SCX_ENQ_NESTED flag
and use raw_spin_lock_nested() in dispatch_enqueue() to support this. The load
balancer timer function reads scx_bypass_depth locklessly to check whether
bypass mode is active. Use WRITE_ONCE() when updating scx_bypass_depth to pair
with the READ_ONCE() in the timer function.

This has been tested on a 192 CPU dual socket AMD EPYC machine with ~20k
runnable tasks running scx_cpu0. As scx_cpu0 queues all tasks to CPU0, almost
all tasks end up on CPU0 creating severe imbalance. Without the load balancer,
disabling the scheduler can lead to RCU stalls and hung tasks, taking a very
long time to complete. With the load balancer, disable completes in about a
second.

The load balancing operation can be monitored using the sched_ext_bypass_lb
tracepoint and disabled by setting bypass_lb_intv_us to 0.

v2: Lock both rq and DSQ in bypass_lb_cpu() and use dispatch_dequeue_locked()
    to prevent races with dispatch_dequeue() (Andrea Righi).

Cc: Andrea Righi <arighi@nvidia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/trace/events/sched_ext.h |  39 +++++
 kernel/sched/ext.c               | 239 ++++++++++++++++++++++++++++++-
 kernel/sched/ext_internal.h      |   6 +
 3 files changed, 281 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
index 50e4b712735a..d1bf5acd59c5 100644
--- a/include/trace/events/sched_ext.h
+++ b/include/trace/events/sched_ext.h
@@ -45,6 +45,45 @@ TRACE_EVENT(sched_ext_event,
 	)
 );
 
+TRACE_EVENT(sched_ext_bypass_lb,
+
+	TP_PROTO(__u32 node, __u32 nr_cpus, __u32 nr_tasks, __u32 nr_balanced,
+		 __u32 before_min, __u32 before_max,
+		 __u32 after_min, __u32 after_max),
+
+	TP_ARGS(node, nr_cpus, nr_tasks, nr_balanced,
+		before_min, before_max, after_min, after_max),
+
+	TP_STRUCT__entry(
+		__field(	__u32,		node		)
+		__field(	__u32,		nr_cpus		)
+		__field(	__u32,		nr_tasks	)
+		__field(	__u32,		nr_balanced	)
+		__field(	__u32,		before_min	)
+		__field(	__u32,		before_max	)
+		__field(	__u32,		after_min	)
+		__field(	__u32,		after_max	)
+	),
+
+	TP_fast_assign(
+		__entry->node		= node;
+		__entry->nr_cpus	= nr_cpus;
+		__entry->nr_tasks	= nr_tasks;
+		__entry->nr_balanced	= nr_balanced;
+		__entry->before_min	= before_min;
+		__entry->before_max	= before_max;
+		__entry->after_min	= after_min;
+		__entry->after_max	= after_max;
+	),
+
+	TP_printk("node %u: nr_cpus=%u nr_tasks=%u nr_balanced=%u min=%u->%u max=%u->%u",
+		  __entry->node, __entry->nr_cpus,
+		  __entry->nr_tasks, __entry->nr_balanced,
+		  __entry->before_min, __entry->after_min,
+		  __entry->before_max, __entry->after_max
+	)
+);
+
 #endif /* _TRACE_SCHED_EXT_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 10d8532f8d9b..c900667b25b8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -34,6 +34,8 @@ DEFINE_STATIC_KEY_FALSE(__scx_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
 static int scx_bypass_depth;
+static cpumask_var_t scx_bypass_lb_donee_cpumask;
+static cpumask_var_t scx_bypass_lb_resched_cpumask;
 static bool scx_aborting;
 static bool scx_init_task_enabled;
 static bool scx_switching_all;
@@ -149,6 +151,7 @@ static struct kset *scx_kset;
  */
 static u64 scx_slice_dfl = SCX_SLICE_DFL;
 static unsigned int scx_slice_bypass_us = SCX_SLICE_BYPASS / NSEC_PER_USEC;
+static unsigned int scx_bypass_lb_intv_us = SCX_BYPASS_LB_DFL_INTV_US;
 
 static int set_slice_us(const char *val, const struct kernel_param *kp)
 {
@@ -160,11 +163,23 @@ static const struct kernel_param_ops slice_us_param_ops = {
 	.get = param_get_uint,
 };
 
+static int set_bypass_lb_intv_us(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 0, 10 * USEC_PER_SEC);
+}
+
+static const struct kernel_param_ops bypass_lb_intv_us_param_ops = {
+	.set = set_bypass_lb_intv_us,
+	.get = param_get_uint,
+};
+
 #undef MODULE_PARAM_PREFIX
 #define MODULE_PARAM_PREFIX	"sched_ext."
 
 module_param_cb(slice_bypass_us, &slice_us_param_ops, &scx_slice_bypass_us, 0600);
 MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]load (100us to 100ms)");
+module_param_cb(bypass_lb_intv_us, &bypass_lb_intv_us_param_ops, &scx_bypass_lb_intv_us, 0600);
+MODULE_PARM_DESC(bypass_lb_intv_us, "bypass load balance interval in microseconds (0 (disable) to 10s)");
 
 #undef MODULE_PARAM_PREFIX
 
@@ -962,7 +977,9 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 		     !RB_EMPTY_NODE(&p->scx.dsq_priq));
 
 	if (!is_local) {
-		raw_spin_lock(&dsq->lock);
+		raw_spin_lock_nested(&dsq->lock,
+			(enq_flags & SCX_ENQ_NESTED) ? SINGLE_DEPTH_NESTING : 0);
+
 		if (unlikely(dsq->id == SCX_DSQ_INVALID)) {
 			scx_error(sch, "attempting to dispatch to a destroyed dsq");
 			/* fall back to the global dsq */
@@ -3744,6 +3761,207 @@ bool scx_hardlockup(void)
 	return true;
 }
 
+static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
+			 struct cpumask *donee_mask, struct cpumask *resched_mask,
+			 u32 nr_donor_target, u32 nr_donee_target)
+{
+	struct scx_dispatch_q *donor_dsq = &rq->scx.bypass_dsq;
+	struct task_struct *p, *n;
+	struct scx_dsq_list_node cursor = INIT_DSQ_LIST_CURSOR(cursor, 0, 0);
+	s32 delta = READ_ONCE(donor_dsq->nr) - nr_donor_target;
+	u32 nr_balanced = 0, min_delta_us;
+
+	/*
+	 * All we want to guarantee is reasonable forward progress. No reason to
+	 * fine tune. Assuming every task on @donor_dsq runs their full slice,
+	 * consider offloading iff the total queued duration is over the
+	 * threshold.
+	 */
+	min_delta_us = scx_bypass_lb_intv_us / SCX_BYPASS_LB_MIN_DELTA_DIV;
+	if (delta < DIV_ROUND_UP(min_delta_us, scx_slice_bypass_us))
+		return 0;
+
+	raw_spin_rq_lock_irq(rq);
+	raw_spin_lock(&donor_dsq->lock);
+	list_add(&cursor.node, &donor_dsq->list);
+resume:
+	n = container_of(&cursor, struct task_struct, scx.dsq_list);
+	n = nldsq_next_task(donor_dsq, n, false);
+
+	while ((p = n)) {
+		struct rq *donee_rq;
+		struct scx_dispatch_q *donee_dsq;
+		int donee;
+
+		n = nldsq_next_task(donor_dsq, n, false);
+
+		if (donor_dsq->nr <= nr_donor_target)
+			break;
+
+		if (cpumask_empty(donee_mask))
+			break;
+
+		donee = cpumask_any_and_distribute(donee_mask, p->cpus_ptr);
+		if (donee >= nr_cpu_ids)
+			continue;
+
+		donee_rq = cpu_rq(donee);
+		donee_dsq = &donee_rq->scx.bypass_dsq;
+
+		/*
+		 * $p's rq is not locked but $p's DSQ lock protects its
+		 * scheduling properties making this test safe.
+		 */
+		if (!task_can_run_on_remote_rq(sch, p, donee_rq, false))
+			continue;
+
+		/*
+		 * Moving $p from one non-local DSQ to another. The source rq
+		 * and DSQ are already locked. Do an abbreviated dequeue and
+		 * then perform enqueue without unlocking $donor_dsq.
+		 *
+		 * We don't want to drop and reacquire the lock on each
+		 * iteration as @donor_dsq can be very long and potentially
+		 * highly contended. Donee DSQs are less likely to be contended.
+		 * The nested locking is safe as only this LB moves tasks
+		 * between bypass DSQs.
+		 */
+		dispatch_dequeue_locked(p, donor_dsq);
+		dispatch_enqueue(sch, donee_dsq, p, SCX_ENQ_NESTED);
+
+		/*
+		 * $donee might have been idle and need to be woken up. No need
+		 * to be clever. Kick every CPU that receives tasks.
+		 */
+		cpumask_set_cpu(donee, resched_mask);
+
+		if (READ_ONCE(donee_dsq->nr) >= nr_donee_target)
+			cpumask_clear_cpu(donee, donee_mask);
+
+		nr_balanced++;
+		if (!(nr_balanced % SCX_BYPASS_LB_BATCH) && n) {
+			list_move_tail(&cursor.node, &n->scx.dsq_list.node);
+			raw_spin_unlock(&donor_dsq->lock);
+			raw_spin_rq_unlock_irq(rq);
+			cpu_relax();
+			raw_spin_rq_lock_irq(rq);
+			raw_spin_lock(&donor_dsq->lock);
+			goto resume;
+		}
+	}
+
+	list_del_init(&cursor.node);
+	raw_spin_unlock(&donor_dsq->lock);
+	raw_spin_rq_unlock_irq(rq);
+
+	return nr_balanced;
+}
+
+static void bypass_lb_node(struct scx_sched *sch, int node)
+{
+	const struct cpumask *node_mask = cpumask_of_node(node);
+	struct cpumask *donee_mask = scx_bypass_lb_donee_cpumask;
+	struct cpumask *resched_mask = scx_bypass_lb_resched_cpumask;
+	u32 nr_tasks = 0, nr_cpus = 0, nr_balanced = 0;
+	u32 nr_target, nr_donor_target;
+	u32 before_min = U32_MAX, before_max = 0;
+	u32 after_min = U32_MAX, after_max = 0;
+	int cpu;
+
+	/* count the target tasks and CPUs */
+	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
+		u32 nr = READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr);
+
+		nr_tasks += nr;
+		nr_cpus++;
+
+		before_min = min(nr, before_min);
+		before_max = max(nr, before_max);
+	}
+
+	if (!nr_cpus)
+		return;
+
+	/*
+	 * We don't want CPUs to have more than $nr_donor_target tasks and
+	 * balancing to fill donee CPUs upto $nr_target. Once targets are
+	 * calculated, find the donee CPUs.
+	 */
+	nr_target = DIV_ROUND_UP(nr_tasks, nr_cpus);
+	nr_donor_target = DIV_ROUND_UP(nr_target * SCX_BYPASS_LB_DONOR_PCT, 100);
+
+	cpumask_clear(donee_mask);
+	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
+		if (READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr) < nr_target)
+			cpumask_set_cpu(cpu, donee_mask);
+	}
+
+	/* iterate !donee CPUs and see if they should be offloaded */
+	cpumask_clear(resched_mask);
+	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
+		struct rq *rq = cpu_rq(cpu);
+		struct scx_dispatch_q *donor_dsq = &rq->scx.bypass_dsq;
+
+		if (cpumask_empty(donee_mask))
+			break;
+		if (cpumask_test_cpu(cpu, donee_mask))
+			continue;
+		if (READ_ONCE(donor_dsq->nr) <= nr_donor_target)
+			continue;
+
+		nr_balanced += bypass_lb_cpu(sch, rq, donee_mask, resched_mask,
+					     nr_donor_target, nr_target);
+	}
+
+	for_each_cpu(cpu, resched_mask) {
+		struct rq *rq = cpu_rq(cpu);
+
+		raw_spin_rq_lock_irq(rq);
+		resched_curr(rq);
+		raw_spin_rq_unlock_irq(rq);
+	}
+
+	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
+		u32 nr = READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr);
+
+		after_min = min(nr, after_min);
+		after_max = max(nr, after_max);
+
+	}
+
+	trace_sched_ext_bypass_lb(node, nr_cpus, nr_tasks, nr_balanced,
+				  before_min, before_max, after_min, after_max);
+}
+
+/*
+ * In bypass mode, all tasks are put on the per-CPU bypass DSQs. If the machine
+ * is over-saturated and the BPF scheduler skewed tasks into few CPUs, some
+ * bypass DSQs can be overloaded. If there are enough tasks to saturate other
+ * lightly loaded CPUs, such imbalance can lead to very high execution latency
+ * on the overloaded CPUs and thus to hung tasks and RCU stalls. To avoid such
+ * outcomes, a simple load balancing mechanism is implemented by the following
+ * timer which runs periodically while bypass mode is in effect.
+ */
+static void scx_bypass_lb_timerfn(struct timer_list *timer)
+{
+	struct scx_sched *sch;
+	int node;
+	u32 intv_us;
+
+	sch = rcu_dereference_all(scx_root);
+	if (unlikely(!sch) || !READ_ONCE(scx_bypass_depth))
+		return;
+
+	for_each_node_with_cpus(node)
+		bypass_lb_node(sch, node);
+
+	intv_us = READ_ONCE(scx_bypass_lb_intv_us);
+	if (intv_us)
+		mod_timer(timer, jiffies + usecs_to_jiffies(intv_us));
+}
+
+static DEFINE_TIMER(scx_bypass_lb_timer, scx_bypass_lb_timerfn);
+
 /**
  * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
  * @bypass: true for bypass, false for unbypass
@@ -3787,7 +4005,9 @@ static void scx_bypass(bool bypass)
 	sch = rcu_dereference_bh(scx_root);
 
 	if (bypass) {
-		scx_bypass_depth++;
+		u32 intv_us;
+
+		WRITE_ONCE(scx_bypass_depth, scx_bypass_depth + 1);
 		WARN_ON_ONCE(scx_bypass_depth <= 0);
 		if (scx_bypass_depth != 1)
 			goto unlock;
@@ -3795,8 +4015,15 @@ static void scx_bypass(bool bypass)
 		bypass_timestamp = ktime_get_ns();
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
+
+		intv_us = READ_ONCE(scx_bypass_lb_intv_us);
+		if (intv_us && !timer_pending(&scx_bypass_lb_timer)) {
+			scx_bypass_lb_timer.expires =
+				jiffies + usecs_to_jiffies(intv_us);
+			add_timer_global(&scx_bypass_lb_timer);
+		}
 	} else {
-		scx_bypass_depth--;
+		WRITE_ONCE(scx_bypass_depth, scx_bypass_depth - 1);
 		WARN_ON_ONCE(scx_bypass_depth < 0);
 		if (scx_bypass_depth != 0)
 			goto unlock;
@@ -7052,6 +7279,12 @@ static int __init scx_init(void)
 		return ret;
 	}
 
+	if (!alloc_cpumask_var(&scx_bypass_lb_donee_cpumask, GFP_KERNEL) ||
+	    !alloc_cpumask_var(&scx_bypass_lb_resched_cpumask, GFP_KERNEL)) {
+		pr_err("sched_ext: Failed to allocate cpumasks\n");
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 __initcall(scx_init);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index dd6f25fb6159..386c677e4c9a 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -23,6 +23,11 @@ enum scx_consts {
 	 * scx_tasks_lock to avoid causing e.g. CSD and RCU stalls.
 	 */
 	SCX_TASK_ITER_BATCH		= 32,
+
+	SCX_BYPASS_LB_DFL_INTV_US	= 500 * USEC_PER_MSEC,
+	SCX_BYPASS_LB_DONOR_PCT		= 125,
+	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
+	SCX_BYPASS_LB_BATCH		= 256,
 };
 
 enum scx_exit_kind {
@@ -963,6 +968,7 @@ enum scx_enq_flags {
 
 	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
 	SCX_ENQ_DSQ_PRIQ	= 1LLU << 57,
+	SCX_ENQ_NESTED		= 1LLU << 58,
 };
 
 enum scx_deq_flags {
-- 
2.51.2

