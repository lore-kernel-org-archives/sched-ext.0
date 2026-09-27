Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012008.outbound.protection.outlook.com [40.93.195.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF73C13FB
	for <sched-ext@lists.linux.dev>; Sun, 27 Sep 2026 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790516256; cv=fail; b=JCPdaIFYT8uVUsKNcfr6idilwg4isA+0pwI/qTEj4yWJWzdKSj/B8QzHx4Ii7vnJ2ylTB5xGDi5AoUz7zqhQT8ofUV0paU4j84LOkattwuzKqek7V2ZWpJn5yrjKRbu76HiGL8PUG8oE1ruLqTvUcLOJXCA8u/WG0BXm35OtfkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790516256; c=relaxed/simple;
	bh=fAXkmCEW88MYrLfPQs+H19xkVuIrMIQ0S3SopQUV914=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KTWSH/StcVTVD4qV/IDFZhhbHAUXTb7msXwLt3dlzcIOIAYCu0YkfZIUJNqAeAmAIANCXEUB0SD+TEulBRVczg3s6kaUZyEU9tg9GQgfLQym2gDhCR6PDwogqtdbl/RhFuvU/83ex79epOnUtplg0w9mn7K6iUHJhCXp+XjKSI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sVuYR5HX; arc=fail smtp.client-ip=40.93.195.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sVuYR5HX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9JZmYH4V0a6zRWH9121OB9qMQ+Hk1HFsKDCdWiGmryPhxTjZ9nv2ENnx0BRcE0QOKtYyCgODXcx5pQEDY7eVDL59JCh/fqXYcE7AmFcE292kOx6EalrIZCF0i+gx557bPEqTEazTnC6Sng5BegL2aakIz4cwaVFAtufZZfAgFPR6A5eL1jGaTWGNeO4yPXjHuBNxT+6B2lfIktR+j9QuYOLfZr8QuZpoeMO52hVaLZfbRHLRmJSjcf+SJWpNoxYAPlQy53SSm0UAVjbVFL79FZvfmcxnQe36tVHed86k0JwzI1CteK8TuuESI7V1sA9IMQqFhy3Z/dh1GLgv4zyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uug4ZTY2FWWJPykfIiL5hctxQMdDeRSKMaqqWbvnSEU=;
 b=D9swY825QvP25EXpuVInwor8PMGdamZXUG13B6fWOuE40n/rKKg466WujYIRuXALEX9zDjONvIQYqkkxfSS535LRy+L00ZDYtlZ7VGGT5lMpI377i1SaSYrIFg0VCs4qhpt53PypXNIjKP+9ogsdWfakrj3hMTG4/pyv43VEokRAlx9B6MTFln/5oD2vprKJ63aCysNoX5w/nMqpdoZ6b3rfuhoqaXLBYl5A/gvOn5bDnA5am7+B3DWkuA/hliVUfjGhonyc/UyDRUhe0zQehC9c3PTuA1TCk74fZjJNjw4XEMxGEGVJTWzr/HBXb4ur7mxqR4V7NfipAWWfZdpWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uug4ZTY2FWWJPykfIiL5hctxQMdDeRSKMaqqWbvnSEU=;
 b=sVuYR5HXm44YbJGwqqa+ppYKfkMW4Qwtafd8Ip/7njRigRW/Pk+CS3T/aeYQqo6nZDnjSYbhlrjJPz+VEVzF9okUKmb0G+cFdPuUzGqlErI1kQ/x8RPpySS7u/0a/hSX3hRxX1mSARpRxpE2fqcuzJT9csLgyMlDsBEwxJvTy5cm/g4jvF5TCKOH27kfIWVIbFHSPROtgx+8Jg4vyw0QK3Gj00IN3wCG9+RYbs6pPyKpsFTpfMiJWYbCmXMGQkxrW05+45LDvrJSwleMLwZgnKNfwWab5tFDSTrj8alvb6Uh+yjMAC3mL8V2fruLyWUaiLOePI2ZImB+kk4h96zGQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:37:29 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0451.014; Sun, 27 Sep 2026
 13:37:28 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 sched_ext/for-7.4] sched_ext: cid: Represent clusters explicitly
Date: Sun, 27 Sep 2026 15:37:19 +0200
Message-ID: <20260927133719.3458770-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::13) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: a2128590-89d9-401e-7955-08df1c9c7956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|260925022911599003|260925021311599003|260925021911599003|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	N0hYFxsKgp6/7HXwuFz/vFDdZx7vXPfbiPGzEG1bMmZ9fVQ6pRgbSkw8zQdwoGITypKWJm39UdC06BrLhoAl/dZZifMNaxm/SufsRre4vDqxDPEW9rmo/95IZEU29rFvuAr6yxw8ny2UUjeAinpUndKNS3C00QO/hCkXahkabrw62eWyqOMdqp6JmS7+Ae0QlyvVAuurrqGITYEIXWaiFPqkT9ioU8p0MI6tgEAz+EVa/3mudrU4r+phTYZzosM4s/DhU+yGy5bo63bjoo4WYfCiWaedX/mEWhI6SXPmplZ4Kxy+PN0dU7/PpOn90vgOk4DcKCB0zX3sHc6WQJzeKPZ2JOgglzoMldh5yvy1dEgIOdkhZGf/teWtNF0jGUMnFEqiWqVSRav1fprwDI6SJCmJOZn7n57zr+hkQPgT1O8YhMP3YvBt4fvsplx5L4/Vb5HACBd9EUt6xZs/iFIKMn2W3MGjYBwBuAk73YAEt9ID9VDLUt0/toWqVpCEiutx79kQYjT5pl2HrYDeDzgRYQDBjczBbjzt5Q06RicLbATNTyarqqGYmU6J7KA4wEoRRXB8nj4bmMvNLzsW0PQiHcY2ZK3sOO2ws2/ABo9BmWr2aS7EvUx9qSC8nkbls+2bB3SP2S1aJglarAimKL3SsMoUhwja8SnvQ2Jc0WsRbfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(260925022911599003)(260925021311599003)(260925021911599003)(3023799007)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KRE7TGFbWa6OovQBeVJEWNN3qKo0pe5OYyUXx2GvIXsK3pI4FaRIaRP/kDTZ?=
 =?us-ascii?Q?1NPA8QLPJaIeqTLQJPi8y5gU8PDXPGZyb/Tp0lhelEjskoBhzroAiKkvi8hB?=
 =?us-ascii?Q?spWR16kthufv1uxxTH6HL5OJsxw7FYBN2AJofBInI8Bt+V8BqGiyx+ghzRtG?=
 =?us-ascii?Q?x3gZ7S/ID+Ko8VF8atwhzLz7Yx433Zqi3p2HxTTBJYCpoRwKIr1Zikf8EXAT?=
 =?us-ascii?Q?sH2GRc1j7dTDsg4HVjZwTPF2epfVC+IxgO3IuI7C3X3HCLwn8ThCysJN3zTp?=
 =?us-ascii?Q?iu8Rd+GM/hYQcyvNh6gcMgZH33P+TiP2UAs5j6Zb3HIV1o82I5fWLnNdRtWT?=
 =?us-ascii?Q?Jk2ZAbN67m/z1Mm28IgqFIfx/yXKTeBQlftJXMjWCpjxJYmVy5HA504/7+Y/?=
 =?us-ascii?Q?NWrJHCq49dwOQX7XJ7/mZbjestwCuJIz6aH7ut+rGTcekkj4PZ/zGGGNiAoL?=
 =?us-ascii?Q?VntsdXQ9MTzuheEw+4YX9gODw5uuN8xA8NZwGAYT2YP+ICuRhgaPVROPi5X4?=
 =?us-ascii?Q?9QLpkpHEmoxn5+msCntyT/PR8GE6hfM1HQafpDZ4QDvxv2vKv7vJPpUoJwtF?=
 =?us-ascii?Q?zDx+2qa6ec6ZVxZ0M5m/yYuT4v7EYBFouxk4ZOej8bWPynPR+5FcoFoVe+ev?=
 =?us-ascii?Q?veo4AQdUp991IJkfCIv/a/9Trpbv5WJZZi90p7hfVMHPF+Z9ZwdobObx588v?=
 =?us-ascii?Q?GAHNHl3aW/PGeOm/MJGIz2kOsJ3cmrAEnk8yMXTW9/SXTFD1V4XpYHA0VUgC?=
 =?us-ascii?Q?ISuILbDbDcxMPiMD+Nrtl86XegO/AktG9U7Y/ctpZNaVw6cIjqGIYMy0xe2g?=
 =?us-ascii?Q?0mvGpvTgFfWjXque0THC8nFKz3kshHW/6zlwhQTybojH1LZxwHi1yiQmqxrG?=
 =?us-ascii?Q?z04rF13UJhUJsK4xwsjCvc7i2gQ7OVFJOpbUrQEFGeTDhQLuAPK1vb4OUBGV?=
 =?us-ascii?Q?Lg63V1vrY02yU9NzWs5YVXMJpUYnaTwVFIUTFd4or/lqNgYsXYxmiSq0yQfb?=
 =?us-ascii?Q?zWI2CYBVLf69OYV6JklW25KvzxjmaP2T8NHfTZ6o6UW6EVgJRfsxmRaaP4Oa?=
 =?us-ascii?Q?BPM5vixx/wDgPZnwS8etJRxDRNb4XgT97xb8UJrqzjXRiktNxSOhUTjVzY1y?=
 =?us-ascii?Q?ZnQ4rVa/haoI/1xyb8rVLm1Se0oizoejG8JqgDDHleXhLxMO/4NNcwKrgJE3?=
 =?us-ascii?Q?rEaquuFqOVvRiDMhZK41VBqCLM1h1r7uZA1qh5dNES3EOgO8R8ZWXZ/wKxKX?=
 =?us-ascii?Q?JbgW8bcGA81rOhYh+115WL00nnuUptnGB/59344VenOv9BEWdwy8AXLgbAs2?=
 =?us-ascii?Q?3h4k46JVZPxb0CK/8zh2JT2v/GGNQqmCr+xdYsrmWU1CPq3dwMtG9NOeDtOR?=
 =?us-ascii?Q?5+pjR5fobzu79yRarcDpeqs/4Y4M7YWMRKciL8s/q93au28i5z3arfNEZJwc?=
 =?us-ascii?Q?1xWGYP8412b3QnwPMnP4qJJPZc/vQPTwGwsbopSiIfIU80zgU50kcswjwXHD?=
 =?us-ascii?Q?FAmOE9y442Y/+Cib/xawem//DLfHyQYhkdnRx6hFqxGH5KvdSwDZ2bK/0pNa?=
 =?us-ascii?Q?yLfunsyrtu1DLTW2rTc+AYWfGFxd9GlTnZMOttaiDfmoee5LdVYDIrJCGFJC?=
 =?us-ascii?Q?8vZ6cstYI5BgrmzMEA/Ct9lYSZRQPYgkF481fBwWGVbK03YaJTgZZ98umNqt?=
 =?us-ascii?Q?FC1FDTBKNwiSAmc9Y1y+4fltwFtatPbzy09VgkU84a95Af/5itE4OkSSYfl2?=
 =?us-ascii?Q?OZ297XNpBQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2128590-89d9-401e-7955-08df1c9c7956
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:37:28.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9o5WSJ0fH/vrBXzBW9O3NeMGIw51rfQ0t8RwEfooNyr7uiPRVE6mOUHzyfjzSx2SPutReBZMz1xFU541zfpxpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712

The sched_ext CID topology gives each core, LLC and NUMA node a
contiguous CID range. Without cluster entries, schedulers cannot obtain
their CID range or global index.

Walk cores by cache-sharing cluster and add cluster_cid and cluster_idx
to scx_cid_topo. Treat the level inclusively: a core without a wider
cluster forms one of its own, while an LLC-wide cache-sharing group
forms one cluster. This gives every cluster a contiguous CID range and a
dense index.

The walk now takes cores in cluster order rather than LLC order. Shards
are still cut on core boundaries, so a shard doesn't need to contain a
whole cluster; only core, cluster, LLC and node are nested, in that
order.

The level follows whatever the arch reports through
topology_cluster_cpumask(), which on x86 is the L2 sharing mask and is
populated independently of CONFIG_SCHED_CLUSTER.

Tested on a 13th Gen Intel Core i7-13800H: six SMT P-cores occupy CPUs
0-11, eight E-cores occupy CPUs 12-19 in two four-core L2 modules, and
all 20 CPUs share one LLC; the P-core pairs form two-CID clusters, the
E-core modules form four-CID clusters, and cluster_idx is dense across
all eight clusters.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v3:
 - Use an inclusive mask so an LLC-wide L2 remains one cluster (Tejun Heo).
 - Update the override kerneldoc and simplify the topology comments (Tejun Heo).
 - Document that shards may split clusters and that cluster_cid alone does not
   identify whether a wider cluster level exists.
 - Link to v2: https://lore.kernel.org/r/20260926212017.3351797-1-arighi@nvidia.com

Changes in v2:
 - Give each core without a wider cluster level its own cluster, with
   cluster_cid = core_cid and a dense cluster_idx (Tejun Heo).
 - Link to v1: https://lore.kernel.org/r/20260926152306.3190774-1-arighi@nvidia.com

 kernel/sched/ext/cid.c   | 43 +++++++++++++++++++++++++++++++---------
 kernel/sched/ext/cid.h   | 11 +++++-----
 kernel/sched/ext/types.h | 28 +++++++++++++++++++++-----
 3 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index dc670975c5bfd..9fc2192570047 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -31,6 +31,7 @@ static struct scx_cid_tables *scx_cid_tables;	/* used only during alloc/free */
 #define SCX_CID_TOPO_NEG	(struct scx_cid_topo) {				\
 	.core_cid = -1, .core_idx = -1, .llc_cid = -1, .llc_idx = -1,		\
 	.node_cid = -1, .node_idx = -1, .shard_cid = -1, .shard_idx = -1,	\
+	.cluster_cid = -1, .cluster_idx = -1,					\
 }
 
 /*
@@ -182,12 +183,14 @@ s32 scx_cid_init(struct scx_sched *sch)
 	cpumask_var_t to_walk __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	cpumask_var_t node_scratch __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	cpumask_var_t llc_scratch __free(free_cpumask_var) = CPUMASK_VAR_NULL;
+	cpumask_var_t cluster_scratch __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	cpumask_var_t core_scratch __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	cpumask_var_t llc_fallback __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	cpumask_var_t online_no_topo __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	struct scx_cid_tables *tbls;
 	u32 next_cid = 0;
 	s32 next_node_idx = 0, next_llc_idx = 0, next_core_idx = 0;
+	s32 next_cluster_idx = 0;
 	s32 next_shard_idx = 0;
 	u32 shard_size, max_cids;
 	u32 notopo_in_shard;
@@ -215,6 +218,7 @@ s32 scx_cid_init(struct scx_sched *sch)
 	if (!zalloc_cpumask_var(&to_walk, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&node_scratch, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&llc_scratch, GFP_KERNEL) ||
+	    !zalloc_cpumask_var(&cluster_scratch, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&core_scratch, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&llc_fallback, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&online_no_topo, GFP_KERNEL))
@@ -256,6 +260,7 @@ s32 scx_cid_init(struct scx_sched *sch)
 			u32 cores_per_shard, nr_large;
 			u32 shard_local = 0, cores_in_shard = 0, cids_in_shard = 0;
 			s32 shard_cid, shard_idx;
+			s32 cluster_cid = -1, cluster_idx = -1;
 
 			/* llc_scratch = node_scratch & this llc */
 			cpumask_and(llc_scratch, node_scratch, llc_mask);
@@ -268,15 +273,32 @@ s32 scx_cid_init(struct scx_sched *sch)
 			tbls->shard_node[shard_idx] = nid;
 
 			while (!cpumask_empty(llc_scratch)) {
-				s32 lcpu = cpumask_first(llc_scratch);
-				const struct cpumask *sib = topology_sibling_cpumask(lcpu);
-				s32 core_cid = next_cid;
-				s32 core_idx = next_core_idx++;
-				s32 ccpu;
+				const struct cpumask *sib;
+				s32 core_cid, core_idx, lcpu, ccpu;
 				u32 max_cores, cids_in_core;
 
-				/* core_scratch = llc_scratch & this core */
-				cpumask_and(core_scratch, llc_scratch, sib);
+				/*
+				 * Take the cores of one cluster before moving
+				 * on, so that a cluster is a contiguous cid
+				 * range like the core, LLC and node levels.
+				 */
+				if (cpumask_empty(cluster_scratch)) {
+					s32 xcpu = cpumask_first(llc_scratch);
+
+					cpumask_or(cluster_scratch, topology_cluster_cpumask(xcpu),
+						   topology_sibling_cpumask(xcpu));
+					cpumask_and(cluster_scratch, cluster_scratch, llc_scratch);
+					cluster_cid = next_cid;
+					cluster_idx = next_cluster_idx++;
+				}
+
+				lcpu = cpumask_first(cluster_scratch);
+				sib = topology_sibling_cpumask(lcpu);
+				core_cid = next_cid;
+				core_idx = next_core_idx++;
+
+				/* core_scratch = cluster_scratch & this core */
+				cpumask_and(core_scratch, cluster_scratch, sib);
 				if (WARN_ON_ONCE(!cpumask_test_cpu(lcpu, core_scratch)))
 					return -EINVAL;
 
@@ -316,8 +338,11 @@ s32 scx_cid_init(struct scx_sched *sch)
 						.node_idx = node_idx,
 						.shard_cid = shard_cid,
 						.shard_idx = shard_idx,
+						.cluster_cid = cluster_cid,
+						.cluster_idx = cluster_idx,
 					};
 
+					cpumask_clear_cpu(ccpu, cluster_scratch);
 					cpumask_clear_cpu(ccpu, llc_scratch);
 					cpumask_clear_cpu(ccpu, node_scratch);
 					cpumask_clear_cpu(ccpu, to_walk);
@@ -461,8 +486,8 @@ __bpf_kfunc_start_defs();
  * starts must be strictly increasing with the first entry 0 and all values <
  * num_possible_cpus(). The last shard extends to num_possible_cpus() and no
  * shard may span more than SCX_CID_SHARD_MAX_CPUS cids. Topo info
- * (core/LLC/node) is cleared and the shard layout is set from the input. On
- * invalid input, abort the scheduler.
+ * (core/cluster/LLC/node) is cleared and the shard layout is set from the
+ * input. On invalid input, abort the scheduler.
  */
 __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid__arena, u32 cpu_to_cid_cnt,
 				      const s32 *shard_start__arena, u32 shard_start_cnt,
diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
index 2fe2311a0f995..709afbfb97c6f 100644
--- a/kernel/sched/ext/cid.h
+++ b/kernel/sched/ext/cid.h
@@ -13,11 +13,12 @@
  * kernel type sized for the maximum NR_CPUS (4k), with verbose helper sequences
  * for every op.
  *
- * cids give every cpu a dense, topology-ordered id. CPUs sharing a core, LLC or
- * NUMA node get contiguous cid ranges, so a topology unit becomes a (start,
- * length) slice of cid space. Communication can pass a slice instead of a
- * cpumask, and BPF code can process, for example, a u64 word's worth of cids at
- * a time.
+ * cids give every cpu a dense, topology-ordered id. CPUs in each core,
+ * cluster, LLC or NUMA node get contiguous cid ranges, so a topology unit
+ * becomes a (start, length) slice of cid space. A core without a wider cluster
+ * level forms a cluster of its own. Communication can pass a slice
+ * instead of a cpumask, and BPF code can process, for example, a u64 word's
+ * worth of cids at a time.
  *
  * The mapping is built once at root scheduler enable time by walking the
  * topology of online cpus only. Going by online cpus is out of necessity:
diff --git a/kernel/sched/ext/types.h b/kernel/sched/ext/types.h
index 139176cf9fc6e..38514d6bf1495 100644
--- a/kernel/sched/ext/types.h
+++ b/kernel/sched/ext/types.h
@@ -59,17 +59,31 @@ enum scx_consts {
 };
 
 /*
- * Per-cid topology info. For each topology level (core, LLC, node) and shard,
- * records the first cid in the unit and its global index. Global indices are
- * consecutive integers assigned in cid-walk order, so e.g. core_idx ranges over
- * [0, nr_cores_at_init) with no gaps. No-topo cids have core/LLC/node fields
- * set to -1 but always have valid shard assignments.
+ * Per-cid topology info. For each topology level (core, cluster, LLC, node) and
+ * shard, records the first cid in the unit and its global index. Global indices
+ * are consecutive integers assigned in cid-walk order, so e.g. core_idx ranges
+ * over [0, nr_cores_at_init) with no gaps. No-topo cids have core/cluster/LLC/
+ * node fields set to -1 but always have valid shard assignments.
+ *
+ * A cluster is the cache-sharing level between the core and the LLC. Where
+ * this level is absent, each core forms a cluster of its own. Where the cache
+ * level spans the LLC, the whole LLC forms one cluster. Each cluster has a
+ * unique cluster_cid and a dense cluster_idx, and its cids form a contiguous
+ * range.
+ *
+ * Every cid therefore has a cluster, so cluster_cid alone does not say whether
+ * the machine has the level: the first cluster of an LLC starts at the LLC's
+ * own base cid and a core-wide one at the core's.
  *
  * Shards are contiguous CID ranges used as scalable locking/work domains for
  * sub-scheduler operations. By default each LLC becomes one shard, split into
  * smaller shards if the LLC exceeds the target size. No-topo cids are packed
  * into their own max-sized shards.
  *
+ * Shards are cut on core boundaries only, so a shard doesn't need to contain a
+ * whole cluster: a cluster may straddle two shards. Only core, cluster, LLC
+ * and node are nested, in that order.
+ *
  * New fields are appended, never inserted: scx_bpf_cid_topo() copies this
  * struct out sized by the program's own layout, and an older program's copy
  * must stay a prefix of the kernel's.
@@ -82,6 +96,8 @@ enum scx_consts {
  * @node_idx: global index of that node, in [0, nr_nodes_at_init)
  * @shard_cid: first cid of this cid's shard
  * @shard_idx: global index of that shard, in [0, scx_nr_cid_shards)
+ * @cluster_cid: first cid of this cid's cluster
+ * @cluster_idx: global index of that cluster, in [0, nr_clusters_at_init)
  */
 struct scx_cid_topo {
 	s32 core_cid;
@@ -92,6 +108,8 @@ struct scx_cid_topo {
 	s32 node_idx;
 	s32 shard_cid;
 	s32 shard_idx;
+	s32 cluster_cid;
+	s32 cluster_idx;
 };
 
 enum scx_cid_consts {
-- 
2.55.0
