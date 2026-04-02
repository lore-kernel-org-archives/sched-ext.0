Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1468344D95
	for <sched-ext@lists.linux.dev>; Thu,  2 Apr 2026 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163888; cv=fail; b=lBEZStOWSy5joyZlMvC+cgOUkI/Ha6DuU+b/5sJdMZbaWObvZjPW4+m/XR8H+Xn+UD7uY+e0NVHNb7HaHBWv2NIxE8QgHR1SdkJkHeT893lldAl7x4wy7QDFlzKPDrvRbU5/puRiEah8v/vnqq73PbeQ1J2acGm4j+lBQIv0byA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163888; c=relaxed/simple;
	bh=lE+GHVo4N7ARhtoA27hIE8kniIInviv8ene5EilRu1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uJG1QU30SUD5oYlaogJgRHPc3JAWygHAMe/xOCt4Fp6taJFNDLIvoVor0EqbftapR0+3wSxdiCIihsJGykatgnBzedshT/onJ7LxtZBI2hXwTpKeYP2zvMFEp88RgJ3R7wiRmf9xIJmO3iGdvKX9b74qWyKn0mFrY2hFf3bgdAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q/9mbAiL; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q/9mbAiL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8opts7pOJr0ReWxdktu/mdvzBNOe5xblZf9f+BCXY41CZrWJdRvkBNECaXKiMR1xggacBGCfVgbzw2lxvoWItsPgThM+O1EgeFkyvXfzEWoev0Dte7ATgPjYVgwb4UU5Iu1WGCcCNOnROqWIeTduP7Dx/55teolI75FrLO1Y64cQmckzgrTX7n40BMhwkp+rJkswOVTfexATnJ/H2IkaFzB1XwQLmlK+rIxIedDbj6PXgwmC246dfK28w1xZ+6mH3fe/ojlbeqfdeb71DavQYJeEyxWG2Y1W64pHR9aequIRRLS+Xuq6udqDTvn7pNgOXN4U5/LHPOl8ijQ2YUH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2BZtkyxKt0DZmcD1dOyDQzP4/DaiHHbBhNV1SmH5vk=;
 b=PApaPUl+AYkeCe8CewuKDUugasDcMNAXasbYL9aWI1iPqaiaL86DzQ+zzRsHqKyh2UpA323ixhB5o2X5BFzRgTOxmu2ar7QAURObgUbtTkJ+/I69vHqBQ1hpGAHmaPTUSNAgVFo/SsOrcL6Id5dvYyukutFVyIByyT5eI0DKNM8FMY+N7BtJexgOTFkoW1ksql2yBKd4Y/LzWQMpt2mzL6fTY5w1AIVrBQAeakpvhmEboMh/6I/bEb8XfJ0fokvnvB1QEnI3g6lvzvUEAd0gbZZYA9Flxy+6N4qv8xDL4nQUE4Dnx/R83OWL+S0R2Qspu0KwifmaIO6VT0sXzsANLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2BZtkyxKt0DZmcD1dOyDQzP4/DaiHHbBhNV1SmH5vk=;
 b=Q/9mbAiLnHt0jBiQbUR4r+zrJEXvm7BhlnQHS3E854Oj9mWfRMXooj+2S3h5yWnIBJ83mBxejodmaUYznc23JG0QOQ95b0Vt7oPBaMI8kvBDuLc6NJlW4L+hl7sON22DxKO1zyTjlEPZemzZRnCW8tcSYGTXqIeGn5fnD4GchzSV9HrFKuZ5kg5ma4AAgnpgSr/ji4I90PimsCXKi19rYKSd1eCY4bOD5LFxvxV09FXcR5FEXuiH+rdDdPETypBT2xaovnMfbVzZ2jxBKPB82hf50c1W5zHd/SP+XChYqS2kyZ6pjJg7Gj2SeezmsOopxkw76ERy7GO0PfT8tlKiQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 21:04:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 21:04:40 +0000
Date: Thu, 2 Apr 2026 23:04:30 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Patrick Somaru <patsomaru@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Fix stale direct dispatch state in
 ddsp_dsq_id
Message-ID: <ac7Z3kRnOMey_fDH@gpd4>
References: <20260402085743.1410070-1-arighi@nvidia.com>
 <ac7NLDdANzT-t6FH@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7NLDdANzT-t6FH@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0022.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4c9685-4baa-4d0e-fd45-08de90fb7432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3nJd1W+6KFEN2rK1k1Ld1NDn1U/UI7dFDquRz0DctBjgNrzB70t6MlY1qgWjcOK2EdMg3GxDSaRi/ZOHJN2BlxUGxcSgIf0FyluGTwm4sDuFQpy4IHsZnZg8UpYYvedxda8vMBy78GWf1dAHSPEH/FBcvGWqlT1eiczkp082HcEbqi+uUKpocRnpDu6PwGzSMx57wIhhi+O0ynBeoV4KEDb+MJ5GbhPOL23bc76m2K3AVv7qm5Rjz/5v055IcGDARH4RbqU2eXuCQAJeYyAeFKVGjyX5HKzTQ2RYNXZAK8IaGVQdrS7S2fbATIJSnqnMK3kesIAP69eh8wyH30/FlZ08pciVt+3eg8vvy31t1UQrWq/RQ8Tvv116vrq9wKKMupw4Lns2AYmTrt4OmdwAdmtVgHswhoLvL70EcxDV/8nn8RHVRIlcWJYVlerHjoyYMQMUeHl8rVRYhoN0aP3EVWrs6TxyjqlaZoEnT+34Tc9PV9oDcuv4TUw1XmExzBDg3wCarDLOrkGy6RW9/QDVmYA9bxp6ky4oOw6qkzoFgXrVh+dhpDE+pgs6IUbWkeJrVhnbFHlBgD3Er9P6GOmL3+daAyGPyxTWu9Htr8iOmqOSrQKZYEHACNd8SAFAUwHcyzNuP/AbfuaLt590yIrdFy+U6K2vMWrzCP6UTIXQZR88VD2qk6AlvpxPHoLuTybXiHA9WHk17+UQZ85G2/SBXpggI0qJf1E8A5NJytSlqco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YdaMIEprdcurahxEduHDEQ4KFnKkC9FtU2Q3s8WlAMtwRaezkG5+A+Xj+GPD?=
 =?us-ascii?Q?eUge0p1YTtF9C8iIRB8GmL2vQigxNFyHGHRKo+kgQ4EQlqkSR94QQg6YORU9?=
 =?us-ascii?Q?EqPONxhrI3PPY5/cEUc33dNZ00nM1zVxj9mfs6CgQgAef8jHMY70C7zLNuRL?=
 =?us-ascii?Q?qsdkBLWCoSFwAiNnv/VWHc53D4t+ynjN/Xi7pS46YCJTVn8sCqxTl6Z5PFjA?=
 =?us-ascii?Q?ri90m+5UpeeVhhKQUmhGQ7x6g92x7IyMvab/5p7hVcs/kim8P1se0R+zFamt?=
 =?us-ascii?Q?BwI/f3xipSa1HVNqZv2NyDl8v51t+Xp55q/eT+ZLD7hQOaNqeMa8tEhI/Yq5?=
 =?us-ascii?Q?XI9dWMBlbdDkPMt002RiZ7k8lbWwVyetel3iv0gVeZOK3uQvjHOteIoWVrxe?=
 =?us-ascii?Q?z+wJwDDkBuOB/CwFTZSWHRFvOoRUuO2FdkTzrZxNa2kGxT9TaWRMuo1hEd6v?=
 =?us-ascii?Q?1rQ9TdnapVOASSQCRWOIZe5uCf/cPb7AWDpeUlvdrdu96Ta/tupamYsMlqU6?=
 =?us-ascii?Q?hRHnWSH0tkSwYocOkd+QrpvNgBICZWmC13t+YBfisM672V71fUM5i/W8hAkw?=
 =?us-ascii?Q?Dq151T72H5rj+kCUt2mDEi1QdYlwzT4w1gqECXWkCLJ/ye++/r95Ltu5Q4V+?=
 =?us-ascii?Q?/dkxFLeZ/1eFSBVePjTj3oTUCZvJ3tHrxs7ny2yhwYBfh84NPkBLoDonR4kl?=
 =?us-ascii?Q?F5636L0AlDdyprFMbIi2bKciECBrGehvuM9qF4PbLWFGPr3iHmJTGvoJrEVL?=
 =?us-ascii?Q?aOleIUs6XHOEAlF40dDDD0wv+eoXF48ieKg09GAC7OFnKviKcmDpGfIMYOy5?=
 =?us-ascii?Q?6zoIJH+MVZl5CMwj28nuw8QhtEseainU9lfesb/B3Jm9DAV404uDS7hjFiPB?=
 =?us-ascii?Q?y3o/ShqvMn9RI/bxzlM0dWUeXgHZwF8GKVIE28KvZ1+jvZjWm174aEU4CtpK?=
 =?us-ascii?Q?7xnimqMxKUIdobXqJpTWbUmPrd94gZz9nGmPOOrKl2lQWx8hYyysKQ4hulLO?=
 =?us-ascii?Q?clDS7DftDPKOMdKwfbAfRiWC4lVTggEBRINdn8WukZ3zfSzPDfWSvM4q3jiv?=
 =?us-ascii?Q?YfSSlvEP3z4YH+o1m9cuc7PXvalL3Zckiy+I+lM58k8Lt1fOVyhgQHH2uBUr?=
 =?us-ascii?Q?adLU77PIPxk/yIApk3qRF/+IpPp5ciQaEE0EmeHnOOgbEn4tIQ6cr5g5ywRa?=
 =?us-ascii?Q?ZjI5uwviUeUTNQqn0xQe8exgA2v381Z10wM6zAbj0SOTOU2806AM1/Gj6lH0?=
 =?us-ascii?Q?Py3V4e1M/fWRkMXVLh8g9b5J9PvSqf5H8tb+X2PyxsUkm6g7zNbwLVgtJSl5?=
 =?us-ascii?Q?UEjFWw0lGg68IUQU0WSeqpWL7O2pRYkPSjxuWAy0Cun8UoZIfy7Wje0WuMnR?=
 =?us-ascii?Q?IuN0wAen0CX3I5XSLW4XDHbt+UMMfP1J+Wq1f2ljD3tBLCbBA7cWeEoTgBGn?=
 =?us-ascii?Q?80G595UV/fEos3GiolIBeP1uX/VSMQOnOj+IP2mmVCG3Uy6cbtCKymSNPepY?=
 =?us-ascii?Q?f7TXNuWTbnbJoUOPaw4WUsUC6zNfw7T3jbY9JLyws2IOpxekRtUwKrucTYg9?=
 =?us-ascii?Q?zzowAhxNZqQvso0KiWvbQg7YNLTm8OEerB1yuAog0dwz4yVbm3RLMFTiZNXE?=
 =?us-ascii?Q?HNuShrqe5WR6ChGxgklL/C3axlyRhcG21i4XKzbjbfuyaeRVoC6mPnukk3vo?=
 =?us-ascii?Q?PCxtxock6aBvvlAOVTc3Umw1YckQqwSHC9SN53J9KiZVydpmZdJqML7zGG9D?=
 =?us-ascii?Q?+/itsJeFQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4c9685-4baa-4d0e-fd45-08de90fb7432
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 21:04:39.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXbho2ChYRa/QsSFBqSu6WxhejK+/963zHKANEEV5Iy/02GBN/EZuKsQyt5z/92Zem3vzN4lu98YhKsb46Y4HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

Hi Tejun,

On Thu, Apr 02, 2026 at 10:10:20AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Thu, Apr 02, 2026 at 10:57:43AM +0200, Andrea Righi wrote:
> > @p->scx.ddsp_dsq_id can be left set (non-SCX_DSQ_INVALID) triggering a
> > spurious warning in mark_direct_dispatch() when the next wakeup's
> > ops.select_cpu() calls scx_bpf_dsq_insert(), such as:
> > 
> >  WARNING: kernel/sched/ext.c:1273 at scx_dsq_insert_commit+0xcd/0x140
> > 
> > The root cause is that ddsp_dsq_id was only cleared in dispatch_enqueue(),
> > which is not reached in all paths that consume or cancel a direct dispatch
> > verdict. Instead, clear it at the right places:
> > 
> >  - direct_dispatch(): cache the direct dispatch state in local variables
> >    and clear it before dispatch_enqueue() on the synchronous path. For
> >    the deferred path, the direct dispatch state must remain set until
> >    process_ddsp_deferred_locals() consumes them.
> > 
> >  - process_ddsp_deferred_locals(): cache the dispatch state in local
> >    variables and clear it before calling dispatch_to_local_dsq(), which
> >    may migrate the task to another rq.
> > 
> >  - do_enqueue_task(): clear the dispatch state on the enqueue path
> >    (local/global/bypass fallbacks), where the direct dispatch verdict is
> >    ignored.
> > 
> >  - dequeue_task_scx(): clear the dispatch state after dispatch_dequeue()
> >    to handle both the deferred dispatch cancellation and the holding_cpu
> >    race, covering all cases where a pending direct dispatch is
> >    cancelled.
> > 
> >  - scx_disable_task(): clear the direct dispatch state when
> >    transitioning a task out of the current scheduler. Waking tasks may
> >    have had the direct dispatch state set by the outgoing scheduler's
> >    ops.select_cpu() and then been queued on a wake_list via
> >    ttwu_queue_wakelist(), when SCX_OPS_ALLOW_QUEUED_WAKEUP is set. Such
> >    tasks are not on the runqueue and are not iterated by scx_bypass(),
> >    so their direct dispatch state won't be cleared. Without this clear,
> >    when the new scheduler calls scx_enable_task() for these tasks, any
> >    subsequent ops.select_cpu() call that tries to direct dispatch the
> >    task will trigger the WARN_ON_ONCE() in mark_direct_dispatch().
> 
> Can you add an abbreviated version of the above as functio comment on
> clear_direct_dispatch()?

Ack.

> 
> >  static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
> >  			    u64 enq_flags)
> >  {
> ...
> > @@ -1303,6 +1301,12 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
> >  	if (dsq->id == SCX_DSQ_LOCAL && dsq != &rq->scx.local_dsq) {
> >  		unsigned long opss;
> >  
> > +		/*
> > +		 * Update the direct dispatch state and keep it until
> > +		 * process_ddsp_deferred_locals() consumes it.
> > +		 */
> > +		p->scx.ddsp_enq_flags = ddsp_enq_flags;
> 
> I know I suggested it but this looks kinda odd. How about we keep the
> original p->scx.ddsp_enq_flags |= enq_flags above and then do
> 
> ...
> 
> Cache enq_flags here?

Ack.

> 
> > +	clear_direct_dispatch(p);
> > +	dispatch_enqueue(sch, dsq, p, ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
> >  }
> >  
> >  static bool scx_rq_online(struct rq *rq)
> ...
> > @@ -3147,6 +3155,8 @@ static bool task_dead_and_done(struct task_struct *p)
> >  
> >  	lockdep_assert_rq_held(rq);
> >  
> > +	clear_direct_dispatch(p);
> 
> This is task_dead_and_done(), not scx_disable_task(). Is this intended?

No, I messed up. My initial patch was based on for-7.1, I backported to
for-7.0-fixes and this chunk was applied to the wrong function. Thanks for
catching it!

I'll send a new version.

-Andrea
