Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1E2D978A
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756797; cv=fail; b=OX6rQ8TGa6mzu9JNyqfQQ86q8YgbMaEaZRZpBvgPUDO4CXmWIBLOHxTmT4gtAvDt/sPBsdvfe0aoB1kPuKIrL7J4La7/U4CkHBfR3Aq7+I2MB8wXvsQCMg/AP5LsBS1eKaSJGsyanq35OUjskcMCYztfMKlm+sag9F8iGsx7dMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756797; c=relaxed/simple;
	bh=E49hapiotfX3OIWGl2LoOVQ6YqwnYGjKc4c0atzwfeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hk2yb1ihAS8h6+fdUYREus5Mw788pG1tX60euiOto8HrlSsPqMGpe00/pRTJ5LG0G+E49nSRqAge28AQ6uKuBl53RUlfBoei6/H1oWnbMLzu9oqD1kES/o88hgPkfR2ib22MGKqL5+h0ovU6rhBGfivqeKldB+NHoyBxMyXi8dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tXPnOzNr; arc=fail smtp.client-ip=40.107.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tXPnOzNr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YU2dmZS1AAis+P7ls3l8QH8fkNWikCW0JnWm4YH8tGN6JWQDiKOAKjT7lcXwXLUA7GSbmnx4k6igamK8ce5sQVyHbje6iB1MMkDsYvle6VNtYiHYJOY5z4WYE8fDUorOabG18rjMV0E9lMj032du3/kASfzFmp4IevYd8gi3SKykcRZC7cggRLGDyM0+PcAgeLPvfI1jUH2TXBm5PUponQxcRssweVI8OPgovgaUW1OaH0wZwxydWIF5Kht1QSYfiHlnoAViRqxMNc3TvlQ28Gs86FmkizTNJe06n0OBRmiPXSUQdFJ3nALCOcc5+5Y+LpxVYjeDhAnr1sYKk0hgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNDSKWtDaRFBJ3Yc6s0IGWCQucnYu0EjoyFCzu/FhbU=;
 b=Eh3hOhijE8wKuFtba8e/AoDfIsGLfwy/6LDVrC5QnLDE86oRGXsEoR/6UJmOqsSKGQUCMYJnxCl5JgtBTpr1uEqhuO1N3eZLHgmKelkeromxOhMMbKm8nzPVhlY8T1BcMas1tywyWnCkM6n4s6O0tUizUW+Zbt2svu5EDv1gXM6lx5huh1M9N+TvU/G6dXV9hL8Va8snz88Xuo+k+8u9mwFGEgn6cKGefsBw0MQhoR5URrNHEIkR+a5z9j72ZJiySwASBHTRuJgeQeJWw7KXTGFIsHzSJpBN6V3y+MQCbZsKvRLpZI912a7nXn39QNy6X2MSFaYVfnOnSE7u88Cg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNDSKWtDaRFBJ3Yc6s0IGWCQucnYu0EjoyFCzu/FhbU=;
 b=tXPnOzNriOLGWVmX3ZmMoCXx5JM8FQzQnoHyEUGFH6QuLH4Ht68Hu63MiUJxIi+omkLQ9toQsnBezpNKQJccSXg+Tepf7GPgs+7o+A+amQLuQf984Cxr7I1r9mIzNwSxWgyIXbXioT12pc2ADJD58O0n0MtJ2nr5VuExnZDDr+jOZ5BMUyxahe3qUZ4Mwq87CAhjdYysHHhZfITfq/jcManbjjtSjjj7v6ePVSRP3X61NkFZzAvwtvvugy/Cbc8uLRucAYTndPbUiStranABliFtxf6Firuq16Aw4i3hEtBbDaQX+wCuARgM8iz3divCx7zfh9x18iI+80zS63jp+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 9 Apr 2026 17:46:31 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 17:46:31 +0000
Date: Thu, 9 Apr 2026 19:46:18 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Documentation: improve
 accuracy of task lifecycle pseudo-code
Message-ID: <adfl6iuDWHYp9fZN@gpd4>
References: <20260409165744.1526489-1-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409165744.1526489-1-jpiecuch@google.com>
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e767cb-9425-4170-bec6-08de965fef1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7dqi7hX53aMsGVBVz4TU4NoRBfqGmXnK71/4Gpwfi1b5DMlxl+xwi28sGfIhtetnkBzkxcCVBZk34SfLgF3r7+81KS+hOoTBzRTGHHcTLq0uc1EpNgh1sXP4ws0kyU0RQpldgYDMjQTPv57/n+D+tYfsCouy43CKzgwRUe7je0htARuuWffA8R+f3agbojuskveHbHlLrk+ZpGYqQVZGqgVnsySZYX4XPlEEBBKbfdl5yD+bHAivPiu4RdKS3J1Z54eEcmSSev0X6No7GvQRcPpjkYkpTX+lf5y5TgDpuy4dWr8rh7wiZQ5cq+7Rjw8Az7JYbB5hya5SGXlFcS7LLrFjbTjuth1/SYLP8OPfthGpwTfUiTCO8Bs+iURzQbpWZeN02/N3ymAEV2nV7ESd/VXvISfyknbpn8ghAYEB3TdTYkYVeYoGML42uuvyuTvlP8iz9bODwZ32hJNmJTpSci0ZyI4ikU+5kIzQT9a8dedm8Kiy8Up2VJghPoPGO13oOS3TZN530tvPSznjdbowVO6HVu+Ekzzke7LWFiEnA6JNAxdZEmdkug3rf/VrzDP01JNLhqBoCQxAnKVe4qeSXw1xzcX9Nlt6rHAiDh5/sjhLhSw3K7rCIyHzo6z/VAnELUZT2zaImCvfNBo/fsrqqZ8SHGFy+9EpwKd6JQYtbmxQfL74Z4Lrm+VFUcEezzC7XuBenZTFh43DK5bhLkRvTD2MarnK4FgDzYmKVozma2w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkJaMlEw+rNR97ucnVw3stMlmTChKtdIa+BGCUeiOB2UY/A4r+tyVOF1AIAh?=
 =?us-ascii?Q?hcytbmg03CLwHu2ehm9MWBpyrUcVmMKZ9m13Fe3F25cqlgbo4qiSIGEUutzt?=
 =?us-ascii?Q?Mg1GGHQrcctphS8fOSFiqPC4nFIJtaH0KBp75qnuh6yh9JplO2Zasa/QTQGt?=
 =?us-ascii?Q?ys+3kVA2YM85BHz8RXyyQO1unEousn3YYydxDaxs1Gvkp0XdqaGLqZwU+WHW?=
 =?us-ascii?Q?pltw0XOXFMQjcCb7WkNRFVwBqbrUlyPyUO2gJu4CSKjm6CWISrFiAfm+ckhT?=
 =?us-ascii?Q?7Rj/wvrTaYYuce1WOHy/Xr2T5R9BSjomEz7luPyf10TTea3Jf2kiK/CIdpkx?=
 =?us-ascii?Q?0svG+7WoGp+yxTjrKZ9+d2dX5dc62fIcUuYCIaltUAdvpq4DjQN9wNL5jTxj?=
 =?us-ascii?Q?PJr8MwZlQkW8XkBYklvIOcqirWl8KeuST+JC4gRwVtTlfJda69LPI7ix8Qfk?=
 =?us-ascii?Q?g2Jv71IOQfcloq40nZInqSvVsIDLNb8b2ApgZ0NZXZIeBhJgTjyKCx/3aVWZ?=
 =?us-ascii?Q?j/P61TU2d8Ffxpc/b4gii9Xv5jK+SyBEDw9rVUTdX1ApdkLO2UEtYwNbmDNZ?=
 =?us-ascii?Q?5xDLdhoWKxWB50Dux0eGvxkBbkdFf88jTF5YJcEl9rJGg+hFTjknxwYnR4tn?=
 =?us-ascii?Q?1/4VSTp55vzYoWTOaf/MBYGQs7x87Zi3NDkix0gARKuPl+Xnhi4Veec5C1cc?=
 =?us-ascii?Q?+G9iZEeGT69Pz2Npo/xdxQ5Tz/4wg+adwuQOIo/UsprsvRJj0cDpMSKKjckM?=
 =?us-ascii?Q?M6OiL064HzxeORQQtnt3EGVhjGoWYF/yyl5WpXvYSINUBnt6ni7rppwRt5hB?=
 =?us-ascii?Q?pHWxSCCj8CbSj4PAlL6rxiKjrL9nfMscVhGyd3m53S8izUVbPeoRxdSpYGCB?=
 =?us-ascii?Q?H+B+L//qLnJxk8GiBjxJP83rys5FmvRC1Xo3AIOOQzxQJbnJ3NqygShzXYoK?=
 =?us-ascii?Q?OmjyW7VF3mRj0F49/rdu6FxTF3zwPP3TO6cZaQlXlkLonXzg5qfUhVCXAvLl?=
 =?us-ascii?Q?xWvV7193CRyMc3Db4AO7q24U5NWpGUs5aZdZRCc8fXqlCA+A2HCBcwkC8YqN?=
 =?us-ascii?Q?F8q1Jp0+sv3Agt3ILxKSKmPGGdrgpt5xpK6w3Q5hIerT9bWTiVb13xw1x3ml?=
 =?us-ascii?Q?ZPCL9/mxaUtH6SVo+lmljkA4d+QORKRBFgvDVMq/4v6SI5GUJQ8WB3tohdsg?=
 =?us-ascii?Q?CJhU8r+G0adzHm39k2TnV5kuDnYMh2Eko1OJ/vXGeOgLRHicumZ0JkO4Tedo?=
 =?us-ascii?Q?8jA6V7zrU2yU31y6/UNfVbayzQAAfA32BOoZV8YKboNNKY46F/Av9+NP2O02?=
 =?us-ascii?Q?i1DitEMn7BQKbXunu1Oc4h0VTLLKqIz7VWkLfoZo8LauwepmfevYSL0Sekai?=
 =?us-ascii?Q?A5TqQl6qiG6nhBDiF1ZNOLFIdeE8ueyXdIRux5Dx1iDtIB1GaAvGWeNyyA7e?=
 =?us-ascii?Q?lvc1XlypaFZGwZvSB/ICsKGe6kKmQTp/TWH/h2EGskV3lRvPxwMAC8P4vl3O?=
 =?us-ascii?Q?9HdyDtMsoZegGSU3G10Zf4LbKLNoezypzzMkuEMCUXd+mi5M11Lz5lUeWjkk?=
 =?us-ascii?Q?9TYiqnhCrAkM7x8WPc+7qqL0FI2lVccQHpTRl2xgGilap9eYFDYY+vo6HEKP?=
 =?us-ascii?Q?nuLrB8zQ8A5D8Z3aqL/YCHgUyE+Ru8vpiAsQag9KEUXHHgP79av6PcV8xeDA?=
 =?us-ascii?Q?CxZUOc7ZpXRNvwl69/JDKDx47OLo3+vM4mzwVzZ+yMpZSk6X2BwjfAc43qkA?=
 =?us-ascii?Q?qJVHYBb2zA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e767cb-9425-4170-bec6-08de965fef1d
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:46:31.6259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJeKln175xZ49+s4AfQAtWQTpMkcjjI9StbKZDGtJb/YvE3pd0cU96tevEel9sSJ/199LlYGyYS392omVJE99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215

On Thu, Apr 09, 2026 at 04:57:44PM +0000, Kuba Piecuch wrote:
> * Add ops.quiescent() and ops.runnable() to the sched_change path.
>   When a queued task has one of its scheduling properties changed
>   (e.g. nice, affinity), it goes through dequeue() -> quiescent() ->
>   (property change callback, e.g. ops.set_weight()) -> runnable() ->
>   enqueue().
> 
> * Change && to || in ops.enqueue() condition. We want to enqueue tasks
>   that have a non-zero slice and are not in any DSQ.
> 
> * Call ops.dispatch() and ops.dequeue() only for tasks that have had
>   ops.enqueue() called. This is to account for tasks direct-dispatched
>   from ops.select_cpu().
> 
> * Add a note explaining that the pseudo-code provides a simplified view
>   of the task lifecycle and list some examples of cases that the
>   pseudo-code does not account for.
> 
> Fixes: a4f61f0a1afd ("sched_ext: Documentation: Add ops.dequeue() to task lifecycle")
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>$

Thanks,
-Andrea

> ---
> 
> Changes in v2:
>  - Changed && to || in ops.enqueue() condition (Andrea)
>  - Moved ops.dispatch() and ops.dequeue() inside the if statement
>    (Andrea)
>  - Added a note after the pseudo-code with examples of cases that the
>    pseudo-code does not account for
>  - Link to v1: https://lore.kernel.org/all/20260408091821.91063-1-jpiecuch@google.com
> 
>  Documentation/scheduler/sched-ext.rst | 43 ++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index ec594ae8086de..2d77ab4816a63 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -408,8 +408,8 @@ for more information.
>  Task Lifecycle
>  --------------
>  
> -The following pseudo-code summarizes the entire lifecycle of a task managed
> -by a sched_ext scheduler:
> +The following pseudo-code presents a rough overview the entire lifecycle
> +of a task managed by a sched_ext scheduler:
>  
>  .. code-block:: c
>  
> @@ -423,20 +423,25 @@ by a sched_ext scheduler:
>          ops.runnable();         /* Task becomes ready to run */
>  
>          while (task_is_runnable(task)) {
> -            if (task is not in a DSQ && task->scx.slice == 0) {
> +            if (task is not in a DSQ || task->scx.slice == 0) {
>                  ops.enqueue();  /* Task can be added to a DSQ */
>  
>                  /* Task property change (i.e., affinity, nice, etc.)? */
>                  if (sched_change(task)) {
>                      ops.dequeue(); /* Exiting BPF scheduler custody */
> +                    ops.quiescent();
> +
> +                    /* Property change callback, e.g. ops.set_weight() */
> +
> +                    ops.runnable();
>                      continue;
>                  }
> -            }
>  
> -            /* Any usable CPU becomes available */
> +                /* Any usable CPU becomes available */
>  
> -            ops.dispatch();     /* Task is moved to a local DSQ */
> -            ops.dequeue();      /* Exiting BPF scheduler custody */
> +                ops.dispatch();     /* Task is moved to a local DSQ */
> +                ops.dequeue();      /* Exiting BPF scheduler custody */
> +            }
>  
>              ops.running();      /* Task starts running on its assigned CPU */
>  
> @@ -456,6 +461,30 @@ by a sched_ext scheduler:
>      ops.disable();              /* Disable BPF scheduling for the task */
>      ops.exit_task();            /* Task is destroyed */
>  
> +Note that the above pseudo-code does not cover all possible state transitions
> +and edge cases, to name a few examples:
> +
> +* ``ops.dispatch()`` may fail to move the task to a local DSQ due to a racing
> +  property change on that task, in which case ``ops.dispatch()`` will be
> +  retried.
> +
> +* The task may be direct-dispatched to a local DSQ from ``ops.enqueue()``,
> +  in which case ``ops.dispatch()`` and ``ops.dequeue()`` are skipped and we go
> +  straight to ``ops.running()``.
> +
> +* Property changes may occur at virtually any point during the task's lifecycle,
> +  not just when the task is queued and waiting to be dispatched. For example,
> +  changing a property of a running task will lead to the callback sequence
> +  ``ops.stopping()`` -> ``ops.quiescent()`` -> (property change callback) ->
> +  ``ops.runnable()`` -> ``ops.running()``.
> +
> +* A sched_ext task can be preempted by a task from a higher-priority scheduling
> +  class, in which it will exit the tick-dispatch loop even though it is runnable
> +  and has a non-zero slice.
> +
> +See the "Scheduling Cycle" section for a more detailed description of how
> +a freshly woken up task gets on a CPU.
> +
>  Where to Look
>  =============
>  
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
