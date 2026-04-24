Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF8B349B1C
	for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777068670; cv=fail; b=nsyqIiyF2NdcfejTXSGTLxnfm0jqGrxFcg591DOSzVzsqNGUqc6q7LbUBFfLTSdWeVgY0CmMedZGRw+2zS26BeOLSYKdWGmK8D/28CaR0qvbkkPsmxfuXtKmm4rwI97b7l3EGRKgyHPbCGj0GKTShU4x4EmMGJ+vK87NqOKPr+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777068670; c=relaxed/simple;
	bh=0e49wL+6bgrhslfFDMXi+Ab9EhD/jBRrhFzDJvY3A6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qnhZmjOPQn+DTVOknAgkWQ7kysO9GzpDoOaLE8i49bnVctBzou4zotsMIbJUK9jiT9SVXFlztsUpO+dguCtSvVAKIV3IppG7I3ON5+H0JiBunBvpt5ix/KACOTMwAdUIwMjsn4ybx3i9BnsxE6N0rSwBA4e+2IgWzWMlyHV+/nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hECCe7XY; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hECCe7XY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydPlCfCOkI3jCh8ATmoaKa4D24gFz9VQcQZPlvGQFQanRHRjjR5S/5ZzY/Mamx+6FuBpxmR6Eq64TU+c8Kg2DYTABzL+kDbSx/7KxwPu2U4vwWuCz+rbLflIRe0HmnArMSXf7GaLxzPVWn4z4m6MAjzTR6uqznWzPNj2iLzIr7ZJt19+wmZz/AnPn1mzBCbgeaTBftYYYmfgo56e6skjik13hR2EV6XPQKc1dLLGsh6QbqPRkGUOS5HFx7SdJqfobq7Umu5mdu0IxlKDT3jGwpq7tjAZ9ilB8DnbSxEZpj+chRGRILLSo/+LKSLPSO6xa+J18iqv5gksKWt+RNkmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFkGRkd0s6l9c3iL96gUCC/1OiDK6IqHbl5KPnclWUs=;
 b=hupok4xn2DS/mot7nC7MtsrmQ4RCggDepVdbdscf484hpqUKfgA50GZyzNwEoKAT5BTPt9c8FIhMSvGvlmXM1mYI069E+VsLGmdlm6rk4C6TWzJ3nzi8rGTW01IQclKDm4E3UNLazDHaktk3lDJk76MCnLVHyYz4KFqlshcox4COTAKw2ptCuLSYMxFPDGpM2XnR+AnNZlQNzY3cTFKh4ipSmK5M02uOlw1bZy0BaIzOlPP61nh1BVKvnNdiAaIVTsx8gTwgsDGvdk4T8wnYF4z1gNJL3kJKEVVouVUar+BmlD/OrsgLHz+5YmsoiUph6Qfp6RynHmKjV6eW/pU9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFkGRkd0s6l9c3iL96gUCC/1OiDK6IqHbl5KPnclWUs=;
 b=hECCe7XY+kPJ/sktFlt9x1OWXrb7mTV+c2YAf/x3B6BUQOdj8liwJs2ErbVJHmXaS3w1KmPe2PLy/E9s9sGkcgK7wVkqUmV/oD22PQFG3My0+6YDdcNX+ibcDD2Jbdl5oQWPdVFX5H1AQBPhJqUFTuj028I7b03VIrFnKhpq3ANcZbSBmNZqPFmAmleMemg+5rktzcjZf/RWUTscX6cgnGi8A0N0WTkwZYS4+40/ggFjpniLAuIho8UN3IEIPy3PaPeeTdJmD8/dRQ8FQz114AJO4gfnmVPjJ34Agq5JBTHCLr2PJf9FE57YHJ3c1zdHBmiI4X91h0m3Zc5E5dV/3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 22:11:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 22:11:01 +0000
Date: Sat, 25 Apr 2026 00:10:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>, Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>
Subject: Re: [PATCHSET sched_ext/for-7.1-fixes] sched_ext: Assorted fixes
Message-ID: <aevqbWFBkKtMMPSc@gpd4>
References: <20260424204418.3809733-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1ef59b-6233-45a7-2857-08dea24e5e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|18096099003;
X-Microsoft-Antispam-Message-Info:
	UsCvCIcPkfeFWG0J1LyRGv7lL9ArRhgV3BaTbwDkGPoHPwTQvIPhupgDXipRSzKiwf7zYwAXe+Bm03RdHAni53jUJWO0B3YFyDEj4X57h31E12LY7DY4/QVT0DMEDOf1PmZOVACimW4GQIc7ytCa/pd08l+q4q0ODU7a3mWhKnIFJgnjCVdvnWf98B+roM92gZS9G8HRorW1nuGEpbbawpgWkisr7X1k40Tc4+iS8WnEfA4Rk9yK1Jy9kPFZexao27XNwAL3YNjjO7kWXKggQupoK9/ZA6SWX/J1FVEJgZ9dhxT1u5NmHx/BIYs6FJvHs81P2i21X3AkxtrfEwOhIGih8PqLrIEsK2HX5EdG8YBhN1ek7MH00zTXKhnE2TO3vN6yCy+NuUy3+AG/zx3iA3Tx4TewVnK35r2GmXsI535BEIAwA5xBhX6xEgLeE7M4M+cgxm59aQPmNoxoP7bOohkhcyllmA5z4k1EKcS+15Jnhzlu3OAWxDtTkDGKS8fJy81fwsPEzpRx/on69XUAh4o7QDa90AbOxCcTUfOJCF0I1lHEo1rPowThT1YVMac8W8HZ8TvW3zcFDOY6qd2rsmZBL3OyUvnOykPiW41OF3bESBKOqpNEwQGAWpoya1XojOi5BapHxisXUSIn+g2MHPuHc1T1HZYy/jJ+OM+Sj4IavwrRZq5n21wg6g365ym+oct4sHOBmzgxjbwfld1LOTqPB1T972xh15liAPu8T7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(18096099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXAyDhKTsgLwFzb6jwMzyRO8qNlg8XJ6jOUITcmcm7n3rXyclfiKBWnyvnKO?=
 =?us-ascii?Q?rZC3EObjDXcS/83qr8ZKmOa9nzOC/dpjX4MgpEbLGqE7N46xGUcNmbU9ssJk?=
 =?us-ascii?Q?wv1Z6iwLKhcXBYm9iRX9AqGbUkhLgXuWSKJql+ZVi4WkJp5M2yRprhNTH+Zs?=
 =?us-ascii?Q?8LP8Fj6RmC+2WZSNAVfFBjKOzPVpjexKOTHfYkLwqz8OQF8pcB9qvSKIRSdF?=
 =?us-ascii?Q?UibZsLUmoBnNhZr23xKMfU24K/TKDjuXt2bYN4R3VWRXiG1Ga0YxBJJ+c7T7?=
 =?us-ascii?Q?Usl6zBV+Z5MO67zUtnXfnFPOb3yoS+IMGQEMuBirK1cqfWCfzWU+3mU53jvj?=
 =?us-ascii?Q?Kyj81plFi6wKzBGED3v7COhnjEtdqo4D4vUVIMyUvgQvtHQ1bZdazOuZNJvd?=
 =?us-ascii?Q?vtzbgXmpS8x8aB38oMHNL66SZSg73mavI+p0AhBTiDBWV3BqpomPin/oRQJS?=
 =?us-ascii?Q?nxuG1cnjnsy9CYgapWuTH5Xn3rG5Oz9HFQF787KN4JJL9HjMF0fzDexK/ce7?=
 =?us-ascii?Q?bhuNnKfoC8tYw+lr8EINkxr4nEHCe7GkTEOz0RZk651R4Epa47Rkf9sPHhhF?=
 =?us-ascii?Q?nXTnQQ1d61FXQY/cQPBF5UbCHK79/WVjR61p7yzeGwKWE0K/X9Tl63IMM0j8?=
 =?us-ascii?Q?3nxyQL+Gve0mNY10CFhIoq8P5BB/lX6ZuBgZBedYFr0OMK8mAEgFMPuVlQJT?=
 =?us-ascii?Q?u18jbXhXLwnNs7LJZ/MLhV2+Qwl80yEYbGd6ESogrJ2+XGmLhOZpyHKBz/QM?=
 =?us-ascii?Q?BW9rXIxly39sVSb2gLlQzCeZtjgXYmq26TwC5HcLnBNmumTNQmNwn/I/WofQ?=
 =?us-ascii?Q?r2jEHx6BDpeH9JXyW+MfDrnPEKV9Z04yKp1GkMLh9mYEVZjCcUF0WipPDovs?=
 =?us-ascii?Q?aDALmklqy/brIM9x/9xDC2SVnvNTBg3UsK45k56C9qgHVB1qTryeb5o3cCrJ?=
 =?us-ascii?Q?+t/SV6d5h2bw6GcnL384Gg74ZCc2rSK8x1LnzEexa5O7DpmZTHvRolHgEZGV?=
 =?us-ascii?Q?15NsNwScSAzEw7kszseOWC8Yw7Lx9boipYoMU7YOSv1QPEPTHG6Njufeb5mT?=
 =?us-ascii?Q?obPc7WycbnpN3S9ml25fr9qqCS5l+n/hRC2JuqsZYWmEapDh1fI92krC7iQV?=
 =?us-ascii?Q?zBS6lgfeiSw/DQL9KY8uXHAkVQCsvhM1Yd2aw7QeqjwNP307Xh4DR0dc7xNo?=
 =?us-ascii?Q?zJd3YcR+UFovbgUIgaHGcOHr2Ku5qfe3g+lju8lQ8k3NEMs1V1Z95IOrqpTl?=
 =?us-ascii?Q?9TXTB3eCE4R7EcYz5lpKmGA5hsSusr3/c9ZW32OeyztIjGe/1oZxfAIS3SMn?=
 =?us-ascii?Q?VMxXTSuo3Y/D3360tdt6YxEl+glhnxuBOlcm4HvtBcoCPdcP4wYVjuKKGIgG?=
 =?us-ascii?Q?Yg22b78nv/mqFH6GESP0u1tw+0n08zsQpK9ouwdwBUvgWO8YQCCqIEQh4sg6?=
 =?us-ascii?Q?USyubqFw+P4IxY1H9QOcU9QWqGcBCiJNJeQRlhgkp9QqTmilLue8QvOzwIt8?=
 =?us-ascii?Q?Fa0ytHEnOTdDxuftpGD7iwcC9wfQCTZbxsAa2h75phULNSn0nh3oIZf61UcL?=
 =?us-ascii?Q?ybMRM13Qzsscd2vxS/UkZYSR3fPUnaB6arzn/8J65PfRWRmNruQxX1EVc2fa?=
 =?us-ascii?Q?Bk3rxFG9Nr3VDYsOr8aAh46r5zYWW9bGw0BQB68GezV3mTWQxOdDa2ArpE8V?=
 =?us-ascii?Q?hOmmNbCS9F/meQBZuAFVMsfLFzIyxuFQ53r/0WyD3T25eidfMLoXeXmH/W2C?=
 =?us-ascii?Q?w/GGu51dCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1ef59b-6233-45a7-2857-08dea24e5e7e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:11:01.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8m0vWUCLeyMGpli5WFEL15hwuggL0/pdW7vLtBaj30V119ISUMv8AEIM7psDeDg//SmvJ0IbpnAH/Gtwc/I4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511

On Fri, Apr 24, 2026 at 10:44:05AM -1000, Tejun Heo wrote:
> Hello,
> 
> This patchset collects fixes for issues surfaced by Chris Mason's
> AI-assisted review of sched_ext. The bugs span use-after-free, leak,
> lock/state inconsistency, rq-lock AA deadlock, and cross-task kfunc
> misuse paths. Each patch stands on its own.
> 
> Based on sched_ext/for-7.1-fixes (510a27055446).

Sent a couple of comments about patch 13 and patch 15.

Everything else looks good to me, feel free to add:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
>  1: sched_ext: Unregister sub_kset on scheduler disable
>  2: sched_ext: Guard scx_dsq_move() against NULL kit->dsq after failed iter_new
>  3: sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu()
>  4: sched_ext: Don't disable tasks in scx_sub_enable_workfn() abort path
>  5: sched_ext: Read scx_root under scx_cgroup_ops_rwsem in cgroup setters
>  6: sched_ext: Resolve caller's scheduler in scx_bpf_destroy_dsq() / scx_bpf_dsq_nr_queued()
>  7: sched_ext: Use dsq->first_task instead of list_empty() in dispatch_enqueue() FIFO-tail
>  8: sched_ext: Save and restore scx_locked_rq across SCX_CALL_OP
>  9: sched_ext: Pass held rq to SCX_CALL_OP() for dump_cpu/dump_task
> 10: sched_ext: Pass held rq to SCX_CALL_OP() for core_sched_before
> 11: sched_ext: Make bypass LB cpumasks per-scheduler
> 12: sched_ext: Align cgroup #ifdef guards with SUB_SCHED vs GROUP_SCHED
> 13: sched_ext: Refuse cross-task select_cpu_from_kfunc calls
> 
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git fix-slop-review
> 
>  kernel/sched/ext.c          | 238 +++++++++++++++++++++++++++++---------------
>  kernel/sched/ext_idle.c     |  19 +++-
>  kernel/sched/ext_internal.h |   2 +
>  3 files changed, 174 insertions(+), 85 deletions(-)
> 
> Thanks.
> 
> --
> tejun
