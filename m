Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A552E06E6
	for <sched-ext@lists.linux.dev>; Sat,  2 May 2026 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777700708; cv=fail; b=CuF+uq+MhmCX9zHKuv9nCqF/CXHMXs4ySSOhghtShyVz60YIsRxZ4UnOWofhy0ofWxaSpipjyuYcetXNkiv1e8ac9gPOCiN+yIfqcO06HgV/898R4FzpTxbIVDtysXgLQGy6opxakLNgtgFnrFGcRHEGwgs/2W4msKJjSHgdMIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777700708; c=relaxed/simple;
	bh=kCMBbrFYzAAbwb5Xuc/M6zYUYP4f3nEVIezXoZ5JJ90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bxxA8MWsyS3i9ztvQoyMxPyU+eKkfQtP2mWPhQXg7xJ+7Gf8pXckBl1PI/6LXuIsZ9UPdA5wW8f88CbVGcsPlGZ42Mv9suWrhvfwwzOERkGIjMoDHvlkY/5oKsRzD+p2dq6e3R+VYNWZiH8CXKAw++zPT8IrN/keTjglWOU+phg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dtgwhh4y; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dtgwhh4y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6T9lYLNvcpeD2+EpmfeI0kyWKR8BZ2C0kG2w5ESSfUsfdpG62hzssGqfDUnuUNCmAyuqfVy57SpEq+ZSfElc4mrSNygTuy9znHo1MsjhUeg6J0DjugMuVFhs19MeuHwjjNLOBK4oqojbi09oX6i2IM2Ub+Gr5O8kEht/KrlokLFbysrFiZEA4S1Ak1C1B3CGV3SJyCp98dkdqCt2v3NOgV1DNgopRMMEnKFyyRHH28qKpP3KVE2lCAMISUf0YM98RyD2/yP/dUOBGSohDOpgqQ9TPE1cYRj/IiY+D6bdqeV9unrOoev+RThidSOh1xF6qUyufk0NC6fia5QLwkUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EngE5M/5jAJQCn3iWs+qugZalCvbrReUij4HnovRAX4=;
 b=Rw2TsexGvbGGhPPeIVJV5bIpvGthqnr15RK5nDJH5B8Zri26fRo09Evmx0Lo/b+9Xopnn1LFR2dlvRnMryGsD998kQLwvJQ1PzmER+/+Jq2i0FmCM3biUY//AyTxF/f+V/Vwiy/e7s/k6XZk5hzc8hwI8fninrAUallnZDooR7uBZGNxWJot0d+JPfR3VI9ZCV3IcE3u7uoA2TBo5RXxsFVcGHGYI+MQHJLETxuG0lqWjtJOD49Nw3VQRcyQbc8+rUeBjcVNZ/b5esGs3g1/vQxD5jeYLkE52n6kkDpEmYB/Fe6Ho4h4d8pWf49gPo8dhx9do4ptEtbJkVwQe6Eb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EngE5M/5jAJQCn3iWs+qugZalCvbrReUij4HnovRAX4=;
 b=dtgwhh4yMBH+cQElibxrGMwrQdOvDGGJpTYnY5CIQRIiSvrMONrGrvqqnRT8ZZDwMiz6QtZ9WHgr1dey/p8voFFoG23nIg8mOdX4K6Y/IYMUe84QvclN0ov7g6Db33HvPyz8kEmHGOD2bTM6lVGPFwDN+PH3sjQaj2NHSTzTAkEoJXgWBJEADK0R5BNoW44xw/DuE8JnNWgzSO/EhZ86hllGuejnOFsH/+UfEZWXyDAC9E3c9OjfbK7TSfJg1IxmtDATV5k2Rcpv34aFe4NtqpcCWEO0vv5OnqBdHNHv6TFaCXuilHDbV8XlihCKi1R9kJWp70Np68B0z7jweog8Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DSWPR12MB999154.namprd12.prod.outlook.com (2603:10b6:8:36e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 05:44:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 05:44:58 +0000
Date: Sat, 2 May 2026 07:44:51 +0200
From: Andrea Righi <arighi@nvidia.com>
To: David Carlier <devnexen@gmail.com>
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
	"open list:SCHEDULER - SCHED_EXT" <sched-ext@lists.linux.dev>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched_ext: idle: Recheck prev_cpu after narrowing
 allowed mask
Message-ID: <afWPU8kn4ZTVwgMz@gpd4>
References: <20260430092747.73114-1-devnexen@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430092747.73114-1-devnexen@gmail.com>
X-ClientProxiedBy: MI1PEPF000008C3.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::425) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DSWPR12MB999154:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c49b18-579d-49dc-20f8-08dea80df1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	z8kb6cWTYsX1mgPqLvB0ZKAJLspgE/mEKsmNNI4/2t+6yCBnmSG6LWMfXNYZqzHeiA05nY7gtgtAD9KlBLhINp4TUWZnwzxIaPH2PF+jATmZhLlSuZjvufb35wiw09RVQMtDVC7ni1+jEPZMC1obBg96t8vZF9ci59HtkCzjPKgJU/6VsGteKc+GFlko2c6Bvz3ZKUo9qBf8Gg+WTqdzk4LFsVHcyxraxIiTTtbl0ksXyC2jbzMjOB6R9qxnzMVaoLg2sITVp+f72sQlSPK8uhHF0Nq8+9ZlvtLQjxBrZE3WQfyxTCo9LOIzNDmaSriVqjx58xLIXMCQ0kjesVgIF9NpfmVzTMoYBnwKrbhCkHYUj9PvJC215tEIhokrR0esu0oiBe8DB0Mdes/3wC8UiURlBBlGO03gKqRH+evypSei9FmOtzkTolVu19KJxxn+eJVTxY7LVoXGJjWclpcUlfrEJmjIliMELf4eXa6yJjWXgnjx7almDWM6irmlbWl+qcqS3roNm+Qgq3BjGI3muAwNg7xOATrKMkUp8rCLnOhxUq1CMb1gzJPcjUl7k6ZBwPwP/brwqv3S+qrkpEn0dKzHaMs1deaxi14ggC9rvofqJVoCW7nVW5esVNr1HWvMDnX6sb/KrbfHI8nNgzwWAmwXa8AfNGjxCx0MZmwaBTS1h4O9fZyNLD8H3FKXNWnm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y2BMw/Yz4e+2XkO7CO9L/tI4+4RM0SCWEDn12MzUAIJuItlHiwsJSlfTI9ta?=
 =?us-ascii?Q?EV6I0hVQfuAq1TGiSj75v9FC9WSILa+Qg8FmDxpu+C6nsyjyDcOMdAeMf96R?=
 =?us-ascii?Q?tVRbEFyZzntYV0/L8syCWJ1p0mfhUyOqvGEx+vvsONMVbLZ8n6XADYkKQrLm?=
 =?us-ascii?Q?ITuYWxTR3RM4zs0aG95kkCCMCAOWpVttrJimoku4Ni72ggzhcV3RKmcFcl05?=
 =?us-ascii?Q?hzPxF17JCq0CgYaZmLHmi31Or9vGjYW2fLO78fNllkjj7L1iUBCGzDcY5o6l?=
 =?us-ascii?Q?zqdUY/fFocyFL99iUjW0q985+oKMOvtSkuFxajywSp/wXITUtMaYmztz4CRj?=
 =?us-ascii?Q?6cZDoylglvEHnOk/gDy4ZgERd9T2MypoMVGvylvffCrAe9/VIH9J9mVXYAuz?=
 =?us-ascii?Q?/u50mW8n/R+7ChgDpx938RYjzMbRGpeuo0Sl23cmPZZMx00ERCUThctTKSOs?=
 =?us-ascii?Q?/nH83xnV4T11Y/Vd3Jp8I4Ol0D32fXZbuqQ4qpF/N2M/z0Q8TbgV/I1NrnJJ?=
 =?us-ascii?Q?9pgIAR+v8LAV2MUDBQEGmHy4b7+lmSF/p8a0BXIKtOtPVneSJdAzvhiwg77b?=
 =?us-ascii?Q?7BFj29gXCFOjpcVV+CLNBE9Rsqi0EAhv/9+nwraHBvBYhSiIYE2g3ihFxzQG?=
 =?us-ascii?Q?ayfBG7iE4ISxtuKTWm+v+rCE+wih7NYtwvk62fA9uSZb5gjaUGDnSMwMq3AJ?=
 =?us-ascii?Q?i+Q2YJFpEGgVO8Yd9uqddtK0rHU4QQNRQSAsQmBKAlNgKo0u04a2MxEZr1Ye?=
 =?us-ascii?Q?r76Sdk09b98ELLtHazCL2IfjyHKDS2JuO5mldnTQ0C3CHV3S0W8auMDmbKzm?=
 =?us-ascii?Q?cqvfjee1f8S6sF1unRPK6ttF8Fo/PdqZdIMcfZZnLbB7mxEqISqixNECrNQV?=
 =?us-ascii?Q?InnueLnUJhx07n8Z0juAuAn9awcjDKFE6/VTTthMnDKnl1S2zxcUliBFrZaq?=
 =?us-ascii?Q?kRePwq5cMC1O+FNq5It1QAJx57zTrRxcm+mJkzqH0txwNk5LsS64MD3Y4BIt?=
 =?us-ascii?Q?9h9AWZUxotlbMoTD2nvMSUO0xbBhNYbTONS4aR8w4Os4m9d+UrUnjv0LiMWb?=
 =?us-ascii?Q?pp2iewX8TKLn2XEmBS5X+KaPkZe+c9RUO2N1nqO2XxT5unrox9cYAaZX4PKL?=
 =?us-ascii?Q?8UeugdAdo3U6LnKosyeLkfSkguFob/jW+0SlDDJfbFEGCDNOFib+PPsstVIp?=
 =?us-ascii?Q?W5XXDjOgzeG0FasFEEGDXR5zYnRKMp0CrPU0uxTagwluww5tKIOEKC/gU6kM?=
 =?us-ascii?Q?Flx/Mk8n5L6csxWr+5dCmtVgnPVSDt3F5B03TZNmG8lIutzyZscwmr3VBZtO?=
 =?us-ascii?Q?x2Vc+M5akfvxFBC4ppX0T4EYttRnizAxBi+2WuIdI/rWVdbHEAb6Fu6nuXfB?=
 =?us-ascii?Q?JJCohTqSnKjW4yJKVIvnWzJiYGAk1WoIR29FF1GzDQ8ppuugSXjWizuvQQOW?=
 =?us-ascii?Q?1CKqZvN7+93uJ8i+DqY//TRAVwTguFeYbsKlXojZrQ+bdMV/JdDHYhc7PP9o?=
 =?us-ascii?Q?hXJ05SZ9Qb+usLNcJ7WvOnJfwckvZPYciyYeqSVjHdzhW7arEJKucUW6U7Db?=
 =?us-ascii?Q?CG0zP6EgZRPQgQK/BonrPCGqE/Dl6jrfw6S53nlkq98K+LyLbB0WJK86kPwi?=
 =?us-ascii?Q?u4aqHl2updYq7orDF1b/dhfSd8adfcq3p0A50h/BcMLi26krv45s0x9dUU5+?=
 =?us-ascii?Q?E9x7VWW5py5ISqQrxaslzdOD+CbZRMw6tuWYr7LuMpUyeVZYNwBF6xhg/tn1?=
 =?us-ascii?Q?dRF1RKZk8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c49b18-579d-49dc-20f8-08dea80df1e9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 05:44:58.3590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVv/xao1Ue/zDo0J3QmkK4wBLLCTNLLhXTZHR0hv3diG3ajQCWW4nv1bjM9zWa5K/5C+THd4HeZKg+oGx6Fa2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999154

On Thu, Apr 30, 2026 at 10:27:47AM +0100, David Carlier wrote:
> scx_select_cpu_dfl() narrows @allowed to @cpus_allowed & @p->cpus_ptr
> when the BPF caller supplies a @cpus_allowed that differs from
> @p->cpus_ptr and @p doesn't have full affinity. However,
> @is_prev_allowed was computed against the original (wider)
> @cpus_allowed, so the prev_cpu fast paths could pick a @prev_cpu that
> is in @cpus_allowed but not in @p->cpus_ptr, violating the intended
> invariant that the returned CPU is always usable by @p. The kernel
> masks this via the SCX_EV_SELECT_CPU_FALLBACK fallback, but the
> behavior contradicts the documented contract.
> 
> Move the @is_prev_allowed evaluation past the narrowing block so it
> tests against the final @allowed mask.
> 
> Fixes: ee9a4e92799d ("sched_ext: idle: Properly handle invalid prev_cpu during idle selection")
> Assisted-by: Claude <noreply@anthropic.com>
> Signed-off-by: David Carlier <devnexen@gmail.com>

Makes sense, good catch.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext_idle.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 41785f65bbb2..bbb845f36a0a 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -464,12 +464,6 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>  
>  	preempt_disable();
>  
> -	/*
> -	 * Check whether @prev_cpu is still within the allowed set. If not,
> -	 * we can still try selecting a nearby CPU.
> -	 */
> -	is_prev_allowed = cpumask_test_cpu(prev_cpu, allowed);
> -
>  	/*
>  	 * Determine the subset of CPUs usable by @p within @cpus_allowed.
>  	 */
> @@ -486,6 +480,12 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>  		}
>  	}
>  
> +	/*
> +	 * Check whether @prev_cpu is still within the allowed set. If not,
> +	 * we can still try selecting a nearby CPU.
> +	 */
> +	is_prev_allowed = cpumask_test_cpu(prev_cpu, allowed);
> +
>  	/*
>  	 * This is necessary to protect llc_cpus.
>  	 */
> -- 
> 2.53.0
> 
