Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8DE3B27F5
	for <sched-ext@lists.linux.dev>; Mon, 17 Aug 2026 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786993357; cv=fail; b=UQqaj0kZsFgZDi48AlRlVPvWGUa2yCq/ddR12go/lA2PW6eYh+QjQTM0Iye4tRXr8DyAf0vFkFFhXs9jqKAWM41z1rQExJs9/1wt+pyZ04Eo4jn4rlfRUh49uCZ4I3c4wGyiHSK1s+znhqJCPXJpcUDvUoZK98T93sm6zqZ2e7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786993357; c=relaxed/simple;
	bh=jTlCPcaMDcqOj5FrAkG1Oy6sK2/i4mxNWuxBgCNJ9ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I0XQJHfRGTOymiiRBstnDjN69ACOB0ld7b0TpMS9mijBZxZGD4HEklrloAKMxEiGbznviP9NaX0hJab/VdzT3l1F3xhNEpPRkn3XiIN+/KYlAQUTNJ/2atOGkxDKkHX+14dmR/SCI9aQP0BmDTD5cM2Ja+4CKGCzN+1mrJYArd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p5BhjMXW; arc=fail smtp.client-ip=40.93.198.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p5BhjMXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6kfTbeiMAI9SNPg9P1wjAOn1NbTdWEgDmrHGawyr//jPHIUGfTYa4RzTuxdYtBexQqQliN/SYQmvddoff1bc3Lullp513z5ZmsvEvK9UOlP2OmtWZ0EKB/bKgL5gTJCAwsbYi5WNtvQQt+ErlwMszu3qfSUsNRUBUvRLtyHQZZTunHBIOsAQo5Poa7NGD8Ybx9wizLIE+LPDyQOwvH7jYzqV4rlguwV6KIZwa+3L0EWz6I2hZ4S7TvB/FHgPzb0f3Or8IIXBX+FYO7pITPyYk9S1fDI9w11FWwFt5EOSRj2P7e3B/ZS0jPLSEBHjxlDfB3gQVNMiu9NsWKpG1uuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thH4M8Czrtnh1WaDJOoq40BdIKQ+u3MlE1FTRz8Ft/0=;
 b=OqEsnrbN5hE/Bo1A5jScxbjj4LphXApy5tYRsToaC2c90HAdIm4pG54JeVZTSlghC7jmH4nTvmL68J3FTIPZJ/W8qbanIA9qQZ0aHAeL0yMx4/Vgpdiw+gotr2MC1mHsE8D0ch+AxFVu7XTQVHFLlWVj6Z52yI5YND7LS+6sNkbNmIfv8gmT4spZepPIzSwxVWCfQS8zpfk9gR+A7Uc7ZvAlw3Shu6iRqSjj9ZqZlPY4f8TVSF6TIRj2UhB1eBUPNPkk9Z4pD/b1hiKoWJRzEqd1Dqio6XPdLH7XRoyKOs0h3+grDBvWS23FzQPpfrJr9Upj3PfL81q8RxgHqzk8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thH4M8Czrtnh1WaDJOoq40BdIKQ+u3MlE1FTRz8Ft/0=;
 b=p5BhjMXWmcWX8m6KlPedO+JViscY3eXlAGxyB5Wpt6HRAJGf3KHO3vZTp6II73MrlP/RvGLBOAp4Xy3fcqjxpLqxkWhDvuXbv2wM02j3d2to+Tgc1Jen/5dMGakQ5bIRyLT8xAvK2zYaxVnmw6TUyrv3b54DkSFw1HTd0JKKS03ibeZWvbRsOQFW1hk0x505i7jo+aMpZ8bGNRGH5R+EMhU10DRT+uRv/S7hkl8ZIvjRU1TBl0yKTTF7Wu4M/CLPvtNOXWPTOk5NZZ5zUWMkckZIolhBKgNo1gSHNoMzW2tbe9w5Me4yIhbzuaA3qzGW27WGZjtE4ZO0qA1tDbRGaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 19:02:30 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 19:02:29 +0000
Date: Mon, 17 Aug 2026 21:02:26 +0200
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
Subject: Re: [PATCH 14/17] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <aoNawphy4OVGU4ex@gpd4>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-15-arighi@nvidia.com>
 <aoJ5q7HbSUOxlC1H@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoJ5q7HbSUOxlC1H@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ae9909-0a9e-4272-7edb-08defc9215e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|6133799003|18002099003|22082099003|3023799007|56012099006|10067099003|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	GA01CKgEs2dFlPTqkv+KXO1qNYgv3/30OX0Tb10tx3fvjgryyY56+FshSATmuoSjw0RpdkfWrLM1h1OOmEaHlbEGnF3mTt2oyLDXgS6D/MFeQbsUWf7zj0aczJrK8cb2KwJkiYuUqzeO5Dtms9Cnj4wU8qKBu5oGcvlT3NQ8sNBczwEJV/F1I5ayOvE5vb2Z5bByDeJSq92MhmPcYewyRXxnDBF9i0R+p1AdDpJbe+3nmscPXPAr0JFZ6fZr7I3hjEHDPL0uZLmPdmMvRtklHtDDFzTODkUDxSAbbwV5IfJOyAubg86NDh9N4KTaX6+miDAzD1G88Se09iKHYNZLxHtuyV9Hoebpz7UYZv8yS78Nt2/vkFQZ7gBjvdp2u5Ssk2G3wSGnyHdBHEOMI1KsP0ikoi1yiMoKfAkeAVFb/SodcpmNXTTGwp46Bidyzmf5idrl2yurVpT29dG22RnVpl3c9+8XSIt5olF2LtDvlJjzvldH4qHNy5vAFaDEGYK18caTk7x/3frMWhGsc9VPEhwZz8xQliYRP3FTbnwrtQeq0BIkpk0+jHDYEDv+GN3OYVNh0S4MHHNQXU5Y4pesfGYZTNf/miPz8rqvtWGDDmnev2L6L7Ey0redA62H9LJImF5UJ12Wt/x74XY+bYgHYa55kLK3UmWIs8NkBsE4Ow8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5WHAif7/t9B5J89g6vqSu6xBO7/g8RJC8UpOZQ1+6i9puZ/l8trD1FEFSLsn?=
 =?us-ascii?Q?kdSzbVMC8mk4FUhycVl5LDOyi7yTPnB9QYm5awS71E/l353Ytv17fzegQRo7?=
 =?us-ascii?Q?yNyon9GRDjN5vaiygTOGn5bpTQdX1kk3KKi6M4qbluUnX2ek1cNO3W5plSfJ?=
 =?us-ascii?Q?wgUhgaDhPetoYVehRGNIOuWZ6pfnDxHwvrp9mQjMRvbXNJzHfdgTdZ5OzAU6?=
 =?us-ascii?Q?f6+71qPzrEjXy0TMz7lM8b3niSuBuiwb6DxA1TYHObkqbrl+8PgQDtkFrRKK?=
 =?us-ascii?Q?QlIYdDTHDEF0NdvzR6t42SKeeys57FTTYMZuMxg2hGedYOVN1vWx23o557Lz?=
 =?us-ascii?Q?K8VCSS7Nui6Hf075aKN+87QVtUmjpbMrC/nA6ZHPc+kM/GWkzTLyoeajVSig?=
 =?us-ascii?Q?GuCwUmiZ/U2SRwI1IfyMFKO3S0weDTH6YNoNeKrZwcGkE3Sw/J8Cylq59v7Z?=
 =?us-ascii?Q?Jxtg09LV1t2f+HQ/zLPZ7vXxSbS107kpX62yKoCUKERWKEUTwR1g3aD8P40N?=
 =?us-ascii?Q?fG6pb8UHIF5PXtapKgNKu9XY8nELueaU5i3JDlzqvzZVgBAsZ3DfNC8SLl6K?=
 =?us-ascii?Q?bojXEqOydiaKQ46qJ6ZhHIPSZhPYnxTKqajOlHDK9ISxZHN9y3wVXWlwVnhf?=
 =?us-ascii?Q?70Bnsb1+0xSgWcuv58WDdd2l7GtO6ALOD9DoM+NkP2f4Vvt7uAwMqgXVmMRH?=
 =?us-ascii?Q?yL2vqpqIkbR7ezW9UiKEmt/Zp1/HiyDGfw1fFCvzBsaldl+EudI3fWtrJbyR?=
 =?us-ascii?Q?rmKvFO3cVR3I4/RDvqx1SCvJEkxKDhKXejFqbizhhQ+RESlaYicXw1XLo3/j?=
 =?us-ascii?Q?8RKIwioYSzkiOZIXy5mKL5JSPW3J9QMQexQFlDr8ihSZ3ARELUTvJkt1/K1E?=
 =?us-ascii?Q?7ow7ClUTLGbKnhpTVWatgxonhbjPiZRZhcYUnCKNI5irGo5iI2yJMZO2JRTU?=
 =?us-ascii?Q?loP9+PSl6Ckg0fnPs9+4szA9X4HssuObP0zf1REd2brue4WX30SYKWj4GKFZ?=
 =?us-ascii?Q?umlSPch8BaTnzKW7VOTdinQcGVQJ8zHt1nfJ2t8Fx0fvVYXkLQvRCY5ZUmZA?=
 =?us-ascii?Q?xUwNhFOF29SeSFtjPFpYlCXUSotF/TUJnCKcyzlXp4cshAnzsT+IgGIktTLG?=
 =?us-ascii?Q?+OB2wRg4M8IJR+PnrElMIr8XZP+/QF2lVIfMXBArZOXY7Ss7F8lmtuSrMWh9?=
 =?us-ascii?Q?pPNSWDu4aUtUiwPz6uDYho1I2wbt/HSfW/wHrmE7TVpPaYVcmajVDmWmx3TS?=
 =?us-ascii?Q?eJEiZCuwTSyos9CHs+dQChL9V/B5pGCGRU9VJ0U9k4tdZ8XWv6v3tNt5skzN?=
 =?us-ascii?Q?wuTgS1zfWv3ZgdKGQh1WakOfnkflu4IinJpHoeH4Qb1bpIxEN+ZAHxhtoAEx?=
 =?us-ascii?Q?bDJszSwKqBRfW4BCh5CJfOoIsKMvV98KZcWoLN9s5Z3Ck6TqwCWXwDHip8tW?=
 =?us-ascii?Q?NkkB6oZfbkd6fA9/gklHStCpiik877rV5jGh46g9ZK3ubfC15GQUI7UKEWqS?=
 =?us-ascii?Q?ODUyFOjHJCqaCjLW/hyArBChzCTYe7Mrmx2Lhct481tghoLFiPXPOhrtBHK7?=
 =?us-ascii?Q?wOsERVsTfmhAQBnC2DHtjUqqfBMaS/qWJvGDCHNwnkd5Pk50Xfgzw3W7UBTS?=
 =?us-ascii?Q?WyTKIYzIrbdeSGdp2cp2uTMUgVm1HlcxLGMvCa7QaCgLJIizvvmFnxVxmSNK?=
 =?us-ascii?Q?E0QjI5nYfqX9HLUhdc+ENKS3qvFtyj2WViPjxO3YHEuJ8DexUmg27heACFBy?=
 =?us-ascii?Q?Mc4IPFEuXQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ae9909-0a9e-4272-7edb-08defc9215e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 19:02:29.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqzaLSDl9ZNFxVX9jLNb17BbA2OB3UgB1E+j+7jSqQKofQma0s/3wxUu8Yx7plBvsdzGiMzPX+NdGyu3fxL8iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123

Hi Tejun,

On Sun, Aug 16, 2026 at 05:02:03PM -1000, Tejun Heo wrote:
> On Sun, Aug 16, 2026 at 07:35:12PM +0200, Andrea Righi wrote:
> >  bool scx_allow_proxy_exec(const struct task_struct *p)
> >  {
> > -	return p->sched_class != &ext_sched_class;
> > +	struct scx_sched *sch;
> > +
> > +	if (p->sched_class != &ext_sched_class)
> > +		return true;
> > +
> > +	/*
> > +	 * scx_enabled() may change while __schedule() holds only @p's rq lock.
> > +	 * Once @p is associated with a scheduler, use that scheduler's policy
> > +	 * even while the global enable state is transitioning.
> > +	 */
> 
> I'm not sure this comment is necessary. scx_task_sched() is stable while
> holding the task's rq lock.

That's right, the comment is unnecessary, I'll remove it.

> 
> > @@ -2059,19 +2086,25 @@ void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> >  	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
> >  		goto direct;
> >  
> > +	enq_blocked = (sch->ops.flags & SCX_OPS_ENQ_BLOCKED) &&
> > +		      p->is_blocked && !(enq_flags & SCX_ENQ_WAKEUP);
> 
> Why not just test directly in the if statement? It's not like the test
> result is used anywhere else. Is the intention giving the test result an
> intuitive name? I guess is_blocked && WAKEUP is the condition is the donor
> gaining execution back? Might be worthwhile to add a comment.

Right, the local var was only intended to give the condition a name. I'll inline
it and add a comment explaining the WAKEUP exclusion.

> 
> > +	if (enq_blocked) {
> > +		enq_flags |= SCX_ENQ_BLOCKED;
> > +	} else {
> > +		/* see %SCX_OPS_ENQ_EXITING */
> > +		if (!(sch->ops.flags & SCX_OPS_ENQ_EXITING) &&
> > +		    unlikely(p->flags & PF_EXITING)) {
> 
> While at it, can you swap the order? This is ordered this way because OPS
> testing used to be static_key but now that these are regular tests, it makes
> more sense to test the unlikely one first, or maybe that belongs in a
> separate patch.

Ack. I'll test PF_EXITING first. Since this patch already moves that condition
to handle blocked-donor admission ahead of it, maybe we can fold this into the
same patch.

> 
> > @@ -2183,8 +2216,17 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
> >  	int sticky_cpu = p->scx.sticky_cpu;
> >  	u64 enq_flags = core_enq_flags | rq->scx.remote_activate_enq_flags;
> >  
> > -	if (enq_flags & ENQUEUE_WAKEUP)
> > +	/*
> > +	 * p->is_blocked is cleared after wakeup_preempt(), so remember whether
> > +	 * this is a full wakeup activation. If wakeup_preempt_scx() isn't called,
> > +	 * set_next_task_scx() or a subsequent non-wakeup enqueue clears the flag.
> > +	 */
> 
> I can't make heads or tails of this comment. This doesn't seem to explain
> what TASK_ENQ_WAKEUP is used for but just goes into how it's managed.

The distinction it was trying to carry is between a retained on-rq donor wakeup,
which reaches wakeup_preempt_scx() through ttwu_runnable() without another
ops.enqueue() and a full wakeup activation, which has already enqueued the task.

We can remove SCX_TASK_ENQ_WAKEUP, pass WF_ON_RQ directly from ttwu_runnable()
and replace the old lifecycle comment with one next to the check explaining that
WF_ON_RQ identifies the no-enqueue path, which needs resched_curr(), so that BPF
can reconsider the task after is_blocked is cleared.

> 
> > +	if (enq_flags & ENQUEUE_WAKEUP) {
> >  		rq->scx.flags |= SCX_RQ_IN_WAKEUP;
> > +		p->scx.flags |= SCX_TASK_ENQ_WAKEUP;
> > +	} else {
> > +		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
> > +	}
> >  
> >  	/*
> >  	 * Restoring the current scheduling context will be immediately followed
> > @@ -2399,10 +2441,30 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
> >  	/*
> >  	 * Preemption between SCX tasks is implemented by resetting the victim
> >  	 * task's slice to 0 and triggering reschedule on the target CPU.
> > -	 * Nothing to do.
> > +	 *
> > +	 * A mutex waiter can remain on-rq as a proxy donor while logically
> > +	 * blocked. If it wakes without having been proxy-migrated,
> > +	 * ttwu_runnable() calls here without another enqueue_task_scx(). Request
> > +	 * rescheduling so that ops.dispatch() can reconsider the task after
> > +	 * ttwu_runnable() clears is_blocked.
> > +	 *
> > +	 * A proxy-migrated donor instead returns through the full activation
> > +	 * path, which calls enqueue_task_scx() before arriving here.
> > +	 * SCX_TASK_ENQ_WAKEUP records that the enqueue already happened and an
> > +	 * additional reschedule isn't needed.
> >  	 */
> > -	if (p->sched_class == &ext_sched_class)
> > +	if (p->sched_class == &ext_sched_class) {
> > +		bool enq_wakeup = p->scx.flags & SCX_TASK_ENQ_WAKEUP;
> 
> Ditto with bouncing test result.
> 
> > +
> > +		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
> 
> I'm not a big fan of SCX_TASK_ENQ_WAKEUP. This is a roundabout way to detect
> owner -> donor case, right? Doesn't the caller already know? If so, can't it
> just pass in that as a wake_flag?

Ok, as mentioned earlier we can pass WF_ON_RQ to wakeup_preempt_scx() to
distinguish the two cases.

> 
> > +		if (!enq_wakeup && p->is_blocked) {
> > +			struct scx_sched *sch = scx_task_sched(p);
> > +
> > +			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
> > +				resched_curr(rq);
> > +		}
> 
> It'd nice if we can gate the above behind proxy enabled.

Ack.

> 
> > @@ -2517,6 +2579,20 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
> >  
> >  	WARN_ON_ONCE(task_cpu(p) == cpu);
> >  
> > +	/*
> > +	 * A blocked donor may be moved normally to select a new callback rq.
> 
> What's "callback" rq?

Poor terminology... I meant the rq associated with the donor before proxy
execution moved its scheduling context. I'll rephrase this.

> 
> > +	 * set_task_cpu() updates wake_cpu and makes the destination rq its new
> > +	 * callback home.
> > +	 *
> > +	 * proxy_set_task_cpu() instead preserves wake_cpu when moving a donor to
> > +	 * its lock owner's CPU. Keep such a donor on the proxy rq until it wakes;
> > +	 * otherwise normal BPF placement may repeatedly pull it back to its
> > +	 * callback rq only for proxy execution to move it to the owner again.
> > +	 */
> > +	if (sched_proxy_exec() && p->is_blocked &&
> > +	    task_cpu(p) != p->wake_cpu)
> 
> No need for line break. Can you elaborate the scenario this scenario is
> needed for? Is this the exact condition? Let's say a donor is running the
> owner on the same CPU, so task_cpu(p) == p->wake_cpu. Wouldn't you still
> want to block scx from moving it to another CPU? What am I missing?

The condition is intended to identify a completed proxy migration, not all
blocked donors.

For example, suppose BPF places donor D on CPU0 while its mutex owner O runs on
CPU1, proxy-exec moves D to CPU1 (its scheduling context) using
proxy_set_task_cpu(), which preserves D->wake_cpu == CPU0.

Then we have:
 - task_cpu(D) = CPU1
 - wake_cpu(D) = CPU0

If D is subsequently put on a shared DSQ, then it could be consumed by CPU0 and
move it back, only for proxy execution to move it to CPU1 again. The check
prevents that ping-pong while D remains blocked.

In the same-CPU case, while D is actively proxy-running O on CPU0, D is
rq->donor and has already been removed from its DSQ, so another CPU cannot
consume and move it. A remote-transfer race is also rejected by
task_proxy_move_active (aka task_proxy_running_or_donating() after the rename).

If D is later preempted and re-enqueued while still blocked, it is no longer
active and BPF may place it elsewhere. Suppose BPF moves it to CPU1. The normal
migration updates both task_cpu(D) and wake_cpu(D) to CPU1. When CPU1 selects D,
proxy execution finds O on CPU0 and moves D's scheduling context back to CPU0
while preserving wake_cpu(D) == CPU1. The resulting mismatch then prevents
further BPF-directed moves while D remains blocked.

So there are 3 cases:
 - task_proxy_move_active() prevents moving a donor that is currently running or
   donating,
 - task_cpu(D) != D->wake_cpu prevents moving an inactive donor whose scheduling
   context has already been moved to its owner's CPU by proxy exec,
 - an inactive donor that has not yet been proxy-migrated remains under BPF
   placement control.

Thanks,
-Andrea
