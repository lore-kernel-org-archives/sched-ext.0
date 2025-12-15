Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02252315793
	for <sched-ext@lists.linux.dev>; Mon, 15 Dec 2025 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807121; cv=fail; b=EHsEqyDHNU9NNzQYFhDhFNZFa2w2L9J4STAEHaVJ3+64B7nW+5BOdEGZGwePvJjU5fK2RA1nrezGaffIq3HQrDeMaa5E7HtffEUpTVG9DNfIw61qXt9ZUaJ7p9SezLcTJf53IHi/uC70gkClvE8A8CamO1Gb1WeNpU8tE2R2JgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807121; c=relaxed/simple;
	bh=w/ynC9IM1IiKbdgdFMGjoerfVFHxfYfEfat6zrwiRBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hGRIV63G2ROm5+A4ieDUk5hMS1toxwqXiydNLC51clQaMGQLq3fukE3SN60PwRDBW67HNROJXqJoqxFaCs9dvEerAxmpTqWoprnHihZG2KxOHW96ENqoF6pjslc/ur1ckP6rE63BdHspi+Hti4jV4FcWAgbq+SmF7GAtCgdOuP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dnay8cqb; arc=fail smtp.client-ip=40.93.198.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dnay8cqb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snSVzP5chDCxnHicwlGwhVuCdPTt6arrYUBaj12roeBHX1Pxkuw6QHFFcDz63paGFNzqAPN4vTda8s2Pnlb/LzAkgDHKDhg3FbkQTst9szUz4eoDOL9EcFZcYPHOOcS4lqGd6emN9ME8sFa8Nk1AlPs1iWAE2W79+6ePuj2Bcupw3nHOwsiu2GHTRSZGaWeNYuGiT1jPSF5zGBcOt8KMJQBc28mn2QQCxnUdJis9DcFA/qh8swN0Oi57Z6T5fdB8RJyj4nnqFiHIW6K0Z5ILggJhXB6UZebpfLiwYrj46CHi1F8TWrA9pOJVGLfSCvWzxsQSpUm1XVYwcp1E6sZ9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3LW7+/pqNVOy2YSOT7Kbijof4/MJB2ZsAqxtJYaLWc=;
 b=XZdscHNlhYB9h6ptDdTqCdsnsChKsG/y81LdEamXrcHQN18fJxqr2C+DGvsYgbTDBHGYeO9zRqVWKPbWkIGCsnNqmsRsLZXLTNRyFxIo3XahOiTdwX8bbVNvKwtcdFKH9WL36L40VdMlfI1vThg33paA7+Tw5VpoVAhXI6AQHA6Acks1sYGHEi7NsVwGQ39amYGsx+DfpysB8FdGrLiKpbQWauRBiFRd3okUmolHqyXF57ux6S5aiD8Ak5yMs7C57hvSEhppYoqK7vsSUDeCmrB5RlOJvXwp6VmVeJBl/G9XCaS+3n0UQLbDxDuvidgC4Oj7YM1l+EzfGQC1PT4DHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3LW7+/pqNVOy2YSOT7Kbijof4/MJB2ZsAqxtJYaLWc=;
 b=dnay8cqbIJo7Bxb2NenFjGKIc4ASFx9sBsixJt8wi856Q368tL2snz6ryDl20C0osVamQvJscZW+PTz/4BDcgunZvHC+2i0O8GR5ZLp24ls/vH6ijjwIWOWa8PPqe6xUqQCS8lCckZRM/uh6cgv86EE25suXFsIO/UU7Dmq8WHSy/Bt59oGzGNqNlmVS7rqiynehkFHNoicuxKH2XHiID39mAwBsLxnU4n7x5CKMi6CrMSLTJwIVNAZxLq/8REIvvPLGZuQldP3EBbrM/qOlvvmdSa7qBiwIHKZnT8MX5bD2BzxtI8RCD1eRmux3JthyiQi1scFN8jZcIQlTTiq2PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Mon, 15 Dec
 2025 13:58:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 13:58:36 +0000
Date: Mon, 15 Dec 2025 14:58:24 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Remove unused code in the do_pick_task_scx()
Message-ID: <aUAUAP9micR5F9oj@gpd4>
References: <20251215112940.23640-1-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215112940.23640-1-qiang.zhang@linux.dev>
X-ClientProxiedBy: ZR2P278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b7ffe0-4a6a-4017-009e-08de3be20ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?csDE9TCCDL/xpOJkllgm2zqe72SjwUyiM2CYRMiDb3NpPL+hsfZvyGnHCGxQ?=
 =?us-ascii?Q?dD3mB1QTS/J9E9zN3o8OPLkqZ7cDuXXODYUUFez44q9f/GrVCLqqT2Wdj/fy?=
 =?us-ascii?Q?2pHYsyD2nCBNC+SIQX2fSn6Mg8aNcAFoi7pDi6fV1mJqh7ApGHQKlURGukT+?=
 =?us-ascii?Q?uI/iw7Fit572OZ94xhosBnq7eogiw/ptkPRvuNcnrR+VqKiEmqX7aWkWS1Hc?=
 =?us-ascii?Q?te0a9c1x3Hcfz25WxTd0KA8Tk84dKpWfgWz56drWAbSf8r8iUUzWcJm8PHbN?=
 =?us-ascii?Q?8TjdTLsWs/dI5ZpHDApmZbjS5AA3V266RMKzWzDXNXNFdG7s3nZVegPlo/m2?=
 =?us-ascii?Q?1QQzi0b354m2Jg+t8FMKwLMMaawNJMrCIEmN3TH5Q8j4SRRAnITEUFOM4Wxo?=
 =?us-ascii?Q?FFAW92CByMQcmw2MHshmQwuc5u/DVhQxja590Bu4vLC7rkLHeZPmtNATo8Uq?=
 =?us-ascii?Q?ZMCCN4YcZQOnIWOaUBv3NkYVorlH4wQlTbSc2GuesHNrqAQrK9wpGK2omkOO?=
 =?us-ascii?Q?/x5Vrgu/yOXwqyTZZpd6SC6L8kffZzEIAxeTt80VVR5kDpXe4Tpq/lTg50Rb?=
 =?us-ascii?Q?0zNC+aVkRG63BtUKaI+U9prXK+IpFFLKcIAEvR0bks/2l8qMwTP401kf+dTp?=
 =?us-ascii?Q?gfG+TITtaoc/eXtgQfDV1HJm0i6zXemvp1H23yZCP8BMsIi/VDbi+WnB0yEo?=
 =?us-ascii?Q?M+peBpDc4WMZQAE0TncSlp8n29gofFnUZgeER1PVHS00VCOVDERv6sqwVMOA?=
 =?us-ascii?Q?t+LYWas/Xzi7PKLEI9v/ozdCC5/wKeANG+ryI224v9FYsplh+qUCK06JkEpr?=
 =?us-ascii?Q?PgWiOz4rmBjU8jM/21m7f74kro0k6dn+8xrnO7rFR1wu41ZVReNU+hsuU2Wq?=
 =?us-ascii?Q?MuiKPvJGu6WNzEEud6p4QiEf1A61EazC/mFlSkb1dNceLW2WLfaMIwxBQ5J0?=
 =?us-ascii?Q?5oS1OCRMi17DfLwOQNJSp/ZMSrY3gjyDpocuXGQYRw+YoQ0BCXNJmwBrJvBe?=
 =?us-ascii?Q?n6k77eHvPLWMJ89SeJf6afReBUXMjr4fIekgLLN1VMG0fFXgGr/y+x+RvJOO?=
 =?us-ascii?Q?0MvPGmMNNP8BZUQA9Lrw6yMqzhhWFpECvhfLP9v1KDJuAPTiyYfWrltmwP2n?=
 =?us-ascii?Q?SeclEviQIfQVIfXdM0OquEf7k0PAW7BZXxyFo1M5vh+9FaR1WxW+sVLr+f+p?=
 =?us-ascii?Q?a5d+jb1QR8gppgBhtokiAhU8zrGdZGslWDi25mLAuiXvr2mRZ2opGCfQsxsT?=
 =?us-ascii?Q?xWYeqHvaFEzRan2AgOnX0u/CpdMDqZrxPgXkYwUoqsJBMbNjGP2w/lQF4WS4?=
 =?us-ascii?Q?yFvOFtGvDHAVrvibr3TCXTLhLPuitEnGpmoHbHTRT3NIQR7JYhcSnuegpkDA?=
 =?us-ascii?Q?wafXJ1cdgB08APwvptorN4AVRRwlj1QNugTIovc983Ut/QpI356SDpI/wvI1?=
 =?us-ascii?Q?j/6R6EK8NgyHN9QDD9Z2Zov38yu3tkWU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ai2k2e4o0MG4md0zGJlGeybFc+EFHfu0LJ7tDJI7gDduHsQSwpVMK3sRGHll?=
 =?us-ascii?Q?iuTPt5jygBn5bMSg2ppLu1p045ERgZzeP5pObykf6XDjoKPU57Ui3mDdcgCy?=
 =?us-ascii?Q?UKY/FllM0uQ/F8Ei6mE1FQEJ5jqdsDnQ/Inf9EGqv1tdVQutbvIVkvikcZto?=
 =?us-ascii?Q?JSVdznHKO2/psMeSHZJez56OdflqjiuPff4ALSdhdypKBT5z5C09EZrUVJKD?=
 =?us-ascii?Q?6K0XDXZUMtBSVapJtWPvPtCMDvkD4bQBIhHI3vQbR4xmGgR0RTlhD3K5MWXT?=
 =?us-ascii?Q?bPEkeZXKjlJIcIkKi7lcT7FZHxsiHWQZimq+sz8c5yZMWVYz46U8KXCEMpy4?=
 =?us-ascii?Q?jWbiIx26umRKVq2nxKlO39FwUJaJkqs+NQn4/2JlA//dR/Dc7h2Vlyk4WfFZ?=
 =?us-ascii?Q?SLPwAE8Nq3jGz3IzTh8qH60ASCzcnN8jVIkrkyYAIvmTqWt12uqsrs43Ojs5?=
 =?us-ascii?Q?zIZiRl/1saj3TRbGX7eH7yjoZ59fDAXekGJKREMcNdCf5NB6oil677y6mILt?=
 =?us-ascii?Q?cy3/SNYBYoSClci8RPefbBUSSmOLkHudP/4hrLdafZ1qU66Wm9xuvu5FSHXA?=
 =?us-ascii?Q?Q9M43UV5aoLABHz256VIXWUpkC4OD5vZ1eKzTzlXSUToe++s4ip4nCFIKpN1?=
 =?us-ascii?Q?oFFBBaSgPQi78eXR/PQLPnB62NwycHz4rB4pQkZ1BNmlA7+hYwtvfWhIrd3e?=
 =?us-ascii?Q?xXNKDKNFSNd+pH/NpEQaH2gRKVta/5m84+GT+K1i20uNXB8R2Agz2UiHZFIA?=
 =?us-ascii?Q?aecLYhfYsZw1VvZTNTQ8PMzf0s4CwuiYAdkwoh055kxzxAk043Q4QNyd/osx?=
 =?us-ascii?Q?KyfBMg466pWxWMb2mK/nuvgBdZC96BulkRjMAu6Z1Nmz/pzDuG7JYVhe1L0C?=
 =?us-ascii?Q?n3Nc/VKb09hArc9Lz5kW3ftzZVEwYwicBSW7xXbvXrFb+Dg8L8zJ3GIVhcVD?=
 =?us-ascii?Q?/+UfK+38iuBF/arqfBv9auhhXry0RZCz+Q0PAxTGJFEQs+Vd+dI2zou3xVpY?=
 =?us-ascii?Q?8SYKFiobduWqXhBxkdBsS8KhP5nhfVgAVhweRpQh210810ybSfjtSxMPyJAw?=
 =?us-ascii?Q?qODKVitkHeFZgDqbpS40qxHY/ddI+AdB192B+JiDxj1un/YoyVmg7aO3e2c4?=
 =?us-ascii?Q?QF/QaGLGtOy+D5nLOwCC3T4f3fI/UjUsYnZDpJIt0nes6iu8C0oF/VqWdrjH?=
 =?us-ascii?Q?1vlW3KqJUejMtokHdphVWZmr85DWmPWOErpLNyVNDEqYg/95VjOD1c0jV6Mv?=
 =?us-ascii?Q?wTwK6pq0O69zEC8j1VvIn4alwQUlTgPgQQVIfk+n5bMe+V9i/+EwTm9gVFgh?=
 =?us-ascii?Q?21CSJOCuF5aKdq95xKIzCLbPdBeZuj8Z0TR16fsQjNVspQUFQOQ6SRPhSF3L?=
 =?us-ascii?Q?GCnGOgKQZy5kDFSgYNTd2ThNPV4IjMegOBpgluk1YfRPCTgZlq3ePfXP8ZWf?=
 =?us-ascii?Q?RAwXIwy7G1GrpLFnXFEvG6n1EBftvSxEPhT+NLhGuVWusL4TnIVif3Hyk4aY?=
 =?us-ascii?Q?tc08UN4d+/yKLrlHv9Bqzuziqzotquvahfn10zMnI1e4S7bVuiupaoIP92Mr?=
 =?us-ascii?Q?jhYLYlISE/9uL3e5B17Ldt0M5tah2C26Y6YSGuDF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b7ffe0-4a6a-4017-009e-08de3be20ae5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 13:58:36.6670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSBurH4OLwZfuGtkzHBtW7H+eI+fmyoDASQ71Lg4rsdEv77FLodTDwIn3oqod5FDm0hkOg9pciF/S6mHhamIHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004

On Mon, Dec 15, 2025 at 07:29:40PM +0800, Zqiang wrote:
> The kick_idle variable is no longer used, this commit therefore remove
> it and also remove associated code in the do_pick_task_scx().
> 
> Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()"),

nit: drop the comma at the end of the line.

Apart than that, looks good to me, thanks for the cleanup.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  kernel/sched/ext.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 695503a2f7d1..94164f2dec6d 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2446,7 +2446,7 @@ static struct task_struct *
>  do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>  {
>  	struct task_struct *prev = rq->curr;
> -	bool keep_prev, kick_idle = false;
> +	bool keep_prev;
>  	struct task_struct *p;
>  
>  	/* see kick_cpus_irq_workfn() */
> @@ -2488,12 +2488,8 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>  			refill_task_slice_dfl(rcu_dereference_sched(scx_root), p);
>  	} else {
>  		p = first_local_task(rq);
> -		if (!p) {
> -			if (kick_idle)
> -				scx_kick_cpu(rcu_dereference_sched(scx_root),
> -					     cpu_of(rq), SCX_KICK_IDLE);
> +		if (!p)
>  			return NULL;
> -		}
>  
>  		if (unlikely(!p->scx.slice)) {
>  			struct scx_sched *sch = rcu_dereference_sched(scx_root);
> -- 
> 2.17.1
> 
