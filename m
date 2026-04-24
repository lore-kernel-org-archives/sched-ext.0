Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B4239E6C
	for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068059; cv=fail; b=cd1aO+Y/dfu4nClsIPnJZAhe7MUO6aV3VgEeNLfWZsOWvn+EjXF+/M7TVrKGE3GXGIVDKzcrxBcq731iRC3EfQyDVQq+0qHGEOyZCk+jBkLR/+HnakF3MhP83KBp4H+31G+89ysf++lzZnSDZJkoVp+KRLr8c8jx/W8bBLqV5eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068059; c=relaxed/simple;
	bh=LXyo196A/iFui+p+4mjkFQaZ3UNCvVvX3b9QCaV/f0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KQND9Exzxf4HESLYWYZQnWIckev8UwZFY10O+SnZcSN/eeMnx6yLRI45dW37O8UdWoUaC0V1H+Ph4St/EgGVS3CRz+pzGU/cz3iJiwf/O67XVPoCHl3jDSYTB1ByZrZOaC1eNjpvfAs9v0gmKCAa7GBaDGMrpZ4u+fU1vol6vQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Umqc5iZS; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Umqc5iZS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu/CInxEJcchmwsIHnTgv+gRZxnGSoVLdQC1yNvXw9ysXnXyky75iEcj9lOaK6o2H63WDg1uu0Qhmb5iSE4C0E+1chVma76haRCINiZswUJxTOamGfuRNijPw9qFCb2y+ffJ8wqbTizYbrWhhztmQ7nh82V58ruya4QO+/UK0AiHjIDvVvRmmKhx80yqqYSUA0LmkSvN9ej3bu9w6tMkKuZZPTRQDQPJrP5nseYwp0v2FIgpHCUsIAOpUMD47PGhi0hdcNpS1BOIlQS1TWlbUNO5iOXfZAEcdLXGs7RxfA5ce3AcsxGazgI9k1iBEB6rPDVY+C8wkyMqyvuKAO3/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3pxBhE1U/6OsfbddVs13dajbtaIUklBnEc1ubePbvg=;
 b=i7/8+fAIFy6n2LNEYQIHaTj81NvWbMLcb8GpxyXyG21j1veymxVoKMaJNiRklWz3r34OdyPp35JAdnFhHrUBTWaGGPcoipL06kVdRxXuQTPfhFI30h3q9ChnnkGUCVBAmHERcUV1L+LHCb5l+n3SqxjL57hiRoWPNrbEgseoLaneHn1rJs1onUQ4RFELC/yCxuKseswKNDTTbDIVI3U65sLrFZTnonl0hI+8cUfqQDrObWFB3NnyC2swVPfea/TaETmMkM4sGC5DgAAc8gB/nQfYP6juD5OF5BvpK0vquFU8eulxk/tvDRVQdd+4AoA8ESUfAi13xbInd56ZNq/Egg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3pxBhE1U/6OsfbddVs13dajbtaIUklBnEc1ubePbvg=;
 b=Umqc5iZS+EG2w5yVIk0XXJ5flIRBHu91LN0W1elP1bNNryjw+YRQOUL6shX2gfacppEE/Svfts386vPMyB2jbLP9GQlxWWfa9YgFwdbsG1ps0loQI8a5dGlV/Vl8aWy9MDnTJJcUqp+MtHuLdOi6haiZ2MERG7VoXE+YjOzCV7AuFNSGi99t68NrGSZXjL4xze7UdJCULKU4kI6y29pWjCbyQ43RvZy0uwSI1qPiWBwnV7vROou9J+vhQvCdE4rl7eQitkXlmXfwjw5ODGqSxp8f/mpd3S+cZ1SUsWuHSErFMWg7EX9FzFSx2BDQImw27vy3G8GCM81/OUdEZUzyGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 22:00:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 22:00:52 +0000
Date: Sat, 25 Apr 2026 00:00:44 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>, Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>
Subject: Re: [PATCH 15/13] sched_ext: Release cpus_read_lock on
 scx_link_sched() failure in root enable
Message-ID: <aevoDOCJggMKtRSv@gpd4>
References: <20260424204418.3809733-1-tj@kernel.org>
 <20260424210802.3842919-1-tj@kernel.org>
 <20260424210802.3842919-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424210802.3842919-2-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f774b4d-f962-4421-3a3a-08dea24cf392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ruvUOkKYH1kD1wUf/31icbKOfclJtBwnxA9AURdq4MobKymc7rftNZA4k0BLhuTBzs991b4cVgTxvt+rsUeTF6LKEE0wTWLey6o+b/aZ/dm0saOrQk3NZD8oZCQwEC8YTxIj6JKSuex8Uao2msn1B9zS+YrABNP99hSuO4s8WRIv68hMb9bjA8MOPmW2Y5J1Cm1ebHHRLp6gsthmyY9pMj6z4JQpa49q41imTig+/oeouK0bAeBsrCNm1GnjS4rL4PyF95HheF1QZcvFs29n1hEJXu9fO86Pmb5k6uxPJFuvD5USM99DxY9ykTtZg8HR3LPq7Iajxz4O4Qo+GD//Es70VbfNO7tCgPG6KSiOnE0xvVngM0TlXZ4B4P6CpjchzufqJWATZ7znIoKQpIu8lt9rORmfQRg0J0U8yZai+SAt0O5bU+9DhbKdvPrMUdtF+EjqY3nKkH9MfBQvLhBRxht1hoFDMFefuiUamUe7yhRlYjl/uWk7quPmS4eVTuPRwUTRXgFhny7Xz+7JAbdZ293cZtiYhHBb31KQgbIuTPpvtJV5QTsUm00PkFaxwzoWpgiOA6kJlxfXcKBF503ZR/m2mxy7nmSGkW67RK/3Jiq/OZGBiTOmSLrMWNMIVadHdhkKr3TX8CxURilPY7C+crcnxoBF0kiIpffX9NPPVmsBojmiV/uu0I3JRkuOfScXvSnh+aZ5uXUBLoATjKldSieY4uprmszuGqlyfcy0u/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rrl0wPlqcMDYitdobIg9DPB9KCBkKomO3MplR864oSw8xfiaYCO5QYrDBl/F?=
 =?us-ascii?Q?L+YLKJiLPjdj3gJpJ6xqAI94l3tWdg3v3kPf4NNvPAFRUxegc0E/beV56IRt?=
 =?us-ascii?Q?jlolo6Yc25Ty8eFn+zl03ZsbHFyKlpLxIh0jtoO1IZ9Z9WBjB4URO8q/EOhR?=
 =?us-ascii?Q?v1X6APXH8zq8kJAPe0hxAOGefn3g5Bkp4ykF1oGohw8v3XK3QZox8lgJIsue?=
 =?us-ascii?Q?vmCyIu3oA6v7+zOoX2213gpZgb31i4nVZaFgibYCxNDcuWtn08hSBP+yAlTu?=
 =?us-ascii?Q?vtQ6yWEnAOQYZl56j+1McO8EBHo10NP5SRXMbgZ2rq9WJkJ4vQTh3DkMaTjv?=
 =?us-ascii?Q?VHbBMbeUOAN4hutBLlLcbQYMpxJySNC5hu0r0Y1mk2VWvZKLk0x5YMX0fw2H?=
 =?us-ascii?Q?kR7iMExLKRZQeW9LL8/9BZ0gvp1eCR/QFn0u9R0Ac5wGN4b12pO0CgzwKdoq?=
 =?us-ascii?Q?k0aGsxeCSxIa+BU9giPxOWw6V/DsqK+/klSQEB7sj94FW2L0V75lierr3dXa?=
 =?us-ascii?Q?ZdPbY6vh9Cz9+VGMHgGEXJ9fYp8GcEwKhic8PGWTCvwp3p6fD9QCUF2YIb1f?=
 =?us-ascii?Q?J+gupxvve9S+Ju/5TSPLCwCKxegKntB9cjFMrsaqjZ0hHiC+1HgeycBWmIVU?=
 =?us-ascii?Q?IlIANezI0FTPFHFf/YmHc619o0G1oYvBtfQsy38ojoAgcbmA8A0tdBDNwNFa?=
 =?us-ascii?Q?lHghcNjv34//1xKSrB0odaqqjSGGRP9Eouw+5jJT7dCxz+6o4KLLNPcDBfzJ?=
 =?us-ascii?Q?LLW8+Z1zxRHLCB/Ch7iesb9nkD5FC+47tQdlJfuJfTgopgD2F3Ct2BaFGBp3?=
 =?us-ascii?Q?0cxyJ3rkOcni9IESLC9sAmO95j0T0w6+0pZJ2spRnhiEOqtA/76VBzl1ixiC?=
 =?us-ascii?Q?DgmvBvAZT7n98MIxIVUqYpSYC6UKFumEORHOv+OGf158+rlYFMiuwuWzB1DF?=
 =?us-ascii?Q?CfSEWCxlZzwRXvOatIBarzPZHqEY8MRV8rN9u6DN3vS83UAJrNtTHtsyFRQF?=
 =?us-ascii?Q?QyD7tyuaUjwjelvblc45PKBXQsXn+pxZAUPDtJSdNb4f4oa2AoD5QRpDhXAg?=
 =?us-ascii?Q?ebiT0Hkly22jpeIpGssV97pWVU5TX7m9U9bjQmsogyT3r9xmqtpNfRKt5tj7?=
 =?us-ascii?Q?UFrc+/RPdvt24ZNZS7A3kRwKP3W2BwCaYVocAJp7e1FjKMknIyfXrTZvkM5c?=
 =?us-ascii?Q?vRoAERSfgnwgwELqM1eCBVb/EdsMsCX7+r3AC5E+7SB/6zFCN+pQ9VRp1Syc?=
 =?us-ascii?Q?r/XsKJib8xJFmGuB4KlotYBrcfy/sq5rLtpDFL6EROFoa6uv0e1veSqJyOgD?=
 =?us-ascii?Q?bekELmcO6C1nipt4vMElMX/LPJTRp7LdxiuvsiCB2q3CjdcYv3x6o7p6o54p?=
 =?us-ascii?Q?nEKVQuT+kfLzL0Sd15MQhVItKKbTpmEyVTsoWdhJrYLxWvQX3/eM27ZXP/+y?=
 =?us-ascii?Q?OgAMgaRjlZCJrrQHcNoimeYL/Hm6g966ZeeJ/jKEu+mtAWjkfAOr3wDfZ747?=
 =?us-ascii?Q?acLEGkMzntehvatoLKtBmmaVIB3+JkQX2lsrmzLwMAWZ/Zout/4US2LNBXUz?=
 =?us-ascii?Q?UXVym4CfA5ZRkslzOYX/l5KNPR6MWxt+pRbnggciW/07pVr47qJEUgQ/S0uC?=
 =?us-ascii?Q?4zw67qHcrJKpBXMnXblHVc18ns4H+IWL+kCczB3yEk8/xxkmAkrdHy1nf0+D?=
 =?us-ascii?Q?KS7ICr/eoPkgEduWEgLh74WX5GmIW8aFPMlBRXfV4g1Cf7OfsiY+BAwcZJu3?=
 =?us-ascii?Q?I7s7qInYrA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f774b4d-f962-4421-3a3a-08dea24cf392
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:00:52.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2OU3s+vNasq09N3J7yGzaDE5NxngFkoaW7CAZkDpCOz5WCN0ClG7eCuAijtm/4LXDMLjBjFTeoZ/LeF39KkfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039

Hi Tejun,

On Fri, Apr 24, 2026 at 11:08:02AM -1000, Tejun Heo wrote:
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
> Fixes: 0128c850513a ("sched_ext: Exit early on hotplug events during attach")

I think we're fixing:

25037af712eb ("sched_ext: Add rhashtable lookup for sub-schedulers")

Thanks,
-Andrea

> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 52b63266e647..d374a5a16bf9 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6715,8 +6715,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
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
