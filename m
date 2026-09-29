Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FC3E5A0F
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658732; cv=fail; b=dOkqyu7GcDjucqh+/SVRtMzWYruTcL3MuPM3a5w7JrA6d0OcJDd8HKNGTp57zNP7yyIrerAPVi7RHHQZtoreuccp7ykdF82LfC7eNqtVgwO1FjTj+WVBSGdUYi8tOtFJKB6oKBxkdArWchC489wEJ1YtaqI0IIUSMUnVcByZ9zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658732; c=relaxed/simple;
	bh=A+2VI4/izO/jZBcLd69HNSfGqHU1k1qoVxcHr8USkQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ikQVl4JpD1x2Ubd2WFImjlQhwGhLrFM9YjVsGqL3t533IPZdC/CKnPtvQ5dvFa41FY7hdPxBxicQIIO9sZCkggbiLDSeplGOHAc4GKiZKmJccvfiUGGnx1vG9tLw7lCtJbHIUuAqov/79LfIsAIFRncCmcjzM19Y/SmHAalXglQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c/1KyNPv; arc=fail smtp.client-ip=52.101.48.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c/1KyNPv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dF5YgmBfjj4K5IqkOHtyY4u9wBZSFMcFl8tjx29TMnux1Vst7Ns0vM80LBkndY8HHefgAxiyT8VzMETDwNsy2AZQkglv7bJIrStj3N6SFSWWKf3i6hW2kdTefCdOv9sWwTsS+RHW9ZXmY1UoerCJlyoQ+aqppfWW4k6oFjOBeD38OcSQd/4nBuyoVKfGybNLy2BxVYhhXqPJX18m5cqO3FDNtfGHNtHbAoQUo3qsVktZI/kIDBdS6+9psDbJ9c7OFFWvxRcXrGmCSLBEpHzg0hlJSqsBQ0XRnwgalBrm6Q9nWKcu8/CFs95s3WdwT6M/+aNIeoRE0NmcplgKi8er6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLT4oNc7LNg2slqKFE1G1c5nPfY4BnnCwM9jXSXkQF0=;
 b=fkoiRA7IDH10Btur1dLIcP7EZcmHUu2I865QiPODPPbatEnXjjATbDNF1AekOYmhQY2nOiF5b6ZtKGE3mT63bEforV9o4wH8rOCJVvsx8Tiygxe6pCUhWQ5bpOoCuxF0O8/vDdn6utj/A4arvjWrNCqpXdGCqXjmWZBEYrYoUL55Z9WI412V4yrPBaBTcmtvhja/q5v5dhj67ffzD3UkNJXDQFHMWpU5V3r42xTgj9vapWM+4Ng3KzzsYOTuIfjdOuuBFu4TG+lT0SlxE0S02C/TlE0JzyqkeXtbgZ7RDrJxz3yLtEAjWMoSqHNNbFkgSMdBOn84tKNQ0tMJh9Qoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLT4oNc7LNg2slqKFE1G1c5nPfY4BnnCwM9jXSXkQF0=;
 b=c/1KyNPvgLaUC0Q6AUwXjlYYmMsNAQ2UrWUD37RF9VMYpVOieqOnYCDOPXTbD0YR2Hs24qNcoIfdZubNQ2pSBjmNU05KV8ZoxNEXvdqYjBtMptV0CJRAthxn+ZHSXs9QU0cEA0dWh5uDz9O/Nph7D7fUFYMdVZnbKHYNtQFotAj/VjJYqhW53fcE4MaYZF8cQMAtcawgDl1FrWhrmrgQ35KdWbdiXdtEHC4HZ8++EOh3/obYLe6xbapBZcBYOyCz7tIRPPg5pB1GoLoi1PxaaK4DT9254MU8tQqnTu28x6yjDX2CeW0sIwpBFgUJyMgSK/UKkWbE9Xn+vOFpq7bWwA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 05:10:07 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 05:10:05 +0000
Date: Tue, 29 Sep 2026 07:09:55 +0200
From: Andrea Righi <arighi@nvidia.com>
To: luoliang@kylinos.cn
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Count cap-rejected local DSQ inserts in
 SCX_EV_SUB_REJECT
Message-ID: <artII3WkutGPf7VQ@gpd4>
References: <20260925070500.565561-1-luoliang@kylinos.cn>
 <20260929030356.3454280-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929030356.3454280-1-luoliang@kylinos.cn>
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e233117-9ca0-43f7-7e0f-08df1de7ec71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	8EzKknyLymK3OUAxkYKUoyRbnjVCElwBx3L6mfTuWR7hakA6J8QbixZeDO+YfLTleVDDrid+G52nepYMCxV990EXAEjTItJXH8l+U4wO3XpBcemmTGQ++AdaWDrcei18iZKG4AAe+ivpi2WbMp3WRxapkuS4rt85uOlOAZAqo//Bs+514AkC4rYGDFMPEcJUEv6gWGXXb0CWi3EHLhjq7wFHI0g72LvlABpthXzPJImq4cFKcSEQxajzjegzwwY/vdj+pgQUvqFYmH5xBYY2Y3Pa3CetZkQUIPyxjRxSSyCuJ54s92ftT4umFfgrLE/u28Q/twiNk7c695o1C3oBLlzprJGH8zMFCdojWpeBN3PuktxIUeEgWsk28U/3Xy5CLQpHD7Ceh4Y4MDty+NGrdIDS9QH2T2kxrCzFUUYCibukjIw2PZZoG3PDJU4mUIfOhsONCf0cmR3sxKbL1f0EWTNDeHcOBZRk1kHr/U23NFQTG+9vPv1OPVNy8Z47md4LxDtgBy7+pLAqlvdZLFa1Lgg872G3HYBR+iZ19E8ZzbqClVWW5N7UkaTVrvDSolhr6/fHYCR3J7AfYJ70Mnue6QwppzsNw6esZB4ugfAD+i8VHgNRCqcHkv+QaLp3Td6/FwVHtzDZTj+5NabQENMyOOpOTR6nQUK9+8veog2DJqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g6NYRvzNfShu0ufgUomA42RZsSZG1JrY3biot9SrlQKxNrzLSFhsQO0tSxgp?=
 =?us-ascii?Q?gPzy9cZqmK6w+5h66O6YFkVlaCE6CEtG0FahO771PEtb4OKPneJ3YVlMUF+5?=
 =?us-ascii?Q?P470gKEgEINW/8lamuTuweIshcESTb47uszTf8COZ1qdIWnmbuDO7yL0mzSI?=
 =?us-ascii?Q?7xRx44ueJ1vcVS3XC+FgVZRhVFZHWRLpFLTsrgN/z1u1ugoTubHYeKn8a+VK?=
 =?us-ascii?Q?Y7x0hj6/FdDd6nbpzT6zJeiJ9IWbAhjaCqx6lfLUr9lA4DpBVxrvS46TTAWD?=
 =?us-ascii?Q?FkL5MoD45uuNML7LMjPY45FRk5Biz93uTGGH5VdpBPPcNcPcUQu9bSchB9HK?=
 =?us-ascii?Q?UVxoJhSb57hFMj1JgLTEVqRh+UGT3yAF2hIF74VUo5IqXGuXqqnnqA44bx//?=
 =?us-ascii?Q?B/tFq+bG8/09vYd08mxeSJAuabggpbR85moJisO8WKUcoRrx1BhDc0Hn4EoE?=
 =?us-ascii?Q?lr++sx81do5xOzr3r3JBa725njiDJ0e+IEu9yAV+Y6tceODRbo/AZs3JfHD4?=
 =?us-ascii?Q?7qq0vUjuFE5B9rLOnKKcsxUq7hN9SEWgdXRHLk1EI8PJYOPbqXsl4sRxyRmn?=
 =?us-ascii?Q?IB1bvMyHQJB78qFNQuzYKAExRfy8Z0dvicHtrUjr6tTU9yQVYRBb5bKvHMGE?=
 =?us-ascii?Q?lMcmykLhauFOYYFaQMKz/UTEplXp0A0Spg5dNnU+UjgB0jALqCjaJHs+c9bV?=
 =?us-ascii?Q?PJb0NTj2Q7orEKkCtddPohEyHotKOH4/zOB/HOnmxoc9sO6rM94XtNlH7MWr?=
 =?us-ascii?Q?bwAO+cYToGBb4EJTqWv5tmuCRYtP5JDEWbxnDFwt0GpapVvqKbksWZnjdQ58?=
 =?us-ascii?Q?wfIL4l7WAuErexmNWJ/vtZ1fhGRcvzqc6Xr9ZLAeUZsj7XnQWkIBwT4jwzyR?=
 =?us-ascii?Q?VNrRR/MJzMl1jaTTo71re40IS/+aF7HZY3qAX3rKcmNqUrG6sxEFfBW8O4z3?=
 =?us-ascii?Q?n7YOUjhJTPRjFD4bkfy5k1zXGzxPnOLeSaOodCwE6w9rsTwhtu6iufmIJQgn?=
 =?us-ascii?Q?xSoAGjwSLvmzNfqE7NzNLOglk0fnHGI2EZVASWNpmh8EMbhs+xXOqHXDB+xR?=
 =?us-ascii?Q?WDepRZFgMOxc7zIMTG6hZEfgiHSkDfyYXU4x3Kw1QKLA1DgnalrxGa27aT8j?=
 =?us-ascii?Q?79EZIZG252SFeox6hOEgsN+m/k80i5HqBCochlYP24J56W9vjVyp1PeR/dI2?=
 =?us-ascii?Q?/6oGo81azbmeS1uUfDWjd4TzAtQoGO1/xTUFPJnuU7ct7KGwhPMq60DAVikX?=
 =?us-ascii?Q?n21xrhsYr2JoAK4ht/v8OgRWQWyiKIFEcIm3FhVX74lKkvIAHAj2J69CRELd?=
 =?us-ascii?Q?9C/3+EzDSLhdEUnGROZWL/1r3gviwNHw8syzdGgLoZlCaL8cQhL5aLFOg8ck?=
 =?us-ascii?Q?22wWw81k5HjYpc6cMIbns77XeERJ9CzilUCunc42RifSsXkwePsxFFnC5g6J?=
 =?us-ascii?Q?nLAO7peki6kS5ux5U+sRks7aH3+L1BKjIqxy5IRj1o6hNQmES7HNpnY7b6S+?=
 =?us-ascii?Q?uchNGIQrRD41pTkYCHbHpwhE9tYTeoqiL0VeNZhkI8igwi0YiEwXSPNIapt3?=
 =?us-ascii?Q?X+KZzLdEpoHuFGTjowdctKglkvnL0+sSoSxOtyl7WAsqptxcTEuqncGVtC8H?=
 =?us-ascii?Q?n26ccH8YWnpeYhRxZK0+OC5LZwgjlvHoPPHOuU5/xtUFYCjXo6kDcSG2De3a?=
 =?us-ascii?Q?laMiqg5Uf5X/uQVMLmjjaBlCpI9OL1C32w8Uz6M3quknTaEjsMoWd0wFgFK2?=
 =?us-ascii?Q?Gg0fp5WSfQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e233117-9ca0-43f7-7e0f-08df1de7ec71
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 05:10:05.7543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXyRbMJ4ZyfVQ+NmPSjolnoxtQueSgfYYh+QuTV1Jk+Nu1dt5bWBeVvtrnDdqxCz4cQk9ov1XXe10z+MgMOMMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916

Hi Liang,

On Tue, Sep 29, 2026 at 11:03:56AM +0800, luoliang@kylinos.cn wrote:
> From: Liang Luo <luoliang@kylinos.cn>
> 
> When a task is enqueued on a local DSQ without the caps its enqueue flags
> require, __scx_resolve_local_dsq() has three outcomes: admit the task
> anyway because the rq is draining offline, the task is migration-disabled
> or a migration is pending (counted in SCX_EV_SUB_FORCED_ADMIT), divert it
> to the rescue path when the enqueue requested rescue (counted in
> SCX_EV_SUB_RESCUE), or divert it to the reject DSQ to be re-enqueued so
> that the BPF scheduler can re-decide.
> 
> Unlike the other two, which require a draining rq, a task that cannot
> migrate anywhere else, or an explicit SCX_ENQ_RESCUE opt-in, the reject
> diversion has no preconditions: every other cap-missing insert lands
> there. Its traffic is currently not visible in any counter -
> SCX_EV_REENQ_REPEAT only counts it once the same task fails its
> placement again, and nr_rejected counts tasks refused by ops.init_task()
> through task->scx.disallow.
> 
> Add SCX_EV_SUB_REJECT and count the reject diversion so that the events
> cover all three outcomes of a cap-missing local insert.

I still don't see a need for this event. The BPF scheduler receives
SCX_TASK_REENQ_CAP on cap-related re-enqueues and can count those itself, as
scx_qmap already does. That count isn't identical to the proposed diversion
count, but the commit message doesn't explain why the distinction matters.

Is there a concrete case where this new counter would help diagnose a problem
that the scheduler-side count cannot?

Thanks,
-Andrea

> 
> Signed-off-by: Liang Luo <luoliang@kylinos.cn>
> 
> ---
> 
> v2: Rework the rationale in the commit message and drop the Fixes: tag
>     per Tejun. No code changes.
> ---
>  kernel/sched/ext/internal.h | 10 +++++++++-
>  kernel/sched/ext/sub.c      |  2 ++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 0bcceab612de..36da1a6560db 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -1308,6 +1308,13 @@ struct scx_event_stats {
>  	 * caps for its cid and the task entered the rescue path.
>  	 */
>  	s64		SCX_EV_SUB_RESCUE;
> +
> +	/*
> +	 * The number of times an insert lacked the caps for its cid and was
> +	 * diverted to the reject DSQ to be re-enqueued so that the BPF
> +	 * scheduler can re-decide.
> +	 */
> +	s64		SCX_EV_SUB_REJECT;
>  };
>  
>  #define SCX_EVENTS_LIST(SCX_EVENT)					\
> @@ -1331,7 +1338,8 @@ struct scx_event_stats {
>  	SCX_EVENT(SCX_EV_SUB_KICK_DENIED);				\
>  	SCX_EVENT(SCX_EV_SUB_REENQ_DENIED);				\
>  	SCX_EVENT(SCX_EV_SUB_CIDPERF_DENIED);				\
> -	SCX_EVENT(SCX_EV_SUB_RESCUE)
> +	SCX_EVENT(SCX_EV_SUB_RESCUE);					\
> +	SCX_EVENT(SCX_EV_SUB_REJECT)
>  
>  struct scx_sched;
>  
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 10567196be96..3429b84f319a 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -748,6 +748,8 @@ struct scx_dispatch_q *__scx_resolve_local_dsq(struct scx_sched *sch, struct rq
>  		return &rq->scx.rescue.dsq;
>  	}
>  
> +	__scx_add_event(sch, SCX_EV_SUB_REJECT, 1);
> +
>  	p->scx.reenq_reason_caps = missing;
>  	p->scx.reenq_reason_cid = cid;
>  
> -- 
> 2.43.0
> 
> 
