Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8C44AB8E
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278072; cv=fail; b=KwhWzAdltoi9TyLcfpZ+3XDajY7Bp2m/lEkJtkmXPgZh3yovVFyrS/OTxmRd/py/WMAuPQ/1syFgoSbvhG3wBSLboO7PjXREPnro2b3/iR5OBEUIh2O+dx6FQDmAefaqioN8VtCk0w3ovRWo3rOid4O4XunW79Dv9MQaPPvG5ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278072; c=relaxed/simple;
	bh=Jq1DviR2yxGLdympgZ7JDEsf2LSBDh9lkBv+1NtA1TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SOnJozUeloO3fY1HlX297Dpyve+MLO3XtOmQcCUXW7ZXtkdnGXwxiYZq5U1M0W84ZJirDBlNUhO/kF5nWysFBynMt7aITrvYUIsD0JXGnk5KhVZ1CUzkhf8znSLl3vrVOhZ+/fS3RGfhxt+E7kzOK8zr3RKFgIX0uH4czOCjLXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BSAt1XCP; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BSAt1XCP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOv+HF27Ak0vZR3BxqiXdIKOqPJPDz0wbfDaI8gjdVcGCNyLqoJ38K+bKezFRUu+cXNhhgkMt2S11S2Sh9s0Qjsu0WZWQEFRNSIjmeEADEFVh/g7ZbEAZRAoeK5//gD7kaaB3KQej9/y+7Nyt+kTYXbi1CTniDS8HdCnQuoshTF0+Zx0dPdPCHVW31Mo0AhnMoTC8J/SPD+Q+IWp/NjXCIqvPUuE1kgjThgPllRXvDXDS0WHa/AbL9YIpD9K7Oee2u7SnLQ1rcxDG+Bggm8/gXkfiUudd+KA82LoJf7HJsYtC2BoF3ezbGknx1fp+JbrHYq+JVaKcCGcVjJ3AU1Xsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEK2XIzd0Rd6QtpzOeAy5DRcKch9xYEx+6FifrH78sk=;
 b=HO3DsfnMSFEX+xOpv/FwyL+X7MwRwBZSXEP6Kg2gZz++0hGGODAoY02r3d3Fn1M4rJwJF4SQDTX7h4qqG0H1IkICn+zeBoEH+1vc4206dupYKKNXEuMlwLTZi9RpsnsF7o+f+4Ov9Z73yauZESPUDzIBjzcWBw6uZdJDBheHFXh8kkhD0rJjQ8diaqoFfRxNN4hI4uUlb94W+V63H2PV8IabCN7JbRWknzDK++H97fxPmPe1eSGXmGvRV/YG1E0EUqpvksCU+jb3Q701BfyD9yBFJg1k9S8HtDoX3msK/D2BCBMeUbF8kuAPGH3MTFqEs4y0roQ3QQPIR27a5uyUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEK2XIzd0Rd6QtpzOeAy5DRcKch9xYEx+6FifrH78sk=;
 b=BSAt1XCPiWQiTPbJn8SAhUbeX4YWBRUnaLbKC7var3kjjIvcyMLlL9gaXOPYDfKb4vnTrDhY3Kj9xSxUXT6nliC0TqqF3GmHMVhiQiiO4HYyoKLc2PhP2KV7JEEaRdrYKjfnQEUZR0eMojFoRQsdoNRl1CsaEFXwlIOcqFhneTXggk+IKbOVTVqzVGJ97PrKa5bUfpoO5+xSxLBQ008MpUGhnU096zIl8sPBy4ZVkc+7vmDEw825bEPXSdhliEW2qTE7vdgzCN7nNmVj4COPxxiOizDhV/Gdq/tPG7OB/3umMXekjpthlzrmbH95H1oXrGmqccEfk0GFTIqQ+qukNw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Sat, 17 Oct
 2026 23:01:07 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 23:01:06 +0000
Date: Sun, 18 Oct 2026 01:01:00 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Add scx_bpf_dsq_reenq_task() to
 re-enqueue single tasks from a DSQ iteration
Message-ID: <atP-LIKpxPhR-Nuc@gpd4>
References: <20261017223738.993262-1-tj@kernel.org>
 <20261017223738.993262-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017223738.993262-3-tj@kernel.org>
X-ClientProxiedBy: MI1PEPF000008D4.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::431) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 9156123b-4783-44e7-5049-08df2ca2868e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|18002099003|10067099003|4143699003|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ItRRlSpBLhUlehpp2DTMiG06vvmNbyswKdP0nNC50nb1ogdUBuLiElffh+QU0xGtj1r8TSn3u+B9tAhJ68+Be3dh0aMuXbpyC+Am84Y2tcMktI/u3eTuDcbS1cAMjGDGvW3mt95matjHn0ePBodIPFiBv4CiJyCr/IjP9yDPMK/bAdTzXbCkHgGEp185TeSgQcb4KMfkLmaGmz2wwwXSxCBXgd+MGWPzzEgNnQOdQxhTAeD3jhE6AtzNwpP9I/YdOBfdiZeoBbruLkh36KZh2o1LKhJI65dWrFDF46eKTpzqZ4URp6XuDDOVxj7+b8smm0sCadOGw9rtkMRrMtrDcGW9eBYzPDjiGWKo53dwIav2FSXPhyNx4V9c/ZpTBPkOa3VzVCAnB71+sWWIcBE9ykPH0ODLON0B96bPQHL4zttGpg21Y+ajmKAIVMzmEpS46G85g/Fbg6Q6YtJaHYN4MBNaW3O1vMZ2isLC+SdWCXxc1w+iToVbmP+4P3W907oa/T8mQj/UcwM1sK1ocDs/SEpVmnEKoRel138sRoqlmu0juz79H44ses8rmZ9npmHLnrxtjPQapEtLsh/Y4HJCFm8f7jaREYVgLKcIexVmUvmwsAm8DvgleH7Mqm6E9PWAmGIGtuldsNFGBEf/PrAqNJTWnKqoz/UevhTmCf59ZH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vj9G/racogX3cgd7lZvvTCS9WMMe5OJYw1PVbGkpGTnMhKCwoIRgjKJWEavL?=
 =?us-ascii?Q?7X47JE6uadtZRx87G/pDGNqK52dotCtvz2zhoKOhkK8ky2DqrTyg/S1bINtW?=
 =?us-ascii?Q?Ab8iMFi45WNmg8qnVX2HIxwdxvOFT5CJyROWCa6+MY7fHd71hKiSNiB1/UQh?=
 =?us-ascii?Q?zvxDkMxwgd5R9w/JQsFIfnf7aAWRw4UxzKSFFidoqr6e9r2tdUkuJpqVTGMd?=
 =?us-ascii?Q?B4fBg5oFGsSZ34X3fdD7y1sbnyKv5lG2YH1H32LZ9C9PiZ5xhG9iRRAk4H9U?=
 =?us-ascii?Q?r0OxXzsPIudx1gpC60vbwtxI2QpZahpA+MkpCIXiCFTCc4pDyncxbfHEYVxv?=
 =?us-ascii?Q?XDC3WZrRLJU0xVZfyuM1nhyK3Mje0UxLX1ewPCnAww9YtmNUsGw2Jonot0aI?=
 =?us-ascii?Q?I/VnGxryfpC2aDb4MsV3YQ1dAHYxA0Zuj3eJPf1QCAiclp3DPfqPrGJ3pSUx?=
 =?us-ascii?Q?2VdIjI4+v22PzyqVYm4Zqb21PELguKivl0Cuy+2Npb9B8h2BzNeK1HlP/8bp?=
 =?us-ascii?Q?PJ2VL/O8zIIyPo9WjKEq1FpAEsuWsXhpAUNvDlNbjI8JtutptIkBh63jFYKg?=
 =?us-ascii?Q?h4EPtZwoDpNw9w41i2mrCpJWdawK0rFglKcs4RdRYXEcERdoJSrL2+J3TtDx?=
 =?us-ascii?Q?B06/LqMSUMV0ARktK1d4sp/SQFFwNK9ONrFutYk3VbK5O+MCtNx2ibfsDU36?=
 =?us-ascii?Q?n+8y5dOuZ2/+xhrJTW3PWFbounsPBv56cW1gyANc2mi3qNX228bxs6sYwN79?=
 =?us-ascii?Q?QibO2ipDHnLY+wmgQcrAmmU+MT0BVJwWvWlLz03l2/LqLe4ebwZh7U84tDll?=
 =?us-ascii?Q?A1KuiimSSerpehq6a3s1ao1AC//Q3WniovhpNNJloMcuHsvolm0HTpjCWH9m?=
 =?us-ascii?Q?d9YWxPrTpP2Gify+cRIdkdNgLUArwQMAGrUiRtC5C4yNMrLsaCrLZ/60ozwv?=
 =?us-ascii?Q?5Yrl4SMdb/HbWLzbYG0nmt4Qhn5Vkwn0tf6FUFQ1v/p4HINuLjmiRYiMreo4?=
 =?us-ascii?Q?pB+l/FJjR7Q3u13O+xkGUMN2ggf4A33xa7YfaoJGfKCfqVbIwB9OZ1DwspW9?=
 =?us-ascii?Q?ZJddv5K4EnImPEIlelHr+XFpysEe5ITk0H853NW2boJA7d84hfJ/jHIFkL4Q?=
 =?us-ascii?Q?lazyxy8ffRqo0W2oPv2mfmN977Dp1WwH1qNxMoV5IgtUuaovfaLay0O64iOM?=
 =?us-ascii?Q?4HH99x07aBppxdOdsUk1z3BgPdfauywV5mzK8nZYfhj/BmuhBPdVCko1nbbZ?=
 =?us-ascii?Q?7X3r6qTHtzc6VEEVTdyhYevGNeAh2XLRoSiCXyyOWFjmgM2nU/NTdzRnzUtZ?=
 =?us-ascii?Q?OoiPqiOMOhmqpW3Bm+PxMjieEdHve7qmmS45U3/gc0vralxi1PqkS3wdHLCQ?=
 =?us-ascii?Q?t4tCiYBbJbmbSDujy9NvsLryfONlSbxEp5e63JraLtBpPkBsopjhZpwSVzrN?=
 =?us-ascii?Q?PYO2v5bdf5j8Yos/u1N5yO0C1Ro9gH8T+I8NVNUhUlE5UnU17Of9JqPLVMky?=
 =?us-ascii?Q?I9Bo9Xk5vbAeCXpcVYwJpjbFITwrK87/5ByifNWOkqJk3fedQw33ngkQ36qb?=
 =?us-ascii?Q?BDhBS0eF25J0YIIsAPQdeSdlfS+MXxR4ydwscAADu3s/0qRsix5x2q0KOzUR?=
 =?us-ascii?Q?FJMo3gx1I1eKebzUndtXbVW/26VKsnHe8Ou4J0Y6WZCUyRn1oLXoMXqB05Gu?=
 =?us-ascii?Q?o6Pc5/CNR7LzJK/R2dXaJVQ36cG65OARnI9glIQIwbStdj88WcRd3cVRBfDe?=
 =?us-ascii?Q?gT5400YbqQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9156123b-4783-44e7-5049-08df2ca2868e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 23:01:06.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKwUMv4HiJiZY7wPOkWsUTwUiFJvflFI4s4gBx3d+3jcWOsosNdfsFKsax3ZwjAmRWGi8qrrm2/1gpHbtHLIGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892

On Sat, Oct 17, 2026 at 12:37:37PM -1000, Tejun Heo wrote:
> scx_bpf_dsq_reenq() re-enqueues a whole DSQ, but a scheduler that loses the
> cpus serving a DSQ, such as a sub-scheduler after a cap revoke, needs only
> the stranded tasks placed again.
> 
> Add scx_bpf_dsq_reenq_task(), which marks a task from a DSQ iteration. When
> the iteration ends, the DSQ's deferred re-enqueue walk is scheduled once and
> re-enqueues only the marked tasks. The kfunc locks the task's rq and the DSQ
> like scx_bpf_dsq_move() and is callable from the same contexts. The mark is
> cleared when the task leaves the DSQ, so a task consumed before the walk is
> not re-enqueued.
> 
> An iteration's DSQ can be destroyed before the iteration ends, so
> schedule_dsq_reenq() now skips a destroyed DSQ instead of aborting the
> scheduler. scx_bpf_dsq_reenq() racing scx_bpf_destroy_dsq() takes the same
> path.
> 
> Declare the kfunc for the tools and add a compat probe.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/sched/ext.h                |  1 +
>  kernel/sched/ext/ext.c                   | 79 +++++++++++++++++++++++-
>  kernel/sched/ext/internal.h              |  2 +
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  tools/sched_ext/include/scx/compat.bpf.h |  6 ++
>  5 files changed, 86 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index ae696d11dac9..efd635a99309 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -157,6 +157,7 @@ enum scx_ent_flags {
>  /* scx_entity.dsq_flags */
>  enum scx_ent_dsq_flags {
>  	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
> +	SCX_TASK_DSQ_REENQ	= 1 << 1, /* marked by scx_bpf_dsq_reenq_task() */
>  };
>  
>  enum scx_dsq_lnode_flags {
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 3e707b00e78b..2d274b54904e 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -555,11 +555,13 @@ enum scx_dsq_iter_flags {
>  	/* iterate in the reverse dispatch order */
>  	SCX_DSQ_ITER_REV		= 1U << 16,
>  
> +	__SCX_DSQ_ITER_HAS_REENQ	= 1U << 29,
>  	__SCX_DSQ_ITER_HAS_SLICE	= 1U << 30,
>  	__SCX_DSQ_ITER_HAS_VTIME	= 1U << 31,
>  
>  	__SCX_DSQ_ITER_USER_FLAGS	= SCX_DSQ_ITER_REV,
>  	__SCX_DSQ_ITER_ALL_FLAGS	= __SCX_DSQ_ITER_USER_FLAGS |
> +					  __SCX_DSQ_ITER_HAS_REENQ |
>  					  __SCX_DSQ_ITER_HAS_SLICE |
>  					  __SCX_DSQ_ITER_HAS_VTIME,
>  };
> @@ -1292,7 +1294,9 @@ void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  			WRITE_ONCE(dru->flags, dru->flags | reenq_flags);
>  		}
>  	} else {
> -		scx_error(sch, "DSQ 0x%llx not allowed for reenq", dsq->id);
> +		/* destroyed since the caller resolved it, nothing to reenq */
> +		if (READ_ONCE(dsq->id) != SCX_DSQ_INVALID)
> +			scx_error(sch, "DSQ 0x%llx not allowed for reenq", dsq->id);
>  		return;
>  	}
>  
> @@ -1918,6 +1922,7 @@ void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq)
>  		RB_CLEAR_NODE(&p->scx.dsq_priq);
>  		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
>  	}
> +	p->scx.dsq_flags &= ~SCX_TASK_DSQ_REENQ;
>  
>  	list_del_init(&p->scx.dsq_list.node);
>  	dsq_dec_nr(dsq, p);
> @@ -5095,7 +5100,9 @@ static void process_deferred_reenq_locals(struct rq *rq)
>  static bool user_task_should_reenq(struct task_struct *p, u64 reenq_flags, u32 *reason)
>  {
>  	*reason = SCX_TASK_REENQ_KFUNC;
> -	return reenq_flags & SCX_REENQ_ANY;
> +	if (reenq_flags & SCX_REENQ_ANY)
> +		return true;
> +	return (reenq_flags & SCX_REENQ_MARKED) && (p->scx.dsq_flags & SCX_TASK_DSQ_REENQ);

With SCX_REENQ_MARKED this can now return false, and reenq_user() skips the task
while still holding dsq->lock (and the rq lock, with IRQs
disabled). If we have too many tasks queued, it means we're walking all of them
with IRQs off.

This is not a blocker, but as a follow-up maybe we could count the visited tasks
and drop dsq->lock periodically? (the cursor should keep the position)

>  }
>  
>  static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flags)
> @@ -10087,6 +10094,8 @@ BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
> +/* also in scx_kfunc_ids_unlocked, same contexts as scx_bpf_dsq_move() */
> +BTF_ID_FLAGS(func, scx_bpf_dsq_reenq_task, KF_RCU)
>  #ifdef CONFIG_EXT_SUB_SCHED
>  BTF_ID_FLAGS(func, scx_bpf_sub_dispatch, KF_IMPLICIT_ARGS)
>  #endif
> @@ -10202,6 +10211,7 @@ BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_reenq_task, KF_RCU)
>  /* also in scx_kfunc_ids_select_cpu: also callable from ops.select_cpu()/ops.enqueue() */
>  BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
> @@ -10610,7 +10620,8 @@ __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *i
>   * bpf_iter_scx_dsq_destroy - Destroy a DSQ iterator
>   * @it: iterator to destroy
>   *
> - * Undo bpf_iter_scx_dsq_new().
> + * Undo bpf_iter_scx_dsq_new(). If the iteration marked tasks with
> + * scx_bpf_dsq_reenq_task(), schedule their re-enqueue.
>   */
>  __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
>  {
> @@ -10626,6 +10637,13 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
>  		list_del_init(&kit->cursor.node);
>  		raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
>  	}
> +
> +	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_REENQ) {
> +		guard(preempt)();
> +		schedule_dsq_reenq(kit->dsq->sched, kit->dsq, SCX_REENQ_MARKED,
> +				   scx_locked_rq());
> +	}
> +
>  	kit->dsq = NULL;
>  }
>  
> @@ -10714,6 +10732,61 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
>  	schedule_dsq_reenq(sch, dsq, reenq_flags, locked_rq);
>  }
>  
> +/**
> + * scx_bpf_dsq_reenq_task - Re-enqueue a task from a DSQ iteration
> + * @it__iter: DSQ iterator in progress
> + * @p: task to re-enqueue
> + *
> + * Mark @p, which is on the DSQ iterated by @it__iter and was queued before the
> + * iteration started, for re-enqueue. When the iteration ends, the DSQ's marked
> + * tasks go through ops.enqueue() with %SCX_ENQ_REENQ in DSQ order and the other
> + * tasks on the DSQ keep their positions. A marked task that leaves the DSQ in
> + * the meantime is not re-enqueued. @p must be on the DSQ's scheduler.

nit: the mark belongs to the task, if two CPUs iterate the same DSQ
concurrently, the walk scheduled by one of them can re-enqueue tasks marked by
the other before its iteration ends. It's harmless, but maybe worth a sentence
here.

> + *
> + * Re-enqueues are performed asynchronously. Can be called from ops.dispatch()
> + * or any BPF context which doesn't hold a rq lock (e.g. BPF timers or SYSCALL
> + * programs).
> + *
> + * Return %true if @p was marked, %false if @p left the DSQ or was queued after
> + * the iteration started, or the iterator holds no DSQ.

nit: also %false if @p belongs to a different scheduler (after scx_error()).

None of the above are blockers, so:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
