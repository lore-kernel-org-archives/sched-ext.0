Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2505355F28
	for <sched-ext@lists.linux.dev>; Sun, 10 May 2026 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433615; cv=fail; b=S87cS40gDpIpVhJAt6xK29Oy7P7IQcUpMSt1KpE44p8I7aOYQXv6kuIClgnHeatSwTiPs4RkxFTk8Kb9+TCh7pNamc2B+J8PzXcHcihz9pzIOp818t689W9Q7x95qgusxyCyGVrEof9W57UrAsTugCjV6AYfeSgeDj6KF5vqWb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433615; c=relaxed/simple;
	bh=L7PwHrAQXPOu5aKUku+TKskUgk1RjekpvzOC/ZmUmHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bynu9l6NLU9TacUneUDGuqqnCU3VfaFfc9BsUNNXP7Rxblr7W++DhP2UwD9DcDaZ0M4BZCeFIAl7CmPCM1oybwJjZaS14fFmNkwSHrFT5nGdWJ+6sxpGONQm5IdIX9JkH8F1wOoHYK7J4XLJGirXJi3L+2vXKgJmgFDJZa2sU0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BtMAzXEV; arc=fail smtp.client-ip=40.93.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BtMAzXEV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmVytq10QhHQIAgpFs2ep8X+Cp3j6MtN80L1dUE7nKsPnjQ435e7ub5pR82sF/xhb+R7Hp6Yr3nl5K4YE/Xl/VPS12NjvKt1fzlsylpkQ0484pArTMadwtaBxthkimClZbT/AAdYLZGk9yQI+7qaClOZuF0lQztJHUkd2tutoTXzGUrDshm0IHZIzkVSpjYfwkXIOFiHOZvGLwj+W2/TrlMva4Lz3pUQyoJU+uZJsXiYV5K4j5mwmkdma2vD9IrrblMjs0268yMERUyXq9FFT+6k89dvxskyXnxi61ZnFJy3sHlm+vBwEIVzqLiKKlhcTvoNTaFavI451S7Nb9Arvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktlpeFddnacWIsxPktsgNhqAM0GQDz787E8DO3mUI0M=;
 b=GAzO7v2aMjGCVnmcDV1YhJk421TjgmppbQBJjody9KNetlxb6iWdgsCmfGrjSxBhYK9mM8w8juwfYmBXP5TqIWMfVw4FFE6kdk94ZwR6AYyEf1FY+r6IMMURtmALhtx38L/SXyugAABKm4YJJPgaOrp0UNE3XGkxkLyN5bUIqc44e9kBNmWVpvla51a8LIvlHPss2MmkusdzMY+xeMwDPwKyddSPQ5G1j6zdhgaVZFhx/0xlYrSonRIcMsST0wJcIZMNKFrq1PyCuTv3j+3bk4ovy4KJ5mQJtyD8emGPrQc1l6cIS1azYOUFG2VYsa3C2ze30r/mawpBzTxT3/9Blg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktlpeFddnacWIsxPktsgNhqAM0GQDz787E8DO3mUI0M=;
 b=BtMAzXEVkdItszY5G1kWaRYT06D83jHZ9FftiqRsYONB3LVw3hY7N6EN0TXqdn0uoxuCU5OsTeFQUgu6Q1RdU5QjGaAg+u3fbFyReB+gCkURtpnktr1UO5eHi5kQXp3s6pr2ilKRm1ggBvh6oCvgW51/Xl8YBK02lBY1427Qm16MNQchq/3lUgdr0odntWHbcif4T0PxpVf9UXnEQOYRqQSsUCZeLZ/LM8eN45+gRxgPww6rgp3A52JtLjGIfMRSKiFtePJsDY4IsDLitp0sMVZf1emmuENdWyq0Ad9BsdQdIezfKHsKO1eCid6VRPY3EQ3SZ1bO5IWF5LzxOQe/Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 17:20:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 17:20:10 +0000
Date: Sun, 10 May 2026 19:20:01 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] sched_ext: Inline scx_init_task() and move
 RESET_RUNNABLE_AT into scx_set_task_state()
Message-ID: <agC-Qdh1TTbJUlZF@gpd4>
References: <20260510074113.2049514-1-tj@kernel.org>
 <20260510074113.2049514-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510074113.2049514-3-tj@kernel.org>
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: a25b7dc5-33bf-4f37-4635-08deaeb8638c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gJuhdzWfrSPuCJ19M6UyOBgS5gRn3+uD870IRXaSEiIVZiNMhuixmMcwxMYAyeqf1dSP3TsksBBFIjy12Pr4IH8frWg8vdx+Aq4/YdSXBpOWEGrtRudLpyDxVOk0PxCfw7QjEW0CWjjWDtE7zNNFp6DPZ2S5leQasAYlzxuSBNh8x63S9EnZZekJUVABcBOKHM+bd/VllhpMnlPYGbs5FMymLGLB2hclgRaLgH2zBUI0sYBO3M87lhEXKTW7qNQ9DdYpeA6lN28cHIElhBWRN0V9jzVliViCEd7BlkF+iap4rYzh9SYO1KKsjy0BZCL5LrNICKW2pujDllX48/Eaqz7/bpzTHgrItW0BtejvDLZMPQEpxlNFxJV3R5voBP1lK7tjaDWZiE2y7/8i56V7O7/jMwJeNXz5Mz2XTEzCzPBh39lNXAwDIThtsN4VrflqMdUNLbFb37ikNeAhvSvzNOL0ExacKGRShl95FSSGF73vkhwr1ngbx8EVfTrjJCTNBeZ75yG9s7YWiXUsOUkLmHJT7dpVxoT1hJBOpbIw8UiQtJhMwARNsqXK9XyT8IL6mOU7PzbPf6NeApb1I2DWYanR5T0F7Q4DhZL0c4iNgnYTblkPJ3uoKAusXvzvORjE8F5ZH2n9KYQnawTB864a1R0AgaRgKxtMfsPCv8dpclOr1mvuzwJ8VQqw2PycZqIz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tKFn70ZkAltvZz05oDGZK4hQoYdEyiPbkU3CdjATufrvqalF1h6UoaJrtG75?=
 =?us-ascii?Q?95lYE+mVT0CQg9mccH6qCyrckZThBZHm+pDs4lz00VuMHy++h/ZkoQxsqjnK?=
 =?us-ascii?Q?KZtEnt2Gt+270ZtSSYyzziwMs1Jz4gO/S7oECobzRX0ytbPRodX4LW0Vbe68?=
 =?us-ascii?Q?NB5dJBzO1c7DtJrw85Ca4R0Lap+Pgg1NqXiDUvWQYFC1felX6w55sVufCZDp?=
 =?us-ascii?Q?Dv/QxL+nCa39SJ+zu5jTnlht/MUA+/qKoCipzy7BrqCaQZeMwqJxfMWdZu6d?=
 =?us-ascii?Q?go2qzT0qMY/+HffdBua9QtFIqmCZcrmLJlf8zYoe6dCCXk6yFZlIlor0oomS?=
 =?us-ascii?Q?Fn96bQmFVs1ZWC+qR2HDSZedClWKC1mnbJT9c05wu15wHc/6f8vXlx1BgMTV?=
 =?us-ascii?Q?xR7InmTFNJyBFo0H6A5UqwM5QlJd17ZEqWXU3GO/C6qidWJ2wJZhEw6aXFUQ?=
 =?us-ascii?Q?VFhWnMvY//ZHCAeLlshjFMI7c2C7qkmIjYSdGcq9pT6mbMp61y4URxSlV6Xd?=
 =?us-ascii?Q?k3XqOBEUbA1Xkwth995JVGw5BB41HYQ4J+cg9OqMqwyGGPTWBn8EFm4S6lIF?=
 =?us-ascii?Q?oK8sbDrpayeEYlEm3/sRbaJ4RvbzbUs3CSKtiL3Drftxy11CcWAAeOExf+nZ?=
 =?us-ascii?Q?bwv804ydrESYWVYlT4/koPZXkCRrYeVFfxVCfbgIeMe71l+ygpREdEbQeKHh?=
 =?us-ascii?Q?4bEIWSl9EifS4EJmL4dCbUtKltZGIiFtHLEJTfZFBUWt4osUweUzHaHrt8+J?=
 =?us-ascii?Q?uA3ZBVnaipGJfCYHwQ/zLKoyVeCF+mY4jOiQ5swv/QhddKi1JADVUL87s5Ij?=
 =?us-ascii?Q?WHFQ6SaIF5pFANnwUuWUsZSb4WgLrDvORdlSPPMyqKsGXpSXXZJ5db+hIoDH?=
 =?us-ascii?Q?E3F9LjITd+TWVqrB5Sn5xBU2UEz1d3WlZiUG7w0S11xd2foDdF8A0hUfO8r+?=
 =?us-ascii?Q?RhXcwHCCstZ5aCVrLNXTLBQzVld+QFc3FoBpCQAdRm+YzPsmUcHYbQZegWwT?=
 =?us-ascii?Q?wWgVgvwS7EOgjVJuL/b8l3LSwTQikXkSlHT5/0xGoLfPsajB/vyGh53RyiRV?=
 =?us-ascii?Q?j14kBJFjU8C2wG8GGfcJXXdHkax/rC9Ll2vjHrUcPOurN8h/2S56sjo3fdpV?=
 =?us-ascii?Q?o9hvB3Nsyeu2kZOIqR6NQEfsoDUZTBMOM+LusnhKSUWcaS16yjqbgHh1WIVe?=
 =?us-ascii?Q?IMu/2mUU/bVBesZKvgtg3blHqw8asPYYAYUakjHz3/f6KPmfNjrcBm4d8r6Q?=
 =?us-ascii?Q?Kp7vsjfd/ZFsDywWjgRSnqYlmhfoDhaWplyFF0EASxT9jsyZ36xJzg43UEfk?=
 =?us-ascii?Q?EcbHbDDridiSYduYcZes3Byx4Bi6FQHBYzEPVViyrhi48dQH+mIfEFNrghw/?=
 =?us-ascii?Q?Ltn2RS7oG1Y+XzM0N742kAnqNaYOzCzC2z7TD7fox/CtX6YGOiUaPyq+8hIr?=
 =?us-ascii?Q?jJGY7slMsbUNEYU3Cz54A1X54hhbSGHp118l5Tz52LrwcCk/ZbSQ27IZp1pu?=
 =?us-ascii?Q?9UFfk+o5AIYU00GjiAiZzCRuNRt1ROqJsSb7TSnW/F+LdQQm8RrC4CxlOs+S?=
 =?us-ascii?Q?ZOc0harnCgQzm1RznfBXpipBr9x2fHH58nLCruPfKtncenVnsOHewGbEyTkI?=
 =?us-ascii?Q?caK9Ei9bjgxwTe8S8mR4+aBjQh2c86AEWiU8hYTg6MFIUKF0NX7z5FnSqGQL?=
 =?us-ascii?Q?TMdzJvq3fquykZzpuF76S5+mO/IJtVeQBRzcGDf4z+tKobo9bcBc4GkScLOG?=
 =?us-ascii?Q?kaw/qyKJ9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25b7dc5-33bf-4f37-4635-08deaeb8638c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 17:20:10.9340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJNY/DV9bcu0b/WdNjE6i/P+V9mGvELlSpAey+5KbVdH0cHSzp6DMgMQFvpezQMPuIzbREgIkYMkLU9O67msRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403

Hi Tejun,

On Sat, May 09, 2026 at 09:41:09PM -1000, Tejun Heo wrote:
> Prepare for the SCX_TASK_INIT_BEGIN/DEAD work that follows by collapsing the
> scx_init_task() helper. Move the SCX_TASK_RESET_RUNNABLE_AT setting into
> scx_set_task_state() on the INIT transition (it was set unconditionally at
> every INIT site through the scx_init_task() helper), inline scx_init_task()
> into scx_fork() and scx_root_enable_workfn(), and drop the helper.
> 
> As a side effect, scx_sub_disable() migration sequence now also sets
> RESET_RUNNABLE_AT (it previously wrote INIT directly without going through
> scx_init_task()). The flag triggers a runnable_at reset on the next
> set_task_runnable(), which is harmless on a task that has just been moved
> between scheds.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 10c6e0261f11..81841277a54f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -726,6 +726,7 @@ static void scx_set_task_state(struct task_struct *p, u32 state)
>  		break;
>  	case SCX_TASK_INIT:
>  		warn = prev_state != SCX_TASK_NONE;
> +		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;

IIUC enable path may touch p->scx.flags without the task rq lock held, while
struct sched_ext_entity documents flags as rq lock protected. But this whould be
fixed later by the follow-up INIT_BEGIN on the root-enable path right?

Maybe we can add a small comment in the patch description (something along these
lines)?

Note: root enable may touch p->scx.flags without the task's rq lock; this is
addressed by follow-up patches (SCX_TASK_INIT_BEGIN).

Thanks,
-Andrea

>  		break;
>  	case SCX_TASK_READY:
>  		warn = prev_state == SCX_TASK_NONE;
> @@ -3585,22 +3586,6 @@ static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fo
>  	return 0;
>  }
>  
> -static int scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
> -{
> -	int ret;
> -
> -	ret = __scx_init_task(sch, p, fork);
> -	if (!ret) {
> -		/*
> -		 * While @p's rq is not locked. @p is not visible to the rest of
> -		 * SCX yet and it's safe to update the flags and state.
> -		 */
> -		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
> -		scx_set_task_state(p, SCX_TASK_INIT);
> -	}
> -	return ret;
> -}
> -
>  static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
>  {
>  	struct rq *rq = task_rq(p);
> @@ -3763,10 +3748,11 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
>  #else
>  		struct scx_sched *sch = scx_root;
>  #endif
> -		ret = scx_init_task(sch, p, true);
> -		if (!ret)
> -			scx_set_task_sched(p, sch);
> -		return ret;
> +		ret = __scx_init_task(sch, p, true);
> +		if (unlikely(ret))
> +			return ret;
> +		scx_set_task_state(p, SCX_TASK_INIT);
> +		scx_set_task_sched(p, sch);
>  	}
>  
>  	return 0;
> @@ -6897,8 +6883,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  
>  		scx_task_iter_unlock(&sti);
>  
> -		ret = scx_init_task(sch, p, false);
> -		if (ret) {
> +		ret = __scx_init_task(sch, p, false);
> +		if (unlikely(ret)) {
>  			put_task_struct(p);
>  			scx_task_iter_stop(&sti);
>  			scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
> @@ -6906,6 +6892,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  			goto err_disable_unlock_all;
>  		}
>  
> +		scx_set_task_state(p, SCX_TASK_INIT);
>  		scx_set_task_sched(p, sch);
>  		scx_set_task_state(p, SCX_TASK_READY);
>  
> -- 
> 2.54.0
> 
