Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011025.outbound.protection.outlook.com [40.93.194.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FB435508
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464805; cv=fail; b=q/GnnqZ7JYUdvwt9jAyFqGqA+dMMqgBJSLIAMhIM+ui/QDIoqoUovun79U/YXTkAHVMkOwKy92cyDqzceL5bhRyPqUGRVzQk5zEctLL3s0ssAD9c/8mSTvrR9IJ+yRC9+VjVvm/VtlanCA26nYt7TezsVwqmEqVcZMXeUdJCCgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464805; c=relaxed/simple;
	bh=2zXPhuIG+7iZqaUJVSozBEvk050tEvXTWGwAO6gQ/jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZA8fyFaXOoVzBnWPt7TYQrQPfXqPQVIwRv8VFRRvvEjrfl2OFz1+eIXniA5phYUiu4LSu9Tclh+t2JGXluesICoLF8EgVGn/cHMbVE+LP1hD8jCpKVNxKfcl1Kg1lHISyLwCikECbzrQTgESmrIM7/vdnw0Iwyr5uW7xT7DHEro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dn+MSEjb; arc=fail smtp.client-ip=40.93.194.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dn+MSEjb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRnempBIzuhjF0dMGaj+jscZMUiKdIWNz8LWt5hotVlPdj+wqHjE3HPzBB1DE3jXoJOwsdhEySAKpfCkpBIHNDB3qpAiiTN4YuGZM0K1pDICowDfix60CqmbG66Ak+EmJnJhokyIpq5uLAkggECOASyt71a2WA5LVArOrH/drrH5qZpRRi8i8kt5ulSNzyJh8hPHq/xX/qNDif680uXWjSamf7gyZgb1+Egt2jfXRVAiufH+0q0RCXfyy3T4G8SzIrt7a3ndhv5sozrkRTzR4DUExyDJ1pXD7HNDKje3ut2i6RLafiFGrX9u6pM7mwKoB3IVBm2edn3s2wvPRA/t8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7Z44XvK1RyC0gseZiuYmfqigR+8s39qbETecfZ2Gs0=;
 b=Jgtrr4S8HtY5/9H1YPmoQD6JNtXqoqewq170KuS969PE2aGz3UuRb8MXhrii9HWQF9ee11gwrX0MeYAZtkG4gRP4TxCLQtWPBfay7Hsj9dQ+PMahbM52h8xWB3+uaIrMgLA3jTSOB3qsBU5p/pJker8mNhEJ/KyJdzHiD/ix9Ny2N3VAoUcMGb5ezRSEl4zyTOTRMQhs3EZz/qNAMcISViKxzkzMaOucYWGf4kalNi6WzpwebRhmxm1pww8rUJdmG5Ul24S0obyRTNzYLbRoyMwB9vAGS0Uhyc5PSUanpVGzI9ltbQ1B93IA4B5PBZQW3gISCCfUoVCYe74LiDTV+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7Z44XvK1RyC0gseZiuYmfqigR+8s39qbETecfZ2Gs0=;
 b=dn+MSEjbLd7+E7RibyZsNi79iIpelBphuVtkjNAWD8eVJ7xP6Gx2Uy6QQFOqpFsu2jFSSfoBidZUfZalljcOmhVJFanLb3ZGn3+ww3VZjOvrdWLArTGVfzlqUNu6gFtCrAechJf+p5SlrAbuPRI3NjQEZcOJSIEdvjJknAwgS+EKCP7Q95KqnUOExBaeS5Vf+8dmgqLnTVw+GcVPNo/1YhKNBD68Y11/7qkWYhDRD9y2cZrflgotZnJ4xJFhuUZPDrDYs5QxKAPj4lAR0iEW/QaZnp2FUUV8NSRdIoWk2ZjxZJPYIJhRrktD4lFbIwT1FUrtFiGzAYrEax08NrT49w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 09:33:17 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 09:33:17 +0000
Date: Tue, 15 Sep 2026 11:33:08 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev,
	Changwoo Min <changwoo@igalia.com>
Subject: Re: [PATCH] sched_ext: Don't run ops.dequeue() with a DSQ lock held
Message-ID: <aqkQ1MtqtqnS0wUs@gpd4>
References: <20260915081027.4185881-1-fangqiurong@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915081027.4185881-1-fangqiurong@kylinos.cn>
X-ClientProxiedBy: MI2PEPF00000B85.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::41c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cf80bf-f685-43e3-8ed7-08df130c5f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	Y1PVMQQGPYNGF6MU7ooiGj40DdgBd7QP2qBcLHYfIAkyGFGPBb32tSTdwsRoVc2YS/Qz7kMETXIWPLD8QNm781ihJ3CFlY2vl9lUrdLA+3pZI0CzK7zsI83c9VuxAa2GmSQCuOo6wGOJj7FqGbWiHc4mbNbRZf4ZABfTR9mPIEk+PsdS3RztqMK3a7avjRtadrxgGeA3V7R0AYuyaDoskLC7XDH+b0QRVMLJa85vOb0Hh4fXiQDZVZu08cFpJx+uyrxMnPsGtt1Ks7UWgXY4PZgAu0SvF58o38IYYXBjp6P+Lb62S+YYsaYuIpSnMLge/05WlRQJoPkSyPMkuxlF9mO4hnFqYwjMIJxi6S1/Y+rhvrIS/RiM7s+cEYDUS53RVq+Vx3l1+5UtXSBBuHa3SOyg3VgRp7cacNlUMvK55zsKOhMn0qwcfdDAOL2VhEaC1dak7UdQGCbmOQUw1Re86uG5oOB330+mGv+OyHenCsSB4ifzAYpAoO7TF+hY0p8RRJJDm2MDotgzvJy/Zu1ShYIJO09TQ/Mqc2E5k0keAyz+6oyVS1V9gqcBmt8gDMrt8iAZIPlbgJTbbMMHr0U1rdf075l/VAzlzksLUZG0SVrJOmYKXPbIziTSg/Ur35W0gd3Im33NVTwPhGWpXWl4WaCnzD4iNCabMictuN5YxXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sAoRuwogyltCRhPhSb02ml96ZUI496XRJwvZBO5N/36p/PNfcnl03s0lq5JN?=
 =?us-ascii?Q?fFz6hwQT8WPV2ndvfWgY6MtT1xz+CTVCdXC2sRJxZxItbV8VMmXPYXTVyFzL?=
 =?us-ascii?Q?XmSeckBS99IKiE3bFUEOWX2WiCD7Wm0PA2Tl10fYPtCtm+hxP4tJDvphf/Cz?=
 =?us-ascii?Q?j167vvrwCy17wjuQblvWJFyyIBYcZuK4oT9qpWt70Jovegfi9Eph1jNYMz7w?=
 =?us-ascii?Q?Bbfbg7GM7Z3zdzXdGkOIhgjggXjGJ/MohaBGIvuRHJ5OhbWDSBlG7lBndVH/?=
 =?us-ascii?Q?vkxvCPuNRWbASAHUJfZEwpygH3AXI5kjVBXOPkrV7oqctSMQPf9nPhhTu2X6?=
 =?us-ascii?Q?oKVMBBhhg8y3x3vYvJ8n8UosILiTHUcRf24W5//dVsJ7UfCKvnLa6Ze9fTGP?=
 =?us-ascii?Q?DZxDHF5kN9a9nw2kFhi9tHwchoG28By8FX91JI3W/TsnYiUJf73ObHWLXCjA?=
 =?us-ascii?Q?tF/5Bsa2bn2Q2rVpN5eAQkRZJJw9/9JzpfDn1W9Na7JMxVdtJp9kW7PVaU8M?=
 =?us-ascii?Q?aEGYrqgKslCBDcLom4ssuaeEgymqnU/mKhVrLxeXkmeFhUJ7q3Hgsw1v9LEA?=
 =?us-ascii?Q?CWeGIsWUZzCw0o74sVPmufUm4j6tpUwguJRt/GqeRQH+u6LHoKRqoX8k1SES?=
 =?us-ascii?Q?SbUKSSihpzCT1TZgKJYWwrzGtHbrer7AlJNjrhb9F6oP+Ry0fAisa/zz4i66?=
 =?us-ascii?Q?sS3YFgl3ErGsJ+I8JFEdq7a+aMwtWG9iLIEgCwJh9aMs9T6LFOAKuBS8CNuJ?=
 =?us-ascii?Q?v0FnHw5Tmh3Ym9ptsFoh4riOJ4Gs0Q8Ddng2FW56Kf3g05rm1vGSL7V8F2SG?=
 =?us-ascii?Q?BsATaABp3LLRBo73PcUrBuObgrKTQtqlpu+R+Z5iuRl95ij+oLj5lEI1psUQ?=
 =?us-ascii?Q?F2KjR8W1X/rbgflQgAP+46tKSfHL+ZN3TMMHruA9uSvLOMisr2J+5IpjhfG+?=
 =?us-ascii?Q?dVnkuCxzo+tHjJfkuswMzXr5rsPHLHIbI2LA6zEiUD3BO6CDvJj6j7FelHEV?=
 =?us-ascii?Q?N4gEvh+n54rrESk8qMifIWKlOhTfSKFwc3rTebPInSnRCKAo3/fEi/0ZSmSW?=
 =?us-ascii?Q?Vu4VAQKcJpJQbh09iL8Oi7fUf96enzy9iT5KQ1/XYeuNLOroKr3aQTBEacn+?=
 =?us-ascii?Q?42E4dPtGPEu0pQYvw1oE2bM6iix3paFeEFEWonZFVKy6dUHCD0ZgHenuTJcI?=
 =?us-ascii?Q?ih2cpepyIUnMFL7euUYwYQ/qJLvMZH9zifMcz/6Mv7QMCQSfoaaq4PSAxlvP?=
 =?us-ascii?Q?4KTsc5hC5m9CWrazSN+R4tcwebwirY4LVuWXoqItP8TBApkq6F3KEhzCw6VV?=
 =?us-ascii?Q?ELW8g2nb5eKjlWj/+tdjSfxnqsUUVsJKxhzEO7ooUxYF4efinnbTCpwBml2n?=
 =?us-ascii?Q?ukG1CgPW50Os670F3ZrYo80aOAD4iKBYB+Ae7J9WuRS+bOe0OarbHM2T+ad+?=
 =?us-ascii?Q?DP3PplngYXk54waktEuyPEEd2TXChcDwi8uwIYlA+Ju8C9uHztnvbs+RdnPK?=
 =?us-ascii?Q?ecUhD/AxzyGMZuPB5lIgEgLXXLVt01wwHONLxAQiDC5vxocNFIyzR/iVL7LR?=
 =?us-ascii?Q?Br5ANMetAEjF1X/qUaTvKBg8Ssgul9CoGzlV2VOBlUzhtY8KHsN2vSVqD9dT?=
 =?us-ascii?Q?MLyTjk1DGetXo4mRZE7jeD91OsEQfES/JYZCoQxGGj406toOzg993wRcsqPG?=
 =?us-ascii?Q?THMatcaA6NMhc4cL9TvfiRlDvIywoHedd5IBOXMzqiLp9N93IHMPXEhcoRAI?=
 =?us-ascii?Q?lT4TL1TNUw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cf80bf-f685-43e3-8ed7-08df130c5f2d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:33:17.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giLVWzuTYkDEPBtnhNuHZlBOg7hfMPxmeQOinKQyvw1OoNLDdUyJp8Z9ipyKZUzFGg5x/0iVGqZRhK0Lsz7BPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610

Hello,

On Tue, Sep 15, 2026 at 04:10:27PM +0800, Qiurong Fang wrote:
> From: fangqiurong <fangqiurong@kylinos.cn>
> 
> ops.dequeue() is called with the source user DSQ's lock still held on
> the consume and move paths (scx_consume_dispatch_q(),
> move_task_between_dsqs()) and with the terminal global/bypass DSQ's
> lock still held in scx_dispatch_enqueue(). A BPF scheduler that locks
> the same DSQ from ops.dequeue() - e.g. by iterating it with
> bpf_iter_scx_dsq, which takes the DSQ lock on every step -
> self-deadlocks.

This analysis makes sense to me, ops.dequeue() can iterate the source DSQ and
recursively acquire the raw spinlock held by these paths.

> 
> Move the invocation after the DSQ unlock on all three paths.
> SCX_TASK_IN_CUSTODY is cleared under the lock so that the callback is
> invoked exactly once; it is not ordered against consumption of the
> task and may run after the task has re-entered custody.

Dropping the DSQ lock does introduce an ordering window: on the global/bypass
path, another CPU may consume the task and move it to a local DSQ before
ops.dequeue() returns.

However, I don't see how the task can re-enter BPF custody in that window.
SCX_OPSS_DISPATCHING remains set until after the callback, so
set_next_task_scx() and concurrent dequeue paths must wait for the transition to
complete. On the user-DSQ-to-local paths, the task's rq lock remains held across
the callback.

Could you clarify the interleaving in which the task re-enters custody before
ops.dequeue() is invoked? If such an interleaving exists, it may also imply a
more serious ordering race with a new ops.enqueue() callback. Otherwise, the
documentation should only say that ops.dequeue() may run after the task has been
consumed or moved to a terminal/local DSQ.

> 
> Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
> Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
> ---
>  Documentation/scheduler/sched-ext.rst |  4 +-
>  kernel/sched/ext/ext.c                | 67 +++++++++++++++++++++------
>  2 files changed, 56 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 794ae80b3ba3..741473c5ae43 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -361,7 +361,9 @@ The following briefly shows how a waking task is scheduled and executed.
>     ``scx_bpf_dsq_reenq()``. The task stays in BPF custody the entire time.
>  
>     When a task leaves BPF scheduler custody, ``ops.dequeue()`` is invoked.
> -   The dequeue can happen for different reasons, distinguished by flags:
> +   The callback is not ordered against consumption of the task and may run
> +   after the task has re-entered custody. The dequeue can happen for
> +   different reasons, distinguished by flags:

The "re-entered custody" part seems to imply that ops.enqueue() for a new
custody cycle may run before ops.dequeue() for the previous one. That would
break the expected enqueue/dequeue lifecycle ordering and could regress
schedulers that track per-task state in these callbacks.

I don't see such an interleaving here. On the user-DSQ to local DSQ paths, the
task's rq remains locked across ops.dequeue(). On the global/bypass path, the
task may be consumed after the DSQ is unlocked, but SCX_OPSS_DISPATCHING remains
set until after ops.dequeue() returns, so the task should not be able to run and
enter a new custody cycle first.

If that's the case, I'd suggest either dropping this addition or rephrasing to
something like:

  The callback is not ordered against consumption of the task and may run after
  the task has been moved to, or consumed from, a terminal DSQ.

It'd also be useful to add a selftest whose ops.dequeue() callback iterates the
source user DSQ, directly covering the reported deadlock.

Other than this ordering/documentation/selftest concerns, the fix looks
reasonable to me.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

>  
>     1. **Regular dispatch**: when a task in BPF custody is dispatched to a
>        terminal DSQ from ``ops.dispatch()`` (leaving BPF custody for
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 40fa1697bdb7..13efddb729e3 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1499,20 +1499,28 @@ static inline bool task_scx_migrating(struct task_struct *p)
>  	return p->scx.sticky_cpu >= 0;
>  }
>  
> +/* Must be called under the lock serializing @p's custody transfers. */
> +static bool task_leave_custody(struct task_struct *p)
> +{
> +	if (!(p->scx.flags & SCX_TASK_IN_CUSTODY) || task_scx_migrating(p))
> +		return false;
> +
> +	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
> +	return true;
> +}
> +
>  /*
>   * Call ops.dequeue() if the task is in BPF custody and not migrating.
> - * Clears %SCX_TASK_IN_CUSTODY when the callback is invoked.
> + * Clears %SCX_TASK_IN_CUSTODY before the callback is invoked.
>   */
>  static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
>  			      struct task_struct *p, u64 deq_flags)
>  {
> -	if (!(p->scx.flags & SCX_TASK_IN_CUSTODY) || task_scx_migrating(p))
> +	if (!task_leave_custody(p))
>  		return;
>  
>  	if (SCX_HAS_OP(sch, dequeue))
>  		SCX_CALL_OP_TASK(sch, dequeue, rq, p, deq_flags);
> -
> -	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
>  }
>  
>  static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
> @@ -1705,20 +1713,28 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
>  	if (is_rq_owned) {
>  		rq_owned_post_enq(sch, rq, dsq, p, enq_flags);
>  	} else {
> +		bool call_dequeue = false;
> +
>  		/*
>  		 * Global and bypass DSQs are terminal - the task leaves the
> -		 * scheduler's custody, so ops.dequeue() fires here. It can run
> +		 * scheduler's custody, so ops.dequeue() fires. It can run
>  		 * without @p's rq lock (finish_dispatch() passes the dispatch
>  		 * rq); that's safe because dequeue_task_scx() waits on
>  		 * SCX_OPSS_DISPATCHING (see the ops_state note above) and so
>  		 * can't race it. A non-terminal DSQ keeps the task in custody.
> +		 * The custody transfer happens under @dsq->lock so that
> +		 * later consumers see the flag clear; the callback runs
> +		 * unlocked - it must not run with a DSQ lock held.
>  		 */
>  		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS)
> -			call_task_dequeue(sch, rq, p, 0);
> +			call_dequeue = task_leave_custody(p);
>  		else
>  			p->scx.flags |= SCX_TASK_IN_CUSTODY;
>  
>  		raw_spin_unlock(&dsq->lock);
> +
> +		if (call_dequeue && SCX_HAS_OP(sch, dequeue))
> +			SCX_CALL_OP_TASK(sch, dequeue, rq, p, 0);
>  	}
>  
>  	/*
> @@ -2373,11 +2389,13 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
>  		scx_schedule_reenq_local(rq, 0);
>  }
>  
> -void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
> -				      u64 enq_flags, struct scx_dispatch_q *src_dsq,
> -				      struct rq *dst_rq)
> +static struct scx_dispatch_q *
> +__scx_move_local_task_to_local_dsq(struct scx_sched *sch,
> +				   struct task_struct *p, u64 *enq_flags,
> +				   struct scx_dispatch_q *src_dsq,
> +				   struct rq *dst_rq)
>  {
> -	struct scx_dispatch_q *dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
> +	struct scx_dispatch_q *dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, enq_flags);
>  
>  	/* @p is on @dst_rq, an rq-owned @src_dsq is covered by the rq lock */
>  	if (!dsq_is_rq_owned(src_dsq))
> @@ -2386,14 +2404,25 @@ void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct
>  
>  	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
>  
> -	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
> +	if (*enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
>  		dsq_insert_head(dst_dsq, p);
>  	else
>  		list_add_tail(&p->scx.dsq_list.node, &dst_dsq->list);
>  
> -	dsq_inc_nr(dst_dsq, p, enq_flags);
> +	dsq_inc_nr(dst_dsq, p, *enq_flags);
>  	p->scx.dsq = dst_dsq;
>  
> +	return dst_dsq;
> +}
> +
> +void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
> +				      u64 enq_flags, struct scx_dispatch_q *src_dsq,
> +				      struct rq *dst_rq)
> +{
> +	struct scx_dispatch_q *dst_dsq;
> +
> +	dst_dsq = __scx_move_local_task_to_local_dsq(sch, p, &enq_flags,
> +						     src_dsq, dst_rq);
>  	rq_owned_post_enq(sch, dst_rq, dst_dsq, p, enq_flags);
>  }
>  
> @@ -2628,9 +2657,14 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
>  	if (dst_dsq->id == SCX_DSQ_LOCAL) {
>  		/* @p is going from a non-local DSQ to a local DSQ */
>  		if (src_rq == dst_rq) {
> +			struct scx_dispatch_q *ldsq;
> +
>  			scx_task_unlink_from_dsq(p, src_dsq);
> -			scx_move_local_task_to_local_dsq(sch, p, enq_flags, src_dsq, dst_rq);
> +			ldsq = __scx_move_local_task_to_local_dsq(sch, p,
> +								  &enq_flags,
> +								  src_dsq, dst_rq);
>  			raw_spin_unlock(&src_dsq->lock);
> +			rq_owned_post_enq(sch, dst_rq, ldsq, p, enq_flags);
>  		} else {
>  			raw_spin_unlock(&src_dsq->lock);
>  			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
> @@ -2679,9 +2713,14 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
>  			break;
>  
>  		if (rq == task_rq) {
> +			struct scx_dispatch_q *ldsq;
> +
>  			scx_task_unlink_from_dsq(p, dsq);
> -			scx_move_local_task_to_local_dsq(sch, p, enq_flags, dsq, rq);
> +			ldsq = __scx_move_local_task_to_local_dsq(sch, p,
> +								  &enq_flags,
> +								  dsq, rq);
>  			raw_spin_unlock(&dsq->lock);
> +			rq_owned_post_enq(sch, rq, ldsq, p, enq_flags);
>  			return true;
>  		}
>  
> -- 
> 2.43.0
> 
