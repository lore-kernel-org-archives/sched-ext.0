Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAC4570DC
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253503; cv=fail; b=rjp9gclIwerHHUrfR1EGpQKwkOJjnGablJjU/MiFtXXOPZtPLr2UnpIAuZb0IIJWvrIEpoB9KGwa0/4KeeYcxegFds0258Vi0keVK88fzGfnQzsebpR6obRk9SMp62bjeUgoh6hoFSOt1qcthExij7tXgEUvXXUSxcqFA+wnEEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253503; c=relaxed/simple;
	bh=1TrEjOAmrvfXn4nE8IugAKz7CQ7NDkWAyqzF5iQNTjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SLAipagFZ75JU5OzNjZqrIYA9pVi06gD6isP0BkPUMVnq7ykGO3vgbtRQyMDguE+NxvopeSldSYwVqZfeyyYYAg/L8zIxTzjC2loNWzzL6FxGzMXoYdEoYZX9TOOEnCKVAYhsR2XU+HW1cvUb2eQQFjE17SBM7wE02vUFVGgBpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SxjHcre6; arc=fail smtp.client-ip=52.101.61.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SxjHcre6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGkQbv9va9g45HE1UOV2xIusYRmS+mUMmN3oJut2Nh+GjdGQvdJdLMNJ07AtbPfVJ2ZEkMORSwfQ9U6dDyj6bSQp5pDWTQ7USH1rluH29EeXKB2KLC0E9+7Iqak7itL/IqBDhDnOMRU9+t/R6AF8nkMsdNyqiuch1hQ3PUDym/in+ZD/L7KRMDgMc9PCK9AwLIVjF15P5Pti5Wc90bIypVi+tZlt3r+JiMQ7dornAKQ4RWnkQdxULVtrek6HWkQmOLHhAZBP9ClRWRoKJcZTGApkI5jXtOXWmax/oUpirHGa7h11rRzFI6FlQw8UqK7yjFYNO+yKagUwDge0LLp2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bE/1SFMtvOKYgs40w3oFm3JBOaRmA57vno9QStV9lQ=;
 b=eanSGu5Ii8HLqjFyzXDMx2dQ8HQ6Ms4sVFkcetz325pqKeYLz96NWuMof1xhSEgjkxJxsyHjB2BqQIjCcDjKb5/gb2vlopyryl9skuxS/Q+9ij9DLh4iIFwCwv+F2Vt3lvoIG0cm278Xsawlvi42SmGHDV54tNWIvfUEwqZ1LAk+cHLihd3hbK5wUfy9qmsn+BxsoeohD45pH7tDEWPlnW3RU7Br7XQfw82wt++KhDF7zmZNxKpxDzXP3BS12zemWK7DA6vfHQRb/pyUx0mLKqlKtbheSZzOuS4VCCqREJSzkO8XMX0dQScJkGliSEHYHZvsnn0FSbESQwiY5jxH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bE/1SFMtvOKYgs40w3oFm3JBOaRmA57vno9QStV9lQ=;
 b=SxjHcre6dSJJybm5VV2VvRZ87qiPRKX++AIXMSQy3z8ZWYBwJAaN++vlSjOAMjteNIDTClec37kgRsl7Ge0+1mWCBS1RvCxxsNgbRBW/SrYziS7rnvYVrlHfX4KVnbi/gRLbGBQD0z2fO3oHmRT7j0ZX6RHNw1HBB6RRuo6D0FjiG9l9chKZEJkut/8UDrjNnw/TiC4cacLVdV3+bNMTb53Lw4lvNY4I0IRzXEmLgbLbMyMqtD0N5/g4PFAApMWKq6lM7I7VK/m/o9wBAgkCtO76yQfUm0dY7bZ5Nc3WRTUCYg9b6xR1mTVqOAC99hV8FO8sGSlSAxn0fPrz63pyzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:44:49 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:44:49 +0000
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
Subject: [PATCH 02/15] sched: Make NOHZ CFS bandwidth checks follow proxy donor
Date: Tue, 28 Jul 2026 17:43:20 +0200
Message-ID: <20260728154425.1549660-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 78654306-7356-4360-514e-08deecbf2767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZC+TirUXRF7C3zTRDh/pb4r8Ls3MHYQtJrAv2T4LYjqd3n0s8446nfrqWHJ/0DBJ8LeM3BWAHvKK2QWluW3DxubPdg4Lu5HToUE9+Ko7aDA/J2fRP/EAyQKSFMPte/ntirl8PZFfVzA1vyqnmYZTKsd2WL7TIs6PzZ4IkgWcBST+602kXZJjHyHo6UnbpnLOXXYh3DA9WoxdJhno+JuELJHx0JFI4BqhKhat+9tR7JOsMd61nzGeOxYZBDjTNdWttpwxyTnnquPlwIz/0H5EOzdeFRkKBHqGdt8EUFReJp1RAlId9Yi4qwtLVOsQ3IKhJtquDJsKuFXX/Qxq1f4ZDAlFZlX0w1C1VR2psN0TETa1RCbCMvzz1UX7EiB4X1l15NxCEEgcO/kM0bC6pmVyw54cdDFJBsZ6xYJy6fDM26/xTYiWKVDpSenpQTLSdt5jIzUUKXozynR01de3KaBx77tz0/mnQxnHMooQaNCTZ2ZWPZbd4NRl6dlUHZ4X8wZzQVzDwCcTebO23GBoI0K84f86kHW1OIoH1uNxTaiQCpjdxrCCRSLF1M3HFWBhnEFjy96nkQCnj9OSAS99335l2mx44TMHxboiKKIFrmdJ8npixPKyl9b7TY56C0Lcz6lu/CQarrNVGYWsuHJyXHOA7vRaG4xygYBNK4ZBW9cWswE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2uKfUDXlBckOj9V25MffQGr1P5BakRoj5VI8SWTCT6xo5VlmwF+bM2fMiXYu?=
 =?us-ascii?Q?tK4CG6/eQx+a8uxddK6gL2fPwfi2FemasW4kgYrH9yhbDEkttunL7QE2+MQZ?=
 =?us-ascii?Q?dlh93GyJjkyzmwY03y8r0cPZr8fUOwyYGb3DkHVRMWaAc8M6+GGh2AQMh3Fk?=
 =?us-ascii?Q?MwNnVNCq7vq6Y1+Nr+mLwdI22q2dHHdVOc9kaDjvhap2aNo5aoEwtthmtPCV?=
 =?us-ascii?Q?x95GbTAalKT+bZbRp1n3sRqtglMpiAs6rc/zx0HpgR5oI0U3nXNgAld0c84H?=
 =?us-ascii?Q?3Yt9kuoxb99TEM891mUqcN+qYxZuFYkkn/rTHWBkG07VWuwcTYhngMKKRxpl?=
 =?us-ascii?Q?TtekjHNJnG1YPhN25PE+0iCvQYjvwSVyTA7tJP1Uj7lIJo4pHuH27YWrqvcx?=
 =?us-ascii?Q?8sCc13laoCH+NWdtkazO1PxWPPl6rO+TtjuQOd20UN8xwoOGbNVks+3zsYXY?=
 =?us-ascii?Q?F44dnflXSy13KLhEB7gFbMn3+tKjZCfxbP1RX22nNaX/Nt1fWJZBNB0smLeK?=
 =?us-ascii?Q?bfgtAsFATF2hVHQLm5YuHUZ28Q9my+3Y6ijxl/5SVoQWrTjrJaEeBfrJ4GWK?=
 =?us-ascii?Q?jZeIRzoZReip5/eQu/1QgzMPVnspnsKJdLBmubDASb03IjAZZXvANFJ5OsV8?=
 =?us-ascii?Q?icQtNMmTLFNq5ZT1hkZUSjSSp+lCwz0uiFNcYwHgcmp81t9l9tQtCPOZGeWJ?=
 =?us-ascii?Q?Jgd+pXVCAo36N68N2HuGSi+Te7N2Qz4IDsC8VAQZX6gQvWsXch7Ou4EXYG2q?=
 =?us-ascii?Q?lgLELKL9NNoB/r0+Qu6KYwEDbyksu6xH0Dtr93sadrsxVIEMiLrmP7SvxBHe?=
 =?us-ascii?Q?c13Lgb5UhPZ1d1SdB0/ExAoGDtmeFsOyj7cqEk0I0ZreVprBNNHJURiMrW+t?=
 =?us-ascii?Q?fQVRimsE1qpkH4R7ifh97d1SsO8oTEsjeynqw9k3XGRED372S73vYGaa3UNT?=
 =?us-ascii?Q?6PKMJ/4NcNn1A9KCYQFBxpUtr3vZBUYihgMbTGs2j9zcSRibQDKNIUyu9XR4?=
 =?us-ascii?Q?OZN7RtXZh66NPtnkTCYMrP4Wrf6UAvKX0qLGb7lOVxDVfJbNg7vUMzLwzHYX?=
 =?us-ascii?Q?/xEryV6FRSKAbHVkjA4RSm8rz9uxQjtE4N+2HHU+xS7PCKTRubUO0rP6ymLJ?=
 =?us-ascii?Q?4tw+aWGuKyOqnE+5EVlLGB77l55PcbiqtFcF9l1VWSHIfyFVdrDyrRvQCHBl?=
 =?us-ascii?Q?w8t1XtrIeck1O+AfOb1qAGk4ZUakkD5uLOLL3qIlupZRYnXqCJwZdazZSjtq?=
 =?us-ascii?Q?OLt+OHkGAt6KDEYaN9JQ5XGQTGjAGZ5T5R6Nt5zl26UASjrBOdwrcZ1N/GFM?=
 =?us-ascii?Q?mvtmnJrjjdvJRbuDaZLR3FDtBsjIH3j3IL2bp5sdw+Je3UcFSLRQRwqQ7eil?=
 =?us-ascii?Q?MaHAF4gTQIB/OVzEaHWOdnWDPkRLaXAfAGu9ULijonQ9QKKRKj/6iITg9V0B?=
 =?us-ascii?Q?lcOvU8XWJSqvbsnMoeuUrFoWI+RlPfgaZ4eKQieFyham4eZg6SfoHM/sfadx?=
 =?us-ascii?Q?FCiFxEkhrxg0YqTFHx6UuQycXZM+YgvV061bVjsJ6AqJnA37uCYPh5ZcI+0O?=
 =?us-ascii?Q?UTl0bS00WTJ4YJ1caGSN7TAAZlt9aipBx4Srao2F/5btohpo7L6TGT9sgqcG?=
 =?us-ascii?Q?tDftLNyBuW2Ptd7U1hlfUtKJwuA+eBNnr1rcwAcrmGo2IFxTYPOngggJa2HO?=
 =?us-ascii?Q?Ba7g0nLOGYD+EgIHpDFFiXPvbiFmICH4UW+fnFcDgVkRHsklmJNJLGaGXpJz?=
 =?us-ascii?Q?Fwm1PqB/4A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78654306-7356-4360-514e-08deecbf2767
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:44:47.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fqfhg52jvMFM5XYxsQEUEp51tdUMLEVkohXg3Oi+RSwcC1trnT7IPDiirvUxDCCHQiUPxeVRox3cpvvIEUJ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

Proxy execution separates the scheduling context in rq->donor from the
physical execution context in rq->curr. sched_can_stop_tick() checks the
latter for CFS bandwidth constraints and only does so when nr_running is
one.

A retained proxy donor keeps both the donor and mutex owner queued. The
check therefore misses a constrained FAIR donor and may stop the tick
while its runtime still needs to be enforced.

Check the selected donor instead and remove the nr_running restriction.
The donor being a queued FAIR task is sufficient to require bandwidth
accounting regardless of other runnable tasks.

Fixes: af0c8b2bf67b ("sched: Split scheduler and execution contexts")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260713164807.E5ED21F00A3A@smtp.kernel.org
Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 25 +++++++++----------------
 kernel/sched/fair.c | 12 +++++++-----
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e11fac7f805e7..96b8b01d43101 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1409,11 +1409,8 @@ static void nohz_csd_func(void *info)
 #endif /* CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
-static inline bool __need_bw_check(struct rq *rq, struct task_struct *p)
+static inline bool __need_bw_check(struct task_struct *p)
 {
-	if (rq->nr_running != 1)
-		return false;
-
 	if (p->sched_class != &fair_sched_class)
 		return false;
 
@@ -1431,6 +1428,14 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (rq->dl.dl_nr_running)
 		return false;
 
+	/*
+	 * The selected scheduling context can be a constrained FAIR donor even
+	 * when rq->curr is an RT task. Check it before the RT fast paths below,
+	 * which may report that the tick can stop for a throttled RT context.
+	 */
+	if (__need_bw_check(rq->donor) && cfs_task_bw_constrained(rq->donor))
+		return false;
+
 	/*
 	 * If there are more than one RR tasks, we need the tick to affect the
 	 * actual RR behaviour.
@@ -1461,18 +1466,6 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (rq->cfs.h_nr_queued > 1)
 		return false;
 
-	/*
-	 * If there is one task and it has CFS runtime bandwidth constraints
-	 * and it's on the cpu now we don't want to stop the tick.
-	 * This check prevents clearing the bit if a newly enqueued task here is
-	 * dequeued by migrating while the constrained task continues to run.
-	 * E.g. going from 2->1 without going through pick_next_task().
-	 */
-	if (__need_bw_check(rq, rq->curr)) {
-		if (cfs_task_bw_constrained(rq->curr))
-			return false;
-	}
-
 	return true;
 }
 #endif /* CONFIG_NO_HZ_FULL */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d78467ec6ee13..14c5b2aa01777 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7570,14 +7570,16 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 	if (!tick_nohz_full_cpu(cpu))
 		return;
 
-	if (rq->nr_running != 1)
+	if (rq->cfs.h_nr_queued != 1)
 		return;
 
 	/*
-	 *  We know there is only one task runnable and we've just picked it. The
-	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
-	 *  be otherwise able to stop the tick. Just need to check if we are using
-	 *  bandwidth control.
+	 * We know there is only one FAIR task queued and we've just picked it.
+	 * The normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we
+	 * will be otherwise able to stop the tick. With proxy execution, its
+	 * lock owner may remain runnable in another scheduling class, so
+	 * rq->nr_running can be greater than one. Just need to check if we are
+	 * using bandwidth control.
 	 */
 	if (cfs_task_bw_constrained(p))
 		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
-- 
2.55.0

