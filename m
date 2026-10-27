Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060286;
	b=eWqULaoJ6DyAKGnU2oRg/zBwkYB3Mk6PopTLy9QEBgOQ5BsH45GPmvRJxsidCJS4t61W
	 Ydnp846dJ+QGsxWdC5I8KeEWVlsq21PCxClthgfH25cJ5QlOf/gYIpd/2SurER9Du1qR/
	 4CEnKlyateUsd85jB6hjP1RNSD0/P1E9XpSvYFGUpW0ocPuWl+WkAJqBb5/purzqT2EbV
	 ZEFFrz/+yvsmU1yVHHryiu53TnVGHS0IYSd3yU/HbNvz3ZfcsRooF9g97YSYmqFD2dx3b
	 Z2t1m3fdoK6tijaq9RqSKDHcwMMhNBriZ0Ve6qam03MgrwuMCF8G6fraxogFJYBW0Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060286;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D2Zmq12SX71qE/jqY7FuRL/GaayqzX0jufoA/towg5w=;
	b=0ZfMMBrh8ByK+jeDv2oAXAesktn16VC3TfPn1Yfcepiht6spbjVzp//wzKmmuZoC4+VC
	 LNA2qLdTu76DP/WHDFcAoWBkPrBex3hdb55WPNGYA28gIJ4KHpikeKTRW8VJWH1YfT3Lx
	 rI2c+B5wwLuK81paZCXPxxPSrz/0Lsio7vhc5TH2rmeLj4ihx0nR1VMAm+otnz96FU6RN
	 x1aMtUpACoAniyBeKFi8EPURb9Xh1mhImImD37F+/e/HjbSOHDoEIIJVWnSlykmOWV0e1
	 Jj6SogWaMwG+PWsrX0XAG8eNPYYieO/Gp2wAjCqW1aHtS2Q/LHLSb5h7KosVKnLuUAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HsO+YwRm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814660A2621;
	Tue, 27 Oct 2026 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HsO+YwRm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4381F031E2;
	Tue, 27 Oct 2026 00:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060285;
	bh=D2Zmq12SX71qE/jqY7FuRL/GaayqzX0jufoA/towg5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HsO+YwRmIMqPGhAFkNlG+iPhXLlkyhHsgwLMaMUXGRCrvt4QMZJ9tKQJ9msh6iDD4
	 IeGyDhAw87e2cKJ/RlhRG8kLGpzRofGr676NdBJLscepJSfGFUlbVKpV2gEpfyQTF+
	 wPT1UAXv72ClCZ4b1GcoiJp6P6GISCL1QA38arJjpz56XXc5jhapvH8hmcyzD4/HY6
	 cbCrWSrjRPk4Wn/YZUIKnCHjspB6wXLzcD9TirTBv1VWqe4CyqoyNmz9CrGAfnGMMy
	 3huOUaScxcGBUZ9nzxYzjJrloonKbWiv1Jch1te1h0wRGhbkpMGM1apVOhE7vzCYRa
	 NxHq/3uSzqjDg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 15/18] sched_ext: Factor out bypass_lb_move() and insert with the donor DSQ unlocked
Date: Mon, 26 Oct 2026 14:17:46 -1000
Message-ID: <20261027001749.1821379-16-tj@kernel.org>
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

Prepare the bypass load balancer for moving tasks homed on other cpus. Such
a move takes the task's own rq lock through the remote consumer's handshake,
which drops the donor DSQ lock on the way, so its insert runs with the donor
DSQ unlocked and under the task's rq lock. The balancer's own move holds the
donor DSQ lock throughout, with the donee DSQ lock nested inside.

Switch the donor-homed move to the same scheme so that one body can serve
both: factor it out of bypass_lb_cpu() into bypass_lb_move(), which takes
the task off the donor DSQ and inserts with the DSQ unlocked. A task that
can't run on the donee goes back to the head of the donor DSQ instead of
being skipped in place.

The walk parks its cursor behind the task before each move and resumes from
it afterwards. It is bounded to the tasks queued when it began, by their DSQ
sequence numbers, so a task it put back is not visited again in the same
pass.

Before, the walk held both the donor rq lock and the donor DSQ lock across
every move. The donor DSQ can be very long and contended, a walk competing
with the cpu's dispatch and the enqueues for the DSQ lock would crawl, and
the walk is what relieves that contention by moving tasks off the DSQ. The
walk now cycles the DSQ lock around each insert but still holds the rq lock
throughout, and that alone keeps dispatch and enqueues away. The DSQ lock is
uncontended when retaken, so cycling it is cheap.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 131 ++++++++++++++++++++++++++++-------------
 1 file changed, 91 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ff79d9af0389..d8e0d99886c6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6619,6 +6619,57 @@ bool scx_hardlockup(int cpu)
 	return true;
 }
 
+/**
+ * bypass_lb_move - Move one task off a bypass DSQ for the balancer
+ * @sch: host sched whose bypass DSQs are balanced
+ * @donor_rq: rq of the cpu whose bypass DSQ gives up @p, locked
+ * @donor_dsq: @sch's bypass DSQ on @donor_rq's cpu, locked
+ * @p: task on @donor_dsq, homed on @donor_rq
+ * @donee: cpu whose bypass DSQ receives @p
+ *
+ * Take @p off @donor_dsq and insert it into the bypass DSQ of @donee. The
+ * caller picks @donee from @p's affinity alone and task_can_run_on_remote_rq()
+ * can still refuse the move under @p's rq lock. @p then goes back to the head
+ * of @donor_dsq.
+ *
+ * @donor_rq and @donor_dsq are locked on entry and on return. @donor_dsq is
+ * unlocked across the insert, so the caller's walk must find its place in it
+ * again after the call.
+ *
+ * Return the cpu that received @p, or -1 if @p went back onto @donor_dsq.
+ */
+static s32 bypass_lb_move(struct scx_sched *sch, struct rq *donor_rq,
+			  struct scx_dispatch_q *donor_dsq, struct task_struct *p, s32 donee)
+{
+	struct scx_dispatch_q *dst_dsq;
+	u64 enq_flags;
+	s32 ret;
+
+	lockdep_assert_rq_held(donor_rq);
+	lockdep_assert_held(&donor_dsq->lock);
+
+	scx_wait_dispatching(p);
+	dispatch_dequeue_locked(p, donor_dsq);
+	raw_spin_unlock(&donor_dsq->lock);
+
+	/* @p's affinity is stable under its rq lock */
+	if (task_can_run_on_remote_rq(sch, p, cpu_rq(donee), false)) {
+		dst_dsq = scx_bypass_dsq(sch, donee);
+		enq_flags = 0;
+		ret = donee;
+	} else {
+		/* back where it was, at the head so that the walk skips it */
+		dst_dsq = donor_dsq;
+		enq_flags = SCX_ENQ_HEAD;
+		ret = -1;
+	}
+
+	scx_dispatch_enqueue(sch, donor_rq, dst_dsq, p, 0, 0, enq_flags);
+
+	raw_spin_lock(&donor_dsq->lock);
+	return ret;
+}
+
 static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 			 struct cpumask *donee_mask, struct cpumask *resched_mask,
 			 u32 nr_donor_target, u32 nr_donee_target)
@@ -6642,14 +6693,15 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 
 	raw_spin_rq_lock_irq(donor_rq);
 	raw_spin_lock(&donor_dsq->lock);
+	/* bound the walk to the tasks queued now, see the seq test below */
+	cursor.priv = donor_dsq->seq;
 	list_add(&cursor.node, &donor_dsq->list);
 resume:
 	n = container_of(&cursor, struct task_struct, scx.dsq_list);
 	n = nldsq_next_task(donor_dsq, n, false);
 
 	while ((p = n)) {
-		struct scx_dispatch_q *donee_dsq;
-		int donee;
+		s32 donee, cpu;
 
 		n = nldsq_next_task(donor_dsq, n, false);
 
@@ -6659,6 +6711,13 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 		if (cpumask_empty(donee_mask))
 			break;
 
+		/*
+		 * A task queued after the walk began, including one the walk
+		 * itself put back, is left for the next pass.
+		 */
+		if (u32_before(cursor.priv, p->scx.dsq_seq))
+			continue;
+
 		/*
 		 * If an earlier pass placed @p on @donor_dsq from a different
 		 * CPU and the donee hasn't consumed it yet, @p is still on the
@@ -6672,49 +6731,41 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 		if (donee >= nr_cpu_ids)
 			continue;
 
-		donee_dsq = scx_bypass_dsq(sch, donee);
-
-		/*
-		 * $p's rq is not locked but $p's DSQ lock protects its
-		 * scheduling properties making this test safe.
-		 */
-		if (!task_can_run_on_remote_rq(sch, p, cpu_rq(donee), false))
-			continue;
-
-		/*
-		 * Moving $p from one non-local DSQ to another. The source rq
-		 * and DSQ are already locked. Do an abbreviated dequeue and
-		 * then perform enqueue without unlocking $donor_dsq.
-		 *
-		 * We don't want to drop and reacquire the lock on each
-		 * iteration as @donor_dsq can be very long and potentially
-		 * highly contended. Donee DSQs are less likely to be contended.
-		 * The nested locking is safe as only this LB moves tasks
-		 * between bypass DSQs.
-		 */
-		dispatch_dequeue_locked(p, donor_dsq);
-		scx_dispatch_enqueue(sch, cpu_rq(donee), donee_dsq, p, 0, 0, SCX_ENQ_NESTED);
-
 		/*
-		 * $donee might have been idle and need to be woken up. No need
-		 * to be clever. Kick every CPU that receives tasks.
+		 * The move drops @donor_dsq's lock. Park the cursor behind @p
+		 * and resume from it afterwards.
 		 */
-		cpumask_set_cpu(donee, resched_mask);
+		list_move(&cursor.node, &p->scx.dsq_list.node);
+		cpu = bypass_lb_move(sch, donor_rq, donor_dsq, p, donee);
+		if (cpu >= 0) {
+			/*
+			 * @cpu might have been idle and need to be woken up.
+			 * No need to be clever. Reschedule every cpu that
+			 * receives tasks.
+			 */
+			cpumask_set_cpu(cpu, resched_mask);
 
-		if (READ_ONCE(donee_dsq->nr) >= nr_donee_target)
-			cpumask_clear_cpu(donee, donee_mask);
+			if (READ_ONCE(scx_bypass_dsq(sch, cpu)->nr) >= nr_donee_target)
+				cpumask_clear_cpu(cpu, donee_mask);
 
-		nr_balanced++;
-		if (!(nr_balanced % SCX_BYPASS_LB_BATCH) && n) {
-			list_move_tail(&cursor.node, &n->scx.dsq_list.node);
-			raw_spin_unlock(&donor_dsq->lock);
-			scx_rq_lock_drop(donor_rq);
-			raw_spin_rq_unlock_irq(donor_rq);
-			cpu_relax();
-			raw_spin_rq_lock_irq(donor_rq);
-			raw_spin_lock(&donor_dsq->lock);
-			goto resume;
+			/*
+			 * The rq lock is held across the walk, not cycled per
+			 * move. @donor_dsq can be very long and contended, and
+			 * the rq lock is what keeps its consumer and enqueuers
+			 * away while the walk cycles the DSQ lock. The walk can
+			 * still take a while, so let the cpu breathe every so
+			 * often.
+			 */
+			if (!(++nr_balanced % SCX_BYPASS_LB_BATCH)) {
+				raw_spin_unlock(&donor_dsq->lock);
+				scx_rq_lock_drop(donor_rq);
+				raw_spin_rq_unlock_irq(donor_rq);
+				cpu_relax();
+				raw_spin_rq_lock_irq(donor_rq);
+				raw_spin_lock(&donor_dsq->lock);
+			}
 		}
+		goto resume;
 	}
 
 	list_del_init(&cursor.node);
-- 
2.56.0

