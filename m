Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011025.outbound.protection.outlook.com [40.93.194.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9045FFC7
	for <sched-ext@lists.linux.dev>; Thu, 17 Sep 2026 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628901; cv=fail; b=lE2Y1MstDB2AsS2n01yYy4icUdkzeZfGLw24PvT9MvJ2M9igDwsfDdFk0yE/d+Lk3JYvA4uygKcwc1tPC6LAqHzdMtSROVC5uH3BufRIMRRfmZiCLpgZo34zT7QzoAGTHguKZsHLSUoaBH4aYrG/UGjrUeDbWfL/qf9pXc5IFOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628901; c=relaxed/simple;
	bh=/Z8lIA5zY5OWjlrUMWG/ksPCXaQjD+aA4nERL9Gq9JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BhjWjV4QIlA2z6NN3dKdsS6pn73tvsDzfjXI+3CXMHZWiyr8R66EjLWjc+kI18PLp5DPf/zdsbcoOxQa8h/J2+VOOFIxUil6mG7I66hVkl900BKJED8Mr702iEbdSCvRtSfLsgVnKQIQsgeENbUj9JvrSyWew1oTAxtZFztDuro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dl8mj1Qk; arc=fail smtp.client-ip=40.93.194.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dl8mj1Qk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7o4kKNBSjFSHGMVGGgWXmZhQoLFxMcm2CgPmTMFYBCrpx/KfVj8ZBUec5fVKtCDcsLrNic+b9wDDQD+krxkQ6WMESvKxFEHEqRUhUMuw1ofikyIovR35L78/pNZsF/HOCA4t2s5mUKJ9aGgEi2hCPJJFHH43w5LRsVlQKwta8cIfjbo/bfAnV8h9XUB2eXl8t8umhgAQS9mmRvcFkxTOpqwInJXEzFd9WWQZh+sOMbCX/hI2axxuivXe2WeZPzc/POYLoP1UPisdT1ZPmwEWS1oPxqy4yjInSFHaonwBPfrkVCB11jkhsTIedw9da/7wRQpQBQQJsTUh26UtXx1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeIohOg0Bqnu/zncppthu8LJmc5jCk4rT2vcvnzBVF8=;
 b=Xi/vz8ou/kBkrfsWdmeJGr9T8QaDIiAoC9xKJy6W0xB+U2wFjc6jA8fOlC5gSrUIR7t8QFkKcXXeTDk04wCJKg0exUsMadk+L1s8+WRnpsHr7t78vbDEWE5fDRQGpf01zx16ZizGjK6at8HZLBXEsQJwYEjkuc8YDBSSgsAde8E3YzdjX++AF7gV2PrlvgBJnWFFcH+lePaSvaEfBGRrTwpoIC4Xr7aECibh0HR8tDDWjzUvKDrDmCBl2AgthTHd8NKT+Ee8HsC5hVqcYfM1rSrMOXmqN0xxZbvcLqDd7DXnd2F4/xfA9pPILCvaZTPNPoAbcUb6r6XL4P41KZaFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeIohOg0Bqnu/zncppthu8LJmc5jCk4rT2vcvnzBVF8=;
 b=dl8mj1Qk513/LYjsLabRhwXW9E8eRzDHgAlWcsiDq2FJEYZiVuTsvOvGAjHoDMSFUdcJPcN36PwLf/L3OmAxokzSk/Vk0ksC1A+7dky3kStNQxNB9cSxpr0tRyjGu1rgLXy8cdR5oPAuNDwCRsYHjDsg3iR6rcyuf62HHn/0ibfTPHej9olDXgS6CmGNp5K/BRkmshtiNg7CNlngVphZkRgdxKx/H/8/ID4OaGhQmy/G+Do7Cn/8Ob9hvhkGbJ6uMXTWG1eGf60UsdMG44+eejs7qb1iO6Qb9hzgni9o8anD0Owqs0MRhCDRWqUK+7HtF1ZWQDQWZ8lxQ2Ji/KO27w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 17 Sep
 2026 07:08:11 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 07:08:11 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Add lazy preemption support
Date: Thu, 17 Sep 2026 09:02:52 +0200
Message-ID: <20260917070751.3617935-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917070751.3617935-1-arighi@nvidia.com>
References: <20260917070751.3617935-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 66768871-9f09-414e-2cb1-08df148a6edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|5023799004|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gfD32v4n/GkcEvmZw/Z+7GYdCfGMo8MPXGenvePMs1+LsXqTrFDT29/y9a4TFRRqKig0MZy9xgC0yFnoOrDjf7C1G+6GhEmBywzFopu3R6YesVP5+2LGJs0FF4FOb/+RsVrcVK6d8TDct7kt2sginzZa44OGFQsRb4/sjl+ypAU6Z/gDmtL6MIoHojUvhUK4QaPqtN8+JMWHMCp6evVmOgB1DFetjPco7afKnckHLXEaRZPDnKY4WM93NwOSStdWOcCpCctdOCpzE1RbIAYitAZlaMs8DBGycfqjK/D4Mp98s5x0aGP+yq4aC2LhqmpOSx2ysmo27mb/maxEhdJqgPi82qn3o7Di7OUROIfsTSB3RrdpEZom8g/hnsQsgQrqXw1CLcpQkwg8CZiJ7/pRmJeV96YeuhO8MEcSsYvOUVxuil1zIa+wP4lhxDNBAGElAX+CjuEQjjNkNl76suf2AqjyhXViInXoMJ3sobjX77f4lENZH3yGy25/7APcZI9dyRjhpmN1BhebJBD7dyb2QuuJP7w+SPMH/mTu5Wq8KmQkye0tBN6T4lqBmIjhM+V1cja6fYIpesCSbSbTGKT711sFuEIuctfgW59DX7WJulydWovi6BvnZjwIC/yefMxWQ9wNgCYYf1h0BKLHJj2SReQJYgp+cGTU3e/TB1vJeg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+F0FSrg6YNf0ry0yT4jDfRzsr4/vbMYMWL7nRPAJo/5Pqe5BfczkubvEImf0?=
 =?us-ascii?Q?jrxRveKAbMxTepydGp0CNhyll3tvETUZ4rv07m8NgDQDhVY5iRmQEUJKWlZh?=
 =?us-ascii?Q?6tCgc1hFFiqW7n/tGAsbhLGK8YqlYfcupsmsXNnQB/UEbGICcHj/vZp/QBDU?=
 =?us-ascii?Q?52/I8ZykI3iAmGJdfjJ77Q3gfpFC1yYHxu/3/e40dT1pUC7b9/hW+xiJa7IG?=
 =?us-ascii?Q?thc9JE/KWYRiKX/nviINvvBAttCwSRiPCPe2IcEpTeolAR+ymvm6F2x2p+u2?=
 =?us-ascii?Q?ZvokC5SCd68j7YLf35vs2mRGYzt9NuFA1KMydfZGvsqfIIg3kV6xpkdFLZUE?=
 =?us-ascii?Q?ZlQyqd+yCMT69Sx7I0sV7tiA5vD/6zWHkPHIg1kCk7OuuvH7W3A27p23hp5f?=
 =?us-ascii?Q?lzEs7JwHfHL+45FxZ+Szb4W1LeD9v5p2Q1vPQiBeHtehyzBEAju11M1rGYyJ?=
 =?us-ascii?Q?i6EBLi4xIg253l7t7aCpWmCrkkHmdTs8U5xjf4C//d0R3T/BWf8Zdqm+ThcR?=
 =?us-ascii?Q?vagT27BLLbmXo1BujoIpJLjvpw9TDFG4D780l8NqeLMqv5IpJ+MUM98+/YYc?=
 =?us-ascii?Q?ienytVg7HS7XJ1i1YWoV+CN7JjpBS/2aDcC3KDjbvdEOed26841qzxPTqUna?=
 =?us-ascii?Q?fBB+m1rBrqNz9DhnIIIk0qqnHxGzoFeabCNQtjGJtPsL+4n6DNDEbLgmXsRI?=
 =?us-ascii?Q?ISfowDGDUOWBC3b1w2y0afFDePgu3XEjTI6lbNIwm2N3qyfA/z0S01++i0ZJ?=
 =?us-ascii?Q?1mQBSATxs5PMIQVc/rS4hGctsaOHqRYwQhS0FEa+klEa7XHn0HWu/SCzNw/m?=
 =?us-ascii?Q?jKIxs2iQgyDLD75T2vDbsJqJ6aaFzU1NtSK1Om660UlaiADj7LEV0uZ4KJiI?=
 =?us-ascii?Q?448Bq/0sKxNPzIlCLlBP0L1hZ5mgEpPuOWH+rjgCVigt0sSwintu6iXvbgED?=
 =?us-ascii?Q?2rIn/Rpq5+CAjo2Njqv0hcM3d1xVLMF1cyelgP6YsK8/g3XDx3x1a08eopUY?=
 =?us-ascii?Q?e4R8hEAV98sUXGs6aoJlb0g9Sot7RaTDaEqMoYyp4Vb3rMNvco5w0g2Hk9EK?=
 =?us-ascii?Q?heqoftootU83CWFiCmrRpG4aAU3itvLRvZltC1ddYJ0QbKqATvrV0dLii38X?=
 =?us-ascii?Q?vg9MHbSsjZf1upO62JQvFMgnmyUaf5NTqupO/VQBgY4QJVV145ewW9Y/EhcR?=
 =?us-ascii?Q?lCMvlv5c59jPUBfprVTH30O5Fm+/7fO6ssHLIK1lrO6gZFs8+cFbZZscbKF6?=
 =?us-ascii?Q?hynBCsCdWbxdBe1mD1musZvNuQQQNIm5mTNWS8kXj9gKdRfqj38D2ZlX4E84?=
 =?us-ascii?Q?brhYnIxr7XnaHKIpH5837uRZKgDGp+SFAg58VEwFIrbJHe49ClSvvToQcjTS?=
 =?us-ascii?Q?bH+VAvlC3YCneEwJEXpti4FtmhbRUI+ZYYKuZJAAvnGr0Pc/KaAN3hGpej70?=
 =?us-ascii?Q?WldS57OmFuleU4ugO5UvA0du3sXEwtrD2quIvCfbl6HRUqSAes6nvfsKIed8?=
 =?us-ascii?Q?1NyiBbbQXuRZQp23htKOJcDi4OPw2GQX5oEWHVAwaaLa8XDvrK5VgEEkqC2P?=
 =?us-ascii?Q?IlL/L1pZweVqHzPeQtrNirK8LBKoGtAI/QhvUN7UGG0fTUkDLfmpiyH4i9FQ?=
 =?us-ascii?Q?NjDAfGFAnjKwDRd9tRm/8ZSm9JGW44LbDXeAk17uBrZyCSALVJs6NyFeySxL?=
 =?us-ascii?Q?nJeERv2RdHKc2GkSOb/kcLQ612C+DseM8ptOnvhYdbgZDpcILPbCuly39sFw?=
 =?us-ascii?Q?Q4meq0M0Ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66768871-9f09-414e-2cb1-08df148a6edf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:08:11.3553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHqZ79CnjdNfSo1Z4+7cg7aSxwHQftFuyilwElaf0qOWzX7bn5a0GTj1BJCmLtd+zuQnSiwxqzYkHtCSZGC8Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

The fair scheduling class can request lazy rescheduling, deferring an
in-kernel scheduling boundary until returning to user space or until the
next scheduler tick. sched_ext only exposes immediate preemption,
preventing BPF schedulers from making the same trade-off.

Add SCX_ENQ_PREEMPT_LAZY and SCX_KICK_PREEMPT_LAZY. Both expire the
current sched_ext task slice but request lazy rescheduling. Immediate
preemption, WAIT and plain kicks take precedence when requests are
combined, while a lazy enqueue to a non-local DSQ retains the
head-insertion semantics of SCX_ENQ_PREEMPT.

Add SCX_OPS_LAZY_SLICE_EXPIRY as the default expiry policy for newly
enabled tasks and initialize it before ops.enable(). Add
scx_bpf_task_set_slice_expiry() so the owning scheduler can override the
policy per task from any callback while preserving sub-scheduler task
ownership boundaries. Bypass continues to force immediate expiry.

For an infinite-slice task whose tick is stopped, set the lazy
reschedule request before restoring the scheduler tick dependency. This
lets the dependency update's IPI serve the request on return to user
space and guarantees that the next tick promotes it otherwise. Use
pinned rq locking for remote kick delivery so RQCF_UPDATED reflects
clock updates since lock acquisition.

Accumulate kick requests independently and resolve precedence while
holding the target rq lock. Reject invalid SCX_KICK_IDLE combinations
and unknown kick flags, which were previously silently ignored.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |   8 +
 kernel/sched/ext/ext.c                        | 152 +++++++++++++++---
 kernel/sched/ext/internal.h                   |  40 ++++-
 kernel/sched/ext/sub.c                        |  15 +-
 tools/sched_ext/include/scx/compat.bpf.h      |  17 ++
 .../sched_ext/include/scx/enum_defs.autogen.h |   3 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   6 +
 tools/sched_ext/include/scx/enums.autogen.h   |   2 +
 .../sched_ext/include/scx/enums_abi.autogen.h |   5 +-
 9 files changed, 210 insertions(+), 38 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 8de69843c2150..7c759baf4813f 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -278,6 +278,14 @@ struct sched_ext_entity {
 	 */
 	bool			disallow;	/* reject switching into SCX */
 
+	/*
+	 * If set, depletion of this task's slice at the scheduler tick requests
+	 * lazy instead of immediate rescheduling. Initialized from
+	 * %SCX_OPS_LAZY_SLICE_EXPIRY immediately before ops.enable() and may be
+	 * modified afterwards with scx_bpf_task_set_slice_expiry().
+	 */
+	bool			slice_expires_lazy;
+
 	/* cold fields */
 #ifdef CONFIG_EXT_GROUP_SCHED
 	struct cgroup		*cgrp_moving_from;
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4080902a528cd..e1d6fddda1815 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -383,11 +383,11 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
 		return true;
 
 	/*
-	 * %SCX_ENQ_PREEMPT clears $curr's slice if on SCX and kicks dispatch,
-	 * so allow it to avoid spuriously triggering reenq on a combined
+	 * The preemption flags clear $curr's slice if on SCX and kick dispatch,
+	 * so allow them to avoid spuriously triggering reenq on a combined
 	 * PREEMPT|IMMED insertion.
 	 */
-	if (enq_flags & SCX_ENQ_PREEMPT) {
+	if (enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) {
 		struct task_struct *curr = rq->curr;
 
 		/*
@@ -1515,6 +1515,26 @@ static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
 	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
 }
 
+/*
+ * A task with an infinite slice may be running with its tick stopped. Lazy
+ * rescheduling doesn't send an IPI, so restore the tick dependency to
+ * guarantee that the lazy request is promoted by a real scheduler tick. Set
+ * the lazy request first so that the dependency update's IPI can also serve it
+ * on return to user space.
+ */
+static void scx_resched_curr_lazy(struct rq *rq)
+{
+	resched_curr_lazy(rq);
+
+	if (rq->scx.flags & SCX_RQ_CAN_STOP_TICK) {
+		rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
+		if (rq->clock_update_flags < RQCF_UPDATED)
+			update_rq_clock(rq);
+		update_other_load_avgs(rq);
+		sched_update_tick_dependency(rq);
+	}
+}
+
 static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 			      struct scx_dispatch_q *dsq, struct task_struct *p,
 			      u64 enq_flags)
@@ -1577,12 +1597,16 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
 		return;
 
-	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
+	if ((enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) && p != rq->curr &&
 	    rq->curr->sched_class == &ext_sched_class) {
-		if (likely(scx_set_task_slice(rq->curr, 0)))
-			resched_curr(rq);
-		else
+		if (likely(scx_set_task_slice(rq->curr, 0))) {
+			if (enq_flags & SCX_ENQ_PREEMPT)
+				resched_curr(rq);
+			else
+				scx_resched_curr_lazy(rq);
+		} else {
 			__scx_add_event(sch, SCX_EV_SLICE_DENIED, 1);
+		}
 	}
 }
 
@@ -1672,7 +1696,7 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 			scx_error(sch, "DSQ ID 0x%016llx already had PRIQ-enqueued tasks",
 				  dsq->id);
 
-		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT)) {
+		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY)) {
 			/* new task inserted at head - use fastpath */
 			if (dsq_insert_head(dsq, p) && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
 				rcu_assign_pointer(dsq->first_task, p);
@@ -2386,7 +2410,7 @@ void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 
-	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY))
 		dsq_insert_head(dst_dsq, p);
 	else
 		list_add_tail(&p->scx.dsq_list.node, &dst_dsq->list);
@@ -3804,8 +3828,14 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	else if (SCX_HAS_OP(sch, tick))
 		SCX_CALL_OP_TASK(sch, tick, rq, curr);
 
-	if (!curr->scx.slice)
-		resched_curr(rq);
+	if (!curr->scx.slice) {
+		/* the slice can't be trusted while bypassing */
+		if (READ_ONCE(curr->scx.slice_expires_lazy) &&
+		    !scx_bypassing(sch, cpu_of(rq)))
+			scx_resched_curr_lazy(rq);
+		else
+			resched_curr(rq);
+	}
 }
 
 #ifdef CONFIG_EXT_GROUP_SCHED
@@ -3921,6 +3951,7 @@ static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 		weight = sched_prio_to_weight[p->static_prio - MAX_RT_PRIO];
 
 	p->scx.weight = sched_weight_to_cgroup(weight);
+	p->scx.slice_expires_lazy = sch->ops.flags & SCX_OPS_LAZY_SLICE_EXPIRY;
 
 	if (SCX_HAS_OP(sch, enable))
 		SCX_CALL_OP_TASK(sch, enable, rq, p);
@@ -5371,6 +5402,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		free_cpumask_var(pcpu->cpus_to_kick);
 		free_cpumask_var(pcpu->cpus_to_kick_if_idle);
 		free_cpumask_var(pcpu->cpus_to_preempt);
+		free_cpumask_var(pcpu->cpus_to_preempt_lazy);
 		free_cpumask_var(pcpu->cpus_to_wait);
 
 		exit_dsq(scx_bypass_dsq(sch, cpu));
@@ -6883,6 +6915,9 @@ static void scx_dump_cpu(struct scx_sched *sch, struct seq_buf *s,
 	if (!cpumask_empty(pcpu->cpus_to_preempt))
 		scx_dump_line(&ns, "  cpus_to_preempt: %*pb",
 			      cpumask_pr_args(pcpu->cpus_to_preempt));
+	if (!cpumask_empty(pcpu->cpus_to_preempt_lazy))
+		scx_dump_line(&ns, "  preempt_lazy   : %*pb",
+			      cpumask_pr_args(pcpu->cpus_to_preempt_lazy));
 	if (!cpumask_empty(pcpu->cpus_to_wait))
 		scx_dump_line(&ns, "  cpus_to_wait   : %*pb",
 			      cpumask_pr_args(pcpu->cpus_to_wait));
@@ -7200,6 +7235,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		if (!zalloc_cpumask_var_node(&pcpu->cpus_to_kick, GFP_KERNEL, node) ||
 		    !zalloc_cpumask_var_node(&pcpu->cpus_to_kick_if_idle, GFP_KERNEL, node) ||
 		    !zalloc_cpumask_var_node(&pcpu->cpus_to_preempt, GFP_KERNEL, node) ||
+		    !zalloc_cpumask_var_node(&pcpu->cpus_to_preempt_lazy, GFP_KERNEL, node) ||
 		    !zalloc_cpumask_var_node(&pcpu->cpus_to_wait, GFP_KERNEL, node)) {
 			ret = -ENOMEM;
 			goto err_free_pcpu;
@@ -7335,6 +7371,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		free_cpumask_var(pcpu->cpus_to_kick);
 		free_cpumask_var(pcpu->cpus_to_kick_if_idle);
 		free_cpumask_var(pcpu->cpus_to_preempt);
+		free_cpumask_var(pcpu->cpus_to_preempt_lazy);
 		free_cpumask_var(pcpu->cpus_to_wait);
 	}
 	for_each_possible_cpu(cpu) {
@@ -8459,13 +8496,23 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct scx_rq *this_scx = &this_rq->scx;
+	struct rq_flags rf;
 	const struct sched_class *cur_class;
 	bool should_wait = false;
 	bool kickable;
-	unsigned long flags;
+	bool preempt, preempt_lazy, wait, immediate;
 
-	raw_spin_rq_lock_irqsave(rq, flags);
+	rq_lock_irqsave(rq, &rf);
 	cur_class = rq->curr->sched_class;
+	preempt = cpumask_test_cpu(cpu, pcpu->cpus_to_preempt);
+	preempt_lazy = cpumask_test_cpu(cpu, pcpu->cpus_to_preempt_lazy);
+	wait = cpumask_test_cpu(cpu, pcpu->cpus_to_wait);
+	/*
+	 * Immediate preemption, waiting and a plain kick take precedence over
+	 * lazy preemption. The lazy request still clears the slice, so all
+	 * accumulated requests are served.
+	 */
+	immediate = preempt || wait || cpumask_test_cpu(cpu, pcpu->cpus_to_kick);
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
@@ -8479,19 +8526,23 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 		   !sched_class_above(cur_class, &ext_sched_class);
 
 	if (kickable && !scx_missing_caps(pcpu->sch, cpu, SCX_CAP_BASE)) {
-		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
+		if (preempt || preempt_lazy) {
 			if (cur_class == &ext_sched_class) {
 				u64 caps = scx_caps_for_preempt(pcpu->sch, rq, 0);
 
-				if (unlikely(scx_missing_caps(pcpu->sch, cpu, caps)))
+				if (unlikely(scx_missing_caps(pcpu->sch, cpu, caps))) {
 					__scx_add_event(pcpu->sch, SCX_EV_SUB_PREEMPT_DENIED, 1);
-				else if (unlikely(!scx_set_task_slice(rq->curr, 0)))
+					/* degrade to a plain, immediate kick */
+					immediate = true;
+				} else if (unlikely(!scx_set_task_slice(rq->curr, 0))) {
 					__scx_add_event(pcpu->sch, SCX_EV_SLICE_DENIED, 1);
+				}
 			}
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
+			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt_lazy);
 		}
 
-		if (cpumask_test_cpu(cpu, pcpu->cpus_to_wait)) {
+		if (wait) {
 			if (cur_class == &ext_sched_class) {
 				cpumask_set_cpu(cpu, this_scx->cpus_to_sync);
 				ksyncs[cpu] = rq->scx.kick_sync;
@@ -8500,17 +8551,21 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_wait);
 		}
 
-		resched_curr(rq);
+		if (immediate)
+			resched_curr(rq);
+		else
+			scx_resched_curr_lazy(rq);
 	} else {
 		/* a kickable cpu was skipped solely for the missing caps */
 		if (kickable)
 			__scx_add_event(pcpu->sch, SCX_EV_SUB_KICK_DENIED, 1);
 		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
+		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt_lazy);
 		cpumask_clear_cpu(cpu, pcpu->cpus_to_wait);
 	}
 
 	scx_rq_lock_drop(rq);
-	raw_spin_rq_unlock_irqrestore(rq, flags);
+	rq_unlock_irqrestore(rq, &rf);
 
 	return should_wait;
 }
@@ -8566,6 +8621,14 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
 		}
 
+		/*
+		 * kick_one_cpu() clears the lazy bit of every cpu it visited
+		 * above; visit the remaining requests which contain lazy
+		 * preemption, see scx_kick_cpu().
+		 */
+		for_each_cpu(cpu, pcpu->cpus_to_preempt_lazy)
+			should_wait |= kick_one_cpu(cpu, pcpu, this_rq, ksyncs);
+
 		for_each_cpu(cpu, pcpu->cpus_to_kick_if_idle) {
 			kick_one_cpu_if_idle(cpu, pcpu, this_rq);
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
@@ -9531,6 +9594,31 @@ __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
 	return true;
 }
 
+/**
+ * scx_bpf_task_set_slice_expiry - Set task's slice expiry policy
+ * @p: task of interest
+ * @lazy: whether slice expiry should request lazy rescheduling
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Choose whether depletion of @p's slice at the scheduler tick requests lazy
+ * or immediate rescheduling. @p must be on the calling scheduler.
+ *
+ * Return %true on success, %false if @p is not on the calling scheduler.
+ */
+__bpf_kfunc bool scx_bpf_task_set_slice_expiry(struct task_struct *p, bool lazy,
+					       const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
+		return false;
+
+	WRITE_ONCE(p->scx.slice_expires_lazy, lazy);
+	return true;
+}
+
 void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 {
 	struct scx_sched_pcpu *pcpu;
@@ -9539,6 +9627,16 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 
 	if (!scx_kf_allowed_ctx(sch))
 		return;
+	if (unlikely(flags & ~(SCX_KICK_IDLE | SCX_KICK_PREEMPT | SCX_KICK_WAIT |
+			       SCX_KICK_PREEMPT_LAZY))) {
+		scx_error(sch, "invalid kick flags 0x%llx", flags);
+		return;
+	}
+	if (unlikely((flags & SCX_KICK_IDLE) &&
+		     (flags & (SCX_KICK_PREEMPT | SCX_KICK_PREEMPT_LAZY | SCX_KICK_WAIT)))) {
+		scx_error(sch, "PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
+		return;
+	}
 
 	local_irq_save(irq_flags);
 
@@ -9564,9 +9662,6 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	if (flags & SCX_KICK_IDLE) {
 		struct rq *target_rq = cpu_rq(cpu);
 
-		if (unlikely(flags & (SCX_KICK_PREEMPT | SCX_KICK_WAIT)))
-			scx_error(sch, "PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
-
 		if (raw_spin_rq_trylock(target_rq)) {
 			if (can_skip_idle_kick(target_rq)) {
 				scx_rq_lock_drop(target_rq);
@@ -9578,12 +9673,15 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 		}
 		cpumask_set_cpu(cpu, pcpu->cpus_to_kick_if_idle);
 	} else {
-		cpumask_set_cpu(cpu, pcpu->cpus_to_kick);
-
+		/* Accumulate requests and resolve their precedence at delivery. */
 		if (flags & SCX_KICK_PREEMPT)
 			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt);
+		if (flags & SCX_KICK_PREEMPT_LAZY)
+			cpumask_set_cpu(cpu, pcpu->cpus_to_preempt_lazy);
 		if (flags & SCX_KICK_WAIT)
 			cpumask_set_cpu(cpu, pcpu->cpus_to_wait);
+		if (!(flags & SCX_KICK_PREEMPT_LAZY))
+			cpumask_set_cpu(cpu, pcpu->cpus_to_kick);
 	}
 
 	if (list_empty(&pcpu->to_kick_node))
@@ -9623,8 +9721,9 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
  * cid-addressed equivalent of scx_bpf_kick_cpu(). An invalid @cid aborts the
  * scheduler via scx_cid_to_cpu(). Caps are enforced on the delivery path: a
  * kick is dropped if the caller lacks baseline access on @cid, and a
- * %SCX_KICK_PREEMPT degrades to a plain reschedule if the caller lacks
- * %SCX_CAP_PREEMPT for a task outside its subtree.
+ * %SCX_KICK_PREEMPT or %SCX_KICK_PREEMPT_LAZY request degrades to a plain
+ * reschedule if the caller lacks %SCX_CAP_PREEMPT for a task outside its
+ * subtree.
  */
 __bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
 {
@@ -10691,6 +10790,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
+BTF_ID_FLAGS(func, scx_bpf_task_set_slice_expiry, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_kick_cid, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued, KF_IMPLICIT_ARGS)
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index e1eb3a0d456cb..bb527e891c8cd 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -215,6 +215,20 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * If set, tasks default to requesting lazy rescheduling when their slice
+	 * runs out at the tick, the way fair.c expires a slice from update_curr().
+	 * The default is copied to p->scx.slice_expires_lazy immediately before
+	 * ops.enable(), after which scx_bpf_task_set_slice_expiry() may override
+	 * it per task.
+	 * A task in user space still reschedules on the way back from the tick; a
+	 * task in the kernel runs on to its next return to user space or to the
+	 * next tick, which promotes the request. When lazy preemption is disabled
+	 * at runtime, the request behaves like an immediate reschedule.
+	 * Rescheduling while bypassing stays immediate.
+	 */
+	SCX_OPS_LAZY_SLICE_EXPIRY	= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -223,7 +237,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_LAZY_SLICE_EXPIRY,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1327,6 +1342,7 @@ struct scx_sched_pcpu {
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
 	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_preempt_lazy;
 	cpumask_var_t		cpus_to_wait;
 	struct list_head	to_kick_node;
 
@@ -1407,15 +1423,16 @@ struct scx_sched_pnode {
  * the allocation pattern.
  *
  * ENQ_IMMED  insert an IMMED task onto the cid's local DSQ
- *            - kick the cid's cpu (except SCX_KICK_PREEMPT)
+ *            - kick the cid's cpu (except SCX_KICK_PREEMPT and
+ *              SCX_KICK_PREEMPT_LAZY)
  *
  * ENQ        insert any task onto the cid's local DSQ (implies ENQ_IMMED)
  *
  * PREEMPT    preempt any task running on the cid regardless of the owning
  *            sched (implies ENQ). Preempting a task in the sched's own subtree
  *            doesn't require any cap.
- *            - SCX_ENQ_PREEMPT inserts
- *            - SCX_KICK_PREEMPT kicks
+ *            - SCX_ENQ_PREEMPT and SCX_ENQ_PREEMPT_LAZY insert
+ *            - SCX_KICK_PREEMPT and SCX_KICK_PREEMPT_LAZY kick
  *
  * PERF       control the cid's cpu power/perf management state, currently the
  *            cpufreq target set through scx_bpf_cidperf_set(). Hardware
@@ -1685,6 +1702,15 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_PREEMPT		= 1LLU << 32,
 
+	/*
+	 * Like %SCX_ENQ_PREEMPT, but request lazy rescheduling. The current
+	 * task's slice is still cleared immediately so that the next scheduling
+	 * boundary observes the new ordering. %SCX_ENQ_PREEMPT takes precedence
+	 * if both are specified. Implies %SCX_ENQ_HEAD, which is all it means on
+	 * a non-local DSQ, as with %SCX_ENQ_PREEMPT.
+	 */
+	SCX_ENQ_PREEMPT_LAZY	= 1LLU << 35,
+
 	/*
 	 * Only allowed on local DSQs. Guarantees that the task either gets
 	 * on the CPU immediately and stays on it, or gets reenqueued back
@@ -1811,6 +1837,12 @@ enum scx_kick_flags {
 	 * is not on SCX.
 	 */
 	SCX_KICK_WAIT		= 1LLU << 2,
+
+	/*
+	 * Like %SCX_KICK_PREEMPT, but request lazy rescheduling. If combined
+	 * with %SCX_KICK_PREEMPT or %SCX_KICK_WAIT, rescheduling is immediate.
+	 */
+	SCX_KICK_PREEMPT_LAZY	= 1LLU << 3,
 };
 
 enum scx_tg_flags {
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 380a5653dc529..a88b87614b55e 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -686,9 +686,10 @@ void scx_rescue_init(struct rq *rq)
  * rescue is enabled, or @rq's reject DSQ after recording the reenq reason on
  * @p.
  *
- * %SCX_ENQ_IMMED, %SCX_ENQ_PREEMPT and %SCX_ENQ_HEAD are cleared when diverting
- * to rescue or reject. %SCX_ENQ_PREEMPT is also cleared on a fallback
- * migration-disabled admission.
+ * %SCX_ENQ_IMMED, %SCX_ENQ_PREEMPT, %SCX_ENQ_PREEMPT_LAZY and %SCX_ENQ_HEAD
+ * are cleared when diverting to rescue or reject. %SCX_ENQ_PREEMPT and
+ * %SCX_ENQ_PREEMPT_LAZY are also cleared on a fallback migration-disabled
+ * admission.
  *
  * Bypass doesn't need special-casing as a bypassing sched's tasks are enqueued
  * to and run by its nearest non-bypassing ancestor. If root is bypassing, it
@@ -709,7 +710,7 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	 * On a remote activation the scheduling sched (@asch) differs from
 	 * @p's owner (@sch). Check caps against the scheduling sched.
 	 */
-	if (*enq_flags & SCX_ENQ_PREEMPT)
+	if (*enq_flags & (SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY))
 		needed |= scx_caps_for_preempt(asch, rq, *enq_flags);
 	missing = scx_missing_caps(asch, cpu_of(rq), needed);
 
@@ -726,7 +727,7 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	if (unlikely(!scx_rq_online(rq) || is_migration_disabled(p) ||
 		     p->migration_pending)) {
 		__scx_add_event(sch, SCX_EV_SUB_FORCED_ADMIT, 1);
-		*enq_flags &= ~SCX_ENQ_PREEMPT;
+		*enq_flags &= ~(SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY);
 		return &rq->scx.local_dsq;
 	}
 
@@ -735,8 +736,8 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	 * or HEAD - a diversion has no priority and IMMED is not allowed on
 	 * non-local DSQs. Strip the enq and task flags along with the slice.
 	 */
-	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_HEAD |
-			SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
+	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT | SCX_ENQ_PREEMPT_LAZY |
+			SCX_ENQ_HEAD | SCX_ENQ_APPLY_SLICE | SCX_ENQ_SLICE_DFL);
 	p->scx.flags &= ~SCX_TASK_IMMED;
 
 	/* the enqueuer opted for rescue instead of rejection and reenqueue */
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 6944221f96cc0..9491acb8d059f 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -403,6 +403,23 @@ static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
 		p->scx.dsq_vtime = vtime;
 }
 
+/*
+ * v7.4: Add per-task control over whether slice expiry requests lazy or
+ * immediate rescheduling. Older kernels have no equivalent operation, so the
+ * compatibility wrapper is a no-op when the kfunc is unavailable. As with the
+ * setters above, discard the kfunc's authority result for consistency.
+ *
+ * Keep the wrapper until pre-v7.4 kernels fall out of the sched_ext scheduler
+ * support window.
+ */
+bool scx_bpf_task_set_slice_expiry___new(struct task_struct *p, bool lazy) __ksym __weak;
+
+static inline void scx_bpf_task_set_slice_expiry(struct task_struct *p, bool lazy)
+{
+	if (bpf_ksym_exists(scx_bpf_task_set_slice_expiry___new))
+		scx_bpf_task_set_slice_expiry___new(p, lazy);
+}
+
 /*
  * v7.1: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. This
  * will eventually deprecate scx_bpf_reenqueue_local().
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 63b6b14b19bd4..5d25a29ab9782 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -85,6 +85,7 @@
 #define HAVE_SCX_ENQ_HEAD
 #define HAVE_SCX_ENQ_CPU_SELECTED
 #define HAVE_SCX_ENQ_PREEMPT
+#define HAVE_SCX_ENQ_PREEMPT_LAZY
 #define HAVE_SCX_ENQ_IMMED
 #define HAVE_SCX_ENQ_RESCUE
 #define HAVE_SCX_ENQ_REENQ
@@ -149,6 +150,7 @@
 #define HAVE_SCX_KICK_IDLE
 #define HAVE_SCX_KICK_PREEMPT
 #define HAVE_SCX_KICK_WAIT
+#define HAVE_SCX_KICK_PREEMPT_LAZY
 #define HAVE_SCX_OPI_BEGIN
 #define HAVE_SCX_OPI_NORMAL_BEGIN
 #define HAVE_SCX_OPI_NORMAL_END
@@ -164,6 +166,7 @@
 #define HAVE_SCX_OPS_BUILTIN_IDLE_PER_NODE
 #define HAVE_SCX_OPS_ALWAYS_ENQ_IMMED
 #define HAVE_SCX_OPS_TID_TO_TASK
+#define HAVE_SCX_OPS_LAZY_SLICE_EXPIRY
 #define HAVE_SCX_OPS_ALL_FLAGS
 #define HAVE___SCX_OPS_INTERNAL_MASK
 #define HAVE_SCX_OPS_HAS_CPU_PREEMPT
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 7268131010de3..6afd4179cce50 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -112,6 +112,9 @@ const volatile u64 __SCX_KICK_PREEMPT __weak;
 const volatile u64 __SCX_KICK_WAIT __weak;
 #define SCX_KICK_WAIT __SCX_KICK_WAIT
 
+const volatile u64 __SCX_KICK_PREEMPT_LAZY __weak;
+#define SCX_KICK_PREEMPT_LAZY __SCX_KICK_PREEMPT_LAZY
+
 const volatile u64 __SCX_ENQ_WAKEUP __weak;
 #define SCX_ENQ_WAKEUP __SCX_ENQ_WAKEUP
 
@@ -121,6 +124,9 @@ const volatile u64 __SCX_ENQ_HEAD __weak;
 const volatile u64 __SCX_ENQ_PREEMPT __weak;
 #define SCX_ENQ_PREEMPT __SCX_ENQ_PREEMPT
 
+const volatile u64 __SCX_ENQ_PREEMPT_LAZY __weak;
+#define SCX_ENQ_PREEMPT_LAZY __SCX_ENQ_PREEMPT_LAZY
+
 const volatile u64 __SCX_ENQ_IMMED __weak;
 #define SCX_ENQ_IMMED __SCX_ENQ_IMMED
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index e616326545172..16e500b10fc65 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -41,9 +41,11 @@
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_IDLE); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_PREEMPT); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_WAIT); \
+	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_PREEMPT_LAZY); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_WAKEUP); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_HEAD); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT_LAZY); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_RESCUE); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index d53899764f5ac..d6f38bebd8134 100644
--- a/tools/sched_ext/include/scx/enums_abi.autogen.h
+++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
@@ -97,6 +97,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_enq_flags", "SCX_ENQ_HEAD", 0x10000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_CPU_SELECTED", 0x100000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_PREEMPT", 0x100000000LLU },
+	{ "scx_enq_flags", "SCX_ENQ_PREEMPT_LAZY", 0x800000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_IMMED", 0x200000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_RESCUE", 0x400000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_REENQ", 0x10000000000LLU },
@@ -161,6 +162,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_kick_flags", "SCX_KICK_IDLE", 0x1LLU },
 	{ "scx_kick_flags", "SCX_KICK_PREEMPT", 0x2LLU },
 	{ "scx_kick_flags", "SCX_KICK_WAIT", 0x4LLU },
+	{ "scx_kick_flags", "SCX_KICK_PREEMPT_LAZY", 0x8LLU },
 	{ "scx_opi", "SCX_OPI_BEGIN", 0x0LLU },
 	{ "scx_opi", "SCX_OPI_NORMAL_BEGIN", 0x0LLU },
 	{ "scx_opi", "SCX_OPI_NORMAL_END", 0x21LLU },
@@ -176,7 +178,8 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE", 0x40LLU },
 	{ "scx_ops_flags", "SCX_OPS_ALWAYS_ENQ_IMMED", 0x80LLU },
 	{ "scx_ops_flags", "SCX_OPS_TID_TO_TASK", 0x100LLU },
-	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x1ffLLU },
+	{ "scx_ops_flags", "SCX_OPS_LAZY_SLICE_EXPIRY", 0x200LLU },
+	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x3ffLLU },
 	{ "scx_ops_flags", "__SCX_OPS_INTERNAL_MASK", 0xff00000000000000LLU },
 	{ "scx_ops_flags", "SCX_OPS_HAS_CPU_PREEMPT", 0x100000000000000LLU },
 	{ "scx_ops_state", "SCX_OPSS_NONE", 0x0LLU },
-- 
2.55.0

