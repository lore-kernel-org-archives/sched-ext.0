Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DC421896;
	Fri,  6 Mar 2026 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823990; cv=none; b=SKMqVTF8x6QoeVGO9rTbd+csvHoFSS8Jr/tR3obGYi1iRG9CGUm6GtRGP6TyiXiHDVH+u5+lLxpm0h0zRyYUtFsHJz/wK25t0+hYO95c5Jx49yx9iIKVucHoU1tT09SIQihse8Y/3PcOHaLJSruoGtmAEq8YiiMptL+Ikg45Ccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823990; c=relaxed/simple;
	bh=7FtxTIo07St7SbU9jVka+e4YT0AZcPyWvlrjxfY9Shg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfujTjvi9uXUdd1KMAX2vQjdLtZVhvvHjCe9S1G3JEsonunOoiX8sMRPmI7GxAFvr1MP4nypvC4UvLvv49o0iS1hN74thqSZvCzXHY/np0w+5gTxVlOW74UCbni4J6iLOvHJP3oCrciLOcdp93NyPvlmip96MQ+sV04UzJlKxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASu5253X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASu5253X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A8FC2BCB0;
	Fri,  6 Mar 2026 19:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823989;
	bh=7FtxTIo07St7SbU9jVka+e4YT0AZcPyWvlrjxfY9Shg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASu5253XgHDrO+1+H8CT7pBNPfirH62Okq1JI/yPkT91vY5NfV+tahcyLDpQ0VjLl
	 6C/5LPtjF2e84iJ8BOr1d6GgAaH7VQOAARupYvYlKe8E0l4+/YKcqQwiqzOLgPWsld
	 j492bDfjGhypEuxjWrIqRpfia1nIO1cXnLS18BrUb71vlhh2uRBvsWD7JWalUR+DYW
	 uC7h/z/Cb1HZ5lfcTeTArTpVtJZC83tnmP5RcAjwDrJRUrqfwhvEl2wsW4JOsYiVjq
	 MM19lbWR0YNEi/xKKx2qQrs1UFfIq1tT9gVSI0SEI/E7r2uRQlAvnYTb7HIuQpz5b/
	 aHm/mf9sPWyRA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/15] sched_ext: Relocate reenq_local() and run_deferred()
Date: Fri,  6 Mar 2026 09:06:13 -1000
Message-ID: <20260306190623.1076074-6-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, both process_ddsp_deferred_locals() and reenq_local() required
forward declarations. Reorganize so that only run_deferred() needs to be
declared. This reduces forward declaration clutter and will ease adding more
to the run_deferred() path.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 132 ++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 67 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c44893878878..1b6cd1e4f8b9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -193,9 +193,8 @@ MODULE_PARM_DESC(bypass_lb_intv_us, "bypass load balance interval in microsecond
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched_ext.h>
 
-static void process_ddsp_deferred_locals(struct rq *rq);
+static void run_deferred(struct rq *rq);
 static bool task_dead_and_done(struct task_struct *p);
-static u32 reenq_local(struct scx_sched *sch, struct rq *rq);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
 static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
@@ -1003,23 +1002,6 @@ static int ops_sanitize_err(struct scx_sched *sch, const char *ops_name, s32 err
 	return -EPROTO;
 }
 
-static void run_deferred(struct rq *rq)
-{
-	process_ddsp_deferred_locals(rq);
-
-	if (!llist_empty(&rq->scx.deferred_reenq_locals)) {
-		struct llist_node *llist =
-			llist_del_all(&rq->scx.deferred_reenq_locals);
-		struct scx_sched_pcpu *pos, *next;
-
-		llist_for_each_entry_safe(pos, next, llist,
-					  deferred_reenq_locals_node) {
-			init_llist_node(&pos->deferred_reenq_locals_node);
-			reenq_local(pos->sch, rq);
-		}
-	}
-}
-
 static void deferred_bal_cb_workfn(struct rq *rq)
 {
 	run_deferred(rq);
@@ -3072,7 +3054,6 @@ static void rq_offline_scx(struct rq *rq)
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
 }
 
-
 static bool check_rq_for_timeouts(struct rq *rq)
 {
 	struct scx_sched *sch;
@@ -3612,6 +3593,70 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 	return 0;
 }
 
+static u32 reenq_local(struct scx_sched *sch, struct rq *rq)
+{
+	LIST_HEAD(tasks);
+	u32 nr_enqueued = 0;
+	struct task_struct *p, *n;
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * The BPF scheduler may choose to dispatch tasks back to
+	 * @rq->scx.local_dsq. Move all candidate tasks off to a private list
+	 * first to avoid processing the same tasks repeatedly.
+	 */
+	list_for_each_entry_safe(p, n, &rq->scx.local_dsq.list,
+				 scx.dsq_list.node) {
+		struct scx_sched *task_sch = scx_task_sched(p);
+
+		/*
+		 * If @p is being migrated, @p's current CPU may not agree with
+		 * its allowed CPUs and the migration_cpu_stop is about to
+		 * deactivate and re-activate @p anyway. Skip re-enqueueing.
+		 *
+		 * While racing sched property changes may also dequeue and
+		 * re-enqueue a migrating task while its current CPU and allowed
+		 * CPUs disagree, they use %ENQUEUE_RESTORE which is bypassed to
+		 * the current local DSQ for running tasks and thus are not
+		 * visible to the BPF scheduler.
+		 */
+		if (p->migration_pending)
+			continue;
+
+		if (!scx_is_descendant(task_sch, sch))
+			continue;
+
+		dispatch_dequeue(rq, p);
+		list_add_tail(&p->scx.dsq_list.node, &tasks);
+	}
+
+	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
+		list_del_init(&p->scx.dsq_list.node);
+		do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
+		nr_enqueued++;
+	}
+
+	return nr_enqueued;
+}
+
+static void run_deferred(struct rq *rq)
+{
+	process_ddsp_deferred_locals(rq);
+
+	if (!llist_empty(&rq->scx.deferred_reenq_locals)) {
+		struct llist_node *llist =
+			llist_del_all(&rq->scx.deferred_reenq_locals);
+		struct scx_sched_pcpu *pos, *next;
+
+		llist_for_each_entry_safe(pos, next, llist,
+					  deferred_reenq_locals_node) {
+			init_llist_node(&pos->deferred_reenq_locals_node);
+			reenq_local(pos->sch, rq);
+		}
+	}
+}
+
 #ifdef CONFIG_NO_HZ_FULL
 bool scx_can_stop_tick(struct rq *rq)
 {
@@ -7702,53 +7747,6 @@ static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
 	.set			= &scx_kfunc_ids_dispatch,
 };
 
-static u32 reenq_local(struct scx_sched *sch, struct rq *rq)
-{
-	LIST_HEAD(tasks);
-	u32 nr_enqueued = 0;
-	struct task_struct *p, *n;
-
-	lockdep_assert_rq_held(rq);
-
-	/*
-	 * The BPF scheduler may choose to dispatch tasks back to
-	 * @rq->scx.local_dsq. Move all candidate tasks off to a private list
-	 * first to avoid processing the same tasks repeatedly.
-	 */
-	list_for_each_entry_safe(p, n, &rq->scx.local_dsq.list,
-				 scx.dsq_list.node) {
-		struct scx_sched *task_sch = scx_task_sched(p);
-
-		/*
-		 * If @p is being migrated, @p's current CPU may not agree with
-		 * its allowed CPUs and the migration_cpu_stop is about to
-		 * deactivate and re-activate @p anyway. Skip re-enqueueing.
-		 *
-		 * While racing sched property changes may also dequeue and
-		 * re-enqueue a migrating task while its current CPU and allowed
-		 * CPUs disagree, they use %ENQUEUE_RESTORE which is bypassed to
-		 * the current local DSQ for running tasks and thus are not
-		 * visible to the BPF scheduler.
-		 */
-		if (p->migration_pending)
-			continue;
-
-		if (!scx_is_descendant(task_sch, sch))
-			continue;
-
-		dispatch_dequeue(rq, p);
-		list_add_tail(&p->scx.dsq_list.node, &tasks);
-	}
-
-	list_for_each_entry_safe(p, n, &tasks, scx.dsq_list.node) {
-		list_del_init(&p->scx.dsq_list.node);
-		do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
-		nr_enqueued++;
-	}
-
-	return nr_enqueued;
-}
-
 __bpf_kfunc_start_defs();
 
 /**
-- 
2.53.0

