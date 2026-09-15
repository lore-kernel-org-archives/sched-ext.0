Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A392772D
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501616; cv=fail; b=ikLj4HFXywl6ar/7S8AfB1gfGyzBN3rnyY69fTcFVJW2akhStRTyhaN2UHbWOvsofS8tD6UhmKqUlPzyLbgLI+S4XOnxRFa0hR2MIGMAIZs1a9rHk97VESNsrs5vtUB6vLBOpRIQ+Xy5gGnEoUQTYvfVkAQ9iX5MCjzH+jq2L/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501616; c=relaxed/simple;
	bh=lnQ290CoEcFZQ1Y/UOe5whYoPXOkmcVLLRylVCL+gnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KQrScIEBuduVoTePB4knhYEXKi+vIBxB4qzRsGy3VakR56+zlEQnmKiToIlqqzaFSMTdIgYbR3Rp+kkIf/Q8PfZllD5Has7Csp27DRBiJqVd19MvliPOoCYvFd8QaCfwqpk36pWg845q9B/2ssu1dnv9hL75BRGmiRnMjuAZny8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aiGZDlpa; arc=fail smtp.client-ip=40.93.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aiGZDlpa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udco2MkRp2PsBHE6mzL1J/50Iv/uePiAPdOOtMh+xH1Jr8DlujSUxB1vMdzxrztp6iTILJdMrTBviMb2qO8uwDw9y+4XDENBqsOZiu9cNc3YH/DmvCZTEZf4EnncI9y3YK1b3BCFSPWfBa2taZqSyJJzGpIqK7sl6QOB+wUGkgqRSZBygbrxsLBmqXFi1EAntiRWxfAxVm9x4LDyjznnd+nwl2CXX4TgB3AqKJilUqbmOHGY3SaX/m2GBRKcHM7eMB5ay6dM5KcG4Lbltj5Bk2cv5gn9fznqRA6auEiBBXv6yGdyX3cex8UFbmfoFnr7B+2h4d8m8uqrjTOf2iGaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tlja+PR633HitF6PYV6jMwKQWSEYYzKY667VKeZRgAI=;
 b=De/FrKathhaO15ZQ6SEb67aKZxZ+jQSfvxgcZ8yh4od0KI0Y36BEn/7hX9ae4U77Q8ARvhjr5nk+WpaQgv+z01pLT0bAK57pcOjmEINbolTDVkz5KCj3018X8v5CnzxEWAliUIdJn+NHS8WW4E5nS+YKJDSJE1/n8uYVc8e1KLA5nkuHtt8uNjW9ZKJkBxEJitJvdA9BOInCNWdXRtKsclaGhBXCbPU8tU3RrS4A2o5zK05j8MrDGWm1JEccpC9Mh+SO8RR3Y4qs6zGyqSnS5R10eY+PxOcpWur1KjV9l3MRBZ9SVTXNmmFwYXMwrvTohrrqoVJXO35nTo6K5oZH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tlja+PR633HitF6PYV6jMwKQWSEYYzKY667VKeZRgAI=;
 b=aiGZDlpascs3Wxrvl46Iz2x5UTzJxgr4vE/qcNsKMbQdAgnjyfFJNLSBffwjCCrMlHr93TwZaxb5lL607as9oRUEgu5t55oyomvQTr0bLIpOfKxwBX054Vjt6yVRxHCPY3xkxtf3hyQ3lDVafs6Mk2MDTjvozWCdg1qzAUpjXLyG3M/lEtX6b1vnTUpGMJjNHZoMCfSzLIXW3MaWBADIxaT9KPBI+aNsiAIEdIsTwIJjijFZ4odl/mDcrRBc2EutNT3mqPsfokiFfKMV9AqwEGuxyTIdRt4rSG2D2I07C3ELf++h3EB9NNpWyr1FwWU4SKae6c47F2fz6eXtLcpepw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 19:46:33 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 19:46:33 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/sched_ext: Add lazy preemption tests
Date: Tue, 15 Sep 2026 21:45:13 +0200
Message-ID: <20260915194611.2674127-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915194611.2674127-1-arighi@nvidia.com>
References: <20260915194611.2674127-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::27) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: abb72ba8-02e8-4bb6-4503-08df13620ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|18002099003|22082099003|3023799007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bNx4z+c+L8opm7syRissCbXNkgknQBk36dQH4bPRlEb/GVUsY4xsOWdNIu5pIEtlka05Iod4eG2+eIxAmS+g2zTR6cAlCj36Ov2vMoU5G3w87hKmEWZYqEAAmlk13xQjae2lTvJfF0pGZJnUTOp4uBzVOHAKejegpO/qQW1AY/iuvFhRsDiPYBz2ubeJnrVkEgO9piyIWNLkpJIGKnxxqujMCPJUA1Bb5b3FgH+9IICAt3QGX7Cvtexd1kahU6rX6O1PSUxMHbqZehAmhrgiWDwduGuf1YQ4+tcPr25OR2KPaBO7xr0tjuA2TdMVFkvUQsOL6eRrGKjLodezMGGv9E/2typ0FvaJz18/FcZMdU+qmZOvJ0VW/eWjXWhqxQoszBq1DKQTJW9f17eRFzXxDM9xwtuq4IbiDJMPv48J2u6tTXMgBAipRPJlypVVkDHAvvSAYY9f223zMCwo+QNWMnfV5h4Wyp7EO6R1plsyxtzcCVRQ/Fd4WbZMpT6ERo0q3ZW64cZMUAW1s2aosn+ohsJh2ofN1UMF7ThXXO3ka33G39npFE/Q7mBYQ4HklnvgXb+2mFuGIprPmzynDyaI4mhgKFiT8cK9MjaRPtukMOkBK7pDgzqiyatj1WTXKTRO2Vag28UpA+ZiIvnKYifj6HhLBuQ9CrZF2L0fWZUj/Ow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?br+vQ+x1KJ44G0qpUyNG4Xuf9Vvu75vUbJ9Es3A5DkmeFQw9yB4G6gZPSXDw?=
 =?us-ascii?Q?J4r2oetMVsVzOvfHMTH32ZaxYLn03OU6Vu5QsFqbyncbCztEURl8QQKlSfjn?=
 =?us-ascii?Q?eDUImpAk/XIU4kmSrPdH30tRmN20EFq4CnXyC35VUNPQFRi+r5XIIKPhrSP7?=
 =?us-ascii?Q?+VQhItCG+kQSDY/Wnv+/jkc7gBk9lj1GRfhVQwNOZv/Tb0ZP7NpKbLjPWajy?=
 =?us-ascii?Q?hAeC+oQ0kby8GoHjvT4cO/jw/WWNPUZxMoy9i+Yj4iHHywxREt4JYe8yg/4n?=
 =?us-ascii?Q?8MQgIIF60rfsyP4LSFP4bFovn7l6R1TQVCnfUPzOgn0aqdMnrzHC46yqPfk8?=
 =?us-ascii?Q?T72MPWgfGfem4iJQddfLRNi3SI+30YXZCZmbQs0yjV4CSweobfWVmwuykh2G?=
 =?us-ascii?Q?mU5GRTFkiC5TFGFvHUolo+nLZgXq7nEV/tDCK02Ja0Goe0P4Sj08SOE/fMSt?=
 =?us-ascii?Q?cuIPFVOrTYVIZgEWzbudMbxuwGgy+5EMXukc1DS0krjlKfGN9dUL7fm5n+Np?=
 =?us-ascii?Q?WN2TJp+Pq9iLVDWBg66caPsB4JiDf4k009ZoyhopfVIS+xKLXfV4itN0p/nc?=
 =?us-ascii?Q?yMzu0whtGuZ3DcSWyOe7olq4YPLg28VOKRRcKDIsp2Mf3qs9e6IV7MeXzLIw?=
 =?us-ascii?Q?S0gTRxTN9fQ384w4FMbqsEn7z5tYBWusX4lFxDwGQXpvK9+aiZRvOAztkI+g?=
 =?us-ascii?Q?rxPNBTqKkz6Az4mw6Um60JpoMjpOKemPK3gzjW0fIEaOePNTaGsfFy9sxKiL?=
 =?us-ascii?Q?hGPcfxlMrKbwvAmBj9Q0b9zGu8HIwBHE1YPNZfK9Meg/14V5FzVkCtGk6/Jc?=
 =?us-ascii?Q?FxZwM4U/dxjKhA6pIFSmoPtXPIx/tliMHj0DYvNxyIGKu5J5izjXduFAj++7?=
 =?us-ascii?Q?/U/vfTH41C6yDXx42Iq0f8sVFtseHNMPRz2jqqYWpE87j9lSGRGC9EtW73+L?=
 =?us-ascii?Q?JenNIYRO5oTCNpMEya8ahcFamYDjGdBmgFNcSOIZvhzMkCoSRQIbW/1uNUyQ?=
 =?us-ascii?Q?zb2J8JUI65mdM+Tdox1eVvcFt+YoUekHNxp2BYik1eabVITXJlCnwJ+5xIHD?=
 =?us-ascii?Q?guRjM7nq3nVOikOOBfcgf2lkhkFOEwC2tGUskC1USwyRvpFVfRLXdhhh6f42?=
 =?us-ascii?Q?p8LCHejoeZQAV9hCY8DE7DJ4W8tbxnfCAXOvnywrbgsXXxhOoq4TWU4RnTo0?=
 =?us-ascii?Q?G+CzxO2wgDU1XeXtXuSeq3X7YdNKlGqVfY3o8abmPkGnozjJYMAW9s4vHD8s?=
 =?us-ascii?Q?me2vvZhB9pM09n9geHg0MS0DqZmGaFp3OncBRcDKRbQMD53D8DEMThdpelY5?=
 =?us-ascii?Q?QhAkR6srxxU4X5J33p5zgtmEQWWEmjM2ZCmBFla+Vqe/WOWBWst7L9exx0kx?=
 =?us-ascii?Q?FElNbsNpUYfxxVWzrGcd3NVW/IV9bD12+qLnowJW5wkAxTQmu3Gd+EcG/RKJ?=
 =?us-ascii?Q?u59hkrQX7FWeB0qXyYH0R64igUwVBXvo5JVSMqGjkP/W+frqVjN7rzk1pVsc?=
 =?us-ascii?Q?EAsRIBhDsW2oQSQ96GAaqpKqx/eGC2O7ZtaLLpxH7Eawzgj3zB6m6c4OEY7X?=
 =?us-ascii?Q?kjNrFNE3RutqOJ+A/tIzc8pLP1QF6w+Wp2uxLgQ0/ctfFT/srkqCMtVp7EqL?=
 =?us-ascii?Q?cDLiXODmxAo9X929hh5botWbokUhcCgR20e7d73JPEyoL4FnPrP+ZBtvTCju?=
 =?us-ascii?Q?GHE4xP9KdKiAtylKih90gQdpcE7fI1xOYvz+L6ir5AEnLxw4vjKMsMdlHHJv?=
 =?us-ascii?Q?Ej+Wwh244Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb72ba8-02e8-4bb6-4503-08df13620ae8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 19:46:32.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4cvngedRPAv8124c16oAsFU+jiBYPifl4NRM4irB6he3uue8UcXiEwfHNvVMwf1Dnrz3Igyv8VU6aupBJ7Isg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054

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

Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 tools/testing/selftests/sched_ext/kick.bpf.c  | 182 ++++++
 tools/testing/selftests/sched_ext/kick.c      | 617 ++++++++++++++++++
 .../selftests/sched_ext/nohz_tick.bpf.c       |  56 +-
 tools/testing/selftests/sched_ext/nohz_tick.c | 249 ++++++-
 5 files changed, 1078 insertions(+), 27 deletions(-)
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
index 0000000000000..5a64e19246004
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/kick.bpf.c
@@ -0,0 +1,182 @@
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
+const volatile s32 challenger_pid;
+const volatile s32 target_cpu;
+const volatile s32 slice_expiry_override = -1;
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
+	if (scenario == ENQ_BOTH && !enq_preempt_issued)
+		return 0;
+
+	slice_at_resched = BPF_CORE_READ(task, scx.slice);
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
+	.name			= "kick",
+};
diff --git a/tools/testing/selftests/sched_ext/kick.c b/tools/testing/selftests/sched_ext/kick.c
new file mode 100644
index 0000000000000..118cc374e6b82
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/kick.c
@@ -0,0 +1,617 @@
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
+#ifdef HAVE_GENHDR
+#include "autoconf.h"
+#endif
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
+static enum scx_test_status trace_one(struct kick_ctx *ctx, u32 scenario,
+				      u64 ops_flags,
+				      s32 slice_expiry_override,
+				      struct observation *obs)
+{
+	struct bpf_link *ops_link = NULL;
+	struct kick *skel = NULL;
+	struct victim challenger = { .pid = -1, .start_fd = -1 };
+	struct victim victim;
+	enum scx_test_status ret = SCX_TEST_FAIL;
+	int cpu = ctx->target_cpu;
+
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
+	skel->rodata->challenger_pid = challenger.pid;
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
+	obs->nr_wait_callbacks = skel->bss->nr_wait_callbacks;
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
+	if (!file) {
+#if defined(CONFIG_PREEMPT_LAZY) && !defined(CONFIG_PREEMPT_DYNAMIC)
+		return 1;
+#else
+		return -1;
+#endif
+	}
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
+	int lazy_mode;
+
+	status = trace_one(ctx, KICK_IMMEDIATE, 0, -1, &immediate);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&immediate));
+	status = trace_one(ctx, KICK_LAZY, 0, -1, &lazy);
+	SCX_EQ(status, SCX_TEST_PASS);
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
+	enum scx_test_status status;
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
+ * lazily with SCX_OPS_LAZY_SLICE_EXPIRY, the way fair.c expires a slice.
+ */
+static enum scx_test_status run_tick(void *ctx)
+{
+	struct observation immediate, lazy, force_lazy, force_immediate;
+	enum scx_test_status status;
+	u64 lazy_flag;
+	int lazy_mode;
+	bool found;
+
+	found = __COMPAT_read_enum("scx_ops_flags", "SCX_OPS_LAZY_SLICE_EXPIRY",
+				   &lazy_flag);
+	SCX_ASSERT(found);
+	status = trace_one(ctx, TICK_EXPIRY, 0, -1, &immediate);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&immediate));
+	status = trace_one(ctx, TICK_EXPIRY, lazy_flag, -1, &lazy);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&lazy));
+	status = trace_one(ctx, TICK_EXPIRY, 0, 1, &force_lazy);
+	SCX_EQ(status, SCX_TEST_PASS);
+	SCX_ASSERT(observation_valid(&force_lazy));
+	status = trace_one(ctx, TICK_EXPIRY, lazy_flag, 0,
+			   &force_immediate);
+	SCX_EQ(status, SCX_TEST_PASS);
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
+static enum scx_test_status invalid_one(struct kick_ctx *ctx, u32 scenario)
+{
+	struct bpf_link *ops_link = NULL;
+	struct kick *skel = NULL;
+	struct victim victim;
+	enum scx_test_status ret = SCX_TEST_FAIL;
+	int cpu = ctx->target_cpu;
+	int i;
+
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
index 028f54391c2ca..acc6510e239ad 100644
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
@@ -47,20 +61,21 @@ static int first_allowed_cpu(const cpu_set_t *mask, int first, int last)
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
@@ -73,25 +88,30 @@ static int find_nohz_full_cpu(const cpu_set_t *allowed)
 
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
@@ -132,6 +152,87 @@ static void stop_worker(pid_t pid)
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
@@ -162,8 +263,9 @@ static bool wait_for_counter(const u64 *counter, u64 value, int timeout_ms)
 static enum scx_test_status setup(void **ctx_ptr)
 {
 	struct nohz_tick_ctx *ctx;
-	cpu_set_t controller_mask;
-	int cpu;
+	cpu_set_t controller_mask, nohz_full_mask;
+	u64 enum_value;
+	int cpu, i, ret;
 
 	ctx = calloc(1, sizeof(*ctx));
 	SCX_FAIL_IF(!ctx, "Failed to allocate context");
@@ -173,15 +275,27 @@ static enum scx_test_status setup(void **ctx_ptr)
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
@@ -189,6 +303,13 @@ static enum scx_test_status setup(void **ctx_ptr)
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
@@ -220,11 +341,15 @@ static enum scx_test_status run(void *ctx_ptr)
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
@@ -260,7 +385,8 @@ static enum scx_test_status run(void *ctx_ptr)
 	/*
 	 * The next EXT task receives a finite slice and must restart the tick.
 	 */
-	__atomic_store_n(&skel->bss->finite_phase, true, __ATOMIC_RELEASE);
+	__atomic_store_n(&skel->bss->phase, NOHZ_PHASE_FINITE,
+			 __ATOMIC_RELEASE);
 	finite_worker = start_worker(ctx->test_cpu);
 	if (finite_worker < 0) {
 		SCX_ERR("Failed to start finite-slice worker (%d)", errno);
@@ -308,7 +434,87 @@ static enum scx_test_status run(void *ctx_ptr)
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
@@ -321,6 +527,9 @@ static enum scx_test_status run(void *ctx_ptr)
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

