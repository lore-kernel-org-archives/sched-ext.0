Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92D3B42C1
	for <sched-ext@lists.linux.dev>; Thu,  6 Aug 2026 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996630; cv=fail; b=rJzXHFpgoocg8Gt/L8uexIWYm2SrjPk639DlQWxnnPz6WVUNv2OZ0XqQZqLkP+U3Ci733F1hvc8klBJaB9jGjBHuz1OA+hoYh4Mm1FSl98PwAHe990LQgMK+qP1aGuBerwJx5IwQKVd4FxGiS6Rr+1XvD2T9INdWYC2Yx1WIEKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996630; c=relaxed/simple;
	bh=QDbB37qKFQn+NdGu28W/MlO9aa4LUqbjIphiT3EG1Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e2CjQaXv22BWpK6VCk1+0OGoqixSSd5m6zs7tF3jrp8ibYbKfmrRNYgXOIciUFBnYsnD4YNsvqjTzT9CvO0i6GZKMmO0ZdWRMI+JqZMMI8DzNKh4LGCAykymM6vlMUADrgGxtNGhmHXxFkGPmN9t/sMIvo2eKuF+4YMYKnT/uOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SsuFTtcR; arc=fail smtp.client-ip=52.101.52.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SsuFTtcR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbaZKur5d2wu0hZMtfI3b2rEaZUI0cGvy30B6YY4NZZHaUXk3n6D4CMwu3QXNm3c1UDpdAHHLlIvRJGTIaH1Y7SAy76hBVuVR4w2TdjPwNQ9KPreoOBb89kB5uFNhiWDo5Y7rFUHBmExaHNfQPbFUfA8gxG9VP5e3t628BrnEuHgp8e/mHwNxggBBrUDUVe4YnFGYe+MCzXu6HQz2TdsztLM6HP8K42kGYNhGkAklAk2lZA8B+L9/wR/Xzay2NBNzly/yRxS1jK4tzUxO3wFaDcmjgGozZtAFKEB+CC6LiERHivXQSlunqksS/RNhzDnrijJq5gWArF/wjVROllZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSnui2ZG3g11AeuJLyUXy77Tiz/TjZC2g7o+jjTtkBo=;
 b=RHVDhlQBYDikpK31L5a00FDumVOeSntIDDTq3ecIiZOaHI/itzCz0oUWM1crUHF3CQbX5ANiqTQZ/zHwFd2QnMxwl5CKoEK/4kLjwpg96bwboW/FmJ4dSGWtAvIHGCaaU/GVBKGRosxk1OTaLPANAVk3/wiBzHouG5/HzpmhqNGTURmO71wCXohuF5lhMRsb3FE2MlLQOssfFyjWjelLZfoJQeDb6LhRwhjq5zm2fBPnwOLeFpBwWHIVlsd++a/V4EC4E0YDdM2BeY0ywD5T8u6s5JsR9SDU+phvsOYDodTMGzh9GUOqJb6VHqcUrIXqBthBmVm3cdtz2RVdAhsWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSnui2ZG3g11AeuJLyUXy77Tiz/TjZC2g7o+jjTtkBo=;
 b=SsuFTtcR7YxNYc44SMWLoPoGYL0OrrW2OZehu4plzSWH562KQr2x8tM3L2A51+OUqgwuUwhcw0gEMAhUgNXgzFgdkLLH4CHUXW7S3fYntXv3pa4SNziLterR0zQEQ12JK0JodzuJvjNcFcdtrV228iJlzfpDuxt9VSA8Jt9bR/6BCY6e7181CwfGW6HbPQzrf2yAplZJKjo2JLlN2N2jIhGL7nu6F2NdEFT+qbpTlxohlptGcBsCNuVgQ9L6cGzgscydVJ8tyhhStOG4NLcRdqV2w1SrTZr10/fJ3iYdi1EZnlLDJ285rHBp5oGYpBAYS6Ft7lD94gJhAAmXQDjUcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 06:10:20 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.016; Thu, 6 Aug 2026
 06:10:20 +0000
Date: Thu, 6 Aug 2026 08:10:09 +0200
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
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <anQlQUOj4PO7XEvy@gpd4>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-13-arighi@nvidia.com>
 <anETyb93XUqBau6Y@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anETyb93XUqBau6Y@slm.duckdns.org>
X-ClientProxiedBy: MI2PEPF00000B81.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::418) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: ea802f15-5549-4b4e-310e-08def381647f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|5023799004|11063799006|56012099006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	xBiJKk0q9lSU4UCZMjHWpFp3FeAHezP4H+k2i03sg1mduFWwZ4yH0kbtkD+N/EQ+FHrGF2VghDOiT6d/S7ftT6t4J5YYiAr0KUHVX8UyRhX+GB3bd1P6dxR90Egohi8OwavWFZJPlFzq3o9oPOl4jC65giyB63/OfYbuR5jSpGC6UbNC3jiNmW0cguWZRtvNKesqJX3KNhpBwDbIRu5Im/piDP31eZaODeg2OO9KqvcIs4gJIuq4a7rgTXM4ZE+l1o/O16y3g5g/YnoutsHcvQgU3juhAkTUHapPSI1frNhV3me5M/gbcBZwgpo7y0FSBVGiG5fx7gnARJMNpIX+Torh1hZAdXLAC6DcBFFxjfNqTQEi8mwXfr78SFhdoR74wWtjTtn13eyrn+wRXiJD/fRfRsJ/pUjChaP/xf5UCBnqyW14Bm0fnzSuGssUI8VjX34NA/DyR2+wYdJEoJcK5jf0BVV1SHyq3zWs2w2uuNVcK3J63nKif+ffoI5XQvylZY0zomTFM4ppz+x6sHvz3GzSw2gNfVOVO/Q3WwLxKZ8kS/wViPISFx1WbvyeCMnu4FEanEygdx+Dt3jt4hh1wdmZUpS33OJm9TlUOpsGPwW/w59V2kDazTgVJ84czLp3RhZZ+dAoQsHXz9wQgMPXRBSDZsLNOGJxhgbAd387NmI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2mYKu6GxjlJGVIJlwYuBME/anfDOvgteqXXjrmHN2ZiNKpWxEl3ZbCvMo9Vd?=
 =?us-ascii?Q?fqvmktPZX1EQiupG3714Vz1s8iuZt0Rvc8IdCrJSRREOTIygBsSe00cMa+XI?=
 =?us-ascii?Q?JdDOLLn2JPBQfllieXqU2Zzg+jlj0j++Ec43r0JESnhi6Dpru1siEAPEzxcv?=
 =?us-ascii?Q?qDQl4dzUjHE8fzAHuXAikpXAnfGrFWvSCEUYP4s038xh/lHmysJEmxodGaUd?=
 =?us-ascii?Q?eUqj1LcbeUTv+B4kxGmNr8a5m7eMD2DmpGmP42NqSx6YRQAiBATvB41VvrVK?=
 =?us-ascii?Q?GxXqqEZ8bOu24hGLirmjZa8oHJKkfrRucXarEcKQhXVmFjBpAASvEnfOkK5i?=
 =?us-ascii?Q?q7kiJ2Amx9nLCH/zuecBlequLCVMI+ARHSokkrmL0TrcmWOmG4PYxj2VJ/l2?=
 =?us-ascii?Q?yveDK2uba5Wbf0xB6NJ7jWbvG0pWLv9X2PWjsnW/XXaggexthfhVKE2yBZe5?=
 =?us-ascii?Q?VGkdbdrBkoDx8EqeObo+oX1vnJBLJRR67rihEdS1eneVcJMpiK55y1KJgNnR?=
 =?us-ascii?Q?hphVATLuNOxx6ljOv1+LTNrixxoz9QzKUOd7iaIlJ+H/UxJ0yUlFN1iEXowE?=
 =?us-ascii?Q?q3phXFkMZpseA2XSQTGNq3rdyAIjBY/SdmVj+ngoda6yImyLyu5VRNnO10pV?=
 =?us-ascii?Q?Wmt+QR+ONWuw4G1q2JkGW6HyS0vsP6RTgLeTZy3cy4qlxkcgVzIQ8Ju1oXfy?=
 =?us-ascii?Q?r4N89OoQ2tKS7CAPpcC/k74AQ5jrEPBGjkkSk+oKtoBpZgcJoV0TuGSSwPBy?=
 =?us-ascii?Q?RdR0VrrJfIVP5yPmiOt5XI6CN9mCEUDd29bdaGinsdCj7rVPfrnDKDkxJWZW?=
 =?us-ascii?Q?LKZA2Pj4ksTdr/yb9gXa1MsvY8/3XchMOOyTFm0itstRTbaZV1h+nxBjDsIc?=
 =?us-ascii?Q?kUeIVLRpXQ4J/fDy0fVIciYZ8jUfwawonylVAcDItoGrkwWWIfiS+hbxDQhx?=
 =?us-ascii?Q?h6sV9xsdjWADJj0prElIm6Yte5v5VdrfjN9shlKtHzA/0ki8g4J2BXE3/T9F?=
 =?us-ascii?Q?I+rKx+FZyU3lBwnrYPBqX5RFLjWw6G153BysKcm/3Xt6zayPOzoXAY9fT4Uy?=
 =?us-ascii?Q?MyVGnhSY1Eb2ZO34zsV5+D3frZozDN2xuG9+TR53B4Cuter+dVZC9a/m+21k?=
 =?us-ascii?Q?GT4Qk2WPtKXb+9VTtM0k6bHg4ZyeiBHctTIlWTxxkYbPX5HXz9hIxPiM2aLs?=
 =?us-ascii?Q?gyPqeKtGdXQirj6tSNL/Bqj8psiJrQ/rNUYhFdkKVsdjvU8HAfmRfFibn6Ns?=
 =?us-ascii?Q?sDeCQlY70Z0vh4AsfVZyrBkHZIsbJ5xFCJh12+QpvxE8uEQcagYB17Z/ch03?=
 =?us-ascii?Q?6sCzHFhhDkZCgWkVWN/4DHiDq+4WtA5ShY7nVn/mU8hExUCXw+/p93RFeevX?=
 =?us-ascii?Q?+2hN3LkhYu2Hrj5u0wVcKg9T88vWX183iPRUku/XxxYzV9I/3T0lRgjaUgu6?=
 =?us-ascii?Q?NzAv7nruBpC2evEK6XShcWKFD73ejHIeajUxOAf9/5979FpRex0nowq6VoNz?=
 =?us-ascii?Q?A/Gqp80GrraA7jNz1aLNrZs1ghJEFFY028i1jp3ry4RjdLXet4oUA7LamI+e?=
 =?us-ascii?Q?sYdt+K5sGuTdY2sGLT+ddPV1/MmdhgqJlPJ/bRdNgIo3UtQF/xmoz4sZzQHp?=
 =?us-ascii?Q?hhWdMuB9y5tnlvhFjX+FjMXzeDm2Faz/9j7OZ04QoxwqX4kTpjdyCjtUcLtN?=
 =?us-ascii?Q?z8IRtZA35TGQPUoY+luxtPH010wzPyki6hOZZO3Ub3rPKkyIBPva2A6D8KG/?=
 =?us-ascii?Q?8Ax2IdYJYA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea802f15-5549-4b4e-310e-08def381647f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 06:10:20.2015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Etx7VIy2PaKE1QLSZ3uoxk0Fa7c32Oy0YMo8UNyJ/ryhTjy1Hz7QqQQZylpL7xOfACoFxOreCs2MFyFFG36nIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990

Hi Tejun,

On Mon, Aug 03, 2026 at 12:18:49PM -1000, Tejun Heo wrote:
> On Tue, Jul 28, 2026 at 05:43:30PM +0200, Andrea Righi wrote:
> ...
> > +/*
> > + * Called with @p's pi and rq locks held immediately before
> > + * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
> > + * is updated only once.
> > + */
> > +void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sched *sch)
> > +{
> > +	lockdep_assert_held(&p->pi_lock);
> > +	lockdep_assert_rq_held(task_rq(p));
> > +
> > +	update_rq_clock(task_rq(p));
> > +
> > +	/* Block retained donors that the incoming scheduler cannot manage. */
> > +	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
> > +		sched_proxy_block_task(task_rq(p), p);
> >  }
> 
> What are the cases that this one catches that scx_allow_proxy_exec() or
> prepare_switch_scx() doesn't?

scx_allow_proxy_exec() controls whether a task is retained when it first blocks
in __schedule(), it doesn't handle a donor that was already retained before its
scheduler ownership changes.

prepare_switch_scx() handles a scheduling-class transition into EXT, but it
isn't called for an EXT-to-EXT scheduler change. The helper was intended to
cover these same-class transitions, i.e., moving between parent and child
sub-schedulers.

Thinking more about this, retained proxy execution can be terminated on all
class changes centrally in sched_change_begin(). In this way we can remove the
.prepare_switch() class callback and prepare_switch_scx(). We would still need
to terminate retained proxy execution explicitly for EXT-to-EXT scheduler
ownership changes, but that shouldn't be an issue. I'll test this approach, it
should simplify the transition handling considerably.

> 
> > @@ -2299,11 +2351,24 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
> >  {
> >  	/*
> >  	 * Preemption between SCX tasks is implemented by resetting the victim
> > -	 * task's slice to 0 and triggering reschedule on the target CPU.
> > -	 * Nothing to do.
> > +	 * task's slice to 0 and triggering reschedule on the target CPU. A
> > +	 * mutex-blocked task is kept queued for proxy execution, so its wakeup
> > +	 * doesn't go through enqueue_task_scx(). If the BPF scheduler manages
> > +	 * blocked donors, reschedule explicitly so that it can reconsider a
> > +	 * donor it declined to dispatch while blocked.
> 
> Can you make this a separate paragraph and is the comment uptodate? I'm
> having a difficulty understanding what "if the BPF scheduler manages blocked
> donors" mean.

"manages blocked donors" means the BPF scheduler sets SCX_OPS_ENQ_BLOCKED. I'll
split the comment and clarify it.

> 
> >  	 */
> > -	if (p->sched_class == &ext_sched_class)
> > +	if (p->sched_class == &ext_sched_class) {
> > +		bool enq_wakeup = p->scx.flags & SCX_TASK_ENQ_WAKEUP;
> > +
> > +		p->scx.flags &= ~SCX_TASK_ENQ_WAKEUP;
> > +		if (!enq_wakeup && p->is_blocked) {
> > +			struct scx_sched *sch = scx_task_sched(p);
> > +
> > +			if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
> > +				resched_curr(rq);
> > +		}
> >  		return;
> > +	}
> 
> My understanding of what happens here is hazy. I suppose this is for the
> case of an active proxy execution being preempted by another SCX task? I'm
> not following why resched_curr() is needed here.

The relevant case is a mutex waiter receiving a wakeup while it's retained on
the rq as a proxy donor. Although the task is basically blocked and cannot
execute itself, its scheduling context remains on the rq, so that the mutex
owner can execute through it.

There are two wakeup paths when the mutex is released:

 1) If the donor was not proxy-migrated and is still on its callback rq,
    ttwu_runnable() handles the wakeup while the task remains on the rq. It
    calls wakeup_preempt() and then clears p->is_blocked, without calling
    enqueue_task_scx(). BPF doesn't receive any new ops.enqueue() notification.
    resched_curr() requests another scheduling cycle so that ops.dispatch() can
    reconsider the now-unblocked task (BPF scheduler may have kept the blocked
    donor in a BPF-managed queue).

 2) If the donor was proxy-migrated to the owner's rq, proxy_needs_return()
    removes it from that rq and the wakeup proceeds through the full activation
    path. That path calls enqueue_task_scx() before wakeup_preempt().
    SCX_TASK_ENQ_WAKEUP records that this enqueue already happened, preventing
    the additional resched_curr().

> 
> > @@ -3198,6 +3279,37 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
> >  	if (p->scx.flags & SCX_TASK_QUEUED) {
> >  		set_task_runnable(rq, p);
> >  
> > +		/*
> > +		 * The rq lock has remained held since scx_allow_proxy_exec(), so
> > +		 * @p's scheduler association cannot have changed. An associated
> > +		 * donor stays queued only when its BPF scheduler enables
> > +		 * %SCX_OPS_ENQ_BLOCKED; delegate its admission to that scheduler.
> > +		 *
> > +		 * If @sch is NULL, @p is transitioning into the root scheduler. The
> > +		 * root is published before tasks enter EXT and cannot be cleared while
> > +		 * this rq is locked. Preserve generic proxy execution by placing the
> > +		 * donor directly on the local DSQ.
> > +		 */
> > +		if (p->is_blocked) {
> > +			/*
> > +			 * If the donor is the same and only the mutex owner
> > +			 * changes, avoid triggering another ops.enqueue(): the
> > +			 * BPF scheduler has already admitted the donor, so it
> > +			 * can continue running.
> > +			 */
> > +			if (next == p)
> > +				goto switch_class;
> > +
> > +			if (sch) {
> > +				WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED));
> > +				scx_do_enqueue_task(rq, p, 0, -1);
> > +			} else {
> > +				scx_dispatch_enqueue(scx_root, rq, &rq->scx.local_dsq,
> > +						     p, 0);
> 
> Does this else arm actually happen? Can you describe the scenario? Oh, maybe
> below is the counterpart.

Right, this was intended for the root-enable transition where a task could
already be on the EXT class but not yet have an associated BPF scheduler. In
that window scx_allow_proxy_exec() permits generic proxy execution and sch can
be NULL.

IF we call sched_proxy_block_task() unconditionally, root enable will block any
retained donor before establishing the new scheduler ownership, so the
NULL-scheduler fallback is then unnecessary and we can remove it.

> 
> > @@ -7758,6 +7875,10 @@ static void scx_root_enable_workfn(struct kthread_work *work)
> >  
> >  		if (old_class != new_class)
> >  			queue_flags |= DEQUEUE_CLASS;
> > +		if (old_class == new_class && new_class == &ext_sched_class) {
> > +			scx_prepare_task_sched_change(p, sch);
> > +			queue_flags |= DEQUEUE_NOCLOCK;
> > +		}
> 
> I'd appreciate if there's more explanation of what happens during enable.
> Wouldn't it be simpler if we just do sched_proxy_block_task() on all
> transitions and start with a clean slate?

Agreed. I'll change the logic so that a proxy session never survives a
scheduling-class or BPF-scheduler ownership transition.

For scheduling-class changes, we can call sched_proxy_block_task() centrally
from sched_change_begin(), this makes the new .prepare_switch() sched-class
callback and prepare_switch_scx() unnecessary.

Thanks,
-Andrea
