Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28C248F57
	for <sched-ext@lists.linux.dev>; Fri, 24 Apr 2026 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777069165; cv=fail; b=tjuaxAnxeCmdUxfdAMoYwC8S7voV8P799vG0XCg/fG+8XYgLTDpEECJnLpYE6R6rvKfqrT1PrAWxIJLQM4O7fqXkvlid2ruGZWzHE7qTp/zUGyh3UMr8Zlx7HRNSUe1ospl9A9MijXZzYFuSockaIKljexKt/hSBFVXdelgIOmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777069165; c=relaxed/simple;
	bh=ZRqz9q42i05tGmYp+XHeNtoQn8Wg7sNw0v2YhxRr8yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sYmGaehBAjT50sa3r7j3B8r/Tn3h9UnUH539qjqcD12DAqfbtVd5+AJRrzpVPWvUbYURR4l0D8AWZzT2W8PXpMPTWIMlUChyaJ3IHELwcxQ7A6h9Smt9QiamNozWR8bJBOugem04Fo2/KrubxzmPFFTuwQnYmxh3kLLj18z/vcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dIk8HXFj; arc=fail smtp.client-ip=40.107.208.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dIk8HXFj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZuCtUNw135xJlC8gCpiJ28DoDNVUmFz0DZzry2KAtvAj29RMkpC5zTLmQ4qRj0UnCTOCPp4gUV3AilckQFATuJzotjG/aMdMBWz7gKIYaxt562jcqItiexR31caI5Hh1Sg1ag0HtpK4PnpLUVvZKKUbef2t9gwfIdxCmBSHk8sB1YNC6u00S660og+seWijTSavmrE4OUmokAhcpI1qZw9ktX3guMUVEq4yVtn4BZ1T+a5sLVkLym6P9zZ56JXYVuPiYpjhAmkCHvvuzIWgYEm7XRWxeEgSwlXporMolNC70yvBs30hXYWdoW3CtAJOgeQrUKh9mf68hsBFCPeF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJj89ORFbRWWRb5+ZPTgiYWDs3OUi6DWytIBIpnp1Jk=;
 b=LJROb04XJyKZpm0Zzh9YX0SEe/wIee5jENtYGmVWaExLeBnjL9wInoOwA47sMgKWGTlpGE/GwWVES1rmQ844XcLhx5hYcFE2Og58KxjLrYeNSTm7Qx0LzLZmgo/Ejp+h0jbQWG6SpaKDRGSVmoawyCdGV4rKuWS7MJRa9lJYVhnSGgQdXod8w96/oSefqjBvc7AYlsqETyoXucYJaFu9S4N5wp7+on2394qz947MscznU/+Ee3nZCqQ/1joEgY6faYx+8c4X7v5kb1KaFp2QRnAdBGgxWmZZzTca3W1dlqw3cqdg3NxuikcGVNnb27lFlxiAPCbJKTA1G1TUAKY+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJj89ORFbRWWRb5+ZPTgiYWDs3OUi6DWytIBIpnp1Jk=;
 b=dIk8HXFju2jwEcvO95K0A+88rVvAscaoiIbR/jFS7GV+h+26q6TxHB8qAySlMqQo0zmrbULftqdzbjnjt0bjN5gNomp7NhASKjb+ux3Gjpu6R+L6ALqlsG7fOWB80nFt6n7CddNwSZZ/p79ndxxT/stf3Hp27Nfgaonrb0Puks+DI5fFSYFiWQ0PQIzejvBgEf69DBLJ4OqM4RxGgl9fxg09DGtnhqmCbS1m9a/xT9fHTRLPjMMFhSR5zmo/JPcGYSbBGPgN6w49HZ73f0ZdrJzeiMBFqhl/SwpflvHmlxzd28LggOhFJylabhkWW3UKOiYGWH45V/bIU+N/MYEYVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 22:19:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 22:19:19 +0000
Date: Sat, 25 Apr 2026 00:19:09 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, emil@etsalapatis.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Defer
 scx_hardlockup() out of NMI
Message-ID: <aevsXVY6tmmimonU@gpd4>
References: <e78c625bf7ef51fef0e564d9c25482aa@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78c625bf7ef51fef0e564d9c25482aa@kernel.org>
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c8cfb9-9766-4448-1e73-08dea24f8702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5kXFdfkoZmrE0XSRcbzkZ4En2E8NTjh9fnGpn1yBcDAhOuhFY1RDkrDD8IZKm8/s0lFvPVS8uW80TcJ5Be5rqdk4rKMPICUTiJf4TeUY5kG8r/ILnIf6CWD1s+g4zEObUu/0SgCzYRwv+N/SgnnTp+4isUz/GZ56TsiecWoVVlpsuLlJYqoa6WxOGHiNlPfUNqhMuLAmpA+YK/8ac2qbp5L6gDwlWxHQtqg8Bp8oeQtkRJADOvWClBVRMlj7lpwndzRPqiNdybbvVkOIake0lk52NAmYJ38N/B7SOSa8i34kZpu0nLNtEZPiOSJ3v1nDVv4xdYJH3VAD1A3jlj2dwjdcO8BFURPoDEhrilt+fmxBfaPuxkOb3i8KFtW8BtFDJqG/hb0LDKgLxRqHoYFjNNhVd4JdpLRFgRxIOu+IwtxYPPVpArQj1CO5IflUxbTYetKQqPvKEuz17ZBlfP1vm96ogAU0SZqYAWO2MX6RxpZmRJAq/i6pJtj5MZ1oBAXEq1vWzdxM3WXxeP5w16Uw+hEYFQJHh3nv/YzrKk8N6aXYhUnkjr5/d1aPWuOO++U8Dkkd0Q4WV1vPOOsrK9XhVQ8/CKRwVLbuqH/FY3Rnl7qR3Rwyjg5GxUdojN0VoFYf+te/3hpBP/nMBflBsxW3BBdzdYVlRUykirJzR6JuR/JpiZvtTAhudbi4rvpGOcCmZYk8PdW94A2Y76RyN/hyhzAXCgkNnamjQZKbiOrIYsw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4nMkvErVtwANKcnsAPWmAaJ0Ir0zVTb9oJoWMitZzQxPa0iGAQvnyvt1ugA1?=
 =?us-ascii?Q?ic7h5uA8IqIzewUD2ZtS2jdzeRSlUtkUNoa9nxBpzWV2+tqnbvm5OmMdB03u?=
 =?us-ascii?Q?32jRhb0FkbphNexYk6u88/9pG41VD8RDbvxZlrip9YtlcEbtgF+JJmAIikBR?=
 =?us-ascii?Q?7pM2QDEKsE269iXeWaEr6jeM1la1+eOTncCiI5vECt6Ea3Xv4NaxwFlLefCB?=
 =?us-ascii?Q?pwm/vwIBJKye3O1KskBlrjbbsVmYAndTsd/WGpeN1XY/vKijInimbtB0IKgI?=
 =?us-ascii?Q?ewpKAUim38hjHgp6EFDdit0cWcb3E8vENpshW97O5SvdZmnDiZn3lplmpaOF?=
 =?us-ascii?Q?vmUKqEmQhKA/ciHhsRXGCPvm3S7m84Wii8pPdZKP0oOlS5NqjSxaXCEYRlfu?=
 =?us-ascii?Q?H73cq/roKrcIneu1uyuaBwcuMs+r3Nw3mOVNrbjaS/zERo58bm4PyilZc9ub?=
 =?us-ascii?Q?i1BzEO8Pw14Qst6rpUjZHtgYzbLph6+YVr33eTg1XG1atRctjaM4dWscg4A9?=
 =?us-ascii?Q?wdfzRniPSy3RnZw/aHz0gLGijXO7gnty3GkZIRfTpDUGb2SyahrXYO6pfFYK?=
 =?us-ascii?Q?x/CmXWSv/FEhzoctRkQugUf7aEH1NKj6dMgeyPvi8zCBZ3HGsW58YavOqHR7?=
 =?us-ascii?Q?IDsAGrNuUM9Id8HuIvGqt57xKZomS8pev88VZ6Cvq0SZ+bigHpXVvHyNz4bX?=
 =?us-ascii?Q?A6zVgXkTMM1JUZjJMOpTGXkMdOCHHNAX08nabypINyjtXBsUaYV55a1StsJc?=
 =?us-ascii?Q?yiokJwYFgGofJFg98Z5xHX5doS+8WmyfZOaegtZg9wiDiRK56LQhR4nfKxub?=
 =?us-ascii?Q?mpTUGG0Z3xlAYg2/ao8ZsfcK/qAcFj398er40vlkje34yvDEIVCkM3stfyEj?=
 =?us-ascii?Q?losOGHU1Xl2B4yIVlZfiOiLWIJjYf/YdA3zFIOzInwDT48P578ugVZzaFPCL?=
 =?us-ascii?Q?TiykhAEpwQbixIevUd0puO1YE9R4TtS/uAk36Jb+eefwLk7ioWhzCB429hpM?=
 =?us-ascii?Q?MZdfsWpKyL7xzOPlQvSN+0sRcOGhUyFVtspjAbkVBHrmoSvzGdSt2ZhXLcLX?=
 =?us-ascii?Q?Na2/M75mz4Hhc0Lo82MGkdMhTeugucA8g9GqIy84vpN9VGViFc4YDCo48Jps?=
 =?us-ascii?Q?eVREKfC5fBfcbHT4iuaeTXs6eHfxFHHt8qjISs7+1pAZgp4CJbVZzI8x6XzN?=
 =?us-ascii?Q?MZTAx+p21mGw74b7uXQA4cYm7PBYc615cClFpMf871bQWcgwZoStm1AV/2Oa?=
 =?us-ascii?Q?XUkrQoRgDIPVEqDmlmWOKj6ZbAh38Qn4Ju9oUTYZ+gInc/kw6pIpE9m7SRf7?=
 =?us-ascii?Q?TbidY2Yq6zv3Omp0RDQwk/BH7ZcIsfX3TFeBRujYvgZ9oZ4+6W5BX59QayOG?=
 =?us-ascii?Q?XDQZnQTRSy4tDphhfwka0213K+SkQzoKRw8rSFzfY/GFTfPg8n57ZsFEEPgx?=
 =?us-ascii?Q?rCpjXcmvATKoUrWys9/TYt3tkgna9yMhoRngaqG+4rh8TYeXOONcOBNzlMBr?=
 =?us-ascii?Q?fE7oajR2fDohQzPx11UGErkOfpdQBcJSChz95ORSDW46E/q5jPnYkW9AeHBX?=
 =?us-ascii?Q?b6RCvoPrGqS73h+p6khSRwY+cZ5pQNgLPdfLCQK6B5Ip6kYBpK4xkt1F+hWs?=
 =?us-ascii?Q?Z9k00l5B5qjzf5Nq6Ww2uVUSXEmOmBTMw+qTt3LabVMPa+nC8Kt1nhhOvXSC?=
 =?us-ascii?Q?yvJ7+53zxB9RoWM7UXrEfyjeV6i9NL8f7bDS+01/8xJvUoPAS8LeXkU2fcKt?=
 =?us-ascii?Q?ylIm+SEeQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c8cfb9-9766-4448-1e73-08dea24f8702
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:19:19.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+wqeCLD/L+nDuzSkJD/kn4WCp/TyUmbJcJ0ZDrX2vT9pkFJmW9A7ha3i5mOKLugTOaZ777wVrJ+LDurqs7gKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511

On Fri, Apr 24, 2026 at 10:14:32AM -1000, Tejun Heo wrote:
> scx_hardlockup() runs from NMI and eventually calls scx_claim_exit(),
> which takes scx_sched_lock. scx_sched_lock isn't NMI-safe and grabbing
> it from NMI context can lead to deadlocks.
> 
> The hardlockup handler is best-effort recovery and the disable path it
> triggers runs off of irq_work anyway. Move the handle_lockup() call into
> an irq_work so it runs in IRQ context.
> 
> Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
> Cc: stable@vger.kernel.org # v7.1+

Apart from the Cc, as you mentioned. :)

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c |   33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5142,6 +5142,25 @@ void scx_softlockup(u32 dur_s)
>  			smp_processor_id(), dur_s);
>  }
> 
> +/*
> + * scx_hardlockup() runs from NMI and eventually calls scx_claim_exit(),
> + * which takes scx_sched_lock. scx_sched_lock isn't NMI-safe and grabbing
> + * it from NMI context can lead to deadlocks. Defer via irq_work; the
> + * disable path runs off irq_work anyway.
> + */
> +static atomic_t scx_hardlockup_cpu = ATOMIC_INIT(-1);
> +
> +static void scx_hardlockup_irq_workfn(struct irq_work *work)
> +{
> +	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
> +
> +	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
> +		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
> +				cpu);
> +}
> +
> +static DEFINE_IRQ_WORK(scx_hardlockup_irq_work, scx_hardlockup_irq_workfn);
> +
>  /**
>   * scx_hardlockup - sched_ext hardlockup handler
>   *
> @@ -5150,17 +5169,19 @@ void scx_softlockup(u32 dur_s)
>   * Try kicking out the current scheduler in an attempt to recover the system to
>   * a good state before taking more drastic actions.
>   *
> - * Returns %true if sched_ext is enabled and abort was initiated, which may
> - * resolve the reported hardlockup. %false if sched_ext is not enabled or
> - * someone else already initiated abort.
> + * Queues an irq_work; the handle_lockup() call happens in IRQ context (see
> + * scx_hardlockup_irq_workfn).
> + *
> + * Returns %true if sched_ext is enabled and the work was queued, %false
> + * otherwise.
>   */
>  bool scx_hardlockup(int cpu)
>  {
> -	if (!handle_lockup("hard lockup - CPU %d", cpu))
> +	if (!rcu_access_pointer(scx_root))
>  		return false;
> 
> -	printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
> -			cpu);
> +	atomic_cmpxchg(&scx_hardlockup_cpu, -1, cpu);
> +	irq_work_queue(&scx_hardlockup_irq_work);
>  	return true;
>  }
> 
