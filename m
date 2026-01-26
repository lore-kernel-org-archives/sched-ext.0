Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C532AAD0
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421705; cv=fail; b=dI6owD3ByX+njlbOFYuEcxUrSVwCOeos7HwP8GujLUUVcvkgWN0vtkzZuCeB96Q/PcKjjl2Q/8ClVJDlWx92xmcms5n0oTH1zj15xSltdm2LMI4vxB2couuiiaUVeKzKL5Aev1qBIuFuocv8aJzfUBrAcmq9epx9z+qi5qv+Vso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421705; c=relaxed/simple;
	bh=IrcU3+HiklWlbi6mgrdky0gHzqPHDoE8zmJIbV+a5l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I2uvlRwbts2cRc9hzkXxfTJM4D8EjgbNSbaCscyq/tNgEoNyz0bWAB1icpjFvMHjYhYIrqZBboVPllgTp98xByQELqCNHgOSnv7nCCsDlvlM7W8ODRuXmIw/Z3C0T1Iliw3cUYT36E35oNjoXWdw24Ok/bl9N4CZ1AETwrrN1r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SujNCyz/; arc=fail smtp.client-ip=40.93.196.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SujNCyz/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vK+ZZni/HGmILV9MwZaMW+oWnk+lddyIpF6k35ivgoiR+a4wC2c4tSa81ai2sNUww2Dfoqjj2Xr90wbuYhEELdAIyfNXyFTEP0HKtuMGqvnsxp9e/vR22fEZalX11VfUCR8+lclYvKWmvG8mUML2JiaycqTdGZCpWPXoMgyALhIPE1xzZTtt5LaFz95GNcmsYy4SBe4pZACX80BryCdb8tb1B190KXPu/UaAya4+h34uOOUDSFaETmQv0YXY48yvX8YP1AFzO6lIP9/mY0I3Svdq8Aw3ZixefR9NwKCGifsQ5og8PKCTNcQJKacq4b+BOkOZnyWeznt63iR2bttN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGtZtWDX2XG1lf6uaatd1O9NjTB1C50OGv4wfN/Do/s=;
 b=mE+OEezT8/ShD12cAMt+IpjhRn4x5jbhC5XbWKkbTFstALl9i8MCG39/yQGQDIXDgl1G6OH3bZBXuVeS0KhPhpGb/uRnfq5t7HhOZe9ujqYQ8BXGHoc09sPFOC32baUu97kHCocNqVjBABXlkupyGDTxTEwGhjITp1W0GVZ+4uY4LpdiipDO9Q+StezP9skLY5YuRAlM1VMLzKGnDNNHe+ZT3wC4hnYbXACFYSj8s58T+9DaVPCPLp9LjRvXRlhZrWLGq9gVfqmV2afe3anPBdB5c+81yvM0uHEmgNsFWQ7GE/ASlPFs4HwHfPkQUQmQH314PN8CGrpyXNpvQ7fbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGtZtWDX2XG1lf6uaatd1O9NjTB1C50OGv4wfN/Do/s=;
 b=SujNCyz/ebqc7WA9gJpM0FhV8CiEveh1BZEArKar3M83dkrm+eGdX3cHdmDjDUu2Yqdq/XMGaGmbfy4Sse0e63dXcuwk/EGSpN99N8qY5t7uSqTJAp5Emf6it/86MMtCyUo1GHLXTHmUO7tB46Rt/1VbaYPksP+4xuoD3JOIxHFPzlKcXaJK5e4cdo2DYCpcl/nOBiOhCjSN1uFyuGTFzaELwEb99nL8WVhl+HOlRD34rTXBCWF96OzFRAnC+ApddRgIGjkxebLHkzihAUehBZqt691cYX9IvoJ5YWLsBCXhlujX062HTzUy+2eoKxiyUvPJZ1s+GbEfR/kCd3OpXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:01:40 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:01:40 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] selftests/sched_ext: Add test for sched_ext dl_server
Date: Mon, 26 Jan 2026 10:59:04 +0100
Message-ID: <20260126100050.3854740-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126100050.3854740-1-arighi@nvidia.com>
References: <20260126100050.3854740-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0174.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 1455a94c-4215-4f2c-bee2-08de5cc1de47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GtLe+idbfW79QYRbgI5gf+uOlLjcOr2YsCtEb5amrg2CxKo5Msqa8BhuzvB3?=
 =?us-ascii?Q?8TW+ZmkQuCBOLfF9fpc8XQ1fi1vFy5DhlQ5kOGUL64wg49hpRJ3BqM928Wqw?=
 =?us-ascii?Q?zyqtbq4Gbbhj3XMSWK80y9zE4Br9o/8yak0dEg4N5ccCaCKMt9iUL+6rNZ0T?=
 =?us-ascii?Q?ccSceMRuwDiozGrSIpf49FIHhsy2vNwzpRca1D+svggNBElvZYdaehKeunLY?=
 =?us-ascii?Q?HeDsUe6kwS5rGHb3/N+ajKORBxfEFqmMPO+U7d/xaM7M6FUprcFrPoi6Xk/j?=
 =?us-ascii?Q?9FfI7PKTgxBx/lqYx0dOZOKTg5CoDeBzvPDz0q9yJzsdi8pV+aoqTMvU4J6W?=
 =?us-ascii?Q?HSj0PXl59eQP+4JD+VQkyruVsZA6nQm/B8JNvQ6OHboyfziLTlANkNFMCdLG?=
 =?us-ascii?Q?1fI/ubpsM1AGR+N3qizL33v8j9+5lFYB45D+TPq4qPPsbId/eH8x4FYaYoV7?=
 =?us-ascii?Q?xgtWbR+4JJJ4FQO9rinppQYM2Tn0UB02IcF49Bp9pRLV/zbwaTPtFgT3fTrq?=
 =?us-ascii?Q?D0oKoXYVPYMsQ1dVZ6GYyU9LjyDc3BxIBAv2idHPLuwh+NBCr+V014BAw2FU?=
 =?us-ascii?Q?44RZxdVaSV2V7+zJI2tTqGcDEWglOvK3eDZ91nl6N8wJygov/TBjnnxqUUCX?=
 =?us-ascii?Q?iCjyaRoP0Od8Ki7qehrYZNS/Ayh+STJDoiYNgu5B866JUZSeNzHQOMXWCed2?=
 =?us-ascii?Q?yiWP1iX2bef7ltQvHL3xmaG/3w32I72crdTEU8bBkMLTKzjhO/3vz1GjkRAm?=
 =?us-ascii?Q?AAfBUTidSSGK5+FCML3rzJYTxsPvm9UNRMZXn9JRQCeMInVLHZyePcl2O3xu?=
 =?us-ascii?Q?8FX4pAFM4a1F7bLUHReeh3S1g3diOjvHaAdNdJZCvA6DKyv4i7JyAXblmY+l?=
 =?us-ascii?Q?22l17+az31jsRRFEAnKpzQgTPSqVKia6BEP7oXhI9Zc1rV7PUqyngc8+nl4f?=
 =?us-ascii?Q?nCsc61qxpQW2Zzu5+DQuV7TX4LAs21+ZNK5sSP3BJILEF7gP1V9j402gh68R?=
 =?us-ascii?Q?27mPm9zcejUZczEcW1a+kvIMBMTetwehS78/H1+KbeJzRyx3zKlKwg3PNqzM?=
 =?us-ascii?Q?ub0yNdc+/9l1wHq6BaAWE7+pgEf/Qe3f1pL4rscoSr7L8xwGxaLb+gqDTtnL?=
 =?us-ascii?Q?PfbN+zOaH5nPpURUM36CggzIdnyRzPbSrfpYlfsiTsMdDljMTGNnsNJox7RO?=
 =?us-ascii?Q?7k0ZUMcBDROvYXj/M3XdkIYX5QmbT2CsBCZ5B/vxNghoBS5Iin2zFDUZWGe8?=
 =?us-ascii?Q?QmB73ledLzBnWVGo+x5NW1zWUeJoO3osXhv8xnhXgWi6rQ9bUyQ+k7OYaXSw?=
 =?us-ascii?Q?3d/bI+d+17J9E7L0NnE5mixlmuVd3Cd5+K4GEwRDo8JxzltITrlBxmjBKzLq?=
 =?us-ascii?Q?pOpQ4jh1eRrXezDliW7RV/21taMhSc+/WTdWR57kJcQFvc9nfxQlfQjyEoQB?=
 =?us-ascii?Q?+E8wHyV0plIZIAedQw6gzeem702ABoZeDKTI1HrL+d12MFb7AFZKTxrNlVVC?=
 =?us-ascii?Q?7p+Do8ncFZ3AO3xF9zhLujGV2XzPMP2/em4OXmc6V0wQ3xXmnYkG+a79Ge/p?=
 =?us-ascii?Q?T7/IYY1HlHZlFQK4RcI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HjHG5dmUjAxlLk5+PhHpPDgoS9uhEEvNZjs9zM1DFCtG1ZssCP7+MPREf9rl?=
 =?us-ascii?Q?PYHD806G7Ao9GRarsVsbESIjAYA62IEGPiyA/d64Mjfi+dbWX6UE/RxBumGg?=
 =?us-ascii?Q?xA88q/2y2rFyoc5COxqjwqRTFAxTKr5Q6e0aO5kecnyH/9+z4ZLE6L2Cmyg4?=
 =?us-ascii?Q?Fh5KlT1Pqtf5RNUuUpxECZTEFMZxqyA2bKh1IHAYM8g1G4VjxbdxWYWrOiRO?=
 =?us-ascii?Q?OMs9MBUTbs1xNx+MNA+OVpMYxZzWZ2azCw7zhNIniXFzoNJusCaKcosBx5W/?=
 =?us-ascii?Q?INNyHs6LbUF7gu5JJq26u9C+OR+Ds4Pi0D+v1FZufBHcWsG7rqkLi1uodEoO?=
 =?us-ascii?Q?4ccxddSw7SBqRrDrLcscWx6ihhC8on1+V1YZyQO8PzH/ietK4zacs/An6jJB?=
 =?us-ascii?Q?/DSR9xh+8ZA0DImhlRHkvlxqpGDqVx3CqGIpudPQ+DZ4Qkvodm4+zmzPho1K?=
 =?us-ascii?Q?4YK07+79MtXxs1MUqj1moxxXkYWXwGsX5hfyHMJZwgRJcvgmWOyq/7Hq7Av+?=
 =?us-ascii?Q?1GnCsYX/vgKmqmedjTl4+Ga1WnnuzDb7y+f7ABp4sYtHRROFKX4n71XSwACP?=
 =?us-ascii?Q?HtGrFy1IIwAtVgRBWC555w0jF7HgIYwp04R7Hl5Zfgd7ySPv9s7u61ReE6GK?=
 =?us-ascii?Q?KIc4aPbRe7GqpxMBA1C5fgkyM2Dv0C8bEOviYFej/0kyJW/L1SiS2ro0rB5O?=
 =?us-ascii?Q?V6TskYUa4FyerQBc9KRqU0CdQNFGinoEdGJKYMuzdzi7riboJsXGOwFqpe/K?=
 =?us-ascii?Q?3ufiVlXxNRvCkhPYU98meFE714poTAz/pZfCDIH5OBuoAzixkgTF2Hr+duzr?=
 =?us-ascii?Q?b93d1X6fcwBTn/mAXJuVrk3zl1lFwxa5eEq5H+TNVfVMc9nu/WWodOKrQhXm?=
 =?us-ascii?Q?SFdXRCxpc+InOyXr9H+cflICTevbyoTzHU/tgJx31HGgXHoYUzH//tXfj+y6?=
 =?us-ascii?Q?5RmIRM5+F6xnrS1L+u+6hGz1IB3MJpZbWOhwyl43aKwxylbT4io5wZuq8RVW?=
 =?us-ascii?Q?w/weW/yh3FoQiwOVS1UiOciXb/o1cxMN92CiiphSukNKefehh62rdPJsz5Bc?=
 =?us-ascii?Q?ZZQrgwiDSmcrgUg4WxoIVl8gYR1HErbZAkNX6cXkH1VEMPz/mr6LCA9UReYq?=
 =?us-ascii?Q?chcT1amJ3QBEuPIbKGzA7a7sjB1LJxBoEXnKEU40pmVHU7cIRYgtnifQdsUU?=
 =?us-ascii?Q?+HQIc46wyeiLpyLaPUNsVp3gMyLuWsX+vfArL7wPCxB4CoyBoIdn0lRIqaBy?=
 =?us-ascii?Q?cwyTZ0vJpR9byGCwe0mTbpRerAftVC99HV1mDTjhOJ3NZiZIUxF87dmvXwcZ?=
 =?us-ascii?Q?woZpGT/svCehHeKI6ublmxK/f+4s+JhHWaqF2GlnPWF1e3zsEMB80ggoPn3P?=
 =?us-ascii?Q?lg07pTrYewShhopHjGZIEsNikrUl1PG+rSEoIrhN2lWzGwwQ7RJT8WsDvUBZ?=
 =?us-ascii?Q?+O61hI5VBPDcDFlcsmM4J57MyTNIhl+K7Qxkq29G445JJFGG5XfyjFnvtPBP?=
 =?us-ascii?Q?deNWvSpDBfHX1VSdbFnW8joML51UuQ/6XBoSPMyawje96RKpVpFFVo3TRMiv?=
 =?us-ascii?Q?znSs+YhD6zvWZx/bNwjXijvjIgrDjsQUz7C7PEKx+vD/7xoyBKc6IJFbBkzH?=
 =?us-ascii?Q?RbQT/+bYPAMi6+6mt1kxTk5/u/keUJuGBVH8MU1PY+kcZA+dtWeMXrNpmJxH?=
 =?us-ascii?Q?M8bPFI/e2jLTgW544BpjXoysHi434s9riU7JahKhpAvivMCU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1455a94c-4215-4f2c-bee2-08de5cc1de47
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:01:40.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iO8CaYOrXnC5lq3Ol7bjnRH+ym/mn3azyLbmSnfsO7O6Bd27SHGPuxNII8Aa+IUeYT+CSRlVBvhx/Fw1KmY2JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

Add a selftest to validate the correct behavior of the deadline server
for the ext_sched_class.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 240 ++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5fe45f9c5f8fd..c9255d1499b6e 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -183,6 +183,7 @@ auto-test-targets :=			\
 	select_cpu_dispatch_bad_dsq	\
 	select_cpu_dispatch_dbl_dsp	\
 	select_cpu_vtime		\
+	rt_stall			\
 	test_example			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
new file mode 100644
index 0000000000000..80086779dd1eb
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops rt_stall_ops = {
+	.exit			= (void *)rt_stall_exit,
+	.name			= "rt_stall",
+};
diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
new file mode 100644
index 0000000000000..015200f80f6e2
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <linux/sched.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <unistd.h>
+#include "rt_stall.bpf.skel.h"
+#include "scx_test.h"
+#include "../kselftest.h"
+
+#define CORE_ID		0	/* CPU to pin tasks to */
+#define RUN_TIME        5	/* How long to run the test in seconds */
+
+/* Simple busy-wait function for test tasks */
+static void process_func(void)
+{
+	while (1) {
+		/* Busy wait */
+		for (volatile unsigned long i = 0; i < 10000000UL; i++)
+			;
+	}
+}
+
+/* Set CPU affinity to a specific core */
+static void set_affinity(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask) != 0) {
+		perror("sched_setaffinity");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Set task scheduling policy and priority */
+static void set_sched(int policy, int priority)
+{
+	struct sched_param param;
+
+	param.sched_priority = priority;
+	if (sched_setscheduler(0, policy, &param) != 0) {
+		perror("sched_setscheduler");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Get process runtime from /proc/<pid>/stat */
+static float get_process_runtime(int pid)
+{
+	char path[256];
+	FILE *file;
+	long utime, stime;
+	int fields;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	file = fopen(path, "r");
+	if (file == NULL) {
+		perror("Failed to open stat file");
+		return -1;
+	}
+
+	/* Skip the first 13 fields and read the 14th and 15th */
+	fields = fscanf(file,
+			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
+			&utime, &stime);
+	fclose(file);
+
+	if (fields != 2) {
+		fprintf(stderr, "Failed to read stat file\n");
+		return -1;
+	}
+
+	/* Calculate the total time spent in the process */
+	long total_time = utime + stime;
+	long ticks_per_second = sysconf(_SC_CLK_TCK);
+	float runtime_seconds = total_time * 1.0 / ticks_per_second;
+
+	return runtime_seconds;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct rt_stall *skel;
+
+	skel = rt_stall__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static bool sched_stress_test(bool is_ext)
+{
+	/*
+	 * We're expecting the EXT task to get around 5% of CPU time when
+	 * competing with the RT task (small 1% fluctuations are expected).
+	 *
+	 * However, the EXT task should get at least 4% of the CPU to prove
+	 * that the EXT deadline server is working correctly. A percentage
+	 * less than 4% indicates a bug where RT tasks can potentially
+	 * stall SCHED_EXT tasks, causing the test to fail.
+	 */
+	const float expected_min_ratio = 0.04; /* 4% */
+	const char *class_str = is_ext ? "EXT" : "FAIR";
+
+	float ext_runtime, rt_runtime, actual_ratio;
+	int ext_pid, rt_pid;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	/* Create and set up a EXT task */
+	ext_pid = fork();
+	if (ext_pid == 0) {
+		set_affinity(CORE_ID);
+		process_func();
+		exit(0);
+	} else if (ext_pid < 0) {
+		perror("fork task");
+		ksft_exit_fail();
+	}
+
+	/* Create an RT task */
+	rt_pid = fork();
+	if (rt_pid == 0) {
+		set_affinity(CORE_ID);
+		set_sched(SCHED_FIFO, 50);
+		process_func();
+		exit(0);
+	} else if (rt_pid < 0) {
+		perror("fork for RT task");
+		ksft_exit_fail();
+	}
+
+	/* Let the processes run for the specified time */
+	sleep(RUN_TIME);
+
+	/* Get runtime for the EXT task */
+	ext_runtime = get_process_runtime(ext_pid);
+	if (ext_runtime == -1)
+		ksft_exit_fail_msg("Error getting runtime for %s task (PID %d)\n",
+				   class_str, ext_pid);
+	ksft_print_msg("Runtime of %s task (PID %d) is %f seconds\n",
+		       class_str, ext_pid, ext_runtime);
+
+	/* Get runtime for the RT task */
+	rt_runtime = get_process_runtime(rt_pid);
+	if (rt_runtime == -1)
+		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
+	ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
+
+	/* Kill the processes */
+	kill(ext_pid, SIGKILL);
+	kill(rt_pid, SIGKILL);
+	waitpid(ext_pid, NULL, 0);
+	waitpid(rt_pid, NULL, 0);
+
+	/* Verify that the scx task got enough runtime */
+	actual_ratio = ext_runtime / (ext_runtime + rt_runtime);
+	ksft_print_msg("%s task got %.2f%% of total runtime\n",
+		       class_str, actual_ratio * 100);
+
+	if (actual_ratio >= expected_min_ratio) {
+		ksft_test_result_pass("PASS: %s task got more than %.2f%% of runtime\n",
+				      class_str, expected_min_ratio * 100);
+		return true;
+	}
+	ksft_test_result_fail("FAIL: %s task got less than %.2f%% of runtime\n",
+			      class_str, expected_min_ratio * 100);
+	return false;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+	struct bpf_link *link = NULL;
+	bool res;
+	int i;
+
+	/*
+	 * Test if the dl_server is working both with and without the
+	 * sched_ext scheduler attached.
+	 *
+	 * This ensures all the scenarios are covered:
+	 *   - fair_server stop -> ext_server start
+	 *   - ext_server stop -> fair_server stop
+	 */
+	for (i = 0; i < 4; i++) {
+		bool is_ext = i % 2;
+
+		if (is_ext) {
+			memset(&skel->data->uei, 0, sizeof(skel->data->uei));
+			link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
+			SCX_FAIL_IF(!link, "Failed to attach scheduler");
+		}
+		res = sched_stress_test(is_ext);
+		if (is_ext) {
+			SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+			bpf_link__destroy(link);
+		}
+
+		if (!res)
+			ksft_exit_fail();
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+
+	rt_stall__destroy(skel);
+}
+
+struct scx_test rt_stall = {
+	.name = "rt_stall",
+	.description = "Verify that RT tasks cannot stall SCHED_EXT tasks",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&rt_stall)
-- 
2.52.0

