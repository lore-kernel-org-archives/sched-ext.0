Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4961A683C;
	Sun, 16 Aug 2026 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838732; cv=none; b=oeFfB3qg26Nzh72DlJ0PZ4U60nDQSRsD6O2qnIXM2VehYPW46lmHtf+Hq9Wb0ITBD3Wj/RXb61Bf9bfI7Sj1quvkKNw6MQl6hTXXU8d/m5kghoWK9zprreVowTH/+ijrlvdwTKQdofwD9l0V0HRz2PBrUrLypw5EdWD3/IuGGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838732; c=relaxed/simple;
	bh=rbWLmVE5l2tIulZFGZ4/Wd0yxEYz08AvjnUwRpCBsmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcqZindJqOXJp54IOA1S08nROBn+rQgMKBa37BY1SYzlgm4PvEvysBg50cB/+CZaIMUuOIVGWKN5LRMSbAC5j4bgmfaUXIYYKEJC5pet/TKperni32ArMmg1n7VnNihLCciBZfGuvukVfl34lR1Hw6pH9bm53cTi8JLfrwePx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNW19NV/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNW19NV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04D81F00A3A;
	Sun, 16 Aug 2026 00:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786838730;
	bh=PDRQPE13RmPD8tuBtIa2KGyrJAIA9Q4X91AZW4wX93A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PNW19NV/A2/OlKZco4nlnct9Hssg3220cGFYTneL27l4q7XRPKbQ26HQqKUrSTxMG
	 hw+yzTd3Ez7SOPzvd3QNRCeTc/LiWY/cFnLWHRgeNTXkJWb1lR4X7YU2ktALzQOtln
	 rvyIPb1Z8a09JRvXZl8F3orNQnIo3ZbWPPugZLh0gY2wc733WHMK0/qDWD952YoNI2
	 88ZCx19XwiB7X4m8/+xHrulutvCNP7Nv5eV13BRVHQIp3qe8LjYRBf9pgWWVeEPhdR
	 ZVvL7CoDcjc1gj4RptJcgCbs9oMNkjQ0sCB+Ma7iomgqqiYD1oUqNzWfAOerE5iPBY
	 ovpCdILdWZrBA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] sched_ext: Make core-sched task ordering hierarchy-aware
Date: Sat, 15 Aug 2026 14:05:26 -1000
Message-ID: <20260816000527.988170-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816000527.988170-1-tj@kernel.org>
References: <20260816000527.988170-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With sub-schedulers, tasks of different schedulers routinely share rqs and
SMT siblings, but scx_prio_less() consults ops.core_sched_before() only when
both tasks belong to the same scheduler. Every pair spanning two schedulers
falls back to the default ordering, so no scheduler can express ordering
across a scheduler boundary, including a root over its sub-schedulers'
tasks.

Order a pair spanning schedulers by the nearest common ancestor that
implements ops.core_sched_before(): both tasks are in its subtree, making
this the one op where a scheduler is called on tasks it delegated to its
sub-schedulers and may not be scheduling anymore. Same-scheduler pairs keep
using the owning scheduler's op so a parent never orders inside a subtree it
delegated. The op is skipped when the deciding scheduler is bypassing on
either task's CPU.

Update scx_qmap to fall back to the kernel's default ordering when handed a
delegated task it has no task_ctx for.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c         | 38 +++++++++++++++++++++++++++-------
 kernel/sched/ext/internal.h    |  5 +++++
 tools/sched_ext/scx_qmap.bpf.c | 23 +++++++++++++-------
 3 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3df2e084d580..f14e3fc69644 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3459,10 +3459,16 @@ void ext_server_init(struct rq *rq)
  * usual sched_class'es and needs to find out the expected task ordering. For
  * SCX, core-sched calls this function to interrogate the task ordering.
  *
- * Unless overridden by ops.core_sched_before(), the default task ordering runs
- * the task which has been waiting longer first. A running task counts as the
- * most recently serviced and orders after every waiting task. Waiting tasks are
- * compared by @p->scx.runnable_at.
+ * A pair of tasks owned by one scheduler is ordered by the owner's
+ * ops.core_sched_before(). A pair spanning two schedulers is ordered by their
+ * nearest common ancestor which implements the op - the one case where the op
+ * is called on tasks that the scheduler delegated to its sub-schedulers and may
+ * not be scheduling anymore.
+ *
+ * When neither applies, or the deciding scheduler is bypassing on either task's
+ * CPU, the default ordering runs the task which has been waiting longer first.
+ * A running task counts as the most recently serviced and orders after every
+ * waiting task. Waiting tasks are compared by @p->scx.runnable_at.
  *
  * Return: %true if @a should run after @b.
  */
@@ -3471,8 +3477,26 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 {
 	struct scx_sched *sch_a = scx_task_sched(a);
 	struct scx_sched *sch_b = scx_task_sched(b);
+	struct scx_sched *sch = NULL;
 	bool a_running, b_running;
 
+	if (sch_a == sch_b) {
+		if (SCX_HAS_OP(sch_a, core_sched_before))
+			sch = sch_a;
+	} else {
+		s32 level;
+
+		for (level = min(sch_a->level, sch_b->level); level >= 0; level--) {
+			struct scx_sched *anc = sch_a->ancestors[level];
+
+			if (anc == sch_b->ancestors[level] &&
+			    SCX_HAS_OP(anc, core_sched_before)) {
+				sch = anc;
+				break;
+			}
+		}
+	}
+
 	/*
 	 * scx_prio_less() returns whether @a should run after @b while
 	 * ops.core_sched_before() returns whether its first argument should run
@@ -3482,10 +3506,8 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	 * calling ops.core_sched_before(). Accesses are controlled by the
 	 * verifier.
 	 */
-	if (sch_a == sch_b && SCX_HAS_OP(sch_a, core_sched_before) &&
-	    !scx_bypassing(sch_a, task_cpu(a)))
-		return SCX_CALL_OP_2TASKS_RET(sch_a, core_sched_before,
-					      task_rq(a),
+	if (sch && !scx_bypassing(sch, task_cpu(a)) && !scx_bypassing(sch, task_cpu(b)))
+		return SCX_CALL_OP_2TASKS_RET(sch, core_sched_before, task_rq(a),
 					      (struct task_struct *)b,
 					      (struct task_struct *)a);
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index c91296c53225..fa20cac3ab61 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -521,6 +521,11 @@ struct sched_ext_ops {
 	 * the BPF scheduler. Should return %true if @a should run before @b.
 	 * %false if there's no required ordering or @b should run before @a.
 	 *
+	 * In a scheduler hierarchy, a pair spanning two schedulers is ordered
+	 * by the nearest common ancestor implementing this op, so the op may be
+	 * called on tasks that the scheduler delegated to its sub-schedulers
+	 * and is not scheduling anymore. See scx_prio_less().
+	 *
 	 * If not specified, the default is ordering them according to when they
 	 * became runnable.
 	 */
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 723f45fe0cbc..a5f666716d80 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -866,16 +866,11 @@ void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
  * The distance from the head of the queue scaled by the weight of the queue.
  * The lower the number, the older the task and the higher the priority.
  */
-static s64 task_qdist(struct task_struct *p)
+static s64 task_qdist(struct task_struct *p, task_ctx_t *taskc)
 {
 	int idx = weight_to_idx(p->scx.weight);
-	task_ctx_t *taskc;
 	s64 qdist;
 
-	taskc = lookup_task_ctx(p);
-	if (!taskc)
-		return 0;
-
 	qdist = taskc->core_sched_seq - qa.core_sched_head_seqs[idx];
 
 	/*
@@ -900,7 +895,21 @@ static s64 task_qdist(struct task_struct *p)
 bool BPF_STRUCT_OPS(qmap_core_sched_before,
 		    struct task_struct *a, struct task_struct *b)
 {
-	return task_qdist(a) < task_qdist(b);
+	task_ctx_t *taskc_a = lookup_task_ctx(a);
+	task_ctx_t *taskc_b = lookup_task_ctx(b);
+
+	/*
+	 * A task delegated to a sub-scheduler has no task_ctx here. Order such
+	 * pairs by the kernel's default ordering - a running task after every
+	 * waiting task, then by runnable_at.
+	 */
+	if (!taskc_a || !taskc_b) {
+		if (a->on_cpu != b->on_cpu)
+			return b->on_cpu;
+		return time_before(a->scx.runnable_at, b->scx.runnable_at);
+	}
+
+	return task_qdist(a, taskc_a) < task_qdist(b, taskc_b);
 }
 
 /*
-- 
2.55.0

