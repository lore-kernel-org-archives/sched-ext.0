Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9473F9A16
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496920; cv=fail; b=U5I3dS25wIztez4BSwidRz5CQTXFa9stfMN/8lUh2elzzQJ+GdfR2+N8zDEjm9xJ/xZ8RYWl9ahEe3TaVAHBVJKhrhXmwU3z6a6U2IXX9nssmH75BnOiheW5RcOiGkCOR/nCeTXAnbpX1jjQsabTRzROlgYKEjxYwMY9pq0dQgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496920; c=relaxed/simple;
	bh=p+t7cxAYbdzHM/6qR3mr5jgmfwqBhqDsBpWLlmf5DQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dnGicNRqc5w0KZ/hML4JhwnCpW4GDoO4GOB7aHbGzrggUqAeSV1VzctttrgtzYIvBh+oyPN55H07JI8nfz+7FTcbVISt3Z7Ie4ngKuGHvDXMGOG7fT4mOwaJ+QqGAGcNIJt4rqf9uaKrQnmeeGv04jMJoP8gHbhphhezF749XoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KCZWIDj6; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KCZWIDj6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psV/rijlck6XEDX4QudQuvi+qJura1UcIHTvyDJllYLn+9KeMSjhAgnptPwKK+lwXG5UAfGdQQyhaSUjgKOEroZwlsC4tJHMIQDem9I9x08b6Poe6646Y2lx+aF2EBISmCpzA3lMHKLFvu2+WTfmaMBuX7o7SWnDLwIkuRlZOIpXNuPZwRbjQQ43DYqMwEyPWAAWEyMlWthV0F9yq3d9gw+RMQMxjSQKDrJQMImBd59wvuytbxfuH57XmZcJRfACLkzLfPHMOV5G4celV0eA2GhNZHIrq8jL3E5ARMtapI0JCkldUxPx7txxbO0GJEt65rkmnRXpeAGOU4U8rgMU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbD+AYEQ6caJYAGGFoEYnNA2COtZTFm9Tj6nKNNYYYA=;
 b=E8CaNRm63CGhx9U6tyTn3N+ySyYqWJCIF81TEkBujBhLAZATKas1NQMZlA1oyhjupFmIF2zywnxD01Ryfd2F65VHYTGzT12sXOPPAybNp0GNSnEneTsHCnX1UdHZOzVp6XdLcJvL6p+eLs6Q8QrQ0byvSGMFPYkHIM8dr4sK8XjdNE2tiGB16mmnMQOtJhd6SiQZqIPgHclIp1UFGW/vjMG5JAKatng8/0rVxzBJiLsUERuIzlgCcE1ukFF0cKSVbzbFaNn1I01TwZpB0IiBYO2nImebyAQbRBoS/D8zb/4ICZrrle4Wlg3sI6ZytNl62wRVgzkz3d+k+i5zCm8NbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbD+AYEQ6caJYAGGFoEYnNA2COtZTFm9Tj6nKNNYYYA=;
 b=KCZWIDj6u4ml0gF43K3ig2JMksni4idJS+NQTyBoDMiRfJIz3t6NzieFLoKuTlWQaw8ZgU8H8gDL4BS2EMhrVCCVy6hm42O1JYVv7OHzOwkRJDFUhX0YwfhD4SxqAchXgAwkh9a2cFijoJ/3Df2ZSQkNXo1XfjoX3jQyeMlPCjV+GgTQFkuyQtWXUR6xK1MbWRves7rpqCz6NI0wzWpQe4SBRvFFnFKh2loyLAvR6Zij22I1CLhmRUqeU/SLf1CQ54sfShlBhb2Ep0ywukGt+d+a44K9Sz2yshTXPjl2vfqp6/CR3RKU6XGLIs4oiwsw+3BxqE+7CAhLtOTAN4tq/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 07:48:31 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 07:48:31 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Enable tick for finite slices on nohz_full
Date: Wed,  8 Jul 2026 09:46:48 +0200
Message-ID: <20260708074812.1041434-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708074812.1041434-1-arighi@nvidia.com>
References: <20260708074812.1041434-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077CA.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::46f) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 9981b6a1-46ac-4589-cf55-08dedcc54df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SXkFXrHM2RZQ75sxPxnuztaRi13BVhoIj68h+z+LuvlxDrpvZfzd7fWopGsiXXhcPi8tSRiYe24GwiY7KQT3TpaP2nZeSLF3qZQRCVHFI+ghQcpNrYHRlKtyHmV92qS2B5W7oTkMU9716BTR3XDq3hjcaWHw8nM8KSXG1AP4A571C895eijBsLm8vYwX8e80/R9vD77WGDQXw1Mb7DZiOJuomOMMWjmoxDMwbWrSbtrWMtdXnqfJjIP5KRD8gzw5M5CI11B11sXESGjtjem2yXS0VmSYnVAEn9ccguNdbh1S/vrJD06/48nGOOqFn6d6DERzQzWlWqua2R1IClOChMfaVBGFX/HnKzsIzhKijb7cZhuFxSi2mHVqj6l93+k+Ci6mnWcS+LHzIBIzKcT4FIeLRkvin1uxifsTk/otAYdpy9mdJsTLNh8MBy5GL/on9iW0CT2Dw3sHlBCNZcQ7B17Fa5Ea9oONNpAEa6dTzBaltgEoEnvj9Tf+oz9pJ965JX0+B0P+vXbCrGwEvl88zb4edcYwzp9rmwA8ja1jbjblHk2022QPwssfY4Ukg+TF4nokQqvBUsVkGFkEqwp94+a1N07SuXPszy6r+637YKAGMM6Cq00n+U8dqDGB0HEcRtRimooAynk6QSP+KNb5uPR3GU0Ik4AOc9jN/+tLbc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FBANkAQewIovEVlnDO7EuBA/0QQ4xD3vNDLlUd+IlW1aYblRqcPAeJVXnADy?=
 =?us-ascii?Q?FbHmi9SkQ8G/9UCNsFbf4LcMryKcUohEgXy5km/Rkqr1NUShBNMYilfhOQl7?=
 =?us-ascii?Q?fW1WFC6IkUw1zFNKQuiailz4PN6ZBLu2cjVfi6ckjtfZ2gWhJJ0e0VBKRzCN?=
 =?us-ascii?Q?prNURuauiz9Tty8L6VT9UIm+kr4daK48jhsjs6hG56nTUvJwXUOyXLiEaL30?=
 =?us-ascii?Q?30eBD8kzS6PIHDAjlTLJtDBsvBmkkoPhpgrdNJ6EtLCZnXh+RO/hiy7sKL/T?=
 =?us-ascii?Q?XX6d044nrWL3DHuF0XuGt5pboRwAnYBfDa+ZXDwm5ueQuJnvxKUhj07cz6RP?=
 =?us-ascii?Q?3/860IaSOrPrjx9UVjiehu4QFJIoJEr7/F0YTi1Zd0yvm6DC1bdSx/iwG0wM?=
 =?us-ascii?Q?NJ4LjRqdWbZCtFNBvR3p53D3zErxC8cX9A3bd9VI3SzVy7CLnaCbk/+/LG40?=
 =?us-ascii?Q?G3vbyBuy5CgwWCmRuFRVPsGYXIaY5ZjgzhDDaHFQSFMJwuRK4J94EFxWti8Z?=
 =?us-ascii?Q?7QiOWeqyDXHOy1MpqVT0NK3wMcDdBEDc410FjC9sjnl3NHZ2FHgnzqkYUngM?=
 =?us-ascii?Q?k0U9nv4VjeEtKoZY6OjBCRo4rWQzC1DNMIiYnGPmB+NQ/2LOlE+CKpaBa15e?=
 =?us-ascii?Q?Nwzhhy/2aGMAOcDY0Do4p1P5VFFN2Anzgipi84sVahmkF+LQeOgzFAaAHCnN?=
 =?us-ascii?Q?mTa+RaTklR0r3G3IRXK2ESDh0yV2HN5vMB0i6dDic2d1aHAwoe/DDnDz9ikJ?=
 =?us-ascii?Q?J53SJbtx7p4QrDomw6ibRkrnbn67s6O6c+NHH7Cz/szBt+W2WzX5YdOzsNFc?=
 =?us-ascii?Q?s5vvgNMcucWhTL6MHxtzSrOEgb5TpN9bzoTuVCO0mJAXLw0SKEh7Nuqx7j8g?=
 =?us-ascii?Q?D3vp41ZzfEhb5Ge4P270mdwWYChAsYd2BJmQWH9LuUICvAQFJoZuf6uBluul?=
 =?us-ascii?Q?w15PpYxtWq6oxaEe9rQBy5VEvf92tEFxdqqAKUbIjNifvJcHM1P4ZcyGRfE3?=
 =?us-ascii?Q?C8z85j9vnN1O3ORUbyiIfrkFpUjBOxQkh75WJPJqkA2ZXeVPY52U53NL/Hbw?=
 =?us-ascii?Q?+7X7X9VNlwY1C4XClOpZXFFXLe1ayZmWsGMC9qIvoSnNz9HxuISMnvVa3NxS?=
 =?us-ascii?Q?Nkz70YNuiqsI/j25cYg1fyHYTUxlvt56atiPWvhX+xbkdJ426ZsphMdt5SY1?=
 =?us-ascii?Q?hlYGa7PWquxdLOjHGiF42NVmEGEFttuh8YSqizTpu3g7oP8pEaaIZqdwNt2M?=
 =?us-ascii?Q?j+95iqMBFZUlJhop+eYQUlodACxyDZKdKDGeobA9YW+VI+kqTWSOkiBwwxqz?=
 =?us-ascii?Q?w10ZjR0jIkPvgZqwzlm197JzrY6owiqtrzuf2m77WC3LXiIf9x6WgVK2u45m?=
 =?us-ascii?Q?eMc9mfydtZEoxJKnL/UvRG6pELj+z908SqHR3QkkQQXIpwlnPR+9XSPUpfYc?=
 =?us-ascii?Q?UJjNO4wpwJT7z8HaSdp1kPCGswrWz4TYaFyiMbiYk6QRxBZRpQWu2hQY4rGt?=
 =?us-ascii?Q?kGaHv+ZrFTsgfdxnwqIOKWOcZj+RuHfGZOQEGU2IwqRUWVV6IpIPSncqvu5X?=
 =?us-ascii?Q?AjMtuXU6LyUtEKVn9tGbYrP1FgqL3TNo6h7nafc5016hQTZemRYaBacNB1oC?=
 =?us-ascii?Q?7Xcz721GIJl8ESTLSJg2W2oXVfvoREQ6a2T02az1N9NKRPXq8ANak3IqH8eo?=
 =?us-ascii?Q?pwXRxePCEJRy78WAL2vwG7RT7v3gFP3VFXVMBt0YWo7rUzP799RTF/ukZIXM?=
 =?us-ascii?Q?xh0rdTh+0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9981b6a1-46ac-4589-cf55-08dedcc54df2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:48:31.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kID14yJdoO8N8GOpm8hOnf1Wb4VMPFiEpXwzxu5XU0MxsDDTdpn6V/BFMk0alzNEXGWkrfojDbVYsehRwlMsHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070

set_next_task_scx() updates the tick dependency before __schedule()
updates rq->curr. When switching from a non-EXT task, such as idle, to
an EXT task with a finite slice, sched_update_tick_dependency() checks
the outgoing task and can allow the tick to remain stopped.

The dependency can also be lost without a slice-type transition. After a
finite-slice task leaves the CPU idle, the enqueue path can clear the
dependency against the idle rq->curr. SCX_RQ_CAN_STOP_TICK still records
a finite slice, so another finite task skips the transition block and
can run without the ticks needed to expire its slice.

The reverse mismatch can also happen when the last finite-slice EXT task
is dequeued: sub_nr_running() updates the dependency before rq->curr
changes, so the outgoing task state can keep the dependency set after
the CPU goes idle.

Fix this by unconditionally enabling the scheduler tick whenever a
finite-slice EXT task is selected on a nohz_full CPU. Moreover, when the
last runnable EXT task leaves, ignore the outgoing EXT slice state so
the generic scheduler can correctly re-evaluate and clear the tick
dependency.

Fixes: 22a920209ab6 ("sched_ext: Implement tickless support")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 47 +++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e75e2fd5ab7e3..3fe06d05ffdd5 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2978,24 +2978,38 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/*
 	 * @p is getting newly scheduled or got kicked after someone updated its
-	 * slice. Refresh whether tick can be stopped. See scx_can_stop_tick().
+	 * slice. Update SCX_RQ_CAN_STOP_TICK to reflect whether the tick can be
+	 * stopped. See scx_can_stop_tick().
+	 *
+	 * Moreover, refresh the load_avgs just when transitioning in and out of
+	 * nohz. In the future, we might want to add a mechanism to update
+	 * load_avgs periodically on tick-stopped CPUs.
 	 */
-	if ((p->scx.slice == SCX_SLICE_INF) !=
-	    (bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
-		if (p->scx.slice == SCX_SLICE_INF)
+	if (p->scx.slice == SCX_SLICE_INF) {
+		if (!(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
+			/*
+			 * Bypass mode always assigns finite slices, so @p
+			 * can't have an infinite slice while bypassing.
+			 * Therefore, sched_update_tick_dependency() can safely
+			 * evaluate the outgoing task.
+			 */
 			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
-		else
-			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
+			sched_update_tick_dependency(rq);
 
-		sched_update_tick_dependency(rq);
+			update_other_load_avgs(rq);
+		}
+	} else {
+		if (rq->scx.flags & SCX_RQ_CAN_STOP_TICK) {
+			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
+			update_other_load_avgs(rq);
+		}
 
 		/*
-		 * For now, let's refresh the load_avgs just when transitioning
-		 * in and out of nohz. In the future, we might want to add a
-		 * mechanism which calls the following periodically on
-		 * tick-stopped CPUs.
+		 * @rq still references the outgoing scheduling context. A finite
+		 * slice is sufficient by itself to require the tick.
 		 */
-		update_other_load_avgs(rq);
+		if (tick_nohz_full_cpu(cpu_of(rq)))
+			tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
 	}
 }
 
@@ -4321,6 +4335,15 @@ bool scx_can_stop_tick(struct rq *rq)
 	if (p->sched_class != &ext_sched_class)
 		return true;
 
+	/*
+	 * @rq->curr may still reference an outgoing EXT task after it has been
+	 * dequeued. If no EXT tasks are accounted on @rq, ignore its stale
+	 * slice state. If another task is dispatched from a DSQ,
+	 * set_next_task_scx() will update the dependency for the incoming task.
+	 */
+	if (!rq->scx.nr_running)
+		return true;
+
 	if (scx_bypassing(sch, cpu_of(rq)))
 		return false;
 
-- 
2.55.0

