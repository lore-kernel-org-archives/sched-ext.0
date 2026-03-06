Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4C3EFD39;
	Fri,  6 Mar 2026 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823989; cv=none; b=YUHa0xwIlCY/6V6TQSu3fdagzgdRxT9YDKcn5ZoObYr9TSbsAns1vqNkOd/5tOfqnSv8K+g7f8FQ9EYvlT170/qAMOXQScqAO0QHfWqbFqLM/OWFJc3Yz91KLeEpolhIHSvHQJ7EODmt8cbFMc22fDV+jKv+xoz8qODI8PPFWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823989; c=relaxed/simple;
	bh=LOlYV832omMK0N8kd39WsmebW9wLysFbLnOEbrfe3Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdVsX2SHJljfX5woQ6oJ3JsE1Ga3Wz3Ll/vrFKTdwAocXHUASSFZ/mO3ODmO+8NcG80jqy5qSYGf8EtHTjIWw3+KnboPNEfrdTIlr56DaTaPzdEAI5MVgipEHELcCC8nt+cnhWSoYlo7bvaCqzvFj+MMC8X4U20NBxz3a6VLDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4pAB29I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4pAB29I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86573C4CEF7;
	Fri,  6 Mar 2026 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823988;
	bh=LOlYV832omMK0N8kd39WsmebW9wLysFbLnOEbrfe3Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4pAB29IqoFBPGSqgP+jsIusoHzDC8sLgpV8zmXnHotGi4zwpnCEvzw8EHxMnNXKC
	 ibO8YXtDLq1NzPoZjAlUrXKDxjFI7LD2vWwyUrTVjK5xXkGlQGXlWKkPVVWGitF37q
	 hBGOotZPXA5OlKjPplOuFLLBKGTEGP4ajm9gj6TcoUP90aezVjcTonYjMrwgrGWiiH
	 ll9irdCv/VmxHFgR2EBI1Ad40gzuyrYEsaX0jX7daYE66+i365ug9TlbzvmnD+xNVw
	 lDJzNYJHkSYNXtQ3Vik/l2LCl4c84NPqWNN2FGG2krdspo2/xOAAccUA4S9+lCQ0aV
	 tLqd30DsVBbPA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/15] sched_ext: Change find_global_dsq() to take CPU number instead of task
Date: Fri,  6 Mar 2026 09:06:12 -1000
Message-ID: <20260306190623.1076074-5-tj@kernel.org>
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

Change find_global_dsq() to take a CPU number directly instead of a task
pointer. This prepares for callers where the CPU is available but the task is
not.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c36d399bca3e..c44893878878 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -341,10 +341,9 @@ static bool scx_is_descendant(struct scx_sched *sch, struct scx_sched *ancestor)
 	for ((pos) = scx_next_descendant_pre(NULL, (root)); (pos);		\
 	     (pos) = scx_next_descendant_pre((pos), (root)))
 
-static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch,
-					      struct task_struct *p)
+static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch, s32 tcpu)
 {
-	return &sch->pnode[cpu_to_node(task_cpu(p))]->global_dsq;
+	return &sch->pnode[cpu_to_node(tcpu)]->global_dsq;
 }
 
 static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
@@ -1266,7 +1265,7 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 			scx_error(sch, "attempting to dispatch to a destroyed dsq");
 			/* fall back to the global dsq */
 			raw_spin_unlock(&dsq->lock);
-			dsq = find_global_dsq(sch, p);
+			dsq = find_global_dsq(sch, task_cpu(p));
 			raw_spin_lock(&dsq->lock);
 		}
 	}
@@ -1474,7 +1473,7 @@ static void dispatch_dequeue_locked(struct task_struct *p,
 
 static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 						    struct rq *rq, u64 dsq_id,
-						    struct task_struct *p)
+						    s32 tcpu)
 {
 	struct scx_dispatch_q *dsq;
 
@@ -1485,20 +1484,19 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
 
 		if (!ops_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
-			return find_global_dsq(sch, p);
+			return find_global_dsq(sch, tcpu);
 
 		return &cpu_rq(cpu)->scx.local_dsq;
 	}
 
 	if (dsq_id == SCX_DSQ_GLOBAL)
-		dsq = find_global_dsq(sch, p);
+		dsq = find_global_dsq(sch, tcpu);
 	else
 		dsq = find_user_dsq(sch, dsq_id);
 
 	if (unlikely(!dsq)) {
-		scx_error(sch, "non-existent DSQ 0x%llx for %s[%d]",
-			  dsq_id, p->comm, p->pid);
-		return find_global_dsq(sch, p);
+		scx_error(sch, "non-existent DSQ 0x%llx", dsq_id);
+		return find_global_dsq(sch, tcpu);
 	}
 
 	return dsq;
@@ -1540,7 +1538,7 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 {
 	struct rq *rq = task_rq(p);
 	struct scx_dispatch_q *dsq =
-		find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
+		find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, task_cpu(p));
 
 	touch_core_sched_dispatch(rq, p);
 
@@ -1683,7 +1681,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	dsq = &rq->scx.local_dsq;
 	goto enqueue;
 global:
-	dsq = find_global_dsq(sch, p);
+	dsq = find_global_dsq(sch, task_cpu(p));
 	goto enqueue;
 bypass:
 	dsq = bypass_enq_target_dsq(sch, task_cpu(p));
@@ -2140,7 +2138,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-			dst_dsq = find_global_dsq(sch, p);
+			dst_dsq = find_global_dsq(sch, task_cpu(p));
 			dst_rq = src_rq;
 		}
 	} else {
@@ -2269,7 +2267,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 
 	if (src_rq != dst_rq &&
 	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, rq, find_global_dsq(sch, p), p,
+		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
@@ -2407,7 +2405,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 
 	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
 
-	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, p);
+	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, task_cpu(p));
 
 	if (dsq->id == SCX_DSQ_LOCAL)
 		dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
@@ -2647,7 +2645,7 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 
 		list_del_init(&p->scx.dsq_list.node);
 
-		dsq = find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
+		dsq = find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, task_cpu(p));
 		if (!WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL))
 			dispatch_to_local_dsq(sch, rq, dsq, p,
 					      p->scx.ddsp_enq_flags);
@@ -7410,7 +7408,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	}
 
 	/* @p is still on $src_dsq and stable, determine the destination */
-	dst_dsq = find_dsq_for_dispatch(sch, this_rq, dsq_id, p);
+	dst_dsq = find_dsq_for_dispatch(sch, this_rq, dsq_id, task_cpu(p));
 
 	/*
 	 * Apply vtime and slice updates before moving so that the new time is
-- 
2.53.0

