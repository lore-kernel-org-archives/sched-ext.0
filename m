Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AE30B502
	for <sched-ext@lists.linux.dev>; Thu,  7 May 2026 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135485; cv=fail; b=MuBvAWlqPZK043KU2iwQ/FvH+ZSp4cp3ngWcZnT1as6eQbEP03BDaINYqey0z+eO6AblPwYIYo8p27tKw68qJsZHEpqhJy6oGnevZhD39w8vA1eNPO/PjQp4SW9SLQZXH2RHfVXVD3oMqjMWoo47qE2YmZYNs8guYF9yWtY/ujs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135485; c=relaxed/simple;
	bh=is4PnGBW2RwsKtXbMz+H+TyEIgEKNXGkkc/tlu2kePk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RUFMycPoYH3LRXqlYWuWbABJ/fZEp8wxad18Y9fhItA6XiRgy4T4pp24MeCf0nUZH+cLYZFxW+lmcKotXEnOksv876itU/NCzXLl0jJEJKnoS7IWah9UPcUyQAMrcGIbCsXdgGL/rN0pTvJ4jSvWnanKwxx5FkopGCXRignfcho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=djphKGIU; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="djphKGIU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DE4b1BlpZOANTYo1EHFjZ+Mukk7tPuCYYZMmOc7YkDwIvJwaRsBofyYZtQbnRDSEQtV0IVq1ZYGmYrmqWKV0QDXBVNdIaBRIXnI232KAzG3nf/M7QnLSJFlxBbzvgFzQAXVUEWgkWn2EqODYqN9e6LGxLNIw8xOjejiR4lvGSkODFQYArgtIMMCvxIE5jIglPaX/lvJpWY+5XOJ/J7H12BsvbpxMfutD3iKCncAvQIFJmIL7NyLBqA9MqWuJNfv0bckHKwNfODeGrtbHJ+C1o0RlhoNsGEegMFAXqnlt1H7oFbcb/5Ot/WSy5VLiBrBtMzi/bSfhKMS6E3yNQJAGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3k8Y5V/FSJQP5Ow8eQILwJupmNPeBJok3iT4OULEAg=;
 b=CQDjQvTenIrhe9nWugurG1vpdHAq41GKUzPDEvFbGeAq7gXzVFXIYYDWMOivQRzeRF9UaVwcnHpoqLn/rZ+rcHIL2sbbG2SBD3NsH94kpKl0PxnVL/QXHu9QArQgtL2TgiqNlTGh36+SI0Ou+5yjbw9ddeZTQAT70IbbpWkyYgT0BEXoEWlKLMpbYxkIy+5BtIDeM3zyg8IohTDkmNP0Wku3ot9e8PNzLXjs68s0JhM6JJBBcccUlPfteAVyH3LgJvssqjhpLRTB7Z4fTWabcwQmeFXjChEX5PG/c/6hU5qFWQMrOvB/66CSCTwDHVLVqPVylQMkgNBsmQTj7isfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3k8Y5V/FSJQP5Ow8eQILwJupmNPeBJok3iT4OULEAg=;
 b=djphKGIUekYj8TSPN/MFNtsVluuc81E2Q7mdw0tm4MHuy8Y+XoNWjr9DaHdGt64YHaOH+K1bhTc/uxjOJa7e0+fNSK4zLPVcMWzGuNzHxjx5fNW49TAuCDusVo6WjPsc9Dpqv/bXGP4aVnpr+EeCUYm1Tg42IwSYfJigNCM2AdSmzzp2IdGZBG+Seuo0LxYiEaRwOa/Y0dt91ZPexN4JMs7ySGJEUx+SjG1HVWRyVeM+5a6H686rHeqBEfdtm/iLLJ7kwms6pIxqFTzTp1zcJGJJCXzi+IGj2FPF9ffLrH1N9P1LzQyMqoSdKqoIGucd7iMVQdOSty8DYNI8CDa7wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 06:31:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 06:31:18 +0000
Date: Thu, 7 May 2026 08:31:12 +0200
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
Message-ID: <afwxsJiNJcNQrcHN@gpd4>
References: <20260506174639.535232-1-arighi@nvidia.com>
 <20260506174639.535232-2-arighi@nvidia.com>
 <CANDhNCoKyJGZApptPo=7S-Cdu1FqPPr_Wr9djV1-NzjfVnbkgw@mail.gmail.com>
 <427e64df-2d3c-47a5-925f-ef9a751f1ca3@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427e64df-2d3c-47a5-925f-ef9a751f1ca3@amd.com>
X-ClientProxiedBy: DU7P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 895c9d69-0737-47ef-9121-08deac023ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7136999003|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ho/Ucigsp43VV65GasR2v8ADf95yadXXL1O++r/oDU4qrH5ll1cQxuKlbX4YJqZ9EVum+Pmj0CrXMuc+vCIPe/Mj2xVPaLKlzezHOTELfSmyTxS7VEolgQXl51ueOlmBSfVPcSLNVA/P2CbyTnrCa/Vou+3y5xNnFOsYEzfQeVCXXwALn2kxdpFKF6iP8poEiUmtL6e3aliL0+Q7unkcyudwV+PEqHWn/PS9UVd3jsy+2vNXjSaYIRUW/89JvYyG7xuofPESWX0idnJ8GoJB9HqswEH17F5YITaHQ+N/V7FEInZKKSy6D7DBu4hbZl3v0HnGCzA3ibxtbfwbfR6tbpeiUTrTYB5gnQiBTuXAeP0htKfbAw6SgWNd3ZSOZUdakF9+xXjwYt+VtETxR6vAWI9GboNllUhTSZgUWUwvAlQpRRKGZMfJlvUYuGBz4oQHCFl8AErPdgcrh6cDzqIBEM7xu6dI0+fg2mwNXS2l3Sy1J758zd9eWGO2PtcLxwQqwwKzyWkygwb4TGtd1JibM+e6GoBxtc/e3KRW6GGv+YRUdnGJc9rVi6ZBWu+60lWBHD5TyqsMBVDoeR5wB0Ob7yT++7zfC5UPbThEC2Q+SI0Q9yiLg0L1j7CuYjNE2Juei2FB+zrmBjsPkhjT10M+ShFcTefEzmOsHn8Camg38oY8PMyem5ZlsLRQO25WW6vKwfHs3+N0SWGkoeUqPkmjTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7136999003)(56012099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nIIkV3OaBzaEWgyHQY+xzAs+xAawPY/usgFqzX+YwtG77JVOWV7zm4TwLYCu?=
 =?us-ascii?Q?IEIpHaai1jaFSBxITx76YYBadP9i2uZgWk9BnLaaiE1qKp3UCejsLRZ/t3l7?=
 =?us-ascii?Q?//aZr8iqcORVBy2DT4Gixwr4TFbSUtCYllrPN8nFokmEJRoSypgL1MPxOURi?=
 =?us-ascii?Q?VrXmWLZleg3TjHaY6QHz1lWgI54+VoaQTeOk9yfT+fm1890Pt/KvVnb+V5XZ?=
 =?us-ascii?Q?WNH5XFK4Ly4HOML4jHyNwjqcdRqR3YgxinvGE95Ev71fQuAX5uZUfd3KlGbq?=
 =?us-ascii?Q?e1eeBBFXZsqfe2R1JfFT1C/33wf/bt2WhzAKeF9RhKTCTHhi6vjh+8G4jswG?=
 =?us-ascii?Q?tq/UcxelblJm9L5BCgboTMF39VCpRPwSysmBWP9hticaWqX9tzwjliXEZ4zs?=
 =?us-ascii?Q?idX61gyD+Wc3GbqQW9zl3mWATmyCZsYhgkqVME2SROeeCHl3vWUnhe2scRNY?=
 =?us-ascii?Q?j/FicKWsFpzsksfZf91zpeO8HfxRxZjb5TpE3jV7dLfprrLtmFrnd+GU9meu?=
 =?us-ascii?Q?kfVa8A6oH2EvXbBxyjeCHSPepBW5vV54qnP5oTpuQ8s8hfsFZla4oGhFHhye?=
 =?us-ascii?Q?eP1xX4cqMI8dH+NDWLds5pRt8T8qgTZiWfllghMQpIy0R9rvv31/JqujWplv?=
 =?us-ascii?Q?GcvQPaNwmgnTyuNZDRB4cgj4STJEwOEMa6qn1zSi9/+orkunq/sfRmBsCvYA?=
 =?us-ascii?Q?PPhtV09RFLTOM1r2zRuMQxBqW8ZJ3W5iEVokx2b4skuhT6TkAtOwxIIUvPwR?=
 =?us-ascii?Q?ldX03iIDh1+upNCF2hI+r3RTEN3vbYtI5mvg08tsKpMRX7ZOQGyCRID/2oRM?=
 =?us-ascii?Q?y6ENCCDQhboRQxB6F6O4rS5V3PQ0O20UAyY/5dFSS4QAea03q/H9v+iY8QZh?=
 =?us-ascii?Q?G9tsqVtoeKQX34H79KzZuSZbVVpOCfo3vYWBcOY7BYKV+m5z4G0wdn1OjN7L?=
 =?us-ascii?Q?mN/rfba/mtKu+mNC0SN3b9cJuFVd3u/D0WbKxzfD9kLlfWq1tjseYecWaTYX?=
 =?us-ascii?Q?TWSKy/AizhS3y3AXZoD8eSCJrQF14lKgDpfGvMXlE7Q60dCYonMNF4ATvU3W?=
 =?us-ascii?Q?tfCjpxeowA2WLj4pSleMnMtWOsRH0DZ79NwRMZzrOFAGM7C2ecBPw7SwMzDm?=
 =?us-ascii?Q?2sAp04CPWoGkt9qeotCN4AFk17s6IeWx3lKUqak5SJD2aoxg/29d5nQHMXv+?=
 =?us-ascii?Q?88HFaef+d6bKxQEPaU2OLmIXmlNX840vKGrWtet+9n9anx0EKX9ngUAzOBBV?=
 =?us-ascii?Q?zWITP2wuz7vfAc1dN42PcjvJ/8QB0/KCQa2boIOyewPSXB0ld9bgi65FzfKy?=
 =?us-ascii?Q?l65rNCDEKbqsFAKJv4ks1mOZLOIA69tfrKBGIAGEdUNbdt+PG/gLKBW1Qmup?=
 =?us-ascii?Q?PqpoOO7dtDxyFlI2X8XK/bCmIVlejYvYqqsGiEMXMrkDrXOhUpQr4mYZKNcJ?=
 =?us-ascii?Q?kNkssWUeiZAE1UUBzWVuCN620OO4ehvniMbOG+jErsMYZe/vh0DrxlUhuWUE?=
 =?us-ascii?Q?g2vk+tXHmFzy+n/AnKow/F6n+H6hNmiHS+DdU2PX4/iMch5PVdrVXgbi4n3N?=
 =?us-ascii?Q?/g5GyK56Y6k4yTBPuXYSRC8pNCHnOu1+8IHo/sohR3LIUp2TNiODlCPQORN5?=
 =?us-ascii?Q?+tXgwH2V9vSRPdGqGZzzLqKZeYdulUQ/dhFitNo8YFIGmfquBJ3yn3SXmfxE?=
 =?us-ascii?Q?FCrkQZso8jjZnCiovQjtXvuT+pTEi1Q2blj+Zp0pAUOIrslX7ajNAuolyvHS?=
 =?us-ascii?Q?53tdoeORnA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895c9d69-0737-47ef-9121-08deac023ea4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:31:17.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5dKGSBNPQcgZ/X1tSNxn6DcEmjrz6cNg3QPfia6lkn1mfLhf3WFYtJIrsoLVool/ii3z1o8CDaX+e3EfJPpWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727

Hi John, Prateek,

On Thu, May 07, 2026 at 09:04:57AM +0530, K Prateek Nayak wrote:
> Hello John, Andrea,
> 
> (Full disclaimer: I haven't looked at the entire series)
> 
> On 5/7/2026 2:39 AM, John Stultz wrote:
> >> +                       /*
> >> +                        * Tasks pinned to a single CPU (per-CPU kthreads via
> >> +                        * kthread_bind(), tasks under migrate_disable()) cannot
> >> +                        * be moved to @owner_cpu. proxy_migrate_task() uses
> >> +                        * __set_task_cpu() which would silently violate the
> >> +                        * pinning and leave the task to run on a CPU outside
> >> +                        * its cpus_ptr once it is unblocked. Stay on this CPU
> >> +                        * via force_return; the owner running elsewhere will
> >> +                        * wake @p back up when the mutex becomes available.
> >> +                        */
> >> +                       if (p->nr_cpus_allowed == 1 || is_migration_disabled(p))
> >> +                               goto force_return;
> >>                         goto migrate_task;
> > 
> > Hey Andrea!
> >   I'm excited to see this series! Thanks for your efforts here!
> > 
> > Though I'm a bit confused on this patch.  I see the patch changes it
> > so we don't proxy-migrate pinned/migration-disabled patches, but I'm
> > not sure I understand why.
> > 
> > We only proxy-migrate blocked_on tasks, which don't run on the cpu
> > they are migrated to (they are only migrated to be used as a donor).
> > That's why we have the proxy_force_return() function to return-migrate
> > them back when they do become runnable.
> 
> I agree this shouldn't be a problem from core perspective but there
> are some interesting sched-ext interactions possible. More on that
> below:

So, I included this patch, because in a previous version of this series it was
preventing a "SCX_DSQ_LOCAL[_ON] cannot move migration disabled task" error.

However, I tried again this series without this and everything seems to work. I
guess this was fixed by "sched/ext: Avoid migrating blocked tasks with proxy
execution", that was not present in my previous early implementation. So, let's
ignore this for now...

> 
> > 
> > Could you provide some more details about what motivated this change
> > (ie: how you tripped a problem that it resolved?).
> 
> I think ops.enqueue() always assumes that the task being enqueued is
> runnable on the task_cpu() and when the the sched-ext layer tries to
> dispatch this task to local DSQ, the ext core complains and marks
> the sched-ext scheduler as buggy.

Correct that ops.enqueue() assumes that the task being enqueued is runnable on
task_cpu(), but this should still be true even when the donor is migrated:
proxy-exec should only migrate the donor to the owner's CPU when the placement
is allowed.

> 
> With sched-ext, even the lock owner's CPU is slightly complicated
> since the owner might be associated with a CPU but it is in fact on a
> custom DSQ and after moving the donor to owner's CPU, we will need
> sched-ext scheduler to guarantee that the owner runs there else
> there is no point in doing a proxy.

But a donor is always a running task (by definition), so it can't be on a custom
DSQ. Custom DSQs only hold tasks that are in the BPF scheduler's custody,
waiting to be dispatched.

The core keeps the donor logically runnable / on_rq and the ext core always
parks blocked donors on the built-in local DSQ:

put_prev_task_scx():
	...
        if (p->scx.flags & SCX_TASK_QUEUED) {
		set_task_runnable(rq, p);

		if (task_is_blocked(p)) {
			dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
			goto switch_class;
		}
	...

> 
> scx flow should look something like (please correct me if I'm
> wrong):
> 
>      CPU0: donor                    CPU1: owner
>      ===========                    ===========
> 
>   /* Donor is retained on rq*/
>   put_prev_task_scx()
>     ops.stopping()
>   ops.dispatch() /* May be skipped if SCX_OPS_ENQ_LAST is not set */
>   do_pick_task_scx()
>     next = donor;
>   find_proxy_task()
>     proxy_migrate_task()
>       ops.dequeue()
>         ======================> /*
>                                  * Moves to owner CPU (May be outside of affinity list)
>                                  * ops.enqueue() still happens on CPU0 but I've shown it
>                                  * here to depict the context has moved to owner's CPU.
>                                  */
>                                 ops.enqueue()
>                                   scx_bpf_dsq_insert()
>                                     /*
>                                      * !!! Cannot dispatch to local CPU; Outside affinity !!!
>                                      *
>                                      * We need to allow local dispatch outside affinity iff:
>                                      *
>                                      *   p->is_blocked && cpu == task_cpu(p)
>                                      *
>                                      * Since enqueue_task_scx() hold's the task's rq_lock, the
>                                      * is_blocked indicator should be stable during a dispatch.
>                                      */
>                                 ops.dispatch()
>                                 do_pick_task_scx()
>                                   set_next_task_scx()
>                                     ops.running(donor)
>                                 find_proxy_task()
>                                   next = owner
>                                 /*
>                                  * !!! Owner stats running without any notification. !!!
>                                  * 
>                                  * If owner blocks, dequeue_task_scx() is executed first and
>                                  * the sched-ext scheduler sees:
>                                  *
>                                  *   ops.stopping(owner)
>                                  *
>                                  * which leads to some asymmetry.
>                                  *
>                                  * XXX: Below is how I imagine the flow should continue.
>                                  */
>                                 ops.quiescent(owner) /* Core is taking back control of owner's running */
>                                 /* Runs owner */
>                                 ops.runnable(owner) /* Core is giving back control to ext layer */
>                                 ops.stopping(donor); /* Accounting symmetry for donor */

I think the order of operations should be the following:

ops.runnable(donor)
   -> ops.enqueue(donor)
   -> donor becomes curr
   -> ops.running(donor) /* set_next_task_scx(donor); !task_is_blocked(donor) */
   -> donor executes
   -> donor blocks on mutex (proxy: stays on_rq; task_is_blocked(donor) true)
   -> __schedule()
   -> pick_next -> proxy-exec selects owner as next
   -> put_prev_task_scx(donor)
        -> ops.stopping(donor)
        -> dispatch_enqueue(local_dsq) /* blocked donor: ext core parks on local DSQ */
   -> set_next_task_scx(owner)
        -> ops.running(owner)
   -> donor runs as rq->donor, owner runs as rq->curr /* execution / accounting split */

  Later, when the owner is switched away (another schedule)

  ... owner running ...
   -> __schedule() / switch away from owner
   -> put_prev_task_scx(owner)
        -> ops.stopping(owner) /* if QUEUED && IS_RUNNING */
   -> set_next_task_scx() /* whoever is next */

   Later, mutex is released - donor can run as itself again

   -> mutex released / donor unblocked (!task_is_blocked(donor))
   -> donor selected as next /* becomes rq->curr as donor; not superseded by proxy */
   -> ops.running(donor) /* set_next_task_scx(donor); QUEUED && !task_is_blocked(donor) */
   -> donor executes as rq->curr

> I think dequeue_task_scx() should see task_current_donor() before
> calling ops.stopping() else we get some asymmetry. The donor will
> anyways be placed back via put_prev_task_scx() and since it hasn't run,
> it cannot block itself and there should be no dependency on
> dequeue_task_scx() for donors.

The ops.running/stopping() pair should be always enforced by
SCX_TASK_IS_RUNNING, so we either see a pair of them or none. So in theory,
there shouldn't be any asymmetry.

> 
> With the quiescent() + runnable() scheme, the sched-ext schedulers need
> to be made aware that task can go quiescent() and then back to
> runnable() while being SCX_TASK_QUEUED or the ext core has to spoof a
> full:
> 
>   dequeue(SLEEP) -> quiescent() -> /* Run owner */ -> runnable() -> select_cpu() -> enqueue()
> 
> Also since the mutex owner can block, the sched-ext scheduler needs to
> be aware of the fact that it can get a dequeue() -> quiescent()
> without having stopping() in between if we plan to keep
> symmetry.

We can see ops.dequeue() -> ops.quiescent() without ops.stopping() even without
proxy-exec: if a task becomes runnable and then it's moved to a different sched
class, the BPF scheduler can see ops.runnable/quiescent() without
ops.running/stopping().

As long as ops.runnable/quiescent() and ops.running/stopping() are symmetric I
think we're fine.

> 
> There might be more issues there that I'm missing.
> 

Right, I'm still trying to figure out if there's any scenario that can break
some BPF assumptions (kfunc permissions or similar), but considering that the
BPF context is usually associated to task_struct I can't see any potential
violation/breakage at the moment.

Thanks,
-Andrea
