Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684D3CAE84;
	Sat, 17 Oct 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255564; cv=none; b=gxfrGcP1o947o6xIV4dAyG9qVl6ZHjS8uikllLXJQqeCgovhB2VamAncgP2FWjLUf0Ml8ASEv3NKA8ePLxbHHd1Uv+cZqgt4OQ5MlKUkG4+xjPqlJPihrhqck9CUbxB9RyC2rwSYmDgECkr595lGfde+/WClvlQq7V27mMI36ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255564; c=relaxed/simple;
	bh=w7bcQloez+ZE0CgIxkXuh6oviRJU/7+VkgcdZsOHGDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc8NI4BE0MBiaInQ1AcGjZDmzl1m9zdTTtN5SfpShmv1ieALAwfYIfSzcZEBoNdUgtk+wpTGrLHk94c79fleCXvWyo59AoYy0d/+ZsomBLATiOeHWbTgsD3dbsNDi8Z8nu7EbTWlmpOfQRynieItsPAHjxPGnn/ve6yXWKpMfpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm69jjox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm69jjox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732B61F000C6;
	Sat, 17 Oct 2026 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792255562;
	bh=8OMZEJJenXk7Dsgkgm/gRlYuRUgBq43LroLFLSCpmUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fm69jjoxNcPXL2ADD2BIJ9LrYi3J7UXobiBdLbxWexyGKefnZ+KHA0aMwleUcb9R0
	 cx02TegegHW/QqodrgOh4tvd6lajhDR7s8N8RUqb75DBjsaB6r/CQgg60+lYIaoFoW
	 sB4f6bUhpQioipJo9qR78nzi0InYBIXjCY6/b6i/YdS7U32mx/L7VGlTlmmbYHpT0M
	 v3YLqA2B1RHtSN4GcYUhradEYQ2dgrOh7xNRyyRJEA6rBLxtojfz36x1jkLcUstAHc
	 Gz63mI0Bv+/u2YgcjbfwXSBnuXR4bTXCJYiGCBM4XzywBMOr0n7SZORK3ks55k5Ywe
	 MPO3vh3t4siBA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] sched_ext: Report the ecaps loss when a cpu goes offline
Date: Sat, 17 Oct 2026 06:45:55 -1000
Message-ID: <20261017164556.4136807-6-tj@kernel.org>
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

When a cpu goes offline, a sub-scheduler's effective caps on its cid are
cleared, but neither the sub-scheduler nor its parent is notified. The
sub-scheduler keeps treating the cid as usable, and the parent can't act on
the loss, e.g. reset the cpuperf target.

Report the loss before the root's ops.cpu_offline() and the regain after its
ops.cpu_online(). The zeroing at offline was the last change to a sched's
ecaps outside a delivery, so they now change only with one, and syncs on an
inactive cpu are processed instead of discarded. Suspend and hibernation now
report their cpu downs and ups as well. This is temporary, and a later patch
leaves them out.

Two things need care. A cpu going down marks a sync for each sub-scheduler,
and its hotplug thread waits until each marked sync has been processed. The
cpu's own ext picks process them, and the ext server is started in case a
fair task holds the cpu. Only the marked syncs count, so a flood of changes
on the cid can't hold up the hotplug.

The detach report reaches only active cpus. It holds off cpu hotplug, so a
cpu it skips has reported its loss as it went down, and no unreported loss
is left to drop.

Drop the cpuperf reset from scx_qmap's ops.sub_detach(), as its
ops.sub_child_ecaps_updated() now resets the targets on the loss reports.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/internal.h    |  22 ++--
 kernel/sched/ext/sub.c         | 232 ++++++++++++++++++++-------------
 kernel/sched/sched.h           |   1 +
 tools/sched_ext/scx_qmap.bpf.c |  25 +---
 4 files changed, 160 insertions(+), 120 deletions(-)

diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index d03180f91ea6..0d20661fa4eb 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -927,9 +927,14 @@ struct sched_ext_ops {
 	 * the bypass DSQs, where this op can't insert or move them. Deliveries
 	 * stop once this sched is being disabled.
 	 *
+	 * Until this sched is being disabled, whenever an op of this sched runs
+	 * under a cid's rq lock, its effective caps on the cid are the @after
+	 * of the last invocation for the cid.
+	 *
 	 * Deliveries for a cid happen only while the root considers the cid's
 	 * cpu online, never before the root's ops.cpu_online() or after its
-	 * ops.cpu_offline() for the cpu.
+	 * ops.cpu_offline() for the cpu. A cpu going offline reports the loss
+	 * of every cap on it, and a cpu coming back reports the regain.
 	 */
 	void (*sub_ecaps_updated)(s32 cid, u64 before, u64 after);
 
@@ -960,12 +965,14 @@ struct sched_ext_ops {
 	 * change is in effect on the cpu. From here on the parent can act on a
 	 * cap the child lost, e.g. reset the cpuperf target or schedule on the
 	 * cid. A disabling child gets no ops.sub_ecaps_updated(), so only this
-	 * op is invoked for its loss. A cpu going offline drops caps without a
-	 * report.
+	 * op is invoked for its loss. On a cpu going offline, a parent other
+	 * than the root loses its own caps on the cid too, possibly before this
+	 * op is invoked. If so, it can't act on the cid when this op runs.
 	 *
 	 * Deliveries start as for the child's ops.sub_ecaps_updated(), continue
 	 * while either sched bypasses and stop once this sched is being
-	 * disabled.
+	 * disabled. A cpu going offline or coming back is reported as for the
+	 * child's ops.sub_ecaps_updated().
 	 *
 	 * Runs in dispatch context with rq lock held, and can perform all
 	 * operations allowed in ops.dispatch() including inserting/moving
@@ -1441,6 +1448,8 @@ enum scx_sched_pcpu_flags {
 	SCX_SCHED_PCPU_ECAPS_ENABLED	= 1LLU << 1,
 	/* a report is pending, see ecaps_report() */
 	SCX_SCHED_PCPU_ECAPS_REPORT	= 1LLU << 2,
+	/* a cpu going down waits for this sync, see scx_offline_ecaps() */
+	SCX_SCHED_PCPU_ECAPS_OFFLINE	= 1LLU << 3,
 };
 
 /* dispatch buf */
@@ -1511,11 +1520,6 @@ struct scx_sched_pcpu {
 	 * under pshard->lock.
 	 */
 	bool			had_caps;
-	/*
-	 * ecaps as of the last sub_ecaps_updated() and
-	 * sub_child_ecaps_updated() delivery. See __scx_process_sync_ecaps().
-	 */
-	u64			reported_ecaps;
 
 	/*
 	 * Decaying rescue runtime consumed on this cpu, see
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 5fb4a4a06422..5395d6f2a17b 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -52,6 +52,9 @@ static unsigned long scx_rescue_overload_after;
  */
 static struct rcuwait ecaps_report_wait = __RCUWAIT_INITIALIZER(ecaps_report_wait);
 
+/* a cpu going down waits here for its marked syncs, see scx_offline_ecaps() */
+static DECLARE_WAIT_QUEUE_HEAD(ecaps_offline_waitq);
+
 /**
  * scx_skip_subtree_pre - Skip @pos's subtree in a pre-order walk
  * @pos: current position
@@ -1040,8 +1043,8 @@ static u64 calc_effective_caps(struct scx_pshard *ps, s32 cid)
  * @sch: sched to update
  * @cid: cid to update
  *
- * Queue an ecaps update for @sch's @cid and kick the cpu so that it syncs in
- * dispatch_one().
+ * Queue an ecaps update for @sch's @cid and kick the cpu, if active, so that it
+ * syncs in dispatch_one().
  */
 static void queue_sync_ecaps(struct scx_sched *sch, s32 cid)
 {
@@ -1049,28 +1052,26 @@ static void queue_sync_ecaps(struct scx_sched *sch, s32 cid)
 	struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
 	/*
-	 * Pairs with smp_mb() in __scx_process_sync_ecaps(). Either the check
-	 * below sees the node off the list and queues it, or the in-flight sync
-	 * sees the caps[] update made before this call.
+	 * Pairs with smp_mb() in __scx_process_sync_ecaps(). The caller has
+	 * written the state a sync reads, caps[] or cpu_active(). Either the
+	 * check below finds the node off the list and queues a sync, or a sync
+	 * in flight is still ahead of its reads and sees the new state.
 	 */
 	smp_mb();
 
 	/* @cid's pshard->lock excludes concurrent queueing attempts */
 	if (llist_on_list(&pcpu->ecaps_to_sync_node))
 		return;
-	if (llist_add(&pcpu->ecaps_to_sync_node, &cpu_rq(cpu)->scx.ecaps_to_sync))
-		scx_kick_cpu(sch->ancestors[0], cpu, 0);
-}
-
-/* discard @rq's queued ecaps syncs */
-static void discard_queued_syncs(struct rq *rq)
-{
-	struct llist_node *pos, *tmp;
-
-	lockdep_assert_rq_held(rq);
 
-	llist_for_each_safe(pos, tmp, llist_del_all(&rq->scx.ecaps_to_sync))
-		init_llist_node(pos);
+	/*
+	 * A cpu going down processes its syncs while its hotplug thread waits
+	 * in scx_offline_ecaps(). That function reschedules the cpu itself, and
+	 * a kick for every change on the cid would only keep preempting the
+	 * hotplug thread. Don't kick an inactive cpu.
+	 */
+	if (llist_add(&pcpu->ecaps_to_sync_node, &cpu_rq(cpu)->scx.ecaps_to_sync) &&
+	    cpu_active(cpu))
+		scx_kick_cpu(sch->ancestors[0], cpu, 0);
 }
 
 /* the pshard holding @sch's caps on @cid */
@@ -1097,6 +1098,29 @@ static void ecaps_report_done(struct scx_sched_pcpu *pcpu)
 		irq_work_queue(&ecaps_report_irq_work);
 }
 
+static void ecaps_offline_irq_workfn(struct irq_work *irq_work)
+{
+	wake_up(&ecaps_offline_waitq);
+}
+
+static DEFINE_IRQ_WORK(ecaps_offline_irq_work, ecaps_offline_irq_workfn);
+
+/*
+ * @pcpu's sync marked by scx_offline_ecaps() has been processed or discarded.
+ * The waiter can't be woken under the rq lock, so the last completion wakes it
+ * through irq_work. The marks are all done before the cpu reaches
+ * __cpu_disable(), past which a queued irq_work would never run.
+ */
+static void ecaps_offline_done(struct rq *rq, struct scx_sched_pcpu *pcpu)
+{
+	lockdep_assert_rq_held(rq);
+
+	pcpu->flags &= ~SCX_SCHED_PCPU_ECAPS_OFFLINE;
+	WRITE_ONCE(rq->scx.nr_ecaps_offline, rq->scx.nr_ecaps_offline - 1);
+	if (!rq->scx.nr_ecaps_offline)
+		irq_work_queue(&ecaps_offline_irq_work);
+}
+
 /**
  * __scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
  * @rq: the cid's cpu rq
@@ -1105,6 +1129,11 @@ static void ecaps_report_done(struct scx_sched_pcpu *pcpu)
  * pshard->caps[] is the target configuration. pcpu->ecaps is the effective
  * transposed copy owned by the cid's cpu and written under @rq's lock.
  *
+ * A sched's ecaps change only with a delivery, so that whenever an op of the
+ * sched runs under @rq's lock, its ecaps are what its deliveries reported. A
+ * sync that can't deliver leaves them alone, and a later one that can reports
+ * the net change.
+ *
  * A sched that newly gains baseline access here is owed an update_idle() so it
  * learns the cid's idle state. Such a gain arms the per-rq
  * %SCX_RQ_SUB_IDLE_RENOTIFY gate so the next idle pick delivers it.
@@ -1119,20 +1148,7 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 	if (likely(llist_empty(&rq->scx.ecaps_to_sync)))
 		return;
 
-	/*
-	 * ecaps are zeroed while the cpu is inactive and must stay zero.
-	 * Discard queued syncs instead of processing them - the
-	 * scx_online_ecaps() reseed re-syncs every sched on activation.
-	 * cpu_active() clears before the offline zeroing and sets before the
-	 * reseed is queued, so this test can neither miss a racing sync nor
-	 * eat the reseed.
-	 */
-	if (unlikely(!cpu_active(cpu))) {
-		discard_queued_syncs(rq);
-		return;
-	}
-
-	/* @cid is valid here: the cpu is active with queued syncs */
+	/* @cid stays valid while a root is enabled */
 	cid = __scx_cpu_to_cid(cpu);
 
 	batch = llist_del_all(&rq->scx.ecaps_to_sync);
@@ -1141,6 +1157,7 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 			container_of(pos, struct scx_sched_pcpu, ecaps_to_sync_node);
 		struct scx_pshard *ps = cid_pshard(pcpu->sch, cid);
 		bool report = pcpu->flags & SCX_SCHED_PCPU_ECAPS_REPORT;
+		bool offline = pcpu->flags & SCX_SCHED_PCPU_ECAPS_OFFLINE;
 		u64 old, ecaps, lost, gained;
 
 		init_llist_node(pos);
@@ -1155,6 +1172,10 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		 * set. Deliveries also need the cpu online to the root, see
 		 * handle_hotplug().
 		 *
+		 * An inactive cpu that can deliver is going down and reads as
+		 * capless. A delivery below can drop the rq lock and the cpu's
+		 * active state can change between syncs, so test it per sync.
+		 *
 		 * A sync that can't deliver leaves the ecaps alone. It may
 		 * still carry a mark that is cleared below. Don't skip the rest
 		 * of the loop for it.
@@ -1163,8 +1184,10 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		if (!(pcpu->flags & SCX_SCHED_PCPU_ECAPS_ENABLED) ||
 		    !(rq->scx.flags & SCX_RQ_OPS_ONLINE))
 			ecaps = old;
-		else
+		else if (cpu_active(cpu))
 			ecaps = calc_effective_caps(ps, cid);
+		else
+			ecaps = 0;
 		WRITE_ONCE(pcpu->ecaps, ecaps);
 
 		lost = old & ~ecaps;
@@ -1181,13 +1204,8 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		 * scheduling can differ from @rq's cpu, so the context is set
 		 * up there. The rq recorded in it keeps the dispatches
 		 * targeting @rq.
-		 *
-		 * Both report the same before value, so one reported_ecaps
-		 * covers them.
 		 */
-		if (ecaps != pcpu->reported_ecaps &&
-		    (pcpu->flags & SCX_SCHED_PCPU_ECAPS_ENABLED) &&
-		    (rq->scx.flags & SCX_RQ_OPS_ONLINE)) {
+		if (ecaps != old) {
 			struct scx_sched *parent = scx_parent(pcpu->sch);
 			struct scx_dsp_ctx *dspc;
 
@@ -1200,7 +1218,7 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 				dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
 				dspc->rq = rq;
 				SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq,
-					    scx_cpu_arg(cpu), pcpu->reported_ecaps, ecaps);
+					    scx_cpu_arg(cpu), old, ecaps);
 				scx_flush_dispatch_buf(pcpu->sch, rq);
 			}
 			if (SCX_HAS_OP(parent, sub_child_ecaps_updated) &&
@@ -1209,15 +1227,16 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 				dspc->rq = rq;
 				SCX_CALL_OP(parent, sub_child_ecaps_updated, rq,
 					    pcpu->sch->ops.sub_cgroup_id, scx_cpu_arg(cpu),
-					    pcpu->reported_ecaps, ecaps);
+					    old, ecaps);
 				scx_flush_dispatch_buf(parent, rq);
 			}
 			rq->scx.sub_dispatch_prev = NULL;
-			pcpu->reported_ecaps = ecaps;
 		}
 
 		if (report)
 			ecaps_report_done(pcpu);
+		if (offline)
+			ecaps_offline_done(rq, pcpu);
 
 		/*
 		 * Gaining baseline access owes an update_idle() so the sched
@@ -1263,11 +1282,26 @@ void scx_init_rq_ops_online(void)
 	}
 }
 
+/*
+ * Make @rq's cpu dispatch through the ext class to process its ecaps syncs. A
+ * kick is dropped while the root bypasses, e.g. for PM, and an inactive cpu
+ * isn't kicked, so reschedule directly. A fair task can hold the cpu, so also
+ * start the ext server, which picks the ext class within its period.
+ */
+static void resched_sync_ecaps(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+
+	update_rq_clock(rq);
+	dl_server_start(&rq->ext_server);
+	resched_curr(rq);
+}
+
 /*
  * A cpu came back and the root's ops.cpu_online() has run. Let the cpu deliver
  * ecaps again and reseed each sub-sched's ecaps on its cid. The sync recomputes
- * effective caps from the pshard and fires ops.sub_ecaps_updated() only on a
- * real change since offline.
+ * effective caps from the pshard and reports any change since the last
+ * delivery.
  */
 void scx_online_ecaps(struct rq *rq)
 {
@@ -1301,40 +1335,69 @@ void scx_online_ecaps(struct rq *rq)
 		guard(raw_spinlock)(&ps->lock);
 		queue_sync_ecaps(pos, cid);
 	}
+
+	resched_sync_ecaps(rq);
 }
 
 /*
- * A cpu is going down, and the root's ops.cpu_offline() follows. Stop the cpu's
- * ecaps deliveries and zero each sub-sched's in-effect ecaps so cap checks
- * treat the cpu as capless while offline. Pending and late-queued syncs are
- * discarded at consumption by scx_process_sync_ecaps() while the cpu is
- * inactive. Leave reported_ecaps. Ownership is unchanged, so the
- * scx_online_ecaps() reseed reports only a genuine delta. No callback fires
- * here.
+ * A cpu is going down, and the root's ops.cpu_offline() follows. Queue a marked
+ * sync for each sub-sched to report the loss and wait until each has been
+ * processed. Then stop the cpu's ecaps deliveries, so that none comes after
+ * ops.cpu_offline().
+ *
+ * This runs on the cpu's hotplug thread. While it sleeps, the cpu keeps
+ * scheduling, and a pick through the ext class processes the syncs, see
+ * resched_sync_ecaps(). Only the marked syncs count, so a flood of changes on
+ * the cid can't hold up the hotplug. After the wait, every sub-sched's ecaps on
+ * the cpu are zero, and the later syncs have nothing to deliver.
  */
 void scx_offline_ecaps(struct rq *rq)
 {
 	s32 cpu = cpu_of(rq);
 	struct scx_sched *root, *pos;
+	u32 nr = 0;
+	s32 cid;
 
-	guard(rq_lock_irqsave)(rq);
+	/*
+	 * ecaps and the tables need a live root, see scx_online_ecaps(). The
+	 * ext class isn't picked without one, so the syncs wouldn't be
+	 * processed and the wait would never end. scx_enabled() can't change
+	 * during hotplug.
+	 */
+	if (scx_enabled()) {
+		scoped_guard (rq_lock_irqsave, rq) {
+			root = scx_root_protected();
+			cid = __scx_cpu_to_cid(cpu);
 
-	root = scx_root_protected();
+			scx_for_each_descendant_pre(pos, root) {
+				struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
+				struct scx_pshard *ps;
 
-	scx_for_each_descendant_pre(pos, root) {
-		struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
+				/* root holds every cap and never uses ecaps */
+				if (!pos->level)
+					continue;
 
-		/* root holds every cap and never uses ecaps */
-		if (!pos->level)
-			continue;
+				/*
+				 * A batch that has yet to reach the sync sees
+				 * the mark. A sync already being processed has
+				 * left the list and is queued again below.
+				 */
+				pcpu->flags |= SCX_SCHED_PCPU_ECAPS_OFFLINE;
+				nr++;
+
+				ps = cid_pshard(pos, cid);
+				guard(raw_spinlock)(&ps->lock);
+				queue_sync_ecaps(pos, cid);
+			}
 
-		WRITE_ONCE(pcpu->ecaps, 0);
+			WRITE_ONCE(rq->scx.nr_ecaps_offline, nr);
+			resched_sync_ecaps(rq);
+		}
 
-		/* deliveries have stopped on this cpu, clear its mark */
-		if (pcpu->flags & SCX_SCHED_PCPU_ECAPS_REPORT)
-			ecaps_report_done(pcpu);
+		wait_event(ecaps_offline_waitq, !READ_ONCE(rq->scx.nr_ecaps_offline));
 	}
 
+	guard(rq_lock_irqsave)(rq);
 	rq->scx.flags &= ~SCX_RQ_OPS_ONLINE;
 }
 
@@ -1345,7 +1408,7 @@ void scx_offline_ecaps(struct rq *rq)
  */
 static void clear_all_caps(struct scx_sched *sch)
 {
-	s32 si, cpu;
+	s32 si;
 	u32 cap_bit;
 
 	lockdep_assert_cpus_held();
@@ -1361,16 +1424,6 @@ static void clear_all_caps(struct scx_sched *sch)
 		for (cap_bit = 0; cap_bit < __SCX_NR_CAPS; cap_bit++)
 			scx_cmask_clear(&ps->caps[cap_bit].cmask);
 	}
-
-	for_each_possible_cpu(cpu) {
-		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
-
-		guard(rq_lock_irqsave)(cpu_rq(cpu));
-
-		/* drop an unreported loss, as the report skips inactive cpus */
-		if (!cpu_active(cpu))
-			pcpu->reported_ecaps = 0;
-	}
 }
 
 /*
@@ -1401,6 +1454,9 @@ void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
 	llist_for_each_safe(pos, tmp, llist_del_all(&rq->scx.ecaps_to_sync)) {
 		if (pos == &pcpu->ecaps_to_sync_node) {
 			init_llist_node(pos);
+			/* a cpu going down may be waiting for the sync */
+			if (pcpu->flags & SCX_SCHED_PCPU_ECAPS_OFFLINE)
+				ecaps_offline_done(rq, pcpu);
 		} else {
 			pos->next = head;
 			head = pos;
@@ -1428,9 +1484,11 @@ void scx_discard_stale_ecaps_syncs(void)
 
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
+		struct llist_node *pos, *tmp;
 
 		guard(rq_lock_irqsave)(rq);
-		discard_queued_syncs(rq);
+		llist_for_each_safe(pos, tmp, llist_del_all(&rq->scx.ecaps_to_sync))
+			init_llist_node(pos);
 	}
 }
 
@@ -1736,8 +1794,14 @@ static void ecaps_enable(struct scx_sched *sch)
  * @sch: sub-scheduler to report
  *
  * Mark every cpu @sch was ever granted a cap on, deliver its pending change
- * through the dispatch path and wait for it. An inactive cpu is skipped. A cpu
- * going down meanwhile has its mark cleared by scx_offline_ecaps().
+ * through the dispatch path and wait for it. An inactive cpu is skipped. It may
+ * already be offline, where the mark would never be processed and the wait
+ * would never end. On attach, the reseed at its activation reports its caps. On
+ * detach, its loss was reported as it went down.
+ *
+ * If a marked cpu goes down meanwhile, it clears the mark while still online,
+ * as ecaps_report_irq_work would never run on an offline cpu. A cpu going down
+ * waits for the marked sync in scx_offline_ecaps().
  *
  * Called with scx_enable_mutex held. A sched's attach and detach reports must
  * not overlap, as the mark is one bit per pcpu.
@@ -1756,7 +1820,6 @@ static void ecaps_report(struct scx_sched *sch)
 
 		guard(rq_lock_irqsave)(rq);
 
-		/* syncs on an inactive cpu are discarded */
 		if (!cpu_active(cpu))
 			continue;
 
@@ -1770,16 +1833,7 @@ static void ecaps_report(struct scx_sched *sch)
 		pcpu->flags |= SCX_SCHED_PCPU_ECAPS_REPORT;
 		atomic_inc(&sch->nr_ecaps_reports);
 		queue_sync_ecaps(sch, cid);
-
-		/*
-		 * The report needs an ext dispatch on this cpu. A kick is
-		 * dropped while the root bypasses, e.g. for PM, so reschedule
-		 * directly. A fair task can hold the cpu, so also start the ext
-		 * server, which picks the ext class within its period.
-		 */
-		update_rq_clock(rq);
-		dl_server_start(&rq->ext_server);
-		resched_curr(rq);
+		resched_sync_ecaps(rq);
 	}
 
 	rcuwait_wait_event(&ecaps_report_wait, !atomic_read(&sch->nr_ecaps_reports),
@@ -1811,9 +1865,9 @@ void scx_sub_disable(struct scx_sched *sch)
 	/*
 	 * Clear @sch's caps and report the loss before any task goes back to
 	 * the parent. A disabling sched is granted nothing, so the caps stay
-	 * cleared. Hold off cpu hotplug across both. The report covers every
-	 * active cpu and the clear drops the unreported loss on the rest, so
-	 * that no loss reaches the parent after ops.sub_detach().
+	 * cleared. Hold off cpu hotplug across both so that a cpu the report
+	 * skips has finished going down. Its loss was reported as it went down,
+	 * see scx_offline_ecaps().
 	 *
 	 * An enable that failed before its attach report has nothing to report.
 	 * If it failed before scx_link_sched(), the root's disable doesn't wait
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c6f1f178e368..11fef351a112 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -844,6 +844,7 @@ struct scx_rq {
 	/* sched of the open running session, see scx_cid_sched_update() */
 	struct scx_sched	*sched;
 	struct llist_head	ecaps_to_sync;		/* pending ecaps syncs */
+	u32			nr_ecaps_offline;	/* marked syncs a down waits for */
 	struct task_struct	*sub_dispatch_prev;
 #endif
 	cpumask_var_t		cpus_to_sync;
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 61143a2d79f8..96de4bc02569 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -2168,35 +2168,16 @@ s32 BPF_STRUCT_OPS(qmap_sub_attach, struct scx_sub_attach_args *args)
 void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_detach_args *args)
 {
 	u64 cgid = args->ops->sub_cgroup_id;
-	s32 nr_cids = qa.nr_cids;
-	s32 pos = qa.part.rr_pos;
-	u64 holder_cgid;
-	bool reset_pool;
-	s32 i, cid;
-
-	if (nr_cids < 0 || nr_cids > SCX_QMAP_MAX_CPUS || pos < 0 || pos >= MAX_PARTS) {
-		scx_bpf_error("-ERANGE");
-		return;
-	}
+	s32 i;
 
 	/*
-	 * The child's caps are gone without a report, see ops.sub_detach().
-	 * cpuperf targets persist until the next write. Reset the child's excl
-	 * cids, and the pool unless another child holds it: that child's revoke
-	 * report or its own detach resets it then.
+	 * qmap_sub_child_ecaps_updated() has reset the cpuperf targets on the
+	 * loss reports.
 	 */
-	holder_cgid = qa.part.rr_slots[pos];
-	reset_pool = !holder_cgid || holder_cgid == cgid;
-
 	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
 		if (qa.sub_sched_ctxs[i].cgroup_id != cgid)
 			continue;
 
-		bpf_arena_for(cid, 0, nr_cids)
-			if (cmask_test(cid, &qa.sub_sched_ctxs[i].granted_cids.mask) ||
-			    (reset_pool && cmask_test(cid, &qa.rr_cids.mask)))
-				scx_bpf_cidperf_set(cid, SCX_CPUPERF_ONE);
-
 		qa.sub_sched_ctxs[i].cgroup_id = 0;
 		qa.sub_sched_ctxs[i].weight = 100;
 		cmask_init(&qa.sub_sched_ctxs[i].granted_cids.mask, 0, qa.nr_cids);
-- 
2.56.0

