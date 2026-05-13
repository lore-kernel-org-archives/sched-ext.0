Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC24B1A01BE
	for <sched-ext@lists.linux.dev>; Wed, 13 May 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682426; cv=fail; b=ISgVMUIfaxds78pQ1G7bgYLp9OfuRtfvPyELcNbqf6M32Fs6d70t9nlbiW2Am6Df3VVMtrF9VxF4vYXa8gKCKFxFo6TAY2FrkOc/00UBz6mKlk6Qw2z6+KdUV1fJsXpW2ij8c1oX2sz5fTWym8nY3HM1YhaVWqSD+nf47/OhYYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682426; c=relaxed/simple;
	bh=Cnw644kw5ZNoA4/VugFNSJll331YUVlP9A5yo/N9VuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=To2gAwNaUlclRgKrigRMBJ/3pDQKszYUcGEnGOSR2vFb324CGjmgMlyNX7p5m0KQ2LVpcHIQlEXYXEvu3One0tKmeXg3mth5ssjZOPkwozGqVeoY1xLY4IBna7Frbhu7FsRAAouTMxeoQyL+U6SYQZMzbWfu7GPLFU7LEy0vqKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FqvjDa0z; arc=fail smtp.client-ip=40.93.198.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FqvjDa0z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tb14vIBd2tJWXtOOwPpcNWz6CODVnuH7ve50qwCF0KI6UFP3li6mRAwKOUqZ0mKyR20dYcRrGpXHp+nvpKokNnJBc3JwfqBZE+oz8xpJc1aqO5bPufc2imV7CTSyYbprgSNUX5ueo8vCjl7x9mZkBJzqLaR7A+N7SPaJNW9HISAGIII+n4Ibvl9oRXMPxYglVjNCesYuu8eLIBEHHTp0czKaqq0NcTwW21ReapRCLPHWWfgRt0KsaRSew9ZMo2O5yYVVYTMdIV7sBFUGUE+kAbZiQr0hjq+j1bNw8waVMAVCc4E844FUp2akj21yQjficnAHxSSYH/IMhqr2mikh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVwQZzf1KYxDnSa4W7ibpVZ8gSCc+3D4gX58R+RlN1k=;
 b=r1NUDLlDPKRAsxdodD/MaF6ydKL7GZmNfaAfxQCcJiP2Y2exD1gzZStx637qFYdHQ8Np2P9WtCLhpYfln27rGkfY3O0gpBOyfUWftrNF85Y9WMzCRW9wpR8PECt4k0BvjYUUYDiNFGLDduOX6Xi/g+7qwl9WtKBW5mZD3NY/P5uWmpQUs/YwLgcdzxxNHuj3ldIUXkr8xIXnWLgjT+pdIPz6uaXiv+bHpiuuDq9KbEpIwYptZoEgKt74pwsvdjElvA/0IvrGB3vzkDS0gyG+Mm89WGvLsSxaKX0THjeC11yeSOOKOXk4/x1wOnbSw1ecInbiJjF1w1/sXTCXE6o9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVwQZzf1KYxDnSa4W7ibpVZ8gSCc+3D4gX58R+RlN1k=;
 b=FqvjDa0zk5GMPpNJ7QFkOw5F/LtwQl46CsqSjnny6LTs5hB1XvbBqGuoLcWvaMqk5L6MgFuXL7XGFtLOLV+sfpD5La1EToRuCw1P/OJ7ijWZS+Wqt7p1WoIhtH9mLN9fniUOpaviSYjS3wbIKO5X7EdT8wQoq7hf9l6xmqRBtn9GcbRsMY66UUxH0O2b4nbirR5BHFkFKt8AIar/xAf+OLGuNIHFtDnHtNHTlxJjLFuH/yJP967gL9Eq+YzZ0390fpb4yt6MiQCmRNV24UnKtGE6HUdSamyLAEZjNji0f0wHMS/q3Pwq+5QWaL0UXkLWf4/w5bKWeeiy2a5d3hPGDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:26:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:26:54 +0000
Date: Wed, 13 May 2026 16:26:45 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Samuele Mariotti <smariotti@disroot.org>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [PATCH] sched_ext: Fix spurious WARN on stale ops_state in
 ops_dequeue()
Message-ID: <agSKJbtmpRPLgYJW@gpd4>
References: <20260513095329.4029345-1-smariotti@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513095329.4029345-1-smariotti@disroot.org>
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e16f9fd-a013-491e-59ac-08deb0fbae47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nAkPJ4mivsxVpBRCW6fQ/1BgGsx1Uu6xjuFoEfKdv2PnzMGDYxd5FXK0hKWUHS98mRN6dF9HMf2RcrGcdo5nzjIkUDtKcsdkmalBt3uDDo1e6VufSGehqOrMTyGHLhcOc4htAaEzaJyCJYwMg3fuVHvu1uczIRHNiRNdnn6rFFEXEMzr6Iyt8QSBYZqhuCWrIM+6F71CIhvqafnGxNssq2aISEvJt/z45qE4DMjhoKtHKqlzCMsGHk7Go2xsV3bv3cPIsVpL/SMHjhc4fYbhtfIHHEEXLJR46ORrUmgEadM3xiz3W3PFsD5TKbl5dDFJ6PyXslx/A+HnVRsOfJrApz8+mABJhPb1HnKSPqOZ9O3nbRfCEXfLt6Sg7xywfRe/2SkMQrn3/g3qoZAVisZvS1xyh3/x/Qa2zIGT95q2uC15mlISCz99j9/ymBm5Re7+pQcrF3Zvf+7tU6/vpFaPGmvHwkMJ5qkUyB41NNHw1pBLk9Nm8nDag8Op+RG68Gz/n6Jyt9NxLqYYDuKWwq/qgqDIAVcnwpAMwef0G9YYQTtK00IoSh/EPUEINCensIbC/LA8dSQ8eZMABy8t2DQcN8kJaOXaGLCgOr3ny8EmjihvNWO5q/SAThcLo4nbAnGReKFyFsGQGrxRpp/M8on3s0E7DkI4JJHmh9vo6c1vBKHLSzNY2tRinf5di/yPQc2C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?//LgEoQAu1SH6hSLLq9UIDANnd5bElvJjpI1gum8Z2RV4e2SRveIzuyspjE0?=
 =?us-ascii?Q?T/j/Fc7LFPQ8dyb8ZNYDEdyHcJ4ynSjmmKWB1K0J16g5ugA8LgppNg/it2xE?=
 =?us-ascii?Q?UD1knvDdPz+vyKCm36pgOOIwF+kaYdywhh/xV1y9cXfRmH+zUAq/o8XPjDDd?=
 =?us-ascii?Q?WFNzd+W6PGoU1QBQrYm1B/qdMeCZSwM+VVd6N90hhDWQwRE077p1aq1rXm4d?=
 =?us-ascii?Q?JcyXuZFAJVZ67YfH7l7vu1jpHyIdn9jPn/x+FHTx9c3oXvOE1sGm5lJYRyr7?=
 =?us-ascii?Q?mzmrlJwsFmEsBQ/bRjKIttxuUDOU1Iy3er2jnD8wJ8mfM6txOjvsJtB/y53H?=
 =?us-ascii?Q?LnGFhJ3hl1QuptiNfP+gYJGbbd2dHHLEb69siCgIUcjtGKZ46Brbf1MbTKd5?=
 =?us-ascii?Q?wL4K+AeMbJHVqCJQAprhYm+FVbtPghUNeItWtq6M3i3zUxQxdft8h8SLpJ0k?=
 =?us-ascii?Q?2CNSaPmFb0eNNxZsRuExmWwxrDvB1NS7zBB0zJ1Wd/40XnuokBfHFtmc2rBP?=
 =?us-ascii?Q?LfDghoCRiVtjaxvURpWqmBeuRm959ToNXw0kbqE8iJu9xqfxmAQ0BCyvKUSG?=
 =?us-ascii?Q?/fPpLYhmS7rjWJSson3osh6gysZNCg92REkjK98LEacru8oa3w5Sdolv7UqC?=
 =?us-ascii?Q?6b80wB4AjQQtblFdSrbwJre7IUykymoovyzoEu9goslKq/E28V2OZb7G+E8q?=
 =?us-ascii?Q?m4ISsZhLPgQpUzZSBhZv+3x/UBSasCKwQPu+P9T+sOlOjdYVOijWt7O1oyAG?=
 =?us-ascii?Q?NGD5/Xk49yZ8KhawWwQ6eM3XH9wLdsdIQQpQSY4x3pcmwm4kpGa5Hv4Y88G9?=
 =?us-ascii?Q?fZpLun3pH4F/qMg7kL1vVLPENw7Z3BMgblC/QOz0RYdMOr9LZwYnOlZHpTsg?=
 =?us-ascii?Q?Skvf1jNueTshWn7wwjcoB7SqN9yw1t3t6zUp0Xg5YE2sWnrYUNnoWT7vqcUQ?=
 =?us-ascii?Q?HQHK0gU1Pixy0BCs3h1ByKZNtfEQlWdh8POT5prwZHN1FjJ82sr9Gte3arQj?=
 =?us-ascii?Q?kefVDzMGDQxogl/uXEszpNjxaUVr7C7cJwju2sR7jzeGhww7IxHFvKWd9JvH?=
 =?us-ascii?Q?JtJP8+QAWPhtHkGWs/6uAqdmexl/b0DzkT08kyW4bf5rykOJsO7lcqsIrzcZ?=
 =?us-ascii?Q?YiQmrfq6hE5cryf46k5YAcIns5cAaCfZJAmZKRH0pyQ73hEJFbtGV7y/1nIm?=
 =?us-ascii?Q?phpo6XIkmhpRXuA7/SOjtShqUZWACKlcJPWxdXG9zD+Xts2HwWnmD4GBhiV6?=
 =?us-ascii?Q?b94+R2zUTtk2DFYfo4mTDctB88YqQf6zVB5k/cKGGd0HNSTeD7lid5zP9dhp?=
 =?us-ascii?Q?X0QRvNRbAFFscLllZwS8jFiSbUS2QkFBOgGbNFn0LhYyAIiYVwcxL/E15xiV?=
 =?us-ascii?Q?WrVEPbve84cyGJpLRIqFwQsxvtlAx6thQYSNXij80OKF8p58vWPqv7SQjRPs?=
 =?us-ascii?Q?rt8+Kjp/ZRoRUf1PF59FwHnOXMVt8xoH1utUDUIOMbqBMxoWiByeucIyt4P2?=
 =?us-ascii?Q?IW+eJ3EitX0orm3SB1rscRp7S1HgLEih2NK+5KBTmJgoxaEAMh+g0pi55Qvr?=
 =?us-ascii?Q?j4KwDJJ4hcz9LNN1zr4HTtFiCFJ+6OoITpxEV/z+MXidLqIuJuY4Fg0khmA+?=
 =?us-ascii?Q?gwkPl9rq7nPgakSAe9Kd/rlwkvyAkyN8+MgSAUQfoFQGzPT8R3Y3CkGnDByc?=
 =?us-ascii?Q?n/iwpTw0xPKWN/TXKzi06nJIQ+XVfX4uXM0uXqvlgpmvjGzo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e16f9fd-a013-491e-59ac-08deb0fbae47
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:26:54.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfgNtiZkM8uSlW11rGVPRMRXH/jD3qDe6pJNOL+7M2yHuYpH/6SIVmpJdofb3ASUyEketbGZ9I/movUJb5O7Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059

Hi Samuele,

On Wed, May 13, 2026 at 11:53:29AM +0200, Samuele Mariotti wrote:
> ops_dequeue() can race with finish_dispatch() and spuriously trigger the
> "queued task must be in BPF scheduler's custody" warning.
> 
> ops_dequeue() snapshots p->scx.ops_state via atomic_long_read_acquire()
> and then, in the SCX_OPSS_QUEUED arm, asserts that SCX_TASK_IN_CUSTODY
> is set. The two reads are not atomic w.r.t. a concurrent
> finish_dispatch() running on another CPU:
> 
> CPU 1                                    CPU 2
> =====                                    =====
>                                          dequeue_task_scx()
>                                            ops_dequeue()
>                                              opss = read_acquire(ops_state)
>                                                   = SCX_OPSS_QUEUED
> finish_dispatch()
>   cmpxchg ops_state:
>     SCX_OPSS_QUEUED -> SCX_OPSS_DISPATCHING  [succeeds]
>   dispatch_enqueue(SCX_DSQ_GLOBAL,
>                    SCX_ENQ_CLEAR_OPSS)
>     call_task_dequeue()
>       p->scx.flags &= ~SCX_TASK_IN_CUSTODY
>                                              WARN_ON_ONCE(!(p->scx.flags &
>                                                      SCX_TASK_IN_CUSTODY))
>                                             /* opss is stale: QUEUED,
>                                              * but task already claimed */
>     set_release(ops_state, SCX_OPSS_NONE)
> 
> The race has been observed via two distinct call chains: the most common
> goes through sched_setaffinity(), a rarer variant through
> sched_change_begin().
> 
> For SCX_DSQ_GLOBAL / SCX_DSQ_BYPASS, dispatch_enqueue() clears
> SCX_TASK_IN_CUSTODY before clearing ops_state to SCX_OPSS_NONE
> (intentional, to avoid concurrent non-atomic RMW of p->scx.flags against
> ops_dequeue()). The window between those two writes is exactly what
> ops_dequeue() observes as "QUEUED without custody".
> 
> The observed state is not actually inconsistent, it just means CPU 1 has
> already claimed the task and the QUEUED value held by CPU 2 is stale.
> Re-read ops_state in that case; the next read is guaranteed to return
> SCX_OPSS_DISPATCHING or SCX_OPSS_NONE, both of which exit the switch
> cleanly. The retry is bounded: once IN_CUSTODY is cleared, ops_state has
> already advanced past QUEUED for this dispatch cycle, and a fresh QUEUED
> would require re-enqueue under p's rq lock, which CPU 2 holds.
> 
> Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
> Suggested-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Samuele Mariotti <smariotti@disroot.org>
> Signed-off-by: Paolo Valente <paolo.valente@unimore.it>
> ---
>  kernel/sched/ext.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 23f7b3f63b09..d285e37f2177 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2078,6 +2078,7 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  	/* dequeue is always temporary, don't reset runnable_at */
>  	clr_task_runnable(p, false);
>  
> +retry:
>  	/* acquire ensures that we see the preceding updates on QUEUED */
>  	opss = atomic_long_read_acquire(&p->scx.ops_state);
>  
> @@ -2092,7 +2093,9 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  		BUG();
>  	case SCX_OPSS_QUEUED:
>  		/* A queued task must always be in BPF scheduler's custody */
> -		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
> +		if (!(p->scx.flags & SCX_TASK_IN_CUSTODY))
> +			goto retry;

Can we add a cpu_relax() before the goto? A hot spin polling two cachelines from
another CPU could be very unkind to SMT siblings and bus traffic.

Moreover, we completely lose the original WARN_ON_ONCE(), so we don't catch the
case where the invariant QUEUED -> IN_CUSTODY is violated by a realy bug. How
about adding a max retries as well, i.e., something like this:

	int retries = 0;

	...
retry:
	...
	if (!(p->scx.flags & SCX_TASK_IN_CUSTODY) &&
	    !WARN_ON_ONCE(retries++ >= 128)) {
		cpu_relax();
		goto retry;
	}

> +
>  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>  					    SCX_OPSS_NONE))
>  			break;
> -- 
> 2.54.0
> 

Thanks,
-Andrea
