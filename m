Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D0485925
	for <sched-ext@lists.linux.dev>; Fri, 18 Sep 2026 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712895; cv=fail; b=F1ijU03w6dZO54G6g3+rMtP4VxqVnt4rtIOzts2L5IvT7AF10fQnzx/vcjlRETY1Jfk6uOooxGQdExsXIwGO0/F4o9oJRzDLBPvOueWi0ryysQGftweJ0ps17mVoIyyc2pulpFhtNKRY61Xt9CL6ZyYPjPMjXUjp5dAL2L2mmD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712895; c=relaxed/simple;
	bh=SfoYRfZV60LxK9FbJMm4fYp2/FR0pt1wAQYT/3Eie6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vr7/CPwqg/RcLoWCD1xl3ECxFmyHmXuQR2XkmrLhDbwitz9d89SWQPOz4FFWX7kUkchcvzGFgXRl9rNzufy106McPYPDrzS2WyouOvPiUeCczn4BrwwU64a57Lvo3KH5dZ5RMHhXiTn0FSfC/Dx4VMuc6CZWS5vwVW5xMo0CZVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H+VfR7zo; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H+VfR7zo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Me5OhgbIe5VmV2LSklVlUegz8PabFOO0kpcZT6kLsxeHOEw2qDiOy7f16PToG6kXV43b5JbxFRRYaTAr9MZ6WZQ/clpEqNCMyBKYZn4/6hhBxX8TIGKU+au9coJJI8lCU+cE5GvS6VhvJViaJXExaG2w+6jZ+zFeZ5LQxQB2XyF0mYwkQHRLfPze0UbRpSn8pOGq3VD3WCwkiI47mlsejgh3eHXHPfZuKbBs2RCbs6pXdQqfNQKqYfuVPsEr6gkzXyC4e+3eioCQrBtYQ0SrWuc9rOTSnJfUbcGLZp6NB+oZ7b2SZDSSN/UidQZTJzyxmnDfjwCk8iPb1qBZ0xzObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJlloA65X4tTwcjJxp0TJ9X+V2FFnAf3qZ2irswwT/A=;
 b=sLJnxyDhE3WjQixMcfDTkwuv/U7dlCxuOjaAmc8biuYd9NzPfSwkJbMskMfEznEtR+H/1hrukhWfppAMHKeq4xaY9JF59TzCa+GidoSmFA7fJ/MZgFvwC8ggSImrDfl0Jb07D10fcCLjpr3cjYM9mc78M1otlWq/2YJ8HSHWLDqU5utUqeQeRPbjjNCvbh0BkD7bAznAc/LqislCBmCCsyOAiH+7asBNUECtslpni6HY6AAznmFch9Xq+t2H47eVH6eolfFzOPYPI6QgIa3mvap16W1cW1Gd8Uujm4pF3hz58pPL9r5nLA1ZJpITjWsYCkJP2hRsbwwpWVdHvh25Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJlloA65X4tTwcjJxp0TJ9X+V2FFnAf3qZ2irswwT/A=;
 b=H+VfR7zoWyj9yBF/KEikZCaZwjlqJ8heVl5P7KAhwnFqJ18nVq0aLT3MXSiTjEHHJDEIaSGlrtzSa8Zdf9A724SRWMsZ5OIuiN2ROLeGCxPWCQy6592v5ztZcBh5oVnNlOK1pjqv/K6NzVvCxTRF8dCOIxDWrLE2ClWXGFrG+IAfsVjZEWOjffdYBA9PJwk8prgWuAhpIwqifEt0sb4zFht87B9O/ggOTQMmUBoybt7ykyKgKVUYQ3T73gn9/35lselExk1lRl/+0Htj3CVZb24sp9X6WBReFFiuTrMeBoN4ZpuDdlbj8MDUCwDREiX6eGkLsojvxC3nO02p6nFIzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 06:28:07 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 06:28:07 +0000
Date: Fri, 18 Sep 2026 08:27:55 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add lazy preemption support
Message-ID: <aqzZ63K9cb19_hAy@gpd4>
References: <20260917070751.3617935-1-arighi@nvidia.com>
 <20260917070751.3617935-2-arighi@nvidia.com>
 <05995f56a36bf6285f738dafdcc63785@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05995f56a36bf6285f738dafdcc63785@kernel.org>
X-ClientProxiedBy: MI3PEPF00007548.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4d4) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: a227545f-5242-449c-19dd-08df154e009d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mvXpBdsWKxnt3jViow6QtT3Wj/yjDwcQOpFfd18eZ2P6W0Pui1JkrLIZFKGEzojtMCMAbQEQl+2cDAFyCIz51qWDBaYEf1r+ZmcANLHSDwrQEUaYTHfvygz0jhKmgFXZzvUZAeRF089sHD9JyUUthAYpDIUjhcNAdv5aQ8VApvTjNs+TTVfO4I2pPqtkGV4KL67+9aHNxGrrdo48t3T9XnM0tdFCbqUPXn6aY3GayJT9aS8bWieVqIANBzspzQypYEmQ9lUYD1e4uGNMTDnJru/WJSxas3ydLE5lPeTbYvPdWKGG17fcIy3spbbIVKBvZ46cTLGKX7fE0AvGTJC7fsYOnL1CcGndb1oUvsIMaM5sv3Xurbpr7npSzJcW0hSqe0qbD0tK2K1b+6HOedN4MbUkt3Ok9GTDw7WdwwThDXTheUkzRw96BcS1l3S6w81mJZz7HILsmKWKNDrMCkSR/GJP+nkn3Fx7hgoJOsC50MpD8HSzIk78PbbLvr3v5WI554ufcZzxLBtgoT9xhIkS+rnCIVHWO0vCY2Rg//rlotHEn2BQVgUzO69dL+GjxQPmWQV5BjGI/nPlKZjRA2otUaMpUSePXY9wHcaI5TMCOGqo18ZLS4s30q2va98UD5AzPd/qV8mPfEhE1z/2jgA88jeKm0jH8heZThA2seAK6Vk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gGl+lUHsGdtiipnCmQB7E+nfbhzR6sWYF+uKN3P/93cT5rSLlIfef5i2UcPz?=
 =?us-ascii?Q?x615CW6mLd0K2cw7uQkLrn7rSRJ0EkDDIOnsiUN6P1BTR8z2qEb1IGnuoWyq?=
 =?us-ascii?Q?uqaTA7jEw5CvKT6SQOM9ji8qgL5d18yUs9ORgqMwWlEHrnVsR3v0RIHGB1L1?=
 =?us-ascii?Q?/Sl3yPiVJUsTPu1xGqhIbfxEXzfTCsCdD10jXulYeWibgd10Zv59vaBeXQFZ?=
 =?us-ascii?Q?ZDnJuRXic1XfTXyQPecRbuEXKfgHf2Fs6tVQQCCdTnKwA+Xs1Wn5l/JZ7GCe?=
 =?us-ascii?Q?SvwGJmw2Y5yJrK6ixS4h26ahf9mG2kWYrqAhO+OtjIBxP9qaWgcNUbqGbyVV?=
 =?us-ascii?Q?oJzPmf3aBll1Ov+oeKgIEIR3E32rWGwfXZiZDBWrvYvmMm4rQ+WAC6Jshl6b?=
 =?us-ascii?Q?7+DiqCgBUO9TFh5/Pz/Cr+5RA2PxYKhJkR1o929wT99S5npvW++W1i6yDGSa?=
 =?us-ascii?Q?GbcAA6Jlk/dFez7TwD/4BPApJNex/fHTt0tCJ0DTWY1ExAndEMuKldj68z5H?=
 =?us-ascii?Q?C+7nTpek5Akx/x9pSXorU1+CXLSQu3+bOmk23d/QfdEhuiTQiNtvGgzUC1L6?=
 =?us-ascii?Q?wgJUCQx9qd1D2WDSJZ6U0XG+xSNzSHpTDmKcWYFhT1VenJAc2PihQgYCQ1QH?=
 =?us-ascii?Q?AP1VwYoFL5pQjvnMf6RxWLIK4P4AeZPgfrmryCTK1p4xBkyfgv6p1TXEzxUO?=
 =?us-ascii?Q?2LGE5/PZoIZ3s0AS/Szl6jfmfg94KE2THCGhaELPz2Y/8d9N2H8Frr4a+Er3?=
 =?us-ascii?Q?JFl+C9uV5AWsDKCWUB+wBB+4In7BlO6W8jQl9UkCx3X3KYcP+nGh2acAqfeM?=
 =?us-ascii?Q?UFE8V6K3Gn9LDX7EShYTbh9MfhKaW/u2xdkmZBJK5sIee2dXySdOhTc94dJ6?=
 =?us-ascii?Q?KuAv6AWJdNFG6wocfjrtVRqu6l5Ba7Jx5sqAODG54NXRjICqm99u7/3tLqCV?=
 =?us-ascii?Q?FwumEwyQAhWeZMOF/lKwmNaVNVqlBd3abd1JGN8uwGHVgy+/xW9UgaOWF8Oj?=
 =?us-ascii?Q?9ybjqhHUI4woHXiu9/6+TbmPuaqE8Hdpl1koepyQ41R7VIVNGjA0Eg0YY2pg?=
 =?us-ascii?Q?56WKRl/M99PPdgubFhKKgoDbu1NyrC4Vrb+hgBJ5SZH/buuXLiq3VVtDamXj?=
 =?us-ascii?Q?CBHsWE+PM1sbfx4i5U29JJbpixlQeSmK4Hb7tSJ43o2cEhFOtX7Y4UO6hq/Z?=
 =?us-ascii?Q?kTataEKsK/AnmBJOxYUx+QAffNtclCuH0cSxFfLlkZbrD4dnheBJsqZKRxj4?=
 =?us-ascii?Q?RS3E/tcUs/rhQjjy+MsmQxEtilnEDU+tp0ZbpQJr0R90DNYpCptwi0ArtUq7?=
 =?us-ascii?Q?3hS9oCMW759Axggd7x38+/u0ua6baMh/Se/Pzfc9MKIQwa1sM7Pz3+T9oS7+?=
 =?us-ascii?Q?83+DwMAXFTkbDBZ+uB/MGTALSVl+j8FqP4L6X1cqcmli0D8ExnEM9/Dw17n3?=
 =?us-ascii?Q?Iamfn589UxJ1+ev3+XqmA3QkT8Wl9C2lkZeBf7uqyUqUo8IAue6Z4F6cIJT4?=
 =?us-ascii?Q?pBY4HpWRJq/R971mi67K8tMKtBzdpB5LxiKKxd6qHTnVfSjo88KcjtRudqFv?=
 =?us-ascii?Q?JgsXhKzk5SDRyiL5wuHiSzOIbKW9hB/kWks/jFutvuADEg6vX1+JfhvabgIB?=
 =?us-ascii?Q?bAj16LiTDMf+2rUYGyyWVfJhyQPDwB+Ts6dCBXZE+jPAUbQWl7cycV1M4Ba1?=
 =?us-ascii?Q?Sr6MgDeg/vYudISJ4NLkYitmmTaL7W2nuio4H0LHFq8ZSMVBZqanhA8T+JCv?=
 =?us-ascii?Q?1IB1SXoz+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a227545f-5242-449c-19dd-08df154e009d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 06:28:07.4122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtqH4TnlvJ0Birc/iuNxAjnMUmGQf/vVFNpdNpbzOP1TgkKYmaJoc50aaIPOV/Mq16sujMWi2Y4dSrICoIrLcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412

Hi Tejun,

On Thu, Sep 17, 2026 at 09:19:07AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> Looks good overall. A few things:
> 
> On Thu, Sep 17, 2026 at 09:02:52AM +0200, Andrea Righi wrote:
> > +		/*
> > +		 * kick_one_cpu() clears the lazy bit of every cpu it visited
> > +		 * above; visit the remaining requests which contain lazy
> > +		 * preemption, see scx_kick_cpu().
> > +		 */
> > +		for_each_cpu(cpu, pcpu->cpus_to_preempt_lazy)
> > +			should_wait |= kick_one_cpu(cpu, pcpu, this_rq, ksyncs);
> 
> Can this fold into the loop above with for_each_cpu_or()? As is, a
> lazy-only target keeps its cpus_to_kick_if_idle bit and gets locked a second
> time by the idle loop.

Good point, this also clears cpus_to_kick_if_idle for lazy-only targets and we
can avoid locking the rq again in the idle loop.

> 
> > +__bpf_kfunc bool scx_bpf_task_set_slice_expiry(struct task_struct *p, bool lazy,
> > +					       const struct bpf_prog_aux *aux)
> 
> The name reads a bit like it turns slice expiry on and off. Maybe something
> like scx_bpf_task_set_lazy_resched(), with the ops flag and the task field
> named to match?

Agreed, I like scx_bpf_task_set_lazy_resched() and at this point I'd also rename
the ops flag to SCX_OPS_LAZY_RESCHED.

> 
> > +	if (unlikely(flags & ~(SCX_KICK_IDLE | SCX_KICK_PREEMPT | SCX_KICK_WAIT |
> > +			       SCX_KICK_PREEMPT_LAZY))) {
> > +		scx_error(sch, "invalid kick flags 0x%llx", flags);
> > +		return;
> > +	}
> 
> Maybe add an enum with all the valid bits and test against that?

Ack.

> 
> > +	if (unlikely((flags & SCX_KICK_IDLE) &&
> > +		     (flags & (SCX_KICK_PREEMPT | SCX_KICK_PREEMPT_LAZY | SCX_KICK_WAIT)))) {
> > +		scx_error(sch, "PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
> > +		return;
> > +	}
> 
> Does this need to move out of the IDLE branch? It's two tests on IDLE instead
> of one, and as scx_error() aborts the scheduler anyway, the early return
> doesn't buy much.

Ok.

> 
> > +	 * ops.enable(), after which scx_bpf_task_set_slice_expiry() may override
> > +	 * it per task.
> > +	 * A task in user space still reschedules on the way back from the tick; a
> 
> Can you add a blank line between the paragraphs?

Ok.

> 
> > + * compatibility wrapper is a no-op when the kfunc is unavailable. As with the
> > + * setters above, discard the kfunc's authority result for consistency.
> > + *
> > + * Keep the wrapper until pre-v7.4 kernels fall out of the sched_ext scheduler
> > + * support window.
> > + */
> 
> Just noting the version it was added in is enough.

Ok.

Thanks for looking at this!
-Andrea
