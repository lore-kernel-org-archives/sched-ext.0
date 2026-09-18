Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012053.outbound.protection.outlook.com [40.107.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424937B02A
	for <sched-ext@lists.linux.dev>; Fri, 18 Sep 2026 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751768; cv=fail; b=CXnLd7YJQ9mtHgLIF2VT5MwfrW//nvM30YNXPkk/6+XJdW1u08ncSMyQT4kloBx61MECLXH1ReyjoiEfeuLrqH7bIUkZLRV+BaS1xzz/TDpX0MzxL0smQwt4RW0oXtjgkcEObEwjwTIlxKvOSlSaWsMYHZhsXjSs6An8x7xSlmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751768; c=relaxed/simple;
	bh=ctymZGXIHEt2tFyxjllR/EFsLtvsoIXKh4k1yDdEk9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HPn/aQDCWK+LK4bNdp/xlc3uZX6sPptvFNxZrsjsx/ybK14q4iEtvmeO5cQ2fIySN8kP7p9WfjNVTQMLmgs1A8E6kTSZ9cEgX3BMMb+UeoOC70KpzPEJ9kFBCpeQOuMA+F91gMVSVpMMc/ksbopJKqdczYzWGxSJSBrj1koEi64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bgIdZN0s; arc=fail smtp.client-ip=40.107.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bgIdZN0s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/RP1DnAjLGEwNk55pg2qqkaj81QsdT7pB9xg9NgnIEp/FF5iWHh6AuRX4i3/QmL/dmUQnBu7UhHF/3rNy0OSHhaD4bn3QUWpg3Q4IFUl8BOLEdZVZIL+G+GWJazgYs+fYnuRobdSqaVQUjj03LYJ8RzWtjFNJ9fGGO1a1TTtNftTHiJFgW31/WEe3/Ux6L/GDcb48BxhRzk2B3DYCbUEp4/rhQad/A0d+23xgvqkQL1FKUkSoSoM9PCMlDKJW9Eon2SV/kd+d+9FMUAPehAF9nN9yl6KQjyRtBFvR779IcgAeE8k2gABgGR5Pe6H0mUUOXIvq59bk7LAd+RRizLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEufaphDFrglfx77IoqCK4VhGkZWaVEGeJ7Jygw1L+k=;
 b=KaX1Ns4eBj7fwjF9NNB3cGQV8UJV1g1mWhFc5TJaV/j5X/uPBiNS5u6Lpytpi0PzVct4wGFawS3oCSxuYxLhjiuS7DUJNOOKCooOSrx+1RCpgFxGUPNR2mw5QapLx2elKTDf1ioYK14ZMJX7H64a+64LIH9TMBBGthEpRL66JWE5/an/ME8Q0FNEDu9mzAA9fVxzlnNdRXji9Z1e/tVH+mf8C3K1aGwv8nwp40XKZOOTlOEk30yQhnQD+YhfCJMeXBwX73zjB7tOVCW6PmqGN4kGY1KK6IjnopCRzldUkYoRHqgEwibzozA8NP9qs9bDP679Dm2hEfB/bX1ssLmyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEufaphDFrglfx77IoqCK4VhGkZWaVEGeJ7Jygw1L+k=;
 b=bgIdZN0sanJX1c8IhqJivRhURgN2aFH+r073OnYx/dVCuIijKoiblT3RM1tGmrCa7VZ+OOrLXToEMXulshAQ+ZvepzJzEgN0Hhmnsxq88IQa7PJxmjl0KPsko8w40Q0vgC/4Ng9Ylc3ntj3P7uuLfKHyK3DqZoxtuHK4ouAtk+XTo+N3snF1ttkjTjeRg7T4QL0VY+G+kUcPER7srK7iGxubXhkLTPNCAhiokxo3CIlcLDyiDEGKxpaC5aXIL4NjufsuZDEhVyt3CnumTIrJ/awRb34hDwuMRLNaCvJaZGCxdMHAdz9xQOrPm3WJPEkLAJfdIsTU6lUjlmvZDqx2Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV2PR12MB919616.namprd12.prod.outlook.com (2603:10b6:408:417::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 17:15:57 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 17:15:55 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <etsal@meta.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Tao Cui <cui.tao@linux.dev>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Add lazy preemption support
Date: Fri, 18 Sep 2026 19:13:27 +0200
Message-ID: <20260918171539.214204-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918171539.214204-1-arighi@nvidia.com>
References: <20260918171539.214204-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::31) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV2PR12MB919616:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1a6efb-f223-447c-661e-08df15a87fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|6133799003|11063799006|5023799004|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZowKF6dSxygzLbZRt7GwgPfRCpsGEaZn62ifPgNbI1OP4tNSA/aqFKG2K96E9Nm9FHbxAsRHnoGYy3/ksyBADzVKg/xLUPAKBA+RK+eAHvSmrYbIRjGwIaOR7bxFwYNEBlubKoHmfSsyF5RQjgQ7YQ+fYHVhKhowiWvsMiXonVJdf5qZJMds78LE8ddwwBoSqWxS8WSeVvb0C6AKwblWhuks34JWMOosSJ291MG9iccBvMnrxbE8A/iTa7XCNL6/QTefXvTRhU22h9H3Tp/9UtizsGtnjwVBrC9ZIcCbIWIztMhpxp0ncaWWB7ncs9qyQxOQXSlgbqw0z4HL+WqRrm42dSaRmVx3godgX72/6cOl4sgxvCXhMKtKpbUkVWXGo+JrpMkgRHhLUS7MIZ34V6w6bLrU3tpW3tyGVElZmtmMHCrP7m2a3qNNXbJakEcg8JHzz97XGCY4MDSYJAHkHiaoJLTmx7l9UKsAZs8/xJT8lCFFJnPputygxyXeKOgW/E+UxU8CQ/i1dkDzHO7l2VPJRkouhIfkQYvzdu5ZKgHgCrrbglXN05EmbPvEZFPQSOBvFSkPESIP/1MflnT3cP47GCIpOobrkX28cY44r7cKMF7/8SJD41j0woIdHDx0QbMDWbBX8UnyJP6y/DpJ2kP8IHlRWOeKnUPyJ/l26Ts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6AE3abslXZ7kAu7cMzUHOz/ALEtf86LUMswoT2Lo/1D9SEQnHZslsRUEWhwe?=
 =?us-ascii?Q?O7b9m2sQksiVT4N8RbRnQhLfj2lUdSWeSv7947qp82HVevJkoAKmgzTlwKiP?=
 =?us-ascii?Q?P4PKLzergXt2d2aZpXv7KNQDSYX2KvQaEbhpKvoeiGir5UZyuWvJ+XHVzXTg?=
 =?us-ascii?Q?Zf94yasBoX8GNxr3VbIuLHFo68GI245MhiLd9R0O2r21gDwkIpRhFGEqdHKb?=
 =?us-ascii?Q?3z1+NH+c9i82Fz+jI1PyNNW95FAe4YO+3QzGt1ltUaNvdTTVnO42zmYR1CQJ?=
 =?us-ascii?Q?BKRyj/eKKkc+n8clHeOcE9YvIGIWtqse+/eqSoupI1D3z9oI/VCwhtP4b5iW?=
 =?us-ascii?Q?RxMQuADo8fHYRtsIzHdVKMFB0nbjPQskG7pUTzMMbUEhAm3A8lULiZ3nURd4?=
 =?us-ascii?Q?wP4IAN8jx3XNfkNbOzFm76pHpaiDntM1nnI7TavjM0RVS/pRfklv6aP0TUMb?=
 =?us-ascii?Q?YevWRt6JJQoDLslEgzOWZHLtcFXTYfgqw8b4xFWXNK+fM0rHs7qqhMsvDnFv?=
 =?us-ascii?Q?b2WdKitGPiziCcjJrxg6YXAKNG7lgI4ZWn5oY3IZrqizrBKc55ljqs9jV1Pc?=
 =?us-ascii?Q?3zYhVTVS1L0yahD4oGIFdNqqezOwdmWS+Hssn/w+VklM9GpcncrABVSJZduo?=
 =?us-ascii?Q?2tXfE2sYpX/qLT0XUVYvcKF0eBbbhFFVmuBQ9k1bqrcFA+Acby2WIsZAR8tH?=
 =?us-ascii?Q?nmPveiH5jzzK5J0f8JC0Z898Z86yQc31lThd8zEc88CBxdtirJCsyw9WX1WW?=
 =?us-ascii?Q?gCATR2I4fV5CcbfJJgb6Zjh79cjx1ZW74J56cHqpYcjgTlx+hW+on0MF7DjV?=
 =?us-ascii?Q?eJkfxTjscmrhJB1R34V/DFveG14Gi43i7IIQvxdzIT7QczYjo7q2Nd3POMPT?=
 =?us-ascii?Q?8CXngFvNsHu/NMebHX9owEgLbxLvxvghaDUeLbmtIa05cpBI1Ed6dymRgZ1o?=
 =?us-ascii?Q?9iM7cfVHlLnkKAvB07iaCx1HgsPNO9JCxEx9xiiZlkO/eBZSsg2hgMLz/PKj?=
 =?us-ascii?Q?HXK114Ds6I1mP40EbKsKzJAWBh3b34g6Tk9/5tuQSBjSZD/qlZfR8HBX/PYq?=
 =?us-ascii?Q?rlZgzPq7x1uUxQTp1SdxphqoQOV3SDTRGb+D9GOClafWwm5xmk8egdpks4A9?=
 =?us-ascii?Q?h53i74hlOP9Xk8wLdUnhkVw+NtnphKsq2aA0PNtq2qIf0g3PsswIw5WxBc5C?=
 =?us-ascii?Q?3scp5PnKK147z4zTR5w4lh+XxHTX9E+AJgVRUXeibnDe7PQQydem188vRaQN?=
 =?us-ascii?Q?fI+DRkqfOUEKVF78fpuRJs+9jW/6hPesWc7zOq4Pi4dnTZp0ujF27ltwwApW?=
 =?us-ascii?Q?vsT3ZsF4LJt0eczd9Xu/TAa3g8fAlIPskppRSDHhLzEaLkigKrJxX8Lfy3kO?=
 =?us-ascii?Q?O9xHT0emvVhyjlR5WLn59/u0Nm4VDnY+SWE9Pi3Cbrujw8CO8S3rE33veS7f?=
 =?us-ascii?Q?EBffeQB0iRxeYrXY7LWZerXwsB866XLIBI8F+GvOMAJIXOBajpRFHC3t6VJ/?=
 =?us-ascii?Q?YrlraUkINNfOfXPSLlh2tIsB7JOY65c1eI7RZ7vwLxU5ZJsu+LZbX/0j08UB?=
 =?us-ascii?Q?qa+GBroxLZ7jJHyKw5Ga+g5RVoNm/GnIRwVBh7ytJwzvIiNlMzpaX+Rv7A9X?=
 =?us-ascii?Q?JCY5U41G0KWjfCDtLlLtdg6Dj5Ff+xDUxp2UFI8f66bKKHr5FMbrw/CmJx+r?=
 =?us-ascii?Q?LRyv4ZNVPmMQEuPYBJ1F7AK/EACSMqQoxOQNRC+8uPkI0TShrG/McLGQWfXX?=
 =?us-ascii?Q?KhLHzCKu9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1a6efb-f223-447c-661e-08df15a87fdb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 17:15:55.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MlRTIFN26Ipn4j6acC3X3l4el6OuJu8ro2+AVWOSkfqEs85z2BgEKgmphgF8WvLWFkLMi46Ae7WLcQGouPmNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB919616

The fair scheduling class can request lazy rescheduling, deferring an
in-kernel scheduling boundary until returning to user space or until the
next scheduler tick. sched_ext only exposes immediate preemption,
preventing BPF schedulers from making the same trade-off.

Add SCX_ENQ_PREEMPT_LAZY and SCX_KICK_PREEMPT_LAZY. Both expire the
current sched_ext task slice but request lazy rescheduling. Immediate
preemption, WAIT and plain kicks take precedence when requests are
combined, while a lazy enqueue to a non-local DSQ retains the
head-insertion semantics of SCX_ENQ_PREEMPT.

Add SCX_OPS_LAZY_RESCHED as the default slice-expiry policy for newly
enabled tasks and initialize it before ops.enable(). Add
scx_bpf_task_set_lazy_resched() so the owning scheduler can override the
persistent policy per task from any callback while preserving
sub-scheduler task ownership boundaries. Bypass continues to force
immediate rescheduling.

For an infinite-slice task whose tick is stopped, set the lazy
reschedule request before restoring the scheduler tick dependency. This
lets the dependency update's IPI serve the request on return to user
space and guarantees that the next tick promotes it otherwise. Use
pinned rq locking for remote kick delivery so RQCF_UPDATED reflects
clock updates since lock acquisition.

Accumulate kick requests independently and resolve precedence while
holding the target rq lock. Reject invalid SCX_KICK_IDLE combinations
and unknown kick flags, which were previously silently ignored.

Tested-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                     |   8 +
 kernel/sched/ext/ext.c                        | 151 +++++++++++++++---
 kernel/sched/ext/internal.h                   |  44 ++++-
 kernel/sched/ext/sub.c                        |  15 +-
 tools/sched_ext/include/scx/compat.bpf.h      |   9 ++
 .../sched_ext/include/scx/enum_defs.autogen.h |   4 +
 .../sched_ext/include/scx/enums.autogen.bpf.h |   9 ++
 tools/sched_ext/include/scx/enums.autogen.h   |   3 +
 .../sched_ext/include/scx/enums_abi.autogen.h |   6 +-
 9 files changed, 212 insertions(+), 37 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 8de69843c2150..1e1fc3312bc40 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -278,6 +278,14 @@ struct sched_ext_entity {
 	 */
 	bool			disallow;	/* reject switching into SCX */
 
+	/*
+	 * If set, depletion of this task's slice at the scheduler tick requests
+	 * lazy instead of immediate rescheduling. Initialized from
+	 * %SCX_OPS_LAZY_RESCHED immediately before ops.enable() and may be
+	 * modified afterwards with scx_bpf_task_set_lazy_resched().
+	 */
+	bool			lazy_resched;
+
 	/* cold fields */
 #ifdef CONFIG_EXT_GROUP_SCHED
 	struct cgroup		*cgrp_moving_from;
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4080902a528cd..8d7d43e7bb800 100644
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
+		if (READ_ONCE(curr->scx.lazy_resched) &&
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
+	p->scx.lazy_resched = sch->ops.flags & SCX_OPS_LAZY_RESCHED;
 
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
@@ -8560,7 +8615,8 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 	list_for_each_entry_safe(pcpu, tmp, &this_scx->sched_pcpus_to_kick, to_kick_node) {
 		list_del_init(&pcpu->to_kick_node);
 
-		for_each_cpu(cpu, pcpu->cpus_to_kick) {
+		for_each_cpu_or(cpu, pcpu->cpus_to_kick,
+				pcpu->cpus_to_preempt_lazy) {
 			should_wait |= kick_one_cpu(cpu, pcpu, this_rq, ksyncs);
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick);
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
@@ -9531,6 +9587,41 @@ __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
 	return true;
 }
 
+/**
+ * scx_bpf_task_set_lazy_resched - Set task's tick reschedule mode
+ * @p: task of interest
+ * @lazy: whether slice expiry should request lazy rescheduling
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Choose whether depletion of @p's slice at the scheduler tick requests lazy
+ * or immediate rescheduling. This is a persistent per-task policy and does not
+ * itself clear @p's slice or request rescheduling, unlike the
+ * %SCX_ENQ_PREEMPT_LAZY and %SCX_KICK_PREEMPT_LAZY one-shot operations.
+ *
+ * With lazy rescheduling enabled, a task interrupted in user space still
+ * reschedules before returning to user space. A task interrupted in the kernel
+ * may continue until its next return to user space or the next scheduler tick,
+ * which promotes the request. If lazy preemption is disabled at runtime, the
+ * request behaves like an immediate reschedule.
+ *
+ * @p must be on the calling scheduler.
+ *
+ * Return %true on success, %false if @p is not on the calling scheduler.
+ */
+__bpf_kfunc bool scx_bpf_task_set_lazy_resched(struct task_struct *p, bool lazy,
+					       const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
+		return false;
+
+	WRITE_ONCE(p->scx.lazy_resched, lazy);
+	return true;
+}
+
 void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 {
 	struct scx_sched_pcpu *pcpu;
@@ -9539,6 +9630,10 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 
 	if (!scx_kf_allowed_ctx(sch))
 		return;
+	if (unlikely(flags & ~SCX_KICK_ALL_FLAGS)) {
+		scx_error(sch, "invalid kick flags 0x%llx", flags);
+		return;
+	}
 
 	local_irq_save(irq_flags);
 
@@ -9564,7 +9659,8 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	if (flags & SCX_KICK_IDLE) {
 		struct rq *target_rq = cpu_rq(cpu);
 
-		if (unlikely(flags & (SCX_KICK_PREEMPT | SCX_KICK_WAIT)))
+		if (unlikely(flags & (SCX_KICK_PREEMPT | SCX_KICK_PREEMPT_LAZY |
+				     SCX_KICK_WAIT)))
 			scx_error(sch, "PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
 
 		if (raw_spin_rq_trylock(target_rq)) {
@@ -9578,12 +9674,15 @@ void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
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
@@ -9623,8 +9722,9 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
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
@@ -10691,6 +10791,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
+BTF_ID_FLAGS(func, scx_bpf_task_set_lazy_resched, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_kick_cid, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued, KF_IMPLICIT_ARGS)
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index e1eb3a0d456cb..dbe48eed40ebd 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -215,6 +215,21 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_TID_TO_TASK		= 1LLU << 8,
 
+	/*
+	 * If set, tasks default to requesting lazy rescheduling when their slice
+	 * runs out at the tick, the way fair.c expires a slice from update_curr().
+	 * The default is copied to p->scx.lazy_resched immediately before
+	 * ops.enable(), after which scx_bpf_task_set_lazy_resched() may override it
+	 * per task.
+	 *
+	 * A task in user space still reschedules on the way back from the tick; a
+	 * task in the kernel runs on to its next return to user space or to the
+	 * next tick, which promotes the request. When lazy preemption is disabled
+	 * at runtime, the request behaves like an immediate reschedule.
+	 * Rescheduling while bypassing stays immediate.
+	 */
+	SCX_OPS_LAZY_RESCHED		= 1LLU << 9,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
@@ -223,7 +238,8 @@ enum scx_ops_flags {
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
 					  SCX_OPS_ALWAYS_ENQ_IMMED |
-					  SCX_OPS_TID_TO_TASK,
+					  SCX_OPS_TID_TO_TASK |
+					  SCX_OPS_LAZY_RESCHED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
@@ -1327,6 +1343,7 @@ struct scx_sched_pcpu {
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
 	cpumask_var_t		cpus_to_preempt;
+	cpumask_var_t		cpus_to_preempt_lazy;
 	cpumask_var_t		cpus_to_wait;
 	struct list_head	to_kick_node;
 
@@ -1407,15 +1424,16 @@ struct scx_sched_pnode {
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
@@ -1685,6 +1703,15 @@ enum scx_enq_flags {
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
@@ -1811,6 +1838,15 @@ enum scx_kick_flags {
 	 * is not on SCX.
 	 */
 	SCX_KICK_WAIT		= 1LLU << 2,
+
+	/*
+	 * Like %SCX_KICK_PREEMPT, but request lazy rescheduling. If combined
+	 * with %SCX_KICK_PREEMPT or %SCX_KICK_WAIT, rescheduling is immediate.
+	 */
+	SCX_KICK_PREEMPT_LAZY	= 1LLU << 3,
+
+	SCX_KICK_ALL_FLAGS	= SCX_KICK_IDLE | SCX_KICK_PREEMPT |
+				  SCX_KICK_WAIT | SCX_KICK_PREEMPT_LAZY,
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
index 6944221f96cc0..7d870331b2a6b 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -403,6 +403,15 @@ static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
 		p->scx.dsq_vtime = vtime;
 }
 
+/* v7.4: Add scx_bpf_task_set_lazy_resched(). */
+bool scx_bpf_task_set_lazy_resched___new(struct task_struct *p, bool lazy) __ksym __weak;
+
+static inline void scx_bpf_task_set_lazy_resched(struct task_struct *p, bool lazy)
+{
+	if (bpf_ksym_exists(scx_bpf_task_set_lazy_resched___new))
+		scx_bpf_task_set_lazy_resched___new(p, lazy);
+}
+
 /*
  * v7.1: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. This
  * will eventually deprecate scx_bpf_reenqueue_local().
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 63b6b14b19bd4..92501498f6a36 100644
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
@@ -149,6 +150,8 @@
 #define HAVE_SCX_KICK_IDLE
 #define HAVE_SCX_KICK_PREEMPT
 #define HAVE_SCX_KICK_WAIT
+#define HAVE_SCX_KICK_PREEMPT_LAZY
+#define HAVE_SCX_KICK_ALL_FLAGS
 #define HAVE_SCX_OPI_BEGIN
 #define HAVE_SCX_OPI_NORMAL_BEGIN
 #define HAVE_SCX_OPI_NORMAL_END
@@ -164,6 +167,7 @@
 #define HAVE_SCX_OPS_BUILTIN_IDLE_PER_NODE
 #define HAVE_SCX_OPS_ALWAYS_ENQ_IMMED
 #define HAVE_SCX_OPS_TID_TO_TASK
+#define HAVE_SCX_OPS_LAZY_RESCHED
 #define HAVE_SCX_OPS_ALL_FLAGS
 #define HAVE___SCX_OPS_INTERNAL_MASK
 #define HAVE_SCX_OPS_HAS_CPU_PREEMPT
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 7268131010de3..21e1a79d5ecda 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -112,6 +112,12 @@ const volatile u64 __SCX_KICK_PREEMPT __weak;
 const volatile u64 __SCX_KICK_WAIT __weak;
 #define SCX_KICK_WAIT __SCX_KICK_WAIT
 
+const volatile u64 __SCX_KICK_PREEMPT_LAZY __weak;
+#define SCX_KICK_PREEMPT_LAZY __SCX_KICK_PREEMPT_LAZY
+
+const volatile u64 __SCX_KICK_ALL_FLAGS __weak;
+#define SCX_KICK_ALL_FLAGS __SCX_KICK_ALL_FLAGS
+
 const volatile u64 __SCX_ENQ_WAKEUP __weak;
 #define SCX_ENQ_WAKEUP __SCX_ENQ_WAKEUP
 
@@ -121,6 +127,9 @@ const volatile u64 __SCX_ENQ_HEAD __weak;
 const volatile u64 __SCX_ENQ_PREEMPT __weak;
 #define SCX_ENQ_PREEMPT __SCX_ENQ_PREEMPT
 
+const volatile u64 __SCX_ENQ_PREEMPT_LAZY __weak;
+#define SCX_ENQ_PREEMPT_LAZY __SCX_ENQ_PREEMPT_LAZY
+
 const volatile u64 __SCX_ENQ_IMMED __weak;
 #define SCX_ENQ_IMMED __SCX_ENQ_IMMED
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index e616326545172..6e0f6a3a219ac 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -41,9 +41,12 @@
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_IDLE); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_PREEMPT); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_WAIT); \
+	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_PREEMPT_LAZY); \
+	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_ALL_FLAGS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_WAKEUP); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_HEAD); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT_LAZY); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_RESCUE); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index d53899764f5ac..f1bb6d70bf1d7 100644
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
@@ -161,6 +162,8 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_kick_flags", "SCX_KICK_IDLE", 0x1LLU },
 	{ "scx_kick_flags", "SCX_KICK_PREEMPT", 0x2LLU },
 	{ "scx_kick_flags", "SCX_KICK_WAIT", 0x4LLU },
+	{ "scx_kick_flags", "SCX_KICK_PREEMPT_LAZY", 0x8LLU },
+	{ "scx_kick_flags", "SCX_KICK_ALL_FLAGS", 0xfLLU },
 	{ "scx_opi", "SCX_OPI_BEGIN", 0x0LLU },
 	{ "scx_opi", "SCX_OPI_NORMAL_BEGIN", 0x0LLU },
 	{ "scx_opi", "SCX_OPI_NORMAL_END", 0x21LLU },
@@ -176,7 +179,8 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ops_flags", "SCX_OPS_BUILTIN_IDLE_PER_NODE", 0x40LLU },
 	{ "scx_ops_flags", "SCX_OPS_ALWAYS_ENQ_IMMED", 0x80LLU },
 	{ "scx_ops_flags", "SCX_OPS_TID_TO_TASK", 0x100LLU },
-	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x1ffLLU },
+	{ "scx_ops_flags", "SCX_OPS_LAZY_RESCHED", 0x200LLU },
+	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x3ffLLU },
 	{ "scx_ops_flags", "__SCX_OPS_INTERNAL_MASK", 0xff00000000000000LLU },
 	{ "scx_ops_flags", "SCX_OPS_HAS_CPU_PREEMPT", 0x100000000000000LLU },
 	{ "scx_ops_state", "SCX_OPSS_NONE", 0x0LLU },
-- 
2.55.0

