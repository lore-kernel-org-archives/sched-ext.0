Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1DA2E7F39
	for <sched-ext@lists.linux.dev>; Fri, 17 Jul 2026 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268246; cv=fail; b=WpVT2orMmOYDyakIXU9hh/tmmM8bVtTqSdA7sm9aIfrkXH/Cm3Ul7Gt3EY9rrYV57V20KJZbkDPBqx5oz26AWAnDFtQOju1n9H5HbU5n9nSIDMUbEC5APRjrK1GGxljcEFybeUScg8CIRqQKxFTT9UmmkY5QmUoig6/eDzaaP7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268246; c=relaxed/simple;
	bh=pP4X0Mlh87RwG+wji/wD+sGUrMxBlYzDROxrcFrYCx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UBT68T29ycpNLADa7iXLqSE9NLMpAUwZnXWfxOy/3BwoMVJcmmU6LJ8uQfpq9PEeDcT1cFqKSpIbfsBY12wb3qnDJeBh7mulq4ra73VTDauhzonDy2I8NTEwhO10WjLKnuURpCM165P4G2ZYePzpyC/qP6sKXwKXO2L2TthrXMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V9BIn3vi; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V9BIn3vi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4Rbv7kmjr3Y4CK9C/hlnTrrWAqOWdVWf6z/gjqDd7IkXwivH3vBJrZ0XbluENZLAmir+O9gd66T+eHgAPSGcrE1qxpu6VrLc3qem/u1SaUvC2/NeW8YkSKW2hLrp+zJrpk0XGXTEeG64ml7EI36hu0Ke/LvcAlKlsCgMLK0fWmzH81UJxRhX+yqvuXX115iBRw6dVgmaMpPeNMZ7HDUcmDzqeP/cJZDvSniGTDcHflJ4hcqa+g/fBZrbMtfQjZ9YibnAa3bBB36mx80Wjdsq/KWt5Q9gXkd4WgqsPWE0brUdxTRaO4uCuxuRHDMV0ezp+/zhDJFox0AcZC6qHMtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0lyX/HfuJpjLxQQmFglI8xZ+T9/tW2wLR4a11fRLx4=;
 b=t+rIGhlMPSxq3ce0xHjgMz2eGFhybtSE/EOEkNjtoJxldo5gja7fpIr/Gu+gBZEmcSHUtVx7Dx33XSv8Llx393AtRWZyD3aA/xoHoYsWSK16pw7oW9iSo2pLuh7dahaLHsiFTgU+sEsf8sDyVCncGc0WfdhE4eaDxyGZN1I30LHLuUT6fn1ytKac42NMCCwQ/d4GRS0ZTMbw2g3OO2+6Z3YokdxrZm2JWFRMiIuswpoPhHZ5ILPaOrGf3DkCoJ1OpWy9ZPxw9/SVjMoT2uKVfJ20FV+JImr9C7fG8OvP3h5Kr4d3GLZ0f1xNsx+FK5qj0LOCrzqKHnJXRfz8yUeDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0lyX/HfuJpjLxQQmFglI8xZ+T9/tW2wLR4a11fRLx4=;
 b=V9BIn3vigKYDIWHC7EYR3Cvba9V/KhX3WlpxhXIvXwgJ247cBLLuGRQ/IxoLt9PGApFpNjiUar1QKSq9ZkZPoP2npZ5wUaMHFG8mbDMQP8XnL0yw6QqLT3cqfvCj+npOL8Is2XZyu8tpgeowj99STKm/d8jcgOjoJdVm+TPEQBpAwVpWPwCsmEwg2yv5H0OWvYwlsK1wkoGKbCgtc2CEsXS1oLSGwN04EC1e2uN8HmLrIe7ghYnPeqQLjADLG6pxBRQ9I3yHwz/HWN/hrcx3bSGLWuEOsLFkH69bt7HSU/yNRnL9xJ0y12iOBDNEPw3vUFPPcbgTNUrtx77U1DLBfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 06:04:00 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 06:04:00 +0000
Date: Fri, 17 Jul 2026 08:03:48 +0200
From: Andrea Righi <arighi@nvidia.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] sched: Add helper to block retained proxy donors
Message-ID: <alnFxEGv18LjdIJM@gpd4>
References: <20260715205622.276220-1-arighi@nvidia.com>
 <20260715205622.276220-3-arighi@nvidia.com>
 <e6dabae1-05e5-4e42-86a1-fbf8fe71b801@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6dabae1-05e5-4e42-86a1-fbf8fe71b801@amd.com>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 174db8b4-a52b-4679-d43b-08dee3c931d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1hOpkegO42AjVfzTcVwhCz8VhrXkqas1gdJ6QnPbcgntc+sZTb2bsLOMVhlfb15nXPei36eRGMxQ2zFSsdWiCH+EZbVo6m+z4fwA5BueGUo6h5BYQBbsoe9xqjVttep5nwPWKvRwx3OhbC/b5mzZkcUrz5J69kC/uDlp0ORZ8fKfNjVGkC3nu8fVEn8PehElvqQsl+Q0tkQwyswPCAok3K05ODpg1VuA0ibN/DRNY5OJCe8C1/TAgfNis6rqK7/nC0KvMfuCem1vWvIFljS44x3t3OwR2Z6A9O+1jVkSbGHAmRwJK4oC/98uHAR3y0jKheZOHErSA3FrSf7QOs6pxvaeb9KEMc62I4A3bO27W2Stpi7Ta5OjHgAtYVIuZvvVCuCV64spvEv2mjncURRD6HiTnG8/9VaWJ4YL7VwuGkfCd5QGTe5evqVzIaNg/WSYhi8tnh3bjl9wOp8GkH1i+s9A99WJ61eYFIhVbod25iYXi6yVy2t9dSgq12dlimw/F4vsHkT7D+HUsZ/zuutxSoVZRG/DudxkZzJWAl3A33IXy9AdogZMwRlyrSQQz7qZriShHPVgi1VDtF/iajARkaSR3nu5Vj0YYjtA6dvw59z6ZPKalTU2NKrsmsUwFz8/TWxRQRqJfoDTzjrEL0xU8jpiYbLY+OzG5XX02OnugK0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2CbJAFetaVRvuMgdMduP1L1lal8kZ7OUP6jrCr0Gq3POanTW6eriP6k8ZRor?=
 =?us-ascii?Q?TF28vn8nOp7ltKnqh/psf04MFXH6dpYEpIYhxVJhq+2I0m5IaxesKySmciD1?=
 =?us-ascii?Q?8gGB0r+mRIxU5/nhSBusIH071nqmzImunN9s1ruq8k2TuKDNghKsiHrvostz?=
 =?us-ascii?Q?NUoTHwhbZWFdQj/l+WSRUqhlj1N2TBIkJpkkeSuPzVXfe33aqeAIK2go1I2E?=
 =?us-ascii?Q?cSQgeWm82W4GfEhg+FoxHtjfmnnluU3B9ohKF/1xQwMKTq+YS03cHrUJCdp4?=
 =?us-ascii?Q?l6ms8vAiw/9qnDaBzUHFUeasOv5RhYMJxvzRl/i5ukVQf6eB80u+rNgxoqKn?=
 =?us-ascii?Q?vFIllawwL71gsxVxuL517NMj74Dzk8RdGPP3MUCBhJSCDGxk37zvlP7wB9yb?=
 =?us-ascii?Q?SesFW0R4dOGvQ/5hDG9yUtA19Uyf/fIhTJrhn1jox97v/Qh4rpuJsEr7142g?=
 =?us-ascii?Q?8FUNlsrEZ/+Hwha0XYK5gU2GaQ+XrkOwC4hhgG6ZlAkXF0d2h5hglmZZFaSF?=
 =?us-ascii?Q?cCpq90IvG1BlLvxgGp4e/eiJb2kIltUygfmpYws1rSIf8cCXuLe9Ss1FElx7?=
 =?us-ascii?Q?4TOmaWViphW6UKs0Onq1paE55IOjmCN5kE8HgyH5JREJS8ZxyiEazWkbp3f5?=
 =?us-ascii?Q?0iU1cgAzmHX9BOWqwp4GHQs0KatF0r7YqeBM3mnR+4lHvVGBP+zJshXf/hz0?=
 =?us-ascii?Q?gt6W32G2DKCXJvk3Xje4+YfN+o75n8OPmXa4oAGUj/tdldUGeX/xJRCrhYN5?=
 =?us-ascii?Q?AmuElj/ZGwq+61ANnYm00CBRzpTR5Ghbut8tRHjtXkFxw8kuu1b861W7GzyT?=
 =?us-ascii?Q?BRk3Ei6M9FIb6Lchr4DLjfXHvfoqk7m+B5WxcUaB87wGARE0N9DPwuRvc5cD?=
 =?us-ascii?Q?GS3yOsx0NmYOLnn/b0krO3p1/e7QewRf+Y1AIa56NnJR1bgmkrTlN/c3PaFK?=
 =?us-ascii?Q?eA0rO8ZzZtPdQBSWioM8LWvCgdeYFJKJ0f1k4zBwL0XstslEpawRlMv9P7e9?=
 =?us-ascii?Q?HuLQ1hFSwbQTz48VH0yBiIRTt2S1QcAeLamuaeHA1ZzyI1CMhY4ROWp50sbW?=
 =?us-ascii?Q?AAUvmeFz8KcXO3Lue3m3Jq55t81Csm+dtevcwEXvEETVOSIGYPKvZx+t3pvZ?=
 =?us-ascii?Q?/+lbREWZDb7HE2SQJX8mcNAY/TX1avbdEGWzsjQRxT85y0n+xHEUU3kzNyIA?=
 =?us-ascii?Q?XpS6akt5jhC1F6OjxWyq3LwjL7Yz1OTOJHtfl8aj4r9PL9zzLua+4JbkzDdU?=
 =?us-ascii?Q?0tmwir1xu3DuDrKvaZJgBDOyBi4wWOi0v1SA8tTz1HMK/TdsMJzPmrmKBl4g?=
 =?us-ascii?Q?KxXq4qmn3vYt+2vi7hE/owCinGXKH6eNcn+Q8SsC84foOYOS0jr1D721mGzQ?=
 =?us-ascii?Q?s0/3tgbnHEWYoelhu1m983ll2cpyLEbKDMUwOUJD0CVKb2lPuMqil7gu5Gfz?=
 =?us-ascii?Q?Jn425k/MqvjpPPCQxEip/UluF1HVWLasMs4Pajv5y2zxvWK/P0YPPl2n6qHo?=
 =?us-ascii?Q?3pTmWqAHRgzYViv3ZfNfl4jqOHQqHJeo+GALWMkuWXq/LXnp1xxLnDlt8bSf?=
 =?us-ascii?Q?q918QtkJBJYwCbdXGlCoAS41QFdgC5sT8Xk30RpKwaBc29n5PsRJk1lFKvKk?=
 =?us-ascii?Q?Pd0SCc/tY1T00Pxq76K2AbtcCR2KRaGFgvQmCG4fd1/CzpnQEsJW3tjSmVyE?=
 =?us-ascii?Q?lgHWGAQfirANeBqm/25jOwbNYIrakRg4fWaI3KsFoPDWNW4NljVg0avnFb+K?=
 =?us-ascii?Q?yGFrxdLZ9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174db8b4-a52b-4679-d43b-08dee3c931d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 06:03:59.8993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2r6AXi1YiAlMffL8XMsp6etCvoLP+xBPaehbChMKPUHXcQmirD8pK6xhA5YWMQ8EGizZRBKh2COyNBAWoJ++A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597

Hi Prateek,

On Thu, Jul 16, 2026 at 11:17:53PM +0530, K Prateek Nayak wrote:
> Hello Andrea,
> 
> On 7/16/2026 2:24 AM, Andrea Righi wrote:
> > +/*
> > + * Remove a retained proxy donor before changing its scheduler ownership.
> > + * The caller holds p->pi_lock, so p cannot wake and migrate after block_task()
> > + * drops it from the runqueue.
> > + *
> > + * Unlike the regular schedule() path, this must leave @p fully dequeued.
> > + * DELAY_DEQUEUE may keep a blocked fair task queued with sched_delayed set,
> > + * which would let the following sched_change preserve and re-enqueue it under
> > + * the new scheduler. Complete an existing or newly-created delayed dequeue
> > + * before returning.
> > + */
> > +void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
> > +{
> > +	unsigned long state = READ_ONCE(p->__state);
> > +
> > +	lockdep_assert_held(&p->pi_lock);
> > +	lockdep_assert_rq_held(rq);
> > +
> > +	if (!p->is_blocked || !task_on_rq_queued(p))
> > +		return;
> > +	if (WARN_ON_ONCE(state == TASK_RUNNING))
> > +		return;
> > +
> > +	if (task_current_donor(rq, p)) {
> > +		proxy_resched_idle(rq);
> 
> This should be proxy_reset_donor() else the current may try to
> do a sched_yield() with idle as donor and you'll try calling
> idle class' yield which will crash.

Good catch! I'll fix this in the next version.

> 
> > +		/* Kick the execution context if @rq is remote. */
> > +		resched_curr(rq);
> > +	}
> > +
> > +	if (!p->se.sched_delayed)
> > +		block_task(rq, p, state);
> > +	if (p->se.sched_delayed)
> > +		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED |
> > +			     DEQUEUE_NOCLOCK);
> 
> nit.
> 
> This case gets dealt by the sched_change_begin() which happens right
> after scx_prepare_setscheduler(). Do we really need it here?

You're right. All callers immediately follow this with sched_change_begin(). On
a FAIR-to-EXT transition, switching_from_fair() completes the delayed dequeue
before sched_change_begin() snapshots the queued state. And EXT-to-EXT changes
can't have sched_delayed set. I'll drop the redundant dequeue and update the
comment accordingly.

> 
> > +
> > +	WARN_ON_ONCE(task_on_rq_queued(p));
> > +	WARN_ON_ONCE(p->se.sched_delayed);
> 
> Very defensive :-) I personally think on_rq check should be
> sufficient. Delayed but not on_rq would scream at wakeup.

Right, sched_delayed implies on_rq, so the second check was redundant.

With the explicit dequeue_task() removed per your previous comment, a FAIR task
may remain queued with sched_delayed until the immediately following
sched_change_begin() calls switching_from_fair(), so we should probably check
WARN_ON_ONCE(task_on_rq_queued(p) && !p->se.sched_delayed) here.

> 
> > +}
> > +
> >  static inline void proxy_release_rq_lock(struct rq *rq, struct rq_flags *rf)
> >  	__releases(__rq_lockp(rq))
> >  {
> 
> Also kudos with the sched_ext + proxy demo. Very impressive to see
> that latency reduction.

Ah that was a bit of a synthetic setup, but I needed something to show that the
numbers move in the right direction with this whole thing. :)

Thanks for taking a look at this!
-Andrea
