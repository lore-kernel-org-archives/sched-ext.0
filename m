Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E833D75A2;
	Wed, 15 Jul 2026 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159498; cv=none; b=SS5wmv3L8pck+z2uT2dDWgmDELlQwZ7cmbVgyhkVcYR5jakZGb6nlPoGjrgMqspev650TKghdQBFAAl/uQAFgD2aONfyGwhZK575rrqlvtMPcWvtiJvU1tuZcD1d5Vf6nD7cmWzQITSPZMGz448E9GOIrCYMPxYsEhZHQa3onwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159498; c=relaxed/simple;
	bh=Z9qDWigj5pcqC+oM1SzBFbYwCAOLRA2RST3RVv4rfik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvMrdbFNPotaZ4Dw0JK7q4rXYTeFirWrC/ttkVvYlJUBHV8njPKG66NRpTrLylw/RaKZvbWJfYiTQfp9BODyPDtTl5PhOgI5maiJ+rC8X9Ce82mk2B7JKfM4hVAaB3kl9pQ///iIpoEKDMn2tu6aU0+ni3mwuJrDYsNRc+R/gdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go5ZDAWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go5ZDAWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790F71F000E9;
	Wed, 15 Jul 2026 23:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784159496;
	bh=rv8g3l43OXBkJGMo0qm1mqvLaOLA0jrvvgniRNTgv3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Go5ZDAWs5r+B6G3F4IX8fdyWOY7xPZEW1JFz3wLqG5q0NLiClhUxgDZbzD4uB75q/
	 cHCrCiRVAIyiVJXHlKHzhmgjADOCKBUl+qxDZqDej38B/m7jvzg2s5XYjSRe2JuIRD
	 JIJtNjWIEVQmcHGeHRYASTS8zLlaWd33x7DUWNTAvJfEhrYPE32W9wMIsJPaK3ifwm
	 B+0hCoE8A5l52R/3Szsd1bdzDFe5EVj6104MwBxhX01hk6EFL/JmiY4p7JYEjOttQP
	 EmG09V7ACwLm1llfwN1AAEngdeQ0BQdxnoUjEE1CqbvZndFC7KSoz2iq7KjJIKQMlu
	 KizqJkH+Lmwtw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] sched_ext: Move scx_dispatch_sched() to a new inlines.h
Date: Wed, 15 Jul 2026 13:51:31 -1000
Message-ID: <20260715235133.810434-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715235133.810434-1-tj@kernel.org>
References: <20260715235133.810434-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_dispatch_sched() is common dispatch machinery and looks out of place in
sub.h, but it needs scx_cpu_arg() from cid.h and can't move into internal.h
without creating a circular include. Add inlines.h on top of internal.h and
cid.h, and move the function there. The function was sub.h's only cid.h
user, so drop that include. Pure code move, no functional change.

v2: Host the function in a new inlines.h instead of at internal.h's tail,
    which formed a circular include with cid.h. Drop sub.h's now-unused
    cid.h include. (sashiko AI)

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/build_policy.c |   1 +
 kernel/sched/ext/ext.c      |   1 +
 kernel/sched/ext/inlines.h  | 125 ++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/sub.c      |   1 +
 kernel/sched/ext/sub.h      | 110 -------------------------------
 5 files changed, 128 insertions(+), 110 deletions(-)
 create mode 100644 kernel/sched/ext/inlines.h

diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 01dc7bf89af8..2a828725a7f9 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -67,6 +67,7 @@
 # include "ext/arena.h"
 # include "ext/idle.h"
 # include "ext/sub.h"
+# include "ext/inlines.h"
 # include "ext/ext.c"
 # include "ext/cid.c"
 # include "ext/arena.c"
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 428f2bfb2cda..f9958b8bd8f4 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -20,6 +20,7 @@
 #include "arena.h"
 #include "idle.h"
 #include "sub.h"
+#include "inlines.h"
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
new file mode 100644
index 000000000000..45c657bdad50
--- /dev/null
+++ b/kernel/sched/ext/inlines.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
+ * Inline definitions layered on top of internal.h and cid.h.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
+ */
+#ifndef _KERNEL_SCHED_EXT_INLINES_H
+#define _KERNEL_SCHED_EXT_INLINES_H
+
+#include "internal.h"
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
+#endif /* _KERNEL_SCHED_EXT_INLINES_H */
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 198063a78a3a..0875659d43c7 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -18,6 +18,7 @@
 #include "cid.h"
 #include "arena.h"
 #include "sub.h"
+#include "inlines.h"
 
 #ifdef CONFIG_EXT_SUB_SCHED
 
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index f72c18a5972a..0db2d2ea0fd1 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -11,7 +11,6 @@
 #define _KERNEL_SCHED_EXT_SUB_H
 
 #include "internal.h"
-#include "cid.h"
 
 #ifdef CONFIG_EXT_SUB_SCHED
 
@@ -172,113 +171,4 @@ static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p
 
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

