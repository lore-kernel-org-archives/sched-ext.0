Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9935AC0E
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445952; cv=fail; b=GeBOnw1kLAHuVw021R9Ijsz7Jc2/wId1pOc5vRoX9vyGdSWmbvoteJb+GhKGwi3idxIcFR2ta/olJ1YA+M4bjS0lr906Czy8I8JkdTjqnAmS/3nqXVkWYI02XzDY0OcPKJNC2LzX3v4QyZs6VuXvAEOTCE8dH6an6qedWFCH2XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445952; c=relaxed/simple;
	bh=o6PCW8wDrIlbvcaa9OHUzjmZnb9v92oIUXu/mtjxj6E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bHg4u7fHkjiT6eKr00wqu9yWD0Wf89eqWiwvmYedqIB23lFlRTyehJwWl6WdYHl2eWIUN3iFG6nrZkNeyWkHhOrekGUEGA/shk+sd0cbefUhWIxPJtZCzepCZFKgkhicsZj9v8o3KtSL9AET1MgZ8r2sdNA8RnDZqmF1rBDDBgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kNvpXh+9; arc=fail smtp.client-ip=52.101.61.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kNvpXh+9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIaT66DqeiV79VbH2cXNOT4x1sKV93dg+y3CndoQbcJLnoc9+XsPzUVSQPAPh6B1JeJ1vb1Dl1RuRa8yZLhGz8QCukb1rx9GouuZF+Tmd5D/jrZ/jQ90VUB1aGPwV55zUQthPtcmacHOba0Sm6bwaW6bm/SvydjDuFhHSNXTGtu9n7iMJhKuHa7ed0qtzu7MygW1fhKwqG4x8onTH6sY92giGn/qmh47Dfj3B9+0kh6fzCcF0CZ2gza8ifXdeoYiYIUy9D5O2g6NxnSUzPG6yT8medqnRQt5XOTIdlBkG7Gqjg3nGgRznywd+xgzetPFFiuptwhX26z6aWp1pDyrww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4Fwzf48o2kmE14yLHtBrv1gvfmLFb9z4PQTowEUOuY=;
 b=iauUj726d0a1FXmvvaGgcofCR6JwxZZym97EXb3baMgKXaZh2dCdoayFQGGCg/VZIy7Ge/DwpanBirDcFkplOZL49RRqUZ90i6/wk8oVaQm/GP8PMs/krYq6rlxD7ys0FkYKVqf7MpGzd1T+S03QleMV3q4xy2iffV0XUvloX2y+vGVg0ieqMiFQE391AzFHpmXMECPgl+pGK6v0nkVcWYyzOL0RjDoS069+Rpdj73t/5/mrE7H8jgSZqBcO+jKPd7vHHrtKDnBkxSMZmgsVkRlcO7LjvOSizkWwLapUm1nkraXYRGqM3Rjf+rL1Z2rHEv5BAKXsqzud4rgxpiywMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4Fwzf48o2kmE14yLHtBrv1gvfmLFb9z4PQTowEUOuY=;
 b=kNvpXh+9OeLtCHxQugnIhP6DDqHTFeeL9r16GYPZEhhr9pCYxnq4AuLkRbjo3mUR5ljTMdLNHSWRkccP/ZhNb7DeSv+zT+njKMkeAb+u1GaRsogysAbXQVKHL25IdtgkhlBeKrL4a6zFc6vRJIMifnWhSCLoXCQF+A0Kuwxp0GPjKksjmci2+El4S7C+EUlDwW96PltpTArn/lfTdwlTC3Ahv2tVfkHqQltcbfMmLk2cxmlJj4VgxEFGjCbNa6HGMMciMtn7zxErlXu11/KmVe/dDrb7Mnixa9amH8OQliGBKhIQiD5To0lpHUvSwxRmIwgTnaGKlgUt1SfeynfYKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 17:39:02 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 17:39:02 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.2-fixes] sched_ext: Preserve rq tracking across local DSQ dispatch
Date: Tue,  7 Jul 2026 19:38:51 +0200
Message-ID: <20260707173851.153379-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF0000753A.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cc) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a635d5-7ce6-4356-3895-08dedc4ea18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	4iE2R9ae49Flb+1gZRqZiAdvXo+51ONSOolib089eHVpJrWgH81/wJoJaC+KUoFW0C1MgehoK3rZEuOovKyxdtmCjIFyCmRGWv5EO1RHYZ/RZKWw14Ji5jWgRmyEjMIclpz/5Ldd/asjwUxngjGaN8JuUjT3EYgnPk3RXdfi3KePtR7++7IrBazeg9IJIa1B9eK7rdwJr+O+83E4mp+TqgXpKk1WmeSNiQ910gv/Z5eGpEVEpEmrM1mM9XldkZBVMOu8HkDnPPGJaZqctEnQOUDvx1ZqlbWXCLHeBi7A1FtJVFHjU5gb2NHSuJnhhisndReLDVODVB+WIlpvU0SpvAvxAcOrAH6EAKmYJYpjIb9AbRmTUfvz1SUEiFS5li9WjJRh53uZ/d6GvO5RR/71TjKl85X8Q/YssxZ2sf1uD25XWqxR5ySKMgWS9166SSZxHerlUdIXelQcDfiP17xsdR2MaepDJm4egxsEYMKQeSAnxEDQU6SQ51QHSAm+QZn4qubOFP0fNg5niqtdz5KncSwFxfzaZYGm1m5q3Bylk+6tfmgW47RKCe/p9wdSUDnHK1xcrwuME2n6HtSusMNLNQ6up7nW3kdqtZHXcgVWl5sNsoDd0EqU4rPfvYUto7zAs4Kmj3HjCbLBrP22zieneQ+40/ouApN9gMiy2m1VIHE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7TKrS18a0DsuT6ErGmfuNj/9k/oEsxjco7+HHOGG9GcL75B2IaZLYhAtUjR?=
 =?us-ascii?Q?OalTAX1TMd1XjldaKnAa13Aig7s23W2K3eVWJxAg7GWU311szmO+mOIKgwBk?=
 =?us-ascii?Q?1YGPG3d22AfVBsMIJzqoMHn4vdOYO3uFnNnEyFNmyIEiYqw0jX2U4QNvfnhw?=
 =?us-ascii?Q?m5wF/NSaf9pqt1VDY+Tx/voBOhZoY1e1ohmj7xIWKPKuYhcnUY0dA1MUj9Iw?=
 =?us-ascii?Q?vdEgYmd8g7sUcG9XFYOz2fWy43yo1YAcw4E1/YNbCpQCzHqWrYyWUB8gLpD2?=
 =?us-ascii?Q?ysxPmGSSzbJeZtoLjEfm5qPImBWEQ7v6g+voBHC47CMw8b90i5KKkLmdrTC0?=
 =?us-ascii?Q?8qqnCU04t7LP88JcJJJh6E6Gvm6caF3euiGos8PSLR1IxNY+8NwqRmMzvogq?=
 =?us-ascii?Q?d7lOC6mjEq4If42GdUctD44zLNeb6i0DG0DWyACJoATduV1qGcGjdnbnlGpJ?=
 =?us-ascii?Q?D4PXLzbCsI+Oyc6Qt7Qr20uCs2QVTAk5L4n7vFimRZse41oFqBpcKX1LIVmk?=
 =?us-ascii?Q?hjUEmj8QtTVGEcgmT1Q9Ahj807IBCudO0fXdROBKfO6tUCNKqQus2ksqZOf0?=
 =?us-ascii?Q?GnTqB6fOuhcfbn0J+vVYnGYVEn1RXM5lQR3tQ5HSSZ+Y28+j0wPzAo3N+2wR?=
 =?us-ascii?Q?7ilEZY1rANCcyzSMkSML7TTXyMkzDbfHoO8D4j0tMIYRxH1FeWSlUDjNHzCP?=
 =?us-ascii?Q?oQLuxJ7R6RwxKwEfyXld21AKo4FQg9wmB/FB/Js2HgKjr2YzY4OxkeZSb/Dc?=
 =?us-ascii?Q?ZH7TwzHI8Qri4obuHHOsXTvWoXJ2VqStttAa7aJfR5xfRqqtKLgWBkSBI4Bg?=
 =?us-ascii?Q?YExUBdipEyS7khd2tiZzILlKzUM6Q6o7vSPar462cyksx3oJ0m9PLT2O3h+M?=
 =?us-ascii?Q?3W0cyG+DWt+UPoaTNkOzzvreAc0JUbrlC0ltZ4tThqI5pOvcFdyGG0v/RlH+?=
 =?us-ascii?Q?Ijy8UA8tqj06s28Na/YrIYQ6ImbQDQEcdYBe8Kq4bU/nWGiwLiw/uva7O6SB?=
 =?us-ascii?Q?QAryH3HvTfzvetqFEJL9XGinrtF40BqTwUP0i/2sryGU1QGPS/EDhU5xJ77v?=
 =?us-ascii?Q?14dTnjQ9ESK5U/AHZ4Fc8TtbJdnepG8j5kQzDxwFYf4zcuqAGG+sOccm0cq6?=
 =?us-ascii?Q?ZuJWZdrhxtV6f2MOMWzggyVZiBviupgdjTNG/WQwujmWyf7FkAOAfWuxx9uW?=
 =?us-ascii?Q?kaWjLBRPeDniKMkYMuUbv7VoWyfvzHAPZhn7zsxqE86LPGufB145fHfyM6wr?=
 =?us-ascii?Q?S+VBayfREcYa0+LiP4wUT561v7TLI1U4Fx5FaiYTW+uCjvOv4pyhYhimaDvU?=
 =?us-ascii?Q?2/gINbKUZvrN5E2uql9pnkxMzV0HoSvg3epje0uhab4ZUGDXof2sFMNBPHzw?=
 =?us-ascii?Q?03Tm2OHTkWt/7aEllJKC8J5IbcBcEXm4o2YCiZRvOygHx8XGJxbwWoOnpwwh?=
 =?us-ascii?Q?l8wWfCSd/rA7MfwUqODIPHILFdTu+BdZYe6L0P0UvaYS5yiMh/q4sUWJyjke?=
 =?us-ascii?Q?08KAmFhlm8sU5SnPBJb4S4ghnAJadIDOUM8f0JllrU3LjkGYycgnBXo9SAKG?=
 =?us-ascii?Q?bQSSHYcOGcMhMRnsoaYQ3RdnSlEO8u2bkc8DO1d6e0pcfL+3gfgU8y73Vcz9?=
 =?us-ascii?Q?s4l5JtszZ5dfgK2+G2ALHFyheefzAVb7GcleXmJhKwL+kiHwJZop/faMsY+l?=
 =?us-ascii?Q?vl3E2Ov920IbLSDy/m+JaZJwePVfZcnRMy3AXiEJf+eeddTdwrl5dM9rV+BA?=
 =?us-ascii?Q?0v58tVzSGQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a635d5-7ce6-4356-3895-08dedc4ea18c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:39:02.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCcR3JitlGG23s1GNsOvD2S3jNebkDBdT73UhKUqdCHu+yJ5mk34cgG+oooHdl5cY6zUNDkVFaBXcmF3rjNPiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214

dispatch_to_local_dsq() can run from scx_bpf_dsq_move_to_local() while
ops.dispatch() has recorded the current rq. Moving a task to a local DSQ
may switch to the source or destination rq before synchronously invoking
ops.dequeue() through the following path:

  SCX_CALL_OP(dispatch, rq)
    ops.dispatch()
      scx_bpf_dsq_move_to_local()
        scx_flush_dispatch_buf()
          finish_dispatch()
            dispatch_to_local_dsq()
              scx_dispatch_enqueue()
                local_dsq_post_enq()
                  call_task_dequeue()
                    SCX_CALL_OP_TASK(dequeue, locked_rq, ...)

The nested callback saves the recorded rq and restores it on return. If
dispatch_to_local_dsq() switched locks, that rq is no longer held and
update_locked_rq() can trigger the following lockdep assertion while
restoring it:

  WARNING: kernel/sched/sched.h:1641 at call_task_dequeue+0x160/0x170
  Call Trace:
    scx_dispatch_enqueue+0x2b0/0x460
    dispatch_to_local_dsq+0x138/0x230
    scx_flush_dispatch_buf+0x1af/0x220
    scx_bpf_dsq_move_to_local___v2+0xe2/0x1c0
    bpf__sched_ext_ops_dispatch+0x4b/0xa7
    do_pick_task_scx+0x3b6/0x910
    __pick_next_task+0x105/0x1f0
    __schedule+0x3e7/0x1980

Clear the tracked rq before switching locks and restore it only after
reacquiring the original rq.

scx_dsq_move() has the same problem when it drops this_rq while
ops.dispatch() is active, so apply the same tracking treatment there too.

Fixes: 7fb39e4eb4c3 ("sched_ext: Save and restore scx_locked_rq across SCX_CALL_OP")
Cc: stable@vger.kernel.org # 7.1+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Apply the same rq tracking fix to scx_dsq_move() (sashiko AI)
 - Link to v1: https://lore.kernel.org/all/20260707135854.1379730-1-arighi@nvidia.com/

 kernel/sched/ext/ext.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e75e2fd5ab7e3..872d1e1f83d14 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2577,6 +2577,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	struct rq *src_rq = task_rq(p);
 	struct rq *dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 	struct rq *locked_rq = rq;
+	struct rq *tracked_rq = scx_locked_rq();
 
 	/*
 	 * We're synchronized against dequeue through DISPATCHING. As @p can't
@@ -2590,6 +2591,16 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		return;
 	}
 
+	/*
+	 * This may be called from an SCX op with @rq recorded as the currently
+	 * locked rq. Clear the tracking while switching rq locks so nested
+	 * callbacks don't restore an rq which isn't locked anymore.
+	 */
+	if (tracked_rq) {
+		WARN_ON_ONCE(tracked_rq != rq);
+		update_locked_rq(NULL);
+	}
+
 	/*
 	 * @p is on a possibly remote @src_rq which we need to lock to move the
 	 * task. If dequeue is in progress, it'd be locking @src_rq and waiting
@@ -2648,6 +2659,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		raw_spin_rq_unlock(locked_rq);
 		raw_spin_rq_lock(rq);
 	}
+	if (tracked_rq)
+		update_locked_rq(tracked_rq);
 }
 
 /**
@@ -8782,7 +8795,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 {
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
 	struct scx_sched *sch;
-	struct rq *this_rq, *src_rq, *locked_rq;
+	struct rq *this_rq, *src_rq, *locked_rq, *tracked_rq;
 	bool dispatched = false;
 	bool in_balance;
 	unsigned long flags;
@@ -8824,6 +8837,18 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	this_rq = this_rq();
 	in_balance = this_rq->scx.flags & SCX_RQ_IN_BALANCE;
 
+	/*
+	 * When called from ops.dispatch(), @this_rq is recorded as the
+	 * currently locked rq. Clear the tracking while switching rq locks so
+	 * nested callbacks don't restore an rq which is no longer locked.
+	 */
+	tracked_rq = scx_locked_rq();
+	if (tracked_rq) {
+		WARN_ON_ONCE(!in_balance);
+		WARN_ON_ONCE(tracked_rq != this_rq);
+		update_locked_rq(NULL);
+	}
+
 	if (in_balance) {
 		if (this_rq != src_rq) {
 			raw_spin_rq_unlock(this_rq);
@@ -8864,6 +8889,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 			raw_spin_rq_unlock(locked_rq);
 			raw_spin_rq_lock(this_rq);
 		}
+		if (tracked_rq)
+			update_locked_rq(tracked_rq);
 	} else {
 		raw_spin_rq_unlock_irqrestore(locked_rq, flags);
 	}
-- 
2.55.0
