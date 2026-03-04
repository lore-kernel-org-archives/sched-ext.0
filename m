Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0983E120B;
	Wed,  4 Mar 2026 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661707; cv=none; b=WgkbObc7LZAB4DcOnNiCUAqYedHcYwSLLfD2/R+UbB8OTQpvWTzHORFZtF7oOf7DzZjp0bQxsBpQLMjZZPm3xDeQrR7QnFsgH9JJWHgwoTYp6Km4ZzZ5Y7nqgXFbplxOtaD0UnJP7CgbrR2I1ZjwumH4MYOYtGLCYGF+APjuq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661707; c=relaxed/simple;
	bh=UsVb93Veq+SsydpnrMmlQX6v+by4AA3mfiWOCr0UcX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yxjx58CXV1GJ9lF1A4WMrr4J8yZnWo/lkK7cWZbFC7VSK/YkT2JNqSJfKsIUVJQ3D/vdLbu2XbgSPJdOc5ynOq0vwJktg+tL1KXRdd0aA0GrwLo9E2yEVs8pozN/3dS4G0kmtjXWeF+R2WbQa8XbGhxipCw0Z/GkvUPjY3AnjQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSGew3eE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSGew3eE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6304C4CEF7;
	Wed,  4 Mar 2026 22:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661706;
	bh=UsVb93Veq+SsydpnrMmlQX6v+by4AA3mfiWOCr0UcX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSGew3eEX72tp6p3HXI8jVtw3bRKNeE9XLS6EFf5nU5o1lG1b8NvUfNq+yTW8OTbX
	 xTz2sfSDPrlQlsbt4FmnadIJKEIJHXjA87LwUKsfzliOjy7wFrmMIvFuOIHO7EyvtG
	 94ClZX1hl84az4c2Pa1wRibosX+E9J9g9HvgfPNlG/tTjC+2G87sotVHNkLFJVwmRs
	 LjHbVwhPXXWhSJ1XPMYEjiciH49txsaFPb/ihmk8ODBHGLW+hBGABhnINoSGvoNnPt
	 k9R8/YK2t/6eujdm1s1jukO+1l999kSUqgZdEswKWWjT+95f/KdZY03x+SFVDZKR2m
	 8CqGCHFIkc73Q==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 25/34] sched_ext: Move scx_dsp_ctx and scx_dsp_max_batch into scx_sched
Date: Wed,  4 Mar 2026 12:01:10 -1000
Message-ID: <20260304220119.4095551-26-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
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
index 09b756141d2f..9e48196f05df 100644
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
@@ -2402,7 +2383,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 
 static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	u32 u;
 
 	for (u = 0; u < dspc->cursor; u++) {
@@ -2432,7 +2413,7 @@ static inline void maybe_queue_balance_callback(struct rq *rq)
 static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 			       struct task_struct *prev)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 	s32 cpu = cpu_of(rq);
 	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
@@ -4972,9 +4953,6 @@ static void scx_root_disable(struct scx_sched *sch)
 	 */
 	kobject_del(&sch->kobj);
 
-	free_percpu(scx_dsp_ctx);
-	scx_dsp_ctx = NULL;
-	scx_dsp_max_batch = 0;
 	free_kick_syncs();
 
 	mutex_unlock(&scx_enable_mutex);
@@ -5469,7 +5447,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
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
@@ -5716,16 +5697,6 @@ static void scx_root_enable_workfn(struct kthread_work *work)
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
@@ -6703,7 +6674,7 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 				  u64 dsq_id, u64 enq_flags)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	struct task_struct *ddsp_task;
 
 	ddsp_task = __this_cpu_read(direct_dispatch_task);
@@ -6712,7 +6683,7 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	if (unlikely(dspc->cursor >= scx_dsp_max_batch)) {
+	if (unlikely(dspc->cursor >= sch->dsp_max_batch)) {
 		scx_error(sch, "dispatch buffer overflow");
 		return;
 	}
@@ -7030,7 +7001,7 @@ __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(const struct bpf_prog_aux *aux)
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return 0;
 
-	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx->cursor);
+	return sch->dsp_max_batch - __this_cpu_read(sch->pcpu->dsp_ctx.cursor);
 }
 
 /**
@@ -7042,8 +7013,8 @@ __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(const struct bpf_prog_aux *aux)
  */
 __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_sched *sch;
+	struct scx_dsp_ctx *dspc;
 
 	guard(rcu)();
 
@@ -7054,6 +7025,8 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return;
 
+	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
+
 	if (dspc->cursor > 0)
 		dspc->cursor--;
 	else
@@ -7077,9 +7050,9 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
  */
 __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux *aux)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
 	struct scx_sched *sch;
+	struct scx_dsp_ctx *dspc;
 
 	guard(rcu)();
 
@@ -7090,6 +7063,8 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
+	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
+
 	flush_dispatch_buf(sch, dspc->rq);
 
 	dsq = find_user_dsq(sch, dsq_id);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 79d44d396152..1d633cc9e001 100644
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
2.53.0

