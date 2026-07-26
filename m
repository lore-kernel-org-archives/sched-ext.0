Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C61EB5CE
	for <sched-ext@lists.linux.dev>; Sun, 26 Jul 2026 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785097253; cv=fail; b=chMV5DX7ioUQgT9lSJibcBFS2ockn9RuHSl2xMQgLWJUIvknldrTJzvIyCEEvrIAcGbRT4Bm65C9sCAwxmLfyLYf6rmExBlxUJuptJhHLZqmha6K54cCf2WDkZU1BoPHVLto17J/zLNCS3CCtuGID0rlwdRIb/iEYUDD7zC6Zdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785097253; c=relaxed/simple;
	bh=yqgYMhe4lrv8xZUG5LBwowKyfQY53ujLvhosLcnfpW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hQQMRlAONA7TiLMAfBEH00MiMg6MCyUnOgckNcQqTRu7n2wAi1MS1u9L+ukDROx3/xtYEXnhGR+0O4dI3a2pwpaUajXSjAo9Unv0qYpXTBt3xgin+7C+1EQmxWGapvK3UtB13iMVnxgVp1RZ0CF9isuY/b+BEEFcK6d5JFq9MRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NT6vnlPQ; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NT6vnlPQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctrKs74xFqI25Si53KJMl9kgBW5mIYvSE/sI1pfqKYkCIRscz/niMo86eC8TOlntLz04rpUFxEuWqRvAxaQcjQaZdVdMdnSX8MpolcCjYr0Wg6Bk/uUkUXZ1anTuW7X9xsG6OlfMJAfZcsdnJmXv8JwsE/1mthHA9vcmjynQq57/hmgb45eBN6/6sfn/9ibPA6ez+WeA28bkppa8DwnJPgjK/Vfa74OkJkQxPG9hnIBV1JfHA349u3leHw/xThZqEl08XdpAqaBEPalAg3JKqCsvGqR9pAhZ/DyzVpOx8uAyl9HkGZn0krzyVZlBoS5g5FsIvJTWzt9NhJj0M53yrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJOq1IN+mfGFwYZtY9ZO7JKkDfL4EVjoflSu795CYt0=;
 b=DH7F+tkW6Yvl3Cy1aeLv7HOTuEBdt6cL7X89af/hphjll3D32Ae3e4MiJZISHDXW4Vmbq8QwpoZFuSJ7xLGoep3AD169nRMgO45NQ6yvnV67gaUAYkITXUGXw9KUnkFRnF/cUuUDvhpB4fxlTIosuu7+EZhD99JIPclbUrDt3CrSDrOOW9Ed3RDTCoeqkB4Fohe/terJullI4nVeWM8qaWbrHEsDhJMUdLl6rLxrR6JTqjzijYdNVkS+unzX8LQITsrreM4iBi6xzGGf2cNF5kYpMSPQk9VecsQqdBVA26pU3tayyxYLBg4SfsVS2Sw7W6oAPpUssAPEUU33xHJMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJOq1IN+mfGFwYZtY9ZO7JKkDfL4EVjoflSu795CYt0=;
 b=NT6vnlPQTtzre7UskOJuqFBzOCkEpu2aq4mv5PT1y3883bjxW0U5NE4+hPMDRVfhW2Ar+kfZLcw+54RdCTpehKnKjdw4KqMxck8wpS9qiWcPqE4oYHiwN0bveHad1Wv+EkUEcgy1l+PUZmeSNPFLLDy/HYb++Iho3yCMFHCXrP5TeqQhv7yM1PxPYhuiZqYmS1s+HMPqeXWznXJGkbFQkoEPTXIASo82+4yb4IMXfwvcG1sWQR/xWCagBjFGHR50vYjXYYUNfd1L/07KeW85dRu4dUczPQ+sRRbCEpUCH/vUHeT5tbd7e4C8ZQbu1S2P5+a2x6QDto+Y2EQAnJAuXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 20:20:44 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 20:20:44 +0000
Date: Sun, 26 Jul 2026 22:20:33 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3] sched_ext: Bound per-task
 reenqueues and eject the owning scheduler
Message-ID: <amZsEbZJdDgjstPF@gpd4>
References: <6649066b805d5660b598f3155c30daac@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6649066b805d5660b598f3155c30daac@kernel.org>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c3bad9-c47d-4dde-a27c-08deeb535eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pbNLE9GKp9RuUdhT2cLKRioNelAA0uNSQhLs0MhnQmSFEHDSitxY0WO+xS9d9v5RSDtfZVwZVzluo7rvMFDR5blzVeDx07cm/lFL/ML7D8kRqp49ZFGDE4WXyw/+6CWgLHREhPrCmMrhYxzqawwZNRINoFEHVCB4FBKdUhzvn5/diOf7b0kq59299qbpfYgIE9u103Tk209V6bonE2JLBis7z6tHQTpRgkbtU63kVpd8P6bemTO/+92UWAr0sdk5jmOfGsQS4V9xiEZUPzwt7ALhHuNA8Aq6x6KYsTI4la4dOU/Mq6KLiFqVAHyyLP0IimKG1mB3OTijQe4XYQ4q9kCAj0F/fIDFDc0mDWV6gD7B4L+Z8QVbrfBwy8tBUwLoeJPeQFnLf8FNNvuOj4aMmUtjGLIb+TLzDbUkBI2MEsLrWHiPNgJHHT3ndem0Rd7ycu4t4QiAfsPvjLEeqaQAPWlruouQ/DV15ob+H7pySbV0q7ss942R9WcfHBeEX+mdKrQmprNQDRNEHHxn1UurNJI9ElmlfgA376Mxzfr2bwIawhDrL6HWaYArrtF7dqeIHUfp+umul4WJYKy+W2RuiLdUfFjMDEDHWIs0OUWXnxfO/t1oJCPhDDaex5qX9uwbY8PXITYhISy9rPcmgyxWsDXeMbao2aZGOYyYB03d4gI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfde4Gr+I11zVnyUUnBms5JvWgxlcmrLlxOhMkyJPtCQyeWtTxyltnt46evA?=
 =?us-ascii?Q?o/QOdmy7Y2/S9E4Bx4/iO/QWWZyUuHjLa3iDjCbzO3uRYSTEnI138K4GOoAn?=
 =?us-ascii?Q?lGwYWPkMfBassk1VVQWwkyNNKcbqAEz00f1rVBYpjaw8OSQzBnHt+wO1SDKr?=
 =?us-ascii?Q?woAjoRK+tY22R6oZNLaL7RJmTyPjxmabAIr4H3z0AO3p+Y8uNaAzs+8ZRFPO?=
 =?us-ascii?Q?R89Q1mZLWCw+rgp2LsGfeD3HjiYim244GhLVn9QAjEjbWLKuuhKXY0qGqQgK?=
 =?us-ascii?Q?u13qHRRQZDSLFDpXtUdlPuEfjb3EUbc7hzH6DoEuMibfbdqpGsSYdQUaV7tQ?=
 =?us-ascii?Q?QHnUVjgByWh6xttE+4vFlS7jNmu6RREu8UA3MKpwBODqcQ1gt+feMi3Xhdxw?=
 =?us-ascii?Q?jn+QXJ8hyrOL+n5wkZkRY9e760leTsfSMNnVNlQ1fjISYlmk3DHoTDF7YgNC?=
 =?us-ascii?Q?m/TkeuYbH70W+Rl99lzGAlFAbKBh88KFQ4ZaEYuBM0K8N2fxK0UaFrg9uqvr?=
 =?us-ascii?Q?Qon23TRCX5ZNe5Q4GbLrexWrUF0vLjQ3L9eRwSbmcM4ePmsRYLgsevVtiSlD?=
 =?us-ascii?Q?R7wbyuhBQok9YKElbNz7KT2fvL/337uD05AJ1xEPVG5sFQGxixRn0moTcQkl?=
 =?us-ascii?Q?pnqz5SyeHpn0gT4EZSLQa1mZJciXzanFdBLm5xmjhUP9s/6wZrVh3ejuv5Yp?=
 =?us-ascii?Q?8CdWyyEZk4pvrNTLuv2uu1l/pp/2XBwXlpbursNJCUldd6wy1FqzEKH69+n7?=
 =?us-ascii?Q?QHQ/gH7va9rOgXN59v802tNHEcYXFiba973je0WaFLzGiGspd5NxA8n5WJMb?=
 =?us-ascii?Q?+GHMdZtQwrEM6NIkypuRrI9uBltwOkzw5OLcaP8w1xOWGUu+5qNTgYwcEwop?=
 =?us-ascii?Q?6BRQmFJlXwmTpqB5o7mK9KJKz8vDdzDo2a2/T7Qy1L8SME/awF8krj+YW49t?=
 =?us-ascii?Q?3AIjMERG9I2WjL0HPRtPvPzCujCK2xX3+8IAexG/gSXh7kO3xllu6QJMAFlr?=
 =?us-ascii?Q?LGEBNNKm3H+Km2L1uRY+Z3V16QX10XZ9VZAjzqV4RX5Ic5kGbez+Asdct+TK?=
 =?us-ascii?Q?/1TGIRzYIVDo8DkELV7U9SyCpVOu036d94ZWk7pCjQ7nIDwYiqYoO1mO2072?=
 =?us-ascii?Q?PN/4DRWqAojF75ObutG/c/vsiqEcU5gmwHwZBRLP/zlYYIXcS5DShSoWaR4l?=
 =?us-ascii?Q?EgDRISkrvddhZRhkWIvL/ZEiK0kigwXw9z4W3dHOznd1tPd/ZHk+Iz0NcISc?=
 =?us-ascii?Q?837vA57Sf1PNEMKVE4gpjOfcr0csbvIJziThSUKoxV4w10Qv7hEngvWyjgMe?=
 =?us-ascii?Q?7oOpLri6q19Mycv1vL9GTqi4diUkCC3sIvKsxg0SHvoIS63pD61EIk78eq5u?=
 =?us-ascii?Q?zZgnW6SDfvsFiRZmgRY0vFLd/ISS7HGswI6VXKH6LAhV/FOiWry2JKqnp5Bi?=
 =?us-ascii?Q?s/rc906uTnHfOXFOi4v/FinAcVSDzw1DWl1C6IXfarIMT1QZWbFNMrweUOJl?=
 =?us-ascii?Q?M+u5v0mV5FCnP4ykYZTpItkzrVQJbHOT9m9ynE2O99ct32bIg8u7mRlPp4Iu?=
 =?us-ascii?Q?Vmt/mUO4FKmF7YiOmtsIq5L9zKIKKi+/d4GK3qj6R0MFRjn5wS4jsHRGTa8a?=
 =?us-ascii?Q?W75xcWosV5D8Iv6x17D2mZhkFziHbBuaEctdAJr/mMTl0n5YgQNIcGVJdo5F?=
 =?us-ascii?Q?32muvDUJTjph+G5ZSsTgfy5Fl7ysXHf2KUaFq7ow1rZi9TLMHCogNLt90DJF?=
 =?us-ascii?Q?7eBc4XtIuA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c3bad9-c47d-4dde-a27c-08deeb535eca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 20:20:44.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUHGow11Y4N+9Pz1VCxGVpJ3V2kDmBUE2dswx2P7LQ2XCMJPhZcO6RpTJ8paL3wvfzrOS8Py2o9YRUbTD1z1/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072

Hi Tejun,

On Sun, Jul 26, 2026 at 09:49:54AM -1000, Tejun Heo wrote:
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
> problem. Counted per-cpu on root, it tears down the whole hierarchy even
> when a sub-scheduler caused the repeated reenqueues.
> 
> Generalize by bounding every reenqueue with one per-task counter. reenq_cnt
> is bumped in scx_do_enqueue_task() on each SCX_ENQ_REENQ, the single path
> every reenqueue producer passes through, and cleared in clr_task_runnable()
> when the task is picked to run and in scx_disable_task() when it leaves the
> scheduler's control. Past SCX_REENQ_MAX_REPEAT the task's owning scheduler
> is ejected with a new SCX_EXIT_ERROR_REENQ and the task is left stranded to
> be picked up during sched exit.
> 
> The SCX_EV_REENQ_LOCAL_REPEAT event becomes SCX_EV_REENQ_REPEAT, counting
> repeat reenqueues from all sources.
> 
> v2: Count SCX_EV_REENQ_REPEAT only when a reenqueue leads to another
>     reenqueue, not on every reenqueue.
> 
> v3: - Also clear reenq_cnt in scx_disable_task() so that the count doesn't
>       carry over to the next owner across sched class switches, scheduler
>       replacement or sub-scheduler rehoming (Andrea Righi).
> 
>     - Update the stale SCX_EV_REENQ_LOCAL_REPEAT references in sched-ext.rst
>       (Andrea Righi).
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Ack about counting all reenqueues.

One minor nit: tools/sched_ext/include/scx/enum_defs.autogen.h still defines
HAVE_SCX_REENQ_LOCAL_MAX_REPEAT, should be renamed to HAVE_SCX_REENQ_MAX_REPEAT.

Other than that, looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  Documentation/scheduler/sched-ext.rst |    8 ++--
>  include/linux/sched/ext.h             |    1 
>  kernel/sched/ext/ext.c                |   58 +++++++++++++++++++---------------
>  kernel/sched/ext/internal.h           |   19 ++++-------
>  kernel/sched/ext/sub.c                |    6 +--
>  kernel/sched/ext/types.h              |    2 -
>  kernel/sched/sched.h                  |    1 
>  7 files changed, 51 insertions(+), 44 deletions(-)
> 
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -106,7 +106,7 @@ counters. Each counter occupies one ``na
>      SCX_EV_ENQ_SKIP_EXITING 0
>      SCX_EV_ENQ_SKIP_MIGRATION_DISABLED 0
>      SCX_EV_REENQ_IMMED 0
> -    SCX_EV_REENQ_LOCAL_REPEAT 0
> +    SCX_EV_REENQ_REPEAT 0
>      SCX_EV_REFILL_SLICE_DFL 456789
>      SCX_EV_BYPASS_DURATION 0
>      SCX_EV_BYPASS_DISPATCH 0
> @@ -129,9 +129,9 @@ The counters are described in ``kernel/s
>    ``SCX_OPS_ENQ_MIGRATION_DISABLED`` is not set).
>  * ``SCX_EV_REENQ_IMMED``: a task dispatched with ``SCX_ENQ_IMMED`` was
>    re-enqueued because the target CPU was not available for immediate execution.
> -* ``SCX_EV_REENQ_LOCAL_REPEAT``: a reenqueue of the local DSQ triggered
> -  another reenqueue; recurring counts indicate incorrect ``SCX_ENQ_REENQ``
> -  handling in the BPF scheduler.
> +* ``SCX_EV_REENQ_REPEAT``: a reenqueue led to another reenqueue without the
> +  task running in between; recurring counts indicate that the BPF scheduler
> +  keeps re-deciding placements it can't honor.
>  * ``SCX_EV_REFILL_SLICE_DFL``: a task's time slice was refilled with the
>    default value (``SCX_SLICE_DFL``).
>  * ``SCX_EV_BYPASS_DURATION``: total nanoseconds spent in bypass mode.
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
> @@ -1904,6 +1904,24 @@ void scx_do_enqueue_task(struct rq *rq,
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
> @@ -2025,8 +2043,10 @@ static void clr_task_runnable(struct tas
>  {
>  	list_del_init(&p->scx.runnable_node);
>  	WRITE_ONCE(p->scx.runnable_cpu, -1);
> -	if (reset_runnable_at)
> +	if (reset_runnable_at) {
>  		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
> +		p->scx.reenq_cnt = 0;
> +	}
>  }
>  
>  static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_flags)
> @@ -3669,6 +3689,7 @@ static void scx_disable_task(struct scx_
>  	 */
>  	p->scx.dsq_vtime = 0;
>  	set_task_slice(p, 0);
> +	p->scx.reenq_cnt = 0;
>  
>  	/*
>  	 * Verify the task is not in BPF scheduler's custody. If flag
> @@ -4066,8 +4087,8 @@ static void process_ddsp_deferred_locals
>   * Reenqueued tasks go through ops.enqueue() with %SCX_ENQ_REENQ |
>   * %SCX_TASK_REENQ_IMMED. If the BPF scheduler dispatches back to the same local
>   * DSQ with %SCX_ENQ_IMMED while the CPU is still unavailable, this triggers
> - * another reenq cycle. Repetitions are bounded by %SCX_REENQ_LOCAL_MAX_REPEAT
> - * in process_deferred_reenq_locals().
> + * another reenq cycle. Repetitions are bounded by %SCX_REENQ_MAX_REPEAT in
> + * scx_do_enqueue_task(), which ejects the task's owning scheduler.
>   */
>  static bool local_task_should_reenq(struct rq *rq, struct task_struct *p,
>  				    u64 *reenq_flags, u32 *reason)
> @@ -4175,14 +4196,16 @@ static u32 reenq_local(struct scx_sched
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
> @@ -4201,27 +4224,12 @@ static void process_deferred_reenq_local
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
> @@ -5941,6 +5949,8 @@ static const char *scx_exit_reason(enum
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
> +	SCX_EXIT_ERROR_REENQ,	/* task hit reenqueue limit without running */
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
>  
>  	/*
>  	 * Total number of times a task's time slice was refilled with the
> @@ -1221,7 +1220,7 @@ struct scx_event_stats {
>  	SCX_EVENT(SCX_EV_ENQ_SKIP_EXITING);				\
>  	SCX_EVENT(SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);			\
>  	SCX_EVENT(SCX_EV_REENQ_IMMED);					\
> -	SCX_EVENT(SCX_EV_REENQ_LOCAL_REPEAT);				\
> +	SCX_EVENT(SCX_EV_REENQ_REPEAT);					\
>  	SCX_EVENT(SCX_EV_REFILL_SLICE_DFL);				\
>  	SCX_EVENT(SCX_EV_SLICE_CLAMPED);				\
>  	SCX_EVENT(SCX_EV_SLICE_DENIED);					\
> @@ -1260,8 +1259,6 @@ struct scx_dsp_ctx {
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
