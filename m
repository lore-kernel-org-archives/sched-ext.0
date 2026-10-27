Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793099388;
	b=tGtZWsfN3quFUt4DcS/xZUGPerkclBoXbWrVjvwyAsgHwim42xlBVjn3vBG4lJT62YY2
	 KkLnKvSP8nJoNiPP3qSuk5ejxKYQRzz1bojlOi3OeHlpiA+8guxlpecJhjOT7V2ddJe0g
	 ar72e6ZXp9UMUGewaWqa/S+2JhRM2iz1vhUYFJc6wwNEKpc6KFQOd0bSDJtZc004sL4vM
	 QGKXFFh65GlahJsbthpL54g1EIEujafM6YkBTsVqlLiF88LmuNlSirlHW5ZCHe8exw/rX
	 a3mc7s6insHt0EDGq7b5g9RWNvOtYIMEEYOrecAJyedroP8xuCxKQbTOPQ8MhVEzRtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099388;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=upkT3vTLjUpvfiUzZSr0d2yk3KbwqmgsUVh6DfNCsGg=;
	b=UMF1HuNW0JDLRt+dFEwH9XQ1cMXqrylZ4Exv63hY8OEQ9ZAzDd26Xm6xtIBWTVq4KNMw
	 BuEVixyIjlqlszAWisW5Y7nK0EUXvsgn5SW3tHwBXcxyaQE3ZV51JWrpoWSetcAYq2knU
	 nZT6JA15Ju4nFTfrNbzYdIG9TV60onF3yMX833f3cISpWrDt2jeY0pR19P1u4yMqZZBis
	 PUFRCyqFLvBYXg87ztSrmByUTdvh3qEX4I6OTa/u9tSJ/om0taCzOcvCJ+oByW6Btt6tM
	 jrsFn5J/7/EqgcFlgZ9GoZXCMLhPLnoiZt5cYYL7GjkWLOOgnfgNfnyzXQLFN+TdNiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s48ffASZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.71
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4D606A31E
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 11:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEA4D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s48ffASZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xvgu1AuNbVPddKsu5P6kV+BopVsy/vpmiW3p3I/vb/d3fRiyfwBw4+eWymQf8IUHdYiDJugFgjHzvl3ageyqUYh2JiqGpla2uCRw9SpH5TVyiSTH+F1LLJf+N3raOUilFP4U+8fTJjpTEnt3DERNjkfSzKZ5GrdSO5Rg2MwJsEAZA8beR8LF1y44tk5mM9OKMjPZzJE7jexdowxVcaOWSt/RY1wx7qakx2n5WERC9mj1bLjrVUwzWLyjMLbKVJY/AZqnYj0d7Hcj2Hsiu7GM6Zg6rYAdEXvdCX+22KKRv5A7p+oINacKM4rtbKxkbNHEDdmh7zS5nmuq3+CZ8c/mUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upkT3vTLjUpvfiUzZSr0d2yk3KbwqmgsUVh6DfNCsGg=;
 b=w0OHtkt3Z3roFkiBg2/pQsOcsYRFe6QBX8SIAYXUbOHYlY6Xxevczugizy4xdN8ZXcWFqH5Ec7INF8hyZqoMXoQcvRZ+0Vjq3N3TiPAXPrzhjv7xWma5/iWFBMDRjwQINegr3wilfQwOQEomcEPBkxXx2xk0vBKRm1Z237YxhkJpTWPc9FS0M49NxWJjPaYwtrAfIaLHryCphsFaqW9dpt88ftyvnzwIZSMVQ+dH4Qty8+xCtP8A3sHxbWGLUaKzk4wqIyg2JnrHcp88nLS9z/2GxMhxt9bcZLQvKou08yiHoXEWq/8MvuNXjLunRKg4RFsT0i8HO0KjR0lqF24Onw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upkT3vTLjUpvfiUzZSr0d2yk3KbwqmgsUVh6DfNCsGg=;
 b=s48ffASZP2yBdi8Bui6V/hbO2K1+EplPMNnHokRJzgym6Mg7On9ENc/LqRwpQrCNdPjnWdDb5pfuP1ddFSHr6ssJwdqQD2Q6jfU8/x5gUzUXoyk4N/1eXE2j5r7sB0N1US0yPU/Lrh8QrlU4AG5j4wiy43UfMJom7VNdIkCxXP4YLJ8Tqaax8ARaAumY4gSL2ynUcuKJhVhXBm/DMCQW4VBMPakKT3zu6wYCf2cOQTAnVkQuCTMN7DB4Weav1GwGOjeh5NCsWsVysbgdFXjP2Raj9sOBOeOIb2j7bQ+rOa6yZdVVxWTBZf1Y9HbYRxgSH4jVgGoSYHaRgJa29CqADg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 11:09:42 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 11:09:41 +0000
Date: Tue, 27 Oct 2026 12:09:33 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] sched/numa: Leave the placement of a BPF-scheduled
 task to its scheduler
Message-ID: <auCGbbLTw4qZS536@gpd4>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-3-arighi@nvidia.com>
 <20261027104317.GC2668564@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027104317.GC2668564@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: FR4P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::8) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c8abab-6a5a-424f-ca60-08df341acc79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|6133799003|18002099003|22082099003|261026140227099003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	p1NbapFX2sRBhidTTQdZa1ghH2sCHeLedIHqYbmJR3GZvD//yraYc21kTonILUz9FiMRd/B5UaL8JKqEFRMoUMFIhSAGmTf5QB0acfbBfD/qpj4ngDx4tt7j9jJh7X9nopCoK74lMfS4aAZeUDpO56aTOz95G0KGAXFoM36TkFcWbm5CiU76hBmUY9u9+Z0riIv8LLjm6JlyrbmMNVngVqftrWNogooPeNtXNz22Yum0WvpMFBGRzUslP8ySjkEAZtBGqpLQ3KYTXKM23Ox4nNjlM3/SS+B9TAM/0htNZoCqCjJ6oh45towjAbHZNAqtPnXfwGNtU860iIghF3uP17kQohbTaVer0lFst2u/HOGSoDBMxkbsM9PGiaAfmLhdYpylHfclPmXZDzkhComONTINJkEauz7UeXAy1LZbU2RkLehUyHQuPuysswnBApXqZ6j1tFAI5zJQlSSKiQGnmMotS5PWnbE5m1rNGF5ewWQxcPAvE8fdDpGPAHb1j1TWT9EXeNNXLv9nTV1Wjr2Zm4JyLFpxz8M+xhAjVRLld99kXzRrJZgsJ40P5BMMk3AZq8ocCMWnL62y10QkRQOebV1bSOThjr7YZW5MRRfQTqfwNR2MeShdnpgiF1sSyQLjP/n0SSG1MG7urrioA9GMTEE1JW4gQcOkR1ye+zIAM0Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(261026140227099003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HzVoFe3dke3aN3SILRWfkPMH8Xd3M+EnIiB+UxmhWQQiOuKiUm7yEu0NpghV?=
 =?us-ascii?Q?eVV6LBz5lzwDnLMlVDwNp0x+3K8TqBzvWJGIP1LdD8L780fL5tsDMBzkPI53?=
 =?us-ascii?Q?B3q3jN9rPGlAeO9QTAt/VwkZbrICn7zOWqWA/effkZx30w/lYYrKHQmJZeAa?=
 =?us-ascii?Q?3v7VG1TFec8xDq4GV2YkASsMiIhzK4cUTf0uc6/fCT6NiHbONfjWJafekKfe?=
 =?us-ascii?Q?je+NBKsZulk+q+sO6snRqzJmyPGftVVWOgI+QbkrZOb59kT+qGELUg1Nm0yT?=
 =?us-ascii?Q?LN6gwF7FMWCaHUEsDshA3TF+oSGp4kX9Mb3fDYR11HaPmjFoq3AhgLuuek5u?=
 =?us-ascii?Q?J/BZakNbwPuBbTyVQDtOIKSKt5UzLpulmBj6b517Fm0skpu6+Rjm5P+VBVcA?=
 =?us-ascii?Q?xzVBHKqbFApP+SrgkLNC6mEB3fsHs2szwmBAYxEDaPYKADyM7fAcPxW5tcWf?=
 =?us-ascii?Q?vnrrx4vURzFVZKX0XdrZMI/k7k863qpjM+RALO95TreWKmIgnbbkdtTQ50i4?=
 =?us-ascii?Q?nHiimhIlQzxBInkHZmcR5EtBuOag6Erchds08ClR3eiKTcuIITjd6Aben8jF?=
 =?us-ascii?Q?bCWkKZn48miU7NisvFJCOXzxng/hKIOGet+BlksN8yQXOb3Vflzh0wPOHSJj?=
 =?us-ascii?Q?5LE7cSjVne5w53qmbYPUdxqG0084oLjYipAu0OfbqjtEHdJMTjjVy8aY9xXt?=
 =?us-ascii?Q?s6ZNDHwrGSx8GFQOssRI2ojSnj7OLjNcTdPGVh1O2NPR3xgDbPKL+i9bTVBk?=
 =?us-ascii?Q?MaMRZLl27yqVUSKntBqHvKGFq6PDaZi6kC/RWRlb8caoB9XMn12zAAtAWvDF?=
 =?us-ascii?Q?rK/0S5SxsO2AUCuJESvxLe59+9yXTFuTuMCcWZPzu0uwm5CrNHthVWBYhuya?=
 =?us-ascii?Q?3MursPz8Kbzz1+C2FyiLUmPFcmqXdoJiPvh2keksVOV+DJytkN1RZkQLN9w+?=
 =?us-ascii?Q?h6Oxp0LkZyKThUeJWVZ/4fWk0/qNn4FweN5EOMTPen9WOLga/QyUYWMTMMph?=
 =?us-ascii?Q?MZ79xeksneM92X501ijIZCcWiDQ6bWjrWv1dl4MZl7g8oa/Fjos434JMKbXj?=
 =?us-ascii?Q?DQqm/l2HhOfG5hLd+vwiUGWlqEn2o4UhC4X4fp0L8blq0YgPRYgVlE3waJuC?=
 =?us-ascii?Q?mYW5E7Qu7rXb4S5NjnFQQ/k+bEIv5KF34zo1XcvHrP8I4IRsvfn6kj+0ogx6?=
 =?us-ascii?Q?xlWNmStSJ+PVO3iUt22BoNyKvMfFwzccqAXxZi5mBuRNHEXKKDV0XM7zKyU2?=
 =?us-ascii?Q?xOfOfIfVtW3Gu/nIHRpOHZDRmKN++UcL7U/en0mOAc3DJptV0eGfF+osRsj3?=
 =?us-ascii?Q?QgutNJzgwJaGzDUIlHbhpt/vfIXeBFAQB7avsY7LPPvSxPYsjTy8ZuIFdmm5?=
 =?us-ascii?Q?rmrJUwGKw5NH72EOuFe8RkzBCHEmU8jJ2w308Z9TfBbK0wX/RNuiQTpXuQ7n?=
 =?us-ascii?Q?KFYln42zWBKTYXCYjJ0Xfd1BLi8fR6LWlZPsXSK6Yt+Wce0JBpYg/euo3/8X?=
 =?us-ascii?Q?QlM3P5g009n7l0HZwFbibOgo8UjW0n8ZAPxwFWyDMTdSyIHAX0I40JIHJ2D2?=
 =?us-ascii?Q?+NMjbVPq+5EgI7FkTJBlf8cfosCvmvFxeKDHaif0Yp9527ycwbhy1zXgXkSa?=
 =?us-ascii?Q?swXcLw5wdFFiP037x+zP6jfCx5Rmyokte0ll9lx+qs5F1DGSFnoBkaR3JkKM?=
 =?us-ascii?Q?EB5f7pXgsb/zTapWwbkiEfrCcZk8t9zNXzox1NB7Epej4b5KbTaGA7c1yqO2?=
 =?us-ascii?Q?ux9GpONSjw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c8abab-6a5a-424f-ca60-08df341acc79
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 11:09:41.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZXNZdwDT9djxYUX0/9jfbBGIq09rS1bGh8mPfsYzOL+ydTh/vjIjWMYcLBlzCpbYRajCXrbrQ39fNwhUqF1IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532

Hi Peter,

On Tue, Oct 27, 2026 at 11:43:17AM +0100, Peter Zijlstra wrote:
> On Tue, Oct 27, 2026 at 05:13:31AM +0100, Andrea Righi wrote:
> > A task under a BPF scheduler can take NUMA hinting faults via
> > task_numa_fault() and then reach numa_migrate_preferred(), which may
> > migrate the task to its preferred node through task_numa_migrate().
> > 
> > The migration of such a task should always be driven by its BPF
> > scheduler, which owns the placement of its tasks.
> > 
> > Keep collecting the statistics, which is what makes
> > p->numa_preferred_nid worth reading, but skip the migration for a task
> > owned by a BPF scheduler. The scheduler can read the preferred node and
> > decide for itself whether moving the task is worth the cost.
> > 
> > For the same reason, never pick a task owned by a BPF scheduler as the
> > swap partner of another task that NUMA balancing migrates, e.g., a fair
> > task when the BPF scheduler runs in partial mode. Such a task is
> > treated like a kthread on the destination CPU: the migrating task can
> > still move there alone, but the BPF-scheduled task is left in place.
> > 
> > Reported-by: Vladimir Vdovin <deliran@verdict.gg>
> > Link: https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/fair.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 36df9a4dde534..5064c7b707f4d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3267,8 +3267,13 @@ static bool task_numa_compare(struct task_numa_env *env,
> >  
> >  	rcu_read_lock();
> >  	cur = rcu_dereference_all(dst_rq->curr);
> > +	/*
> > +	 * Never pick a task under a BPF scheduler as the swap partner: its
> > +	 * placement is left to that scheduler, see numa_migrate_preferred().
> > +	 * Moving the faulting task alone to the destination is still allowed.
> > +	 */
> >  	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
> > -		    !cur->mm))
> > +		    !cur->mm || task_on_scx(cur)))
> >  		cur = NULL;
> 
> Rather than check task_on_scx(); your argument with Prateek seems to
> highlight that the actual check you're looking for should be something
> like: cur->class != &fair_sched_class or somesuch, right?

Right, the actual condition is "cur is not a fair task". I used
task_on_scx() only to avoid changing the behavior of RT/DL tasks, but
the same arguments apply to them: their se.avg isn't updated either, so
task_h_load(cur) is stale, and their placement is driven by their own
class (push/pull), so fair shouldn't move them around.

So yeah... "task not in the fair class" seems the right thing to do.

> 
> >  	/*
> > @@ -3645,6 +3650,14 @@ static void numa_migrate_preferred(struct task_struct *p)
> >  	if (task_node(p) == p->numa_preferred_nid)
> >  		return;
> >  
> > +	/*
> > +	 * A task under a BPF scheduler is placed by that scheduler. Keep the
> > +	 * statistics coming, which is what makes p->numa_preferred_nid worth
> > +	 * reading, but leave the placement alone.
> > +	 */
> > +	if (task_on_scx(p))
> > +		return;
> > +
> >  	/* Otherwise, try migrate to a CPU on the preferred node */
> >  	task_numa_migrate(p);
> >  }
> 
> I am somewhat confused on all this still, probably because I've not
> looked at it for more than a couple of minutes at this point :-)
> 
> But rather than putting a callback in sched_setnuma() should you not put
> a class call here?
> 
> That is; have this be:
> 
> 	p->class->task_numa_migrate(p);
> 
> and have fair set task_numa_migrate_fair(), which is the current
> function, and then ext can implement the BPF thing.

Yeah, that'd be a much cleaner approach than special-casing ext in fair.
But I think it gives a different signal than the sched_setnuma()
callback.

numa_migrate_preferred() is called from task_numa_fault(), in the
context of the faulting task, at most every numa_migrate_retry, and it
only gets to this point when the task isn't on its preferred node. So a
class call here means "this task is misplaced, migrate it if you want",
repeated at each retry, even if the preferred node remains the same.

The sched_setnuma() callback instead reports when the preferred node
changes, which is what a BPF scheduler needs to use the preferred node
as a placement hint.

So I think the two are complementary: the class call would replace the
task_on_scx() check here (ext can just skip the migration, or expose it
to BPF if we think it's useful), while the notification would stay in
sched_setnuma().

One thing to consider: RT/DL tasks would also stop being migrated here
(they can take hinting faults too), which seems more correct honestly:
task_numa_migrate() decides the move based on task_h_load(p), which is
stale for them, and their faults only come from pages scanned by other
fair threads of the same mm, since they don't drive the scanning
themselves.

Would that work for you?

> 
> Anyway, if you want to do this task_on_scx() thing like you did, its in
> the wrong spot, that condition right above it is irrelevant if you're
> not going to be calling task_numa_migrate(). 

Right, I'll move it before that check. It still needs to stay after the
p->numa_migrate_retry update though, otherwise the time_after() check in
task_numa_fault() would be always true for scx tasks and
task_numa_placement() would be called at every hinting fault.

Thanks,
-Andrea
