Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31EE3CFF73
	for <sched-ext@lists.linux.dev>; Mon, 27 Jul 2026 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180936; cv=fail; b=dpcrVBASy+KP11n8OalRD3rw01fQck9AZG6tJKJUPURQ9tDwdL8jd6wqolBKNzVOHVA+g2TtNdwZy44/ZpIsiC41uxNBqbb/UnQhSqPyHb3I8wEtdHq8F33u6/gX+PQREwuQdlG54f3UzeUuib392/qDR79+Q3Upb0rJclSqfZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180936; c=relaxed/simple;
	bh=ID58014XbiH/qgwPLC9MDYj5GQaNcxAlrPc5Z/6L/Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h43NI00BiArlIVCT8Pz6ueTgUvMYqPhR1M5IV9P65Yc1aW6XYttdKMiUU9YhBOe+2oGigNWDSYLKsgHKXCPI16smINZ2qKtBfUBROGSHhMtWn3A/xXY0ht6o0kOVYGNq/gc40jXqyB0NE2q5s0X4oykHsarMNvFbwRT+AxWPaTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p1NiwOWu; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p1NiwOWu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9ot7VenT6aVqmmxoT70viN8PBd6WC8PvqufMn+DszjAjaEzq1bPni7ty1WGaYC0Noul/68RRQhiiWjG0NtPc+pErL0bIQBxnlzoQjydUBFt0qc0syaLwhSHIFuYKJs3Uu8lTWjhm7Rn60qgfUujJvd6StFpJcqG0BQZVn82lTvV2qpgcMg2mKJ2egNti8HcO1+GONd3F6La0RoJtQo2aZpqh31fBTyVfqd0j01Q5J42qkYd46i4DuWdmmwlT94y8EgD3b+NoO4+eKM4v4j4M7w0v9wsQg+8xqG1+GSlcQBiGEhSRGCQXxZyESVmbz+mo1Gi6KAAWL+x1LFw1zT/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2+Uz4IeI06x3c5mjb+/YPtxNRKMpMkXiiRpLhOvX6c=;
 b=bJmi2QTlI0LftNzcXSj1D0fBPfAsmCldzvmbL11CBhmWlWp+qDkwDY7i79ZZGpOeSVmXNgoQ3bwRZV5YFCS9hu1EPu7CYLct+EQqvV+kcjSN7Wo+pPmbwFccXs7j8ijIvHP5KjMa2r8v9uyIhMECZDwpjs2Lv1x151akk0SkY4q/e/hrr0/NsrqsIkJ7GOBCBWyPWYEyPzPLMe6rdT0Ry3Hc7o3XGH1ajK/MTGradp3eHzCqiQOl6Yirm18L9u0yAZ4gYz3lNZCWziBYJz+i5L6k5MK23yImPi/P6pXDS4p66H6vEc4vyiSvtbi25zHbtZSk1g4epy6W9ANUKdk4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2+Uz4IeI06x3c5mjb+/YPtxNRKMpMkXiiRpLhOvX6c=;
 b=p1NiwOWuQI0IJ17WI8iVgCW9MNJopaFu9am4g+TTHSNBdiIusGfBDAVuN51OkJYqoQW6es4BgEYtdHBOYDeZ6Ya0idloWo2M1fwvuykvpgHzx7vFE0XdVfTPvz0mn8B9aAtX8fERDjWJqoeYLmuSkqdldcVDTuhcuHy0FaHRO7dH6MhaddkNfajfLNFpHBtl3EsIqi0R69CYb5sag1kF2iLJn6j25TCxg2kbJA6aKEb1p3crFl191kpo3ZDJBAYGewCqx7lF4+lNGuk0xHgXHP3XLigetyJvUMLqTe18K6ibR9e1KF0oVmQF+dURFdFOPLfOH1RXUlT37n5hsfbCHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:35:26 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 19:35:26 +0000
Date: Mon, 27 Jul 2026 21:35:12 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched_ext: Make exit claiming lock-free
Message-ID: <amey8FunQb8M7qwI@gpd4>
References: <20260725005019.1297049-1-tj@kernel.org>
 <20260725005019.1297049-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725005019.1297049-2-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d32bb25-4c12-424f-9206-08deec16352b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Nr7qvuRA5txWzYDG/g2YhwM2lqNHA1JaPxSUD1WmqsUo9Hd4eYUJzn4gRK2+iEOQOViZJ0c6QIMsBtSfeCXrd39nlcRVw/1iGziDbo21fjpddHBJYtX28keVuEC3Y9dDMgZf6fGT+04a+6BJP6VMQinvro/GpXYBqTl4gYhwHO2UGAZRWEGgZt2Pdck0FH5NOEvGeeU2GOMhA/xF+NGq1U69RC++7pk+O91wllYkCJjgRmfWo4XUkPkyDcuWbbseLTvK2N3Z/Oc8S2LyMucAlXaaYn5bve2KC1+uxYr2nvTVcYfZpn/7tSnU5gvG+uvFxo0MXCKVrvCj+uvtBZ2kdfP41SIBZuvuz3Y7YXpcYZbdbSs2VQctok54Pf4Y10/opWTO8Tr3vFQfp7rC7MYvZjX2psB5GjW8odqKyjhLNMbA7FtLxyjLFT78fErit+WvSr8tis0sp0VUOBU8BBNzguqdwh/PhR+E0eLSev31kgX6tdNJJ0u/RewkZtQaHjcwx2P/3imTWo8EB1sdOANsmV11HwtnTukutjxclWBW16ocuR1bE1EaYTUmVCe9OMxUVd0orUXqVIif+32E/DN3Py8jnsLQ9MuyTvboR2rEufQCt4IQbE9hPDIVrcTGA+/XeDBHvyahSkoQiq/wPIfzl1XBw5sUkATd3hQMZ6xqW5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w3QjAFSXllvgUSXFH7Gs7vS1MjPcgfsPhLvZlE4eArEA/wFKAGS6fTlQdxT6?=
 =?us-ascii?Q?fd978NsKdxvGa9VsAarTc8uP0hW/KunWKpHEW8O4GGcSLRCMcLWV4CXemf3W?=
 =?us-ascii?Q?0GSS4ItR8eb3HmnqSYfowuPyOkGlfFzP82wopt79DBzXnvDi9LelRN9H8fvn?=
 =?us-ascii?Q?5z88DvAGAYeKEwF3r9Q1FB9bnMOEcrEX3FyFtsJompKjqxV7ZfFXEqm5sm/0?=
 =?us-ascii?Q?Vcq95obbXqNNQ1pwrrOUuc4BqMZeqIjQX9iJM2VxqSLs5YXUweqjub7YS3b6?=
 =?us-ascii?Q?3mana7ZzW0NwDwzDgIkDAkhThu0asusvpv0mMgJr3JFVib7tWwR0Wi0i9ou8?=
 =?us-ascii?Q?Ill//Qx/F5kl54FWksv+wf1XaF0BoOcA8QOKCmOPdLwBejtagukDIUyaAWzc?=
 =?us-ascii?Q?zbHWHPCwL4GkINK54gFhHVC3WFkRvrtdvf6nvkfSsdeOVsjmKDIHSXX72m2Z?=
 =?us-ascii?Q?ENKlm12WqTNZHEGPPzijUwzvFijMVSudC/WHjo6NAEsoX0snxRPQ8a5UelK1?=
 =?us-ascii?Q?FmPTjDx24KRiRxZ3gAImStpbuaE2OSw67rcQNy7LrUXefYqegHB46/plLOUP?=
 =?us-ascii?Q?wY3AaD/ZtS8HQEU3mANPLJzvbGsCWvxmedKqS9s/3PNSf6XTYvgP2lAAPxMt?=
 =?us-ascii?Q?b4UxmnUsyfour8woB2Shf8fql/+ynwVmIRrnhX7EqBGpZ1odi/vWvB3BWMZJ?=
 =?us-ascii?Q?vKznNnGpGIdVz7lKW38SdLVkvRIIlbJQaerEcbXNvwn4TkJtX9/vr7iKCcMy?=
 =?us-ascii?Q?XmLMNRGik/2f0LNcw3K6M6UBvVhxhTn4yCqyAaclEs4c29jowOgy020ZNxLK?=
 =?us-ascii?Q?fhId6RBlJASw/LUg1jVDyFuJZHHZUBbnjS/ecTLjAgWZkojJslIYm3tqaS/x?=
 =?us-ascii?Q?sEFp84SGPDdFjevPwOUBCLf/ysVUscO8iRXqEniTClP2HK+vJ2/z+lS+0dG7?=
 =?us-ascii?Q?qZGnNlAR5iGSw142GBhT3lQap3EdpVqoqDdTrhIWvviXuNGhZyHe8ZmBBJRi?=
 =?us-ascii?Q?RtKHvohCiPGQ9KABgCwtvhRjQv1A5wDdrEPHefbHEz8E5JCxpoOuyK4L3poB?=
 =?us-ascii?Q?eO0g0YCDE0UgJtjx1T9T04UFlNab2cH6vYc6dwSrNYyAISUtgAWUt/MMuRYK?=
 =?us-ascii?Q?jgsGJy3EnFQcFlzmzbZJwuz/bjTGPQ7qsrA/xVEqt4On8Xq2JtIzlCL3Mel+?=
 =?us-ascii?Q?8LYeLqNAJkSE7HZodT61+o3FFPtUrFYcJ6Mm1IJ6qqUeOBrKBn/6LZ3SAV6z?=
 =?us-ascii?Q?MpTNiRu8Mip75tQ7Wvpv0Fl3hkY393trOcLhgPjWxERAW7d9OAQUDHvrlNpC?=
 =?us-ascii?Q?aSG7fCImx3Aq3rOYV6n8Ai6TVIJrVH0I4CQPFNc8zU5vvC2qloqlyyAmRlqx?=
 =?us-ascii?Q?x/gXvD4jQdt3JaiOBv8h1K4dAjoqZy4IczebBZXsTMAOq6r1k12fmru4OOw+?=
 =?us-ascii?Q?C3He2FN0TupGDuPHe2oZpkx07e9qaNh3GNGtJumHfg6tacT6slZzgC4STu5p?=
 =?us-ascii?Q?Bmae6IStzje3nsPcLanJnNoiMm5vGqoL+zLNsDM/QiONfiD9Y/Kagvf6aWV7?=
 =?us-ascii?Q?gPwyfu9gnyBaEm+yqSC7gPhZeQptj7Ee3Y0/vawtplxrJAk54hqnVPTuEEPC?=
 =?us-ascii?Q?wV8rcol6ny3Ly2NLPEYZxvatkkUhN5SR9qHJa/Z0MCkZ1QmjceeHM0Ovuujl?=
 =?us-ascii?Q?tpNr+MiKm811yXEveiThUPaQeABQDlf517MzagA46vtTz+ccANkxAog42Gw5?=
 =?us-ascii?Q?lAxnsCUNRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d32bb25-4c12-424f-9206-08deec16352b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:35:26.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQjRncM9th/KnSL6VDkQd2fddwH9HmqnFP1S69Z3gFIzbifglvFxa8/G+YhxubOJexSuWgA58SXQhzA0oeg9xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075

Hi Tejun,

On Fri, Jul 24, 2026 at 02:50:15PM -1000, Tejun Heo wrote:
> scx_claim_exit() claims descendants' exits by walking the subtree under
> scx_sched_lock, making exit claiming, and thus scx_error(), unusable from
> NMI and from under scx_sched_lock. However, kfuncs raising errors can run
> from NMI-attached BPF progs, the hardlockup handler runs in NMI, and
> scx_link_sched() wants to report failures under the lock.
> 
> The walk does two things with different urgencies: ->aborting must be
> asserted synchronously to break IRQs-off dispatch-path live-locks, while the
> descendants' exit_kind claims can happen later. Split them: sweep ->aborting
> locklessly under RCU to unwedge the system and defer the locked
> SCX_EXIT_PARENT walk to a new irq_work, both of which are NMI-safe.
> 
> The sweep stores each node's ->aborting and then reads its children list
> while scx_link_sched() inserts and then checks the parent's ->aborting, the
> two sides paired by full barriers - one side always sees the other. A link
> that sees ->aborting undoes its insert and fails. As the undo's
> list_del_rcu() leaves ->sibling non-empty, list_empty() can no longer
> identify a never-linked sched during teardown - add sch->linked instead.
> 
> trace_sched_ext_exit can now fire from NMI. The exit backtrace is skipped
> for NMI exits as stack_trace_save()'s NMI-safety is arch-dependent and
> undocumented.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

...

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index aca8d2380509..30ce4c9428cf 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -5027,6 +5027,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)

...

>  /*
>   * Claim the exit on @sch. The caller must ensure that the helper kthread work
>   * is kicked before the current task can be preempted. Once exit_kind is
>   * claimed, scx_error() can no longer trigger, so if the current task gets
>   * preempted and the BPF scheduler fails to schedule it back, the helper work
>   * will never be kicked and the whole system can wedge.
> + *
> + * Lock-free and safe to call from any context including NMI.
>   */
>  static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
>  {
> @@ -6279,35 +6310,28 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
>  	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
>  		return false;
>  
> -	/*
> -	 * Some CPUs may be trapped in the dispatch paths. Set the aborting
> -	 * flag to break potential live-lock scenarios, ensuring we can
> -	 * successfully reach scx_bypass().
> -	 */
> -	WRITE_ONCE(sch->aborting, true);
> -
>  	trace_sched_ext_exit(sch, kind);
>  
> -	/*
> -	 * Propagate exits to descendants immediately. Each has a dedicated
> -	 * helper kthread and can run in parallel. While most of disabling is
> -	 * serialized, running them in separate threads allows parallelizing
> -	 * ops.exit(), which can take arbitrarily long prolonging bypass mode.
> -	 *
> -	 * To guarantee forward progress, this propagation must be in-line so
> -	 * that ->aborting is synchronously asserted for all sub-scheds. The
> -	 * propagation is also the interlocking point against sub-sched
> -	 * attachment. See scx_link_sched().
> -	 *
> -	 * This doesn't cause recursions as propagation only takes place for
> -	 * non-propagation exits.
> -	 */
> -	if (kind != SCX_EXIT_PARENT) {
> -		scoped_guard (raw_spinlock_irqsave, &scx_sched_lock) {
> -			struct scx_sched *pos;
> +	if (kind == SCX_EXIT_PARENT) {
> +		/* an ancestor is already sweeping the subtree */
> +		WRITE_ONCE(sch->aborting, true);
> +	} else {
> +		struct scx_sched *pos;
> +
> +		/*
> +		 * CPUs may be live-locked in the dispatch paths of @sch or its
> +		 * descendants, which ->aborting breaks. Sweep the subtree
> +		 * locklessly so that this works from NMI. smp_store_mb() orders
> +		 * each node's ->aborting store before its children are walked -
> +		 * either we see a racing scx_link_sched() on ->children or it
> +		 * sees ->aborting.
> +		 */
> +		scoped_guard (rcu) {
>  			scx_for_each_descendant_pre(pos, sch)
> -				scx_disable(pos, SCX_EXIT_PARENT);
> +				smp_store_mb(pos->aborting, true);
>  		}
> +
> +		irq_work_queue(&sch->propagate_exit_irq_work);
>  	}

Should we move the trace_sched_ext_exit() after this block?

Before this patch, sch->aborting was set before the tracepoint. Now the
tracepoint callbacks run before any scheduler in the subtree is marked aborting.
Patch 4 also makes this path callable directly from the hardlockup NMI.

While the tracepoint is running, other CPUs may remain in the live-lock-prone
dispatch paths instead of observing ->aborting and backing out. Probably it
doesn't really matter much, but this should help reduce the recovery window a
bit.

Thanks,
-Andrea
