Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6554654;
	Fri,  6 Mar 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772836441; cv=none; b=Ny49aegDhXcL310pvYMawzYr58fFjZjrid8ApHoDizflAiaiN5pr8GurdbsAYXz13ENunloOqIyOmLKkRcSdAezXZCpnOtr8P89OcV62rky/vGU8/Ctc9wbSgdg/Dg++Vi5UoJwyhb7bdPHCTR/jzMxL50lmYXmUqiVHjY2Bm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772836441; c=relaxed/simple;
	bh=IF59oWxE+8FL1TXsC/mMJb3MpCotl+qQCyIJ9dSjCss=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=VX8FEHe6kA+ETPznJXmWu0QvwbwHB//LnhQdPnJS8abECST+zA23iunrkVl1OoqJ+vgHwT++83PBQwxQx+sBOQQ2F6k00DJwPcLcttJ+vt6gzCTKFpy3azjyUvnVUjCk+g47Av5jHkH+Bf9mJ5X0FNof/YC8vP8XCup3r5rMfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X02Ttv4g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X02Ttv4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF21AC4CEF7;
	Fri,  6 Mar 2026 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772836440;
	bh=IF59oWxE+8FL1TXsC/mMJb3MpCotl+qQCyIJ9dSjCss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X02Ttv4gLvtqWpWkJY7KMTHRg3ZmC3IYZ7NA7OyMaAPOoNQvyx23bO4wMDHK8j/v/
	 WZDbmdDTWV+L8xBx0//jwbXCbsPYswWPvNkF0EqCbq2dHKyYByJl6tPXGSYK9lGjX8
	 3BCo1fpeIpj7YNurdxdYxOQ4/C//xOewhVt4QsTHDhIdTX6pIn5dhFlWwISx5XYQGm
	 F+tsCxxOHBvTI0la/rEYI8io3VcETBdV1EDdFjT6AsFrV23NiQtrK8/rH+5nePBREC
	 K92wUztD46NAh0wAeHet91Lmbgjt+ZNt1DUrYjHQntv7sl5fGxb81EWPy21gMlv3Yt
	 aVnfpgcGIy3wg==
Date: Fri, 06 Mar 2026 12:33:59 -1000
Message-ID: <fe9185cbb72785b3310b5e1180cd2a9b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 emil@etsalapatis.com
Subject: [PATCH v2 04/15] sched_ext: Change find_global_dsq() to take CPU
 number instead of task
In-Reply-To: <20260306190623.1076074-5-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Change find_global_dsq() to take a CPU number directly instead of a task
pointer. This prepares for callers where the CPU is available but the task is
not.

No functional changes.

v2: Rename tcpu to cpu in find_global_dsq() (Emil Tsalapatis).

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/sched/ext.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -341,10 +341,9 @@ static bool scx_is_descendant(struct scx
 	for ((pos) = scx_next_descendant_pre(NULL, (root)); (pos);		\
 	     (pos) = scx_next_descendant_pre((pos), (root)))

-static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch,
-					      struct task_struct *p)
+static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch, s32 cpu)
 {
-	return &sch->pnode[cpu_to_node(task_cpu(p))]->global_dsq;
+	return &sch->pnode[cpu_to_node(cpu)]->global_dsq;
 }

 static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
@@ -1266,7 +1265,7 @@ static void dispatch_enqueue(struct scx_
 			scx_error(sch, "attempting to dispatch to a destroyed dsq");
 			/* fall back to the global dsq */
 			raw_spin_unlock(&dsq->lock);
-			dsq = find_global_dsq(sch, p);
+			dsq = find_global_dsq(sch, task_cpu(p));
 			raw_spin_lock(&dsq->lock);
 		}
 	}
@@ -1474,7 +1473,7 @@ static void dispatch_dequeue_locked(stru

 static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 						    struct rq *rq, u64 dsq_id,
-						    struct task_struct *p)
+						    s32 tcpu)
 {
 	struct scx_dispatch_q *dsq;

@@ -1485,20 +1484,19 @@ static struct scx_dispatch_q *find_dsq_f
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
@@ -1540,7 +1538,7 @@ static void direct_dispatch(struct scx_s
 {
 	struct rq *rq = task_rq(p);
 	struct scx_dispatch_q *dsq =
-		find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
+		find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, task_cpu(p));

 	touch_core_sched_dispatch(rq, p);

@@ -1683,7 +1681,7 @@ local:
 	dsq = &rq->scx.local_dsq;
 	goto enqueue;
 global:
-	dsq = find_global_dsq(sch, p);
+	dsq = find_global_dsq(sch, task_cpu(p));
 	goto enqueue;
 bypass:
 	dsq = bypass_enq_target_dsq(sch, task_cpu(p));
@@ -2140,7 +2138,7 @@ static struct rq *move_task_between_dsqs
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
 		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-			dst_dsq = find_global_dsq(sch, p);
+			dst_dsq = find_global_dsq(sch, task_cpu(p));
 			dst_rq = src_rq;
 		}
 	} else {
@@ -2269,7 +2267,7 @@ static void dispatch_to_local_dsq(struct

 	if (src_rq != dst_rq &&
 	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, rq, find_global_dsq(sch, p), p,
+		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
@@ -2407,7 +2405,7 @@ retry:

 	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));

-	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, p);
+	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, task_cpu(p));

 	if (dsq->id == SCX_DSQ_LOCAL)
 		dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
@@ -2647,7 +2645,7 @@ static void process_ddsp_deferred_locals

 		list_del_init(&p->scx.dsq_list.node);

-		dsq = find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
+		dsq = find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, task_cpu(p));
 		if (!WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL))
 			dispatch_to_local_dsq(sch, rq, dsq, p,
 					      p->scx.ddsp_enq_flags);
@@ -7410,7 +7408,7 @@ static bool scx_dsq_move(struct bpf_iter
 	}

 	/* @p is still on $src_dsq and stable, determine the destination */
-	dst_dsq = find_dsq_for_dispatch(sch, this_rq, dsq_id, p);
+	dst_dsq = find_dsq_for_dispatch(sch, this_rq, dsq_id, task_cpu(p));

 	/*
 	 * Apply vtime and slice updates before moving so that the new time is
