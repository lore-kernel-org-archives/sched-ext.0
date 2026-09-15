Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ABF3F1050
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505761; cv=fail; b=bjeBsVRUMBLXfBk073qhqUJDzkphKpd187D7bi/R05+9T0A8zH7FxZ+TZoKRKNwlJbZgLcLOSS/xCH5y/5YOV0GRSMU+r0wgCIGcQ/CGKBpfIG2slLow0ZxPQ/OiXnNxLhkuNhJh5qIzEAfdVn43wYdhKYQSF3zakuSn/9DCVa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505761; c=relaxed/simple;
	bh=Doaky4pCWUhOzFg+q4qPoVaiQvmVAFimVXglzyPyPlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=txR+EWiFdFvHC6JXYZOQRRWnobDN6+mv6uyDfiuNf594KrB8IKIfkjrUHLCGHkrnPZUeibY/hjWfCcBhBIgOZlrf+iA4IaWB/jdUjquMGJq4kRzcwNQ04vxUE3Q8hvKxihAS3Ul0YdeoREHWIlPNIIfjY/gO4nAE3kHkNzBpEXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GS+OLFOh; arc=fail smtp.client-ip=52.101.85.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GS+OLFOh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcAg/etAOn/zulK5xPuWIapZdTzB7Il4jRY+DP4t6VfI6CSMk/cotmXI3iwOIqJTE0NTMoQljQaXKZtCIV8VWX0xVhGgKol3D3c/Cof+IPq8Vyk85PXFafokWRhGIWW7FwRZdSbc63vmg2MqO5jKRVzrp7kt9FDmY1n3LobGMahCGzTiNX7XaRx0cp68kv9AYGVVJ22gO9rF5qYWOxydhOHgjAKHxiNNa9uUIbE9laUWb0vfPwoSQu6Smi8pHVbUSChY9tFq7l6zodV13Ap+UGy40hA0y8gXquFWI+6WrHYy+vY5ttqhsoyp8I/Vx4GrtiX9ab4snYFsrE6uzoDixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qY8GMpjb0WhaZciQoC5eF0WTYeohQcz3VEihl68xWfo=;
 b=GeghCC42EPwWxpgFKZqUTtB7AFGRCUZEwDSIyVd96Hzw7tmzhWYLW9KNJf7IQhFQdaqlddpSS9TYSh1eM6L+iz5ZgDXNQLFlndNjcOKUhERSWJijM/A3O7Uoq0IYmoNCyz1IW8Pa7I+6Zsqi9xvcV/i6cI6P6e2kYw1mOlaXxc4jpcbRv1XDz/Nq4jpkuYjNdP8hHas1RJZh1H6gcYGvxalC4+444ZUPQQj2JxAmFVke/vN7pOq0OO+iktBjBC2LbJTNZjA7w+zGYmMBXSfjkYTTE0l1q21YCUtaPGFPAPBqbzGaLC/DkyVzSPAAOb6j+RSNK4dn49R3UfMjx5etqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY8GMpjb0WhaZciQoC5eF0WTYeohQcz3VEihl68xWfo=;
 b=GS+OLFOh5BPEKoMULCEL3rlWM/bWyevhFhn5bYaFNCNMMC0ZE8KrmxBAxCBBPPbsr10N8iRj2Pxp013X0b6xKTV6mPblaSm6OF6CS4z9OlVTficNVId+RJ3su1n7hO3Pnb2N97IX428Z054yHfzhupBoTIVmj4GqNt7aYbUufh+0tBwyflMgnyVJr1E3/5G8BbgfBgKW7XPWzJBD/TNJ2Bjr+lN9Fp4QhVdLgcHix1MAqq0xVJJ18TGkC0A8UGM7K4cTUNgENCGKTg7SuZDK+UwaN2o6uJIRFJFHcfHWetOpUkydjUvIQY4dgdaFGDwh/lampWuQ8unKMnVqKOJkCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB507217.namprd12.prod.outlook.com (2603:10b6:408:3b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 20:55:54 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 20:55:54 +0000
Date: Tue, 15 Sep 2026 22:55:44 +0200
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
Subject: Re: [PATCH 08/18] sched: Introduce WF_ON_RQ wake flag
Message-ID: <aqmw0OT5cCtge-QI@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-9-arighi@nvidia.com>
 <20260910104528.GI4120091@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910104528.GI4120091@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1PEPF000008C2.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::43c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB507217:EE_
X-MS-Office365-Filtering-Correlation-Id: 0524b34b-6932-4262-36c1-08df136bbbab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|56012099006|4143699003|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	BsFO5Y+XFcUwNeSIYqxW1IJy7f7asC+hxgp81ECE6tPeVnLm9EunDiM9m+rPQi29wCwlne35ycP9Or6MO5dGdeGdmuave0y9XRw7QDYGlxisZQILS+efBHSYT7vJ8J3g51ih1jy4VygQ4o4FIuMBQxbIHjL97fRCK9HSKBcmOew3jM/9KLzypbLQ8bgL6Rc995INp35UswraPtbqNYm6Qbp5yXJgnzrDXr8rI/4Uw87zl11TuiABZHl6mQsM3U3bOBsOaHkMcIzXJyfNgoKiDsDhKN5ZgrLrmDU/diPd9CAy4gZB9dkJEFVxX8REkpNp7yEDhy3UIWoUNcVHm0IlGK8FbNMKCd0ar0FxaWHkeb39wWGPVYt5HPLJwkKBVbkdWbjG2dmtOeSJW0817R+IlAA44Ey6gDTemLHIagB/JsaO+98zmVM0DwRtr/YHUR2uTE6X3B1RcgYHMLbzNHoZHtidiIdu0alhL2B8OitaA+tsvXarsDmFtJ6Z2iPQtoYMJ+soaCFnYrjD7B+V3LzXPqB2l81oUNzjwO8fcFvOpswi4ijSU55Gmsc6QYA+ilSBpCz872ZrZUqYMxStVFJFUPncehi8s7EbCWKtcIRl6rDXurE1UXaAia9/9jlW/Zx4BmjAXE+Z74K1IHKMDIkjuqzaUBMEE/lz3qMRQD3O4CQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GTqQPebiLDYFkBw0SJzz1WDEjeitm8OBjVtbCPfmPzr9Gihpok17Z6y0BaIP?=
 =?us-ascii?Q?ZZ3LUdIkGUZTy8P62OAhQHZZTNFzSeIe6UGPv9PDDEa3/qEw2XppuOReoD1D?=
 =?us-ascii?Q?THL4gA9LI0zkb7TM7yD2T3tFMGmd71Om8Hkm5WJjWK72a2cpuyzV7qy8Q4Wt?=
 =?us-ascii?Q?aQmv+n+KwltwwUypJuwqa5IggTwlsgGry+Vv+JFBBj9jyNgYD/YkHVZiZc0Y?=
 =?us-ascii?Q?Rx3z0o+v88iCzVknKzhnfrbgedYo62kFLKRitYN/TjNMdqVH7+01qvuvHNEH?=
 =?us-ascii?Q?RjA3xANn6GCu2puykMGQDSXKhHBPqn4vI93YJH43glgvlYtpaXiGhSlKTwbb?=
 =?us-ascii?Q?aWUWX5l+BbnMYX7VvUOA6euvIGXAYq1mMNqSKgtcnoiCBDfppJQkRduArejY?=
 =?us-ascii?Q?WCSlMdw+FdZqsJGxadUYldd051MGXZgTbXIaFRattn9q+K1O8GxsPU4JkTr4?=
 =?us-ascii?Q?VMKvL0kEQdWfVcF701mAlOckg0H87YGz4hN/9ItUPlk7p1CnlrYx0eutJyjf?=
 =?us-ascii?Q?p66Wxl/yf2hl2liVBbHEe0X+ldu7tLtc5SVGTUp3znsIDSFvKOHgQ8zTWIVQ?=
 =?us-ascii?Q?dKan50JGxYWltpKJu+4riWpBqE0UeOC287/7U5igdd9aIxs3ZrvwUgIqKLGI?=
 =?us-ascii?Q?a+dDulK3rZT+1sBcL+QgGlALTqwOAMIKmiKoqr3hnDwCgaWQ165hcHlezrHB?=
 =?us-ascii?Q?RSI5aEwAU5LmDXwHGADgUgDDYJ7P0zr5esoaxhiAFDIs1OX5CYxAkdkHXOur?=
 =?us-ascii?Q?D0SZThDJNarIRD48uJ3qE+H3kBRvZ2Qn9VL2ZJR7HIIxQ3GPEu1Yen8ieLSj?=
 =?us-ascii?Q?P/vvowMqpD9r/VypYZId3dnK+4u+7BOIERq9aN1NDDk6e+rGurVnjeVXHBnW?=
 =?us-ascii?Q?2DijMYoBdNX4L5A/T69SxJKEUxNZqd01ya9dKy3OdUxtGytes2NTgn9mKBhj?=
 =?us-ascii?Q?PMPv3LsLj06cecI6QByhPzhC41FemUfXW5uupMN8VUr0Fkwua0grYkOz2QVe?=
 =?us-ascii?Q?9k+ah3N0deJG1AgeXI437LvnxYyQLQKLjecOrcRItUly4dzc9FecENp0L69L?=
 =?us-ascii?Q?tygGNE8mgTSiCDHCUava+1gDNvZRc3XjqiW7Ztn7FOYApVhkYVaiYxqSxJ/Q?=
 =?us-ascii?Q?7UbQJBsRR4Ebp6LA/no0VgK88R5e4fs4WF7zRDR9V110WFuu1++ayhnvxZrT?=
 =?us-ascii?Q?hFALIYN4Rs89DwBD39qVbH86rT+qKRjuF4k3mERkzqXpDCW/Ayc5NUtpVAYg?=
 =?us-ascii?Q?KFBKCvEA+VVvBB6eLxLJIGvP66z/wxtGdnepaH++ALpgZf0qgAbYa5dHioaa?=
 =?us-ascii?Q?3Ks1Q2VGOHLZEbBQRYUHRZ54Zu1F7Zz8NR0sHCTKcMFKEYUKX1iej/ovDDtM?=
 =?us-ascii?Q?pOByHC9pIiEiBkF2a6JwCKKRbHwa9wGU3xLQTQFWV6Hku+n+9a9U+uarG8QN?=
 =?us-ascii?Q?3f9UicZYivRxhz09HyyJCLvcMKP8nNKBp0QZwX1j7T/PC9XOWZQzqDbUKKHU?=
 =?us-ascii?Q?ylvnABV8mHUc7L64xwShN8pRT/+yaJhT+W1vxe+AjTeimvmSlEpU5Q7eTtoJ?=
 =?us-ascii?Q?vss8fQ6p9AS//qPYGu7DOVm3Ya8zMMLmrBung9O5+wuYjKWXbpKIUWWTEaow?=
 =?us-ascii?Q?6xQOvVFbAHo/Ebx2SCEFDKzDfF+V/dF2f2/8H9uJEw+l6YAzVmscGNrg75up?=
 =?us-ascii?Q?tCO19V7Yu4eS0tFIMPWnBIcQLpwH/EVxVOUD69Ig2so2hEKDqE/I7Yms/fjk?=
 =?us-ascii?Q?/CNi9+7loA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0524b34b-6932-4262-36c1-08df136bbbab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 20:55:54.2888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHjC9gaGxMPKo6vm6hNzEB3PvnSdPnDwI3LDQ6FzZbtgH0PLwlr60McIOIMpG9VTZHdiw++4Y4xr5HVWR+OM8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB507217

On Thu, Sep 10, 2026 at 12:45:28PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 31, 2026 at 03:42:18PM +0200, Andrea Righi wrote:
> > ttwu_runnable() handles wakeups for tasks which are already on the
> > runqueue, but scheduling classes cannot distinguish that path from a
> > full wakeup activation in wakeup_preempt().
> > 
> > Pass WF_ON_RQ to wakeup_preempt() from ttwu_runnable() so scheduling
> > classes can handle already-runnable wakeups separately.
> > 
> > This is a preparatory change to support proxy execution with sched_ext.
> > No functional change.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/core.c  | 2 +-
> >  kernel/sched/sched.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index d578dd635f2eb..f142ab455b797 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3908,7 +3908,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
> >  		 * When on_rq && !on_cpu the task is preempted, see if
> >  		 * it should preempt the task that is current now.
> >  		 */
> > -		wakeup_preempt(rq, p, wake_flags);
> > +		wakeup_preempt(rq, p, wake_flags | WF_ON_RQ);
> >  	}
> >  	ttwu_do_wakeup(p);
> >  	return 1;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 56ac104f1f825..f30d122909e7b 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2538,6 +2538,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
> >  #define WF_MIGRATED		0x20 /* Internal use, task got migrated */
> >  #define WF_CURRENT_CPU		0x40 /* Prefer to move the wakee to the current CPU. */
> >  #define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
> > +#define WF_ON_RQ		0x100 /* Wakeup of an already runnable task */
> 
> I are confused again... help?
> 
> wakeup_preempt() can only ever be called for tasks that are on the
> runqueue. That is more or less the point of wakeup-preemption.
> 
> Even the already-runnable distinction would mean things like
> move_queued_task() should also have this. The task is new to this
> runqueue, but was definitely already runnable before.
> 
> What actual distinction are you needing?

Hm... yeah, WF_ON_RQ describes the wrong distinction.

What sched_ext actually needs to know is: did this wakeup use ttwu_runnable(),
changing the task back to TASK_RUNNING without calling activate_task() /
enqueue_task()?

We need the distinction because a retained proxy donor remains on the runqueue
while blocked. When it wakes, ttwu_runnable() can clear its blocked state
without calling enqueue_task_scx() again.

sched_ext must therefore request a reschedule so the newly unblocked task
is reconsidered for dispatch. We don't want this extra reschedule for a normal
wakeup because that path already called enqueue_task_scx() and performed the
required sched_ext bookkeeping.

Thanks,
-Andrea
