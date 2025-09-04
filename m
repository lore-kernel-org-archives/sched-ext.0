Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A573090E2
	for <sched-ext@lists.linux.dev>; Thu,  4 Sep 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009625; cv=fail; b=aNlNqmIzgDT7e1ikit5/wHaO9Wg3FSooeKrDdqL22oSRk2DwsJIE/csdCF9N3Z9pYNMb/GJbf1fpOOlecTWm1ssIRNkIODkuhxIg6w1MxzpzVo7eKRx2GY1mUW2Lv0rX7AprfdYBjCiglCnjvEwySFhAEvuLA0hx2Hs7+2GGJHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009625; c=relaxed/simple;
	bh=p07tAsgj8NrROX0efjM3tW4mic5SI1LUefGt44WMht8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C6g1nGg2RFo/L0/dVFksQTnx6m+e5D0DyHpHQhJMcncdyef3IPaR3npk3ksMlxXXELKsG13KDeNXt1pP0mfv0/5f2dATYrn4H5BGl5rNvp+ZwkM1xLOU+OP/pPf69FyE2jWzqht421xMqvcaATNlP72i0lTwQK0h9TLimTuJbJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BwKzrEX1; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BwKzrEX1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVk2K3szRu6Hin0yinLb7ownU/cV4lOVpHznJomf1PPPussHH6oeYqncJ2v9vSop0bSwUXxJUYewo4xdrJGH+lGR1JFbv2zlqDqpzLWnGH1nXsF78SYFUPLnevAIGeVpLC1Fme+Rxr5SM6UDjSoe6Q1pGIc/MUksA7xHG14WJfLewVPKkDZUwf8pN6KY0HEUjYtzMnH9wAMwJ+BoRiTAHvF4gXLYo9bzzcyHqVQ0IxAf6EOLHqsE/XBj4dTV9ILr0NXcNASUmLtBP9/Y5GvSbYwqjHTszM19VaU8LRnEq0YWE6F2jkdI11xWJ1CB8tQZoYwBON+E33aStq1X2AJO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/11I4DdvqIN8b/bDQtVD44WiUoyqxvOFWXrvBsVZlg=;
 b=G2swswSs/sjHYpptWQQEOzBTCKLzHl9GRifd0Lc2ovckr2VrjKIXUxOoUjjp2iYT+iz6cZTLWkkP9Jrs/CVUfEL4ppnmxCwj7gUh/H/meV/F4A7kafFk/fACKFJjKn6i/EXadzPaUFziXCDSFh94Na6B3E6Hm+ycksMPC4t2sxUNBibBAMzeJYs9gvpjr4RYmAG/GAYTB7AxEyS/vA4fa7/yIT1C36jF3ZPSh85SN+sXdGQ0jTrIkuqC5VVDu6BzLYJCPk6ZUyXBp48//QkWnXooSsRFpR+126ECyqnJbp+jmaZVG417War0gQcXBSCl9gjJi2j8bFW0ck4geDivlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/11I4DdvqIN8b/bDQtVD44WiUoyqxvOFWXrvBsVZlg=;
 b=BwKzrEX1VpOsw2AKWsrlwgy0Ep11/FDedHOb/PdZdAkWN5423EwSCo+yfA7lTSY2hkQ30seH387SAO3R3qe8EpiE8SAM/bMgf5uqKfk2rtXd7gwqLhrebgaKi9l/AvRWoM0qr4rmm5TtPIuG8oE7Cmp0I3hPjuMFMtqKGHy6oiKbAJI87WGdGHLrGczUKkGxo2xcunHumGNotS+cTCXOAZqpst5N2o5ROxsIUNI8G/nL6RdiOobC7QZYVUKPpAa5kO6U3mq8WkvCcwUaQsOpRYbK+B9q4a5h7K/uYlLIYHhpy2M6koYwEIub2xet36cM7wgBqxaxy7jYf9yIdZf7SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Thu, 4 Sep 2025 18:13:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 18:13:40 +0000
Date: Thu, 4 Sep 2025 20:13:34 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Jake Hillion <jakehillion@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Fix NULL dereference in
 scx_bpf_cpu_rq() warning
Message-ID: <aLnWztwCj4GyJFyS@gpd4>
References: <20250904125522.561737-1-arighi@nvidia.com>
 <aLnO1r5X265Knl0W@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLnO1r5X265Knl0W@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d49621b-020b-4cfb-19eb-08ddebdec6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ECuJAD600YnXp78Ew4WbL/QavWRESC3Q+paYiWaD4zSSfRQzrNpdIumEUs4?=
 =?us-ascii?Q?0ceIg9YSZ4HeIhWpDqPjF7iWRRV89kynRA6/67q1DGcJStj7rhtsnJI7xyka?=
 =?us-ascii?Q?57XZWASn7JEj8rX+3RWfXSZPm1rSJghRBB1sQicu3OJZBc3r9hh/WPY6fpzM?=
 =?us-ascii?Q?l55Y+RnbQIWfxWE6TWAXLJf++4wueSsqG+JWs9i6dOMwlFOJ/6439I0b0FHB?=
 =?us-ascii?Q?iLm85hgEH2dHPo1DtNrNhft11U7c2fQ76uBpjm7p5tmTMWVc2YA44EQcze7e?=
 =?us-ascii?Q?KeBR4GxwT04jU7SreW3Wkgnt03eL/yn9xvcsirU22kVp5X0TccVWd0dR3VVS?=
 =?us-ascii?Q?gEyl3zaO0wMR7UOi6is/bFNplVa6bj5FFhB+YlW/spkdgJnPUsAC87gXdgdl?=
 =?us-ascii?Q?hNAkq51D21RSry+/5BI/Em/99DCvwMZmoQzN/9ZXpC+rQ3FQcqAyg2dlM3hN?=
 =?us-ascii?Q?Bj+ZvnE51fMf4g2g+0EuQIVMVgU9Mz86OMYZc9J4kVOgJKRfGxiy3hosICcW?=
 =?us-ascii?Q?81DAzKTpuUrK3zvYtxYhM8hYAyi1cIG8rql37BTBUMKnr2gur8MGonhNxRNJ?=
 =?us-ascii?Q?7tYUKjyhJvP11ulFad0QSvvwL21BxfogvALVFsLG05X1CF10VY7XzguTwjnD?=
 =?us-ascii?Q?8ypC+XBo0cDFvrXH09prZZjyU3OiIQ48Bzk3zj+hWcVXVPR58KpCbckAhLqs?=
 =?us-ascii?Q?L0hLsTZzAOSi0IS+laPhnjUMpwW7xoynB1MmqsKNCf4vMuSJ8LXqmq96kIAy?=
 =?us-ascii?Q?QHEoBN/LtgcCqZP65WFNi/kL47G2mByPlOnhGaskFdGL7PGiTgp0b8Y25GrY?=
 =?us-ascii?Q?CeGcs5pPbx1TNXuLtIVfNdvvw11rxW7LUwuX2wGlXoS9lwkDYipZpFct8Pcm?=
 =?us-ascii?Q?tAxqqkQPuOlJMhQFSjFYL/YrJQl5enBuDI28gA+bQkWJwP/SxA2Wm2qrrZKN?=
 =?us-ascii?Q?lVwQWekk/8pADz6dJn776H+bunQL3HMgdsj0548gHBuLPkbaW09SE9BQe51u?=
 =?us-ascii?Q?Gj/wYhVrO12ZoI3FSruXfDGCaRMg/q8PnHcYRoH5FmVzbBO8BY70uhdbO+GM?=
 =?us-ascii?Q?L3352h3ZR7MxKTiC+kDQIP5wVkmUoj5/fOS2O6kMeOivckYF9joFrkYwaxR3?=
 =?us-ascii?Q?Q5a4FRhO48HLmVMHuh9AH4PYVdmVLu3JkrUQRBa0gBsp3Egt7LW+aEGq3c4v?=
 =?us-ascii?Q?29bqPpHWAZ9Sz+URmIK2kdf1iYazHrzp6xFzo/toS4jXQCsp57iruTSTBN8S?=
 =?us-ascii?Q?I4zi/BK2GsKWXHh49OLqwXrmh1qOmW9J4S30sNyJ5RaQ76j3iNgbVCvdA2Na?=
 =?us-ascii?Q?+bvZNEdM7v5c4JH7pewoIoZtVbYAM7wVDtwTH/DwzGsP1h/3uhUKyADSuoCV?=
 =?us-ascii?Q?lAgmharpuiq0ON9AC3t3uD9gD9CFcXQKUGYOBdS68codzSWWcidxkzERVKw+?=
 =?us-ascii?Q?cT1RA3KyvLA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?goASO94FCrJa/5mhBsGPPb3m6d/fbdPchaXm0uQAJ6tUBgOvUeVyDpcOxQaB?=
 =?us-ascii?Q?YeZ6cxOUrYW8St8FMtQ6vgVKX6j9dkxFa1Znb/dUKZ12Mm6ZjKEdqmpyHvpm?=
 =?us-ascii?Q?RTe1hGfmH/1D76U4OegY2c0Z5bMTdFzQdRfA/MjZRJnKO7nLnYcjhO/y9ozU?=
 =?us-ascii?Q?Kw7dtA8fX0IVtR30c6pPfIrb2ldxPA7kP7jh/7wJUhOKOQD+5bGNBIYWQRen?=
 =?us-ascii?Q?vInlLktmef0uxS2iAD52+Tuz3Wd2CCQCFAYfcYaM3ce+bAVDlRKDsUk6faow?=
 =?us-ascii?Q?cgergxGd9R9wQ8d6IIjWwo5HNC0tNJoh5qU3ObqAaBk7th8wkg2xV8g/l9NQ?=
 =?us-ascii?Q?cY8F3RJGvSwxBUXE7YIe31OOZ9mrrp8Dk04BWphijTD0rVsOy3gPY033aKHP?=
 =?us-ascii?Q?tgh9Rk6Zg3fK6mcbLmLX4s6uld0nsdeURonoJqFzoQ9cgVvzPveQyuJ4Lc53?=
 =?us-ascii?Q?MS7HWR0P+cy0EolDGN644jBXQ8yv6hHf91VZbzoyjesk2xJoqACdnlLQ913Q?=
 =?us-ascii?Q?w378dzt5/7h7OeLfHcIzPLq6FXVDNhbv4GGGh0kD/vCfgWRQEvPMDGVr5rdn?=
 =?us-ascii?Q?dkpc8cc1IyiMsLaVhcXWDF0xVVpth7h1OiusJ22se+2TnQEGowM34+h5g9JI?=
 =?us-ascii?Q?LX0x6qMYTo8kX5ugdDKYkTtr2E1IEraClXdBdx0KtvKOwL/1oskIO0lfFBi9?=
 =?us-ascii?Q?OvicHhEsDx9KB6L9UfSrm1IG0LI7B3I6rHLWVKXH7oKKT9x62uDyE5GLMKU6?=
 =?us-ascii?Q?+GyP5o2+1jHEFwP4qQovnMDy5WL0fNFdh6GvYSgFenzJQ+QJumOfUfM1Afvl?=
 =?us-ascii?Q?djjHguwqj18Qih7GZb1iyEnkIXviIVlvMkVn7hH/8YCaJAvA8vIxXUjWw41I?=
 =?us-ascii?Q?5FCpgxi7fq5To684sgrh4/5k2WRHMvkIPC47YGpUxz5UAAHXuFf50pAT75ji?=
 =?us-ascii?Q?vHG7XVr5O+oD6ae9DTPibj2GjGVB1xjRA295rHeg4IuHknLRz9u8sR8B1BHU?=
 =?us-ascii?Q?GuFRITA2IRbDzdYVbqkzuMeJaF9uoiArF87I4yhwWrF4xvgedI8JDJ8MKyhd?=
 =?us-ascii?Q?+e05aK7red5IDn0jo/ThQ0uRuvoSjSKo4a4txmynZvy/4eKrb3hD5wa8ciIT?=
 =?us-ascii?Q?kL8uJeo/DXDLTg8FHOonTEAcu/JJBFTQHb5Ep8UkRe3IYYV9ZIG/l+uV4v3e?=
 =?us-ascii?Q?ye7nUX05n1OsikT+rABn3y8TY3oFw3EKQekB5LvozLsSetLS00zlB2/KaYO/?=
 =?us-ascii?Q?XDVvtDW/ym4jiwB7qf9W+r6Ebi2Q7LClIrWcFmXvH/xCcKgSr8Tf35Skg/+T?=
 =?us-ascii?Q?pV+8FVT6VcmKR92qwIj8V0Ds4Jf60xgE+55uMI1SxFEk2BgrT7QitfzJQCWB?=
 =?us-ascii?Q?sDvFecuC3a0C8OqhsEjhKweSn227Zo8uwkt4rRJddFdNUEtUi/zWPJRI0eFV?=
 =?us-ascii?Q?uMUIWRrghj6ctRioI5SEFZz1i9dQHjBTIJIrgJ/Zs9dVVECLAyJA+UY17TZh?=
 =?us-ascii?Q?re8D7r9hGmbPI/pwBtddqyOxsqF8KKxmwThU4EA77GwcYj4MciI/RlAz9HQ5?=
 =?us-ascii?Q?M400iIDiurT3zqIj+Wkq2MBqqjlE4e0DIl3RddGs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d49621b-020b-4cfb-19eb-08ddebdec6b5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 18:13:40.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwfo/+vbn8CtUIgB7fFBDye8F54SeIi3c2VGgCk9ZZkIU9d/I868jC28+z62v4Ccb+qqMIRh1JChQ49b4CXMtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592

On Thu, Sep 04, 2025 at 07:39:34AM -1000, Tejun Heo wrote:
> On Thu, Sep 04, 2025 at 02:55:22PM +0200, Andrea Righi wrote:
> > When printing the deprecation warning for scx_bpf_cpu_rq(), we may hit a
> > NULL pointer dereference if the kfunc is called before a BPF scheduler
> > is fully attached, for example, when invoked from a BPF timer or during
> > ops.init():
> > 
> >  [   50.752775] BUG: kernel NULL pointer dereference, address: 0000000000000331
> >  ...
> >  [   50.764205] RIP: 0010:scx_bpf_cpu_rq+0x30/0xa0
> >  ...
> >  [   50.787661] Call Trace:
> >  [   50.788398]  <TASK>
> >  [   50.789061]  bpf_prog_08f7fd2dcb187aaf_wakeup_timerfn+0x75/0x1a8
> >  [   50.792477]  bpf_timer_cb+0x7e/0x140
> >  [   50.796003]  hrtimer_run_softirq+0x91/0xe0
> >  [   50.796952]  handle_softirqs+0xce/0x3c0
> >  [   50.799087]  run_ksoftirqd+0x3e/0x70
> >  [   50.800197]  smpboot_thread_fn+0x133/0x290
> >  [   50.802320]  kthread+0x115/0x220
> >  [   50.804984]  ret_from_fork+0x17a/0x1d0
> >  [   50.806920]  ret_from_fork_asm+0x1a/0x30
> >  [   50.807799]  </TASK>
> > 
> > Fix this by only printing the warning once the scheduler is fully
> > registered.
> > 
> > Fixes: 5c48d88fe0049 ("sched_ext: deprecation warn for scx_bpf_cpu_rq()")
> > Cc: Christian Loehle <christian.loehle@arm.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 489462290142a..04fefd34db238 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -6362,17 +6362,20 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
> >   */
> >  __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
> >  {
> > -	struct scx_sched *sch = scx_root;
> > +	struct scx_sched *sch;
> >  
> >  	if (!kf_cpu_valid(cpu, NULL))
> >  		return NULL;
> >  
> > -	if (!sch->warned_deprecated_rq) {
> > +	rcu_read_lock();
> > +	sch = rcu_dereference(scx_root);
> > +	if (sch && sch->warned_deprecated_rq) {
> 
> This drops ! from the condition.
> 
> Thanks.

Oops, thanks for noticing it Tejun. I'll send a v2.

-Andrea
