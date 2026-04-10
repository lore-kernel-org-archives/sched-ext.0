Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11A38F658
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837075; cv=fail; b=haULN+ELscjw3Ixgv7PIW6CSLkDFhaYdUI3qf/KWBmcIkrzZzI0K6s+7o4x4KA+WAmkMJg2G285yMM5hKAdY0AZCGP06bfn3hNEY5X5UwZxN1x25XIl1C9uPeDrpz1XLAuV1WzNH3vAOZchniD8+BFOLN2Z1DYjjC+1/QulUY4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837075; c=relaxed/simple;
	bh=FQIslUbiZIfHyb/fls21ISzABJUO9A9fqigrkXodN5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DIGPWw0iA4y4B3OYgNyeqNvFxj42R8i/dgN0FIK/od94BTPHBayQkICD9SQe7j10dliNIccJmqIF67gF5zb4yYUlCJi5KmHANahpX09yFgKj/KdFvYojni24syl0uGYl+AgbrueCzPBHqY6dQBCZy8EYKj3kWA4HBQAMl+85HlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qBz1UEa5; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qBz1UEa5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFgxamBFKxCZAqaS1GThPofjJFqE945e82XFYgxKXgB6AJ+lfdljDhMhTtkdewkcB59oZUcmpJ0XT8VIrYu2ZAQak+AqRFW4ypyR3UH9MNEf9r7eb6ugMZ33yYT1PAJrPWPfhk1Rz9GaTAItuN+Fu5DevZDsng3ggHZOVbX4yky1LBd4mjU/NsdLpwCLKkq0UzlWDDOhYNxsindwjxewJBMtp+pMXNeQAvVTX4JZ+fUaTvrZ3p7IEJKkuhlEPKxgmnyvU2Pg1bNPNEgwedHDKSATzOqzelTzur6qob0zPj295hdVfCo8e7TpyKQIPoXqbZ8G2Vzw25o84g8T78Y63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVr6FWitLCqAsdzbL0WGehbVam1iGa7+GXrjGhcABZ8=;
 b=Gep5AfiqQG7xDhoRYNP/Uk6EtEgVXs9NBFZxklSYClO4MktzCmHEkQtkDeyKFmyC7eoWLT9XMYuELjN7wzG3p4voUgmixNowTaSG33ca+kF7zopYQi2rm2piv3uwGgzhPqDjYra3MTFlrUzmt0w5ofwggPiSyO9mWQINCFLX8WJqmsWg76n2aJw4iVyG5oE7pA546+mzuvcCmHtkvDAqqV2lfXWVGFRsTaGbNohhbQvxzf1iN0Yxh6QEgZ+l5yzdopkNDphB7OVDvvZxh7SBnVJJn53FeWyOAlhc1OyuJ4bnpeFUmntUvmoaHpuqoBJlkx4MIqQbDkphLhLVe9ms2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVr6FWitLCqAsdzbL0WGehbVam1iGa7+GXrjGhcABZ8=;
 b=qBz1UEa5yiZqCTvwzQTtJR4eYAQuUBem4iYQcRVeGFOE+Oe6dS8mH+zfmPoxUS6Gw0UqkTB7q5uy8o92GFtk1j6d2wd9sFUakwrxmcAZjlI5fpt8WKioZ0WkugHxgx9O/ur9HG3Dv2eRZrW/YaxG+fulYpnJTgStH3giJzx5cAW1PoNZr/b4FVhMklhCbRbxAi5KghInd/bUS/gjwuY86ivTvvZQ/v4OF9BTblx3IzI8DkOJxz8AkUE0tvWWPEbSnlsq5Dw0ptUgHGldjIrT4R2tkX19GjKVABSnCP2j4GBHBghWmPRCXkMcJ9M/WIXaqEOLg6Ss0xcd+UiefhQqTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 16:04:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 16:04:24 +0000
Date: Fri, 10 Apr 2026 18:04:15 +0200
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
Subject: Re: [PATCH 01/10] sched_ext: Drop TRACING access to select_cpu kfuncs
Message-ID: <adkffz6gR0vGKgqX@gpd4>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410063046.3556100-2-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c71c54-76c8-4b20-42d0-08de971ad59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mFMatTFXNIGKV7wez9cDSOAr94dQelA7pEhqXV6XBbOz87fa4vkxLFGC5VTUm/kgPQ0rDCVBgosKCCEHxD4mS2CpIIWyXj/wRB6laQmM+OBofJs4JfssyIZPfJqADMH/esKaZri+1TJey66Z8d3dyNC4gC9myluWr1KT9l35mTSyZ3yiVbHCqvbrwJF9TnU/g4BAirEOS07DpqNyxHNNWULgdbrnsydhHAz/dTEz0CTh70rtpcknX0Gvp49rcpbLUnKNlU1z+tmMf8uKSuCCf0SGfFM4gejazBxCbOKUvHT8EA92pZouuPYtdI8LAU0nwhIO9QpWH35VEI74WOxuSOC7chBJAx2qRf2474n/ogOzswd8UoD6CWYN9CYCkKyq6SAfCS+fKcZ62MRrX5LnNVIk8J6VnoUAZgkyv7SwwYHkrj28M6ZK+cpfYptEFFLQT0R7sRVrp61XvX+le1nDSo4cgpW/bsUYmDuELoazGdZWethxCddxEJa4JAJ4Qm6RSP8ZQaeKZ0t/HMwkTzeFHhB7Gaql5kIlWYTvY4ArXyjQot2z5dYcz9HuuO9Rm+UI4BaJFYcJjWorfoLJ7SmofwiADqDuSL3vBt5GamrbMtRxU9rGTbBpehHnxxwajig3nZhOTgOocV+bQ2P/0G3+XuOw2/HejASL05VQ7MrMeWUC4aYjp5BEmNn88mz3gGgGN0oOiqOF09LYjFY0Vd6R+8rfeoCZcEenMVKrWlcF5wE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Zxmu6a7VptBlIvD//LsDvBcYJiSSZbgWwG1H/9uzfeiI0lOlWsrml57N+9r?=
 =?us-ascii?Q?ipeU/xWAQ2TbWbp855P82KvJvmGv6PY6+IlZz63Rf9S3ucgwLgUA/5KkkKTR?=
 =?us-ascii?Q?+hwdEM6I13UlMtk/vZcv8CI+8Wjg5+26mtNxQkjuRSJ22h+zjhcUKuPEKkMN?=
 =?us-ascii?Q?gcY7RX310exY8dq5Hq63Zuh1sEWDiJX57tNmjaN/aVndE3pnVqHvGPhiy83U?=
 =?us-ascii?Q?n4cdCCXCC6F9XIqETO3sey9xySrT5BzwA2NhnBdeLyoEU7OwEbPu/5PZKqkQ?=
 =?us-ascii?Q?a8kHUJ7+cvFI+C60jF+UPDmB+BM3xpfPwdyxvV9ZyetXVRqL1GtUo1fuMIHG?=
 =?us-ascii?Q?tH6eNEZVVRZ8ulI4xnyzrkVLu1Vzg2RkjX1TWZGrmnOvag5ddY0GK9vpMhua?=
 =?us-ascii?Q?AYW5urTcUYdkRO8cG75okutRbWFMU7MZORzmfLzS0FkreRoeoWViwbDf7jpC?=
 =?us-ascii?Q?sI5sExwalgBg4s7lyIhLPz4cT0cxmg9HaoidUKX4tQPEycGsjDjLVQ7BmaXK?=
 =?us-ascii?Q?F/3Rk0sUXWP1vfBEgr3y9xjNi1fLyi/fUb2juVlUbMaGfnWa/n5wfV8/5tDC?=
 =?us-ascii?Q?slPji1FH/7M7nPy9AD9Dc3M87Ly7D3rB0qScUv+1hmMzTCVlImTu3kPkdcbp?=
 =?us-ascii?Q?GmsbJ6L2qggW0YbLvT9N0iBX2CJ1f0grBEMbYRdfeskxaAuKmvpmtsO1ni+r?=
 =?us-ascii?Q?D027q8l/tnLqR2sGNdu436rRdJPUs2VBIZ5Jdu9ZovTX3cyBLI6Tzn84Zjw0?=
 =?us-ascii?Q?5DKeI74Ez01bwQr4ef3jtfaCT1dhafYuZOcyNN5PPDPHYjOtE45V+noesQyE?=
 =?us-ascii?Q?+bErdO7UeR9cB8FvH0CdMo0zgLg6grbQ6hEC9BJqUR75D+ykMTaBojGUTEf1?=
 =?us-ascii?Q?Erf+70XhJtOw8uONX6RxKIVjaBCHQee3qGS77HVUiQO2Efgek6z2pC259u8n?=
 =?us-ascii?Q?XH/apFT1AnP5gbZgUPPrMgBeFU1W34m930hyp9G6dCYedap7EXpa0R6pfsUm?=
 =?us-ascii?Q?iTZeg85Lh1Zi+6C2upDEm0qqbNqkpsl6Wju2nJFjD+PmEVswoNC80grc2W/H?=
 =?us-ascii?Q?od7tsQdTSMExhJFV0p9EreFY1DoW8iT1E0djqT1stcYzgcc4JVh0rItftYvs?=
 =?us-ascii?Q?CbshrMfE8SWZqvwX/XwfMMozRZ5nJq1+OXs/puYJqycLKF8S1ac5kjPOrpFl?=
 =?us-ascii?Q?3gIEKC+tnyJzEwIz96f0UIAWda1GeXLPV3bskGh1u2009jSXIBk83lopBfNM?=
 =?us-ascii?Q?WeLrzH3pnpRy4mulzBPjTNiEBYSbsSPrEZb1VnPbNoGVJVYpacxGLWX8RxPJ?=
 =?us-ascii?Q?HYPRtsdPq9W/kZRFRBmYmep8LBm0KkRQRxvJq3FbVV9TalJKcp2c3mKyE1XY?=
 =?us-ascii?Q?7nCjZeOzaST/UKWfg8M3hdg13vpndh0Hs+/3rsNJzLpmhKDjhsf5yvtah1zf?=
 =?us-ascii?Q?RSiCc7TnuZjNVGgaXYqScAgeedV0R1dowbgkRoEjDKyNEMry1iT0uHSVBKv/?=
 =?us-ascii?Q?Up6ihUxa3mzlVa/sxdpC15+a6+nziBhfd1zt13M9y9/GY54rmIPYrVb+7ddK?=
 =?us-ascii?Q?MNpNwSCGAWZDUyCEGdQo1Z6aYYvlO8k9tGbXgE8vYEkrclfAObK+kDhHRycO?=
 =?us-ascii?Q?UiRhSAJhMAsgA+KUb5g3chIBynlhZ/W1Q9t1V3uwO/0olFHlTvN3tdUR0pOl?=
 =?us-ascii?Q?13TpIxAyUQAMpUQOBolWUyYWVU6C6VqbR6T3rvHkQrNzhtsQy1pVY3P6pB3S?=
 =?us-ascii?Q?AuI1ZXoI3g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c71c54-76c8-4b20-42d0-08de971ad59b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:04:24.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJzVxCbjCwHsm1tDryo2oygxHEEX26qm1a31cCXEjoNGp+eyXv7Td/9AOZ7CAriPx0yVKwiJtwA29kcmuWJFkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713

Hi Tejun,

On Thu, Apr 09, 2026 at 08:30:37PM -1000, Tejun Heo wrote:
> The select_cpu kfuncs - scx_bpf_select_cpu_dfl(), scx_bpf_select_cpu_and()
> and __scx_bpf_select_cpu_and() - take task_rq_lock() internally. Exposing
> them via scx_kfunc_set_idle to BPF_PROG_TYPE_TRACING is unsafe: arbitrary
> tracing contexts (kprobes, tracepoints, fentry, LSM) may run with @p's
> pi_lock state unknown.
> 
> Move them out of scx_kfunc_ids_idle into a new scx_kfunc_ids_select_cpu
> set registered only for STRUCT_OPS and SYSCALL.

In addition of being unsafe it also makes sense from a logical perspective to
not "allocate" idle CPUs from a BPF_PROG_TYPE_TRACING context.

> 
> Extracted from a larger verifier-time kfunc context filter patch
> originally written by Juntong Deng.
> 
> Original-patch-by: Juntong Deng <juntong.deng@outlook.com>
> Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext_idle.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index ecf7e09b54ae..cd88aee47bd8 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -1469,9 +1469,6 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_IMPLICIT_ARGS | KF_RCU)
> -BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
> -BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
> -BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_idle)
>  
>  static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
> @@ -1479,13 +1476,33 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
>  	.set			= &scx_kfunc_ids_idle,
>  };
>  
> +/*
> + * The select_cpu kfuncs internally call task_rq_lock() when invoked from an
> + * rq-unlocked context, and thus cannot be safely called from arbitrary tracing
> + * contexts where @p's pi_lock state is unknown. Keep them out of
> + * BPF_PROG_TYPE_TRACING by registering them in their own set which is exposed
> + * only to STRUCT_OPS and SYSCALL programs.
> + */
> +BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
> +BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_IMPLICIT_ARGS | KF_RCU)
> +BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
> +
> +static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
> +	.owner			= THIS_MODULE,
> +	.set			= &scx_kfunc_ids_select_cpu,
> +};
> +
>  int scx_idle_init(void)
>  {
>  	int ret;
>  
>  	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_idle) ||
>  	      register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &scx_kfunc_set_idle) ||
> -	      register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_idle);
> +	      register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_idle) ||
> +	      register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &scx_kfunc_set_select_cpu) ||
> +	      register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &scx_kfunc_set_select_cpu);
>  
>  	return ret;
>  }
> -- 
> 2.53.0
> 
