Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4FD3C199C;
	Mon, 14 Sep 2026 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429389; cv=none; b=GdfBdxZweyP7a7K6rw5ZgYF8Ylnpog9aB2en1ItwUeajL2e+9wB5QSjUCHu8X8bUz8uQDEhWrR/bMRmSow6SMJjhWQ4cXX8I04HuH6lA3kqDa159aElVXCLYb+nAqJ49MODLqUAgO9ohScWzSfCpUMBR7uL3NZZxgMfHXsinKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429389; c=relaxed/simple;
	bh=3E8geTbYhBWUox9lbnQJ++A6EV6sxl1jjoKTms1DRjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoKMN1+7jNb0HtgQrc2+4a4eaqjeDXcslIUILlTl7jzmbqs4KTIYOZCA90tqBuamjQEBGecwBovtYkN7HFpDA6KGdnayMK4vrj7H6YyCmggwjaf3mmCUSDOnCItB9aYGqQieork0U9cCilB6nChhuZgl1AwZD6DRW9XEe+5gixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgNi9T/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgNi9T/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B2D1F00893;
	Mon, 14 Sep 2026 23:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429381;
	bh=ii/BA/6tiYCc5mjghpZFLPSkPt99ZmLCaLCr2wju5TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hgNi9T/cJHsyfb42wPn131K+bNldkeQ61acCvYFWqipZlcYbgnJguOUr6KqwaCTX1
	 0MIEajw+tBMiQgPOi/FHEq6oh17PSe5drYu0bf27w+A4QwxeAefw2fCFHYZ6YAB1tB
	 /RvNzVIWdYSRkONU8spnTlsFQUmssFiR7b2+Qgf+ulhACCfXf1JNAxUykQGeKSKwjq
	 e8TVZHsIETNUZH173kutgwL5ulHARkpFEiMNSp4Sc7P9qg205e0sbWYeWP0XoVc8Yn
	 ehlyrkBsCAL9WQMs7aP4Ik2/Lkr+x8tEBRbMymaf2IpcWV9eKIxrQDQAhIKoY7aWiU
	 LgEnwtDr/r3mw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Fix idle state tracking across idle repicks
Date: Mon, 14 Sep 2026 13:42:58 -1000
Message-ID: <20260914234259.3585373-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914234259.3585373-1-tj@kernel.org>
References: <20260914234259.3585373-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An idle CPU can be reserved and kicked without receiving a task. When it
picks idle again, the builtin idle masks recover the reservation, but
ops.update_idle() is not called. The BPF scheduler's own idle tracking can
leave the CPU unavailable until another real idle transition. This is a hole
in the notification interface: BPF schedulers cannot reliably recover unused
idle reservations, which is required for cid-form schedulers to maintain
their own idle tracking.

Fix this by notifying on idle-to-idle picks and making these notifications
automatic for cid-form schedulers. Keep CPU-form schedulers opt-in because
existing callbacks may restart idle accounting or repeat actions intended
only for idle entry. The known cid-form users, scx_qmap in tools/sched_ext
and scx_nitosis in the scx repository, have idempotent update_idle() bodies.
All sub-schedulers use the cid form, so this is a root property and can use
a static key.

scx_root_enable_workfn() must initialize idle tracking from sch->ops, where
the automatic cid flag has been set. The local ops pointer still refers to
the caller-provided table. Using it would leave the static key disabled for
cid-form schedulers that omit the flag.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c                        |  3 +-
 kernel/sched/ext/idle.c                       | 60 +++++++++++--------
 kernel/sched/ext/internal.h                   | 21 ++++++-
 tools/sched_ext/include/scx/compat.h          |  2 +
 .../sched_ext/include/scx/enum_defs.autogen.h |  1 +
 .../sched_ext/include/scx/enums_abi.autogen.h |  3 +-
 6 files changed, 60 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 83999203a63a..934605dfd950 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7251,6 +7251,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 	 */
 	if (cmd->is_cid_type) {
 		sch->ops_cid = *cmd->ops_cid;
+		sch->ops_cid.flags |= SCX_OPS_UPDATE_IDLE_TO_IDLE;
 		sch->is_cid_type = true;
 	} else {
 		sch->ops = *cmd->ops;
@@ -7575,7 +7576,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		goto err_disable;
 	}
 
-	scx_idle_enable(ops);
+	scx_idle_enable(&sch->ops);
 
 	/*
 	 * A cid-form scheduler finalizes its cid layout in ops.init_cids(),
diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index aa9fb6de0ad6..ea2fe5030fc4 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -20,6 +20,9 @@ static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 /* Enable/disable per-node idle cpumasks */
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
 
+/* Idle-to-idle notifications are a property of the root hierarchy. */
+static DEFINE_STATIC_KEY_FALSE(scx_update_idle_to_idle);
+
 /* Enable/disable LLC aware optimizations */
 static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
 
@@ -734,13 +737,12 @@ static void update_builtin_idle(int cpu, bool idle)
 }
 
 /*
- * Notify schedulers of an idle transition on @cpu's cid, delivering to every
- * sched that holds %SCX_CAP_BASE on the cid (the root holds every cap). A real
- * transition (@do_notify) reaches all holders. A forced one (@root_renotify for
- * the root, a sub-sched's idle_renotify marker for a sub) reaches only the owed
- * scheds.
+ * Notify schedulers holding %SCX_CAP_BASE on @rq's cid (the root holds every
+ * cap). Real transitions and enabled idle repicks (@notify_all) reach all
+ * holders. A forced notification (@root_renotify for the root, a sub-sched's
+ * idle_renotify marker for a sub) reaches only the owed scheds.
  */
-static void scx_idle_notify(struct rq *rq, bool idle, bool do_notify, bool root_renotify)
+static void scx_idle_notify(struct rq *rq, bool idle, bool notify_all, bool root_renotify)
 {
 	s32 cpu = cpu_of(rq);
 	s32 cid = scx_cpu_arg(cpu);
@@ -751,7 +753,7 @@ static void scx_idle_notify(struct rq *rq, bool idle, bool do_notify, bool root_
 
 	/* with no sub-sched, only the root can be owed a notification */
 	if (!scx_has_subs()) {
-		if ((do_notify || root_renotify) &&
+		if ((notify_all || root_renotify) &&
 		    SCX_HAS_OP(root, update_idle) && !scx_bypassing(root, cpu))
 			SCX_CALL_OP(root, update_idle, rq, cid, idle);
 		return;
@@ -775,8 +777,8 @@ static void scx_idle_notify(struct rq *rq, bool idle, bool do_notify, bool root_
 			forced = true;
 		}
 #endif
-		if ((do_notify || forced) && SCX_HAS_OP(pos, update_idle) &&
-		    !scx_bypassing(pos, cpu))
+		if ((notify_all || forced) &&
+		    SCX_HAS_OP(pos, update_idle) && !scx_bypassing(pos, cpu))
 			SCX_CALL_OP(pos, update_idle, rq, cid, idle);
 		pos = scx_next_descendant_pre(pos, root);
 	}
@@ -786,21 +788,22 @@ static void scx_idle_notify(struct rq *rq, bool idle, bool do_notify, bool root_
  * Update the idle state of a CPU to @idle.
  *
  * If @do_notify is true, ops.update_idle() is invoked to notify the scx
- * scheduler of an actual idle state transition (idle to busy or vice
- * versa). If @do_notify is false, only the idle state in the idle masks is
- * refreshed without invoking ops.update_idle().
+ * scheduler of an actual idle state transition (idle to busy or vice versa). If
+ * @do_notify is false, refresh the idle masks and notify schedulers with
+ * %SCX_OPS_UPDATE_IDLE_TO_IDLE or an outstanding forced notification.
  *
  * This distinction is necessary, because an idle CPU can be "reserved" and
- * awakened via scx_bpf_pick_idle_cpu() + scx_bpf_kick_cpu(), marking it as
- * busy even if no tasks are dispatched. In this case, the CPU may return
- * to idle without a true state transition. Refreshing the idle masks
- * without invoking ops.update_idle() ensures accurate idle state tracking
- * while avoiding unnecessary updates and maintaining balanced state
- * transitions.
+ * awakened via scx_bpf_pick_idle_cpu() + scx_bpf_kick_cpu(), marking it as busy
+ * even if no tasks are dispatched. In this case, the CPU may return to idle
+ * without a true state transition. Refreshing idle tracking restores the unused
+ * reservation. Schedulers receiving repeated notifications must distinguish
+ * idle refreshes from transitions for accounting.
  */
 void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 {
 	int cpu = cpu_of(rq);
+	u32 renotify;
+	bool notify_all;
 
 	lockdep_assert_rq_held(rq);
 
@@ -818,20 +821,19 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 	 * An idle pick also fires it to flush a forced notify owed to a sched
 	 * that missed transitions while bypassed or on a cid it just gained.
 	 * unbypass_renotify_idle() and scx_process_sync_ecaps() arm the per-rq
-	 * gates, and scx_idle_notify() targets the owed scheds.
+	 * gates, and scx_idle_notify() targets the owed scheds. Schedulers with
+	 * SCX_OPS_UPDATE_IDLE_TO_IDLE receive every idle pick.
 	 *
 	 * This must come after the builtin idle update so that BPF schedulers
 	 * can create interlocking between ops.update_idle() and ops.enqueue() -
 	 * either enqueue() sees the idle bit or update_idle() sees the task
 	 * that enqueue() queued.
 	 */
-	if (do_notify ||
-	    (idle && (rq->scx.flags &
-		      (SCX_RQ_SUB_IDLE_RENOTIFY | SCX_RQ_ROOT_IDLE_RENOTIFY)))) {
-		bool root_renotify = rq->scx.flags & SCX_RQ_ROOT_IDLE_RENOTIFY;
-
-		rq->scx.flags &= ~(SCX_RQ_SUB_IDLE_RENOTIFY | SCX_RQ_ROOT_IDLE_RENOTIFY);
-		scx_idle_notify(rq, idle, do_notify, root_renotify);
+	notify_all = do_notify || (idle && static_branch_unlikely(&scx_update_idle_to_idle));
+	renotify = rq->scx.flags & (SCX_RQ_SUB_IDLE_RENOTIFY | SCX_RQ_ROOT_IDLE_RENOTIFY);
+	if (notify_all || (idle && renotify)) {
+		rq->scx.flags &= ~renotify;
+		scx_idle_notify(rq, idle, notify_all, renotify & SCX_RQ_ROOT_IDLE_RENOTIFY);
 	}
 }
 
@@ -869,6 +871,11 @@ void scx_idle_enable(struct sched_ext_ops *ops)
 	else
 		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
 
+	if (ops->flags & SCX_OPS_UPDATE_IDLE_TO_IDLE)
+		static_branch_enable_cpuslocked(&scx_update_idle_to_idle);
+	else
+		static_branch_disable_cpuslocked(&scx_update_idle_to_idle);
+
 	reset_idle_masks(ops);
 }
 
@@ -876,6 +883,7 @@ void scx_idle_disable(void)
 {
 	static_branch_disable(&scx_builtin_idle_enabled);
 	static_branch_disable(&scx_builtin_idle_per_node);
+	static_branch_disable(&scx_update_idle_to_idle);
 }
 
 /********************************************************************************
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 076a351bb3f2..2586879e9084 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -215,6 +215,14 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * Call ops.update_idle() with idle=true when an idle CPU picks idle
+	 * again. Custom idle tracking can use this to restore an unused idle
+	 * reservation after a kick that did not dispatch a task. Automatically
+	 * enabled for cid-form schedulers.
+	 */
+	SCX_OPS_UPDATE_IDLE_TO_IDLE	= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -223,7 +231,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_UPDATE_IDLE_TO_IDLE,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -572,6 +581,14 @@ struct sched_ext_ops {
 	 *
 	 * Specify the %SCX_OPS_KEEP_BUILTIN_IDLE flag to keep the built-in idle
 	 * tracking.
+	 *
+	 * With %SCX_OPS_UPDATE_IDLE_TO_IDLE, this operation is also called with
+	 * @idle true when an idle CPU picks idle again without leaving the
+	 * idle state. The flag is automatically enabled for cid-form
+	 * schedulers. Such notifications must not restart idle accounting or
+	 * repeat actions that require an actual idle entry. Track the previous
+	 * idle state separately from availability bits cleared by idle
+	 * reservations.
 	 */
 	void (*update_idle)(s32 cpu, bool idle);
 
@@ -1029,7 +1046,7 @@ struct sched_ext_ops {
  * Differences from sched_ext_ops:
  *   - select_cpu       -> select_cid (returns cid)
  *   - dispatch         -> dispatch (cpu arg is now cid)
- *   - update_idle      -> update_idle (cpu arg is now cid)
+ *   - update_idle      -> update_idle (cid arg, also called on idle repicks)
  *   - set_cpumask      -> set_cmask (cmask instead of cpumask)
  *   - cpu_online       -> cid_online
  *   - cpu_offline      -> cid_offline
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 7c12df45fdba..b96f2cd8b593 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -214,6 +214,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
 #define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
+#define SCX_OPS_UPDATE_IDLE_TO_IDLE SCX_OPS_FLAG(SCX_OPS_UPDATE_IDLE_TO_IDLE)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
@@ -273,6 +274,7 @@ static inline long scx_hotplug_seq(void)
  * - v6.19: ops.cgroup_set_idle()
  * - v7.1:  ops.sub_attach(), ops.sub_detach(), ops.sub_cgroup_id
  * - v7.3:  ops.rescue_bandwidth_ppt, ops.rescue_quantum_us
+ * - v7.3:  SCX_OPS_UPDATE_IDLE_TO_IDLE
  */
 #define __SCX_OPS_OPEN(__ops_name, __scx_name, __ops_struct) ({			\
 	struct __scx_name *__oskel;						\
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 63b6b14b19bd..c7a7baae95f4 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -164,6 +164,7 @@
 #define HAVE_SCX_OPS_BUILTIN_IDLE_PER_NODE
 #define HAVE_SCX_OPS_ALWAYS_ENQ_IMMED
 #define HAVE_SCX_OPS_TID_TO_TASK
+#define HAVE_SCX_OPS_UPDATE_IDLE_TO_IDLE
 #define HAVE_SCX_OPS_ALL_FLAGS
 #define HAVE___SCX_OPS_INTERNAL_MASK
 #define HAVE_SCX_OPS_HAS_CPU_PREEMPT
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index d53899764f5a..609ccacaba7e 100644
--- a/tools/sched_ext/include/scx/enums_abi.autogen.h
+++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
@@ -176,7 +176,8 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE", 0x40LLU },
 	{ "scx_ops_flags", "SCX_OPS_ALWAYS_ENQ_IMMED", 0x80LLU },
 	{ "scx_ops_flags", "SCX_OPS_TID_TO_TASK", 0x100LLU },
-	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x1ffLLU },
+	{ "scx_ops_flags", "SCX_OPS_UPDATE_IDLE_TO_IDLE", 0x200LLU },
+	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x3ffLLU },
 	{ "scx_ops_flags", "__SCX_OPS_INTERNAL_MASK", 0xff00000000000000LLU },
 	{ "scx_ops_flags", "SCX_OPS_HAS_CPU_PREEMPT", 0x100000000000000LLU },
 	{ "scx_ops_state", "SCX_OPSS_NONE", 0x0LLU },
-- 
2.55.0

