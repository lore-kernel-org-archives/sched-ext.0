Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060287;
	b=IXq/QNXon9B260pvyYwS29xzK34sqNRBxYnGlxB1tULC8hO5keiIonDVIgv5zQBH+VnL
	 fu76p53PR9uf2aX9i4wX2BB6SA6InIkuav4R5EjHqeijWTtQ6JBhPSXb97F/tCGHAU4u5
	 ZtHW8Gwss8V4lCWZ2e26Idt5cJce7JYuexkRYBLkKEtpNhZlFWTSLuX5kO0+ZoHhc7cFV
	 +uTcnQ/lg25QJWKWjnE2A1OjbK5m3jvDf+1MlzvifFRqKkYcGPz8z0DIIyizyUYMLbiVL
	 MWuhAUce/PwLWblheDSgBbNXRyizQ0vjuUtCqtoxFFYl+Vy6bgSLpq4uaHpQTvPbJKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060287;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yMuhcWzIibzjRSnhzjjg9lAT62fPTo5Jq89DVpXRPI8=;
	b=2Nl0vcGR2iTEi5KGW0FV0tShlGfvy9QTdJ1bdhTIx++Wbp2U/hZL4dqN/xR9d2LjziK5
	 suV2k+jEPhCoEuzaBgbpyvqbTKzy1ROS71U1Tajc+yrs5uoVQSIkfJUumSwPvABClngUV
	 TqYVDgUcm74V60/GfBWWk7XlHfy0MhTSM9lKuzH3nzu6lIFqW2Tkt3ulHszcn1RVdLRcf
	 ptBlLd6SWRQvF9d1KkN8B3iZrmz5xk4ND8htyds4cSdW6h4zpdeNR+QiY045Kb8acLxUU
	 3VJXlAKR4OzblmMHZd+ZylSvFDkmQ5XDr64uDB66FLzFKYg/ei7PzAYcNU++LidQz5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FB3fe8ej;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1560A2630;
	Tue, 27 Oct 2026 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FB3fe8ej
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15D41F01825;
	Tue, 27 Oct 2026 00:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060286;
	bh=yMuhcWzIibzjRSnhzjjg9lAT62fPTo5Jq89DVpXRPI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FB3fe8ejBP2FjTPBvg5Y9OK/pdSutx+KdpxcrbcgdlLuqY8yosgtfZ6XYart7LgVK
	 7fs1gzzKA0iiwgk8XVpuulCLkd3ref2DJp5KX9N1g082m0PymJmsLUGcNyvAAhsRhw
	 Z3BLGf1oZ6OS4Tuf5Opjk0t2iP6yyI2LgykpZUgPzmcPWz153MtcM6qRnzw6haiDrQ
	 RxqU+2lvyDgnwUphusDBQeVWGpkZr01KsWW4WRu3FTyOPO1hQ0Six6Yho0pp+x1/Dn
	 DgtK7JWJU1LFDicqMiUoLgCavTqb1mgMZnpJVy/Sw6T6rISY8h6awRxFN7rj41c+dv
	 NhMbaw/51fKog==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/18] sched_ext: Let the bypass load balancer move tasks homed on other cpus
Date: Mon, 26 Oct 2026 14:17:47 -1000
Message-ID: <20261027001749.1821379-17-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following patch uses the bypass load balancer to drain a cpu's bypass
DSQ when the host loses SCX_CAP_BASE there. The host no longer consumes that
DSQ, so the drain has to move every task on it. The balancer skips the ones
homed on another cpu.

An earlier pass moved such a task in from its home cpu's DSQ, and the donor
cpu has not consumed it yet. A task's DSQ membership may only change under
the task's rq lock, which the balancer does not hold.

Take such a task off the donor DSQ with unlink_dsq_and_switch_rq_lock(), the
handshake a remote consumer uses. It drops the DSQ lock and switches to the
task's rq lock. A dequeue that gets in between takes the task, and the
balancer moves on. The insert then runs under the task's home rq lock, as it
already does for a donor-homed task.

A task whose donee is its own cpu can always run there.
task_can_run_on_remote_rq() warns when asked about a task's own cpu, so the
balancer skips the test for such a task.

The walk holds the donor rq lock, which keeps the donor cpu's dispatch and
its enqueuers away from the donor DSQ. A move of a task homed elsewhere
switches to the task's rq lock, and both can reach the DSQ meanwhile. The
parked cursor keeps the walk's place through a consume, and the sequence
bound keeps a task enqueued meanwhile out of the pass.

v2: The description says "the following patch", not "patches", uses the
balancer to drain a DSQ.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 64 +++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index d8e0d99886c6..f02be209c44a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6624,7 +6624,7 @@ bool scx_hardlockup(int cpu)
  * @sch: host sched whose bypass DSQs are balanced
  * @donor_rq: rq of the cpu whose bypass DSQ gives up @p, locked
  * @donor_dsq: @sch's bypass DSQ on @donor_rq's cpu, locked
- * @p: task on @donor_dsq, homed on @donor_rq
+ * @p: task on @donor_dsq, homed anywhere
  * @donee: cpu whose bypass DSQ receives @p
  *
  * Take @p off @donor_dsq and insert it into the bypass DSQ of @donee. The
@@ -6632,28 +6632,45 @@ bool scx_hardlockup(int cpu)
  * can still refuse the move under @p's rq lock. @p then goes back to the head
  * of @donor_dsq.
  *
+ * The insert runs under @p's rq lock. A task homed on @donor_rq is dequeued in
+ * place. unlink_dsq_and_switch_rq_lock() takes one homed elsewhere off and
+ * switches the rq lock from @donor_rq to its own. The switch can lose to a
+ * dequeue, and @p then belongs to the dequeuer.
+ *
  * @donor_rq and @donor_dsq are locked on entry and on return. @donor_dsq is
- * unlocked across the insert, so the caller's walk must find its place in it
- * again after the call.
+ * unlocked in between, and @donor_rq too while the lock is switched, so the
+ * caller's walk must find its place in @donor_dsq again after the call.
  *
- * Return the cpu that received @p, or -1 if @p went back onto @donor_dsq.
+ * Return the cpu that received @p, or -1 if @p went back onto @donor_dsq or was
+ * lost to a dequeue.
  */
 static s32 bypass_lb_move(struct scx_sched *sch, struct rq *donor_rq,
 			  struct scx_dispatch_q *donor_dsq, struct task_struct *p, s32 donee)
 {
 	struct scx_dispatch_q *dst_dsq;
 	u64 enq_flags;
+	struct rq *rq = task_rq(p);
 	s32 ret;
 
 	lockdep_assert_rq_held(donor_rq);
 	lockdep_assert_held(&donor_dsq->lock);
 
-	scx_wait_dispatching(p);
-	dispatch_dequeue_locked(p, donor_dsq);
-	raw_spin_unlock(&donor_dsq->lock);
+	if (rq == donor_rq) {
+		scx_wait_dispatching(p);
+		dispatch_dequeue_locked(p, donor_dsq);
+		raw_spin_unlock(&donor_dsq->lock);
+	} else if (!unlink_dsq_and_switch_rq_lock(p, donor_dsq, donor_rq, rq)) {
+		/* lost to a dequeue, @p is the dequeuer's now */
+		ret = -1;
+		goto out;
+	}
 
-	/* @p's affinity is stable under its rq lock */
-	if (task_can_run_on_remote_rq(sch, p, cpu_rq(donee), false)) {
+	/*
+	 * @p's affinity is stable under its rq lock. A task whose donee is its
+	 * own cpu can always run there, and task_can_run_on_remote_rq() warns
+	 * when asked about a task's own cpu.
+	 */
+	if (donee == task_cpu(p) || task_can_run_on_remote_rq(sch, p, cpu_rq(donee), false)) {
 		dst_dsq = scx_bypass_dsq(sch, donee);
 		enq_flags = 0;
 		ret = donee;
@@ -6664,8 +6681,10 @@ static s32 bypass_lb_move(struct scx_sched *sch, struct rq *donor_rq,
 		ret = -1;
 	}
 
-	scx_dispatch_enqueue(sch, donor_rq, dst_dsq, p, 0, 0, enq_flags);
-
+	scx_dispatch_enqueue(sch, rq, dst_dsq, p, 0, 0, enq_flags);
+out:
+	if (rq != donor_rq)
+		switch_rq_lock(rq, donor_rq);
 	raw_spin_lock(&donor_dsq->lock);
 	return ret;
 }
@@ -6718,22 +6737,16 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 		if (u32_before(cursor.priv, p->scx.dsq_seq))
 			continue;
 
-		/*
-		 * If an earlier pass placed @p on @donor_dsq from a different
-		 * CPU and the donee hasn't consumed it yet, @p is still on the
-		 * previous CPU and task_rq(@p) != @donor_rq. @p can't be moved
-		 * without its rq locked. Skip.
-		 */
-		if (task_rq(p) != donor_rq)
-			continue;
-
 		donee = cpumask_any_and_distribute(donee_mask, p->cpus_ptr);
 		if (donee >= nr_cpu_ids)
 			continue;
 
 		/*
-		 * The move drops @donor_dsq's lock. Park the cursor behind @p
-		 * and resume from it afterwards.
+		 * The move drops @donor_dsq's lock, and the rq lock too when
+		 * @p is homed elsewhere. The donor cpu's dispatch and its
+		 * enqueuers can reach @donor_dsq then. Park the cursor behind
+		 * @p and resume from it afterwards. The seq test above keeps a
+		 * task enqueued meanwhile out of the pass.
 		 */
 		list_move(&cursor.node, &p->scx.dsq_list.node);
 		cpu = bypass_lb_move(sch, donor_rq, donor_dsq, p, donee);
@@ -6752,9 +6765,10 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 			 * The rq lock is held across the walk, not cycled per
 			 * move. @donor_dsq can be very long and contended, and
 			 * the rq lock is what keeps its consumer and enqueuers
-			 * away while the walk cycles the DSQ lock. The walk can
-			 * still take a while, so let the cpu breathe every so
-			 * often.
+			 * away while the walk cycles the DSQ lock. The rare
+			 * move of a task homed elsewhere does switch it away,
+			 * see the cursor comment above. The walk can still take
+			 * a while, so let the cpu breathe every so often.
 			 */
 			if (!(++nr_balanced % SCX_BYPASS_LB_BATCH)) {
 				raw_spin_unlock(&donor_dsq->lock);
-- 
2.56.0

