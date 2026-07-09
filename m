Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F23CE0A2
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629510; cv=fail; b=XVLOZJ1ErsYwm9d3UEq2r53PBtH7lrHJVDBykIRFHr+bCmthjMp3VJDOAfNs1l+zJQPar+1vjQ2BNHE/Hvr/wk9kkSiy45GTx2AF/cOjmwwx8sr6pItPKzPa1ZgE9+KOMCxOQUXN0x8c2XGhvPtl0NNPCdyg7G9AIDY1bCtn5i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629510; c=relaxed/simple;
	bh=Gq3TeuWRLvEY5F3NJMRUYEU3w/Nrn3Q15HSdMWrTj7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R7Pb4Y18pX6uRiUaYAqK9BTcTww32b8J1WrC6SIO3ozL2XQLj8gKNGpmwZRXMgRNBUws6VdnEl/OVfxiScx5SULkGpe257b+Xfdq3B9crI+CkvrTa56CEVVqMmlbcJicnKsqMb00GA2XuGgwcneEwZZGlKi5+Z4nAZVfTYRg9ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dq6svu0y; arc=fail smtp.client-ip=40.93.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dq6svu0y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ko9fj7VAYKxKDKFeJ7xLXCbFTerboKzcgak38KxORLnBuFYq8j2Ig52scZjDB25qbxNod5/QJyi7xBkn0D81oq4TBrhkMOpXeDnykSA/C4Fbp+xoGj1xktg3OreDcnNpMKn11fRU1LePJDnfmFPMHweVYDkbL6gcpQUO+sKOnhYh4O/74ZiY6fJ7MddYGGgmchGjttuoM+tbGk073P1JXttWB1l0piow1bduPpxOneKFwDk2/8OBJavOYTOhTWkk6vdNMszRScQKY9zhvvxwLpSQzNspOC9EpyggZQ2c0lzXOGNuWVm/G3bp9X0y5TqerXa9pkcI/cdSnlbnrqroYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMTiiCBMMiZlI62eEyQp9TUlyhY7HKOdvPHLXeI9X0E=;
 b=T1pWWdBf3M34VbqOC4obSqdTZ2YMHa3oPo1/ck72CFBEPEoRlqbkAL2qgdN4HziYGCc2oFqDPC8VhgfrXXTTj4bFC/frW2Ofi+k75E8Mi0z7zfKalKMxYY5phbO1hoQvdG3MxtTaOyOfM1KtnIBNZnRQxjgJN4IEotAVolY8Kpp+OxEew9mVCQhP9Kqzg0+2E6bKBXoRvADneKRQJW6xm3O6m5lDCapSgV/sSf/W9OGXrgfdWc28+9OqE93AENWnespXs8N1+kJUzdvuOHWTimNxQy5ViUTNlIWTei4QNLoPfEBw9OsU/l5bzvLY8UkYNcXCVaA4RaqGi/jBUDGRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMTiiCBMMiZlI62eEyQp9TUlyhY7HKOdvPHLXeI9X0E=;
 b=Dq6svu0yJV2WSgjXkay0JFpJNmwhwwaZg1PZ6eGytjVFXqnv0TmQnQEdJ6qiZ1HFSP04pTJKv2U5KQnkoCrSkmRmrRI1qtkcYFnxsdLafbLPVdF6IEF3WRSFpg20gG/sY9WGQvAFFPoJrC6OuJpzASQLEG1Excu7KVIVlljN9+CLSVYGSPNzLs/z/PudA2jRb5Icrq7yJ6j6CqaQDrmBUL1bnv8MecZpdRv6ytkXQZW8nf88DURJIXjfnwvKf1CYmdIe47EsX81bE6MQDRt+Q1VfBOOsyQ4LZm/NESi+lasVZn5fIQ+mQBsFnAP17LtYHiDlhdpj+ureI0OJKdgrdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:38:24 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:38:24 +0000
Date: Thu, 9 Jul 2026 22:38:16 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 02/40] sched_ext: Fix premature
 ops->priv publication in scx_alloc_and_add_sched()
Message-ID: <alAGuFvcUsrekmy4@gpd4>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708212429.3405787-3-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 487a080c-fd78-41fb-0e83-08deddfa05a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0WdZSt4L9UyA9UZIKT7sh6attOM9Yhrc9xM+BsZCue5ViMp1i+lVuwY8GgkTZyhI6A8x9V9nAdqNV4p5RunTSXTo4FXs/rcZB1usfaKICvNs2J6rxMJA2aH2xe4EcXug+HRLllfyscz1vFh2oBYvIwr8ZeoQNU3BMhZudxDXHsa4M/YMwg9oQNzTJhSykdC/ldf/oOpdXgkZiCcxeAOLLNel4c510uHN3DKzwiNl+RIj0wr5k0g5n2G3530wZ+FX1bPqdZg47YYnk15OgVyaVKZIDSHhtamq1l5mEKQcaQ/A6Xqed5vTEGIHqca5J6kVPZKeV/Ije4hH9asOWTVajPzddCOXi2T/tFG9CO6tj+Ke779scCdZm8hBZrYqRLeo7RSScYmU6J+kwWua8FjcjrVH0BIJo+yIfseAF8nVbmxffPiRRwukc3VyapQ/amSK8dppbgR7YbAsaznQYUYjCu7Fm1XFqn4xmYll1n/7zC2FuS5adeztJ9ZyNZYTlT3fDZWCSPKO735w9L5h3G4k3cehbuPhCTFQFU5npeaOuBcS4TNB4wKSre56fBtMJpKgcwmdkqq4RUkyqf2HpUDA+gsf06RcSWdyu5SWNFl/GiNzi0Bd77kc3mAHVzp1YywpWtrOw/dzDHzNylsmWCaxpUyDvzWkSVy57w9s22GfgUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s3QrHiKlglZ+2oV7Go5/XmsJgs/ZIrnJS13sx3wppKEiNrtjoAcOcerSL/co?=
 =?us-ascii?Q?iHaa2UIREbyzaYOZFYQAF8x/Dt2D+QVOKoju1/B32StINAhZdf3Pzp2vnEpY?=
 =?us-ascii?Q?73Yh5gj3t5LxqgDsBZr1OF8OyQICIPKJT6IOt0TC/GIZNR8S9/j6TSWXqzwJ?=
 =?us-ascii?Q?eptjFptANs2CBTvmQxKQJNO4oTctDUMnHsZ4SetHRQUGaXbKre/7Hbu+AxBv?=
 =?us-ascii?Q?mKTaNqJjfOlO2bBr7nWyiajMUvmXH0rwYLOtsnbWye5Tmuvj9RLFVV/BW9Ud?=
 =?us-ascii?Q?2Z2JRebPHlEmkTYyKd3yXLj2zAIKKmxZhSNJSjCZGn/wg2Lul7UZUY0uKuXO?=
 =?us-ascii?Q?5ZUnTBR02OZLNZvdUOhrMeG9esJlsI9aH+rDL7J/RCVnufx82UYu20Vott5N?=
 =?us-ascii?Q?RUakEkmf1VwJwvqYGFwSv18l5dJe0hFOc85sZaWtsoFlxUwt+FwjPVMOt7bE?=
 =?us-ascii?Q?lhlU+an3b/OavOJHu3H2XR1n3ZjkCYcbOWCj2IL5FO3VGyxVhpIaDg9lquGW?=
 =?us-ascii?Q?lmDzdRvUV3VhgR2C+KKcHY6Dow+0us+18VhvcoAkPpZ1r1JIGsC3eFm+yxbf?=
 =?us-ascii?Q?CMsTZc3VKuAJjpRgNvr0+w27aHRkck9Z3hT9/RAtsXdzTo+JtorMC0gzyuF4?=
 =?us-ascii?Q?KVnlOeP2ZZOz+0l9s8q980djo82hd//r7xw8eYJYSDgZYIZ6AAuarTNML88h?=
 =?us-ascii?Q?GLa8bjbCIS8+/iZz8+JlYLM91aLmu485X3H0/00rvStG5M4PP4kNIjSW0s6U?=
 =?us-ascii?Q?SzmsyUKZcU8epe6uVcPWcS+gG4i/G9DRpCAjtGUYSqusU6ii8l8znCQFZAkA?=
 =?us-ascii?Q?dPRlkVs8Nca4nSzlbBJvSXN/Cq+5FpdlIbqCwr7t3/i3EY8OQMJksHdpjTfj?=
 =?us-ascii?Q?lOQ0KVxNBVr3T4ritOnJ7U/dMrMu0unEfWYnOcBA3wCwszWVkVqgqW0yxF9E?=
 =?us-ascii?Q?D0wCWwJjm9wIPgp133TDUwoDoNap+6iZ5ICfaX1kvvzDsqaIaDwPwCmBzS4c?=
 =?us-ascii?Q?W/oAif+yqWMzGMfgaHrcJX//SN09anM4PDQe9rP4qad3D0pO+HuVSJZji+er?=
 =?us-ascii?Q?si1Hzu6Hq5inHyTAj/6lNwSpB9v2B9uzYuqXctt++nmB45X6I2GKLHmYL9lr?=
 =?us-ascii?Q?RrHTfzcLjB4I5eFcwjxoDVwbSJtsmiz/VfS9vxtp9yVAJWjTdstEZg1MiekD?=
 =?us-ascii?Q?dTS/oA4tk+vN5T2YZ8ISX75k3BXXXL6Y+oj5nnrvs2RiLqJrJ+Px9YHukhfb?=
 =?us-ascii?Q?fXyuhw/zgbgO2akPsXyDw6g80o4juYp8Rwly7lG3z8ss8kixLE1W8WoUJRPc?=
 =?us-ascii?Q?Ai6GiGJsmXDKpq11NGzfCwrEEPDFB11/qV31TGZdPCp26LIjH/0IuoWwBy3v?=
 =?us-ascii?Q?APMR/Zs4UGoNWG0PEpv24lK3gEr4HMD7IK6WfRTxNiXSDMcDR0SixZLINYxp?=
 =?us-ascii?Q?05mMBqvHlMIuPAtz5fEumPM702t8n7kr/RwWD74h7Pupe8QI9C9RU2YF3jz3?=
 =?us-ascii?Q?ggGwZyeVqlrB4YJ1woHTap+YI/nLHgBwPKac9IVeDJvZbWFPYXXnCUeEHt71?=
 =?us-ascii?Q?4l4djMRsLxCtnTSihpH7438vDC6pbCac8sr2bCg5T1YqnI/G+NB649kRGlGZ?=
 =?us-ascii?Q?kJW5lsdmiPo/PPXOF5n1n3NPLhx8sKjPiH782Z4gIfFngKe+UxOv8C8zTua0?=
 =?us-ascii?Q?iRrkupYkM23luTPiSMUurf9yTovK9heCQb9ylQv9iyCDymHHnMyQXPHAJ1JN?=
 =?us-ascii?Q?CyKwx+6k5w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487a080c-fd78-41fb-0e83-08deddfa05a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:38:24.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctz+QkZT5oeyNCEe7SC2loesl1XeOi5FzlXvF2HCvM1EOy6WQo4DPTHsisr0NdP+uSgGE6F9r2VGl+54dLqDDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

On Wed, Jul 08, 2026 at 11:23:51AM -1000, Tejun Heo wrote:
> scx_alloc_and_add_sched() publishes @sch through ops->priv before allocating
> the cgroup path. If that allocation fails, the unwind path clears ops->priv
> and frees @sch immediately. scx_prog_sched() callers can dereference
> ops->priv from RCU context the moment it is set, so freeing without a grace
> period can use-after-free a concurrent kfunc caller.
> 
> Move the publication below the cgroup path allocation so that every failure
> path after publication frees @sch through kobject_put(), whose release path
> defers the freeing by a grace period.
> 
> Fixes: 105dcd005be2 ("sched_ext: Introduce scx_prog_sched()")
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 1a0ec985da77..f4725698f5ef 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -6363,11 +6363,6 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
>  		sch->ops = *cmd->ops;
>  	}
>  
> -	rcu_assign_pointer(ops->priv, sch);
> -
> -	sch->kobj.kset = scx_kset;
> -	INIT_LIST_HEAD(&sch->all);
> -
>  #ifdef CONFIG_EXT_SUB_SCHED
>  	char *buf = kzalloc(PATH_MAX, GFP_KERNEL);
>  	if (!buf) {
> @@ -6385,7 +6380,19 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
>  	sch->cgrp = cgrp;
>  	INIT_LIST_HEAD(&sch->children);
>  	INIT_LIST_HEAD(&sch->sibling);
> +#endif	/* CONFIG_EXT_SUB_SCHED */
>  
> +	/*
> +	 * Publishing makes @sch visible to scx_prog_sched() readers. Failure
> +	 * paths after this point must free @sch through kobject_put() whose
> +	 * release path defers the actual freeing by an RCU grace period.
> +	 */
> +	rcu_assign_pointer(ops->priv, sch);
> +
> +	sch->kobj.kset = scx_kset;
> +	INIT_LIST_HEAD(&sch->all);
> +
> +#ifdef CONFIG_EXT_SUB_SCHED
>  	if (parent) {
>  		/*
>  		 * Pin @parent for @sch's lifetime. The kobject hierarchy pins
> @@ -6440,7 +6447,6 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
>  
>  #ifdef CONFIG_EXT_SUB_SCHED
>  err_free_lb_resched:
> -	RCU_INIT_POINTER(ops->priv, NULL);
>  	free_cpumask_var(sch->stall_cpus);
>  #endif
>  err_free_lb_resched_cpumask:
> -- 
> 2.54.0
> 
