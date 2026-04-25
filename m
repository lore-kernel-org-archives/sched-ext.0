Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551731B6D1A
	for <sched-ext@lists.linux.dev>; Sat, 25 Apr 2026 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777099877; cv=fail; b=WfSynQkPeSSQNkRG755kA9PwpwPOsPHnixRXnggYnFOthUIJzHygKmdFJBBRtbyByIfAAxAVcDl/BNUHif1S4izrJIRHnYrkIbuPfgb9Ee/9J+yFjVz1alCLXRwqk56FkMbcwSDlS3nYq5h+Y3BW+qKIyZtNO8DarL8GlCqWN+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777099877; c=relaxed/simple;
	bh=KXR/LVx+2OWLwQtdE82E3zZym0uTpK4lxuCvU9hmrzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYWwsaJH/KWMlvyr+alEY/FHhrTQLz7Hc3AMvs9q5PnXYnhc4aGLeWfmE6fsSecrhSW5oPO4bUnf1io0EyL1R+vsyWJdSTcUgvLGNsMsx3pIF7yUKSDt1MictSIxMPiidjObi9iXgjrst8zM59UfUZzdxv7Qwyov72WPVlXTmPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YgPI48IT; arc=fail smtp.client-ip=40.107.200.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YgPI48IT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQOFJpPKl0ldaSXJuosV4W5XpJt+9BF1uiTqZPMKEd/ZgfgOpQy5ThZ2yQGIbXm0maIQoWeUrx8sUJMgx+3TIIwp44OUx64p2FLnKsUV4jWR1nU5/oxUwxPYuk7EmrfpC8GMtn2gBVJBzNFCjA+ahfKmr5JfSsuGsVEjA7hsVxiqFCdmf1V6/BaDdSMa5eaok5MN4wMxupbIYP3b6ayVQEZAN5ZXYsby/uE2cAcG5usyR6dpPzFPtOVd1UhQWVc+kNmnfAElPbmeNPsR/VcrCGpv+ienqvrzN+C/FsEdYwN1YlVqRlFGuo4Y7Ch/WTcli1Z0M0ysQc+/EMHVMM4zvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUkKPKaCBRRBhsLc8wJvlMWTi45MgJzl2CAHz5HxSdI=;
 b=emyQqAy5FxZw9ILAEwffukw2GT42LkBTsdJ8fjvr0IIdD3OTPdW9VHhKxkcafBY3XzeXROuDVqFWjVJT5LnBEworzoBVaONWFTCWU6edii8O4dJAfQFe/w/SPop/+2DiMNgOWoFSiM3g3iQM2vcYLAabnWOu22ayjmE/Ll2fkmImH7PHckttkdsQDs827HLeD7THArFkPPt/CdevOjuc72uPSZp1U4JQ3lvYALdrJ603w/XqqFqi/uSyOXeoV2U5w+AWfEzPjJO6AS1uOp/lOIsnbHBznG9osQqE5f2weouegAPsUkJ7R/fp/gbOYBp71YV1mV0QQ4tCxcaJFdGZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUkKPKaCBRRBhsLc8wJvlMWTi45MgJzl2CAHz5HxSdI=;
 b=YgPI48IT1jgLnyGbTvlyexdax8XCGL0ynphXkPWzbk9qxUdFkjt5vHMMjNn2hJ5yHR7xugMj7sBbJmVYZPuDCK0rA6JQ2R2+qrEyGHghPPBthiuwEcB56pTc/Mn2hCGtjtNDX2ZKtSSwmuv5YyjxXZKPknBYsfyDafCnT+DfrRDnzcEo0rXiQHyPPf87m7ho+KMUNEYUx/0yW+7GdKVFO+paqnJOuUptPiFwrPhsj9olkhzCWQOe9caobJMWBnS6nsyLzd+vkr8h3/7uOPOBYY+gVk0njlC3k9kSvBfcI9MD8KoqLnKsmTZc7OV7DcivIwDM9we62+ZXx+VDsx7iGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sat, 25 Apr
 2026 06:51:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 06:51:12 +0000
Date: Sat, 25 Apr 2026 08:50:59 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>, Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>
Subject: Re: [PATCH v2 13/13] sched_ext: Refuse cross-task
 select_cpu_from_kfunc calls
Message-ID: <aexkU_cROm-NyTNE@gpd4>
References: <20260424204418.3809733-14-tj@kernel.org>
 <20260425001942.3987351-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425001942.3987351-1-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004E97.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::447) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: ab06132e-ebd1-4db5-b919-08dea297098f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	s4nVNushGlGxYA13KOIRRt+DrJAOQaA0whhMgoxqBqT7vymZC4TVUYOfVS83+TMbkhMOk1LUFFYcPnhu+P7uMlq3AYA0R9afVCJTZTIAH/6y1ga6U73JmEXaOqkjyHhnCBWnkfeq7lkKNF0Q5vmWx9DydMEd+cFJIEdBSJWrWiS3ji3FOZJOtXFeZ1J+JGCb22Oe75oZ1qZehu16L2EI58ae2DCaIhImatY7vYi6bLgjFn1z8y9hhBRiebcoIIsWgOEgIq6jqyoABuVy3Y3IokfpMCNWryiBT34ZJKCWUTOT/wwyFhpqrLOZLVjEGc6XZmYg+1alV9/scC0zXJ6yqCuHzleCBW7s/8E+GPzEsKIj1Qq/+HcKmPxHLA4ULCP72xn9GAq0K88witdFdPyMBy1a/og/0gr+1n2ee9S97Hvg3x3Na6gXX3PAf3P/BkoZrA8r4pYDCMO1kaDURRKXaI8b+x7KT+teDRMGY9AvI4guM+lTn/D2Pw9R2dtf14vNQh8k3D00skSttfV/t4n5wCellEN5iKH4gZzt99mZ/oQzTozRHTbd6jOO5V7nn4JxZQ3h96fHzS2RGgQ477sclJKRMP9i9pYiUs/ZwZtg1txm8M+uQU+QSsHXYXznpu6Qtj+b38EtXnZe7EL3yPfjU3kyYpB6FdpYqtLDYHESkcwk2RXKIV4OYcpkoCxz4E++b0lEaj8/rXpPDS0Ci/DtjKN7GYqlji9Sr3WA/w5FKhc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MwBTh5D5QLXCIN64exSiA1McBuB7Ns3waoo7NCju4LBIP89B5WBNv8hauwFU?=
 =?us-ascii?Q?knh+PVSPvBRYFEkUpNUmj3lO/51A34JalN0t5SINXeSeUtsvOolX0fRBgIoE?=
 =?us-ascii?Q?qJzZWAjFAM+dqmcNrkdaNAFiCJEfyla/qOnEzjNIB3v6gky0lUnh5lJfbo40?=
 =?us-ascii?Q?SKMDlbNko4TkB+2M3j0BlO7H1i549lBgCkXhNaskjv9jcIZ/2i4d+0enzfZj?=
 =?us-ascii?Q?BTuctcgYZL9Dx1frG1JsmhD8AGE6Laa/yqh9wxP2MguTLgzLqMASLNksIzIi?=
 =?us-ascii?Q?qSK6G4rHfgWxxxkSxcdgbVPr/kfFkbM3GqOwnwCVS+/i4QVpXbyb5gyO8C2y?=
 =?us-ascii?Q?KCn/LhQgriqzbHktJX7wNHm7ox5yjPq4PzcZHWFWdjv+sB4jRXTuEazxdC7p?=
 =?us-ascii?Q?uxjWQ/fKCg31bdZQaoMjXEHGEtW2sqMAjtu6cvzibmRWTnnDtIBg60mYhu3F?=
 =?us-ascii?Q?vfttkPIWIYWurbItudHbauMy47WBKJ7c7IHoEuKZ5AOJ2Fw8Qwm61azNKBSp?=
 =?us-ascii?Q?BWivvTTSAqq7kQD+xTCFUY/9EcYbx7wu936FJaTZa+ZtFzcjnyauPgWl2o3p?=
 =?us-ascii?Q?SIo+TRsmknJF5ZzVRg3gu0kkEN98w8auE/qWbYxGsABG3T12okH4I/mLB/Ac?=
 =?us-ascii?Q?HCXx9iEtawbhIlIFqdxegncA8VxPLFUbj6n2slbXvnaGgunKF6OEXpyDGprV?=
 =?us-ascii?Q?bXEhy3SyArTbIQHOqHBrQDePmO5xLTib4CIeZWn3kqTXK0BWsdTq+Vq6LZS4?=
 =?us-ascii?Q?sO2l6UkP4KfxmrAky72/EXnOAhdeCPBVqKhOYIx+y4vAeh/h4s/HtdXGACgW?=
 =?us-ascii?Q?rpHBPCpfFEZwHEy3lUvr+cyr56yTEi0iO/ibkzHbZW7WC0MGsP+r3f1wLGZq?=
 =?us-ascii?Q?pMSUCy+8qtPAZg/jA1KM6F6ghawFHmPExDS6N5859BoExlSs0RcG4WHrakkl?=
 =?us-ascii?Q?CD5oO2cLf+dWl6OVyi4++IteTrjxR//hJTLJiv7H1wmrZoA5sdYp1Oc5W8wt?=
 =?us-ascii?Q?E1pvW805HGRan0fhLFIapZn+F8BJ4wFm1bWfkVtmdhVVHbxmWxbk3G0/32vC?=
 =?us-ascii?Q?2ClNZcNcDD01M6R02ONDBKySA3SwyheTJLY1hYa7Q2lqZ4scKMOhxBiC0gFa?=
 =?us-ascii?Q?5w8aVKxb9y5bc4lD4VWR4KpR8cTiXfZKbxrB/vQSAuzGIXhfs6LWyQCQewkd?=
 =?us-ascii?Q?po4q1tCjNZT+mU6X1Cr0oQkkQ1oLG6fIRDxDOs3YU1JBpNYJ3jV85vVOoD0R?=
 =?us-ascii?Q?rkd7wXdwi+/wBlric9CsxaDPWzZ4yaHU5Br3o5LxBUljzyHQiHzMSfMO8Yhf?=
 =?us-ascii?Q?lPzoxPyavTNUpvcnqx277U2H1MPweCZW17deoEfiEVJJLDAsVsFkR/QW2mAE?=
 =?us-ascii?Q?oJ/WRYXwN8AOLhOtJZedlVL8Z7wYrsZK+8RJ5/k6TORZ0762cJgX0AYeC8ea?=
 =?us-ascii?Q?Za/EUiRUXVXO64dCP8NImv/Ou1vQ9axB7zGfCUvPrHAQgWJMAKt5hPrlFEmv?=
 =?us-ascii?Q?YXR83ttOlgF1aNSBoORFmGS4f10JdlrJoiuQYSG4h7awE01mDGgU1DqKhZwC?=
 =?us-ascii?Q?ST1CU3XXwpWvgKlSl0wdyM2jqx+4bspnxWcgRv8rJdurfCVOcQ9sxc6Wzrxl?=
 =?us-ascii?Q?eMUan7mZTspWnSfbns8OEyg07lBhUaSviStNG4W7Ud4j/64lOnbfiIKi++hM?=
 =?us-ascii?Q?PcQZFIVcA/z18qJUDBHo0TewU8kBqdnOvzh+FAFmezshjfBAedU2Gi20BPXJ?=
 =?us-ascii?Q?GJ7iYhLeHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab06132e-ebd1-4db5-b919-08dea297098f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 06:51:11.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZP93T9f1kNT1JtWdYCJXMTV/MD90iliXq91VkixJ2+vW2i8MoflD9G1CCAAC9ofmNYgh6BCtLBK4fhqvv7Gnwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354

Hi Tejun,

On Fri, Apr 24, 2026 at 02:19:42PM -1000, Tejun Heo wrote:
> select_cpu_from_kfunc() skipped pi_lock for @p when called from
> ops.select_cpu() or another rq-locked SCX op, assuming the held lock
> protects @p. scx_bpf_select_cpu_dfl() / __scx_bpf_select_cpu_and() accept an
> arbitrary KF_RCU task_struct, so a caller in e.g. ops.select_cpu(p1) or
> ops.enqueue(p1) can pass some other p2 - the held pi_lock / rq lock is p1's,
> not p2's - and reading p2->cpus_ptr / nr_cpus_allowed races with
> set_cpus_allowed_ptr() and migrate_disable_switch() on another CPU.
> 
> Abort the scheduler on cross-task calls in both branches: for
> ops.select_cpu() use scx_kf_arg_task_ok() to verify @p is the wake-up
> task recorded in current->scx.kf_tasks[] by SCX_CALL_OP_TASK_RET();
> for other rq-locked SCX ops compare task_rq(p) against scx_locked_rq().
> 
> v2: Per Andrea Righi: switch the in_select_cpu cross-task check from
> direct_dispatch_task comparison to scx_kf_arg_task_ok(). The former
> spuriously rejects when ops.select_cpu() calls scx_bpf_dsq_insert()
> first (mark_direct_dispatch() stamps direct_dispatch_task =
> ERR_PTR(-ESRCH)), then calls scx_bpf_select_cpu_*() on the same task.
> 
> Fixes: 0022b328504d ("sched_ext: Decouple kfunc unlocked-context check from kf_mask")
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Andrea Righi <arighi@nvidia.com>

Looks good!

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext_idle.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index c43d62d90e40..7468560a6d80 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -927,14 +927,24 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  	 * Accessing p->cpus_ptr / p->nr_cpus_allowed needs either @p's rq
>  	 * lock or @p's pi_lock. Three cases:
>  	 *
> -	 *  - inside ops.select_cpu(): try_to_wake_up() holds @p's pi_lock.
> +	 *  - inside ops.select_cpu(): try_to_wake_up() holds the wake-up
> +	 *    task's pi_lock; the wake-up task is recorded in kf_tasks[0]
> +	 *    by SCX_CALL_OP_TASK_RET().
>  	 *  - other rq-locked SCX op: scx_locked_rq() points at the held rq.
>  	 *  - truly unlocked (UNLOCKED ops, SYSCALL, non-SCX struct_ops):
>  	 *    nothing held, take pi_lock ourselves.
> +	 *
> +	 * In the first two cases, BPF schedulers may pass an arbitrary task
> +	 * that the held lock doesn't cover. Refuse those.
>  	 */
>  	if (this_rq()->scx.in_select_cpu) {
> +		if (!scx_kf_arg_task_ok(sch, p))
> +			return -EINVAL;
>  		lockdep_assert_held(&p->pi_lock);
> -	} else if (!scx_locked_rq()) {
> +	} else if (scx_locked_rq()) {
> +		if (task_rq(p) != scx_locked_rq())
> +			goto cross_task;
> +	} else {
>  		raw_spin_lock_irqsave(&p->pi_lock, irq_flags);
>  		we_locked = true;
>  	}
> @@ -960,6 +970,11 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  		raw_spin_unlock_irqrestore(&p->pi_lock, irq_flags);
>  
>  	return cpu;
> +
> +cross_task:
> +	scx_error(sch, "select_cpu kfunc called cross-task on %s[%d]",
> +		  p->comm, p->pid);
> +	return -EINVAL;
>  }
>  
>  /**
> -- 
> 2.53.0
> 
