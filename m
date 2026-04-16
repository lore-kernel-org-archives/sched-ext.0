Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1531A061;
	Thu, 16 Apr 2026 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360034; cv=none; b=ibEwAlCC3GgcUb5lQXZZ/FBlfyQhlR/fNKEuG5GWxHAMrC/mQrly+wNx2UzkJH062LO0Le24RZ8XTn8y+qye1nLI9bz2S4/+ei4OddD7aCwTZzw9f/7te248VZeFs9Ur4f+4YSxo9Y+n8zfO6xBQJJuPoWJLMb4Rajg3Y1DG5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360034; c=relaxed/simple;
	bh=MtskYSXB6w+33TWcGv/dBPSpt+4I6oVt0kR9QS9U8FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7E1wdrxqRAn8JjHQGbZ30a4mXZgTrHNexuCu7lPW9VAySADr9scnyOmq3iD0G+JEXP75wQmEO0U4jeNK8cQTv6uO7LAY84oBXJjB8gfL9+FnSk/7X+3MJGcKRwC/Ij01f2kV88DmFaGveo8PXnZXULITOD0K7SyarT9GUtoUZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAVPxrbF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAVPxrbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445EDC2BCAF;
	Thu, 16 Apr 2026 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360034;
	bh=MtskYSXB6w+33TWcGv/dBPSpt+4I6oVt0kR9QS9U8FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rAVPxrbFeog6p73jZtX0qYm70tCQocoIKJVSnn46xYFpq6KtrTnnshwLEaxUDQqr2
	 4TZOthVhZ3/w1w9xae5l5Mr18O5Fk7TB856bOk5L/ttRHfjSdjlgPV2b/TJ3iCubOs
	 +94chJZEyJHGgGO8PTqOixYXRbOMe3Fcok3hvxMbx8OZxjs/Jl2/MtIdHuS45Hhkwk
	 wk49zwEeoTbk3nIvU2csQ7sJoguno8brv9XuLwk/vAWnBOp+3fy3+09X+Z/5rAAvRg
	 6bzP9cHlg1MwcA+q44X+kyj8wS03xm8JfxR8BsFCDBHzhJWG14VRTY8//lbT8Iai6h
	 HP8Bt8MlSsCBw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sched_ext: scx_qmap: move task_ctx into a BPF arena slab
Date: Thu, 16 Apr 2026 07:20:28 -1000
Message-ID: <20260416172030.1417417-4-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416172030.1417417-1-tj@kernel.org>
References: <20260416172030.1417417-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arena simplifies verification and allows more natural programming.
Convert scx_qmap to arena as preparation for further sub-sched work.

Allocate per-task context from an arena slab instead of storing it
directly in task_storage. task_ctx_stor now holds an arena pointer to
the task's slab entry. Free entries form a singly-linked list protected
by bpf_res_spin_lock; slab exhaustion triggers scx_bpf_error().

The slab size is configurable via the new -N option (default 16384).

Also add bpf_res_spin_lock/unlock declarations to common.bpf.h.

Scheduling logic unchanged.

v2: Add task_ctx_t typedef for struct task_ctx __arena (Emil).

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/sched_ext/include/scx/common.bpf.h |   4 +
 tools/sched_ext/scx_qmap.bpf.c           | 181 ++++++++++++++++++-----
 tools/sched_ext/scx_qmap.c               |   9 +-
 tools/sched_ext/scx_qmap.h               |   7 +
 4 files changed, 162 insertions(+), 39 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 19459dedde41..35fc62556241 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -526,6 +526,10 @@ static inline bool is_migration_disabled(const struct task_struct *p)
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
 
+/* resilient qspinlock */
+int bpf_res_spin_lock(struct bpf_res_spin_lock *lock) __ksym __weak;
+void bpf_res_spin_unlock(struct bpf_res_spin_lock *lock) __ksym __weak;
+
 /*
  * Time helpers, most of which are from jiffies.h.
  */
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 184a3a729d21..57ce95a306cc 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -49,6 +49,7 @@ const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
 const volatile bool always_enq_immed;
 const volatile u32 immed_stress_nth;
+const volatile u32 max_tasks;
 
 UEI_DEFINE(uei);
 
@@ -117,20 +118,46 @@ static const u32 qidx_to_cpuperf_target[] = {
  * and used when comparing two tasks for ordering. See qmap_core_sched_before().
  */
 
-/* Per-task scheduling context */
+/*
+ * Per-task scheduling context. Allocated from the qa.task_ctxs[] slab in
+ * arena. While the task is alive the entry is referenced from task_ctx_stor;
+ * while it's free the entry sits on the free list singly-linked through
+ * @next_free.
+ */
 struct task_ctx {
-	bool	force_local;	/* Dispatch directly to local_dsq */
-	bool	highpri;
-	u64	core_sched_seq;
+	struct task_ctx __arena	*next_free;	/* only valid on free list */
+	bool			force_local;	/* Dispatch directly to local_dsq */
+	bool			highpri;
+	u64			core_sched_seq;
+};
+
+/* All task_ctx pointers are arena pointers. */
+typedef struct task_ctx __arena task_ctx_t;
+
+/* Holds an arena pointer to the task's slab entry. */
+struct task_ctx_stor_val {
+	task_ctx_t		*taskc;
 };
 
 struct {
 	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 	__type(key, int);
-	__type(value, struct task_ctx);
+	__type(value, struct task_ctx_stor_val);
 } task_ctx_stor SEC(".maps");
 
+/* Protects the task_ctx slab free list. */
+__hidden struct bpf_res_spin_lock qa_task_lock SEC(".data.qa_task_lock");
+
+static int qmap_spin_lock(struct bpf_res_spin_lock *lock)
+{
+	if (bpf_res_spin_lock(lock)) {
+		scx_bpf_error("res_spin_lock failed");
+		return -EBUSY;
+	}
+	return 0;
+}
+
 static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
 {
 	s32 cpu;
@@ -148,21 +175,34 @@ static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
 	return -1;
 }
 
-static struct task_ctx *lookup_task_ctx(struct task_struct *p)
+/*
+ * Force a reference to the arena map. The verifier associates an arena with
+ * a program by finding an LD_IMM64 instruction that loads the arena's BPF
+ * map; programs that only use arena pointers returned from task-local
+ * storage (like qmap_select_cpu) never reference @arena directly. Without
+ * this, the verifier rejects addr_space_cast with "addr_space_cast insn
+ * can only be used in a program that has an associated arena".
+ */
+#define QMAP_TOUCH_ARENA() do { asm volatile("" :: "r"(&arena)); } while (0)
+
+static task_ctx_t *lookup_task_ctx(struct task_struct *p)
 {
-	struct task_ctx *taskc;
+	struct task_ctx_stor_val *v;
+
+	QMAP_TOUCH_ARENA();
 
-	if (!(taskc = bpf_task_storage_get(&task_ctx_stor, p, 0, 0))) {
+	v = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (!v || !v->taskc) {
 		scx_bpf_error("task_ctx lookup failed");
 		return NULL;
 	}
-	return taskc;
+	return v->taskc;
 }
 
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
-	struct task_ctx *taskc;
+	task_ctx_t *taskc;
 	s32 cpu;
 
 	if (!(taskc = lookup_task_ctx(p)))
@@ -199,7 +239,7 @@ static int weight_to_idx(u32 weight)
 void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 {
 	static u32 user_cnt, kernel_cnt;
-	struct task_ctx *taskc;
+	task_ctx_t *taskc;
 	u32 pid = p->pid;
 	int idx = weight_to_idx(p->scx.weight);
 	void *ring;
@@ -321,7 +361,7 @@ void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags)
 static void update_core_sched_head_seq(struct task_struct *p)
 {
 	int idx = weight_to_idx(p->scx.weight);
-	struct task_ctx *taskc;
+	task_ctx_t *taskc;
 
 	if ((taskc = lookup_task_ctx(p)))
 		qa.core_sched_head_seqs[idx] = taskc->core_sched_seq;
@@ -345,7 +385,7 @@ static bool dispatch_highpri(bool from_timer)
 	/* scan SHARED_DSQ and move highpri tasks to HIGHPRI_DSQ */
 	bpf_for_each(scx_dsq, p, SHARED_DSQ, 0) {
 		static u64 highpri_seq;
-		struct task_ctx *taskc;
+		task_ctx_t *taskc;
 
 		if (!(taskc = lookup_task_ctx(p)))
 			return false;
@@ -396,7 +436,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 {
 	struct task_struct *p;
 	struct cpu_ctx __arena *cpuc;
-	struct task_ctx *taskc;
+	task_ctx_t *taskc;
 	u32 batch = dsp_batch ?: 1;
 	void *fifo;
 	s32 i, pid;
@@ -440,7 +480,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 
 		/* Dispatch or advance. */
 		bpf_repeat(BPF_MAX_LOOPS) {
-			struct task_ctx *taskc;
+			task_ctx_t *taskc;
 
 			if (bpf_map_pop_elem(fifo, &pid))
 				break;
@@ -529,11 +569,9 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	 * if the task were enqueued and dispatched immediately.
 	 */
 	if (prev) {
-		taskc = bpf_task_storage_get(&task_ctx_stor, prev, 0, 0);
-		if (!taskc) {
-			scx_bpf_error("task_ctx lookup failed");
+		taskc = lookup_task_ctx(prev);
+		if (!taskc)
 			return;
-		}
 
 		taskc->core_sched_seq =
 			qa.core_sched_tail_seqs[weight_to_idx(prev->scx.weight)]++;
@@ -564,14 +602,12 @@ void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
 static s64 task_qdist(struct task_struct *p)
 {
 	int idx = weight_to_idx(p->scx.weight);
-	struct task_ctx *taskc;
+	task_ctx_t *taskc;
 	s64 qdist;
 
-	taskc = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
-	if (!taskc) {
-		scx_bpf_error("task_ctx lookup failed");
+	taskc = lookup_task_ctx(p);
+	if (!taskc)
 		return 0;
-	}
 
 	qdist = taskc->core_sched_seq - qa.core_sched_head_seqs[idx];
 
@@ -606,21 +642,64 @@ bool BPF_STRUCT_OPS(qmap_core_sched_before,
  * tasks when a higher-priority scheduling class takes the CPU.
  */
 
-s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
-		   struct scx_init_task_args *args)
+s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_task, struct task_struct *p,
+			     struct scx_init_task_args *args)
 {
+	struct task_ctx_stor_val *v;
+	task_ctx_t *taskc;
+
 	if (p->tgid == disallow_tgid)
 		p->scx.disallow = true;
 
-	/*
-	 * @p is new. Let's ensure that its task_ctx is available. We can sleep
-	 * in this function and the following will automatically use GFP_KERNEL.
-	 */
-	if (bpf_task_storage_get(&task_ctx_stor, p, 0,
-				 BPF_LOCAL_STORAGE_GET_F_CREATE))
-		return 0;
-	else
+	/* pop a slab entry off the free list */
+	if (qmap_spin_lock(&qa_task_lock))
+		return -EBUSY;
+	taskc = qa.task_free_head;
+	if (taskc)
+		qa.task_free_head = taskc->next_free;
+	bpf_res_spin_unlock(&qa_task_lock);
+	if (!taskc) {
+		scx_bpf_error("task_ctx slab exhausted (max_tasks=%u)", max_tasks);
+		return -ENOMEM;
+	}
+
+	taskc->next_free = NULL;
+	taskc->force_local = false;
+	taskc->highpri = false;
+	taskc->core_sched_seq = 0;
+
+	v = bpf_task_storage_get(&task_ctx_stor, p, NULL,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!v) {
+		/* push back to the free list */
+		if (!qmap_spin_lock(&qa_task_lock)) {
+			taskc->next_free = qa.task_free_head;
+			qa.task_free_head = taskc;
+			bpf_res_spin_unlock(&qa_task_lock);
+		}
 		return -ENOMEM;
+	}
+	v->taskc = taskc;
+	return 0;
+}
+
+void BPF_STRUCT_OPS(qmap_exit_task, struct task_struct *p,
+		    struct scx_exit_task_args *args)
+{
+	struct task_ctx_stor_val *v;
+	task_ctx_t *taskc;
+
+	v = bpf_task_storage_get(&task_ctx_stor, p, NULL, 0);
+	if (!v || !v->taskc)
+		return;
+	taskc = v->taskc;
+	v->taskc = NULL;
+
+	if (qmap_spin_lock(&qa_task_lock))
+		return;
+	taskc->next_free = qa.task_free_head;
+	qa.task_free_head = taskc;
+	bpf_res_spin_unlock(&qa_task_lock);
 }
 
 void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
@@ -675,12 +754,17 @@ void BPF_STRUCT_OPS(qmap_dump_cpu, struct scx_dump_ctx *dctx, s32 cpu, bool idle
 
 void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struct *p)
 {
-	struct task_ctx *taskc;
+	struct task_ctx_stor_val *v;
+	task_ctx_t *taskc;
+
+	QMAP_TOUCH_ARENA();
 
 	if (suppress_dump)
 		return;
-	if (!(taskc = bpf_task_storage_get(&task_ctx_stor, p, 0, 0)))
+	v = bpf_task_storage_get(&task_ctx_stor, p, NULL, 0);
+	if (!v || !v->taskc)
 		return;
+	taskc = v->taskc;
 
 	scx_bpf_dump("QMAP: force_local=%d core_sched_seq=%llu",
 		     taskc->force_local, taskc->core_sched_seq);
@@ -915,10 +999,32 @@ static int lowpri_timerfn(void *map, int *key, struct bpf_timer *timer)
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 {
-	u32 key = 0;
+	task_ctx_t *slab;
+	u32 nr_pages, key = 0, i;
 	struct bpf_timer *timer;
 	s32 ret;
 
+	/*
+	 * Allocate the task_ctx slab in arena and thread the entire slab onto
+	 * the free list. max_tasks is set by userspace before load.
+	 */
+	if (!max_tasks) {
+		scx_bpf_error("max_tasks must be > 0");
+		return -EINVAL;
+	}
+
+	nr_pages = (max_tasks * sizeof(struct task_ctx) + PAGE_SIZE - 1) / PAGE_SIZE;
+	slab = bpf_arena_alloc_pages(&arena, NULL, nr_pages, NUMA_NO_NODE, 0);
+	if (!slab) {
+		scx_bpf_error("failed to allocate task_ctx slab");
+		return -ENOMEM;
+	}
+	qa.task_ctxs = slab;
+
+	bpf_for(i, 0, max_tasks)
+		slab[i].next_free = (i + 1 < max_tasks) ? &slab[i + 1] : NULL;
+	qa.task_free_head = &slab[0];
+
 	if (print_msgs && !sub_cgroup_id)
 		print_cpus();
 
@@ -1005,6 +1111,7 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .tick			= (void *)qmap_tick,
 	       .core_sched_before	= (void *)qmap_core_sched_before,
 	       .init_task		= (void *)qmap_init_task,
+	       .exit_task		= (void *)qmap_exit_task,
 	       .dump			= (void *)qmap_dump,
 	       .dump_cpu		= (void *)qmap_dump_cpu,
 	       .dump_task		= (void *)qmap_dump_task,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 8844499c14c4..4bdcc4bc5fbd 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -23,12 +23,13 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-P] [-M] [-H] [-d PID] [-D LEN] [-S] [-p] [-I] [-F COUNT] [-v]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-d PID] [-D LEN] [-S] [-p] [-I] [-F COUNT] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
 "  -t COUNT      Stall every COUNT'th user thread\n"
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
+"  -N COUNT      Size of the task_ctx arena slab (default 16384)\n"
 "  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
 "  -P            Print out DSQ content and event counters to trace_pipe every second\n"
@@ -73,8 +74,9 @@ int main(int argc, char **argv)
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
+	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PMHc:d:D:SpIF:vh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -94,6 +96,9 @@ int main(int argc, char **argv)
 		case 'b':
 			skel->rodata->dsp_batch = strtoul(optarg, NULL, 0);
 			break;
+		case 'N':
+			skel->rodata->max_tasks = strtoul(optarg, NULL, 0);
+			break;
 		case 'P':
 			skel->rodata->print_dsqs_and_events = true;
 			break;
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index e0e19af6dcb3..5beaec82a5db 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -34,6 +34,9 @@ struct cpu_ctx {
 	__u32 cpuperf_target;
 };
 
+/* Opaque to userspace; defined in scx_qmap.bpf.c. */
+struct task_ctx;
+
 struct qmap_arena {
 	/* userspace-visible stats */
 	__u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cpu0;
@@ -52,6 +55,10 @@ struct qmap_arena {
 	__u64 core_sched_tail_seqs[5];
 
 	struct cpu_ctx cpu_ctxs[SCX_QMAP_MAX_CPUS];
+
+	/* task_ctx slab; allocated and threaded by qmap_init() */
+	struct task_ctx __arena *task_ctxs;
+	struct task_ctx __arena *task_free_head;
 };
 
 #endif /* __SCX_QMAP_H */
-- 
2.53.0

