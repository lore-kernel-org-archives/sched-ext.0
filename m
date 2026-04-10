Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9773DD52F
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838995; cv=fail; b=Jflgc+FI5uwROvSg1nVxkMwW5EVJK2y2tFxH6MGc+H0TH8BkHZRkVMI6fX3wyqbSB2Nsb6ZiE0lwjb+Zbjm2sLizK/yYxBG7NpT6WycGQtqabWAvl/6B6Xog/0CXHxF8Tvwn8QN5MZ1Z77UVQDgBSHdxn7ki4GPHnIjTTUQGXno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838995; c=relaxed/simple;
	bh=9Adrc+2ln9wQHbrL9vB357fDI0vJ6EAwfj5CEHfQLo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iR3BscnPAFPh9F+DGt2mFrt3N6yzMvwnriVAD2J3J0Xpo7EeQ1Qz39z1u3k7RIEtTl2nnhOHZyv+Gd+32+92Lh85KOoXlJbvqyMEV6Qt0iGEj4Celme6FPdnWk8L8DQTEK4fXN3KIzj7kco68GXTgt7apg6hXSMLJUMbYRDN3Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KC7j4UuN; arc=fail smtp.client-ip=52.101.57.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KC7j4UuN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jde3kZ7JV5DyMZt6FQfgsdauzGU6R73oPjtf6RcMJwF/Ljnj5phR6rVt/TYWq1adxDwm8STNpiXg9fmxPn1zxAMnAKVO3TlVCvLvJ6kOE5ohwBDz3KMYlz/a94tEoTkNWwG5+kYgTTjnANhExHu7dGuf2Fah+l13yFwLd36xmxC1rNULZh295ZfWsfej/nPUGNs1ee+vMt1d3fFUUgV17L2s9hh5HkbVNdX4hUYQnZ7JnWOdb9IeXrzRefgxx05lWlHU7B70o2wMEH9no0ZNnTOOGqv8rI1gSgZFvKtuGqnO9ppxn8JTWiETCCnUV4JaoxzelCOm9c9DX34yNH3h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ni0o+X1ixvpLjbYeXg2bTSnLGxXcpr+xte6fCpyA94=;
 b=XGB7sOrtsqHmHBrLyUeAqHhF/nw5bDnMV2eMH/Cf2YZ5wx9tLiClyTMRIxK5PazpFJ4ymaImuyi+t0hs47FH/4fHnPsB5NrCOyYw/DTxEbtoXNK4O2srPbR3G9/K81L4MWGKQCeliSCqCrjrwvmUo5AdAjal7OHTTXAHClRGD6XXof+OlmRJ/mwRNG1Lyl6tyEt6qIKVK59WBmSNsDNzXw3ibMUgrxMR8vCoDRel1+53Tw9r5ScqLMQISq04/uRoTcsF9mwVsgC21U3h7p5CEyK+ObG4dvvEHfdnZvfGG2miPOEq21jwrXUK3BnpTR+mqX3ZkkmRY9KvM4bafCop0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ni0o+X1ixvpLjbYeXg2bTSnLGxXcpr+xte6fCpyA94=;
 b=KC7j4UuN2D9jU5jtAer1ItFM/MChAASet0xSFqTPoY+lUVe4QLBAagB2YzYtSGgqKr/nI+tSKce28Ae/dZQrZ7Hel29+Sfi7akLfHB9odH33Dhij/bkBQWJsXur3If2lCQdvinOIeVRfFyV8m8gP4Vl3nZ0KlYYsq3v0EQ67qj1PI/5bhbUlbhA8uKaGDueyIJm3eO85QolHVHElrbISaqjIHffJC5jA6sP+vyFQMCTC3ehcisY0rMPwF/z98A+6pCTfYsXxMoLzYhPKDEJFDXpTbhbuNGXlIKRBSReCEnM2vPZCExp5L4v42TdEW9la4cSwbdPbw3GI8msgq6MJDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 16:36:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 16:36:22 +0000
Date: Fri, 10 Apr 2026 18:36:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] sched_ext: Drop redundant rq-locked check from
 scx_bpf_task_cgroup()
Message-ID: <adkm_nYLAVK2hd35@gpd4>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-7-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410063046.3556100-7-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004E95.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::445) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d87c9c0-d263-4666-fa64-08de971f4cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AK8MZzPjXS3guy7Oi9Ofg05EGbQkaf1yTtFDs2L//3Rm1pL2BLPDSWGS5Fkkqs4R3VMIgJnstphmOtOCquLKD92JgKlorMtRpuAoOvGXlJRS8Bnd0z2OCvxX+2q9U1spRi+/lBwytlifN/YsoKQmvIDy4tplj/W114nqQsHbHimOOh3RC7PqOLPh2bPXOuol5/A6oBns4PVyhdGVlNvpYTlEgO7HrNrTixVuGxzlhK/BgQd8IsrlNZFRhAQi150VST+CyGzxuJ8LzHp7HTAvi3Abxxq905loXoNNS0GPODYuRef1mDNM9fmbatQxrsJ1mt5SxquFjSjs94MeFraLmDDtW+7yGbHXDwpYjMlpvTsks8mzqk8AVpMaQz93XrLQt9hg+vFusn2SZWTc5rYuIKG5PDwHEEqnPcJvv9QVvO2+7zo9zjiyDmVwjKotfSrWY7WUQTTMQlHNjDzRcYGcUzsNylKa301fE1tP7Tkjg8Q6FOXs6++/C+A5zNdcRx49rSwfk4wo7vXTVYKEQOxp2AjjukAIex0gqqmhkEk3g+cpg680SGdc1PSo+62UUeCi/TXuentPtSC+JaMfOR2ZTY007BEs5z57zrxgeTP+qbWCs7PhLsiIWctK01bjuP553SCEgzWemLyfW6W+B5Xhiz08vbaDgFZCBcYDqC46hlcxIPT1MhxpklO8ecXZEyvGuWpfzEreVtymvu8TKvNlQCQuV8JTpmoKQy9wLHLv4eI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dl7N3Nzp/S+duTaDk+rsJf0nLCQR/RC9pFmh3tHNPag3EsZY27rV8BbdlM4v?=
 =?us-ascii?Q?y51kve6W4oUqGNdOvlxStJXhcBAF8D17zcebQ+gKPse4N0IgqXgVsy8Bp0xO?=
 =?us-ascii?Q?6w2AivlBrD4ISx9u9RCsp3f1lWwtGHEy5TPy5jwOrtCg7l+nmWTcik93u4fv?=
 =?us-ascii?Q?dW3URiafdT/4xBG6KbJFYBu/EpmCZlwuOzNNVnIPtw9y818daGjaBkwU+AAR?=
 =?us-ascii?Q?RWHt/KdML32LZgTvbAMwnuW5qFZHArDE7G2Puve7nERGayd6Q1Gdxh5EfEly?=
 =?us-ascii?Q?pYdT8M9+NrC1kM3pF724h1Ds11pMh/sRc2pQHTnj+3rrUQnt8cQNHHxjWQ4U?=
 =?us-ascii?Q?+uuqdVF9OgvUdjfmzcN9TvjgU7cJFGmKYVHS5gP9OYol5znxhk37kEKjO7et?=
 =?us-ascii?Q?PH/QzB9hjuawIg0nNPv949kRIQ7g1vj3OI5TtNHoGWvygo9Dgf8DDG0c5/iO?=
 =?us-ascii?Q?osXuxGc2brVkAbKaLKf3L20i2QtfkFAp+c8+BYvLdCK2/qaUTmrLdY8taapK?=
 =?us-ascii?Q?gbTxtHl/24gLedYt6g/hlblgzqFbYdZUKQhpdN7s9sn5PxiLvLMICVNIeEIT?=
 =?us-ascii?Q?SKdErEQ+dVDbxrW7/t4jvNPuZmvUDrfBe46iwFmh3o3ekc239ebRcFwGpPTS?=
 =?us-ascii?Q?VZpDcWGVopQIixbu/VWkl30zJPCiomj2lgd3P7adGnNX+v5hxqvYTJBIoZ1F?=
 =?us-ascii?Q?WMOmJGUy5pUC/NVVEU0NjLi8HPz9hp3tZHqAUP4wtOXalmM+t0lotV96PCHn?=
 =?us-ascii?Q?SWvlB0NyWzZRBu3EIqEbOqtBOjkXGxA7kkmR4Fl2EZPQXrgEDqVtxFwk1ISm?=
 =?us-ascii?Q?0y6gf4OvkHNhAFRIueB22bIIEqXGNCR+sjmva/Z7VoUBA+96/A9k1s9Zn25I?=
 =?us-ascii?Q?SqX+HHiP4xrWkKiUqbMbw4X0A+YNTQnELW1LPSUGD86MHaosDZx+IEJZfl8o?=
 =?us-ascii?Q?34SsyI9DSNYvY7KR0hq4e7w8WGrlRC1i6/TlDi1IMfz6+4aI2rzdgjbzWkZi?=
 =?us-ascii?Q?BYzFdQU94dzRHvTMshyv1udY9ZLUZ5VKU5Q7BAPzDeeYWp32cOxhZN7TQ/Xo?=
 =?us-ascii?Q?zeDy2vVgHG4Hv2+BmiLHQPeQb31t1z3il9nONCQ3en0YnPXBYRSopSU43kyz?=
 =?us-ascii?Q?3RmFx0afCh5d0Dc4yYYGzHjD23Fu6vLI3gsjzZH7y0h4lfFABJA9DaP6Emkj?=
 =?us-ascii?Q?Nxkwp6sx7+ZOEorVygotcRJKdyUTLjRyk18MC3Az3DMiTF17lApUmykPvx/l?=
 =?us-ascii?Q?9LLBslpT8JtYEJXTZZz10CmEgx0LSLgd7xHyo8MV1gS4ssg7VceqezpWDt85?=
 =?us-ascii?Q?XZLy5gKxsT+Ww8glLS3eqvS7G79hshLGj/aT6jFeAFsRIE82Am0PdVYYP5v7?=
 =?us-ascii?Q?OnoqaEbZfsGBC2HLUZZ5zl7eER4iA7Wl5iiFtMA6+bOSgaNEvTzJuxWro1ef?=
 =?us-ascii?Q?HwrcoKklTdVkO6bBHKM/8yGLsQ9uHdBsrDqxMBcdrrWd7++tc2qQ7uItDe4q?=
 =?us-ascii?Q?th2mc3/HGX9PF1njpjxW3bqhM9w5sd3+/xfYw5fBpxJ1oDHHiqGO400lESDB?=
 =?us-ascii?Q?h3AE6f1CsCN3eClJ9O42LO+Err96y0nyGq1GM7JwIf2Kw3n0wGRmQSn0fRj/?=
 =?us-ascii?Q?nkCFXxAxxeXAnA0CUDN/NnnFW8iUqbJk3IjcY7WKvmoN8o4e0UTmVmHy7NrH?=
 =?us-ascii?Q?g3GbYB6HSs/6NPHWM+SbdIpymw5+V+ti8o4cFjjHrjpkX448KU3w5m+KRaub?=
 =?us-ascii?Q?6znqWojMKQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d87c9c0-d263-4666-fa64-08de971f4cd9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:36:22.4531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvUPVt2gavdtZlgEiyo2kBqtI3d3zxafh+7bLIC0RbVW5ID8iECPgFx3dzrXnBCt05GoP1mGjs/Pf1dnNqVdkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126

On Thu, Apr 09, 2026 at 08:30:42PM -1000, Tejun Heo wrote:
> scx_kf_allowed_on_arg_tasks() runs both an scx_kf_allowed(__SCX_KF_RQ_LOCKED)
> mask check and a kf_tasks[] check. After the preceding call-site fixes,
> every SCX_CALL_OP_TASK*() invocation has kf_mask & __SCX_KF_RQ_LOCKED
> non-zero, so the mask check is redundant whenever the kf_tasks[] check
> passes. Drop it and simplify the helper to take only @sch and @p.
> 
> Fold the locking guarantee into the SCX_CALL_OP_TASK() comment block, which
> scx_bpf_task_cgroup() now points to.
> 
> No functional change.
> 
> Extracted from a larger verifier-time kfunc context filter patch
> originally written by Juntong Deng.
> 
> Original-patch-by: Juntong Deng <juntong.deng@outlook.com>
> Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index a0bcdc805273..6d7c5c2605c7 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -540,15 +540,18 @@ do {										\
>  })
>  
>  /*
> - * Some kfuncs are allowed only on the tasks that are subjects of the
> - * in-progress scx_ops operation for, e.g., locking guarantees. To enforce such
> - * restrictions, the following SCX_CALL_OP_*() variants should be used when
> - * invoking scx_ops operations that take task arguments. These can only be used
> - * for non-nesting operations due to the way the tasks are tracked.
> - *
> - * kfuncs which can only operate on such tasks can in turn use
> - * scx_kf_allowed_on_arg_tasks() to test whether the invocation is allowed on
> - * the specific task.
> + * SCX_CALL_OP_TASK*() invokes an SCX op that takes one or two task arguments
> + * and records them in current->scx.kf_tasks[] for the duration of the call. A
> + * kfunc invoked from inside such an op can then use
> + * scx_kf_allowed_on_arg_tasks() to verify that its task argument is one of
> + * those subject tasks.
> + *
> + * Every SCX_CALL_OP_TASK*() call site invokes its op with @p's rq lock held -
> + * either via the @rq argument here, or (for ops.select_cpu()) via @p's pi_lock
> + * held by try_to_wake_up() with rq tracking via scx_rq.in_select_cpu. So if
> + * kf_tasks[] is set, @p's scheduler-protected fields are stable.
> + *
> + * These macros only work for non-nesting ops since kf_tasks[] is not stacked.
>   */
>  #define SCX_CALL_OP_TASK(sch, mask, op, rq, task, args...)			\
>  do {										\
> @@ -613,12 +616,8 @@ static __always_inline bool scx_kf_allowed(struct scx_sched *sch, u32 mask)
>  
>  /* see SCX_CALL_OP_TASK() */
>  static __always_inline bool scx_kf_allowed_on_arg_tasks(struct scx_sched *sch,
> -							u32 mask,
>  							struct task_struct *p)
>  {
> -	if (!scx_kf_allowed(sch, mask))
> -		return false;
> -
>  	if (unlikely((p != current->scx.kf_tasks[0] &&
>  		      p != current->scx.kf_tasks[1]))) {
>  		scx_error(sch, "called on a task not being operated on");
> @@ -9535,9 +9534,8 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
>   * @p->sched_task_group->css.cgroup represents the cgroup @p is associated with
>   * from the scheduler's POV. SCX operations should use this function to
>   * determine @p's current cgroup as, unlike following @p->cgroups,
> - * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r.t. all
> - * rq-locked operations. Can be called on the parameter tasks of rq-locked
> - * operations. The restriction guarantees that @p's rq is locked by the caller.
> + * @p->sched_task_group is stable for the duration of the SCX op. See
> + * SCX_CALL_OP_TASK() for details.
>   */
>  __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
>  					       const struct bpf_prog_aux *aux)
> @@ -9552,7 +9550,7 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
>  	if (unlikely(!sch))
>  		goto out;
>  
> -	if (!scx_kf_allowed_on_arg_tasks(sch, __SCX_KF_RQ_LOCKED, p))
> +	if (!scx_kf_allowed_on_arg_tasks(sch, p))
>  		goto out;
>  
>  	cgrp = tg_cgrp(tg);
> -- 
> 2.53.0
> 
