Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDCB490BE8
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792241287; cv=fail; b=Hdd4TRsxLb/Z2l/TMsdEWwO/7Wmcjd6H9A6TdYajpbxplsRkZblUm6mrJKwyzBUhRw8CtnsQEphY0Lm5R7j6DBfPCzQuSfFy8jXIKrvKgC/cNrRmtJP08/RqIDyKUPckOn2z38JLy+tfS23YixJup5NeAFGyJ0yeJ9ImTPGUAWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792241287; c=relaxed/simple;
	bh=iQz5KgWXuxCYeAmzX6SAQ23yMjU8C19sJZfCw20FNdY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u/Sh1U08zav5GNfXaBpN8CB0C+zwqARH/0xsyx26VTHGUS0QGF6Zl9ITBd8uu7z3Zfpi1q8wnW7IU0Y9RWFiSSRF/oLhe/hRbsXU073D1j5P4+G7tsgym1hOwQk3DtoH4PQM19Ye1ff0Z3tVK7h+jBH5n9EUxfAQlMFaeSXk6GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qWZoNhkY; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qWZoNhkY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UumXXSJSSYlD7luO2H7byeUDjxrYX6wD4sErkJtX6DA8JyyZGTGfrLzWxPMkrcpmm0YUEpnVr6DGE7OTXZhQ1ugBsRF+qfOxshVo+GZ3o5D3zr6kqUucC88ej0WdTdiyQiCvllgo8TDZF79IDRbGfv4ItBN2CtMWMNLiJt1rEHPl3IcIfELPz8/q5c2nVEwY06JNxCDqJMIdw4fSOuwefHnt2Lcyy2czN950YSMK7xV9jNmtKPhAzBVLg56FJXIwcFM2SLGPmhWz/M5kzs24VNtdrlZL/flSv+IGWCTmF/YfJq7rYElI38WYZFigToPyf+1SFreu1qM/RdRq4TOJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5GoLzk7k1cmuMmHDoagUex3NgbvfU5HWjr8YgEyLN4=;
 b=Hr2GsJiPdjBUuWjBpXB7TR6S+c12EkMjRelPlfBpR091v75H40QLtM1pLyg5cmb7GkpoFIRo5XmgfrBu2RKkFti5LdBpAX14i0jDBUNhrnrSD2CEsUm+2ZAaD2vF51eZjEjYwEmwnwXmuDrW7MiOqTTZgW93VOJ9pHix9SQY0H8zcpz27seg1O/TeBhSnMyyTGbuA7rysmmOi8au9JPCzpgmjXOcE7rLg5OpeHzqn/M6zCefBassBNuNZJtiUkvjxsDezTpu/D5Oa+YZ+AYqkADxG1/HU8r8IDgVBTYV4vqDWHUYC2gOorL0wsJFRFwjQwgRrePW9Da9GhB4Y90Jkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5GoLzk7k1cmuMmHDoagUex3NgbvfU5HWjr8YgEyLN4=;
 b=qWZoNhkYvjPLr8uZuID0B8xs+lcTl79R/mIeyJEa0LztmIad9QPS4AWq2XEH1oeYKDgMZAaFzRyfUSoNc9mfgFNdVWY0fL+/5ABUTshPKWG4L3rwWUQh2r2lr7xpN0HUBXvGNVTbmqj/xjWlQelpZSJReGpDttmwl/CFTvhdGf6nl+rxeko+3jtvVrfvtCAQabHZ/VJ+4aSHVWkkrPs87JGKPSFW0xsNzDsWZlhgK8260r2HA830SvyjP0NXuflbJxpe3uyen+vyXB3OlsP1Bs5h4guc2AIx8J9FqdErfqyfT1DCrUEA2IEmF1hcIinGW71N1V9tyt7aFbnhLMh5EQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Sat, 17 Oct
 2026 12:48:00 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.016; Sat, 17 Oct 2026
 12:48:00 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: Don't report a forced-idle CPU as open for IMMED tasks
Date: Sat, 17 Oct 2026 14:47:49 +0200
Message-ID: <20261017124749.3608468-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077E2.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::415) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9f9b91-fe32-475e-475a-08df2c4ce01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|5023799004|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fygndeBuvZqEQIFp35fpz0R9+hn2/K9zCZ1XXVYnPlLjeMkalkfE+2zGpsiP25beBQHCZiDCeulfLDA5QJN5zmuyglXjK+viFSXWO+hilYI5qI0CBcZy08t/vh6xp+8VNFr8SqFqOC0Fi/fHEm4aouMe2YnittdA87oyQgOEuGpjWN0PIGU+LM7ywaJMNoeANXEp6HwHUUTDdMxhVhAriz16jPLhz/NyCDYmbIuU0WzpsI6VrDx9uk2+sY7Ga4xijnMfmZE0EpDHeAtWhBZBGQmO4y3b9gUPoc6y6ARQFmBaPuehkZkWss8EKPxotAc8xThXxx8Z2/wkA/vdQrKKujeS9yxnpgNRnnUBCjh69C5hqpAUbedR0T5Kc5on8xa1OAqFsQCphH47ald2V2GxfCOh8U4zlrl2/MlMa/5hP+HC/Xb9OXTDV0SBmKNbLOVLxdhERxSfmOALoJCYwEgdygj3R97Q0hQbWOQbj2YlXbr25yOCfsgKTVVuezTUdJ6/z4oLNdRk+nE+fiwohlvauVGl5rkUuxQfYkkwHd+klpar+tKQGcxsOBLA+IJExRvpfWFJFrsWrSHYZQKvvT7gk4wVrG3s6452SMh2e344hxXB2sagnhCPnRGPGpXrwQ3ZdVRgECdPBZ3OK81ctL+9AB2Wjm+jme6qTf9bwcqGeEk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(5023799004)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZIW4My8q+DudimLBAuC3rUcHWpOuP5s7lwjOyQmk7Mn9l5xx9NKgNdiIkO4?=
 =?us-ascii?Q?mpKGJ5Aki6S4xs2Sa3aDRnnYwTxAyJ+IPsJLHlegcTVOJA8nrFqDEEVKFvkg?=
 =?us-ascii?Q?pfnbgxYFaKS4nrKHqLjdXbEXdbobrtzc6/t4F3UrT4cIbU5+FERn9Y/Q/UIm?=
 =?us-ascii?Q?yS7XjbMUx1bjOE+3hemrO5L+/w5NRWxC3VaiTPOzzU0YzUKD1RGIo+qXhrtJ?=
 =?us-ascii?Q?9luiIEDZSgJKS9gGFW1xUVH8MyOsTOGLyfZGlVyTL4mR/n5kFzHyUKRMX+JL?=
 =?us-ascii?Q?Ox584Jg90gOKIF9aVqhoTnJexDBZ+RTTuS0PXUGqiODI7eUiIUzmha5MtRXe?=
 =?us-ascii?Q?am59tgUnRLEdbew0krJvXvN2EopZiJexWM+cpfPiPklvmCgR7EAAJjPNTIrq?=
 =?us-ascii?Q?Yk+HsZs/xT7EMhkTx7T9XCFNXzdkmS/ZJMiK1cIITzIJgYyst/kB+wbN14OE?=
 =?us-ascii?Q?mJtZe60mPxAanz3+wEQU6FcOL/xG4+SJIjJzWN1qZeymJWKRCU84d9GqBA8/?=
 =?us-ascii?Q?aFKxzDw+pVz0FC2pnyAnTCRqJKvlsKd2psvcwqOS7kH+Jr2I2ZZBcdx4cnm8?=
 =?us-ascii?Q?h/rLy0KgKP1zt9HdYh+pvBoh7byAnedAwEo1tWzYPEAh0e5KewfUwQeGRmxp?=
 =?us-ascii?Q?JErC4H5fZbgHDZAUELVzwY0wk4L95B7YVL07K9hZoeX35oj1KnTGXi56gH4u?=
 =?us-ascii?Q?AN1+G6S4FBWPAdWeIuKQKbgmxqiLFW05//iPGrPQCXx5CI3oiRKHVEDuLvv4?=
 =?us-ascii?Q?VNQrCuapPiQl1xnJOydo2gYaWIIwBtoPNLrNx9nRfhzQylZ0DVQs4LtID5Lr?=
 =?us-ascii?Q?vb3MPToGJFPRQckvN2SJsI9YjPRO7QLGYaE8jP4v2GRo6g9KHhe0qsF63rmv?=
 =?us-ascii?Q?Pi1vMbZek4ciIt68qyGbH95XBoABBMdvzeIndzbnB+03iHeCOdsz0GGvYAcI?=
 =?us-ascii?Q?COAkua3551y7bq59ud5+rFb0VnuDyuPNKJ/ntRcVQHkPgForuLqE6nSXRSyg?=
 =?us-ascii?Q?jNCZAliv9ug0UeHLjr+1TD6ONSvzTErt2jUj2dOeP7EsAEjG37wFwzEaUFlV?=
 =?us-ascii?Q?APBa7PGY/HfFQNeu+nfZnbM32WB56w3UxmnE3kSb1b6TOddH5FtfJleklR6A?=
 =?us-ascii?Q?p8P2B3HyXZYUeGYLWuqBb5CdWPbNM+zHtRmrp2uQaDj1859ruBR+xkTsMx1a?=
 =?us-ascii?Q?hnQ03cUw8/RSlqfRw/NEOUjndI85olbW85pRCG1IyfrVfJ/ISutrnwvnvMa6?=
 =?us-ascii?Q?gcJcAM2kElZfIixZ1jCwMaMazwS0qXyFYOH9I2YWsD22ket1A4CXTfpptkfC?=
 =?us-ascii?Q?l93hbsRKMOFI8MiRwUvj6WIVDMW5KU+NmGnVX48FtQWTvfNZLXbAL1rjHXMc?=
 =?us-ascii?Q?Y+evSxXR7w+nVRh/r6G7KiNaLLsNRZbEFJBQSZxrH9MQzPC6PEJsVyQtIrtH?=
 =?us-ascii?Q?bXBzgbvz6Wd5j4GWtNiuDCFzRidnCCSF0BeTB2WyLLJn/Ya4X5eWtn6jpxnu?=
 =?us-ascii?Q?OjUerIPyEeJALT4FVxOgHyP+MjNBVgjHpIBpeSuR/etL6shZ0BfJKpwmV90f?=
 =?us-ascii?Q?/cLDGzxc2+5x/K5lRhMmjcvm1TwCusnm/hdfPslKid8C4NXWyUWqlnhymwaU?=
 =?us-ascii?Q?9qsqAZYL1ACKOoe34xO0eTP9VFXQEq7r+NioNlWUGUiikJJhP73Qcyl91c65?=
 =?us-ascii?Q?wsnQ4TPTtU+LBudIVAnEhnk96Ck/kM0sp9sBzSuJo5xUXvh7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9f9b91-fe32-475e-475a-08df2c4ce01f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 12:48:00.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52S/dhC9C9JgaL91GJqE6CU7VK6p/cX6UZCsDPB2bbnEpEzy0MWBK3OQkqwquQkuJyIO1aSQLqy5kuEaw6VYBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024

Core scheduling can force a CPU idle while a higher-class task is
runnable on it: under an untagged core-wide max, an incompatible pick is
replaced with idle without looking for a compatible task; rq->next_class
is then idle, so rq_is_open() reports the CPU as open and IMMED tasks
inserted into its local DSQ are parked there behind the higher-class
task, instead of going back to the BPF scheduler.

This scenario was reproduced on an SMT pair with the ext server runtime
set to 0 on both siblings: an untagged SCHED_FIFO task spinning on one
sibling forced the other idle while a tagged SCHED_FIFO task was
runnable there. An IMMED task inserted into the local DSQ of the
forced-idle sibling was never reenqueued and stayed parked for the whole
test time window. With the ext server enabled the task eventually runs,
but only once the server kicks in, so far from immediate.

Fix by reporting the CPU as busy while the donor is idle and a higher
class is runnable, except during dispatch, where the higher classes had
nothing to run. With this change the IMMED task is reenqueued right away
and the BPF scheduler runs it on another CPU.

Fixes: 98d709cba319 ("sched_ext: Implement SCX_ENQ_IMMED")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 6b472506944e9..4259578186954 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -336,6 +336,18 @@ static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, s32 c
 	return scx_bypass_dsq(scx_exec_sched(sch, cpu), cpu);
 }
 
+static bool higher_class_runnable(struct rq *rq)
+{
+	if (sched_stop_runnable(rq))
+		return true;
+
+	/* The ext server selects SCX tasks ahead of RT and fair tasks. */
+	if (sched_dl_runnable(rq))
+		return rb_first_cached(&rq->dl.root) != &rq->ext_server.rb_node;
+
+	return sched_rt_runnable(rq) || sched_fair_runnable(rq);
+}
+
 /**
  * rq_is_open - Is the rq available for immediate execution of an SCX task?
  * @rq: rq to test
@@ -357,6 +369,17 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
 	if (sched_class_above(rq->next_class, &ext_sched_class))
 		return false;
 
+	/*
+	 * Core scheduling can force @rq idle while a higher-class task is
+	 * runnable on it. next_class is left at idle, or raised to ext by a
+	 * local insertion, but the blocker is picked ahead of the local DSQ
+	 * once the core cookie allows it. An in-progress dispatch means the
+	 * higher classes had nothing to run.
+	 */
+	if (rq->donor == rq->idle && !(rq->scx.flags & SCX_RQ_IN_DISPATCH) &&
+	    higher_class_runnable(rq))
+		return false;
+
 	/*
 	 * @rq is either in transition to or in idle and there is no
 	 * higher-priority class task waking up on it.
-- 
2.56.0

