Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8E39FCB0;
	Tue, 21 Apr 2026 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756003; cv=none; b=NvE8ZLcXRPyCw/dj6CToeI1cBL7wghNbyCQTxHnl5E8rOiSGgjIuAkZdfGPTN7syZHSHmlUEdU8kOQ66qloXrKLh7kAA5QLSZ9HrVVrlQoK3lC31RQV0DMY8JaeUeM5nRIJGKLKddkAyKEjv8dE4t/hGfamuSKKebiFvST7Sz0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756003; c=relaxed/simple;
	bh=z+LaSk+HD7lxbMjQiOD5Ci8XzgfZHUiiuNJXFQRq/dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=himNW6ml4moMbrTP+J0lM6dCusyA5W9qlHS4LeVU2NRQB2ukRsfvt2hK3AXP097g2K/UBjdsov1sy4Tu4a6NchwvNd4m9tPYciUDXWf95E91ysRXW7Sxovcogazbk6iTDLiqCqMlQ3sylZ5o15Znp9TNxll8nro3G8Ut97ITeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLGxlSZU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLGxlSZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158F9C4AF09;
	Tue, 21 Apr 2026 07:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776756003;
	bh=z+LaSk+HD7lxbMjQiOD5Ci8XzgfZHUiiuNJXFQRq/dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLGxlSZUd4gt/CwRE3zLLf4Ug0eVIQZZkfVR4p9/GchGxKHqK9qe9mp2BZOUBIizm
	 7C+hYZdP+2/92wpxBwCYRbGoK938pkTWdCpvrBgAZcWJP4uwPI/rpwzr6ykih3VaB7
	 5PTEFHgyXCJxZ+KircwKcScqltQQn+Bf+PLc2c0cc2WFCkZa5CXgE0iLw2LZLMH8ix
	 34C/0q3n1YEqJCGnrjK1D00ZU/ItZIQ0c45tTrsn74gHQEO5o8OXGdnkqYB12sxgu0
	 pMxbAS2cmkjwjynOhd88+oKOiGAcb3JEhB5ZS9aikgmGCGFX/IFfKh5b8QiPY3P5Kk
	 xdGugyBh+Cbmw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 15/16] tools/sched_ext: scx_qmap: Port to cid-form struct_ops
Date: Mon, 20 Apr 2026 21:19:44 -1000
Message-ID: <20260421071945.3110084-16-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421071945.3110084-1-tj@kernel.org>
References: <20260421071945.3110084-1-tj@kernel.org>
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

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 195 +++++++++++++++------------------
 tools/sched_ext/scx_qmap.c     |  14 ++-
 tools/sched_ext/scx_qmap.h     |   2 +-
 3 files changed, 98 insertions(+), 113 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index d30ec914a118..ceb136935ffa 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -179,25 +179,24 @@ static int qmap_spin_lock(struct bpf_res_spin_lock *lock)
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
@@ -207,7 +206,7 @@ static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu,
 		if (cid >= nr_cids)
 			return -1;
 		if (cmask_test_and_clear(qa_idle_cids, cid))
-			return scx_bpf_cid_to_cpu(cid);
+			return cid;
 	}
 	return -1;
 }
@@ -308,25 +307,25 @@ static void qmap_fifo_remove(task_ctx_t *taskc)
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
 		return -ESRCH;
 
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
 
@@ -350,12 +349,12 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
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
@@ -388,14 +387,14 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 
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
@@ -411,11 +410,11 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
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
 
@@ -423,15 +422,16 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
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
 
@@ -483,7 +483,8 @@ static void update_core_sched_head_seq(struct task_struct *p)
 static bool dispatch_highpri(bool from_timer)
 {
 	struct task_struct *p;
-	s32 this_cpu = bpf_get_smp_processor_id();
+	s32 this_cid = scx_bpf_this_cid();
+	u32 nr_cids = scx_bpf_nr_cids();
 
 	/* scan SHARED_DSQ and move highpri tasks to HIGHPRI_DSQ */
 	bpf_for_each(scx_dsq, p, SHARED_DSQ, 0) {
@@ -502,21 +503,29 @@ static bool dispatch_highpri(bool from_timer)
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
+
+		if (!(taskc = lookup_task_ctx(p)))
+			return false;
 
-		if (bpf_cpumask_test_cpu(this_cpu, p->cpus_ptr))
-			cpu = this_cpu;
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
@@ -535,7 +544,7 @@ static bool dispatch_highpri(bool from_timer)
 	return false;
 }
 
-void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
+void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct task_struct *prev)
 {
 	struct task_struct *p;
 	struct cpu_ctx __arena *cpuc;
@@ -563,7 +572,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 		}
 	}
 
-	cpuc = &qa.cpu_ctxs[bpf_get_smp_processor_id()];
+	cpuc = &qa.cpu_ctxs[scx_bpf_this_cid()];
 
 	for (i = 0; i < 5; i++) {
 		/* Advance the dispatch cursor and pick the fifo. */
@@ -628,8 +637,8 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 			 * document this class of issue -- other schedulers
 			 * seeing similar warnings can use this as a reference.
 			 */
-			if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
-				scx_bpf_kick_cpu(scx_bpf_task_cpu(p), 0);
+			if (!cmask_test(&taskc->cpus_allowed, cid))
+				scx_bpf_kick_cid(scx_bpf_task_cid(p), 0);
 
 			batch--;
 			cpuc->dsp_cnt--;
@@ -666,7 +675,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 
 void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
 {
-	struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[bpf_get_smp_processor_id()];
+	struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[scx_bpf_this_cid()];
 	int idx;
 
 	/*
@@ -678,7 +687,7 @@ void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
 	idx = weight_to_idx(cpuc->avg_weight);
 	cpuc->cpuperf_target = qidx_to_cpuperf_target[idx];
 
-	scx_bpf_cpuperf_set(scx_bpf_task_cpu(p), cpuc->cpuperf_target);
+	scx_bpf_cidperf_set(scx_bpf_task_cid(p), cpuc->cpuperf_target);
 }
 
 /*
@@ -826,9 +835,9 @@ void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
 	}
 }
 
-void BPF_STRUCT_OPS(qmap_dump_cpu, struct scx_dump_ctx *dctx, s32 cpu, bool idle)
+void BPF_STRUCT_OPS(qmap_dump_cid, struct scx_dump_ctx *dctx, s32 cid, bool idle)
 {
-	struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[cpu];
+	struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[cid];
 
 	if (suppress_dump || idle)
 		return;
@@ -879,46 +888,24 @@ void BPF_STRUCT_OPS(qmap_cgroup_set_bandwidth, struct cgroup *cgrp,
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
@@ -933,59 +920,49 @@ struct {
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
-
-	bpf_for(i, 0, nr_cpu_ids) {
-		struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[i];
-		u32 cap, cur;
+	s32 cid;
 
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
@@ -1191,20 +1168,20 @@ void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_detach_args *args)
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
index 99408b1bb1ec..2cc10fd36bec 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -73,6 +73,14 @@ int main(int argc, char **argv)
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
@@ -162,9 +170,9 @@ int main(int argc, char **argv)
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
@@ -173,7 +181,7 @@ int main(int argc, char **argv)
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
2.53.0

