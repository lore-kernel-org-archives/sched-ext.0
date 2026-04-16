Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4840391E41;
	Thu, 16 Apr 2026 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327390; cv=none; b=Sk8BZ8D9DEFMUGYB1DaAA1Uy/ams+ZxFfihHOd2EIBOcBxmS/vhAlzc/fXO8wic5AD0MoPvGeeETKIFd1I3lAeRp8JEsU55U9JA9MFA6EKA1Nzdan2HLp1fYZyZrg8ON4EkaasfKaA1ZpTAu15VZMexreDwdofxDIsDgotiRypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327390; c=relaxed/simple;
	bh=PrWznXVOrwDrpjq81xUWziq+9Y1aI0lFF6LWFVtjh6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBqi3iaueFBsEsKaN0G3jsyiRzzlgjcXxGY/UvcVeit+7/FXBfVzEpT0MQD1BfhgUhoCOT0HPqfgNzE4Utiy8lJRe0XKpIp3pmOozWdnibhc/CO2ZrZYRdl4D+5Ol4rO6FB8Z/hfhtNzpFvhQ5EeRKeV3D0iu1YovdeqKlRB4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG3/xFlb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG3/xFlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C84C2BCB3;
	Thu, 16 Apr 2026 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776327390;
	bh=PrWznXVOrwDrpjq81xUWziq+9Y1aI0lFF6LWFVtjh6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kG3/xFlbCaHrrKrzVj9Vt+f7Wj6mc6uyXj6WoVqTkeFtpSCHrgGZ1TJ6Mm7Au5YBZ
	 WcT9t2S+e00LQwNxgMXVjTGnS5SOLd01Vl91cbTObcRkclDLkCAQLe7y0dKM3qFWAT
	 uZrCWpMQTParuHGCoXdiC2JZsmuj2kOrJD+P9MZaBys9nE3clIzOWy9I0ud0R5OcsS
	 4iNnM5eq/kJLGUTLHUErZAaHlFLog0PCoclRVFM6XcsLM5kJikFUwxBEsInuht96Gy
	 27zta0ydpsLh29/5TFZy8N7YkYpCheYbg9Yuy1VxrZ1RjTTdClt9lDPpieb7tMCdYQ
	 hwipVWdieILQA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] sched_ext: scx_qmap: move globals and cpu_ctx into a BPF arena map
Date: Wed, 15 Apr 2026 22:16:24 -1000
Message-ID: <20260416081626.1285617-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416081626.1285617-1-tj@kernel.org>
References: <20260416081626.1285617-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arena simplifies verification and allows more natural programming.
Convert scx_qmap to arena as preparation for further sub-sched work.

Move mutable scheduler state from BSS globals and a percpu array map
into a single BPF arena map. A shared struct qmap_arena is declared as
an __arena global so BPF accesses it directly and userspace reaches it
through skel->arena->qa.

Scheduling logic unchanged; only memory backing changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 152 ++++++++++++++-------------------
 tools/sched_ext/scx_qmap.c     |  45 +++++-----
 tools/sched_ext/scx_qmap.h     |  57 +++++++++++++
 3 files changed, 147 insertions(+), 107 deletions(-)
 create mode 100644 tools/sched_ext/scx_qmap.h

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index a18234f3c27a..0f8fbb6d0bc2 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -22,6 +22,8 @@
  */
 #include <scx/common.bpf.h>
 
+#include "scx_qmap.h"
+
 enum consts {
 	ONE_SEC_IN_NS		= 1000000000,
 	ONE_MSEC_IN_NS		= 1000000,
@@ -48,14 +50,26 @@ const volatile bool suppress_dump;
 const volatile bool always_enq_immed;
 const volatile u32 immed_stress_nth;
 
-u64 nr_highpri_queued;
-u32 test_error_cnt;
-
-#define MAX_SUB_SCHEDS		8
-u64 sub_sched_cgroup_ids[MAX_SUB_SCHEDS];
-
 UEI_DEFINE(uei);
 
+/*
+ * All mutable scheduler state - per-cpu context, stats counters, core-sched
+ * sequence numbers, sub-sched cgroup ids - lives in this single BPF arena map.
+ * Userspace reaches it via skel->arena->qa.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1 << 16);		/* upper bound in pages */
+#if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
+	__ulong(map_extra, 0x1ull << 32);	/* user/BPF mmap base */
+#else
+	__ulong(map_extra, 0x1ull << 44);
+#endif
+} arena SEC(".maps");
+
+struct qmap_arena __arena qa;
+
 struct qmap {
 	__uint(type, BPF_MAP_TYPE_QUEUE);
 	__uint(max_entries, 4096);
@@ -102,8 +116,6 @@ static const u32 qidx_to_cpuperf_target[] = {
  * task's seq and the associated queue's head seq is called the queue distance
  * and used when comparing two tasks for ordering. See qmap_core_sched_before().
  */
-static u64 core_sched_head_seqs[5];
-static u64 core_sched_tail_seqs[5];
 
 /* Per-task scheduling context */
 struct task_ctx {
@@ -119,27 +131,6 @@ struct {
 	__type(value, struct task_ctx);
 } task_ctx_stor SEC(".maps");
 
-struct cpu_ctx {
-	u64	dsp_idx;	/* dispatch index */
-	u64	dsp_cnt;	/* remaining count */
-	u32	avg_weight;
-	u32	cpuperf_target;
-};
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, u32);
-	__type(value, struct cpu_ctx);
-} cpu_ctx_stor SEC(".maps");
-
-/* Statistics */
-u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cpu0, nr_dequeued, nr_ddsp_from_enq;
-u64 nr_core_sched_execed;
-u64 nr_expedited_local, nr_expedited_remote, nr_expedited_lost, nr_expedited_from_timer;
-u32 cpuperf_min, cpuperf_avg, cpuperf_max;
-u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
-
 static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
 {
 	s32 cpu;
@@ -215,9 +206,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	s32 cpu;
 
 	if (enq_flags & SCX_ENQ_REENQ) {
-		__sync_fetch_and_add(&nr_reenqueued, 1);
+		__sync_fetch_and_add(&qa.nr_reenqueued, 1);
 		if (scx_bpf_task_cpu(p) == 0)
-			__sync_fetch_and_add(&nr_reenqueued_cpu0, 1);
+			__sync_fetch_and_add(&qa.nr_reenqueued_cpu0, 1);
 	}
 
 	if (p->flags & PF_KTHREAD) {
@@ -228,7 +219,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 			return;
 	}
 
-	if (test_error_cnt && !--test_error_cnt)
+	if (qa.test_error_cnt && !--qa.test_error_cnt)
 		scx_bpf_error("test triggering error");
 
 	if (!(taskc = lookup_task_ctx(p)))
@@ -238,7 +229,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 * All enqueued tasks must have their core_sched_seq updated for correct
 	 * core-sched ordering. Also, take a look at the end of qmap_dispatch().
 	 */
-	taskc->core_sched_seq = core_sched_tail_seqs[idx]++;
+	taskc->core_sched_seq = qa.core_sched_tail_seqs[idx]++;
 
 	/*
 	 * IMMED stress testing: Every immed_stress_nth'th enqueue, dispatch
@@ -276,7 +267,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	/* if select_cpu() wasn't called, try direct dispatch */
 	if (!__COMPAT_is_enq_cpu_selected(enq_flags) &&
 	    (cpu = pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p))) >= 0) {
-		__sync_fetch_and_add(&nr_ddsp_from_enq, 1);
+		__sync_fetch_and_add(&qa.nr_ddsp_from_enq, 1);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, slice_ns, enq_flags);
 		return;
 	}
@@ -311,9 +302,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 
 	if (highpri_boosting && p->scx.weight >= HIGHPRI_WEIGHT) {
 		taskc->highpri = true;
-		__sync_fetch_and_add(&nr_highpri_queued, 1);
+		__sync_fetch_and_add(&qa.nr_highpri_queued, 1);
 	}
-	__sync_fetch_and_add(&nr_enqueued, 1);
+	__sync_fetch_and_add(&qa.nr_enqueued, 1);
 }
 
 /*
@@ -322,9 +313,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
  */
 void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags)
 {
-	__sync_fetch_and_add(&nr_dequeued, 1);
+	__sync_fetch_and_add(&qa.nr_dequeued, 1);
 	if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC)
-		__sync_fetch_and_add(&nr_core_sched_execed, 1);
+		__sync_fetch_and_add(&qa.nr_core_sched_execed, 1);
 }
 
 static void update_core_sched_head_seq(struct task_struct *p)
@@ -333,7 +324,7 @@ static void update_core_sched_head_seq(struct task_struct *p)
 	struct task_ctx *taskc;
 
 	if ((taskc = lookup_task_ctx(p)))
-		core_sched_head_seqs[idx] = taskc->core_sched_seq;
+		qa.core_sched_head_seqs[idx] = taskc->core_sched_seq;
 }
 
 /*
@@ -384,14 +375,14 @@ static bool dispatch_highpri(bool from_timer)
 				     SCX_ENQ_PREEMPT)) {
 			if (cpu == this_cpu) {
 				dispatched = true;
-				__sync_fetch_and_add(&nr_expedited_local, 1);
+				__sync_fetch_and_add(&qa.nr_expedited_local, 1);
 			} else {
-				__sync_fetch_and_add(&nr_expedited_remote, 1);
+				__sync_fetch_and_add(&qa.nr_expedited_remote, 1);
 			}
 			if (from_timer)
-				__sync_fetch_and_add(&nr_expedited_from_timer, 1);
+				__sync_fetch_and_add(&qa.nr_expedited_from_timer, 1);
 		} else {
-			__sync_fetch_and_add(&nr_expedited_lost, 1);
+			__sync_fetch_and_add(&qa.nr_expedited_lost, 1);
 		}
 
 		if (dispatched)
@@ -404,19 +395,19 @@ static bool dispatch_highpri(bool from_timer)
 void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 {
 	struct task_struct *p;
-	struct cpu_ctx *cpuc;
+	struct cpu_ctx __arena *cpuc;
 	struct task_ctx *taskc;
-	u32 zero = 0, batch = dsp_batch ?: 1;
+	u32 batch = dsp_batch ?: 1;
 	void *fifo;
 	s32 i, pid;
 
 	if (dispatch_highpri(false))
 		return;
 
-	if (!nr_highpri_queued && scx_bpf_dsq_move_to_local(SHARED_DSQ, 0))
+	if (!qa.nr_highpri_queued && scx_bpf_dsq_move_to_local(SHARED_DSQ, 0))
 		return;
 
-	if (dsp_inf_loop_after && nr_dispatched > dsp_inf_loop_after) {
+	if (dsp_inf_loop_after && qa.nr_dispatched > dsp_inf_loop_after) {
 		/*
 		 * PID 2 should be kthreadd which should mostly be idle and off
 		 * the scheduler. Let's keep dispatching it to force the kernel
@@ -430,10 +421,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 		}
 	}
 
-	if (!(cpuc = bpf_map_lookup_elem(&cpu_ctx_stor, &zero))) {
-		scx_bpf_error("failed to look up cpu_ctx");
-		return;
-	}
+	cpuc = &qa.cpu_ctxs[bpf_get_smp_processor_id()];
 
 	for (i = 0; i < 5; i++) {
 		/* Advance the dispatch cursor and pick the fifo. */
@@ -442,9 +430,11 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 			cpuc->dsp_cnt = 1 << cpuc->dsp_idx;
 		}
 
-		fifo = bpf_map_lookup_elem(&queue_arr, &cpuc->dsp_idx);
+		u64 dsp_idx = cpuc->dsp_idx;
+
+		fifo = bpf_map_lookup_elem(&queue_arr, &dsp_idx);
 		if (!fifo) {
-			scx_bpf_error("failed to find ring %llu", cpuc->dsp_idx);
+			scx_bpf_error("failed to find ring %llu", dsp_idx);
 			return;
 		}
 
@@ -465,10 +455,10 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 			}
 
 			if (taskc->highpri)
-				__sync_fetch_and_sub(&nr_highpri_queued, 1);
+				__sync_fetch_and_sub(&qa.nr_highpri_queued, 1);
 
 			update_core_sched_head_seq(p);
-			__sync_fetch_and_add(&nr_dispatched, 1);
+			__sync_fetch_and_add(&qa.nr_dispatched, 1);
 
 			scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, 0);
 
@@ -529,8 +519,8 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	}
 
 	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
-		if (sub_sched_cgroup_ids[i] &&
-		    scx_bpf_sub_dispatch(sub_sched_cgroup_ids[i]))
+		if (qa.sub_sched_cgroup_ids[i] &&
+		    scx_bpf_sub_dispatch(qa.sub_sched_cgroup_ids[i]))
 			return;
 	}
 
@@ -546,21 +536,15 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 		}
 
 		taskc->core_sched_seq =
-			core_sched_tail_seqs[weight_to_idx(prev->scx.weight)]++;
+			qa.core_sched_tail_seqs[weight_to_idx(prev->scx.weight)]++;
 	}
 }
 
 void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
 {
-	struct cpu_ctx *cpuc;
-	u32 zero = 0;
+	struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[bpf_get_smp_processor_id()];
 	int idx;
 
-	if (!(cpuc = bpf_map_lookup_elem(&cpu_ctx_stor, &zero))) {
-		scx_bpf_error("failed to look up cpu_ctx");
-		return;
-	}
-
 	/*
 	 * Use the running avg of weights to select the target cpuperf level.
 	 * This is a demonstration of the cpuperf feature rather than a
@@ -589,7 +573,7 @@ static s64 task_qdist(struct task_struct *p)
 		return 0;
 	}
 
-	qdist = taskc->core_sched_seq - core_sched_head_seqs[idx];
+	qdist = taskc->core_sched_seq - qa.core_sched_head_seqs[idx];
 
 	/*
 	 * As queue index increments, the priority doubles. The queue w/ index 3
@@ -679,13 +663,10 @@ void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
 
 void BPF_STRUCT_OPS(qmap_dump_cpu, struct scx_dump_ctx *dctx, s32 cpu, bool idle)
 {
-	u32 zero = 0;
-	struct cpu_ctx *cpuc;
+	struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[cpu];
 
 	if (suppress_dump || idle)
 		return;
-	if (!(cpuc = bpf_map_lookup_percpu_elem(&cpu_ctx_stor, &zero, cpu)))
-		return;
 
 	scx_bpf_dump("QMAP: dsp_idx=%llu dsp_cnt=%llu avg_weight=%u cpuperf_target=%u",
 		     cpuc->dsp_idx, cpuc->dsp_cnt, cpuc->avg_weight,
@@ -802,7 +783,7 @@ struct {
  */
 static void monitor_cpuperf(void)
 {
-	u32 zero = 0, nr_cpu_ids;
+	u32 nr_cpu_ids;
 	u64 cap_sum = 0, cur_sum = 0, cur_min = SCX_CPUPERF_ONE, cur_max = 0;
 	u64 target_sum = 0, target_min = SCX_CPUPERF_ONE, target_max = 0;
 	const struct cpumask *online;
@@ -812,7 +793,7 @@ static void monitor_cpuperf(void)
 	online = scx_bpf_get_online_cpumask();
 
 	bpf_for(i, 0, nr_cpu_ids) {
-		struct cpu_ctx *cpuc;
+		struct cpu_ctx __arena *cpuc = &qa.cpu_ctxs[i];
 		u32 cap, cur;
 
 		if (!bpf_cpumask_test_cpu(i, online))
@@ -834,11 +815,6 @@ static void monitor_cpuperf(void)
 		cur_sum += cur * cap / SCX_CPUPERF_ONE;
 		cap_sum += cap;
 
-		if (!(cpuc = bpf_map_lookup_percpu_elem(&cpu_ctx_stor, &zero, i))) {
-			scx_bpf_error("failed to look up cpu_ctx");
-			goto out;
-		}
-
 		/* collect target */
 		cur = cpuc->cpuperf_target;
 		target_sum += cur;
@@ -846,14 +822,14 @@ static void monitor_cpuperf(void)
 		target_max = cur > target_max ? cur : target_max;
 	}
 
-	cpuperf_min = cur_min;
-	cpuperf_avg = cur_sum * SCX_CPUPERF_ONE / cap_sum;
-	cpuperf_max = cur_max;
+	qa.cpuperf_min = cur_min;
+	qa.cpuperf_avg = cur_sum * SCX_CPUPERF_ONE / cap_sum;
+	qa.cpuperf_max = cur_max;
+
+	qa.cpuperf_target_min = target_min;
+	qa.cpuperf_target_avg = target_sum / nr_online_cpus;
+	qa.cpuperf_target_max = target_max;
 
-	cpuperf_target_min = target_min;
-	cpuperf_target_avg = target_sum / nr_online_cpus;
-	cpuperf_target_max = target_max;
-out:
 	scx_bpf_put_cpumask(online);
 }
 
@@ -996,8 +972,8 @@ s32 BPF_STRUCT_OPS(qmap_sub_attach, struct scx_sub_attach_args *args)
 	s32 i;
 
 	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
-		if (!sub_sched_cgroup_ids[i]) {
-			sub_sched_cgroup_ids[i] = args->ops->sub_cgroup_id;
+		if (!qa.sub_sched_cgroup_ids[i]) {
+			qa.sub_sched_cgroup_ids[i] = args->ops->sub_cgroup_id;
 			bpf_printk("attaching sub-sched[%d] on %s",
 				   i, args->cgroup_path);
 			return 0;
@@ -1012,8 +988,8 @@ void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_detach_args *args)
 	s32 i;
 
 	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
-		if (sub_sched_cgroup_ids[i] == args->ops->sub_cgroup_id) {
-			sub_sched_cgroup_ids[i] = 0;
+		if (qa.sub_sched_cgroup_ids[i] == args->ops->sub_cgroup_id) {
+			qa.sub_sched_cgroup_ids[i] = 0;
 			bpf_printk("detaching sub-sched[%d] on %s",
 				   i, args->cgroup_path);
 			break;
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index e7c89a2bc3d8..8844499c14c4 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -10,9 +10,11 @@
 #include <inttypes.h>
 #include <signal.h>
 #include <libgen.h>
+#include <sys/mman.h>
 #include <sys/stat.h>
 #include <bpf/bpf.h>
 #include <scx/common.h>
+#include "scx_qmap.h"
 #include "scx_qmap.bpf.skel.h"
 
 const char help_fmt[] =
@@ -60,6 +62,8 @@ int main(int argc, char **argv)
 {
 	struct scx_qmap *skel;
 	struct bpf_link *link;
+	struct qmap_arena *qa;
+	__u32 test_error_cnt = 0;
 	int opt;
 
 	libbpf_set_print(libbpf_print_fn);
@@ -76,7 +80,7 @@ int main(int argc, char **argv)
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
 			break;
 		case 'e':
-			skel->bss->test_error_cnt = strtoul(optarg, NULL, 0);
+			test_error_cnt = strtoul(optarg, NULL, 0);
 			break;
 		case 't':
 			skel->rodata->stall_user_nth = strtoul(optarg, NULL, 0);
@@ -142,29 +146,32 @@ int main(int argc, char **argv)
 	SCX_OPS_LOAD(skel, qmap_ops, scx_qmap, uei);
 	link = SCX_OPS_ATTACH(skel, qmap_ops, scx_qmap);
 
+	qa = &skel->arena->qa;
+	qa->test_error_cnt = test_error_cnt;
+
 	while (!exit_req && !UEI_EXITED(skel, uei)) {
-		long nr_enqueued = skel->bss->nr_enqueued;
-		long nr_dispatched = skel->bss->nr_dispatched;
+		long nr_enqueued = qa->nr_enqueued;
+		long nr_dispatched = qa->nr_dispatched;
 
-		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq/cpu0=%"PRIu64"/%"PRIu64" deq=%"PRIu64" core=%"PRIu64" enq_ddsp=%"PRIu64"\n",
+		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq/cpu0=%llu/%llu deq=%llu core=%llu enq_ddsp=%llu\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
-		       skel->bss->nr_reenqueued, skel->bss->nr_reenqueued_cpu0,
-		       skel->bss->nr_dequeued,
-		       skel->bss->nr_core_sched_execed,
-		       skel->bss->nr_ddsp_from_enq);
-		printf("         exp_local=%"PRIu64" exp_remote=%"PRIu64" exp_timer=%"PRIu64" exp_lost=%"PRIu64"\n",
-		       skel->bss->nr_expedited_local,
-		       skel->bss->nr_expedited_remote,
-		       skel->bss->nr_expedited_from_timer,
-		       skel->bss->nr_expedited_lost);
+		       qa->nr_reenqueued, qa->nr_reenqueued_cpu0,
+		       qa->nr_dequeued,
+		       qa->nr_core_sched_execed,
+		       qa->nr_ddsp_from_enq);
+		printf("         exp_local=%llu exp_remote=%llu exp_timer=%llu exp_lost=%llu\n",
+		       qa->nr_expedited_local,
+		       qa->nr_expedited_remote,
+		       qa->nr_expedited_from_timer,
+		       qa->nr_expedited_lost);
 		if (__COMPAT_has_ksym("scx_bpf_cpuperf_cur"))
 			printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
-			       skel->bss->cpuperf_min,
-			       skel->bss->cpuperf_avg,
-			       skel->bss->cpuperf_max,
-			       skel->bss->cpuperf_target_min,
-			       skel->bss->cpuperf_target_avg,
-			       skel->bss->cpuperf_target_max);
+			       qa->cpuperf_min,
+			       qa->cpuperf_avg,
+			       qa->cpuperf_max,
+			       qa->cpuperf_target_min,
+			       qa->cpuperf_target_avg,
+			       qa->cpuperf_target_max);
 		fflush(stdout);
 		sleep(1);
 	}
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
new file mode 100644
index 000000000000..52153230bfce
--- /dev/null
+++ b/tools/sched_ext/scx_qmap.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Shared definitions between scx_qmap.bpf.c and scx_qmap.c.
+ *
+ * The scheduler keeps all mutable state in a single BPF arena map. struct
+ * qmap_arena is the one object that lives at the base of the arena and is
+ * mmap'd into userspace so the loader can read counters directly.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
+ */
+#ifndef __SCX_QMAP_H
+#define __SCX_QMAP_H
+
+#ifdef __BPF__
+#include <scx/bpf_arena_common.bpf.h>
+#else
+#include <linux/types.h>
+#include <scx/bpf_arena_common.h>
+#endif
+
+#define MAX_SUB_SCHEDS		8
+
+/*
+ * cpu_ctxs[] is sized to a fixed cap so the layout is shared between BPF and
+ * userspace. Keep this in sync with NR_CPUS used by the BPF side.
+ */
+#define SCX_QMAP_MAX_CPUS	1024
+
+struct cpu_ctx {
+	__u64 dsp_idx;		/* dispatch index */
+	__u64 dsp_cnt;		/* remaining count */
+	__u32 avg_weight;
+	__u32 cpuperf_target;
+};
+
+struct qmap_arena {
+	/* userspace-visible stats */
+	__u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cpu0;
+	__u64 nr_dequeued, nr_ddsp_from_enq;
+	__u64 nr_core_sched_execed;
+	__u64 nr_expedited_local, nr_expedited_remote;
+	__u64 nr_expedited_lost, nr_expedited_from_timer;
+	__u64 nr_highpri_queued;
+	__u32 test_error_cnt;
+	__u32 cpuperf_min, cpuperf_avg, cpuperf_max;
+	__u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
+
+	/* kernel-side runtime state */
+	__u64 sub_sched_cgroup_ids[MAX_SUB_SCHEDS];
+	__u64 core_sched_head_seqs[5];
+	__u64 core_sched_tail_seqs[5];
+
+	struct cpu_ctx cpu_ctxs[SCX_QMAP_MAX_CPUS];
+};
+
+#endif /* __SCX_QMAP_H */
-- 
2.53.0

