Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305452E738A
	for <sched-ext@lists.linux.dev>; Thu, 28 May 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984840; cv=fail; b=sX5XEllhnXiKtEevOt8J4ng9qVfeSNWqgboaK1Do7KFBcbyKzCX9HbA4id8Lwmm4sKiJbv3kb6qXrqXo65EGwDVGvq/7W1q/Tz7+/E+FJJ0t9ayK7MGJ3PdrkEH601oE1qTYFwTGdx0CpiX3Tp4DYsSS3z6zvMpgJYOBwwRW1/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984840; c=relaxed/simple;
	bh=9p0GUO4qAfUzyexfB79V3QRmbkgL0GuEvC0Ad5HQdxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G/Pdhs6qssUlciWw2EXGZw/WE5krJ8ilGd/p9RU9m0FkebKL4ll72FEtovdFxrlRcLC321Hf+u5aLnVmjPlSzi31KnJRlUlYOAyShnuC/uPOeh1G8NvzZuKX7OTYZlukiQApUoaaJJizfR/WU5TClwePRC1RagSKaZZtQS4y4K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kj7zYYOL; arc=fail smtp.client-ip=40.107.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kj7zYYOL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+QYLGJCpndXITKVDvZc1v0bN1FcQO2wnZUUe7iMczcSeQH68avhlbyKYRWyw3ViHESep81meRF2oxzo+zJcXsGtGirgcm2HOjnfaAUHUgirsrTjcG80v35YCsUTyMGxK+gO7G9bkJfX0+G9p6ET62znrG0SWYJIBOHlA+YcKyslB3FUJxATDYqP0YRJqbM1VOVODnAuoQ+RTZ/iBBZti3m85shz6qjrslPIeGpLZsd11R0jQ9LkyNw3I5xWQIJ8UVnorlYo8k/FBnDIyjlBLe1neSLHsaB2nmT7/RhYNHAcuP309c14MV80rvPl0wBPBUBK4HdWcnNFlLPBg9ju8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eckXLpikwrXWsRY/FtTu8QFFAB5bzOmt5xujYqNy7T8=;
 b=LlLyfd4uK96omLlk+CJxjiQt2yxWHhCUIwxo9vVeO/rFt8VTe5Nt0Fa2fcJ8JeaWtfxGH4ozmCQWEJcx2AyXIqLWr/n5i/PdrLqdHTIN73eSE57PcgR+bHlgVKKC4JUueAmj3aF78cJF2ql9kYqgSv5I9BTWidOPLSHlvRG2eWx6wfF4Q6TR1lV9CuuMxh86RKOqVrTQtMrPbh4V4HsBSNMMwEv2jVfuN8K+LQGlw1vNrZwCIic7OY+PLXF8KdblL6QqkL2Oo2VGIBPY7nUCvB3eiwM5MzcOpc9zDjUGdeO6U9yIqSvudXmoJUw5Qlpm9IwgjfY2sIxYhZFXJERl2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eckXLpikwrXWsRY/FtTu8QFFAB5bzOmt5xujYqNy7T8=;
 b=Kj7zYYOL2t/b+DlpDoXTmxBM17uvXdm1Ihw83pTWBgYCsKm+DZjIbmlkJqxtd+tmS6zQhQkafp+fpVrrpo0w9dZ2z425x6fFGLCYaFhFYeQd/X9qFQPvM3CoXzoWvCB9osjQhEAN01omioiIl9Y8lyN+wuyKUKDK7p9ZOYrtZQgQyA6DsyvvUwEZ2Aog2j1xtTV1eFoclHZ1lgmI7Sx8PEv3dO0N8EXSv6DojrUkI3y2HdCEGxXBzbe8bm2OuMyeJcjzjw0bzGDjvEb89un7xjzGE9Zetylrj3uRQoQ+/GzARHoluQ1kZHgS2AsB67eM9gVWsUT+ENmHnIwOVUjD7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 16:13:53 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 16:13:53 +0000
Date: Thu, 28 May 2026 18:13:45 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>, Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Auto-register/unregister dl_server
 reservations
Message-ID: <ahhpuW_Y4vSgjFAk@gpd4>
References: <20260526164420.638711-1-arighi@nvidia.com>
 <20260526164420.638711-2-arighi@nvidia.com>
 <20260528113621.GE3493090@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528113621.GE3493090@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI3PEPF00004EAA.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44e) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d848e87-0ae1-452d-cf3d-08debcd41c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	7pvdfdM6sAF91cUN0VJSeflOzlznRiwsoJAHGcfwue0JtdS08Wj7i4CPwoWr/CVLbSDcZaO1aZsJPfOvqPUjq6HxpqJ4YBFxrnEg6ubuZu1CB+iKsNbjlgN3nE5WgN4vQtCTWRdUEsGqbA6bX2COyfJAjaAY2HFPIdKNqDe6Vls9TTnuCT37VzbfdGgxSBTxwdCO4fSlWY1xPRNpzPH4JL585crVWcmaDYDJIILidrTK1aE98a6a4PMX/FCheyHifnm8+vUFry+tQH0aBK1jbQpwPyPzJjTQa+yqG8awmo/LJwxQmz/gD3iQlBTBSOo9QSlr50MATNYuFUyVoEpluWq69tNbKxpMFbH/GFhXSbVo4xAFdznNH+cT13MfTYUp5x6dQZ/BPGZBnv96Jd0sIhDA/1/0aVo+VAmabo3q9Yj6ZgIrk+Boo9bZAyg5OTrC+skij5dchG4mqeJy/r8i/bx4i+KEDtoTsI+WNDXPv3gHVZREuECOwNvCsmid3qSs7VS4qdxWAo0AkArBsl9JhFYMVfLTJ2Dwltid073XCqkA65GKs1hDg/BLcow9eH5yIjNmMpCt00oQS29a8zpx0hr8zQ2++xYKAE5iUkB/Qfo/xwJUCO8IZTjyKBJPrUhrYk8LKrsonMfwyk7lrLq8TzJYjJC1SMPSNK0KICidV9kQAFILgnlOrzI1cnEM1WWj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6uUsFme/F7et+OFEB4l4WSTDGOysv1/Atbs0h2Ye6XWbz8K35yttPWNDska4?=
 =?us-ascii?Q?xXo8Okt6r5Fex+4ZJfyeoWHJW6TfR03qT5C0lHBtP9uK7N0F+pkUEmHupJ2e?=
 =?us-ascii?Q?cWEf8vw5CRlVgsq5SglOssCl/A/tcmTjUb6aQ26jCiJiWHHtoPRM72aO5wPi?=
 =?us-ascii?Q?rWhodKqmQlRC4FKoRAWqMzJdQgrHdvSkDyLpjHGpo2iwMPt2AOoDUPV584jQ?=
 =?us-ascii?Q?EnVUOUO88d/dZ3K2UyVn5wGTqziqC1JoW76gZA9+UyqAE7EAc1CWWct5ahAJ?=
 =?us-ascii?Q?FCnkBEQl1nm9KjWew1YYZIVcGahFOXty5fUO/UxEJVLPhmRdE5aawM1/vvHy?=
 =?us-ascii?Q?z98U8lVnlunIvU0Hw0wRqwfoPMU2hh8L/w+vpgwgJOL998GAtvk4BqgJaCK3?=
 =?us-ascii?Q?tT22ED6ciNoFcTn7M9WqTcx5qsVFciNAsZPCiR0sUmHksFAAQ3CJ70mjofQT?=
 =?us-ascii?Q?1NRFJsE4Ogtu9RA0eMup0TgddIkfmaGHD/Hv6YwLD/l4c676ul/lW5d1vKGt?=
 =?us-ascii?Q?bIVpsyb8jwVJlTQAsZWpKWo7v+Pf4Dpq3UzBxNt+31oWtslJuW3TBxKIIPA2?=
 =?us-ascii?Q?lf8t3w97jOuajjrj7+aiWGehLFpiXocajd9DgS7gMf2ZGDdB8ibtnOwl0YS/?=
 =?us-ascii?Q?asikoTd+/Dm5WfZV6dCbZNmM9126Q8hcC5tz3YfrwHDQCjgWRl7+7bLUNJFx?=
 =?us-ascii?Q?sNwVSce8j5BfPSsm1YyoKxesnbTVSwyQ1GQ37UA+FbIhvv+x/9K+Oe/qJjcA?=
 =?us-ascii?Q?SEx8BnZU5xxijL+OdVWoqVoUAxvOjBPgIioEqKeTPz63uDRJnp045PoTpD1n?=
 =?us-ascii?Q?V+yB/2/t17BSEbNy4da+8VQEJFvCYQDoNddzMpvxTkgl0c5RxYgVwGcHBg5P?=
 =?us-ascii?Q?Ugka0xud051oeN/TpNUQLickLRbqbM1O8OtIbRJvBT/RNvbzvJq6tMpsblg+?=
 =?us-ascii?Q?Z1G3W70VVjx/QTLRtY2Nw/vPU6MZQisCSjzcKAELb1emGC2/uz6eaRgivBFN?=
 =?us-ascii?Q?hbSVW/Z22vS7L7srLZlTSTMGrviOlTbpk0UR3yod5JVQ93GrjeHPUNG/IuHR?=
 =?us-ascii?Q?1TJqjZVNRaftWJ50Yo6uKjwApgZBIWp85r3TtAC4H7BFLraOODuKfoqa+kyA?=
 =?us-ascii?Q?OW1NKfHh0GK/otbTEuueZL2V63qnztdKx8hCLvzy75f5RoJpaMZLap3mQsxH?=
 =?us-ascii?Q?wsAdzhjugoFH/w2OuJeTAPKkWn4sbIG2+aFODEaKRUPbA9vj/o4CGbBgHoSs?=
 =?us-ascii?Q?FHve9Po87citvNwtCXCfWjL7LlSI3cc8LYwgQgOB5cWu1ItDy3lqmY6tpDHr?=
 =?us-ascii?Q?DN6CtiwVfj4RE2jx7GBtZhh5ZD/xBO3RD3s5wEILmDk65rJD9cejN6QTXw2z?=
 =?us-ascii?Q?3rBjVvipLhzPYrZ9lnn6tJbXTBL1RVA46qab1HP3vMad8K8irPVgyrmnSipe?=
 =?us-ascii?Q?VOk3BV68mK5gLRh3cXC7sWiLlQXBNVzm3dqq0+u63/VZTAppqVS5cDiDNj/2?=
 =?us-ascii?Q?oF5CmH3qVDFw68pYjPiOZg6aPJ36LubNN25z9kZFKjcATHoGg9nwRDQP1JOF?=
 =?us-ascii?Q?g9daoolq3zGpSAYxqwRdDUhVzqeCzxaRK/6RtYu0uk50JtnmegPwHxHztiFP?=
 =?us-ascii?Q?taffo0TiNrfsbFcgTVnINZ/cshdA5bcvyc/uzPmyCgJywBo/QHMr32b6Zyac?=
 =?us-ascii?Q?HWqJuuNCG+ZjgjROyPgdnbuhhQTaugF92S/YXvFS2h3xhu80?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d848e87-0ae1-452d-cf3d-08debcd41c5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 16:13:52.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laIDpF7m+hZ7Nbm8z6mxkkDiuJUfFk4f3ANuMss2x6pLv2TzvCRezomZy9mWchEatYNPm6/ovTnPcKp323KLeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714

Hi Peter,

On Thu, May 28, 2026 at 01:36:21PM +0200, Peter Zijlstra wrote:
> On Tue, May 26, 2026 at 06:42:48PM +0200, Andrea Righi wrote:
> > @@ -6187,10 +6190,34 @@ static void scx_root_disable(struct scx_sched *sch)
> >  	/*
> >  	 * Invalidate all the rq clocks to prevent getting outdated
> >  	 * rq clocks from a previous scx scheduler.
> > +	 *
> > +	 * Also re-balance the dl_server bandwidth reservations: detach
> > +	 * ext_server (no more sched_ext tasks) and reinstate fair_server if it
> > +	 * was previously detached because we were running in full mode.
> > +	 *
> > +	 * Unlike the enable path, this runs on a recovery path that cannot
> > +	 * fail, so we use dl_server_swap_bw() to atomically free ext_server's
> > +	 * bandwidth and reclaim it for fair_server under the same dl_b lock.
> > +	 *
> > +	 * The swap can still fail with -EBUSY if someone bumped ext_server's
> > +	 * runtime via debugfs between enable and disable; in that narrow case
> > +	 * both servers end up detached and we just WARN.
> >  	 */
> >  	for_each_possible_cpu(cpu) {
> >  		struct rq *rq = cpu_rq(cpu);
> > +
> >  		scx_rq_clock_invalidate(rq);
> > +
> > +		scoped_guard(rq_lock_irqsave, rq) {
> > +			update_rq_clock(rq);
> > +			if (was_switched_all) {
> > +				if (WARN_ON_ONCE(dl_server_swap_bw(&rq->ext_server,
> > +								   &rq->fair_server)))
> > +					pr_warn("failed to re-attach fair_server on CPU %d\n", cpu);
> 
> One option here, with the swap, is to reduce the fair servers bandwidth
> to match the outgoing ext server. Then at least you end up with the fair
> server running, rather than having it completely stopped.
> 
> But this is going to be a rather rare occurrence, and people will have
> to go poke at the debugfs controls anyway if this happens, so maybe
> that's just not worth the effort.
> 
> But I wanted to mention it...

Yeah, it'd be safer to at least have "some" bandwidth attached if
dl_server_swap_bw() fails, so that fair isn't left completely unprotected.

On top of that we could even try to opportunistically restore the original
bandwidth whenever DL bw is released, but as you say, this is probably a rare
scenario, maybe it could be a later follow-up improvement?

> 
> > +			} else {
> > +				dl_server_detach_bw(&rq->ext_server);
> > +			}
> > +		}
> >  	}
> >  
> >  	/* no task is on scx, turn off all the switches and flush in-progress calls */

Thanks,
-Andrea
