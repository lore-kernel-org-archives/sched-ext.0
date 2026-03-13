Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CB31D759;
	Fri, 13 Mar 2026 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401479; cv=none; b=SSrmN5T/L8Z3lMnEKvSy3zfmtEhDETnDRQCO0Iel44ijO8gIZiCuxVlAzbQIXOIf1CGlXGpgbqJJr1oYgUZ6jH9s6hw6/Tb1XJ94aZfjFCMWf48o6CUpRvOhjXGC93Wj8TYsepGxfD9ki4NHAnieVJGJheuqLjqDidpfcbiargM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401479; c=relaxed/simple;
	bh=LJH3LFewc/Lz/Cy535K0qQIDnXYMn40YxktInktylbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7ktVRmIVfCOOPAlN8xnxjuYGExJUcB71XyhfG/nfgFxV/DiEfMka4iNk1GJELmbJMm9CISGL3NuI3RuEsj7AXvQLFoTkveuo34eDgUDITJ4pXgia+C4g/z/illTwOdFf0qev8Vb3qVLtQkH2OuNMSdUSrX8TjM4OhevnmvKgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McTZ+EzH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McTZ+EzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F151C19421;
	Fri, 13 Mar 2026 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773401479;
	bh=LJH3LFewc/Lz/Cy535K0qQIDnXYMn40YxktInktylbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McTZ+EzHTrpcbHHCnfWOUvqGk+3MDxCa/eecxbpjGVul47SLZNqh2gIWZ0Mqb46WH
	 hHCGhiEmsthKGcsI2tVxHE/2LIDvrzoaKGIqysmU9Z/nzXruDmCvR6vAPldttApYg+
	 fFZ08OYpBvg+G5Ls4yl2hIIuDtKSOv15W0rV4wDtQyl29uLY1X7TWJEVh1IH+MtTMY
	 bPfW0fnK3yq0quHP/nGtEteF7B1CXHTKwkFRJc1KDHJDgLnlZg/weV0CscE1ypNWbM
	 ILIfUwBhru+oR+7b/4w6X8vrJHRN/iG4k/3Rso/6hPdN4yL3YZW/6jG/f2eq20Zyh/
	 Vm4nbMNOtuzTg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] sched_ext: Plumb enq_flags through the consume path
Date: Fri, 13 Mar 2026 01:31:12 -1000
Message-ID: <20260313113114.1591010-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313113114.1591010-1-tj@kernel.org>
References: <20260313113114.1591010-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add enq_flags parameter to consume_dispatch_q() and consume_remote_task(),
passing it through to move_{local,remote}_task_to_local_dsq(). All callers
pass 0.

No functional change. This prepares for SCX_ENQ_IMMED support on the consume
path.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 85cdb65a5a66..9dd51f0c9a53 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2355,13 +2355,14 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
 		!WARN_ON_ONCE(src_rq != task_rq(p));
 }
 
-static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
+static bool consume_remote_task(struct rq *this_rq,
+				struct task_struct *p, u64 enq_flags,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	raw_spin_rq_unlock(this_rq);
 
 	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
-		move_remote_task_to_local_dsq(p, 0, src_rq, this_rq);
+		move_remote_task_to_local_dsq(p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
 		raw_spin_rq_unlock(src_rq);
@@ -2441,7 +2442,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 }
 
 static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
-			       struct scx_dispatch_q *dsq)
+			       struct scx_dispatch_q *dsq, u64 enq_flags)
 {
 	struct task_struct *p;
 retry:
@@ -2471,13 +2472,13 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 
 		if (rq == task_rq) {
 			task_unlink_from_dsq(p, dsq);
-			move_local_task_to_local_dsq(p, 0, dsq, rq);
+			move_local_task_to_local_dsq(p, enq_flags, dsq, rq);
 			raw_spin_unlock(&dsq->lock);
 			return true;
 		}
 
 		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
-			if (likely(consume_remote_task(rq, p, dsq, task_rq)))
+			if (likely(consume_remote_task(rq, p, enq_flags, dsq, task_rq)))
 				return true;
 			goto retry;
 		}
@@ -2491,7 +2492,7 @@ static bool consume_global_dsq(struct scx_sched *sch, struct rq *rq)
 {
 	int node = cpu_to_node(cpu_of(rq));
 
-	return consume_dispatch_q(sch, rq, &sch->pnode[node]->global_dsq);
+	return consume_dispatch_q(sch, rq, &sch->pnode[node]->global_dsq, 0);
 }
 
 /**
@@ -2727,7 +2728,7 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	if (bypass_dsp_enabled(sch)) {
 		/* if @sch is bypassing, only the bypass DSQs are active */
 		if (scx_bypassing(sch, cpu))
-			return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
+			return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu), 0);
 
 #ifdef CONFIG_EXT_SUB_SCHED
 		/*
@@ -2745,7 +2746,7 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
 		if (!(pcpu->bypass_host_seq++ % SCX_BYPASS_HOST_NTH) &&
-		    consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu))) {
+		    consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu), 0)) {
 			__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
 			return true;
 		}
@@ -2817,7 +2818,7 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	 * scheduler's ops.dispatch() doesn't yield any tasks.
 	 */
 	if (bypass_dsp_enabled(sch))
-		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
+		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu), 0);
 
 	return false;
 }
@@ -8195,7 +8196,7 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux
 		return false;
 	}
 
-	if (consume_dispatch_q(sch, dspc->rq, dsq)) {
+	if (consume_dispatch_q(sch, dspc->rq, dsq, 0)) {
 		/*
 		 * A successfully consumed task can be dequeued before it starts
 		 * running while the CPU is trying to migrate other dispatched
-- 
2.53.0

