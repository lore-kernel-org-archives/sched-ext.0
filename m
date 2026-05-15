Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C331E845
	for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866102; cv=none; b=VFEPJgM1VjjyKG2nVTcDVzftn8BR2/6uYt7ob4wB1t6PzjjFrz1DopOxClWvvbVqgWSlOm8L1IFToKV5AX9vClaZRRK8xUMCxEHXX1z+D9N6eSRxt70DtG1Kc2iPEFaIL3mpH+9xOdQfuA5+3UAblmApM8coKuEdcKsJ0NPAM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866102; c=relaxed/simple;
	bh=3nb/RaGG6AfA2A17QpuVKi8U/dQmAXOMEip790mDNY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDQjemAqxaUX/RJwHKZU353tKG+6eAVbXPGHYLN6oQ6rkpRJkB7Xs0UU4zgYLYCJ8Jj+L6p7bHWW6tDPtCUCR+0nJwayM/u30Dlkxb8PyUjQKgMsj4Uxge8U1470gFFSRxw9rB1jUHnUr/uxCaUVVyCRP6coHm2PYHnC2GzqMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it3fCd2y; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it3fCd2y"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83ef1d17904so96616b3a.1
        for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 10:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866100; x=1779470900; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt+jsJsl27xuor3zWS8wmUXhY/BuPsAZ0VijKK5gtaU=;
        b=it3fCd2yOFClL1aQ8PYTlDw2e92NRT0Dam209xYoozr9zBwuypN5Ot2L0IziiWnQ10
         PeJdKhWwBa1d2WRzDeDR5w96h+/C/pZ2+pI2vUv/B5rti7IqZtUhtkWxvZ103cUsN+pC
         SvRp5An9PWxvUXhkVDnZyoOlpn97ASJhRpmn+YgrxDWyIS6Q+aNir6S6M/uaiBqa1uem
         SlnN1iNNJweCHF1ujxdie1KpbZC20UbtU+b/yZVcHv95YDE9VKM6/GJJ9gxnh8y+hczw
         6IxtV0gRyw1zJs6VbFGKSc2j8OWiPJ4iBjcwfwXLz5XyRs50oM0vw7ULfzWcyfFkD1r4
         tyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866100; x=1779470900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wt+jsJsl27xuor3zWS8wmUXhY/BuPsAZ0VijKK5gtaU=;
        b=cEphOJt6XeeRolUOB6CYnKDi0WExpu0xw7482Gw2fajxjI1GypW2hX8k99s3W6HzNM
         vPfAWPh6gYF0ziZ8tiK02tzem8BT3nsxqVkaJpUTLYO1jlRyfedojElWuH+V8zz2rmUf
         5xbntYYG/6DclKrDg5Pl2sEafV9Qz4ASMDHJ8X2f3Zcx+LSJ6pbCNCkjrad2yEe6PYYF
         r4rWzUHvPXNXBm1jVPFM7pKect65uOhDzEczFL2+k7ooD3bvSLxIECmhfenNU5n6S2ku
         LYOEfpZgFd8yug5Oz2L1JtyCgkG/LcLe8Oeby8uE6JUsh0/clWfBPOtVzhiixm3X6Mbn
         LD3Q==
X-Gm-Message-State: AOJu0Yw8U8MgFUKGapmF277n/EhGdgg93ZaFb9WYUdJKvvaryCel/n7e
	ksWH+Y5KiMzfWD7Ab+ZY6ekhSXiRxcyv6BBHu4llwSUuFONTNRV/+tixIFu9MQ==
X-Gm-Gg: Acq92OGnuzrKjPlJ3a2VoHwETSoUxfHtyUSi05qO54NUoJVpX2UzJ20o34yMmxel6+M
	7vEa9AwofageP2zsDuOkCAGShOV5ymSnbDY/uGkMdP5hdrL9fYzmQBTT+xLX4rqDkr34ubH61c8
	Tx7Ge6xH4AmqFwItUg1yR0fCtL3WpnnkTayuF6IEgXiXwgBoBZHFdYzmHpS+hcUu8Ulcqpk3Q33
	kuxK6BCrAgYQtBUvkC5xrNPFPB9gKVeCDjKVPYqkrZNyIBbOQ38Xitm2z87Ey+5skxi/QM1q0jw
	cHTvt7hbV2WNV4zyxx7ywHhWtVjcuW0FXk7wzHVLzVaHo1zmiiAoLZuxgPuBre5a2ybF+g8hvJd
	sPu5m09LTZMi3azedDPPtDhncwh1M4Th1fHM3fi7PpGtXJFAatXnvHAhLMNWALoTolNOdcAxFPE
	wji8WfgtxvnkvNV2/qmI5V//kYmdO06g5XjA1WNv3L0fAhsPyuTBS8
X-Received: by 2002:a05:6a00:2998:b0:82c:77cd:50e8 with SMTP id d2e1a72fcca58-83f33d9dc6emr5283545b3a.27.1778866099820;
        Fri, 15 May 2026 10:28:19 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:9584:f97f:cff9:ff7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b71fsm5973035b3a.29.2026.05.15.10.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:28:19 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 2/3] sched_ext: Add dispatch transaction API
Date: Sat, 16 May 2026 01:27:40 +0800
Message-ID: <20260515172807.254804-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260515172807.254804-1-yphbchou0911@gmail.com>
References: <20260515172807.254804-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_insert() captures the task's dispatch token at insert time.
Any BPF-side validity checks performed before the insert fall outside
the race detection window: a dequeue/re-enqueue occurring between the
check and the insert goes undetected, and finish_dispatch() proceeds
with stale assumptions.

Introduce two new kfuncs to extend the detection window via a dispatch
transaction:

- scx_bpf_dsq_insert_begin(p) captures the sequence number before any
  pre-dispatch checks, opening the transaction.

- scx_bpf_dsq_insert_commit(p, args, token) closes it by inserting @p
  using the early-captured token. Only callable from ops.dispatch() and
  only targeting local DSQs. If the token has gone stale,
  finish_dispatch() silently discards the buffered entry.

scx_bpf_dsq_insert_commit wraps its parameters in a struct to stay
within the BPF verifier's five-argument limit imposed by KF_IMPLICIT_ARGS.

This mechanism is intended for schedulers that do not implement properly
synchronized dequeue. A scheduler whose ops.dequeue() synchronizes
atomically with the dispatch path does not need this API.

Suggested-by: Tejun Heo <tj@kernel.org>
Suggested-by: Kuba Piecuch <jpiecuch@google.com>
Suggested-by: Andrea Righi <arighi@nvidia.com>
Reported-by: Andrea Righi <arighi@nvidia.com>
Link: https://lore.kernel.org/r/20260203230639.1259869-1-arighi@nvidia.com/
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c                       | 110 +++++++++++++++++++++--
 kernel/sched/ext_internal.h              |   2 +-
 tools/sched_ext/include/scx/common.bpf.h |   2 +
 3 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9e59b068f02c..1c538329a202 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1895,6 +1895,16 @@ static void mark_direct_dispatch(struct scx_sched *sch,
 		return;
 	}
 
+	/*
+	 * No qseq validation is needed here. Direct dispatch from ops.enqueue()
+	 * happens while @p is in SCX_OPSS_QUEUEING state under its rq lock,
+	 * preventing concurrent dequeue or re-enqueue. Direct dispatch from
+	 * ops.select_cpu() happens before @p has been handed to the BPF
+	 * scheduler, so no concurrent dequeue is possible either.
+	 * finish_dispatch() validates qseq only on the deferred (ops.dispatch())
+	 * path, where @p may have left SCX_OPSS_QUEUED state between
+	 * scx_bpf_dsq_insert() and the actual dispatch.
+	 */
 	WARN_ON_ONCE(p->scx.ddsp_dsq_id != SCX_DSQ_INVALID);
 	WARN_ON_ONCE(p->scx.ddsp_enq_flags);
 
@@ -2775,7 +2785,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
  */
 static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 			    struct task_struct *p,
-			    unsigned long qseq_at_dispatch,
+			    u64 qseq_at_dispatch,
 			    u64 dsq_id, u64 enq_flags)
 {
 	struct scx_dispatch_q *dsq;
@@ -8423,7 +8433,7 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 }
 
 static void scx_dsq_insert_stage(struct scx_sched *sch, struct task_struct *p,
-				  u64 dsq_id, u64 enq_flags)
+			       u64 dsq_id, u64 enq_flags, u64 qseq)
 {
 	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	struct task_struct *ddsp_task;
@@ -8441,7 +8451,7 @@ static void scx_dsq_insert_stage(struct scx_sched *sch, struct task_struct *p,
 
 	dspc->buf[dspc->cursor++] = (struct scx_dsp_buf_ent){
 		.task = p,
-		.qseq = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK,
+		.qseq = qseq,
 		.dsq_id = dsq_id,
 		.enq_flags = enq_flags,
 	};
@@ -8508,7 +8518,8 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 	else
 		p->scx.slice = p->scx.slice ?: 1;
 
-	scx_dsq_insert_stage(sch, p, dsq_id, enq_flags);
+	scx_dsq_insert_stage(sch, p, dsq_id, enq_flags,
+			      atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK);
 
 	return true;
 }
@@ -8536,7 +8547,8 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 
 	p->scx.dsq_vtime = vtime;
 
-	scx_dsq_insert_stage(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+	scx_dsq_insert_stage(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ,
+			      atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK);
 
 	return true;
 }
@@ -8625,6 +8637,92 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
 }
 
+/**
+ * scx_bpf_dsq_insert_begin - Begin a dispatch transaction for a task
+ * @p: task_struct to dispatch
+ *
+ * Returns an opaque u64 token encoding @p's current scheduling state
+ * sequence number. Pass it to scx_bpf_dsq_insert_commit() in ops.dispatch().
+ *
+ * This function addresses a race in schedulers that queue tasks in
+ * ops.enqueue() and dispatch them later in ops.dispatch() without
+ * implementing ops.dequeue(). Between queuing and dispatch, @p may be
+ * dequeued, migrated, or re-enqueued on another CPU. Without token
+ * validation a stale dispatch would silently succeed, running @p from the
+ * wrong queue context.
+ *
+ * Capture the token before any per-task validation or pre-dispatch work.
+ * A commit with a stale token (one where @p was dequeued or re-enqueued
+ * after begin()) is detected asynchronously by finish_dispatch() and
+ * discarded.
+ *
+ * Schedulers that implement ops.dequeue() with proper synchronization do not
+ * need this API.
+ */
+__bpf_kfunc u64 scx_bpf_dsq_insert_begin(struct task_struct *p)
+{
+	return atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK;
+}
+
+struct scx_bpf_dsq_insert_commit_args {
+	/* @p can't be packed together as KF_RCU is not transitive */
+	u64			dsq_id;
+	u64			slice;
+	u64			enq_flags;
+};
+
+/**
+ * scx_bpf_dsq_insert_commit - Commit a dispatch transaction
+ * @p: task_struct to insert
+ * @args: pointer to struct scx_bpf_dsq_insert_commit_args
+ * @token: token from scx_bpf_dsq_insert_begin()
+ * @aux: implicit BPF argument
+ *
+ * May only be called from ops.dispatch(). Inserts @p into a local DSQ after
+ * validating @token against @p's current scheduling state. If @p was
+ * dequeued or re-enqueued between scx_bpf_dsq_insert_begin() and this call,
+ * the dispatch is silently discarded; stale-token detection fires
+ * asynchronously in finish_dispatch() after ops.dispatch() returns.
+ *
+ * Only local DSQs (SCX_DSQ_LOCAL or SCX_DSQ_LOCAL_ON | cpu) are valid
+ * targets. Attempting to commit to a non-local DSQ aborts the scheduler.
+ *
+ * Returns %true if @p was staged for dispatch, %false if @p is not owned by
+ * this scheduler. A %true return does not guarantee the task was actually
+ * dispatched: a stale token is detected after ops.dispatch() returns.
+ */
+__bpf_kfunc bool scx_bpf_dsq_insert_commit(struct task_struct *p,
+					    struct scx_bpf_dsq_insert_commit_args *args,
+					    u64 token,
+					    const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+	u64 enq_flags = args->enq_flags;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return false;
+
+	if (args->dsq_id != SCX_DSQ_LOCAL &&
+	    (args->dsq_id & SCX_DSQ_LOCAL_ON) != SCX_DSQ_LOCAL_ON) {
+		scx_error(sch, "scx_bpf_dsq_insert_commit() may only target local DSQs");
+		return false;
+	}
+
+	if (!scx_dsq_insert_preamble(sch, p, args->dsq_id, &enq_flags))
+		return false;
+
+	if (args->slice)
+		p->scx.slice = args->slice;
+	else
+		p->scx.slice = p->scx.slice ?: 1;
+
+	scx_dsq_insert_stage(sch, p, args->dsq_id, enq_flags, token);
+
+	return true;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
@@ -8993,6 +9091,7 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert_commit, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local, KF_IMPLICIT_ARGS)
@@ -10301,6 +10400,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert_begin, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 7258aea94b9f..73cced7cc0a1 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1054,7 +1054,7 @@ enum scx_sched_pcpu_flags {
 /* dispatch buf */
 struct scx_dsp_buf_ent {
 	struct task_struct	*task;
-	unsigned long		qseq;
+	u64			qseq;
 	u64			dsq_id;
 	u64			enq_flags;
 };
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 5f715d69cde6..bc2083f485fd 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -63,6 +63,8 @@ s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
 			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
 bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
+u64 scx_bpf_dsq_insert_begin(struct task_struct *p) __ksym __weak;
+bool scx_bpf_dsq_insert_commit(struct task_struct *p, struct scx_bpf_dsq_insert_commit_args *args, u64 token) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
-- 
2.48.1

