Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2433A9D6
	for <sched-ext@lists.linux.dev>; Sat,  9 May 2026 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778353955; cv=none; b=s+xQoABDPpmy5EHshSLPQrHwd2THfwsV92nWPvD45cD1snsgDUQl67IL9FIlbSdcf3upg6LgrCbtNWOC8dHLaYAtaC5iAhAJaEJMPXCJko8DzX5AaGxxTuY+KT1ATKaQLurqKgPy7wveRI0bc4JGVKbWPXDwt+9WG9yOeMsvtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778353955; c=relaxed/simple;
	bh=buoFwZcfMoHAEb2wVT3r8ho+o7RKNQnVGrjIjHTkKLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJy+QdduWXJeh8pm58HBhVSjXkmNW7O4ba81UGEtu1D6iaU0tGX3H/6HjbIvs3nbNOFw/A2kPdUXAQS/uZShPVNhSVne9oZDIMdd+owLnfbg/RFSHZ9XenFa0h09J5ESpMQMgrYfTJvnHl5EG2OVSUfMVllrwadbvxYUdaJQ4Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT1FYS/L; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT1FYS/L"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82faf871346so2171276b3a.0
        for <sched-ext@lists.linux.dev>; Sat, 09 May 2026 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778353953; x=1778958753; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVIqZnMaFRdEkd9ciNSxiylOHQsYJ82ix3eDnEtePeY=;
        b=OT1FYS/LH+Wwmg3271hJx/C2VW0gX9IKKZaUuIf2GPZqAyz9+tAJXd4AIgn9isoSqf
         yKjRCaQhqel2O0tW/Dlg4AABRBXr6a1bWf7fhelqYspGdm8l1l6f+u2vkJVbvN2+TWlV
         880WofcroA8k8zFhhguHw9pCLS6scbLrQZ87kChfZ/2WFP6rT2wG48DsHFu3As6SZmVr
         pnRFcImjfBiC8aal5ckK9qkqkx1CWb2iNZkxVlkcul2CFypWj1+FrkVMzKUjtMGvtD9U
         CYbHw3AJh7/vy68vBSLL5f82eGq405xlX+fVpDJOGZi+6IMggoqWulICRG0cYxF6ocpY
         1LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778353953; x=1778958753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVIqZnMaFRdEkd9ciNSxiylOHQsYJ82ix3eDnEtePeY=;
        b=I3buld1ojL1iDD1LshXZ882fDOLJx1x5SSDr2MJaT65Lt+o9Pk6oIkiv+srh07jp2A
         2Ul4zUvN26gJYLPdJmVHgEeohhdoWpXWfDrsXJdhV9d0i7xtKbLWlIrEB8j2Kqk+JABe
         nUDzeSUYEwAXIOsSu+Lj+7CruSW9Kxkl/6vIi2oSrKYEBsE7WmFbHRIDqKHGxNukiinu
         Ii5Qi6TNnToLIybbzZdPYVybJDStgquIEpgmQ15BbEviXZpVZT2StaaI+aEyfmbyaBP1
         ZKOLs2VYqxFxuybzTxWjCXgNekJFrqyrlA8TYOdhoBHegnNR62mRmA3jwDIpyzmQCLFr
         rXEw==
X-Gm-Message-State: AOJu0YxG2WlR+dCP0inE0Z4dqxxWr09UIJClcnaE5stV62ZERLOpFaf0
	2ueA4mIWGKVQiD9IXtbVHtvPoUa9T7Rpk1ukjXPWhzc+1hICuOz2Q5plcGYkwg==
X-Gm-Gg: Acq92OFnibScr2NjCYpl6NfsoN3JpyKxCSHjggYICxhVI6cVXH6blizfyXOPiGWjE5n
	0OKlED7yGCY/uKFuFrn7aquYSWWi+FcRgqTDSnVLD0/vojvCwrNI6aA4l1Ojam6HGD6MvBYdvGm
	vZ5HkpoXW33R8FlsOx25Ep0QMLi3oFP7AlVDz4o/m/eL3QbPn3qDOlcBAkAUCnT82H+PMWZFiHs
	sveSfOGMqDMCErntONTXswuQH2MK9s2cFjDHXdhIOFUXGpiI9AFsYwBhjmQ6MdX3Rcmd5hbjHz8
	b38SVr5hWItkZLSmHVSnr1ENhZBTWQfEJzaf2NbBWKyXo3j69NnT1xl1mSIMCZjuf8lmb2UGIph
	QKp999ZP0dWnyaN/Q4JU3eeSMY+FbdQSnMX2kr/IGPdaXV2YVPh5fDr3ROGBCIownuGCrklvZSJ
	R9jIKktdgfN+UWAlkqFTyN1iwVJshPu7KewZMogurT6vM7AgRnzVH+AY5LKE6DYrM=
X-Received: by 2002:a05:6a00:9297:b0:82c:e83d:a9b0 with SMTP id d2e1a72fcca58-83a5c6babd7mr18020935b3a.21.1778353953119;
        Sat, 09 May 2026 12:12:33 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:7487:6815:7f54:c796])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbd995sm14470222b3a.43.2026.05.09.12.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:12:32 -0700 (PDT)
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
Subject: [PATCH v3 1/2] sched_ext: Add dispatch transaction API
Date: Sun, 10 May 2026 03:11:56 +0800
Message-ID: <20260509191223.168648-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260509191223.168648-1-yphbchou0911@gmail.com>
References: <20260509191223.168648-1-yphbchou0911@gmail.com>
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

- scx_bpf_dsq_insert_begin(p)
    Starts a dispatch transaction for @p and returns an opaque u64
    token. The BPF scheduler should call this before performing
    pre-dispatch validity checks. The token may be stored in BPF maps
    to support cross-CPU dispatch patterns.

- scx_bpf_dsq_insert_commit(p, dsq_id, enq_flags, token)
    Like scx_bpf_dsq_insert() with slice=0, but commits using the
    token captured by scx_bpf_dsq_insert_begin(). If @p was dequeued
    or claimed between begin and commit, the transaction is silently
    discarded. Use scx_bpf_task_set_slice() to set a non-default slice.

To support explicit token passing, rename scx_dsq_insert_commit() to
scx_dsq_insert_buf() and add a qseq parameter. All existing callers
preserve the original behavior.

This mechanism is intended for schedulers that do not implement
properly synchronized dequeue. A scheduler whose ops.dequeue()
synchronizes atomically with the dispatch path does not need this API.

Suggested-by: Tejun Heo <tj@kernel.org>
Suggested-by: Kuba Piecuch <jpiecuch@google.com>
Suggested-by: Andrea Righi <arighi@nvidia.com>
Reported-by: Andrea Righi <arighi@nvidia.com>
Link: https://lore.kernel.org/r/20260203230639.1259869-1-arighi@nvidia.com/
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c                       | 72 ++++++++++++++++++++++--
 tools/sched_ext/include/scx/common.bpf.h |  2 +
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b2741b6fb046..81483520f5cc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8315,8 +8315,8 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 	return true;
 }
 
-static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
-				  u64 dsq_id, u64 enq_flags)
+static void scx_dsq_insert_buf(struct scx_sched *sch, struct task_struct *p,
+			       u64 dsq_id, u64 enq_flags, unsigned long qseq)
 {
 	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	struct task_struct *ddsp_task;
@@ -8334,7 +8334,7 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 
 	dspc->buf[dspc->cursor++] = (struct scx_dsp_buf_ent){
 		.task = p,
-		.qseq = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK,
+		.qseq = qseq,
 		.dsq_id = dsq_id,
 		.enq_flags = enq_flags,
 	};
@@ -8401,7 +8401,8 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 	else
 		p->scx.slice = p->scx.slice ?: 1;
 
-	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
+	scx_dsq_insert_buf(sch, p, dsq_id, enq_flags,
+			      atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK);
 
 	return true;
 }
@@ -8429,7 +8430,8 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 
 	p->scx.dsq_vtime = vtime;
 
-	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+	scx_dsq_insert_buf(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ,
+			      atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK);
 
 	return true;
 }
@@ -8518,13 +8520,72 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 	scx_dsq_insert_vtime(sch, p, dsq_id, slice, vtime, enq_flags);
 }
 
+/**
+ * scx_bpf_dsq_insert_begin - Begin a dispatch transaction for a task
+ * @p: task_struct to dispatch
+ *
+ * Returns an opaque u64 dispatch token. Pass the token to
+ * scx_bpf_dsq_insert_commit() to insert @p into a DSQ. If @p is dequeued
+ * or claimed by another path between scx_bpf_dsq_insert_begin() and
+ * scx_bpf_dsq_insert_commit(), the commit will silently fail.
+ *
+ * This API is intended for schedulers that do not implement properly
+ * synchronized dequeue.
+ */
+__bpf_kfunc u64 scx_bpf_dsq_insert_begin(struct task_struct *p)
+{
+	return atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK;
+}
+
+/**
+ * scx_bpf_dsq_insert_commit - Commit a dispatch transaction
+ * @p: task_struct to insert
+ * @dsq_id: DSQ to insert into
+ * @enq_flags: SCX_ENQ_*
+ * @token: token from scx_bpf_dsq_insert_begin()
+ * @aux: implicit BPF argument
+ *
+ * Like scx_bpf_dsq_insert() with slice=0, but commits a dispatch transaction
+ * begun with scx_bpf_dsq_insert_begin(). If @p was dequeued or claimed
+ * between begin and commit, the dispatch is silently discarded. Use
+ * scx_bpf_task_set_slice() to set a non-default slice.
+ *
+ * Returns %true if the entry was buffered for dispatch, %false on preamble
+ * failure (e.g. @p is not owned by this scheduler). Note: stale token
+ * detection fires asynchronously in finish_dispatch() after ops.dispatch()
+ * returns. A %true return does not guarantee the task was actually dispatched.
+ */
+__bpf_kfunc bool scx_bpf_dsq_insert_commit(struct task_struct *p,
+					    u64 dsq_id, u64 enq_flags,
+					    u64 token,
+					    const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return false;
+
+	if (!scx_dsq_insert_preamble(sch, p, dsq_id, &enq_flags))
+		return false;
+
+	p->scx.slice = p->scx.slice ?: 1;
+
+	scx_dsq_insert_buf(sch, p, dsq_id, enq_flags, (unsigned long)token);
+
+	return true;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_IMPLICIT_ARGS | KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert_commit, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert_begin, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
@@ -10194,6 +10255,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_insert_begin, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 5f715d69cde6..fb793008e2e3 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -63,6 +63,8 @@ s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 s32 __scx_bpf_select_cpu_and(struct task_struct *p, const struct cpumask *cpus_allowed,
 			     struct scx_bpf_select_cpu_and_args *args) __ksym __weak;
 bool __scx_bpf_dsq_insert_vtime(struct task_struct *p, struct scx_bpf_dsq_insert_vtime_args *args) __ksym __weak;
+u64 scx_bpf_dsq_insert_begin(struct task_struct *p) __ksym __weak;
+bool scx_bpf_dsq_insert_commit(struct task_struct *p, u64 dsq_id, u64 enq_flags, u64 token) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
-- 
2.48.1

