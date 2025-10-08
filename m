Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0EE1E25F9
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759962274; cv=fail; b=jhOSqt8joqsoaH13SZz9txzbsG3A5Nuzhxi9OctwMdQgGxJorbt58SURqJtsQfPMIeQVOgtX9PA4qkecveYFd3C5CYBVIjcNS0deVZVltaZ8x+NLdqM5tYaqnQ2HsVY7jbtBPx671jXY1Paj/0AuZvfngwSteol1QWz0COCo1dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759962274; c=relaxed/simple;
	bh=KcuhxC7+rYUs97t0mVttJQMUhaFzfw67Eo5na0Zs4gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ptTG65fspX8rTe3LJ8RHk8XpbzAqORuq5jVjrPZTcowTjcgKFlk2IujRXbne3m4/IU9zy44/IjMvU06QtciU/NrclMS7s4Rx+8Sjdke1RIFSmNd1GJgN2R3kgqSoO2FQHanbPbwRLxKS7U6VgALTsU9oiBLZfY8BiMnuur9OUGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VrhPZq2N; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VrhPZq2N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2Q+Ra/b/Kdunwhe6daLJHkCTqd3R8rIEMPC4S9ahpuyOpgqef0viaoVV28R8Ar6Huvgwnq8nFyevRR2JSP40Ps090KiGfb9CwSDOLHVcpAKoRJairve+Tega89qetglt+T62FOhYdYygsqNW+clZP2EQ5DaGb+iP+vFSmaIL3gDDJQ01J5QSHRNWEAubSSLBB84CVOB8ot3uXexos57l6BJtjuVfLkHNMnngS3FMQizyYWuXNSeIyKfl/XeOpOwgXOGZxZOphW4DMAGZ2szqhI7sfH4ap8dTkNvTXoDYfRhwCOighrvfL5MUOgrL0O4ClswtNgRXBMN6zAezesaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKgnOwKvqZ2DVJYcBhb1RBHqodXN7ENk6tyxF7+6t5g=;
 b=NDm3osbIIekHbNRXb3xv7KYHrN8tNVmEMjZo1sh1Q/yWzLpbhWYyo+EUFzmTp6NfvhFtCTffzMrntYdbQ8z44JBA2UVZgFs8KuQvOfXE/BLxdpLQAGPB9nRhkoykJRBBcDqRez7r4t+8WORk11rX7LgBxusGLqzvXwdrb9ivpT6pbX0c3YLGzXf8oY4RN1uBekVrvFF8XALIX6hXycKoiLvBiUgU7U6q5BUhGfyfDXjZQbF2RIpzkzO8+jIDQfUp6qgI39P8/J7WFLkluEg52TQbjHp30j981XThB11UHFYUEuwzM8idjDCnBL3Nv+tOsSJA3CaoPE/Q/O7yo22LBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKgnOwKvqZ2DVJYcBhb1RBHqodXN7ENk6tyxF7+6t5g=;
 b=VrhPZq2Nv8V6Ui7ouUUYAZydRCDhE27InPri57woNd7TKp1t13KSGQirb+H2BMOk2EvdsPVpByzS5NCD8kv+Uk+zx79HzGHc0FcktiawNJCGaVlu0NHoqaP0hOtgGPzbyb/suEJt3PC2I0WLN3WBn5KbPgLF1x/cXmNZ4kvbLxJx7ChpX13flNhOg8th/X31qlU9sGRaMUN1msbpld+0p0Ez+kf5KA3yhrBY8lN95dVrnBP9bAtOurRMxn8hpqv8Psk3pPgZHZhNysoQeGCvetqE45i91ZzX+hkMKKLoEfvddY709h3+GTsbXk5+p8K3GAn/4I8gKcyIj726Sgffeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 22:24:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 22:24:24 +0000
Date: Thu, 9 Oct 2025 00:24:16 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Phil Auld <pauld@redhat.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily
 using kvzalloc()
Message-ID: <aObkkKf_UCHySRGz@gpd4>
References: <20251007133523.GA93086@pauld.westford.csb>
 <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
 <aOYAV2ZQvMt5aZxu@gpd4>
 <aObPQF1-o-Uek7bd@slm.duckdns.org>
 <aObcIMFpUoMy7vJI@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aObcIMFpUoMy7vJI@slm.duckdns.org>
X-ClientProxiedBy: MR2P264CA0153.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0a85df-6c5e-49ef-ff4e-08de06b96f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A4daX3O+FnYeK82nCnCbaxYf11h0i6HhoqApJsc4Qr3SoI3flD36FIQbpHxn?=
 =?us-ascii?Q?7adgM7iyAxAggOzdiKw7aY/gzmZubapSoyNpXnUrYUxk+vuO1dDKYzypRAYf?=
 =?us-ascii?Q?wV+U0SROjfrU66nm4a3/v5O2Yx7uGG9iIMpW+umWkmwIQxcfZeN4aVGuYbrx?=
 =?us-ascii?Q?Yv8F9FB9Dh0jGs39gCpOqsghreehwtvcCcN0WYAxRxYrdW1QiMaX5x/BM+la?=
 =?us-ascii?Q?y7S+/1Px72MKAyCG5fRr/fd2adu//FnworS2DZDfxjU6j8CdPGZbL8exS3zh?=
 =?us-ascii?Q?ItZe0WOJWWkEPYS83iSwsnUny/wop28do81J0Ev6kncP0nMLrl1ShEXUTvbt?=
 =?us-ascii?Q?+vSBKF2+UO7vjyrY5wDReKm6zYESB9OnGgBXiiRsVllUOkDujr00B1PJIBAv?=
 =?us-ascii?Q?V2uHwHEQNBGWCikVZ3TPmMCoMSgZXeYiUQZGVLWeEGnv0v+ThemisQOT9lFl?=
 =?us-ascii?Q?XIikTPtVAqgAozwonTC97LCjzf1QQuF3ONRlIZ1JnR6ZyuU8jbIMd1bX5VRP?=
 =?us-ascii?Q?BAVUw6zurWgHZ5zL/WhZ9ihmJtrEPFkvwFh9/v3bx85V5DGhEW+mHA/PYyqk?=
 =?us-ascii?Q?ITL4D7aM7kiSB+sQxxDvs3/wHJicKWaPRJLHcTQlKRVo7IoqX5Oem19rtO4d?=
 =?us-ascii?Q?vxIpHA8cZ4t/ZacIULtwugacjZ6BStvqpDLeMDgKbKfUwVHdL2ElVAkjBAvZ?=
 =?us-ascii?Q?lnz2huSolL0bw2Aaid7k5wbaPlamdenrqUgYszlYXrHx/YtOASMr4tv24v4j?=
 =?us-ascii?Q?4D5sN0vdtpWbm9wISx6aCBpoRqii3lx07ifpkMDBBnbrCd/gas+5Xeqvvgjl?=
 =?us-ascii?Q?9/xn64uT1nGfSFcG6qYLjj/CByvB3piLbgCmzd73jbbquDWRW78pdU1ACAGi?=
 =?us-ascii?Q?wisGSjJpI/CE8ZsUKo5NHoOWgU33/kYsGFJga/Fq8o3rXoTcQ2nYuEZGPp2V?=
 =?us-ascii?Q?+1Mz6KSiw8F2Dph2312aIVymfu6lxI90sNtMZ/GDjyss4PoHVQ2Huef8R1g3?=
 =?us-ascii?Q?p04LZZSRPqviMMj+1TeNnMPcWQF7zO9Bk1EGxcS/rhqJ+szwD581kCoq+FOX?=
 =?us-ascii?Q?m28BKnk4GpnhgP2iZszwc2o09I2jEEFWQOgfH7axXy326tgj9/GDAnNs9Z5a?=
 =?us-ascii?Q?BdokWkILl8+Cduv9RVyW4XqhYhSUMjkD3JkAPPt3RsCUPmOzZQToahaPWxGA?=
 =?us-ascii?Q?GH5SbitS+Ho3RxrSrVH2G6pdq0r1m+Oe7Grrt4LSiHHS+yobirYWlH8hAO3k?=
 =?us-ascii?Q?CXsa1Vz5orQ0zMQYKLbeODFwTvYU4VGyApr/jD7t+ihucQc7NtuSOL68kaxk?=
 =?us-ascii?Q?pwSmSn0YO9+wKhtC0EfB5jZxhvOjoAjdkla+80XGAxLTr8gKrP3tTx6N1LfC?=
 =?us-ascii?Q?C5XoXG6BxR5SxuDcBJNTl4fa2rKI2WdBvvYdkLMjvidcc2UuRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0EUxDRlgg31aolDAQhpjQMoOkbuxoww2KpYDCmtrpeFsCBrIMDziemeO3Orz?=
 =?us-ascii?Q?78tv3TLGrUSu3yt7WcF2rI9WCJMYN5URO0sI0XzWH63p28Quo3I2cCAwBVir?=
 =?us-ascii?Q?ne5HgvFBPxHR+X8neuvGjSkNnKljKie2d6FS73ilGrfKt+GC9TBJ8ZgBgAUd?=
 =?us-ascii?Q?a6TpojOjqQo8VwvZChgQy9Te0CqruH8ZS41gR+LKRBjF+Vp+WzMfCEE/BXzR?=
 =?us-ascii?Q?2FXQq88IiI72upZAtdoGSnJUjV+JvKQ9KDrvijyZLOgdhhwAV+EvIVNoYah5?=
 =?us-ascii?Q?hf42PadCK14iJkM+jNTwKLpXmuQ/BfWrAdj9ThMFYdUP2TlGcClNciVSpY9B?=
 =?us-ascii?Q?W9D0BBMpNhrVzEyOO/PZFb/50HWfN502RcIhg/hQPobUO0ZSxnO+l7EnC0MP?=
 =?us-ascii?Q?KcdwcPIAiJHiBGR8JzeVc1VcK3zAbIcx1MOnfiPgenmLo+SEUCMPndXvlc0T?=
 =?us-ascii?Q?1ATNa+f39+VLvPmr/X20MX+vyLFB2yeNh3L9KaLrXpNa0X2VgOZF9+TksAj9?=
 =?us-ascii?Q?zFMVvmrDkR5PgbIvce7SAZPizvv6snf+DrirXzgEt7uPpl62luwGj/CLAccj?=
 =?us-ascii?Q?+icOiIjpneBL7wMCZt05zUY4yJE6hDPvOixZ9RjInl5O++Qy4U1MT6ynKvLn?=
 =?us-ascii?Q?3DjQzG52eABnqwBfo+PTOfndjPtKSkvit6j2MYGf5z4wRBvgktxW8yKaEzyj?=
 =?us-ascii?Q?MDDdYuYXlc69jntwiRWkzZ1ByzptcAfojm4ew6pnNgVuHkGT/NiztiDA7z3g?=
 =?us-ascii?Q?Ac6IUvHuVcgeWgQNliuOddKSmxp2mbgZjQWRyxMzr2GtPK5wtHa6Tzo6ZY4d?=
 =?us-ascii?Q?KEiBF+8VMW8AHWpRDfFctBBMogfVoqpeuP/JrX9IR6qyiJ+a2XItCXcweSeR?=
 =?us-ascii?Q?/khakmL5VhuR0KXy2meQ6dMDwSsUXaogMOIWDRhQDlQa9PDawSLKIvAs/dXk?=
 =?us-ascii?Q?al0iw5QpByzFsTqB2yDBm06IY3v7vVLiH4DRFeEejbo+vMG91OchRdbe+FbH?=
 =?us-ascii?Q?sBKlXKUi3891ch5eaxaydqCEJfsKalESfAoV+cmx9EAeB7mWWoJi2L+bKXHm?=
 =?us-ascii?Q?+s5HQLVj23z6bjqmTndsMoFQca1Ht0148htvd3ZTGRd8y1l0tyc2xrlc4El4?=
 =?us-ascii?Q?eZh0W+YHFrJ3gqySwLD7Y2Puawdmfruw/txDY2cqHQ9/vx0v3NGcMbVwQ/Yh?=
 =?us-ascii?Q?wRaMvSI9+iDIjDNM1HF59c7bEjv1F8h/56knl8Hsb22mVXK8dQZMOlaazAe5?=
 =?us-ascii?Q?3juwmTFEzvVK5sLq1XhHS7XGMLN6LgddEE40pqeOppyBAbmV637DVBbqdCad?=
 =?us-ascii?Q?quLs7YtD93Ay9xEclj72UfpFmzu3H2xtXnHYFHW3hUcMzODY5VGsyZxnTDph?=
 =?us-ascii?Q?bxLquowIKSN3YC55fcjyWAbp3U/P4Ue7/qvQRn8N4CjVDQlFk0YpTCbWkAjh?=
 =?us-ascii?Q?smu6LEFw+QI0/QqYBERF/z0eZ00kyK6qqD733DRlxHqk3uwcjppomJx1rfoT?=
 =?us-ascii?Q?vZBD7Ap9Vxoyo2RiDEnixpqwRpZM8bvkrNF/Z7hXXI3QinVBoCVORdT3pwA4?=
 =?us-ascii?Q?zKPK6yLfpc+umrfBZXHblPredme0jZYujJb/aw6S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0a85df-6c5e-49ef-ff4e-08de06b96f91
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 22:24:24.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orCdnF+N47psoxoqMz7AwP/h30Q+QQGG6sfy/WxHBTVQCxMxMrdMFhfNg+7HpEgFsBa4daV74P7+4RHrC97/7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450

Hi Tejun,

On Wed, Oct 08, 2025 at 11:48:16AM -1000, Tejun Heo wrote:
> On systems with >4096 CPUs, scx_kick_cpus_pnt_seqs allocation fails during
> boot because it exceeds the 32,768 byte percpu allocator limit.
> 
> Restructure to use DEFINE_PER_CPU() for the per-CPU pointers, with each CPU
> pointing to its own kvzalloc'd array. Move allocation from boot time to
> scx_enable() and free in scx_disable(), so the O(nr_cpu_ids^2) memory is only
> consumed when sched_ext is active.
> 
> Use RCU to guard against racing with free. Arrays are freed via call_rcu()
> and kick_cpus_irq_workfn() uses rcu_dereference_bh() with a NULL check.
> 
> While at it, rename to scx_kick_pseqs for brevity and update comments to
> clarify these are pick_task sequence numbers.
> 
> Reported-by: Phil Auld <pauld@redhat.com>
> Link: http://lkml.kernel.org/r/20251007133523.GA93086@pauld.westford.csb
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 88 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 78 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..217c80d0105c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -67,8 +67,19 @@ static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
>  
>  static struct delayed_work scx_watchdog_work;
>  
> -/* for %SCX_KICK_WAIT */
> -static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
> +/*
> + * For %SCX_KICK_WAIT: Each CPU has a pointer to an array of pick_task sequence
> + * numbers. The arrays are allocated with kvzalloc() as size can exceed percpu
> + * allocator limits on large machines. O(nr_cpu_ids^2) allocation, allocated
> + * lazily when enabling and freed when disabling to avoid waste when sched_ext
> + * isn't active.
> + */
> +struct scx_kick_pseqs {
> +	struct rcu_head		rcu;
> +	unsigned long		seqs[];
> +};
> +
> +static DEFINE_PER_CPU(struct scx_kick_pseqs __rcu *, scx_kick_pseqs);
>  
>  /*
>   * Direct dispatch marker.
> @@ -3850,6 +3861,25 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
>  	}
>  }
>  
> +static void free_kick_pseqs_rcu(struct rcu_head *rcu)
> +{
> +	struct scx_kick_pseqs *pseqs = container_of(rcu, struct scx_kick_pseqs, rcu);
> +
> +	kvfree(pseqs);
> +}
> +
> +static void free_kick_pseqs(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
> +
> +		call_rcu(&(*pseqs)->rcu, free_kick_pseqs_rcu);
> +		RCU_INIT_POINTER(*pseqs, NULL);

Is this safe? I think we should replace the pointer first and then schedule
the free via call_rcu(), like:

        old = rcu_replace_pointer(*pseqs, NULL, true);
        if (old)
		call_rcu(&old->rcu, free_kick_pseqs_rcu);

> +	}
> +}
> +
>  static void scx_disable_workfn(struct kthread_work *work)
>  {
>  	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
> @@ -3986,6 +4016,7 @@ static void scx_disable_workfn(struct kthread_work *work)
>  	free_percpu(scx_dsp_ctx);
>  	scx_dsp_ctx = NULL;
>  	scx_dsp_max_batch = 0;
> +	free_kick_pseqs();
>  
>  	mutex_unlock(&scx_enable_mutex);
>  
> @@ -4348,6 +4379,34 @@ static void scx_vexit(struct scx_sched *sch,
>  	irq_work_queue(&sch->error_irq_work);
>  }
>  
> +static int alloc_kick_pseqs(void)
> +{
> +	int cpu;
> +
> +	/*
> +	 * Allocate per-CPU arrays sized by nr_cpu_ids. Use kvzalloc as size
> +	 * can exceed percpu allocator limits on large machines.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
> +		struct scx_kick_pseqs *new_pseqs;
> +
> +

nit: extra newline.

> +		WARN_ON_ONCE(rcu_access_pointer(*pseqs));
> +
> +		new_pseqs = kvzalloc_node(sizeof(unsigned long) * nr_cpu_ids,
> +					  GFP_KERNEL, cpu_to_node(cpu));

Don't we need to allocate the struct as well? This should be something
like:

	new_pseqs = kvzalloc_node(struct_size(new_pseqs, seqs, nr_cpu_ids),
				  GFP_KERNEL, cpu_to_node(cpu));

> +		if (!new_pseqs) {
> +			free_kick_pseqs();
> +			return -ENOMEM;
> +		}
> +
> +		rcu_assign_pointer(*pseqs, new_pseqs);
> +	}
> +
> +	return 0;
> +}
> +
>  static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
>  {
>  	struct scx_sched *sch;
> @@ -4490,15 +4549,19 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  	mutex_lock(&scx_enable_mutex);
>  
> +	ret = alloc_kick_pseqs();
> +	if (ret)
> +		goto err_unlock;
> +
>  	if (scx_enable_state() != SCX_DISABLED) {
>  		ret = -EBUSY;
> -		goto err_unlock;
> +		goto err_free_pseqs;
>  	}
>  
>  	sch = scx_alloc_and_add_sched(ops);
>  	if (IS_ERR(sch)) {
>  		ret = PTR_ERR(sch);
> -		goto err_unlock;
> +		goto err_free_pseqs;
>  	}
>  
>  	/*
> @@ -4701,6 +4764,8 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  	return 0;
>  
> +err_free_pseqs:
> +	free_kick_pseqs();
>  err_unlock:
>  	mutex_unlock(&scx_enable_mutex);
>  	return ret;
> @@ -5082,10 +5147,18 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>  {
>  	struct rq *this_rq = this_rq();
>  	struct scx_rq *this_scx = &this_rq->scx;
> -	unsigned long *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
> +	struct scx_kick_pseqs __rcu *pseqs_pcpu = __this_cpu_read(scx_kick_pseqs);
>  	bool should_wait = false;
> +	unsigned long *pseqs;
>  	s32 cpu;
>  
> +	if (unlikely(!pseqs_pcpu)) {
> +		pr_warn_once("kick_cpus_irq_workfn() called with NULL scx_kick_pseqs");
> +		return;
> +	}
> +
> +	pseqs = rcu_dereference_bh(pseqs_pcpu)->seqs;
> +
>  	for_each_cpu(cpu, this_scx->cpus_to_kick) {
>  		should_wait |= kick_one_cpu(cpu, this_rq, pseqs);
>  		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick);
> @@ -5208,11 +5281,6 @@ void __init init_sched_ext_class(void)
>  
>  	scx_idle_init_masks();
>  
> -	scx_kick_cpus_pnt_seqs =
> -		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
> -			       __alignof__(scx_kick_cpus_pnt_seqs[0]));
> -	BUG_ON(!scx_kick_cpus_pnt_seqs);
> -
>  	for_each_possible_cpu(cpu) {
>  		struct rq *rq = cpu_rq(cpu);
>  		int  n = cpu_to_node(cpu);
> -- 
> 2.51.0
> 

Thanks,
-Andrea
