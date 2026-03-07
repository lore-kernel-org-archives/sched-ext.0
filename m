Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C763644CC
	for <sched-ext@lists.linux.dev>; Sat,  7 Mar 2026 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772866223; cv=fail; b=Y1ypm6awxNTUNjitLUB4s5fSXPAXeCA9c+EX5UehJ8oUDDDPZsY8Ix/4SmNC9anwSqhcYUomGyjEgo8dYostnLwMoKNTNp/w95UOzidBvAzfNQhbHWWcU6scsuIGiLFH7e3c3+c+4KpaJxYUExqAsnmv8VuOqwoBQHMMXepkaco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772866223; c=relaxed/simple;
	bh=etb9n2d9xtkI2E1jnkk3DLZD80VT8yxqtG5VT44jm0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QwVduc6Q7UMRY9+zJriAfYlVAW/PY+tfa2WjQKmndi0l7lB7ziLJts24vwYanOxL01UmWECqzidBe2O+uO3KcQKqFQjEcIRFX72Lr4Nrh7+9s0T2u3RPNDeiqjiO5OZnt17B9MxeWhMUma0qb2nRQYq6uvK0OCSPSfPsYKfIwZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b/pRgZ20; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b/pRgZ20"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ve0XuSH1SVL7c/J58oxVFeqfIAGEjEnFzqU4WDfIy32+bOmsq37rhPoMNPLaFtwapm2jKp4ZDVbDJQpkGGq4A59zRGcj12N+ynzGilZ+UCDkp6Nhva/Ngc10Dop8q/BDh4ogr4wro03ojkH/wTKnn3x5PCaRyNqAxu4rIRw1mjOmr8bY6gvTUz0bFA61zzaSdyAPRMlpowGiZFL8ozQsItb7u8cDcrsK5JYP2RC7o4Y93pCIOPE0BYpOVgJC7kZXY1LIfJ3bc4yZIUHSmUh2zGlsDOrf1J+KliT9Pc4fFNZonaacrKTiYdTirdaTEuTwo619gGctcI4lcQt/ZN+FLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ggSA38IjliqdL5oq7EWr7ubihVZ/ypM60FgeUll0qg=;
 b=w/q+C7AIZEYSkUo9QdQdZZj7xpKXc23ktugzo5JOeDUg7ann9pMMyjvTuW7diEUnKs6aKsv986oL6xhsIJhHlcQ9RkWuoD4XU6246LKw4SNK/U+VKfB81gQ8j4XWhoB0Hocv6VAbTNbYKhrAjTldtwtK0Un23XYZ2BY2kS4oTh88G8m7xJXOL9W5RuwY7fDvbIHnL8nz1r8z4mqI3WMxn0zPb2NBCioyUww/UMGUtPNQibBeNoqoxTQEwNoxtwS804xoetabo4jPA4pwee6TS1PZ1VVmC7u3XXpYAJowVItveWA6T3M4VLj/ywDnPAEe7eHP2IRsWcLQAJO141q0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ggSA38IjliqdL5oq7EWr7ubihVZ/ypM60FgeUll0qg=;
 b=b/pRgZ20wEMUMdMypp6TNjpPZXX1vdRyZzIvztR12pHJU3oXl+Q1TVpmAnU+1jEvXpAqBZ8uCeKfsqdkA3uZI+qIGuVBRc9eIuqbgQXDKad9Duhhnh/hkI3r+M7wr7iFLWN1yFtzQiB6/DIxtfaNx8Alo+xweR9t3l5FZsvgmeh8QScRlo2cQmR4/HLg+lMg0slREdTH5MmBXM30lAGTgxl3MCIPl6rsEIBO3IpEkSXp5RAEIj2hR/sILax2yPcv8QNakTDu0n0Y41kfBJfxJKjLKvP9L5bxk0TRbe1koFlECjspJNk1nkHpmtuHRUeLz5P3k55dYjV40uZhXZIDxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sat, 7 Mar
 2026 06:50:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Sat, 7 Mar 2026
 06:50:18 +0000
Date: Sat, 7 Mar 2026 07:50:12 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.0-fixes] sched_ext: Fix
 enqueue_task_scx() truncation of upper enqueue flags
Message-ID: <aavKpFRhyV8U5SBb@gpd4>
References: <9b72570da1834f89d8f6017ce3b14db0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b72570da1834f89d8f6017ce3b14db0@kernel.org>
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f25c45-9946-42bd-a528-08de7c15cba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	IJmkZTsNCBMS6DIIWwOLletrUI8e7mWXyh940G+SMPUd+yCCVLPiEQ4KArAazLL33WqrugdZb8vKgQB4a93ysYScI36MEjt+e5pljML7bnyF0gykJH/RBihr/4WwbPLENIWxlcM/fFcO1Rct9n7A26MZUzPTY4TJBtmnEgEFG5uLPyl0NGaH7kyD/WgLSb6SHmrkhxgiQ4Grkn4q74BBys8fJQdbcD8oj8kIGQ4NN6UsWBDriRMfSCABlF9VgcNFZw0GbVkwbbXL+jyinwGemiF56uiIviKo6Gf8gExl9iyp2g9z4idmia/qXktptf0zXqEQCeRdYHTl0FFJYmVyoQc3INzpzyjEXNUfJlF1IRoKiDUngJ5whU6ZwDlFktZGf2Kxz+2XMg3a9PhyR4jkkig+cREAouUCFqRhxu0Ite9g+bDg01E1k8K/O4IWEDY3pCr1gYB7CIz2o49/xL7PQezflG53BL+AkU189tjVkcWl/AlZYF9owwzPBERGVxCDAKFvFt5S4ttVQHvrfZotu0cosqcaadJMTWyThJh9pWwkNwZc6Z4GxQzH3fsFvQ5zKXZouiEFT3PSOoQDdO+YxclFZ06QUlzRER27n/2C4GviJs3Lm6wggTIfAwmT/v/e8CjY4Tvq7++2yzfra0txEQtFuZrEKvBlbqPsb/CiPP+NWV+Mn4pkw6alfOxeyugVThYeJILUArTyQlpnBrBALoQdq5m5oX1vpFUK3LCx090=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W56HpcNYynFlYBsmPWtsymy8NqsPC18lLrA4uNQq4TZf4QRid9Q3TQOQJoM4?=
 =?us-ascii?Q?T21VQ+gUNZfGtmcAbSLY+/4oDLIeiQ/+++9+FYwln6E3HhGiyai6JgbSFe85?=
 =?us-ascii?Q?3AweAA6fcxh80VYsANnVxjqTJ31k6p6Kf0/fNgU2zoQ9PxWa3FKzHqUhMtBK?=
 =?us-ascii?Q?DhPgr0U2cSHn9NdXx6es8pobUFfafJZ8c7+LKegNVq00O4y7L7k9b8F4wEaJ?=
 =?us-ascii?Q?fhJkRarmgYRUtiiJBb1nsFLbD7lRqLuF/NkG8Kfv0vQsE761Ilf+mapw/Tzu?=
 =?us-ascii?Q?ouSW/1UqdWDjUC7H3QvBJE8umUyvCbbBTiEGw/md0S6sruoWRbuOMeFLx/y8?=
 =?us-ascii?Q?eEFWYu5MOhIGoJHBE8aTmNmdWUESxVnJtVer/SBFJW0XvdRtiMDF39pJJlBO?=
 =?us-ascii?Q?jbXXe099plA6IXJAa10UVRO3hH8g0HCB0rCDay5CNzq+FnHDBGmSi9+FhHjJ?=
 =?us-ascii?Q?P/bSgdqAe3WS8WthWEcPBvZaa9XlD64cTCR0DttmC1bgeSewASH1ff9lE1yx?=
 =?us-ascii?Q?bZAxzWiSpAQMfJIdxc6Fya34r+B1VLWmDPc4iKQcWJLkzt74saDhz8K/iGyA?=
 =?us-ascii?Q?Y/8xmvXy5xvyH9BsxA0l5mI9QSc1VfuOXlD/Lc7KwjKIKbpAPVvENBHs6/KK?=
 =?us-ascii?Q?zI5bsmMPFboE0w5V+F5HtvgY7lqnbWIcOZDGN0dmoOKclzYSlZL7NbIprsp0?=
 =?us-ascii?Q?SsJ3aiEqw3ml2Z4YBVm72NTltGAGiIQovh6PXNeTw1N9/cEwZkkpAgT7+Cau?=
 =?us-ascii?Q?dxixSzRsB7q0NEMeKewbp+q59OPVr/mzn5MVY8WXO5MsRib2Od/UCfOHXNsR?=
 =?us-ascii?Q?WqLcPzAJOsfAy5uH22pbSo2Ged3jctZZdbQ4C1yN0411oRaCnUV3yV2ZhW/x?=
 =?us-ascii?Q?oJ5Tq3Fr4BTPyzE6NtI2uMeT2QUKvUVr7DkbuwOZiQ6LzV4GTABP3p1F8DBu?=
 =?us-ascii?Q?Cr3AoQj8hjL60tXjsZS3D4MSavVQU4h3Xj2ZFEQU/aVic8fALwnpEdo/TCMj?=
 =?us-ascii?Q?p2bAdMzG9yNRXM8qgs1flEtqnJfG0+wt65vldJ/4qgNtQhtz+i1UAiZhIVJT?=
 =?us-ascii?Q?jAznmP8fRS2Uhx2whYnZSuErp2i1EnO9R7MMKos669HDBr7/+B3RAeN8upAh?=
 =?us-ascii?Q?jWIR1H3D8pTLuU9GouNlk3llQwpMbS6u2nrxmZhayixcKroy30qX/2Iykbq/?=
 =?us-ascii?Q?TzlRJPXn5AU9N8lHmWHVNZhnaADc4Tm9VUXGoMqKP0KoZwkdqAu85nrSF5zj?=
 =?us-ascii?Q?MnHu062Api7brkJFvGVSgVxniiKjWiiqXZTmgc89UZ06aNYglpEyesz0rAPs?=
 =?us-ascii?Q?mYXyYOrUQAz30NwuIMawxj+x4siFHew4g9X3gln4PgRsHoMZDLwv58ZyNjeo?=
 =?us-ascii?Q?HUh+tYg16LeYiI/VQtD/acpAzQoNzyWqbba2/2vXgQ9cToLRUoWkOgNMJ/dq?=
 =?us-ascii?Q?qZGt1io5t0TFh0mRGB0GK02bquzNVHZPkceg8foX6QZ9R6Bah7waiJ771Wk7?=
 =?us-ascii?Q?XA8z4qTDmZ6gxom9k/pmezJsauoj2GN9ZZ/Pe5Ps24Ekc5K/RXZTkiaddsgE?=
 =?us-ascii?Q?yT53S9hdAa0fAf0UqLDfDiiVhwlL3ohrKp2cLjtSsCgZF4IB4tjHVDBNxXS3?=
 =?us-ascii?Q?adutrftu3YE4ulWEFfZDh/1NN5z+2L/RVX/PApPJyD6uSkig7D8Nu83QdkKS?=
 =?us-ascii?Q?mvnUifF+CNI4C3tZSyqroBXOMBVegge0SciKcsnK4M/Tj0oLYLBNhGzd/mHa?=
 =?us-ascii?Q?TBl+0mrj+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f25c45-9946-42bd-a528-08de7c15cba6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 06:50:18.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rq1lp4N8v0nv0Y2Kk/r2EX3HSc4Qg9vmzpHmiPR5t99S/q9D6jaSwoyKgg2YjqWQ4tZyfuOLvrMcL7fa3T3cqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695

On Fri, Mar 06, 2026 at 02:23:13PM -1000, Tejun Heo wrote:
> enqueue_task_scx() takes int enq_flags from the sched_class interface.
> SCX enqueue flags starting at bit 32 (SCX_ENQ_PREEMPT and above) are
> silently truncated when passed through activate_task(). extra_enq_flags
> was added as a workaround - storing high bits in rq->scx.extra_enq_flags
> and OR-ing them back in enqueue_task_scx(). However, the OR target is
> still the int parameter, so the high bits are lost anyway.
> 
> The current impact is limited as the only affected flag is SCX_ENQ_PREEMPT
> which is informational to the BPF scheduler - its loss means the scheduler
> doesn't know about preemption but doesn't cause incorrect behavior.
> 
> Fix by renaming the int parameter to core_enq_flags and introducing a
> u64 enq_flags local that merges both sources. All downstream functions
> already take u64 enq_flags.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Tejun Heo <tj@kernel.org>

Good catch.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index XXXXXXX..XXXXXXX 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1728,16 +1728,15 @@ static void clr_task_runnable(struct task_struct *p)
>  		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
>  }
> 
> -static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags)
> +static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_flags)
>  {
>  	struct scx_sched *sch = scx_task_sched(p);
>  	int sticky_cpu = p->scx.sticky_cpu;
> +	u64 enq_flags = core_enq_flags | rq->scx.extra_enq_flags;
> 
>  	if (enq_flags & ENQUEUE_WAKEUP)
>  		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
> 
> -	enq_flags |= rq->scx.extra_enq_flags;
> -
>  	/*
>  	 * Restoring a running task will be immediately followed by
>  	 * set_next_task_scx() which expects the task to not be on the BPF
> --
> tejun
