Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08660426D0A;
	Wed, 21 Jan 2026 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037110; cv=none; b=YoZDks0babmetT2C7XeHumPn0piiIS5VRYnUO4sEiEf1ivDYk9AJjqywBTJ7BRDRy24Ol/G1HyrbEH84WbLHEITn4RH2UJTMrtB1dNCiFdSeHPQ4AIqyhfqtoceznbZkZPYko3YVdBbLvCiEmLxZA6fYPH7gLvFCTTsGNDpCgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037110; c=relaxed/simple;
	bh=m68bAoyE06HzCdW3IyErBHsQc3BWajl1iNhYUQzPC4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnSK06jNSYKYa4UoGBUlj2kM33AtZTgOiWaNhxPxddBNcnOQ9vy651brjRGKZoiH1ChfP6y58qihwBE9ryHIu72EGqoEQtmilYyVjTKS4H75cnIvcUe/qhpuM4+yXnwm+dWsxrzXRGeBFbpmQImVAMMeO1PWbDvKL0+hjMEZOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB1ombl4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB1ombl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDE7C16AAE;
	Wed, 21 Jan 2026 23:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037109;
	bh=m68bAoyE06HzCdW3IyErBHsQc3BWajl1iNhYUQzPC4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HB1ombl4q7qmUKOmV9u3VrlETvCK7j3TghyI3fLapQPp+argbUhfBdgPRa/PUQjw/
	 TkPQ3PtJNu4HMLSD3nhcEcjdBA2ZOyJQLCr7/I3RCjTX9lUhXZaQSvBrclI5BlWoxo
	 /4+TSZC5qKNRbAS6MyOW/V+VPmYRdrGBbJyl1eNvCCMjUDx4uFYXm9aCQG2Qvp59Nq
	 SkuvMchYsozuSqYsMR0BIctpjeKemz/TOWZLh+F7KGOH1QnJpx9oIo9umZrVdw+4RW
	 vN3+IMmDDbQLXL8Ji16bGcb07fXxbjBUVHQm5ACav4NGkX5HEqjRVLBQcwmdUITRtE
	 neE57zIIYuxXw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/34] sched_ext: Introduce scx_task_sched[_rcu]()
Date: Wed, 21 Jan 2026 13:11:14 -1000
Message-ID: <20260121231140.832332-9-tj@kernel.org>
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

In preparation of multiple scheduler support, add p->scx.sched which points
to the scx_sched instance that the task is scheduled by, which is currently
always scx_root. Add scx_task_sched[_rcu]() accessors which return the
associated scx_sched of the specified task and replace the raw scx_root
dereferences with it where applicable. scx_task_on_sched() is also added to
test whether a given task is on the specified sched.

As scx_root is still the only scheduler, this shouldn't introduce
user-visible behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h   |  7 +++++
 kernel/sched/ext.c          | 63 +++++++++++++++++++++++--------------
 kernel/sched/ext_internal.h | 59 ++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 24 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 8b663658b95f..fef788dc867d 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -164,6 +164,13 @@ struct scx_sched;
  * for a task to be scheduled by SCX.
  */
 struct sched_ext_entity {
+#ifdef CONFIG_CGROUPS
+	/*
+	 * Associated scx_sched. Updated either during fork or while holding
+	 * both p->pi_lock and rq lock.
+	 */
+	struct scx_sched __rcu	*sched;
+#endif
 	struct scx_dispatch_q	*dsq;
 	struct scx_dsq_list_node dsq_list;	/* dispatch order */
 	struct rb_node		dsq_priq;	/* p->scx.dsq_vtime order */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 96937ce7041f..e7f35962dea9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -19,7 +19,7 @@ static DEFINE_RAW_SPINLOCK(scx_sched_lock);
  * are used as temporary markers to indicate that the dereferences need to be
  * updated to point to the associated scheduler instances rather than scx_root.
  */
-static struct scx_sched __rcu *scx_root;
+struct scx_sched __rcu *scx_root;
 
 /*
  * All scheds, writers must hold both scx_enable_mutex and scx_sched_lock.
@@ -303,9 +303,15 @@ static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos,
 
 	return NULL;
 }
+
+static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
+{
+	rcu_assign_pointer(p->scx.sched, sch);
+}
 #else	/* CONFIG_EXT_SUB_SCHED */
 static struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
 static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
+static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch) {}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
 /**
@@ -1483,7 +1489,7 @@ static bool scx_rq_online(struct rq *rq)
 static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			    int sticky_cpu)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	struct scx_dispatch_q *dsq;
 	unsigned long qseq;
@@ -1607,7 +1613,7 @@ static void clr_task_runnable(struct task_struct *p, bool reset_runnable_at)
 
 static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 	int sticky_cpu = p->scx.sticky_cpu;
 
 	if (enq_flags & ENQUEUE_WAKEUP)
@@ -1654,7 +1660,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 
 static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 	unsigned long opss;
 
 	/* dequeue is always temporary, don't reset runnable_at */
@@ -1703,7 +1709,7 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 
 static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	if (!(p->scx.flags & SCX_TASK_QUEUED)) {
 		WARN_ON_ONCE(task_runnable(p));
@@ -1747,8 +1753,8 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 
 static void yield_task_scx(struct rq *rq)
 {
-	struct scx_sched *sch = scx_root;
 	struct task_struct *p = rq->donor;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	if (SCX_HAS_OP(sch, yield))
 		SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, yield, rq, p, NULL);
@@ -1758,10 +1764,10 @@ static void yield_task_scx(struct rq *rq)
 
 static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 {
-	struct scx_sched *sch = scx_root;
 	struct task_struct *from = rq->donor;
+	struct scx_sched *sch = scx_task_sched(from);
 
-	if (SCX_HAS_OP(sch, yield))
+	if (SCX_HAS_OP(sch, yield) && sch == scx_task_sched(to))
 		return SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, yield, rq,
 					      from, to);
 	else
@@ -2423,7 +2429,7 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 	 */
 	while ((p = list_first_entry_or_null(&rq->scx.ddsp_deferred_locals,
 				struct task_struct, scx.dsq_list.node))) {
-		struct scx_sched *sch = scx_root;
+		struct scx_sched *sch = scx_task_sched(p);
 		struct scx_dispatch_q *dsq;
 
 		list_del_init(&p->scx.dsq_list.node);
@@ -2437,7 +2443,7 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
@@ -2534,7 +2540,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			      struct task_struct *next)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	/* see kick_cpus_irq_workfn() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
@@ -2628,14 +2634,14 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	if (keep_prev) {
 		p = prev;
 		if (!p->scx.slice)
-			refill_task_slice_dfl(rcu_dereference_sched(scx_root), p);
+			refill_task_slice_dfl(scx_task_sched(p), p);
 	} else {
 		p = first_local_task(rq);
 		if (!p)
 			return NULL;
 
 		if (unlikely(!p->scx.slice)) {
-			struct scx_sched *sch = rcu_dereference_sched(scx_root);
+			struct scx_sched *sch = scx_task_sched(p);
 
 			if (!scx_rq_bypassing(rq) && !sch->warned_zero_slice) {
 				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in %s()\n",
@@ -2696,7 +2702,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flags)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 	bool rq_bypass;
 
 	/*
@@ -2757,7 +2763,7 @@ static void task_woken_scx(struct rq *rq, struct task_struct *p)
 static void set_cpus_allowed_scx(struct task_struct *p,
 				 struct affinity_context *ac)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	set_cpus_allowed_common(p, ac);
 
@@ -2898,7 +2904,7 @@ void scx_tick(struct rq *rq)
 
 static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(curr);
 
 	update_curr_scx(rq);
 
@@ -3074,11 +3080,12 @@ static void scx_disable_task(struct task_struct *p)
 
 static void scx_exit_task(struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 	struct scx_exit_task_args args = {
 		.cancelled = false,
 	};
 
+	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
 	switch (scx_get_task_state(p)) {
@@ -3100,6 +3107,7 @@ static void scx_exit_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, exit_task))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, exit_task, task_rq(p),
 				 p, &args);
+	scx_set_task_sched(p, NULL);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
 
@@ -3129,12 +3137,18 @@ void scx_pre_fork(struct task_struct *p)
 
 int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
+	s32 ret;
+
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
-	if (scx_init_task_enabled)
-		return scx_init_task(p, task_group(p), true);
-	else
-		return 0;
+	if (scx_init_task_enabled) {
+		ret = scx_init_task(p, task_group(p), true);
+		if (!ret)
+			scx_set_task_sched(p, scx_root);
+		return ret;
+	}
+
+	return 0;
 }
 
 void scx_post_fork(struct task_struct *p)
@@ -3204,7 +3218,7 @@ void sched_ext_dead(struct task_struct *p)
 static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 			      const struct load_weight *lw)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	lockdep_assert_rq_held(task_rq(p));
 
@@ -3220,7 +3234,7 @@ static void prio_changed_scx(struct rq *rq, struct task_struct *p, u64 oldprio)
 
 static void switching_to_scx(struct rq *rq, struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	scx_enable_task(p);
 
@@ -3866,7 +3880,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 	if (!scx_enabled())
 		return true;
 
-	sch = rcu_dereference_sched(scx_root);
+	sch = scx_task_sched(p);
 	if (unlikely(!sch))
 		return true;
 
@@ -5366,6 +5380,7 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			goto err_disable_unlock_all;
 		}
 
+		scx_set_task_sched(p, sch);
 		scx_set_task_state(p, SCX_TASK_READY);
 
 		put_task_struct(p);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index c98d63e49017..0081c9da55de 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1134,6 +1134,7 @@ enum scx_ops_state {
 #define SCX_OPSS_STATE_MASK	((1LU << SCX_OPSS_QSEQ_SHIFT) - 1)
 #define SCX_OPSS_QSEQ_MASK	(~SCX_OPSS_STATE_MASK)
 
+extern struct scx_sched __rcu *scx_root;
 DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
 /*
@@ -1154,3 +1155,61 @@ static inline bool scx_rq_bypassing(struct rq *rq)
 {
 	return unlikely(rq->scx.flags & SCX_RQ_BYPASSING);
 }
+
+#ifdef CONFIG_EXT_SUB_SCHED
+/**
+ * scx_task_sched - Find scx_sched scheduling a task
+ * @p: task of interest
+ *
+ * Return @p's scheduler instance. Must be called with @p's pi_lock or rq lock
+ * held.
+ */
+static inline struct scx_sched *scx_task_sched(const struct task_struct *p)
+{
+	return rcu_dereference_protected(p->scx.sched,
+					 lockdep_is_held(&p->pi_lock) ||
+					 lockdep_is_held(__rq_lockp(task_rq(p))));
+}
+
+/**
+ * scx_task_sched_rcu - Find scx_sched scheduling a task
+ * @p: task of interest
+ *
+ * Return @p's scheduler instance. The returned scx_sched is RCU protected.
+ */
+static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
+{
+	return rcu_dereference_all(p->scx.sched);
+}
+
+/**
+ * scx_task_on_sched - Is a task on the specified sched?
+ * @sch: sched to test against
+ * @p: task of interest
+ *
+ * Returns %true if @p is on @sch, %false otherwise.
+ */
+static inline bool scx_task_on_sched(struct scx_sched *sch,
+				     const struct task_struct *p)
+{
+	return rcu_access_pointer(p->scx.sched) == sch;
+}
+#else	/* CONFIG_EXT_SUB_SCHED */
+static inline struct scx_sched *scx_task_sched(const struct task_struct *p)
+{
+	return rcu_dereference_protected(scx_root,
+					 lockdep_is_held(&p->pi_lock) ||
+					 lockdep_is_held(__rq_lockp(task_rq(p))));
+}
+
+static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
+{
+	return rcu_dereference_all(scx_root);
+}
+
+static inline bool scx_task_on_sched(struct scx_sched *sch,
+				     const struct task_struct *p)
+{
+	return true;
+}
+#endif	/* CONFIG_EXT_SUB_SCHED */
-- 
2.52.0

