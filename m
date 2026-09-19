Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F52C3244;
	Sat, 19 Sep 2026 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777722; cv=none; b=snVnCqXmjFl+atTsOVX5STZCSEx/eLNz0hFUwcseVYJcamDZLKbxKTRegdj0kzlMiXbYLtaeNT6TXawhr7Aj0ZXRitYP0fNuPFLmZHgAdghs4nifv+rfAxcIkTDDxmDZuVLtJ4FlZCIpeHEyoL0dnB3x7V2P/6e34M9WI7MXPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777722; c=relaxed/simple;
	bh=FTHAtgy4vZsQalOxH3x88yzu/FdJYRBMyzNj+IACD9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9vBO159bbSMTu5+NgH4y81wCJzipU1hnuTTcA4zdGZLZpK9vRD1fmWrT5e8A+AI5jF77hncSHQn4yR2+1DZXV3UdlNw5r989QOr0rW/xRM3Cy9CcCNUAoQxa7tb/NJ2g4ORIqsRgT0Ekr8Sw6x7liCRbMg0tVGTJwcNIQVLVWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewhnGb+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewhnGb+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C3B1F00898;
	Sat, 19 Sep 2026 00:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777720;
	bh=+LupAdVkfnxLA1tDI01eluObXL54ITiiXTpvAvbPZ/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ewhnGb+vi+H1mxCr6wYToBA5kgr4pYOiCGdUmOWkXEuIx0vF0CQ/rEeGqIfkfUIh5
	 S1dBEGPHF1XK/SkdWvoQ99to4bR57pRO+2KjOuanPDqEOY0TyVOS8fd0Vlr8TxD0iI
	 otkck6DfNXyYzjjq3KIQnf6x6+VIMwCPHnAYtcsCIPvotVIJDlSrLjPTUSRr5hWFU5
	 jufTAvWFWrJ0FTXWAEPnEdhOLb3uK8al8x/riissdm+VckpYPUwbPVwNJptQBt/hWe
	 73jedeuGLc0YsXVppZP/nFX08+xczGKzIyf/g4dM1O0+1O3M3izFD9l+Y5sJ/OVnQs
	 sDIMXNxY3RzAw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Pass the initial cmask to cid-form ops.enable()
Date: Fri, 18 Sep 2026 14:28:37 -1000
Message-ID: <20260919002838.1960071-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919002838.1960071-1-tj@kernel.org>
References: <20260919002838.1960071-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cid-form API has an obvious hole. A task's cid mask is only visible
through ops.set_cmask(), which fires on affinity changes and class switches
but not when a task enters a scheduler through fork, sub-sched enable or
re-home, and there is no p->cpus_ptr equivalent to fall back on. Schedulers
work around it by seeding the mask in ops.init_task() from p->cpus_ptr cid
by cid, which is subtly wrong: on sub-sched enable and re-home, an affinity
change between init_task() and enable() is delivered to the sched the task
is still on, and nothing corrects the new sched's copy afterwards.

Fix it by adding struct scx_enable_args to cid-form ops.enable() carrying
the task's cmask, built in the per-cpu scratch under the rq lock as the task
enters the scheduler, and calling set_cmask() with the same mask right after
enable(), ahead of set_weight(). A scheduler can then track affinity in
set_cmask() alone, and scx_qmap drops its init_task() seed. set_cmask() no
longer fires for a cid-form task before it is enabled, and the class-switch
republish in switching_to_scx() is limited to the cpu form.

This changes the cid-form ops.enable() signature, which is fine as the
cid-form API is still considered unreleased. An args struct rather than a
bare cmask argument leaves room for more initial state without another
signature change, and the cmask travels as a plain arena address because BTF
can't type arena struct members yet.

v2: The cmask travels as a u64 arena address, cmask_arena_addr, instead of a
kernel-typed pointer, with the typing limitation and the planned typed alias
documented (Sashiko review).

v3: The initial set_cmask() is delivered before set_weight() so that the
mask is in place when weight-dependent state is derived (Andrea Righi).
Selftest added.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c         | 92 +++++++++++++++++++++++-----------
 kernel/sched/ext/internal.h    | 56 ++++++++++++++++++---
 tools/sched_ext/scx_qmap.bpf.c |  3 --
 3 files changed, 110 insertions(+), 41 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f568fd9973f6..ad391a8cbd05 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -447,37 +447,45 @@ static void switch_rq_lock(struct rq *from, struct rq *to)
 DEFINE_STATIC_KEY_FALSE(__scx_is_cid_type);
 
 /**
- * scx_call_op_set_cpumask - invoke ops.set_cpumask / ops_cid.set_cmask for @task
+ * scx_fill_cmask_scratch - Build this cpu's arena cmask from @cpumask
+ * @sch: scx_sched whose scratch to fill
+ * @cpumask: cpus to translate into cids
+ *
+ * The scratch lives in BPF-writable arena memory and its header can't be
+ * trusted, so it is rewritten from kernel geometry rather than read. Caller
+ * must hold an rq lock so this cpu is the sole kernel writer for as long as the
+ * returned address is in use.
+ */
+static struct scx_cmask *scx_fill_cmask_scratch(struct scx_sched *sch,
+						const struct cpumask *cpumask)
+{
+	struct scx_cmask *kern_va = *this_cpu_ptr(sch->set_cmask_scratch);
+	struct scx_cmask_ref ref;
+
+	scx_cmask_ref_init_kern(sch, kern_va, 0, num_possible_cpus(), &ref);
+	scx_cmask_ref_from_cpumask(&ref, cpumask);
+	return kern_va;
+}
+
+/**
+ * scx_call_op_set_cpumask - Invoke the set_cpumask or set_cmask op for @task
  * @sch: scx_sched being invoked
  * @rq: rq to update as the currently-locked rq, or NULL
  * @task: task whose affinity is changing
  * @cpumask: new cpumask
  *
- * For cid-form schedulers, translate @cpumask to a cmask via the per-cpu
- * scratch in cid.c and dispatch through the ops_cid union view. Caller
- * must hold @rq's rq lock so this_cpu_ptr is stable across the call.
+ * For cid-form schedulers, translate @cpumask to a cmask in the per-cpu scratch
+ * and dispatch through the ops_cid union view. Caller must hold @rq's rq lock.
  */
 static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 					   struct task_struct *task,
 					   const struct cpumask *cpumask)
 {
-	if (scx_is_cid_type()) {
-		struct scx_cmask *kern_va = *this_cpu_ptr(sch->set_cmask_scratch);
-		struct scx_cmask_ref ref;
-
-		/*
-		 * Build the per-cpu arena cmask from kernel geometry via @ref,
-		 * never reading its BPF-writable header. set_cmask()'s __arena
-		 * argument takes the kernel address and the struct_ops
-		 * trampoline rebases it into BPF's arena pointer form. The rq
-		 * lock makes this cpu the sole kernel writer.
-		 */
-		scx_cmask_ref_init_kern(sch, kern_va, 0, num_possible_cpus(), &ref);
-		scx_cmask_ref_from_cpumask(&ref, cpumask);
-		SCX_CALL_CID_OP_TASK(sch, set_cmask, rq, task, kern_va);
-	} else {
+	if (scx_is_cid_type())
+		SCX_CALL_CID_OP_TASK(sch, set_cmask, rq, task,
+				     scx_fill_cmask_scratch(sch, cpumask));
+	else
 		SCX_CALL_OP_TASK(sch, set_cpumask, rq, task, cpumask);
-	}
 }
 
 enum scx_dsq_iter_flags {
@@ -3634,8 +3642,12 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 	 *
 	 * Fine-grained memory write control is enforced by BPF making the const
 	 * designation pointless. Cast it away when calling the operation.
+	 *
+	 * The cid form receives the initial mask when the task is enabled and
+	 * hears about changes only afterwards, see struct scx_enable_args.
 	 */
-	if (SCX_HAS_OP(sch, set_cpumask))
+	if (SCX_HAS_OP(sch, set_cpumask) &&
+	    (!scx_is_cid_type() || scx_get_task_state(p) == SCX_TASK_ENABLED))
 		scx_call_op_set_cpumask(sch, task_rq(p), p, (struct cpumask *)p->cpus_ptr);
 }
 
@@ -3944,8 +3956,27 @@ static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 
 	p->scx.weight = sched_weight_to_cgroup(weight);
 
-	if (SCX_HAS_OP(sch, enable))
-		SCX_CALL_OP_TASK(sch, enable, rq, p);
+	if (SCX_HAS_OP(sch, enable)) {
+		if (scx_is_cid_type()) {
+			struct scx_cmask *cmask = scx_fill_cmask_scratch(sch, p->cpus_ptr);
+			struct scx_enable_args args = {
+				.cmask_arena_addr = scx_kaddr_to_arena(sch, cmask),
+			};
+
+			SCX_CALL_CID_OP_TASK(sch, enable, rq, p, &args);
+		} else {
+			SCX_CALL_OP_TASK(sch, enable, rq, p);
+		}
+	}
+
+	/*
+	 * The initial mask also goes out through set_cmask() so a scheduler can
+	 * track affinity there alone, and before set_weight() so that the mask
+	 * is in place when weight-dependent state is derived, see struct
+	 * scx_enable_args.
+	 */
+	if (scx_is_cid_type() && SCX_HAS_OP(sch, set_cpumask))
+		scx_call_op_set_cpumask(sch, rq, p, p->cpus_ptr);
 
 	if (SCX_HAS_OP(sch, set_weight))
 		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);
@@ -4288,9 +4319,10 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 
 	/*
 	 * set_cpus_allowed_scx() is not called while @p is associated with a
-	 * different scheduler class. Keep the BPF scheduler up-to-date.
+	 * different scheduler class. Keep the BPF scheduler up-to-date. The cid
+	 * form gets its mask from scx_enable_task().
 	 */
-	if (SCX_HAS_OP(sch, set_cpumask))
+	if (!scx_is_cid_type() && SCX_HAS_OP(sch, set_cpumask))
 		scx_call_op_set_cpumask(sch, rq, p, (struct cpumask *)p->cpus_ptr);
 }
 
@@ -8374,10 +8406,11 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
 /*
  * cid-form cfi stubs. Stubs whose signatures match the cpu-form (param types
  * identical, only param names differ across structs) are reused. Some need
- * fresh stubs, set_cmask due to an argument type difference and the sub-sched
- * notifiers because no cpu-form stub exists to reuse.
+ * fresh stubs, set_cmask and enable due to argument differences and the
+ * sub-sched notifiers because no cpu-form stub exists to reuse.
  */
 static void sched_ext_ops_cid__set_cmask(struct task_struct *p, const struct scx_cmask *cmask__arena) {}
+static void sched_ext_ops_cid__enable(struct task_struct *p, struct scx_enable_args *args) {}
 static void sched_ext_ops__sub_caps_updated(const struct scx_cmask *cmask__arena, u64 caps) {}
 static void sched_ext_ops__sub_ecaps_updated(s32 cid, u64 before, u64 after) {}
 
@@ -8398,7 +8431,7 @@ static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
 	.update_idle		= sched_ext_ops__update_idle,
 	.init_task		= sched_ext_ops__init_task,
 	.exit_task		= sched_ext_ops__exit_task,
-	.enable			= sched_ext_ops__enable,
+	.enable			= sched_ext_ops_cid__enable,
 	.disable		= sched_ext_ops__disable,
 #ifdef CONFIG_EXT_GROUP_SCHED
 	.cpuctl_init		= sched_ext_ops__cgroup_init,
@@ -10421,8 +10454,7 @@ __bpf_kfunc const void *scx_bpf_online_cmask(const struct bpf_prog_aux *aux)
 	if (unlikely(!online))
 		return NULL;
 
-	/* BPF rebases by the low 32 bits, like __arena callback args */
-	return (void *)((unsigned long)online - sch->arena_kern_base);
+	return (void *)scx_kaddr_to_arena(sch, online);
 }
 
 /**
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index d150de10a5c9..1df8f583b0ec 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -250,6 +250,31 @@ struct scx_exit_task_args {
 	bool cancelled;
 };
 
+/**
+ * struct scx_enable_args - Argument container for cid-form ops.enable()
+ * @cmask_arena_addr: BPF arena address of the cmask of cids the task may run on
+ *
+ * @cmask_arena_addr is the task's affinity as it enters the scheduler.
+ * set_cmask() delivers the same mask right after enable(), before set_weight()
+ * and the first enqueue, then every affinity change afterwards, and is never
+ * called before enable(). A scheduler may therefore track affinity in
+ * set_cmask() alone.
+ *
+ * The kernel builds the mask in the scheduler arena from its own geometry, so
+ * the header is valid regardless of what the scheduler last wrote there. The
+ * memory is per-cpu scratch reused once the callback returns: copy the bits
+ * out, don't keep the address. The set_cmask() argument follows the same rules.
+ *
+ * The address is a plain value rather than a typed pointer because BTF can't
+ * mark a struct member as an arena pointer yet and a pointer member would reach
+ * the program typed as a kernel pointer. Cast it to struct scx_cmask __arena *
+ * before use. Once arena members can be typed, a typed alias will join this
+ * field in an anonymous union at the same offset.
+ */
+struct scx_enable_args {
+	u64	cmask_arena_addr;
+};
+
 /* argument container for ops.cgroup_init() */
 struct scx_cgroup_init_args {
 	/* the weight of the cgroup [1..10000] */
@@ -1037,6 +1062,7 @@ struct sched_ext_ops {
  *   - dispatch         -> dispatch (cpu arg is now cid)
  *   - update_idle      -> update_idle (cpu arg is now cid)
  *   - set_cpumask      -> set_cmask (cmask instead of cpumask)
+ *   - enable           -> enable (takes struct scx_enable_args)
  *   - cpu_online       -> cid_online
  *   - cpu_offline      -> cid_offline
  *   - dump_cpu         -> dump_cid
@@ -1070,7 +1096,7 @@ struct sched_ext_ops_cid {
 			  struct scx_init_task_args *args);
 	void (*exit_task)(struct task_struct *p,
 			   struct scx_exit_task_args *args);
-	void (*enable)(struct task_struct *p);
+	void (*enable)(struct task_struct *p, struct scx_enable_args *args);
 	void (*disable)(struct task_struct *p);
 	void (*dump)(struct scx_dump_ctx *ctx);
 	void (*dump_cid)(struct scx_dump_ctx *ctx, s32 cid, bool idle);
@@ -1533,7 +1559,8 @@ struct scx_sched {
 	 * by BUILD_BUG_ON in scx_init()). The anonymous union lets the kernel
 	 * access either view of the same storage without function-pointer
 	 * casts: use .ops for cpu-form and shared fields, .ops_cid for the
-	 * cid-renamed callbacks (set_cmask, select_cid, cid_online, ...).
+	 * callbacks whose cid-form signature differs (set_cmask, enable,
+	 * select_cid, cid_online, ...).
 	 */
 	union {
 		struct sched_ext_ops		ops;
@@ -1556,9 +1583,9 @@ struct scx_sched {
 	uintptr_t		arena_kern_base;
 
 	/*
-	 * Per-CPU arena cmask used by scx_call_op_set_cpumask() to hand a cmask
-	 * to ops_cid.set_cmask(). The kernel writes through the stored kern_va
-	 * and passes it to the callback's __arena argument.
+	 * Per-CPU arena cmask the kernel fills from a task's cpumask and hands
+	 * to ops_cid.enable() and ops_cid.set_cmask(). The stored pointers are
+	 * the kernel addresses.
 	 */
 	struct scx_cmask * __percpu *set_cmask_scratch;
 	struct scx_cmask *online_cmask;
@@ -1669,6 +1696,19 @@ static inline void *scx_arena_to_kaddr(struct scx_sched *sch, const void *bpf_pt
 	return (void *)(sch->arena_kern_base + (u32)(uintptr_t)bpf_ptr);
 }
 
+/**
+ * scx_kaddr_to_arena - Translate a kernel arena address to the BPF form
+ * @sch: scheduler whose arena hosts @kaddr
+ * @kaddr: kernel address inside @sch's arena
+ *
+ * __arena callback arguments need no translation. Addresses handed to BPF any
+ * other way, such as struct fields and kfunc return values, go through this.
+ */
+static inline uintptr_t scx_kaddr_to_arena(struct scx_sched *sch, const void *kaddr)
+{
+	return (uintptr_t)kaddr - sch->arena_kern_base;
+}
+
 enum scx_wake_flags {
 	/* expose select WF_* flags as enums */
 	SCX_WAKE_FORK		= WF_FORK,
@@ -2302,9 +2342,9 @@ do {										\
 } while (0)
 
 /*
- * Dispatch a task op through the cid-form ops_cid table. Only set_cmask() needs
- * this: it takes an arena cmask address instead of a cpumask, so it cannot be
- * invoked via its cpu-form set_cpumask() slot.
+ * Dispatch a task op through the cid-form ops_cid table, for the ops whose
+ * cid-form signature differs from the cpu-form slot: set_cmask() takes an arena
+ * cmask instead of a cpumask and enable() takes scx_enable_args.
  */
 #define SCX_CALL_CID_OP_TASK(sch, op, locked_rq, task, args...)			\
 	__SCX_CALL_OP_TASK(sch, ops_cid, op, locked_rq, task, ##args)
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 67b7c01cae55..2f3653199842 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -961,9 +961,6 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_task, struct task_struct *p,
 	taskc->highpri = false;
 	taskc->core_sched_seq = 0;
 	cmask_init(&taskc->cpus_allowed, 0, scx_bpf_nr_cids());
-	bpf_rcu_read_lock();
-	cmask_from_cpumask(&taskc->cpus_allowed, p->cpus_ptr);
-	bpf_rcu_read_unlock();
 
 	v = bpf_task_storage_get(&task_ctx_stor, p, NULL,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
-- 
2.55.0

