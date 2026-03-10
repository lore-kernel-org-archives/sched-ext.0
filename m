Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D134844C
	for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125262; cv=fail; b=mkCbnwUyZm776GH/LcjXEc2Co96nMrJMf+FWGqB/gMrGhuydoQMnhLEmdXbQpezscspgtVuFCktBylo1WkCZbscVvEHqFAEhlRjXaIthqdVfpkbruqoywe0eZ0FZoD2W1lyzRKF/y5u4KVE/m7yGV6E2myh29MG7gvXAcpD8qNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125262; c=relaxed/simple;
	bh=Pfuemmf9sch8ZhJu3GVqYfZt/tljVmRXZf16GlA9dA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mcmI2I7Ut7Mco4HU9Pxqx58j8jRTaUH4v8dBwg5D+vxM6oXq+MidjJiq5O+MXPwfUR40fP0gWUdwa2Fq+jeTnR023nQLuOUscJbRhNPM8JpQfvjG3D2S3Sm4HEGF5iWe48OVekw0HxsCOvVX5f5T6OKcoEICcXiz4GGvLJlUVP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gkOVopUA; arc=fail smtp.client-ip=52.101.57.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gkOVopUA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwjeH2i7WnWw67KAl0EccDX6fQ9lFh4nXMvPjaWr63BD83mhxzYKbz8epWXUXbt7nqWQfQbVTqPA2JYLgIzZUqKdW1WvH3+6TIYOsR34WV9SQFUJJcBueypgx3lMQG269CqhhsvzF4AZklYeaCfm3YWDnfA1EQ1s9GtptWZTQt8rQ6Un0e6umPRkgDTEn2wDTnRhKXYcqOTJJe7bFDJccL5hiplI4Fr6U5paaRAaBbR9YkP3EZ9Ne/Pi84Nl/OleyuzrMHp2wEzEViXG/iHcWxE5T8K8Des1R8hiP4rhu4sUFGb310o7rGkNGqxOSRlYc/FLd+xvPVlojar+CJejlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bA2A8OIIDR8tWUzmWSvTO2QLjCWTGYqrdN5o1q8qLY=;
 b=d98oiNXobsryKqWdlWEf+XNzBhvUHXQYzzYqYLMt922DLt8hTfkDCAAtB6QVuYmX3NGf0RaQUWzy2N5WOaux6wHMLznZqaqCcgbWBKReZwMnNuWvQ80b75qaqVqmk1wCBGcwhZcQl4qPikWYKtesK925+AjY48X/OvHWTSOWWhcHU0Etuz2+EQySi9EGpttoCWb9MFBzSK+904ZLq3JM1fY7yPwWI0UuZuPx36l7l4Z5bhjTtqyWvLHvwKeOJaMAJbzV/sfe48yGV3mmBSBXDufmPxl0grCliEvAltCShNYU6ghpJZS5i2kOz1596fiJnMzqLavU8SuoYOxX4Ma/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bA2A8OIIDR8tWUzmWSvTO2QLjCWTGYqrdN5o1q8qLY=;
 b=gkOVopUAFE7bh22BAxuyvQHqZwbZTewNbVs37inPtUcYaRGqFOdmj5iSh9gaZedd8BCSFagiITlH/71Ddr+8HgiMwrL7kmqS8RKHtq+Tsf4NXlnBrHJ+wj8IWWi/qRDmyvRGzNDYqLL1xbE2Mn4N70Qc6DXtE9ZkZ2AvoFDUsXfhqbkzqIwCt4PyQyLUnULU1XiHr7jc2+DAnYFe3SeRVb82neJK7TrZ9vEPJ20daTU8A8B460GM2en/PDVSGGAxDCLPJXv9krJFD2DofQWfodlQI5l4tkC0V6gpFI3YDPq0INrAm+vNAOQvEEz29/sbEmcDuJOj7FTWLQlOabSVZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 06:47:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 10 Mar 2026
 06:47:36 +0000
Date: Tue, 10 Mar 2026 07:47:26 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched_ext: Fix scx_sched_lock / rq lock ordering
Message-ID: <aa--fsiEFsxc0gRL@gpd4>
References: <20260310011653.2993712-1-tj@kernel.org>
 <20260310011653.2993712-5-tj@kernel.org>
 <aa-8hNTGRvHUrBsN@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa-8hNTGRvHUrBsN@gpd4>
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 479a5114-d534-4c8e-a2bf-08de7e70e9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	G3HABYAeqCjcNulGxL+OI0FzTpHIQ3vYI4NixJYkhe/Wy5qUCyS6Jkuaec3v7hz3dt3gkj+WJ1NfK/CjBQPljl94qHwBMVnIF+TijQCHjEol+tEDmAyadZ9w+Bmu9fgfqoaFk+bsBurJXqtF416ku89fN/3zap5QsfClHjFTJxetQ0+6APah1an6/WghFuxmPxMapdBlcsGGVVvXDB+XEiPrqdy4PK1l8/13EEYqeTVxEkQk9wu3RxegDbj6OQdTmjWn1tcMl63bTvCSyLL/kIt1AlM96MO7ZGlZprCYCXs8PRQvFJI8qq/VzMYUkV/sFcxY2cAtcKKripQ+s126kgC60HN2Qw1t1wIvQpNEUUtQuquTrwkBT97Yo6SomTmZPrUz972j2Iw8Jc+ZuCgTo6i+KxoI7mB9bYr5AtRBdW4u9I4rkP3JXioI91glr3vMMfY76r/8Ij1lu/0GpzwFxb88B9LHEWN0FRUVEnA6y3SQ5MC6kd5gisafq9602x3RqMDQhLhN+Xt3P68xee4YavGSCwqpLyuPS7FwRRHH73h0sC11LBrGpNOWUv0yuLrhWyAIIZUH+fcLt1Dp89Arpdl4pxj7d3owIZJbt2B5kYYIH7wa+mt8VCBSotLeTZTISc86h/PxO1OEbWbOGGy5wtWuJhTzl8Hevyvc1d/a806LKWtTzm2leA/mifXezEWRpAtHlTItuKaiXK4TO8bH/lihyEYzrQaJEEhO/ai+cNs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uR42jZR5FuAvTT4H6FzmW0mv9n/Q70sTyU9JomscDPFV0lBNya0cmSMbRbkg?=
 =?us-ascii?Q?t/Ql8Fx9DGHZfbrLPuh5OerHjTes04LIBLKZJTDNMyKXEenndojT9XY/8/Pr?=
 =?us-ascii?Q?lkDfXAOVKPl86snQfeGqSTXasUX5vMbtLyJZ91IO5xPqWumWWCYXzd9EKkD5?=
 =?us-ascii?Q?gn3jJvdIxgm9DQcgpsZFGFXb8W5QlHuap4h4zPGaUn/llgQ+2S0P0qX0RKPg?=
 =?us-ascii?Q?XUP3brSoQsL9nVXlK8iiKE1QHOOHPabDF6rcW6NFkG73LfJdVVhlZrDXEZlS?=
 =?us-ascii?Q?zfU0BdzzaasEN+YZGdlVQIZ7QCSUVoFcbbCZyR9u79zav0qdKc77rnFvfVjB?=
 =?us-ascii?Q?+3VyZi37k9HxyEQq9qjirwjwsA2943Ea4SkQ8J5N1JKQmrGzHNYxCS/7sN15?=
 =?us-ascii?Q?OnmhEYJLod7gzpnQJZk3Sd6rzw7VkWhWN/03Aca4k8FE6O0J3fEVabw9V6xr?=
 =?us-ascii?Q?vXPAy00qAr8QbU/L3AEWqPBeb6SthokQeuMlGxoiVOw1uNnQ9cyccXn4XGQC?=
 =?us-ascii?Q?d1HGfm3AdHqix1xs+V6vdctk/Yx1hpcKn6dZ2gePHu1tzsi5/ShQjUhI7Oqv?=
 =?us-ascii?Q?K6eZE/Lk/hVDv8QiyYQAqHHaarAN8fWyOhfJuVcewh6t/2KSubM/Bd6xeMdw?=
 =?us-ascii?Q?NU0PO6MnlkS/bm05JlNuM9LGBUb1RlLbYt0JyihOwVE5w2yh/6OUnP+RHfzM?=
 =?us-ascii?Q?Fp0ESaY9AvTgiMWkI4biCoT0OJwgdLsrkLJOAuWdgQjnfKzuLRFSxOCx03sl?=
 =?us-ascii?Q?1sDnECF5IJ+ohl4+klIPVt5pMU10ueIyhUxpHfu/JcZajaWP4dkF7h400+Nn?=
 =?us-ascii?Q?rvPhDmNzgBj6CpJWbC9CKOOJPCxrwghjg7khy7qOK8naW7L17y6A5jTK+8GF?=
 =?us-ascii?Q?thhsVMRSy4jl1v1oh/gVBPFchSL6ibxUhu4SusmhdFyWcYgF2Q0S5QRF1j5u?=
 =?us-ascii?Q?3IFfoFKwYTZBqY8aNFOYV2VYzO5faiai/Y1UftBxEpCovH9diRh3X8GSt2dx?=
 =?us-ascii?Q?J8aG3q3dkzQFu0m/BUpHs/Jl3Io8cxqhuOxib5ORJPoJ1/mIPHW6qRuYpD7B?=
 =?us-ascii?Q?bzDz7BpzidZyUkFkByMWi6DtdviA6PxQTUIoJdz6aGp89r2eNUHrjUiwSM7s?=
 =?us-ascii?Q?2w29w3umd//4qh+CAXsP4MXTHXy/PuU/D5IKh0+sME06v7xC+ZktgRU3l2bw?=
 =?us-ascii?Q?Rgd8ZnwI2ju5LvnHjZTkzPbjbcOCXLfr1YBp8sFW2VHm4WM7V74sxySqy8Bx?=
 =?us-ascii?Q?8AxQxiVMJHsPA8Fe/+tQB46KvDXBvy6lRNkBmgeRcRaX5IAPNvqGpsZcy/vM?=
 =?us-ascii?Q?E4W7qGB0EcWStmWsZRjQr2JDMuUZjlSZEQV+mf3zs8X/EMbnfCoQVDEono7x?=
 =?us-ascii?Q?S59JXrhoEClnjPx/A7S9D4TGofnr8XKRTUti+88I/aOsRq6QDQCF4eFOJavM?=
 =?us-ascii?Q?tYCE0wsEvgwxTGQOHduKMBiHHM+WzrjZr9Nzi9oBpZhsIGRuX+7BXY6dm9Zt?=
 =?us-ascii?Q?x7BZonSt97+pFl8AR3w5RSS9vcIO3cpUxZif6/ouhrW47jS4OTFFCm866cY+?=
 =?us-ascii?Q?vCRB3Q5U4XX+V52jevStsBTmpfhrA8cDihwc5u1g6dlL9GnPj0UfFGxLycg6?=
 =?us-ascii?Q?fDNAdXDoVJpWz5xy48QyMLHT5DeB3xf0hsikK7/wWonv65UwsVA3CJeI6qA9?=
 =?us-ascii?Q?0Vl5kI9PKiRXu7c6vvKflQwOsiRMOLAfjiGLt3aB2AxfZi/raB0sDDk9Jv+Y?=
 =?us-ascii?Q?f4SE4EMoHQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479a5114-d534-4c8e-a2bf-08de7e70e9ef
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:47:36.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3uwdCUuZ8ZzlSamPOgnCYHw/1OCpf/odoC7i6qfbQSjC/FctReNbhNe6ZNT6diMhjxnzAQjPNLaupfK06WQKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

On Tue, Mar 10, 2026 at 07:39:10AM +0100, Andrea Righi wrote:
> Hi Tejun,
> 
> On Mon, Mar 09, 2026 at 03:16:52PM -1000, Tejun Heo wrote:
> > There are two sites that nest rq lock inside scx_sched_lock:
> > 
> > - scx_bypass() takes scx_sched_lock then rq lock per CPU to propagate
> >   per-cpu bypass flags and re-enqueue tasks.
> > 
> > - sysrq_handle_sched_ext_dump() takes scx_sched_lock to iterate all
> >   scheds, scx_dump_state() then takes rq lock per CPU for dump.
> > 
> > And scx_claim_exit() takes scx_sched_lock to propagate exits to
> > descendants. It can be reached from scx_tick(), BPF kfuncs, and many
> > other paths with rq lock already held, creating the reverse ordering:
> > 
> >   rq lock -> scx_sched_lock vs. scx_sched_lock -> rq lock
> > 
> > Fix by flipping scx_bypass() to take rq lock first, and dropping
> > scx_sched_lock from sysrq_handle_sched_ext_dump() as scx_sched_all is
> > already RCU-traversable and scx_dump_lock now prevents dumping a dead
> > sched. This makes the consistent ordering rq lock -> scx_sched_lock.
> > 
> > Reported-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> > Link: http://lkml.kernel.org/r/20260309163025.2240221-1-yphbchou0911@gmail.com
> > Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  kernel/sched/ext.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index cf28a8f62ad0..677c1c6c64bf 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -5097,8 +5097,8 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
> >  		struct rq *rq = cpu_rq(cpu);
> >  		struct task_struct *p, *n;
> >  
> > -		raw_spin_lock(&scx_sched_lock);
> >  		raw_spin_rq_lock(rq);
> > +		raw_spin_lock(&scx_sched_lock);
> >  
> >  		scx_for_each_descendant_pre(pos, sch) {
> >  			struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
> > @@ -7240,8 +7240,6 @@ static void sysrq_handle_sched_ext_dump(u8 key)
> >  	struct scx_exit_info ei = { .kind = SCX_EXIT_NONE, .reason = "SysRq-D" };
> >  	struct scx_sched *sch;
> >  
> > -	guard(raw_spinlock_irqsave)(&scx_sched_lock);
> > -
> 
> Don't we need RCU protection here?

Nevermind, __handle_sysrq() is already doing rcu_read_lock/unlock(), so
this looks good.

Sorry for the noise,
-Andrea

> 
> >  	list_for_each_entry_rcu(sch, &scx_sched_all, all)
> >  		scx_dump_state(sch, &ei, 0, false);
> >  }
> 
> Thanks,
> -Andrea
