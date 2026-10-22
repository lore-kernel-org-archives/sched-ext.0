Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705125;
	b=c0FIUfIMomkgByE21JGBMTj61kOAjraKG1n18fBDtF1CFzq1HDZSkO0WZhrjFyUMIV6G
	 Bi+2PHU0WFr7ZxfARngXYLnP8lAUlv9SY4TwsuWuMPBi/eQgDVE9DgfJw2TaU3K9aGo79
	 6PmhQ8puayvnycCcokAC6tgYYkunLgO1ctq0FFu9dpju3qWSSbCsD3+3mUa/hY4SZjdW5
	 Go57LFpxmPo2Le/38yfFR/sdB91jy5qMbnrU2hcQSpSpb6mP3QHgXs4yzRmMc+2szCiFT
	 lZgI1XktY+nuIDnFJByBNd+bPc5db9eU9yEe3AmIMS1EgPdTh5EBdX4pUYVuN0WqLqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705125;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pPAvjHM8ro4xIP2YHvHSd5RsxKLMUDkIBB24QGoCZFU=;
	b=pc7BZ91UT4wPphkrhDw67UTt+Q3r4NTcf3r32SrsH6XvFC7zPfV1YM1jCNo5kJx3KUHE
	 yTB0YohGjQ9QmTbrWqjNisX0W5xkjYZiFV+qcJryHeCmqbx4RXjGcasBEVXkvor956X4m
	 o3ikNmhxbOJ7iVRewIVXhiTIwuEHTphuOr6O/LXxwxOMRthje/D8SPXss2huPiauL0e2Y
	 Wt833kVdPUCmQjuuameiuIgV0qPr8X/ZGvoTKPaOR4sTbaLM/p7TXnUtkJm9RtcXcF0UD
	 ugkXtQsr2pW5Her0GfvYu2dkqrH1fNgaUcdfBU/cW517bSwURAatp2VMnAgopyY50/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlKtm9Wv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F84606A32A;
	Thu, 22 Oct 2026 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlKtm9Wv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746C31F031E2;
	Thu, 22 Oct 2026 21:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705124;
	bh=pPAvjHM8ro4xIP2YHvHSd5RsxKLMUDkIBB24QGoCZFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YlKtm9Wv4O5eLObf9LFymgdwAFG8ro1wllHnEYo2GCn5gUOAZsYdl/61nyS4yWWj1
	 nAz83qZ67fiGj7K9XE9F5VDHd/e0aOzuyDzCf2YbS4yeAmne9EiqCj988ODW/NnelK
	 u/h+zjCCoHIZ1gzdKDW2jRynm60yNaTMgigr/NiMRkezDBe+YwRfDCHyePQZbkUW6+
	 0fkoOhZLUpGhM2Hys/UNVhPV2J+zdJIhemE+ikdn9I42VKn1btai9fjSBBKJDKCQ91
	 dx3Pl3Qfm7dfKB6ZDkVdaHJwfNjDsbJhb5vIUELOuEcLMwLuYHu6PnglJDEzWud7Y6
	 3TSY+Bdc955ew==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/14] sched_ext: Mark the rescue grant as a kernel slice with SCX_TASK_KERNEL_SLICE
Date: Thu, 22 Oct 2026 11:38:29 -1000
Message-ID: <20261022213836.2259069-8-tj@kernel.org>
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

In the following patches, bypassed tasks run under rescue when their host
lacks SCX_CAP_BASE on the cpu. Under bypass the kernel zeroes the running
task's slice at every tick, as it does not trust the scheduler's slices.

A rescue grant has to survive that, or it is served a tick at a time with
the rescuee sent to the tail of the local DSQ each time. The generic slice
handling can't tell a kernel grant from a scheduler's slice.

Mark the grant as a kernel slice with SCX_TASK_KERNEL_SLICE, set at rescue
admission and cleared when the slice ends. The generic slice handling leaves
it alone. The default refill does nothing for it, and the three zeroings go
through the new expire_task_slice(), which skips it:

 - the bypass tick's zeroing of the running task
 - the eviction of a running task that can't stay on the cpu when bypass
   lifts
 - the cap-revoke eviction of a running task

Schedulers keep their control. Preemption and scx_bpf_task_set_slice() still
apply, and the rescue stays bounded by served time.

The sites that recognized the rescuee by identity, the reenqueue scan and
put_prev_task_scx()'s reinsert, test the flag instead.
scx_task_has_kernel_slice() hides the test behind the scx_has_subs() static
key, as only a sub-scheduler's task can carry the flag. The flag's entries
join the enum tables in tools/sched_ext.

No kernel slice reaches a zeroing until bypassed tasks run under rescue. The
cap-revoke eviction skipped the rescuee already, and bypass entry ends an
open rescue, so the bypass tick and the eviction at bypass lift see none.

The refill is the one behavior change. The pick refills a zero slice only
for a task that can stay on the cpu, so it concerns a rescuee whose
scheduler holds BASE there. A scheduler may zero such a queued rescuee's
slice, and the next pick used to refill it to the default.

Now the rescuee runs on the zero slice until the next tick. There
put_prev_task_scx() restores the remainder when another task is runnable.
When nothing else is runnable, dispatch_one() keeps the rescuee as the last
task. The pick then ends its zero slice, which ends the rescue, and refills
the default.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h                     | 11 +++++
 kernel/sched/ext/ext.c                        | 45 ++++++++++++++-----
 kernel/sched/ext/sub.c                        | 11 ++---
 kernel/sched/ext/sub.h                        |  7 +++
 .../sched_ext/include/scx/enum_defs.autogen.h |  1 +
 .../sched_ext/include/scx/enums_abi.autogen.h |  1 +
 6 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index b341c328948e..fcf85b87fdd4 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -106,6 +106,17 @@ enum scx_ent_flags {
 	SCX_TASK_PROTECTED	= 1 << 6, /* slice and DSQ head position protected */
 	SCX_TASK_RUN_TRACKED	= 1 << 7, /* task is in an ops.running()/stopping() session */
 
+	/*
+	 * The kernel owns the slice, currently the rescue grant. While set:
+	 *
+	 * - refill_task_slice_dfl() and expire_task_slice() leave the slice
+	 *   alone.
+	 * - Reenqueue scans skip the task.
+	 * - put_prev_task_scx() keeps a preempted task on the local DSQ.
+	 * - Scheduler slice writes and preemption still apply.
+	 */
+	SCX_TASK_KERNEL_SLICE	= 1 << 8, /* slice owned by the kernel */
+
 	/*
 	 * The multi-bit fields are packed at the top, below SCX_TASK_CURSOR, so
 	 * that the single-bit flags stay contiguous from bit 0.
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b68674d7f762..73d49dd07255 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1441,8 +1441,8 @@ bool scx_set_task_slice(struct task_struct *p, u64 slice)
  * @rq: rq @p is on
  * @p: task of interest
  *
- * End what rides on the slice - the protection, and the rescue if @p is being
- * rescued.
+ * End what rides on the slice - the protection, the kernel's ownership of the
+ * slice, and the rescue if @p is being rescued.
  *
  * A dequeue normally ends the slice too. The exception is a save/restore pair
  * on the running task. Attribute changes like renice cycle the task through
@@ -1454,7 +1454,7 @@ void scx_task_slice_ended(struct rq *rq, struct task_struct *p)
 {
 	lockdep_assert_rq_held(rq);
 
-	p->scx.flags &= ~SCX_TASK_PROTECTED;
+	p->scx.flags &= ~(SCX_TASK_PROTECTED | SCX_TASK_KERNEL_SLICE);
 	if (unlikely(p == scx_rescuee(rq)))
 		scx_rescue_end(rq);
 }
@@ -1538,8 +1538,16 @@ static void apply_slice_vtime(struct task_struct *p, u64 slice, u64 vtime, u64 e
 		p->scx.dsq_vtime = vtime;
 }
 
+/*
+ * refill_task_slice_dfl() supplies a slice when the scheduler left none and
+ * expire_task_slice() takes it away to force the task off the cpu. Neither
+ * touches a kernel slice, see %SCX_TASK_KERNEL_SLICE.
+ */
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
+	if (scx_task_has_kernel_slice(p))
+		return;
+
 	/*
 	 * A default refill is not an explicit request, so it must not drop a
 	 * pending out-of-band one, which is applied when @p next runs.
@@ -1548,6 +1556,17 @@ static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
+static void expire_task_slice(struct task_struct *p)
+{
+	/*
+	 * Unlike the refill above, an expiry supersedes a pending out-of-band
+	 * request. A kept request would be applied at the next
+	 * update_curr_scx() and undo the expiry.
+	 */
+	if (!scx_task_has_kernel_slice(p))
+		scx_set_task_slice(p, 0);
+}
+
 static void update_curr_scx(struct rq *rq)
 {
 	struct task_struct *donor;
@@ -3639,11 +3658,15 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 				u64 enq_flags = 0;
 
 				/*
-				 * Keep a preempted rescue going. If preempted
-				 * by another SCX task, append to the local DSQ,
-				 * see scx_rescue_keep().
+				 * The enqueue caps gate the scheduler's
+				 * placement. The kernel placed a kernel-slice
+				 * task here itself, so reinsert it without a
+				 * cap check, at the head like any preempted
+				 * task. When scx_rescue_keep() restored a slice
+				 * the scheduler zeroed, the scheduler wanted
+				 * something else to run first, so append.
 				 */
-				if (unlikely(p == scx_rescuee(rq))) {
+				if (unlikely(scx_task_has_kernel_slice(p))) {
 					enq_flags |= SCX_ENQ_IGNORE_CAPS;
 					if (!rescue_keep)
 						enq_flags |= SCX_ENQ_HEAD;
@@ -4358,7 +4381,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 	 * management.
 	 */
 	if (scx_bypassing(sch, cpu_of(rq)))
-		scx_set_task_slice(donor, 0);
+		expire_task_slice(donor);
 	else if (SCX_HAS_OP(sch, tick))
 		SCX_CALL_OP_TASK(sch, tick, rq, donor);
 
@@ -4972,7 +4995,7 @@ static bool local_task_should_reenq(struct rq *rq, struct task_struct *p,
 	first = !(*reenq_flags & SCX_REENQ_TSR_NOT_FIRST);
 	*reenq_flags |= SCX_REENQ_TSR_NOT_FIRST;
 
-	if (unlikely((p->scx.flags & SCX_TASK_PROTECTED) || p == scx_rescuee(rq)))
+	if (unlikely((p->scx.flags & SCX_TASK_PROTECTED) || scx_task_has_kernel_slice(p)))
 		return false;
 
 	*reason = SCX_TASK_REENQ_KFUNC;
@@ -5075,7 +5098,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 	if ((reenq_flags & SCX_REENQ_CAP_REVOKE) &&
 	    rq->donor->sched_class == &ext_sched_class &&
 	    scx_task_reenq_on_cap_revoke(rq, rq->donor)) {
-		scx_set_task_slice(rq->donor, 0);
+		expire_task_slice(rq->donor);
 		resched_curr(rq);
 	}
 
@@ -6895,7 +6918,7 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 			if (bypass)
 				scx_task_slice_ended(rq, p);
 			else if (!scx_task_can_stay_on_cpu(rq, p))
-				scx_set_task_slice(p, 0);
+				expire_task_slice(p);
 		}
 
 		/*
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 63d7876fe577..825055208ab3 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -581,11 +581,11 @@ static void scx_rescue_timer_arm(struct rq *rq)
  * @p: task being admitted, off any DSQ
  * @slice: CPU time to grant
  *
- * The schedulers keep their normal control over @p and may preempt or reslice
- * it. @slice is measured on served CPU time against the snapshot taken here, so
- * neither shortens the rescue, see scx_rescue_charge() and scx_rescue_keep().
- * Prolonged denial escalates into protected execution, see
- * scx_rescue_timerfn().
+ * The slice is a kernel slice, see %SCX_TASK_KERNEL_SLICE. The schedulers keep
+ * their normal control over @p and may preempt or reslice it. @slice is
+ * measured on served CPU time against the snapshot taken here, so neither
+ * shortens the rescue, see scx_rescue_charge() and scx_rescue_keep(). Prolonged
+ * denial escalates into protected execution, see scx_rescue_timerfn().
  */
 static void scx_rescue_admit(struct rq *rq, struct task_struct *p, s64 slice)
 {
@@ -596,6 +596,7 @@ static void scx_rescue_admit(struct rq *rq, struct task_struct *p, s64 slice)
 	rq->scx.rescue.slice = slice;
 	rq->scx.rescue.exec_snap = p->se.sum_exec_runtime;
 	scx_set_task_slice(p, slice);
+	p->scx.flags |= SCX_TASK_KERNEL_SLICE;
 	scx_rescue_timer_arm(rq);
 }
 
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index b76d750463f0..223c34309b5a 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -248,12 +248,19 @@ static inline struct task_struct *scx_rescuee(struct rq *rq)
 	return rq->scx.rescue.curr;
 }
 
+/* does the kernel own @p's slice? see %SCX_TASK_KERNEL_SLICE */
+static inline bool scx_task_has_kernel_slice(const struct task_struct *p)
+{
+	return scx_has_subs() && (p->scx.flags & SCX_TASK_KERNEL_SLICE);
+}
+
 #else	/* CONFIG_EXT_SUB_SCHED */
 
 static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed) { return 0; }
 static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq, u64 enq_flags) { return 0; }
 static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p) { return true; }
 static inline struct task_struct *scx_rescuee(struct rq *rq) { return NULL; }
+static inline bool scx_task_has_kernel_slice(const struct task_struct *p) { return false; }
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 4fa82033b99c..362e8bb34499 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -108,6 +108,7 @@
 #define HAVE_SCX_TASK_IMMED
 #define HAVE_SCX_TASK_PROTECTED
 #define HAVE_SCX_TASK_RUN_TRACKED
+#define HAVE_SCX_TASK_KERNEL_SLICE
 #define HAVE_SCX_TASK_STATE_SHIFT
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index 05a460611c4d..ad8f56f581ad 100644
--- a/tools/sched_ext/include/scx/enums_abi.autogen.h
+++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
@@ -120,6 +120,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ent_flags", "SCX_TASK_IMMED", 0x20LLU },
 	{ "scx_ent_flags", "SCX_TASK_PROTECTED", 0x40LLU },
 	{ "scx_ent_flags", "SCX_TASK_RUN_TRACKED", 0x80LLU },
+	{ "scx_ent_flags", "SCX_TASK_KERNEL_SLICE", 0x100LLU },
 	{ "scx_ent_flags", "SCX_TASK_STATE_SHIFT", 0x19LLU },
 	{ "scx_ent_flags", "SCX_TASK_STATE_BITS", 0x3LLU },
 	{ "scx_ent_flags", "SCX_TASK_STATE_MASK", 0xe000000LLU },
-- 
2.56.0

