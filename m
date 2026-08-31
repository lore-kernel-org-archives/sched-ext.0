Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FBB526AA9
	for <sched-ext@lists.linux.dev>; Mon, 31 Aug 2026 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183866; cv=fail; b=rQ3Ck5TWMoPkoaFfNk9JOOZezIDoMPrEZ9/5PlEVemoKtgxsAjT0n1lvZCY3ouRosWyKAlDl/gtGGlDYBnhIeandwoiLz78Y5Vc4UB6f+d6+zrNYgFRgglQPSJTNxDgyzhKUXYnKId+C2XE0DhlAboNWrkfT0UGEnqTlsOI43Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183866; c=relaxed/simple;
	bh=Uo12J90Hda7ITCQ8lI3A1YpSK4gODdjMHtiprdUV46s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pM9hUPnFkQz0Tf4Mh5yBiJ6wGOtjNZNjHkMDJvdtlJ5+HUp08zau/OuaUy/gr388IYsKCv0DYzHJSF7dugYN4CSlCmNgdk3Xt8t++WD1I9BJ3KNvrBQqPChDROTZYbSRH6HjmclqG2v5ttCoOG299FbasLl78X0RCuFpHYVUlQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kFdMzfIK; arc=fail smtp.client-ip=40.107.208.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kFdMzfIK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEUtkLHIJLhuzOHhTowEw+O/IEBjC5xZS6llXj7zNsAF0hlvWzbwFS4R38fbbhLlWZyWSx9N6TUgO7sGt5/kdqCHShkNehqzcbQq7l6QdAHCi2vW9JzPeXjxTZOHN+XMP1oFWmnI+tuhdkVddesRJo915ueYp0XkqYnr8zfBz/m3Pr9mCgSscBA8YrqcOjYq1JSxh/D/0CEkQkiiD7OrYCgoGNNA43nzuvrL+aijI/6aQBLvejxdXRK+rK/zaSJyWeP4hJvzJzHQTkWz01Uni/1wwdjFsPrQmCF6ajoeWeSJGaOInJjWfNZzMPBvwoKhthmss0Saa16kM8dXPKznXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJFi5qAiDKesnD3lga1WWjE4rAqcoiFAffqVLeUHsWI=;
 b=B/VBrjVDJdfIkRXSORkxgJiMLaqgqDBFpMXegOLbQTJcmnBuouPrDZZrp8Xxt0DPtRd/17MtdegkXMEpmWM1M2zAnt2kuOopn1ChLuI5vuhS+TKVfQgRTzjBt/qgk6O5fX7t3t7ZrYfTzYbbn/OKO7eDVMj65XWAfC9CSpddto6T68uIG7tw6TV+GamJHm5nIzdOxvDhl+c3RW9mo0hlDE2CZyVjBr9rI0L6yN39rvcc10YcvETEe/evDX3fWWclI0rk3InrNyuxtS3SeNl60LcrYhUMCvRbyg6ZRD7BtPh78DJCRxa9Nyo4LZisDoDetGwrO+VELIfEEXBHYEPisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJFi5qAiDKesnD3lga1WWjE4rAqcoiFAffqVLeUHsWI=;
 b=kFdMzfIKbhQDSGu0DiByz933zoRST69hnV5GHhT1YshD3wHYNQZ8bnuas0H/NvJ8Labt2PurqhPpMTTsyFnb7X+ikoWwEgg0+T2TJCyQUWbJZOiu+HR+rQ1v9M2dR7+wlVnYxKkEe66oBy2PMiy+KpYpRSqtvjgm8u6wP2a6NV0P09i9UXtFux+HgNQAA7J34NaKrTW6mPoiZX89ZT9aVa7NOAAw+Gc4Oc2HEFsNlOF4hL0FqS34lmgCJr5aPeeR4Y5lYL261YC84K9AMWDuSNSIrdH02VfAWXHT64EK9pPeqTonrj+n/tmuw4yEMGsQRqLHfmLNZZIMeWUxEH16Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 13:44:15 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:44:15 +0000
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
Subject: [PATCH 03/18] sched: Make NOHZ CFS bandwidth checks follow proxy donor
Date: Mon, 31 Aug 2026 15:42:13 +0200
Message-ID: <20260831134338.1531664-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831134338.1531664-1-arighi@nvidia.com>
References: <20260831134338.1531664-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 558e55d3-e779-46bc-3565-08df0765f25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XUQHmvjJQcffdSXTei7KPXSLJeOx7Lxuqjgt0BaRvQjOjVtGlcKgI/emvGrsgSLdyQMUTgJ93LshvIE1YuZZNEzAXjImK+yzjq8ssQIZyAGLZWKMjVKo+XxBZdj4dKXC5PkMG+aye1wvQmApHzzyzlcSAscL9MHRYeGBkgbCX2kReuVxGVdoedTzgvkFtmeVr7htNKm0ku6h7G7S/7fE7atOq8Xbc8UoRVie3F11UCM9EOJIzsR8rEcSjtZLrImjXxNonn+UsK4t01D4v/s6NI5y65mcybN3gUZWLlWmQ1azbQ+unKTnYW8yvV3IFwxRSkOqixvWiQFIxfKvKqEOU4esQY8rlXcK8nFMDKXo29D2M71XveQFF7rDX3xIuDHebF21TSja9a9iWSVw4eB0yZ6qll7h/utIPLUf9B/8pOS/1K8hv6TGcz5s2zPkSFGXPc0wHhngLyPxK5/IKJK2J/2w5D5k1rTtFjEpug9w0zvjySwHTVB1B8B/5B7KPvBEGdOXxswk6EviafJcoL3CqB1u/bos+H68MF/gs8gGHNLs8ZxqefsrgoapWepzYJ37l+BU24IrrB0EtfhVPdLBWSybp6YYinL+cjtjyU6IhB7X+iptDPGpAQHI7xkiyO9cFzvaE49l4ADUi4c3PP9edmwQ6hGm+hxv6sSN0hQ8BB8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tCwAe2GcUnI1z0ylw9oSvtu6FfLyVn36UQey65R69iEjtUoACBDHU3Cwui4Y?=
 =?us-ascii?Q?n7jP8yTrbnoTDUG5Y14CuJHsoaZh8GQ86vcePmN4vNHDzU6JCKH+APnzY7I6?=
 =?us-ascii?Q?oRS4Zqz7sznaLmU7idQz9XRyb/KtlldBT3ibjX0ue0L0Ra1EqNynV09f+ttO?=
 =?us-ascii?Q?qo4JRacuO1QeGnSVvoZ5t2sGwQGwEvBzfwFdWsx0k9djiwxwdKfnJPdiA0GR?=
 =?us-ascii?Q?0g1PlEuiRmEdwjm84YchfNDgUWLGyWJd3kLT8uTo2QT+UoWNXyGPbR0UXBVQ?=
 =?us-ascii?Q?IiEvcggsxekJ2xrrZrUwpKUXc45RJlKI3vTJ62zXfr75D5ww1G8NXTxa7TwW?=
 =?us-ascii?Q?RNc4nIn2aUOGdlPiMwcmZb/dMQC4AFl2wIkt5gYpu4audz41UzWXvhXjRd8I?=
 =?us-ascii?Q?8OFMWE9+5PnBTgQdEmrHIQxSMIW0z2IAbcZ0tweEhwp5xrIl508/M6voqpGk?=
 =?us-ascii?Q?xwicAdXrt8+zIR8sXnysQx+g4DYrdXAL8rt5F5Q8arcUdAFAD2ayehH7CqAM?=
 =?us-ascii?Q?t7wBvU7N4qaOPTSnP6c+u3l9EqFG7It2lxqrJiPsiaFHNvXyjb5+JSwW7qrI?=
 =?us-ascii?Q?jUPkQdc2eaSk3bTsARNdZUz0DohIiu0rnZiGTQfe67yqiqx4rga6UoQwj70G?=
 =?us-ascii?Q?v/HoFGhoTlfOnCAOZ6zRaOyoA5WyIsq3hOIuCnesGgMQBhL8/vGB6qb2lqrl?=
 =?us-ascii?Q?NLBSyJsoPrarztCRzBE6HU74XW7NQk/omvuOsythYy+EnbXmBU3Snls/ncNY?=
 =?us-ascii?Q?8Vn0HIOv/aoJnM+M+1jgdavsdduRIPm87kAZhzmKTWF5mPm+O3cTWPh2tVGz?=
 =?us-ascii?Q?0XAndeLxghlSMEhtNc6db0Ux+0Ed9I6htXKVqqSne1LEtb9LxU1owFDCLwGB?=
 =?us-ascii?Q?4/o1Qq5AjtRciIkQ5jp7+znwrJy5b414HQvvlCTydDm02UzsTvm1BXk6P7Dc?=
 =?us-ascii?Q?jKFqnKvlNA699jAv3xihBSDLzEXj4lWMY82kgRAA+O1qnrcc2rjhHv57MdWV?=
 =?us-ascii?Q?CHfh6CzZe/v0XpfidB5eIa0h8cMRz8Sj4GrernyfNPbxwKpXaWCH/r2RBiVW?=
 =?us-ascii?Q?rXyorr+dTUW4ehlI2Pq0whMLe7aheIJ/Q1oSUWt0J+MOg5jUAozGLD+5QJv+?=
 =?us-ascii?Q?xk+zom/mYKUmQ7vO6hNETgSi3hculI9Bk7g4lxk4vYa88PTqJs/orMIvfj3L?=
 =?us-ascii?Q?CmEFoldDLPAxvESSaWrC7XLjWZ5dngn8Kf7uHKC+3HsUpVGDPgh0rJ0/7e18?=
 =?us-ascii?Q?aULp+B9iz83C6wBoymZuyLuJKsVPyMGotm6NOhOjSh8aDQ5OBemNVOIpxWyz?=
 =?us-ascii?Q?sycvF8ACowmC4D2Zg9MEa8x3TqEtz1WnMgqIiRqb7F1Cr29ugZpv7t54S09n?=
 =?us-ascii?Q?LcEohbJVzjNvLdZQ9RtS1U1WZehnh/caTP9QpiMOb49NC5AqGkSxSu5TSz9Q?=
 =?us-ascii?Q?7agsnQyIZewWPWhVsBwjjW8SWw3GDH5mM0R3OfUxIk1vumRd5Aeu3BD0OqJM?=
 =?us-ascii?Q?LLef3P9wdkw6uwIy8FwhyZaGCO/Yu4EROEUAafXPTKTwFjavdB26eEPV8Oyi?=
 =?us-ascii?Q?oakNqcrw8/6kUyg94o+L4DprELpZIHSJRC667DJZHrlikm4KUVjU8t5crsp9?=
 =?us-ascii?Q?VqfUDEx9PJ79n5wa4m6dhsfWoK/x5QHSvyIErNRHR2otxmtbKmUn0v1ofYsQ?=
 =?us-ascii?Q?t9OHhIsjftcDxHXRriNnj2ukZhzeuklQ9WSvag/9mdAe5dtI5uS5KrPfc+Xk?=
 =?us-ascii?Q?Bfp1rMwVnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558e55d3-e779-46bc-3565-08df0765f25a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:44:15.0328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixJvIG1uzThqeQXH6VJsZb8zUOF+TgWJjzbMmUTj7WkC46z+mnd6w7eiUxe4qCp3a08T3anMR+ChgwFmNeacTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

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
index 237d216382f46..14d0d5c884393 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1419,11 +1419,8 @@ static void nohz_csd_func(void *info)
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
 
@@ -1441,6 +1438,14 @@ bool sched_can_stop_tick(struct rq *rq)
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
@@ -1471,18 +1476,6 @@ bool sched_can_stop_tick(struct rq *rq)
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
@@ -7114,7 +7107,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
  */
 static void __sched notrace __schedule(int sched_mode)
 {
-	struct task_struct *prev, *next;
+	struct task_struct *prev, *next, *tick_donor;
 	/*
 	 * On PREEMPT_RT kernel, SM_RTLOCK_WAIT is noted
 	 * as a preemption by schedule_debug() and RCU.
@@ -7168,6 +7161,7 @@ static void __sched notrace __schedule(int sched_mode)
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
 	rq->clock_update_flags = RQCF_UPDATED;
+	tick_donor = rq->donor;
 
 	switch_count = &prev->nivcsw;
 
@@ -7243,6 +7237,13 @@ static void __sched notrace __schedule(int sched_mode)
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
index 8dff37059faf7..1842a748641b7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7703,14 +7703,16 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
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

