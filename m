Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7211407CF1
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505686; cv=fail; b=sqcjRTHUnulDQXlm1kriPlF0oXRlI4aSf5kfXeiFVOJR2tZQeltjby14a1KXGZmqVtKWxa54IErT4tlmLUD+17rLTFuOJaeXdewKbbsf6cQhO7JViCj37WqUQ8pg/zdGh4hiXF7tDCvZLRnOMP7ZDM2gm+bAdDvrOjq85zmgNV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505686; c=relaxed/simple;
	bh=nLyir9GSEkBwFZqkd5sMfEfODcGF71silRX5YXSAlNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n9FV98W6pDrPEyTrXuzLTGVfjCkPXZ2Gragt6bPj0hDJqFnvA1kcjbuIS2Wh0s67ZAlcvzYXCes0Mb3NG3pzgD/RUPZQ8PHX/z7lWHsUpMjK2uDDsY2lRNDwzZcgq76c8JaElXUeI/XAs+FVPelUA6L/2AosS4DBWhLRACQtTLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j7U+W9Gt; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j7U+W9Gt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGga8k3kVm3qglwsWg7d/SVJxGKTvdG/f3GGtzxtImVLmMfC4WKK3vHG6m7RD1OFry0e56Iw675hXXXVJLzlCdSWH9GhDF5ptRSJYFqYpNW/JPVtL4uOtAVjLSoCH4K3PP7eZUEuNSyMqUWuCdPdQ91P0y9TiebPJmaL818vK7Rapn5KQmaL7ee2Fa23uFhsD5IRfJrzee1vrVAiqDdXMf5Y9yFMPR90kk0tTTKdSWblRCmOzxwdnEPcgnUvSIDGuYr4sCyu6xDq0v33xki/AkNyvOcCxbmGRqtsOqPuU3BpKS1z9n3AGX4JDMbU4ESkNn7Pt0cANO3Vi3U+uxTbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/MiVVoBFLxoJPwuF6F6qC2wn3zKkDYf6G5Ls8e0Lec=;
 b=rWi/PPwaOA89k98v5NUvqO6m8IsTpKgI58IBlBphdFbaK9gZcmL4Ewinam4c34PNKOuzUw/lpDNhtKefBXuMwXGP5jHH+NfpczU1OpWo9/CS5e/SsqzNN1AJt4SlMbV6ocR2BmbACxXJp40y4loJU2P6enkdQCBkMqiK0NIU8ASxd9CeemXVvk77STIpHnNz2A/SbpovNHmvp2qy3rAcy+u69sKmepCMjfIiYj6pK3yAHVpmBYJvfCAafwO20yHGu9nDHsfItGgr2j5lay2ABoesDwhRfsY1VnyrjXlPdxr/Hj5gclCq4YwO8Y4bj6plTCoyykEBONRKjGxyp12ZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/MiVVoBFLxoJPwuF6F6qC2wn3zKkDYf6G5Ls8e0Lec=;
 b=j7U+W9GtELh9VSFlNHs5H54Qyfwjt6KVCP2XRxO46apjYoWofzTX/sS3J//cWzqYRrAo/yyTsl70b309UpuLxTT7RrsiZqsEJnqqdHoICxvfVWxgF1vW12cpUlxcmctfrEznbTRlQb4//6HlMJw8vjzjEmen4TSJFz125sidmWKvMVesKC8fLO6et2K4zevFN2JVfTrTXu2mUU1pNaLuG0j/SuMx66jG4I9iGZtok7Bl9x1huHBYL25Jobrg2v83BypHkuzyrSRCBcNA/kU5L9UrsVrf4zzuMtMTSDZvsqjSpXMaUQU/EODf/iyseWh9J4d3LYIVpulbU0N1fb6fkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB507217.namprd12.prod.outlook.com (2603:10b6:408:3b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 20:54:41 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 20:54:41 +0000
Date: Tue, 15 Sep 2026 22:54:32 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Qiurong Fang <fangqiurong@kylinos.cn>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Wait for
 SCX_OPSS_DISPATCHING before reenqueueing a task
Message-ID: <aqmwiJ1StVe1EH4L@gpd4>
References: <a4304b3f0c89fba23f1e5e92997a8f56@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4304b3f0c89fba23f1e5e92997a8f56@kernel.org>
X-ClientProxiedBy: MI1PEPF000008CA.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::435) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB507217:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6f17e4-efb7-4d18-b0cf-08df136b901e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	XMlDRtodswVH4gSHNOxUkajImS7iIOYNR4vTZeRonFAeGQj8h6CJ/TC5zSvp9CoSAENhx1lbomwJ6CS6zJGLUFlbNICpC4u7Py1NdPKnBNPcH+ocdaiHOmaMwpiN1KhPAn0yjwJ5lIAvtmiEgJT2WLu5s+Oy1ATtuyRnNaZV8FgZxENlEaA6DqqbsO21cl7IOXnRSNGOaizdB5uKec59hPT+XKU7U+X74gdZ3Kg1Yd6Oyu7YVfOoiCKaJ5LHTQSM8/oSwc62g80wLcb+us7Ep/kve0n/WCbjiPgoYyBq1iNILL5Q+pwKRESW0aCvUG5NBLEbZD0fg5GMlLgOblEDUuTY1D0vLo+GLNZKfw3QMQ6U8cZgeGiGlh3VjbjpK4aUunWoh5U69eJkMQqb/ud6mH+v91Cn3hjJiDrll4e///T/LYOQBkTijVJsDH3agx+O51pIWPmM2kq6G9YIm9/4+XPYnVFrkWspBz4mOAboUzQajViQPC03m6Sg8o1AGvONiRYdQ86MRNDdvHyi7hasK1v+wRz1YtDz7K8W5zEGimWWERnZvB+Ai5fgjaJUooVvEOX5tHy6fTxbGILRXbgUx63Cj/7HCT9/O2+Mf2TeMF0OfB1usRfM5CQkrxVu3vAEaDewYfE6/08J58jN6Xr7L59U8IIeod4isJmcGcd7xkc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N1fe5JvZ7pqNLob6jJaj71G3ilDFB0wb0/lEbypX00KQMkf34Pai6N34s0eN?=
 =?us-ascii?Q?kcAbOGuXaT3sIHx0f1GKFEzMmyo9TXPYUABEqqqYA3k3EIZWg7HuSUx0Y8v3?=
 =?us-ascii?Q?KOtmfXtEG76CWV3gMPQjn2aHRVOSoYVcH/fbmOwxdy3p3Fk3NVN5pq6mAYNU?=
 =?us-ascii?Q?s5KeW6ZpVMVQwsGilwMij8PBROGmmaC2VgxygyxbxgWX6kroDuybbLqeD48f?=
 =?us-ascii?Q?7tY1otImFvxlnJ6FfMytrPOulnsQl6ZA0zDsmChrAHn2eyn7/hSYfFqdE6IW?=
 =?us-ascii?Q?1NF57vtbqf8C8Mo+DN8SRx/Nqji9qN2eueabv4NJxvp0h7olTD6Bjb1u+wdj?=
 =?us-ascii?Q?myb897BmNI71yVSX0z5R8her5raOinWh/YZZ+5bv1FVzRw8zrKqbsX0b+X6c?=
 =?us-ascii?Q?noSWjyKVssyf2XHbDAt8fIWWjbHQUC1r6MXOI8QTpMvu+32rQVq2IusQCA/j?=
 =?us-ascii?Q?g2GwpjcCghbHcaWzr0KVo97CPSbIgV/EaUPKFGx0MsKjZGeVZr0kLnRr3rrt?=
 =?us-ascii?Q?vSCr0g/Avl3Tj9BY3LdrUeG6XcxPGBJRZEDZuBrVral+bpt60dG1Tgcff9zd?=
 =?us-ascii?Q?cHAFJdP5GMMcGYrSNIl0IPlhZlmILqFHze/W2SJjO410fj3n3epJYljiqTsA?=
 =?us-ascii?Q?PCaNCkJTATalA068XxDRj8KcWNrX2LcPyyTl3izwkWmfxxBZ/tahJljdyko8?=
 =?us-ascii?Q?vlFf0Q/jN3zbCO7Za9Q/Fisy0lsqkMWzQsf52rnsZtHVfOxaBEbZCb4WiXhs?=
 =?us-ascii?Q?K+Lz0pv9U4Q6IgjjFnuh5e1hsFdoK8SXzm+fUlrb+niLLoGjhAPPiBDIR84E?=
 =?us-ascii?Q?DfoBq3+TgwU49+0VeDB2hW7rfKfJ/5ArWgsP1ovtjAM5NbyR05Ajbf+Ked7J?=
 =?us-ascii?Q?nE4jeDb9fWIWYhKTzOdocO6d/oIufEZExpeaE6fftkLZ/EjrOjJMzBv+0yOU?=
 =?us-ascii?Q?BPDaGpVBFrFrcwtEaaucmeniB5XQQLclHM1dPuvH1YAktNd8bHEZioYS3ncL?=
 =?us-ascii?Q?fAzk2NZNEV7m6oEQ9X+No3LX+Z79bYl8LHRztxD+nEWutBXPTy6jV2iQ6lX8?=
 =?us-ascii?Q?N3rVviDJZ5R1jpRer0azmU3n0prN0i1ox2dvZ3U3ODjZvEbNA7UeRbTyYYEv?=
 =?us-ascii?Q?ppWP4zl09C8u4U1sO1xxITqlmKHZ6s1RHRI9pXSYwUhleITVRh9bk1Z5lFKc?=
 =?us-ascii?Q?J7jBNS72wdamHN+InENg4a0vkRCLNYYB1kueXcu+cvUeFsNRPjuJ8HkXf+zs?=
 =?us-ascii?Q?c4x3OxowDH8eLXXWJxCqOIraejAZKNKMgWPZW8ldfe2uBYC+6qVIqYA/NwTu?=
 =?us-ascii?Q?oS2rIAUUinFJF9luDVVibqppyB0y4gyp3kBYDm/9FFwT2RjSkq4BZ4IDshEr?=
 =?us-ascii?Q?9RvxjMggc57ie0yZLCBimpmIA5end2Sbg4zYy9bRi1xBoIu67ULr9QtkWZVW?=
 =?us-ascii?Q?zNefmwh6FxTom5uoUfovDkbLOt59WQnhKzS5vrrA1BhQMQAQ+Sggv/oQPNP2?=
 =?us-ascii?Q?KV4KIWmVBoFEJX8h+l71YvAr0wOHsklfcO8LJ2DbNNMKqzbnYNIxhogIXbEb?=
 =?us-ascii?Q?9IfS+KEOLLtWZedZXZGS5bP6Mr/efWHAoZnuKCjGBFoLU9OaJ/p5EaakMRxY?=
 =?us-ascii?Q?bsP/WvKEWgs0gbT9noyDyadE6vCdqA7HKRga5YjQb1vA+YVh3Cq25ke9E86F?=
 =?us-ascii?Q?bCg9L44XdJH8xpkUJADFjBtxTqSSQ5NLzZCgVkQACjpADXLrk/EdNmfUYH7o?=
 =?us-ascii?Q?W2bBMJScmQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6f17e4-efb7-4d18-b0cf-08df136b901e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 20:54:41.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uupx5dDtn3OU6f8lE/Q73+FXEZUOXNpdjpGS/AnqHWDE7BxwJ1fP6EI8sbpD3kqqInEbWBpM6atvmlUiGeEOHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB507217

Hi Tejun,

On Tue, Sep 15, 2026 at 10:03:37AM -1000, Tejun Heo wrote:
> ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics") moved the final
> ops_state store in scx_dispatch_enqueue() after the DSQ unlock so that the
> custody update and ops.dequeue() precede it. A task can thus be found on a
> DSQ while still SCX_OPSS_DISPATCHING.
> 
> The dequeue and core-sched pick paths wait for the state to clear in
> ops_dequeue() but the reenqueue paths don't. A reenqueue in that window runs
> ops.enqueue() and sets SCX_OPSS_QUEUED before the dispatch has completed.
> The dispatcher's final store then overwrites it with SCX_OPSS_NONE and
> finish_dispatch() drops every later dispatch of the task.
> 
> Wait for SCX_OPSS_DISPATCHING to clear before dequeueing a task for
> reenqueue, the same way ops_dequeue() does.
> 
> Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Tejun Heo <tj@kernel.org>

Thanks for fixing this, it makes sense to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> ---
>  kernel/sched/ext/ext.c      |   13 +++++++++++++
>  kernel/sched/ext/internal.h |    1 +
>  kernel/sched/ext/sub.c      |    1 +
>  3 files changed, 15 insertions(+)
> 
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4404,6 +4404,17 @@ static bool local_task_should_reenq(stru
>  	return *reenq_flags & SCX_REENQ_ANY;
>  }
>  
> +/*
> + * The dispatcher stores the final ops_state after dropping the DSQ lock, so @p
> + * can be found on a DSQ while still %SCX_OPSS_DISPATCHING. Reenqueueing @p
> + * before that store lands would have it clobber the new %SCX_OPSS_QUEUED.
> + */
> +void scx_reenq_wait_dispatching(struct task_struct *p)
> +{
> +	if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
> +		wait_ops_state(p, SCX_OPSS_DISPATCHING);
> +}
> +
>  static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
>  {
>  	LIST_HEAD(tasks);
> @@ -4447,6 +4458,7 @@ static u32 reenq_local(struct scx_sched
>  		if (!local_task_should_reenq(rq, p, &reenq_flags, &reason))
>  			continue;
>  
> +		scx_reenq_wait_dispatching(p);
>  		scx_dispatch_dequeue(rq, p);
>  
>  		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
> @@ -4570,6 +4582,7 @@ static void reenq_user(struct rq *rq, st
>  		}
>  
>  		/* @p is on @dsq, its rq and @dsq are locked */
> +		scx_reenq_wait_dispatching(p);
>  		dispatch_dequeue_locked(p, dsq);
>  		raw_spin_unlock(&dsq->lock);
>  
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -2078,6 +2078,7 @@ void scx_kick_cpu(struct scx_sched *sch,
>  u64 __scx_bpf_now(struct rq *rq);
>  void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  			u64 reenq_flags, struct rq *locked_rq);
> +void scx_reenq_wait_dispatching(struct task_struct *p);
>  int __scx_init_task(struct scx_sched *sch, struct task_struct *p,
>  		    struct cgroup *cgrp, bool fork);
>  void scx_enable_task(struct scx_sched *sch, struct task_struct *p);
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -801,6 +801,7 @@ void scx_reenq_reject(struct rq *rq)
>  		if (WARN_ON_ONCE(p->migration_pending))
>  			continue;
>  
> +		scx_reenq_wait_dispatching(p);
>  		scx_dispatch_dequeue(rq, p);
>  
>  		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
