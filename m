Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142E2DECC5
	for <sched-ext@lists.linux.dev>; Fri, 19 Dec 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136858; cv=none; b=ns8a8CLq8hHh3/XtFRigSX8wQVOKMY6KJ3+WetibR3tQTuMbALOOHSve4p4lE5ObX5V8xI3Q/H8O9DXMCtQ81J4bzTh8ghO4eJKZVrvz4dL1gtFlDQaX0yk0uLSKlLOTCUfL3Eb6ZZt7vwNHe7PBySyZ5rhWLcSkEAkz1Dzk+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136858; c=relaxed/simple;
	bh=nxUYB9bqmYOl9fM9HYD5HSqTmkyt29pKiLs8ahnoMS4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lLIgE03ZvyGWEzSaNq3q5k/sdvbfEQllDTcLSm2NU47RliRITeTY0EsdCaX2SIR+iS7rzjNYmMtUULp8AEgKbBGPGl8hwOfvz/gCQp47gFqV+vPvsNsE+kWci627nC3eUsma5M3Nm+4oaH1uVQ3pusQ4+20IqcMoPgWrwuZx9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n+Cbivw4; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n+Cbivw4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766136849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=Rv6Y57lYMKS6k2RZidGxtPimU5NCiVa3mvKMYxltF44=;
	b=n+Cbivw4vK5I4T+ANPf1ptF0ukn3WO88OFFclX/soUVxmlNRtEhNNzz+B/q2B9qKODfdOJ
	CJA5mCLMReiZf8c2Qa+2QG4TsYkIsDmT37iWhlYCgFVUvqjKCKfpcatmwB3skt5oVrISjZ
	LWfHT1fkiAfkvu318IkzHiyYmKfDJBM=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] sched_ext: Fix some comments in ext.c
Date: Fri, 19 Dec 2025 17:34:04 +0800
Message-Id: <20251219093404.382-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

This commit update balance_scx() in the comments to balance_one().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7a53d1cf8e82..5ebf8a740847 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1577,7 +1577,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	 *
 	 * @p may go through multiple stopping <-> running transitions between
 	 * here and put_prev_task_scx() if task attribute changes occur while
-	 * balance_scx() leaves @rq unlocked. However, they don't contain any
+	 * balance_one() leaves @rq unlocked. However, they don't contain any
 	 * information meaningful to the BPF scheduler and can be suppressed by
 	 * skipping the callbacks if the task is !QUEUED.
 	 */
@@ -2372,7 +2372,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 	 * preempted, and it regaining control of the CPU.
 	 *
 	 * ->cpu_release() complements ->cpu_acquire(), which is emitted the
-	 *  next time that balance_scx() is invoked.
+	 *  next time that balance_one() is invoked.
 	 */
 	if (!rq->scx.cpu_released) {
 		if (SCX_HAS_OP(sch, cpu_release)) {
@@ -2478,7 +2478,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	}
 
 	/*
-	 * If balance_scx() is telling us to keep running @prev, replenish slice
+	 * If balance_one() is telling us to keep running @prev, replenish slice
 	 * if necessary and keep running @prev. Otherwise, pop the first one
 	 * from the local DSQ.
 	 */
@@ -4025,7 +4025,7 @@ static DEFINE_TIMER(scx_bypass_lb_timer, scx_bypass_lb_timerfn);
  *
  * - ops.dispatch() is ignored.
  *
- * - balance_scx() does not set %SCX_RQ_BAL_KEEP on non-zero slice as slice
+ * - balance_one() does not set %SCX_RQ_BAL_KEEP on non-zero slice as slice
  *   can't be trusted. Whenever a tick triggers, the running task is rotated to
  *   the tail of the queue with core_sched_at touched.
  *
@@ -6069,7 +6069,7 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 		/*
 		 * A successfully consumed task can be dequeued before it starts
 		 * running while the CPU is trying to migrate other dispatched
-		 * tasks. Bump nr_tasks to tell balance_scx() to retry on empty
+		 * tasks. Bump nr_tasks to tell balance_one() to retry on empty
 		 * local DSQ.
 		 */
 		dspc->nr_tasks++;
-- 
2.17.1

