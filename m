Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBC3BBA0B;
	Sat, 17 Oct 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255561; cv=none; b=k+RI+JedTVSFMUCyZG6UmH+p8qbtm8dElkyNXvxnx90NZiQ1XN53/4Qc28Gg0+7hI1iX4xYeFWuupWOeGBA7SGHHSjBkX2+w/gUMz40cD6tkLOgw4sjBX8AmRY7zkF/LuT1nvOrQbxPAp9yB0gAk/cA4ViqN46tEtKjWfkeJbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255561; c=relaxed/simple;
	bh=kuCISZ/sWKYx+rG/SPmdJQJfaLh92+Q3UlvaOSe0LGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/NJyWVG/paE3ELLlVs03nbXo6nFh1Bdq6VQK7yK0NMhJIp4oKu/nd3s6O04OOkGAfGL9U+etWlSk84BYKj8besMg5GNrkXg6L4FT8dgNahNZulbjNLLvExGoYJ1EdNxjwVFciLlovue/Nyuu3x1S6cwS17Zr2lQnxUJ2KfsG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5gRrtH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5gRrtH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2621F000C4;
	Sat, 17 Oct 2026 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792255559;
	bh=sppnObLBkAFphsqh/UGu/wgn9L9kDt6iNx1n4Mk1Qe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B5gRrtH6wAIp7wES9uGoyU4b717W+ehEuM/5KHJ3u1fwINlA32phra9woHMIIV58d
	 han4bcHqTaW0B9LXfIVwIQJW8T+6dhUoZax9emN7xqg5BWRo1t1SspA9iLolKQ2N4q
	 kVvAQz5ingb2Pc0Ns4ODrfP+5hVdDVFMlFFzl703gX6tTUQJNKazMSRqOt/oPKSEHz
	 9BVLcZH3KsHXKXKW2jXYjA1/e3/9p1xkFz7fBhEgk61EWeFeb9jAC3BguDMcNQw4HC
	 IdGu4MhCVoHmFx2cLR52O9QHiX8FKBV0FFsgZijYvxrdAkDCMnb1EdQnYJNoQKw2Bt
	 kDwoA8VLvZyGQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] sched_ext: Free a sub-scheduler a grace period after discarding its ecaps syncs
Date: Sat, 17 Oct 2026 06:45:52 -1000
Message-ID: <20261017164556.4136807-3-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017164556.4136807-1-tj@kernel.org>
References: <20261017164556.4136807-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The free path removes a sub-scheduler's ecaps sync node from each cpu's list
and then cycles the rq lock until the node reads off-list, as a sync batch
can hold the node privately. Cycling the lock is correct only because the
sched is bypassing and a bypassing sched's sync calls no op, so the batch
touches the pcpu within one rq lock hold.

Tying the free path to what the sync does for a bypassing sched is unusual
and brittle, and it gets in the way of changing the sync. Delivering ecaps
to a bypassing sched or its parent would break the wait, as a delivery drops
the rq lock.

Wait for the batches with RCU instead, the usual way to wait for lockless
users before a free. Discard the nodes after the first grace period as
before, and free the sched after a second one. The first grace period waits
for the paths that found the sched before it was unlinked, such as the
sub-cap kfuncs and the cpu hotplug hooks. Until they finish, they can queue
its syncs, and a cpu can take a queued node into a sync batch that the first
grace period doesn't wait for. After it, nothing queues the syncs, and the
discards remove the nodes still queued.

A batch that took a node keeps irqs off from llist_del_all() to its last
pcpu write, even across the rq lock drops of a delivery. The second grace
period waits for it whether or not it called an op. The exit and disable
irq_works, the helper kthread and the bypass load balancing timer are
stopped ahead of the per-cpu checks as before, so they move into
scx_sched_quiesce_rcu_work() with the checks.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 76 ++++++++++++++++++++++++++++++------------
 kernel/sched/ext/sub.c | 51 +++++++++++-----------------
 2 files changed, 74 insertions(+), 53 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index a955403ba8e5..d28902dc48ff 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5983,10 +5983,6 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	struct scx_dispatch_q *dsq;
 	int cpu, node;
 
-	irq_work_sync(&sch->propagate_exit_irq_work);
-	irq_work_sync(&sch->disable_irq_work);
-	kthread_destroy_worker(sch->helper);
-	timer_shutdown_sync(&sch->bypass_lb_timer);
 	free_cpumask_var(sch->bypass_lb_donee_cpumask);
 	free_cpumask_var(sch->bypass_lb_resched_cpumask);
 	free_cpumask_var(sch->stall_cpus);
@@ -6004,22 +6000,6 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	for_each_possible_cpu(cpu) {
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
-		/*
-		 * $sch would have entered bypass mode before the RCU grace
-		 * period. As that blocks new deferrals, all
-		 * deferred_reenq_local_node's must be off-list by now.
-		 */
-		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
-
-		/* remove the queued ecaps sync so the pcpu can be freed */
-		scx_discard_ecaps_to_sync(cpu, pcpu);
-
-		/*
-		 * Bypass blocks new kicks. Flush the kick irq_work so this
-		 * pcpu's to_kick_node is off the list before it is freed.
-		 */
-		irq_work_sync(&cpu_rq(cpu)->scx.kick_cpus_irq_work);
-		WARN_ON_ONCE(!list_empty(&pcpu->to_kick_node));
 		free_cpumask_var(pcpu->cpus_to_kick);
 		free_cpumask_var(pcpu->cpus_to_kick_if_idle);
 		free_cpumask_var(pcpu->cpus_to_preempt);
@@ -6061,11 +6041,65 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	kfree(sch);
 }
 
+/**
+ * scx_sched_quiesce_rcu_work - Quiesce a sched and queue its free
+ * @work: &scx_sched.rcu_work
+ *
+ * $sch is freed after two RCU grace periods because of its ecaps sync nodes.
+ *
+ * The first grace period runs between scx_kobj_release() and this function. It
+ * waits for the paths that found $sch before scx_unlink_sched(), such as the
+ * sub-cap kfuncs and the cpu hotplug hooks. Until they finish, they can queue
+ * $sch's syncs, and a cpu can take a queued node into a sync batch. The first
+ * grace period doesn't wait for a batch that started after it began.
+ *
+ * Nothing queues $sch's syncs now. Remove the nodes still on the cpus' lists. A
+ * batch that took a node can still write $sch's pcpu, and a delivery in the
+ * batch can drop the rq lock before that write. The batch keeps irqs off from
+ * taking the node to its last pcpu write, so the second grace period waits for
+ * it before scx_sched_free_rcu_work() frees $sch.
+ */
+static void scx_sched_quiesce_rcu_work(struct work_struct *work)
+{
+	struct rcu_work *rcu_work = to_rcu_work(work);
+	struct scx_sched *sch = container_of(rcu_work, struct scx_sched, rcu_work);
+	s32 cpu;
+
+	irq_work_sync(&sch->propagate_exit_irq_work);
+	irq_work_sync(&sch->disable_irq_work);
+	kthread_destroy_worker(sch->helper);
+	timer_shutdown_sync(&sch->bypass_lb_timer);
+
+	for_each_possible_cpu(cpu) {
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
+		/*
+		 * $sch would have entered bypass mode before the first RCU
+		 * grace period. As that blocks new deferrals, all
+		 * deferred_reenq_local_node's must be off-list by now.
+		 */
+		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
+
+		/* remove the queued ecaps sync so the pcpu can be freed */
+		scx_discard_ecaps_to_sync(cpu, pcpu);
+
+		/*
+		 * Bypass blocks new kicks. Flush the kick irq_work so this
+		 * pcpu's to_kick_node is off the list before it is freed.
+		 */
+		irq_work_sync(&cpu_rq(cpu)->scx.kick_cpus_irq_work);
+		WARN_ON_ONCE(!list_empty(&pcpu->to_kick_node));
+	}
+
+	INIT_RCU_WORK(&sch->rcu_work, scx_sched_free_rcu_work);
+	queue_rcu_work(system_dfl_wq, &sch->rcu_work);
+}
+
 static void scx_kobj_release(struct kobject *kobj)
 {
 	struct scx_sched *sch = container_of(kobj, struct scx_sched, kobj);
 
-	INIT_RCU_WORK(&sch->rcu_work, scx_sched_free_rcu_work);
+	INIT_RCU_WORK(&sch->rcu_work, scx_sched_quiesce_rcu_work);
 	queue_rcu_work(system_dfl_wq, &sch->rcu_work);
 }
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 7edad2ddaa54..1923bdc33d6b 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1318,8 +1318,10 @@ static void clear_all_caps(struct scx_sched *sch)
 }
 
 /*
- * @pcpu's sched was unhashed before the grace period, so nothing re-queues its
- * sync node. Remove the node from @rq's pending list so the pcpu can be freed.
+ * Remove @pcpu's ecaps sync node from @cpu's pending list. The first grace
+ * period has passed, so nothing queues the node again. The second grace period
+ * waits for a sync batch that took the node earlier, see
+ * scx_sched_quiesce_rcu_work().
  */
 void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
 {
@@ -1327,43 +1329,28 @@ void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
 	struct llist_node *head = NULL, *tail = NULL;
 	struct llist_node *pos, *tmp;
 
+	guard(rq_lock_irqsave)(rq);
+
+	if (!llist_on_list(&pcpu->ecaps_to_sync_node))
+		return;
+
 	/*
 	 * llist can't unlink a single node. Take all queued nodes, drop @pcpu's
 	 * and resplice the rest. Nodes in the taken batch read as on-list
 	 * throughout, so queue_sync_ecaps() stays correct.
 	 */
-	if (llist_on_list(&pcpu->ecaps_to_sync_node)) {
-		scoped_guard (rq_lock_irqsave, rq) {
-			llist_for_each_safe(pos, tmp, llist_del_all(&rq->scx.ecaps_to_sync)) {
-				if (pos == &pcpu->ecaps_to_sync_node) {
-					init_llist_node(pos);
-				} else {
-					pos->next = head;
-					head = pos;
-					if (!tail)
-						tail = pos;
-				}
-			}
-			if (head)
-				llist_add_batch(head, tail, &rq->scx.ecaps_to_sync);
-		}
-	}
-
-	/*
-	 * An in-flight scx_process_sync_ecaps() batch may still hold the node
-	 * privately across dispatch-induced rq unlocks, reading as on-list.
-	 *
-	 * Because a bypassing sched gets no op call, init_llist_node() and all
-	 * @pcpu accesses share one contiguous lock hold, off-list under the rq
-	 * lock means @pcpu won't be accessed again.
-	 */
-	while (true) {
-		scoped_guard (rq_lock_irqsave, rq) {
-			if (!llist_on_list(&pcpu->ecaps_to_sync_node))
-				return;
+	llist_for_each_safe(pos, tmp, llist_del_all(&rq->scx.ecaps_to_sync)) {
+		if (pos == &pcpu->ecaps_to_sync_node) {
+			init_llist_node(pos);
+		} else {
+			pos->next = head;
+			head = pos;
+			if (!tail)
+				tail = pos;
 		}
-		cpu_relax();
 	}
+	if (head)
+		llist_add_batch(head, tail, &rq->scx.ecaps_to_sync);
 }
 
 /**
-- 
2.56.0

