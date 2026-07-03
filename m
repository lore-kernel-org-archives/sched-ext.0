Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FB32572F
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067867; cv=fail; b=ZwLCpTYBeqKjEjZlk+yKg0CpKg0o09w+um6jK6KVHTRnnZ/bafviBpBaYzDbSSa6rJe8qguhulZyEU9UChxFThekdRKwhAXnAZqvBNNkUhYLyy+MmUaPe06++tuhf0xMgh921lcIR8Kp8hVMIV6+Ps9oG2fg2To5wXx698vbzU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067867; c=relaxed/simple;
	bh=pNbN7cHiE1sbE95Oqv/r3Zpu3r45hxbY31j5K9qaL9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bZZaPnTIQ2F3YZHQ3rRSYrprQw83Ii1Y87HvEmRTqyWX5tErOTEDHZEJ5LN705XM1Q9x9s4NXzJYPIuAibT3y/0aiWZHqOZgJeEMjJRRsBRVYrl55ABqyDsLH4nOXuL6nPbN0parBcfrzSMvbyVWPirRyVzh+H0tmIYWe2JruBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r4sl0XYL; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r4sl0XYL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWak+7wYSBVQA173Ogi05zcRQEiCBQai7Y8DtRMO0mrJUHqDwlU1jS1LwFxptDVeo6tGPiAZies2DQzcjcLA8yz0D22DxYiW1SeW2HEwUcYOAmofDYq/pCZ8n/ZH5Z7bMZZ2DslciV9VF+j1F+lZe75w1May2Sr/jHzafkt4+IRME/PB64mBY+q+iDOVFtF2Mx1x6TLG4BLqoTLTUsk8jYkKIN9GqDrtaeZvU3rcdlpnPEljup9NkmmFLqgHGv3g8Odlm4GcsMeEj/ECj62V9hQSqLKxHAgZtsxqWnRXr28tI8PrSVQ7vSjKFvAOCbiFUzTxleSQeyhqpDphI1bggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaVzmcy+GG7JrFrHMMIMMkeuhPMZjFi6ot2Zp1G3Wjo=;
 b=unC8p5cfzJF4Vmq1nZtdahoBRbmnym4KL3svbzUf34Avb6uXjsY7mjtybVaxHEatSj4+6Z1yoD9SfwyqLO3NvnDVUNLOQ1WGNT+rHBmAr68R4IKykCU3CtHmI9NkSF0jKkZdd76porqvis4Srb1tZQ3N6MNuMTs36pprJ6+JOBLAUPs3h1eA40ft3mSQvv94J2Rrry8J7DsRN2vrnocZIjIUS/C+hrUToGU0A16AqaH0qpTL7QmPK/GuL59Y0CfrIZ2tG62e4KMcMxiyJVgJiZHBHOamIEH5KrQg7n5H23YHnAfJCOMFiBSB2wBjdPTIJclLziB+uF1jFe4XyEQS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaVzmcy+GG7JrFrHMMIMMkeuhPMZjFi6ot2Zp1G3Wjo=;
 b=r4sl0XYLhh8S7vr3uJk243irh1fa0jPllfqVJEOnZVNuXTfQ9hG/Vx2BWDbN9SIY+Hy7mGqVesH1a4sZTOrnafLCUSIi+Z1p+01SNKDuX15nM7nKlxIoh1xdBc9mI802Xw6L4iN9U6ytfPqxK7N9wS8WRQ6t432njbx5GEVdxgzSJMFJBaE9hyeSMBpgvTR1IYHEoXIQRYlruBeGEIqrgxmP+82CU3YvYc56OrqXA729wp+MXFUeuT3QW83YGGxGKOswBN0sr1XvxjqMMHI1WxdTRR0udNB9eBvtEvj7+mh9tjVvmciO77D6goQuZ6rm56Zu3/QQDCTAOt46MqhMUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 08:37:37 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 08:37:37 +0000
Date: Fri, 3 Jul 2026 10:37:26 +0200
From: Andrea Righi <arighi@nvidia.com>
To: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
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
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] sched_ext: Split curr|donor references properly
Message-ID: <akd0xi4q5_0Ynnve@gpd4>
References: <20260702171909.1994478-1-arighi@nvidia.com>
 <20260702171909.1994478-4-arighi@nvidia.com>
 <4c58a564-f53b-4031-8821-206f359994ed@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c58a564-f53b-4031-8821-206f359994ed@oss.qualcomm.com>
X-ClientProxiedBy: MI3PEPF00007538.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4ca) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d614e47-205d-4bd9-4dae-08ded8de55f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	C5wuQboMn0U6Ng0xAfotkJUbXR1LUDCVNBPNQo3YBrHSIeDe+Ms6ofy33QD3fG0vdY0REZah9+5CbRo5v+qb2D8gADX0mtkqD8TsZXXa7PtCX3MptTUZpbXojLOIiY/UIxGIBT8PhoZWKqfNAzL7WRFhRJrn9SwWHEoWJ5oHs4+e20W4WFfarKy6jpZnFRSAyUw75XBhysLDsixSwXRrcmkO4yVEkMjViXQ9DP4QqHdZbIjCOixmpCqxwfMnhGkEQW8Bba0HgnDIVPwjpk61rDrrKmSYX2bFhbBUUY4MRl9zKROQYd90ktICjEDnDbaWquSocOkTkn2zvPyTP18VWfNXMyBf4q9VAoUaPZ3v32vgeClxyR7zk5TH/7QdjL9FX75PIuDdAa8RZvAiGoj8vTHJgWO1ocqgN6Gp+jWO3H6K3HR/x8tt6QtIYIV8qOdT1c6rv4qkp153I22nGNOeV3uhHYgT74Ik3zVvA0MDqdqimiPzg4RvX+xqOojtDjqGty17MREZr74T/c/aqO4Ki84/Nq+UFN+Hj7Obr+EqynnKhPpIe7ukCsvjQBM7rDB7RXvW6HgpslDEyutaOxf/Dbnznvlhr9GJBRtMki5Pv1zMw8xhC2xN910yOAbJluwnTgZKoR9CrYcg95wWDBMfhkfMyGRPTWB01yLsZzKi+FA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v3wBiWUBwDISb65H3R4c6rnxElTwIWbGE0hdzNDTbMcVxXB6tm0q+oRug+3h?=
 =?us-ascii?Q?PTTKzCoK2KEOHgX0IyRfRVTQhkGVj2BRmsxc4WS+QULhu+KFNRkxQRzNERph?=
 =?us-ascii?Q?+GnTMUEXUsJHYbBpLYwAFXVRpG6XqZjh9lAJxg/To6Fw5w6dI6WCwMprAGuM?=
 =?us-ascii?Q?j2HaHFgD1hN0xbczewhXeYADVjcI2K8wh9x3+2OeHTrAThpEpI/SDmw9D4VG?=
 =?us-ascii?Q?o37qbU5SpliPfOEhPg2kDBcP03DPCwOGWLFZBavd8UHkES10bAbYa0rPC6je?=
 =?us-ascii?Q?/u8QgcWQouUoCN8QKgCnF5PhvdxsobdMjvDZOyPm45kOwIi0LyLK3YT/ex8i?=
 =?us-ascii?Q?xkPBu39z9PnrV2WMCX+2LiuRIwt6zCQFUNGaAeVVCnlhx6ZRiUnPMu0T0up9?=
 =?us-ascii?Q?wbv+VQBp/5968diQex9Md6cYT/AT96IZtcZiC6jC6EhS6roQrMsiEgpAsbcT?=
 =?us-ascii?Q?CvXK+5LK5bv443cByWA84lwbI5iYjhec4FJsYhb4rWzmUCzvXuAcCUCZn3bP?=
 =?us-ascii?Q?kgZ0iHfHv/LcW9pyoHLusn/hOpVD13E1UtpU35+S2+w0F4nGXLDruQzrA9Ew?=
 =?us-ascii?Q?pDTDCB5KdCDke/26R+I40aRz0fT6+8tWvDLSu8h59QhizlK6Uis8biUMUgmY?=
 =?us-ascii?Q?wmxmBTWZOcpu9Y6tlqKfDoU53I1YBbSF94jHdCVKtN7kEZq/9EGBT+wUjsGN?=
 =?us-ascii?Q?VXxrRThGAp8aC7ksVFQOEDmsWiPPyK9L+OO2lmpa0iAohUywiKw0hXAx/j8A?=
 =?us-ascii?Q?LootKcGWHU7Qp44glZBpa3EbZkI4sg74fTZo1NT/aleNWXdGwIBhxKXt24Xb?=
 =?us-ascii?Q?6TMUll2Ypb0aQaISbx3NTLMgaA5MmAjaJU+HEvuNRLrICc1BQf3pFfXsSSNo?=
 =?us-ascii?Q?oEbuDc2itEa2o08KSoWptjoK9KSqjXEt0ujbctqgVG7qL6fTBXeh1axTAt5k?=
 =?us-ascii?Q?SjsrY0LSO5nURBTY9O2Km0YuBjhBiF18jw6zR68aZ3VPet5cIDGvLDRpmS+Z?=
 =?us-ascii?Q?oNZFEXGY2ppZk0hj8z0dhuRQ1dGURxF7+t9Ngo5ngHDLnMxgjK/BBOtjXF1m?=
 =?us-ascii?Q?Cs9yM3uFX6Ff+69LwRG27ed3IYHRbJd1DHQ19sCySMSNh8H7X+dxQ2m1dnGF?=
 =?us-ascii?Q?qKN8GhAHWcooMwr825hrcftJcO9hnBiH+JCYUb7452urw5tcIgnbBHNJyqPt?=
 =?us-ascii?Q?BnJb64itxIEY1+uv0I9DZO5taG36/CUpchi7MVc/S1gZqj83B6v1DGlfCOWa?=
 =?us-ascii?Q?h0xjOR6F3S3v+uFBM7EwgGlZY3dtlID950UWtehrwWnVig6H+NlKX+J6sket?=
 =?us-ascii?Q?ZqWyLvzOemQS5CGFbNx7coMXGPIFvMNF1z9fOWofCC71xZZemDu4HSO+626+?=
 =?us-ascii?Q?MMNnhYwN6nszkraoHi25mIEGw87R66X5Vf7nDXwu4IIrKCm3oolqJCrd2DlY?=
 =?us-ascii?Q?Ok7ES7lgsyRKRv9T07H+gYMs8oIjy+0C3bMs5z7yAhb4LikwDxmjpwkfW9Dw?=
 =?us-ascii?Q?qmM+QBQx8E4Np59lQ3SVCbZLvkYQZmhkhZaaAt91S162Hi4nTTeutHdSo1Hq?=
 =?us-ascii?Q?gl//2fMXfkk2EsNGDUEnOzZpOhOxDBoA3GaZrVM9HXEZAs/J5S9YXXumAWyX?=
 =?us-ascii?Q?lAt3Y76nmjrspC0gBnHbyUWCTXc62CEc0ts5NWx8h7ms+ifa8jDGylT3VuXr?=
 =?us-ascii?Q?U+j+F2Jo62Cwk0kemV8y2SwK2VR5EWOeZgNg7bsnt+RAoKdV+Z/VgzL3+XNH?=
 =?us-ascii?Q?4z661NgMFA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d614e47-205d-4bd9-4dae-08ded8de55f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:37:37.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH/GUm2q0e4xpiAntH0xfXgs4WXEIcbrurNzS4o8mngkhEXijLTIQCh4bZUf8b5cQ/pHO7ad//hpIUtkv7b69A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

Hi Maria,

On Fri, Jul 03, 2026 at 02:10:05PM +0800, Aiqun(Maria) Yu wrote:
> On 7/3/2026 1:09 AM, Andrea Righi wrote:
> > From: John Stultz <jstultz@google.com>
> > 
> > With proxy-exec, we want to do the accounting against the donor most of
> > the time. Without proxy-exec, there should be no difference as the
> > rq->donor and rq->curr are the same.
> 
> Trying to understand more of the situation when donor and curr in
> different sched_class? one is in scx and the other is not.
>  could you pls help to explain more with this information in commit message?

Sure, I'll add more details. Do you think something like the following would
help (maybe in a shorter form)?

Let use FAIR and EXT and assume we run the BPF scheduler in partial mode. We can
replace FAIR with RT/deadline, the result is the same.

Terminology:

  D = blocked donor
  M = mutex
  O = mutex owner
  T = competing runnable task

 D -----------------> M -------------> O ----------------> T
 [donor] blocked on [mutex] owned by [owner] preempted by [task]
    \_________________________________^
         donates scheduling context

During a proxy exec switch:
 - D supplies scheduling class, priority and runtime budget
 - O is the task whose code is physically executing
 - T is a competing task that preempts O

Scenarios:

 1) D is EXT, O is EXT, T is EXT

    Result:
    - D can interrupt T depending on the BPF scheduling policy
    - O is executed with D's EXT priority and runtime budget
    - When D runs, T waits in EXT

 2) D is EXT, O is EXT, T is FAIR

    Result:
    - D is visible to the BPF scheduler
    - D cannot preempt T (EXT < FAIR)
    - Once T stops, BPF dispatches D
    - D executes O using D's EXT priority and runtime budget
    - if T becomes runnable again, it preempts the D/O proxy execution

 3) D is EXT, O is FAIR, T is EXT

    Result:
    - Not possible, T can't preempt O (EXT < FAIR)

 4) D is EXT, O is FAIR, T is FAIR

    Result:
    - D cannot boost O because EXT < FAIR
    - O and T continue competing under FAIR
    - O eventually runs and releases M
    - D then wakes and resumes normal EXT scheduling

 5) D is FAIR, O is EXT, T is EXT

    Result:
    - D preempts T immediately (higher sched class)
    - O is executed with D's FAIR priority and runtime budget
    - When D runs, T waits in EXT
    - D is not visible to the BPF scheduler

 6) D is FAIR, O is EXT, T is FAIR

    Result:
    - D runs based on its FAIR deadline (competing with T)
    - O is executed with D's FAIR priority and runtime budget
    - When D runs, T waits in FAIR
    - D is not visible to the BPF scheduler

 7) D is FAIR, O is FAIR, T is EXT

    Result:
    - Not possible, T can't preempt O (EXT < FAIR)

 8) D is FAIR, O is FAIR, T is FAIR

    Result:
    - O, T and D all have FAIR scheduling contexts
    - D remains runnable as a blocked proxy donor
    - When CFS selects D, O executes using D's FAIR scheduling context
    - When CFS selects O, O executes using its own FAIR context
    - When CFS selects T, T executes normally
    - D is not visible to the BPF scheduler

> 
> > 
> > So rework the logic to reference the rq->donor where appropriate.
> > 
> > Also add donor info to scx_dump_state().
> > 
> > Since CONFIG_SCHED_PROXY_EXEC currently depends on
> > !CONFIG_SCHED_CLASS_EXT, this should have no effect (other than the
> > extra donor output in scx_dump_state), but this is one step needed to
> > eventually remove that constraint for proxy-exec.
> > 
> > Signed-off-by: John Stultz <jstultz@google.com>
> > ---
> >  kernel/sched/ext/ext.c | 28 ++++++++++++++++------------
> >  1 file changed, 16 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index 1a0ec985da77d..1588565050679 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> > @@ -1145,17 +1145,17 @@ static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
> >  
> >  static void update_curr_scx(struct rq *rq)
> >  {
> > -	struct task_struct *curr = rq->curr;
> > +	struct task_struct *donor = rq->donor;
> >  	s64 delta_exec;
> >  
> >  	delta_exec = update_curr_common(rq);
> >  	if (unlikely(delta_exec <= 0))
> >  		return;
> >  
> > -	if (curr->scx.slice != SCX_SLICE_INF) {
> > -		curr->scx.slice -= min_t(u64, curr->scx.slice, delta_exec);
> > -		if (!curr->scx.slice)
> > -			touch_core_sched(rq, curr);
> > +	if (donor->scx.slice != SCX_SLICE_INF) {
> > +		donor->scx.slice -= min_t(u64, donor->scx.slice, delta_exec);
> > +		if (!donor->scx.slice)
> > +			touch_core_sched(rq, donor);
> >  	}
> >  
> >  	dl_server_update(&rq->ext_server, delta_exec);
> > @@ -1316,8 +1316,8 @@ static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq
> >  	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
> >  		return;
> >  
> > -	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
> > -	    rq->curr->sched_class == &ext_sched_class) {
> > +	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->donor &&
> > +	    rq->donor->sched_class == &ext_sched_class) {
> >  		rq->curr->scx.slice = 0;
> 
> Do you forget to update rq->curr with rq->donor here?

Yes, good catch. This should be rq->donor->scx.slice = 0. I'll fix it in the
next version.

Thanks,
-Andrea
