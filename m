Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC43E714F;
	Fri, 24 Apr 2026 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051659; cv=none; b=LHVpy4Uc9o3jMuAT0Xgfou/7CvID/zp1IrgN+NcB+Av0fpkxbmNMRwbZ03CagVdkamIeHRGCKKnpXzJCWRfFBKZVag+41HiMc3Lc7rJUV+07UIQfXhy3qyaZOivzOL7pbXbjz7mWhpbeB2OebTul0F92Li/3pQQq50JeHveAmTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051659; c=relaxed/simple;
	bh=b9SFeYk6FBY9ruvgfcvV+TtJ0vHTzPE5iCgys96mfA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1eVx20cL4qayuym3iHhZEtphzKc6jXxKuSfWByecGHdW96amHI+xDbdcXP7Arfo2426QvM4kvFVP5JyP8h0jDE6SFbWhlZSJ8w6qiKq/2rfE+KIWfvxipWpmQrnLiWULkwtTUKwm8p59bGhzvYaw/3yHIBsdLwgsLSs6R/306E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A39Cjj4V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A39Cjj4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F8CC2BCB5;
	Fri, 24 Apr 2026 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051658;
	bh=b9SFeYk6FBY9ruvgfcvV+TtJ0vHTzPE5iCgys96mfA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A39Cjj4Vfo0asykQJEUfKLd7JnDeqjOpmQBa2EueiREBP6mo+TpbXRC7pibFiCNBN
	 H33TKq3r3L6JmJ9CBTuG/koWUtSrwBmy/9XItGNIHL2G7NwxZrA94xAdUOVTRqp0+L
	 +AQY/waSq3QiMiMFmKV+jpEWH128oJQLBle2YKZhAIBF0yh8qzTknEGJy1CudJUYXi
	 GVRqzf7SgxitOyvgL3UTvGGVeo0C+2dlm03aPqGLvHcOEL5/7fNVXSD3UJAXRsMJHo
	 8fhjJek3nZ2x8gmgnVs6F3GkuAIuyR3WeCUr5zLvSS1zND5UUgG14kYRmy+L/p7PZS
	 /HKzquiF7OV7Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 15/17] tools/sched_ext: scx_qmap: Add cmask-based idle tracking and cid-based idle pick
Date: Fri, 24 Apr 2026 07:27:19 -1000
Message-ID: <20260424172721.3458520-16-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424172721.3458520-1-tj@kernel.org>
References: <20260424172721.3458520-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch qmap's idle-cpu picker from scx_bpf_pick_idle_cpu() to a
BPF-side bitmap scan, still under cpu-form struct_ops. qa_idle_cids
tracks idle cids (updated in update_idle / cpu_offline) and each
task's taskc->cpus_allowed tracks its allowed cids (built in
set_cpumask / init_task); select_cpu / enqueue scan the intersection
for an idle cid. Callbacks translate cpu <-> cid on entry;
cid-qmap-port drops those translations.

The scan is barebone - no core preference or other topology-aware
picks like the in-kernel picker - but qmap is a demo and this is
enough to exercise the plumbing.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 131 +++++++++++++++++++++++++++++----
 1 file changed, 115 insertions(+), 16 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 78a1dd118c7e..bbb3922bafd7 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -72,6 +72,13 @@ struct {
 
 struct qmap_arena __arena qa;
 
+/*
+ * Global idle-cid tracking, maintained via update_idle / cpu_offline and
+ * scanned by the direct-dispatch path. Allocated in qmap_init() from one
+ * arena page, sized to the full cid space.
+ */
+struct scx_cmask __arena *qa_idle_cids;
+
 /* Per-queue locks. Each in its own .data section as bpf_res_spin_lock requires. */
 __hidden struct bpf_res_spin_lock qa_q_lock0 SEC(".data.qa_q_lock0");
 __hidden struct bpf_res_spin_lock qa_q_lock1 SEC(".data.qa_q_lock1");
@@ -132,8 +139,18 @@ struct task_ctx {
 	bool			force_local;	/* Dispatch directly to local_dsq */
 	bool			highpri;
 	u64			core_sched_seq;
+	struct scx_cmask	cpus_allowed;	/* per-task affinity in cid space */
 };
 
+/*
+ * Slab stride for task_ctx. cpus_allowed's flex array bits[] overlaps the
+ * tail bytes appended per entry; struct_size() gives the actual per-entry
+ * footprint.
+ */
+#define TASK_CTX_STRIDE							\
+	struct_size_t(struct task_ctx, cpus_allowed.bits,		\
+		      CMASK_NR_WORDS(SCX_QMAP_MAX_CPUS))
+
 /* All task_ctx pointers are arena pointers. */
 typedef struct task_ctx __arena task_ctx_t;
 
@@ -161,20 +178,37 @@ static int qmap_spin_lock(struct bpf_res_spin_lock *lock)
 	return 0;
 }
 
-static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
+/*
+ * Try prev_cpu's cid, then scan taskc->cpus_allowed AND qa_idle_cids
+ * round-robin from prev_cid + 1. Atomic claim retries on race; bounded
+ * by IDLE_PICK_RETRIES to keep the verifier's insn budget in check.
+ */
+#define IDLE_PICK_RETRIES	16
+
+static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu,
+				    task_ctx_t *taskc)
 {
-	s32 cpu;
+	u32 nr_cids = scx_bpf_nr_cids();
+	s32 prev_cid, cid;
+	u32 i;
 
 	if (!always_enq_immed && p->nr_cpus_allowed == 1)
 		return prev_cpu;
 
-	if (scx_bpf_test_and_clear_cpu_idle(prev_cpu))
+	prev_cid = scx_bpf_cpu_to_cid(prev_cpu);
+	if (cmask_test_and_clear(qa_idle_cids, prev_cid))
 		return prev_cpu;
 
-	cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
-	if (cpu >= 0)
-		return cpu;
-
+	cid = prev_cid;
+	bpf_for(i, 0, IDLE_PICK_RETRIES) {
+		cid = cmask_next_and_set_wrap(&taskc->cpus_allowed,
+					      qa_idle_cids, cid + 1);
+		barrier_var(cid);
+		if (cid >= nr_cids)
+			return -1;
+		if (cmask_test_and_clear(qa_idle_cids, cid))
+			return scx_bpf_cid_to_cpu(cid);
+	}
 	return -1;
 }
 
@@ -286,7 +320,7 @@ s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 	if (p->scx.weight < 2 && !(p->flags & PF_KTHREAD))
 		return prev_cpu;
 
-	cpu = pick_direct_dispatch_cpu(p, prev_cpu);
+	cpu = pick_direct_dispatch_cpu(p, prev_cpu, taskc);
 
 	if (cpu >= 0) {
 		taskc->force_local = true;
@@ -379,7 +413,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 
 	/* if select_cpu() wasn't called, try direct dispatch */
 	if (!__COMPAT_is_enq_cpu_selected(enq_flags) &&
-	    (cpu = pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p))) >= 0) {
+	    (cpu = pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p), taskc)) >= 0) {
 		__sync_fetch_and_add(&qa.nr_ddsp_from_enq, 1);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, slice_ns, enq_flags);
 		return;
@@ -726,6 +760,10 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_task, struct task_struct *p,
 	taskc->force_local = false;
 	taskc->highpri = false;
 	taskc->core_sched_seq = 0;
+	cmask_init(&taskc->cpus_allowed, 0, scx_bpf_nr_cids());
+	bpf_rcu_read_lock();
+	cmask_from_cpumask(&taskc->cpus_allowed, p->cpus_ptr);
+	bpf_rcu_read_unlock();
 
 	v = bpf_task_storage_get(&task_ctx_stor, p, NULL,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
@@ -843,6 +881,48 @@ void BPF_STRUCT_OPS(qmap_cgroup_set_bandwidth, struct cgroup *cgrp,
 			   cgrp->kn->id, period_us, quota_us, burst_us);
 }
 
+void BPF_STRUCT_OPS(qmap_update_idle, s32 cpu, bool idle)
+{
+	s32 cid = scx_bpf_cpu_to_cid(cpu);
+
+	QMAP_TOUCH_ARENA();
+	if (cid < 0)
+		return;
+	if (idle)
+		cmask_set(qa_idle_cids, cid);
+	else
+		cmask_clear(qa_idle_cids, cid);
+}
+
+/*
+ * The cpumask received here is kernel-address memory; walk it bit by bit
+ * (bpf_cpumask_test_cpu handles the access), convert each set cpu to its
+ * cid, and populate the arena-resident taskc cmask.
+ */
+void BPF_STRUCT_OPS(qmap_set_cpumask, struct task_struct *p,
+		    const struct cpumask *cpumask)
+{
+	task_ctx_t *taskc;
+	u32 nr_cpu_ids = scx_bpf_nr_cpu_ids();
+	s32 cpu;
+
+	taskc = lookup_task_ctx(p);
+	if (!taskc)
+		return;
+
+	cmask_zero(&taskc->cpus_allowed);
+
+	bpf_for(cpu, 0, nr_cpu_ids) {
+		s32 cid;
+
+		if (!bpf_cpumask_test_cpu(cpu, cpumask))
+			continue;
+		cid = scx_bpf_cpu_to_cid(cpu);
+		if (cid >= 0)
+			__cmask_set(&taskc->cpus_allowed, cid);
+	}
+}
+
 struct monitor_timer {
 	struct bpf_timer timer;
 };
@@ -992,34 +1072,51 @@ static int lowpri_timerfn(void *map, int *key, struct bpf_timer *timer)
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 {
-	task_ctx_t *slab;
+	u8 __arena *slab;
 	u32 nr_pages, key = 0, i;
 	struct bpf_timer *timer;
 	s32 ret;
 
 	/*
 	 * Allocate the task_ctx slab in arena and thread the entire slab onto
-	 * the free list. max_tasks is set by userspace before load.
+	 * the free list. max_tasks is set by userspace before load. Each entry
+	 * is TASK_CTX_STRIDE bytes - task_ctx's trailing cpus_allowed flex
+	 * array extends into the stride tail.
 	 */
 	if (!max_tasks) {
 		scx_bpf_error("max_tasks must be > 0");
 		return -EINVAL;
 	}
 
-	nr_pages = (max_tasks * sizeof(struct task_ctx) + PAGE_SIZE - 1) / PAGE_SIZE;
+	nr_pages = (max_tasks * TASK_CTX_STRIDE + PAGE_SIZE - 1) / PAGE_SIZE;
 	slab = bpf_arena_alloc_pages(&arena, NULL, nr_pages, NUMA_NO_NODE, 0);
 	if (!slab) {
 		scx_bpf_error("failed to allocate task_ctx slab");
 		return -ENOMEM;
 	}
-	qa.task_ctxs = slab;
+	qa.task_ctxs = (task_ctx_t *)slab;
 
 	bpf_for(i, 0, 5)
 		qa.fifos[i].idx = i;
 
-	bpf_for(i, 0, max_tasks)
-		slab[i].next_free = (i + 1 < max_tasks) ? &slab[i + 1] : NULL;
-	qa.task_free_head = &slab[0];
+	bpf_for(i, 0, max_tasks) {
+		task_ctx_t *cur = (task_ctx_t *)(slab + i * TASK_CTX_STRIDE);
+		task_ctx_t *next = (i + 1 < max_tasks) ?
+			(task_ctx_t *)(slab + (i + 1) * TASK_CTX_STRIDE) : NULL;
+		cur->next_free = next;
+	}
+	qa.task_free_head = (task_ctx_t *)slab;
+
+	/*
+	 * Allocate and initialize the idle cmask. Starts empty - update_idle
+	 * fills it as cpus enter idle.
+	 */
+	qa_idle_cids = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!qa_idle_cids) {
+		scx_bpf_error("failed to allocate idle cmask");
+		return -ENOMEM;
+	}
+	cmask_init(qa_idle_cids, 0, scx_bpf_nr_cids());
 
 	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
 	if (ret) {
@@ -1104,6 +1201,8 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .dispatch		= (void *)qmap_dispatch,
 	       .tick			= (void *)qmap_tick,
 	       .core_sched_before	= (void *)qmap_core_sched_before,
+	       .set_cpumask		= (void *)qmap_set_cpumask,
+	       .update_idle		= (void *)qmap_update_idle,
 	       .init_task		= (void *)qmap_init_task,
 	       .exit_task		= (void *)qmap_exit_task,
 	       .dump			= (void *)qmap_dump,
-- 
2.53.0

