Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E43909BD;
	Thu, 16 Apr 2026 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327390; cv=none; b=VOg1h0f8d4Gic5d9/Oix24dbxd65T4Nl5nGNKP6AHseY/HTzwH7/zXGqsvP7dY73bPsqPHIWmyyab5FKbuqTZYkMB7hyedi4Xh2sIzbqhTogdm7nxA0ihz9lgoQzbsLolbLfnKon950nuwaC90NqGsVQ8EuxdPIVeK89vKrADs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327390; c=relaxed/simple;
	bh=YmdMaGfP8s9w29aAUbLNtfNJ+yN+vWK5loAF78/QXlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUMOE3fRDe5FvqoXf0knn/KL0jNXboLZqCuMEMu4tv+m6GPDxmo1EjbUiuUO17NsBFgbhFSogTKemUFmomK7Uys9IgDf5kYftZS1qy9UsxSil7Q4pWVTRmqAg0fmkZ1BI7dU36vpicUtewjsumucIWxXIZ+WEVcvyknrcZ67+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz62GDFl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz62GDFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E403C2BCB5;
	Thu, 16 Apr 2026 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776327389;
	bh=YmdMaGfP8s9w29aAUbLNtfNJ+yN+vWK5loAF78/QXlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vz62GDFlxRpGs1mQkU6bZAd8N4PuywQz+J+T5rOaNCJIYsELKf4KJN5ODCQ4imGYB
	 byyxqPaww4FQMV0U4ohDv9V7oGu/38+ZdmTKyZcFdgxOcOFntP5OQ5/iaWJ6pvZC2d
	 t1MGr+5ps1Dn7k11NjHlm192SCxGrjf3z6PnKbnrop/cu80whWxL98TQc+AKShgFvB
	 1QTL45P1JYNDlaTKHgTDTOCllr2jUjvJBhzxioO65xg7tnrePk0FCMWjdhmzjr5GB1
	 OEfD2MdDffvor9hY5dCHMpkIVkeO18vHDQs0xEiD8uE3D/BoOc9S8vCZkLQLPbHiyw
	 BvcSXMAOHuecw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] sched_ext: scx_qmap: rename tctx to taskc
Date: Wed, 15 Apr 2026 22:16:23 -1000
Message-ID: <20260416081626.1285617-2-tj@kernel.org>
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

Rename the per-task context local variable from tctx to taskc for
consistency.

No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 60 +++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index b68abb9e760b..a18234f3c27a 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -159,22 +159,22 @@ static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
 
 static struct task_ctx *lookup_task_ctx(struct task_struct *p)
 {
-	struct task_ctx *tctx;
+	struct task_ctx *taskc;
 
-	if (!(tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0))) {
+	if (!(taskc = bpf_task_storage_get(&task_ctx_stor, p, 0, 0))) {
 		scx_bpf_error("task_ctx lookup failed");
 		return NULL;
 	}
-	return tctx;
+	return taskc;
 }
 
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
-	struct task_ctx *tctx;
+	struct task_ctx *taskc;
 	s32 cpu;
 
-	if (!(tctx = lookup_task_ctx(p)))
+	if (!(taskc = lookup_task_ctx(p)))
 		return -ESRCH;
 
 	if (p->scx.weight < 2 && !(p->flags & PF_KTHREAD))
@@ -183,7 +183,7 @@ s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 	cpu = pick_direct_dispatch_cpu(p, prev_cpu);
 
 	if (cpu >= 0) {
-		tctx->force_local = true;
+		taskc->force_local = true;
 		return cpu;
 	} else {
 		return prev_cpu;
@@ -208,7 +208,7 @@ static int weight_to_idx(u32 weight)
 void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 {
 	static u32 user_cnt, kernel_cnt;
-	struct task_ctx *tctx;
+	struct task_ctx *taskc;
 	u32 pid = p->pid;
 	int idx = weight_to_idx(p->scx.weight);
 	void *ring;
@@ -231,14 +231,14 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	if (test_error_cnt && !--test_error_cnt)
 		scx_bpf_error("test triggering error");
 
-	if (!(tctx = lookup_task_ctx(p)))
+	if (!(taskc = lookup_task_ctx(p)))
 		return;
 
 	/*
 	 * All enqueued tasks must have their core_sched_seq updated for correct
 	 * core-sched ordering. Also, take a look at the end of qmap_dispatch().
 	 */
-	tctx->core_sched_seq = core_sched_tail_seqs[idx]++;
+	taskc->core_sched_seq = core_sched_tail_seqs[idx]++;
 
 	/*
 	 * IMMED stress testing: Every immed_stress_nth'th enqueue, dispatch
@@ -249,7 +249,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		static u32 immed_stress_cnt;
 
 		if (!(++immed_stress_cnt % immed_stress_nth)) {
-			tctx->force_local = false;
+			taskc->force_local = false;
 			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cpu(p),
 					   slice_ns, enq_flags);
 			return;
@@ -260,8 +260,8 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 * If qmap_select_cpu() is telling us to or this is the last runnable
 	 * task on the CPU, enqueue locally.
 	 */
-	if (tctx->force_local) {
-		tctx->force_local = false;
+	if (taskc->force_local) {
+		taskc->force_local = false;
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
 		return;
 	}
@@ -310,7 +310,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	}
 
 	if (highpri_boosting && p->scx.weight >= HIGHPRI_WEIGHT) {
-		tctx->highpri = true;
+		taskc->highpri = true;
 		__sync_fetch_and_add(&nr_highpri_queued, 1);
 	}
 	__sync_fetch_and_add(&nr_enqueued, 1);
@@ -330,10 +330,10 @@ void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags)
 static void update_core_sched_head_seq(struct task_struct *p)
 {
 	int idx = weight_to_idx(p->scx.weight);
-	struct task_ctx *tctx;
+	struct task_ctx *taskc;
 
-	if ((tctx = lookup_task_ctx(p)))
-		core_sched_head_seqs[idx] = tctx->core_sched_seq;
+	if ((taskc = lookup_task_ctx(p)))
+		core_sched_head_seqs[idx] = taskc->core_sched_seq;
 }
 
 /*
@@ -354,12 +354,12 @@ static bool dispatch_highpri(bool from_timer)
 	/* scan SHARED_DSQ and move highpri tasks to HIGHPRI_DSQ */
 	bpf_for_each(scx_dsq, p, SHARED_DSQ, 0) {
 		static u64 highpri_seq;
-		struct task_ctx *tctx;
+		struct task_ctx *taskc;
 
-		if (!(tctx = lookup_task_ctx(p)))
+		if (!(taskc = lookup_task_ctx(p)))
 			return false;
 
-		if (tctx->highpri) {
+		if (taskc->highpri) {
 			/* exercise the set_*() and vtime interface too */
 			scx_bpf_dsq_move_set_slice(BPF_FOR_EACH_ITER, slice_ns * 2);
 			scx_bpf_dsq_move_set_vtime(BPF_FOR_EACH_ITER, highpri_seq++);
@@ -405,7 +405,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 {
 	struct task_struct *p;
 	struct cpu_ctx *cpuc;
-	struct task_ctx *tctx;
+	struct task_ctx *taskc;
 	u32 zero = 0, batch = dsp_batch ?: 1;
 	void *fifo;
 	s32 i, pid;
@@ -450,7 +450,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 
 		/* Dispatch or advance. */
 		bpf_repeat(BPF_MAX_LOOPS) {
-			struct task_ctx *tctx;
+			struct task_ctx *taskc;
 
 			if (bpf_map_pop_elem(fifo, &pid))
 				break;
@@ -459,12 +459,12 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 			if (!p)
 				continue;
 
-			if (!(tctx = lookup_task_ctx(p))) {
+			if (!(taskc = lookup_task_ctx(p))) {
 				bpf_task_release(p);
 				return;
 			}
 
-			if (tctx->highpri)
+			if (taskc->highpri)
 				__sync_fetch_and_sub(&nr_highpri_queued, 1);
 
 			update_core_sched_head_seq(p);
@@ -539,13 +539,13 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	 * if the task were enqueued and dispatched immediately.
 	 */
 	if (prev) {
-		tctx = bpf_task_storage_get(&task_ctx_stor, prev, 0, 0);
-		if (!tctx) {
+		taskc = bpf_task_storage_get(&task_ctx_stor, prev, 0, 0);
+		if (!taskc) {
 			scx_bpf_error("task_ctx lookup failed");
 			return;
 		}
 
-		tctx->core_sched_seq =
+		taskc->core_sched_seq =
 			core_sched_tail_seqs[weight_to_idx(prev->scx.weight)]++;
 	}
 }
@@ -580,16 +580,16 @@ void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
 static s64 task_qdist(struct task_struct *p)
 {
 	int idx = weight_to_idx(p->scx.weight);
-	struct task_ctx *tctx;
+	struct task_ctx *taskc;
 	s64 qdist;
 
-	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
-	if (!tctx) {
+	taskc = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (!taskc) {
 		scx_bpf_error("task_ctx lookup failed");
 		return 0;
 	}
 
-	qdist = tctx->core_sched_seq - core_sched_head_seqs[idx];
+	qdist = taskc->core_sched_seq - core_sched_head_seqs[idx];
 
 	/*
 	 * As queue index increments, the priority doubles. The queue w/ index 3
-- 
2.53.0

