Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C4432BDA
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355333; cv=fail; b=jHWtnTb7GSKk001JrDqH5+KQqKa/3ybUfqS+YTzeYR2kt1kJtg2TQAXHvXiqvwhD3mxgAe5HWIXwXjJ/jPVYS+amkp8coxgWklenBtP9xHKxCPPNz/Bj2fS9vsTq3lxI0/5OebZeO4EcvAbKLCvq/KYcJgsLNH/f3k7k8jm/wq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355333; c=relaxed/simple;
	bh=woD4EyhY+36tpclTmBn7X68GfQsTU6u0lB8/A8CYhMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QSkKVX90v8SVgvchaiEvLq4O06prrGui+NBevfTMeDhMUdE8MfBElLAhPvRAJzS4xg7PwyEx/ZS5oZU88rmQkrDwdnmzhDVEV7AN+PUhV2vzFKjXRuTa99f1C+/iWg1g7MPTH5F24cIrmUzVtkDuOeRXJnWLMtPopZhQa7B2pmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RE7Khc0G; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RE7Khc0G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAjqAJFaw+Hqkqz47WgdhWXy6MUZEIrUOEX5ygA4baGjf1gB5YHHVBfyyf/lBlQ2BEmZshXkjrpGU4kxQUIpWbql+GT3FmuoY/yweXwWsQRAQ1eZPr41f0C5VTJ87dj4TxoWVyOg+UrChLtp8iT4vXxmhgjngtcce10USTjRd1lr7AmU7bCQla/3vrxWpWXJOWJOxOm6R7aLGwfH/tgjrKIvMOEdez12ypzOfrdCiVrANpWoZr6NIZ8Vw05T2D4ZIYqsNtxeXHQ64vfciNoqRUUyJT1oqVm6DPjha7Kq2+n5biL5BDvNryJiAszLJwnaIGQKUF9DqEB/W8cBTX6EAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oyeb23Kl6+vP8iko11zu1bMnWW8aLx2ykmJGd66PrM=;
 b=a0VafBkB9TUrVDVs9UOFqYA8cGhQKFmF13Rzx+qv3ka22s85W3advg7t4tDow6jGAWhguslhOw+DVp9Znk1vj8NgBQkuzVW468vrW+LrJfsdqBSGHSE1NdTfuR5qX6/nWMb4vPIov3UJyeg/QlKN65WTtod42+XByn+1HzA6RzTpMyVtrvFUhx4M1ktx0JTyVni8TjvoJBynsrlWur98vmX1Ztsxlg720450nvU7hvQ41NiwkOEuI9/a/1f3T/ZwJ+9iWR1o1wQJW7oleMLAOR+fh31BmXGb/+tCO+tRu5BXIrVnINtZGK/vVns8sZL0s2Kf8MPRKn8JQyYpN0QsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oyeb23Kl6+vP8iko11zu1bMnWW8aLx2ykmJGd66PrM=;
 b=RE7Khc0G6LhwiFm39gwkr3BbjHiWtbEhoaZZaIvpfuHENzQMo6oDDOdncfe8U//8VpKsIf8cXbvs0eZ3OW0WJ1gbu5BG214q26Ow7UZzQ+FF0LYfDmIDrXGUa9bpQsf9ryISlSSqhc/rSRXViTsbF/+gaGSr4NHOmm5FXShWEODSrBzpvT2P8sLWN5bI5OZ5qhBQilx5HQqpAvqYfIz4MEnOjWgVhd26UBSpfFJk/7D7m0n+SHVoNvIdMj3K4N+FMQXlOozcD2m0iOjD9nN/vPekp0tk3pM0mQjwA0zsjxA1mG1eMs/VhJriBm3rxeXXtNIVz/tIFEKLPRrqnKDadA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 16:28:45 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 16:28:43 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Verify nohz_full tick behavior
Date: Mon,  6 Jul 2026 18:18:22 +0200
Message-ID: <20260706162819.650155-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706162819.650155-1-arighi@nvidia.com>
References: <20260706162819.650155-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2ba3db-a2a5-402e-a53a-08dedb7ba54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|5023799004|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	O2na4FLh89Wm2cJvliATDUsdbm8XPDuMCeC1tDRFcnPemCSSdWKNxblmTZc8ATbVq5yS2uy/JsSO9wLEmS12un++04kXls7mJZ6oSlEIAiR4qZZXElHze133qYASEMdzR5X+u3CAk0cYJAsTeaj+e1o/jkDAFJaLjpqTsXd3q49UmaTOHXrKEtdXgEwO/7qYWc+Qpx2AEHVHc0D0BwqC1yXBwTPpzg/qnfM1r10sh6Xr7lw5bYEnpn9myT+xnK3t3FlDnh8V6Te/+5VrC0e7oR6qsQ0d/P7jRXk+idVUm4CbfEYU4mZw5+bjr62W8tKYu1QjXis+2m8urEb+eCZNdS1Qnno7v+b0DU9+crqdKX41Hzpn0a5rx6IPuDKEU2F8ERYS/NiNibKAh5cA238VmNo01LvrjlsnWA5JLLVvoC1hODFXny1iRh47SX7O77wPZ8NQutyRANR7eXBnlyj73qXoTr7g1MFORWy4xoxxGxF+Dnl9nDMlgPd9vZnnGY2xCk5A1ZNUPga+ggADUd5A1MAT+NSxlx5nryih7K3LQVJWBxzJ33s2HbeeKrbSOZo54E8Y5pesYgwe+djHneTVujJMIXqKpWQiiSDTH42lS2uf8bXpVMhoQMOGS2qt4T7IrS85S+24YblbRcn19TqOFQmSzR5ITkb1zlz7Cu4cdV8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(5023799004)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ol93LYX0gzyAGWZ/6YlBQebV51cXdaoTgGTFhkd3qtDipSQPodtBYZGmjo7r?=
 =?us-ascii?Q?jDybCY/gZ4QafVQZwfYUZIs9Lj8OWgAF2kLmUtCtniHEtkZfsQPB4jSbYU4L?=
 =?us-ascii?Q?P/6OZdYeFc/HF8LbXIWF3y74gY9rDga8Q9gWROkfWoy1z3nfYgTAT0yP42B2?=
 =?us-ascii?Q?GChpBA0Ev/DMWG+d3iJW1Vmi2n6vwHvSSe5xvh1cVhj1hQxKAK1pJLJfK2t+?=
 =?us-ascii?Q?w/rUvPkXFVlTUc3cHNAim0CxQTG8MYY24hZw0LtTZ16NWFaH7/xTgEgt078d?=
 =?us-ascii?Q?q1rZYlJhdHYKcPAKtouZbPVwMQHGxmjYd+BDLL7WYSQylDpgGI8sbpCVsBG8?=
 =?us-ascii?Q?A7kdghI/JHpb6G6kPAyOaMN7yfSJdNxRMERYUzXkr82MUWUmh2vZFIJtkn5o?=
 =?us-ascii?Q?3v1onZZ0tc3Z3tKr3SUwVMS4LLY4Dh6PjxdIFh9/4YU9lSmvJRStOOREEUCM?=
 =?us-ascii?Q?PvpoxL520EDws+3TfIhV50ln9yr9pRSn3gR1rM83V62YGYOSrg17u2BWQ8hj?=
 =?us-ascii?Q?r7QoAfbXkD06fEgMZjrfk8Mj++0DA71tL1fA1s8iZwfU20ArWfoWbdbNV/Q9?=
 =?us-ascii?Q?Vx//iSTOBwBIxpAAfB8nWZfoMWySMtMNxnkfKrRbOE1sdsO02KQJES3X8jnr?=
 =?us-ascii?Q?O555RQxBpEMpwmwduFmLtfnCE0/A81sYby6VMDpJgL/tvKAqwqGerFXpFexd?=
 =?us-ascii?Q?tSuUQQ1Ty6sxnlU7KDfq1y3nLqPhDbIvMj9q4mFKiomwOe0Mhfox7pjBse0I?=
 =?us-ascii?Q?9HkLD0wCQmKNt4HkG7yIQ+cskH51itLtpldsFXt+MxwFp7Z2g6nxgyUXmCqc?=
 =?us-ascii?Q?ToxkWfLor9GJZFCZXwr0lmdtFNxYRMtdBL3DOshHpJpe5nBhZ2WreWD2vTkW?=
 =?us-ascii?Q?laQJrmNfvubVQkro8W+Z9UUMaIndUi/BfsYA/gt7pwMGVArAWZhbPEh87MpP?=
 =?us-ascii?Q?spGB0NSuaeOWewCeHnKgZRvPEpU7kTMBDvJqcUr0/iuBNIokByPLg981US6O?=
 =?us-ascii?Q?Xz0qwn7bL/fvTTkxcnxC1O/iMratZ5ZP3hk/oDnhGXsn3idKVGmhlraRMu93?=
 =?us-ascii?Q?wuA18rIPSGaTKb3sS9qFELhZUd7MVjVnvbUmbcHUdjpVs8npdaX2geEJiF2a?=
 =?us-ascii?Q?kQg9kuPdA2E6FfbsLTeetFtZY5e9UZto25czD0Xx6QPjfD5nZHsdzvJIebvG?=
 =?us-ascii?Q?3iCLyFa5mRDE7w72VqSbe/59+Mp6wYYon5OpLgF1BCeuP0boy5e33Zz8+sDz?=
 =?us-ascii?Q?k2YJ3+Xa7tpcFXCf539PVyuq6f0oEe2zYgTf+zFhz6LdfgNJjBK++csV9LKM?=
 =?us-ascii?Q?bu6yzGTnUP0lU9AxWCK3CIXsw0noyY1KjbRGNtgHdSIPEJE+AAikU9oFpEIW?=
 =?us-ascii?Q?DnD3Zgpq3np0j0Jjo28Jj5/5LLarkbaEPAQlOOzFa6IbePN4WNkZrY5kL1fg?=
 =?us-ascii?Q?sU5CC7ulP6id/Rz6UOtE3p8k3wC0hsLd0PBD+bOabvxcXHTFtMZYOsABRg87?=
 =?us-ascii?Q?junWyKZSCzb2t17X7yX8vktKIYAokSwAD9y09IhtGehjm4Ez0FF68q3acjzU?=
 =?us-ascii?Q?7v8ROdIyYJ/LhjvJVRdK6ZmY/c0h7KGGy5elzRDzv0Oqk+FeUYOyDgJhcxj2?=
 =?us-ascii?Q?kxkq6S6JDhiHlSLJZImk5F/ZrppRtL4EIKvCqCd6CrUN/Dgc4tankcNOIN22?=
 =?us-ascii?Q?sdfCUtiU6sqbN86FU8k4lJOU5ztSRBQ4WAUhhHWZ5CWXY/GXL5n0C5fiZneW?=
 =?us-ascii?Q?Wp3VaiF4Ew=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2ba3db-a2a5-402e-a53a-08dedb7ba54f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:28:43.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EezqnornbdQQfSXzuCK0DYp1KPuKH6yeAY0ydnsk2PS/wns/sAw92ls0gjx1wTcsxEEHjInurFmiYVmeQ24sag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

A finite-slice EXT task needs the periodic scheduler tick to expire its
slice even when nohz_full is enabled.

Add a regression test to validate the proper nohz_full behavior:
 - the test selects a nohz_full CPU and first runs an EXT task with an
   infinite slice,
 - the task then is stopped, leaving the CPU idle with the tick stopped,
 - then run an EXT task with a finite slice and verify that its
   ops.tick() callback is invoked.

Skip the test when an allowed nohz_full CPU and a separate housekeeping
CPU are not available.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/nohz_tick.bpf.c       |  65 ++++
 tools/testing/selftests/sched_ext/nohz_tick.c | 309 ++++++++++++++++++
 3 files changed, 375 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/nohz_tick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/nohz_tick.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5d2dffca0e918..3cfe90e0f34fa 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -176,6 +176,7 @@ auto-test-targets :=			\
 	maybe_null			\
 	minimal				\
 	non_scx_kfunc_deny		\
+	nohz_tick			\
 	numa				\
 	allowed_cpus			\
 	peek_dsq			\
diff --git a/tools/testing/selftests/sched_ext/nohz_tick.bpf.c b/tools/testing/selftests/sched_ext/nohz_tick.bpf.c
new file mode 100644
index 0000000000000..6998c5dd6bcb9
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/nohz_tick.bpf.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ *
+ * Exercise tick dependency transitions between infinite and finite slices.
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+const volatile s32 test_cpu;
+bool finite_phase;
+u64 nr_inf_running;
+u64 nr_finite_running;
+u64 nr_finite_ticks;
+
+UEI_DEFINE(uei);
+
+s32 BPF_STRUCT_OPS(nohz_tick_select_cpu, struct task_struct *p, s32 prev_cpu,
+		   u64 wake_flags)
+{
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(nohz_tick_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	u64 slice = finite_phase ? 1000000ULL : SCX_SLICE_INF;
+
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, slice, enq_flags);
+	if (enq_flags & SCX_ENQ_LAST)
+		scx_bpf_kick_cpu(test_cpu, SCX_KICK_IDLE);
+}
+
+void BPF_STRUCT_OPS(nohz_tick_running, struct task_struct *p)
+{
+	if (bpf_get_smp_processor_id() != test_cpu)
+		return;
+
+	if (finite_phase)
+		__sync_fetch_and_add(&nr_finite_running, 1);
+	else
+		__sync_fetch_and_add(&nr_inf_running, 1);
+}
+
+void BPF_STRUCT_OPS(nohz_tick_tick, struct task_struct *p)
+{
+	if (bpf_get_smp_processor_id() == test_cpu && finite_phase)
+		__sync_fetch_and_add(&nr_finite_ticks, 1);
+}
+
+void BPF_STRUCT_OPS(nohz_tick_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops nohz_tick_ops = {
+	.select_cpu		= (void *)nohz_tick_select_cpu,
+	.enqueue		= (void *)nohz_tick_enqueue,
+	.running		= (void *)nohz_tick_running,
+	.tick			= (void *)nohz_tick_tick,
+	.exit			= (void *)nohz_tick_exit,
+	.name			= "nohz_tick",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/nohz_tick.c b/tools/testing/selftests/sched_ext/nohz_tick.c
new file mode 100644
index 0000000000000..5921bb9b9e83a
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/nohz_tick.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ *
+ * Validate that a finite-slice EXT task restarts the scheduler tick when it
+ * follows an infinite-slice EXT task and an idle interval on a NOHZ_FULL CPU.
+ */
+#define _GNU_SOURCE
+
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <scx/common.h>
+
+#include "nohz_tick.bpf.skel.h"
+#include "scx_test.h"
+
+#ifndef SCHED_EXT
+#define SCHED_EXT 7
+#endif
+
+#define MIN_FINITE_TICKS 3
+#define PHASE_TIMEOUT_MS 1000
+
+struct nohz_tick_ctx {
+	struct nohz_tick *skel;
+	cpu_set_t original_mask;
+	int test_cpu;
+};
+
+static int first_allowed_cpu(const cpu_set_t *mask, int first, int last)
+{
+	int cpu;
+
+	for (cpu = first; cpu <= last && cpu < CPU_SETSIZE; cpu++)
+		if (CPU_ISSET(cpu, mask))
+			return cpu;
+
+	return -1;
+}
+
+static int find_nohz_full_cpu(const cpu_set_t *allowed)
+{
+	char buf[4096], *cur, *end;
+	FILE *file;
+
+	file = fopen("/sys/devices/system/cpu/nohz_full", "r");
+	if (!file)
+		return -1;
+	if (!fgets(buf, sizeof(buf), file)) {
+		fclose(file);
+		return -1;
+	}
+	fclose(file);
+
+	cur = buf;
+	while (*cur) {
+		long first, last;
+		int cpu;
+
+		while (*cur == ' ' || *cur == '\t' || *cur == ',')
+			cur++;
+		if (*cur < '0' || *cur > '9')
+			break;
+
+		errno = 0;
+		first = strtol(cur, &end, 10);
+		if (errno || end == cur || first < 0 || first >= CPU_SETSIZE)
+			return -1;
+		cur = end;
+		last = first;
+		if (*cur == '-') {
+			cur++;
+			errno = 0;
+			last = strtol(cur, &end, 10);
+			if (errno || end == cur || last < first)
+				return -1;
+			cur = end;
+		}
+
+		cpu = first_allowed_cpu(allowed, first, last);
+		if (cpu >= 0)
+			return cpu;
+	}
+
+	return -1;
+}
+
+static pid_t start_worker(int cpu)
+{
+	struct sched_param param = {};
+	cpu_set_t mask;
+	pid_t pid;
+
+	pid = fork();
+	if (pid != 0)
+		return pid;
+
+	/*
+	 * Become EXT before touching the target so it stays idle until wakeup.
+	 */
+	if (sched_setscheduler(0, SCHED_EXT, &param))
+		_exit(1);
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask))
+		_exit(1);
+
+	for (;;)
+		asm volatile("" ::: "memory");
+}
+
+static void stop_worker(pid_t pid)
+{
+	if (pid <= 0)
+		return;
+
+	kill(pid, SIGKILL);
+	waitpid(pid, NULL, 0);
+}
+
+static int pause_worker(pid_t pid)
+{
+	int status;
+
+	if (kill(pid, SIGSTOP))
+		return -errno;
+	if (waitpid(pid, &status, WUNTRACED) != pid)
+		return -errno;
+	if (!WIFSTOPPED(status))
+		return -ECHILD;
+
+	return 0;
+}
+
+static bool wait_for_counter(const u64 *counter, u64 value, int timeout_ms)
+{
+	int elapsed;
+
+	for (elapsed = 0; elapsed < timeout_ms; elapsed++) {
+		if (__atomic_load_n(counter, __ATOMIC_RELAXED) >= value)
+			return true;
+		usleep(1000);
+	}
+
+	return false;
+}
+
+static enum scx_test_status setup(void **ctx_ptr)
+{
+	struct nohz_tick_ctx *ctx;
+	cpu_set_t controller_mask;
+	int cpu;
+
+	ctx = calloc(1, sizeof(*ctx));
+	SCX_FAIL_IF(!ctx, "Failed to allocate context");
+	if (sched_getaffinity(0, sizeof(ctx->original_mask),
+			      &ctx->original_mask)) {
+		free(ctx);
+		SCX_FAIL("Failed to get affinity (%d)", errno);
+	}
+
+	cpu = find_nohz_full_cpu(&ctx->original_mask);
+	if (cpu < 0) {
+		fprintf(stderr, "SKIP: no allowed NOHZ_FULL CPU\n");
+		free(ctx);
+		return SCX_TEST_SKIP;
+	}
+
+	controller_mask = ctx->original_mask;
+	CPU_CLR(cpu, &controller_mask);
+	if (CPU_COUNT(&controller_mask) == 0) {
+		fprintf(stderr, "SKIP: no housekeeping CPU available\n");
+		free(ctx);
+		return SCX_TEST_SKIP;
+	}
+
+	ctx->test_cpu = cpu;
+	ctx->skel = nohz_tick__open();
+	if (!ctx->skel) {
+		free(ctx);
+		SCX_FAIL("Failed to open skeleton");
+	}
+
+	SCX_ENUM_INIT(ctx->skel);
+	ctx->skel->rodata->test_cpu = cpu;
+	ctx->skel->struct_ops.nohz_tick_ops->flags |= SCX_OPS_SWITCH_PARTIAL |
+							   SCX_OPS_ENQ_LAST;
+	if (nohz_tick__load(ctx->skel)) {
+		nohz_tick__destroy(ctx->skel);
+		free(ctx);
+		SCX_FAIL("Failed to load skeleton");
+	}
+
+	if (sched_setaffinity(0, sizeof(controller_mask), &controller_mask)) {
+		nohz_tick__destroy(ctx->skel);
+		free(ctx);
+		SCX_FAIL("Failed to move controller off CPU %d (%d)", cpu, errno);
+	}
+
+	*ctx_ptr = ctx;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx_ptr)
+{
+	struct nohz_tick_ctx *ctx = ctx_ptr;
+	struct nohz_tick *skel = ctx->skel;
+	struct bpf_link *link = NULL;
+	enum scx_test_status status = SCX_TEST_FAIL;
+	pid_t finite_worker = -1;
+	pid_t inf_worker = -1;
+	int ret;
+
+	link = bpf_map__attach_struct_ops(skel->maps.nohz_tick_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		goto out;
+	}
+
+	/*
+	 * Establish SCX_RQ_CAN_STOP_TICK with an infinite-slice task.
+	 */
+	inf_worker = start_worker(ctx->test_cpu);
+	if (inf_worker < 0) {
+		SCX_ERR("Failed to start infinite-slice worker (%d)", errno);
+		goto out;
+	}
+	if (!wait_for_counter(&skel->bss->nr_inf_running, 1,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Infinite-slice worker was not scheduled");
+		goto out;
+	}
+
+	/* Block without exiting so the rq retains the infinite-slice state. */
+	ret = pause_worker(inf_worker);
+	if (ret) {
+		SCX_ERR("Failed to stop infinite-slice worker (%d)", ret);
+		goto out;
+	}
+
+	/* Let the target enter idle with its tick stopped. */
+	usleep(100000);
+
+	/*
+	 * The next EXT task receives a finite slice and must restart the tick.
+	 */
+	__atomic_store_n(&skel->bss->finite_phase, true, __ATOMIC_RELEASE);
+	finite_worker = start_worker(ctx->test_cpu);
+	if (finite_worker < 0) {
+		SCX_ERR("Failed to start finite-slice worker (%d)", errno);
+		goto out;
+	}
+	if (!wait_for_counter(&skel->bss->nr_finite_running, 1,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Finite-slice worker was not scheduled");
+		goto out;
+	}
+	if (!wait_for_counter(&skel->bss->nr_finite_ticks, MIN_FINITE_TICKS,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Finite-slice worker received only %llu scheduler ticks",
+			(unsigned long long)skel->bss->nr_finite_ticks);
+		goto out;
+	}
+
+	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+		SCX_ERR("Scheduler exited unexpectedly (kind=%llu code=%lld)",
+			(unsigned long long)skel->data->uei.kind,
+			(long long)skel->data->uei.exit_code);
+		goto out;
+	}
+
+	fprintf(stderr, "CPU %d received %llu finite-slice ticks\n",
+		ctx->test_cpu,
+		(unsigned long long)skel->bss->nr_finite_ticks);
+	status = SCX_TEST_PASS;
+out:
+	stop_worker(finite_worker);
+	stop_worker(inf_worker);
+	if (link)
+		bpf_link__destroy(link);
+	return status;
+}
+
+static void cleanup(void *ctx_ptr)
+{
+	struct nohz_tick_ctx *ctx = ctx_ptr;
+
+	sched_setaffinity(0, sizeof(ctx->original_mask), &ctx->original_mask);
+	nohz_tick__destroy(ctx->skel);
+	free(ctx);
+}
+
+struct scx_test nohz_tick = {
+	.name = "nohz_tick",
+	.description = "Verify finite EXT slices restart the NOHZ_FULL tick",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&nohz_tick)
-- 
2.55.0

