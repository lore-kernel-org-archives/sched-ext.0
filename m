Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C733F5BE
	for <sched-ext@lists.linux.dev>; Sat, 26 Sep 2026 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436205; cv=fail; b=VYSpLWSUhfKt7oJk/ffMkNWfjAap4hsTWxVLDJEVrz3/reLyUOtXVSSeDmhMIcE9he5Z1szv81cWmll/SxDjY6ME3KlsH12MuB1XB0a3ysJgF7SgSxhv8VKrheArTdyRHHgCmepUAGULPEmGjdyQioIuyPSKFtJWgBI+nuV1ulc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436205; c=relaxed/simple;
	bh=Li9/OAPMkOwqbODzgedXmTETmdlxUNsdowBKNGCmocI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eYLrvpglVZaTYtuUEepQydo+eoi5kG/nxQVAOqIiX6+e29PXb7oAvUFvChmMBOhG09nEwT9xKSxs0srCpry87lzExBbe6DcwdLlIZwvDNhRZav4Sh7wVxDhfpRb1XJbVN4m0AlVTN9wUPMQi1bU754iKq6SzqBg6uuByq+sBSg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kSKdyB8v; arc=fail smtp.client-ip=52.101.57.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kSKdyB8v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJtgxWNWIoMePD+EaAw+XMpCqBemxEkTAx0oQQhBGqI7+XOxyMiSQROxtA5NmthnO4io8ROuFfa+O23Hm4C4YKgrcyl3XSSXRHKdU2uBZr6X02Wv7nsZcHkvtsbV3jJ1B+/U2d0UUXFtMarvZ+gS39n9rKTLCf/8x2xnW7cdReC3VjmrLVnqPpNQY0dvdruxdod0CbLpCfT/NfTUuO9Tzteedt212VGQanE2PqoS65ddGEggii92H9pPkxCbzxTMwhMf+SAqpyU1j93NGhnplbyi9VOuCKSB968RdkLJasAQq/vkFF1Mqhsj2qLnZnnwNAzh5Yv8W5RrjfMfIt1p/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EOjp1p5Frwh/84w1HJBzCdlD83vzCPtFZVpW1XKYME=;
 b=boEwquVTiHOYZBuY6FkXXdDZBcTWOJsxuYSf6HTyZdbPfAHhTGDLIp4fW+j+Kaa+ArzSeZQE8yXBWL036OZM/2PSIXHyqxOe1pgC/8htNQADHrhjuMg1JGE3/Q47Ci9TGMTpF3SJ1yeSfWRitp6Qep2RdV5HUE4/KMuN9qhibGBTkX/fsHCkEXRpdSpmvoIbwBFoOur5pd8SnIrmnKskkUb1jb/sbDn1qxpRNz+yQAhOPVUGSJreMcbkm2NidappjX+BwDeQtqA2OLYuULbMiPc/RRR8XkuzNm0cm4ZDKMxT0BFiMzdeufCvg4j89K65s1AFM/MQvmyCdYXmuerNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EOjp1p5Frwh/84w1HJBzCdlD83vzCPtFZVpW1XKYME=;
 b=kSKdyB8v+q6aGUQ3ogN2JEexrnQVA1b9vUL8SA1E9EOSh+LZWSTssQmDD0Jk2NXm9sLJKPOwBwIQFBeAIgsMG7w01fLBCeHcqAFkTPuLcCU6vy+mF/PZi5zoBBJcqSJEnmHsbAjyqPqUXPCRgOMeF/i96chSOJFD90le+ZIWF4+EvByq3E+svrfls1SFvmsnZTWeVTlzSyu7PuJ3dtcVMGFYuAm5PX37YYbbwyVuQGEQCtHD4VRljbLU4J5ugfYaZxZTpa4UCDEmoh6TYZT1PceZyswt4T0Ri569LeLltkctYFOtXATTAIEZKWF687gluDlsnb1kZWtQc+0bMTVZNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 15:23:15 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 15:23:15 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.4] sched_ext: cid: Represent clusters explicitly
Date: Sat, 26 Sep 2026 17:23:06 +0200
Message-ID: <20260926152306.3190774-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF0000753E.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4da) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: c632bab9-8b47-4194-42cd-08df1be21581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|5023799004|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	G3DsGnJnz5bhSkdOu5K+C04mF2FDt+NWhGuNAKvIx4Zt36uodX6uh5WVfY2NI3P/l3PyMJCCWnuzUB6VNe81wjMfz5xdiYeECTGlZE8hR5Q++fyQ1RsDGXZybCj2xLiCaJ8vYXgSDYD3obLrLCRI27V17p/YENp5OZUG0bQLJU4r0bzGpHNN3mH8E6HIPX1YD3h42UTqGH/ipFdVUbbNxSZNNVSCKIz0I9H3L1+lsw4P5QWI8de0yMq5rDfD4FcZHbTJpHrx1FnqkwlDXXuANl+yxK3tPbOUQsmNcHireZnS8AKA8WLGY88/cH3eONSc2qWeeRNjPpIA8big2dYCO0YzgKace4Bfw944wF2rh7W2xIGwA/gj0qtzMZRTvCZnCTDwAAQice0vIbsOx0s7k4JNcUuEhP25SG+vv3bpf7melB8YwwIR3hDPk1sU8O/0LYz9nekRCbEZeYfXYvlSctDUUZcLrJ+Of16TKRv20aX51/FkkYZna+RyULKQ8efI6SuRff2U2NLPmbzZFdJE9yfjO3rXJn6B2hzlvf8SQ10gh4UtbFQTfxdE5iu2nrUebr/qaCEmtSPRTGA0bDz25Pv2MJMIpGYD/CvTINWxRC5YPTq6ERHaaBOCKSHAviOHOtmasi+G+L+I3s/S0Uxl/6VZu3mqzAk5Fd16MfvQn5g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+h5riKoqeVr7/XAaXmXaIDmABZAa7pjH8THKlWzz8KSEcTtg0SumK1nSklE?=
 =?us-ascii?Q?S8H92UVv8L8YhFhWAJqOZfPp0UqUEv723yYVGgTo7XTMoyJSAO8182sZ7vfX?=
 =?us-ascii?Q?EQqRT8kA86+JTzPoWFK0uCVgSPiJFYdbQm/Bh1BV9G2aSfCpZodPRPd/tvBG?=
 =?us-ascii?Q?JcNJ+OsUdZPzhYc9dsXdMbtaYZ6QhE17Xow88GUVws/BLERZMR6raUkCMW0T?=
 =?us-ascii?Q?9bUIGuydWIwXXJlyCmOB1f+h28hot6UVSqMlTAYnIdeUP0AXgQBHugaoKAOx?=
 =?us-ascii?Q?Oo8vPTdN9U+AhD1dVhLxvnhRZERGXx/7uMmolcPsuv57t+ANTonXu3wUYVYJ?=
 =?us-ascii?Q?jMui9wI8D7xw3XXEQR/VdS9LpGK4mXn7AN2OsPJYIP4eACvVmXwouq69dzA2?=
 =?us-ascii?Q?55aQX0A2CTCDA2oKdnenPdz7oEs3wot0KT+a4W9+YWfjbwSoS/7x8WOxvtIT?=
 =?us-ascii?Q?9jIVvyP3VkdfN5pjhe0hmmF9boNu2BXCrzJuRVimZ/UYTu5IOAJAZekYorC3?=
 =?us-ascii?Q?rqtfApt9szHgeWuTfoWYfQqJHkFXD8L6Yhgej/D0wm+GwMjxMqBK6Ztpj4pM?=
 =?us-ascii?Q?h2EniSK3852rUDkny9/FPjPdjYKO1nkUizk4jeQjhg1+dOlb2gVbMwVjq0Tk?=
 =?us-ascii?Q?2ePf5WkBQKWMseFapWw2SnSX7OHpqT+Q1ChLCf/d7QD/LiHDXXDPbqfUY0cX?=
 =?us-ascii?Q?kujnLwAWfyAimz5JDVl5yfsGjx5QwQ7Zx3akSyIQXwvFcKgyfBLUhQrUjQRv?=
 =?us-ascii?Q?Z8Ub7S3DOzeagFxoNfi2jPLGHKXVlNe+0MA91zOGH3HOpeUiEidkCYjBT1Qy?=
 =?us-ascii?Q?tRSHg7T+7WuWbZ7DNyNqkXtJgwa2H+Xw/GNnm9TTBbYX2/gHzOUWOMd4cOhA?=
 =?us-ascii?Q?8FNPyktM/r/ua//SUdilddDMFQo7f9RDnyg7ZI6Y574j0O2MV9RO0ykO1qb2?=
 =?us-ascii?Q?H/U/XFNhKTVlqlqMGjt9Ld/+yDhdcS1iHTYvG9bgu2+ANP0iyEjpAGHPe+8z?=
 =?us-ascii?Q?NMgqO5Uq2NuaOvMA9hY3OecIsOdmQ11u+3Ds9WHnsvUBwuCUsUESy8QWx0Fn?=
 =?us-ascii?Q?taQKFMQX5zHISYK/EkdnriVlfzptDOfv2lj/ebubjl4ssiknUaOxDEg7FwRL?=
 =?us-ascii?Q?/3nIpkFxbRb5dYwbk2XhdUKnRsUl4R7vBp+0hhWttjH2LA3+XJ34hrdZoo/1?=
 =?us-ascii?Q?lpUYYEL2L5GV+/HPg9slCo5Ni2nm6D+7x4vdw7quaL5N7iB+91/ApfNbXqD1?=
 =?us-ascii?Q?HAb6LGM7yVb60AanHVg6xr8K9XGavj3ueVejZ1KpTP+tlnjLdG6NaMvp17l4?=
 =?us-ascii?Q?vNwlZR3jngopnvBLWP1emfSHspXR0PBx/hBdpitAl0w1avsMgRIf+gkLEmJ1?=
 =?us-ascii?Q?LSVIsQcAv4By1P0ycK7nUg8NWtjFX+0QKJI1OUjdAINc+qdqU50TqDXZdzGQ?=
 =?us-ascii?Q?P9iL+ftb/D+nEvDHVf1OgzTqJ9VNWpo/FomXfRL9YUEmLx1udMB9Sl3Wf0Dj?=
 =?us-ascii?Q?gnnosok68TEITje7KsyiBLHCac3i2tGp5fkClIRZqBBnrAfx7FgYcFiOoYyg?=
 =?us-ascii?Q?nzVk2/SVsv2qaVOT81jlBaZ023ySAZrv+RcUReiaJtMbo84fa/Q/jZA5uQZ/?=
 =?us-ascii?Q?N5usrmuXZgg+pOammtJkT1pJv8Ep90Kde5MUZU4oMrOQL3xDUL2uXOWXG2p2?=
 =?us-ascii?Q?l3GTfyFvhxzHfanhBQqnPCDeC23Yq4HTbL9Z8iXBk7PxtcSEeIJmFapp1pnf?=
 =?us-ascii?Q?1q4C2bB0uQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c632bab9-8b47-4194-42cd-08df1be21581
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 15:23:14.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FUoM0wHQGNbBcCqdA9ecbIGEYhTpS5W1pn+OCZ33cK78z60Fu9USMk0eZ/qpOgaV+RKn2zzGVsUme5Z9T2Jrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590

The sched_ext CID topology is meant to represent each topology level as
a contiguous range of CIDs. This works for cores, LLCs, and NUMA nodes,
but not for clusters: group of CPU cores that share a cache or other
CPU-local resources more closely with each other than with the rest of
the CPUs in the same LLC. Moreover, struct scx_cid_topo does not
identify the cluster a CPU belongs to.

Represent clusters explicitly in the CID topology:
 - enumerate the cores of each cluster before moving to the next
   cluster,
 - report the cluster in struct scx_cid_topo,
 - set @cluster_cid to the LLC's own CID when no cluster level exists,
 - set @cluster_idx to -1 when no cluster level exists,
 - treat a CPU without a cluster level as a cluster containing only its
   core, preserving the existing walk order.

Tested on a 13th Gen Intel Core i7-13800H with CONFIG_SCHED_CLUSTER=y:
six P-cores with SMT on CPUs 0-11, eight E-cores in two L2 modules on
CPUs 12-15 and 16-19 and one LLC spanning all 20 CPUs. The P-core
cluster domains degenerate to their SMT pairs, while each E-core module
has its own cluster domain; scx_bpf_cid_topo() reports the LLC's CID for
the P-cores and contiguous four-CID ranges for the two E-core clusters.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/cid.c   | 71 ++++++++++++++++++++++++++++++++++++----
 kernel/sched/ext/cid.h   | 12 ++++---
 kernel/sched/ext/types.h | 22 ++++++++++---
 3 files changed, 88 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index 39f88deb94bc4..680eef9bd924e 100644
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
@@ -256,27 +282,55 @@ s32 scx_cid_init(struct scx_sched *sch)
 			u32 cores_per_shard, nr_large;
 			u32 shard_local = 0, cores_in_shard = 0, cids_in_shard = 0;
 			s32 shard_cid, shard_idx;
+			s32 cluster_cid = llc_cid, cluster_idx = -1;
 
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
+						cluster_cid = next_cid;
+						cluster_idx = next_cluster_idx++;
+					} else {
+						cpumask_and(cluster_scratch, llc_scratch,
+							    topology_sibling_cpumask(xcpu));
+						cluster_cid = llc_cid;
+						cluster_idx = -1;
+					}
+					if (WARN_ON_ONCE(!cpumask_test_cpu(xcpu, cluster_scratch)))
+						return -EINVAL;
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
 
@@ -316,8 +370,11 @@ s32 scx_cid_init(struct scx_sched *sch)
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
index 2fe2311a0f995..cfe1e3890373d 100644
--- a/kernel/sched/ext/cid.h
+++ b/kernel/sched/ext/cid.h
@@ -13,11 +13,13 @@
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
+ * unit becomes a (start, length) slice of cid space. A cpu without a distinct
+ * cluster level uses its LLC's first cid as cluster_cid; cpus with this
+ * fallback value need not form a contiguous range. Communication can pass a
+ * slice instead of a cpumask, and BPF code can process, for example, a u64
+ * word's worth of cids at a time.
  *
  * The mapping is built once at root scheduler enable time by walking the
  * topology of online cpus only. Going by online cpus is out of necessity:
diff --git a/kernel/sched/ext/types.h b/kernel/sched/ext/types.h
index 943d8d429a2c9..9280e9cbdd6c3 100644
--- a/kernel/sched/ext/types.h
+++ b/kernel/sched/ext/types.h
@@ -59,11 +59,19 @@ enum scx_consts {
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
+ * A cluster is the cache-sharing level below an LLC used by SD_CLUSTER and
+ * identified by per_cpu(sd_share_id). Where this level is absent, including on
+ * individual CPUs of hybrid machines, cluster_cid is the LLC's first cid and
+ * cluster_idx is -1. Comparing cluster_cid then matches cpus_share_resources().
+ * Entries with the same nonnegative cluster_idx form a contiguous cid range.
+ * Fallback entries may be interleaved with clusters and may share cluster_cid
+ * with a real cluster, so cluster_cid alone does not delimit a cluster range.
  *
  * Shards are contiguous CID ranges used as scalable locking/work domains for
  * sub-scheduler operations. By default each LLC becomes one shard, split into
@@ -78,6 +86,8 @@ enum scx_consts {
  * @node_idx: global index of that node, in [0, nr_nodes_at_init)
  * @shard_cid: first cid of this cid's shard
  * @shard_idx: global index of that shard, in [0, scx_nr_cid_shards)
+ * @cluster_cid: first cid of this cid's cluster, or LLC if no cluster level
+ * @cluster_idx: global index of that cluster, or -1 if no cluster level
  */
 struct scx_cid_topo {
 	s32 core_cid;
@@ -88,6 +98,8 @@ struct scx_cid_topo {
 	s32 node_idx;
 	s32 shard_cid;
 	s32 shard_idx;
+	s32 cluster_cid;
+	s32 cluster_idx;
 };
 
 enum scx_cid_consts {
-- 
2.55.0

