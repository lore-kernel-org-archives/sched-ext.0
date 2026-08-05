Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5583AA4E4
	for <sched-ext@lists.linux.dev>; Wed,  5 Aug 2026 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919824; cv=fail; b=TFYp+tjStZBiLtAct2X2WEGmrAXK+Emm04T1XSrxZC02iajCj8E2u9xZAwD9u/ULx329cj07dkztiEAYsP+c26WxQpDZ+B2tmeI66uD+HE7hiC+m2YGr81E3jbhX+9XXzE2GIYHC/qGJxkbyufDDu5b+GMLMZ+5UaRytGjUhSSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919824; c=relaxed/simple;
	bh=dXe3EcE0nR8hig/M6mv2iSo5vXX+R8PWa7IAzliltmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RzYGfZhFpVLt53/1HVteemlLE76gwFkUmKxi85LiSt7pjS5IQSpOJIRdtzMQbLeZJDtkraLIrKpgZ4ysnLITkISg+p+lHOwaCXyq9zaje1mRYqFEDDKXfEiDmNoiCQUGjuGANz+skpuQrHVo5dV1VhxD849xhMlkS66rB/qrrM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RK5TPCfk; arc=fail smtp.client-ip=52.101.48.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RK5TPCfk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViZIxBKd/v0rARlzFf90qnEhflIv1z0ukztWltHIHvZLpqAT8GtIaFsBp7dZJMxr5BGqlcoHG5885YmjjN3Ph5Ogy4JfOaPXStROejLdzQeIKQX6OmTcDvPmln0njIwFmd2CjXgK0OQwdzxLS3PKFDPtt9HboOUjEndP7vq9ltUxAM2geu/h+nDH+QgAG/fp7jR3rNr57dTB84BnKKd9rM9HeLZMhQJulsvEidaRCn+2eagZDGrFN5N6xuf0kwhX6Jf3tQjhDmkSmvA/uLx5BYwylHWn763eh3gudjP7kjxu75BK5GmymS5JEphIrQMmst8boBkhiRCB5RyYdD7m0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT5pQfTryJjNiu2C2VJ+aeQTASvJTV/10Ok1PtmxhRU=;
 b=SGI2yiwBiY2jHUjKJkagUxJVzktQgFKAoCN0R3h0VVmgUZFqLjVhs+xVBWM+gVBJiP9noFiuzw8Bgkudc4PC+MNs8oD5Nzwu+4ieQ+Kie5mWBtLteu9BTj6qJFpzYSM0m1JlpGtbI+bKjeRyc+DGCWLVG6jWJIATMP84uSprOauYyJNuTrz5fiYg3VfSM+mnOkBKMaX734DQby0F/YZRrlT7i+pjFJ6txOfQtgq4tgr/DlWDK5Yza4p7sJzEH+hqf0y/v4FFJ5fgUt2M09ng4rlmHyjlX1EW7gnCxZh4Op10nGCnIfNNLosVK8boKkofZgnxOjQrfZ1+xbXpcFChAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT5pQfTryJjNiu2C2VJ+aeQTASvJTV/10Ok1PtmxhRU=;
 b=RK5TPCfkPQkFy1XNGVQaGGPIOWqtZaQxEA0ayNiyKk3ukHKYfQEA+NQMi8lgHTHkou4sYCSh7AFf74jPWhIfgnBzxyiwEp2spBmetAhFvjIU8ChKG/QYdUYJhoXKU54f1pk0ygFnpHwRQaKJxI2biqMyfLdT9AT9cj3KMH+rLMbhh1lpub91Tts/mbq2X0Za5n4UOJGeNkLQ3SJiQ4xKNUxY/QGjMDOgmVD/yALY+4A4632SsfzsQsKc/BYmZ8jKrlumIFnaLl0OYLed6hGoQEGEPMMgt783211h+HDKE0cxIvbaD+mx53CO/PWMHqKa23myaPuFb8i1EHoNige52w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 08:50:18 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 08:50:17 +0000
Date: Wed, 5 Aug 2026 10:50:06 +0200
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
Subject: Re: [PATCH 09/15] sched_ext: Generalize the reject DSQ reenqueue path
Message-ID: <anL5PpLdyI2sK74t@gpd4>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-10-arighi@nvidia.com>
 <anD7hCGZ5v1TggPd@slm.duckdns.org>
 <anD8MxW5H0jBCppN@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anD8MxW5H0jBCppN@slm.duckdns.org>
X-ClientProxiedBy: ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8d31d0-5a80-4f32-63f4-08def2ce92c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|22082099003|18002099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	dV4Kiab61SQl1kqjzMxMw2E1mxkIy1HdWx54PiIMnecaCkbv2ef2WjGziF+HI5LzuRUN9vWUEbhWJESp1n/ZyjJu3Tvt8khOx+qHNikoOkGDJLcunB9+OGdJYqdG5CMr/w2I1n/Y+zvVu/vpDpAOnHVIOsOPX9FYIpdDAoQqN8cjkArjBcSe2auTYv5EDdJdDO5pWzrauadg34Cha+2v/2JGyBjA+5yZjZShLH0xSo9o58oruq4qswTxlOADoNMc4rp6SufyVaehRCpyQryReb39FR1hYj4/1VFGHM+xBi53AmxV31BODnXbXg56wSZ+vmKRAqJJdrHoE+iyeNJlnnI9oNGpuhDgzHvwH4RyPzgaVQxsOH0VhgZFdUs6j/dumvmhlGvsjfV8TrR6MV38mATEqoxjfyBFOyEIW6gyq/mwYrZ0uoPj25MtrPHoTwl1rjy3h/bq9cR9a460qqSqtM2NHcDYJKnNRlW2btiVKRNgpKwU0ipiqMa7NMFoKAB34EPNSkjThGwx/uS5OYmsp3bsJ1XYkKlVQwzmaxdD6d+KhAT+VifRaT0+NISjZ5LcpFk4+qqhLoVf4JtWrJMKyFNK9phrusHjwU+wFajRjsEFjkDkkfEuuguBSmWlKQBE/SRKBDDsc1XEvPyyOjvprvK5u3C+kl4vvEy1s99u244=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mvat3UCykKZfqxz9tqaaqmyOAjpOPb9G7+O5wb3qY4z3ujmnX043qrn2ohhJ?=
 =?us-ascii?Q?YTBfvrecuEjkwIZaRE7WlIuRmCqGQSyt3kWeR8hpPxK55IowWbEdQHnRGexQ?=
 =?us-ascii?Q?GsQhIHRTpaaSF05CpwcgGdKjciobHo+g9axyxUneQItYskk+FUN5k+O40vVy?=
 =?us-ascii?Q?lKarCRZ42Jb3TOfPRFl3nmWwXqeTmh5PwYADUi9e7me8zwEkIqYTMxoF/eqi?=
 =?us-ascii?Q?rQb0FudIeh/TKCpU29Pp0OBtwqHDPTpjbLFUjTg6Fkl7KW+DtdH0IT4/rLZJ?=
 =?us-ascii?Q?hoZfSXbTep+3Ba4fiP2U0oOUQlN2+xgmnlldUvE8ZZrMGNWUbFKlCJaJyOQE?=
 =?us-ascii?Q?6iAiotUH/zBiyNq2WC6nXY0BZjz+FfwFvhQAyDsNulCEm7/wQgBSs62USVDu?=
 =?us-ascii?Q?QEywNHHezCKZQBHitfKSL23Si6NSx+yBMhMJnsV70V3gLuoaucHsEFnRgPKz?=
 =?us-ascii?Q?8W73QoHxMYNjqgHNaJ4MWcs5hz/3WLPwyyqQJvD0NdwqwxniND1p66Yi+QLP?=
 =?us-ascii?Q?i43UVa8ln0BpFslOpfQwK3JHjLNvABinZ69yD7F9Bur1dwvccwhTYC8qkf2h?=
 =?us-ascii?Q?kfvJsYNyFRkcipTx381jeCmSiEOKSMb9IKa6I3nOrIU1WPDnYECppeTQjKZF?=
 =?us-ascii?Q?VzPz3HiVKF78Lj/gwAUZ68+X+szYqdGxgMpQPvb+E2gHAySp6HzZxxvWJ9Ls?=
 =?us-ascii?Q?kdnIfI03KxmhEd3IHatTo2OP9D3DHIePpBpzu45ecy3OElEcNlpzOhDcBQzt?=
 =?us-ascii?Q?Rl5zc9xCUDbMNsv5EdqAk++FAL52V3jFORTASTj2yjmUNexe8sZOHych3F/y?=
 =?us-ascii?Q?k/MbbzTg0BuBkiHrx4c3JCqTIWdhFQOeROdNGgwqocN3uWeIq6KLELQ3n87B?=
 =?us-ascii?Q?uWfPpPZLj9lEtvdjk4r2MukHwV55N5+r253aao2xqnBYbRB3DP3VZoBZ3jHs?=
 =?us-ascii?Q?eq3z0GpVtmYF9h97/mQkGWXw676AwGJRtum5Dr8kvckPKGMRbjHhRokcIPze?=
 =?us-ascii?Q?XxoEkK2PqvsRSeXC6LGD3oQKPjs3SeCuVZU8gIJVUAXeWMH8rpeRBnF3xCCr?=
 =?us-ascii?Q?bJszRo7uqU0eJWiLnUFK4zHGPflLo+zDXpUfgzVxUHgp3AgTsbpyOfZ0zO/c?=
 =?us-ascii?Q?s3MUoVT1iCnGJA4YEFJ67XYByMKveGr4aw2FJg7ER952SAoitGk47JochoFY?=
 =?us-ascii?Q?inD87NMAuSHES2DSUy5i8YOnbwTatdY+WHOUH0CqFbW5BEMPgu2o3gTFXbPo?=
 =?us-ascii?Q?xM7XIReN4Tr2vNfVWYPRGGxzm1FWAz9WUXt+CtZ/4aZs8TRL+XxksRoXpdjV?=
 =?us-ascii?Q?xokGSCuD48cyMZH3QlFA+lRVTY3XeqvIt/nhyP4uwAZHwaSPdhrTYipgA7jy?=
 =?us-ascii?Q?R2UhRNfzNUnqOglKTHFvo/R7FZMRhbmcdymeaWw6cFxOtNNewfqB13kEQPxW?=
 =?us-ascii?Q?AnrlmkKmx9jPt/+RnUsPQxpALrPI/F07+XO3ZnHN6HGVNuSos1y6AAYFYR8R?=
 =?us-ascii?Q?h+l0sywBwecq80r2JqW7mfLImz5H9jInK58KS2B5XAOWffkveZqkE4kvjfAM?=
 =?us-ascii?Q?7kWWmS0/A8Cn4zgNAb/2MnVw2o4bnSay/f1zqq+XaiNCJI0HXcM2xXVISmyB?=
 =?us-ascii?Q?zqVrizdxJdMjj0uLNrV+sdqMyDuBK0vBNloFulLjSpkzao8yWQlTJkzD9Von?=
 =?us-ascii?Q?YgD7umK9E3/8vBv4iM2e2HSNRTJIRG8bdzANBmbLWVhJiCqJkB/0b2zv1K1I?=
 =?us-ascii?Q?p4wLg9tXFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8d31d0-5a80-4f32-63f4-08def2ce92c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:50:17.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YblXD/gGs9uTJ5VWjEDmS8So4rFFh06Zb84EPTGWQN3Q0ttaaQHQX1o+I8ORXj1vrNVZjvcM5qTdS8iXO8SCQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760

On Mon, Aug 03, 2026 at 10:38:11AM -1000, Tejun Heo wrote:
> On Mon, Aug 03, 2026 at 10:35:16AM -1000, Tejun Heo wrote:
> > On Tue, Jul 28, 2026 at 05:43:27PM +0200, Andrea Righi wrote:
> > ...
> > > +static void scx_reenq_reject(struct rq *rq)
> > > +{
> > > +	LIST_HEAD(tasks);
> > > +	struct task_struct *p, *n;
> > > +
> > > +	lockdep_assert_rq_held(rq);
> > > +
> > > +	if (list_empty(&rq->scx.reject_dsq.list))
> > > +		return;
> > > +
> > > +	/*
> > > +	 * Move tasks to a private list so a task re-rejected by
> > > +	 * scx_do_enqueue_task() below isn't revisited this round.
> > > +	 */
> > > +	list_for_each_entry_safe(p, n, &rq->scx.reject_dsq.list, scx.dsq_list.node) {
> > > +		u32 reason = p->scx.reject_reason;
> > > +
> > > +		/* migration_pending tasks should have bypassed to local DSQ */
> > > +		if (WARN_ON_ONCE(p->migration_pending))
> > > +			continue;
> > > +		if (WARN_ON_ONCE(!reason))
> > > +			continue;
> > > +
> > > +		scx_dispatch_dequeue(rq, p);
> > > +		p->scx.reject_reason = SCX_TASK_REENQ_NONE;
> > > +
> > > +		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
> > > +			p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
> > > +		p->scx.flags |= reason;
> > 
> > Can you separate out code movement and actual changes into separate patches?
> > Even for relatively simple changes, combining move and changes adds
> > significant unnecessary review friction.
> 
> I wonder whether the reason can be carried in p->scx.flags from the
> rejection site instead of bouncing through p->scx.reject_reason.

Ack, I think it's possible. I'll split the patches and set the rejection reason
directly in p->scx.flags.

Thanks,
-Andrea
