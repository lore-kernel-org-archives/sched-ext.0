Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A52080C8
	for <sched-ext@lists.linux.dev>; Mon,  1 Dec 2025 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622282; cv=fail; b=THpVmcrcORdUxMzoTEKvwhuGQZXZLvPLIvvhKlCDw0gf86PMxUfuE7fysWJUC8h+lDYUFdhK/k1DYvHtyDJ5zX2BIdsFmSh0T2exd+GpWJJ22cBn7zoPjqi/9wwQ1R6QT9IFRG0AoLrSjXV77ioau1HGWZ6QO4p09NgWo29nbKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622282; c=relaxed/simple;
	bh=6/lZCi2G/hrlsCe1REmyZUmT2liGa5ya9n/bSDurS/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rv30eiHpfrWlT0VLw/iMCTAwsUgEIzTHSaVzyJBaa3qIFrR3pXfeK/4MbItW5CbLQrQyihYiJajoldbV7hG3BjktnZJLA8UWYWt3i94Sm+oTNbUWUtHspg04HQapghs2WJ/vXbfvFOUHjYZXSiH6s8UmG5nhcyaUk3N8x4dF60Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U95N3bO1; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U95N3bO1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5eY0wCJeJBJqndcbzq+XmLrXxHngxF1p6wzfbTUcX+Boov0xe4geixnLwq7/LLP8NKjpg4pcCKHnP3Aelggcc01YcJ59jrPt5I/KRTs5DheoaaKEklp1SB3/cR0zGBT1O7T4mIGpEO69IXOZTuMTcb62R62zIg9OI0lcUnKfhvW7UgDTn52tPw4upDx0jnxXIdSvOqFeaNehoN6BGM56+HLDiaDWAvS5w4qRqAfLBGPBmp0P6SBCXHucw3EfwUkbSfFjKsz1+q81t+35TDCKex0zM8OaYTIvYSvL5krs3tuMrP+nqt0TdSbz47HPHujW7xdgUlbbEcL3rbV+fK3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSPWIVSMkVUcrp+y4z76b2EXcq7xuEmC5ypqDN7zoSQ=;
 b=BMsylMLjl3H31DF/tU4DWpxY5QiqbVOAjmYOWInM6TCDfEAN3wSdXle1PxtRogSuXbPvg9yQnb218S9F2ZUqEniC75ljOTVY71mqKnFXczpgdda0HolB9PZkOu+5EoQBWmjZphCl2ybtFFHEMbaNsB3u3yU1kkiufsLWFZqFHA5cvilYe9hSD8hCofqQs+F0fB1jlp8taVN2bj012SXOGSZiZIzGas6kmcwpxsVsL99uupyW4uPzvUzPklw+3B8oRi22hZWh+c8h92AZwDF4CD/V/0BW8WUuoJ+wElw2RIxaer9TqNS0I/t5j5ITSIBUhY3eo5R9G0qP0ybYZKO5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSPWIVSMkVUcrp+y4z76b2EXcq7xuEmC5ypqDN7zoSQ=;
 b=U95N3bO1Pi5ZD46+7PXiY198GV3LRvgMYC8yN11z+FBHF/VJSNPrijZVfdRSbQ9etpPyMQsZH9SrXJ/F1ZwEdI3+96ERWHOXuPvPktJkSzsY43/h8auy4Q2wiUccwYcn9/wV50cfcqutPx3ufZ4ya1+aCbkvJqW3ZNcC6RSUUVkS4cId6ygWbcrkFV71OwIxNbL3WmC7OEKbfZV2WEZQqY+HNQDPWJPyGkp0uPfenAKPNh0iYEaaOY6QKqVAkMd79w5lqxQKJ4v11DqyxAqwvrdU6xTrDCmyl5DXPBUzfDcKlROeNNa0PrvFINpI3135T1EjzZfTCQMtvKTfjkK5hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 20:51:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:51:17 +0000
Date: Mon, 1 Dec 2025 21:51:07 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix incorrect sched_class settings for
 per-cpu migration tasks
Message-ID: <aS3_u1upYCkb3qzT@gpd4>
References: <20251201112540.5119-1-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201112540.5119-1-qiang.zhang@linux.dev>
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 46aa4144-afc3-4172-60e1-08de311b5f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pAZZF2WKd1xAhi4fAhoBRBNk4abk5+AEr4hbBcIgUIJ18NpUwhxyQej4JCgC?=
 =?us-ascii?Q?pHU82ndHaMsLj2dro8m0zB60OsEdqkmMjekcXFIJpfWHv6AQPgVhfAdaNm5c?=
 =?us-ascii?Q?d79MOcDd3yK1OQ79eWH/a9pPu4oVFb0hqhjrSza3AUhtpuR/80EspTvK7IYZ?=
 =?us-ascii?Q?OJgUakcPFjpa/bSBLCu3x1XmQi8fh+9sOe+GDpGlUYWBG2TTWeA7y/9Loubh?=
 =?us-ascii?Q?28iP1OYmhYHCZPclFaOHGwfmoDW28uCJg8+JLD/8g+VfSyJtYAfGL/R0EU3+?=
 =?us-ascii?Q?DoF1BUYhTizuqZaXVGOlb9Ch36Rz1BvzMzR4JkLHFUR6kmknEZNOr4G+E+u9?=
 =?us-ascii?Q?bpcBublakQy3haLKUsmEz3TvwtjWT5eyFJm30FqdesVmHJQSJThRUpw9dLDj?=
 =?us-ascii?Q?gru3yt07Zil84YbwyiYMKS2lYz1rfhC7jbYk/NSC97Knkc2kQOE5c+ZlLVZ1?=
 =?us-ascii?Q?UqX83E8NdKa7T+MwUUxQG304Xr6mKiujJei8PxpFZf9Gb5Lc75wfLaOI3hF4?=
 =?us-ascii?Q?BWyttwm4hnDnqWvmbIooT3spsSFlWXgk5SHODEUNhMubfi+aAZn/d3+VLX18?=
 =?us-ascii?Q?pUSsdlo/EeoQCN0rZjbjF5gCTIZ2Pm8mvU62oIZ9iSYjDIjrRn9NnxjOwfKW?=
 =?us-ascii?Q?2lT39SoHF74Lhr/REbff7Qap10iWwij82nQSAoiinc31en00sl7qYitbqO04?=
 =?us-ascii?Q?uNhquCQrwWacSooRiVi1bkp+JADb9oW9d9N4pPeuZ2rAwy8DmAf7U8r5bs5X?=
 =?us-ascii?Q?+FuUMih7BUQepzSEeeXphcNd5/ltpyHLbGbNwCnMxjplsEwVjuKDG0S/DaCY?=
 =?us-ascii?Q?yKwUMKNiYMbw9xDBQtkcJQZ0rmvqFuvZeMWDaVdLX4/v0GqhfJ5ov7Ml4jK0?=
 =?us-ascii?Q?expBvU8gNTlCOVlRnS5ZH8C0Jnhxok5gbLcKsLi1eIFRqiUrTeRbqggBOxM1?=
 =?us-ascii?Q?R2osgUCc7TZtnqPpuQgBJPMkOW7n82B9ZSXUgLt9Gyxao5ha/qi9xAIIPxk3?=
 =?us-ascii?Q?Jt3PSlQDILO1s8lxqGZe0lHT/qIIICmGX/+4JglxQ4XzT72NxhWeubnEzt04?=
 =?us-ascii?Q?96ITLMjYfUE05miZb+zXu0IvYWIqi00OMI6s4R9Ct9BMv15fmN/HNiBczqxE?=
 =?us-ascii?Q?q2IK424bHGigdmWwXBIxBtYHg7GjZ0ywixjUr6yWXVrdNsh00b/GYvBuO0dA?=
 =?us-ascii?Q?rGQLftqrZjkYjYEQ0oYNDY66K3AScqYLQHZRWaxr9zUR2U62wPgGeg4Nqnjm?=
 =?us-ascii?Q?sN2cI7kTTwO7mAy57Z+SCrJnQJ/P+5uAog2aFs4s8vgQEozD8GX/VfOr5Psz?=
 =?us-ascii?Q?rzpGmzQXwoNKzbRy1iE2F/nXXRmRH+1G2/fB+9owKIZ9YLz7zkQi5nqP7QS7?=
 =?us-ascii?Q?o9MaYiTVUCxiacUe+KcxSc+VdfK7Tua5poZOb9y7eNeL6lliCpWSD3ePY1b2?=
 =?us-ascii?Q?KcruYEpcB8nsjzNB9QPjv99kBMtNN2sp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7kSprgKbkPHAnPNmyovb283Dm5qKr0bxYqFPTI382buU1b9zO1TykQW1AXQs?=
 =?us-ascii?Q?u7xIZppZyG7tpqF4iBQUz1xDqq2bedrsO+lavUdL6+ljjkpG+KYOGnEiMZSI?=
 =?us-ascii?Q?7GYCwXCIYwuPAjtv38zAvwK0lAs0+wLyrA+FUQQUTIeBh07O/ohoIFyN61M1?=
 =?us-ascii?Q?UvOyS1rRctFR3yF7dpcyNXd9R3U6YQpwL/wjknRwrwNCgVYN3xWHk7pdHNID?=
 =?us-ascii?Q?bxAHQ+kMMsD14esquW9w/2/U1Zasfvnsr6M0AXY3+OxVGVBwU0AsySnKL7Zy?=
 =?us-ascii?Q?beKOT5w+mE+ahnv9KHNcM8RmtPZL9SBLRTrvrqSMY4sL4v7Ln2h/QGgR/kB5?=
 =?us-ascii?Q?95fSnhshEoMOM65Tdgffn3BOumquBOxgdTRd7+5mPIxbvrjmBvIkSNnSc8In?=
 =?us-ascii?Q?FZWxHBBVMs+CUWxcm4xSl+nwcgJgQJKHbuzxyQjN/YWFg0n10JEKGOzEQClB?=
 =?us-ascii?Q?cvUsH9FCyZJOFd+phKecZH+kEofT8Er6W/9h4gDf1l3lTfYixeA5ZNlZDA0D?=
 =?us-ascii?Q?QS1GOz0yd3c3jqKHO+I3u8Ssu7cByNoIazNIVioLe+ydERuDTxy1A1OMrFvN?=
 =?us-ascii?Q?dFafQEJpiOEYBJn4Xy8djGJb6w1pPtvmnyvOQXOTCY80qKcvyhjE+sxr1uzj?=
 =?us-ascii?Q?tVGCeWDb2I6KeAshXRcAnUV0a/3Zjry6blyQbF2eY3Alo4yTxpqizagWx4KQ?=
 =?us-ascii?Q?V7p1HOi/E+G8k+4O26I+HTUNk5agO18eVr9BZEjxZRB93BfgXSls7QGucSi0?=
 =?us-ascii?Q?59MAoXlVIUuyhcksVLGUEwL+8P4Y0AfO+3NT1bAcrGXiIgnlDhqD9EDIwHL7?=
 =?us-ascii?Q?meOvE6RU1rn76Oi9XVDhcxvDdyTt04noZKwrzgQ60qRYxZ1achUZlJhmkjBW?=
 =?us-ascii?Q?HisG+ypstfoDrJj1aLxlYywNZhVFSN9BygzNUOQSie2ax7g2MAK99TTxc6MH?=
 =?us-ascii?Q?nVdedctvFYvYl/OpzQOgIMjYLajk1HJwcEJw0/7dVQnnoKgB8FNbQiQ6N1vf?=
 =?us-ascii?Q?EI/QiXmJz14wmoBB1FYdG/q2jY9myhp8CI/hRQvrbrfJY+O8U1iInqyrVWzd?=
 =?us-ascii?Q?cpGrrynyTBc4Uq1ummVHdU0LZdCWeh0yVE3yTOWBthObpAXdFYp0DIX4F7GM?=
 =?us-ascii?Q?Cxg6K2j81XOFmRsKfAMB+oyDIjCENif8mFss6hQdGIlJirINRiHiSqw9iinG?=
 =?us-ascii?Q?Bn2e9+3CNF8/eYyDFigkOuLfZU8bnaUksd3KaXaWlsgo95/u25kgMdADmb2j?=
 =?us-ascii?Q?tnwuvtXIiNTJ4GlNY+nBE9rj9MYYfMYI3XFoXJnlPjwZOms6riZgUzOdWpBp?=
 =?us-ascii?Q?UULRYZfqbgvNSpgxjd89tQlChBdf6zfE3QAlMfL7XygLesPIQChVttwa5CqA?=
 =?us-ascii?Q?5k3ZzT+gBr2RnXNhfSFIiIFHQ3by+wAMUoYO7dIHkqUbk5qZJPYdbGLQNufk?=
 =?us-ascii?Q?5hzA2ROYPvfd34DHhfeJ9D6M6hRuJ+6z2HFildWj2UdTGqpeTSHlO6GgCgQY?=
 =?us-ascii?Q?4dErLgh0JFvT0p32T2csr7kdhFWM+27AG5cv7HXWSwcK54cR7tSbFCioDZsP?=
 =?us-ascii?Q?V28tlpdj/GHsk/uWA2Y3Ar97WFCsJtwUjr/gQIfj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46aa4144-afc3-4172-60e1-08de311b5f84
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 20:51:17.1067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7qdfYx63OQcnCzt04GzhqXyTYRNuLZg84VvqCpojxjc3/goOR4F5fxI8ihLpzfLiSEFdMAK8u3UrlcR9M+rnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707

Hi Zqiang,

On Mon, Dec 01, 2025 at 07:25:40PM +0800, Zqiang wrote:
> When loading the ebpf scheduler, the tasks in the scx_tasks list will
> be traversed and invoke __setscheduler_class() to get new sched_class.
> however, this would also incorrectly set the per-cpu migration
> task's->sched_class to rt_sched_class, even after unload, the per-cpu
> migration task's->sched_class remains sched_rt_class.
> 
> The log for this issue is as follows:
> 
> ./scx_rustland --stats 1
> [  199.245639][  T630] sched_ext: "rustland" does not implement cgroup cpu.weight
> [  199.269213][  T630] sched_ext: BPF scheduler "rustland" enabled
> 04:25:09 [INFO] RustLand scheduler attached
> 
> bpftrace -e 'iter:task /strcontains(ctx->task->comm, "migration")/
> { printf("%s:%d->%pS\n", ctx->task->comm, ctx->task->pid, ctx->task->sched_class); }'
> Attaching 1 probe...
> migration/0:24->rt_sched_class+0x0/0xe0
> migration/1:27->rt_sched_class+0x0/0xe0
> migration/2:33->rt_sched_class+0x0/0xe0
> migration/3:39->rt_sched_class+0x0/0xe0
> migration/4:45->rt_sched_class+0x0/0xe0
> migration/5:52->rt_sched_class+0x0/0xe0
> migration/6:58->rt_sched_class+0x0/0xe0
> migration/7:64->rt_sched_class+0x0/0xe0
> 
> sched_ext: BPF scheduler "rustland" disabled (unregistered from user space)
> EXIT: unregistered from user space
> 04:25:21 [INFO] Unregister RustLand scheduler
> 
> bpftrace -e 'iter:task /strcontains(ctx->task->comm, "migration")/
> { printf("%s:%d->%pS\n", ctx->task->comm, ctx->task->pid, ctx->task->sched_class); }'
> Attaching 1 probe...
> migration/0:24->rt_sched_class+0x0/0xe0
> migration/1:27->rt_sched_class+0x0/0xe0
> migration/2:33->rt_sched_class+0x0/0xe0
> migration/3:39->rt_sched_class+0x0/0xe0
> migration/4:45->rt_sched_class+0x0/0xe0
> migration/5:52->rt_sched_class+0x0/0xe0
> migration/6:58->rt_sched_class+0x0/0xe0
> migration/7:64->rt_sched_class+0x0/0xe0
> 
> This commit therefore generate a new scx_setscheduler_class() and
> add check for stop_sched_class to replace __setscheduler_class().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Good catch! It looks like we had this since the beginnig...
Maybe we should add:

Fixes: f0e1a0643a59b ("sched_ext: Implement BPF extensible scheduler class")

In any case, the fix looks correct to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b40d35964cd4..9447fada0050 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -248,6 +248,14 @@ static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
>  	return rhashtable_lookup(&sch->dsq_hash, &dsq_id, dsq_hash_params);
>  }
>  
> +static const struct sched_class *scx_setscheduler_class(struct task_struct *p)
> +{
> +	if (p->sched_class == &stop_sched_class)
> +		return &stop_sched_class;
> +
> +	return __setscheduler_class(p->policy, p->prio);
> +}
> +
>  /*
>   * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
>   * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
> @@ -4241,8 +4249,7 @@ static void scx_disable_workfn(struct kthread_work *work)
>  	while ((p = scx_task_iter_next_locked(&sti))) {
>  		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
>  		const struct sched_class *old_class = p->sched_class;
> -		const struct sched_class *new_class =
> -			__setscheduler_class(p->policy, p->prio);
> +		const struct sched_class *new_class = scx_setscheduler_class(p);
>  
>  		update_rq_clock(task_rq(p));
>  
> @@ -5045,8 +5052,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	while ((p = scx_task_iter_next_locked(&sti))) {
>  		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
>  		const struct sched_class *old_class = p->sched_class;
> -		const struct sched_class *new_class =
> -			__setscheduler_class(p->policy, p->prio);
> +		const struct sched_class *new_class = scx_setscheduler_class(p);
>  
>  		if (scx_get_task_state(p) != SCX_TASK_READY)
>  			continue;
> -- 
> 2.17.1
> 
