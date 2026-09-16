Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7344AAC55
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573989; cv=fail; b=Gi5O2NzeFJs03XmTa91PkuVijn+juOcvtsWkGqKx68mc6zMEGuEEfbuEzydfvbOLkW1q7vLnuTeQO6NaBT6xtiUmVyiw/G1Wwlsbhd7nhWGgzxWnx3FR4Fy/ggHLS0imhBKBuzM5mGVlaFpUCWT2YBATS+1vT2J7DhSNIl7RKJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573989; c=relaxed/simple;
	bh=t67eiOrMC2/QbJqpN5SinjATgBJyZozE91YyJ7sMsLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m9sC3g7jRP5BTCdwe90vecWbfeo/4QjLyETU9aQ0V/G9p/Yw+lPfTHgYK47JKgqSLbQMol6/+BMYGCWLPOp2PPkHTnLOoKry2oO8pUFuOQEcz9RYvbSgck5T5H7c34DWEieBOgSyKDl8XYHuZWxIJSyj46MPOGVMb7bP/6Sm2bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zm4hHol6; arc=fail smtp.client-ip=52.101.62.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zm4hHol6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0m/63BhAG4H8EMtbVt625WDPo/3Ihf0PNl3Ls4fKG/SrKckM3l34WdwCzEid29SFs2MoGm95kSjxYDSwGXEXdS4ZEJINUtEV8M9Sfs3Q2agIE9PqJllS3H1kbpQLFqpyNd+yfBn0zes+fNrVHGge1ODdhUEtFggE91WnGmtHkdpnnZDGLQhyl2oY6iLdHP9yaODPVg/Adt6mXPRIZ6KiPl6QPK3xcJ2uOflg1rV5nZJd9LCkIz7W5idVBfT1ELx0tgqDsrBabShtI1wJk3/ApaCvRXG9Qapf4uDaEHuZV5sT76vlX8tseXFyGJfEhjRJf79GPOJBwzfWEeHTOJ9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtSO09yKmxRrxElDkEpbb6EmNMag2dq+a3dr68tq5IA=;
 b=ah6NP8O2Ovk3msCywQOIyYa8hnRgmfcpNjW6YoTfSGH+znDMz9fNsiLMo3m+kNdixaeZMV+g20e3Ij7DnzOtKB72onKvgfJYH2Q2iRM+6aAMycQsaYfD3XLUtRsjvSRkFwBly5xYbdoDUS/hl9DjlF/zz9ivnglNpFKvkoElnRMiR6LtIaSgBnQZonGHlSZVTLh5JXXMXKrc259z4Ch2cAtsfgHTHQuApp2ws5PEVCSfxZhuaszF7VEVyNLBq/7QbNppqczVYSsLy4g+As0wd2CeFsb4fO/eEHDnBjDtsiZRl7BUjkJcR4oaR8IhJVKCPGuhi4zKYffVODE35BWWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtSO09yKmxRrxElDkEpbb6EmNMag2dq+a3dr68tq5IA=;
 b=Zm4hHol6pSFrgWhpLLBPWv3A1Ge7u/zo0VSkNbloF7svPqC3iGh4JQUL//6CTEw0QGINkmHiKqOGuEqvcwrCEFOKkKOs82CSSnn8Zu8ZG+dQKlwWFRYcplL/4SgtyBttbhY5mJr2DTDPHz6IUUwpdMZ1l9kHaD8Di7fQrdTjaoxMBcJZVjNWQKHUqIe3PTxSKgl9sxTtN9jqWdecnRVF6AJIk8+9a4ZoZuGP1w2jEwuPXChWNPQohXG8J6Rr1hDR1fupIeLKNd1mc6HoeNl+2cMO8OT2n6rE84mfqidMWsoIllEJKJZRo3hwb+qjOEk9DxPX1akZ/+5ONpnwD0tvoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 15:52:50 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 15:52:50 +0000
Date: Wed, 16 Sep 2026 17:52:42 +0200
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
Message-ID: <aqq7Si1D3P2et_gw@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-8-arighi@nvidia.com>
 <20260910103818.GH4120091@noisy.programming.kicks-ass.net>
 <aqmq7iahwiBR34zU@gpd4>
 <20260916090017.GF4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916090017.GF4121339@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI2PEPF00000B85.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::41c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: c455f84c-a812-4982-264f-08df140a8f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DCqqVot+WrnJkmsUBjglHnSIwzrY6LbSKBc4XBBbpnj6+tWflDWDODQjcjfTAEYM/67cRtkzJscn+xIvTR+3xexEQ/0CHVOima8FS7beR4gUhXtziGrYADP0N8u6vTYH+Hz/gsspJVkbLab1dRySpFomEoO24pE9j35Rl5w7yC+lCQPc4k1FYiEqoalvHL97JNuSAuCkV1e6nfXQUizesMRQmkWrkCpiU8KoTlYaECjIXKbFbTiG91zlKf3SeaCufy/o4w07Xs4sKF1JwGe9Uoz6mtiXsJiQqUi+FEZIbQzLMH0g03VVKsakjxDGThXfOJuoPMYmyeqRd7H6HnQ0jpbalzJcxPIm+PCCt+bH8UaxEwjdZykPK+8d8Gzxrn0UHzFkyV9tSzRmaO4mtJ4XGbGKWuMf2B2k6+u44KI+J3PjBY3Oin+XQPSXVNUid3b9OFMjLfD4K2MF64b8InH6v0D6Rw7MXPIo0+6/qRHC94yj5v+c6mC7DJz7uFtPfcRAajhwA9LsNlHp8Rn5aT3CHAXMzrx0jaHalGjZL9Mr1mcTC0Y92wsjf+YA1PpltSPvJU+rmiBDW3KFtj4JMSLLC0jCb1OZ7HZQ176tqJwmA2g3KyBjtJDWPAdTtfAwveLmiC0uZGkow6JYEf+3aDMVS7LARZ2uSaZL9ofxG9boyCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VTCPA0v41OarCuK50Y487zt7sQeO5qgwEiEA0iyVZYt/lUbzCKAQZON/t9/i?=
 =?us-ascii?Q?CAKQXpLakLOHaR2T0LrqhtecxFSJngibfGQ4klfr6v3rS0ffL2IUjM+uclHy?=
 =?us-ascii?Q?OWd97KzTFLhJzTmODmRxFrNPkPBnwz6UBA3QSF8Z+psreqKgMVAWllrQ68Qq?=
 =?us-ascii?Q?Z0iMkFHyv4zzaBA8JNZ7rWchNYLbOAWZXo4954OnHcKmMQKygqpuA1Pj2dAN?=
 =?us-ascii?Q?HTxO14O9Pd8V2faMjCzMCcnARfxovzmDdq70TidivNcoxMAot8Fcoy7ui0Li?=
 =?us-ascii?Q?0tHUcG+HcTqtvPN14UjYZTJFP8mZean6EQWbIPSlu+4St/IIrgNmQCOJENyj?=
 =?us-ascii?Q?Q3re2CyiFCdH79p5nlboFrhh6pJA2hN4zpWb9L1GN1IF10+mCPVQaA54Giyn?=
 =?us-ascii?Q?8g4pvhZoZ3yyC5r4HchzgSTOcXkdsdf4SoUMj4cHfbRZ/tbTmm5GYqDO4x3n?=
 =?us-ascii?Q?nHMmEftN9oxAj6NyCwth7qjWFNsHVXh0H0baFw1uwHMtST1K63ugNa8rSYSB?=
 =?us-ascii?Q?rqlCr7cTKlgNqXahri44lHwRMhZ0uEe0Xht3iZigoWC47kfucZWUFwktVAIg?=
 =?us-ascii?Q?F/ZPbJ/Olqql7acbWgGsSUKY9VUKHZaY0kn27NX16y8tKLPZ+oTExtf793Ri?=
 =?us-ascii?Q?E91zBCMIUvEjb3KrBCw0hxaIuxF+iWZcw/SR0jy0ddyNNOr01llSYJDaZjHN?=
 =?us-ascii?Q?mGIGHffRNSbkjEu4S0FKQLWx9ySBns2yFgId8DwH3DE+zUptD4MHlurnjUJd?=
 =?us-ascii?Q?Hy4aE3DV10x3KNBGN/jvHl/hFXzs6wvnv/TDK2BdNjQtTkz/iuD/Ok01s93t?=
 =?us-ascii?Q?+W+itWYZ10dwkIyMy83EIcLtIvNIXdnKoU0WHJMSwY57veut/Pe3dCRdBLgK?=
 =?us-ascii?Q?hVD96Lt0s0AcMgJkyzxovIO7PabXuhF2q67anrdoiqZKfFdpa0BjJKnXicM9?=
 =?us-ascii?Q?mVfiaiRHOe+S1b3X9JJDbDqjTdZxjk8r14mpoO0Pp0/Nbq66bKl2lfKdZLUm?=
 =?us-ascii?Q?8LJa8Yy8DMp3nyBpxH1UCCZsje5QEaVWYZn4HqQN4ySw3a/bIJqvbiP/oQB+?=
 =?us-ascii?Q?ypHmNZSBpKC6cGWzPq0anhs1ghRcd2DRp7Xne2LuPNoAdoff2CHNz8p6d7dQ?=
 =?us-ascii?Q?5rv4bH605nfEayXiwSanKOy+Z9mt/4X42N2bYgs6XROOTw0XL2GKUyXfaI/q?=
 =?us-ascii?Q?MDwFLnt/oX60PaXsqQG6rA7/XwqaSkAe9KRKwXm84J1VqfXeuVZ9xASqRpZv?=
 =?us-ascii?Q?yB1groYfj04dbuPAm09Qif4wW6/T1Pf8lul2gZJLP9wWeQ56X8meOP9+X+q3?=
 =?us-ascii?Q?8Z6MvawFTO3AhDL+FgiYN+SBJaHzMbVkxBjGinGPvVoRj3OPhvaDSmtz209Z?=
 =?us-ascii?Q?PXoc9JI1Tb6hdT2ItpWjjAQ2m188kk6mAVHTpCL+jpYYrpW1rVy8AstIrdM3?=
 =?us-ascii?Q?Rm3KOe6S9q8XwhVG0x52xfL+jCBQri1Tx+eipPm+aTDag95hP8I5A+wcBzsF?=
 =?us-ascii?Q?uq7Bqx8aEaDN/MJ+Bb6y3ucDYliZ2tWecW6w8W4N6hHbeMKMw81KVbtShvB8?=
 =?us-ascii?Q?19PgYw8rKMHlvdJ9vzLKTwiLrGabqLaPwa3FRgWQT56UMrm4UMCDQ3olOYPx?=
 =?us-ascii?Q?81ELl09p8dadzN2pf4tmR8YHqKX0rrnpfQrLLwK2pN2hzDnCJeelCWvkXWe/?=
 =?us-ascii?Q?HzCwRcRZp7EYnU82K9vwAgwK0nsWqVMYOd8BqMQ/ptUMnYdtbZptRLamyHRb?=
 =?us-ascii?Q?/kvfRJ3swA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c455f84c-a812-4982-264f-08df140a8f9c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:52:50.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rlr1T5iYmWSTgCYKZKZS1bfeIfqzCylU25VWYW3PhaqmGMuW/sWjvpbCN2wQjuneWXlK/hvMjkrrvff1im9Xbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026

Hi Peter,

On Wed, Sep 16, 2026 at 11:00:17AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 15, 2026 at 10:30:38PM +0200, Andrea Righi wrote:
> > On Thu, Sep 10, 2026 at 12:38:18PM +0200, Peter Zijlstra wrote:
> 
> > > > @@ -7264,6 +7264,8 @@ static void __sched notrace __schedule(int sched_mode)
> > > >  			donor->sched_class->put_prev_task(rq, donor, donor);
> > > >  			donor->sched_class->set_next_task(rq, donor, true);
> > > >  		}
> > > > +		scx_proxy_donor_start(rq);
> > > > +		scx_proxy_resolved(rq);
> > > >  	} else {
> > > >  		rq_set_donor(rq, next);
> > > >  	}
> > > 
> > > Can you expand on the need for scx_proxy_resolved() ? I understand the
> > > other two, but this one I'm struggling with a bit.
> > 
> > Yeah and the name is a poor choice, it should renamed
> > scx_proxy_reenqueue_retry() or something similar.
> > 
> > It's the retry point for a task that sched_ext couldn't move while
> > processing a dispatch from a remote DSQ (used later in the series).
> > 
> > When sched_ext consumes a task dispatched to a CPU other than the one
> > whose rq currently owns it, it may find (after locking the task's
> > source rq) that proxy exec has made the task either the physical
> > current task or the active donor. It can't migrate the task in that
> > state, so it parks the task on the source rq's reject DSQ.
> > 
> > If the deferred reject-DSQ drain runs while the task is still current
> > or donating, the task must remain parked. Retrying immediately could
> > spin until the proxy relationship changes. The hook provides the
> > notification that proxy selection has run again, allowing sched_ext to
> > schedule another deferred drain after the current context switch.
> > 
> > I couldn't find an existing event that covers this transition without
> > periodically retrying the reject-DSQ drain. Is there a better place to
> > trigger this retry?
> 
> Ah, so its a little like that problem we had with ->balance() and
> ->pick_task(). Where a task gets taken off the DSQ and moved to the
> local queue, but when not picked, it must be moved back.

Exactly, that is the same general kind of problem.

> 
> In this case, ->donor is visible to ext and all is well, but ->curr is
> not so easy.
> 
> I'm still a little confused though, why not leave blocked tasks on this
> reject queue. If they're needed, the proxy mechanism will move them
> around. They won't actually ever run except through proxy.
> 
> The point where they will become runnable again, is through wakeup. So
> why not delay everything until that point?
> 
> Or am I not understanding ext again?

I think the missing detail is that the task rejected by the remote DSQ transfer
isn't necessarily blocked.

Consider a blocked donor D proxy-executing a runnable EXT mutex owner O on CPU0.
O is rq->curr and D is rq->donor. Since O is executing using D's scheduling
context, O's own EXT scheduling entity may still be on a non-local DSQ.

CPU1 could concurrently consume O from that non-local DSQ and start transferring
it to CPU1. After dropping the DSQ lock and acquiring O's source rq lock, it
discovers that O has become rq->curr on CPU0 and therefore can't be migrated.
O is then parked on CPU0's reject DSQ.

When proxy exec switches away from O, O stops being rq->curr but remains
runnable. There's no wakeup in this case, because O never blocked. If it remains
on the reject DSQ, it's no longer visible to the BPF scheduler and can't
subsequently run using its own scheduling context.

The rq->donor case has a similar issue even though that task is blocked: a
blocked donor can stop being the active donor before the mutex wakes it (for
example, if another scheduling context is selected). The proxy exec mechanism
follows the owner chain after the donor has been selected, it doesn't select
tasks from the internal reject DSQ. Leaving the donor there until wakeup would
prevent it from being selected again for proxy execution in the meantime.

This is why the retry is tied to another proxy selection point, once the task is
no longer rq->curr or rq->donor, it can be re-enqueued to through its BPF
scheduler.

Thanks,
-Andrea
