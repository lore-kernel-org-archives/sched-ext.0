Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5427455634
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293867; cv=fail; b=dUz3s/n2NT+b3aQ3g8lMFb55gWbt0t+C6MAe1SiObGGx/3X0QM031QnmjrDa2SGaLjV7wEceqDz9pU5ZSfqaZ6y6Q2mBXH3WFDgtVspLNsO9Zr5uRChjGtjM4uZ+ZTYEktbUd9QcWcreCi5iYuj7FmzpW+KewkLN6+fcmXcJDzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293867; c=relaxed/simple;
	bh=UA1yf1wttQnsEA8Y4LmVZ0OODPAadb+BzR4fGKPb8aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C+xm8LByeb9k2yaXR4BDxa1XdPzeCoiAjmoRxcTHVMvyqe+Y+q21oGE5cnccT2I4Ny6yAYFXNORv5Qmy7eE4G5YtIP4NiSIQARI0OoCdGvkTfAQ2ZDVPVYqqrruyFlOrMRm7OSCkRR+zgiRTqxJX+UnTIZPhWGmTNvCEFEZyTU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PxigWk1s; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PxigWk1s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqIUIMuMKhlhnsoVdS2vsTm+eoPOStfsCoYa5Ma3D+Cmc7ktrptm0y7MUyDf2UCfz6Nrdc82TghvS6Rp3PZYQpYB4mz5hnYKpabOGx5GQqUjaDivtZIzBxu/NsQrBiYJkxgpiQM+2WrF241c6BvUNmc9z0ViHs2Txphj8hcykrtaly4cPZaiAauf4vCPRgJIlMdrML0VdpcKDmBsIvg1LYD2XNqdnLhTn8ghoumYK6TiE5pzEWawJZlDds7oRQf5/+BmKo8MKeg7QKBBQea0Ku+3OfCIwcZAOXprqWdYcuCAr6RssplCwnNRXQQu4uXMjrZ0oW65H/I2ybdtcW6Gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws1RlZ3/Gf90MpNAazE3wWACX8ZEgaP6EUyMg09S4/Q=;
 b=Hep0iIaohU/S09mZdIaaoxEBr9mFTPf4HMH3pWkJauFpnyVmU7xLGan1jKDM8mv64ju1kP4vjXrCQywbe+NWbSjBytfBM3tzJbh+ZhD/kMtymKY/aBTj759F/AUl2shQU/B/evEvDFrOfOLZl3+YVGMM3WYXuJwR1+LpuDOKHFO3+hhkubNhbdFc8qae/Fw5ARFcuouiktHXtolZNjZR3hhf11jd725ZtCFJ5eZUgnrjVSoD1Mzlo8Hozt+VoeR5E82XFPIh3I/mfm98O+UWdQB1nUAPhGMRfV2Tb+BnkhG94H5lp23HF+dbsI3UCPPSWv0+o4r5+ekNCSCGG2uBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws1RlZ3/Gf90MpNAazE3wWACX8ZEgaP6EUyMg09S4/Q=;
 b=PxigWk1sRV61sDeSWfRoHGWfkY58ICqfthfQmGjQguimivYj3pLz5SlhF5IcoSRRshOPhR133g6ov9WvF0y3on0Kz0d/F3gQ6sK0agGXectr7T7FfzRb/RdLyGLGxGq9ApI1UXrsOAyDA6r0YtFa/ktr2In7j/spS9utnHZepFz9wc1gR0czk2tNhF4RgKZMOf30AKQ3asG2HIOsaf01TtUGrNYqfpFDMnDnbiHV1szMnsbxMQr2AM9ajwwON2pL5FL1jk5xWoJg0ZcGO3yWsOX0WFN9Hyw1s0aGXWpKToNiyv+PpCrwzT54/57SePqyxWVsxJdpsVM1Iuya0I+SDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:17:37 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 20:17:37 +0000
Date: Tue, 1 Sep 2026 22:17:29 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: Delete sub-scheduler kobjects before
 releasing scx_enable_mutex
Message-ID: <apcy2S-8coGUYrFg@gpd4>
References: <20260901102240.2671888-1-fangqiurong@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901102240.2671888-1-fangqiurong@kylinos.cn>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ebe38fa-364b-4486-01ac-08df086610f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CV5vx374Q7eMF+Jm/Tq20QHov0iJ4qNkOMJXlfxR3aSitN6E8aWNdrlP21BO8T2q0kD81yWH86V8IwXyocMBB0YVCM16nVx6IABbnEGWBuGWTj2MrTb1FXgcHJM29ZbV5/LkT0QrSnU260Eet/GEoDrjjjTHJWouJ3xR3u5DMtR8Tt2pSjQrBXlRS/qc7Ghq28kUftf8iY3jP4VxJCn3qFt+z3qQMrIWheZgcy1ktt19oqvSGJredNvcJLB6bWYYKeDh5LMkJIt+WoqgmG612yHuayZzeHc6ZlZXu4Z0Jk5VFQGt7tDXkHSKvGwo0/pV+OQGtip/JOgKmZd4tjjDgUa3lj6eJPeFxxMhhQH3s9+hCngq+pPIBHvcQ+lRfbLHKuGLG9uIj1jgAP69RO+7Ry7CQMi7A3e585SY4AtvYxkaYP+rogNcAJKuT0RUtS1Bq+GMZPr9vfdyGszi6S8HwAx/y8mAb845KU8EVAMDbsY+iX3OWpyEpGcvPhSuJJNXjtXbKOYdvWRFFYdADu2R73GCzIL6TTrppmuwcxwD4w00KKYu6c7ZPo3HX0/XOocvkxnpjh3LQYHcQwNU0UTK0HqeuZkoDxyqFugWSziQBGh0D92RRRK93i5TLLQl08QFqZKqQB4ha4wLxA7k/CrMkL2YsY2zYovpZEp7f8PtBR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wjp85XWsrwcrqdSaqWRD//+mpWuOzBrEn/gD7/6yAvkZNc64qrVTWVpfHGEM?=
 =?us-ascii?Q?i2BwZwWdHrJjdW9GmMXDzi/GKCITJxBo8yFE63yiarD9/ONXNTIDMj7maiVj?=
 =?us-ascii?Q?Lln1yY6xhJnsLUX2EvBlHnbZSfknC1oyTdZf866uS2PGqs/3QnkVygRikLA+?=
 =?us-ascii?Q?j2cih7StCowHPXh4pMkQ5wJH0rTYwmEVB7wEwQTvs9ahHPr5dh4XvalivJPB?=
 =?us-ascii?Q?MXMpElk47fOfl9uPK2eg50ZoEyRfjpakSxrlnrnBIOveE/ybDF8TPawprdCA?=
 =?us-ascii?Q?w7l6N/AbxIxpGPveLjIK/GGx58hKqvz8EWh/QDLt3RyZsk5gz5SxV/+DfA85?=
 =?us-ascii?Q?2G/HvW6PD2a1DueWgiSa6NZf6OQJuoM9MKzib+lsbLcvaWPEux3czuxdRp2C?=
 =?us-ascii?Q?1xnO81rbmgXT/QGiaVvP7r17RcTgQmW7wGHa96QfZDbLWxePacqW1A7+WtcF?=
 =?us-ascii?Q?6Jl43ZMj2S+rxkns7mJyZjUA7v7/Ln4+Sekc8+paXvufnLfcoErobAlbfqEf?=
 =?us-ascii?Q?8hTHJm2PNRpjY8tCGKUHqtwkZ78PJ+aJsQHU7aFeUJmcQBDdmL/JzXIYH1tk?=
 =?us-ascii?Q?t5xxZxpJifOu9BuHoMWWk3MKcUPD59ov1mjlprdUCdNlrKjJWBt00g2H84bP?=
 =?us-ascii?Q?bvCDzzyhyqzsUKVijJyc7eyxtINk4bzENmF8oBxWPZyR4q6AkpjtJxU6ZXlh?=
 =?us-ascii?Q?PupjQo1fdmuIKmxbRd8GkyfLVp035Hs4Yu0pLbBX6pEzJql2GJtO+OYaaFK2?=
 =?us-ascii?Q?YH53K1pzuPt00CkPh0rKHPGOUf8iDwGGU+Mbzoi9egLgwY/fb7ENTMsj0dvG?=
 =?us-ascii?Q?1u9j65ptqWb3qkfUxxyUROKfpRIm+oqzvHTZNYYhPvJLos4HasvrHO6+qUTG?=
 =?us-ascii?Q?zoKR4XV3fbpigIuk3PfWGddeTHm8tu38e2ECUd65C0Kwejv9CK5vRQRouQSP?=
 =?us-ascii?Q?XG8AdjY3b1n2eAIk13swPgODWnoQZqzOTLrBIHbY0TG5TnPhoBPNCiUZaIny?=
 =?us-ascii?Q?94zPvcLgX+B9V7D8TgkmYj9YDH9hX2dgJcXiAUk3lNtsIZDbarckrJK/QI06?=
 =?us-ascii?Q?fpPymm19iUNhgLrrS5xxYtspGDNlv1i+56QYgHn09ZZPUZbr+nc/MMORdDtD?=
 =?us-ascii?Q?Cwpfb5oEUWK8EKQsZI7UGlUTjghUTgnwucVLXVpFSCh0Z/ZbAcdEf4zrBSV4?=
 =?us-ascii?Q?P6lr9IcTNV2YocHD8x6GwsYv+S9Ir1J+koiKmuNkjsTVOiV4pKdITtFDUVq3?=
 =?us-ascii?Q?2ncBeSS7l8HiSyJRQ3RuKc8Y5wq50eJb1zKu3gOOyFoX/+b2+BTZtPlRtBqA?=
 =?us-ascii?Q?VmQ/ddTDYXWsBmgfypEVgJHuYWdYuZni10tf1hYbn05N5roNi2mgkX3YpMYx?=
 =?us-ascii?Q?92vciIpIBDlW3XOQC7eNm5Z7w1U6a9+6SLs/gLkagFNWhcfB3TGQXG1RTfZ0?=
 =?us-ascii?Q?lXwgbesi2hIw6SWO2uzpRhSZHENW8O+X37jW4SKFmWdmFSMTnkgjdD8Rswxd?=
 =?us-ascii?Q?jzkfgwdUkXBD1qE7MtN831KPo6Oft0eh7DQ1JuXTM4pSK7r4mGK895Sg/AEe?=
 =?us-ascii?Q?x9Opq6FB9qiNd6n3vxCiz6EVBcZeYFa/D6dkE+M54iv17IsiKPiYOb0vvFnP?=
 =?us-ascii?Q?mLrCI1Me1m0JsM9YqmJ0F6IT+mHL1L0dXWxOGRuecalitsDa30XDjWc+5VsT?=
 =?us-ascii?Q?AfZt2g8ErNaJYrXNaXBOLAf4P2awxlwWTtkzgn/UOOEbTcuGwR7xA7n+NX21?=
 =?us-ascii?Q?l6q3REbOww=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebe38fa-364b-4486-01ac-08df086610f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:17:37.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZc+8sGzhW/64vLHOjY5LNhkdNBphEET3Y1wzk5vQl/2HqRSlDGsKTHjW2aont/Isi8y2nDs7iwqfR4A3XYlQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634

Hello,

On Tue, Sep 01, 2026 at 06:22:40PM +0800, Qiurong Fang wrote:
> From: fangqiurong <fangqiurong@kylinos.cn>
> 
> The sub-scheduler disable path deletes the scheduler's kobjects after
> releasing scx_enable_mutex, while the root path deletes them before
> releasing it. A concurrent enable on the same cgroup can therefore hit
> kobject_add() with the same "sub-%llu" name still in the hierarchy and
> fail with -EEXIST, tearing down an otherwise healthy scheduler.

This race seems legit to me, but I think the commit message should clarify that
the concurrent enable must use a different struct_ops instance. Re-enabling the
same instance is rejected by the ops->priv check and a normal sequential
unregister/register is serialized.

With that:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Bonus: would it also be possible to add a sched_ext kselftest for this? The race
should be reproducible deterministically by blocking the parent's
ops.sub_detach() callback after the first child has been unlinked, and then
attaching a second struct_ops instance to the same cgroup. Without this change,
the second scheduler should exit because scx_sched_sysfs_add() returns -EEXIST;
with the change, it should attach successfully.

Thanks,
-Andrea

> 
> Move the two kobject_del() calls above mutex_unlock() to match the root
> path.
> 
> Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
> Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
> ---
>  kernel/sched/ext/sub.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index a17d84db93bd..1923e3023bff 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1631,6 +1631,12 @@ void scx_sub_disable(struct scx_sched *sch)
>  
>  	scx_unlink_sched(sch);
>  
> +	if (sch->sub_kset)
> +		kobject_del(&sch->sub_kset->kobj);
> +	/* not added if enable failed before scx_sched_sysfs_add() */
> +	if (sch->kobj.state_in_sysfs)
> +		kobject_del(&sch->kobj);
> +
>  	mutex_unlock(&scx_enable_mutex);
>  
>  	/*
> @@ -1661,12 +1667,6 @@ void scx_sub_disable(struct scx_sched *sch)
>  	 */
>  	WRITE_ONCE(sch->dead, true);
>  	synchronize_rcu();
> -
> -	if (sch->sub_kset)
> -		kobject_del(&sch->sub_kset->kobj);
> -	/* not added if enable failed before scx_sched_sysfs_add() */
> -	if (sch->kobj.state_in_sysfs)
> -		kobject_del(&sch->kobj);
>  }
>  
>  /* verify that a scheduler can be attached to @cgrp and return the parent */
> -- 
> 2.43.0
> 
