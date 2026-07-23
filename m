Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028CE35E1D9
	for <sched-ext@lists.linux.dev>; Thu, 23 Jul 2026 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829519; cv=fail; b=VK9GQFXOnLdtsNtjPhYfAxfOrkaBZ0HHt9sWIHUXvCjiqOMid5AmYIelItrl31sCUswxugOMc41o+c8o3I6TzLPm9ojOly5WfoiS6D/8WOMsRgd5bT2BMsvuhp7/8vxYTO9yEjY8BAmLgdIWI1bBVdSIjMIE++DjK7EfiLPyuRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829519; c=relaxed/simple;
	bh=SRF9QJfHLgLoXwS1NOHfeNGZq+w63Z924BsRjQTy7Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QWwkzNVD1vUZ3SSF2DPsDak4Cp+L3FsaPmCbb22rg0dazlqX6I+WHVrrIrxKEAma1gJKzOt5RgZiBCDtXRFVJ7iRXE3CieRgUP74EJaYwWZf6IilhruMue/F0FAS6RqJ3rA1eQs0T5vuP4CGVYpxGURLq4Fdb5T+6WZpMnyJaGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OJTD25FP; arc=fail smtp.client-ip=52.101.46.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJTD25FP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDeAz3/yMxoOJf9tAB7HftfDG9i/krGsLmIziUNcFP4HomQPpZnj5ka80zDPLeg+bhYxFq+1MTv67ybEBcTG4ke0qx9IvMOz/Q8/mX/63TzwAgqtmCjQolyW7L2CCQKEWW4rwDyZMZCMNCtonBt9IcNsk/DCEfknR5ZhELPLEHtYvwB6pCmJzJht+to8Xn1YTJiNBTFuFqTj86o69ioThTVGfMFAt3WMLtm22Toq3N2NpdQc0D1mWQbvM+/uIRp+kCp++kfE0svG8IUZNfnf2nojLDTd8p4c4jC0+IFeCOzcrN717YwvOyOyt4aVNzwno7ckEzaX5ZY0E7hr88Pn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5GmBaOtRCFqz+npZDR8kVQ6sE2gYQoZUiQN+Nqvor4=;
 b=HBTjq42ZqEmt/UWwnevcUtOJe9PNQSZ3NUwxBOy/1B/fgfFklqhWtSSYmYtvdft2grZJZaSJoM2e6WcrVijOzdQ3sSsuBUfRgRm1dVQBLtBc3pbFgd6b6lUel7AUxPFNplneF6kvTPO1iWa01yARszr5+F8Q25i+2OIpotCmRhx7mT3rdPoRodHxnddNXiR0Aq41Z/gZFkobFSMcSJs6YnNROVR/fa6DJ1KNzRUAd6xIqAaTo/yvhOpkNYnnpNGaEK+6TO8aD3xgLVv8gaPC+MtMBBmabOGaUvTLezFJOZ9mV1S2rfXmlR9vnTQWcj+ajWs1ZIJu94l9pbG6S6lUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5GmBaOtRCFqz+npZDR8kVQ6sE2gYQoZUiQN+Nqvor4=;
 b=OJTD25FPpfsbebfb/mgH+T+zRqRbGlWVldR27EuF5BWu6+m2khQHj7wnXL/N0zHnbVG+TCLctQrIrIwE8InT5Cgkf4elnXC/0ucE0Z/aqZS4MzE9EiZG0niLORyZLb4XD3hmPQPhHyLwSCkQtGxJrmZ62IbhZ1aPvSurMPt4QtDfGc6CHFTOJhPDOk9PhnftzUzznPc16a++U4VkB7d9dYxR0t48oAWC/0T4MklfRIPMW5TVNsKtw1HjlX4xEbKhfT90lz/2aFL5csyESkYz7WRH/l+keaJQ+M11rHasgZxtl359mQ+aSCA/T0dz9RSY4hTE90RzXBWDaFnk39O/tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 17:58:33 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 17:58:33 +0000
Date: Thu, 23 Jul 2026 19:58:23 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: repair kernel-doc comments
Message-ID: <amJWP6UzxvNVlaAk@gpd4>
References: <20260723173118.327466-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723173118.327466-1-rdunlap@infradead.org>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba62cc6-df02-4bfd-c5ac-08dee8e4029f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U1mTM5lFKtUWYx+Hilp8M9mUB+KjRBV6olcO7+o8gzLiThq8vtuMAhi95gxgy6uvHerSFmsmockDxiqBoe/YNHpyDLRhePLSP0Kc7XARB56J2niFqhqTZ+qo218/K0ssh1OZCRm0mMrfbikhJemgDVoqb4bUsGBZ8qc2EDBY+teiCLaLPw8OzVSx4lULKxSM7b1iTqCu5B8uHw+NoWgoOuW3Jb+YECCqjrTk/xNWEBqyDTjEBpR6RLoLNVXCZh/yLNsDDQMaBpE0TVXPGtnmMNEmLfD+dnz9OkjYQJVams4+9alMo9yYKHycrRYcRbUM4B7upmMgPl0Gn/28Gc7njH4jZzk0KQgUB66/9ceLXzLga5Th0J5dGrO8WOtPFHcVlfsGmFiZgZ9EhgWozIj9bWwZl7qxYekRf2U1x/hkkNp5E+NynJ22FLRl0JJvMwDYiXkEGdBLtcF6tjJ+lIf0l5zMAolqjNjvpRql/rV73LtVtFRy+r5iIagUG79DDbM0nGuFIYKAQWHZOO5NUB2lRfB5S6lgX8PZBdyT4O09V2AwYfwh/5KYEbYgfeOvuX4uAwkDMP3J/oLC89O0DGYq2vj1Guwy9H8wIrDFPEeFAuDsmAZsUEOO+S3LsZSo7j79gqQf51U8/JEzJknl1M43RJq9YVp3So/Wq50k3TrsQ0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/IQMlO1nb4VKSxUK7DC3zQv6WGjLVnp6sttmAoIiiIyeVNPhzWkYzEwduP/?=
 =?us-ascii?Q?a4ChuSK0A2XxPupGCZ8gXJ90W49l0yDIkKYWh0ZHXp/0Nn+aaW8fTsb+T/Iy?=
 =?us-ascii?Q?kqPpbqFNaHJN38guxzH89Epv1t2sfgqMiPi7d4VkmjJUz57G8oc9lce5XEK5?=
 =?us-ascii?Q?DyZw6VY3IdPYJUUj1xf6eExFX/AFhYJPJLDIHCL1y7z9K6mq1ZrzY0LC6PP/?=
 =?us-ascii?Q?UcoiLO/dk4ce1cEa6mPbf6Sw7lLHkAcrWdhlrbmMLugfQGwC83GU6G++Zmh2?=
 =?us-ascii?Q?nN1/medHyDvVqE5PrdVBf0+lH68x2n9K3tzzlxdj91v9PuU/af68w0G691/M?=
 =?us-ascii?Q?+4V9Dk9WC3MN+tjhjsBPDSyryCBXmiVXTaxBXpNH65+tXpRVd1wEa/lUnkiW?=
 =?us-ascii?Q?iedTr5qytGbw70iqYA1IbJedQejFFRSCXiT4gpOsWIaC3GbP1vPPOohESGsh?=
 =?us-ascii?Q?VdDzuGx+9C37Y9MU8AwTsPVstGXK4jxLzZZ7UlQOkKFiO3qwMmz30yJG2ueF?=
 =?us-ascii?Q?GsQEjDawyWkiTfSDudb9pQn3Sa8+qDUtuUBhIQCmw7RcXR9YWl2h4NfKw3BE?=
 =?us-ascii?Q?AnMznzb8CA+yIrJyyanNztLzORirYhAJ8J5OHIKmvNc47QAI1sQIAncylTPZ?=
 =?us-ascii?Q?hCLCFVXJQ2PrFPyuG8a+QtWikWMNXT2FVGjLyoaXNh7qZAYRWe2VtF2lRlbh?=
 =?us-ascii?Q?nijGMQXJCM45Y9W6YchDk5/Qq7A3MdC9SqnqcrPXwtXQIF4Ra8XrKmJaY7U3?=
 =?us-ascii?Q?d/0KK5yJiJrBsUu7JBnGsb81sh/bWHKbKQUnX6ctDXDG4GakvbkVww0OGomZ?=
 =?us-ascii?Q?BJ0rcdO10mjiO5/lSflnyrcf84+rA4+YkrgpYYdaqr4/SJjPVPLE3AMqjZHU?=
 =?us-ascii?Q?OXoDYCKCSXlOz8DeEl+elAyammUWl1Lm/sxJ8PxqJO6U9ybyYQp0rq9xg6pF?=
 =?us-ascii?Q?oI3CXh4waQL1+OdsBezhXupXLjLtHV1FA5RNd9pBHP3Q01eeM7SVSRg2jebv?=
 =?us-ascii?Q?XojMyer6vEW6mdcNwSsFgIsnpmJzcG53AjzU5e4ePnVYQFAoLQEdq6OZkyMk?=
 =?us-ascii?Q?xVhn8NhWiJ7MSYKVMB+gPpfqn8ZWhIEmnAYW4Eju8wX3siDe6QjxNz7sj3xd?=
 =?us-ascii?Q?m+PzXohObH5ToaVvtd8woHCTxM79y5DrJ0+qJTyguz+R6fbw+FWCkB0ro0Ra?=
 =?us-ascii?Q?I7H/enOEd1K1ziDYloBIzH5jCAsd53efjLbrAxK9qxUonYrluuEUkTFZc1AF?=
 =?us-ascii?Q?W+ZPSCywAiwmKoyZ1EAz8DjBg5wyykEmiA00PBhMHJ60qkqvEOXqigpuMoRn?=
 =?us-ascii?Q?pcrZ7lZ3KvYFMjwAfDF44113s2kKp6VmO3A7qwrRJ7PWIdbZm0gJfUWKiPMh?=
 =?us-ascii?Q?2er4yDXsdnVS1LenXgVGo9Jyb0nhbotX5PRMCNo+QdJ655+J+uabf3f8O965?=
 =?us-ascii?Q?8b1TYrT88MuNED6dZBCI2v9lcxZc7foAln3ZphrW9DCKCwgpyrbx4MnXhBSw?=
 =?us-ascii?Q?V1GyxdgbsCZejYoNCW6ywlU2pSbmODirw1sl3869Ze/dt18rWv+y0jvoei3e?=
 =?us-ascii?Q?Moyy0F5HhRku8Wyu8u3MRCEi3Dlu3eosGXL7BuWK30oJAzZPXth9XdAEknwr?=
 =?us-ascii?Q?wroHFv3InJvU8Pyhdg0vwRSeSgi84+nNyp6rFmTOjYj01X9Pd+HpVYedKaSO?=
 =?us-ascii?Q?TQu2W0P6prKXBNofzDG+BgTRzsLitKl2Aq0Y5xSLYJoKTW28/UA0Pf7kLkam?=
 =?us-ascii?Q?Rua3d6pXoQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba62cc6-df02-4bfd-c5ac-08dee8e4029f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 17:58:33.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ia/ECJ4JhfW1pCLsBtJrczlWtdGDTO6XmkOpYrVVkYdFNb4pgaUJLz9cznIXV+CqvJHGGCX34e4CDvgjpZqCUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298

Hi Randy,

On Thu, Jul 23, 2026 at 10:31:18AM -0700, Randy Dunlap wrote:
> Add missing function parameter descriptions and use the correct
> function name in kernel-doc comments to avoid kernel-doc warnings:
> 
> Warning: kernel/sched/ext/ext.c:2692 function parameter 'sch' not described in 'finish_dispatch'
> Warning: kernel/sched/ext/ext.c:5309 function parameter 'stalled_mask' not described in 'scx_rcu_cpu_stall'
> Warning: kernel/sched/ext/ext.c:5405 function parameter 'cpu' not described in 'scx_hardlockup'
> Warning: kernel/sched/ext/ext.c:8470 expecting prototype for scx_bpf_dsq_insert(). Prototype was for scx_bpf_dsq_insert___v2() instead
> Warning: kernel/sched/ext/ext.c:8784 expecting prototype for scx_bpf_dsq_move_to_local(). Prototype was for scx_bpf_dsq_move_to_local___v2() instead
> Warning: kernel/sched/ext/ext.c:9498 expecting prototype for scx_bpf_reenqueue_local(). Prototype was for scx_bpf_reenqueue_local___v2() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Looks good to me, thanks for the cleanup!

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> ---
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Andrea Righi <arighi@nvidia.com>
> Cc: Changwoo Min <changwoo@igalia.com>
> Cc: sched-ext@lists.linux.dev
> 
>  kernel/sched/ext/ext.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> --- linux-next-20260722.orig/kernel/sched/ext/ext.c
> +++ linux-next-20260722/kernel/sched/ext/ext.c
> @@ -2669,6 +2669,7 @@ static void dispatch_to_local_dsq(struct
>  
>  /**
>   * finish_dispatch - Asynchronously finish dispatching a task
> + * @sch: the scheduler
>   * @rq: current rq which is locked
>   * @p: task to finish dispatching
>   * @qseq_at_dispatch: qseq when @p started getting dispatched
> @@ -5296,6 +5297,7 @@ static __printf(2, 3) bool handle_lockup
>  
>  /**
>   * scx_rcu_cpu_stall - sched_ext RCU CPU stall handler
> + * @stalled_mask: bit mask of stalled CPUs
>   *
>   * While there are various reasons why RCU CPU stalls can occur on a system
>   * that may not be caused by the current BPF scheduler, try kicking out the
> @@ -5390,6 +5392,7 @@ static DEFINE_IRQ_WORK(scx_hardlockup_ir
>  
>  /**
>   * scx_hardlockup - sched_ext hardlockup handler
> + * @cpu: the target CPU
>   *
>   * A poorly behaving BPF scheduler can trigger hard lockup by e.g. putting
>   * numerous affinitized tasks in a single queue and directing all CPUs at it.
> @@ -8426,7 +8429,7 @@ static void scx_dsq_insert_commit(struct
>  __bpf_kfunc_start_defs();
>  
>  /**
> - * scx_bpf_dsq_insert - Insert a task into the FIFO queue of a DSQ
> + * scx_bpf_dsq_insert___v2 - Insert a task into the FIFO queue of a DSQ
>   * @p: task_struct to insert
>   * @dsq_id: DSQ to insert into
>   * @slice: duration @p can run for in nsecs, 0 to keep the current value
> @@ -8756,7 +8759,7 @@ __bpf_kfunc void scx_bpf_dispatch_cancel
>  }
>  
>  /**
> - * scx_bpf_dsq_move_to_local - move a task from a DSQ to the current CPU's local DSQ
> + * scx_bpf_dsq_move_to_local___v2 - move a task from a DSQ to the current CPU's local DSQ
>   * @dsq_id: DSQ to move task from. Must be a user-created DSQ
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
>   * @enq_flags: %SCX_ENQ_*
> @@ -9485,7 +9488,7 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 d
>  }
>  
>  /**
> - * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
> + * scx_bpf_reenqueue_local___v2 - Re-enqueue tasks on a local DSQ
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
>   *
>   * Iterate over all of the tasks currently enqueued on the local DSQ of the
