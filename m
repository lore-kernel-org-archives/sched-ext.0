Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012030.outbound.protection.outlook.com [40.107.200.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18873D669F
	for <sched-ext@lists.linux.dev>; Thu,  7 May 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148814; cv=fail; b=XWfYgBoqwIwAwXPRl1oCjrO0ufoX4osrv6kzkDvwsFPpcmitiHTtIc2i9gowTcO5DN/aEACuRM4RdupbcWo6WvbfjbGe04WNy2HpQ16AYBS3XbeyPvNJNf+i68zWC5M4xY/FHMPKvoPHTiRhP/m/zd5xC6aYypw/IsbNHsTK5Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148814; c=relaxed/simple;
	bh=Ei3hMduJLoBugCMND7zmYJfv0o+YIcBnykb/ttUhiP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EHRLcqNUyoQsbI1MEEMStnkM97thpVLg5PG/UcY9PAwcs3T+wcmllyzrQPfbjsarbsN5NpjSTnCmonIHTI8SzPQaPs0Q7ppuiUt5WSSS2fCb4YtG1sdoQGui4WlCCz0Pu7d09rxDdLeMOrgM3jYtbV9hGRzr83ZoHdmg2wUH4T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IDRvg6kz; arc=fail smtp.client-ip=40.107.200.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IDRvg6kz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dzl/WTZUnJ0ORiWCSdHHD6FnIbcMgbQdZkbYqRBP49iwiU0gv7YjPM+zMbv1RO474QoluWgf7OgOPq8NVRBJZKsBIL+bDprB3qBuPlCwYFAYrWYoJoUiSy1smg2ecZ/2tFnALSrYo5jMJogwsQ8hCO+wzlk3TR4sWRdx+20hrptPDVAz+yBUgC3JJXDgxGyBsvJ0fa+zsEZdqpaYEKKff+tpirglfXnexAhe8jX+4Bt+sOdixLm/y3iNvxXIxunvaxHiIygOLUhj3kuKWlbp2iBK8vE5DT4iRkCGKElP0Q14j2I3sNCtw0soRfp8WqebeURKP4Njyn/p3qneLUZyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++08c1ql0Blt0bqif1ER69Ul0Kf4HhzSPYIbZ/IYdPA=;
 b=tQxlh6ruYIuEeZuNvMQqRTy3xVg0OjYa97esZevtx++LBGBM6ZD0g8vqUKxVxN6FCaZioPl9quNtc6bf4lDfulBAeYCCSc+LLdl4ovCswVYLUssiAlZ0WiS/HoOZrbYMS6TnIb76mEoRG+pIpyv8wAXUZGtWe28OhBsulnLa7CeibLUHBfGWephpcvBYFN+usLCMBvhkqKxXSJSiEUMuR0S2hzrDUikVGPLqw0cDHqop/EBMZjFGptyCaSWvDN0e165K4lP45PViqtfFWn/YsqcyebnLXobuKWO1ao36J1eRMJvLvFxk/F/xvfl8QwWZGviacZauRXrGOZO0m1ktzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++08c1ql0Blt0bqif1ER69Ul0Kf4HhzSPYIbZ/IYdPA=;
 b=IDRvg6kzXvHSl8VRSfbSzeYB9Yszs25ZKtWgSd4xBhBgP2Gbm9lj6T3x3JYuq0Ow7HHzopW0hYIWPcdjjK6ijKI8H9+0Qxw2uFck9NSRGwrh3If2JU5s02o5d25s0IrbIMsypBhpMUVMomOungq1DnYVh/95SmlbTVklmXDmR3vD0dmowRswpsElVdIsZxRFLqeAFCr35aub33VZ2K+yFcNZxjduYGxf+e4HR/2pn7Kx700VJyt85dvtmaxBl33E89JlyDFNmfk15ww1hOPSGOZ1zsqA62ocUe4UVGtYCxOIzAz/FRFlgTVkr6WPfuvJ1dCOptlI/r4QkjGiTmsYjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 10:13:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 10:13:23 +0000
Date: Thu, 7 May 2026 12:13:19 +0200
From: Andrea Righi <arighi@nvidia.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: John Stultz <jstultz@google.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Koba Ko <kobak@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] sched/core: Skip migration disabled tasks in proxy
 execution
Message-ID: <afxlvypRoa0qCHhs@gpd4>
References: <20260506174639.535232-1-arighi@nvidia.com>
 <20260506174639.535232-2-arighi@nvidia.com>
 <CANDhNCoKyJGZApptPo=7S-Cdu1FqPPr_Wr9djV1-NzjfVnbkgw@mail.gmail.com>
 <427e64df-2d3c-47a5-925f-ef9a751f1ca3@amd.com>
 <afwxsJiNJcNQrcHN@gpd4>
 <bfb4c8ca-e155-41b8-ab00-1607d9823051@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfb4c8ca-e155-41b8-ab00-1607d9823051@amd.com>
X-ClientProxiedBy: MI2PEPF00000B7B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::411) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 21700a0f-110c-4d96-e8d3-08deac214567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|13003099007|22082099003|18002099003|56012099003|7136999003;
X-Microsoft-Antispam-Message-Info:
	d1NENmP5/r6ZASpSHhbOW2Wd/7fVSpBzHOYXCoePat7/Ed/q+up1GCf+AdzPFoQTTa0/pm3qu9gC68/vTbzvrghlLjhANUZP2pNtULSeScOo+8tFXHUflswwlobQeipLQ7mW3BJ3ZNNJ0z4u6puBu8OT4J0/2Mx7/rLf7baibPUgTVKDj+M0RAJWOP61m3Mwalz4NowbjH9K+3SI4nCjOlJG4+rV1iSgE3OpZfxV30JpRJKX0aRfe9ExyLkLwNeksZcyO/2IngLKjZFD8VUVE7a1tn5X/IBn2BSMnrFnkyAs4+DXMpRyNiuJ79Bvrp9BQ+oyPkI5kyyuZSrRLm98vbEWIwxqwPtq/vZ4YFNiA9iYfhBi/Uf0XZgvez+B/rAIiakDA6CKhvTlSa2DfU0b03+IpZXQakDz/abS4fMMg0szVcb2tp41wXszGA7FQcbKWv4AVQ7IDGKnOZlm5VP8AWpfKGen+352qcmhk4GP1Igbv/sntURzQTm42hxJMsopC74nJkL8iTPs0fTFvhGp4+D8eg6Z0I74ff0co6W3JZVlxdjXv/DOA7/aJpgVYUSKpxHCtD06qWFi/D9S2ksI2dx6qYned2qQHthOhR/D9AF1RSoQUqh/8L/ge9od7P0JYiVfxAuzkAXEBwRuuGG5fRl8Csh8K2eQSM1tfeBsay4QROK/TjKKtyHOtPIRHwx0cITOGf2q/nbhI1+UolsqcA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007)(22082099003)(18002099003)(56012099003)(7136999003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kepi7fX95ptjZOpbN2K0g6Sfz9mxflml4Eux/1bt2lh/x/o5OGWZnPtIfjjt?=
 =?us-ascii?Q?5eA2xPlTZ9k0TTmvF8b+21arABhrbeNcWiYYSY96NuoeEd+qVKo1knIkmVcP?=
 =?us-ascii?Q?GhgA+w/Ub98/SKwQwmHPxTYi027KtH0bZiQkjUT8hyYxvcThBQg7mrptjxmX?=
 =?us-ascii?Q?TVBx2Q0c7etp1zqwfHbpsJQS3lIbYPIqEcLZJwMkQTtrOtkfFuW2XYm/RXWW?=
 =?us-ascii?Q?RSvJUirHusUBWfBD7lY4o4JE3vITHwF8WmCFckrrCAtk6m3zSGQZdmdhizWW?=
 =?us-ascii?Q?TpScGBvJJnQrmC8fG6EZ6O+fLyLotlZZXcS4SkPxc3Qjc05W3D1Plo0e2J3K?=
 =?us-ascii?Q?RQyUhatzkSw2wDs6diN2Z81LL/9gEypTQBfVKm3cvrJjA+Sre44udwbufsnh?=
 =?us-ascii?Q?8E+yzXCXxiN139OgtcgBZmfiauhS+0eLjQg8OlvgESQaDOxN7W0Eo/m7cg11?=
 =?us-ascii?Q?7gXeKhxjKvVP8VmGFVF23ZNvkZh5QSFEuO2U9ZDMWXSvJj6Zt2y8ctSAsxoS?=
 =?us-ascii?Q?GUj9hm3BJ13wr70nMV29cLFcjCjPzcgxAGqXrbp1CdRz9c/prLauq9DuekTg?=
 =?us-ascii?Q?cGe8XoZ1XdumiWefwHgxGS0wCIPpcI62mfq5cq3NfBBrkfcod8CyLppoLTFb?=
 =?us-ascii?Q?etNdsEHSpypV6m3eQes95Wc9ZLh7fh+3EMks3UTy+gZzWgsx4mAYZ3XWHxJ2?=
 =?us-ascii?Q?LIcQBpTlNbNuZXP8qIqfJMcwUcM7GaHv3XHBdDlRFyOZOPAQuxk1/rs1dMV8?=
 =?us-ascii?Q?wytj61BYiaEBEeii1h31RGRjgIoKRnrPI/E3SaJBVcSL9moyQcm7xLh0scXg?=
 =?us-ascii?Q?cXSmJV571F/g76KN6tpIHdTtDZfDeC0n4I05VgWroq3a4c8YoYdqNBSg9RfG?=
 =?us-ascii?Q?DUBGA08ehMuvaiOpXzpEvGKnN5zqnBO5UvuqSfufSCdy80JZulF8e8B4k/zX?=
 =?us-ascii?Q?oJSRIbAdS/bLm6CMqDGv6r4IyfdF18Q+OHVnQRkP+xr+ulwaCga1dh4rSQYD?=
 =?us-ascii?Q?iVteH1u0qi7hC25jwG9ZfObWQCTEtI970zh279Lu236rxwFBKiF8sTX+r9X0?=
 =?us-ascii?Q?jyaO6RgcGgCFv4LLwXpBcRiXdwL+nSPNurX0PXNHRYmBtvZRUQHuvSj/ytwG?=
 =?us-ascii?Q?o9TOLeH91hNJhj7kooOn9C00GOpII5UVcHs2DA9en1jy/huYkC8VsDJXAdg/?=
 =?us-ascii?Q?VZZ/7U+ptRi0TFm+i0Dt53/lsxCaydhGV/mRpdTnzGYaBM0kx+khXDrTJ6PG?=
 =?us-ascii?Q?VAs7j1m+WE11Rg5xWgkpIJAqWSMLrp0VATLoDGl2LTLNpIL5WEKaXOhYtHxI?=
 =?us-ascii?Q?9SmTh55hbopvPq8m6O5MwKe/fvVBoFV8RJiE+11SsNMZyxVa3OJXkcUStuic?=
 =?us-ascii?Q?9KWWZ+eDRxWpbyFIxM3RnFfQx55owgPtpAB89rF0KRdmbwZVLVMfDDA95ITN?=
 =?us-ascii?Q?doam/wgAdu4z/XpQBlGizBsbifzyXduZ+MslEEGmeUhvzzHDWDsFLETWZ9Cx?=
 =?us-ascii?Q?cTUKSk4dQaUjoqehs/gPklezHgKV8RM5sOzzLvvQ54qhYmQq47D1/iLPj8xH?=
 =?us-ascii?Q?pJdCtZ6DkqDhJU/bjQNwIkd+DNhdO/kKkwZQiAQdpb9Ib1cUVAna94GtXWF/?=
 =?us-ascii?Q?P/P6GECGQJoggKYIilpG1xHT/NNS9kVVyKTEwctoRYmVDj8wXbZWXXt2kQPK?=
 =?us-ascii?Q?66jw0XVNCAblnrfRdyG6ejrvttECw1UBD1qWMJ1WoFRNJ/bYCfMm/Ec//Vs6?=
 =?us-ascii?Q?vvk7nL5O0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21700a0f-110c-4d96-e8d3-08deac214567
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:13:23.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ggt74WLnQ5JQXcY93CGMzgJQyv/TsDgTZzV+c8xEoogPRGsGHRlyY72MuJdlLSWyFqxncVVLtTu5DeTu9VPwGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412

Hi Prateek,

On Thu, May 07, 2026 at 01:15:22PM +0530, K Prateek Nayak wrote:
> On 5/7/2026 12:01 PM, Andrea Righi wrote:
> > Hi John, Prateek,
> > 
> > On Thu, May 07, 2026 at 09:04:57AM +0530, K Prateek Nayak wrote:
> >> Hello John, Andrea,
> >>
> >> (Full disclaimer: I haven't looked at the entire series)
> >>
> >> On 5/7/2026 2:39 AM, John Stultz wrote:
> >>>> +                       /*
> >>>> +                        * Tasks pinned to a single CPU (per-CPU kthreads via
> >>>> +                        * kthread_bind(), tasks under migrate_disable()) cannot
> >>>> +                        * be moved to @owner_cpu. proxy_migrate_task() uses
> >>>> +                        * __set_task_cpu() which would silently violate the
> >>>> +                        * pinning and leave the task to run on a CPU outside
> >>>> +                        * its cpus_ptr once it is unblocked. Stay on this CPU
> >>>> +                        * via force_return; the owner running elsewhere will
> >>>> +                        * wake @p back up when the mutex becomes available.
> >>>> +                        */
> >>>> +                       if (p->nr_cpus_allowed == 1 || is_migration_disabled(p))
> >>>> +                               goto force_return;
> >>>>                         goto migrate_task;
> >>>
> >>> Hey Andrea!
> >>>   I'm excited to see this series! Thanks for your efforts here!
> >>>
> >>> Though I'm a bit confused on this patch.  I see the patch changes it
> >>> so we don't proxy-migrate pinned/migration-disabled patches, but I'm
> >>> not sure I understand why.
> >>>
> >>> We only proxy-migrate blocked_on tasks, which don't run on the cpu
> >>> they are migrated to (they are only migrated to be used as a donor).
> >>> That's why we have the proxy_force_return() function to return-migrate
> >>> them back when they do become runnable.
> >>
> >> I agree this shouldn't be a problem from core perspective but there
> >> are some interesting sched-ext interactions possible. More on that
> >> below:
> > 
> > So, I included this patch, because in a previous version of this series it was
> > preventing a "SCX_DSQ_LOCAL[_ON] cannot move migration disabled task" error.
> > 
> > However, I tried again this series without this and everything seems to work. I
> > guess this was fixed by "sched/ext: Avoid migrating blocked tasks with proxy
> > execution", that was not present in my previous early implementation. So, let's
> > ignore this for now...
> > 
> >>
> >>>
> >>> Could you provide some more details about what motivated this change
> >>> (ie: how you tripped a problem that it resolved?).
> >>
> >> I think ops.enqueue() always assumes that the task being enqueued is
> >> runnable on the task_cpu() and when the the sched-ext layer tries to
> >> dispatch this task to local DSQ, the ext core complains and marks
> >> the sched-ext scheduler as buggy.
> > 
> > Correct that ops.enqueue() assumes that the task being enqueued is runnable on
> > task_cpu(), but this should still be true even when the donor is migrated:
> > proxy-exec should only migrate the donor to the owner's CPU when the placement
> > is allowed.
> 
> Not really - it'll migrate the task to donor's CPU even if it is outside
> the task's affinity with the reasoning that the donor will never run
> there - it only exists on the runqueue to donate it's time to the lock
> owner.
> 
> But if you mean runnable in the sense it hasn't blocked then yes it is
> SCX_TASK_QUEUED + set_task_runnable().

proxy-exec can migrate the donor to the owner's rq/DSQ, but it doesn't actually
execute it, it's just there to bump the owner on the same CPU.

Then when the donor returns back home, via proxy_force_return(), we trigger
deactivate_task() -> dequeue_task_scx() and that also unlinks the donor from the
local DSQ. So we shouldn't break affinity.

> >> With sched-ext, even the lock owner's CPU is slightly complicated
> >> since the owner might be associated with a CPU but it is in fact on a
> >> custom DSQ and after moving the donor to owner's CPU, we will need
> >> sched-ext scheduler to guarantee that the owner runs there else
> >> there is no point in doing a proxy.
> > 
> > But a donor is always a running task (by definition), so it can't be on a custom
> > DSQ. Custom DSQs only hold tasks that are in the BPF scheduler's custody,
> > waiting to be dispatched.
> 
> I was thinking more from a proxy migration standpoint - when the donor
> is on a different CPU and the owner is on another one, and the core.c
> bits move the donor to the owner's CPU.

Ah I see what you mean. So you're saying for example: if owner is on CPU1's rq,
but it's also sitting on a global DSQ (that can be consumed by any CPU), we'd
move the donor to CPU1's rq, park it in CPU1's local DSQ, but then the owner can
be consumed by any CPU, because it's in a global DSQ.

However, if I'm not missing anything, I think in this case the core scheduler
should select the donor via pick_next_task(), then proxy-exec can replace it
with the owner, removing it from the global DSQ and run it.

From set_next_task_scx():

 if (p->scx.flags & SCX_TASK_QUEUED) {
      ops_dequeue(rq, p, SCX_DEQ_CORE_SCHED_EXEC);
      dispatch_dequeue(rq, p);
  }

That dispatch_dequeue() removes the owner from whatever DSQ it was on
(global/custom/local), then the owner becomes rq->curr and runs.

> 
> > 
> > The core keeps the donor logically runnable / on_rq and the ext core always
> > parks blocked donors on the built-in local DSQ:
> > 
> > put_prev_task_scx():
> > 	...
> >         if (p->scx.flags & SCX_TASK_QUEUED) {
> > 		set_task_runnable(rq, p);
> > 
> > 		if (task_is_blocked(p)) {
> > 			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
> > 			goto switch_class;
> > 		}
> > 	...
> 
> Ah! This is what I was missing but then, this task gets picked and
> is moved by find_proxy_task() in core.c right?

Yes, that's the intent.

> 
> > 
> >>
> >> scx flow should look something like (please correct me if I'm
> >> wrong):
> >>
> >>      CPU0: donor                    CPU1: owner
> >>      ===========                    ===========
> >>
> >>   /* Donor is retained on rq*/
> >>   put_prev_task_scx()
> >>     ops.stopping()
> >>   ops.dispatch() /* May be skipped if SCX_OPS_ENQ_LAST is not set */
> >>   do_pick_task_scx()
> >>     next = donor;
> >>   find_proxy_task()
> >>     proxy_migrate_task()
> >>       ops.dequeue()
> >>         ======================> /*
> 
> At this point I mean ^
> 
> >>                                  * Moves to owner CPU (May be outside of affinity list)
> >>                                  * ops.enqueue() still happens on CPU0 but I've shown it
> >>                                  * here to depict the context has moved to owner's CPU.
> >>                                  */
> >>                                 ops.enqueue()
> >>                                   scx_bpf_dsq_insert()
> >>                                     /*
> >>                                      * !!! Cannot dispatch to local CPU; Outside affinity !!!
> >>                                      *
> >>                                      * We need to allow local dispatch outside affinity iff:
> >>                                      *
> >>                                      *   p->is_blocked && cpu == task_cpu(p)
> >>                                      *
> >>                                      * Since enqueue_task_scx() hold's the task's rq_lock, the
> >>                                      * is_blocked indicator should be stable during a dispatch.
> >>                                      */
> >>                                 ops.dispatch()
> >>                                 do_pick_task_scx()
> >>                                   set_next_task_scx()
> >>                                     ops.running(donor)
> >>                                 find_proxy_task()
> >>                                   next = owner
> >>                                 /*
> >>                                  * !!! Owner stats running without any notification. !!!
> >>                                  * 
> >>                                  * If owner blocks, dequeue_task_scx() is executed first and
> >>                                  * the sched-ext scheduler sees:
> >>                                  *
> >>                                  *   ops.stopping(owner)
> >>                                  *
> >>                                  * which leads to some asymmetry.
> >>                                  *
> >>                                  * XXX: Below is how I imagine the flow should continue.
> >>                                  */
> >>                                 ops.quiescent(owner) /* Core is taking back control of owner's running */
> >>                                 /* Runs owner */
> >>                                 ops.runnable(owner) /* Core is giving back control to ext layer */
> >>                                 ops.stopping(donor); /* Accounting symmetry for donor */
> > 
> > I think the order of operations should be the following:
> > 
> > ops.runnable(donor)
> >    -> ops.enqueue(donor)
> >    -> donor becomes curr
> >    -> ops.running(donor) /* set_next_task_scx(donor); !task_is_blocked(donor) */
> >    -> donor executes
> >    -> donor blocks on mutex (proxy: stays on_rq; task_is_blocked(donor) true)
> >    -> __schedule()
> >    -> pick_next -> proxy-exec selects owner as next
> >    -> put_prev_task_scx(donor)
> >         -> ops.stopping(donor)
> >         -> dispatch_enqueue(local_dsq) /* blocked donor: ext core parks on local DSQ */
> >    -> set_next_task_scx(owner)
> >         -> ops.running(owner)
> 
> So ext will just switch the context back to owner? But how does this
> happen with the changes in your series?
> 
> Based on my understanding, this happens:
> 
>     -> pick_next -> sced-ext returns donor as next
>     /* prev's context is put back */
>     -> set_next_task_scx(donor)
>       -> ops.running(donor)
> 
>     /* In core.c */
> 
>     /* next = donor */
>     if (next->blocked_on) /* true since we have blocked donor */
>        next = find_proxy_task(); /* Returns owner */
> 
>     /* next = owner; */
>     /* Starts running owner */
> 
> How does ext core swap back the owner context here? Am I missing
> something? find_proxy_task() doesn't call put_prev_set_next_task() so
> I'm at a loss how we get to set_next_task_scx(owner).

The sequence should be the following:

 - pick_next_task(rq, rq->donor, &rf) returns donor (because we parked it on the local DSQ)
 - in __schedule() (still holding rq->lock), proxy sees next->blocked_on and does:
    - next = find_proxy_task(rq, next, &rf);  -> returns owner (or triggers migration / retries)
 - Only after that, __schedule() reaches the point where it performs the switch
   (put_prev_set_next_task(rq, prev, next) via the pick path). At that point,
   next is already the owner, so:
    - put_prev_task_scx(prev=donor) (or whatever prev is)
    - set_next_task_scx(next=owner)

And parking the blocked donor on rq->scx.local_dsq makes it the obvious
candidate for pick_next_task_scx() on that CPU.

So the donor isn't "moved" by find_proxy_task() in the DSQ sense, rather:
  - SCX picks the donor token
  - proxy-exec replaces the picked task with the lock owner (or triggers
    migration/return paths)

> 
> >    -> donor runs as rq->donor, owner runs as rq->curr /* execution / accounting split */
> > 
> >   Later, when the owner is switched away (another schedule)
> > 
> >   ... owner running ...
> >    -> __schedule() / switch away from owner
> >    -> put_prev_task_scx(owner)
> >         -> ops.stopping(owner) /* if QUEUED && IS_RUNNING */
> >    -> set_next_task_scx() /* whoever is next */
> > 
> >    Later, mutex is released - donor can run as itself again
> > 
> >    -> mutex released / donor unblocked (!task_is_blocked(donor))
> >    -> donor selected as next /* becomes rq->curr as donor; not superseded by proxy */
> >    -> ops.running(donor) /* set_next_task_scx(donor); QUEUED && !task_is_blocked(donor) */
> >    -> donor executes as rq->curr
> > 
> >> I think dequeue_task_scx() should see task_current_donor() before
> >> calling ops.stopping() else we get some asymmetry. The donor will
> >> anyways be placed back via put_prev_task_scx() and since it hasn't run,
> >> it cannot block itself and there should be no dependency on
> >> dequeue_task_scx() for donors.
> > 
> > The ops.running/stopping() pair should be always enforced by
> > SCX_TASK_IS_RUNNING, so we either see a pair of them or none. So in theory,
> > there shouldn't be any asymmetry.
> > 
> >>
> >> With the quiescent() + runnable() scheme, the sched-ext schedulers need
> >> to be made aware that task can go quiescent() and then back to
> >> runnable() while being SCX_TASK_QUEUED or the ext core has to spoof a
> >> full:
> >>
> >>   dequeue(SLEEP) -> quiescent() -> /* Run owner */ -> runnable() -> select_cpu() -> enqueue()
> >>
> >> Also since the mutex owner can block, the sched-ext scheduler needs to
> >> be aware of the fact that it can get a dequeue() -> quiescent()
> >> without having stopping() in between if we plan to keep
> >> symmetry.
> > 
> > We can see ops.dequeue() -> ops.quiescent() without ops.stopping() even without
> > proxy-exec: if a task becomes runnable and then it's moved to a different sched
> > class, the BPF scheduler can see ops.runnable/quiescent() without
> > ops.running/stopping().
> 
> Ack!
> 
> > 
> > As long as ops.runnable/quiescent() and ops.running/stopping() are symmetric I
> > think we're fine.
> 
> I think it is mostly symmetric other than for that one scenario I'm
> confused about above.

Hope it's clearer now, assuming I didn't miss anything or make it even more
confusing. :)

I'm still not fully convinced about the migration-disabled task scenarios, but
so far I can't find any holes.

Thanks,
-Andrea
