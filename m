Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E63B7752
	for <sched-ext@lists.linux.dev>; Mon, 17 Aug 2026 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950934; cv=fail; b=DIAItbD32gVjW0/EhbTgz9V1XH3raKrzhkbUklEOZLmqrqlrvdmrejAirIDky12a7fou/hqLB+qJqOL2gUrEzYKHtZCHLwEIkYbJ34yOzasF6w4uTdeS7gDWo2oMgaqtpnYYkHXi40CoJPYjQNV41F6Ab5FPzdhCHlHIJEUJNwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950934; c=relaxed/simple;
	bh=ukcr1g6Nb+r8uZ4CyxYhRhSzU2DztdJVgo+9YFPGn6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MsII7Xvpc2wqp8KEA6ksRL69xHngo2y520rOZIu4lNDdki1irY8LoA7WTyeEka5uUhaQKg18VBu6H2xbANzhVTREOXNbGm0Fkd+1kDd4xWCFUmXLOtAzHfQwkohzfmkAXda2J2o4nYXnQuWlQ6zfgeOpaR13gq9qbfaeWF1JgS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cIjhqSXA; arc=fail smtp.client-ip=52.101.57.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cIjhqSXA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ac33I6lrNs9UkniX2yDXgwKDlcD6mO8WygOn6LclufQRNQKEGoUvsm+GTDToMAnysyC02umLFeAcvhqXrj+A7IJX0LQxLu24/E3Sz7Yvuo66SlqhSQb9+BuBpIoCm/JhQdHmGaaaczYXl+fVl9PlYF8tQzTcOM+nSKM485OqE85eB+U+IsJfPiH3jGu2Z8AXT0+/FZXEGjfj9TeGHrwawcbYCbAy5UuK7Pm6XCX+GYvBSdCdu+BfBOwb6bqkhW7GgAJ4xuq9AH9mUBHYb3+MiUdy8mu+msoCEB9X5FOWCPnEaD3npvpu8+wAKFqMVafTx042qICOCGmH38lHuwTQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNvtjGJ+/vAzZS5EJrMDSVHVQpOE0zGxvhRtXFse7Xw=;
 b=KYANhrbq1qGxup8WtbL/C1ire1izmU6ShP9XYAdUv2dSoM5c0QQ8oeS59nRh5Tb+DFidd51YQvCDG7bY0uMJ+OmjAwvIlmN2LKa9+HPkgTrnSBNEHtFVZ/G0LHAAH2P1cvj8BNtd5O7OrCVSR8qAwq+an9BbCJGZIrGagvH3BcQM9KthAYM10QpY9bY5BKSvCGIyQsnltH1jT4nCJz2I1hx3Crl5tm9fc/PqENFl/mFk06cqzEZ7VQ4GqhWYlPFU7e4o0z3ZwfTZRhcGqGbc4GyhJA5o061etd8p+VCt95FtHuITgj7Rgu3CbacbTo4+6wJhTpgqk2o+DKtW5H+M0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNvtjGJ+/vAzZS5EJrMDSVHVQpOE0zGxvhRtXFse7Xw=;
 b=cIjhqSXAKVpXUEQ273aeJ3AUTR9XcejodkcCHsIznDFR15k5808+HhhSBQshWre+pEIObJYrgwN4PRIACRgnvdDELQNMQKu2SpvtNf17OSlhEWq5ct3o5hFnCoW4MQBo+TYddWRcEeox37pJfhfJa0gXJEYkwWK8Fq+PT3j39yAsC4l4Q4+r7ts4zN0uWK9C0ROcjCNa57qw5t+TH88aMp9LCQmMdRx6F27d2WWZYy4mU5KHFA17g17ZVABK/ypyruhWeQ+xnxJXye+HxHolBIVeSa76UlUvt+1by4WRBAF9gf9om93ETEd37HHlzP1DfeucTLeTMK+0rKCC5HfOGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 07:15:25 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:15:25 +0000
Date: Mon, 17 Aug 2026 09:15:22 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] sched_ext: Handle proxy-exec races in remote DSQ
 transfers
Message-ID: <aoK1Ck67oyhysjQD@gpd4>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-13-arighi@nvidia.com>
 <aoJNrhYq_MjO1bDb@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoJNrhYq_MjO1bDb@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c51bbb-5314-4402-3316-08defc2f4f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|7136999003|6133799003|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0+H2g++INQrVUkWxslvgTC/W+id8pnwNCNkczRGEXfj26FE37iXIyBnUo5N7Buojet56CyGbBbRof/aY5aSfNPKf+MRBUIPVpkV0sgAlujiOhZaWrARpwNHniXeIVfooYV9b2YzRtdipx2VO/JFkOu/BB0Vog/eJdfadt/CtdAHkTjoNBbbS2X8qtJ9hVodZO+28sDV+plvPJ1dnWOj0YsOvvIFHh1f/HTYd0iieCvyJkw9Xi+On9alhLFGRYd5VV/qLSa8P8gZw/k5XdOjmP2fQq9idad2UGuxC+jRe/DK16SbJw+QqQQ5q0nvfFY42Rk7l5ArMwJS+g9/AtwCJrK4uyzzNbXfS7FIl7Br7dDrVoz00GAw8r4NHra9gJvoBN8C0Ptu644hUtzD7cJIZWERth++Isyhglaa69OIyK/LXVxvlIf9Gp4QT+wTUu2V9FOiwJegQgdum0RVR4NJF/Qsh/Azn0oqdOmUSviGADtGDnZjzPJSFdZSixSGoGafi54irA4b0CbjbDynNxzes3MYaTlwojsGKDnQjoGDnWllPprYnUwGx7Qc+My4WIqALuvfpQe0ym+8DfacAJ1Yp37XZCzXOFbqlXdHE4I9a8lfYnEGSE8JJ7lQfHE2qLNz4DIqdOf5A+bLSR6WWnSxaauJ/lHnX2rzl3j9+BWkFSMY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(7136999003)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VXVZz8gyrY9QArP0y1ARBhCMMyq4snzOsrGt7w3YKPNv3AhW0VIHFSWMXTkf?=
 =?us-ascii?Q?RkT4KCZr6Me9WKWQpsRNlZrAmf6His5RedKHL8tLZCGPMzAinQEdtQoWaxVS?=
 =?us-ascii?Q?ujfnNBwB8Ot8GzLVH3RsvSBpty20fhwK+eJeCE8Kv9zhitbq+awgzEWIhOKG?=
 =?us-ascii?Q?I86Vb34zjKzpp+xL+w7Ub9glSnh4H6QIMrfWXPr9L8mNPPVi2kVrUHSub5G1?=
 =?us-ascii?Q?OwM3jVGdNWFwTBgXjF9TCjJUZ4EbpRvRPncZsnacdyBYftcqMZSgSQisqmU8?=
 =?us-ascii?Q?7wazQhEBoffEL8pw3cCY4ikVs3QiqgCpNXR60PkgzYg4ecN6d2DSGlDZRTI9?=
 =?us-ascii?Q?gzkZRYTSlm8Q6n31qKYY9pTWAzMbUF1WnGCr2Ni7Qgcw/xjJBa4sMULY4d3w?=
 =?us-ascii?Q?Cv4sXpOtteRXah/atzLzUhZgm48u/f4BucVk1kQgWHANJRRmzpIWi+XlLiLy?=
 =?us-ascii?Q?F8CTzpXXypYzVENuQhq4gvzSuipS/qLCgBF/Lmc91cvJ8++1ddc8QxoDqbt2?=
 =?us-ascii?Q?wevXDZyWHYCZl/Xgzv4kXAj+0KwZVcvvpE12bImY7E29/d1ryo4XgimzJN8O?=
 =?us-ascii?Q?tuZWz99w4uXv38PCdC3vHm5G4tz6mt53srT6Je/Znm8NCum2jeXJMJXXh9Ld?=
 =?us-ascii?Q?1yyu4XR7PNxqAOXcKYBesxKJadWAKaGkiHopux1Ux6tYArsyNybf+FRcLXNT?=
 =?us-ascii?Q?NYLgI8LT98BFtAmGyv7oULCt6PQGr5Vk6GodTjciSv9O6FtD8oB345iV0DK7?=
 =?us-ascii?Q?kQs9uaD252c6uwyZc0UjfaElkB3smgyjLIdzwMuk01RK/JqBhnpzosmFxmmf?=
 =?us-ascii?Q?1R0EMvWAqmmQkZL11erd29lS2NEum8y2kCpBIo6VsSx8M5sYFHYZjUMHwIgV?=
 =?us-ascii?Q?u5BBMZQ7xcdO4xh5WlkjUWz6INs7VqVY9Q5CvELjJ3aF1FZJpniUK1kihRJU?=
 =?us-ascii?Q?ym7hDOd4RuXuJkNoEfwWsyRDJVKY1pRfhp77lPp7p4gHPgBGwQN1cCEw6xp9?=
 =?us-ascii?Q?MxzhLyz4LuoUhpp7NMbws2hri98d1ap6NdWipvaRJyjwnZhPhBOrSE3OCRp1?=
 =?us-ascii?Q?n6dE6bSphEafmBsZLgRrrVTa8Ab2QlxfmCC6q+H3VaFKDZk7OY8sw4EJVjlB?=
 =?us-ascii?Q?uJVDSCxJ1bsr6pS+ey/Sqbuzm34yfBw/g+h8PecFzX/eZL1I3sqvoyejaQnZ?=
 =?us-ascii?Q?0PAGWPK+ycI29BY4pA3DUaVFFhE2Vix/E63jXnNdT0Zc3XbxZsWxCrNJuTU2?=
 =?us-ascii?Q?E5upiczT5gQ0WPg7RHzlVdSKsxvKPPoO/308y1fUnqhfOZhGneso8WOf7s0s?=
 =?us-ascii?Q?doR6YxGbxKpAsU4oQTAW6N9gCuj1swKHK65oajejd3Q1lkbWSS18K2GeaTEN?=
 =?us-ascii?Q?NSHfLGrj7XkqiCRAqc/PSbHN7GKPrEPqENKKatnN1C+sp33zvciupnWis6aJ?=
 =?us-ascii?Q?J1X4fw3bg9GhnOr2WsMr4oRPzye2uela9Z+2v2I3Zce33mn+syBkyKMzwGGg?=
 =?us-ascii?Q?0JIc0Y8z0JVrpzBrjGOncQSqWJc5S2e5lTfns8yuD+eW8SyE0ZQ0gfbgnScE?=
 =?us-ascii?Q?aSR9N/booR3UX7MA74f4nHC5dpTyTiw8M27O0I0hrED21mN+nWbjo/iiVLkS?=
 =?us-ascii?Q?CP8+ga1guSO1vkHPc1VyszPeyGLUf9LZ2O9RfDu4x+Efk7QW40IUR78tb12g?=
 =?us-ascii?Q?R8rN59l1LoCghccV2MJkGe0hRp0epBqycJWpbT40SXy8zLqdD4UDmiG7QkHF?=
 =?us-ascii?Q?XrlIsdMl4w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c51bbb-5314-4402-3316-08defc2f4f07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:15:25.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LicH8gdMXGmY29wN4nVT9e94jLGUbmkNgBdB5pW57Hmh3BiggPAE0/UliEumm2yihoci6xi+avc9XqY3jIe5aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365

Hi Tejun,

On Sun, Aug 16, 2026 at 01:54:22PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sun, Aug 16, 2026 at 07:35:10PM +0200, Andrea Righi wrote:
> > +/*
> > + * Proxy resolution happens before rq->curr is switched. Queue deferred work
> > + * on the rq so that an outgoing proxy owner has cleared on_cpu by the time
> > + * reject_dsq is drained.
> > + */
> 
> This doesn't make sense to me. Deferred operatoins can only execute after
> the scheduling operations are complete no matter when they were queued. I
> can see why you'd need this to kick rejected tasks that can't be queued yet.

You're right, this comment comes from an earlier version where proxy-active
rejects did not schedule an initial deferred drain and the hook was used to
arrange the post-switch drain.

The rejection path has changed to schedule deferred work for every reject, so
queueing it from this hook is not what provides the post-switch ordering.

But the hook is still needed as a retry notification. When the initial drain
runs, the rejected task may still be on_cpu or remain the active donor if the
scheduling operation retained or selected the same proxy execution context. In
that case, scx_reenq_reject() must leave the task parked and record that another
attempt is needed. A later proxy resolution then queues that attempt.

The flag also records the outstanding drain independently of the balance
callback used to schedule it. If proxy re-pick calls zap_balance_callbacks()
before that callback runs, scx_proxy_resolved() uses the flag to queue
replacement deferred work.

I'll rewrite the comment to describe this retry role.

> 
> >  void scx_proxy_resolved(struct rq *rq)
> >  {
> > +	lockdep_assert_rq_held(rq);
> > +
> > +	if (rq->scx.flags & SCX_RQ_PROXY_REENQ)
> > +		schedule_deferred_locked(rq);
> >  }
> >  
> >  void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
> > @@ -1530,12 +1539,17 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
> >  	call_task_dequeue(sch, rq, p, 0);
> >  
> >  	/*
> > -	 * Only local inserts get the wakeup treatment below. Rejects kick the
> > -	 * deferred reenq and rescue parks are paced by the rescue timer.
> > +	 * Only local inserts get the wakeup treatment below. Proxy-active tasks
> > +	 * and rescuees remain parked until their respective resolution paths.
> > +	 * Other rejects can be reenqueued immediately.
> >  	 */
> >  	if (unlikely(dsq->id != SCX_DSQ_LOCAL)) {
> > -		if (dsq->id == SCX_DSQ_REJECT)
> > +		if (dsq->id == SCX_DSQ_REJECT) {
> > +			if ((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) ==
> > +			    SCX_TASK_REENQ_PROXY)
> > +				rq->scx.flags |= SCX_RQ_PROXY_REENQ;
> 
> and if my reading above is correct, this wouldn't be necessary, right?

The flag isn't needed to provide the post-switch ordering, but it is needed to
record that reject_dsq still needs another drain.

scx_reenq_reject() sets it when a proxy-rejected task remains on_cpu or
continues to be the active donor, scx_proxy_resolved() then can use it to queue
another attempt.

It also preserves the outstanding drain if proxy re-pick calls
zap_balance_callbacks() before the initially queued callback runs. In
that case, the task is already parked on reject_dsq, but the flag lets
scx_proxy_resolved() queue replacement deferred work.

> 
> >  			schedule_deferred_locked(rq);
> > +		}
> >  		return;
> >  	}
> >  
> ...
> > +static bool task_proxy_move_active(struct task_struct *p)
> 
> How about task_proxy_running_or_donating()

Ack.

> 
> > +static bool task_move_proxy_raced(struct task_struct *p)
> 
> and task_proxy_unsafe_to_move() instead?

Ack.

> 
> > +/*
> > + * Park a task whose remote transfer raced with proxy execution. Reenqueueing
> > + * from the source rq makes the task's owning scheduler choose its placement
> > + * again and preserves sub-scheduler containment.
> > + */
> > +static void scx_reject_task(struct scx_sched *sch, struct rq *rq,
> > +			    struct task_struct *p, u64 enq_flags)
> 
> and scx_proxy_reject_task().

Ack.

> 
> > +{
> > +	lockdep_assert_rq_held(rq);
> > +	WARN_ON_ONCE((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) &&
> > +		     !(enq_flags & SCX_ENQ_REENQ));
> 
> In the previous patch, is it possible to clear reason before reenqueueing
> it and get rid of overwrite cases or does that quite not work out?

Yes, I think we can get rid of the overwrite cases. There is one constraint,
though: the reason must remain set while ops.enqueue() runs, because BPF reads
it from p->scx.flags.

I'll move the clearing into scx_do_enqueue_task() so that it happens immediately
after ops.enqueue() returns and before resolving any direct dispatch requested
by the callback. A rejection caused by that new placement will then see a clear
reason field and can set its own reason without overwriting the previous one.

For paths which bypass ops.enqueue(), the reason can be cleared before the
kernel placement. With that lifetime enforced in scx_do_enqueue_task(),
scx_finish_reenqueue() and the overwrite handling in the previous patch can go
away.

> 
> > +	p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> > +
> > +	p->scx.holding_cpu = -1;
> > +	p->scx.flags |= SCX_TASK_REENQ_PROXY;
> > +	scx_prepare_dsq_divert(p, &enq_flags);
> > +
> > +	scx_dispatch_enqueue(sch, rq, &rq->scx.reject_dsq, p, 0, 0, enq_flags);
> > +}
> > +
> >  /**
> >   * unlink_dsq_and_switch_rq_lock() - Unlink task and switch to its rq lock
> >   * @p: target task
> > @@ -2596,6 +2667,20 @@ static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
> >  				struct scx_dispatch_q *dsq, struct rq *src_rq)
> >  {
> >  	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
> > +		/*
> > +		 * Proxy execution may have changed @p's running or
> > +		 * migration-disabled state while switching rq locks without
> > +		 * clearing holding_cpu. Park it on the source rq and let its
> > +		 * owning scheduler choose its placement again.
> > +		 */
> > +		if (unlikely(task_move_proxy_raced(p))) {
> > +			p->scx.dsq = NULL;
> > +			scx_reject_task(sch, src_rq, p,
> > +					enq_flags | SCX_ENQ_CLEAR_OPSS);
> 
> No need for line break.

Ack.

> 
> > +			switch_rq_lock(src_rq, this_rq);
> > +			return false;
> > +		}
> > +
> >  		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
> >  		return true;
> >  	} else {
> > @@ -2626,6 +2711,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
> >  					 struct scx_dispatch_q *dst_dsq)
> >  {
> >  	struct rq *src_rq = task_rq(p), *dst_rq;
> > +	bool proxy_raced;
> >  
> >  	BUG_ON(src_dsq->id == SCX_DSQ_LOCAL);
> >  	lockdep_assert_held(&src_dsq->lock);
> > @@ -2633,6 +2719,19 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
> >  
> >  	if (dst_dsq->id == SCX_DSQ_LOCAL) {
> >  		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
> > +		/*
> > +		 * Unlike the rq-lock handoff paths, @src_rq has been locked
> > +		 * throughout this operation. Only active proxy state can race the
> > +		 * move here; let the enforcing check below diagnose an ordinary
> > +		 * migration-disabled task.
> > +		 */
> > +		proxy_raced = src_rq != dst_rq && task_proxy_move_active(p);
> > +		if (unlikely(proxy_raced)) {
> 
> I don't know what bouncing through the local var buys. Out of curiosity, if
> task_move_proxy_raced() is used here, does something break or is it just to
> avoid unnecessary tests?

Yeah, the local variable doesn't buy anything, I'll remove it.

Using task_move_proxy_raced() (aka task_proxy_unsafe_to_move() after the rename)
would change the behavior for an ordinary migration-disabled task. This path
holds src_rq, so that state isn't a lock-handoff race and should still reach
task_can_run_on_remote_rq(..., true), which diagnoses the invalid BPF-directed
migration. Treating it as a proxy rejection instead could hide that error and
cause repeated reenqueues.

> 
> > +			dispatch_dequeue_locked(p, src_dsq);
> > +			raw_spin_unlock(&src_dsq->lock);
> > +			scx_reject_task(sch, src_rq, p, enq_flags);
> > +			return src_rq;
> > +		}
> >  		if (src_rq != dst_rq &&
> >  		    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> >  			dst_dsq = find_global_dsq(sch, task_cpu(p));
> > @@ -2788,7 +2887,9 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
> >  	/* task_rq couldn't have changed if we're still the holding cpu */
> >  	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
> >  	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
> > +		bool proxy_raced = src_rq != dst_rq && task_move_proxy_raced(p);
> >  		bool fallback = false;
> > +
> >  		/*
> >  		 * If @p is staying on the same rq, there's no need to go
> >  		 * through the full deactivate/activate cycle. Optimize by
> > @@ -2798,9 +2899,13 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
> >  			p->scx.holding_cpu = -1;
> >  			scx_dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
> >  					     slice, vtime, enq_flags | SCX_ENQ_APPLY_SLICE);
> > -		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
> > -			p->scx.holding_cpu = -1;
> > +		} else if (unlikely(proxy_raced)) {
> 
> Ditto, I don't know what the bouncing through proxy_raced buysk. Alos, in
> this else clause src_rq != dst_rq is already established.

Ack.

> 
> >  			fallback = true;
> > +			scx_reject_task(sch, src_rq, p, enq_flags);
> > +		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq,
> > +							       true))) {
> 
> No need for line break.

Ack.

> 
> > +			fallback = true;
> > +			p->scx.holding_cpu = -1;
> 
> fallback = true and p->scx.holding_cpu = -1 lines are swapped compared to
> the original code making the diff look a bit confusing.

Ack.

> 
> >  static void scx_reenq_reject(struct rq *rq)
> >  {
> >  	LIST_HEAD(tasks);
> >  	struct task_struct *p, *n;
> > +	bool proxy_pending = false;
> >  
> >  	lockdep_assert_rq_held(rq);
> >  
> > -	if (list_empty(&rq->scx.reject_dsq.list))
> > +	if (list_empty(&rq->scx.reject_dsq.list)) {
> > +		rq->scx.flags &= ~SCX_RQ_PROXY_REENQ;
> >  		return;
> > +	}
> >  
> >  	/*
> > -	 * Move tasks to a private list so a task re-rejected by
> > +	 * Move ready tasks to a private list so a task re-rejected by
> >  	 * scx_do_enqueue_task() below isn't revisited this round.
> >  	 */
> >  	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
> >  		u32 reason = p->scx.flags & SCX_TASK_REENQ_REASON_MASK;
> >  
> > -		/* migration_pending tasks should have bypassed to local DSQ */
> > -		WARN_ON_ONCE(p->migration_pending);
> >  		WARN_ON_ONCE(!reason);
> >  
> > +		/*
> > +		 * The affinity machinery owns placement while a migration is
> > +		 * pending and will dequeue and reactivate @p as necessary. Don't
> > +		 * return it to BPF in the meantime. This isn't a proxy-resolution
> > +		 * state and thus doesn't contribute to @proxy_pending.
> > +		 */
> > +		if (p->migration_pending) {
> > +			WARN_ON_ONCE(reason != SCX_TASK_REENQ_PROXY);
> > +			continue;
> > +		}
> > +
> > +		if (reason == SCX_TASK_REENQ_PROXY &&
> > +		    (task_on_cpu(rq, p) || task_current_donor(rq, p))) {
> > +			proxy_pending = true;
> > +			continue;
> > +		}
> 
> Can you structure the code so that it's:
> 
>         if (proxy_exec_enabled() && reason == SCX_TASK_REENQ_PROXY) {
>                 ...
>         else {
>                 WARN_ON_ONCE(p->migration_pending);
>                 ...
>         }
>

Ack.

> >  		scx_dispatch_dequeue(rq, p);
> >  		p->scx.flags |= reason;
> >  
> >  		list_add_tail(&p->scx.dsq_list.node, &tasks);
> >  	}
> >  
> > +	if (proxy_pending)
> > +		rq->scx.flags |= SCX_RQ_PROXY_REENQ;
> > +	else
> > +		rq->scx.flags &= ~SCX_RQ_PROXY_REENQ;
> 
> Hmm... this looks unconventional. Shouldn't the cosumer of the flag -
> scx_proxy_resolved() - clear it?

Agreed. I'll make scx_proxy_resolved() clear the flag before scheduling the
deferred work.

> 
> > diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> > index 2b2dcde923600..8b0be25cda7d0 100644
> > --- a/kernel/sched/ext/internal.h
> > +++ b/kernel/sched/ext/internal.h
> > @@ -1758,6 +1758,14 @@ enum scx_enq_flags {
> >  	SCX_ENQ_SLICE_DFL	= 1LLU << 62,	/* carried slice is a default refill */
> >  };
> >  
> > +/* Strip priority and carried slice state when diverting from a local DSQ. */
> > +static inline void scx_prepare_dsq_divert(struct task_struct *p, u64 *enq_flags)
> 
> How about scx_divert_strip_flags()?

Ack.

Thanks tons for the review!
-Andrea
