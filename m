Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7AD3921DF
	for <sched-ext@lists.linux.dev>; Thu,  2 Apr 2026 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123164; cv=fail; b=Dra2nfSiC1m0xyQIgurSoIipc4P38gU2c2obrkCe4Z7/Thvh4avj4EV/QAxnnZEHx4Ec3EGhmKZmbFSvj/wjOh6Nng8do+UO1ute13ZOLzB/+MFaNh6RBnbw9q0+i3VyFaQrqox8eKS4X/O5Vt+tJeN/IHngAMeUL7t8T/loUZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123164; c=relaxed/simple;
	bh=EvifLNESJ84W1r0C7zEQah1vEYWXPqvYBrHHiU9W4aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DNKFZTU+Ialt2Vpc3f+lDXEomzSp6RzjY7B6uKJ1r0zIP7Sv4llDUvqoLLmfNLKksTphr29BQb6WC7q9INhz5Y67eWl09EzfvbTcuHESvPfB1po2dTFrFQ6Ym69Aq5rI85prjspIXtO1X2j6H6678iWbKifG6ye8tVnkjc3v9ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TVoAoM6g; arc=fail smtp.client-ip=52.101.53.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TVoAoM6g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9lkdGDD4mrwsrzIQSBrFQYySLSKphW8xdlwZis/vTL9mXnSEWpRG5gzheozu8o6LCuEUf9lF5pPVTKnCHglGe2KWGTAMQdWNufQgyx9CSkJINqO0LCCVZWroUIBGH6eM6/UODiXnTBX1uZGVnAj6mg2LPyUc9aFEjuch84oPZ/mO/ljdPP23pEKgTLPK2FUEdEDx6jRw68RR3j1UkojaeafGc/WpIlye6soVPsLb1FfC0bP/FVZmyjo0YEqDOnVacB/xza5rNK8RCEAm7qEssvcmxecbmcA0oXp4BJtbiOYtJtyvWTftfx85B/9w58ZNzbiOvExbpnyR/ksyNdODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FkCNww1TeoAsrABV9IxG/PMGf+OnEHfCCo2L/pNfsk=;
 b=bOY1N7xw6+g8e1urXk2UgQTQTgw8MzUZrf6D+8XB1/FJEVAlIh9K/CmkbWZDaUvUSmGgfqL4bSDerzPpeLGuTXNMBQJrGnS7GDXO3gdCZPGUjJFtMkmEJeeTzaLP3mbtK4KJ141nA7JkksNOAADW0MVLVL0nCdpaZU+4MCZ7obv7WG/i7yAkzn651eWXVL7Uu53fkRL7hKeaskmH8kIKb3ZGAOSKt8ZccgzhPgMKkKq0EmF9H5oV+eMUz+l95mboXdVYHMoHsAK86ypgyPCSPZObQy/1B1QCq4Wf5Ft7uepiv+Zvpb8SpRgB3mpdGbqQJqD96CUAz4sUhFjA3BQo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FkCNww1TeoAsrABV9IxG/PMGf+OnEHfCCo2L/pNfsk=;
 b=TVoAoM6glAlIiXS3HpcsAS8Wx+ErK8Vut6mIQKzl5JJto9BqIm4CtGTP6k71Lpo8dFiJEGOWx1RoG8vsSyLi7aSOItdcm4ZLShzcOKoU9T59g5QQqwTUxjIjIdAC8LL0YLynGmSGz0pmdIDrzJepbPH2zRP+FuXQA0czgQ/GSf/9LVkbiTHHJjch/TIOGn/OjHnZ1ZIK9UfU3wHtGLxD2JfCZv3bsF02+zD+rpb4D2wetRyCFHk55x5Olxzz/9FcGsvzXWZvIRw3Z2WL8Sp/nuzlb4MplEHOB25QYXpaMgrnDaWS5rTJVxIo33QfGSQ7MxvnlTH6g347t83jrCA61A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 09:45:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 09:45:53 +0000
Date: Thu, 2 Apr 2026 11:45:38 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix is_bpf_migration_disabled() false
 negative on non-PREEMPT_RCU
Message-ID: <ac46wjXIGgnMT_1p@gpd4>
References: <20260402023150.660967-1-changwoo@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402023150.660967-1-changwoo@igalia.com>
X-ClientProxiedBy: ZR0P278CA0128.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::7) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: eff35746-b408-46b4-cbff-08de909ca0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wDZmuBLS+zYkMP++H43PHwMR6BnJvHcwem3MZuocBofnGieDEmfV2aqUGV90Atv0jNG1f+/ZQ9zVClE+YiMg4J0NSIJ7ZI8P9d6/FPbpK8ifAyvgsyg/JkSYdUL1o1TRn9FlnsoP9px0N84m2bD4TevUzr+eCQdloBP7ysgnwyW1TID6KIMq2VS0uPReU9EGT5WKA0OGKGML5E1TjfQTlo6hHLaDm1Ow7lOqZ4AnvMyfDAji2hMFbNRsLi81DJMZ57QsMwQx/ZDzPjwhhhdRCamPqAvpEJIPllHDvyJC5C181hczhzzQD8fHMy7kdYNL0p2eRqEWzrgrgkHAxfIwc1Nxfpysa8pq7IW4cHEepr1FtrDAw+MR62CXOhkyRcIGCnuDuPjys13mFg0C+kahB2oVb7B9dcaDGOPtCDNlxU/A4a7M8yGVsAKMW8XjrgOiAa6tbc2+KRZg+vTPzo1c1NcV+ON+qnlSi9z0MA0P0wkIQmDdYfZWZL4S7f3lTSjPCZ87VPbHUvLleDGaCfWGm8pAud438t/71DPAqOA0q2VCgtOExm36wXCiZVIOOlrUEybUi99WOmT51FZlW+xwwV+nUkLJ+fjnzL8apAU5s6PgJ6xoG7EJamPLxOwYjFBSOo1/C9aMoNE8d2Rks4AiOb22R+QDG22zV6g6Cizz1eRdV7hoWMSJk9cYjyRPW4jVnrkcGBzlF7UTwWBYUbOfc3z5t1TlISCJXft9gk23iSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SKqBdNbdLJMHmNhGNJmZivml81IBvA91296z1cWLEPWL3y39YG8yI63wd/AP?=
 =?us-ascii?Q?be6Rr2yjUPIdzGZUs+1BsGsWGdipM7c7E5RsXktdCa91/nIpyAtFaPXNuRfd?=
 =?us-ascii?Q?5NFtIuldob9yyeSr/T6BLU/l9ZK4Lv2ESjvGAt288JCBwl/2HpLt10OGJC4P?=
 =?us-ascii?Q?dlE55iBA3jxkwr4qQKjy1pWmESJmJogxjy4QF0U9ALE21zmXBKQ2IBaavryr?=
 =?us-ascii?Q?CgQlbIb6BErgwG1fYb1rA+Z2IXVUv0uTds0Z2ax2DX+elOfTpFWwRLVuFB2Q?=
 =?us-ascii?Q?lnpZ9bs3yytxCVgoka8A8rNhfCUGuQDaLaPMyRkWxkD5DqEMWgTHseZjiN7A?=
 =?us-ascii?Q?B9haBPKMmAbVCaollGDakh1WasjRIZjGMAemoRsQdFDzrW+/h4898hHSnHZh?=
 =?us-ascii?Q?Bd46EoBTNNJYvIkPBGoEfddT3Rv2D8vKNZ8C+6PvBoFlz3RQ/Jr0GC2nQ50s?=
 =?us-ascii?Q?BQGxnSZOcdCXiGh3KIbiZAFnppmS4lgAkQN91PfiTVSjx6EMFq+iHmx2183x?=
 =?us-ascii?Q?7K7ZEgo2gJgHuHecCBCt8yobxwpFA0Clj9XYDHq33YA59zF5skkCBkxLNM0S?=
 =?us-ascii?Q?mLOnJ2pw9EYvleT9iym+Jwl8z/yUM7vQDaYIMZeB9yiUuh0HL+f+f8zAW7ke?=
 =?us-ascii?Q?j04RNR00puf7tLXuM4QawGhxlzwoeyRwG9IO3bzAzC5eV5JU+GaFK638Unc/?=
 =?us-ascii?Q?PiNfGntxSMAMNMg6wUouVhZxL9mfOa6jaRnZHKjOeS6+Jhbzeilr0v9S5anS?=
 =?us-ascii?Q?gEGcG1e6i/W0+EsqMLm9sPu0tSmnz364K4LRQrLW+A2EmgGChSfvpWdhiWpS?=
 =?us-ascii?Q?27I1rTDCtRB37ILPMG92iHmAZTNEViiDcxl3r7p26XMEWN029/rP6nX22Rie?=
 =?us-ascii?Q?J3Sp3m/5DZrpx2nekBwkMZjuXXlcLrbWBgIswZDK9oC+Eh8G3mtRZE1Va8PC?=
 =?us-ascii?Q?exazmhiJfI5DOAqDPqWAXRKxLnyhsdD4QScwejmZx0D7ZsX8lLSs0vFG3ryW?=
 =?us-ascii?Q?oBCkq9lRhZevRMWe7emiUz/jd32TpRcnojtvZ/bNKo6DjP3osQSbZbnNEwaL?=
 =?us-ascii?Q?T5MLVLbsFI1/tiUGdonoV9BP2QQPBenIXQXcLo0llRPvNZUSPQq7+xPmKoZ1?=
 =?us-ascii?Q?YRIyTEiJBiRnCwvOv+sb+bbJRw6sGXkcAYSCbcSc12+nTu975Uyw7TNmBb5f?=
 =?us-ascii?Q?od4dIA2ytbD+BHOl7vn53MO9YrrGPdFi7LbWDAyyFwAZxbj2zcp6WkbNuY8c?=
 =?us-ascii?Q?pZMDR6dLAZpQcGY9sCeyZ0XTpCG3dKQ2FZ2cYolGTtrL4H89hlJy51+jVnAx?=
 =?us-ascii?Q?k2AS4LlE8KUrL5gUiYx3mFqrVciWw1PmkbJulGAWyFlt6rjXszMGs3RpQN5d?=
 =?us-ascii?Q?POkaWzSS7NgkawXC7jS9/MW3G008Gb0RXPwcx5an2BqSnS3GjB7qQpr43LmI?=
 =?us-ascii?Q?ofTea50SUBIfLLoaoGJ1vrxoCdxqCyv4U8alIfyx+za1Z2yp+j8dNMZQQX5v?=
 =?us-ascii?Q?Ibh/hZYWu51PcuDYOZ1z75KPVMosCgqcJc7c8XntMLb9OpnnPlyaydcW7bBr?=
 =?us-ascii?Q?XntCl6ulkeGJEHMBYZrfeV4H481H+u66qr7sBOMbmbZ8V96PavJkeLPhee6Q?=
 =?us-ascii?Q?3K/J2euP1dgQvhtLPBnQqKXkH9BrI49trVtFpXUOhlZUu7XxkghPvHtLYhQE?=
 =?us-ascii?Q?Xtf1jKA7XLSaVj8uRH0oRjUkWW3L7+GmWQIVt4ZDVC/UtyHpXbHMClq4GYhu?=
 =?us-ascii?Q?N98wRkf/Tg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff35746-b408-46b4-cbff-08de909ca0b5
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:45:53.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6/4nRom90D491Kn6auZgSEEMESj74yQi/sQztauscbV9bpQaDwy9Obd2RZ4H6itv3zxltxNGJAvlZNjIIMvxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213

On Thu, Apr 02, 2026 at 11:31:50AM +0900, Changwoo Min wrote:
> Since commit 8e4f0b1ebcf2 ("bpf: use rcu_read_lock_dont_migrate() for
> trampoline.c"), the BPF prolog (__bpf_prog_enter) calls migrate_disable()
> only when CONFIG_PREEMPT_RCU is enabled, via rcu_read_lock_dont_migrate().
> Without CONFIG_PREEMPT_RCU, the prolog never touches migration_disabled,
> so migration_disabled == 1 always means the task is truly
> migration-disabled regardless of whether it is the current task.
> 
> The old unconditional p == current check was a false negative in this
> case, potentially allowing a migration-disabled task to be dispatched to
> a remote CPU and triggering scx_error in task_can_run_on_remote_rq().
> 
> Only apply the p == current disambiguation when CONFIG_PREEMPT_RCU is
> enabled, where the ambiguity with the BPF prolog still exists.
> 
> Link: https://lore.kernel.org/lkml/20250821090609.42508-8-dongml2@chinatelecom.cn/
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Makes sense to me. Instead of the link we should probably add:

Fixes: 8e4f0b1ebcf2 ("bpf: use rcu_read_lock_dont_migrate() for trampoline.c")
Cc: stable@vger.kernel.org # v6.18+

So kernels with the BPF change will also pick this one.
Apart than that:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext_idle.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index a61339c36902..ecf7e09b54ae 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -881,25 +881,32 @@ static bool check_builtin_idle_enabled(struct scx_sched *sch)
>   * code.
>   *
>   * We can't simply check whether @p->migration_disabled is set in a
> - * sched_ext callback, because migration is always disabled for the current
> - * task while running BPF code.
> + * sched_ext callback, because the BPF prolog (__bpf_prog_enter) may disable
> + * migration for the current task while running BPF code.
>   *
> - * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) respectively
> - * disable and re-enable migration. For this reason, the current task
> - * inside a sched_ext callback is always a migration-disabled task.
> + * Since the BPF prolog calls migrate_disable() only when CONFIG_PREEMPT_RCU
> + * is enabled (via rcu_read_lock_dont_migrate()), migration_disabled == 1 for
> + * the current task is ambiguous only in that case: it could be from the BPF
> + * prolog rather than a real migrate_disable() call.
>   *
> - * Therefore, when @p->migration_disabled == 1, check whether @p is the
> - * current task or not: if it is, then migration was not disabled before
> - * entering the callback, otherwise migration was disabled.
> + * Without CONFIG_PREEMPT_RCU, the BPF prolog never calls migrate_disable(),
> + * so migration_disabled == 1 always means the task is truly
> + * migration-disabled.
> + *
> + * Therefore, when migration_disabled == 1 and CONFIG_PREEMPT_RCU is enabled,
> + * check whether @p is the current task or not: if it is, then migration was
> + * not disabled before entering the callback, otherwise migration was disabled.
>   *
>   * Returns true if @p is migration-disabled, false otherwise.
>   */
>  static bool is_bpf_migration_disabled(const struct task_struct *p)
>  {
> -	if (p->migration_disabled == 1)
> -		return p != current;
> -	else
> -		return p->migration_disabled;
> +	if (p->migration_disabled == 1) {
> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> +			return p != current;
> +		return true;
> +	}
> +	return p->migration_disabled;
>  }
>  
>  static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
> -- 
> 2.53.0
> 
