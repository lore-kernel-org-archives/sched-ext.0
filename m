Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8535395AF2
	for <sched-ext@lists.linux.dev>; Mon,  3 Aug 2026 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737390; cv=fail; b=q+JyqzJfYMMKIndiP3cs6r717v5JDaGbJEefu3tMkRt2Ktm3NbcSABGSPeMO/ZSLDnwxUmICdN0pb02iMtJyCRrNxdIEms1bVhBBSJspFhFrCes0wDy439nBCD7V4VktqreHgsl6C/jyL8j/SAJG2iNph6ps3bWVcBbQtHbsdRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737390; c=relaxed/simple;
	bh=kOhJz2UoestB7id5zE5Y2CeoSwB5N1ku0RkzINmQ9BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eDs3/+J1pYd6pM3bLMK0eiBdysSMxFMMpY6DUkf6L5yE0cjHeByJTe4ctcdL93keVVFBtp+MjjYu5eJEFrkmaAcV0zdzIQWlms79ZMSkx3ckSYjmUGPrJU3ZZzRFtR++RckWlwHGUtfpKH1r1Vb8RwyR8xrYVGBVhGQyAM5Y9mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V40CUOjo; arc=fail smtp.client-ip=40.107.209.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V40CUOjo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgGNjYXG1HBczRmpTuLqVOiy2rSidjBIW7J14ZMQJWTXOcqwWwdSccQ3EAeBb8E1BqucQdUR9ei9jU837NRB8QzoRGVVfFVVMTs84v7sGUcX0l/QpObGZBxxQ/MwIy4Kxr8ig3ZQkKGNwAC/ZlVCFyUR+xQSo/pGzloLnnTUx9O0t3/pXe2WKMo6xNQqJJplFo3HsrvZORlyUDU9GzpmawHIXGlpBIPHQTjWPXNLMdfBq8W02WyvILSTJ91xY+V749oYouP+mprGURxarB1g0UCeDXIy9BmkE6ildZnr6dXZHLMCFzrmh/b3gX8VmVknNRnyby2oc/iHpk7BGWb5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMHLfRHO2JQHNWohi8I1NZbrtpxJTcYf4flie+TO9F0=;
 b=IUNy1x3WcvhWrrRREmiax5WPb0sw3fNmHKaTaeBdUWM4e/qSWbneYUBqSqjLgtptEGImn8ObXWvg466j7HrkR3fAiGBSClmE7wAnSIxJgFeLHrZ65SX8eLIZ6rGMgJTKwZJ3BdSp3DhAwBCC81FvgSN4cwuG1gOiaiSfAFTTqv/6/vhyHHJtHdEfeob4BD9tusOfevY0WJxF1ggbdGKA/dujvMa//Pd8RHHs5OM/xEwLajRgBpaE0po+0EgJr9OqY2AWYs5gupI/CGCLXaw49KyF+jm6+69V1+q8/Dby7pBNHDwgnKceubtgE4KoRxhw3jAUE/nmtLQ2X6BRLUn6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMHLfRHO2JQHNWohi8I1NZbrtpxJTcYf4flie+TO9F0=;
 b=V40CUOjoj+/13SodDpvqcsXxx5L2nludeXt11158vpWrcPBFx11Bt1r+m4r9Iah/FJSerZABN3wrzjz1AwRvSREiMN7MOGWEqri3UkZe18X3VHCpSk2GWWcULHo1qaPeVktUKFDe1hMg09cC7IE14FVAnS60DWPOXGzcbuIiQ21cry13WQBklFWJt/ISNwbZQ/wVXReVV/aenlyFeVpG4bF6nTBBIkZ8X0cNjzbEo+P0GJ+Rh+WFYSv3FmMlWXgbuMl4ySyZkqbLdUFdHNBRVt1lsuTrmdX1jYbQaSIkWkTdPVAiqyeDfQoSxXVJguuN6Ln1eQ2L3XWSdqKMkQVR3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 06:09:46 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 06:09:46 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Initialize idle masks as busy
Date: Mon,  3 Aug 2026 08:08:12 +0200
Message-ID: <20260803060930.4111746-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803060930.4111746-1-arighi@nvidia.com>
References: <20260803060930.4111746-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: a8831b61-d4e2-435d-edcf-08def125d122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4zhY5JNxwDXUGtiEjS480xbVvtOxHEJf/cu+NSGy1IVT+EAfK47YYGAnB08xY0+kwODObPZMNRK+RHNNjMU9dWjKceWl65OFmQ+YZnDv5J8A+yPTzeZcnh2sx+QjNv9jhK75VOw0od6vMmcL9xe/qGShrMXIokibiEDCazBrBI+4N7O9VdbVnsPfiGguVT8sl0aiuQN/2ImfF+2rzfOLMaWYBXE1ZNYmvv2HH3Ijac0SU0nGVS6rpkeZy4IA9Si/euPmO5AdHskKeA9MUTXxvjznb5kL0kWWhffw1jqQNIc6xXV6bE8n5nHhHAfJBNz0/VhIOA8a5J0SsEQqoc4tjgqub3UMHMTVRZ9BfK703ufQ5Tn7Ol8uFjPZSLB8/OZ9h/xolA+s3Cwp/+vT8NDjR8VuqXWU49L1jFSOL6t8hfKI+2r0SBgqJyTooeGKQ417x9znkzYSrHrDTII4ztCTu8wL6snU+nlY0QqfsBgHNS7T+eUAqVpDolhZsltXPgY2Jl6hLP1+w8Ox40mzvZ2pHoFDnw+2Qziu4trFX98KDJAidnF+V4S7keGhjn323gDnRKCYeGW7IVfhRd/PD9Gp2PBgO0ae7zOGNAjdHpkLpnsrcO6Jx2rbAx4v6NbHfHm8KvaKZAzeFGXfgdEk0ws4nmiz/MKY/sokNBUMe+dkUb8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PU4otI3kECr75Jld9creVQcLK3NtI9aFwSMOyMgvYAiPLHWq7vhCVW7nfIgh?=
 =?us-ascii?Q?1550SVLeAszKrxjKlKPVlaTDGtvsarWg0bz5YaTbDdm2Ktaqb28H1h1iOWm+?=
 =?us-ascii?Q?W1E0HE4bEjAiNdVUrIQYJ/L5c/gDk40WP5+AOx8UCuO3nb0gzx8F80uESkkA?=
 =?us-ascii?Q?tnbF7fOwCGpCn1dXx7mxo+UdTwDGLFh8I2aw7TiIx6MwbjuHBZDh4xDfdAmM?=
 =?us-ascii?Q?crhe///O+m7x0PpC1MTsgooVYx2oxEN3xIxenI6y5a18hs0iYyRi7dnEQtOu?=
 =?us-ascii?Q?uUt2KDb3qfxuK5/GvtrdFRL+n9jqtnUATiNmAhcsABcblgXuyakBO05K5bIu?=
 =?us-ascii?Q?eHC9/K8t6TmP+bRPlmswhHeQ5qcLsHk3bg4rj9WHCokA/NcgyK4VXPJz2r9y?=
 =?us-ascii?Q?3EmleX0ys5VsvSfUAgztsmgAdMbyKmywxsOY/v4EbVnXcyJw/U+NVdALCFsJ?=
 =?us-ascii?Q?+aw5CkExXjFZIbgtgdUfvwm6KqL8Lg1w1sJIFQ7PSQYlfP2S2oGTjYZK7hIa?=
 =?us-ascii?Q?aIjIQz4m61dwL06do3sm1lxNQYrmXrbnEOKapeWNgc4GsbGbodEPBxzNaAa0?=
 =?us-ascii?Q?o+GRN/p3WdSP0b35prcsSseMnkyhRhvrbv7lu5jFNXJGdyrSMbPpK3NpvD+p?=
 =?us-ascii?Q?/iCA2ueOSJVsAeebAjvwaBlsqWchpTVltr28dpmJ15zu4h52VeG6+Xj03RwT?=
 =?us-ascii?Q?E3/xyHgo5BKtxuWVhyr+P45I/FmMQXDnIPHagPBocsntXfZk76T37Semb7Gu?=
 =?us-ascii?Q?xe3nztXcrk1528l4S7S2PzFWT/AXIafK2I6ud+6fiSFf4B5pEa5RLNMYWfvj?=
 =?us-ascii?Q?XbdnK9zO87pliqCmHzPJw0/uptf1rOmQtNTJ+LLwlQ9/podCn0SsSrxkYzEg?=
 =?us-ascii?Q?uU1A3zMBfqj/Bw7nwp/OKfcx7QCsmIStLTog3YaLQmSsmwnhbrdL7JL9DP2F?=
 =?us-ascii?Q?l5SHLQG5NQOfpSXjSWBcbAo5Q+diCddfhDRNmyiJblpMtF7JIMhBS11ZZhll?=
 =?us-ascii?Q?Y0rCRb7DZXGYyvKV5NbChqQQfFedbgpJQWPSzQq9/1wRd4XnwAPNvvjwEVlX?=
 =?us-ascii?Q?uTfijw6XS/KXdeQEzaGQwJAeeTqoDvMdODP5ab0UDv207/eu0PE/Tu3HKfu1?=
 =?us-ascii?Q?FHWkY31c0VdH/l41wWNINVGF/7CvWAAAwSU9RKtv0+kYP+MTfILw3UQ7UY2f?=
 =?us-ascii?Q?jtkq0levkhnzvD56r0JYwQqMxaV7e8vBhD2oIyQzl1Xmri8N8vfOBLYW77Zs?=
 =?us-ascii?Q?Fmt4qDcAi7V4zYxy66qZdJV16RdKOyo7Dp1jzNPfyoD1YeDCABuogn2hQJQ7?=
 =?us-ascii?Q?81rK+9pySrSQI7mJy1l56FIgjklBovnNMmNVDQlhNNASHIxgzRWCbVzT74wn?=
 =?us-ascii?Q?hhsLRA7ITEGbwX9Sv7tmFhMKfa9E/jDkgpPf1wFXLpBhJMnq1wvq/rSwmT/b?=
 =?us-ascii?Q?faW+anCWxNQ99mn+R9cx5m1gd0SJT2JjBixcNE2CQi8+GyIZVROTim346Vyh?=
 =?us-ascii?Q?98NxoIAof4sQdiCyUxfJYVaThQi26FREsHKunOAbyRgFvoR/JimAgy/Wy8oh?=
 =?us-ascii?Q?yrExhq/4I8TseY4w2zOrP4xVHt73yE0Q/StGdIykhsyReFWgcoTQefZB17A+?=
 =?us-ascii?Q?6ojYuROtJ/mUmpAxoCH4RomaGygYCDkzf/Rt+fbv73qp10LGNcPaFc0DGBbY?=
 =?us-ascii?Q?HDB12qRQIdM5k9VGF7JnXm8Kfhlp1IiD8+qaJcc3yug3Pmxqu/SGnkMuqJD3?=
 =?us-ascii?Q?nSYWgm+z2Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8831b61-d4e2-435d-edcf-08def125d122
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 06:09:45.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GuH2GcjKVI4z4Vgmc0i6OxlJHFcNarWSrnd6w3wPQ3VyK5L2ThoCZ+lMbUiDIcZQTLleA2TFafJBNVzTA6taQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300

The built-in idle masks are reset with all online CPUs marked idle
before sched_ext is enabled. Busy CPUs can therefore be incorrectly
advertised as idle until their next idle transition.

Initialize the masks empty so that the initial state is conservative.
When bypass is lifted, every CPU is rescheduled and idle-to-idle
re-picks populate the masks with CPUs that are actually idle. Later
idle transitions keep the masks up to date.

Cc: Kuba Piecuch <jpiecuch@google.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/idle.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 3e9d6a44bf431..33bd51ab3cede 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -838,20 +838,20 @@ static void reset_idle_masks(struct sched_ext_ops *ops)
 	int node;
 
 	/*
-	 * Consider all online cpus idle. Should converge to the actual state
-	 * quickly.
+	 * Start with all CPUs marked busy. The idle masks are populated when
+	 * bypass is lifted and each idle CPU is forced through an idle re-pick.
+	 * This may temporarily omit idle CPUs but never advertises a busy CPU as
+	 * idle.
 	 */
 	if (!(ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)) {
-		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->cpu, cpu_online_mask);
-		cpumask_copy(idle_cpumask(NUMA_NO_NODE)->smt, cpu_online_mask);
+		cpumask_clear(idle_cpumask(NUMA_NO_NODE)->cpu);
+		cpumask_clear(idle_cpumask(NUMA_NO_NODE)->smt);
 		return;
 	}
 
 	for_each_node(node) {
-		const struct cpumask *node_mask = cpumask_of_node(node);
-
-		cpumask_and(idle_cpumask(node)->cpu, cpu_online_mask, node_mask);
-		cpumask_and(idle_cpumask(node)->smt, cpu_online_mask, node_mask);
+		cpumask_clear(idle_cpumask(node)->cpu);
+		cpumask_clear(idle_cpumask(node)->smt);
 	}
 }
 
-- 
2.55.0

