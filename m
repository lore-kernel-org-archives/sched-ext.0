Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4644766BB
	for <sched-ext@lists.linux.dev>; Fri, 25 Sep 2026 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324618; cv=fail; b=ilYwUrV8ohuhZW5s5hN5KMa4rjoo5wZsNznOorW05XfBYAmX0zDixD8jnscc5eJIWx+Nd4LvfXAFBhnNhrlQrV5Jbg2NBca9N99tPAqidlhSL6jwPm7nbBNaSyGMFhIceYZhmsxiQB3MMCfW0SEuH/xHkAuBwGYUH8MMYSuqwLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324618; c=relaxed/simple;
	bh=l1vAcx3yK51PSkWRYCW5+6WlwdcNr1bDNsnZ5pPDRdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CQDYWGY7H16JSjt+79x8BS+7iVMHQaw7yz8temoJeX8XdhjxDwbdUtOm5yypvU7eL9z3Pn+5YRmp4vqA3lINwOhUKKGMRdpkHbiPhNQ/FdLxKrFalPNBgKn++BMrvZANTjOinJvBt/vL5IS8sniMvVDWv8EV18jyitLlTRKx1ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nSKz0Ufd; arc=fail smtp.client-ip=52.101.46.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nSKz0Ufd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgWfJDvTafOTKcG1uLGnef8DfanKYESmwML3GkqoV2ti0ejMEuzXhAhXZGXWE41ia8roaB80ZXpC226ENflpB9VmXBrJhIU3ddwEafkWQlkVhwQMIJZc22DoVv3UuNgCLvfSZ1UrVvRTnfCQKEfJ3TxE1e+Rxw6hITNWFk7Io/vEI+CcCgmg70EGFbXR3ho5c314suCyKRJQi/yMOJ9HURfHjuNhlMdyCBh7i1Ih8Lj30q5v6Jppi0mTj7JB3QcvYDEQLnmRVt/xKaiT3aC9IRSMGWzTqhU0yVr1n+2/BfuZpxlhaNCwnJaRFrBq7ABSF/XmVy9XIB7jGbdcBmgqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtKZzL1a5UO9vRvuG9J46o9V6uCELuASxidqG7uN5Us=;
 b=Ncml/xQBB3+1o0o9padLPx0L7S6lflJFzUvlStOkm5iKd/ooZljMNwoNnJIGo8hDnMs1Gg2SSv0xhgM9VO8FSGky/u4xIidH95vSW+RVv7WpMlbssGgRwAdMLOTkGaSUjJCCe4LToMEVMyvFFEWI1ADTHXwZ/AG36vpR7IC2N0+pgHDg4q5/ehyRH1haeipehrPt3oyKjH5O7hIhXXnIsY5t0jNqxvZw+idD+tTPuZvdV8XaDsEtKDaVu98PzAjifYSfd8NrE2TCBcw0DLA1x5bD79Ky3OLLFJLZTptKOqiSFZbqWURIcI4IHvDTwX7i1TTjVXNmmjx2EBIqaHjnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtKZzL1a5UO9vRvuG9J46o9V6uCELuASxidqG7uN5Us=;
 b=nSKz0UfdEaDDJYmpMhGt6OZL1AHNJQcVfeD6FTqGICpfRO9OIW61w1gyvUopFZhQa36CSwby6xLNtz7Q6ubCsjt6Lb+sv7tJS8odQ9Ryv4N2DxwuZb0fd7Y9JkyU8HNheWWwnKHOOHt6qsD0sPpeE6TIgWzgbCyM0R7/cVSslfBVZMEUj0F/kwsC4gvy1/SDE1x82MwLN4tL/KuxKXnNzUjeXQWJsiJ+Ga9BgDE1l50IsvJQ5EmZYj+LcDZksGsq/qq1y42HqP3JYTGHhc89+ISMZBwnQkT9nPt6nl6So6Gh4GzAEwP2Gpo/qGG7A7YHRWBWijB0JtneapL/7LOWsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Fri, 25 Sep
 2026 08:23:30 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 08:23:30 +0000
Date: Fri, 25 Sep 2026 10:23:20 +0200
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
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] sched: Add sched_ext hooks for proxy execution
Message-ID: <arYvePmLroZ9G_XI@gpd4>
References: <20260922165445.943315-1-arighi@nvidia.com>
 <20260922165445.943315-6-arighi@nvidia.com>
 <20260924075107.GC4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924075107.GC4121339@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: ZR0P278CA0053.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::22) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: e2605330-60c0-41f0-4520-08df1ade469b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dQqZwtJCibC8gQG1xpOaTmeMjILPpkXRh+pZN+h6Q5yIJxmJ8wIyRX7+LEtCfORmB3y5nEVin9gpHVkQ+fMfNmum0dVl73LaEY/a97ELdlct9TKxq/vj6y4dlC2DFppg0tahMabvnP3L8nwio+q4tgYCbbTllx/1tiazN8ZeaLB0ek6YyrngpiRN/N8EXSVhnr5zvH0NEfUO8xo5NmvxNJUA7ZouugD502vxDN/BTFzEbYn/5AON8NWQ9LwfTFChN6tvMdx0mJOobF8wI+80lNE/2ClM0BNqZfKimuVH9ayBfr2KgAtwe5ol/Sscd2J8bfu2RFkByscDJi3AQLqhDWNtsj6R1kHLpHlTQy1Yl8vWtipSjm7W+pe+XQVrucPt9PBznNdPgy9sql/6+O38ibV6OWgvGKJf21P8tVpveIbnpqovuNt9sUugrXEu/E+gb30CV7b3nDu4+El6L1QGvP/2+ZqUcyCl6fb31jKznDAFzmWRMoPlfPAK91Jp5M88ro1Un3gLdwGJsCdww17WpNKVN+NAPSCpKYAsmhKmgxZv1Td+iriho2DRyCTC6BGZKy3Ljy1jgLc6LUldfHpX4IShqHZGsJYo4lGI7wEyMJ+DgwO9pGoyT0V9AFVBV0HGMOdKJSxvoMtpt3PwwDm7O0qDA0JEG6EvPsOyw4FJP8U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aCcQ3AmxEgi7idfuZir5udeCATs3oAn6RMJqZ/mrqYUi8JA+G2rX2Og7x1Om?=
 =?us-ascii?Q?O3c6YZGemIVQMtcuh8x2EDnp6PvfIDlSpLdbT3Stkf0XIcbol63cZQalOUCj?=
 =?us-ascii?Q?1lrqa0YJP5+q8imy0zjzBdwgwM2bWK3eqA14imAxsLlGSLSgyfv+CFwy3Jty?=
 =?us-ascii?Q?8K54UPIvofmiWIYb3n/QGf4UK5CWDzG4opVho6UUjn3ixGJ7Hcflf1UH08KO?=
 =?us-ascii?Q?0WJQRc91tfoU22dBUqvGFmMT2zf+iCLtDZYurGlaP835uS+QFqJUs5zE26W2?=
 =?us-ascii?Q?75kQmYKVYFOT6QIeVl9htGO0riwLconP/Mo1p2dcwl7mIR0/1i+hn7xs/oGb?=
 =?us-ascii?Q?6ZutB1vkCA6hxl+0E0kG/eM1aKMsByWCch2o3zpNhs1IgWzZHN+Sgfov4YDO?=
 =?us-ascii?Q?/PiVK70jDopmuz/dtmKjwcCYulI3hqR3DX9k6HJnK2FODgKl4hbndKwscyaN?=
 =?us-ascii?Q?x/NFUSxyBgHRZC8iN+Iia3mtn3SJ0wV13wZ+2b4TnO2S2rV+EvTYCkn+qZ2c?=
 =?us-ascii?Q?LiOGQFKQ+XBKa6xt2g+3ISJeK+V0utDhNNcpLpjj7Qy7nW9fY+CuM13IU8l0?=
 =?us-ascii?Q?99SBtJCCBflFWyo06VzXRequ87AF7D3RaayU+NFGbJXqnwWXcmvRf2RHh9iz?=
 =?us-ascii?Q?G8Ex7fXEGli2WNnf+Io4WGMBokjEmQwEeyLmfNo1JdbP8b3z0WWpHBbxpxb2?=
 =?us-ascii?Q?IAO8v+8E+g/VH/Z5CAHepNrlZ22fEVzJgaFew5jv7ZIzKkeqkWxRLEiX3enP?=
 =?us-ascii?Q?Ztovz6aGgf3ZJUgzFLty09def/bStSufYIoGPGAIfGnvROj1oEJns4JReWCQ?=
 =?us-ascii?Q?+Rqd4q+ur6haXgf0FAs607F/X5QgZFfqjhb2GOTAJI00Gvi7fEmbG3qwM/8H?=
 =?us-ascii?Q?H0swGnBFttk1IOD3R0NEhJZB08mVioQV+TUxNkX0sjO1wog/TPKk7+JTyITk?=
 =?us-ascii?Q?VDvz2f5SP8lh3j6IvtKht0Jzyj5GEXkPTA+xCQAXNyqkuyn/tp80SgFWsTQq?=
 =?us-ascii?Q?JmEwB05vVY2LQjmd3RM1kQvMS2DIIaFOO2yFSOSBFEMpAp04pHFPnaldVg7x?=
 =?us-ascii?Q?N7XCJmmh+Nb4Nltyv0VnTz69NAJnNuDeXGej46IbtwK34tpMCkdmzvicNz3i?=
 =?us-ascii?Q?sexkSJSiHLW9OL3fKeZJc150BSRpzw7Q5hpQL464iVcaH/8bnyGKvVStrcWJ?=
 =?us-ascii?Q?YUm3Y/RTDa2Apfx8CKZORcQyRdlKhYC9IUhtzbeBmY9JbRWrIySj5PWjz3WD?=
 =?us-ascii?Q?qt96Bym0iA3Uri7rKor7vw28AGj0JyXI/MCYiiiNJjkpusrEdM6i5Tp8mm2f?=
 =?us-ascii?Q?0Qfb2H+4x2Meyb+FwN0cKJCntZMQiwiv4vVzw7Zir284Am8bwWCtql1nIdMq?=
 =?us-ascii?Q?3ZwVSTEMM36bnNDKhv7iagxKVDFI5bnHm6m0utlK5hL4mbILzlEIoYMIJxcr?=
 =?us-ascii?Q?xWaxLrRu602VM0sqhBdaCFyFRmt4lAb8MbcFD5t7uLIE/4jaWeYjyaylajRh?=
 =?us-ascii?Q?jHdeNHv3Kfc9VLYEJYBQ5ZXHiswhLVzxSDXGjeTS19ghBSTQtUlx5Mxszt4R?=
 =?us-ascii?Q?ti+nIegKMbfpO48mnAhvhLCXb8zTqnGCCvYzjzL6CW6Ui3EjJoLC/ADmyTbW?=
 =?us-ascii?Q?tWdyM4uOwjONWA+sC1KugyQDCcro07gGBcSHsB80q8Ss3KxF2zc3BUdMnL/K?=
 =?us-ascii?Q?qFiJJ47FmP8G0GKzN6jg5PmAPpCb5vuf8d/lbaO2WJ1Uzp5KGNQMtXfGPnfZ?=
 =?us-ascii?Q?Cz3XuWuIVA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2605330-60c0-41f0-4520-08df1ade469b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 08:23:29.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4X2L5z0vAJKth2ujtfeYfML9u+Kt9IP+r8UeN3tbgzgNezJ3+uu6iYu9AP/iggk/JYySyVLFnHunjNKNptD9CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

On Thu, Sep 24, 2026 at 09:51:07AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 22, 2026 at 06:51:44PM +0200, Andrea Righi wrote:
> > Proxy execution splits the scheduling context (the donor) from the
> > execution context (the lock owner). sched_ext needs to observe that
> > split at three points in __schedule():
> > 
> >  - whether a blocked EXT task can be retained on the runqueue as a
> >    donor,
> >  - when a donor's scheduling context starts driving a lock owner,
> >  - after proxy resolution, when deferred reenqueue work that was blocked
> >    by an active proxy relationship can be retried.
> > 
> > Introduce scx_allow_proxy_exec(), scx_proxy_donor_start() and
> > scx_proxy_reenqueue_retry(), and add their call sites in __schedule().
> > The implementations are empty here and are filled in by the sched_ext
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
> 
> > @@ -7243,6 +7242,7 @@ static void __sched notrace __schedule(int sched_mode)
> >  			}
> >  			if (next == rq->idle) {
> >  				zap_balance_callbacks(rq);
> > +				scx_proxy_reenqueue_retry(rq, next);
> >  				goto keep_resched;
> >  			}
> >  		}
> > @@ -7263,6 +7263,8 @@ static void __sched notrace __schedule(int sched_mode)
> >  			donor->sched_class->put_prev_task(rq, donor, donor);
> >  			donor->sched_class->set_next_task(rq, donor, true);
> >  		}
> > +		scx_proxy_donor_start(rq);
> > +		scx_proxy_reenqueue_retry(rq, next);
> >  	} else {
> >  		rq_set_donor(rq, next);
> >  	}
> 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index f60894dbf0623..aaa6ee66917e8 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> 
> > @@ -1110,6 +1115,10 @@ static void schedule_deferred_locked(struct rq *rq)
> >  	schedule_deferred(rq);
> >  }
> >  
> > +void scx_proxy_reenqueue_retry(struct rq *rq)
> > +{
> > +}
> 
> Doesn't match its prototype, also, I'm a little confused about the next
> argument in the next == rq->idle case. 

Ah yes, the empty stub has the wrong signature (fixed now in my
scx-proxy-exec-next branch). Thanks for catching it.

> 
> Hmm, you seem to be using the argument like:
> 
>   bool proxy = next != rq->donor;
> 
> And I suppose that works. But that seems to be about the tick, not
> putting current back on a dsq.

Yes, it's used for the NO_HZ_FULL tick bookkeeping.

In the next == rq->idle case, find_proxy_task() has called proxy_resched_idle(),
which sets rq->donor to idle too. Passing next through the hook lets the tick
bookkeeping see that proxy execution has stopped and clear its proxy tick state.

And the reenqueue retry is separate work in the same hook. I moved both actions
in the same hook to avoid adding another call from the sched core, but I agree
it looks a bit confusing.

-Andrea

> 
> > diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
> > index 0012f708a5504..cca3f7c97b788 100644
> > --- a/kernel/sched/ext/ext.h
> > +++ b/kernel/sched/ext/ext.h
> > @@ -20,6 +20,9 @@ void scx_rq_deactivate(struct rq *rq);
> >  int scx_check_setscheduler(struct task_struct *p, int policy);
> >  bool task_should_scx(int policy);
> >  bool scx_allow_ttwu_queue(const struct task_struct *p);
> > +bool scx_allow_proxy_exec(const struct task_struct *p);
> > +void scx_proxy_donor_start(struct rq *rq);
> > +void scx_proxy_reenqueue_retry(struct rq *rq, struct task_struct *next);
> >  void init_sched_ext_class(void);
> >  void __scx_update_idle(struct rq *rq, bool idle, bool do_notify);
> >  
