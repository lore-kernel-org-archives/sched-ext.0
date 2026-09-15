Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E943B6CD
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789453445; cv=fail; b=lJLig3LbC4zbVx2Oj3dBZTxjrZYyp46usVmjKO/5sEvqElxG4ALogq00FnVsStrSfE0leEAvzisx56f/B5H0SfJk1kikxvA1a5WI0JkT10CIzg1oGU602orUxUk2QQ4H1qXDuOQxtCGgDLuefWheOtBefdaneJQiHcPqmINqpq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789453445; c=relaxed/simple;
	bh=bR+rZDjVv28Y+j+Vkjktr7efHhtm687FASJ9d4AZ18E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BwBP8Xw52EpI9tGUCzFxTUxo5KXmzNNoZDuTIrOUXd9596o1jadyACpcFMT+HJcYHI43RgGs0W3eSjsvOlz1K6g4fxQ3PzdM25VCaMCAHSfwz28oaed0CblErMNxE4joJZdgY+I/lBmDvoBg31acsN/aQq68zsVNDkUE9f1MIBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qSHtVQzE; arc=fail smtp.client-ip=40.107.209.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qSHtVQzE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAWx6tznIykHox0vKuy9C3RIAW7L+tL80rM6SMKyQQEeGePJiTxII3RJ6R/dO2lKq6whATaJMBrWPWqGGnWM465qhpCA39gQvgsimzxNj2tR/nBkNpWiXLPRCo/Yxa10xkQn0C7MmAVUsQHZleyerjPp1TZfVUXC81KFodl/spPAQjcLqEXhjq4pEHHjTP9NIFWiClEcOmzN1gOL98ZVsNHTz4+xA11ydsZhKA8paq9YwjsZfGSysxjjPMOSAgT2Ax0IBl4hw0EsgGeDA6oKH7RVeR5L05SlUZJYPdyye5aAlUk2QKXU4Jlx1eFIFa/F2PgDQE1zdagVHP55Rfd+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezyNSGZJ1uNskqrA2USdGnMLAKh8AiQzpuoH0vu4js0=;
 b=n4WMFmYOTPURLmDGecgwYtBx9q7vN/bCBi+CtdeuGY5yxo/Ckn+PE9cMj4oJv2A1AKAKiVlieR5sbs3/ziRz66NpTLBPReNaCg/iKgxuiBeQCpee4J7b0OTgVgr6A76UiAQ9I00Woq5s4lYRSrBTjD7wb5KCIsSaebmOfEVoOJ8IQIox7T8FPxqmtTduohSimo99CQ35kxSmNkjxWv4AvbU6UrG/aLJHieQdVpNS+7YhwpJpOwS2eAnPsBETW8ooPCip4AXTUfTWmZawgpJkHV5puOwe6E6J13FjahemfQuSpXH9ksWH78ES4wnsW+udc711BpsyPls7xF7pUedOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezyNSGZJ1uNskqrA2USdGnMLAKh8AiQzpuoH0vu4js0=;
 b=qSHtVQzEelKh6addPNfUNZ/1vReV+jL0idWYoK+a4br8mD14ba8fA/KYRw18AUv60spqPHDvu6m+YR8RLh3Tgxy7nkIxgw2Pw8yWFyNewJnfNk+nnIX7mxBbhLzQb6G87rappCUg4gVDRtg8i1511YfRD4ZEKKWYtWL1L7wsA2uhTbMdFHCne7ji0+jnQQ/mhtynjYNQT1U/J9tJbRtK5jlRjt9aLNyDy/sTHvegsXv+Pna/LTKan6oo8QZAt4jW1vLdu7ap2CukgeyTFFQSKGheQMtTpSh6OFKB5D8/AwN7os+y2N2GosMYqs6Y+wp3XNhnEbxJHObauPhfK4NoLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Tue, 15 Sep
 2026 06:23:59 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 06:23:59 +0000
Date: Tue, 15 Sep 2026 08:23:51 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix idle state tracking across idle
 repicks
Message-ID: <aqjkdw_Ds_O8W4eR@gpd4>
References: <20260914234259.3585373-1-tj@kernel.org>
 <20260914234259.3585373-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914234259.3585373-2-tj@kernel.org>
X-ClientProxiedBy: ZR1PEPF000077FA.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::44f) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d67fba-ace8-408b-eda3-08df12f1ed78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZwQgUGKOMgQwvfexPbZEXSlSFEXw5CRcB2dTiRn65aO2y3QcGgGm6LWYhLY80ANOgF4g/+WkQ1bT7TfaNQ7EVaLaABlSq8KhsoH5y+UKr53XJXvxztMTXrPMwKhLDD3gPhD03eQQRut48wUxHyOJSITKjy7Sc50goYVOQ9wNX+e3DJavoyuOYjpvNk8vfLjENnLt6USelkTFgr+KqCpt0Yghs+SC2AGkn3eX/v0RoFikyLlmEaaxuVEfntcU5NEsNzn1EStCjmei+CMxRVIWLiM3KpB+In04+8g6o40daNrFq19/p0RTZXkPZN2r9zeIb4bZZ2SmG03KfpQgZ70D39BIRBLbRpun1b5/YvIYi3sEJKlwF7ez06dynuCrjUQer3ExjO9qiXuNqMnaqbM5/amxmAtu0fV6QkA0tGqUvU55utzZucU7BgQA0Ol9f3rOIMqKsEUfPxCv7g7J3121RIhKV05alO2lo5rjJxVrbGeUdc/HtiwuuhmgTZkQX0v3SXCGEfITKyhdfWntdwJ+j13u1gRJsYmlfwAprLgqEA3k//y7qGnxFhGzHD7iOMsoNH4BdSJa1cUPL7yCJ71FRuLTeqdXpTe/Gc3J8m7Ky5DmlNAxvKgzxv9Ij37cRHjE2zLX8/Lg/bFWK8vOqMv01rJ825GPDVHEJ8WcokjE/Ps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+5MUrWg3/GkMUQYZVKyF8X2ekwbfvsENXw6wrc/tCZCB7ar4W0Yf6k2aGzmU?=
 =?us-ascii?Q?T3BWgUgErChm6Zyl4P6YA3uO8V/H++WRX3Vadlryo76z/T/W9GxRMDMLdO1E?=
 =?us-ascii?Q?uryiEDnM3H+5zhYOlNmHBpB3S8MHqncorMuztTgy8jhyMIxRDXvmqXcIQ4WZ?=
 =?us-ascii?Q?S8cBlJHFYV4RvuIB//NJHvufdLIxi6Jr3U1PGs7FCDFqdf6jN8sf1193uq/l?=
 =?us-ascii?Q?vyuNRgPIInqCQYOSuNXV3H9MYFELASp9HAwhZz/EOaKxOjqlfdxymuzUVtgh?=
 =?us-ascii?Q?H+j3cbMoL+/Yi+0/yYACKW7xahqwGCrznTsvKIVZJ40iq+Vqz1ejCqRdQy/m?=
 =?us-ascii?Q?sC0TimDvdNk7X1UYA3mhMaIoGfHZuareWQyDSC5d3QJgxnZzOCdZTTbvZL+5?=
 =?us-ascii?Q?ZG9H2KXC7bXZ17DBQrK5cyRgSipxfX3PkqqUqAyShsGjLE8haGWLop5hTALb?=
 =?us-ascii?Q?sfAqTY293hytSPReoMQpoYdZeZ9/5bvbFnL70LcMAiRLsBvrEvmPv+CfhiBx?=
 =?us-ascii?Q?U5gLkZPLr9XXX82h6gCJbxGinzgHeDlNyovzBC5YP6nrlbppOkFEAybpz0o6?=
 =?us-ascii?Q?NbzMZTQqskVr4SSOFVi4p/Qv8LwNMh+59yojKE6DAqzUC8F2dj/rnKddVYpo?=
 =?us-ascii?Q?fJEei8KTYI2PhflQcywH20XbNuWVgqX7leDBPVVx0UvAqFyWqjQG3xBsvA6t?=
 =?us-ascii?Q?paohFX3iStNULWptpwhjJ7jRJBPfcwEiB27y7T+DwAGbnVQRNVWyXHzQ4CUF?=
 =?us-ascii?Q?Ynlo7gLkb5t83piIwhb3epfy/5E1l2LB46h8sUH3ORd4iUSzIGOWMjDwGm2j?=
 =?us-ascii?Q?vCp5QUQMWMuqndrYhWKfQbbyhx1jtUkKseGKYnLZS8SaWM6dSoSjABpAJRLW?=
 =?us-ascii?Q?mBwOcm/RxeH8XnE74qsa58XIIw1Y5FR86odIZoQV86OdFd4WdAGHCbzQRHJ6?=
 =?us-ascii?Q?Fe5G+ZS/1vQ2KGlYNCme9q6k9Q02yIGqjP4TMuAc0CfqL+Iyh3xmXjU3ni44?=
 =?us-ascii?Q?0h5dzV7u3LiS9TAk+x//aeHA/++qCvEUFVgQr7DBBXBGd3GHPlUmGmxnKB5H?=
 =?us-ascii?Q?iXKhbCOJawp8PUwlU9Bnzz6DXaS2I++p1taS2EcMmoK9/J5DlQp0cuH1T8Yv?=
 =?us-ascii?Q?6wudpcWgCcgjxu/+ZcgalRctP9d79aAPUj/sa1qVWzupib/K7aBpL5viKyFz?=
 =?us-ascii?Q?OnnT3vApdojlcsm4RuPToqWIoyW43C2veyDZwLVws9DM2w5X2Nz0Nj7uylj6?=
 =?us-ascii?Q?cH+d24qDlJB79Fow0vLuIQKJux614kTg0Kgqe65owAGW7YZdzz5N8A6xw+Vu?=
 =?us-ascii?Q?eDr9pwxudKMacH4Q9hS0dl2D4hJ/qWE1hKhmg/VD8A30El/cwoH7XGoQnYFJ?=
 =?us-ascii?Q?9dVmFWvpK/C7pqfsnQfXRuPQvjQaDpZbx+kkWYNkbjxttGiOgnCJAndtD/QI?=
 =?us-ascii?Q?TD3vo4Jmi4oC6tpFZKNUIjr32LRWyBg6STOzy5NoAi9GRrvfzwdRew1dkA5n?=
 =?us-ascii?Q?iTyqcwZ64Mg138jrzI5dWu1sF4tFUjxrj1FlpRtJef3zHnfHG+02l1j8ivOj?=
 =?us-ascii?Q?tY8h3cwhxV8vjZlKVdJFruQv/6XqSjscbOJQBtIN9E4DDw0fvS2OcAlFu2iI?=
 =?us-ascii?Q?6ChGtDbnMK9bJFPO6/C4t1AIcPR1asAq3+NDlAVmQa9OPzxjvwqjdRQK5n/C?=
 =?us-ascii?Q?Q1WiZqSb/M4SSzHplIcEDJ1JDIUkwbzf4lskTHmi2mmfJwdV436WlTxORoml?=
 =?us-ascii?Q?mQ/97oPTyQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d67fba-ace8-408b-eda3-08df12f1ed78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:23:59.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v95CIdysPHLqvc/UvlP2bwwn5PlH5UzSwVRuMsPwBHoT40mkR0QZudOBuF5KA/gWdhgbai3XQo2udLAAfC44JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437

Hi Tejun,

On Mon, Sep 14, 2026 at 01:42:58PM -1000, Tejun Heo wrote:
> An idle CPU can be reserved and kicked without receiving a task. When it
> picks idle again, the builtin idle masks recover the reservation, but
> ops.update_idle() is not called. The BPF scheduler's own idle tracking can
> leave the CPU unavailable until another real idle transition. This is a hole
> in the notification interface: BPF schedulers cannot reliably recover unused
> idle reservations, which is required for cid-form schedulers to maintain
> their own idle tracking.
> 
> Fix this by notifying on idle-to-idle picks and making these notifications
> automatic for cid-form schedulers. Keep CPU-form schedulers opt-in because
> existing callbacks may restart idle accounting or repeat actions intended
> only for idle entry. The known cid-form users, scx_qmap in tools/sched_ext

But this would change the semantics of ops.update_idle() for cid-form
schedulers. A scheduler that maintains balanced busy/idle accounting may now
receive multiple idle=true notifications without an intervening idle=false
notification.

We discussed essentially the same behavior here:
https://lore.kernel.org/r/Zw5_FlXfbLXDLCPG@slm.duckdns.org

> and scx_nitosis in the scx repository, have idempotent update_idle() bodies.
> All sub-schedulers use the cid form, so this is a root property and can use
> a static key.
> 
> scx_root_enable_workfn() must initialize idle tracking from sch->ops, where
> the automatic cid flag has been set. The local ops pointer still refers to
> the caller-provided table. Using it would leave the static key disabled for
> cid-form schedulers that omit the flag.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

...

> ---
>  kernel/sched/ext/ext.c                        |  3 +-
>  kernel/sched/ext/idle.c                       | 60 +++++++++++--------
>  kernel/sched/ext/internal.h                   | 21 ++++++-
>  tools/sched_ext/include/scx/compat.h          |  2 +
>  .../sched_ext/include/scx/enum_defs.autogen.h |  1 +
>  .../sched_ext/include/scx/enums_abi.autogen.h |  3 +-
>  6 files changed, 60 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 83999203a63a..934605dfd950 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -7251,6 +7251,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
>  	 */
>  	if (cmd->is_cid_type) {
>  		sch->ops_cid = *cmd->ops_cid;
> +		sch->ops_cid.flags |= SCX_OPS_UPDATE_IDLE_TO_IDLE;
>  		sch->is_cid_type = true;
>  	} else {
>  		sch->ops = *cmd->ops;

The unused-reservation case can already be handled by restoring the cid's idle
state at the end of ops.dispatch() when no task was selected for dispatch. For
example, scx_cidland does this:
https://github.com/sched-ext/scx/blob/6c54f4f664bb8e9cc445c8333128b4ba17b93608/scheds/experimental/scx_cidland/src/bpf/main.bpf.c#L2960

That said, idle-to-idle notifications would simplify scx_cidland and allow the
special handling in ops.dispatch() to be removed. However, other schedulers may
rely on ops.update_idle() being called only for actual idle state transitions.

Would it make sense to leave SCX_OPS_UPDATE_IDLE_TO_IDLE opt-in for cid-form
schedulers too?

Thanks,
-Andrea
