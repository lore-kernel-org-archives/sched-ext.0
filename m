Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7C310777
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412766; cv=fail; b=M/bPtu2f/JRSMajNKRijlJpoAw6bhTJb/IwY6vxseQS7y7/48wx4v5wTNu2pm0DsanTAll52IIqO/IjSbM6vWziz9Wf8+NJHZ/orA5ZfDSmivETfo/u/bI0YutJO8JgHLz8cjuPv+wZ5TKixIiRvPYDheiEJjL/T9oTQrRdnDHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412766; c=relaxed/simple;
	bh=lPAtsQFjtBnFkzrsFHs5+l7gdH/oCivhsxio8Bto8FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LDXTGpq34f2wGSPYUjfHj3InAEVqW0kTSEfIzWud9XJYBwLAs6Ktp1qxo/ok2IAkiWnJ6njgKTU7W+Vx8slrsdChx/yYIXPtASwpus4YjR5KOnkQyrSjSIXxqNGPfh1jw2upKg3Y0iSzjXnjrdCfyKJq8JwaNjJji4Plfw1XjBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=at+WsNwr; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="at+WsNwr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvOgCisW6gYilX8asagpnjHyeIqUEJas4U/pMEiYodCTxCGncTGoKmOTEY4YFePxKA4v2NteDpjc8L9HCkeDMBF1aVy9Q4fhpXseB04PyZDSbXeEn5qz7x9D1f3HptFa8449qikePybN7qwMFOhdOhQYPhwvL2cY1p/r4IJal5jNZxGZw+DUb72kx5YTGEzfVkK1FwmtWPb9KfyHvXbBVatdykZ0qacCASsw9vcO26zzyFUWLSOHrLGc5hv/V5IS3RsJMOf/A6l555PQ0g6BF5rcvKG/zyQbjYsYflg1rXKQgpq9ByBg4I7/m46bUBlSNapWyuHS7x0h8TXXC3lJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjMSxle68wVbpI20NVqB7DAPP8qsQcSknHwqLPun0sU=;
 b=joBgQm8CoriG3UYeCWKFNKi7PeGgvkY6l0VjlqQA8Qu4Gcck6Xqa19ExlcQzr6DoaGZR9NV/4/uayYE3LusrhdluboSoZTRc1PilEO6I2CaPJF5EpN4gTlvM37waUf0yIJndewgD8nuCSlA+XL91krCsbEh1+xE5VVnsjhN2b4PnNrvfZcz/iftaZk+opuAu5w2lOoJUBT1BpwDJrxZLLtLXHAu6wdYGnbcCoXl1w1n0vZYf3n+M6TfNgkNGrXNlzEZTqaIKx7HQYSFgQC6GrCvtr0aLhofhxGv2596a73Hr/GPGBlCkUnkKJ3c6aQRlLBQM3OEyAbuLQkHd3KfcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjMSxle68wVbpI20NVqB7DAPP8qsQcSknHwqLPun0sU=;
 b=at+WsNwraVYTns8k+/S/OuJcDNPcJ8k+Ab47fn/M6edKV4NEouDI0rRdHrilGI8oHQ58lZBYi8K/RYS2+wYXF8xq63KhNKvk/gOcNtCzkd60uwrlg3SyNqz4wtD4qVU2gZsSioLidsBHvPl5ez2POXUUY5UhytA6JLG6LzWQ+cDTcWRWVX/+Uh8NFvjX30k1TqSDbgXudTFZbdxDlKDCkAMbl3qgJvF9NJTMKHxartKOqLMdqujvJY5TcFZD6A10OWc3+Q1nGTeZAuQ7V1DGCMEb5KFYr/+EU4Gcas6Q/XZxtQxo1t4kSK60mxC9lRbGi8f8j4ZmW6Az5nN2D4vo5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 08:26:01 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:26:01 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Enable tick for finite slices on nohz_full
Date: Tue,  7 Jul 2026 10:17:59 +0200
Message-ID: <20260707082537.918068-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707082537.918068-1-arighi@nvidia.com>
References: <20260707082537.918068-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 263dfe83-cb1d-4399-0521-08dedc0160c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	88yzDErtXqhZQBsE/Xccj6arPNuWlBL/dqq3mu5dRuGb/MO1dmwl3QhKebdLruzZph3ZeKGfU0Ffs7ElhLBfYxzmVaLBJix9MmOkFI/7OpN5eqBsU0oYHgNuDs2ghj+LAg5d11ejyUK2gHrXugnmlAvOKgTNTHwq4B7AZn0Z3B4D5e7lHwMReliCVjSFB1/f6nQoLA8kRFhVMiTkQ9a1Gj6rsQ1fooSf9qi7gRShL+FWzmB9pBGS9srOQRLcsgjY/oDiFQxeCry2OF9l3JSAf7U1EdTF7VClFfdSlS6rW3uL6IaDMMiVAaTrEX9ZEwv2RTXojo7HybLZnKn5qywfCEFCDPzFpMhpGEQYGHadEJ62maayMRrnvrXhtLjAmaunfePtAccTyVfY+5AWVI7AzBpkRziBFMVijstss38APRKXGDQXt6w1Xry0XSE/wfdskdiZUIzYepISZeWK72HhmeRLE7jHStvInY2lb2hkECXLoKXCnry6AgToh15AJrjnBjGz9NZNg739QebnQ/6DQ+t3enihe3VWNNMwIDHaww8vI37i0ZUH2BRDDHvqOf5cVuQxX0+xuKsiFoRW+ePWOqc0Q6NlGpBMj4/ol7xAzWL32tBHUAmgZbV9P+OvZsMgNbyjn1mL7Hz7LgFC2is6qeNKiAGawh1ToY9pUA4mSdo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tkYiqN+fe3tisOCAIJk/0KqHv/MPWZqwFm3XxdghQI3UP+nY60gLEmXAgIn6?=
 =?us-ascii?Q?LRlRVxhFP9M8AMj0r0p0o5eWhIFrzQ7EEFkJUarJ0eE3vSr7xnljYixhiyXf?=
 =?us-ascii?Q?8flGdxJLAlHQ4yOqr2Ff7/tElajgqHIzOSphsnODGhHqe2J56rfrJw6p7PXJ?=
 =?us-ascii?Q?fDfLlL8ROZkypVfUQvbd/QCXQ/SOAFF4nUBeW2y7YrWW2RvEvQdqruD3yLN8?=
 =?us-ascii?Q?h5MTLPEUNd6X9XSSjNwrJ2bJsek8njOHksXXH9bX5M9YH5IC3hS96Ssl9aHQ?=
 =?us-ascii?Q?hq2jCO5Xnsuv7QMuYvEVMD+S2fvyUXUtG26uqKlvSdfPXWV69mcbcu4pvgzw?=
 =?us-ascii?Q?nqM8TuxYK+QDs/LHLzusW4ll1x17XE94sshxMo7zi5Xn0UOM+aWF+0m1ve6s?=
 =?us-ascii?Q?xPcdt0NmMnfbx7wyjO6PXdVIiUFjX79vX1mknhxkWa7uOGPCSLf/Ka7ftNSm?=
 =?us-ascii?Q?X1A527qoufKF+XHvqoYq+Tz8G+t2mnSGpqqYd96oULObW2mSUmLc7Bo7JKQ6?=
 =?us-ascii?Q?dCDTpShAARQDHllncI9aO7OG818WMugORhXQUm7VLgfjoERtAniJ3FFbDTPW?=
 =?us-ascii?Q?vr46Qs/N3osjubB9puTg7K1ADYZtSVUQE5DZOLkbnI4OGH/blc8+gIKVnkdv?=
 =?us-ascii?Q?IUUigAe8vapB11TWv3DLWJpZwwVWKwvYsQoEv3jhxqs84gL8sKG8S7z/pL2u?=
 =?us-ascii?Q?AvhmqIBp5k//WtV1Uoz02MPDgzfnjutItHcg7WN7FCbJqfHOYJA6DOWidjLz?=
 =?us-ascii?Q?zTIEPqAhS0nTKnu1B3GKh8Febzv3kD33BCXn2I1gqb8Qa4dFgnyXCKOsZoRW?=
 =?us-ascii?Q?ICU1fdcT2VidMTkOA0voRMqxVMj1aqIw3MIJEUSXAA0kl6Ft8JO46U5sZpGk?=
 =?us-ascii?Q?PzdOcd0si2IxP6biN1JWkryzU34DmJstTZ8CSH8x7EhdjLrCivYPSKpWlDpM?=
 =?us-ascii?Q?r3L4HnVV9JkOrichSaR+uaNROoQZfYLt+G6H/JzJf0ixpIzvte32mEAzv52c?=
 =?us-ascii?Q?MumGzZyvj1Ht2HoUuSrS9Vjvb/jCVRC4RvyQu2fmv/3RvH5GYfQmvoXveH2r?=
 =?us-ascii?Q?y3nj5gczmxzrCQMKrlExOIOdOiHo/wYPK1rxrEcDlNPD09ddJz1dJ7jvakQl?=
 =?us-ascii?Q?kmRhsTjC/FDjaSQOHiqWl1p7uIcSRYHAzSMInMzveqXTGoEw/BmeurUvn5po?=
 =?us-ascii?Q?sUkx1cfuN69WyxjdYT0VDImgajaU0dOIBM0PfL8NsevOC5owsIon7l5RQdvW?=
 =?us-ascii?Q?8vnILsSpuKLrqVF7iaBdZv7lcpIhqn9zkfwHoauwpxUzk2jg4h+9RQHy6Y5G?=
 =?us-ascii?Q?W/CjCCeg49XcGC/6DyCuqXzM2nDWiVPE8kTeSl5liaeRhUh2xrn2u2qM93BJ?=
 =?us-ascii?Q?mM/UWJ1qH60FZV6fsdydlaILizOe5oj4jBNcLQEkSZE3av/wOk2ktERvVOtQ?=
 =?us-ascii?Q?1HQ0cgQX45+UU0zOUM599o6RR0H/ldyqnAr8by91OGghFjWCGJ0l5Np+HPTy?=
 =?us-ascii?Q?iviW8ZqFC/XAFnjqL/x+M/fKGm29YT/sIb3UCrPNq4LD3EzbrfN8/5JHRIdE?=
 =?us-ascii?Q?oOi1jmtTMOo3GTKOw4IHLgbR1KzR6ZyGKnM4fH4gNRRjrlcN7MGLGCG8cjKa?=
 =?us-ascii?Q?tVHc/noW1bmMssICmK5u4kpv079johsR40/OR6HIcQkcQxgu7DMggJSN/bLP?=
 =?us-ascii?Q?kf33CjJcIPsdGNHDGN4c+FNrVhqUf0OeoUIcheRUDdqkJt441HhK6wXmVNC8?=
 =?us-ascii?Q?dwWRiOQHBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263dfe83-cb1d-4399-0521-08dedc0160c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:26:01.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaT+nJBdVsvpmePocp2FHFI1mXkorG5k9SZzl67sOadzC1N/988h7TPgNQqISLGdbEDp0Wkt8lnmFp//1kPCMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841

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
 kernel/sched/ext/ext.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e75e2fd5ab7e3..b6a635ba269cc 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2982,12 +2982,18 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	 */
 	if ((p->scx.slice == SCX_SLICE_INF) !=
 	    (bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
-		if (p->scx.slice == SCX_SLICE_INF)
+		if (p->scx.slice == SCX_SLICE_INF) {
+			/*
+			 * Bypass mode always assigns finite slices, so @p
+			 * can't have an infinite slice while bypassing.
+			 * Therefore, sched_update_tick_dependency() can safely
+			 * evaluate the outgoing task.
+			 */
 			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
-		else
+			sched_update_tick_dependency(rq);
+		} else {
 			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
-
-		sched_update_tick_dependency(rq);
+		}
 
 		/*
 		 * For now, let's refresh the load_avgs just when transitioning
@@ -2997,6 +3003,14 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 		 */
 		update_other_load_avgs(rq);
 	}
+
+	/*
+	 * @rq still references the outgoing scheduling context. A finite slice
+	 * is sufficient by itself to require the tick.
+	 */
+	if (p->scx.slice != SCX_SLICE_INF &&
+	    tick_nohz_full_cpu(cpu_of(rq)))
+		tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);
 }
 
 static enum scx_cpu_preempt_reason
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

