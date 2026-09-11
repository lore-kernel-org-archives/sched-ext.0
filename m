Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E7258B6D5
	for <sched-ext@lists.linux.dev>; Fri, 11 Sep 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156735; cv=fail; b=h0HZjb83aghDk3duuue/DPBo6nszWorAGlj1394I4fU/fwzXRNyL/5QvkBSrSgjMy2axOJ7j3tn1k55yRXQBeZSbLKbXM1SivFnHsuQaU26Eih1jrzOozX9x5C625Llc2wBYVJL1zm4IEDEAkYLXvQA7zzUm0/BuMGk8AMDvrRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156735; c=relaxed/simple;
	bh=jtImJBsmXzpnRrKOamrXMHsXsXaZj+ijv7qnB86j40w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EBzQeOq34LMlxwFAOUsit68K+TSrLhkKD76BOfwVX73zj751J3nNZPOdK6xtfFK6AhwLOPxZmRYlpM2i0lCj9RTUUt1Ryo6wIt68knyA7TfWIv4ajP2lvQDkBnMWcIBSaF/elnLPPtWenUruCaNAR0y15ccOCDYh94L4Hae5RV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JvORVk9S; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JvORVk9S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JT4ke7JeonwSkSd50MUr5Ciyz05ALaPP3+osTjUtxLkYyTfUHj5dxtLViS/Gjy9keflQ08yHaoz+Fn6N1FKxhZJ3EAv8EdAPJ8RgJcVqxBuLlA7gVafekAHJdW6ffLnv7+0zmd45PZDxUek7xfV8qjyu7j2SLII4GGWrmcfhK7NZ18T21jOJsLF2gUhDa7ZgqSU3iv+FIjxJ+FhfLjmNtJUG4Y5z7aVpSgR7EoMvCbsjvwQ1l3eAcUx2lVWPK3QuDlifIwCCQLD2F6qd8JIXHsfAC2jlBZ45yNL24ClQS9/6LM50rBPqUG2EM7Lj+pQli1oDn08bus8V5IbLusLPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYTfIIsyZVOnI6/3WNkzheGDxkMR/56so69HMd/F08E=;
 b=hE9eHvj8CNiW9SwQr/FweFmOnrcqf94UJi3ava6R6NcDjv+uES95RZez/MRPXbMStfWpd0dOumuL1fIYclqvwRgXHU26YWiLeK/nbVEnFTPR0uQyYh/0Quctncirs476GOOp9qVjzkCeNFBVTp3l1MXy21P8mvj1YksgobB4eIyXNKSt9thpSayXQ6Z7WUhKYxCm/F0Ajn6Lz2AgVQIn6EXJpYtyj2H5yAHrSfQvqHAvoNdkKenC2+JOgWKEvnAFjZTYILcSz8BHXt+thWITlBIiwkbDuMujMCyd7gPK31RuUAPXhLezQtZy09jOxOB4Sbup1ee9k2rAtjPuCW490Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYTfIIsyZVOnI6/3WNkzheGDxkMR/56so69HMd/F08E=;
 b=JvORVk9SOWlbAxZdB/9DCyzkArqx0dTd6yiSHkgjBJmSmCtmWBFpXoWvfpraO75Cmkf5fcPa+4laDsgxK39NQ9wSIdHkFt3slORWYo0mSv/LdGRnaBEk/cgT0y4e3QG6BYOw6fJ6+Mq5pdfeSD6TkVSxHqYUJgz645NHDSyzOnHKZDwjCQpx3fI13STgiV0/0d7kQ2RGg8h8kKkiaWEQUmqSxdhFdxrVZE44CtgBVMnichM+vjjs8FU0gAeSysmwZ8KJ9+1opR9fFHB6JtRevK4mcSVFqlZMQ5/C0An+Fta/956dc+J3/kNcUQAE6TdJOv2kDWdmUYk1hfvbNW7aQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 19:58:26 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 19:58:25 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Add kick selftest
Date: Fri, 11 Sep 2026 21:56:54 +0200
Message-ID: <20260911195800.974364-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911195800.974364-1-arighi@nvidia.com>
References: <20260911195800.974364-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::33) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f61d80b-d9ba-485f-66f2-08df103f0a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|11063799006|56012099006|6133799003|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	I5W59uj11dCb7I3yK2KB5uCAqJc9wqXnRv172ATLPO2LNNhEAl3Y4zzZYxwjRMkGuHoiT1j2++72iQG+Jz1Q1W9ev4CErVKkv3ZOcKajfyYfUUwGPaqbfbAvW/ubhIpa3xyx1/VJ/6mBR44w6rEpW4kJLCa7ibo95L+gzv9CbnxtEBaSaawIMrFwpF43zB1FDacglGxmwHR0LI+jfXMiN2JOFj5f0P3MQH4bAk0R5v8wJry3LoQomzXdml76mKnssG9eduWrcLZQbHDRlwk9PpgUdbEpXMVfITWz3X+INYBW0QdJIZPo7KvXx38nvIg4VChCck97CNQTu66tg4lIb9hRz26iNNOwprpx1o3wi0ZFCUyVRPkK9BEa6oBRLTdm1leMuLpEv/wspwUEOYRSERc06u1SMXAm8kml/uoS3Sx2uJudRqHkRAAD3rknlBthsX9PAlp/H1y1pTOCj4p8YXY633EbxIwz//qgWuph0S5NgfvHySCqJbzCqOJ1pS84oqToWGkou0Da0JEwqG+sXRzGNWbO4Ytp3YLN6dA8WlNnjrdrvqXHC4w9JO/+MJSiU++DFBDRR7Cv84CotIJtF/xmm3QN965OcLVTepJIJdBxEo3eEC/IApSidYoyL+kybwNV0nCoOy9gVVHE+sxGdvF3R/w0NzWlQyzcEJuow3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iW0xaM+Oq4rRaEeYKUj/pSUOxZ6FGQNUHh2kv0bzJTtDTsA725w588hsQx+r?=
 =?us-ascii?Q?Quywu/98PvgG/xUt4GDSwpTmg2DP5XKOb6w6mt4qC44zGWslK6Gda5GORwa7?=
 =?us-ascii?Q?xHONWxYAMLap2A/AdK5cNYR4tix1OpbIH93pxUUZelML2ratP74M6npjNp0A?=
 =?us-ascii?Q?y2VjCmNYjUQ3O2UgVF1CXGIMKmp+ldkZ6XwWWVpQQ3yu0keI+R3ykZatKy4C?=
 =?us-ascii?Q?N7xxKf+OBq35A0g4l7FsxEwVI7PpCrBMfVvM+mJjDQGTr1GZm/0STR3HPbDp?=
 =?us-ascii?Q?VWeFKYGvtP6BK0+9IfQ//AguvDRokvbYRqdWodRzmQWLC8A+Ipe+A2HNFMA4?=
 =?us-ascii?Q?1ocenihzAYFSedOqplKrpiz6QVfeLX8MasY8/RTiUtQZhZFKdTKXc/6l1DPc?=
 =?us-ascii?Q?st4Wd+FH+ngE4skpe7JKrIcnIAYhQGBvFqSXt9UkkSGXvVl4mFRYcQ9C7T7Z?=
 =?us-ascii?Q?YjwnaZCDj6+jvuEQwYvLGITJZVgjdtGwTYuecCG22Kz1+kDbwX900DRU/hkJ?=
 =?us-ascii?Q?maocukMyGrgmO5FjTvd68v2OwYUvOr8PJaA+Ijl+db35DMdW0yOKmH0hEkqx?=
 =?us-ascii?Q?RQpGwEHnVJBDeInFfbXbXsPfcIUn2jn75TnqSdedAcB8puN7jJaqwC41f5Mf?=
 =?us-ascii?Q?EW3qQknI7nsdfYy4DEGTx6svOIzI8dlTWzqU0c0XpeootyOFht0aHeipn4gX?=
 =?us-ascii?Q?DXQEHs1rp3x8Dyy1r+zQeof6YymqiYp0jFU33UrzpgAaKHyMqsp14Qkj/HCx?=
 =?us-ascii?Q?9O/pdYLSt6sNg38iKYe6AwOUnjFSFyp9nlakr1plohvHpwc1rMLpdbnc7PIF?=
 =?us-ascii?Q?qNs/yW3+Pu0EwDDavKy/NJxU9kPTPaf5+fkWE1P3ccQrUO/x29F1Eb3B+nv0?=
 =?us-ascii?Q?Dt6U18AwbVF+RERCo1+6XhNh0mbslx8Qn3NhiJi/raqGpiWqIcSwIEs1Hp3q?=
 =?us-ascii?Q?9hS1p16tAwKyp1EJnNSLGjwbV7pLj/U9gDfdY0I4q2jtKmOhGaQ2vpJl2ZI+?=
 =?us-ascii?Q?nHWZ0z/W+yycffKuz6H9DUg+sM6+Yd97kGZu3BatNOK5ETKocF9BPStnafPP?=
 =?us-ascii?Q?igXr6EJ/T5fUe+uPuv/ZbS5PU0GbreQQZ47+0T46tu8KxwXPkP5frsZIupFd?=
 =?us-ascii?Q?ZgOzaDCnR+wJJCfoZoTTzPXx9ldTxYVpCMrFjbItfHdiSTuZxerXhfEBTkPW?=
 =?us-ascii?Q?Jif968cJVdMPKUvlJ3NDwS9kFtzXsK+zW7a6rXQZ6Wgto2QztLiyRxO+53aY?=
 =?us-ascii?Q?MaUtYkn3fAOEDaMtZDGF9vCyKa3KHi9N4xhqqhEZX4uWtwlT2kSQolS2yLAM?=
 =?us-ascii?Q?7ZkYUt1mira27Q4BEzVAkuwuGh0Y4sMP00WxbJff89FuVAv9qwAfHr4bMj/k?=
 =?us-ascii?Q?LclalY2Lb14xy0UK5hAclB2lJeEeJ02iF2esL4pc0MVttGtnAb32rVKwJSke?=
 =?us-ascii?Q?Vnm/zn56Vk0oSniW/em95VSYHTuRBY9ZM1006l+wgWUyLJKwhxlhtjn29JDD?=
 =?us-ascii?Q?wL2XlQOAPKZKyNfefxAqZ3B0PHYP2Anqg6GlQv1Ha4VZ1/IsU4QKqFS5qCJa?=
 =?us-ascii?Q?jTNfd/wdMP9IhAgIuJEezIe1AlIbEzYq485Re7N83TLtWN4fctCtV5RW6DJL?=
 =?us-ascii?Q?s6FKC53cYdJ3nEpSlyZIfpMAAAXsMdZEuclaDmaKpxhECwQpGVE1wyvVSTtr?=
 =?us-ascii?Q?8otTjyZxf9ERNsv5UlsAy65ls9SKPAHL+nuu5lCTGjr7jOhtKJO3LLrG8U3r?=
 =?us-ascii?Q?/l46urxNBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f61d80b-d9ba-485f-66f2-08df103f0a84
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:58:25.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4n/PguRIBZwDELMzKS2GmBspNHoMlwHS/XitYU8y9ACo1simIMALERJWk+Yx4Uc4cwd5gG0+k/FmtNYQe59XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

Add trace-based coverage for immediate and lazy preemption kicks. Run a
CPU-bound sched_ext victim and issue each kick after the victim starts
running.

Use an fexit probe on __resched_curr() and the stopping callback to
verify that the victim starts with a positive slice, has a zero slice
after the rescheduling request is processed and subsequently reaches a
scheduling boundary. The probe also records the requested TIF for
comparison against an immediate-kick baseline and the active runtime
preemption mode.

Issue lazy and immediate kicks in both orders and verify that the
recorded TIF matches the immediate baseline. Keep the invalid flag checks
from the original test.

Register immediate, lazy, coalescing, tick-expiry and invalid-request
coverage as separate tests. Probe the running kernel BTF before using
each kick mode to skip unsupported modes instead of failing or
accidentally issuing a zero-flag kick.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile   |   1 +
 tools/testing/selftests/sched_ext/kick.bpf.c | 144 ++++++
 tools/testing/selftests/sched_ext/kick.c     | 479 +++++++++++++++++++
 3 files changed, 624 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/kick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/kick.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5f5dd9ab903ae..c4ec9b21a4c2a 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -172,6 +172,7 @@ auto-test-targets :=			\
 	exit				\
 	hotplug				\
 	init_enable_count		\
+	kick				\
 	maximal				\
 	maybe_null			\
 	minimal				\
diff --git a/tools/testing/selftests/sched_ext/kick.bpf.c b/tools/testing/selftests/sched_ext/kick.bpf.c
new file mode 100644
index 0000000000000..031856f990cef
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/kick.bpf.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+enum kick_scenario {
+	KICK_IMMEDIATE,
+	KICK_LAZY,
+	KICK_LAZY_THEN_IMMEDIATE,
+	KICK_IMMEDIATE_THEN_LAZY,
+	KICK_PLAIN_THEN_LAZY,
+	KICK_LAZY_THEN_PLAIN,
+	TICK_EXPIRY,
+	INVALID_ENQ_BOTH,
+	INVALID_KICK_BOTH,
+	INVALID_KICK_WAIT,
+	INVALID_KICK_IDLE,
+	INVALID_KICK_UNKNOWN,
+};
+
+enum kick_state {
+	KICK_STATE_IDLE,
+	KICK_STATE_ARMED,
+	KICK_STATE_QUEUED,
+	KICK_STATE_RESCHED,
+	KICK_STATE_DONE,
+};
+
+const volatile u32 scenario;
+const volatile s32 victim_pid;
+const volatile s32 target_cpu;
+
+u32 state;
+u64 slice_before;
+u64 slice_at_resched;
+s32 resched_tif;
+
+UEI_DEFINE(uei);
+
+static bool is_trace_scenario(void)
+{
+	return scenario <= TICK_EXPIRY;
+}
+
+void BPF_STRUCT_OPS(kick_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	switch (scenario) {
+	case INVALID_ENQ_BOTH:
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
+				   enq_flags | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY);
+		return;
+	case INVALID_KICK_BOTH:
+		scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_PREEMPT | SCX_KICK_PREEMPT_LAZY);
+		break;
+	case INVALID_KICK_WAIT:
+		scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_PREEMPT_LAZY | SCX_KICK_WAIT);
+		break;
+	case INVALID_KICK_IDLE:
+		scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_PREEMPT_LAZY | SCX_KICK_IDLE);
+		break;
+	case INVALID_KICK_UNKNOWN:
+		scx_bpf_kick_cpu(scx_bpf_task_cpu(p), 1LLU << 63);
+		break;
+	}
+
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(kick_running, struct task_struct *p)
+{
+	if (!is_trace_scenario() || p->pid != victim_pid)
+		return;
+	if (__sync_val_compare_and_swap(&state, KICK_STATE_ARMED, KICK_STATE_QUEUED) !=
+	    KICK_STATE_ARMED)
+		return;
+
+	slice_before = p->scx.slice;
+
+	switch (scenario) {
+	case KICK_IMMEDIATE:
+		scx_bpf_kick_cpu(target_cpu, SCX_KICK_PREEMPT);
+		break;
+	case KICK_LAZY:
+		scx_bpf_kick_cpu(target_cpu, SCX_KICK_PREEMPT_LAZY);
+		break;
+	case KICK_LAZY_THEN_IMMEDIATE:
+		scx_bpf_kick_cpu(target_cpu, SCX_KICK_PREEMPT_LAZY);
+		scx_bpf_kick_cpu(target_cpu, SCX_KICK_PREEMPT);
+		break;
+	case KICK_IMMEDIATE_THEN_LAZY:
+		scx_bpf_kick_cpu(target_cpu, SCX_KICK_PREEMPT);
+		scx_bpf_kick_cpu(target_cpu, SCX_KICK_PREEMPT_LAZY);
+		break;
+	case KICK_PLAIN_THEN_LAZY:
+		scx_bpf_kick_cpu(target_cpu, 0);
+		scx_bpf_kick_cpu(target_cpu, SCX_KICK_PREEMPT_LAZY);
+		break;
+	case KICK_LAZY_THEN_PLAIN:
+		scx_bpf_kick_cpu(target_cpu, SCX_KICK_PREEMPT_LAZY);
+		scx_bpf_kick_cpu(target_cpu, 0);
+		break;
+	case TICK_EXPIRY:
+		/* no kick: the slice runs out at the tick */
+		break;
+	}
+}
+
+SEC("fexit/__resched_curr")
+int BPF_PROG(kick_need_resched, struct rq *rq, int tif)
+{
+	struct task_struct *task = BPF_CORE_READ(rq, curr);
+
+	if (!task || BPF_CORE_READ(task, pid) != victim_pid ||
+	    BPF_CORE_READ(rq, cpu) != target_cpu || state != KICK_STATE_QUEUED)
+		return 0;
+
+	slice_at_resched = BPF_CORE_READ(task, scx.slice);
+	resched_tif = tif;
+	state = KICK_STATE_RESCHED;
+	return 0;
+}
+
+void BPF_STRUCT_OPS(kick_stopping, struct task_struct *p, bool runnable)
+{
+	if (p->pid == victim_pid && state == KICK_STATE_RESCHED)
+		state = KICK_STATE_DONE;
+}
+
+void BPF_STRUCT_OPS(kick_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops kick_ops = {
+	.enqueue		= (void *)kick_enqueue,
+	.running		= (void *)kick_running,
+	.stopping		= (void *)kick_stopping,
+	.exit			= (void *)kick_exit,
+	.name			= "kick",
+};
diff --git a/tools/testing/selftests/sched_ext/kick.c b/tools/testing/selftests/sched_ext/kick.c
new file mode 100644
index 0000000000000..652f4c3add54b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/kick.c
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ */
+#define _GNU_SOURCE
+#include <bpf/bpf.h>
+#include <linux/sched.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <scx/common.h>
+
+#include "kick.bpf.skel.h"
+#include "scx_test.h"
+
+#define WAIT_LOOPS 3000
+
+enum kick_scenario {
+	KICK_IMMEDIATE,
+	KICK_LAZY,
+	KICK_LAZY_THEN_IMMEDIATE,
+	KICK_IMMEDIATE_THEN_LAZY,
+	KICK_PLAIN_THEN_LAZY,
+	KICK_LAZY_THEN_PLAIN,
+	TICK_EXPIRY,
+	INVALID_ENQ_BOTH,
+	INVALID_KICK_BOTH,
+	INVALID_KICK_WAIT,
+	INVALID_KICK_IDLE,
+	INVALID_KICK_UNKNOWN,
+};
+
+enum kick_state {
+	KICK_STATE_IDLE,
+	KICK_STATE_ARMED,
+	KICK_STATE_QUEUED,
+	KICK_STATE_RESCHED,
+	KICK_STATE_DONE,
+};
+
+struct victim {
+	pid_t pid;
+	int start_fd;
+};
+
+struct observation {
+	u64 slice_before;
+	u64 slice_at_resched;
+	s32 resched_tif;
+};
+
+static bool enum_supported(const char *type, const char *name)
+{
+	u64 value;
+
+	return __COMPAT_read_enum(type, name, &value);
+}
+
+static int pick_target_cpu(void)
+{
+	cpu_set_t mask;
+	int cpu;
+
+	if (sched_getaffinity(0, sizeof(mask), &mask))
+		return -1;
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++)
+		if (CPU_ISSET(cpu, &mask))
+			return cpu;
+
+	return -1;
+}
+
+static struct victim spawn_victim(int cpu)
+{
+	struct victim victim = { .pid = -1, .start_fd = -1 };
+	int ready[2], start[2];
+	char byte = 1;
+
+	if (pipe(ready))
+		return victim;
+	if (pipe(start)) {
+		close(ready[0]);
+		close(ready[1]);
+		return victim;
+	}
+
+	victim.pid = fork();
+	if (!victim.pid) {
+		cpu_set_t mask;
+
+		close(ready[0]);
+		close(start[1]);
+		CPU_ZERO(&mask);
+		CPU_SET(cpu, &mask);
+		if (sched_setaffinity(0, sizeof(mask), &mask))
+			_exit(1);
+		if (write(ready[1], &byte, 1) != 1)
+			_exit(1);
+		close(ready[1]);
+		if (read(start[0], &byte, 1) != 1)
+			_exit(1);
+		close(start[0]);
+		for (;;)
+			asm volatile("" ::: "memory");
+	}
+	if (victim.pid < 0) {
+		close(ready[0]);
+		close(ready[1]);
+		close(start[0]);
+		close(start[1]);
+		return victim;
+	}
+
+	close(ready[1]);
+	close(start[0]);
+	if (read(ready[0], &byte, 1) != 1) {
+		close(ready[0]);
+		close(start[1]);
+		kill(victim.pid, SIGKILL);
+		waitpid(victim.pid, NULL, 0);
+		victim.pid = -1;
+		return victim;
+	}
+	close(ready[0]);
+	victim.start_fd = start[1];
+	return victim;
+}
+
+static void stop_victim(struct victim *victim)
+{
+	if (victim->start_fd >= 0)
+		close(victim->start_fd);
+	if (victim->pid > 0) {
+		kill(victim->pid, SIGKILL);
+		waitpid(victim->pid, NULL, 0);
+	}
+}
+
+static bool start_victim(struct victim *victim)
+{
+	char byte = 1;
+
+	if (write(victim->start_fd, &byte, 1) != 1)
+		return false;
+	close(victim->start_fd);
+	victim->start_fd = -1;
+	return true;
+}
+
+static bool wait_for_state(struct kick *skel, u32 wanted)
+{
+	int i;
+
+	for (i = 0; i < WAIT_LOOPS; i++) {
+		if (__atomic_load_n(&skel->bss->state, __ATOMIC_ACQUIRE) == wanted)
+			return true;
+		if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE))
+			return false;
+		usleep(1000);
+	}
+	return false;
+}
+
+static enum scx_test_status trace_one(u32 scenario, u64 ops_flags, struct observation *obs)
+{
+	struct bpf_link *ops_link = NULL;
+	struct kick *skel = NULL;
+	struct victim victim;
+	enum scx_test_status ret = SCX_TEST_FAIL;
+	int cpu = pick_target_cpu();
+
+	if (cpu < 0) {
+		SCX_ERR("No available CPU");
+		return SCX_TEST_FAIL;
+	}
+	victim = spawn_victim(cpu);
+	if (victim.pid < 0) {
+		SCX_ERR("Failed to spawn victim");
+		return SCX_TEST_FAIL;
+	}
+
+	skel = kick__open();
+	if (!skel) {
+		SCX_ERR("Failed to open scenario %u", scenario);
+		goto out;
+	}
+	SCX_ENUM_INIT(skel);
+	skel->rodata->scenario = scenario;
+	skel->rodata->victim_pid = victim.pid;
+	skel->rodata->target_cpu = cpu;
+	skel->struct_ops.kick_ops->flags |= ops_flags;
+	if (kick__load(skel)) {
+		SCX_ERR("Failed to load scenario %u", scenario);
+		goto out;
+	}
+
+	bpf_map__set_autoattach(skel->maps.kick_ops, false);
+	if (kick__attach(skel)) {
+		SCX_ERR("Failed to attach __resched_curr tracer");
+		goto out;
+	}
+	skel->bss->state = KICK_STATE_ARMED;
+	ops_link = bpf_map__attach_struct_ops(skel->maps.kick_ops);
+	if (!ops_link) {
+		SCX_ERR("Failed to attach scenario %u", scenario);
+		goto out;
+	}
+	if (!start_victim(&victim)) {
+		SCX_ERR("Failed to start victim");
+		goto out;
+	}
+	if (!wait_for_state(skel, KICK_STATE_DONE)) {
+		SCX_ERR("Scenario %u stopped in state %u, exit kind %d", scenario, skel->bss->state,
+			skel->data->uei.kind);
+		goto out;
+	}
+
+	obs->slice_before = skel->bss->slice_before;
+	obs->slice_at_resched = skel->bss->slice_at_resched;
+	obs->resched_tif = skel->bss->resched_tif;
+	ret = SCX_TEST_PASS;
+out:
+	stop_victim(&victim);
+	if (ops_link)
+		bpf_link__destroy(ops_link);
+	if (skel)
+		kick__destroy(skel);
+	return ret;
+}
+
+static bool observation_valid(const struct observation *obs)
+{
+	return obs->slice_before > 0 && !obs->slice_at_resched;
+}
+
+static int active_lazy_mode(void)
+{
+	char buf[128];
+	FILE *file;
+
+	file = fopen("/sys/kernel/debug/sched/preempt", "r");
+	if (!file)
+		return -1;
+	if (!fgets(buf, sizeof(buf), file)) {
+		fclose(file);
+		return -1;
+	}
+	fclose(file);
+
+	if (strstr(buf, "(lazy)"))
+		return 1;
+	if (strstr(buf, "(full)"))
+		return 0;
+	return -1;
+}
+
+static enum scx_test_status setup_immediate(void **ctx)
+{
+	if (!enum_supported("scx_kick_flags", "SCX_KICK_PREEMPT")) {
+		printf("SKIP: SCX_KICK_PREEMPT is not supported\n");
+		return SCX_TEST_SKIP;
+	}
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status setup_lazy(void **ctx)
+{
+	if (!enum_supported("scx_kick_flags", "SCX_KICK_PREEMPT_LAZY")) {
+		printf("SKIP: SCX_KICK_PREEMPT_LAZY is not supported\n");
+		return SCX_TEST_SKIP;
+	}
+	return setup_immediate(ctx);
+}
+
+static enum scx_test_status setup_tick(void **ctx)
+{
+	if (!enum_supported("scx_ops_flags", "SCX_OPS_LAZY_SLICE_EXPIRY")) {
+		printf("SKIP: SCX_OPS_LAZY_SLICE_EXPIRY is not supported\n");
+		return SCX_TEST_SKIP;
+	}
+	return setup_lazy(ctx);
+}
+
+static enum scx_test_status setup_invalid(void **ctx)
+{
+	if (!enum_supported("scx_enq_flags", "SCX_ENQ_PREEMPT_LAZY")) {
+		printf("SKIP: SCX_ENQ_PREEMPT_LAZY is not supported\n");
+		return SCX_TEST_SKIP;
+	}
+	return setup_lazy(ctx);
+}
+
+static enum scx_test_status run_immediate(void *ctx)
+{
+	struct observation obs;
+
+	SCX_EQ(trace_one(KICK_IMMEDIATE, 0, &obs), SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&obs));
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run_lazy(void *ctx)
+{
+	struct observation immediate, lazy;
+	int lazy_mode;
+
+	SCX_EQ(trace_one(KICK_IMMEDIATE, 0, &immediate), SCX_TEST_PASS);
+	SCX_EQ(trace_one(KICK_LAZY, 0, &lazy), SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&immediate));
+	SCX_ASSERT(observation_valid(&lazy));
+
+	lazy_mode = active_lazy_mode();
+	if (lazy_mode > 0)
+		SCX_FAIL_IF(lazy.resched_tif == immediate.resched_tif,
+			    "Lazy mode used immediate TIF %d", lazy.resched_tif);
+	else if (!lazy_mode)
+		SCX_EQ(lazy.resched_tif, immediate.resched_tif);
+	else
+		printf("INFO: preemption mode unavailable; lazy TIF was %d, immediate TIF was %d\n",
+		       lazy.resched_tif, immediate.resched_tif);
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run_coalesce(void *ctx)
+{
+	struct observation immediate, lazy_first, immediate_first;
+	struct observation plain_first, lazy_then_plain;
+
+	SCX_EQ(trace_one(KICK_IMMEDIATE, 0, &immediate), SCX_TEST_PASS);
+	SCX_EQ(trace_one(KICK_LAZY_THEN_IMMEDIATE, 0, &lazy_first), SCX_TEST_PASS);
+	SCX_EQ(trace_one(KICK_IMMEDIATE_THEN_LAZY, 0, &immediate_first), SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&lazy_first));
+	SCX_ASSERT(observation_valid(&immediate_first));
+	SCX_EQ(lazy_first.resched_tif, immediate.resched_tif);
+	SCX_EQ(immediate_first.resched_tif, immediate.resched_tif);
+
+	/*
+	 * A plain kick in the same batch doesn't clear the slice by itself.
+	 * The lazy preemption must still expire it, and the plain kick must
+	 * still reschedule immediately, whichever came first.
+	 */
+	SCX_EQ(trace_one(KICK_PLAIN_THEN_LAZY, 0, &plain_first), SCX_TEST_PASS);
+	SCX_EQ(trace_one(KICK_LAZY_THEN_PLAIN, 0, &lazy_then_plain), SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&plain_first));
+	SCX_ASSERT(observation_valid(&lazy_then_plain));
+	SCX_EQ(plain_first.resched_tif, immediate.resched_tif);
+	SCX_EQ(lazy_then_plain.resched_tif, immediate.resched_tif);
+	return SCX_TEST_PASS;
+}
+
+/*
+ * A slice running out at the tick reschedules immediately by default and
+ * lazily with SCX_OPS_LAZY_SLICE_EXPIRY, the way fair.c expires a slice.
+ */
+static enum scx_test_status run_tick(void *ctx)
+{
+	struct observation immediate, lazy;
+	u64 lazy_flag;
+	int lazy_mode;
+
+	SCX_ASSERT(__COMPAT_read_enum("scx_ops_flags", "SCX_OPS_LAZY_SLICE_EXPIRY", &lazy_flag));
+	SCX_EQ(trace_one(TICK_EXPIRY, 0, &immediate), SCX_TEST_PASS);
+	SCX_EQ(trace_one(TICK_EXPIRY, lazy_flag, &lazy), SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&immediate));
+	SCX_ASSERT(observation_valid(&lazy));
+
+	lazy_mode = active_lazy_mode();
+	if (lazy_mode > 0)
+		SCX_FAIL_IF(lazy.resched_tif == immediate.resched_tif,
+			    "Lazy slice expiry used immediate TIF %d", lazy.resched_tif);
+	else if (!lazy_mode)
+		SCX_EQ(lazy.resched_tif, immediate.resched_tif);
+	else
+		printf("INFO: preemption mode unavailable; lazy TIF was %d, immediate TIF was %d\n",
+		       lazy.resched_tif, immediate.resched_tif);
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status invalid_one(u32 scenario)
+{
+	struct bpf_link *ops_link = NULL;
+	struct kick *skel = NULL;
+	struct victim victim;
+	enum scx_test_status ret = SCX_TEST_FAIL;
+	int cpu = pick_target_cpu();
+	int i;
+
+	if (cpu < 0)
+		return SCX_TEST_FAIL;
+	victim = spawn_victim(cpu);
+	if (victim.pid < 0)
+		return SCX_TEST_FAIL;
+
+	skel = kick__open();
+	if (!skel)
+		goto out;
+	SCX_ENUM_INIT(skel);
+	skel->rodata->scenario = scenario;
+	if (kick__load(skel))
+		goto out;
+	ops_link = bpf_map__attach_struct_ops(skel->maps.kick_ops);
+	if (!ops_link || !start_victim(&victim))
+		goto out;
+
+	for (i = 0; i < WAIT_LOOPS; i++) {
+		if (skel->data->uei.kind == EXIT_KIND(SCX_EXIT_ERROR)) {
+			ret = SCX_TEST_PASS;
+			break;
+		}
+		usleep(1000);
+	}
+out:
+	stop_victim(&victim);
+	if (ops_link)
+		bpf_link__destroy(ops_link);
+	if (skel)
+		kick__destroy(skel);
+	return ret;
+}
+
+static enum scx_test_status run_invalid(void *ctx)
+{
+	u32 scenario;
+
+	for (scenario = INVALID_ENQ_BOTH; scenario <= INVALID_KICK_UNKNOWN; scenario++)
+		SCX_EQ(invalid_one(scenario), SCX_TEST_PASS);
+	return SCX_TEST_PASS;
+}
+
+static struct scx_test kick_immediate = {
+	.name = "kick_immediate",
+	.description = "Trace immediate kick slice expiration and rescheduling",
+	.setup = setup_immediate,
+	.run = run_immediate,
+};
+
+static struct scx_test kick_lazy = {
+	.name = "kick_lazy",
+	.description = "Trace lazy kick slice expiration and rescheduling",
+	.setup = setup_lazy,
+	.run = run_lazy,
+};
+
+static struct scx_test kick_coalesce = {
+	.name = "kick_coalesce",
+	.description = "Verify lazy kicks coalesce with immediate and plain kicks",
+	.setup = setup_lazy,
+	.run = run_coalesce,
+};
+
+static struct scx_test kick_tick = {
+	.name = "kick_tick",
+	.description = "Trace slice expiry at the tick, immediate and lazy",
+	.setup = setup_tick,
+	.run = run_tick,
+};
+
+static struct scx_test kick_invalid = {
+	.name = "kick_invalid",
+	.description = "Verify invalid enqueue and kick flag combinations fail",
+	.setup = setup_invalid,
+	.run = run_invalid,
+};
+
+__attribute__((constructor))
+static void register_kick_tests(void)
+{
+	scx_test_register(&kick_immediate);
+	scx_test_register(&kick_lazy);
+	scx_test_register(&kick_coalesce);
+	scx_test_register(&kick_tick);
+	scx_test_register(&kick_invalid);
+}
-- 
2.55.0

