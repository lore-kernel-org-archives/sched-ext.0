Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6231B803
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412774; cv=fail; b=RahSaUbXi/PqNdXeMfw0yu7O0Vidrd1ZrQNoDmvp4vqKufUxqSYoFWhmljkKqlwmTK+fqoCKFE+YmLEs/eRsWipiWMArXbgb9KF7XC7aweD/WdWDxgMwibICgVgJRg0GPzBJMduY12MoeM+4+QAYqqQr3FRiL4UBvQmW4MXZJo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412774; c=relaxed/simple;
	bh=1Uc70lQNHNeYORTtl/kxNW99uHsz6NJgRUPY/WBtmjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K5LgarXxXbyyMLxTETnIhm+ze4I4l4qzpf/vwWbR5I7l5XAUdnenUwdF3Gr0vbERqxBM+wRT0b2CPstGKkQDElrDkVpboDUeJpBI9Sftki2Nh0I/Ot6heAeARDVp7LyFTn5Gr1ZFVeutWSGMr9o25aqVT8lu7/HrDdhwpH3ZhCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PpOb4ufs; arc=fail smtp.client-ip=40.93.195.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PpOb4ufs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fe1IYHVqALv+mMx+0UbcySe8XK9rfx34/R/uTSAzQi4WXllWejit22/arqeSLPCOU4RzRNwDRBdNRBMoSORHVank5W8pbkm2dsl6Y6GXmiTxaYBIctkJpeAGZb68DATakI2Es69O4zsXIbyDEKQ7f17d5qCbeLDmRcOjqs3ZsLYbusx1W9O17XcWyi6oCRuJv9ohipzhTMQTNcZey4rCxPh+kPnmcThHiJpMFgFKUfJuas5nDwAQ/fnq1Fz3gKYBydL4FUDQiD2uTSGU0WQDguqUVpKEYiK5eFECwIh4vi6Ms6ogwref+M3me+OG7N1oSByRGuAISxdFXZzHsml5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VSA0LGFAc9G6OQVL/R4Y/K/DV1tB74pQIL29rhmKks=;
 b=dUQxT0gxfIcM8KOi/ZmIDa01KSLCmbf2xMS9Qc7qxeoVh3+9NZTai3slwDtgGqj8Oga2DuhEFa8N50+UhFe7m2+2BIJGXXRJvnXUDVdurUNDnNWUE0uWLI57rr4RT/jNBCAx8hda5DiVR328Wr5LGlVOf7OHrm5z+ZdVKxWSrXXBzyzOHOgdNW/Z7gs+f80FGS8AMw2gzqftfn8/WG4G1eC7Y7q35/bgenG82cgLvrpJQwc2gXeiKMBiCdfWbhQ+xgmzj2n96JwP0OYpjKa31thsHiygXJvQNKkDiiK2F54NxOaZn478bWtX7ogEfL6xGifj3he1b1MUawTYXayS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VSA0LGFAc9G6OQVL/R4Y/K/DV1tB74pQIL29rhmKks=;
 b=PpOb4ufs+5YwZV+LJpYoWykmQpi28pSixcllzaR/ZGEUS4PkBUJ0IFCr+wQ1b4eZ7ITbWpyYwdq2UKpjIUyrjSp8KZ2SOqTu4MmXL0n/aQhIhkSPQSdFC1GcyRvvM/ezAXhnsGkXoaRhqCUrAhJtGUBwLaNIAo+O9yToKt8xDOGX1q2v7chGX2VAPZTRui2cMYrvyVNZf/7rp+8l4i/2s0CIhuoFgUc/W4NcI15wa4YTOxl2YnYW1OZlrK6H1slwXG4nyCQTWLrH32onaULu3HToRynL4r1rHiPtWm1R2qR3TfKH/b7u83+cEcj6dJ0/RflbS2OATrXC/qdTOaiCPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 08:26:06 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:26:06 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Verify nohz_full tick behavior
Date: Tue,  7 Jul 2026 10:18:00 +0200
Message-ID: <20260707082537.918068-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707082537.918068-1-arighi@nvidia.com>
References: <20260707082537.918068-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c31fab0-ea7e-4f69-2a2f-08dedc0163c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|5023799004|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M0et2MxOtfibudQkipaL+P0kbiNNtRSk98si/EdFgp0CCYfQnEb6A7y/mJRqpVS8H16NryAMvBv9kCHZni9iiaHgaNbRHjeIh+KwrYcr3MD4VFXPLvFJID+jC5GDdDC6R1dVeIyFVG0FMxDqnZTqdPrdicAXHcmYmt2iYsxwO3cdxJ/i64VztyWEikVKv2YlMwdYvLcfbSSJhyCp/+UQpJ3PHb1jUVxCzol0+DdESCJ7ErCEH8W0F48V/1KSftn1YBddynyZR5X0jzQhOyq7W9UCzCTQVp2MAHQMU5HBt4xaiQfeLNp/rdq2wJZbDatFT80Q2Y1HIAuq0uaUzMepySaH6orMGu8U8BAj5RuSKWswsM+OODSz/WM0KrzNsYq8dEdXGrcRviTXXZc5Bk/nj6vczJyu+9WNrTqtyebWkCHJClFepHM20AhtdRAU1HW7eriytHI6NRyhzWCIUGn9Q3B0/m68LkrPeLkVCUw5Qgh+Hw9Tv7E3Z1J6Ux/3ac5WNnn3KSLJQP+lAUJbJCI0MxnujyOPMbMJL3MT2EW6riurRtLi5gwclUcONBBnXlGYW+F11oTe+8E4dS2zH0/rrw7PwP/+x6pgNqyNvET6QsNE22xWGlrw0Kv5WulcL3ZZrg/uAbJLmkEDutBxzPFS8PTe5cXZGiVn2qKaHoNWess=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p7fp294UJpXWhS7YQSg8DTXZaTxyqTIH8nrOD2QNbnN/NC8o0iH0PrRj+8Pk?=
 =?us-ascii?Q?Opf12HqMhwfk2KvTAXysx5cZXYCxDiaLXepXcUARjFfeUXaRaOFZn2mLHD1P?=
 =?us-ascii?Q?7617JuSb206uUCH2LJyLFotHk/6yyLiWYhMcigoINPHy2hjH+0WYCUwj3ZzQ?=
 =?us-ascii?Q?aSi8mHJcelggwembhrT3WD+z8jnXq0XwmVndCxLJZpDlN/qERdXSmeJmajOR?=
 =?us-ascii?Q?d25wQ+bUtr858qC+byMgdAmHfVUM/RY+ryuIzI4NHKNnmd9KjEhGJkBfYekL?=
 =?us-ascii?Q?/HPA1v4TQIG45EDTO7MT2BCpcICoOFVTRwu6v9XL0SMViIQ6806jFxLKDp3r?=
 =?us-ascii?Q?GbBOhClWEOTfek1/lrN/ZrmNFa2VNi2kyy3yH5jcvFFQ76qVc4Ccs7dG2gjl?=
 =?us-ascii?Q?d1i95R/i5CscIjY/9j0vI8t6Vz+NvOGJRhf/AEUog1DywpaukAFwt+ihvLqw?=
 =?us-ascii?Q?LyLR3LKoX5XuNPStOaxmijAQqK9ELjYNGCrNEpgBd8yrYOK+F7itzvLmkxIb?=
 =?us-ascii?Q?m5hbgZ1/dViPAEw5oi+R57lRiGVVYv0NhVK4R1+2pvEWodkI7LKdGfqkdmF8?=
 =?us-ascii?Q?PNQnqkkMocxSaJlimocdBh36KP1XxkBST/u2AgNzOhcrB3k5pigniPJ8lGj3?=
 =?us-ascii?Q?soCF1Ou0DfhSbPUCjbW8fTLvuPFeSDKBC1ndBjf2I+BHRiRV8WCDEsnCXLNO?=
 =?us-ascii?Q?+u+UT/KUiIKcR19eUuOnFbJVqr6s5ZszW6Tik9Lf6tpHHu0Xo5qwTV3HEEi6?=
 =?us-ascii?Q?wEyc866z968aovKR4dKoq+KBqR8koD7taHp4SdAv6Lwu4eO3YfJQx52SESFS?=
 =?us-ascii?Q?9nwVzzdBRq2g4BpgxTj4pnGZSLpwxlTyXLWgYJYi/K2wtQenbfw85BO/CFPa?=
 =?us-ascii?Q?07kxrFIlG9tcV5KCZra1sGaR0ZPsiA/Dd318xJ/ap/3Wo213GcCJK6PsI5eF?=
 =?us-ascii?Q?Z2T3W46Yvja/ddqAF1KZZrO8TTwDa3l5VlLciNkOUcBP8sIOWxWkfKpuHTK2?=
 =?us-ascii?Q?170vDRSrfUk5mnA9c/WqKic0TUT7fx3x+ZNbQ7Mwtn2RixY0DKPoAjIegthM?=
 =?us-ascii?Q?jd2zNjiMJe/uXLN4gkhhqCXzNctSUAtfv6SksAVNLLOmqEXaPV+a+dqmPi4g?=
 =?us-ascii?Q?ObQAadNe84XduwkF43idOsum1b2/eb4PWKhiCyiuYy98p6GShUYcEJ9DEKfi?=
 =?us-ascii?Q?DtSUMVIdeumDQGuTjniS9e+0dTD6/9oow+jICqrgvX6yTzmJFAg6ElP6NkZ/?=
 =?us-ascii?Q?Vxk3h0rNUehnHJ5cRauUpEjqEoXHkX+EokRzopUyp2TrWH+Mn+BJIGa8zO6V?=
 =?us-ascii?Q?0ujbxK9KlC4CJM+mMgmd7qCCMQS28MIqEdZrbXQpNSrNTssWxtlLrTaPg2Ht?=
 =?us-ascii?Q?sXGZvAVLp/QCYA2DZfX18ZYAs7Z7hfGs8K7N6rBnh6QoU3JZWx7MW6oj8Y1u?=
 =?us-ascii?Q?JmXsO0SUFA8Y9Hi0Y6M96SrX8AWHHlRcrRSQxJfog8k4Yz+wwt9hretw6G6H?=
 =?us-ascii?Q?3dKqXrhXWRWV7BUHTxI8oJ34P2/XKRYCvpJ/MMQ/qdwNcJ8eUc9turZGADHF?=
 =?us-ascii?Q?wGQan+oNBm1fbDsJ0ZkS3eJvVi6kCgji60Tnd3sh72wuIIoCKPrHNikfbSTg?=
 =?us-ascii?Q?W9TVqB1uIfvu1t9N8172Noh5L7+IGjlFSxbiPvg4c1zUHbRuhN8V+NSVX77K?=
 =?us-ascii?Q?hugL/DOc3CObrHfnsueDWMNiy7ZWJS3skhtpXX/PhY99rSvGu9IixM7M1d5T?=
 =?us-ascii?Q?Sjj62ePZwA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c31fab0-ea7e-4f69-2a2f-08dedc0163c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:26:06.2210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewn4jXYw13zB0qeOwps6V2eAjBsZSW5GI1rYpE6Whp3gwGsOdbULMr4fp1uEgpzKc68uldLlUgF5tbEHguyK/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841

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

