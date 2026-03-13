Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557437268C;
	Fri, 13 Mar 2026 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401483; cv=none; b=BVRXZJuB5jytQFhV559xvV/WNr3xQ9k4sx6IuSj/uhQjCLS+cPzUKv3X7ol16arMn7C/fGWqEyD5Fuhj5GeOYfqxGft4Gay1EHrxRwQJ+X2NtgAhOFzRHsrVhr8VQLrvlAZECqz6KgR+vBjbpCQ/HUhxf7HnJnSzzJb76fdyrzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401483; c=relaxed/simple;
	bh=NNiNMZXC5IF2tna4rzQJRxvV/KltQ2QP8NU1kXAaC6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPucACQjJieiMm3SLKmxfxYsHH/cJlq/CJJtXQKwJDA/wpwc7EilnaaBdhgr2igoajXjL7IRNTdhKT8a4Yro/W0rMANxx+A4OoF1wY0xxyY74MIyR8CNKprJyA4f2vErNn8BawgpO4WrW2hEjm83nkfgKKVoczGxYrjsf4Y7FZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tD3+kml3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD3+kml3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBAAC19421;
	Fri, 13 Mar 2026 11:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773401480;
	bh=NNiNMZXC5IF2tna4rzQJRxvV/KltQ2QP8NU1kXAaC6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tD3+kml3eNBimBhTt4ScDiVy6KrMfpqNnvMMUENMHHJLscXNBHVH7g/jmEn2yZrjr
	 0wSDkctLqPamjFqt/fWB4A5Ilz7W+BlM0WHNt7QsWr/F7nqa+bOy/n/Zeds06S7W92
	 9tODuDBrnATaa7zH8SkeLOEQgyj7VDWKaGXatV6elcAjqKq7hse0gvtn2Z/a1l4NJ1
	 OjqdcNvgbruisWfpC63sR4m/yFmZLVyp7LnrftJPexTgfyY9aetpWpm3LTBtPcMBeO
	 0raFPJg+QZXX/PH5eWX8xEqI7HA5gPcgeU7qMcLiftJ3veGAJbV+CYQUBz0FhYdRmy
	 blDbrhtz+1pZQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] sched_ext: Add enq_flags to scx_bpf_dsq_move_to_local()
Date: Fri, 13 Mar 2026 01:31:13 -1000
Message-ID: <20260313113114.1591010-6-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313113114.1591010-1-tj@kernel.org>
References: <20260313113114.1591010-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_move_to_local() moves a task from a non-local DSQ to the
current CPU's local DSQ. This is an indirect way of dispatching to a local
DSQ and should support enq_flags like direct dispatches do - e.g.
SCX_ENQ_HEAD for head-of-queue insertion and SCX_ENQ_IMMED for immediate
execution guarantees.

Add scx_bpf_dsq_move_to_local___v2() with an enq_flags parameter. The
original becomes a v1 compat wrapper passing 0. The compat macro is updated
to a three-level chain: v2 (7.1+) -> v1 (current) -> scx_bpf_consume
(pre-rename). All in-tree BPF schedulers are updated to pass 0.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                       | 21 ++++++++++++++++++---
 tools/sched_ext/include/scx/compat.bpf.h | 15 ++++++++++-----
 tools/sched_ext/scx_central.bpf.c        |  4 ++--
 tools/sched_ext/scx_cpu0.bpf.c           |  2 +-
 tools/sched_ext/scx_flatcg.bpf.c         |  6 +++---
 tools/sched_ext/scx_qmap.bpf.c           |  4 ++--
 tools/sched_ext/scx_sdt.bpf.c            |  2 +-
 tools/sched_ext/scx_simple.bpf.c         |  2 +-
 8 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9dd51f0c9a53..553730836000 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8160,9 +8160,11 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
  * scx_bpf_dsq_move_to_local - move a task from a DSQ to the current CPU's local DSQ
  * @dsq_id: DSQ to move task from
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ * @enq_flags: %SCX_ENQ_*
  *
  * Move a task from the non-local DSQ identified by @dsq_id to the current CPU's
- * local DSQ for execution. Can only be called from ops.dispatch().
+ * local DSQ for execution with @enq_flags applied. Can only be called from
+ * ops.dispatch().
  *
  * This function flushes the in-flight dispatches from scx_bpf_dsq_insert()
  * before trying to move from the specified DSQ. It may also grab rq locks and
@@ -8171,7 +8173,8 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
  * Returns %true if a task has been moved, %false if there isn't any task to
  * move.
  */
-__bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux *aux)
+__bpf_kfunc bool scx_bpf_dsq_move_to_local___v2(u64 dsq_id, u64 enq_flags,
+						const struct bpf_prog_aux *aux)
 {
 	struct scx_dispatch_q *dsq;
 	struct scx_sched *sch;
@@ -8186,6 +8189,9 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
+	if (!scx_vet_enq_flags(sch, SCX_DSQ_LOCAL, enq_flags))
+		return false;
+
 	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 
 	flush_dispatch_buf(sch, dspc->rq);
@@ -8196,7 +8202,7 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux
 		return false;
 	}
 
-	if (consume_dispatch_q(sch, dspc->rq, dsq, 0)) {
+	if (consume_dispatch_q(sch, dspc->rq, dsq, enq_flags)) {
 		/*
 		 * A successfully consumed task can be dequeued before it starts
 		 * running while the CPU is trying to migrate other dispatched
@@ -8210,6 +8216,14 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux
 	}
 }
 
+/*
+ * COMPAT: ___v2 was introduced in v7.1. Remove this and ___v2 tag in the future.
+ */
+__bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux *aux)
+{
+	return scx_bpf_dsq_move_to_local___v2(dsq_id, 0, aux);
+}
+
 /**
  * scx_bpf_dsq_move_set_slice - Override slice when moving between DSQs
  * @it__iter: DSQ iterator in progress
@@ -8353,6 +8367,7 @@ BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local___v2, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index cba37432eec0..83b3425e63b2 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -28,8 +28,11 @@ struct cgroup *scx_bpf_task_cgroup___new(struct task_struct *p) __ksym __weak;
  *
  * scx_bpf_dispatch_from_dsq() and friends were added during v6.12 by
  * 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()").
+ *
+ * v7.1: scx_bpf_dsq_move_to_local___v2() to add @enq_flags.
  */
-bool scx_bpf_dsq_move_to_local___new(u64 dsq_id) __ksym __weak;
+bool scx_bpf_dsq_move_to_local___v2(u64 dsq_id, u64 enq_flags) __ksym __weak;
+bool scx_bpf_dsq_move_to_local___v1(u64 dsq_id) __ksym __weak;
 void scx_bpf_dsq_move_set_slice___new(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
 void scx_bpf_dsq_move_set_vtime___new(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
 bool scx_bpf_dsq_move___new(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
@@ -41,10 +44,12 @@ void scx_bpf_dispatch_from_dsq_set_vtime___old(struct bpf_iter_scx_dsq *it__iter
 bool scx_bpf_dispatch_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 
-#define scx_bpf_dsq_move_to_local(dsq_id)					\
-	(bpf_ksym_exists(scx_bpf_dsq_move_to_local___new) ?			\
-	 scx_bpf_dsq_move_to_local___new((dsq_id)) :				\
-	 scx_bpf_consume___old((dsq_id)))
+#define scx_bpf_dsq_move_to_local(dsq_id, enq_flags)				\
+	(bpf_ksym_exists(scx_bpf_dsq_move_to_local___v2) ?			\
+	 scx_bpf_dsq_move_to_local___v2((dsq_id), (enq_flags)) :		\
+	 (bpf_ksym_exists(scx_bpf_dsq_move_to_local___v1) ?			\
+	  scx_bpf_dsq_move_to_local___v1((dsq_id)) :				\
+	  scx_bpf_consume___old((dsq_id))))
 
 #define scx_bpf_dsq_move_set_slice(it__iter, slice)				\
 	(bpf_ksym_exists(scx_bpf_dsq_move_set_slice___new) ?			\
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 1c2376b75b5d..399e8d3f8bec 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -214,13 +214,13 @@ void BPF_STRUCT_OPS(central_dispatch, s32 cpu, struct task_struct *prev)
 		}
 
 		/* look for a task to run on the central CPU */
-		if (scx_bpf_dsq_move_to_local(FALLBACK_DSQ_ID))
+		if (scx_bpf_dsq_move_to_local(FALLBACK_DSQ_ID, 0))
 			return;
 		dispatch_to_cpu(central_cpu);
 	} else {
 		bool *gimme;
 
-		if (scx_bpf_dsq_move_to_local(FALLBACK_DSQ_ID))
+		if (scx_bpf_dsq_move_to_local(FALLBACK_DSQ_ID, 0))
 			return;
 
 		gimme = ARRAY_ELEM_PTR(cpu_gimme_task, cpu, nr_cpu_ids);
diff --git a/tools/sched_ext/scx_cpu0.bpf.c b/tools/sched_ext/scx_cpu0.bpf.c
index 9b67ab11b04c..0b1a7ce879b0 100644
--- a/tools/sched_ext/scx_cpu0.bpf.c
+++ b/tools/sched_ext/scx_cpu0.bpf.c
@@ -66,7 +66,7 @@ void BPF_STRUCT_OPS(cpu0_enqueue, struct task_struct *p, u64 enq_flags)
 void BPF_STRUCT_OPS(cpu0_dispatch, s32 cpu, struct task_struct *prev)
 {
 	if (cpu == 0)
-		scx_bpf_dsq_move_to_local(DSQ_CPU0);
+		scx_bpf_dsq_move_to_local(DSQ_CPU0, 0);
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(cpu0_init)
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index a8a9234bb41e..1351377f64d5 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -660,7 +660,7 @@ static bool try_pick_next_cgroup(u64 *cgidp)
 		goto out_free;
 	}
 
-	if (!scx_bpf_dsq_move_to_local(cgid)) {
+	if (!scx_bpf_dsq_move_to_local(cgid, 0)) {
 		bpf_cgroup_release(cgrp);
 		stat_inc(FCG_STAT_PNC_EMPTY);
 		goto out_stash;
@@ -740,7 +740,7 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
 		goto pick_next_cgroup;
 
 	if (time_before(now, cpuc->cur_at + cgrp_slice_ns)) {
-		if (scx_bpf_dsq_move_to_local(cpuc->cur_cgid)) {
+		if (scx_bpf_dsq_move_to_local(cpuc->cur_cgid, 0)) {
 			stat_inc(FCG_STAT_CNS_KEEP);
 			return;
 		}
@@ -780,7 +780,7 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
 pick_next_cgroup:
 	cpuc->cur_at = now;
 
-	if (scx_bpf_dsq_move_to_local(FALLBACK_DSQ)) {
+	if (scx_bpf_dsq_move_to_local(FALLBACK_DSQ, 0)) {
 		cpuc->cur_cgid = 0;
 		return;
 	}
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index a4a1b84fe359..6d34115cb8bd 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -395,7 +395,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	if (dispatch_highpri(false))
 		return;
 
-	if (!nr_highpri_queued && scx_bpf_dsq_move_to_local(SHARED_DSQ))
+	if (!nr_highpri_queued && scx_bpf_dsq_move_to_local(SHARED_DSQ, 0))
 		return;
 
 	if (dsp_inf_loop_after && nr_dispatched > dsp_inf_loop_after) {
@@ -460,7 +460,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 			if (!batch || !scx_bpf_dispatch_nr_slots()) {
 				if (dispatch_highpri(false))
 					return;
-				scx_bpf_dsq_move_to_local(SHARED_DSQ);
+				scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);
 				return;
 			}
 			if (!cpuc->dsp_cnt)
diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.c
index 31b09958e8d5..10248b71ef02 100644
--- a/tools/sched_ext/scx_sdt.bpf.c
+++ b/tools/sched_ext/scx_sdt.bpf.c
@@ -643,7 +643,7 @@ void BPF_STRUCT_OPS(sdt_enqueue, struct task_struct *p, u64 enq_flags)
 
 void BPF_STRUCT_OPS(sdt_dispatch, s32 cpu, struct task_struct *prev)
 {
-	scx_bpf_dsq_move_to_local(SHARED_DSQ);
+	scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(sdt_init_task, struct task_struct *p,
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index b456bd7cae77..9ad6f0949987 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -89,7 +89,7 @@ void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
 
 void BPF_STRUCT_OPS(simple_dispatch, s32 cpu, struct task_struct *prev)
 {
-	scx_bpf_dsq_move_to_local(SHARED_DSQ);
+	scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);
 }
 
 void BPF_STRUCT_OPS(simple_running, struct task_struct *p)
-- 
2.53.0

