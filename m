Received: from mta1.migadu.com (out-153.mta1.migadu.com [95.215.58.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD34BFE93
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281642; cv=none; b=pWd2aswn8u03I6BYsIHUXL0CmZ62HUaY+N4PWwx3qoW2j32BpaA1dGne1f/lPC+pape6yc8zKWwVazs9fKA+cc3tObrkri455ZF6O2iK1sbxvGNeG9Da+aUwPY62w/uSzSqyI8J96YcieUZICwKpA6SQVgjDROn15A9jIDHAv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281642; c=relaxed/simple;
	bh=8VEzepUYXnkMgxydyc4i9ERcKbbyPZU5XIr7Df9ZbXQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=asVoL0qy7HxhuG0aloqbWcBf8pKATvC7XOtZ4QO6t5j8D7gtdmoS149LpqiPZ10RAtU0HH1ZIepU06FccZs/vIu0asRzZI5qb4oT6HGhsY0O/op5OJRQSkpOGHzVcD8aUj+/Rka9vDCSngdDB3gZaqz8lFGNxElKF1ZqUxOuj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DBAfSKAn; arc=none smtp.client-ip=95.215.58.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DBAfSKAn"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=8VEzepUYXnkMgxydyc4i9ERcKbbyPZU5XIr7Df9ZbXQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790281634; v=1; x=1790886434;
 b=DBAfSKAnDTLDMCani1gCI+J6Vs74Z9vAHPnaHuetN3ABipcUkr/bcebyokue+WxJFtV+2KlR
 1hfUSPab7+VJKZV/ZNewRGSF5wCyQVjTdv+r897Yyw3reUrwGfmhiNNlxsMU7i1iu24UWFROp4A
 OrF4syyoktEPET66cZJMSBFo=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 81d824b08deb57c9;
	Thu, 24 Sep 2026 20:27:14 +0000
X-Mizu-Trace-ID: 81d824b08deb57c9
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	mgorman@suse.de,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	usama.arif@linux.dev,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: [PATCH] sched_ext: Test scx_has_subs() inline before calling sub-sched hooks
Date: Thu, 24 Sep 2026 13:27:11 -0700
Message-ID: <20260924202711.4042339-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_reenq_reject(), scx_process_sync_ecaps() and scx_resolve_local_dsq()
return early if there are no sub-schedulers, but clang emits the full
prologue before the static branch. Without sub-schedulers, we still pay
for a call and for saving and restoring up to six registers, on every
wakeup, dispatch and local DSQ insert.

Let's move the scx_has_subs() test into inline wrappers, so that these
calls go away completely. The wrappers keep lockdep_assert_rq_held().

In a pinned perf bench sched pipe test on x86-64 with clang 22, this
reduced kernel instructions by 52-54 per context switch with scx_simple,
scx_lavd and scx_layered.

No functional change intended.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/sched/ext/sub.c | 25 +++++++++----------------
 kernel/sched/ext/sub.h | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 6463cebd88985..10567196be96c 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -675,7 +675,7 @@ void scx_rescue_init(struct rq *rq)
 }
 
 /**
- * scx_resolve_local_dsq - Pick the local, rescue or reject DSQ for an insert
+ * __scx_resolve_local_dsq - Pick the local, rescue or reject DSQ for an insert
  * @sch: enqueuing sub-sched
  * @rq: rq whose local DSQ @p targets
  * @p: task being inserted
@@ -695,12 +695,9 @@ void scx_rescue_init(struct rq *rq)
  * to and run by its nearest non-bypassing ancestor. If root is bypassing, it
  * always holds all caps.
  */
-struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *rq,
-					     struct task_struct *p, u64 *enq_flags)
+struct scx_dispatch_q *__scx_resolve_local_dsq(struct scx_sched *sch, struct rq *rq,
+					       struct task_struct *p, u64 *enq_flags)
 {
-	if (!scx_has_subs())
-		return &rq->scx.local_dsq;
-
 	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
 	struct scx_sched *asch = rq->scx.remote_activate_sch ?: sch;
 	u64 needed = scx_caps_for_enq(*enq_flags);
@@ -783,14 +780,12 @@ bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p)
  * scx_do_enqueue_task(), which ejects the owning sub past SCX_REENQ_MAX_REPEAT.
  * Rejection can't happen for root.
  */
-void scx_reenq_reject(struct rq *rq)
+void __scx_reenq_reject(struct rq *rq)
 {
 	LIST_HEAD(tasks);
 	struct task_struct *p, *n;
 
-	lockdep_assert_rq_held(rq);
-
-	if (!scx_has_subs() || list_empty(&rq->scx.reject_dsq.list))
+	if (list_empty(&rq->scx.reject_dsq.list))
 		return;
 
 	/*
@@ -926,7 +921,7 @@ static void queue_sync_ecaps(struct scx_sched *sch, s32 cid)
 	struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
 	/*
-	 * Pairs with smp_mb() in scx_process_sync_ecaps(). Either the check
+	 * Pairs with smp_mb() in __scx_process_sync_ecaps(). Either the check
 	 * below sees the node off the list and queues it, or the in-flight sync
 	 * sees the caps[] update made before this call.
 	 */
@@ -951,7 +946,7 @@ static void discard_queued_syncs(struct rq *rq)
 }
 
 /**
- * scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
+ * __scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
  * @rq: the cid's cpu rq
  * @prev: @rq's previous task from the in-progress dispatch
  *
@@ -963,16 +958,14 @@ static void discard_queued_syncs(struct rq *rq)
  * learns the cid's idle state. Such a gain arms the per-rq
  * %SCX_RQ_SUB_IDLE_RENOTIFY gate so the next idle pick delivers it.
  */
-void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
+void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 {
 	s32 cpu = cpu_of(rq);
 	s32 cid, shard;
 	struct llist_node *batch, *pos, *tmp;
 	u64 lost_all = 0;
 
-	lockdep_assert_rq_held(rq);
-
-	if (!scx_has_subs() || likely(llist_empty(&rq->scx.ecaps_to_sync)))
+	if (likely(llist_empty(&rq->scx.ecaps_to_sync)))
 		return;
 
 	/*
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index f7bcdfda8dd85..6a7076b9a1ddb 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -28,16 +28,16 @@ bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *aux);
 void scx_free_pshards(struct scx_sched *sch);
 s32 scx_alloc_pshards(struct scx_sched *sch);
 void scx_init_root_caps(struct scx_sched *sch);
-void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev);
+void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev);
 void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch);
 void scx_online_ecaps(struct rq *rq);
 void scx_offline_ecaps(struct rq *rq);
 void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu);
 void scx_discard_stale_ecaps_syncs(void);
-struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *rq,
-					     struct task_struct *p, u64 *enq_flags);
+struct scx_dispatch_q *__scx_resolve_local_dsq(struct scx_sched *sch, struct rq *rq,
+					       struct task_struct *p, u64 *enq_flags);
 bool scx_task_reenq_on_cap_revoke(struct rq *rq, struct task_struct *p);
-void scx_reenq_reject(struct rq *rq);
+void __scx_reenq_reject(struct rq *rq);
 void scx_rescue_charge(struct rq *rq, s64 delta_exec);
 void scx_rescue_end(struct rq *rq);
 bool scx_rescue_keep(struct rq *rq, struct task_struct *p);
@@ -72,6 +72,33 @@ static inline void scx_dec_has_subs(struct scx_sched *sch)
 		static_branch_dec(&__scx_has_subs);
 }
 
+/* hot-path hooks, gated inline so that a root-only system skips the calls */
+static inline void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
+{
+	lockdep_assert_rq_held(rq);
+
+	if (scx_has_subs())
+		__scx_process_sync_ecaps(rq, prev);
+}
+
+static inline struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch,
+							   struct rq *rq,
+							   struct task_struct *p,
+							   u64 *enq_flags)
+{
+	if (!scx_has_subs())
+		return &rq->scx.local_dsq;
+	return __scx_resolve_local_dsq(sch, rq, p, enq_flags);
+}
+
+static inline void scx_reenq_reject(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+
+	if (scx_has_subs())
+		__scx_reenq_reject(rq);
+}
+
 #else	/* CONFIG_EXT_SUB_SCHED */
 
 static inline struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
-- 
2.53.0-Meta

