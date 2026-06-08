Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123FE36C9CC
	for <sched-ext@lists.linux.dev>; Mon,  8 Jun 2026 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926563; cv=fail; b=fy96wNE1xLfYqIMBhPly5ndOVWY4xaiENNZhgae7XZGtgLbszinZCJiqwfMU/BIt0GfTsOkA3FkNu2IeDiH0EcWl36TyEEl1XEAa1mS6eSbHKv+oPejEKwOQ9OJk8dyNCmRmIie+4A3Iuo2hDKIczyqrvdK5/J5PAfIphwTxNII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926563; c=relaxed/simple;
	bh=TvVV3AEOvPuFP+A/pAE54GHGSIVx17lFClgqLLwBaj4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eNKDvQz6ryxWF9hPXyvRDtmvcWxcv7OXSbxDpCsLBH7A4/frnHt+SbyAc6+WnBLqIHi++5cZG76Z0S7pcnpm08oz9JzuUcKRB3fdyeV7xnBsxGCazCrQmk5QSZAY+UiCNY6wcHIj+THzFUoJ1InfEaIT7VX74vQ10CFELpjMAM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WTgXoAQG; arc=fail smtp.client-ip=52.101.61.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WTgXoAQG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiEq+bHzJzJyTfN2kv3e4j5Ti9+t3p977IQfCMfwykSWC3oT5D51KbeCMf7I+/VIQ69CZiiXXymqspd4YKppkjK4livEp85uqao3m416UFy2AfibmRogb3obHsN3gErjRE7Bj9WyOwI9OkjlqRpFIH0QHgDZxF7orC6lQFlOMPrwYs8xNcm6ILtlKgdMELTnHyd3AECYse8h5G9rQ2NyIuary4bY9TRbos+dvEdvAPHpIXUBiNWJWvCSlvSbLfkBYRDRk0l2DvKskd3/CPB5IgRbIgBBVK+9ug4kcdp340fEB2di7TaC2V31fBFUtoHBQI+LbRNTgHtdG0vnJflkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxNfsWB3JTf/22aH9bpJ+vZXc3yspnZDnkLOCKqhCm4=;
 b=Ai6h3IwuakJlMuwKoU7ULmySD1VQY8lQMWaN+aaFkfmzmmaJEf5Ix8kcIffjjcDMvA9dDLWN8iei8yjPN/xspDU885rEK6vCt9bUWxrCas4QEoxZMMgoYce7KPU62EQmNStUdXbFyQM07ymfkDtqSSyv7c8J414yf7eUiWEo//Symw2m3JZ97z7oo+plLLtWyiXLg6zQ2ZGPXV9e1ssY8rwBHkJX49NE+0VXmn4ZBN1Bwv8I8Ff/kOYrsZVmMcvHpgYSjxi/BcVpC97lRT8QTqA4S52qySrTXjHRYtUCCWHWkbj1d2GQISPl7lUwE/ne4I5qrtaqWKmOApeKXxvk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxNfsWB3JTf/22aH9bpJ+vZXc3yspnZDnkLOCKqhCm4=;
 b=WTgXoAQGW8HASl794hXe7f5w75mt28Rp83G0mfrCYjox4XllQsvKQXgqMuExOBY14F+RVBwM2167VZiXS68yfm9pbqDu6Se/jL6fWJc5cMTova1QiNp+BXfTE8UyuUCvbzNjM4BM8vnQqI5mQ59iGyOHKkd/di2Ewu6tMK1Bys9eQjhgZP1WcNEbE4KhgVB9k46bZaDqD1+AntawOsYVR7E0SLP3yMh/brqAS5SDXW0+piMxDmavQRAJTzzTu5BbaUXxfejpOCT4CBixRb1wTdqgIpu5KNy6Irl4ZTpDTO7QcQ7VrosEjmxbyN6xbXH7E5zOePpy2sN5mrB11gBVGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 13:49:17 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 13:49:17 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Reset dsq_vtime and slice when a task leaves SCX
Date: Mon,  8 Jun 2026 15:49:08 +0200
Message-ID: <20260608134908.3232097-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e79179-74de-44f9-019a-08dec564bbc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/vgZEWGap7CdD63zmKi2mJDC8vpaix0rgdNXuftYX7GpNGAlVjLU510qHCk50ICdYww6WMrB60l07EHD5uY/rpofCl5uarGwCwxI3CcCxGAz6l1GF4uvWlKcKZP7eAo0V+0E6ZvHNWHxOOz4gh8JOLImvS+NqcGUC0zx76u7o0VhsLQVZd6J6AmOXpsLVIIPRqd0Lt263SVaXlJGOOjOEllupfvNJhVreAcDJaTnpvcGqge5YAgreYduXRHFNBI2Okg99Cjgf7XW4LPmgyNU5ks6qe9yqKRI5mmNQ/6VGmMF42Bv11U9eUqyVtaZfbQ0NX9l3mJ58SKVt9+dYQJdMxuYpxset8KSVeIaMCpokk2oG7A0UZJ5q9XTLAVomoQdlA8I105zrWkldxY/4ikZm3peCwavqGtyRDYCfB1gjFJVxlENBVg5dH2FgeEDVas2hW3ZEA6CEc8yseZaGIl7YwwiinVrjxePVao1qiphj4tsO5ZiplEdwuPFheB2FSA8G8Xb6Z6AQOJi4/gDBsTK87XDTSVPpkZuCJAq+/xdSlt5Xk1+A5IXRhzFu1wS8nt9lXxQEQAJH3E4PH1ILPBM83AJk2N35G+vzUD+qbsZBzciNgH7TgXRw2GQL1nyFta9xnsGhtOn9MEXbf/VARKK8tH9rfVEpxNAVZorekt2l9Ms8gQoqRSRhApR6b4dQ2aq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d3fPO2cvnHjD6T3GTbuEaScBXZmVnPWwBQWLeeqJ9jujQmCK4R0Kl+PEgKnj?=
 =?us-ascii?Q?qJnCS/pwPE45oqrkwQ29sOp3nbdvldTs4jtR6jABnkGX95g2ZmqmQ/cUfina?=
 =?us-ascii?Q?Ml1QUL8ODlH5opDfZmB6YQ3ZzRFD9B26xqSOqG/uG4f+Cpk0S3saqjbfrDVO?=
 =?us-ascii?Q?TGJQA7riQ2dgZb6MwPVpvq655Whn7pYSqlKxRclWmrVzz9erj/l4UKmKktuH?=
 =?us-ascii?Q?BNYXFmHC06vMnQzKUfWn4WKSZkHhzP3b1RnJGgyILOC8IPnvw+KxR66uVzSJ?=
 =?us-ascii?Q?/KIy30J+YNTj+C/HgbnJcfsTGWOX7q6HUDQa4FO228gSCVC2UUo7bA/MA7/c?=
 =?us-ascii?Q?vCmwPTyh3XZ95pOlKR7C9O7vM6jdo1+uSZ02pfhuWAvTGH1FYjWbdIlWYdxZ?=
 =?us-ascii?Q?41y+4/kd3f/MJp3Zx/ktE1ieSUxALFPP39YRRMeZfZpHJ/lpBNyIvX8flFKY?=
 =?us-ascii?Q?Yc5zv8+DDmisXzx7+KMR6UNu4N7JMp88V1bFY6KUfFwt+X68ICwXb/maxQcU?=
 =?us-ascii?Q?ip1RMeTnvXQi44UguvOcat2IMmTGqFM0Xs727xPynVL/m8yysu3A+JRyTUoz?=
 =?us-ascii?Q?GXvdTuiPsFs5cjznJ1d5mqtnR9Kjr3+/p1xqgFiPPlvc3VTglwYLCLb6o/sQ?=
 =?us-ascii?Q?/aSD7qSsZ8db0fTqDJl1v5QviSxKL0T0uvHmqDoHZHE8GPs+xq+Y5TaOqaFC?=
 =?us-ascii?Q?Ru6S+FX9Pxppnalju4E7dj73Ym1oIH0N0EtlnIK8CzfaNh3vZ8TOxMznM65J?=
 =?us-ascii?Q?HeM/qyqQdZERwxP4DqNoEBiWURKO3n+N54K9S13UkfJ2B/tKtmpf27rzbR2/?=
 =?us-ascii?Q?mzotK8zhasxX6mZ2xcLbBnhpgBU1BRJ9Ryl+zMt3FajgxIKYW9Jle7YS6QKi?=
 =?us-ascii?Q?8SNQ6RYCLxwTVJA9t99tHGmmFaKdzS2wDH3GNq9eWQkOz7lbDylVw5B9BlO0?=
 =?us-ascii?Q?opbbJHIgIqLZGiu7orQ12ps6Hn61b9PPqnFhHJ/6CcVh2Ra1Se7Kg2ItoAEi?=
 =?us-ascii?Q?zNAQBvk27BNwPcm33U7RBfzhc/n4hO/Jy82XWBmGaAeYgknBxWDgSEtTaIaF?=
 =?us-ascii?Q?IyYUok+oBIcNZIYGil2S/4pgBOZ1vcGK64LHM+iWZNSeaVkzYS8sOXEkCuwm?=
 =?us-ascii?Q?180pqJHvMJd1zkkhvp1SBmCb4pLX2GwvsKHyxFcsZaePnp4lYr8yo4Rp6UFi?=
 =?us-ascii?Q?9/I+a58rA57P6OGEgH393KP/W495oSPlj/pkgtWO08ku6WriPrVsEDzGeGM/?=
 =?us-ascii?Q?UJFz0dnR3RATtlm/da9yK/Gaz9FuZ0eefj3BKboshpb6zjxqeo4bnagcdghJ?=
 =?us-ascii?Q?HnrNkU7X8/RQU9ZY/rbud3HnnUCT+DUFWPNMyjHaBzLyqJPZbwRkX8d9DVF2?=
 =?us-ascii?Q?JOFaT5JdwCwTgKWgluf5EMtjpGvNY913ELBmTpLr70HVSGymDDbMvT9U8CAL?=
 =?us-ascii?Q?jW/pCwTxBR45F+urbRw3IvrBKd1zjo4Ph3eDsElAnyd6dc/JqzibaoOUBOjs?=
 =?us-ascii?Q?DkEbt6p6agVIv6VKLwAZM4UQS+CKFcyiFj77hnX+Eg82DfjGwZEI68NO03Te?=
 =?us-ascii?Q?R133UrzW0dXXdmPwr+Hb8kRN/Ntczp1g7tPTHNMes914M8c1PHWoN5613iA9?=
 =?us-ascii?Q?gsWPiLLD41p61uJzrj+7c/FzjOnPSCFCw6O3kDnZyElMtz71QTynx4JjjkbD?=
 =?us-ascii?Q?xKkOiuW1gwaZ/De52+Ml2sxr9MOj0SVok2qwK7jyDzzjSdio?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e79179-74de-44f9-019a-08dec564bbc8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:49:17.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jv1jVAX/AzZ2lt21EmsH+Umzs28JSJ/7OGd75XRuZeNR4kdlkNlANiXYJC1yFIf1OLA+ez6AQTEAbNwfbLm4Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495

When a task switches out of the sched_ext class, p->scx.dsq_vtime and
p->scx.slice keep whatever values they last held. On enable, slice is
reset to slice_dfl, but dsq_vtime is owned by the BPF scheduler and is
never cleared by the core, so a task that leaves SCX and later returns
carries a stale dsq_vtime across the round-trip.

The stale values are also visible to other SCX schedulers if they
inspects the scx fields of non-SCX tasks.

Zero dsq_vtime and slice in switched_from_scx() after scx_disable_task()
so the fields are reset to the same baseline a freshly forked task has.
The reset is done after the disable callback so the BPF scheduler can
still observe the task's final values.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8e88a25bc602f..915d5ece5d277 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3942,10 +3942,11 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
 	 * scx_disable_task() would WARN on the non-%ENABLED state and trigger a
 	 * NONE -> READY validation failure.
 	 */
-	if (scx_get_task_state(p) == SCX_TASK_NONE)
-		return;
+	if (scx_get_task_state(p) != SCX_TASK_NONE)
+		scx_disable_task(scx_task_sched(p), p);
 
-	scx_disable_task(scx_task_sched(p), p);
+	p->scx.dsq_vtime = 0;
+	p->scx.slice = 0;
 }
 
 static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
-- 
2.54.0

