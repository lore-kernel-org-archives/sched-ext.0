Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8F52F14D
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183893; cv=fail; b=EHpQHDLh3B0zu2jYzMlHFfjxd6hegQ2G0lVIJfTuTV9D1rTDgopAyxkNp3CmsbRoc/SJQ/4sPk44cnETYE4V7Pgt973eJVuiqQVnWq8CzhSMyBxlYPHnhnbnV4vSloiz3SMucj6jaOXeiYEuRhnighXfQ0i69WuVLO2CG+PFf1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183893; c=relaxed/simple;
	bh=R4gPrHQELsc/jjL8ymAZds9awgQStaou/vIz14gCNP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxYp+CpOuB1FHi7OKV777of0Ovy5P1DaaT+iSvEZcnIDkpNeuJ4oeSyDah9d2SHaPqlbRti9+1fY877qIDhvjYU2Kr+9AAfkWLHu2QMADnIvwR1Jhv5czbBiYXvqeY2jFAQWe9lS0MvKzRT1tzMQPqYR5xRp7gqoS3M+szg5Iow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JW7dlIlE; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JW7dlIlE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czWysQYwsHJdWy862VFc4maLayTAicNcLuvaswJK4CLPWpio0CMWu7PF6CHjZ6fKDbLbEHvCtXB5vqLKsmb20ntugvwYiI+rnw9JYK2QR1tVQ7XMqC/0DDEG7Ppeg8DEIZKocfPMYta8dDZ3Tcuu2xKO1xI3lX2pCA9DzLUhZje00bPaLVMbTA1UZ0TVo+SeQl2EN6qjpk+oqkRtlB4TOtBQgoiXxPLk/u4AH1/WygJiNMyG1Vv7vEF5cbL0znGqGpxrDesydbOW2gUy6U4A+CBYkQGrM/5F6IswTHySqzYSKqLq1a8N5OsF+sMpV0GpopvG8rmYglNIdJ7PUmOcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Tmy+aPkpHWfLYJMQHTcVXKhGBd857/yV+bzISVUOxo=;
 b=UzAD63r4iY9wfwsvAIfRRlkUe82iUJqixzZxVhIlZc2Jd8FPy7kdFAPO14ext52DQgxn84NF64332u8/hqMeUaayOTfHhQo5WR8BGpaeE8AvnJAUyd0RjXMFdDfqQ2oXuqFZaIVwJpBmvlMskRIpRlXO1Acptb0N7SQbXWn80KtWlNwJW94p6Me6FUAEjW9ElmnPf/L0mhW6p5np7MOa7igwrC6/Q7LrWnpwhHYOjN/1f8Wun9cEhuVWegFBLOqypG/H7ULf8NzSg2qqiVOw70F51Cmu8FLHhUD65E9j64TSCl4QZBCYWrg1JbBxscW6zuuJ9rsPSUJD4jHxLAbC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Tmy+aPkpHWfLYJMQHTcVXKhGBd857/yV+bzISVUOxo=;
 b=JW7dlIlEY9J2F3M3k7hPyqw2lOA6NXQ+ioiFQbxKn4jDURFl1h7QBfZXzd689Y8x7v6JHzJSzwiYlU32kA1xjeZT2b3PufCsNJbERPvBLe/GMy/y85grdOoYRL2vV+WLknJ/JLCTixUCdc4/wMWfS3oAWVtc5sNqU8wIQaNRGdQk/ybJnEWLJqbIIpitWzdTJJbhIMSVHP5mNyuaLy4QCzmgnNKh/hxIevErW34lKCkhF/BbxWxALjVygxVRs1EKQJFnmZtY3oEZ4argle+LNp8ZSf/+vM2yj1+W2bFCfWouZLdf6Yxisq8mytA38ZzEQt5rCAyLrYYpJkxydHT1uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:44:47 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:44:47 +0000
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
	Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/18] sched: Introduce WF_ON_RQ wake flag
Date: Mon, 31 Aug 2026 15:42:18 +0200
Message-ID: <20260831134338.1531664-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::25) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb7bc9d-cd3c-4970-0038-08df0766056c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mRzc3Q/2zFFIUqFE4WOEcFEGNM8+GUa6vb5EywKKb2DQiTjenGIwPZRr/GMAZ2mNwwABh8FCJAncK8IUDMakOA9NpVw26QLM99D2zaV6eSPe7ScjlK/+Fe4LiDW6uliz6DjNFn+v2AWrYULUTH1Cy5aVZ43A2r8OBttfp6R9YjJBgblkfbHxIkpJ43i6dBunx1zO1gfjmlM2eQqCiSxnSYiAqJPl2r9Z6MP8SNJQVf9MeRfVdlHYSKTqDeLTLksvPF/8DCH0IA9LKpoC8fMI6ujaA1X2dz128bIO3lLHZndsiavwlOl63ilZ6FNBBCdbn4lqV7sl335A+JLC5gscDwneO/p/9S42KTKyZfWUGAk/UjBvWCm29rAj89cIo484KKvGdOJTRqW3nMNo1j2w7Ujo+1w4SM6h+Ub063NMfH/tKou2//+VLLL3EvjP0pkc1ZV8rgzVzimWi6GNqCnsTvvw2QeqjOM6IXl1VYKmz2Nnfs/LpEZsw+wWqjVPvwLKSOGOpsPE70MDYi1KDBUQV2cWGFYeGELmchW9G0xFadNBBUb8NLwTR1CkgwzUQm16eZny3uzrLZ0wekDK4neWk8Ej2/UVJq+OXejwC2dvPi2Twhx720CO7JaFzSNEJy4H748kd97dmOVfLDJNwQpEYCAFPRZ1YU4RH6UNIJptdZg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A1l84vrO/9o6XaUO5h8c1UAsDaY8nWVJEfiUXFPYmKuGsKlWFiDI5euOdveb?=
 =?us-ascii?Q?TE9OxQG54NpJqTOlnAfy0hkmzvOIVI3W26T99CwSqDEddYf0oRxhrcYsdoAk?=
 =?us-ascii?Q?nK/U1/N+/Ae5/xZcx0o2d7zH5al5O/Uocw16w3F1viqohvzaRTWLnZwdJisi?=
 =?us-ascii?Q?Ak6P0tbsoeiPXC20M4uPUs2ZJzwE7qV6BVigcy4sckTxJqkhT8KV8Ov9he30?=
 =?us-ascii?Q?0sh7F1vAXXJJThqvIWnzkCWYgEWgdGYuVz1423WCwmuPoHvuhjN3gFM3w/D8?=
 =?us-ascii?Q?Db6jBRHJW/QmsI+A0viWbxzV8uf5rkO2ZFID9P78G54DIc7WuCFJkwRRO3/Z?=
 =?us-ascii?Q?iDQMYAZvWV8qHJYvPjVMeQj/v/Z6ySygmcQpjBuM9VkQfqZB6H34//Krdi8w?=
 =?us-ascii?Q?Yd8q4Cp6VYV9jJqkV+F+oHxkMR1a9asKVmEMfXpyLZ68Tczomw+6bOyvIdkx?=
 =?us-ascii?Q?w8lmhQpPEgum6uzjt+Pyzybv+SPhKk+uLJR/yczO8xF4ufvQt+9mk689q9a5?=
 =?us-ascii?Q?U5/AVuGlYcnG5DeW8j8Tl7lSq1SjX4gMuc2LOfHn7QIPF3hUiHE3E02aOpzV?=
 =?us-ascii?Q?QpxVYl6dp7Myu9+OkTNv3phIxNCv7LyuzsF6dH5Q+M6AGLm55PGsI7rhELVC?=
 =?us-ascii?Q?zWEzgFFOWvSPnegQsyxyRDUJGXgZbEjC5D/HR4DN2U7OWZ3gNVKHUH/lBRXz?=
 =?us-ascii?Q?GEKL3JA65c0j8XjpvkJ+WNVLgd89u2kasbCBOS16qTNf4NvAy2GWiLGYYgnQ?=
 =?us-ascii?Q?eZHqHFh1Yk3brXUsmeSIVgrUsqr+BKA+0/95MZP66/rTqhxtoqVB3lP8hxMu?=
 =?us-ascii?Q?0MmlQS6FxHe+2hXUBWe+kMYSh8rEJBJasxPmq1IXIMRrYK5f/ir7PzrKcoeL?=
 =?us-ascii?Q?eVTgzE+6Cp+ZMjefT/AHred/x+Ucd5IO1ojNQfyHsOUm6EPSJevSUnsf3GmX?=
 =?us-ascii?Q?Pp7gPTCScHzS3We0QNUyrnrcaYRTZ9Z/5ccGmOVGrSyrruhR1BsV9Y0FFwpf?=
 =?us-ascii?Q?7pALDQj+lwnoozNSIg8pHrvZ+TwXl5JthiNCTBTQpSRuTOrfbqHY8XSt2gK+?=
 =?us-ascii?Q?tQjNfKhjp1cRvS/Q2wQ76G2/DbDKkg8SRsyhnhQInc0Ntiz6hsknP73iYgky?=
 =?us-ascii?Q?1/scpu2ruBjmBUOvuxIWBMmma4OYE9Fgh8chub2B1JHP7M1Xs8ywnh+GAsV5?=
 =?us-ascii?Q?36cSqKIZAjzECNjWOtRnT/NC9tJ7jQU1X1CPY96E+O90LJAJW7vE2NCZsPlt?=
 =?us-ascii?Q?R5wok2wFb7X6sOmWs9W5OiWs4qZOjlNtCWvRpohVlJGjVK7N9XY9Bw42KsSW?=
 =?us-ascii?Q?uqWWMA0LZ1Y9r2+RCEda1vsX7/p7ky5LrRTpDXnX4KnE5bmP5XiuA5Cn7x8e?=
 =?us-ascii?Q?Q/pzkM0sYw1ymG/Bi6DeDNEnG3tQgr0/MH/Qq3vNHWcmrv3/GvZI23iLGa+P?=
 =?us-ascii?Q?UutPpm/M3Kl4suudyuIBP5CxS8b3+MyXBLxuP6j6DYDfW3jJ740/MqH/9PJz?=
 =?us-ascii?Q?SepHLuuBQCykzUgl07iHS6qs7fxAN96PCAO+8OeEVqNUAFdPmLZ4siKijNYR?=
 =?us-ascii?Q?i2bGR5ra+wVIpa15SLTthMV39YgVH58W5dELDjdyb3FMR+JqlM3Hai9WsVa2?=
 =?us-ascii?Q?+geWOuGSCQa/IcZOkLWbb39rwH9CB4MFtXBfrxNha8mPgZh9LqWIdmv1mn/v?=
 =?us-ascii?Q?yboECId9N5pSufCZRimjB2M5QppHRvop0BtNOZbG9ALY86CaLJFevW3vvkIJ?=
 =?us-ascii?Q?jqIJDZL7XQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb7bc9d-cd3c-4970-0038-08df0766056c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:44:47.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNP6UYRo78iaXjqZtyqcfnnrNOVDfHZcCgac8qXT/fFJyxYcab9Js5SAWlfrDgHmyZeX7eNMho4jle+qgYGjkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

ttwu_runnable() handles wakeups for tasks which are already on the
runqueue, but scheduling classes cannot distinguish that path from a
full wakeup activation in wakeup_preempt().

Pass WF_ON_RQ to wakeup_preempt() from ttwu_runnable() so scheduling
classes can handle already-runnable wakeups separately.

This is a preparatory change to support proxy execution with sched_ext.
No functional change.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/sched.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d578dd635f2eb..f142ab455b797 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3908,7 +3908,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 		 * When on_rq && !on_cpu the task is preempted, see if
 		 * it should preempt the task that is current now.
 		 */
-		wakeup_preempt(rq, p, wake_flags);
+		wakeup_preempt(rq, p, wake_flags | WF_ON_RQ);
 	}
 	ttwu_do_wakeup(p);
 	return 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 56ac104f1f825..f30d122909e7b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2538,6 +2538,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 #define WF_MIGRATED		0x20 /* Internal use, task got migrated */
 #define WF_CURRENT_CPU		0x40 /* Prefer to move the wakee to the current CPU. */
 #define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
+#define WF_ON_RQ		0x100 /* Wakeup of an already runnable task */
 
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
 static_assert(WF_FORK == SD_BALANCE_FORK);
-- 
2.55.0

