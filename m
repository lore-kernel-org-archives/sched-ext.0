Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB702423EAF;
	Tue, 14 Jul 2026 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070566; cv=none; b=UQ8lvvCvtaR+R8qDvDE9LxRv9nXKWWazQG7EXVq/X7OEALzvGzfRIqr/HbJ/Z+L2uGtlDHp1tNHeSxfPCXuaBBGHsu6xYOoe3piwF/tVDGXLp6nCEt2zA5R3qe7fcTO1rOlNhEMYZZFset1CmHOTeK+7HNZHUL3FM3rMjPiKmwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070566; c=relaxed/simple;
	bh=XufO/yqtMcnIxH8QxMFa+00TxB4h4Z5/toBQi/3s/o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM+yJdWxnXmT3JGKF2ZxvGtxIjrEpncs8LwKts7Y+QngDoUVg1+WkGnXvDVpqtk5qiFClZcKUJGeuiKxd+PKyIdI5icmyYRa7W9vlifnwCVi7CLQ/hN17qCrWT+imaeFqkYQI3XgdXGdNcpDLJId0UUkLm9mIP+b0q7Uk9ywRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InVMqFl/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InVMqFl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD091F00A3A;
	Tue, 14 Jul 2026 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784070560;
	bh=o94gM3NnBfKi8tn/2xx10BvSRbnse1wOX0kzMW4tI8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=InVMqFl/z9X6uv32sW/9YvfRytUikkCkX6TELC6seR3h1PAeqyXAg3ExJ2MaXuuP6
	 gI6gNdD4Z0KKtHFr8VBfqUSgLfurwZJoGfuxnDwQ9p5+m2DJd6FhuFiGRBI8KUUfW8
	 9AEAdrIy+zkgnGS6u5+oLU+v5w57H8guMFgUIGNlShvaYO6s9oH8p0Lv5L8uCwztxz
	 y8OBv240jZ2dwEQL1aGSnE+rto95OvIFLCrDzP9Dl0gyGGgbrUxMBya4Oh90FDgJ4I
	 0xNzSJ5eJsqcjTLW27OYGwWMNP0T+IgybO/XDcMKT5TAmlQonNI3D+8Q7Zy46JiYIj
	 byfKI9aUDSfeg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] sched_ext: Move scx_dispatch_sched() from sub.h to internal.h
Date: Tue, 14 Jul 2026 13:09:15 -1000
Message-ID: <20260714230917.84158-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714230917.84158-1-tj@kernel.org>
References: <20260714230917.84158-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_dispatch_sched() is common dispatch machinery, not sub-scheduler support
code, and looks out of place in sub.h. Move it to internal.h. cid.h is
included near the tail for scx_cpu_arg() as it depends on internal.h
declarations. Pure code move, no functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/internal.h | 111 ++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/sub.h      | 109 -----------------------------------
 2 files changed, 111 insertions(+), 109 deletions(-)

diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index d7a1d6a14ebf..88b2a9b5d3ab 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2289,4 +2289,115 @@ static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
 static inline struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
+#include "cid.h"
+
+/*
+ * One user of this function is scx_bpf_dispatch() which can be called
+ * recursively as sub-sched dispatches nest. Always inline to reduce stack usage
+ * from the call frame.
+ */
+static __always_inline bool
+scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
+		   struct task_struct *prev, bool nested)
+{
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
+	int nr_loops = SCX_DSP_MAX_LOOPS;
+	s32 cpu = cpu_of(rq);
+	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
+		scx_task_on_sched(sch, prev);
+
+	if (scx_consume_global_dsq(sch, rq))
+		return true;
+
+	if (scx_bypass_dsp_enabled(sch)) {
+		/* if @sch is bypassing, only the bypass DSQs are active */
+		if (scx_bypassing(sch, cpu))
+			return scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0);
+
+#ifdef CONFIG_EXT_SUB_SCHED
+		/*
+		 * If @sch isn't bypassing but its children are, @sch is
+		 * responsible for making forward progress for both its own
+		 * tasks that aren't bypassing and the bypassing descendants'
+		 * tasks. The following implements a simple built-in behavior -
+		 * let each CPU try to run the bypass DSQ every Nth time.
+		 *
+		 * Later, if necessary, we can add an ops flag to suppress the
+		 * auto-consumption and a kfunc to consume the bypass DSQ and,
+		 * so that the BPF scheduler can fully control scheduling of
+		 * bypassed tasks.
+		 */
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
+		if (!(pcpu->bypass_host_seq++ % SCX_BYPASS_HOST_NTH) &&
+		    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0)) {
+			__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
+			return true;
+		}
+#endif	/* CONFIG_EXT_SUB_SCHED */
+	}
+
+	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
+		return false;
+
+	dspc->rq = rq;
+
+	/*
+	 * The dispatch loop. Because scx_flush_dispatch_buf() may drop the rq
+	 * lock, the local DSQ might still end up empty after a successful
+	 * ops.dispatch(). If the local DSQ is empty even after ops.dispatch()
+	 * produced some tasks, retry. The BPF scheduler may depend on this
+	 * looping behavior to simplify its implementation.
+	 */
+	do {
+		dspc->nr_tasks = 0;
+
+		if (nested) {
+			SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
+				    prev_on_sch ? prev : NULL);
+		} else {
+			/* stash @prev so that nested invocations can access it */
+			rq->scx.sub_dispatch_prev = prev;
+			SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
+				    prev_on_sch ? prev : NULL);
+			rq->scx.sub_dispatch_prev = NULL;
+		}
+
+		scx_flush_dispatch_buf(sch, rq);
+
+		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice) {
+			rq->scx.flags |= SCX_RQ_BAL_KEEP;
+			return true;
+		}
+		if (rq->scx.local_dsq.nr)
+			return true;
+		if (scx_consume_global_dsq(sch, rq))
+			return true;
+
+		/*
+		 * ops.dispatch() can trap us in this loop by repeatedly
+		 * dispatching ineligible tasks. Break out once in a while to
+		 * allow the watchdog to run. As IRQ can't be enabled in
+		 * balance(), we want to complete this scheduling cycle and then
+		 * start a new one. IOW, we want to call resched_curr() on the
+		 * next, most likely idle, task, not the current one. Use
+		 * __scx_bpf_kick_cpu() for deferred kicking.
+		 */
+		if (unlikely(!--nr_loops)) {
+			scx_kick_cpu(sch, cpu, 0);
+			break;
+		}
+	} while (dspc->nr_tasks);
+
+	/*
+	 * Prevent the CPU from going idle while bypassed descendants have tasks
+	 * queued. Without this fallback, bypassed tasks could stall if the host
+	 * scheduler's ops.dispatch() doesn't yield any tasks.
+	 */
+	if (scx_bypass_dsp_enabled(sch))
+		return scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0);
+
+	return false;
+}
+
 #endif /* _KERNEL_SCHED_EXT_INTERNAL_H */
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index f72c18a5972a..d06bf24aee83 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -172,113 +172,4 @@ static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
-/*
- * One user of this function is scx_bpf_dispatch() which can be called
- * recursively as sub-sched dispatches nest. Always inline to reduce stack usage
- * from the call frame.
- */
-static __always_inline bool
-scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
-		   struct task_struct *prev, bool nested)
-{
-	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
-	int nr_loops = SCX_DSP_MAX_LOOPS;
-	s32 cpu = cpu_of(rq);
-	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
-		scx_task_on_sched(sch, prev);
-
-	if (scx_consume_global_dsq(sch, rq))
-		return true;
-
-	if (scx_bypass_dsp_enabled(sch)) {
-		/* if @sch is bypassing, only the bypass DSQs are active */
-		if (scx_bypassing(sch, cpu))
-			return scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0);
-
-#ifdef CONFIG_EXT_SUB_SCHED
-		/*
-		 * If @sch isn't bypassing but its children are, @sch is
-		 * responsible for making forward progress for both its own
-		 * tasks that aren't bypassing and the bypassing descendants'
-		 * tasks. The following implements a simple built-in behavior -
-		 * let each CPU try to run the bypass DSQ every Nth time.
-		 *
-		 * Later, if necessary, we can add an ops flag to suppress the
-		 * auto-consumption and a kfunc to consume the bypass DSQ and,
-		 * so that the BPF scheduler can fully control scheduling of
-		 * bypassed tasks.
-		 */
-		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
-
-		if (!(pcpu->bypass_host_seq++ % SCX_BYPASS_HOST_NTH) &&
-		    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0)) {
-			__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
-			return true;
-		}
-#endif	/* CONFIG_EXT_SUB_SCHED */
-	}
-
-	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
-		return false;
-
-	dspc->rq = rq;
-
-	/*
-	 * The dispatch loop. Because scx_flush_dispatch_buf() may drop the rq
-	 * lock, the local DSQ might still end up empty after a successful
-	 * ops.dispatch(). If the local DSQ is empty even after ops.dispatch()
-	 * produced some tasks, retry. The BPF scheduler may depend on this
-	 * looping behavior to simplify its implementation.
-	 */
-	do {
-		dspc->nr_tasks = 0;
-
-		if (nested) {
-			SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
-				    prev_on_sch ? prev : NULL);
-		} else {
-			/* stash @prev so that nested invocations can access it */
-			rq->scx.sub_dispatch_prev = prev;
-			SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
-				    prev_on_sch ? prev : NULL);
-			rq->scx.sub_dispatch_prev = NULL;
-		}
-
-		scx_flush_dispatch_buf(sch, rq);
-
-		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice) {
-			rq->scx.flags |= SCX_RQ_BAL_KEEP;
-			return true;
-		}
-		if (rq->scx.local_dsq.nr)
-			return true;
-		if (scx_consume_global_dsq(sch, rq))
-			return true;
-
-		/*
-		 * ops.dispatch() can trap us in this loop by repeatedly
-		 * dispatching ineligible tasks. Break out once in a while to
-		 * allow the watchdog to run. As IRQ can't be enabled in
-		 * balance(), we want to complete this scheduling cycle and then
-		 * start a new one. IOW, we want to call resched_curr() on the
-		 * next, most likely idle, task, not the current one. Use
-		 * __scx_bpf_kick_cpu() for deferred kicking.
-		 */
-		if (unlikely(!--nr_loops)) {
-			scx_kick_cpu(sch, cpu, 0);
-			break;
-		}
-	} while (dspc->nr_tasks);
-
-	/*
-	 * Prevent the CPU from going idle while bypassed descendants have tasks
-	 * queued. Without this fallback, bypassed tasks could stall if the host
-	 * scheduler's ops.dispatch() doesn't yield any tasks.
-	 */
-	if (scx_bypass_dsp_enabled(sch))
-		return scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0);
-
-	return false;
-}
-
 #endif /* _KERNEL_SCHED_EXT_SUB_H */
-- 
2.55.0

