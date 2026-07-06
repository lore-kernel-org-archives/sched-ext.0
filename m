Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E3395AFA
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329053; cv=fail; b=ea4llwpDZJ7XJ3orwS1rdqQSnJe5Z/+UZK0f0URCeMLJeqdXhO0DehPoRRbEF2cSpHRfBkGLFraJEShfnTVuVllPRfArPBhEtj4IJ7qcF+5K7KHMQlUBckD7G2EkyU4R6JEiFxbTlxQ8GprBGdG6u4+fBs7XvtSun2EOS6CC/+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329053; c=relaxed/simple;
	bh=V116dp6mBeQl4YFqdkLEVaUHhWRDhGtRUJyGsFXCpcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AqmOMFLB8RfBXGEAwsIHq3wAWdJ/GlMdDMW6XimxU5NC0Ubd/3saDkheJGlWJTP6rMDbKiFz3WCckoyFSx+RX12SzfcQt1pzgMSCjuYi9CUtu0vGPHUJxaK00CGxOOVtgxLmD61LT2q3/l54R6ngaJ70q80kj+3Os3opgeakE6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hIMfQ3jx; arc=fail smtp.client-ip=40.107.208.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hIMfQ3jx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ck2s5J4irjblXiDeJeunrEqb7n5qFUmhDVBEXustA38Xx0FS31WlksKidnIRAwmsCfr15C5bdvxCh/B4RlidLtKJs9+w4cqCEU+Hv4ujz17rB0yFYBYRPAEX/SSgi0KyvnpessrdRNxNe2Qz+FXO0blYpbe1O5QL8Jn0pRBKXcjD6Sl1xczufVZW6hZVVIN8XxmQw5gD1fOegWSh4IvD+BoQMeC/L3YM2UJlS2WlwlMg9Wu70EPMhVqvZYNuVAFtjQ22GDoNmLJjq4RE/D7zhTFpcLVBR0gZ8797BmHvym9pvn16K5KfAtLwMDbMUXcDXMYSl6V5l7p+l+bSQ506Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/6RkQyT45mE7VuULgUr9H5wc5msrFby2ujvw7iv1N8=;
 b=qdwkqB2ICdYl3an9MT98VGrY0CkMC9x/t2tfY50e7IB+1M1+cE9Ga6mPkRZ1ijxmj8I+VQ/67UaJRN01A+Rb4aoxJWOJgxopLf2bVJggpzaGUsXpuEY6w+V8HaGPNdSl+j/km+0q0uGZrdzavIAwQ+2AbJODrtgWzZ8ImEpBOo0ln5nSyWKi8Gw2UNvJkJnMaLRnXDnlmzpkSt4uctX2c93U9ZvvwBAscX31sDdNByTByZa+Qw8T4j9kUnvES9W+AJ9zIebsraugrIj8myAmNp3DAy0lpykH38mhPp9UvymH9MHIB6STrtmC81+eUAhpIrKipgSxx1M7G90jnJMSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/6RkQyT45mE7VuULgUr9H5wc5msrFby2ujvw7iv1N8=;
 b=hIMfQ3jx/pd78pFycOgVq7MXKWIM1tqulBDkF5w8xXoJIqtu5dndfzYt4kaSNxSVncPjRTpfcBydo1hgtcbsuuL4ALa1yzzqH+BSU8BL+b4bTxXdySw4bGpS/rYRhbm+ZNJ2R+qhQmpMaTnDnm/4U+YAdPKNermsm0y5NaLLtod2nl1Qk1PzvipuxAW4VIj8fM8XAYvC8Ixz9awkAg3WbQr0gE/4TMm9pYNGo2reaWQ9a9U0ju8VfBZwynMYEnroo8m3lsfTLp6I3ZSdPsfW3LfwWNOBFiJ449WdsYg3Mm73jzlnXgkI3+D9lAug1F1aQVjQF1KRMEAYJzfS/yMlNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 09:10:40 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 09:10:40 +0000
Date: Mon, 6 Jul 2026 11:10:32 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 27/36] sched_ext: Route task slice
 writes through set_task_slice()
Message-ID: <aktxCD_O7-IO1Kut@gpd4>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-28-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706014058.439853-28-tj@kernel.org>
X-ClientProxiedBy: MI1PEPF000008C7.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::429) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f70048-8373-4e92-d46f-08dedb3e7320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|4143699003|11063799006|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	dnwUfFE2jQoRZp2x7AVnoYeAe6jxA1tcWIobjnls6TT0fAYxLkMod1vXcL9WwPF2deK8GYjgjWkiFEMipjivShzBiNTShYiD8E1ueZwqA++k4f8sirff03FyN6HC5Vv8NGuRcX+TFvcm9Y6BVMXJ5X9CUTGaHT69x63s91ROauJTYCFoZsVBNbRq2XP+1JlX14fp6tJWTxf8o7Y8785KyRCD5HDtK9y3om8M26fKg1IuY9j5WpBmwJhQSSfShCuKyB+u57yNY35KdwQw6LqUMShPgiVVnK2VsMQdwrFiezcqPckNufB8EfCxIRJUIUN/3eD4k9nFclSz3CUPaxGBw0Ft4sB01xLYh8lfKQpGaEeVGLo8o/Nht9lpnr1m02gslyM+woQMvmweXWJcvlN81ohL5+rLxXa6O28EpXP3xNt5DSk4EVgZPfbKHPuZzgTLlEPOYGwgqDwfarHp46V3LQJAQ/0Emy4HqjI6Y/kOfjqykxV/G4u3bJcrl3KEAqkZ3iN29rueG7iUIGz88RDVALNuIMfNFemItJ6rFecHAIHaN4szoBzUUV160bMlJNxiUWZMq6Ilg/TwXXeua8XnSAIX0K4Hyps6rNHrQl4ygeibd5xGlOKfo0dfHBrVsH+wTg9buUeQIqV2+wLyy1YBQcKEOq88hMpwi/X3L3RcIAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FsRmG8owSNkIiHBIE56GZctsQgkWhKSuSM8e+bQBNCD8Mo9DpxnltdqTcIoN?=
 =?us-ascii?Q?Ez90wLGkasHS3oFNfrV1PnIotZH4gywE6f52/zePeukvAjJchqmmiVxyLF9P?=
 =?us-ascii?Q?fjODjQIJl/+XTPL2Au37m2RLHKZEmQ6Mowd4mcb46gxH7fMlZNH5ygXcLAPZ?=
 =?us-ascii?Q?awVdveQ5YaGKDbMYoeH5Dd+xRo6Qa0ILreeKemPWadzh7ig6wbuRk2wJs91U?=
 =?us-ascii?Q?ARNTVW/ln5piTRplEIOm0zP/5uoVs4G62U0g4qbfdgklWN9xmwnHP12UHSf4?=
 =?us-ascii?Q?rSPd3tLPwjC499oqBFV7mXo26ZcmiObKP0QDv0zkQ54Ijxysq+72zrcB7qOb?=
 =?us-ascii?Q?oXssjCssHvsxTv7mKWotpMTrAu57RUzw0UPmTyeuVFwIPOiRZdZzUt3zd8yb?=
 =?us-ascii?Q?YUGBAxo5ZHnQ5IAFy0LJO7wljSNIRi4hYyysYau0xe0t+f3Uhg/YcijU7VXA?=
 =?us-ascii?Q?51fHj47j1hzPU7tS7L6x8CUn4z/FvFfCj7XZKaQSyF1Y5thlyzy1/HknOuD5?=
 =?us-ascii?Q?ecCVbCzyQDt/l01C9OZSHqinoNywF7vuhC1AqlVuEivtyt41bU+dcBxP2EHI?=
 =?us-ascii?Q?ohBmV6FN9FhV/RQAgv6zv6QNAvSRgrqQ/9v9V7ziqhwG7Pe12Ox9rhT4afu5?=
 =?us-ascii?Q?E+ipwQz//IucdGDF2jz6tz7lr+pX3CYDGULiJuw49QlaJmOZafIY9EdjN+Oy?=
 =?us-ascii?Q?18VCcdVPzoFY6l+gSRfTU1guLDtv1GAfQgH4eYCVMryDPbLfnfbBIR1wqzw/?=
 =?us-ascii?Q?Hshdr8A43msrtFVX16Tv4dOt1wMOyL8KL/dpDFOSM6og66cuAYm+A087uyD3?=
 =?us-ascii?Q?5lbck01KPQNsmd9kTNJTh92pWCsgBRZqiu2X3g4rknqt0jfDP+Bbv3U/p1nA?=
 =?us-ascii?Q?iwz3y30gKB/lN7o1nEEQrqjMPwxHdqrJj0lAhG6FbQwhtBwjkFUQl+oKyN7S?=
 =?us-ascii?Q?cabKe6sJ2XsOuoNc+yedBFsz3YwLdrwQC5frlzWVkaauhS9OY6DxVODOtWWy?=
 =?us-ascii?Q?NB4OCnt3KVdkx2JFSfUXzFTpnEypPm95QB/lfBW31CIZEBLEeCapInmqjK5b?=
 =?us-ascii?Q?ShxhyvbgAUZyLssb4uSjTqQbqjMAaWWUrrDduLvgGFMKRHNT1Pfsv7nG3uSS?=
 =?us-ascii?Q?+TOjCFCx65KdKde24qajfgyQNL8RuNyYaWoYP6rfe0a0MnZeHPvME30DbUB+?=
 =?us-ascii?Q?drEfAoDm3jCiQq0Z1+dMkYMLm/8X9PCz7PZAOwlghjAS9DQdP408b2NeSbD0?=
 =?us-ascii?Q?T+rKkNUfULEPIK2e0IgdLHloFMm5ttKwSdmgNuIbtIKRb2k0vkwR9ZnvzFKf?=
 =?us-ascii?Q?o1pqWCuM4cQqByI8sGgMYOX+pSrO+bEvLceFSYOyW04ZZc9uPuUqTlENMyDN?=
 =?us-ascii?Q?uaOF6LQELPZdWGXxl6Ef+ukgu7SODha4cUj/LMbdsggYdvZWi/ngLVscxTgq?=
 =?us-ascii?Q?Fnc2gZWkXCkrbKf7h/P3OrqJOyXIwo/SZaQIb/WVno6x3pQMGlsAjQ7jzpPb?=
 =?us-ascii?Q?P3vDCCqogJpkUPazMgxcU2e+PZbRqAgrXL5JVMkENTSXCYPbShgjsrVHdi2E?=
 =?us-ascii?Q?wN3iVG4u7/273h8ABQl4Xr5+BCciyvrjZVVSIJIfOUBLqDUT+BpgCFJwfhpb?=
 =?us-ascii?Q?Vxbx0E11UJcwgkqKgXzPQtTZWSEkjxGyd5c9nOUfGYU1AeHlMkOMaDVLmpvY?=
 =?us-ascii?Q?piqFKA9RjHMxhwZ+xLO3UJPg2cYTsbmxWbByHTAHJhco+UAns0/t1SrACb/X?=
 =?us-ascii?Q?HxPf93RSng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f70048-8373-4e92-d46f-08dedb3e7320
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 09:10:40.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jexx99Rs6DgD82aB63tbtspFvHLPJlq50TCJKH2NuZlUkp7FDsOVbcO93O4xL7GSn/dtdrqQLfR9a1XZG+yc3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992

Hi Tejun,

On Sun, Jul 05, 2026 at 03:40:49PM -1000, Tejun Heo wrote:
> A later change makes every write to p->scx.slice also drop a pending
> out-of-band slice request, which needs all such writes to go through one
> place. Introduce set_task_slice() and route the existing direct writes
> through it. No functional change - the helper only assigns p->scx.slice.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext/ext.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 9fa4cfbc75c8..ff997ba881b0 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1153,6 +1153,12 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
>  #endif
>  }
>  
> +/* set @p's slice, every write to p->scx.slice goes through here */

nit: maybe we should say all "BPF-triggered writes to p->scx.slice", or
something along these lines, just for clarity, update_curr_scx() still
decrements curr->scx.slice directly.

Thanks,
-Andrea

> +static void set_task_slice(struct task_struct *p, u64 slice)
> +{
> +	p->scx.slice = slice;
> +}
> +
>  static void update_curr_scx(struct rq *rq)
>  {
>  	struct task_struct *curr = rq->curr;
> @@ -1238,7 +1244,7 @@ static void dsq_dec_nr(struct scx_dispatch_q *dsq, struct task_struct *p)
>  
>  static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
>  {
> -	p->scx.slice = READ_ONCE(sch->slice_dfl);
> +	set_task_slice(p, READ_ONCE(sch->slice_dfl));
>  	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
>  
> @@ -1333,7 +1339,7 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
>  
>  	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
>  	    rq->curr->sched_class == &ext_sched_class) {
> -		rq->curr->scx.slice = 0;
> +		set_task_slice(rq->curr, 0);
>  		resched_curr(rq);
>  	}
>  }
> @@ -2039,7 +2045,7 @@ static void yield_task_scx(struct rq *rq)
>  	if (SCX_HAS_OP(sch, yield))
>  		SCX_CALL_OP_2TASKS_RET(sch, yield, rq, p, NULL);
>  	else
> -		p->scx.slice = 0;
> +		set_task_slice(p, 0);
>  }
>  
>  static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
> @@ -3273,7 +3279,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
>  	 * we can't trust the slice management or ops.core_sched_before().
>  	 */
>  	if (scx_bypassing(sch, cpu_of(rq))) {
> -		curr->scx.slice = 0;
> +		set_task_slice(curr, 0);
>  		touch_core_sched(rq, curr);
>  	} else if (SCX_HAS_OP(sch, tick)) {
>  		SCX_CALL_OP_TASK(sch, tick, rq, curr);
> @@ -3412,7 +3418,7 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
>  	 * control, after ops.disable() has observed their final values.
>  	 */
>  	p->scx.dsq_vtime = 0;
> -	p->scx.slice = 0;
> +	set_task_slice(p, 0);
>  
>  	/*
>  	 * Verify the task is not in BPF scheduler's custody. If flag
> @@ -7033,7 +7039,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  			queue_flags |= DEQUEUE_CLASS;
>  
>  		scoped_guard (sched_change, p, queue_flags) {
> -			p->scx.slice = READ_ONCE(sch->slice_dfl);
> +			set_task_slice(p, READ_ONCE(sch->slice_dfl));
>  			p->sched_class = new_class;
>  		}
>  	}
> @@ -7671,7 +7677,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
>  	    !sched_class_above(cur_class, &ext_sched_class)) {
>  		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
>  			if (cur_class == &ext_sched_class)
> -				rq->curr->scx.slice = 0;
> +				set_task_slice(rq->curr, 0);
>  			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
>  		}
>  
> @@ -8021,9 +8027,9 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
>  		return false;
>  
>  	if (slice)
> -		p->scx.slice = slice;
> +		set_task_slice(p, slice);
>  	else
> -		p->scx.slice = p->scx.slice ?: 1;
> +		set_task_slice(p, p->scx.slice ?: 1);
>  
>  	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
>  
> @@ -8047,9 +8053,9 @@ static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
>  		return false;
>  
>  	if (slice)
> -		p->scx.slice = slice;
> +		set_task_slice(p, slice);
>  	else
> -		p->scx.slice = p->scx.slice ?: 1;
> +		set_task_slice(p, p->scx.slice ?: 1);
>  
>  	p->scx.dsq_vtime = vtime;
>  
> @@ -8233,7 +8239,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
>  		p->scx.dsq_vtime = kit->vtime;
>  	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_SLICE)
> -		p->scx.slice = kit->slice;
> +		set_task_slice(p, kit->slice);
>  
>  	/* execute move */
>  	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
> @@ -8628,7 +8634,7 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
>  	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
>  		return false;
>  
> -	p->scx.slice = slice;
> +	set_task_slice(p, slice);
>  	return true;
>  }
>  
> -- 
> 2.54.0
> 
