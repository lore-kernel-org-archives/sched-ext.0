Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FC3B0583;
	Thu,  8 Oct 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451953; cv=none; b=BVreeQZXm7mfUNsg+wzimKestE5qIkjDG6vsWlpjXxMKD5fl559gs6+1Om3NfGTf79k1k9wW5fipWwkheKZgowIqcQ34zDveEAUtWickVJp5ErRUEDzJJeTdQAN4aggdxsjt+F0EFmKajRovY7L5I8UJ7nnb998EvjYeKYANB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451953; c=relaxed/simple;
	bh=ZAp4lXQfT/SLcePpeZpFsnGwSEzcvefv7yLDGD3rlJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTerv63Fhw0aCI5a3OKJ1HSlC22kGJzG1VxI8ULZu9db14BfEqzOkFIH4nDSu1frbrFjGn8nS1K63OkXCFDv9dSPjSGk39ettYYm1h2ZhP8gbjjIf2QsmvJwjlf1TPQihFbDuAFVWVebTD62FR5wJzKc8ETHixctUo/bg6LQSdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsFWjLGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsFWjLGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBCD1F00893;
	Thu,  8 Oct 2026 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791451950;
	bh=38jfiXk1+eqKe9ZIHpoqLfh1EL4oPonm1c7n7sZhFHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XsFWjLGHWJNnOlnhc5hvx7EGRUdFUAFUO5GExkFDuUFhtzvdtL3nT6zneyzSiI7if
	 rEO8bsy3Ga5FbNxkkLpPclANNbq2rFE6s0/7VwcGd8JoHVUSgEeo/A3V8teTYpYYHb
	 g2LUyTULEwoKWvx+k93BJ81NDZ0M0SyIyeyuniIDce1ZpKHsjVD3urkz2uM3VLNhsA
	 KUoaMyJ43qULnKJOQ/jol25p8jUObsUM6SIi1F/FXO+IcQHS/ETeQP+1xCQsOGwUWz
	 Qb/LEXnVANRpWPyazQ20pD5dki9mxuZ3WDhFPeLlRNs/P6Vb0L60El3IkAmPiqnEp6
	 5I9aJtQlS3Itw==
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
Date: Wed,  7 Oct 2026 23:32:27 -1000
Message-ID: <20261008093228.2015427-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008093228.2015427-1-tj@kernel.org>
References: <20261008093228.2015427-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A grant or revoke only records the target caps. They take effect on a cid at
its next dispatch, and nothing tells the parent when. Without that the
parent cannot act on a revoke: a child that ran a cid at a low cpuperf
target leaves the target there when PERF is revoked, as the kernel resets
targets only at root enable. Nor can the parent tell when it may schedule on
the cid again.

Add ops.sub_child_ecaps_updated(), delivered to the direct parent right
after the child's own ops.sub_ecaps_updated() with the child's cgroup id and
the same before and after caps, in the same dispatch context. Both
deliveries are suppressed while the child is bypassing and replayed together
afterwards. A disabled child reports nothing: ops.sub_detach() is where the
parent restores what it had delegated.

A sub is now bypassed before it is linked, so that the grants queued for it
from ops.sub_attach() are consumed while it is bypassed and replayed to it
and the parent once it is enabled. Otherwise a sync consumed before the
sub's ops are registered would reach the parent but never the sub.

v2: Drop the disable report with its sleep lock and nested-dispatch gate,
the parent restores from ops.sub_detach() instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  4 +++
 kernel/sched/ext/internal.h | 30 +++++++++++++++++--
 kernel/sched/ext/sub.c      | 59 ++++++++++++++++++++++++++-----------
 3 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 248b39d09ce3..2095b78b6bf6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8921,6 +8921,7 @@ static void sched_ext_ops_cid__enable(struct task_struct *p, struct scx_enable_a
 static void sched_ext_ops__sub_caps_updated(const struct scx_cmask *cmask__arena, u64 caps) {}
 static void sched_ext_ops__sub_ecaps_updated(s32 cid, u64 before, u64 after) {}
 static void sched_ext_ops__sub_cid_sched_updated(s32 cid, u64 sched) {}
+static void sched_ext_ops__sub_child_ecaps_updated(u64 cgroup_id, s32 cid, u64 before, u64 after) {}
 
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
index 8dcab02a38ab..2b637973244c 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -878,8 +878,9 @@ struct sched_ext_ops {
 	 * @args: argument container, see the struct definition
 	 *
 	 * The sub-scheduler holds no caps by this point and can no longer
-	 * affect any cid. Whatever was delegated to it, e.g. cpuperf targets,
-	 * is the parent's to restore here.
+	 * affect any cid. Its caps went away without a
+	 * sub_child_ecaps_updated() report, so whatever was delegated to it,
+	 * e.g. cpuperf targets, is the parent's to restore here.
 	 */
 	void (*sub_detach)(struct scx_sub_detach_args *args);
 
@@ -932,6 +933,25 @@ struct sched_ext_ops {
 	 */
 	void (*sub_cid_sched_updated)(s32 cid, u64 sched);
 
+	/**
+	 * @sub_child_ecaps_updated: A child's effective caps on a cid changed
+	 * @cgroup_id: cgroup id of the direct child
+	 * @cid: the cid whose effective caps changed
+	 * @before: the child's effective caps as of the last delivery
+	 * @after: the child's effective caps now
+	 *
+	 * Invoked right after the child's sub_ecaps_updated(), once a grant or
+	 * revoke is in effect on the cpu. From here on the parent can act on a
+	 * cap the child lost, e.g. reset the cpuperf target or schedule on the
+	 * cid. A detaching child's caps go away without a report, see
+	 * sub_detach(). A cpu going offline drops caps without a report.
+	 *
+	 * Runs in dispatch context with rq lock held, and can perform all
+	 * operations allowed in ops.dispatch() including inserting/moving
+	 * tasks.
+	 */
+	void (*sub_child_ecaps_updated)(u64 cgroup_id, s32 cid, u64 before, u64 after);
+
 	/*
 	 * All online ops must come before ops.cpu_online().
 	 */
@@ -1190,6 +1210,7 @@ struct sched_ext_ops_cid {
 	void (*sub_caps_updated)(const struct scx_cmask *cmask__arena, u64 caps);
 	void (*sub_ecaps_updated)(s32 cid, u64 before, u64 after);
 	void (*sub_cid_sched_updated)(s32 cid, u64 sched);
+	void (*sub_child_ecaps_updated)(u64 cgroup_id, s32 cid, u64 before, u64 after);
 	void (*cid_online)(s32 cid);
 	void (*cid_offline)(s32 cid);
 	s32 (*init_cids)(void);
@@ -1453,7 +1474,10 @@ struct scx_sched_pcpu {
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
index 51a53467cf98..c7c95661280b 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1121,27 +1121,43 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
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
+		 * bypassing has no bypassing parent. The child's bypass state
+		 * gates both deliveries. Both report the same before value, so
+		 * one reported_ecaps covers them.
 		 */
-		if (ecaps != pcpu->reported_ecaps &&
-		    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) &&
-		    !scx_bypassing(pcpu->sch, cpu)) {
-			struct scx_dsp_ctx *dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
+		if (ecaps != pcpu->reported_ecaps && !scx_bypassing(pcpu->sch, cpu)) {
+			struct scx_sched *parent = scx_parent(pcpu->sch);
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
+			if (SCX_HAS_OP(parent, sub_child_ecaps_updated)) {
+				dspc = &this_cpu_ptr(parent->pcpu)->dsp_ctx;
+				dspc->rq = rq;
+				SCX_CALL_OP(parent, sub_child_ecaps_updated, rq,
+					    pcpu->sch->ops.sub_cgroup_id, scx_cpu_arg(cpu),
+					    pcpu->reported_ecaps, ecaps);
+				scx_flush_dispatch_buf(parent, rq);
+			}
 			rq->scx.sub_dispatch_prev = NULL;
-			scx_flush_dispatch_buf(pcpu->sch, rq);
 			pcpu->reported_ecaps = ecaps;
 		}
 
@@ -1940,6 +1956,15 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_disable;
 
+	/*
+	 * Bypass before @sch is linked and grants can reach it. The parent's
+	 * delivery advances reported_ecaps, so a sync consumed before @sch's
+	 * ops are registered would reach the parent and never be replayed to
+	 * @sch. While bypassed, the syncs are consumed without a delivery and
+	 * replayed to both at unbypass.
+	 */
+	scx_bypass(sch, true);
+
 	ret = scx_link_sched(sch);
 	if (ret)
 		goto err_disable;
@@ -1985,8 +2010,6 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	}
 	sch->sub_attached = true;
 
-	scx_bypass(sch, true);
-
 	for (i = SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
 		if (((void (**)(void))ops)[i])
 			set_bit(i, sch->has_op);
-- 
2.55.0

