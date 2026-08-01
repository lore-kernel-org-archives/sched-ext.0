Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A6367B97;
	Sat,  1 Aug 2026 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574316; cv=none; b=chbYdaKgNFtMu3M4JowuRrdr0O2IlTlhN8TpNgLNs/hOMu/qR1v97kwLPReJo3Rl/9s5FHHFoaz/7H3/5h8lHNBXyalR3untedI1X2zw5nrdOVEmU+FuhtCYA26+/V74RusRQOG63DY5z5y5buLp8kPhmxI2CCKupL/H2jHyc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574316; c=relaxed/simple;
	bh=dKn91YkSxnflM4yg9CHSa0B0jqeE9lnbZzcpu1qrc74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eibgZ8WXH1X0EgIINowDCPrPUDrpZ0mLafF51GhO94CgMSx8fda+wf3UuqR2+0tJI8xep6Y7x4FutGJTTSvqh6BAaFGLMMwC9rVWDYIOW7Sf8RfSKhBYUy3ETnEVMCVTipYUkxejp+wkGBDDqhwoW3aPvN1tgr4vLG12giwmj5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqMAltO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqMAltO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985521F00AC4;
	Sat,  1 Aug 2026 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574313;
	bh=PG9EGQ1bgttJI/F8ePygH0FiFdwBOcyN4taMEr5jGAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jqMAltO1p7SWHjUuD/wRJpG9psVmNFlEsPxgJ52tKWKenXCrAYUmA5MIxuLt77wXo
	 yInE0UctVJXcn6H26f0BEKU5uKWBT15Xf71O+dxOlwMTYOdtzCD/HQQv4Hx8wX/4pb
	 DaFek0xD1OC5L38cOgvdvu8Cpq7UQjUg3ElKIYZ1/Y9Kro99lrTC6poDb9GnqkFffS
	 YVvRZUuaaqCogVNfC1EDmDUuq0clEAi7bRv/fnoopgoiMsRIuC1siqz4INEssudSSk
	 63G6VD757SEv+fXhQqrb/5RIxMb0FERGHc95xnWpC3TCn6QxnPrpeoh9AHR+hZXk8A
	 XJt5PW87rbNYA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/12] sched_ext: Make several ext.c helpers available outside ext.c
Date: Fri, 31 Jul 2026 22:51:40 -1000
Message-ID: <20260801085150.2697653-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801085150.2697653-1-tj@kernel.org>
References: <20260801085150.2697653-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_task_slice(), task_unlink_from_dsq(), move_local_task_to_local_dsq(),
init_dsq() and dump_line() will be used outside ext.c. Add the scx_ prefix
and declare them in internal.h. The scx_sched_all list will also be used
outside ext.c, drop its static. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 172 +++++++++++++++++-------------------
 kernel/sched/ext/internal.h |   8 ++
 2 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 595b45746245..59c9c1f2dc04 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -38,7 +38,7 @@ struct scx_sched __rcu *scx_root;
  * All scheds, writers must hold both scx_enable_mutex and scx_sched_lock.
  * Readers can hold either or rcu_read_lock().
  */
-static LIST_HEAD(scx_sched_all);
+LIST_HEAD(scx_sched_all);
 
 #ifdef CONFIG_EXT_SUB_SCHED
 const struct rhashtable_params scx_sched_hash_params = {
@@ -900,7 +900,7 @@ struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
  * @kind: a kind of event to dump
  */
 #define scx_dump_event(s, events, kind) do {					\
-	dump_line(&(s), "%40s: %16lld", #kind, (events)->kind);			\
+	scx_dump_line(&(s), "%40s: %16lld", #kind, (events)->kind);		\
 } while (0)
 
 
@@ -1248,7 +1248,7 @@ static void set_task_slice_keep_oob(struct task_struct *p, u64 slice)
 }
 
 /* set @p's slice, superseding any pending out-of-band request */
-static void set_task_slice(struct task_struct *p, u64 slice)
+void scx_set_task_slice(struct task_struct *p, u64 slice)
 {
 	set_task_slice_keep_oob(p, slice);
 	clear_task_slice_oob(p);
@@ -1495,7 +1495,7 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 
 	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
 	    rq->curr->sched_class == &ext_sched_class) {
-		set_task_slice(rq->curr, 0);
+		scx_set_task_slice(rq->curr, 0);
 		resched_curr(rq);
 	}
 }
@@ -1637,8 +1637,7 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
 }
 
-static void task_unlink_from_dsq(struct task_struct *p,
-				 struct scx_dispatch_q *dsq)
+void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq)
 {
 	WARN_ON_ONCE(list_empty(&p->scx.dsq_list.node));
 
@@ -1695,7 +1694,7 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	*/
 	if (p->scx.holding_cpu < 0) {
 		/* @p must still be on @dsq, dequeue */
-		task_unlink_from_dsq(p, dsq);
+		scx_task_unlink_from_dsq(p, dsq);
 	} else {
 		/*
 		 * We're racing against dispatch_to_local_dsq() which already
@@ -1722,7 +1721,7 @@ static void dispatch_dequeue_locked(struct task_struct *p,
 	lockdep_assert_rq_held(task_rq(p));
 	lockdep_assert_held(&dsq->lock);
 
-	task_unlink_from_dsq(p, dsq);
+	scx_task_unlink_from_dsq(p, dsq);
 	p->scx.dsq = NULL;
 }
 
@@ -2236,7 +2235,7 @@ static void yield_task_scx(struct rq *rq)
 	if (SCX_HAS_OP(sch, yield))
 		SCX_CALL_OP_2TASKS_RET(sch, yield, rq, p, NULL);
 	else
-		set_task_slice(p, 0);
+		scx_set_task_slice(p, 0);
 }
 
 static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
@@ -2274,10 +2273,9 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 		scx_schedule_reenq_local(rq, 0);
 }
 
-static void move_local_task_to_local_dsq(struct scx_sched *sch,
-					 struct task_struct *p, u64 enq_flags,
-					 struct scx_dispatch_q *src_dsq,
-					 struct rq *dst_rq)
+void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
+				      u64 enq_flags, struct scx_dispatch_q *src_dsq,
+				      struct rq *dst_rq)
 {
 	struct scx_dispatch_q *dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
 
@@ -2458,7 +2456,7 @@ static bool unlink_dsq_and_switch_rq_lock(struct task_struct *p,
 	lockdep_assert_rq_held(locked_rq);
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
-	task_unlink_from_dsq(p, dsq);
+	scx_task_unlink_from_dsq(p, dsq);
 	p->scx.holding_cpu = cpu;
 
 	raw_spin_unlock(&dsq->lock);
@@ -2529,9 +2527,8 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		/* @p is going from a non-local DSQ to a local DSQ */
 		if (src_rq == dst_rq) {
-			task_unlink_from_dsq(p, src_dsq);
-			move_local_task_to_local_dsq(sch, p, enq_flags,
-						     src_dsq, dst_rq);
+			scx_task_unlink_from_dsq(p, src_dsq);
+			scx_move_local_task_to_local_dsq(sch, p, enq_flags, src_dsq, dst_rq);
 			raw_spin_unlock(&src_dsq->lock);
 		} else {
 			raw_spin_unlock(&src_dsq->lock);
@@ -2581,8 +2578,8 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			break;
 
 		if (rq == task_rq) {
-			task_unlink_from_dsq(p, dsq);
-			move_local_task_to_local_dsq(sch, p, enq_flags, dsq, rq);
+			scx_task_unlink_from_dsq(p, dsq);
+			scx_move_local_task_to_local_dsq(sch, p, enq_flags, dsq, rq);
 			raw_spin_unlock(&dsq->lock);
 			return true;
 		}
@@ -3530,7 +3527,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * we can't trust the slice management or ops.core_sched_before().
 	 */
 	if (scx_bypassing(sch, cpu_of(rq))) {
-		set_task_slice(curr, 0);
+		scx_set_task_slice(curr, 0);
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(sch, tick)) {
 		SCX_CALL_OP_TASK(sch, tick, rq, curr);
@@ -3685,7 +3682,7 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 	 * control, after ops.disable() has observed their final values.
 	 */
 	p->scx.dsq_vtime = 0;
-	set_task_slice(p, 0);
+	scx_set_task_slice(p, 0);
 	p->scx.reenq_cnt = 0;
 
 	/*
@@ -4184,7 +4181,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 	if ((reenq_flags & SCX_REENQ_CAP_REVOKE) &&
 	    rq->curr->sched_class == &ext_sched_class &&
 	    scx_task_reenq_on_cap_revoke(rq, rq->curr)) {
-		set_task_slice(rq->curr, 0);
+		scx_set_task_slice(rq->curr, 0);
 		resched_curr(rq);
 	}
 
@@ -4748,8 +4745,7 @@ DEFINE_SCHED_CLASS(ext) = {
 #endif
 };
 
-static s32 init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id,
-		    struct scx_sched *sch)
+s32 scx_init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id, struct scx_sched *sch)
 {
 	s32 cpu;
 
@@ -6375,7 +6371,7 @@ static void dump_newline(struct seq_buf *s)
 		seq_buf_putc(s, '\n');
 }
 
-static __printf(2, 3) void dump_line(struct seq_buf *s, const char *fmt, ...)
+__printf(2, 3) void scx_dump_line(struct seq_buf *s, const char *fmt, ...)
 {
 	va_list args;
 
@@ -6407,7 +6403,7 @@ static void dump_stack_trace(struct seq_buf *s, const char *prefix,
 	unsigned int i;
 
 	for (i = 0; i < len; i++)
-		dump_line(s, "%s%pS", prefix, (void *)bt[i]);
+		scx_dump_line(s, "%s%pS", prefix, (void *)bt[i]);
 }
 
 static void ops_dump_init(struct seq_buf *s, const char *prefix)
@@ -6457,7 +6453,7 @@ static void ops_dump_flush(void)
 		 */
 		c = *end;
 		*end = '\0';
-		dump_line(dd->s, "%s%s", dd->prefix, line);
+		scx_dump_line(dd->s, "%s%s", dd->prefix, line);
 		if (c == '\0')
 			break;
 
@@ -6501,21 +6497,19 @@ static void scx_dump_task(struct scx_sched *sch, struct seq_buf *s, struct scx_d
 			  (unsigned long long)p->scx.dsq->id);
 
 	dump_newline(s);
-	dump_line(s, " %c%c %s[%d] %s%s %+ldms",
-		  marker, task_state_to_char(p), p->comm, p->pid,
-		  own_marker, sch_id_buf,
-		  jiffies_delta_msecs(p->scx.runnable_at, dctx->at_jiffies));
-	dump_line(s, "      scx_state/flags=%u/0x%x dsq_flags=0x%x ops_state/qseq=%lu/%lu",
-		  scx_get_task_state(p) >> SCX_TASK_STATE_SHIFT,
-		  p->scx.flags & ~SCX_TASK_STATE_MASK,
-		  p->scx.dsq_flags, ops_state & SCX_OPSS_STATE_MASK,
-		  ops_state >> SCX_OPSS_QSEQ_SHIFT);
-	dump_line(s, "      sticky/holding_cpu=%d/%d dsq_id=%s",
-		  p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf);
-	dump_line(s, "      dsq_vtime=%llu slice=%llu weight=%u",
-		  p->scx.dsq_vtime, p->scx.slice, p->scx.weight);
-	dump_line(s, "      cpus=%*pb no_mig=%u", cpumask_pr_args(p->cpus_ptr),
-		  p->migration_disabled);
+	scx_dump_line(s, " %c%c %s[%d] %s%s %+ldms",
+		      marker, task_state_to_char(p), p->comm, p->pid, own_marker, sch_id_buf,
+		      jiffies_delta_msecs(p->scx.runnable_at, dctx->at_jiffies));
+	scx_dump_line(s, "      scx_state/flags=%u/0x%x dsq_flags=0x%x ops_state/qseq=%lu/%lu",
+		      scx_get_task_state(p) >> SCX_TASK_STATE_SHIFT,
+		      p->scx.flags & ~SCX_TASK_STATE_MASK, p->scx.dsq_flags,
+		      ops_state & SCX_OPSS_STATE_MASK, ops_state >> SCX_OPSS_QSEQ_SHIFT);
+	scx_dump_line(s, "      sticky/holding_cpu=%d/%d dsq_id=%s",
+		      p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf);
+	scx_dump_line(s, "      dsq_vtime=%llu slice=%llu weight=%u",
+		      p->scx.dsq_vtime, p->scx.slice, p->scx.weight);
+	scx_dump_line(s, "      cpus=%*pb no_mig=%u", cpumask_pr_args(p->cpus_ptr),
+		      p->migration_disabled);
 
 	if (SCX_HAS_OP(sch, dump_task)) {
 		ops_dump_init(s, "    ");
@@ -6563,28 +6557,26 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	seq_buf_init(&ns, buf, avail);
 
 	dump_newline(&ns);
-	dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu ksync=%lu",
-		  cpu, rq->scx.nr_running, rq->scx.flags,
-		  rq->scx.cpu_released, rq->scx.ops_qseq,
-		  rq->scx.kick_sync);
-	dump_line(&ns, "          curr=%s[%d] class=%ps",
-		  rq->curr->comm, rq->curr->pid,
-		  rq->curr->sched_class);
+	scx_dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu ksync=%lu",
+		      cpu, rq->scx.nr_running, rq->scx.flags, rq->scx.cpu_released,
+		      rq->scx.ops_qseq, rq->scx.kick_sync);
+	scx_dump_line(&ns, "          curr=%s[%d] class=%ps",
+		      rq->curr->comm, rq->curr->pid, rq->curr->sched_class);
 	if (!cpumask_empty(pcpu->cpus_to_kick))
-		dump_line(&ns, "  cpus_to_kick   : %*pb",
-			  cpumask_pr_args(pcpu->cpus_to_kick));
+		scx_dump_line(&ns, "  cpus_to_kick   : %*pb",
+			      cpumask_pr_args(pcpu->cpus_to_kick));
 	if (!cpumask_empty(pcpu->cpus_to_kick_if_idle))
-		dump_line(&ns, "  idle_to_kick   : %*pb",
-			  cpumask_pr_args(pcpu->cpus_to_kick_if_idle));
+		scx_dump_line(&ns, "  idle_to_kick   : %*pb",
+			      cpumask_pr_args(pcpu->cpus_to_kick_if_idle));
 	if (!cpumask_empty(pcpu->cpus_to_preempt))
-		dump_line(&ns, "  cpus_to_preempt: %*pb",
-			  cpumask_pr_args(pcpu->cpus_to_preempt));
+		scx_dump_line(&ns, "  cpus_to_preempt: %*pb",
+			      cpumask_pr_args(pcpu->cpus_to_preempt));
 	if (!cpumask_empty(pcpu->cpus_to_wait))
-		dump_line(&ns, "  cpus_to_wait   : %*pb",
-			  cpumask_pr_args(pcpu->cpus_to_wait));
+		scx_dump_line(&ns, "  cpus_to_wait   : %*pb",
+			      cpumask_pr_args(pcpu->cpus_to_wait));
 	if (!cpumask_empty(rq->scx.cpus_to_sync))
-		dump_line(&ns, "  cpus_to_sync   : %*pb",
-			  cpumask_pr_args(rq->scx.cpus_to_sync));
+		scx_dump_line(&ns, "  cpus_to_sync   : %*pb",
+			      cpumask_pr_args(rq->scx.cpus_to_sync));
 
 	used = seq_buf_used(&ns);
 	if (SCX_HAS_OP(sch, dump_cpu)) {
@@ -6652,25 +6644,25 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 
 #ifdef CONFIG_EXT_SUB_SCHED
 	if (sch->level == 0)
-		dump_line(&s, "%s: root", sch->ops.name);
+		scx_dump_line(&s, "%s: root", sch->ops.name);
 	else
-		dump_line(&s, "%s: sub%d-%llu %s",
-			  sch->ops.name, sch->level, sch->ops.sub_cgroup_id,
-			  sch->cgrp_path);
+		scx_dump_line(&s, "%s: sub%d-%llu %s",
+			      sch->ops.name, sch->level, sch->ops.sub_cgroup_id,
+			      sch->cgrp_path);
 #endif
 	if (ei->kind == SCX_EXIT_NONE) {
-		dump_line(&s, "Debug dump triggered by %s", ei->reason);
+		scx_dump_line(&s, "Debug dump triggered by %s", ei->reason);
 	} else {
 		if (ei->exit_cpu >= 0)
-			dump_line(&s, "%s[%d] triggered exit kind %d on CPU %d:",
-				  current->comm, current->pid, ei->kind,
-				  ei->exit_cpu);
+			scx_dump_line(&s, "%s[%d] triggered exit kind %d on CPU %d:",
+				      current->comm, current->pid, ei->kind,
+				      ei->exit_cpu);
 		else
-			dump_line(&s, "%s[%d] triggered exit kind %d:",
-				  current->comm, current->pid, ei->kind);
-		dump_line(&s, "  %s (%s)", ei->reason, ei->msg);
+			scx_dump_line(&s, "%s[%d] triggered exit kind %d:",
+				      current->comm, current->pid, ei->kind);
+		scx_dump_line(&s, "  %s (%s)", ei->reason, ei->msg);
 		dump_newline(&s);
-		dump_line(&s, "Backtrace:");
+		scx_dump_line(&s, "Backtrace:");
 		dump_stack_trace(&s, "  ", ei->bt, ei->bt_len);
 	}
 
@@ -6681,8 +6673,8 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	}
 
 	dump_newline(&s);
-	dump_line(&s, "CPU states");
-	dump_line(&s, "----------");
+	scx_dump_line(&s, "CPU states");
+	scx_dump_line(&s, "----------");
 
 	/*
 	 * Dump stalled CPUs first so they aren't lost to dump truncation, then
@@ -6705,8 +6697,8 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	}
 
 	dump_newline(&s);
-	dump_line(&s, "Event counters");
-	dump_line(&s, "--------------");
+	scx_dump_line(&s, "Event counters");
+	scx_dump_line(&s, "--------------");
 
 	scx_read_events(sch, &events);
 #define SCX_EVENT(name)	scx_dump_event(s, &events, name)
@@ -6815,7 +6807,7 @@ static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int node)
 	if (!pnode)
 		return NULL;
 
-	if (init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch)) {
+	if (scx_init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch)) {
 		kfree(pnode);
 		return NULL;
 	}
@@ -6876,7 +6868,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 	}
 
 	for_each_possible_cpu(cpu) {
-		ret = init_dsq(scx_bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
+		ret = scx_init_dsq(scx_bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
 		if (ret) {
 			bypass_fail_cpu = cpu;
 			goto err_free_pcpu;
@@ -7509,7 +7501,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			set_task_slice(p, READ_ONCE(sch->slice_dfl));
+			scx_set_task_slice(p, READ_ONCE(sch->slice_dfl));
 			p->sched_class = new_class;
 		}
 	}
@@ -8159,7 +8151,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 			if (cur_class == &ext_sched_class) {
 				if (likely(!scx_missing_caps(pcpu->sch, cpu,
 							     scx_caps_for_preempt(pcpu->sch, rq))))
-					set_task_slice(rq->curr, 0);
+					scx_set_task_slice(rq->curr, 0);
 				else
 					__scx_add_event(pcpu->sch,
 							SCX_EV_SUB_PREEMPT_DENIED, 1);
@@ -8363,9 +8355,9 @@ void __init init_sched_ext_class(void)
 		int  n = cpu_to_node(cpu);
 
 		/* local_dsq's sch will be set during scx_root_enable() */
-		BUG_ON(init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL));
+		BUG_ON(scx_init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL));
 #ifdef CONFIG_EXT_SUB_SCHED
-		BUG_ON(init_dsq(&rq->scx.reject_dsq, SCX_DSQ_REJECT, NULL));
+		BUG_ON(scx_init_dsq(&rq->scx.reject_dsq, SCX_DSQ_REJECT, NULL));
 #endif
 
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
@@ -8522,7 +8514,7 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 		return false;
 
 	if (slice)
-		set_task_slice(p, slice);
+		scx_set_task_slice(p, slice);
 	else
 		set_task_slice_keep_oob(p, p->scx.slice ?: 1);
 
@@ -8548,7 +8540,7 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 		return false;
 
 	if (slice)
-		set_task_slice(p, slice);
+		scx_set_task_slice(p, slice);
 	else
 		set_task_slice_keep_oob(p, p->scx.slice ?: 1);
 
@@ -8732,7 +8724,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
 		p->scx.dsq_vtime = kit->vtime;
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_SLICE)
-		set_task_slice(p, kit->slice);
+		scx_set_task_slice(p, kit->slice);
 
 	/* execute move */
 	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
@@ -9055,10 +9047,10 @@ __bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node, const struct bpf_prog_a
 		return -ENOMEM;
 
 	/*
-	 * init_dsq() must be called in GFP_KERNEL context. Init it with NULL
-	 * @sch and update afterwards.
+	 * scx_init_dsq() must be called in GFP_KERNEL context. Init it with
+	 * NULL @sch and update afterwards.
 	 */
-	ret = init_dsq(dsq, dsq_id, NULL);
+	ret = scx_init_dsq(dsq, dsq_id, NULL);
 	if (ret) {
 		kfree(dsq);
 		return ret;
@@ -9152,7 +9144,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 	    unlikely(scx_missing_caps(sch, cpu_of(locked_rq), SCX_CAP_BASE)))
 		__scx_add_event(sch, SCX_EV_SLICE_DENIED, 1);
 	else
-		set_task_slice(p, slice);
+		scx_set_task_slice(p, slice);
 
 	return true;
 }
@@ -9701,8 +9693,8 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 	ret = __bstr_format(sch, buf->data, buf->line + dd->cursor,
 			    sizeof(buf->line) - dd->cursor, fmt, data, data__sz);
 	if (ret < 0) {
-		dump_line(dd->s, "%s[!] (\"%s\", %p, %u) failed to format (%d)",
-			  dd->prefix, fmt, data, data__sz, ret);
+		scx_dump_line(dd->s, "%s[!] (\"%s\", %p, %u) failed to format (%d)",
+			      dd->prefix, fmt, data, data__sz, ret);
 		return;
 	}
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 7501ec28958b..e234a51cf82d 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1968,14 +1968,21 @@ void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp);
 void scx_task_iter_unlock(struct scx_task_iter *iter);
 void scx_task_iter_stop(struct scx_task_iter *iter);
 struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
+void scx_set_task_slice(struct task_struct *p, u64 slice);
+void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq);
 void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
+void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
+				      u64 enq_flags, struct scx_dispatch_q *src_dsq,
+				      struct rq *dst_rq);
 bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			    struct scx_dispatch_q *dsq, u64 enq_flags);
 bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq);
 bool scx_rq_online(struct rq *rq);
 void scx_flush_dispatch_buf(struct scx_sched *sch, struct rq *rq);
+s32 scx_init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id, struct scx_sched *sch);
+__printf(2, 3) void scx_dump_line(struct seq_buf *s, const char *fmt, ...);
 void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq);
@@ -2014,6 +2021,7 @@ extern bool scx_cgroup_enabled;
 #ifdef CONFIG_EXT_SUB_SCHED
 extern const struct rhashtable_params scx_sched_hash_params;
 extern struct rhashtable scx_sched_hash;
+extern struct list_head scx_sched_all;
 extern struct scx_sched *scx_enabling_sub_sched;
 #endif
 
-- 
2.55.0

