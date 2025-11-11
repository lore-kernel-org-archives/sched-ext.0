Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16B328278;
	Tue, 11 Nov 2025 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888703; cv=none; b=HmfTT9nixb7cRvbAAk6T5/KGWfcO3ewtdZJrXzFGzEWfE2aMEMuHtwnE+XjRYLBj+8Cg56C3VgH6a1h3G1+IyN1Arr0jyqGo4yOxGhoxTQXnHW20oXrpLbycHG3zWmlm8GT3zahYpZeTA+WGdDjEWNFkYP4GU2/zUC120qMKyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888703; c=relaxed/simple;
	bh=KbWeYc4WfB1h7Kb2jw5inRSnBHtZAXgPWO8if/DfbdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjenqcGCIKk7n7IwfxG8Q5v0qwGuLzae4ZA2GxwQhJDyOV1FGiKZivbx+M4fO2TXWc3YTZHkGd/C5UxPWFC0TXZO9YGDtGCqcCYYjoFrcRMs93gyAq/3Llfk9IIAFvsKsFAlWnEL8alGUHSB+sGIUH+JSt03XZLJlpdrFP0tsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ksb6Rkwp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ksb6Rkwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD841C4CEF7;
	Tue, 11 Nov 2025 19:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888702;
	bh=KbWeYc4WfB1h7Kb2jw5inRSnBHtZAXgPWO8if/DfbdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ksb6RkwpmGRDTkLpweVGc2Sico2jvwz+rZB8FBxFVIeO4rICqtQqj7pM8BlcSR8HF
	 9/C66Is8w2V8yr/ZUg3CXWHdohPKTwYtg1H2im3Wy4SURe8ENQpBkTtUrtUOV2+lAc
	 rpk9OhiLKwHEsVc+7a8FId6vekHFU1otl6giEv1yACdkJ2HDACVKWLgIPozZzmnqgR
	 7x/8aQtnh6sUF7MFurFCRbC7ZwFzRs8n4DBBa2Di/d4SqXfs7Vc8EeIK1+gGHqvQ0Y
	 ctGr8z1zQi5ssIN21vsWqNqCnus4FUEa6igvyPSmM49bA7b39l4qgD+2DrlM1U6Rgv
	 MgWkwKfrkzGiw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH 05/13] sched_ext: Exit dispatch and move operations immediately when aborting
Date: Tue, 11 Nov 2025 09:18:08 -1000
Message-ID: <20251111191816.862797-6-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

62dcbab8b0ef ("sched_ext: Avoid live-locking bypass mode switching") introduced
the breather mechanism to inject delays during bypass mode switching. It
maintains operation semantics unchanged while reducing lock contention to avoid
live-locks on large NUMA systems.

However, the breather only activates when exiting the scheduler, so there's no
need to maintain operation semantics. Simplify by exiting dispatch and move
operations immediately when scx_aborting is set. In consume_dispatch_q(), break
out of the task iteration loop. In scx_dsq_move(), return early before
acquiring locks.

This also fixes cases the breather mechanism cannot handle. When a large system
has many runnable threads affinitized to different CPU subsets and the BPF
scheduler places them all into a single DSQ, many CPUs can scan the DSQ
concurrently for tasks they can run. This can cause DSQ and RQ locks to be held
for extended periods, leading to various failure modes. The breather cannot
solve this because once in the consume loop, there's no exit. The new mechanism
fixes this by exiting the loop immediately.

The bypass DSQ is exempted to ensure the bypass mechanism itself can make
progress.

v2: Use READ_ONCE() when reading scx_aborting (Andrea Righi).

Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 62 ++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5da699cacde1..56a6d453543a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1818,48 +1818,11 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	return dst_rq;
 }
 
-/*
- * A poorly behaving BPF scheduler can live-lock the system by e.g. incessantly
- * banging on the same DSQ on a large NUMA system to the point where switching
- * to the bypass mode can take a long time. Inject artificial delays while the
- * bypass mode is switching to guarantee timely completion.
- */
-static void scx_breather(struct rq *rq)
-{
-	u64 until;
-
-	lockdep_assert_rq_held(rq);
-
-	if (likely(!READ_ONCE(scx_aborting)))
-		return;
-
-	raw_spin_rq_unlock(rq);
-
-	until = ktime_get_ns() + NSEC_PER_MSEC;
-
-	do {
-		int cnt = 1024;
-		while (READ_ONCE(scx_aborting) && --cnt)
-			cpu_relax();
-	} while (READ_ONCE(scx_aborting) &&
-		 time_before64(ktime_get_ns(), until));
-
-	raw_spin_rq_lock(rq);
-}
-
 static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			       struct scx_dispatch_q *dsq)
 {
 	struct task_struct *p;
 retry:
-	/*
-	 * This retry loop can repeatedly race against scx_bypass() dequeueing
-	 * tasks from @dsq trying to put the system into the bypass mode. On
-	 * some multi-socket machines (e.g. 2x Intel 8480c), this can live-lock
-	 * the machine into soft lockups. Give a breather.
-	 */
-	scx_breather(rq);
-
 	/*
 	 * The caller can't expect to successfully consume a task if the task's
 	 * addition to @dsq isn't guaranteed to be visible somehow. Test
@@ -1873,6 +1836,17 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 	nldsq_for_each_task(p, dsq) {
 		struct rq *task_rq = task_rq(p);
 
+		/*
+		 * This loop can lead to multiple lockup scenarios, e.g. the BPF
+		 * scheduler can put an enormous number of affinitized tasks into
+		 * a contended DSQ, or the outer retry loop can repeatedly race
+		 * against scx_bypass() dequeueing tasks from @dsq trying to put
+		 * the system into the bypass mode. This can easily live-lock the
+		 * machine. If aborting, exit from all non-bypass DSQs.
+		 */
+		if (unlikely(READ_ONCE(scx_aborting)) && dsq->id != SCX_DSQ_BYPASS)
+			break;
+
 		if (rq == task_rq) {
 			task_unlink_from_dsq(p, dsq);
 			move_local_task_to_local_dsq(p, 0, dsq, rq);
@@ -5636,6 +5610,13 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
+	/*
+	 * If the BPF scheduler keeps calling this function repeatedly, it can
+	 * cause similar live-lock conditions as consume_dispatch_q().
+	 */
+	if (unlikely(READ_ONCE(scx_aborting)))
+		return false;
+
 	/*
 	 * Can be called from either ops.dispatch() locking this_rq() or any
 	 * context where no rq lock is held. If latter, lock @p's task_rq which
@@ -5656,13 +5637,6 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 		raw_spin_rq_lock(src_rq);
 	}
 
-	/*
-	 * If the BPF scheduler keeps calling this function repeatedly, it can
-	 * cause similar live-lock conditions as consume_dispatch_q(). Insert a
-	 * breather if necessary.
-	 */
-	scx_breather(src_rq);
-
 	locked_rq = src_rq;
 	raw_spin_lock(&src_dsq->lock);
 
-- 
2.51.2

