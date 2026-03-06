Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318D40F8DA;
	Fri,  6 Mar 2026 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823986; cv=none; b=WDNsVrwREQ/UktJce9v1oOJlxxkh67P3VotB4cVDTY/wVTCGRZKcGe4TODuyZDvQ1Y5HhRnyhq6Zgs/AbTeh0tStkDaFRh46YY5//6YTI9WPX/fz/oCFsm8HmVjWABHSWS36qACnUrbjgzVGWjh+dJv/mF0edSIHLDDBdAQl8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823986; c=relaxed/simple;
	bh=MzwsQHLvwckxw+G1+vOzyuuoFe6/vw3VO/Ld23sHi/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsf14PAi4NqId3JsBNDwtcCIVnW5A/VpOkBLcxBfGaftiy2RfnF5YN+kGftqd9E0UqhnYdPfelp6c65TWCEv234BdpNQRiMGbnXBiWuKT08gAcdyCCNJcUOzDlqNNXJ8qt8HJvjtlv9RA9xwlJqXQyR5pypiJRFJJEHPpVQfqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZQW9I2c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZQW9I2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B78DC4CEF7;
	Fri,  6 Mar 2026 19:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823986;
	bh=MzwsQHLvwckxw+G1+vOzyuuoFe6/vw3VO/Ld23sHi/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZQW9I2coebozjDUghVPAHuR2y7vNOQy0SwE0rRUpDTbUg2RO/l6v0UeNTMzSK9BD
	 9X8Xyph1NBwnng8E6GoYe75OLR9HXRd5Hwa7jBiuhU+e/9vIuIr5ADxfRnEpiGu1FV
	 qyTPcyJWmQVW33BOlSrXRAPro9qdIKAzMaz/ftZj0VigwfK7lrp1g0+IpgEH3OpAmL
	 cFlKD4EcQ7g5avStbrKm5zQFAKGcRzNZzIBHDc12Jj9zJfoXbNZMk0201MmvbqztBq
	 lIv59ytcKu+3mlc4ZMgJZfz4vDYlleULstAPHAusQhwuglQR5SVEKegZ1OM6//p8S+
	 eLXirk3G/N4zA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/15] sched_ext: Wrap global DSQs in per-node structure
Date: Fri,  6 Mar 2026 09:06:10 -1000
Message-ID: <20260306190623.1076074-3-tj@kernel.org>
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

Global DSQs are currently stored as an array of scx_dispatch_q pointers,
one per NUMA node. To allow adding more per-node data structures, wrap the
global DSQ in scx_sched_pnode and replace global_dsqs with pnode array.

NUMA-aware allocation is maintained. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 32 ++++++++++++++++----------------
 kernel/sched/ext_internal.h |  6 +++++-
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fe222df1d494..9232abea4f22 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -344,7 +344,7 @@ static bool scx_is_descendant(struct scx_sched *sch, struct scx_sched *ancestor)
 static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch,
 					      struct task_struct *p)
 {
-	return sch->global_dsqs[cpu_to_node(task_cpu(p))];
+	return &sch->pnode[cpu_to_node(task_cpu(p))]->global_dsq;
 }
 
 static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
@@ -2229,7 +2229,7 @@ static bool consume_global_dsq(struct scx_sched *sch, struct rq *rq)
 {
 	int node = cpu_to_node(cpu_of(rq));
 
-	return consume_dispatch_q(sch, rq, sch->global_dsqs[node]);
+	return consume_dispatch_q(sch, rq, &sch->pnode[node]->global_dsq);
 }
 
 /**
@@ -4148,8 +4148,8 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	free_percpu(sch->pcpu);
 
 	for_each_node_state(node, N_POSSIBLE)
-		kfree(sch->global_dsqs[node]);
-	kfree(sch->global_dsqs);
+		kfree(sch->pnode[node]);
+	kfree(sch->pnode);
 
 	rhashtable_walk_enter(&sch->dsq_hash, &rht_iter);
 	do {
@@ -5707,23 +5707,23 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	if (ret < 0)
 		goto err_free_ei;
 
-	sch->global_dsqs = kzalloc_objs(sch->global_dsqs[0], nr_node_ids);
-	if (!sch->global_dsqs) {
+	sch->pnode = kzalloc_objs(sch->pnode[0], nr_node_ids);
+	if (!sch->pnode) {
 		ret = -ENOMEM;
 		goto err_free_hash;
 	}
 
 	for_each_node_state(node, N_POSSIBLE) {
-		struct scx_dispatch_q *dsq;
+		struct scx_sched_pnode *pnode;
 
-		dsq = kzalloc_node(sizeof(*dsq), GFP_KERNEL, node);
-		if (!dsq) {
+		pnode = kzalloc_node(sizeof(*pnode), GFP_KERNEL, node);
+		if (!pnode) {
 			ret = -ENOMEM;
-			goto err_free_gdsqs;
+			goto err_free_pnode;
 		}
 
-		init_dsq(dsq, SCX_DSQ_GLOBAL, sch);
-		sch->global_dsqs[node] = dsq;
+		init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch);
+		sch->pnode[node] = pnode;
 	}
 
 	sch->dsp_max_batch = ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH;
@@ -5732,7 +5732,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 				   __alignof__(struct scx_sched_pcpu));
 	if (!sch->pcpu) {
 		ret = -ENOMEM;
-		goto err_free_gdsqs;
+		goto err_free_pnode;
 	}
 
 	for_each_possible_cpu(cpu)
@@ -5819,10 +5819,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	kthread_destroy_worker(sch->helper);
 err_free_pcpu:
 	free_percpu(sch->pcpu);
-err_free_gdsqs:
+err_free_pnode:
 	for_each_node_state(node, N_POSSIBLE)
-		kfree(sch->global_dsqs[node]);
-	kfree(sch->global_dsqs);
+		kfree(sch->pnode[node]);
+	kfree(sch->pnode);
 err_free_hash:
 	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
 err_free_ei:
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 4cb97093b872..9e5ebd00ea0c 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -975,6 +975,10 @@ struct scx_sched_pcpu {
 	struct scx_dsp_ctx	dsp_ctx;
 };
 
+struct scx_sched_pnode {
+	struct scx_dispatch_q	global_dsq;
+};
+
 struct scx_sched {
 	struct sched_ext_ops	ops;
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
@@ -988,7 +992,7 @@ struct scx_sched {
 	 * per-node split isn't sufficient, it can be further split.
 	 */
 	struct rhashtable	dsq_hash;
-	struct scx_dispatch_q	**global_dsqs;
+	struct scx_sched_pnode	**pnode;
 	struct scx_sched_pcpu __percpu *pcpu;
 
 	u64			slice_dfl;
-- 
2.53.0

