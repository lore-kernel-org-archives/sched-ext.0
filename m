Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859412;
	b=dUW6Z9wcQLA1O9FB8x/yaDscpWO+td5ANIwkI2dzp3YYVkHeCRAIfnmDjCn4byt5uzT0
	 4kCMbxrLrtnEfOC0GtDMM0ZrKxqZGDX4aUyWhDY6gxQPa3206zdfoGIAIhCtUOEKj7DwS
	 bj0ta3KoXRNN/wVV7ueaqhx4KcWG5CZw0Ikjh2NR9zxqguKJThnVSoOZZvNnPDQXRnRxs
	 56xg6eqi1vXaDWNbF2beC97h17eK/kIiTxkWVocKhd3ZKT46IXUBXiOlai4FTV/tKt2/j
	 LsRyt5hDYPvmPoTaaOaL4nYJKggTMCrVZjWTi9NtBPeeNMi331/9TsSJUG0W3JHllJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859412;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=KOzW1UB+t+jEelbcYPH5TbAEq94n39ZkhHY9cRiwXeo=;
	b=OqsJlmxJqIZqwXo65mNwS3Usuammwb6J828nSExhySw0nOwU6rHpxozKABKB9Fy1Mrmi
	 tAU+CwFmYdHZQ+0ynbQmWi+Lm2BVhmB9qEE+KkevEnpMrWdZsWWP+QGdwX3/TAS7TS7dl
	 hYyDn+uCr+0s82xoXSkRjBU2ahWqp3bgKgHNXL4GZL6QiibXDJF5H+km2CdH8tGb4MYbD
	 yGG15K11VygVjtbQXtTf4r8vHNPC6XRWnk9nLA1xS2lytHgHegpAEAwlQSeM0SBfUT63E
	 nSig3ISHOnoo/ao0CyYPNXU3pBTB6E+I2hmKpsKUhkDEYJr9nltBM9+AS58TGpibFQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zpsT+AuA;
	arc=none smtp.remote-ip=113.46.200.221
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF2606A32E
	for <sched-ext@lists.linux.dev>; Thu,  5 Nov 2026 06:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25CF2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zpsT+AuA
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KOzW1UB+t+jEelbcYPH5TbAEq94n39ZkhHY9cRiwXeo=;
	b=zpsT+AuATWaQqVRa280d9OUqsdIn4rFnA3HnMKREtwqLUlsLzdAclJTRMeviQLiTw2dHHMZ5/
	eTvy73Jc4eWuGpT90RVqYpez1wUD90XUueMmre6mOR2ZB2zoxqbRmfVRFKui8wh5zIhJ4m3o/rQ
	qEzIVh9CTlIXeCSmS1lbOHY=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jKsX56XfQzRhSB;
	Thu,  5 Nov 2026 14:16:37 +0800 (CST)
Received: from kwepemk300016.china.huawei.com (unknown [7.202.195.98])
	by mail.maildlp.com (Postfix) with ESMTPS id AA6744058F;
	Thu,  5 Nov 2026 14:16:44 +0800 (CST)
Received: from huawei.com (10.67.174.191) by kwepemk300016.china.huawei.com
 (7.202.195.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 14:16:44 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <sched-ext@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <tj@kernel.org>, <void@manifault.com>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <tanghui22@huawei.com>,
	<zhangqiao22@huawei.com>
Subject: [PATCH 4/4] sched_ext: Extract online CID construction from scx_cid_init
Date: Thu, 5 Nov 2026 14:50:13 +0800
Message-ID: <20261105065013.784398-5-zhangqiao22@huawei.com>
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

Move the node walk into scx_cid_build_online() so scx_cid_init() is
left with allocation, diagnostics and cleanup only. Document the
builder's mask ownership and add one-line summaries for the traversal
helpers.

The mapping, shard policy, publication timing and error paths are
unchanged. Partial-SMT core counting and the single-core shard
hard-cap corner case are left for separate fixes.

Validation: compiled kernel/sched/build_policy.o with SCHED_CLASS_EXT
enabled and CPUMASK_OFFSTACK both disabled and enabled. A temporary C
harness compared all construction stages against the original across
1800 topology/shard-size combinations and checked seven mask
allocation failure paths under UBSan. Each patch passes strict
checkpatch.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/ext/cid.c | 90 ++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index 54eacdc23d32..688008823355 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -165,6 +165,7 @@ void scx_cid_retire_tables(void)
 	call_rcu(&tbls->rcu, scx_cid_tables_free_rcufn);
 }
 
+/* Build-only state. The masks are borrowed from scx_cid_init(). */
 struct scx_cid_builder {
 	struct scx_cid_tables *tbls;
 	struct cpumask *to_walk;
@@ -180,6 +181,7 @@ struct scx_cid_builder {
 	u32 shard_size, max_cids;
 };
 
+/* Consume one LLC from node_scratch and append its cids and shards. */
 static s32 scx_cid_build_llc(struct scx_cid_builder *b, s32 nid,
 			     s32 node_cid, s32 node_idx)
 {
@@ -192,7 +194,7 @@ static s32 scx_cid_build_llc(struct scx_cid_builder *b, s32 nid,
 	s32 shard_cid, shard_idx;
 	s32 cluster_cid = -1, cluster_idx = -1;
 
-	/* b->llc_scratch = b->node_scratch & this llc */
+	/* Intersect the remaining node CPUs with this LLC. */
 	cpumask_and(b->llc_scratch, b->node_scratch, llc_mask);
 	if (WARN_ON_ONCE(!cpumask_test_cpu(ncpu, b->llc_scratch)))
 		return -EINVAL;
@@ -229,7 +231,7 @@ static s32 scx_cid_build_llc(struct scx_cid_builder *b, s32 nid,
 		core_cid = b->next_cid;
 		core_idx = b->next_core_idx++;
 
-		/* b->core_scratch = b->cluster_scratch & this core */
+		/* Intersect the remaining cluster CPUs with this core. */
 		cpumask_and(b->core_scratch, b->cluster_scratch, sib);
 		if (WARN_ON_ONCE(!cpumask_test_cpu(lcpu, b->core_scratch)))
 			return -EINVAL;
@@ -284,6 +286,45 @@ static s32 scx_cid_build_llc(struct scx_cid_builder *b, s32 nid,
 	return 0;
 }
 
+/* Assign online CPUs by node, consuming to_walk as CPUs get their cids. */
+static s32 scx_cid_build_online(struct scx_cid_builder *b)
+{
+	cpumask_copy(b->to_walk, cpu_online_mask);
+
+	while (!cpumask_empty(b->to_walk)) {
+		s32 next_cpu = cpumask_first(b->to_walk);
+		s32 nid = cpu_to_node(next_cpu);
+		s32 node_cid = b->next_cid;
+		s32 node_idx;
+
+		/*
+		 * No NUMA info: skip and let scx_cid_build_notopo() assign a
+		 * no-topo cid. cpumask_of_node(-1) is undefined.
+		 */
+		if (nid < 0) {
+			cpumask_clear_cpu(next_cpu, b->to_walk);
+			continue;
+		}
+
+		node_idx = b->next_node_idx++;
+
+		/* Intersect the remaining online CPUs with this node. */
+		cpumask_and(b->node_scratch, b->to_walk, cpumask_of_node(nid));
+		if (WARN_ON_ONCE(!cpumask_test_cpu(next_cpu, b->node_scratch)))
+			return -EINVAL;
+
+		while (!cpumask_empty(b->node_scratch)) {
+			s32 ret;
+
+			ret = scx_cid_build_llc(b, nid, node_cid, node_idx);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static void scx_cid_build_notopo(struct scx_cid_builder *b)
 {
 	u32 notopo_in_shard;
@@ -292,10 +333,10 @@ static void scx_cid_build_notopo(struct scx_cid_builder *b)
 
 	/*
 	 * No-topo section: any possible cpu without a cid - normally just the
-	 * not-online ones. Pack into shards of up to min(@b->shard_size,
+	 * not-online ones. Pack into shards of up to min(b->shard_size,
 	 * SCX_CID_SHARD_MAX_CPUS) cids so that every cid has a valid shard
-	 * assignment and the hard cap holds even with a large @b->shard_size.
-	 * Collect any currently-online cpus that land here in @b->online_no_topo
+	 * assignment and the hard cap holds even with a large b->shard_size.
+	 * Collect any currently-online cpus that land here in b->online_no_topo
 	 * so we can warn about them at the end.
 	 */
 	notopo_in_shard = min_t(u32, b->shard_size, SCX_CID_SHARD_MAX_CPUS);
@@ -348,7 +389,7 @@ static void scx_cid_finalize_tables(struct scx_cid_builder *b)
 
 /**
  * scx_cid_init - build the cid mapping
- * @sch: the scx_sched being initialized; used as the scx_error() target
+ * @sch: scheduler whose ops specify the target shard size
  *
  * Build a fresh table set. It becomes visible through scx_cid_publish_tables()
  * and is retired by scx_cid_retire_tables() at disable.
@@ -370,7 +411,7 @@ s32 scx_cid_init(struct scx_sched *sch)
 	cpumask_var_t online_no_topo __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	struct scx_cid_tables *tbls;
 	struct scx_cid_builder b = {};
-	s32 cpu, si;
+	s32 cpu, si, ret;
 
 	/* CMASK_MAX_WORDS in cid.bpf.h covers NR_CPUS up to 8192 */
 	BUILD_BUG_ON(NR_CPUS > 8192);
@@ -412,38 +453,9 @@ s32 scx_cid_init(struct scx_sched *sch)
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
 		tbls->cpu_to_cid[cpu] = -1;
 
-	cpumask_copy(b.to_walk, cpu_online_mask);
-
-	while (!cpumask_empty(b.to_walk)) {
-		s32 next_cpu = cpumask_first(b.to_walk);
-		s32 nid = cpu_to_node(next_cpu);
-		s32 node_cid = b.next_cid;
-		s32 node_idx;
-
-		/*
-		 * No NUMA info: skip and let the tail loop assign a no-topo
-		 * cid. cpumask_of_node(-1) is undefined.
-		 */
-		if (nid < 0) {
-			cpumask_clear_cpu(next_cpu, b.to_walk);
-			continue;
-		}
-
-		node_idx = b.next_node_idx++;
-
-		/* b.node_scratch = b.to_walk & this node */
-		cpumask_and(b.node_scratch, b.to_walk, cpumask_of_node(nid));
-		if (WARN_ON_ONCE(!cpumask_test_cpu(next_cpu, b.node_scratch)))
-			return -EINVAL;
-
-		while (!cpumask_empty(b.node_scratch)) {
-			s32 ret;
-
-			ret = scx_cid_build_llc(&b, nid, node_cid, node_idx);
-			if (ret)
-				return ret;
-		}
-	}
+	ret = scx_cid_build_online(&b);
+	if (ret)
+		return ret;
 
 	scx_cid_build_notopo(&b);
 
-- 
2.43.0

