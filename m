Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B5361650
	for <sched-ext@lists.linux.dev>; Thu,  9 Apr 2026 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775727498; cv=fail; b=Vm9rBNTxz/FT33dlQdSuGugpnYN056GHLyeGcJ9DrepaQ3wcvt/l70PHB3GPcvhCFL9R0V6xa9kmtMhL31viPhtdOHun0FfsYpuzJ1MVEYufFPZAoB9Is6xQgwM39JD0v7d1H/0vdrbC2Qqj1cRdcWOt3FhviCtboAEit3mmd3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775727498; c=relaxed/simple;
	bh=j+S/VNrkP+0G2ygNj6WK+4rrhxTzki3zfOHma1F4QDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RGAMXcSiaUAcKsOGLR2K0oR9YdLfh5pSLHejc/BhNaJcBQlnUDiqTifS3SoiPEHReLRrk6NjKDKZafoJk5NeXSNrlKqTWCM2bBRnPJMCDjwhjtldtL89RIGSx0ERmmTSDRx1U9qiwLIr8re/OzYul7vncU8j3dSqQQujmqHVxPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gl+wvvpg; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gl+wvvpg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSlDFzp2EeQLFlaNo4aEUsvrofGKWovyfuiKqszNk15P2esmnlrqJ0Rq5gMaOqfuCQgUnXwcyBrG4Ti+rop3scENl42gDHk9FREU1qCrxkl0H1yEgAmUeDe6ZBvrtU4Oc9fOkHcQF5FtrnNZk0kPrbv5wf0/WSgsHriH+xM8Ve5TSll6bj2SEqSczveVMLsTJ94owL/bujtVhnn6pQiT3xI1D7RnElD2Z8Ig5KU6qLMW7TKiGlY2ce5RiNaBmYObtn1YDAFDJxpkpbuzXFjfNGYz3wRf6pDR0Iqi0keG1N23Y2wMj8y/E8kIRT6PkR4ZP43czQ7OGvmqjE1wG6zUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8KcVHhB8MyQmELhL+iXBIOgzxBOhIN29PL8dNn5oKk=;
 b=qXXT9vM/zZNe0YxDDRxrrNgykJNO76XbcpNmZLCkpPJz6WgqcgWCfzixwRSCJGLH5lC31FAf1km14hH8qzyPqMgrqk99eUnQkblZIMXZlQJGImcoH6u5r+cjjJZmqdxbdf29rHO47ef/ZMI0BcCfw5F8p02CyYdSE4Cujs/yhAnLP03i539d2tma6kuQ1g1PP35wGzbzFwnjoYV35pJ+U1VszxnJ0U/PfQHrhuyynyYeG1xGJB+KprLsHRQeciMutJk0+mNDyPPxhf0yerj33rc4tb83voxU/UpnsG3f0N2DmQJIaYqtWBKyLIe8EVnSaho9ZTH1Uw5j+Vm3FqCWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8KcVHhB8MyQmELhL+iXBIOgzxBOhIN29PL8dNn5oKk=;
 b=gl+wvvpgKE9oOFqzdLOZY7Vuci+ReBkVXyzH4IsvOVG4m8syWhrdsBrl4/0TC2/uwL+Wc5GhsNB4ohbD5Ne7ExJoBG8DOTV6QTms8gUV63uFZabjQSPfYMfHgewP9iVXtPm5mauNv1l5WZt28AgwMQ4zgHYTB94HT+M8dfE2wGIMHh5I1uWtThoOaAYxqp2Jdn55XnXjgN1rALLzlTh/8wAUF8WTvLNcxoE0MjKg8c2zmLK99HJRtfGTI0n7C63A38VvH7n3VOoRDPIdaRIW0nvbvQXC7yhv4p8A/vpzpxrWx5D0XF5lCz0ZGng1oXdlSFVgE3UONGCVQpnLhb2ATw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 09:38:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 09:38:11 +0000
Date: Thu, 9 Apr 2026 11:38:01 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing
 calls to quiescent(), runnable()
Message-ID: <addzeX8Le_533Lgo@gpd4>
References: <adUxZ5Qp_vH6cBZj@gpd4>
 <20260408091821.91063-1-jpiecuch@google.com>
 <adY76wiI82pUBYkr@gpd4>
 <DHNS3RWRB1C5.29B8SXO481CHK@google.com>
 <adZc8caEfOZw8TLE@gpd4>
 <DHNU5YSWABWC.2B8Q38OKJGVDR@google.com>
 <adZsJZDFNgtod-Bd@gpd4>
 <DHOHR34ZLGL6.2UIL2GRFLR53X@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHOHR34ZLGL6.2UIL2GRFLR53X@google.com>
X-ClientProxiedBy: ZR2P278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: f48b0331-b36e-48a0-8f43-08de961bb6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pnm/4BJrptWovNHl+iXYAjScAyVf+26w5ERX181uKA8tYwM7srT+myoNUk9FZsdwB4XCkMzrkEfUb5Hj1Yh6DD4M6xa+x+BVUrqDzbO9RAbTSK5K6dfcLTDfNUyzoasbO+Bb1rQdMBPCGbRKuwjxwQ1LQwv6z0jaMJyFshi/s/u2ALbYA5xk4efHItfvviNCE3xbRpbw3U2JB92UFbYA3XJofsxEQMNtJObyVTDCZTEEJFteaE6wHsNkIlIKPu9DfFURxFVX9P+tUdqZ0OKcQDSWhiBUB1ecjVxwF63w5+Mm6MJMsCHi+CitcHI9CTI9bGTQJHxPri3xvrocunlMliXesWeoIu2V+AGRmZ8lX26akZdvCaLb4qiOIZEOS/OsvpZjnEdVWFdi76CQxMNggfgZ943GznLzIqOgGVM61h3n5dVIsSxd5n15P6bTyfxguRfeEVBpqRmzOYtp3sh2bMKn0MsTpBrHPRq7GfEvKVkjiotp3Zq5F5wDu+L0OC96kQpFZcA/Io2W9tUSWJcl4amdfgkmEb6gAtuvoa6Jc9HBbYLF4RvuWlXORbUU76nIJFZolDFEgZSG38lfYV13wCeHYHOUm7KpV7EkI1+3HHCSk/Mq1dL/011RshtRi9PoCZcDmZF7Z7yct2tPo2Bq65y0yJRLTrd5/g3aphi5Mrg8hrWzCqt1mwgx62bPATAKBWNhe1+jvGWwima8Jj+LMDqKQq8AIDrt+IWDj6zhiqI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GE7WyQp/GdTB0fFEYMjYG/Yy4hniQQEzV3mx5Aq55zU4LzjiuSlzkMgVYowr?=
 =?us-ascii?Q?VMqrgSJCsNjK4kjB1dvbzuExe3B63WQ/QrPsUwdfhRUfdP5nfQUfSo7sdMcF?=
 =?us-ascii?Q?ScBknYq3J0jJAfKguTciM4nCSrB3D/SdtM/M522r7J6XyXKaJPWhFYyfrdLo?=
 =?us-ascii?Q?q5AQRT7qgWHRWr84wjD5WRqRrLyHMse15LyIAe7YffbzLv2qv+/IJr+wvI9X?=
 =?us-ascii?Q?1dptZsX5wFy68Doa/udcIHHlX4klGnvqEB7EFiWy0RVrlSEUH77pVbP5dYxD?=
 =?us-ascii?Q?Bld9zQKv/uQP/sd0+eWMl/Dp/lYQyQZS2MO7B5H735wJtMRWITuqLll8rwYb?=
 =?us-ascii?Q?zrpgLWxDblOVoJgTNlLGDzb/WNYpIwflaqqtdiMPEPqi9ZGT5GV4EpbbozrS?=
 =?us-ascii?Q?VIjee7hzj9Gsoo45rwZu3B++SzEBQpXfOpaGpNh90ifwhZmbSCTARsr1i+Ps?=
 =?us-ascii?Q?3dSPFkkbTAPiGz3PNZVIZ731KD0sv8vpyOqh75aBs/hd5CUH5CyWpWk+YEON?=
 =?us-ascii?Q?67BbCyvnb8CDyAMqDHL4t2HAQ1iVBX+EmBuuhEUxLC6QitaWl/R3sUOaEXBV?=
 =?us-ascii?Q?H1IqIZJTeBe4LZmZfeS/yL73P1dyN0nNiakxgrIMIZUx2kgrFLlKWSC6oIgQ?=
 =?us-ascii?Q?Sg3AU6ny6oPSLhNT83XXS8RvJHVtphyBEP8rSQ2c1Ak4pc0UswVtC1KbNVCX?=
 =?us-ascii?Q?8OVBZzY95PusboYY46HMX6auAMfjfoBVm3qArAZk5xe05aOKKQWyAfub35IM?=
 =?us-ascii?Q?LKc3rnKFrOsN2oQiOKnazFCRC3QwWmNHWQqK+SofToqyHwmELXO4k7owgFz/?=
 =?us-ascii?Q?zQoOYXuX1/A9PraK8EqFYc6N8D5lZJ5sGiKA/bON9kje3SC2NKNJ7IX78BlK?=
 =?us-ascii?Q?IlDtv0zY/3wniCe5VN9HoqDKb+chDjtZajiV0ZwEeXT+pJsTkITnrx/k+lM3?=
 =?us-ascii?Q?ucYqbJZFZbCstpkqm1NmpXfHHKTAwyMgPXiMMWVByYB0Ls2NvdrbgG+mZ4vL?=
 =?us-ascii?Q?MpDTS4o/R7qJlmplWT/Pp18LqI3YEOpLIvD8+NhX0MGIfVf3EuCNv/2Twj0E?=
 =?us-ascii?Q?efShgepkofjgud0ayhrTGbqmyEJGzqziC03h02KH3k/uVI3EC3KXp8c9Qdz1?=
 =?us-ascii?Q?dmB0ICX60QDZ81LM0Ib53sjuQ9ROi6NqTw49bGh6MdjuRMk8JGLJIyDL2z8V?=
 =?us-ascii?Q?eWpkb3S5Xp9l1Z0pIfgKezDxZ3W6gy8u/aXWY+zb1aAZLVro5eETkGABQWeY?=
 =?us-ascii?Q?1mAzdgyEKH/Iurqe7XpaCHvf5zTzhkd18CH3mahYVqCUahMv0xMrkFFa72Ec?=
 =?us-ascii?Q?fnLM7vEPAyNmUaA7XJvNZoVHZj8BQ4rrB8IUDz/CGsOhg5b1wELaWHj+eDIO?=
 =?us-ascii?Q?q74gQK/jCXz4+FVm4JfLImPMx744GcXnST3ZtIYGife0Voby0J2fNGe5G49D?=
 =?us-ascii?Q?hZU5VEYpabw14y3BnboW0E2BDuJOuXmWvgrKTy8D8JKmEA1zg3a+/GbhwS8M?=
 =?us-ascii?Q?RDcxyL9fLzpuxvUMyIJRTd6a+xwNvIMZUb1z5/IQo2v/xqcJzviaW4VlUBzw?=
 =?us-ascii?Q?AFhLHy0lJr7uYr/VPMvtkzaHcDRGowkS9wiF0+kHtOgIONnNU06qxJH6QBEh?=
 =?us-ascii?Q?5LmmEf325/TeKp7gu3cmsWlXzIFEYQtFJQiyYFNIYhNJFrw0mY6klAFf0Xz4?=
 =?us-ascii?Q?w1CIRKkrUZTv4n4rmyJisGtdZzofJAuWSfZnDXs1JUJDBez56UG/hFI28xo5?=
 =?us-ascii?Q?a3QS1tOd0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48b0331-b36e-48a0-8f43-08de961bb6b0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:38:11.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCZqwq9CE3HOF7cqN9yW2OwVhBhplwUVisFoUZbfOwQtkOaDbf6fRTfgVMHHhf3YNNyTY3bHzMZBKg4a9XhfeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970

On Thu, Apr 09, 2026 at 08:46:03AM +0000, Kuba Piecuch wrote:
> On Wed Apr 8, 2026 at 2:54 PM UTC, Andrea Righi wrote:
> ...
> >> 
> >> Another inaccuracy not related to direct dispatch: property changes can occur
> >> while a task is running, while the psedocode only allows for property changes
> >> while a task is queued.
> >
> > Sure... but again, modelling all the possible scenarios would make the
> > pseudocode completely unreadable.
> 
> I'm not arguing we should cover all scenarios.
> 
> I'm ok with omitting scenarios whose existence depends on a configuration flag
> or presence/absence of a callback, because:
> 
> a) Using the right configuration, one can actually write a scheduler where the
>    pseudocode is an accurate representation of the task lifecycle;
> 
> b) The assumptions about the configuration can be clearly stated next to the
>    pseudocode.
> 
> I'm less ok with omitting specific scenarios that can't be simply "turned off"
> because they are triggered by the scheduled tasks themselves. A task's property
> being changed while it's running is one example of such a scenario -- one can't
> just prevent it from happening by setting a configuration flag, and sched_ext
> schedulers implementing dequeue/quiescent/runnable/enqueue should be aware of
> it.
> 
> What I especially don't like is giving the reader a partial picture that looks
> like a complete one, as is the case with property changes here. We're letting
> the reader know that it can happen, but the pseudocode makes it look like it
> can only happen while a task is queued and not while it's running, giving the
> reader a false impression that they can assume property changes apply only to
> queued tasks.

I agree on that, but I think the goal of this pseudocode is to find a reasonable
compromise between readability and accuracy. If such comprosmise doesn't exist
or if we're concerned that it'd introduce more confusion than benefits for the
users, then we can also consider removing it.

> 
> >
> > IMHO it'd be better to give an overview of the most common use cases here and
> > clarify in the description that the diagram doesn't cover all the possible
> > scenarios. This one is a special use case that, personally, I wouldn't cover in
> > the pseudocode.
> >
> >> 
> >> There's also preemption by a higher sched class, which is not covered in the
> >> loop condition (task_is_runnable(task) && task->scx.slice > 0), unless we take
> >> task_is_runnable() to return false if there's a higher-priority sched class
> >> with runnable tasks on the CPU, though that would be in conflict with the
> >> actual implementation of task_is_runnable() in include/linux/sched.h.
> >
> > Ditto.
> >
> >> 
> >> >
> >> >> 
> >> >> A more general comment about the pseudocode: I think it can be useful to
> >> >> introduce someone new to the general flow of the callbacks in sched_ext,
> >> >> but the documentation should be clear that this is a simplified view that
> >> >> makes assumptions about the behavior of the BPF scheduler itself (flags like
> >> >> SCX_OPS_ENQ_LAST, whether the scheduler uses direct dispatch), as well as
> >> >> the overall system (Can sched_ext be preempted by a higher-priority sched
> >> >> class? Can scheduling properties of a task be changed while it's running?)
> >> >> Without stating these assumptions clearly, we risk leaving the reader falsely
> >> >> believing they have a complete understanding.
> >> >
> >> > Of course this schema is not a complete representation of the entire sched_ext
> >> > state machine, if we put everything it'd become too big and complex. I think we
> >> > should just cover the most common use cases here. Maybe we can clarify this in
> >> > the description before this diagram.
> >> 
> >> Let's agree on what inaccuracies need to be fixed and I'll send a v2 with fixes
> >> and attach an appropriate disclaimer to the pseudocode.
> >
> > If we move ops.dispatch() + ops.dequeue() inside the ops.enqueue() block I think
> > the pseudocode becomes "fairly" accurate. At least more accurate than what we
> > have right now. It won't be perfect, but it can help newer sched_ext devs having
> > an overview the task lifecycle without going too much into implementation
> > details.
> >
> > So, to recap, what do you think about this?
> >
> >     ops.init_task();            /* A new task is created */
> >     ops.enable();               /* Enable BPF scheduling for the task */
> >
> >     while (task in SCHED_EXT) {
> >         if (task can migrate)
> >             ops.select_cpu();   /* Called on wakeup (optimization) */
> >
> >         ops.runnable();         /* Task becomes ready to run */
> >
> >         while (task_is_runnable(task)) {
> >             if (task is not in a DSQ || task->scx.slice == 0) {
> >                 ops.enqueue();  /* Task can be added to a DSQ */
> >
> >                 /* Task property change (i.e., affinity, nice, etc.)? */
> >                 if (sched_change(task)) {
> >                     ops.dequeue(); /* Exiting BPF scheduler custody */
> >                     ops.quiescent();
> >
> >                     /* Property change callback, e.g. ops.set_weight() */
> >
> >                     ops.runnable();
> >                     continue;
> >                 }
> >
> >                 /* Any usable CPU becomes available */
> >
> >                 ops.dispatch();     /* Task is moved to a local DSQ */
> >                 ops.dequeue();      /* Exiting BPF scheduler custody */
> >             }
> >
> >             ops.running();      /* Task starts running on its assigned CPU */
> >
> >             while (task_is_runnable(task) && task->scx.slice > 0) {
> >                 ops.tick();     /* Called every 1/HZ seconds */
> >
> >                 if (task->scx.slice == 0)
> >                     ops.dispatch(); /* task->scx.slice can be refilled */
> >             }
> >
> >             ops.stopping();     /* Task stops running (time slice expires or wait) */
> >         }
> >
> >         ops.quiescent();        /* Task releases its assigned CPU (wait) */
> >     }
> >
> >     ops.disable();              /* Disable BPF scheduling for the task */
> >     ops.exit_task();            /* Task is destroyed */
> 
> I don't love it (and I probably never will), but I agree it's the best so far.
> I'll send a v2 with the updated pseudocode and I'll put a bit of a disclaimer
> before it.

I also don't love it, but with these changes it'd better (or rather a bit more
accurate) than what we have right now...

Maybe we can add a "Special cases" section below the task lifecycle to better
explain all the exceptions and non-covered scenarios? Some of them are covered
in the "Scheduling Cycle" section, so we could also point to them.

Thanks,
-Andrea
