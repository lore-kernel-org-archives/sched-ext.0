Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2443340DB8
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782164; cv=fail; b=Ra1DKmvn0uUyS2MwwFsjM5y2Hiet5xpqxM6OMQHggRPTkBCvyikY6BI2JEfzj7xSAMJKYSTPL3BwWx54I2eO8KHkkJzUMhAimD2rnevYdPkKap45m5bOeWFAS/pno9IbJwIkeQMJUfzsKapcT/gMFgDjFyA0F/q04F4zngFoZus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782164; c=relaxed/simple;
	bh=rL3oKxUX3cYnN5Ga+zPa7zsSDSNrQ00pdnAMEJJi8xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WGUvayxqRI5L0u0Fq3sKPCZS4wUT9UGca6ZhZdDWnhBbhQuZPeke72xHCCWvReZmKwXA1MCigkpNfmrAS5SF6HQc/TJbf5vSzRw3B058UAA9RWVAZiNg99StCMd3F3W+sIGkqqtFJrAosdrFxgFLOFi3XX0/ww0S2SWDYznSL8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fnyvi44K; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fnyvi44K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mpg3m87ACSfNf9hUgfhwtTHKWfxpjMS8PYIBFrNrcYF7PwWcfLdcoaPgxysONCfeWHKINUlkAAcE9hha/Jv+1Cfad2xf9gyvLuI5LZ7kVnXSiK8fgoRVGa1mgNWM7P4+iVi8wkiEct5pu8KFrFIEdK9/PYxbXIusuodncGt9v0pAOf+Jeyh7fqK3zf08vOSQgGZiel6E0SWI7u2URH2MVk6qISkt9yIqnIHjFhFAdd1fG5C9WtSAtawwmsOtLDZ+1OS30l9LzIyMc1ueppg4AHIoW2KPE6vBqBqoz638zpqLLcbsf2N6z2VyYAY7NMIoScrRJVHzqVMAamrG5ObiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkTODd0TR7Mc6e+c/4jIVfc3sWl/6UDLaJmlI88UDRQ=;
 b=NHuL+Shr8KEMc+FP+myHa/gsl31e9QA5uNcow79lOzbmaUvRUQcBF+uqvYFNsJWIHhWx6yAFUXQ+glcWfW4UBwfFUvuHahpqTKAcSh3kp4Ho36JyNjCicL448VllT+cf5qjY6NPM6naZF6A58lZ89uO3/usK1QNqHxcU/+x9PburobhdNMlWb+YvRaJAFCVJGdd5C8o3DOMIvrY4Z6n4omxvrgTuPO7+YdyCcpmSdwcQs+c1injAqA6BgdUfQCMJIv9SUvDQQW+0+0Sb1LWdfg1mTnwAwYU68EbhYegcRu9xuBd3yo+xkZsAtnJBisqcm27d8zqd2BtuNtHokQqSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkTODd0TR7Mc6e+c/4jIVfc3sWl/6UDLaJmlI88UDRQ=;
 b=Fnyvi44KkG0od1blwXXVD/f44hNqq57EYl/iyz/u7vWg35Wn4t/43xHpajL6zHO4vbDYtPU+VSYpG6wVqZPdXnQhL/fDyDI9iPZvX+ImLO1gkCAAaaXd1wNLwfXS9yvuIRdWbek78LeF0bWzeMHqRuPMOGbbAI8v5lsAI6dI6dqYzwTrcQiajQb7i4LRAkSNlK858nTXqFgP/d8wwaTZ1IjbttdZFvxTw6NGfpFVTMOoH4ILneTGbAzDvjfE6STg1WAfugWsJjgAlSX7gRqRP13zK4m5VEJwoyL3w+52/fS1Lg+9DZHxq6iSsYp8i8KOYZICGsCcis/ZVwi4Vdt8ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 07:29:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 07:29:17 +0000
Date: Fri, 6 Mar 2026 08:29:14 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com
Subject: Re: [PATCHSET v3 sched_ext/for-7.1] sched_ext: Implement cgroup
 sub-scheduler support
Message-ID: <aaqCSg8fcR4L74u1@gpd4>
References: <20260304220119.4095551-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f214184-b63d-4dac-b3ff-08de7b52133b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	S0+hnxnR/lhITi2S08q72Zs/thHg3aJQIs7iudSKLPIfnxAa7sZs6ld2luM69QWaUFvubq1MEeZF4vNk3S+QZznGIdQ8XNj4/YH1cZ09FPrtA3YpPS6LAsWevWJjEtaNtuncbniVyWl6JAVUYwcwkzaorrnJ1xDCZ+X1Q5nIXagi0LWzrOFvh091zcWsd/m1Pk7YMNNWHOTAcIrAU+lFktpN9bM6BbJb5D8O7vtHyv1fE7NMP5t2HW2nZ8OYCbARLUH2IaZYsISS3PAJG2o4HUVj6Rm6HorznmB1QOI6j8ApYcEsTmJo7EDt6oNAxofMHnwnetkFetMJhttuB1lq8d1lHMv2Oi3eGm0BdXfoZKrhXamsuR5eFlbUCvT3gUFVhKCoYMUPLwIF/QDCu1zoIJDeITZyQGsWeSPVf9yrsbVHEtaD22YqVAAo/brA6/5SR7V0vDYuXLD6mijBSi+VEDDsi9jKga8SSxqrCPVPtyA3pp5t74XUcK9i03Zw2k2486aQzvTanX5hEE3U1jLrI8UkjFDh7lQGoxNu9RD1TfDMAXOum7yzjQl6LQFIFgMCTsI1OiEVvPd2AD4+Wgz1FENk7yraOHIDOJ82/Rpxn5OctoaAWJUWx9nTypeB7ly9A2hd+qOA6WnSVO7GAfzL7CaaQM7/C46EYzB7u/n/RjIOv88GkRb37Gx301+OeRSqa5Ekc9BXyEhLInp6MFI2t1oGOoeOZuPzTKgZMfhe/NA2VJBokj0+8uuVzXwgAVzX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gC1y5cRZJ0dCjf4ddJh7mY85t0zBaXhXhgrX+cwPWaf3Oaiiany0BJHjAcbw?=
 =?us-ascii?Q?E6i3RGJ1r/X+1Qm6Mrke2tfsT+C3EYwEFjuT6A2AVxFMcTJCnddklzjAahWL?=
 =?us-ascii?Q?5LEPyvQQ/QSLglr8AEA41xWRoUm95ugGVYkEN1c5mqVTT0aNQtt5CycTwWfX?=
 =?us-ascii?Q?21Ks9cLq0+EaBKcOcOvdlEA+Ms48KggKoKkDlgUf6czc9ClDSD3TrWwohg5W?=
 =?us-ascii?Q?clIByx9PY2chZRvjgIpXMwhtzteipC18v/GKSR7vPaE9ublJ8xSTZoRw7hC6?=
 =?us-ascii?Q?yjjTT5xcy3nT4Pz082qRVq9etB0tI4YSt/exMC+5KrxUnIRvMBJTe8ftw1NA?=
 =?us-ascii?Q?TFyVswObEKrvi8h6FMA0D+oDkZC5pCLjgM0H5b4j1u5RL88pNkjgFMueDoNM?=
 =?us-ascii?Q?d208AgL+6tuwqHiAmxcGg+F5H8SqOz+FEyQt8MRJ5wrdtso9bsCgVLWV4xLX?=
 =?us-ascii?Q?Nv5uEhuKoSLfnRJnc7+z/eNuE2oXT6+UUDAdXn4I3hecFYpeebQsGbOSYJYg?=
 =?us-ascii?Q?3X+gmv48Z8N/unxgZY6Xw3WuSOKJhht/kc2d17FWu0leKdxgf/a/D0HaUZhL?=
 =?us-ascii?Q?M3eAWvTKhF3mfb3etbyUc3VryF4DTMk00VUnNwFF9GjmHMiFVHMBy/+pn/YY?=
 =?us-ascii?Q?owOzkeOa1Ag6Xb9uRxecW1sJkzLCstT0PGvkBZWtWRfXZBeAC+TbDDLEXXBG?=
 =?us-ascii?Q?TLch7XqWkpPIecbaiBkI07ssk/qXE2tz9FgxjGO55f/UPGEOKvhLNi/lkJDD?=
 =?us-ascii?Q?H5UnqCttgIemCg7BtTfICbDQEf8q5OOTe2TKVKXJywE8ZKjEvyZtaDxfCWv5?=
 =?us-ascii?Q?i+olf7VIRrZa6rCl+7gWLtlFbh3fWIXIX9AbOfWi6t/fVTm5jEPhJUWAh508?=
 =?us-ascii?Q?kP/fpQbTCFy1ZwMpURXLpVXoID5IY5UTa1gm8Er10pMcFETpcPa/+7QZUUzY?=
 =?us-ascii?Q?u58B5JBUm9qgcixEV/l5qsRUQYJ5AtUAt7kQ4KZ+AuC0jtWHAl97T8lfiD3v?=
 =?us-ascii?Q?keCi2xndix2OrDmiilTOyzd4brpRFkPL5YqFFJIgsN2eD6AQFgmOX4KT1j3J?=
 =?us-ascii?Q?rPvyuz4Jd3FU+X4qy0dytC0zXVFMhJXfDu8vJRqg7pjJN5R9vIa8EumlNGgk?=
 =?us-ascii?Q?V3V5w6p/JAEzXz0rjcHCRF2+sHOXuUH9GZmuFMh+amjz7dEvWh5JDMdPbizG?=
 =?us-ascii?Q?G/oJLUloNQ2kSe8dqEncOjYsi8+utLp0xBXxQUzYUpPee0lbIyvE3deT4ZCC?=
 =?us-ascii?Q?Db0dfrBgaPZ7MNEOGmfN0XatWYEyHxQW9ui7E0TqHJt6ippKUT276M0xhbIU?=
 =?us-ascii?Q?kJO3ajW5qYVRs5/fl4gavdWJx5ugKSe1/UYN9af6irKCHfRCx+Df5enoSj7X?=
 =?us-ascii?Q?HzK9vdpVoBgdBTWg3lcpnNwQRnEGIVvBT7vD4bYQjEp1HGZw6TlwMvJOqdqC?=
 =?us-ascii?Q?/0myKjFFMnPDmon5fgiZ/5rfAKmS/LH8ec8cQLmx5QGHr2D3SYMeA+Gsabcw?=
 =?us-ascii?Q?zABD5BjBGgTQgUZcPOST1v3M+kCIilADZCICiwWrm8h1snWYqcmgtConHUIA?=
 =?us-ascii?Q?/MGyERiYXNrZPzwCMT7QPirMpxPHUX39Jl9vMFFcsyDJRRZt/FrBBurAaeX0?=
 =?us-ascii?Q?gXo7r+fZt6XkbgOVu+JPMefOaQGQOxR2mq4XNn7nHe/HV4URB/1sWNpOqYH3?=
 =?us-ascii?Q?OJlN5Bcu7SNaBgbm7QoK1m80FQAPSiWigoOncTXF+xbtW4fvXk2NVBZaKd/t?=
 =?us-ascii?Q?BWYF9IG57A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f214184-b63d-4dac-b3ff-08de7b52133b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 07:29:17.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2w4XZluMiyEy/UDvnVVswr2Ahh1NkdXGnv/3xwL9Q7AbqGoMyUeS4TvtrYVlTia/b7AGMpEbWX3IbRbHqjhmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462

Hi Tejun,

On Wed, Mar 04, 2026 at 12:00:45PM -1000, Tejun Heo wrote:
> This patchset has been around for a while. I'm planning to apply this soon
> and resolve remaining issues incrementally.
> 
> This patchset implements cgroup sub-scheduler support for sched_ext, enabling
> multiple scheduler instances to be attached to the cgroup hierarchy. This is a
> partial implementation focusing on the dispatch path - select_cpu and enqueue
> paths will be updated in subsequent patchsets. While incomplete, the dispatch
> path changes are sufficient to demonstrate and exercise the core sub-scheduler
> structures.
> 
> Motivation
> ==========
> 
> Applications often have domain-specific knowledge that generic schedulers cannot
> possess. Database systems understand query priorities and lock holder
> criticality. Virtual machine monitors can coordinate with guest schedulers and
> handle vCPU placement intelligently. Game engines know rendering deadlines and
> which threads are latency-critical.
> 
> On multi-tenant systems where multiple such workloads coexist, implementing
> application-customized scheduling is difficult. Hard partitioning with cpuset
> lacks the dynamism needed - users often don't care about specific CPU
> assignments and want optimizations enabled by sharing a larger machine:
> opportunistic over-commit, improving latency-critical workload characteristics
> while maintaining bandwidth fairness, and packing similar workloads on the same
> L3 caches for efficiency.
> 
> Sub-scheduler support addresses this by allowing schedulers to be attached to
> the cgroup hierarchy. Each application domain runs its own BPF scheduler
> tailored to its needs, while a parent scheduler dynamically controls CPU
> allocation to children without static partitioning.
> 
> Structure
> =========
> 
> Schedulers attach to cgroup nodes forming a hierarchy up to SCX_SUB_MAX_DEPTH
> (4) levels deep. Each scheduler instance maintains its own state including
> default time slice, watchdog, and bypass mode. Tasks belong to exactly one
> scheduler - the one attached to their cgroup or the nearest ancestor with a
> scheduler attached.
> 
> A parent scheduler is responsible for allocating CPU time to its children. When
> a parent's ops.dispatch() is invoked, it can call scx_bpf_sub_dispatch() to
> trigger dispatch on a child scheduler, allowing the parent to control when and
> how much CPU time each child receives. Currently only the dispatch path supports
> this - ops.select_cpu() and ops.enqueue() always operate on the task's own
> scheduler. Full support for these paths will follow in subsequent patchsets.
> 
> Kfuncs use the new KF_IMPLICIT_ARGS BPF feature to identify their calling
> scheduler - the kernel passes bpf_prog_aux implicitly, from which scx_prog_sched()
> finds the associated scx_sched. This enables authority enforcement ensuring
> schedulers can only manipulate their own tasks, preventing cross-scheduler
> interference.
> 
> Bypass mode, used for error recovery and orderly shutdown, propagates
> hierarchically - when a scheduler enters bypass, its descendants follow. This
> ensures forward progress even when nested schedulers malfunction. The dump
> infrastructure supports multiple schedulers, identifying which scheduler each
> task and DSQ belongs to for debugging.

I've reviewed and conducted some basic testing with this. Apart from the
few minor nits, I haven't noticed any bugs or performance regressions, even
using scx_bpf_task_set_slice/dsq_vtime(), which is really good! I'll keep
running more tests, but for now everything looks good to me. Good job!

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Patches
> =======
> 
> 0001-0004: Preparatory changes exposing cgroup helpers, adding cgroup subtree
> iteration for sched_ext, passing kernel_clone_args to scx_fork(), and reordering
> sched_post_fork() after cgroup_post_fork().
> 
> 0005-0006: Reorganize enable/disable paths in preparation for multiple scheduler
> instances.
> 
> 0007-0009: Core sub-scheduler infrastructure introducing scx_sched structure,
> cgroup attachment, scx_task_sched() for task-to-scheduler mapping, and
> scx_prog_sched() for BPF program-to-scheduler association.
> 
> 0010-0012: Authority enforcement ensuring schedulers can only manipulate their
> own tasks in dispatch, DSQ operations, and task state updates.
> 
> 0013-0014: Refactor task init/exit helpers and update scx_prio_less() to handle
> tasks from different schedulers.
> 
> 0015-0018: Migrate global state to per-scheduler fields: default slice, aborting
> flag, bypass DSQ, and bypass state.
> 
> 0019-0023: Implement hierarchical bypass mode where bypass state propagates from
> parent to descendants, with proper separation of bypass dispatch enabling.
> 
> 0024-0028: Multi-scheduler dispatch and diagnostics - dispatching from all
> scheduler instances, per-scheduler dispatch context, watchdog awareness, and
> multi-scheduler dump support.
> 
> 0029: Implement sub-scheduler enabling and disabling with proper task migration
> between parent and child schedulers.
> 
> 0030-0034: Building blocks for nested dispatching including scx_sched back
> pointers, reenqueue awareness, scheduler linking helpers, rhashtable lookup, and
> scx_bpf_sub_dispatch() kfunc.
> 
> v3:
> - Adapt to for-7.0-fixes change that punts enable path to kthread to avoid
>   starvation. Keep scx_enable() as unified entry dispatching to
>   scx_root_enable_workfn() or scx_sub_enable_workfn() (#6, #7, #29).
> 
> - Fix build with various config combinations (Andrea):
>   - !CONFIG_CGROUP: add root_cgroup()/sch_cgroup() accessors with stubs
>     (#7, #29, #31).
>   - !CONFIG_EXT_SUB_SCHED: add null define for scx_enabling_sub_sched,
>     guard unguarded references, use scx_task_on_sched() helper (#21, #23,
>     #29).
>   - !CONFIG_EXT_GROUP_SCHED: remove unused tg variable (#13).
> 
> - Note scx_is_descendant() usage by later patch to address bisect concern
>   (#7) (Andrea).
> 
> v2: http://lkml.kernel.org/r/20260225050109.1070059-1-tj@kernel.org
> v1: http://lkml.kernel.org/r/20260121231140.832332-1-tj@kernel.org
> 
> Based on sched_ext/for-7.1 (0e953de88b92). The scx_claim_exit() preempt
> fix which was a separate prerequisite for v2 has been merged into for-7.1.
> 
> Git tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-sched-v3
> 
>  include/linux/cgroup-defs.h              |    4 +
>  include/linux/cgroup.h                   |   65 +-
>  include/linux/sched/ext.h                |   11 +
>  init/Kconfig                             |    4 +
>  kernel/cgroup/cgroup-internal.h          |    6 -
>  kernel/cgroup/cgroup.c                   |   55 -
>  kernel/fork.c                            |    6 +-
>  kernel/sched/core.c                      |    2 +-
>  kernel/sched/ext.c                       | 2388 +++++++++++++++++++++++-------
>  kernel/sched/ext.h                       |    4 +-
>  kernel/sched/ext_idle.c                  |  104 +-
>  kernel/sched/ext_internal.h              |  248 +++-
>  kernel/sched/sched.h                     |    7 +-
>  tools/sched_ext/include/scx/common.bpf.h |    1 +
>  tools/sched_ext/include/scx/compat.h     |   10 +
>  tools/sched_ext/scx_qmap.bpf.c           |   44 +-
>  tools/sched_ext/scx_qmap.c               |   13 +-
>  17 files changed, 2321 insertions(+), 651 deletions(-)
> 
> --
> tejun
