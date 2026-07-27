Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437C3BED7D;
	Mon, 27 Jul 2026 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184602; cv=none; b=CrJSdQeCMGWRCHph3Q+WKKG77KdkNuyomw/FFixDp4JRu409hLM3C4TArTtAMr0y6Pt7P72x2QoVhzbpvvs7W60dmiQ1xEZkz1AddWMQjKM6j+8IAU0G5HTO5Eg7ENhPv20KBXwahKp1lnIE7fyk8qkpsq9ilah89MOxq8/y+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184602; c=relaxed/simple;
	bh=aIiHF+ZRNCz6aXdkc3OZKTMOGqN3ydFigHrVw4pBgI8=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=acdXvL1tazAEogfR53+Bjip7Y42yZy7kucK2x+Iv8HP9L+4pxFYeldjrCcuJKMAOr5BQuGWOaImJdvFMl2TP4cD3XCWAsd28fMjl5cf2ZiQi43o+NkN8+if0ws441VQ0IrfrlEVjseFie0Wmvp9XLBIrQOLfPDVIAPGJ0D2wl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwBhi8Wz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwBhi8Wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADE81F000E9;
	Mon, 27 Jul 2026 20:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785184599;
	bh=cWReivQZS7VMcuOofScUXvenvwxQ5GhJIvqAeiSlMKg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=hwBhi8Wz/bIVlpvFMeQrQCfZ57f81X8MEnO9cy7zrol4uxsiZvfFRy2SXD6BZ2Qg0
	 9TMSNq3jT4qyUhy9/cmALEefGqdwoaYGd1VSZWyQZk/cya96YDB0Re6GBUSX0Etaur
	 aMFQtdK79JTmlDxDYhGdojt1qrXybzUZVS7WZWpo/GzfH63sgJk0ql0sPJ9+5DqCFr
	 F4hKHEUrzr/m/d+2eJruMUgWVQa873kt30ldia+PxcO9ib7iYx5LzKrH/3tuwUvaBQ
	 OBCy7V0F7+gGkqNDiimAzd/sGLnYJb7l/U6aFPLxWV016hpPFPnNdleIi9OW8KUJ0f
	 sxb2yS0E6+PMg==
Date: Mon, 27 Jul 2026 10:36:38 -1000
Message-ID: <684ed36923a4f388b8be726cfbfc5154@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260725005019.1297049-2-tj@kernel.org>
References: <20260725005019.1297049-1-tj@kernel.org> <20260725005019.1297049-2-tj@kernel.org>
Subject: [PATCH v2 1/5] sched_ext: Make exit claiming lock-free
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_claim_exit() claims descendants' exits by walking the subtree under
scx_sched_lock, making exit claiming, and thus scx_error(), unusable from
NMI and from under scx_sched_lock. However, kfuncs raising errors can run
from NMI-attached BPF progs, the hardlockup handler runs in NMI, and
scx_link_sched() wants to report failures under the lock.

The walk does two things with different urgencies: ->aborting must be
asserted synchronously to break IRQs-off dispatch-path live-locks, while the
descendants' exit_kind claims can happen later. Split them: sweep ->aborting
locklessly under RCU to unwedge the system and defer the locked
SCX_EXIT_PARENT walk to a new irq_work, both of which are NMI-safe.

The sweep stores each node's ->aborting and then reads its children list
while scx_link_sched() inserts and then checks the parent's ->aborting, the
two sides paired by full barriers - one side always sees the other. A link
that sees ->aborting undoes its insert and fails. As the undo's
list_del_rcu() leaves ->sibling non-empty, list_empty() can no longer
identify a never-linked sched during teardown - add sch->linked instead.

trace_sched_ext_exit can now fire from NMI and is called after the
->aborting stores so that its callbacks don't hold up live-lock recovery.
The exit backtrace is skipped for NMI exits as stack_trace_save()'s
NMI-safety is arch-dependent and undocumented.

v2: Move trace_sched_ext_exit() after the ->aborting stores (Andrea).

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  110 ++++++++++++++++++++++++++++----------------
 kernel/sched/ext/internal.h |    2 
 kernel/sched/ext/sub.c      |   12 ++--
 3 files changed, 79 insertions(+), 45 deletions(-)

--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5027,6 +5027,7 @@ static void scx_sched_free_rcu_work(stru
 	struct scx_dispatch_q *dsq;
 	int cpu, node;
 
+	irq_work_sync(&sch->propagate_exit_irq_work);
 	irq_work_sync(&sch->disable_irq_work);
 	kthread_destroy_worker(sch->helper);
 	timer_shutdown_sync(&sch->bypass_lb_timer);
@@ -5994,18 +5995,6 @@ s32 scx_link_sched(struct scx_sched *sch
 
 		if (parent) {
 			/*
-			 * scx_claim_exit() propagates exit_kind transition to
-			 * its sub-scheds while holding scx_sched_lock - either
-			 * we can see the parent's non-NONE exit_kind or the
-			 * parent can shoot us down.
-			 */
-			if (atomic_read(&parent->exit_kind) != SCX_EXIT_NONE) {
-				err_msg = "parent disabled";
-				ret = -ENOENT;
-				break;
-			}
-
-			/*
 			 * Bypass state is spread across per-cpu flags and a
 			 * depth count, so inheriting it is tricky and has no
 			 * valid use case. Refuse it.
@@ -6024,6 +6013,23 @@ s32 scx_link_sched(struct scx_sched *sch
 			}
 
 			list_add_tail_rcu(&sch->sibling, &parent->children);
+
+			/*
+			 * Pairs with the mb after the ->aborting assertion in
+			 * scx_claim_exit(). Either we see ->aborting and back
+			 * out, or the exit path sees us and exits us.
+			 */
+			smp_mb();
+			if (unlikely(READ_ONCE(parent->aborting))) {
+				rhashtable_remove_fast(&scx_sched_hash, &sch->hash_node,
+						       scx_sched_hash_params);
+				list_del_rcu(&sch->sibling);
+				err_msg = "parent disabled";
+				ret = -ENOENT;
+				break;
+			}
+
+			sch->linked = true;
 		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -6047,10 +6053,11 @@ void scx_unlink_sched(struct scx_sched *
 {
 	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
-		if (scx_parent(sch)) {
+		if (sch->linked) {
 			rhashtable_remove_fast(&scx_sched_hash, &sch->hash_node,
 					       scx_sched_hash_params);
 			list_del_rcu(&sch->sibling);
+			sch->linked = false;
 		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 		list_del_rcu(&sch->all);
@@ -6260,12 +6267,36 @@ done:
 	scx_bypass(sch, false);
 }
 
+/**
+ * scx_propagate_exit_irq_workfn - Claim SCX_EXIT_PARENT on the exiting subtree
+ * @irq_work: &scx_sched.propagate_exit_irq_work
+ *
+ * Queued by scx_claim_exit() after a non-PARENT claim. Claims SCX_EXIT_PARENT
+ * on each descendant, giving every one its own disable work - most of disabling
+ * is serialized but ops.exit() can take arbitrarily long and running them in
+ * separate helper kthreads parallelizes it. No recursion as only non-PARENT
+ * claims propagate.
+ */
+static void scx_propagate_exit_irq_workfn(struct irq_work *irq_work)
+{
+	struct scx_sched *sch = container_of(irq_work, struct scx_sched,
+					     propagate_exit_irq_work);
+	struct scx_sched *pos;
+
+	scoped_guard (raw_spinlock_irqsave, &scx_sched_lock) {
+		scx_for_each_descendant_pre(pos, sch)
+			scx_disable(pos, SCX_EXIT_PARENT);
+	}
+}
+
 /*
  * Claim the exit on @sch. The caller must ensure that the helper kthread work
  * is kicked before the current task can be preempted. Once exit_kind is
  * claimed, scx_error() can no longer trigger, so if the current task gets
  * preempted and the BPF scheduler fails to schedule it back, the helper work
  * will never be kicked and the whole system can wedge.
+ *
+ * Lock-free and safe to call from any context including NMI.
  */
 static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 {
@@ -6279,37 +6310,31 @@ static bool scx_claim_exit(struct scx_sc
 	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
 		return false;
 
-	/*
-	 * Some CPUs may be trapped in the dispatch paths. Set the aborting
-	 * flag to break potential live-lock scenarios, ensuring we can
-	 * successfully reach scx_bypass().
-	 */
-	WRITE_ONCE(sch->aborting, true);
-
-	trace_sched_ext_exit(sch, kind);
+	if (kind == SCX_EXIT_PARENT) {
+		/* an ancestor is already sweeping the subtree */
+		WRITE_ONCE(sch->aborting, true);
+	} else {
+		struct scx_sched *pos;
 
-	/*
-	 * Propagate exits to descendants immediately. Each has a dedicated
-	 * helper kthread and can run in parallel. While most of disabling is
-	 * serialized, running them in separate threads allows parallelizing
-	 * ops.exit(), which can take arbitrarily long prolonging bypass mode.
-	 *
-	 * To guarantee forward progress, this propagation must be in-line so
-	 * that ->aborting is synchronously asserted for all sub-scheds. The
-	 * propagation is also the interlocking point against sub-sched
-	 * attachment. See scx_link_sched().
-	 *
-	 * This doesn't cause recursions as propagation only takes place for
-	 * non-propagation exits.
-	 */
-	if (kind != SCX_EXIT_PARENT) {
-		scoped_guard (raw_spinlock_irqsave, &scx_sched_lock) {
-			struct scx_sched *pos;
+		/*
+		 * CPUs may be live-locked in the dispatch paths of @sch or its
+		 * descendants, which ->aborting breaks. Sweep the subtree
+		 * locklessly so that this works from NMI. smp_store_mb() orders
+		 * each node's ->aborting store before its children are walked -
+		 * either we see a racing scx_link_sched() on ->children or it
+		 * sees ->aborting.
+		 */
+		scoped_guard (rcu) {
 			scx_for_each_descendant_pre(pos, sch)
-				scx_disable(pos, SCX_EXIT_PARENT);
+				smp_store_mb(pos->aborting, true);
 		}
+
+		irq_work_queue(&sch->propagate_exit_irq_work);
 	}
 
+	/* fired after ->aborting is set so callbacks can't delay recovery */
+	trace_sched_ext_exit(sch, kind);
+
 	return true;
 }
 
@@ -6738,7 +6763,11 @@ bool scx_vexit(struct scx_sched *sch,
 
 	ei->exit_code = exit_code;
 #ifdef CONFIG_STACKTRACE
-	if (kind >= SCX_EXIT_ERROR)
+	/*
+	 * stack_trace_save()'s NMI-safety is arch-dependent and undocumented.
+	 * Skip the backtrace when exiting from NMI.
+	 */
+	if (kind >= SCX_EXIT_ERROR && !in_nmi())
 		ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
 #endif
 	vscnprintf(ei->msg, SCX_EXIT_MSG_LEN, fmt, args);
@@ -6908,6 +6937,7 @@ struct scx_sched *scx_alloc_and_add_sche
 	sch->slice_dfl = SCX_SLICE_DFL;
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
 	sch->disable_irq_work = IRQ_WORK_INIT_HARD(scx_disable_irq_workfn);
+	sch->propagate_exit_irq_work = IRQ_WORK_INIT_HARD(scx_propagate_exit_irq_workfn);
 	kthread_init_work(&sch->disable_work, scx_disable_workfn);
 	timer_setup(&sch->bypass_lb_timer, scx_bypass_lb_timerfn, 0);
 
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1562,6 +1562,7 @@ struct scx_sched {
 	char			*cgrp_path;
 	struct kset		*sub_kset;
 
+	bool			linked;		/* on ->children, see scx_link_sched() */
 	bool			sub_attached;
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -1580,6 +1581,7 @@ struct scx_sched {
 	struct kthread_worker	*helper;
 	struct irq_work		disable_irq_work;
 	struct kthread_work	disable_work;
+	struct irq_work		propagate_exit_irq_work; /* see scx_claim_exit() */
 	struct timer_list	bypass_lb_timer;
 	cpumask_var_t		bypass_lb_donee_cpumask;
 	cpumask_var_t		bypass_lb_resched_cpumask;
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1064,12 +1064,14 @@ void scx_sub_disable(struct scx_sched *s
 	scx_cgroup_lock();
 
 	/*
-	 * An enable that failed before scx_link_sched() never owned a cgroup or
-	 * task and won't be waited on by an ancestor's drain_descendants().
-	 * Nothing to reparent and walking the tasks can misbehave as the task
-	 * ownership invariant (either owned by self or parent) does not hold.
+	 * An enable that failed before scx_link_sched() succeeded never owned a
+	 * cgroup or task and won't be waited on by an ancestor's
+	 * drain_descendants(). Nothing to reparent and walking the tasks can
+	 * misbehave as the task ownership invariant (either owned by self or
+	 * parent) does not hold. ->sibling can't identify this case - an undone
+	 * link leaves it non-empty.
 	 */
-	if (list_empty(&sch->sibling))
+	if (!sch->linked)
 		goto dump;
 
 	set_cgroup_sched(sch_cgroup(sch), parent);
