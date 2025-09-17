Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013010.outbound.protection.outlook.com [40.93.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB786261591
	for <sched-ext@lists.linux.dev>; Wed, 17 Sep 2025 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089496; cv=fail; b=KJH1ZGix5cr6yeoyZc/jU4ZFMa4c5HsY9DIYrj5aeDw2vMPkWfdI+U/ikCv0/6WXOmAkCX/fBVkT7cabB4EPFT8apBpPHnFGnpbXuIkAqkdWgQsxWNtEbyhD9u40cwaHFoeghojS1MPeYNQ2qrmlRJX1hL0ZBHqEvkRFBqw0kVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089496; c=relaxed/simple;
	bh=9n1V8OEVq8CZ3wBKTNH+pThqEaV0+QLolNs0VtHFwww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j36iEnp6pDm3BkC8WssegnN2AJI9KtlepAWCUQuGlIMAj8jkux8O8X/TYWKgwl7BVQ6SD5vIFP47jmUnQDbgrkFF9mclsZxnugSWD+dVaVKGNPmJHLwHOAfWsNEQPEjrI1dBqOAzsNvkqrxGLtnGCEfgvPBWAwDaeS7AoHWQ3gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZrcCknnn; arc=fail smtp.client-ip=40.93.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZrcCknnn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejCVdExzKG5srQCFGPQFOIjS4eG6HvobyulhnO11OLdjyxJ3mK2uh217wHZjkmHPJzHjcHVKvdVqbq/VhHDUvlY1Gqmu6HBl2UVehe6LteMnVbR13DYRGk9tyYy1tcM4Z6DXhiF3KwsuJa6bdA0aMDqPh5uuj8B/vBRDjcW1uDuzDK/xP6RGyGw8JhiHpQ9MWXjz6otAco4Rk+pRvSmeA0M1oeGwvRjJoLO4+dSUBDSh5wKJTRpQBTbparwo7mvbJHMd5kmvFyznAcqzSfDytUxV2kpsofyJj/Aidvrjvo9bVAbQjtZ9IMa955Syt7LPGifYxKQXlBGOXZ8pruDu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22GR49sZNILGNHSBuUTS9iDZJPGejSd36Nc+RoWPqk4=;
 b=abZml7sekAPkh0nE3CRgQk2emtfB0YVHhlO6dEN6XbfE1f2S9mtpZhd3Pqg+bJWvBjZtPKguybslNCocS/oTBA3QA7J2MQ2EUMPtrR77Pz8s42XePKK2WA1tA5CNfhoO25hQAAnN0ldkizeETRlF5F3pkV8uCINMfS1nUzOKqDEG4pWAYcxlUDDfVfFMYfkvyA/8K2dwnxoWqG4DuL18vyK/ZQs2WovG0e1XhKnf0IbqR1QAmNNWVtAVUWKrRHmnRRMNFL4IKUjd7v4TiQOp/V9VGgsBL7A2XKcqPAHVFpDfqLhfo0/hdz5DPqgJ1L6p6MQVNcR8+tlIweba+Pn/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22GR49sZNILGNHSBuUTS9iDZJPGejSd36Nc+RoWPqk4=;
 b=ZrcCknnnNou+kvop/C/9dyCVkFG4mbQLMcok0t2Ajw/3bzxZUiGs+76OTaUn+XfckH9QlNu656wBVKD6xzZmmHMljgJ+K9dqV25eUvOmPA7zPkHac79yEqxrrZrfU8oAPk9Q/6ve9m44lqYrOwO+pA2JVrsKAo0MoaAMYMYOlNXMV4+RujTm0Yx1hOGAShjQtdiTEMbe/+jZ5HC/Zy5Q902rc1dGY+jq4l3KpAvaUQEJpYw/Inj67HYeDzCPj0UlmP+U+ESKZkoRRDpRwmuTJx8O0kF9DL5+fVF4wCvYKjSYih4yMaQUHmojgGppBw1cbcaqIzE4qRSdPTIoCFhF0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 06:11:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 06:11:31 +0000
Date: Wed, 17 Sep 2025 08:11:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-6.17-fixes] sched_ext, sched/core: Fix
 build failure when !FAIR_GROUP_SCHED && EXT_GROUP_SCHED
Message-ID: <aMpRDcIhrnx2ZaIr@gpd4>
References: <aMnRYuUvbYsc9S2L@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMnRYuUvbYsc9S2L@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5b4ff9-69c9-4f8b-519b-08ddf5b10bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0LRSvlhDY7abXC/kKV4UAi3uQLHY8iYUpHDVtR7bWxVD98BdexYEScORFUnM?=
 =?us-ascii?Q?srMdKpHHcyZ+Y7jJZzy1ojG0j96rzHzNxWMta3cf3GnuIHrNrX2qH5W1g4Kn?=
 =?us-ascii?Q?6DDSrIRkzxP2QoJxOnPzlKhJd6LPt45+KcderkmCCwRBZ44dpcG4DhDHA92l?=
 =?us-ascii?Q?udOVKo8LWqALZKJ3OrKHraEzo+S2bowvt9d9pbDgTha80F0QOWQiX6FBcj5S?=
 =?us-ascii?Q?t8kEe/FbrPda7soHNQ0p9eLPBwJXfV8gW2C3o1zgudWy1dbFK5oNODaA5C6s?=
 =?us-ascii?Q?ujlHE2k03f+Pb6IgwZQvMMXrhY2VjBeXm1xFvXkYytT2LqRNYqJzV/FbGmvt?=
 =?us-ascii?Q?5IcUIB6COlyw6PYYSs4ThyP1+rcYilN86nC1MuKiALWV1N6wia9mTOcs05kj?=
 =?us-ascii?Q?W2Fo/RqoUG9+2mASfX9hC4e8rWKhncyIOpSZQuGiHt8ognyCELX8/554tB5z?=
 =?us-ascii?Q?TdljukHU5lXxeKvsET6M3XFynOpt1Yvg2AwxNLIp2KkRu1Ijirdx+44SA3Gq?=
 =?us-ascii?Q?mtKVwW2Ee8Xl7nBSrtQ5RDVdIEtj1s06tRiYNbcGUQjXBoTme/DhqOlIIrOb?=
 =?us-ascii?Q?rUvDnGIUGrfgXcHm6PpPJvbc1X5Xa1cp/1WWs2bj/UcYkgcsj+mn3G0Onk5L?=
 =?us-ascii?Q?er12Nlrj39JG5uWi5IshAs0oKC//quLvzCWu9JsyucuhOc467C0sYnJbqa20?=
 =?us-ascii?Q?AVVvhbbTpWaACtWZ97lqEsKwprt1lNE2jilR1MB0Q02bA8H+IL2tr4X9+uLa?=
 =?us-ascii?Q?W/xUBN8xLn59s9HxjtGSXntDvm0wza3KKx9UbfdDKVwHk6uOdiBaV5akteD4?=
 =?us-ascii?Q?bv2hgJphkL06/leqLAxO4w9eZFiTIjd1Rl8wJz15EZyqiVrD3aPlVrUqFRKi?=
 =?us-ascii?Q?DfY/cB/V0slkO7ARJmvKz8Nu2o5PoHmGLR5zPe73Y8Mqwk7e+Zs0EMXl5AJg?=
 =?us-ascii?Q?sSi8FYxKW8FI1De9t4EnnZzaDOapSbOG14TgFM+0/WoRuK21uheMljn2voNv?=
 =?us-ascii?Q?DrEHUyAQKhrLMwyH73WNLN40O5fn0HMYcyKPzd/ruub91uUY1FcX/qH23aqR?=
 =?us-ascii?Q?RZsgtoVaNVcc/LkCO7BK/IssDVkZFTpo7PaY5S8s7rIR5rIl7oo0x1K6cyN3?=
 =?us-ascii?Q?7nwx9Y/PLxnl2zR3fWj5f8TvE9GLNlPzP3J1B/XQQQV9pi8eqP+L6jWXkRTQ?=
 =?us-ascii?Q?C6+5loV+LeShtcqrzm8fDr8XEhGh8MA5owtedYnBCWGjz/K9dZwSgHTpB3qN?=
 =?us-ascii?Q?7SKclWFjZ945JGRGGbfXQCXZiEPGqHpQZ1lq/mbDXIHDGVlTK2xIKsJItuGV?=
 =?us-ascii?Q?RU0n+WtUw8p/FIumSyTHVMWCtxfif9MvAgPgto9MtMIzr/1XotGkaNJ4aphB?=
 =?us-ascii?Q?00lSaKWofHCTRT3DcLA91drRQorKfOzr2Dcr0wVO/l6FYGB+S4H3GlOiXMn5?=
 =?us-ascii?Q?AibBNP14Wyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uPKvsP9j/5vYGus6nSNGuFI8uz0dnoj+CUhIJgOxfkXxNvcR9Z2K4co1tSXS?=
 =?us-ascii?Q?DfPwx0NdeFSrADj4xlT2x6+3zIMeyNZSL5t2HgnUD1nmyW1epuyOVlkKm5JU?=
 =?us-ascii?Q?ogLI3tSIZUQNiQNOY5yM6d967ppn+n8rPRH9KFTsxa8HqobH7rPIVvoxFqFF?=
 =?us-ascii?Q?akOPdktyW6NYFdgBvcy6/I/hiPx8JCucvY73Mqa6pIjiQIFYC84ihKX5AFyy?=
 =?us-ascii?Q?E9WJRyrf6FbYK9ZIJrhHekkVXgi0j40hFqx7sSSJA+FPvg6yL8jPWAJyJ6Wi?=
 =?us-ascii?Q?/3VUQSAyDybulEY4WG0AG8RPwfFm/IAOFmB8Xe6xn4YI8KRX8GhujRmCpy6R?=
 =?us-ascii?Q?yYG4BNKTegPxNc1+KILixn6FSoHMWhsCLTdfUzLzwXmVNt++SAbhVzfyk+GO?=
 =?us-ascii?Q?c6/8zC8wWxIKp/A/EM+g4gTElRORPubwpaAaL8+1U1K0Vlj/exbTL7lhLmIP?=
 =?us-ascii?Q?75U/vOBs63UV9puVTygMJuF1fX8TxdGMQ6ulcp2RLmIhVUQyx7T9MjOh//cK?=
 =?us-ascii?Q?SgOQNVkWuwNSxWdci1ESidu5uCDXnVgDS+6tscYc1z5VSNgNI/06q8RNlbLm?=
 =?us-ascii?Q?Hgbsfx4upexfhKJG3Fa7UAGixnFQq+M9WcVJKI2ml5LdZNuJcZHUJxlFmvJd?=
 =?us-ascii?Q?iHcTJH6ySESUIQoOvW/n8ApQ9DBQu86bwlJW6E5/I2nu+M4U5dCvHFAQHp5/?=
 =?us-ascii?Q?lExJdmoR9dRfhvr8FJu7JGT/0edeT58l0gUI5BKP7pU/UgG4JvIwLAUO+bBM?=
 =?us-ascii?Q?+yULLfqw+FPndsQCXxHgil8qkhxHrX5TBRMrwyhZhs1WEmveuLTI5Y3B9LT3?=
 =?us-ascii?Q?Vz0x9O/g3UPqmiKBt0nhwD5tEtaj+f7qAm9KoLKI0ijDzle3pp+1FdGvi/Ep?=
 =?us-ascii?Q?5hDhQmCfmHaR3wTIR3mrDu/v2xSaBgS+SUlRkLmcES9B73M1KTMr0eDO7oBp?=
 =?us-ascii?Q?Dcn90QKgidSDTWpO+Q6rHxr6v6s1OpiF47uZ7t0lX1aS2TrtnqAafMfXQPom?=
 =?us-ascii?Q?d4Jr3bGIJehW7qwHUsn52vBQ0VZA/WjiCkQsNREXXrcy5OsmiFH0SW8rZVLh?=
 =?us-ascii?Q?oCAreG1w7dncFKWYDTW1wdpD00ZCIQ6N/6s8Lzp5JamhIUg686kc2fk4woIH?=
 =?us-ascii?Q?aatgjlU5+5r85xoiHeLhBlIS/D3Z8P8rBRPyhHpRb2n3HKJjOfU7PWrjAoUg?=
 =?us-ascii?Q?PGdgeFDPRnM9J78oECQLd1gC5CGL0nB4eQ/69MBOh+Gj56iW/3jwUzWswg1e?=
 =?us-ascii?Q?N7qsVdGyO7J1VqiL79Q2C0eqtJRN7mr2eqCAnICcY13TMNaHy2CyWRggG6Gm?=
 =?us-ascii?Q?EjMzx3lvnow5ZYMPuzQrSk1T6gdPm2MrE2uz//p4vgPv/su0Z+LUe8q7z8mH?=
 =?us-ascii?Q?CJ2xPfB1764aGvVs8CJjhbL3f6QolAXf4t3QbS9gi5h3J5fa/xdXYHmWvvVZ?=
 =?us-ascii?Q?nv6fV9wlQ1pB22/Di+X2e2+86twZrhpNQ4XLxtor2TVAeMq58w4m2FB+5bGi?=
 =?us-ascii?Q?7Crtc8yVMg2dQQu4cOzqP0fRGWzlSHhdU8YgyE9HsknwSheAI7smrEJ1ceoW?=
 =?us-ascii?Q?9C1u9q4KmNZEoDA4Dg4GKy6ENriy/NomvqidCxDH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5b4ff9-69c9-4f8b-519b-08ddf5b10bdb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 06:11:31.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvT7RiUZB4/xVZbc30ddxdaOYCsB3zJAbU8Z3WblvLSQOePw7DfBUNd4nOrpHe5pWBHNelbgnNIlxkPUX8Ws5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495

On Tue, Sep 16, 2025 at 11:06:42AM -1000, Tejun Heo wrote:
> While collecting SCX related fields in struct task_group into struct
> scx_task_group, 6e6558a6bc41 ("sched_ext, sched/core: Factor out struct
> scx_task_group") forgot update tg->scx_weight usage in tg_weight(), which
> leads to build failure when CONFIG_FAIR_GROUP_SCHED is disabled but
> CONFIG_EXT_GROUP_SCHED is enabled. Fix it.
> 
> Fixes: 6e6558a6bc41 ("sched_ext, sched/core: Factor out struct scx_task_group")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509170230.MwZsJSWa-lkp@intel.com/

Missing SoB line? Apart than that LGTM.

Tested-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> Peter, I'll apply this to sched_ext/for-6.17-fixes and send it Linus' way.
> Please let me know for any concerns.
> 
> Thanks.
> 
>  kernel/sched/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index be00629f0ba4..ccba6fc3c3fe 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9551,7 +9551,7 @@ static unsigned long tg_weight(struct task_group *tg)
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	return scale_load_down(tg->shares);
>  #else
> -	return sched_weight_from_cgroup(tg->scx_weight);
> +	return sched_weight_from_cgroup(tg->scx.weight);
>  #endif
>  }
>  
