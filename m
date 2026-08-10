Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A941834C
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374959; cv=fail; b=HSVDBKDUTvr0rcC+EgZcxcYLGW/a401SYM6GUsmHpniQ2/gAUxVn6dz8Y3yxL9fmXyBQHLug02ryAixlwzRetsWHG2fAbCDl088ITwEi5F49984n+U/f96Y1lRUZ0RMskKlac41Uzi43RxIJGXghBUz1brMYgkkTq51AqMbZT44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374959; c=relaxed/simple;
	bh=x3cBC8jdUkjSstT8HkJiNDMxM2DrQhTOrMkmt5emgcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T9uTaHOYOR8PYl4wzX6EWz8Lzxka0MlnLIEtPAuux6E/NdklD1I8dAtQvzEtBml437wb8MVxDFBeNH0Um1t/D++tu4fCypeHA4pGNMuWJyJHeflBTxjODUtqtvWTLprGgSgf6dxtyUu1Vlnz1tBMAB0497sHbci6mG5F8C6JJnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c2JNeCni; arc=fail smtp.client-ip=40.93.194.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c2JNeCni"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJz2n0+bkn2Y1X5YyNFmTbxKat8keT8IL2ZQDS21GHzQthxdHdYob60ryh70Pz03BILaJX9mZjM9NXDUvp5gPFZgIw4XDREZmuFapplePYpVH1Shjktw3CHJs4QbZejY9KnNrQIEWEgtttxE66K/w2m2R6fYWv5T9D9tAkta56o0NdLHQHGu5ik8uV+U2vjOeZCEvnl7F8eHQKdIr31PjgyTRfnJxkH4bfvEA+KPGfOdEHtrS1xZ0491LeCojjLgCAYPlj9T2vHolDmOt5zqmEpOTOaWX0XihKQSeW4RIadniG5AbEfbiVWj28173RGY4t8iBWdRYrOL8FV8NFDRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzEQRuinUS72q6oVo5KDKFr3MdZHqkRLofk58wbFOHU=;
 b=tfQRL7xrlpL7MJ+MxS/wFxQZ84WgHfWt/DgwYcZ2HksT+aActD6aWRSTMZapD3WVW/DGMjiOWa+1Lk9azY9i48BRXm1oQc/W8I1I8z36DJQOhp1qA6bdMJcJx6kZ3nbn/AGzfgbHEcLKkhl6OSezswYuv5WnVjgItdFbJejnFitcRaX/ekREFb6Cthx5kBTHJoVOVV/8K0FOOpWvRiEZTC5nxt3h8GEno9nDq8zoWXRk00Qi8ABGcx27vw3NerfQuQey2wY8jW9ih+IU3lkUM0sxmQNBnpdy3TK5UgsB9MJF5OQ4qVzWfNfm5RDHWkHX4jqlKVEi28W3tMi9HhoBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzEQRuinUS72q6oVo5KDKFr3MdZHqkRLofk58wbFOHU=;
 b=c2JNeCnirqc5Cu+ey/4dJepdKm0x0KimD2ZIBnujxrBgoEsxD3tEQpdU61xhm8CnHWT9mwgL/eGkaKINF16AXmvZk5Lsd2D7z7zNf5hS7AubRduWoCL3XQnB3nuP8KUMQMBVUcffkegTTp3Jj8FfpnjN4SLYa4K0rgnqCcBE6hAlP0KnNQv7Wk8xTr5Nlsyv+NdbBfKmZoTaHDWXzzXo9ryI8iyylGInvlifKPqseC+qbe75WK2LwVvgPMDWPQ8lhFCX8O3tk0oWgHLaaxAYUCS8TDIdG0NY1jlOR16EucD3LE4rpm8Z0KFhR41Cnp84RJMULUuZdyQzmybh6BlY+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Mon, 10 Aug
 2026 15:15:50 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:15:50 +0000
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
Subject: [PATCH 01/15] sched: Make NOHZ CFS bandwidth checks follow proxy donor
Date: Mon, 10 Aug 2026 17:13:47 +0200
Message-ID: <20260810151523.86994-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B7A.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::40e) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: f125b31d-44cc-47f8-930b-08def6f24330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	DJ6JELEP3KS2+EgXdKQr/gXPN0eWM/GCgXzgWRXr3k2aOiUcJnoJ0Iw1Olq7e4p00ggR1Ej3jk+giqAPbWf+hZEJwXcqHlQLjoWgBvJZrRQpaISXJmJDkkI835zUL2P6PVb3rbkHY2ONUCupQJ8rKX6+AdKCCzB543q/OrbFu8xA8W9a8zfwLKXIVHNPd6PYDTtZQAp72REx+9XhfFyr61+jw4wPxAUbESSBoWVBqkHN19S+zmgkZB2YusNWi8sjHH748xZNa9rOu3nfHc8qYWuPiE0IfS3e/PqXK1p6OSgt7C9/M+lH/WFfFqAacY5Pb8e4moFmNe/RkvKmN76JaDhP7sW0H0E/a5z6YinrJh9UdaoTnAjAWb9iE4evMLEtBwpOAzSUOjfAtwFjs9BjiQfu5apFbgl+ja7AdqQ5P7wubWDVSK8mDOuc08Q3Z8GLuYJ25TTvKA+skGAH4kjabqvpCN9+DAuA2/wEljj6QpRXSGKFNFDJ/p9plm/BWo9QY87Ef2ZyoaFjyRt9KtAgOOlxyaI6PfJypxuyjajlUMiMYpjuxTbT1fOruft3trBwxJlteq7uUllFvi0YZvzup95jNTMHFCaUnoFRTg6ld0AUgTSf5sT9yRZasf+anaU1bVHbhG6q2vucfIUMVvWGnRCwzL5wEM5tt92C79PihUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/SjctBzxy3GgqP8w9M626CutYg+Js1nP8rs/D+31q2naQjoS0S0sV6wwDwsq?=
 =?us-ascii?Q?1M9xKayoMq3euRKs+aGSuICJJIlN5/egJo3pwwmy2d2MC3KUu7fsIqCTgVWR?=
 =?us-ascii?Q?lMTt0oH1e5gPa6DtJi3e1mJ5TLMA9uYn+o6OWjsMYtl1dO7bmYGBKzbq/dfU?=
 =?us-ascii?Q?cTqyX7C6KhIr4wWAuN7wm23Kf8D02pyRvhdsr4AzChdSg7o90jlzjqdbuib8?=
 =?us-ascii?Q?zGSsdtR9zsjkzboDAVAnHCRzafIqX56RufE8k/FCWCSPFIUWKEDv4k3BWiq6?=
 =?us-ascii?Q?xPF0SzAP8GmRz/tywT66YYKIcTagrTfjCrDSTuOfvPFu37FHOJ5xiulDbnKE?=
 =?us-ascii?Q?+CfAXewkEEQpC244eHPbnruAOCjdxlOu6dCc8PQT2FvhbQVEjsjMDcZauCAT?=
 =?us-ascii?Q?8nFQ6hY6YdXHFdwvkXjduny8+Vogyrsf6ZTHAQ9uJnNqdmJKf9ycrO3TtKHe?=
 =?us-ascii?Q?1h5aalSfDudq3U+OkL4YCMgxmJx+GJeFMG4oJb0cka0xnSaPR45xNE7J4mz/?=
 =?us-ascii?Q?w173gU+F/wKUn09pPihPz5Kok4O3AUM3bBmNJpP24PX/bNzc9W6dJ6V2uRVw?=
 =?us-ascii?Q?c5fw2H78fCz4SK2S0TPQ7z4B0EBmhBleSTR9lVV9HluzeakhgxQzUL/8Km6v?=
 =?us-ascii?Q?qWxcLqlGL43HcxliPx6vI+7r5YieVUB71zNMdmUkYWQGAGhZ/tjDEWZMPWAK?=
 =?us-ascii?Q?Fo0GPayC0h52WmEzl52AJ6Gc2ju01oqK69GsR0wvS7eDnivT/5cYXjxb+X5V?=
 =?us-ascii?Q?NxYvuvyokHyMpRwgcJraZiuqDWrLFAOe4R0z+iiyHG2Oc0L1uxWCBK81omL0?=
 =?us-ascii?Q?K8n7nBiefT+o6K5QCzlB8yvp7HEYGJH1pURj2gend4aJ+wIz8h+H3K4mNJy0?=
 =?us-ascii?Q?1vOK4BO6dME81ttfMqMo3MxB0u2n1v9410wQzufaA+GDNga5gJfJPN++Oej1?=
 =?us-ascii?Q?vOHF6oDt9Q/MGfFgZrsc8Bk7vJIK9OmoY18Py2KjWtWrbCP2KS+NqncV4bD1?=
 =?us-ascii?Q?F+VqknIO2bFCzJoWclXOpeJEbcH2FVpZCmHOqwqxk+PmSDMgEf1Vm75TK5IH?=
 =?us-ascii?Q?eKGUjm2g8jfbB+fc8l4FEwSkX3trfB0UcEE4m/vLrragstbZUr4T6ICMAokp?=
 =?us-ascii?Q?HpHNGoQpRX/p6JqEgR0m2og3w5OZxSR2t1shLoSWPfYeTML7H9jmbMI5KFEc?=
 =?us-ascii?Q?BSX/F3CiCyz87txrDqBC4gumhjeXs85JSfEgTwsKz9l2wTa2u0uEJIPlTcwc?=
 =?us-ascii?Q?vxai2QXBpHdP/JaVfZgb/Kxq19aYX8P6Gv6k9eMH3yVrRokZeNumhBmbEBRx?=
 =?us-ascii?Q?QJrcAY4A7c0b+wGSD7YFs7XzRag0hw/jinOr7XyBDONzrFVYXoelruxric9c?=
 =?us-ascii?Q?flKrj7/B8d+aKu+wWJgpLuQxuaD8JdnKI7bghVqSiETVZfq2Ky38NlryoRpt?=
 =?us-ascii?Q?ihP7Yfcagctb8fp161U7lUHpqJbLWIMv+a1SjoKUS/J+QSdJBreDRu1WAk4f?=
 =?us-ascii?Q?E2BqsuybE1I5OO90/pGzZn3WlnAlOqpywn0PAXhf+gFfZjJ/gEshJ0oIoQM0?=
 =?us-ascii?Q?FkUq6rpgodvdLL7o5fusaVFBcqprxm+qlymje3Mlkgk6eenBMcNTvtxWY/ca?=
 =?us-ascii?Q?1EK5RBBMkLxpmrV05iJEOT0TMT+HQVsn8uVwo81faSJDlco1VKOyE/X9Z5kb?=
 =?us-ascii?Q?9AkW/ZuOIfTQOpJP1YeI6ziRLaWVkcXPh7Kfw08RVBuLwVHsjXWYENp8cnPw?=
 =?us-ascii?Q?r+9Sk0om6Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f125b31d-44cc-47f8-930b-08def6f24330
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:15:50.4991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiAcbc1w4LkI7IQ+2lx3+p4VogrcErNqra5Rm8784oeCA9JXk/cxhYLJgL9QiT28IB+BXma24ltupAMylopCmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324

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
index 3cc6fb1d20547..fbdbe2762ba96 100644
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

