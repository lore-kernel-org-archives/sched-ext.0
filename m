Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592923FB7E1;
	Fri, 24 Apr 2026 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063466; cv=none; b=QQa7me4qD6x4gEjUMJjOcSALtxSS8ql80EUrM0voDBuXJU5EnlsF+UV3gGtpcYvSR5VSrSUyAX3MMwM2/nNX1DOvp5GEP9euLsFe03xhf77AgbOYVBlqqaRA26Sm82QzEjMPu2V4UIcIiLR+k/lHtsbGaYfjnbMC/oR9zYa+3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063466; c=relaxed/simple;
	bh=FbULoCVK/BHm7n3kSXDiZg1VXUCgNNJu1RFCIYMIBQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtWdbfeWSNe13o8Sn0UwItNF/+AbPk+CXdjFUAzd7ECQ+gYEb1+EJsr4yAaQ6v/bn5RxLE4wBv8s9nHVyOKz2WRQBPkyJjVbk996vemQpDokX2/lSpfiF8+7PdUyzPcTabDuayq+GQUfQbSXLNRRLIzq9UJotA3EAeHvQGacHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plMhXKoX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plMhXKoX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E28C2BCB0;
	Fri, 24 Apr 2026 20:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063466;
	bh=FbULoCVK/BHm7n3kSXDiZg1VXUCgNNJu1RFCIYMIBQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plMhXKoXkbXASWwQoINqADlz0sSC0k5VQDU0oEoaREBXJ078hmFx4bLxlp2EoOSNR
	 XhWOalshPFxlH+HOuixyjWFT6DK5LDHjd878+LSb4iVIXVD1o489doCgTMXqrZroxy
	 eme6WJfB3wxmJaft4AafAntbZ+45QRKcpqrjh2H+W/KVBxOMci3kqIDpgV1W/RqBCH
	 YXbEE0Fy/h66xw4cHakU4qYZQ/qwV7OJl78AXl/wsMzL8soC3z9+yR23p41wbacX04
	 irElyfK449lKT5COSABtgB+wtG+DTBOHw2fSfi5b8OZV9WdioyisWNvq6JBEmYz5m1
	 G6/bg3aztY1Kg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/13] sched_ext: Resolve caller's scheduler in scx_bpf_destroy_dsq() / scx_bpf_dsq_nr_queued()
Date: Fri, 24 Apr 2026 10:44:11 -1000
Message-ID: <20260424204418.3809733-7-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_create_dsq() resolves the calling scheduler via scx_prog_sched(aux)
and inserts the new DSQ into that scheduler's dsq_hash. Its inverse
scx_bpf_destroy_dsq() and the query helper scx_bpf_dsq_nr_queued() were
hard-coded to rcu_dereference(scx_root), so a sub-scheduler could only
destroy or query DSQs in the root scheduler's hash - never its own. If the
root had a DSQ with the same id, the sub-sched silently destroyed it and the
root aborted on the next dispatch ("invalid DSQ ID 0x0..").

Take a const struct bpf_prog_aux *aux via KF_IMPLICIT_ARGS and resolve the
scheduler with scx_prog_sched(aux), matching scx_bpf_create_dsq().

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 59445e95d2f2..4bd1fcba50c5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8701,11 +8701,12 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
 /**
  * scx_bpf_dsq_nr_queued - Return the number of queued tasks
  * @dsq_id: id of the DSQ
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Return the number of tasks in the DSQ matching @dsq_id. If not found,
  * -%ENOENT is returned.
  */
-__bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id)
+__bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id, const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *sch;
 	struct scx_dispatch_q *dsq;
@@ -8713,7 +8714,7 @@ __bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id)
 
 	preempt_disable();
 
-	sch = rcu_dereference_sched(scx_root);
+	sch = scx_prog_sched(aux);
 	if (unlikely(!sch)) {
 		ret = -ENODEV;
 		goto out;
@@ -8745,21 +8746,21 @@ __bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id)
 /**
  * scx_bpf_destroy_dsq - Destroy a custom DSQ
  * @dsq_id: DSQ to destroy
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Destroy the custom DSQ identified by @dsq_id. Only DSQs created with
  * scx_bpf_create_dsq() can be destroyed. The caller must ensure that the DSQ is
  * empty and no further tasks are dispatched to it. Ignored if called on a DSQ
  * which doesn't exist. Can be called from any online scx_ops operations.
  */
-__bpf_kfunc void scx_bpf_destroy_dsq(u64 dsq_id)
+__bpf_kfunc void scx_bpf_destroy_dsq(u64 dsq_id, const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *sch;
 
-	rcu_read_lock();
-	sch = rcu_dereference(scx_root);
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
 	if (sch)
 		destroy_dsq(sch, dsq_id);
-	rcu_read_unlock();
 }
 
 /**
@@ -9513,8 +9514,8 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
-BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
+BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_destroy_dsq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_IMPLICIT_ARGS | KF_RCU_PROTECTED | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_dsq_reenq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2, KF_IMPLICIT_ARGS)
-- 
2.53.0

