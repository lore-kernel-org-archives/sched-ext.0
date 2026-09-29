Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012030.outbound.protection.outlook.com [40.107.200.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313C54856E
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706841; cv=fail; b=AHsEHZhnVQt3KajuG2QSGsdMToqFbUTKu6NT+1Kz3vn/zZSj5bbwBUclzhy7rFpG35+453tstr+Fu2E12JUwEoYF0AwbFwxy+ZR+zK1wXOaqu6ghn/s/VO79Xd7fUtKfvVP9+WdJq7n5otcqd/hpnWJcvXOCfyKi2sOP5EcVv1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706841; c=relaxed/simple;
	bh=2rK8LKpDh1P+DhCmHsw9FyQfYr6bzzDEpcqgf4bgEAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sg4QEia++7OVtSwhySmV+Mr5zukJKv2h7BZ6HOtK1zx5YkUJ7QICJGyYJpfvnikeB5MRKO+zGVd6dGpG+ABT7sKR4QM3ypDKug2W45aFPa2EJcNMpdUPh1KWF+KIRo2WwHK9Yui9nQr2kJTBwBHFAc5BsvqxrhLCJMkYFJ/4184=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EBY1Zf5d; arc=fail smtp.client-ip=40.107.200.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EBY1Zf5d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoAyBFyGdFdlZT7R9/eSHYKinvUXZq+UDJ5AOnPKGWoCUBFN/y2viJp1NH7mjPBH+O05jn72kdHfyz0VyFOlPJ00d9/jsTpsKOzOqvu4truGuz7iEX9beTD5sqvZPB6PjcagPAednCdRqUXXlu4Pt4B7dgHZ+eHebewZIkKZrOGX9LRURgiZQMbJH8B7rxb/utyRYTe1QVgRHYIgoigXDYxr0sUpoSZb+gc+z8gzjxmL2XHn/BPHKDsh6iX+M5g5HwHJKfmUGXfb/rRJaBbZ7j/UO7AiCt7zg4YqOM35Sgp7ZQhpL9V4/+cQUNW3aQvPq6fZqNashn24xtbjfXbfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh4hJ44zUxXi++rynGcz1zXDqFHRmtEdfy9xJ8yIVFM=;
 b=DjrO7VZo/DodR/5cupkKVH/7EK1/vQDcBgRmH2KNmziKAQnNKAYYt93E69c2Pkpy7i+pgCM4XeTV7WOg6m3rtlBPT8LNApDW2vG+41xwFqQ0hlV2aCMC3Nj6BJtRxldgmQX1InyhUIgFtGIsnD1uV7iGoBsy5eMTsuNdmgV5d/yaLTVHHydEfXCEUgAVTGKR70ObEYiGfLY0V3h4F/eUty35iJ7V0FPrFAPeh/mOTvRFWDpztRy0Lr/GlkKwub2JcS4pnPQ7T0MAsq+b8a2wkrCio5KXXWAosiLpEz8K76TkBXPx10IHpXCkHk8R8VWw7/sDrdDabxn66zj+kE/v1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh4hJ44zUxXi++rynGcz1zXDqFHRmtEdfy9xJ8yIVFM=;
 b=EBY1Zf5dUVkM38/uJLmsQWdQSAak14+dkdZlvj9Y1cBiHqg8+BWzU0/vX6Xe8cjokArPpy4XfJvABEuHteM7bMGhZ51AWJ6dTjIH1PMhSGYSP7ZgsLy+kLLge0zdbZiBauLuyD7cVNSnBdNSwnUAh8GcYm0H9HHKSYK3vSgKKSABY8nWP+JRd+CL56nRlNVWBT6STsvy8RDKyNblNn44sR+oTyxVKEoALAcJN1uES08MyrTqVK04Dgsh0jK6s4y+fRFKVYnysPKtojR6chSAIS97R/PN3nR5s0bSO9YyJJCakBVNq97op7gFp8eiG58n9ofWD9yfOa9yom5d/K7dxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 18:33:53 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 18:33:52 +0000
Date: Tue, 29 Sep 2026 20:33:45 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Call ops.dequeue() when a task arrives on
 a remote local DSQ
Message-ID: <arwEiZVRNlrOosFi@gpd4>
References: <20260929161730.185271-1-jpiecuch@google.com>
 <20260929161730.185271-3-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929161730.185271-3-jpiecuch@google.com>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 254d2cb1-a7ad-47f4-6e95-08df1e583637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|4143699003|10067099003|5023799004|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/bZwViR7XhA55c9J1wpIBBtjjkOKcZFcE0ena7GP+GTCDbHoWu//9s5ZRhqm9axyXk/wx8nAM+5Qap+0lbZv72hz5I7Z8sXq7b6K/AmdX3+fH9A3abYxp6RuntmB40u72bzxULfiicSSegRHd01PVIcbE1XzMlQi1efPsSMDbHK1aulKP1stvKC0yahQAGyC74t1+9PC5DdLcU+tykwnveLjp/t/FwvyFKJU3/Y2OqkAceaPdjn6ZBXeO7Qvmp1wyF07VuYdtQ2DGS2ofu9ftYW4xHt90jXV0Yy3dISHCxpEhikVjJm2H2K4qO1rTZuZQRTXCIn3XsAUuYDo0bLoT7oJD51BjoWNqO0Jsm9n/jEVLtr2Ppcx5VZwFgbg8E6YRcsJvDOjMCbvBjOmGICMpBW46nEqFaV3EkR0DCj8dOodW3Y4v606hGk/xJtJfZGw4jvMIsjbZWHLUtZ8d+V0sr6hr5UC7hLvH8ZznXrARadnx+u/uPEnKEJn6nVMb8SYpQ44UYnIqq5dTpbaeIiQzhfUU24/5jxk3TGBH99snpLO59aQzla9X046QaVBW5hEjlkVTMBCFE6jCqMHHHe1dxrzR912sOO41VHJJN8pUrNc4yUpsW3G5UtFZ2mCAhs1gtg+IsHNjzvneN0NbXqCmNgu/ldymsnYGW6p58u7Ym8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(10067099003)(5023799004)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cG+7mGTAibpNcVDbz/tG6K3zqNDKpV5ZjtQls2ZJoZvKTxa7ttOvHDe93dx6?=
 =?us-ascii?Q?cG5DprycPUi2ejt9q9XTybBErwuCrmKtsKvJSBOGNXnNbi5CkujG3ZCFH5FL?=
 =?us-ascii?Q?59T0HSTPN+td8jYcNJVhZrTAGpW7+sBq7xBweOcgyDiBgmxUl3yJFVRatkKi?=
 =?us-ascii?Q?VJE/g7LOB7l8puEywlh/p86pu6c8opfYqRKvZYXGRE1Q8blIj30H7gQGRqDa?=
 =?us-ascii?Q?9OZ4eiwjDOBv7bDP/nBcN2g+TtxPcx5yyTAVfWG8kUUhCqYcL9MIdKNT7GCR?=
 =?us-ascii?Q?5xyWQJyJC+7GJgJAN3LcINR76Nmur1+/jOOdoChjuH3c0Atsf0jZJConx+lU?=
 =?us-ascii?Q?nzRwLD7N9VJwXOgUNDq8LjHrcZfrB2cSMHaItuU5PfmhUhjJf0sgfrLNYWRm?=
 =?us-ascii?Q?2NZbK9p1Hd1nYGHZ8lfUXMbtPPsZdJIaYz7+fmnFE5g/MFm5R0OgNQdgMiBb?=
 =?us-ascii?Q?BZqwLPtVVQeRnP54+mG9R4z19RvYtRBK7QEFCrcaQ6DqRSxnED1QEDEhEiJq?=
 =?us-ascii?Q?a+DJ5wQgDHTziCE1zijY/RjSnBjz5I9FkjoRZPdHba81YJvCFKCK6MkzdZS4?=
 =?us-ascii?Q?riLyXilBi7r42te5pPU01DhSBybEWWN9YUg6MutLd7IngFa7ImLkqg8AFpmO?=
 =?us-ascii?Q?EXpSq2pwH3IlMoACU9+ev2RhakkVQlEDIMLZGsjDylkOAlXoUxwL88Gb+4Ql?=
 =?us-ascii?Q?SKer8kKDNAkYPlZ9ahH3+L5QHendgNmd9+ERBsPN+EIinMCma7Zgrh+fKwhY?=
 =?us-ascii?Q?ca8d75E2JnAihSjAWaHb6cMUid82h+ibpGKhPwOMoVIBVIZKFsUhoPKzUpUj?=
 =?us-ascii?Q?APYrHlFChJuLeKu90FULo+8q2nu5Ws6if2ukvMr0jwOq+4fcXU5W3Yg/4oTq?=
 =?us-ascii?Q?NjgyowZ2y4yuXx2M/SzAkVlLxb0dhLf37B8RlzhpVO1pRv4bAJXpUqZdJB7V?=
 =?us-ascii?Q?1lLrEgOPzZxKnRKKlDRNXONod+KOIr+xmbr6VkzMpslPTozrbX6bwa57XRc6?=
 =?us-ascii?Q?gPaPOGBCaOZSrMORERcmJQkr5+s1a+mIs08ELBX5EYSzu0pIGXr2xB/wgY12?=
 =?us-ascii?Q?u23GFj58vpz3x72hudg0NGbZtb3Mw6W2ltTQYPzEPAKW/peWWxwtT4drlopM?=
 =?us-ascii?Q?MUyxQ+7+3UKTpdzIgdrzJqEhQ7hKoi4iaflWP2zUqobecI317Fa8Lpfnp+Fj?=
 =?us-ascii?Q?Bzs++0CicHgtSbF15DjPJuT6INjzfrnKaUFMMl9tegOznngWG7X1yhh4hNvJ?=
 =?us-ascii?Q?WyHcY4SfHSKnzndKK4HLS1P6AXRkwS2hbS6x5pyf5giI62rYF2cPzAmwdVZB?=
 =?us-ascii?Q?KFfTvxB21llY8Hgf54zoi/PG76qnwx5wCuB+ordTx2twQFSvoXw5g/YuVO1S?=
 =?us-ascii?Q?CzOK/g5CluZ3RTnYvvzqIpk8fEi6NjQmk4NrxMxplW9haczzout6jMyJ4l0Y?=
 =?us-ascii?Q?zO9sQkadtghssg32z3mXJ0kLWrTYa2xHtim+9HSOcSEgbrQ0vc6LIZ4Zj7nX?=
 =?us-ascii?Q?SCFMvQ6R0UIecBYw1NYL45i0/CjLN2NQtGfmdvWMT8auuCA7NvSardTdXTws?=
 =?us-ascii?Q?uLSCu4ylAmkZ87BUVk15s1uKcMYJlpuTuSAxrgI8RbtrKQc5Z8bH/a7d2HNr?=
 =?us-ascii?Q?Gspm0DIdhGH6N1kh8msQdy+P9yBOVH5tTfD9tRo+TVrD0nOiyLvy+Ug5XE4U?=
 =?us-ascii?Q?V5+w4ZIkrFkLx4NZh6gqM2tgx5VQKuk78LaVokMKFfYY1KbuVC9Kp2LuUyOI?=
 =?us-ascii?Q?zDl5aAe/Fg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254d2cb1-a7ad-47f4-6e95-08df1e583637
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 18:33:52.7944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwHrXACxXXU98yixrnmSROl9ANW0hYCmjALSFFJyQSwMMO6sbPlaZ7tNd5pSrzWt77m3ucJhpmYv/RVcKdemKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

Hi Kuba,

On Tue, Sep 29, 2026 at 04:17:25PM +0000, Kuba Piecuch wrote:
> When the BPF scheduler moves a task to the local DSQ of a CPU other than
> the one whose rq the task is on, e.g. with SCX_DSQ_LOCAL_ON dispatch,
> scx_bpf_dsq_move_to_local() or scx_bpf_dsq_move*(), the task is migrated
> by move_remote_task_to_local_dsq(). p->scx.sticky_cpu is set across the
> migration so that dequeueing the task from the source rq isn't treated as
> the task leaving the BPF scheduler's custody.
> 
> However, enqueue_task_scx() only clears p->scx.sticky_cpu after
> scx_do_enqueue_task() has inserted the task into the destination local
> DSQ. task_leave_custody(), called from rq_owned_post_enq() on insertion,
> still sees the migration in progress and skips the custody exit. The task
> ends up on a terminal DSQ with SCX_TASK_IN_CUSTODY set and without
> ops.dequeue() having been called.
> 
> The custody exit then happens only when the task is picked for execution,
> in set_next_task_scx(), which reports it to the BPF scheduler as
> ops.dequeue(SCX_DEQ_CORE_SCHED_EXEC) even though no core-sched pick took
> place. If a scheduling property change hits the task while it's waiting
> on the local DSQ, the BPF scheduler instead gets
> ops.dequeue(SCX_DEQ_SCHED_CHANGE) for a task that has already left its
> custody. Both break the ops.dequeue() semantics, under which a dispatch to
> a terminal DSQ ends custody with an ops.dequeue() call without special
> flags.
> 
> Clear p->scx.sticky_cpu before calling scx_do_enqueue_task(). The routing
> decision in scx_do_enqueue_task() uses the local copy, and the departure
> side is unaffected as p->scx.sticky_cpu is still set across
> deactivate_task(). ops.dequeue() is now invoked on the destination rq when
> the task is inserted into the local DSQ, as it already is for same-rq
> dispatches.
> 
> Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
> Cc: stable@vger.kernel.org # v7.1+
> Assisted-by: Claude:claude-opus-5.5
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
> ---
>  kernel/sched/ext/ext.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index ad391a8cbd05..763de7797056 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1501,8 +1501,9 @@ static inline bool task_scx_migrating(struct task_struct *p)
>  	/*
>  	 * We only need to check sticky_cpu: it is set to the destination
>  	 * CPU in move_remote_task_to_local_dsq() before deactivate_task()
> -	 * and cleared when the task is enqueued on the destination, so it
> -	 * is only non-negative during an internal SCX migration.
> +	 * and cleared in enqueue_task_scx() on the destination before @p is
> +	 * inserted into the local DSQ, so it is only non-negative while @p
> +	 * is in transit between the two rqs.
>  	 */
>  	return p->scx.sticky_cpu >= 0;
>  }
> @@ -2189,10 +2190,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
>  	if (rq->scx.nr_running == 1)
>  		dl_server_start(&rq->ext_server);
>  
> -	scx_do_enqueue_task(rq, p, enq_flags, sticky_cpu);
> +	/*
> +	 * An SCX-internal migration ends once @p arrives on the destination
> +	 * rq. Clear sticky_cpu before enqueueing so that @p leaves the BPF
> +	 * scheduler's custody when inserted into the destination local DSQ.
> +	 * The local copy in @sticky_cpu is used for routing.
> +	 */
> +	p->scx.sticky_cpu = -1;
>  
> -	if (sticky_cpu >= 0)
> -		p->scx.sticky_cpu = -1;
> +	scx_do_enqueue_task(rq, p, enq_flags, sticky_cpu);

Nit: nothing between the top of enqueue_task_scx() and scx_do_enqueue_task()
looks at p->scx.sticky_cpu, so p->scx.sticky_cpu = -1 could go right after
reading it into the local variable, as it was before b75aaea24c9f. Same
behavior, but it also covers the SCX_TASK_QUEUED early exit, which currently
leaves p->scx.sticky_cpu set and essentially makes the fix a revert of the
enqueue side of b75aaea24c9f.

Either way:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
