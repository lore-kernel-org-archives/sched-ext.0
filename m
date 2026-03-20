Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFC2DF6EA
	for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027720; cv=fail; b=mvYiZo5HCVept6sRYfAv/FZpyuLcqY4yFkdyDdkyrwLWrlhYsFaHQ/7K6rJ1MK422qoPiS26gkJILXcN32/1Ol8uraAGxmSkSCtS6pZpA9J3R+okLbVO0uCcsvudmNyXC2tWfu/bxrp9AU+oKdP2jv1g4tMEqstVuGjah6BdUSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027720; c=relaxed/simple;
	bh=IJN3JXMkhsUz4C3BR3TiOrtGrfYZ5l4tfxRY4Mo6cyM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bBTdK71bzhCjjExCXjXlqcsbxYxYCeTf0is312FO1SEaBU5199IfkpoiPIoA6L6Z/zNsum3K0gl/W1sl/F9Y5Ycr9kdn619APJS74JjqHL0b464PNHDBlfL0FJOrAnyXXdGOEj0VD6CqTwXpim64ESILRtc4h00oAdLdHV6Xh1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ek8mF434; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ek8mF434"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR1LZgbAHs/4ggtR9mZohI2rxNBbq8DM2keAIOX/Yxh4IOYxZtSakVy8qYiI3pA/jT9m+/vs49y/kGUJBBp9l/2RN9XtzdflbMDYNKKWmqCjATau328qS1zb5C3/tBJuVqNqNMyZBidqcQe8Se5wPXJymWlKsTyyWKJv93/3BrlynUVuxt95OQ9t9lvzF0POtK3eEsbs7RtwpKla2l5R3XtHS9JbVoIsxsT/RTG69r5umEb4470eDbQIed+GBVY5Rgc64Nq8xqHx9p3nXR9TuvR4kOalGa5rBBypUjLh9dDo2VkDMQ2T1EB1bZ+vcmGOauqEPq0utQnlI/VkZ77LZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O//A4Z8VJxizEn9SYV3+DlwtNHODfT+9y6qECG6UL+o=;
 b=PbU7Ph5PUenN0mwR63bs8N7eKsanecI7H0KeSnqQLr4wrU3EQl3e4UYPIaONdLo0aRcbTYcCxZ02etXzn06WfhzvvPpbWn5BeDNV/MlFXdZ+mFnCjWXoUwe9C1nLJLkv+/6rh/+ZVnnnMskUkXLttIscc4A28BBLqndraWa6+mkLMWd9vKjIWItB/urYHZ7CFzoumb/HZgbk7UC6S9exojBFryAMGujlCTFtslHG+5duB6ASGOfjrQafVXpmSO5HEfUxfmxtfkmwx5rmUpitTR5QWuapbQsFr+3I4XwuefVPtGyhVyht1xTtJrCg82oXf2ui2tzgv8C/208bngI//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O//A4Z8VJxizEn9SYV3+DlwtNHODfT+9y6qECG6UL+o=;
 b=ek8mF434euvbdUWEnIVMqSFdjCL2TS8eSWTiitqlMcF0bqQFGJg3hnMIBWI4CEMsCmxadd0d3QqAbXOpnuGC1tsigYBJ92Qz3l7cmPSf/rASopS7ugNfhLYy5DVkiZyIFPyTGbNatWPi9dHE1cEqGrrGBcJ7SveP0OabHeSMA7mc5D5SiwIcFTWzIi0ZE3Ke9naC99rE8ONyYoa/GPS7WGCSjlqZjbzdJqcPGIIbeAbW410Sif/sIcPE8P4UgmGKdRNXJn4fU5BL4hQKe5IDdesZ3I6faotFg61Z8uQChcYJ2FpFmkXAzvu4tkgVQi8HzQ3xZDky6Ko5Gv3taAZ5rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 17:28:35 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 17:28:35 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH v2 sched_ext/for-7.1] sched_ext: idle: Prioritize idle SMT sibling
Date: Fri, 20 Mar 2026 18:28:31 +0100
Message-ID: <20260320172831.365031-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: e1be9506-9309-40f2-2f6e-08de86a61d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7jz0lcm4WdacZtGXkcDCuScUIj5Jp1VC7WoB4rb66tObrA3JC5KOaIzXFP/tfPCig4mMeTMF6IwKcCQvGNVQigYOKkrQAGAV5oXGIMDyzsZ5yKuBmX/eADvKbEE1AGblbk2Z2FMm6RxMP6bTCvNP7yJ1jC10RTw8na0XupSy4emFr8aAxVIempr8fiWu0hK2NIKpCkAhd+HAoS3LHpR/j8D6k/52OUoFR1ZcMeYyQasbAe2TuNqsg+mvdFHwzoVFwSUOBYvRKSMLtiCymyJSFLYJBIafd2SXpaGoE2iVKErnPfWn5leHvPnS3ycQBpYRW66Wo0sVmEP/cJlcguymccD3qdjvVpJstIxbGHrXvcF5+D5EFgcFQbJ1Y830RZz6wHvK1os5TW8J/43tRMgL+Xj6P/h3WXqtxhmfs7cNORxokxu4wDhLfrYpNGEhh9w07GJaWnXToeYaQIszMl+tNNzD9+cTb4yWbAiWsLTZcVykcdkWIipwfM0JLcgrj8CALZJvHHCEqQRWvPqEm64BWACHsSdcRBKbgWbTeCSN2OXAKJXKDkKsnneJn95By7hgXR39jGFIint7WwgaWdWizTqPE2E0UnIqugOTjVPIBkJdiRP9yk2CwXnL6WbAhfn4g6RMRLHsJFWBbv3L3y/JFPEb/++QVk3e8rr4m1T/665GinzcF3rVKJWMup+mHfGBZ7/l+2GFqfJNX8UaTRi6iWSjuVXSBOfzqVcIP+zZDuotLl4q015gfXiOGPF8448o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c3EvQryA7g7kMTxDYum5o/T7LgXQeMst2AYi8yibLX0mGruor8VjBP07G+/A?=
 =?us-ascii?Q?TKOht8gKWoqFUU/NVZlMMMWZ7UNhqMm2i0vuLRwflz6bFPDlpHn4s4gfIkoU?=
 =?us-ascii?Q?Vc04eysaV0Luzi8wTsprtTWrv2qX8kkwkNNngSbD//E3lfQ31pYtYBalbYmR?=
 =?us-ascii?Q?j2vxQCe2dA4CZ7qxj63ApTISH8IWpNo8Bge3ZTVRLKBftI9obWZAvxiugbCi?=
 =?us-ascii?Q?nFI0jgaxZ+JNg3yeOMBlfFfaHVlPzrryWbwTEG5zG+WBzmcqAvcfx9B1p50Z?=
 =?us-ascii?Q?nEXZj723MpPsoLhqT7sqEc6Z+/1tIBaSC+tGyi2Stm1ahUBtlAMJdFzFI6ts?=
 =?us-ascii?Q?/FTecWh/X9hY69RSpWTQ8J+ymikB9lLgK3xbDLNW8+YoPyEJ1jmU51xMwQLx?=
 =?us-ascii?Q?LqGaLMpV+AiGfDe6R9t558d2hBrnfVCraNqENeENVNnEYzZyMpvN7CzItxmZ?=
 =?us-ascii?Q?KbUXyASf5GJlNKAaDs52h/m+5xd01b22yoqwSb+pEiqtaq3jWI9HaNoJG1hG?=
 =?us-ascii?Q?CQrxWF10Q+/f9ulgynREAhUXhu+JFFIzez5rh0FxetdXtqwiqy0KJN81dnFt?=
 =?us-ascii?Q?hX/MYatPkv4kYjxPsyUgzDeEpxpXGN69uLaiJ9LFkITZEe0PmsRIn3xSXy7h?=
 =?us-ascii?Q?L9y5L+Y92P2t01tAjUWZBvzEocgRQr5BJudb0iUwqjZyEERXVTLq5cr4IIPa?=
 =?us-ascii?Q?FdJvV3w+canlBxXhvboPV+Y+XOjRPsTecJqxyxu9U6WyoIzQ0w72aFR8lkHV?=
 =?us-ascii?Q?vE9ernH9bCblPM83PPmKBhhq3pSaAjHkmHXzzedOPBHypPVuL5f8RYX0aGaU?=
 =?us-ascii?Q?eR6HEq0t9bxpr6tvrycoKzDZh9kSZJ9YxwDZH06m+H52n3F5IoafPrDnQrlq?=
 =?us-ascii?Q?bPL64tl7//thFwkmCsundtNagYKtB8VQZ6SLJJRiASx8/r7//d0L1qB8hHZ+?=
 =?us-ascii?Q?Z4u+i7E/upRm4IWxpN0ru8STKsAoD2crUBy2LT1CFcQ1pmEIo/qQ+ybaby74?=
 =?us-ascii?Q?SydQzQkZVNbhTLXDJ/wd4RKiB3qNA94WPknAtXsD3eK3jg+HC4uRi9CVjcO5?=
 =?us-ascii?Q?1OXw+mpP9yoptAQuPlduD9YbQxXU2BTsGrVMBx2oRCYAWNDUsNHaAW+Io0ue?=
 =?us-ascii?Q?j2ZT4Ag9aaJ+lTfa8wzjHbTErQVKTXFkhiIWogzA5yaBVkv739XgyBJlC53x?=
 =?us-ascii?Q?eVKM7NGzjAYO8O4KeBtNOW8U7quFsvMs0E53qCWXiXLgGGYHwFg9ixP4xviD?=
 =?us-ascii?Q?6nJvhN1JNY8GEvRKT17/qFa+Hx58hNxvppD1tP0yQiiDlkIN5m6dNWyzEmGF?=
 =?us-ascii?Q?Iwpf3XYb2IXwL+8U5p4o746B3FGtwCmZnYMkfawDIJ+wRoWjfx4xoJjvnOot?=
 =?us-ascii?Q?YCqddlm/oX+vok0won8+dRLkWbil39jbbXTrZziig0lYNFwK/pAy72pTvnjx?=
 =?us-ascii?Q?4KFKaF1ew9Q+7r8oXRSxsGesg6gr7dOCheAfzqWrRjBzdcsGgWnFJsno40RV?=
 =?us-ascii?Q?EK92j0fgo9sHSe1ltjFXIMsX74B5EK1ZrF3kPRKHuGPbZABh4Igw/J+uGa1B?=
 =?us-ascii?Q?o2xkWvg9ps4anM9+bGg1lEe4EjyuoQRjVzXpJUcuRDPX5BW+mnNRo9/Ei39S?=
 =?us-ascii?Q?WioE4wIKMazpkx8nNXUj/fMXlR17zKMuJkXqDbf1TIwoFsl7Twn3yIJ0ijEi?=
 =?us-ascii?Q?nw20jms/TBotFI6fCtTPijhRblgfPctRDZUYqM4FoTXyKnqbq2Q1NNw82JLB?=
 =?us-ascii?Q?8TdJdJrkIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1be9506-9309-40f2-2f6e-08de86a61d51
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 17:28:35.0438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09kl7BwtDYY4eciVW+F44V32x8EW8bUNJWuqrIya8gxL3rxt0OdAA8y+yxRrRMtF6hOG69GJxg2J2S76ZoCKbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018

In the default built-in idle CPU selection policy, when @prev_cpu is
busy and no fully idle core is available, try to place the task on its
SMT sibling if that sibling is idle, before searching any other idle CPU
in the same LLC.

Migration to the sibling is cheap and keeps the task on the same core,
preserving L1 cache and reducing wakeup latency.

On large SMT systems this appears to consistently boost throughput by
roughly 2-3% on CPU-bound workloads (running a number of tasks equal to
the number of SMT cores).

Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Update scx_select_cpu_dfl() documentation to reflect the SMT sibling
   preference (Cheng-Yang Chou)
 - Link to v1: https://lore.kernel.org/all/20260318003842.762275-1-arighi@nvidia.com/

 kernel/sched/ext_idle.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index c7e4052626979..d9596427b5aa1 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -424,18 +424,24 @@ static inline bool task_affinity_all(const struct task_struct *p)
  *   - prefer the last used CPU to take advantage of cached data (L1, L2) and
  *     branch prediction optimizations.
  *
- * 3. Pick a CPU within the same LLC (Last-Level Cache):
+ * 3. Prefer @prev_cpu's SMT sibling:
+ *   - if @prev_cpu is busy and no fully idle core is available, try to
+ *     place the task on an idle SMT sibling of @prev_cpu; keeping the
+ *     task on the same core makes migration cheaper, preserves L1 cache
+ *     locality and reduces wakeup latency.
+ *
+ * 4. Pick a CPU within the same LLC (Last-Level Cache):
  *   - if the above conditions aren't met, pick a CPU that shares the same
  *     LLC, if the LLC domain is a subset of @cpus_allowed, to maintain
  *     cache locality.
  *
- * 4. Pick a CPU within the same NUMA node, if enabled:
+ * 5. Pick a CPU within the same NUMA node, if enabled:
  *   - choose a CPU from the same NUMA node, if the node cpumask is a
  *     subset of @cpus_allowed, to reduce memory access latency.
  *
- * 5. Pick any idle CPU within the @cpus_allowed domain.
+ * 6. Pick any idle CPU within the @cpus_allowed domain.
  *
- * Step 3 and 4 are performed only if the system has, respectively,
+ * Step 4 and 5 are performed only if the system has, respectively,
  * multiple LLCs / multiple NUMA nodes (see scx_selcpu_topo_llc and
  * scx_selcpu_topo_numa) and they don't contain the same subset of CPUs.
  *
@@ -616,6 +622,18 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		goto out_unlock;
 	}
 
+	/*
+	 * Use @prev_cpu's sibling if it's idle.
+	 */
+	if (sched_smt_active()) {
+		for_each_cpu_and(cpu, cpu_smt_mask(prev_cpu), allowed) {
+			if (cpu == prev_cpu)
+				continue;
+			if (scx_idle_test_and_clear_cpu(cpu))
+				goto out_unlock;
+		}
+	}
+
 	/*
 	 * Search for any idle CPU in the same LLC domain.
 	 */
-- 
2.53.0

