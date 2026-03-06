Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AF42DFEE;
	Fri,  6 Mar 2026 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823993; cv=none; b=cgAvuu32mQnxX9Pnw85x6xLuxnLcbhW/nDX50u8461uTYjKV8o1sGkXnjm9lmf3vuANpgSF61lPT/iT0l7r2yQWwyGVRXhDmpaL5e+rLqI4D1mfL/E3950ADHwAp7aOJru8GPI/cXAfo8gPfGv1MPgKKyndGr7hlcEMP5RiJd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823993; c=relaxed/simple;
	bh=6dLmEAOCZIw+EDSKwn1XPf9dWJ06MEJxsMJPn6E3Rb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsajS3IITaxrO0YJ3nfrDTSKU3J2yPbcOa5cLSHhlAKnmga0D1VbU87E3JzaE6yc0Lh2kWXubNjwX93Wp4CouPUYv9cP7GeYriir1notzWmD2b7r0uDnphcJtkuur08x29WWjfQvUFzeb9VHvITdPsilULpOqDv/OaY9EE5E8WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltHzlkwJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltHzlkwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE1EC4CEF7;
	Fri,  6 Mar 2026 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823992;
	bh=6dLmEAOCZIw+EDSKwn1XPf9dWJ06MEJxsMJPn6E3Rb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltHzlkwJyDScEy7pnY6MeZUBwJe1V0z5T5SZgQvcnMowT+U8dTVKkRgLOoJrkYpk6
	 nwxAyminnFkqMmHoDTpIx159NgVfOjdB8fsABb/rb/MKL9+qKvn4MbO+KZVCW5EcFU
	 NQ6BbkbKAU9pL2wgxpTfC3cb7O/OTwdOKO9Z1l+30Hb/NxH0qaLDB081faR+30RiVv
	 nEigEtOgfvcBp23/xXX4LOdlljysrf6ASPxuYlTJkoMVhtBjLVYw/hc5dwX5AjAEEv
	 j5b3lpCHaMcJr8Q2nEzzgmcSvGQZAfeygdYfBMbsi/qAOW/9wMtZ4x1NSj/vRPyXDP
	 7cklNlyBUZPVA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/15] sched_ext: Introduce scx_bpf_dsq_reenq() for remote local DSQ reenqueue
Date: Fri,  6 Mar 2026 09:06:16 -1000
Message-ID: <20260306190623.1076074-9-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_reenqueue_local() can only trigger re-enqueue of the current CPU's
local DSQ. Introduce scx_bpf_dsq_reenq() which takes a DSQ ID and can target
any local DSQ including remote CPUs via SCX_DSQ_LOCAL_ON | cpu. This will be
expanded to support user DSQs by future changes.

scx_bpf_reenqueue_local() is reimplemented as a simple wrapper around
scx_bpf_dsq_reenq(SCX_DSQ_LOCAL, 0) and may be deprecated in the future.

Update compat.bpf.h with a compatibility shim and scx_qmap to test the new
functionality.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                       | 118 ++++++++++++++---------
 tools/sched_ext/include/scx/compat.bpf.h |  21 ++++
 tools/sched_ext/scx_qmap.bpf.c           |  11 ++-
 tools/sched_ext/scx_qmap.c               |   5 +-
 4 files changed, 106 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 80d1e6ccc326..b02143b10f0f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1080,6 +1080,31 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq)
+{
+	/*
+	 * Allowing reenqueues doesn't make sense while bypassing. This also
+	 * blocks from new reenqueues to be scheduled on dead scheds.
+	 */
+	if (unlikely(READ_ONCE(sch->bypass_depth)))
+		return;
+
+	if (dsq->id == SCX_DSQ_LOCAL) {
+		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
+		struct scx_sched_pcpu *sch_pcpu = per_cpu_ptr(sch->pcpu, cpu_of(rq));
+		struct scx_deferred_reenq_local *drl = &sch_pcpu->deferred_reenq_local;
+
+		scoped_guard (raw_spinlock_irqsave, &rq->scx.deferred_reenq_lock) {
+			if (list_empty(&drl->node))
+				list_move_tail(&drl->node, &rq->scx.deferred_reenq_locals);
+		}
+
+		schedule_deferred(rq);
+	} else {
+		scx_error(sch, "DSQ 0x%llx not allowed for reenq", dsq->id);
+	}
+}
+
 /**
  * touch_core_sched - Update timestamp used for core-sched task ordering
  * @rq: rq to read clock from, must be locked
@@ -7775,9 +7800,6 @@ __bpf_kfunc_start_defs();
  * Iterate over all of the tasks currently enqueued on the local DSQ of the
  * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the number of
  * processed tasks. Can only be called from ops.cpu_release().
- *
- * COMPAT: Will be removed in v6.23 along with the ___v2 suffix on the void
- * returning variant that can be called from anywhere.
  */
 __bpf_kfunc u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux)
 {
@@ -8207,6 +8229,52 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id,
 	return rcu_dereference(dsq->first_task);
 }
 
+/**
+ * scx_bpf_dsq_reenq - Re-enqueue tasks on a DSQ
+ * @dsq_id: DSQ to re-enqueue
+ * @reenq_flags: %SCX_RENQ_*
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Iterate over all of the tasks currently enqueued on the DSQ identified by
+ * @dsq_id, and re-enqueue them in the BPF scheduler. The following DSQs are
+ * supported:
+ *
+ * - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON | $cpu)
+ *
+ * Re-enqueues are performed asynchronously. Can be called from anywhere.
+ */
+__bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
+				   const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+	struct scx_dispatch_q *dsq;
+
+	guard(preempt)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return;
+
+	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, smp_processor_id());
+	schedule_dsq_reenq(sch, dsq);
+}
+
+/**
+ * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Iterate over all of the tasks currently enqueued on the local DSQ of the
+ * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called from
+ * anywhere.
+ *
+ * This is now a special case of scx_bpf_dsq_reenq() and may be removed in the
+ * future.
+ */
+__bpf_kfunc void scx_bpf_reenqueue_local___v2(const struct bpf_prog_aux *aux)
+{
+	scx_bpf_dsq_reenq(SCX_DSQ_LOCAL, 0, aux);
+}
+
 __bpf_kfunc_end_defs();
 
 static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
@@ -8364,47 +8432,6 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 		ops_dump_flush();
 }
 
-/**
- * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
- * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
- *
- * Iterate over all of the tasks currently enqueued on the local DSQ of the
- * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called from
- * anywhere.
- */
-__bpf_kfunc void scx_bpf_reenqueue_local___v2(const struct bpf_prog_aux *aux)
-{
-	unsigned long flags;
-	struct scx_sched *sch;
-	struct rq *rq;
-
-	raw_local_irq_save(flags);
-
-	sch = scx_prog_sched(aux);
-	if (unlikely(!sch))
-		goto out_irq_restore;
-
-	/*
-	 * Allowing reenqueue-locals doesn't make sense while bypassing. This
-	 * also blocks from new reenqueues to be scheduled on dead scheds.
-	 */
-	if (unlikely(sch->bypass_depth))
-		goto out_irq_restore;
-
-	rq = this_rq();
-	scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
-		struct scx_sched_pcpu *pcpu = this_cpu_ptr(sch->pcpu);
-
-		if (list_empty(&pcpu->deferred_reenq_local.node))
-			list_move_tail(&pcpu->deferred_reenq_local.node,
-				       &rq->scx.deferred_reenq_locals);
-	}
-
-	schedule_deferred(rq);
-out_irq_restore:
-	raw_local_irq_restore(flags);
-}
-
 /**
  * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
  * @cpu: CPU of interest
@@ -8821,13 +8848,14 @@ BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
 BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_IMPLICIT_ARGS | KF_RCU_PROTECTED | KF_RET_NULL)
+BTF_ID_FLAGS(func, scx_bpf_dsq_reenq, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_IMPLICIT_ARGS | KF_ITER_NEW | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_set, KF_IMPLICIT_ARGS)
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index f2969c3061a7..2d3985be7e2c 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -375,6 +375,27 @@ static inline void scx_bpf_reenqueue_local(void)
 		scx_bpf_reenqueue_local___v1();
 }
 
+/*
+ * v6.20: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. This
+ * will eventually deprecate scx_bpf_reenqueue_local().
+ */
+void scx_bpf_dsq_reenq___compat(u64 dsq_id, u64 reenq_flags, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+
+static inline bool __COMPAT_has_generic_reenq(void)
+{
+	return bpf_ksym_exists(scx_bpf_dsq_reenq___compat);
+}
+
+static inline void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags)
+{
+	if (bpf_ksym_exists(scx_bpf_dsq_reenq___compat))
+		scx_bpf_dsq_reenq___compat(dsq_id, reenq_flags, NULL);
+	else if (dsq_id == SCX_DSQ_LOCAL && reenq_flags == 0)
+		scx_bpf_reenqueue_local();
+	else
+		scx_bpf_error("kernel too old to reenqueue foreign local or user DSQs");
+}
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 91b8eac83f52..83e8289e8c0c 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -131,7 +131,7 @@ struct {
 } cpu_ctx_stor SEC(".maps");
 
 /* Statistics */
-u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued, nr_ddsp_from_enq;
+u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cpu0, nr_dequeued, nr_ddsp_from_enq;
 u64 nr_core_sched_execed;
 u64 nr_expedited_local, nr_expedited_remote, nr_expedited_lost, nr_expedited_from_timer;
 u32 cpuperf_min, cpuperf_avg, cpuperf_max;
@@ -206,8 +206,11 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	void *ring;
 	s32 cpu;
 
-	if (enq_flags & SCX_ENQ_REENQ)
+	if (enq_flags & SCX_ENQ_REENQ) {
 		__sync_fetch_and_add(&nr_reenqueued, 1);
+		if (scx_bpf_task_cpu(p) == 0)
+			__sync_fetch_and_add(&nr_reenqueued_cpu0, 1);
+	}
 
 	if (p->flags & PF_KTHREAD) {
 		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
@@ -561,6 +564,10 @@ int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
 	case 2: /* SCHED_RR */
 	case 6: /* SCHED_DEADLINE */
 		scx_bpf_reenqueue_local();
+
+		/* trigger re-enqueue on CPU0 just to exercise LOCAL_ON */
+		if (__COMPAT_has_generic_reenq())
+			scx_bpf_dsq_reenq(SCX_DSQ_LOCAL_ON | 0, 0);
 	}
 
 	return 0;
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 5d762d10f4db..9252037284d3 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -137,9 +137,10 @@ int main(int argc, char **argv)
 		long nr_enqueued = skel->bss->nr_enqueued;
 		long nr_dispatched = skel->bss->nr_dispatched;
 
-		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq=%"PRIu64" deq=%"PRIu64" core=%"PRIu64" enq_ddsp=%"PRIu64"\n",
+		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq/cpu0=%"PRIu64"/%"PRIu64" deq=%"PRIu64" core=%"PRIu64" enq_ddsp=%"PRIu64"\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
-		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
+		       skel->bss->nr_reenqueued, skel->bss->nr_reenqueued_cpu0,
+		       skel->bss->nr_dequeued,
 		       skel->bss->nr_core_sched_execed,
 		       skel->bss->nr_ddsp_from_enq);
 		printf("         exp_local=%"PRIu64" exp_remote=%"PRIu64" exp_timer=%"PRIu64" exp_lost=%"PRIu64"\n",
-- 
2.53.0

