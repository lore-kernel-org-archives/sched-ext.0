Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60E2FB997
	for <sched-ext@lists.linux.dev>; Mon,  9 Feb 2026 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664651; cv=fail; b=o1DB4bFjDn84HAgZHzATAymC9Vpxv8FC+qzhN6ycTzdegtZPpiJBvYPor5u9q91mrWbOERzPSXYNveGL12IJ6Yd95yzOqBHvuvpnhm5c1kXpPewJXtnyS95tGOdnxSqlYn64QX1BqDAibx2nYnKtwzADp2mYyfbi6HqXfccBxNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664651; c=relaxed/simple;
	bh=QRud+Dr4gP2Y2F0sv6X03r9vQBX/lcUv1ro+xHJXqy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rm8CylUICc/a9u8V1aiT2nnU4/L56+cpBw2rw4PQeSzszlNr3KXxJe4jw3sNvSU7kLzRoCqmSsVOQPs3E7u8Szz0Q1gcfJoC17aulTsMAQABHWiHO3prVTrSgVUsE9tqcQBnEcCz6oagBvpyYg2T3fF+vAFfNncJ6sJYQ5hhg68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IpElNJl+; arc=fail smtp.client-ip=40.93.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IpElNJl+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDkeErfyDuwQIGJFQGPyjqF7BaVezrYyUCUpSAmrN1LukZE6ZhfAsrAwapEqzmIS3KI96H3lGipoxsjV87oTC1y8J4z4uSDIDwh6q/UgQosS1nIEB2zBAjh31zBw886K3mG/mTJEyotbHFoK9pjFTiXWGgEec/Zrm7nXFXzjvVJcN4TgwflVuG++BCdLLGYS1hFazzO5NUxvXatU9YKf8L+lZu0ZbWhUA5gI2uDT/pu16YqyKAg/vd5QZLIBTvYVo1rEK4k0w5qWkHCmu12KQ8NTHy96PR1cWjkua4s1gGqsXwRwaQYiX0VyKfEK14aEscQqx2RBhc5r/AB1ZVPY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trxPoQL3hrqX+ruOqdqmYwTrOUkXBA0sehmLo0sFbok=;
 b=JX8d1s75cWok6bqPLu5tRXgsX46RBpP/OPB8Se+GBS4LtiHF0CT1O77FoxHVLlqmPpe+DWQbq/mbi+6Xcl1nfDEozllxBcp9zD7p0r7dFsndelKQtqT7UVlBRM9yFbYyA/c9bRIRCNSPxDhhQKOOT2T/eDTTZS6mn4c3HVd3e3Fyw0Fs+Rcp+V4lpyWhcc7epbkATdsdZvD+fJLkBA0Yp35bcdRFY9b96YBBV5PbDQ+dxCKHMl9ejQ/99yntD1GkiRsE6d02EWFmTiVCER0GzVQeajb4SZ4GKQvLxaxZqU6reu+apNys6nCWxSOtJhJKpUySrBGiS4MIjMKoYRHqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trxPoQL3hrqX+ruOqdqmYwTrOUkXBA0sehmLo0sFbok=;
 b=IpElNJl+4v9Yod1HeGJaTdTvNNq2vM4LLIHwj0jWaOEVNNsTF4SXLO7PrT6dGMkk6+LV7i9oMJ3S40/1ZmZk+F/YpmFF2iqXnRRWjBGrPKmNTnowoo4t7dQ8XqTUog0e+0b1gl34fph7DnwcpEaabDqC6fColJ3BSX3hAb/y3ZySPvUtvK3bLusoZtXUwVFlKuFuawKPEY1YZ9W21FX7AyCDGFmMg8xHI9IN9uqgp5lRFdw5kprBNPw6f3KoWGhlMqe8hk3rF68kYjitgYMpaUKh/Nf9LAOdCbQdWTSv1USIRQEXoFcEnIBNC0/L9HD9sPke8sGafAQupzwtuCBJ6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 19:17:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:17:27 +0000
Date: Mon, 9 Feb 2026 20:17:24 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
Message-ID: <aYoyxIkzp0E5dL1g@gpd4>
References: <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com>
 <aYhRKbkHf-or9lNO@gpd4>
 <aYhkv2K99aqiuwr5@gpd4>
 <aYiVv998mfMGVMCq@gpd4>
 <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com>
 <aYjtOQP0tmGIqoOM@gpd4>
 <aYm00oHl3BRWNFFA@gpd4>
 <DGAIRREHTBTV.E8XTJPHQUAN8@etsalapatis.com>
 <aYoAmES8tKNZJkdx@gpd4>
 <aYoYECCY_k1IrGqp@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoYECCY_k1IrGqp@slm.duckdns.org>
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 96296482-2dbb-4e25-125c-08de680fdc9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?phMfXCpSFFjMSr2UpzqtSZ1uVgn37HTxahhrM3zguUmDtwEYJe03yd66XixV?=
 =?us-ascii?Q?/kDsQMwhubxGc4DUm+my6aEeKhyoJ+7TUwbYlLJwy0lm/30SXGWVuWH9Z9Ws?=
 =?us-ascii?Q?Ury5ubzPI/2LHv6gmPTJOWbkktVDkFiLinxhDB06RDniNAJT8LXPILJfbeRF?=
 =?us-ascii?Q?o3gmBGl7c7XcAfZIRYvdoICqS8tRyWTvYIoPuyiRlTCEVlRCbA7tHrS55MHa?=
 =?us-ascii?Q?x0ZvNGQamPts45EAeMAKBTD+m4Z3Aqz45IKFJLgEVzx/o/3EPaBuw8KZHLmZ?=
 =?us-ascii?Q?53TQmC71H5iMNiSVehSyojhZjZ32QUWSnXDA6uGbentYwv7xYbe17MqZfdGI?=
 =?us-ascii?Q?M9zcsV3+SmNpo6Wsokgbly4n6ska/FfQAa/lC7vZTCYBfEDnbCdiNq7Y6Ypf?=
 =?us-ascii?Q?TwnVdfKGxSwJZPZzc569RJOUBXlu8gxa9huv3hdCd7xBQNGASZFqql9pKaRs?=
 =?us-ascii?Q?6gpBV3zR21gBvakLIz65sKtRoXtQI8kPE8nSoDT35oqCvMaQRWToEvVzmQT+?=
 =?us-ascii?Q?Harpt1pq/sEcomvpPJql3iZRzno2BJxPsEW5r91rcQLi9Le3YElNDg5jmE0Z?=
 =?us-ascii?Q?P2I9qz+ICgEaFvMC4wQJhCEw6sSJImZH3PEDxlteL8palD0I6TtI1sCUNOPn?=
 =?us-ascii?Q?KPa+zfcP3SqTU6DwuF772KR3lHknxgK9TmLBGGit08iOy4j1QsQiC6tWMmba?=
 =?us-ascii?Q?LBsw9moGaxzazbGTwypW6nITaFg8zb0F8JAS7nNpN/ZC2q3nVKbIsxWJp7Uq?=
 =?us-ascii?Q?1ppsVv+TWxKVY2x86DRyfrJK+s+IapvE7Qn3w4s23wsbCf0ti49UoGUFievL?=
 =?us-ascii?Q?l7cnBS1JCgTKnMuQrk4C81Sdz00cIDj1H8jgmX5dMCXFEINLAKCQ/DkRqNqA?=
 =?us-ascii?Q?TvzIomR57xxxM7a1c13MPtraZLexZBXauQ+tAfMS8BBLxc+vM82JCEfd4RnA?=
 =?us-ascii?Q?66iZFSNsrcFodvId2LVYZ373OQqLm10dTaHnWCDkY0k91xISgdXjNzclPMe5?=
 =?us-ascii?Q?WeBCh7xRnToE8L8hq29VNk6+LymN2kGfcO1VHjpwK/6mHrhyg4OFFOOYOFJS?=
 =?us-ascii?Q?fL8pFseIdeE0Qb2o2aTxuFP9yDhxxWdjH7s796ijKk5aO2DvnJwPfpjkbg4C?=
 =?us-ascii?Q?fj7Nbsqu2mxCfHkI0NE5DSwwaFsKOcDnX+zPrjrsCLfZM6tRccilZ+58bf/D?=
 =?us-ascii?Q?+cjm9WtBYfu4jgE68edQBYs9P71t6VyN3aGk9RUyt/0WlCB4Ajp9BmO1nCa1?=
 =?us-ascii?Q?MPNHGBqzjQgOiMNYhtpsns/KWk4IL6oBbp6kjk/uFiG1kqvJaJdgUivfObvh?=
 =?us-ascii?Q?OWIDGa4Jdtlm6H1nbMPx2JjBMSthW3kdx42IrGi6Aln1tiePE29Zf2m7b/B4?=
 =?us-ascii?Q?GuVfDAH3yFCaMBiMbXTmAi9bTt2/8S05dUYjTT4kj9IFkoG5sqNdn1+WGfk6?=
 =?us-ascii?Q?DQPb0thRkyGGSx50+6IgSENzp9k6cqzaI4pE4Fii5V8oe26GD4/PDwZzZhVY?=
 =?us-ascii?Q?snQnEzheApHLUwIaBXw9uEHThnZIFm+cCSRLTwBlBLuK4qxPHJz/KRHkqj96?=
 =?us-ascii?Q?9HEAnF3F4BJwE7YzwVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WaXW/5QOQvSiKdGQJvE94oQYQqvlukLZ9MJFEfEdIGkm8ZD1LViEJiPQ90fF?=
 =?us-ascii?Q?Ekdl7MeHzGNaxNVkNAW5Zb99sXbADNbPG50NQ7SScAFa0MmkVfXdBpEEQLqa?=
 =?us-ascii?Q?NlQJTdKlkOm5zUq+IwpvNaGfglKVyHzEO+xaGKmCX46W4mk5RP4azNolfHi4?=
 =?us-ascii?Q?jQCENNHit9CF21IY534RbFb/6ZVOkr6pSar9t1jfFX6gOchcs6f8VfIEwXcF?=
 =?us-ascii?Q?dNS+8OQ8KbbpjFz4YuHZtcotBckXSJ9hyhAiCAv2oz+on1tRz2pfut8xgAec?=
 =?us-ascii?Q?cdRfIOux82NtvJVFcndJYRlQG2fj3E2ejeyA62DXBM38m6Bf669HGz5Apggt?=
 =?us-ascii?Q?JR00sKY1kcyzjr0o2qbTKudcdPwH6QZD1XFPJzT6ST5y5Mg7V+Y8eTGYtsrI?=
 =?us-ascii?Q?kATdq2vkAtfUvbwyDgJB4d58oLGjFBsrMqoVf0Efq0Ba4PdkXKLcMQWWhK7z?=
 =?us-ascii?Q?04ebYxNWrbTwwbaLPlRS8GSAD9dbj07ntX0AXFJbcFYM2SNCV+mW3ephchcf?=
 =?us-ascii?Q?43Cr5jnvTadg44DdcXTb/a3ln+2F9xH28ABOYQHTNN4jqb0Tifrom1iOzRdp?=
 =?us-ascii?Q?X20MhhkUs6ypa6jz39CB5CJhgtzsHDgXf2jO6qD2JvPbdrE26rrGvo58GODN?=
 =?us-ascii?Q?jOwA6Gd/vaPC2Au8cL3b3fNLotv9xzAxpBTE1TRAPbSd8TC+5TNXu6RuHMtT?=
 =?us-ascii?Q?GGy5kQQanobzzG7DLZjJBDniYin8OARhauEvq3/vsiKHB2aOQS9anFGpg1RL?=
 =?us-ascii?Q?5ATxt2R8UThT6zu1aKAMAhRlpgLL7iWxqtwV+BpmfVueXuwmT3LnZmJd/Ki/?=
 =?us-ascii?Q?vQmnJ1pDPDddr/X67yNAYK/AXyQaEJlLDCqGMQ46Xtao4+HTX4LZ69DycrZ0?=
 =?us-ascii?Q?u0EC6aQbFMhvb/KLB+Xw8+UbtHU0/XQTDR0Dqyq33AgLzBcrdnsTJzYbW4iK?=
 =?us-ascii?Q?s0dUnloCLXHhIHlMM+I2CJ9m/uUGF/u0cAO6ZOzTgMpa3mh58MUgvuub/a6w?=
 =?us-ascii?Q?igPW9E2rZvMJ3la/PHqyGkIWENgePHWUuCEjyYLhdMWrf75udhecOZxwUDTc?=
 =?us-ascii?Q?ZhckVq7I9xCZ7SWUJA0NL8Je3gedkVzVgD530bVL5AFU/6sS8nQgxROGwBgT?=
 =?us-ascii?Q?1tg8LdVE5VeS9+bik4x8UEcNEhNDvYsAS/4tf/TNCbyh4Q/MJk9JAYyXSF1j?=
 =?us-ascii?Q?2fXMwT6oPUlIJfTJJYzLXROFn1J9Z1OVqjtuf4jS8+dWLipicGGCVdjuD4hm?=
 =?us-ascii?Q?jRFxmKOK6k6q0NESC++SUp25Fyulal8Fj2PxjZD4/GKCz09PAHurwRkyZsPt?=
 =?us-ascii?Q?vzgY25NNYJqzhW15/4DfOsq0WQgZku2VTCYiqWZxP2XVoDW4yNM01wRFEgmo?=
 =?us-ascii?Q?+0e1ymv6X4jq096tFEo3TGnz0bvg8MBFB2IJC1imqKmM4OvKlkhNkPJhRYql?=
 =?us-ascii?Q?P91NhWaTpXk5kbyEREYXSvv8JYIT7HEWRLinrVnlXwdYSRDQFE0Xhm3h/9uQ?=
 =?us-ascii?Q?c2LGVRPKRFXnIHwQUM/VGiyJX3aFQkWNDgcQsCGQE7Puw1S6W5oA5NQNkFfY?=
 =?us-ascii?Q?4dR6iowdGXHdpBYHeJ4pBevqoq2Kfsgz9VpBoEQNkWpYFPXfrBqJr/IKrDtD?=
 =?us-ascii?Q?IPVMHbXqurLEvJdEVmZ13n/E4zpLa4uTmvAVJxwS74o0BcMftKVy+wPbRjrk?=
 =?us-ascii?Q?XQZed299wxNZ+D6Y+dkynCNUYmTew5KTIM+WTig7AU3xqtXg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96296482-2dbb-4e25-125c-08de680fdc9c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:17:27.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKppkueHAOFJ6K3ImMlHgu6/7SMduTDd8Jp75kbCvEWKShq5AEF3FL3ENl0A2C7B1TwX8OrL1stF7POH3HiUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

On Mon, Feb 09, 2026 at 07:23:28AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Feb 09, 2026 at 04:43:20PM +0100, Andrea Righi wrote:
> > > I agree with going with option 1. 
> 
> I think this is the only way. The only reason this is a bit murky is because
> we allow direct dispatching from ops.select_cpu() but if you look at how
> that's implemented it doesn't really bypass enqueue path. The task still has
> to enter the enqueue path (as that's when the rq lock is grabbed and task
> state can be updated) while already knowing what to do in the enqueue path.
> I don't think it make sense to consider a task to be in the BPF sched's
> custody before it has passed through enqueue. Note that you can't even set
> the flag - the flag field is protected by the task's rq lock.

Agreed. And just to be clear, for the purpose of triggering ops.dequeue(),
**all** direct dispatches from ops.select_cpu() should be consistently
ignored, including dispatches to user DSQs. I'll update this behavior in
the next version, because this one treats direct dispatches to user DSQs
from ops.select_cpu() as if the task is in the scheduler's custody, which
shouldn't be the case for consistency.

> 
> > > For the select_cpu() edge case, how about introducing an explicit 
> > > kfunc scx_place_in_bpf_custody() later? Placing a task in BPF custody 
> > > during select_cpu() is already pretty niche, so we can assume the 
> > > scheduler writer knows what they're doing. In that case, let's let 
> > > _them_ decide when in select_cpu() the task is considered "in BPF". 
> > > They can also do their own locking to avoid races with locking on 
> > > the task context. This keeps the state machine clean for the average
> > > scheduler while still handling the edge case. DYT that would work?
> > 
> > Yeah, I was also considering introducing dedicated kfuncs so that the BPF
> > scheduler can explicitly manage the "in BPF custody" state, decoupling the
> > notion of BPF custody from ops.enqueue(). With such interface, a scheduler
> > could do something like:
> > 
> > ops.select_cpu()
> > {
> >         s32 pid = p->pid;
> > 
> >         scx_bpf_enter_custody(p);
> >         if (!bpf_map_push_elem(&bpf_queue, &pid, 0)) {
> >                 set_task_state(TASK_ENQUEUED);
> >         } else {
> >                 scx_bpf_exit_custody(p);
> >                 set_task_state(TASK_NONE);
> >         }
> > 
> >         return prev_cpu;
> > }
> > 
> > On the implementation side, entering / leaving BPF custody is essentially
> > setting / clearing SCX_TASK_IN_BPF, with the scheduler taking full
> > responsibility for ensuring the flag is managed consistently: you set the
> > flag => ops.dequeue() is called when the task leaves custody, you clear the
> > flag => fallback to the default custody behavior.
> > 
> > But I think this is something to explore in the future, for now I'd go with
> > the easier way first. :)
> 
> We should just not do it.

Ack.

Thanks,
-Andrea
