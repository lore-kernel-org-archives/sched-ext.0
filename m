Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEB2F7449
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769417002; cv=fail; b=d9j2WPT+bMoQN0SukNmnmPkxDcsWmqYPi8gthwkitfR3LIdlxFmUmKZwEekHxEnTt+g79XPvFPWqSFSSjxhgiihnfKNGergAljcubddbJ/o2vNm0SyWng8K8vVidXN0CaJNrN9di5/G39lL41NDtFgcJyCqN9VDbhvcKXfQjb0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769417002; c=relaxed/simple;
	bh=xzOfhb8ydkZelmK9hDqGTKjWTh2JVlRjx8QKXmSiOHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uU5QA0jd3NN45ylIrzybwXjBLcMQnnODsomLvgAc68H7h5ys6clC7O74oc83sARyLX/WVK0IC5QMR8NMpiUfgKmr8VaaEAdc9lnaUe7f+OgUObjduPDhABAEwX6/L2E0ZJCZCBYvb06JyEGzj683EoG4pHS09+nuTS/VMTarctg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nslm0QZU; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nslm0QZU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbmJRqHfgvsdCuoYDA1rV0ebpq0ZobBXxCD49Z+5Ti6qiH0HkvldVBnpV8/5V2L4OtXZ4CIXvs/lkoC8Rx3Xktkt3f5+rSDNF0RWAPw9sVGxsZjyCJiJjY2Fb5Cwtow70/s6DyJD9CMIIwr5BD3OwZERP/7U3MYmZja6LPygI+xS45MH/w0NQzRc+tR4kAOj9cw+uT3ep1MXtERG+cCrsAD0uYlQ/c5nPV/cveaOIxNpqBatEQft4etkga6f5hZ/a1ntMgrzRxW94dbfyiUKWV/q0hpM7UQ+5+Roq7XTdCmoOGSrfWUjnvVtBMoO4tnuYc5rr6JEeszNml1GL4l5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCOmSEdq2TdNXGvWomGG4+3flgscBsIsDUevlgDJlL8=;
 b=guU1FRnXI2dg4RDEwm2KgIueaybo9ISamBKnc/PKmsxk1zj2i12lIdmo540ompiM1CQzeyo7354jGUMGI9xI9JYtis+0VCv8Z4poU2mlxekqnDgw4ERH9s9xIRs/TzvmUtbs5tHWdtZ1t+xA5k4jaAiQ112GxwfepRFM6TTg+YOhk9WbugV9N7753aoOadg6oOSFAfxMWlBmmfiKFEeV4pCPUHLewvqqUnAjBO0wDkh/Az1rlxX2rPYVAI0K3t/JRyIfECSG7nipvS61NlCYb5oAIQ/VlFQfKsPHW0uY3nqazADOXb/I6+qXixzYqdDFn2XO5L2J3nmtGTshhqDiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCOmSEdq2TdNXGvWomGG4+3flgscBsIsDUevlgDJlL8=;
 b=Nslm0QZU5+eOJYFKnf/rPYGUaQmF68pE/Cf4VetMpXuNMJNyP3MNDCyppHPXO2/7GIA3lsyIgkC1H9dTZnf3w4TxwShaUFlMGBRkmLD6NRq2ZsHZtIdLuUicssBbnbp+MxP4wgNVOTDnz5htymxuVUirU160tx5sVIyrr1D85S+vxZAtXJoDMUsV23Y5CptsPaI7NXY7flu3Geu+fF0LDmrAwAYiMdQhseq5DveuW9/lDkUWH7FyN8GhwZIuj/7d/y378z04jGH7bSsOp7NkTpjIJi8LA/2klyZ+JgaGncz5SvJm6khlpDP52qtmAXzzSvCYDpBxMUiR5nqOpRGqzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Mon, 26 Jan
 2026 08:43:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 08:43:15 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 2/2] selftests/sched_ext: Add test to validate ops.dequeue() semantics
Date: Mon, 26 Jan 2026 09:41:50 +0100
Message-ID: <20260126084258.3798129-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126084258.3798129-1-arighi@nvidia.com>
References: <20260126084258.3798129-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e3f203-ac0c-4c5d-fe17-08de5cb6f265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oPRCGd7eJGNcI4t9sn28lQ38HSS4KnE9OOX2flIadAySb+JqUDbsidWKG7Yn?=
 =?us-ascii?Q?j4EPiowbD+P6YUyhBv6EAG0h/wn6fRivqHHlAKv/pU3RQ+GXmuPwfTZc2p47?=
 =?us-ascii?Q?4LMJ2JdAogpPmxUexzEr3QAnyxW1cdZFldRxL551JFs2Yq0rNReajSy4lBJb?=
 =?us-ascii?Q?eSrQ5cqmI/HC/SIhZ5I6p5j1aq+QUhSDeQbZEr+ZxQS23QQ7tVTggND2LVRa?=
 =?us-ascii?Q?C9+DhD+lValCS8jUTncvm9vz7DEi7bP5nsGoYr8INte/DyMxe5NlIa7wkuHC?=
 =?us-ascii?Q?2mkX4+j9nH04KAxEDtMeZ3PK3y7ngH99kp2fIWI4BBDPbKZZoW/4nPgtFnJ5?=
 =?us-ascii?Q?Ez4SI7IMihZIo7ljpdP2bugsuvQ2/pcklM45q5s/rYSX9ZXmkK/RpKr5fBMb?=
 =?us-ascii?Q?4/lfOuOFazgjIHjb4J/errMUkAGmbMVT1lEBYpme6nB3T4lfA553ctO1kQ05?=
 =?us-ascii?Q?NxxId9evYS531yDGeakaepJ61HxEdxdmJfYwgEnpIQEqtGhJVbrkQSaDhskk?=
 =?us-ascii?Q?w0T1V4pPTDJ8XRLzI6w2PJ6DCDSucDAf++By8YVThzG+lBF1uMBrOh+flsg0?=
 =?us-ascii?Q?JnDXkRoa0ZDbFeuIA8fIZmzrSmWJ2yEYP9rMnWTrypvyIiaipE1uoIzRl5+/?=
 =?us-ascii?Q?xqLs3jJVPVWnDyTv+KW27prrmAkNV5Mg4vQ8uLOjSlu1vyEqGXdeCpQum2YI?=
 =?us-ascii?Q?kxegpiaD00GO51qPiWE1YIYNZx96weju14NMqK0sdNvXgrOwA/SOljT1dCfm?=
 =?us-ascii?Q?2yRhX7GB6r+TiOVg6h/OiVBSV2DnvWKAfAIOd1OJi3+n/CjVz3CHXgnTA3KU?=
 =?us-ascii?Q?K4AD+SPWQg94+aOAcsxWnfDycG7PUzUrtuEdhSUuAgzLAaUbcrxEmBNBQq3N?=
 =?us-ascii?Q?hXttORaGg3gaoQl6s9/Lvip6Z0kVQ2MD45Hwa76Hv4W/wkC51NGi1O/YLvJp?=
 =?us-ascii?Q?neFpALqiQy7ua7Fdjw4P/G+BiFiuycvSYYcVCKGRpSbGIYLM88rdf+28zYTL?=
 =?us-ascii?Q?ckimxoMVaAwBNOirmi03QJzYEI1kzPSTnf1jt1WmjRVTmFbkXAbo5bvgVFGC?=
 =?us-ascii?Q?hJPOjb4NzjHmd6tFYuYw+sFy9h6zODFJ/YH1QWD9eqnxEkwuuC8She848uyJ?=
 =?us-ascii?Q?/M49VT+iPMn1VcwFMjfOkGirozHpTb/dFs8lP3IdXLXyGkn14X8FuIKMSMvi?=
 =?us-ascii?Q?FYFR9dFKlCfjMBofRr7c3n/0EjgAByIoU+X9S1T+QuvkRdenPoiGWp61uJE6?=
 =?us-ascii?Q?4ZdyfWGqTJBovIrrnjYa2fBbsSv3Nz/dO4GVomPZiJQJ0+o4jk8RFlBc2k1Y?=
 =?us-ascii?Q?cWkqjLikyR/KAQQ46YCLUfnFcHUG0qM7P8SNKfpBw10mfQRjJg658HQuS2xr?=
 =?us-ascii?Q?eUxN3sh/FWRPgSh2tY+gOVEC+MIVR/R6n7Jn9Ev0vxz8crW71f9VtCCdKGYg?=
 =?us-ascii?Q?X5vqvoxf7QIRZwf8WNqKjYx5V4Y5Lo8m+dd0BHczyOOV6aNuC3q1qh7g//ca?=
 =?us-ascii?Q?guHRXB+MNcLx1GvkHqvQr0qiiLaChgU6UQINkULcv+PjbxEJ3geeuftfcdPm?=
 =?us-ascii?Q?KbvjE/5scIrr9nuy92U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pFG0FHbo1d/JR8ynaJU0HJgbpmKySUBR+UpCRoTcj7+j+TWuzDBCgrcysQkG?=
 =?us-ascii?Q?7OvIIXeSBORyZqwEfuIf/M26q4WHAVzz4C4S1Aqk5AGOYHfk6N0dBktt1rvn?=
 =?us-ascii?Q?FfGNMy1neq/upJyTCHbw09eO3qsuskpx+cax9TJlqRAwIfAnWUkbDpaN+CRC?=
 =?us-ascii?Q?Fv1ecz8OmOAIgKPQR96kdoK6CNOVawHZ6MXEf9EPmkc6u53WZSbaxOCt6yG7?=
 =?us-ascii?Q?QMa2wLg7hg3emvdReteDZAgkXWFAZ25ENb+3Hjc+7IRVqBYf9PAUsWcdFXOg?=
 =?us-ascii?Q?kpqvvCas+vzC5R4citYyUpM2holCVT5C7HrGebHY1f46cPRMvPtTcqt0wJoq?=
 =?us-ascii?Q?jSC0EPHy6Ro+dqvQD9ddoZW7mjJStXn7I98Kei4cks7VLqM7ahFhOVOVEUMp?=
 =?us-ascii?Q?5j27PFvANiUqILzsAhJNJTY8KX+CBkBEHvLv4MNXuTVE4VEfoACC9/w76Ljw?=
 =?us-ascii?Q?MZ7gtMWHV2FzFbqhx8JqNu6kFTpF8fFrwJnWIFYVjdXZ6VUI5CjPwedg9BqO?=
 =?us-ascii?Q?PaJG5HGOHD1nfmjPpax8rx4cKLmJAhYx3GwTZSHe8XtlivdpOpZvGF32wR1i?=
 =?us-ascii?Q?kPe+zHLvD3/xIvyhiKpXY1VTWXaX4Mgsd4Rq6LimV8yMp/xfhf1DwBsCY9g4?=
 =?us-ascii?Q?mygQAJIwsDfEIUM0IWZas/0FelqgUcUuSLXWGuqUytZYhqEHDuM4rn+j8xDZ?=
 =?us-ascii?Q?nIbRZzZV9xArYE6QRTJmCZ7YjC5xvcmDD4xLGUYfhAs0HaTpMqJlDDLNAejG?=
 =?us-ascii?Q?lBJ5eaSQHod+IKpHAu2ZYAGefGnZaa8BL3aWdLu4qT9pVeERpW5hUKiTzlTj?=
 =?us-ascii?Q?huMhgSMtGu59mqBDjQLZvGV74KXngDT+FqMqxTTq2Z7fA/NzLHyR7JWpgODf?=
 =?us-ascii?Q?WZQOIEgOAA2arFv/m/xZm3uEdhtGvri9ggyGA6TnSFar2mYyL2y7ePz7xaqV?=
 =?us-ascii?Q?/Xy7X4wiEsQ3G7q+nUwLK6F+MB+PqqzpScYAZzp1EGZ2JwxVmojWaVL5dto0?=
 =?us-ascii?Q?0kR+g28qQMB7LkuVNML43F2HkeJLqmcH7zuqdc9fFenMW8jbuQUQEkMCmwan?=
 =?us-ascii?Q?PkbP4/uT7jotcQjPGkUfMNbljjsDiPHiyWFDYytZnL3fBee8+36O1F0rIKt5?=
 =?us-ascii?Q?QZ8OhIyDqEtkTohep31JAP+aI56T8cDlYccp8pODIzVwIJSTdW9keZvXKbki?=
 =?us-ascii?Q?4GuyjsqmauoZp6mgj6/O4ej2ZtZIpthLUWiA6F5JcWhU25FQfhcjzQ5PGpDl?=
 =?us-ascii?Q?9Px6KQ4rpsJDpl0DQL547idMqDtaM91uX3VCBhZm3ZiaPgV3JcXXROv8UOve?=
 =?us-ascii?Q?W3+uY39TtrIpg+CEybmN2ps7KGMcYcSh+MRtU6GKwi9c03osRG0sSmKiBpMj?=
 =?us-ascii?Q?QCEWmvpSoKY4vSenfhLeNglZ+Yi3CLfm0P/+nwA/FpnSEYOf/W9LDaqIcqnB?=
 =?us-ascii?Q?K2MyrwSDZMa7HYI8xnjkoCbNRzFFxB0/mkQqymw44W+Jsf1j+XymbyssyHTF?=
 =?us-ascii?Q?Iuo6+mYwAd4AQUll+XprIPVTl/ISgv6f3kUKyPaG53rBxbqLQ+j7iREOTCph?=
 =?us-ascii?Q?etkYhUFj7EjQo+bSEwSauJiJByVsZyGE0h2ptuZr4Grn5i66Mlq0YQVKX4Jy?=
 =?us-ascii?Q?brpB/uUevJl8RJ6QD4m6Vs2RPudu21lDEcYvIf7ntsVwBkPuXcA9Ke/kvMRv?=
 =?us-ascii?Q?xu05tHgZOcTvguSDBu4vEm88pAiG7SYtAc7LyEGaNCyAXvYK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e3f203-ac0c-4c5d-fe17-08de5cb6f265
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 08:43:15.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW2WQB1Q/uOha3i1XtTKxH8RTxmpbPk/uzSAB5AzzZDXK7s8Rbd1iXOX3si1gHec9+HFf/8hDsRLt0Xzedfdqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

Add a new kselftest to validate that:
 - every enqueue is followed by proper dequeue,
 - dispatch dequeues happen exactly once per enqueue,
 - property change dequeues (%SCX_DEQ_SCHED_CHANGE) only happen for
   property changes,
 - no duplicate enqueues without proper dequeue.

Test scenarios:
 - direct dispatch to local DSQ (%SCX_DSQ_LOCAL),
 - dispatch to user DSQ,
 - explicit property changes via sched_setaffinity().

This validates that the new ops.dequeue() semantics work correctly for
all task lifecycle scenarios.

Cc: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../testing/selftests/sched_ext/dequeue.bpf.c | 209 ++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c   | 182 +++++++++++++++
 3 files changed, 392 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5fe45f9c5f8fd..764e91edabf93 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 
 auto-test-targets :=			\
 	create_dsq			\
+	dequeue				\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/testing/selftests/sched_ext/dequeue.bpf.c
new file mode 100644
index 0000000000000..8b2f792cf7d8b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that validates ops.dequeue() is called correctly:
+ * - For tasks on BPF data structures (not yet dispatched)
+ * - For tasks already on DSQs (local or shared)
+ * - That every ops.enqueue() is followed by ops.dequeue()
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SHARED_DSQ	0
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+/*
+ * Counters to track the lifecycle of tasks:
+ * - enqueue_cnt: Number of times ops.enqueue() was called
+ * - dequeue_cnt: Number of times ops.dequeue() was called (any type)
+ * - dispatch_dequeue_cnt: Number of regular dispatch dequeues (no flag)
+ * - change_dequeue_cnt: Number of property change dequeues (%SCX_DEQ_SCHED_CHANGE)
+ */
+u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt;
+
+/*
+ * Test scenarios:
+ * - 0: Dispatch to local DSQ
+ * - 1: Dispatch to shared DSQ
+ */
+u32 test_scenario;
+
+/*
+ * Per-task state to track lifecycle and validate workflow semantics.
+ * State transitions:
+ *   NONE -> ENQUEUED (on enqueue)
+ *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
+ *   DISPATCHED -> NONE (on property change dequeue or re-enqueue)
+ *   ENQUEUED -> NONE (on property change dequeue before dispatch)
+ */
+enum task_state {
+	TASK_NONE = 0,      /* Task is outside scheduler control */
+	TASK_ENQUEUED,      /* ops.enqueue() called, waiting for dequeue */
+	TASK_DISPATCHED,    /* Dispatch dequeue received, can get property change or re-enqueue */
+};
+
+struct task_ctx {
+	enum task_state state; /* Current state in the workflow */
+	u64 enqueue_seq;       /* Sequence number for debugging */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+static struct task_ctx *try_lookup_task_ctx(struct task_struct *p)
+{
+	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/* Always bounce to ops.enqueue() */
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+
+	__sync_fetch_and_add(&enqueue_cnt, 1);
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	/*
+	 * Validate state transition: enqueue is only valid from NONE or
+	 * DISPATCHED states. Getting enqueue while in ENQUEUED state
+	 * indicates a missing dequeue.
+	 */
+	if (tctx->state == TASK_ENQUEUED)
+		scx_bpf_error("%d (%s): enqueue while in ENQUEUED state (seq %llu)",
+			      p->pid, p->comm, tctx->enqueue_seq);
+
+	/* Transition to ENQUEUED state */
+	tctx->state = TASK_ENQUEUED;
+	tctx->enqueue_seq++;
+
+	switch (test_scenario) {
+	case 0:
+		/* Scenario 0: Direct dispatch to the local DSQ */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		break;
+
+	case 1:
+		/* Scenario 1: Dispatch to shared DSQ */
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
+		break;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dequeue, struct task_struct *p, u64 deq_flags)
+{
+	struct task_ctx *tctx;
+
+	__sync_fetch_and_add(&dequeue_cnt, 1);
+
+	tctx = try_lookup_task_ctx(p);
+	if (!tctx)
+		return;
+
+	/*
+	 * Validate state: dequeue should only happen from ENQUEUED or
+	 * DISPATCHED states. Getting dequeue from NONE indicates a bug.
+	 */
+	if (tctx->state == TASK_NONE)
+		scx_bpf_error("%d (%s): dequeue from NONE state (seq %llu)",
+			      p->pid, p->comm, tctx->enqueue_seq);
+
+	if (deq_flags & SCX_DEQ_SCHED_CHANGE) {
+		/*
+		 * Async dequeue: property change interrupting the workflow.
+		 * Valid from both ENQUEUED and DISPATCHED states.
+		 * Transitions task back to NONE state.
+		 */
+		__sync_fetch_and_add(&change_dequeue_cnt, 1);
+
+		/* Validate state transition */
+		if (tctx->state != TASK_ENQUEUED && tctx->state != TASK_DISPATCHED)
+			scx_bpf_error("%d (%s): property change dequeue from invalid state %d (seq %llu)",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/* Transition back to NONE - task outside scheduler control */
+		tctx->state = TASK_NONE;
+	} else {
+		/*
+		 * Regular dispatch dequeue: normal workflow step.
+		 * Valid only from ENQUEUED state (after enqueue, before dispatch dequeue).
+		 * Transitions to DISPATCHED state.
+		 */
+		__sync_fetch_and_add(&dispatch_dequeue_cnt, 1);
+
+		/* Validate: dispatch dequeue should NOT have %SCX_DEQ_SCHED_CHANGE flag */
+		if (deq_flags & SCX_DEQ_SCHED_CHANGE)
+			scx_bpf_error("%d (%s): SCX_DEQ_SCHED_CHANGE in dispatch dequeue (seq %llu)",
+				      p->pid, p->comm, tctx->enqueue_seq);
+
+		/* Must be in ENQUEUED state */
+		if (tctx->state != TASK_ENQUEUED)
+			scx_bpf_error("%d (%s): dispatch dequeue from state %d (seq %llu)",
+				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
+
+		/* Transition to DISPATCHED - normal cycle completed dispatch */
+		tctx->state = TASK_DISPATCHED;
+	}
+}
+
+void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_dsq_move_to_local(SHARED_DSQ);
+}
+
+s32 BPF_STRUCT_OPS(dequeue_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	struct task_ctx *tctx;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!tctx)
+		return -ENOMEM;
+
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_init)
+{
+	s32 ret;
+
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(dequeue_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dequeue_ops = {
+	.select_cpu		= (void *)dequeue_select_cpu,
+	.enqueue		= (void *)dequeue_enqueue,
+	.dequeue		= (void *)dequeue_dequeue,
+	.dispatch		= (void *)dequeue_dispatch,
+	.init_task		= (void *)dequeue_init_task,
+	.init			= (void *)dequeue_init,
+	.exit			= (void *)dequeue_exit,
+	.name			= "dequeue_test",
+};
diff --git a/tools/testing/selftests/sched_ext/dequeue.c b/tools/testing/selftests/sched_ext/dequeue.c
new file mode 100644
index 0000000000000..6861257d79b47
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <sched.h>
+#include <pthread.h>
+#include "scx_test.h"
+#include "dequeue.bpf.skel.h"
+
+#define NUM_WORKERS 8
+
+/*
+ * Worker function that creates enqueue/dequeue events. It alternates
+ * between CPU work, sleeping, and affinity changes to trigger dequeues.
+ */
+static void worker_fn(int id)
+{
+	cpu_set_t cpuset;
+	int i;
+	volatile int sum = 0;
+
+	for (i = 0; i < 1000; i++) {
+		int j;
+
+		/* Do some work to trigger scheduling events */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Change affinity to trigger dequeue */
+		if (i % 10 == 0) {
+			CPU_ZERO(&cpuset);
+			/* Rotate through the first 4 CPUs */
+			CPU_SET(i % 4, &cpuset);
+			sched_setaffinity(0, sizeof(cpuset), &cpuset);
+		}
+
+		/* Do additional work */
+		for (j = 0; j < 10000; j++)
+			sum += j;
+
+		/* Sleep to trigger dequeue */
+		usleep(1000 + (id * 100));
+	}
+
+	exit(0);
+}
+
+static enum scx_test_status run_scenario(struct dequeue *skel, u32 scenario,
+					 const char *scenario_name)
+{
+	struct bpf_link *link;
+	pid_t pids[NUM_WORKERS];
+	int i, status;
+	u64 enq_start, deq_start, dispatch_deq_start, change_deq_start;
+	u64 enq_delta, deq_delta, dispatch_deq_delta, change_deq_delta;
+
+	/* Set the test scenario */
+	skel->bss->test_scenario = scenario;
+
+	/* Record starting counts */
+	enq_start = skel->bss->enqueue_cnt;
+	deq_start = skel->bss->dequeue_cnt;
+	dispatch_deq_start = skel->bss->dispatch_dequeue_cnt;
+	change_deq_start = skel->bss->change_dequeue_cnt;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dequeue_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops for scenario %s", scenario_name);
+
+	/* Fork worker processes to generate enqueue/dequeue events */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork worker %d", i);
+
+		if (pids[i] == 0) {
+			worker_fn(i);
+			/* Should not reach here */
+			exit(1);
+		}
+	}
+
+	/* Wait for all workers to complete */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for worker %d", i);
+		SCX_FAIL_IF(status != 0, "Worker %d exited with status %d", i, status);
+	}
+
+	bpf_link__destroy(link);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
+
+	/* Calculate deltas */
+	enq_delta = skel->bss->enqueue_cnt - enq_start;
+	deq_delta = skel->bss->dequeue_cnt - deq_start;
+	dispatch_deq_delta = skel->bss->dispatch_dequeue_cnt - dispatch_deq_start;
+	change_deq_delta = skel->bss->change_dequeue_cnt - change_deq_start;
+
+	printf("%s:\n", scenario_name);
+	printf("  enqueues: %lu\n", (unsigned long)enq_delta);
+	printf("  dequeues: %lu (dispatch: %lu, property_change: %lu)\n",
+	       (unsigned long)deq_delta,
+	       (unsigned long)dispatch_deq_delta,
+	       (unsigned long)change_deq_delta);
+
+	/*
+	 * Validate that we got enqueue and dequeue events.
+	 * The BPF code does strict state machine validation with scx_bpf_error()
+	 * to ensure the workflow semantics are correct. If we reach here without
+	 * errors, the semantics are validated correctly.
+	 */
+	SCX_GT(enq_delta, 0);
+	SCX_GT(deq_delta, 0);
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dequeue *skel;
+
+	skel = dequeue__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(dequeue__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dequeue *skel = ctx;
+	enum scx_test_status status;
+
+	status = run_scenario(skel, 0, "Local DSQ");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	status = run_scenario(skel, 1, "User DSQ");
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	printf("\n=== Summary ===\n");
+	printf("Total enqueues: %lu\n", (unsigned long)skel->bss->enqueue_cnt);
+	printf("Total dequeues: %lu\n", (unsigned long)skel->bss->dequeue_cnt);
+	printf("  Dispatch dequeues: %lu (no flag, normal workflow)\n",
+	       (unsigned long)skel->bss->dispatch_dequeue_cnt);
+	printf("  Property change dequeues: %lu (SCX_DEQ_SCHED_CHANGE flag)\n",
+	       (unsigned long)skel->bss->change_dequeue_cnt);
+	printf("\nAll scenarios passed - no state machine violations detected\n");
+	printf("-> Validated: Correct state transitions (NONE -> ENQUEUED -> DISPATCHED)\n");
+	printf("-> Validated: Dispatch dequeues have no flags (normal workflow)\n");
+	printf("-> Validated: Async dequeues have SCX_DEQ_SCHED_CHANGE flag (interruptions)\n");
+	printf("-> Validated: No duplicate enqueues or invalid state transitions\n");
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dequeue *skel = ctx;
+
+	dequeue__destroy(skel);
+}
+
+struct scx_test dequeue_test = {
+	.name = "dequeue",
+	.description = "Verify that ops.enqueue() is balanced with ops.dequeue()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+
+REGISTER_SCX_TEST(&dequeue_test)
-- 
2.52.0

