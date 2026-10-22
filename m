Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705130;
	b=d4Oi2/o4mku+5uxQQtBAC4JqutZK/yjYWdmY1eRg3oXPDnwFZDMfSc/cLiygxWMcGZQ3
	 gWG5Yhwu7M5TlffLi39Yud8s6Wa6gv4iLTKAe52H3QDfpzefRQKzLgE1WWg+4Las+jccL
	 +ILjS8OK64a5i4O0e7J+oQ3l4WB2goKkCdd/ORQdY1zXYEW41kA30IxRzwTWGcikSOJSn
	 iOHT9f3XS8oVylGf9TwHohroGaM5yMDBZ5Nji8u82bBPY9mUnv+jtkla5ibPHL5oqSI27
	 1PyV+LAbtIQoVDMiy2TuPbQMEwlNJpheZNWWVAl8Hq6ikT4yoOqmpsJlIx9+OlQyQWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705130;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=45mMpOwezLE/eZgcq4ogTWjq+BNZlTpiyitM81S6f/k=;
	b=s/Z6vlARQjuq/y9+pZjgssXF7TQ38BGoxu6Dot8Y9dFtU1Z1c4wHARcUCmQxKfyUVTVI
	 HgzDnGZ+FRiV5d9dgL1Fy3lTLvRWoTFdHKyJ0urIMQgOUr0COqYJjMYqfzxv/7rLajkcV
	 J1+oKYtCOMwPWPJaqi6NXC1FPewOA9h6MqbZDf44yb3hX1pmbYnD3z8YL8SeURrsIxIow
	 VCXvlzf561gKAm1ue74IMIE7x2b1Y55LHoQis8O/A9VjEJWrulbDIQWtRlHiK2wVkxsOi
	 Of5Dj3SEtWKDAhRwSd7zwzY2nFeA8k16+toEjS9XCXfIFmBXXbb2tnV8V6oBvW212EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4BroUgR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322A60A2613;
	Thu, 22 Oct 2026 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4BroUgR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7941F031E6;
	Thu, 22 Oct 2026 21:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705129;
	bh=45mMpOwezLE/eZgcq4ogTWjq+BNZlTpiyitM81S6f/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4BroUgR+ephCc8FMVLLow78MUr5MHUjb7RDv4APJkmgbDwzjfZj3+ILSTNYwqUxF
	 OvmPMBze/I9zWHbaAlS1WL72d/cc7KYrVI8xCy5FhuQFaWGGQgDgl0pln3KP6Fctkf
	 savUwPc1fcX/9tr/AOjEUVEkE/YRZWeBQ2Zq7Ncfad70dsRYvtqQ1EZdd6ZeZX4/Iz
	 JjyeAF+k8WCIbvGIneWFCiyQmj1FOeJ98KI02ywwGJsKJ6312i/WUHVNTjEyV/FjAg
	 iLGWuwO+WazBD4JMbwP8xN+6Lny2Yh3L25MBNlPQ72Tb3cXaoK87rixSobKWOAl927
	 TaD2lRlne3hMg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/14] sched_ext: Factor out bypass_lb_move() and insert with the donor DSQ unlocked
Date: Thu, 22 Oct 2026 11:38:34 -1000
Message-ID: <20261022213836.2259069-13-tj@kernel.org>
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
index 5a0c7ddf48e3..70d8ee36148b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6492,6 +6492,57 @@ bool scx_hardlockup(int cpu)
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
@@ -6515,14 +6566,15 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 
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
 
@@ -6532,6 +6584,13 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
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
@@ -6545,49 +6604,41 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
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

