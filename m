Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF151D504
	for <sched-ext@lists.linux.dev>; Tue,  8 Sep 2026 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859697; cv=fail; b=TS2XEu63oqM8HHWF/VtWdfcGPYomvkK8DQBj+g04uPuyXdE1JP9cUDiLLMHxjXzSKp89xn85oSm6E+icJqQiISqjiluH1u9836iwPzW/iNFOBn7elPBN1gM2qfJZQJCHQI5nmTXTc1p8izjIOu0RW5j8iqcYSJBEg1tyAvOgqtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859697; c=relaxed/simple;
	bh=xvLPOgnNjAkwj0KgqtX/bCMTtpk55uFVRQ0hahkQpE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lyxBVhqGcRQAHBJkvr+6lDR0jnpimNEUzn+WYjgOcik0vaSRmr1extAH+G6ZHdRCxfEvYpXiq5OSHeBpkufvvpvhC66iBFktecS8chJJ3yp1G/oQYTN1KM7/QFH9vWZ0Gs3oPjmPjUDEBrZPh0othxo35HfzG3sYTygRJr5ftsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R/8avkH7; arc=fail smtp.client-ip=40.107.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R/8avkH7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilUMqqrceItyvCGMI6GJmX6oJg73Ih5AtO5U1x0yssKwFxjNJOi3Fm/TJOXB+6SLPUWhDWC1ECWUj7N8H6XnII6sR0+DwqM6vLjCEsCdJXq5+rteheH6uf/X7w0DwJh3XIofW2xKsdbc9IEqiMOAeaSei+a2mLXPE1rL2STjVFGComeQqRWE8EUcOBpOdDmb9K2Y+F3Ykq94MwYNcY5bmS9PnWU1JM/lTu+nU0T8foiLk1lX06UMRKE/lsX0tJYz/yLPBGasKkqeRqZD/8es0aIWMUxvTWM2DflVFYGeMK5BOh/4haSKdXbSoFKwpuFRCnx3+m6ZBxSaRQjm+NtIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgIodrbaaqyYD8MsjIJ2MF+1KHaT7fMcPxXXpK0kPKY=;
 b=AueRAtUnPggq64QiqIbaTraLxe39kDX0vPcuKHA8Cx6+8z/1jelpmjuhIDjeV3Shxf7Jx84edFpdPDfPhknzK/X9zmh/zFAQuAzA73M5js5P6YwBeJkTiEbeJnKRHaowR6RVatOl919yFDYtW7fX1eCzqZMNAc9IYuj0kWitgG6K/8rMsa2O6mTXheHFx3C4InOsbg9rXSsc9bA+EIZXeTPofNC1RUrna/fnRGyLLDiS8QiOB/o3Gcso0zWWT0cwVHjX6YP4AnNM3YFyVGtpfz15t6czhv8sPQJ+BwfevW0Ee7g+70wl1XZME0qNcxUrYsKsyi6ynLklSF5zus3P5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgIodrbaaqyYD8MsjIJ2MF+1KHaT7fMcPxXXpK0kPKY=;
 b=R/8avkH7WfoV8WV2dS4jj4GMc8kz0Mg5d6HXbltnnMDehZbaJUZ9ddNWIgzSUgd5IrR8OM4Akqc0DngfRhWRFjiIG2jieAj5n5IerF+Ht4OPzKdMs9Au37fIn1HQSyFWDAEE5J2C91b/ufsQ9DwRSFuMApjz7Pph+hfp2yifmrhfr+Q0yTS2y+EC+FMR5ZhvWU4Ug/zF4EE4bFLeYBTbfGzxQvcNcdoW/yzKKi9xKJAX9f6ROUcPAjE+6WoiHWTP4GgaI1UrYqb9HR1Immmi1g/xYGnRGNSefA/P+J76epg7hrMne0z6KweoGmJA2KD+/7e35LXFdoPPyZOTMb1YdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS4PR12MB733313.namprd12.prod.outlook.com (2603:10b6:8:50e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 09:28:09 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 09:28:08 +0000
Date: Tue, 8 Sep 2026 11:28:00 +0200
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
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/18] sched/core: Dequeue waking proxy donors before
 reset
Message-ID: <ap_VIJdG80ZZ_8D0@gpd4>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-3-arighi@nvidia.com>
 <3d4116ff-0634-4ab6-be24-0bd2c68f1698@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4116ff-0634-4ab6-be24-0bd2c68f1698@amd.com>
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS4PR12MB733313:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e6c29d-923f-4eb4-9f3c-08df0d8b7ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|6133799003|18002099003|22082099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	54FJtXzWAfOcF1sUaVAMlPQ50koGf5Wbk9UqRmeewyFo10bEswC7dpHpyqgz7Co2MhqsNue/aUV1ys80QrP0Hy9oMUfbSOs+7vbSDx3l9REJSU/vSQ0ksI5hNX3Zb0IKx70A0KKMs1QJncLMunzR6uu1g3h30VJ9Sv8i01l2TwSGcvOKa1HgOlPGXgxEjZYUO2OBa+r3R8oWu3qIFV5n9cweyEG7k6TdyM89xbJjxeTtqu98+U+kpKO7ewg1d+8lCTalQ4E5+SP2vsM/n7HXO0M7QSDyPvJaNHMGKmLHQun3oL2hm9ez/i5WSJXA4+yuWCcH7YH9pe34NwqBiu/WrHzZPKCSeOtIcnElmuuc3it6Swqh3tKo22IppD9QVgnlOJXJpgqxJTsXkruDp29W1jdOdnLvbCSbQk81DHZWri+YkUzKNzlznvBdkI1ck+IbRnBA+iZigKWwdNrHSko/zc7PSjL/nyjqLDwXC06HzztN3LtgU/iHmMJwgvhqrJugjgx5ut2fuofaYgcnIqAUEgLoW/e2GZ0RXIjaA+j4lbqq0fuT/QQyMLUaTYZM1GcBFs7BLifKC56o5K9LaJdYKUX5yC039uZGvY1ccVuqtxRxAfcqycNYLEMoHZjBR5kKDQcH6VRLNr9e2ioiv/CKMGFP5cb1Pe9+x84O8htYVYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YLCmPi/cE5FzoJqu1kiaaLedcrjuLBRslG5eongn4mm9sSb6PxJUM/Il/Hsf?=
 =?us-ascii?Q?DBwYioB8wcGz+KMdtJq+P7Huu44JMDxm8UU4vG9IOMWfhrCS6xreMmuCq9IL?=
 =?us-ascii?Q?ZTERvxm8+6NeHswczzIcjJmZDUu/h1ClPpKSlNh2bAkUl6tioI+xJAXNFFDP?=
 =?us-ascii?Q?pts7lNU1UZA2wJnHKI2v9zkxqkVUyEQ9ySxRu+1sXVKC9oyjCpdbXEa1rAro?=
 =?us-ascii?Q?+6xBxrqyjjLPAVTlxue98ccHzVaJ5qFMlJtvYXOdDTQvvKHOx9Od0gYzy1xN?=
 =?us-ascii?Q?2XxX8P+/r1I73x5bmZ04fNriOJ8y3a8Z2KwHLgvM6/WPt480T6BMMCWilya/?=
 =?us-ascii?Q?tla4NsmCEdOZkBhJWqjov3uVTAv/C4nW/B8/g6cBEFUE1L3n4qe6pRVAXzIs?=
 =?us-ascii?Q?e+IMMuwjIDnmoaTjtJ/AuA7ecd9ME5VgoqlcWPRnikRq7Qjpzg+eY5ZpnO6W?=
 =?us-ascii?Q?JpGLd/4M3F7rocBOfosQlKGCDbstjiY42wF/Zyl8A1Ta5xag7H8RXu3iwWU/?=
 =?us-ascii?Q?oM78VWdSaG4w0BVCX7bblWcfCeIPNLJjXH/xtNL4otZiS4HEOjM/fhmgyQnO?=
 =?us-ascii?Q?U0vffstK05V9bixdZyevAcezffKLjEwHjhQDIDtbSbhoyu107gX0uL2m05s0?=
 =?us-ascii?Q?enZ19aBJaV6yDTjcWt0grpHQHPbCLxXVbk7plc/IMFwwInTwyhYL85IvdlfK?=
 =?us-ascii?Q?8R55t1Q5o5gsPESOAV2MyknpuR9VtZVl4kF/E1SQeEJdIj+UtBU5EcUozja9?=
 =?us-ascii?Q?bV0xEYuEYrMMCI5sAOvqKrBpeYB1X+jH4bqJRO8c443l7Hk+U4S+LI/vplmK?=
 =?us-ascii?Q?jfBkxok5b4iBLVd1p1ghTXlv7TLWdIrSFo97u73lhslDsUJDF/F6wS5nM+V2?=
 =?us-ascii?Q?Hz/aQCW4Z+fD+d9vvw75JeMGFmjYCDVS1QbGO7PD6aWQZ6u45erTcVLoxnNM?=
 =?us-ascii?Q?vTMGhjhVFNBHsvaPVgx48DCiTYX83fEPyj58XL6LUzrhg7T9wqcGkEk7aUe0?=
 =?us-ascii?Q?xRwTk0egwdSIuyVzlDavCJi8IqWIyHPaJXbQqT9mM9Er3JOU+DdCqmlbH04Z?=
 =?us-ascii?Q?ApWUPkzAJT6s/VDT2Y+nj2xtPzjPxwb/zarHiMBtOYGwC5ShTUSVY5RLIk49?=
 =?us-ascii?Q?pwANNzWoyWYWlK0V+j/cf+h+BkNID1C9zbWsC+rfoGREN7JMoSJsfuCa2wId?=
 =?us-ascii?Q?U4Ym7QUi/OOfwW/pfvwXOxdyN8pZGEltmqJiSKSbwuvTWqyiH5+TyuA05okh?=
 =?us-ascii?Q?IwpLNevNLPaIn+02pN3l24VJuPbuyVZjf2maStRLiKwBtZHnx9dAI2BR5StU?=
 =?us-ascii?Q?YD4MxeyM4Iq1tTERi6bxIZ9P4+2vDAl9ffhY5TEXiBREl9jSV20LiMlsBFqp?=
 =?us-ascii?Q?2rWxLAjd2O0S8a7/D0m0CFUNvldSqT+JdVsj8uiXe1jr19K91V0XgSE75zkA?=
 =?us-ascii?Q?VQSSwZLTfYHXIO0CWHZwmq7NKjekeHdrrnFkvKgD3AwEAhWv4NgscoTXbWe7?=
 =?us-ascii?Q?//qsjHg1fU/uKmP/aYr549/SQG765dkKSuJaqKFLmkOXGh10PCUVu8mHzGrL?=
 =?us-ascii?Q?DO/Gab4iW4mQHOKguaUl3ffO5WEOKnN1x8ux2ohzRmpZJuoIQivu666WSnB4?=
 =?us-ascii?Q?kZKEHC742P8q7K2csVb+vyYBFY4qj3sBLcXx37/kaPU53N2Y8oknQ0Ax2j2h?=
 =?us-ascii?Q?2I40xsb7AztoXRVWrLRPaQIN+qHuR4L+jK2lgGq5yw0xIy51R1Y0hJu44Ja7?=
 =?us-ascii?Q?Sp6Sd6KJwg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e6c29d-923f-4eb4-9f3c-08df0d8b7ea2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 09:28:08.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcD+aEz219WW7+QBNxRrlQaIGixWWRgiMGEGzr58gL5gbLMplldBrUrGFpO5c0Ef2JWO1ru0cY8e+/5UYnMwxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB733313

Hi Prateek,

On Tue, Sep 01, 2026 at 10:54:44AM +0530, K Prateek Nayak wrote:
> Hello Andrea,
> 
> On 8/31/2026 7:12 PM, Andrea Righi wrote:
> > proxy_needs_return() resets an active donor while holding blocked_lock.
> > proxy_reset_donor() invokes scheduling-class callbacks, adding an
> > unnecessary raw-spinlock nesting. It also presents the waking donor to
> > put_prev_task() as still runnable immediately before block_task()
> > removes it from the runqueue.
> 
> Is that an issue for scx?

Yes. When a proxy-migrated donor wakes while it's still rq->donor,
proxy_needs_return() has to reset the rq's donor before clearing the task's
generic on_rq state and returning it through the full wakeup path.

proxy_reset_donor() calls put_prev_set_next_task(), which invokes
put_prev_task_scx() for an EXT donor. If this happens before the
scheduling-class dequeue, SCX_TASK_QUEUED and is_blocked are still set, so
put_prev_task_scx() re-enqueues the donor through scx_do_enqueue_task() and the
following block_task() immediately dequeues it again.

I can clarify this sched_ext-specific ordering better in the patch description.

> 
> > Split block_task() so the waking donor can first be dequeued from its
> > scheduling class. Release blocked_lock, dequeue the donor while its
> > generic on_rq state still prevents migration, replace all donor
> > references, and only then complete the generic runqueue removal. This
> > follows the normal sleep ordering and avoids transiently re-enqueuing
> > the waking donor.
> > 
> > This is a preparatory change to support proxy execution with sched_ext.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/core.c | 30 +++++++++++++++++++++++-------
> >  1 file changed, 23 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 5817d1a4cea2c..237d216382f46 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2252,7 +2252,8 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
> >  	dequeue_task(rq, p, flags);
> >  }
> >  
> > -static void block_task(struct rq *rq, struct task_struct *p, unsigned long task_state)
> > +static bool dequeue_block_task(struct rq *rq, struct task_struct *p,
> > +			       unsigned long task_state)
> >  {
> >  	int flags = DEQUEUE_NOCLOCK;
> >  
> > @@ -2273,9 +2274,15 @@ static void block_task(struct rq *rq, struct task_struct *p, unsigned long task_
> >  	 *
> >  	 * Where __schedule() and ttwu() have matching control dependencies.
> >  	 *
> > -	 * After this, schedule() must not care about p->state any more.
> > +	 * Once the caller invokes __block_task(), schedule() must not care about
> > +	 * p->state any more.
> >  	 */
> > -	if (dequeue_task(rq, p, DEQUEUE_SLEEP | flags))
> > +	return dequeue_task(rq, p, DEQUEUE_SLEEP | flags);
> > +}
> > +
> > +static void block_task(struct rq *rq, struct task_struct *p, unsigned long task_state)
> > +{
> > +	if (dequeue_block_task(rq, p, task_state))
> >  		__block_task(rq, p);
> >  }
> >  
> > @@ -3774,6 +3781,9 @@ static inline void proxy_reset_donor(struct rq *rq)
> >   */
> >  static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
> >  {
> > +	bool reset_donor = false;
> > +	bool dequeued;
> > +
> >  	/*
> >  	 * Typically per __set_task_cpu(), task_cpu(p) == p->wake_cpu.
> >  	 *
> > @@ -3797,11 +3807,17 @@ static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
> >  		if (task_current(rq, p))
> >  			return false;
> >  
> > -		/* If we're return migrating the rq->donor, switch it out for idle */
> > -		if (task_current_donor(rq, p))
> > -			proxy_reset_donor(rq);
> > +		reset_donor = task_current_donor(rq, p);
> 
> nit.
> 
> Since proxy_needs_return() holds the rq_lock, you can check this outside
> the blocked_lock safely, even after the dequeue. There is no need to
> stash "reset_donor".

Agreed, rq->donor is stable while the rq lock is held, so this can use
task_current_donor(rq, p) directly after dequeue_block_task() and remove
reset_donor.

> 
> >  	}
> > -	block_task(rq, p, TASK_WAKING);
> > +
> > +	dequeued = dequeue_block_task(rq, p, TASK_WAKING);
> > +
> > +	/* Keep on_rq set until all donor references have been replaced. */
> > +	if (reset_donor)
> > +		proxy_reset_donor(rq);
> 
> Since TASK_WAKING is guaranteed to block the task by adding
> DEQUEUE_SPECIAL, you can just move the proxy_reset_donor() bit out the
> blocked lock and keep everything else the same right?

We still need to perform the sched-class dequeue before proxy_reset_donor().

If proxy_reset_donor() runs first, put_prev_task_scx() sees the donor with
SCX_TASK_QUEUED and is_blocked still set and reenqueues it through
scx_do_enqueue_task(). Then the following block_task() dequeues it again.

> 
> I'm not sure I understand "transiently re-enqueuing the waking donor"
> bit. How is that possible if we just do:
> 
>     /* __task_rq_lock is held throughout. */
> 
>     if (task_current_donor(rq, p))
>         proxy_reset_donor(rq, p);
> 
>     block_task(rq, p, TASK_WAKING);

And the transient reenqueue happens inside proxy_reset_donor():

  proxy_reset_donor()
    put_prev_set_next_task()
      put_prev_task_scx()
        scx_do_enqueue_task()
          ops.enqueue()

__clear_task_blocked_on() clears the blocked_on relationship, but p->is_blocked
remains set until ttwu_do_wakeup(). As SCX_TASK_QUEUED is also still set,
put_prev_task_scx() takes its retained-blocked-donor path.

The subsequent block_task() would then immediately undo that enqueue.

> Is the split because dequeue_task_scx() needs a correct rq->donor
> reference or does ext requires dequeue_task_scx() to be called
> before doing put_prev_task_scx() always?

Both are aspects of the same ordering requirement here.

dequeue_task_scx() must run with rq->donor == p so it recognizes p as the
current scheduling context, emits the appropriate stopping transition and clears
SCX_TASK_QUEUED. Then put_prev_task_scx() can run as part of proxy_reset_donor()
without placing the blocked donor back into a DSQ or calling ops.enqueue()
again.

And this is specific to resetting a retained donor, it's not a general
requirement that dequeue_task_scx() always precede put_prev_task_scx().

I'll remove the unnecessary reset_donor variable and expand the comment to make
this ordering more explicit.

Thanks!
-Andrea

> 
> > +
> > +	if (dequeued)
> > +		__block_task(rq, p);
> >  	return true;
> >  }
> >  #else /* !CONFIG_SCHED_PROXY_EXEC */
> 
> -- 
> Thanks and Regards,
> Prateek
> 
