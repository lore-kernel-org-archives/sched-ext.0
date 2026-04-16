Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0339185B;
	Thu, 16 Apr 2026 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327393; cv=none; b=YkjocE15foAqrHZOtBHi2YD45NHcri6rgMF6DnUjADdcr6oPm++YlEgvdtThMiDSTeiejQHCAaadHweuYeCrtw0TW/0g0K9JS81cdn8hgPX9NNmUET7+gyri2VBNLzuj7RB9p2eSB6QgDEYT0Z3q6Wn4/BUI0f8JVlBDN4NCkdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327393; c=relaxed/simple;
	bh=wZdWn0H+bAI0C3CRhgZF+O9Gamk/CUZPutMCiqA1FTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkxJYG3+VeN7BDrY7WHzxDVD8t6FCkDJJBkzYAtFREroB2nfBUq/AYZzFaRATKVqVOuD+DZ8Pns6CZOSQGCwPsD8tO1+Oq8x6a7QGqjm4wJ74zIfutIraL9YQPWl6BSs1vcGFatUetG/D8eWV3AiCO7U3xj0PsLrkqKP4PlfG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1OeFxIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1OeFxIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB21C2BCB3;
	Thu, 16 Apr 2026 08:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776327392;
	bh=wZdWn0H+bAI0C3CRhgZF+O9Gamk/CUZPutMCiqA1FTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1OeFxIcflmhCuqxUf/6Rc/iv68CLP9TZtQAn8vl7w3Q/LnRjhM5BtKFYarZsb5Ed
	 8az8RtMbosPxCNvmWn0dycMcivULMV+SkpocnDcUi+MPy6CHQVICv+4RjiR05nqYDk
	 nHoqZbQFNaMUdihb/Ky5LWddESajEC8YZgEVTfrQC0l5KtkgZ5jfSdmmjbrxEsE1qe
	 aQ04rckdvh/F0mC9zt16sYNIGOJYIMLXI+o1cUr3QpB/LiQZ/bHbSQw0PNafbx9OGf
	 ZnRwShxplbqg8Z15LRJrXRd1Pt81DLjakDXQQxG37TUdJZ/nvnlmu6JjvrAFhxb1Ln
	 tle52Djpyycig==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] sched_ext: scx_qmap: replace FIFO queue maps with arena-backed lists
Date: Wed, 15 Apr 2026 22:16:26 -1000
Message-ID: <20260416081626.1285617-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416081626.1285617-1-tj@kernel.org>
References: <20260416081626.1285617-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Arena simplifies verification and allows more natural programming.
Convert scx_qmap to arena as preparation for further sub-sched work.

Replace the five BPF_MAP_TYPE_QUEUE maps with doubly-linked lists in
arena, threaded through task_ctx. Each queue is a struct qmap_fifo with
head/tail pointers and its own per-queue bpf_res_spin_lock.

qmap_dequeue() now properly removes tasks from the queue instead of
leaving stale entries for dispatch to skip.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 221 +++++++++++++++++++++------------
 tools/sched_ext/scx_qmap.h     |   9 ++
 2 files changed, 148 insertions(+), 82 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index e071969c8f32..c26997ff7863 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -71,31 +71,24 @@ struct {
 
 struct qmap_arena __arena qa;
 
-struct qmap {
-	__uint(type, BPF_MAP_TYPE_QUEUE);
-	__uint(max_entries, 4096);
-	__type(value, u32);
-} queue0 SEC(".maps"),
-  queue1 SEC(".maps"),
-  queue2 SEC(".maps"),
-  queue3 SEC(".maps"),
-  queue4 SEC(".maps"),
-  dump_store SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
-	__uint(max_entries, 5);
-	__type(key, int);
-	__array(values, struct qmap);
-} queue_arr SEC(".maps") = {
-	.values = {
-		[0] = &queue0,
-		[1] = &queue1,
-		[2] = &queue2,
-		[3] = &queue3,
-		[4] = &queue4,
-	},
-};
+/* Per-queue locks. Each in its own .data section as bpf_res_spin_lock requires. */
+__hidden struct bpf_res_spin_lock qa_q_lock0 SEC(".data.qa_q_lock0");
+__hidden struct bpf_res_spin_lock qa_q_lock1 SEC(".data.qa_q_lock1");
+__hidden struct bpf_res_spin_lock qa_q_lock2 SEC(".data.qa_q_lock2");
+__hidden struct bpf_res_spin_lock qa_q_lock3 SEC(".data.qa_q_lock3");
+__hidden struct bpf_res_spin_lock qa_q_lock4 SEC(".data.qa_q_lock4");
+
+static struct bpf_res_spin_lock *qa_q_lock(s32 qid)
+{
+	switch (qid) {
+	case 0:	return &qa_q_lock0;
+	case 1:	return &qa_q_lock1;
+	case 2:	return &qa_q_lock2;
+	case 3:	return &qa_q_lock3;
+	case 4:	return &qa_q_lock4;
+	default: return NULL;
+	}
+}
 
 /*
  * If enabled, CPU performance target is set according to the queue index
@@ -123,9 +116,17 @@ static const u32 qidx_to_cpuperf_target[] = {
  * arena. While the task is alive the entry is referenced from task_ctx_stor;
  * while it's free the entry sits on the free list singly-linked through
  * @next_free.
+ *
+ * When the task is queued on one of the five priority FIFOs, @q_idx is the
+ * queue index and @q_next/@q_prev link it in the queue's doubly-linked list.
+ * @q_idx is -1 when the task isn't on any queue.
  */
 struct task_ctx {
 	struct task_ctx __arena	*next_free;	/* only valid on free list */
+	struct task_ctx __arena	*q_next;	/* queue link, NULL if tail */
+	struct task_ctx __arena	*q_prev;	/* queue link, NULL if head */
+	struct qmap_fifo __arena *fifo;		/* queue we're on, NULL if not queued */
+	s32			pid;
 	bool			force_local;	/* Dispatch directly to local_dsq */
 	bool			highpri;
 	u64			core_sched_seq;
@@ -196,6 +197,81 @@ static struct task_ctx __arena *lookup_task_ctx(struct task_struct *p)
 	return v->taskc;
 }
 
+/* Append @taskc to the tail of @fifo. Must not already be queued. */
+static void qmap_fifo_enqueue(struct qmap_fifo __arena *fifo,
+			      struct task_ctx __arena *taskc)
+{
+	struct bpf_res_spin_lock *lock = qa_q_lock(fifo->idx);
+
+	if (!lock || qmap_spin_lock(lock))
+		return;
+	taskc->fifo = fifo;
+	taskc->q_next = NULL;
+	taskc->q_prev = fifo->tail;
+	if (fifo->tail)
+		fifo->tail->q_next = taskc;
+	else
+		fifo->head = taskc;
+	fifo->tail = taskc;
+	bpf_res_spin_unlock(lock);
+}
+
+/* Pop the head of @fifo. Returns NULL if empty. */
+static struct task_ctx __arena *qmap_fifo_pop(struct qmap_fifo __arena *fifo)
+{
+	struct bpf_res_spin_lock *lock = qa_q_lock(fifo->idx);
+	struct task_ctx __arena *taskc;
+
+	if (!lock || qmap_spin_lock(lock))
+		return NULL;
+	taskc = fifo->head;
+	if (taskc) {
+		fifo->head = taskc->q_next;
+		if (taskc->q_next)
+			taskc->q_next->q_prev = NULL;
+		else
+			fifo->tail = NULL;
+		taskc->q_next = NULL;
+		taskc->q_prev = NULL;
+		taskc->fifo = NULL;
+	}
+	bpf_res_spin_unlock(lock);
+	return taskc;
+}
+
+/* Remove @taskc from its fifo. No-op if not queued. */
+static void qmap_fifo_remove(struct task_ctx __arena *taskc)
+{
+	struct qmap_fifo __arena *fifo = taskc->fifo;
+	struct bpf_res_spin_lock *lock;
+
+	if (!fifo)
+		return;
+
+	lock = qa_q_lock(fifo->idx);
+	if (!lock || qmap_spin_lock(lock))
+		return;
+
+	/* Re-check under lock — a concurrent pop may have cleared fifo. */
+	if (taskc->fifo != fifo) {
+		bpf_res_spin_unlock(lock);
+		return;
+	}
+
+	if (taskc->q_next)
+		taskc->q_next->q_prev = taskc->q_prev;
+	else
+		fifo->tail = taskc->q_prev;
+	if (taskc->q_prev)
+		taskc->q_prev->q_next = taskc->q_next;
+	else
+		fifo->head = taskc->q_next;
+	taskc->q_next = NULL;
+	taskc->q_prev = NULL;
+	taskc->fifo = NULL;
+	bpf_res_spin_unlock(lock);
+}
+
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -237,9 +313,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 {
 	static u32 user_cnt, kernel_cnt;
 	struct task_ctx __arena *taskc;
-	u32 pid = p->pid;
 	int idx = weight_to_idx(p->scx.weight);
-	void *ring;
 	s32 cpu;
 
 	if (enq_flags & SCX_ENQ_REENQ) {
@@ -325,17 +399,8 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
-	ring = bpf_map_lookup_elem(&queue_arr, &idx);
-	if (!ring) {
-		scx_bpf_error("failed to find ring %d", idx);
-		return;
-	}
-
-	/* Queue on the selected FIFO. If the FIFO overflows, punt to global. */
-	if (bpf_map_push_elem(ring, &pid, 0)) {
-		scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, enq_flags);
-		return;
-	}
+	/* Queue on the selected FIFO. */
+	qmap_fifo_enqueue(&qa.fifos[idx], taskc);
 
 	if (highpri_boosting && p->scx.weight >= HIGHPRI_WEIGHT) {
 		taskc->highpri = true;
@@ -344,15 +409,20 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	__sync_fetch_and_add(&qa.nr_enqueued, 1);
 }
 
-/*
- * The BPF queue map doesn't support removal and sched_ext can handle spurious
- * dispatches. qmap_dequeue() is only used to collect statistics.
- */
 void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags)
 {
+	struct task_ctx __arena *taskc;
+
 	__sync_fetch_and_add(&qa.nr_dequeued, 1);
 	if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC)
 		__sync_fetch_and_add(&qa.nr_core_sched_execed, 1);
+
+	taskc = lookup_task_ctx(p);
+	if (taskc && taskc->fifo) {
+		if (taskc->highpri)
+			__sync_fetch_and_sub(&qa.nr_highpri_queued, 1);
+		qmap_fifo_remove(taskc);
+	}
 }
 
 static void update_core_sched_head_seq(struct task_struct *p)
@@ -435,8 +505,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	struct cpu_ctx __arena *cpuc;
 	struct task_ctx __arena *taskc;
 	u32 batch = dsp_batch ?: 1;
-	void *fifo;
-	s32 i, pid;
+	s32 i;
 
 	if (dispatch_highpri(false))
 		return;
@@ -467,30 +536,18 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 			cpuc->dsp_cnt = 1 << cpuc->dsp_idx;
 		}
 
-		u64 dsp_idx = cpuc->dsp_idx;
-
-		fifo = bpf_map_lookup_elem(&queue_arr, &dsp_idx);
-		if (!fifo) {
-			scx_bpf_error("failed to find ring %llu", dsp_idx);
-			return;
-		}
-
 		/* Dispatch or advance. */
 		bpf_repeat(BPF_MAX_LOOPS) {
 			struct task_ctx __arena *taskc;
 
-			if (bpf_map_pop_elem(fifo, &pid))
+			taskc = qmap_fifo_pop(&qa.fifos[cpuc->dsp_idx]);
+			if (!taskc)
 				break;
 
-			p = bpf_task_from_pid(pid);
+			p = bpf_task_from_pid(taskc->pid);
 			if (!p)
 				continue;
 
-			if (!(taskc = lookup_task_ctx(p))) {
-				bpf_task_release(p);
-				return;
-			}
-
 			if (taskc->highpri)
 				__sync_fetch_and_sub(&qa.nr_highpri_queued, 1);
 
@@ -661,6 +718,10 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_task, struct task_struct *p,
 	}
 
 	taskc->next_free = NULL;
+	taskc->q_next = NULL;
+	taskc->q_prev = NULL;
+	taskc->fifo = NULL;
+	taskc->pid = p->pid;
 	taskc->force_local = false;
 	taskc->highpri = false;
 	taskc->core_sched_seq = 0;
@@ -701,38 +762,29 @@ void BPF_STRUCT_OPS(qmap_exit_task, struct task_struct *p,
 
 void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
 {
-	s32 i, pid;
+	struct task_ctx __arena *taskc;
+	s32 i;
+
+	QMAP_TOUCH_ARENA();
 
 	if (suppress_dump)
 		return;
 
+	/*
+	 * Walk the queue lists without locking - kfunc calls (scx_bpf_dump)
+	 * aren't in the verifier's kfunc_spin_allowed() list so we can't hold
+	 * a lock and dump. Best-effort; racing may print stale pids but the
+	 * walk is bounded by bpf_repeat() so it always terminates.
+	 */
 	bpf_for(i, 0, 5) {
-		void *fifo;
-
-		if (!(fifo = bpf_map_lookup_elem(&queue_arr, &i)))
-			return;
-
 		scx_bpf_dump("QMAP FIFO[%d]:", i);
-
-		/*
-		 * Dump can be invoked anytime and there is no way to iterate in
-		 * a non-destructive way. Pop and store in dump_store and then
-		 * restore afterwards. If racing against new enqueues, ordering
-		 * can get mixed up.
-		 */
-		bpf_repeat(4096) {
-			if (bpf_map_pop_elem(fifo, &pid))
-				break;
-			bpf_map_push_elem(&dump_store, &pid, 0);
-			scx_bpf_dump(" %d", pid);
-		}
-
+		taskc = qa.fifos[i].head;
 		bpf_repeat(4096) {
-			if (bpf_map_pop_elem(&dump_store, &pid))
+			if (!taskc)
 				break;
-			bpf_map_push_elem(fifo, &pid, 0);
+			scx_bpf_dump(" %d", taskc->pid);
+			taskc = taskc->q_next;
 		}
-
 		scx_bpf_dump("\n");
 	}
 }
@@ -756,6 +808,8 @@ void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struc
 
 	QMAP_TOUCH_ARENA();
 
+	QMAP_TOUCH_ARENA();
+
 	if (suppress_dump)
 		return;
 	v = bpf_task_storage_get(&task_ctx_stor, p, NULL, 0);
@@ -1018,6 +1072,9 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	}
 	qa.task_ctxs = slab;
 
+	bpf_for(i, 0, 5)
+		qa.fifos[i].idx = i;
+
 	bpf_for(i, 0, max_tasks)
 		slab[i].next_free = (i + 1 < max_tasks) ? &slab[i + 1] : NULL;
 	qa.task_free_head = &slab[0];
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index c183d82632b3..9c0da5a301cb 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -37,6 +37,12 @@ struct cpu_ctx {
 /* Opaque to userspace; defined in scx_qmap.bpf.c. */
 struct task_ctx;
 
+struct qmap_fifo {
+	struct task_ctx __arena *head;
+	struct task_ctx __arena *tail;
+	__s32 idx;
+};
+
 struct qmap_arena {
 	/* userspace-visible stats */
 	__u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cpu0;
@@ -59,6 +65,9 @@ struct qmap_arena {
 	/* task_ctx slab; allocated and threaded by qmap_init() */
 	struct task_ctx __arena *task_ctxs;
 	struct task_ctx __arena *task_free_head;
+
+	/* five priority FIFOs, each a doubly-linked list through task_ctx */
+	struct qmap_fifo fifos[5];
 };
 
 #endif /* __SCX_QMAP_H */
-- 
2.53.0

