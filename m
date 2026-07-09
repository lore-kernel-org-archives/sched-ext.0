Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA23B14D0;
	Thu,  9 Jul 2026 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637449; cv=none; b=PIdGoth2MrJOfHpCFFyxxnsfCm/uwvZrGZbhpi69Tn5FxibAx0ioAAu7Ee/CZSvrlRrbNXrJs6/KAg151LSGrU1nYN2vPe0c9OuypGmbHI5elRKYqBNE8iqBATyECzcxSkGM4m8iSSU1Nmt52AiWV6TQ6A9Gx09W+BAuIrOmVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637449; c=relaxed/simple;
	bh=DlfmyEQ6T0Ghv2IeWBYZDA7j4Wjp8QC0OL7MbEl0hmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqJFZ+yhbVVbPQe6CkH7y3GfpUz38MitNdVIUGqfZOlFWTugwy0Wv4N/1DuXv/92t3ugabRokMBZHLt78UxeClTUEPr7IopWIy8up5wLL6Eq8xGv9BV73cekfEL5Xt8VaQ/+2nIJ59Ha2X8FLQTcec+e+Jhw4vkat2c+W5u1pVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMMWWVfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMMWWVfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E469B1F00A3E;
	Thu,  9 Jul 2026 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637447;
	bh=lxIr/id9jF63zH3km1y8rt8IwPkA9lcw9OKXDnbsHcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMMWWVfgK0UunhlghBGW1B3MD/teMfusVN5oYH3FkMWePeQFacH+dCoCSCW2ZAZul
	 GUWJvz67dXFQvPa0Az/RFgC3ojNcgn9sR28NDaou4C/pmTNAOAKxWoqtsQfP9VB3Z+
	 C/bIp1/S/SmxIeT90rGJvH8LJVslkqaRXseFGm/rBwE7GtP51/EWYm1IaDMmGfWBzT
	 HKy2Ao/Q32IIXkDNFmSMy9jy5DjFtekKgoUwnUIt1laqHkceJTsIf9Rhpr2mu+dSRO
	 MCNxUtLstDgktBnTsN9BVBB0lPsaxsK1zhBIXc3Kwpixhiw/rYPwiC+D/8l+BU1CWq
	 DcPKzzVoEHe/g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 04/33] sched_ext: Add CID sharding
Date: Thu,  9 Jul 2026 12:50:12 -1000
Message-ID: <20260709225041.1695495-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
References: <20260709225041.1695495-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sub-sched operations need a scalable locking / work domain smaller than the
whole cid space. Carve the cid space into topology-respecting shards: each
shard is a contiguous cid range that stays within one LLC, and LLCs larger
than the per-shard cap (default 24 cids, configurable via
ops.cid_shard_size) split into enough shards to fit. A hard cap of
SCX_CID_SHARD_MAX_CPUS prevents pathological sizes under custom
configurations.

No-topo cids pack into their own shards so every cid has a shard assignment.

Also build scx_cid_shard_ranges[] for O(1) shard-to-cid-range lookup and
scx_shard_node[] so callers can size or place work by NUMA without walking
cids. Auto-built shards inherit their LLC's node. No-topo shards carry
NUMA_NO_NODE.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/cid.c      | 132 ++++++++++++++++++++++++++++++++++--
 kernel/sched/ext/cid.h      |   4 ++
 kernel/sched/ext/ext.c      |   4 ++
 kernel/sched/ext/internal.h |  13 ++++
 kernel/sched/ext/types.h    |  35 ++++++++--
 5 files changed, 176 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index b0ec4d76f855..f3c54f4223b4 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -18,13 +18,17 @@
  * use scx_bpf_cid_override() to change the mapping. The mapping stays stable
  * until the root is disabled.
  */
+u32 scx_nr_cid_shards;
 s16 *scx_cid_to_cpu_tbl;
 s16 *scx_cpu_to_cid_tbl;
+s32 *scx_cid_to_shard;
+s32 *scx_shard_node;
+struct scx_cid_shard *scx_cid_shard_ranges;
 struct scx_cid_topo *scx_cid_topo;
 
 #define SCX_CID_TOPO_NEG	(struct scx_cid_topo) {				\
 	.core_cid = -1, .core_idx = -1, .llc_cid = -1, .llc_idx = -1,		\
-	.node_cid = -1, .node_idx = -1,						\
+	.node_cid = -1, .node_idx = -1, .shard_cid = -1, .shard_idx = -1,	\
 }
 
 /*
@@ -43,11 +47,40 @@ static const struct cpumask *cpu_llc_mask(int cpu, struct cpumask *fallbacks)
 	return &ci->info_list[ci->num_leaves - 1].shared_cpu_map;
 }
 
+/*
+ * Compute per-LLC shard layout. Each shard holds at most @shard_size cids, and
+ * in any case no more than SCX_CID_SHARD_MAX_CPUS. Cores are spread as evenly
+ * as possible across shards so cpu count is balanced: the first *@nr_large_p
+ * shards get (*@cores_per_shard_p + 1) cores, the rest get *@cores_per_shard_p.
+ */
+static void calc_shard_layout(const struct cpumask *llc_cpus, u32 shard_size,
+			      u32 *cores_per_shard_p, u32 *nr_large_p)
+{
+	u32 nr_cores = 0, nr_cpus = 0, nr_shards;
+	int cpu;
+
+	for_each_cpu(cpu, llc_cpus) {
+		nr_cpus++;
+		if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
+			nr_cores++;
+	}
+
+	nr_shards = max_t(u32, 1, DIV_ROUND_UP(nr_cpus, shard_size));
+	nr_shards = max_t(u32, nr_shards,
+			  DIV_ROUND_UP(nr_cpus, SCX_CID_SHARD_MAX_CPUS));
+
+	*cores_per_shard_p = nr_cores / nr_shards;
+	*nr_large_p = nr_cores % nr_shards;
+}
+
 /* Allocate the cid tables once on first enable; never freed. */
 static s32 scx_cid_arrays_alloc(void)
 {
 	u32 npossible = num_possible_cpus();
 	s16 *cid_to_cpu, *cpu_to_cid;
+	s32 *cid_to_shard;
+	s32 *shard_node;
+	struct scx_cid_shard *cid_shard_ranges;
 	struct scx_cid_topo *cid_topo;
 
 	if (scx_cid_to_cpu_tbl)
@@ -55,17 +88,27 @@ static s32 scx_cid_arrays_alloc(void)
 
 	cid_to_cpu = kzalloc_objs(*scx_cid_to_cpu_tbl, npossible, GFP_KERNEL);
 	cpu_to_cid = kzalloc_objs(*scx_cpu_to_cid_tbl, nr_cpu_ids, GFP_KERNEL);
+	cid_to_shard = kzalloc_objs(*scx_cid_to_shard, npossible, GFP_KERNEL);
+	shard_node = kmalloc_objs(*scx_shard_node, npossible, GFP_KERNEL);
+	cid_shard_ranges = kzalloc_objs(*scx_cid_shard_ranges, npossible, GFP_KERNEL);
 	cid_topo = kmalloc_objs(*scx_cid_topo, npossible, GFP_KERNEL);
 
-	if (!cid_to_cpu || !cpu_to_cid || !cid_topo) {
+	if (!cid_to_cpu || !cpu_to_cid || !cid_to_shard || !shard_node ||
+	    !cid_shard_ranges || !cid_topo) {
 		kfree(cid_to_cpu);
 		kfree(cpu_to_cid);
+		kfree(cid_to_shard);
+		kfree(shard_node);
+		kfree(cid_shard_ranges);
 		kfree(cid_topo);
 		return -ENOMEM;
 	}
 
 	WRITE_ONCE(scx_cid_to_cpu_tbl, cid_to_cpu);
 	WRITE_ONCE(scx_cpu_to_cid_tbl, cpu_to_cid);
+	WRITE_ONCE(scx_cid_to_shard, cid_to_shard);
+	WRITE_ONCE(scx_shard_node, shard_node);
+	WRITE_ONCE(scx_cid_shard_ranges, cid_shard_ranges);
 	WRITE_ONCE(scx_cid_topo, cid_topo);
 	return 0;
 }
@@ -90,17 +133,29 @@ s32 scx_cid_init(struct scx_sched *sch)
 	cpumask_var_t online_no_topo __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	u32 next_cid = 0;
 	s32 next_node_idx = 0, next_llc_idx = 0, next_core_idx = 0;
-	s32 cpu, ret;
+	s32 next_shard_idx = 0;
+	u32 shard_size, max_cids;
+	u32 notopo_in_shard;
+	s32 notopo_shard_cid, notopo_shard_idx;
+	s32 cpu, cid, si, ret;
 
 	/* CMASK_MAX_WORDS in cid.bpf.h covers NR_CPUS up to 8192 */
 	BUILD_BUG_ON(NR_CPUS > 8192);
 
 	lockdep_assert_cpus_held();
 
+	shard_size = sch->ops.cid_shard_size ?: SCX_CID_SHARD_SIZE_DFL;
+	max_cids = min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS);
+
 	ret = scx_cid_arrays_alloc();
 	if (ret)
 		return ret;
 
+	/* clear shard ranges and reset shard_node for repopulate */
+	memset(scx_cid_shard_ranges, 0, num_possible_cpus() * sizeof(*scx_cid_shard_ranges));
+	for (si = 0; si < num_possible_cpus(); si++)
+		scx_shard_node[si] = NUMA_NO_NODE;
+
 	if (!zalloc_cpumask_var(&to_walk, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&node_scratch, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&llc_scratch, GFP_KERNEL) ||
@@ -142,29 +197,60 @@ s32 scx_cid_init(struct scx_sched *sch)
 			const struct cpumask *llc_mask = cpu_llc_mask(ncpu, llc_fallback);
 			s32 llc_cid = next_cid;
 			s32 llc_idx = next_llc_idx++;
+			u32 cores_per_shard, nr_large;
+			u32 shard_local = 0, cores_in_shard = 0, cids_in_shard = 0;
+			s32 shard_cid, shard_idx;
 
 			/* llc_scratch = node_scratch & this llc */
 			cpumask_and(llc_scratch, node_scratch, llc_mask);
 			if (WARN_ON_ONCE(!cpumask_test_cpu(ncpu, llc_scratch)))
 				return -EINVAL;
 
+			calc_shard_layout(llc_scratch, shard_size, &cores_per_shard, &nr_large);
+			shard_cid = next_cid;
+			shard_idx = next_shard_idx++;
+			scx_shard_node[shard_idx] = nid;
+
 			while (!cpumask_empty(llc_scratch)) {
 				s32 lcpu = cpumask_first(llc_scratch);
 				const struct cpumask *sib = topology_sibling_cpumask(lcpu);
 				s32 core_cid = next_cid;
 				s32 core_idx = next_core_idx++;
 				s32 ccpu;
+				u32 max_cores, cids_in_core;
 
 				/* core_scratch = llc_scratch & this core */
 				cpumask_and(core_scratch, llc_scratch, sib);
 				if (WARN_ON_ONCE(!cpumask_test_cpu(lcpu, core_scratch)))
 					return -EINVAL;
 
+				/*
+				 * Advance to a new shard when either core or
+				 * cid count reaches max. The latter bounds
+				 * shard sizes under uneven SMT. Never start an
+				 * empty shard.
+				 */
+				cids_in_core = cpumask_weight(core_scratch);
+				max_cores = cores_per_shard + (shard_local < nr_large ? 1 : 0);
+				if (cores_in_shard &&
+				    (cores_in_shard >= max_cores ||
+				     cids_in_shard + cids_in_core > max_cids)) {
+					shard_local++;
+					cores_in_shard = 0;
+					cids_in_shard = 0;
+					shard_cid = next_cid;
+					shard_idx = next_shard_idx++;
+					scx_shard_node[shard_idx] = nid;
+				}
+				cores_in_shard++;
+				cids_in_shard += cids_in_core;
+
 				for_each_cpu(ccpu, core_scratch) {
 					s32 cid = next_cid++;
 
 					scx_cid_to_cpu_tbl[cid] = ccpu;
 					scx_cpu_to_cid_tbl[ccpu] = cid;
+					scx_cid_to_shard[cid] = shard_idx;
 					scx_cid_topo[cid] = (struct scx_cid_topo){
 						.core_cid = core_cid,
 						.core_idx = core_idx,
@@ -172,6 +258,8 @@ s32 scx_cid_init(struct scx_sched *sch)
 						.llc_idx = llc_idx,
 						.node_cid = node_cid,
 						.node_idx = node_idx,
+						.shard_cid = shard_cid,
+						.shard_idx = shard_idx,
 					};
 
 					cpumask_clear_cpu(ccpu, llc_scratch);
@@ -184,12 +272,17 @@ s32 scx_cid_init(struct scx_sched *sch)
 
 	/*
 	 * No-topo section: any possible cpu without a cid - normally just the
-	 * not-online ones. Collect any currently-online cpus that land here in
-	 * @online_no_topo so we can warn about them at the end.
+	 * not-online ones. Pack into shards of up to min(@shard_size,
+	 * SCX_CID_SHARD_MAX_CPUS) cids so that every cid has a valid shard
+	 * assignment and the hard cap holds even with a large @shard_size.
+	 * Collect any currently-online cpus that land here in @online_no_topo
+	 * so we can warn about them at the end.
 	 */
-	for_each_cpu(cpu, cpu_possible_mask) {
-		s32 cid;
+	notopo_in_shard = min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS);
+	notopo_shard_cid = -1;
+	notopo_shard_idx = -1;
 
+	for_each_cpu(cpu, cpu_possible_mask) {
 		if (__scx_cpu_to_cid(cpu) != -1)
 			continue;
 		if (cpu_online(cpu))
@@ -198,7 +291,18 @@ s32 scx_cid_init(struct scx_sched *sch)
 		cid = next_cid++;
 		scx_cid_to_cpu_tbl[cid] = cpu;
 		scx_cpu_to_cid_tbl[cpu] = cid;
+
+		if (notopo_in_shard >= min_t(u32, shard_size, SCX_CID_SHARD_MAX_CPUS)) {
+			notopo_shard_cid = cid;
+			notopo_shard_idx = next_shard_idx++;
+			notopo_in_shard = 0;
+		}
+		notopo_in_shard++;
+
+		scx_cid_to_shard[cid] = notopo_shard_idx;
 		scx_cid_topo[cid] = SCX_CID_TOPO_NEG;
+		scx_cid_topo[cid].shard_cid = notopo_shard_cid;
+		scx_cid_topo[cid].shard_idx = notopo_shard_idx;
 	}
 
 	if (!cpumask_empty(llc_fallback))
@@ -208,6 +312,20 @@ s32 scx_cid_init(struct scx_sched *sch)
 		pr_warn("scx_cid: online cpus with no usable topology: %*pbl\n",
 			cpumask_pr_args(online_no_topo));
 
+	/*
+	 * Fill cid_shard_ranges[] from cid_to_shard[]. Shards are contiguous
+	 * cid ranges by construction: base_cid is the first cid landing in a
+	 * shard, nr_cids is the count.
+	 */
+	for (cid = 0; cid < next_cid; cid++) {
+		s32 sidx = scx_cid_to_shard[cid];
+
+		if (scx_cid_shard_ranges[sidx].nr_cids == 0)
+			scx_cid_shard_ranges[sidx].base_cid = cid;
+		scx_cid_shard_ranges[sidx].nr_cids++;
+	}
+
+	scx_nr_cid_shards = next_shard_idx;
 	return 0;
 }
 
diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
index cd0d4b9f1088..cdc18a7a48f5 100644
--- a/kernel/sched/ext/cid.h
+++ b/kernel/sched/ext/cid.h
@@ -48,8 +48,12 @@ struct scx_sched;
  * See the comment above the table definitions in cid.c for the
  * memory-ordering and visibility contract.
  */
+extern u32 scx_nr_cid_shards;
 extern s16 *scx_cid_to_cpu_tbl;
 extern s16 *scx_cpu_to_cid_tbl;
+extern s32 *scx_cid_to_shard;
+extern s32 *scx_shard_node;
+extern struct scx_cid_shard *scx_cid_shard_ranges;
 extern struct scx_cid_topo *scx_cid_topo;
 extern struct btf_id_set8 scx_kfunc_ids_init_cids;
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 7b5eccf0b0cc..f12691c839ce 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7172,6 +7172,9 @@ static int bpf_scx_init_member(const struct btf_type *t,
 	case offsetof(struct sched_ext_ops, hotplug_seq):
 		ops->hotplug_seq = *(u64 *)(udata + moff);
 		return 1;
+	case offsetof(struct sched_ext_ops, cid_shard_size):
+		ops->cid_shard_size = *(u32 *)(udata + moff);
+		return 1;
 #ifdef CONFIG_EXT_SUB_SCHED
 	case offsetof(struct sched_ext_ops, sub_cgroup_id):
 		ops->sub_cgroup_id = *(u64 *)(udata + moff);
@@ -9865,6 +9868,7 @@ static int __init scx_init(void)
 	CID_OFFSET_MATCH(timeout_ms, timeout_ms);
 	CID_OFFSET_MATCH(exit_dump_len, exit_dump_len);
 	CID_OFFSET_MATCH(hotplug_seq, hotplug_seq);
+	CID_OFFSET_MATCH(cid_shard_size, cid_shard_size);
 	CID_OFFSET_MATCH(sub_cgroup_id, sub_cgroup_id);
 	/* shared callbacks: the union view requires byte-for-byte offset match */
 	CID_OFFSET_MATCH(enqueue, enqueue);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 902244dc27ff..6560a0fa3efa 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -845,6 +845,18 @@ struct sched_ext_ops {
 	 */
 	u64 hotplug_seq;
 
+	/**
+	 * @cid_shard_size: Target number of CIDs per shard
+	 *
+	 * Shards are contiguous CID ranges used as operation and locking
+	 * domains for sub-scheduling. Each LLC is divided into ceil(nr_cpus /
+	 * @cid_shard_size) shards, then cores are distributed across them
+	 * evenly. If one core has more logical CPUs than @cid_shard_size, its
+	 * shard will become larger than @cid_shard_size. Values above
+	 * SCX_CID_SHARD_MAX_CPUS are capped. 0 means use the default (24).
+	 */
+	u32 cid_shard_size;
+
 	/**
 	 * @cgroup_id: When >1, attach the scheduler as a sub-scheduler on the
 	 * specified cgroup.
@@ -977,6 +989,7 @@ struct sched_ext_ops_cid {
 	u32 timeout_ms;
 	u32 exit_dump_len;
 	u64 hotplug_seq;
+	u32 cid_shard_size;
 	u64 sub_cgroup_id;
 	char name[SCX_OPS_NAME_LEN];
 
diff --git a/kernel/sched/ext/types.h b/kernel/sched/ext/types.h
index bc74eafd43f1..b31d12931999 100644
--- a/kernel/sched/ext/types.h
+++ b/kernel/sched/ext/types.h
@@ -47,11 +47,16 @@ enum scx_consts {
 };
 
 /*
- * Per-cid topology info. For each topology level (core, LLC, node), records
- * the first cid in the unit and its global index. Global indices are
- * consecutive integers assigned in cid-walk order, so e.g. core_idx ranges
- * over [0, nr_cores_at_init) with no gaps. No-topo cids have all fields set
- * to -1.
+ * Per-cid topology info. For each topology level (core, LLC, node) and shard,
+ * records the first cid in the unit and its global index. Global indices are
+ * consecutive integers assigned in cid-walk order, so e.g. core_idx ranges over
+ * [0, nr_cores_at_init) with no gaps. No-topo cids have core/LLC/node fields
+ * set to -1 but always have valid shard assignments.
+ *
+ * Shards are contiguous CID ranges used as scalable locking/work domains for
+ * sub-scheduler operations. By default each LLC becomes one shard, split into
+ * smaller shards if the LLC exceeds the target size. No-topo cids are packed
+ * into their own max-sized shards.
  *
  * @core_cid: first cid of this cid's core (smt-sibling group)
  * @core_idx: global index of that core, in [0, nr_cores_at_init)
@@ -59,6 +64,8 @@ enum scx_consts {
  * @llc_idx: global index of that LLC, in [0, nr_llcs_at_init)
  * @node_cid: first cid of this cid's NUMA node
  * @node_idx: global index of that node, in [0, nr_nodes_at_init)
+ * @shard_cid: first cid of this cid's shard
+ * @shard_idx: global index of that shard, in [0, scx_nr_cid_shards)
  */
 struct scx_cid_topo {
 	s32 core_cid;
@@ -67,6 +74,24 @@ struct scx_cid_topo {
 	s32 llc_idx;
 	s32 node_cid;
 	s32 node_idx;
+	s32 shard_cid;
+	s32 shard_idx;
+};
+
+enum scx_cid_consts {
+	SCX_CID_SHARD_SIZE_DFL		= 24,
+	SCX_CID_SHARD_MAX_CPUS		= 512,
+};
+
+/*
+ * Per-shard metadata for O(1) shard->cid-range lookup.
+ *
+ * @base_cid: first cid of the shard
+ * @nr_cids: number of cids in the shard
+ */
+struct scx_cid_shard {
+	s32			base_cid;
+	s32			nr_cids;
 };
 
 /*
-- 
2.55.0

