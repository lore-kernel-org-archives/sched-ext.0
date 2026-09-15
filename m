Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19564D09F4
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504260; cv=fail; b=l6bXwovHAb41yc7VboTodzrT8ydtqYT7Mqmy7HhbRMJpKj3m1omZpkbeSNypqUFp/LbKX7iA930XlM1S3oJQwnpPPs5EDk7olRGeqrtbJFVAY6QTuVF082N51bj3cxqXbZQ8d8vwGdwf6nbtT2DIjCwuXEYOWaSCYzqTjmnm9r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504260; c=relaxed/simple;
	bh=rsCb9TBPCO10Da23mZrQAya7rDgg8dvQTNT6bs16diM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vl2uBAlwMHdtHH9KOYxMcGg6M+ViRjBWhzyi0szW2BpSFt0CzqwO3yYQY0+EBjIEkxEAwgrD7n4igJ48mSkihOr+8OYiT3k0xMqnoTjAMmeF9gYtgwkQXnBWdTXnuXNEk5VGcAQYdHzG2t+vxATfCBDo5OAihEt+8RsYGCMjer4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F24j/xbz; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F24j/xbz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKIejyMVvT1BxpLB8Nym+KvjiqEoOyBXWjGDOJTFYiytYpzI5gPMxS3s+SBBsWecY21JpReUNRPTw/crUANYy6OL1azhnLUcd3aczZTLfSDW7pAOh9H7JRyyW8YsbAZdERddomHj7MYmzB2AfOiQ1/uP4ZfWdcPBmsGsPijbOVPHb/rkJF+3RZ0IhWC+0+oa1AjgIPx7hH/b5Bk3zg6BwJcxdw52gBnz6Ol/7W4P2n5+ECX1FUW8JhE/Zt3FK7keM6D4hZo/Mf0NUhTBmG1qaJ0SyuI2DZqqvSkTb4MPQX7c/MOYwigB4kTkk5xO7XFVYv0jn1q/IEXfkq5vzG4jOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKjQY06pTPvXzHLW8KOi0ZNU053d+WoBeEFhDusesVc=;
 b=ZtQ7A8gzl5sEC6fjHDA+8UECJm4yi/Ws+jOTWJnDi/UvrCgrwaohF3EVQIE3hPUxbsLvc9AIIJqoFovMDhFdww7URpHRk4NSdNrU6Gyi4a0MWnxURGqjkSLPWf7FzmS4RSmNfMx1qTw3fDDVXNcB/ONUqHMSbnorvZ0GlihTJy6ZVqwzRAmDNALHIpp58hgm301JXTpzbH5fGFXNDnbm3pvsjTwVWbbuI+PkwAP/hDcgF8YT5RngtOJp24a4cJ3rz3ZAUWXrs039wQTipvetmsprYfi4qOabv9/Kh6id2kqzrN3SQubM02wbKVddNkkvWlXGN24OHVg/oBNb6Qojrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKjQY06pTPvXzHLW8KOi0ZNU053d+WoBeEFhDusesVc=;
 b=F24j/xbzybEdPyR/bwhajqR35rgPAAY+8lAQwJK0GOK694OkHznUhMPI2u420RgXiBTxNv6gT2RFfPGZysmEbT1cuKP4sj5ao1gRg4E76MrIqcqD9FHoSjzbMmYPIwkMafthXwq0BtyuHWN2ccJtAEG2d4Y4+SumdtWRA66hNAlLEgnhUGOkj6YERDZunLZXVKaSCwkrZPvJcHsemMmBm3LGIAFqyhgcMu/H7pDTnTP6fOhr6m3Ocf3icU/6KDSvNvusYeIxHS3AArIkJMVQg64o4mmeBgNgVSqXX/0aQv3DfnVkQnf6vX/FuMKGpIJIy4FFEtfgORGkOgc7QPuyuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 20:30:47 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 20:30:47 +0000
Date: Tue, 15 Sep 2026 22:30:38 +0200
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
Subject: Re: [PATCH 07/18] sched: Add sched_ext hooks for proxy execution
Message-ID: <aqmq7iahwiBR34zU@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-8-arighi@nvidia.com>
 <20260910103818.GH4120091@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910103818.GH4120091@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: d96f2cf4-fb23-4205-9233-08df13683926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|4143699003|56012099006|6133799003|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	CtBCnJUZ3F0x9LDThy6Aan+CuHtKyD/2rLDWdF9gZmYsi7WCmlNPxMGEVivKYDEnEp/ICa9qwtkSalEA4TagehseKHsyz/O/gLvXF+S8Ea9729FMNjYTMhGt6vGpbZy306fWHz5aCQtO0xjRA+R3ZnRUHRqmd32YZdUDURMG7hKJfd0fn1V7qDKaU5Ljm/3PR9gWI3jDQ6D8+dHQNczTlr9WDyTOIxWCOfq57Wxd3zWhHNZF2322WRJx2Mr+vBx01EhDe6IDwNkj296hQQF/vDMnLNXsxayzaO3IhGbcKpqR23/X2Dk0HtXC4PK30R72SiJ571I9C3TVTaOXrv/zLgRC+Mmp7VYkZRG1n/jzyDXxBZcK/qoU/B9aSPm+Yghl1UmXGmnPuvoiS8YDCaT+MAoL6EAVEXpp033y+mOQAhmrqssDQkEI5H1eh+909qjcVmF9SToFnHzrBUW3LZmJnCnMWNnEOR9/XYD3gM49m/uhyk7ACyXZKQMNzOfiJ5ao+vS+H6WUSEwVdB85VK87oEEYr52b7C0WjitMUqG/Du+esvF4t+91ZjqXf0jKxk6jPrHFl/j0RGmykM2hvxu8OLO62XU51/Me15Q8UrcfPI9EozzpjyjFWv0hKQVRlc005nE4pnd2Nv4b3UuixtL7u6FiewHp73kfcstVCZmSl9U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(4143699003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BWDNHLxAmDcwxD8MvO/0s0fsj2HDlcT5El44mHt+We99raPh/9FsGFhzbmrx?=
 =?us-ascii?Q?ijMNaOG5HQjMsxAC8qc63wiNKwnkl1F/9w3KdaOTiDDHPvBfYJeNjb6+Mhda?=
 =?us-ascii?Q?w6jfXEaY/YqNiQoVB2/s2qfXdQTSBwVsG6yaiIN+Vd8NvxO+U1JxXn670bDz?=
 =?us-ascii?Q?yavWGcWeBLdSZ4VKk9CYCM2K5vuhTeGvIFaDE/HqoZ7KmyL/0clY2wBEVzOG?=
 =?us-ascii?Q?CGaewkL7TrN4VHjdE8iYF/pgLmsyMRJxnddPSLcTFhwVfiMDL27D3aSS83t8?=
 =?us-ascii?Q?whjVDh/ao5I+0Fh4t6JILJUxaTq+tQUKgmF+m2RooyID/Xk4DT4LaDAYgA7X?=
 =?us-ascii?Q?MafS0szgM2Mj0fXAXWhIK9AqyhGvGzjYYJUR9rm9EDfqtBueK/zOb7RmJ0nD?=
 =?us-ascii?Q?3E3xZ8P+I0Uoce/GmfPbe0Vak1EdnX88mbOFf1vDfSQZltAs4E6BwBpUkBTG?=
 =?us-ascii?Q?pnjKAJEU7RP2+a9uSEaRtmPqdKu1CpSYzOJdS7BsrcXlznBS6fWXmAntHNfx?=
 =?us-ascii?Q?vvaRMrMIb12DqGxA5g2d03YsTI+GKuFEzvp2fAEMpDJhuAMWvzasUV+7UZ5S?=
 =?us-ascii?Q?VbpntFVvAjOMpZJwjupNtqGXpdGHVcijuz5eLeuQep+w6PO8S1YsoeG36o6Q?=
 =?us-ascii?Q?T+kvwh4wX08hLmrUkx3QxXql6brzcE53Wt+Tf65pOYzp6FG4oBI2Tw4FIYzD?=
 =?us-ascii?Q?sLPnyivZqXsCgkncVi7oXgHmPQwTxqYL3kgLqGHN5fbFF76v3E8wAWQeDu9j?=
 =?us-ascii?Q?rmCF/O21PGhA87ivzgcUCP/5PldPY9qzrYHLSDan6bIN2aE7NOG28kt29vX5?=
 =?us-ascii?Q?VjOtbIVnhPDjQ0oXTyia54barF6m2U0RDCCVH2aIt7txD8drMSW3auqBVk9f?=
 =?us-ascii?Q?AR7W/3nmq/xBbmVdZkyJc+fJcQnxYWCosPH9MYZul40LvJWlSVYdWeRksHdb?=
 =?us-ascii?Q?Z5ePohjn/RHnr8pPKPahVEND/WJQEfjdO5gSvSHkvyaQ9q0BtPnLdnsNyend?=
 =?us-ascii?Q?Bp+P84KiX0pT0Ey3Ly3kWCVb0+IcdmF050/rGd0+xLwGXnSTHHP+2jOUXil+?=
 =?us-ascii?Q?knpNrkV+CpBcPorRgsj9AVnqh6XNmML/ESUhTaHPZ0LsBeKo4OEo/tmmbkxN?=
 =?us-ascii?Q?H4wp7wtn7KVgsRzZOzCnYfOlR1uCg4kjYQ9/5QcKM8auPDWLouvmuY9tDkzz?=
 =?us-ascii?Q?5/Y35arIJJPBfWrZRovI+f0qJLwRSTBpTSZP28BtZe0a5IJOEyxD2V+STrP6?=
 =?us-ascii?Q?+hzZqYSW2f+t0l1mnldONxgVKKOX7U2z/J79vaB3RvWC/6A7CNP0yet7wlNq?=
 =?us-ascii?Q?sqLh/vMmDIpTqAsfFBZz3rvkdA7E1hNOe7e7GhxXnI3cukk5S7wsiXjWnuS3?=
 =?us-ascii?Q?WqQHp4L3pio1ma7ULZrcNp8lYCZbaaGqzzIxYui9zs9X+dSCoD3vayYEpTNf?=
 =?us-ascii?Q?b1nAVDq15Xk469QQPNdSVpUxkMdGIe03HKazJzVUxMiaRVJg3y3JkLvxyE/C?=
 =?us-ascii?Q?n2tZVV5rnFQ+s2OfRrn/5R+6YHcfxB3zk9UEfSu50//c+wW1u3iCkXGOINcg?=
 =?us-ascii?Q?Vg3Ug2YVtHVfjWikyZ55OBxyAHYEQNXt8SrkVf7UafxrpqgqlnLPkG5z0TKD?=
 =?us-ascii?Q?qKQBXFqn2J/Mc5PrYXqssvdcaOL3Hr3yhAbffPld2AKJENq69RrOvWz4hEK3?=
 =?us-ascii?Q?htxf/hTsGaRPPsdMdyLfUx2RSZNoBEkGKUgKk/+gVVL00xDfddGk5+vJq59Y?=
 =?us-ascii?Q?I2iWtE2iAw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96f2cf4-fb23-4205-9233-08df13683926
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 20:30:46.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUs0k4Q3mW5/UHa99uGQptkr3M6z0oZ+HQrHqyp69T2VLXyrtyf9+q+8oIgoOdijytYkHoCC3wFrfwyLcr857A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416

On Thu, Sep 10, 2026 at 12:38:18PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 31, 2026 at 03:42:17PM +0200, Andrea Righi wrote:
> > Proxy execution splits the scheduling context (the donor) from the
> > execution context (the lock owner). sched_ext needs to observe that
> > split at three points in __schedule():
> > 
> >  - whether a blocked EXT task can be retained on the runqueue as a
> >    donor,
> >  - when a donor's scheduling context starts driving a lock owner,
> >  - once proxy resolution has settled for the current pick.
> > 
> > Introduce scx_allow_proxy_exec(), scx_proxy_donor_start() and
> > scx_proxy_resolved(), and add their call sites in __schedule(). The
> > implementations are empty here and are filled in by the sched_ext
> > changes that follow, so that all the sched core changes needed by proxy
> > execution stay together in the preparatory patches.
> > 
> > SCHED_PROXY_EXEC still depends on !SCHED_CLASS_EXT, so the new hooks are
> > inert: they are compiled out with CONFIG_SCHED_CLASS_EXT=n and
> > unreachable otherwise.
> > 
> > This is a preparatory change to support proxy execution with sched_ext.
> > No functional change.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/core.c    | 12 +++++++-----
> >  kernel/sched/ext/ext.c | 13 +++++++++++++
> >  kernel/sched/ext/ext.h |  6 ++++++
> >  3 files changed, 26 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index bb79fcfa21cd2..d578dd635f2eb 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7217,13 +7217,12 @@ static void __sched notrace __schedule(int sched_mode)
> >  		}
> >  	} else if (!preempt && prev_state) {
> >  		/*
> > -		 * We pass task_is_blocked() as the should_block arg
> > -		 * in order to keep mutex-blocked tasks on the runqueue
> > -		 * for slection with proxy-exec (without proxy-exec
> > -		 * task_is_blocked() will always be false).
> > +		 * Keep mutex-blocked tasks on the runqueue for proxy execution
> > +		 * only when their scheduling class allows it. Without proxy
> > +		 * execution, task_is_blocked() always returns false.
> >  		 */
> >  		try_to_block_task(rq, prev, &prev_state,
> > -				  !task_is_blocked(prev));
> > +				  !task_is_blocked(prev) || !scx_allow_proxy_exec(prev));
> >  		switch_count = &prev->nvcsw;
> >  	}
> >  
> > @@ -7244,6 +7243,7 @@ static void __sched notrace __schedule(int sched_mode)
> >  			}
> >  			if (next == rq->idle) {
> >  				zap_balance_callbacks(rq);
> > +				scx_proxy_resolved(rq);
> >  				goto keep_resched;
> >  			}
> >  		}
> > @@ -7264,6 +7264,8 @@ static void __sched notrace __schedule(int sched_mode)
> >  			donor->sched_class->put_prev_task(rq, donor, donor);
> >  			donor->sched_class->set_next_task(rq, donor, true);
> >  		}
> > +		scx_proxy_donor_start(rq);
> > +		scx_proxy_resolved(rq);
> >  	} else {
> >  		rq_set_donor(rq, next);
> >  	}
> 
> Can you expand on the need for scx_proxy_resolved() ? I understand the
> other two, but this one I'm struggling with a bit.

Yeah and the name is a poor choice, it should renamed
scx_proxy_reenqueue_retry() or something similar.

It's the retry point for a task that sched_ext couldn't move while processing a
dispatch from a remote DSQ (used later in the series).

When sched_ext consumes a task dispatched to a CPU other than the one whose rq
currently owns it, it may find (after locking the task's source rq) that proxy
exec has made the task either the physical current task or the active donor. It
can't migrate the task in that state, so it parks the task on the source rq's
reject DSQ.

If the deferred reject-DSQ drain runs while the task is still current or
donating, the task must remain parked. Retrying immediately could spin until the
proxy relationship changes. The hook provides the notification that proxy
selection has run again, allowing sched_ext to schedule another deferred drain
after the current context switch.

I couldn't find an existing event that covers this transition without
periodically retrying the reject-DSQ drain. Is there a better place to trigger
this retry?

Thanks,
-Andrea
