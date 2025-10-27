Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146019D07A;
	Mon, 27 Oct 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589181; cv=none; b=LztxSe74ynqQb1Ap3kSGDAokUsRXvTW//YLDqt7V3lY9l5rvjBb7kRi4Q1OYdShYLemz1QE/5lCKA0xOsruNrId/xF6BoHnxTL+1mSuuKN5ohw8iWvT2sHW79UzziRlKX5rb2NnHvfwnCQf0oOfmOP96euDNccs4bciRzsdEPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589181; c=relaxed/simple;
	bh=WtcGsr4Tkg/Y0AE9jD2dyBiYgZpQwtXm6AFSbVyoemc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6MDrR6pHGblva0MNaJBgprp4jOOTWKMm2ijAbIsdq+kPP4yG8tCXcyhyKydlfKZS27q0eIt2XlTTDGeZlg+ibXS1iu0ptIXcl70ZleHuPP1Ar2x9YCyK+hHahDq1PExmah1/zLIFZ8D5b9cr4XCp7Zsi7JnZww2JSxsgk1wnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs1KBh3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs1KBh3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FF6C4CEF1;
	Mon, 27 Oct 2025 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761589181;
	bh=WtcGsr4Tkg/Y0AE9jD2dyBiYgZpQwtXm6AFSbVyoemc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rs1KBh3rsUTUXMEwX/pvA/Mie0rvd5eT19MSB/qAPNw1Hfq1TDzeJiNe9W0KBgLYF
	 M7fry1qriAhHmc5bPBM98Skrc+YTnTgRxICmKQ2KEf8eoqhZshhK0xxPaRQcJKDxQs
	 qGSQrftidNAng1I+cGr1/R6KN8N+L8vzYnb88tt6pQjNjNQF3OYqFbUnWcz2CKrKYD
	 VN1K2zs3qAll+11LLV2hZKiKiSaUwQcNaBqN9i3AmcIgvD6xspvSAL9431rFs1/88M
	 WdiYWr9gS/rpeyaapMqB97ya+RSA24ouYm6gbzcoU8z5qdb68metay+nCJXfplrWH2
	 I+5rJRrV+/XZw==
Date: Mon, 27 Oct 2025 08:19:40 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: [PATCH v2 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
References: <20251025001849.1915635-1-tj@kernel.org>
 <20251025001849.1915635-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025001849.1915635-4-tj@kernel.org>

The ops.cpu_acquire/release() callbacks are broken - they miss events under
multiple conditions and can't be fixed without adding global sched core hooks
that sched maintainers don't want.

There are two distinct task dispatch gaps that can cause cpu_released flag
desynchronization:

1. balance-to-pick_task gap: This is what was originally reported. balance_scx()
   can enqueue a task, but during consume_remote_task() when the rq lock is
   released, a higher priority task can be enqueued and ultimately picked while
   cpu_released remains false. This gap is closeable via RETRY_TASK handling.

2. ttwu-to-pick_task gap: ttwu() can directly dispatch a task to a CPU's local
   DSQ. By the time the sched path runs on the target CPU, higher class tasks may
   already be queued. In such cases, nothing on sched_ext side will be invoked,
   and the only solution would be a hook invoked regardless of sched class, which
   isn't desirable.

Rather than adding invasive core hooks, BPF schedulers can use generic BPF
mechanisms like tracepoints. From SCX scheduler's perspective, this is congruent
with other mechanisms it already uses and doesn't add further friction.

The main use case for cpu_release() was calling scx_bpf_reenqueue_local() when
a CPU gets preempted by a higher priority scheduling class. However, the old
scx_bpf_reenqueue_local() could only be called from cpu_release() context.

Add a new version of scx_bpf_reenqueue_local() that can be called from any
context by deferring the actual re-enqueue operation. This eliminates the need
for cpu_acquire/release() ops entirely. Schedulers can now use standard BPF
mechanisms like the sched_switch tracepoint to detect and handle CPU preemption.

Update scx_qmap to demonstrate the new approach using sched_switch instead of
cpu_release, with compat support for older kernels. Mark cpu_acquire/release()
as deprecated. The old scx_bpf_reenqueue_local() variant will be removed in
v6.23.

Reported-by: Wen-Fang Liu <liuwenfang@honor.com>
Link: https://lore.kernel.org/all/8d64c74118c6440f81bcf5a4ac6b9f00@honor.com/
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
v2: Description updated w/ justifications on taking this approach instead of
    fixing ops.cpu_acquire/release().

 kernel/sched/ext.c                       |   31 +++++++++++++++++++++++++
 kernel/sched/sched.h                     |    1
 tools/sched_ext/include/scx/common.bpf.h |    1
 kernel/sched/ext.c                       |   31 +++++++++++++++++++++++++
 kernel/sched/sched.h                     |    1 
 tools/sched_ext/include/scx/common.bpf.h |    1 
 tools/sched_ext/include/scx/compat.bpf.h |   23 ++++++++++++++++++
 tools/sched_ext/scx_qmap.bpf.c           |   38 ++++++++++++++++++++++---------
 5 files changed, 83 insertions(+), 11 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -147,6 +147,7 @@ static struct kset *scx_kset;
 #include <trace/events/sched_ext.h>
 
 static void process_ddsp_deferred_locals(struct rq *rq);
+static u32 reenq_local(struct rq *rq);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
 		      s64 exit_code, const char *fmt, va_list args);
@@ -755,6 +756,11 @@ static int ops_sanitize_err(struct scx_s
 static void run_deferred(struct rq *rq)
 {
 	process_ddsp_deferred_locals(rq);
+
+	if (local_read(&rq->scx.reenq_local_deferred)) {
+		local_set(&rq->scx.reenq_local_deferred, 0);
+		reenq_local(rq);
+	}
 }
 
 static void deferred_bal_cb_workfn(struct rq *rq)
@@ -4569,6 +4575,9 @@ static int validate_ops(struct scx_sched
 	if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
 		pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a noop\n");
 
+	if (ops->cpu_acquire || ops->cpu_release)
+		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
+
 	return 0;
 }
 
@@ -5931,6 +5940,9 @@ __bpf_kfunc_start_defs();
  * Iterate over all of the tasks currently enqueued on the local DSQ of the
  * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the number of
  * processed tasks. Can only be called from ops.cpu_release().
+ *
+ * COMPAT: Will be removed in v6.23 along with the ___v2 suffix on the void
+ * returning variant that can be called from anywhere.
  */
 __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 {
@@ -6490,6 +6502,24 @@ __bpf_kfunc void scx_bpf_dump_bstr(char
 }
 
 /**
+ * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
+ *
+ * Iterate over all of the tasks currently enqueued on the local DSQ of the
+ * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called from
+ * anywhere.
+ */
+__bpf_kfunc void scx_bpf_reenqueue_local___v2(void)
+{
+	struct rq *rq;
+
+	guard(preempt)();
+
+	rq = this_rq();
+	local_set(&rq->scx.reenq_local_deferred, 1);
+	schedule_deferred(rq);
+}
+
+/**
  * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
  * @cpu: CPU of interest
  *
@@ -6902,6 +6932,7 @@ BTF_ID_FLAGS(func, bpf_iter_scx_dsq_dest
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -804,6 +804,7 @@ struct scx_rq {
 	cpumask_var_t		cpus_to_preempt;
 	cpumask_var_t		cpus_to_wait;
 	unsigned long		kick_sync;
+	local_t			reenq_local_deferred;
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -70,7 +70,6 @@ void scx_bpf_dsq_move_set_slice(struct b
 void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
 bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
-u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -279,6 +279,29 @@ static inline void scx_bpf_task_set_dsq_
 }
 
 /*
+ * v6.19: The new void variant can be called from anywhere while the older v1
+ * variant can only be called from ops.cpu_release(). The double ___ prefixes on
+ * the v2 variant need to be removed once libbpf is updated to ignore ___ prefix
+ * on kernel side. Drop the wrapper and move the decl to common.bpf.h after
+ * v6.22.
+ */
+u32 scx_bpf_reenqueue_local___v1(void) __ksym __weak;
+void scx_bpf_reenqueue_local___v2___compat(void) __ksym __weak;
+
+static inline bool __COMPAT_scx_bpf_reenqueue_local_from_anywhere(void)
+{
+	return bpf_ksym_exists(scx_bpf_reenqueue_local___v2___compat);
+}
+
+static inline void scx_bpf_reenqueue_local(void)
+{
+	if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
+		scx_bpf_reenqueue_local___v2___compat();
+	else
+		scx_bpf_reenqueue_local___v1();
+}
+
+/*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
  */
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -202,6 +202,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct
 	void *ring;
 	s32 cpu;
 
+	if (enq_flags & SCX_ENQ_REENQ)
+		__sync_fetch_and_add(&nr_reenqueued, 1);
+
 	if (p->flags & PF_KTHREAD) {
 		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
 			return;
@@ -529,20 +532,35 @@ bool BPF_STRUCT_OPS(qmap_core_sched_befo
 	return task_qdist(a) > task_qdist(b);
 }
 
-void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
+SEC("tp_btf/sched_switch")
+int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
+	     struct task_struct *next, unsigned long prev_state)
 {
-	u32 cnt;
+	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
+		return 0;
 
 	/*
-	 * Called when @cpu is taken by a higher priority scheduling class. This
-	 * makes @cpu no longer available for executing sched_ext tasks. As we
-	 * don't want the tasks in @cpu's local dsq to sit there until @cpu
-	 * becomes available again, re-enqueue them into the global dsq. See
-	 * %SCX_ENQ_REENQ handling in qmap_enqueue().
+	 * If @cpu is taken by a higher priority scheduling class, it is no
+	 * longer available for executing sched_ext tasks. As we don't want the
+	 * tasks in @cpu's local dsq to sit there until @cpu becomes available
+	 * again, re-enqueue them into the global dsq. See %SCX_ENQ_REENQ
+	 * handling in qmap_enqueue().
 	 */
-	cnt = scx_bpf_reenqueue_local();
-	if (cnt)
-		__sync_fetch_and_add(&nr_reenqueued, cnt);
+	switch (next->policy) {
+	case 1: /* SCHED_FIFO */
+	case 2: /* SCHED_RR */
+	case 6: /* SCHED_DEADLINE */
+		scx_bpf_reenqueue_local();
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
+{
+	/* see qmap_sched_switch() to learn how to do this on newer kernels */
+	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
+		scx_bpf_reenqueue_local();
 }
 
 s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
