Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8736635F17D
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837823; cv=fail; b=aS2dfTpz4GizOqURDL8Quf6pGSa8XqKmAfMQ9wzSoLKoyx3rYY3aJpRkNHaPxB398/mtOkpI7PiJ9Jg1w3GZDegwSTEmNtnxOagEj+hB2HrnFNNfJ22Kw7RevU790wyYAeb7AyBfuJsyFOOze40hAAxRUJY+m6U3vO58dJ8POdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837823; c=relaxed/simple;
	bh=tYUStDGe78+FscrsAGjur5EEZQbbkgNkm9lgYh6GzRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eryWVVJAOaTMfYx3BTay+v07Bjr1WkoOtROdgsq/P0D17HY96dH/DaKljLbjBH65Otqr67R6/u6fchwYXEpWs3kU8Lg156udtDSuBvTOU2HTgPRmDmpDg4zOGoZkmQcEubVKtSdmB/PFQjqayKKk3VWSgqhq+5DzRXFREEgAn98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L0yw7Dzv; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L0yw7Dzv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haFDrw9BJdi9JAlgTGweuFqmbpIsLPnIjQa54zkmxmO7chU7Xbrzx6CA3IEUxOuQu2X6Urt0oZWcePmxTxGgT0anEpUjChlqnFhTSEIo6K0vFJwfc5mfqUdES2U0rCD+kTIDiHCv/AtAG0GnzBB7FJJxgWi//siDKz0++8xOJ7Lb4cxqyNf4P7H1x1XMyfnMDTKtyKwLXDrB/gILyU/vx9nmlfGv7PAxbPvKlx4vbpoqdnziUzC7i/utpin/P6sV0SJChSzrKYfbMJTqN8DIt7/HqC0N965UFoIBHHEPU3ezoT3ecjsnYpNvi/Fak1/o/8LrfLx9n5kPXyBMQT4dbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRE4mAV7z1t/octThFrJwWP3JufN5e1V2vBOvfaH2Ds=;
 b=baLOUj6ntGm11EF0ZeP8LWrWZJIPmWUehyhUAxhr1LP2RPVqe9W139RifWL2g3IHCvxKlOPOlaVdh4gmRcYnvk99etPgaVYrzxDgD2MQiu0EE2vgCtE65MlNDE+5PNS2KJ534MPW3ezsFIiNoizx9c/nbWQPoQCFX/qf8lL0pf6vfGjg6KBkKoDjrceuHAMUyBtzMi2C3XOX6BvkemcYzpSxkkMA509nol6fIApBn7Qfkwf3hihVR3OBZIfhHawBmeIMOeciPASENZ0e7D8Cvf1qTVZmKMplllc2q2QmLuNoElFg8cjBCxGnRi+jZQMgj8E0jPUsm8Vu7XCl5qAJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRE4mAV7z1t/octThFrJwWP3JufN5e1V2vBOvfaH2Ds=;
 b=L0yw7Dzvz9JiGBP7qXCeU1ztKRgO98+7VAjSusm8Qz2P3EHZoPwehb2hteiTfqQcjLz2tSbiAqU/rc7HWy/VAV0MHrjF2EURJj3cp41cx+89BWY7hmb1WmpEL12Q581vXjtj0wnJnb9BFu72PVIAnka5Ki7JRw/xkl4dC9q4zObTFvDadgwjHNS0SOvL6rgzJaYJqj24SRbZsYFwdg8KSRCMOG4mwEsW8orQth5JB7pxG9+WGsF4AAYLlZuAqqYg3tHGtStZn8gaL2LMXNiLW7yzSmQKRQz+t03HNxsgZw5HwJFAH3DUW+NVtOT+v/ynQEQ1QLoxQTV6Bfs9XVYukA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Fri, 6 Mar
 2026 22:56:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 22:56:56 +0000
Date: Fri, 6 Mar 2026 23:56:48 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com
Subject: Re: [PATCH 10/15] sched_ext: Add per-CPU data to DSQs
Message-ID: <aatbsAPM9J7fqHH3@gpd4>
References: <20260306190623.1076074-1-tj@kernel.org>
 <20260306190623.1076074-11-tj@kernel.org>
 <aatbDPw3wcY0b0Lx@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aatbDPw3wcY0b0Lx@gpd4>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: cf93d873-e9a9-4332-f6fa-08de7bd3aa93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	PPTRzbUXW5xKM2uK3FZ6obB5VMO0Vf7qEjLyhIM8vr1ObSXSuod92cK3MPMf+vrGvRsiL7QjNrPvX6Sz/cYXiiI50DoZblM+TRfiLXnCTXkbAl2aDVfJeu/CQ0hYPTl2GUyz6OSDB946hH13kyFNXczP1SxsTgh+KiDQKWxd6apr2Qfyk0PkX3SQLPDv90c2Mby8B8j+xiH3zG0jbcD4qyJ4Rqd4uj0CSpa6TyFSu4hMSuwX0WSyuxw8DaACClcv7N5QaIDZwQwrIS8xObbJQXDPdFRW8P3w0yoNQ15hQeoNl9XtZsM+sdDy2TKZ0sY1/NRYqEU3sgaI1KNnHP3y/VMt50ePK94agoC9ssGHb7beBz8z+MEr0HnQQYPbKo8kh8s0NE2D48YVIXQ/XEHahEVdgaX9XwvmwMm9Bn/u1P7CYhb2922epU4m5emJMYbaPv4+hNKVNkOY0zBo4M/Bv7a85lgpVGX7xIkM0jHbML8rKjO5nAbpzdIdT+kXWcPBC8Iy+fK4RX3fcNkllTmNBllzXQNghNTLsjMhYWIDFLhclq5jlpn6mryGMssItciPaQRj2Hpm7UeS6s3Eoy+zIYNAyamYpoQEefRxOQjGM83N/6hzhLKl02qR3VMHPgSZ2eEWSs3D9AlxBvvz9+BC6S0pzCWC9Eyx6xiB10jErvMoiEzima5MyeQbfGJJEbMGvoS1sJHhAbvM26jJbgM+JBu8piBdXlAtitTM4outvGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8lbqmKIrHlu0HB8Yd9ZqzDwUWvxb0ti+tyey8xRTBCBOfnExGekhG6+mYDlE?=
 =?us-ascii?Q?yRqta9apD53CRFpbC7vJj5EaH/QAp3Ch62s4CxGq3XiTAGRBnjmOa3fX8djr?=
 =?us-ascii?Q?aE11weRLXzNpDG/4n6eUReYXN6v7QX7riuqD2g15dailOmSH3IWK/sl9FyBm?=
 =?us-ascii?Q?PJoqMMUAwkgtwspaIfFLpBlSStuyKtLCuxtwfUvcU6Lt1w5XbWNoZrsKHjWs?=
 =?us-ascii?Q?7jUUZbKkaFRmX1AGQQCBymZBgV03xf1K7E382Rnq0HXCblSw20BjS1Y+rGYZ?=
 =?us-ascii?Q?oqoxZyKw5CHOqf/nRXQU93hFq4s7jLGDvD78JsmT3UC7gTor1FugjZu03SfK?=
 =?us-ascii?Q?0cKXY3TSBEvBYS214t7PDoxr5kg6HQWXfpRzH9pPfOI6rISZHaHpAbqczWCm?=
 =?us-ascii?Q?L6ILF3LxRHtgX79PGuSQ42cCbJboxjHWZ3p43NILXJ1hOOjdLg1EFMLUz1u3?=
 =?us-ascii?Q?b99adNx81G84ASAfjb08phs+vwf8eGXQ9urfAlQpsMQj++KD29+DzHfKhUXc?=
 =?us-ascii?Q?9QFOpm2wRnOdAzU6RQ+DiZ90vJHAkcpOe7yxzDlv1WrJ5tzhvt8ycDMLVr9j?=
 =?us-ascii?Q?AGq9/5IUbApgNXTGH1/y6cu+VmzDpgPHcKRMhrA+xT9lnWYxVmPFXGDlhutb?=
 =?us-ascii?Q?eZleW3MtpXK+GhYb2cinEubtw4lUgpnB2bQiUrOeaSuat9PMu/ydaYtcNvyo?=
 =?us-ascii?Q?wcNGaH0EjQ0DrWb/9TBcs0avjX6B9orf3IBo1cxGyetNrW2MG1eXAmTVCchu?=
 =?us-ascii?Q?F1X0sebIkJMz/1lctMh4k/ZWIISdJj4xt9inVLweZ1mAsJ7mEmlPO1W1UENd?=
 =?us-ascii?Q?LyGlMaYrrf8Ywx+JcQfBrgDoyWAk7ERVIFAGF+pg1uXuCoQEKOogpILOVURV?=
 =?us-ascii?Q?49f3Hg02AUPUZnQhJyhpsboZMYxL00UC3fYCNj5WUdvwX0WGRNLMipsi6SBH?=
 =?us-ascii?Q?EiA/mmlbPvFFOkMkb3dG1GEi/+lpyEfhvi98h/Byo0sfeqa0l55d3b57Deiw?=
 =?us-ascii?Q?UqV5LmTYZKMsr67sR+ZXjSlNhH2aVX5YI/yrN1DIG4HpFW1/7CcvZnAHdLcT?=
 =?us-ascii?Q?QESXI8zCOd0KtrQ50rSQ7NsQk0gsLwacNMAFSFkHFXMM51gr3XBiXUa4IK1G?=
 =?us-ascii?Q?CSWv2j9qXTW1VS/PDANPY4APu2MVU/kmM6Mqh2Hq7sH0R7MUeUnPUKY3vt5d?=
 =?us-ascii?Q?VY/bzDsDknohTt/RXU9Nywu5+7GYlt7n78uvvMpVnUJ28PgnASCGA5MZbdHd?=
 =?us-ascii?Q?3pua1I0gwWd9TpBKBV9O9dHKvG7l08Ww3gP20phsAvfBylrSWfbRkj2xhd/K?=
 =?us-ascii?Q?AB8CopUVj85Glw5hjgt61tnNud/RsSNMy/F2DV+6RLsmlPWahW8FwOs8YGOh?=
 =?us-ascii?Q?uobE+yv19qkvRe3Ch5snDj4hREEk49CuRGCg9Xne1l22uN0RfyudQx+nbik+?=
 =?us-ascii?Q?+5RzdrRtDLidbCzWy7qHuf8UeNHRwPL0VJWOrhyV6VeNhlP0mtGxb3+fd4sm?=
 =?us-ascii?Q?1VkDTgC4c/F9ghA7mTQfLDqnh/e/cKWLW+qFBjTUs95MFxilGZN+i922E1HV?=
 =?us-ascii?Q?UIOoReLQr0/0rVwpyy7Fk/g25J5rS1R/mlkDZx7U/c1FUljovkibRamVqNsb?=
 =?us-ascii?Q?1KVjOO4WuqWiaSFULd+1IXDJXhKYb8p8siG0JNrRGCWrdriMpc2eKwXPm9Cg?=
 =?us-ascii?Q?C3VESXWKEeIB4Z7YgapilquK18NhfU9taQYh/33lWBLq+oSRU5Zd8T1VS674?=
 =?us-ascii?Q?owAS50UagA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf93d873-e9a9-4332-f6fa-08de7bd3aa93
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 22:56:56.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di7qmj1m27yo6iMq66PSDkjzWZNceGkVSBxMNa3XXJM+D+dWPAU0WaBnUpn3zn3zg5lPZQe+Acs6bWn5L925Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494

On Fri, Mar 06, 2026 at 11:54:15PM +0100, Andrea Righi wrote:
> Hi Tejun,
> 
> On Fri, Mar 06, 2026 at 09:06:18AM -1000, Tejun Heo wrote:
> > Add per-CPU data structure to dispatch queues. Each DSQ now has a percpu
> > scx_dsq_pcpu which contains a back-pointer to the DSQ. This will be used by
> > future changes to implement per-CPU reenqueue tracking for user DSQs.
> > 
> > init_dsq() now allocates the percpu data and can fail, so it returns an
> > error code. All callers are updated to handle failures. exit_dsq() is added
> > to free the percpu data and is called from all DSQ cleanup paths.
> > 
> > In scx_bpf_create_dsq(), init_dsq() is called before rcu_read_lock() since
> > alloc_percpu() requires GFP_KERNEL context, and dsq->sched is set
> > afterwards.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> ...
> > @@ -5849,8 +5884,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
> >  		goto err_free_pnode;
> >  	}
> >  
> > -	for_each_possible_cpu(cpu)
> > -		init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
> > +	for_each_possible_cpu(cpu) {
> > +		ret = init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
> > +		if (ret)
> > +			goto err_free_pcpu;
> 
> If we fail here...
> 
> > +	}
> >  
> >  	for_each_possible_cpu(cpu) {
> >  		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
> > @@ -5932,6 +5970,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
> >  err_stop_helper:
> >  	kthread_destroy_worker(sch->helper);
> >  err_free_pcpu:
> > +	for_each_possible_cpu(cpu) {
> > +		if (bypass_dsq(sch, cpu))
> > +			exit_dsq(bypass_dsq(sch, cpu));
> > +	}
> 
> ...we are still calling exit_dsq() for all the CPUs. We should probably
> call it only on the initialized ones, or we may touch uninitialized mem.

Moreover, bypass_dsq() is always non-NULL so we can remove the redundant
check if bypass_dsq().

Thanks,
-Andrea
