Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778179;
	b=BlRa3dcBvOy5i+LvzPb8/vVwNiUUKEo+NZaiDINLsC740ugY1qMf9ISyuHbiqT3hl6D1
	 jjF4m6aqkjuLwd6XlNmaw/MfqJdHJI3Uk1H2HV9lu8nzg0rTfE3b8+0HdjQottaEOxQAw
	 0fkGuSIcZHykUGKWjYCXyMYOfcm2IHO6gySIUYGL7OjLw+AE/HCbqJAkDCjqScw/r+1W1
	 FEdoplKC7IogeZ5cP7KKnYfmdSZYjzOBokJtZLfwDi0wZqUw0kzVaCUSnJBELDvv59iJC
	 /XYouKVSjE7qMK82T8TA9fjdH+utk03UOdb6Y4Zf6PnBAgiaYhAMg3BZxjKIofJKTjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778179;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OtukOdyWT3+9i9eODM0Gj2A/5/qwvCEy4cDgCDAnVas=;
	b=KOS/VMruFHUrn4ohXgZ/HMQGPklv2CNRfuHpDLnRnUzh9V6Q14J7uHkhGsyjdA3utwEp
	 ltJZlK9jNFqLIeEYBW2DAoM46z8cWsQ45/muLaVw8p/FsmC9VCdNLwxF7H8/F4qYHotc+
	 Gme4AW5Z74XA32a1b46x2I0X2VyMGDPpsO6Mv1F9jDE9D/gUlRArPdFeKKvDURAPd2a/s
	 uF+jgbhljXwEOuxjxbY7uYMz2xI2AVqMETgw+GWdS9GndtpTH3rDqrUgjHMdXenC8J/PT
	 x2W3wmBSvOGDeV0A7m5cMbAlN93fJkF4bJyDmaqWJHxF0vpIdqDeTehwX7qEx1hv7cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJIEeWET;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4860A3806;
	Fri, 23 Oct 2026 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJIEeWET
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7121F01828;
	Fri, 23 Oct 2026 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778178;
	bh=OtukOdyWT3+9i9eODM0Gj2A/5/qwvCEy4cDgCDAnVas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lJIEeWETRe1HP03CuR7RuZ4hp7RxvPOjeBzRzksvW7cBEK2n4IbEJxKTPH5wNQ4Xr
	 lQI+TqYBjr1CiBgAHDSXjbH1ATuC+kq9QblqKyjr6n62oWVgCJUX2FSf1r98AoQgsw
	 WhL3h92t/Qr3cgrtlBJbrPgtari7M6/0Q2LLoxbKPlU6HXRFf0IIXWMp3EjcdOWfGo
	 2DmvNMBmJhfuIvzM1yZ6y2I2ppiJ0dzcw8wWsqc4FwvX5cuk0dN11vvYfmYd9foIBt
	 SLHZxymR/0ygqc1x+bBKiZ+DpFpuxqOPfg9+4SsKnVvlDbBdEG4YblESH7P5tmbFeB
	 hHcDWriUnzrOQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/17] sched_ext: Mark the rescue grant as a kernel slice with SCX_TASK_KERNEL_SLICE
Date: Fri, 23 Oct 2026 07:56:00 -1000
Message-ID: <20261023175608.4120910-10-tj@kernel.org>
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
the default. A scheduler with SCX_OPS_ENQ_LAST skips the keep-last test.
scx_rescue_keep() restores the remainder there instead and the rescue goes
on.

v2:
- scx_rescue_admit()'s kerneldoc no longer mentions a served-time snapshot.
- The description covers a scheduler with SCX_OPS_ENQ_LAST, whose rescuee
  dispatch_one() keeps on the remainder.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h                     | 11 +++++
 kernel/sched/ext/ext.c                        | 45 ++++++++++++++-----
 kernel/sched/ext/sub.c                        | 10 +++--
 kernel/sched/ext/sub.h                        |  7 +++
 .../sched_ext/include/scx/enum_defs.autogen.h |  1 +
 .../sched_ext/include/scx/enums_abi.autogen.h |  1 +
 6 files changed, 60 insertions(+), 15 deletions(-)

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
index de3fa7476fec..09d093b17269 100644
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
@@ -3654,11 +3673,15 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
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
@@ -4373,7 +4396,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *donor, int queued)
 	 * management.
 	 */
 	if (scx_bypassing(sch, cpu_of(rq)))
-		scx_set_task_slice(donor, 0);
+		expire_task_slice(donor);
 	else if (SCX_HAS_OP(sch, tick))
 		SCX_CALL_OP_TASK(sch, tick, rq, donor);
 
@@ -4988,7 +5011,7 @@ static bool local_task_should_reenq(struct rq *rq, struct task_struct *p,
 	first = !(*reenq_flags & SCX_REENQ_TSR_NOT_FIRST);
 	*reenq_flags |= SCX_REENQ_TSR_NOT_FIRST;
 
-	if (unlikely((p->scx.flags & SCX_TASK_PROTECTED) || p == scx_rescuee(rq)))
+	if (unlikely((p->scx.flags & SCX_TASK_PROTECTED) || scx_task_has_kernel_slice(p)))
 		return false;
 
 	*reason = SCX_TASK_REENQ_KFUNC;
@@ -5091,7 +5114,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 	if ((reenq_flags & SCX_REENQ_CAP_REVOKE) &&
 	    rq->donor->sched_class == &ext_sched_class &&
 	    scx_task_reenq_on_cap_revoke(rq, rq->donor)) {
-		scx_set_task_slice(rq->donor, 0);
+		expire_task_slice(rq->donor);
 		resched_curr(rq);
 	}
 
@@ -6912,7 +6935,7 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 			if (bypass)
 				scx_task_slice_ended(rq, p);
 			else if (!scx_task_can_stay_on_cpu(rq, p))
-				scx_set_task_slice(p, 0);
+				expire_task_slice(p);
 		}
 
 		/*
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 42ac92ecb627..1c1e4d4b53cf 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -589,10 +589,11 @@ static void scx_rescue_timer_arm(struct rq *rq)
  * @p: task being admitted, off any DSQ
  * @slice: CPU time to grant
  *
- * The schedulers keep their normal control over @p and may preempt or reslice
- * it. @slice is measured on served CPU time, so neither shortens the rescue,
- * see scx_rescue_charge() and scx_rescue_keep(). Prolonged denial escalates
- * into protected execution, see scx_rescue_timerfn().
+ * The slice is a kernel slice, see %SCX_TASK_KERNEL_SLICE. The schedulers keep
+ * their normal control over @p and may preempt or reslice it. @slice is
+ * measured on served CPU time, so neither shortens the rescue, see
+ * scx_rescue_charge() and scx_rescue_keep(). Prolonged denial escalates into
+ * protected execution, see scx_rescue_timerfn().
  */
 static void scx_rescue_admit(struct rq *rq, struct task_struct *p, s64 slice)
 {
@@ -603,6 +604,7 @@ static void scx_rescue_admit(struct rq *rq, struct task_struct *p, s64 slice)
 	rq->scx.rescue.slice = slice;
 	rq->scx.rescue.served = 0;
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

