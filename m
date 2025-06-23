Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9ED155CBD
	for <sched-ext@lists.linux.dev>; Mon, 23 Jun 2025 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660961; cv=fail; b=ZiL+bX+uFug44O+59ey4HZc0cTV6bFJze+hZxHkBkRwXV4HczblA/FXTsszSf23zxhXwV9G0dPvugKHJgQ/edYQukn2AYg8jJzP9IGc6FSUyVMZAKukHY63EsNCTXILFEuOoD+P3HNq0cMcRgZi2ecg85zkW8rz05+qpLTQ2EI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660961; c=relaxed/simple;
	bh=JdMBn7lVZv+XGbIVtyB447av8XhKsWXq6BOGtWaJvUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ujpKUD2/oUNHrDO+M2IIR9dZrKZc9qiMvTEqFQZ5uuAdcYqnT+u3eKgqvUJP8QICWfZAMq0eTlzjlyO7+Fz1p7+nB48GI30GsxaXrKp2MTWOzJ0oXSQX16+xrL6Bz70G+L1N8GWxthV2eiB3iHyNsoRVVFcI36kq9oZ+6USsk1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZGpeZs27; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZGpeZs27"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEj4KtDDKHe//F1jPH3j/L3DWnqopNNyMxPlZSqh2Ea5P6ZfRQGSzIvluf+T5LGWpHygcPKeaY2B38l21K1TLf5O2oKNraqfnOV2bWMgjKujJZf7rcfTpq97wcoSpLaFOsuRj1D6Mpt17q5RRuzTrYN4n2p1opXBqUNCz9RnU+I/JkMET+c4VFMdZXh1Se0EciGOViQZCYIGozSORIbTVtpY9uOaYAo0gkefrl7xbh4IST+qY/y0J53CLOSCYylKQp7bOVaQZxW1rP5dNgBkTsrEQW9JCUwnx90yWulajp5HEInyZIA69r3AyCh86+TXYFLdy9YyoYG7K3fKfdRINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgVxh+C7GzEhTSm3rBXnUztCvWagLXoQ8FFcP87dSXw=;
 b=Ji47qlBuSqykR8He1W/MxmiIlzrTUtKrMaeXmpse57ZQF6HFKCqgCJ81HIfxMuzDLrTNic4Mdi+XoihIS7Z6l8JH0kvwKQMqoXHFwRfOqqZ3fPA9iF6UHQyMFOqfHzDhFI+4ord/nXPyk/B9QqY9Q9tS2IjbeFX9RHfuYacPeyRUYxpUM0b+v+F3v9lUUQkepwXg/n234QhAAYJi+WyaWy+S9JgAMtzNEKa8X0zT2PLKJlm5OizTtuV/kssA8Z6LSa2EnhP6nmtpkIZboTC6NdJ0/Uwbe7vYGo/Bf8is2e/KbvQnNhPGpLBDlzp67VOL3A/2/xpFKhdTNDN6zzx/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgVxh+C7GzEhTSm3rBXnUztCvWagLXoQ8FFcP87dSXw=;
 b=ZGpeZs27hSlKtD+QX5UFnfZ4Gfcbq/21XtAXMgvpu0kleEBhiM0SIH1oHbklrVn1vwhE67nlldH0NZiBDIkAZswNIKWXcmlr+AgCabJgxulPEsO/6HdTd02OAE5PoQh//xRmpEWdnk+aJe77Pwut6SoWWiMwEc3kvlKESP0XGdbTcckE9rn/GZyCbpGxCnrTxDwUUb5UZkGOoS5qzf/ynO4ueZ6lMMk3jIDgDk0XpZvkNq/jiD6IJN8P5M//+ebgLQpS1+ziHMtn+yEmAGH5jRFcHSoj7FxfPg2WT5tXBL1YaxE5phVZGSL4ItonWB2yIC1j3sQC+/SgeGSsILVjFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.38; Mon, 23 Jun
 2025 06:42:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 06:42:36 +0000
Date: Mon, 23 Jun 2025 08:42:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Henry Huang <henry.hj@antgroup.com>
Cc: changwoo@igalia.com, tj@kernel.org, void@manifault.com,
	=?utf-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>,
	"Yan Yan(cailing)" <yanyan.yan@antgroup.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v3] sched_ext: Implement SCX_OPS_TRACK_MIGRATION
Message-ID: <aFj3UWs3ZtEJjetH@gpd4>
References: <20250623063033.76808-1-henry.hj@antgroup.com>
 <20250623063033.76808-2-henry.hj@antgroup.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623063033.76808-2-henry.hj@antgroup.com>
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 897dbfec-42b4-4d26-c9b9-08ddb2212390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mlEQy3TA9/h4NCaOpeJUf9gXDFWEEyauLpid7oLOaiseanzpS7PKtSgmWcM6?=
 =?us-ascii?Q?XT7lKYLgbd8Gxa02OLS9wkL64NKWswsT+lrZl/lfEoV/1xoWzPUhKF3AlJAB?=
 =?us-ascii?Q?ETlSQjOWR6xdyFgERVQ2VvW1um4FFjIzSiHnR3MTFEQjCl4CgxKWsD7NvlKT?=
 =?us-ascii?Q?aDR4Vc/aIAj6/p7ALqXPMriBY409z3DtOhqkmeHVbI5m1o9PLXu7uf4XXKUE?=
 =?us-ascii?Q?L7p/M9pT5s19otw6xdtX0lkSNMtNOYuFwRtB90iR5kLfjqC24pj+dAOi7llz?=
 =?us-ascii?Q?EXHfUo9OpHQOpG0XGPTuFsoSKgZDDJlvjV1CcEEP/ufWfsNQxt/sqN735PwR?=
 =?us-ascii?Q?6aiIXLhUThtGyAIgzqG2Z9kp/XBtALWyZs/rt3a7HWfnnDHLzV1lDFv1EG8M?=
 =?us-ascii?Q?MRqvkLClzVGEwN7/5ZS/nRQodNabOW5CeYQvL58e/Y9fjnpYpaMnsIlmNzlb?=
 =?us-ascii?Q?1FVgnh8Py92BeiF1+wVacMvfiPHUryUVW+LCc+lMUTSAo4X8fnXWVqQgxN+x?=
 =?us-ascii?Q?d/nFEg72qRKiTjpL0QGrvfHRdaiHWZm2bBYB10dOdBP6NbDBoTTkuRzlmRio?=
 =?us-ascii?Q?T2lbahdPcX/XkQ/3KiSoK/JCrIig/aZ2XVQxGPOqLAu6nAb0Vl7+C2WAkZcG?=
 =?us-ascii?Q?3UhZ1AnKNnd9mgr9gSDJ1drA4HavAZEDT4vEWnwrp2sMxHPCt85O3locDntP?=
 =?us-ascii?Q?qEBarQNS2DBB2Jxq8BCi3wbhRTeqKkp00OHkUVI8nVHE6kkZtwW0VaWt/XZ4?=
 =?us-ascii?Q?3rpuWiyhZWJ+bojXgYRiDyl/8ZzuReIh0rytiwh1zfsHtUiu78uRaHvOeLnk?=
 =?us-ascii?Q?k7U23aWmr0rlX5+tTSUqI1lxQDZvQih5BX9eh/wzYbZI3DnKCJrmGzphffS6?=
 =?us-ascii?Q?X40hzE0VCvUe22g63sXuXj7UpQ7gxiQ/EmhdsY6pxe16RSTZHgv1J6rNkvb7?=
 =?us-ascii?Q?ch3BE1Pon71S4H9bhZtFRZyPv+S2JTabtcSDY99zDZE+o2eN6GUN83SivtbU?=
 =?us-ascii?Q?o9Y1NDihDCaVUkgYztArEVn6c1YDziL4HG07kEUin4MZq82u5CWDU7L2Fl72?=
 =?us-ascii?Q?HL/kAPnNNw/kA7BavpCJPSXWTGehuVn3dfx5embWvUcowUUzVsbhQxAd+gCy?=
 =?us-ascii?Q?/Y6TaSQfDfdhIKT7iQumAGvZ2/i+eh2Ec35akf4axNsrCKd4DmdgAseoe68L?=
 =?us-ascii?Q?S6xNYdPg+TjD+jkJ59zAWlDj53PkUx+/TaFR4vy0g2dU6z2MVQCGIcy/9p5y?=
 =?us-ascii?Q?RCDvNKUFetSCOaYx8xgRYOTOSaOps/r4/a40owbM89hEGqCSIGJ26wzZEQuh?=
 =?us-ascii?Q?lkWljZ9oOWCrc7M8TiBaJceDKTtFgWBWipGpmN4BLYU4zC/jfDwnOWuoka0R?=
 =?us-ascii?Q?c1B6kffgojlUr2jFlRZT8CSGwaw0GquE44SRihxUCBEfUxEMEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QqB/CZLLYJID5n3PK3PCMehyjN6lcxQY49HYfRSkGpbUE5T7y1S43smhCLwd?=
 =?us-ascii?Q?HUws4D/NHi6bXjFoWEoD76zEQBWT4ixlYAPbta3bzJTPvr+Hco5aBxBJY5PL?=
 =?us-ascii?Q?J5xtDHif1s5H3mZsV4aI1Nzs0eSuzOzaOj885esIi9LWwHQ7IDjf8fj+NtCK?=
 =?us-ascii?Q?UBmyYTziKXDxlmj0fS4iVoZkNPXLXo2zZpM3UYFYMo41yhzJmYpmzF8pUmuZ?=
 =?us-ascii?Q?CM5RhcnHoEum+jKKFe9O8EiMZtFdWI3OxZai1+hxqjzwkT5hh+Rbc86z41pY?=
 =?us-ascii?Q?zaB81zi2Wr/AEFSv9ECQku+1bi5NjY+jaVVzojKzwMmRJZBevSP3J8UsmYST?=
 =?us-ascii?Q?q9Ah7o0JwUAcuLavJtB7CLQEtjErqe/bz3bYOJDyf2ib9jOt7iTFolpgtwFp?=
 =?us-ascii?Q?prD+tT3ZK6z+sU6ZdchjUApCvx9fbLb2+3U40ovj0HmRmTvktN4HJGDOMDiv?=
 =?us-ascii?Q?AYkQgOkDepV+Pb9XXmxOGTnqPdbuwsQHBC3M06tOCnMAgQVDOmrLwj1uhXAY?=
 =?us-ascii?Q?LAwo7iGFvWSlDEh+MD7zEwhOWpaelABWPf881EheOlJ2VtZjKR4CLIZLe7SQ?=
 =?us-ascii?Q?lma6BMKZvM74PhRlX+wQD+skKjQgxtc85Pukw47MjmT3A1F2MHqPK7mToORN?=
 =?us-ascii?Q?8PWTWJ1Jhz1Pw1kqCIUegYymivyGvtApxkqcBIzJbvY1IAWXNlYJnq4P4J0k?=
 =?us-ascii?Q?ZmYDE42eB4n0UM9stjUtfPRyVgi661N0Lbq1/LXCOvd5GrwgSt76w72RF5ic?=
 =?us-ascii?Q?YDxyuhcPcDSWvAHZbx7ntTUol+2Lmi/wyMjdbh3ZeywPpOez1ZsMRTUs3eOD?=
 =?us-ascii?Q?lPg6GsOiuJ+4m9bTHjsC9pctHm8aXZuB/f/t1Ditj0hzUup9n2DvSvbp9Zpi?=
 =?us-ascii?Q?IKfKDVO4mBPfaDJ9WA5Ly+gCVCNWo33XCFu2qKJYfy1BkP/8AHa74JtgI6nC?=
 =?us-ascii?Q?ong3CVE99Ofppo/EB4FO7yIEZUfXr5EBhvCMkxrUsY/Zwkc2BozKNHjSsLc1?=
 =?us-ascii?Q?d8/nM1u/cFZO72nAHu+OTZ49OkdOeZdUvlkNhwqbz1P6tApYJbJbkwoTHBPD?=
 =?us-ascii?Q?sfQ79aBLOTap8vwFM+PGCJCqNURuv6yfoUlWWdB5j+duy9IjHrhLaCv0B8hk?=
 =?us-ascii?Q?0Tq8AjHcdyar9l44/LUrV/kvr1bYqkY28mUHAU4OqmliVmtu6kw9Pu5c2x92?=
 =?us-ascii?Q?e4GlUFmrLT4HgzT65cVV3VrXeIzdJaEaJFNUK5/7VLC1CwWxP5itThd3gemM?=
 =?us-ascii?Q?kpEQnMbrWzTYWu+BXNUKtsae8X9dvikraca0MzGAuy2ogIoVvyP2UG7mN8U+?=
 =?us-ascii?Q?/2RolayaNfmBlgE7VjQF1SOl/mdTOGbuZN4ThRE+1jZXa9dL5k7T5JgUuJfU?=
 =?us-ascii?Q?efjJP7FQJjzHeZ5bW04j3oXC7f00P/AlBbCccPRnJhoGmmdX4Fjay5SdX/dI?=
 =?us-ascii?Q?1lIJwTREFPWnZrCFp793z2gh2SWl1jHrENh5ihEHReWvc0VFW78LU1/3dn9S?=
 =?us-ascii?Q?lV5gMAESEFB4nOuyPWIO6MxaNhgrWX2yaFD8KbZ1U5eASvL+mh/Wl5GkfH48?=
 =?us-ascii?Q?P5BHOWGvrWqpm9PcbyZmYvkMxzh1kyeW/u4oOpLR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897dbfec-42b4-4d26-c9b9-08ddb2212390
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 06:42:36.0844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGo8yrj/XWgc2rA8bnrhIkPxnu2szsZW6BYG+R0ZUmIecewrv1YaQmtmudZ+wy+DH4kAEQ0pHraECmuCWEQDIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292

On Mon, Jun 23, 2025 at 02:30:33PM +0800, Henry Huang wrote:
> For some BPF-schedulers, they should do something when
> task is doing migration, such as updating per-cpu map.
> If SCX_OPS_TRACK_MIGRATION is set, runnable/quiescent
> would be called whether task is doing migration or not.

Looks good, thanks for moving SCX_ENQ_MIGRATING to the proper place. :)
You already added my reviewed-by line, but just in case:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> 
> Signed-off-by: Henry Huang <henry.hj@antgroup.com>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b498d86..376e028 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -161,6 +161,12 @@ enum scx_ops_flags {
>  	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
>  
>  	/*
> +	 * If set, runnable/quiescent ops would be called whether the task is
> +	 * doing migration or not.
> +	 */
> +	SCX_OPS_TRACK_MIGRATION		= 1LLU << 7,
> +
> +	/*
>  	 * CPU cgroup support flags
>  	 */
>  	SCX_OPS_HAS_CGROUP_WEIGHT	= 1LLU << 16,	/* DEPRECATED, will be removed on 6.18 */
> @@ -172,6 +178,7 @@ enum scx_ops_flags {
>  					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
>  					  SCX_OPS_SWITCH_PARTIAL |
>  					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
> +					  SCX_OPS_TRACK_MIGRATION |
>  					  SCX_OPS_HAS_CGROUP_WEIGHT,
>  
>  	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
> @@ -870,6 +877,7 @@ enum scx_enq_flags {
>  	SCX_ENQ_WAKEUP		= ENQUEUE_WAKEUP,
>  	SCX_ENQ_HEAD		= ENQUEUE_HEAD,
>  	SCX_ENQ_CPU_SELECTED	= ENQUEUE_RQ_SELECTED,
> +	SCX_ENQ_MIGRATING	= ENQUEUE_MIGRATING,
>  
>  	/* high 32bits are SCX specific */
>  
> @@ -913,6 +921,7 @@ enum scx_enq_flags {
>  enum scx_deq_flags {
>  	/* expose select DEQUEUE_* flags as enums */
>  	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
> +	SCX_DEQ_MIGRATING	= DEQUEUE_MIGRATING,
>  
>  	/* high 32bits are SCX specific */
>  
> @@ -2390,7 +2399,11 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
>  	rq->scx.nr_running++;
>  	add_nr_running(rq, 1);
>  
> -	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p))
> +	if (task_on_rq_migrating(p))
> +		enq_flags |= SCX_ENQ_MIGRATING;
> +
> +	if (SCX_HAS_OP(sch, runnable) &&
> +	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(enq_flags & SCX_ENQ_MIGRATING)))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, runnable, rq, p, enq_flags);
>  
>  	if (enq_flags & SCX_ENQ_WAKEUP)
> @@ -2463,6 +2476,9 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
>  		return true;
>  	}
>  
> +	if (task_on_rq_migrating(p))
> +		deq_flags |= SCX_DEQ_MIGRATING;
> +
>  	ops_dequeue(rq, p, deq_flags);
>  
>  	/*
> @@ -2482,7 +2498,8 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, stopping, rq, p, false);
>  	}
>  
> -	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
> +	if (SCX_HAS_OP(sch, quiescent) &&
> +	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(deq_flags & SCX_DEQ_MIGRATING)))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, quiescent, rq, p, deq_flags);
>  
>  	if (deq_flags & SCX_DEQ_SLEEP)
> @@ -5495,6 +5512,11 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
>  		return -EINVAL;
>  	}
>  
> +	if ((ops->flags & SCX_OPS_TRACK_MIGRATION) && (!ops->runnable || !ops->quiescent)) {
> +		scx_error(sch, "SCX_OPS_TRACK_MIGRATION requires ops.runnable() and ops.quiescent() to be implemented");
> +		return -EINVAL;
> +	}
> +
>  	if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
>  		pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a noop\n");
>  
> -- 
> Henry
> 
