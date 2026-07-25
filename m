Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1A255F28;
	Sat, 25 Jul 2026 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940622; cv=none; b=MG9W6feLQoxEIZUv+Ga8WVdKiEUUZJG4JZ3UyZf38hDCzIB69pHxxjW4xM5nKwnWRRBOXgjiLzzQZoqxjD+JLqPyTvY1qSFUJ58dvzaLfVFqYrvkg3AgwG6WkJxLLFkp+664GlvhO2Bxo7NSUZsod1lKIKdD3jiGX2YaN8WtnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940622; c=relaxed/simple;
	bh=61+mcpuB0AnwKl0JuzoJ2QTOQJmn/YXXP3oBW4Kd7RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acmzsd0xvV4QkQwntyohQEXPrgHVw3KO33REJF3oUbkFPnY03T1FW59rGwonFqoc6h0sDHME4vX91eIhc77N2W2Ho0TMX5zJU5lIzSY0ggO7nwT5G2V18OE8DQ6M0l/yAycp+xqljJDv67XeZAHyOdZh2rO1TD9h/QhAtjG7DBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBlNEGCF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBlNEGCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD2C1F00A3A;
	Sat, 25 Jul 2026 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784940621;
	bh=KgAZqPBIZwZxXqINvxmITxtRzui9EAtZHnHGsXpTJ1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eBlNEGCF3Y92BykFLPdixUPPRzXxb8ZNwL1Edz+ksOZ20hlNalPKTntZIUS0XDwnL
	 XDO+FFUpMAhqLkCVj1d9dlxMapckVpdk2ariQQOQJ5pQ7ofUxJzfQwb+6IzwrwFhcV
	 plrX5QMrI17vnD6xs323qjbYMvNVP0ViQ77RJLQxb22NUbkL9Ko3X0moCwRXWfBxym
	 sVNEw9oWJPvx7NLKG1a0q3fBRK52Jwa4rLAY9vT6hH9G7x4Vz7ALNciQewfohy8w7+
	 NPTCZys9rQ9bON3fYBbqfaVf0TQVjMxHEfTB+KkRSRrQbMYj3c0lUfTeZsB81uHxpf
	 T/u4465XAsDUg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] sched_ext: Make exit claiming lock-free
Date: Fri, 24 Jul 2026 14:50:15 -1000
Message-ID: <20260725005019.1297049-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725005019.1297049-1-tj@kernel.org>
References: <20260725005019.1297049-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

trace_sched_ext_exit can now fire from NMI. The exit backtrace is skipped
for NMI exits as stack_trace_save()'s NMI-safety is arch-dependent and
undocumented.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 107 +++++++++++++++++++++++-------------
 kernel/sched/ext/internal.h |   2 +
 kernel/sched/ext/sub.c      |  12 ++--
 3 files changed, 77 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index aca8d2380509..30ce4c9428cf 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5027,6 +5027,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	struct scx_dispatch_q *dsq;
 	int cpu, node;
 
+	irq_work_sync(&sch->propagate_exit_irq_work);
 	irq_work_sync(&sch->disable_irq_work);
 	kthread_destroy_worker(sch->helper);
 	timer_shutdown_sync(&sch->bypass_lb_timer);
@@ -5993,18 +5994,6 @@ s32 scx_link_sched(struct scx_sched *sch)
 		struct scx_sched *parent = scx_parent(sch);
 
 		if (parent) {
-			/*
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
 			/*
 			 * Bypass state is spread across per-cpu flags and a
 			 * depth count, so inheriting it is tricky and has no
@@ -6024,6 +6013,23 @@ s32 scx_link_sched(struct scx_sched *sch)
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
 
@@ -6047,10 +6053,11 @@ void scx_unlink_sched(struct scx_sched *sch)
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
@@ -6260,12 +6267,36 @@ static void scx_root_disable(struct scx_sched *sch)
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
@@ -6279,35 +6310,28 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
 		return false;
 
-	/*
-	 * Some CPUs may be trapped in the dispatch paths. Set the aborting
-	 * flag to break potential live-lock scenarios, ensuring we can
-	 * successfully reach scx_bypass().
-	 */
-	WRITE_ONCE(sch->aborting, true);
-
 	trace_sched_ext_exit(sch, kind);
 
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
+	if (kind == SCX_EXIT_PARENT) {
+		/* an ancestor is already sweeping the subtree */
+		WRITE_ONCE(sch->aborting, true);
+	} else {
+		struct scx_sched *pos;
+
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
 
 	return true;
@@ -6738,7 +6762,11 @@ bool scx_vexit(struct scx_sched *sch,
 
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
@@ -6908,6 +6936,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 	sch->slice_dfl = SCX_SLICE_DFL;
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
 	sch->disable_irq_work = IRQ_WORK_INIT_HARD(scx_disable_irq_workfn);
+	sch->propagate_exit_irq_work = IRQ_WORK_INIT_HARD(scx_propagate_exit_irq_workfn);
 	kthread_init_work(&sch->disable_work, scx_disable_workfn);
 	timer_setup(&sch->bypass_lb_timer, scx_bypass_lb_timerfn, 0);
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 886f1d132e6b..4b07f82bef40 100644
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
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 6da6c91e4287..76ff58de54e7 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1064,12 +1064,14 @@ void scx_sub_disable(struct scx_sched *sch)
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
+	 * parent) does not hold. ->sibling can't discriminate this - an undone
+	 * link leaves it non-empty.
 	 */
-	if (list_empty(&sch->sibling))
+	if (!sch->linked)
 		goto dump;
 
 	set_cgroup_sched(sch_cgroup(sch), parent);
-- 
2.55.0

