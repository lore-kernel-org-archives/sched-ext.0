Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18F46AED1;
	Wed, 21 Jan 2026 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037128; cv=none; b=H/xfQYGw8SuyUzLHu1PAcP3KImbNKtDyoxC7XuUrLWuytWatLyn18GMiXCOvdTrrsd+lcKGFl+ACCS6bjQLv9vw2gpcKzAreB50IXxq5k519pDZOIMl7OTC9I+mIUv9NrK0vMGxieDHqkEShXO8HNDvJ410T4C/8DxK8yR2fVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037128; c=relaxed/simple;
	bh=qWBk+sC6DyOKcbdFYxV4ylWzcYKhsi0EiG9w+tsODFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIrW78SyvJ/4LdT50vJOX0gxCZzvLSkGlHa3C9EeeVXUUhu4qJY5cTlqB8knBzzn7K7y6tUhDczgy5AcUzv9cQSyn7BZRaKMcB8M5pOrcO/byNpTMBGmszMoytf3xlxbKBpqwr+3lWurAY858f8tmnyyBrOEsH6F+xtbQWpXFl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG/kg00/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG/kg00/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF62BC2BCB3;
	Wed, 21 Jan 2026 23:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037127;
	bh=qWBk+sC6DyOKcbdFYxV4ylWzcYKhsi0EiG9w+tsODFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mG/kg00/5g8x9WzM2mW1XcfREqf3sWZH4QTjmBxCdXO0AnEFzK+S7tkHIVVoB85nU
	 ehaFBpDRB+Y2B6xkpRN8abTaZU9gs9Y6Nt6hQFCM0mcXv5kYR5/Vle9FpaOob05O7l
	 4rgF8z4SLoQJaxvfU20yHdR6Q/p+QP+iSBmRs5LLsqAwMVeZ8BrSMYduUArCbsMfKU
	 Eq8XGPNTbHskFOuBqmMCnlZkLEkOlxfyfkEDR/8ZKm3jfWtrhqOUM97tURs+kN6DXF
	 6+9i8TDzRdtUBts9c4483peyDlt5apL6GRKNml2ksx/cVoNIu94tNq5zQxlUAMhI57
	 SHcK/fLzmTIgQ==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 25/34] sched_ext: Move scx_dsp_ctx and scx_dsp_max_batch into scx_sched
Date: Wed, 21 Jan 2026 13:11:31 -1000
Message-ID: <20260121231140.832332-26-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_dsp_ctx and scx_dsp_max_batch are global variables used in the dispatch
path. In prepration for multiple scheduler support, move the former into
scx_sched_pcpu and the latter into scx_sched. No user-visible behavior
changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 55 ++++++++++---------------------------
 kernel/sched/ext_internal.h | 19 +++++++++++++
 2 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 69158c01f308..9c474a6dc2cc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -106,25 +106,6 @@ static const struct rhashtable_params dsq_hash_params = {
 
 static LLIST_HEAD(dsqs_to_free);
 
-/* dispatch buf */
-struct scx_dsp_buf_ent {
-	struct task_struct	*task;
-	unsigned long		qseq;
-	u64			dsq_id;
-	u64			enq_flags;
-};
-
-static u32 scx_dsp_max_batch;
-
-struct scx_dsp_ctx {
-	struct rq		*rq;
-	u32			cursor;
-	u32			nr_tasks;
-	struct scx_dsp_buf_ent	buf[];
-};
-
-static struct scx_dsp_ctx __percpu *scx_dsp_ctx;
-
 /* string formatting from BPF */
 struct scx_bstr_buf {
 	u64			data[MAX_BPRINTF_VARARGS];
@@ -2308,7 +2289,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 
 static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	u32 u;
 
 	for (u = 0; u < dspc->cursor; u++) {
@@ -2338,7 +2319,7 @@ static inline void maybe_queue_balance_callback(struct rq *rq)
 static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 			       struct task_struct *prev)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 	s32 cpu = cpu_of(rq);
 	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
@@ -4776,9 +4757,6 @@ static void scx_root_disable(struct scx_sched *sch)
 	 */
 	kobject_del(&sch->kobj);
 
-	free_percpu(scx_dsp_ctx);
-	scx_dsp_ctx = NULL;
-	scx_dsp_max_batch = 0;
 	free_kick_syncs();
 
 	mutex_unlock(&scx_enable_mutex);
@@ -5262,7 +5240,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		sch->global_dsqs[node] = dsq;
 	}
 
-	sch->pcpu = alloc_percpu(struct scx_sched_pcpu);
+	sch->dsp_max_batch = ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH;
+	sch->pcpu = __alloc_percpu(struct_size_t(struct scx_sched_pcpu,
+						 dsp_ctx.buf, sch->dsp_max_batch),
+				   __alignof__(struct scx_sched_pcpu));
 	if (!sch->pcpu) {
 		ret = -ENOMEM;
 		goto err_free_gdsqs;
@@ -5500,16 +5481,6 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ret)
 		goto err_disable;
 
-	WARN_ON_ONCE(scx_dsp_ctx);
-	scx_dsp_max_batch = ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH;
-	scx_dsp_ctx = __alloc_percpu(struct_size_t(struct scx_dsp_ctx, buf,
-						   scx_dsp_max_batch),
-				     __alignof__(struct scx_dsp_ctx));
-	if (!scx_dsp_ctx) {
-		ret = -ENOMEM;
-		goto err_disable;
-	}
-
 	if (ops->timeout_ms)
 		timeout = msecs_to_jiffies(ops->timeout_ms);
 	else
@@ -6448,7 +6419,7 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 				  u64 dsq_id, u64 enq_flags)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	struct task_struct *ddsp_task;
 
 	ddsp_task = __this_cpu_read(direct_dispatch_task);
@@ -6457,7 +6428,7 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	if (unlikely(dspc->cursor >= scx_dsp_max_batch)) {
+	if (unlikely(dspc->cursor >= sch->dsp_max_batch)) {
 		scx_error(sch, "dispatch buffer overflow");
 		return;
 	}
@@ -6775,7 +6746,7 @@ __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(const struct bpf_prog_aux *aux)
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return 0;
 
-	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx->cursor);
+	return sch->dsp_max_batch - __this_cpu_read(sch->pcpu->dsp_ctx.cursor);
 }
 
 /**
@@ -6787,8 +6758,8 @@ __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(const struct bpf_prog_aux *aux)
  */
 __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_sched *sch;
+	struct scx_dsp_ctx *dspc;
 
 	guard(rcu)();
 
@@ -6799,6 +6770,8 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return;
 
+	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
+
 	if (dspc->cursor > 0)
 		dspc->cursor--;
 	else
@@ -6822,9 +6795,9 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
  */
 __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux *aux)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
 	struct scx_sched *sch;
+	struct scx_dsp_ctx *dspc;
 
 	guard(rcu)();
 
@@ -6835,6 +6808,8 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
+	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
+
 	flush_dispatch_buf(sch, dspc->rq);
 
 	dsq = find_user_dsq(sch, dsq_id);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index db2065ec94ee..93ab6e0b0f74 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -937,6 +937,21 @@ enum scx_sched_pcpu_flags {
 	SCX_SCHED_PCPU_BYPASSING	= 1LLU << 0,
 };
 
+/* dispatch buf */
+struct scx_dsp_buf_ent {
+	struct task_struct	*task;
+	unsigned long		qseq;
+	u64			dsq_id;
+	u64			enq_flags;
+};
+
+struct scx_dsp_ctx {
+	struct rq		*rq;
+	u32			cursor;
+	u32			nr_tasks;
+	struct scx_dsp_buf_ent	buf[];
+};
+
 struct scx_sched_pcpu {
 	u64			flags;	/* protected by rq lock */
 
@@ -951,6 +966,9 @@ struct scx_sched_pcpu {
 #ifdef CONFIG_EXT_SUB_SCHED
 	u32			bypass_host_seq;
 #endif
+
+	/* must be the last entry - contains flex array */
+	struct scx_dsp_ctx	dsp_ctx;
 };
 
 struct scx_sched {
@@ -978,6 +996,7 @@ struct scx_sched {
 	atomic_t		bypass_dsp_enable_depth;
 
 	bool			aborting;
+	u32			dsp_max_batch;
 	s32			level;
 
 	/*
-- 
2.52.0

