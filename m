Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDC532E6BD
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226033; cv=fail; b=Dq1KfG/ozkKP7OluZeEYH4jDLjkt7LHu0tHUEI2Wa4X1q+MrcCsjuUMtFXFaQbETtv7X1mB9whZ24SF8wb/0uMTW3ahQCA/TCff/FffmIpv0+C3jm6yT2gSDTbjJkJic7wWqrhvgQjUBB8bam9U2Y1FIjisFmkfs7cU65KdfygA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226033; c=relaxed/simple;
	bh=8EGrBZHbI+CaYIVT2ax7FZzoESH6MEHL7NwEn6Id91Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JoEH4eZxYkCuzoWOy4eopEtyLL2Gomz0bBRHT0d/4qQnvW1OuiFJcFR8ErX5lyBuFoGfO3Vdq04gE41vOczCuL3RHi7eXjOKKI5ASp6c9CixViWhveh1wV3TYq1NO1WMuamkyrGKw1E5tKHL7DO1/jTkiByfiuj2fY1qEOO1yIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jEjUhcMy; arc=fail smtp.client-ip=52.101.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jEjUhcMy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMW2E8tlxO6Q6qY4zMA1QoW/x3wJtzn+uuqQiIVslyB0lNWYZ+ekY6SxdqwNEZw5izA61QRUmzKNWaGxqUkB85l36qo5MxhgiN+RzPdZpZF39nKtoFzh5P6paL5ef+0aFs7ozoZt6oeU95GAjpS4FKTxIvj/37w7EWP8d/QThfIlJDG9AQKYkC/nfCr8/dnQz/8YDlvLWdpe57xNRLoOctmhVnXuUq354m6neLcJV1jMipftYv2tBd7YePgFRZJy1AJJucgTD5oxah0EbYmxf89TFoaf3POBfroo3qouQCNaFVuHd1Lgz5ydd45iddTJA7X0fRgP9FQy20a9KQVaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWzPh/em1swiWo2xcit193nFVd1BmWgQbv3cS9jtyO8=;
 b=xBbaEobjaFY1fRik5uXMf7YO10V9Mk2HjP0zG4SeLyoZi9eL31xq6tHxdxnUA78/IOyDr5WtL4qaqpg1fCPi4/PG+1zCwicOD35XPgVZvsjB39tHeGLbnPuClzZToMDHslmeeXs4Yj8RhOSvucQ10GyvKY9jZ+4KVCDpf5T9e+fDsZIC4Tdb7yEesSVIbiPli5z4NeHjKrED8pPx3/8gABpDzGFkcGBX/ArVkBHJv1LlYkFrGx9WPrPPFlylrij7pGruTuMBJk7X9WXiBn5X8vwpsywxosGVwY5umjT09VWg9i46Zkn0wiEPBUf6RzNNH3ShOmBl7JBonRd3i0k7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWzPh/em1swiWo2xcit193nFVd1BmWgQbv3cS9jtyO8=;
 b=jEjUhcMyAUL4no8IaCdYptPYWYY3cY5lDqtT4kNvIQkiR0bc/Oojx8jyj4XfZS7m2cQYjb7HdTv4yYGolXtF9vQOUJIgcX7bZXt9Vrfqclj1/FheFDIx58r6cPeokzGYXMWZ2vM59FHXbaSviXEIF/yeffEsFlaPiY5j5ulNJjyOpw6nKvxSSpfrqWoHHYHjyTj/wPHg94hSNb7qz2KhDLkaWc5Lq0oeqXyxlI/UhedRKxA73cMw8vXL5n/UYY8RuH6LLaFvlcvyeEl2OluvHVl7Bp278PM8j+mHzJdt0kBk+KO/Mp1J55PeQlKfwnbY72RypbrjkGcu1XxLIScfDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:40:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 07:40:20 +0000
Date: Fri, 8 May 2026 09:40:04 +0200
From: Andrea Righi <arighi@nvidia.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: John Stultz <jstultz@google.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Koba Ko <kobak@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] sched/core: Skip migration disabled tasks in proxy
 execution
Message-ID: <af2TVI7ZAw41ZO3C@gpd4>
References: <20260506174639.535232-1-arighi@nvidia.com>
 <20260506174639.535232-2-arighi@nvidia.com>
 <CANDhNCoKyJGZApptPo=7S-Cdu1FqPPr_Wr9djV1-NzjfVnbkgw@mail.gmail.com>
 <427e64df-2d3c-47a5-925f-ef9a751f1ca3@amd.com>
 <afwxsJiNJcNQrcHN@gpd4>
 <bfb4c8ca-e155-41b8-ab00-1607d9823051@amd.com>
 <afxlvypRoa0qCHhs@gpd4>
 <24ffc508-a806-4be0-9b33-fbe8c02d1742@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ffc508-a806-4be0-9b33-fbe8c02d1742@amd.com>
X-ClientProxiedBy: ZR2P278CA0063.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 30eb0b4b-e03a-4b35-01cb-08deacd50dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Zvq/gW3zghhbw5dW0XaO3DXRcB7Y3upUr8gg5JpjCNm9x9RZvHgdgsW9VjrBox2MyuDBlsvyWVaG1F2F0+BOVr3Wuh4JKHT6OGHa5LPCkuL/pz7Tst0dolIPWYCi5FEmqyiTOUQs24gN23o0AHKUsIz8iBwnPM4FFC9bpVs2ZE8VUBnATaB0IAj0OdX8TCysU0BD+MSdLFJsornqpvAWibKk2kUvEz3k2p90/nSLzXmV6OW3UgYkbCM7kaAwux3hKBy2TK8ZcJlwubOHGvf5313SShNhtWYZgs2IOoV+aLtjBzpPhDpISa5vuiKza1LdWcCtTNyYZiDgjx1SOxJpKStad61UVrPvb7HYx4vheEPqn1OKkiI0q3VLcWH4SgC3sNlwzLLOgXX0/4oeiuCwjibDNo+XgUQyWyHkPxDWAZUi0pml7eLPP1looMtnhZCppyNZWPIu2cN1IWqCVpBrVI3DI/pVM4in1I32oSyHl4bHjq/Q8D1Os6CFu8xw+/okl/u4Mz5CxfUgK3YJjsT7/dpTczktMMP6byzKUiHpdlDxeW06bnThKh9T3PUYY4Px6CWei5O37VxqJyt6QZKZGMuWneJM/OcqyS6ZEhR+7Zbk8YkkYga/MEQlKG7RO7WsJRpTY8V5vYq3xUNubJwH96uhaKP+KCz+5+2hxJt4CqAsKBmiPVz+n7V7gaMC6j2c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q0HeUQshfwrS6SdGEZcIRH1RTs+ZRbrA+/8zN2AHAvlC/66rZe5nVL4bLTFh?=
 =?us-ascii?Q?jA++OiP+s1t9Y50LxCqwokAx23q5l7ZiSLAV09RPBOkFO3xz1tkIKSeb5NmX?=
 =?us-ascii?Q?ctrR1LiEmK/0bY0WVv3b6j8QkkjEb+Rj7cZAuvn1IZBy6ofssFz70phuv/kH?=
 =?us-ascii?Q?AFPZ1ut4DGqeKIfhVVMszn/Wzk49lCC2flmP8FQBQt492oQPbk/+Ow+KFtOG?=
 =?us-ascii?Q?X7OSHRLZHxys4s/YiVFZSX3ZffQCBMhwOlhXJl5uEPapypFPtq9/XZum2QcF?=
 =?us-ascii?Q?ZBP5kpp+qwVnccZgvr6fe7mfUDO3/dohaqe2N5tAmRcXswsFKwTSA2l0ika5?=
 =?us-ascii?Q?TWR52kI39Rr8EbUk+/Pqm6/VkXj4GNGmgEB1bxbTBewDMR9JUBr6F6OVErmB?=
 =?us-ascii?Q?7144y/clVzG63NOSlYAraZ6peTpilKw/xQyTuheeRsGdgxxOcO4FjOmS1WER?=
 =?us-ascii?Q?+iCteIQcYO+yG7j+d0Ok7V7Ytbl157S81wvVFVwHhxyFFEkM/psfRwRQ7j4E?=
 =?us-ascii?Q?2fdHqU99jnx3MrG8u4sP7Pw7OYa1FbykhLo+WikT2sdit/7U77QW2S9BlcFp?=
 =?us-ascii?Q?1WBJJ17SNeHtLowG4IfgyQmh9r0lG16lIGwjw/fiMIByuUiV9yfbQP/s3lmi?=
 =?us-ascii?Q?0Zc07lMl6XJaqFLiO97NJuFKSr2x2URhaKrphUZZCh2FfeNPMaq8kJTUZHKr?=
 =?us-ascii?Q?j3BP7jB4MiBLIko56MX6wO988Gfz40O4zjKMYOGKAb9iO8ihKPSq2tdFbYx5?=
 =?us-ascii?Q?DRt51xD4Idr/AWy6Kpn6oRji/jeuOTPt9pfEmExNHs8GUpZm7sKJ1iFq5mAG?=
 =?us-ascii?Q?kuZi3oGAZt75IVtQ5UwmIDpdMCOB/W9m6G7npDfvd/XSFwVZpDxG8Tu95nTy?=
 =?us-ascii?Q?e0FdB1d02Gaoyj40XeNutz/ynw5F75Ko3BGCjJM5cJZCsTL6nkhYHbcfpsEF?=
 =?us-ascii?Q?sRLnSM4l3Mha5YDfECREAUal5zP9hSHaZOeb8/WERDdupoJO7VmtQUF5IHZX?=
 =?us-ascii?Q?DBUM51hTJN1r8JoAWoVgRGudN/HHvMLetOqADAyJXnjs+ibn0z3jKOZ/HA2V?=
 =?us-ascii?Q?DrMvD1ObotO4xqe0J6B+mbmlSeBK+Qj7OitnaaO2Qzzblb7TJwdG+0ZSML+h?=
 =?us-ascii?Q?9W6t+6MTjBxQLsV1K5tbLolG9g8pwVGzUwyty2CWmutkiYOVljLWxm4YnQPM?=
 =?us-ascii?Q?GTkwAx0z1g64L2AjwBnlf9zaLtMinQVVEHdGY0BDinORChMpMXWA9QP6IzxL?=
 =?us-ascii?Q?wejioq6TkAJO0KlbdVi57hX47FdGGncg+J54tE4UiVo6UAve/TNdG/dCHmZe?=
 =?us-ascii?Q?5nEE3sGxRThcHfZ2/DRvL2VN/kKh7sI6JjSJDgTVY62djim+p34d2T4gVShK?=
 =?us-ascii?Q?YH2CKGOwi/Hl8bw41rzZc50VdsGJxJwVfCBiuHzpFNCG2gdBh78U6RfjU2x1?=
 =?us-ascii?Q?pBGasu3lOUsd+LZWJRC2Nq2YSZxJIBtuS4XNtWC3ikv0AecZDEte8g1QHLef?=
 =?us-ascii?Q?mQ/VlzjGLwhs7CzwhKxl9ez6IuQL89DEmYnZ5dZTimWoyvOhrae0e2+hETU7?=
 =?us-ascii?Q?a5Q6PkNTTNuJeIfh3cL1U3ozFN2KM8H9wwDkHC1sGig2TuqT4U4BvOMKfpp+?=
 =?us-ascii?Q?5k/HQWJGT0OH8t7viCxT3SYoVAlSTYFNV2XtHGj54xxg6wonWe47Mg+9m+SR?=
 =?us-ascii?Q?0EeI7mpSSWBgklJWb9AI1QiYlxvFibdrzxbH5bcnNbR+rIvs7KDTAO6PlbTN?=
 =?us-ascii?Q?cq5gJDdWLw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30eb0b4b-e03a-4b35-01cb-08deacd50dbe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:40:19.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LC+n+FW/5hgJ+CbTTdnVn99pyAnVxOjNKMx2J15C3yfvSY5471tfNBLCxll+YZ+puKH7vYbl98tNcrvZAGd4gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545

Hi Prateek,

On Thu, May 07, 2026 at 09:17:34PM +0530, K Prateek Nayak wrote:
> Hello Andrea,
> 
> On 5/7/2026 3:43 PM, Andrea Righi wrote:
> >>>> scx flow should look something like (please correct me if I'm
> >>>> wrong):
> >>>>
> >>>>      CPU0: donor                    CPU1: owner
> >>>>      ===========                    ===========
> >>>>
> >>>>   /* Donor is retained on rq*/
> >>>>   put_prev_task_scx()
> >>>>     ops.stopping()
> >>>>   ops.dispatch() /* May be skipped if SCX_OPS_ENQ_LAST is not set */
> >>>>   do_pick_task_scx()
> >>>>     next = donor;
> >>>>   find_proxy_task()
> >>>>     proxy_migrate_task()
> >>>>       ops.dequeue()
> >>>>         ======================> /*
> >>
> >> At this point I mean ^
> >>
> >>>>                                  * Moves to owner CPU (May be outside of affinity list)
> >>>>                                  * ops.enqueue() still happens on CPU0 but I've shown it
> >>>>                                  * here to depict the context has moved to owner's CPU.
> >>>>                                  */
> >>>>                                 ops.enqueue()
> >>>>                                   scx_bpf_dsq_insert()
> >>>>                                     /*
> >>>>                                      * !!! Cannot dispatch to local CPU; Outside affinity !!!
> >>>>                                      *
> >>>>                                      * We need to allow local dispatch outside affinity iff:
> >>>>                                      *
> >>>>                                      *   p->is_blocked && cpu == task_cpu(p)
> >>>>                                      *
> >>>>                                      * Since enqueue_task_scx() hold's the task's rq_lock, the
> >>>>                                      * is_blocked indicator should be stable during a dispatch.
> >>>>                                      */
> >>>>                                 ops.dispatch()
> >>>>                                 do_pick_task_scx()
> >>>>                                   set_next_task_scx()
> >>>>                                     ops.running(donor)
> >>>>                                 find_proxy_task()
> >>>>                                   next = owner
> >>>>                                 /*
> >>>>                                  * !!! Owner stats running without any notification. !!!
> >>>>                                  * 
> >>>>                                  * If owner blocks, dequeue_task_scx() is executed first and
> >>>>                                  * the sched-ext scheduler sees:
> >>>>                                  *
> >>>>                                  *   ops.stopping(owner)
> >>>>                                  *
> >>>>                                  * which leads to some asymmetry.
> >>>>                                  *
> >>>>                                  * XXX: Below is how I imagine the flow should continue.
> >>>>                                  */
> >>>>                                 ops.quiescent(owner) /* Core is taking back control of owner's running */
> >>>>                                 /* Runs owner */
> >>>>                                 ops.runnable(owner) /* Core is giving back control to ext layer */
> >>>>                                 ops.stopping(donor); /* Accounting symmetry for donor */
> >>>
> >>> I think the order of operations should be the following:
> >>>
> >>> ops.runnable(donor)
> >>>    -> ops.enqueue(donor)
> >>>    -> donor becomes curr
> >>>    -> ops.running(donor) /* set_next_task_scx(donor); !task_is_blocked(donor) */
> >>>    -> donor executes
> >>>    -> donor blocks on mutex (proxy: stays on_rq; task_is_blocked(donor) true)
> >>>    -> __schedule()
> >>>    -> pick_next -> proxy-exec selects owner as next
> >>>    -> put_prev_task_scx(donor)
> >>>         -> ops.stopping(donor)
> >>>         -> dispatch_enqueue(local_dsq) /* blocked donor: ext core parks on local DSQ */
> >>>    -> set_next_task_scx(owner)
> >>>         -> ops.running(owner)
> >>
> >> So ext will just switch the context back to owner? But how does this
> >> happen with the changes in your series?
> >>
> >> Based on my understanding, this happens:
> >>
> >>     -> pick_next -> sced-ext returns donor as next
> >>     /* prev's context is put back */
> >>     -> set_next_task_scx(donor)
> >>       -> ops.running(donor)
> >>
> >>     /* In core.c */
> >>
> >>     /* next = donor */
> >>     if (next->blocked_on) /* true since we have blocked donor */
> >>        next = find_proxy_task(); /* Returns owner */
> >>
> >>     /* next = owner; */
> >>     /* Starts running owner */
> >>
> >> How does ext core swap back the owner context here? Am I missing
> >> something? find_proxy_task() doesn't call put_prev_set_next_task() so
> >> I'm at a loss how we get to set_next_task_scx(owner).
> > 
> > The sequence should be the following:
> 
> Still a bit confused! Hope you can bear with me for just a little
> bit longer :-)

No, thank you! This is super useful for me! I want to make sure I'm not
missing/misinterpreting anything obvious. :)

> 
> > 
> >  - pick_next_task(rq, rq->donor, &rf) returns donor (because we parked it on the local DSQ)
> 
> So put_prev_set_next_task() happens as a part of pick_next_task().
> 
> When we pick the donor, we have already called set_next_task(donor)
> on it before returning it from pick_next_task().
> 
> "owner" is still not known at this point ...

That seems correct.

> 
> >  - in __schedule() (still holding rq->lock), proxy sees next->blocked_on and does:
> >     - next = find_proxy_task(rq, next, &rf);  -> returns owner (or triggers migration / retries)
> >  - Only after that, __schedule() reaches the point where it performs the switch
> >    (put_prev_set_next_task(rq, prev, next) via the pick path). Ao  that point,
> 
> ... and we don't do put_prev_set_next_task(donor, owner) after
> (or within) find_proxy_task() as far as I'm aware. The "donor"
> remains as the task on which we last called put_prev_task().

Also correct.

> 
> If you are referring to the bits in your Patch2, the calls to
> put_prev_task() and set_next_task() is done on the same "donor"
> task. It is purely for the sake of adding a balance callback if
> we had skipped migrating away the prev task due to proxy.
> 
> AFAIC, nothing does a set_next_task(owner) after
> pick_next_task() in __schedule() unless I'm grossly mistaken.

I think you're right.

Let me try to recap what happens in two different scenarios:

# donor and owner running on the same CPU

Owner runs on CPU0, it expires its p->scx.slice, so it's de-scheduled and added
to a DSQ; donor is next, it runs and blocks on a mutex on CPU0, we park the
donor on CPU0's local DSQ, pick_next_task(rq, rq->donor, &rf) on CPU0 returns
next == donor, we see next->blocked_on == true, so we trigger find_proxy_task(),
inside find_proxy_task() we see owner_cpu == task_cpu, find_proxy_task() returns
owner, replacing next, set_next_task_scx(owner) triggers ops_dequeue() +
dispatch_dequeue(), removing the owner from the DSQ, then
set_next_task_scx(owner) will trigger ops.running(onwer), then
ops.stopping(owner). And in this case we don't trigger ops.stopping(donor) +
ops.running(donor) during the proxy switch.

# donor and owner running on different CPUs

Owner runs on CPU0, it expires its p->scx.slice, so it's de-scheduled and added
to a DSQ; donor runs on CPU1, it blocks on a mutex on CPU1, we park donor on
CPU1's local DSQ, pick_next_task(rq, rq->donor, &rf) on CPU1 returns donor as
next, we see next->blocked_on == true, we trigger
find_proxy_task() on CPU1, find_proxy_task() sees owner_cpu != this_cpu, so it
triggers proxy_migrate_task() to migrate donor to CPU0, which triggers
deactivate_task(donor), unlinking it from CPU1's local DSQ, then
proxy_set_task_cpu(donor, CPU0). But at this point we're not adding donor to
CPU0's local DSQ. I think this is the part that is missing, if we add donor to
CPU0's local DSQ at this point we would effectively fall back to the "same CPU"
scenario and (in theory) everything should work.

Something like the following (not tested yet - about to).

Thanks,
-Andrea

 kernel/sched/ext.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index af9b10cd82c4a..6125c4cbd6d64 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1915,6 +1915,22 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
 
+	/*
+	 * Under proxy execution, mutex-blocked donors can be migrated to a
+	 * different rq (e.g., towards the mutex owner's CPU). For sched_ext, rq
+	 * association alone isn't sufficient for the donor to be picked again
+	 * and drive find_proxy_task(); make it immediately visible on the
+	 * destination rq by parking it on the built-in local DSQ.
+	 *
+	 * This task is a scheduling context token and isn't supposed to run as
+	 * itself while blocked.
+	 */
+	if (unlikely(task_is_blocked(p))) {
+		clear_direct_dispatch(p);
+		dispatch_enqueue(sch, rq, &rq->scx.local_dsq, p, 0);
+		return;
+	}
+
 	/* internal movements - rq migration / RESTORE */
 	if (sticky_cpu == cpu_of(rq))
 		goto local_norefill;
