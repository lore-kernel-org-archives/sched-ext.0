Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705131;
	b=odw8BOcCYSAee88i+tJgQEeodldUEsJMJfz6ek/SYEk+3QtYXgK4Mp22EePpSMKXHmLz
	 s+TWXRQXLuQwbgPyV9x72KA5dcYkMGdffxlfbZs7oKkDxcG3s7FZrekehfrwEvvh3VtaY
	 eXzOKOsl011T2nDLmbQxXOXHBuiAXJriQFpULd/NJdf8yMF6CW6y4JeRVHoaF1+4k6mYZ
	 eeGraXkUEVxkif3CM9W+8VUWcOEvsk5ZrOep3EEVywP8XP6Nr+uP9t0PgsGDRjEDkpVuf
	 WvKo08R2jjumcq/K/XKfPONnQ79pnYqP1rPRi9o//K7tLQ1Cji/Y3eO2jtXBTuxdXgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705131;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gJ/yzizc0tT9pJCB5B7rGcC6JWsMWyvpDXEsJbkFAyw=;
	b=Uv/cXwSAZk3Ji4xMSqNbayf8CwQQZQzpFFC7t5Ra2YlboF7xqdKS2lAguPz9tLavS++b
	 SxdbpA/doZnigPzepwEju3yBZcKa0/Cf3+A4CeW759bd9B/bvM0Ot9X2KbFsOXYNymXc5
	 DMKLup4EQruEjwHLZ0saXJ7QT8+VvN0red6doZB6464/bSAmv6dYeT1fWikoyvWUL1bOf
	 VM9Wfs/J+XjtbgQEgyl56itdzu4DeUhEUaY1TDo/IHMUW/IaRycBN8LE/fQBSf6ZWnNWw
	 WFWQsmercr4ecU0Tot9VKRko3adycu0aK13+7hhZ2bs6euvSvzWjUkT6LgdD+APgcKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYdpWmFt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3C60A2602;
	Thu, 22 Oct 2026 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYdpWmFt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86101F01828;
	Thu, 22 Oct 2026 21:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705130;
	bh=gJ/yzizc0tT9pJCB5B7rGcC6JWsMWyvpDXEsJbkFAyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mYdpWmFtdpl+zwc8FfDM536qwUuRC1IBuM9c32+cGeQSbu11EA+PFYDq+iJAC4s2j
	 y9fz73blEb8tsDZqaWzI2eZ3PcapUQEYXRBdLH0pyakr8qt3240f1/9qv64JXGoer6
	 I7PaPlQ5xuh/Si3PF+ZGwNgoVXP5LW7dN1zt5eMG0q5TddfRK+1GKj62FyrV3YzT2g
	 aZ4TzcJLc7lmLLQLGcpnPPtQY+e2ax6t//Fh2JrFLvqJfc5D3e/DEhK9CSVda2Ntvl
	 3i2IWVQXPKThilFRroIJkn0p+G2/gjqwnRVrQkDTRlS74vlyDZFykCwDjT3J0qFOfz
	 gCp+xV0SiE/8w==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/14] sched_ext: Let the bypass load balancer move tasks homed on other cpus
Date: Thu, 22 Oct 2026 11:38:35 -1000
Message-ID: <20261022213836.2259069-14-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022213836.2259069-1-tj@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org>
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

The following patches use the bypass load balancer to drain a cpu's bypass
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

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 64 +++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 70d8ee36148b..0e1a773deff6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6497,7 +6497,7 @@ bool scx_hardlockup(int cpu)
  * @sch: host sched whose bypass DSQs are balanced
  * @donor_rq: rq of the cpu whose bypass DSQ gives up @p, locked
  * @donor_dsq: @sch's bypass DSQ on @donor_rq's cpu, locked
- * @p: task on @donor_dsq, homed on @donor_rq
+ * @p: task on @donor_dsq, homed anywhere
  * @donee: cpu whose bypass DSQ receives @p
  *
  * Take @p off @donor_dsq and insert it into the bypass DSQ of @donee. The
@@ -6505,28 +6505,45 @@ bool scx_hardlockup(int cpu)
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
@@ -6537,8 +6554,10 @@ static s32 bypass_lb_move(struct scx_sched *sch, struct rq *donor_rq,
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
@@ -6591,22 +6610,16 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
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
@@ -6625,9 +6638,10 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
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

