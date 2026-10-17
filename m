Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2EC3B27D3
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792268456; cv=fail; b=YxaAag2Lz3WsNFCVJK9PYuT1CGdpXukF4hZslNDZG+wSHgh6iM6xuXwfEfsposv/mlMFBrqZR0YcxlokQlTs0ec337oR/8Kso7vEoTuxftKybwByalK/lTUbKtTAAPCT0oKa2sZ9IKz7vHiu1x7ySjxtk/YQhVbcCqCVTGSZ0II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792268456; c=relaxed/simple;
	bh=EKVGieaxunSVoKX6Y4aGsxa1a2B3xE9g1JQKWGaABT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7S53HHF2DShhHmhRG1v0HTZg0zKELr7tdKMGeqoKY/LOzblmk9xZKIYZBOPn4gNZcYlBI8HsQkAiOAHWLiitrcjp5NQLq+YEomDNPdBN8YPq6svXLcAtEtRulWUZXcFU4+Lh0OCdRHLfc0Gijxii+7ah6jPmuP2LkIOACqEda8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GrD0yKFj; arc=fail smtp.client-ip=40.93.198.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GrD0yKFj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubRa63HFyOuaD0r9G9GYyhbaLRXHTMqKEr7hiHydvYnCCOjJ1auLBj703ZEYON3FObE0xhXodiaMARhxScqvKlUMykZ1ViDY88FyX5/woxQPJvcrKE4r81pjxOoBC0yL7Epi3BdjraHVRkx4Ohsjxfot1n7m6yKBRauNpjLjJ3kZTQgKQYz1qN00R8SG3zQ+v5K/JppYdqw20rXYpCxSGxuyRuXijYzgHBCrDAKnvctjSTp65HTPoRlfqHPlfGhx96ytoxv3BTQi0AWPxMWSuZwxi0uE1AqkgZ4Qi3XFcpBNSs3uuPc6RlDpCINa6ADU14SODSn+KzO6cSRkrW3zHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE0jiY2tYP+4OFp64MutA1shNwstLjKNxCKHyVcwnnc=;
 b=SM6fDJz1z1yKTDkHPVY7CsI1Bz2MaZdgWTWlQuorOOtwg6OSX/0Ua9lqIor0wJYrQpo/F3uY6sKL/P9BYW2Z89wQXOGcRB8pVslJwgk/to6qBUWAjWU67e6n+hA6LyT/tjIpf9ko/gEhX90uj35zoGr1w66A1sAuzTXhe7ymskHmLEc0y3N2XKIyrvDPjTyzSVmsaVmzqA5wqMw7P2x7OydzhmsORPpxOfPAH1/ArSsJ2XgfU6G38o+f41C7fy4FRi8Tufm5LrMt9xF3FRD8Ok/r/oXq0WqBaNX0gucMAZVB+FuPVvb5v5CVdzegyMTuB1AiHyy4s8Nz/0HxF8aM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE0jiY2tYP+4OFp64MutA1shNwstLjKNxCKHyVcwnnc=;
 b=GrD0yKFjwIvavcu7+NqhMPmN7HtZs+U9opBMXgeospxU1VNbAlEEqvmi7iUaCga2ePemJMa3GL8jra31f4j/fgRGS4c6KK286sDAmInOi0J1za/G4feBALgX/TMIz708/zDxzqdiiwE8KLp5Hl0892ywTcuLBuYYHOmY405BgijN/GMcTU+K/pVT3vbYKDtgZ6hCYxmlPTbpwmjVbyCF5dFjjAEdX+lkeADXDStLCuMp1UpuxMJ36mP1btIwTuFiqNO/UhyAV6Muod32gwts3VhAR/dmus3sQ4FDHUSRRc/loDmsoj6wFOnZbAcfLsCFBZIcofqfkmpLOJrZi/O6WQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 20:20:52 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 20:20:52 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Don't queue balance callbacks from a core-sched pick
Date: Sat, 17 Oct 2026 22:05:14 +0200
Message-ID: <20261017202025.3834954-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017202025.3834954-1-arighi@nvidia.com>
References: <20261017202025.3834954-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF00000AD8.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4bc) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a5526e-af9b-4d2e-af09-08df2c8c2402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OyO2+8heEfjUAWHOzM6A8YTNZIMwyYts1SwNYth5zLs7HmLE0UFiPsU/lZS+lHf3RlEToZIliYdTYBG1TjvlWCJlTuvTZFXlYzMJkCfTnE0HL1rWLAxz76RDAusZ3IXCq79Tiy7P/2F/mSduWORIvdA3MPYY8vZOzuutqs3eNPZCPtV7BlgA+l3YPki+O4Dqmgnu2VOKXw4A2hPqZKqDFZrsi22KCP0iWmRN4MIvbWNbjDQyw5ejHxBsXZdm8pldkUJ4nsFxfZVlMJCyH12Wi8sRRjXr8Gf6sgSsXw/d0mZTPsVCX1XUDbBoEoG3DiQP1g37d6rNlbSin8sWR9LRlLOgZ5rsCYw8zy5WH7v4+RRMza4h/1qPaNqWuA6nP94BXEDKVyjLMtAztXZsm8ai+QhtDIB54C/FJ5kOxIO6Jh1/gMtGMbfEA7zdVYxgHkjB+8TNpG9+QuzEZZG0YIC9ET/7/KuI3a5an8g+zV3WkJxjhF8paP2dfv4G1g/JKdDSaoG7iwW5IhAItvxGHEEtKOhNa1v3XAw6Ag9GDBcQVUcI5hwn5iFb03wQ+aAL3ql1uRJAXIe0t/U/EKnm1HEDgPA+e3HUPjWJpZPSDBXnWRrqOxt3+ZtqfeB5hTl/rHn8oHB387lD5XLyhya7DXg62dXD3KtvZP9T2EmpYjgPBQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YRQIxHhJFSRrzFyBXmpTPR98fBmQb+HEcF6gFop1fs0RHnaizgHpEVnYaQ8/?=
 =?us-ascii?Q?0lRCDvt/kF2ZS3UISsjtJx3ZfjNLDwNDSL/hxAOR6uLnA1XfzyNgptQXqKKg?=
 =?us-ascii?Q?MXLeCDT6brgdrkOlc/qIYm769z70EcRmmL4zBPW0yh6J8jOLtlg03aPv+vXD?=
 =?us-ascii?Q?PinI/gtAC2Nk/fQ9uBAh083EBn5p2oxz4D9kyMQWG0plD6MU3icl+VdzNfFA?=
 =?us-ascii?Q?pcURdM4lC8tbKHchT/Qsx0HFyakn42+1BYed3+A/K0O2dyL6gCydBgctfiGg?=
 =?us-ascii?Q?085HDuUXJNbM+sD8gLoQxTMOCvFAQ9P3b+5ak0LeFpKXU+MUZDKanPbiQ487?=
 =?us-ascii?Q?OVZZjkjFu/NC1NrV7AsADR+DPw5ZYwiUqdnN6SxmRKa9yGgQOKq9EdD/8t0u?=
 =?us-ascii?Q?Nq18RzL1gd2iLHlq0dnCrbLk5PNTnDoRQILa7k8Uy/ZJsmo9KTGaITffey8i?=
 =?us-ascii?Q?9sgx9PorZVkOYIEHsWytsL3+S01XAmT0LhbegYEAwnB5VeW5uY0f7WTxzU3o?=
 =?us-ascii?Q?8PPBOrT/GjUfkz1gNx0nMo6cBXnZTD1IZkcHWH56KjhDU7PWGr83wVDIwWiu?=
 =?us-ascii?Q?QVp4txr/Nx5mndCCRycOHnUxmZnqjio6Wln3PeVz0+4VY8FwVwB5niHW50ji?=
 =?us-ascii?Q?lAuxoPcyeS9q/CM1XW8ffZ5oRW3n9vBnz7TWGu4MnPfjXK/u5zKgF8TidBUm?=
 =?us-ascii?Q?IsQU4IHhGYulGJg/c50pzCeqsmDX9Ve7PCFGU3ZojQqZdoM1GN6nyXQBwjku?=
 =?us-ascii?Q?VelIuV6OyjWtpkOHRhZC8RtYM1cmv2lyRdDBL4JMOI55D1k7qn71NkKW1ZR8?=
 =?us-ascii?Q?G6eOAs5mT1qAEGbIA5ZRbBHWMmHJ2gLzyEjQgTuWVUk9auam3cf/npRVCcAo?=
 =?us-ascii?Q?LBFNNci3mC1G2Igap8JVDyGET+CPRT6+OHmZLn9niFFsb4pMUQ9kSoiNAQH6?=
 =?us-ascii?Q?htDSwPb5b+kY5OlneU4LTzs0YoulKB5xvIsSKXo3wIIMmQotEkABxaRXJLP0?=
 =?us-ascii?Q?4SF5/wT9bybYhDh3XbO8jG8E+sF1QKxamPScozI93xYdblnY2FnYFd85Cbj8?=
 =?us-ascii?Q?I8mO1xpCR8m5ZaGOLvWoxVybu5Ui4nQUdpCk3M7XceFqN+c9G1VP2yVsZUE7?=
 =?us-ascii?Q?gXiN2bD+n1/WvCg5ODQ+BUgNXsk5aMjUlgA7DSNdJbhiFsIZxL+NrgeQVgER?=
 =?us-ascii?Q?NMtjArq4Znp8RbeEwNO+PfV9TSg4W/umpN2ck3yzp5ugixsOTknnkYYqQNIa?=
 =?us-ascii?Q?AxoglpvDd1+ikUENthMTwAOh1/Hoo9TCDnbG3d7Z3aKkIFFk+oHSXZlZiYE9?=
 =?us-ascii?Q?rzD2I0dFQUCawsDJOHKuZB6ib7uGBvx4uRB/N0mQGOjPJ9yok82Pcfq3QJyY?=
 =?us-ascii?Q?1L6pwgHJdLVIR/ZPmqrsklDkeKrUNkIu3S+MhU+YtX9N2lr78RWIYsWQebPz?=
 =?us-ascii?Q?RPw+H6kMTj06K6o7dZ3jY0bw54bj/Av/aurdPGktNvuBMorNH7CzzCrG30YZ?=
 =?us-ascii?Q?RHpH2M/Opjmg2h0XIoFNlBpRSGg7H3v7z0Xov0o1+fcQ4DXhhOyGQE+wZiyB?=
 =?us-ascii?Q?fObkMFsImnU2ZvjESPtQ928HOD51sVcS+M5lVhwN2XAhl8b+Oykq+RUnEK/3?=
 =?us-ascii?Q?Y/GuiGye3nFgxj/sEhR9IfVfQRNlsOIQQFYzRlfB+/uZeect9h8IKSGuMLRo?=
 =?us-ascii?Q?2WpIdd9pHzO/IqxGgBAjEW6ywAkpsENOgO9bAs3vml/KfR9i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a5526e-af9b-4d2e-af09-08df2c8c2402
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 20:20:52.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7PaNuQQRTPd49hBflx4SNfZvF43Tabm/v9UsSNBZ0fw8cNpVWrMpcI312EC4e/EuNjBB3+CXOp+1ExD2MdRaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522

Commit ff0545e0c263 ("sched_ext: Don't leave balance callbacks queued
across a pick retry") queues the deferred work as a balance callback
only when do_pick_task_scx() returns a final pick. However, under core
scheduling, a pick that returns a task isn't final either:
pick_next_task() goes on to pick the SMT siblings, and their dispatch
can release the shared rq lock with the callback still queued,
triggering the rq_pin_lock() warning.

Moreover, dispatch_core_pick() returns early when another dispatch is
in flight on the rq, and do_pick_task_scx() then consumes
%SCX_RQ_BAL_CB_PENDING set by that dispatch while it's still running.

This can be reproduced running scx_qmap -I on SMT siblings with
coresched-tagged workloads that frequently sleep, mixed with untagged
CPU-bound tasks.

Fix this by always deferring the pending work to the irq_work path from
dispatch_core_pick() under core scheduling, for both the local and the
sibling picks, and by leaving %SCX_RQ_BAL_CB_PENDING alone in
do_pick_task_scx(), so that it's handled by the dispatch that set it.
Sample the core scheduling state once at the start of the pick, since
core scheduling can get enabled while a non-core dispatch has the rq lock
released, and the follow-up work must match the dispatch path that ran.

Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 0e93a5c45ede4..0c5ed97c4d080 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3390,15 +3390,20 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
 
 	verdict = dispatch_one(rq, prev);
 
-	if (cpu_of(rq) != smp_processor_id() &&
-	    unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
-		/*
-		 * Balance callbacks must run in the context that queued them,
-		 * so they can't be queued on another CPU's rq. Run the deferred
-		 * work directly instead.
-		 */
+	/*
+	 * A pick that returns a task isn't final under core scheduling: the
+	 * selection goes on to pick the siblings, and their dispatch can
+	 * release the rq lock, which can't happen with balance callbacks
+	 * queued. Don't queue the deferred work as a balance callback, for this
+	 * CPU or a sibling, and run it from irq_work instead.
+	 *
+	 * do_pick_task_scx() leaves %SCX_RQ_BAL_CB_PENDING alone under core
+	 * scheduling, so that the early return above leaves it to the dispatch
+	 * in flight, which handles it here.
+	 */
+	if (unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
 		rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
-		run_deferred(rq);
+		schedule_deferred(rq);
 	}
 
 	rq_repin_lock(rq, rf);
@@ -3421,6 +3426,7 @@ static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
 	struct task_struct *prev = rq->curr;
+	bool core_sched = sched_core_enabled(rq);
 	enum scx_dsp_verdict verdict;
 	struct task_struct *p;
 
@@ -3429,7 +3435,12 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 
 	rq_modified_begin(rq, &ext_sched_class);
 
-	if (sched_core_enabled(rq))
+	/*
+	 * Core scheduling can get enabled while dispatch_pick() has the rq lock
+	 * released. Stick to @core_sched, so that the follow-up work below
+	 * matches the dispatch that ran.
+	 */
+	if (core_sched)
 		verdict = dispatch_core_pick(rq, rf, prev);
 	else
 		verdict = dispatch_pick(rq, rf, prev);
@@ -3495,7 +3506,9 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	 * for the next pick.
 	 */
 	if (p != RETRY_TASK && (p || !force_scx)) {
-		maybe_queue_balance_callback(rq);
+		/* under core scheduling, see dispatch_core_pick() */
+		if (!core_sched)
+			maybe_queue_balance_callback(rq);
 
 		/*
 		 * Defer to a balance callback which can drop rq lock and enable
@@ -3508,7 +3521,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 			queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
 					       kick_sync_wait_bal_cb);
 		}
-	} else if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
+	} else if (!core_sched && (rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
 		rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
 		schedule_deferred(rq);
 	}
-- 
2.56.0

