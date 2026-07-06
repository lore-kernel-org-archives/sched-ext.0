Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176BA37DAD5
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321556; cv=fail; b=uYTiTXZemTzKsjy2yEFjjAcOlbhGNtRuLfIHNof/CRN1ESosSfNEjH/mvpA2djN10XAxfMvHKJWVvvB3Ze4jjcu47vnotGNnlYQqhwdG8rMy4bL4KVjppbj71+P52OkK7xYx+bSL45rOev1bVEVcNmXc0NTRLDEsKWPh6eGSfrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321556; c=relaxed/simple;
	bh=yxTvbr59oVxZi96tfBSLox280lmwKxLn/qGCQwxthDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fh4mnpm8JaX8ah2LHL/5mMXVmK8Nz/u2wHdKtNPEL96VqxeT9l0ZdqD7ow8Yfn7dz2CG7ecOBCEdYfWXWP6UJsLmmgFgbh5JbihUJ7+cM97zTUyvYfE4KcmntW+8sQO3cMAJvjWVPgef3Pa9T+djsEQHbhjOCW4uMgd4gqaTrLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hmr0tFC/; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hmr0tFC/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uizAIdOCU4d2Df1notdaF6q6QUOHLHAUlPSyBB85dQPJn/c137fgJfTxEEn9iqHPFgOPPTO7qiASKCN5PCx0vZTaYuqraPXysu3FteLpY8d1oJ2SiZ7cALdpN0wpAV/7HHHfKc0rjYan6A+YNlRfjj/QoMU27a0in7Wt92YZFDrj+98SieuKq6t1/zpVTmWmjNh9wtTzKMXmZtVuVlb0cnOGU+Zhm17HZqj6vDb6TDFRTL7zABNIIIyQPQb6idPxcGjwhwS2dSxpYLrPaJ1od9HIxnZpPVkblNBXSIyzTTpOQlfev1LrfNBj/0nbJtzW6VZSk6mbZ3WZQSPKUUAsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI3rF8TJgJduXNh0WGrzrJwD0QZxwlVOq6uUfmHqL2I=;
 b=stpcGlOpuAGWDt3Aq0Qm/ooSQvWidynR12JoAWkPGZpF2TNKjd014eVbA9MALLPddQI/CiJtpkkS0+2xEN8+p13AnFu4MGroLTPaSKhb1z15XxFiMv24CoeZXAUVfwrj2B2xo7ziJxQ/h5oXeMv/CjMtA4aS2QmSdUnCfrkKwOVi/OUyETqANk0TRYdHZLvZxT0X2P4kYyaQ4SFr2Rp4R2SPTlIOb5RRDIkEP3KqOJh2IhtG7ZhKZV10A8wB0H0WGd3Auu7/82ygL4/AwECmlGgGXzR7sPBjuLeen014pcaImKCftQGymS3zeD/euGdi3Sl4WXOE9+jr3c54t2NkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI3rF8TJgJduXNh0WGrzrJwD0QZxwlVOq6uUfmHqL2I=;
 b=Hmr0tFC/NIpk/op9otPB82zQ4uMG6nr0snhoCRyldeArB5dJ1WzwVxtbvS6Jd6DoL2rc0eXNEnYEdhVZFZxcp6aKCBAnbvCvoDWi59XD867s6uHutmOIRxBelTu8jmFt7ruKc0OyuuxtX3gF4i06jF2XEhAVBkAkGe2/DJrdlvshUggrKT0OCy6wNygSFJodXnHxPOlcsUH/qpFkw227HJ3kPra3VwVjI/NpuJjyaa0B31siRccqkus1Bc7Aaz9M5D7XP+m03Qva/EzPoXektGkmDkDnBKmzOkvQc1e5H8zj3VEk/X2i8WX8JHJmh9utHBjcXSeRGoyu6lS3eHx6pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:05:13 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:05:13 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
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
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] sched_ext: Add selftest for blocked donor admission
Date: Mon,  6 Jul 2026 08:51:02 +0200
Message-ID: <20260706070410.282826-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706070410.282826-1-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 43700b8b-55a0-4d32-8e3c-08dedb2cec87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ctv4SDkzNUBI1H3UcNqBTSTqlCFS0AdjbOgkiQyOurQPK5gYrWz5Jo3Dy2AZTWeNKnCXmW3QqTd9EIirkLZhrh3ZCpBjVVozqJDifOC9V89aiNef2YrAe614t0+6cXZwYn05wJFhvMNSrZHfw3LyJqFKe3Z0KNxyq5fxZYDO4uGE1qi3i5C+9KJRxn3ULN3AB1L+KnVbWu0t7hjlAxfGxToOGIT60j3QstDe/6jfPlYTJ9O4Vbj4M6HbsA+EdUPkIuodrBpwBwu5SmsmM6eg7Bz4iw1y5mZuLYWadQ65EEg0Y5lokieWkukmul9E2/beBPZwUOI6Y68KAr8jTbX9gtQmlbZaDjAM8axOAmopJzRYGCpz6QtCQWhGCktxoj+t8lJSO10ukEO7b7hoLFdBc+xoP7XNBIIy88SaDjTyv2N7pIpmAz3idQkas+kPY+dI7Hd5wiN3gOlW+yh1oCMuTQUlIyVmu7XTgbukkQURN4rHKMSJKIC23QaLLPfFklPaaWWn8399nQ27BVYgvzDQQtBzbx6Yq/Z4vq/NRyYskBjrCBGZzrjZdiwBfCvuPy9OqFI/b+PInma5LrKp4PGg8kaZC/3No+BpIe9GZsvzejbIRX9F6C3B53MU4PY7X4MmSmj7RRrFFZ8+rHOCfhSYbjz6uejDUKQ97WTHzV6D9uE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gFylsAEVcy+VBFb4zNXAEu6Egp96PAEQ57oIcNLYxX75PaA1QDiv6Yugpg2k?=
 =?us-ascii?Q?czzyL+IMrCil+uS0vm0usMHAh2QIBGErgob2TzRk2LZqlfTDpMxHQ1GNRG3u?=
 =?us-ascii?Q?7a0ayM2GO5QZ7eeQg4+1SoREdIXDzpfSANgwa0xxORqGkNY/nTCLivYJX5Vb?=
 =?us-ascii?Q?f0B970jRGIAp0J7rsFHbpoSPIvSZ9K9glyhtIAmTXWhuy6SWPr8gLca7R/QW?=
 =?us-ascii?Q?dFa0SEsfziy+yRhsDEr7Y8XqlhyzMZXB7iQWhi4cWn/w27rTSWh8fiCOWXoi?=
 =?us-ascii?Q?eySqXdwKxp7Vyvmeb60sX2Hrt5RxZHf2IuaDAL+37s0NR5e+W6x+CtInzAcq?=
 =?us-ascii?Q?/ic3URN9I8ZQeeaWHYQLMrbwAKBWq0I6P+Rg6pjOGFwzsoIRWjJBlR47M9dM?=
 =?us-ascii?Q?aL2cbdHPfK/ikk1pDJ8EI0vaTpf3jeg5NgY9e2Xv3h+N+URSXRhdeBv7UcgD?=
 =?us-ascii?Q?REcHXMF20scoUDm4n3FTVU4IrIcP7ifmuKwGGxV6rG/luxaVFfxLyIjVsjy7?=
 =?us-ascii?Q?uRXHVb+1oSvQkaCXClrqLrUGDKttP1b6wbrOC1zxRJuWdwnSaJxTAyMZMxJo?=
 =?us-ascii?Q?8UAlutILkhAUC9/ZAPGM2f4JXoCMoQVqaHnBQozoCsvx/AKEqEoPkAsMpH7Q?=
 =?us-ascii?Q?F3JX3lM/OmwD4lqbk+hsmgnoCdNUgqEkFlapfsKVcZiKSCIUEoJ8Hwlzwdhe?=
 =?us-ascii?Q?f6WWEPW+6goENf+Q1eA2uTpIqAiREo0dQdaXqnqfsvepT+Uj7eHrQDMvjQa3?=
 =?us-ascii?Q?ydArRc6/QzFcjheVaOZ0JJlszG8vqxYERM6/nHuTsBFses0v4SIlnYLW78xx?=
 =?us-ascii?Q?hXvAdvsgjrWgA2N35QHWZ0qugLCkwQzryQBb1NN1T4YcFKr7T0HsemEFljyZ?=
 =?us-ascii?Q?BPgRIw5EjmKEFfZqrz77T7VMLoPoFtepFTgczeGT+UgnBhRsts6Tcz0ta1ol?=
 =?us-ascii?Q?r6HhCY6VSxq6/QcKpVxdFHQsloDTlxxCeVFKnd1LLicaS48uh2vctTsPpprr?=
 =?us-ascii?Q?k4L2RjpXgSkC7RHSIj/ZUzXnGNo+6uMru7Qf+CgPR2naqyXb+fS4CnrKqFaU?=
 =?us-ascii?Q?AJyWWH7eXj4r5DYnIRH7F1rG3lwnovTNVnX5uDY4L7izrEIIBYco/LvvnWdO?=
 =?us-ascii?Q?byYCh/bu5W6X+DV1odUBVL+BAzvU89BUYccA4oB+A3lvceDBwf+Cd9KAAlgE?=
 =?us-ascii?Q?yEWPTnXGsnIfQGu594wJS1Qcod/UGJ6FVgyIgDSNb84bYu/O0cNntzvyLzgm?=
 =?us-ascii?Q?HjBI90LjdtQTgC3dAyyJJALoGTHkSPAhbUNjB4Gg8191nMl6leC/tbQ4k681?=
 =?us-ascii?Q?2uRB21yLe47ofh48EYmxwtfUqzQgZ9dL4tpgT2bi9js63uVjYVvaQn+YrTqg?=
 =?us-ascii?Q?f3KZRAs7+IRTFzgRDlc75iSTmjdnibl5PHu1g4Hd4mCujrPpPHCMBoQFiw5h?=
 =?us-ascii?Q?meNqlZd2jKEW3swSq/UchzbT2PHB/5XMhNh9RBz+mPiIyFWapa9jF5xSYFpw?=
 =?us-ascii?Q?qM4BnPkAW6z8PBeOIq55hlDvk8hdYmotiyOPungglOXsu++Rv9vN4zvDqfd5?=
 =?us-ascii?Q?HeHQB2VsgiPcq5AfHgM2XHkdE/n9KEiyfHVkKN4YY0W7te0mEcTZMFXuIHAj?=
 =?us-ascii?Q?f6UEg+sZHyay1W8yUJjXP+sbH67wU+iyjZ2rCvPVwgiXobxHoRA/FsoagKkc?=
 =?us-ascii?Q?BVaQlD81KDvzJFKX5OYQqIZnRLBcUSLmDZh4lDR7424qLpD/7N5bLxCoWyuh?=
 =?us-ascii?Q?qcd/Uh/F/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43700b8b-55a0-4d32-8e3c-08dedb2cec87
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:05:13.3009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8E8o6NF8TrbpXiA4+qTCHZUqucx+0mgaNy3muDseZ2GV9biQx0FFOb3I1/KBz+s4tPZ1MzFPDBV3zzwiKauFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

SCX_OPS_ENQ_BLOCKED allows BPF schedulers to receive blocked proxy
donors through ops.enqueue(). SCX_ENQ_BLOCKED identifies donor admission
requests in enq_flags, while __COMPAT_scx_bpf_task_proxy_cpu() returns the
CPU of the mutex owner or a fallback error when the kfunc is unavailable.
Add test coverage for this interface and owner CPU.

Exercise a three-task priority inversion on a single CPU using a
weighted vruntime BPF scheduler. A nice +19 owner holds a shared mutex,
a nice -20 donor blocks on it and a nice 0 CPU contender delays the
owner.

Block the first donor before attaching the BPF scheduler and hold the
owner until attachment completes. Verify that the donor starts sleeping
and on-rq, is removed from the runqueue when the incoming scheduler does
not support blocked donors, and remains on-rq when it does.

Run the workload with SCX_OPS_ENQ_BLOCKED first disabled and then
enabled. In the enabled run, count blocked donor enqueues, validate the
proxy CPU, and dispatch the donor there to facilitate proxy execution.
Report average mutex hold and wait times without enforcing performance
results.

Proxy execution coverage requires CONFIG_SCHED_PROXY_EXEC=y, which the
selftest config selects. The mutex fixture is a loadable kernel module
built through TEST_GEN_MODS_DIR and managed by the test.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/.gitignore  |   4 +
 tools/testing/selftests/sched_ext/Makefile    |   2 +
 tools/testing/selftests/sched_ext/config      |   2 +
 .../selftests/sched_ext/enq_blocked.bpf.c     | 128 +++
 .../testing/selftests/sched_ext/enq_blocked.c | 732 ++++++++++++++++++
 .../testing/selftests/sched_ext/enq_blocked.h |  27 +
 .../selftests/sched_ext/test_modules/Makefile |  13 +
 .../test_modules/scx_enq_blocked_test.c       | 193 +++++
 8 files changed, 1101 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_blocked.h
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c

diff --git a/tools/testing/selftests/sched_ext/.gitignore b/tools/testing/selftests/sched_ext/.gitignore
index ae5491a114c09..54a1fd2af713d 100644
--- a/tools/testing/selftests/sched_ext/.gitignore
+++ b/tools/testing/selftests/sched_ext/.gitignore
@@ -4,3 +4,7 @@
 !Makefile
 !.gitignore
 !config
+!test_modules/
+!test_modules/scx_enq_blocked_test.c
+!test_modules/Makefile
+test_modules/*.mod.c
diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5d2dffca0e918..8eeece67d1de1 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -5,6 +5,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 TEST_GEN_PROGS := runner
+TEST_GEN_MODS_DIR := test_modules
 
 # override lib.mk's default rules
 OVERRIDE_TARGETS := 1
@@ -164,6 +165,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 auto-test-targets :=			\
 	create_dsq			\
 	dequeue				\
+	enq_blocked			\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/config b/tools/testing/selftests/sched_ext/config
index aa901b05c8ad6..affa3cf33470a 100644
--- a/tools/testing/selftests/sched_ext/config
+++ b/tools/testing/selftests/sched_ext/config
@@ -6,3 +6,5 @@ CONFIG_BPF=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_BTF=y
+CONFIG_EXPERT=y
+CONFIG_SCHED_PROXY_EXEC=y
diff --git a/tools/testing/selftests/sched_ext/enq_blocked.bpf.c b/tools/testing/selftests/sched_ext/enq_blocked.bpf.c
new file mode 100644
index 0000000000000..e4e0e5ce8c2ee
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_blocked.bpf.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ *
+ * Verify that SCX_OPS_ENQ_BLOCKED passes blocked proxy donors through
+ * ops.enqueue().
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ 0
+
+char _license[] SEC("license") = "GPL";
+
+s32 donor_pid;
+s32 expected_proxy_cpu;
+u64 nr_blocked_enqueues;
+u64 nr_bad_proxy_cpus;
+static u64 vtime_now;
+
+UEI_DEFINE(uei);
+
+s32 BPF_STRUCT_OPS(enq_blocked_select_cpu,
+		   struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(enq_blocked_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	if (enq_flags & SCX_ENQ_BLOCKED) {
+		int cpu = __COMPAT_scx_bpf_task_proxy_cpu(p);
+
+		if (p->pid == donor_pid) {
+			__sync_fetch_and_add(&nr_blocked_enqueues, 1);
+			if (expected_proxy_cpu != cpu)
+				__sync_fetch_and_add(&nr_bad_proxy_cpus, 1);
+		}
+
+		/*
+		 * Admit blocked proxy donors immediately and steer them to the
+		 * mutex owner's CPU, if possible; otherwise keep them on the
+		 * CPU they're currently associated with. A successful dispatch
+		 * to a remote DSQ makes the destination the donor's new
+		 * callback home CPU for proxy exec.
+		 *
+		 * This is done to exercise scx_bpf_task_proxy_cpu().
+		 * Production schedulers may instead keep the donor on its
+		 * current CPU for better locality.
+		 */
+		if (cpu < 0 || !bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
+			cpu = scx_bpf_task_cpu(p);
+
+		/*
+		 * SCX_ENQ_PREEMPT puts the donor at the head of the remote DSQ
+		 * and requests preemption on the destination CPU to expedite
+		 * the proxy execution switch.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL,
+				   enq_flags | SCX_ENQ_PREEMPT);
+		return;
+	}
+
+	/* Limit the amount of budget an idling task can accumulate. */
+	u64 vtime = p->scx.dsq_vtime;
+
+	if (time_before(vtime, vtime_now - SCX_SLICE_DFL))
+		vtime = vtime_now - SCX_SLICE_DFL;
+
+	scx_bpf_dsq_insert_vtime(p, SHARED_DSQ, SCX_SLICE_DFL, vtime,
+				 enq_flags);
+	scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
+}
+
+void BPF_STRUCT_OPS(enq_blocked_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);
+}
+
+void BPF_STRUCT_OPS(enq_blocked_running, struct task_struct *p)
+{
+	if (time_before(vtime_now, p->scx.dsq_vtime))
+		vtime_now = p->scx.dsq_vtime;
+}
+
+void BPF_STRUCT_OPS(enq_blocked_stopping, struct task_struct *p, bool runnable)
+{
+	u64 delta = scale_by_task_weight_inverse(p,
+					 SCX_SLICE_DFL - p->scx.slice);
+
+	scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);
+}
+
+void BPF_STRUCT_OPS(enq_blocked_enable, struct task_struct *p)
+{
+	scx_bpf_task_set_dsq_vtime(p, vtime_now);
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(enq_blocked_init)
+{
+	int ret;
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret) {
+		scx_bpf_error("failed to create DSQ %d (%d)", SHARED_DSQ, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(enq_blocked_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops enq_blocked_ops = {
+	.select_cpu		= (void *)enq_blocked_select_cpu,
+	.enqueue		= (void *)enq_blocked_enqueue,
+	.dispatch		= (void *)enq_blocked_dispatch,
+	.running		= (void *)enq_blocked_running,
+	.stopping		= (void *)enq_blocked_stopping,
+	.enable			= (void *)enq_blocked_enable,
+	.init			= (void *)enq_blocked_init,
+	.exit			= (void *)enq_blocked_exit,
+	.name			= "enq_blocked",
+};
diff --git a/tools/testing/selftests/sched_ext/enq_blocked.c b/tools/testing/selftests/sched_ext/enq_blocked.c
new file mode 100644
index 0000000000000..a3999e096d0bb
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_blocked.c
@@ -0,0 +1,732 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ *
+ * Exercise a three-task priority inversion on a single CPU. A high-priority
+ * donor blocks on a mutex held by a low-priority owner while a medium-priority
+ * contender consumes CPU. A weighted-vruntime BPF scheduler runs the workload
+ * with SCX_OPS_ENQ_BLOCKED first disabled and then enabled. When enabled, the
+ * scheduler observes the blocked donor in ops.enqueue(), validates the proxy
+ * CPU, and dispatches the donor there to facilitate proxy execution.
+ *
+ * Report the average mutex hold and wait times for both runs and their deltas.
+ * The timing data is informational; only blocked-donor admission and proxy CPU
+ * selection are validated. CONFIG_SCHED_PROXY_EXEC=y is required to exercise
+ * the proxy-execution paths.
+ */
+#define _GNU_SOURCE
+
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <pthread.h>
+#include <sched.h>
+#include <scx/common.h>
+#include <stdatomic.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/resource.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "enq_blocked.bpf.skel.h"
+#include "enq_blocked.h"
+#include "scx_test.h"
+
+#define MODULE_NAME	"scx_enq_blocked_test"
+#define MODULE_FILE	"test_modules/" MODULE_NAME ".ko"
+#define DEVICE_PATH	"/dev/scx_enq_blocked"
+#define WAIT_STEP_US	1000
+#define WAIT_TIMEOUT_MS	2000
+#define NR_TRIALS	10
+#define JOIN_TIMEOUT_MS	((NR_TRIALS + 1) * WAIT_TIMEOUT_MS)
+#define OWNER_NICE	19
+#define DONOR_NICE	-20
+#define CONTENDER_NICE	0
+
+struct thread_ctx {
+	atomic_bool start_donor;
+	atomic_bool abort;
+	atomic_bool stop_contender;
+	atomic_int contender_status;
+	atomic_int donor_pid;
+	atomic_int donor_completed;
+	int fd;
+	int cpu;
+};
+
+static bool parse_bool(const char *value, bool *result)
+{
+	if (!strcasecmp(value, "1") || !strcasecmp(value, "y") ||
+	    !strcasecmp(value, "yes") || !strcasecmp(value, "on") ||
+	    !strcasecmp(value, "true")) {
+		*result = true;
+		return true;
+	}
+
+	if (!strcasecmp(value, "0") || !strcasecmp(value, "n") ||
+	    !strcasecmp(value, "no") || !strcasecmp(value, "off") ||
+	    !strcasecmp(value, "false")) {
+		*result = false;
+		return true;
+	}
+
+	return false;
+}
+
+static bool cmdline_bool(const char *name, bool default_value)
+{
+	char cmdline[4096], *newline, *saveptr = NULL, *token;
+	size_t name_len = strlen(name);
+	bool value = default_value;
+	FILE *file;
+
+	file = fopen("/proc/cmdline", "r");
+	if (!file)
+		return default_value;
+
+	if (!fgets(cmdline, sizeof(cmdline), file)) {
+		fclose(file);
+		return default_value;
+	}
+	fclose(file);
+	newline = strchr(cmdline, '\n');
+	if (newline)
+		*newline = '\0';
+
+	for (token = strtok_r(cmdline, " ", &saveptr); token;
+	     token = strtok_r(NULL, " ", &saveptr)) {
+		bool parsed;
+
+		if (strncmp(token, name, name_len) || token[name_len] != '=')
+			continue;
+		if (parse_bool(token + name_len + 1, &parsed))
+			value = parsed;
+	}
+
+	return value;
+}
+
+static int module_path(char *path, size_t size)
+{
+	ssize_t len;
+	char *slash;
+
+	len = readlink("/proc/self/exe", path, size - 1);
+	if (len < 0)
+		return -errno;
+	path[len] = '\0';
+
+	slash = strrchr(path, '/');
+	if (!slash)
+		return -EINVAL;
+	*slash = '\0';
+
+	if (snprintf(slash, size - (slash - path), "/%s", MODULE_FILE) >=
+	    size - (slash - path))
+		return -ENAMETOOLONG;
+
+	return 0;
+}
+
+static int load_test_module(bool *loaded_here)
+{
+	char path[PATH_MAX];
+	int fd, err;
+
+	err = module_path(path, sizeof(path));
+	if (err)
+		return err;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	if (syscall(SYS_finit_module, fd, "", 0)) {
+		err = errno;
+		close(fd);
+		if (err == EEXIST)
+			return 0;
+		return -err;
+	}
+
+	close(fd);
+	*loaded_here = true;
+	return 0;
+}
+
+static void unload_test_module(bool loaded_here)
+{
+	if (loaded_here && syscall(SYS_delete_module, MODULE_NAME, O_NONBLOCK))
+		SCX_ERR("Failed to unload %s (%d)", MODULE_NAME, errno);
+}
+
+static int pin_to_cpu(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	return sched_setaffinity(0, sizeof(mask), &mask) ? errno : 0;
+}
+
+static int set_nice(int nice)
+{
+	return setpriority(PRIO_PROCESS, 0, nice) ? errno : 0;
+}
+
+static bool wait_for_pid(atomic_int *pid)
+{
+	int waited_ms;
+
+	for (waited_ms = 0; waited_ms < WAIT_TIMEOUT_MS; waited_ms++) {
+		if (atomic_load_explicit(pid, memory_order_acquire) > 0)
+			return true;
+		usleep(WAIT_STEP_US);
+	}
+
+	return false;
+}
+
+static int wait_for_contender(struct thread_ctx *ctx)
+{
+	int status, waited_ms;
+
+	for (waited_ms = 0; waited_ms < WAIT_TIMEOUT_MS; waited_ms++) {
+		status = atomic_load_explicit(&ctx->contender_status,
+					      memory_order_acquire);
+		if (status)
+			return status;
+		usleep(WAIT_STEP_US);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int wait_for_donor_state(struct thread_ctx *ctx, int expected)
+{
+	int state, waited_ms;
+
+	for (waited_ms = 0; waited_ms < WAIT_TIMEOUT_MS; waited_ms++) {
+		state = ioctl(ctx->fd, ENQ_BLOCKED_IOCTL_DONOR_STATE);
+		if (state == expected)
+			return state;
+		if (state < 0 && errno != ENOENT)
+			return -errno;
+		usleep(WAIT_STEP_US);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static bool wait_for_donor(struct thread_ctx *ctx, int trial)
+{
+	int waited_ms;
+
+	for (waited_ms = 0; waited_ms < WAIT_TIMEOUT_MS; waited_ms++) {
+		if (atomic_load_explicit(&ctx->donor_completed,
+					 memory_order_acquire) >= trial)
+			return true;
+		if (atomic_load_explicit(&ctx->abort, memory_order_relaxed))
+			return false;
+		usleep(WAIT_STEP_US);
+	}
+
+	return false;
+}
+
+static void *contender_fn(void *arg)
+{
+	struct thread_ctx *ctx = arg;
+	int err;
+
+	err = pin_to_cpu(ctx->cpu);
+	if (!err)
+		err = set_nice(CONTENDER_NICE);
+	atomic_store_explicit(&ctx->contender_status, err ? -err : 1,
+			      memory_order_release);
+	if (err)
+		return (void *)(uintptr_t)err;
+
+	while (!atomic_load_explicit(&ctx->stop_contender,
+				     memory_order_relaxed))
+		;
+
+	return NULL;
+}
+
+static void *owner_fn(void *arg)
+{
+	struct thread_ctx *ctx = arg;
+	int err, i;
+
+	err = pin_to_cpu(ctx->cpu);
+	if (err)
+		return (void *)(uintptr_t)err;
+	err = set_nice(OWNER_NICE);
+	if (err)
+		return (void *)(uintptr_t)err;
+
+	for (i = 0; i < NR_TRIALS; i++) {
+		if (ioctl(ctx->fd, ENQ_BLOCKED_IOCTL_OWNER))
+			return (void *)(uintptr_t)errno;
+		if (!wait_for_donor(ctx, i + 1))
+			return (void *)(uintptr_t)ETIMEDOUT;
+	}
+
+	return NULL;
+}
+
+static int run_donor_trial(struct thread_ctx *ctx)
+{
+	int waited_ms;
+
+	for (waited_ms = 0; waited_ms < WAIT_TIMEOUT_MS; waited_ms++) {
+		if (!ioctl(ctx->fd, ENQ_BLOCKED_IOCTL_DONOR))
+			return 0;
+		if (errno != EAGAIN)
+			return -errno;
+		usleep(WAIT_STEP_US);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void *donor_fn(void *arg)
+{
+	struct thread_ctx *ctx = arg;
+	int err, i;
+
+	err = pin_to_cpu(ctx->cpu);
+	if (err)
+		return (void *)(uintptr_t)err;
+	err = set_nice(DONOR_NICE);
+	if (err)
+		return (void *)(uintptr_t)err;
+
+	atomic_store_explicit(&ctx->donor_pid, syscall(SYS_gettid),
+			      memory_order_release);
+	while (!atomic_load_explicit(&ctx->start_donor, memory_order_acquire) &&
+	       !atomic_load_explicit(&ctx->abort, memory_order_relaxed))
+		sched_yield();
+
+	if (atomic_load_explicit(&ctx->abort, memory_order_relaxed))
+		return NULL;
+
+	for (i = 0; i < NR_TRIALS; i++) {
+		err = run_donor_trial(ctx);
+		if (err)
+			return (void *)(uintptr_t)-err;
+		atomic_store_explicit(&ctx->donor_completed, i + 1,
+				      memory_order_release);
+	}
+
+	return NULL;
+}
+
+static void print_avg_time(const char *name, u64 total_ns, u64 samples)
+{
+	u64 avg_ns = samples ? total_ns / samples : 0;
+
+	printf("  %s_avg_ns=%llu (%llu.%03llu ms, samples=%llu)\n", name,
+	       (unsigned long long)avg_ns,
+	       (unsigned long long)(avg_ns / 1000000),
+	       (unsigned long long)((avg_ns / 1000) % 1000),
+	       (unsigned long long)samples);
+}
+
+static void print_avg_delta(const char *name, u64 disabled_total,
+			    u64 disabled_samples, u64 enabled_total,
+			    u64 enabled_samples)
+{
+	u64 disabled_avg, enabled_avg;
+	s64 delta_ns;
+	double delta_pct;
+
+	if (!disabled_samples || !enabled_samples)
+		return;
+
+	disabled_avg = disabled_total / disabled_samples;
+	enabled_avg = enabled_total / enabled_samples;
+	delta_ns = (s64)enabled_avg - (s64)disabled_avg;
+	delta_pct = disabled_avg ? 100.0 * delta_ns / disabled_avg : 0.0;
+
+	printf("  %s_delta_ns=%+lld (%+.2f%%)\n", name,
+	       (long long)delta_ns, delta_pct);
+}
+
+static int join_thread(pthread_t thread, const struct timespec *deadline,
+		       int *thread_err)
+{
+	void *result;
+	int err;
+
+	err = pthread_timedjoin_np(thread, &result, deadline);
+	if (err)
+		return err;
+
+	*thread_err = (int)(uintptr_t)result;
+	return 0;
+}
+
+static void set_join_deadline(struct timespec *deadline)
+{
+	clock_gettime(CLOCK_REALTIME, deadline);
+	deadline->tv_sec += JOIN_TIMEOUT_MS / 1000;
+	deadline->tv_nsec += (JOIN_TIMEOUT_MS % 1000) * 1000000;
+	if (deadline->tv_nsec >= 1000000000) {
+		deadline->tv_sec++;
+		deadline->tv_nsec -= 1000000000;
+	}
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct enq_blocked *skel;
+	u64 flag;
+
+	skel = enq_blocked__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+
+	flag = SCX_OPS_ENQ_BLOCKED;
+	if (!flag) {
+		enq_blocked__destroy(skel);
+		fprintf(stderr, "SKIP: SCX_OPS_ENQ_BLOCKED is unavailable\n");
+		return SCX_TEST_SKIP;
+	}
+
+	enq_blocked__destroy(skel);
+	*ctx = NULL;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run_one(bool enq_blocked,
+				    struct enq_blocked_stats *result)
+{
+	struct enq_blocked *skel;
+	struct thread_ctx thread_ctx = {};
+	struct bpf_link *link = NULL;
+	pthread_t owner, donor, contender;
+	struct timespec join_deadline;
+	cpu_set_t mask;
+	bool module_loaded = false;
+	bool owner_started = false, donor_started = false;
+	bool contender_started = false;
+	bool join_timed_out = false;
+	bool proxy_enabled;
+	enum scx_test_status status = SCX_TEST_PASS;
+	int cpu, donor_pid, donor_state, err, thread_err;
+	u64 nr_blocked;
+	struct enq_blocked_stats stats;
+
+	skel = enq_blocked__open();
+	if (!skel) {
+		SCX_ERR("Failed to open skel");
+		return SCX_TEST_FAIL;
+	}
+	SCX_ENUM_INIT(skel);
+	skel->struct_ops.enq_blocked_ops->flags =
+		SCX_OPS_ENQ_LAST |
+		(enq_blocked ? SCX_OPS_ENQ_BLOCKED : 0);
+	if (enq_blocked__load(skel)) {
+		SCX_ERR("Failed to load skel");
+		status = SCX_TEST_FAIL;
+		goto out_skel;
+	}
+
+	proxy_enabled = cmdline_bool("sched_proxy_exec", true);
+
+	err = load_test_module(&module_loaded);
+	if (err == -EPERM || err == -ENOENT) {
+		fprintf(stderr, "SKIP: cannot load mutex fixture (%d)\n", -err);
+		status = SCX_TEST_SKIP;
+		goto out_skel;
+	}
+	if (err) {
+		SCX_ERR("Failed to load mutex fixture (%d)", -err);
+		status = SCX_TEST_FAIL;
+		goto out_skel;
+	}
+
+	thread_ctx.fd = open(DEVICE_PATH, O_RDONLY | O_CLOEXEC);
+	if (thread_ctx.fd < 0) {
+		SCX_ERR("Failed to open %s (%d)", DEVICE_PATH, errno);
+		status = SCX_TEST_FAIL;
+		goto out_module;
+	}
+	if (ioctl(thread_ctx.fd, ENQ_BLOCKED_IOCTL_RESET_STATS)) {
+		SCX_ERR("Failed to reset mutex statistics (%d)", errno);
+		status = SCX_TEST_FAIL;
+		goto out_fd;
+	}
+
+	if (sched_getaffinity(0, sizeof(mask), &mask)) {
+		SCX_ERR("Failed to get CPU affinity (%d)", errno);
+		status = SCX_TEST_FAIL;
+		goto out_fd;
+	}
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (CPU_ISSET(cpu, &mask))
+			break;
+	}
+	if (cpu == CPU_SETSIZE) {
+		status = SCX_TEST_SKIP;
+		goto out_fd;
+	}
+	thread_ctx.cpu = cpu;
+	skel->bss->expected_proxy_cpu = cpu;
+
+	if (ioctl(thread_ctx.fd, ENQ_BLOCKED_IOCTL_PREP_ATTACH)) {
+		SCX_ERR("Failed to prepare scheduler attachment (%d)", errno);
+		status = SCX_TEST_FAIL;
+		goto out_fd;
+	}
+
+	err = pthread_create(&owner, NULL, owner_fn, &thread_ctx);
+	if (err) {
+		SCX_ERR("Failed to create owner thread (%d)", err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+	owner_started = true;
+
+	err = pthread_create(&donor, NULL, donor_fn, &thread_ctx);
+	if (err) {
+		SCX_ERR("Failed to create donor thread (%d)", err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+	donor_started = true;
+
+	if (!wait_for_pid(&thread_ctx.donor_pid)) {
+		SCX_ERR("Timed out waiting for donor thread");
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+	donor_pid = atomic_load_explicit(&thread_ctx.donor_pid,
+					 memory_order_acquire);
+	skel->bss->donor_pid = donor_pid;
+	atomic_store_explicit(&thread_ctx.start_donor, true,
+			      memory_order_release);
+
+	donor_state = ENQ_BLOCKED_DONOR_SLEEPING;
+	if (proxy_enabled)
+		donor_state |= ENQ_BLOCKED_DONOR_ON_RQ;
+	err = wait_for_donor_state(&thread_ctx, donor_state);
+	if (err < 0) {
+		SCX_ERR("Donor did not block before scheduler attachment (%d)", -err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+	link = bpf_map__attach_struct_ops(skel->maps.enq_blocked_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+	donor_state = ENQ_BLOCKED_DONOR_SLEEPING;
+	if (proxy_enabled && enq_blocked)
+		donor_state |= ENQ_BLOCKED_DONOR_ON_RQ;
+	err = wait_for_donor_state(&thread_ctx, donor_state);
+	if (err < 0) {
+		SCX_ERR("Unexpected donor state after scheduler attachment (%d)",
+			-err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+	if (ioctl(thread_ctx.fd, ENQ_BLOCKED_IOCTL_ATTACH_DONE)) {
+		SCX_ERR("Failed to complete scheduler attachment (%d)", errno);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+	err = pthread_create(&contender, NULL, contender_fn, &thread_ctx);
+	if (err) {
+		SCX_ERR("Failed to create contender thread (%d)", err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+	contender_started = true;
+
+	err = wait_for_contender(&thread_ctx);
+	if (err != 1) {
+		SCX_ERR("Contender thread failed (%d)", -err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+out:
+	ioctl(thread_ctx.fd, ENQ_BLOCKED_IOCTL_ATTACH_DONE);
+	if (status != SCX_TEST_PASS) {
+		atomic_store_explicit(&thread_ctx.abort, true, memory_order_release);
+		atomic_store_explicit(&thread_ctx.start_donor, true,
+				      memory_order_release);
+	}
+
+	set_join_deadline(&join_deadline);
+	if (donor_started) {
+		err = join_thread(donor, &join_deadline, &thread_err);
+		if (err == ETIMEDOUT) {
+			SCX_ERR("Timed out waiting for donor thread");
+			join_timed_out = true;
+			status = SCX_TEST_FAIL;
+		} else if (err) {
+			SCX_ERR("Failed to join donor thread (%d)", err);
+			status = SCX_TEST_FAIL;
+		} else {
+			donor_started = false;
+			if (thread_err) {
+				SCX_ERR("Donor thread failed (%d)", thread_err);
+				status = SCX_TEST_FAIL;
+			}
+		}
+	}
+	if (!join_timed_out && owner_started) {
+		err = join_thread(owner, &join_deadline, &thread_err);
+		if (err == ETIMEDOUT) {
+			SCX_ERR("Timed out waiting for owner thread");
+			join_timed_out = true;
+			status = SCX_TEST_FAIL;
+		} else if (err) {
+			SCX_ERR("Failed to join owner thread (%d)", err);
+			status = SCX_TEST_FAIL;
+		} else {
+			owner_started = false;
+			if (thread_err) {
+				SCX_ERR("Owner thread failed (%d)", thread_err);
+				status = SCX_TEST_FAIL;
+			}
+		}
+	}
+	atomic_store_explicit(&thread_ctx.stop_contender, true,
+			      memory_order_release);
+	if (!join_timed_out && contender_started) {
+		err = join_thread(contender, &join_deadline, &thread_err);
+		if (err == ETIMEDOUT) {
+			SCX_ERR("Timed out waiting for contender thread");
+			join_timed_out = true;
+			status = SCX_TEST_FAIL;
+		} else if (err) {
+			SCX_ERR("Failed to join contender thread (%d)", err);
+			status = SCX_TEST_FAIL;
+		} else {
+			contender_started = false;
+			if (thread_err) {
+				SCX_ERR("Contender thread failed (%d)", thread_err);
+				status = SCX_TEST_FAIL;
+			}
+		}
+	}
+
+	/* Restore the fair scheduler before waiting for any stranded thread. */
+	if (join_timed_out) {
+		atomic_store_explicit(&thread_ctx.abort, true,
+				      memory_order_release);
+		if (link) {
+			bpf_link__destroy(link);
+			link = NULL;
+		}
+		if (donor_started)
+			pthread_join(donor, NULL);
+		if (owner_started)
+			pthread_join(owner, NULL);
+		if (contender_started)
+			pthread_join(contender, NULL);
+	}
+
+	if (ioctl(thread_ctx.fd, ENQ_BLOCKED_IOCTL_GET_STATS, &stats)) {
+		SCX_ERR("Failed to read mutex statistics (%d)", errno);
+		status = SCX_TEST_FAIL;
+	} else {
+		*result = stats;
+		printf("\n[SCX_OPS_ENQ_BLOCKED=%s]\n",
+		       enq_blocked ? "enabled" : "disabled");
+		printf("  proxy_exec=%s\n",
+		       proxy_enabled ? "enabled" : "disabled");
+		printf("  owner_nice=%d\n", OWNER_NICE);
+		printf("  donor_nice=%d\n", DONOR_NICE);
+		printf("  contender_nice=%d\n", CONTENDER_NICE);
+		print_avg_time("mutex_hold", stats.hold_time_ns, stats.nr_holds);
+		print_avg_time("mutex_wait", stats.wait_time_ns, stats.nr_waits);
+	}
+
+	nr_blocked = skel->bss->nr_blocked_enqueues;
+	printf("  nr_blocked_enqueues=%llu\n",
+	       (unsigned long long)nr_blocked);
+	if (status == SCX_TEST_PASS) {
+		if (enq_blocked && proxy_enabled && !nr_blocked) {
+			SCX_ERR("ops.enqueue() did not receive the blocked donor");
+			status = SCX_TEST_FAIL;
+		} else if ((!enq_blocked || !proxy_enabled) && nr_blocked) {
+			SCX_ERR("ops.enqueue() unexpectedly received %llu blocked donors",
+				(unsigned long long)nr_blocked);
+			status = SCX_TEST_FAIL;
+		} else if (skel->bss->nr_bad_proxy_cpus) {
+			SCX_ERR("scx_bpf_task_proxy_cpu() returned an unexpected CPU %llu times",
+				(unsigned long long)skel->bss->nr_bad_proxy_cpus);
+			status = SCX_TEST_FAIL;
+		}
+	}
+
+	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+		SCX_ERR("Scheduler exited unexpectedly (kind=%llu code=%lld)",
+			(unsigned long long)skel->data->uei.kind,
+			(long long)skel->data->uei.exit_code);
+		status = SCX_TEST_FAIL;
+	}
+
+	if (link)
+		bpf_link__destroy(link);
+out_fd:
+	close(thread_ctx.fd);
+out_module:
+	unload_test_module(module_loaded);
+out_skel:
+	enq_blocked__destroy(skel);
+	return status;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct enq_blocked_stats disabled = {}, enabled = {};
+	enum scx_test_status status;
+
+	(void)ctx;
+
+	status = run_one(false, &disabled);
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_one(true, &enabled);
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	printf("\n[delta: enabled - disabled]\n");
+	print_avg_delta("mutex_hold", disabled.hold_time_ns,
+			disabled.nr_holds, enabled.hold_time_ns,
+			enabled.nr_holds);
+	print_avg_delta("mutex_wait", disabled.wait_time_ns,
+			disabled.nr_waits, enabled.wait_time_ns,
+			enabled.nr_waits);
+
+	return SCX_TEST_PASS;
+}
+
+struct scx_test enq_blocked = {
+	.name = "enq_blocked",
+	.description = "Verify BPF-driven proxy donor admission",
+	.setup = setup,
+	.run = run,
+};
+
+REGISTER_SCX_TEST(&enq_blocked)
diff --git a/tools/testing/selftests/sched_ext/enq_blocked.h b/tools/testing/selftests/sched_ext/enq_blocked.h
new file mode 100644
index 0000000000000..68094fb06c875
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_blocked.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES */
+#ifndef __ENQ_BLOCKED_H
+#define __ENQ_BLOCKED_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+struct enq_blocked_stats {
+	__u64 hold_time_ns;
+	__u64 wait_time_ns;
+	__u64 nr_holds;
+	__u64 nr_waits;
+};
+
+#define ENQ_BLOCKED_IOCTL_OWNER	_IO('s', 1)
+#define ENQ_BLOCKED_IOCTL_DONOR	_IO('s', 2)
+#define ENQ_BLOCKED_IOCTL_RESET_STATS	_IO('s', 3)
+#define ENQ_BLOCKED_IOCTL_GET_STATS	_IOR('s', 4, struct enq_blocked_stats)
+#define ENQ_BLOCKED_IOCTL_PREP_ATTACH	_IO('s', 5)
+#define ENQ_BLOCKED_IOCTL_ATTACH_DONE	_IO('s', 6)
+#define ENQ_BLOCKED_IOCTL_DONOR_STATE	_IO('s', 7)
+
+#define ENQ_BLOCKED_DONOR_SLEEPING	(1U << 0)
+#define ENQ_BLOCKED_DONOR_ON_RQ		(1U << 1)
+
+#endif /* __ENQ_BLOCKED_H */
diff --git a/tools/testing/selftests/sched_ext/test_modules/Makefile b/tools/testing/selftests/sched_ext/test_modules/Makefile
new file mode 100644
index 0000000000000..a0e9e9401ead6
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/test_modules/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+
+TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
+KDIR ?= $(if $(O),$(O),$(realpath ../../../../..))
+
+obj-m += scx_enq_blocked_test.o
+
+all:
+	+$(Q)$(MAKE) -C $(KDIR) M=$(TESTMODS_DIR) modules
+
+clean:
+	+$(Q)$(MAKE) -C $(KDIR) M=$(TESTMODS_DIR) clean
diff --git a/tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c b/tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
new file mode 100644
index 0000000000000..e352301d9e274
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/test_modules/scx_enq_blocked_test.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES
+ *
+ * Kernel mutex fixture for the sched_ext SCX_OPS_ENQ_BLOCKED selftest.
+ */
+
+#include <linux/atomic.h>
+#include <linux/fs.h>
+#include <linux/jiffies.h>
+#include <linux/ktime.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+
+#include "../enq_blocked.h"
+
+#define DONOR_WAIT_TIMEOUT	msecs_to_jiffies(2000)
+#define ATTACH_WAIT_TIMEOUT	msecs_to_jiffies(10000)
+#define MUTEX_HOLD_TIME		msecs_to_jiffies(200)
+
+static DEFINE_MUTEX(test_mutex);
+static DEFINE_SPINLOCK(donor_lock);
+static struct task_struct *donor_task;
+static atomic_t owner_ready = ATOMIC_INIT(0);
+static atomic_t donor_started = ATOMIC_INIT(0);
+static atomic_t attach_pending = ATOMIC_INIT(0);
+static atomic_t attach_done = ATOMIC_INIT(0);
+static atomic64_t hold_time_ns = ATOMIC64_INIT(0);
+static atomic64_t wait_time_ns = ATOMIC64_INIT(0);
+static atomic64_t nr_holds = ATOMIC64_INIT(0);
+static atomic64_t nr_waits = ATOMIC64_INIT(0);
+
+static long run_owner(void)
+{
+	unsigned long timeout;
+	u64 start_ns;
+	long ret = 0;
+
+	atomic_set(&donor_started, 0);
+	mutex_lock(&test_mutex);
+	start_ns = ktime_get_ns();
+	atomic_set(&owner_ready, 1);
+
+	timeout = jiffies + DONOR_WAIT_TIMEOUT;
+	while (!atomic_read(&donor_started)) {
+		if (time_after(jiffies, timeout)) {
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+		cond_resched();
+	}
+	if (atomic_xchg(&attach_pending, 0)) {
+		timeout = jiffies + ATTACH_WAIT_TIMEOUT;
+		while (!atomic_read(&attach_done)) {
+			if (time_after(jiffies, timeout)) {
+				ret = -ETIMEDOUT;
+				goto out;
+			}
+			cond_resched();
+		}
+	}
+
+	/* Keep yielding while the donor blocks on test_mutex. */
+	timeout = jiffies + MUTEX_HOLD_TIME;
+	while (time_before(jiffies, timeout))
+		cond_resched();
+
+out:
+	atomic_set(&owner_ready, 0);
+	atomic64_add(ktime_get_ns() - start_ns, &hold_time_ns);
+	atomic64_inc(&nr_holds);
+	mutex_unlock(&test_mutex);
+	return ret;
+}
+
+static long run_donor(void)
+{
+	unsigned long flags;
+	u64 start_ns;
+
+	if (!atomic_read(&owner_ready))
+		return -EAGAIN;
+
+	get_task_struct(current);
+	spin_lock_irqsave(&donor_lock, flags);
+	WARN_ON_ONCE(donor_task);
+	donor_task = current;
+	spin_unlock_irqrestore(&donor_lock, flags);
+
+	atomic_set(&donor_started, 1);
+	start_ns = ktime_get_ns();
+	mutex_lock(&test_mutex);
+
+	spin_lock_irqsave(&donor_lock, flags);
+	donor_task = NULL;
+	spin_unlock_irqrestore(&donor_lock, flags);
+	put_task_struct(current);
+
+	atomic64_add(ktime_get_ns() - start_ns, &wait_time_ns);
+	atomic64_inc(&nr_waits);
+	mutex_unlock(&test_mutex);
+	return 0;
+}
+
+static long get_donor_state(void)
+{
+	struct task_struct *task;
+	unsigned long flags;
+	long state = 0;
+
+	spin_lock_irqsave(&donor_lock, flags);
+	task = donor_task;
+	if (task)
+		get_task_struct(task);
+	spin_unlock_irqrestore(&donor_lock, flags);
+	if (!task)
+		return -ENOENT;
+
+	if (READ_ONCE(task->__state) != TASK_RUNNING)
+		state |= ENQ_BLOCKED_DONOR_SLEEPING;
+	if (READ_ONCE(task->on_rq))
+		state |= ENQ_BLOCKED_DONOR_ON_RQ;
+	put_task_struct(task);
+	return state;
+}
+
+static void reset_stats(void)
+{
+	atomic64_set(&hold_time_ns, 0);
+	atomic64_set(&wait_time_ns, 0);
+	atomic64_set(&nr_holds, 0);
+	atomic64_set(&nr_waits, 0);
+}
+
+static long get_stats(unsigned long arg)
+{
+	struct enq_blocked_stats stats = {
+		.hold_time_ns = atomic64_read(&hold_time_ns),
+		.wait_time_ns = atomic64_read(&wait_time_ns),
+		.nr_holds = atomic64_read(&nr_holds),
+		.nr_waits = atomic64_read(&nr_waits),
+	};
+
+	return copy_to_user((void __user *)arg, &stats, sizeof(stats)) ?
+		-EFAULT : 0;
+}
+
+static long enq_blocked_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	switch (cmd) {
+	case ENQ_BLOCKED_IOCTL_OWNER:
+		return run_owner();
+	case ENQ_BLOCKED_IOCTL_DONOR:
+		return run_donor();
+	case ENQ_BLOCKED_IOCTL_RESET_STATS:
+		reset_stats();
+		return 0;
+	case ENQ_BLOCKED_IOCTL_GET_STATS:
+		return get_stats(arg);
+	case ENQ_BLOCKED_IOCTL_PREP_ATTACH:
+		atomic_set(&attach_done, 0);
+		atomic_set(&attach_pending, 1);
+		return 0;
+	case ENQ_BLOCKED_IOCTL_ATTACH_DONE:
+		atomic_set(&attach_done, 1);
+		return 0;
+	case ENQ_BLOCKED_IOCTL_DONOR_STATE:
+		return get_donor_state();
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct file_operations enq_blocked_fops = {
+	.owner			= THIS_MODULE,
+	.unlocked_ioctl		= enq_blocked_ioctl,
+};
+
+static struct miscdevice enq_blocked_device = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "scx_enq_blocked",
+	.fops	= &enq_blocked_fops,
+	.mode	= 0600,
+};
+
+module_misc_device(enq_blocked_device);
+MODULE_AUTHOR("Andrea Righi <arighi@nvidia.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("sched_ext blocked donor test module");
-- 
2.55.0

