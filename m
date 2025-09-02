Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD76222581
	for <sched-ext@lists.linux.dev>; Tue,  2 Sep 2025 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791843; cv=fail; b=plRB/oVfx6OmVVcOTLlkSiTcerRwAFI6npKUmyAVnet0trU2aTVL8qIvLFrxrg63k4wZL82xVeQ1DTREdEutPQVgcR4pNW4Nbd5OmBksw9pJg/IRn8jSUA6q0crd7gsUURWf2/nI0KuRLCzl44CcEk1XXzuUPLvgrXtSlQnHVCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791843; c=relaxed/simple;
	bh=sM8VYabrY0KxcWnIaXEkP6qPPXRwy/msjORet5++Miw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IzGbHdCEG4lZKg1DmjmS3ICCz4AA8T0Nxg2l3QNhn3CJLaGXH7pzpUL4/trraweVsZX2LY2qOmj1FTi/IxuMO8O2UcKu7qq75+YOt2a3CRNDBZvk2o6XSiZMSTWgfL/nIuw7ismvlG0qtziNTCQoVd4qesXGQLrbxl5aH60/gB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g6YnVqyB; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g6YnVqyB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=occ4L9yUum303WAZq3I0C7M0D8el22LEsDH4rmenkDH5FcWTNMHt5Rf5AMlPXH8YJWUv3uzCVO7aNXLvIvcH6ofSqk9Tr5vizAp0l4EZhrAb/IkwLHYb/6030e4pbU/s/iRuscmb63XClvXdb5bX8Stme2z4DmETfMpnIvEhdUs2B3aAlLgz3aHuBIbgjr8eAfLwlCG37YGvDzt27zCDlJjvL545QLAXt4+7Lndixmzy/RC1X09+6LZnlJDvHd2Q0TtbCpO5XI4MhkibSiIQHeiabXj6yZkawyDlmryZV01mh4yX0xbRGCz2ke+zFYrKTtun2jwLXvt4XLreKdv30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPDr/yHoVSo7K7CylP1yQv/4TuDZBXdBG3Z7kOeClFQ=;
 b=xQkqiV9DJuGjk60CEZqTcNHGHSgDPX8pDL9uCytUm0gft9m9TbEJXjBJuDjUl84P27Nu+sTwS3uuKEGEqqfI0/oDamokZ6nvfl8+ksjJMLZ/fhK6jzyZ8M7OygFMtwi5SYFtnnp3P7NjQkiko1cSYgQsLY/tztG21f8DvjzfxKc8Sg6kLMCx9nYUKYcuWBJC6IcpfS0E4xEMaNCDGAbXixlJPRcHQH1qKqu5M8+UEEDiuMTjx9xhDZBhMTuUc9NLlveWnPeWeU3QC3BszMemRv5vbI7JfhUputBdcE6daALMz989rOtE3ot6YjfbWnL9Njbe8Nl7eymi9R7B7ediqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPDr/yHoVSo7K7CylP1yQv/4TuDZBXdBG3Z7kOeClFQ=;
 b=g6YnVqyBffWR0pfFzmmKf1/QzcEIDAVOJwA6OF/1HCV1Bel6OKdjxyWjI9Hman67wGu9MLD3FFe+YWmeEfeqvKyRMhKMJ/F6Pobp1q5rF8eHr7CZZXcN2yqCcoen3ZPckTdmnC9IVQim2EQdaYPe//muEjrqVqKBUAcWSPx9Mzo8bCTqaIiyjpnHi35Mhsmyu0RkI3nlpb54KsXIu7XgbFq0tpmArV9zcDYOEd8BWiHopyMmM1O++iXIJqOscnPeVUExQVarT4ZMbqTwKbFnxfjzJd64qdKgk5+gr0H9mxcLQ80UmUFyK9OtTIbZvGTwnbtVwyhFx1WXC2gvK9dnQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA4PR12MB9834.namprd12.prod.outlook.com (2603:10b6:208:5d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 05:43:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 05:43:55 +0000
Date: Tue, 2 Sep 2025 07:43:42 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org, jake@hillion.co.uk
Subject: Re: [PATCH v5 2/3] sched_ext: Introduce scx_bpf_remote_curr()
Message-ID: <aLaEDuOEPT_9VOMO@gpd4>
References: <20250901132605.2282650-1-christian.loehle@arm.com>
 <20250901132605.2282650-4-christian.loehle@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901132605.2282650-4-christian.loehle@arm.com>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA4PR12MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: c880dc20-6e3b-44eb-3cf6-08dde9e3b44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QKNSIYcSNMpOvcX349pXxQhOsyr/hFwIZAYJHIKgPIhMu0sssG4ryIytFeav?=
 =?us-ascii?Q?gHAflfT1x08eWSbsyfffdCp9o437bo6BkmrzfXnNz1tYotJlCkxKJ/Jv9Wp9?=
 =?us-ascii?Q?ePWkmG7AS8dNNYW066KwA0IJ0wdjkMWjzgU7D3WDghI8/HZjYP/2+DZr5Jfw?=
 =?us-ascii?Q?IQuEVfzpQu1ukJbprBX5wfEE/x2vSYHEA6Wi4Cmy2NtNV2FIyy1kBXqFvlpv?=
 =?us-ascii?Q?xKEpVvn+5wS4Slkv/VOAaXAz+Hnq+YIECEcRQCk4Z/0UeocLxcl4aI1s4a+n?=
 =?us-ascii?Q?Zr9XJQrbXCapxg7KGo+RUVn8AD6cfBVDC1VVO+EBwiNYapdGWiu/mku99wl/?=
 =?us-ascii?Q?zxtHPSZpfqkTVogmZZyDBkDRuhkZPHUUcwFD9NLH8/nv2+dIYfeCjtBoR19H?=
 =?us-ascii?Q?Erphr5MFDRebU/MdAjZhRuJ8CmFzKirgJ/mU5hSyQNksIVcq0bp2TJx0Lw6W?=
 =?us-ascii?Q?F2ZUffeFhOn2uGqvf9Ku5CEumaQMQlisn/Nf//wLT6rQtziLnJfEb1d15zQ+?=
 =?us-ascii?Q?YdqKX8LC9ijP1qgYpjc6Vy8RU/zhvMEc/vmUQRh425qxKaY2B0zMRiNWoaLj?=
 =?us-ascii?Q?TdXJVuwXgXMCPM07Rp84v/05JQZFVSaWxdl8w4gCus14xoZrA/pY8P5jqg8k?=
 =?us-ascii?Q?5XSEcIDNHsBq61IsMwpt2PNPXbJh15cUX9/rQc6wSt6QfK9iG7ByCKOdJOWq?=
 =?us-ascii?Q?glarB4DTdyTx9wcbaLHadgNCowZPBypD4iw63G7nTPmDq1h4TbrsjA85+uhi?=
 =?us-ascii?Q?y3HwdeSMpBYue4zazg/QGaLHMiRUsJOhV4RAPtmgq+jyM/Xivp2a82U5P1Rn?=
 =?us-ascii?Q?AFPzVm9xbiJfJFi1M9/RcO+RQJeSCPTREfR72FTxNVHoXubbkrrhe36myaKo?=
 =?us-ascii?Q?ImQyryaTK7GFO0BwzNFwtSxQAixippyalmQAo9HgMAvyvfifhfrCWssxBkwo?=
 =?us-ascii?Q?zbWATKUje9+BgyO/HqF39wd51n1WRg9tEKWdzDRkOPVWSf8dM+NJAz3hHEC0?=
 =?us-ascii?Q?ux0AhByvDydloCi4ZG01ixMGNnoaJX753XvF74OspoDhX9AXSHNU6DebNS5Z?=
 =?us-ascii?Q?+ySCHAIQtBTU1Cp3FEJPevwITQcrn5UYOXZDM57BCnj1EeCUpfEYkDKUB8S5?=
 =?us-ascii?Q?YiTw2X03pxMz6rSmrTB5uN3ytddCPWwAxAbFh+PRee4On50vziWD/shf4fZa?=
 =?us-ascii?Q?FLuI4r+bwIRbV77AVKEW2ZnfRCGV6vTKYjNdmMfB+qwaLMroILdOZ5KnlI3i?=
 =?us-ascii?Q?6mPJBr4a8oPTsPM1q7keU3S3IG14ZN5NQlHPMtpkORLtEdr/K54givFy2+bf?=
 =?us-ascii?Q?b7JrFlnsxEyiv/dIdlJQ/0p4Lph4w86cCJ7jSfsmqw6yrRQZyplPTy+RHwgS?=
 =?us-ascii?Q?PP4awRawClSp8nm/n4/4PTW+urRNrlGYcyxO+gDdtcOxToW1Bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6VJheiSpqkmXlH0El+ZLsx+Y/ZI7Lw11RztHeommCMKNyPPMnBlfcarpKg4H?=
 =?us-ascii?Q?YrVZr6a3DpxeTy1N3sCHjbgwjOdLbKVW3ulgcs2EVjlB6yRyEw33SkabXOYT?=
 =?us-ascii?Q?pUu+pQWFNwqszqX7GvblNmbwsOvFReU46YOAfE51a1yxj0gAbe7I1vzn66ts?=
 =?us-ascii?Q?dSuqmKiWTAnQvAnUaGn//RO69BJWfZOJbwjWNBQj0dyJCCCZfU+7/TmwCTRv?=
 =?us-ascii?Q?NoBuC9Hz59fF1x6t7SNQVcE0UCj6f+qaTkfv4ycTuvtcrOSmheghy3q2v63f?=
 =?us-ascii?Q?A/qZrVcIwddAI4Kxv3zZ4bQ+rfZUhVGUDPGQinmPzG+/5mQjIN33ToOuhKUZ?=
 =?us-ascii?Q?Q6O7CYoeeb1HQafzsaj9IUztW23HtItAQuKVUN+AC+KZpnwj9VKCFaxnw3ws?=
 =?us-ascii?Q?9z698TRriP9hpennxd+qdZn8BGmkyvudjjjRL/zKMsL1yRcNryydtTf62i2t?=
 =?us-ascii?Q?9Z3GKW3CXdBSHppx0UFXXUyFXKqKDaGyy0xYY8c5NGyFadGFYGBxDo9l2Cio?=
 =?us-ascii?Q?JauMPXutpH0UEsUjWxRnXdxPmjpHSX81TN2CKfyfJQy0jqKxblfhOSf3D1bm?=
 =?us-ascii?Q?+5lORKdgQAWnvdCJ/8VZ2LOByqqqQTFIrk2L0Jj7o+rFzKT4RlKEtFAWOvg0?=
 =?us-ascii?Q?Pb31VwZT1ik/+Hb8r/ElhYqnJYZDma3Bhl5U8ekltUzx8D9ixebgdQOYvst6?=
 =?us-ascii?Q?w5WDdUDPT+6+kK+ZptQGGKwVmv8p9JVdyZucwMG9YrDmPtFZ4MYyTRtpS36b?=
 =?us-ascii?Q?Oy44NocsifwjzZqes28xj7JdbtKRamBAaDxtaqOyZ9Z7AOfsU43VlJB1HLq2?=
 =?us-ascii?Q?LDyvqoQ5LWiCn7B7zNwWonW0X3zFWb4fgoIL1djgEBILqhYHiGWeCH6eATFX?=
 =?us-ascii?Q?WzWJkB615smMj+m8a74MiePzTonKsN8TBmpQw9Z9p90gmbUbTeA45vQbtA2W?=
 =?us-ascii?Q?kv6Oyp8/hs0IWJL7SK4vk/3FJrVO2plaIoCfcxVVSkSP65vyVMYUZb11IJA0?=
 =?us-ascii?Q?mFiPxE+0dq13jO5Q3ryQo4JFCz21ccJ7LkMql66/7WBiE3Ab+UW3WlZ9cubj?=
 =?us-ascii?Q?hA289lQqDjpRUYgTFijsbWkJB5ngLd4MTOWONzFNh5CQdG1kwbyd+K+KUrN3?=
 =?us-ascii?Q?bv9fZ1+2DSaS+yc1LuSt/vh4nquB6Cil5YPTDV9TtBU+euEg34HT7+P8xPmO?=
 =?us-ascii?Q?bz81sZd33RS+Nk5bQ+xaOaQlRKDk1f4IL55z4NisaIaWTEYkuT2gjV3EIvwI?=
 =?us-ascii?Q?/qZ5nNZjNV4xm0j/H9bgrno4Zoha0H6/nFPjFW/A9LV/KXTpGq0mfU2SJw9g?=
 =?us-ascii?Q?EQCaLhcg3xCtRFF6mavBkHYaIA5JFA/RnIBZG97OIsDsji/QjC2QXnhqgSt4?=
 =?us-ascii?Q?CGxhMyuaInXjbqVc6cd6UtzG9kno9mtniV4UCnZhMRIlo+WcRZkpcrN1+waY?=
 =?us-ascii?Q?Jy3rVqZxlco7SqMFfeSVOm6pZsd78/icrUVkHQ049nuTZHcyXa7IZiP5tOha?=
 =?us-ascii?Q?94H7C6PaBcfOtx3CPN2py6PCJlHIjysbm6w9SffHO6TYmkZ8lIXqcAQDi8/U?=
 =?us-ascii?Q?Q9zWinjBI9EOdQe5y4JvlrUGLSiAdfsnQRBJ+sNX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c880dc20-6e3b-44eb-3cf6-08dde9e3b44f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 05:43:54.9757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8E2tH9Cr7Uyara7PGG3w0gI0Hwe+b1Vlir24LqAiF+jmudlfJyHQJFKaTYr7WUgNVSh1VTrU3h2dguACbrOlMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9834

Hi Christian,

On Mon, Sep 01, 2025 at 02:26:03PM +0100, Christian Loehle wrote:
> Provide scx_bpf_remote_curr() as a way for scx schedulers to check the curr
> task of a remote rq without assuming its lock is held.
> 
> Many scx schedulers make use of scx_bpf_cpu_rq() to check a remote curr
> (e.g. to see if it should be preempted). This is problematic because
> scx_bpf_cpu_rq() provides access to all fields of struct rq, most of
> which aren't safe to use without holding the associated rq lock.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/ext.c                       | 14 ++++++++++++++
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  2 files changed, 15 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9fcc310d85d5..e242a2520f06 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7452,6 +7452,19 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq_locked(void)
>  	return rq;
>  }
>  
> +/**
> + * scx_bpf_remote_curr - Return remote CPU's curr task
> + * @cpu: CPU of interest
> + *
> + * Callers must hold RCU read lock (KF_RCU).
> + */
> +__bpf_kfunc struct task_struct *scx_bpf_remote_curr(s32 cpu)
> +{
> +	if (!kf_cpu_valid(cpu, NULL))
> +		return NULL;
> +	return READ_ONCE(cpu_rq(cpu)->curr);

It shouldn't be rcu_dereference(cpu_rq(cpu)->curr)?

Thanks,
-Andrea

> +}
> +
>  /**
>   * scx_bpf_task_cgroup - Return the sched cgroup of a task
>   * @p: task of interest
> @@ -7617,6 +7630,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_rq_locked, KF_RET_NULL)
> +BTF_ID_FLAGS(func, scx_bpf_remote_curr, KF_RET_NULL | KF_RCU)
>  #ifdef CONFIG_CGROUP_SCHED
>  BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
>  #endif
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index f5be06c93359..dd3d94256c10 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -92,6 +92,7 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
>  s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
>  struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
>  struct rq *scx_bpf_cpu_rq_locked(void) __ksym;
> +struct task_struct *scx_bpf_remote_curr(s32 cpu) __ksym;
>  struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
>  u64 scx_bpf_now(void) __ksym __weak;
>  void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
> -- 
> 2.34.1
> 
