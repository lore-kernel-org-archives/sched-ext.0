Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF42450901;
	Wed, 21 Jan 2026 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037125; cv=none; b=tdqolU/h+xwPKX0W6K3zapkUbAZv8gBk4KBQ1MbIWDUVsYGj/BWDDHNQmp3pYJeZik36p7U9suL6ynQrNChgh6Kw7fSBxHvY6TLu6OaDoaz2ewUdObaW3naJcw9p0k+xjK1u7S+bjHWXAbyLBb30/G9Lpv+6a9qPKQMRpFsYgCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037125; c=relaxed/simple;
	bh=o9lcUHMuJgzBUUBBMPstv6vlsSRef6VLa4aCzS7RXU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMe0YX95KivqTOi76ggqsBstfTmg4qXYsNytEVI5pZJUdbSAF4DwDEuh5el1Mz/JiFbJ3r++bntI6EYWBDBX6TeFenPlimgr/Za9g6EZwkalEewC6GcbyQhRz18pYX5lh1FczmqxNm3Qo6Us16ahL3gOydBzvmo8vgoAbrptr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J85u64P9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J85u64P9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D11C4CEF1;
	Wed, 21 Jan 2026 23:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037122;
	bh=o9lcUHMuJgzBUUBBMPstv6vlsSRef6VLa4aCzS7RXU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J85u64P91RYFJZ8ce6YgRy5pzxgAKheQlU3NZ6sMAevXINf3uXZDcv1vLMvX45D0k
	 4uww+yO2eKoDdvy0CZITh3K9HDwTTscBUSPIYkiYSljH0fl4/o4YPhXeBs5RjROqCt
	 NNTwtSY06mZ9oumQIqpwt++TxGO6fo12yW1qFzQWoDJRarXPTLJqlcHmCNgiIDf6gK
	 unPoj3JMCtlLfK6G/lNMhdE0XVMORTSDc9t4V20rvp/YIykI7dgz5w+kIM+LnkcEMw
	 E+wgMdD702fEjWPc0evaFGNCAdpCr1kdYc/KehTxgC0OOVBOTSy+w4NdyL7AShm+M4
	 nrQeKPjvmxYLw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 20/34] sched_ext: Factor out scx_dispatch_sched()
Date: Wed, 21 Jan 2026 13:11:26 -1000
Message-ID: <20260121231140.832332-21-tj@kernel.org>
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

In preparation of multiple scheduler support, factor out
scx_dispatch_sched() from balance_one(). The function boundary makes
remembering $prev_on_scx and $prev_on_rq less useful. Open code $prev_on_scx
in balance_one() and $prev_on_rq in both balance_one() and
scx_dispatch_sched().

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 123 ++++++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 58 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 42b177585972..682dbaa22488 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2294,67 +2294,22 @@ static inline void maybe_queue_balance_callback(struct rq *rq)
 	rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
 }
 
-static int balance_one(struct rq *rq, struct task_struct *prev)
+static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
+			       struct task_struct *prev)
 {
-	struct scx_sched *sch = scx_root;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
-	bool prev_on_rq = prev->scx.flags & SCX_TASK_QUEUED;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 	s32 cpu = cpu_of(rq);
 
-	lockdep_assert_rq_held(rq);
-	rq->scx.flags |= SCX_RQ_IN_BALANCE;
-	rq->scx.flags &= ~SCX_RQ_BAL_KEEP;
-
-	if ((sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
-	    unlikely(rq->scx.cpu_released)) {
-		/*
-		 * If the previous sched_class for the current CPU was not SCX,
-		 * notify the BPF scheduler that it again has control of the
-		 * core. This callback complements ->cpu_release(), which is
-		 * emitted in switch_class().
-		 */
-		if (SCX_HAS_OP(sch, cpu_acquire))
-			SCX_CALL_OP(sch, SCX_KF_REST, cpu_acquire, rq, cpu, NULL);
-		rq->scx.cpu_released = false;
-	}
-
-	if (prev_on_scx) {
-		update_curr_scx(rq);
-
-		/*
-		 * If @prev is runnable & has slice left, it has priority and
-		 * fetching more just increases latency for the fetched tasks.
-		 * Tell pick_task_scx() to keep running @prev. If the BPF
-		 * scheduler wants to handle this explicitly, it should
-		 * implement ->cpu_release().
-		 *
-		 * See scx_disable_workfn() for the explanation on the bypassing
-		 * test.
-		 */
-		if (prev_on_rq && prev->scx.slice && !scx_bypassing(sch, cpu)) {
-			rq->scx.flags |= SCX_RQ_BAL_KEEP;
-			goto has_tasks;
-		}
-	}
-
-	/* if there already are tasks to run, nothing to do */
-	if (rq->scx.local_dsq.nr)
-		goto has_tasks;
-
 	if (consume_global_dsq(sch, rq))
-		goto has_tasks;
+		return true;
 
-	if (scx_bypassing(sch, cpu)) {
-		if (consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu)))
-			goto has_tasks;
-		else
-			goto no_tasks;
-	}
+	if (scx_bypassing(sch, cpu))
+		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
 
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
-		goto no_tasks;
+		return false;
 
 	dspc->rq = rq;
 
@@ -2373,14 +2328,14 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 
 		flush_dispatch_buf(sch, rq);
 
-		if (prev_on_rq && prev->scx.slice) {
+		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice) {
 			rq->scx.flags |= SCX_RQ_BAL_KEEP;
-			goto has_tasks;
+			return true;
 		}
 		if (rq->scx.local_dsq.nr)
-			goto has_tasks;
+			return true;
 		if (consume_global_dsq(sch, rq))
-			goto has_tasks;
+			return true;
 
 		/*
 		 * ops.dispatch() can trap us in this loop by repeatedly
@@ -2389,7 +2344,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * balance(), we want to complete this scheduling cycle and then
 		 * start a new one. IOW, we want to call resched_curr() on the
 		 * next, most likely idle, task, not the current one. Use
-		 * scx_kick_cpu() for deferred kicking.
+		 * __scx_bpf_kick_cpu() for deferred kicking.
 		 */
 		if (unlikely(!--nr_loops)) {
 			scx_kick_cpu(sch, cpu, 0);
@@ -2397,12 +2352,64 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		}
 	} while (dspc->nr_tasks);
 
-no_tasks:
+	return false;
+}
+
+static int balance_one(struct rq *rq, struct task_struct *prev)
+{
+	struct scx_sched *sch = scx_root;
+	s32 cpu = cpu_of(rq);
+
+	lockdep_assert_rq_held(rq);
+	rq->scx.flags |= SCX_RQ_IN_BALANCE;
+	rq->scx.flags &= ~SCX_RQ_BAL_KEEP;
+
+	if ((sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
+	    unlikely(rq->scx.cpu_released)) {
+		/*
+		 * If the previous sched_class for the current CPU was not SCX,
+		 * notify the BPF scheduler that it again has control of the
+		 * core. This callback complements ->cpu_release(), which is
+		 * emitted in switch_class().
+		 */
+		if (SCX_HAS_OP(sch, cpu_acquire))
+			SCX_CALL_OP(sch, SCX_KF_REST, cpu_acquire, rq, cpu, NULL);
+		rq->scx.cpu_released = false;
+	}
+
+	if (prev->sched_class == &ext_sched_class) {
+		update_curr_scx(rq);
+
+		/*
+		 * If @prev is runnable & has slice left, it has priority and
+		 * fetching more just increases latency for the fetched tasks.
+		 * Tell pick_task_scx() to keep running @prev. If the BPF
+		 * scheduler wants to handle this explicitly, it should
+		 * implement ->cpu_release().
+		 *
+		 * See scx_disable_workfn() for the explanation on the bypassing
+		 * test.
+		 */
+		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice &&
+		    !scx_bypassing(sch, cpu)) {
+			rq->scx.flags |= SCX_RQ_BAL_KEEP;
+			goto has_tasks;
+		}
+	}
+
+	/* if there already are tasks to run, nothing to do */
+	if (rq->scx.local_dsq.nr)
+		goto has_tasks;
+
+	/* dispatch @sch */
+	if (scx_dispatch_sched(sch, rq, prev))
+		goto has_tasks;
+
 	/*
 	 * Didn't find another task to run. Keep running @prev unless
 	 * %SCX_OPS_ENQ_LAST is in effect.
 	 */
-	if (prev_on_rq &&
+	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
 	    (!(sch->ops.flags & SCX_OPS_ENQ_LAST) || scx_bypassing(sch, cpu))) {
 		rq->scx.flags |= SCX_RQ_BAL_KEEP;
 		__scx_add_event(sch, SCX_EV_DISPATCH_KEEP_LAST, 1);
-- 
2.52.0

