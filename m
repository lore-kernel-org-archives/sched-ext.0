Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB87489FBA;
	Fri,  9 Oct 2026 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539044; cv=none; b=mhYifXaTZ1burD8JT0umm70P56uFWozLGS1rnKyuyCW9MLaB234F9SyerW9bb0iAmmHuIzq9dQulbD1O5pQTfAVhXFvbLKFjJ+11qGfrcm4UBaxWUlHc4+p7E64z2SXwQQejIWpfNK2AxxVpT8mTr4qibnQjxvyMP8fCf8grKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539044; c=relaxed/simple;
	bh=NNuIRC9sZGQCQM/o8HMKT7qEs0pFm1tK7UjF8GW+/5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dy2/LJsKYVSYtpm6QpkXHtFZLWLUu2RDh26BvyUU873mOdD8Wumz211eM26mg4qKPD5V6ZwpMzeYnPphKqCezVh8mpvi6sIJ3tOdHu7wAFXTFy5gBwQDYzXAx6S5byyUxVZ3VMlJZkKxhGlFdoqnIxjRG4ZVq+QAoMhwhPImUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlGbgviR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlGbgviR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396441F00893;
	Fri,  9 Oct 2026 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791539038;
	bh=XWU+wplxO39VJSGhjcrrdsj/X46fewiug7ASIVD6bhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YlGbgviR0p4Qszw926ZdSguXoxc9G38sfGesdHHtsLxCaiIot1/4JyKX9hgKMPoJV
	 3KFSr/r8fQxIyoGlgjl09a+jg9L4gFBjs0q2PYIFyvDEZXl9zA/vRAopn5O+wlsmCX
	 8oMd33u+y/s9s/Px3UU5z3fpTQEm4gEAaWIrpIipD4UOeGq0CHzX6ljduzx1SXNyfv
	 AmsJ8XPOtchxaHzObGknLiIDEB0IJqhowj7ZppoZYzD2Dz3hxVPrIJsZshI6Ey1E/O
	 7WSQd9MoBy6s9I7lIINykCDr4b+pGvw3V7krnrNLt4aRMihgm++hBMXBggreu474kb
	 WsaojmZ8sPvCw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Factor out sync_pcpu_ecaps()
Date: Thu,  8 Oct 2026 23:43:55 -1000
Message-ID: <20261009094356.2852794-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009094356.2852794-1-tj@kernel.org>
References: <20261009094356.2852794-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor sync_pcpu_ecaps() out of __scx_process_sync_ecaps() so that a sched's
ecaps can be synced and reported outside the drain. No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/sub.c | 127 +++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 51a53467cf98..313e69841bc9 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1036,9 +1036,9 @@ static void queue_sync_ecaps(struct scx_sched *sch, s32 cid)
 	struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
 	/*
-	 * Pairs with smp_mb() in __scx_process_sync_ecaps(). Either the check
-	 * below sees the node off the list and queues it, or the in-flight sync
-	 * sees the caps[] update made before this call.
+	 * Pairs with smp_mb() in sync_pcpu_ecaps(). Either the check below sees
+	 * the node off the list and queues it, or the in-flight sync sees the
+	 * caps[] update made before this call.
 	 */
 	smp_mb();
 
@@ -1061,9 +1061,13 @@ static void discard_queued_syncs(struct rq *rq)
 }
 
 /**
- * __scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
- * @rq: the cid's cpu rq
+ * sync_pcpu_ecaps - Sync @pcpu's ecaps to its pshard caps on @rq's cid
+ * @rq: the cid's cpu rq, locked and active
+ * @pcpu: the sched's per-cpu state on @rq's cpu
+ * @cid: @rq's cid
+ * @shard: @cid's pshard index
  * @prev: @rq's previous task from the in-progress dispatch
+ * @report: whether a change is reported to the sched
  *
  * pshard->caps[] is the target configuration. pcpu->ecaps is the effective
  * transposed copy owned by the cid's cpu and written only here under @rq's
@@ -1072,6 +1076,67 @@ static void discard_queued_syncs(struct rq *rq)
  * A sched that newly gains baseline access here is owed an update_idle() so it
  * learns the cid's idle state. Such a gain arms the per-rq
  * %SCX_RQ_SUB_IDLE_RENOTIFY gate so the next idle pick delivers it.
+ *
+ * Return the caps lost.
+ */
+static u64 sync_pcpu_ecaps(struct rq *rq, struct scx_sched_pcpu *pcpu, s32 cid, s32 shard,
+			   struct task_struct *prev, bool report)
+{
+	struct scx_pshard *ps = pcpu->sch->pshard[shard];
+	u64 old, ecaps, lost, gained;
+
+	/* pairs with smp_mb() in queue_sync_ecaps(), see there */
+	smp_mb();
+
+	old = READ_ONCE(pcpu->ecaps);
+	ecaps = calc_effective_caps(ps, cid);
+	WRITE_ONCE(pcpu->ecaps, ecaps);
+
+	lost = old & ~ecaps;
+	gained = ecaps & ~old;
+
+	/*
+	 * Tell the sched its effective caps on this cid changed. The invocation
+	 * is equivalent to the dispatch path and may drop and re-acquire the rq
+	 * lock temporarily while the caller still holds other queued syncs
+	 * privately, see scx_discard_ecaps_to_sync(). The dispatch kfuncs
+	 * resolve their context on the executing cpu, which under core
+	 * scheduling can differ from @rq's cpu, so the context is set up there.
+	 * The rq recorded in it keeps the dispatches targeting @rq.
+	 */
+	if (ecaps != pcpu->reported_ecaps &&
+	    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) && report) {
+		struct scx_dsp_ctx *dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
+
+		dspc->rq = rq;
+		/* stash @prev so nested dispatches can access it */
+		rq->scx.sub_dispatch_prev = prev;
+		SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq, scx_cpu_arg(cpu_of(rq)),
+			    pcpu->reported_ecaps, ecaps);
+		rq->scx.sub_dispatch_prev = NULL;
+		scx_flush_dispatch_buf(pcpu->sch, rq);
+		pcpu->reported_ecaps = ecaps;
+	}
+
+	/*
+	 * Gaining baseline access owes an update_idle() so the sched learns the
+	 * cpu's idle state. Arm the per-rq gate so the next idle pick flushes
+	 * it. Losing access drops any pending notify.
+	 */
+	if (gained & SCX_CAP_BASE) {
+		pcpu->idle_renotify = true;
+		rq->scx.flags |= SCX_RQ_SUB_IDLE_RENOTIFY;
+	} else if (lost & SCX_CAP_BASE) {
+		pcpu->idle_renotify = false;
+	}
+
+	return lost;
+}
+
+/**
+ * __scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
+ * @rq: the cid's cpu rq
+ * @prev: @rq's previous task from the in-progress dispatch
  */
 void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 {
@@ -1104,58 +1169,10 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 	llist_for_each_safe(pos, tmp, batch) {
 		struct scx_sched_pcpu *pcpu =
 			container_of(pos, struct scx_sched_pcpu, ecaps_to_sync_node);
-		struct scx_pshard *ps = pcpu->sch->pshard[shard];
-		u64 old, ecaps, lost, gained;
 
 		init_llist_node(pos);
-
-		/* pairs with smp_mb() in queue_sync_ecaps(), see there */
-		smp_mb();
-
-		old = READ_ONCE(pcpu->ecaps);
-		ecaps = calc_effective_caps(ps, cid);
-		WRITE_ONCE(pcpu->ecaps, ecaps);
-
-		lost = old & ~ecaps;
-		gained = ecaps & ~old;
-		lost_all |= lost;
-
-		/*
-		 * Tell the sched its effective caps on this cid changed. The
-		 * invocation is equivalent to the dispatch path and may drop
-		 * and re-acquire the rq lock temporarily while the rest of
-		 * @batch is held privately, see scx_discard_ecaps_to_sync().
-		 * The dispatch kfuncs resolve their context on the executing
-		 * cpu, which under core scheduling can differ from @rq's cpu,
-		 * so the context is set up there. The rq recorded in it keeps
-		 * the dispatches targeting @rq.
-		 */
-		if (ecaps != pcpu->reported_ecaps &&
-		    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
-		    !scx_bypassing(pcpu->sch, cpu)) {
-			struct scx_dsp_ctx *dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
-
-			dspc->rq = rq;
-			/* stash @prev so nested dispatches can access it */
-			rq->scx.sub_dispatch_prev = prev;
-			SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq, scx_cpu_arg(cpu),
-				    pcpu->reported_ecaps, ecaps);
-			rq->scx.sub_dispatch_prev = NULL;
-			scx_flush_dispatch_buf(pcpu->sch, rq);
-			pcpu->reported_ecaps = ecaps;
-		}
-
-		/*
-		 * Gaining baseline access owes an update_idle() so the sched
-		 * learns the cpu's idle state. Arm the per-rq gate so the next
-		 * idle pick flushes it. Losing access drops any pending notify.
-		 */
-		if (gained & SCX_CAP_BASE) {
-			pcpu->idle_renotify = true;
-			rq->scx.flags |= SCX_RQ_SUB_IDLE_RENOTIFY;
-		} else if (lost & SCX_CAP_BASE) {
-			pcpu->idle_renotify = false;
-		}
+		lost_all |= sync_pcpu_ecaps(rq, pcpu, cid, shard, prev,
+					    !scx_bypassing(pcpu->sch, cpu));
 	}
 
 	/*
-- 
2.55.0

