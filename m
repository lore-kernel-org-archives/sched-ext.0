Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796338F920;
	Mon,  6 Jul 2026 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302091; cv=none; b=GucBVUBE7ALiGn3ZgodmIFKx4irjc679o7cZ+yPcz1bBLvLxHJr4mC/xEiYFN9hzjXkS3MN1mT88HmN2N4zpjaZL4iQYtsQSXnY4tZyGw8ysFZLrZGe/Plxqy899MXuxAywmCcmJGTDDS/yRM2tH15K7GkgPBh2chYt1H0sszDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302091; c=relaxed/simple;
	bh=526CaWYlX0dzMafhoctssNsCFNkVjzV0buFxy+kFGUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mq9AMj5haai0yTWWhXcD67jvAfuzkSNAk/3g2+shGgpDEfSq9akPjEQMfg8NYl8gRK+jttfKfNciXE/N/KArf0iElu5FUaUSU+2d6VdXC00dP3y045kqFSJAn22Dai24PgmPF7AOxyjMweyabxWyL8PhIf0CpDjSvxiHtvrMRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjPdLtd2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjPdLtd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7621F000E9;
	Mon,  6 Jul 2026 01:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302088;
	bh=c/I1mse2elaU19kuc2liS4jYkMYGJL47x27qJUTNS/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GjPdLtd2mqmhula70aYeVin1cjvivJnfRp+VlawyrtvgCWaUcqcUUTdheCMWD/PTH
	 BOyfbjHr46oepnr2AyQNjYRRHB2xahNLZTFmG8FceN7Nf1JhUgWHCy4i4vkj1dlf6K
	 EKuH7ug94HHg9pCNiFHft5P5KBoA5mJJAdyL+AGwHsHZmgRWUYw7Q1Bg/cUVQLGTf1
	 QYJ0FnpRWrkf7CIRYWlhShYIdPhfbBMUb/IxhdbkMz2mBiw7/phTxRLitG2Mec/Dwb
	 3IGrMdVmnClBXSDKaV30ZaPCfkfZkKCserNDGypJfdo0BXWWhoulPJrC/9M9mx9hZO
	 hiWuSoYHpnsjQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 28/36] sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice
Date: Sun,  5 Jul 2026 15:40:50 -1000
Message-ID: <20260706014058.439853-29-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
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

v2: Only write slice directly when @p is queued on the held rq. (sashiko AI)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h   |  17 +++-
 kernel/sched/ext/ext.c      | 178 ++++++++++++++++++++++++++++++++++--
 kernel/sched/ext/internal.h |  19 +++-
 kernel/sched/ext/sub.h      |  11 +++
 4 files changed, 212 insertions(+), 13 deletions(-)

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
index ff997ba881b0..e4a725df297e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1153,10 +1153,129 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
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
+ * scx_bpf_task_set_slice() writes directly only when @p is queued or running
+ * on the rq lock it holds. That is the only state where the lock keeps us @p's
+ * owner: @p can't move to another rq without it. A task that isn't queued here
+ * can instead be woken onto a different rq without taking this lock, and that
+ * dispatch sets its slice - so a direct write would race. Those cases stash
+ * into p->scx.slice_oob to be applied under @p's actual rq lock. A later in-band
+ * write supersedes a stash, and a stash whose scheduler id no longer matches
+ * @p's owner is dropped.
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
@@ -1164,6 +1283,9 @@ static void update_curr_scx(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	s64 delta_exec;
 
+	/* apply even on 0 delta_exec, callers may still act on the slice */
+	apply_task_slice_oob(rq, curr);
+
 	delta_exec = update_curr_common(rq);
 	if (unlikely(delta_exec <= 0))
 		return;
@@ -2677,7 +2799,8 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	 * %SCX_OPS_ENQ_LAST is in effect.
 	 */
 	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
-	    (!(sch->ops.flags & SCX_OPS_ENQ_LAST) || scx_bypassing(sch, cpu))) {
+	    (!(sch->ops.flags & SCX_OPS_ENQ_LAST) || scx_bypassing(sch, cpu)) &&
+	    scx_task_can_stay_on_cpu(rq, prev)) {
 		rq->scx.flags |= SCX_RQ_BAL_KEEP;
 		__scx_add_event(sch, SCX_EV_DISPATCH_KEEP_LAST, 1);
 		goto has_tasks;
@@ -2838,12 +2961,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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
@@ -2965,7 +3090,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 		if (!p)
 			return NULL;
 
-		if (unlikely(!p->scx.slice)) {
+		if (unlikely(!p->scx.slice) && scx_task_can_stay_on_cpu(rq, p)) {
 			struct scx_sched *sch = scx_task_sched(p);
 
 			if (!scx_bypassing(sch, cpu_of(rq)) &&
@@ -3893,6 +4018,20 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
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
 
@@ -8621,20 +8760,45 @@ __bpf_kfunc_start_defs();
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
+	 * Directly write only when we are the owner of @p. See the slice write
+	 * rules above.
+	 */
+	if (scx_locked_rq() != rq || !task_on_rq_queued(p)) {
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
index 0f3d98c19f7a..78e20d1e9acf 100644
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

