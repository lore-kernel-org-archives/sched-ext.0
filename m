Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587A3B389C
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349138; cv=fail; b=Qz3uxF8xaldjWc0k1U9JwUddqF+E05HN4VNH2ibEfQsVd585AWcI3kM2JAYZysPBPW9FVCAbymrSViHtngvKxtzVx3/fJj9m2XFQ6Y6MH4SL2zRJA17yrCz+9gL80I5Ncqyl5csb0xLZmSIK1AayRtjJf/k2lMPt3zJpVTIODVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349138; c=relaxed/simple;
	bh=95kaNrVihl+feJyssZkC49XVCW1vEVhIFCiq9TUulG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T3e4b69KrTW3TfbEC6YCTEekVdXgOl0/wMf4IUJBbQ+kcNfI7Ouz8XPxpR20gMP2V+GzS/2th9bE3cXSljBG6qTzQyb8aXJZ0ZJgCcSP91DCz2VIiY+oKRSdRIGc1S+bCo7Nzlj6P3T5uRIPA6Y8KNMEioqFt7d8dZmKcUUXVwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UlKTLnvK; arc=fail smtp.client-ip=40.93.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UlKTLnvK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSN1wtCL4BT2zV6WSo9sGZhio+M0RfhWs/BrA5LhDC+DVTu3WThKt6piERIsgWZegU0w2c4pIb5hylt/kk4FTIC+1J5EHAlVFgwhx0InaeWZvpbabqyX1ydFlmzP0zCLNH9+5EZxWR9P5oQLSNpZ5VGUtUpUaAiVETBCo8F0Q3DoScz/oPtEsbt3HGI7EF9cj2kDuGzi3JEocilOFlTFlf2ohiA6U2kvOrluZjPobdbp5CqD3e7KVW6iQirzet4D1voWKkNPxH7Tz6HPiqCm38Ef4GFM4pD0NEuxDdrjdzn0GN4OgDOAEUaY9I8Kn/VdLhqM8EcfUaLQ4YKv6e8xNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jLQYsrlPIlwJYWEO3Jj07buwTrEHqijenn2BkO4xu8=;
 b=gjzhtm1KD8Ot/ovna3UhMxGsCUT3k7XAHqTNLLJqQVD/4g0EGYHKHYRMieAUZLakITd0gtt8oAhqya2I0yvGnBMDXtOyX8nz3UAdRhFFDC0/2gg+Sh2d8Pq6MTFWTJvUiBQeCQ0PTMSXTwVjiySyGikFIfG/Xp+M3OersrWrHiMYP8jORsKSZi96joALwwlQASqFHmEIilzvgQEDb1uRTZmPaFWDBQA6MG3MlEM1TfC4yMzR3HLyqIcMOaFFm0eveWGwe3d9Y6WZgmbFDF8worP0LpvqG0PtXAbbOBmUd82D4OrLeDlFaEG7HCgM1vqEOL/qWeTrQupnZmvZvwhyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jLQYsrlPIlwJYWEO3Jj07buwTrEHqijenn2BkO4xu8=;
 b=UlKTLnvKZaj0/gajkBANMmB+W2A3gMD8adp2v5ksIMyY6YkMFPlQcd7RNt17BVJEXecNRR0RHwQW0aipAE/sM5swOKOvmwdqsHRxP9QeGMIH/6EpDuWl/HWq/5E+iD+r+d2gUB3GmrNBObRrYNZrFxVseEjzqUD7qRz0wIgE/UTkC0MVboiyoxkOxK8W4mhM///CZU6pJbmi+BrlwrfN1qe2PwOzaXWJLdwOerwnRgXcMHNktnaG873RAJV2E6FppA1RUUSEvP8rWobrwrKV67Fdq5mTeSYZ2GUBuOriQ6hkIVg90+E8KI+QEuAWTfyYD/DpQh2rxZm1jbi1qM4hag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 20:58:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 20:58:53 +0000
Date: Thu, 12 Mar 2026 21:58:46 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 2/2] sched_ext: Update demo schedulers and selftests
 to drop ops.cpu_acquire/release()
Message-ID: <abMpBuWqxHCT__9X@gpd4>
References: <20260312175527.1220540-1-yphbchou0911@gmail.com>
 <20260312175527.1220540-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312175527.1220540-3-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d41fe8-b39a-49f3-8b26-08de807a2b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info:
	ul2JznsjKrcOCxQuPiBrU8pfb0utiO9MZ4kUlOxeLXUSkJ+ON92aZOshwZ32/7kN4cyzXM68vIBcVzDR51tSwuFlndXfOgjsdHrl3OdHFEjqq3taJ2aNUSI6WB60z3ABwT/7ZuEpn8Um5jISMh9+RD2pu3JH1D+XMaV9ZpkzTy7CjHOdxUYI06utv9JS8s6IUIqT4axjyPWnA3KQVbYWzK+FBJ3mLZP6TSUcW/3ZphaWIuEGxvdp30JvyVcZNIWmiV8+MZ0xPY6d9MC1VA599Y2GXzaTcAX0lcJuoJtT1xCNzN+QjIVeyOYLA8wk3iPNSwaJHFZj5UU4/cc6B1L6Ux/FGZboTloxoTg/E28EcOYEUMnI/lHF6+4JHuk7hV+qavug0rWV8+RVmHtNYXiwM75tMNHHZJE5Q0ZDyY/qFBTQvPWL8Jor60CDe0edAHpI2TTXt2f5sZ2VPTLfYuKs1gPlyqaAcj6Vx1LwlTLxTaMUWENAi7LzkKyftpVY9IVqw2sD6luqK8pVtXGAGvDWPeKUatvnXusWI/8vI+5gfsn3OPlXM4dGOX9GCcIr6/6/ni8q2L3YlEiXvOwUp9S+LAFXCK3rJBlyihEfdHAHh/5Aaigb6iGuIouLCGYmv5V//Ig32X/kN7hHcMbhvz+FBaNxvNWXAmwe3GI3hmWit5hXJ/G0w6gSD/yLgwfY0sbnN5EsmdYbcbGD9H1KTh6a5BKQSjCLs/UbjYszAz69bZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(7053199007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AlP6sYIddnaPAMCZ05UDiBsJ6EXvR2a4l1ck6moDvH/yEn13xdfaUeotAcvN?=
 =?us-ascii?Q?FSezjNEgkYyMqzaebtZ8RXXfK8vKZp1huGM1nBzw+dXnCQ/5fKDzIrDVU2Vm?=
 =?us-ascii?Q?sZYCY3PKWgQBBOEHdmQbrgua+MIFkqRIW6WucN73/nyOGGZqAMzuuyrWOTvg?=
 =?us-ascii?Q?ergUu1dvUZ1kZnMdF+IcJS8INoqvj7+Rg0kW5u4u5XoqwO+tLRQRqF6FWJ/0?=
 =?us-ascii?Q?yEPuEtsIB+Lr2LfX9Sgsu7JU9hKe35RjEW2O1at67ldqMN1ZKcFSxxFmntAw?=
 =?us-ascii?Q?is9MwMyY/ZmwT8f1om3Em/xndDFU8UWnQPtfqQgGNj2WrkR7aGQ8OQhdO6bN?=
 =?us-ascii?Q?PGu3QyoXsXrUXT0O4eGr3xYI8tqcUvtIuJjnd0WDXpqgF3phnbzirC0QGoMB?=
 =?us-ascii?Q?ChxNviP/aK0v2TshroSpNwskmASmw1wLUWDTpzyy1SLwA+YFVa5W4YIkey29?=
 =?us-ascii?Q?qqMc5DwgniKhrYL8FNKA+rtz1cDSxw9xkbnF/7BybUkXm5jj8Q/H8Tvnrgmt?=
 =?us-ascii?Q?C7FxqDAVU/qjDDgEw0Azr/lNEKqiJ/dRlpDvAnNOEIK9Avn95nJtqwlgCY96?=
 =?us-ascii?Q?j6AFqt5xw+JIzzTaU5/A0+Y+0BC8U7v0tlD4OPYSjD/hhqZkb62YLGWOx0+F?=
 =?us-ascii?Q?AyJHLBob+gzDDXoU4S+LXSEp+JSLjcCSQ3j+PGlcBqzzRoSosWnoh+gJvFdh?=
 =?us-ascii?Q?zHes7q8xYd7UN49nDrJhpQ1499mA//dHH1DU6S30dEbyCHJFP1NDaNiCYeZJ?=
 =?us-ascii?Q?z3OJdC+8cohF9reYd2pBcSdSzNafO5+3czSnuYlBBqoYAVkBrHe7RNFu0Pfx?=
 =?us-ascii?Q?6ya0mhVobot1Tf4BiFZms4ozMIhqI8ihtTr0WXrAjYk+N9QnIfsLGQfeaRNp?=
 =?us-ascii?Q?RQeqt9WBwNa4jdaAVnajg8B9F8GzKlsmNBNVqxg24oOJlt0yqPNZ7bXfK5X6?=
 =?us-ascii?Q?m3rQpsRpRSVfTvoFjspoYvb8MjWlN0yAee/kKOrmkkxJhzZwFDDzMve7GMwV?=
 =?us-ascii?Q?sFp1R6NaP9fsLbu4XSEsGKHJA/9U3XqIeXfFOSVWhc1kRPlV+QSq2/OmKBSd?=
 =?us-ascii?Q?EkGr4obDiiSXI91o8JsCehMh0zbWv9lyfGhoRoqmsrPGIeomi6b/zQucBxFq?=
 =?us-ascii?Q?JHKmuD1uiWun4acrYW/Rd1UDKJsSerEXGywZFX9QN+74wHqJL7OVDQPYZ9Xv?=
 =?us-ascii?Q?ZoDN6vg04wVWug02ycO7W5nxJxUVXN1r/KeovN49CySH4nPC+5/pMQzFOfnM?=
 =?us-ascii?Q?mtGLlKQEO2+1FQY/drHbxMNP8/62Zr1RC53Lx1+Mj/F/HT2ZHSJ5o56Kwl4w?=
 =?us-ascii?Q?PcyuvZ6CJvdAuQaytKtUbZvNCKv8p48wY8p3Cq0M1poMG20mehJiCxVI9/Nv?=
 =?us-ascii?Q?HbGYT8t0v3BckpK+MgzTBMq/VRCRLdvpZ9mJej5DB+hLnRGBiOb0VBrrRCQK?=
 =?us-ascii?Q?nRqn6uNoKF70GJS2x/ISB9JqIIVX13E+xdv4aL/2qGfV2ch1MtkXURbIwpSW?=
 =?us-ascii?Q?zsA2fDeGQsSeh1rAXceKKNts0n0JQpOJj4xfKos5UimJcUxaSI1QqhH1Uycg?=
 =?us-ascii?Q?Wr/9CSjAzxfuao8h4ciiNYI/KHx+p1OAE40fTsNfxvFDHG503h7Y3kXaxLR/?=
 =?us-ascii?Q?KYB+/qOTe0TflvddhLLDSMZaR/kNZ4kDbgUgBEKzAq4IwVP63N1+W3AbCvix?=
 =?us-ascii?Q?gXjEyE+9kxn3s6UvS91f7vxfyKkaKgJ1abWlabnk424+1eAdjbDJmcMHPmRN?=
 =?us-ascii?Q?Zj1J3CFY2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d41fe8-b39a-49f3-8b26-08de807a2b2c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:58:53.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqN4NWnZmOZ5jz6+kwJK6kHOWtUanzQEikL40ELfkJRe5hDplcRQBk/RkcwsHsIZBbVD5abUDZg/5zaRwuJbkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

On Fri, Mar 13, 2026 at 01:55:27AM +0800, Cheng-Yang Chou wrote:
> ops.cpu_acquire/release() are deprecated by commit a3f5d4822253
> ("sched_ext: Allow scx_bpf_reenqueue_local() to be called from
> anywhere") in favor of handling CPU preemption via the sched_switch
> tracepoint. Update scx_qmap and the maximal selftest to use the new
> approach.
> 
> In scx_qmap, remove the cpu_release fallback and the
> __COMPAT_scx_bpf_reenqueue_local_from_anywhere() compat guard from
> qmap_sched_switch(), unconditionally handling preemption via the TP.
> 
> In the maximal selftest, replace the cpu_acquire/release stubs with a
> minimal sched_switch TP program. Attach all non-struct_ops programs
> (including the new TP) via maximal__attach() after disabling auto-attach
> for the maximal_ops struct_ops map, which is managed manually in run().
> 
> Apply the same fix to reload_loop, which also uses the maximal skeleton.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Looks good!

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_qmap.bpf.c                  | 15 ++-------------
>  tools/testing/selftests/sched_ext/maximal.bpf.c | 15 ++++++---------
>  tools/testing/selftests/sched_ext/maximal.c     |  3 +++
>  tools/testing/selftests/sched_ext/reload_loop.c |  3 +++
>  4 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index a4a1b84fe359..a11e27c8de77 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -11,8 +11,8 @@
>   *
>   * - BPF-side queueing using PIDs.
>   * - Sleepable per-task storage allocation using ops.prep_enable().
> - * - Using ops.cpu_release() to handle a higher priority scheduling class taking
> - *   the CPU away.
> + * - Using the sched_switch tracepoint to handle a higher priority scheduling
> + *   class taking the CPU away.
>   * - Core-sched support.
>   *
>   * This scheduler is primarily for demonstration and testing of sched_ext
> @@ -562,9 +562,6 @@ SEC("tp_btf/sched_switch")
>  int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
>  	     struct task_struct *next, unsigned long prev_state)
>  {
> -	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
> -		return 0;
> -
>  	/*
>  	 * If @cpu is taken by a higher priority scheduling class, it is no
>  	 * longer available for executing sched_ext tasks. As we don't want the
> @@ -586,13 +583,6 @@ int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
>  	return 0;
>  }
>  
> -void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
> -{
> -	/* see qmap_sched_switch() to learn how to do this on newer kernels */
> -	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
> -		scx_bpf_reenqueue_local();
> -}
> -
>  s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
>  		   struct scx_init_task_args *args)
>  {
> @@ -999,7 +989,6 @@ SCX_OPS_DEFINE(qmap_ops,
>  	       .dispatch		= (void *)qmap_dispatch,
>  	       .tick			= (void *)qmap_tick,
>  	       .core_sched_before	= (void *)qmap_core_sched_before,
> -	       .cpu_release		= (void *)qmap_cpu_release,
>  	       .init_task		= (void *)qmap_init_task,
>  	       .dump			= (void *)qmap_dump,
>  	       .dump_cpu		= (void *)qmap_dump_cpu,
> diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
> index 01cf4f3da4e0..5858f64313e9 100644
> --- a/tools/testing/selftests/sched_ext/maximal.bpf.c
> +++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
> @@ -67,13 +67,12 @@ void BPF_STRUCT_OPS(maximal_set_cpumask, struct task_struct *p,
>  void BPF_STRUCT_OPS(maximal_update_idle, s32 cpu, bool idle)
>  {}
>  
> -void BPF_STRUCT_OPS(maximal_cpu_acquire, s32 cpu,
> -		    struct scx_cpu_acquire_args *args)
> -{}
> -
> -void BPF_STRUCT_OPS(maximal_cpu_release, s32 cpu,
> -		    struct scx_cpu_release_args *args)
> -{}
> +SEC("tp_btf/sched_switch")
> +int BPF_PROG(maximal_sched_switch, bool preempt, struct task_struct *prev,
> +	     struct task_struct *next, unsigned long prev_state)
> +{
> +	return 0;
> +}
>  
>  void BPF_STRUCT_OPS(maximal_cpu_online, s32 cpu)
>  {}
> @@ -150,8 +149,6 @@ struct sched_ext_ops maximal_ops = {
>  	.set_weight		= (void *) maximal_set_weight,
>  	.set_cpumask		= (void *) maximal_set_cpumask,
>  	.update_idle		= (void *) maximal_update_idle,
> -	.cpu_acquire		= (void *) maximal_cpu_acquire,
> -	.cpu_release		= (void *) maximal_cpu_release,
>  	.cpu_online		= (void *) maximal_cpu_online,
>  	.cpu_offline		= (void *) maximal_cpu_offline,
>  	.init_task		= (void *) maximal_init_task,
> diff --git a/tools/testing/selftests/sched_ext/maximal.c b/tools/testing/selftests/sched_ext/maximal.c
> index c6be50a9941d..1dc369224670 100644
> --- a/tools/testing/selftests/sched_ext/maximal.c
> +++ b/tools/testing/selftests/sched_ext/maximal.c
> @@ -19,6 +19,9 @@ static enum scx_test_status setup(void **ctx)
>  	SCX_ENUM_INIT(skel);
>  	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
>  
> +	bpf_map__set_autoattach(skel->maps.maximal_ops, false);
> +	SCX_FAIL_IF(maximal__attach(skel), "Failed to attach skel");
> +
>  	*ctx = skel;
>  
>  	return SCX_TEST_PASS;
> diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/testing/selftests/sched_ext/reload_loop.c
> index 308211d80436..49297b83d748 100644
> --- a/tools/testing/selftests/sched_ext/reload_loop.c
> +++ b/tools/testing/selftests/sched_ext/reload_loop.c
> @@ -23,6 +23,9 @@ static enum scx_test_status setup(void **ctx)
>  	SCX_ENUM_INIT(skel);
>  	SCX_FAIL_IF(maximal__load(skel), "Failed to load skel");
>  
> +	bpf_map__set_autoattach(skel->maps.maximal_ops, false);
> +	SCX_FAIL_IF(maximal__attach(skel), "Failed to attach skel");
> +
>  	return SCX_TEST_PASS;
>  }
>  
> -- 
> 2.48.1
> 
