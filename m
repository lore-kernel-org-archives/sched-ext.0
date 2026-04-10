Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143F33DC4D3
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840157; cv=fail; b=IU9mOeth5D0d9XShhsK+R98fhf4RvqUWjBA5LT+/Og0mlYQpfaAXeGY1fcGHnUNxm2uVfdf3qZCF1mQhUNYeM3WwU6vxRDlCjHkIMfyLRsHTN+tygJ/18dyweIfp5tRGs2rPNhpTzn99xp96aw6jN3YjqqOU71Vptjw5nWUobUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840157; c=relaxed/simple;
	bh=IPTbEtKvKAlup7sqWD2DYC+UaTA7bTyT60E6Qb2qw9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=szTQ8l1xXzk+Mgio2dqczKMmY7rNxxjvNPyWD6pW/+C7iYsVOU0cntcCib+Zs+EiXYZ/cuXxNyt2JGTISquVgTUPA3rSEIsntHAm3wJWpOHylcCCokEmxwztDLt+oZ8BF/rnTK87kZam38SPXkuGNRt/oQX0erPBjNUh8+eaEWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lUCEnnkb; arc=fail smtp.client-ip=52.101.53.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lUCEnnkb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hh24vHlLX6Ga4Yv8RgWDUiQtZxC8xoMCfW+ocxRtr6POJd4p+/g1bhLg2gcBErYXswzB7lMSwbuhb/vjHs1MNpDEvebQfa5YL6e0u3TfDuZVVSjHAUsa93JFpVVOsKPlENx7FVmhhwIFaxYsGbyttX1cRQuXu2yd/g0QIFq7lyU5iwGI7fqYeNn1jLl7aiZeReYD3gZxv4dZMR37rpGFI2uiQEsKtLP9aGcGcIiiFdn9mcI1g7RoRXZqavHH34sX/DRPXVqUPgNBd6vHKK392FLLIs63KwhQQXMRm6p8lcudd8tdywK0mzMNwByUIIoD+1YvhKJMLewpUMg16+3CUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToaVzlmSG9BrMAvhwtZAQ5rX0m09oHnm9WAScyU/I5c=;
 b=HZsqAOmN4NzPb7RttupKd2o6+vnpXguLnPgl7rs1K9mEmbuUlKvRT3bzWeNsEWMPwUpx4MVhf5NOM/ttPa9peYn7jFhoqlGcy7DvPRQrX76+CyGt1+8V6Dh9uLJUOdlD6jClgssfVWf//YLsPVBLX8IDTVQ/71P968mNdbwzWU3Vg570VDwiomu79G7fqk4ppdmh9KoRHmFbGW6Zj9DscLFV4ETuiVFNRAEN2YTR4B80zt27zpDkoGhCaxaKwoyFjp9ofKlDVJVONu0c5r4xpcQr/h5N35AiutMRKetKOSjlpmYELkb1laiWpp6l5T5AfWQhUITP1lcySqLwxi1fCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToaVzlmSG9BrMAvhwtZAQ5rX0m09oHnm9WAScyU/I5c=;
 b=lUCEnnkbLkCh4LIwQoOdrh8uxhQkc/fisPNyR2GX3wstdYpHcJiwwx7eIczw0cQR4HOBSsvX0pcVQC/S2mWCpbR7P0Tc7WhaVPLHCfyI5H7JNvwpLiVH0/N33HODKPSUIIGaJJrEg+uXrPAwTmff60kY1qlVxpnLF1wtLeEbOLaUMMn1xFxp4OsgrEe16vuS6Xpk17RNWf4FBjhu7LiRgFEsLWDB/JG9P0f3S+kuu0d1/Vwz/uZNquyc8oZkHD0gWKKmPweT/D40LXuhbfzkCd63Qt/+SJxFg95elLn9CB9Odos4VRTa96qsMhbu1/igXWhTYxRBAS8LruOMFVF1Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 16:55:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 16:55:47 +0000
Date: Fri, 10 Apr 2026 18:55:40 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] sched_ext: Rename scx_kf_allowed_on_arg_tasks() to
 scx_kf_arg_task_ok()
Message-ID: <adkrjEscC3GEWo4P@gpd4>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-10-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410063046.3556100-10-tj@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B82.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::415) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 55882da5-a473-4885-82d3-08de9722036e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kSHm/WY9eo36Ohnw9iF1r4XIIBY+K65dFU/jYQv083dGfAyuKaBI2k5XMxMNzrokGAPLYVtaDyxtMiwwXrQwB1F1qBe91fFLp6YWdrrTnBgQdKozOC1G9mOmIyYuYV/HnqayTc91Epz0fArbcOacBclEZkQBmbKz7zY9zc6oNjEaieNLC/FmLumANXiV8uhGDW7laSjO0hIP5uoJehdzf9DEE7oLIN4aTqHLR3bKRe3OT8luf+X3cXQE8VNkELbwfaoGOCKVR4sPPC9Pcuhfe0biTpI3dpISPvsnLRyE1QfO1tG6EM0pV9LmHjMNpNhpxXtf5klu0vwaZpwGYCIWt1BoKg02uNL3qpS8sdswQz/23awNu2ZmwMlntW+ZSQX/2qaxzKw0VseHSqFEW6rMMPCHC30vwKBG5PA+9Dnh/xufDVLpOwvdjQRXZK4oviIjZd4WO9kjOKHu8sMxUYuUBqX0YQ+jV84WF8TAawlpkVG548yIgBaX3W3Uzcaxa/OlJGQdV7uaYIzglWBZZwm0wctIAjE5qa3NV2OBOZyO4ZP0bkjo11mVlQUPs5PX20m1x9fA0ih6AqxAUmrLgDvnMzHQEBLXathJ4GoTyVCpfr0kZdHuENVUF8AWD/7jhLajm2qCZvPC1HTqBLHkRQeL7G0g0AikkicloQwmaaHqHkSexF4AChsrP+uCeQmpzhdw1SUcQkJv3jFktK9I31ED+X02toLNidyUoRC2467SHXw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ADIyr3tyuo2wE9xwRdpfA7uScXDOPE7ZquF8H5R5b8UNYWp+7vO7hFyrldeK?=
 =?us-ascii?Q?TwFUs9g3dcMaCXM/UUd9186ppwxOf4Ye3nkM7We0VzT+g2Ip15t1LdUdurIf?=
 =?us-ascii?Q?tVhXip9tlMPCH2QQAsvyOfTBWBmxM9m/319QuusrFIhH7c0arIt3pwxIYOhU?=
 =?us-ascii?Q?a30C5BoiZNqSnmzwdxsVUQ5YNot1CF0ax3phqmIqG+RXZgchylpqW+4xvZIL?=
 =?us-ascii?Q?iy7LXBpKHzRQPe4vzyOhpl3MvdXTFSsjxsNUHV69OFz/jKLnDOC0JFCGPEtI?=
 =?us-ascii?Q?uwYwhCtyF9jL5KCt1+EiDg3eygPza7sbQLBzr8GudugP+FhZ8q531DCX47hr?=
 =?us-ascii?Q?NaNrlftJFNvf9TomeWJS1l+djFy6OEZYqOMlI27NOJckH4GTRD8oDs0IA//o?=
 =?us-ascii?Q?vZJmA/TyRAYFSvyHK1Ry3tSzT/YtIi+on+PqADG4uzzwcJ7+jJRv5G8ioLrk?=
 =?us-ascii?Q?ZYOesSuPYK+0a2i6N4IDnFp1W+hbn70vBLi5TMgIhEav/1qYLVpxeyIjoHbU?=
 =?us-ascii?Q?Bp8XxK6nidZSdaBddFyFrsXuzUFw/CT6QobjsfZtu1xH3cC3MsFHvZFyQEBb?=
 =?us-ascii?Q?HzZF/nC9ZxujTphcY+LsKeuHUx1jF6G0Fw+feUgfopCHLuRL6p1b8Tx5Jm65?=
 =?us-ascii?Q?SBD13eRmqg2ALyDcP1ro3BYppkveBJoGeH4m2/Ra3bVseLuBYrPLqXuertXK?=
 =?us-ascii?Q?agNo4jDI4qK154K7M6qmg1wqlhX5B49RSNEHnL9V4IhLpxqoYoksTbh44qXg?=
 =?us-ascii?Q?j9Mf0uKw4x1p3zA4BtxPMQOQC7Z8ed39Iif8263qDlWT2zDl0xXCgo/NsHzn?=
 =?us-ascii?Q?TxK1Qql4FUYjuAV6dQQmtmuOPkPvl+LAk9SNCg7rVLJCfHbX7Ezpysox9xrB?=
 =?us-ascii?Q?rR/Ix+IhXZuF+BELJuOeKylaMigfXp2VirTn+e3PJ86O7z+XhDRkxE+pwoIO?=
 =?us-ascii?Q?Njbve34dPpPGgpmkvhx2ov92rHV3Suhk92KrpOEriqAOd1nGuxoLxsQaJWE4?=
 =?us-ascii?Q?05JuKKT3Yzhs9V8xjIq83eLfnAmGX5i3EIF4n4Ob4EOsr3WB2hcLKxt3+reA?=
 =?us-ascii?Q?h3k19oKvwffqCtS7YjXIPin1GMWTBZMog8mPVdRbsda6ih5cD1JvjvsSL8cl?=
 =?us-ascii?Q?TV0pb9GQz0ZFft6w8RVsQjSVQguu1AwDKWU5bV+/yyHyZbI2AX+/39LGyA5E?=
 =?us-ascii?Q?G/r4QfnRpzNVheFHWLFLDjkT52jqAZ60ydq4neyJU7a9Ba8+TwKAjVLAE+Jc?=
 =?us-ascii?Q?tVIlyZ0W2QCRhgc6VH1jT7kJLdpHcHByWzBd0KwTfsJgKBYFIphctkQmRfDy?=
 =?us-ascii?Q?FYjK+gzY32hWltu5YVxXxLALBUmmTD0Va1tnU/Os0TJeoAIqAF4b+c7DNheX?=
 =?us-ascii?Q?OdPjSbNBK3whCpiE+UZylaob28adIcKm4QsLXE855sEPb+CvC7E9iXQcoJGL?=
 =?us-ascii?Q?P3kMWpTcPGWE6J3HZnc0bsPE25DNLvakiXAmptcNq3vX23/iSlzEWLYrzq/e?=
 =?us-ascii?Q?t6MFvDRi1EjJKP3R9QdMBKya0BXTkBEAwQEDF3gcDN94pRBOgZo941ZqCoG4?=
 =?us-ascii?Q?QLDU6PVDi+gyC+O1tk1ea2FYcG2+MVh6IVDw2x+b/I9yFiTw85ms6Q1X19Wj?=
 =?us-ascii?Q?saNIDNKiJSeg5/h/l/oTQkx/cphYtitinzote8AjCmCF2thBb5FYz1ATswFM?=
 =?us-ascii?Q?UanUAvNhzoCaI3hl0aH/al/1oyBsXI9ARxvNvjOZn15RKJ6dHvx4AWzwksOt?=
 =?us-ascii?Q?b6ME48i/zA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55882da5-a473-4885-82d3-08de9722036e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:55:47.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+Xbd/rt8Z16/iXEw6pmTV2iqA7wjeW4QsNGx4ombetVhJNgWk7llqRuYOnvtYjT5+mX/s5kRfZGzntoVIoQbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868

On Thu, Apr 09, 2026 at 08:30:45PM -1000, Tejun Heo wrote:
> The "kf_allowed" framing on this helper comes from the old runtime
> scx_kf_allowed() gate, which has been removed. Rename it to describe what it
> actually does in the new model.
> 
> Pure rename, no functional change.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 70e9434a9a0d..27091ae075a3 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -494,7 +494,7 @@ do {										\
>   * SCX_CALL_OP_TASK*() invokes an SCX op that takes one or two task arguments
>   * and records them in current->scx.kf_tasks[] for the duration of the call. A
>   * kfunc invoked from inside such an op can then use
> - * scx_kf_allowed_on_arg_tasks() to verify that its task argument is one of
> + * scx_kf_arg_task_ok() to verify that its task argument is one of
>   * those subject tasks.
>   *
>   * Every SCX_CALL_OP_TASK*() call site invokes its op with @p's rq lock held -
> @@ -532,7 +532,7 @@ do {										\
>  })
>  
>  /* see SCX_CALL_OP_TASK() */
> -static __always_inline bool scx_kf_allowed_on_arg_tasks(struct scx_sched *sch,
> +static __always_inline bool scx_kf_arg_task_ok(struct scx_sched *sch,
>  							struct task_struct *p)
>  {
>  	if (unlikely((p != current->scx.kf_tasks[0] &&
> @@ -9424,7 +9424,7 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
>  	if (unlikely(!sch))
>  		goto out;
>  
> -	if (!scx_kf_allowed_on_arg_tasks(sch, p))
> +	if (!scx_kf_arg_task_ok(sch, p))
>  		goto out;
>  
>  	cgrp = tg_cgrp(tg);
> -- 
> 2.53.0
> 
