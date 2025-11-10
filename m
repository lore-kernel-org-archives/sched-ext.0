Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FA212560
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763509; cv=fail; b=fe5rdw430Zgmg2Znv+qxQnJK6oDkmj/rtxvppwcyq7sYTfbWCW0WWBhg3dyXGHZpUnYeYZTuN8+iWyMfKeGD++4E/86nghofj1hYXao7+ZfEcDDZbVhfLaBIB43quNBdjMSguEmuaIuTrZKmLO+kb5b4RgyCuI8eNx2dujzkuME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763509; c=relaxed/simple;
	bh=f3gxooJY1bYtli0U6V/pvBIf3UE0fC5vMlavyyOrVxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jkAj/DHLrqN6GvzOS+R+6uR06T/bpyc1CXIpEAMF3pXtqPMuBwSyxb3/qQXhlzzQgxQvIh3Pi3v7AcdO14+f2Lnb5UfEpdsllouHRWq5LVZIE7Np89hXCtLn4KBSoQ1jQR8sXvnaISMA1b6J5xydevIkIqeEfRBch//8+/2p3ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AErxwjOb; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AErxwjOb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXPAh5M9k6LWwXNDuto417h4mfqOGPU4afeMEN4f67IrydZ8cvXT3ou4Emn0cAj+B0fVmGaNsyDuhR1aYj0BsjGM0Us4VMmrN5RK9tJg+6Q7qwyjWL8rMCSPhGHZDWTmndU5c86Q9WMlJW7H/21/d2Vyv98E7jrhG+WNYAW5AsF2UoGhPdjVBGT4I87NJYsy6yAmZf95vfrbMirh1PV7ndjMYAKBr3NiuxuSs88vQboh/2WqzLFRpd9hYvyapytKFokSUci+DE54j2arOb4+FTwxvyj2UH1/skSeSLMEk4x25CCjVVg9kr0tEmltWkiMi/q8EsUcrvdE2/k5tYzkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaPBNWHgwM5oBPOFZe6YtnINfoJM1gLubkDuocmbbJ0=;
 b=iIb19C69mRJbn+Fg+limu5ROhVOC31netrXU0iBKYMqAEPNMdPgZOmesN0985rkuMK6Hkw0TPxqbYJs0v64Rte6flUu+F17oL7hoNsqkvx4vsuTs9wKANHa/KKKM4KdfLFjL6KEfLMMdNZCWnI+k284uflYdGIRMPJ3b2b5F9vzCBzZiWdzY5FWTJJj3FXJPbbkMQeXB2r5GCdjg0re0JYLWly6hwVW+Q21pkke8kIsQpFlOxjUYKIvy3Omf7kuKFE4hFSOz/O8/bDX7U2cU56+7HYB/zSff2ZC/LURmjAM28tyHhJq/omIavMjcLWdrIXEgmdEcDtlCW87pcmTyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaPBNWHgwM5oBPOFZe6YtnINfoJM1gLubkDuocmbbJ0=;
 b=AErxwjObHmNT336uHRq9qMFrULI42g36BhB1IbGniUOpjM6gaXPg3pWfoEAvyrf23xFrqqkhwLzqeZ2hJippakjNORpaDnoqNoWMSQvFipo3CUwuyAYtHqorMfdokkpUvSTm5b8EfeMmCDinTYf+KYJqNdqObRbw9bKp2kABl9L2jBKKAhAAOgXWjd/j2CRmjN96NmVBTtsa+aaovQYPXkdkDpoas7P4RgRnNWBMOGsMa1hghvR4LNQlB6u+cKqJY4KpFwWInxEMUcN2i/2hgw3q6wyKSgBpwCcx5Qa4KXooTBmJH/iriOSrhwiYFV3vk2GC0Vf0A2mHXP3aPqYi2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Mon, 10 Nov 2025 08:31:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 08:31:44 +0000
Date: Mon, 10 Nov 2025 09:31:35 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 10/13] sched_ext: Hook up hardlockup detector
Message-ID: <aRGi50r1BYcKTNJA@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-11-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-11-tj@kernel.org>
X-ClientProxiedBy: ZRAP278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 919c74de-bcae-4b4d-1507-08de20339477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YW411VDN1N6e2yuuLSJ5a6P1Tg+Yb8WVUDpgxytKIK3iWds7Vjqb6LrD2md2?=
 =?us-ascii?Q?1U497yQwEYiOcY3v+DiHeKJVtw42GJfRlVmtS4YUyzcpUpSJOMMyrupySWyF?=
 =?us-ascii?Q?vkEmW5vCdExSrhq20NTzNgtT9eQvdCnb0FD2ruj0k71gwTHsgCNXJTN8YFDs?=
 =?us-ascii?Q?B7TUFgSn3TeRJhiSotsOFnYQ1bxOCQFKkOEXltV21eU7SGPQfZAvdGvWZ3cZ?=
 =?us-ascii?Q?tBhRmqTDMPwUpV6ylnWQmoSf+72UBp/Ch90rByZ0z3GZJTHbqIOwoIg+7r9J?=
 =?us-ascii?Q?59kY9BmWCVgXEUUyE2qoRLqEDfRXkDNKSxBSVeb9DnI+sH8ul/mC2I+FESe0?=
 =?us-ascii?Q?uyHYjJlzmJpCxU2fc4isMebozXtarcDIsVdSw8FZtYbi91MHkwsTKSHGh3qg?=
 =?us-ascii?Q?OYFuX8z8L43hxe+0pHz0slplL18DxH+geDdCz4pK0xO/FOSYUMec53f91V/V?=
 =?us-ascii?Q?0tuVfqx4tqVu+IPaGtSqcYmwBb+sqi7fdx/TtbqdIBqHU9rqZpgSHmfu9d48?=
 =?us-ascii?Q?AiE+zCNpWP1co692WtGtahHS9wZUwX6CcECKCYxIgWDoHU8hL679XaQ9aO/T?=
 =?us-ascii?Q?Qr0w5gYSrg6RcuuAYB+q5DnFhSGvEwPDDTwNaiGtB4zqKOg6hPW1XU0vFgS4?=
 =?us-ascii?Q?zgMFrvikxoBM5AJBK2c/8HlFptHWxJoOYJlzdupj1gM6ksWoM4DCo4dWj/5k?=
 =?us-ascii?Q?V2DsRggLdTCddt8c0WyxyFrznc9W1pDo0d84gjZWJ5wF/7cic81uI++iSjBX?=
 =?us-ascii?Q?aL1TT6WGsEqzYPac24ZtXNp6nyhgGLjZyextOYakCG3CNMYL0r5HjWLdNjOC?=
 =?us-ascii?Q?0B7i7VUcrmsYcuTC1Bu1M1djpdUejFmELm2AING+1OmEa0wKC+/O3j/yrH6z?=
 =?us-ascii?Q?PZ1wUeoGHTiRLaFKH5NbSwiOMNNgNIkEwqVV6p1DCQVIht7xfD0vHngfwont?=
 =?us-ascii?Q?3jaPGbBFGvr1H+UFMGhq2mJ+0zH/uIjaX1I6bJdqB1+oSkQ9wnX6E/m2ohL1?=
 =?us-ascii?Q?qxsGPn6OVIy23pNuO+67PCPTSqV5cDo5dQHOEjjgtuG13fGeSn3WJJUV6CWF?=
 =?us-ascii?Q?bTSNUhMP/fk1Ui38+SXXdUOHe5uLvXZ8SvZARKS7hE+4NHGiIvIIpHB2OMpf?=
 =?us-ascii?Q?zVOdHgZ0VVpxCT29sn1KQPit0aAXttLsNai20sgAWDObHOdEetJ8i6mjlpUU?=
 =?us-ascii?Q?ac4YoEip7JkZty06FPFyZe3Rajz5lY277t8Yq17R4rOfN/XvVQ4tT9tiS3kb?=
 =?us-ascii?Q?lcvmDHS7UOJxgoBJrygk36PfiFjo5uJ5lJv65SssGUAvzG7sOJd7VyB1Z/0o?=
 =?us-ascii?Q?Ek51apZdoqX++XyJQf8huMFOkvPlrxD/c4KTtjGRImVMMpeNPrHhX7ODMMhI?=
 =?us-ascii?Q?wiNVa3/Ccr/AH+l5bm2YFEzxypobrHXa2UeTEyuCwGWyEMycR/PrCk86f3oq?=
 =?us-ascii?Q?Xv8EDd3zqj+L1QA2qRv1aBATLpuHXK0q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IlxQp9+8Tb7rZkLjF6gfXSQkd6HnPip9CCcgSES8jzkcMbV4fxIRwdILBFNR?=
 =?us-ascii?Q?Bi+BQmLjMrCPDN4jyF80xgVKL5cc7yYs5i/V+cNLAw6/OKyzCLieuQXjcLxC?=
 =?us-ascii?Q?+92xVBQPQi86qlQW9hYYmc8AJ/K3HpB03+huQVk1jVf/0ZCKB9E9W7jPSUmC?=
 =?us-ascii?Q?BZwHhgL6AoCmMr1RKAw8M8Hux1j8ExRcievSTW/bktp2fWql5+repglVlGva?=
 =?us-ascii?Q?pKsR5fou9qoca+HU5lYs2fmiN9hVGJfFf5o3gVZNv4N4bUBkHZB9cJFQauNG?=
 =?us-ascii?Q?/i3+tCg2hX7BalUJZsjCIGm0y/8pRFV/kfxjJ22qEX4KC1QwDy5bywviqRPJ?=
 =?us-ascii?Q?QylJkECQMri06Q/P7Khj/D9/xwAID+KcxPkUD8veiQ6Yqa3pKw539v23XNo+?=
 =?us-ascii?Q?2+VP6gKNYveZjlUecp6XuUc7kw7FEYI5AMMm8By7dJlYfguwce15t3jRIjw3?=
 =?us-ascii?Q?V1M6e3R5QPg9h4AjE91mjIJ+PFBVFjJ5xu/1D/YDuF8bIVgPEXDpIrr4sbuD?=
 =?us-ascii?Q?NCYCR69AqKheFiFIWh4IAyJG5qm6II3lKY5QFHLl2BkjJJmjzsPdVSgJaW/o?=
 =?us-ascii?Q?3ZyMZj3SRTgjVOUjJUrao9gC5pWKMzS6RDkG0WhfB7MhO+ZIo0RRuG1+XVhj?=
 =?us-ascii?Q?35R1qmM2kCFa5UHcYLS1vy/97c3zDeHQ4jso/LOvG+7pvFxqfNVNn2L20ELg?=
 =?us-ascii?Q?XzjXqaf/h1T9BDnQV+uWEi8xPiSclcv4jO+BxkDV0xxetgcC+O9EZTXSJyEL?=
 =?us-ascii?Q?l7819DCsZYcl5ztmW7y5zA4fihkiFLP8ibmWqvC4niTAQLXjg2XYYtKeaifS?=
 =?us-ascii?Q?+Jrc758WqMrMmSXuLLfUAU85moc54+0WHYHqx6COCWNVG0MOCzx6mYwQKUn1?=
 =?us-ascii?Q?hSm09EOHQiytlWWiv03wKxMRnq+Hn31UxFRRjxHn5bkv70wXilJ4YfeXLNLt?=
 =?us-ascii?Q?GHnJzQ1M+AyRCRlgfJSgENx089R2B3QiIqGJRPxVuDYDRvF1jtwyL8rcIqV1?=
 =?us-ascii?Q?HrVwQASfgov+lRZIjxD+DqRL5wvcFeRxclm2AGVRQF3KDpwIvN8hPb2pNdSO?=
 =?us-ascii?Q?7kGWXTYLzt0AX7IjAQ+BqPqfY77kCC0IJy3qlj5AtWXyUayRHg2mj+YmkkKX?=
 =?us-ascii?Q?CdI6Mu0cUaSPvj0ZGMpvSSB4aNQTaAb4VI04TwrplpecSREBWl/jHX7fWogb?=
 =?us-ascii?Q?jjaJnA5jjue0mzOrnd0i1+ZzMmpoy93nkA4T4Uf/76ngJHanTBno2wi5iVIc?=
 =?us-ascii?Q?Tvmhf45U14KYd1J5ZPd4jRTtA645+BiLrgA4vUuK3Ijj+fAe6dw/UsMIeS0e?=
 =?us-ascii?Q?U8H6zrhqnCGrRms1wlQIRVymHDAZJyOcaLLZLAtRgLut1sE4Q+nexclXcELm?=
 =?us-ascii?Q?0v5h6Q4zam+C4m5kEX0A0rVuOegBszUaU0OXw0QQMJrosfXFpgk5R+/UMI07?=
 =?us-ascii?Q?k0dlkSQ+47EL8ewjhdXQQi/kgDwOc0IWuZQpQAsdKkDFki+Ur9Me6IcGyojt?=
 =?us-ascii?Q?LmxAiir8D1HWCuT7LAsr12ncpitjPcEbBCoa31oytRDNKjKozOs8l36qTuWz?=
 =?us-ascii?Q?TYWdOpDxnbHc6GgXQ0mD15RePVvA+ojMOSssA+Gl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919c74de-bcae-4b4d-1507-08de20339477
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 08:31:44.1671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DD4x4V53kgW7m4vV+9j0VYq3tvsMMCO5SjJKuhrsLrf1Fv72t0oY0dMmvpz7s/Ca7J7h4yYvXx+Gugzy1R9D9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769

On Sun, Nov 09, 2025 at 08:31:09AM -1000, Tejun Heo wrote:
> A poorly behaving BPF scheduler can trigger hard lockup. For example, on a
> large system with many tasks pinned to different subsets of CPUs, if the BPF
> scheduler puts all tasks in a single DSQ and lets all CPUs at it, the DSQ lock
> can be contended to the point where hardlockup triggers. Unfortunately,
> hardlockup can be the first signal out of such situations, thus requiring
> hardlockup handling.
> 
> Hook scx_hardlockup() into the hardlockup detector to try kicking out the
> current scheduler in an attempt to recover the system to a good state. The
> handling strategy can delay watchdog taking its own action by one polling
> period; however, given that the only remediation for hardlockup is crash, this
> is likely an acceptable trade-off.
> 
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Makes sense to me, from a sched_ext perspective:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  include/linux/sched/ext.h |  1 +
>  kernel/sched/ext.c        | 18 ++++++++++++++++++
>  kernel/watchdog.c         |  9 +++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index e1502faf6241..12561a3fcee4 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -223,6 +223,7 @@ struct sched_ext_entity {
>  void sched_ext_dead(struct task_struct *p);
>  void print_scx_info(const char *log_lvl, struct task_struct *p);
>  void scx_softlockup(u32 dur_s);
> +bool scx_hardlockup(void);
>  bool scx_rcu_cpu_stall(void);
>  
>  #else	/* !CONFIG_SCHED_CLASS_EXT */
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 4507bc4f0b5c..bd66178e5927 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3710,6 +3710,24 @@ void scx_softlockup(u32 dur_s)
>  			smp_processor_id(), dur_s);
>  }
>  
> +/**
> + * scx_hardlockup - sched_ext hardlockup handler
> + *
> + * A poorly behaving BPF scheduler can trigger hard lockup by e.g. putting
> + * numerous affinitized tasks in a single queue and directing all CPUs at it.
> + * Try kicking out the current scheduler in an attempt to recover the system to
> + * a good state before taking more drastic actions.
> + */
> +bool scx_hardlockup(void)
> +{
> +	if (!handle_lockup("hard lockup - CPU %d", smp_processor_id()))
> +		return false;
> +
> +	printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
> +			smp_processor_id());
> +	return true;
> +}
> +
>  /**
>   * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
>   * @bypass: true for bypass, false for unbypass
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 5b62d1002783..8dfac4a8f587 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -196,6 +196,15 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
>  #ifdef CONFIG_SYSFS
>  		++hardlockup_count;
>  #endif
> +		/*
> +		 * A poorly behaving BPF scheduler can trigger hard lockup by
> +		 * e.g. putting numerous affinitized tasks in a single queue and
> +		 * directing all CPUs at it. The following call can return true
> +		 * only once when sched_ext is enabled and will immediately
> +		 * abort the BPF scheduler and print out a warning message.
> +		 */
> +		if (scx_hardlockup())
> +			return;
>  
>  		/* Only print hardlockups once. */
>  		if (per_cpu(watchdog_hardlockup_warned, cpu))
> -- 
> 2.51.1
> 
