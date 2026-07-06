Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4F37F8C0;
	Mon,  6 Jul 2026 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302084; cv=none; b=ml7wfxkTF96Ba4TGQyDxtqrDsiWEOm/XVExIGmZtVwAK4CgaV433vTUi9+TX31mUTArEupUXR2678VGmDu0o5ZHua4KZ5KURBiwv1JzY8slQiRz/6t3XCfotn7BdtInfSlvly+ZaRWnQtVPlRXXJhQC8X00RoCvEHoHi6tzZWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302084; c=relaxed/simple;
	bh=vQND435Ok+o8NcFa0Rk123AkcRKmzSaL6czhS5fOgDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erZgHv31VcE5FB5vvLXQ6cZywTCdFPR5R/cyQLjMiIV6HLH0qoM7qakMt8Od6GqCyITkR2D0wab3EKP15/q2m8kx+Kh35kqZDbXhun5VykHHcMWiGyKI4lIkr8xJUJiFkEu/4yQOCVo+KUi7Tq1jyF+dxG4GR8yrkgFbCSkMLy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/okvvus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/okvvus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BAA1F00A3E;
	Mon,  6 Jul 2026 01:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302081;
	bh=w2VfFHiIQuWfYr4F2qmnz+Lc3GZDZul6oP1niNPl614=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/okvvusJOQnJf8pFr6qE8bK7sc3M/hb0ed32WvsQBhMwN3Gb2MpajLg8JfWb/edk
	 D67jkGzD0talQSsME8RH7DJoVH/z/q/msfzFGdi1/Ra1ToBB5M872NfbW4FKes61+G
	 Tl7EjjGzgvmFQLLB8WArUAd3qGuEOqpIYi+4GP+2bIoLKKpGiGWMjD119979w08W1s
	 rggfuOjwf4dZvHTVvqRXWZUr1Np8TsZLnOngAgmL7xNC/66NuYQTJmDpPksGhwGpa3
	 o4lHJmUKEI5+R0CWQsob4n1mZ7eyuNUow3IULi0ueLhqaN3cWTQEMhQjcP25yK5VLe
	 9PyhS+XBu7ogQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 22/36] sched_ext: Add sub_ecaps_updated() effective-cap change notifier
Date: Sun,  5 Jul 2026 15:40:44 -1000
Message-ID: <20260706014058.439853-23-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sub-scheduler that gains or loses effective caps on a cpu may want to act
on it right away - e.g. place or preempt on a newly usable cpu. The existing
ops.sub_caps_updated() doesn't fit as it is delivered asynchronously to
scheduling operations and can arrive before the per-cpu effective caps go
live.

Add ops.sub_ecaps_updated(cid, before, after), a cid-form callback fired
from scx_process_sync_ecaps() when a sub-sched's effective caps on a cid
change. It runs in dispatch context so the sched can insert, kick or preempt
on the cid directly. @before is the caps as of the last delivery.

Cpu hotplug rides the same machinery. Going down zeroes each sched's ecaps
on the cpu's cid, with queued syncs discarded at consumption while the cpu
is inactive. Coming back up queues a sync for every sched. reported_ecaps is
kept across the down/up cycle, so the resync fires the callback only if
ownership actually changed while the cpu was down.

v2: Compute cid below the active-cpu guard; discard queued syncs on !cpu_active(). (sashiko AI)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  13 +++-
 kernel/sched/ext/internal.h |  19 +++++-
 kernel/sched/ext/sub.c      | 129 +++++++++++++++++++++++++++++++++---
 kernel/sched/ext/sub.h      |   8 ++-
 4 files changed, 154 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 6f8841b5b925..6d363a784308 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2595,7 +2595,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	rq->scx.flags |= SCX_RQ_IN_BALANCE;
 	rq->scx.flags &= ~SCX_RQ_BAL_KEEP;
 
-	scx_process_sync_ecaps(rq);
+	scx_process_sync_ecaps(rq, prev);
 
 	if ((sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
 	    unlikely(rq->scx.cpu_released)) {
@@ -3120,6 +3120,11 @@ static void handle_hotplug(struct rq *rq, bool online)
 	if (scx_enabled())
 		scx_idle_update_selcpu_topology(&sch->ops);
 
+	if (online)
+		scx_online_ecaps(rq);
+	else
+		scx_offline_ecaps(rq);
+
 	if (online && SCX_HAS_OP(sch, cpu_online))
 		SCX_CALL_OP(sch, cpu_online, NULL, scx_cpu_arg(cpu));
 	else if (!online && SCX_HAS_OP(sch, cpu_offline))
@@ -4629,7 +4634,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		 */
 		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
 
-		/* flush the queued ecaps syncs */
+		/* retire the queued ecaps syncs so the pcpu can be freed */
 		scx_discard_ecaps_to_sync(cpu, pcpu);
 
 		/*
@@ -7481,6 +7486,7 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
 static void sched_ext_ops_cid__set_cmask(struct task_struct *p,
 					 const struct scx_cmask *cmask) {}
 static void sched_ext_ops__sub_caps_updated(const struct scx_cmask *cmask, u64 caps) {}
+static void sched_ext_ops__sub_ecaps_updated(s32 cid, u64 before, u64 after) {}
 
 static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
 	.select_cid		= sched_ext_ops__select_cpu,
@@ -7514,6 +7520,7 @@ static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
 	.sub_attach		= sched_ext_ops__sub_attach,
 	.sub_detach		= sched_ext_ops__sub_detach,
 	.sub_caps_updated	= sched_ext_ops__sub_caps_updated,
+	.sub_ecaps_updated	= sched_ext_ops__sub_ecaps_updated,
 	.cid_online		= sched_ext_ops__cpu_online,
 	.cid_offline		= sched_ext_ops__cpu_offline,
 	.init_cids		= sched_ext_ops__init_cids,
@@ -9834,6 +9841,7 @@ static const u32 scx_kf_allow_flags[] = {
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 	[SCX_OP_IDX(sub_attach)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(sub_detach)]	= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(sub_ecaps_updated)]	= SCX_KF_ALLOW_ENQUEUE | SCX_KF_ALLOW_DISPATCH,
 	[SCX_OP_IDX(cpu_online)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(cpu_offline)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(init_cids)]		= SCX_KF_ALLOW_UNLOCKED | SCX_KF_ALLOW_INIT_CIDS,
@@ -9973,6 +9981,7 @@ static int __init scx_init(void)
 	CID_OFFSET_MATCH(sub_attach, sub_attach);
 	CID_OFFSET_MATCH(sub_detach, sub_detach);
 	CID_OFFSET_MATCH(sub_caps_updated, sub_caps_updated);
+	CID_OFFSET_MATCH(sub_ecaps_updated, sub_ecaps_updated);
 	CID_OFFSET_MATCH(init_cids, init_cids);
 	CID_OFFSET_MATCH(init, init);
 	CID_OFFSET_MATCH(exit, exit);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 8e9b697c833b..93c24c5d7515 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -770,12 +770,26 @@ struct sched_ext_ops {
 	 * Delivered asynchronously after the change is recorded, and may run
 	 * before it takes effect on any given cpu. Use it to track which caps
 	 * the sub-sched holds and propagate to its own children, not to decide
-	 * if a task can run on a cpu now.
+	 * if a task can run on a cpu now. sub_ecaps_updated() reports that per
+	 * cpu, once it is in effect.
 	 *
 	 * May call scx_bpf_sub_grant() / scx_bpf_sub_revoke() on children.
 	 */
 	void (*sub_caps_updated)(const struct scx_cmask *cmask, u64 caps);
 
+	/**
+	 * @sub_ecaps_updated: This sub-sched's effective caps on a cid changed
+	 * @cid: the cid whose effective caps changed
+	 * @before: effective caps as of the last delivery
+	 * @after: effective caps now
+	 *
+	 * Invoked when this sub-sched's effective caps on @cid change, once the
+	 * change is in effect on the cpu. Runs in dispatch context with rq lock
+	 * held, and can perform all operations allowed in ops.dispatch()
+	 * including inserting/moving tasks.
+	 */
+	void (*sub_ecaps_updated)(s32 cid, u64 before, u64 after);
+
 	/*
 	 * All online ops must come before ops.cpu_online().
 	 */
@@ -997,6 +1011,7 @@ struct sched_ext_ops_cid {
 	s32 (*sub_attach)(struct scx_sub_attach_args *args);
 	void (*sub_detach)(struct scx_sub_detach_args *args);
 	void (*sub_caps_updated)(const struct scx_cmask *cmask, u64 caps);
+	void (*sub_ecaps_updated)(s32 cid, u64 before, u64 after);
 	void (*cid_online)(s32 cid);
 	void (*cid_offline)(s32 cid);
 	s32 (*init_cids)(void);
@@ -1198,6 +1213,8 @@ struct scx_sched_pcpu {
 	 */
 	u64			ecaps;
 	struct llist_node	ecaps_to_sync_node;
+	/* effective caps as of the last sub_ecaps_updated() delivery */
+	u64			reported_ecaps;
 #endif
 
 	/*
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 3d488c1b0d59..deb4c802af83 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -13,6 +13,7 @@
  * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
  */
+#include <linux/delay.h>
 #include <linux/rhashtable.h>
 #include "internal.h"
 #include "cid.h"
@@ -339,15 +340,16 @@ static void discard_queued_syncs(struct rq *rq)
 /**
  * scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
  * @rq: the cid's cpu rq
+ * @prev: @rq's previous task from the in-progress balance
  *
  * pshard->caps[] is the target configuration. pcpu->ecaps is the effective
  * transposed copy owned by the cid's cpu and written only here under @rq's
  * lock.
  */
-void scx_process_sync_ecaps(struct rq *rq)
+void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 {
-	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
-	s32 shard = scx_cid_to_shard[cid];
+	s32 cpu = cpu_of(rq);
+	s32 cid, shard;
 	struct llist_node *batch, *pos, *tmp;
 
 	lockdep_assert_rq_held(rq);
@@ -355,33 +357,140 @@ void scx_process_sync_ecaps(struct rq *rq)
 	if (likely(llist_empty(&rq->scx.ecaps_to_sync)))
 		return;
 
+	/*
+	 * ecaps are zeroed while the cpu is inactive and must stay zero.
+	 * Discard queued syncs instead of processing them - the
+	 * scx_online_ecaps() reseed re-syncs every sched on activation.
+	 * cpu_active() clears before the offline zeroing and sets before the
+	 * reseed is queued, so this test can neither miss a racing sync nor
+	 * eat the reseed.
+	 */
+	if (unlikely(!cpu_active(cpu))) {
+		discard_queued_syncs(rq);
+		return;
+	}
+
+	/* @cid is valid here: the cpu is active with queued syncs */
+	cid = __scx_cpu_to_cid(cpu);
+	shard = scx_cid_to_shard[cid];
+
 	batch = llist_del_all(&rq->scx.ecaps_to_sync);
 	llist_for_each_safe(pos, tmp, batch) {
 		struct scx_sched_pcpu *pcpu =
 			container_of(pos, struct scx_sched_pcpu, ecaps_to_sync_node);
 		struct scx_pshard *ps = pcpu->sch->pshard[shard];
+		u64 ecaps;
 
 		init_llist_node(pos);
 
 		/* pairs with smp_mb() in queue_sync_ecaps(), see there */
 		smp_mb();
 
-		WRITE_ONCE(pcpu->ecaps, calc_effective_caps(ps, cid));
+		ecaps = calc_effective_caps(ps, cid);
+		WRITE_ONCE(pcpu->ecaps, ecaps);
+
+		/* tell the sched its effective caps on this cid changed */
+		if (ecaps != pcpu->reported_ecaps &&
+		    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
+		    !scx_bypassing(pcpu->sch, cpu)) {
+			struct scx_dsp_ctx *dspc = &pcpu->dsp_ctx;
+
+			dspc->rq = rq;
+			/* stash @prev so nested dispatches can access it */
+			rq->scx.sub_dispatch_prev = prev;
+			SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq, scx_cpu_arg(cpu),
+				    pcpu->reported_ecaps, ecaps);
+			rq->scx.sub_dispatch_prev = NULL;
+			scx_flush_dispatch_buf(pcpu->sch, rq);
+			pcpu->reported_ecaps = ecaps;
+		}
+	}
+}
+
+/*
+ * A cpu came back. Re-seed each sub-sched's ecaps on the cpu's cid. The sync
+ * recomputes effective caps from the pshard and fires ops.sub_ecaps_updated()
+ * only on a real change since offline.
+ */
+void scx_online_ecaps(struct rq *rq)
+{
+	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
+	s32 shard = scx_cid_to_shard[cid];
+	struct scx_sched *pos;
+
+	guard(rq_lock_irqsave)(rq);
+
+	scx_for_each_descendant_pre(pos, scx_root) {
+		struct scx_pshard *ps;
+
+		/* root holds every cap and never uses ecaps */
+		if (pos == scx_root)
+			continue;
+
+		ps = pos->pshard[shard];
+		guard(raw_spinlock)(&ps->lock);
+		queue_sync_ecaps(pos, cid);
+	}
+}
+
+/*
+ * A cpu is going down. Zero each sub-sched's in-effect ecaps so cap checks
+ * treat the cpu as capless while offline. Pending and late-queued syncs are
+ * discarded at consumption by scx_process_sync_ecaps() while the cpu is
+ * inactive. Leave reported_ecaps. Ownership is unchanged, so the
+ * scx_online_ecaps() reseed reports only a genuine delta. No callback fires
+ * here.
+ */
+void scx_offline_ecaps(struct rq *rq)
+{
+	s32 cpu = cpu_of(rq);
+	struct scx_sched *pos;
+
+	guard(rq_lock_irqsave)(rq);
+
+	scx_for_each_descendant_pre(pos, scx_root) {
+		/* root holds every cap and never uses ecaps */
+		if (pos == scx_root)
+			continue;
+
+		WRITE_ONCE(per_cpu_ptr(pos->pcpu, cpu)->ecaps, 0);
 	}
 }
 
 /*
  * @pcpu's sched was unhashed before the grace period, so nothing new queues.
- * Flush its pending sync so the pcpu can be freed. scx_process_sync_ecaps()
- * takes nodes off the list before syncing and acquiring the rq lock waits for
- * any in-flight walk.
+ * Flush its pending sync so the pcpu can be freed. If the cpu is online and
+ * scx is enabled, drain via balance_one(). Otherwise, discard under the rq
+ * lock.
  */
 void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
 {
-	scoped_guard (rq_lock_irqsave, cpu_rq(cpu))
-		scx_process_sync_ecaps(cpu_rq(cpu));
+	struct rq *rq = cpu_rq(cpu);
 
-	WARN_ON_ONCE(llist_on_list(&pcpu->ecaps_to_sync_node));
+	while (true) {
+		scoped_guard (rq_lock_irqsave, rq) {
+			/*
+			 * scx_process_sync_ecaps() takes the node off the list
+			 * before it is done accessing @pcpu but does all of it
+			 * under the rq lock. Off-list observed under the rq
+			 * lock guarantees that the sync is complete.
+			 */
+			if (!llist_on_list(&pcpu->ecaps_to_sync_node))
+				return;
+			/*
+			 * Discard only when the cpu is truly down. cpu_active()
+			 * is already set when scx_online_ecaps() queues an online
+			 * resync while SCX_RQ_ONLINE is not - so test cpu_active(),
+			 * or that resync would be dropped.
+			 */
+			if (!scx_enabled() || !cpu_active(cpu)) {
+				discard_queued_syncs(rq);
+				return;
+			}
+		}
+		resched_cpu(cpu);
+		msleep(1);
+	}
 }
 
 /**
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 85cadb62ad93..1f0cef59302c 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -28,7 +28,9 @@ bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *aux);
 void scx_free_pshards(struct scx_sched *sch);
 s32 scx_alloc_pshards(struct scx_sched *sch);
 void scx_init_root_caps(struct scx_sched *sch);
-void scx_process_sync_ecaps(struct rq *rq);
+void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev);
+void scx_online_ecaps(struct rq *rq);
+void scx_offline_ecaps(struct rq *rq);
 void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu);
 void scx_discard_stale_ecaps_syncs(void);
 
@@ -44,7 +46,9 @@ static inline void scx_sub_disable(struct scx_sched *sch) { }
 static inline void scx_free_pshards(struct scx_sched *sch) {}
 static inline s32 scx_alloc_pshards(struct scx_sched *sch) { return 0; }
 static inline void scx_init_root_caps(struct scx_sched *sch) {}
-static inline void scx_process_sync_ecaps(struct rq *rq) {}
+static inline void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev) {}
+static inline void scx_online_ecaps(struct rq *rq) {}
+static inline void scx_offline_ecaps(struct rq *rq) {}
 static inline void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu) {}
 static inline void scx_discard_stale_ecaps_syncs(void) {}
 
-- 
2.54.0

