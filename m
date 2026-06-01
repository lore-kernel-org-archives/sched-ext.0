Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAACE3803D3
	for <sched-ext@lists.linux.dev>; Mon,  1 Jun 2026 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780345205; cv=fail; b=MjOsKOlmFu9Cx3rANFz3jgfPWjQKiZcpHujDaEJw8Mp27t2a9XaHjE5YndMSO6ay8z6Z+ZkV0jW5DoxOoNuKZwx7Cw/KXl4JtjuOp94gAiyLY6XNTHT2JFgjfH+6aREfWHNP3qr7mOqMcOGDDdCpY1NqaKUl8UWJ+wuJrzs6TR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780345205; c=relaxed/simple;
	bh=KsGKTscJc+mut+vKog+5sKrvkEFGUvy+cIJ19VfZZpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gyk/x3FD6oeeRuDAvLpMAdC1UyeE8GrNjk606Dc8YC7D6fXNlkCgJR+0E4rag0bsLQnshfav5jP09sP40dPNeQ3kI1YHgKxnf+TB46L4btG3FdeBHqQQhV2nFeF2LZJIwSrOmvEmK0Cs2BzmIZ97jsPvNymWPkhMa+EYpYo9DkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pgfmNtvu; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pgfmNtvu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSCqCDOpTKXh/Qmf5EFFqRiWjRYDiW6W+qJTANdh4wLtBrGTKzcisv3oFWbZFIdnHVaB+duEV8v5ReyuHipBHvSwtgtDg1t1csce16XvaXY6sQukfMl3NWaU8WKwspR6qO8kkNIS8U8sPK9Y22rKPgg6ACdzo+kF9vmKuJIdTBxFEpotQh91K9uOzZnmW2woHXa2DDQevR4sztiEqwpwSZZBnCBSmhVmCmfpJc8gvWMmPIyqz3BTM9uVWTPA62ACpFF4UeXXm55TJT4tqqVkIKeMCtVS0KbLgw5T7A9tAKdfh6B8tXioUYegAItW9KSq2QbbHjyg7R57494jcapLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RefJGGckAM5a0bTvwIAfABUgF+LYlULhNmQqjsg0/OY=;
 b=WwXZh61whXk5aHY2263CEXs9N1Rkg0wZDEKzpAKINs5LsfWzJ048DkAtrG6Y79eNbNUeLz9fGv8h9uplM6exu7llKfIhqBzlJEwIVQgkPO14XxEA2m4Xe5h53zPiQKocVmct8snNPEouvlJHzLkxjn8o+Lx8GW81TfHB3TOGiLBzH/GXldI8KGXv7U8QyGSELGFVeICHJVbNqUyuPTw/9btiJDckau17auAfcfQ9miJhcJ3O/2PAZdqHv/gSh4+kobQIC+vzpJf6uxxpjuzOZ40Vurqwy1rkE7EtgIokWYA8q+0XQtweGw8lT5WOwh3CR0Hlr823gC3AIrBRZ733nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RefJGGckAM5a0bTvwIAfABUgF+LYlULhNmQqjsg0/OY=;
 b=pgfmNtvuCg0RVDpFuus8Yb7bUqIoD3NtSKUj1L2bekAd4OkoQNLjz3g46aNhx06HYRkdfIYjFcK72kWJrp1Rjz4RJ2VncIYfDW9HG/iF53dAC+ci/v0S5N7Dsp5Um3glOruBmh9F3Zpd+LSO0ZWK9b0sbXMAVBjbHjCORbubWWibG7zbN4pMBKHxv9aYPqyKpIcz7+S+77pGppemUR8Z5dElayeSEO68NIdgh6S+gS5qsGA9M9X72IOjyJP4GbiFw3zbFMzsaIXU51Idu2kL5SHe2VskxVaS+CZPu12Ri8243JeRRUQCx/30Wc1oAty2Z3fsa8uIbrd1acgqTl1O/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 20:19:58 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 20:19:57 +0000
Date: Mon, 1 Jun 2026 22:19:48 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Matt Fleming <mfleming@cloudflare.com>, kernel-team@cloudflare.com
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Don't warn on NULL
 cgrp_moving_from in scx_cgroup_move_task()
Message-ID: <ah3pZLaGXTOuMbv7@gpd4>
References: <20260601124156.2205704-1-mfleming@cloudflare.com>
 <fd46c41cbae0ea3194b9d8c1c8efcefc@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd46c41cbae0ea3194b9d8c1c8efcefc@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B88.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::406) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS2PR12MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: b08ddaf4-63d7-44b5-7a27-08dec01b2637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099006|6133799003|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iKngiZEIWbzNgQIYFqzfAYduh8OtlwON67hDpQUCPI6d1lw4bidZisAsGYKSMiP9pJRxiFc4HHdUlELQUMvdWPKO5/uViS25G/c/J39YNi6gBY72p+mU0gQyAho3R+Q/bPXjPIJ1cw+R9HrWcIoMINjodu5kzj/XSGvV10cXPlcWXXXZ5UWfVR63mRourkU4/37v7f9O/V/44b8R1QxOa/fpVJOJCjOrIpUklrPthUbGElVPm/MweL1NgwiEeZsABCHzUYZL3K/ADUER1upLqzHq1BHEhFBkXeWKuUyievUHhVzoOIF/VYbWmWdD3gZi65K+nwFsHY8JzKlkVCkAmE5XkqCSUgSsGFvgKLzs+/x6Y5P/AIRxeI5Ph59FoMvRslDY0mHe5X5s0OS3sOt3/nYxOkxojEVcxe1MvNNUXiD47ErX5kvkrWiwNz9ajqrwEukud1XRL/LWLtQcUSMSvNeUqxmZpAbQtkEn/mXjqakdvQ6m+fWHEuBppuPx+aXdLQhjN2RHKzcRFCRkfYzCnYRc9hQ0rcqNqW9WNyWIQcWpgnF1VrYZlC+OP+9eKxORE/c1nq4kxZz0OqQAxRDqPZvp6EqulIaq2fLbbGIEK1ytbgzLdYxoORiV8OzTNxPkL9lkyTHRh1DVXC2NH/0WJtmVMhvzDq3//vcYrlH+dDbhPTXB0jrGiusivdjSx8q3+UnU/RoYdB6e0TiJXrxI/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099006)(6133799003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HXhOIk/QLKyaoIvgLsGVBBTbDcx0DLp/6DbxdiFLOxdlTwJbGpWLMOk2K7wy?=
 =?us-ascii?Q?uiSZR12xCdSVE6YW/WI+8uY8CxfXqPHe5h3bqs7tQFwiq43FNDyHczlD+Q5k?=
 =?us-ascii?Q?c6houp37T8ItvAQDP00xPUuGuCFFCs2g0FpUBuDsLRLWuYP9RquDy90EMG3V?=
 =?us-ascii?Q?GspP0VM8k3UEu0jXOQhJvUrrn12ROGmLCUHmptlzgFNHBt89iLF1Z8O+V33X?=
 =?us-ascii?Q?xdWavyoM5/a/ePkqV3QkcpF9YZ4DgVjU6IJhIKtHiepIVmDgGYptWGh6ofVO?=
 =?us-ascii?Q?oyhDcVTpsdyD1OFBfHP+VHSGoj2lCRhZuRma4xMfqE6i38JdhzX9ZIu9Llnc?=
 =?us-ascii?Q?4MrPKqcxaeQJUS8PKJVVBgHlKq1Lum0Es9VN32gLWN+9H21+aqmZ9ejTrGEY?=
 =?us-ascii?Q?/HuO9ClgKkCdb4tIr91moqo+QuEyqSYY0J2i7rC4r5AEtZWRdCBu8qqhtM2N?=
 =?us-ascii?Q?nRk2X5ofDRK+W2RAEwhT2+EGVclAoZVQLgrHFPTFkw5HkDAh0frmR2DmJ6Q1?=
 =?us-ascii?Q?x0+4qvX0XcsOLS0Sy8nrIeP8PJkHxWHdsMxFjXKFRqI1CjdeNm3s7oU+71+E?=
 =?us-ascii?Q?EJ6XYpg88JxGpDeWsRVsLs/thl0OUlawUavIbjPrUKOv08yyeRsNbShqLwRl?=
 =?us-ascii?Q?XEQEUOZfIRblACt4AYipoUWkCPfALGA/YQi0YNMD2e4/60FqTG2k3r5goMIK?=
 =?us-ascii?Q?0ayJDgsGDUDPUGI+SnvPHOYqChqFheXGj62KIKAz6DeQQpkUVDzsM0lvq9I1?=
 =?us-ascii?Q?yi+Weqvt6vYJDR1uQKB/DlgKou//bmvxpxmzXoS+rA2m0XxgfyySE1moFWUi?=
 =?us-ascii?Q?zqRlV73/LOXDQ/1FBmiAYy/Nxktc+BrWmu1e3h37006bWCtFCzi/AujP207R?=
 =?us-ascii?Q?0MWkNWi8ljO1qVi/ew75QJLzHuw/l1jfboVLUbYe6UuafBlYWxxeJwN1118N?=
 =?us-ascii?Q?yyPmR8yxh/SI2DazMbmubZ2F4/YGdcmx4N/Cx0FOyKwUr6U2u8gtplAt4CUk?=
 =?us-ascii?Q?dTYnwrHAG2o2+RQPxQAs2k9D142mqNfn+REhxqXWNjfLWTBeBkvOvFbNjNfv?=
 =?us-ascii?Q?ufeIaeaUNP20Zgv1fjYtfFM0fXNP3DCm+Uety6K4YNKV/kNgsCHnC+Ww1O/3?=
 =?us-ascii?Q?EEwQaiQL8swylZGfyxgKqPYvJqYkLVvyDdqJ0a/pMt+d5/x5rQqmOTeMwLtw?=
 =?us-ascii?Q?M4wEfqgspZWnpFUiGK0AjfROBd6cN4eLj51opRIuTj0apdel6OUS3OEi8ouk?=
 =?us-ascii?Q?Up2h96lK9yLEB3Se9fbNcs31e6na7bXRheQL0oyS2ub93uWmgOeEC9M7IXAn?=
 =?us-ascii?Q?mhbP4wiD/9TIxKyWIGcYdHSfLZkvqK5rVrEow/mXvzpz4NGWXb4US9hijKOH?=
 =?us-ascii?Q?B+UPJV06B1g4EQn/qP9sgmRMJCF2zlraMDhy+XmrqnKIjIbkuyrMuYc9CxaH?=
 =?us-ascii?Q?NUUpKwg01tDqP/9lSmYw7TEKL1HmmREVYdpGlFooYUcF0k3pv18xJ/KPBcmQ?=
 =?us-ascii?Q?zpbwCMnwvYCZVB5BHkztOJun0z4fXK8wFTBU7AFBwWGmxHchrijv9nRJOJLo?=
 =?us-ascii?Q?OU7EwSr48Aq7FnBDO5mAYGXFeoUH5HyBWNH2xTIQErFUPJborDTLbOavPhYW?=
 =?us-ascii?Q?GBgebkp9qapBGFkRJ8+0kuwzfgCAu2oUsyi6kNpoVkFN1AZ5GFDJlzhLR/gl?=
 =?us-ascii?Q?quQPz/2+r7sXoY7ab3gIHh5dNTizmI9hVH3GEkJeZCOEoss/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08ddaf4-63d7-44b5-7a27-08dec01b2637
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:19:57.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5OqVXnD02x6Qn/3/IxleL3bRUpuA350j4irhJooi5o19OswHOfPamcs6ytkomYP140XBJhEeKTtJZ4kyvL9PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9749

Hello,

On Mon, Jun 01, 2026 at 09:22:37AM -1000, Tejun Heo wrote:
> A WARN fires when systemd's user manager writes "+cpu +memory +pids" to
> its own subtree_control while a sched_ext scheduler is loaded:
> 
>   WARNING: at kernel/sched/ext.c:3227 scx_cgroup_move_task+0xa8/0xb0
>    scx_cgroup_move_task+0xa8/0xb0
>    sched_move_task+0x134/0x290
>    cpu_cgroup_attach+0x39/0x70
>    cgroup_migrate_execute+0x37d/0x450
>    cgroup_update_dfl_csses+0x1e3/0x270
>    cgroup_subtree_control_write+0x3e7/0x440
> 
> scx_cgroup_can_attach() arms cgrp_moving_from only when a task's cpu
> cgroup changes. It can still be NULL when scx_cgroup_move_task() runs,
> through this sequence:
> 
>   Step                               Result
>   ---------------------------------  ----------------------------------
>   1. cpu enabled on cgroup G         cpu css = A
>   2. cpu toggled off then on for G   A killed, B created (same cgroup)
>   3. an exiting task keeps A alive   migration skips it, A now stale
>   4. +memory migrates G              stale A vs current B pulls cpu in
>   5. cpu attach runs for all tasks   hits a live, cpu-unchanged task
>   6. scx_cgroup_move_task() on it    cgrp_moving_from NULL -> WARN
> 
> The mismatch is that scx_cgroup_can_attach() keys on cgroup identity
> while migration drives the move on css identity, so a NULL cgrp_moving_from
> here is a legitimate css-only migration, not a missing prep.
> 
> The call is already gated on cgrp_moving_from, so just drop the warning.
> ops.cgroup_prep_move() and ops.cgroup_move() stay paired.
> 
> Fixes: 819513666966 ("sched_ext: Add cgroup support")
> Cc: stable@vger.kernel.org # v6.12+
> Reported-by: Matt Fleming <mfleming@cloudflare.com>
> Closes: https://lore.kernel.org/all/20260601124156.2205704-1-mfleming@cloudflare.com/
> Signed-off-by: Tejun Heo <tj@kernel.org>

Makes sense to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 012ca8b..a1f7698 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4293,11 +4293,13 @@ void scx_cgroup_move_task(struct task_struct *p)
>  		return;
>  
>  	/*
> -	 * @p must have ops.cgroup_prep_move() called on it and thus
> -	 * cgrp_moving_from set.
> +	 * scx_cgroup_can_attach() sets cgrp_moving_from only when the task's
> +	 * cgroup changes. Migration keys off css rather than cgroup identity,
> +	 * so it can hand an unchanged-cgroup task here with cgrp_moving_from
> +	 * NULL. Nothing to report to the BPF scheduler then, so skip it and
> +	 * keep prep_move and move paired.
>  	 */
> -	if (SCX_HAS_OP(sch, cgroup_move) &&
> -	    !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
> +	if (SCX_HAS_OP(sch, cgroup_move) && p->scx.cgrp_moving_from)
>  		SCX_CALL_OP_TASK(sch, cgroup_move, task_rq(p),
>  				 p, p->scx.cgrp_moving_from,
>  				 tg_cgrp(task_group(p)));
