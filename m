Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275F3F0AA9
	for <sched-ext@lists.linux.dev>; Sun,  4 Oct 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098984; cv=fail; b=ijCADPXUInykjxo+sdzywVH9EZaU3LpO0Wpgwf9FUixP27b1ns9TkPcxGzM7SrFyUTjdwDwUmo6wJuUDkNFSUIYpHO0w2ERwS+MgpcPNb2cBUdZUShaB+YDGeZtEY1WrXW0FMWlHk+aPAHu5+lbSV2aLZ4g1VHD23oY03Q4s/3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098984; c=relaxed/simple;
	bh=qbqtdF8JPd47FByZeN+tljDdSAyvsZ6S6sg2xkCJtBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eo3Tj1mQxyZRrT2F1wpGjq6KTgQW815V3l0+VHvrm5IY+HlBBKBSaht0+w7SheDDCElZv0FP++/XwrPaj8+h6HxvSU1lbnNDHmPay4UWKYPL7V2sNvkr4Tn1+k6AJixv+x6zVqsYocZUeJPS5MhiuLfaubCfDfryHWWaoqRPq1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lBbYH49z; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lBbYH49z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZT++R7fHTMYZ70cKDW44vTdIJLbcPnKgnpMQjE0dcMAY7IF8Q+Vlppcb/uBjxpAFFlz8eBTBJzshuXb9nesgO96xWjz1354o7xUa279kG7AjKfa2UvLUABYlPpUdiZVfkRDEo89DHnrhoUc4qousiAfcOkgeCcjqZ0ibsvfJ7Flaal76VFvnxS/OGS41gmp8A0f1YCS3tEyu+0I/dz2YaOxSsnP3KEFzbSjeFm/5lx067RYpxo5DjyRwX4gmb4cHHfhnzWZPltOJG8W5WdotMFEvK72XMoBLKLtBeuCFr6O2EYCsd/Ggp+wfEsodZNB+k8pvFu28iLTNhPWPrYOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7rSfiF0EX99OnhsQUuEzPjtvf8Os0Iz1LHltvM+VVo=;
 b=NkCg/ArGcplQPxDmJn1Z3PM+438CYwDwaaCcn5UUSCAUPnF26caeq/5bBNcMuRpCpZOAMRq1lor9fzq9VxEkX6cmljpwrb1FmZNRlPn8b6Fe7ayhl4S8cB4fPPin72xnoZBe3YXvwvxd3EZGtQujqo48HJDA1xfnlwSjDMCWGsUmdDr5zf8TCk+9X6HyaK7nJyzpDpo/x0G5Wyns007+QGR2JX/JgGzTzq91JZKHeYxtSzubR6juOEXcSFsPzkiUq+2I1zzVO4AyKuOE8MOwfPSbET2HsycVraMa2nAIIg2s2gxUkeS5gUWuSY3/oHN/7r+WLhesn3zcd3luS5WNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7rSfiF0EX99OnhsQUuEzPjtvf8Os0Iz1LHltvM+VVo=;
 b=lBbYH49zYj+YHBNxmamox85UhIwsba6sy5KqE8nBxq3HK4hB+fGCSb61JwyESk2VTBTStpMhPmg99RCRY6YptZ58blxJ3AFoBokQ3NDSaa6KBchzpLijPtWaPE4n657eCZA71u6YbkGmjNRACnPERto9R6TdwIbMItpEYJ3DzzCAFUVR7noJXM8eePblzNiKMCLBLeMyfzlNFdcVtLO/4zdvbpjqj6aqnsbJ4/HNb5GTmhLwD6u5XGeHKUv2syJdmARcPKQqAcUBSfNfxfu6udwH+6rw10Y6RsIYIpIyu1EHhz6ZCDmzgNnbOTuOJOM6FTLOmvmgRo2Zd186qSrcmg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 07:29:28 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 07:29:28 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] selftests/sched_ext: Add a test for scx_bpf_task_numa_nid()
Date: Sun,  4 Oct 2026 09:27:11 +0200
Message-ID: <20261004072901.3579967-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004072901.3579967-1-arighi@nvidia.com>
References: <20261004072901.3579967-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9e4c04-daa7-43e0-bcef-08df21e9395b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	OTGueNHwQ4N/JajCm7hyr9KCxqMjdSF0t7rgG6fbtztKTzI6I7ubx1dPbYwu9jlHE9LMnvUMK8v+Oc2gvutmjfpxdon1Plw7VUEMafyZRdFgB97BiTBO1c1ctFD+kfe/P532m9tZg2mLYR3c/GKI7ZnTR4Q/s+FhkJACymeCcJZuot+fQtpNmEG1f+F2jPPonPXH5WcZEqz10PvIYatgpGvLyULJz18p+3PwSa0xfzLxfcsnByHFjGS1BjTaTI+7WZOT9bMndQAJCRfI6HXkvmNevZ6/iHZq332SLf2ZbFps8YKqyIkRUgijdnf8/F8pQU+diKwbXTAsL7E5c0SoJSQrlajBWpns6wuJWLE9DdIhaqCvWJEv4t/dSz3MTmjrmcPDKBamJsJkuw5h4QkZ9h2yew6P6fRSAe1qazqLQlZxipfXYAUCxWxDiVwK9wG282KYHPdTneMgYTUemUpOg26lEqXsElqYELS9Hyg5cueelBZn+jFXpSUhs70S9xN/fOgqC63lTUK/3q2OOc8ON6ExJPYiAzb7Dx2XX++2tuZSn9w9FXtM438LOX/5hQ82hTLfkufkV3Si9HwdyNFLfxRP1YMngEKGd9ecD4QMzr7Y5i/ZGKzKgrHpYWPI3mEWx79n63FL1jHaqm3D/6v+EbPE6uz10rsCNN8SwQ4yWHU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RySXsvcUgJzWA2wIaNw8ZThOEG6N85aUug95U9dtuz/5w0upMNqo+gwnlUlO?=
 =?us-ascii?Q?ciK35SiH4kWM8MMnMiyiI58SyjE4ECnIQM8w3Lv+rOJs2AyP3P47qohXTVjx?=
 =?us-ascii?Q?/0sTypbCDSpSFstT8UY5Ld6+kkdIMIR7TF6OFDeM2+NkZeLK0vB/IS7crFpy?=
 =?us-ascii?Q?4Q8zFUO7di64b12SCq+8l7EccFrNpES2E/VTisQG0Yunlpqz6RUJPDb2UkY6?=
 =?us-ascii?Q?7/mBt9ZirG5067EyUyCUjxI7QLjWlmTYVE5eenhi2Ej5j15DtDNOGlaAcAdJ?=
 =?us-ascii?Q?MoW11Ty1rbo0XsxQ+AsLr+ERsyu6pIXA/OdU9f6Lhm1/lAjbYcJcq8AyMJvh?=
 =?us-ascii?Q?Pb8ezAaM/Y/7hfdVlmyxtPczANoEsZGexFNi1oPx36FUgPC3mQj7fwrRAi9E?=
 =?us-ascii?Q?bKg1dxcdwvpleGfzV2pN1eWsHIzQy94GljQJQlXUsGbOwdG6stRGc9jeKv/R?=
 =?us-ascii?Q?fa88yzKYjQK/68mIQN20wfzQRP96awwmSA7mU/z0ygA4yDPcaeJWm7Cw5Rr+?=
 =?us-ascii?Q?9/HfdR/ZtJOJf7DxEs3ZdOhoyOmVDtn+7YTcu4u/NRjup4BsYs1x8NBT35wn?=
 =?us-ascii?Q?6V7gKOQolY7mwQCHH7W/abDoLZCKV8NamhKhseVm+5FV0y5YOc4/rjNOR1fI?=
 =?us-ascii?Q?PChnY+9FtVtwMmVZZqX08HoFWJI2nhdW9arYmTToli9rzIJS6hBIatm6uNqt?=
 =?us-ascii?Q?oppZl6h/tWAuIpZJA+Jwkd1QRB/relI+2ocHRWm2zb6GEIJ4AbOw+d34roiv?=
 =?us-ascii?Q?A0GGl0/yYSSQQbjCo8sFeyZL4Rh2M8o+daOckqOWTGpkbbBTWaCU86Ta1l9L?=
 =?us-ascii?Q?Mu4HvxL5NFneKfZz25uljpuw1xqLl2aMbxFFs8gIthepShqO1ZRPHYVwZlLH?=
 =?us-ascii?Q?6V7uCOj4YGWv52EOsJ45I+118ixAHNAcGmYyc/rEUrctrGpwX8DiHBQ2MP71?=
 =?us-ascii?Q?9gNT+NK9W6ReuKQo2frytuHnYdPc5W4Z9VzO4zIsd1evyOZ3X3IRwNyUNgWW?=
 =?us-ascii?Q?ALx/t2xIEN1XntK6KAbGZssy6+GUD8TFs3OfQx3M2HAqN24ouvOV6o10ied0?=
 =?us-ascii?Q?KX9h9GhoR7CGbhq+rEbHabzAsaAH9+Y2qNE0Bg0BQoZzww4H/8tpgRo39GYk?=
 =?us-ascii?Q?PU5DkBMMCJpKgCz1FIg/tLzwFmMBFn36Jict8WVT/ZYlnP7x1aGWrfJI2LR+?=
 =?us-ascii?Q?klKedsLX3StOwt0SEqjemHdZcwEI4s9e0Rb4dKuTaKL9SnQ082qURKky2Ch7?=
 =?us-ascii?Q?TwVAV1jpUouko7LBEza38G7stetDlq2Oo6wxKzWJM/i5vumM4c9Xv1eEmr8a?=
 =?us-ascii?Q?K4EzlZWcTnV1z3piY7mYtFtgISevZLvklJpqRjwyjKb9NHBhizdTyE920vOI?=
 =?us-ascii?Q?fM4fB1u5iOW0+lT68auXxUe1nYANoMLLXa9IgfUDt1igsJ++WR4JqApazdhe?=
 =?us-ascii?Q?0I3ovgtI2BGchbBJM/bqvaf4PazqOXvIVDOEBi5IH4VsxL3Cfgu9zQu1s34E?=
 =?us-ascii?Q?bGZtgZhB2Zjg8mfy/BeDW+eh0+PSxfDEfxe+HRFMb5wgBkeWkPTYwJMiTer7?=
 =?us-ascii?Q?TyHJ+MnIOINv1msNztqrjJEOYPDvzvFL4lzudJKzmacQ2CWHDjeRJ+BMusXl?=
 =?us-ascii?Q?ba7GcGBTh7J/I0dtwyfdUzjYVejgQwKv40jT1F1F6ClLa2VkFJKXk+7mhEf+?=
 =?us-ascii?Q?NqvFtRQqgh63IOJZoCpxPorKwfXHP7xCIX1sBbafa8WXaM1UIsbzLEl453iu?=
 =?us-ascii?Q?fvo7dyZhkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9e4c04-daa7-43e0-bcef-08df21e9395b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 07:29:28.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYsZSDyMvTN8E+S7np3+wR4fKmVhJG/ycYYyqtIjARFL3JovB/0LqYsx8kqdW6gt7FHjlvoaqg72lFZKoYFC6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577

Add a scheduler which opts into NUMA hinting-fault scanning and reads
every running task's preferred node. Check that each result is either
NUMA_NO_NODE or a node reported by the kernel.

The test runs two threads touching memory for a few seconds, which on a
NUMA machine with numa_balancing enabled is enough for its tasks to be
scanned and acquire a preferred node. Two threads are needed because
the scan skips the pages of a single-threaded process that are already
on the node it runs on. Whether a node is acquired depends on the
machine, so the test only reports the counts it observed and does not
require one.

Assisted-by: LLM
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/numa_nid.bpf.c        |  52 ++++++++
 tools/testing/selftests/sched_ext/numa_nid.c  | 111 ++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/numa_nid.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/numa_nid.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index c5d3a2eaea7da..707ab511acb51 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -186,6 +186,7 @@ auto-test-targets :=			\
 	non_scx_kfunc_deny		\
 	nohz_tick			\
 	numa				\
+	numa_nid			\
 	allowed_cpus			\
 	peek_dsq			\
 	prog_run			\
diff --git a/tools/testing/selftests/sched_ext/numa_nid.bpf.c b/tools/testing/selftests/sched_ext/numa_nid.bpf.c
new file mode 100644
index 0000000000000..54f7bdbc0a3d0
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/numa_nid.bpf.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that reads the NUMA node a task's hinting faults point at.
+ *
+ * Every task that runs is asked for its preferred node. The answer is either
+ * NUMA_NO_NODE, which a task keeps until its address space has been scanned a
+ * few times, or a node id the kernel knows about. Anything else means the
+ * value reaching BPF is not the one the placement code maintains.
+ *
+ * Copyright (c) 2026 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+/* Tasks seen with and without a preferred node. */
+u64 nr_with_nid;
+u64 nr_without_nid;
+
+void BPF_STRUCT_OPS(numa_nid_running, struct task_struct *p)
+{
+	s32 nid = scx_bpf_task_numa_nid(p);
+
+	if (nid == NUMA_NO_NODE) {
+		__sync_fetch_and_add(&nr_without_nid, 1);
+		return;
+	}
+
+	if (nid < 0 || nid >= scx_bpf_nr_node_ids()) {
+		scx_bpf_error("task %d reported node %d, kernel has %d node ids",
+			      p->pid, nid, scx_bpf_nr_node_ids());
+		return;
+	}
+
+	__sync_fetch_and_add(&nr_with_nid, 1);
+}
+
+void BPF_STRUCT_OPS(numa_nid_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops numa_nid_ops = {
+	.running			= (void *)numa_nid_running,
+	.exit				= (void *)numa_nid_exit,
+	.flags				= SCX_OPS_NUMA_BALANCING,
+	.name				= "numa_nid",
+};
diff --git a/tools/testing/selftests/sched_ext/numa_nid.c b/tools/testing/selftests/sched_ext/numa_nid.c
new file mode 100644
index 0000000000000..3aa1630ff6844
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/numa_nid.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <bpf/bpf.h>
+#include <pthread.h>
+#include <scx/common.h>
+#include <stdlib.h>
+#include <time.h>
+#include <unistd.h>
+#include "numa_nid.bpf.skel.h"
+#include "scx_test.h"
+
+#define WORKLOAD_SIZE		(64 << 20)
+#define WORKLOAD_THREADS	2
+#define WORKLOAD_SECONDS	3
+
+/*
+ * Touch a private buffer for a while. The hinting-fault scan skips the pages
+ * of a single-threaded process that are already on the node it runs on, so
+ * one such thread alone would never take a hinting fault: run two of them.
+ */
+static void *touch_memory(void *arg)
+{
+	struct timespec start, now;
+	volatile char *buffer;
+	size_t offset;
+
+	buffer = malloc(WORKLOAD_SIZE);
+	if (!buffer)
+		return NULL;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	do {
+		for (offset = 0; offset < WORKLOAD_SIZE; offset += 4096)
+			buffer[offset]++;
+		clock_gettime(CLOCK_MONOTONIC, &now);
+	} while (now.tv_sec - start.tv_sec < WORKLOAD_SECONDS);
+
+	free((void *)buffer);
+	return NULL;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct numa_nid *skel;
+
+	skel = numa_nid__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(numa_nid__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct numa_nid *skel = ctx;
+	pthread_t threads[WORKLOAD_THREADS - 1];
+	struct bpf_link *link;
+	int i;
+
+	link = bpf_map__attach_struct_ops(skel->maps.numa_nid_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	/*
+	 * Give the scan something to work on, so that the tasks of this test
+	 * can acquire a preferred node on a NUMA machine with numa_balancing
+	 * enabled. The test does not require one, as it depends on the
+	 * machine: the scheduler reports an error through UEI if it ever sees
+	 * a node id that is not valid and the counts below show what it saw.
+	 */
+	for (i = 0; i < WORKLOAD_THREADS - 1; i++) {
+		if (pthread_create(&threads[i], NULL, touch_memory, NULL)) {
+			SCX_ERR("Failed to create a worker thread");
+			bpf_link__destroy(link);
+			return SCX_TEST_FAIL;
+		}
+	}
+	touch_memory(NULL);
+	for (i = 0; i < WORKLOAD_THREADS - 1; i++)
+		pthread_join(threads[i], NULL);
+
+	fprintf(stderr, "tasks with a preferred node: %lu, without: %lu\n",
+		(unsigned long)skel->bss->nr_with_nid,
+		(unsigned long)skel->bss->nr_without_nid);
+
+	bpf_link__destroy(link);
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct numa_nid *skel = ctx;
+
+	numa_nid__destroy(skel);
+}
+
+struct scx_test numa_nid = {
+	.name = "numa_nid",
+	.description = "Read a task's preferred NUMA node from BPF",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&numa_nid)
-- 
2.55.0

