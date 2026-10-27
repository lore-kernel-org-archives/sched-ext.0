Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793083430;
	b=Z8vhN/6KNrESZMR4UrBTpMN7uv/pQ72OtLrJeACtjpQmfg31FnWfNxEhkB14gYVZ7/Y4
	 sT3Wewmiw7wHt/8MNblQd6IJqRRaDflLZj+RPwtXJSso/QrIE1nnVFXTTLzxetx/v5PQg
	 nYV6BrshsZFmO/CHP4XP7krczddNlFNU6gv1zstRZCO21ggsTpYY/OpBu1jN+aM7MZhfK
	 1CF9L1Ta8N3zaIuCfWAn/fb+bp/MVYDBrzeWNMGqzFG+WT5v6onSlKffzZXh5rmiIiLMS
	 anZ+thl3z53uzYJYC8W7FqyMiB8qWjT2dLVgd3YHu1JGCz0rclbQpoIZW9at92xP6Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083430;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=h8FpjP1nrdbASzvpv6u2ZxVkSPuM6COfzl9S9qhn2IE=;
	b=hJCIAxM2paPLfFBdpoGFkMSnp2o9de/Os1D5U6h/9+TGX3rLD2lVw+aiPTBCOT0AnKtC
	 a3sGii+FteqGBgqyqtT3O5mmnABAEEk8bgsBIDmyfaVx+g0UgocrA3+YC4MZYb8rpXUs1
	 jiI1H+BHayhTU5NIufacNXU31pIAWMCHy1xP88QImUtjbp+8psI2fPH8JzrU6UFs37e+3
	 lDcFN7Q0CCqQXq7VOEH83Gst5SS+RbsN/mJFKfOYNSDOBCC5Wz7wMcIt5A4/HzzzAvO53
	 oOEvRevqg8XngBInwb+0PVjCC3t1vxKFFcdKltbDfuMh+Nau1DzK/P6VybeMwCjZH6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OIQ105Vh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.23
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694D606A31E
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 06:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4694D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OIQ105Vh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5i8UYKJlECjwoxC3o5F4K/Ce1tvCHt4yvj+gLw1Xh01IhuD4SBBwzrSbCQtjgGRYobB6DYSIIqDVjYV5ILrKzHaSkTZXnLlujEIdoKnzqpwL/c+Qi7PRwuTrSyj8C2l+CPWifEK/jlnLnc0+am9Evu8VqfL1DaOQ18zdl34poMN3HXQ/um7NNKTLv6mnjsLY5yp3rcMI9P7RDLb3PsyYS+sjIz+2jX3jgFXgUxjxBAkOzmGSR75QTLofeYHPo806WFgXFxVRfhufm158HjuXMCb+8m9UdC9SRPdfoiTcJJc+wjKE3QNK/fCsrmw4UoF9/ZKcDRXBHUZhrDh5Gv0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8FpjP1nrdbASzvpv6u2ZxVkSPuM6COfzl9S9qhn2IE=;
 b=r5rpqkPDpr9OXHGVdrcIjfELPoizMQf6lgDpMcBdZrewP4Aq19y8XV6Own3gl6tO7u/KJgCK7pFUCnbpQAroTIzrY0E5g+xgR1891BO0qlqeY4Pn+Z/Bva0RegnQ7vN7bMXqiib2nLKnAiFeME8nmji7ErUSV91xQAqPv6VbBvKjrpXg04IHXp935B2F6MBNQAWJV+Ja8k5kczbADh/GCO6sT5o8v+Kw2/yoyXdmHW9S752t3LOeTjxLsC3Iw9/smgP88hKULina5rEFOkS54ZI4hueV2PqMYZXJC6PZeukeduSE/BemTMDRsN3+mUrtRzu4JvqH+9MHsAz4tAHEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8FpjP1nrdbASzvpv6u2ZxVkSPuM6COfzl9S9qhn2IE=;
 b=OIQ105Vh/em7PlCdl1h8aDC5MVfckOy7rv7LF5ED/Ek/WZl9Vt5mxzmX9VmuDXJ74yLw9Y8foC8SCevi9FptWETinxRPSCuliiskTYwbJNQJpTonACMZLawhEMcz68Td4deCX7LUlBosYEMcc1EucjGZQBPDAX837lF1/zL30lIhtlPCxunY29uwTEuiRm6bwoAnVOyHb8HtvJCZwfhuStAhfaP5esegWpV+qKy2hR5J5nfshhIyFsLhkdq6Dd1xOkE3QBK1AvYagcIZlzvmdUyondgFltQ9/BkzPe1HZ67P4HCT4Fhip5NNo580kHzl2ES4+8vOosUkTl0HkOUv2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:43:46 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 06:43:46 +0000
Date: Tue, 27 Oct 2026 07:43:39 +0100
From: Andrea Righi <arighi@nvidia.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] sched/numa: Leave the placement of a BPF-scheduled
 task to its scheduler
Message-ID: <auBIGwZfPR9oDPH6@gpd4>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-3-arighi@nvidia.com>
 <8464e356-d1d2-4aea-8702-40429c63bac1@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8464e356-d1d2-4aea-8702-40429c63bac1@amd.com>
X-ClientProxiedBy: ZR0P278CA0069.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::20) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ffb6c0f-a6f8-4d22-671b-08df33f5a643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|261026121527099003|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|10067099003|261022075727099003|22082099003|18002099003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2Kz9y6LeW6KVqI8dWRx1aL7fFdY7TYkx/1GrfqQoiZEz0t3wL46pci3g2n/cHjekeBx4P6amU0EToGPhZbmlUAy7NosJBRTRjbGGekknIxwSzNKugXVl4D5HDEct67GQnUMfVz6FZt54/jP8CL7dJetIEp1M8uultkyWEupKpwzL9F3mnoNd7BNaHTl7F0c6BCDMKMu0unUFTboAjnumxkFO8GAl1v7DdlZgrus50maG+yGkyAo/Zp1/46Sv9NbRoZivk+2xV70qx/TP6i4SxAP7dywgiHPSbjqL/SFHM2Nq8mM1cFSe0GC34Bg+Y+59NAua/lwMH0ImcpmfH8nBzlmFUeQoxqm8PH/LHqatPe0Oshuja5tsO+M1XvWaZFowhdkNyFvjQwa7ra0iFSADxDxfiv0cSzQIo/sjuIeIto/o4IpVfapcrpRetMO55jsHcRi6QIXD7Ds1atnV6zyJTRGEMOjkmGdma0ySy7YT8ZQC55IJHmCAcuMcnf8LU1RpC8UZ5oo462ggoaIQ7Z7t4JBDMqFoQyh7filHvxRFjLZkJEoKrM65n1udVAUQS2qwF3DFARafobPK+8p9EeKbXHlcKvRmDXrMoT8Y2Nv39RqDWu1S3U1exJ4cWTyPO/Sy5V6iobr6mf3GH6FQgOCvgoHRrHp3xIY2QqNRszNKyDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(261026121527099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(10067099003)(261022075727099003)(22082099003)(18002099003)(261026140227099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8if8tSqyN4Y8xHXb6JJlbMo0aFG8hSiT94v5hUTkISdOS+7e0DoLPd4z+am?=
 =?us-ascii?Q?vJc3F2wLBGU0DeD/vHbEQMVqbsbUIkgwPBtEIGJZacl6vpeDLPpkj5V3HGQE?=
 =?us-ascii?Q?oGtPEpUFnvr/vkkWvZOVZexPa8nCnduydpppiVpeQB3pwaWVTQC2XLAmADZL?=
 =?us-ascii?Q?apWtEvI5DIVZ7GU13NONxLUIJ4koK5KvBRrEPi3p5w2D4yrMfjoHIIHAhT+R?=
 =?us-ascii?Q?qV5qCMXyHRJDK6eHJX7CkgTghPrTWwIX/5k4eCdNz1KgdHHdScwH525e91fi?=
 =?us-ascii?Q?u8X1S2dHWOBZzfK7TolncHTmAGk5RaE+xEu0KxcHDZp99US8Kugu5PxNSOKl?=
 =?us-ascii?Q?1jU3bTsnsGTRPquc47YkKfkGeHZJ3X45oYV31Ke7rq884/M7TGJ5YEgwoi+S?=
 =?us-ascii?Q?6Hp7doJ2Bu4IGLSsi5JKTO+E8bOrBVr5rq7n89xsDh5vVzEJp4FYuUkSiEzM?=
 =?us-ascii?Q?x6+YH8aGMUOeSRloTFPvgV1VDJxraz7C6+N1kAKfET47jOBsLxm396v7RGKo?=
 =?us-ascii?Q?0txB/PMkBkZtQSE7Ml/T1TGPaSiNSmjSNTRc/p08KF4RpDS+axXSbjTPM25U?=
 =?us-ascii?Q?aqJPLt+e6nStnQNd5RYlyaoaDeqikIJuhmW8kz9Kym6wzuXQ0QljfKzrXmzK?=
 =?us-ascii?Q?9eu6hrUDJsnm9NQHyhj6v+dd6zcrdCQsszcfJJyqSPcnFZIOOgZm4UWfhHgh?=
 =?us-ascii?Q?Nr3cNSXjJ08PY/8U1XCRslfFlQkTGgie+3be6d7r4pvjBQN3udBFqq5aGrSt?=
 =?us-ascii?Q?7nb7pNMbgllWz4SypL/5P+nS9q7uvutWCwixaPzgtp5VuAr99JjrH7DPB+HU?=
 =?us-ascii?Q?6Cpblv+Pc84tWAyGRUzZ++n5k0LF47D8gbO1lBkZXa++WWtWL83xdCJz/k3n?=
 =?us-ascii?Q?es/cep6fjvYw9T6cguDkPwji0VLQSOJ5vm7JSVMkA091fsAMZWju7JufrP3w?=
 =?us-ascii?Q?U9whTr3xRllQUz1dU4QOOVuRlgyoqJpXcW0pwkcW1xeSn8v25rROtRYLlqEg?=
 =?us-ascii?Q?Ub7xgNua0EusVTQnpsM48Rvexr8Mpaimeoq4quF1Gq1ayQwCBISBQ/a+z5y9?=
 =?us-ascii?Q?B4LFDGvClHEAdRzA6w+GVQsXR6lxEZiiT3qtM+jEy8G8Th25bv+lQpP8hmhc?=
 =?us-ascii?Q?C2kGaVLS4P6xBk6KFWntZ/k7Y2qWD160fvE2uqkQ5dIo1ANWtFuqZ5he1X9A?=
 =?us-ascii?Q?WLdxjZfJ5o1oBcDIfvWE1W5vJz2LBi4eH/GuV34vjMe7PQwN0ezjK/J+0V4U?=
 =?us-ascii?Q?pIC3ORlqa57ujyLty1DRnNOnrlG13JamgKFVxL97Nan0MPjZk+aY6A494N/r?=
 =?us-ascii?Q?2yPlWE2ATKEPmSJ9BUuTDpzMStpAE8mqWlSC2+PaIXfsH7JgM5Cif5bbuYEt?=
 =?us-ascii?Q?wmxjSP/KPzXepLfaz8edQDH0Enu7VZK7Mu2uAHegF6prOI/erDuzL3sEOl/T?=
 =?us-ascii?Q?Y2CH50Rt83F2FZSwEThG50me3jfvEA+Fbwb+S9K59fYs3Y3RWIwpRPi1C/uf?=
 =?us-ascii?Q?f72m+vb1ra0MNEVmii8dGk19UOJEe4f1p/L6E3JQMjOTRrQUelG4yp54t8JR?=
 =?us-ascii?Q?HTP6BQkb5nkejYaLBsnmcwoXRwIn0UuR/QGFaDUtppnyzX2LTGET5LyvJucO?=
 =?us-ascii?Q?eS5/nYHVjrMmIgpLPjM6PzmoBIsmugUANH4Ogw6IhwlikEVpNFImFv4pDjAd?=
 =?us-ascii?Q?MrGFGoWQ/ojYtthUoXGwXyIuZkFyvmunigA7WOe9SVwWrH/OXeNQUn7Ywtjf?=
 =?us-ascii?Q?EEDL8alSng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffb6c0f-a6f8-4d22-671b-08df33f5a643
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:43:46.0777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvUNq8kCbdNONb42dKB7INiC+Cp5pavfCx5sJg+knYSevGRHupPsf6suSI+qbV6Q/gGj3VCDXm2hoBNPqdZrKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109

Hi Prateek,

On Tue, Oct 27, 2026 at 11:15:58AM +0530, K Prateek Nayak wrote:
> Hello Andrea,
> 
> On 10/27/2026 9:43 AM, Andrea Righi wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 36df9a4dde534..5064c7b707f4d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3267,8 +3267,13 @@ static bool task_numa_compare(struct task_numa_env *env,
> >  
> >  	rcu_read_lock();
> >  	cur = rcu_dereference_all(dst_rq->curr);
> > +	/*
> > +	 * Never pick a task under a BPF scheduler as the swap partner: its
> > +	 * placement is left to that scheduler, see numa_migrate_preferred().
> > +	 * Moving the faulting task alone to the destination is still allowed.
> > +	 */
> >  	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
> > -		    !cur->mm))
> > +		    !cur->mm || task_on_scx(cur)))
> 
> So if you are here, it must be from:
> 
>   task_numa_migrate()
>     task_numa_find_cpu()
>       task_numa_compare()
> 
> but task_on_scx(p) would skip this and it means a fair task is looking
> for a swap candidate when scx running in partial mode right?

Correct.

> 
> At that point, it feels fair class should be well within its rights to
> call shots on the swap candidate even if it is an scx task.
> 
> If scx has a ops.set_numa() defined, it would have accumulated hinting
> faults and the CPU it is running on is a wrong node anyways so the
> migration shouldn't be bad in grand scheme of things. If ops.set_numa()
> is not defined, then the scheduler doesn't care about NUMA placement
> and it should be okay for a fair task to acquire that CPU.

The fair task can still acquire that CPU: with cur = NULL,
task_numa_compare() can still pick the destination CPU for the fair task
alone, and once it's there it'll preempt the sched_ext task, since fair
wins over scx. What the check prevents is only the other half of the
swap, which is fair moving the scx task to the source CPU, overriding
the placement decided by the BPF scheduler (the idea is that fair should
be able to preempt scx, but not override scx's task placement).

And the fact that the scx task is not on its preferred node doesn't
necessarily mean that it's on the wrong node: the preferred node only
tracks memory locality, but the BPF scheduler may have placed the task
there on purpose for other reasons (e.g., close to a device, which is
one of the use cases that motivated this work), using the preferred node
only as a hint.

There's also a more practical problem: the swap decision is based on
data that isn't maintained for sched_ext tasks. task_numa_compare()
does:

	load = task_h_load(env->p) - task_h_load(cur);

and for an scx task se.avg is not updated, so task_h_load(cur) reflects
whatever load the task had when it left fair. Similarly, if the BPF
scheduler doesn't implement ops.set_numa_node(), the task isn't scanned,
so its NUMA fault statistics are stale as well. So fair would be
deciding the swap based on frozen values.

So I think it makes sense to apply the same principle as in
numa_migrate_preferred() also to the other task involved in the swap.

What do you think?

Thanks,
-Andrea

> 
> >  		cur = NULL;
> >  
> >  	/*
> > @@ -3645,6 +3650,14 @@ static void numa_migrate_preferred(struct task_struct *p)
> >  	if (task_node(p) == p->numa_preferred_nid)
> >  		return;
> >  
> > +	/*
> > +	 * A task under a BPF scheduler is placed by that scheduler. Keep the
> > +	 * statistics coming, which is what makes p->numa_preferred_nid worth
> > +	 * reading, but leave the placement alone.
> > +	 */
> > +	if (task_on_scx(p))
> > +		return;
> > +
> 
> Restricting ext on this path seems fine.
> 
> >  	/* Otherwise, try migrate to a CPU on the preferred node */
> >  	task_numa_migrate(p);
> >  }
> 
> -- 
> Thanks and Regards,
> Prateek
> 
