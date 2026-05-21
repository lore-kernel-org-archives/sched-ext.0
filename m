Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1489385D6E
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381941; cv=fail; b=kw0CvJE6UTuNEaHZgX/Lz0KjqkV6WbR39OzgLFR9AARAClIUr9I65SbReoxP/CofbS/WvB8M1xwtfIDLBu61RatbBD5Bp6pmJoP+OnWWhlVOhcEvEMoxDWRu0fO+uuntf3qnReTwQV1hiIUGhJSm/emUXmN9A8Otqx7RJpQB04I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381941; c=relaxed/simple;
	bh=u7XGHHk0mwHYW9jSL7ryrAwxM8mJl8pgFtZDzH5U9nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cXy5KGIAdNK8H9vSeKLiybS4dkvcCCORXeeVdvfMoFNzVogyeWiKDx/PTLHOl47JUTzPzblK0AFMt8dQxA+RNj62H9NB1Tw4+QTEF4fBfnzpOu9E/Fm/BP8qsN2yMtyqCstY0NQTq936s6Wj/ut0p6cf/XMu/KgwzKlbAOAGpZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XGGbUzbT; arc=fail smtp.client-ip=52.101.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XGGbUzbT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFiYudf3jx0LwSfIvY1AtfiTkj1CbKaqwqguBoc5Eop5YKwvhOl1YbA2poHWf3z+6oqv4p0ceojF8YOmvbZWZgtQkqBv9t+Odhif6KaH2LpoPwRx4Lqgn0BC13kf6N/FxQje3wBr9WgxcDsgQq/p8IJpRBdZm3e+D+GUoMSqzsEtOv83rBE7rTIE5EgjmI3OEHG3jDceu8MhVXTZ0OdeFkJWZMalEMBfx0+3p3GZA+a2PGOG/I7ytR2pjbXdhKTYYukBlRRgacmyAg5cnZAQ0XGQOh18pcMAjUiARUNl92vatMPZrx4etoM3Ly/S83weySIl6F0H3pG/ODdtV2Xt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpt5dQnMjd+VKSLSBBfQ0SeAmnNqoVAilrqEFrkp72U=;
 b=HYapcwWFIp5AkLw/trQZIU2DfU+r+ixh/h7bFyEPIh9y7DhUQB17MhKFekEfDx8Y96JwXNLyCHBHT5K3DM2bgzuQZ9Pkj/gLjK9cghr5yYUG8i7OkCurF/p2tyZSck+IGGP0Mv843YRF5Mr+xzUa7FEguND8ck6tbfZuTBYhDYixNqa5wnNf597X6d+85rSKaGL6XRlSd1vxUU2uFtH+zdo27mpcZbvaprcGJ6JIuuc+rKBe3fyN02RnyfXO18/eg+MEgyvBB2Atr28ixIld08CIwpaxToU3XiqpdKjuRg7eAoRLkBgAWtEBDXQK9FlCcBkbEfn/nVW1B99AWuJjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpt5dQnMjd+VKSLSBBfQ0SeAmnNqoVAilrqEFrkp72U=;
 b=XGGbUzbTXF3JPs5PNUvGrtyl42IuykZ+8EirbeoIzu5j+dNIHptlyRq0QwoCJBm+ktWRpd8WjFpU74eoFsUDW4M89BjE4RsoRCyOG5t0yzpiCbhaXMup1j64o0/YCIs5tWoDv8W+XO7O4aW8LDch8j9Qm5xgvUSFpdmuvSIK1YSgp6k0vcFa3tIMkxu8hZz5nhLojkN3utC7i7myIU10+M4BdGPtKLmjgTz+r8790XV8RpoC0XH+nxUKkxjisvQl7xpRpBAlKVEbOn6LHea3I18EmJUV8pMkaFj/eNIWQWPDS/mbb20Dox03+83c9CDEjUJp7rr6QMat30bS1YmaFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 16:45:34 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 16:45:34 +0000
Date: Thu, 21 May 2026 18:45:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Samuele Mariotti <smariotti@disroot.org>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [PATCH V2 1/1] sched_ext: Fix spurious WARN on stale ops_state
 in ops_dequeue()
Message-ID: <ag82paswEla1JYa8@gpd4>
References: <20260521105911.1814606-1-smariotti@disroot.org>
 <20260521105911.1814606-2-smariotti@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521105911.1814606-2-smariotti@disroot.org>
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcfac90-3318-4f0f-d92a-08deb75860b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	LxdWdfdiZuVEhxyk93rs9hYIGymNazaTgyNqK0zsN23+oEsiwDdY3kch5bgfu8CusApXgSblPnw9LLihRskmElUIZKhwERMKchi8baPu+5+g2Y9S6org3fN+7Z2wWgstRck1Dlc50l5kFin5OVTFR3aqz+tMMgcl0xj3uXHIBRgFRhoKTAhbWwpvMYxgwzrF0ZqfUMaHGrz6Lsu5fAYHa4vjIer73GZ87aywjYahE+wXvavOLFLE2AiF8uXVOSBvJSzw9qzfg+WSP/WJullQUcDI2xlehQA+W6js2Flld8wM8HGpuY5JBEWfqJqpt71DAiQsE2OSZI6kX1TQt+uRBCkshOEBf+GUpLDu2ynS5Fm/VuHGIILlKQQW0Z4vI+niVPg5wtlhlFr5ApNFQ128IiplcipGl9f7KcxkWlLPDED7es+kM9RjCBy7hCxLRAN1cFkvOatuaOzW5k0aXu2E+L1HVGIG7GXhGja6vZyP2NzhxELLsVqIPbkjH5w9m+X0oBcNPIwcLXF++ndjKMq9OAl4yybefgkswVIDiWlQk9aVJ/kq6gj/D26hhodVkAv7f38f+yNhPY+eRSbHSNGd7M8z+glPDhMEVYl8kauIf+p71NLMDbki47ZqRVsAZkKtRLgue8RpWS0eg385AxqnMPBJpKb9OB4w/RXWeb8CBkX7Gp6Dk19AHGTpnPyMehJr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P02WJ7P4/EoPT+rEOdv42fy4ENh3sewJCrtGRKkegxZJgh8YjDgnRJJt268l?=
 =?us-ascii?Q?APyYo7hXeAyRHyZDwwTPd85GjvqraaSx9vvfGxft72/wDXhbnX/+KxY7ebLo?=
 =?us-ascii?Q?dmeFt3+5I+4kgQLy/tCxOh8u6uFE2Ghe/egAM7VlyJAhgBpERxVwkKKSIhYx?=
 =?us-ascii?Q?bEriEMoXIdzT7v5CyFEDjHwYSDcEyURmDpl0MEHc/YqdB+147YzojwvRnuI+?=
 =?us-ascii?Q?DJs1fzg0uoVyCJelNTzbhxPBKoD5YkIdI4jDunlFXoUS1oVt8axJhMhz/fzx?=
 =?us-ascii?Q?g0lUttB2ZENtlkKEsORQeCn2Y5agxJvTraIF9Vb6RDep+9Mw5ohFExKZbanY?=
 =?us-ascii?Q?3G5EJ/abDfaHBEQQYh6fnGQHxA//CZezNGl+8ul9ejocPXx3AZbeGUONC/CO?=
 =?us-ascii?Q?XKdO0kVhfZnZe5Zc21kQcLmIskfgkCYc97Fi22CsLSmp1dmE4pDQiJYknOBX?=
 =?us-ascii?Q?YAcK+vGf+DkCFgW1fU1klZQVRDDH8fGPu05G6lDGAa/xjFpaknTQDQzJqcPv?=
 =?us-ascii?Q?KimQI9i2NswlOqWb0aM59Y+ZhBKA2LN+8sZp184BaApdSHZdfbYNYh7eU+ot?=
 =?us-ascii?Q?3iVTcdWk8EZCq+l4n3ec/r2bjKr9OFjwEoMLJCqnCrpZoAxwPUnBcom+GaIP?=
 =?us-ascii?Q?sTTvpchxtSs8TXeJJfKh7QT1KAPeGx5h1WhvUF0Dr5q2rPCmfFLFP1a+DwHs?=
 =?us-ascii?Q?84hP1qNgwJHXX3g6nedbCFrSPr1XCGopFZ52h/gQFxUSJkU0TmCztV7q6mNd?=
 =?us-ascii?Q?hBHZhPDejUVhDdJ/F8sxE1+CCETtGxXSwwI0nmRY4cKXqgA29hyxFohTLqp/?=
 =?us-ascii?Q?pYZVZS0TybezAZea651Nj5l7wkZfJz21RBPGkZgHhUnejnmQllR9ncMRO7Ma?=
 =?us-ascii?Q?bPf822wadzGUWkhHR4/kp75DQZMeX1YcezAP+7USuD/yEBpLE7wTq5JM9i9q?=
 =?us-ascii?Q?Y7q325kViRrYS5UCpH0yqK8B3XAgOkRB86ZK0i3+AlTFKZ5y55cN/tUXB7CH?=
 =?us-ascii?Q?fBjmat1c4iUq4430nyryqqL1vuKIeljyMoboNpzJjeBPWa466RQe34hf6so4?=
 =?us-ascii?Q?eEstTK57fvMp7L+rm0xzX9FT+sTo0gLm797MUa1oyRZUpo/W3d2HV6KuXG52?=
 =?us-ascii?Q?ivYuVE/w8/b1QDI+PwZ0Bu755csg+Eiiweflz4+1zpfiRz9EyW6EiYW/1FL1?=
 =?us-ascii?Q?gbUM4ZJ30kRaS5jXJZtnw5VS0mAQG5Xk1bpQlvv44XlVE0ScGmk6RfSYBpZQ?=
 =?us-ascii?Q?rd4NO7lOHLHT+QoHxWNkiA3SLfYGnjoPQwxXj8Sd8lwZIEw+EIvQSuHTnkso?=
 =?us-ascii?Q?OymiBvg8kD5hCo52t+DMUb2cXBJy9SLrL9MrM1sgh0HkRcrf4+7t2JQpkdp8?=
 =?us-ascii?Q?Ie/g80szuj/Al14ngIFUVmbE66RO4qqRG3oKoaPjazvmxiB+DN2svKeB76Ou?=
 =?us-ascii?Q?8HxJppVKapBZv6g5n0K66xKU8SwLFKYg2co67/KUIS1PUNgXPz5HsXTDtuQC?=
 =?us-ascii?Q?SIAlPne+lTasJ5XBZOyVoPjnYW9bXR/YpC0lay6k0//MZWYIA52cpCYjp1MU?=
 =?us-ascii?Q?mrbFuzyEIv4KzIkB5WNAs3aZrJnNyRUKrIWsSNfg78j2SQL2TuzbGj2uaMOG?=
 =?us-ascii?Q?WdG4DtaUMkIbrukHd6kBDzxJLfslYgLueAYnuVETktcj8gVAjVe6LOeihNQG?=
 =?us-ascii?Q?hLPJ1WEf131FJzxwRBbN3uOpPSjqP5KMZZxNI8CtgpbYc1BA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcfac90-3318-4f0f-d92a-08deb75860b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:45:34.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa38bGewy6JjMInVY3agIlNJv/+AA1WzqOMYENjY8hbxSrj9o+TPbwzxpHHnnzQUTzXRg1t9r78JkHtwogNl2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287

Hi Samuele,

On Thu, May 21, 2026 at 12:59:11PM +0200, Samuele Mariotti wrote:
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
> Changes in v2:
> - Use READ_ONCE() for p->scx.flags to ensure fresh reads and prevent
>   compiler reordering in the lockless path
> - Add cpu_relax() to reduce power consumption and improve performance
>   during the spin-wait
> - Use unlikely() to optimize branch prediction for the common case
> - Expand the in-code comment to document the race condition and
>   bounded retry guarantee
> 
> Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
> Suggested-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Samuele Mariotti <smariotti@disroot.org>
> Signed-off-by: Paolo Valente <paolo.valente@unimore.it>

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 547ca398f646..c1762420cc35 100644
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
> @@ -2091,8 +2092,20 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
>  		 */
>  		BUG();
>  	case SCX_OPSS_QUEUED:
> -		/* A queued task must always be in BPF scheduler's custody */
> -		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
> +		/*
> +		 * A queued task must always be in BPF scheduler's custody. If
> +		 * SCX_TASK_IN_CUSTODY is clear, finish_dispatch() on another
> +		 * CPU has already passed call_task_dequeue() (which clears the
> +		 * flag), but has not yet written SCX_OPSS_NONE. That final
> +		 * store does not require this rq's lock, so retrying with
> +		 * cpu_relax() is bounded: we will observe NONE (or DISPATCHING,
> +		 * handled by the fallthrough) on a subsequent iteration.
> +		 */
> +		if (unlikely(!(READ_ONCE(p->scx.flags) & SCX_TASK_IN_CUSTODY))) {
> +			cpu_relax();
> +			goto retry;
> +		}
> +
>  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>  					    SCX_OPSS_NONE))
>  			break;
> -- 
> 2.54.0
> 
