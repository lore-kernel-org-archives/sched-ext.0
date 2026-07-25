Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525B1186284
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995551; cv=fail; b=QhjWR6LetaeWijLvJUgjpPaBNu6m+3Q6vCxV8aCYOssb9pKTbc0FgyblMrNsJDkmp+wdXGklmTvcY5HHUkqG9BbIjzEXED96wWEViqd7oK9gDEVgJf1gTpYSfCRhTJruITGrVG3/nplJ9iFFDUF8IaQoQ6oAM5aUAquyXXKExMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995551; c=relaxed/simple;
	bh=UXmxqmRTmjjOXTush8xioA/hQUsYJ82T40Qdk4YZYo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tN/RXQBCoNvHIMq8Emq1MV0rCv/CTFZirODmSW0zQXpZImt9qvB8L1GtMBlFBFw3WlIoGg0q7yHY2ZtZJ2ny9jtcvg8vSyf0mV2TsUWaxkJJFGq9FxGj2BMUtu5sy6PdxRYE7kLUffSthisDBTkJgxo0TggSPjZE3QKVjcZVMtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OyQ0n8zb; arc=fail smtp.client-ip=40.107.200.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OyQ0n8zb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDqTVkfP467Bq2nFxy8HVTLyv57iGbPiVwTiG5JO4akYpJrMYed61P328wEBVp4w5eGoCz6ZitocMSic8YW/9nn6rI9eRP2NgaMyLPWyrjTdkiiocexxciO7hgkZotj4jpgHz+yA0RL7YdfMq3Nl+UXSr3BQ3ct2s+u7EsqnzHpCR3k/rlrEgIOzc+bfM4arblRfJeW1I6XgIicx5euSDbQ2RZZ+viItThFWOijZ7f+vePNlSekO507ue1uuwKidS+2r6jCoGgx/wjTclOCYNyfayR14zdxRBIaaOd3hmXmiy3xtfZ5kkoMiz58xXcF0PGWzz/vtLWIS9hLr5JCJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eP1z0rpsCyGNoqbIo08Tk2kn/pdc+UN3riSQJLTYRc=;
 b=ufhzHGAyx2QTahruX+QAJHvWYqBQVTtwGFeYGmuOg5SBmZS6pv7EyQPNPV4jj7OU127mpaq5UBmuVOqMqq4LCbfKTB7icppLk5jeS4uBUiZ+q3k9pxEV7YfmZ58oM95flTIhvbDnauPMRPR2Fdk6HEY+fKgMCXKGFPh4Sqse6HSLLwYN7++2vDDT0BjlPZgAWYSNoZ8XxAOZ6yKyIZN/Jf4P9jVDgcXa0ORwI1FbuzLIPt4VHOWK2yIpauCGA1uJ9ryipJQ8Bsq8HUzHTAv5wBzUL3e0w/JjuhKGawRtKU98BBfMpp7AUCtqxgqcCQuXPxGxuBzP0UZQKh8cjbT5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eP1z0rpsCyGNoqbIo08Tk2kn/pdc+UN3riSQJLTYRc=;
 b=OyQ0n8zbzJqx7dIg5qSydhTICugmrpYDrSrSU/aMF7qzFA1iN/hLsVxpdx5gDNoFPYsc8+1zMLYkRNTH7ICBABz1wJ5uiAMEa8lU97hmQNrb1j7Ev2FcgCpUoQhKKINgT/L5vH+Ytg6/8KtH3NtXC63li5K+ETDFvl80vJPsHgPg9X6yqgeUwFaA/1woSkeBrJX2b8WutlOMuMHtDwUG7+hFAXu6wCNO9+2ozxmE7s185uhTB3NWya1HRKO2uEhsCa3isYKY5xpYdmD3Ql3fxuCv0li0hwtvaGuh2wmJH8gMsrOsUKTYcrvvauPncGJ1CdlKVqI7rDXgY9la6Ik4nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:05:44 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:05:44 +0000
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
Subject: [PATCH 02/14] sched: Make NOHZ CFS bandwidth checks follow proxy donor
Date: Sat, 25 Jul 2026 18:04:08 +0200
Message-ID: <20260725160513.57477-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: ae47dcbf-211c-4038-cd95-08deea669526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/IyHebr8UDGGlS1U86qX7O+NMcdUYcIJ35irYifO/mheRqWUPt7g9yST54cNQm2Ber3oAx23jED8rLrT3THiZDtoTbkIIYr9Rch/w5665EI5kK3DrBWROK0PzFiYh2aYOvYWdwyjQ/qfCaLHb0uyPpB6NEGPToF/ewuOU+/LO6sDsIJFmUYZRcpqDQI86ZtRVZPmc3ra44bzAWmSum7mWZbqRGTXuNxP6+UBoI9uLf9Biy4WY6jpFN3Ib+CF88/y9uN4tnIM/jdTbfPevacY4Dm9Me7DNgsrCIsc8yaGz3qbG0z/t+IQdcViWRRGXn7Tg/ab+MAY7YPUIKGVg6YgJNOsIbWXtOyCyv6UQBe2Le4Xey5Q56oIp+Uxlesa2nFeFBgREEvIKObtauQe3vmHKUzrkskVvbh43XwjClZt/mxj/Om/38Qrf5huxSJQnp+KjScRfQtKOh+5mFLX82HZWn0M3olEMZH8jfDqwHZeVWdySTIW/SC8Rny21VlnX8SmaHez7zZ79cfR5ymrMDvNtgNbxKV6h4emm48OSsD33fNaY1hc2J1DPi5rUaGQ78rDhKIIAyeQBufY2+0WZMeHft4uEHFAqgcOJfqmmfGddJb8qSceTQ/oLbMajNR9Gc2onWytN5TDmVRbpEMuL3Myu1ZAg/j9BKOTSjsphIoOI58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4MG4xDS8sdLJuwR4Iy4URXsu41pq+6gMU0msUa7pPSs+p1s5f0nTua6hF4BG?=
 =?us-ascii?Q?gl+0M1U/JiOUVcOU0izUbkWY6wmRq8JofmnVYIUr5w1C+yOttjODWclXBjhP?=
 =?us-ascii?Q?7cMsOHxk0CYRG1K7HF/FgZUFa775B01rajwavt1BU4/dstq97bccX1yty/l8?=
 =?us-ascii?Q?GXjlxaES1Hr9KlBSiKeDYXZ9Blr4Ea/wSo8S1CCq4Ay4hlaMVPgZkF+bDkai?=
 =?us-ascii?Q?7tWP6lDHhnVvKwaippSWio8Tf/2gWweIDb0hSRQeeKAFnqYwbEQZ+6UtSF0q?=
 =?us-ascii?Q?985k377+Yy2duAu/myff8DK3i2SekIapivDzy+vBtTuBqq9t/jQhjNVyrt0m?=
 =?us-ascii?Q?v/PTa2M3HARTBet6MmCtZteqpqPtm3YAUtVDrWCRaJRQyaNJ/EpYVAldKtFZ?=
 =?us-ascii?Q?VtRCAInAKYqC2XCNNcICb3i3HTzfwVgNYufR2alwXe+TZ9Kb3FPd3WnmlklF?=
 =?us-ascii?Q?3YS54BFCiufnm8bL73s/CZFX5RlJUc4tzu7xOFCfR9ElHXzKDekveHs1yDse?=
 =?us-ascii?Q?HQMGI65iA3L71bBZwb8YnXjbVDdZG9k2W6i1fGVj0p67y0JVSu6pjGYX0DWt?=
 =?us-ascii?Q?+8uKear8u4Rz4RR1sJnd4kKzbGFDE7LhpvW+3m9uCkTeAea32Acjkz2y4Kc2?=
 =?us-ascii?Q?1TzQhzlAHssKAUstZJLhgaSWiw2WxI/GDUk9qXJc9sDD4NEPjIuFmvtQhL8H?=
 =?us-ascii?Q?jAI40E2DmlN+On+c85TCtBzV2eT5zcM3SVpogIoaxrqxwvhg5vLLiDIraUye?=
 =?us-ascii?Q?/aGxN61NIHaOI7SfQyKFsW9xMICdC1TdG8skd+cvnkwhDLuD3zOUCH+2sQDC?=
 =?us-ascii?Q?iH0u9jhKeAh90OjEYQaV7x10SsIrLBYTckhNpfwEEcNtT7vZlOwrv2M0qXl4?=
 =?us-ascii?Q?7OgOiIxv75Yhoa4UCLNADYkYYWvbbD8NsewDBZC4JtVlP1DXcMXXZ88G6B74?=
 =?us-ascii?Q?CJCdfSAy4NUNUJLbd8cjjtIywzAvTOwz8NG/JfGE7JBiKndHWi4+gr2HpW5B?=
 =?us-ascii?Q?gD5V68QdhXFA9g1OWgIpFbpvoznVid/47gUeU0ZZb6OQpUQYnbXW62Q0lzt/?=
 =?us-ascii?Q?yAIQlCz+6NQENxnN4ITByuyeN5r8QmPsFs9hOjvyehj0VtmZW3OCaTeid7tU?=
 =?us-ascii?Q?i+wrC9C41/G4d+/z7elA4MwxLayejmokGbFbVE5ogAKJgzv3RfqQtncOJ6cD?=
 =?us-ascii?Q?Ezrh0SV+e/2s2x23LeOowp5ijYGZE2qS3J1EIPgDYXTIIOYwuBtNNmUH0seF?=
 =?us-ascii?Q?VcH9LT1c8HQm+TuSBH7CXsvdFBknjvSsajFrSWQXa4zJH4Zp85KYb/Xb3D3e?=
 =?us-ascii?Q?3hg8o1EFdFjLafqRXtOAsPfVzP3fgISxJNHqBAgGOpwrXcJa+rm788iUUSDO?=
 =?us-ascii?Q?jMe4nkNGR6RVbeXtPwGNFM941nuXMzFbfj0/d8yD/HQ3Es551DK4lnWBMV8E?=
 =?us-ascii?Q?s4o2mX1ocu1DuwbKhmhMbIfqMbGihDmD1PnVfu95Ksd+Ozhg0dPYm99yTVBO?=
 =?us-ascii?Q?hnHCkezM83cUpj8G1Qo2fov+vJ9J9d435nhUOEaPdRGLIsIcrNQbacB4Dy9F?=
 =?us-ascii?Q?tCNX7aEBloRDHunp6qX1HjIyeTjm6qxhTJrz6zQ2IIOzP2rodOI0j6RlfxW/?=
 =?us-ascii?Q?CghcDD9b9km1z1VEfh/XuruqXGblOE7S8QlmYhjBYixtHtp6D/82gNx6pAW5?=
 =?us-ascii?Q?TNk54klFFcxuEX+wsUU60gT24u8C7ExtpcMcQin/UnJWpB/zDGY4n6B6LME+?=
 =?us-ascii?Q?gXq+G0+5jQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae47dcbf-211c-4038-cd95-08deea669526
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:05:44.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cya6TQrU2Baura0WNmMGmsvi7gEDPkGxt4tPr4KnrRAPL1KViy78GG26o/3hoFC8V6rgYQpDxVpZgnae9xZYQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

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
 kernel/sched/core.c | 18 +++++++++---------
 kernel/sched/fair.c | 12 +++++++-----
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e11fac7f805e7..e9829a289da45 100644
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
 
@@ -1462,14 +1459,17 @@ bool sched_can_stop_tick(struct rq *rq)
 		return false;
 
 	/*
-	 * If there is one task and it has CFS runtime bandwidth constraints
-	 * and it's on the cpu now we don't want to stop the tick.
+	 * If the selected scheduling context has CFS runtime bandwidth
+	 * constraints, don't stop the tick. With proxy execution, rq->donor is
+	 * the selected scheduling context while rq->curr is the task physically
+	 * executing on its behalf.
+	 *
 	 * This check prevents clearing the bit if a newly enqueued task here is
-	 * dequeued by migrating while the constrained task continues to run.
+	 * dequeued by migrating while the constrained donor continues to run.
 	 * E.g. going from 2->1 without going through pick_next_task().
 	 */
-	if (__need_bw_check(rq, rq->curr)) {
-		if (cfs_task_bw_constrained(rq->curr))
+	if (__need_bw_check(rq->donor)) {
+		if (cfs_task_bw_constrained(rq->donor))
 			return false;
 	}
 
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

