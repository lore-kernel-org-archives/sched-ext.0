Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820983DCDBF
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786918880; cv=fail; b=PN3Is1O7XM8BOzs/HbwrzazGSJR4L2cGCT4zk1lW4a/ZP/UTgxSgmFznQq9HGMj2NtFIqvpqxSSeH6mkbVE6g+NUB0eBYdLDalCScNyAOmyzInsz7uwtc/OLihEZ1fFlcUAXS69Kho5UqFYpRyoP+3b2DUAUlj4D2dILu3uM1Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786918880; c=relaxed/simple;
	bh=e2Zsr01uggEfRa4gqfteuduqkMotrZCQuSoUWEX17jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gqvaaSqdrH7oyIbRyFyPR11cctMGN8Y3837GGpSoCT+mJyo2VCEua2xlDF0foiraB3lt8QhiN3DERujf4Wz5VuJVxY15o32MXc9yPMI8YKgyhjbWlKfflz/4bx3ppnt1UpOK1BqEqGedg9Eb3cueth4tP9qsehllDdMZDV5NRF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TcU17Cpy; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TcU17Cpy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaJfPe8JgQt5qj8IU9uQdN/3dKBF3aARzrZDEVNJCsaV5yc6T0LZGvVyyejWR4+9a7MJZ6q7byTxXtCd590DtHnwu+rTs7XXa7LhZvwewvJ5Dkn4ifRIam99I76hwnPllBpCAetPIS7EI8vzXE4RvWsDYOE+LLPMbAjlCYwAIFhBRIjrieTbpk1HjXHwTABCtfNfIcnKL3YvqFxVxctIdj0Wk30g/4hkDt+fh0pnM1ixhTOgDym35C7RUV8dKXKbHtuATXHpVO6iq91pqO0hLCw9pYSX9xf7LgRYrt07PmaIUahHJJrmRucsb/Cx9p3HxvRJVrgdXymCZyjstnV2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITYEpzigUoICTT54z5fHwom6qqyJ2hu5ZmycQ2zpW4I=;
 b=RKmtNVusJ5/h5PeLIpyVJtCSKRuOor1JdNZo101VkkBpPuBJVpJe5XP9kKqcH0k1VodhcWCv4GdmLdUDUvFKbCaKg9XVBAlLNRCJk2kgcgk7hLAGKLAFUgi0jCZtkFVF5ssDxa7GUcKrHWEM3QtiixKAbByl0TawD1i1/wlqr/ohOaomrSKdOcstRTYMeIRISCMVvwlY9v57Yhn/7KcM+XmbEL5Ajytk5rrEJFHW8T5kRRBUL6636MSqi3+vXrosB/Jbhh5lvtbUEFl2iXpjdO/h5/4YJkLKWbt7sNEFNBsElwjLWcDtyWJhEcVN76AF0HWcfISAAN2kD0J9FGT4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITYEpzigUoICTT54z5fHwom6qqyJ2hu5ZmycQ2zpW4I=;
 b=TcU17Cpyz8lrjVlQ9ODkWjeTAZXwluECH8YOXVKbr8EwK9KUBjC43cY05eueS5FBj9QPVtyJ7VW6+3LLq+hxiFLPk/yig3y/eqsMevHodNuY3CeRMKRFEkw7uGTuAXhcjPFMR/A1ep3ZEl6u1FTWkasyyidL6dQ0PCXa6LOk/7QaVm8Izh4FrXrbmTZGy4oOT6ef8hVKgZfPqF2ty+6Sn0OfJEhR/RI/3j+VOBSE4cmjAyZgmZOihNfvwXEIJvyA1bujoJSyvu0zBHMiy5/t4dFnG7kCpYRFIqwC+bPRLXe3wHz5IbYONjpdYPp9SpTfQIA7RjeJbjOWUpkezk0agQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 22:21:14 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 22:21:13 +0000
Date: Mon, 17 Aug 2026 00:21:10 +0200
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
Subject: Re: [PATCH 09/17] sched_ext: Fix ops.running/stopping() pairing for
 proxy-exec donors
Message-ID: <aoI31jCh2S47r5aq@gpd4>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-10-arighi@nvidia.com>
 <aoI1SOEXuIUHl7jc@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoI1SOEXuIUHl7jc@slm.duckdns.org>
X-ClientProxiedBy: MI3PEPF00007541.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4d3) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 39273846-7064-4f5c-79e9-08defbe4aec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|22082099003|18002099003|10067099003|56012099006|5023799004|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	waFkl2gQ8g9yLUdtWjPw10JvmcflTBSM/zJIDEbI+2EGQ8ijcIIuJNdjt1QSbSPhLLij178rDhEiqeBK7GHTvBWFiq17ELgrVmUqgahaeR4l89i0+w3rCtGGA5Vaugr+aBy5pODzmeLMfOSXygJ9u4I7Sx102DXBTbvnygr56eW3W2zJU7f6DV+ilbyhR9+rcbkQIiQLNnLHavz2b5IUZI1DdIG4Lm8MJ1wnIsD2t3IGGQxYN3X2KyFsNGGU2R70HSdQdhZ9WDQgiPPPYm4pn4is/12ObFEuwRXIOWqWoDCP4Ln4dL9Uog3Yx1UoV9dHanseWYUbdnZkSFNSUfjlk7loAiLOe6lzlj54eMKcnfVOshonNCqgBxEGGWduSsGO+eeG8Ofl0fMZDLoRfh3cb2r0paeMisJhcRR3wdhdZR0YKiAfqTjpFtJ6kK3aCJJzSZho+DpOtSKH7Fayc1y9Jiu6x5C3OZLTygUAlp0Z3t2umchp6I4d32Rwknvd+rminNInAIcDedKt+eHeWMNHMYT6yCPaLQQ4gAGxlMKzw3Nh50nvWOknF7kBsOpd0AioWDM2YaJkAjpwQLqW2toZQbDB5fhML+EECSR2PNJygtSGBEqGKPVxLfgiqbuivC0mzdV2G761+gcoevwn0D1/h7n5GYVYGz+I2aN+0Vp84CU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?56wqcHExGL4CLsPKt21/tMnABLgpUQTvlxSg4BBEl7w6Fe+wZphRdjhQRAz4?=
 =?us-ascii?Q?e2iJ/1RFLOFOqXSBFwGAE+KpUNd9OJPnjAbj2Tf0LYGCbnq8MdfQgnWpzNk9?=
 =?us-ascii?Q?wRa6Y7BnOHaKsunL3K0CAyEztpgZi4DX1050q3ntM+1/47PlPNr6htcR0kLm?=
 =?us-ascii?Q?zlrgin6Yx85/3Zx3HhyGfbXc5U3AO6k+vJrEUeNSmqBKd56VwJaKSJyF81oC?=
 =?us-ascii?Q?wc55fF09wpcGqTHIlc/2bJEkbeOxLqM5IhoRBRJte63vrUjQYXZi0xnSiiib?=
 =?us-ascii?Q?dpfrqV6EPjow5MpsjLpE7eDK088pU6I7W91CQfRcVWutJfD0YunJf+QdOhTs?=
 =?us-ascii?Q?5oV+sIJ11D+IKY0XAv8itGX0mxkjkkRi2cwxLMh9zmeY+7pfj/AJCDwPbEVD?=
 =?us-ascii?Q?VdDP16601ml4c9bxxaER/b8pt3Or44xiCMj2scMh2o7zmQq/NL+18Gn1ON1H?=
 =?us-ascii?Q?qf4se3CcYIT/TMm2j6/lz3gKM+dI6E17ANC19kZa31iNYFtI0+ShspYYB0ai?=
 =?us-ascii?Q?Xc76DikzyIbiijngIoLpEMZSbRFKa3x5g+OKSoPx8JlorHkXIRKUdGGV7peN?=
 =?us-ascii?Q?NYX24McIUCTxTHCFriEUhVsA1lZ/+gO6Tus3+8Smd2LOeRPRoaOURtWSzAsa?=
 =?us-ascii?Q?JjwUyACieg61UDU2vuQ2W6b/pmR2iCKUhpjzF+SQCkYHr4TiWGLisIkZVPCH?=
 =?us-ascii?Q?DtoKidxNRMqjRduFXhpiu5XDFprvmRbK3sqFNicPqjWrYcAyyxQdV9OeoJgn?=
 =?us-ascii?Q?6xMlgMGUD3n29oj3wKJUQI9HvEQ+6zq4oFI9cat4fZnmHNJOg7TVn5uRJ5+N?=
 =?us-ascii?Q?axZlp4VBhI4uKWVX2YmG3gejgmJ8AA+30no+jQwlWysNf6WcB21zkIoJCgAG?=
 =?us-ascii?Q?iVDBBZeAatYMN9JGu9r24gFsFLUC1Bli06QKJ3StJZbtxwjOjApAvZ1AzCH7?=
 =?us-ascii?Q?Q0a/1ULEjMxnED4RoQAcbu3Bl1faU/wlWqKo+0Pr/jt949dtUGzuBH7C58Lh?=
 =?us-ascii?Q?//QYeJZxms8mtVL4WdVkPZ7e64BRaIZKVTLZwbmf5GKFfFOIAHKSBi9Kk/I7?=
 =?us-ascii?Q?cM+8FHNIZj9OOLfq3noYC0kVHUvsAzVh+7z3NGhI1Kkmoegg4NR9LOQc3aoy?=
 =?us-ascii?Q?EyhWK49neAPaiPdxkhq+vfQLbYNNyNgXKndvhd/Te3RefR2Y4FV5C6rHsFm4?=
 =?us-ascii?Q?C0SHm5ArWvM+rwUOydSim0b+iByF8ZEnL9Ix9r246sBMgZquylAZzmVHTYer?=
 =?us-ascii?Q?ZIOsToM8svuQ9ZTkgP+bB4EexlAsigXZyhyQcWrRLAexxThPejRQypS3YrJj?=
 =?us-ascii?Q?EsYZZNDj7oR9PjMr5SbE2/yBRSMSHywEvB7WKkMEkAEfAg9Ais5kI/dN1305?=
 =?us-ascii?Q?kFAFTkYEuKfc+Jm1Kdxn+qKDjRbc9hRiFXBMOEeYwijHbpWL7GFCxWOiIHZ+?=
 =?us-ascii?Q?gbenwuTcUazlvVSUPYqyj+rVDL4NJXMNw+YP5QPUaa6IwbdUbE68IE10+LsG?=
 =?us-ascii?Q?h2yxtT+/XnjBRUWRWj0M5RaSZc4Vj6vh71FIHSF2GG+sKtnLFxdAVgYJ7i3l?=
 =?us-ascii?Q?/nkHlF1tfCrT8Jc0He8qNOzY3dbLRSoKsePKTqnB/Ynni3zckD0wbywkJKZD?=
 =?us-ascii?Q?vKQSHiItR4ABTY1RN4P2qAuu9goiTxrpT1S4dszxEfR0EMhszk6gYNVlQWTK?=
 =?us-ascii?Q?cHQQLwegN4856zlwWUoGLQfTqyugcSmHt/YXrkfviUBr1NN4zgFN87hhzXjC?=
 =?us-ascii?Q?P9uIBCtoZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39273846-7064-4f5c-79e9-08defbe4aec1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 22:21:13.9160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3uUItGHJFrR+Bmmav31CmdbPea+SdRnoJFSESmI5a4lCR3sIIDYqNioELuIrG2RP36CiE1lAOSccESTBtm4RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340

On Sun, Aug 16, 2026 at 12:10:16PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sun, Aug 16, 2026 at 07:35:07PM +0200, Andrea Righi wrote:
> > +static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
> > +{
> >  	if (p->scx.flags & SCX_TASK_QUEUED) {
> >  		/*
> >  		 * Core-sched might decide to execute @p before it is
> > @@ -3024,9 +3037,14 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
> >  
> >  	p->se.exec_start = rq_clock_task(rq);
> >  
> > -	/* see dequeue_task_scx() on why we skip when !QUEUED */
> > -	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
> > -		SCX_CALL_OP_TASK(sch, running, rq, p);
> > +	/*
> > +	 * See dequeue_task_scx() for why we skip when !QUEUED. On a normal
> > +	 * scheduling transition, defer starting a blocked donor's session until
> > +	 * proxy resolution succeeds. A restore follows an already resolved
> > +	 * scheduling context and can start the session immediately.
> > +	 */
> > +	if ((p->scx.flags & SCX_TASK_QUEUED) && (!p->is_blocked || !first))
> > +		scx_start_task_running(rq, p);
> 
> nit: can we do !(p->is_blocked && first) instead? I think that matches
> what's being expressed better.
> 
> Also, can you expand the comment? I find it a bit difficult to follow. So,
> when we're actually switching to a donor, we skip running transition because
> proxy resolution might give us nothing or it may have to run on a differnet
> CPU and so on, so we do running transition after proxy resolution is done.
> For SAVE/RESTORE, this doesn't apply as they're always matched regardless of
> donor state. Is that the right reading?

Yes, that's the intended behavior. When @first is set, a blocked task is only a
provisional donor: proxy-exec may fail or migrate the donor to another CPU, so
ops.running() is deferred until resolution succeeds. When !@first, this is the
restore side of a SAVE/RESTORE cycle, the matching dequeue already issued
ops.stopping(), so ops.running() must be restarted regardless of the donor
state. I'll change the condition and expand the comment.

> 
> >  	clr_task_runnable(p, true);
> >  
> > @@ -3072,6 +3090,13 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
> >  
> >  void scx_proxy_donor_start(struct rq *rq)
> >  {
> > +	struct task_struct *donor = rq->donor;
> > +
> > +	lockdep_assert_rq_held(rq);
> > +
> > +	if (donor->sched_class == &ext_sched_class &&
> > +	    (donor->scx.flags & SCX_TASK_QUEUED))
> 
> another nit: no need for line break.

Ack.

Thanks,
-Andrea

> 
> > +		scx_start_task_running(rq, donor);
> >  }
> 
> Thanks.
> 
> -- 
> tejun
