Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6F2346FAD
	for <sched-ext@lists.linux.dev>; Sun, 17 May 2026 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779015407; cv=fail; b=bD+AfkaSTA4wMBxD7A7pgsNvY34BDtN7wqh2NE6oPAmkixEfgr+sYywo8BU4xpYvSkqbA1pWoDIQzWixp2KPKGGkp6ig5qHdjLM/RmPwIQUBCH5qoLtbiXbyR1nwA++SQJJbDQUo3p1Gg5NePbdT4mVf9XoDWeNcqDb3T6WgkLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779015407; c=relaxed/simple;
	bh=/WgSVtWojU8Vfyl5rznIDVPgubk06i2C108uFGJd6mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ikRtGfyj1vARTOPpHAfoBG+gHnzii7IC/MZSqM1d55XWCup5PH305MlnTkc8vi0fH+I//CGbo8Wjwjna9JG51mavjn5dwN62g/Qp7Ab+tX3HHBXEgtNGRNlvlI2kKDShLwrN/rf0K4VkePv5GAWNDP8/WJnw006IaSqTWlnprcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fFhBwlxw; arc=fail smtp.client-ip=40.93.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fFhBwlxw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIKoE1qaFwxQpLwcANquopD0aJNLcxEUx2b6zoqTQVVJW/WjVVKoq3PF8ksHI1wlZ8HLMpHmD/dM7Jp0cqaBSRy7BjZKr6xsP9s6uPHMGZravzKlTI2W1N+y6glhmYO9onx0Tj1Rjm1Ne8YyRCuBdpMEqBIStCmDgKe5bnJ90f8ntND0XyxNM/Wj1fPQXpZEtBMmXEMr3a5iV8fNBwRCnPE/mdHOoXEe/EG6WmT7IIHtPSxA2v0cQSIUDREfBM/gjOnMfzNXDyU4o3Yiyk70+SRqKBCcnmWewmtk29ztb8yd6QMJVjdC7ZXlLnuH+t9QvN8phtFGJ/PqxkBbF5pqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qut8bPoZDoVn7ASiLh+0nPIRcQkz5DPozD2yt17fzUQ=;
 b=X2MOOIFpEj3DT0Y0bFq88g/3caNHR7jBycYEQ2AlHdvGccHHUjkZ1i+J6+D+BrWt7zxvYLF1E5STzUw9dp65G7nMabuJ133sFicQNLDGpcoR8TDpFsQCrE8TmTyAJX+LfnkD70vdXQ0RHb4TfNP4ZqzugJSBFal23upURzLK3iN7eIml00MciSnOrnbdIvkkt9QJsXaTrtMmMZOdiL+uHnh69UtDo0hNT0NsEWQI9fXUIm4u76mxALlMLHsH46HXInV2cI9lwxi3HibD1uplRhincwRf5l4+o05LCU+/bUolnG0vew5D1gXYHv05TLBfCzRsIOC0fBQ9bB6YY6PU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qut8bPoZDoVn7ASiLh+0nPIRcQkz5DPozD2yt17fzUQ=;
 b=fFhBwlxwXhZ7XdbYwYbouBWpPUkJGEDt3Nxto1vy+4+0zzJ5Z3ylpNrhIOaMEX/Q1509aJ4wYVtFAwRypndpzfrTOwOgQ9fveN5wIyDnBRt3SZPCCL8C4On4W3XVb99jrV3b0NfonOyWkXz9H3rszVRYO80d4A8HQeZTEYNBtNgCN1Js6CsSMDU22cXTi6dHd1zwk6pUfJsWNen5z5rdsKBvDTakSTu8kYgdhlUMDINKltGU8p22tXHbBDtG2BLWp3N9QctYnO3RGd8GvG8X+LPHMyqf91ALx6CWgycZbBW1RIufMIm2o2jD0BxF6/SC5ltbHdVBiYm6HWiOjecoqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 10:56:42 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.20.9913.009; Sun, 17 May 2026
 10:56:41 +0000
Date: Sun, 17 May 2026 12:56:34 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix deadlock between
 scx_root_disable() and concurrent forks
Message-ID: <agme4i4w5K6Ab9cM@gpd4>
References: <39ab37b4e79c6e5361a907c06ab27e72@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ab37b4e79c6e5361a907c06ab27e72@kernel.org>
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e33a743-e642-458f-51db-08deb402fa07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Kh13dRldM7vP8XLMPUFo9GpnF84K7pn4NuHsaHATFEB2IuS0OE4L6bi0uUAO2wIfhRFgWdPEvcnx/ccEZc2ulCHXDohvzMpEEERpWxmtCioF6GVSYdzpoKXvGQ5NeLuNsdABli+4CaL3Y9CvEU39gkKkoGl1rMS7H5C2kSCd5m3ENje09leM33hAM0FTURfdWVV9ZurPuJ5iw84V8a5ACLCohchSbRqbNMtGY5ylWccdIBkREcTkiMc56gfPg0zd+0YOEwhcjwSxCL7YntXqhy/GAQGrrojbsbDN3VR8p9cM9uW+AoU/0p/pnIrOJCAnEH2HtV0rIOtsJYWTn0R/SCJJ+n9CFSHEkK4DUsBUjOrYKpQN1p/OtyDqWsFEBeTfAZVXYOkSJvZrEV3TmcnvaTn5VHxJJiyzNHS9wwuuZrPy1hYikxPGsRsLAiqDZTV1Rjam44+hHIrop4nmkbAm76WIBV/YACN824NNzkJluWqnkBKSyWh0Zd3lZR0YLYn60myjYdrKNS69X2M/1y0FcGG2qVXGiHKiuG6h49c44fJ3QSClPFImWJAhobJUoK39/1Q6UKMThX3Kmb303L7Fi+DXU2eS5fnmaxKokGv6BxWMhRNtCjUNzxm68IlTlba1bPFUCb1pYa+B1s5yQ3P8BlpHit8KookKx9B/Jo3nrKciANc6km5ZJG8Wm4lxyYzd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ifjfNmJXt9EiPazRywIifGJk4/7vZq0VcUO+wr6ohbxw/vnYt014407s5RGr?=
 =?us-ascii?Q?C+txDaPTv4rU8U6rrCV4VB4g0hznAaz079XqhAr+DliIt6VigCvdA5sfcXBd?=
 =?us-ascii?Q?NUjb+9fxrHC4OczUewlZdgyl4sraDmycggrm8pDoJXlztJxELfj0alL4JnxX?=
 =?us-ascii?Q?HDSOm8MQ34lu3IGEgBrYMJ4h4rHNZotp3AKFyVqsH+yjv2mTHC4qiMHItJOd?=
 =?us-ascii?Q?tnXyyWXy9zZ7Is+qlK4IOuni+4qasOlQjlBPoYd4/B1gx+lbE3yuKRCnw7VT?=
 =?us-ascii?Q?lcOrvV6cwf/7q5DrSgM3adm1y/ZaAJQX60P4VuO2khTTP7kQesI4OLi4pjg/?=
 =?us-ascii?Q?quUy8Po0v3QX7RKkFJtvfFpxG8Ge1S2eosZuQ+OjztQOVL2g7VZOScRjZ7eM?=
 =?us-ascii?Q?DOSmnu1Tq1hEQ0831pbPd06ShVjD9nEUeLYoJPRladRQn6B4zeM1xyADjvHw?=
 =?us-ascii?Q?B4tUkgFQBxUY6H0owTJx6tvAEEZ2zfAbAGFyOFu0cpwt5MUs4SQvFBv+ps+V?=
 =?us-ascii?Q?vtJhWyCJ4J3tdyTrgoUR3+GiwZJP9cuvrsPexDXO0OL4MPzUf/voJQIRu94G?=
 =?us-ascii?Q?LTgNxCo9riBm0iIwM0xLa3qFr8J+vZxQ9HQbO6flnFk7d+G8MmFIGkOPEh5L?=
 =?us-ascii?Q?hj69za6pVS8/jop8YBiv0OaVDVm/KdTLdV773zUsjceapJ8ZI4JkBvJ1KkE5?=
 =?us-ascii?Q?nqh1Wva0Fz5s9hFri1sQLvo3QC5E/QOCg/X7uN+4kk6y8VWnj51U71fSZbvg?=
 =?us-ascii?Q?hLjW7ax4zER7cCHR+q2oG5iWbMsKR2Gs8fSrOrl1ZU9OZgBYGU0X1qlgsp6/?=
 =?us-ascii?Q?a6SlGMOhNWUeN2enaIqt0qIBzs5z9KsyG2fiEsb0aHjKsrv2U+Kmfw+U0gMP?=
 =?us-ascii?Q?Gq+J3mqQclczQ+QVVNcZfbNarCnEwGpLr/kvYb+S0hEtfBtIPuKY60DU3bxG?=
 =?us-ascii?Q?inIcTDzaBEMjYp3vjV9hw0EExFAXQqFWXYl9tgrABsLaDMdny+FIymjZ9juX?=
 =?us-ascii?Q?CT9zh5EEYMJtxZj99n5pb4Yo/VgxipH+2QODop8YPqayVJXGCcD14vUAcRLz?=
 =?us-ascii?Q?jzvOmX+5iYNwmVYbDHVZz9H3hWYA92+6QJQj9h70MWiJ7weU7Q9FlC9+XP+a?=
 =?us-ascii?Q?W0D+YszAerBrA+HNrtuPmjg9gcsDyfVDXbOVvSdVoiVwihbk+B4CSkyZEJbO?=
 =?us-ascii?Q?lGjN79fNp9peXK+a93DuQkpYkWf0q7Rt/ZBmWHoGBM8ffNRALQDk1uS0K3yG?=
 =?us-ascii?Q?+rlhOrorAScHXMemr4hn9ohSaRK4G7TNRX3t4mz2eKM/HtzGaJyWiie5MEkf?=
 =?us-ascii?Q?ZmpQYNxdX7yIAkK0PJuAUoDrp4qs5U5VWapK7Dj0fguw2RGQWbhLOU0YlBUY?=
 =?us-ascii?Q?7QVe4cw4bkT2k+N26mAPUPokgfcOnyx0a/Yj2XIGg0HirHL/FqCFEge7bxrx?=
 =?us-ascii?Q?R7HDkc8LXhtgei7vzOGY6GfY4R3sDzFxRXr6C7PADZT41hg2qkPEGePdQHby?=
 =?us-ascii?Q?iIeQtBzIKlO4+Q9N1BO/lzwK8lgVUa3AjAZg4WiDNm2tn1n7Ykj0A1+ARm4S?=
 =?us-ascii?Q?PuA2U4RpS8sgkouMB3L2QsjImrqwL/YVUnSQkMelNNbJdNbscewFJwwPRUnT?=
 =?us-ascii?Q?kpf5RtXLnmG6FoJ467FkS79WPw3eBpyeJLXcp7c7CtbBbMLQG4wgSe74G1zF?=
 =?us-ascii?Q?6MGrPUUH20D/c0LApAaUBFgLYWAoTRIRg2HDVIgHoKUk6cd0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e33a743-e642-458f-51db-08deb402fa07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 10:56:41.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRDc0DU5TXPe5lts8gfMeqR1cgY5V1Pn+HB3vz21pWFRzvbfMH3SqkRGrw9gaPEp3+J+7OWy1hZuVDDb1x14Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665

Hi Tejun,

On Sat, May 16, 2026 at 02:41:20PM -1000, Tejun Heo wrote:
> scx_root_disable() enters SCX_DISABLING before it grabs scx_enable_mutex to
> clear [__]scx_switching_all. task_should_scx() short-circuits on DISABLING,
> so forks in that window land on fair while next_active_class() still skips
> fair - the new tasks stall.
> 
> This can deadlock the disable path itself: scx_alloc_and_add_sched() runs
> under scx_enable_mutex and creates a helper kthread; if that new kthread is
> one of the stalled fair tasks, the mutex holder waits forever and
> scx_root_disable() can never make progress. Only sub-sched support exposes
> this, since sub-sched enables are the only path where
> scx_alloc_and_add_sched() can race the root's disable.
> 
> Move the DISABLING check after @scx_switching_all so that whenever
> @scx_switching_all is set, forks keep going to scx and stay in lockstep with
> __scx_switched_all. Once both are cleared (together under the mutex),
> DISABLING applies normally.
> 
> Fixes: 337ec00b1d9c ("sched_ext: Implement cgroup sub-sched enabling and disabling")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c |   23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5092,10 +5092,31 @@ static const struct kset_uevent_ops scx_
>   */
>  bool task_should_scx(int policy)
>  {
> -	if (!scx_enabled() || unlikely(scx_enable_state() == SCX_DISABLING))
> +	/* if disabled, nothing should be on it */
> +	if (!scx_enabled())
>  		return false;
> +
> +	/* scx is taking over all SCHED_OTHER and SCHED_EXT tasks */
>  	if (READ_ONCE(scx_switching_all))
>  		return true;
> +
> +	/*
> +	 * scx is tearing down - keep new SCHED_EXT tasks out.
> +	 *
> +	 * Must come after scx_switching_all test. While both are set, we must
> +	 * return true via the branch above: [__]scx_switching_all are cleared
> +	 * together under scx_enable_mutex, and a fork routed to fair while
> +	 * __scx_switched_all is still on would stall because
> +	 * next_active_class() skips fair.

Just being extra picky: [__]scx_switching_all are cleared together sequentially,
but not atomically (in fact the order is what matters). To make it more clear,
how about rephrasing the comment block above like this:

  * Must come after the scx_switching_all test. scx_root_disable()
  * clears __scx_switched_all before scx_switching_all (both under
  * scx_enable_mutex), so while scx_switching_all is observed as true,
  * __scx_switched_all may still be on. A fork routed to fair in that
  * window would stall because next_active_class() skips fair.

> +	 *
> +	 * This can develop into a deadlock - scx holds scx_enable_mutex across
> +	 * kthread_create() in scx_alloc_and_add_sched(); if the new kthread is
> +	 * the stalled task, the disable path can never grab the mutex to clear
> +	 * scx_switching_all.
> +	 */
> +	if (unlikely(scx_enable_state() == SCX_DISABLING))
> +		return false;
> +
>  	return policy == SCHED_EXT;
>  }
> 

Other than that, looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
