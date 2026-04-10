Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BE0383C62;
	Fri, 10 Apr 2026 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802657; cv=none; b=FAlxRetLSvn5EmDeZ6hTxJ8/wnhaN5pOuE5UmtiVN7lhuXo8/5OBMr3u9M7xs8iGlDioU0+EASdUC69Fw1VaBad9dIn1YPaq2DsZzIqen6VKrhTXHsB6qcev2KYn6/vAq99Z4Mh05q7oCRrHS1+y2KfPbvR6Xx2jEJRr4uYLoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802657; c=relaxed/simple;
	bh=3rLCdXwaNdNetSQ2xV6A+KEytoB0NbF6M/ethDoTxcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCalLSGZbSrHqHZpqM6omCQqvXw7aR+Id73YrypRZDBYy6O9JVau0ewgZbLasPWaLV5C8zmpPcxxqivLsqDSRHYnflSc/6BBqHge+6hHRtBQjjh4lHGyMy2jhere3OLDAWf6I79SJes1KiJpjdnR6UNXb9Zkr0PCKaGOo69l6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjZtMjfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjZtMjfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1786EC2BCAF;
	Fri, 10 Apr 2026 06:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802656;
	bh=3rLCdXwaNdNetSQ2xV6A+KEytoB0NbF6M/ethDoTxcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjZtMjfoYtG6qq7Buf5tW3rfpitu5e3/pRaaFX5t0yI+xuqPaykehMQQ7xV4RvVH3
	 mf+DGpMMR4EQNdRZnvhaSK4OkbW+T1gyr4FO6IHbZD/fa7Y04KWiLOAQa2yXeEIX0P
	 S54/v7w/eUAmVY8TfxALYLRUWgChCmUIBFRxVQLa7Enrj8xEIcsr6ed1tEz/ib5b0v
	 tl0VaErItjmmrwu9ESKzcWpnvv7RdVyY8fdAsZPqhFU2zUlyZ9KRUD/guBTzuVdcYx
	 dlJSL09yuQ4aPS+3BTEpsyBIf3fNSt75I6kXk3RBpWJf60q5E2F75237xVJ/Km1zkY
	 +O7euWWikNvVQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/10] sched_ext: Remove runtime kfunc mask enforcement
Date: Thu,  9 Apr 2026 20:30:44 -1000
Message-ID: <20260410063046.3556100-9-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410063046.3556100-1-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng-Yang Chou <yphbchou0911@gmail.com>

Now that scx_kfunc_context_filter enforces context-sensitive kfunc
restrictions at BPF load time, the per-task runtime enforcement via
scx_kf_mask is redundant. Remove it entirely:

 - Delete enum scx_kf_mask, the kf_mask field on sched_ext_entity, and
   the scx_kf_allow()/scx_kf_disallow()/scx_kf_allowed() helpers along
   with the higher_bits()/highest_bit() helpers they used.
 - Strip the @mask parameter (and the BUILD_BUG_ON checks) from the
   SCX_CALL_OP[_RET]/SCX_CALL_OP_TASK[_RET]/SCX_CALL_OP_2TASKS_RET
   macros and update every call site. Reflow call sites that were
   wrapped only to fit the old 5-arg form and now collapse onto a single
   line under ~100 cols.
 - Remove the in-kfunc scx_kf_allowed() runtime checks from
   scx_dsq_insert_preamble(), scx_dsq_move(), scx_bpf_dispatch_nr_slots(),
   scx_bpf_dispatch_cancel(), scx_bpf_dsq_move_to_local___v2(),
   scx_bpf_sub_dispatch(), scx_bpf_reenqueue_local(), and the per-call
   guard inside select_cpu_from_kfunc().

scx_bpf_task_cgroup() and scx_kf_allowed_on_arg_tasks() were already
cleaned up in the "drop redundant rq-locked check" patch.
scx_kf_allowed_if_unlocked() was rewritten in the preceding "decouple"
patch. No further changes to those helpers here.

Co-developed-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  28 -----
 kernel/sched/ext.c        | 244 +++++++++-----------------------------
 kernel/sched/ext_idle.c   |   4 +-
 3 files changed, 58 insertions(+), 218 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 602dc83cab36..1a3af2ea2a79 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -147,33 +147,6 @@ enum scx_ent_dsq_flags {
 	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
 };
 
-/*
- * Mask bits for scx_entity.kf_mask. Not all kfuncs can be called from
- * everywhere and the following bits track which kfunc sets are currently
- * allowed for %current. This simple per-task tracking works because SCX ops
- * nest in a limited way. BPF will likely implement a way to allow and disallow
- * kfuncs depending on the calling context which will replace this manual
- * mechanism. See scx_kf_allow().
- */
-enum scx_kf_mask {
-	SCX_KF_UNLOCKED		= 0,	  /* sleepable and not rq locked */
-	/* ENQUEUE and DISPATCH may be nested inside CPU_RELEASE */
-	SCX_KF_CPU_RELEASE	= 1 << 0, /* ops.cpu_release() */
-	/*
-	 * ops.dispatch() may release rq lock temporarily and thus ENQUEUE and
-	 * SELECT_CPU may be nested inside. ops.dequeue (in REST) may also be
-	 * nested inside DISPATCH.
-	 */
-	SCX_KF_DISPATCH		= 1 << 1, /* ops.dispatch() */
-	SCX_KF_ENQUEUE		= 1 << 2, /* ops.enqueue() and ops.select_cpu() */
-	SCX_KF_SELECT_CPU	= 1 << 3, /* ops.select_cpu() */
-	SCX_KF_REST		= 1 << 4, /* other rq-locked operations */
-
-	__SCX_KF_RQ_LOCKED	= SCX_KF_CPU_RELEASE | SCX_KF_DISPATCH |
-				  SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
-	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
-};
-
 enum scx_dsq_lnode_flags {
 	SCX_DSQ_LNODE_ITER_CURSOR = 1 << 0,
 
@@ -221,7 +194,6 @@ struct sched_ext_entity {
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	s32			selected_cpu;
-	u32			kf_mask;	/* see scx_kf_mask above */
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 
 	struct list_head	runnable_node;	/* rq->scx.runnable_list */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 81a4fea4c6b6..70e9434a9a0d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -229,19 +229,6 @@ static long jiffies_delta_msecs(unsigned long at, unsigned long now)
 		return -(long)jiffies_to_msecs(now - at);
 }
 
-/* if the highest set bit is N, return a mask with bits [N+1, 31] set */
-static u32 higher_bits(u32 flags)
-{
-	return ~((1 << fls(flags)) - 1);
-}
-
-/* return the mask with only the highest bit set */
-static u32 highest_bit(u32 flags)
-{
-	int bit = fls(flags);
-	return ((u64)1 << bit) >> 1;
-}
-
 static bool u32_before(u32 a, u32 b)
 {
 	return (s32)(a - b) < 0;
@@ -462,30 +449,6 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
 	return false;
 }
 
-/*
- * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
- * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
- * the allowed kfuncs and those kfuncs should use scx_kf_allowed() to check
- * whether it's running from an allowed context.
- *
- * @mask is constant, always inline to cull the mask calculations.
- */
-static __always_inline void scx_kf_allow(u32 mask)
-{
-	/* nesting is allowed only in increasing scx_kf_mask order */
-	WARN_ONCE((mask | higher_bits(mask)) & current->scx.kf_mask,
-		  "invalid nesting current->scx.kf_mask=0x%x mask=0x%x\n",
-		  current->scx.kf_mask, mask);
-	current->scx.kf_mask |= mask;
-	barrier();
-}
-
-static void scx_kf_disallow(u32 mask)
-{
-	barrier();
-	current->scx.kf_mask &= ~mask;
-}
-
 /*
  * Track the rq currently locked.
  *
@@ -506,34 +469,22 @@ static inline void update_locked_rq(struct rq *rq)
 	__this_cpu_write(scx_locked_rq_state, rq);
 }
 
-#define SCX_CALL_OP(sch, mask, op, rq, args...)					\
+#define SCX_CALL_OP(sch, op, rq, args...)					\
 do {										\
 	if (rq)									\
 		update_locked_rq(rq);						\
-	if (mask) {								\
-		scx_kf_allow(mask);						\
-		(sch)->ops.op(args);						\
-		scx_kf_disallow(mask);						\
-	} else {								\
-		(sch)->ops.op(args);						\
-	}									\
+	(sch)->ops.op(args);							\
 	if (rq)									\
 		update_locked_rq(NULL);						\
 } while (0)
 
-#define SCX_CALL_OP_RET(sch, mask, op, rq, args...)				\
+#define SCX_CALL_OP_RET(sch, op, rq, args...)					\
 ({										\
 	__typeof__((sch)->ops.op(args)) __ret;					\
 										\
 	if (rq)									\
 		update_locked_rq(rq);						\
-	if (mask) {								\
-		scx_kf_allow(mask);						\
-		__ret = (sch)->ops.op(args);					\
-		scx_kf_disallow(mask);						\
-	} else {								\
-		__ret = (sch)->ops.op(args);					\
-	}									\
+	__ret = (sch)->ops.op(args);						\
 	if (rq)									\
 		update_locked_rq(NULL);						\
 	__ret;									\
@@ -553,67 +504,33 @@ do {										\
  *
  * These macros only work for non-nesting ops since kf_tasks[] is not stacked.
  */
-#define SCX_CALL_OP_TASK(sch, mask, op, rq, task, args...)			\
+#define SCX_CALL_OP_TASK(sch, op, rq, task, args...)				\
 do {										\
-	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
 	current->scx.kf_tasks[0] = task;					\
-	SCX_CALL_OP((sch), mask, op, rq, task, ##args);				\
+	SCX_CALL_OP((sch), op, rq, task, ##args);				\
 	current->scx.kf_tasks[0] = NULL;					\
 } while (0)
 
-#define SCX_CALL_OP_TASK_RET(sch, mask, op, rq, task, args...)			\
+#define SCX_CALL_OP_TASK_RET(sch, op, rq, task, args...)			\
 ({										\
 	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
-	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
 	current->scx.kf_tasks[0] = task;					\
-	__ret = SCX_CALL_OP_RET((sch), mask, op, rq, task, ##args);		\
+	__ret = SCX_CALL_OP_RET((sch), op, rq, task, ##args);			\
 	current->scx.kf_tasks[0] = NULL;					\
 	__ret;									\
 })
 
-#define SCX_CALL_OP_2TASKS_RET(sch, mask, op, rq, task0, task1, args...)	\
+#define SCX_CALL_OP_2TASKS_RET(sch, op, rq, task0, task1, args...)		\
 ({										\
 	__typeof__((sch)->ops.op(task0, task1, ##args)) __ret;			\
-	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
 	current->scx.kf_tasks[0] = task0;					\
 	current->scx.kf_tasks[1] = task1;					\
-	__ret = SCX_CALL_OP_RET((sch), mask, op, rq, task0, task1, ##args);	\
+	__ret = SCX_CALL_OP_RET((sch), op, rq, task0, task1, ##args);		\
 	current->scx.kf_tasks[0] = NULL;					\
 	current->scx.kf_tasks[1] = NULL;					\
 	__ret;									\
 })
 
-/* @mask is constant, always inline to cull unnecessary branches */
-static __always_inline bool scx_kf_allowed(struct scx_sched *sch, u32 mask)
-{
-	if (unlikely(!(current->scx.kf_mask & mask))) {
-		scx_error(sch, "kfunc with mask 0x%x called from an operation only allowing 0x%x",
-			  mask, current->scx.kf_mask);
-		return false;
-	}
-
-	/*
-	 * Enforce nesting boundaries. e.g. A kfunc which can be called from
-	 * DISPATCH must not be called if we're running DEQUEUE which is nested
-	 * inside ops.dispatch(). We don't need to check boundaries for any
-	 * blocking kfuncs as the verifier ensures they're only called from
-	 * sleepable progs.
-	 */
-	if (unlikely(highest_bit(mask) == SCX_KF_CPU_RELEASE &&
-		     (current->scx.kf_mask & higher_bits(SCX_KF_CPU_RELEASE)))) {
-		scx_error(sch, "cpu_release kfunc called from a nested operation");
-		return false;
-	}
-
-	if (unlikely(highest_bit(mask) == SCX_KF_DISPATCH &&
-		     (current->scx.kf_mask & higher_bits(SCX_KF_DISPATCH)))) {
-		scx_error(sch, "dispatch kfunc called from a nested operation");
-		return false;
-	}
-
-	return true;
-}
-
 /* see SCX_CALL_OP_TASK() */
 static __always_inline bool scx_kf_allowed_on_arg_tasks(struct scx_sched *sch,
 							struct task_struct *p)
@@ -1461,7 +1378,7 @@ static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
 		return;
 
 	if (SCX_HAS_OP(sch, dequeue))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, deq_flags);
+		SCX_CALL_OP_TASK(sch, dequeue, rq, p, deq_flags);
 
 	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
 }
@@ -1920,7 +1837,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	WARN_ON_ONCE(*ddsp_taskp);
 	*ddsp_taskp = p;
 
-	SCX_CALL_OP_TASK(sch, SCX_KF_ENQUEUE, enqueue, rq, p, enq_flags);
+	SCX_CALL_OP_TASK(sch, enqueue, rq, p, enq_flags);
 
 	*ddsp_taskp = NULL;
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
@@ -2024,7 +1941,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	add_nr_running(rq, 1);
 
 	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, runnable, rq, p, enq_flags);
+		SCX_CALL_OP_TASK(sch, runnable, rq, p, enq_flags);
 
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
@@ -2141,11 +2058,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_
 	 */
 	if (SCX_HAS_OP(sch, stopping) && task_current(rq, p)) {
 		update_curr_scx(rq);
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, stopping, rq, p, false);
+		SCX_CALL_OP_TASK(sch, stopping, rq, p, false);
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, quiescent, rq, p, deq_flags);
+		SCX_CALL_OP_TASK(sch, quiescent, rq, p, deq_flags);
 
 	if (deq_flags & SCX_DEQ_SLEEP)
 		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
@@ -2167,7 +2084,7 @@ static void yield_task_scx(struct rq *rq)
 	struct scx_sched *sch = scx_task_sched(p);
 
 	if (SCX_HAS_OP(sch, yield))
-		SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, yield, rq, p, NULL);
+		SCX_CALL_OP_2TASKS_RET(sch, yield, rq, p, NULL);
 	else
 		p->scx.slice = 0;
 }
@@ -2178,8 +2095,7 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 	struct scx_sched *sch = scx_task_sched(from);
 
 	if (SCX_HAS_OP(sch, yield) && sch == scx_task_sched(to))
-		return SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, yield, rq,
-					      from, to);
+		return SCX_CALL_OP_2TASKS_RET(sch, yield, rq, from, to);
 	else
 		return false;
 }
@@ -2799,20 +2715,11 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		dspc->nr_tasks = 0;
 
 		if (nested) {
-			/*
-			 * If nested, don't update kf_mask as the originating
-			 * invocation would already have set it up.
-			 */
-			SCX_CALL_OP(sch, 0, dispatch, rq, cpu,
-				    prev_on_sch ? prev : NULL);
+			SCX_CALL_OP(sch, dispatch, rq, cpu, prev_on_sch ? prev : NULL);
 		} else {
-			/*
-			 * If not nested, stash @prev so that nested invocations
-			 * can access it.
-			 */
+			/* stash @prev so that nested invocations can access it */
 			rq->scx.sub_dispatch_prev = prev;
-			SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq, cpu,
-				    prev_on_sch ? prev : NULL);
+			SCX_CALL_OP(sch, dispatch, rq, cpu, prev_on_sch ? prev : NULL);
 			rq->scx.sub_dispatch_prev = NULL;
 		}
 
@@ -2871,7 +2778,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * emitted in switch_class().
 		 */
 		if (SCX_HAS_OP(sch, cpu_acquire))
-			SCX_CALL_OP(sch, SCX_KF_REST, cpu_acquire, rq, cpu, NULL);
+			SCX_CALL_OP(sch, cpu_acquire, rq, cpu, NULL);
 		rq->scx.cpu_released = false;
 	}
 
@@ -2950,7 +2857,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, running, rq, p);
+		SCX_CALL_OP_TASK(sch, running, rq, p);
 
 	clr_task_runnable(p, true);
 
@@ -3022,8 +2929,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 				.task = next,
 			};
 
-			SCX_CALL_OP(sch, SCX_KF_CPU_RELEASE, cpu_release, rq,
-				    cpu_of(rq), &args);
+			SCX_CALL_OP(sch, cpu_release, rq, cpu_of(rq), &args);
 		}
 		rq->scx.cpu_released = true;
 	}
@@ -3041,7 +2947,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(sch, stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, stopping, rq, p, true);
+		SCX_CALL_OP_TASK(sch, stopping, rq, p, true);
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
@@ -3271,7 +3177,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	 */
 	if (sch_a == sch_b && SCX_HAS_OP(sch_a, core_sched_before) &&
 	    !scx_bypassing(sch_a, task_cpu(a)))
-		return SCX_CALL_OP_2TASKS_RET(sch_a, SCX_KF_REST, core_sched_before,
+		return SCX_CALL_OP_2TASKS_RET(sch_a, core_sched_before,
 					      NULL,
 					      (struct task_struct *)a,
 					      (struct task_struct *)b);
@@ -3308,10 +3214,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		*ddsp_taskp = p;
 
 		this_rq()->scx.in_select_cpu = true;
-		cpu = SCX_CALL_OP_TASK_RET(sch,
-					   SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU,
-					   select_cpu, NULL, p, prev_cpu,
-					   wake_flags);
+		cpu = SCX_CALL_OP_TASK_RET(sch, select_cpu, NULL, p, prev_cpu, wake_flags);
 		this_rq()->scx.in_select_cpu = false;
 		p->scx.selected_cpu = cpu;
 		*ddsp_taskp = NULL;
@@ -3361,8 +3264,7 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 	 * designation pointless. Cast it away when calling the operation.
 	 */
 	if (SCX_HAS_OP(sch, set_cpumask))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_cpumask, task_rq(p),
-				 p, (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(sch, set_cpumask, task_rq(p), p, (struct cpumask *)p->cpus_ptr);
 }
 
 static void handle_hotplug(struct rq *rq, bool online)
@@ -3384,9 +3286,9 @@ static void handle_hotplug(struct rq *rq, bool online)
 		scx_idle_update_selcpu_topology(&sch->ops);
 
 	if (online && SCX_HAS_OP(sch, cpu_online))
-		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cpu_online, NULL, cpu);
+		SCX_CALL_OP(sch, cpu_online, NULL, cpu);
 	else if (!online && SCX_HAS_OP(sch, cpu_offline))
-		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cpu_offline, NULL, cpu);
+		SCX_CALL_OP(sch, cpu_offline, NULL, cpu);
 	else
 		scx_exit(sch, SCX_EXIT_UNREG_KERN,
 			 SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
@@ -3504,7 +3406,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 		curr->scx.slice = 0;
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(sch, tick)) {
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, tick, rq, curr);
+		SCX_CALL_OP_TASK(sch, tick, rq, curr);
 	}
 
 	if (!curr->scx.slice)
@@ -3580,8 +3482,7 @@ static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fo
 			.fork = fork,
 		};
 
-		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, init_task, NULL,
-				      p, &args);
+		ret = SCX_CALL_OP_RET(sch, init_task, NULL, p, &args);
 		if (unlikely(ret)) {
 			ret = ops_sanitize_err(sch, "init_task", ret);
 			return ret;
@@ -3662,11 +3563,10 @@ static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 	p->scx.weight = sched_weight_to_cgroup(weight);
 
 	if (SCX_HAS_OP(sch, enable))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, enable, rq, p);
+		SCX_CALL_OP_TASK(sch, enable, rq, p);
 
 	if (SCX_HAS_OP(sch, set_weight))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_weight, rq,
-				 p, p->scx.weight);
+		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);
 }
 
 static void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
@@ -3685,7 +3585,7 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 	clear_direct_dispatch(p);
 
 	if (SCX_HAS_OP(sch, disable))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
+		SCX_CALL_OP_TASK(sch, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
 
 	/*
@@ -3723,8 +3623,7 @@ static void __scx_disable_and_exit_task(struct scx_sched *sch,
 	}
 
 	if (SCX_HAS_OP(sch, exit_task))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, exit_task, task_rq(p),
-				 p, &args);
+		SCX_CALL_OP_TASK(sch, exit_task, task_rq(p), p, &args);
 }
 
 static void scx_disable_and_exit_task(struct scx_sched *sch,
@@ -3903,8 +3802,7 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 
 	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
 	if (SCX_HAS_OP(sch, set_weight))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_weight, rq,
-				 p, p->scx.weight);
+		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);
 }
 
 static void prio_changed_scx(struct rq *rq, struct task_struct *p, u64 oldprio)
@@ -3925,8 +3823,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	 * different scheduler class. Keep the BPF scheduler up-to-date.
 	 */
 	if (SCX_HAS_OP(sch, set_cpumask))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_cpumask, rq,
-				 p, (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(sch, set_cpumask, rq, p, (struct cpumask *)p->cpus_ptr);
 }
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
@@ -4309,7 +4206,7 @@ int scx_tg_online(struct task_group *tg)
 				  .bw_quota_us = tg->scx.bw_quota_us,
 				  .bw_burst_us = tg->scx.bw_burst_us };
 
-			ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, cgroup_init,
+			ret = SCX_CALL_OP_RET(sch, cgroup_init,
 					      NULL, tg->css.cgroup, &args);
 			if (ret)
 				ret = ops_sanitize_err(sch, "cgroup_init", ret);
@@ -4331,8 +4228,7 @@ void scx_tg_offline(struct task_group *tg)
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_exit) &&
 	    (tg->scx.flags & SCX_TG_INITED))
-		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_exit, NULL,
-			    tg->css.cgroup);
+		SCX_CALL_OP(sch, cgroup_exit, NULL, tg->css.cgroup);
 	tg->scx.flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
 }
 
@@ -4361,8 +4257,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 			continue;
 
 		if (SCX_HAS_OP(sch, cgroup_prep_move)) {
-			ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED,
-					      cgroup_prep_move, NULL,
+			ret = SCX_CALL_OP_RET(sch, cgroup_prep_move, NULL,
 					      p, from, css->cgroup);
 			if (ret)
 				goto err;
@@ -4377,7 +4272,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_for_each(p, css, tset) {
 		if (SCX_HAS_OP(sch, cgroup_cancel_move) &&
 		    p->scx.cgrp_moving_from)
-			SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_cancel_move, NULL,
+			SCX_CALL_OP(sch, cgroup_cancel_move, NULL,
 				    p, p->scx.cgrp_moving_from, css->cgroup);
 		p->scx.cgrp_moving_from = NULL;
 	}
@@ -4398,7 +4293,7 @@ void scx_cgroup_move_task(struct task_struct *p)
 	 */
 	if (SCX_HAS_OP(sch, cgroup_move) &&
 	    !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
-		SCX_CALL_OP_TASK(sch, SCX_KF_REST, cgroup_move, task_rq(p),
+		SCX_CALL_OP_TASK(sch, cgroup_move, task_rq(p),
 				 p, p->scx.cgrp_moving_from,
 				 tg_cgrp(task_group(p)));
 	p->scx.cgrp_moving_from = NULL;
@@ -4416,7 +4311,7 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_for_each(p, css, tset) {
 		if (SCX_HAS_OP(sch, cgroup_cancel_move) &&
 		    p->scx.cgrp_moving_from)
-			SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_cancel_move, NULL,
+			SCX_CALL_OP(sch, cgroup_cancel_move, NULL,
 				    p, p->scx.cgrp_moving_from, css->cgroup);
 		p->scx.cgrp_moving_from = NULL;
 	}
@@ -4430,8 +4325,7 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_weight) &&
 	    tg->scx.weight != weight)
-		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_weight, NULL,
-			    tg_cgrp(tg), weight);
+		SCX_CALL_OP(sch, cgroup_set_weight, NULL, tg_cgrp(tg), weight);
 
 	tg->scx.weight = weight;
 
@@ -4445,8 +4339,7 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
 	percpu_down_read(&scx_cgroup_ops_rwsem);
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
-		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_idle, NULL,
-			    tg_cgrp(tg), idle);
+		SCX_CALL_OP(sch, cgroup_set_idle, NULL, tg_cgrp(tg), idle);
 
 	/* Update the task group's idle state */
 	tg->scx.idle = idle;
@@ -4465,7 +4358,7 @@ void scx_group_set_bandwidth(struct task_group *tg,
 	    (tg->scx.bw_period_us != period_us ||
 	     tg->scx.bw_quota_us != quota_us ||
 	     tg->scx.bw_burst_us != burst_us))
-		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_bandwidth, NULL,
+		SCX_CALL_OP(sch, cgroup_set_bandwidth, NULL,
 			    tg_cgrp(tg), period_us, quota_us, burst_us);
 
 	tg->scx.bw_period_us = period_us;
@@ -4690,8 +4583,7 @@ static void scx_cgroup_exit(struct scx_sched *sch)
 		if (!sch->ops.cgroup_exit)
 			continue;
 
-		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_exit, NULL,
-			    css->cgroup);
+		SCX_CALL_OP(sch, cgroup_exit, NULL, css->cgroup);
 	}
 }
 
@@ -4722,7 +4614,7 @@ static int scx_cgroup_init(struct scx_sched *sch)
 			continue;
 		}
 
-		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, cgroup_init, NULL,
+		ret = SCX_CALL_OP_RET(sch, cgroup_init, NULL,
 				      css->cgroup, &args);
 		if (ret) {
 			scx_error(sch, "ops.cgroup_init() failed (%d)", ret);
@@ -5795,12 +5687,12 @@ static void scx_sub_disable(struct scx_sched *sch)
 			.ops = &sch->ops,
 			.cgroup_path = sch->cgrp_path,
 		};
-		SCX_CALL_OP(parent, SCX_KF_UNLOCKED, sub_detach, NULL,
+		SCX_CALL_OP(parent, sub_detach, NULL,
 			    &sub_detach_args);
 	}
 
 	if (sch->ops.exit)
-		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, exit, NULL, sch->exit_info);
+		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
 	kobject_del(&sch->kobj);
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
@@ -5915,7 +5807,7 @@ static void scx_root_disable(struct scx_sched *sch)
 	}
 
 	if (sch->ops.exit)
-		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, exit, NULL, ei);
+		SCX_CALL_OP(sch, exit, NULL, ei);
 
 	scx_unlink_sched(sch);
 
@@ -6178,7 +6070,7 @@ static void scx_dump_task(struct scx_sched *sch,
 
 	if (SCX_HAS_OP(sch, dump_task)) {
 		ops_dump_init(s, "    ");
-		SCX_CALL_OP(sch, SCX_KF_REST, dump_task, NULL, dctx, p);
+		SCX_CALL_OP(sch, dump_task, NULL, dctx, p);
 		ops_dump_exit();
 	}
 
@@ -6242,7 +6134,7 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 
 	if (SCX_HAS_OP(sch, dump)) {
 		ops_dump_init(&s, "");
-		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, dump, NULL, &dctx);
+		SCX_CALL_OP(sch, dump, NULL, &dctx);
 		ops_dump_exit();
 	}
 
@@ -6302,7 +6194,7 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 		used = seq_buf_used(&ns);
 		if (SCX_HAS_OP(sch, dump_cpu)) {
 			ops_dump_init(&ns, "  ");
-			SCX_CALL_OP(sch, SCX_KF_REST, dump_cpu, NULL,
+			SCX_CALL_OP(sch, dump_cpu, NULL,
 				    &dctx, cpu, idle);
 			ops_dump_exit();
 		}
@@ -6748,7 +6640,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	scx_idle_enable(ops);
 
 	if (sch->ops.init) {
-		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, init, NULL);
+		ret = SCX_CALL_OP_RET(sch, init, NULL);
 		if (ret) {
 			ret = ops_sanitize_err(sch, "init", ret);
 			cpus_read_unlock();
@@ -7020,7 +6912,7 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	}
 
 	if (sch->ops.init) {
-		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, init, NULL);
+		ret = SCX_CALL_OP_RET(sch, init, NULL);
 		if (ret) {
 			ret = ops_sanitize_err(sch, "init", ret);
 			scx_error(sch, "ops.init() failed (%d)", ret);
@@ -7037,7 +6929,7 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 		.cgroup_path = sch->cgrp_path,
 	};
 
-	ret = SCX_CALL_OP_RET(parent, SCX_KF_UNLOCKED, sub_attach, NULL,
+	ret = SCX_CALL_OP_RET(parent, sub_attach, NULL,
 			      &sub_attach_args);
 	if (ret) {
 		ret = ops_sanitize_err(sch, "sub_attach", ret);
@@ -7891,9 +7783,6 @@ static bool scx_vet_enq_flags(struct scx_sched *sch, u64 dsq_id, u64 *enq_flags)
 static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p,
 				    u64 dsq_id, u64 *enq_flags)
 {
-	if (!scx_kf_allowed(sch, SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
-		return false;
-
 	lockdep_assert_irqs_disabled();
 
 	if (unlikely(!p)) {
@@ -8146,10 +8035,6 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	bool in_balance;
 	unsigned long flags;
 
-	if ((scx_locked_rq() || this_rq()->scx.in_select_cpu) &&
-	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
-		return false;
-
 	if (!scx_vet_enq_flags(sch, dsq_id, &enq_flags))
 		return false;
 
@@ -8244,9 +8129,6 @@ __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(const struct bpf_prog_aux *aux)
 	if (unlikely(!sch))
 		return 0;
 
-	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
-		return 0;
-
 	return sch->dsp_max_batch - __this_cpu_read(sch->pcpu->dsp_ctx.cursor);
 }
 
@@ -8268,9 +8150,6 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
 	if (unlikely(!sch))
 		return;
 
-	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
-		return;
-
 	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 
 	if (dspc->cursor > 0)
@@ -8317,9 +8196,6 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local___v2(u64 dsq_id, u64 enq_flags,
 	if (unlikely(!sch))
 		return false;
 
-	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
-		return false;
-
 	if (!scx_vet_enq_flags(sch, SCX_DSQ_LOCAL, &enq_flags))
 		return false;
 
@@ -8473,9 +8349,6 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
 	if (unlikely(!parent))
 		return false;
 
-	if (!scx_kf_allowed(parent, SCX_KF_DISPATCH))
-		return false;
-
 	child = scx_find_sub_sched(cgroup_id);
 
 	if (unlikely(!child))
@@ -8535,9 +8408,6 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux)
 	if (unlikely(!sch))
 		return 0;
 
-	if (!scx_kf_allowed(sch, SCX_KF_CPU_RELEASE))
-		return 0;
-
 	rq = cpu_rq(smp_processor_id());
 	lockdep_assert_rq_held(rq);
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index ec49e0c9892e..443d12a3df67 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -789,7 +789,7 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 	 */
 	if (SCX_HAS_OP(sch, update_idle) && do_notify &&
 	    !scx_bypassing(sch, cpu_of(rq)))
-		SCX_CALL_OP(sch, SCX_KF_REST, update_idle, rq, cpu_of(rq), idle);
+		SCX_CALL_OP(sch, update_idle, rq, cpu_of(rq), idle);
 }
 
 static void reset_idle_masks(struct sched_ext_ops *ops)
@@ -937,8 +937,6 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 	} else if (!scx_locked_rq()) {
 		raw_spin_lock_irqsave(&p->pi_lock, irq_flags);
 		we_locked = true;
-	} else if (!scx_kf_allowed(sch, SCX_KF_ENQUEUE)) {
-		return -EPERM;
 	}
 
 	/*
-- 
2.53.0

