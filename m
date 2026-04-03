Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB930B514
	for <sched-ext@lists.linux.dev>; Fri,  3 Apr 2026 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199454; cv=fail; b=O5L8+ShLHVkLbe7jdogj7BpdIk8Fc6g3fpdXUUu7/y8dUDodFfnhsyc/As9fIPdQmPxC5Q0arm0OXfQ0NzyqKHRIInGkTPyFK4uso7RB1bYxEEvxPACKGq/YiCsVb87TYG+GOgWxlnHqgx9gUw00V5PTSF/K7J9XtFL7nWtJC8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199454; c=relaxed/simple;
	bh=uX79/kQ4ofEOFPEOHQglaj4NyXZBIpcSdijznc0j1ik=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hHRiA9CIvLk8wTq1DlUp+2sIw2/4U7PreVmF6o5A3Ag6m+sSYPy2rX9sQQPvpcB3PbpFKA23B9wHrEv/5IZP/6gedtjIfjpRaGYsPsm2AR7AstDsEPLqSPz1LPtjvtTtpHxFsrB4y/YH9+ZkvO41ULaWmlaE7VPo/WFdHvDEm1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O5Bhmc0s; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O5Bhmc0s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4oeZcrqy5DPQrwCt35UwMJJ7nXy03eYHq68Og4oR4N6GWKgtD+jAZBk0sOUE5PWPzXARQJS6Bu+3txyYFOKE4vr7DsmXDnleVeVG6QzrRl7KID/+W2Ho2aIniWfkSy4sYTvqOxBW/R5VzwXZiSNxYkOj+lTlo1JPQW4zvtHBhII9cOjWCyYzcssoe9eOD/kQ+UcpSNmWeY8T6Uku/ErR9itSeo9kBtCN+Njg+3J7LQGnw9YRPOiwAATqN76ersB0GMgYg3X2xsAJI+6v+1TPjuu8TNyxCnthn2TZH7y7A/IeUWesDEzTKT0O9pKVTF21pVWM0s7a+babyqI3NjfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bt0LgUeGT7bh5DEpkYR/e4CxpEx44s/arBN1JGygpiU=;
 b=F1PV2Sewl9oXzU81tqq9JUEzZHT927VoYvgSzV/UT+Orq6VjGS/g+UsFB3nVA74lX783YYnMGXC8MeAdTwlzH9MV5GCyW4L4jUkYIMmOK1RTkLwdEo6jYGZmNLileRxP2JGfIaIijj5WkMS9Gvjlrr+VrWuavrx4R/WfjVNZVQceZCOLOniFwW7kDYMd5L4uY4da5bP6Cr3rIeZr3GyWwUUb+y1KwD/qg/InUQ8Z5Gu5++4r+f3Kxh66HhmqtAM7S0VZvu5eEUMo5DOnD4rDu68g/L/Ip0ACBGi5OOVMIjg3ZDaSf8LeNsKUKWZHm9oCAF6s7fER9I9IGyPj+avNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt0LgUeGT7bh5DEpkYR/e4CxpEx44s/arBN1JGygpiU=;
 b=O5Bhmc0sxwI9uY4M8isTes65vIAq1C86i5R1jwoel4+yYrq+4qVktJcfMM7XeyW7q8KvztS048XjF8/xEVZF4OuuzoVvRkeu9JR7NjI4afJ6jfjSdnAdBQC4tBuszZraqPd6iCJhdXGQaGexFXcgxu+m6xI7BBybpkRFyijZgTVxgrUbggxYxdWD5/qwVknrD2Kxjjk5iVmSe5p6DGzPjJVJ+MouzJD4FwbGSa7yIbnwxUozI1MW5kTRR5WivXVa9a9v1/vJhoRxIKG0lqbnXvlyqOj1SOQaAUf/23Uz+TutkMGugXGv4FPG/fcOHrwl7S8MlC/4bafIoAHruw+44Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 06:57:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 06:57:28 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Daniel Hodges <hodgesd@meta.com>,
	Patrick Somaru <patsomaru@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] sched_ext: Fix stale direct dispatch state in ddsp_dsq_id
Date: Fri,  3 Apr 2026 08:57:20 +0200
Message-ID: <20260403065720.1605109-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: facd3819-277c-4bcd-75d1-08de914e4512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GyNJA2yN2y2IPjS49SBdiToWy9Sq9YQy4+iTrZORaO1Sb644Ubejm4rye9ucvbimuOqWkSJ2Lwu12CqDr3kbu38ye29hAnIh/o/mSDvG78Oza1ROakuyzCx6BmtoVwwDJFDgSY7vBF18QgXFZvlRdFHr9K1wobkwAYF6JB4XWKA4PJyOmJC42PTY5A4PYUKDnh5SdRQV1HLjHB68UVciSs0iyhppPTWtBe4WcWtwGCBypVZf67idu3t/0FNrD52CzGflThMWLFiRcWj1CYwPMC23fzRzvR2AilOVuix6yfg/Vr6jarSeaa7yeLUAQmb5OOxmUOImsZVdCVrE1qWCo9tmEq8gJTDPPzi1tUyfqyQqjYvn4w76Nja5T8pRriVDM8PdZ2ROsiPYO649PzeDNdr7r16WjPzp1Qe+gCtkOhlqcdLDqHgi5UXexQf/KW2KmiyGkpuAYvrwk6QaUfQZtTPzkfxQH7mbQyMyzsOj2OWbrjAAkevHu+U1JVGNOn8oQByDUY4dH8noprA/KdHVARZGL3vz66NNa42ArGsnm91NFjFaNf4m1LGVANaprQbIiDKoE/6JeP8pPJOsUbLETyFOeUaUltQ84HhMIu2WW57vXwB8QDyvuq6Drr8t3RaKd+viKKFVioqn9xUdlNGglDmeyqg2E4SNCErqKqtRGNuatUD5ZCtoX0nZM9MZTEBv8Ptj2pstoP/l3AtK6maXdMoUxV2TTT3F/XQhfP98TVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UQ/+5DMGwvw6dJ/h1pM4RqyB6tO6ALL2LkSSFSqrn4QuVmwgfhtIW6GQhBrO?=
 =?us-ascii?Q?33IulhLVeInDyQ5BWrhViaG247n36xxS1Qm40cJ5Txgnxl2mwBaJnv/84Vqg?=
 =?us-ascii?Q?GPDLg/Ots5hBctiqtyrntb9aGYKCARY7ylnPkSoE8jJMS5tqyEjt6o5BRr4S?=
 =?us-ascii?Q?pdLNGQnuqXeH/9Q0/BdVmwebE5hdbV3ks+hMm/MI1RYv8rvUwTxsGUEnlRyu?=
 =?us-ascii?Q?2DG3xtYQgkm5b6EZ/AYxRzf3ehNIvVIQSO3i2iwHHm0I/JednZqCbD4Knzzm?=
 =?us-ascii?Q?UQ4TN07DxDuEsGHTLQD3jp8wJzolZD9RvLW5iXgq9TFJD4OkTck2+TVjl6ov?=
 =?us-ascii?Q?Akccf8YsZAyuC2iM2/MRW+NvK/wMP+2CWts3HvOZKbjiJaaHYBSxZWEDeXga?=
 =?us-ascii?Q?+TqNoGd5vz+/H28sDmTF4eAToCseW0qu1yLQJ7Acqol9VPcPWvXS9+sfqvPG?=
 =?us-ascii?Q?JXvyPhfFxBtuD9H92Q1IgGPCgLBMiEYSqOccdcc2SshYfC1JDUJS+l9Ewxs9?=
 =?us-ascii?Q?qRRYMkfcfDuAPyakrYldVwlLIJbOsmuIEuGL3L/4FHtRLI/wO8H45EEjGfe3?=
 =?us-ascii?Q?xN7DFTeOXHBuxDTIIifzYsilewvyBjjN5+QsuBvfSv1PQr5vIEGlvxD+B/5c?=
 =?us-ascii?Q?dncatOBvBGBOqNgsoZIjyTw+4Jvv0Zz6/2jaZCLKAzYLMSXOwTzNsf2HNz6T?=
 =?us-ascii?Q?8bU/3SKGm53RgoGInK0OTcjhIEWzRsSaZULXPlZQUOpjya1wiWx5E0jWpUjR?=
 =?us-ascii?Q?bj9P/XGQJhPfdQh4X2Bk+wovxnmQgJjSlQxeF4OFUp0T4mmW3ruDL2hLThho?=
 =?us-ascii?Q?xnvwNkHlAp1MqIbFg8sHYNutmP7NBkuuqV4mi1JIGcD8Fa3QGsdG3Kh4iomg?=
 =?us-ascii?Q?8sGg3bxm2sHl1OzSlBQD/Nlyh23SGm41FXhdgDiHnj2UFhFVAIhWszDaUoSq?=
 =?us-ascii?Q?O3FG6rKbZclGGUZvXRc/WM8kXDZlQ3v1fywAHhHYS2zCWlcQ8KtRDUsN9xTG?=
 =?us-ascii?Q?oJDajexK7j0ZweauGUe9lsDMI+7EDeP7WE7b+tR6XeBCcoeoxftq2nCxUuz0?=
 =?us-ascii?Q?AjdGSmsalNzTOG//YXUy1dgLa4yk8QLSRFJYIKMj+tUSbzXv62o+OnuBjBfw?=
 =?us-ascii?Q?iLTJGGnpVSjFDjxtpYQbHobBD5/tGjHpjHeXWSXHlCNUagLbNMkaGTd9Irq3?=
 =?us-ascii?Q?umG7lG4tBU7fNaoY3ALniZ9lQfZ82Opc4ZUoWnXaDsbw3ItxKxs+6cD0/Zgu?=
 =?us-ascii?Q?oEZEIzmGjppYNW3pOFiEoU39a8XJph5DW00HSmeVjhwNsPOyC1tDnqIXTpkQ?=
 =?us-ascii?Q?EaN8DkWtKsXhyjUm7Cahb6CI8DLOJpdZ6gnK5EnlZ5wTBwn3txzOZ28jRKG2?=
 =?us-ascii?Q?aEUMxeNCMewabmTjZjNwtYyad0ELHXo0XD+SU32YTfBpcp4AHZ4MnqeJDG0K?=
 =?us-ascii?Q?lc8/8s1UCOKDwrSa6fewXuNxq8bWkFeA94TDMeuPMjIS1T3v3Tof6zI7/YoQ?=
 =?us-ascii?Q?TzbKXWQapLlcdj/MBStmYVdPzgKIYNiZlDwevBuOEkCCtGgU4Vb1Z2dtWgnU?=
 =?us-ascii?Q?T80mDtbl2i6PN/qiVz0bh4jjjcWjQiHVpP6w5QffSR5s+6QIzFeN0/y3Dj5E?=
 =?us-ascii?Q?o+ETTncAuS8L77K6Z1CrQ7euFAGiMQ930maLTEVnnTKSPfbNS+XysVMkypu8?=
 =?us-ascii?Q?cq8cscQjxSFchPb60JQzZ/BEHuH0syJwss0PmNLQMIfU/ZFQRf5ZBd2KMzHA?=
 =?us-ascii?Q?DCRscjIkvw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facd3819-277c-4bcd-75d1-08de914e4512
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 06:57:28.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36CsTOezyu7NE0SjDVrenOemZtTQY6wlenF/GLA8ZaOIA9zYY9kVJPjBfYgA//OQO7g8FsRCjpy2W6Oq61sKLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

@p->scx.ddsp_dsq_id can be left set (non-SCX_DSQ_INVALID) triggering a
spurious warning in mark_direct_dispatch() when the next wakeup's
ops.select_cpu() calls scx_bpf_dsq_insert(), such as:

 WARNING: kernel/sched/ext.c:1273 at scx_dsq_insert_commit+0xcd/0x140

The root cause is that ddsp_dsq_id was only cleared in dispatch_enqueue(),
which is not reached in all paths that consume or cancel a direct dispatch
verdict.

Fix it by clearing it at the right places:

 - direct_dispatch(): cache the direct dispatch state in local variables
   and clear it before dispatch_enqueue() on the synchronous path. For
   the deferred path, the direct dispatch state must remain set until
   process_ddsp_deferred_locals() consumes them.

 - process_ddsp_deferred_locals(): cache the dispatch state in local
   variables and clear it before calling dispatch_to_local_dsq(), which
   may migrate the task to another rq.

 - do_enqueue_task(): clear the dispatch state on the enqueue path
   (local/global/bypass fallbacks), where the direct dispatch verdict is
   ignored.

 - dequeue_task_scx(): clear the dispatch state after dispatch_dequeue()
   to handle both the deferred dispatch cancellation and the holding_cpu
   race, covering all cases where a pending direct dispatch is
   cancelled.

 - scx_disable_task(): clear the direct dispatch state when
   transitioning a task out of the current scheduler. Waking tasks may
   have had the direct dispatch state set by the outgoing scheduler's
   ops.select_cpu() and then been queued on a wake_list via
   ttwu_queue_wakelist(), when SCX_OPS_ALLOW_QUEUED_WAKEUP is set. Such
   tasks are not on the runqueue and are not iterated by scx_bypass(),
   so their direct dispatch state won't be cleared. Without this clear,
   any subsequent SCX scheduler that tries to direct dispatch the task
   will trigger the WARN_ON_ONCE() in mark_direct_dispatch().

Fixes: 5b26f7b920f76 ("sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispatches")
Cc: stable@vger.kernel.org # v6.12+
Cc: Daniel Hodges <hodgesd@meta.com>
Cc: Patrick Somaru <patsomaru@meta.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v3:
 - Summarize all clear state scenarios as a function comment on
   clear_direct_dispatch()
 - Correctly apply clear_direct_dispatch() to scx_disable_task()
 - Link to v2: https://lore.kernel.org/all/20260402085743.1410070-1-arighi@nvidia.com

Changes in v2:
 - Move clearing of the direct dispatch state out of dispatch_enqueue() to the
   appropriate places (Tejun Heo)
 - Do not unconditionally clear the direct dispatch state in scx_enable_task()
 - Link to v1: https://lore.kernel.org/all/20260401215619.1188194-1-arighi@nvidia.com

 kernel/sched/ext.c | 49 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d5bdcdb3f7004..064eaa76be4b9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1109,15 +1109,6 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 	dsq_mod_nr(dsq, 1);
 	p->scx.dsq = dsq;
 
-	/*
-	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
-	 * direct dispatch path, but we clear them here because the direct
-	 * dispatch verdict may be overridden on the enqueue path during e.g.
-	 * bypass.
-	 */
-	p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
-	p->scx.ddsp_enq_flags = 0;
-
 	/*
 	 * We're transitioning out of QUEUEING or DISPATCHING. store_release to
 	 * match waiters' load_acquire.
@@ -1283,12 +1274,34 @@ static void mark_direct_dispatch(struct scx_sched *sch,
 	p->scx.ddsp_enq_flags = enq_flags;
 }
 
+/*
+ * Clear @p direct dispatch state when leaving the scheduler.
+ *
+ * Direct dispatch state must be cleared in the following cases:
+ *  - direct_dispatch(): cleared on the synchronous enqueue path, deferred
+ *    dispatch keeps the state until consumed
+ *  - process_ddsp_deferred_locals(): cleared after consuming deferred state,
+ *  - do_enqueue_task(): cleared on enqueue fallbacks where the dispatch
+ *    verdict is ignored (local/global/bypass)
+ *  - dequeue_task_scx(): cleared after dispatch_dequeue(), covering deferred
+ *    cancellation and holding_cpu races
+ *  - scx_disable_task(): cleared for queued wakeup tasks, which are excluded by
+ *    the scx_bypass() loop, so that stale state is not reused by a subsequent
+ *    scheduler instance
+ */
+static inline void clear_direct_dispatch(struct task_struct *p)
+{
+	p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
+	p->scx.ddsp_enq_flags = 0;
+}
+
 static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 			    u64 enq_flags)
 {
 	struct rq *rq = task_rq(p);
 	struct scx_dispatch_q *dsq =
 		find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
+	u64 ddsp_enq_flags;
 
 	touch_core_sched_dispatch(rq, p);
 
@@ -1329,8 +1342,10 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	dispatch_enqueue(sch, dsq, p,
-			 p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
+	ddsp_enq_flags = p->scx.ddsp_enq_flags;
+	clear_direct_dispatch(p);
+
+	dispatch_enqueue(sch, dsq, p, ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 static bool scx_rq_online(struct rq *rq)
@@ -1439,6 +1454,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
+	clear_direct_dispatch(p);
 	dispatch_enqueue(sch, dsq, p, enq_flags);
 }
 
@@ -1610,6 +1626,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+	clear_direct_dispatch(p);
 	return true;
 }
 
@@ -2293,13 +2310,15 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 				struct task_struct, scx.dsq_list.node))) {
 		struct scx_sched *sch = scx_root;
 		struct scx_dispatch_q *dsq;
+		u64 dsq_id = p->scx.ddsp_dsq_id;
+		u64 enq_flags = p->scx.ddsp_enq_flags;
 
 		list_del_init(&p->scx.dsq_list.node);
+		clear_direct_dispatch(p);
 
-		dsq = find_dsq_for_dispatch(sch, rq, p->scx.ddsp_dsq_id, p);
+		dsq = find_dsq_for_dispatch(sch, rq, dsq_id, p);
 		if (!WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL))
-			dispatch_to_local_dsq(sch, rq, dsq, p,
-					      p->scx.ddsp_enq_flags);
+			dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
 	}
 }
 
@@ -3015,6 +3034,8 @@ static void scx_disable_task(struct task_struct *p)
 	lockdep_assert_rq_held(rq);
 	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
 
+	clear_direct_dispatch(p);
+
 	if (SCX_HAS_OP(sch, disable))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
-- 
2.53.0

