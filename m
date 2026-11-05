Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859410;
	b=CzTPrlGwMUPNXRiQ8jZ0m6K1wZjQeqlChcIwigl5OSgvjda5zDPUnb18EqNQerIBsLdO
	 slamBlyvx2saTIxB5zowdkM6g1pBeIzAJ80FveLhyh/kxLYvbCeBMBgSWYnuCqjlJdUYF
	 3xEqn3rmeWNt1FA35xl4P4M07R91imRnIy9W55HLrXpgyeRzuJa9/H78X2M9lR8aEdMRl
	 o9uUju/CPurRKv8HE8a6Dq+S3KxCI1dUUxaxNqEKrv/m0fjxGZqOZlHPtHTIfiC0bAFkb
	 Y7mp85lck0+O7JNnU2rh0/PZxQnB2yhtNeVvEXAyGmEMsG74BT19kaJbiHUvBxSiipA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859410;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=/pT5bB/iqBe4l8xXdonjO3NcFwU6d+FBzgM1+k2Uspw=;
	b=35DTC0w6UwJrDDr+5zT88cJ1Ked+k46KNEsyDtBd12gonGwR8M5WYqT0N/6+mIh9RHLP
	 sEkG0WlrbsiXIl/2r0Gaqp0SlQiitSPOmD6Oj/4+QAmlgUQPL1usrwCEjbxzBzyj62lQh
	 AsjQzVLfJUZ1hzSfS7CTtSv0FINmcHxOpIVAV7Z0xEURPlYJm1GiJDtOHjlT7u1XhOO1W
	 v7UgKJCgeCY3XmU46uVoAjMmJ1zwlgY8Y1Vibj/jledpDGEpiyKGbn7Yy6UzBxGfkeMC2
	 g7jKeVCbg+hoglNWoKPCBnUnzoCC+wmnoiMO+pZFRXkQfAbu5BfiZ4+N49pK2Ot6MTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WY3UFdPS;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C28606A31B
	for <sched-ext@lists.linux.dev>; Thu,  5 Nov 2026 06:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33C28606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WY3UFdPS
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/pT5bB/iqBe4l8xXdonjO3NcFwU6d+FBzgM1+k2Uspw=;
	b=WY3UFdPSDZUhxcTP+d0UxKZiHe8E/UkqazYLa4ex5i80mJLSYv0vu6SV1zr2JkRm0QQ4BBq2s
	mndno3jhK6REfiSLcX7IHPoMt8Ax5JBq6/uqS9ZjrsaKHDHjJEeZQkI2BMFr87wD+RZe2ZGoD4U
	XutJ7EmQGe5ou+fOeQqPnwg=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jKsWh04cdzcb1H;
	Thu,  5 Nov 2026 14:16:16 +0800 (CST)
Received: from kwepemk300016.china.huawei.com (unknown [7.202.195.98])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D6C24058F;
	Thu,  5 Nov 2026 14:16:44 +0800 (CST)
Received: from huawei.com (10.67.174.191) by kwepemk300016.china.huawei.com
 (7.202.195.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 14:16:43 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <sched-ext@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <tj@kernel.org>, <void@manifault.com>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <tanghui22@huawei.com>,
	<zhangqiao22@huawei.com>
Subject: [PATCH 3/4] sched_ext: Extract construction of a single LLC CID range
Date: Thu, 5 Nov 2026 14:50:12 +0800
Message-ID: <20261105065013.784398-4-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261105065013.784398-1-zhangqiao22@huawei.com>
References: <20261105065013.784398-1-zhangqiao22@huawei.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk300016.china.huawei.com (7.202.195.98)

Extract the per-LLC walk into scx_cid_build_llc(), which consumes one
LLC worth of cpus from b->node_scratch and appends their cores,
clusters and shards. All per-LLC state - the llc cid and index, the
shard layout counters and the cluster carry - is local to the helper;
cross-LLC state stays in the builder.

The two WARN_ON_ONCE checks now return -EINVAL to the caller instead
of returning straight out of scx_cid_init(); the value and its effect
on the error path are unchanged.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/ext/cid.c | 206 ++++++++++++++++++++++-------------------
 1 file changed, 109 insertions(+), 97 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index ee55f101e5c5..54eacdc23d32 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -180,6 +180,110 @@ struct scx_cid_builder {
 	u32 shard_size, max_cids;
 };
 
+static s32 scx_cid_build_llc(struct scx_cid_builder *b, s32 nid,
+			     s32 node_cid, s32 node_idx)
+{
+	s32 ncpu = cpumask_first(b->node_scratch);
+	const struct cpumask *llc_mask = cpu_llc_mask(ncpu, b->llc_fallback);
+	s32 llc_cid = b->next_cid;
+	s32 llc_idx = b->next_llc_idx++;
+	u32 cores_per_shard, nr_large;
+	u32 shard_local = 0, cores_in_shard = 0, cids_in_shard = 0;
+	s32 shard_cid, shard_idx;
+	s32 cluster_cid = -1, cluster_idx = -1;
+
+	/* b->llc_scratch = b->node_scratch & this llc */
+	cpumask_and(b->llc_scratch, b->node_scratch, llc_mask);
+	if (WARN_ON_ONCE(!cpumask_test_cpu(ncpu, b->llc_scratch)))
+		return -EINVAL;
+
+	calc_shard_layout(b->llc_scratch, b->shard_size, &cores_per_shard, &nr_large);
+	shard_cid = b->next_cid;
+	shard_idx = b->next_shard_idx++;
+	b->tbls->shard_node[shard_idx] = nid;
+
+	while (!cpumask_empty(b->llc_scratch)) {
+		const struct cpumask *sib;
+		s32 core_cid, core_idx, lcpu, ccpu;
+		u32 max_cores, cids_in_core;
+
+		/*
+		 * Take the cores of one cluster before moving
+		 * on, so that a cluster is a contiguous cid
+		 * range like the core, LLC and node levels.
+		 */
+		if (cpumask_empty(b->cluster_scratch)) {
+			s32 xcpu = cpumask_first(b->llc_scratch);
+
+			cpumask_or(b->cluster_scratch,
+				   topology_cluster_cpumask(xcpu),
+				   topology_sibling_cpumask(xcpu));
+			cpumask_and(b->cluster_scratch, b->cluster_scratch,
+				    b->llc_scratch);
+			cluster_cid = b->next_cid;
+			cluster_idx = b->next_cluster_idx++;
+		}
+
+		lcpu = cpumask_first(b->cluster_scratch);
+		sib = topology_sibling_cpumask(lcpu);
+		core_cid = b->next_cid;
+		core_idx = b->next_core_idx++;
+
+		/* b->core_scratch = b->cluster_scratch & this core */
+		cpumask_and(b->core_scratch, b->cluster_scratch, sib);
+		if (WARN_ON_ONCE(!cpumask_test_cpu(lcpu, b->core_scratch)))
+			return -EINVAL;
+
+		/*
+		 * Advance to a new shard when either core or
+		 * cid count reaches max. The latter bounds
+		 * shard sizes under uneven SMT. Never start an
+		 * empty shard.
+		 */
+		cids_in_core = cpumask_weight(b->core_scratch);
+		max_cores = cores_per_shard + (shard_local < nr_large ? 1 : 0);
+		if (cores_in_shard &&
+		    (cores_in_shard >= max_cores ||
+		     cids_in_shard + cids_in_core > b->max_cids)) {
+			shard_local++;
+			cores_in_shard = 0;
+			cids_in_shard = 0;
+			shard_cid = b->next_cid;
+			shard_idx = b->next_shard_idx++;
+			b->tbls->shard_node[shard_idx] = nid;
+		}
+		cores_in_shard++;
+		cids_in_shard += cids_in_core;
+
+		for_each_cpu(ccpu, b->core_scratch) {
+			s32 cid = b->next_cid++;
+
+			b->tbls->cid_to_cpu[cid] = ccpu;
+			b->tbls->cpu_to_cid[ccpu] = cid;
+			b->tbls->cid_to_shard[cid] = shard_idx;
+			b->tbls->topo[cid] = (struct scx_cid_topo){
+				.core_cid = core_cid,
+				.core_idx = core_idx,
+				.llc_cid = llc_cid,
+				.llc_idx = llc_idx,
+				.node_cid = node_cid,
+				.node_idx = node_idx,
+				.shard_cid = shard_cid,
+				.shard_idx = shard_idx,
+				.cluster_cid = cluster_cid,
+				.cluster_idx = cluster_idx,
+			};
+
+			cpumask_clear_cpu(ccpu, b->cluster_scratch);
+			cpumask_clear_cpu(ccpu, b->llc_scratch);
+			cpumask_clear_cpu(ccpu, b->node_scratch);
+			cpumask_clear_cpu(ccpu, b->to_walk);
+		}
+	}
+
+	return 0;
+}
+
 static void scx_cid_build_notopo(struct scx_cid_builder *b)
 {
 	u32 notopo_in_shard;
@@ -333,103 +437,11 @@ s32 scx_cid_init(struct scx_sched *sch)
 			return -EINVAL;
 
 		while (!cpumask_empty(b.node_scratch)) {
-			s32 ncpu = cpumask_first(b.node_scratch);
-			const struct cpumask *llc_mask = cpu_llc_mask(ncpu, b.llc_fallback);
-			s32 llc_cid = b.next_cid;
-			s32 llc_idx = b.next_llc_idx++;
-			u32 cores_per_shard, nr_large;
-			u32 shard_local = 0, cores_in_shard = 0, cids_in_shard = 0;
-			s32 shard_cid, shard_idx;
-			s32 cluster_cid = -1, cluster_idx = -1;
-
-			/* b.llc_scratch = b.node_scratch & this llc */
-			cpumask_and(b.llc_scratch, b.node_scratch, llc_mask);
-			if (WARN_ON_ONCE(!cpumask_test_cpu(ncpu, b.llc_scratch)))
-				return -EINVAL;
-
-			calc_shard_layout(b.llc_scratch, b.shard_size, &cores_per_shard, &nr_large);
-			shard_cid = b.next_cid;
-			shard_idx = b.next_shard_idx++;
-			b.tbls->shard_node[shard_idx] = nid;
-
-			while (!cpumask_empty(b.llc_scratch)) {
-				const struct cpumask *sib;
-				s32 core_cid, core_idx, lcpu, ccpu;
-				u32 max_cores, cids_in_core;
-
-				/*
-				 * Take the cores of one cluster before moving
-				 * on, so that a cluster is a contiguous cid
-				 * range like the core, LLC and node levels.
-				 */
-				if (cpumask_empty(b.cluster_scratch)) {
-					s32 xcpu = cpumask_first(b.llc_scratch);
-
-					cpumask_or(b.cluster_scratch,
-						   topology_cluster_cpumask(xcpu),
-						   topology_sibling_cpumask(xcpu));
-					cpumask_and(b.cluster_scratch, b.cluster_scratch,
-						    b.llc_scratch);
-					cluster_cid = b.next_cid;
-					cluster_idx = b.next_cluster_idx++;
-				}
-
-				lcpu = cpumask_first(b.cluster_scratch);
-				sib = topology_sibling_cpumask(lcpu);
-				core_cid = b.next_cid;
-				core_idx = b.next_core_idx++;
-
-				/* b.core_scratch = b.cluster_scratch & this core */
-				cpumask_and(b.core_scratch, b.cluster_scratch, sib);
-				if (WARN_ON_ONCE(!cpumask_test_cpu(lcpu, b.core_scratch)))
-					return -EINVAL;
-
-				/*
-				 * Advance to a new shard when either core or
-				 * cid count reaches max. The latter bounds
-				 * shard sizes under uneven SMT. Never start an
-				 * empty shard.
-				 */
-				cids_in_core = cpumask_weight(b.core_scratch);
-				max_cores = cores_per_shard + (shard_local < nr_large ? 1 : 0);
-				if (cores_in_shard &&
-				    (cores_in_shard >= max_cores ||
-				     cids_in_shard + cids_in_core > b.max_cids)) {
-					shard_local++;
-					cores_in_shard = 0;
-					cids_in_shard = 0;
-					shard_cid = b.next_cid;
-					shard_idx = b.next_shard_idx++;
-					b.tbls->shard_node[shard_idx] = nid;
-				}
-				cores_in_shard++;
-				cids_in_shard += cids_in_core;
-
-				for_each_cpu(ccpu, b.core_scratch) {
-					s32 cid = b.next_cid++;
-
-					b.tbls->cid_to_cpu[cid] = ccpu;
-					b.tbls->cpu_to_cid[ccpu] = cid;
-					b.tbls->cid_to_shard[cid] = shard_idx;
-					b.tbls->topo[cid] = (struct scx_cid_topo){
-						.core_cid = core_cid,
-						.core_idx = core_idx,
-						.llc_cid = llc_cid,
-						.llc_idx = llc_idx,
-						.node_cid = node_cid,
-						.node_idx = node_idx,
-						.shard_cid = shard_cid,
-						.shard_idx = shard_idx,
-						.cluster_cid = cluster_cid,
-						.cluster_idx = cluster_idx,
-					};
-
-					cpumask_clear_cpu(ccpu, b.cluster_scratch);
-					cpumask_clear_cpu(ccpu, b.llc_scratch);
-					cpumask_clear_cpu(ccpu, b.node_scratch);
-					cpumask_clear_cpu(ccpu, b.to_walk);
-				}
-			}
+			s32 ret;
+
+			ret = scx_cid_build_llc(&b, nid, node_cid, node_idx);
+			if (ret)
+				return ret;
 		}
 	}
 
-- 
2.43.0

