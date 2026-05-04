Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79454199931
	for <sched-ext@lists.linux.dev>; Mon,  4 May 2026 05:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777871844; cv=fail; b=PLn0ixSpu+1fvuQF8PhxGhxnTHzWdXRHhMEb4uhZ6UVgXen1OhoKCyv4xLS3fB92U4GlpDQhcR6xyYvhKooJ9QXZk4uMntr02IkWqs53X8ngkdvoYFmYsXSR0G40iYIA7wcGNBH430S/++fnl3a6ATeWukXWGM1MahQi4BbYHDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777871844; c=relaxed/simple;
	bh=A2FXFEhyyDTa6viw3Vn1Liq/75af0OfHeMwXI5YJUA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V2kPIz/w6lpBcxKNc9twhvBAV0RUMRdZ3kcq8bSddGVewiSC96IXWQJgyILTxckYHVrYruV+5Jy/4f8tzMMrv/XUd3GU5xtmRi64QltYzC7DV1j2qVFOtiQ+3bOQNedqKM1+rxTjfTKyVt0SmW/aHbnkuXT2ht00KYJprMKdVdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kt8sePei; arc=fail smtp.client-ip=52.101.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kt8sePei"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tU17T4dHa1usLkkIrV9kBLPzP3y8q71LaYDTUoPBH4aasvwC5gOxlZ9r+UaN9Dhy2jbjNI96ZnIv/6pcyuY2K3amppp9Knw46gstV81yDxVDEogzR8WBZJ4fNLyK9PHXxYGXPkXtDdBeweqcCAnzb9fUCnCsKSNFBzZAxA9s5z124yYZ9ECNW47Pp6DwCEGwNQ70XAjg/gzHmMf1+hHTEsPXV2QtyJdxk9idpLmjjXbsvYyJbmyeJ7Y0Mb2dD6sPQ9ixBpv7DPInAG4bucSQnARR6WaK6Hgm4aejLiEysSDBUnIAHb7zChUYOAAx3HHmukEBoqASUVViiD0QxYuPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Scgkj44FMNy8qewEi6FKlcJyXlJR/bzcASR/H7vzMXM=;
 b=j/TwG8ncHkMdndv7BM8nMT8t1sICAP9Q/0F4i4/LhOlGrOUGK8xhisGKE+FuL2DcxCBjWt+p76yj5YHdr1p/T9lLeRm0ys9LOjmVqqze98ZbFp0iLD8H5RMLCPBuzgcSX0OWYT6TFBuG8M8djPko/vSbJu7kb+cJLMw2iW2iaqiGJXWzS1m8d1eATTD5ps7XbeXl8+qKXAiO6idEzBbbs3ZRJ5LR1bOXLKkrngJo10s4pDMQnJCgolOGSlEChl5+tTsXDeD8skzbQXAxN9gmi6/Ljh3WD0THLGUyIZhKa/nnisZ6cn4JGeSwHwfxiwjtj7E9E1FZcOsIGZwVZax9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Scgkj44FMNy8qewEi6FKlcJyXlJR/bzcASR/H7vzMXM=;
 b=Kt8sePeiIvzui1jLzccZrt0qirknRbfSKwatHXD4UBziM+AO8Fjx/XJ4XK+ErpElXfDJ1O/d2uYk0nYbTNwycD5a2EMNOf3HUVxUqkTMTnNRyjHsNj3ss++ABEU8YWA3jGRJs7WPxls/Y5e5emdJJApt9p23tI9vd3eOEkyqCHEjNTYZ2gTg0k6GmxtmY4SCG4XBryUbjdv5u9AftL8zmOYZnO4/wG/Yz4wOLKvA9MbHKzeJ0uxv9/nWQpcoe7EqVcCmccXAAtTRhEzBoByDREUyvP6kGWVJggksdoFotq7Bpry59rM4M7BeWKzKCO55HNpif/tcLkQrzNLR/3Fk1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 05:17:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 05:17:16 +0000
Date: Mon, 4 May 2026 07:17:09 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Remove redundant rcu_read_lock/unlock() in
 sysrq_handle_sched_ext_reset()
Message-ID: <afgr1Tj3n85nYsdZ@gpd4>
References: <20260430084543.25137-1-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430084543.25137-1-qiang.zhang@linux.dev>
X-ClientProxiedBy: MI1PEPF000008C5.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::427) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a043e5-4a4d-443e-c949-08dea99c682f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bVt4XKapvxXUUpB07BQrn9tuuchmyoA7oaD7pK2M6Poo0ilcZnSOM0BrapQYEKv758ClJb7cZU3woV00TenKKokfuwKD9KWUMuoSDKvYpCZVF/9wgMfjicKhUYFlidpVfJN5T55oVYrZM/hHb0LtmVBCfltP0SwUYOEepHfG2VrE4kSUT51gQItZ5TwYl5R9frBVDDiprEFykMUoKROqqoUaHy6Gbbr+yvX53w5lHln/T8jIyMP1WcLlasvIj+t6F2+r9sMHw5wGAeNAq25AutH7vPYR2B5+JWMAZYUcWitVB0ADx4STRsX5nErQ7sS0PRP8kKYFrotASeLlgAeo9PBR3KOjUb1AOpCl8HnKulQ9LtIQ9NyS5Ay+7F74nhpaNxXjL+emwW/M47/b98Qcs4js2Dlr6UC2yk4VJj15wy39YRv2of5lh6YLJjLVNj3/DhAK/oh1l0kDowvXd44Q9zuqqhGKxEoOtvAVo27B1/LdgHC/oSeKQtjUhelU0I8WbPAdmnDUX8zTLI+f4ly9qUP1AuwAyJ22eKC/UMoSyRgUiixWwho1vKz8KHhadi24KpKxBAPDFYfRJt+Tgb7k6hIY5f+vMzRISU5MX75peuvS+CCgigzyO+P7qc/uv99PcPmWV1nYiD4+KG5s28aMnuyusKWh2Eb1c9pn4eJI6p/5DhpUAEzM3ipYawCJZmtB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yogma3djK+OZPK1zmX6yyEdh8z6Kt8F6ZG33JPLNrCskpg7W3Hj0WQs3fvKn?=
 =?us-ascii?Q?1r7UUK4sYHoGmzTdLo1NvdY9eaHIiKPjAD0sC2IGeHLJjp9zYRFcnwHTpTy0?=
 =?us-ascii?Q?IwVcAC7APHtTPtCcK/CxKDxMi9ESumAuVc6SsjHZTfGDBwXhb59Qb6zlBGNx?=
 =?us-ascii?Q?NRekPgMffDXBeU3K6eoguDT5EKyrOjWksUpkAvVAcZadOocP0Y9PR/yAeIc5?=
 =?us-ascii?Q?/OB4v4/4BL9LoPO6OfagaCbvtcEy01BU7ortg14PClGo0H9YhVn/TOCYs4kX?=
 =?us-ascii?Q?pAGeC1QBNdxGL/f0F6led9lrxEUjfRQcJGWebjtZ3PbDNzcKQWPGxKtSeAZU?=
 =?us-ascii?Q?MnRZaKTgrqQr44Cdm/sWchUG+6dXlBJQKpypPUJVKW1nicz8PV36ucURpOY2?=
 =?us-ascii?Q?UAnMRmoA7ZriX1tWpON4Cbw0g9Fgx+BXcTALb4QSpncB0bgyGV3I9413ymn6?=
 =?us-ascii?Q?2zwqE59/XkNACEli2ACX9NwHIsSAELaSJE23LQ07E0x4zy8O9egjkhL8WojJ?=
 =?us-ascii?Q?XzAzaXoHOolLvkOiMCdQgopT5ATmbyMDktKClsB47yYFeynbudJ3BCZJ7O+u?=
 =?us-ascii?Q?ODgJqs4zRcNGncEKGyFNme7PEuCO2XXDn64fdSGmAqD67ZBx3NnGmp5fpXhZ?=
 =?us-ascii?Q?T3MuL6N+5awMPV+B3weIxpXeoylpruJwdjxiJ3lIh/bkmlaRTNSHsIKd4VWc?=
 =?us-ascii?Q?V499WWkDXMlb3VunsbZ5Th7GSt821Wrdno/iJGYZk14oixMn6vPT4HvUrQ2M?=
 =?us-ascii?Q?NPaY6yqbln/kmwRPwAyuk/O4J69EWF7HTjZ8HRU1OaauvJw7gN00opHVgbu2?=
 =?us-ascii?Q?QeqS6hMtvc/eAxlqCd0R08iP8wtdq6mboJ+P9NFSVTHSGe8suVZd/nOTuzk4?=
 =?us-ascii?Q?rkWhNTM81DqKCBOljuImsKvBWLThftKQfQEh76/MPk/tcvHuJEBWuYCwfVf7?=
 =?us-ascii?Q?6apcSpGZHmnjXeJp2VITKBR8C3FY9sFWaN0z2cdQR+R/i+RI6/oKhDtq7sGF?=
 =?us-ascii?Q?CUHxIOcTldrXxQLIslRGOj6DNFYKnGVhyDkBPhOMIUj/bXNfk9Rw9zaqAguO?=
 =?us-ascii?Q?fVCRwt5gLBgIuQAJuKanrvzTXl/Dyus3CADGMQb9gzZsHAnsc4KeZeepAPum?=
 =?us-ascii?Q?8WaviM2np/R7O6r49cYe7UNc50taDtNr6PfV6gpFFBizSnQ2Qi2GzYYXEz1g?=
 =?us-ascii?Q?AI++LyTPXZUDE+LCRuuhHgQSwsHi4kVCMGgCfapF+XLK9gDS8yhYUmdAEufD?=
 =?us-ascii?Q?c6oyIOjkoUZg3rDnRjWFvT11ZB8Zt+R2/MHq+IL/JI4VfQ/wamJXecBHj+zL?=
 =?us-ascii?Q?qW3KkucESCdT4F7JElf3IlBBmILp3f+dfTv5CsaxCDM7sR2NTeFxp+97QJ3c?=
 =?us-ascii?Q?dIxi7hhXRyZ17oWLbRJZU+q4PCzLfj9r/cQoVnLYzkO0biIuH8Cn2RKE1wfq?=
 =?us-ascii?Q?oVMQicy2GbCaAR5cvqnLYJR24hmgCnWu1Tx7b3W6F9Vq6yDnUPtG0z05sWNL?=
 =?us-ascii?Q?qYFHxalDkPqhXUFCpg2Ahq+btrM8qcTYMgdoVFmpwKsXjfXoOw3jZ+pwvJqK?=
 =?us-ascii?Q?xbSDlyxIPv/QWh/M9nr9+Xmj7+N3yy+Uz7VN77sPJUB5GFSYU/URt9wZxdRp?=
 =?us-ascii?Q?s/k/f+XgbNiEZ4SG7uaX4XoqLqxopm+46ZNKfquXVkNOgJAt1qoL5VvLPtrK?=
 =?us-ascii?Q?yA0Dovx4zrsdOp3gjBXwQIeNI4NOWRq8C4stsPDH+/4Jj/NZnU7mgwjyHK+L?=
 =?us-ascii?Q?bH597tob/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a043e5-4a4d-443e-c949-08dea99c682f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 05:17:16.3232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8y6bp7IEc6ZZsgxRbcdOe2S33DkBhoMe3lXZuI1HtyHTC4ZX8+MeXTjy5XmuvBn6MG3XFJnLkctgbKJxBEbiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871

Hi Zqiang,

On Thu, Apr 30, 2026 at 04:45:43PM +0800, Zqiang wrote:
> The sysrq_handle_sched_ext_reset() callback has already been
> executed in the rcu read critical section within __handle_sysrq(),
> this commit therefore remove redundant rcu_read_lock/unlock() in
> the sysrq_handle_sched_ext_reset().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 45a2668284bc..0f3e9d088151 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7953,13 +7953,11 @@ static void sysrq_handle_sched_ext_reset(u8 key)
>  {
>  	struct scx_sched *sch;
>  
> -	rcu_read_lock();
>  	sch = rcu_dereference(scx_root);
>  	if (likely(sch))
>  		scx_disable(sch, SCX_EXIT_SYSRQ);
>  	else
>  		pr_info("sched_ext: BPF schedulers not loaded\n");
> -	rcu_read_unlock();
>  }
>  
>  static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
> -- 
> 2.17.1
> 
