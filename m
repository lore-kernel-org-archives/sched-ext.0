Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB9446825
	for <sched-ext@lists.linux.dev>; Mon, 14 Sep 2026 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397218; cv=fail; b=Cfxsu/sKdKLyZOoBzVfDZUqkWs5Vn5sLA3/m4FstDNTcPNQNacANJwiPv5JQzUpyoi0pW6xoZRZo1QJfrj9j9Ogt9uoVcDR0eH9L8932GnwIzleY4pYbESYW5IuGcabnOalEPwPJ44BRybi+Px6nnvEIXWNLeEJ4ofrfgvq01eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397218; c=relaxed/simple;
	bh=nZLRbgFqTUEXN9K4bLQbS4cD4kGGXBFCsWRxFmpN+Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PgwVMM0Ja9/jmxC7eix6IJ4bMW7mdNouKVvO8g3HmIhbpivB5sqWHwJgXsKY3e3WszFMLVuxPOin5jeEZgY61PtB1RLvxc8DZCNRiRMBS93OtUq8OYvgZ1HSbXQ5NsOvx4n/RN5M5ctxXYa+/73u1w3qKUcP81X+0EstL35QBl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qncu0VW1; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qncu0VW1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDUW1IiSrsKYOKY3WwPvKkf6cFaL0RtPLC7uwCG0uWFYygPUnifK9ErYTsHZFeQptm9+t4gbO58AhqfxL07XS5pbExHRJMZl6suzQ7azAbEPfqD3MXiej2BFV6Ulg9xd1mlByBojUT3jM8oitB9/xVnhO6WkeuCq6yL3B5DpQ96TRp+fT0H+9tUWu07YTvYKlO0dxjUWnr2ava+ODqUCEu+8D3L2jecTEjq8+Lg1mXu1aEXFUdgQMe2SOMs5tGF3B67Qlqcq0XI3T4oNej61hSKcPedval8HWyhPL8ug8z7SkR48vsHzFSCcGxV2kHWLUBYmg5ESoK+Z+y7cRtCULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK3BjQlgY9jPYySiuOx2L3JW/3upf24MIuhPNl0UCO8=;
 b=rgDCqyWPdEL2hgMXE0Y54bExrX9eLjytgymw3AEyFgDlMEtAg6FxQlSLoFDqt4JLCAJEppqtiPvGddD0EpaC+UId4k3vqqg7+jxWBF+lz6Ia1bKc55ViqlNScidEBwUkN6lk93xgqEgZCFyAYbLd7pseSvYUVyblpAik7dUtjv1NeiPzjGg3tfu35lGCsksWVPCqLPRUYtfqBDIK+AgkwY6EwtMWndohumdxs42taZkXtk0iFVWzZUCemIdH+aDNMQYIIXvttAg+9iiiUlEpN8THfwPgtKGSKGdS2ajVkat7NACGMtpjlZ0wZzbzGqqdAcLtnLxWQmSxuXlR3Hu1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK3BjQlgY9jPYySiuOx2L3JW/3upf24MIuhPNl0UCO8=;
 b=qncu0VW17nddmepnDNffBj17zouLM79DtpgUM8AowaEBlGLO8CL8QmfuATZXONnv+1omjgqsNrhi5Dpj+eUR2czr+AMB5XnIZXYYkfneCfXx6y21iILsh4+zzGJ2XppqVYs3r3XXZ6QZS3pPyzq6Gm+ZJtV8SU4wiVCFdMiCvJnEiYZE6pP/Ff2hHxNWuyNt7EDAwYwM9GOOllHs2UYi+3lNZtnzEeZSObfWEtmjWWnMWxnPDslNETDtVzQhhA7XbNiJ1VZXnVFbfpI1/Ub6TyTlgIOvi88M0t9H/NdsfOe0X+n5FQq7Vm5nRq8/uh93iICtqet0Lyepj7vhkOTMJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:46:46 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:46:45 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Add lazy preemption tests
Date: Mon, 14 Sep 2026 16:44:54 +0200
Message-ID: <20260914144620.2032614-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914144620.2032614-1-arighi@nvidia.com>
References: <20260914144620.2032614-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA5PPFB9BA66B77:EE_
X-MS-Office365-Filtering-Correlation-Id: 66cdcd9d-cf6b-4604-61d5-08df126eff2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|3023799007|10067099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3dE9d+gNjIIhhRX2pxBm04HAbOWwYgC/Hn/CuSFelrO+QXufepSO9LJlqqKvabi+VxIWi4L26VZhUldQUmyf++K4yoj4BKlwUmklTfCwiqy9R9/CfJYX4qHbYiJ5NSQLa62MpUXWgWIkxdP/kC7FBPB+Rneh6OxIwoRAN9WCez7+w7mk7jKqgcGeRCgBiBY18zvmEksL670vIZBc8tKMppia0yN+GBKwbMCAN6r/RW5P+HsPFQt2YNSkYINOBXlHrc4QhWhIqbaSvcukK3REvt0KGPpW5nTFEO2aRoGskpVkp/+K1mICRmEHStDWAcZQ0Hfw9QwJwt6Hc7OKoHKB8AXSO05C1hYGbKjEEabpu+C5DKJSrAqVndYPw2upO+CLB1+WprkwKSnbbU0xTsky/xDDuDL6AhhBAr7KAr3GpBnCAfOF+rD50UG3nJlqCgRuwJXpc6PuhjhxOe/6E/6xqpWHT79182TFz2unrjKyL1jX7HWZ4qM0LzFRg0lx1o1eesiHbPWPx8CVjfz0djqaFkXPk0F4FqBcIR5W/TGgtAgu3CaSu8cqY6y/J+qqxzqcT5pf9RUvkd4Sv+C7hjbJUQ6S1dELdn6VkTCogUsZY0maAWC0+hKPtrSwWpFAxddz4KEIeiwGGiqgSp4C3SNDy/lgZBl73nd7aWK/Kl3p1DQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0XdlGMiJFumEHBuPhL08qQfbg40K3b5NsejYSd+ecuEE+l7rygyEQdo+PvGs?=
 =?us-ascii?Q?0LE9Cs+M++B2pkSwJeYayDH9/yFi+jE9aMouBave6NY/9zUzGeUnXfI8AXDB?=
 =?us-ascii?Q?I1Ha+whU6uq1Uk7fnbcezXW1hwYbPMhZue8I6uVXmyujUuEInkE7SAqz/r+z?=
 =?us-ascii?Q?TGbprlL89nhQaAdvRzm1h9DkEg0CuCLasdxg7wUM45mBkcFeRD9BAkYsnRTh?=
 =?us-ascii?Q?sX8+tb4yr7ZpFqh9w6cxxKBBTrIkOBEpFakCDM7CoDrYR8VmC/+rWJQt88pI?=
 =?us-ascii?Q?FEET0oa8PKXcti/Uv2BSnESHFvLE9E2DCaHwvw4N8dD2UwjHcVX383oNwW+p?=
 =?us-ascii?Q?2J+AMPw98FLNGFsEo9ZOCH2TDOnfJl+CuXAtzo0ltNYS2mIjD8el6/kaEa17?=
 =?us-ascii?Q?AZdEd3Ce8KgcXy7hTYXlkL+duHZ5XeiPwgUJQ3f65/ckNdRKASrbo/lM+5Gh?=
 =?us-ascii?Q?Qxd8P/pT4B+FNjEOCGlGd+rdpgVCtKsyHQevQHP35FYDsmKnS8Ea8HFu/9qM?=
 =?us-ascii?Q?oAN7pkfREIm4VUdh+pC8Ojaa8RTAgea0yFyiUP3fcKBY6IeOq4Zl2jFcb0YV?=
 =?us-ascii?Q?YTm6eeSroHm+Jvp/COZo2ZGQ0jVs4fPhi8JRfVXxbGSXzLLZRzV1Q2aFwvC3?=
 =?us-ascii?Q?/SSYLIxVF8t22mFW24zVhpaU90R54uHGZuFw/3ExImCzio/8Wv/qqpZZwAwc?=
 =?us-ascii?Q?Wx5VEL+QpvEqRddbWvWHr1pRKIwLH0NSIXRNv7IcOmjNIz+oQDZVIh2E9h31?=
 =?us-ascii?Q?87y++ukH4d4sI7B1wuofFXzB+qMkWW5oNiMhjqhAemEb2r5tfFRXuYgX5pd5?=
 =?us-ascii?Q?63TOS6UurHhqlbYtUD2Dt+V3waucQzFGez1c9DcqI/65T5q0mWnD0oF4d3es?=
 =?us-ascii?Q?C3gSD5uvqAe/bclgxFayQoH557wXwqASChiGArhDp1Xnpmn0uzOkNSRpoQGO?=
 =?us-ascii?Q?bg8cIZZk2yoMLnD+7o3wd1j0xHIL1b5XGtHRj7oDleZEHsY7H5HGV/YYq1u5?=
 =?us-ascii?Q?WHd26/CMp5/WSdTWKvnc53I/ekl7wj/XSCnYixM9PpRU7jlh1KORqcgRxbDt?=
 =?us-ascii?Q?YELHX6BHIDqw7FfAhap9um+o6oKJimFkuWBBxXLxriBUE+kXrT9HR2d7Gcax?=
 =?us-ascii?Q?1USm/BfnZV5papqXpxw5A8I57m0dZNPf+ok8sBwFjrUgCeok/ZolQXwP6qUX?=
 =?us-ascii?Q?k9mvdyAbGJW4IRRoVfbcn1o1jnYj0lyiPRxmuRqe+3c/N9iWQ9W7RrMm07xO?=
 =?us-ascii?Q?ymCIGntXnnYtKynNgl7RS89NZF0NDuwpHyVivN7mxmx972/furwCQ1tmZCGk?=
 =?us-ascii?Q?rV/i30Jug6TZ8yR56+Gd/i7CcCRC7ovftpgF3iWbUYp0fmozgPXaEDDI/r9U?=
 =?us-ascii?Q?rhT8EE7rBvhSsZpVEgFXgm5c7by7pGqSfhalYFS9JpjuktL83EuZAMdvoE1w?=
 =?us-ascii?Q?Ip8q1Kd6nFHWUQTIvPrGEyhaNeTi7EANmJPbopJUOS4oi0C0q6lQQN7beasn?=
 =?us-ascii?Q?/S9aQswJRy5m3Td5O0l7y45YoG4kRX98YATZS+T6wq88O7A75mEGsPjG4M4J?=
 =?us-ascii?Q?BJpDXBLVKuMRn3yD2m4d/s/caBylAKvcBs1AXT0b0aYg5Hs+r70fegqiljpK?=
 =?us-ascii?Q?1yGWLG8Cmf03i5V7eMGCLMHooeqOjKkgKJVplssnVuRR2PkbvWNxCHvr/uEk?=
 =?us-ascii?Q?HPjyBOtGPwgHm4MIG5sXoI6iLaoGMgY90bfvtgqPVKSvhpISzoJxXszXxU8Y?=
 =?us-ascii?Q?+vxq0eeknw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cdcd9d-cf6b-4604-61d5-08df126eff2c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:46:45.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AADjH8hBEZevNmpIjwbOofqvvHOhHsDN6n/2xSXDIwT9ZeBZ041MuvUNydsfb6wmEVHG/RGUKAiL/BJYHi75GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77

Add trace-based coverage for immediate and lazy preemption. An fexit
probe on __resched_curr() records the requested TIF and the current task
slice, while the stopping callback verifies that the task reaches a
scheduling boundary.

Exercise kick requests individually, in both orders and combined in one
call. Verify that immediate preemption and WAIT take precedence over
lazy preemption, and that combining immediate and lazy enqueue
preemption follows the same rule. Also test overriding the expiry
default in both directions through scx_bpf_task_set_slice_expiry().

Extend the NO_HZ_FULL test with infinite-slice victims. Verify that lazy
enqueue and kick requests restart a stopped tick and make forward
progress. Keep invalid kick flag coverage and skip modes not exposed by
the running kernel.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 tools/testing/selftests/sched_ext/kick.bpf.c  | 166 ++++++
 tools/testing/selftests/sched_ext/kick.c      | 530 ++++++++++++++++++
 .../selftests/sched_ext/nohz_tick.bpf.c       |  56 +-
 tools/testing/selftests/sched_ext/nohz_tick.c | 195 ++++++-
 5 files changed, 939 insertions(+), 9 deletions(-)
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
index 0000000000000..03ddc44faf5c4
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/kick.bpf.c
@@ -0,0 +1,166 @@
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
+const volatile u32 scenario;
+const volatile s32 victim_pid;
+const volatile s32 target_cpu;
+const volatile s32 slice_expiry_override = -1;
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
+	case ENQ_BOTH:
+		if (p->pid == victim_pid) {
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_INF,
+					   enq_flags);
+		} else if (state == KICK_STATE_QUEUED) {
+			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
+					   enq_flags | SCX_ENQ_PREEMPT |
+					   SCX_ENQ_PREEMPT_LAZY);
+		} else {
+			scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL,
+					   enq_flags);
+		}
+		return;
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
+static void set_slice_expiry_override(struct task_struct *p)
+{
+	if (p->pid == victim_pid && slice_expiry_override >= 0)
+		scx_bpf_task_set_slice_expiry(p, slice_expiry_override);
+}
+
+void BPF_STRUCT_OPS(kick_running, struct task_struct *p)
+{
+	if (!is_trace_scenario() || p->pid != victim_pid)
+		return;
+	set_slice_expiry_override(p);
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
index 0000000000000..b7af2683c2728
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/kick.c
@@ -0,0 +1,530 @@
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
+#include <sys/prctl.h>
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
+	pid_t parent = getpid();
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
+		if (prctl(PR_SET_PDEATHSIG, SIGKILL) || getppid() != parent)
+			_exit(1);
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
+static enum scx_test_status trace_one(u32 scenario, u64 ops_flags,
+				      s32 slice_expiry_override,
+				      struct observation *obs)
+{
+	struct bpf_link *ops_link = NULL;
+	struct kick *skel = NULL;
+	struct victim challenger = { .pid = -1, .start_fd = -1 };
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
+	if (scenario == ENQ_BOTH) {
+		challenger = spawn_victim(cpu);
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
+	skel->rodata->target_cpu = cpu;
+	skel->rodata->slice_expiry_override = slice_expiry_override;
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
+	if (scenario == ENQ_BOTH) {
+		if (!wait_for_state(skel, KICK_STATE_QUEUED)) {
+			SCX_ERR("Enqueue scenario did not arm");
+			goto out;
+		}
+		if (!start_victim(&challenger)) {
+			SCX_ERR("Failed to start enqueue challenger");
+			goto out;
+		}
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
+	stop_victim(&challenger);
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
+static enum scx_test_status setup_coalesce(void **ctx)
+{
+	if (!enum_supported("scx_enq_flags", "SCX_ENQ_PREEMPT_LAZY")) {
+		printf("SKIP: SCX_ENQ_PREEMPT_LAZY is not supported\n");
+		return SCX_TEST_SKIP;
+	}
+	return setup_lazy(ctx);
+}
+
+static enum scx_test_status setup_invalid(void **ctx)
+{
+	return setup_lazy(ctx);
+}
+
+static enum scx_test_status run_immediate(void *ctx)
+{
+	struct observation obs;
+
+	SCX_EQ(trace_one(KICK_IMMEDIATE, 0, -1, &obs), SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&obs));
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run_lazy(void *ctx)
+{
+	struct observation immediate, lazy;
+	int lazy_mode;
+
+	SCX_EQ(trace_one(KICK_IMMEDIATE, 0, -1, &immediate), SCX_TEST_PASS);
+	SCX_EQ(trace_one(KICK_LAZY, 0, -1, &lazy), SCX_TEST_PASS);
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
+	struct observation both, lazy_wait, enq_both;
+
+	SCX_EQ(trace_one(KICK_IMMEDIATE, 0, -1, &immediate), SCX_TEST_PASS);
+	SCX_EQ(trace_one(KICK_LAZY_THEN_IMMEDIATE, 0, -1, &lazy_first), SCX_TEST_PASS);
+	SCX_EQ(trace_one(KICK_IMMEDIATE_THEN_LAZY, 0, -1, &immediate_first), SCX_TEST_PASS);
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
+	SCX_EQ(trace_one(KICK_PLAIN_THEN_LAZY, 0, -1, &plain_first), SCX_TEST_PASS);
+	SCX_EQ(trace_one(KICK_LAZY_THEN_PLAIN, 0, -1, &lazy_then_plain), SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&plain_first));
+	SCX_ASSERT(observation_valid(&lazy_then_plain));
+	SCX_EQ(plain_first.resched_tif, immediate.resched_tif);
+	SCX_EQ(lazy_then_plain.resched_tif, immediate.resched_tif);
+
+	/* Immediate kick and WAIT both take precedence over lazy preemption. */
+	SCX_EQ(trace_one(KICK_BOTH, 0, -1, &both), SCX_TEST_PASS);
+	SCX_EQ(trace_one(KICK_LAZY_WAIT, 0, -1, &lazy_wait), SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&both));
+	SCX_ASSERT(observation_valid(&lazy_wait));
+	SCX_EQ(both.resched_tif, immediate.resched_tif);
+	SCX_EQ(lazy_wait.resched_tif, immediate.resched_tif);
+
+	/* Immediate enqueue preemption likewise takes precedence over lazy. */
+	SCX_EQ(trace_one(ENQ_BOTH, 0, -1, &enq_both), SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&enq_both));
+	SCX_EQ(enq_both.resched_tif, immediate.resched_tif);
+	return SCX_TEST_PASS;
+}
+
+/*
+ * A slice running out at the tick reschedules immediately by default and
+ * lazily with SCX_OPS_LAZY_SLICE_EXPIRY, the way fair.c expires a slice.
+ */
+static enum scx_test_status run_tick(void *ctx)
+{
+	struct observation immediate, lazy, force_lazy, force_immediate;
+	u64 lazy_flag;
+	int lazy_mode;
+
+	SCX_ASSERT(__COMPAT_read_enum("scx_ops_flags", "SCX_OPS_LAZY_SLICE_EXPIRY", &lazy_flag));
+	SCX_EQ(trace_one(TICK_EXPIRY, 0, -1, &immediate), SCX_TEST_PASS);
+	SCX_EQ(trace_one(TICK_EXPIRY, lazy_flag, -1, &lazy), SCX_TEST_PASS);
+	SCX_EQ(trace_one(TICK_EXPIRY, 0, 1, &force_lazy), SCX_TEST_PASS);
+	SCX_EQ(trace_one(TICK_EXPIRY, lazy_flag, 0, &force_immediate), SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&immediate));
+	SCX_ASSERT(observation_valid(&lazy));
+	SCX_ASSERT(observation_valid(&force_lazy));
+	SCX_ASSERT(observation_valid(&force_immediate));
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
+	SCX_EQ(force_lazy.resched_tif, lazy.resched_tif);
+	SCX_EQ(force_immediate.resched_tif, immediate.resched_tif);
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
+	for (scenario = INVALID_KICK_IDLE; scenario <= INVALID_KICK_UNKNOWN; scenario++)
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
+	.description = "Verify lazy preemption coalesces with immediate requests",
+	.setup = setup_coalesce,
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
+	.description = "Verify invalid kick flag combinations fail",
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
diff --git a/tools/testing/selftests/sched_ext/nohz_tick.bpf.c b/tools/testing/selftests/sched_ext/nohz_tick.bpf.c
index 6998c5dd6bcb9..96ba1524ca384 100644
--- a/tools/testing/selftests/sched_ext/nohz_tick.bpf.c
+++ b/tools/testing/selftests/sched_ext/nohz_tick.bpf.c
@@ -9,10 +9,23 @@
 char _license[] SEC("license") = "GPL";
 
 const volatile s32 test_cpu;
-bool finite_phase;
+enum nohz_phase {
+	NOHZ_PHASE_INF,
+	NOHZ_PHASE_FINITE,
+	NOHZ_PHASE_LAZY_ENQ,
+	NOHZ_PHASE_LAZY_KICK,
+};
+
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
 
 UEI_DEFINE(uei);
 
@@ -24,9 +37,31 @@ s32 BPF_STRUCT_OPS(nohz_tick_select_cpu, struct task_struct *p, s32 prev_cpu,
 
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
@@ -36,15 +71,22 @@ void BPF_STRUCT_OPS(nohz_tick_running, struct task_struct *p)
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
+	if (bpf_get_smp_processor_id() == test_cpu &&
+	    phase == NOHZ_PHASE_FINITE)
 		__sync_fetch_and_add(&nr_finite_ticks, 1);
 }
 
@@ -61,5 +103,5 @@ struct sched_ext_ops nohz_tick_ops = {
 	.tick			= (void *)nohz_tick_tick,
 	.exit			= (void *)nohz_tick_exit,
 	.name			= "nohz_tick",
-	.timeout_ms		= 1000U,
+	.timeout_ms		= 5000U,
 };
diff --git a/tools/testing/selftests/sched_ext/nohz_tick.c b/tools/testing/selftests/sched_ext/nohz_tick.c
index 028f54391c2ca..6fd74fd629b85 100644
--- a/tools/testing/selftests/sched_ext/nohz_tick.c
+++ b/tools/testing/selftests/sched_ext/nohz_tick.c
@@ -28,12 +28,26 @@
 #endif
 
 #define MIN_FINITE_TICKS 3
-#define PHASE_TIMEOUT_MS 1000
+#define PHASE_TIMEOUT_MS 5000
 
 struct nohz_tick_ctx {
 	struct nohz_tick *skel;
 	cpu_set_t original_mask;
 	int test_cpu;
+	int housekeeping_cpu;
+	bool lazy_supported;
+};
+
+enum nohz_phase {
+	NOHZ_PHASE_INF,
+	NOHZ_PHASE_FINITE,
+	NOHZ_PHASE_LAZY_ENQ,
+	NOHZ_PHASE_LAZY_KICK,
+};
+
+struct gated_worker {
+	pid_t pid;
+	int start_fd;
 };
 
 static int first_allowed_cpu(const cpu_set_t *mask, int first, int last)
@@ -132,6 +146,87 @@ static void stop_worker(pid_t pid)
 	waitpid(pid, NULL, 0);
 }
 
+static struct gated_worker spawn_gated_worker(int cpu)
+{
+	struct gated_worker worker = { .pid = -1, .start_fd = -1 };
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
+		if (sched_setscheduler(0, SCHED_EXT, &param))
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
+static bool start_gated_worker(struct gated_worker *worker)
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
+static void stop_gated_worker(struct gated_worker *worker)
+{
+	if (worker->start_fd >= 0)
+		close(worker->start_fd);
+	stop_worker(worker->pid);
+	worker->pid = -1;
+}
+
 static int pause_worker(pid_t pid)
 {
 	int status;
@@ -163,6 +258,7 @@ static enum scx_test_status setup(void **ctx_ptr)
 {
 	struct nohz_tick_ctx *ctx;
 	cpu_set_t controller_mask;
+	u64 enum_value;
 	int cpu;
 
 	ctx = calloc(1, sizeof(*ctx));
@@ -189,6 +285,13 @@ static enum scx_test_status setup(void **ctx_ptr)
 	}
 
 	ctx->test_cpu = cpu;
+	ctx->housekeeping_cpu = first_allowed_cpu(&controller_mask, 0,
+						  CPU_SETSIZE - 1);
+	ctx->lazy_supported =
+		__COMPAT_read_enum("scx_enq_flags", "SCX_ENQ_PREEMPT_LAZY",
+				   &enum_value) &&
+		__COMPAT_read_enum("scx_kick_flags", "SCX_KICK_PREEMPT_LAZY",
+				   &enum_value);
 	ctx->skel = nohz_tick__open();
 	if (!ctx->skel) {
 		free(ctx);
@@ -220,11 +323,15 @@ static enum scx_test_status run(void *ctx_ptr)
 	struct nohz_tick_ctx *ctx = ctx_ptr;
 	struct nohz_tick *skel = ctx->skel;
 	struct bpf_link *link = NULL;
+	struct gated_worker victim = { .pid = -1, .start_fd = -1 };
+	struct gated_worker challenger = { .pid = -1, .start_fd = -1 };
+	struct gated_worker trigger = { .pid = -1, .start_fd = -1 };
 	enum scx_test_status status = SCX_TEST_FAIL;
 	pid_t finite_worker = -1;
 	pid_t inf_worker = -1;
 	u64 finite_running;
 	u64 finite_ticks;
+	u64 victim_running;
 	int ret;
 
 	link = bpf_map__attach_struct_ops(skel->maps.nohz_tick_ops);
@@ -260,7 +367,8 @@ static enum scx_test_status run(void *ctx_ptr)
 	/*
 	 * The next EXT task receives a finite slice and must restart the tick.
 	 */
-	__atomic_store_n(&skel->bss->finite_phase, true, __ATOMIC_RELEASE);
+	__atomic_store_n(&skel->bss->phase, NOHZ_PHASE_FINITE,
+			 __ATOMIC_RELEASE);
 	finite_worker = start_worker(ctx->test_cpu);
 	if (finite_worker < 0) {
 		SCX_ERR("Failed to start finite-slice worker (%d)", errno);
@@ -308,7 +416,87 @@ static enum scx_test_status run(void *ctx_ptr)
 					     finite_ticks));
 		goto out;
 	}
+	stop_worker(finite_worker);
+	finite_worker = -1;
+	stop_worker(inf_worker);
+	inf_worker = -1;
+	if (!ctx->lazy_supported)
+		goto check_exit;
+
+	/*
+	 * A lazy local enqueue must restart the tick after clearing the slice of
+	 * an infinite-slice task on a full-dynticks CPU.
+	 */
+	__atomic_store_n(&skel->bss->phase, NOHZ_PHASE_LAZY_ENQ,
+			 __ATOMIC_RELEASE);
+	victim = spawn_gated_worker(ctx->test_cpu);
+	challenger = spawn_gated_worker(ctx->test_cpu);
+	if (victim.pid < 0 || challenger.pid < 0) {
+		SCX_ERR("Failed to spawn lazy-enqueue workers");
+		goto out;
+	}
+	skel->bss->victim_pid = victim.pid;
+	skel->bss->challenger_pid = challenger.pid;
+	if (!start_gated_worker(&victim) ||
+	    !wait_for_counter(&skel->bss->nr_lazy_victim_running, 1,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Lazy-enqueue victim was not scheduled");
+		goto out;
+	}
+	usleep(100000);
+
+	if (!start_gated_worker(&challenger) ||
+	    !wait_for_counter(&skel->bss->nr_lazy_enq_running, 1,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Lazy enqueue made no progress on CPU %d", ctx->test_cpu);
+		goto out;
+	}
+	stop_gated_worker(&challenger);
+	stop_gated_worker(&victim);
+
+	/* Repeat with a lazy kick delivered from a housekeeping CPU. */
+	__atomic_store_n(&skel->bss->phase, NOHZ_PHASE_LAZY_KICK,
+			 __ATOMIC_RELEASE);
+	victim = spawn_gated_worker(ctx->test_cpu);
+	challenger = spawn_gated_worker(ctx->test_cpu);
+	trigger = spawn_gated_worker(ctx->housekeeping_cpu);
+	if (victim.pid < 0 || challenger.pid < 0 || trigger.pid < 0) {
+		SCX_ERR("Failed to spawn lazy-kick workers");
+		goto out;
+	}
+	skel->bss->victim_pid = victim.pid;
+	skel->bss->challenger_pid = challenger.pid;
+	skel->bss->trigger_pid = trigger.pid;
+	victim_running = __atomic_load_n(&skel->bss->nr_lazy_victim_running,
+					 __ATOMIC_RELAXED);
+	if (!start_gated_worker(&victim) ||
+	    !wait_for_counter(&skel->bss->nr_lazy_victim_running,
+			      victim_running + 1,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Lazy-kick victim was not scheduled");
+		goto out;
+	}
+	if (!start_gated_worker(&challenger)) {
+		SCX_ERR("Failed to start lazy-kick challenger");
+		goto out;
+	}
+	usleep(100000);
+	if (__atomic_load_n(&skel->bss->nr_lazy_kick_running,
+			    __ATOMIC_RELAXED)) {
+		SCX_ERR("Lazy-kick challenger ran before the kick");
+		goto out;
+	}
+	if (!start_gated_worker(&trigger) ||
+	    !wait_for_counter(&skel->bss->nr_lazy_kick_running, 1,
+			      PHASE_TIMEOUT_MS)) {
+		SCX_ERR("Lazy kick made no progress on CPU %d", ctx->test_cpu);
+		goto out;
+	}
+	stop_gated_worker(&trigger);
+	stop_gated_worker(&challenger);
+	stop_gated_worker(&victim);
 
+check_exit:
 	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
 		SCX_ERR("Scheduler exited unexpectedly (kind=%llu code=%lld)",
 			(unsigned long long)skel->data->uei.kind,
@@ -321,6 +509,9 @@ static enum scx_test_status run(void *ctx_ptr)
 		(unsigned long long)skel->bss->nr_finite_ticks);
 	status = SCX_TEST_PASS;
 out:
+	stop_gated_worker(&trigger);
+	stop_gated_worker(&challenger);
+	stop_gated_worker(&victim);
 	stop_worker(finite_worker);
 	stop_worker(inf_worker);
 	if (link)
-- 
2.55.0

