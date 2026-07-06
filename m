Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30F37E2E6;
	Mon,  6 Jul 2026 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302083; cv=none; b=i8RwUETPMgC8nXPZG/aJyh//NS2VTDfWVdSULnxPwHzz9MgfdvTe3sie3igoPgjWoFBS0yW66dquO9lITe7k+po+bdWNgDdAawRfUQLOav2QgfYgmEH2vFTYA1+66XLRImfllX5PONVJLY1TuWeTch3pAlLny8g3DtBFcjw4nT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302083; c=relaxed/simple;
	bh=nLVno1eKJSv6l4btgzJMPghAgepRMADBRKhr7WEA0vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyyZo2rAl0iJDThtMxXGriVUJSAYuCq0VCiXJRXM7F+A9R3jMk0u34mNhX4HXgroMsRhw9AgKALbo0x/b5RuO+r3QwCdVsfz0V2yjrg6K9TJhhoVODKOTxwYvof1CJhEFgS5o3zZ/JFaeinXtnUdwgnH0LHWFye+JSXNRVkLuvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMn7gQf9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMn7gQf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878E01F00A3A;
	Mon,  6 Jul 2026 01:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302080;
	bh=yGUeokeaZv252Gcsj0TDEc5D98Co/FsGweVWihaJcUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UMn7gQf9KlXdfYAHjFaYT6Dr+wlUShTlzLrsrg5cYvCKGBpE2rzeNQh9XqdSpBoAJ
	 eCRRqvWjRwU4bosxHJMfgrqHbQ1Xi1cT+Ip7rjljkYiExrCEBdSWgvXkd5dB536WK1
	 YiR3oiaH9FvWCd4lHSTEsfxjAUQoPAXorA7F3dmjks7Kw7T2RfrVdlToprayZCmRq2
	 P8IwJWpLFXN07Fb+X/ZbsIXumkoJXJCKG2uHn9vTkW87NBGQgJcTrjGpSKuyrJtdW6
	 gWVnadIdjwpHj/2mp9H76SCFArGM4t+HYdbWr181vjZR0HvICwOzCLvzJPEGEGYTsA
	 O3paBPJrmCVIA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 21/36] sched_ext: Maintain per-cpu effective cap copies for single-read checks
Date: Sun,  5 Jul 2026 15:40:43 -1000
Message-ID: <20260706014058.439853-22-tj@kernel.org>
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

Checking a sched's caps on a cid would need to test several cap bits against
caps[] to account for implied caps. Also, caps[] modifications aren't
synchronized against scheduling operations on each cpu, which can lead to
awkward race conditions.

Collect them per cpu instead. caps[] under pshard->lock stays the target
configuration. scx_sched_pcpu->ecaps is added, the transposed effective
copy: the set of cap bits the sched holds on that cpu which can be accessed
with a single read. It is stable under the rq lock. It can also be read
locklessly with READ_ONCE().

Grant and revoke only mutate caps[]. They queue a sync request on the target
cpu's rq->scx.ecaps_to_sync and kick it, and the cpu recomputes the queued
scheds' ecaps from caps[] in balance_one() under its own rq lock. A dying
sched runs the sync directly to retire its queued request before freeing. As
held references can defer the freeing past the enclosing root scheduler's
lifetime, root enable discards leftover sync requests before going live.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  10 +++
 kernel/sched/ext/internal.h |  21 +++++-
 kernel/sched/ext/sub.c      | 133 +++++++++++++++++++++++++++++++++++-
 kernel/sched/ext/sub.h      |  16 +++++
 kernel/sched/sched.h        |   3 +
 5 files changed, 180 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1fa656e2bbb4..6f8841b5b925 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2595,6 +2595,8 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	rq->scx.flags |= SCX_RQ_IN_BALANCE;
 	rq->scx.flags &= ~SCX_RQ_BAL_KEEP;
 
+	scx_process_sync_ecaps(rq);
+
 	if ((sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
 	    unlikely(rq->scx.cpu_released)) {
 		/*
@@ -4627,6 +4629,9 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		 */
 		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
 
+		/* flush the queued ecaps syncs */
+		scx_discard_ecaps_to_sync(cpu, pcpu);
+
 		/*
 		 * Bypass blocks new kicks. Flush the kick irq_work so this
 		 * pcpu's to_kick_node is off the list before it is freed.
@@ -6371,6 +6376,9 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		node = cpu_to_node(cpu);
 		pcpu->sch = sch;
 		INIT_LIST_HEAD(&pcpu->deferred_reenq_local.node);
+#ifdef CONFIG_EXT_SUB_SCHED
+		init_llist_node(&pcpu->ecaps_to_sync_node);
+#endif
 		INIT_LIST_HEAD(&pcpu->to_kick_node);
 		if (!zalloc_cpumask_var_node(&pcpu->cpus_to_kick, GFP_KERNEL, node) ||
 		    !zalloc_cpumask_var_node(&pcpu->cpus_to_kick_if_idle, GFP_KERNEL, node) ||
@@ -6715,6 +6723,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		rq->scx.cpuperf_target = SCX_CPUPERF_ONE;
 	}
 
+	scx_discard_stale_ecaps_syncs();
+
 	/*
 	 * Keep CPUs stable during enable so that the BPF scheduler can track
 	 * online CPUs by watching ->on/offline_cpu() after ->init().
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 4cf110a3b738..8e9b697c833b 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1182,6 +1182,24 @@ struct scx_sched_pcpu {
 	cpumask_var_t		cpus_to_wait;
 	struct list_head	to_kick_node;
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	/*
+	 * pshard->caps[cap_bit] is the set of cids the sched holds that one
+	 * cap on. ecaps is its transpose: the set of SCX_CAP_* bits the sched
+	 * holds on this cpu, collected so that the hot-path check is a single
+	 * read.
+	 *
+	 * While pshard->caps[] under pshard->lock is the target configuration,
+	 * ecaps is the effective copy owned by the cpu. It is written under the
+	 * rq lock while processing rq->ecaps_to_sync. Can also be read with
+	 * READ_ONCE() outside rq lock.
+	 *
+	 * See queue_sync_ecaps() and scx_process_sync_ecaps().
+	 */
+	u64			ecaps;
+	struct llist_node	ecaps_to_sync_node;
+#endif
+
 	/*
 	 * The event counters are in a per-CPU variable to minimize the
 	 * accounting overhead. A system-wide view on the event counter is
@@ -1291,7 +1309,8 @@ struct scx_pshard {
 
 	/*
 	 * Per-cap cmask, inline via TRAILING_OVERLAP so cmask.bits[] overlaps
-	 * the trailing _bits[] storage. Access as &caps[i].cmask.
+	 * the trailing _bits[] storage. Access as &caps[i].cmask. See
+	 * scx_sched_pcpu->ecaps.
 	 */
 	TRAILING_OVERLAP(struct scx_cmask, cmask, bits,
 			 u64 _bits[SCX_CMASK_NR_WORDS(SCX_CID_SHARD_MAX_CPUS)];
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 5bd3b8a1da6b..3d488c1b0d59 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -287,6 +287,125 @@ static void scx_sub_seed_caps(struct scx_sched *sch)
 	caps_updated_deliver(&to_deliver);
 }
 
+static u64 calc_effective_caps(struct scx_pshard *ps, s32 cid)
+{
+	u64 ecaps = 0;
+	u32 cap_bit;
+
+	for (cap_bit = 0; cap_bit < __SCX_NR_CAPS; cap_bit++)
+		if (scx_cmask_test(cid, &ps->caps[cap_bit].cmask))
+			ecaps |= BIT_U64(cap_bit) | scx_caps_implied(BIT_U64(cap_bit));
+	return ecaps;
+}
+
+/**
+ * queue_sync_ecaps - Queue ecaps update for a (sch, cid) pair
+ * @sch: sched to update
+ * @cid: cid to update
+ *
+ * Queue an ecaps update for @sch's @cid and kick the cpu so that it syncs in
+ * balance_one().
+ */
+static void queue_sync_ecaps(struct scx_sched *sch, s32 cid)
+{
+	s32 cpu = __scx_cid_to_cpu(cid);
+	struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
+	/*
+	 * Pairs with smp_mb() in scx_process_sync_ecaps(). Either the check
+	 * below sees the node off the list and queues it, or the in-flight sync
+	 * sees the caps[] update made before this call.
+	 */
+	smp_mb();
+
+	/* @cid's pshard->lock excludes concurrent queueing attempts */
+	if (llist_on_list(&pcpu->ecaps_to_sync_node))
+		return;
+	if (llist_add(&pcpu->ecaps_to_sync_node, &cpu_rq(cpu)->scx.ecaps_to_sync))
+		scx_kick_cpu(scx_root, cpu, 0);
+}
+
+/* discard @rq's queued ecaps syncs */
+static void discard_queued_syncs(struct rq *rq)
+{
+	struct llist_node *pos, *tmp;
+
+	lockdep_assert_rq_held(rq);
+
+	llist_for_each_safe(pos, tmp, llist_del_all(&rq->scx.ecaps_to_sync))
+		init_llist_node(pos);
+}
+
+/**
+ * scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
+ * @rq: the cid's cpu rq
+ *
+ * pshard->caps[] is the target configuration. pcpu->ecaps is the effective
+ * transposed copy owned by the cid's cpu and written only here under @rq's
+ * lock.
+ */
+void scx_process_sync_ecaps(struct rq *rq)
+{
+	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
+	s32 shard = scx_cid_to_shard[cid];
+	struct llist_node *batch, *pos, *tmp;
+
+	lockdep_assert_rq_held(rq);
+
+	if (likely(llist_empty(&rq->scx.ecaps_to_sync)))
+		return;
+
+	batch = llist_del_all(&rq->scx.ecaps_to_sync);
+	llist_for_each_safe(pos, tmp, batch) {
+		struct scx_sched_pcpu *pcpu =
+			container_of(pos, struct scx_sched_pcpu, ecaps_to_sync_node);
+		struct scx_pshard *ps = pcpu->sch->pshard[shard];
+
+		init_llist_node(pos);
+
+		/* pairs with smp_mb() in queue_sync_ecaps(), see there */
+		smp_mb();
+
+		WRITE_ONCE(pcpu->ecaps, calc_effective_caps(ps, cid));
+	}
+}
+
+/*
+ * @pcpu's sched was unhashed before the grace period, so nothing new queues.
+ * Flush its pending sync so the pcpu can be freed. scx_process_sync_ecaps()
+ * takes nodes off the list before syncing and acquiring the rq lock waits for
+ * any in-flight walk.
+ */
+void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu)
+{
+	scoped_guard (rq_lock_irqsave, cpu_rq(cpu))
+		scx_process_sync_ecaps(cpu_rq(cpu));
+
+	WARN_ON_ONCE(llist_on_list(&pcpu->ecaps_to_sync_node));
+}
+
+/**
+ * scx_discard_stale_ecaps_syncs - Discard ecaps syncs from earlier schedulers
+ *
+ * To be called during root enable before the scheduler goes live. An earlier
+ * root's sub-sched may not have gone through its RCU free path yet (e.g. a
+ * still-open link fd defers it) and can leave queued ecaps syncs behind.
+ * Processing them would decode the dead sched's pshards with the current cid
+ * layout. Discard them instead. The backing scx_sched_pcpu's are still
+ * allocated as the free path drains ecaps_to_sync_node before freeing.
+ */
+void scx_discard_stale_ecaps_syncs(void)
+{
+	s32 cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		guard(rq_lock_irqsave)(rq);
+		discard_queued_syncs(rq);
+	}
+}
+
 static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
 
 void drain_descendants(struct scx_sched *sch)
@@ -1030,9 +1149,14 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
 				granted_caps |= BIT_U64(cap_bit);
 			}
 
-			if (granted_caps)
+			if (granted_caps) {
+				s32 cid;
+
 				caps_updated_record(cps, changed_cids, granted_caps,
 						    &to_deliver);
+				scx_cmask_for_each_cid(cid, changed_cids)
+					queue_sync_ecaps(child, cid);
+			}
 		}
 
 		/* record cids that didn't make it through into @denied_out */
@@ -1125,9 +1249,14 @@ __bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
 					revoked_caps |= BIT_U64(cap_bit);
 				}
 
-				if (revoked_caps)
+				if (revoked_caps) {
+					s32 cid;
+
 					caps_updated_record(ps, changed_cids, revoked_caps,
 							    &to_deliver);
+					scx_cmask_for_each_cid(cid, changed_cids)
+						queue_sync_ecaps(pos, cid);
+				}
 			}
 
 			if (revoked_caps)
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 3a913cc56422..85cadb62ad93 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -28,6 +28,9 @@ bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *aux);
 void scx_free_pshards(struct scx_sched *sch);
 s32 scx_alloc_pshards(struct scx_sched *sch);
 void scx_init_root_caps(struct scx_sched *sch);
+void scx_process_sync_ecaps(struct rq *rq);
+void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu);
+void scx_discard_stale_ecaps_syncs(void);
 
 #else	/* CONFIG_EXT_SUB_SCHED */
 
@@ -41,6 +44,9 @@ static inline void scx_sub_disable(struct scx_sched *sch) { }
 static inline void scx_free_pshards(struct scx_sched *sch) {}
 static inline s32 scx_alloc_pshards(struct scx_sched *sch) { return 0; }
 static inline void scx_init_root_caps(struct scx_sched *sch) {}
+static inline void scx_process_sync_ecaps(struct rq *rq) {}
+static inline void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu) {}
+static inline void scx_discard_stale_ecaps_syncs(void) {}
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -57,6 +63,16 @@ static inline void scx_init_root_caps(struct scx_sched *sch) {}
 	for ((pos) = scx_next_descendant_pre(NULL, (root)); (pos);		\
 	     (pos) = scx_next_descendant_pre((pos), (root)))
 
+#ifdef CONFIG_EXT_SUB_SCHED
+
+/* caps implied by holding @cap */
+static inline u64 scx_caps_implied(u64 cap)
+{
+	return 0;
+}
+
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 /*
  * One user of this function is scx_bpf_dispatch() which can be called
  * recursively as sub-sched dispatches nest. Always inline to reduce stack usage
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9e41a23ef49e..72299c105487 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -806,6 +806,9 @@ struct scx_rq {
 	u32			flags;
 	u32			nr_immed;		/* ENQ_IMMED tasks on local_dsq */
 	u64			clock;			/* current per-rq clock -- see scx_bpf_now() */
+#ifdef CONFIG_EXT_SUB_SCHED
+	struct llist_head	ecaps_to_sync;		/* pending ecaps syncs */
+#endif
 	cpumask_var_t		cpus_to_sync;
 	bool			kick_sync_pending;
 	unsigned long		kick_sync;
-- 
2.54.0

