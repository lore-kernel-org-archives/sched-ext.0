Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEEB334C1D
	for <sched-ext@lists.linux.dev>; Sun, 26 Jul 2026 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051072; cv=fail; b=OPY8IIQxP3zDW1beEL5dag8MBzEFdj5a2pOzm4BkXDjSAB3ZZFHgOKOB7YGqCASIcZwr130m3wWD7bldZf/gqb7C0tv/NRqd8+y6NoOyU/+N0MGicd9sG6xVb+Y/gZgdHC/MRb/SrwkmRv1GMvgGgyMeqibXUXBcqPZCwpcJu8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051072; c=relaxed/simple;
	bh=WutLcg2ZqsaA2MroV5200ip9l7HQsvx/Geopq4d3QtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l9IajuqwolNsS82yoXYzT9KJOQD8vRSpW21HZ236gsXHYuylxKsmrpofko1XIdLpZWGSxR1SBj1U3ffu4AN1d/1zPTBu+pQfqGey/sMAQ9hEScuPFpIl0qSX/xgHlFbWGBSo8EmHbaxlx9/pcYImSlgJz3t046KzYWZfp0Ajfl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eIY6z3Nb; arc=fail smtp.client-ip=52.101.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eIY6z3Nb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPs5NAh7ZY27KdKRLu6ehObLjorkVPU5ceOFl6IH39Wtnc2H0f9P1X3xi/uCLlJ+JZmml3fatkhKpGBJUfJTrbQV7y3D+nFrxpdJkouHTLL4ouVDTHuJTbk5gcSoVTmDXgsFE6dOTRB3JZ3iyXmJdyjM4+EH4fWBl98j8tsv6CLM+sq2QFKPhCl7jDBUpXFXOb6U4WJoDC3F2pNavqvmKvBcb1nvSNdREwc2iNuxEic63k6n+Yxhjni8W8iaVdVIDAhLL+5a0yvDoipzXSpAEPsJMi0JNNLrR6nD3mo4kLIgjN2poGF/qUoHgDO+YlGswzTtHBoLGufuANHf5NUiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xHryA24GlZIidAguMNmSj3yZfzmVCcuziXpAYmBtkU=;
 b=IXXj+rg8wvfYpaxzGM76j87JYVf/r3/zbqGo/UOQviscORANm4qL7BbiYdociYNZ38Po5h6Pi00WluYtk4Qz9rxP0HiqCRpifxOjXwJkIvswQs38lmn81auIA1572N072qIupl2MRx0cvDynaFHQFAD1LslnPphFojPEqAnMRv0r5N004VbYa1g12/fhuvO78MN5XVbUCtYIk5Spa6gjo4kW1E7JzoO1R+Y1W5Z0II5HxPPP0BOIlLFoOtGNyQO+QqJVhU7/PFBRF1jgnCPan93e/ZK4B6piKWYCZAc52PDffH8tJc8IpBcnzyO0xVTrat8VgVKGR9VRDS2DkPYPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xHryA24GlZIidAguMNmSj3yZfzmVCcuziXpAYmBtkU=;
 b=eIY6z3NbMh0Q96aoxoTFMC827TyuYFs6u5rmSjzZJxwq2wfA+6TxJZkOOaR5grF13myJVcYeqEwPO7L5yvQ+ljuLZBmklhMy7vtRjKkkc/tAYnuQRJJP5uaaQp/zSST3P3a6JC2w1B2gvJziBl4m3+1JulqW7vZsA1xON2jy0zAZLPq6sqcCwqaVAtHMGQtKlFUtRLLFTHB6XtrbYqi50noscKkyXR0XBB0vRCaknKtvXUtwMlXz6FSOw1KLNC5BtgE6iO8FVWwv9xQN7L4c257NfqcLZsMMpJjjLom0Xu5VdBj/xqopRGA6iSdDCN/Jr0sHUOmtBU23szaotlrAsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 07:31:03 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 07:31:03 +0000
Date: Sun, 26 Jul 2026 09:30:54 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3] sched_ext: Bound per-task
 reenqueues and eject the owning scheduler
Message-ID: <amW3rqVgsXHBvj6u@gpd4>
References: <7f80005b54904a9a037822c2df5bcbc2@kernel.org>
 <2f7e89d4ee0ce10c24782ad35279a1bd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f7e89d4ee0ce10c24782ad35279a1bd@kernel.org>
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 741a44a3-6b82-4543-8ce3-08deeae7d8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|4143699003|11063799006|10067099003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TfraiGfO5Mr04cfdkfXO7d7lZMlseVS6nIPUn2EpCgTRewoTibUVuCNIjm8UFHv0iisqkc3DouHXhkZ0Kg3ci4Co9IZ2ByAcIA0hIe0zMrq4plPutI+MHPOcpPwTUHbzqwSy1/k1DtSWW0PPBPgikrS44Ve2DnxPL717yO8JH2hmxFZ0i8+Q68/GgYLPmrc3mO6WZHlbRVbE2HpvralUnLI4kW0IAgkKAJFXbAuylWFh7SYJTeGMo4b1fFScjgH43ELlS9W/G2cVAn9u8Ht3mmgE+1tg4++2NIZNZqthGKEYtnDrCK1Tsam737ian30zByBO2tt6f2/baf/nO9j/YgxLWu6OGRZIrwzVWgNZWYr1CA75TzgG+7iIEAI19LSjKnA1xnSpzP1nEcVt4i7UVdr+cRDSarPblXKbSC+/VZCYVX13RZSdA1B1qGQ2wtTXNfjnLNnd42C1VKR0yZJQADYivH4ucy9DCQ1EI0EVkikKDG2j6OEZzi618fx7AjPIzqsrwOx+5Ij/ncX9KU7k4rCOeFkX0bQqsOn0boxQo0IvSFzvmToC8AprRWC+CF+GWHR/84zJ3qFyWx9HkSTbpeqWc32O2MMEwQ5gEUgeNrLRSI3wBt/n9oUKvx0IGw43qTi7Nt1YHeel1kGROn6lHm6YXtgK99ZwNl9zMGP7xVA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PpRmZPWyF+PdK1fo6MCXjjeQtomFdH6FAlWTlj3sPE5o3LbJSzMO6tKf4Lmr?=
 =?us-ascii?Q?ZPZDK6kKU2a//uRUQcG4FuY2v/c8X86NILT+wG8dDfi0ixWvFV3eBXR119gr?=
 =?us-ascii?Q?D71DW0CV7hyaIjCpxVZo0GNgZL46ru+jsLh1QUKY0N5Els9nGyw9ErpQ/IvV?=
 =?us-ascii?Q?RmGRax5EoqvUQgFVYVKu3iBB6mfmu/paKtZ0HVLFhUTG0NtJCoryHOXVIOmV?=
 =?us-ascii?Q?hmmi8/incgzvgoWfuZOsAgPpwZcqzGIMxjUYRqaNLZBYFmwdQV0z0trhC42Z?=
 =?us-ascii?Q?zS4iTWzGKuVeMdQR1eybTChXHP5RTieM+oClkQCT3gMlD6pTQk/363BgHNVB?=
 =?us-ascii?Q?XNaYysCVNaPCo/Skfy/dd5ABc0N4Ek3/QIUZo5Qk5aYX0NOubMjdytNEF1Tl?=
 =?us-ascii?Q?iafKJl0ppoALoStvnCrfj3y4DTXNWiDg9MN3JOVFKdg6XqOVsGx9Yk4qo9Yl?=
 =?us-ascii?Q?21CVx57VqL+Zz15YaLRYNoed+9UZHvEaYoJVqF4+miYOPdzjVcbUeHgEX9rV?=
 =?us-ascii?Q?0kHzn4c2ZLXvkMbHRU8M4OExPJL74PepI/Lc+6Zm+18E/m+jTdZLJYPOmYqI?=
 =?us-ascii?Q?HgGD1+9NT8n3kFe3yCbhOPVMA1quXDb8gIs26i1WXWLc1j26QIero9RYKsyh?=
 =?us-ascii?Q?n7Bizf4uDWGP0IJy5h/r1wltl5wSH4yLjYkY3ttvxgHoodliEbNBiu6bFMuz?=
 =?us-ascii?Q?zWxl22Kq6N6eXEDSKgk1R///Zz3RBxSBqGiJZDRc3JfvZGQWOerECsStCd07?=
 =?us-ascii?Q?zoSy1+H6WXh5MTns+Dsw3uACazkXvpm3z2FDik4Cr5WH2YMJ/8L4xqetVu3C?=
 =?us-ascii?Q?gmfdEcKX0QphO+lvbzdrsnWvf2klXozt7TeBVsj/4YCWB6KHLPiTj23+NciC?=
 =?us-ascii?Q?NelNjb0PIJ6d+YGUXCWd0f0wlr/wR9uzPy4byfdJAy9aOwnD9zwJLggzKnxN?=
 =?us-ascii?Q?oOTgv7YWCqo1iQb6cgiLm/Fug+47PGbDoS4BKl1OcT1QGAl0MLya1D9jFAnz?=
 =?us-ascii?Q?TI01N2oXdtnZWwsLaaYQ6t6B+ItLCOYTYBDaPlmPLu0gan9+3anGG6P5y/Ig?=
 =?us-ascii?Q?iUeQ335MuGtsAw5aRqEB5kuFU71uJJiAokTQAHg9qvnWCQR4Wj2U37sYJ0kr?=
 =?us-ascii?Q?JqrikFZN67r6O0scidk2PQaJDtiFPgq7hXElsnJXoFk0iIMUaCGYy+8jWDES?=
 =?us-ascii?Q?BqwFL6NeIOam89L82+/BI+zvhPw2HMKrHUT7L76Ni5i7WosTpe52YSlPy9bG?=
 =?us-ascii?Q?siIABIJMca/kgox5PJzwPFEKT+EDNz/OTZrHO6qqgDqFMUbmVtKW9IT1nEeg?=
 =?us-ascii?Q?DYb7g+wgS98HVLzUTSkc4JfAGzrCvxGXCSboFQcjmFenfWwOVNXuxkmcLcre?=
 =?us-ascii?Q?lgC8VkvmA+q3bLTNuwiFMGZQYcIyr9g6GZfFp+rKGROG0rWtCssMAewhFXwv?=
 =?us-ascii?Q?vU88JQYiFNejweRjtfv5C1k97SePbcCOnq/A1QRpkHMeMQIbHSM5gzUqu0xs?=
 =?us-ascii?Q?0d8S/7qBwazyp5sc+0bIshT+JTBYLW2hqAo1Ui8N3icQ1aCKWZxqdivhmD3v?=
 =?us-ascii?Q?blG8AVXpNndDROJlkrJcPmUm2oUYs1ZAvlLpOdWN7JyebkbjeAonR2u517LJ?=
 =?us-ascii?Q?VY3WOzM1XcFc+TpzrZHuWTRjLDODN0sw9X1LL7zhWiti8BK6orAKqJbS6Ah4?=
 =?us-ascii?Q?18QBOPtAS8+bZhXm/xngvr4Hn7xQ/6BtQSVYlkbTY7rXUEzuanbFebyAsa88?=
 =?us-ascii?Q?+qJx99LZ/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741a44a3-6b82-4543-8ce3-08deeae7d8cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 07:31:03.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnpZ50W7siyAlWfoJkjVZAXn5j2UO0VH16qMZFPF3ypnRr3PiRCSceeX276x4qqD1UPjCGTsBKT1Hhysy8lvuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972

Hi Tejun,

On Sat, Jul 25, 2026 at 09:05:39AM -1000, Tejun Heo wrote:
> Unlike local reenqueues, cap rejections have no repeat limit. A
> malfunctioning scheduler can keep re-inserting a task to a cid it lacks caps
> on, cycling the task through reject and reenqueue. This was assumed safe
> because a task that never runs trips the stall watchdog. However, the
> reenqueue irq_work re-arms itself and outranks the timer vector, blocking
> everything else on the CPU including stall detection and recovery, until the
> NMI hardlockup detector fires.
> 
> Local reenqueues already have a repeat cap, SCX_REENQ_LOCAL_MAX_REPEAT,
> which needs generalizing to cover all reenqueues. It also has an attribution
> problem. Counted per-cpu on root, it tears down the whole hierarchy for a
> sub-owned bounce.
> 
> Generalize by bounding every reenqueue with one per-task counter. reenq_cnt
> is bumped in scx_do_enqueue_task() on each SCX_ENQ_REENQ, the single funnel
> every reenqueue producer passes through, and cleared in clr_task_runnable()
> when the task is picked to run. Past SCX_REENQ_MAX_REPEAT the task's owning
> scheduler is ejected with a new SCX_EXIT_ERROR_REENQ and the task is left
> stranded to be picked up during sched exit.
> 
> The SCX_EV_REENQ_LOCAL_REPEAT event becomes SCX_EV_REENQ_REPEAT, counting
> repeat reenqueues from all sources.
> 
> v2: Count SCX_EV_REENQ_REPEAT only when a reenqueue leads to another
>     reenqueue, not on every reenqueue.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/sched/ext.h   |    1
>  kernel/sched/ext/ext.c      |   57 +++++++++++++++++++++++++-------------------
>  kernel/sched/ext/internal.h |   19 ++++++--------
>  kernel/sched/ext/sub.c      |    6 ++--
>  kernel/sched/ext/types.h    |    2 -
>  kernel/sched/sched.h        |    1 
>  6 files changed, 46 insertions(+), 40 deletions(-)
> 
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -198,6 +198,7 @@ struct sched_ext_entity {
>  	u32			dsq_flags;	/* protected by DSQ lock */
>  	u32			flags;		/* protected by rq lock */
>  	u32			weight;
> +	u32			reenq_cnt;	/* reenqueues since last run */
>  	s32			sticky_cpu;
>  	s32			holding_cpu;
>  	s32			selected_cpu;
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1892,6 +1892,24 @@ void scx_do_enqueue_task(struct rq *rq,
>  	p->scx.flags &= ~SCX_TASK_IMMED;
>  
>  	/*
> +	 * A task reenqueued too many times without running means the scheduler
> +	 * keeps re-deciding a placement it can't honor, e.g. re-inserting to a
> +	 * cid it lacks caps on. Eject the owning scheduler and strand the task
> +	 * to be picked up during sched exit.
> +	 */
> +	if (enq_flags & SCX_ENQ_REENQ) {
> +		if (++p->scx.reenq_cnt > 1)
> +			__scx_add_event(sch, SCX_EV_REENQ_REPEAT, 1);

Should we consider only consecutive kernel-driven retry reenqueues here, rather
than every reenqueue? IIUC, the paths we need to limit are SCX_TASK_REENQ_IMMED
and SCX_TASK_REENQ_CAP.

> +
> +		if (unlikely(p->scx.reenq_cnt > SCX_REENQ_MAX_REPEAT)) {
> +			__scx_exit(sch, SCX_EXIT_ERROR_REENQ, 0, cpu_of(rq),
> +				   "%s[%d] reenqueued %u times without running",
> +				   p->comm, p->pid, p->scx.reenq_cnt);
> +			return;
> +		}
> +	}
> +
> +	/*
>  	 * If !scx_rq_online(), we already told the BPF scheduler that the CPU
>  	 * is offline and are just running the hotplug path. Don't bother the
>  	 * BPF scheduler.
> @@ -2013,8 +2031,10 @@ static void clr_task_runnable(struct tas
>  {
>  	list_del_init(&p->scx.runnable_node);
>  	WRITE_ONCE(p->scx.runnable_cpu, -1);
> -	if (reset_runnable_at)
> +	if (reset_runnable_at) {
>  		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
> +		p->scx.reenq_cnt = 0;
> +	}

Should reenq_cnt also be cleared in scx_disable_task(), together with the other
SCX-managed fields?

Otherwise, the count can survive switching the task to another scheduling class,
replacing the BPF scheduler, or rehoming it to another sub-scheduler and the
next owner could then be ejected based on the reenqueues from to the previous
owner.

>  }
>  
>  static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_flags)
> @@ -4053,8 +4073,8 @@ static void process_ddsp_deferred_locals
>   * Reenqueued tasks go through ops.enqueue() with %SCX_ENQ_REENQ |
>   * %SCX_TASK_REENQ_IMMED. If the BPF scheduler dispatches back to the same local
>   * DSQ with %SCX_ENQ_IMMED while the CPU is still unavailable, this triggers
> - * another reenq cycle. Repetitions are bounded by %SCX_REENQ_LOCAL_MAX_REPEAT
> - * in process_deferred_reenq_locals().
> + * another reenq cycle. Repetitions are bounded by %SCX_REENQ_MAX_REPEAT
> + * in scx_do_enqueue_task(), which ejects the task's owning scheduler.
>   */
>  static bool local_task_should_reenq(struct rq *rq, struct task_struct *p,
>  				    u64 *reenq_flags, u32 *reason)
> @@ -4162,14 +4182,16 @@ static u32 reenq_local(struct scx_sched
>  
>  static void process_deferred_reenq_locals(struct rq *rq)
>  {
> -	u64 seq = ++rq->scx.deferred_reenq_locals_seq;
> -
>  	lockdep_assert_rq_held(rq);
>  
> +	/*
> +	 * A task can be re-queued within this loop when a reenqueued task
> +	 * bounces straight back to the local DSQ. That recursion is bounded by
> +	 * the per-task reenqueue cap in scx_do_enqueue_task().
> +	 */
>  	while (true) {
>  		struct scx_sched *sch;
>  		u64 reenq_flags;
> -		bool skip = false;
>  
>  		scoped_guard (raw_spinlock, &rq->scx.deferred_reenq_lock) {
>  			struct scx_deferred_reenq_local *drl =
> @@ -4188,27 +4210,12 @@ static void process_deferred_reenq_local
>  			reenq_flags = drl->flags;
>  			WRITE_ONCE(drl->flags, 0);
>  			list_del_init(&drl->node);
> -
> -			if (likely(drl->seq != seq)) {
> -				drl->seq = seq;
> -				drl->cnt = 0;
> -			} else {
> -				if (unlikely(++drl->cnt > SCX_REENQ_LOCAL_MAX_REPEAT)) {
> -					scx_error(sch, "SCX_ENQ_REENQ on SCX_DSQ_LOCAL repeated %u times",
> -						  drl->cnt);
> -					skip = true;
> -				}
> -
> -				__scx_add_event(sch, SCX_EV_REENQ_LOCAL_REPEAT, 1);
> -			}
>  		}
>  
> -		if (!skip) {
> -			/* see schedule_dsq_reenq() */
> -			smp_mb();
> +		/* see schedule_dsq_reenq() */
> +		smp_mb();
>  
> -			reenq_local(sch, rq, reenq_flags);
> -		}
> +		reenq_local(sch, rq, reenq_flags);
>  	}
>  }
>  
> @@ -5925,6 +5932,8 @@ static const char *scx_exit_reason(enum
>  		return "scx_bpf_error";
>  	case SCX_EXIT_ERROR_STALL:
>  		return "runnable task stall";
> +	case SCX_EXIT_ERROR_REENQ:
> +		return "reenqueue limit";
>  	default:
>  		return "<UNKNOWN>";
>  	}
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -56,6 +56,7 @@ enum scx_exit_kind {
>  	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
>  	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
>  	SCX_EXIT_ERROR_STALL,	/* watchdog detected stalled runnable tasks */
> +	SCX_EXIT_ERROR_REENQ,	/* a task hit the reenqueue repeat limit without running */
>  };
>  
>  /*
> @@ -1119,15 +1120,13 @@ struct scx_event_stats {
>  	s64		SCX_EV_REENQ_IMMED;
>  
>  	/*
> -	 * The number of times a reenq of local DSQ caused another reenq of
> -	 * local DSQ. This can happen when %SCX_ENQ_IMMED races against a higher
> -	 * priority class task even if the BPF scheduler always satisfies the
> -	 * prerequisites for %SCX_ENQ_IMMED at the time of enqueue. However,
> -	 * that scenario is very unlikely and this count going up regularly
> -	 * indicates that the BPF scheduler is handling %SCX_ENQ_REENQ
> -	 * incorrectly causing recursive reenqueues.
> +	 * The number of times a reenqueue (%SCX_ENQ_REENQ) led to another
> +	 * reenqueue without the task running in between. This count climbing
> +	 * rapidly indicates that the BPF scheduler keeps re-deciding placements
> +	 * it can't honor. A single task reenqueued more than
> +	 * %SCX_REENQ_MAX_REPEAT times gets its owning scheduler ejected.
>  	 */
> -	s64		SCX_EV_REENQ_LOCAL_REPEAT;
> +	s64		SCX_EV_REENQ_REPEAT;

Documentation/scheduler/sched-ext.rst still uses SCX_EV_REENQ_LOCAL_REPEAT in
both the sample events output and the counter description.

The description also says that the event is specific to local DSQ reenqueues,
while SCX_EV_REENQ_REPEAT now covers reenqueues from all sources. Can you update
those two references as well?

>  
>  	/*
>  	 * Total number of times a task's time slice was refilled with the
> @@ -1202,7 +1201,7 @@ struct scx_event_stats {
>  	SCX_EVENT(SCX_EV_ENQ_SKIP_EXITING);				\
>  	SCX_EVENT(SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);			\
>  	SCX_EVENT(SCX_EV_REENQ_IMMED);					\
> -	SCX_EVENT(SCX_EV_REENQ_LOCAL_REPEAT);				\
> +	SCX_EVENT(SCX_EV_REENQ_REPEAT);					\
>  	SCX_EVENT(SCX_EV_REFILL_SLICE_DFL);				\
>  	SCX_EVENT(SCX_EV_SLICE_CLAMPED);				\
>  	SCX_EVENT(SCX_EV_SLICE_DENIED);					\
> @@ -1238,8 +1237,6 @@ struct scx_dsp_ctx {
>  struct scx_deferred_reenq_local {
>  	struct list_head	node;
>  	u64			flags;
> -	u64			seq;
> -	u32			cnt;
>  };
>  
>  struct scx_sched_pcpu {
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -319,9 +319,9 @@ bool scx_task_reenq_on_cap_revoke(struct
>   * Drain @rq->scx.reject_dsq, reenqueueing each task so the BPF re-decides
>   * from p->scx.reenq_reason_*.
>   *
> - * A task can be re-rejected repeatedly, and there's no repeat limit here.
> - * Rejection can't happen for root, and sub-scheds can be safely ejected after
> - * triggering the stall watchdog.
> + * A task can be re-rejected repeatedly. The reenqueue is bounded per task in
> + * scx_do_enqueue_task(), which ejects the owning sub past SCX_REENQ_MAX_REPEAT.
> + * Rejection can't happen for root.
>   */
>  void scx_reenq_reject(struct rq *rq)
>  {
> --- a/kernel/sched/ext/types.h
> +++ b/kernel/sched/ext/types.h
> @@ -41,7 +41,7 @@ enum scx_consts {
>  	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
>  	SCX_BYPASS_LB_BATCH		= 256,
>  
> -	SCX_REENQ_LOCAL_MAX_REPEAT	= 256,
> +	SCX_REENQ_MAX_REPEAT		= 256,
>  
>  	SCX_SUB_MAX_DEPTH		= 4,
>  };
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -823,7 +823,6 @@ struct scx_rq {
>  	struct list_head	sched_pcpus_to_kick;	/* see kick_cpus_irq_workfn() */
>  
>  	raw_spinlock_t		deferred_reenq_lock;
> -	u64			deferred_reenq_locals_seq;
>  	struct list_head	deferred_reenq_locals;	/* scheds requesting reenq of local DSQ */
>  	struct list_head	deferred_reenq_users;	/* user DSQs requesting reenq */
>  	struct balance_callback	deferred_bal_cb;

Thanks,
-Andrea
