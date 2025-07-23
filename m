Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB352E5B2F
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272754; cv=fail; b=hAO2oZyAKfhN+hff0Cf8VukjoFa8dE1GrXJ1V1zwdE09azwFUn9zg2bVTbBWrNwU0CPhG4J1ZUNaazOMUChjm9v3AO4+OYmzpUpWgNTEKBmsUtd9ceeNgZ+yrvggZ+oRxohf9cL0ngkhh9VOqHYwkvm4LVZgDxBX2WytTNAOl6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272754; c=relaxed/simple;
	bh=nd+GTjHA7QZoewFUUcY3G+yqmh9vO8ulPjyTwExF2M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tXR+oOvdawd2WyR38bomIveJw9bdHpV3iDW+5J6AK8jaNsgEskilhu8HFFC5g8hQOGLbsqaxRy6VxVoHJ4U4fB+ZAtROwDR3Nybnvj3wpH4UgtjLqt0DyyXt5d2q0zvQ2rAsnubyrdv//KYv6p4PgEIJPKBdoqpMpCcSHx3gkLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pSvqkbqs; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pSvqkbqs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGfHyOaqkUmFuBEqyil6BQ10VmsDGrKGcfwXe7Q2ceLia4qP++f1OYM2UJDuGiYdnxKZdFpH52m6CEC3gTiZ8vztroNEV4r/IljNb0eZ5QJOJiPt7dZrm5AK332mcZelnYkHLlAQsPKQ/M/bwPTJYfqcHu6iEmx4wuiVJtyysi+WUeIztCLAQKodSQ23GMCehgk6GTwGBcrVGchs0fUyn7SJbvxXCiy3Wo69hOXJFTX6GLrrhv8XxeJP7eo+ccvpK6JOAD4PXSCkwJccAOj4Gq8520nlKFO+XqkKFnnUtydJfE5D04ZJt1ymzqRYRQcxuD1Cb9xNVApEtwz0wdEyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqOb59NeoROKkFdszT1U/W4w5/E8+t2GRKRRBkwlZLI=;
 b=adc8VgkCjJWGi/ZDq7aouU6LiIdju3ONXxrRH7uSzzJtfxLI+07xJ1Ww5cpg4YvS8TjC50hbPMq+7OtB8lvHnUWk1sq4o99cCW5Y8Rz7sza46zqFbKEJ7FQSDnvyPvabp4OxG3iqLyzH/X3g6vrhqBwwxBPaeqQ9kgiGqx2dlzbCsalJlI5NFFdKoFZSVSedAea5R6yRSCXwNoiQo1GJsJ9cXpNcp4fhUOEALUyjz5400kpLnq8G4DJc5cLZrDtjbRYY0u4VOC7bgfsp1zsrpP4svFHqvcz4fFpEng7uCXLldsVPqmDF9y7LRRk2Q5ia+o9zEbBDCuJyAf9pzqeD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqOb59NeoROKkFdszT1U/W4w5/E8+t2GRKRRBkwlZLI=;
 b=pSvqkbqsi7aCWipIz9z9LjwfE9FTa5P6P1HC41uDR2FARP7zlIuEAfLRUCrKkQ3XyC94KtcleGY0to/ogo1aqpDYYelZ6sdoRv/nDvNaA7eS4bW0fwCwWZqksCkmI4djQm4sSmb6Prrri/EM2beuhKqfBfuKfRaSwNgURiqFHDricVCBVXF82YNz2f+vcYca+vFQ+IQ/01sYnNG5fZwxqjHccg5cHAutc6CDJdWg6iCTGCq8LHo6mzrQb/IektmUnHPknmVH5UoT5fZu73Xfm919ACF4AJhIsy2Xr6CvQ31ypxv76Z7ar34vA0ObrjxR8nntURiTj0j/KodGX1Iajw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 12:12:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 12:12:24 +0000
Date: Wed, 23 Jul 2025 14:12:20 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 00/10] sched_ext: Sync with scx upstream
Message-ID: <aIDRpN7OZsz-uMju@gpd4>
References: <20250723120746.52847-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723120746.52847-1-yphbchou0911@gmail.com>
X-ClientProxiedBy: ZR2P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 0804dfc4-9071-430d-813d-08ddc9e22f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8eOS+whD/5ec3yfIXj98av5rSm3NY0ysTtOQ67mziJzmsgiQiqznjYkdyqpU?=
 =?us-ascii?Q?cTWz8kUnNjK0Ksq8HncDYo7E53P9Z6qan/i5YSdKIgXQTiPgllu3v0n64MuB?=
 =?us-ascii?Q?pVpoSm2mIafkxYMprqfBlhjCCb0wnL1t5k8y6PD15Nn6bD3mXKtr7mVkAW+F?=
 =?us-ascii?Q?pfj7c7npH50O5IpXCf6FmmCjL8pz/iVhNAIICjj1rL7sxWgqSmvSiDleJ8LN?=
 =?us-ascii?Q?8CLZ0U9WXHYeAPO9aWfvphsFh0nbHvSKcYZUKfnoSgC0enciaCKvjrWFPAu+?=
 =?us-ascii?Q?lVuQcHno0DPeLAveRX0I7KWPlx6xvSZ2FS8JGvmhvmq8nXUF2Mvy2WpKK6lf?=
 =?us-ascii?Q?oXRb0zSdMhaagRpCR+Ernkif4ZexqnJ/kTtnqpGzi4RdyhLrf6j8SFJI6GDJ?=
 =?us-ascii?Q?3Al+3KV+N5reUnoJ1LBg0a7NqyS0/GXhUghFoQBg+GG9MsL8R0vC7pWotb2T?=
 =?us-ascii?Q?piLc4u1RGBwMczI6qlzkEmkjYgSPJamM7O1B5dlRblHvMcEe1HESUCDIfCrL?=
 =?us-ascii?Q?n2cdoWIFZyZeo/MgiFKIbcu+6YscVPqqkBnTyPQZbzTAdXeINtMJ0qC2O4y5?=
 =?us-ascii?Q?jhFfblr4KoxdGCFRHFxTwDXuTjqQFPKEUaCz/mupwQO1OvjWfoiCyXDsquab?=
 =?us-ascii?Q?cZ9lcDZCU+Zc6DxbUIYOwgfxNaspTR4d/bWXepb6h4wHAAHB3lTmyW0qJH63?=
 =?us-ascii?Q?xSYgRqL06sHml8WwyhGOfQc9kVo06kjh95p9QOc4bYB7dKPcTeLzMvIe7wSe?=
 =?us-ascii?Q?ZGZxwlUCxyjEgsyr4d17U5NbwIuqsKgae1JSKrBtNIqPC11PUn2K2IAc2fKj?=
 =?us-ascii?Q?mpzS7cDMaCuEpljpJon07zyx//v7pcAmOI/7E8nblTsTpOal/EPUFMOqVAJi?=
 =?us-ascii?Q?nWx5dz+NHdyBnpurmMDAAOpMkIqwciQPmoR5kWIkuL4YiKI80dUBeB9xNaO/?=
 =?us-ascii?Q?hVd3nQ/bhzZcZOrT/lq3iBeITKuzELTlEWxwQ6L2gtSSd1aZnAeHmbDKvNOz?=
 =?us-ascii?Q?//1E29d8n55+7qQfdvr0bdjciotZ8w3lHh8k2Gm6GTXLPU7NDxHXG/YCn+MT?=
 =?us-ascii?Q?JBSUGuYc2J5KTpatA/lnx6K2ggPkIHo2MLWsmws4mCNc6XC73TCgGInGO7CI?=
 =?us-ascii?Q?V3DF+6Nd19TcpOHZ5Mhu6lJpHwdNoYEaMy+c16JNLmpUyhXh62H5xR4QzfE+?=
 =?us-ascii?Q?8emF2WeXIqqBJFgewd60La95CJk9fn4BNeXNZoJY96hQS1fC8wqo3AWK0tWy?=
 =?us-ascii?Q?V3KICz6/ybAIeyORkMriFhnSMoPpzlNDhYrNrBFVIhNKWOYKUTXTS6rTgBf7?=
 =?us-ascii?Q?RMkDlquLqjDMGLifznpSPs+ZS83KiQjjqUhJq7QvUCwfUg8xd3IfBPAN25fq?=
 =?us-ascii?Q?qd9CDxSlvknvzaJyQHqOjDcg37iLogRMwGZtCzjDzu4N2SJjkbGN2HCLMILJ?=
 =?us-ascii?Q?YGeQ7AxZMUs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nGK+3/ukjQERg5bBhX+W8dMcFt0810Un0yMPWvSUoDMORdgnxS+n202CCWvG?=
 =?us-ascii?Q?LGnZrWRhAlXV+gFqbEz3da5eBnJj4//ceZJgX4HPtfMraT9SxasfsvUL55+W?=
 =?us-ascii?Q?WLN43f2eaONCJNA7yp/3jTRylU5+ENedTF8O8Jl8ul4vTKR2jjfrKhDJ4vXh?=
 =?us-ascii?Q?VOLYvGc7eAB5CegundQRmYK1emqAgUCXKLQ2B6HYE8Ij/pT5IO0cqOtPE6eN?=
 =?us-ascii?Q?VrkhOZudcTkfb9CKqJ+Uk34AOdQJ7dT4CkPRqHcdixgnv5hHOjoBXtJGnJCi?=
 =?us-ascii?Q?rEdhqp+3BQ0/nV0FINO6bmZtycpEuspvavCoFbua+uPxZpYW+jRcecZ0zROc?=
 =?us-ascii?Q?4q4gZsJyixJ/3GqCa8JdMxJFyQBuv+/cAF9QSIBHKfPgIJSuyslQmzhhgcqh?=
 =?us-ascii?Q?6AL1zCJTdXlNz+fNqM9flILUHCgGAuOE/hYQ+s+mmJ4CQqva8yGTHSXorqga?=
 =?us-ascii?Q?YgbrGhyBD+PL1DG9+kwz24V4RJVSP9olOBQAMj7/6zejNgQLPyvZeWQwZo4G?=
 =?us-ascii?Q?PEEwWABxrAltSDvR6zS5GQxnD4MCj5vEorAce2jN0f6SiklQPgPkjIXmTYfC?=
 =?us-ascii?Q?wHequHhjIJJPDZimwyFC2X+0h28jDOE1PIkTxmsCzubtJOOJXAksepg6y5EL?=
 =?us-ascii?Q?lZRXRWQOHUUragVlYRluDCTCeJFHgb4Pd3WAaDwUqX26YASd9V82lbQNp6zn?=
 =?us-ascii?Q?pZ5uQjBRdE3yNDWkKF5VUPZCF2zhDHAQldRHJ+ogeMU59lNpLi3dlQu19z/j?=
 =?us-ascii?Q?jfOapXhPsDSyEom7EbsRcdNSJCEgfE0hjrsuFLV1PzRot1t94dVTp3ofLsbV?=
 =?us-ascii?Q?RUsveFON+oe9d/OBdqMLWBknHlkFWBEad9sJr7m0DXja/4p+98fRE8hIQJj+?=
 =?us-ascii?Q?vaNAd8bMMyOTSmI9B44GpJ/1TsYSHhoFiP7xvYGVHXRlvK2XuttgziNnXIrS?=
 =?us-ascii?Q?8UXIf/SbXNAyLkjlt/9DdM0i4guJb7q6DaRh2BIc6+p29atgdQAE+nbQhJ3g?=
 =?us-ascii?Q?8nzL0nLnFJmcO9/E/2KuLCYAuW7ke/t9mI8JRxwfhvKsX/NCIK3r2Ne61XcE?=
 =?us-ascii?Q?iqXpn/5HpYiIX5ql1jA9WMjGSdcsFMaqCJQZg6VW7idq9LYbNEke6+c0BRWQ?=
 =?us-ascii?Q?lAVIz5GRix6427TyvjxrT8Y+NTQTzUz4W1A9UebaeB7Jvcuz90kWsVTwpCIN?=
 =?us-ascii?Q?Oe4HgAan+iQqVxrqdS6XinkODRgX62IQOsc2zYerNCGrpMoiij+ke+tXlNrb?=
 =?us-ascii?Q?p1F3XuQqdjBJy5XxPhHTeeuEhit5Bh+3xYHnV5tDXlSW2C/yxPTlGQ3eR2el?=
 =?us-ascii?Q?t4MMj7N+D0Tx8YXiSkfqruW8pDoXJY5C7xxOhrOWXtI+ifr0vwuul5of2OBR?=
 =?us-ascii?Q?JsCoFbEbWlSBjj8JgBauWibyZeQfsVID17wB/6aD4Mm8cG1sbvBOMc+tjzAk?=
 =?us-ascii?Q?9fm28m5EIzoDocFi2Fm+JJcF+opuErcSiorD9B4FYQsSeVOT3qayvE76L01x?=
 =?us-ascii?Q?NW2yawFo6O4jnWxK+KDBC/Q8iJezb5G4pp85A4Kp6g0TOXnrHbK1S/O64qza?=
 =?us-ascii?Q?CJMy6LlxuDf71LVUsuKOuf1w7wdFcJQVU33Jzrhw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0804dfc4-9071-430d-813d-08ddc9e22f01
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 12:12:24.6311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz6WJFqQYCQNVY10GDS06o2ygXKPLDZB/s1S55Dkg5ggcpdb3vQXDIqLP2mPfTNXcV7giSKdy5fy3fkd1K9JqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350

On Wed, Jul 23, 2025 at 08:07:36PM +0800, Cheng-Yang Chou wrote:
> This series syncs 10 sched_ext source/header files with the latest scx
> upstream via:
> 
> 	./sync-to-kernel.sh /path/to/kernel/tree
> 
> The updates ensure alignment with upstream development. Build tested
> with `make -j`.
> 
> Thanks.
> 
> -chengyang

I don't think splitting the patch set into multiple per-file patches is
very helpful for review. Since this is a single logical change, I think
it's better to include all the changes in a single patch.

Thanks,
-Andrea

> 
> ---
> 
> Cheng-Yang Chou (10):
>   sched_ext: Sync with scx upstream in tools/sched_ext/scx_central.bpf.c
>   sched_ext: Sync with scx upstream in tools/sched_ext/scx_central.c
>   sched_ext: Sync with scx upstream in tools/sched_ext/scx_flatcg.bpf.c
>   sched_ext: Sync with scx upstream in tools/sched_ext/scx_flatcg.c
>   sched_ext: Sync with scx upstream in tools/sched_ext/scx_qmap.bpf.c
>   sched_ext: Sync with scx upstream in tools/sched_ext/scx_simple.c
>   sched_ext: Sync with scx upstream in
>     tools/sched_ext/include/scx/common.bpf.h
>   sched_ext: Sync with scx upstream in
>     tools/sched_ext/include/scx/common.h
>   sched_ext: Sync with scx upstream in
>     tools/sched_ext/include/scx/compat.bpf.h
>   sched_ext: Sync with scx upstream in
>     tools/sched_ext/include/scx/user_exit_info.h
> 
>  tools/sched_ext/include/scx/common.bpf.h     | 102 +++++++++++++++++--
>  tools/sched_ext/include/scx/common.h         |   5 +-
>  tools/sched_ext/include/scx/compat.bpf.h     |   5 +
>  tools/sched_ext/include/scx/user_exit_info.h |  49 +--------
>  tools/sched_ext/scx_central.bpf.c            |   2 +-
>  tools/sched_ext/scx_central.c                |   1 +
>  tools/sched_ext/scx_flatcg.bpf.c             |   2 +-
>  tools/sched_ext/scx_flatcg.c                 |   2 +
>  tools/sched_ext/scx_qmap.bpf.c               |  23 -----
>  tools/sched_ext/scx_simple.c                 |   2 +
>  10 files changed, 110 insertions(+), 83 deletions(-)
> 
> -- 
> 2.48.1
> 
