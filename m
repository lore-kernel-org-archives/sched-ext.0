Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0264317D
	for <sched-ext@lists.linux.dev>; Wed, 24 Sep 2025 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694457; cv=fail; b=RVDoCwokBiSGgj31JDazf9YM57Z5fJ7Q80R6hvVi4cRSQOH2mGe7qIaJVOU2dSnx06pjtzlZzUEVNvUN5wrQwFZKstMn1JV+Swu+y3Y2Fg6Q3sqSyjyQTsxTIrdynwrc+PLHLj5GUYTArwQ7dHjsIIYE62F/P55sF0HvkwoQ2JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694457; c=relaxed/simple;
	bh=GSvjcJbY5z4s3aexCRrmBOcRElt8Gar9POX/JIHGc8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DiLy6RS/zbcP5Gc+rZgXQbRzux6Ngy8tUpqb1cj4XHO3Qw5Z0YCGzY7jqr+8bA0PlDdqkrqsPp7hN/8PP4rLbhofjp/FB+KZNlZ8ci7/bzox1mFvgpgRsycrHjkwu5MR2sI5VCY3phl8I+71/yGIMz/LculNodlQ5iUDg3Yb/UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K4god3/1; arc=fail smtp.client-ip=40.107.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K4god3/1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJ6+OU7SsTpA1oU4SQj9KLIP7Hi4B+LP+BeJMhTipRg6dYaV2vSMghfkkNx4Qbe+kTQ2H0xve3AA+Zt1dJ7FalCZn1Zo5lXeC4y61dRSmEssllsaiVOckEJclEUpgo86CZwO7/1jf27Rlg911otJkNI71NCvaWGLIiIu3CbA71Nop7UEjwbVMMLeUebWPmvf1fkWZzHt9/f2dodmu5PYqiNCp2fm8vtnymjKGhNnks/rqnkNa2kI17o10OXDBb1aQUb2gMVgtwBQkBKWC/HO46LeAgE0EVMLgPPcZm9H4H64sXx5FVo9SksHnHw2deHmlLZ5KlYr6EzXsLZaNyHbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etdQH0gEuc3uzI3kQNobZm5TUahWGQAHVUsup6IWe0I=;
 b=gOXwhUPhSc0RzN29O2s+IUVGVr6ZR24hGI/NeLRmR9s2IYvFPd2TMkA82C+AdcQlDn1uIAWSdJ7Z+t1UJjhcb5M437NNYEkorDUgFj9L2fgBHCCh/YM1/r8oSN1TvWjSHwcsHRN2QZyrvla11rNCkHjmoaDheo1mxdKhWysmMA6S+bDNlxCTBOIhlyiSuBMM1LDmzVMGmeMyi8qXoXMAgciMsIbS8aqUPt9cUfRp8sOu6AkzIGMfQIdHq2jbTjkRn22euijBJIfP3YPTJ4VbcBiwgVg8YHzf7jiW52FuQ5iXUZbWWs1n3eozzkGTCqMdWONaAXABxZKPL9w4hP1YOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etdQH0gEuc3uzI3kQNobZm5TUahWGQAHVUsup6IWe0I=;
 b=K4god3/1jCEJFYP/g9XwtvxKRy91cMjZo2w4Wg4qOMclxnJRd79gBaDcjrGF4r8cDPKwC+lfWYr/ql5IgYYAEUdnb0DhfMQrgVRqfNcM88yY4cmoK13PiUPBG9QAy1lPEC4SKaKziMn2veiXt83TK9J7bSCi67rwDeuX7FBbZLtGKXkY003bHR/E0e2CG0lJwl684XhI01ui3BdkDpW1fdmMWeWZ3QlPDK0i23oD0S81L09LT9j85Gwrxw4TkMUN2JX3VMwBqj5uAvFVIuDq/KRVkoOZ8sz1MKlHLX7uva7nFdIuLR33IMcoyPzeEl2QXePg41Q/jGGcv6ox6AHk/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 06:14:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 06:14:12 +0000
Date: Wed, 24 Sep 2025 08:14:03 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/7] sched_ext: Use rhashtable_lookup() instead of
 rhashtable_lookup_fast()
Message-ID: <aNOMK1gk9if3UTgQ@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922013246.275031-1-tj@kernel.org>
X-ClientProxiedBy: PA7P264CA0275.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: d2036e0e-7505-4ef2-6a97-08ddfb319463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pDwnIo3domg7WCwX/PklxzqUUT0MXRXhXeXoSL2qJX3br4mF91WnxvAbEov3?=
 =?us-ascii?Q?yVnvWQNaxeDKvCAVeheIA5cYNLQKD/lSinqwUMRbZzWyqKeEWcWdHu+h04SV?=
 =?us-ascii?Q?7pNXPPwAUFDQZqwyiyQHqXOTG11vhBcriu2dBcpRogVoMGHo3rPj/8kv1Jvg?=
 =?us-ascii?Q?TbA0rHj/mkM5Y9K66rKJ16fPObiEMzzNY0o3GAgMvR06M3PGEBl8kYQirKWn?=
 =?us-ascii?Q?Gv+0kQeYDkDc6J4o6nioUX9hV0Ls7+pxTKD/TsvDVVpdcXwu+0TRtMt46EpD?=
 =?us-ascii?Q?Gvg87ucyO/8faumCeeGQfEGhTMBQzvpxunaZX3jzNk7a547X6CjhC14pS1ea?=
 =?us-ascii?Q?LHa+7zL/uTabecv958YaBLgmf2XfilBs7rXHs9gnKVJ2KWsXj5LMyVqRrNS1?=
 =?us-ascii?Q?W9DTkY04z9fFzdaHLHa8iAeXlGsNYRYOK/aO37tuLDUG7LMxcjZ1B7FwfrY7?=
 =?us-ascii?Q?SmF3+QHaFSRrE/cpkm53cOH1KgiJAqsino7V0cXkN/HESuhsbEtzsHp0/ELS?=
 =?us-ascii?Q?fHlV7870SxH2Noww413JLJuv9BENo7Ik6uP/3IisOOB1HjA9FrFRHOyryJln?=
 =?us-ascii?Q?JiNLpG+KEgMTHoJSMh2xTCtb+XM1gw76kopqZMbcNpcERsIXvNxodnZQ4Cuk?=
 =?us-ascii?Q?JcGT8Lyw4trjQ9un5JRlElvVUtvU5pOwTwD7hgDaPlnj/KKwvqFRzGrRtBWF?=
 =?us-ascii?Q?YiiP9HF14wz+PAgvEfrg2HBd59yeqh8nGURyEqdPeI+sQhq4zJGF72GZ+3Yx?=
 =?us-ascii?Q?ViuuiVz/xAEypAwcvxnkDLKWErGO9QcqJ24MIjHMEnRwBZYQQIbRAZvqVTIU?=
 =?us-ascii?Q?nLXvDiEe+l3c8PU7KfybknWewXC+ubB6IwD3RzKN4DquGMQ0FEmGC1+SnXFc?=
 =?us-ascii?Q?vEZVOLsz6d8ZPeADLiPVphe+cCrgW6QEgZmTS/Wz0iagTg+VTXA/VDH8fjvo?=
 =?us-ascii?Q?jDbFrItSOdbKvk+sZaNWca5DvFaJBHFdKnSqBaDFRN0iw12371Chj885FTg0?=
 =?us-ascii?Q?E3Fkd6+mAYaOVSZtJR0f2cAnFISCUpnZJ89wVFoklTqFAyKkY3EuKoQGPIuq?=
 =?us-ascii?Q?LjWxOr5ZkislQ783waacLfeakBHIuK18g1ActbWUxP7xFevi2wm2kJ9CYag9?=
 =?us-ascii?Q?qJV9m3BErzrjFYjBk0QLcoTWb0BXkKToEwA5StuXuieGhDjks3REpLVG3Ln6?=
 =?us-ascii?Q?IyZtC1Odp3H4xRgiDRu9nmrSKk0apVZLRIInHH+FF51/Vs8guyUi7dfj/X0D?=
 =?us-ascii?Q?fJPjbeXOgSIzBRe46z1z/94mCLiXCWPcS3MgyoeaGoICYGy4Uf6+u0BQlt9k?=
 =?us-ascii?Q?DWxznjM0nOOfz1wtF4u5cMlqwTTxmUj+0TTcQH9ZUAtAAGhnSXpClaNgyVpG?=
 =?us-ascii?Q?J9H/ZCS7AzcYFD9hBFPlHlW7ho95KVfwXQglkQTFCoutITWODJ3LWGs2Uey/?=
 =?us-ascii?Q?KbukBr9UKTE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Lh0wK5LQJMQB2qtiR09Q5vheOBhXSxJOr87RDyXnJcY7QOffIurO3eZIIMM?=
 =?us-ascii?Q?mAeOWGE+Ov+IFToa267dumwvbfsnN87k7qH2GEuvwsLDprVVTPQjzZI15Rxm?=
 =?us-ascii?Q?9Lrlg3D5vaoNHPG9fi5hGMEc/fE4rDbcdtTK7LRSUxadrCROkR/4Dn9XrciJ?=
 =?us-ascii?Q?T0mlvp32tccoVG87LgVNSdWf78j+vLZUhKvCKoh7p34xWrLktTYv/oC8nYH6?=
 =?us-ascii?Q?e330bBz54Z3O9VVKt81Y7FQG68JHB998A9DX5kmsiF/B4L1hlWnZ0xoCaGrj?=
 =?us-ascii?Q?tw3GB5U/b31IzZXtsYZlkX7I9QvFO/vWJVyFQIUZtxUgzYXExQR7mPDztpsa?=
 =?us-ascii?Q?GFThd0/GLMgEDJAMQpYL9+1atM2kPakvH3bOdMFSjP7R3xRYOVxoAfGciTPm?=
 =?us-ascii?Q?QK+linDfmWayp0N425BbFDCOocSGrWT0OJYQiP7d9QZ/qMCs0lOuT1aXLP6K?=
 =?us-ascii?Q?B6V3Meo0MczgRXuYwYB+hbRCeAR4FmjoyldimxulnY6Iw6FwBHTno2AjRIvQ?=
 =?us-ascii?Q?6WKESr3WLP6Ykvg2DuCrvRBRDj09vivwrppATDs4p5ME0PGpuUjaytIYVDEY?=
 =?us-ascii?Q?JWrzO5QBnZ5DZlEsE1dLYAoT+R9iBFOk2tGx589furHFB+FteAHiNp7Nns5i?=
 =?us-ascii?Q?lrYXDoKBIgni9zrQkf30vO/zTJNcKBr9YOShKl0VEltPAMIKe3+ryJ8vansD?=
 =?us-ascii?Q?WbdTDVmYidXum9L28gLJIgVcCZIDOQa2zlYxYtxIYCNm2M33ALJUvlU5Om1R?=
 =?us-ascii?Q?iM0Zs1Wl6LZYWEXxStLPmxId9+INSXXaYWnH3tVLjFgcLIlvOh6ZCJQdBMQC?=
 =?us-ascii?Q?hn/ggAgYHFhDTB1QQlvAmm7Jw8srG092NFU90EauMRmyz1s3pw9qOHpujXsv?=
 =?us-ascii?Q?EyfQpeP7xjAXjtZaHA9NcyqDYso1kf/PN5M8FDz3kabqB3VHXM/aqnS3ZUKf?=
 =?us-ascii?Q?L8yarpvEgQAcDJLQ62AUukZgPib36BiHorhTbbui80Vf30ReFpJb7x1wOA5t?=
 =?us-ascii?Q?uAQcarp6Qi5GI7vfezeU6fGBbxwZmOlKZNC/BccqL+WdsVo9E4whcxB0jtn+?=
 =?us-ascii?Q?cIyCe6xj6MIWHbCSvWAtXARRTtw8xy4hLNewrSVYYPZUcOtJD7K6kvQSJ36u?=
 =?us-ascii?Q?S7uX391ynIyvgBgHR/cGF4EYqAv/ABG83G6xRT6qydkwMBu2GWyfIpuJr+pR?=
 =?us-ascii?Q?eRNdmkYDEJB18BXRiwL/F4q0PT+nvGcfgmAZMePAGIRAlNj/NucYlgYv/jAz?=
 =?us-ascii?Q?wJnacgeG/+xK024QOMZ+ySCTjD/n5SXS2wUHThHisOV/B+1ae3hp/z2v27hp?=
 =?us-ascii?Q?MWBKuXc240DjOiV87/503JUxTOidI9IAt1g3OYhWx8Pl187lsoFDczi8pArT?=
 =?us-ascii?Q?qXGAyjLOtEstN5xguXq88Ow2wGJWz9hXg5nJBFm83/u0QWuhFgfA+XogEXFb?=
 =?us-ascii?Q?/frkskDlrPvypKyNbY55VGPrJYvfZRTaHpDM0Qqsns46r9fC4UeupLxdvn3u?=
 =?us-ascii?Q?FdlVp0wgPNwiqeuwsMjY4qnTWRv6ZDL2nGvn3cNbRFjcnZ3Fi91Zbg8i6HJj?=
 =?us-ascii?Q?9XKxen1U6iri9H5q20a1oEJlxE5AXBOPROpgeiPY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2036e0e-7505-4ef2-6a97-08ddfb319463
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 06:14:12.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtvvBz0ogWyCHogvX+qENZfrXlX0PhsLyvmFdqqUBI9Ppv7+UEw1bg+fA1EE29dwd6ZBdVGhEGgZ490VI7KCqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234

Hi Tejun

On Sun, Sep 21, 2025 at 03:32:40PM -1000, Tejun Heo wrote:
> The find_user_dsq() function is called from contexts that are already
> under RCU read lock protection. Switch from rhashtable_lookup_fast() to
> rhashtable_lookup() to avoid redundant RCU locking.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

It looks like the ttwu_queue() path isn't RCU read lock protected.
With this applied:

[    6.647598] =============================
[    6.647603] WARNING: suspicious RCU usage
[    6.647605] 6.17.0-rc7-virtme #1 Not tainted
[    6.647608] -----------------------------
[    6.647608] ./include/linux/rhashtable.h:602 suspicious rcu_dereference_check() usage!
[    6.647610]
[    6.647610] other info that might help us debug this:
[    6.647610]
[    6.647612]
[    6.647612] rcu_scheduler_active = 2, debug_locks = 1
[    6.647613] 1 lock held by swapper/10/0:
[    6.647614]  #0: ffff8b14bbb3cc98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x20/0x90
[    6.647630]
[    6.647630] stack backtrace:
[    6.647633] CPU: 10 UID: 0 PID: 0 Comm: swapper/10 Not tainted 6.17.0-rc7-virtme #1 PREEMPT(full)
[    6.647643] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    6.647646] Sched_ext: beerland_1.0.2_g27d63fc3_x86_64_unknown_linux_gnu (enabled+all)
[    6.647648] Call Trace:
[    6.647652]  <IRQ>
[    6.647655]  dump_stack_lvl+0x78/0xe0
[    6.647665]  lockdep_rcu_suspicious+0x14a/0x1b0
[    6.647672]  __rhashtable_lookup.constprop.0+0x1d5/0x250
[    6.647680]  find_dsq_for_dispatch+0xbc/0x190
[    6.647684]  do_enqueue_task+0x25b/0x550
[    6.647689]  enqueue_task_scx+0x21d/0x360
[    6.647692]  ? trace_lock_acquire+0x22/0xb0
[    6.647695]  enqueue_task+0x2e/0xd0
[    6.647698]  ttwu_do_activate+0xa2/0x290
[    6.647703]  sched_ttwu_pending+0xfd/0x250
[    6.647706]  __flush_smp_call_function_queue+0x1cd/0x610
[    6.647714]  __sysvec_call_function_single+0x34/0x150
[    6.647720]  sysvec_call_function_single+0x6e/0x80
[    6.647726]  </IRQ>
[    6.647726]  <TASK>
[    6.647727]  asm_sysvec_call_function_single+0x1a/0x20

Should we revert this?

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f5873f8ed669..df433f6fab4b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -207,7 +207,7 @@ static struct scx_dispatch_q *find_global_dsq(struct task_struct *p)
>  
>  static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
>  {
> -	return rhashtable_lookup_fast(&sch->dsq_hash, &dsq_id, dsq_hash_params);
> +	return rhashtable_lookup(&sch->dsq_hash, &dsq_id, dsq_hash_params);
>  }
>  
>  /*
> -- 
> 2.51.0
> 
