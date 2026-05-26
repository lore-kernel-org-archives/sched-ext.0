Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C340B6D0
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816056; cv=fail; b=C+8/dLGb4Y0t306TSWNb2qtTmaTndA2k/4cx8Caepms0AAtR3r6IAkcdH6yu1abCh1mUrAX0z4aXCX4O9ntxGXWfdgajYSQO0vvSzD63Cth8rbwQtqE91Ryu3OV2IVB4iJfEKRNRHPXnc0c7BhoeEiWPlsjBHHDm6hRiUmAVnQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816056; c=relaxed/simple;
	bh=IYhqJw+3GeINS1ItD6I+lhSOexulGkT5uEimW19hEYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WuuYTJFvj/+G8UtHt0z8SMWQPgov56Pc87BbuACoHuq8BboNMYVbtdWlKx4Y9mwMIatbW/MbD8dkvZliRH0O7de7eMRcOZSvuK0IzYzEjf4slo7J9vd1QdADv6DT2fkH20LOHeCcWyaQFy3PIkLJpcfw6iDRgVRL6Apr1TloI4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RuHXBX5t; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RuHXBX5t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgOtYB9yivihzt8WD4+ka/lDrbdltQx5IuZmPsek5A/IkH36PVrgkjHMp76PPsSCKO93upHxBi++JOqBiTve5yBpzgcX/O3ewph7u365hqEKhlsE9b9+LPK1VJIKRs7cgzEQEYmvYceHvdXMZEGiI8kLVczt29WD/NpTPpPRl1BNDYD3iFhW0LpZNfUMcDNgcxwOPZbkPBaTSTpqspNIQrIBmQke8ngmfVIUZn3e3tpTaFKQtQqGpYySvPu9ZEZH6JoVl+sbmDw8ra5CuFsP8uX0WRE4bswNz5NpuqdzjKg3UlDqZd9cm5h8qo0WV3U+dxCWxmM0OahmcePlDvsnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxCgvSNCxWJEN5ciVpwCGW+XSSh1sbFEuguWVm/IAoM=;
 b=EKs+W2efY3W4YlDBrQU7lNFmQi2Xb/sgxgTrZ0SWL8q6yRpSNrY32NgfYph4XS4jxdPBy4OaNvtWJhP54Lw8y4olA8TEC7IY+wilyV6rwfQrxsI2cYBMy8TpHzSJ3cuPVhaYrcQFXaoD4qh8O8R6KXbs7Dvu4fGERVFSVBMSguvJ6gXwr7n/c7olOtlBzIUluOZZbzQSe0xQ/JoEAYLENMCLfzz4jGTPUnn1poHeQlEBy5xasj9klqK7AFZ/JHB899odCcOXJLNZa1Q6GvOrl9Pv+E855cXZC3ER8gm0Rj7kj35s3nb+B2WFozZfUGh0BIAdDJMADhDFaFwdO3EbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxCgvSNCxWJEN5ciVpwCGW+XSSh1sbFEuguWVm/IAoM=;
 b=RuHXBX5tqn9zFEJtDxGJuZZFcwIrujpGFL3prfjjr2RNSN01pzkAIqXwMq/NqhcgEBWEk81NRIM0hO7y1un1FhKjMGQfqzk6AHajQ2UONJ15Tp0JKAZDM5CZ9hWDUimBjXQ0Og9NfAY9c1XZLi3yYiBsDXPKIVUgVB7gXny9RBkaOTAGsGKzYzm5f4sUISy9NOdVSuemRUhGxqojzg2xLzql0W6afMpse6JIpkCNs/QZ24osPM0O8KiojutNyFidtCnevIfrwl+dvb66Mlpo/MeSiKW3ox2CTnHDmmKIHN2KHfhrelwa5yDHOIxd+HpbD5Z3Vw7h65ofQOE1EJbwBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 17:20:48 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 17:20:47 +0000
Date: Tue, 26 May 2026 19:20:40 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Zicheng Qu <quzicheng315@gmail.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.co,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, haoluo@google.com,
	joshdon@google.com, brho@google.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, tanghui20@huawei.com,
	zhangqiao22@huawei.com, quzicheng@huawei.com
Subject: Re: [PATCH] sched_ext: Rebuild fair weight when disabling BPF
 scheduler
Message-ID: <ahXWaL2BYLU6ukkO@gpd4>
References: <20260526135211.1892261-1-quzicheng315@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526135211.1892261-1-quzicheng315@gmail.com>
X-ClientProxiedBy: MI3PEPF00007537.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4c9) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: c25ab7a2-6aa7-469d-ca54-08debb4b2068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OdIy2tgoHA0jejjLC9+q+3oGCV/T7r2Fw+eKR2nxubOhSr9JAzzD8ri6ZpFLegInrk36/ty+VDiSIt1OSv4Z/NVVd7EkHrkIG4+Y0YNlJ19b1h7ODvY2jF6Ohk1PkzSO+taBuY2YyiMuBpOLpVR+7FXZ/3m3iskn6dzJPokFD29Dt7vHUlSj/OPx+5e7z2O33XPpYUoHiSjdKyz6kFnG3eWhRRmWrB7exg5e409D/y+1HL/84euXwkZBJkZ35y0W5tPwhGAuneBZPy0rCd0wR0JJj+2S6Mo1WxPEJ6PUqF+n+4ZJhLb4MI6QjLn0rnrSM+Y9IzECpIp56TGR89OujNvt8IVieLB6L0hUhCXYp+p3lM4ntvtrAqBV6hTbVppkuTwGE1EFghGm0R8vTzckIYK4R/LIk0bwdwWeUT/CJMWB5zALlSgQO8ykkPYadoK0DGtVMF1Zv/bYiuAqeqAztysP1i96FFVLs8Rn8kEazaYwlLeC/Jm4opZRRWUMPhdO8ZzjvyamO5mgQ+c7H0kceO13M9MagLOcmzVVQHXY3M/ZcyUMqdDnK3ZCETVYpUtBYPXl8o8jY1tjDC8mncgLLrkU3BgS84fRqolRodoECEMVW1mkjp56ZqUZJyuICaKt98bOOPtXyCVB/L9x/nfKSZZWzhcxt0naKfQDCnbRq9nkWBJvpWAE9mEhF0IEuNIG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3myvNDoIxiKSGlECGMdEbXD2daxnVlrcu7nwErwxZsb4273ltxqdVd1bF+66?=
 =?us-ascii?Q?S88EVdMWGtPYN5DlYR5ANUlx4+u+eHPgdiMBYVqcnC+79f6C2vD6HBL+aHPy?=
 =?us-ascii?Q?bWqHpsuCnyWX2znKomBNR6wZ9Nonjj/xDnfoT+x9z+3tC/70d2NuX8Jt90eW?=
 =?us-ascii?Q?PbBhfplFPt6c1a835pDqS+s98gp3vp7YhqQVPARDMrc6Pvjh0H4Ki5IHWEb3?=
 =?us-ascii?Q?2V5J3YMy2IAPBWeqeBbmSCQ0zY5vsPaupOK+63Z3lGKETsgI8oyrH6F8GEhg?=
 =?us-ascii?Q?7jWxLiCgTdFK7I9OZ84ABv7YKeWhyNvTLxVuKngKfp1BNjewUmF5weiwWuVY?=
 =?us-ascii?Q?l09bGlad6exMxu2L9mf89+BxLMc03lMGpjoxtoxdu6/Ez1oLKWEuCFM0YJa6?=
 =?us-ascii?Q?h7W2s7aBETT3KjrAWh2se9RAA740mPfmzLvunvIA/tAq1mDCpgyk8NvXPSbu?=
 =?us-ascii?Q?hAav6xEI4f/Q48kvb1G+yVFAp/efDmDIccpQ8Dd2NjTGpYQ7g6z9u+YEiXtY?=
 =?us-ascii?Q?oz3K24KHgWWzQdT8Y035Fh1pMqXu7S7KD8LB+JHsAErIhBRAZpU/aFhYZNem?=
 =?us-ascii?Q?960Za3ksu5nsi/rAcIeE8Y/hoiSybzTexWZd6XFaSFI8b5t5znlWIRrpoWNW?=
 =?us-ascii?Q?EojdniGSmoGgk2s/Yc+OY0NWiFxaXOPsrM5QciqHFgAwsrrZdQw68H4TEols?=
 =?us-ascii?Q?m9B0EbNRtfWMGigHLEhK9sLcHCvTZYdGXPt6GKDu1RqYpJVjDv77ASATN5mh?=
 =?us-ascii?Q?9bDeDht/m9bKGSyKTKgFmjw85xfLNVwaClynahFJDaN6W2LBxS9y718qF2ah?=
 =?us-ascii?Q?a3jDTt8FteGtoxtILEoOcIcI7U530V7vwZxaMb/0YaT+ZMJACJgAAC1uc78e?=
 =?us-ascii?Q?Ebt6mH7FnR618RbdMSUtwMKaRuuMWkMnVi6o8xxO6qhScF7X5ZN+K8Aos5tL?=
 =?us-ascii?Q?/je3BwFubHqp6bbvQYf+gHZGhLlmEpE3BIhrdcDdTgMBFR4h2jInh8E9+qZn?=
 =?us-ascii?Q?S8zk1XkvMQwbKyjQqTW1HMCaS/OiZKl9Vgix7SCHeIpYHdtCQk+mZdiTTmxV?=
 =?us-ascii?Q?pbpvl+L7igqKg0R4Tey8m88ypFOL6wjKansgCO3pnbWcN8pJuqas5XxHocXU?=
 =?us-ascii?Q?xZEdJs+9fDKUNHuRA19jaYl6Ft8NxlAGiuDFrde4WtqIi7aafvg55blyt2y9?=
 =?us-ascii?Q?KpP/PN8ONVzioPNzIqsMS5WFeVG/vdARsxBs3ktRPcZffEfTKh3g/DQsDE/c?=
 =?us-ascii?Q?toLnsYwWzKr8PhRBBMsn+KpAEB0z6AnuulyX9PlSU2tDTqEIfTDYjIAGNP0W?=
 =?us-ascii?Q?7L7VVp2gBVqkETD2ntW9AzULR6g8EZZUToZWJ4tNmeKVPj5xMChjv3ubFy1M?=
 =?us-ascii?Q?PsqYJzb51iYaQ/9I0mvlND0u9BIg06Qip3+8/Eo/7p3iK40OS1MDPluAoi9W?=
 =?us-ascii?Q?K5tiqzpY13FUyqup+RqkAogR6A+N75sMFgyK3jrC7JF2Robmxn3kic/SVI4x?=
 =?us-ascii?Q?i7gdQtfOcNqwCD2M+9UjchTOo1PMF/IUQRqMjsb3DyHC9TCl0STWWyWoho2Y?=
 =?us-ascii?Q?w/IC8lOLRl1DLyZ824T2rbiUX4C2NRDGUcgKrfoGJST6bmNsrsmTHElYZ8+C?=
 =?us-ascii?Q?cavmDRs3bKQ8dH+DbExljnpExhU9ARlK3sdAFOkPFfiPY5WLnn2aGyya2Xv+?=
 =?us-ascii?Q?tVNbinBY5ipAusJmrxwCkOianjMQXdMx0OsaK+gYanRDihFG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25ab7a2-6aa7-469d-ca54-08debb4b2068
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 17:20:47.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQY2ej89+uXvDco0MD/zxC5Fwoa97Pc8AVClHVsvd8AZ6skfvQ7o8zKLIR/oubd/PHO0lvFQLqg3O3J1PwH+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492

Hi Zicheng,

On Tue, May 26, 2026 at 09:52:11PM +0800, Zicheng Qu wrote:
> From: Zicheng Qu <quzicheng@huawei.com>
> 
> When a BPF scheduler is disabled, scx_root_disable() switches tasks
> from ext_sched_class back to fair_sched_class directly. This does not
> go through __setscheduler_params(), so p->se.load is not rebuilt for
> tasks returning to fair.
> 
> For example, after enabling a sched_ext BPF scheduler and creating
> CPU-bound tasks with different nice values, disabling the BPF scheduler
> can leave them running under fair with stale p->se.load. They may then
> split CPU time according to the stale weight instead of their current
> nice weights.
> 
> Rebuild the fair load weight when scx_root_disable() switches a task
> from ext_sched_class to fair_sched_class. Use set_load_weight(p, false)
> so CFS gets a native load_weight derived from the task's current
> policy/static_prio before the task is enqueued on fair.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
>  kernel/sched/ext.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 65631e577ee9..e5b8509ce7ee 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5967,6 +5967,10 @@ static void scx_root_disable(struct scx_sched *sch)
>  
>  		scoped_guard (sched_change, p, queue_flags) {
>  			p->sched_class = new_class;
> +
> +			if (old_class == &ext_sched_class &&
> +			    new_class == &fair_sched_class)
> +				set_load_weight(p, false);

I'm wondering if we have a similar issue for tasks moving from SCHED_EXT to
SCHED_NORMAL when a scx scheduler is running in partial mode. Maybe we need to
intercept this special case in __sched_setscheduler()? (not necessarily for this
patch, it can be addressed later as a separate follow-up patch).

For now, this makes sense to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

>  		}
>  
>  		scx_disable_and_exit_task(scx_task_sched(p), p);
> -- 
> 2.43.0
> 
