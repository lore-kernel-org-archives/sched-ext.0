Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A50335BA
	for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058390; cv=fail; b=CTjrNqboesl0m9uzyM/QAK0T+K/QQExhtRMH13NEYP7Wp/qAs6kOhl41J9N/ad6Eto/svIczuizKoKxvErY3hW54naVza8eja/azCUEbYPCRZ+FP5q5J8P88YHIUFYJ7JppHQnr2RwQ3r+qawFoy/1S7+NTqPyN5JjMi3SEFFUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058390; c=relaxed/simple;
	bh=aFnAEfk4T5fB9ISblLOIjIPfIR27lqXjF5tfLxBMGZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pGuhExDXTxaSVB6kl3YGfvvF9gK8wlC92ZSBOS0jIlkIFCADzmzWALUweQgLKktgh91GYxmEMxdgW8cWUNDp8ANpOBUQYUUUYeIkb6STMm447+4tUlref1MIr0KgS8oQhHTTR7qi/rXi3Lv+DVb5qEVW5shx1JMYmKxU7Nre+/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECr2B/ur; arc=fail smtp.client-ip=40.107.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECr2B/ur"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+dMxX7rVlOGkoaQlV6bf+RehWV08LSXT7FRPLf6mLgyHFN+P41I6G1fE82xb33CzxgXkKX76klZ1V4JakhoP8cZo2yrFa2mv3LQlyetnbGxQtg0pbtwiCW/de8RDLSh1uKXiHGX9ofuadKUISzjMkHLREVHeQo6CEu7fANwGaS3pFrABpoiwPMjsWOBHAIXBDclyDq4/yHe93T6wCG2hL9stdPmgMam7eMlJMcoWq38bF0YkfcNZx77fJiQUHkDsxaamFbcNlSn2e9h3pSRc/4AX846GaGa29GRKyWm6kFdA4zqmFmct6Eb7725bDswfZq5pEpjdS6MHc9S9bw7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP2vJbq2SSmAagE9ZPTS6vRWLihI2Yf+VMMK3mFGyxI=;
 b=EG0ZM+NN78dAHB+uPUW7l45LDsJzQ3efEPdDiCP+/CvUgDdnVN+DqSKYlIwR7o1c7OXPRXkDuH7FCtskmFiR5E+HzLwJjVzRBfBCbcLHTvT6gT+rK3Qq02n1xH3MQGijQqaLqDlI0upU9pVgdm666kaJgB2knrM7AozF3YuraZVJi/liqF8fgFUi1LxVaXBJuDxbT03qgdzjdgXMTHsUMXom7aMzJhLglBNm+4vYZ3N0En8eGmBz8JNyd7v1Odg0ldygjhxl61WVBFtsxsLYBbaq6z7iOb2POW5LuKXK9eNegmQPMo1o71owJBt5FDuMWcHEdZQDFwSD+wnzNSm5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP2vJbq2SSmAagE9ZPTS6vRWLihI2Yf+VMMK3mFGyxI=;
 b=ECr2B/urj05jUaCCNL0rRCF8aRRZYkktbHpTmKXTaKyRuXJWXuPVPyxyUSH6y4HoYmxhBvRPQO29Whg52eH5JvUzT0reCm8M+GLuhwwOxZO7veGbGkrsHnPURqOo+SsVKSenX8fLrSPolPYusp+kKmdwWuiilMPn/6b12a4ytvVLtm8jKe4XtQwutEJpChKpbBwS+qzhMBkDEFjdfRMUGV6tC0+m3ZSpM13nxHfasrz5d0PGlPStWzzOlFcFPl9YWDAt+PAU9JZdoFRnnLL2DjBHSjCcxJj6q65TPguRADwvTLAyVQfFnwaGp4yMpO7s3szJ68A8muCneUMwcgDvmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 05:33:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Mon, 13 Apr 2026
 05:33:04 +0000
Date: Mon, 13 Apr 2026 07:32:56 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Kick home CPU for
 stranded tasks in scx_qmap
Message-ID: <adyACFXObn1rZNPh@gpd4>
References: <de52a1c5537e2a130d19eb244b7606c1@kernel.org>
 <9e172bda49dade833db7118929332693@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e172bda49dade833db7118929332693@kernel.org>
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 4303b332-0db2-49a9-dd01-08de991e22d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|11006099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tzMlkYGVzv9iAtZv4BYVyIXeKeiTC6tiSDJATNDyfuruwacSTDKLSg/I9c/2rMYUfbocFckdb9S5WnQvVFTIe+B76rrfJUiA6Nky7wQci+Nj3gb0Z0iWzl0E/sl5UkCSBJ3HmseTaxwRzPuWujEkJs1X2KrUDY/AFNiU9XNfURf97gWFE/i3/LuwofnM7yxi8HJJOFrsz7ZLI2rlMv13t4FXczGb+nDvIPOcK7RLlRhblrD4grpu4C5niUGM5A/XlcB/SNwfNA6pZwXWNyW51+Ql6PSiwIfbFGjt+avO2ZBQAab+IYPgTzTU7zholZbD4dSAjhixTdsglbqh/eP37b4j5dQwTAXLLN40GZUe/O96L+8kZLYW0KUZJeLCXhH5pZHQ0DeLeQ2pLO3fTFXXyAUcE8sQiu9urngscAQgIAN1kyYI1WIhLBpxREoaEsG8Isum4FMiLeVcoWST6+PbOfQX6cMGWJVp9eqM/WUE6O+NEZPK04z1nBkhfmjrmx30ldkk70C/UY0eO0AbCgmZL0HUvRQCn1YFqdwQCAkp0xpHLoXnHUCS/dhMILyGm9zjuJTU4u/XpdSdvjHuXENHuJ19zz2fCP1fA07MLhGZqhkqWjsv7XVfoWOPxIdkEmSsiDvDo3OPE3EQiKs7LMo2eXG3fRP62Wi6XoSLiCv/P3ASXwBE1S/UpG6ObzaCdh39OPXCZOwX7oe6imR1F+5bOAWpoQe0qM+wwmiz7HerBAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(11006099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RUt3FHkzr1i0/gTFCfnmhdgLgY+0QP1zZYyXw0Iv27hmnf17cRb02/F494HT?=
 =?us-ascii?Q?JM/IwEAcKs8llH8yIrxNQA3G2n5eNnsKAPd/E8MAEg7zVZ7PnB3pTmtlYeq6?=
 =?us-ascii?Q?FRpHPngua9AKQxc32qqXcTOvoHMR3JiOscw9hTtc5sW/4DQ4OI/4AXZi61es?=
 =?us-ascii?Q?HkS8UlU8ZH4LdDuOApt8jvspUmzA0RGEVbXlOA7s9p/CWgmWiLWLxm+b9bC1?=
 =?us-ascii?Q?8Rdnp2ZHI6VnStGRLxZjM35Y5FisYkhh4K8BpJEl9PSVWIgrV9FxTW6EsyCv?=
 =?us-ascii?Q?7704ARRQYgP52OP9atuFYLV/C5/LCwuHZP34ADyu4tk7AiWS6W4LAlXlge8P?=
 =?us-ascii?Q?vqi4Lzn6JA1bZn5NEWBZPywW7/v/YfhOEjq/uZuv4A2TFGg+IpILsBMJnqTZ?=
 =?us-ascii?Q?LoAAmVo8qrJqWJUlFFgSXYaNACp+nrQVTXTrTJlDhZg+5VC9vw0cHNaSnzAN?=
 =?us-ascii?Q?at9xf0ywM0FvWpUM61Pvrqg5ll1fHtrYryf2ZZBipIVGLoiR3SU9EAFzACWC?=
 =?us-ascii?Q?2r+hiR3u2ijaDjTK3DKexIntmPcYKYWuRhkjY3x9DLh+sY+KM/YrN2ol7dRu?=
 =?us-ascii?Q?csR/sAmJKLm7O2ir+DIXWZdTwwOlBtZ4fIchpgWzoSuwdfnFZHEuhiA3p+lZ?=
 =?us-ascii?Q?ohHphnN4CcsfeIHhRSG+8fZjdK7pTfPgFxsN6nHd8pIdFmdwqbr1xwz08m9y?=
 =?us-ascii?Q?j14G6J108wKQQV4uYvZX68nFN0DqDg7rQg5N8pBPgo+9HWm2jUFASh8lFj7k?=
 =?us-ascii?Q?ti42iIo7nOstyv+AwftQtETlpREbfjOtm9j9h8fNclSKGiSvikh0wyEQZRG5?=
 =?us-ascii?Q?TJCUObvo3vWKH2kyN0PCOe4bJ9E/BULP4ndfqz34+1TupIUMhgkGaVLzsUl3?=
 =?us-ascii?Q?2iV/QVwT/SE3qso/AUEYx8tVWY0DZpI+ZgwqCv+lxaAImqjETTAzibO/GFst?=
 =?us-ascii?Q?waD22Bjj/+41J1HdYbJw2wPaERHXjPsLaW5e11TMS3tZbeyUmInuioRsbYR+?=
 =?us-ascii?Q?jHL9aezzj544fYjjfLJO4Ikqnpr4L+bSIoRP0tPt3xRrcFQtP2A92L4x6Zjn?=
 =?us-ascii?Q?8Mm1xtJpitHTYRlSSHBrA4w3PulC9BhWl4TyV27+A/jvyKQtdX2Y50aCeeQM?=
 =?us-ascii?Q?3WGe70uCdfOkBWKbWQ0htuq/lchmjLxe/nETYjGm8DpaL03nDqeaTz6wJ/AZ?=
 =?us-ascii?Q?qj4JMexEZHqOYDdUoV96/2vBQp8H0f/ctAmlfzfJMI5aRkOTfBgAwOpGGpQZ?=
 =?us-ascii?Q?SP6i1nIGzuCLbHdW5thdAZ06ve1abkp+JfqkwJdtYeHq5lWCfHUj2TahrcRi?=
 =?us-ascii?Q?FsiQhxElqT0Ck5HWLIWgWVpS9DNRocLZ+r+E6kw70RgULpGing652ri1xdyD?=
 =?us-ascii?Q?3U56hGnpUhj4MwdTZ5UWYnxRFCxJXnaBQ0q7QC3Eq0Nh1SwxfmaQyP6tBLt5?=
 =?us-ascii?Q?Z2yEEgXUtzr2C2IGLvzrXFGwIi626A89lX6qkAQUyG31FfmM4SNCxS27zshK?=
 =?us-ascii?Q?lweTm6Ar+eymwB/XF09ICh1GPe/Th+yuVLABaNf80YtRso8F1omHuqPiOoLr?=
 =?us-ascii?Q?J0cRPfyJ3xLckpez0cGnar6K1oTMLHvWu/gM08vJZInJCpVZoWb5z5H8Zv2R?=
 =?us-ascii?Q?dOH6SCnrnQAc0KLXgEqRywFlmXeNaA3Le6SW25cFO/axqJa3+oAbzzwEC7/c?=
 =?us-ascii?Q?+tylbuo7cUhufyWG+PCux7Si2Uxi4Q/HpgkoIqQ/L7hG+/klkTSd1f8z4gmK?=
 =?us-ascii?Q?ezObZnRayg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4303b332-0db2-49a9-dd01-08de991e22d9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 05:33:04.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmajPxdeKJ6N9I/svpBFWkpYmOczTKbUFHE6M/2XfdavGB1WSa6JI8czY9E3Qn/tN8fshuD6YdiZ7JVbS+SAJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536

Hi Tejun,

On Sun, Apr 12, 2026 at 05:30:52PM -1000, Tejun Heo wrote:
> scx_qmap uses global BPF queue maps (BPF_MAP_TYPE_QUEUE) that any CPU's
> ops.dispatch() can pop from. When a CPU pops a task that can't run on it
> (e.g. a pinned per-CPU kthread), it inserts the task into SHARED_DSQ.
> consume_dispatch_q() then skips the task due to affinity mismatch, leaving it
> stranded until some CPU in its allowed mask calls ops.dispatch(). This doesn't
> cause indefinite stalls -- the periodic tick keeps firing (can_stop_idle_tick()
> returns false when softirq is pending) -- but can cause noticeable scheduling
> delays.
> 
> After inserting to SHARED_DSQ, kick the task's home CPU if this CPU can't run
> it. There's a small race window where the home CPU can enter idle before the
> kick lands -- if a per-CPU kthread like ksoftirqd is the stranded task, this
> can trigger a "NOHZ tick-stop error" warning. The kick arrives shortly after
> and the home CPU drains the task.
> 
> Rather than fully eliminating the warning by routing pinned tasks to local or
> global DSQs, the current code keeps them going through the normal BPF queue
> path and documents the race and the resulting warning in detail. scx_qmap is an
> example scheduler and having tasks go through the usual dispatch path is useful
> for testing. The detailed comment also serves as a reference for other
> schedulers that may encounter similar warnings.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> v2: Replaced the previous enqueue-side fix which kicked when a pinned task was
>     enqueued. That was based on the theory that ops.select_cpu() being skipped
>     meant the home CPU wouldn't be woken, which wasn't quite right --
>     wakeup_preempt() kicks the target CPU regardless. Moved the fix to
>     ops.dispatch() where the stranding is actually observable.

Looks good now!

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
>  tools/sched_ext/scx_qmap.bpf.c | 40 ++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index f3587fb709c9..a4543c7ab25d 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -471,6 +471,46 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
>  			__sync_fetch_and_add(&nr_dispatched, 1);
> 
>  			scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, 0);
> +
> +			/*
> +			 * scx_qmap uses a global BPF queue that any CPU's
> +			 * dispatch can pop from. If this CPU popped a task that
> +			 * can't run here, it gets stranded on SHARED_DSQ after
> +			 * consume_dispatch_q() skips it. Kick the task's home
> +			 * CPU so it drains SHARED_DSQ.
> +			 *
> +			 * There's a race between the pop and the flush of the
> +			 * buffered dsq_insert:
> +			 *
> +			 *  CPU 0 (dispatching)      CPU 1 (home, idle)
> +			 *  ~~~~~~~~~~~~~~~~~~~      ~~~~~~~~~~~~~~~~~~~
> +			 *  pop from BPF queue
> +			 *  dsq_insert(buffered)
> +			 *                           balance:
> +			 *                             SHARED_DSQ empty
> +			 *                             BPF queue empty
> +			 *                             -> goes idle
> +			 *  flush -> on SHARED
> +			 *  kick CPU 1
> +			 *                           wakes, drains task
> +			 *
> +			 * The kick prevents indefinite stalls but a per-CPU
> +			 * kthread like ksoftirqd can be briefly stranded when
> +			 * its home CPU enters idle with softirq pending,
> +			 * triggering:
> +			 *
> +			 *  "NOHZ tick-stop error: local softirq work is pending, handler #N!!!"
> +			 *
> +			 * from report_idle_softirq(). The kick lands shortly
> +			 * after and the home CPU drains the task. This could be
> +			 * avoided by e.g. dispatching pinned tasks to local or
> +			 * global DSQs, but the current code is left as-is to
> +			 * document this class of issue -- other schedulers
> +			 * seeing similar warnings can use this as a reference.
> +			 */
> +			if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
> +				scx_bpf_kick_cpu(scx_bpf_task_cpu(p), 0);
> +
>  			bpf_task_release(p);
> 
>  			batch--;
> --
> 2.53.0
