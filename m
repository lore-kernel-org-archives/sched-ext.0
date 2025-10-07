Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BC1FF1B5;
	Tue,  7 Oct 2025 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759801912; cv=none; b=jPW3Dq45x42k1IxjvuaPqYmbCaA/VpDmFeOZD3IJABxmXh7CBHq+g9z2L22YIAs/KEV3qzYgITiDRZSB7VKkhlKwCCrQnE2L+uJKuaiAYOOy9XDoMFZTpYHCFyghSOHhXPDZAefIldoFH9xgLw6S4YAQZ31SUz6/dD9GhbWT2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759801912; c=relaxed/simple;
	bh=Ay9ceGKK5NxBM1wuW1Lv6k49vpGB9g7+W94UnvV/TtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3K2wZBdTv+kQrv4iFr5of+fpqySVrLNpO4EJ5s7CaTSRLjfOGrIxKG5c97wusDUxuuABtTmWtQ8wTzNenkF7SKVGsen0NuP1Mz6P1K8jlg8v74HD+IsfmQbhxoXfM0TGFQ+QxrFOQFw3969v96Wqw5ZNxW2j9ZoXJG9m0ZeHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVrnMARa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVrnMARa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8590FC113D0;
	Tue,  7 Oct 2025 01:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759801911;
	bh=Ay9ceGKK5NxBM1wuW1Lv6k49vpGB9g7+W94UnvV/TtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVrnMARagoqUQe6m1gCP5lEkvNAypowdn58WhPpFs6/jDD0W/w+/a7cmx4IWoUTuX
	 PYMLPfO4XHT/oEwqk86wZJvlD/fL4/7LKrMiCEzOqTEMuYS1+qe+SIg/avYD13XuXd
	 hNhpKiRwQ3eWM1QhP859hiEXkXZ2wnlxZ69+znkBkskLAcDtVfjmIkvulD3uvqAIBk
	 1xsaHibk/8LzOJkebz7mxhwKPLJjd4WeltbRuZtqLk4X57Bn0fJlVDZAxoxiHGiVC+
	 zHaIEubkmOLrRPiQyfWO3q+QTz6LCQOvbx6EVrYSCaVCPz/DM+ft3VoqUlif1duwbY
	 rYUK4cd81BWCw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] sched_ext: Wrap kfunc args in struct to prepare for aux__prog
Date: Mon,  6 Oct 2025 15:51:46 -1000
Message-ID: <20251007015147.2496026-4-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007015147.2496026-1-tj@kernel.org>
References: <20251007015147.2496026-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_insert_vtime() and scx_bpf_select_cpu_and() currently have 5
parameters. An upcoming change will add aux__prog parameter which will exceed
BPF's 5 argument limit.

Prepare by adding new kfuncs __scx_bpf_dsq_insert_vtime() and
__scx_bpf_select_cpu_and() that take args structs. The existing kfuncs are
kept as compatibility wrappers. BPF programs use inline wrappers that detect
kernel API version via bpf_core_type_exists() and use the new struct-based
kfuncs when available, falling back to compat kfuncs otherwise. This allows
BPF programs to work with both old and new kernels.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                       | 82 ++++++++++++++++++------
 kernel/sched/ext_idle.c                  | 43 +++++++++++--
 tools/sched_ext/include/scx/common.bpf.h |  6 +-
 tools/sched_ext/include/scx/compat.bpf.h | 72 +++++++++++++++++++++
 4 files changed, 173 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6d76efaaa9b2..a34e731229de 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5345,54 +5345,94 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
 	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
 }
 
+static void scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
+				 u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags)
+{
+	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
+		return;
+
+	if (slice)
+		p->scx.slice = slice;
+	else
+		p->scx.slice = p->scx.slice ?: 1;
+
+	p->scx.dsq_vtime = vtime;
+
+	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+}
+
+struct scx_bpf_dsq_insert_vtime_args {
+	/* @p can't be packed together as KF_RCU is not transitive */
+	u64			dsq_id;
+	u64			slice;
+	u64			vtime;
+	u64			enq_flags;
+};
+
 /**
- * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queue of a DSQ
+ * __scx_bpf_dsq_insert_vtime - Arg-wrapped vtime DSQ insertion
  * @p: task_struct to insert
- * @dsq_id: DSQ to insert into
- * @slice: duration @p can run for in nsecs, 0 to keep the current value
- * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
- * @enq_flags: SCX_ENQ_*
+ * @args: struct containing the rest of the arguments
+ *       @args->dsq_id: DSQ to insert into
+ *       @args->slice: duration @p can run for in nsecs, 0 to keep the current value
+ *       @args->vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
+ *       @args->enq_flags: SCX_ENQ_*
  *
- * Insert @p into the vtime priority queue of the DSQ identified by @dsq_id.
- * Tasks queued into the priority queue are ordered by @vtime. All other aspects
- * are identical to scx_bpf_dsq_insert().
+ * Wrapper kfunc that takes arguments via struct to work around BPF's 5 argument
+ * limit. BPF programs should use scx_bpf_dsq_insert_vtime() which is provided
+ * as an inline wrapper in common.bpf.h.
  *
- * @vtime ordering is according to time_before64() which considers wrapping. A
- * numerically larger vtime may indicate an earlier position in the ordering and
- * vice-versa.
+ * Insert @p into the vtime priority queue of the DSQ identified by
+ * @args->dsq_id. Tasks queued into the priority queue are ordered by
+ * @args->vtime. All other aspects are identical to scx_bpf_dsq_insert().
+ *
+ * @args->vtime ordering is according to time_before64() which considers
+ * wrapping. A numerically larger vtime may indicate an earlier position in the
+ * ordering and vice-versa.
  *
  * A DSQ can only be used as a FIFO or priority queue at any given time and this
  * function must not be called on a DSQ which already has one or more FIFO tasks
  * queued and vice-versa. Also, the built-in DSQs (SCX_DSQ_LOCAL and
  * SCX_DSQ_GLOBAL) cannot be used as priority queues.
  */
-__bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
-					  u64 slice, u64 vtime, u64 enq_flags)
+__bpf_kfunc void
+__scx_bpf_dsq_insert_vtime(struct task_struct *p,
+			   struct scx_bpf_dsq_insert_vtime_args *args)
 {
 	struct scx_sched *sch;
 
 	guard(rcu)();
+
 	sch = rcu_dereference(scx_root);
 	if (unlikely(!sch))
 		return;
 
-	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
-		return;
+	scx_dsq_insert_vtime(sch, p, args->dsq_id, args->slice, args->vtime,
+			     args->enq_flags);
+}
 
-	if (slice)
-		p->scx.slice = slice;
-	else
-		p->scx.slice = p->scx.slice ?: 1;
+/*
+ * COMPAT: Will be removed in v6.23.
+ */
+__bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
+					  u64 slice, u64 vtime, u64 enq_flags)
+{
+	struct scx_sched *sch;
 
-	p->scx.dsq_vtime = vtime;
+	guard(rcu)();
 
-	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return;
+
+	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
 }
 
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
+BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
 
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index d2434c954848..3d9d404d5cd2 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -995,26 +995,56 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	return prev_cpu;
 }
 
+struct scx_bpf_select_cpu_and_args {
+	/* @p and @cpus_allowed can't be packed together as KF_RCU is not transitive */
+	s32			prev_cpu;
+	u64			wake_flags;
+	u64			flags;
+};
+
 /**
- * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p,
- *			    prioritizing those in @cpus_allowed
+ * __scx_bpf_select_cpu_and - Arg-wrapped CPU selection with cpumask
  * @p: task_struct to select a CPU for
- * @prev_cpu: CPU @p was on previously
- * @wake_flags: %SCX_WAKE_* flags
  * @cpus_allowed: cpumask of allowed CPUs
- * @flags: %SCX_PICK_IDLE* flags
+ * @args: struct containing the rest of the arguments
+ *       @args->prev_cpu: CPU @p was on previously
+ *       @args->wake_flags: %SCX_WAKE_* flags
+ *       @args->flags: %SCX_PICK_IDLE* flags
+ *
+ * Wrapper kfunc that takes arguments via struct to work around BPF's 5 argument
+ * limit. BPF programs should use scx_bpf_select_cpu_and() which is provided
+ * as an inline wrapper in common.bpf.h.
  *
  * Can be called from ops.select_cpu(), ops.enqueue(), or from an unlocked
  * context such as a BPF test_run() call, as long as built-in CPU selection
  * is enabled: ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE
  * is set.
  *
- * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ * @p, @args->prev_cpu and @args->wake_flags match ops.select_cpu().
  *
  * Returns the selected idle CPU, which will be automatically awakened upon
  * returning from ops.select_cpu() and can be used for direct dispatch, or
  * a negative value if no idle CPU is available.
  */
+__bpf_kfunc s32
+__scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
+			 struct scx_bpf_select_cpu_and_args *args)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
+	return select_cpu_from_kfunc(sch, p, args->prev_cpu, args->wake_flags,
+				     cpus_allowed, args->flags);
+}
+
+/*
+ * COMPAT: Will be removed in v6.22.
+ */
 __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 				       const struct cpumask *cpus_allowed, u64 flags)
 {
@@ -1383,6 +1413,7 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
+BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_idle)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 505231b7b7ae..b1c2a0dde76e 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -60,10 +60,10 @@ static inline void ___vmlinux_h_sanity_check___(void)
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
-s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
+s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
+			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
 void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
-void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
+void __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index d979f16a3ae2..e172de696f99 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -143,6 +143,78 @@ static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
 	return rq ? rq->curr : NULL;
 }
 
+/*
+ * v6.19: To work around BPF maximum parameter limit, the following kfuncs are
+ * replaced with variants that pack scalar arguments in a struct. Wrappers are
+ * provided to maintain source compatibility.
+ *
+ * The kernel will carry the compat variants until v6.23 to maintain binary
+ * compatibility. After v6.23 release, remove the compat handling and move the
+ * wrappers to common.bpf.h.
+ */
+s32 scx_bpf_select_cpu_and___compat(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+				    const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
+void scx_bpf_dsq_insert_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
+
+/**
+ * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @cpus_allowed: cpumask of allowed CPUs
+ * @flags: %SCX_PICK_IDLE* flags
+ *
+ * Inline wrapper that packs scalar arguments into a struct and calls
+ * __scx_bpf_select_cpu_and(). See __scx_bpf_select_cpu_and() for details.
+ */
+static inline s32
+scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+		       const struct cpumask *cpus_allowed, u64 flags)
+{
+	if (bpf_core_type_exists(struct scx_bpf_select_cpu_and_args)) {
+		struct scx_bpf_select_cpu_and_args args = {
+			.prev_cpu = prev_cpu,
+			.wake_flags = wake_flags,
+			.flags = flags,
+		};
+
+		return __scx_bpf_select_cpu_and(p, cpus_allowed, &args);
+	} else {
+		return scx_bpf_select_cpu_and___compat(p, prev_cpu, wake_flags,
+						       cpus_allowed, flags);
+	}
+}
+
+/**
+ * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queue of a DSQ
+ * @p: task_struct to insert
+ * @dsq_id: DSQ to insert into
+ * @slice: duration @p can run for in nsecs, 0 to keep the current value
+ * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
+ * @enq_flags: SCX_ENQ_*
+ *
+ * Inline wrapper that packs scalar arguments into a struct and calls
+ * __scx_bpf_dsq_insert_vtime(). See __scx_bpf_dsq_insert_vtime() for details.
+ */
+static inline void
+scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime,
+			 u64 enq_flags)
+{
+	if (bpf_core_type_exists(struct scx_bpf_dsq_insert_vtime_args)) {
+		struct scx_bpf_dsq_insert_vtime_args args = {
+			.dsq_id = dsq_id,
+			.slice = slice,
+			.vtime = vtime,
+			.enq_flags = enq_flags,
+		};
+
+		__scx_bpf_dsq_insert_vtime(p, &args);
+	} else {
+		scx_bpf_dsq_insert_vtime___compat(p, dsq_id, slice, vtime,
+						  enq_flags);
+	}
+}
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.51.0

