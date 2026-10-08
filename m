Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03DE547070;
	Thu,  8 Oct 2026 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417836; cv=none; b=FxwXTEnbcPBhJLr6ZcAEXWhqgKxnA513TysiK4+DL1//v6f/KWudmoKUZbrs0koINuxUKEtwRgELFwvdMyuBy/Cmj/QuyJNXnwWky9P/cgrr9iPmaFrEcYn3tzrUC0m2SsFlufQlBYYym1MoHVhxnIcewM+jJSbiWFjsMkXtXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417836; c=relaxed/simple;
	bh=gjhpMuTQSIy0wGWErDRzzWEEw+TVMSDS3favBErTU1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIs2LowqKBhjPaEvkEeDC+SCaywwdp7PhQPxQaTKHKxDSTe7bXaNH8RUGBIHXcCGx02DRlDYnxrkS5uIH11ehlZjzaQRdez2ZMi0ZvBWj67mz/okD5Ucg3YlxpwfqbAqH5RhggOKaKI9hIdTHH77FE03s/jbe4g4WJ4bO5VI+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLMn2ABk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLMn2ABk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C9B1F00893;
	Thu,  8 Oct 2026 00:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791417834;
	bh=YCYMSkB0KU+fS5ycxF3InRvW7mW7pxvCUsocqM16+hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hLMn2ABk9HVlAE3HQunezvTdzRLmMf7+Up2YYkIadczZkb6TMsWPTMpSE383jlXPZ
	 6UwtTladh7zUVIoq2sLeAWuyxjhS6OYuXAlIHbhe7Df+BkDwZp1OE6KLJGO9kDpHva
	 ah1vk/fJcsgstKE74Y8SSrHn84gQ1yk7Yd8Ti3TdNceIr6S7BFfSTvt0uckbNTs/tA
	 e0lRf/hA1Gl/rAIIaUxwX7Nsi/Sa0POxbJlyUhOb6aDZZzviOfPDN9SZeIAQtg2Gdx
	 7T3cYg4x3TGUAAHFWmI6XRfEc2TgyToDM1ID/j/xFMdrINzyAj5qqpRCLdRn/efWGB
	 3kxe+fvRVYhIg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Add ops.sub_child_ecaps_updated() to report a child's effective cap changes
Date: Wed,  7 Oct 2026 14:03:51 -1000
Message-ID: <20261008000352.1689057-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008000352.1689057-1-tj@kernel.org>
References: <20261008000352.1689057-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A grant or revoke only records the target caps. They take effect on a cid at
its next dispatch, and nothing tells the parent when. Until then the parent
cannot act on a revoke: a cid a child ran at a low cpuperf target keeps that
target after PERF is revoked, as the kernel resets targets only at root
enable, and the parent cannot tell when it may schedule on the cid again.

Add ops.sub_child_ecaps_updated(), delivered to the direct parent right
after the child's own ops.sub_ecaps_updated() with the child's cgroup id and
the same before and after caps, in the same dispatch context. Both
deliveries are suppressed while the child is bypassing and replayed together
afterwards. A sub's disable reports the caps it still held as revoked before
the parent's ops.sub_detach(), so the parent needs no record of its own for
a detach. A cpu going offline drops its caps without a report, as for the
child.

The following behavior changes are made to support the deliveries:

- The disable report runs outside the dispatch path, with the clock updated
  and the rq lock unpinned for the op's kfuncs. scx_bpf_sub_dispatch() needs
  a pick in progress and triggers an scx_error() there.

- scx_sub_disable() holds the system sleep lock so that a disable never runs
  during a PM transition. The transition bypasses the whole hierarchy, which
  would suppress the report to a parent that stays enabled.

- A sub enters its enable bypass before it is linked, so that the grants
  queued for it from ops.sub_attach() are consumed while it is bypassed and
  replayed to it and the parent once it is enabled. Otherwise a sync
  consumed before the sub's ops are registered would be delivered to the
  parent but not to the sub, and the shared before value would move past it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |   4 ++
 kernel/sched/ext/internal.h |  29 +++++++-
 kernel/sched/ext/sub.c      | 130 ++++++++++++++++++++++++++++++------
 3 files changed, 140 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 248b39d09ce3..5b68c3b7b3fa 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8921,6 +8921,7 @@ static void sched_ext_ops_cid__enable(struct task_struct *p, struct scx_enable_a
 static void sched_ext_ops__sub_caps_updated(const struct scx_cmask *cmask__arena, u64 caps) {}
 static void sched_ext_ops__sub_ecaps_updated(s32 cid, u64 before, u64 after) {}
 static void sched_ext_ops__sub_cid_sched_updated(s32 cid, u64 sched) {}
+static void sched_ext_ops__sub_child_ecaps_updated(u64 cgid, s32 cid, u64 old, u64 new) {}
 
 static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
 	.select_cid		= sched_ext_ops__select_cpu,
@@ -8956,6 +8957,7 @@ static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
 	.sub_caps_updated	= sched_ext_ops__sub_caps_updated,
 	.sub_ecaps_updated	= sched_ext_ops__sub_ecaps_updated,
 	.sub_cid_sched_updated	= sched_ext_ops__sub_cid_sched_updated,
+	.sub_child_ecaps_updated = sched_ext_ops__sub_child_ecaps_updated,
 	.cid_online		= sched_ext_ops__cpu_online,
 	.cid_offline		= sched_ext_ops__cpu_offline,
 	.init_cids		= sched_ext_ops__init_cids,
@@ -11552,6 +11554,7 @@ static const u32 scx_kf_allow_flags[] = {
 	[SCX_OP_IDX(sub_attach)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(sub_detach)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(sub_ecaps_updated)]	= SCX_KF_ALLOW_ENQUEUE | SCX_KF_ALLOW_DISPATCH,
+	[SCX_OP_IDX(sub_child_ecaps_updated)] = SCX_KF_ALLOW_ENQUEUE | SCX_KF_ALLOW_DISPATCH,
 	[SCX_OP_IDX(cpu_online)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(cpu_offline)]	= SCX_KF_ALLOW_UNLOCKED,
 	[SCX_OP_IDX(init_cids)]		= SCX_KF_ALLOW_UNLOCKED | SCX_KF_ALLOW_INIT_CIDS,
@@ -11696,6 +11699,7 @@ static int __init scx_init(void)
 	CID_OFFSET_MATCH(sub_caps_updated, sub_caps_updated);
 	CID_OFFSET_MATCH(sub_ecaps_updated, sub_ecaps_updated);
 	CID_OFFSET_MATCH(sub_cid_sched_updated, sub_cid_sched_updated);
+	CID_OFFSET_MATCH(sub_child_ecaps_updated, sub_child_ecaps_updated);
 	CID_OFFSET_MATCH(init_cids, init_cids);
 	CID_OFFSET_MATCH(init, init);
 	CID_OFFSET_MATCH(exit, exit);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 8dcab02a38ab..41feed00f1f0 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -932,6 +932,29 @@ struct sched_ext_ops {
 	 */
 	void (*sub_cid_sched_updated)(s32 cid, u64 sched);
 
+	/**
+	 * @sub_child_ecaps_updated: A child's effective caps on a cid changed
+	 * @cgroup_id: cgroup id of the direct child
+	 * @cid: the cid whose effective caps changed
+	 * @before: the child's effective caps as of the last delivery
+	 * @after: the child's effective caps now
+	 *
+	 * A grant or revoke records the target caps and the cid applies them at
+	 * its next dispatch, which is when the child's kfuncs start seeing the
+	 * change. Invoked at that point, right after the child's
+	 * sub_ecaps_updated(). From here on the parent can act on a cap the
+	 * child lost: reset what the child set under it, such as the cpuperf
+	 * target, and schedule on the cid, since the child no longer can. The
+	 * caps a child holds when it is disabled are reported revoked before
+	 * sub_detach() runs. A cpu going offline drops caps without a report.
+	 *
+	 * Runs with the cid's rq lock held, and can perform all operations
+	 * allowed in ops.dispatch() including inserting/moving tasks. The
+	 * disable report runs outside the dispatch path, where a nested sub
+	 * dispatch triggers an scx_error().
+	 */
+	void (*sub_child_ecaps_updated)(u64 cgroup_id, s32 cid, u64 before, u64 after);
+
 	/*
 	 * All online ops must come before ops.cpu_online().
 	 */
@@ -1190,6 +1213,7 @@ struct sched_ext_ops_cid {
 	void (*sub_caps_updated)(const struct scx_cmask *cmask__arena, u64 caps);
 	void (*sub_ecaps_updated)(s32 cid, u64 before, u64 after);
 	void (*sub_cid_sched_updated)(s32 cid, u64 sched);
+	void (*sub_child_ecaps_updated)(u64 cgroup_id, s32 cid, u64 before, u64 after);
 	void (*cid_online)(s32 cid);
 	void (*cid_offline)(s32 cid);
 	s32 (*init_cids)(void);
@@ -1453,7 +1477,10 @@ struct scx_sched_pcpu {
 	struct llist_node	ecaps_to_sync_node;
 	/* owed a forced update_idle() re-notify on this cpu */
 	bool			idle_renotify;
-	/* effective caps as of the last sub_ecaps_updated() delivery */
+	/*
+	 * ecaps as of the last sub_ecaps_updated() and
+	 * sub_child_ecaps_updated() delivery. See __scx_process_sync_ecaps().
+	 */
 	u64			reported_ecaps;
 
 	/*
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 51a53467cf98..acc0171da75e 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1060,6 +1060,28 @@ static void discard_queued_syncs(struct rq *rq)
 		init_llist_node(pos);
 }
 
+/*
+ * Tell @sch's parent that @sch's effective caps on @rq's cid went from @before
+ * to @after. Runs in the dispatch path's context on @rq, which the callers
+ * provide, see __scx_process_sync_ecaps() and clear_all_caps(). The dispatch
+ * buffer is the executing cpu's with @rq as the target. The callers skip a
+ * bypassing parent.
+ */
+static void report_child_ecaps(struct scx_sched *sch, struct rq *rq, u64 before, u64 after)
+{
+	struct scx_sched *parent = scx_parent(sch);
+	struct scx_dsp_ctx *dspc;
+
+	if (!SCX_HAS_OP(parent, sub_child_ecaps_updated))
+		return;
+
+	dspc = &this_cpu_ptr(parent->pcpu)->dsp_ctx;
+	dspc->rq = rq;
+	SCX_CALL_OP(parent, sub_child_ecaps_updated, rq, sch->ops.sub_cgroup_id,
+		    scx_cpu_arg(cpu_of(rq)), before, after);
+	scx_flush_dispatch_buf(parent, rq);
+}
+
 /**
  * __scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
  * @rq: the cid's cpu rq
@@ -1121,27 +1143,35 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		lost_all |= lost;
 
 		/*
-		 * Tell the sched its effective caps on this cid changed. The
-		 * invocation is equivalent to the dispatch path and may drop
-		 * and re-acquire the rq lock temporarily while the rest of
-		 * @batch is held privately, see scx_discard_ecaps_to_sync().
-		 * The dispatch kfuncs resolve their context on the executing
-		 * cpu, which under core scheduling can differ from @rq's cpu,
-		 * so the context is set up there. The rq recorded in it keeps
-		 * the dispatches targeting @rq.
+		 * Tell the sched and its parent that the sched's effective caps
+		 * on this cid changed. The invocations are equivalent to the
+		 * dispatch path and may drop and re-acquire the rq lock
+		 * temporarily while the rest of @batch is held privately, see
+		 * scx_discard_ecaps_to_sync(). The dispatch kfuncs resolve
+		 * their context on the executing cpu, which under core
+		 * scheduling can differ from @rq's cpu, so the context is set
+		 * up there. The rq recorded in it keeps the dispatches
+		 * targeting @rq.
+		 *
+		 * Bypass propagates down the hierarchy, so a sched that isn't
+		 * bypassing has no bypassing parent. Its bypass state gates
+		 * both deliveries. Both report the same before value, so one
+		 * reported_ecaps covers them.
 		 */
-		if (ecaps != pcpu->reported_ecaps &&
-		    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
-		    !scx_bypassing(pcpu->sch, cpu)) {
-			struct scx_dsp_ctx *dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
+		if (ecaps != pcpu->reported_ecaps && !scx_bypassing(pcpu->sch, cpu)) {
+			struct scx_dsp_ctx *dspc;
 
-			dspc->rq = rq;
 			/* stash @prev so nested dispatches can access it */
 			rq->scx.sub_dispatch_prev = prev;
-			SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq, scx_cpu_arg(cpu),
-				    pcpu->reported_ecaps, ecaps);
+			if (SCX_HAS_OP(pcpu->sch, sub_ecaps_updated)) {
+				dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
+				dspc->rq = rq;
+				SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq,
+					    scx_cpu_arg(cpu), pcpu->reported_ecaps, ecaps);
+				scx_flush_dispatch_buf(pcpu->sch, rq);
+			}
+			report_child_ecaps(pcpu->sch, rq, pcpu->reported_ecaps, ecaps);
 			rq->scx.sub_dispatch_prev = NULL;
-			scx_flush_dispatch_buf(pcpu->sch, rq);
 			pcpu->reported_ecaps = ecaps;
 		}
 
@@ -1269,10 +1299,12 @@ void scx_offline_ecaps(struct rq *rq)
 /*
  * Clear every cap @sch holds. The pshard caps go first as they are the source a
  * pending sync recomputes ecaps from. ecaps are then zeroed directly for the
- * cap checks.
+ * cap checks, and what @sch held is reported revoked to the parent before
+ * ops.sub_detach().
  */
 static void clear_all_caps(struct scx_sched *sch)
 {
+	struct scx_sched *parent = scx_parent(sch);
 	s32 si, cpu;
 	u32 cap_bit;
 
@@ -1289,8 +1321,37 @@ static void clear_all_caps(struct scx_sched *sch)
 	}
 
 	for_each_possible_cpu(cpu) {
-		guard(rq_lock_irqsave)(cpu_rq(cpu));
-		WRITE_ONCE(per_cpu_ptr(sch->pcpu, cpu)->ecaps, 0);
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+		struct rq *rq = cpu_rq(cpu);
+
+		scoped_guard (rq_lock_irqsave, rq) {
+			bool parent_bypassing = scx_bypassing(parent, cpu);
+
+			WRITE_ONCE(pcpu->ecaps, 0);
+
+			/*
+			 * A bypassing parent is exiting and does not need the
+			 * report. scx_sub_disable() does not run during a PM
+			 * transition, so a parent that stays enabled is never
+			 * bypassing here.
+			 */
+			WARN_ON_ONCE(parent_bypassing &&
+				     atomic_read(&parent->exit_kind) == SCX_EXIT_NONE);
+			if (pcpu->reported_ecaps && !parent_bypassing) {
+				/*
+				 * The op runs outside the dispatch path. Its
+				 * kfuncs need the clock updated for a cpuperf
+				 * write and the lock unpinned so that an insert
+				 * or move can switch rqs. A nested sub dispatch
+				 * triggers an scx_error() here, see
+				 * scx_bpf_sub_dispatch().
+				 */
+				update_rq_clock(rq);
+				rq_unpin_lock(rq, &scope.rf);
+				report_child_ecaps(sch, rq, pcpu->reported_ecaps, 0);
+				rq_repin_lock(rq, &scope.rf);
+			}
+		}
 	}
 }
 
@@ -1652,6 +1713,7 @@ void scx_sub_disable(struct scx_sched *sch)
 	struct scx_sched *parent = scx_parent(sch);
 	struct scx_task_iter sti;
 	struct task_struct *p;
+	unsigned int sleep_flags;
 	int ret;
 
 	/*
@@ -1662,6 +1724,14 @@ void scx_sub_disable(struct scx_sched *sch)
 	scx_bypass(sch, true);
 	drain_descendants(sch);
 
+	/*
+	 * A PM transition bypasses the whole hierarchy. A disable during one
+	 * would suppress the parent's ops.sub_child_ecaps_updated() with
+	 * nothing left to replay it, see clear_all_caps(). Taken after the
+	 * drain so that the descendants' disables can take it first.
+	 */
+	sleep_flags = lock_system_sleep();
+
 	/*
 	 * Here, every runnable task is guaranteed to make forward progress and
 	 * we can safely use blocking synchronization constructs. Actually
@@ -1799,6 +1869,8 @@ void scx_sub_disable(struct scx_sched *sch)
 			    &sub_detach_args);
 	}
 
+	unlock_system_sleep(sleep_flags);
+
 	scx_log_sched_disable(sch);
 
 	if (sch->ops.exit)
@@ -1940,6 +2012,15 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_disable;
 
+	/*
+	 * Bypass before @sch is linked and grants can reach it. The syncs
+	 * queued by those grants, from the parent's ops.sub_attach() or
+	 * elsewhere, are consumed while @sch is still bypassed, and the
+	 * unbypass replay below delivers them to @sch and to the parent once
+	 * @sch is live.
+	 */
+	scx_bypass(sch, true);
+
 	ret = scx_link_sched(sch);
 	if (ret)
 		goto err_disable;
@@ -1985,8 +2066,6 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	}
 	sch->sub_attached = true;
 
-	scx_bypass(sch, true);
-
 	for (i = SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
 		if (((void (**)(void))ops)[i])
 			set_bit(i, sch->has_op);
@@ -2378,7 +2457,8 @@ __bpf_kfunc_start_defs();
  * move tasks from dispatch queues to the local runqueue.
  *
  * Returns: true on success, false if cgroup_id is invalid, not a direct
- * child, or caller lacks dispatch permission.
+ * child, or caller lacks dispatch permission. A call outside the dispatch path,
+ * from a disable report, triggers an scx_error().
  */
 __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *aux)
 {
@@ -2390,6 +2470,12 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
 	if (unlikely(!parent))
 		return false;
 
+	/* a nested dispatch needs the pick in progress and its @prev */
+	if (unlikely(!(rq->scx.flags & SCX_RQ_IN_DISPATCH))) {
+		scx_error(parent, "scx_bpf_sub_dispatch() outside the dispatch path");
+		return false;
+	}
+
 	child = scx_find_sub_sched(cgroup_id);
 
 	if (unlikely(!child))
-- 
2.55.0

