Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806E3E0236
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496933; cv=fail; b=b5BRUquLV41Ynbsl4tQev8QySUxhU3T5Slq5s+UlLwDexL9drYACyg1oEu0GbQ/4uVlPJWPMX3qwyKLwXNohDruBm1bjFNY2lFrY8Tj3BjC2rCdycaH0crkz/1BKbyrVRFVMU3wUHKficq7P/nQOkNYUmXVNGT3WIbZ9onMRuTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496933; c=relaxed/simple;
	bh=1Uc70lQNHNeYORTtl/kxNW99uHsz6NJgRUPY/WBtmjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kB+hlwJh9EMX3+hhnx0cfl1KytHXwnR9T0fE5acci4vb1Rf4kgsSqnSyWCFsAqZ4vyIeamsRa16p8mMhnX8ty6vymvu90HXs5OO47nf8RzJ0XZ8o3zjlDaKshDLBaGP/jlTCLyiOQuOYj/EBJ1eidjPuBaCeAp2PVmtYiUgyV5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lNq1hLWq; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lNq1hLWq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIO15LUHeE6vHLpVgJY4bx7bq8Cay3yfwrmivcr0eiABbjRmy+3pmMsCvPD0r2tV1c51x5+D8pm9awBYC0/aFFWPnuPgPYPaBRl7k55dfkFyJtulze/xWDVwAwqm9vuqKAKLX+V78plOZ63cGogzJfEu7Y9droIk2X7FJdV1TrS+YU2KA2Fn6iUu1k9yiRtVdfGUjdrSpXt50//uWPNs9qDEUtakQEu9j6GP5QjgByGE/oAO2r7gWtE8toAuFIxWeFkZpEteRLRg+9vWevzM9bEvHbkZ0VqSnm32FtNS/Gc0NDFsDL3bjG1vy43DLPVuLglpy0abG11cU/Hhw9+6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VSA0LGFAc9G6OQVL/R4Y/K/DV1tB74pQIL29rhmKks=;
 b=PrISHMYPMKLFRD+nq90LMEMv9o7Xd4tJUuuYJRPpdqER7DkEHBRz7yWJBYHxuUz0VNV46Qc8z+fj3uw7dkEqzsBAac3sfZ00SqrP8zocZS7MSbSpXDUDid5Bl1/ZHLEjIQm/63lGOOqMHVZCod5O5dpzerk0L4aIOeOpFFul8s/JWYanQ0BRVDYgH4m6dAgGQ786BP99eGa9ZhDbnJBdXRb9fusbxwquVAO1gt02YYEkhOHJUAVy4aqlsm2G/Z45Ma7d2f1KdmxDZ46ak56kag+qHXcFIQYBHwaQLg7btMSJKObGE76kNmiiTb1/0OUOd51L8s13vBu3zHGlk/SOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VSA0LGFAc9G6OQVL/R4Y/K/DV1tB74pQIL29rhmKks=;
 b=lNq1hLWqCN0Xyejl4w99LuDHvJB5PazG4k2XrbpdGwu86OKEEtv8cE4VNyQ0DWwow0+Fr130TYmMUyHUMSMdjgN9RmFqgQijExQcG9g9q83fBdOS4a+IPrHDyXLBIGEvJXqVVYu/PXgpZsf6YjhZ0Tp1sMVTUWEVdwJTOa1scqXZT/UHLC76o5hmcd3oIJqVIn29ZBsmf9BBP5hCAeQF1/c8GPsiX5AQX0i0CMAJtd+tpmDh5bfaSnzukN2xaaIORqZgNdhiu8IpTXxEF+ZG5vXZ6XSOn+JvWlSW0JTarivw7OQlbBpVyclJ5O6voisOdF59U9miVXS6nYATGz0dzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 07:48:36 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 07:48:36 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Verify nohz_full tick behavior
Date: Wed,  8 Jul 2026 09:46:49 +0200
Message-ID: <20260708074812.1041434-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708074812.1041434-1-arighi@nvidia.com>
References: <20260708074812.1041434-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: ee39dd4b-099b-472d-73dd-08dedcc55107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jlUtbM5gPAVAMERaoTYie/NYC+1OUHdbRxZIqsCiGM8M9UzxcHHicbNNJyW+LILTRsbBvzLgBAr5ni3BY+9w4G13nwUKf/yakz/LCrWGj4Zwl2r23G3ognZT2EKQ4EtyPwtVTn8UxmfQNn/ZXIYjUDrl0amDeI+FQyC9YhwfysCC/Qdw2V/c2SV1EHIqhvP0KiVsgyYcowI48Fd6EfaNcIU9M72Wz5ji3QEp2q+AeVd43u8AKcer/pXWIsJWXh6GuRbVq3+JSZHn9nGw3JCWgjXPzvTZkhXdMcdt/AsGk0Ye3NFz5Y2PJcL/qLoWYUsXQUxWyy31jWCFrDKVgEnUSUFiHzr23NEuM4v+wsJ404UbPHKjlFhE8bBSl1gPorYL0nXjULlvdNd6k/Gwmnpm6UzKT9CrX9dSArErJ4fC5UUU50lJ1P9eooPlXtU+BwWDRgNt8JXfIfK9ggE7geGMXjuxRZrbk0OMg7V9xrFW8Jm/OjfvMdruYiKSk9r/1ykac0HmOLhT0MuSwqgsYTibtQrpzJCz/vkyAKg1T2qkpkd2SUJEP7M/5atSmVZtyVxnUJWV+WGJyqiuwVfvuBvlACXGaQHDVEi1yXsymbzuL6g8l3GFhywp/SYv2qksn6+AGAIowfJ+YGv71DEfvSqGXmaoqbhP4g0CUJKgBltPyhY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SAYYLRIZPVmUFYI4dQ4r0KSMajWnBinoRFUMozYcwjhkupeX6KfN4/nc2JlF?=
 =?us-ascii?Q?pf3exLF254eIFLQSHDLhEOaTcV7kr9ilcBm4rPMzH7KmodWfvshE0nw09+R2?=
 =?us-ascii?Q?3WqnxeuJiISdYNOEVdOIsF/7atMm/DgYQkP7tybzla9qb3BMB1Ggi9XFJTPl?=
 =?us-ascii?Q?5XYdnfypj0x5dmcUpnmB+XJyQKCZAOlu58nn/5My052McpZ569lerVdHcNks?=
 =?us-ascii?Q?ueY9UnpZkeJPuIFPpyLnh1JxgYUnuW7RGtZSylKkWqIdROTvH4euGXUnjf9D?=
 =?us-ascii?Q?ZvZuRPr5v5dd75IyULmOzVdtI4YHgdo+FBeCdhujCNBA6F421FhCFfllUVq1?=
 =?us-ascii?Q?MX72Td/7Ub9P30wiGEBNusluunNk/jPojz/f3GRQGiU8Otk/xrbVgFynyOyr?=
 =?us-ascii?Q?e6F6ZekkY51O2mrEvBmChv//nyx3Omp3FH+6LjIWjebWC/6qPzFU9mKJn28A?=
 =?us-ascii?Q?M8P+ndqSVwkH1Dc2VlOD6NWPTfK+0QThzxry1UPuuZ+g/SdJpkCZ/JDnHClJ?=
 =?us-ascii?Q?uyoZjbKlvxGqhNGJwNITO8YTydAhF3j7ul9G45a+T26L4VvI3XQStVj7q0kw?=
 =?us-ascii?Q?MNSk9lNlV0NSrr3/00a0HCfVgO6eMOMrfmCX7LeVRHIIw+/jKAwnUMluDf6J?=
 =?us-ascii?Q?t1TMPsrlR+qZiw4joK2h5OX2xiNN68UkB08l1L+e9d71LSABx9FrcFdsRUJL?=
 =?us-ascii?Q?OK98nYGRV927Knfp0L3q+fy4MX4vZeUe6qRCvPEjDuvakiEpVGOdSJVpYXwX?=
 =?us-ascii?Q?97WVT4ApyE9v7g6fdQpVKYYPtVrrYz7r9povvnns/eP+XQwFf0VuNHiK/34C?=
 =?us-ascii?Q?rEkYY84t4J8gPvB0ChNLP47BNrmGtvNuJBIJL1XXA/2Ns1OFQT+0FCOsaohb?=
 =?us-ascii?Q?DK9GfWQFubmW56O7Snba74fAF2NYKjDZTYd2pSENaMJ3k6U78Ujl7p+l657Q?=
 =?us-ascii?Q?r0sOFGh7YDSJ4WLyAU2xtYtNLE0jz427r2a3PJbfBmER3KaLmBuzNdzpi/O1?=
 =?us-ascii?Q?EME4h7++gCJAUuZ5Ou93W5j+FI5JVAWmcE3BCMxWsd8SfFFbGMWy0WxaC9ML?=
 =?us-ascii?Q?2/0Akpwi7sEEcG/xTxb1SrXCq4KzzXBOY8nxhvWABE2kht3SxD2PrTTvq7g5?=
 =?us-ascii?Q?yMlLnglv6wzYTz35yRojMTtZ/NYvFaNVqLTrdiP+b5boP+xMHdSijccGBzXU?=
 =?us-ascii?Q?HpwuNbfQwKuQwcPKqHdA4HfoKjTbTg2bGE9XNSsiH5inwqjAg6ykxb43oxyw?=
 =?us-ascii?Q?bbG8l6jZ9k0Tj/PPHPu/s4VMSSr5wtyC+YNrmX3SPLInhhjKAj1/4TiY6RMX?=
 =?us-ascii?Q?fZTIXcs5Z+v3+GW8d7dG48Q10KSbObi5LxmmDeZ0AMlkL2YvTUMdfa4RNbhR?=
 =?us-ascii?Q?gA7YAXjcjVXVZiExx5ey7iBlubcl4V+NM6S/qrJKNMEcvEix3ar3/77O7YC5?=
 =?us-ascii?Q?ZYUNJMtlIMdPhxq8rDZgHQtenCcgpskB6w8FfIIRgdMKZ86leAECJa282Dsw?=
 =?us-ascii?Q?xC252UAQC8X1G1Vqb5auVzebFO93gklYNEjVAR0hn6IFGS1XZqpj0tZSBJCt?=
 =?us-ascii?Q?3r4hHbqdbueVMykOfpndo04urqRJmnP1JzVUy9lK3+Q1ANeN1qD8VqPggK8O?=
 =?us-ascii?Q?ZcjbFDc6um3ThmbRrZz+mgKmHHeKozqlXnZVvdu4IwtV48Z7lDitqWdk5brA?=
 =?us-ascii?Q?/+Q+nfqtQ5A5Q1VdLbv8X6Dwd2qs+pDS3dg32rZSd2jcJV6l0Xkj2pxuIdQj?=
 =?us-ascii?Q?lILCx2Nblg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee39dd4b-099b-472d-73dd-08dedcc55107
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:48:36.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt+tuU6qyop5eMs4QYGTI8T/XxVnWg27IdxEZuy7eQ6FHllD33ETvaYXZL3WAX34Zu8o9HpdGo90zQ4hoNjltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070

Finite-slice EXT tasks need the periodic scheduler tick to expire their
slices even when nohz_full is enabled.

Add a regression test that selects a nohz_full CPU and exercises both
infinite-to-finite and finite-to-finite slice transitions across an idle
interval. For each finite task, verify that its ops.tick() callback is
invoked.

Skip the test when an allowed nohz_full CPU and a separate housekeeping
CPU are not available.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/nohz_tick.bpf.c       |  65 ++++
 tools/testing/selftests/sched_ext/nohz_tick.c | 347 ++++++++++++++++++
 3 files changed, 413 insertions(+)
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
index 0000000000000..028f54391c2ca
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/nohz_tick.c
@@ -0,0 +1,347 @@
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
+#include <sys/prctl.h>
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
+	pid_t parent;
+	pid_t pid;
+
+	parent = getpid();
+	pid = fork();
+	if (pid != 0)
+		return pid;
+	if (prctl(PR_SET_PDEATHSIG, SIGKILL) || getppid() != parent)
+		_exit(1);
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
+	u64 finite_running;
+	u64 finite_ticks;
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
+	stop_worker(finite_worker);
+	finite_worker = -1;
+
+	/*
+	 * Leave the CPU idle after a finite-slice task. The next finite-slice
+	 * task must restart the tick even though the slice type is unchanged.
+	 */
+	usleep(100000);
+	finite_running = __atomic_load_n(&skel->bss->nr_finite_running,
+					 __ATOMIC_RELAXED);
+	finite_ticks = __atomic_load_n(&skel->bss->nr_finite_ticks,
+				       __ATOMIC_RELAXED);
+
+	finite_worker = start_worker(ctx->test_cpu);
+	if (finite_worker < 0) {
+		SCX_ERR("Failed to start second finite-slice worker (%d)", errno);
+		goto out;
+	}
+	if (!wait_for_counter(&skel->bss->nr_finite_running,
+			      finite_running + 1, PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Second finite-slice worker was not scheduled");
+		goto out;
+	}
+	if (!wait_for_counter(&skel->bss->nr_finite_ticks,
+			      finite_ticks + MIN_FINITE_TICKS,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Second finite-slice worker received only %llu scheduler ticks",
+			(unsigned long long)(skel->bss->nr_finite_ticks -
+					     finite_ticks));
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

