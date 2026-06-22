Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD13403E4;
	Mon, 22 Jun 2026 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149948; cv=none; b=hNIwpNm0GVRcp+wyxs4mo+mkbFqwQ3e9Y17SB1kYOXMMuPUaWEuQtVPnota0FlAD5PWYpWZ2dfykX3IDCx1tNnUMP7SXYJCNow9+pYaTAq0l/rtFM97gp2iolo7+3j6GFWunFKWFJF3OViZRSUNGVX5cxwyFToctRonm0eossU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149948; c=relaxed/simple;
	bh=t33aOzZC6hTGOhd6aAVzheQdxOv7Oz0UHzgaKLuXHEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L15pMGwfQD9lrOPQ3jt1lX3qT85iUlPl33Hn8Yl47fqcLeINiKCgcAaV272IT/LImvUNtEPqyKf/XKQGFxZ4mY0cqk/ivCaKu3fpOVDmGVqSSbvy1svRjURli4ttzmDbGnwFCBbOr07PglJMB3xOYcXqZnXYu4Ju1C8ylE2SnQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwYWYyO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwYWYyO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D6A1F00A3A;
	Mon, 22 Jun 2026 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149946;
	bh=arQM8lOB2e6J6pPRiGEtO2odQzQxb13X+doZnd82CMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fwYWYyO1fT3+xp6xF47p1D1AbzZpuSysN8r3Ruy7tiSHPkLAoeO7XgP7Wc3jjkvcw
	 Qp3tzgyvqd8rBc14OwMRd2TU3xOjlUnrH5mJVHLNSBycYqLn1bYUH/Ss6t9Dv9YtBA
	 d5Zu8u5AiC3/E+aVtZ1ZPY0cSKk13DPk0ng2BAvo8uju5SbwRTQXVKn53+VDM421eb
	 /6xyJ4qqaKBivBHr3ahNIypkdY8UNj5LiwSeJ+ugkDHgW/m5bJxOO0yXK1H5J8LSCl
	 z75eDr6G8Jpvxcwc8R7S7kVt/eJX+BUFw2ywLLBOmQu2zZJzrS7AK1QGk/Ca97Nw52
	 nTFVcRH1eNaMQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.2 2/2] sched_ext: Move shared helpers from ext.c into internal.h and cid.h
Date: Mon, 22 Jun 2026 07:39:04 -1000
Message-ID: <20260622173904.1169407-2-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622173904.1169407-1-tj@kernel.org>
References: <20260622173904.1169407-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idle.c and cid.c are included into build_policy.c together with ext.c and
use helpers that ext.c defines. Because the helpers live in ext.c, the two
files can not parse as standalone units and clangd reports errors in them.

Move the helpers to the headers they belong to. The op-dispatch macros and
helpers plus scx_parent() to internal.h, and scx_cpu_arg()/scx_cpu_ret() to
cid.h. No functional change. idle.c and cid.c now parse clean standalone.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/cid.h      |  21 ++++++
 kernel/sched/ext/ext.c      | 141 ------------------------------------
 kernel/sched/ext/internal.h | 121 +++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 141 deletions(-)

diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
index 41d0802c6af3..9c4f4b907f12 100644
--- a/kernel/sched/ext/cid.h
+++ b/kernel/sched/ext/cid.h
@@ -270,4 +270,25 @@ static inline u32 scx_cmask_nr_used_words(const struct scx_cmask *m)
 		     __w && ((cid) = __bs + __wi * 64 + __ffs64(__w), true);	\
 		     __w &= __w - 1)
 
+/*
+ * scx_cpu_arg() wraps a cpu arg being handed to an SCX op. For cid-form
+ * schedulers it resolves to the matching cid; for cpu-form it passes @cpu
+ * through. scx_cpu_ret() is the inverse for a cpu/cid returned from an op
+ * (currently only ops.select_cpu); it validates the BPF-supplied cid and
+ * triggers scx_error() on @sch if invalid.
+ */
+static inline s32 scx_cpu_arg(s32 cpu)
+{
+	if (scx_is_cid_type())
+		return __scx_cpu_to_cid(cpu);
+	return cpu;
+}
+
+static inline s32 scx_cpu_ret(struct scx_sched *sch, s32 cpu_or_cid)
+{
+	if (cpu_or_cid < 0 || !scx_is_cid_type())
+		return cpu_or_cid;
+	return scx_cid_to_cpu(sch, cpu_or_cid);
+}
+
 #endif /* _KERNEL_SCHED_EXT_CID_H */
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ebf6dc84cb4d..dd41b84ae680 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -258,8 +258,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch,
 	return ret;
 }
 
-#define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
-
 static long jiffies_delta_msecs(unsigned long at, unsigned long now)
 {
 	if (time_after(at, now))
@@ -274,20 +272,6 @@ static bool u32_before(u32 a, u32 b)
 }
 
 #ifdef CONFIG_EXT_SUB_SCHED
-/**
- * scx_parent - Find the parent sched
- * @sch: sched to find the parent of
- *
- * Returns the parent scheduler or %NULL if @sch is root.
- */
-static struct scx_sched *scx_parent(struct scx_sched *sch)
-{
-	if (sch->level)
-		return sch->ancestors[sch->level - 1];
-	else
-		return NULL;
-}
-
 /**
  * scx_next_descendant_pre - find the next descendant for pre-order walk
  * @pos: the current position (%NULL to initiate traversal)
@@ -335,7 +319,6 @@ static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
 	rcu_assign_pointer(p->scx.sched, sch);
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
-static inline struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
 static inline struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
 static inline void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch) {}
 #endif	/* CONFIG_EXT_SUB_SCHED */
@@ -495,123 +478,12 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
  */
 DEFINE_PER_CPU(struct rq *, scx_locked_rq_state);
 
-static inline void update_locked_rq(struct rq *rq)
-{
-	/*
-	 * Check whether @rq is actually locked. This can help expose bugs
-	 * or incorrect assumptions about the context in which a kfunc or
-	 * callback is executed.
-	 */
-	if (rq)
-		lockdep_assert_rq_held(rq);
-	__this_cpu_write(scx_locked_rq_state, rq);
-}
-
-/*
- * SCX ops can recurse via scx_bpf_sub_dispatch() - the inner call must not
- * clobber the outer's scx_locked_rq_state. Save it on entry, restore on exit.
- */
-#define SCX_CALL_OP(sch, op, locked_rq, args...)				\
-do {										\
-	struct rq *__prev_locked_rq;						\
-										\
-	if (locked_rq) {							\
-		__prev_locked_rq = scx_locked_rq();				\
-		update_locked_rq(locked_rq);					\
-	}									\
-	(sch)->ops.op(args);							\
-	if (locked_rq)								\
-		update_locked_rq(__prev_locked_rq);				\
-} while (0)
-
 /*
  * Flipped on enable per sch->is_cid_type. Declared in internal.h so
  * subsystem inlines can read it.
  */
 DEFINE_STATIC_KEY_FALSE(__scx_is_cid_type);
 
-/*
- * scx_cpu_arg() wraps a cpu arg being handed to an SCX op. For cid-form
- * schedulers it resolves to the matching cid; for cpu-form it passes @cpu
- * through. scx_cpu_ret() is the inverse for a cpu/cid returned from an op
- * (currently only ops.select_cpu); it validates the BPF-supplied cid and
- * triggers scx_error() on @sch if invalid.
- */
-static s32 scx_cpu_arg(s32 cpu)
-{
-	if (scx_is_cid_type())
-		return __scx_cpu_to_cid(cpu);
-	return cpu;
-}
-
-static s32 scx_cpu_ret(struct scx_sched *sch, s32 cpu_or_cid)
-{
-	if (cpu_or_cid < 0 || !scx_is_cid_type())
-		return cpu_or_cid;
-	return scx_cid_to_cpu(sch, cpu_or_cid);
-}
-
-#define SCX_CALL_OP_RET(sch, op, locked_rq, args...)				\
-({										\
-	struct rq *__prev_locked_rq;						\
-	__typeof__((sch)->ops.op(args)) __ret;					\
-										\
-	if (locked_rq) {							\
-		__prev_locked_rq = scx_locked_rq();				\
-		update_locked_rq(locked_rq);					\
-	}									\
-	__ret = (sch)->ops.op(args);						\
-	if (locked_rq)								\
-		update_locked_rq(__prev_locked_rq);				\
-	__ret;									\
-})
-
-/*
- * SCX_CALL_OP_TASK*() invokes an SCX op that takes one or two task arguments
- * and records them in current->scx.kf_tasks[] for the duration of the call. A
- * kfunc invoked from inside such an op can then use
- * scx_kf_arg_task_ok() to verify that its task argument is one of
- * those subject tasks.
- *
- * Every SCX_CALL_OP_TASK*() call site invokes its op with @p's rq lock held -
- * either via the @locked_rq argument here, or (for ops.select_cpu()) via @p's
- * pi_lock held by try_to_wake_up() with rq tracking via scx_rq.in_select_cpu.
- * So if kf_tasks[] is set, @p's scheduler-protected fields are stable.
- *
- * kf_tasks[] can not stack, so task-based SCX ops must not nest. The
- * WARN_ON_ONCE() in each macro catches a re-entry of any of the three variants
- * while a previous one is still in progress.
- */
-#define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
-do {										\
-	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
-	current->scx.kf_tasks[0] = task;					\
-	SCX_CALL_OP((sch), op, locked_rq, task, ##args);			\
-	current->scx.kf_tasks[0] = NULL;					\
-} while (0)
-
-#define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
-({										\
-	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
-	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
-	current->scx.kf_tasks[0] = task;					\
-	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task, ##args);		\
-	current->scx.kf_tasks[0] = NULL;					\
-	__ret;									\
-})
-
-#define SCX_CALL_OP_2TASKS_RET(sch, op, locked_rq, task0, task1, args...)	\
-({										\
-	__typeof__((sch)->ops.op(task0, task1, ##args)) __ret;			\
-	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
-	current->scx.kf_tasks[0] = task0;					\
-	current->scx.kf_tasks[1] = task1;					\
-	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task0, task1, ##args);	\
-	current->scx.kf_tasks[0] = NULL;					\
-	current->scx.kf_tasks[1] = NULL;					\
-	__ret;									\
-})
-
 /**
  * scx_call_op_set_cpumask - invoke ops.set_cpumask / ops_cid.set_cmask for @task
  * @sch: scx_sched being invoked
@@ -650,19 +522,6 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 	current->scx.kf_tasks[0] = NULL;
 }
 
-/* see SCX_CALL_OP_TASK() */
-static __always_inline bool scx_kf_arg_task_ok(struct scx_sched *sch,
-							struct task_struct *p)
-{
-	if (unlikely((p != current->scx.kf_tasks[0] &&
-		      p != current->scx.kf_tasks[1]))) {
-		scx_error(sch, "called on a task not being operated on");
-		return false;
-	}
-
-	return true;
-}
-
 enum scx_dsq_iter_flags {
 	/* iterate in the reverse dispatch order */
 	SCX_DSQ_ITER_REV		= 1U << 16,
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 1f5312b3b387..145272cb4d8a 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1553,6 +1553,111 @@ static inline struct rq *scx_locked_rq(void)
 	return __this_cpu_read(scx_locked_rq_state);
 }
 
+static inline void update_locked_rq(struct rq *rq)
+{
+	/*
+	 * Check whether @rq is actually locked. This can help expose bugs
+	 * or incorrect assumptions about the context in which a kfunc or
+	 * callback is executed.
+	 */
+	if (rq)
+		lockdep_assert_rq_held(rq);
+	__this_cpu_write(scx_locked_rq_state, rq);
+}
+
+#define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
+
+/*
+ * SCX ops can recurse via scx_bpf_sub_dispatch() - the inner call must not
+ * clobber the outer's scx_locked_rq_state. Save it on entry, restore on exit.
+ */
+#define SCX_CALL_OP(sch, op, locked_rq, args...)				\
+do {										\
+	struct rq *__prev_locked_rq;						\
+										\
+	if (locked_rq) {							\
+		__prev_locked_rq = scx_locked_rq();				\
+		update_locked_rq(locked_rq);					\
+	}									\
+	(sch)->ops.op(args);							\
+	if (locked_rq)								\
+		update_locked_rq(__prev_locked_rq);				\
+} while (0)
+
+#define SCX_CALL_OP_RET(sch, op, locked_rq, args...)				\
+({										\
+	struct rq *__prev_locked_rq;						\
+	__typeof__((sch)->ops.op(args)) __ret;					\
+										\
+	if (locked_rq) {							\
+		__prev_locked_rq = scx_locked_rq();				\
+		update_locked_rq(locked_rq);					\
+	}									\
+	__ret = (sch)->ops.op(args);						\
+	if (locked_rq)								\
+		update_locked_rq(__prev_locked_rq);				\
+	__ret;									\
+})
+
+/*
+ * SCX_CALL_OP_TASK*() invokes an SCX op that takes one or two task arguments
+ * and records them in current->scx.kf_tasks[] for the duration of the call. A
+ * kfunc invoked from inside such an op can then use
+ * scx_kf_arg_task_ok() to verify that its task argument is one of
+ * those subject tasks.
+ *
+ * Every SCX_CALL_OP_TASK*() call site invokes its op with @p's rq lock held -
+ * either via the @locked_rq argument here, or (for ops.select_cpu()) via @p's
+ * pi_lock held by try_to_wake_up() with rq tracking via scx_rq.in_select_cpu.
+ * So if kf_tasks[] is set, @p's scheduler-protected fields are stable.
+ *
+ * kf_tasks[] can not stack, so task-based SCX ops must not nest. The
+ * WARN_ON_ONCE() in each macro catches a re-entry of any of the three variants
+ * while a previous one is still in progress.
+ */
+#define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
+do {										\
+	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
+	current->scx.kf_tasks[0] = task;					\
+	SCX_CALL_OP((sch), op, locked_rq, task, ##args);			\
+	current->scx.kf_tasks[0] = NULL;					\
+} while (0)
+
+#define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
+({										\
+	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
+	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
+	current->scx.kf_tasks[0] = task;					\
+	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task, ##args);		\
+	current->scx.kf_tasks[0] = NULL;					\
+	__ret;									\
+})
+
+#define SCX_CALL_OP_2TASKS_RET(sch, op, locked_rq, task0, task1, args...)	\
+({										\
+	__typeof__((sch)->ops.op(task0, task1, ##args)) __ret;			\
+	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
+	current->scx.kf_tasks[0] = task0;					\
+	current->scx.kf_tasks[1] = task1;					\
+	__ret = SCX_CALL_OP_RET((sch), op, locked_rq, task0, task1, ##args);	\
+	current->scx.kf_tasks[0] = NULL;					\
+	current->scx.kf_tasks[1] = NULL;					\
+	__ret;									\
+})
+
+/* see SCX_CALL_OP_TASK() */
+static __always_inline bool scx_kf_arg_task_ok(struct scx_sched *sch,
+					       struct task_struct *p)
+{
+	if (unlikely((p != current->scx.kf_tasks[0] &&
+		      p != current->scx.kf_tasks[1]))) {
+		scx_error(sch, "called on a task not being operated on");
+		return false;
+	}
+
+	return true;
+}
+
 static inline bool scx_bypassing(struct scx_sched *sch, s32 cpu)
 {
 	return unlikely(per_cpu_ptr(sch->pcpu, cpu)->flags &
@@ -1633,6 +1738,20 @@ static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
 
 	return NULL;
 }
+
+/**
+ * scx_parent - Find the parent sched
+ * @sch: sched to find the parent of
+ *
+ * Returns the parent scheduler or %NULL if @sch is root.
+ */
+static inline struct scx_sched *scx_parent(struct scx_sched *sch)
+{
+	if (sch->level)
+		return sch->ancestors[sch->level - 1];
+	else
+		return NULL;
+}
 #else	/* CONFIG_EXT_SUB_SCHED */
 static inline struct scx_sched *scx_task_sched(const struct task_struct *p)
 {
@@ -1656,6 +1775,8 @@ static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
 {
 	return rcu_dereference_all(scx_root);
 }
+
+static inline struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
 #endif /* _KERNEL_SCHED_EXT_INTERNAL_H */
-- 
2.54.0

