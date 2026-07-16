Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190238737B
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 05:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784178892; cv=fail; b=KcRDQmvkfNoSGmOxCOrUVMiWr01V1PN3jBlKKNjM4Fy2iqg0cdgCTdS9k9ssL3uyw1JQvXi+zx3JWQLMwVB2OYsLJ6xoi93Bqqlrogv8l1yfwOxTmt+WdGSPmIW/3wJJGH9KdZabrIH2woUt8Dh4kDCGJIJTBv7wbwR7gb8zfsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784178892; c=relaxed/simple;
	bh=kkCMcau22VSPALcD58kWtD2XsY7gUR6dJstNdn3xnKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QWicDSX8Njzfsaiq4FePOGyTDCO/sDLeah6GgaRzTn3neoAZ9cR7fJyHyf8Qgmnr4LW+TYuo6TIc3pE9kp+KOP83/2qBKst1DeUXqJjX1A5bWjSBKfWLwEW2OB/Hp7w8J6tzPmoOqquFZBrylVLejH8Kp+n+W6rmn18ziEz8Ji8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uo/Am3kF; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uo/Am3kF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVMIfxHvSwX7TmwRUb0M5+if8f+VvFUgXgyG9VUWJH29JBusR0AXupBMm5mlWUgBinaEbreaJjfYrSUdmw1g2QOB+gKl4/WLxL51pDmFmg27QRJafES459couJBfJgGyHhyQmeBv1z3/zBdBgBANoKLRza+lILWog/XizEpZrAZmNugkSNrjbZDdLwlJIJTHRdCs3hgLHpBwsYfiug2+6X2mDku9tvJz6Yd213rtVwZhs1A/hh1HM3KcFZUM9SBdOAFyvFDB3okttB82GAZGCDYlmyuHwMCrrOlHMQvjXmf87zWVpW8APX2xVJwIW1NMMO9TSp3VbbK3/HKjmPH0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0TT364z+LDgyEUJJyhAB84ajs4dCDmwM0g3GNjMzI4=;
 b=gSj4TNCUWC2LPxRLk1MqehGgtX2N5N69vbHrM9URcFF3TPh4ZS3/7kThrabr9UbgSalc88CpugTy66ZfSyjjtmbQr4uCxdZLi+rYq98C+Oy+EdTixXZB025jHpqHZ62nPbyNWdPy2BA6MlCpJB70dP83RL3WJEu2xD4nqt+HtuiCyozom5oi9a04+B6MrlBMrpmgLcrFke0U9OJbEmDKYEHRjBr5R9fw6Npp/BOoOZJrDVsQmAPNcHW4i275e2mk7V28GlSacMvG+sI+L+tpc0/844lMi/LARa4GMjyvE06XuIzb7fIVjhL2mxGKSce5HOxlfsJrwcl+x6hxh5znDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0TT364z+LDgyEUJJyhAB84ajs4dCDmwM0g3GNjMzI4=;
 b=Uo/Am3kFV2MxHvRbz9Q1rmwOOvi9PWKhB8PH5i0yLBfTRWyoPohmhPcD+wOOzr0r4uKluWExGSuqnIP2SH8QEyz7s8spzzFRAnbJaPWiiqFue5AOiQEMhBvzyV1ZTYXeDvnnPJOs/lEQUtOdTUhSmO5joxtI5vLYrVRGSZ8apqVuiN/l/gVk1FPToxLkKneCTxKbELug6G8rWFTmjxSEWoEZ48SSheDEYpm5/f4QZeBKYWUW2tnBOLIXwCSpyAqOCObCxOVnyAb/5eD/w3uMHT2sMt9kdQwweFOBMQMh+/Do3Ux/77SkcggavJv6gKv56c6tsoWHnRDeNODzzqJcxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB999106.namprd12.prod.outlook.com (2603:10b6:8:301::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 05:14:44 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 05:14:44 +0000
Date: Thu, 16 Jul 2026 07:14:35 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Zhimin Feng <fengzhimin@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Emil Tsalapatis <etsal@meta.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH sched_ext] sched/ext: Keep tick enabled for finite-slice
 tasks
Message-ID: <alhou5r8pMyp-tqU@gpd4>
References: <20260716023746.3289089-1-fengzhimin@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716023746.3289089-1-fengzhimin@bytedance.com>
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB999106:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f670f6c-899a-4ba0-a0ec-08dee2f925c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	S57FU+bZQWd4/9hF5nzH+y1CNouRzBOqNqhkFNOhUG69T+GDcs3sMtrWLsJeL6RdI5bWpS6LB1SrlkZygU5Eiy7wct9a5WD4yWyAFq/gGvn7KD+x9b5p19XXOWG/Bx0sVoQ3Ix9Lx1FHNXi+2i5Ux5/YOfZ+iR955FoKSLZEUpZBdHIcQwRpMCTlmtL1oyjL1w+OcgdeviA3+ki/CP5bT8rXFxNFf+OxykdOelXrEwSkCstq9Z6uC3BWHZcrAS2ozQZHyV/d0qNVT5YucUJZihk/jlj/slkjsKkPEvQOv6JVbCgwBFZiCt0SCPT8wXU9coSjYcX/FeyZnFVzTDy3DZ4puEnaHwKCqoEH8x1ki//u7SK3DYBsFfD0gaseT6+npZrOX7CzHZGpeX6Yy8LhEbZo7LWVSsUhgfUvpUra106RqcEBqsoLOerLks5KGm24qri1OfNLV8g7kxjm64FNGEiCT4NcQXcqwnaEqW0YapImL7r8qux0a0wfCCnVuugqw53ex80GqO3JN1ZHLNpLGh7EYyClIL0egqhrB2lw0JHDktjX5SFQX/Yziz0lzxAH/cLM68ftwEUbso2PzqS+oCTW2iq3qeqt6hVsi8AHW246yfyS3IbELkJDTOhrN91S4XhvpP+t1f/xMbdfvsXj2unfWZH5Ci+x64cPW9xYdk4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(56012099006)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hYRhFLRwxyYz4nEDKaDVuFs62Ock6EbP+mykERblSZwh66tbHg/4XLUH5trK?=
 =?us-ascii?Q?p/J0p8rcDG6KMbmz3MlgLA5p2LZUcMlZgpkHyD+DyM4auI5k+biMYBFH5dtc?=
 =?us-ascii?Q?Ndt96+mX/0Isb1lSDw1ftRggi80WmeTaxvpC7zA2fRPCRRc3yfe4z5k84xRj?=
 =?us-ascii?Q?FZXVgQsZ7tmFKHKoNL4HONrSgYSDtNwOMJX2cZ+67PhGL0cnOqpqU0bsLwgE?=
 =?us-ascii?Q?XQz2Hk1Sdhl+GS39mrb42FBY6nNzws4QoONqxJU5Cp+WhSbb1Uls91J0yK80?=
 =?us-ascii?Q?XyoAtgCSEiWMsQP8urHZyDBUvkEP6TdXJR3pi9PwizzMPCHUbZ7wL16741Cb?=
 =?us-ascii?Q?04QQHPJZ9mGCOAEqUMhxtiHye0ID6PFKJl9TZ1a7K97dxov1SClWt1qEhF2h?=
 =?us-ascii?Q?4s4j1SYj1Lmm50Xt1/VR9Oy53gHwQk5qs9AkTwuon0xcBqhIbLCd6yFVsEYx?=
 =?us-ascii?Q?5iP02OA2byFxO6GGOibQkU95sNLREbukLo9IcyCddnTFsBGT+Wqmph23ZB9H?=
 =?us-ascii?Q?Y3wVjon690CiKwivAhChllw9iPbnSuJHfcNK+IG298TvZp0s4XwhA5y48+e8?=
 =?us-ascii?Q?/ync7OtGlfoWJse6Fhj+ThBY5wtaWcsDWc3jP+2TlwR8U8KjA3PkELseiUIo?=
 =?us-ascii?Q?mmtCD8qd3Mn/x2VzTkxyxtRgU7aoNJHN99m5fZB63ausFN27BAGFY6dvsH5e?=
 =?us-ascii?Q?56pvHlK1C6tbXVVVXwKnksS1KZicBFYbuos26AwxAJlzvnXzXxvuE66XTYaL?=
 =?us-ascii?Q?R6xuzSytsG8TstSz0Fknm8TT+NNp75VOjUyRndhOi5TTXz2ofg951fW7txNQ?=
 =?us-ascii?Q?tf2TmlLrGIJMjmnoWjjztJQVZXhiW7V+hBQ+js4A0mfeigSjOh0xbBljJmIn?=
 =?us-ascii?Q?QlKLU8GsYTY9Q6SNNsfB5Oc0bPP2vo/nMUxxXMlMlnyj6+pSXqAg2gfxUs1f?=
 =?us-ascii?Q?HCAnoCaxu1sE2Kgmp2d3a8uZqN0yFK8tnjqs9Bc8VJWXiSgtwGrxUpGe2tC6?=
 =?us-ascii?Q?iy9D/pudTctu9WCpl151uWq6cxXqdPJLzLPfnzLVeLdLJy8MJ8tYxHbmAwDq?=
 =?us-ascii?Q?EXccWUcUJVcRD6W/CckGe4e4vrzMo3XXgf+88gNV2lnJXYj06AFRrrMZfFyC?=
 =?us-ascii?Q?8m9VPqwcjjrbfP6FNQym1R9jT1OHB4RJLLlAjOOrmDy+9Eg0L68hnqLpb7y9?=
 =?us-ascii?Q?NOqYNIKqTyl8PaTWlg02agFo4B6I5Vxyy0KjPRgPmM3qBS8gmDgeGIdKHuFa?=
 =?us-ascii?Q?ZEvKrD1eLBQEsBwG6nNHhA2A9YeODYkY2Uzmmz8NFtfb36ClctYzaZ8zxCYe?=
 =?us-ascii?Q?wM+7MGSbnMY9rgoUAIBWrsgeBkqFNxivFZ7XAICxNCj6UIjZ0fAPWHYAE76C?=
 =?us-ascii?Q?Ql8WANTO4qyRH5c1PAkvMoDXN98LNehIpRKb4TaFU9G+mmRZ9DHp4Wy1Ng6W?=
 =?us-ascii?Q?F///qmU99Du40qv3wlmD1D0RLdBxV5ow7YRBLGeZQPIpYtsl0PsKVlyQIJ+J?=
 =?us-ascii?Q?NDYhIhgD+iEPKkj5cdXDK36uqdV1trqsZ3d92ALbE1hZ2hQ+3/xceEKDlYTz?=
 =?us-ascii?Q?9cRwmhgI6FAMYtZBsTfhDtJMdqAOT+WunuA+8POy9lMC2d8vu8Z2BBkIl/1o?=
 =?us-ascii?Q?cYfdGsFFJdxX5Th1UinuF0SwhoJFRUIfidK1TL58pS+w7gdirJetrp5e+duE?=
 =?us-ascii?Q?CHeoBZ3fAXBhLS3xd/D8bg26ba12+Yt9fppECVhPXn21BBqqH1/6Qc6n8+46?=
 =?us-ascii?Q?bEIdTRqQ9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f670f6c-899a-4ba0-a0ec-08dee2f925c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:14:44.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFMiTyEb+khsGs62TYIiTYpsPsMcZOfABsbmKED5jcrwdO4OR1Oe+9WLH4s3JnUrRy9bE4XWGeaNidpbuBSkvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999106

Hi Zhimin,

On Thu, Jul 16, 2026 at 10:37:46AM +0800, Zhimin Feng wrote:
> SCX tasks with finite slices need the scheduler tick to make forward
> progress on slice expiration. However, set_next_task_scx() used to refresh
> the nohz dependency through sched_update_tick_dependency(), which evaluates
> sched_can_stop_tick() using rq->curr.
> 
> When switching from idle, RT, CFS, or another previous task to a
> finite-slice SCX task on a nohz_full CPU, rq->curr may still point at
> the previous task while set_next_task_scx() is running. If that previous
> task allows the tick to stop, the scheduler dependency can remain
> cleared even though the next SCX task has p->scx.slice != SCX_SLICE_INF.
> 
> CFS does not hit the same gap for bandwidth-constrained tasks because its
> pick path has a next-task based check: sched_fair_update_stop_tick()
> explicitly sets TICK_DEP_BIT_SCHED when the selected CFS task needs
> bandwidth accounting on a nohz_full CPU.
> 
> Add a helper to set the scheduler tick dependency directly and use it from
> set_next_task_scx() whenever the next SCX task has a finite slice.
> This avoids basing the finite-slice decision on the old rq->curr while
> preserving the existing tickless behavior for SCX_SLICE_INF tasks.
> 
> Signed-off-by: Zhimin Feng <fengzhimin@bytedance.com>
> Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

This should already be fixed upstream by commit 4ec10f38ff901 ("sched_ext:
Enable tick for finite slices on nohz_full"):

See also:
https://lore.kernel.org/all/20260708074812.1041434-1-arighi@nvidia.com/

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 21 ++++++++++++++++++---
>  kernel/sched/sched.h   | 11 +++++++++++
>  2 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 691d53fe0f64..6c0c805d489a 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2950,6 +2950,8 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
>  static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
>  {
>  	struct scx_sched *sch = scx_task_sched(p);
> +	bool can_stop_tick;
> +	bool tick_state_changed;
>  
>  	if (p->scx.flags & SCX_TASK_QUEUED) {
>  		/*
> @@ -2972,15 +2974,28 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
>  	 * @p is getting newly scheduled or got kicked after someone updated its
>  	 * slice. Refresh whether tick can be stopped. See scx_can_stop_tick().
>  	 */
> -	if ((p->scx.slice == SCX_SLICE_INF) !=
> -	    (bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
> -		if (p->scx.slice == SCX_SLICE_INF)
> +	can_stop_tick = p->scx.slice == SCX_SLICE_INF;
> +	tick_state_changed = can_stop_tick !=
> +		(bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK);
> +	if (tick_state_changed) {
> +		if (can_stop_tick)
>  			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
>  		else
>  			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
> +	}
>  
> +	/*
> +	 * If @p has a finite slice, it needs the scheduler tick to make
> +	 * forward progress on slice expiration. Don't rely on
> +	 * sched_update_tick_dependency() here because rq->curr may still be
> +	 * the previous task while set_next_task_scx() is running.
> +	 */
> +	if (!can_stop_tick)
> +		sched_set_tick_dependency(rq);
> +	else if (tick_state_changed)
>  		sched_update_tick_dependency(rq);
>  
> +	if (tick_state_changed) {
>  		/*
>  		 * For now, let's refresh the load_avgs just when transitioning
>  		 * in and out of nohz. In the future, we might want to add a
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 56acf502ba26..d692d92fc095 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2998,9 +2998,20 @@ static inline void sched_update_tick_dependency(struct rq *rq)
>  	else
>  		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
>  }
> +
> +static inline void sched_set_tick_dependency(struct rq *rq)
> +{
> +	int cpu = cpu_of(rq);
> +
> +	if (!tick_nohz_full_cpu(cpu))
> +		return;
> +
> +	tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
> +}
>  #else /* !CONFIG_NO_HZ_FULL: */
>  static inline int sched_tick_offload_init(void) { return 0; }
>  static inline void sched_update_tick_dependency(struct rq *rq) { }
> +static inline void sched_set_tick_dependency(struct rq *rq) { }
>  #endif /* !CONFIG_NO_HZ_FULL */
>  
>  static inline void add_nr_running(struct rq *rq, unsigned count)
> -- 
> 2.39.5
