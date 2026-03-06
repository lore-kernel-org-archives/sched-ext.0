Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A721428490;
	Fri,  6 Mar 2026 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823995; cv=none; b=oXHf2o7VUKY/cXE7ZVvfS60eB1h4dnD4YXsPBc51DJSFE++AD+COmi1NBoVBELG9vDWSvmi7S8R4Xl9FUpehpOgiNVS9QivTqTdHuftpoH6Wli+V+enokajmuUO+KITnYcw51P9hKa4Uj1sPq9StpIAX4NejNS5booaDgEq+dzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823995; c=relaxed/simple;
	bh=QHmURaUvTSSBMVWI0I2WBUEQZckuRunbGob/JsYUWWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=px9Dw/XVQbGMyxB6BNdYrbdykzsDHFcWg7XdnpvpQuz6ZiPnSnvV+1Z+N9EZoPn+IJ1RtmW1Ocd0wWuTHzxd9OHUt/KPKXW5kpFuEQ81waCB/YOwwMQCxq37E0B6o4a5TyplIRWSafUa2BWEd6PV2KiiOttuzWUr7HWk/ndFJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4dsg9U0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4dsg9U0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9A9C4CEF7;
	Fri,  6 Mar 2026 19:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823995;
	bh=QHmURaUvTSSBMVWI0I2WBUEQZckuRunbGob/JsYUWWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4dsg9U0ZmD/Df8noeuDf9Tf2S4NGK/4Yryyi8XsqS9U2NEmcA5edSTeVsdTTaSex
	 LihUcgYt/UahG44p3iKrR8dt8/c6D1ixZRYb+bfkIoCA54wKFTb/T+WznYhEhnI9pa
	 4r8VC6O68bAx0Z2y/sW8Sn+C1kwIGoPbYbfTCbPbvMx7pRuSNgBZPUdcH7uDklv+E2
	 3js50b4fz6P5Cmfvj52Y1ugpqjCmeJ/3jxF1o1sRIAQEoyLZKN5tUMH/oa4KxJ4NKa
	 JD6M2gvlwAFv8pX+RWdwFQF6jj5qw+4QN3zKGc9T1p84tEHe3KwnJIjZPcDW6VU1iQ
	 GFi6jXkVp7frw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/15] sched_ext: Add per-CPU data to DSQs
Date: Fri,  6 Mar 2026 09:06:18 -1000
Message-ID: <20260306190623.1076074-11-tj@kernel.org>
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

Add per-CPU data structure to dispatch queues. Each DSQ now has a percpu
scx_dsq_pcpu which contains a back-pointer to the DSQ. This will be used by
future changes to implement per-CPU reenqueue tracking for user DSQs.

init_dsq() now allocates the percpu data and can fail, so it returns an
error code. All callers are updated to handle failures. exit_dsq() is added
to free the percpu data and is called from all DSQ cleanup paths.

In scx_bpf_create_dsq(), init_dsq() is called before rcu_read_lock() since
alloc_percpu() requires GFP_KERNEL context, and dsq->sched is set
afterwards.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  5 +++
 kernel/sched/ext.c        | 82 ++++++++++++++++++++++++++++++++-------
 2 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index f354d7d34306..98cc1f41b91e 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -62,6 +62,10 @@ enum scx_dsq_id_flags {
 	SCX_DSQ_LOCAL_CPU_MASK	= 0xffffffffLLU,
 };
 
+struct scx_dsq_pcpu {
+	struct scx_dispatch_q	*dsq;
+};
+
 /*
  * A dispatch queue (DSQ) can be either a FIFO or p->scx.dsq_vtime ordered
  * queue. A built-in DSQ is always a FIFO. The built-in local DSQs are used to
@@ -79,6 +83,7 @@ struct scx_dispatch_q {
 	struct rhash_head	hash_node;
 	struct llist_node	free_node;
 	struct scx_sched	*sched;
+	struct scx_dsq_pcpu __percpu *pcpu;
 	struct rcu_head		rcu;
 };
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c9b0e94d59bd..996c410cc892 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4021,15 +4021,42 @@ DEFINE_SCHED_CLASS(ext) = {
 #endif
 };
 
-static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id,
-		     struct scx_sched *sch)
+static s32 init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id,
+		    struct scx_sched *sch)
 {
+	s32 cpu;
+
 	memset(dsq, 0, sizeof(*dsq));
 
 	raw_spin_lock_init(&dsq->lock);
 	INIT_LIST_HEAD(&dsq->list);
 	dsq->id = dsq_id;
 	dsq->sched = sch;
+
+	dsq->pcpu = alloc_percpu(struct scx_dsq_pcpu);
+	if (!dsq->pcpu)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct scx_dsq_pcpu *pcpu = per_cpu_ptr(dsq->pcpu, cpu);
+
+		pcpu->dsq = dsq;
+	}
+
+	return 0;
+}
+
+static void exit_dsq(struct scx_dispatch_q *dsq)
+{
+	free_percpu(dsq->pcpu);
+}
+
+static void free_dsq_rcufn(struct rcu_head *rcu)
+{
+	struct scx_dispatch_q *dsq = container_of(rcu, struct scx_dispatch_q, rcu);
+
+	exit_dsq(dsq);
+	kfree(dsq);
 }
 
 static void free_dsq_irq_workfn(struct irq_work *irq_work)
@@ -4038,7 +4065,7 @@ static void free_dsq_irq_workfn(struct irq_work *irq_work)
 	struct scx_dispatch_q *dsq, *tmp_dsq;
 
 	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
-		kfree_rcu(dsq, rcu);
+		call_rcu(&dsq->rcu, free_dsq_rcufn);
 }
 
 static DEFINE_IRQ_WORK(free_dsq_irq_work, free_dsq_irq_workfn);
@@ -4235,15 +4262,17 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		cgroup_put(sch_cgroup(sch));
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
-	/*
-	 * $sch would have entered bypass mode before the RCU grace period. As
-	 * that blocks new deferrals, all deferred_reenq_local_node's must be
-	 * off-list by now.
-	 */
 	for_each_possible_cpu(cpu) {
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 
+		/*
+		 * $sch would have entered bypass mode before the RCU grace
+		 * period. As that blocks new deferrals, all
+		 * deferred_reenq_local_node's must be off-list by now.
+		 */
 		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
+
+		exit_dsq(bypass_dsq(sch, cpu));
 	}
 
 	free_percpu(sch->pcpu);
@@ -5788,6 +5817,9 @@ static int alloc_kick_syncs(void)
 
 static void free_pnode(struct scx_sched_pnode *pnode)
 {
+	if (!pnode)
+		return;
+	exit_dsq(&pnode->global_dsq);
 	kfree(pnode);
 }
 
@@ -5799,7 +5831,10 @@ static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int node)
 	if (!pnode)
 		return NULL;
 
-	init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch);
+	if (init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch)) {
+		kfree(pnode);
+		return NULL;
+	}
 
 	return pnode;
 }
@@ -5849,8 +5884,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		goto err_free_pnode;
 	}
 
-	for_each_possible_cpu(cpu)
-		init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
+	for_each_possible_cpu(cpu) {
+		ret = init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
+		if (ret)
+			goto err_free_pcpu;
+	}
 
 	for_each_possible_cpu(cpu) {
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
@@ -5932,6 +5970,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 err_stop_helper:
 	kthread_destroy_worker(sch->helper);
 err_free_pcpu:
+	for_each_possible_cpu(cpu) {
+		if (bypass_dsq(sch, cpu))
+			exit_dsq(bypass_dsq(sch, cpu));
+	}
 	free_percpu(sch->pcpu);
 err_free_pnode:
 	for_each_node_state(node, N_POSSIBLE)
@@ -7174,7 +7216,7 @@ void __init init_sched_ext_class(void)
 		int  n = cpu_to_node(cpu);
 
 		/* local_dsq's sch will be set during scx_root_enable() */
-		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL);
+		BUG_ON(init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL));
 
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
@@ -7873,11 +7915,21 @@ __bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node, const struct bpf_prog_a
 	if (!dsq)
 		return -ENOMEM;
 
+	/*
+	 * init_dsq() must be called in GFP_KERNEL context. Init it with NULL
+	 * @sch and update afterwards.
+	 */
+	ret = init_dsq(dsq, dsq_id, NULL);
+	if (ret) {
+		kfree(dsq);
+		return ret;
+	}
+
 	rcu_read_lock();
 
 	sch = scx_prog_sched(aux);
 	if (sch) {
-		init_dsq(dsq, dsq_id, sch);
+		dsq->sched = sch;
 		ret = rhashtable_lookup_insert_fast(&sch->dsq_hash, &dsq->hash_node,
 						    dsq_hash_params);
 	} else {
@@ -7885,8 +7937,10 @@ __bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node, const struct bpf_prog_a
 	}
 
 	rcu_read_unlock();
-	if (ret)
+	if (ret) {
+		exit_dsq(dsq);
 		kfree(dsq);
+	}
 	return ret;
 }
 
-- 
2.53.0

