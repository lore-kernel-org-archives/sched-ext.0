Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AC41D206
	for <sched-ext@lists.linux.dev>; Fri, 18 Sep 2026 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751777; cv=fail; b=ZfpgaXEfWT2YLDTaiK5wMcpHgG2CNthAJaUclWM6dNhZf/k/pXDQ1H9Y8JP8PIcwimWT22OeC5lGOagZFQKWlUru/NiNGx4ZEVbufuU+Tq8jSDCM95CgGzoWD/MoZkVKUcrK/QtQo5oblfsu8YDCBjL5JmChElApLZCEEGnn+8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751777; c=relaxed/simple;
	bh=jgEjuc9ygu2v5Wys8dgWnHoM10PHa0ScTvc1djoVX9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EGSH2f5nSMoKptKit707U7QrXkH7pbpZmEqkMsOEw+vadliTQmgPMIWsUs7uoCLr/C4ZOeEztUgqsmSdOS+rrKyxkfwyoP1UKj/f6MWXMJFrWlpEuyyvCQxNaI++k1SkuvnXNYtNa3FWEzGhQu0RONwmGgZ8qpYI/t+byCzvztY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q+MGIuL6; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q+MGIuL6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxmEEmOGVInPa1M/Z4mnENxLaiRh1dQrOFa1KEvcLjePITwUzyBb+53d0XSO/+opkv3/hZA1mDQKGNWiSKy/KMfE7qbE6SYP0O2dNPVNCeu+NIIm+0wzuUrJt/57zYIoiTrN5PKCU1TJ1nnofhzWuzDicdXoDsIycqBwYEO7Pr1msUoG8ogLWdURMg5mNU4MvRkxSwQBCmUPpPUnFzenDMuCbSDarWULzXwDcJLGXR0qEaiA9TzHYd+BqeWxZz5jOOGEzI9RsptaBlS2aG55RbUfCB5cVQ6287oUk+tXeaMy0nEEQ7Njx0aWNbYFu8gbpZfCJvJLKbmYC3QG/+CRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHaK9XJcUFrU5pPXkmBmBaeLDCfBg2MZo+hqMWmfhGM=;
 b=zC/0IwtakRcyoBgirQqiVfYAEqM5FrvDCcwCOk9Rt2luMMIBPzywlQirSCop7DKqyN3MsnDaaVUHyyTZFE6HRwq/+MasV/kw0pC3T1Z/zHSJRgGy9JMo49BTEamCNyHMTwSLzVS3Vhlusd085WzeOaBbPIymx1KvU6XqiyeHx5XHx/olGf48lJmE6FPhyw5Kc7qgcpqgQ+YJIXq2SLD3tYD+QEsZpGEFxImltYEowaUQ2bfuy1Y0N3mIdMoHvTj/DTdNqJkiqRJYlAja4V6g5Du8M+oEproXd0G1zjg2REU0L2LMBxv6mWsRJRIU/6iK5HFIwp4Rk0gMiM917saAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHaK9XJcUFrU5pPXkmBmBaeLDCfBg2MZo+hqMWmfhGM=;
 b=Q+MGIuL6IuJtp61j+lLzw0qPkBblzvAf7TT4GhsTd8Y5pNt85w3nFs1KSGXm9XrKYLm4oh+SgNcfDKw/BVHzA9gojNrTriNKqhzWdRcsJAOTiXUr7ui/2k8lFT9u2NY0W0ianc+CWV76iBlDHBOkLxetbZ1lfODNnjEjDZNoisr4s+3H/DU+Ri17s9rwoLm6PjzQL4fRDMn9uYkP5fQBMTwtlSOYkLhdWwkTgI/rX5cdcTxlHixFuPaMX6hZ30TgEkrlbXGaHkEi8ZW+JBL46CZECKp86XTHqPzXbyts5iqAlLPYRYp9oF8hgW7mZxYakJCzXh6ukOQf4o460+1tNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV2PR12MB919616.namprd12.prod.outlook.com (2603:10b6:408:417::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 17:16:05 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 17:16:04 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Tao Cui <cui.tao@linux.dev>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Add lazy preemption tests
Date: Fri, 18 Sep 2026 19:13:28 +0200
Message-ID: <20260918171539.214204-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918171539.214204-1-arighi@nvidia.com>
References: <20260918171539.214204-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B88.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::406) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV2PR12MB919616:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cc2df7-d598-4e57-04ea-08df15a88526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|6133799003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/rSUkOIAoqNZRjE34QmM9ZhSg+w/ecsiHMX0nzGMdhs3VOnDeECibDHfKAQoZy3M30hwwIO7ks8Wb2EwwIX+vbBREC48Rj1wa2zIdVjup743Adc53YPQu798GORAjEx/SgXk4Yjdz/+AwoqwtBcZ8fx+ilD+zVhJa+DcH/oTnymxZXHn+al/eX4qzPcUmcQpTpSbrqIU6ovkFa1QblgR2q5Taxp6iU3GEZ2MIBX7MLyMSOyZqgkxrU+omW+6OYuiw+jWMHtapuuZoBi1LDYvBd5mMKg+lcShCG5nIEebl0bpNLQpQ6QmBlmgHrxDw/Fp93MinJUhHT47xFMbHfTic7onA4X3ZFdkGdxSHXuBfw8n4mqfJ2k6vDbgKX/T0NyVM5BykKmdfJNIvxESEIGFvQshItOZLCh2MRwJzXSOL6aDbsBGPAVKs7/CXbeyncJB9c/Kyt2dkt8vZ+gqtCxgldrRjtruK/59s6M+DtrFjuHB/OaK8AWEl3n/nAMRcol7c40NwIDsJfKmVKlNhSv2LpNqbadvPTO5Uj1yx+rPBpWr3zaWCNRZsoIQxNO0XvUYJE1lAkSffcfX2b9jwmb2ggFlbN/iuDnTwgaDqrzxsKcdqZp82cyF0Eh3OHbDTvbl7nVQM5NWwS/CBll94jDpWxhKQIZvcinu4ry21LdaZIw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8OVengiv4HdOIzU1LUI70qHW/juB3cCny1Rklk/Ky37xfNYlPqQAnnEJleOz?=
 =?us-ascii?Q?Ohqu9su4pGrsZn6PGQdgkXFxOZXTc2ySD+DvHuk/lYS9+8oR/VeJNobPuFFX?=
 =?us-ascii?Q?G04+6H61Hl69zjnlN+Pkizel9ZqJiX4SDH7a9r0qhV471XaofRzOmScV1lPa?=
 =?us-ascii?Q?4UA+uzPMkh/FIf3FlBZdfs25mtCp0X7CA5d2AV4f5s1ocDeA7Ud+vFho+IXe?=
 =?us-ascii?Q?a8aJpfXEEMQtTvOQxj4DNqWkbk8jVYHHvKFXBKs/v9MyewYrGwtacHCgVbgH?=
 =?us-ascii?Q?IQIO3ehy2OxRWz6iN0HPDDBClnlpqkXTSJYVKz9VIn/JcNS885C+QzSzEV5B?=
 =?us-ascii?Q?y631PG7wykIvC8n+MvVz39KtELggeNocvV3Mk+IG1DpDtcWgjyTdbtRuJjZY?=
 =?us-ascii?Q?PwISJbWVjg/wFH5/IcF2UDmI2WUztHcSobagX2NB56RT7Y8Pmf81ok1RphV8?=
 =?us-ascii?Q?R8FKLT3JWjb/4gj6osdA+r9521cNxmiRbs6PcjnNSj1qwhf9SXaVu5d8gVEG?=
 =?us-ascii?Q?1vaCzLvNzAeXYVUeVDmFowufM5tgZRKEg27vmEVb3xZqs3S0cYBrD5vSaBOR?=
 =?us-ascii?Q?tpDdlQ2LZDlsz9VmHlfg61ZTxfTq07bH6dAA79+3AsE5N07YvALG1pI7VXQd?=
 =?us-ascii?Q?eFO1h9t3K/cfDbsGUcm9o1s7L4sD9nnz9oxCARH9ASEwjtg1AN4lZbn1Yfhw?=
 =?us-ascii?Q?dUI3LsbN671iZemwRwRXJix6/T8WOW5WzYcvnhne/VfvQVMknykG6PkvLDce?=
 =?us-ascii?Q?hXuHHCKsZsVLwZnZ9E9tybRSK2g6WSzR3TNFoMF9P5s3G7eyZdZGzzXEhWf2?=
 =?us-ascii?Q?bgBIN5fMcoZMN/HIAZdKLHVdvhhUV/7q4TVzTZUhX3q+sEu+D/SWNlJdwUao?=
 =?us-ascii?Q?MobatR/vsOHE+bnr+dE8dLB6yMcIdOlMyEV4RUlorgiPBlAdqktxWMQb8aK3?=
 =?us-ascii?Q?IubbN2y8XNL2amCv+YlcCHx/CV6qZQFn/eW1DvsAxUf2G07P50/l4zpxNcgY?=
 =?us-ascii?Q?4232alTF/6zCG4aOuAvPuCQ41bTIWdpGyrNvQPk4oc6TOt3VXrcMj1nxek6f?=
 =?us-ascii?Q?cgiO/7BqxErfs5a2mZvs3PY7xY7RD8RSDgsVRkiwZHor1wMFwZw84GQUb+rM?=
 =?us-ascii?Q?28v5p+LFVlTP0vFzv83Gj+uav1ODj4AQ6eLfvtDC/WzVmHBY6EOcj0LEGw/w?=
 =?us-ascii?Q?fAxubqIA8wcA+Lizl6c6EMsm2eqEWNONkeLesv3725+oNNfGSH8DgRx9wO1t?=
 =?us-ascii?Q?gwNSaxCP10STHaKQfSSKoz4mgxDRCaRnHJgi5V1BBWHoBCDcgHpU/vGLLO01?=
 =?us-ascii?Q?/6sWtRAi1+3CqdnpUS109qUyEPEZ8iYN00W8vep9PE1V6V+eFoAp7qRj/r/J?=
 =?us-ascii?Q?8qF2zvnyo/Tecnm2mDxKMolh5DxPAKA0cjFhd13/vcTtcrSo6ANhghh8HD/Q?=
 =?us-ascii?Q?jzNCRCdKSVd5kQfrF7xNgVu/4zZtUs2V/7ugBqguLJxLbNsxt3U6NysQQqfn?=
 =?us-ascii?Q?oeOjUr1K63KnRW+axDzI0JcdVeGxCFiSxhlqaSHa56KSP9V7CBPjsNQu4dmd?=
 =?us-ascii?Q?/kiAeIKSctQPMCMl5VdrLIqbpv36+BC9NQZQnIdwcmqFoHYBfrCGAtI4V3Ki?=
 =?us-ascii?Q?tPAxrw3TmbdgFXW7dCDcU6G7htD9z6wlrmRyK+eP9m5oV45ylLBoh+RqUDVS?=
 =?us-ascii?Q?PyJqg/lQE1LJTIOIUwNZUMc8LHQevbkBfE+5TzoebOx9O1/qF3U7Ez+YeHfM?=
 =?us-ascii?Q?vaW7+pc1eQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cc2df7-d598-4e57-04ea-08df15a88526
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 17:16:04.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOz+GUyw+J0Ej6G/46B4JcUgKjZJ09PPetKKgngGRI9PHFCPuiveVDE9YSiKHGyVqfGrUswvEbEVMOG+gfxjSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB919616

Add trace-based coverage for immediate and lazy preemption. An fexit
probe on __resched_curr() records the requested TIF after the current
task's slice is cleared. SCX_OPS_ENQ_LAST drives the victim through
ops.stopping() without relying on an unrelated wakeup.

Exercise kick requests individually, in both orders and combined in one
call. Verify that immediate preemption and WAIT take precedence over
lazy preemption, and that combining immediate and lazy enqueue
preemption follows the same rule. Also test overriding the persistent
policy in both directions through scx_bpf_task_set_lazy_resched(), and
add invalid kick flag coverage.

Extend the NO_HZ_FULL test with infinite-slice victims. Wait until the
scheduler tick is observed to stop, then verify that lazy enqueue and
kick requests restart it and make forward progress. Move the controller
off all NO_HZ_FULL CPUs and increase the phase and watchdog timeouts to
tolerate scheduling delays in oversubscribed test VMs.

Detect both dynamic and static kernel preemption modes and skip
mode-sensitive assertions when the active mode is unavailable. Skip
trace-based cases when their kernel BTF targets are unavailable, while
allowing the independent invalid-flag cases to run.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 tools/testing/selftests/sched_ext/kick.bpf.c  | 170 ++++++
 tools/testing/selftests/sched_ext/kick.c      | 531 ++++++++++++++++++
 tools/testing/selftests/sched_ext/kick_test.h |  29 +
 .../selftests/sched_ext/nohz_tick.bpf.c       |  57 +-
 tools/testing/selftests/sched_ext/nohz_tick.c | 220 +++++++-
 .../selftests/sched_ext/nohz_tick_test.h      |  13 +
 tools/testing/selftests/sched_ext/util.c      | 144 +++++
 tools/testing/selftests/sched_ext/util.h      |  13 +
 9 files changed, 1145 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/kick.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/kick.c
 create mode 100644 tools/testing/selftests/sched_ext/kick_test.h
 create mode 100644 tools/testing/selftests/sched_ext/nohz_tick_test.h

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
index 0000000000000..cb71905d975e4
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/kick.bpf.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ */
+#include <scx/common.bpf.h>
+
+#include "kick_test.h"
+
+char _license[] SEC("license") = "GPL";
+
+const volatile u32 scenario;
+const volatile s32 victim_pid;
+const volatile s32 challenger_pid;
+const volatile s32 target_cpu;
+const volatile s32 lazy_resched_override = -1;
+
+u32 state;
+u64 slice_before;
+u64 slice_at_resched;
+s32 resched_tif;
+u64 nr_wait_callbacks;
+bool enq_preempt_issued;
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
+	case ENQ_BOTH:
+		if (p->pid == victim_pid) {
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_INF,
+					   enq_flags);
+		} else if (p->pid == challenger_pid &&
+			   state == KICK_STATE_QUEUED) {
+			enq_preempt_issued = true;
+			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
+					   enq_flags | SCX_ENQ_PREEMPT |
+					   SCX_ENQ_PREEMPT_LAZY);
+		} else {
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL,
+					   enq_flags);
+		}
+		goto kick_last;
+	case INVALID_KICK_IDLE:
+		scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_PREEMPT_LAZY | SCX_KICK_IDLE);
+		break;
+	case INVALID_KICK_UNKNOWN:
+		scx_bpf_kick_cpu(scx_bpf_task_cpu(p), 1LLU << 63);
+		break;
+	}
+
+	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+kick_last:
+	if (enq_flags & SCX_ENQ_LAST)
+		scx_bpf_kick_cpu(target_cpu, SCX_KICK_IDLE);
+}
+
+static void set_lazy_resched_override(struct task_struct *p)
+{
+	if (p->pid == victim_pid && lazy_resched_override >= 0)
+		scx_bpf_task_set_lazy_resched(p, lazy_resched_override);
+}
+
+void BPF_STRUCT_OPS(kick_running, struct task_struct *p)
+{
+	if (!is_trace_scenario() || p->pid != victim_pid)
+		return;
+	set_lazy_resched_override(p);
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
+	case KICK_BOTH:
+		scx_bpf_kick_cpu(target_cpu, SCX_KICK_PREEMPT |
+				 SCX_KICK_PREEMPT_LAZY);
+		break;
+	case KICK_LAZY_WAIT:
+		scx_bpf_kick_cpu(target_cpu, SCX_KICK_PREEMPT_LAZY |
+				 SCX_KICK_WAIT);
+		break;
+	case ENQ_BOTH:
+		/* The userspace controller wakes a competing task. */
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
+	u64 slice;
+
+	if (!task || BPF_CORE_READ(task, pid) != victim_pid ||
+	    BPF_CORE_READ(rq, cpu) != target_cpu || state != KICK_STATE_QUEUED)
+		return 0;
+	if (scenario == ENQ_BOTH && !enq_preempt_issued)
+		return 0;
+
+	slice = BPF_CORE_READ(task, scx.slice);
+	if (slice)
+		return 0;
+
+	slice_at_resched = slice;
+	resched_tif = tif;
+	state = KICK_STATE_RESCHED;
+	return 0;
+}
+
+SEC("fentry/kick_sync_wait_bal_cb")
+int BPF_PROG(kick_wait_callback, struct rq *rq)
+{
+	if (scenario == KICK_LAZY_WAIT &&
+	    BPF_CORE_READ(rq, cpu) == target_cpu)
+		__sync_fetch_and_add(&nr_wait_callbacks, 1);
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
+	.flags			= SCX_OPS_ENQ_LAST,
+	.name			= "kick",
+};
diff --git a/tools/testing/selftests/sched_ext/kick.c b/tools/testing/selftests/sched_ext/kick.c
new file mode 100644
index 0000000000000..0c7d14194211a
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/kick.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ */
+#define _GNU_SOURCE
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <linux/sched.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <scx/common.h>
+
+#include "kick.bpf.skel.h"
+#include "kick_test.h"
+#include "scx_test.h"
+#include "util.h"
+
+#define WAIT_LOOPS 3000
+
+struct observation {
+	u64 slice_before;
+	u64 slice_at_resched;
+	u64 nr_wait_callbacks;
+	s32 resched_tif;
+};
+
+struct kick_ctx {
+	cpu_set_t original_mask;
+	int target_cpu;
+};
+
+static bool enum_supported(const char *type, const char *name)
+{
+	u64 value;
+
+	return __COMPAT_read_enum(type, name, &value);
+}
+
+static enum scx_test_status setup_controller(void **ctx_ptr)
+{
+	struct kick_ctx *ctx;
+	cpu_set_t controller_mask;
+	int cpu, controller_cpu = -1;
+
+	ctx = calloc(1, sizeof(*ctx));
+	SCX_FAIL_IF(!ctx, "Failed to allocate context");
+	if (sched_getaffinity(0, sizeof(ctx->original_mask),
+			      &ctx->original_mask)) {
+		free(ctx);
+		SCX_FAIL("Failed to get affinity (%d)", errno);
+	}
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (!CPU_ISSET(cpu, &ctx->original_mask))
+			continue;
+		if (controller_cpu < 0) {
+			controller_cpu = cpu;
+		} else {
+			ctx->target_cpu = cpu;
+			break;
+		}
+	}
+	if (cpu == CPU_SETSIZE) {
+		printf("SKIP: two allowed CPUs are required\n");
+		free(ctx);
+		return SCX_TEST_SKIP;
+	}
+
+	CPU_ZERO(&controller_mask);
+	CPU_SET(controller_cpu, &controller_mask);
+	if (sched_setaffinity(0, sizeof(controller_mask), &controller_mask)) {
+		free(ctx);
+		SCX_FAIL("Failed to pin controller to CPU %d (%d)",
+			 controller_cpu, errno);
+	}
+
+	*ctx_ptr = ctx;
+	return SCX_TEST_PASS;
+}
+
+static void cleanup_controller(void *ctx_ptr)
+{
+	struct kick_ctx *ctx = ctx_ptr;
+
+	sched_setaffinity(0, sizeof(ctx->original_mask), &ctx->original_mask);
+	free(ctx);
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
+static bool wait_for_counter(struct kick *skel, const u64 *counter, u64 wanted)
+{
+	int i;
+
+	for (i = 0; i < WAIT_LOOPS; i++) {
+		if (__atomic_load_n(counter, __ATOMIC_ACQUIRE) >= wanted)
+			return true;
+		if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE))
+			return false;
+		usleep(1000);
+	}
+	return false;
+}
+
+static enum scx_test_status trace_one(struct kick_ctx *ctx, u32 scenario,
+				      u64 ops_flags,
+				      s32 lazy_resched_override,
+				      struct observation *obs)
+{
+	struct bpf_link *ops_link = NULL;
+	struct kick *skel = NULL;
+	struct scx_test_gated_worker challenger = { .pid = -1, .start_fd = -1 };
+	struct scx_test_gated_worker victim;
+	enum scx_test_status ret = SCX_TEST_FAIL;
+	int cpu = ctx->target_cpu;
+
+	victim = scx_test_spawn_gated_worker(cpu, false);
+	if (victim.pid < 0) {
+		SCX_ERR("Failed to spawn victim");
+		return SCX_TEST_FAIL;
+	}
+	if (scenario == ENQ_BOTH) {
+		challenger = scx_test_spawn_gated_worker(cpu, false);
+		if (challenger.pid < 0) {
+			SCX_ERR("Failed to spawn enqueue challenger");
+			goto out;
+		}
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
+	skel->rodata->challenger_pid = challenger.pid;
+	skel->rodata->target_cpu = cpu;
+	skel->rodata->lazy_resched_override = lazy_resched_override;
+	skel->struct_ops.kick_ops->flags |= ops_flags;
+	if (scenario != KICK_LAZY_WAIT)
+		bpf_program__set_autoload(skel->progs.kick_wait_callback,
+					  false);
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
+	if (!scx_test_start_gated_worker(&victim)) {
+		SCX_ERR("Failed to start victim");
+		goto out;
+	}
+	if (scenario == ENQ_BOTH) {
+		if (!wait_for_state(skel, KICK_STATE_QUEUED)) {
+			SCX_ERR("Enqueue scenario did not arm");
+			goto out;
+		}
+		if (!scx_test_start_gated_worker(&challenger)) {
+			SCX_ERR("Failed to start enqueue challenger");
+			goto out;
+		}
+	}
+	if (!wait_for_state(skel, KICK_STATE_DONE)) {
+		SCX_ERR("Scenario %u stopped in state %u, exit kind %d", scenario, skel->bss->state,
+			skel->data->uei.kind);
+		goto out;
+	}
+	if (scenario == KICK_LAZY_WAIT &&
+	    !wait_for_counter(skel, &skel->bss->nr_wait_callbacks, 1)) {
+		SCX_ERR("WAIT callback did not run");
+		goto out;
+	}
+
+	obs->slice_before = skel->bss->slice_before;
+	obs->slice_at_resched = skel->bss->slice_at_resched;
+	obs->nr_wait_callbacks = skel->bss->nr_wait_callbacks;
+	obs->resched_tif = skel->bss->resched_tif;
+	ret = SCX_TEST_PASS;
+out:
+	scx_test_stop_gated_worker(&victim);
+	scx_test_stop_gated_worker(&challenger);
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
+static bool trace_target_supported(const char *name,
+				   enum bpf_attach_type attach_type)
+{
+	return libbpf_find_vmlinux_btf_id(name, attach_type) > 0;
+}
+
+static enum scx_test_status setup_immediate(void **ctx)
+{
+	if (!enum_supported("scx_kick_flags", "SCX_KICK_PREEMPT")) {
+		printf("SKIP: SCX_KICK_PREEMPT is not supported\n");
+		return SCX_TEST_SKIP;
+	}
+	if (!trace_target_supported("__resched_curr", BPF_TRACE_FEXIT)) {
+		printf("SKIP: __resched_curr is not available in BTF\n");
+		return SCX_TEST_SKIP;
+	}
+	return setup_controller(ctx);
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
+	if (!enum_supported("scx_ops_flags", "SCX_OPS_LAZY_RESCHED")) {
+		printf("SKIP: SCX_OPS_LAZY_RESCHED is not supported\n");
+		return SCX_TEST_SKIP;
+	}
+	return setup_lazy(ctx);
+}
+
+static enum scx_test_status setup_coalesce(void **ctx)
+{
+	if (!enum_supported("scx_enq_flags", "SCX_ENQ_PREEMPT_LAZY")) {
+		printf("SKIP: SCX_ENQ_PREEMPT_LAZY is not supported\n");
+		return SCX_TEST_SKIP;
+	}
+	if (!trace_target_supported("kick_sync_wait_bal_cb", BPF_TRACE_FENTRY)) {
+		printf("SKIP: kick_sync_wait_bal_cb is not available in BTF\n");
+		return SCX_TEST_SKIP;
+	}
+	return setup_lazy(ctx);
+}
+
+static enum scx_test_status setup_invalid(void **ctx)
+{
+	if (!enum_supported("scx_kick_flags", "SCX_KICK_PREEMPT_LAZY")) {
+		printf("SKIP: SCX_KICK_PREEMPT_LAZY is not supported\n");
+		return SCX_TEST_SKIP;
+	}
+	return setup_controller(ctx);
+}
+
+static enum scx_test_status run_immediate(void *ctx)
+{
+	struct observation obs;
+	enum scx_test_status status;
+
+	status = trace_one(ctx, KICK_IMMEDIATE, 0, -1, &obs);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&obs));
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run_lazy(void *ctx)
+{
+	struct observation immediate, lazy;
+	enum scx_test_status status;
+	int lazy_mode = scx_test_preempt_lazy_mode();
+
+	if (lazy_mode < 0) {
+		printf("SKIP: running kernel preemption mode is unavailable\n");
+		return SCX_TEST_SKIP;
+	}
+
+	status = trace_one(ctx, KICK_IMMEDIATE, 0, -1, &immediate);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&immediate));
+	status = trace_one(ctx, KICK_LAZY, 0, -1, &lazy);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&lazy));
+
+	if (lazy_mode > 0)
+		SCX_FAIL_IF(lazy.resched_tif == immediate.resched_tif,
+			    "Lazy mode used immediate TIF %d", lazy.resched_tif);
+	else if (!lazy_mode)
+		SCX_EQ(lazy.resched_tif, immediate.resched_tif);
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run_coalesce(void *ctx)
+{
+	struct observation immediate, lazy_first, immediate_first;
+	struct observation plain_first, lazy_then_plain;
+	struct observation both, lazy_wait, enq_both;
+	enum scx_test_status status;
+
+	if (scx_test_preempt_lazy_mode() != 1) {
+		printf("SKIP: kick coalescing requires active lazy preemption\n");
+		return SCX_TEST_SKIP;
+	}
+
+	status = trace_one(ctx, KICK_IMMEDIATE, 0, -1, &immediate);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&immediate));
+	status = trace_one(ctx, KICK_LAZY_THEN_IMMEDIATE, 0, -1,
+			   &lazy_first);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&lazy_first));
+	status = trace_one(ctx, KICK_IMMEDIATE_THEN_LAZY, 0, -1,
+			   &immediate_first);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&immediate_first));
+	SCX_EQ(lazy_first.resched_tif, immediate.resched_tif);
+	SCX_EQ(immediate_first.resched_tif, immediate.resched_tif);
+
+	/*
+	 * A plain kick in the same batch doesn't clear the slice by itself.
+	 * The lazy preemption must still expire it, and the plain kick must
+	 * still reschedule immediately, whichever came first.
+	 */
+	status = trace_one(ctx, KICK_PLAIN_THEN_LAZY, 0, -1,
+			   &plain_first);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&plain_first));
+	status = trace_one(ctx, KICK_LAZY_THEN_PLAIN, 0, -1,
+			   &lazy_then_plain);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&lazy_then_plain));
+	SCX_EQ(plain_first.resched_tif, immediate.resched_tif);
+	SCX_EQ(lazy_then_plain.resched_tif, immediate.resched_tif);
+
+	/* Immediate kick and WAIT both take precedence over lazy preemption. */
+	status = trace_one(ctx, KICK_BOTH, 0, -1, &both);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&both));
+	status = trace_one(ctx, KICK_LAZY_WAIT, 0, -1, &lazy_wait);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&lazy_wait));
+	SCX_EQ(both.resched_tif, immediate.resched_tif);
+	SCX_EQ(lazy_wait.resched_tif, immediate.resched_tif);
+	SCX_GT(lazy_wait.nr_wait_callbacks, 0);
+
+	/* Immediate enqueue preemption likewise takes precedence over lazy. */
+	status = trace_one(ctx, ENQ_BOTH, 0, -1, &enq_both);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&enq_both));
+	SCX_EQ(enq_both.resched_tif, immediate.resched_tif);
+	return SCX_TEST_PASS;
+}
+
+/*
+ * A slice running out at the tick reschedules immediately by default and
+ * lazily with SCX_OPS_LAZY_RESCHED, the way fair.c expires a slice.
+ */
+static enum scx_test_status run_tick(void *ctx)
+{
+	struct observation immediate, lazy, force_lazy, force_immediate;
+	enum scx_test_status status;
+	u64 lazy_flag;
+	int lazy_mode = scx_test_preempt_lazy_mode();
+	bool found;
+
+	if (lazy_mode < 0) {
+		printf("SKIP: running kernel preemption mode is unavailable\n");
+		return SCX_TEST_SKIP;
+	}
+
+	found = __COMPAT_read_enum("scx_ops_flags", "SCX_OPS_LAZY_RESCHED",
+				   &lazy_flag);
+	SCX_ASSERT(found);
+	status = trace_one(ctx, TICK_EXPIRY, 0, -1, &immediate);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&immediate));
+	status = trace_one(ctx, TICK_EXPIRY, lazy_flag, -1, &lazy);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&lazy));
+	if (lazy_mode > 0) {
+		SCX_FAIL_IF(lazy.resched_tif == immediate.resched_tif,
+			    "Lazy slice expiry used immediate TIF %d", lazy.resched_tif);
+
+		status = trace_one(ctx, TICK_EXPIRY, 0, 1, &force_lazy);
+		SCX_EQ(status, SCX_TEST_PASS);
+		SCX_ASSERT(observation_valid(&force_lazy));
+		status = trace_one(ctx, TICK_EXPIRY, lazy_flag, 0,
+				   &force_immediate);
+		SCX_EQ(status, SCX_TEST_PASS);
+		SCX_ASSERT(observation_valid(&force_immediate));
+		SCX_EQ(force_lazy.resched_tif, lazy.resched_tif);
+		SCX_EQ(force_immediate.resched_tif, immediate.resched_tif);
+	} else {
+		SCX_EQ(lazy.resched_tif, immediate.resched_tif);
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status invalid_one(struct kick_ctx *ctx, u32 scenario)
+{
+	struct bpf_link *ops_link = NULL;
+	struct kick *skel = NULL;
+	struct scx_test_gated_worker victim;
+	enum scx_test_status ret = SCX_TEST_FAIL;
+	int cpu = ctx->target_cpu;
+	int i;
+
+	victim = scx_test_spawn_gated_worker(cpu, false);
+	if (victim.pid < 0)
+		return SCX_TEST_FAIL;
+
+	skel = kick__open();
+	if (!skel)
+		goto out;
+	SCX_ENUM_INIT(skel);
+	skel->rodata->scenario = scenario;
+	bpf_program__set_autoload(skel->progs.kick_need_resched, false);
+	bpf_program__set_autoload(skel->progs.kick_wait_callback, false);
+	if (kick__load(skel))
+		goto out;
+	ops_link = bpf_map__attach_struct_ops(skel->maps.kick_ops);
+	if (!ops_link || !scx_test_start_gated_worker(&victim))
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
+	scx_test_stop_gated_worker(&victim);
+	if (ops_link)
+		bpf_link__destroy(ops_link);
+	if (skel)
+		kick__destroy(skel);
+	return ret;
+}
+
+static enum scx_test_status run_invalid(void *ctx)
+{
+	enum scx_test_status status;
+	u32 scenario;
+
+	for (scenario = INVALID_KICK_IDLE;
+	     scenario <= INVALID_KICK_UNKNOWN; scenario++) {
+		status = invalid_one(ctx, scenario);
+		SCX_EQ(status, SCX_TEST_PASS);
+	}
+	return SCX_TEST_PASS;
+}
+
+static struct scx_test kick_immediate = {
+	.name = "kick_immediate",
+	.description = "Trace immediate kick slice expiration and rescheduling",
+	.setup = setup_immediate,
+	.run = run_immediate,
+	.cleanup = cleanup_controller,
+};
+
+static struct scx_test kick_lazy = {
+	.name = "kick_lazy",
+	.description = "Trace lazy kick slice expiration and rescheduling",
+	.setup = setup_lazy,
+	.run = run_lazy,
+	.cleanup = cleanup_controller,
+};
+
+static struct scx_test kick_coalesce = {
+	.name = "kick_coalesce",
+	.description = "Verify lazy preemption coalesces with immediate requests",
+	.setup = setup_coalesce,
+	.run = run_coalesce,
+	.cleanup = cleanup_controller,
+};
+
+static struct scx_test kick_tick = {
+	.name = "kick_tick",
+	.description = "Trace slice expiry at the tick, immediate and lazy",
+	.setup = setup_tick,
+	.run = run_tick,
+	.cleanup = cleanup_controller,
+};
+
+static struct scx_test kick_invalid = {
+	.name = "kick_invalid",
+	.description = "Verify invalid kick flag combinations fail",
+	.setup = setup_invalid,
+	.run = run_invalid,
+	.cleanup = cleanup_controller,
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
diff --git a/tools/testing/selftests/sched_ext/kick_test.h b/tools/testing/selftests/sched_ext/kick_test.h
new file mode 100644
index 0000000000000..7d3c608c6b630
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/kick_test.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES */
+#ifndef __KICK_TEST_H__
+#define __KICK_TEST_H__
+
+enum kick_scenario {
+	KICK_IMMEDIATE,
+	KICK_LAZY,
+	KICK_LAZY_THEN_IMMEDIATE,
+	KICK_IMMEDIATE_THEN_LAZY,
+	KICK_PLAIN_THEN_LAZY,
+	KICK_LAZY_THEN_PLAIN,
+	KICK_BOTH,
+	KICK_LAZY_WAIT,
+	ENQ_BOTH,
+	TICK_EXPIRY,
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
+#endif /* __KICK_TEST_H__ */
diff --git a/tools/testing/selftests/sched_ext/nohz_tick.bpf.c b/tools/testing/selftests/sched_ext/nohz_tick.bpf.c
index 6998c5dd6bcb9..5fec5673fbf26 100644
--- a/tools/testing/selftests/sched_ext/nohz_tick.bpf.c
+++ b/tools/testing/selftests/sched_ext/nohz_tick.bpf.c
@@ -6,13 +6,22 @@
  */
 #include <scx/common.bpf.h>
 
+#include "nohz_tick_test.h"
+
 char _license[] SEC("license") = "GPL";
 
 const volatile s32 test_cpu;
-bool finite_phase;
+u32 phase;
+s32 victim_pid;
+s32 challenger_pid;
+s32 trigger_pid;
 u64 nr_inf_running;
 u64 nr_finite_running;
 u64 nr_finite_ticks;
+u64 nr_lazy_victim_running;
+u64 nr_lazy_enq_running;
+u64 nr_lazy_kick_running;
+u64 nr_lazy_ticks;
 
 UEI_DEFINE(uei);
 
@@ -24,9 +33,31 @@ s32 BPF_STRUCT_OPS(nohz_tick_select_cpu, struct task_struct *p, s32 prev_cpu,
 
 void BPF_STRUCT_OPS(nohz_tick_enqueue, struct task_struct *p, u64 enq_flags)
 {
-	u64 slice = finite_phase ? 1000000ULL : SCX_SLICE_INF;
+	u64 slice;
+	u64 dsq_id = SCX_DSQ_GLOBAL;
+
+	switch (phase) {
+	case NOHZ_PHASE_INF:
+		slice = SCX_SLICE_INF;
+		break;
+	case NOHZ_PHASE_FINITE:
+		slice = 1000000ULL;
+		break;
+	case NOHZ_PHASE_LAZY_ENQ:
+	case NOHZ_PHASE_LAZY_KICK:
+		dsq_id = SCX_DSQ_LOCAL;
+		slice = p->pid == victim_pid ? SCX_SLICE_INF : SCX_SLICE_DFL;
+		if (phase == NOHZ_PHASE_LAZY_ENQ && p->pid == challenger_pid)
+			enq_flags |= SCX_ENQ_PREEMPT_LAZY;
+		break;
+	default:
+		slice = SCX_SLICE_DFL;
+		break;
+	}
 
-	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, slice, enq_flags);
+	scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags);
+	if (phase == NOHZ_PHASE_LAZY_KICK && p->pid == trigger_pid)
+		scx_bpf_kick_cpu(test_cpu, SCX_KICK_PREEMPT_LAZY);
 	if (enq_flags & SCX_ENQ_LAST)
 		scx_bpf_kick_cpu(test_cpu, SCX_KICK_IDLE);
 }
@@ -36,16 +67,28 @@ void BPF_STRUCT_OPS(nohz_tick_running, struct task_struct *p)
 	if (bpf_get_smp_processor_id() != test_cpu)
 		return;
 
-	if (finite_phase)
+	if (phase == NOHZ_PHASE_FINITE)
 		__sync_fetch_and_add(&nr_finite_running, 1);
-	else
+	else if (phase == NOHZ_PHASE_INF)
 		__sync_fetch_and_add(&nr_inf_running, 1);
+	else if (p->pid == victim_pid)
+		__sync_fetch_and_add(&nr_lazy_victim_running, 1);
+	else if (phase == NOHZ_PHASE_LAZY_ENQ && p->pid == challenger_pid)
+		__sync_fetch_and_add(&nr_lazy_enq_running, 1);
+	else if (phase == NOHZ_PHASE_LAZY_KICK && p->pid == challenger_pid)
+		__sync_fetch_and_add(&nr_lazy_kick_running, 1);
 }
 
 void BPF_STRUCT_OPS(nohz_tick_tick, struct task_struct *p)
 {
-	if (bpf_get_smp_processor_id() == test_cpu && finite_phase)
+	if (bpf_get_smp_processor_id() != test_cpu)
+		return;
+
+	if (phase == NOHZ_PHASE_FINITE)
 		__sync_fetch_and_add(&nr_finite_ticks, 1);
+	else if ((phase == NOHZ_PHASE_LAZY_ENQ ||
+		  phase == NOHZ_PHASE_LAZY_KICK) && p->pid == victim_pid)
+		__sync_fetch_and_add(&nr_lazy_ticks, 1);
 }
 
 void BPF_STRUCT_OPS(nohz_tick_exit, struct scx_exit_info *ei)
@@ -61,5 +104,5 @@ struct sched_ext_ops nohz_tick_ops = {
 	.tick			= (void *)nohz_tick_tick,
 	.exit			= (void *)nohz_tick_exit,
 	.name			= "nohz_tick",
-	.timeout_ms		= 1000U,
+	.timeout_ms		= 5000U,
 };
diff --git a/tools/testing/selftests/sched_ext/nohz_tick.c b/tools/testing/selftests/sched_ext/nohz_tick.c
index 028f54391c2ca..53f1e8d92508b 100644
--- a/tools/testing/selftests/sched_ext/nohz_tick.c
+++ b/tools/testing/selftests/sched_ext/nohz_tick.c
@@ -21,19 +21,24 @@
 #include <scx/common.h>
 
 #include "nohz_tick.bpf.skel.h"
+#include "nohz_tick_test.h"
 #include "scx_test.h"
+#include "util.h"
 
 #ifndef SCHED_EXT
 #define SCHED_EXT 7
 #endif
 
 #define MIN_FINITE_TICKS 3
-#define PHASE_TIMEOUT_MS 1000
+#define PHASE_TIMEOUT_MS 5000
+#define TICK_STOP_STABLE_MS 100
 
 struct nohz_tick_ctx {
 	struct nohz_tick *skel;
 	cpu_set_t original_mask;
 	int test_cpu;
+	int housekeeping_cpu;
+	bool test_lazy;
 };
 
 static int first_allowed_cpu(const cpu_set_t *mask, int first, int last)
@@ -47,20 +52,21 @@ static int first_allowed_cpu(const cpu_set_t *mask, int first, int last)
 	return -1;
 }
 
-static int find_nohz_full_cpu(const cpu_set_t *allowed)
+static int read_nohz_full_mask(cpu_set_t *mask)
 {
 	char buf[4096], *cur, *end;
 	FILE *file;
+	int ret = 0;
 
 	file = fopen("/sys/devices/system/cpu/nohz_full", "r");
 	if (!file)
-		return -1;
+		return -errno;
 	if (!fgets(buf, sizeof(buf), file)) {
-		fclose(file);
-		return -1;
+		ret = ferror(file) ? -errno : -EINVAL;
+		goto out;
 	}
-	fclose(file);
 
+	CPU_ZERO(mask);
 	cur = buf;
 	while (*cur) {
 		long first, last;
@@ -73,25 +79,30 @@ static int find_nohz_full_cpu(const cpu_set_t *allowed)
 
 		errno = 0;
 		first = strtol(cur, &end, 10);
-		if (errno || end == cur || first < 0 || first >= CPU_SETSIZE)
-			return -1;
+		if (errno || end == cur || first < 0 || first >= CPU_SETSIZE) {
+			ret = -EINVAL;
+			goto out;
+		}
 		cur = end;
 		last = first;
 		if (*cur == '-') {
 			cur++;
 			errno = 0;
 			last = strtol(cur, &end, 10);
-			if (errno || end == cur || last < first)
-				return -1;
+			if (errno || end == cur || last < first) {
+				ret = -EINVAL;
+				goto out;
+			}
 			cur = end;
 		}
 
-		cpu = first_allowed_cpu(allowed, first, last);
-		if (cpu >= 0)
-			return cpu;
+		for (cpu = first; cpu <= last && cpu < CPU_SETSIZE; cpu++)
+			CPU_SET(cpu, mask);
 	}
 
-	return -1;
+out:
+	fclose(file);
+	return ret;
 }
 
 static pid_t start_worker(int cpu)
@@ -146,24 +157,54 @@ static int pause_worker(pid_t pid)
 	return 0;
 }
 
-static bool wait_for_counter(const u64 *counter, u64 value, int timeout_ms)
+static bool wait_for_counter(struct nohz_tick *skel, const u64 *counter,
+			     u64 value, int timeout_ms)
 {
 	int elapsed;
 
 	for (elapsed = 0; elapsed < timeout_ms; elapsed++) {
 		if (__atomic_load_n(counter, __ATOMIC_RELAXED) >= value)
 			return true;
+		if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE))
+			return false;
 		usleep(1000);
 	}
 
 	return false;
 }
 
+static bool wait_for_tick_stop(struct nohz_tick *skel, const u64 *counter,
+			       int timeout_ms)
+{
+	u64 prev = __atomic_load_n(counter, __ATOMIC_RELAXED);
+	int elapsed, stable = 0;
+
+	for (elapsed = 0; elapsed < timeout_ms; elapsed++) {
+		u64 curr;
+
+		usleep(1000);
+		if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE))
+			return false;
+		curr = __atomic_load_n(counter, __ATOMIC_RELAXED);
+		if (curr == prev) {
+			if (++stable >= TICK_STOP_STABLE_MS)
+				return true;
+		} else {
+			prev = curr;
+			stable = 0;
+		}
+	}
+
+	return false;
+}
+
 static enum scx_test_status setup(void **ctx_ptr)
 {
 	struct nohz_tick_ctx *ctx;
-	cpu_set_t controller_mask;
-	int cpu;
+	cpu_set_t controller_mask, nohz_full_mask;
+	bool lazy_supported;
+	u64 enum_value, lazy_ops_flag;
+	int cpu, i, lazy_mode, ret;
 
 	ctx = calloc(1, sizeof(*ctx));
 	SCX_FAIL_IF(!ctx, "Failed to allocate context");
@@ -173,15 +214,27 @@ static enum scx_test_status setup(void **ctx_ptr)
 		SCX_FAIL("Failed to get affinity (%d)", errno);
 	}
 
-	cpu = find_nohz_full_cpu(&ctx->original_mask);
-	if (cpu < 0) {
+	ret = read_nohz_full_mask(&nohz_full_mask);
+	if (ret) {
+		fprintf(stderr, "SKIP: failed to read NOHZ_FULL mask (%d)\n", ret);
+		free(ctx);
+		return SCX_TEST_SKIP;
+	}
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++)
+		if (CPU_ISSET(cpu, &ctx->original_mask) &&
+		    CPU_ISSET(cpu, &nohz_full_mask))
+			break;
+	if (cpu == CPU_SETSIZE) {
 		fprintf(stderr, "SKIP: no allowed NOHZ_FULL CPU\n");
 		free(ctx);
 		return SCX_TEST_SKIP;
 	}
 
 	controller_mask = ctx->original_mask;
-	CPU_CLR(cpu, &controller_mask);
+	for (i = 0; i < CPU_SETSIZE; i++)
+		if (CPU_ISSET(i, &nohz_full_mask))
+			CPU_CLR(i, &controller_mask);
 	if (CPU_COUNT(&controller_mask) == 0) {
 		fprintf(stderr, "SKIP: no housekeeping CPU available\n");
 		free(ctx);
@@ -189,6 +242,23 @@ static enum scx_test_status setup(void **ctx_ptr)
 	}
 
 	ctx->test_cpu = cpu;
+	ctx->housekeeping_cpu = first_allowed_cpu(&controller_mask, 0,
+						  CPU_SETSIZE - 1);
+	lazy_supported =
+		__COMPAT_read_enum("scx_enq_flags", "SCX_ENQ_PREEMPT_LAZY",
+				   &enum_value) &&
+		__COMPAT_read_enum("scx_kick_flags", "SCX_KICK_PREEMPT_LAZY",
+				   &enum_value) &&
+		__COMPAT_read_enum("scx_ops_flags", "SCX_OPS_LAZY_RESCHED",
+				   &lazy_ops_flag);
+	lazy_mode = scx_test_preempt_lazy_mode();
+	ctx->test_lazy = lazy_supported && lazy_mode > 0;
+	if (lazy_supported && lazy_mode < 0)
+		fprintf(stderr,
+			"SKIP: kernel preemption mode unavailable; skipping lazy NOHZ_FULL phases\n");
+	else if (lazy_supported && !lazy_mode)
+		fprintf(stderr,
+			"SKIP: lazy preemption inactive; skipping lazy NOHZ_FULL phases\n");
 	ctx->skel = nohz_tick__open();
 	if (!ctx->skel) {
 		free(ctx);
@@ -199,6 +269,8 @@ static enum scx_test_status setup(void **ctx_ptr)
 	ctx->skel->rodata->test_cpu = cpu;
 	ctx->skel->struct_ops.nohz_tick_ops->flags |= SCX_OPS_SWITCH_PARTIAL |
 							   SCX_OPS_ENQ_LAST;
+	if (lazy_supported)
+		ctx->skel->struct_ops.nohz_tick_ops->flags |= lazy_ops_flag;
 	if (nohz_tick__load(ctx->skel)) {
 		nohz_tick__destroy(ctx->skel);
 		free(ctx);
@@ -220,11 +292,15 @@ static enum scx_test_status run(void *ctx_ptr)
 	struct nohz_tick_ctx *ctx = ctx_ptr;
 	struct nohz_tick *skel = ctx->skel;
 	struct bpf_link *link = NULL;
+	struct scx_test_gated_worker victim = { .pid = -1, .start_fd = -1 };
+	struct scx_test_gated_worker challenger = { .pid = -1, .start_fd = -1 };
+	struct scx_test_gated_worker trigger = { .pid = -1, .start_fd = -1 };
 	enum scx_test_status status = SCX_TEST_FAIL;
 	pid_t finite_worker = -1;
 	pid_t inf_worker = -1;
 	u64 finite_running;
 	u64 finite_ticks;
+	u64 victim_running;
 	int ret;
 
 	link = bpf_map__attach_struct_ops(skel->maps.nohz_tick_ops);
@@ -241,7 +317,7 @@ static enum scx_test_status run(void *ctx_ptr)
 		SCX_ERR("Failed to start infinite-slice worker (%d)", errno);
 		goto out;
 	}
-	if (!wait_for_counter(&skel->bss->nr_inf_running, 1,
+	if (!wait_for_counter(skel, &skel->bss->nr_inf_running, 1,
 			      PHASE_TIMEOUT_MS)) {
 		SCX_ERR("Infinite-slice worker was not scheduled");
 		goto out;
@@ -260,18 +336,19 @@ static enum scx_test_status run(void *ctx_ptr)
 	/*
 	 * The next EXT task receives a finite slice and must restart the tick.
 	 */
-	__atomic_store_n(&skel->bss->finite_phase, true, __ATOMIC_RELEASE);
+	__atomic_store_n(&skel->bss->phase, NOHZ_PHASE_FINITE,
+			 __ATOMIC_RELEASE);
 	finite_worker = start_worker(ctx->test_cpu);
 	if (finite_worker < 0) {
 		SCX_ERR("Failed to start finite-slice worker (%d)", errno);
 		goto out;
 	}
-	if (!wait_for_counter(&skel->bss->nr_finite_running, 1,
+	if (!wait_for_counter(skel, &skel->bss->nr_finite_running, 1,
 			      PHASE_TIMEOUT_MS)) {
 		SCX_ERR("Finite-slice worker was not scheduled");
 		goto out;
 	}
-	if (!wait_for_counter(&skel->bss->nr_finite_ticks, MIN_FINITE_TICKS,
+	if (!wait_for_counter(skel, &skel->bss->nr_finite_ticks, MIN_FINITE_TICKS,
 			      PHASE_TIMEOUT_MS)) {
 		SCX_ERR("Finite-slice worker received only %llu scheduler ticks",
 			(unsigned long long)skel->bss->nr_finite_ticks);
@@ -295,12 +372,12 @@ static enum scx_test_status run(void *ctx_ptr)
 		SCX_ERR("Failed to start second finite-slice worker (%d)", errno);
 		goto out;
 	}
-	if (!wait_for_counter(&skel->bss->nr_finite_running,
+	if (!wait_for_counter(skel, &skel->bss->nr_finite_running,
 			      finite_running + 1, PHASE_TIMEOUT_MS)) {
 		SCX_ERR("Second finite-slice worker was not scheduled");
 		goto out;
 	}
-	if (!wait_for_counter(&skel->bss->nr_finite_ticks,
+	if (!wait_for_counter(skel, &skel->bss->nr_finite_ticks,
 			      finite_ticks + MIN_FINITE_TICKS,
 			      PHASE_TIMEOUT_MS)) {
 		SCX_ERR("Second finite-slice worker received only %llu scheduler ticks",
@@ -308,7 +385,95 @@ static enum scx_test_status run(void *ctx_ptr)
 					     finite_ticks));
 		goto out;
 	}
+	stop_worker(finite_worker);
+	finite_worker = -1;
+	stop_worker(inf_worker);
+	inf_worker = -1;
+	if (!ctx->test_lazy)
+		goto check_exit;
+
+	/*
+	 * A lazy local enqueue must restart the tick after clearing the slice of
+	 * an infinite-slice task on a full-dynticks CPU.
+	 */
+	__atomic_store_n(&skel->bss->phase, NOHZ_PHASE_LAZY_ENQ,
+			 __ATOMIC_RELEASE);
+	victim = scx_test_spawn_gated_worker(ctx->test_cpu, true);
+	challenger = scx_test_spawn_gated_worker(ctx->test_cpu, true);
+	if (victim.pid < 0 || challenger.pid < 0) {
+		SCX_ERR("Failed to spawn lazy-enqueue workers");
+		goto out;
+	}
+	skel->bss->victim_pid = victim.pid;
+	skel->bss->challenger_pid = challenger.pid;
+	if (!scx_test_start_gated_worker(&victim) ||
+	    !wait_for_counter(skel, &skel->bss->nr_lazy_victim_running, 1,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Lazy-enqueue victim was not scheduled");
+		goto out;
+	}
+	if (!wait_for_tick_stop(skel, &skel->bss->nr_lazy_ticks,
+				PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Tick did not stop before lazy enqueue");
+		goto out;
+	}
+
+	if (!scx_test_start_gated_worker(&challenger) ||
+	    !wait_for_counter(skel, &skel->bss->nr_lazy_enq_running, 1,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Lazy enqueue made no progress on CPU %d", ctx->test_cpu);
+		goto out;
+	}
+	scx_test_stop_gated_worker(&victim);
+	scx_test_stop_gated_worker(&challenger);
+
+	/* Repeat with a lazy kick delivered from a housekeeping CPU. */
+	__atomic_store_n(&skel->bss->phase, NOHZ_PHASE_LAZY_KICK,
+			 __ATOMIC_RELEASE);
+	victim = scx_test_spawn_gated_worker(ctx->test_cpu, true);
+	challenger = scx_test_spawn_gated_worker(ctx->test_cpu, true);
+	trigger = scx_test_spawn_gated_worker(ctx->housekeeping_cpu, true);
+	if (victim.pid < 0 || challenger.pid < 0 || trigger.pid < 0) {
+		SCX_ERR("Failed to spawn lazy-kick workers");
+		goto out;
+	}
+	skel->bss->victim_pid = victim.pid;
+	skel->bss->challenger_pid = challenger.pid;
+	skel->bss->trigger_pid = trigger.pid;
+	victim_running = __atomic_load_n(&skel->bss->nr_lazy_victim_running,
+					 __ATOMIC_RELAXED);
+	if (!scx_test_start_gated_worker(&victim) ||
+	    !wait_for_counter(skel, &skel->bss->nr_lazy_victim_running,
+			      victim_running + 1,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Lazy-kick victim was not scheduled");
+		goto out;
+	}
+	if (!scx_test_start_gated_worker(&challenger)) {
+		SCX_ERR("Failed to start lazy-kick challenger");
+		goto out;
+	}
+	if (!wait_for_tick_stop(skel, &skel->bss->nr_lazy_ticks,
+				PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Tick did not stop before lazy kick");
+		goto out;
+	}
+	if (__atomic_load_n(&skel->bss->nr_lazy_kick_running,
+			    __ATOMIC_RELAXED)) {
+		SCX_ERR("Lazy-kick challenger ran before the kick");
+		goto out;
+	}
+	if (!scx_test_start_gated_worker(&trigger) ||
+	    !wait_for_counter(skel, &skel->bss->nr_lazy_kick_running, 1,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Lazy kick made no progress on CPU %d", ctx->test_cpu);
+		goto out;
+	}
+	scx_test_stop_gated_worker(&trigger);
+	scx_test_stop_gated_worker(&victim);
+	scx_test_stop_gated_worker(&challenger);
 
+check_exit:
 	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
 		SCX_ERR("Scheduler exited unexpectedly (kind=%llu code=%lld)",
 			(unsigned long long)skel->data->uei.kind,
@@ -321,6 +486,9 @@ static enum scx_test_status run(void *ctx_ptr)
 		(unsigned long long)skel->bss->nr_finite_ticks);
 	status = SCX_TEST_PASS;
 out:
+	scx_test_stop_gated_worker(&trigger);
+	scx_test_stop_gated_worker(&victim);
+	scx_test_stop_gated_worker(&challenger);
 	stop_worker(finite_worker);
 	stop_worker(inf_worker);
 	if (link)
diff --git a/tools/testing/selftests/sched_ext/nohz_tick_test.h b/tools/testing/selftests/sched_ext/nohz_tick_test.h
new file mode 100644
index 0000000000000..b122d723cd8b4
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/nohz_tick_test.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES */
+#ifndef __NOHZ_TICK_TEST_H__
+#define __NOHZ_TICK_TEST_H__
+
+enum nohz_phase {
+	NOHZ_PHASE_INF,
+	NOHZ_PHASE_FINITE,
+	NOHZ_PHASE_LAZY_ENQ,
+	NOHZ_PHASE_LAZY_KICK,
+};
+
+#endif /* __NOHZ_TICK_TEST_H__ */
diff --git a/tools/testing/selftests/sched_ext/util.c b/tools/testing/selftests/sched_ext/util.c
index 2111329ed2893..5703c8afd5e2f 100644
--- a/tools/testing/selftests/sched_ext/util.c
+++ b/tools/testing/selftests/sched_ext/util.c
@@ -5,10 +5,21 @@
  */
 #include <errno.h>
 #include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
 #include <unistd.h>
+#include <zlib.h>
+
+#include "util.h"
+
+#ifndef SCHED_EXT
+#define SCHED_EXT 7
+#endif
 
 /* Returns read len on success, or -errno on failure. */
 static ssize_t read_text(const char *path, char *buf, size_t max_len)
@@ -69,3 +80,136 @@ int file_write_long(const char *path, long val)
 
 	return 0;
 }
+
+struct scx_test_gated_worker scx_test_spawn_gated_worker(int cpu,
+							 bool set_sched_ext)
+{
+	struct scx_test_gated_worker worker = { .pid = -1, .start_fd = -1 };
+	int ready[2], start[2];
+	pid_t parent = getpid();
+	char byte = 1;
+
+	if (pipe(ready))
+		return worker;
+	if (pipe(start)) {
+		close(ready[0]);
+		close(ready[1]);
+		return worker;
+	}
+
+	worker.pid = fork();
+	if (!worker.pid) {
+		struct sched_param param = {};
+		cpu_set_t mask;
+
+		close(ready[0]);
+		close(start[1]);
+		if (prctl(PR_SET_PDEATHSIG, SIGKILL) || getppid() != parent)
+			_exit(1);
+		CPU_ZERO(&mask);
+		CPU_SET(cpu, &mask);
+		if (sched_setaffinity(0, sizeof(mask), &mask))
+			_exit(1);
+		if (set_sched_ext && sched_setscheduler(0, SCHED_EXT, &param))
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
+	if (worker.pid < 0) {
+		close(ready[0]);
+		close(ready[1]);
+		close(start[0]);
+		close(start[1]);
+		return worker;
+	}
+
+	close(ready[1]);
+	close(start[0]);
+	if (read(ready[0], &byte, 1) != 1) {
+		close(ready[0]);
+		close(start[1]);
+		kill(worker.pid, SIGKILL);
+		waitpid(worker.pid, NULL, 0);
+		worker.pid = -1;
+		return worker;
+	}
+	close(ready[0]);
+	worker.start_fd = start[1];
+	return worker;
+}
+
+bool scx_test_start_gated_worker(struct scx_test_gated_worker *worker)
+{
+	char byte = 1;
+
+	if (write(worker->start_fd, &byte, 1) != 1)
+		return false;
+	close(worker->start_fd);
+	worker->start_fd = -1;
+	return true;
+}
+
+void scx_test_stop_gated_worker(struct scx_test_gated_worker *worker)
+{
+	if (worker->start_fd >= 0)
+		close(worker->start_fd);
+	if (worker->pid > 0) {
+		kill(worker->pid, SIGKILL);
+		waitpid(worker->pid, NULL, 0);
+	}
+	worker->pid = -1;
+	worker->start_fd = -1;
+}
+
+static int config_preempt_lazy_mode(void)
+{
+	bool dynamic = false, lazy = false, immediate = false;
+	char buf[128];
+	gzFile file;
+
+	file = gzopen("/proc/config.gz", "r");
+	if (!file)
+		return -1;
+
+	while (gzgets(file, buf, sizeof(buf))) {
+		if (!strcmp(buf, "CONFIG_PREEMPT_DYNAMIC=y\n"))
+			dynamic = true;
+		else if (!strcmp(buf, "CONFIG_PREEMPT_LAZY=y\n"))
+			lazy = true;
+		else if (!strcmp(buf, "CONFIG_PREEMPT_NONE=y\n") ||
+			 !strcmp(buf, "CONFIG_PREEMPT_VOLUNTARY=y\n") ||
+			 !strcmp(buf, "CONFIG_PREEMPT=y\n") ||
+			 !strcmp(buf, "CONFIG_PREEMPT_RT=y\n"))
+			immediate = true;
+	}
+	gzclose(file);
+
+	if (dynamic)
+		return -1;
+	if (lazy)
+		return 1;
+	if (immediate)
+		return 0;
+	return -1;
+}
+
+int scx_test_preempt_lazy_mode(void)
+{
+	char buf[128];
+
+	if (read_text("/sys/kernel/debug/sched/preempt", buf, sizeof(buf)) > 0) {
+		if (strstr(buf, "(lazy)"))
+			return 1;
+		if (strstr(buf, "(none)") || strstr(buf, "(voluntary)") ||
+		    strstr(buf, "(full)"))
+			return 0;
+	}
+
+	return config_preempt_lazy_mode();
+}
diff --git a/tools/testing/selftests/sched_ext/util.h b/tools/testing/selftests/sched_ext/util.h
index 681cec04b4395..6a9bd92d42a3f 100644
--- a/tools/testing/selftests/sched_ext/util.h
+++ b/tools/testing/selftests/sched_ext/util.h
@@ -7,7 +7,20 @@
 #ifndef __SCX_TEST_UTIL_H__
 #define __SCX_TEST_UTIL_H__
 
+#include <stdbool.h>
+#include <sys/types.h>
+
+struct scx_test_gated_worker {
+	pid_t pid;
+	int start_fd;
+};
+
 long file_read_long(const char *path);
 int file_write_long(const char *path, long val);
+struct scx_test_gated_worker scx_test_spawn_gated_worker(int cpu,
+							 bool set_sched_ext);
+bool scx_test_start_gated_worker(struct scx_test_gated_worker *worker);
+void scx_test_stop_gated_worker(struct scx_test_gated_worker *worker);
+int scx_test_preempt_lazy_mode(void);
 
 #endif // __SCX_TEST_UTIL_H__
-- 
2.55.0

