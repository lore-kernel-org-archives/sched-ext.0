Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493838911F;
	Fri,  3 Jul 2026 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065747; cv=none; b=O3TmNUZByMa/gj+cDY5+HvveoozCSyOp09ylrE9UtJYaBzWqNO9p3j3eL3vZLCYnndHRJa9C+iaxr+EP1XOWb8Uf14wJAgiwwAJAtw2hqg7Hhfp7eUTFcKg8Hu2Pu9JEw4Jl/yDe+3PupjTxjGmLxgDVRhJPB2ceAuPO+pRa5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065747; c=relaxed/simple;
	bh=wkvrUJ6rM6fCKsqr55Wm4YL2niFVYzy/Rb0y3jXrHWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mqc76i7ySFQInBHIWjuguisdRGqpDS1dgnRuQA7dybi/G2wjw/cko98ap/WrIOy6tGMtq1vsx4rPBMIFwE8ukfivxQgqN3XIxC8ysoogGbVHsdqciD+1wv6XI+1H10/TmUpPJq+PQ32eGKCmoOdhKDeCAx+nWCWkBXDXfXNAQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApJqubvZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApJqubvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEE11F00A3A;
	Fri,  3 Jul 2026 08:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065745;
	bh=vLW3sX26CaaBGuWVRsh1EdFGmWjWXvmTOCK3gBODRw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ApJqubvZyyv+MhTG4Azwmvidn9jLiJT1ZO9cJydrxqbG7n+Hj1QeQwsfraExryM6f
	 68hip0bQ4bjkmKZ1oYPmh95m6CyWRhH4HP9eH8KFGKhEriZZqBbxEsMz0v+b786Ro6
	 l+P3RicDTeqd4ULGspjtKA9ZlxIsWVwTT4mojmvisrT6In9Vi9EW0/fvMTW1YffMH5
	 Nx4x3150Rq4/v6r8YJdKTZD8L/j+66E075CvSfhk0pFJEqWlMKx9h+yu2s3k9LxXxv
	 W8Jc+S2dWEp/5F7OGoZSQj1sJ6lQi2dDjt5b2RQTIbIqnAAECNALbkv6KQhLk9nCD0
	 dXSFT4YtNee9Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 25/32] sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice
Date: Thu,  2 Jul 2026 22:01:52 -1000
Message-ID: <20260703080159.2314350-26-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703080159.2314350-1-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A task's slice grants it cpu occupancy - how long it holds its cpu. In a
sub-scheduler hierarchy cpu access is delegated through revocable
capabilities, so a task's occupancy must follow them. Only its own scheduler
sets its slice, and extending the slice is allowed only while that scheduler
holds baseline cpu access (SCX_CAP_BASE) on the cpu. Otherwise a scheduler
could keep occupying a cpu it has been denied simply by handing out long
slices.

The cap check reads effective caps, which are coherent only under the task's
rq lock, and the kernel decrements the slice under that lock as the task
runs, so a running task's slice can be changed only there while a queued
task's can be set directly. Make scx_bpf_task_set_slice() apply the slice
under the rq lock. Synchronously when the caller already holds it, otherwise
by stashing it in the new p->scx.slice_oob, tagged with the scheduler's id
so a request that outlived a reassignment is dropped.

Revocation is enforced through the same grant. When a cpu's effective caps
lose SCX_CAP_BASE, the cap-revoke reenq scan also checks the running task
and zeroes its slice to evict it. The scan runs as a balance callback after
the pick, so this catches both the task that was running when the revoke
landed and a capless task the pick just promoted off the local DSQ. The
paths that keep a task on its cpu - holding on to the last runnable task in
balance, the ENQ_LAST reinsertion and the slice refill on pick - skip tasks
lacking baseline access. A migration-disabled task is exempt, mirroring its
capless admission on insert.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h   |  17 +++-
 kernel/sched/ext/ext.c      | 174 ++++++++++++++++++++++++++++++++++--
 kernel/sched/ext/internal.h |  19 +++-
 kernel/sched/ext/sub.h      |  11 +++
 4 files changed, 208 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 7e3f6b33f4a8..7f3f8a26b0b4 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -222,10 +222,11 @@ struct sched_ext_entity {
 	/* BPF scheduler modifiable fields */
 
 	/*
-	 * Runtime budget in nsecs. This is usually set through
-	 * scx_bpf_dsq_insert() but can also be modified directly by the BPF
-	 * scheduler. Automatically decreased by SCX as the task executes. On
-	 * depletion, a scheduling event is triggered.
+	 * Runtime budget in nsecs - how long the task may hold its cpu. Owned
+	 * by the task's scheduler. Set it when enqueuing via
+	 * scx_bpf_dsq_insert(), or otherwise via scx_bpf_task_set_slice().
+	 * Automatically decreased as the task executes. On depletion a
+	 * scheduling event is triggered.
 	 *
 	 * This value is cleared to zero if the task is preempted by
 	 * %SCX_KICK_PREEMPT and shouldn't be used to determine how long the
@@ -242,6 +243,14 @@ struct sched_ext_entity {
 	 */
 	u64			dsq_vtime;
 
+	/*
+	 * Out-of-band slice request from scx_bpf_task_set_slice() when the
+	 * caller does not hold the rq lock, applied under the rq lock at the
+	 * next slice consideration. One atomic64 packs the pending flag, the
+	 * issuing sch's id, and the requested slice. See scx_slice_oob_consts.
+	 */
+	atomic64_t		slice_oob;
+
 	/*
 	 * Sub-sched cap rejected reenq context, valid only while
 	 * %SCX_TASK_REENQ_CAP is set. @reenq_reason_caps is the SCX_CAP_* bits
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 95ad8f37cc92..dfae05ce3e81 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1158,10 +1158,125 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
 #endif
 }
 
-/* set @p's slice, every write to p->scx.slice goes through here */
+/*
+ * p->scx.slice_oob packs an out-of-band slice request into one atomic64. A zero
+ * word means no request. Otherwise the fields are:
+ *
+ *   63      SCX_SLICE_OOB_PENDING, set on every request
+ *   62-43   lower bits of issuing scheduler's id
+ *   42-0    requested slice duration in nsecs
+ *
+ * A duration of SCX_SLICE_OOB_DUR_MASK means SCX_SLICE_INF. A finite dur
+ * saturates at SCX_SLICE_OOB_DUR_MASK - 1. The id is used to detect and ignore
+ * a request that outlived a task ownership change.
+ *
+ * Only the low 20 bits of sch->id are packed, which is enough to make
+ * collisions practically impossible. A theoretical collision just lets a stale
+ * request through once.
+ */
+enum scx_slice_oob_consts {
+	SCX_SLICE_OOB_DUR_BITS	= 43,
+	SCX_SLICE_OOB_ID_BITS	= 64 - SCX_SLICE_OOB_DUR_BITS - 1,
+
+	SCX_SLICE_OOB_DUR_MASK	= (1LLU << SCX_SLICE_OOB_DUR_BITS) - 1,
+	SCX_SLICE_OOB_ID_SHIFT	= SCX_SLICE_OOB_DUR_BITS,
+	SCX_SLICE_OOB_ID_MASK	= (1LLU << SCX_SLICE_OOB_ID_BITS) - 1,
+	SCX_SLICE_OOB_PENDING	= 1LLU << 63,
+};
+
+/*
+ * Slice write rules
+ *
+ * A task's slice - how long it may hold its cpu - is an occupancy grant owned
+ * by the task's scheduler. How it may be written depends on whether the task is
+ * running.
+ *
+ * Queued, not running: the slice grants no occupancy yet and nothing consumes
+ * it, so the owner writes it directly - via scx_bpf_dsq_insert(), the dsq move
+ * kfuncs, or scx_bpf_task_set_slice(). Serializing its own writers is then the
+ * scheduler's job, not the kernel's.
+ *
+ * Running: the slice must be changed under the task's rq lock, because:
+ *
+ * - Raising it extends occupancy, allowed only with %SCX_CAP_BASE on the cpu,
+ *   and that cap check is coherent only under the rq lock. Shortening is always
+ *   allowed.
+ *
+ * - The kernel decrements it there as the task runs. The decrement is a
+ *   read-modify-write, so a racing write can be clobbered.
+ *
+ * scx_bpf_task_set_slice() writes directly when it holds the rq lock, and
+ * otherwise stashes the value in p->scx.slice_oob for the kernel to apply under
+ * the lock. A later in-band write supersedes a stash, and a stash whose
+ * scheduler id no longer matches the task's owner is dropped.
+ */
+
+/* clear a pending slice request */
+static void clear_task_slice_oob(struct task_struct *p)
+{
+	if (unlikely(atomic64_read(&p->scx.slice_oob)))
+		atomic64_set(&p->scx.slice_oob, 0);
+}
+
+/* set @p's slice, superseding any pending out-of-band request */
 static void set_task_slice(struct task_struct *p, u64 slice)
 {
 	p->scx.slice = slice;
+	clear_task_slice_oob(p);
+}
+
+/* request @p's slice to be set to @slice, see the slice write rules above */
+static void set_task_slice_oob(struct scx_sched *sch, struct task_struct *p, u64 slice)
+{
+	u64 dur;
+
+	if (slice == SCX_SLICE_INF) {
+		dur = SCX_SLICE_OOB_DUR_MASK;
+	} else if (unlikely(slice >= SCX_SLICE_OOB_DUR_MASK)) {
+		dur = SCX_SLICE_OOB_DUR_MASK - 1;
+		scx_add_event(sch, SCX_EV_SLICE_CLAMPED, 1);
+	} else {
+		dur = slice;
+	}
+
+	atomic64_set(&p->scx.slice_oob, SCX_SLICE_OOB_PENDING |
+		     ((sch->id & SCX_SLICE_OOB_ID_MASK) << SCX_SLICE_OOB_ID_SHIFT) | dur);
+}
+
+/*
+ * Apply a pending out-of-band slice request under @rq's lock. A request whose
+ * packed id no longer matches @p's current owner is dropped. An extension needs
+ * baseline cpu access on @p's cid. %SCX_EV_SLICE_DENIED counts the denials.
+ * Shortening is always allowed. See the slice write rules above.
+ */
+static void apply_task_slice_oob(struct rq *rq, struct task_struct *p)
+{
+	u64 oob, dur, slice;
+
+	lockdep_assert_rq_held(rq);
+
+	if (likely(!atomic64_read(&p->scx.slice_oob)))
+		return;
+
+	oob = atomic64_xchg(&p->scx.slice_oob, 0);
+	if (unlikely(!oob))
+		return;
+
+	/* the issuing scheduler no longer owns @p, drop the request */
+	if (unlikely(((oob >> SCX_SLICE_OOB_ID_SHIFT) & SCX_SLICE_OOB_ID_MASK) !=
+		     (scx_task_sched(p)->id & SCX_SLICE_OOB_ID_MASK)))
+		return;
+
+	dur = oob & SCX_SLICE_OOB_DUR_MASK;
+	slice = dur == SCX_SLICE_OOB_DUR_MASK ? SCX_SLICE_INF : dur;
+
+	if (slice > p->scx.slice &&
+	    unlikely(scx_missing_caps(scx_task_sched(p), cpu_of(rq), SCX_CAP_BASE))) {
+		__scx_add_event(scx_task_sched(p), SCX_EV_SLICE_DENIED, 1);
+		return;
+	}
+
+	p->scx.slice = slice;
 }
 
 static void update_curr_scx(struct rq *rq)
@@ -1169,6 +1284,9 @@ static void update_curr_scx(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	s64 delta_exec;
 
+	/* apply even on 0 delta_exec, callers may still act on the slice */
+	apply_task_slice_oob(rq, curr);
+
 	delta_exec = update_curr_common(rq);
 	if (unlikely(delta_exec <= 0))
 		return;
@@ -2682,7 +2800,8 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	 * %SCX_OPS_ENQ_LAST is in effect.
 	 */
 	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
-	    (!(sch->ops.flags & SCX_OPS_ENQ_LAST) || scx_bypassing(sch, cpu))) {
+	    (!(sch->ops.flags & SCX_OPS_ENQ_LAST) || scx_bypassing(sch, cpu)) &&
+	    scx_task_can_stay_on_cpu(rq, prev)) {
 		rq->scx.flags |= SCX_RQ_BAL_KEEP;
 		__scx_add_event(sch, SCX_EV_DISPATCH_KEEP_LAST, 1);
 		goto has_tasks;
@@ -2843,12 +2962,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
 		 * ops.enqueue() that @p is the only one available for this cpu,
 		 * which should trigger an explicit follow-up scheduling event.
+		 * This doesn't apply if the baseline access on the CPU is lost.
 		 *
 		 * Core scheduling can force this CPU idle while @p stays
 		 * runnable. @p's cookie then won't match the core's, so skip
 		 * the warning in that case.
 		 */
-		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
+		if (next && sched_class_above(&ext_sched_class, next->sched_class) &&
+		    scx_task_can_stay_on_cpu(rq, p)) {
 			WARN_ON_ONCE(sched_cpu_cookie_match(rq, p) &&
 				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			scx_do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
@@ -2970,7 +3091,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 		if (!p)
 			return NULL;
 
-		if (unlikely(!p->scx.slice)) {
+		if (unlikely(!p->scx.slice) && scx_task_can_stay_on_cpu(rq, p)) {
 			struct scx_sched *sch = scx_task_sched(p);
 
 			if (!scx_bypassing(sch, cpu_of(rq)) &&
@@ -3898,6 +4019,20 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		nr_enqueued++;
 	}
 
+	/*
+	 * The revoke that scheduled this scan may have raced the pick: curr
+	 * may be a now-capless task, either one that kept running or one
+	 * promoted off the local DSQ between the ecaps sync and this scan.
+	 * Zero the slice to evict it. The enqueue gate blocks new capless
+	 * inserts, so no later pick can slip through after the scan.
+	 */
+	if ((reenq_flags & SCX_REENQ_CAP_REVOKE) &&
+	    rq->curr->sched_class == &ext_sched_class &&
+	    scx_task_reenq_on_cap_revoke(rq, rq->curr)) {
+		set_task_slice(rq->curr, 0);
+		resched_curr(rq);
+	}
+
 	return nr_enqueued;
 }
 
@@ -8626,20 +8761,45 @@ __bpf_kfunc_start_defs();
  * @slice: time slice to set in nsecs
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
- * Set @p's time slice to @slice. Returns %true on success, %false if the
- * calling scheduler doesn't have authority over @p.
+ * Set @p's time slice. @p must be on the calling scheduler. The value is
+ * applied whether or not the caller holds @p's rq lock - see the slice write
+ * rules above for the ownership model.
+ *
+ * Raising the slice is honored only while the scheduler holds %SCX_CAP_BASE on
+ * @p's cpu, otherwise it is counted in %SCX_EV_SLICE_DENIED. Shortening is
+ * always allowed. On the stashed path the slice is packed into an atomic64_t
+ * with the scheduler id and a flag bit, so a slice too large to fit is clamped
+ * and counted in %SCX_EV_SLICE_CLAMPED. %SCX_SLICE_INF is preserved.
+ *
+ * Return %true on success, %false if @p is not on the calling scheduler.
  */
 __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 					const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *sch;
+	struct rq *rq = task_rq(p);
 
 	guard(rcu)();
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
 		return false;
 
-	set_task_slice(p, slice);
+	/*
+	 * Out of band: stash and apply under the rq lock at the next drain,
+	 * where it is re-validated against @p's current owner.
+	 */
+	if (scx_locked_rq() != rq) {
+		set_task_slice_oob(sch, p, slice);
+		return true;
+	}
+
+	/* under the rq lock: apply now, extensions gated on baseline access */
+	if (slice > p->scx.slice &&
+	    unlikely(scx_missing_caps(sch, cpu_of(rq), SCX_CAP_BASE)))
+		__scx_add_event(sch, SCX_EV_SLICE_DENIED, 1);
+	else
+		set_task_slice(p, slice);
+
 	return true;
 }
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 323c88835698..48d975a457ca 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -400,8 +400,9 @@ struct sched_ext_ops {
 	 * @p: task running currently
 	 *
 	 * This operation is called every 1/HZ seconds on CPUs which are
-	 * executing an SCX task. Setting @p->scx.slice to 0 will trigger an
-	 * immediate dispatch cycle on the CPU.
+	 * executing an SCX task. Setting a slice of 0 for @p with
+	 * scx_bpf_task_set_slice() will trigger an immediate dispatch cycle on
+	 * the CPU.
 	 */
 	void (*tick)(struct task_struct *p);
 
@@ -1103,6 +1104,18 @@ struct scx_event_stats {
 	 */
 	s64		SCX_EV_REFILL_SLICE_DFL;
 
+	/*
+	 * The number of times an out-of-band slice request exceeded the maximum
+	 * representable value and was clamped.
+	 */
+	s64		SCX_EV_SLICE_CLAMPED;
+
+	/*
+	 * The number of times a slice extension was denied because the
+	 * scheduler lacked baseline cpu access on the task's cpu.
+	 */
+	s64		SCX_EV_SLICE_DENIED;
+
 	/*
 	 * The total duration of bypass modes in nanoseconds.
 	 */
@@ -1153,6 +1166,8 @@ struct scx_event_stats {
 	SCX_EVENT(SCX_EV_REENQ_IMMED);					\
 	SCX_EVENT(SCX_EV_REENQ_LOCAL_REPEAT);				\
 	SCX_EVENT(SCX_EV_REFILL_SLICE_DFL);				\
+	SCX_EVENT(SCX_EV_SLICE_CLAMPED);				\
+	SCX_EVENT(SCX_EV_SLICE_DENIED);					\
 	SCX_EVENT(SCX_EV_BYPASS_DURATION);				\
 	SCX_EVENT(SCX_EV_BYPASS_DISPATCH);				\
 	SCX_EVENT(SCX_EV_BYPASS_ACTIVATE);				\
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index ea8bea347bb0..ce626a29b33b 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -120,9 +120,20 @@ static inline u64 scx_caps_implied(u64 cap)
 	return 0;
 }
 
+/* may @p keep running on @rq's cpu? requires baseline cpu access */
+static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p)
+{
+	/* a migration-disabled task is let in without caps, keep it likewise */
+	if (unlikely(is_migration_disabled(p)))
+		return true;
+
+	return likely(!scx_missing_caps(scx_task_sched(p), cpu_of(rq), SCX_CAP_BASE));
+}
+
 #else	/* CONFIG_EXT_SUB_SCHED */
 
 static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed) { return 0; }
+static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p) { return true; }
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
-- 
2.54.0

