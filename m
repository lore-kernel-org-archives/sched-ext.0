Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79C352C3C;
	Tue, 18 Aug 2026 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787086636; cv=none; b=WY9MOtqDOwHUb09DoVoobfo+s7KY6SyqO/WFgRKOlhoxZ8AvSSct5GIyj3WjbrDcJchT7p2cqbZsKJuafU/wWtLkl9n9fEZ+O5TQ11W4LCiZXcpi/CufeHiKQ/uB0dyLF/xKQFnLYnWBOTaXJnN6ihS/C4tQr3yrQNcA041txmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787086636; c=relaxed/simple;
	bh=YnV8vHa1gI4gkQoJe672avej7pGRhm6MeStUzbdhjlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC3lIs1z8g0eb2Sh3Gq6JqQvs5FBwfkdiZbVV7MEeVb0gbgTEHkEX4q3g527EgnXgGwiNRTuntPolNo8x0Q0zj5phtCoOL0LXuWYKdpcjsNZes/FUQfWitXs9YbWvJLoNKhMdHPWuJqHJKsIr1q55TQpUqYGMBP2Q/md9NF4ahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUrpqswH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUrpqswH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92781F00A3D;
	Tue, 18 Aug 2026 20:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787086634;
	bh=Ubu7iSRAThYpL1QhjOmTowkgc/jU3mQM4RKugz/sX20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUrpqswH77oHKw5DZvngPrAHRd5DvTGyD8MtMecIrzOWg2TQtE+rfC8IpPC2C1XOX
	 scZ9Uod20gAkBv8W90q0omODWIR4DNxjlYQQvxXqYxqUPYAeH3c7Wi2XOmwyaB03i9
	 hqcM5VWfQ68ErRdkEj/nWHqv8rB1vVWRKiBMkXnViaoXYWVvVo/hota10pVoMrQoYU
	 egdBDNlXCSozDsYXUUBBpJWBS2669TYDsI1fxswi1/gvkgW1am62pTURaPQDegTfMW
	 EU6GpqT+NU4S1MlVVqY4Q/X/YdAK9K8n8zQHQuRCWQrGX60AffjXsdFgAcGsSa+6GB
	 olNpOr99m85Pg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Gavin Guo <gavinguo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Sync common and compat headers from the scx repo
Date: Tue, 18 Aug 2026 10:57:11 -1000
Message-ID: <20260818205711.3175265-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818205711.3175265-1-tj@kernel.org>
References: <20260818205711.3175265-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync common.bpf.h, compat.bpf.h and compat.h with the scx repo, which
accumulated the following:

- __COMPAT_read_enum() can now recover 64-bit scx enum values from kernel
  BTF generated without BTF_KIND_ENUM64 support (pahole < 1.24 or
  --skip_encoding_btf_enum64, e.g. COS/GKE kernels), substituting values
  from the build-time vmlinux.h cross-checked against the low 32 bits the
  kernel does provide.

- is_migration_disabled() no longer assumes the BPF prolog always disables
  migration. Since 8e4f0b1ebcf2 ("bpf: use rcu_read_lock_dont_migrate() for
  trampoline.c") the prolog only does so under CONFIG_PREEMPT_RCU, so the
  old current-task test under-reported on v6.18+ !PREEMPT_RCU kernels. A
  runtime probe on bpf_scx_reg() handles older kernels with backported
  trampoline behavior.

- __COMPAT_scx_bpf_dsq_peek() is gated behind kernel v7.1 where 2f2ea7709266
  ("sched_ext: Use dsq->first_task instead of list_empty() in
  dispatch_enqueue() FIFO-tail") fixed the kfunc spuriously returning NULL
  on non-empty FIFO DSQs, and the new
  scx_bpf_reenqueue_local_from_anywhere() provides a callable-from-anywhere
  reenqueue which prefers the generic scx_bpf_dsq_reenq(). Both were first
  posted by Gavin Guo and Changwoo Min and are picked up here with the
  review feedback folded in.

- __COMPAT_scx_bpf_cpu_curr() and the scx_bpf_cpu_rq() declaration are
  restored. Schedulers built from these headers still run on pre-v6.18
  kernels where scx_bpf_cpu_curr() does not resolve and the scx_bpf_cpu_rq()
  fallback still exists.

- scx_clock_task() and scx_clock_pelt() document their stale-read behavior
  for remote idle CPUs under NO_HZ_IDLE.

Link: https://lore.kernel.org/all/20260817143126.562923-1-changwoo@igalia.com
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/common.bpf.h | 140 +++++++++++++++++++----
 tools/sched_ext/include/scx/compat.bpf.h |  68 +++++++++--
 tools/sched_ext/include/scx/compat.h     |  97 ++++++++++++++++
 3 files changed, 274 insertions(+), 31 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 979d4cabfaf9..76f5e025e107 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -48,6 +48,7 @@
 extern int LINUX_KERNEL_VERSION __kconfig;
 extern const char CONFIG_CC_VERSION_TEXT[64] __kconfig __weak;
 extern const char CONFIG_LOCALVERSION[64] __kconfig __weak;
+extern bool CONFIG_PREEMPT_RCU __kconfig __weak;
 
 /*
  * Earlier versions of clang/pahole lost upper 32bits in 64bit enums which can
@@ -97,6 +98,7 @@ s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
+struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym __weak;
 struct rq *scx_bpf_locked_rq(void) __ksym;
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
 struct task_struct *scx_bpf_tid_to_task(u64 tid) __ksym __weak;
@@ -527,32 +529,103 @@ static __always_inline const struct cpumask *cast_mask(struct bpf_cpumask *mask)
 	return (const struct cpumask *)mask;
 }
 
+/*
+ * True if the non-sleepable BPF trampoline prolog (__bpf_prog_enter) calls
+ * migrate_disable() for the current task. Recorded once by
+ * scx_lib_init_probe, an fentry program on bpf_scx_reg() that fires during
+ * the natural scheduler-attach call chain (auto-attached by scx_ops_attach!).
+ *
+ * Defaults to true (conservative). Over-reporting in is_migration_disabled()
+ * causes local-only dispatch, which is safe. Under-reporting can crash the
+ * scheduler, so we err high if the probe somehow fails to run.
+ */
+bool __scx_prolog_disables_migration __weak = true;
+
+/*
+ * scx_lib_init_probe - non-sleepable prolog probe.
+ *
+ * Attached to bpf_scx_reg(), the .reg callback in bpf_sched_ext_ops
+ * (kernel/sched/ext.c). The kernel's struct_ops machinery invokes
+ * bpf_scx_reg when userspace creates the scheduler link, before
+ * ops.init() fires. Its address is taken in the vtable, so the symbol
+ * is non-inlinable and has been stable since introduction.
+ *
+ * Entering via fentry runs us through __bpf_prog_enter -- the
+ * non-sleepable prolog that consumers of is_migration_disabled() live
+ * under.
+ *
+ * Loud warning: the prolog adds at most 1 to migration_disabled.
+ * Reading > 1 means something upstream in the
+ * bpf_struct_ops_link_create -> bpf_scx_reg path disabled migration
+ * before the prolog ran, invalidating the probe; audit and adjust.
+ */
+SEC("fentry/bpf_scx_reg") __weak
+int scx_lib_init_probe(void *ctx)
+{
+	if (bpf_core_field_exists(((struct task_struct *)0)->migration_disabled)) {
+		const struct task_struct *p = bpf_get_current_task_btf();
+		unsigned int md = p->migration_disabled;
+
+		if (md > 1)
+			bpf_printk("scx_lib_init_probe: unexpected migration_disabled=%u "
+				   "upstream of BPF prolog; probe result unreliable",
+				   md);
+
+		__scx_prolog_disables_migration = md > 0;
+	}
+	return 0;
+}
+
 /*
  * Return true if task @p cannot migrate to a different CPU, false
  * otherwise.
+ *
+ * IMPORTANT: designed for NON-SLEEPABLE BPF contexts only. Sleepable
+ * contexts (BPF_STRUCT_OPS_SLEEPABLE, SEC("syscall"),
+ * SEC("fentry.s/...")) enter via __bpf_prog_enter_sleepable() or
+ * __bpf_prog_enter_sleepable_recur(), both of which unconditionally
+ * call migrate_disable(); this helper can yield a false negative for
+ * p == current there, which can crash the scheduler.
  */
 static inline bool is_migration_disabled(const struct task_struct *p)
 {
 	/*
-	 * Testing p->migration_disabled in a BPF code is tricky because the
-	 * migration is _always_ disabled while running the BPF code.
-	 * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) for BPF
-	 * code execution disable and re-enable the migration of the current
-	 * task, respectively. So, the _current_ task of the sched_ext ops is
-	 * always migration-disabled. Moreover, p->migration_disabled could be
-	 * two or greater when a sched_ext ops BPF code (e.g., ops.tick) is
-	 * executed in the middle of the other BPF code execution.
+	 * Testing p->migration_disabled in BPF is tricky because the BPF prolog
+	 * (__bpf_prog_enter) may call migrate_disable() for the current task,
+	 * making migration_disabled == 1 even for tasks that are not truly
+	 * migration-disabled.
+	 *
+	 * Since commit 8e4f0b1ebcf2 ("bpf: use rcu_read_lock_dont_migrate() for
+	 * trampoline.c"), the BPF prolog calls migrate_disable() only when
+	 * CONFIG_PREEMPT_RCU is enabled. Two fast paths cover the common cases:
+	 *
+	 *   1) CONFIG_PREEMPT_RCU: prolog always calls migrate_disable(), so
+	 *      migration_disabled == 1 for the current task is ambiguous.
+	 *      Disambiguate by checking p == current.
+	 *
+	 *   2) v6.18+ without CONFIG_PREEMPT_RCU: prolog never calls
+	 *      migrate_disable(), so migration_disabled == 1 is unambiguously
+	 *      a real migrate_disable() call.
 	 *
-	 * Therefore, we should decide that the _current_ task is
-	 * migration-disabled only when its migration_disabled count is greater
-	 * than one. In other words, when  p->migration_disabled == 1, there is
-	 * an ambiguity, so we should check if @p is the current task or not.
+	 * A slow path handles pre-v6.18 kernels without CONFIG_PREEMPT_RCU,
+	 * where the prolog historically called migrate_disable() unconditionally
+	 * but a cherry-picked downstream kernel may not. The runtime-probed flag
+	 * __scx_prolog_disables_migration (set by scx_lib_init_probe) distinguishes
+	 * the two cases without relying on the kernel version alone.
 	 */
 	if (bpf_core_field_exists(p->migration_disabled)) {
-		if (p->migration_disabled == 1)
-			return bpf_get_current_task_btf() != p;
-		else
-			return p->migration_disabled;
+		if (p->migration_disabled == 1) {
+			/* Fast path: prolog always disables migration */
+			if (CONFIG_PREEMPT_RCU)
+				return bpf_get_current_task_btf() != p;
+			/* Fast path: prolog never disables migration */
+			if (LINUX_KERNEL_VERSION >= KERNEL_VERSION(6, 18, 0))
+				return true;
+			/* Slow path: pre-v6.18, !PREEMPT_RCU - use runtime flag */
+			return __scx_prolog_disables_migration ?
+			       bpf_get_current_task_btf() != p : true;
+		}
+		return p->migration_disabled;
 	}
 	return false;
 }
@@ -1021,7 +1094,20 @@ static inline u64 scx_clock_task(u32 cpu)
 {
 	struct rq___local *rq = get_current_rq(cpu);
 
-	/* Equivalent to the kernel's rq_clock_task(). */
+	/*
+	 * Equivalent to the kernel's rq_clock_task(): wall-clock time minus
+	 * cumulative IRQ time (CONFIG_IRQ_TIME_ACCOUNTING) and hypervisor
+	 * steal time (CONFIG_PARAVIRT_TIME_ACCOUNTING). Without those configs,
+	 * it equals rq->clock.
+	 *
+	 * Conceptually this clock advances during idle (the idle task counts
+	 * as a running task), but rq->clock_task is only updated on scheduling
+	 * events. With NO_HZ_IDLE (the default), the periodic tick is stopped
+	 * on idle CPUs, so rq->clock_task is not refreshed while a CPU is
+	 * idle. Reading this clock for a remote idle CPU from a BPF timer
+	 * callback returns the value from when the CPU last went idle, making
+	 * the delta over an idle interval effectively zero.
+	 */
 	return rq ? rq->clock_task : 0;
 }
 
@@ -1032,9 +1118,23 @@ static inline u64 scx_clock_pelt(u32 cpu)
 	/*
 	 * Equivalent to the kernel's rq_clock_pelt(): subtracts
 	 * lost_idle_time from clock_pelt to absorb the jump that occurs
-	 * when clock_pelt resyncs with clock_task at idle exit. The result
-	 * is a continuous, capacity-invariant clock safe for both task
-	 * execution time stamping and cross-idle measurements.
+	 * when clock_pelt resyncs with clock_task at idle exit. The intent
+	 * is a continuous, capacity- and frequency-invariant clock that is
+	 * frozen during idle, IRQ, and hypervisor steal.
+	 *
+	 * However, like scx_clock_task(), this clock has a stale-read issue
+	 * for remote idle CPUs with NO_HZ_IDLE (the default). clock_pelt
+	 * itself advances at wall-clock rate (hardware-clock based), but
+	 * lost_idle_time is only updated via update_rq_clock_pelt(), which
+	 * requires update_rq_clock() to be called. With NO_HZ_IDLE, the
+	 * periodic tick is stopped on idle CPUs, so lost_idle_time is not
+	 * refreshed during idle. Reading this clock for a remote idle CPU
+	 * from a BPF timer callback therefore returns a value that drifts
+	 * at wall-clock rate -- the same stale behaviour as scx_clock_task().
+	 *
+	 * Without NO_HZ_IDLE, periodic ticks keep lost_idle_time nearly in
+	 * sync (stale by at most one tick period, ~1 ms), so the result is
+	 * accurate.
 	 */
 	return rq ? (rq->clock_pelt - rq->lost_idle_time) : 0;
 }
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 3ab642f92c8a..6944221f96cc 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -92,15 +92,20 @@ int bpf_cpumask_populate(struct bpf_cpumask *dst, void *src, size_t src__sz) __k
 
 /*
  * v6.19: Introduce lockless peek API for user DSQs.
+ * v7.1:  Fix scx_bpf_dsq_peek() spuriously returning NULL on non-empty
+ *        FIFO DSQs (2f2ea7709266).
  *
- * Preserve the following macro until v6.21.
+ * The kfunc exists from v6.19 but can return NULL for a non-empty FIFO DSQ
+ * before the v7.1 fix. Require kernel version >= 7.1.0 before calling it;
+ * otherwise fall through to the bpf_iter_scx_dsq fallback below.
  */
 static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
 {
 	struct task_struct *p = NULL;
 	struct bpf_iter_scx_dsq it;
 
-	if (bpf_ksym_exists(scx_bpf_dsq_peek))
+	if (bpf_ksym_exists(scx_bpf_dsq_peek) &&
+	    LINUX_KERNEL_VERSION >= KERNEL_VERSION(7, 1, 0))
 		return scx_bpf_dsq_peek(dsq_id);
 	if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
 		p = bpf_iter_scx_dsq_next(&it);
@@ -238,6 +243,26 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
 	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
 
+/*
+ * v6.18: Add a helper to retrieve the current task running on a CPU.
+ *
+ * The kernel tree dropped this helper and scx_bpf_cpu_rq(), but schedulers in
+ * this tree still support pre-v6.18 kernels where scx_bpf_cpu_curr() doesn't
+ * resolve and the scx_bpf_cpu_rq() fallback still exists. Keep it until
+ * pre-v6.18 kernels fall out of the support window.
+ */
+static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
+{
+	struct rq *rq;
+
+	if (bpf_ksym_exists(scx_bpf_cpu_curr))
+		return scx_bpf_cpu_curr(cpu);
+
+	rq = scx_bpf_cpu_rq(cpu);
+
+	return rq ? rq->curr : NULL;
+}
+
 /*
  * v6.19: To work around BPF maximum parameter limit, the following kfuncs are
  * replaced with variants that pack scalar arguments in a struct. Wrappers are
@@ -378,6 +403,17 @@ static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
 		p->scx.dsq_vtime = vtime;
 }
 
+/*
+ * v7.1: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. This
+ * will eventually deprecate scx_bpf_reenqueue_local().
+ */
+void scx_bpf_dsq_reenq___compat(u64 dsq_id, u64 reenq_flags) __ksym __weak;
+
+static inline bool __COMPAT_has_generic_reenq(void)
+{
+	return bpf_ksym_exists(scx_bpf_dsq_reenq___compat);
+}
+
 /*
  * v6.19: The new void variant can be called from anywhere while the older v1
  * variant can only be called from ops.cpu_release(). The double ___ prefixes on
@@ -395,21 +431,31 @@ static inline bool __COMPAT_scx_bpf_reenqueue_local_from_anywhere(void)
 
 static inline void scx_bpf_reenqueue_local(void)
 {
-	if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
+	if (__COMPAT_has_generic_reenq())
+		scx_bpf_dsq_reenq___compat(SCX_DSQ_LOCAL, 0);
+	else if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
 		scx_bpf_reenqueue_local___v2___compat();
 	else
 		scx_bpf_reenqueue_local___v1();
 }
 
-/*
- * v7.1: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. This
- * will eventually deprecate scx_bpf_reenqueue_local().
- */
-void scx_bpf_dsq_reenq___compat(u64 dsq_id, u64 reenq_flags) __ksym __weak;
-
-static inline bool __COMPAT_has_generic_reenq(void)
+static inline int scx_bpf_reenqueue_local_from_anywhere(void)
 {
-	return bpf_ksym_exists(scx_bpf_dsq_reenq___compat);
+	/*
+	 * The generic reenq kfunc and the v2 reenqueue-local variant can both be
+	 * called from anywhere; v1 cannot. Test each ksym in its own branch with a
+	 * distinct call: combining them with || would fold into a bitwise OR of the
+	 * two ksym addresses, which the verifier rejects.
+	 */
+	if (__COMPAT_has_generic_reenq()) {
+		scx_bpf_dsq_reenq___compat(SCX_DSQ_LOCAL, 0);
+		return 0;
+	}
+	if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere()) {
+		scx_bpf_reenqueue_local___v2___compat();
+		return 0;
+	}
+	return -EOPNOTSUPP;
 }
 
 static inline void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags)
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index d2e4384df5af..7c12df45fdba 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -10,9 +10,14 @@
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 
+#include "enums_abi.autogen.h"
+
 struct btf *__COMPAT_vmlinux_btf __attribute__((weak));
 
 static inline void __COMPAT_load_vmlinux_btf(void)
@@ -23,6 +28,85 @@ static inline void __COMPAT_load_vmlinux_btf(void)
 	}
 }
 
+/*
+ * Recover the true value of a 64-bit enum enumerator whose kernel BTF entry
+ * was truncated to its low 32 bits.
+ *
+ * Kernels whose BTF was generated without BTF_KIND_ENUM64 support encode
+ * 64-bit enums as 8-byte BTF_KIND_ENUM entries whose enumerator values only
+ * carry the low 32 bits. This happens with pahole < 1.24, which predates
+ * ENUM64, and with pahole passing --skip_encoding_btf_enum64 (e.g. Google's
+ * Container-Optimized OS / GKE kernels deliberately pass it for backward
+ * compatibility with older BTF consumers). The high bits
+ * can't be recovered from kernel BTF, so substitute the value from the
+ * vmlinux.h this tree was built against, cross-checked against the low 32
+ * bits the kernel did provide.
+ *
+ * Note that this is a best-effort recovery, not a ground truth. The
+ * substitution assumes the running kernel agrees with this tree's vmlinux.h
+ * on the high 32 bits, but only the low 32 bits can actually be verified.
+ * The cross-check is vacuous for enumerators whose value has no low bits
+ * set (e.g. SCX_DSQ_FLAG_BUILTIN, __SCX_ENQ_INTERNAL_MASK,
+ * SCX_ENQ_CLEAR_OPSS, SCX_ECODE_*): their lo32 is 0 and matches anything,
+ * so those substitutions rest entirely on the high bits never moving. An
+ * enumerator missing from the table (a kernel newer than this tree's
+ * vmlinux.h, or a stale autogen table) can't be recovered at all. If a
+ * substitution is ever wrong, the scheduler operates on bogus values (e.g.
+ * dispatching to nonexistent DSQ ids or silently dropping flags) and can
+ * wildly malfunction, which is why the mismatch and table-miss paths refuse
+ * instead of guessing.
+ */
+static inline bool __COMPAT_recover_truncated_enum64(const char *type,
+						     const char *name,
+						     u32 lo32, u64 *v)
+{
+	static bool warned;
+	size_t i;
+
+	for (i = 0; i < sizeof(__scx_enum_abi_vals) / sizeof(__scx_enum_abi_vals[0]); i++) {
+		const struct __scx_enum_abi_val *e = &__scx_enum_abi_vals[i];
+
+		if (strcmp(e->type, type) || strcmp(e->name, name))
+			continue;
+
+		if (e->val <= (u64)UINT32_MAX) {
+			*v = lo32;
+			return true;
+		}
+
+		if ((u32)e->val != lo32) {
+			fprintf(stderr, "ERROR: kernel BTF value of %s::%s (0x%x) doesn't match the low 32 bits of the vmlinux.h value (0x%llx); refusing to substitute\n",
+				type, name, lo32, (unsigned long long)e->val);
+			return false;
+		}
+
+		if (!warned) {
+			fprintf(stderr,
+				"WARNING: kernel BTF lacks BTF_KIND_ENUM64 encoding (generated by\n"
+				"WARNING: pahole < 1.24 or with --skip_encoding_btf_enum64), so 64-bit\n"
+				"WARNING: scx enum values are truncated to their low 32 bits in kernel\n"
+				"WARNING: BTF. Substituting the full 64-bit values from the vmlinux.h\n"
+				"WARNING: this binary was built against, cross-checked against the low\n"
+				"WARNING: 32 bits the kernel does provide. The high 32 bits cannot be\n"
+				"WARNING: verified: if the running kernel's actual values differ from\n"
+				"WARNING: the build-time vmlinux.h (e.g. an enum that moved in a newer\n"
+				"WARNING: kernel), the scheduler will operate on bogus values, such as\n"
+				"WARNING: dispatching to nonexistent DSQ ids, and can wildly malfunction.\n");
+			warned = true;
+		}
+		*v = e->val;
+		return true;
+	}
+
+	/*
+	 * Unknown enumerator (likely a stale autogen table). Fail
+	 * pessimistically to avoid returning an invalid value.
+	 */
+	fprintf(stderr, "ERROR: kernel BTF truncates 64-bit enum %s::%s to 0x%x; 64-bit variant not found in vmlinux.h\n",
+		type, name, lo32);
+	return false;
+}
+
 static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v)
 {
 	const struct btf_type *t;
@@ -46,6 +130,19 @@ static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v
 			n = btf__name_by_offset(__COMPAT_vmlinux_btf, e[i].name_off);
 			SCX_BUG_ON(!n, "btf__name_by_offset()");
 			if (!strcmp(n, name)) {
+				/*
+				 * Try to recover a 64-bit enum from an 8-byte
+				 * BTF_KIND_ENUM that was encoded without ENUM64
+				 * support (old pahole or
+				 * --skip_encoding_btf_enum64). Only scx_*
+				 * types are covered by the substitution table;
+				 * non-scx types fall through to the raw value
+				 * so this generic utility keeps working for
+				 * them.
+				 */
+				if (t->size == 8 && !strncmp(type, "scx_", 4))
+					return __COMPAT_recover_truncated_enum64(type, name,
+										 (u32)e[i].val, v);
 				*v = e[i].val;
 				return true;
 			}
-- 
2.55.0

