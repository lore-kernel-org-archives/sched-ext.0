Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0E52843A
	for <sched-ext@lists.linux.dev>; Fri, 18 Sep 2026 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767583; cv=fail; b=EgQEy+12npdQCDy60Xq7AmmTKyVpWJ8W2rfuo9eM+HJ8YnKaNsqZDddViN7/kWia4/7sZqzj6C3nTL1MZ+tcWvI91loXCV7K2/w/q/3Wteq7ZWl16WtscxQNBBMn8FyHhvVGr8g6MPJ7GjEQEvMrfp6W9fPmL305Y4XYU/F3Shk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767583; c=relaxed/simple;
	bh=nVsEeGhAy1l37ImE6PlcmKt9McFn9AoIpD2nc6FrBJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CR22I/mejomu5vb6T7wjxjBBHIMfBhDBmW1ZNdiOalkWft+vrEj2AKDmD6CjIlj+XuyzTmr7vnrfAWMm5saSKHaBYaAdXnB05bqF7qmNW+f9w7Hlg/Zy6x7Oj8+besPSRHVxjVcPkDw+rO0BJA6o7cVqGjqzgKljjEWnN4st1OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jkPDfXGd; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jkPDfXGd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2pirvR8mikpwxkyQZcyJRH5+K43XuZ+Ag3Roq9r5HNUqicEXFj1l1lWRmu91g5MxpgbBqrXHEUYnY07bcuic4EcnifRsneQE94yh+W48Yz2SreP/v3UTauFSEAIsewqJ8rt7opm8b7bznJ6HWtVGpCPuz965dIV0XNx9+9sf7zzFK4FYf5Wnk9jebwIgbqrXt9i0fnKEKRhow+j6beiS1h+ouHm0GL2GSTiPXasTxvjiOdHMoNJ3beo9ianZsiko5rmwhk5gC76Udw0waRsuL2hTN6HDNeEH5Mm9vszuofe0kX6DVTiWzn6tD7QZ0jRKTTu3eTubCVg95Xmu5Xnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blUzXRT6RSKJNaA3u3lebIrhYHW+D7yD3EAJP6bQIYI=;
 b=D4i7ZnXm8tqZgG0+/NRmU2Psb4fvi3rxTTLid4i/ctr9bjHN1a2RdLH1ZN5QM4dRy7r/l0wNqliYAfjc6s3uiL1H6pk5t20QMqg3g4hKuqc/w1DeohxaL0KQK6D7DCM6a/hNuQAg+SPMAaMjlQIDHgW41v8URDN6D7rgxum58QITZMTrKKSuRXVb5JTy47jbUOks2Wx5KB7+X6xTwBSyFtxzgB8hsczeW97MyGJorWId4i0EVSLrvqaahfpTnW2k3uqkQKVAddRt6f6APfp9p4XTRAhgEmpmUMz/jD7YY3YA1EfwszwKFrEVozR9T7R6CH3SoDdOoLwUmtdMdDP8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blUzXRT6RSKJNaA3u3lebIrhYHW+D7yD3EAJP6bQIYI=;
 b=jkPDfXGdIwN0pMejKqU9xa6zEsYFyqtvac73ywGn2qcoYIp2ULlq7mxSaHAHTFTmJG2zp31iZPALfLO4mpbIJkQiDJVl9hJrV7QTt9WPHWPviBBgivHo1WrtQzi+433iuRHkfj8O4RyIDPG0IFaZCijzAg39mhDOMLoUsP6IVr3tiRtmI3oTH6W65MNdJHrJqUnvciVO071GK9aFlTYXT3rDX88bUv2EhsDvba73kdE2zrjD2DeKaTavIsdj8NIQcjBbZ2ajpR5fhiiP2KQbh/8oC7aQy/6IPapsBYtA8jq5vkr2oj9HSsJjkMfJvJ+ksJJIjqRo2oza06ZcLqgbiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 21:39:34 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 21:39:34 +0000
Date: Fri, 18 Sep 2026 23:39:24 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Pass the initial
 cmask to cid-form ops.enable()
Message-ID: <aq2vjD_eTI3sMK91@gpd4>
References: <c8343c2e457508a6cd3fcab66b0823b6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8343c2e457508a6cd3fcab66b0823b6@kernel.org>
X-ClientProxiedBy: MI1PEPF000008C1.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::437) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 0542ca5d-89a5-47fb-ddec-08df15cd5456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|5023799004|6133799003|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	1J0ytjKL6y/xvlcp/vPPGha+o/nwheT0LhXB0uWV7q3Ax0xZpWde50KMDswYI22iNLgVcFe4k8XyN9aQesYSHMkNJNF+RjQm6/lEoiKLzaBy/PwYOoyvknE4ZMLP/2TW/tE+/tlZD9mvUkBNVbAXBJUB8zBIJJ7GIdD/5lEf6/inJcCPP0LtMYSFWsyum9sYLxYLFsuqdI6cR7XLXymCCM9DDJJTesfKqq5ejp+4jiw+PSnvSrF7zHbwTQkXUYTLeQAxlY2Fj4T4L9HjtU5xlhCpNYnpZ23xwR7XwVaef4wCB1qOxgI0VJpI0CK6//0EhiiYGe7piNcmhl/UISBbn8mnJY4BjsVEZBRbLB1ksm1mc2Lf5cSjVCopZYwKtkzH/utB0CpEhtwPLeYefXLyWyTKhBJByW5vxHbPGnev3zGPGERGMM8N0w1msefKbriC7rNfaKLYgNubOW+2LTg+vwZpAJfRNFeRAILorJ6KLHqRRb/IseWINSxAxXCGuXcuk9YVqqjx57WuKIkL3YGIrlQb6ZkvyCl4xLyLhbh+CIqJ5w0E2PRf2G3S3z1hJJR/MVms++hqFtGQQ3R9U9BfVEiWDJuP0grArv7POm/zOunoGeOCz+P+yAFJ7Rk07WzaET8GHw6wMJ5zb/7KChgWIcuhkZiLSlFw5J1+4BBT1Bo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(5023799004)(6133799003)(56012099006)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+xW8eVfiw3ijaR750Xd3tv4PgQTmnLKMXL94qj2jtb98ktUWW3HCl7USOaV2?=
 =?us-ascii?Q?FpMz5gt5Pi7hFb7cxMzIiI8txeP2kqtElWVgPxDnPb0zS62BHLgWBc+pHj2+?=
 =?us-ascii?Q?7Qq2hTVmdaLu4JhQXmpEyYuHHQCMGV64VRYcFHOMGd3w2oMv2kpDSDZU17Lw?=
 =?us-ascii?Q?2fZs+G1gXLMI64Njm05u1F+lJS960oBCTZxpAJwsQN+qEf4HfP4mqztqbrB1?=
 =?us-ascii?Q?Ph79sdw/5h8mOJ5lbTFYmRSyh18tX94i+9tf207ygyabon1zPwvCwlmWMmAX?=
 =?us-ascii?Q?ymNka245dGMEh9qHlgaV6zVj/lDCjg3XEbUqzHNwIekpekHTpsl7CmARSAnC?=
 =?us-ascii?Q?7nei1lKqNSTmBsq1g3f5y3trLMsYRB70Pewdku/lH54xDbl7YdEBL/2EWRea?=
 =?us-ascii?Q?OH2Vtztg18XMC0rPedpROU4XJxYgl1EWQjaHzC5YzzgAhP7lLJRlFyby8VPM?=
 =?us-ascii?Q?3u7jMXg6naVMfa9A4L8ek0FxUiETfNAdOLmT1kkCZ4YsvfWy/iFR6//NfQgH?=
 =?us-ascii?Q?OczrvyHtJ/eZq4SPz/xpSCgm2z3U42aX86nf+fOoNxXH4+eqr6fdFxJF9CUG?=
 =?us-ascii?Q?mP1ocnPWiuPLTxNU3Nq8k1nJpTzlR/X2FveAhEsnX89LZ9b/d1fH4V/x1JHE?=
 =?us-ascii?Q?IHiAXzHjRVR+KlKqcUSSGGjx1Ds6bq9vArZuikScslgmnnuOLM+EfHtgXtDW?=
 =?us-ascii?Q?aoARUZnKZs8Ff8SMszPCT/uDt464n6LFSa2kqTsWf+YMgW98EMLIqGzACk1r?=
 =?us-ascii?Q?nhLbk3ZZpGrKhE+rBsbUNP+gQYiCCHIFTjLpnbEAz9w6yOdP5/DVIL9DFnIN?=
 =?us-ascii?Q?cVKig3W2qmE6bb3bybYEqD6mO3BCj3fzsphczO+WLlGs94P2TWQ87lRNK+z5?=
 =?us-ascii?Q?dyis/GOhDpW5xlMk1/bhrmMC8dmQi5Fe+r3tPwnR/v7BMcndGfGsK4zikXCC?=
 =?us-ascii?Q?S8+hq7qz/G/Fji0Zx45TzQ/9KHiMHq9WmJ00QxhkX97ncez6XXOduMtWxJew?=
 =?us-ascii?Q?y6XQ29vOaSHIsHcW3tVM6upRd8mwJePswUzIR+UvAdi5ll9kjmFuI9Le9UCS?=
 =?us-ascii?Q?nSmTauM6UTgvIPeFGMwMEjtNE4IYHWfOeZ9a9bwO0W+ECLGqyN5/Ucd3Npc8?=
 =?us-ascii?Q?/8OJ6tsbkFpmfl2vpYbZ726OaUcw9NOT6TY6GCQOXQ4dArTLlohyEE/xIRJL?=
 =?us-ascii?Q?tB9xOMe/RwA3kInamhVDPxknH1IzFw7Lmibm0QgCoIJ1glIcS8ZgTksLkoiX?=
 =?us-ascii?Q?w2jD4vbr2eiaGCmduU+yeiPpkC7U1SYNzpT/ZCHr3KU/9KDRBPkVk9WxbdSB?=
 =?us-ascii?Q?Ac+hsT8yO08zk0jLwmip8t4hYbaUE2+Z5kCrVCsSw2vQf7zR3331swnfogsi?=
 =?us-ascii?Q?S0FNa2YN0CmUYdSzTItdljtYmeyyotK+jELqM0SlagzmP0c7bS/qg+2tK96L?=
 =?us-ascii?Q?aSlJF98VLigSm9MtvmikT5kCCs7Vip9cwe7dHIN9YHDICTp9rN9hEC4gaW2y?=
 =?us-ascii?Q?lvx0nZJoMjGMuTYShKRgpn8Vcy43sWjtsjOyQI6wSvY5HnD3WgG1YSG8SIrA?=
 =?us-ascii?Q?WkUBvmkfqbBL6jrjmofC8/pxWu939i7B5UWX/Gx2Dw2W7Bd1WLMql3X3BQg5?=
 =?us-ascii?Q?Ftk+T7/tu4sHXtnFRCa0c6GNSkoNVYK0dbOKxX0jBrlXY6W/BNaUchvTDzMG?=
 =?us-ascii?Q?wVViWoNxTM2XehfKagn4LIHQlKYrZz6Gco3Z3c0A/dhzQOODCic7/93odYWi?=
 =?us-ascii?Q?M499EYN+cg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0542ca5d-89a5-47fb-ddec-08df15cd5456
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 21:39:34.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpE7lQUbm8m2b4p0F0BRgln37QY2v43lYkNBJYv/ahV9P7M5xKlzP1p//BC7eGH21oX1k6o4aqmiUKMBkTas8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728

Hi Tejun,

On Fri, Sep 18, 2026 at 10:58:18AM -1000, Tejun Heo wrote:
> The cid-form API has an obvious hole. A task's cid mask is only visible
> through ops.set_cmask(), which fires on affinity changes and class switches
> but not when a task enters a scheduler through fork, sub-sched enable or
> re-home, and there is no p->cpus_ptr equivalent to fall back on. Schedulers
> work around it by seeding the mask in ops.init_task() from p->cpus_ptr cid
> by cid, which is subtly wrong: on sub-sched enable and re-home, an affinity
> change between init_task() and enable() is delivered to the sched the task
> is still on, and nothing corrects the new sched's copy afterwards.
> 
> Fix it by adding struct scx_enable_args to cid-form ops.enable() carrying
> the task's cmask, built in the per-cpu scratch under the rq lock as the task
> enters the scheduler, and calling set_cmask() with the same mask after
> enable(). A scheduler can then track affinity in set_cmask() alone, and
> scx_qmap drops its init_task() seed. set_cmask() no longer fires for a
> cid-form task before it is enabled, and the class-switch republish in
> switching_to_scx() is limited to the cpu form.
> 
> This changes the cid-form ops.enable() signature, which is fine as the
> cid-form API is considered unpublished until the 7.3 release. An args struct
> rather than a bare cmask argument leaves room for more initial state without
> another signature change.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
...
> @@ -3944,11 +3956,28 @@ static void __scx_enable_task(struct scx
>  
>  	p->scx.weight = sched_weight_to_cgroup(weight);
>  
> -	if (SCX_HAS_OP(sch, enable))
> -		SCX_CALL_OP_TASK(sch, enable, rq, p);
> +	if (SCX_HAS_OP(sch, enable)) {
> +		if (scx_is_cid_type()) {
> +			struct scx_cmask *cmask = scx_fill_cmask_scratch(sch, p->cpus_ptr);
> +			struct scx_enable_args args = {
> +				.cmask = scx_kaddr_to_arena(sch, cmask),
> +			};
> +
> +			SCX_CALL_CID_OP_TASK(sch, enable, rq, p, &args);
> +		} else {
> +			SCX_CALL_OP_TASK(sch, enable, rq, p);
> +		}
> +	}
>  
>  	if (SCX_HAS_OP(sch, set_weight))
>  		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);
> +
> +	/*
> +	 * The initial mask also goes out through set_cmask() so a scheduler can
> +	 * track affinity there alone, see struct scx_enable_args.
> +	 */
> +	if (scx_is_cid_type() && SCX_HAS_OP(sch, set_cpumask))
> +		scx_call_op_set_cpumask(sch, rq, p, p->cpus_ptr);

Can we deliver the initial ops.set_cmask() before ops.set_weight()? Otherwise
set_weight() can observe an empty or stale saved mask during the initial enable.
This can matter if ops.set_weight() derives per-domain state from both the
task's weight and its allowed cids.

>  }
>  
>  void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
> @@ -4288,9 +4317,10 @@ static void switching_to_scx(struct rq *
>  
>  	/*
>  	 * set_cpus_allowed_scx() is not called while @p is associated with a
> -	 * different scheduler class. Keep the BPF scheduler up-to-date.
> +	 * different scheduler class. Keep the BPF scheduler up-to-date. The cid
> +	 * form gets its mask from scx_enable_task().
>  	 */
> -	if (SCX_HAS_OP(sch, set_cpumask))
> +	if (!scx_is_cid_type() && SCX_HAS_OP(sch, set_cpumask))
>  		scx_call_op_set_cpumask(sch, rq, p, (struct cpumask *)p->cpus_ptr);
>  }
>  
> @@ -8374,10 +8404,11 @@ static struct bpf_struct_ops bpf_sched_e
>  /*
>   * cid-form cfi stubs. Stubs whose signatures match the cpu-form (param types
>   * identical, only param names differ across structs) are reused. Some need
> - * fresh stubs, set_cmask due to an argument type difference and the sub-sched
> - * notifiers because no cpu-form stub exists to reuse.
> + * fresh stubs, set_cmask and enable due to argument differences and the
> + * sub-sched notifiers because no cpu-form stub exists to reuse.
>   */
>  static void sched_ext_ops_cid__set_cmask(struct task_struct *p, const struct scx_cmask *cmask__arena) {}
> +static void sched_ext_ops_cid__enable(struct task_struct *p, struct scx_enable_args *args) {}
>  static void sched_ext_ops__sub_caps_updated(const struct scx_cmask *cmask__arena, u64 caps) {}
>  static void sched_ext_ops__sub_ecaps_updated(s32 cid, u64 before, u64 after) {}
>  
> @@ -8398,7 +8429,7 @@ static struct sched_ext_ops_cid __bpf_op
>  	.update_idle		= sched_ext_ops__update_idle,
>  	.init_task		= sched_ext_ops__init_task,
>  	.exit_task		= sched_ext_ops__exit_task,
> -	.enable			= sched_ext_ops__enable,
> +	.enable			= sched_ext_ops_cid__enable,
>  	.disable		= sched_ext_ops__disable,
>  #ifdef CONFIG_EXT_GROUP_SCHED
>  	.cpuctl_init		= sched_ext_ops__cgroup_init,
> @@ -10421,8 +10452,7 @@ __bpf_kfunc const void *scx_bpf_online_c
>  	if (unlikely(!online))
>  		return NULL;
>  
> -	/* BPF rebases by the low 32 bits, like __arena callback args */
> -	return (void *)((unsigned long)online - sch->arena_kern_base);
> +	return scx_kaddr_to_arena(sch, online);
>  }
>  
>  /**
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -250,6 +250,24 @@ struct scx_exit_task_args {
>  	bool cancelled;
>  };
>  
> +/**
> + * struct scx_enable_args - Argument container for cid-form ops.enable()
> + * @cmask: cids the task may run on, as a BPF arena pointer
> + *
> + * @cmask is the task's affinity as it enters the scheduler. set_cmask()
> + * delivers the same mask after enable() and before the task is first enqueued,
> + * then every affinity change afterwards, and is never called before enable(). A
> + * scheduler may therefore track affinity in set_cmask() alone.
> + *
> + * The kernel builds @cmask in the scheduler arena from its own geometry, so the
> + * header is valid regardless of what the scheduler last wrote there. The memory
> + * is per-cpu scratch reused once the callback returns: copy the bits out, don't
> + * keep the pointer. The set_cmask() argument follows the same rules.
> + */
> +struct scx_enable_args {
> +	const struct scx_cmask	*cmask;
> +};
> +
>  /* argument container for ops.cgroup_init() */
>  struct scx_cgroup_init_args {
>  	/* the weight of the cgroup [1..10000] */
> @@ -1037,6 +1055,7 @@ struct sched_ext_ops {
>   *   - dispatch         -> dispatch (cpu arg is now cid)
>   *   - update_idle      -> update_idle (cpu arg is now cid)
>   *   - set_cpumask      -> set_cmask (cmask instead of cpumask)
> + *   - enable           -> enable (takes struct scx_enable_args)
>   *   - cpu_online       -> cid_online
>   *   - cpu_offline      -> cid_offline
>   *   - dump_cpu         -> dump_cid
> @@ -1070,7 +1089,7 @@ struct sched_ext_ops_cid {
>  			  struct scx_init_task_args *args);
>  	void (*exit_task)(struct task_struct *p,
>  			   struct scx_exit_task_args *args);
> -	void (*enable)(struct task_struct *p);
> +	void (*enable)(struct task_struct *p, struct scx_enable_args *args);

Does this break existing cid-form scheduler that implements ops.enable()?
If an existent scheduler moves the new prototype, does it load both with old and
new kernels? In theory if the new args isn't used, LLVM should eliminate it, so
existent BPF schedulers just need to use the new prototype and should be fine,
but I haven't tested it.

>  	void (*disable)(struct task_struct *p);
>  	void (*dump)(struct scx_dump_ctx *ctx);
>  	void (*dump_cid)(struct scx_dump_ctx *ctx, s32 cid, bool idle);
> @@ -1533,7 +1552,8 @@ struct scx_sched {
>  	 * by BUILD_BUG_ON in scx_init()). The anonymous union lets the kernel
>  	 * access either view of the same storage without function-pointer
>  	 * casts: use .ops for cpu-form and shared fields, .ops_cid for the
> -	 * cid-renamed callbacks (set_cmask, select_cid, cid_online, ...).
> +	 * callbacks whose cid-form signature differs (set_cmask, enable,
> +	 * select_cid, cid_online, ...).
>  	 */
>  	union {
>  		struct sched_ext_ops		ops;
> @@ -1556,9 +1576,9 @@ struct scx_sched {
>  	uintptr_t		arena_kern_base;
>  
>  	/*
> -	 * Per-CPU arena cmask used by scx_call_op_set_cpumask() to hand a cmask
> -	 * to ops_cid.set_cmask(). The kernel writes through the stored kern_va
> -	 * and passes it to the callback's __arena argument.
> +	 * Per-CPU arena cmask the kernel fills from a task's cpumask and hands
> +	 * to ops_cid.enable() and ops_cid.set_cmask(). The stored pointers are
> +	 * the kernel addresses.
>  	 */
>  	struct scx_cmask * __percpu *set_cmask_scratch;
>  	struct scx_cmask *online_cmask;
> @@ -1669,6 +1689,19 @@ static inline void *scx_arena_to_kaddr(s
>  	return (void *)(sch->arena_kern_base + (u32)(uintptr_t)bpf_ptr);
>  }
>  
> +/**
> + * scx_kaddr_to_arena - Translate a kernel arena address to its BPF pointer
> + * @sch: scheduler whose arena hosts @kaddr
> + * @kaddr: kernel address inside @sch's arena
> + *
> + * __arena callback arguments need no translation. Pointers handed to BPF any
> + * other way, such as struct fields and kfunc return values, go through this.
> + */
> +static inline void *scx_kaddr_to_arena(struct scx_sched *sch, const void *kaddr)
> +{
> +	return (void *)((uintptr_t)kaddr - sch->arena_kern_base);
> +}
> +
>  enum scx_wake_flags {
>  	/* expose select WF_* flags as enums */
>  	SCX_WAKE_FORK		= WF_FORK,
> @@ -2302,9 +2335,9 @@ do {										\
>  } while (0)
>  
>  /*
> - * Dispatch a task op through the cid-form ops_cid table. Only set_cmask() needs
> - * this: it takes an arena cmask address instead of a cpumask, so it cannot be
> - * invoked via its cpu-form set_cpumask() slot.
> + * Dispatch a task op through the cid-form ops_cid table, for the ops whose
> + * cid-form signature differs from the cpu-form slot: set_cmask() takes an arena
> + * cmask instead of a cpumask and enable() takes scx_enable_args.
>   */
>  #define SCX_CALL_CID_OP_TASK(sch, op, locked_rq, task, args...)			\
>  	__SCX_CALL_OP_TASK(sch, ops_cid, op, locked_rq, task, ##args)
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -961,9 +961,6 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init_t
>  	taskc->highpri = false;
>  	taskc->core_sched_seq = 0;
>  	cmask_init(&taskc->cpus_allowed, 0, scx_bpf_nr_cids());
> -	bpf_rcu_read_lock();
> -	cmask_from_cpumask(&taskc->cpus_allowed, p->cpus_ptr);
> -	bpf_rcu_read_unlock();

Can we also add a small selftest comparing the mask received by enable() with
the immediately following set_cmask()? That would cover arena-pointer rebasing,
mask contents, and callback ordering.

Thanks,
-Andrea
