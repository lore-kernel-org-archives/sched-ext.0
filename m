Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7BC35FF5B
	for <sched-ext@lists.linux.dev>; Sat, 26 Sep 2026 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790457634; cv=fail; b=l/e7s5XwNf9pwZ6WzCqgQhymqv29PPKr3HFbKWI8scL00A0jaZ9BfIoxdoC1agHERN5uIFiOodzMoXyQmwBuGvDKluVOtJk7T+K2tawksRHAKK4HHLs333c93luRJlbN901YzlzHhugDIzL1GAW9sJcpGLFyYI+fR2anoPTNJ98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790457634; c=relaxed/simple;
	bh=vdS/EFUIsJ0rG8JBDNJDSaI4s3XKiHHrMwjQSWrMEag=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=omWYvNIM4Jnkgdn0tNZZEPOeCOrUhhDp1fjIW72aMSaHVbw0Q9XnxOL9rCHlaHchhoo178KNaijNT0C8CtPkFAcvu34b8T2VPfYV62yM9mgCzd78/x61myRZ4uNaVKtcl/lScFNZZO4mYIKdVpvutjEbZ2rXkuKJtQNAAaCM3jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MOg0bzeB; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MOg0bzeB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeGxlJGa/d3TZ1k0FxRH9AJcksQTuJS2HttnPRoD3qAGcZGFMwov2vL6/7ttlxFn8JYtnzCrmgQbYVXpG4pN9H9DzNNF8+9Ah1ASn/g7MNksAvvplX+4qYAmiNvzXlfhjVh31CnwaSXvw+o/bitC/QZXdbDa0V4yyRfJEv7XQBtM4C1lW3AteBy2u9EuvUgofjgmOCGHcMMY4s2beQ3b/C+Np5CepjW4iCGSTWV7kfaqzwgXf92f009oZDY7s4R5dqSKOtG0OAr8LDgYN9YcI/6ZeuJhyzh6ArySn1HvnZHm0bbuHEhQB0EUz+yd50vNsrW7xF2sp745UxE08t8F+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6KSV+6jqIeN8kdO9qh4og+9xV/TeKR53gs48X5V5JY=;
 b=ZulL5Yq8Fa37jDC0r2/AD6G2c3h2FunjpZge3oJpdhydHgKwhRlPrrcltbwK/aIe9EEMC2cND6ioQSvz5HzuEnVaYWOaQMqsA4jClkddKys2czdnOwfZeNYUjhZHhb/UQj8dHi1qSRpZtxo8c1YTV7YEgqttV7dmc8dOMB4R1ZVHKZFCfsMG4CdzN6TbB2aWr4NxVtnKjhn9pJ49rKLUmkOUWW/sqBy3usYVxZB3UjlomypHTKmveXUw2y7HIT/1OLKTmcRReLut61Lloe0x7zoy6cZXPyRb17wrGP3Ez2d+WElqBGXYztaIh87MiEayONI6kzQhTDp2l7xR24LHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6KSV+6jqIeN8kdO9qh4og+9xV/TeKR53gs48X5V5JY=;
 b=MOg0bzeB9Ex05QwIEuOGCdJlexgxKDGcVJMc82MKNRl8yRG8Sjx3uh35jTZ9OTEQ84jRbmmbNvh4M6EbSyBI1mTPdxxtCFvsyQmEJO5j3D5mWl9nxr/OlGVJFexwQlswoicngqpTPXRAPlJeXy5kMnm6671ew5LckQolV/qvQMc4NGUEfHiGoyj7t59cMgdTYCC5z6Ypp0jBeLZFxNmbWOIjBDLkaNr3YqBR3DN9gzaAl61cGQWxtpxhExFs6ayqT1Dcn8m+AvEs08Q+6szPcMKsTsA5E47F0zysg9ay3bw8wSsS62CUX0KP+OqTHNJeEjS1w1AUNqhigQD4q4ieiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 21:20:27 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 21:20:27 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.4] sched_ext: cid: Represent clusters explicitly
Date: Sat, 26 Sep 2026 23:20:17 +0200
Message-ID: <20260926212017.3351797-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00007539.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cb) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d909477-50d1-4d63-2065-08df1c13fc25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|5023799004|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	f8f22riKSfrAutr/5yPK2xTiXgShLb61q9GfVBEYWbNz+x6o/5IbjJLzjh7JP6FSDZlZy4Ne+/1X93SHjOjIl6sTVFiZeC8/hUbMs4WxLVe+dyc4BYP5xCZ8O+j7FmNnJGsG/L/Z8kTJR1Qp1+Xy6YM6X2ajFrFiwBSo2ejZslqRGmIi3vrdWkJnBQYfNimzmyPQKzETPuPZ2VYIDIEYmttcL6uEKPeX/u3QgvEkgGSRoVKksGrtGBAlVW8szmTVERO6O5LVLIVnl/5ZIFSJqA2Zfn1DWXuVo56GlulJKUa3uCPWYQYzzoQPQQgkGxvHMAI1DIoag7wwxVYv4+ws5wpOx+d2uK6HsninwihWBW3r8+m2hQd7ynUuFo00h0rBv2OQ2mEhSaiiBDLbVKrSkd2B8k6qdA1d+SsXaykmGGuCri/vfkkfzM2/nJRtcOkcpeK+0O5ZabYMf5hDTA5A3NTMP6ocqAVXyXvwRxvmFFlvCuLbhrsBfOMdrmG6Rfc47+A+dfDZnFZmxuuukPK58l6rozBappML/ersa8carDvk1A25KKcBTtefsFkiexElQPhF+M6IYoRxMqqUiX+PWt+Ny+rMLrzuNVbT1jrGTGl34r+ToiHn2fOgewoCIO84xhV3ZGvCCJKcFCOIaBx/6qxPaoXGajSTwV4cWgkw9nk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(5023799004)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1HXRlPwshS/ifCOF6BFs+SAUrEGk4cTjIXXgoBwKdcMJ44vLWzJhavNQ4AJd?=
 =?us-ascii?Q?tKGBdXLZ4b6e6nkpljrp4iKgoGaq08E68ytSO22Vf3shRfxp+bFzk7FYVwDX?=
 =?us-ascii?Q?EHEc/X0306wjWE3ml3hPrrodaSLeYH3bE6btY4XfhtN7LWYtjXSnZ2Pj5eGj?=
 =?us-ascii?Q?eJONBs7IO7zyS/5UMTF70uHVAg+Aii6ots2wQVtI+3OW8k3tn3M548plYVKz?=
 =?us-ascii?Q?mCnxXMVBgfKTgxvKY+a6lrtDt8/xdoCtcXRc4uZ5pGySc7mo2cbrTBaUMDIr?=
 =?us-ascii?Q?Ras40+NUxr45ITEwo4Csd4STZYFDsPA7QmHEv8qrGOFRivqlxcodVqIWZ5zW?=
 =?us-ascii?Q?tPLqULq0hFCzneI1CrFuhS9nKRbMJF6XSGscQ2yHr4ywmA9i5EUvAgaGJrgT?=
 =?us-ascii?Q?JapBg7MZdkrXqjaQhil3kLqhSvyY6z9b+T5OWI1mRkWDlT0VCEYe9Y3oYTsT?=
 =?us-ascii?Q?oV5OY7CB+tx6ahNYEqad0CadLnd+/50OXkv55N9ZVbNqUeKrzhjQ8XeeNDyj?=
 =?us-ascii?Q?q9NU3cCQVGNqneP1n0z5zO+c7dHujN0J+yaO9vppkcNoAUfdlx35iIou5jqF?=
 =?us-ascii?Q?iCqGWAZA6l2yNnLIsQ/MZL7hWWijgrfOc9E7Ryaw6Uca2ooHvDkON7+rvQev?=
 =?us-ascii?Q?LizogoR2IkqjksDopIGYdztHnT+xVg1QqpdrPIHFbWjsm6vBHJ9pJ59tseMN?=
 =?us-ascii?Q?P5HGMA3hMQNYpdfC9Tnmn4GFrD3FBIW/v2BaSOOpdsa7Pgh9GOEdve9EQyeO?=
 =?us-ascii?Q?4xzYSBoeZ++Snx6x3CErwfiLKOQVhP+SzpKRHzKfE+iLqny8w+swA5mkWfB+?=
 =?us-ascii?Q?QIQh7SZCrhQ1qFWbnX6eNWfwarIfeVOfMll+BDlYIPfp4ccvPtyLnjcRl9fG?=
 =?us-ascii?Q?1VaH3ztX9jaKIy7/2m5Cs7oMBVGMP6cH7BYMORtsqGvHUyizdBIS5t2H5wdv?=
 =?us-ascii?Q?jQ04Hi1MwJ923RpubqTZLDyGv4x0Kc7v+khy5jcqovuwI4nIclBlPqAJpGJo?=
 =?us-ascii?Q?cXftHDXekzJ5irTaJ8gXru/XhhBqmjwiboV0tWMTk92uEgbNsS7BRdSz9lL1?=
 =?us-ascii?Q?jlG+kai5Rde3s3SjdH+Vq+xUFsCdAzKNh5KALGzU62ILl5671srnwk+lpLC9?=
 =?us-ascii?Q?EWJGwQ/WUFp5RTyd20YqEwTcr6owK4rTVqlQVQxGZPDMuZU9sLFP8HRbjvK+?=
 =?us-ascii?Q?iNz1pYJ1XLygtkBDR6NWmZ/4gHWWfV3zbOrcGDTxmGFV3eowCE21g1eZR8zm?=
 =?us-ascii?Q?INv3l6wCMB3hl6lI8twBsUgL7B8F5zJptOs4rRX+1a7dm3HhjABMZbew737J?=
 =?us-ascii?Q?faVdTxK94GdZhjdRYkM/TwvQZpPqKcDATz93e6+2+uv3nu85N6OuIyKRd8CO?=
 =?us-ascii?Q?kDjDlN4a6QBSH3ANXsBJ/iTdegcO0/7yi86kpUZmBnXBQQ9Mi44fhkpBNNiA?=
 =?us-ascii?Q?TMK1XqDm2XvUs7mVYG2pwj2cZxRs90574NZU0vXsuQMA6mIfwHj44zUOAL4J?=
 =?us-ascii?Q?K8/6rcZLDXdkgAPYwEX5awOXM7Yq2sNzKl2FQQi/Wl/J294CEB2v6sFpff4K?=
 =?us-ascii?Q?66S9nk8vTtHzHvgD9kbK3Uu85tHcw2KpGSMwv4aXDPncPhlijC/I1kZVwKee?=
 =?us-ascii?Q?P8VEgZEBKe0ZuD0TfAgZPlt7PijJHznfki2RwSyr5FyLAINwGKTiLZdepkPZ?=
 =?us-ascii?Q?E/Nbg0VNy3cXG0sDwAc4vmfyrSAYWfo0UGvl/6+A8dKDslJIy/6tXmCVAfbp?=
 =?us-ascii?Q?iYGJSJriFQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d909477-50d1-4d63-2065-08df1c13fc25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 21:20:27.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckUGrlKL65BEXpVBIu05kSUx9Wy82SH/4bu+eR0erCkCAiVrORpAx0f/TyRcPolS9twW+D4q4Jp2xNlSLJJXDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767

The sched_ext CID topology gives each core, LLC and NUMA node a
contiguous CID range. Clusters lack explicit entries, so schedulers
cannot obtain their CID range or global index.

Walk cores by cluster and add cluster_cid and cluster_idx to
scx_cid_topo. When a core has no distinct cluster level, make that
core its own cluster. This gives every cluster a contiguous CID range
and a dense index, including on hybrid machines where only some cores
have a cluster domain.

Tested on a 13th Gen Intel Core i7-13800H with CONFIG_SCHED_CLUSTER=y:
six P-cores with SMT on CPUs 0-11, eight E-cores in two L2 modules on
CPUs 12-15 and 16-19 and one LLC spanning all 20 CPUs. Each P-core's SMT
pair forms a two-CID fallback cluster with cluster_cid = core_cid; each
E-core L2 module forms a four-CID cluster; scx_bpf_cid_topo() reports
dense cluster_idx values across all eight clusters.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Give each core without a distinct cluster level its own cluster,
   with cluster_cid = core_cid and a dense cluster_idx (Tejun Heo).
 - Based on the size-aware scx_bpf_cid_topo() fix
   (https://lore.kernel.org/r/fa6479d36b528573565ca22914451317@kernel.org)
 - Link to v1: https://lore.kernel.org/r/20260926152306.3190774-1-arighi@nvidia.com

 kernel/sched/ext/cid.c   | 69 ++++++++++++++++++++++++++++++++++++----
 kernel/sched/ext/cid.h   | 11 ++++---
 kernel/sched/ext/types.h | 19 ++++++++---
 3 files changed, 82 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index dc670975c5bfd..0addbcd103472 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -31,6 +31,7 @@ static struct scx_cid_tables *scx_cid_tables;	/* used only during alloc/free */
 #define SCX_CID_TOPO_NEG	(struct scx_cid_topo) {				\
 	.core_cid = -1, .core_idx = -1, .llc_cid = -1, .llc_idx = -1,		\
 	.node_cid = -1, .node_idx = -1, .shard_cid = -1, .shard_idx = -1,	\
+	.cluster_cid = -1, .cluster_idx = -1,					\
 }
 
 /*
@@ -49,6 +50,28 @@ static const struct cpumask *cpu_llc_mask(int cpu, struct cpumask *fallbacks)
 	return &ci->info_list[ci->num_leaves - 1].shared_cpu_map;
 }
 
+/*
+ * Return the mask of cpus @cpu shares cache resources with below its LLC, the
+ * cpus an SD_CLUSTER domain would span, or NULL when that is not a level of its
+ * own here.
+ *
+ * The level is dropped in the same cases the sched domain is: a cluster that is
+ * no wider than the core, or that covers the whole LLC, adds nothing.
+ */
+static const struct cpumask *cpu_cluster_mask(int cpu, const struct cpumask *llc_cpus)
+{
+	const struct cpumask *cluster = topology_cluster_cpumask(cpu);
+
+	if (!cluster || cpumask_empty(cluster))
+		return NULL;
+	if (cpumask_subset(cluster, topology_sibling_cpumask(cpu)))
+		return NULL;
+	if (cpumask_subset(llc_cpus, cluster))
+		return NULL;
+
+	return cluster;
+}
+
 /*
  * Compute per-LLC shard layout. Each shard holds at most @shard_size cids, and
  * in any case no more than SCX_CID_SHARD_MAX_CPUS. Cores are spread as evenly
@@ -182,12 +205,14 @@ s32 scx_cid_init(struct scx_sched *sch)
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
@@ -215,6 +240,7 @@ s32 scx_cid_init(struct scx_sched *sch)
 	if (!zalloc_cpumask_var(&to_walk, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&node_scratch, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&llc_scratch, GFP_KERNEL) ||
+	    !zalloc_cpumask_var(&cluster_scratch, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&core_scratch, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&llc_fallback, GFP_KERNEL) ||
 	    !zalloc_cpumask_var(&online_no_topo, GFP_KERNEL))
@@ -256,27 +282,53 @@ s32 scx_cid_init(struct scx_sched *sch)
 			u32 cores_per_shard, nr_large;
 			u32 shard_local = 0, cores_in_shard = 0, cids_in_shard = 0;
 			s32 shard_cid, shard_idx;
+			s32 cluster_cid = next_cid, cluster_idx = next_cluster_idx;
 
 			/* llc_scratch = node_scratch & this llc */
 			cpumask_and(llc_scratch, node_scratch, llc_mask);
 			if (WARN_ON_ONCE(!cpumask_test_cpu(ncpu, llc_scratch)))
 				return -EINVAL;
 
+			cpumask_clear(cluster_scratch);
 			calc_shard_layout(llc_scratch, shard_size, &cores_per_shard, &nr_large);
 			shard_cid = next_cid;
 			shard_idx = next_shard_idx++;
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
+					const struct cpumask *cluster =
+							cpu_cluster_mask(xcpu, llc_mask);
+
+					if (cluster) {
+						cpumask_and(cluster_scratch, llc_scratch, cluster);
+					} else {
+						cpumask_and(cluster_scratch, llc_scratch,
+							    topology_sibling_cpumask(xcpu));
+					}
+					if (WARN_ON_ONCE(!cpumask_test_cpu(xcpu, cluster_scratch)))
+						return -EINVAL;
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
 
@@ -316,8 +368,11 @@ s32 scx_cid_init(struct scx_sched *sch)
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
diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
index 2fe2311a0f995..6377b76db9c6f 100644
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
+ * distinct cluster, LLC or NUMA node get contiguous cid ranges, so a topology
+ * unit becomes a (start, length) slice of cid space. A core without a distinct
+ * cluster level forms a cluster of its own. Communication can pass a slice
+ * instead of a cpumask, and BPF code can process, for example, a u64 word's
+ * worth of cids at a time.
  *
  * The mapping is built once at root scheduler enable time by walking the
  * topology of online cpus only. Going by online cpus is out of necessity:
diff --git a/kernel/sched/ext/types.h b/kernel/sched/ext/types.h
index 139176cf9fc6e..da1be66cd8c3c 100644
--- a/kernel/sched/ext/types.h
+++ b/kernel/sched/ext/types.h
@@ -59,11 +59,16 @@ enum scx_consts {
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
+ * A cluster is the cache-sharing level below an LLC used by SD_CLUSTER. Where
+ * this level is absent, including on individual CPUs of hybrid machines, each
+ * core forms a cluster of its own. Each cluster has a unique cluster_cid and a
+ * dense cluster_idx, and its cids form a contiguous range.
  *
  * Shards are contiguous CID ranges used as scalable locking/work domains for
  * sub-scheduler operations. By default each LLC becomes one shard, split into
@@ -82,6 +87,8 @@ enum scx_consts {
  * @node_idx: global index of that node, in [0, nr_nodes_at_init)
  * @shard_cid: first cid of this cid's shard
  * @shard_idx: global index of that shard, in [0, scx_nr_cid_shards)
+ * @cluster_cid: first cid of this cid's cluster
+ * @cluster_idx: global index of that cluster, in [0, nr_clusters_at_init)
  */
 struct scx_cid_topo {
 	s32 core_cid;
@@ -92,6 +99,8 @@ struct scx_cid_topo {
 	s32 node_idx;
 	s32 shard_cid;
 	s32 shard_idx;
+	s32 cluster_cid;
+	s32 cluster_idx;
 };
 
 enum scx_cid_consts {
-- 
2.55.0
