Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411038F647
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658198; cv=fail; b=sNBOcG3YkRMB3dKdQjBjQnjFlVyKq+ZN50SylpfVFsloglaWuVYR8b5da4sWz5ta8sFC3hq19K5CKRzzf5DRjGXaLvUSQPMeSGap8lIdy1ymmELOQOfI31DOpXRXiqyfXTA2zWQ4Lo21iteU37WmJU7MbOhkqnFhM2IJh+WESV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658198; c=relaxed/simple;
	bh=+irnAnANljiBt9tReHyvTcVwhBUggkUDakoAKY5ZZYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IY2AhGcrQosLtkUzJmqg8noxPWkdUgWbTmah2ypTXNwhPHQASyf0zVsh4mNdh5vtRkMwLQMYjxeVDeTzBOhJ8PMTHFRP0T3wQYcN1Ibhhq2834JIVHkrKU+Pj66fP/2UUaSVlzZysjE4wXwdabgi0ytPcTnwZR5c89fNpqzlr9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NedfV1Jd; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NedfV1Jd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb9VyKVq0VVY4JruSLkqMOQua5Mxi3849E1F/fsowMUbD2Q217syIcvCOjBc8MvL2FpODwX2pkIqniEIXrmAaNpp6wsHIOEV/xannOR3/StpMYCXKtqKA3D3amuMUHdH+ZOzvg0y/cW0JRrVNtqao2Ru8Eb/QkWqz9YAfnzQpigrp1fzEdLSjFlugVoaFnIpMjzqPCmcIdOUfbJRWB8MchTu+0gGZhimaTKv4NBd1Hruf54FhWHQ2SG4BTybLRN/kDp6mdJPrH37u+8dXKDA/rERLzi1tITI7kgHQBtdO/XMkzirESagLRoExwHaXQXoZp07aiz3nz65xedyYAyUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofUFA0jcELXHnqxk+bkj7C4beq49MRVcvu3PC4VVfSc=;
 b=SpiCekEeDkDdLamhGPS+Mg/rpfuZWne9l2/jWGlWVetIooPGkERzjA395dFdvMnSURhmLQRxZrsBCSMKA1O5T+Gw55t+52zE74ZVH3OZCxob8EgprFywsGKDO8SbCUgxt9jfkD+jY/K9lTI8nLz0FbpHoRcu0WEEcNy+DEAPzMoM9rQvo3mhIytXLaEdtBx+MpqfG5jIxXJ2CkFqQGnBNJb7ALeDoVdlyLqHI779JBXIO4MjcK+JAUaz2YPAJRIWm5+8tiSbbFwICzgiP5VSpUVLKekZGEkePQr2HcZPW5eX97ZNn0Kb7SK2vrqekmS1TjoxSwY0rgxHHtdDyiY1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofUFA0jcELXHnqxk+bkj7C4beq49MRVcvu3PC4VVfSc=;
 b=NedfV1JdrlMU9knTM+LxXox3wvq30f4mtPmgen83ZHu2UH+mGBkmB+acuDLqyy+7csMmtjY7PSFoGRqOBg/+TcZv5ykCwCS9cBbPp3r1tpiQqpAe2FUapyK8dZ8aSsSLl/tlVKG9ajuBtJqzWIQRUCCt1baf105boXN/j+js5L2t5dnT0SSyg/WTcdmtsd86KgWrsk8kZuFS5wo4DuuyWQaZtmm1Jo0W7GHmKEbzumo854o3adGP0Crvp3C6CRXiKfW0joYOvwBMp8IAFsxNMTWfUdPtEQAKtIFj23tOM3c2YoXXYtPYmFPpeO0zYBje+rzqJODgM+zxyy6PVr1Z0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Mon, 16 Mar
 2026 10:49:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Mon, 16 Mar 2026
 10:49:52 +0000
Date: Mon, 16 Mar 2026 11:49:42 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
	shuah@kernel.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/2] sched_ext: Prevent SCX_KICK_WAIT deadlock by
 serialization
Message-ID: <abfgRv5DkOnCzz-q@gpd4>
References: <20260316100249.1651641-1-christian.loehle@arm.com>
 <20260316100249.1651641-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260316100249.1651641-2-christian.loehle@arm.com>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: aea2759e-15a6-46b0-5b4f-08de8349c0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+KDmg7eTuSkQ5fbt9GErPC2bSe8MQQF63+bpZOtXJkZohPQhksIu/2vKPdhFxDktsZG1ZrM65LfDuHn0TmQLVjflRsdO8Q/k3jndaYLOAZqaKplye7ugD6xFbiYwI+NYW4EVFsBREJNH+77DKtL3QQj3ATueVV/G9gOY3xNaLCzOu2epvJYjlfal0K7d4V/gleUCdY+/96MWz7BLNki6wkpa9OFrkbT7RzdEesRzm0vOImaYO+2kffQ0EbpFDuTd3HNvV3rFvLeiIR/SI0Hz6KsfEDz5SstAQsvYwfL/IkwtLjRWXtt7go+6U3YDKkkpjE2mAXU0DKqHD9nou67C+fatpf7nQecYaUKXJ46qaX9tPIEnFqWrxO0LTk1aklroXrmDOGkL1jMiBJH/loiKeiJ66+qlzrYYry0MW6Wl00e4lAPa2tWEJl4STzx5IJ5uTIxEC/t9aXCAsCd+iYad7+Znge8yZKuBpYHURPxXKixBP7IZ56MlI+heq1FMN5wiMvHkYgwxFGtOxnDcoYweWQx472+nqfhO1FUx68CvJKfFn7FOlRee9KrK1F0P+V3dUAL5jtK0FsmMNDU4hXbkJzdG5TH76mQt1AlCbMFpOcKqT+lK9AtlL0bSd55sK0zEul974IOQgdJtt40uRV+RhypL6aV2phQR2xbg1lKEpqAhz/SOr0Jh3M23p3hXr4vsZHW/3bdhBOOkgsz6ARKmABoZht2Z9MTr588AJm3qgWE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y04ycUNoYVBWTzRvNzA0K3dGTzRTamxVQ3R6Y2xlckJtMlp2eTBqQUovcVlY?=
 =?utf-8?B?VGw2VlBHQ1ZkejFoZGpRc3VCdnV2OHRvbDNCNHNDTG9XbnVkQzl3aEp1REo5?=
 =?utf-8?B?NGdVSXcxMFNkNlZoaUFHQ1dRY29pY1dQb0dqYW5Yb3pwR0JjcE9ualBsSjVn?=
 =?utf-8?B?NFBjSkhTencwaE5GSzRQalh0a2hQWUgvVjBsNDlKSjdzUUJ3VGN1VWljWTVs?=
 =?utf-8?B?NGs3Q2taWEZPVE42dWpmVFFSMkdydFNia2FyQTVaTnVJY0xaWGtTRm0vNFlE?=
 =?utf-8?B?eEdzWU43T1M1Ly9sTnB0dHV5VG5ua0J6L0dhL3Z5Q2VQWGxtbVlUc09HQVFO?=
 =?utf-8?B?K2Y2a2ExaGlqWWYxbW5iTHhLTEVMWlJ0OXZRU3h6Z2VYY1NKcklNTFgxK3Fv?=
 =?utf-8?B?K2NtSmZVTTk1UTJwZEJhQkdPU25qS3V2cnZSeDEwTG1xN1JTbk0vbWxHdXBG?=
 =?utf-8?B?Uktjdk5UTkFhK2RYUTdSRDE5cnlMcHRUc1A0VlM1MlNYTFZlRlBLZWV1dmZH?=
 =?utf-8?B?aVBRekxIUVVsU3VYWkNzMVJlVFcySXZYdkpGSUYzOHNnaWt5K25VQkJ3RUNl?=
 =?utf-8?B?ZHpIcTkyWThtMlFEMzV0cm1CcU0wSVhSWTUrNFk4MDZVN3B5ZnRLY3l2M2pP?=
 =?utf-8?B?d1hGNHZKSmJIYUVueEtvWnJtdU9hVWcrcDgvczVCemE1T3Z6em9ONHFKQzNW?=
 =?utf-8?B?Mm81MklHTWJ4QmVmazllVm0yZ25Ba2U5Wlozc2MyM2Q2aDF3YXkzWGovY0kw?=
 =?utf-8?B?YjJ3Y1Bxa0VYdms3ak80eFZVNkJxaTVOTHNCSWFNUUl6eWtIdXZMNUhGVVJH?=
 =?utf-8?B?OG0rb3YxNW9VS2NNZlFNWEptb1YzYzdnUkVWa081RSs2V3RDSkwrRCsyZGor?=
 =?utf-8?B?K0pLQ2VadjlvQ0IvNTFZekZad1Yxd1BhYWtuQ3dzcHp2OTRQNUxaYTVVOGRN?=
 =?utf-8?B?Q1laSE1uMnhyZ0lxbGQxR0ZGV3k4blR0VlZiNkZlZTVCZFpMZ25jYjcwUkVy?=
 =?utf-8?B?WWRwdlFVYVd4ZnhJc1ZlZXVwN2NacXFaN3RVdS96NzhhZk9oMEU5Sk9KQUtl?=
 =?utf-8?B?eit3RGlkK2E2SndqVnliSHl1dkVSWGsrSVhuMDR1dGsxcVZXdEt4eUR3Q01Z?=
 =?utf-8?B?NDJ5bXNZZFVVT2hFeXAyYXd0RXBDZ0xBZ3F1SERqOUtRQUU4MVhQZ0tYdW9p?=
 =?utf-8?B?di8yZnFKNlJScFR1eDdRTGU4b28wMmVnTVk3T0J5SVk3VjNjZlVkRmxIUGRl?=
 =?utf-8?B?ZlhOZzc4TVZjSzRjeXVIeWo0a3ZoanlrTE0vYURiT2NtakgydUxMZ1N1UjRT?=
 =?utf-8?B?YjBmTjR5RnYzZUttYUp0UmxScmttZEtGdDQwRzEwek1EWnUwVnJtYkJjdTkz?=
 =?utf-8?B?c3psd0xxRWtSQjRUa2N4VW42bGEzMk5zOVJmUDJYRk4veWhkWnVLbzk0NHNs?=
 =?utf-8?B?NWZOUCt1bHhIVnRaeGFSOFVuVGlPczRLNEIvdVJlOEFUWmcyT3IrUCtnZ280?=
 =?utf-8?B?YXNKRnJDdGgxS0xOUlVnamZFeVVZVDUzaENnNkhJWVVreFJ2VFZoaUgwTFMv?=
 =?utf-8?B?a0EvN2QrT3J2cjdnVy93L3dNUHpWOGRQYVV4dVpMOXRBK29pTUxYOVNuU1lx?=
 =?utf-8?B?VHdjVVl3OXpRQ2ZWajhPUXdsZ3hXa3E5ZEVXY3J3WVY1L3hZRHdFUkVOWmkw?=
 =?utf-8?B?N2cyeXpGSXlPZjNsVXZ6K3BuSHNhbG1VM3dHTmJRUEtkUmxMZXNzK2xYeVQr?=
 =?utf-8?B?eXRUK05FcE50aGpzejU0RkdkWDA5NXNIUnhGbFJpQ3lDbWR4djRzMXRqblZT?=
 =?utf-8?B?dmwwR2xXRys2anZnZ28xM2RZblV5SnNqMVd4REt5VHhkQmd4OVdpRG9rRjdp?=
 =?utf-8?B?Z1JHdXVMNkhBazRNQ2VsNlNNdDgzL1F3WGNsNFpiWlhKcUxQR2lDRGdKZTRm?=
 =?utf-8?B?SUttd0xSVDZmZW42WDR0V0JTRVZyVjdTa1V1WndEUVlQdmVDM0FLdkVlekEx?=
 =?utf-8?B?enVrakl5NU5yVThLdUo3RzFveFM0YTJZT3V0SlFmM21OME0zUUZPVDRON0U4?=
 =?utf-8?B?RW1jNmt6V2RpTEladW9aWnNFU2EzMmdUWCtnbGdDcHlSQTN2Vm93UHR1UStv?=
 =?utf-8?B?aUFTNlRKVWtITnJ3NDZnZzBadEdVTFhxdEYvdkg3SWVhTlVOM0k5dkdhR2lp?=
 =?utf-8?B?aGUyd0UxN3RDKzhhQWFqR1MyWVFMbDliMFIvakQybzYzVnBMQ08vNzk1M0lM?=
 =?utf-8?B?TnJodnF4UmpGNmNUNzYraVdqVGRTNnJoc1ZwMXBSVThGZFpSYWVWeWUyaHFk?=
 =?utf-8?B?RW9NMC9rekVWM1FNdFVmTk5QQWRJYjJCOHhLcWkyL0VCNm15RUl1dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea2759e-15a6-46b0-5b4f-08de8349c0bb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 10:49:52.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USW7vEvdG6+Aux9syePCrLu+5TL4tszYRnQXqLe+m+b7L7L2Tdgcbr44+o4a3cJGO6saGwhbted9iBsXfQvbhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385

Hi Christian,

On Mon, Mar 16, 2026 at 10:02:48AM +0000, Christian Loehle wrote:
> SCX_KICK_WAIT causes kick_cpus_irq_workfn() to busy-wait using
> smp_cond_load_acquire() until the target CPU's current SCX task has been
> context-switched out (its kick_sync counter advanced).
> 
> If multiple CPUs each issue SCX_KICK_WAIT targeting one another
> concurrently — e.g. CPU A waits for CPU B, B waits for CPU C, C waits for
> CPU A — all CPUs can end up wedged inside smp_cond_load_acquire()
> simultaneously.  Because each victim CPU is spinning in hardirq/irq_work
> context, it cannot reschedule, so no kick_sync counter ever advances and
> the system deadlocks.
> 
> Fix this by serializing access to the wait loop behind a global raw
> spinlock (scx_kick_wait_lock).  Only one CPU at a time may execute the
> wait loop; any other CPU that has SCX_KICK_WAIT work to do and fails to
> acquire the lock records itself in scx_kick_wait_pending and returns.
> When the active waiter finishes and releases the lock, it replays the
> pending set by re-queuing each pending CPU's kick_cpus_irq_work, ensuring
> no wait request is silently dropped.
> 
> This is deliberately a coarse serialization: multiple simultaneous wait
> operations now run sequentially, increasing latency.  In exchange,
> deadlocks are impossible regardless of the cycle length (A->B->C->...->A).
> 
> Also clear scx_kick_wait_pending in free_kick_syncs() so that any stale
> bits left by a CPU that deferred just as the scheduler exited are reset
> before the next scheduler instance loads.
> 
> Fixes: 90e55164dad4 ("sched_ext: Implement SCX_KICK_WAIT")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/ext.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 26a6ac2f8826..b63ae13d0486 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -89,6 +89,19 @@ struct scx_kick_syncs {
>  
>  static DEFINE_PER_CPU(struct scx_kick_syncs __rcu *, scx_kick_syncs);
>  
> +/*
> + * Serialize %SCX_KICK_WAIT processing across CPUs to avoid wait cycles.
> + * Callers failing to acquire @scx_kick_wait_lock defer by recording
> + * themselves in @scx_kick_wait_pending and are retriggered when the active
> + * waiter completes.
> + *
> + * Lock ordering: @scx_kick_wait_lock is always acquired before
> + * @scx_kick_wait_pending_lock; the two are never taken in the opposite order.
> + */
> +static DEFINE_RAW_SPINLOCK(scx_kick_wait_lock);
> +static DEFINE_RAW_SPINLOCK(scx_kick_wait_pending_lock);
> +static cpumask_t scx_kick_wait_pending;
> +
>  /*
>   * Direct dispatch marker.
>   *
> @@ -4279,6 +4292,13 @@ static void free_kick_syncs(void)
>  		if (to_free)
>  			kvfree_rcu(to_free, rcu);
>  	}
> +
> +	/*
> +	 * Clear any CPUs that were waiting for the lock when the scheduler
> +	 * exited.  Their irq_work has already returned so no in-flight
> +	 * waiter can observe the stale bits on the next enable.
> +	 */
> +	cpumask_clear(&scx_kick_wait_pending);

Do we need a raw_spin_lock/unlock(&scx_kick_wait_pending_lock) here to make
sure we're not racing with with cpumask_set_cpu()/cpumask_clear_cpu()?
Probably it's not that relevant at this point, but I'd keep the locking for
correctness.

Thanks,
-Andrea

>  }
>  
>  static void scx_disable_workfn(struct kthread_work *work)
> @@ -5647,8 +5667,9 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>  	struct rq *this_rq = this_rq();
>  	struct scx_rq *this_scx = &this_rq->scx;
>  	struct scx_kick_syncs __rcu *ksyncs_pcpu = __this_cpu_read(scx_kick_syncs);
> -	bool should_wait = false;
> +	bool should_wait = !cpumask_empty(this_scx->cpus_to_wait);
>  	unsigned long *ksyncs;
> +	s32 this_cpu = cpu_of(this_rq);
>  	s32 cpu;
>  
>  	if (unlikely(!ksyncs_pcpu)) {
> @@ -5672,6 +5693,17 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>  	if (!should_wait)
>  		return;
>  
> +	if (!raw_spin_trylock(&scx_kick_wait_lock)) {
> +		raw_spin_lock(&scx_kick_wait_pending_lock);
> +		cpumask_set_cpu(this_cpu, &scx_kick_wait_pending);
> +		raw_spin_unlock(&scx_kick_wait_pending_lock);
> +		return;
> +	}
> +
> +	raw_spin_lock(&scx_kick_wait_pending_lock);
> +	cpumask_clear_cpu(this_cpu, &scx_kick_wait_pending);
> +	raw_spin_unlock(&scx_kick_wait_pending_lock);
> +
>  	for_each_cpu(cpu, this_scx->cpus_to_wait) {
>  		unsigned long *wait_kick_sync = &cpu_rq(cpu)->scx.kick_sync;
>  
> @@ -5686,11 +5718,20 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>  		 * task is picked subsequently. The latter is necessary to break
>  		 * the wait when $cpu is taken by a higher sched class.
>  		 */
> -		if (cpu != cpu_of(this_rq))
> +		if (cpu != this_cpu)
>  			smp_cond_load_acquire(wait_kick_sync, VAL != ksyncs[cpu]);
>  
>  		cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
>  	}
> +
> +	raw_spin_unlock(&scx_kick_wait_lock);
> +
> +	raw_spin_lock(&scx_kick_wait_pending_lock);
> +	for_each_cpu(cpu, &scx_kick_wait_pending) {
> +		cpumask_clear_cpu(cpu, &scx_kick_wait_pending);
> +		irq_work_queue(&cpu_rq(cpu)->scx.kick_cpus_irq_work);
> +	}
> +	raw_spin_unlock(&scx_kick_wait_pending_lock);
>  }
>  
>  /**
> -- 
> 2.34.1
> 
