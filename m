Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49029D292
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759903851; cv=fail; b=IbHMaXxEQ3QEyrsG4qkWJne5bWlJeATiM4RVi7Rv2aoSPbdeTGUiK8TAtdA1FoF0MpdBMC04ccWdCdqYkr4Fc2LkFiOq3TDATQR4xBiaQF3q3oD8zxrGh0Iz9EWAffO+qrkeVmwFcEhZFYNLd8N00Ppr18g8091bCNMoMWMOt4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759903851; c=relaxed/simple;
	bh=CfGV3ZQRuOl7Nab6mTPlcrvOuI00/tZnTQFpoDmfrKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FIG7ptqt58Xxy6O/ROuJS+kzGxGXO/P2ns5EuaoYPcwnrSxC6N04sfFgzkWdVW9gBbBlwCOO0O75dPc8+yWO8rL4CY3lExO7uDfdktfl1nfn/GFkV6faAseHUKWb/4orBp3z+cLy60iCkA7sPMlLERLHG2mrJQW7CMca9Yr8uj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0/bislI; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0/bislI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxM4DUfXHwoaPdt7gzUNwkf+q7KpWNiYgzFKBDsXS6GxB3XxKSW6jzO34bGrjPYoxUJN/q89sUUvsjeWv5QNtLF41KyJWsJW8Tz7GCg954K/iMdJoOGiQeBBjg8xlXjznkmDFN+c3VHMU5ESCfhx0CE9Cc4CnPSOOw/TaIFwHOSAA1WMOh4rpzGlnoqoGi6LamD8aYZ2RO7mJJYD787GZAn+Fr9TCXZT8oVtfhO45eGBOEwTtZKvGoH/5ln/draqb2dCGz+WGfwR9zEQXCsCgJNq15zhjFOC4U7tqivq3NzxknEiSKAsOtpp3H6sTeqkDcFaXNaDqBuYzYsUa++4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs4eIdMSeOh1Cyz/ubLBvUz7EQJZ5JDua/DBx1zl1Lc=;
 b=S9sV/IbklNX72c2aswjR/5/WdK0TqJ0z9Mscoi2QECmb/bIGQ11Ea8xQRen3Uw0xdgMDu4zgCDfRRwL5ouUlqyKSkwmWtZ65x0Zks0ow7+qBvUL7zbh/VV/ZmNEDhStW1RcPkioIjVZr2NHtAmGhp+jnNR7444dMoNG6h6z9pv7sKmYoYjpmhnNFJQAo27KvyOfGRb85O4vzLscLR+B5LNHwkUcdcPfEYrfBy8BBpqI2LzsOITXzKDk8jXnR/AnI4TSL48MQzFqWq+rUHfm4jvY5ZFg9XSPNh6XvlSMC9OWQf/3+VUz7ItDdQRRTSp7rFI/p4qMC0pP5Ym1HuCU//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs4eIdMSeOh1Cyz/ubLBvUz7EQJZ5JDua/DBx1zl1Lc=;
 b=e0/bislI17AWS+2lTEApGNbfn9+/g5umB/GFwxH2miYarlN/5xEzjX+1OdDBPhHdEiknNtb/BQROS8J4EeMR5ldEJctOfSmHGR3G7Jfkq2bEh4+eYTaqjftszaDFDxwqH+XBmAp8ExL+T7hZMVh1NI1prnsKmHG0raCK7M5IMyLR1zIZrhB8YtZO4HL8pABHeo8TaiFJJWMByt1G3TC+NgYjB1cMgMNHf6QHN07fQqgLVluEMtiU3j1rkzCAZqm9+p2MKzpNJD8kE9RCQ/bvgO/ddO7TU03k1hcNxlfBFJVt+6qPdA5R8jJJHVwXUUNwU1Ph/hWUeWYBCNF522Lo7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 06:10:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 06:10:40 +0000
Date: Wed, 8 Oct 2025 08:10:31 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Phil Auld <pauld@redhat.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: Re: sched_ext and large cpu counts
Message-ID: <aOYAV2ZQvMt5aZxu@gpd4>
References: <20251007133523.GA93086@pauld.westford.csb>
 <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
X-ClientProxiedBy: MR1P264CA0027.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e08bb32-80c4-4dfc-e2d3-08de06316817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?82kYzp8t6A9okI5jgiHaWExRKyRxeNYbH8jHKkFFoJWlk9ye8zJR5bd1odDm?=
 =?us-ascii?Q?AWhC62lhZ0kMtK9AO6EU6zs4e1Mcoh1qmzYBwbMozl1G2WV7vJqMaDKf0Rch?=
 =?us-ascii?Q?BlDCNt3JpS0xz2sqD7bxoC8noJqW9tFb4pBlX6+ezQmvobc/cR7SFFmYH3JE?=
 =?us-ascii?Q?BmG8Wrh83VH79yRpNM4Zglb//Sd8ENmIjfDHsRD3i6GCYp6YPSdHTxGtaTRp?=
 =?us-ascii?Q?t/6LO0ohB4Ep9cFlbUxOT1BC2npFLGyLoGI7SnNacMWAqdrszFyXbJTEaUHz?=
 =?us-ascii?Q?zoPJqxw15XL20RTVMRD50X/zWZjusC7CTZPSB3L58fNucD0VJlKjvIPnvgQ7?=
 =?us-ascii?Q?acTDCgoFKmUqdTt6Eud9Ev+ifk6q9ASP5tWVdrpc8kMPpfcKG9WjX+oLTrap?=
 =?us-ascii?Q?fAyXw0PxSsUtXIQD1VxpXM9hJ0GT4Y2qEUydek9aR/n6yxhmPfje2ujxVKoK?=
 =?us-ascii?Q?W64xyo5d8fDyZLefeV+dBkmxsFRrexDJ9ildgBFqm/mpkO5WsTeOnIT6RU8M?=
 =?us-ascii?Q?bxbOODKGvCBEz73iQ3CW8W4fV5D463diZ6r99P603/vhZpyWIBVVbNw6r4Es?=
 =?us-ascii?Q?FuYi33NA6rA3pTj3YL0gBqyZucAOt5q1wCRmwtKZoJxXySJjkzmTaqTaAq7o?=
 =?us-ascii?Q?ON+dX0qtvYhUQjB7de3R3Dhjqj0usc8KQobyALbaZwCF0Phkv9jC9ZFyCWm1?=
 =?us-ascii?Q?7fjUMFAMo6Bm0tOOvqvgF059ac7obvzLKP1go38+TFkqsJsub3mdqa4swfwu?=
 =?us-ascii?Q?v25s2gP+ZUi9cgLKv2AWg4JsKQkMO5GOnlU+lwhTN+G9vDjNZdnuycAoGdNi?=
 =?us-ascii?Q?LM4ldFpfbXtXPxVLafO9WfQxZTfz5TWAa0wF69BejzNmJDIBHdbxx8V7Sgbm?=
 =?us-ascii?Q?0htqk2gmDfI2StVxrpC1t59Rppp1GVo52D4U7SpxPk93EVE6XqbljOl8uHEY?=
 =?us-ascii?Q?kFaYLtHzbvk3OGW0NrNXKuUtcDsI5DWiG1TWseygceu8dxMnc+2kSPwdNuuk?=
 =?us-ascii?Q?YZKuD0C5ZVGY5wfb/BAiOrGyopwSdwXb/a4cHaTr99Fi2wjHIUncJbf73vGI?=
 =?us-ascii?Q?eQEsvTptM+dy8wIvBFRYN1uiyMP/WJ3STgTkzzRFSnwchZ/uwE0Ansdafq6/?=
 =?us-ascii?Q?6dnCJweVvtw62Cq/Z2NIp5gYGKWMTs/IcoCFJ99BFsHEgB86DCjYzHO6gZmQ?=
 =?us-ascii?Q?cVfpaY2hBE3PM4E4HgH9ylf2EunHeT7WcnbncdTsDE7iXaJTRma668nOinS+?=
 =?us-ascii?Q?gPqqSgxyWNWjWErCzcyvxl2oA1rNqHdrItZo0Id1B2x7Hm9scSI1oneWNRJt?=
 =?us-ascii?Q?O/q/AOe93CnjiSP+7lPpXSHyUnSOm+PEoHcdPgBl+vj1mQfXuSegJujxabPW?=
 =?us-ascii?Q?kBFu4g4Yl0y/n1g7AQ4dUX+cEu1OcqeNWxBum6njpInMLPrUjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NvecYJibiGEdU0iWpGiG2+gWU+ArJmg78arSZknxZfyUubV4E+XvfeyybTr6?=
 =?us-ascii?Q?uuwnrrikRoOf6LZACcS/QLlZarjHBGBxPeJvvqFA14bBuSZKYipVUNp2vmIt?=
 =?us-ascii?Q?pf5fo8d1eJoQm6D3tWCBuoz733ZJFM70o9BtepMeDoOpFXiAtqjYLHjWHxgp?=
 =?us-ascii?Q?l0pXzTljcbriab16MNgO6OIYOV4rW4fxOTJlU7vTApvW6/sNi6FAF4Jd1wve?=
 =?us-ascii?Q?Bfl3Dvh4pCx4vqlHnPUEPxjBPrcThRPbsObcoHHIER274kK/KmOo6WzBADLT?=
 =?us-ascii?Q?P35DZNcuJ53/zv60MAN9aim5nTjDOKE404QYON/E8lAV3r8KIgBWx43Vrf/j?=
 =?us-ascii?Q?ymMsvAAINv6DPhBuMsY+9JyztTrkHuVjInVlr9SZM7YLjvQYYhZ76jEwPyVa?=
 =?us-ascii?Q?3cORRieUk4wkDE0iCCPe2UdXvOYAmDWOXaRaIvPE7h3bJysZjqEYtrrGgm7x?=
 =?us-ascii?Q?mTk+AHT+71xEuluR13IjDKEXYQr6JSewGbYLTLpIHli6UxiuLj98BimU8YXc?=
 =?us-ascii?Q?BOLWWLEmrpG1oEOWW8p+YIquH4OyF1XsRuqW5ULwv9HiCwgrgcUME6m4eJ55?=
 =?us-ascii?Q?8jHj0aRt68LiIAB6Tfy3OKymkdcZFAy4LDX7ntpNt1IpJxAIsPywCjQuq0M2?=
 =?us-ascii?Q?Uc/6B7fEwx++dJNyIjDtz+iobBaHYf1tYCCVx6zzu0l1Bk4g7DqWTjeKp6mc?=
 =?us-ascii?Q?BhF+L28eF3pRyCj7DhEfqNmMr7bApq2VB9UFxC0RJWJhBaTxhcfQn+g3cwdb?=
 =?us-ascii?Q?5Ge1IowNDBSymIXp7bK//Th986KHof2LcW4L1PHTtXgOdrZy/01vek5AQKHK?=
 =?us-ascii?Q?qpMkgTfvzFNEOugSXM0jAxUy5OtFnlzGvLn311eaYbL2zSW/EemFgUYpaea2?=
 =?us-ascii?Q?/ais9aD2LDI0HLO3pGF1TwuPAKv6mCJ3jONjsCkqA/AU/W3yBkZTRRB6J87T?=
 =?us-ascii?Q?XwoGzaRRq8sbJdo9RdX75Bu5rRhG8I9lU45zw86yfMkF69QesXaG3mLJPrGd?=
 =?us-ascii?Q?ZsRPWr+djA8Ru4ZoDcK9fXYFO6nTxz5/sRayuZnUN4aS65yaCGYRoBl69DA/?=
 =?us-ascii?Q?HEPJCSUzVBALXF9WangLSGLU+y3GLKFzaHKxcnILz/Tnk3y1IUdh9R/G/dbv?=
 =?us-ascii?Q?NalQvs9VyNb3tlF+/jRnJWIdv1KxEf7l7iK9DDx/HK3NJqfjUzqqR2rG6yC1?=
 =?us-ascii?Q?2ork4Tnzw7Qfr6b67DpfvZMCtE8/3B9+dsLMbTen/9DW3dQcsK1Y5MB62RIM?=
 =?us-ascii?Q?T3yJDwVFUWDEPZQy1RqOdk06QXUF4IsyIUEZtLEGCSGirLKMoUksYdLsNiXV?=
 =?us-ascii?Q?6n3Fv1Kugw8vWg4ThusO8FB1BFOQiibO+M+ahtuDW/vfsJYVTatcq3ubYdc6?=
 =?us-ascii?Q?2+b2HvqTbZuOOB3wY8i1MLgy2c9yaoMF1+MAJq/5qE+qfrTQJdn+M1/LopJO?=
 =?us-ascii?Q?OAW5yNzVwHc0imNMpRQvNDnXomG8WjGIL5ElVFvy2JgoRxzo+O2NOxqleDrF?=
 =?us-ascii?Q?depvMCUiXjhhA8VNiEzb3FEZKo2YTquArEt6s8/RsFuOLP6jhU3GGjj9a/ZI?=
 =?us-ascii?Q?leORf+rU5n7JMiRgYELxrxOYH02pbi4VViRDIuSk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e08bb32-80c4-4dfc-e2d3-08de06316817
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 06:10:40.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYJystqEx+nGog4LlR/UUGFr64zVa8KJua/6z0MT/ZG8l0AjrISY1+/i3ufS7U2DAbl/MNj6OH20723Cc03Nvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281

Hi Tejun and Phil,

On Tue, Oct 07, 2025 at 04:37:24PM -1000, Tejun Heo wrote:
> Hello,
> 
> Can you please see whether the following patch resolves the problem?
> 
> Thanks.
> 
> --
> tejun
> 
> ----- 8< -----
> From 4d7f7d24e90fba47bb08ddbeb8668123b4bbab1b Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Tue, 7 Oct 2025 16:23:43 -1000
> Subject: [PATCH] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using
>  kvzalloc()
> 
> On systems with >4096 CPUs, scx_kick_cpus_pnt_seqs allocation fails during
> boot because it exceeds the 32,768 byte percpu allocator limit. The allocation
> size is sizeof(unsigned long) * nr_cpu_ids, which becomes 33,792 bytes with
> 4224 CPUs.
> 
> Restructure scx_kick_cpus_pnt_seqs to use DEFINE_PER_CPU() for the per-CPU
> pointers, with each CPU pointing to its own kvzalloc'd array. This avoids
> percpu allocator size limits. Additionally, move allocation from boot time to
> scx_enable() and free in scx_disable(), so the O(nr_cpu_ids^2) memory is only
> consumed when sched_ext is active.
> 
> Reported-by: Phil Auld <pauld@redhat.com>
> Link: http://lkml.kernel.org/r/20251007133523.GA93086@pauld.westford.csb
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 59 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 49 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..042fc73fb141 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -67,8 +67,13 @@ static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
>  
>  static struct delayed_work scx_watchdog_work;
>  
> -/* for %SCX_KICK_WAIT */
> -static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
> +/*
> + * For %SCX_KICK_WAIT: Each CPU has a pointer to an array of sequence numbers.
> + * The arrays are allocated with kvzalloc() as size can exceed percpu allocator
> + * limits on large machines. O(nr_cpu_ids^2) allocation, allocated lazily when
> + * enabling and freed when disabling to avoid waste when sched_ext isn't active.
> + */
> +static DEFINE_PER_CPU(unsigned long *, scx_kick_cpus_pnt_seqs);
>  
>  /*
>   * Direct dispatch marker.
> @@ -3850,6 +3855,16 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
>  	}
>  }
>  
> +static void free_kick_cpus_pnt_seqs(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		kvfree(per_cpu(scx_kick_cpus_pnt_seqs, cpu));
> +		per_cpu(scx_kick_cpus_pnt_seqs, cpu) = NULL;
> +	}
> +}
> +
>  static void scx_disable_workfn(struct kthread_work *work)
>  {
>  	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
> @@ -3986,6 +4001,7 @@ static void scx_disable_workfn(struct kthread_work *work)
>  	free_percpu(scx_dsp_ctx);
>  	scx_dsp_ctx = NULL;
>  	scx_dsp_max_batch = 0;
> +	free_kick_cpus_pnt_seqs();
>  
>  	mutex_unlock(&scx_enable_mutex);
>  
> @@ -4348,6 +4364,28 @@ static void scx_vexit(struct scx_sched *sch,
>  	irq_work_queue(&sch->error_irq_work);
>  }
>  
> +static int alloc_kick_cpus_pnt_seqs(void)
> +{
> +	int cpu;
> +
> +	/*
> +	 * Allocate per-CPU arrays sized by nr_cpu_ids. Use kvzalloc as size
> +	 * can exceed percpu allocator limits on large machines.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		WARN_ON_ONCE(per_cpu(scx_kick_cpus_pnt_seqs, cpu));
> +		per_cpu(scx_kick_cpus_pnt_seqs, cpu) =
> +			kvzalloc_node(sizeof(unsigned long) * nr_cpu_ids,
> +				      GFP_KERNEL, cpu_to_node(cpu));
> +		if (!per_cpu(scx_kick_cpus_pnt_seqs, cpu)) {
> +			free_kick_cpus_pnt_seqs();
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
>  {
>  	struct scx_sched *sch;
> @@ -4490,15 +4528,19 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  	mutex_lock(&scx_enable_mutex);
>  
> +	ret = alloc_kick_cpus_pnt_seqs();
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
> @@ -4701,6 +4743,8 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  	return 0;
>  
> +err_free_pseqs:
> +	free_kick_cpus_pnt_seqs();
>  err_unlock:
>  	mutex_unlock(&scx_enable_mutex);
>  	return ret;
> @@ -5082,7 +5126,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>  {
>  	struct rq *this_rq = this_rq();
>  	struct scx_rq *this_scx = &this_rq->scx;
> -	unsigned long *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
> +	unsigned long *pseqs = __this_cpu_read(scx_kick_cpus_pnt_seqs);
>  	bool should_wait = false;
>  	s32 cpu;

Should we add:

	if (WARN_ON_ONCE(!pseqs))
		return;

Not sure if we can race with scx_disable_workfn() here.
But for a test the patch looks fine as it is.

Thanks!
-Andrea

>  
> @@ -5208,11 +5252,6 @@ void __init init_sched_ext_class(void)
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
