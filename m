Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7630216D;
	Sat, 17 Oct 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253868; cv=fail; b=dMXb5qw/AcSkqsQTbMJZaIZVdAHXu3SxR3H2/GXI9BXHjj0wcDZ5j4eEAfZfeqDlu0QowZCoX6iBwIf8gElGyuqlA7apJJRDnhZ7QzNTQiFfEhfuknR1nmOXPypPXzDv0tchlLEG+mQ/mRwziAOQ57WeD4EI/kzzXKWPawx3RCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253868; c=relaxed/simple;
	bh=i9pR0GLCXa8q2n5s3QFCTJnx+j1Cx9lw5XlFVoQxuw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OZpVgXzKVsfHfyvx0nAK9pDB1rUdc4yybzanc4zvPanCQZLIvsnaIheakFmIGO9Koe7L3sjOt1tu7aK2t8UZ7C1y5wPY7jxuXGNks8lXtIhjA6AiQbh7SQCVLAihO4Jx05HBXx2ACDXPOqG+2mLOjgBauNeMIT/PjQ4W0s6hCKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TvDS2sOp; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TvDS2sOp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOwU5vwLzTtwgxEipP/so9RVYFjg3+JTD+ixqbKZ8HTh6jq+O1f6ZIntb1L2R95VQhHVMlpenr8vTrsgYfGoyg8KHwHgPTUhkmm9z4vV6aFhm/qfJaSuY/7jirP/V2Ax/SIbIaA4uPGsKkBSzCEfsbyZl4NqpGCvKO4JjgsviupENN1gSRzwGxbDHi16NVUeh3MX5WcKMOWoBVDGkmYt99tpmo9drBqB/q+1li7ziGhdDZnubbzoCUGf2Tv+fK+SywcboGnAX+FOKLgXBzv88wfhFYyJ5Sq8YqcKSLVXi8w3JLAJtLOTYdBjXPQsTFTImBO9z9YUSESx5og4Gn5gGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W/Iu8UZg/ynUgc/1DvSb0mPq7ufUDgWUwFV2pur+pk=;
 b=bGJ/Ts/ZN1IupqLWVZ0d33D0nZy6ZN/pFzdVEqQmaEFEMuJus/tSsIS74KEdNluXM9jY8TiiQIYTGx8QRh3XPhn7ceLcnTozwSDo6xPdAnOGU4FAjFZjipF4r4WuYBDJMEABkP6b59FABSa+kqm4jPT4uxjZiDAWYAkFN0tekaMAaWCiYAasD5IxPHGi4WPcHjaRansgVkXgT+y0Ll8NfrxpBsHKhmnP8i1rY1VkRgcq+rOagaPucKMLR3MHStlzgWLtOV17s/r3gA5MIPN9eA4Kazv3kmvaJxM/Wk0NRKtkVqzhRJFjKwg31ksnHbPdOLo6wMxq+hsH7hZk4lxhZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W/Iu8UZg/ynUgc/1DvSb0mPq7ufUDgWUwFV2pur+pk=;
 b=TvDS2sOp4gAA79Z5pb2X7YJRitp345aFrsI863sV1ECNxNog7uZprPZx6Q3d7lAilDgdnUkmQHP4AvXnHEo40i810Q7ww9CkNfXoLzCWLW6q9hhRCDOnpWdpoFzMxVJ4tSnkrYikg4BQ4Btr7pf2XuOVkvMzsvfyKBQbGgtZONaloVM1qtb1W10Gg1VMkW13WPXBbAgfo2myw0wCwAqiX8aXjsbHwkJuUlzWLc9WXq+63DpSWL9Y3aLAZQ2+7EA72RqwCZBiBcYOlUapC2zBG5++QJ9vUabA7Eg6mfKaK0y2hunWPnZESDkUcNUKbdf5CCshXY6GYb5jYsiaZoklTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH3PR12MB9731.namprd12.prod.outlook.com (2603:10b6:610:253::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Sat, 17 Oct
 2026 16:17:43 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 16:17:43 +0000
Date: Sat, 17 Oct 2026 18:17:39 +0200
From: Andrea Righi <arighi@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3-fixes] sched_ext: Don't leave
 balance callbacks queued across a pick retry
Message-ID: <atOfoxKON9YYfup3@gpd4>
References: <20261017152226.3690249-1-arighi@nvidia.com>
 <sashiko-outbox-175614@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-175614@kernel.org>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH3PR12MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 86572904-17cb-42b5-abbc-08df2c6a2c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|4143699003|18002099003|22082099003|56012099006|6133799003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	PkwdbqqaqKxj4orXqstF+mBrt7k8DzwRz+/tuC1eMpFkrGOBsKkH5rIQLPzQ+uJBzTRgGFa7VirZByhQpVa0mQRXxIKGH2wH06QvCjRHdkROhWgRmrB63A7JdH4Ydzmykyj9QHipv38WjgZWLPIDMpCmnyYnDHUSgwJVzf82tfUrkvlkSP8npEl/58jEiyKgwrzYS88dE9HJCR2WCuc2FXE5zY6Qs0zwNJlt8JsJ1NEnTL//4liUj+FQFFcmwuLwEOUcsWDm/p+DN9mDudRxUwKCu+w8tolANvZ2yW+Y8n8HivFcX2LT9ZPuyo3iGtPcxD3EsG7yYAN4iDqGTLjB3GNmS5+hBP987zHa98VOTpdCKY9Ur4iaUvI655u74DPnPWiEoltD2TQC8zvYqPPKHl/GKyfvA8knk52VhwHpjumFYddMdKBrGe/U9W1FjTCnJXluLhyNBUlMyupBV3bXYc9WKEJSI+6u3gnO17MwvG1luHZKbGwXphSQFjaPYWV7iYxovagzTE2CxwrPzznbM4tpcolY7/2483RjGmv40Rx6xYEC+ozqMtn2v39TZAvo3Y3TDpwQhrGCXs/X/TEcoXaei0RB1lLbM934SvdjPgL8fFnmrYKeRmVnHA7FCjAzPhlCs1/qiNJ4YzflpFD2fHzTDTgBqlOpeMLAdK2+nHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lQsPByzEKFXkUmAYsMJ2FQOs0boPF8rbVXZo6SMc1rWFOiZQqfN5+7tXa4zD?=
 =?us-ascii?Q?bJndIFPT9S6hjmkWEh90sla6GX0RfijnttgvM915prDZvt3VOjpi6AQz3UzB?=
 =?us-ascii?Q?TGeqvmTZA4vhgzjAvtHImfTtmPHzovl7E1dNMpoXVoaTsiKmF9LrJ4hBy5qz?=
 =?us-ascii?Q?UK1Iq2YnXiGH2cNIe8Mzvc2tlLP6qNpW+GsDjCoGOaTO1ce7Zh/2a4/J9Zz9?=
 =?us-ascii?Q?CD/f+pfIzo5xIwpe5jTRz9s5ZnG7oDutR8gEPBJoWQy9s0C+qWTDZGZNDN3C?=
 =?us-ascii?Q?PMjENDEfgy9e0hKxNBspZzUdgnaDTyjKmI6fAVMoOTWaLMZY0I2k9yANw7C0?=
 =?us-ascii?Q?yvKg70gs1Y1TsjdyaZIWw/NRz3QcgsoaMm/ceNDTNSoK3PYjIPV13x/dH74x?=
 =?us-ascii?Q?aJHhbEU9rnHcMLxqLI0V7r0oXs5vvKQZRt+Uw1M1I/7FBmhc7TRb5Hg6fJ3w?=
 =?us-ascii?Q?rVo5iOXaK3xv1r3lTE65OzY4/XSt4YfcByPb03T7+wgq7a5tt/T1RgoHsht4?=
 =?us-ascii?Q?bzF0gW/Tsi4sTbONltCnE4xjM/AzE3gC7K6Lmx/fbjEiivW5HkuKuh8w3+vn?=
 =?us-ascii?Q?IWBo7xgnrCE7RrUvoPiYf/5KsaF4850hvHgQ5MEVapAZqqYWgQ5MP4TCoXmm?=
 =?us-ascii?Q?yEJkE2nmVlGjjlCo2P0j3HEFOr5Qnp3NXgC2LYEXPd7PLOdWZLnUS4isLBBl?=
 =?us-ascii?Q?H4ZV89c5rUTionIYBQLOsKf6vDxvnl2ck+68Q6Xx2nw+zoQ+QkPmaEJP53wK?=
 =?us-ascii?Q?77lb59jkdXb393zc/q/hpg58RMfyVDvv04r79sJiVgt3MXrovrRRseBsS6E2?=
 =?us-ascii?Q?aFhCtFgY27vd8CVvXdqNF1mVlesnUrTuIAc4HoKEpEUM9QAE37NUY8cqdwd+?=
 =?us-ascii?Q?nb6ZdNcChFZbUahh9xupLOAIcVggmotcNLM1kikNCrzl0SLeWyu9Tm7bJAph?=
 =?us-ascii?Q?y1NqdMLo1Ao7KpBrf4EC6KzGIXPq1Ka0ZPXe0jJSJgLz+5k3TZ1YrhIJ48qs?=
 =?us-ascii?Q?0s3HVTCffY+7C8hFmHQ+QgdTphdc4qDnoiVAepLLcAHwItFnfHfUyvuTkOzQ?=
 =?us-ascii?Q?/vWBsLCSX9AhC0pDYD+efd9MMwTCzui05nffId09kxfFjai76wTI1+q6F6LT?=
 =?us-ascii?Q?976aPda5N2n0cVHA9RwCZRtZUheCTSfrXSakxJfUs//OhviheUYoZNQgEeTx?=
 =?us-ascii?Q?oNcnNYtb5kAg5NWnqtBXHM5xW7HznWbtNqBR4IQTr126w1upx0z+iqlvegwe?=
 =?us-ascii?Q?NxCWBpE/2Rxi1Su302zDGdR5caAITSj3udcsE6TGrmRo5eqNsE+1wSeFyqYU?=
 =?us-ascii?Q?J8DNjSfQlaiWgBjOns1UIhlXqLXCGemoXFQ9Q6HGCDGAUODZz80USm9k16xG?=
 =?us-ascii?Q?wV60znbtPTOwqhiRY+9HCKVbW+ak2NpvXvf01SvUbsOXeo0QY9vc7ltErO+z?=
 =?us-ascii?Q?Gq2bF9vv9bJy7H2yTywdvqoHUsmUD6KNwRtKy38aEY2OJQwhxrx9ym7ocUqr?=
 =?us-ascii?Q?r7UMliJJum4ZxQOk8sjN2oNpl2Y0TXtqO7p+CwZ7rX0yn8W6XJFn69Kh0C7i?=
 =?us-ascii?Q?YUnEnJVntHaCo6PoNlDGV0BKV902xqtrDKrGYMZtlp9CjvVtPqISQW81gnHK?=
 =?us-ascii?Q?fQMqCLz1bFuVVXZenvfNEROGkuyjFk4f4740AwFEcJuhWxpxeTwkd4PO7Y1h?=
 =?us-ascii?Q?HTF5e991F2kbLiLZfgfxCDILv40Y4AqzwMK82rA7u6bfrPGK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86572904-17cb-42b5-abbc-08df2c6a2c6e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 16:17:43.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yx9KGaDRh/MVsUta6SGRDDZ06QozqJGZKV6F+LhT+tv23kZExvMQGpzHLCAixFhcqNzxj2rarJJe9nHNo0vGjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9731

On Sat, Oct 17, 2026 at 03:40:58PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] sched_ext: balance callbacks queued before core-sched pick is final
> --
> 
> commit 859b8e499322d8a16b0b359431e360cdd5ae7494
> Author: Andrea Righi <arighi@nvidia.com>
> 
> sched_ext: Don't leave balance callbacks queued across a pick retry
> 
> This commit moves the queueing of rq->scx.deferred_bal_cb and
> rq->scx.kick_sync_bal_cb to the exit path of do_pick_task_scx() so that
> balance callbacks are only queued when do_pick_task_scx() returns a final
> task rather than RETRY_TASK or a NULL dl_server pick.
> 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index 0403c46342813..e19961164cb01 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> 
> [ ... ]
> 
> > @@ -3342,16 +3331,8 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
> >  
> >  	verdict = dispatch_one(rq, prev);
> >  
> > -	if (cpu_of(rq) == smp_processor_id()) {
> > -		maybe_queue_balance_callback(rq);
> > -
> > -		/* see dispatch_pick() */
> > -		if (unlikely(rq->scx.kick_sync_pending)) {
> > -			rq->scx.kick_sync_pending = false;
> > -			queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
> > -					       kick_sync_wait_bal_cb);
> > -		}
> > -	} else if (unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
> > +	if (cpu_of(rq) != smp_processor_id() &&
> > +	    unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
> >  		/*
> >  		 * Balance callbacks must run in the context that queued them,
> >  		 * so they can't be queued on another CPU's rq. Run the deferred
> > @@ -3394,8 +3375,10 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
> >  	else
> >  		verdict = dispatch_pick(rq, rf, prev);
> >  
> > -	if (verdict == SCX_DSP_RETRY)
> > -		return RETRY_TASK;
> > +	if (verdict == SCX_DSP_RETRY) {
> > +		p = RETRY_TASK;
> > +		goto out;
> > +	}
> 
> [ ... ]
> 
> > @@ -3437,6 +3422,38 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
> >  		}
> >  	}
> >  
> > +out:
> > +	if (cpu_of(rq) != smp_processor_id())
> > +		return p;
> > +
> > +	/*
> > +	 * Balance callbacks must be consumed before the rq lock is released, so
> > +	 * queue them only when the pick is final. On RETRY_TASK, or after a
> > +	 * NULL pick from the dl_server, the core continues picking and can
> > +	 * release the rq lock (e.g., prev_balance() or another dispatch). In
> > +	 * that case, run the deferred work from irq_work, which doesn't depend
> > +	 * on the current rq lock section, and leave the kick sync wait pending
> > +	 * for the next pick.
> > +	 */
> > +	if (p != RETRY_TASK && (p || !force_scx)) {
> > +		maybe_queue_balance_callback(rq);
> > +
> > +		/*
> > +		 * Defer to a balance callback which can drop rq lock and enable
> > +		 * IRQs. Waiting directly in the pick path would deadlock against
> > +		 * CPUs sending us IPIs (e.g., TLB flushes) while we wait for
> > +		 * them.
> > +		 */
> > +		if (unlikely(rq->scx.kick_sync_pending)) {
> > +			rq->scx.kick_sync_pending = false;
> > +			queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
> > +					       kick_sync_wait_bal_cb);
> > +		}
> > +	} else if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
> > +		rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
> > +		schedule_deferred(rq);
> > +	}
> > +
> >  	return p;
> >  }
> 
> [Severity: High]
> Under CONFIG_SCHED_CORE, can a non-RETRY_TASK return from
> do_pick_task_scx() on the local rq still be followed by further picks that
> release the shared core lock before the core-wide pick is final?
> 
> In kernel/sched/core.c:pick_next_task(), a single shared core lock is held
> across all SMT siblings, and pick_task() can be called multiple times after
> the local rq pick succeeds:
> 
> 1. In the !need_sync fastpath, pick_task(rq, rf) runs on the local rq:
> 
> kernel/sched/core.c:pick_next_task() {
> 	if (!need_sync) {
> 		next = pick_task(rq, rf);
> 		...
> 		if (!next->core_cookie) {
> 			...
> 			goto out_set_next;
> 		}
> 	}
> }
> 
> If do_pick_task_scx() returns a cookied SCX task (next->core_cookie != 0),
> the out: block sees p != RETRY_TASK && (p || !force_scx) and queues
> rq->scx.deferred_bal_cb and/or rq->scx.kick_sync_bal_cb on
> rq->balance_callback. Because next->core_cookie is non-zero,
> pick_next_task() then falls through into the for_each_cpu_wrap(i, smt_mask,
> cpu) loop to re-pick across all siblings.
> 
> 2. In the for_each_cpu_wrap(i, smt_mask, cpu) loop in pick_next_task(),
> iteration starts at i = cpu (where cpu_of(rq_i) == smp_processor_id()):
> 
> kernel/sched/core.c:pick_next_task() {
> 	for_each_cpu_wrap(i, smt_mask, cpu) {
> 		rq_i = cpu_rq(i);
> 		...
> 		p = pick_task(rq_i, rf);
> 		if (unlikely(p == RETRY_TASK)) {
> 			...
> 			goto restart;
> 		}
> 	}
> }
> 
> Once do_pick_task_scx() on the local rq succeeds and queues the balance
> callbacks on rq->balance_callback, the loop proceeds to call
> pick_task(rq_i, rf) on the remaining SMT siblings (i != cpu). When
> dispatch_core_pick(rq_i, rf, prev) runs for a sibling rq_i,
> dispatch_one(rq_i, prev) or run_deferred(rq_i) can drop the shared core
> lock and return SCX_DSP_RETRY, causing pick_next_task() to jump to restart
> with rq->balance_callback already queued on the local rq. Any CPU acquiring
> the core lock during that window will trigger the warning in
> assert_balance_callbacks_empty() via rq_pin_lock() or flush the callback
> early.

I'm planning to fix this with a follow-up fix, it was also pointed out by Tejun
in his review of v1.

> 
> 3. Also in dispatch_core_pick(), if an SMT sibling already has an in-flight
> dispatch on the local rq:
> 
> kernel/sched/ext/ext.c:dispatch_core_pick() {
> 	/* another dispatch is in flight on @rq, let that handle it */
> 	if (rq->scx.flags & SCX_RQ_IN_DISPATCH)
> 		return SCX_DSP_NONE;
> }
> 
> Previously, returning SCX_DSP_NONE here bypassed callback queueing in
> dispatch_core_pick(). With the callback handling moved to the out: label in
> do_pick_task_scx(), won't this early return now fall through to out: and
> consume SCX_RQ_BAL_CB_PENDING and rq->scx.kick_sync_pending while the
> sibling's dispatch_one() on rq is still in flight?

Hm... yeah this looks legit for SCX_RQ_BAL_CB_PENDING, I'll fix this in v3.

-Andrea
