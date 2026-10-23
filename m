Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778188;
	b=r4Uk8qCTu18hp4lGZ00n6rTsk5bZJ0mOzjWqFOEY4YymaOSto9KZWeopcfsXieikXPnj
	 t9UVrNox5ENJyHTvez5ju39ZRQTJTGqISSLrDQ8UTYwfJlpoA2W5fdyTpsyUuXozk6vEg
	 c5RzbqTWixAHpCj9fx9NyDGpBFUT2woO3S+UMG/0yBgXmY2+lcw/WQgFGIdgQ0me2RMz9
	 HIbFzCU5O6mSJF4Lwj2+fgOd6fF8FT3l4+QrIWUwXpU4ligOMhYwmA95kix0OP8U37luo
	 1+DGhhM/+6ivuGWzwtJ9E9nLQoqUER396l7GJIuKkaqC/1AYozXdSiQjs07lccQq6bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778188;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qf8jiV0Vv8E9audG5dz8Bcb0l+yq+eZBCktdS2uymvo=;
	b=xLHjUl3gilOOGX/wYyt1WDwHPrT1VF6xAesREg2eKE3bXJ+CrYByoaMhr6nneY3yQWTA
	 HwbYUJB89kkEnSVrQiVI5aM7ZQsl0j6HDEigTE8/ckk4RyY1N+lGOl/tk+eHsUnAz52rl
	 R9smZDYmw//kT7sqoQGH1hIo6AjKZgLEQB2dZq8Zh79K8Pt3iWTAVRcYS5yynLfVRZSCk
	 Boy4z5Ox6fKg09/eQMH5JtH46ZNvZM1+TqxoGR1mETHya2L7Gv2tEVhmtdIJ5Y1BMivU1
	 lkLQx6gjv/Ik2p2Hiae2dcfBF39uQtgDLslPdi0/2u2iVHj60XEf+AiFh2T4h/pdoOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ajqq0u2b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB260A2614;
	Fri, 23 Oct 2026 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ajqq0u2b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B681F031E2;
	Fri, 23 Oct 2026 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778187;
	bh=qf8jiV0Vv8E9audG5dz8Bcb0l+yq+eZBCktdS2uymvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ajqq0u2b736KH1fi032BE6wmhd/JLCws2toW17AFZfmDtV2nfmfIcnPglSaFmja6+
	 453PzoaNI3NyFHCupdVa9ikauHl4RoU7WN9PtyJY6gd70T6Fr/0u/0x2KnV9JoXcl5
	 Q2yp5B+BLqjUKqn6kCeLoAKarJ/xgzeyqhJ1KBhGI7/PmtbktVw6HsrnxBxFfRxrFN
	 rkU3sVPGkzmKf5h6JfaEakyrbPBqtne/pUmIbYS3nek3oBHOQ9iW4RduUe+t4xRuKV
	 aZDZlzJygpghSQcDL+b35pngLHW4jTWG1+pnj4k5Cvx3xIaTMYq3DIVAhLHg2xjJVn
	 IpXsqEHgxf8MQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 17/17] sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_BASE
Date: Fri, 23 Oct 2026 07:56:08 -1000
Message-ID: <20261023175608.4120910-18-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023175608.4120910-1-tj@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org>
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

A task already queued on a bypass DSQ stalls when the host loses
SCX_CAP_BASE on that cpu. The cpu's dispatch no longer consumes the DSQ, and
the task sits there until the host regains BASE or the bypass window ends.
Sending a bypassed task to rescue at enqueue time covers only a task
enqueued after the loss, and the balancer no longer donates to a capless
cpu.

Have the bypass load balancer drain such a DSQ: a cpu where the host lacks
BASE is a donor with a target of zero. The target already counts its tasks
against the cpus that hold BASE, so the donees take them under their
ordinary fill. The queued-duration threshold doesn't apply to a zero target.

The balancer reenqueues a task no donee can take at its home, under the home
rq lock the move holds there anyway. The enqueue sends the task to rescue
when the host lacks BASE at home and rescue is enabled, and to the home's
bypass DSQ otherwise. A task that must run at home, migration-disabled or
with a migration pending, is admitted to the home's local DSQ in either
case. Every donee refuses a migration-disabled task, so it always takes this
path.

The same reenqueue replaces the put-back for a task that can't run on the
donee the walk picked for it. That is a cold path: the donee went inactive
or the task is a proxy-migrated blocked donor. An affinity change while the
move is in flight dequeues the task and the balancer loses the claim
instead.

Without rescue, the reenqueue of a task homed on the drained cpu lands on
the DSQ it came from, apart from the admit above. A task stuck that way is
reenqueued once per pass and waits for the host to regain BASE or the bypass
to end, or for the stall watchdog to eject the host, which it blames for a
task stuck on its DSQ.

With a zero interval the stuck task is reenqueued once per BASE loss, and a
task that lands on the drained DSQ after that pass waits the same way. These
reenqueues, like those of a task refused pass after pass, are not counted
against the reenqueue limit, as the task's scheduler is bypassing.

On a BASE loss, scx_bypass_lb_kick() sets the balancer's timer to expire
now, so that the drain runs before the next interval, and runs at all when
the interval is zero. A donee can lose BASE while the balancer is moving
tasks onto it, and the kick from that loss covers it.

The balancer re-arms with timer_reduce(), which only brings the expiry
forward, so a loss during a run leaves the timer at now and the next run
sees it. The arming at bypass dispatch enable uses timer_reduce() too, so
that a kick landing there is kept.

v2: The description drops an in-flight affinity change from the causes of a
refused balancer move.

v3:
- The description says that a stuck task's reenqueues are not counted
  against the reenqueue limit (sashiko).
- The description names the stall watchdog as the way out for a task stuck
  without rescue, and the tasks a zero interval leaves on a drained DSQ.
- bypass_lb_reenq_home()'s kerneldoc and the description give the placement
  with rescue disabled and for a task that must run at home, and the other
  two comments on that placement point to the kerneldoc.

Fixes: 147d1885f390 ("sched_ext: Add the SCX_CAP_ENQ_IMMED cap")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 147 ++++++++++++++++++++++++++----------
 kernel/sched/ext/internal.h |   1 +
 kernel/sched/ext/sub.c      |   8 ++
 3 files changed, 116 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3d2d01489766..a274210007fa 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6530,36 +6530,59 @@ bool scx_hardlockup(int cpu)
 	return true;
 }
 
+/**
+ * bypass_lb_reenq_home - Reenqueue a task at its home from the balancer
+ * @rq: @p's home rq, locked
+ * @p: task off any DSQ, taken from the bypass DSQ of @dsq_cpu
+ * @dsq_cpu: cpu whose bypass DSQ gave up @p
+ *
+ * @p came off the bypass DSQ of @dsq_cpu with no donee able to take it. A
+ * migration-disabled @p always comes here, as every donee refuses it. The
+ * enqueue sends @p to rescue when the host lacks %SCX_CAP_BASE at home and
+ * rescue is enabled, and to the home's bypass DSQ otherwise. When @p must run
+ * at home, migration-disabled or with a migration pending, it is admitted to
+ * the home's local DSQ in either case, see bypass_enq_target_dsq(). No DSQ lock
+ * may be held, as the enqueue takes one.
+ */
+static void bypass_lb_reenq_home(struct rq *rq, struct task_struct *p, s32 dsq_cpu)
+{
+	lockdep_assert_rq_held(rq);
+
+	WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK);
+	p->scx.flags |= SCX_TASK_REENQ_CAP;
+	p->scx.reenq_reason_caps = SCX_CAP_BASE;
+	p->scx.reenq_reason_cid = __scx_cpu_to_cid(dsq_cpu);
+	scx_do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
+}
+
 /**
  * bypass_lb_move - Move one task off a bypass DSQ for the balancer
  * @sch: host sched whose bypass DSQs are balanced
  * @donor_rq: rq of the cpu whose bypass DSQ gives up @p, locked
  * @donor_dsq: @sch's bypass DSQ on @donor_rq's cpu, locked
  * @p: task on @donor_dsq, homed anywhere
- * @donee: cpu whose bypass DSQ receives @p
+ * @donee: cpu whose bypass DSQ receives @p, -1 for none
  *
  * Take @p off @donor_dsq and insert it into the bypass DSQ of @donee. The
  * caller picks @donee from @p's affinity alone and task_can_run_on_remote_rq()
- * can still refuse the move under @p's rq lock. @p then goes back to the head
- * of @donor_dsq.
+ * can still refuse the move under @p's rq lock. A task it refuses, or one with
+ * no donee, is not put back, as the host may no longer consume @donor_dsq.
+ * bypass_lb_reenq_home() reenqueues it at its home instead.
  *
- * The insert runs under @p's rq lock. A task homed on @donor_rq is dequeued in
- * place. unlink_dsq_and_switch_rq_lock() takes one homed elsewhere off and
- * switches the rq lock from @donor_rq to its own. The switch can lose to a
- * dequeue, and @p then belongs to the dequeuer.
+ * The insert and the reenqueue run under @p's rq lock. A task homed on
+ * @donor_rq is dequeued in place. unlink_dsq_and_switch_rq_lock() takes one
+ * homed elsewhere off and switches the rq lock from @donor_rq to its own. The
+ * switch can lose to a dequeue, and @p then belongs to the dequeuer.
  *
  * @donor_rq and @donor_dsq are locked on entry and on return. @donor_dsq is
  * unlocked in between, and @donor_rq too while the lock is switched, so the
  * caller's walk must find its place in @donor_dsq again after the call.
  *
- * Return the cpu that received @p, or -1 if @p went back onto @donor_dsq or was
- * lost to a dequeue.
+ * Return the cpu that received @p, or -1 if @p was lost to a dequeue.
  */
 static s32 bypass_lb_move(struct scx_sched *sch, struct rq *donor_rq,
 			  struct scx_dispatch_q *donor_dsq, struct task_struct *p, s32 donee)
 {
-	struct scx_dispatch_q *dst_dsq;
-	u64 enq_flags;
 	struct rq *rq = task_rq(p);
 	s32 ret;
 
@@ -6579,20 +6602,21 @@ static s32 bypass_lb_move(struct scx_sched *sch, struct rq *donor_rq,
 	/*
 	 * @p's affinity is stable under its rq lock. A task whose donee is its
 	 * own cpu can always run there, and task_can_run_on_remote_rq() warns
-	 * when asked about a task's own cpu.
+	 * when asked about a task's own cpu. A @donee of -1 means none, so
+	 * don't pass it to cpu_rq().
 	 */
-	if (donee == task_cpu(p) || task_can_run_on_remote_rq(sch, p, cpu_rq(donee), false)) {
-		dst_dsq = scx_bypass_dsq(sch, donee);
-		enq_flags = 0;
+	if (donee >= 0 && (donee == task_cpu(p) ||
+			   task_can_run_on_remote_rq(sch, p, cpu_rq(donee), false))) {
+		scx_dispatch_enqueue(sch, rq, scx_bypass_dsq(sch, donee), p, 0, 0, 0);
 		ret = donee;
 	} else {
-		/* back where it was, at the head so that the walk skips it */
-		dst_dsq = donor_dsq;
-		enq_flags = SCX_ENQ_HEAD;
-		ret = -1;
+		/*
+		 * No donee, or @p can't run on it. Reenqueue @p at home
+		 * instead, see bypass_lb_reenq_home().
+		 */
+		bypass_lb_reenq_home(rq, p, cpu_of(donor_rq));
+		ret = cpu_of(rq);
 	}
-
-	scx_dispatch_enqueue(sch, rq, dst_dsq, p, 0, 0, enq_flags);
 out:
 	if (rq != donor_rq)
 		switch_rq_lock(rq, donor_rq);
@@ -6615,10 +6639,11 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 	 * All we want to guarantee is reasonable forward progress. No reason to
 	 * fine tune. Assuming every task on @donor_dsq runs their full slice,
 	 * consider offloading iff the total queued duration is over the
-	 * threshold.
+	 * threshold. A zero target is a drain and empties the DSQ regardless.
 	 */
 	min_delta_us = READ_ONCE(scx_bypass_lb_intv_us) / SCX_BYPASS_LB_MIN_DELTA_DIV;
-	if (delta < DIV_ROUND_UP(min_delta_us, READ_ONCE(scx_slice_bypass_us)))
+	if (nr_donor_target &&
+	    delta < DIV_ROUND_UP(min_delta_us, READ_ONCE(scx_slice_bypass_us)))
 		return 0;
 
 	raw_spin_rq_lock_irq(donor_rq);
@@ -6638,19 +6663,30 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 		if (donor_dsq->nr <= nr_donor_target)
 			break;
 
-		if (cpumask_empty(donee_mask))
+		/*
+		 * Without a donee, a balancing donor has nothing to do. A drain
+		 * still sends its tasks home.
+		 */
+		if (cpumask_empty(donee_mask) && nr_donor_target)
 			break;
 
 		/*
 		 * A task queued after the walk began, including one the walk
-		 * itself put back, is left for the next pass.
+		 * itself reenqueued, is left for the next pass.
 		 */
 		if (u32_before(cursor.priv, p->scx.dsq_seq))
 			continue;
 
+		/*
+		 * A task no donee can take is left where it is by a balancing
+		 * donor and sent home by a drain, see bypass_lb_move().
+		 */
 		donee = cpumask_any_and_distribute(donee_mask, p->cpus_ptr);
-		if (donee >= nr_cpu_ids)
-			continue;
+		if (donee >= nr_cpu_ids) {
+			if (nr_donor_target)
+				continue;
+			donee = -1;
+		}
 
 		/*
 		 * The move drops @donor_dsq's lock, and the rq lock too when
@@ -6706,6 +6742,7 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 	const struct cpumask *node_mask = cpumask_of_node(node);
 	struct cpumask *donee_mask = sch->bypass_lb_donee_cpumask;
 	struct cpumask *resched_mask = sch->bypass_lb_resched_cpumask;
+	u32 intv_us = READ_ONCE(scx_bypass_lb_intv_us);
 	u32 nr_tasks = 0, nr_cpus = 0, nr_balanced = 0;
 	u32 nr_target, nr_donor_target;
 	u32 before_min = U32_MAX, before_max = 0;
@@ -6725,7 +6762,7 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 		before_max = max(nr, before_max);
 	}
 
-	if (!nr_cpus)
+	if (!nr_tasks)
 		return;
 
 	/*
@@ -6733,7 +6770,7 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 	 * balancing to fill donee CPUs up to $nr_target. Once targets are
 	 * calculated, find the donee CPUs.
 	 */
-	nr_target = DIV_ROUND_UP(nr_tasks, nr_cpus);
+	nr_target = nr_cpus ? DIV_ROUND_UP(nr_tasks, nr_cpus) : 0;
 	nr_donor_target = DIV_ROUND_UP(nr_target * SCX_BYPASS_LB_DONOR_PCT, 100);
 
 	cpumask_clear(donee_mask);
@@ -6744,18 +6781,28 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 			cpumask_set_cpu(cpu, donee_mask);
 	}
 
-	/* iterate !donee CPUs and see if they should be offloaded */
+	/*
+	 * Offload the !donee cpus. A cpu where the host lost %SCX_CAP_BASE no
+	 * longer consumes its DSQ. Drain it as a donor with a target of zero. A
+	 * zero interval disables the balancing, not the drain.
+	 */
 	cpumask_clear(resched_mask);
 	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
-		if (cpumask_empty(donee_mask))
-			break;
-		if (cpumask_test_cpu(cpu, donee_mask))
+		u32 target = nr_donor_target;
+
+		if (unlikely(scx_missing_caps(sch, cpu, SCX_CAP_BASE))) {
+			/* the mask may predate the loss, keep this cpu out */
+			cpumask_clear_cpu(cpu, donee_mask);
+			target = 0;
+		} else if (!intv_us || cpumask_empty(donee_mask) ||
+			   cpumask_test_cpu(cpu, donee_mask)) {
 			continue;
-		if (READ_ONCE(scx_bypass_dsq(sch, cpu)->nr) <= nr_donor_target)
+		}
+		if (READ_ONCE(scx_bypass_dsq(sch, cpu)->nr) <= target)
 			continue;
 
 		nr_balanced += bypass_lb_cpu(sch, cpu, donee_mask, resched_mask,
-					     nr_donor_target, nr_target);
+					     target, nr_target);
 	}
 
 	for_each_cpu(cpu, resched_mask)
@@ -6794,9 +6841,28 @@ static void scx_bypass_lb_timerfn(struct timer_list *timer)
 	for_each_node_with_cpus(node)
 		bypass_lb_node(sch, node);
 
+	/*
+	 * A kick during this run can leave the timer pending at now, see
+	 * scx_bypass_lb_kick(). timer_reduce() only brings the expiry forward,
+	 * so that kick is kept.
+	 */
 	intv_us = READ_ONCE(scx_bypass_lb_intv_us);
 	if (intv_us)
-		mod_timer(timer, jiffies + usecs_to_jiffies(intv_us));
+		timer_reduce(timer, jiffies + usecs_to_jiffies(intv_us));
+}
+
+/**
+ * scx_bypass_lb_kick - Run the bypass load balancer now
+ * @sch: sched that lost %SCX_CAP_BASE on a cpu
+ *
+ * @sch no longer consumes its bypass DSQ on that cpu. Have the balancer drain
+ * it without waiting for the next interval, see bypass_lb_node(). A loss during
+ * a run leaves the timer pending at now, and the run that follows sees it.
+ */
+void scx_bypass_lb_kick(struct scx_sched *sch)
+{
+	if (scx_bypass_dsp_enabled(sch))
+		mod_timer(&sch->bypass_lb_timer, jiffies);
 }
 
 static bool inc_bypass_depth(struct scx_sched *sch)
@@ -6865,11 +6931,12 @@ static void enable_bypass_dsp(struct scx_sched *sch)
 
 	/*
 	 * The LB timer will stop running if bypass dispatch is disabled. Start
-	 * after enabling bypass dispatch.
+	 * after enabling bypass dispatch. A kick from a BASE loss can have set
+	 * the timer to expire now in the meantime, see scx_bypass_lb_kick().
+	 * timer_reduce() keeps that expiry.
 	 */
-	if (intv_us && !timer_pending(&host->bypass_lb_timer))
-		mod_timer(&host->bypass_lb_timer,
-			  jiffies + usecs_to_jiffies(intv_us));
+	if (intv_us)
+		timer_reduce(&host->bypass_lb_timer, jiffies + usecs_to_jiffies(intv_us));
 }
 
 /* may be called without holding scx_bypass_lock */
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 38ed3813eb8a..6745ad6edc7e 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2280,6 +2280,7 @@ void scx_cgroup_unlock(void);
 s32 scx_alloc_kern_arena_objs(struct scx_sched *sch);
 void scx_disable_bypass_dsp(struct scx_sched *sch);
 void scx_bypass(struct scx_sched *sch, bool bypass);
+void scx_bypass_lb_kick(struct scx_sched *sch);
 s32 scx_link_sched(struct scx_sched *sch);
 void scx_unlink_sched(struct scx_sched *sch);
 void scx_disable_dump(struct scx_sched *sch);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 60b35cf2f96d..cbb69db6d3ba 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1134,6 +1134,14 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		gained = ecaps & ~old;
 		lost_all |= lost;
 
+		/*
+		 * The bypass DSQ on this cpu is no longer consumed, so drain
+		 * it. A bypassing sched's own bypass DSQs are empty, as its
+		 * tasks sit on the host's.
+		 */
+		if ((lost & SCX_CAP_BASE) && !scx_bypassing(pcpu->sch, cpu))
+			scx_bypass_lb_kick(pcpu->sch);
+
 		/*
 		 * Tell the sched and its parent that the sched's effective caps
 		 * on this cid changed. The invocations are equivalent to the
-- 
2.56.0

