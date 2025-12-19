Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F327FD76
	for <sched-ext@lists.linux.dev>; Fri, 19 Dec 2025 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766185260; cv=fail; b=lzCgZ7GtkGQvGwaoEwi8d98vZoFxJ0HxIhh71AbeA5Y9yF5ot/vTcSZNqMIYhJtSpQwFLBOmII6QvlGl/Zw90iVFyD0VxnXNJPaQPg2K1PD62N9oyies0oqmQuCWHNrO1kES8gpLrbkdK12vGxFeEn3rdYX+b0xNtFzW+okRxjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766185260; c=relaxed/simple;
	bh=UKb1aPlvuUfqrXv1TN64opb4lGyk7O4W0I8ViRWPeuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CPPFg3bBT0nSQ8j4uG3ISH72EO799LAGe3iCSu6JtEaJeWerjMxWOOqzZ0/6UnZc3dsGpOsyC6AIaGeUIkWb/IABwJJqtDjFxWei9ZZoyrxfD3UIaXu/3L8hB10UiT2kmsgO9COcwaGkDiwR+yKxKFsXlV11ilBdgKlFFA9S8S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e7AwWzFr; arc=fail smtp.client-ip=40.93.196.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e7AwWzFr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBbd9oslKItvR9v+DYutnsLwtAR9vg1u9JsfC5wyXgKUKvqFf/IORvQ8woIg6YmHatd79DNfX0roNiZDcsXRj6ezOMa5r2NRkq9aujsG9tFoPVaJDmRWbOlJpo0f7DCAZ673QmwfBRPWX8i9XoAREG50/zRB7NnVbrseQ4hvruXg0+RLrkt4fD/mmNtNaSxbWtzyCoq1h27qDE03MicuvoRrkBBu/eWYYYFZm/LzwdvChQfUiok3TLNaKEWotrU000OCbXO8W9f2Z/7oTWc9eFClSbAETYomkqb1dKtT3IEhU5RjRfV5XthmlBCHSt82HIgsrP7MOy+eHBfatMVuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naxy8gyN255cviXwNCAR5Kptdt7qVfrpfrO3ENyDVxM=;
 b=LzuF6nSDvRv4fJ1gSNP6UPGZxgUHpAqSa+qtdjUlhTO37J2Oj6onD3x8qKmuCNoSMTj+roP4bftDQbC5AFoem8gG51jcqreiuv4l2zTsNJcqzXfB7udwrCHDLREv2ybCk446MYBOuXiZBCwG8KtqFgterIIdu1O+UFRLw2HgFkg2x6ufy3KJ29a0Dk/icWnBy1jx+wWcnNpbLglfZsTScCe/cfMnCgZdEa9uf/LldKqWb8tJIlQFn8sUH+U4jJUPEVDcYRt3g0zI6VDkMM+BgL1aTizrQ6nrdx5pqezW2ZmrypvCubI+1fJUR/t7XbkHoHiCxDLVM+USvj0Nf/6h+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naxy8gyN255cviXwNCAR5Kptdt7qVfrpfrO3ENyDVxM=;
 b=e7AwWzFrH9t8Wo2VoUqE+S/RQ1BuDszCOaQpi6gCZacE9sbMibmb03gWWRjITtnJx4wAvlFX57BQ5NcAFJZIoMVCfv4w3UpIm0kzzcZOsuVkIqjiz+Y7esVJuVbjimXxX5PiJb1sj00E+zDcKzkfj+ZrJiLTkCRTk0eKuvuMp6vp3jyRxH51GqdSffDH4N7Ig+g0HrQwxUd7n4euHDENqpxKWqD/fCgoq9bbuhkpW5H3Sp1TN7POMI6kKRb0LlBsiiH3tyYAVBgCnWj99Y9UGXNJZ4UsAEyFcza2XjkchWRtqKN+HN2SO1UR1OvltBurEzptGNHt8UM+VM+LRzmKFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPF9A76BB3A6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 23:00:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 23:00:52 +0000
Date: Sat, 20 Dec 2025 00:00:47 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix some comments in ext.c
Message-ID: <aUXZHx1Hzmp7xksq@gpd4>
References: <20251219093404.382-1-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219093404.382-1-qiang.zhang@linux.dev>
X-ClientProxiedBy: ZR0P278CA0106.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPF9A76BB3A6:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df529d7-f381-4711-cd86-08de3f527558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ks1qveQkSmqH3t7e70u0MmnMIdTB1H2poFPMNmL7ECvmUvs+YHF3xCCo1/49?=
 =?us-ascii?Q?YsuwxZz/d2545EAqp0gZC3K7bpjmRwoi+xkayP/hGih/VNPhYihBz2id7F5v?=
 =?us-ascii?Q?1XuJC+Oqiyuqmx/e0s/DIEozrh39EameATkYTd1byhcw3f74ESg6UbUCBgAW?=
 =?us-ascii?Q?7KK1Jr9oydJ32HfDeznvtSVZjcGqqI6uwSpcfIs4BEzCoEC1ieDndi8A36Fq?=
 =?us-ascii?Q?X+k8AZmjMm+MNe8FSYER4i/eXCBDU515WWAV4R96b5lV1FZsebREeqxYb9tR?=
 =?us-ascii?Q?L3i5FDkAIPVsvkSrcrvHh/0K2HRcg6kxL+N6y6yXeAPgU+g+pNuyS02LE8p3?=
 =?us-ascii?Q?3iKILMY4uyk744DYz3QfVsud8xVZD6U2kCnvWLO9dWE1KXrnF6ZQ369Kymhh?=
 =?us-ascii?Q?V9zu2MzfgEgFUaRiFwhd3fUT0e26c8r610q9OuJHgMd45qJhWDNPDnxLTNX3?=
 =?us-ascii?Q?H7McGlKHZ4sBG5NWw5x8N8MYXQMNt8iG4CvA40fFe4F35mxtS9W6okDL7Epo?=
 =?us-ascii?Q?ZLiAlh2tNQKCsgSWaOf1tYKnuzAiMGKa91ifqw/hXXDyrKt+JwcZYSsuzSwB?=
 =?us-ascii?Q?Tqq6iTAoOtV2v/DMY/XpHs4yWqozLsqr5l+SJA4CNMQht11aS0+1peLSa1/p?=
 =?us-ascii?Q?z6aDqvO+v91hQE5p9KSWErf7ibn0PKMjzlR72TXdeKIxK4+St7Am2g3HEt3Q?=
 =?us-ascii?Q?b9i+BQof80RB9dMvQJy+msFRlWhihb9/IHkcou9zRyGLJSUyWdfhywksC8/Q?=
 =?us-ascii?Q?RZo+QQxTZ930qHbdihGGVZeOiGS7UggPnXQbcAr1lA6btWy0fyWbcm+oo1Rj?=
 =?us-ascii?Q?zB5ieeKAI1ABB7nwM/ogjgP2TuqxpbStSMd1P3hPMVQJ3OgS0KeDsP/oeWLL?=
 =?us-ascii?Q?tclIo+Bwezo3C+78nm1vfCuZ4S68vAXqmvex4V67hn7i4TEnsACUlMJ0wcRw?=
 =?us-ascii?Q?Syo47645zvWhhfTBiH9586OmKP2fwDrPZRGD1vQSZcxEv7Gj5C0jFWB2HobU?=
 =?us-ascii?Q?KzInh9ru8Ngzvo1vr0Y5P4RxCs7MoG1lOMSjBWeqMfzAu/AtMGNwWh3UAJPh?=
 =?us-ascii?Q?4qKB+KiBFXDPMZcIeaPxm6+aS+A2aMRYgb8KCWJGHD0vkRnADHhkSF0J8EHU?=
 =?us-ascii?Q?9qitvpfP8g4ur9V35KWEJe7C7Mby/xrdekca9zI4ZndOc273sDaemRqQQ6Qi?=
 =?us-ascii?Q?r6uZyiBIyMXCZ2rd1OHACsqrYvjtIiO6qo8P0FUuBaMalpg/NDjIC/qpZevi?=
 =?us-ascii?Q?7LQiY2K0/cRzOfvTczLVFz+9a7gdSBW0taEUMjKxXp31ZqksRuDu9AuhF+8c?=
 =?us-ascii?Q?jdWHYp+m0bTEWy/W+OP2H87GHQ0tQN9QRA9zkkuj9F/PjwwIcjrzGRGPV2pg?=
 =?us-ascii?Q?NZrAS46gCoSRw3S2cmuWWhZfIsXfDVo38ZbcJUS17yMjdfo7wfvSEf/AwyP7?=
 =?us-ascii?Q?PpRTP22/wc6rxw/jlrxG8FcyLAx/Gqjr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gk8DoPxcoUn22FU4l795uvkIPHz6/TQDy33KqYMR7fJ+ocLyWR7nhM0/y411?=
 =?us-ascii?Q?hGHbDoy6PnrU8bUkjuR7qN2Mv7Uj+R4TDyiID7kCiiXdzw4VT+sAzBOLb7kN?=
 =?us-ascii?Q?MET/1nYcTqloXD2azA0zGjwyoaaH5koCPYmT6sxRL1oDmWiPE0nncLF7dYHD?=
 =?us-ascii?Q?WAJVmjnkMByx5DolTUu6EHPZNzDPydfljv9nSGNPXi881s4RtIpZv81kIjVG?=
 =?us-ascii?Q?afWp0cakfAD3YXAbyEij8yTUuJGGuT5v6kHa9FsNabSUjE4At+zslH3+ua/6?=
 =?us-ascii?Q?sdECYslhMwdloR5+cuch6OhfYU6Ui4M+zQmdzKTSA9n+E2z1GL2nGeCqNqkC?=
 =?us-ascii?Q?NkU80dBtByKTV0WzkUzAaJ9+9EiHJvFz5du+wOO7TFCaVV6Fnl3n1ntSTlbh?=
 =?us-ascii?Q?r3RRIePhGQNUUZxaev1wuuzDyzOKdLZCNtWtBLVSXJo0oEQn+z+6Sp/LNec4?=
 =?us-ascii?Q?IZvJOyxnqMUaM/mhj+kMWihi2QlHfT/FTXjgcN1hcHG6qqM9M3X/bZ5KCuTJ?=
 =?us-ascii?Q?6x2BTHYtmu96XTNsTdjHwJna52+fkLIQCwRVzGOv0A09TtWgCdiMYeP9uVWT?=
 =?us-ascii?Q?wm4s3pGuqn/LPDQe3/IsO7IisPZO5LrpPJ8UuBZcvr9xxH4bO+acuHrarUJU?=
 =?us-ascii?Q?cmw+/FvdMGQw3bnyHKptlqSketUMjOKwuriQnbjUdsAyfB09bMo2lr5PJrJb?=
 =?us-ascii?Q?RM5EqyBosXudqRukqperJs7367gpIi8zb/6J0EW5rdrKn98xm8TGNNCUoeeE?=
 =?us-ascii?Q?/18motAWZwJ/Pn0lpAsiUW0LEaU+KqJe8qhwnaWvPrHYqFI3Ho6UgR6EAWcd?=
 =?us-ascii?Q?FH/QWfRf8zJs/xxaVlKMygP19cQg1wxgy34DQ1jgPWd/LTH74eC2Zxce4pao?=
 =?us-ascii?Q?bKXVIVqOwBFQgi7keyvoYe21IHiutREDlkuda9+85RVZ3iq3uPvYxcp7Xpkl?=
 =?us-ascii?Q?eG4Z+ABm4aoQYE8tNv7zu02u9G6T4hjn/D1gKOesL/GpOxrGUcHdkC1s9xAH?=
 =?us-ascii?Q?4R8mvwFV0UWnPe4lmhgeDeIJIcrTRuTbd46lIDaV1dWRC7HYpJgN76A+FB+G?=
 =?us-ascii?Q?igR5ZzKa5vxOLdlG5jBkx5Mtray1KpCb9tnExcNHTIoX0yQxCIoEymajReuo?=
 =?us-ascii?Q?Fn0FjowROCr1uHt0YIglGQjzr+sNfT+n/FvHvrIITbo3zSfLgK/IVGL1jgQh?=
 =?us-ascii?Q?scgnKLE+ZOOomhOGa9ijAc30BuiskqlG4wTPg8r8MiR6j/nRvYFnN6A4NKtD?=
 =?us-ascii?Q?BXqkjTKMRv/N9+t+1UGn21aRjjhQUk0lwdTL/29vNCIUY84UWHo8WP/36p5z?=
 =?us-ascii?Q?O2u01YWmwbLyPvnNIyZdf7EuFuW58mGJoRNtKwB+2fY7JEq7urS9Vhyue5vO?=
 =?us-ascii?Q?nKzY2zmypdB0s3/3HfKYgHDuSSHNuKhGmFKXQc8DsJnJm9sD8s7DT3sBbltn?=
 =?us-ascii?Q?J0diMhBIGB32Fuf673jUUyL8PrSTDaVDVYBnaHzGU7ZSSixSQGKEc1DQ2px7?=
 =?us-ascii?Q?xtVn+ePthkOEb+5OsOA6NvXDPD5Ay733DmVdCJBbQz75gSC2ek5mTY9tbnvR?=
 =?us-ascii?Q?ktMuk2zSLtXvM7cnWbraNyl1F6CxeY/WpF1dKuTEHRHcD3HlGTIvwN4XHvmx?=
 =?us-ascii?Q?eW/m2ebrdZjitiaC4RiA2piC+7gqltqX7qHahYqLo+oZEM180msK3ooHfTo6?=
 =?us-ascii?Q?FrX1QrUkk4wuWipF6aRQ03DfRFM50bBFESYLM82JRKLwQNr36+prXyqQEgOH?=
 =?us-ascii?Q?4AScVQCxbg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df529d7-f381-4711-cd86-08de3f527558
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 23:00:52.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQdbQtpjwGkV9Vh39iYeKqq1QF8lps/SsEkov+yXje24JL9fvmTWG376csVBkQNLOwoFmvdIDiVY9uQA20idmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF9A76BB3A6

On Fri, Dec 19, 2025 at 05:34:04PM +0800, Zqiang wrote:
> This commit update balance_scx() in the comments to balance_one().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Maybe we can mention that balance_scx() was removed by commit 4c95380701f58
("sched/ext: Fold balance_scx() into pick_task_scx()"). Now balance_one()
is called directly from do_pick_task_scx() and does all the work that used
to be handled by balance_scx(), so the renames are correct.

In any case, looks good to me, thanks for the cleanup.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> ---
>  kernel/sched/ext.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 7a53d1cf8e82..5ebf8a740847 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1577,7 +1577,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
>  	 *
>  	 * @p may go through multiple stopping <-> running transitions between
>  	 * here and put_prev_task_scx() if task attribute changes occur while
> -	 * balance_scx() leaves @rq unlocked. However, they don't contain any
> +	 * balance_one() leaves @rq unlocked. However, they don't contain any
>  	 * information meaningful to the BPF scheduler and can be suppressed by
>  	 * skipping the callbacks if the task is !QUEUED.
>  	 */
> @@ -2372,7 +2372,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
>  	 * preempted, and it regaining control of the CPU.
>  	 *
>  	 * ->cpu_release() complements ->cpu_acquire(), which is emitted the
> -	 *  next time that balance_scx() is invoked.
> +	 *  next time that balance_one() is invoked.
>  	 */
>  	if (!rq->scx.cpu_released) {
>  		if (SCX_HAS_OP(sch, cpu_release)) {
> @@ -2478,7 +2478,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>  	}
>  
>  	/*
> -	 * If balance_scx() is telling us to keep running @prev, replenish slice
> +	 * If balance_one() is telling us to keep running @prev, replenish slice
>  	 * if necessary and keep running @prev. Otherwise, pop the first one
>  	 * from the local DSQ.
>  	 */
> @@ -4025,7 +4025,7 @@ static DEFINE_TIMER(scx_bypass_lb_timer, scx_bypass_lb_timerfn);
>   *
>   * - ops.dispatch() is ignored.
>   *
> - * - balance_scx() does not set %SCX_RQ_BAL_KEEP on non-zero slice as slice
> + * - balance_one() does not set %SCX_RQ_BAL_KEEP on non-zero slice as slice
>   *   can't be trusted. Whenever a tick triggers, the running task is rotated to
>   *   the tail of the queue with core_sched_at touched.
>   *
> @@ -6069,7 +6069,7 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
>  		/*
>  		 * A successfully consumed task can be dequeued before it starts
>  		 * running while the CPU is trying to migrate other dispatched
> -		 * tasks. Bump nr_tasks to tell balance_scx() to retry on empty
> +		 * tasks. Bump nr_tasks to tell balance_one() to retry on empty
>  		 * local DSQ.
>  		 */
>  		dspc->nr_tasks++;
> -- 
> 2.17.1
> 
