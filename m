Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D1345CA3;
	Wed, 29 Oct 2025 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752947; cv=none; b=rSM0WJvR83S3cgyEcsQe+du0tcpqtBTO9SnWWqyMvfXNqybZH4iI+YgO+4UzXwiMxU/9kNv6k24BSc4Qs0ooqJPoyyHj03wBEcLvNTKfftW8/fgLHLj2w+8dEvbhvtiRxw0KePD/0sqSq+PebF+MJ7lViPWAO+HI8IZ+ecobYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752947; c=relaxed/simple;
	bh=ftulnBq5KqEbe4YEfaqagXhnIGh6yPNmwHKJydanaoE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=CMK9T49U4ULKpw5B+CAlPXudErqTUBqh0OqP3xPjAScBWOTVEYDwz449A4PrcyY7wjSVLSNUbpQZixxbXZ5F+C+PWYFAgfYHJPJSo3GbTL3yBglVpxVqXDC+pFp4V7FX6+toJgKexDwa7OQAOTjOXAH/R33K88XneLyYhR2QAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ+xK1At; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ+xK1At"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B4AC4CEF7;
	Wed, 29 Oct 2025 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761752946;
	bh=ftulnBq5KqEbe4YEfaqagXhnIGh6yPNmwHKJydanaoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BQ+xK1At70A0przTXqgZEIpHZ/XKCyq9Kdg7nm3San7KNYHoQPBOA1VbEVKML7odv
	 20q79C5mJ/Pamho5U7/231cBzpF9X76+mRgWJCt6paWdcG8hIAk4h19sj2OsdWpSaG
	 j5RD8jQa7kYi4dM39mh0+WMZDCnviSDCT9WsABrx2fzjMdUKLs9jIXLKB0WowfJtrN
	 KnhVSBB8QtIbjWix7SisQQI5OJsJvoSa6ZhIa1u2X2f55TH6Y3kP9gNRQjZsud/ve8
	 q16pa7KWB/Hd1sVz5qIaUa2WTe74lqFQcRfaxbMHklbHoWnJPLKlN8/MX2kYtj/xg7
	 T2ZBwwN/hLpdg==
Date: Wed, 29 Oct 2025 05:49:05 -1000
Message-ID: <7e9b27d70e31c243da3ce77e622b0af5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, Wen-Fang Liu <liuwenfang@honor.com>
Subject: [PATCH v3 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be called from anywhere
In-Reply-To: <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
References: <20251025001849.1915635-1-tj@kernel.org> <aP-3vOtH9Dyg_R9w@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The ops.cpu_acquire/release() callbacks miss events under multiple conditions.
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

v3: Dropped "can't be fixed without adding global sched core hooks that sched
    maintainers don't want" from description per Peter's feedback.

 kernel/sched/ext.c                       | 31 +++++++++++++++++++
 kernel/sched/sched.h                     |  1 +
 tools/sched_ext/include/scx/common.bpf.h |  1 -
 tools/sched_ext/include/scx/compat.bpf.h | 23 ++++++++++++++
 tools/sched_ext/scx_qmap.bpf.c           | 38 +++++++++++++++++-------
 5 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d13ce92c3f01..d1ef5bda95ae 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -147,6 +147,7 @@ static struct kset *scx_kset;
 #include <trace/events/sched_ext.h>
 
 static void process_ddsp_deferred_locals(struct rq *rq);
+static u32 reenq_local(struct rq *rq);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
 		      s64 exit_code, const char *fmt, va_list args);
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -147,6 +147,7 @@ static struct kset *scx_kset;
 #include <trace/events/sched_ext.h>
 
 static void process_ddsp_deferred_locals(struct rq *rq);
+static u32 reenq_local(struct rq *rq);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
 		      s64 exit_code, const char *fmt, va_list args);
@@ -755,6 +756,11 @@ static int ops_sanitize_err(struct scx_sched *sch, const char *ops_name, s32 err
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
@@ -4569,6 +4575,9 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 	if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
 		pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a noop\n");
 
+	if (ops->cpu_acquire || ops->cpu_release)
+		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
+
 	return 0;
 }
 
@@ -5929,6 +5938,9 @@ __bpf_kfunc_start_defs();
  * Iterate over all of the tasks currently enqueued on the local DSQ of the
  * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the number of
  * processed tasks. Can only be called from ops.cpu_release().
+ *
+ * COMPAT: Will be removed in v6.23 along with the ___v2 suffix on the void
+ * returning variant that can be called from anywhere.
  */
 __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 {
@@ -6487,6 +6499,24 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 		ops_dump_flush();
 }
 
+/**
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
 /**
  * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
  * @cpu: CPU of interest
@@ -6900,6 +6930,7 @@ BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 909e94794f8a..27aae2a298f8 100644
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
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index e65b1eb668ea..82a798c3fb22 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -70,7 +70,6 @@ void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __
 void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
 bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
-u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 26bead92fa04..0bfb8abe2a46 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -278,6 +278,29 @@ static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
 		p->scx.dsq_vtime = vtime;
 }
 
+/*
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
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index c67dac78a4c6..df21fad0c438 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -202,6 +202,9 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	void *ring;
 	s32 cpu;
 
+	if (enq_flags & SCX_ENQ_REENQ)
+		__sync_fetch_and_add(&nr_reenqueued, 1);
+
 	if (p->flags & PF_KTHREAD) {
 		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
 			return;
@@ -529,20 +532,35 @@ bool BPF_STRUCT_OPS(qmap_core_sched_before,
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
-- 
2.51.1

