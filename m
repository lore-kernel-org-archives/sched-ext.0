Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9641CFBA
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762758231; cv=fail; b=B9S1qZNs1E62Trevs0YCBWhyLkELJAgt207K27YRqzPJpQ86vxO020JrAmn06zNxqPIVQhWPT5eF3cr03DHFpIgiGH9qIGajxbk6Ew4pTc8wJ7Dih117nM/41lPeQFZwfrzgxGu4NdwVkv2gTUu0nOn1UiqGXi0A5F32YwB1h6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762758231; c=relaxed/simple;
	bh=EuYVba/EpT4XTA0ozf75L19M0poD+9G9lNaKlBdTLNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LSgR5MjB7fVWzgBPIFsM6iZV9LdACUjIAabI+8LZD7cSMwrhh2YhbmnbazacKOGPwrTVD6e1eYicPifgfoc3r5mUUvOsSmiCGAQB0OMbpiT/OWF7j/3aBMUNds+xZTX+DUDYzcjyUua7tUxJq5u694Ve64bSsa/bPgZyAz69j1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PdWF2PW/; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PdWF2PW/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVZKmpnyqGUDldsQe4lc6xJ1/yzY3GpGW+cbcrAB2pXe1MTrSDTtfSLqu/B5T2bWXIC57iRyMO/5nTnd6zheg6KcbAnqsSFeD7LMeU9lbWwqkm/ia694k62VZcVnszZm/eNgAidAifeohrLMUNBTrSMLMtLxlKDU4PSjrpzrgHpguYadf/NS4Gep0URohrodObXetWf8ITlAwYK21Wtv7YtlH0W+Mn1B3oO8xHwvIQQdX38coOHUNkrsQfTGDulRAZXpWnDcNt74Z1rNs5zzdp8qI5v+MmXIuBQhE+snWAWq3y+KSKuLY/5dzKBzku5tJskRMt8be9luoi+r3FQP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mO+BJVB8uKGp0qhvBqlux12uy3iicLz9Zie41Ojn8U=;
 b=MwxqQ4Jj9oEjupet+wVPg7JZGenZZ1R7lNyICAA1wF2k2Fcsma2thI7zDvJS2HPYRlwbvEGfmL3tmifWV/Cp7aL3SXBGuVlS3+E6u+jlF/igFX8oZluldzzGEpyOBePA42/3gR5/qIL21rYeLuRVSC4IBZQFXT5l6ht/GRB7JLirhvbfY1JGk3r5KCInJ87wwxCWSKkZNRPJ0hJdHQMZy9S9PZG/n8oB7JTK9MYKPPxf4RWfT7kvFVPXvarVT3Q/FGz0Eda2PWhLyCXd2xbmLSgNxKTdsXvVxFnscx8o4y7RggzfEC9FifCdepTjTlnnFEqChcrce+P9XOhGfGFbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mO+BJVB8uKGp0qhvBqlux12uy3iicLz9Zie41Ojn8U=;
 b=PdWF2PW/zONN5C9B5HGhiDEzkFtLKEPJTJhclzpL7v6431SC0/vuiLfhvHKS4iM/G/z5L+bfoNNOkJdAyKJrfgj4hyEs5yALa/aiIQTzWMx8+dQn7qI7Ax2Io1iiYFPgmVngxgFKfDHxKzudHhcyW80MWs2tascseDrQbE9LuJJg+2ln/NSpkx6KbG5Ipeazlr1j/vG/qmcNOVtNRphGR/BBnICgUMuYMDDqxrATms6vydkZihZriAR2DsXMWiQEtarJoHFx9oNsxBDvSPjFx6/zT6tQSFH3WqXAQ0MDnkEnneQEL85615SpftHEd1f919WBvv2VnyEJnryjVSO3xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 07:03:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 07:03:45 +0000
Date: Mon, 10 Nov 2025 08:03:37 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] sched_ext: Make slice values tunable and use
 shorter slice in bypass mode
Message-ID: <aRGOSSN9PiCBCoWy@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-3-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0b434d-9bc3-4cb1-63a1-08de202749e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kd0mNuGXUGncvMPjn+pYV1Kv4I5JBJDDfBywVNk16DYzC8LvFS3nDiSTr+Kn?=
 =?us-ascii?Q?3KmGv32chD/wxXFSswkGMNWAhJLfgizH4vOQO96vievppfxDLbgsCeUkiTgG?=
 =?us-ascii?Q?TOdEmu3ApEDxudeLM49L+gVHyeAHx/yMWoxcNIvDFqUBtZAj6b5/FAWb4CTE?=
 =?us-ascii?Q?d95oDO+NTvIMRxnLxZh3Txbmh9WI6coqtncdGnuXnLs/1fbx225+hAjVary6?=
 =?us-ascii?Q?kMDzCbfw1Xcv+29df61v5ccKBtGfkiKxYqpBPfSauTRA9BQMFIk1sNbswdmI?=
 =?us-ascii?Q?YQZh/xgP3m02wz1lqHMpQzMhzJvgHydwFvWAVxMdE0tCvBmLpbc+4uF3bpG1?=
 =?us-ascii?Q?Z89ZFgDI9lbRCSvnjQT6DAypv2UothzTpje77uxmpdfrMdekFzz/w3w5wqT1?=
 =?us-ascii?Q?FwxsWyQ9LgU+bQ2wvVjUSSZYBESu+dvUZ7ge8zcCDA2gbJ9pGG7iWou5CwIc?=
 =?us-ascii?Q?r0KW3Kl+iEOutNTTrtM4jDHjtDuMhIl6mPq6CVrpgHSFwZC2qVRw0POudpLb?=
 =?us-ascii?Q?kpqhHQaZY1fqEmp6XZnJS/By3T9sOr5xDmKm+nbiDhmZYx3DPtwTZSkF6lNl?=
 =?us-ascii?Q?5s0TQS2vyUCTIrO39nBiLZQ+NueirMVASEP/Rmm6uKt/C6Mqc0SMrNMTYE0f?=
 =?us-ascii?Q?YBKvLizCZ/IIJOC6iZ3LeyduLP1qQ1wRsGrU/TW96Lbt7X8cf+sTdS/Jx8+e?=
 =?us-ascii?Q?zii1O3M7r7+Qaq1C4RujubNwMjXsEMd2jAc1qnN1ZglorDDAVQ3oP05oP/2f?=
 =?us-ascii?Q?v3t2OY+5lm1qd4FsNDjn2yLV8+7WIfW1IYPrrz+7wLlxWd5U8BDquMrCWeVC?=
 =?us-ascii?Q?Nk/KKqHWnww8AnFqpxPmrpZHzBoh7YQxSMsTDvpZe37b+nmeRihlxMYcEo21?=
 =?us-ascii?Q?DvEI3cndKH25NnDw6bajQq+VemKNZWeHCHPeCJ76TaWMXZDlkabf/RpNC66p?=
 =?us-ascii?Q?lUiJC+AVejjK46OQUp6sd0XMLO54E5HdFwQyjgSRNL1rm94wuI225BHGfy0k?=
 =?us-ascii?Q?RYrQliCcJE5vw+HWBczAK2StMTheQ5fbj+7A4YqgK9dxJWLUW6oKRh3rSgnJ?=
 =?us-ascii?Q?vZjKAJN8DRRr4oFOQQddBiT9HqpgWlQ2FN4figIrR2DFb9KExYK+x/+d1rEF?=
 =?us-ascii?Q?7DesSNhdh1o/G4EDVDwSDnOJGG29c3168JQAEOGdsCH6G7pS22iV5UJNgrEQ?=
 =?us-ascii?Q?yY4SSbLZUiUESo5HqXYAAQAp3KbgOFiDOqkSdGdQKny+6OkAyHwZdonDuZXB?=
 =?us-ascii?Q?EofLzWgbM+xsIIW1amf+0SeuJXGrtQS8tZiLbuOZwEjIvkdIlOxhbtMkmGdT?=
 =?us-ascii?Q?VWqUIC83FKbWy4l3spNPG1xeI4voh0ALLTVBkSQF8I5Lf9dd9NOlYWuxut1y?=
 =?us-ascii?Q?ieNmQMr540j0saUKWwZc9YB9vdIiz7/d29umTyMHJ1cQ7Hzt+nXUsBsmw01+?=
 =?us-ascii?Q?ULU+/aYe90aQka1EQQeihGayf0pFnvEh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b8m5gEjcHjHxym/aIuUKLsvH/P8SUTodXj3uXj3H/GZ5L/ph/TkhZnqU/qJj?=
 =?us-ascii?Q?wfvROlRFvEDvaxMYFHJTHPnCCjSeIkDsUxAO4HjBBk9QkPQKlykEL+W46yxI?=
 =?us-ascii?Q?X6+zTqaMATaTuiw8pGllcYcmJWuYQlDZJTX1ZcloofGQOh9zR+T2VrmBcWQc?=
 =?us-ascii?Q?bTNoZRNcNxDXuoCpqSSkH+HcpV+FfzQGFywHtruE5S1694cqsrNJIS/Z81g9?=
 =?us-ascii?Q?V4KrOR3qvEX0JGrGgjSsol3daqlRXWpcdmJitfgd/y9BkpVuIuVcMWkeQ4Q1?=
 =?us-ascii?Q?qPLMHRlSdANitUITsExILbEzUw2XB6y4dIUkqZH5plfXHrmyaZXPLtAIvt+l?=
 =?us-ascii?Q?JVzmkcAX3MudOCFSOqB45wKh9LLVMQ97Ydaxb3SwESp03Jl4oP3JKwkKvcYB?=
 =?us-ascii?Q?UZcw1tJu+ks2agefcNhVLAgP+UuhsQiGtm/0WZRX9X5D+G+enRNANO6GDcZg?=
 =?us-ascii?Q?WOtQRjVj/Yr0uieTEWsHILZf3AQljibA9tuCVs03u1YPwBx3MjYATGF/RebX?=
 =?us-ascii?Q?pR1AwbzlyxHuJbf6+f69N4HW9iVwBvESO9oeLhKSwBTtwpGrUsXksGbKxDV/?=
 =?us-ascii?Q?ZuIBAQ+yFXMh2efrdKtAl1k/iLJAmvoY+/63uAXbKEuFCJz8ABNEwFnT2CSZ?=
 =?us-ascii?Q?ZKINjnt1z+36stTcSvhcaFll7n1seKq0Kjx5oVTkQOmL5gCPwOoHb3DwmruN?=
 =?us-ascii?Q?nYa9aAx9jo50yrcQqikpVqXBDDI5O3coFS8tfvSOu9v2H1GFcL9y6nsJNX6r?=
 =?us-ascii?Q?OcedohL+SOma7iX89IxsKetxoGwOTxB8mnebCBNSxXp+4VdIPgWyyxTv6CPC?=
 =?us-ascii?Q?v6Aokl0/QX9suqWKwiMrPEayPMLEfdqNpiiFIr95tFbn6O0pUWQiY8z4a0U3?=
 =?us-ascii?Q?Blp5aw6RU4sTE5CCtR4rJXxsxQfygx6m/FMd/Eksy76FUJF7aKZ5bzku32Rm?=
 =?us-ascii?Q?T6OxUfEoDKT7mWLlzLmQVzxi+JRpgPcfA2QTrVNaqur40QMvvIQVLlOgEBr7?=
 =?us-ascii?Q?DhujbipFJwo15VP297snTguf0p0fqYHkyHnLCB+RtwEH1saRd1iKbJGGvHm4?=
 =?us-ascii?Q?ZXpognzrVvarhSXXkxKs/YBhpe8h5M/RLiSOtRTz+fIEMR2QHYLSLnMn9sqj?=
 =?us-ascii?Q?O7//ju0tzU/FZw3z+I+t/IiMBatyHXo9UKkpH7h+j4N6VpvC0A5PMZQSr0Aj?=
 =?us-ascii?Q?1maxzIug0c9xiW66NS8OmbPfryz6LnmQH1Boa5VkfKiyrQbKqwEEj7ct76q1?=
 =?us-ascii?Q?nL1sOXFNr5mgQPSZnSuB93Xdpn8xspU045J2JghIHRXe2cXwPqFyVvPiyAOn?=
 =?us-ascii?Q?3bdkyj6bm6I1BtdOzewK4AW4lp3nig1EDDxwdydR6qnJBfcLkeVaT5ILsqDY?=
 =?us-ascii?Q?zp3uNQMksmEzUqxoUPEe5cVJ74aHznLNq5ICKbwYUCbhGWKhqIWOMyvefhCS?=
 =?us-ascii?Q?Wcde7wueqndcXnNFiSyPNBTeMDSt6CvsugiQKVyuwt69AL++qCp6bsHXtXO0?=
 =?us-ascii?Q?bQbarvmEmfEK2B4p6nQUGiSUggxMlMZr21odl42Ggo/uH4/AJX2YF6ZDWi79?=
 =?us-ascii?Q?5TmIHLOC+0Yl+185LC6bUih+kV6wEKac+bTWK2cF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0b434d-9bc3-4cb1-63a1-08de202749e8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 07:03:45.1121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijzCWslCj5iJ2AUmPPfyGfYxltiJO+A0RSQiOpGEC5bx7PqIXtH9JCl4MDYZg7Ma3h74cKvdf/bflrc1Ns6hGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

Hi Tejun,

On Sun, Nov 09, 2025 at 08:31:01AM -1000, Tejun Heo wrote:
> There have been reported cases of bypass mode not making forward progress fast
> enough. The 20ms default slice is unnecessarily long for bypass mode where the
> primary goal is ensuring all tasks can make forward progress.
> 
> Introduce SCX_SLICE_BYPASS set to 5ms and make the scheduler automatically
> switch to it when entering bypass mode. Also make both the default and bypass
> slice values tunable through module parameters (slice_dfl_us and
> slice_bypass_us, adjustable between 100us and 100ms) to make it easier to test
> whether slice durations are a factor in problem cases. Note that the configured
> values are applied through bypass mode switching and thus are guaranteed to
> apply only during scheduler [un]load operations.

IIRC Changwoo suggested to introduce a tunable to change the default time
slice in the past.

I agree that slice_bypass_us can be a tunable in sysfs, but I think it'd be
nicer if the default time slice would be a property of sched_ext_ops, is
there any reason to not do that?

Thanks,
-Andrea

> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/sched/ext.h | 11 +++++++++++
>  kernel/sched/ext.c        | 37 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index eb776b094d36..9f5b0f2be310 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -17,7 +17,18 @@
>  enum scx_public_consts {
>  	SCX_OPS_NAME_LEN	= 128,
>  
> +	/*
> +	 * %SCX_SLICE_DFL is used to refill slices when the BPF scheduler misses
> +	 * to set the slice for a task that is selected for execution.
> +	 * %SCX_EV_REFILL_SLICE_DFL counts the number of times the default slice
> +	 * refill has been triggered.
> +	 *
> +	 * %SCX_SLICE_BYPASS is used as the slice for all tasks in the bypass
> +	 * mode. As mkaing forward progress for all tasks is the main goal of
> +	 * the bypass mode, a shorter slice is used.
> +	 */
>  	SCX_SLICE_DFL		= 20 * 1000000,	/* 20ms */
> +	SCX_SLICE_BYPASS	=  5 * 1000000, /*  5ms */
>  	SCX_SLICE_INF		= U64_MAX,	/* infinite, implies nohz */
>  };
>  
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index cf8d86a2585c..2ce226018dbe 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -143,6 +143,35 @@ static struct scx_dump_data scx_dump_data = {
>  /* /sys/kernel/sched_ext interface */
>  static struct kset *scx_kset;
>  
> +/*
> + * Parameter that can be adjusted through /sys/module/sched_ext/parameters.
> + * There usually is no reason to modify these as normal scheduler opertion
> + * shouldn't be affected by them. The knobs are primarily for debugging.
> + */
> +static u64 scx_slice_dfl = SCX_SLICE_DFL;
> +static unsigned int scx_slice_dfl_us = SCX_SLICE_DFL / NSEC_PER_USEC;
> +static unsigned int scx_slice_bypass_us = SCX_SLICE_BYPASS / NSEC_PER_USEC;
> +
> +static int set_slice_us(const char *val, const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, 100, 100 * USEC_PER_MSEC);
> +}
> +
> +static const struct kernel_param_ops slice_us_param_ops = {
> +	.set = set_slice_us,
> +	.get = param_get_uint,
> +};
> +
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX	"sched_ext."
> +
> +module_param_cb(slice_dfl_us, &slice_us_param_ops, &scx_slice_dfl_us, 0600);
> +MODULE_PARM_DESC(slice_dfl_us, "default slice in microseconds, applied on [un]load (100us to 100ms)");
> +module_param_cb(slice_bypass_us, &slice_us_param_ops, &scx_slice_bypass_us, 0600);
> +MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]load (100us to 100ms)");
> +
> +#undef MODULE_PARAM_PREFIX
> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/sched_ext.h>
>  
> @@ -919,7 +948,7 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
>  
>  static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
>  {
> -	p->scx.slice = SCX_SLICE_DFL;
> +	p->scx.slice = scx_slice_dfl;
>  	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
>  
> @@ -2892,7 +2921,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
>  	INIT_LIST_HEAD(&scx->runnable_node);
>  	scx->runnable_at = jiffies;
>  	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
> -	scx->slice = SCX_SLICE_DFL;
> +	scx->slice = scx_slice_dfl;
>  }
>  
>  void scx_pre_fork(struct task_struct *p)
> @@ -3770,6 +3799,7 @@ static void scx_bypass(bool bypass)
>  		WARN_ON_ONCE(scx_bypass_depth <= 0);
>  		if (scx_bypass_depth != 1)
>  			goto unlock;
> +		scx_slice_dfl = scx_slice_bypass_us * NSEC_PER_USEC;
>  		bypass_timestamp = ktime_get_ns();
>  		if (sch)
>  			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
> @@ -3778,6 +3808,7 @@ static void scx_bypass(bool bypass)
>  		WARN_ON_ONCE(scx_bypass_depth < 0);
>  		if (scx_bypass_depth != 0)
>  			goto unlock;
> +		scx_slice_dfl = scx_slice_dfl_us * NSEC_PER_USEC;
>  		if (sch)
>  			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
>  				      ktime_get_ns() - bypass_timestamp);
> @@ -4776,7 +4807,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  			queue_flags |= DEQUEUE_CLASS;
>  
>  		scoped_guard (sched_change, p, queue_flags) {
> -			p->scx.slice = SCX_SLICE_DFL;
> +			p->scx.slice = scx_slice_dfl;
>  			p->sched_class = new_class;
>  		}
>  	}
> -- 
> 2.51.1
> 
