Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF19416CFE
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615608; cv=fail; b=p+GPFCGllm7chg4s8y3/eKXyC9iM2+cvxMLfgSyVWST+pWtGm9LE3vOmWjb4i2LOcuxnGHVsit5MV2USmwfRNOOInFiGqiIwJJtE4cdX2Jnn+2DdizxeRvS4YXQAzk9lNLKo6aj1PBTwNlNDhkcTvosdc6DAJgcvyva/kBeXS/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615608; c=relaxed/simple;
	bh=bMIPIB+qhlfadG1+EbULUwKuJqs2aJHrGEcRkpPD7U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mcKWyXVLSVOI+INUjG5c+PLFlzgTkXIjOQb+9/niBMsCXE3RdrIqlUfrXuiKLFS16ZZpRyFzjfEFT/d2sMLYzUUM+vkPewd/fSv2uagVH0TNVfr7JhaC14obu/rmtJbplikNWkuk98rLHsJX2A9+wMxPBM7Ffdlwk2pxziLD7CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UM7yOwYn; arc=fail smtp.client-ip=40.93.195.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UM7yOwYn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjy4uu/L14xr33FUE8BKNtAgYqpAmoQuCS9nOzvNytEDJmZ18f5byXjYV4sv9PXytr5olV9G16s42YoNVfZAX0KMHznPF98yjDC98pGw9CskAhbfjC6G+7RSiilKsTdAzEqtiVu8+qbabtmf6rj9GyeamxfLCs47buFAW6LpQTvzfTdhTsTqCxFgybWclBKDZObhpXDEzfPdKH1xwHXUm8MgK9XsBs5RSk40F6ECE6LcEnX7tjgZzRS46aYd00mQ9ufBT1AC22T4CWcUzjoawrblrNaOzHZt0OiEjZOrOp++gK24/60rzJ4hOscPaXa5WYFWnbDVHgAHvk98MxE5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMZ4q0jTrg/MiaiIWy/3YlWGnRDHz+VgJ2rKR3pTJ6M=;
 b=kRF4+DOGEkrDmXCdJDa78hwNXN6wnxuwaJJeCBFBJGWqL1EPtMDcaGU4dBbD4rtxOMHQff7gRDkn2n+k4FS6LHYd4c3vgzu0hAYGnxEwVkqw4PtR7FTcJXHRntCbCaNduVNZ346/naIFCljj9rekD5ASvTlkQ22kOlj84p2dsZV3tphrVD6/HgBZocsRXn2SIzVsSXgCoP3ytIyFK6aEpNGEN3N5XgMdJb7GMhrNaB5WYgxpJ2fO8r+qZsJOCcxgz1KMELRfUKdcN4/pOezppBKwH40y/8EkwXONVWOC+7G63vUsSn45Mff7nS9Z1ANGcIO8W9J/7akOa+4ChW8Sig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMZ4q0jTrg/MiaiIWy/3YlWGnRDHz+VgJ2rKR3pTJ6M=;
 b=UM7yOwYngDOdsCLEJ2AtF+jttH/ZLMgLbskaDNOBuVRFVDYVpFJAr+2CX0DBwDrJ7qTrTZd2ccojGyHr9Zdx77w70iVARVOblb6Y6sfYkuKCGh+GKQtUoUQ/LkYNi9834GbsOMvINPEDWoGPubLVmpyeLv6gIstcfLtmy/If4ZQSPUp0m6K/dvwfUG/iZla1XcgoFNp/DWxanupHK6FizSpmntXqCKrQUtk7AsKD6ZSbB9bkv1ensUbYKuPi5srM5oZQjr5bmUkXuR1CrutvBqwbDJTiX97rtrfyEh4gT0JG+YIvUD12FWR0X99UnwHcFMXnE/n3SzMG6HeHi0ZHpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:33:22 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 06:33:22 +0000
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
Subject: [PATCH 02/12] sched: Make NOHZ CFS bandwidth checks follow proxy donor
Date: Tue, 21 Jul 2026 08:31:23 +0200
Message-ID: <20260721063242.552774-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721063242.552774-1-arighi@nvidia.com>
References: <20260721063242.552774-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: cab37773-02eb-490b-4b30-08dee6f1f5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V8TtwUF34QYLomssFH6PyHeX8pJanNGDsLrIn2GU6dhwPRvHmH6drluPwhdRFezaQA0izlDgp/r/fz8ApCTCFdOq4+1a0UTXyKlXIhmp+PkHnmYvKePjMdui9pzi2pv9avbxlTyvtSfOAvxtfu258ljz6S/hICLBOcRG2ypnfyrbJCthtQOs9Qcx2djugesOzW+VDM5TPqBv8xvA8OGbYm50MLC/uaj5CryqTMuD5h1F/km/O0V1SlVbGeU1C7j83LCShWYR6lAe8NI8cJXoAkl973Pz4DBOZYtsHyqU0CFMnDp+y5gW7IzvJSL3Vt/H0OW+OD6TL86CrzqhM7L8HPdz2Bjrm6OreU9XJhAdm0lXUepL7HxgP+FdpcXpLHX1WrXW0ghTUBAc3K7xjLVj7j8WvgdMl62poiehnyDn4m38QmG26RZSPGsmjIWeZPNJv9kU3aDm21lPVrlXZ/+pFQDOSkYpm+KyUcYS0MAfg+7Z/Mp2XvuP+Gw8yxy411hGPyaS9Zwm271poanadwRAMUqfhVPAJEUQNy8/rPFMA/pzQ9LzhSQHh3qkcldwmFNJ2y+v36PDwD+pXCZd9c69iTmDaTPjPKut5Rn08ALHIeBsYNCS6VA+WwPjqNp4d9dDSdMzPEAZ2h+DHtx3jRjWW5rzyXbyzsyZgvPBRb7XMuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wgHLKx9+IkyqKRZM/UbNgiwi1QV0Xr7nj7hkQZJI+zGUrCpodxXF9MvbfG+b?=
 =?us-ascii?Q?buNxoMkkKJfTylY4oy0D/TG3VXO8vwBbYWmZF0WAEVWfb53UYQRX6vg2aCik?=
 =?us-ascii?Q?4GQ90ox2ppe7O9eE4pd4W2gfVeR88tPVbw/VkQGMICQA229ZzZtp9P4IDV5s?=
 =?us-ascii?Q?SMxFNeGMERcjUO0gNoe8sCWlwQ21/SgCbKz/vc10MesqR1A9lREuywcu/IVE?=
 =?us-ascii?Q?BwiA39laeAh9jHjkkE30XFFAWn/57+HJv0NtWiUzWQ9skusDKC/svwNrvmTT?=
 =?us-ascii?Q?42SPNflEUJ+8L7YEK7B0iSlswVBCzklJIbKhOGLrt8TAVtSHBehA/dB/k6Tl?=
 =?us-ascii?Q?Yp/Ood0/Q1otwC9gZpriDypDEM3YFJI9BY/U1d2izs/XcH73kFpyUQap3+6+?=
 =?us-ascii?Q?KBTvyvzQdNxIl5HRPeSMpbSRr96r5rVi5ICpPW86WY1k8NlVk5roaat8jFSr?=
 =?us-ascii?Q?piS8FWIzhI9tJukq8lgeRz1Ksbk8g7NI8yUmrf/4IlqQ9AVkhxm7ivnL+UVf?=
 =?us-ascii?Q?pKBXgZGxWrryYRc06XvgAxnSDpxq9JrOYBtdGCtjXXBTr0h3mWNbWsHKBu/n?=
 =?us-ascii?Q?jdFGbgdGT/lZFyLVoXCNgOkXXXpYS5cByQrdFvmFtDVqBN/kUNq+0eBuKx0C?=
 =?us-ascii?Q?u70WtRjfb7TK9xFkml1vfgPFynHFPp7CISeR/wBQd+u0PE0PIAY79fFzLc8l?=
 =?us-ascii?Q?LhXTBq1198IDmbiDbt/KNjSa3ajhlv5VoqMH1pFr/g2YBvJTQEwKVeYdNI6w?=
 =?us-ascii?Q?SeA0Mgce+wijCRcTLqlzkqwZRALg2xobkaaKHbaDqrdwIED8x8Hk068hqgBK?=
 =?us-ascii?Q?DwGzZoK2lDQq/m4MFpy83+OJwgXLNSnjs4L9glnnBh6Afb5ZSgbIP7O3QvMM?=
 =?us-ascii?Q?HS5l9E54wq2AufoZO8kdYc3OsewADYwJqK/MUHUkikruothIKsM/PpcFBn84?=
 =?us-ascii?Q?evJmKYsDkljI8GXBn9gjAy4tJF6alok2FoXB9Q3q8+9Id/6id3UPl4BciPyL?=
 =?us-ascii?Q?8pcE0F3rlK5yBK3PLYab1Gwv0TNspvVUQvf1d8K/CK0F76xeXkSbqI1j4QKw?=
 =?us-ascii?Q?U3vBIm7HQpTz0bT9otvsn12I7jHE6+thNC5Y2rrqOOdVNfdJmakYlSM047EA?=
 =?us-ascii?Q?Y2m/g1BWnlM+3/rz0msrg4/yNNlpy6el4QFRfHb688/tJOJYEYOMxAYxGjjB?=
 =?us-ascii?Q?ieBSYm3KM4K2XqGUsP0PBMrUx41wWmza1OIq0Jtz56uZ0rK3PWljv9RviCXh?=
 =?us-ascii?Q?qcyUOkuEM/FWwlBRFay7tYXTomZyeJ4y59BLC0uEZN07SR3VEtlhv1F5GZpM?=
 =?us-ascii?Q?IN+wd6mI2pPWAuEhiwB6wcmLs12pHyj0CS6SRvJAVeuPrYeob+xhGly13BpH?=
 =?us-ascii?Q?By/ED5hbYccqGIRypZHhtwD2SPJxKZmWsD6IZtU9Rnny2bdXimDQxW4MZB6p?=
 =?us-ascii?Q?iJc4gyOs3ibcHLbUIeAzTwr2K6q/vvxKl8V7A0lyGu16BNtpJNOxiw42Xe3s?=
 =?us-ascii?Q?KJjy6M9w12uqbc0nCauVHzn6O0+2jOg2nqJwXBmlgOEdCi2mWedW9/+cP4oj?=
 =?us-ascii?Q?sJnJO01CuXIE8pdJrSwQgejqD2WnyWvJyVvJFD0hwIjAuEbZVPl75GsSuMaC?=
 =?us-ascii?Q?75S3zQkNrLvrLCYbdSw5jCh0Hwi25huhIeJ48+aakiGBWRa/a/evimMofC+J?=
 =?us-ascii?Q?SiwDyVJouRpiehH9OTlcuPDVbGex1V6A7vEoJ3+7p2ZlCDQvLpTk0fpc4ZlJ?=
 =?us-ascii?Q?GzF4SvsvLg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab37773-02eb-490b-4b30-08dee6f1f5b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:33:22.6558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s78vwK0fTtQazpdkIsCL0QfXPetgeKyGLcxN9Su7Li/gNFJQEajDIdmNkt1XlODI0A2O5ZDQeTz4WiwhWNS7zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

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
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a0e813abddc28..074dc14c22d5d 100644
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
 
-- 
2.55.0

