Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9764657F5
	for <sched-ext@lists.linux.dev>; Wed, 15 Jul 2026 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149005; cv=fail; b=sOpdUWYHI74PUkUwmLClbSGckzZsK3/4rNUf8QsddQARTph9B1rbRecyLdcoGQar4X4UDdE3rSTrJEPD03FRcH2teBVppDaNZ+1WwhyDjaz4WN6mHnBqmEMK987VnmG/nd4tMgIhJXzpZLr/nJmu9vf2bCNV430T2fVCekv2LcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149005; c=relaxed/simple;
	bh=w92jgfyqNp0AkE2vpYqYYSYjF3iM8zJdMoPi3H0NTRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llCbBef0HF/63rmTmhsG49stdCOVBq517ZvXhxuy8pMz0mrXeQNbkhvQINQEvH+adnxV7ciYD30l0C9w3GcvQOPMliPJ4S/XDrGlFeh6ZablivxUS/cLf/konrQp2dGxbRRcP8mwFxSkKRidENVjVlTzV9xczNv2iJ55NCH6lcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i7t3PL6X; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i7t3PL6X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ky1XgD4s/G2dZ/5cMtCyFcp0zcSETkCXflPtAlZVjbe2GozFv40Qk71Eav6H8GQzYquTPnuLxgO/iZUj2SeV3lSFUbeH2xmetn5qwORoUkmbin4r1xXY44DsGOTglvhUwAgo21oLt/3U6ncFjXHqhS2xd7EBauVZoyYU9mCIv1yukg7yhuKmWKS7vM9m0nQIqWLpqgtNRMj84BN7BCX/Z+ekztOK4AnscS8aavEaZMr58wbGeMzxsjQmXz3CLW+PwERkwtbkWUUHtCQn7+a5vDywgHbZ8rqZEMwhRrlOzqFx60zDQyArnlKcOPCqUokSra3Mn4/p/+uP5pG8asLbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8LW9yWhVyKP5fKsVIkdQDPcYokUSeUUZXbdqv+MWSM=;
 b=IPdkI9DxyRGbssDMQY9ftDBtAlw4b0sIqwQ7t44k6D/sIXnLphcgn3xk5/fB2fDuuBrwepWfwFPczk8/H2juFof2aMBlNhp5RVP7Da9Dv8TBrOMPHwGUdczsM5XBOaWrsnSpa9R+PSLcmn8zEgWO5Qo0UTFYaZa12YK/adAHaf3ESziQqxUxEkpTaogeOnAxz+a5ErKF9BmuqNM9K87Y8cT70oTYuQ8gvCtTjpgEtq4SR/10wqp1l+48LjwCERQU41qZfC7WhmDs7eSHsWPpJCmzPDOkRuCJDD5lbeXthhiHjiIV49MlDiaDgLwkAtAN1+f2uDDm0kbCnjbxeIHOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8LW9yWhVyKP5fKsVIkdQDPcYokUSeUUZXbdqv+MWSM=;
 b=i7t3PL6X2dmYWXekGYCk4aQR6skviHn8oGEMyneCFzw5iTkhSxkzAFz5m/2r+HmBmq+9v3lcH5D039rjvjRsUkZY0rCdKq7riETALLbPaUj9/p3krqVkTqwoayJsA+V816WUB6q41gac5y1MCEuupBMNYYfgzv9ncyYoceYnVENUIMamSeajA/ToxKdobd/MlCtneAAJFDGcKMWuCBShz29SZbdRFNSXSBVsyVykWuBz6g8FJj+9gFzdkLESGyZVkJ4oPJk75cmw1n8it6a61DwlOQxvXKg5X0FSO18dW1axOMuV9LMkEulGTFGe9KMmo3yTZW9IGzsFjvgaKaiVhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 20:56:36 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 20:56:36 +0000
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
Subject: [PATCH 01/11] sched: Make NOHZ CFS bandwidth checks follow proxy donor
Date: Wed, 15 Jul 2026 22:54:09 +0200
Message-ID: <20260715205622.276220-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715205622.276220-1-arighi@nvidia.com>
References: <20260715205622.276220-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cee734-8c62-404f-0be9-08dee2b38f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|3023799007|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jJs9FNMQD5AC4ZWC9hP8BW4V4kOpt0RKUHcn/j2rlhV5IGOHTBAtYRB8cn1594iTLhQ6oGWKxFXmvYv2bOPoKO7ig6mXYQ+/5iJcU+GDjnCEUJsQq4+eNWvw7Oq1pJumOgaNxXuVobTVhn9pmyUHDbpVlF+evrBBzKwq+/N2BYiUFh7cc/uw32Y6bXXvGs5Wrs28uP57jlwduX/tE/FQZddPJuWslRtdIb3lhQ0odlTsdNUgbukQLVMRQqt1sypC+Xhl1EBLdNi2Hw0JPxwFL3SEq4UrYur37FinsNSrfRQvjaTi3NvBREvdWIPOOEtiGuoI0YRv8Wge87PnF5b0/HViBbn9TGDiBotiDDSRtoo+wBfNj6p6CeGmk5HzYC309OB16yrGETnW63mTwRIzyk3GSxEVJM9+Eo1H5bhgeqo/JImLAfTT72iTc5A8h+gxtzj8VWA8JuhTYeiC+0yIu2QZrsc+0Hk8f5UtWM2kxKdxNDcr6gj7BkdsKEPmAJrgz7t6rUzNap74eVgSLXCd3ByIknqHbS3I3d20lK1gV5JR6w/M4LYyIc/sht+NBPhkTZWuL27RRgWZMsBIITg2a876VPrZ2+lqgkfw5zPYwety5apDzsyO9CNCsyICaIsLazCkD8MPFDcASE+O79GTr7A+ne70TowiW16LxdBXymI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fHhUfO0PL5Ply3+v91TikLj35brtFxgedLfzqekZTUPBJqp/XjxfeZK7OJQt?=
 =?us-ascii?Q?SEOxa3Uw7Gb5grzmV69RJ0RCtHvsYCl28Oyf5z95c3PDx4PdUGjWosKnhoXZ?=
 =?us-ascii?Q?SIpklKcVnDG0dtRF8zgq/fLoh9hRN5Mu/DwlhmV1qwY6rGKL1oH7a3s3b/kb?=
 =?us-ascii?Q?3615v6MyfdUzlx0l3e6eFZle94JbC5ggEiuyabPqGgrwmUfPv2zsDxt38dwA?=
 =?us-ascii?Q?nrdXS4uSnMxceyYbuQRhzIofPP+8sxANT+dnp6nfNW/lof+sknlLJz/04IKu?=
 =?us-ascii?Q?bRTs/wy42paJYkKLeDnFROFqnRAYvA75BT4o111wo/gOiLgtypWEEFKKK+jJ?=
 =?us-ascii?Q?ZlJBMvWgXJcBl1hQEemLVBQ4C45irCtBhs1R1/wGydZoEh/XGsrehIu0tmG/?=
 =?us-ascii?Q?i38u6HkmdBUXZTG9F7KCBl+0XKgPUIyNBp4lcfNBL2Kxlzab0Nq/jjPqhabM?=
 =?us-ascii?Q?Q/wmyuM+3GsTEFao2IjLsXBtB3NE96ejMOpj/FBHTIjWi7ysYbmgEE+QbnPg?=
 =?us-ascii?Q?nVaiFS9DTu5gc3bTJN8MrCj7JEbhvi71X4jzi2NXMl29mvTkJnyjMDtIaB1C?=
 =?us-ascii?Q?1zhUnjc6K6xLRQKcvJ5HTlKMc6v1Gx2IVUWvnf4AzoArNGAu6jx3wGZjRNFF?=
 =?us-ascii?Q?DhBt3sHYGOSobn97/HTjFnanLetYpTromscSwyum7qo/5+zgsydk9+pxTNtL?=
 =?us-ascii?Q?U+XRyqtvCy7MeoWPOGZ/hpUBkAvaB99eL9O8l1e1Cv3bTWLNn6vcTV1C4IpO?=
 =?us-ascii?Q?0K2eZrQyoyAt2jl5NydIHAPbYNU6GmHU8EpwvVV+WcGapswQG/YhbfqXPWcQ?=
 =?us-ascii?Q?os9+9aV0DlYJ3TTXq3SjvI24vp7wHj+iiTgSRYSl7hLfCO3cHsgs02FDDOwE?=
 =?us-ascii?Q?QRNTnvox5H58YFLl1ggOaBXp2HulZVcWw/PhhCmtpIYo+9Q4fROdsQWo3An0?=
 =?us-ascii?Q?AJr1RBiYaG1weX4+IMBOZKWw+9eRb8mUKSF/Gtz1pEaujj7rgGBg0ffJMgUH?=
 =?us-ascii?Q?9siAVekh3PTpQ2+Om5KLpSST7J7AbQl+lf7tXzfxYoil/0bbS/wN7xknT9aM?=
 =?us-ascii?Q?WQ+KUDamxCsNYmpbep+NdQAhuJtWAP79mXmcKLzu/gngGg7I31MciRFwzxDD?=
 =?us-ascii?Q?Z4J/U3q3UB5dyTt+CiYM3P9P4E45oifrCzXett+5HMxXTB4mQhtEy3KQueY1?=
 =?us-ascii?Q?yGuO5dPib44xE9qbFRy3MnJH5+8SmBS+QrRf1VENAHcaatsti3WJ1rWtOAtf?=
 =?us-ascii?Q?JESvoEdP/wtedk7hylDlMupHyKONGcbRc04KrsE7DmkpNrGGhOAUbw5q9MKI?=
 =?us-ascii?Q?MiLYFIHAco1yn5SskGyQbN0aNlSO6LFSjeBiv1w4SnvabRfQIPd6dZXHfO7J?=
 =?us-ascii?Q?fXEvRT+D/PTPlfvlPU3U4E4z/a3eOUbjcFcB/6eODXLMPDiqDBbH8tJLHcth?=
 =?us-ascii?Q?G8X9PlA31yCJ9ogwm7DPG4tDjcmAXzSJiAI4fegxcgrOmBYCHhBrYfb3e8xm?=
 =?us-ascii?Q?zNo7PzLK2+IkzyzuIS8UCJErNa/MKssUgIl7bPICwQajUQeZXkEVYOikROJY?=
 =?us-ascii?Q?EzwOf7keteoSG9GblIW0gjafTQtqj9200uh61DlyApt0rLl3A8yJGQD1/vOU?=
 =?us-ascii?Q?vaEH7x7vHwXVSPWlgr2np/WsgHaSlHqsS9mopCJ4naFqXVTz4h10Xa5zuaAO?=
 =?us-ascii?Q?gkgYU/ONCNwHwoCCImOT3o8Fx9xT4kSmoysF7NTH+0nY6IVJANE+e3WPXhnp?=
 =?us-ascii?Q?9HTNpyCB8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cee734-8c62-404f-0be9-08dee2b38f38
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:56:36.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MU6fD/EvUI7SeeUKWxTaDxyCa7xyQNXjSIBKEpHjOX2EOkCRfjtXMPqxxwsjtiLXEXRJXJw/4GKgK57uItyDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255

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
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cc6fb1d20547..f47bcfb25033a 100644
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

