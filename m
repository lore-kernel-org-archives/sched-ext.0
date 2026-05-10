Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E620468E
	for <sched-ext@lists.linux.dev>; Sun, 10 May 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778435545; cv=fail; b=qOiJeMMDW1bu2lEGwS56jJm9zB+wwWA+eRCNy6wYsDPjIPNnnL8Dx+8mK0CzSpXWUB/u6g1IxOjpoUMNKweT6oLr2b3EKpHDY5x09UnrJm1+e8XzQ3+i4wWwdb5heH3gN3pa76RGU9Xkoj0J2y2NbF9E9cQKg4J5V6UAD4AIak8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778435545; c=relaxed/simple;
	bh=dwunw1ykbKU/D2l6Et6nbWyLOYlwu/i5/bw3GrPNrj8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EJEPgmVIOwVZNCNOVtklQldekq+B8elNGkXlqQQrJaBeJoxldXPhu3662uXyIk99XQGzc6/oLV2DkstsOzrPX6JbJbFNkzKf4XPZa/zHsCL1Uxbg+o/PbPtzdlSOjWx5noOyasTCqqinIjJJLxUqgsJWZ+uFNjP8n9a7Id4wpOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cXBO9t8O; arc=fail smtp.client-ip=40.107.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cXBO9t8O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBHKn9K3X6mLKNs8tRI7qy/fkWc1ozBh8wybTSfnWVkzWLhiomGPXiJhbEQs1x1FZwdLQbd30meJeCsPvoflVUq7FGefMuO3mrC9GzyZt9VnwcBr/V/0e2DSFquPSlMN//BzzbxhF9KcXRybaty0XjDsH/PCA4TfZfz4NRilLQULAXjpvU2CFDUiouvFKZ+ANq2680P7Hj7rbYctc5pxc4HRup96iWZK+0IzEqdQqpVQ0tFJxOVAJZ71VrFNRpauG87VYmz6OmLo0f/h0yXwFW/WA/JnrC1ENEHIukEvys8a0g03D4UNUAg/FFTIobT9Q61M2v9g6Mf2AiHNrEOMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4WBo72Tk8CjVdacKVvKL5vKtNp08oIpNl5Jz0ObwF8=;
 b=lpWUuuZyAIzA+tJTri5/53Du6TEWoxRA5PQcRGH6WIjnOdVscEXNZ4glfoLXKT2CxCaEihcxivNjMuzoOfaItTO6NTV7jpQfSq5cDXD75Cpxl7aS/gi7uGyJlbWMXsQ20HCA51uSBJVaCZpz/kXuPx+bnDwQte+pTvBjrtz9hzKL76YfQQbzsVcUtcO1iwqBKGZR0prQzy1OodQPsOuaNp/HN/f6Ge+4QS7c1+xT4XY9/K7ZL3T3ThtG5Yq2dVS41eQb6WnrphwWedaQzDfFHVKOgfJ2XjmxV8RCSvBX8yPWo6ShrA7wNFmx021KZwZcAh8fMgSITyWL5QRuHcRh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4WBo72Tk8CjVdacKVvKL5vKtNp08oIpNl5Jz0ObwF8=;
 b=cXBO9t8OaXeFcqwxxoEHEVOpZ326y3gZ0Q/ZUpAwCDP1uIEZUOclUa3mEgLJeX7F3OONc9OIFRlbe+ECkSnksFQQqYqFQRMNag8tAnNgwAXMo4eDfrvcx1mRWzukx1nDeLXMaABnyV/1fgkZ/X0m99OJmTdfu0cfOjT6GrxNpg03s1pVqymn1nmr9p/3fbnqtcK2Qfpy05rX9d0F0kLJ9/qixQ/17eHTTWFBkEFu/FM3+qLzlFtRsw/GUVh5NOcd8x/Si3xn/tYlB4npEkmhZB6SNPHos0btcX/ERH2IphsEmpY0A2Z1NFlugKMak1UhMvfjkY4uamSDEsM85FEJeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 17:52:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 17:52:19 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] selftests/sched_ext: Fix build error in dequeue selftest
Date: Sun, 10 May 2026 19:52:11 +0200
Message-ID: <20260510175211.978332-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ec218c-85c6-4f9a-b94a-08deaebce131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WSCKnoHFyFBuhM8COH3Vk1pL04YmILgx79wdmWTjttZVyJzao/ozGloV+J0rCAhDwgXy7qQhFz2iy1pj/nXlC3LEWADPpiXqDJvGL/ETtCbcxPuiM9ywnjwtkgHS7rA1+1ts46GBCo1XkaIb0+miixfNS3pbRgnGAVwlrJSduo4CvUEIWp7mxKPQzVzCxfYKvH8otkf9hlpW+yJ6d+a5+rNc+3fXTtWuaoQLxgpB1tDGX9h4SSCH8TygiEHeEcMgCWGuCSgU6MeHGHt1vuMi/R5/O3MXi3ehYeauF8YslvELTFJqPA6ul+55I0L71GbJTNUeZOZTwit/7cDKxRbmgoJbn79ogSVNqPcHd64Jh221pqpJRqlh/vjpmUT/Z+eKtArDwijHzYOB3+PcS/TJnNkX+dxVG/2uM42GPbEiqZ3pSBmr+FWhzYE1098DyZqb7S119bgtUdsjeJVWyLlRxck6lndYbqyWjbkb1LYuPFbSAlw7/K2OLHb4RQGIHoH33j+SNP0Y1qFPAsqXdyzOkTkV6Y7yPR80jJ9wfmVusGbD+AXjQ9axDpqhOfCN/SQxYZqm/fsZpilm4cSYNvG46fSNM+hjxv3dp5n6oxTGuIeLRvdGgOrqkmf/gX8Kc1WjaciJZNEv9JK/eipr2oBIyZdi7VfUhHKLBKRMk6RnBfuHSDHCvXgeXCzL9NdCmMZJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JtvO9kqkA48VJ8dNgWRMXM9bWkJuBlg6q1TSZ3HgDEdYTcN03DBGOrMdk7aX?=
 =?us-ascii?Q?T7yuu9hhL05Qn8kK7QG1qryT3umVdUHkrCy41WMmV4/j+LT1CZbICKsB9qGN?=
 =?us-ascii?Q?QneLJYFgKPlOBeaPKLDSp5/eeXNXsLBwwlG+YsHHMrZLgIxNR3V90++81Qmq?=
 =?us-ascii?Q?DkYXOqLeZhKuQXciOt1eej+rGksxT6+WRY0KKImPzAXCLypBEFD7KINetErv?=
 =?us-ascii?Q?UdiZH0xDWAbgJUhLJe/RAGlJ89WOoTuOLUhhvod2KC2YOF7TtHvXQXIUli8p?=
 =?us-ascii?Q?OOztystQ1Dx+hvvZ6T8GhVmrmg/kRkHy2C9G47AuNkS8za9mTiIcqylInwQi?=
 =?us-ascii?Q?ART85mndXsM9ArWCg4ICJyiLDU09yQF5Nym9IFnl0fiMfy2RAJDbPLDuDfLk?=
 =?us-ascii?Q?EJUFSdKqxAJOvdxWQbGWZQkiubHX+h8VBtMgrdbkNzhy8V0mXBRnu9JoQ6TY?=
 =?us-ascii?Q?BGb50uKh6BNe7sBrcRR3E7kyop8q6PNdcSED8t2/ovuxGiRfLninKdolH6WH?=
 =?us-ascii?Q?68PX6lx4O7v849bvXuyWQPU+Lt5StPUXjYcvds3JKB0GGxxIS72gM9Z2h8G8?=
 =?us-ascii?Q?Wqurz3M96KADWYCkCllD11pfSpDmcWEbOq0D5NdlvgA6eUJsRdgsU35v6HwB?=
 =?us-ascii?Q?FxYSBfpjdRGRZIhVK9HVbZgmBS86wfBbkfEupkgiaXyp9wVi6r6WVFg+u23m?=
 =?us-ascii?Q?9woZn8Dr/BBq0eyFRFkbHBUcqO02YAHZ1lSuHER/zIMed1pqCLUSL+xGcZyB?=
 =?us-ascii?Q?XVXRuYqJV54df60xcdHnZFE/qms0sIMU76XMiDqFSgZieldrPxFXhawf+2hv?=
 =?us-ascii?Q?1Wls89FsXXCrk5rkjLtnSFlyrNl4OIzOlyP2rwLFAnh6b/YEBoamHpKeWt5z?=
 =?us-ascii?Q?Zz59hNxoHve5sE0qWYSXhKbL7lWXPFHl1O+1B8lsIdoP5ZircKnxggCZ4Evb?=
 =?us-ascii?Q?EShpX1xab5zBqntYAPp94JZ+bfkRB37u4/HNDzp4WrM+4RTLJbfmHDLJp9K2?=
 =?us-ascii?Q?UKT8DBOm+QoERbpV5WHU90pifKjR/WTlSjXCR3t+UzYP3BEHFjAAQ5G1Lsp7?=
 =?us-ascii?Q?4BLymNYL1sq2PzN8A14dT149q0/ZIn51Wph+GJheile8jXcRbN5005CNsLlu?=
 =?us-ascii?Q?C5zP2F9YMtgCB7WObnaKN0TspF5pIhrBCJC2uTFcMQOjfbCy5LwjFpgNtBxm?=
 =?us-ascii?Q?AM9W92EAjtkyjp0pLWw49M6VC2A/lsaac18Dox9f0FIM6yYSTFpo+kXqLUSF?=
 =?us-ascii?Q?C8jNy8jfRhaWstPH0sbBAD1qeB19uiQPV6+gKwXs0PosavOLxKTxIZYmbvkg?=
 =?us-ascii?Q?3YZbeJbgXXRW2u2Kz/j8vzkGOLbAzl4AdqlRUyHQbNd3bTQb865Q+3SDJoBo?=
 =?us-ascii?Q?kQuCJzIIgc6c3js/aCQyPamOlaT+ZCgztFTFIMtNi/uZSv6VVAkNoEG8ydHs?=
 =?us-ascii?Q?p65n10ofXhUt8Sw8M5BUheCwsZJZnCoO/cHii/LdTqhvqYqjN8pP01HL4+hz?=
 =?us-ascii?Q?c1LFZYPZPDnFqYH1p+M5/nxoMG1NC7XeVdxpJntBF8wh35kG3827ZmLMR5Kb?=
 =?us-ascii?Q?oY1PAPtwJm6iNVvmUUWGuLw2h4IK0t84MjBXLsm1xomNd1MSIFJdSFptHkbR?=
 =?us-ascii?Q?JPp9IFHKOroYZsCWFsQXbyaM+62SMFBMAn7fVxxYi1uglHaoI9+W8CtvC1ww?=
 =?us-ascii?Q?h/ndo5956JTsWbCM8NRQco4PXufeF5K6tY3VB5xvwnUPa/TwtEFRubWTRZGw?=
 =?us-ascii?Q?og9NwwlVFA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ec218c-85c6-4f9a-b94a-08deaebce131
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 17:52:19.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dgrg0ZUdYXZVhXLjrOWvmmNf5ZZ5jYJilY1Zv5Xt2GnrqD20lSeTWlaY58nBSDRB7RM6/JZy94pUuNUd6mR2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550

Building the dequeue selftest with newer compilers (e.g., gcc 16)
triggers the following error:

 dequeue.c:28:22: error: variable 'sum' set but not used

The 'volatile' qualifier prevents the writes from being optimized away,
but does not silence the unused variable 'sum' is indeed only written
and never read.

Consume 'sum' via an empty asm() with a register input constraint. This
forces the compiler to keep the accumulated value (preserving the CPU
stress loop) and avoiding the build error.

Fixes: 658ad2259b3e ("selftests/sched_ext: Add test to validate ops.dequeue() semantics")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/dequeue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/sched_ext/dequeue.c b/tools/testing/selftests/sched_ext/dequeue.c
index 4e93262703ca8..383d06e972a46 100644
--- a/tools/testing/selftests/sched_ext/dequeue.c
+++ b/tools/testing/selftests/sched_ext/dequeue.c
@@ -33,6 +33,7 @@ static void worker_fn(int id)
 		/* Do some work to trigger scheduling events */
 		for (j = 0; j < 10000; j++)
 			sum += j;
+		asm volatile("" : : "r"(sum));
 
 		/* Sleep to trigger dequeue */
 		usleep(1000 + (id * 100));
-- 
2.54.0

