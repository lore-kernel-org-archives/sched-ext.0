Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555784218A5;
	Wed, 29 Apr 2026 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486910; cv=none; b=jWbMV3oiYkT/KXg920J3xSUktftKDDcdRnFgWE3Kvr9oiOQYSTwYtdv9CqCJqIKWsk9cLp68vVQrLuQeoufPGRiAzlxYKRAUSBZIIgXR2yXHBWlKlVSbrTsG2/2wXXy7UZtaU7X9u/9wOU7jtWvMQFDN36wwEHVs0TouXhotTpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486910; c=relaxed/simple;
	bh=FyeE/D7Kvo+eYv0tV07Uoh+HBdHj9Y3fwB4tInlOv88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rp6RJ3im7heFH3WY1JFXA9XIjIdujFMNHt63ySqTWXj9YsiiHoAwwpwXmkSVp9CmE29w6Zt7oC/uq0SKUBTAqvSEJ2kVZ9u5qjySYy62IGjo8jZl6QpjOUAqeTRLOdTIF32Tv5GgHN7hwqdTAcvShmie7nCSg/9VoDZXce72sEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jieP8c58; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jieP8c58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2A2C2BCB8;
	Wed, 29 Apr 2026 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486910;
	bh=FyeE/D7Kvo+eYv0tV07Uoh+HBdHj9Y3fwB4tInlOv88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jieP8c58ksiBPp9+YHmq2aVFe5Zs+0U9MGXWOU/gs9nLieo91bT1Q/YxQGwboA1wy
	 i/H0cPpUWubEYBWhXsQj+9EjmVN+YM6wwV5How3JmhewqY5hH0OIDUcoAfWSH/mLsv
	 f3ioPjyiFYlFIMEw+fTaSWO7d4qCB88FJXQnAC04jzNkpW9ITuhs2cZVXk5+vuzLYI
	 ml5ob43i9KORPzQY/aWgE/7UACrMgbWBOrpZnyg3ZTjwgqabf1Cj2Kiu1fjNMqPQ7i
	 5lktrewzvfLlpFG4/6AOQoxPpqyPrw1wTlt3eboYNxRjtI3gT83OEfW8312u+qda//
	 k37a+84ZwpYVw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 16/17] tools/sched_ext: scx_qmap: Port to cid-form struct_ops
Date: Wed, 29 Apr 2026 08:21:30 -1000
Message-ID: <20260429182131.1780125-17-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429182131.1780125-1-tj@kernel.org>
References: <20260429182131.1780125-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flip qmap's struct_ops to bpf_sched_ext_ops_cid. The kernel now passes
cids and cmasks to callbacks directly, so the per-callback cpu<->cid
translations that the prior patch added drop out and cpu_ctxs[] is
reindexed by cid. Cpu-form kfunc calls switch to their cid-form
counterparts.

The cpu-only kfuncs (idle/any pick, cpumask iteration) have no cid
substitute. Their callers already moved to cmask scans against
qa_idle_cids and taskc->cpus_allowed in the prior patch, so the kfunc
calls drop here without behavior changes.

set_cmask is wired up via cmask_copy_from_kernel() to copy the
kernel-supplied cmask into the arena-resident taskc cmask. The
cpuperf monitor iterates the cid-form perf kfuncs.

v4: Match scx_bpf_cid_override()'s 2-arg form, drop the shard test
    plumbing, bound nr_cpu_ids for the verifier, and switch mode 3
    from bad-mono to bad-range (Changwoo, Andrea).

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 241 +++++++++++++++++----------------
 tools/sched_ext/scx_qmap.c     |  46 ++++++-
 tools/sched_ext/scx_qmap.h     |   2 +-
 3 files changed, 171 insertions(+), 118 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 88ef3936937d..bea43d235908 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -52,6 +52,25 @@ const volatile bool always_enq_immed;
 const volatile u32 immed_stress_nth;
 const volatile u32 max_tasks;
 
+/*
+ * Optional cid-override test harness. When cid_override_mode is non-zero,
+ * qmap_init() calls scx_bpf_cid_override() with the caller-supplied
+ * cpu_to_cid array to exercise the kfunc's acceptance and error paths.
+ *
+ *   0 = disabled
+ *   1 = valid reverse mapping
+ *   2 = invalid: duplicate cid assignment
+ *   3 = invalid: out-of-range cid
+ */
+const volatile u32 cid_override_mode;
+/*
+ * Array lives in bss (writable) because scx_bpf_cid_override()'s BPF
+ * verifier signature treats its len-paired pointer as read/write - rodata
+ * fails verification with "write into map forbidden". Userspace populates
+ * it before SCX_OPS_LOAD, same as rodata, and nothing writes it after.
+ */
+s32 cid_override_cpu_to_cid[SCX_QMAP_MAX_CPUS];
+
 UEI_DEFINE(uei);
 
 /*
@@ -179,25 +198,24 @@ static int qmap_spin_lock(struct bpf_res_spin_lock *lock)
 }
 
 /*
- * Try prev_cpu's cid, then scan taskc->cpus_allowed AND qa_idle_cids
- * round-robin from prev_cid + 1. Atomic claim retries on race; bounded
- * by IDLE_PICK_RETRIES to keep the verifier's insn budget in check.
+ * Try prev_cid, then scan taskc->cpus_allowed AND qa_idle_cids round-robin
+ * from prev_cid + 1. Atomic claim retries on race; bounded by
+ * IDLE_PICK_RETRIES to keep the verifier's insn budget in check.
  */
 #define IDLE_PICK_RETRIES	16
 
-static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu,
+static s32 pick_direct_dispatch_cid(struct task_struct *p, s32 prev_cid,
 				    task_ctx_t *taskc)
 {
 	u32 nr_cids = scx_bpf_nr_cids();
-	s32 prev_cid, cid;
+	s32 cid;
 	u32 i;
 
 	if (!always_enq_immed && p->nr_cpus_allowed == 1)
-		return prev_cpu;
+		return prev_cid;
 
-	prev_cid = scx_bpf_cpu_to_cid(prev_cpu);
 	if (cmask_test_and_clear(qa_idle_cids, prev_cid))
-		return prev_cpu;
+		return prev_cid;
 
 	cid = prev_cid;
 	bpf_for(i, 0, IDLE_PICK_RETRIES) {
@@ -207,7 +225,7 @@ static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu,
 		if (cid >= nr_cids)
 			return -1;
 		if (cmask_test_and_clear(qa_idle_cids, cid))
-			return scx_bpf_cid_to_cpu(cid);
+			return cid;
 	}
 	return -1;
 }
@@ -308,25 +326,25 @@ static void qmap_fifo_remove(task_ctx_t *taskc)
 	bpf_res_spin_unlock(lock);
 }
 
-s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
-		   s32 prev_cpu, u64 wake_flags)
+s32 BPF_STRUCT_OPS(qmap_select_cid, struct task_struct *p,
+		   s32 prev_cid, u64 wake_flags)
 {
 	task_ctx_t *taskc;
-	s32 cpu;
+	s32 cid;
 
 	if (!(taskc = lookup_task_ctx(p)))
-		return prev_cpu;
+		return prev_cid;
 
 	if (p->scx.weight < 2 && !(p->flags & PF_KTHREAD))
-		return prev_cpu;
+		return prev_cid;
 
-	cpu = pick_direct_dispatch_cpu(p, prev_cpu, taskc);
+	cid = pick_direct_dispatch_cid(p, prev_cid, taskc);
 
-	if (cpu >= 0) {
+	if (cid >= 0) {
 		taskc->force_local = true;
-		return cpu;
+		return cid;
 	} else {
-		return prev_cpu;
+		return prev_cid;
 	}
 }
 
@@ -350,12 +368,12 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	static u32 user_cnt, kernel_cnt;
 	task_ctx_t *taskc;
 	int idx = weight_to_idx(p->scx.weight);
-	s32 cpu;
+	s32 cid;
 
 	if (enq_flags & SCX_ENQ_REENQ) {
 		__sync_fetch_and_add(&qa.nr_reenqueued, 1);
-		if (scx_bpf_task_cpu(p) == 0)
-			__sync_fetch_and_add(&qa.nr_reenqueued_cpu0, 1);
+		if (scx_bpf_task_cid(p) == 0)
+			__sync_fetch_and_add(&qa.nr_reenqueued_cid0, 1);
 	}
 
 	if (p->flags & PF_KTHREAD) {
@@ -388,14 +406,14 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 
 		if (!(++immed_stress_cnt % immed_stress_nth)) {
 			taskc->force_local = false;
-			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cpu(p),
+			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cid(p),
 					   slice_ns, enq_flags);
 			return;
 		}
 	}
 
 	/*
-	 * If qmap_select_cpu() is telling us to or this is the last runnable
+	 * If qmap_select_cid() is telling us to or this is the last runnable
 	 * task on the CPU, enqueue locally.
 	 */
 	if (taskc->force_local) {
@@ -411,11 +429,11 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
-	/* if select_cpu() wasn't called, try direct dispatch */
+	/* if select_cid() wasn't called, try direct dispatch */
 	if (!__COMPAT_is_enq_cpu_selected(enq_flags) &&
-	    (cpu = pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p), taskc)) >= 0) {
+	    (cid = pick_direct_dispatch_cid(p, scx_bpf_task_cid(p), taskc)) >= 0) {
 		__sync_fetch_and_add(&qa.nr_ddsp_from_enq, 1);
-		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, slice_ns, enq_flags);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cid, slice_ns, enq_flags);
 		return;
 	}
 
@@ -423,15 +441,16 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 * If the task was re-enqueued due to the CPU being preempted by a
 	 * higher priority scheduling class, just re-enqueue the task directly
 	 * on the global DSQ. As we want another CPU to pick it up, find and
-	 * kick an idle CPU.
+	 * kick an idle cid.
 	 */
 	if (enq_flags & SCX_ENQ_REENQ) {
-		s32 cpu;
+		s32 cid;
 
 		scx_bpf_dsq_insert(p, SHARED_DSQ, 0, enq_flags);
-		cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
-		if (cpu >= 0)
-			scx_bpf_kick_cpu(cpu, SCX_KICK_IDLE);
+		cid = cmask_next_and_set_wrap(&taskc->cpus_allowed,
+					      qa_idle_cids, 0);
+		if (cid < scx_bpf_nr_cids())
+			scx_bpf_kick_cid(cid, SCX_KICK_IDLE);
 		return;
 	}
 
@@ -483,7 +502,8 @@ static void update_core_sched_head_seq(struct task_struct *p)
 static bool dispatch_highpri(bool from_timer)
 {
 	struct task_struct *p;
-	s32 this_cpu = bpf_get_smp_processor_id();
+	s32 this_cid = scx_bpf_this_cid();
+	u32 nr_cids = scx_bpf_nr_cids();
 
 	/* scan SHARED_DSQ and move highpri tasks to HIGHPRI_DSQ */
 	bpf_for_each(scx_dsq, p, SHARED_DSQ, 0) {
@@ -502,21 +522,29 @@ static bool dispatch_highpri(bool from_timer)
 	}
 
 	/*
-	 * Scan HIGHPRI_DSQ and dispatch until a task that can run on this CPU
-	 * is found.
+	 * Scan HIGHPRI_DSQ and dispatch until a task that can run here is
+	 * found. Prefer this_cid if the task allows it; otherwise RR-scan the
+	 * task's cpus_allowed starting after this_cid.
 	 */
 	bpf_for_each(scx_dsq, p, HIGHPRI_DSQ, 0) {
+		task_ctx_t *taskc;
 		bool dispatched = false;
-		s32 cpu;
+		s32 cid;
 
-		if (bpf_cpumask_test_cpu(this_cpu, p->cpus_ptr))
-			cpu = this_cpu;
+		if (!(taskc = lookup_task_ctx(p)))
+			return false;
+
+		if (cmask_test(&taskc->cpus_allowed, this_cid))
+			cid = this_cid;
 		else
-			cpu = scx_bpf_pick_any_cpu(p->cpus_ptr, 0);
+			cid = cmask_next_set_wrap(&taskc->cpus_allowed,
+						  this_cid + 1);
+		if (cid >= nr_cids)
+			continue;
 
-		if (scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | cpu,
+		if (scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | cid,
 				     SCX_ENQ_PREEMPT)) {
-			if (cpu == this_cpu) {
+			if (cid == this_cid) {
 				dispatched = true;
 				__sync_fetch_and_add(&qa.nr_expedited_local, 1);
 			} else {
@@ -535,7 +563,7 @@ static bool dispatch_highpri(bool from_timer)
 	return false;
 }
 
-void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
+void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct task_struct *prev)
 {
 	struct task_struct *p;
 	struct cpu_ctx __arena *cpuc;
@@ -563,7 +591,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 		}
 	}
 
-	cpuc = &qa.cpu_ctxs[bpf_get_smp_processor_id()];
+	cpuc = &qa.cpu_ctxs[scx_bpf_this_cid()];
 
 	for (i = 0; i < 5; i++) {
 		/* Advance the dispatch cursor and pick the fifo. */
@@ -628,8 +656,8 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 			 * document this class of issue -- other schedulers
 			 * seeing similar warnings can use this as a reference.
 			 */
-			if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
-				scx_bpf_kick_cpu(scx_bpf_task_cpu(p), 0);
+			if (!cmask_test(&taskc->cpus_allowed, cid))
+				scx_bpf_kick_cid(scx_bpf_task_cid(p), 0);
 
 			batch--;
 			cpuc->dsp_cnt--;
@@ -668,7 +696,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 
 void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
 {
-	struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[bpf_get_smp_processor_id()];
+	struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[scx_bpf_this_cid()];
 	int idx;
 
 	/*
@@ -680,7 +708,7 @@ void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
 	idx = weight_to_idx(cpuc->avg_weight);
 	cpuc->cpuperf_target = qidx_to_cpuperf_target[idx];
 
-	scx_bpf_cpuperf_set(scx_bpf_task_cpu(p), cpuc->cpuperf_target);
+	scx_bpf_cidperf_set(scx_bpf_task_cid(p), cpuc->cpuperf_target);
 }
 
 /*
@@ -828,9 +856,9 @@ void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
 	}
 }
 
-void BPF_STRUCT_OPS(qmap_dump_cpu, struct scx_dump_ctx *dctx, s32 cpu, bool idle)
+void BPF_STRUCT_OPS(qmap_dump_cid, struct scx_dump_ctx *dctx, s32 cid, bool idle)
 {
-	struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[cpu];
+	struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[cid];
 
 	if (suppress_dump || idle)
 		return;
@@ -881,46 +909,24 @@ void BPF_STRUCT_OPS(qmap_cgroup_set_bandwidth, struct cgroup *cgrp,
 			   cgrp->kn->id, period_us, quota_us, burst_us);
 }
 
-void BPF_STRUCT_OPS(qmap_update_idle, s32 cpu, bool idle)
+void BPF_STRUCT_OPS(qmap_update_idle, s32 cid, bool idle)
 {
-	s32 cid = scx_bpf_cpu_to_cid(cpu);
-
 	QMAP_TOUCH_ARENA();
-	if (cid < 0)
-		return;
 	if (idle)
 		cmask_set(qa_idle_cids, cid);
 	else
 		cmask_clear(qa_idle_cids, cid);
 }
 
-/*
- * The cpumask received here is kernel-address memory; walk it bit by bit
- * (bpf_cpumask_test_cpu handles the access), convert each set cpu to its
- * cid, and populate the arena-resident taskc cmask.
- */
-void BPF_STRUCT_OPS(qmap_set_cpumask, struct task_struct *p,
-		    const struct cpumask *cpumask)
+void BPF_STRUCT_OPS(qmap_set_cmask, struct task_struct *p,
+		    const struct scx_cmask *cmask)
 {
 	task_ctx_t *taskc;
-	u32 nr_cpu_ids = scx_bpf_nr_cpu_ids();
-	s32 cpu;
 
 	taskc = lookup_task_ctx(p);
 	if (!taskc)
 		return;
-
-	cmask_zero(&taskc->cpus_allowed);
-
-	bpf_for(cpu, 0, nr_cpu_ids) {
-		s32 cid;
-
-		if (!bpf_cpumask_test_cpu(cpu, cpumask))
-			continue;
-		cid = scx_bpf_cpu_to_cid(cpu);
-		if (cid >= 0)
-			__cmask_set(&taskc->cpus_allowed, cid);
-	}
+	cmask_copy_from_kernel(&taskc->cpus_allowed, cmask);
 }
 
 struct monitor_timer {
@@ -935,59 +941,49 @@ struct {
 } monitor_timer SEC(".maps");
 
 /*
- * Print out the min, avg and max performance levels of CPUs every second to
- * demonstrate the cpuperf interface.
+ * Aggregate cidperf across the first nr_online_cids cids. Post-hotplug
+ * the first-N-are-online invariant drifts, so some cap/cur values may
+ * be stale. For this demo monitor that's fine; the scheduler exits on
+ * the enable-time hotplug_seq mismatch and userspace restarts, which
+ * rebuilds the layout.
  */
 static void monitor_cpuperf(void)
 {
-	u32 nr_cpu_ids;
+	u32 nr_online = scx_bpf_nr_online_cids();
 	u64 cap_sum = 0, cur_sum = 0, cur_min = SCX_CPUPERF_ONE, cur_max = 0;
 	u64 target_sum = 0, target_min = SCX_CPUPERF_ONE, target_max = 0;
-	const struct cpumask *online;
-	int i, nr_online_cpus = 0;
-
-	nr_cpu_ids = scx_bpf_nr_cpu_ids();
-	online = scx_bpf_get_online_cpumask();
+	s32 cid;
 
-	bpf_for(i, 0, nr_cpu_ids) {
-		struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[i];
-		u32 cap, cur;
-
-		if (!bpf_cpumask_test_cpu(i, online))
-			continue;
-		nr_online_cpus++;
+	QMAP_TOUCH_ARENA();
 
-		/* collect the capacity and current cpuperf */
-		cap = scx_bpf_cpuperf_cap(i);
-		cur = scx_bpf_cpuperf_cur(i);
+	bpf_for(cid, 0, nr_online) {
+		struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[cid];
+		u32 cap = scx_bpf_cidperf_cap(cid);
+		u32 cur = scx_bpf_cidperf_cur(cid);
+		u32 target;
 
 		cur_min = cur < cur_min ? cur : cur_min;
 		cur_max = cur > cur_max ? cur : cur_max;
 
-		/*
-		 * $cur is relative to $cap. Scale it down accordingly so that
-		 * it's in the same scale as other CPUs and $cur_sum/$cap_sum
-		 * makes sense.
-		 */
-		cur_sum += cur * cap / SCX_CPUPERF_ONE;
+		cur_sum += (u64)cur * cap / SCX_CPUPERF_ONE;
 		cap_sum += cap;
 
-		/* collect target */
-		cur = cpuc->cpuperf_target;
-		target_sum += cur;
-		target_min = cur < target_min ? cur : target_min;
-		target_max = cur > target_max ? cur : target_max;
+		target = cpuc->cpuperf_target;
+		target_sum += target;
+		target_min = target < target_min ? target : target_min;
+		target_max = target > target_max ? target : target_max;
 	}
 
+	if (!nr_online || !cap_sum)
+		return;
+
 	qa.cpuperf_min = cur_min;
 	qa.cpuperf_avg = cur_sum * SCX_CPUPERF_ONE / cap_sum;
 	qa.cpuperf_max = cur_max;
 
 	qa.cpuperf_target_min = target_min;
-	qa.cpuperf_target_avg = target_sum / nr_online_cpus;
+	qa.cpuperf_target_avg = target_sum / nr_online;
 	qa.cpuperf_target_max = target_max;
-
-	scx_bpf_put_cpumask(online);
 }
 
 /*
@@ -1074,14 +1070,33 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 {
 	u8 __arena *slab;
 	u32 nr_pages, key = 0, i;
+	u32 nr_cids, nr_cpu_ids;
 	struct bpf_timer *timer;
 	s32 ret;
 
-	if (scx_bpf_nr_cids() > SCX_QMAP_MAX_CPUS) {
+	nr_cids = scx_bpf_nr_cids();
+	nr_cpu_ids = scx_bpf_nr_cpu_ids();
+
+	if (nr_cids > SCX_QMAP_MAX_CPUS) {
 		scx_bpf_error("nr_cids=%u exceeds SCX_QMAP_MAX_CPUS=%d",
-			      scx_bpf_nr_cids(), SCX_QMAP_MAX_CPUS);
+			      nr_cids, SCX_QMAP_MAX_CPUS);
 		return -EINVAL;
 	}
+	if (nr_cpu_ids > SCX_QMAP_MAX_CPUS) {
+		scx_bpf_error("nr_cpu_ids=%u exceeds SCX_QMAP_MAX_CPUS=%d",
+			      nr_cpu_ids, SCX_QMAP_MAX_CPUS);
+		return -EINVAL;
+	}
+
+	/*
+	 * cid-override test hook. Must run before anything that reads the
+	 * cid space (scx_bpf_nr_cids, cmask_init, etc.). On invalid input,
+	 * the kfunc calls scx_error() which aborts the scheduler.
+	 */
+	if (cid_override_mode) {
+		scx_bpf_cid_override((const s32 *)cid_override_cpu_to_cid,
+				     nr_cpu_ids * sizeof(s32));
+	}
 
 	/*
 	 * Allocate the task_ctx slab in arena and thread the entire slab onto
@@ -1122,7 +1137,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 		scx_bpf_error("failed to allocate idle cmask");
 		return -ENOMEM;
 	}
-	cmask_init(qa_idle_cids, 0, scx_bpf_nr_cids());
+	cmask_init(qa_idle_cids, 0, nr_cids);
 
 	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
 	if (ret) {
@@ -1199,20 +1214,20 @@ void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_detach_args *args)
 	}
 }
 
-SCX_OPS_DEFINE(qmap_ops,
+SCX_OPS_CID_DEFINE(qmap_ops,
 	       .flags			= SCX_OPS_ENQ_EXITING | SCX_OPS_TID_TO_TASK,
-	       .select_cpu		= (void *)qmap_select_cpu,
+	       .select_cid		= (void *)qmap_select_cid,
 	       .enqueue			= (void *)qmap_enqueue,
 	       .dequeue			= (void *)qmap_dequeue,
 	       .dispatch		= (void *)qmap_dispatch,
 	       .tick			= (void *)qmap_tick,
 	       .core_sched_before	= (void *)qmap_core_sched_before,
-	       .set_cpumask		= (void *)qmap_set_cpumask,
+	       .set_cmask		= (void *)qmap_set_cmask,
 	       .update_idle		= (void *)qmap_update_idle,
 	       .init_task		= (void *)qmap_init_task,
 	       .exit_task		= (void *)qmap_exit_task,
 	       .dump			= (void *)qmap_dump,
-	       .dump_cpu		= (void *)qmap_dump_cpu,
+	       .dump_cid		= (void *)qmap_dump_cid,
 	       .dump_task		= (void *)qmap_dump_task,
 	       .cgroup_init		= (void *)qmap_cgroup_init,
 	       .cgroup_set_weight	= (void *)qmap_cgroup_set_weight,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 99408b1bb1ec..67ddd483a4c7 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -43,6 +43,7 @@ const char help_fmt[] =
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
+"  -C MODE       cid-override test (shuffle|bad-dup|bad-range)\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
 
@@ -73,6 +74,14 @@ int main(int argc, char **argv)
 	libbpf_set_print(libbpf_print_fn);
 	signal(SIGINT, sigint_handler);
 	signal(SIGTERM, sigint_handler);
+
+	if (libbpf_num_possible_cpus() > SCX_QMAP_MAX_CPUS) {
+		fprintf(stderr,
+			"scx_qmap: %d possible CPUs exceeds compile-time cap %d; "
+			"rebuild with larger SCX_QMAP_MAX_CPUS\n",
+			libbpf_num_possible_cpus(), SCX_QMAP_MAX_CPUS);
+		return 1;
+	}
 restart:
 	optind = 1;
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
@@ -80,7 +89,7 @@ int main(int argc, char **argv)
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:vh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -143,6 +152,35 @@ int main(int argc, char **argv)
 		case 'F':
 			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
 			break;
+		case 'C': {
+			u32 nr_cpus = libbpf_num_possible_cpus();
+			u32 mode, i;
+
+			if (!strcmp(optarg, "shuffle"))
+				mode = 1;
+			else if (!strcmp(optarg, "bad-dup"))
+				mode = 2;
+			else if (!strcmp(optarg, "bad-range"))
+				mode = 3;
+			else {
+				fprintf(stderr, "unknown cid-override mode '%s'\n", optarg);
+				return 1;
+			}
+			skel->rodata->cid_override_mode = mode;
+
+			/* shuffle: reversed cpu_to_cid, bad-dup: dup cid 0, bad-range: identity */
+			for (i = 0; i < nr_cpus; i++) {
+				if (mode == 1)
+					skel->bss->cid_override_cpu_to_cid[i] = nr_cpus - 1 - i;
+				else
+					skel->bss->cid_override_cpu_to_cid[i] = i;
+			}
+			if (mode == 2 && nr_cpus >= 2)
+				skel->bss->cid_override_cpu_to_cid[1] = 0;
+			if (mode == 3)
+				skel->bss->cid_override_cpu_to_cid[0] = (s32)nr_cpus;
+			break;
+		}
 		case 'v':
 			verbose = true;
 			break;
@@ -162,9 +200,9 @@ int main(int argc, char **argv)
 		long nr_enqueued = qa->nr_enqueued;
 		long nr_dispatched = qa->nr_dispatched;
 
-		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq/cpu0=%llu/%llu deq=%llu core=%llu enq_ddsp=%llu\n",
+		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq/cid0=%llu/%llu deq=%llu core=%llu enq_ddsp=%llu\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
-		       qa->nr_reenqueued, qa->nr_reenqueued_cpu0,
+		       qa->nr_reenqueued, qa->nr_reenqueued_cid0,
 		       qa->nr_dequeued,
 		       qa->nr_core_sched_execed,
 		       qa->nr_ddsp_from_enq);
@@ -173,7 +211,7 @@ int main(int argc, char **argv)
 		       qa->nr_expedited_remote,
 		       qa->nr_expedited_from_timer,
 		       qa->nr_expedited_lost);
-		if (__COMPAT_has_ksym("scx_bpf_cpuperf_cur"))
+		if (__COMPAT_has_ksym("scx_bpf_cidperf_cur"))
 			printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
 			       qa->cpuperf_min,
 			       qa->cpuperf_avg,
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index 9d9af2ad90c6..d15a705d5ac5 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -45,7 +45,7 @@ struct qmap_fifo {
 
 struct qmap_arena {
 	/* userspace-visible stats */
-	__u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cpu0;
+	__u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cid0;
 	__u64 nr_dequeued, nr_ddsp_from_enq;
 	__u64 nr_core_sched_execed;
 	__u64 nr_expedited_local, nr_expedited_remote;
-- 
2.54.0

