Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5437C115;
	Mon,  6 Jul 2026 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302077; cv=none; b=rclFZvOVSTOfoP72D31TBRSbaU+5JxRrWJ2NcMI8FiTc0TTqoMYmoxDxqugFgufQerFufEzfUn5wExbWVgwN0pvlRJBnS+LZvJ4zJIUHEP7HJKZkr6mYI0ASlYqXJBceCCpCV6ukWMqnKnPusUI9MoM2dnwZlW+Y0H0u4BTCERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302077; c=relaxed/simple;
	bh=w0ImiDOxTlb/npeCdpy/+VblruQr6nHqE43qkyeEbO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARCH1WAnVoDrYL6e8fhglqt8CioVuqtrDCx2aJ4Pd6xLUTzpGhQE/Zsti8RmlaZ3fBdd54YS1Cqgw40g+3iz6W9qtnKARBJJWMyBYS0xH5ytynYn5Q4GM9AAxe6BuWyjJZin6lgQm3X/n62oZy8M6na1it1UN/6TsVkHLqX5MQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/cU6gFO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/cU6gFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BED1F00A3A;
	Mon,  6 Jul 2026 01:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302073;
	bh=aA0ubIyNT6z82WAk4ZBwfzNsqJAhdZFnTqNXRrkVxoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H/cU6gFO31A/jbo7UYJTy2Bnd/rvgL8GYnqhyDEgX3dvdNgGGRcltj9rFdyW41U92
	 gWjdNgGQROFuLkryMTEkACkuFOfukU37PF2o1s/2Y8S37yB79/uaPDNKjRvsNd/Eh5
	 RM6mCAg9MYku3+SjUBjeEM1X+bv1YsOMtoakaUUzcfsQu6jxe+KcNopD93UUMFUqrV
	 Sm7qTfLiKF9Ye4wJ+l/1jOyaL0IAOGd078oqFeNLi00VkTmzIZ1n/n4Y61k56Y/hIN
	 mw5mLyGUA7EyU7y9yxSae5XuGITJHvzkQORUPjfASYKeX5K2HseTIKWuG/nH16mGdV
	 kJCwcwsEjCzCg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 14/36] sched_ext: Add per-shard scx_sched storage scaffolding
Date: Sun,  5 Jul 2026 15:40:36 -1000
Message-ID: <20260706014058.439853-15-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add struct scx_pshard and sch->pshard[] indexed by shard_idx, each entry
allocated on its shard's NUMA node from scx_shard_node[si]. The struct
starts empty (one dummy field). Follow-up patches will grow it as
shard-local state lands. Only cid-type schedulers with an arena pool get
pshards.

Allocation happens after ops.init_cids() returns so any
scx_bpf_cid_override() it issues has finalized scx_nr_cid_shards and
scx_shard_node[]. sch->nr_pshards records the array size for the async RCU
free path, which may run after a later scheduler's scx_cid_init() has
rewritten the global.

v2: Free the partially-allocated pshard array on alloc failure. (sashiko AI)

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  8 +++++++
 kernel/sched/ext/internal.h | 18 +++++++++++++++
 kernel/sched/ext/sub.c      | 46 +++++++++++++++++++++++++++++++++++++
 kernel/sched/ext/sub.h      |  4 ++++
 4 files changed, 76 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 340d1cf3630c..a5e782147bf4 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4644,6 +4644,8 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		free_pnode(sch->pnode[node]);
 	kfree(sch->pnode);
 
+	scx_free_pshards(sch);
+
 	rhashtable_walk_enter(&sch->dsq_hash, &rht_iter);
 	do {
 		rhashtable_walk_start(&rht_iter);
@@ -6722,6 +6724,12 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		goto err_disable;
 	}
 
+	ret = scx_alloc_pshards(sch);
+	if (ret) {
+		cpus_read_unlock();
+		goto err_disable;
+	}
+
 	if (sch->ops.init) {
 		ret = SCX_CALL_OP_RET(sch, init, NULL);
 		if (ret) {
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 61a9230265cd..dce07b83c166 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1183,6 +1183,12 @@ struct scx_sched_pnode {
 	struct scx_dispatch_q	global_dsq;
 };
 
+#ifdef CONFIG_EXT_SUB_SCHED
+struct scx_pshard {
+	int			_dummy;		/* until the first real field lands */
+};
+#endif
+
 struct scx_sched {
 	/*
 	 * cpu-form and cid-form ops share field offsets up to .priv (verified
@@ -1230,6 +1236,9 @@ struct scx_sched {
 	 */
 	struct rhashtable	dsq_hash;
 	struct scx_sched_pnode	**pnode;
+#ifdef CONFIG_EXT_SUB_SCHED
+	struct scx_pshard	**pshard;	/* indexed by shard_idx */
+#endif
 	struct scx_sched_pcpu __percpu *pcpu;
 
 	u64			slice_dfl;
@@ -1245,6 +1254,15 @@ struct scx_sched {
 	u32			dsp_max_batch;
 	s32			level;
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	/*
+	 * pshard[] size captured at enable for the async RCU free path -
+	 * scx_nr_cid_shards may be rewritten by a later scx_cid_init() before
+	 * free runs. While sch is active, use the global.
+	 */
+	u32			nr_pshards;
+#endif
+
 	/*
 	 * Updates to the following warned bitfields can race causing RMW issues
 	 * but it doesn't really matter.
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index e94a415ee10a..6d8b9bcf2f49 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -82,6 +82,52 @@ void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch)
 		rcu_assign_pointer(pos->scx_sched, sch);
 }
 
+static void free_pshard(struct scx_pshard *pshard)
+{
+	kfree(pshard);
+}
+
+void scx_free_pshards(struct scx_sched *sch)
+{
+	s32 si;
+
+	if (!sch->pshard)
+		return;
+	for (si = 0; si < sch->nr_pshards; si++)
+		free_pshard(sch->pshard[si]);
+	kfree(sch->pshard);
+}
+
+static struct scx_pshard *alloc_pshard(struct scx_sched *sch, s32 shard_idx, s32 node)
+{
+	return kzalloc_node(sizeof(struct scx_pshard), GFP_KERNEL, node);
+}
+
+s32 scx_alloc_pshards(struct scx_sched *sch)
+{
+	s32 si;
+
+	if (!sch->is_cid_type || !sch->arena_pool)
+		return 0;
+
+	sch->pshard = kzalloc_objs(sch->pshard[0], scx_nr_cid_shards, GFP_KERNEL);
+	if (!sch->pshard)
+		return -ENOMEM;
+
+	sch->nr_pshards = scx_nr_cid_shards;
+
+	for (si = 0; si < scx_nr_cid_shards; si++) {
+		sch->pshard[si] = alloc_pshard(sch, si, scx_shard_node[si]);
+		if (!sch->pshard[si]) {
+			/* drop the partial array so the !pshard cap guards hold */
+			scx_free_pshards(sch);
+			sch->pshard = NULL;
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
 static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
 
 void drain_descendants(struct scx_sched *sch)
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 460a9fd196dc..9fa6b5c8be23 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -24,6 +24,8 @@ void drain_descendants(struct scx_sched *sch);
 void scx_sub_disable(struct scx_sched *sch);
 void scx_sub_enable_workfn(struct kthread_work *work);
 bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *aux);
+void scx_free_pshards(struct scx_sched *sch);
+s32 scx_alloc_pshards(struct scx_sched *sch);
 
 #else	/* CONFIG_EXT_SUB_SCHED */
 
@@ -33,6 +35,8 @@ static inline struct cgroup *sch_cgroup(struct scx_sched *sch) { return NULL; }
 static inline void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch) {}
 static inline void drain_descendants(struct scx_sched *sch) { }
 static inline void scx_sub_disable(struct scx_sched *sch) { }
+static inline void scx_free_pshards(struct scx_sched *sch) {}
+static inline s32 scx_alloc_pshards(struct scx_sched *sch) { return 0; }
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
-- 
2.54.0

