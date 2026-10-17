Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E03B47F4;
	Sat, 17 Oct 2026 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255563; cv=none; b=KC4tliwigZ6gn6wHGqS/i4qhUt8cL0tm2LW3NrLoqKa7rf4NILX1sFVArETyDVvc3r0cXtc8cAA9kPGpq0DWsTatL67wjA9Yhgybl3cE7jGxdPemvdGD6borhtDIdl6/IM9ZD5Swva5C94omXpnqySmzln9jLpjk7J13fypXvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255563; c=relaxed/simple;
	bh=3b5YRF4RYF0//kwetllea8rWutbCpdkbZu4jKJiWxfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKuvvpTcPKU3RN5krIexH3K9IkDE46dLl0pvU1oRF2mvX/kh8+9npKdDBU0Mu9Z8IKl7ZINc76jts+9GttxfZ6DflH43VFD2W1gx8xGRuS/Mm0EC1KPcPB92ZrECik+FAZtoBmmx9eap2uIA10G4w1e7oP7y1Fx0LK8xMgfevUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaJeArRC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaJeArRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709E61F000C4;
	Sat, 17 Oct 2026 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792255561;
	bh=h8eF448tidKfw7czlmzrvUiN/Lh7IKVzri1xom/k0E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KaJeArRCbCnIjxh+eFPy1rg7ztT8bsHjpAFkWuuyRLsa6xgLWprU/BQnnYCIVISND
	 jp3uZKpfjtfmRV/N/uIKjHatcp9FRz/ivk/hqiA0BchLQ3xLt/vJDb7WfRjlrGywAE
	 SG7OrGjXsN5mZ0inHqNkoEf4ZeEZtuIn2VKbPoiMEijglr/KoorWl7ouspoRSjI9Uq
	 FMzoGDHHQl17w5GHn4KwRJsLsUGJzVvwKYGsl7JwCiHlOBRDyWbOzFomPlmINMebjp
	 VmhB6NvFXSP10ZEDpFeec9dwPmxvWoNw++B5nPre03S9N53NrPDkBNq1/EIxRtkoHU
	 YiiHB3IGNInqQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] sched_ext: Deliver ecaps only while the root has the cpu online
Date: Sat, 17 Oct 2026 06:45:54 -1000
Message-ID: <20261017164556.4136807-5-tj@kernel.org>
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

A sub-scheduler's ecaps ops run in dispatch context, and ops.cpu_online()
and ops.cpu_offline() document that the cpu doesn't call ops.dispatch()
outside them. The reseed of a cpu coming back is queued before the root's
ops.cpu_online(), so the ops of a sub-scheduler and its parent can run for a
cpu the root still considers offline.

Add SCX_RQ_OPS_ONLINE, set while the root considers the cpu online, from its
ops.cpu_online() or its enable until its ops.cpu_offline(). A sync outside
that span leaves the ecaps alone, and the reseed, now queued after
ops.cpu_online(), reports the net change. SCX_RQ_ONLINE can't be used, as
the core changes it ahead of the root's view on both edges.

A cpu going offline still drops its caps without a report.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 18 ++++++++----
 kernel/sched/ext/internal.h |  6 ++++
 kernel/sched/ext/sub.c      | 57 ++++++++++++++++++++++++++++++-------
 kernel/sched/ext/sub.h      |  2 ++
 kernel/sched/sched.h        |  7 +++++
 5 files changed, 74 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3deda2d1f7f8..b7a24ff34483 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4117,11 +4117,6 @@ static void handle_hotplug(struct rq *rq, bool online)
 	if (scx_enabled())
 		scx_idle_update_selcpu_topology(&sch->ops);
 
-	if (online)
-		scx_online_ecaps(rq);
-	else
-		scx_offline_ecaps(rq);
-
 	/*
 	 * The tables can't be retired while this function is running as the
 	 * retirement is inside cpus_read_lock. However, scx_cpu_arg() is
@@ -4150,6 +4145,14 @@ static void handle_hotplug(struct rq *rq, bool online)
 		}
 	}
 
+	/*
+	 * ecaps are delivered for @cpu only after ops.cpu_online() and before
+	 * ops.cpu_offline(). The ecaps ops may read online_cmask, so
+	 * scx_offline_ecaps() and scx_online_ecaps() run after its update.
+	 */
+	if (!online)
+		scx_offline_ecaps(rq);
+
 	if (online && SCX_HAS_OP(sch, cpu_online))
 		SCX_CALL_OP(sch, cpu_online, NULL, cpu_or_cid);
 	else if (!online && SCX_HAS_OP(sch, cpu_offline))
@@ -4159,6 +4162,9 @@ static void handle_hotplug(struct rq *rq, bool online)
 			 SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
 			 "cpu %d going %s, exiting scheduler", cpu,
 			 online ? "online" : "offline");
+
+	if (online)
+		scx_online_ecaps(rq);
 }
 
 void scx_rq_activate(struct rq *rq)
@@ -8293,6 +8299,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		goto err_disable;
 	}
 
+	scx_init_rq_ops_online();
+
 	/*
 	 * Make the scheduler instance visible. Must be inside cpus_read_lock().
 	 * See handle_hotplug().
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 8532c58ddbfa..d03180f91ea6 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -926,6 +926,10 @@ struct sched_ext_ops {
 	 * Deliveries continue while this sched bypasses. Its tasks are then on
 	 * the bypass DSQs, where this op can't insert or move them. Deliveries
 	 * stop once this sched is being disabled.
+	 *
+	 * Deliveries for a cid happen only while the root considers the cid's
+	 * cpu online, never before the root's ops.cpu_online() or after its
+	 * ops.cpu_offline() for the cpu.
 	 */
 	void (*sub_ecaps_updated)(s32 cid, u64 before, u64 after);
 
@@ -979,6 +983,7 @@ struct sched_ext_ops {
 	 *
 	 * @cpu just came online. @cpu will not call ops.enqueue() or
 	 * ops.dispatch(), nor run tasks associated with other CPUs beforehand.
+	 * ops.sub_child_ecaps_updated() runs for @cpu only after this op.
 	 */
 	void (*cpu_online)(s32 cpu);
 
@@ -988,6 +993,7 @@ struct sched_ext_ops {
 	 *
 	 * @cpu is going offline. @cpu will not call ops.enqueue() or
 	 * ops.dispatch(), nor run tasks associated with other CPUs afterwards.
+	 * ops.sub_child_ecaps_updated() runs for @cpu only before this op.
 	 */
 	void (*cpu_offline)(s32 cpu);
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 46b13a1767bb..5fb4a4a06422 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1152,13 +1152,19 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		 * Before the sched's has_op is set, only the parent's op would
 		 * run, and the change would never reach the sched.
 		 * ecaps_enable() enables deliveries on each cpu once has_op is
-		 * set. Until then, a sync leaves the ecaps alone.
+		 * set. Deliveries also need the cpu online to the root, see
+		 * handle_hotplug().
+		 *
+		 * A sync that can't deliver leaves the ecaps alone. It may
+		 * still carry a mark that is cleared below. Don't skip the rest
+		 * of the loop for it.
 		 */
 		old = READ_ONCE(pcpu->ecaps);
-		if (pcpu->flags & SCX_SCHED_PCPU_ECAPS_ENABLED)
-			ecaps = calc_effective_caps(ps, cid);
-		else
+		if (!(pcpu->flags & SCX_SCHED_PCPU_ECAPS_ENABLED) ||
+		    !(rq->scx.flags & SCX_RQ_OPS_ONLINE))
 			ecaps = old;
+		else
+			ecaps = calc_effective_caps(ps, cid);
 		WRITE_ONCE(pcpu->ecaps, ecaps);
 
 		lost = old & ~ecaps;
@@ -1180,7 +1186,8 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		 * covers them.
 		 */
 		if (ecaps != pcpu->reported_ecaps &&
-		    (pcpu->flags & SCX_SCHED_PCPU_ECAPS_ENABLED)) {
+		    (pcpu->flags & SCX_SCHED_PCPU_ECAPS_ENABLED) &&
+		    (rq->scx.flags & SCX_RQ_OPS_ONLINE)) {
 			struct scx_sched *parent = scx_parent(pcpu->sch);
 			struct scx_dsp_ctx *dspc;
 
@@ -1235,15 +1242,42 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 }
 
 /*
- * A cpu came back. Re-seed each sub-sched's ecaps on the cpu's cid. The sync
- * recomputes effective caps from the pshard and fires ops.sub_ecaps_updated()
- * only on a real change since offline.
+ * Called with cpus_read_lock() held before the root is published. The cpus
+ * active now are online to the root without ops.cpu_online(), so they can
+ * deliver ecaps. handle_hotplug() maintains %SCX_RQ_OPS_ONLINE from here on.
+ */
+void scx_init_rq_ops_online(void)
+{
+	s32 cpu;
+
+	lockdep_assert_cpus_held();
+
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		guard(rq_lock_irqsave)(rq);
+		if (cpu_active(cpu))
+			rq->scx.flags |= SCX_RQ_OPS_ONLINE;
+		else
+			rq->scx.flags &= ~SCX_RQ_OPS_ONLINE;
+	}
+}
+
+/*
+ * A cpu came back and the root's ops.cpu_online() has run. Let the cpu deliver
+ * ecaps again and reseed each sub-sched's ecaps on its cid. The sync recomputes
+ * effective caps from the pshard and fires ops.sub_ecaps_updated() only on a
+ * real change since offline.
  */
 void scx_online_ecaps(struct rq *rq)
 {
 	struct scx_sched *root, *pos;
 	s32 cid;
 
+	guard(rq_lock_irqsave)(rq);
+
+	rq->scx.flags |= SCX_RQ_OPS_ONLINE;
+
 	/*
 	 * Only a live hierarchy can have ecaps to reseed. This also keeps the
 	 * table reads below away from an enable that failed before publishing
@@ -1253,8 +1287,6 @@ void scx_online_ecaps(struct rq *rq)
 	if (!scx_enabled())
 		return;
 
-	guard(rq_lock_irqsave)(rq);
-
 	root = scx_root_protected();
 	cid = __scx_cpu_to_cid(cpu_of(rq));
 
@@ -1272,7 +1304,8 @@ void scx_online_ecaps(struct rq *rq)
 }
 
 /*
- * A cpu is going down. Zero each sub-sched's in-effect ecaps so cap checks
+ * A cpu is going down, and the root's ops.cpu_offline() follows. Stop the cpu's
+ * ecaps deliveries and zero each sub-sched's in-effect ecaps so cap checks
  * treat the cpu as capless while offline. Pending and late-queued syncs are
  * discarded at consumption by scx_process_sync_ecaps() while the cpu is
  * inactive. Leave reported_ecaps. Ownership is unchanged, so the
@@ -1301,6 +1334,8 @@ void scx_offline_ecaps(struct rq *rq)
 		if (pcpu->flags & SCX_SCHED_PCPU_ECAPS_REPORT)
 			ecaps_report_done(pcpu);
 	}
+
+	rq->scx.flags &= ~SCX_RQ_OPS_ONLINE;
 }
 
 /*
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 63769205c013..46c7e2a578d1 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -32,6 +32,7 @@ void scx_free_pshards(struct scx_sched *sch);
 s32 scx_alloc_pshards(struct scx_sched *sch);
 void scx_init_root_caps(struct scx_sched *sch);
 void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev);
+void scx_init_rq_ops_online(void);
 void scx_online_ecaps(struct rq *rq);
 void scx_offline_ecaps(struct rq *rq);
 void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu);
@@ -109,6 +110,7 @@ static inline void scx_free_pshards(struct scx_sched *sch) {}
 static inline s32 scx_alloc_pshards(struct scx_sched *sch) { return 0; }
 static inline void scx_init_root_caps(struct scx_sched *sch) {}
 static inline void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev) {}
+static inline void scx_init_rq_ops_online(void) {}
 static inline void scx_online_ecaps(struct rq *rq) {}
 static inline void scx_offline_ecaps(struct rq *rq) {}
 static inline void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu) {}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 37d4808d7f19..c6f1f178e368 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -787,6 +787,13 @@ enum scx_rq_flags {
 	 */
 	SCX_RQ_ONLINE		= 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
+	/*
+	 * Set while the root considers the cpu online, from its
+	 * ops.cpu_online() until its ops.cpu_offline(). ecaps are delivered
+	 * only while it is set. %SCX_RQ_ONLINE follows the core's rq state
+	 * instead, which changes ahead of the root's view on both edges.
+	 */
+	SCX_RQ_OPS_ONLINE	= 1 << 2,
 	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
 	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */
 	SCX_RQ_SUB_IDLE_RENOTIFY	= 1 << 7, /* sub-scheds are owed update_idle() */
-- 
2.56.0

