Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE83A718C
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901877; cv=fail; b=BI6s957NVU7bGyrf+KQsq5uZ5jDZqzN3jXNSCezB6T1b9G0Rpeu4+QcwyuSLhsvqVFb9ltzRRaMYGqm0IYNzAfiWLnNjdnzSV/PHR70EEE0WTEqA4lwS/hBCvr64UVHkjD2vyHHcV9yuC9RAnZpqN4u6ewmVuNCq/WxxG+SWo20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901877; c=relaxed/simple;
	bh=30yzwI1SGGASiWHRW/QeYgT2EhDYmyWWk2SJfWxWpGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKf1E4Ac+UqGP6J7GKJK9HiZ3enTnSYaIgwPSetsvapO4snGqg+z2uGYF2T/tMbBK5DbIYwpgjD7R66LoIPk3YPokzzVNHsE+cbTSzt/KhmQUc/ryfteN28hZcREaYUt0D+DUONA4/zihLa3ORFF+Gy2CMbQBwMPftpL+EsYBdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BwoAn/ik; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BwoAn/ik"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxsEG5UovMIOpHQDjjRVkYnV3GI2cCjfSk9LiRISznbgxyduvbjUrTHu8caIy1UlQkt+2irITv01vRVJ75bhv2QoVTRB+yPLUNQM6sCCj3HjO2TY7/N4w8KVD2a5Yq8b6TH5JOFiCvZacNVyLyiLRmsdRRul/doCHVeOT5m+Rer0TcNOyzujvWsRf6M2kki6axITV+ZUUB1BxmwgVHpkWR1nHPH3Uh/K7AgD/l7ZV2bQBvLjq/xXe49vaUx1zczNtFTgCoIc285mQDcraIZ1N/SJJ4sahy/DZm2skH+H5Im/a6BdmYgAlgBmTWQnJcQbvQ4bEKWIvWv9jMB78xn1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wE0TmHHw/lctRDFaFxl8mDDKoPTTGvsDGJYmmbpoK0=;
 b=yNqiNhPpzsok/nsxTbJdYNMSsw4Zc1H+ZKYZyrkq8UJ2qXGKH36M8McWuStzmFVeed9HP4Ads/CfzO8YoIo5Q+7gk/9Cu5ZzCaQN03OcaM9LbOyAaAsVsYyCPm/fw6icZVIsHncfNIsZbe6lTl9LKZXCP51an2CARU4CUXpl2Fht/lTSNcA5jOYqZvSqgCyMtQnADIKP1zaS0WaeEvBSBO3WI3O66MNrHRBzTrgBmNiyQKxvsxnmGhPobNCUrcdGz8t/Z27bKHMRhQd75OYWwt5h3FkfTl/f2rCwYVe7xmoHYzGAClUY0zfzPNIV82FDEBM1m1WTqQGXHIKsOipdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wE0TmHHw/lctRDFaFxl8mDDKoPTTGvsDGJYmmbpoK0=;
 b=BwoAn/ikk5BVmOdk/jHUQOcHSTwG5zcCkqIAMMjnaKXmYZfA2BgvwpLkfwcDL/6E9TGd27HuBGXKmlsQgsP5c4HUhAU5nW8FxzuTR1qypD+m0VA5Jtc+Zf66NZF7piFDFLPbtr6/SknqqxfeDgNR9s3fNODjI3oxcV/T2tA62it1ariNrEN55pnvTL3YbBxVs/BYkWq/YF15ihA3ilzEbGnw+Gtj50+F1+6oHXBDiEcZ8E0s2lwdIaih48FFjc3EFwlw1BpA0QOyPCMEBYBmD4xHRFyRNAyrkWXthCh4Vpq9zx/WIl+GYwMWz38mIgUA4TSkMPQEfhDDsyGNkMgjzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:37:52 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:37:52 +0000
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
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] sched: Make NOHZ CFS bandwidth checks follow proxy donor
Date: Sun, 16 Aug 2026 19:35:01 +0200
Message-ID: <20260816173732.17162-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E9E.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::455) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbdd719-3b5d-41fd-0b5e-08defbbd18f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	MTQ+CZ/aCI6kKbVhAwe2J7YajK/faeeNapNkcJKFNq4B3i9UZLFZ4rIdZHP6etzYZCvUfk29Xhv3aXflds768C2HQ0s+Fl26V9n4ylL3oP2HRVAh+LWe+yyqiPZBD5MizZL89su/IxEUxHq2Dako7Gns46BsQOajyf7m8Uq9z8iD09OhyrmxaW+Ugec0wFZLyClaCsAko4m/2/X/Pe9NrtDbfOvB/anH5fMWoDCxXojmL6U2rbGX3A7canQ8FP8Ad8Ea2e/6IBoucjE8ZK+upPY7iW1yu91cMXrJAkfA5AG6dwRVZ5xJhtqM8TGG1UNJ/B9w17/2ztOuy3cAorWGLxrLvYx/vKqPCKei5odoViz7UICRdVblW0f6PiKHHy5BbJ+jOl/YNzf8X8sbfczy+Lx6LAtYLDGrkjSJuZ4SXhovmZ09NT5GjUJ8bUMZRIyzewP0XWuaS6qHGoRib2vPfr1NJbvDWTo56+nYl9e78OmZnQ3q3PQBXDCFiYYiUKdHbAFBUJQyXvkUjgOnpLEpucSDmCS60QKu/NWq1F94vcrfeKKQMncCuWaOCVzHU/llaHFI/MkU5gcmZQ5bflDrKjK0rswD6KRja3kmGNQC3R83zeb1uK7JEAMezyCLY07DVZ0ZrvdptjVOgDnLFfOK02GAHtfjf9WMYZaeqoYUu6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Q5pb9bKV0sw5a/ENISm1G0RRoOtJ1jmPx27mCxqA52UfC2VwjU4aVIAoGds?=
 =?us-ascii?Q?dglmwJpmsVc6y28btd531gh2RN4NhK5mESg1ZdnKOOewzEMrxi8w4KbrZ/yg?=
 =?us-ascii?Q?Up9A+P+TSBHaRmdhyneqS5l1xQz+IAGV5tf90cBHumPpOmO1Rf7iHowZoDf1?=
 =?us-ascii?Q?aa8+I7xbcDwyzXAO/vw2a1re9ZAUvY8CORfFsSvMTwTMreKFfQW6nRW/FNzH?=
 =?us-ascii?Q?+TLD/ZvocFGkcUhA1hLFsDJT4TdYd45JC0tl/k35WQ7ijOf6aH5OIvfwtzKz?=
 =?us-ascii?Q?77YKosHHPwizYWKIrfkf8Atl0VTLYLRnj+JBdab/zRn9qDZz3AbhOe/OPWCS?=
 =?us-ascii?Q?zyBHWeoFUCI9onqnBTRu+k/3zqaKTjbOhubmhbO8SCh/bJLgXfHTretHtikF?=
 =?us-ascii?Q?zVP1nHAxAcmAyG6irUFYvpPeYzxq/VI+odsnmMCCrh+dZMLostPVWTSQqOGI?=
 =?us-ascii?Q?LMCy9t+A0HSGGf2bh2KSemSHQrx3lCo+YEkjKcl8ua2YjgJMa/Vm3mJhjPG3?=
 =?us-ascii?Q?+euys2EiQxYWCeCAPPh1+I4BDmncbMrYl5z29I1cedKs5yphLqBc7JreV04r?=
 =?us-ascii?Q?ocvV/As4ZDaK0/FSzHly/qDjDZehKMUgqfxMuZWYKrFNl0kSDe1yKt7vnvnq?=
 =?us-ascii?Q?ijDjXz0glJmVxttmTXG8GdRn+tP5yIixOZ5VtyGtTQewwUcm3zBALv3r1oY0?=
 =?us-ascii?Q?1uO8AbdVsWmNvuC8o5JKej3lFbL9Kgxb8kfVzkRFXkJClcIXKrv9hlXrxfl1?=
 =?us-ascii?Q?XWxVs9NhqwJRr3I4mZmqO8I+MwnY2++CNJfpBwl6NhVuBvhmiX5zfuqsh8ZG?=
 =?us-ascii?Q?QV0TL2prh3oRbulQxs9wFFzb1m++hF9MVCFxzx1XTLYUFij3cfxwsNut6tiU?=
 =?us-ascii?Q?kRZcAWfqR+EbT1yqVrEGN2djspm2bybtbTRGb2Ry9YRdUwQi0ulfGMs0iFqX?=
 =?us-ascii?Q?v/EsuLdhi8L2atdHpFXNTEHbO0wXzkkU0JBwgyP5/91pXlPkAcnULa50B1zo?=
 =?us-ascii?Q?UflpR4zLaUjyqkI7nmBrorWZXupJGwCf3413ZEJsYh4o88A81+4Vfg82tF2I?=
 =?us-ascii?Q?A+mUy5u53wMsz5eyEUSuMS9yLzwk4baunYhsQcpwtIHltl3Mewed27RBk525?=
 =?us-ascii?Q?/L4ivy5VHsQVZ1S+DBFMCGDWOz5bXe202gfVZ/79Pk/v4cyTTyw/XlCV0e5C?=
 =?us-ascii?Q?xnQB4yt78o0K5+Y8py4y952phb1471OXg05YcKgAtDshLndLwgpeMsOfffkP?=
 =?us-ascii?Q?zDYj8sjgyFAVuVtFBbgRSX6I2PyaiVUys3IzgBD2Oo/Zf3G7gmPPieyoDiEc?=
 =?us-ascii?Q?ZJBrRVguU0TMimVRrl6avkzNrGwSwOWnSf8JN497kiYyWPTD8j3as8jA7AuZ?=
 =?us-ascii?Q?a0X9D/VayCmsX37mpOO0GndISeJFdmiGAOaw5kxh1PozVo18myJievUt08m+?=
 =?us-ascii?Q?a5yzXTkdT6Pgnb/tcXfGbxTXHDW9HjqgBCS2OcIZ//2m5yKoynFMJhxoia2e?=
 =?us-ascii?Q?PQPBlpb3vFZKsP+tXmxerNOdDuc1HY9Wceg49mMlW8+U3+QSl14VXXTpJbk+?=
 =?us-ascii?Q?zXFH7nKxlrKcjVvrrZWPPqFug9PzBjJTqUWCtcg0/0pMW0D5Fn2rPahbf2Uv?=
 =?us-ascii?Q?2Lnx1M1b8Uudji7dHjwRDBeJZ1ph7tHDXjFH1JL2nNTI7x0iv4ANEyQkfjdp?=
 =?us-ascii?Q?4bdvqrer0+MBHyP7qsujLp14nqjZfN9FSFE0MgPTrbV+0XKi/WlZ4JzKHkEW?=
 =?us-ascii?Q?uGCHP/YFdQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbdd719-3b5d-41fd-0b5e-08defbbd18f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:37:52.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJ0XnLl6GSQqYVHiJavMHvb0lrxDPweWNX3KPV9EFrbd/grtTXi9j9I2QVoRLYpVGNHWyGthizq+GVBZsUo6zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

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
 kernel/sched/core.c | 35 ++++++++++++++++++-----------------
 kernel/sched/fair.c | 12 +++++++-----
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 27164afc7b0aa..f47514ba6c241 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1420,11 +1420,8 @@ static void nohz_csd_func(void *info)
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
 
@@ -1442,6 +1439,14 @@ bool sched_can_stop_tick(struct rq *rq)
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
@@ -1472,18 +1477,6 @@ bool sched_can_stop_tick(struct rq *rq)
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
@@ -7105,7 +7098,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
  */
 static void __sched notrace __schedule(int sched_mode)
 {
-	struct task_struct *prev, *next;
+	struct task_struct *prev, *next, *tick_donor;
 	/*
 	 * On PREEMPT_RT kernel, SM_RTLOCK_WAIT is noted
 	 * as a preemption by schedule_debug() and RCU.
@@ -7159,6 +7152,7 @@ static void __sched notrace __schedule(int sched_mode)
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
 	rq->clock_update_flags = RQCF_UPDATED;
+	tick_donor = rq->donor;
 
 	switch_count = &prev->nivcsw;
 
@@ -7234,6 +7228,13 @@ static void __sched notrace __schedule(int sched_mode)
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 keep_resched:
+	/*
+	 * Enqueue and dequeue updates can evaluate the outgoing donor. Refresh
+	 * the dependency after selecting a different scheduling context.
+	 */
+	if (rq->donor != tick_donor)
+		sched_update_tick_dependency(rq);
+
 	rq->last_seen_need_resched_ns = 0;
 
 	is_switch = prev != next;
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

