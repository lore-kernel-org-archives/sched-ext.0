Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1C369D6E
	for <sched-ext@lists.linux.dev>; Thu,  2 Jul 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783017284; cv=fail; b=sDNQE7bAkVBWRiUYPWpLE+tv1LCpA8SItBZwI+FqitUMgPnnECsWHd7jUBufa3dVTHhlirvkcVdACETH2pdYbE6uj9M4uObTyOUDIwD7y7joPAhg5NtYoYwhfLmTUT5QCln+Jr+hy5GPfNDbNeWfsUPyB5j/EqE0jLQ4+9TEi7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783017284; c=relaxed/simple;
	bh=J5weIN3L01IchXbh5BrUJ9wGJmk4/TMrlnKukMj4E+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ft9jdvEktPcHRtFERdW2A7rvt0Jb/oHnc/IGbR919J995voW2grLpYl190aUagdlbrjncPr8HpZMRgVDr0371JduG7FgH5IMhqu32wT8TjkAHSDvb2EwZxgQeXtMdgKq+DZMtgshg4lz+IibsoVmbHK8yuSWTS3hof7uNvlogjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=go3YhAz6; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="go3YhAz6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8dghVRb3W+reXd7BzIdpJXiEZ6SGBW1HfhRI/Kj4PCJvZPSVz2IlSokekPc0yWK0ocSewMHBi9DoKovG+e/Dl1+qkTg0P/RmEsK2i/YMSJuN6bD5BNiAftiRhpyG5PlYJ3pRi1quQ6z9nkvJf445tSk0cWBAm15FcBv4TpEreFR18YWMXgiATLzB08jmicENEe9s/3gt3xA7fzsLq72YSyRuuXo6o31wpvN/Ym3sDXgAPOF/5oX9xCpY81hJ8caRGnIPOUn/jDiUlHPQdeNdGtxB0ZvBdt8hL2NBP/dScBqNaL8P7fJSZPR9tzbCWi43fM6IVlQJ2tD5aowz6ppXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZyA033oX07+8Au+tFDCwAsRc0sed5wZZpdtM55W/pk=;
 b=cxTEFOB/3RsQfXgVrT95uMRkGf4/elugY0DrH1tQIWt6GWwNEk15KpQFo3i87nvw54n38xF59xrw7CDNUgY7EhaSOhXfzgFWqKoiTXxASO/DOpxQ9TpmKCTeXu5NzehNd1YyQ2j2S6sGWEXuZicw1Fnn+TDm5Ase26X55OMLENSSWAAflVGBFuA+U6B/PpHI89EIq5w8PRTMZnP/VHVBk/RcQ+ZXAGH688wKNL8x/t6hRt1F8oUMj6ogzUwHUALYuRBlBKL4muynItS+a57iPDw6UYjUuwqzZcmgG8sjwNdCKsCiKWvBc+XlPYsfo2FkRM3Gddv2l2AUxYpBbta68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZyA033oX07+8Au+tFDCwAsRc0sed5wZZpdtM55W/pk=;
 b=go3YhAz6icaMDSLq6uWf0EM3vRjJdye9PZRNa31Ttwo+E8h9l/Gd7n2ONxjrIipZQUYNC9GjyTiBVraG3uW5qIlaqAG8szr2CnsuiSfaH/wC/s8jlHLDhtZxAKwGxaNpIXg+rZ02Q/VCBzjVHusk3fKXxIFB40YWNvM3ja8YFsqmiNKqu5mpS0eTF+xeXeICCK050qaAfcD/kp5LDCyN6wrYvZDeJDe0W3X+JMbybjrp5wK/1XAsCGmg4JQeQd3xPwUOE5Xhr54WgEC460XHuEeN3oZh9hZ5VCCbg0Ff1R3LZR/aDPMQ13wUznRB5Y0uWFaJfOvM3PY8fsq2XeTUTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 18:34:37 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 18:34:37 +0000
Date: Thu, 2 Jul 2026 20:34:22 +0200
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
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] sched/core: Skip migration disabled tasks in proxy
 execution
Message-ID: <akavLigiPfJCM6WI@gpd4>
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-2-arighi@nvidia.com>
 <20260702182118.GL751831@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702182118.GL751831@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 78dc9618-b4bd-4636-fcd9-08ded86891c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|7136999003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	58v8zfXpjeEZ02z+E2woLBoRWLjQk3khFZ+aJJy2eIvM+8V3Fxn/E8LBQgD1txsXqbpceRdkA38AjFN8ug5il1EF2qphGhZkhngixoCFtLaafFQsSFZPIss02IxWYBKs1rfkb/DFMGLhyLxLfiedH0eyuO+Ww+0e9LXfR3cx8080EIIe3newkiFT20GMAd/T3AwX4i409OdAttRGdKbXl7Gv7SEbP1i3wkuMNtvnmZe61PjeLMG6ExS9tY2C3JC8uA0gqYZPOWijvaJhdhkQKKB4UJ+LLlTywGA52eAXj2zW8j9uYZNjjXe2DWeItqEQvBYNc8HyoMgBLPbXLe7z/tKrbdjXjkSgXXOfxz9DKUu6t1EgSeTX5MOKSGpq0ApNfpkTl8CZCXucgkY0cMQ93OZ7aP+vyNwwMsGee9ND2WbIk/Q0w71vOIwTRXc50KlS/JdonbrEMe2c+kT5I+BoKGuxpbMuqpitya4fDovRVUhwPnHMoPeHRcWGCuAenqS7xxrjAZdDFStQ0+1qHbS1B2x85p/dg2d2PIuXC8syzAT4BNsY8r+cCxMrcVbL/bIZULbCoMngSG6ndH6VIoK+m2FqXvYDrOOmODH+TwNs2MLaIrcgB7cHfNOHpLJagr9ek+wT93d7i4IF34dVMT92j7GpiomypsFhyqpRlhvTQ6M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(7136999003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vRq3VWWJBOAmerGGk6/OR/96lI1bhzU/bC4gvsaVbuJD1Ppo8GRLcy9SfVDj?=
 =?us-ascii?Q?S6BP8qB/cVteUikI/yM3Tms7ycyeM4qxXmfm2WMwzUwcQqeUAea2uLbMEq1n?=
 =?us-ascii?Q?Pgc3ahRqRs4nw50PcEhhgXk5XzN1xcoqsC6b8p5Ozj3yKBIzY3bILtSKLP/4?=
 =?us-ascii?Q?EbBke+BiJLGg/5boCxCyqIQb9DQMV9g7U1fNdB+bfq+eIKTMVkHO+u+DyJfE?=
 =?us-ascii?Q?BDwpqY8+ZamOmkx6hVYM98l/u9WmhtHFmbehvbeXfU761CL4ehH2yvdr5KTy?=
 =?us-ascii?Q?YuqUq15ycXkKcwlsGKgDyyd/LZ56odb1yr3u1Ru0MoFB23ZbXXdeA/Qqx6WC?=
 =?us-ascii?Q?p7FFMuwYbechhRY5tSJsUXow3nI6qkRR4NYxERzAX+QmCX2A/T1jzA6WpLjK?=
 =?us-ascii?Q?JRcEY9VXZUlZreZkzU/jhDPAVdoiN8AZzyuzqI72EtxNPvhNfudxYp2e1hgo?=
 =?us-ascii?Q?xR+IhzLt/nuSzibLgBqSwgDL6SpW06uzsw927cCtxLlWrOP3h4BMBQYtKmsO?=
 =?us-ascii?Q?9yNoF0tBxFpmM0S0kDLxefVOjRGODkIbV97/xAl/sUq2er7LJwfXU+P/MV+U?=
 =?us-ascii?Q?7BknixgL1fFz2HqszduvMfE3xLyx6jYFmMZ0MXcFa5rLk0hGgygJk5QY80Pf?=
 =?us-ascii?Q?Qa+L3cHZaFOk2G0KShbQMLQdPrGcBwoR0qWHJBYLnhTLPXP786pgLVlA1nA/?=
 =?us-ascii?Q?0sVVizCeO69UHghT8jpBkgRCbae3mXkO6GSkM3wOZddxcpf/JCH5wDjzmfs3?=
 =?us-ascii?Q?iwgHlTPwY02DtOWJMBbYqnjwoIrfl+LDDKXKjq71Zfj/FqG/1Z/7vPud255q?=
 =?us-ascii?Q?2+l41j9Q2JnFMW9KI4ErcicsBwP54aTjDVofD5aieeHlmOZ12sm91LdFb34f?=
 =?us-ascii?Q?XjC+ZjDsUpOi7YtK2muxjChnpPB3vlXqVQ75ZoCSStIy+YnLlk8UgKRYWq1/?=
 =?us-ascii?Q?kZg1dzItuhhRFLaP/8EdyGXAxb66oakLSmpYO5DN0Gr89XBYBrUd61qgmcGu?=
 =?us-ascii?Q?Dye3BHtPiRoDIUPjGWtHVwe6XEIR68qxtEJboB/sQRsfV1+jC3gFGDx3Ls0P?=
 =?us-ascii?Q?lISczVCDYwJuTCbs88tqllAFQm0TvII+X+w9wzEJH4YLFdYA4SktEzIf/N6P?=
 =?us-ascii?Q?ZTUMXbagPou83o0oOPqUTgET2XtgOnY+LO8atxhVXFVxvVpLmV0/bcJI+Dp8?=
 =?us-ascii?Q?Bi5EInlFQt+0cuST75FlSXosyzppBBzLmsKSApXgLaxTn/3B/dGSni0Dqzwj?=
 =?us-ascii?Q?3W65ykHGWyh3HRH4WIEiIHJHLz1QTyMgBHSLFuHW5etu9y29ApLTMs1VFDZO?=
 =?us-ascii?Q?yd/P21ryKvOZvz4/elQxDR3qn0Q/jFTq6cWxDLCo0eKHdLItOMo9SEScQYGD?=
 =?us-ascii?Q?ZeeTmSJKDh+JXpF1vDjfQEskRNstB6/JLdHfsoelUKwZkWHYKD016ZypOD3a?=
 =?us-ascii?Q?R70YyAEPlLZnNOd32kGQYx3wQFRAk/6cFfkvNdze3Z7GY0fENEZOlyk3ymqg?=
 =?us-ascii?Q?ghCnoJhRhY2wIV7ufuhGxqydcjIcf19sN2S6VuWCxlsop9OF2qUjydknskEN?=
 =?us-ascii?Q?yA8VEf1/FUKcCqkkW3za8EoyuQv06j1bAvWy0eEwedm/5jMIUduof1c6LD1Y?=
 =?us-ascii?Q?yuGmS1v2GMFQ68JBSb4H61tnZYFaRfmRGihozmFP4D48379M8YW+XC9UdM37?=
 =?us-ascii?Q?TIGgeDvrm9r2nE0QE9R/0SXkaW1bT2/T1I9R3ZHRWnpqJL1Ig6LUlHrL6aFq?=
 =?us-ascii?Q?x/zHNxlOKA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dc9618-b4bd-4636-fcd9-08ded86891c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 18:34:36.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w21qRu4Fy2/G4G3WuhNDTjp2xdPqiR0RdnFyDHrS2s2v3/tFu08oUAaQwkzbMzl37ngnEBsnDvQg7+F6GQoKEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712

Hi Peter,

On Thu, Jul 02, 2026 at 08:21:18PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 02, 2026 at 07:09:17PM +0200, Andrea Righi wrote:
> > Never attempt to migrate migration-disabled tasks or tasks that can only
> > run on a single CPU when switching donor's execution context, preventing
> > task pinning violations.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/core.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3cc6fb1d20547..8a3eecc7caf5d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6936,6 +6936,20 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
> >  			 */
> >  			if (curr_in_chain)
> >  				return proxy_resched_idle(rq);
> > +			/*
> > +			 * Tasks pinned to a single CPU (per-CPU kthreads via
> > +			 * kthread_bind(), tasks under migrate_disable()) cannot
> > +			 * be moved to @owner_cpu. proxy_migrate_task() uses
> > +			 * __set_task_cpu() which would silently violate the
> > +			 * pinning and leave the task to run on a CPU outside
> > +			 * its cpus_ptr once it is unblocked. Deactivate it on
> > +			 * this CPU; the owner running elsewhere will wake @p
> > +			 * back up when the mutex becomes available.
> > +			 */
> 
> No, this is actually OK. Remember, we only migrate the scheduling
> context, but the task as such won't ever execute on the remote CPU.

Yeah... makes sense. This patch is actually coming from the previous series,
maybe I was hitting a different issue with the sched_ext core. I'll remove this
one and repeat my tests.

Thanks,
-Andrea
