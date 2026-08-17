Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E3367F31
	for <sched-ext@lists.linux.dev>; Mon, 17 Aug 2026 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995175; cv=fail; b=FsW0d0J1T00N08NTEGrRz4o3gRIJb3xJdMl0SBZvFFf/7vTKdVS4aPlVUyRK1ZWBfV+u7nf/c8+hqhiz3NfcrDmkqyHngZF1yykoYJuPnUo/mjUXRQrRRM7htX0XgufUz1xqS9tpvza4e4a+WRkSdQl8c8w6+JJ7mcm76SQaioA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995175; c=relaxed/simple;
	bh=l1TsW/B9B1iWg2a+rbEMTir7J0dp9kaeRokXUK8dMuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oIP8+uHKfZD5XyuK+DTXRrMaZEcy0LeEDogfetvQvtF7aNfyavO/HwT/Lrn0qNhzIp6qL1SUzN8HeipqKg6f15m8iQl7xV/27glyNrC+qjgXLVd/hcp6NGS0WM/rXIoQHYm9cBSQ2Nqy3W261eHO2b+4ZC2Qbe+w0mm8zJ2MV28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVXOL+7y; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVXOL+7y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYmT/PhI7q+4IMR8vAO4QNY40jjdwuzLCpFeKV1ylO0TyXXDyEmOctKxghxy1eEWRWyjfAcuTgahDpjDlsWSSrTwx89R+8art6jqBv3a+bkpXOZNUQbLWWFRkay3/sekqHr1EkKwA00Rl8bBR3LwBwyvaTkpDYN1Sa+rJImKlUpW5QKxyXsZe/J9Dt8YgO/9wDo+qUp6L9LNcJPW+ANED1UeRGZ2996jx+EkGBvaJx22508Bk5ue7MTHisNyEvF5QTeyM+QGm+wk5L7iPpv9Hd0/PfD71+qelt8EMH7i1M48feHuHASKiI93hrrDBqkUOSTk+2OUDNXqqogDaZLSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfsJKj0z3BcW0imrwKncvCElRkmamv2GQa0WokfCHyQ=;
 b=IyvjLPUcMXuCuTcTn9xk8kISxBiMFGdMivO0dvlJkrwSSuAQuwujc+ftGAj+4fR2RGbLfYjamyohfFZpKdDAmoEw6zwTeH1G/yOjYI3+6kAo2L74g/cO1Snvbfq9F6AQJEINRY3hRQ8e2xTEXAs2oG9BBaAPkkAKmysBiCqB8PZ92K+CE2OHQCfz49i7e8qjl1qXzKxi9HsS0bc/ghX2jIGzAOig3y693VST8wcNsO8eOQMxSrTdehQ6vEA4IG/+IQtZnl6dmRX9KAog8izKuFrq7Aqp/9WDC1UK38txBDviVGE2VI6LvI2HDYYUA3agyW0XcVx4mSEK4fm7kWz6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfsJKj0z3BcW0imrwKncvCElRkmamv2GQa0WokfCHyQ=;
 b=XVXOL+7yxnlbXQZHOgDYIxIa3Jb6k6EIrkUptzGocwfci3lHhmzVAKtbUEY4VwDeocyN93+at/q8HJCMmTPzVH0OtY4UTYMH4TTg2l2kxy/Nr/Cr8Q1UBgtwOjb9yqzqYOuc3kSVIZkCescX/60j3nXypUGITUkIdCDF1UEO7HoHnwQ4d/d32z+twDhfWjOVDVbfixHOcg0OlC6Gjk8E65PMHp+CA7NSu9dXO0vx7tZf6f6w75RXvNi0CFgHqATNG2ZCsF8fT0O2nXdwRQWxG8+51QuwpY/OvyE3fJUQkLR/G5wAXnj103n2R+LPr0G/E1o+ExZs9deMRTOhKHKIkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 19:32:42 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 19:32:42 +0000
Date: Mon, 17 Aug 2026 21:32:38 +0200
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
Message-ID: <aoNh1gAh1e8zDRKD@gpd4>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-13-arighi@nvidia.com>
 <aoJNrhYq_MjO1bDb@slm.duckdns.org>
 <aoK1Ck67oyhysjQD@gpd4>
 <aoNCIwlkVXKNgM5l@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoNCIwlkVXKNgM5l@slm.duckdns.org>
X-ClientProxiedBy: MI3PEPF00004E96.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::446) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b61fa72-e7d4-4918-6847-08defc964e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|56012099006|22082099003|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	WP9qA/a4EJzgFauG9cIJCnY4aPIvNRirU5MSQGjLMx2fJMMkoE6nA50qZcWVQy2dHF1SAdEBxSaCJgQVMpbrhqjW0t/OWPZpL7lmtwpV99JGMPGJMiV9oDSiRvTiW5EQ595Ekfb5LovmiKfiNyo5RRjk/vmDbKrG+TAJpnKQgH9AmHZc1r3BmGV5LxySvq0kx7xewP7IqtMl4O7aL1GfsiTudqbT4ixZIm4WyafxheFBZmHZiuwbPV20kpBflky5M12ixJWzPNgWhO0BXiwvtsvoij628dPA94n7R3tmGObFSam54UazuXnCXXMQsIsQuTfF3Qco2dj5mHLRNu1+aB68UYx9SmKuxCkWrCFbRSTS7Ogi6SYtpGn7FMIClajM2gnfwLL5/blem8DiRDhb1mjJYe0439v+2WVtUC+33hozrX/q4l/PkPVV5+pBiR7z5dYkrnQG4KNNch8X7BfaoouiSRuBERoOQjjImmqYi0hIOkRHOxEDDYM3aURc0rwTNGAaThtz4+Ar45aoKJ53awNQwoBVbSaoikSqJDF5Fpe7eb5RsgARlkQPuMPG7kEBLUalmlNHUIGDVeKdQEKKGXPXyz9/FHsY3F17b4w+tOji10PKgteia4slENcZ4HBoK0XzU7N3HWNqEiZSK4PTWTQFoOTjLf0iwN1Gd03NPzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099006)(22082099003)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?umHxpiiQ3n87JX+rn9bQXmO5VJrtPmrSrHh2jJ1YWRnYXoerle9U6PWuUPwu?=
 =?us-ascii?Q?BvjRSZGWn3JxpZp2eT2VNzZg9K7KdspAduoKB4KMqWrcit0MkPnzeyE5EXz8?=
 =?us-ascii?Q?8A2VwTFIxDpgJZP9dADROUi+fZ84jbU+iYaHTUCb31ZUYp1sKMijMBzubhsi?=
 =?us-ascii?Q?jG2BmchjvW5Dg/6aXNuZUWZOTfIIsSH34RfN6Y33+OdA7+jK3yKPHMNlQIMm?=
 =?us-ascii?Q?301cjVbn6wI2HbC4sGFas7k1GxYD/Do7Zo8V+zC86mkPML1Vf4rFfbEjjAhg?=
 =?us-ascii?Q?I8P7UJX6C3ru8asg0p1l0VsHYMPbk3jBuR53GW/yPTBGT5sJfzm0kzkVhgJi?=
 =?us-ascii?Q?uoS86cajbUsIfjIlK6CkFL8n6GS0d7rRlgFGfCHuXXdhsrg4zauAFnCjSrqj?=
 =?us-ascii?Q?QeXGHXjE7YnXP6dhaaVurt6xSg8oR3aW2DjDTdNjrqVSz+Nvve6BiAfpr8b+?=
 =?us-ascii?Q?IC9JE1E0mVvtXVvp82St6VbFgHVYu+WZe1KTYI7zDbgH7sxe75qdxGmtdlCh?=
 =?us-ascii?Q?cpxzaL7XW9HZGvZd3spz130BwfTYN7LT20nZzzs5mi5pdPSBwMmTlACGVgkH?=
 =?us-ascii?Q?59O0++VigAfqikAdYouvu0zYGtXVca69HsRsLOgAUCDgLRAcwyH0v3aqKQhA?=
 =?us-ascii?Q?H41BqhJ3Rr9j2N5z9voES6L7hmDxNRD2Rb2IXFTSKiUIO+G9xQcSLX0lMq4C?=
 =?us-ascii?Q?P0eRTSRuJpf65iFrVy5BCx2MJjN1wEC9gxekpvrrXtDc4jeeGdy27bjCbuxu?=
 =?us-ascii?Q?W4Fq/EOzYmLhq2wymhPkEOXWd09ic9WNajlIaf5eWTUmJkJs9APr1NCMdoN4?=
 =?us-ascii?Q?4nmfkHZMFlB8WEKOWQ/fhK6bdAwdrocSppl9pZ+uKxu0HfVzvlQJMf2eMNgM?=
 =?us-ascii?Q?5r2RKze2gZmniO+0FmP7KbqtYClmNqj63pmn8QLBefIUsEUQpe7Qh2PGsoz3?=
 =?us-ascii?Q?o2g+6cEyV1QWn1A/5tGbV/3gU+3pU06gWiReDax0XPpeyMB+qrt7UYAq5yHV?=
 =?us-ascii?Q?XhQgiOuTln0SrD6pYVVhPenlN+arMjadvjJPV2VZoFEM5laRmy+WG95ewTtu?=
 =?us-ascii?Q?NnMt71QbVqm0oxbn+XbDC+04rEoCwnVmLfp3CdypNzNdEIALPCDple0f4a25?=
 =?us-ascii?Q?09JMAgcG5HEZ3xl8znTxYg5HjdbYiS1pI2ne8H5UkEbVzVl+QJ+B+zXuL4aR?=
 =?us-ascii?Q?flJrqxAQBtl+psREwRmvoSW7UFLsK4MbKKgB4TnZG1+rlzcq751hHth3iALF?=
 =?us-ascii?Q?/bI7dfDqrO7N1spvfDJ/KJ83ERdTBrxxibAgi7S0lUbx6ruiDAbcQNdzJfuz?=
 =?us-ascii?Q?RlN6xeY/VBJDLAd8Xc5xeUX1dVRqK36eC6mP2Peh6DJcrUKSnSsARjTnMHiO?=
 =?us-ascii?Q?QhPKgT01rPHC+Acly+PyJHHAfHRB/jK5JiMhivMOUSJY2sPzuZ5s+rElRreW?=
 =?us-ascii?Q?ijoW2H3bhev9CS55RPHEijRlU5uyJoQGOIK8a89t2CmqTkVPg834Q5p7Lagb?=
 =?us-ascii?Q?txCnJ01UCXI+Z96UypTDk5Eff5tMxG8tUcbp+9qoZm6beEjDMlx5hAcsOWpG?=
 =?us-ascii?Q?kCrEu1MkwZ0v5B42zUYMdwlJLjLKkrmZLrr1fytay/Arnr5FzqAgu5SXdW55?=
 =?us-ascii?Q?bw6PNrNFKqoCFdVKwIRnsGa3ukpTqp+hLnuVwHlEXzq+hK90cYQMRFj26IPv?=
 =?us-ascii?Q?L11lV4iT0DiJV1gc97ewYZ5mIhwtd7dbSiU3S14X55XmXWPzLb0qW3Jq21dk?=
 =?us-ascii?Q?Ea66OpMPKA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b61fa72-e7d4-4918-6847-08defc964e4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 19:32:42.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vkfi82ue5Wg+/abxGUhvndPlblZczVVMWBCdhw3vtopakfufpmCUxM/zNf+2eKCOa/Df6JUJbiknLOxW1BydaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044

On Mon, Aug 17, 2026 at 07:17:23AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 17, 2026 at 09:15:22AM +0200, Andrea Righi wrote:
> > > > @@ -1530,12 +1539,17 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
> > > >  	call_task_dequeue(sch, rq, p, 0);
> > > >  
> > > >  	/*
> > > > -	 * Only local inserts get the wakeup treatment below. Rejects kick the
> > > > -	 * deferred reenq and rescue parks are paced by the rescue timer.
> > > > +	 * Only local inserts get the wakeup treatment below. Proxy-active tasks
> > > > +	 * and rescuees remain parked until their respective resolution paths.
> > > > +	 * Other rejects can be reenqueued immediately.
> > > >  	 */
> > > >  	if (unlikely(dsq->id != SCX_DSQ_LOCAL)) {
> > > > -		if (dsq->id == SCX_DSQ_REJECT)
> > > > +		if (dsq->id == SCX_DSQ_REJECT) {
> > > > +			if ((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) ==
> > > > +			    SCX_TASK_REENQ_PROXY)
> > > > +				rq->scx.flags |= SCX_RQ_PROXY_REENQ;
> > > 
> > > and if my reading above is correct, this wouldn't be necessary, right?
> > 
> > The flag isn't needed to provide the post-switch ordering, but it is needed to
> > record that reject_dsq still needs another drain.
> 
> But wouldn't it be able to use the same schedule_deferred_locked() call like
> SCX_DSQ_REJECT case so that the PROXY_REENQ flag is only used for retry
> cases (and maybe renamed accordingly)?

Yes. The initial insertion into reject_dsq can use schedule_deferred_locked()
without setting a proxy-specific flag. Then we can set the flag only when
scx_reenq_reject() actually skips a task because it is still running or
donating. How about renaming to SCX_RQ_PROXY_RETRY to refelct the new meaning?

> 
> ...
> > It also preserves the outstanding drain if proxy re-pick calls
> > zap_balance_callbacks() before the initially queued callback runs. In
> > that case, the task is already parked on reject_dsq, but the flag lets
> > scx_proxy_resolved() queue replacement deferred work.
> 
> I think this is a generic problem with core scheduling. SCX assumes that
> deferred scheduilng always runs but core-sched can zap them. We probably
> need to address this directly using a similar but generic deferred work
> pending flag.

Agreed. This isn't specific to proxy-rejected tasks, any sched_ext deferred work
queued through a balance callback can be lost if core scheduling zaps the
callback.

Maybe we can introduce a new generic sched_ext deferred work pending flag, kept
set until the deferred work actually runs and we can use it to rearm it after
callback cancellation?

Probably something to do for another patch series...

> 
> > > > +{
> > > > +	lockdep_assert_rq_held(rq);
> > > > +	WARN_ON_ONCE((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) &&
> > > > +		     !(enq_flags & SCX_ENQ_REENQ));
> > > 
> > > In the previous patch, is it possible to clear reason before reenqueueing
> > > it and get rid of overwrite cases or does that quite not work out?
> > 
> > Yes, I think we can get rid of the overwrite cases. There is one constraint,
> > though: the reason must remain set while ops.enqueue() runs, because BPF reads
> > it from p->scx.flags.
> > 
> > I'll move the clearing into scx_do_enqueue_task() so that it happens immediately
> > after ops.enqueue() returns and before resolving any direct dispatch requested
> > by the callback. A rejection caused by that new placement will then see a clear
> > reason field and can set its own reason without overwriting the previous one.
> 
> I haven't really thought through it so please do whatever that makes the
> code least ugly.

Ok, probably moving the clearing into scx_do_enqueue_task(), after ops.enqueue()
returns but before resolving the resulting placement is the least ugly way...
This keeps the reason visible to BPF while ensuring that a subsequent rejection
starts with a clear reason field.

> 
> > > > @@ -2633,6 +2719,19 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
> > > >  
> > > >  	if (dst_dsq->id == SCX_DSQ_LOCAL) {
> > > >  		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
> > > > +		/*
> > > > +		 * Unlike the rq-lock handoff paths, @src_rq has been locked
> > > > +		 * throughout this operation. Only active proxy state can race the
> > > > +		 * move here; let the enforcing check below diagnose an ordinary
> > > > +		 * migration-disabled task.
> > > > +		 */
> > > > +		proxy_raced = src_rq != dst_rq && task_proxy_move_active(p);
> > > > +		if (unlikely(proxy_raced)) {
> > > 
> > > I don't know what bouncing through the local var buys. Out of curiosity, if
> > > task_move_proxy_raced() is used here, does something break or is it just to
> > > avoid unnecessary tests?
> > 
> > Yeah, the local variable doesn't buy anything, I'll remove it.
> > 
> > Using task_move_proxy_raced() (aka task_proxy_unsafe_to_move() after the rename)
> > would change the behavior for an ordinary migration-disabled task. This path
> > holds src_rq, so that state isn't a lock-handoff race and should still reach
> > task_can_run_on_remote_rq(..., true), which diagnoses the invalid BPF-directed
> > migration. Treating it as a proxy rejection instead could hide that error and
> > cause repeated reenqueues.
> 
> That sounds like something which is worth noting in the comment. It's subtle
> that this site needs a different set of conditions.

Agreed. I'll remove the local variable and expand the comment.

Thanks for all the help! Really appreciated!
-Andrea
