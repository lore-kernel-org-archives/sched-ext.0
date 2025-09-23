Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE01274B55
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615083; cv=fail; b=HgjVNL9KXgnuVSUWpFGqyeUuieI6b3+rx7PJ8WfCAeNgWfB0sGnmdc148NfwA4sl4FWM2dzXa4Lnbc7iRn1geJngoRxJ0wIcgxTF/ivv16Zcab6cu7z5szrrIwjc6dX7OigkXwuRPdnlLvnn/qulGJdscKNxvdMH1a+fVIw77iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615083; c=relaxed/simple;
	bh=FAuZA/fGhL5Z6tEMU1yD7DNcWWo7FoQHG+FiFLGGjv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hh7gBnLzJjfDsFwo8/ZU1AJfo03xjZ27NVC33+R/ynpV/AuoQDWFGCHdXtjE9TcdZIC4cvWGWc84pcm8AKlO1PZc963FJ71bf1gJrhS831Pmlo6jldmOoISWSi/KYcLmShqHcm2Do4aYqBAzASRer/IhXEbdyoA2g/PTMbGnKM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VQRTjGzR; arc=fail smtp.client-ip=52.101.85.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VQRTjGzR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgZryo24SCDKIqhZNd6reH8A/qsrdFlIjocMLIK+162fPTJRMmidIpGh+geppHqAq1PIr9a/l/Rr2deRZ+oYdvACDbRvWJ9ittaqODAX8lPutO7v/DXwfD9B4dYvVbcXrUp4bBQFcXyqwsKiTytFeWt7tr9rW9NLo51EwltXL91apyvwgd5Z3Ji+pa7SuwyKfblYDlDCwdFdvZxrxu5rB6SqujcddF3RW3+HvfaLgzbqSEKPqxFRRF/3S4UUtWDpltMu14lDC9UZsoDhA7vbPQQ3FxpKW6hKrdAWUA+fpeEiRLuv8I2JC5xRtGlc+7ioXsWvjH/nyh0e1oZpv1PXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtXUj6JrC4/ThgB0ID2AScAsmbqRXyvd9XjB9BuwA/Q=;
 b=vR/UHdcEmJvTMEizTDqTELYjAJZA662+rIqnKpOFEemZV6N6AyaQjz2/J92SZpLYTPCNqZ5opBbtK7NmYJ/hReU/kJa+eAl4GLP/LLNXFqJoVhGf5fZGCuOIgsNem93nbKtCYdFV7uSZ+d1LlQbRLV4ay0uYCuCxYsovUD5nt8EYcsNkF1z+6lAOECzFr+LHwKeow2O5cmZ6RSD3hSHR3LL1nM0r0Tjc+vT8licHX/V7N3RgYwOevMT6Etlc2gilma1EyD30U35lWjIHsZyIGGJ7hv8CIUd1nHRIiovw4UgNnvtX4MwASPmcQaySsIN+YuK2I1uIj3FeQSrC4aj+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtXUj6JrC4/ThgB0ID2AScAsmbqRXyvd9XjB9BuwA/Q=;
 b=VQRTjGzRpwLYPUhxk3lATmJRt20XJeNODQBq6HXS00PtRrqltON0NkvWHrJe8Ok/jZFXnAdr6KljEjB1UstoCUj1Nm+DGnIuPDGiA7AOBcJym+WQBnyVZMu82+H8FtvUwJtT6ptJlKratoa8jOg7OrSRD3MQUy8+LRowCUS05P8FTyVw/vFa6A38k+km/eIdDqZ390DD8051zJk8gT8BWKuxKqMmHJFhzhs9/wY8+0pxRQo4eQE04WOUFDPIWofF/5RTtwTozgwgkFZCH9hmSt0itO4AuLmyE1gXDulS9JpngOUaJGWSKc2f+gDo2y0MEL1HhwkV1XDPVssju3hPCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 08:11:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 08:11:11 +0000
Date: Tue, 23 Sep 2025 10:11:06 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 7/7] tools/sched_ext: scx_qmap: Make debug output quieter
 by default
Message-ID: <aNJWGrp08ucA4Ov2@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
 <20250922013246.275031-7-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922013246.275031-7-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0101.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b85249-6b5e-4a4c-de11-08ddfa78c21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QtZa3IKpWl173QAQg7Ll+dOpojnmy4gWm+O7rCLrNKhnB6ErYkxusDP0Wp+?=
 =?us-ascii?Q?JBv+18FTR8Px2KGbCsVsUASrgcAAThArXOg4JQA1DGYh5wsF2c9WxF2oxXfy?=
 =?us-ascii?Q?3RTslLfqY15lf+zfubPfYBlgofFMK185tHSaJ7DVXrp9F880F+03UFR1ZJHK?=
 =?us-ascii?Q?wjURqLrFAx/TifbOMMlc8zQviX4tHb3icADOnGNyXvoHAoZyoxtmb5tJMwLB?=
 =?us-ascii?Q?stPfmvcg6IL/DEZWYyAgFI5zT4jTYqkHXVQ8nmgCMULOFrAhgC0qJa+nTwfV?=
 =?us-ascii?Q?b7JWlku1c/NHiFw9V7/90r/rYyt+QsNcCFndL2/dwJW0e8+u085XtA5CY02f?=
 =?us-ascii?Q?7hwuqs99FWu5YAEHCv/QUtVSMFrkA6nmw0Cx2xv/qCepanwNEtTnuwj0DYvl?=
 =?us-ascii?Q?anPE5byBwUnHX6mZhGu3r/PMzE8Pkw8afDaI0olh/bKIrzsTGJHlbFF3z3Y4?=
 =?us-ascii?Q?plsPQN17Pq2M6s1RqBjEblHdRD0c+vvDEy0+InGozoTrHgmoQ9y33C38z+7i?=
 =?us-ascii?Q?sZxmVo21L6TnXlqnrabhBCnfRDYUYOJxf+uU+EsOfNTaoc3HwW7d2ydtoPad?=
 =?us-ascii?Q?a+wiyojRKqZmXsRxYt8fLFHlB1yy+k39RhWESVznreIvLRRkFXOMoYmAMp2n?=
 =?us-ascii?Q?la9drOhAbEIEJxv7h9fDOnp+K7LN8iryIPEvM3lSbntxNN0hhFgGc6Tgj1zI?=
 =?us-ascii?Q?I7Gv7bE5PPT7y6EKK91vZ++xtFrEwp5JVNA3SJIrA6ifsjLr4/9oO8IMm1fa?=
 =?us-ascii?Q?o2Zpu6Z6yH83Bg5SrAf3SkxsM9Js4PFS/BmQghbo+YN9cinKnkHT9cWjL3gf?=
 =?us-ascii?Q?3nMfUxxBznVUlkG0LeWprzL/UkdDFusSMUSDdqRJJ1YFZ94EOPQEnBDXjEmm?=
 =?us-ascii?Q?NpjMn6U+2KLRL9eUFMjJ/r/v3KO4nlKE6gRG4FIBQlfwP5FYYFd9eHkyNjtR?=
 =?us-ascii?Q?R89HPU0eWEkh8JfbY1EVYal4TvPwHFZ3Jq7nisI2yZekA1LItwGzORAx6bHi?=
 =?us-ascii?Q?8SL9TUEgtlDp0R6HQz366idj2gBNDdkrQSRiDlEbJr7IPRlxqNTaqMNNrSyi?=
 =?us-ascii?Q?xdntkakpk95VgWiYlfJiFfvtX7oSakyXnd2qPzpdE5W+OGX3saoKVecfSecB?=
 =?us-ascii?Q?Q743Y32nZTM1yRkZe+uUbUEsuMEfUJ+0jAi7uUoNOX5nQ5s7+8PSR7VsAKA8?=
 =?us-ascii?Q?JXYh8R9BBuL9tALCUx1P25ICTLWeDg26r/Cv2ByMvNPCaYrfRA/D+qyAwW3T?=
 =?us-ascii?Q?+iqnMgVNYJh/RxEocmspqhD+0/X1ZJMYc1hNYTG2Lke0NlzjtRDWZIZJEfB8?=
 =?us-ascii?Q?Z1htxo8xxJfoX58dW4Npx2mNcf6dztc/ZAzSTFoT01GxE1puE4kT93sP/eJP?=
 =?us-ascii?Q?BDeMlFtuC0wL1Fcr+uXOYHLfZXc8t3qFJ7ZwUiZRhGHhBJn4jPV8Teu5CuHL?=
 =?us-ascii?Q?EYZXaQ5jCc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pGcLIgg9bdix7IuLSKDot+QADBvaiZAy0T0jQgv5Zs5Hp1ERYrRSf3DAqqZx?=
 =?us-ascii?Q?rlz7KyuRw1g0t7rZ2TrU0fur7z1eSJQTsMl2q1ozCD9uMzO6rIbhRWydYqOe?=
 =?us-ascii?Q?hQkTVaInS2ieHTZloZuaRGM9TVlxM8QBzXmtTmaDBovdXjHJtxE5dpUoPnty?=
 =?us-ascii?Q?sC7TfK+INHJAq3nUjj0pc+rWIjmk6Wchq8bREIHU9ZwrmJ/c86kIjaFs81jV?=
 =?us-ascii?Q?f7eRBibafIvpBcr9ioEwaTykb4JYv7INuuSAMNPmPLj86jw2VTLYhMDJHPVw?=
 =?us-ascii?Q?l48b80TR+o9xpyJuXt7MesutVfVyZiuQbFTLmfFxDWOxHjeQ4PADIWOljoSB?=
 =?us-ascii?Q?KwVvuB5oReFhWBSLJ/4jbt4rVed2PLB2SsQWf/URia3QCpItsm3XQQDhRkOl?=
 =?us-ascii?Q?UzxSsqiDKoTv7UzP7fNJjE1qBwesYEUm1tj5LuJzUn/kGUQMWbsngbzQej1a?=
 =?us-ascii?Q?xgbMzZ6mIahssS7/tysJ+AyPdFzzojgU7BHWlMyyV6io8f4mv4k00IO1sLvi?=
 =?us-ascii?Q?D1SP3AapazkS87VivoBKqJ1q54qYxAV1XjDCO6wOIaKZI4ac+/p/D55cqIiD?=
 =?us-ascii?Q?t6mnCRQaKjq5o34s/eNnxFmKl3mGzI2Fq44awgyJvWjELWhcuHOdjYxsDc90?=
 =?us-ascii?Q?WJmWMDXhuLib9FKBjwcMh0oCoCnEGjgwDeBu+HLoxX0RQW3luKTvJdYWCe1N?=
 =?us-ascii?Q?YwbUixVfp9ZW1WSs2H3vA85TDEdhtXhto+uJrVrDs4f/ydPEVquxa2A7Cd9R?=
 =?us-ascii?Q?08Ui8o4pcZfrcMQqymt9qoNcTWq37E14XKGYjYeVfrgcAZvyutoLVIaEupJM?=
 =?us-ascii?Q?H2zYCNokXKNMHkVIpFGkz4uCbz5K4rMaEPCug8RHa2NzgFmWY+iTtZL+vB+i?=
 =?us-ascii?Q?thAuf31gI6UpZ8nkw5GOAZZyym1hTIioB+9ltyiZARVmC+ypD9XXsjAnzGst?=
 =?us-ascii?Q?S3ZEKFbUXpA4s3BWzUKCvOmnr3rW6R5jMm6r/oT9lR+godXnwN8zESFbRYWa?=
 =?us-ascii?Q?suqIlOJs+98/+I3HODZDWle2UtW2+tAo2UnBggXIHAgkdTxGTgvBy4tWo06U?=
 =?us-ascii?Q?GVci550L+WhE2yGCwNzGP3jGa45gULcDYqM4GRqBAfJJhXS5lGFYinR6SbIy?=
 =?us-ascii?Q?AKET3lKeYMO8itmT1NwgwGWKy5nA43tF3MfjSwU8pMQVaerHhxg4RWFuc5x/?=
 =?us-ascii?Q?EeD34BBlXFEImNfrTVXD5fNPGwEMUZb95dI9YkQGqzmvSdhl/WPe5JqJV97M?=
 =?us-ascii?Q?OoxLjyfHLfCL+OouIE33cqc2p8oYNTPTe6DKf4gd2/biBX3njfN/a4K321hZ?=
 =?us-ascii?Q?sCeKjgoZVkDUm4YzznPFO8X7ibUVv0nTUHpAhTYS9+TEa4Ro3iRWWzDiwQmT?=
 =?us-ascii?Q?n51ixX/F47V93rGqY3+xGztisjItepWXcfRwhzDaYEcZJ9tvO33gqtUfnAe0?=
 =?us-ascii?Q?AcJyLAdYYObFFpHbRpKhByUu8VgTlUI4H8lwc72e80K1A6GbVc1lZ/Dkzlqv?=
 =?us-ascii?Q?cX+fZ6ktBkiquSr+mp5eebCk4OhL9My9H4/1Lpfw0v7HtNLMEJk443APTb3x?=
 =?us-ascii?Q?oWSB1BGOUhJ+ncgO2IrY9rQKWqDKYgit23qzAJtc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b85249-6b5e-4a4c-de11-08ddfa78c21b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:11:11.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DXFz9jv7I18fHu4z9mOvXFZKiskwdwzAOpXqkHuUz/UL2d1JaIighX1bSG7vNLLmI1IckjBTt0UvOu/n34TMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129

On Sun, Sep 21, 2025 at 03:32:46PM -1000, Tejun Heo wrote:
> scx_qmap currently outputs verbose debug messages including cgroup operations
> and CPU online/offline events by default, which can be noisy during normal
> operation. While the existing -P option controls DSQ dumps and event
> statistics, there's no way to suppress the other debug messages.
> 
> Split the debug output controls to make scx_qmap quieter by default. The -P
> option continues to control DSQ dumps and event statistics
> (print_dsqs_and_events), while a new -M option controls debug messages like
> cgroup operations and CPU events (print_msgs). This allows users to run
> scx_qmap with minimal output and selectively enable debug information as
> needed.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_qmap.bpf.c | 80 +++++++++++++++++++---------------
>  tools/sched_ext/scx_qmap.c     | 12 +++--
>  2 files changed, 53 insertions(+), 39 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index cd50a94326e3..3072b593f898 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -39,7 +39,8 @@ const volatile u32 stall_kernel_nth;
>  const volatile u32 dsp_inf_loop_after;
>  const volatile u32 dsp_batch;
>  const volatile bool highpri_boosting;
> -const volatile bool print_shared_dsq;
> +const volatile bool print_dsqs_and_events;
> +const volatile bool print_msgs;
>  const volatile s32 disallow_tgid;
>  const volatile bool suppress_dump;
>  
> @@ -633,22 +634,25 @@ void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struc
>  
>  s32 BPF_STRUCT_OPS(qmap_cgroup_init, struct cgroup *cgrp, struct scx_cgroup_init_args *args)
>  {
> -	bpf_printk("CGRP INIT %llu weight=%u period=%lu quota=%ld burst=%lu",
> -		   cgrp->kn->id, args->weight, args->bw_period_us,
> -		   args->bw_quota_us, args->bw_burst_us);
> +	if (print_msgs)
> +		bpf_printk("CGRP INIT %llu weight=%u period=%lu quota=%ld burst=%lu",
> +			   cgrp->kn->id, args->weight, args->bw_period_us,
> +			   args->bw_quota_us, args->bw_burst_us);
>  	return 0;
>  }
>  
>  void BPF_STRUCT_OPS(qmap_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
>  {
> -	bpf_printk("CGRP SET %llu weight=%u", cgrp->kn->id, weight);
> +	if (print_msgs)
> +		bpf_printk("CGRP SET %llu weight=%u", cgrp->kn->id, weight);
>  }
>  
>  void BPF_STRUCT_OPS(qmap_cgroup_set_bandwidth, struct cgroup *cgrp,
>  		    u64 period_us, u64 quota_us, u64 burst_us)
>  {
> -	bpf_printk("CGRP SET %llu period=%lu quota=%ld burst=%lu", cgrp->kn->id,
> -		   period_us, quota_us, burst_us);
> +	if (print_msgs)
> +		bpf_printk("CGRP SET %llu period=%lu quota=%ld burst=%lu",
> +			   cgrp->kn->id, period_us, quota_us, burst_us);
>  }
>  
>  /*
> @@ -692,16 +696,20 @@ static void print_cpus(void)
>  
>  void BPF_STRUCT_OPS(qmap_cpu_online, s32 cpu)
>  {
> -	bpf_printk("CPU %d coming online", cpu);
> -	/* @cpu is already online at this point */
> -	print_cpus();
> +	if (print_msgs) {
> +		bpf_printk("CPU %d coming online", cpu);
> +		/* @cpu is already online at this point */
> +		print_cpus();
> +	}
>  }
>  
>  void BPF_STRUCT_OPS(qmap_cpu_offline, s32 cpu)
>  {
> -	bpf_printk("CPU %d going offline", cpu);
> -	/* @cpu is still online at this point */
> -	print_cpus();
> +	if (print_msgs) {
> +		bpf_printk("CPU %d going offline", cpu);
> +		/* @cpu is still online at this point */
> +		print_cpus();
> +	}
>  }
>  
>  struct monitor_timer {
> @@ -799,35 +807,36 @@ static void dump_shared_dsq(void)
>  
>  static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
>  {
> -	struct scx_event_stats events;
> -
>  	bpf_rcu_read_lock();
>  	dispatch_highpri(true);
>  	bpf_rcu_read_unlock();
>  
>  	monitor_cpuperf();
>  
> -	if (print_shared_dsq)
> +	if (print_dsqs_and_events) {
> +		struct scx_event_stats events;
> +
>  		dump_shared_dsq();
>  
> -	__COMPAT_scx_bpf_events(&events, sizeof(events));
> -
> -	bpf_printk("%35s: %lld", "SCX_EV_SELECT_CPU_FALLBACK",
> -		   scx_read_event(&events, SCX_EV_SELECT_CPU_FALLBACK));
> -	bpf_printk("%35s: %lld", "SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE",
> -		   scx_read_event(&events, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE));
> -	bpf_printk("%35s: %lld", "SCX_EV_DISPATCH_KEEP_LAST",
> -		   scx_read_event(&events, SCX_EV_DISPATCH_KEEP_LAST));
> -	bpf_printk("%35s: %lld", "SCX_EV_ENQ_SKIP_EXITING",
> -		   scx_read_event(&events, SCX_EV_ENQ_SKIP_EXITING));
> -	bpf_printk("%35s: %lld", "SCX_EV_REFILL_SLICE_DFL",
> -		   scx_read_event(&events, SCX_EV_REFILL_SLICE_DFL));
> -	bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DURATION",
> -		   scx_read_event(&events, SCX_EV_BYPASS_DURATION));
> -	bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DISPATCH",
> -		   scx_read_event(&events, SCX_EV_BYPASS_DISPATCH));
> -	bpf_printk("%35s: %lld", "SCX_EV_BYPASS_ACTIVATE",
> -		   scx_read_event(&events, SCX_EV_BYPASS_ACTIVATE));
> +		__COMPAT_scx_bpf_events(&events, sizeof(events));
> +
> +		bpf_printk("%35s: %lld", "SCX_EV_SELECT_CPU_FALLBACK",
> +			   scx_read_event(&events, SCX_EV_SELECT_CPU_FALLBACK));
> +		bpf_printk("%35s: %lld", "SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE",
> +			   scx_read_event(&events, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE));
> +		bpf_printk("%35s: %lld", "SCX_EV_DISPATCH_KEEP_LAST",
> +			   scx_read_event(&events, SCX_EV_DISPATCH_KEEP_LAST));
> +		bpf_printk("%35s: %lld", "SCX_EV_ENQ_SKIP_EXITING",
> +			   scx_read_event(&events, SCX_EV_ENQ_SKIP_EXITING));
> +		bpf_printk("%35s: %lld", "SCX_EV_REFILL_SLICE_DFL",
> +			   scx_read_event(&events, SCX_EV_REFILL_SLICE_DFL));
> +		bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DURATION",
> +			   scx_read_event(&events, SCX_EV_BYPASS_DURATION));
> +		bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DISPATCH",
> +			   scx_read_event(&events, SCX_EV_BYPASS_DISPATCH));
> +		bpf_printk("%35s: %lld", "SCX_EV_BYPASS_ACTIVATE",
> +			   scx_read_event(&events, SCX_EV_BYPASS_ACTIVATE));
> +	}
>  
>  	bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
>  	return 0;
> @@ -839,7 +848,8 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
>  	struct bpf_timer *timer;
>  	s32 ret;
>  
> -	print_cpus();
> +	if (print_msgs)
> +		print_cpus();
>  
>  	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
>  	if (ret)
> diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
> index c4912ab2e76f..ef701d45ba43 100644
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -20,7 +20,7 @@ const char help_fmt[] =
>  "See the top-level comment in .bpf.c for more details.\n"
>  "\n"
>  "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
> -"       [-P] [-d PID] [-D LEN] [-p] [-v]\n"
> +"       [-P] [-M] [-d PID] [-D LEN] [-p] [-v]\n"
>  "\n"
>  "  -s SLICE_US   Override slice duration\n"
>  "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
> @@ -28,7 +28,8 @@ const char help_fmt[] =
>  "  -T COUNT      Stall every COUNT'th kernel thread\n"
>  "  -l COUNT      Trigger dispatch infinite looping after COUNT dispatches\n"
>  "  -b COUNT      Dispatch upto COUNT tasks together\n"
> -"  -P            Print out DSQ content to trace_pipe every second, use with -b\n"
> +"  -P            Print out DSQ content and event counters to trace_pipe every second\n"
> +"  -M            Print out debug messages to trace_pipe\n"
>  "  -H            Boost nice -20 tasks in SHARED_DSQ, use with -b\n"
>  "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
>  "  -D LEN        Set scx_exit_info.dump buffer length\n"
> @@ -66,7 +67,7 @@ int main(int argc, char **argv)
>  
>  	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
>  
> -	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PHd:D:Spvh")) != -1) {
> +	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PMHd:D:Spvh")) != -1) {
>  		switch (opt) {
>  		case 's':
>  			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
> @@ -87,7 +88,10 @@ int main(int argc, char **argv)
>  			skel->rodata->dsp_batch = strtoul(optarg, NULL, 0);
>  			break;
>  		case 'P':
> -			skel->rodata->print_shared_dsq = true;
> +			skel->rodata->print_dsqs_and_events = true;
> +			break;
> +		case 'M':
> +			skel->rodata->print_msgs = true;
>  			break;
>  		case 'H':
>  			skel->rodata->highpri_boosting = true;
> -- 
> 2.51.0
> 
