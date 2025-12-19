Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01402E7621
	for <sched-ext@lists.linux.dev>; Fri, 19 Dec 2025 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766184327; cv=fail; b=nhUQM/oXlaJihLAehhqKoo91gA6/s1ZGTATi3h7XTNxxf9O4BhR6ug/WMXuq5QxvEbfwCiw26avLMB5rXn7sNPnlwZlJ5ZLdOXYfi5VSZ2fCnkywUuUDjYn8tRQwY6azz3vLIkau+bXESjyEzHLRnmFBHgKY7WHRmm8XxNTvrq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766184327; c=relaxed/simple;
	bh=xYqCVLyCBhykWcwx29H/kNhjUsiJBc29vetj32uIHKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXOH3h2ycN/NJZBxOzRD1FZjWcohKkhBHuS6ys5vRfbKKsb1rYVhCZ3/njyV+z3M5bKnrWGcYcggIvR+MzWJfM5ZAiptVefJ5aWrC+Z14DBFURxovzKm4C3pHR9BekEef3b3WQymCCmGd0S+fPllyvyyr+kq1wxyXl21MOXfrdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rm3mmQKO; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rm3mmQKO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=po4ySwuS2o0asN0cU2MneU4lufGJlf2yS1IlZ6yLTY+eTPLYgIGko8mgjoPnDoyb6EcLXCCgf/3NO6565gOHFMMiDk3ZDs3lJ5ibn4wUBEjO55r2e7lEwcczOYC5OepPzKZJG6LBHOCzHPe83b+LZ+WrlNMzmLz/9Qe0t7y+ka61cB6+9HmwJIXPfckJe1figfOMZ0qkarq41L8STyT0AdjVCfGC8el77at2rhIr+Tayvhjcm8zoIMsvgSIRirQ+rmPU0QCh2f7DTDM2wxYHfFxHcw0ctgNu/VFpUf6X3QjHG7ZMw6TJA31yPFSUCf8GArEm8KxW0i3IkoGB6ZSFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haKTM87/fxJGALS6AuoIgpxZKiHwu/UgmstUedxR5qI=;
 b=Tq4Zfy5+ugTALK8QR57jIn0GkAy1Lt9uYpoKib/tboWddIRw5PSobo/KGf0rl4bBbFwpjwSiaYO/NR+51y+EsrkUN++uV5lRdQWRt9HxdpyW1j17NEfoKZ4xrmkTrXKC2xloHA7JLVASYCjStJfUE2f1XJ/ETPzsllJLXmfiaZgfREaLM5cHSmW0Wab1lI5MOnndT+vZNufMDhaX7bXbGYuhjyMXBVJGoLi5zXMaffdRMl0mB/gz821/23pOIIfIwwJFEuC66wsM80LCdQCfn/+5nuz+M+RIHy+cO1iz61BS5Uv9a9f8FJV/C5tXaJVSEO8IuOrQwoqZYJbPOmzeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haKTM87/fxJGALS6AuoIgpxZKiHwu/UgmstUedxR5qI=;
 b=rm3mmQKOvdYB9n+jE3f0yveSB6/D7WJ2iXzqXDfjNSogeNw93FEdwYDFSZF/2yUxPyeHFyRO1hQJTtrr0G/eVgeMJqZ4OoG2CWLtU/nQOmh7g1RB6ok3bb/OkvQgeGpi+Rbv+NgEgIzURxzmypuVh4bMZuQQ36tQZc0cmx0s2aigckH6xR1b30aacgTpTVRU+It6K05cUHFntCbYsXZeoq4zLrappsci9tPZAbZxz4Tvy/Xm7v9423uZuAvknqEYkBQILPcx6RVN2DkZ7c78LPMAotpbXjwQmtFGYhdsmCzbD2PzQCS+/ATS3Pjg+S1/W3MKjWf7Whe9E95tiWcImw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 22:45:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 22:45:20 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Add test to validate ops.dequeue()
Date: Fri, 19 Dec 2025 23:43:15 +0100
Message-ID: <20251219224450.2537941-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219224450.2537941-1-arighi@nvidia.com>
References: <20251219224450.2537941-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5b0a64-55d8-4880-87c7-08de3f5049f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aL1nyIfZoqEUM4ze9y09+9+9+iI/xpRyHrVSYIwfeFKQephEglcEqfRMpIkF?=
 =?us-ascii?Q?IvFISHmuHJJ4dZw2Co5yaWwmqqdEZiAnvhG6Mh2Ub6WJzGLHStZLi71VO4Xy?=
 =?us-ascii?Q?zAB99Z2n9EwVxlML5/rPoK1NPGQlWUXU0odAVWlbi1xt4smQ6likCpAOg5J0?=
 =?us-ascii?Q?oBRLOz4JLohRRrJM196nG12MwK6hOlAL0XqQ6ClkUujD+/E5pBasrQGyW2Kf?=
 =?us-ascii?Q?UDQ/oA0Wql5KLN6E2c+Es7uNsqjfM9tGnojQQVnLgVjkuxk8Owelib6l1Gop?=
 =?us-ascii?Q?vzmlDGHFttD0LZPm/65V/hiEgMDZEHFljkitFTxEnDPOi/GDHQ7M7Q1kxxf1?=
 =?us-ascii?Q?xSu+P+fhqB54/PjvyhF5phXA48rgUC9uaFM/T/PckBzP69ij8PEi0pV6vX6M?=
 =?us-ascii?Q?4eudIxqf/epXaI3AuAWfw9jBCIifoeVhFzokY/ip28SDSDjkVQNxOqBj8gxJ?=
 =?us-ascii?Q?sj9WFwVA06YFJEo8OAzlWIwvkHQC8gaxki/FFRYyRQsNoe27F9Gf+bVFfDji?=
 =?us-ascii?Q?NEU5LtTgjRtJnr3TezkziV7BV9VuFLdAiEghwUQQEwL6jrys4qByh9MnzmMk?=
 =?us-ascii?Q?IRVxYR2DgYhx6Hp3BovxBJZsaTj7uKxL1ct9GU85Unz2V4X0JoFy9fnqy8hr?=
 =?us-ascii?Q?GlqaRmOIREht77lg7cTc/Sb3JDb6FTlI00U29uBfNMdf6o1aVO7ULscrqJd1?=
 =?us-ascii?Q?jotSFKmBjdPaseTW4L1K4zZ4TgtmmO8M/QeDCwGJjRdYRFMoDWwvNFU5zHrZ?=
 =?us-ascii?Q?718RGaa7HeO4g1acZ1wcwHA22v0oQW5ZsG2fo8BjjdYZRXALz7bnAHEFLZ6X?=
 =?us-ascii?Q?5yOE8Xoh9W8FLzCVM72PDdnyHSIICTewoUwwecNG8Myi2i0MrVPTqaHX+duk?=
 =?us-ascii?Q?eQfcvqW/4JPsM4NT+dpKIx8ZqKJzOao2n3e8HRcp9ITMD2/V1c7KH5a0Zgwt?=
 =?us-ascii?Q?hgeY/zRyWhEVNsJ56eNQfpJS/Ce0GU5Pwto4plCsjDeNND22Dl85rIImrZTj?=
 =?us-ascii?Q?0TNVbA/DHiGwSJDoag12vf67b2NVdNAcNE8ronN6QopNZ5STZXxFgsYffKU4?=
 =?us-ascii?Q?bzlU0SrxOjO6HkBAF3fWmsjGnS72OIvPMLlTubnNQVvdaIPq1SLOrUz5HXJ+?=
 =?us-ascii?Q?01Lfsm8AnhYsbi8j+0auby2ETcQhlN2sZCaVPeN/Fch0aq5RkbYn4S5UDQx2?=
 =?us-ascii?Q?SGh6v+vh5kyvBCQ/DmDz/IIlhhoA0kxAcI/9wL4JPeEHky+abnj8HfcpW1AR?=
 =?us-ascii?Q?J587yBU+9X2SuiFKXKsidsobiTuRf0r4vhuCX5tdZKF8zW1fdMmADztdAIhC?=
 =?us-ascii?Q?FgX2SSWmvJBVXArGSc/jD6d24e58IRvoD+XX4CTr5AJvLby22pXzVuMZlAQ/?=
 =?us-ascii?Q?qrc+8ibPUvQnPuGIfvoIxDkGD39NOVcR2SJmpUgeVCnUP/wHjsU881NccORb?=
 =?us-ascii?Q?gQJ2TrAKo6x4BcjOG9wNVi/eZItT08RM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?as+oy9urfhuET4DR86/npTiM+Ic20Ne2GEJeHP8H9/voJn2JzUdQS910xQ3C?=
 =?us-ascii?Q?CSW7b4KjA4VIs6s7jIAg2n/R8QU2pEgDtPC6JdAC6SR0MPuCugtx3tOfXfdW?=
 =?us-ascii?Q?13TbXTycRH3T3ep0LqsbQErxdH3+c78w6Cbf+iJKEaByXdbEECNIy/L4XH8J?=
 =?us-ascii?Q?ss9BGifhLBDm8kGPjdnYBjTjYnicvGFUImhep86Or1bfUP3YI6Zg5wswqQKw?=
 =?us-ascii?Q?8vxo2UnDywiV+eT+vvD+kcQfB0mZeEXDGOwFDMCvyVXOvzvGCrGC5A3MyBSE?=
 =?us-ascii?Q?HzSnpVdYrTFesda5Kz3/bm9YAah9b5DefbOvrYkoQEJTQqzuXvzvLpqtOVCw?=
 =?us-ascii?Q?G+7d3ZjbLukd0g0G01rxlEOEhfiHHveKeyMKfUzRLq+7Y02XKnMEoWn7Lch2?=
 =?us-ascii?Q?HwwFMrcLlOrXx4hzlFeiFxYu5ClP3AEThQ9QG91y3NJx98bIifyPVkeWhZpk?=
 =?us-ascii?Q?9DMooKi3X0EIHjV/2mmT1FTe6c5G/L9cN3TVL6ne+NIhK9mlhJ8GjjXyPGHM?=
 =?us-ascii?Q?0l4y6rBChH+p5397nVF5sdijlegBILqdm3yBP3EIZGPU+LkvDcSE+OODY42i?=
 =?us-ascii?Q?fK1UA/VgehvemOtH12tLANQ1D83UNeZ8hjX2XO532CAMBpphS8GzLqk1yeDq?=
 =?us-ascii?Q?H2b8P9ZUjXPSJHfMZiXtKsDwXPNvQNLcMH2XyEBwZ/Ulk21Uc4oASOASt8qD?=
 =?us-ascii?Q?uyRMS9zgJd14OysHJu5CwsK5kRb33HrV/34jzmIeFkeMEtxDL4jLIk6D0dj5?=
 =?us-ascii?Q?KtpSc/5bQKW72DjLUn6KLSgkCIzaxltUgBRhOAm3yyLIVTasH+mh23h9ZqFW?=
 =?us-ascii?Q?NoZlIX0W9yKstZ9nmEgsvnYg/O/WSrMBtP0vrw3uplk3MDiMAydhlXlJGVQL?=
 =?us-ascii?Q?VU1fmUPJLL4GopTWXj/f8bUZYcM2VA5lXiEUPfnB38OW3hqBaGRpHX6/ENRV?=
 =?us-ascii?Q?jYSSFLY/ZYSiucQ7ktqvk5KFbwotpdZW2yJ/G0xzXAB+eCvnZ00QWl3D3Bic?=
 =?us-ascii?Q?BqIW57wE6uIa1kqeqhRMbZZVmYAsgh4xBRl+hRDjh7ihlc4otJ6BeQTPgT4a?=
 =?us-ascii?Q?5XKU/GFlCOXszOkFOD4+latwnef5FbPjLXxZXTR2I8XggYboFX4SAkrMlpa/?=
 =?us-ascii?Q?4nLOp+bCejRSbPoWY2VyyZ03e+xgfrfB+Kl1ckKqzo9uWnit1hG9ChQK6lO0?=
 =?us-ascii?Q?f0n/bTVKK5zAvd4GV1aD3F5Di0nVdtZy867GNPTK6BrQnZSbnYbWViv5a3ul?=
 =?us-ascii?Q?MN3cV184+4R5KFsgUcZ89doLIfLwV9RlWngST/LE2FP5HtfqrSz/miGyWU0A?=
 =?us-ascii?Q?bJAjsJvuV5gyxBrxbGB2sySlgrJ+3qvrnzcxGfDCjpMQlJPFV1UokG1C/LZY?=
 =?us-ascii?Q?66bY0jLI1abP2znCZ1nxGYlWyxoT254EKgGsqy6RKruNDgPuKlPwAR9He3fT?=
 =?us-ascii?Q?mEFn8z1WCsJSB6iPwo9tJRiXjvY24GfqwuvyODIQXDuyGYYL5dIz2lCLrNgi?=
 =?us-ascii?Q?6qI3Z0ltj42gOjUpgavJGouFrL+1ArvFJIpeCY7jrX+ohGi9XFeA3XNKCgDt?=
 =?us-ascii?Q?pRQ77e2bQN4pwdd9aMMc+j7sqSTPHJ47Y+f0Q+PpH6YYA1gnYf9bgnmwkNcl?=
 =?us-ascii?Q?AWYRbCIhTDI89PaZo2UZ8gSgSmP49ho2U87oQpKIeD1GVEDh/paFccDeaOMw?=
 =?us-ascii?Q?wlHG24pumFy/zx+KPrUrAJ4DGb1I0p4v4SL7Wn6f2yOm5FlVNQRO/sy9HRYJ?=
 =?us-ascii?Q?sSr+E1JL9Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5b0a64-55d8-4880-87c7-08de3f5049f5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 22:45:20.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSe3338TBcUU6Ri2yF3+TXvCIEPQPIEypgAPT2nPYSH8lvpc1MFNvIW7xABiF0qp6kwUC0G6sxxryIHSahGgDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421

Add a kselftest to validate ops.dequeue() semantics with direct
dispatch, user DSQ dispatch, affinity changes and verify that any
ops.enqueue() is balanced by a corresponding ops.dequeue().

Cc: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/dequeue.bpf.c | 139 ++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c   | 172 ++++++++++++++++++
 3 files changed, 312 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5fe45f9c5f8fd..764e91edabf93 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 
 auto-test-targets :=			\
 	create_dsq			\
+	dequeue				\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
new file mode 100644
index 0000000000000..aae19bfd42f04
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates ops.dequeue() is called correctly:
+ * - For tasks on BPF data structures (not yet dispatched)
+ * - For tasks already on DSQs (local or shared)
+ * - That every ops.enqueue() is followed by ops.dequeue()
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ	0
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+/*
+ * Counters to track the lifecycle of tasks:
+ * - enqueue_cnt: Number of times ops.enqueue() was called
+ * - dequeue_cnt: Number of times ops.dequeue() was called
+ */
+u64 enqueue_cnt, dequeue_cnt;
+
+/*
+ * Test scenarios:
+ * - 0: Dispatch to local DSQ
+ * - 1: Dispatch to shared DSQ
+ */
+u32 test_scenario;
+
+/* Per-task state */
+struct task_ctx {
+	u64 enqueued;	/* was this task enqueued? */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+static struct task_ctx *try_lookup_task_ctx(struct task_struct *p)
+{
+	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/* Always bounce to ops.enqueue() */
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+
+	__sync_fetch_and_add(&enqueue_cnt, 1);
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	tctx->enqueued = 1;
+
+	switch (test_scenario) {
+	case 0:
+		/* Scenario 0: Direct dispatch to the local DSQ */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		break;
+
+	case 1:
+		/* Scenario 1: Dispatch to shared DSQ */
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
+		break;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dequeue, struct task_struct *p, u64 deq_flags)
+{
+	struct task_ctx *tctx;
+
+	__sync_fetch_and_add(&dequeue_cnt, 1);
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	tctx->enqueued = 0;
+}
+
+void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_dsq_move_to_local(SHARED_DSQ);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	struct task_ctx *tctx;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!tctx)
+		return -ENOMEM;
+
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_init)
+{
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(dequeue_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dequeue_ops = {
+	.select_cpu		= (void *)dequeue_select_cpu,
+	.enqueue		= (void *)dequeue_enqueue,
+	.dequeue		= (void *)dequeue_dequeue,
+	.dispatch		= (void *)dequeue_dispatch,
+	.init_task		= (void *)dequeue_init_task,
+	.init			= (void *)dequeue_init,
+	.exit			= (void *)dequeue_exit,
+	.name			= "dequeue_test",
+};
diff --git a/tools/testing/selftests/sched_ext/dequeue.c b/tools/testing/selftests/sched_ext/dequeue.c
new file mode 100644
index 0000000000000..0fd6748786079
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include <pthread.h>
+#include "scx_test.h"
+#include "dequeue.bpf.skel.h"
+
+#define NUM_WORKERS 8
+
+/*
+ * Worker function that creates enqueue/dequeue events. It alternates
+ * between CPU work, sleeping, and affinity changes to trigger dequeues.
+ */
+static void worker_fn(int id)
+{
+	cpu_set_t cpuset;
+	int i;
+	volatile int sum = 0;
+
+	for (i = 0; i < 1000; i++) {
+		int j;
+
+		/* Do some work to trigger scheduling events */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Change affinity to trigger dequeue */
+		if (i % 10 == 0) {
+			CPU_ZERO(&cpuset);
+			/* Rotate through the first 4 CPUs */
+			CPU_SET(i % 4, &cpuset);
+			sched_setaffinity(0, sizeof(cpuset), &cpuset);
+		}
+
+		/* Do additional work */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Sleep to trigger dequeue */
+		usleep(1000 + (id * 100));
+	}
+
+	exit(0);
+}
+
+static enum scx_test_status run_scenario(struct dequeue *skel, u32 scenario,
+					 const char *scenario_name)
+{
+	struct bpf_link *link;
+	pid_t pids[NUM_WORKERS];
+	int i, status;
+	u64 enq_start, deq_start;
+	u64 enq_delta, deq_delta;
+
+	/* Set the test scenario */
+	skel->bss->test_scenario = scenario;
+
+	/* Record starting counts */
+	enq_start = skel->bss->enqueue_cnt;
+	deq_start = skel->bss->dequeue_cnt;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dequeue_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops for scenario %s", scenario_name);
+
+	/* Fork worker processes to generate enqueue/dequeue events */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork worker %d", i);
+
+		if (pids[i] == 0) {
+			worker_fn(i);
+			/* Should not reach here */
+			exit(1);
+		}
+	}
+
+	/* Wait for all workers to complete */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for worker %d", i);
+		SCX_FAIL_IF(status != 0, "Worker %d exited with status %d", i, status);
+	}
+
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	/* Calculate deltas */
+	enq_delta = skel->bss->enqueue_cnt - enq_start;
+	deq_delta = skel->bss->dequeue_cnt - deq_start;
+
+	printf("%s:\n", scenario_name);
+	printf("  enqueues: %lu\n", (unsigned long)enq_delta);
+	printf("  dequeues: %lu\n", (unsigned long)deq_delta);
+
+	/* Validate that we got enqueue and dequeue events */
+	SCX_GT(enq_delta, 0);
+	SCX_GT(deq_delta, 0);
+
+	if (enq_delta > deq_delta)
+		SCX_FAIL("Too many enqueues without dequeues: %lu enqueues, %lu dequeues",
+			    (unsigned long)enq_delta, (unsigned long)deq_delta);
+	else if (deq_delta > enq_delta)
+		SCX_FAIL("More dequeues than enqueues: %lu enqueues, %lu dequeues",
+			    (unsigned long)enq_delta, (unsigned long)deq_delta);
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dequeue *skel;
+
+	skel = dequeue__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(dequeue__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dequeue *skel = ctx;
+	enum scx_test_status status;
+
+	status = run_scenario(skel, 0, "Local DSQ");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 1, "User DSQ");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	printf("\n=== Summary ===\n");
+	printf("Total enqueues: %lu\n", (unsigned long)skel->bss->enqueue_cnt);
+	printf("Total dequeues: %lu\n", (unsigned long)skel->bss->dequeue_cnt);
+	printf("\nAll scenarios passed\n");
+	printf("-> Validated: ops.dequeue() is called for tasks on local DSQ\n");
+	printf("-> Validated: ops.dequeue() is called for tasks on user DSQ\n");
+	printf("-> Validated: Every enqueue is balanced with dequeue or execution\n");
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dequeue *skel = ctx;
+
+	dequeue__destroy(skel);
+}
+
+struct scx_test dequeue_test = {
+	.name = "dequeue",
+	.description = "Verify that ops.enqueue() is balanced with ops.dequeue()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&dequeue_test)
-- 
2.52.0

