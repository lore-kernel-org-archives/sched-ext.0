Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB4D396B76
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783929187; cv=fail; b=HZea88SkLHCSbTpAWJhlhoTjERRsU3VFSMofQW9d+3/hkswLwKztqMsuicY6Ue9C+XzMdA9FAuDc4R9+3Q7dLspksUT2Wnstr62Jwbsk9b4mokdSvt/nGtgNn1oKVjIk3wvbURX54gEyCTKwYyLRp6T2g5DvbxHyDBGQfHyVbos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783929187; c=relaxed/simple;
	bh=BNotqpxGPsDORT8s1iuBTWpWeKqS3BZ9J0s3Nk8fwy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cc/qNF0JhK5YOgYlEdtMP0iwGIKjurtZE1NNPWv0tdjxFHRwhIcVPqzow9kz5AqymdU99dHYNGDftLia/SgAUCSrEJ6F/sTUxBSTVlmmknEIqBwQdsJ0BGZI7vYpIBq82bYVPe2LLiY6WAkEDq8FxZ5XbUbJkC2G5SpnJeOYzuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CSNT8oXA; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CSNT8oXA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9GlGbYALOluT6qKutyubPfBo8t7rOyHBXCNhJBCrWvTw7EsDybdRA0cYBpYt6bckBefC2lmWyGe8kMjg/MxzmMnDVsjWK/8pGACBzLHKy+1/ti1xsqyPpSM/xpZIW1kvMiMXrDCDQXG5MOEwG3VZFqrugAMXlcuLVz872i01OQfZPDLtmb6jGyc7d8lokKioOAIcovFMUGdQ4KYW9Dhu6vLoOtJO1EgB4E76a2fUHx3SYrZC6aeor56MIS/88/jIeqyoZyYUy8Oy2jS1LfHBxlek4EHxt1qiAsRS/J8uJ4gqIv/JRyOZEBMZo9Hp6qEcTHRnjN6dzEfUYIJC3DNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/624QWcNoIwNwYr0m/SLCFNN0eontZ2MYmVYNn1yPg=;
 b=W54j+MQX8JPV3RCd5iZDOFAUm4NQE5OqMniWgeeVFzD7r5/Y8Kfed4/4l6IUfUzGuh77R/efqzHcUtCdYYPlg+9gAkuMxWYQsVlWW1rxtvRmtajFU99aJR4OYpLZ8E5qgBhl4DbJMaOArTv6cUHt9TrjvWMMlnRewWbc+05svJLUm3KeBoLpFSgLKyfXjVYBTcZYR/EmFz8kIfqeF0CZWUhBCwlDCQ5U0HAReIS3HF6u4YLR1SdPd92oAlmeG7h9QjEXczmz4YXNp49ZqPGviDzayUGeDalUVWVZFpWcJSmC/z+f3DU3R7JSm/R0HzssXlC8F4l9nCBqEU/DVgst5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/624QWcNoIwNwYr0m/SLCFNN0eontZ2MYmVYNn1yPg=;
 b=CSNT8oXArcGO/xYa4S439Hhz/BuEktGyse4Ayahxe9ZyavJNHCR1vQ4J7lZ1oc88Y+I+NwyAegNz4HRCxp1nFd1q55i80LX3oUHTBItuATQNdafL8n1+R6LR3zuo0oZZ2QvMON+cRilxNk2qzdlzl4K5oIsoN1sCXIzMmIT36N+DoFkpBuIAmmd8PXQB1Zch6q1G6JqXSI26aBs3QmfzcwHQW4kY/grhxf0n7jCQP26xZkcu9XL5329jJqOmnZR4y79PwA/GvxQ+bx+krbj6jKKXpSzBfLr59K9krGsYDvuVCtoqaoN5WkPKCWt7NdYNwlYtTDD0eCPG+GqVyxgsRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 07:53:01 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 07:53:01 +0000
Date: Mon, 13 Jul 2026 09:52:50 +0200
From: Andrea Righi <arighi@nvidia.com>
To: luoliang@kylinos.cn
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: scx_flatcg: Fix uninitialized stats on
 allocation failure
Message-ID: <alSZUqOKd5ZpH87m@gpd4>
References: <20260713071808.89847-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713071808.89847-1-luoliang@kylinos.cn>
X-ClientProxiedBy: MI2PEPF00000B84.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::41b) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 81eda707-2c23-453c-9bf5-08dee0b3c2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9pYx3geOChv/8EUSvVi+rfBRqaSOnWMnrxQAtHBzLVRvvjbBQWS/KyizWcBJHn5ImU+waSv/1PyC5isDQxiLpJkBPdYZ/wl6NcXnAT1vDMaXb+EeYfiDTOfqYokR/vW9xcx6aRvgrCMkAo7yyMqGrn+EfxhNfvukQrujCpfwky7fdJKlp982D/VhtbDmlaFA2kBJ0RH1B1+Nw2EGdF/lOBaKK4Yhx4LempQ5PKlw5h7mMn6VNyGBs0V1JRBie8taIJoZAPPP721V+8kzKMscUFyGUVxwZRXRuYp4RpK+kPi51WTV/0fTwZY3dmeHh2+SuAbA+y4ifuE1Z2n6/E0lCyCP1ORy91so3nISGT31N5MvO98KM5X3kHtbG/dhZ7/JL34jSx1YOrtAbqW9LRssSQApmPIZkUC1CT1pcvdtoDuIVtSsG05kDEqETwWzTUbv/zpyTUHK/WV104qE/HLUw8JiLCFp2knsvV1paLqjqFitCFN52UHUunq0P7+98N9fYWPm2yiRifL+0XrWhbU9kiTkfGCPc3D1wwuMZPQZFR7PvhQE8ryORqqQv79b7stHJSg4uyadF1xQK1fDsZFyH1evPh4tCX8/0z5G9yBhMSHpUNfBx0W/TIn+ywfMYOxdfFhrf5FqvsqDkCKiu6YGHsGVo7ALnqmQFXxTBogWLcg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dp4zmdQnZvUqw52Jb9+1A+pwklfD0vnaInxfFCYEwJMRaVssw0j9+r3Vue8v?=
 =?us-ascii?Q?gQU+tqEXg3Hi+jqJk0w8iH0xGC7/Kvlu0X4CXVFQXdquUfBIEHN32oFxKUAx?=
 =?us-ascii?Q?Wz+hvNNnt2e8eIEtQs035sMsmxT+rGFsodN2AhPQN5hXm+VUnSVTzeLIjyz4?=
 =?us-ascii?Q?bdSlazpfwRNq0ALe93DccwuvxUinprA9ZZhA5YUe9SDigzg6nbw0z6SaVU6Q?=
 =?us-ascii?Q?GzfKwVmeIGlK5stufmEHs+VCw6QYCXWxwIh4O+o6VawETyDXSP/VEMHIr2h0?=
 =?us-ascii?Q?TQTEpDVlOECRwqSZci7dJ3636MxZV5VOVZK3AVF33ZJGK5j5pyajEBvETf70?=
 =?us-ascii?Q?/j2PuVEm+WGrRP7MMM2lcnJOLs5uFi5SOuZddn9d47HE4qiTnq6QhplLL3HQ?=
 =?us-ascii?Q?/Yv6UF5yW6RrxAfKSsSrPR9YBvg4KWqSH+2jYMvNCB2nPyOo3aipfxzjCU9h?=
 =?us-ascii?Q?BDdhVOL05z/fyVdnveMrnzM/4g1k8oAfV6xE5U5sCvO9EmSm/8VYOF4m/Ily?=
 =?us-ascii?Q?kLeNt34kNn/u6e0yrJEWhtAYDA1kDRp2CMBGk0DMBiz4p9HaM2MRtYYCHZ38?=
 =?us-ascii?Q?8vlboRpq/9ZtBVakBl5g/PU3I5gXmwNfzKk5XMir1t9Ebra1MumMLLDzLNtj?=
 =?us-ascii?Q?vp+LIISCPOMl+Kynau7Fx1p9gOmiRW1dfjPYPIlbxVEBDLKWGCQ3uWN6FVwj?=
 =?us-ascii?Q?lpvi5ZhOACFPSiMF2+fQkbqeVhhEPleIvEWab3wIH3eGR4tr3Dlofr2LHfMJ?=
 =?us-ascii?Q?mFmTiZp0UL5PrXVdDvzvwXcRVODy7W0zpmWJgwVxbGtnAP6tgAEFDMCIGJZe?=
 =?us-ascii?Q?7kBPsTRsEPhB8/+F62ELDqlyJ0YpZIiDk3lbGUocuL+Nq1cRwmJ6ht8Iu/kL?=
 =?us-ascii?Q?AgDxyQz7mhbeq8Weg7VZTkQ2Pnh6nsIWwEeVqnqDzVtGDsPZRoj6fCPMprQY?=
 =?us-ascii?Q?iJ8ro1UnxTt1esVZPOlmM9Sv32xf7hTlZTy1/JyPI5f/fXW/ndmlaLMV/ls0?=
 =?us-ascii?Q?SUf68LnTOCee3AHmboaLVFE5gZE06Yar1o7711Aj5FLvkhMJXNy8mAH1W39d?=
 =?us-ascii?Q?YaaggpChkHiFmR5lSv+/jxOy94QeJf2WBCOE07szK67IbTfDMsFIMwjuhT4P?=
 =?us-ascii?Q?uvMyOq9hWngbuIzymPn5kIW8Tr1pyHjLx1i56HmFekm5ytG9h3Q5CP6Z4RTv?=
 =?us-ascii?Q?JaeuxO6a1Y68kn63ZS8CEuHAJzb/MCUZLOShZL3HUBmdgDG0E/JXfI30Q1OW?=
 =?us-ascii?Q?K9c5MBifTMgn88fr47rmTeYAzJaN2jNcGAESGEYKQO4523Rog8EAKrA+Fe+X?=
 =?us-ascii?Q?PQyTc9fKeE2K04JX5B3gRQG8UTEEBbkffew/tVJrkSs5mEPsnI/0lldrMxYF?=
 =?us-ascii?Q?h5VPSHEtjKmwWYBVJjJ7UxpBucxp0y1wRsHEjtOT3fMmWJbJX+GvmjUDUs3h?=
 =?us-ascii?Q?5s0Fd0UbvJxsfzsy+Qwe16WfeKOVtW+k8mUSWB1sfS9rQQBS26nv6iwqbesp?=
 =?us-ascii?Q?0OEGAQBWpCkclAQW+XzTf1rVJAv1R/+DbIUti/Th1+UYPUrGfpFnCqFqKjrq?=
 =?us-ascii?Q?AiFngci8omkyIduzlIjJeGRKZe5ZZYaTmKjsATGFEA6YWPz0XTMZSGMt3V9/?=
 =?us-ascii?Q?wf11WMr4peHZlLvTGjtABicznVapx9V3TyYeX2LMYlozxc7aM196W/45XFqW?=
 =?us-ascii?Q?WniGe6gEqsgZ3D/dzYGAnyyh8I50MryWebxYpny76fX8wh0FGGNex5buJ8ew?=
 =?us-ascii?Q?3Kmom52RBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81eda707-2c23-453c-9bf5-08dee0b3c2cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:53:01.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2s40+QbhHJ95pwWYZSU49c7aGrjNgdvZVJuSmERwLqyux+0MUStmm4idiTev4E4JG56iHi0dzy9+W4JaSENSpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098

Hi Liang,

On Mon, Jul 13, 2026 at 03:18:08PM +0800, luoliang@kylinos.cn wrote:
> From: Liang Luo <luoliang@kylinos.cn>
> 
> In fcg_read_stats(), the memset() that zeroes the output @stats array
> sits after the calloc() failure check. When calloc() fails, the
> function returns without writing @stats.
> 
> The caller in main() declares acc_stats uninitialized, passes it as
> the @stats argument, and then reads it unconditionally:
> 
>     __u64 acc_stats[FCG_NR_STATS];
>     fcg_read_stats(skel, acc_stats);
>     stats[i] = acc_stats[i] - last_stats[i];   // reads garbage
> 
> Because fcg_read_stats() returns void, the caller cannot detect the
> failure. Reading the uninitialized array is undefined behavior, and
> the garbage is further copied into last_stats via memcpy(), corrupting
> the baseline used by the next interval.
> 
> This regression was introduced by commit cabd76bbc036 ("tools/sched_ext:
> scx_flatcg: fix potential stack overflow from VLA in fcg_read_stats"),
> which replaced the VLA with calloc() and inserted the failure check
> before the existing memset().
> 
> Move the memset() above the calloc() failure check so @stats is always
> zeroed regardless of allocation outcome.
> 
> Fixes: cabd76bbc036 ("tools/sched_ext: scx_flatcg: fix potential stack overflow from VLA in fcg_read_stats")
> Signed-off-by: Liang Luo <luoliang@kylinos.cn>

Makes sense.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_flatcg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
> index de2bef86d64d..7799782b76d1 100644
> --- a/tools/sched_ext/scx_flatcg.c
> +++ b/tools/sched_ext/scx_flatcg.c
> @@ -105,12 +105,12 @@ static void fcg_read_stats(struct scx_flatcg *skel, __u64 *stats)
>  	__u64 *cnts;
>  	__u32 idx;
>  
> +	memset(stats, 0, sizeof(stats[0]) * FCG_NR_STATS);
> +
>  	cnts = calloc(skel->rodata->nr_cpus, sizeof(__u64));
>  	if (!cnts)
>  		return;
>  
> -	memset(stats, 0, sizeof(stats[0]) * FCG_NR_STATS);
> -
>  	for (idx = 0; idx < FCG_NR_STATS; idx++) {
>  		int ret, cpu;
>  
> -- 
> 2.43.0
> 
