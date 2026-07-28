Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221D3290DB
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253531; cv=fail; b=pp4Fq3WuirUguAd1H900B6JASMwBxYKBNJ58Fdx6EZcAqGB8gIWlnwVlTWEw5TF+CuEONjLQf8TKDILQw4NBYKdx4nZ93SGH8EYYvc3k4AJL30SECkIo1LSgXGcvkjheos6a0XbdEK5zgihJUWRetAHpi3hGPUZfgCs56oMIbsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253531; c=relaxed/simple;
	bh=FEXtjI23Wl0c5wll2BDhTzbUNGiH+8L6A+qEoIYjCrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hEj0KgV1pXztB2KDRkeG+bl9JxDfYxaSeRZryAQGylIMbiOh5bbsJxzXI/lIcOy3HTh1bzZsHeQbuBanqd1kqzx7vVL/3D5aQchIeD2YPel6E71TRki63AxDOqSXhxbLva9lyr153BCjQDmyseBub04IpcOXpRJZSdOwh1p5H7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJ0d3P22; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJ0d3P22"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZD0OTvfh0VnnI+zGVuyQqatSUPzdxxJkeicLLcEiBNXG9QMeWjfUz0bQ1rmBH68pNty5bkt8RTNfKiMfNmFtYwatIWYz23pJAzR8VR29XrbW6P6ce+YWTpWmCPZuUHwn2yYVY2ifCTdWJEIf/knhdaTPx4/H0/6VLxWfXNt2Tubay7MOd7boMOG1R89o/L8fpJH4n1W2lMI+gH5IMWsQCOBzhV3YZPa3x4CmRWIYP6/MNxCGYeLcZuW02/nKiyaccVoG4eiKoxhyX8iA9ljGAAC+unW4qGrEFmGfGp/G6beakSwrhqrljMzw0juQTenrZDoHyzoJcm9TcVhwPjVfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2tcP18k4SWgvLk9VgFuffHUYI2Z/UMRwHkrh5QvTFo=;
 b=AJERgUfu8hqL3FU2dxSVANJ0ZqunDJ+2+b5a2NXsRChWph+gP8tsTBNKUZ9x6ZjgIuij9n8bdsWBud300kQlawWmW5Kmma7gd+VisMehf2+ibj7AIreB+n4w/5Mi6/aGt7lpJy1S+QDG6bXNN5eWnFXnt78XktooNQUDvSKujo0AZfXywRh/9giyEn5ZUeaIiB4boo6iZmBTRqAm2onFCXY+ktkomp4MuekM3A7wIJkGlEzfFIUFoQpT/Y6JXsbmSbdxV5hTDU6HYyokMkttP6c4jXdpyv/Z4jxpleiw8rlFvnt71Vq1f9cSuujGljacXvGpoK1mwf6kxZgkYETRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2tcP18k4SWgvLk9VgFuffHUYI2Z/UMRwHkrh5QvTFo=;
 b=IJ0d3P22s9pJVN8xWuonodZfvWqO+triysaYozZ4zLmTFNK741rhmaqsUa0GLM++CKZRCAdR4j6iXk0B+eg3KcUCQKJ63RS+wuUTT2mYGRt5QzalI0ih1NWneFPpgkU61ah3t1M4KF0oqK2gutoSs/TXiN1naXnWSTTXwsVt/VlgGiM+mEoVUU4PicI/f7E8vCjOv1MZnfnZRp4AJz/vfg+4I5JeYMz/7WZ+QVT3EaVqg6WXX3NrcfS4z58Z0jRfQ4XmBsgAduvTHU8fc1L5G6roc83F0lshIa6Ac8wv+P+FOqPZGlWlA4nE5y0W5bKznSJosT61U32Ekf6YUT2FFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:45:19 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:45:19 +0000
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
Subject: [PATCH 07/15] sched_ext: Block proxy donors across scheduler transitions
Date: Tue, 28 Jul 2026 17:43:25 +0200
Message-ID: <20260728154425.1549660-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B83.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::419) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: c7afce5e-8002-41b6-1be6-08deecbf3a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	klp9mrb4H/AognQX11kbxhbnPX1omfndYPFyyujJEDSANEC2fi0zKmBjU4EeviF8jDWFXPpSofcyj2P36mqwAMS8ONDIfF2mQgCjaxriqGK7KNIf3KiicQg2d7QaZLWoPweqc0qjhIMdbw6X4cUg5y0Yk8rQuDujT0jLNhXXM6gj/rzxm9j1/Njd3W+EtRmqTx9gdxipVgzAMNui3Mgv3c8Dftq9B36NHYJAOjMK2Q/naovmojrjrkdUlT25AuMfF1PAxFCk8R+G5xgwwO9YDs/z+UUY32wTj0/ek8lnRfvnguwXA5edCqY0pYkCcogfNk5mrO76096UJai/VnS9194bNTNHfCMgqhxsEwykihE06J8oi1tQS/LBYEXNUucZPIZAME/TDqTk0kgVadYohUlfyEIJXm8AVOXP4HpMc6TaX7dy4he5HGox9fMJVZNMmf1l5cpxDiWEEaqA7KFMfIaTjKbxpiq/vYOqCAJ3c1y7275iei0x0uW7DV1yX56pJiT1vrom3/O3LaVUAqmyMQDIKSYNG9Yc+QdEIAIlSZp0OgmEwumvcPMs8hqS8tXyR308K30WXBsI5tvz3Q5Ei9ILq3LsNQM8/RAco637jQuWqyUJMqJfdL97GmkAxG/5grO5a8QqtA6nJDtkVSxkZUjAnw2S/Q7eV17TO4KwGps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GL6i/y8fNeRYZIQcjFDp6PXZL4QwdOZY/DOb55O5p28cM+hSxxYobknQgwzc?=
 =?us-ascii?Q?i4P+BGI6OdtCk0reFqAyruOiIC4jGE212iICFfy5Jvn520ztDnNEfA5jGx6v?=
 =?us-ascii?Q?axVNQMru1jg5pNeKbd8I3BcB6hbUzg1pp5tAEF8VAkq7qnJhX2sNOx7C3zvX?=
 =?us-ascii?Q?xQagJjrR1KWKfRUNN57S+fpZHhcNC/Lrm8egBdqZbpkVfZk/s0kjng/XbNAs?=
 =?us-ascii?Q?gAOFaapdEwIl+lSy1qFxvaDr5FQhtbmRIezy2LH8Zt85X54n24LdtYoAskbi?=
 =?us-ascii?Q?6wNy0NxtTSodFr0G27ZT2QbOAYhSy+0XSWSCDGQNeZ7f9rkeACSPsI2I+ap3?=
 =?us-ascii?Q?UvbAM7NekMyaODtJie6Fp0Pks0kT5Qsny/BFylsEylS291GiYlzBfN/8oosy?=
 =?us-ascii?Q?ThJes5WlUOWA8qP6FYWp8DHGBWTnE4avQJJa4lipziltRCSqJ7ir/v0utpWn?=
 =?us-ascii?Q?xNgO/tUp4OUuociUB+fmDwkUc5+8Fvf3SxBzC9957E8GV+fKNh8TSuEidXvq?=
 =?us-ascii?Q?+p6p0dshFXHES/XHoASPf1iaXHPnmPcjXgSkxxieQVKgjrraA3W4e/xz3fsH?=
 =?us-ascii?Q?LCk3i3RzDyO96P0vpIEvD/CoHLROnooSyDiqFwsg5R9nKAF8eyhtSe1juQfV?=
 =?us-ascii?Q?y+rmrk7cyK5jN4GJTndureGLuyh6uB9OdKrhesiu+LDube4cFJZgkxkOQ47D?=
 =?us-ascii?Q?/byNTR3wnW/KZYB1B4NR8Aiq67WBEMa7S7LlJs1oeSz629ChfrSO1zfPcuPn?=
 =?us-ascii?Q?s8VtGyyt0jJ5aV7L1xSV3cLZ1r/vBjJtfPfuz7MfHxe3nzO+WY6b95yxbi1I?=
 =?us-ascii?Q?D3lisxK291jlIlxZaDDGJpUnOEASprL+pH/hmDtjDVFJSQ7vwF0gT9mckO4j?=
 =?us-ascii?Q?nS3mrWlHo/LbFPihuDHXcgxuw4myjE+b7GJdllH9P5r1ayBvL47AYAEmF9+0?=
 =?us-ascii?Q?qtfOiaLWNyz4QlDCPzCU+T3QAoQSX73vrtQxTyZJJiztkjc7XqS7lRWY95SK?=
 =?us-ascii?Q?ibwtQcDh77s2tiS92adLCpIWNlKDqlxA2HVpfyhOPa1OAJzsCTc6DX9oN2Fb?=
 =?us-ascii?Q?c343Ya8NbpsTczZtyMqQ7ipPzRUR8NT4fEEf7wSj6D+GU1/B/WXHYUEaDbfI?=
 =?us-ascii?Q?RDDSzig1kra32O5ELPqfbWkpHyMR5w9gnSJYy3c0UpgWn++R9qacwlYsv9TV?=
 =?us-ascii?Q?iChQVHxnszsu7wRkxJVfupAH0mJZ7hhjNtsD1TUj2d4KT/QdfJ968BBgU3k7?=
 =?us-ascii?Q?qXLo9TdC3YWcArwo7PTKHtCgwr3e2xCouFibcasAH6AZJCQKdqiVmrMzE5le?=
 =?us-ascii?Q?fEyZcG6hgD+A3fqpgUS/d3imvgEBMUDMWmUotvRrw2194G2bxr3hhFKPRA3m?=
 =?us-ascii?Q?xsRLrU5z+2NK0XZn7ixqI1xuEFdykpz2Bqqa44QcehffzT7NTuAa2ycJqB22?=
 =?us-ascii?Q?h7kXXFIem586ox7ReFVFA3UizQQZhjQMUCPs8K8x03sCl/1iUwq8ESJ665ux?=
 =?us-ascii?Q?T9ul5fl2a++o3PoEGj4GhR7rJDv7wUJxkivw4QMn3FzNrCtABPfpoR9ckyw0?=
 =?us-ascii?Q?ZR+7D9r//NL+dftrVFqL4ZMB8tNh/zD8n6H5jgYo64+U5nBUdd5b8/FLYeFB?=
 =?us-ascii?Q?cBltevoj8mpg7YzUjk1A+ewkCLcPuE8XCaIejIzSkLzor8ytjGZhYcP52ODb?=
 =?us-ascii?Q?hbQSgspQkzQ6RKYiTrKH3qY/C8SSEKuRKBroimOODFy/HeWAGxcxQL3fULuv?=
 =?us-ascii?Q?aF6CmPJQgA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7afce5e-8002-41b6-1be6-08deecbf3a17
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:45:19.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akmb41nGh+lCQUSiC6d0sWt/re4DYrMYP6NHrOj1anQWSi1MDchaI6PtYORuKv4zh7vw4+ZJXBEaCsMY+OjscQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

Proxy execution retains mutex-blocked donors on the runqueue so their
scheduling context can execute a lock owner. sched_ext cannot safely
retain such donors unless the BPF scheduler explicitly participates in
their admission and ordering.

Make sched_ext reject retained donors by default. Implement
scx_allow_proxy_exec() to force blocked EXT tasks through the regular
block path in schedule(), and fully deactivate a retained donor before
sched_setscheduler(), PI de-boosting, or global activation moves it into
the EXT class.

This is a preparatory change to support proxy execution with sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 8bc83070720ca..4ee27eaea8604 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,7 +26,15 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return true;
+	return p->sched_class != &ext_sched_class;
+}
+
+static void prepare_switch_scx(struct rq *rq, struct task_struct *p)
+{
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
+
+	sched_proxy_block_task(rq, p);
 }
 
 /*
@@ -4748,6 +4756,7 @@ DEFINE_SCHED_CLASS(ext) = {
 
 	.task_tick		= task_tick_scx,
 
+	.prepare_switch		= prepare_switch_scx,
 	.switching_to		= switching_to_scx,
 	.switched_from		= switched_from_scx,
 	.switched_to		= switched_to_scx,
-- 
2.55.0

