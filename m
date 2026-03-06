Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178BD35F606;
	Fri,  6 Mar 2026 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838572; cv=none; b=FT1YezbXJzdLFp01Ml7PibkNYitlixxQsQYmi3jQtIYBv+0UMQYMnvAmJmRq9UDSuHWn+kcd6DP6848IT6JVgBrUVSq8fNhgVPxVRb83IR5sFhIcPHujaObYpEiN0Y52UGqg+H9G7FPO6FRxWvQPSfOjs+x4xltTRLMgS96jsrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838572; c=relaxed/simple;
	bh=KCFWd6Iqa+h7PQ1gmmYESjVRz0yST1iUgRggzAORtIQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ViofAMlV/ygjYNXmaBW601vueF9d2kgrD2d8VmOSYhZIdW4AU2eDKJtFuKN/Rm6Me+qWjx8UEur1aNrRXt1T7xZT0NTlZdoXPRAmnGFXZScEz0a/PJirxyErWSsPf/YAedAFO7Y4m4yutK844nTWi6B1g6LXd2ggwfWinV8l6ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohcb6uHb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ohcb6uHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0139C4CEF7;
	Fri,  6 Mar 2026 23:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772838572;
	bh=KCFWd6Iqa+h7PQ1gmmYESjVRz0yST1iUgRggzAORtIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ohcb6uHbSSc66XLxdMWLbovkGze3vcTn2nO/eMHuQi3RyCYJLV0BqDwrItFMdX3q+
	 RyHzOYd3dbNmGPNPAzdDHhBkUWwux5E9lZPq9kEWCr4ZeDydAPaYklCNx0WhCn6PUP
	 5xzbhajQaR3ZxAL5gnj2twqmquITluoz1Zquk76yPVVDZPOUVwPLWyYmkQFCGjPniV
	 A858UrbBlZCnZZ0VvIM7HQtH0qX6bvzOM+SXc13GGmmOLYHswPf9LEfuJOl+5eOfcL
	 mMFxcta2ZG4XqIRBjxYXcoxSLUWRf1AgKLmQNY4zP7PizVlT3v+Q8pmqagDGHkNDYO
	 UenTOAsErGZzA==
Date: Fri, 06 Mar 2026 13:09:30 -1000
Message-ID: <af18f4873ed5d2ef606c55923acc1014@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 emil@etsalapatis.com
Subject: [PATCH v2 10/15] sched_ext: Add per-CPU data to DSQs
In-Reply-To: <20260306190623.1076074-11-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-11-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Add per-CPU data structure to dispatch queues. Each DSQ now has a percpu
scx_dsq_pcpu which contains a back-pointer to the DSQ. This will be used by
future changes to implement per-CPU reenqueue tracking for user DSQs.

init_dsq() now allocates the percpu data and can fail, so it returns an
error code. All callers are updated to handle failures. exit_dsq() is added
to free the percpu data and is called from all DSQ cleanup paths.

In scx_bpf_create_dsq(), init_dsq() is called before rcu_read_lock() since
alloc_percpu() requires GFP_KERNEL context, and dsq->sched is set
afterwards.

v2: Fix err_free_pcpu to only exit_dsq() initialized bypass DSQs (Andrea
    Righi).

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h |    5 ++
 kernel/sched/ext.c        |   87 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 77 insertions(+), 15 deletions(-)

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
@@ -4038,7 +4065,7 @@ static void free_dsq_irq_workfn(struct i
 	struct scx_dispatch_q *dsq, *tmp_dsq;

 	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
-		kfree_rcu(dsq, rcu);
+		call_rcu(&dsq->rcu, free_dsq_rcufn);
 }

 static DEFINE_IRQ_WORK(free_dsq_irq_work, free_dsq_irq_workfn);
@@ -4235,15 +4262,17 @@ static void scx_sched_free_rcu_work(stru
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

@@ -5799,7 +5831,10 @@ static struct scx_sched_pnode *alloc_pno
 	if (!pnode)
 		return NULL;

-	init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch);
+	if (init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch)) {
+		kfree(pnode);
+		return NULL;
+	}

 	return pnode;
 }
@@ -5810,7 +5845,7 @@ static struct scx_sched *scx_alloc_and_a
 {
 	struct scx_sched *sch;
 	s32 level = parent ? parent->level + 1 : 0;
-	s32 node, cpu, ret;
+	s32 node, cpu, ret, bypass_fail_cpu = nr_cpu_ids;

 	sch = kzalloc_flex(*sch, ancestors, level);
 	if (!sch)
@@ -5849,8 +5884,13 @@ static struct scx_sched *scx_alloc_and_a
 		goto err_free_pnode;
 	}

-	for_each_possible_cpu(cpu)
-		init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
+	for_each_possible_cpu(cpu) {
+		ret = init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
+		if (ret) {
+			bypass_fail_cpu = cpu;
+			goto err_free_pcpu;
+		}
+	}

 	for_each_possible_cpu(cpu) {
 		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
@@ -5932,6 +5972,11 @@ static struct scx_sched *scx_alloc_and_a
 err_stop_helper:
 	kthread_destroy_worker(sch->helper);
 err_free_pcpu:
+	for_each_possible_cpu(cpu) {
+		if (cpu == bypass_fail_cpu)
+			break;
+		exit_dsq(bypass_dsq(sch, cpu));
+	}
 	free_percpu(sch->pcpu);
 err_free_pnode:
 	for_each_node_state(node, N_POSSIBLE)
@@ -7174,7 +7219,7 @@ void __init init_sched_ext_class(void)
 		int  n = cpu_to_node(cpu);

 		/* local_dsq's sch will be set during scx_root_enable() */
-		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL);
+		BUG_ON(init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL));

 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
@@ -7873,11 +7918,21 @@ __bpf_kfunc s32 scx_bpf_create_dsq(u64 d
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
@@ -7885,8 +7940,10 @@ __bpf_kfunc s32 scx_bpf_create_dsq(u64 d
 	}

 	rcu_read_unlock();
-	if (ret)
+	if (ret) {
+		exit_dsq(dsq);
 		kfree(dsq);
+	}
 	return ret;
 }
