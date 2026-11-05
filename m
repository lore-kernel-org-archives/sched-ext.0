Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859412;
	b=VSE876ZsDINhZ68dtKfrHNZilWGBG2QYFSSPIC/YFxbkEroeOubexJw/rQgLRReDSOF5
	 LVNnC369JSHfZiroBgt5RXNrr+HmuuG+PmBhCUhENLc7wsrSoZzwiKbGW0HZamHn3TkZz
	 VjpN0Ixwy8uzu20Odi6nVv6+eOvpGEnfsEq2B0uh+tisbSA1XwmTkOvHC8CW4CToaOdSS
	 dvioD/FzG4YUhA03b7sufkBUBz3lrPAyjysdznIz0eWH1tvlOpbu1nvoRTn1kOVzusY1c
	 mHypILGGzxxs+We0rop43xUS6M6zrxV6Yn9pE2qxrILPFCxLFo8TCZtOyWMlY1SsSVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859412;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=oamRUV5Tzl45yO4Nrq85G79i+IntLzWp4w5J3i/wSbk=;
	b=4ZGyA301DiK6dFwcQXKxWIw6XuM8o1fiDZinreyN7paOZPTiKEAXxIg0Tfz+nNXWhqM3
	 qvp+9x+s2kjd2GMXUWHoNZTDg5QKfszLVMakErYYQhtjxWo7f9hKLeoS1wGFh5gDefBR/
	 WH/MKE28mbOn7SJEl+3WcpGwxQlLZN1DbDeyb9JJ2gWHNhDpealCXA3i4wBlE/Z/LcKxv
	 hQQbbO1QGKQagtCilzI7vr8j4nfjbi/pPOKnweV7ky96qw2PI/8TkRcIHgFQbpd0J5cF/
	 iESC6BCs69p3C1jI3GHtGVriCdMIJTjcVjxvQwkyOg8czxtpTL4VNZxMRSlrIw50ysA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SfzUU3eT;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB55606A32F
	for <sched-ext@lists.linux.dev>; Thu,  5 Nov 2026 06:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB55606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SfzUU3eT
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oamRUV5Tzl45yO4Nrq85G79i+IntLzWp4w5J3i/wSbk=;
	b=SfzUU3eTeKaFchkHZZ6rlCQH9y2BuZcfyG60w1LhFxr19JX3f+aflevkG4yTGickl9fO0O2jz
	K8wAbkrVOTL9GVBuNuK+Ez/CiSaCJzqBxlumchNqXMYiEWiwQEoMQXe9ucqRBSPpscbQaaGYJ8A
	Uct9aYJ3LcKcxXOopUutT1A=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jKsX02ymXz1cyVM;
	Thu,  5 Nov 2026 14:16:32 +0800 (CST)
Received: from kwepemk300016.china.huawei.com (unknown [7.202.195.98])
	by mail.maildlp.com (Postfix) with ESMTPS id 197B14056C;
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
Subject: [PATCH 2/4] sched_ext: Collect CID construction state in a private builder
Date: Thu, 5 Nov 2026 14:50:11 +0800
Message-ID: <20261105065013.784398-3-zhangqiao22@huawei.com>
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

The running counters and scratch masks are about to cross function
boundaries in both directions, which would grow the parameter lists of
every subsequent extraction step. Collect the build-only state instead
- the under-construction tables, the seven scratch masks borrowed from
scx_cid_init() and the running cid and index counters - in a
file-private scx_cid_builder and thread it through the stages
extracted so far.

No behavior change.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/ext/cid.c | 188 ++++++++++++++++++++++-------------------
 1 file changed, 103 insertions(+), 85 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index b6be8806a7d5..ee55f101e5c5 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -165,9 +165,22 @@ void scx_cid_retire_tables(void)
 	call_rcu(&tbls->rcu, scx_cid_tables_free_rcufn);
 }
 
-static void scx_cid_build_notopo(struct scx_cid_tables *tbls, u32 shard_size,
-				 u32 *next_cid, s32 *next_shard_idx,
-				 struct cpumask *online_no_topo)
+struct scx_cid_builder {
+	struct scx_cid_tables *tbls;
+	struct cpumask *to_walk;
+	struct cpumask *node_scratch;
+	struct cpumask *llc_scratch;
+	struct cpumask *cluster_scratch;
+	struct cpumask *core_scratch;
+	struct cpumask *llc_fallback;
+	struct cpumask *online_no_topo;
+	u32 next_cid;
+	s32 next_node_idx, next_llc_idx, next_core_idx;
+	s32 next_cluster_idx, next_shard_idx;
+	u32 shard_size, max_cids;
+};
+
+static void scx_cid_build_notopo(struct scx_cid_builder *b)
 {
 	u32 notopo_in_shard;
 	s32 notopo_shard_cid, notopo_shard_idx;
@@ -175,42 +188,41 @@ static void scx_cid_build_notopo(struct scx_cid_tables *tbls, u32 shard_size,
 
 	/*
 	 * No-topo section: any possible cpu without a cid - normally just the
-	 * not-online ones. Pack into shards of up to min(@shard_size,
+	 * not-online ones. Pack into shards of up to min(@b->shard_size,
 	 * SCX_CID_SHARD_MAX_CPUS) cids so that every cid has a valid shard
-	 * assignment and the hard cap holds even with a large @shard_size.
-	 * Collect any currently-online cpus that land here in @online_no_topo
+	 * assignment and the hard cap holds even with a large @b->shard_size.
+	 * Collect any currently-online cpus that land here in @b->online_no_topo
 	 * so we can warn about them at the end.
 	 */
-	notopo_in_shard = min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS);
+	notopo_in_shard = min_t(u32, b->shard_size, SCX_CID_SHARD_MAX_CPUS);
 	notopo_shard_cid = -1;
 	notopo_shard_idx = -1;
 
 	for_each_cpu(cpu, cpu_possible_mask) {
-		if (tbls->cpu_to_cid[cpu] != -1)
+		if (b->tbls->cpu_to_cid[cpu] != -1)
 			continue;
 		if (cpu_online(cpu))
-			cpumask_set_cpu(cpu, online_no_topo);
+			cpumask_set_cpu(cpu, b->online_no_topo);
 
-		cid = (*next_cid)++;
-		tbls->cid_to_cpu[cid] = cpu;
-		tbls->cpu_to_cid[cpu] = cid;
+		cid = b->next_cid++;
+		b->tbls->cid_to_cpu[cid] = cpu;
+		b->tbls->cpu_to_cid[cpu] = cid;
 
-		if (notopo_in_shard >= min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS)) {
+		if (notopo_in_shard >= min_t(u32, b->shard_size, SCX_CID_SHARD_MAX_CPUS)) {
 			notopo_shard_cid = cid;
-			notopo_shard_idx = (*next_shard_idx)++;
+			notopo_shard_idx = b->next_shard_idx++;
 			notopo_in_shard = 0;
 		}
 		notopo_in_shard++;
 
-		tbls->cid_to_shard[cid] = notopo_shard_idx;
-		tbls->topo[cid] = SCX_CID_TOPO_NEG;
-		tbls->topo[cid].shard_cid = notopo_shard_cid;
-		tbls->topo[cid].shard_idx = notopo_shard_idx;
+		b->tbls->cid_to_shard[cid] = notopo_shard_idx;
+		b->tbls->topo[cid] = SCX_CID_TOPO_NEG;
+		b->tbls->topo[cid].shard_cid = notopo_shard_cid;
+		b->tbls->topo[cid].shard_idx = notopo_shard_idx;
 	}
 }
 
-static void scx_cid_finalize_tables(struct scx_cid_tables *tbls, u32 next_cid,
-				    s32 next_shard_idx)
+static void scx_cid_finalize_tables(struct scx_cid_builder *b)
 {
 	s32 cid;
 
@@ -219,15 +231,15 @@ static void scx_cid_finalize_tables(struct scx_cid_tables *tbls, u32 next_cid,
 	 * cid ranges by construction: base_cid is the first cid landing in a
 	 * shard, nr_cids is the count.
 	 */
-	for (cid = 0; cid < next_cid; cid++) {
-		s32 sidx = tbls->cid_to_shard[cid];
+	for (cid = 0; cid < b->next_cid; cid++) {
+		s32 sidx = b->tbls->cid_to_shard[cid];
 
-		if (tbls->shard_ranges[sidx].nr_cids == 0)
-			tbls->shard_ranges[sidx].base_cid = cid;
-		tbls->shard_ranges[sidx].nr_cids++;
+		if (b->tbls->shard_ranges[sidx].nr_cids == 0)
+			b->tbls->shard_ranges[sidx].base_cid = cid;
+		b->tbls->shard_ranges[sidx].nr_cids++;
 	}
 
-	tbls->nr_shards = next_shard_idx;
+	b->tbls->nr_shards = b->next_shard_idx;
 }
 
 /**
@@ -253,11 +265,7 @@ s32 scx_cid_init(struct scx_sched *sch)
 	cpumask_var_t llc_fallback __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	cpumask_var_t online_no_topo __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	struct scx_cid_tables *tbls;
-	u32 next_cid = 0;
-	s32 next_node_idx = 0, next_llc_idx = 0, next_core_idx = 0;
-	s32 next_cluster_idx = 0;
-	s32 next_shard_idx = 0;
-	u32 shard_size, max_cids;
+	struct scx_cid_builder b = {};
 	s32 cpu, si;
 
 	/* CMASK_MAX_WORDS in cid.bpf.h covers NR_CPUS up to 8192 */
@@ -266,8 +274,8 @@ s32 scx_cid_init(struct scx_sched *sch)
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&scx_enable_mutex);
 
-	shard_size = sch->ops.cid_shard_size ?: SCX_CID_SHARD_SIZE_DFL;
-	max_cids = min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS);
+	b.shard_size = sch->ops.cid_shard_size ?: SCX_CID_SHARD_SIZE_DFL;
+	b.max_cids = min_t(u32, b.shard_size, SCX_CID_SHARD_MAX_CPUS);
 
 	tbls = scx_cid_alloc_tables();
 	if (!tbls)
@@ -287,16 +295,25 @@ s32 scx_cid_init(struct scx_sched *sch)
 	    !zalloc_cpumask_var(&online_no_topo, GFP_KERNEL))
 		return -ENOMEM;
 
+	b.tbls = tbls;
+	b.to_walk = to_walk;
+	b.node_scratch = node_scratch;
+	b.llc_scratch = llc_scratch;
+	b.cluster_scratch = cluster_scratch;
+	b.core_scratch = core_scratch;
+	b.llc_fallback = llc_fallback;
+	b.online_no_topo = online_no_topo;
+
 	/* -1 sentinels for sparse-possible cpu id holes (0 is a valid cid) */
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
 		tbls->cpu_to_cid[cpu] = -1;
 
-	cpumask_copy(to_walk, cpu_online_mask);
+	cpumask_copy(b.to_walk, cpu_online_mask);
 
-	while (!cpumask_empty(to_walk)) {
-		s32 next_cpu = cpumask_first(to_walk);
+	while (!cpumask_empty(b.to_walk)) {
+		s32 next_cpu = cpumask_first(b.to_walk);
 		s32 nid = cpu_to_node(next_cpu);
-		s32 node_cid = next_cid;
+		s32 node_cid = b.next_cid;
 		s32 node_idx;
 
 		/*
@@ -304,38 +321,38 @@ s32 scx_cid_init(struct scx_sched *sch)
 		 * cid. cpumask_of_node(-1) is undefined.
 		 */
 		if (nid < 0) {
-			cpumask_clear_cpu(next_cpu, to_walk);
+			cpumask_clear_cpu(next_cpu, b.to_walk);
 			continue;
 		}
 
-		node_idx = next_node_idx++;
+		node_idx = b.next_node_idx++;
 
-		/* node_scratch = to_walk & this node */
-		cpumask_and(node_scratch, to_walk, cpumask_of_node(nid));
-		if (WARN_ON_ONCE(!cpumask_test_cpu(next_cpu, node_scratch)))
+		/* b.node_scratch = b.to_walk & this node */
+		cpumask_and(b.node_scratch, b.to_walk, cpumask_of_node(nid));
+		if (WARN_ON_ONCE(!cpumask_test_cpu(next_cpu, b.node_scratch)))
 			return -EINVAL;
 
-		while (!cpumask_empty(node_scratch)) {
-			s32 ncpu = cpumask_first(node_scratch);
-			const struct cpumask *llc_mask = cpu_llc_mask(ncpu, llc_fallback);
-			s32 llc_cid = next_cid;
-			s32 llc_idx = next_llc_idx++;
+		while (!cpumask_empty(b.node_scratch)) {
+			s32 ncpu = cpumask_first(b.node_scratch);
+			const struct cpumask *llc_mask = cpu_llc_mask(ncpu, b.llc_fallback);
+			s32 llc_cid = b.next_cid;
+			s32 llc_idx = b.next_llc_idx++;
 			u32 cores_per_shard, nr_large;
 			u32 shard_local = 0, cores_in_shard = 0, cids_in_shard = 0;
 			s32 shard_cid, shard_idx;
 			s32 cluster_cid = -1, cluster_idx = -1;
 
-			/* llc_scratch = node_scratch & this llc */
-			cpumask_and(llc_scratch, node_scratch, llc_mask);
-			if (WARN_ON_ONCE(!cpumask_test_cpu(ncpu, llc_scratch)))
+			/* b.llc_scratch = b.node_scratch & this llc */
+			cpumask_and(b.llc_scratch, b.node_scratch, llc_mask);
+			if (WARN_ON_ONCE(!cpumask_test_cpu(ncpu, b.llc_scratch)))
 				return -EINVAL;
 
-			calc_shard_layout(llc_scratch, shard_size, &cores_per_shard, &nr_large);
-			shard_cid = next_cid;
-			shard_idx = next_shard_idx++;
-			tbls->shard_node[shard_idx] = nid;
+			calc_shard_layout(b.llc_scratch, b.shard_size, &cores_per_shard, &nr_large);
+			shard_cid = b.next_cid;
+			shard_idx = b.next_shard_idx++;
+			b.tbls->shard_node[shard_idx] = nid;
 
-			while (!cpumask_empty(llc_scratch)) {
+			while (!cpumask_empty(b.llc_scratch)) {
 				const struct cpumask *sib;
 				s32 core_cid, core_idx, lcpu, ccpu;
 				u32 max_cores, cids_in_core;
@@ -345,24 +362,26 @@ s32 scx_cid_init(struct scx_sched *sch)
 				 * on, so that a cluster is a contiguous cid
 				 * range like the core, LLC and node levels.
 				 */
-				if (cpumask_empty(cluster_scratch)) {
-					s32 xcpu = cpumask_first(llc_scratch);
+				if (cpumask_empty(b.cluster_scratch)) {
+					s32 xcpu = cpumask_first(b.llc_scratch);
 
-					cpumask_or(cluster_scratch, topology_cluster_cpumask(xcpu),
+					cpumask_or(b.cluster_scratch,
+						   topology_cluster_cpumask(xcpu),
 						   topology_sibling_cpumask(xcpu));
-					cpumask_and(cluster_scratch, cluster_scratch, llc_scratch);
-					cluster_cid = next_cid;
-					cluster_idx = next_cluster_idx++;
+					cpumask_and(b.cluster_scratch, b.cluster_scratch,
+						    b.llc_scratch);
+					cluster_cid = b.next_cid;
+					cluster_idx = b.next_cluster_idx++;
 				}
 
-				lcpu = cpumask_first(cluster_scratch);
+				lcpu = cpumask_first(b.cluster_scratch);
 				sib = topology_sibling_cpumask(lcpu);
-				core_cid = next_cid;
-				core_idx = next_core_idx++;
+				core_cid = b.next_cid;
+				core_idx = b.next_core_idx++;
 
-				/* core_scratch = cluster_scratch & this core */
-				cpumask_and(core_scratch, cluster_scratch, sib);
-				if (WARN_ON_ONCE(!cpumask_test_cpu(lcpu, core_scratch)))
+				/* b.core_scratch = b.cluster_scratch & this core */
+				cpumask_and(b.core_scratch, b.cluster_scratch, sib);
+				if (WARN_ON_ONCE(!cpumask_test_cpu(lcpu, b.core_scratch)))
 					return -EINVAL;
 
 				/*
@@ -371,28 +390,28 @@ s32 scx_cid_init(struct scx_sched *sch)
 				 * shard sizes under uneven SMT. Never start an
 				 * empty shard.
 				 */
-				cids_in_core = cpumask_weight(core_scratch);
+				cids_in_core = cpumask_weight(b.core_scratch);
 				max_cores = cores_per_shard + (shard_local < nr_large ? 1 : 0);
 				if (cores_in_shard &&
 				    (cores_in_shard >= max_cores ||
-				     cids_in_shard + cids_in_core > max_cids)) {
+				     cids_in_shard + cids_in_core > b.max_cids)) {
 					shard_local++;
 					cores_in_shard = 0;
 					cids_in_shard = 0;
-					shard_cid = next_cid;
-					shard_idx = next_shard_idx++;
-					tbls->shard_node[shard_idx] = nid;
+					shard_cid = b.next_cid;
+					shard_idx = b.next_shard_idx++;
+					b.tbls->shard_node[shard_idx] = nid;
 				}
 				cores_in_shard++;
 				cids_in_shard += cids_in_core;
 
-				for_each_cpu(ccpu, core_scratch) {
-					s32 cid = next_cid++;
+				for_each_cpu(ccpu, b.core_scratch) {
+					s32 cid = b.next_cid++;
 
-					tbls->cid_to_cpu[cid] = ccpu;
-					tbls->cpu_to_cid[ccpu] = cid;
-					tbls->cid_to_shard[cid] = shard_idx;
-					tbls->topo[cid] = (struct scx_cid_topo){
+					b.tbls->cid_to_cpu[cid] = ccpu;
+					b.tbls->cpu_to_cid[ccpu] = cid;
+					b.tbls->cid_to_shard[cid] = shard_idx;
+					b.tbls->topo[cid] = (struct scx_cid_topo){
 						.core_cid = core_cid,
 						.core_idx = core_idx,
 						.llc_cid = llc_cid,
@@ -405,17 +424,16 @@ s32 scx_cid_init(struct scx_sched *sch)
 						.cluster_idx = cluster_idx,
 					};
 
-					cpumask_clear_cpu(ccpu, cluster_scratch);
-					cpumask_clear_cpu(ccpu, llc_scratch);
-					cpumask_clear_cpu(ccpu, node_scratch);
-					cpumask_clear_cpu(ccpu, to_walk);
+					cpumask_clear_cpu(ccpu, b.cluster_scratch);
+					cpumask_clear_cpu(ccpu, b.llc_scratch);
+					cpumask_clear_cpu(ccpu, b.node_scratch);
+					cpumask_clear_cpu(ccpu, b.to_walk);
 				}
 			}
 		}
 	}
 
-	scx_cid_build_notopo(tbls, shard_size, &next_cid, &next_shard_idx,
-			     online_no_topo);
+	scx_cid_build_notopo(&b);
 
 	if (!cpumask_empty(llc_fallback))
 		pr_warn("scx_cid: cpus without cacheinfo, using node mask as llc: %*pbl\n",
@@ -424,7 +442,7 @@ s32 scx_cid_init(struct scx_sched *sch)
 		pr_warn("scx_cid: online cpus with no usable topology: %*pbl\n",
 			cpumask_pr_args(online_no_topo));
 
-	scx_cid_finalize_tables(tbls, next_cid, next_shard_idx);
+	scx_cid_finalize_tables(&b);
 	return 0;
 }
 
-- 
2.43.0

