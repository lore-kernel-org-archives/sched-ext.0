Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39C3DD87A
	for <sched-ext@lists.linux.dev>; Wed,  3 Jun 2026 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511944; cv=fail; b=ktTlyrqOW13ytpPzgsa6UESe8yW661ypozO/jbok5r/MifL5dBjS388NQdkYuuCWSSMhOl1/dIXVkOlvWN34zmOgGhhMkA0XlZg6jip19JXHNNguIBZq6N5q1DrheCN7jE0aGcVTZeULgeUZJ9mYGOO4ZZPuExpAMj80C7r/rec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511944; c=relaxed/simple;
	bh=b9+Dst6GaXsoWheA5hWecTEXHS0VbHfFC8O0piuQjB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=quuQOUGMScZHSgzJ+3qP8WNGK34XOxHPyFPc0Pjkvvx9yFQnxUkof1xQ7wY49dYk2PkuHctcp/+abw2SV0IIeC0epgLDzr4Admcmqf5/fedZfJrRl8RihWfe318cmORLjyfHC8StfMdjiyyyspEnn1LzNK/pvBcBW1JNKzbYMBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fR983OWj; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fR983OWj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snTGqSVgR3wV77tMNWNSSG57Od5ka9ZAyhMmrE2DI1JbAsZ3g1HsEDanuh3Zyi+tR9oC3qoEdUlqWctmPYqNN1cXqVo08e0zDHZxIgPnh55MI7XOavvFleXUGMrKk+BvYanXWziKT+X3rqqV2flZh6ZySiXcxpbJnJDhjf3PKu51aITdpdUM9/Y4KPIwQLw6HkM8ZOY+85kIGjJJdTFuQgtPIiS9T26Ii57CTz/WK736lJWSy2Kgaar4JIP8nh7G/hM+5XrPBWFX9AzYkSrafz+wTQ6XETeBFVeMv2q3R4EYFiSYuUemCB4KUzIgG8PwWNgrFn//ad9B++Sz3t6xUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUHscu5O/+QDukf9TFwbQwpOPiQKt8LnXXSgucacQg4=;
 b=UPhAUzHgg8OsDiBEc6c4qczjnju/RVFCzYZXeOgAXTvAs3R5fjt7mF8u1Eq4rAHkZJwVouyjLvz9r/ZY91D8EFXCKsMXFcdzb4J3fcUosym/AACfVUY4XZ3SMcH4mU+lBCRoVjziCIQJhWsANmalhZiyQAaicOPtP11mvWcqoVeXY4PTR8zDbPwkxTuRLnONZmQkzEntphM0gLXpEqtnwaANCyLg8Bqg5NRtCeVWy9aEnuwCFRPKQz7M4MQXJEznwngJi3ZlQzpbGDUq/39SeAjkmJ14BJM3s35PDE8byUOptOMUJ0dLIHwLTaSV3BvUYWjKnBV58/bCStBjpTYc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUHscu5O/+QDukf9TFwbQwpOPiQKt8LnXXSgucacQg4=;
 b=fR983OWjK5WMZCDdwdD3z8RdeOU4u6I/ohuCJAnSf4HRTM2WGkS2xFRCEsi2smbqaU2DcbHkyK4DU91YG2+lgnvVggOL0ZnR49W2FoXtcPeuHwg1g6wWv+usthOzl2A2KXlHGOWgpwkeBQhbJFypaArt0FPFezED8BXBb4aKEsvXqQeEimnrrNaz98/YUbKvFLqafYJ0qPyNT1qoQfNSxOGFOcDsIaw1ogeVTkul/9DwV4nkgtSAxrnM5nX1kzXTy1Uj0aeDaIEYTL2adlaBjiPLLnY/papCAfpdDlVHDwCAVVU1MgQ1hppoLnERdqulgF7xoZVv3Fb0L0kNj5vyJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:38:56 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:38:56 +0000
Date: Wed, 3 Jun 2026 20:38:43 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched_ext: Make scx_bpf_kick_cid() return s32
Message-ID: <aiB0s-UPTAaaIIdA@gpd4>
References: <20260603172153.3081861-1-tj@kernel.org>
 <20260603172153.3081861-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603172153.3081861-4-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 3338bd0b-15ce-472c-9bac-08dec19f5e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	wF8fnVfVmr1ZNfxVBDFfVdmliTVV5rWMp8NorQe2BLHggOhLT8M1oqfiwBx/2xCzU9PiotpYtsNZCzj6QV+uXKX59zEIhiLwT4uvLYWgc2J3W+tBQaj2ZK3fhBtMjbGefa1OgNjAxTyz5tS4OtKh126nE6cpMzLsRx37bRMGXI56bOQe1fMjn4PIXU9kSxOF1IjCQiI8R0z+Wass8bPRjmDNxnvlT05Ns+btnNMq1+69LQACaBgMdggfoOBxkbTQmfahk9yo7WR5ozbRejiesGyqyaL1vRDqnhus9DU7K4i9Q68LGx24QmFe11lQeoVrH2U9HKvh8mC+EekpaueHtJX+Yw5H0ttlEBF6Tfvu7684fDdopElJGYRIBON7CMeuWcvyrfj6eAK4UliRzvRPNlmHEGjEIbOhz+XW7bB+FnZ+eZmAAiclJy3uqi7AS6LIPkyankPX1HkcYGowubyUVoTpAp1LSwD/ahbAZr3yPLTe3C5Au5TDo/k4fyBRCsmOkrikdCtpKBLlLWyQd14VHGexXMVgK5jeH3kkIJwdJqNGVS4jSPktU6aUQBzjqfDQKN+ZfEZ/prag+fXrwOfG1mPcWUGX6KArf+uHN0DIwzKkk1CRxmdMVpmyy5k+PWymOqMMqFndk2kt4jPfWfYUKgD5dpyCgxJyxnYWCRRGq+iwrZIWDfEFE+c92lSPy3MJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?22GY3FvF8LnLPzZLSxuAhnA3tK4vt417Qcyeh0uu9gxWpvy0ETojCudEbXfB?=
 =?us-ascii?Q?DYhTNzN50nUQb8NhkfjcEM8x7oWnbm3w01If8L/SGQEeIjCh5205+hjqVozE?=
 =?us-ascii?Q?BXkLT1usqbZsSfvMfxcnSG7t4OKtbnxyHPpb1GdvQp74bfFhRTU7ozott/rx?=
 =?us-ascii?Q?7kqhWr4NStftMcwI48/2g1pAlEQZ622wBy1+NvZu/ujsnvrP1Up4gdtUg+km?=
 =?us-ascii?Q?OWOPHM1McnBV3M/eKPYAYhcOcWkgMEkgn3itgNwLXI4SqQnkavh/jlZej3xi?=
 =?us-ascii?Q?wAxnBEJqs25FblQy6Ry5wd4QhZXRbIoPhT9X815u0kQC+JAGWcTmSgpQbXEp?=
 =?us-ascii?Q?o042m2ds/nR2FhCzviR5sMhRHhn723maXAGY0iaAHtmJJ6J7CP+13vqyb08s?=
 =?us-ascii?Q?fhyR+SdFU36YCOoeDi4QRRrgCB0seICbIvomEDyRJiZT3SdC9Slb9/fZa8ZZ?=
 =?us-ascii?Q?vIzvXixeKEE+cJsS91yKnSYE9CQdD+NkzzViqMe6suktt3ObQpKLjYrO73ci?=
 =?us-ascii?Q?aDROMSjbfUxRaVUhet1+3Zw+4d4qrgiG6TvxU2K9L4/Rq60l1Ym1lff1E+pa?=
 =?us-ascii?Q?0nmVbO0L615sFgxcRNUe8ekOeWkM6papTl+H4LRpmhtjdH4rQ97+UE4dVfqA?=
 =?us-ascii?Q?DzU3hQwF1ooP/0sB8N6d605Xtr6pC6wE4pQOwSz/qrEQjmZPHXx6Nz+pFPxI?=
 =?us-ascii?Q?90ei+6mYghdMHo/6Wp4Tdpb00Y8vs3UvwD5Cr8m5LlUhm3XswGOAbpRaGJrX?=
 =?us-ascii?Q?Cq0Q9RqIMrJP5Voyo0URtdtyI7O0wczR3pG/EltFB/nlEzmX3iQTatqRmy0g?=
 =?us-ascii?Q?TiSj7fucG3a9tSsAdEqmN92Qr+1P+iSxymkL7YnBNxOzqiOPYhH8i/stRZt/?=
 =?us-ascii?Q?8chGATEihfmz1ZCCjrSgWVSQEw5k3wuL6Wol06tCyuWFxEmAfhOxSzR23U8f?=
 =?us-ascii?Q?ayH5hcM7Pp5yi+YKUKhGMVa+hY73607MGddfeGO7N4W88LKJae4ed90joUvp?=
 =?us-ascii?Q?5zs8E3zfYj9ST2K5Ilh1Te/HE4FnghXAYHp5S/w2myOW/l3uLej1iBqMpeT3?=
 =?us-ascii?Q?ksqxxB9catCK4EVc6joACgecLvgr2d+ZQiaRiXxRNXnFPExtdwWlYfAnIrs5?=
 =?us-ascii?Q?q6t8yat3Alfcrg4Kih0J21olZ0OmyTOW0T4lMzowaPa9wAfqg6vefZB/FhHh?=
 =?us-ascii?Q?5GnTeCGVwsFmv4oH0xHjpWfu5Vsh2YC+4VQxQkhADfbLCzMfa1yQGLCSdeXn?=
 =?us-ascii?Q?XCvBa/Kf4dbvsu3nFOt/EpwctoY0uyxjo8nPKfxDu4RCT/nG9KtG8ylSO0t1?=
 =?us-ascii?Q?EryHBc1T+/DdMvMJlqtYTCG1GjvDPfKFx9JCfASfqa5dAFhVJVZcGjam/AN4?=
 =?us-ascii?Q?UzNAzv4y4w+jYzEwnwiNLimNNZnBrU/Nhmq2IamyKIpshu3WBSmyXE9jCzMR?=
 =?us-ascii?Q?kTf7/iDOvOAYSWD2FWglt9S4JtObqD/KhU4Lq/trKbZA4FSsAe9iulyMSzVa?=
 =?us-ascii?Q?sG9dBrH1gW1Ufa+pHF8e7/7FRy9ROW5wtOXHChD2uQjzZaySSEt3PyckOXRG?=
 =?us-ascii?Q?HEtgXQmz60yeLz/8vKZaH4lwNKDJc3P5Kej9LhZdtDpQLxZ+4vZevbUTE48s?=
 =?us-ascii?Q?bUBAvkfSFgkptGNt0hxnt7i8sLfzG0SET/nFaJyBhpzXQSj4ozjo0EFkuyD9?=
 =?us-ascii?Q?p+leZ6nHeNenQD3XvQQSOSR7bNE4aKhlRh9GujZPrt+fo6HF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3338bd0b-15ce-472c-9bac-08dec19f5e55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:38:56.2340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tei8BDPhAaI1KEHjr+iDX4JhcPnfINdXWnpUxym9IPJR0kIgheP4SSJZXyDvsPHUbWeunGyea6LoVbXDi+dI/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605

Hi Tejun,

On Wed, Jun 03, 2026 at 07:21:53AM -1000, Tejun Heo wrote:
> Switch scx_bpf_kick_cid() from void to s32 so future cap enforcement can
> surface failures. cid interface is introduced in this cycle and has no
> external users, so the ABI change is safe. Subsequent patches will add
> -EPERM returns when the calling sub-sched lacks the required cap on the
> target cid.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c                       | 13 ++++++++-----
>  tools/sched_ext/include/scx/common.bpf.h |  2 +-
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 32ebbc351564..fedd501de67e 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -9405,9 +9405,10 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
>   * @flags: %SCX_KICK_* flags
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
>   *
> - * cid-addressed equivalent of scx_bpf_kick_cpu().
> + * cid-addressed equivalent of scx_bpf_kick_cpu(). Return 0 on success,
> + * -errno otherwise.
>   */
> -__bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
> +__bpf_kfunc s32 scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
>  {
>  	struct scx_sched *sch;
>  	s32 cpu;
> @@ -9415,10 +9416,12 @@ __bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux
>  	guard(rcu)();
>  	sch = scx_prog_sched(aux);
>  	if (unlikely(!sch))
> -		return;
> +		return -ENODEV;
>  	cpu = scx_cid_to_cpu(sch, cid);
> -	if (cpu >= 0)
> -		scx_kick_cpu(sch, cpu, flags);
> +	if (cpu < 0)
> +		return -EINVAL;

Right now scx_cid_to_cpu() can only return -EINVAL, but should we propagate the
error to the caller and return cpu here (in case we add more errors in the
future)?

Thanks,
-Andrea
