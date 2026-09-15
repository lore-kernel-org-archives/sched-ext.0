Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4454B66D1
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487987; cv=fail; b=M1kIVn4mQmg/Z5R8FRxwzIYuz4YOF4lvQpADmvYqMkL6chj6V/yd+hou3HxK538DC5GDukFR2z/vxTFAkQeQ9SDDL3tBX75zyfKavo0/NobSjp3mckFLUliT52qhFue3+41scENTBH+ZnIJy4qTTTQpWt95CvoqvdUc9TrPnU1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487987; c=relaxed/simple;
	bh=Fgog1h9AB8Rt+FMVRs+2RzcFGzAujkoSTKCUQaDn9ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VtkO4Bgg+1IwvZVwMrFbdBq/y2vukX7YD+WnIX9mT/bumO3TzSB0yqtMutV/RcDYKiSux6mf4/f2oAG1pV/nAUX3juKjZiTpDufAPXd/rvZzqAPb0e+2AoEBCpH8oEOLZU1vm1X2f2VmRit+FMEZjStZXBQU6lYKYGNaiaVeNjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NGxVkjK2; arc=fail smtp.client-ip=40.93.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NGxVkjK2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYUcI7kafI2Ar4w63HjVrHPkWXNl4zyUlNravSwZRLt9kIVwReEjg4GZFv8IxwM3BeclwKIBB5gQpf9moqu6Vij/Hp+YqgH9bhI6F7SDqbYZSg3X4Mdjc4L5XCggSyIS2nNO+QSwtm4wXOgm2mMCcE4nl+sk0wK5+DVSZ4jLXxhmJ4eMymkHYxEeB7v4gDzj0qniRekpDkQY5xeoQCy2J7XYlyUVqdjGp0pWs1GyyEt2g+2FF7Shi6ivwYOhqTSjNog6Fydg12WIs+BmK8bZ+47gZWAbWb/gSrHyH7AaKmyBk1W5KUFskXllbr0soMKiKxBCBTMrd5TjSxxY/+jSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFMBXA0kp/e1izXeE8wASJRp/gI//zYrGwMU1foS8mE=;
 b=SP2DdaHgMxUYoFXrOqyYJy1/gvvLfCfaScgcwFAoQVh4Sod6mj0ZqY/qlbcE6Iw9iARJSs7Mt2Fy1uHPL+9kHFzr+ktDe+7iRj2SpCAVyAlb4og2IUOwJvfa2fjo9IY+7q3aB1rV6MI/rPNPYnJ7MyC0hSaqCqPu3pe8lOQe3J+sSmlwjqjViKewIPvaQMVb7Pmct9VnHlttocelFJ+WcML19Srak54ZxO/FyAJpTaQtE/yfiD6cdXuj37hvzS3gv+VNz+rkn1SlmEAtEwAgZjnEVVOK+G9s0r7jnCs5A/LjmjzJpLM2CuGKQjMrWhmyZ0bWI2Mu8x6hOGaKQc5RrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFMBXA0kp/e1izXeE8wASJRp/gI//zYrGwMU1foS8mE=;
 b=NGxVkjK26GgtyLVH0a9BaAcGIAUKEkmJpVex1sdqBoyhpaRokNYk0pMUi47oU3wz8D0GyWd+MPbN/Vu3bDiqtm1t6NKzXy1E4u/Q9rB13ltMyxzRFnYaj9x5Mr2a/qK2ae725ZN1sqQ2aSz5X/wjdJOR6Z8r6511S+q5ZovrzSsDQMTyQKZ4CdyWwf+HmpYOkuJZKS7MHf1XqiTWIkWp1VZo6CMtOavosuqSXU0UUSzdTZNNN1k92bftmihtVtp8cs7vJHqact0Y8zs/sfMkw7XUc0t9FTngFdSl7w5V4ZC+ZXAFfGqzhYT9B/SYQB20WbbYuJJ69v6yqMV1iox+IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 15:59:38 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 15:59:37 +0000
Date: Tue, 15 Sep 2026 17:59:27 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] sched: Make NOHZ CFS bandwidth checks follow proxy
 donor
Message-ID: <aqlrX1bur4ue3856@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-4-arighi@nvidia.com>
 <20260910095448.GE4120091@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910095448.GE4120091@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI3PEPF00007535.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4c7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fb0653-d251-4553-74ca-08df134257e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|11063799006|4143699003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k9bmETtGTmf43Z6+mNMaea5Dlqr4Fw8H4hlmM2Igl8TcZMfBxYo/IdxKwQzhrXEwKxdxDzQVlEh88PILboa9X4bNlcZjaNHDaBJQvNI4VQuM2IQPf3Q1y60JsNKnXxw5id/Y+ZwoiCTBo1ZhoBfLu/ufaJhNn8GIPfnyZ6Zk5DKctZWPG22Jgnlf6IlCkBmRE5Ag5BUelWj4hkJ3WDelps7JNB47w/yHNUo3PrKMJuy//rHO7LYJmbgXotp6hXH6slrY8YAfVdUKmPHFHjXEEEQOClxTglUkzwp9ZYBud2HLrBZwpZPPPF1SLaNoW1Vw7icNBQKWZc3sonb99s2VmNqVbfH4iNYsSUnYeMVGpGUgszFYoexuvNVaenDk23cKSoJ9ncgdj3yWsbaF1RkWK2xnsZekdGywVDv4T+jV4L2p3VEgEpRxR4fd7jjkuMMfSHHnGcXB5/4vyK3ukbnNgJ5kji/wQdPuTRup7CDrUye6E1FOyaO1B24OJQJ3USCoxgD/8EZwsYLt/wXxROd92Pom9WMCFrNRpw2euaBwSJfek1nF3L2kuQBvJsTrC39laaK37l/CuUWak4LvyPb9LPInJUnr262waHl8SuDLo1YBH5AgXy2x7qZHfsKeS7LJbz/IgXufgHJcE1oFpzYg11cly5uRftcMksO+p89Pxmw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UCC/ehkDTvJ/JkIycTMLJMB9CftZdVDjD4UqBt+hm+VlGVi5I1Ou0fdmun3S?=
 =?us-ascii?Q?NuiZkQFeFnzLy/g+fGZaFHER9QfxWsvsN+9oykXUYtVMO3OkVqHKYgyWD5ox?=
 =?us-ascii?Q?KjlxgWyfA9MjxwxRyYmpiEsXU6OIpjVi8hc1S4pnUdKLtEkmiLpOTsqEAqyO?=
 =?us-ascii?Q?trcp1nGcpcllXovU0R01xTA6ApdUoh6Od9iw4ZtYL5fWPjlZMJzkNE7axlUf?=
 =?us-ascii?Q?bkpejI2r6rXyMZv/6AUqNSwG/TP9c1iFkSGYt1mu7uH7gXQ7u2ASRs9T6YEi?=
 =?us-ascii?Q?GUNTsZZns40p42QaF7xKDbKJHt3/lg+i3a35EUgOgr+DrM0oedVyqGKS8F3n?=
 =?us-ascii?Q?YVvztusDxUimkeBM3d7iX7meALY0TU+ZvGPxAZEa7rk/WtrBJAoZtrlWjlwD?=
 =?us-ascii?Q?IiYMHNl+mSv5r3DiBl1rxjJ37ldklj+ExOpJbvUZDqiKPiC23U6kR83LL5Co?=
 =?us-ascii?Q?ZZz4P4+sTpr6vKVKoUe2R4J2mS1sdeDyIHX4WrdWcm9H5P2hpYOTOHZudB3s?=
 =?us-ascii?Q?8nLbHbwJWBhHLUND9JCPEkDAsGIcAx9MZHutB+jbyaChlez+WvFgMqp/bhSE?=
 =?us-ascii?Q?Nwt1srOOxXLQaXGPgb/4u7mhhjWvFtxLVjf88NI49IzRn4PucSOitUw102Xn?=
 =?us-ascii?Q?HCKzBLaepYTHcrl2e11ZrCB+cYVZZ5K0azmcyyPi3qRnJmQdUe6kwgwMRZl0?=
 =?us-ascii?Q?n60bvtpSUZbDDwQnDKQkt6aeA2GJbRv6EzJBTyUCnqypDJXa8M+sIuK47bi3?=
 =?us-ascii?Q?+RnWOWHO6p/qehZLXUGj9N/3TRVrbfpOhRC/TQ4Bst8VLZMMuj+qe3di5tFa?=
 =?us-ascii?Q?Z0CjYuG0EN79TkUO3SEO5aX3d0g4no6GWxqr5QBXZ33Axvfdq7ERIPj41jPh?=
 =?us-ascii?Q?dkKx2Zfqq+Jv85mjd19BV2fUoLHHta5DguL3ocQZsIiwG+Io+OHciRYYnZyt?=
 =?us-ascii?Q?VVLfB/4TjVT3c5teOxc5YDUOqaeofftWqaSWYBdf4gI0v8DDAixGQIv1s4EY?=
 =?us-ascii?Q?ywBwi+j9SfgXs1ZC2tI/Kj5KJ+hwTZdr53soDBkT/bbzsYqnVWWT1CV0YE7M?=
 =?us-ascii?Q?ABmdgoem9BpWP08x1Mf2sWAa17EbBYVtZLoMELuvOLUDlI6uTbJr9Zbje83N?=
 =?us-ascii?Q?yea0lxng8aZX4Tlie0rIgwi8HZMX/GqmXmB6WBMSBa+LrB/50RTrNT112/MT?=
 =?us-ascii?Q?EpWtn+AS6BZcvZfT0ZFS37ipBcC7dcoefU8rS4Xch3RdyohZIwuFepOXst1G?=
 =?us-ascii?Q?0/LAzlvIfFhR1mweM7L/RcMQ39BhX1+gtyNSkVmifs3xlJPVDSPqWLWhcg4c?=
 =?us-ascii?Q?zUb6umoAE3/W85ozhkk5iMtSsZVCyuUvJI3MUEzYP3JiMjTl0qUfeEnK02la?=
 =?us-ascii?Q?7hlmEf5eJd8iT+60gdRZnFkBvS59mcdvIxlCebVmzIOvOzUcNdrWKBrzkWoQ?=
 =?us-ascii?Q?gRHqW8xyiv8MUhWM0y57S6Lzr50OxxU/h7N+jej1FVKL0kTPFF1GCirVkpiU?=
 =?us-ascii?Q?tI4UbWyrbjdOP/ltGwVVObflTxa6neKLnBwE6bRbpJzPiUaIdkv5pOlQuKs/?=
 =?us-ascii?Q?pLqj8wlc6mezFVpNX6tDfztNaS4MDb4N+Oac6SE+QLIk3RuHJqJUcxgHVoPT?=
 =?us-ascii?Q?9ECCEz80/zkNbywle27JpcZrNmVqhdiIyLhLjC20AhYNoYSuwQGbMCIEHODI?=
 =?us-ascii?Q?chC6hM2Um/wbQAlxbt4D7QUJ5J4Vd/VvcaYayxReHAiVk9QQAoNI0htn2dw2?=
 =?us-ascii?Q?ISpEFq5vyw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fb0653-d251-4553-74ca-08df134257e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:59:37.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XST4vjF7GHEcJPJHuqZPvfgr08SD9FbBom2mz6E8WWjN/jYfL+WRXewFBtSmy1AmKq+BGub6/XW9g3iyPPotEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479

Hi Peter,

thanks for looking at this and sorry for my late response!
Comments below.

On Thu, Sep 10, 2026 at 11:54:48AM +0200, Peter Zijlstra wrote:
> On Mon, Aug 31, 2026 at 03:42:13PM +0200, Andrea Righi wrote:
> > Proxy execution separates the scheduling context in rq->donor from the
> > physical execution context in rq->curr. sched_can_stop_tick() checks the
> > latter for CFS bandwidth constraints and only does so when nr_running is
> > one.
> > 
> > A retained proxy donor keeps both the donor and mutex owner queued. The
> > check therefore misses a constrained FAIR donor and may stop the tick
> > while its runtime still needs to be enforced.
> > 
> > Check the selected donor instead and remove the nr_running restriction.
> > The donor being a queued FAIR task is sufficient to require bandwidth
> > accounting regardless of other runnable tasks.
> > 
> > Fixes: af0c8b2bf67b ("sched: Split scheduler and execution contexts")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Link: https://lore.kernel.org/r/20260713164807.E5ED21F00A3A@smtp.kernel.org
> > Acked-by: John Stultz <jstultz@google.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/core.c | 35 ++++++++++++++++++-----------------
> >  kernel/sched/fair.c | 12 +++++++-----
> >  2 files changed, 25 insertions(+), 22 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 237d216382f46..14d0d5c884393 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1419,11 +1419,8 @@ static void nohz_csd_func(void *info)
> >  #endif /* CONFIG_NO_HZ_COMMON */
> >  
> >  #ifdef CONFIG_NO_HZ_FULL
> > -static inline bool __need_bw_check(struct rq *rq, struct task_struct *p)
> > +static inline bool __need_bw_check(struct task_struct *p)
> >  {
> > -	if (rq->nr_running != 1)
> > -		return false;
> > -
> >  	if (p->sched_class != &fair_sched_class)
> >  		return false;
> >  
> > @@ -1441,6 +1438,14 @@ bool sched_can_stop_tick(struct rq *rq)
> >  	if (rq->dl.dl_nr_running)
> >  		return false;
> >  
> > +	/*
> > +	 * The selected scheduling context can be a constrained FAIR donor even
> > +	 * when rq->curr is an RT task. Check it before the RT fast paths below,
> > +	 * which may report that the tick can stop for a throttled RT context.
> > +	 */
> 
> I am most confused... how can we ever have rq->donor be FAIR and
> rq->curr be RT? That makes no sense. If an RT task is runnable, pick
> should just straight up pick that.

Yeah, the RT example is bogus.

The relevant case is a FAIR donor belonging to a quota-controlled cgroup which
still has runtime available, proxy-executing a lower-class mutex owner
(specifically an EXT owner with the other patches in the series).

The owner's execution is charged to the donor's scheduling context. The retained
donor and runnable owner make rq->nr_running greater than one, while rq->curr
identifies the EXT owner rather than the quota-controlled FAIR context. There is
also only one queued FAIR task, so the normal CFS multiplicity check does not
retain the tick.

The bandwidth check must therefore follow rq->donor so that the donor's
remaining CFS quota is enforced.

> 
> > +	if (__need_bw_check(rq->donor) && cfs_task_bw_constrained(rq->donor))
> > +		return false;
> > +
> 
> 
> > @@ -7114,7 +7107,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
> >   */
> >  static void __sched notrace __schedule(int sched_mode)
> >  {
> > -	struct task_struct *prev, *next;
> > +	struct task_struct *prev, *next, *tick_donor;
> >  	/*
> >  	 * On PREEMPT_RT kernel, SM_RTLOCK_WAIT is noted
> >  	 * as a preemption by schedule_debug() and RCU.
> > @@ -7168,6 +7161,7 @@ static void __sched notrace __schedule(int sched_mode)
> >  	rq->clock_update_flags <<= 1;
> >  	update_rq_clock(rq);
> >  	rq->clock_update_flags = RQCF_UPDATED;
> > +	tick_donor = rq->donor;
> >  
> >  	switch_count = &prev->nivcsw;
> >  
> > @@ -7243,6 +7237,13 @@ static void __sched notrace __schedule(int sched_mode)
> >  	clear_tsk_need_resched(prev);
> >  	clear_preempt_need_resched();
> >  keep_resched:
> > +	/*
> > +	 * Enqueue and dequeue updates can evaluate the outgoing donor. Refresh
> > +	 * the dependency after selecting a different scheduling context.
> > +	 */
> > +	if (rq->donor != tick_donor)
> > +		sched_update_tick_dependency(rq);
> 
> Please keep all the proxy specific bits inside the one
> sched_proxy_exec() branch above.

Sure, I'll move the donor-change tracking and tick dependency update into the
sched_proxy_exec() branch.

Thanks,
-Andrea
