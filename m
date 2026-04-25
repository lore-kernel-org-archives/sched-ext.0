Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763ED1B6D1A
	for <sched-ext@lists.linux.dev>; Sat, 25 Apr 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777099931; cv=fail; b=MUn3RFxlvN8Q+ZYH5REJUR379puWpsrj1Ai9i5Dp0aDXAQJuc1RWePhzxydqDM8cSiUTKGL8E5SA7vLlpXMzSysHvnwbyvgSECmLBpfSgkwIXv0IRL/TPe4PMOrYqnkMetmqteZHIMVyMPvVAGhF62hH//YO1QTZP545eIrHiv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777099931; c=relaxed/simple;
	bh=Ql7YtA6XX9SkjvpLWqOsLd9flL7fGqqweENsynUcvZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EAqZyEEPK+y1sLNAXwXnIOJwQ9uvQHRS/a17b/x/ng7aF/mbDchcddTniWDdir9OsXgHa7mp5hHGess/Po+wvQkzf2hsCQcCAh7EBgYPzdh/vHK2Xm5YY0e+FWDrkrmdFJ2n7f2qahftm95PBKd3VGgTfCM7rVLovwv9o9kSzNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qBWvaa2I; arc=fail smtp.client-ip=52.101.85.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qBWvaa2I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6+68JFPqlsRnLsVrOoWWSu3GN7H0TIjwjg46fEawgkTbn5X1/pU4qezH0kv/u0oF/utLi3UylRO/QK4CGlwDTE5uFGaUnLbEcblgVPhuSi8u0XvLHk7V4FdFmjydqKZ8wM8Mh7FXOZP8SjncQjHLeZcTYJcKJGI6yRnjPhb2IJTe/PpqSFxBNkj790RyoAZL5dAuxDyOKdTbx6iFmIT4NxgGrQe9OixLxumz2tcSp9AVeTGP+MkzbyaufH9vQ46bOGtXN9n5gDyN3I2ZTMUU/ezuwCmrOcMEj7guRbRS2cMdi1MfHjeThRI4OA6iIl/7rwjXWcaol1ragohlkBgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+m8ahehB+QYBdv1LfsAG52Y8PmNWUSootGPLanPRks=;
 b=P/Gf/e2mKlynqaw9ZWa1yQs9RMFKLhCGPt7XTr7Mm1fY6///Wkgp0XCX3R2ot7mQEGv2YRFN8UCpmBQNH5JdAgWD3o7EaDiGE5t0Ht9EWKq1BbkbmnpdNZA36ywsatNk1iUnLqEzvBuXgLHUL3T6KF8a/D+9rNu1K9RtpQq+7Iw3Q0BzwLaz7Z1bUUvkqiRrD+EBiSC4NtQB9TBdtxOlR+Ir/3Cxm4lyoVgPeCQrjNNr+af1nrg2tTDXx4sl2D5YE/Aw3t+j9I1HuTMiJWuQWh9Ow9yE4MzjlUaSOoS3FGytHErme7Zpf+/HSmKlb9I9A4dPqXabd6Bxc9qbNllE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+m8ahehB+QYBdv1LfsAG52Y8PmNWUSootGPLanPRks=;
 b=qBWvaa2Ime4JypxiopFrV+nHl5sTskYWAYthjel3i4nZhJYCiLxlNaFarLw1Zn2tjE+8EpkPyqxv4zqYB0hD/SZTz6wkr8BN0SvDacXhsB4n0v1nPQ5On1LgP8XUbmTMCcNjEs339+T2aKEzPVt9kiiDgEqqERNBvogYzBBzpEwozzLFNA8xhNuKuR2SqfA0JRdPcPdGTWQdxM2+WpiS2qBxik1SELDbf7ecd5CA99kcUxX0r457hoXpmm0YYxE9ty/fZ91762nyj9nWETbX6MEqBXfrNvDDCwAx0xn1ppcLfwN25UQ4dJAkfqbk/uCsEj0KEU7AU+ZZmqXdeDubnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sat, 25 Apr
 2026 06:52:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 06:52:06 +0000
Date: Sat, 25 Apr 2026 08:51:58 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>, Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>
Subject: Re: [PATCH v2 15/13] sched_ext: Release cpus_read_lock on
 scx_link_sched() failure in root enable
Message-ID: <aexkjh-z8vfSe5JM@gpd4>
References: <20260424210802.3842919-2-tj@kernel.org>
 <20260425001951.3987485-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425001951.3987485-1-tj@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B7D.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::410) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 61378177-6e10-4e34-5457-08dea2972a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+oVpSsYk7Lk/7iODRc4e/VqxYXF/bKsZEscF2AOhhTD6J5OQxQ4ZlgIuIqXhovtjlP1TorG/GoT9b2MPiBtyXVKG8wX8lJy19HIVD8njuX32De0Z+OBiaR0PY8B4s3bi5dj1x+t++7GkALmqMgLwoMbI/rGCXFM9DCKh5zcmUTCN9M06hPDu9zyVmv2zT9sMHrlpW0mLeDI2GDnbTPM4LftLKeFY2nkh4je8DtxDYHsAYM0DE2sEU8ngpgjQwzHY+BAsex7j5QB9CjEGYONsyJIA1EUKd00FeVpRR3Ko+2nUyFvsQRBwtgJSKk/r4mZSoekPYPkpwUU/FHvMmmD21MINar3Nb5w9S0SO4A1YsduS3y7uqQFrykMcxJ7t7Fj2DwmsQo5fXsbeAnAdVhz776A/R1XUiatZqkGFwF1dqaQJkb5jsybS/ZJ2/CN1aM6bt9TfoZ7fRxfI+Atg5Br6Gry3uLIMDT87nTtHaPELkWTYtiNKCW14C3nRKLRHTCDptekrtad/U+8WuaiPaZRt2RcYUddNmYMKGWKfRvRNh+MkzTHVcTzAzKJw9WXuk48xPHqNb7knn//nyJ0xckRjPDnAYvfBRvs6crWC/CMFmprlAUcWuHWWLkXvDVRSAcm3R1bH6MSJ8vlPm4AUaiZr8C0T3w29OYzh8bP5BDLoYe6KAHV3nhS9XOQXsmXDEGDmlOb5X/O/64YfCmzBo+wAAvhWYAicmKMv+sV9NI2zJh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IUHUtL4owtcH/+IunjHMcUthC3osZubrbmEE2caNbLj8tjSnRy5p1SAp9ztx?=
 =?us-ascii?Q?MezQTlSWE0TsDHPfdUQSuJvOs+lPgITeE1DShz0+Y2OioUucpI/PHuZ5qufl?=
 =?us-ascii?Q?ERVC0HU97p2Z0dQzubMdW/TpxHd/1SbvxR6SmfebI+KR4Wg5UFBtFFqvbYA9?=
 =?us-ascii?Q?tovpju3F4IJHOX3A11yOf5ZQo/AkQchn0GuUfbUsVjT9yMp6TA5CtU9ywVZ6?=
 =?us-ascii?Q?tQ7oeJ6f4/utvw1Y1Czxtb4LVZQKq+qb0uocoHx/uzi+RrrKkSFmutZ0wE1+?=
 =?us-ascii?Q?P8yTfC7yO6Gz/EWqWFItfy/pSrFXMzedjtksxXuIA+zzjsZqGGUHPlqUNnz1?=
 =?us-ascii?Q?SzIEmVAfgOOGHWHqhNft15U02DXi3cUMlT5DhHuhUKvcE6HCi0i16KnpBdpS?=
 =?us-ascii?Q?H5OXaOPD5LVHuuvN5sftq5vTKVwNYZHXVB7KnSYFpOA/3CMK+CTvBcBx9JxN?=
 =?us-ascii?Q?mwEZKyvHqn2kYq9z/OM/r6WxkU2Uy6ntcbv2bNljSmRKfso9toNWpDfz36Ok?=
 =?us-ascii?Q?doRkx+1bpbUYYP6OqIgfDZHnAqJNSvrg3C2iPmXLDkTuUSg0CD/OXxqI3kCC?=
 =?us-ascii?Q?nZthE0m3NiZP1oS4Ay6JoO9cDUZPbxSP/23/XqGHR46Ohqqz9buo0tHfk/ZX?=
 =?us-ascii?Q?q9yal07e5MaSFp6iuoGhBLYqogF0kYKMcbupznJqHFf5y6gmoYCdXbvCOL3T?=
 =?us-ascii?Q?AB4Wed7CKa7Ae1VsyzoOpAsgVOFeOxSfhKAO1+3qYXkQLbZJvFTMaWuyALfS?=
 =?us-ascii?Q?/UhXhbJFd85F0MyjEiPai5qrzqaxndWX0algu4d7jNfOduiwq9NKeQe7hkw+?=
 =?us-ascii?Q?fBmean5zHT4TDj/SKNYnMElsdweX5DsR/VIhK9Xz2K3o1ftD5bUGMun1t2Xi?=
 =?us-ascii?Q?VAGoalbf17SYAgGyAR7I6oS1jq3GkUk0Qb79PQ2+7gylObW8WpDenhpcZZ+C?=
 =?us-ascii?Q?mDSsirMSi9spLlAX/BH7QsFMH2NHvhO09tt/AtTmjJ4ye5+yjBxeNyT9CkkL?=
 =?us-ascii?Q?8bLpbSMa/H+YOsjrIiOZXIhnJBdbmJRJkmepzTpD1QQzf78rq7Ckt/UpyDxH?=
 =?us-ascii?Q?lC1cbUeSqYmmN6P4KGzRsK2xj+NhqwT+7JMs8VZG8hkQZYUtzSF9uqVYtWB8?=
 =?us-ascii?Q?z8UCqYt84GifkHSY82OFLutgmPAAaSbXfVklhz94WL5a3VOZMOXZE7t45VPM?=
 =?us-ascii?Q?MQRiPSaGYnJfsT5I8ORCBj0xBR6v3YECV4Ig7e2+gNdM4HIhQOZ2wAq0gK1D?=
 =?us-ascii?Q?eDc49nJh++xTlKtxHVy6rQAyYxPhp00KV0IKIkvMcXVDOldUIm8OOhy6TWqd?=
 =?us-ascii?Q?3/MWIPqR9cSyskCcyzIeLk8VexPMNwaV7rYh4qtzDfn4VcWFHB1mXaR5z403?=
 =?us-ascii?Q?HXUdehvm7ThQY1sADk7HHzm82sAPGEgMXzAuL4KMQie4tKNhgOycJsquzgxK?=
 =?us-ascii?Q?Tn8kxROzc0ubsOhRsUQ2970/j62mVcTQr07lOZizm1rqybXOKEI3uGYf3SSH?=
 =?us-ascii?Q?o/U9BkAyRnuKZx1KJcbnmDELXi+9uit8+EnA7pt9keNBC3s8Qrl6xQM3Xw9r?=
 =?us-ascii?Q?PgVgWQunsd5X+vrqnaHuKROwgBT7ay+VrfWydUu5fkx25ZfNnsc7WW3RNmF8?=
 =?us-ascii?Q?CLIght+ap3/kORzJi+UZnwVyJKX2Sd7Pa6XEJ3jg+oE54KBN3jDUHrP4OfdU?=
 =?us-ascii?Q?vdkcpGJLn2FcB1/nqjvx/XEHV9zj6HoqrjZXmm2Ybi3tesXmap+GxMsk85aO?=
 =?us-ascii?Q?rzFRQ41IiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61378177-6e10-4e34-5457-08dea2972a47
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 06:52:06.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZhxkrviV8p4wJ9TMeDpl6bdn9tK4VkjXxMshlN3tx4NjIUJrDmSQfPhLu4Ya1cDBHtdvH03cDzsyCXjwjxEhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354

On Fri, Apr 24, 2026 at 02:19:51PM -1000, Tejun Heo wrote:
> scx_root_enable_workfn() takes cpus_read_lock() before
> scx_link_sched(sch), but the `if (ret) goto err_disable` on failure
> skips the matching cpus_read_unlock() - all other err_disable gotos
> along this path drop the lock first.
> 
> scx_link_sched() only returns non-zero on the sub-sched path
> (parent != NULL), so the leak path is unreachable via the root
> caller today. Still, the unwind is out of line with the surrounding
> paths.
> 
> Drop cpus_read_lock() before goto err_disable.
> 
> v2: Correct Fixes: tag per Andrea Righi - the missing
> cpus_read_unlock() became a (latent) bug when scx_link_sched() was
> made fallible, not when err_disable was reorganized for hotplug.
> 
> Fixes: 25037af712eb ("sched_ext: Add rhashtable lookup for sub-schedulers")
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f333fd0cb83f..9eda20e5fdb8 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6736,8 +6736,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  	rcu_assign_pointer(scx_root, sch);
>  
>  	ret = scx_link_sched(sch);
> -	if (ret)
> +	if (ret) {
> +		cpus_read_unlock();
>  		goto err_disable;
> +	}
>  
>  	scx_idle_enable(ops);
>  
> -- 
> 2.53.0
> 
