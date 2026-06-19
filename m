Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0440D561
	for <sched-ext@lists.linux.dev>; Fri, 19 Jun 2026 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875970; cv=fail; b=bHqf2wY1E2hafHg2i9RqCTAGIOSoRnwraoQ9jrV1xNXqRy+rm5pPP9Yq8ewYYLU04Hnmv6zzSWg6BABVXLKS2yIe4TynaqlFvDo1XCzjgTuvUwwl9VM6Dhljo4V6pLjpMgfw13BRK/u6w/CQgmdOibk5jG56/pxc1HtHC9U46og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875970; c=relaxed/simple;
	bh=/htonLtWXc3QksQS7UmuAMoYydPERw8Hb+hcqohsz7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qtNBePyhTV++yCpqkrNNXu73CBV/55SZAOuyep2hg12romi3qotiA3rvgrXBltQrfY3cFLuu4vw3n0jFDoX4W0GmyydC79iHlP5Osy1A5+PZlBOkNc7LKgCukLg+zcCD1Uc9H1PDX/zSUcbFlb0H8O8is55I0dnd+i/Lypa3WnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h8WORJ1O; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h8WORJ1O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvlxm0qPOmBHZZuLRGvQSf9urwqWClICoUyA1feoPTCFeIK9EwNVeubcHw4eAf16KpKsWhqcws9HKn1bHjLY6/fw3Lz8z9f8PqU4iA+eXa1SVcx7CxKnu6VS9JddR0ceSwHOA4N07gsFmaY0E9S/hDq9dPHejxbTXOs+KhniI26rQtkia1fpq5hFlbGD40pnLedXEWRlACEalo8Qi+Q3eFkvN/x+xmxYCOAfV/F3H/33rsD8wIRoInBy/Xel9egR8yK7GZM9aDRNka9xpnuFWxkxfr0gWfa66MyS4cREggwfnKeBpeZ0CfPU+mrfEIa2DC6s07dq+1Kfbt4hXFIUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5fKZt8pdP20GHLaiZXUI7z6vG14LmBt8mIq138MPvQ=;
 b=Y8takJvrgMWQOajizZE0L26+rROFWPfDOnl0SI2R+eS+ZA+zkrlGkfkkvApTcH0cFxi1dOZLxLS588f6l/E3q+gQXokjatF6ZG/vDoSuK33E3byfnaA4aNqKJqVLY5uayfwPhs8D0r4c3Ye747CJm99a7bbTqjRAgdJsHrGSCdUUzvfCR2cogsP4mCnk7tTAWacNIitinEETwJZCnHSCDxW+ziz9D0PL2p8B+1lHg4iawjn612rP2+zFNzp1vgs+dvywBCkkRhEBnkKoBOk6kosx+oOpxxbSQKVq6gVzwa0mok2pSTSNoZ9ajCNzK4oY0Ydqne5B/vzzd2uzHB1/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5fKZt8pdP20GHLaiZXUI7z6vG14LmBt8mIq138MPvQ=;
 b=h8WORJ1OHoWjkHIBVlRCj7NqeaPWk67ffAqjvlrprGusqMNiU6v6wP2J3NresC0HUujGn4c5Z/VNwaqtBzN52JVoWSsrn2MuWk+kY4uT6nV2ccTp37q70TFzwI5zLjwRBNRk9o5elCzo82H5/rvjVGIHVPTV2QW0z723oknNWkETjMbs/7SrRl33+m2MoxdeSghXUbo5PK7q6zQaTF8csWiuDrBT4o/Esj29ROPAG8gTN7p1unI4ggKfGkPv1uflbLU5Im7s/yFVA9gbdLlr1JkxjbPsajDFuobJ9ZlzBwe/1IMJT+hQDKhk+/rTFoc+TcnSW3Tdubce9SLBHDIPmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 13:32:44 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 13:32:44 +0000
Date: Fri, 19 Jun 2026 15:32:36 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.2] sched_ext: check remote rq
 eligibility under task's rq lock
Message-ID: <ajVE9Msy9kEv1ihV@gpd4>
References: <20260619132359.831936-1-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619132359.831936-1-jpiecuch@google.com>
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 576da773-b9fe-42cb-565d-08dece073e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7136999003|3023799007|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	XHk8IMCWgWF2qFdbL6Pz3DJJHrLW4fXdptlG+gfOyLaostAJ/bMc9e9+CBpakyrmqcTwRCWUOZDbO03leDR0clM0bD5fVn3liHJUWyfpytgw+/2IrpeTuTSdMIh5/z27ewoeyxeIloOVMp9sQVl88VrPhoph+C6IxQO21s/yK6IRvTfR7ZPgVqQvHeUAQ8I2R38eE92n6qkV99j7sEkAu4Pvfg4RAuqlEWDUUQFRKIeKZJy/qivdz5IVmSpizzj6a1xnuYZUZdfK5diq8BCiBf9OORB1Hntc2QZi/WMLtSZ73VrpvZiY9Jssxbpir09KYUB9HBkPVnSVdwQE+tBZswTGOl0/9Fg50vksQjNybRBHTFK2+J9C6hvc3G0Sd00mxIqPkpJMuNzIbdZFZ+x9cdFdDo/JcNzP1Z7ocG0yCwpHbBb8BLZOgCDgRAM6rLKhghVergOjq5c2rpdMWjgQdSMijflTO6VBdK3qp7+EQecclkPGlyfuKhKsEi3QdxafjTvkQ9hd6YdvQYeJQRSrbMZ70LSo2NPYXmPgIRLopRz3uM2QV8r62kIxQ7dn9fEPyiPQcF+2iqEFx8YMljRRfQGXIU33+y1VBhWIywWqJfUFImh51RbB8c9pmRYF6ZiO3LtRXuriSbUy/LvRwBs3xoluaaiHAyCDm/JEqsXoeyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7136999003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LGo3cytzqeGKtvv3TsiLec4sfw4gb13ASg5QpfQwITdJ5Xka4IvNDV5kRm7H?=
 =?us-ascii?Q?xiLACeARtdkUneI197pEkltAl3pDlSi/fJqrUyGjTML6uYuagccvtMmi2V1H?=
 =?us-ascii?Q?sqK21uX5Gn2+ykKRT4ylhy4xyznMRMGN1GSnvlzjnnoNnE2LtBenYMJXEEqX?=
 =?us-ascii?Q?XiOyg0GsMuSuxXq8vzHzWDBl2jf3u4lfPZvl2nozcXb+7IZILVlhBFDlfnrc?=
 =?us-ascii?Q?Lrg1DC1LpPSDzUvTxycp3SMEGjuscVp3S1sfjadMWxkpLnKdPGugUXRJd2qH?=
 =?us-ascii?Q?VskYjLizetLeQ3Uac8ZPst8fR6GEy16+DqC9mzMsKyADTbzgJj5hjFy/raxA?=
 =?us-ascii?Q?lCQDGoqNrKlpOrCPKssaCuviW/PCdrkTOqCUUxM7tnvQhvpJuWzu6wPId2xR?=
 =?us-ascii?Q?NTnOAvzJHyGP1hPFMI4TKlMK90ichk/wnEV1MbnJp/r2ZunUmVnpA6jOd60f?=
 =?us-ascii?Q?4VHW5aEBE3ZUXWHy87QtmcCr4WsKb1vagKn1Zfvbzq38eX5IneoanmOgyPEy?=
 =?us-ascii?Q?2ln9Uzt41LGqNLkS/zzDg3Qwb/omXNwUxN3xEZ/p88mnlK4sn2Bjc1wOvIKa?=
 =?us-ascii?Q?miGJhVcovMghOMhZx+j2ML1t+e/ryFzWAAOwtE+++IgjzrdLncIAfhbJouFV?=
 =?us-ascii?Q?YaLFoDCw0OFWEbedP57RK6ckiwuIPebCh5z4vo7O3XIFixHBy4WYyjQf5Qla?=
 =?us-ascii?Q?BG2UDRrSvBIbsWX2dtF6xNf4fffV23vd9WFfQHFwTIVF0VJne5F/cSMcAJ/x?=
 =?us-ascii?Q?BgWrK8KOtjjh4s5F4x1sjFve0fPmy7JrBu59axInLlq10bNW8X+YIrL/tc6x?=
 =?us-ascii?Q?+q/SjyV3fYkgBv895Ta3u1r7Uk3xldwEKgAoxWj00berruUzGpECh5bqfx/a?=
 =?us-ascii?Q?bDH+d5NYSlffDOjBEnS5qTwn91t59eWv67izqknYTJ8YUG3q1kVKzQ2Rae10?=
 =?us-ascii?Q?Gpu9j1KzFR1Ttn0+wnX0gmyxOBLiz9Qg1kBTY656MU3QOviJ+xaphDbn2apO?=
 =?us-ascii?Q?9gw6qEKRjXvDptBEmL2UYXB4AeeMTAlcFANc9glpNGdIi1OuX/eHsKRziIcc?=
 =?us-ascii?Q?huPIdfAkcCDXi19NiizUeIhBY1h9jzZtMJ/Th2ng70ueto0wO98kFkITZ7v9?=
 =?us-ascii?Q?Esz6Uti8U+6jm76Ue5cJ7uiCFJtkQjc0tPBgldabYChnBvzk1wT3UdOUEoVD?=
 =?us-ascii?Q?VA+fFck+o1M8fDB9A/FqsayeXLNkBEq5xynh+jqP8KW4WUhRg9cUEUalzq2k?=
 =?us-ascii?Q?0g5cY/UisxH0ST5Fev7Z/BA83cjaB6Pxd47yOYNAZmJDxZad7ke/M31gJz8o?=
 =?us-ascii?Q?qkk6k+S8Z9mEPFGVXtnoHdUwhZO7xCDN2AuUhkItbB8KFZTIL88fhbHLX/NZ?=
 =?us-ascii?Q?fGg6KRLpqSFwZSB2yLrnAbmn5BUbeaYPLl6aGQQGzq/UwCnp/Gbphaq4HnLm?=
 =?us-ascii?Q?+Wia4zmENI/y4sxObbOZLaDySJr21bP2KNDlOpPaDzGsY6uCG3AiUGc5uXlB?=
 =?us-ascii?Q?kQHcXlRxq2kIA7XwUraOn2nnWly9aQi2JeVivV6riDy9DW7HL+JNRCpG1nC5?=
 =?us-ascii?Q?K0L+D3pSQvkbZCYp46brDWxr1K/eZgj7PdDn8b/2oA8mQqzlaNo7t4AXYpsL?=
 =?us-ascii?Q?ucZz47l3ik5JAkvXSW7VEUMOxJBLgpR4BOO0FJ69nCkqjgewBWY3edTD40sy?=
 =?us-ascii?Q?OQj6eUNgi37fmNWVCiLcs0kNqWbgC1plgIJ+NIbXyRvds7oppVQDz9TJpcNO?=
 =?us-ascii?Q?EddZXv9eKw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576da773-b9fe-42cb-565d-08dece073e77
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:44.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQEzCkyYH2o8IOaGSRy+BWyxnd7D3SYpNE+EyFH67ITbEFYh1Ow+9rSJAgfBGzaDr7ZZacOnp49MAWSKUGemlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141

Hi Kuba,

On Fri, Jun 19, 2026 at 01:23:59PM +0000, Kuba Piecuch wrote:
> task_can_run_on_remote_rq() operates under the assumption that
> p->migration_disabled is stable, i.e. if the kernel observed
> is_migration_disabled(p) == true, then the BPF scheduler must have also
> been able to see this when dispatching the task, and it's the BPF
> scheduler's fault that it tried to dispatch a task with migration
> disabled to a CPU other than the task's current CPU.
> 
> This assumption does not always hold. It's possible that the BPF
> scheduler saw is_migration_disabled(p) == false, while the kernel
> observes is_migration_disabled(p) == true in dispatch_to_local_dsq()
> -> task_can_run_on_remote_rq().
> 
> The crucial thing here is that with CONFIG_PREEMPT_RCU, migration is
> disabled while a task is executing a BPF program. So, if there's a
> situation where the BPF scheduler checks a task while it's not executing
> a BPF program, while the kernel checks it while it is executing one,
> the BPF scheduler will be killed through no fault of its own.
> 
> Consider the following scenario:
> 
> 1. SCX task @p is executing on CPU A and CPU A gets preempted by a
>    higher-priority scheduling class. On entry to __schedule(),
>    p->migration_disabled == 0.
> 
> 2. In put_prev_task_scx() @p is enqueued on the BPF scheduler's internal
>    data structures, making it available for other CPUs to dispatch.
> 
> 3. CPU B enters ops.dispatch(), pops @p from the BPF scheduler's data
>    structures, checks is_migration_disabled(p) which returns false,
>    and dispatches @p to CPU B's local DSQ.
> 
> 4. On CPU A, @p hasn't been switched out yet. Execution reaches
>    trace_sched_switch() which enters a BPF program, as the BPF scheduler
>    hooks into the sched_switch tracepoint to detect idle->fair
>    transitions. On entry into the BPF program, @p disables migration.
> 
> 5. CPU B enters finish_dispatch() -> dispatch_to_local_dsq() ->
>    task_can_run_on_remote_rq() which observes
>    is_migration_disabled(p) == true, triggering scx_error().
>    This all happens while holding CPU B's rq lock, so it's not
>    synchronized with @p switching out.
> 
> This patch fixes this by moving the call to task_can_run_on_remote_rq()
> after @p's rq lock is acquired in dispatch_to_local_dsq(). This way, we
> synchronize with @p switching out, since @p holds its rq lock all
> the way until it's switched out. Thus, any BPF programs that are called
> between put_prev_task_scx() and the end of the context switch are
> guaranteed to have finished and cannot influence p->migration_disabled.
> 
> Also add a lockdep assertion in task_can_run_on_remote_rq() which
> ensures the task rq lock is held if enforce == true.
> 
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> 
> Changes from v1:
>  - Update documentation in ext_internal.h explaining the locking dance
>    around task rq migration (Andrea)
> Link to v1: https://lore.kernel.org/all/20260618170047.283701-1-jpiecuch@google.com/
> 
>  kernel/sched/ext.c          | 24 ++++++++++++++++--------
>  kernel/sched/ext_internal.h | 23 +++++++++++++----------
>  2 files changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6567f626b3f0..4ae7ca4e0a41 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2422,6 +2422,7 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
>   *   no to the BPF scheduler initiated migrations while offline.
>   *
>   * The caller must ensure that @p and @rq are on different CPUs.
> + * If enforce == true, caller must hold @p's rq lock.
>   */
>  static bool task_can_run_on_remote_rq(struct scx_sched *sch,
>  				      struct task_struct *p, struct rq *rq,
> @@ -2429,6 +2430,14 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
>  {
>  	s32 cpu = cpu_of(rq);
>  
> +	/*
> +	 * To prevent races with @p still running on its old CPU while switching
> +	 * out, make sure we're holding @p's rq lock so as not to risk
> +	 * erroneously killing the BPF scheduler.
> +	 */
> +	if (enforce)
> +		lockdep_assert_rq_held(task_rq(p));
> +
>  	WARN_ON_ONCE(task_cpu(p) == cpu);
>  
>  	/*
> @@ -2696,13 +2705,6 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  		return;
>  	}
>  
> -	if (src_rq != dst_rq &&
> -	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> -		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
> -				 enq_flags | SCX_ENQ_CLEAR_OPSS | SCX_ENQ_GDSQ_FALLBACK);
> -		return;
> -	}
> -
>  	/*
>  	 * @p is on a possibly remote @src_rq which we need to lock to move the
>  	 * task. If dequeue is in progress, it'd be locking @src_rq and waiting
> @@ -2729,6 +2731,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  	/* task_rq couldn't have changed if we're still the holding cpu */
>  	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
>  	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
> +		bool fallback = false;
>  		/*
>  		 * If @p is staying on the same rq, there's no need to go
>  		 * through the full deactivate/activate cycle. Optimize by
> @@ -2738,6 +2741,11 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  			p->scx.holding_cpu = -1;
>  			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
>  					 enq_flags);
> +		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> +			p->scx.holding_cpu = -1;
> +			fallback = true;
> +			dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
> +					 p, enq_flags | SCX_ENQ_GDSQ_FALLBACK);
>  		} else {
>  			move_remote_task_to_local_dsq(p, enq_flags,
>  						      src_rq, dst_rq);
> @@ -2746,7 +2754,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>  		}
>  
>  		/* if the destination CPU is idle, wake it up */
> -		if (sched_class_above(p->sched_class, dst_rq->curr->sched_class))
> +		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
>  			resched_curr(dst_rq);
>  	}
>  
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index b04701190b23..457df0bebcd9 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1463,21 +1463,24 @@ static const char *scx_enable_state_str[] = {
>   * The sched_ext core uses a "lock dancing" protocol coordinated by
>   * p->scx.holding_cpu. When moving a task to a different rq:
>   *
> - *   1. Verify task can be moved (CPU affinity, migration_disabled, etc.)
> - *   2. Set p->scx.holding_cpu to the current CPU
> - *   3. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
> + *   1. Set p->scx.holding_cpu to the current CPU
> + *   2. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
>   *      is set, so clearing DISPATCHING first prevents the circular wait
>   *      (safe to lock the rq we need)
> - *   4. Unlock the current CPU's rq
> - *   5. Lock src_rq (where the task currently lives)
> - *   6. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
> + *   3. Unlock the current CPU's rq
> + *   4. Lock src_rq (where the task currently lives)
> + *   5. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
>   *      race (dequeue clears holding_cpu to -1 when it takes the task), in
>   *      this case migration is aborted
> - *   7. If src_rq == dst_rq: clear holding_cpu and enqueue directly
> + *   6. If src_rq == dst_rq: clear holding_cpu and enqueue directly
>   *      into dst_rq's local DSQ (no lock swap needed)
> - *   8. Otherwise: call move_remote_task_to_local_dsq(), which releases
> - *      src_rq, locks dst_rq, and performs the deactivate/activate
> - *      migration cycle (dst_rq is held on return)
> + *   7. Otherwise, verify under src_rq lock that the task can be moved to dst_rq
> + *      (CPU affinity, migration_disabled, etc.). If not, clear holding_cpu,
> + *      leave the task on src_rq, and enqueue it on the fallback DSQ.
> + *   8. Otherwise (i.e. if the task can be moved to dst_rq), call
> + *      move_remote_task_to_local_dsq(), which releases src_rq, locks dst_rq,
> + *      and performs the deactivate/activate migration cycle
> + *      (dst_rq is held on return)
>   *   9. Unlock dst_rq and re-lock the current CPU's rq to restore
>   *      the lock state expected by the caller
>   *
> -- 
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
> 
