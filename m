Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D503148CF;
	Sun, 18 Oct 2026 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288799; cv=none; b=bUJ4sXcDcTQkuZtBP8ICdXcfoAhxhGqsoB3DjmZDrTHyOfuc8UNCNzPBBhuh7GOOpe2njXh1mPalQsZ92ikuEmcagg1n7biCaF0Jc2yJdGMl89AGHaoM03wMe+LDlhjAzPK5kRSi+WlcQHOUVBzQbSFwCjLm9qlHo4CNV9GbNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288799; c=relaxed/simple;
	bh=26Krbsbq0EEvc4LeK/hrzKAj4aPYTtfP6ThBlGlkru0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDWZlkYyLsSZ6cUSaLzZ9lVhlnPwozIyxmGp74M5ecGObT3EBnYvIZq8ZmDkH5BMY/32JENXmpseH+n87qrjkkDx+nQ/IKh3tcI8NgNS7Gi00aMZ83GDKdp1IzdapM/89q2/xdLoTtZBZqj6BsEGxbX+qIp8WmPJRrPycbGd76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEOMjFXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEOMjFXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7409A1F000C4;
	Sun, 18 Oct 2026 01:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792288797;
	bh=afQx7TLficYCld0UPk18VJh2xa7+K+TdtF10oKzhaVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QEOMjFXEADxXzmeZsPXORZpHgHRDxRAOQFltNSTv8LtbNrPh4l3P5F1uqDxd7KyDp
	 d7Ah3VoRdUVqitOn/bQIEJaF66/I6GkHX8dBAWMFUz+LPEmeA9fhRCDWn3gqfkl7R9
	 MPg3XDeQudHc4jGSmWQiMDJwEd7POHiSiKXy2dBS76K5j+2nPdbUtnGa0TNm3mSRTC
	 PWaJAyDNaRPPd6+8rKDfXKARrywV4ojNd7iQ98OdLrNBjheiUTOf1hJnUX1c98Gs/w
	 nddurJqtJoM36ocXuF6eUcxBIcnP+7aOvK2XMmjGHfNU55k7d14TFSUEfD3KqcQZ1E
	 mjIgQOXPNRuog==
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
Date: Sat, 17 Oct 2026 15:59:50 -1000
Message-ID: <20261018015952.1499528-5-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018015952.1499528-1-tj@kernel.org>
References: <20261018015952.1499528-1-tj@kernel.org>
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

While at it, fix the SCX_RQ_ONLINE comments, which claimed that the flag
tracks ops.cpu_online() and ops.cpu_offline().

v2: Fix the SCX_RQ_ONLINE comments.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 28 +++++++++++-------
 kernel/sched/ext/internal.h |  6 ++++
 kernel/sched/ext/sub.c      | 57 ++++++++++++++++++++++++++++++-------
 kernel/sched/ext/sub.h      |  2 ++
 kernel/sched/sched.h        | 15 ++++++++--
 5 files changed, 84 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index a34c1452f8c6..c2df269959e4 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2173,11 +2173,11 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 bool scx_rq_online(struct rq *rq)
 {
 	/*
-	 * Test both cpu_active() and %SCX_RQ_ONLINE. %SCX_RQ_ONLINE indicates
-	 * the online state as seen from the BPF scheduler. cpu_active() test
-	 * guarantees that, if this function returns %true, %SCX_RQ_ONLINE will
-	 * stay set until the current scheduling operation is complete even if
-	 * we aren't locking @rq.
+	 * Test both cpu_active() and %SCX_RQ_ONLINE. %SCX_RQ_ONLINE follows the
+	 * core's rq online state. cpu_active() test guarantees that, if this
+	 * function returns %true, %SCX_RQ_ONLINE will stay set until the
+	 * current scheduling operation is complete even if we aren't locking
+	 * @rq.
 	 */
 	return likely((rq->scx.flags & SCX_RQ_ONLINE) && cpu_active(cpu_of(rq)));
 }
@@ -4177,11 +4177,6 @@ static void handle_hotplug(struct rq *rq, bool online)
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
@@ -4210,6 +4205,14 @@ static void handle_hotplug(struct rq *rq, bool online)
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
@@ -4219,6 +4222,9 @@ static void handle_hotplug(struct rq *rq, bool online)
 			 SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
 			 "cpu %d going %s, exiting scheduler", cpu,
 			 online ? "online" : "offline");
+
+	if (online)
+		scx_online_ecaps(rq);
 }
 
 void scx_rq_activate(struct rq *rq)
@@ -8353,6 +8359,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		goto err_disable;
 	}
 
+	scx_init_rq_ops_online();
+
 	/*
 	 * Make the scheduler instance visible. Must be inside cpus_read_lock().
 	 * See handle_hotplug().
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 43aa1354e79b..1dea516b377d 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -927,6 +927,10 @@ struct sched_ext_ops {
 	 * Deliveries continue while this sched bypasses. Its tasks are then on
 	 * the bypass DSQs, where this op can't insert or move them. Deliveries
 	 * stop once this sched is being disabled.
+	 *
+	 * Deliveries for a cid happen only while the root considers the cid's
+	 * cpu online, never before the root's ops.cpu_online() or after its
+	 * ops.cpu_offline() for the cpu.
 	 */
 	void (*sub_ecaps_updated)(s32 cid, u64 before, u64 after);
 
@@ -980,6 +984,7 @@ struct sched_ext_ops {
 	 *
 	 * @cpu just came online. @cpu will not call ops.enqueue() or
 	 * ops.dispatch(), nor run tasks associated with other CPUs beforehand.
+	 * ops.sub_child_ecaps_updated() runs for @cpu only after this op.
 	 */
 	void (*cpu_online)(s32 cpu);
 
@@ -989,6 +994,7 @@ struct sched_ext_ops {
 	 *
 	 * @cpu is going offline. @cpu will not call ops.enqueue() or
 	 * ops.dispatch(), nor run tasks associated with other CPUs afterwards.
+	 * ops.sub_child_ecaps_updated() runs for @cpu only before this op.
 	 */
 	void (*cpu_offline)(s32 cpu);
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index a3f7c0be98ac..2c5853d193d7 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1164,13 +1164,19 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
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
@@ -1192,7 +1198,8 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		 * covers them.
 		 */
 		if (ecaps != pcpu->reported_ecaps &&
-		    (pcpu->flags & SCX_SCHED_PCPU_ECAPS_ENABLED)) {
+		    (pcpu->flags & SCX_SCHED_PCPU_ECAPS_ENABLED) &&
+		    (rq->scx.flags & SCX_RQ_OPS_ONLINE)) {
 			struct scx_sched *parent = scx_parent(pcpu->sch);
 			struct scx_dsp_ctx *dspc;
 
@@ -1247,15 +1254,42 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
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
@@ -1265,8 +1299,6 @@ void scx_online_ecaps(struct rq *rq)
 	if (!scx_enabled())
 		return;
 
-	guard(rq_lock_irqsave)(rq);
-
 	root = scx_root_protected();
 	cid = __scx_cpu_to_cid(cpu_of(rq));
 
@@ -1284,7 +1316,8 @@ void scx_online_ecaps(struct rq *rq)
 }
 
 /*
- * A cpu is going down. Zero each sub-sched's in-effect ecaps so cap checks
+ * A cpu is going down, and the root's ops.cpu_offline() follows. Stop the cpu's
+ * ecaps deliveries and zero each sub-sched's in-effect ecaps so cap checks
  * treat the cpu as capless while offline. Pending and late-queued syncs are
  * discarded at consumption by scx_process_sync_ecaps() while the cpu is
  * inactive. Leave reported_ecaps. Ownership is unchanged, so the
@@ -1313,6 +1346,8 @@ void scx_offline_ecaps(struct rq *rq)
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
index 22a2628a04a2..05cf0f0056e9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -781,12 +781,21 @@ struct cfs_rq {
 /* scx_rq->flags, protected by the rq lock */
 enum scx_rq_flags {
 	/*
-	 * A hotplugged CPU starts scheduling before rq_online_scx(). Track
-	 * ops.cpu_on/offline() state so that ops.enqueue/dispatch() are called
-	 * only while the BPF scheduler considers the CPU to be online.
+	 * Set while the core has the rq online, see rq_online_scx() and
+	 * rq_offline_scx(). A hotplugged cpu starts scheduling before
+	 * rq_online_scx(). ops.enqueue() and ops.dispatch() are called for the
+	 * cpu only while it is set, see scx_rq_online() and
+	 * scx_dispatch_sched().
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

