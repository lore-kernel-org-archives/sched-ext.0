Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546EE3B0AE7
	for <sched-ext@lists.linux.dev>; Mon, 24 Aug 2026 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570669; cv=fail; b=DCIKA0BQyXHseSkHjKWibWHoKKGfgxw/LU3bxRgLqVGnugS/YzPZqo+pSJoTlMQLtOjCwH4vfDlQPS/oD4mMw6uBMjm3Id08469fmPcZMnVHkuhCGqvnZkaWaajpJhA03wnziBumQaKSs6AEhBQC2+Kn4/eeg5QzDMdhFtI6Hyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570669; c=relaxed/simple;
	bh=c2HOmnXN+zDmDlEqPp7uE9OJrGKZty7V5/TdcQwtU3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qWSRr7AEIT3KCkwCUgLKcOCY8Rjzfd96OSpc4PkhlBQhn8nwEhGWFwQxmW7fO1P2ldcRLrzJqcJZrnJ6jVftziD21P1uMItwbW9rpHBgGqTZdDfBcw+6IkNma5yOkN5W/82Uv8IMZpKKUU0DZ9B9nMyn4y3UkG6fdhb268PLb4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D9n4XRvY; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D9n4XRvY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ew6sNP1JhXfmgwfD6SYB2k8cLzKhi9X56zrmUh+6RZ2UknGMYBKyjzDkCisn05FQ0P2c9UbkLCU3PWp00jAl+YvucFjqUHD3Y4D5BVzIs5hw06AX4b/s0wXp/oQ9b9ZYtza6V8ug0U+1pOEMC3RNieyWNGc3VTCmHuQIfFXTwTwPY7Juy4JZZKJU7trDR1A6kkka102ek3uzCfeRxlO8gwBNBXpNx9cJLI+YUi3Sgm3V7h6SKsPPWT2UKK9L7tFC99sxKc5hr9Ifw/rWY1GcjeDMSNEqjjxBKhs7H9qLC+0HsAY8wU0nOYuoseKgBM3hoi8Il8jKyhLfcocI+0iohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk+9lAeTvRyYW0pbpfn9/FAgwBM30AjjYOIUVEOeIKM=;
 b=FUEyq+3E5o08wqOx6V9Euni+AwhSh06HPCSecUSfbLD0QWHwTsQlN9zMwEsaKk95WMmZ0Km4ySVjMPelfM0uEEewZS2ViAU96IkvkWy37a3UdnWa6/mXggakaDCkUpQ7p9oM2GhpfNZLGI+8B7rKG0p52Qf14b9Ity/J52P6S8Nd5dJc8EB2AHbG1MqeMIp1lYXON9nqzZALY0He9wSEfjErbwwcPLaCNlbW8HXzS4AJdJdU/Ek3SztX2rG1lk8UvFMZn/S2xJMaj08RxYAUAi4g5sm8L8HDBtpcujxGq/td/CVemBSSqBgySfi/N1huyDsPr39hX7h8P+O0iAt24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk+9lAeTvRyYW0pbpfn9/FAgwBM30AjjYOIUVEOeIKM=;
 b=D9n4XRvYm9M6AV22Co5psjS5L5FQELJIVdLLtCO5tnjy2a8v7/GQXg+d1nUKi1qDas0W8cKUmjiQHoy/FJnaVDFwcpNDXBSWrtgmtaJt321hBhXjTECn7PHVgzqa/1rcClqxHRgvo4lMtliKmOaJlajDv9bZVdkcCx+bFiaVeIjca1Nn8a8Rxsbj4OPLqh0/fe0sJO12ictlYqfqpMmHhxHTUicnE7NyzxP29jGNvw6xCNrSVSP6aCmWxGQJzJAnAqsc+P5jScnc+PGIBq8QYJrluwmffuISCj7ry5X/gKNDefjuiD8bqK/5e6BIK/K8ILD3WAJ0N4ODEcAnVhIY+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9712.namprd12.prod.outlook.com (2603:10b6:8:275::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 11:24:20 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 11:24:20 +0000
Date: Mon, 24 Aug 2026 13:24:06 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Michal Blaszczyk <michalblk@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched: Lift cgroup update locking to core to prevent
 CFS/SCX divergence
Message-ID: <aowp1tYb-XeCdKi9@gpd4>
References: <20260824074913.2468177-1-michalblk@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824074913.2468177-1-michalblk@google.com>
X-ClientProxiedBy: MI2PEPF00000B8C.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::41a) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: d44a31e4-2ac5-48d3-e140-08df01d23d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	AHvfxF5uU0RondcS6nG0H1EcyiHDsfXM/KT1ecpQYzMApP0CEttUWh8uGJTgXl92Wz07FSVuzemi5WZI/73BnvTvd4bJZ9D9+HIzvz8bEdZ9F4uCHdEJhwFC3BagHZxSTq+u5qyGzoSxRMecgUdxYXjVDUhzlJKMEm0vqdYG25pX18SHaNi93sH8QB+4LMUWMILAv12a6BfVFSDsF7g/CcqNyqzTq19NNkEiqE/XGYCfRdT8Nts5EJXwidmK5CupQ4FQGMu5kKyyv2t3KLrpMA8nGfEcGMOLNf6NzfFZmeUG8RUsefGr4HkmFt6ba07g/SoEJOtJqYZ18ZAJkz3vY3s4i6vRO+2qytrRJ0UlLimXkAKRQYh/OrP/GRVOiCAAjDrOOCukUUWDvD5FtrIAN9tE3nTc08oLkGMJATQKSGGFC8KyDH4YdSMF05vZEB1DZAujH9z6dbg2YnF26ebnmtCcnXR4nORAbJhvyCyzSOSb7s3M4tfEnTjvULSqdhig4hNMoEMNFCMsOlaVmUTilGdlkUFiKWF7QgMRI1OL6mTi/goa9E9+DayfhAaj4F64qSN/QWXiWXqhgGIGnY1rA6FjoMq1hvhBS9wVYzyyRK2+uthqw9bz0MI0Q42/at/c80B0ey1R+0zgrt7TuI7HFuT8+jx8dlfXl5668aiO/C0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2M6nY8FQ0LRRSNrFdfL2Sn/Lb/WTWfMhz15G4rsp79lUbSE6yfnt4b9XCihN?=
 =?us-ascii?Q?7sVsx7/T+oBgUKAcYelgtpdpzAjAcCjqKVMgBDwWJ96iEcyBwvjyUyZVS4gQ?=
 =?us-ascii?Q?Toh8+8S+ga6sOTHWiPmPc1zhEuaLPzygBchR3KbbqE0UqTMQXE9XfPPwi4VU?=
 =?us-ascii?Q?17IkT2LBSObevHbdpXpEUe11iHfDNw/+xpFYJNIsGbYJmsVwd6ANuVL3hkSd?=
 =?us-ascii?Q?IVxmiFgZZQVlFrtRtVzHvoNuVVV44eO0CedQbY3DqdFJUpHYYexWa1nNn1ot?=
 =?us-ascii?Q?dL++GqUfBCdKndj6wGJuT9OaYzPV8TcWmYP1NH8g4wFRlwGorwTk9LpRvBqc?=
 =?us-ascii?Q?2Gkh1PMdYUZ0NeP7+b6F5aKL0YL0tySkJqK3/J3nY8bqq93g3qRhhV/7Z3AQ?=
 =?us-ascii?Q?PruV87wod1UknNBGDdEsPmr5fFjg/j+Hrmqui4p0+eGmZvsXuNPULmotlbjw?=
 =?us-ascii?Q?3MijHDl6YJCcUf13Orfd14jeHm2UGOMpQXPDRnwAAobZqW7sbOAAqb2lmCy5?=
 =?us-ascii?Q?zPkMkOpJDtxdwqCJqdYQF3gi5gdeZY0AMsAvzVZF8vVR9a1OT5geJ7X6vnui?=
 =?us-ascii?Q?P2KYJ6eplnxMqT4226IEIHIxBuoHT92ZtmL3e4ILO7Y7zXLjIhrBxAfGTCYh?=
 =?us-ascii?Q?K4wWZwiCcicfc+lqN0qWOzI4ECoV1RX9cu/AddRw/SKtfSZfnslmNjtu6Ay1?=
 =?us-ascii?Q?zKFg7bCCRpSByZsHY/nujn7WeIQu0vyVcb1/HGGSlIPoDwnja2zNoNq2+So1?=
 =?us-ascii?Q?2H4RQN9QnUPRCwWZsAFPnFquoxSOh6BTpLcbondD1Da2U3JfdgChfpnLfeiR?=
 =?us-ascii?Q?R14zh0YagGamCbL52vsg+6vQNk7qiN0xORU0bDfSRJe9UQXMyk34Wn39K1eC?=
 =?us-ascii?Q?5btD7HjZWI8Je6gfTrFijT7hShOjY0VBj7GG3e6sr73INDdfpyC8OYAmvJHY?=
 =?us-ascii?Q?QW5Tle3PCFnetUqiW4nZlLhb/d86ykxtAUK9GYaKK0PqBZhbEQ/G7rGCfRME?=
 =?us-ascii?Q?wzpAeYUGBiyOiCwnQW4VxEAFBZKBQqyRN4IPI649r0ivJFwSFBp5N9c6TDTb?=
 =?us-ascii?Q?I9SyLEmXWQZ45xlOjMTB4uZT0B4C61k5ccKj50o7vPr7HN76wsqOqUI+c4Pg?=
 =?us-ascii?Q?BL8wiJV7C4jb+GMtSUG57BDcpD+n7pGA9hIuYymfEpxrlqBbyLRkFBnm41Hh?=
 =?us-ascii?Q?RhLZkoHGmidEBPIZEe4O+FejzJwEYkYgysg/33/mFziIqHNLiNhXc2a+nJtt?=
 =?us-ascii?Q?NpIUOhmrDZIKahvmgAZ4WCUixOAt9cawm6bMnH4960giCn3fEsxQ/1+MI9RT?=
 =?us-ascii?Q?VfgnmaPx8zBPY/dMwqmTwCPz0hP9/fnhCtQCar0CP5dHd8fmqABDpmmBHD0A?=
 =?us-ascii?Q?Z+/PuF7d4+XKmbC4/tI7K2dMSYC0OJk1fHq4U2RIX+E3MR9SJJgR4QSoqsWX?=
 =?us-ascii?Q?KVg6C3L/H+QyJGSVqsY7tGhM4Q2nYp4Mk7Junrae3HAbLgmpapNGIYing5mh?=
 =?us-ascii?Q?kwhPOYhmwS70oxD3egf4sd1X+/LcGEin5qP0S8l2/q9VwVMbhdi2qRLkgiHc?=
 =?us-ascii?Q?Ebz8AEjWVcfXZJZP3WTQyYMZ9hU4ZCI01odLkFQo4dUVHULG4WD7K2W1DuMD?=
 =?us-ascii?Q?MUYrwpc8MjqLt5TDZPB9BcJYaitiMIxGdgQjiu2FlnhhdnL+neFYot7+6xj1?=
 =?us-ascii?Q?TuLro5pexm9mCb/i3akARfv3yAksBP/p/wVcaSSVqLQLXRLD/ywy8CyG0ljA?=
 =?us-ascii?Q?hq47loTa9g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44a31e4-2ac5-48d3-e140-08df01d23d61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 11:24:20.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6g4eycBWNTkS/YiC0OCE3JcbZx1Vf11EDVJUe2uMNTTrXHyELbmI/ojl9wAMbdkB6JZtorcGH7kXBlUcK8FxXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9712

Hi Michal,

On Mon, Aug 24, 2026 at 07:49:13AM +0000, Michal Blaszczyk wrote:
> Concurrent writes to cgroup control files (such as cpu.shares or
> cpu.weight) can lead to state divergence between CFS and SCX.
> 
> For instance, in cpu_shares_write_u64(), the CFS update is serialized
> by shares_mutex (internal to fair.c), but this lock is dropped before
> scx_group_set_weight() is called. The latter only acquires a read
> semaphore (scx_cgroup_ops_rwsem), allowing multiple threads to evaluate
> and act on the sched_ext update concurrently.
> 
> This serialization gap allows concurrent writes to interleave.
> As a result, the recorded state in CFS, the SCX internal bookkeeping
> (e.g., tg->scx.weight), and the BPF scheduler itself can end up operating
> on completely distinct parameters (pairwise distinct values).
> 
> Similar races are present in tg_set_bandwidth(), cpu_idle_write_s64(),
> cpu_weight_write_u64(), and cpu_weight_nice_write_s64().
> 
> Fix this by moving the CFS locking up into the core layer in
> `kernel/sched/core.c`. By acquiring these locks directly in the core
> write handlers, both the CFS and SCX callbacks are executed atomically
> under the same lock.
> 
> Fixes: 819513666966 ("sched_ext: Add cgroup support")
> Signed-off-by: Michal Blaszczyk <michalblk@google.com>

IIUC the bandwidth read-modify-write paths still snapshot the unchanged
parameters before taking cpu_max_mutex, so concurrent writes to different
bandwidth knobs can overwrite each other.

However, this shouldn't be a blocker for this patch. The serialization aspect
could be addressed in a separate patch, maybe extending the lock over both the
snapshot and update?

For now:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> v3:
> - Renamed the shares and cfs_constraints mutexes.
> 
>  kernel/sched/core.c  | 35 +++++++++++++++++++++++------------
>  kernel/sched/fair.c  | 25 +++++++++++++------------
>  kernel/sched/sched.h |  7 +++++++
>  3 files changed, 43 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f5f7ff8c680a..4673a78cb9e8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9779,6 +9779,8 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
>  }
>  #endif /* CONFIG_UCLAMP_TASK_GROUP */
>  
> +DEFINE_MUTEX(cpu_weight_mutex);
> +
>  #ifdef CONFIG_GROUP_SCHED_WEIGHT
>  static unsigned long tg_weight(struct task_group *tg)
>  {
> @@ -9796,7 +9798,10 @@ static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
>  
>  	if (shareval > scale_load_down(ULONG_MAX))
>  		shareval = MAX_SHARES;
> -	ret = sched_group_set_shares(css_tg(css), scale_load(shareval));
> +
> +	guard(mutex)(&cpu_weight_mutex);
> +
> +	ret = sched_group_set_shares_locked(css_tg(css), scale_load(shareval));
>  	if (!ret)
>  		scx_group_set_weight(css_tg(css),
>  				     sched_weight_to_cgroup(shareval));
> @@ -9811,8 +9816,6 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
>  #endif /* CONFIG_GROUP_SCHED_WEIGHT */
>  
>  #ifdef CONFIG_CFS_BANDWIDTH
> -static DEFINE_MUTEX(cfs_constraints_mutex);
> -
>  static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
>  
>  static int tg_set_cfs_bandwidth(struct task_group *tg,
> @@ -9831,13 +9834,6 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
>  
>  	burst = (u64)burst_us * NSEC_PER_USEC;
>  
> -	/*
> -	 * Prevent race between setting of cfs_rq->runtime_enabled and
> -	 * unthrottle_offline_cfs_rqs().
> -	 */
> -	guard(cpus_read_lock)();
> -	guard(mutex)(&cfs_constraints_mutex);
> -
>  	ret = __cfs_schedulable(tg, period, quota);
>  	if (ret)
>  		return ret;
> @@ -10089,6 +10085,8 @@ static u64 cpu_period_read_u64(struct cgroup_subsys_state *css,
>  	return period_us;
>  }
>  
> +static DEFINE_MUTEX(cpu_max_mutex);
> +
>  static int tg_set_bandwidth(struct task_group *tg,
>  			    u64 period_us, u64 quota_us, u64 burst_us)
>  {
> @@ -10131,6 +10129,13 @@ static int tg_set_bandwidth(struct task_group *tg,
>  					burst_us + quota_us > max_bw_runtime_us))
>  		return -EINVAL;
>  
> +	/*
> +	 * Prevent race between setting of cfs_rq->runtime_enabled and
> +	 * unthrottle_offline_cfs_rqs().
> +	 */
> +	guard(cpus_read_lock)();
> +	guard(mutex)(&cpu_max_mutex);
> +
>  #ifdef CONFIG_CFS_BANDWIDTH
>  	ret = tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
>  #endif /* CONFIG_CFS_BANDWIDTH */
> @@ -10229,6 +10234,8 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
>  {
>  	int ret;
>  
> +	guard(mutex)(&cpu_weight_mutex);
> +
>  	ret = sched_group_set_idle(css_tg(css), idle);
>  	if (!ret)
>  		scx_group_set_idle(css_tg(css), idle);
> @@ -10405,7 +10412,9 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
>  
>  	weight = sched_weight_from_cgroup(cgrp_weight);
>  
> -	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
> +	guard(mutex)(&cpu_weight_mutex);
> +
> +	ret = sched_group_set_shares_locked(css_tg(css), scale_load(weight));
>  	if (!ret)
>  		scx_group_set_weight(css_tg(css), cgrp_weight);
>  	return ret;
> @@ -10442,7 +10451,9 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
>  	idx = array_index_nospec(idx, 40);
>  	weight = sched_prio_to_weight[idx];
>  
> -	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
> +	guard(mutex)(&cpu_weight_mutex);
> +
> +	ret = sched_group_set_shares_locked(css_tg(css), scale_load(weight));
>  	if (!ret)
>  		scx_group_set_weight(css_tg(css),
>  				     sched_weight_to_cgroup(weight));
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 001140132a7d..4e0a38b0cb3c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -15392,13 +15392,11 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
>  	se->parent = parent;
>  }
>  
> -static DEFINE_MUTEX(shares_mutex);
> -
>  static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
>  {
>  	int i;
>  
> -	lockdep_assert_held(&shares_mutex);
> +	lockdep_assert_held(&cpu_weight_mutex);
>  
>  	/*
>  	 * We can't change the weight of the root cgroup.
> @@ -15430,36 +15428,40 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
>  	return 0;
>  }
>  
> -int sched_group_set_shares(struct task_group *tg, unsigned long shares)
> +int sched_group_set_shares_locked(struct task_group *tg, unsigned long shares)
>  {
>  	int ret;
>  
> -	mutex_lock(&shares_mutex);
> +	lockdep_assert_held(&cpu_weight_mutex);
> +
>  	if (tg_is_idle(tg))
>  		ret = -EINVAL;
>  	else
>  		ret = __sched_group_set_shares(tg, shares);
> -	mutex_unlock(&shares_mutex);
>  
>  	return ret;
>  }
>  
> +int sched_group_set_shares(struct task_group *tg, unsigned long shares)
> +{
> +	guard(mutex)(&cpu_weight_mutex);
> +	return sched_group_set_shares_locked(tg, shares);
> +}
> +
>  int sched_group_set_idle(struct task_group *tg, long idle)
>  {
>  	int i;
>  
> +	lockdep_assert_held(&cpu_weight_mutex);
> +
>  	if (tg == &root_task_group)
>  		return -EINVAL;
>  
>  	if (idle < 0 || idle > 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&shares_mutex);
> -
> -	if (tg->idle == idle) {
> -		mutex_unlock(&shares_mutex);
> +	if (tg->idle == idle)
>  		return 0;
> -	}
>  
>  	tg->idle = idle;
>  
> @@ -15505,7 +15507,6 @@ int sched_group_set_idle(struct task_group *tg, long idle)
>  	else
>  		__sched_group_set_shares(tg, NICE_0_LOAD);
>  
> -	mutex_unlock(&shares_mutex);
>  	return 0;
>  }
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 26ae13c86b69..a989b54f7017 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -599,7 +599,10 @@ extern void sched_release_group(struct task_group *tg);
>  extern void sched_move_task(struct task_struct *tsk, bool for_autogroup);
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> +extern struct mutex cpu_weight_mutex;
> +
>  extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
> +extern int sched_group_set_shares_locked(struct task_group *tg, unsigned long shares);
>  
>  extern int sched_group_set_idle(struct task_group *tg, long idle);
>  
> @@ -607,6 +610,10 @@ extern void set_task_rq_fair(struct sched_entity *se,
>  			     struct cfs_rq *prev, struct cfs_rq *next);
>  #else /* !CONFIG_FAIR_GROUP_SCHED: */
>  static inline int sched_group_set_shares(struct task_group *tg, unsigned long shares) { return 0; }
> +static inline int sched_group_set_shares_locked(struct task_group *tg, unsigned long shares)
> +{
> +	return 0;
> +}
>  static inline int sched_group_set_idle(struct task_group *tg, long idle) { return 0; }
>  #endif /* !CONFIG_FAIR_GROUP_SCHED */
>  
> -- 
> 2.55.0.860.g4b6b3295ed-goog
> 
