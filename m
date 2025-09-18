Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0127B326
	for <sched-ext@lists.linux.dev>; Thu, 18 Sep 2025 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215179; cv=fail; b=ptg9bOclsaKgPdaBAVOuQQQjqyl4idn6KS77qgeshJOe7E5UZhVp+VgWaQwyjTbHWCrtx2f/kAc17L6Y/Bz9crKLAYosNyGU8trCVXtd22OvuRJQcYs7N5JW9KCYCRdJ20mBhf+0US3cGxoHsh8/+t8BALFrlpN+Fk+cUuah0+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215179; c=relaxed/simple;
	bh=Zur0iaN4eATcDF5te6fK802m10XWsRV9wY9l1ibg4vw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cQ56D9doAthO51l/iP9csSsN8m2VjpO5ULsaveL828hbquyRM7KLw24nCRO39XF8f9Am+2h35VK+1rwZ73UWm+AfTlFBADyA37EDY5nGvsF7dddljti3UvGc6leUQerVukIw4kXNxWH1zpVGWkYbzY/MLN1L3WSZeldl0q0fJqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b7vyz2o+; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b7vyz2o+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ve0Po8ARo0ZWtMm3AdEYgxql1CGI/5xwvuwTz4m+h5EY6BIq4mjhXjV9irC0EdGIhkpDgal2ijmsLe+zAQcWYbmrL2jAIWw0ZGWCaSrEZBdlki/5eokHKu8nrqGiWyO2RwGJo0HyLMGCn4mQQzRasrdXBtONoU/XdVIN13DgjnjVo11qqG1zpwYYPItzpydRx0AXiiya3GxPeGsLgWSFqv5yZoSW7rRy9lO1FJn6D2weK+n6wfzQFGbo4XhGJrtVc69GwmKQ7JS+tD7LtrPuYtCf8tabOG/KGyWoTAnTVTLC9+XghkvRnDhE796V406G49QcSXS83rKaHsHvYIvWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzlMd+lJiLfWZbIZcxdAr2rxMxHOwsSn2KCVRtJb1E4=;
 b=q5Ya9xOdGRKjQUBQ6v/ytrlJRzIrH438XkPC4eWmnAYfpsQxxoFN0VWEAqTM+84yl5uWX9k7YTUvfXsrfoapKh5EIp+LiLRXoZ1aAiKDvlDb09mnX7mNx2b9wxTPcJ5+F1x2LBwKoZJLL0Wk5ekWHtdHmO5Q1+2kum5T8GKb0yL8o8vXsybvYDflazha2OxAM0eREiWw/A4BOghfLJ/kGq5GpKnxULiU/H+9u+UbS/XrwTrBc6OV+ibbPD09EQp8hKquoGvxo6HD8o254U4smlaTYszQtGhKfBt+C3M9NqV3wbPLVUXdAAtVbvH9bbCtEc0fGj9OXjqXZB5F+sTddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzlMd+lJiLfWZbIZcxdAr2rxMxHOwsSn2KCVRtJb1E4=;
 b=b7vyz2o+Lcj73C08QZ9odOmqf6oi+Aqy7Ca9FJrDRFcvmR09+QSc+I0lu9v7Twz+1JuINkBouPelmO7uAV1FQ1Bo07JvIHA6kmHcm09UBCbIdLJWp8W6iXwYhnLuwdddUN/R9s8hKXOZSVf5DJYbEkjnNCq2wrOppk1ygPqpg64juh5UZGGffbb0GqxF9s95nr2d80wlXvygQj85uNRugPAojwoczhq+U3D84MkAX1TClnISsM2Taml4G9ZJvCeLPsydnybtlPpAaGVDyG2JjKuE8GCgA5rf2UkkkQGWe1wTIbSk8NdLqoOFbnwlzbvz7ZFLGIGmhXIfxG6gZqR/rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 17:06:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 17:06:12 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-6.18] sched_ext: Add migration-disabled counter to error state dump
Date: Thu, 18 Sep 2025 19:06:02 +0200
Message-ID: <20250918170602.2441024-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 628ca427-f49d-4913-5be8-08ddf6d5ab5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FFO1kvn5KBpVChHpgV7RMCMW2d8d+NJErgxIKU8MFZ26FVBT7BqPCBlhqGul?=
 =?us-ascii?Q?cXM+myvZWFp+w0dCuwapQpisEeY1FuEZBeZO//TbcoSGkgcaB28teqRoM9wN?=
 =?us-ascii?Q?QRIdbbPCxUr6Eg5r7qrssxk/hoEmUueI0dsimxdjtYBkxc1zeTIZHHPXYrb+?=
 =?us-ascii?Q?2C3y2tR73VGBDwlw9DwErhv+IKsOlE9kD7fYbCgodlsRkkpgn2zWRu27vty/?=
 =?us-ascii?Q?BYkSQ2b/GV1G0uYfxTWCTn61C7zUbkmB68bUD+K00FkfRN188qx5WsoIqJg0?=
 =?us-ascii?Q?XwJMtXYtiMcKsGUwLhC22SaiJRkD7sFpllDYd2zrUBemYzU93VtX2vyR+m9F?=
 =?us-ascii?Q?XxakWU+IxZyyFqk95DkJm1PPahDHJJ1epWKSc5JyWrubUvASRGWVniyaRm8x?=
 =?us-ascii?Q?U7yP3MSkZgP1oN8JTc++kR2MzUAOuT4mrFXGbcEaVFPbRI4X/aQbld7hz3kx?=
 =?us-ascii?Q?NbOYO9Mud2QtUCR1yh2+f7++0fls+fIjveJEkSl+ENeL6WxyGODhmxD+vuMN?=
 =?us-ascii?Q?cKYPk4rsgTTe6nJykoaxu7Ow7+bSuF2lToajFvvhoPF07IqcYExBWrm0z7L1?=
 =?us-ascii?Q?5KSURQo+XdYNPDpz6o80uxWprfqV9MLz79LInuuEtYJ3ktGTTOzhSHOm2RcA?=
 =?us-ascii?Q?JhSOauBNIYhbGQAVXkILxuwq5VOE+CR9XTH5YpQx7LWvT84TuH+fAvmUKQrf?=
 =?us-ascii?Q?hZjYmIt/LVP9w5pCTGZNMQoxglO1gwZiG8rtp0GNhj4QdnkuawAyOkWDA/aA?=
 =?us-ascii?Q?MHE+qzTV9Gihi+U2neiJCZl82smd6o9DjaICc+3U7H0OoqYffcgh4q4mLUks?=
 =?us-ascii?Q?PDvQkVsXPNx7KFanBp1xSI0zh10VHwWmAjDv1LIZflonhDBQ6YDX4iOc4PNv?=
 =?us-ascii?Q?ZTIDNqifCg1OKCZQaFMf/LxAo97YK+zRhaaqTudhy795japSxSrZGnh5f6mH?=
 =?us-ascii?Q?z2xEfCD3FruBZpHdyPPmYUYA0heUJM+72V7o+s6NDWAPga8Ooc9l5rpsN3M5?=
 =?us-ascii?Q?Edrbz/PgZBjfHvqvCqLJOu0SlQraMD+Rv0IxkU5UzSA1QuRoGX14+OsAq/yV?=
 =?us-ascii?Q?WrQLoHxpwZee/7tEoQPz8uDcXcixhRtjKHKxwkv9FJGvnNWaJKRaY5XkMP+e?=
 =?us-ascii?Q?VmcvuajLPMOCViuBforhUew5mlzWQqTVP4lpYzV4OI9phwnLUBvvO2ml2Dy+?=
 =?us-ascii?Q?v0uvr3GZn+RgsEAlbQL/+1KhjeOf1IgXnISAE9AInVyp1U3dE9UGvmyV+LbM?=
 =?us-ascii?Q?6pR/bcdEEvF6XBaWXLscghS6praD/C+r2bTtpx/ocjwalchDxfSKoeSCQsGx?=
 =?us-ascii?Q?w2cB2GqsGXAoTAiGSo+k5m2TX7EgwWc4bEcnABa+jGkWEljdWf3/vsUjkALq?=
 =?us-ascii?Q?7LuXeMkubB61tQOjIXUtcyGmA8hIKzVlGk05xB06d1yt3ammpeDbn0J91XFs?=
 =?us-ascii?Q?NlC4EqXxo5w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z5nyxIicp3vQ0Uqu+WB858tZMRANyJudI9omFme47tadettgappdxngVBX4Q?=
 =?us-ascii?Q?+9d+z/LuUpJUgF6OVku3ZSGkZVVtrrSrhJeWtZ9OV4v4f1lGkp78L2qxydZ8?=
 =?us-ascii?Q?+pdJRs8mhQkKe2JKMoBXgEBus4SfRb6jGDVP8bwrdyDol3j1tdEkoVPn1kIS?=
 =?us-ascii?Q?ejtq0zoTFjPRgK4iW5T8nD+quh/Bv7XMVSng6FgOug67Ei8QDmBP+9IXaGPL?=
 =?us-ascii?Q?QsoQlYmFJkuN4sZ88kT9fDiVxLdrINcyrwu6NObuXEXCJi53KIYhI7YHCozq?=
 =?us-ascii?Q?S2veFuUrICehY7V1X0FH/YlYhFKKYtW5g2ardPinPACvkm2y1XlFwzENJj+H?=
 =?us-ascii?Q?YejeQkTy921oz00Am0Qa5oOhbEFsu9f71hBAe59ZbS9FP26Gk+MDsny/XVID?=
 =?us-ascii?Q?nhPKgeUNcNGGLgjbK8EdoVyZoHCtiXUR3/nIh7klfkk8PzCFokgsxKdOugMc?=
 =?us-ascii?Q?PdTsn0wxGfi0qXr3axO2OThDdKuatG4N/jak46hP5FUNNYbyM/1U8qyKGyVk?=
 =?us-ascii?Q?ck4Txk0VhLGDkq4FFCuSEd8BI9xw2/9xfPtd0uz0feWEyERsBIz6XnziXg9k?=
 =?us-ascii?Q?hUR7IpewhOIabfxEcuS71KajqljYHonooMp+/svwTd8iOGrkU7HQsgF6x0Js?=
 =?us-ascii?Q?YY1vYaoEN+zpdwZqy+GQSZAm6rQCJRVB2+7wdqlMC0tfIOpwwejJ5K5R4nMC?=
 =?us-ascii?Q?fQTiGJyIdRl1N5LU1m1Kl1vxltGTqVh90iDV/J2obLoWMZzqSXz6MekhgJzl?=
 =?us-ascii?Q?oaQwhofuDzvol+K/ZhbP7cWvw+20TSpEe2IOumTsDhBuiITFCtnChZtVQbOM?=
 =?us-ascii?Q?j/2YniLHhyvYQXE2ALu6l8ZLtJE7iBFTm19SNrSrhjSn2J62PUwC5I2z2UzX?=
 =?us-ascii?Q?3YwlZIiL/VkAxGhQ8dQr/nx4sh53JTgNfNEhcammSwhaO2qOXhuGEQmHqitG?=
 =?us-ascii?Q?k+9s1VVl/HMsfZNCAM17nq0TMOE47uYV5p3AFb3K80ewgYQv+OBE2/iVyqmA?=
 =?us-ascii?Q?vAZvDHDozDAXrQzBOWPiUrZPZDKslMPePGJAACcKNXJ6TxVmbxXkZ9CoFvvw?=
 =?us-ascii?Q?MxQFuUOKyzaVuZlgL8PSLTWg8psianfJYTughnIgUCzb6+0rScS6QPieVH2W?=
 =?us-ascii?Q?FIcO+cloFzsDwFSjmtcVC5KpkRjanMOYgS7Uga1cmJNka3gbyw9Zxwr7R9My?=
 =?us-ascii?Q?hoNPxTcej7799L/JUZdlBdK7Ts/lQNUz0wbLa4xVK0sYUYeW4A7gQKyxITxR?=
 =?us-ascii?Q?IcViHBt1ISLEtc1ZL7gLM89J+ikfT6vrmY42SWbccxvtRYJAut2nPD0s2MOF?=
 =?us-ascii?Q?Sjhi+9J1L6bTjuLsyH1gTFpEUmSNSiC9FjUDX+nTHulYZXNorpdGjnQj0bhl?=
 =?us-ascii?Q?Cw0PbefmuFNihPUdKvJ0SkGF20is7AorfnD8Mmd41Smd3xUGm8iP+9oqtNUu?=
 =?us-ascii?Q?2SC+MpkUtqtDWU0vGJ45YVllfTjUgOREVJav9BcciWDH7ml3V9cAb5WRfznr?=
 =?us-ascii?Q?ZGDA73E/rkF3QIZy2gH0260i1ue3EG9/CPvi8dKTbupAZPRO5Toi73qLzxki?=
 =?us-ascii?Q?821vmff9bO7P6WtWEaou5ZWY3H6aSgkwKer+nSnt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628ca427-f49d-4913-5be8-08ddf6d5ab5d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 17:06:12.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrBKCztb5f7X87VbB2TLNA+Vi76bIeiFQDvFdnuMAmmAaY5cAMLNJMTbtRMI/AQLWPm4L4cSuKr1Z6vpqmMnAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790

Include the task's migration-disabled counter when dumping task state
during an error exit.

This can help diagnose cases where tasks can get stuck, because they're
unable to migrate elsewhere.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Abbreviate migration_disabled= to nomig= (Tejun)
 - Link to v1: https://lore.kernel.org/all/20250918092928.402242-1-arighi@nvidia.com/

 kernel/sched/ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4e6d83b3b7775..d33e6edef65c8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4266,7 +4266,8 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 		  p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf);
 	dump_line(s, "      dsq_vtime=%llu slice=%llu weight=%u",
 		  p->scx.dsq_vtime, p->scx.slice, p->scx.weight);
-	dump_line(s, "      cpus=%*pb", cpumask_pr_args(p->cpus_ptr));
+	dump_line(s, "      cpus=%*pb nomig=%u", cpumask_pr_args(p->cpus_ptr),
+		  p->migration_disabled);
 
 	if (SCX_HAS_OP(sch, dump_task)) {
 		ops_dump_init(s, "    ");
-- 
2.51.0

