Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792786384;
	b=akjNM10AdOAqY/r/TnafxyKmPErLJf5zzBfNe+uvPRimYMf/1SXgT+Ym7oZGEzgMowqs
	 O03+OAoMnScuWO55WvsrMNMMq8hIFEb+Fh7g8x5qMg2RQ6wACmNwiKS/oOl88gDffjcOS
	 k2WQFCr/X9AjIxapnjuvCkhudyzRC0krMDHmjrhc5/8kPm83xfX58vN/dwQstiNwXRPRH
	 V7eKr3Xb+ZwouZXXKdB+36Rw9ETBm3LaYEUblqiDUEkV0PahHj9yt0vjgeY0HskyNOnZe
	 gUBN9A1gNjPEO6wV2WmEwie2oC/oNJGgpvhO3z5/U4t7rNsIC3DVl79f2lLbNDeWTlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786384;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FZkC2vuSLkA95eKUD+KtgylSvq3h4TFqNNXAh9W8Qpg=;
	b=D4JIi/U88tNoORwhTA97/NnpEuM14zsN9G0kr1FcdHm5JXbntYqtlgP51EB2obzudU0i
	 QwsUBUoFNb5wSmx6ycqxSDI3hKr1PEccA53C00prCS7Oz4MJ4AozTKEl9WHKV3hwKF4k4
	 R9g2RN7QYGWIWXag2nXNkdmkhcTCbtX2lxchVbYC+CO2LNBLlRqr9trN4R/R5LBttCtgt
	 skEbAr16V8u5Tnn61bU8ruLuqKaNUz+ctFN5onH5b40bipVHbQHPAngPsojJFAPA5gyy2
	 HvscljxIGx4UpTQPshYECzcj06AE/+IJWL/XMkIWDPqwo0tABTqvdIF5ILM7hO3b8tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YtLLJVXs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.48
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68626606A31D
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 20:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68626606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YtLLJVXs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsq2X3vTes2oqvxPUtgxHygUNiQZf7N8vxs69dyTVQaiRjzmAB/l0F/Qaw63VJtPdvtYv71yqH9BrZus143iwTQ3sHgCUIy1WjEl9ktU4m1Yr/IBIp1++G/KKOp2fmYuN9yLuDhKLsjby2WIIq0R7Re1vaxLI+ln5QgOx8s6BVZ4X+0FfHDgy9YsH6WjAiDBoOK2sMgD48kONlJIOAgLsinEdY47iRMScMKqjfLcIFqv3vDKvSVlYsqQygUcN+M+PThabp5LyPMi6Rvnipc/2MUrN0xfeheJSICvevHekyqqBhxChpg78YegGhqrZ+yHJkwzkCpXUqZ3b5JK8FBk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZkC2vuSLkA95eKUD+KtgylSvq3h4TFqNNXAh9W8Qpg=;
 b=pdO7fdY9dLvb8hq5Letymx5zIbk5ICaAUqO2jt3CYi1ElcfLb1yBPuEvfBBub9n+fabzfy7qbvKuV6S5nMLhIKdZLkC+o3ViydKI7Sk7/ggBOfYL6502Z7wQ/TqXnEPsuX3WcVar0tzPbDYQ6vLRYjXQOYyDsfzap+dEpW5dCtkKzHYBDpNC/es15udFYmulc3cgtkUm9ZYceG3bhAr3qDObp63TOzRoZ8DYuzsLjT2SFl51+8UmIZ45aLNcmnw2SDeVnuyy9fKvLNbagEV1C+pKweKuhvAQ9gaAvUbG3XlrwL/h9nJF6EeufDb7f4B0MOznKc+7NBn3Pmpj7pTBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZkC2vuSLkA95eKUD+KtgylSvq3h4TFqNNXAh9W8Qpg=;
 b=YtLLJVXsXbifJ1y1Z8Mx6n5dG00mQugMafoX/YedCoWGJ3W5+oCkNFqqO8erJhqqxKZ01+7tY5K3RRIm2ICYl98d8sk2kXtqqRMIyC38/l5P3AxtPqhhkWn6m/64Qv5Dnkrz8PbjWSE1f6f6HWKvSHp/Q2CAqiJHdQ8DZoBQzX9yxZ06rCiXAcw3WopGY4ij/swi5WZPhtv0e+uK+rBpThsZzqoJ2EU0ZOynjAN/dIRCbbcHBqZ2uallcqxhhAIp8RRPz3qozqOBt1JwqDCGEpbJgotSUDNaULtNaemQcLJ/SpoZdSSrPoUOYXPVdL7EUBqwmTf6yPLgW7CVcuZylg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by AT6PR12MB925810.namprd12.prod.outlook.com (2603:10b6:170:111::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 20:12:59 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 20:12:58 +0000
Date: Fri, 23 Oct 2026 22:12:46 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/core: Preserve WF_RQ_SELECTED across queued
 wakeups
Message-ID: <atu_vjtcwe1BjCaf@gpd4>
References: <20261023144811.2230393-1-jpiecuch@google.com>
 <20261023144811.2230393-2-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023144811.2230393-2-jpiecuch@google.com>
X-ClientProxiedBy: ZR2P278CA0052.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::16) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|AT6PR12MB925810:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba55e75-3cbe-44b5-6a33-08df31420851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|56012099006|260925021911599003|260925021311599003|11063799006|260925022911599003|18002099003|22082099003|6133799003|10067099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Dil/uX0K6Ca8C9i3PAbNZw3YwNT2l6/J8xe+SXUMToe3/nO+cLetJ7od1VbNocbh2aHWSSbb3usQZzAQPhRVjs+b9cELxkxP1jbUGZlwQL3Zae+Dd9IlP39XMRLaxWIPMDQTNaVg4BEUoTo83dAGOlDhsWiS7uTJ//fDMIP7YG9C8RU2gbBtY0HtIVWoQBKbWSDNC52FxZ0ZucUXAP1cylFAIzFJIz0TdBU83L/q/N7DPdLoZkirbHQyhwG7xwoX6rQuWDPLEOyS83XGqL+AVkdpKIWj6jaBVN4AR5mjj1N7m7EbDCHVYr2XjA007bhaRLKRIfOgc1jBkN0aaOjk6SCeYPtaqd24T4JUTZ6/fkUSLgBEJiKmBZj+CFG99J9FHAFy2UCXzVHLO1TPnUcKy+tcDHZVHQqYH8MmYXvSWCOLJ/qP5JV1Z/FS6Pj/ykjHX/0aufPHjyE3oN5RS2KXd/91xBgQD4e9aBiVBL0bqbKiNHWN03AcxeFMgGu+noP4ioH5HXVfUv+Ic0jdNtoMoyUSfAjGDDGVSFTY+APicn9ilPudU1J4C9pINXhfnsg3fqdN+slfJ5Sau8ZQzeQIzqYs0Itx+Ocg7Wqb78g5U7TqaK0zUmVmiAr4OxkzZcmRfHYENdXuZZ+1VPWjENwS35/rVnzPNt/NMO+WACaL3Iw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(260925021911599003)(260925021311599003)(11063799006)(260925022911599003)(18002099003)(22082099003)(6133799003)(10067099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FGv4HBX1ORM1BYOJejv8NtS6R5UqR+KwWxkhF5itHljRIj5x+/atnxuLDCoz?=
 =?us-ascii?Q?pdtechVxicsfMXEEF4WyEC2DFGty1Px8qa0tNL5hw6W6CMahq0YI863fyB6P?=
 =?us-ascii?Q?URvzKXYn4vp/jQ5QElBGEzCdqqweyySv0ItxYEZ4+a8DIEQSwsid5nFBTHYR?=
 =?us-ascii?Q?SgfCuB6E0wz1hmRyZHZdYvpzCQJOZ38Ji29NMgmMPSQswwSeDiiO4Onqfzhx?=
 =?us-ascii?Q?Nzs5oazBK8QO/6rgiolffc4GKCz70jHVbVyIJ0xAvOAglAaxKaBhTV3Q+wTb?=
 =?us-ascii?Q?YcohzEQb1bggodWLvYBU0lsGRyykrBjx1+e/Ra8Hl5gynI/FMOErDAVmRtsq?=
 =?us-ascii?Q?7SBySR1UeDcoXnnUyffqOh68v00gKTU5M85Rn31Lod0reyXhlH2wbjeZRmnO?=
 =?us-ascii?Q?rZvMdjLCC+hGWSXcNwuNFWtSL63vu+OSbz1ZBMvgsdncfOlK/ta0yep5D0Rw?=
 =?us-ascii?Q?ZAF4jF89h+F+ASg7PWO9wgepMpExmqciKjd8Cy00xd1VrFrhXoXnbFBbDZXr?=
 =?us-ascii?Q?RokgpcCdYbkAdNrEZXwFV7Ba4dpnh/tcPXS3mdBrS2DQUfsjQC6r/oQdehNl?=
 =?us-ascii?Q?JxmD0lCIqaVVvciCLXO24Sa1hcYgV5UVJKlYtGoNV8W9lilkO2E0e13pUMBB?=
 =?us-ascii?Q?Cuj0yc03giSutxHi8RLhs35PMELmdEo4XcAPba2mGEC4+81JN88QP6wE2Lnq?=
 =?us-ascii?Q?M9gk7gQdku6W6kKFydaK9wqsk/DaYitMQCIdgTPAe9WjiFkGDwOqCRZOFPpG?=
 =?us-ascii?Q?2jSUv2OfqF691l3wOS3eLd9d7ZgPwGCykxIN7nUAGexxq+vqpEBSB97jc8xe?=
 =?us-ascii?Q?6r7bmF79jkbT8nz2NxizLArgpCV84mEHin2/bwNWViU9YT0acYowZdYO7a+m?=
 =?us-ascii?Q?38dysaytSNnBzYFxuXxSKE4T2BO+fouhF2w54Wd3w540pzcjQwL25oJ3//Q5?=
 =?us-ascii?Q?OBS8+wer2jSgDymiJwqLsItHvxGzbypwGlKa26+uYVNmmPhnCzxGqKko3c34?=
 =?us-ascii?Q?S5zPJkz63G/ydoF9pr10wxrdxUuuasg9q/IBG0anmLq2ZfPenwoYv6GIJrkE?=
 =?us-ascii?Q?nYhu0xw1rfm61XAbohVeplpaq7HlwgKz2ZGIqRzKqNPj9NtWo3TIIPCwpEFP?=
 =?us-ascii?Q?QBXfXn05pCAkuYS9Axg/3rwaVNcbfX6sJqjqND7IHyDK1rkkfrd0Rf5nkF+N?=
 =?us-ascii?Q?r6vPZ37gYyuMFoEnoGYa0Tp3Kdr5p5ja68PZYghIE6I+ctwp6DgkTZISXYGN?=
 =?us-ascii?Q?FsTyoGm8ZpowCyqDB4NK0fXpnLCZoJGQppfzuQJNDEDSVlpiL5G5Rebk6fyd?=
 =?us-ascii?Q?fgp1l+GWzRPxdKkuQKvef47uVl5a3yhkPI8paledGwHsvUdSYqUBHwX+YdlO?=
 =?us-ascii?Q?XvIFyIOVvFbRdt95XhRaF5tBz66x6njX3Bk+EeceapL1oDBGxbuEDlsY0Ilj?=
 =?us-ascii?Q?wvXejvj7gHqvAme6KwGg+jKlL5zvXdUQd8trrsdbGd/XTJne9s6mZ+8CdUCO?=
 =?us-ascii?Q?pd7zazfArXUDUc8tim+dK9nHooKiYdMgGZHD1aGm8nGsQzOrovDETPJqUEA+?=
 =?us-ascii?Q?uP1qkZT9/09xIVZHUHLHKYkx9lo8qv+l/aKUYMF+tWTvD4pX/Lz2HN3C3N+Q?=
 =?us-ascii?Q?soJHtHqdcXhumdskdisiLHmnnTWb/FxRf4vKTO+auUra/ydg4mhAvxSW+Za/?=
 =?us-ascii?Q?63pXoOKBUc80/SG0vP2zb8a5x24dseFTm2o2mPwYGpZinCiv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba55e75-3cbe-44b5-6a33-08df31420851
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:12:58.8285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDAsTqNPDqefRMOXRIJIfcuU0CYIUggG1+i3ZLezkg5q+BKgP1SZPWLh5DFb7DJMqe5IgYpgj5fXnIk0PEMMcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB925810

Hi Kuba,

On Fri, Oct 23, 2026 at 02:48:04PM +0000, Kuba Piecuch wrote:
> ENQUEUE_RQ_SELECTED tells a sched_class that ->select_task_rq() was
> called for a task wakeup. sched_ext exposes this flag to BPF schedulers
> as SCX_ENQ_CPU_SELECTED. However, the flag is lost for queued wakeups,
> which a BPF scheduler can opt into with SCX_OPS_ALLOW_QUEUED_WAKEUP.
> This also results in undercounting SCX_EV_SELECT_CPU_FALLBACK events.
> 
> Preserve WF_RQ_SELECTED for queued wakeups in the same way WF_MIGRATED
> is. This way, ttwu_activate() receives WF_RQ_SELECTED for queued wakeups
> and passes ENQUEUE_RQ_SELECTED to activate_task().
> 
> Fixes: 3539c6411a7c ("sched_ext: Implement SCX_OPS_ALLOW_QUEUED_WAKEUP")
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

Thanks for catching this, it makes sense to me.

In the description we could clarify that we're fixing the queued wakeups
from try_to_wake_up() after ->select_task_rq() has been called.

Maybe something along these lines:
---
When a BPF scheduler sets SCX_OPS_ALLOW_QUEUED_WAKEUP, a wakeup can be
delivered through the ttwu wakelist in two ways:

 1) from the p->on_cpu path, before ->select_task_rq() is called. In this
    case WF_RQ_SELECTED is not set and SCX_ENQ_CPU_SELECTED is correctly
    clear;

 2) from ttwu_queue(), after ->select_task_rq() has been called. In this
    case WF_RQ_SELECTED is set in wake_flags, but sched_ttwu_pending()
    only carries WF_MIGRATED across the wakelist, so the flag is dropped
    and ops.enqueue() is wrongly told that ops.select_cpu() was skipped.
    This also results in undercounting SCX_EV_SELECT_CPU_FALLBACK events.

Fix case 2 by preserving WF_RQ_SELECTED across the wakelist in the same
way WF_MIGRATED is, so that ttwu_do_activate() passes
ENQUEUE_RQ_SELECTED to activate_task(). Case 1 is unaffected.
---

Also nit: s/ttwu_activate()/ttwu_do_activate()/.

With that:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  include/linux/sched.h |  6 ++++--
>  kernel/sched/core.c   | 10 +++++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 12a7e094a3e6..9dabffea1c54 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1006,7 +1006,7 @@ struct task_struct {
>  	/* Unserialized, strictly 'current' */
>  
>  	/*
> -	 * This field must not be in the scheduler word above due to wakelist
> +	 * These fields must not be in the scheduler word above due to wakelist
>  	 * queueing no longer being serialized by p->on_cpu. However:
>  	 *
>  	 * p->XXX = X;			ttwu()
> @@ -1016,9 +1016,11 @@ struct task_struct {
>  	 *     p->on_rq = 0;			p->sched_remote_wakeup = Y;
>  	 *
>  	 * guarantees all stores of 'current' are visible before
> -	 * ->sched_remote_wakeup gets used, so it can be in this word.
> +	 * ->sched_remote_wakeup and ->sched_rq_selected get used, so they can
> +	 * be in this word.
>  	 */
>  	unsigned			sched_remote_wakeup:1;
> +	unsigned			sched_rq_selected:1;
>  #ifdef CONFIG_RT_MUTEXES
>  	unsigned			sched_rt_mutex:1;
>  #endif
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0ab15f03cb94..d8495735166d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3975,13 +3975,20 @@ void sched_ttwu_pending(void *arg)
>  	update_rq_clock(rq);
>  
>  	llist_for_each_entry_safe(p, t, llist, wake_entry.llist) {
> +		int wake_flags = 0;
> +
>  		if (WARN_ON_ONCE(p->on_cpu))
>  			smp_cond_load_acquire(&p->on_cpu, !VAL);
>  
>  		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
>  			set_task_cpu(p, cpu_of(rq));
>  
> -		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
> +		if (p->sched_remote_wakeup)
> +			wake_flags |= WF_MIGRATED;
> +		if (p->sched_rq_selected)
> +			wake_flags |= WF_RQ_SELECTED;
> +
> +		ttwu_do_activate(rq, p, wake_flags, &rf);
>  	}
>  
>  	/*
> @@ -4025,6 +4032,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
>  	struct rq *rq = cpu_rq(cpu);
>  
>  	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
> +	p->sched_rq_selected = !!(wake_flags & WF_RQ_SELECTED);
>  
>  	WRITE_ONCE(rq->ttwu_pending, 1);
>  #ifdef CONFIG_SMP
> -- 
> 2.56.0.257.gf7497c7d27-goog
> 
