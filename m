Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA772F7444
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767539; cv=fail; b=IALM31u114LRAn1G6rYw/xddQrJOpv0pPcWrt+rSrvCpJspbEvdEno4dk+zAfnPYDWoBZ3yr/7XlXfGG+UX9GQ4dvjBOMoh8TDxB3/a8pUx+2LDX1RWpu+ePdF5HEl3Z5W1zSnI57i6u8X3Xxo9Kbg31y3EfLkZJU6TU9XFn1kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767539; c=relaxed/simple;
	bh=JcaIbGZVgxWF75bV4sG10hVWCgYx699MHViIsKtSYaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uZzZoYEEa/N1oNJOBv/URzg2QA7J0BTBrbxwT3qLrOzbi6tBHkIqR4EWtHCkbgKlR8UxdhzsCPzwOisv6BIp31cRjP+kuOpC5Bfyay/V8LRXb38NYli50B+Jkf9YOWJcLaEnOHSUXBKCeNkumHQG4qLwF4FbtJ5NsprcD6SZxNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xd8tpV1h; arc=fail smtp.client-ip=40.107.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xd8tpV1h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsog8SHMyywApObRTUWFEVnAIN5oRc8938VgHGaLyzv+oB9VrrN93J893EZ+Ry/a8rramczbss3ujfPJGxn4o4BjEiL3B3+NLaDMe7N72w1qTh9Nt8LpKNJCFUwGlOU4ry4iVHSWXm3NyxcYWYPFsn+HQwq979dKZ3WIj16gKzOj6pkKTaCMoLoLNEExHvy9d8qYI/BIOnRl92yFgQ2Yo2JMkMMyoWjsDqiEMbGR3dZF7e12skL+0jhBp76p8FETXH+wyD9b+Qybh5SN8+4gjSjOZIR7SEwdZEJHpJiHO9/A2psU13RMLqr0lJHfVEKES3NCxCog/a1xqpUfaFU1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLUQYJ1th0ZNbpF4ecocMQf7hb7e+dJf4Yf501drQqg=;
 b=t/RcWR84ApRnhQBDT0BKBLj7UNdvcCV6XFr9xDHXpGeJJ2vjE8a1qufWAPh6urKtDCtsU7nPjjb/CLkS8fn3prJh3fo7MTDFdYvE5umi56D1rM0pDIHAoQSjSAOc8VRk8bGV601fE2TyzfPBKWrxeYNaVPjErGh/VQskMCnOxVYN8Y9kKaNGnx9Zn2Q5t6R1q30QE0fm21mNbvbiSErZTbN0tvRvUnIbYNklMIj3DeFC9mgmaFMtnZA7SF6HqORHcyzX0hrVSQKCGMGsy4S72GBKyfHdqA97tn+M4MJglvyZ/x/Ta6zu2ufPxswZuq5NfAjmBcQxOa9+jaekAFXWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLUQYJ1th0ZNbpF4ecocMQf7hb7e+dJf4Yf501drQqg=;
 b=Xd8tpV1hmZTh+8x3h1xbPEVuYBhmWVPsPD5JrXEx+BjBxZOsNAqnQJHeWCXrPUVCpOJ9+fEQLjyUatXZF2IQ5DtGZtmCPvrfYRPedQ7Ozn2fJ4ioYDNBpfnwHkjbZgobkTrqaoxQ3SFoijWk8vTjBTMJutIRzQpYof/UAeANNL/d9OaHYuwrNwk4qVtAOik/pap2gc0nnJ3LIhSbR7Z92h8m3gAnV6N13QkBfcUPR5+QsIasD9lkuMUMVoIFMovsL0X5KAePdGJPbkSNDg2b9j5sr6tFC9eIQC5htbOMFd1zv8wrImwiBFKZCYF73BzFYaUcSforfLD1io+6hxQ/lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:38:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 09:38:51 +0000
Date: Mon, 10 Nov 2025 10:38:43 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] sched_ext: Implement load balancer for bypass mode
Message-ID: <aRGyo6M9AbInZTkb@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-14-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-14-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d4e7db-340c-4551-b269-08de203cf4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+rP7eZYhTODvxv3qly15tO72VPlZ0ibOEmst3/EyYen+jCLGfoYVcnYeS4yX?=
 =?us-ascii?Q?qZ1xtPDb0kTwgmhjpX7CWhtU9MBtOS5WmoaPnbJTVQXkbE73Spwf9vsBsiEG?=
 =?us-ascii?Q?dXa10hrSEi7iPy+/SOxvT9EusCBtRk2d9EV+tPDt6bk4zh+fzkX4qJbLCQcd?=
 =?us-ascii?Q?GTaU9ELcV+PNECB9wxDiIl0vjhGhZd2XOse57SYNM7mETua6HC0TQKXWAn3P?=
 =?us-ascii?Q?awS+tLHPcOc3X5EutFGMute3JvvmFaJkYjb70z8jMv7KAA/4+QKS4D86caZL?=
 =?us-ascii?Q?ESzTlPph2yXDzZCjBSaTZsfYn9UPzGOfhTb8loLbqYSFXTv7DLYXABAtVasE?=
 =?us-ascii?Q?AHZ10fefet3A1nIiWffI5Eyt31iZWtc92CpFHa36hNOYf3TrliX0Hi2VyDy4?=
 =?us-ascii?Q?oFisWc4XpLReU/a8xnbFWjudP+sigVOXPsDJMEAwgBG9inlfotgaCwW5T7YB?=
 =?us-ascii?Q?zEeNRpTA98CpRnQhOCWmQyT6MYCDndJSLugGQZCklgUR+7J60kY+StbYokuL?=
 =?us-ascii?Q?Uqi+ap3S3vJJt3/kRrMlWyaCt2YPqdLa8oddAFn6zKqO7oLes9CNINkgauGY?=
 =?us-ascii?Q?hI8PT9uKVEAYplBgX/e34slfx+ZjcUrW/xbiawbtFvZ4OsymXn9Q3b98SvfN?=
 =?us-ascii?Q?9UuQTtCw1vwP0aoudTzoFB4VG79dhd/g3iNNM4tXZESW7xrdgpOZ2oya6azR?=
 =?us-ascii?Q?CuGIoQWiNhlH1odgPN23V3KB5IiWfLSEgdJR2w2KW8TMLtilA1sxA+e5rK6L?=
 =?us-ascii?Q?UHY3jkkzgTUfGcUpbNF4OIvtOSc3nh7FELEO8QyG+gQV9B0LH74BBzYgpTix?=
 =?us-ascii?Q?zZthVYmTTc0mIFe9nW3mV6EUVYlLaIlKvVtonIbckBF5A/FO1+NDI4qBeszd?=
 =?us-ascii?Q?rfzgHwBwHRAMS4a6+THguMLQNKDPEK+v6GKuPmnUUmM5uzI6k3SBTAyz7S3+?=
 =?us-ascii?Q?Wi58xZ72lUdJrGDshQ0jQhCt1BXQKwXQA1CkAjAQ1dk5Newda19dgbVB2+Zk?=
 =?us-ascii?Q?QTwub2XVXKLX2Gfo6DQbj9V1Ah2x+fwi2lPAMjXlP5pBlL4VAv9w7ZhIh7tM?=
 =?us-ascii?Q?zGg9gAHqOo1MdlafFac+fmVPWMQe5plw99IYJwLt/MlqY/KRAqLC7GhsZmLF?=
 =?us-ascii?Q?PKK10EW1+Pp3PPleDtDTB+deUSbpy9yG5//8AFf4fuKb9p4tYB0LS6DJNDwv?=
 =?us-ascii?Q?K0dYkFYUlEWX1PDfu4+9KRFX6hjav8DHr1SyNidHvgKx+Q1DR9MZEUXoZumk?=
 =?us-ascii?Q?hAFJ400CgNCEzQd5e/kkI1a2YzMK+aKJsWhUyE+X1blxoY2+YUH1QJDJDCSH?=
 =?us-ascii?Q?LCxl4PMeCyor/H+qzzSz22KltA76x8++f/oZjQ5ysjdPOmHvkSahBQ3wR/XO?=
 =?us-ascii?Q?+Gnu905Iz71UC6mnpzftpIw6S3PkKHZXkFS1dfMG3RD77nYtDyk8lHW/bXxz?=
 =?us-ascii?Q?0DA45sy5XfpDWubER4ZDJkITRCNHT/9f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A+9v80wak9BDX8HHmZdrQvyQYsvKEHrIH3eb7gRGNylg+rGJA2DCTfxUcAal?=
 =?us-ascii?Q?4u0OHhhMtvrOqu3oxGjHsS4nuQJqmP3jA8CO0gYAMFS0svymIv1Gqg14ogri?=
 =?us-ascii?Q?FoTG62CCO3JVzFddCLc4QEoIjCHX+Y4J4JrmABGe4LyibMMXnpKMnu88p57t?=
 =?us-ascii?Q?hveP0IxZxDp9F0c82gl+AurZE8MbYZuxnVi7F03eLdFyR89bopmzWMNyquSG?=
 =?us-ascii?Q?L8EzpVCed75b/4dXMkjdREBEAmOoQ/oXzKAohT2GXajGWMoqK0Fa73/wfK8G?=
 =?us-ascii?Q?C0PR3jYrTzMzL6unMK+a1hhePPwZkDvZHCjgmamv9qsF7gPccOqXSx9KUKFv?=
 =?us-ascii?Q?EbMt4DuG1clkldiG9bb94t40qPigSNQ172ukOYSFkqPAXeOUdggnLdw2K3Vn?=
 =?us-ascii?Q?A7jA/cz1jIZE+DPpJP9W4AejHQmnhedwdXKnkiiyiBTrkTIZW1GsHIVKNRMk?=
 =?us-ascii?Q?IcRwdIVfAKjCx7OV6c9j9qjliV0vEQZinIfoMncO42uxFG4+qenOFIoJiz2C?=
 =?us-ascii?Q?tRBUYyvV49nEI1TfIqA8QsGD9h+VZgr4SGy0jDxQqXLSrPDyCRFydaXLTlSc?=
 =?us-ascii?Q?RiCFCqb9hPwh6DbGn3IO7rf5b7pbLxGCZ6/4CpVcr9jFkPD33Hph2X5UKgfv?=
 =?us-ascii?Q?zP76Y4xQZUKTxmjYw7SM3CdIOkIOF+8+gW+KaNpt1xJZy0jNCVNggGRLXaFk?=
 =?us-ascii?Q?kyDh7WJd5BTe0D4ds6Sv/lLCEnQLtTUwClyQGygQuvRkKSWp4uo+ayjMsb/I?=
 =?us-ascii?Q?GX7GR1JUQDsCN0MOoiflGxnuJLmzQClvlSrKGGPA1gu4REwiLGwCuYlzkkJ+?=
 =?us-ascii?Q?Xem6UY6a43dbJccIxr6g9ns5XqI5oFJSqZthP8cvIQEZ/KY6A/Dyh87CuHDU?=
 =?us-ascii?Q?nkUQgKoSzgNJ2xhCZ1CVsQiED5DCSVzLN6d47q5tDKK7cpMry8lDj+LqyLda?=
 =?us-ascii?Q?f/E+ZT+bDXq0KyzxPdcwqNZ9eUhGiP/6mqm3pMJ6CBg4TG7ULDjr/Dg8oFW6?=
 =?us-ascii?Q?JQLNonBQUT53Ry0F1TtJRqGD4Qp41/4Sqn7NWWCrDm/Xqiuz7GFFUJhqhn6w?=
 =?us-ascii?Q?OVLazr+pPdO/0bvXNvqBke0uLEULrnZ3/Q0PEORxdaS9zKTPR28YInb90RhJ?=
 =?us-ascii?Q?MA9g/9s2yqa2HaBxyHDf+4vI3YRTDf2gv04X4SVE1v3bMtwmEevQ9ftwX68M?=
 =?us-ascii?Q?Pi6oPFJZvUnJHsG7vs5QeRx3F0huJPAXNBymSHP+aW6aKsSX1SRcuR6UZtAC?=
 =?us-ascii?Q?HZncdaG6ejifJbtTWJnQ2/Eq791vv/2TQkgXY2LXGi2iuFi7FgjfC6h3C+xk?=
 =?us-ascii?Q?Yz2OYX2H5Z5IdslDopGH7ZQrxvHgcXXynbZwU5mOZR3V4nR6PxW0ZT5kN3Ij?=
 =?us-ascii?Q?IzFj3W4htGoyHOC0fZksJLSV/R1h+JS+esRMvcqQqd1zyJdU4qxlU2Ls4ctw?=
 =?us-ascii?Q?+eVavvxpFboKyiBE9yl0ARbuuv6PHE4Z74mgnoieXZ2H0psl4PDWL46xyX+k?=
 =?us-ascii?Q?+a7H4sB1WtrZN2XD3T6T//Uuns9wqDuKRfuxO7gtQF7zTjC3m23IyckSEvDn?=
 =?us-ascii?Q?MLkQugmxMtWpsj8Khm3/XlxE9qtqwmjZum+Ef02E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d4e7db-340c-4551-b269-08de203cf4e3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:38:51.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B592alOy1/vojHDXaFv2hK6XZV0zUfs3Ic8G50kCJBE8rrYu3lDteOEFL0+0gIBF8R+ttsq6KxGa+2aS/2+2RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200

On Sun, Nov 09, 2025 at 08:31:12AM -1000, Tejun Heo wrote:
> In bypass mode, tasks are queued on per-CPU bypass DSQs. While this works well
> in most cases, there is a failure mode where a BPF scheduler can skew task
> placement severely before triggering bypass in highly over-saturated systems.
> If most tasks end up concentrated on a few CPUs, those CPUs can accumulate
> queues that are too long to drain in a reasonable time, leading to RCU stalls
> and hung tasks.
> 
> Implement a simple timer-based load balancer that redistributes tasks across
> CPUs within each NUMA node. The balancer runs periodically (default 500ms,
> tunable via bypass_lb_intv_us module parameter) and moves tasks from overloaded
> CPUs to underloaded ones.
> 
> When moving tasks between bypass DSQs, the load balancer holds nested DSQ locks
> to avoid dropping and reacquiring the donor DSQ lock on each iteration, as
> donor DSQs can be very long and highly contended. Add the SCX_ENQ_NESTED flag
> and use raw_spin_lock_nested() in dispatch_enqueue() to support this. The load
> balancer timer function reads scx_bypass_depth locklessly to check whether
> bypass mode is active. Use WRITE_ONCE() when updating scx_bypass_depth to pair
> with the READ_ONCE() in the timer function.
> 
> This has been tested on a 192 CPU dual socket AMD EPYC machine with ~20k
> runnable tasks running scx_cpu0. As scx_cpu0 queues all tasks to CPU0, almost
> all tasks end up on CPU0 creating severe imbalance. Without the load balancer,
> disabling the scheduler can lead to RCU stalls and hung tasks, taking a very
> long time to complete. With the load balancer, disable completes in about a
> second.
> 
> The load balancing operation can be monitored using the sched_ext_bypass_lb
> tracepoint and disabled by setting bypass_lb_intv_us to 0.

In general, I really like to have a default load balancer implementation in
the sched_ext core, even if initially it's only used for bypass mode for
now. In the future, we could also consider reusing this in the regular
scheduling path somehow and not just for bypass.

Comments below.

> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
...
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -34,6 +34,8 @@ DEFINE_STATIC_KEY_FALSE(__scx_enabled);
>  DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
>  static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
>  static int scx_bypass_depth;
> +static cpumask_var_t scx_bypass_lb_donee_cpumask;
> +static cpumask_var_t scx_bypass_lb_resched_cpumask;
>  static bool scx_aborting;
>  static bool scx_init_task_enabled;
>  static bool scx_switching_all;
> @@ -150,6 +152,7 @@ static struct kset *scx_kset;
>  static u64 scx_slice_dfl = SCX_SLICE_DFL;
>  static unsigned int scx_slice_dfl_us = SCX_SLICE_DFL / NSEC_PER_USEC;
>  static unsigned int scx_slice_bypass_us = SCX_SLICE_BYPASS / NSEC_PER_USEC;
> +static unsigned int scx_bypass_lb_intv_us = SCX_BYPASS_LB_DFL_INTV_US;
>  
>  static int set_slice_us(const char *val, const struct kernel_param *kp)
>  {
> @@ -161,6 +164,16 @@ static const struct kernel_param_ops slice_us_param_ops = {
>  	.get = param_get_uint,
>  };
>  
> +static int set_bypass_lb_intv_us(const char *val, const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, 0, 10 * USEC_PER_SEC);
> +}
> +
> +static const struct kernel_param_ops bypass_lb_intv_us_param_ops = {
> +	.set = set_bypass_lb_intv_us,
> +	.get = param_get_uint,
> +};
> +
>  #undef MODULE_PARAM_PREFIX
>  #define MODULE_PARAM_PREFIX	"sched_ext."
>  
> @@ -168,6 +181,8 @@ module_param_cb(slice_dfl_us, &slice_us_param_ops, &scx_slice_dfl_us, 0600);
>  MODULE_PARM_DESC(slice_dfl_us, "default slice in microseconds, applied on [un]load (100us to 100ms)");
>  module_param_cb(slice_bypass_us, &slice_us_param_ops, &scx_slice_bypass_us, 0600);
>  MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]load (100us to 100ms)");
> +module_param_cb(bypass_lb_intv_us, &bypass_lb_intv_us_param_ops, &scx_bypass_lb_intv_us, 0600);
> +MODULE_PARM_DESC(bypass_lb_intv_us, "bypass load balance interval in microseconds (0 (disable) to 10s)");
>  
>  #undef MODULE_PARAM_PREFIX
>  
> @@ -965,7 +980,9 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  		     !RB_EMPTY_NODE(&p->scx.dsq_priq));
>  
>  	if (!is_local) {
> -		raw_spin_lock(&dsq->lock);
> +		raw_spin_lock_nested(&dsq->lock,
> +			(enq_flags & SCX_ENQ_NESTED) ? SINGLE_DEPTH_NESTING : 0);
> +
>  		if (unlikely(dsq->id == SCX_DSQ_INVALID)) {
>  			scx_error(sch, "attempting to dispatch to a destroyed dsq");
>  			/* fall back to the global dsq */

Outside the context of the patch we're doing:

			/* fall back to the global dsq */
			raw_spin_unlock(&dsq->lock);
			dsq = find_global_dsq(sch, p);
			raw_spin_lock(&dsq->lock);

I think we should we preserve the nested lock annotation also when locking
the global DSQ and do:

		raw_spin_lock_nested(&dsq->lock,
			(enq_flags & SCX_ENQ_NESTED) ? SINGLE_DEPTH_NESTING : 0);

It seems correct either way, but without this I think we could potentially
trigger false positive lockdep warnings.

> @@ -3728,6 +3745,204 @@ bool scx_hardlockup(void)
>  	return true;
>  }
>  
> +static u32 bypass_lb_cpu(struct scx_sched *sch, struct scx_dispatch_q *donor_dsq,
> +			 struct cpumask *donee_mask, struct cpumask *resched_mask,
> +			 u32 nr_donor_target, u32 nr_donee_target)
> +{
> +	struct task_struct *p, *n;
> +	struct scx_dsq_list_node cursor = INIT_DSQ_LIST_CURSOR(cursor, 0, 0);
> +	s32 delta = READ_ONCE(donor_dsq->nr) - nr_donor_target;
> +	u32 nr_balanced = 0, min_delta_us;
> +
> +	/*
> +	 * All we want to guarantee is reasonable forward progress. No reason to
> +	 * fine tune. Assuming every task on @donor_dsq runs their full slice,
> +	 * consider offloading iff the total queued duration is over the
> +	 * threshold.
> +	 */
> +	min_delta_us = scx_bypass_lb_intv_us / SCX_BYPASS_LB_MIN_DELTA_DIV;
> +	if (delta < DIV_ROUND_UP(min_delta_us, scx_slice_bypass_us))
> +		return 0;
> +
> +	raw_spin_lock_irq(&donor_dsq->lock);
> +	list_add(&cursor.node, &donor_dsq->list);
> +resume:
> +	n = container_of(&cursor, struct task_struct, scx.dsq_list);
> +	n = nldsq_next_task(donor_dsq, n, false);
> +
> +	while ((p = n)) {
> +		struct rq *donee_rq;
> +		struct scx_dispatch_q *donee_dsq;
> +		int donee;
> +
> +		n = nldsq_next_task(donor_dsq, n, false);
> +
> +		if (donor_dsq->nr <= nr_donor_target)
> +			break;
> +
> +		if (cpumask_empty(donee_mask))
> +			break;
> +
> +		donee = cpumask_any_and_distribute(donee_mask, p->cpus_ptr);
> +		if (donee >= nr_cpu_ids)
> +			continue;
> +
> +		donee_rq = cpu_rq(donee);
> +		donee_dsq = &donee_rq->scx.bypass_dsq;
> +
> +		/*
> +		 * $p's rq is not locked but $p's DSQ lock protects its
> +		 * scheduling properties making this test safe.
> +		 */
> +		if (!task_can_run_on_remote_rq(sch, p, donee_rq, false))
> +			continue;
> +
> +		/*
> +		 * Moving $p from one non-local DSQ to another. The source DSQ
> +		 * is already locked. Do an abbreviated dequeue and then perform
> +		 * enqueue without unlocking $donor_dsq.
> +		 *
> +		 * We don't want to drop and reacquire the lock on each
> +		 * iteration as @donor_dsq can be very long and potentially
> +		 * highly contended. Donee DSQs are less likely to be contended.
> +		 * The nested locking is safe as only this LB moves tasks
> +		 * between bypass DSQs.
> +		 */
> +		task_unlink_from_dsq(p, donor_dsq);
> +		p->scx.dsq = NULL;
> +		dispatch_enqueue(sch, donee_dsq, p, SCX_ENQ_NESTED);

Are we racing with dispatch_dequeue() and the holding_cpu dancing here?

If I read correctly, dispatch_dequeue() reads p->scx.dsq without holding
the lock, then acquires the lock on that DSQ, but between the read and lock
acquisition, the load balancer can move the task to a different DSQ.

Maybe we should change dispatch_dequeue() as well to verify after locking
that we locked the correct DSQ, and retry if the task was moved.

Thanks,
-Andrea

> +
> +		/*
> +		 * $donee might have been idle and need to be woken up. No need
> +		 * to be clever. Kick every CPU that receives tasks.
> +		 */
> +		cpumask_set_cpu(donee, resched_mask);
> +
> +		if (READ_ONCE(donee_dsq->nr) >= nr_donee_target)
> +			cpumask_clear_cpu(donee, donee_mask);
> +
> +		nr_balanced++;
> +		if (!(nr_balanced % SCX_BYPASS_LB_BATCH) && n) {
> +			list_move_tail(&cursor.node, &n->scx.dsq_list.node);
> +			raw_spin_unlock_irq(&donor_dsq->lock);
> +			cpu_relax();
> +			raw_spin_lock_irq(&donor_dsq->lock);
> +			goto resume;
> +		}
> +	}
> +
> +	list_del_init(&cursor.node);
> +	raw_spin_unlock_irq(&donor_dsq->lock);
> +
> +	return nr_balanced;
> +}
> +
> +static void bypass_lb_node(struct scx_sched *sch, int node)
> +{
> +	const struct cpumask *node_mask = cpumask_of_node(node);
> +	struct cpumask *donee_mask = scx_bypass_lb_donee_cpumask;
> +	struct cpumask *resched_mask = scx_bypass_lb_resched_cpumask;
> +	u32 nr_tasks = 0, nr_cpus = 0, nr_balanced = 0;
> +	u32 nr_target, nr_donor_target;
> +	u32 before_min = U32_MAX, before_max = 0;
> +	u32 after_min = U32_MAX, after_max = 0;
> +	int cpu;
> +
> +	/* count the target tasks and CPUs */
> +	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
> +		u32 nr = READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr);
> +
> +		nr_tasks += nr;
> +		nr_cpus++;
> +
> +		before_min = min(nr, before_min);
> +		before_max = max(nr, before_max);
> +	}
> +
> +	if (!nr_cpus)
> +		return;
> +
> +	/*
> +	 * We don't want CPUs to have more than $nr_donor_target tasks and
> +	 * balancing to fill donee CPUs upto $nr_target. Once targets are
> +	 * calculated, find the donee CPUs.
> +	 */
> +	nr_target = DIV_ROUND_UP(nr_tasks, nr_cpus);
> +	nr_donor_target = DIV_ROUND_UP(nr_target * SCX_BYPASS_LB_DONOR_PCT, 100);
> +
> +	cpumask_clear(donee_mask);
> +	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
> +		if (READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr) < nr_target)
> +			cpumask_set_cpu(cpu, donee_mask);
> +	}
> +
> +	/* iterate !donee CPUs and see if they should be offloaded */
> +	cpumask_clear(resched_mask);
> +	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
> +		struct rq *rq = cpu_rq(cpu);
> +		struct scx_dispatch_q *donor_dsq = &rq->scx.bypass_dsq;
> +
> +		if (cpumask_empty(donee_mask))
> +			break;
> +		if (cpumask_test_cpu(cpu, donee_mask))
> +			continue;
> +		if (READ_ONCE(donor_dsq->nr) <= nr_donor_target)
> +			continue;
> +
> +		nr_balanced += bypass_lb_cpu(sch, donor_dsq,
> +					     donee_mask, resched_mask,
> +					     nr_donor_target, nr_target);
> +	}
> +
> +	for_each_cpu(cpu, resched_mask) {
> +		struct rq *rq = cpu_rq(cpu);
> +
> +		raw_spin_rq_lock_irq(rq);
> +		resched_curr(rq);
> +		raw_spin_rq_unlock_irq(rq);
> +	}
> +
> +	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
> +		u32 nr = READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr);
> +
> +		after_min = min(nr, after_min);
> +		after_max = max(nr, after_max);
> +
> +	}
> +
> +	trace_sched_ext_bypass_lb(node, nr_cpus, nr_tasks, nr_balanced,
> +				  before_min, before_max, after_min, after_max);
> +}
> +
> +/*
> + * In bypass mode, all tasks are put on the per-CPU bypass DSQs. If the machine
> + * is over-saturated and the BPF scheduler skewed tasks into few CPUs, some
> + * bypass DSQs can be overloaded. If there are enough tasks to saturate other
> + * lightly loaded CPUs, such imbalance can lead to very high execution latency
> + * on the overloaded CPUs and thus to hung tasks and RCU stalls. To avoid such
> + * outcomes, a simple load balancing mechanism is implemented by the following
> + * timer which runs periodically while bypass mode is in effect.
> + */
> +static void scx_bypass_lb_timerfn(struct timer_list *timer)
> +{
> +	struct scx_sched *sch;
> +	int node;
> +	u32 intv_us;
> +
> +	sch = rcu_dereference_all(scx_root);
> +	if (unlikely(!sch) || !READ_ONCE(scx_bypass_depth))
> +		return;
> +
> +	for_each_node_with_cpus(node)
> +		bypass_lb_node(sch, node);
> +
> +	intv_us = READ_ONCE(scx_bypass_lb_intv_us);
> +	if (intv_us)
> +		mod_timer(timer, jiffies + usecs_to_jiffies(intv_us));
> +}
> +
> +static DEFINE_TIMER(scx_bypass_lb_timer, scx_bypass_lb_timerfn);
> +
>  /**
>   * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
>   * @bypass: true for bypass, false for unbypass
> @@ -3771,7 +3986,9 @@ static void scx_bypass(bool bypass)
>  	sch = rcu_dereference_bh(scx_root);
>  
>  	if (bypass) {
> -		scx_bypass_depth++;
> +		u32 intv_us;
> +
> +		WRITE_ONCE(scx_bypass_depth, scx_bypass_depth + 1);
>  		WARN_ON_ONCE(scx_bypass_depth <= 0);
>  		if (scx_bypass_depth != 1)
>  			goto unlock;
> @@ -3779,8 +3996,15 @@ static void scx_bypass(bool bypass)
>  		bypass_timestamp = ktime_get_ns();
>  		if (sch)
>  			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
> +
> +		intv_us = READ_ONCE(scx_bypass_lb_intv_us);
> +		if (intv_us && !timer_pending(&scx_bypass_lb_timer)) {
> +			scx_bypass_lb_timer.expires =
> +				jiffies + usecs_to_jiffies(intv_us);
> +			add_timer_global(&scx_bypass_lb_timer);
> +		}
>  	} else {
> -		scx_bypass_depth--;
> +		WRITE_ONCE(scx_bypass_depth, scx_bypass_depth - 1);
>  		WARN_ON_ONCE(scx_bypass_depth < 0);
>  		if (scx_bypass_depth != 0)
>  			goto unlock;
> @@ -7036,6 +7260,12 @@ static int __init scx_init(void)
>  		return ret;
>  	}
>  
> +	if (!alloc_cpumask_var(&scx_bypass_lb_donee_cpumask, GFP_KERNEL) ||
> +	    !alloc_cpumask_var(&scx_bypass_lb_resched_cpumask, GFP_KERNEL)) {
> +		pr_err("sched_ext: Failed to allocate cpumasks\n");
> +		return -ENOMEM;
> +	}
> +
>  	return 0;
>  }
>  __initcall(scx_init);
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index dd6f25fb6159..386c677e4c9a 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -23,6 +23,11 @@ enum scx_consts {
>  	 * scx_tasks_lock to avoid causing e.g. CSD and RCU stalls.
>  	 */
>  	SCX_TASK_ITER_BATCH		= 32,
> +
> +	SCX_BYPASS_LB_DFL_INTV_US	= 500 * USEC_PER_MSEC,
> +	SCX_BYPASS_LB_DONOR_PCT		= 125,
> +	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
> +	SCX_BYPASS_LB_BATCH		= 256,
>  };
>  
>  enum scx_exit_kind {
> @@ -963,6 +968,7 @@ enum scx_enq_flags {
>  
>  	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
>  	SCX_ENQ_DSQ_PRIQ	= 1LLU << 57,
> +	SCX_ENQ_NESTED		= 1LLU << 58,
>  };
>  
>  enum scx_deq_flags {
> -- 
> 2.51.1
> 
