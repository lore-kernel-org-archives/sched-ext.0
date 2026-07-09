Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38283C7E17
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629721; cv=fail; b=hlbCo6vniBMBrJ0Q/mqNMmIngiNDIy3PvxwCChEiZxxeJg6Z1doNxT7F0tls8Rr+vOGn9LpVsHL460wnPa74iDO5YPXN8abyjXTQXwPiArq6BlY7upjuqgAGCGMhINOJpICQl2gdygcuIWfZMusBGEAsB81nZmjR1Z2D9qRwc18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629721; c=relaxed/simple;
	bh=0pkdAR8FYS3BPdqpH3WoQzZILs/yMomEHxxnxC6UA04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UW5LGRrDzhdq228EjbADOuo6L/Jz66Xxz8p4qiUFpVd7RPoxSv54EnS8LdyIfVGNFtcoQ+y3kGypiU18zKXg+BhVzH6BogWoeZIyEqAnySgyMv9g/ummRnB8Ay+B5PGR1NQH+Zf9tsMCTR6BNjND7m0hUOKy0yEacCosGxXVB3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HdWXH/kF; arc=fail smtp.client-ip=52.101.57.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HdWXH/kF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjThWdFCxpY00I3R1h423gotlQFYOgj1PGOVwRi6CuqkAAcjkB/Nx6ZgyD89SZ78+YF7kSSaYKZFkPTZkgrpCDoQy59gIZbqYD33PCPdAwC+dR0dvqJwFooaKb8o8CGTbK6QaO4+KRCn22TK4pIjXlFZzmTAsaFrSPj1r6WNTr3HW12aA6a36dT23myWaPx+F6yPU7TYRIRJeFM9ZvbeV6xK4Vyt9xS8CtL4EKV8Uv5nJ1NvfHJRUyQ+6M0GSV3PHtV3Zm7YRQgDKWJDovCSShthnDdtPg0thIDFiE5dvhyaeZNYpikJnjDGdUoxwLVbXzhycKPKbjvBa+FTW+h+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5OUBtbwApRftvCSMSt3OutoqVNHn7v9fa2MidKQvxw=;
 b=vD2yq2skIuPMd41QHDEjdZ5jHvt9VkMGZctRoyYoD0q6eUiyZ7e/JyevQEXjI+8eNqMGOOvvG/SW6siwDp0o84G0YmSIetOrrGKob7XJv8xl0fpvqG6F/P/4i4xYKx7nOlk4BtnAiyC8nU61KuZolK3Qt2UhpEcrKOUjuJt1MDAKBpm9B/Cq9izbe/wWttDqd0CQ+Jv+/0/a/qsKpeh8CxgAQ3Yex2E6k99FjdnqIYkyvB7RmK6znuxWh/rp4LH/b+ZI5ffsJIjGkGRQ6Xp43qTIpA1wqJD7Ti2QrRHarKpUkrGN+ds5LzyfKlyHA8ezwNuRu97QkciO5Umw1yDV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5OUBtbwApRftvCSMSt3OutoqVNHn7v9fa2MidKQvxw=;
 b=HdWXH/kFJIhPtEnBeVvX3kXu2PQQkRF+mmjJE1TVHpy14uY++bq/7b8jOOUs+qJp05HTaVqiesiXp2PMPeCsvk0RQQ4+u3Lkbm++mQq3QCtwNJy1rgriUvjO1j3W3bfgzWU8TWE6kJ7QWwRgcKbAkf6sgtEe9zl5Wlh7dHV9MfAbPvgDdBj3MPToSnOAWfbLgmAIemE+Pedj4FKJrhXUeB9dukQVWNnCLdHzoNu2foqr9/hjDz3a1Cd+wWnZODWLcyL8UYuSc6nRqCxSdTTsE2GzjrBq2b5GQWXtKMX4mEMNvP62OgjpnT/YR+BL+0vzo6fTaS6l+lmsDQrAKEGwYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 20:41:50 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:41:50 +0000
Date: Thu, 9 Jul 2026 22:41:42 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 06/40] sched_ext: Rename
 extra_enq_flags to remote_activate_enq_flags
Message-ID: <alAHhmsgKv4Uv8TV@gpd4>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-7-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708212429.3405787-7-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 5040a6ef-058f-4df9-293a-08deddfa8093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|4143699003|6133799003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y2LZIrgd2XpJAd3pOoG0fpuzAGH7W1tClg2dkLndd8p4AcvU4AYyvXD97BKhBxCSnRmv/hSZICFkmWl3yfIbmk9qiudnSmeAkZzlScAI/FEKFZ5xscFUcMCQYHCwSMa2fXHUtUapCdwAgZDDRoFunBr3XUeZPoyl1YkTLbebRaU8nRYIJpkBs8EM22gZc9UWW9cX3+E2bNC+EGFbP76hHFCqTDBfmMPtCnRyxRzEvuxO6uNuwEn/eZ2ikDEINJsZ6vBXSrsEb631d2Zqo0GLgb1VkFEFCZJt9LQZWbX+QWXvN/EyrP5ewO10QSNnVzSBaM1Zzm/zCDPjH8orGUFNR0D6XOd0KXKPI1FzSj+yyic6WT89J4CcP1DLECRGi5GmEgpXpOpEap4E8EbTfADI/7zhTDjR+5oc4XEN62p6ua4T+KBWgfE+Znj3csl5q9ssnenvUQ0XJ+XCcX20qDVUOJeQghTyDal8/m0RpeBiXGDSoCPAeSOtXgnmO3Ns2vf+VHqclsp8NdsAp83yNCewJLAmFlhDfdnztkeTJnOWZn09kYoV8SQQhh+nNZizkskvHHidg1iAoqWWUM0R1o+y8XNSMN9xRM3exypMKM/iz37pbfMdTBot5dKxK1Sxtsc7D29deRIiBX/azOWIc2rhjobEvr3nUdaVTNFiUyUtwVY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(4143699003)(6133799003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U19byr2rClrEIgo5aOk6lXVzUFj5IcxHFDNWFtxvwDrRj7Wby1ynYZt7a+Oq?=
 =?us-ascii?Q?4n4v5TLPX37jM6z4mlTrPso5XWq/rQZBYI7eEY4amalkM/mxtuLo5rBczUju?=
 =?us-ascii?Q?UqQPD8e3s+VsN4sFUQW1rcntorjhbSyY4w0IRIsMXl3vEVwKF4ZEYhBiGN6k?=
 =?us-ascii?Q?cWf0Ql7ovHicSBcnThaCpdAsaNXp9uhYaDKydMO/U+E2ckMy2Z+8DShgcJ2b?=
 =?us-ascii?Q?QaLfE1C/9JuGZRwg7o4Z5vuL/5Pu5u5hUOsZNSN0LFZqYpUmX5J89YniHWQh?=
 =?us-ascii?Q?K5y/YCpRrYLHHp5gAiV8rJ2CdVoQLJnErHXQcuxpeda3Q+C1BDnh5AXTzS2r?=
 =?us-ascii?Q?n16BLEw/118TJaa2dl9NwDAbRVdDU5FfSLy4qDG99V69+gFQrU5ChmV4SOJz?=
 =?us-ascii?Q?J3QL5Y/4htymINA0W9maR+8Fz+LKzAOt9zHuJs6srQlHMZuAtmaGIjR1Ecov?=
 =?us-ascii?Q?weIewrsQf6F1gdrhQf9+PKlB2Wy/2eomICoGMDImRH28HEFygrxSh8hzXJq6?=
 =?us-ascii?Q?mEx5m8DUKMaM8DHv50deHDSRQelIJrT+rzPE/u1xdlagHJvPtQe/pqAGH9bv?=
 =?us-ascii?Q?O2ifwVLffYQ1V9RrSXo92dKIS8JH4BxqFQNYYrCoUf6hTMlbkExSe5hWF9sf?=
 =?us-ascii?Q?nmEmaJNZuH8u5X6v7QrqhFfJDdKV7edByStxisvegRL43Nx14X6MYxrx1+RH?=
 =?us-ascii?Q?/23pL6qUBqHKKA4rbTdb4Z92zPm7C94pBOIdKKFKwD0m24M88qNuBQbwUpnc?=
 =?us-ascii?Q?I2c0nkvTAC5qlx8QLXMs1j2M2oLpgK4Jzpg+6YY0B4SuKDzAjNWoSqcrcidx?=
 =?us-ascii?Q?TC5Nba3etaxCkth+qrZth0wUdZ4+pW8GNvtT+4hhjBsgPfqdw8nMsN7BFSp6?=
 =?us-ascii?Q?COuVQQlKAaRu8XCDYpXKyDx+grEp182VUCbhjLFVQjPiaPmMElHCpBJV8h3F?=
 =?us-ascii?Q?3K9AKhn1REQr/jAVOOyaz/kbGlYZRw6zfl9A3+9jxvwIzkFVdVjk2Tf8sKAD?=
 =?us-ascii?Q?AkJJxYCmBTFzXF543eEixPVIQlhUcDegC0P8SoKfseJITRI1Zf5s8R7bpMmm?=
 =?us-ascii?Q?/XVvb55BKaQ4CvHt9+5/ipAXbvV80wBllrcXz4khTA821O0zAyLxjDvYTZgL?=
 =?us-ascii?Q?hk2zbE5Q5WDozJDXTV9au6Rdf7jzfI2sAKboLPD7wCmf/NFzYFSsof52yIcQ?=
 =?us-ascii?Q?RBKcChBvvacV9Xs/quhvndeNQIZE7SMrbxlaymAKChGyd0wFHuwllqQhM5k+?=
 =?us-ascii?Q?Ip2Hls9LRnU3upPBYGjhcpDJ3P6UFwEEJezVoQPXoC57+jilhJ7tsduc21hf?=
 =?us-ascii?Q?pwCDuOOOuFDOE68kLitScO6xyX+Up6JAOmAtdbhPvmCM9OOqKnJe1ltj4tgZ?=
 =?us-ascii?Q?sH8vmSML0oPdbrm0XBijBVfxlxDawYWQNL+eOgTYxZEJ8ScOG3pIAa8qyeYj?=
 =?us-ascii?Q?jZ0HJEb5xmjfPRgWHreQ+lCkGs0Ge5ZKfYjLxm/XUSVaKCBC26jIo7aaV8IR?=
 =?us-ascii?Q?pWCU24nmdWgtBXSvON9Vxji+lK8y8KVSIeOFnUmTLxOvTXqKpSB2kSfDbZqt?=
 =?us-ascii?Q?kFidANA+My7ljQvzgdss+mzuHZ+qdRur/sRUbOeZ/qsBgbCQI9EArI3YxMKt?=
 =?us-ascii?Q?ttey4O2O7Zi9JBKj+q3hwvCBAZrjoRI7QxeST+t87T8UrFSawfOyUpy4bCy4?=
 =?us-ascii?Q?ZpyltvSpq/GTDIFVG7R7Loesi1bwQcLGhUDXlD4eQjS4z8JSANstNObE5VD7?=
 =?us-ascii?Q?y2JamnT1DA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5040a6ef-058f-4df9-293a-08deddfa8093
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:41:50.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxSWjG+7bIdI9VVlgqS09m7/QywmCRwuyBjAtb5uL3Vk0wXIn4A3jN6zfRkNzhrxvdCzQuCHflfVtrRK+AWmtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487

On Wed, Jul 08, 2026 at 11:23:55AM -1000, Tejun Heo wrote:
> scx_rq.extra_enq_flags carries scx-specific enqueue flags across the
> activate_task() boundary during a cross-rq task move in
> move_remote_task_to_local_dsq(). Rename it to remote_activate_enq_flags to
> name that role, and fix the stale comment that referenced the old
> move_task_to_local_dsq() name.
> 
> No functional change.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 10 +++++-----
>  kernel/sched/sched.h   |  3 ++-
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index c050a68189d4..be75bdc9ada2 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1824,7 +1824,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
>  {
>  	struct scx_sched *sch = scx_task_sched(p);
>  	int sticky_cpu = p->scx.sticky_cpu;
> -	u64 enq_flags = core_enq_flags | rq->scx.extra_enq_flags;
> +	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
>  
>  	if (enq_flags & ENQUEUE_WAKEUP)
>  		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
> @@ -2097,13 +2097,13 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
>  	/*
>  	 * We want to pass scx-specific enq_flags but activate_task() will
>  	 * truncate the upper 32 bit. As we own @rq, we can pass them through
> -	 * @rq->scx.extra_enq_flags instead.
> +	 * @rq->scx.remote_activate_enq_flags instead.
>  	 */
>  	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr));
> -	WARN_ON_ONCE(dst_rq->scx.extra_enq_flags);
> -	dst_rq->scx.extra_enq_flags = enq_flags;
> +	WARN_ON_ONCE(dst_rq->scx.remote_activate_enq_flags);
> +	dst_rq->scx.remote_activate_enq_flags = enq_flags;
>  	activate_task(dst_rq, p, 0);
> -	dst_rq->scx.extra_enq_flags = 0;
> +	dst_rq->scx.remote_activate_enq_flags = 0;
>  }
>  
>  /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 56acf502ba26..80b72d934ff3 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -797,7 +797,8 @@ struct scx_rq {
>  	struct list_head	runnable_list;		/* runnable tasks on this rq */
>  	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
>  	unsigned long		ops_qseq;
> -	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
> +	/* see move_remote_task_to_local_dsq() */
> +	u64			remote_activate_enq_flags;
>  	u32			nr_running;
>  	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
>  	bool			in_select_cpu;
> -- 
> 2.54.0
> 
