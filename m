Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878F3A1D2;
	Sat,  7 Mar 2026 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842327; cv=none; b=SNpifbWpWfFjkGclVDgHf0R8qsHdRKKIYZk/kx3yBPncHchdEz8fFl6I8GazCP/n5WGkQABPxAVqX5/QXQ3Gqth5GhYqGWpF9tNQeob43NT+yGCmMVSLxiMUmkN9GgC/c+f6gdbSx/5rdblQD7kTHMMZkbJ6krEmBl2c5tp38Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842327; c=relaxed/simple;
	bh=PAlGV16kiC8P0FmeoTrAiWUmmKUasGs1VLciNk4hlHg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tRYmKY0EXhlE66Eh8JXWRXV8ofkhf/xsOU4Ob/Zw2sJs1CxOr+yJXidRlkNbzh3qgue2ZgovBGUSJMWVMLw0b/f8PH95y/psD6PSCDJeqvb6W7ZgbUdpYwxLq+CcZvGi0ghady1a5kViB0LAmh3norkYqbtM2oYnGDDsJBlPtC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDLwmlIV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDLwmlIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BFBC4CEF7;
	Sat,  7 Mar 2026 00:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772842327;
	bh=PAlGV16kiC8P0FmeoTrAiWUmmKUasGs1VLciNk4hlHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uDLwmlIVwUVyVwrdLHky0Ttmh9ZlIzue7rdcltAQ11zSPAs70EmS18N0q1l23RA1/
	 F6GDpMwg5xADM1ej1uO+psc8IljtUmx+S+So9vEdrEWSpr7hFt3YnDFql5W0u16HwM
	 y8DqDNv2NQKLUPmrv3IIV9F/v7/6p1mBJAOuEevRcjbfHuF7s34+fnS3DXTqQ3dvNF
	 enM0lTzrnuXuivuny6NUqni0Gx2GFK/JU3lENKpDLPQ/QWniAHueAMP1I0lmFD1FDL
	 lr5Q+aWLeHDsK+bzjergMpQ1BFhVxdRQ6xR7Yx4Xw05IDOvqwE7kUyZ7Fj6DlpfzLZ
	 NlNwhrlODzNXA==
Date: Fri, 06 Mar 2026 14:12:06 -1000
Message-ID: <f452de511bd41ba99d77af11e37f76b0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v2 05/15] sched_ext: Relocate run_deferred() and its
 callees
In-Reply-To: <20260306190623.1076074-6-tj@kernel.org>
References: <20260306190623.1076074-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Previously, both process_ddsp_deferred_locals() and reenq_local() required
forward declarations. Reorganize so that only run_deferred() needs to be
declared. Both callees are grouped right before run_deferred() for better
locality. This reduces forward declaration clutter and will ease adding more
to the run_deferred() path.

No functional changes.

v2: Also relocate process_ddsp_deferred_locals() next to run_deferred()
    (Daniel Jordan).

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 kernel/sched/ext.c |  186 ++++++++++++++++++++++++++---------------------------
 1 file changed, 92 insertions(+), 94 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -193,9 +193,8 @@ MODULE_PARM_DESC(bypass_lb_intv_us, "byp
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched_ext.h>

-static void process_ddsp_deferred_locals(struct rq *rq);
+static void run_deferred(struct rq *rq);
 static bool task_dead_and_done(struct task_struct *p);
-static u32 reenq_local(struct scx_sched *sch, struct rq *rq);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
 static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
@@ -1003,23 +1002,6 @@ static int ops_sanitize_err(struct scx_s
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
@@ -2625,33 +2607,6 @@ has_tasks:
 	return true;
 }

-static void process_ddsp_deferred_locals(struct rq *rq)
-{
-	struct task_struct *p;
-
-	lockdep_assert_rq_held(rq);
-
-	/*
-	 * Now that @rq can be unlocked, execute the deferred enqueueing of
-	 * tasks directly dispatched to the local DSQs of other CPUs. See
-	 * direct_dispatch(). Keep popping from the head instead of using
-	 * list_for_each_entry_safe() as dispatch_local_dsq() may unlock @rq
-	 * temporarily.
-	 */
-	while ((p = list_first_entry_or_null(&rq->scx.ddsp_deferred_locals,
-				struct task_struct, scx.dsq_list.node))) {
-		struct scx_sched *sch = scx_task_sched(p);
-		struct scx_dispatch_q *dsq;
-
-		list_del_init(&p->scx.dsq_list.node);
-
-		dsq = find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, task_cpu(p));
-		if (!WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL))
-			dispatch_to_local_dsq(sch, rq, dsq, p,
-					      p->scx.ddsp_enq_flags);
-	}
-}
-
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct scx_sched *sch = scx_task_sched(p);
@@ -3072,7 +3027,6 @@ static void rq_offline_scx(struct rq *rq
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
 }

-
 static bool check_rq_for_timeouts(struct rq *rq)
 {
 	struct scx_sched *sch;
@@ -3612,6 +3566,97 @@ int scx_check_setscheduler(struct task_s
 	return 0;
 }

+static void process_ddsp_deferred_locals(struct rq *rq)
+{
+	struct task_struct *p;
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * Now that @rq can be unlocked, execute the deferred enqueueing of
+	 * tasks directly dispatched to the local DSQs of other CPUs. See
+	 * direct_dispatch(). Keep popping from the head instead of using
+	 * list_for_each_entry_safe() as dispatch_local_dsq() may unlock @rq
+	 * temporarily.
+	 */
+	while ((p = list_first_entry_or_null(&rq->scx.ddsp_deferred_locals,
+				struct task_struct, scx.dsq_list.node))) {
+		struct scx_sched *sch = scx_task_sched(p);
+		struct scx_dispatch_q *dsq;
+
+		list_del_init(&p->scx.dsq_list.node);
+
+		dsq = find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, task_cpu(p));
+		if (!WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL))
+			dispatch_to_local_dsq(sch, rq, dsq, p,
+					      p->scx.ddsp_enq_flags);
+	}
+}
+
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
@@ -7702,53 +7747,6 @@ static const struct btf_kfunc_id_set scx
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
tejun
