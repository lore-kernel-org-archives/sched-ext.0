Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A92320A0E
	for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773124757; cv=fail; b=cIjjFEZUXinmMw6Q3Q9LGwc3slWIPRQxSy4E87nLdCMZse1qvd7ZEED93b7x2pceH48OT/NYZQNZMVkBPkoGGzFEKgqzzS6n7mFFibZsfTTLHBJqNIHVlxTmtgMpnZjOQj5ThDLl3EDFjZG5v3JkDuw46asFgzIh6+d59bo/QvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773124757; c=relaxed/simple;
	bh=DjyAn2VCKpFe1u0lj4X1VNpx3gUGd0qPLEWGpsmIQek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j6q1vYrJkfabi7KTwWo/060BFM01QyiAaWCvi7hRp+vmkN6xjvrcx4gLbyOCmE9hNkQorOoUhIHrMU208YUFb/pCMErLHTOgSz4Ju5rRyxCt6y/2pmb10JpdVJSbDRuUzJ1okv0PJyGA8mHexPGgKtDY1NeKHJJFzzpPDf7lxn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eyWKjy96; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eyWKjy96"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMjsWmLuwXisXE/X6nxa/Tv4PeVZC1/LUMjilDo14K/1H69HM7Qjfa0Bub/6GLcOWNj7DFl6ySI+tkDZ5RZrHeFggt5Y6uQWEypGnWMMuPOtXqvmnUj9hfvUTXpzdr2ChN1sYSCJAs/cGOK4hvKNW3HUgFntPaGxe2KkI94vvBmr59Lk3mQGqYXsYuUhcGQDI6gvWuhMVsDvBvsrs6gLp2ILoctJq/w0jgrclkuozSowTV8tIbMGCwMvuIjJIbyTyWOPRWOtbfQY4frlwxG6YMH0IdirI4IfU8QfpSu2u8x/UAcIFulPgX7QfV19138NX5rpJ/YY5TrNnMwGea72bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLhIkP850drcDRcxgfD+nxXy0r6yMNBWSZWsXOdK0h8=;
 b=htileoDt5FVhyhE1vlO/Q4TWEruc8hlICVQ2w6UJQvhlXNEHa9Osj6UxO+t6WFTlNO1gmWGGdMK44yUvGSpZsy/xusv4gYkK3I2O6OCTyKCaqigq4kSFthXNf7nyydfmi8d1QbJM9ie62n0+kBVCcCfW/B1U1b+a6nOqsqHvnl4PO2B6eUL1wDEKtxUj5vDPU7VLgiLkhDiwQwbz7KmZvXC+Cx9T6XV4owwJV5ioUnCp6GhE31BJIkCMD9Epf0S1EjhvQaAw/q2HJi03sMCt8tUjsswN378G0VXFhDU7JXkaWftz2B8ejx1sZxewQ87mLEn74y7q3gA32G3/MeNJJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLhIkP850drcDRcxgfD+nxXy0r6yMNBWSZWsXOdK0h8=;
 b=eyWKjy966gHFXiPRPwmDqDImCVdfldw5RrNaHMrWiRwzE/+gV7OegKMONoro52FmEFGCai8oqAen7lxhoEYuXvdE6/nPj2rn1H/SvE/+2z9ECN3zwX34WTtphZy9dNj8tMWKV/ssJz47vSAYZjX9xd2IRjmh7ZLa95am3ZleYdf/tmQVYSGDkLDSosRF7/3t7Tw3jFKhUqhM9bZkSm4tv5eoLWWhxmz+hCHMIMN4/MdqY83ljyLHQG8qOZ3brSt/ahRgE84DNOf2x8ckBywrn0ttA4vvmI/+4Muh2dOikQ8W3+fLDO+moNGCCQ6AUw5RMrSSTIEUTCuJVjOOJDMmRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 06:39:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 10 Mar 2026
 06:39:09 +0000
Date: Tue, 10 Mar 2026 07:39:00 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched_ext: Fix scx_sched_lock / rq lock ordering
Message-ID: <aa-8hNTGRvHUrBsN@gpd4>
References: <20260310011653.2993712-1-tj@kernel.org>
 <20260310011653.2993712-5-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310011653.2993712-5-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bfb5491-65bc-4809-819a-08de7e6fbc27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	2yu07MCbAYDtVHfZ3jOse/9UrAF0cYPW7k7sgrJTwalvmMHyDwzx9b8HfaIF0uP7yBCYPzn6rM7mb+sC1FnswZTx1/7AjNwEfV3fXMwRBwyKRvczc+gPZnz9bqghCwu7wdvWkB21QWDwgJIXv8JkHyfZwxQe2DEklTStfhRIBM2I2uj1MKG0q5G9JcP6Hn398FKtuubXY8DncFh+lfPP+1c1tgpM+p6hiFEGhFvG+BT1wagTPmFSQHAKK9z11KJdNe9F5DPYxIu0+Dr2/NW65lKp89NOJ3o6thc1v2hlmw5GqXv3NLnMemPuXCASJgyBN7Z+UEHApaypTwBwnf6Ovth8YPX4AQMwrUiplirl6dZxmPQ9Tdm5v5d9xRGMWQc8/22X3AuGZU6xO6KgxuHzhB7GI/nHZQmT7u7pXo2T/81VYwNMk6l0NlhygEATipIv97gK7WZcYhN6C2byGR3zjl7QzyQmMHINzHcwVVklN1jYIX+oqWgYa8q68niqvRXxAZaAiDD3hmdHUPPXcnV3MBlZY6yVId0AFfV/iyjcUcL3bjcYL9yeqZ6FelslD7jP3yO7FwxpgAzlfGXdSDgN0yo8Ib8iEx0bLYcZyhl7vqE/1GJlyET3RvkFI56XpYv2uxk0OubLXMMwug9l6s6M7Gv5ZLKulyqV6dw5fjMamLy6Hg5ZK5GyJnBc6fefxC5lr4Opkk6zKn9FDQcPOjN1KYpsEUX6kLYLVBaGHGq/+gA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xNJkaqTVD3fG7KkLnFGGZr/rlm692+OGdlx1091HOWZXhtHB7JA2CtRLR1a?=
 =?us-ascii?Q?p+fAZlCi5BU//lnyHIZ5sMFZ2gOrapWyRv00fyF64lzuKm/0WQ4diOwmkD72?=
 =?us-ascii?Q?uI+uGBvdANR3ukPUtdd0mg2ZzvZ16Gn/3FGmUI5oKOnZBf7t8Hbc8tDOmd9S?=
 =?us-ascii?Q?RbDLbityvocA8LHePYrn7+6zeSw46yv4nUDbMRP250UVFXbtAhl1RS+Xl4m9?=
 =?us-ascii?Q?12CoLoQdPpHpROAQxCIqYnbiaviHQT4+Dc5D0exqkCgN8qHynDbdCNndDnWz?=
 =?us-ascii?Q?12wcTW9ywZP80TvuJvbsmGbcl6B1ZtYc0qOSbyNYYG5ELsu1IV+uTJF/z6BG?=
 =?us-ascii?Q?JJze1YnHHHztw0fzSFeBuKeQcVMkTs8EAiL0CvxTqRHfqjs0H4OKQSBEc2+1?=
 =?us-ascii?Q?McNn1Nab2TtEU5aAQoWHNcFwfJ3tUaP+OpNNS5Wi7ZQ/6T06Ylxc0y0GKA0A?=
 =?us-ascii?Q?jW3s3XvuSfTyJq7wGM2jEPu7c9or0UO7b/MOfjWG+aq0Hb2tkI+nI1DBgDS8?=
 =?us-ascii?Q?6Z42Ta2Hp67RBf/4AW1XIoaSbtTigeZamu+yMFjgCBennoKkCWeOMFf8muoK?=
 =?us-ascii?Q?uyvBU/YrbKTjSZJ9CaeCq+LZaC8l6fC4GcHTo1/AuZemf5UpG4ChiZ5Xeq7r?=
 =?us-ascii?Q?tvdxLZLrQbyl/A3STtLnyJ+m3sH+RUTqQ+Yt93UjlKVzgWDWwAAFHAW7N/O7?=
 =?us-ascii?Q?MFObFGOTwn2ZYhp4d9HD2VlFHCRAZApEXympBnImtroDiSAG6FK4A40vUGDW?=
 =?us-ascii?Q?jRjU/DVNvvQIGJFwkm7RYAwYwJP1IT9mQxzZ3eIKRpgvB/ow1tyk7JOTMvl/?=
 =?us-ascii?Q?KPn/M0QUaM0hgCJxO0f410Sn8R2ClhqaLg84h5RHkjuwIH4Bn6ktyGw+4P42?=
 =?us-ascii?Q?YQIHeEQxqk50YdF7YyzzvoNZ1fMvyCxRfDtDd86fVxNuNXSRkdsadbmdBqgQ?=
 =?us-ascii?Q?gWtXzl12cDZM+y00/sjMH6UHNfbp/+QCTayqrSUqmU0wE5109wn7RtbBHycv?=
 =?us-ascii?Q?XySZfhd4GbyA2sXSC2uPQVSDD8NJwv3gjgN8YZqplLGYqNcAYB0ZTIXWlNXf?=
 =?us-ascii?Q?uQyXrQvk3N6HGwxs7xJ6IWdfDHNWfthCPbEBWo9iEZ93WBQEaGy8rmbotOLk?=
 =?us-ascii?Q?5AWwbMemM6uAcrn8XCfm2UsnEfUtppFxnvaxtERf3r4SWjBnhtY9dNwZuNi0?=
 =?us-ascii?Q?CUjFjxIV7O62M4CiaAZysoEID4d26yaY/BFUAWRGuSPWGLbSJtmBdt3O/wwq?=
 =?us-ascii?Q?tZaDbR/oW0WZ//wJgSxLF5CRF4Sbr4MoOcc1gDczkwovFLdztgcHkT7a7MQT?=
 =?us-ascii?Q?WSxIoGnIMCZoTnIulzmOMYZIjJEM/56gdyxTvASv8c1ZtZP8NpNjFKRMS6RC?=
 =?us-ascii?Q?M9FWwySxU5eu81HFTzxX9I2dvkPTR3oYQnxonK4sETl2ZsOuuHhImUhquNPX?=
 =?us-ascii?Q?TyMQ80vLuE0kK9f/9ulbUt9Mauh6Ad8UVtkjl1deSctRLxZmS1OUy4X3wgf7?=
 =?us-ascii?Q?mlsYt3PO49+SVNuR/6gqjUdLeZCnompTM7JdJYL7e/FJ7RJiQsXSIqk3gyaQ?=
 =?us-ascii?Q?cdWio4Ig5UontSTlmKn7YecVn2mEZ06/aTNWXCwnAo5zVakYiVshI6+bNwI4?=
 =?us-ascii?Q?X/MtAyyapZ8NrBiAX5bZkMTjqYBQqZjTBMBafN3oa6u/iWZynmAoim41JHg6?=
 =?us-ascii?Q?pgGG0jDF79BxeEN+a43DgPaSlRhnOJKg+h/yuJX7w+dzV0lCUGaMBGVf+r49?=
 =?us-ascii?Q?99WKQcFvvQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfb5491-65bc-4809-819a-08de7e6fbc27
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:39:09.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxPRlrGesppw66zk/KqYW+30RdAydAY8WbHlB4VwEeV2tV50jw/MPviTlcYhNWPUQ+OTGIRJIe4Q4zAcfWTsTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956

Hi Tejun,

On Mon, Mar 09, 2026 at 03:16:52PM -1000, Tejun Heo wrote:
> There are two sites that nest rq lock inside scx_sched_lock:
> 
> - scx_bypass() takes scx_sched_lock then rq lock per CPU to propagate
>   per-cpu bypass flags and re-enqueue tasks.
> 
> - sysrq_handle_sched_ext_dump() takes scx_sched_lock to iterate all
>   scheds, scx_dump_state() then takes rq lock per CPU for dump.
> 
> And scx_claim_exit() takes scx_sched_lock to propagate exits to
> descendants. It can be reached from scx_tick(), BPF kfuncs, and many
> other paths with rq lock already held, creating the reverse ordering:
> 
>   rq lock -> scx_sched_lock vs. scx_sched_lock -> rq lock
> 
> Fix by flipping scx_bypass() to take rq lock first, and dropping
> scx_sched_lock from sysrq_handle_sched_ext_dump() as scx_sched_all is
> already RCU-traversable and scx_dump_lock now prevents dumping a dead
> sched. This makes the consistent ordering rq lock -> scx_sched_lock.
> 
> Reported-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Link: http://lkml.kernel.org/r/20260309163025.2240221-1-yphbchou0911@gmail.com
> Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index cf28a8f62ad0..677c1c6c64bf 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5097,8 +5097,8 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
>  		struct rq *rq = cpu_rq(cpu);
>  		struct task_struct *p, *n;
>  
> -		raw_spin_lock(&scx_sched_lock);
>  		raw_spin_rq_lock(rq);
> +		raw_spin_lock(&scx_sched_lock);
>  
>  		scx_for_each_descendant_pre(pos, sch) {
>  			struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
> @@ -7240,8 +7240,6 @@ static void sysrq_handle_sched_ext_dump(u8 key)
>  	struct scx_exit_info ei = { .kind = SCX_EXIT_NONE, .reason = "SysRq-D" };
>  	struct scx_sched *sch;
>  
> -	guard(raw_spinlock_irqsave)(&scx_sched_lock);
> -

Don't we need RCU protection here?

>  	list_for_each_entry_rcu(sch, &scx_sched_all, all)
>  		scx_dump_state(sch, &ei, 0, false);
>  }

Thanks,
-Andrea
