Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB223BAD96
	for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023841; cv=fail; b=Rf5kC+TaUcCGxYtKFMDRzh2s+3EoeiUjsNpDJTywpWq8FtgVJJl4N+3yFq87cBRl1zSEdxsI7hlIxLs2DxxPxUj34lYidgSaAaarg7sI672UWQ3TUI6YAqotjFnVxVbjEQAmOFa26GK1yx/74WBNtJTP1H23FZ3OJqoK40MUljQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023841; c=relaxed/simple;
	bh=qciX7CNPt34tSOIjVyWK8jVhkyWfJfcAsJpFwj6flbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nLX/sQreA2EKao+s2tWyGNlOgMp45OhBmpIAGDvSittL2uq2No2O/CH2T2VDx9CVOIz8idbFePIyZMVgqNcvNRktMC4aWLarQp+3r3RCW/cX7aQ8BIPU0QdMY6MY6RJLDsvmd0/yE1pTQiP9NgsEeJu1hL8p13f70tHi6GiZYo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QdXPGwyi; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QdXPGwyi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE9see1d+W1raig5dQu9t/7BxMe8uabXwMz+NmIgyLVzWS1AgBcUml3WVcRP7msW5SC3CPH2+4StEXnloWc0/Pz1BnTX6YGqxERtB9LwrtOTEWcnXD/fvxJjzJepclTDdhrONobUMD+nP6LGiTH1z8qjXa/AONYWhbELe6mKO86/qKS0yq0zoc9pcUh05gUtVral+Iwv2EF6R8lmKhwLbrwDpO0tMM83cJyyYVRpitNpEKLpeI2pXmgfpcHChhGm129AzL0QoI0YncCpQK826nexS7qm3Nf+ICryTkA7sqFr2KSzD9RnMYUbap/ChaSyobyNm8ODoFilCUaPZq1W0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpZySfZ36xfNefczsdSxLrW/g/rQhEdFa6XlzfFNY78=;
 b=pH+hwxnyoYupfz2+u8vqnT4VlZazfhUG+KfOxD7tvG+M4v1xDFlqk7jkaWXq3mqFmW4NkRtYiPzyNfWiroBXJML88QiTe05oie0OLcUUiuKI36r4eWdyQy27SRinGG1Z26xDbxQKHiJ7F8R4frt/pLvh9T9dPWqtwYyAz7ZOwuaU4i1DRX/Kk2hMzd255CpHi39VsLlEc0ni1yeNqw5qexXd7szONxl9E28kgrsOvlYZSGtJjJjQTK8auQZey4H0m9SOpyoe3fCLBfEtyOdcgUf45Q7AudtnksqEWTGySSRP9T1aX7OPb14blVVP5oJDuDuZfeHk59ZxVvvS+Wczcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpZySfZ36xfNefczsdSxLrW/g/rQhEdFa6XlzfFNY78=;
 b=QdXPGwyiFzIhglULYlUCm9hmKtP70CiFKH7UMoC0BbiPBawc0lRiQG1BMPrL547lp4Gc0WR3xYXUNsEW99H/pFimk6P/QC+8hn9kGgLp1lpfWJl9zU37KTVC6zLQiARgJ8sBhZTlJkJZP2E4Q24nAhfwP/Zx/zO9vKP/rRbd2tWtvR8tm2pVD0Fo6v8f6JQxFCYXuELcXLuXQ5EF0cQIjSOyN1kxyl+cbIEt+J6H2SxFiulCC0ePtqHHXwtS/XloP8BmhBC8x38uRJPe5Wl7/9FYLap5/hXUM1YZSurnf/rlI5Tj/wsM+zB5pygurDrYJgaSCnir7IXt0mm3qKpFZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 16:23:55 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 16:23:55 +0000
Date: Fri, 20 Mar 2026 17:23:40 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: idle: Prioritize idle SMT
 sibling
Message-ID: <ab10jAVp9fP0oL22@gpd4>
References: <20260318003842.762275-1-arighi@nvidia.com>
 <mqszomfbraegntun7x4vb5x4u65nwbo74plledtdz23ean3tcy@av7vios3d3ie>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mqszomfbraegntun7x4vb5x4u65nwbo74plledtdz23ean3tcy@av7vios3d3ie>
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c1f2c1-49ee-4dde-7028-08de869d14c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BEzzVd2szEU+L/PS3OEKXmchgBTDC72Aqezn8gx3sHloYddwltxVsaD04dKrFZC+JhkZ308wYMDQlnKRl93TF04BdTnbpzcdzPwHUnH17ec3srR86F69hQ7ClCzw6yXFxl3qbDXip5pOnUCg79UpCr2rypEkP0YK2MpnRWmKKIxMYPr3fmdAi0sWEZCEy7/kD216uQf6lIVyuFiXf106scLbMCVoJhTBd6BXsOKlTEAbMaXEV64w9ikoreBSbj0KWLHOCNFbaBv4W26xbI7M90u+3AjabvP7KuyRx6S8E/Kkm73EfdOEiD3lO1Zm5KzTyiNsZg/Zbyn36F2B8RgkskQcEbQ5GQSPjKyYlF7G/uMjG7KezrqQVH3mLWv+kNPJFXY48qe24oWuaD6BvgYYs4gGroruwqt7EXx4W6l9YFAqXCopwkazL1260W5uTHJWeN5quTPMeysX4xyALCIiOW8etaDfSEkUpzvqzFVWKA0oYkQDUWZClvzOWE8hRaq7QTX0Npw4m4L7zJQwk8wDEpVIQhJoUcPF0HBVOrwtsUpTRuZ7u/KhS4FpnXMXrHwLZlZoFTziYiRD3x3BCmi313Ycsi9BQ+1LcSiEDuK+VlrwQHz7pndJ5n0sLYDOfPZ/dCXeWAGIpPHO/QX/6H4Ybziy2UDT+tL3fBnOrpcExcLSAaXK8pSHSrT7pPYh6FmTjGaVLr+CVBNhq7u+9dQm1Rwf8aPfsPHloguuEcqurPU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yABTmNEdywfyjbBpZDC5XR0ySqIFB4KVQ/0nEgHPXj2IaLS/9KIAZrCXmQPg?=
 =?us-ascii?Q?18u0ZFGl3yPZVBTI3nckpswBjX/VuM8xzeq8mC1d6c1ezPY8rnlgmZP9CnBx?=
 =?us-ascii?Q?NR9ruc1JcW00aQCECQ/60l/RcyO0/8ahIffhQSEQGbcVOI2pw1Nqblmpwjwk?=
 =?us-ascii?Q?moOuagXbIh/qOV0O8clKk0m6Y3bxN49iehBMCQCLdJlmabNHqvB1HWrGMAKX?=
 =?us-ascii?Q?3RRwtQp2eAjPPp/g+Cp68GTPg9LtdZC7FY+T6cf0dpVXchEP06a8C6kMabGI?=
 =?us-ascii?Q?yCXol5uH7/HjHQK87jBSNrLTCmyCGJmSvcifGpr9ehRtLWPBh13wA18lsjUV?=
 =?us-ascii?Q?3xz1BHxFTCWHBpBJ/AKf2HOBzBjU9U8olXKsQIRNLkRLCy+X5p//PNvl90yO?=
 =?us-ascii?Q?DF0vHEUcUqdTOjraOK6MFU8+1Q2zMt94cEclcT8aG+e8y9XlVH1TxbwqdgLS?=
 =?us-ascii?Q?HmqyxI07hQoHFotgeandwVyGOBhXpu29WSu7ETvsrb3iTXlyMeWhgLkdCysr?=
 =?us-ascii?Q?9nf9WvC/RHXpl0+AXo4txH4qmouxUjO45bRf36vF2wRfo9W/q0EmC4g8jVyA?=
 =?us-ascii?Q?LWwYyezPQNmJj4inx2bLxyqWrwObmdvRS6cQOmJo2C3A20PIpx4UbV9svMkY?=
 =?us-ascii?Q?m6efZmuRvCiesBc9+i4LweJGei7mxn8azOfhYdk1cHIHIdWsG1tm2n4L4+H4?=
 =?us-ascii?Q?Ig+YmMS4lXQivWkwpGQ5zBV9+61garmxtvGCiSQn+wEZ8ClBTxY7txi9AR/P?=
 =?us-ascii?Q?QRMAWRqx/wjTeQmDziiHyOlXiNrH6xNTgKmSavgB9wynOFvcRhehKJ48NSNG?=
 =?us-ascii?Q?HoKQ9tBJloeKpcP9g6AaQxhrVp/K754RVnxHvr5eyq1SYaR8Z4ijyGkCYwBD?=
 =?us-ascii?Q?n80DqUdAUyTy8eSS4BZKQQ4YEElwfomXX3PMH+P4Jq1RRptsn12Poc+tvxEX?=
 =?us-ascii?Q?oEZc0WVHoWVLeXZZJkfBEa4bsM2HLfXZ8BfS+IcrdgZJqqcBnQpMn+N2JyUj?=
 =?us-ascii?Q?Q4Q+w4tX52NrBkGy0Zf+Z/wl9r3XF/xf8dJXjl7a2TqgX1SON3Ebw1CVd+kz?=
 =?us-ascii?Q?o+xdHR3/8ydXbYvLK/CGGNDQLtIVFUK6tx53YQl4aSKPnKT9ErhXZfN87Ls4?=
 =?us-ascii?Q?pClRacPu9+pO4FmjmBATw0zrQPNfrgsyLe/BhymNHzgsWBEFqk7TUE19z3/2?=
 =?us-ascii?Q?BGOOBFRsK6Fkit9rurN/XCYPlb1/bwgDQH9BKl6r6AlsbyIBFWCPEICv6mNC?=
 =?us-ascii?Q?IwSHsi37Ev8HO578jJIq1mdLdzey3g8hAl4ksi4Bic3oggPoutKipfjU4/ua?=
 =?us-ascii?Q?kQznmUhMG6TmQjrBL520IA4bYZb4dFFoiGV+iGB/wib32CJ9NM4jwa76M02g?=
 =?us-ascii?Q?RvuY0xSVHvA8UaviTFo7XUBEdxWdYQcouJURPygedA1KwmM1xIdaxQnDIMu0?=
 =?us-ascii?Q?krfGgze41qqnz2lue+7APfCZe7JB/OVIRdpxDKbYe/sEIjvhgMJVkByEM+aP?=
 =?us-ascii?Q?U/ULRgtl4aRK304JdgPbnT4+FdHzSO/+KGBzK4CZManKrNZpc/BLOFWO5oaA?=
 =?us-ascii?Q?vKxnyxQjz58t8Mncu/a0y2f2Qbd7O8Q9BBJTWvZJ/9ALtiaqYcDH0mkbzp8x?=
 =?us-ascii?Q?dV1f2Rd7ee+v+B2xw33i8wkLDpNYFKY3kBCgkM/zt1LIIWBf9YyAyfA9SZj7?=
 =?us-ascii?Q?X5nHXZ8pFeB+3NLuzKyTG+44zOuZ1Tp9CXRQ71ATMsTT5Kfn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c1f2c1-49ee-4dde-7028-08de869d14c7
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:23:55.2674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NEO9TIGGUe7oOkbqu9HGxuUmFldwGXACFVdznSCP/nbLROWkyi8qUZV1O0bUV8Fwz04ZT3hugxYtxANplCfpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117

Hi Cheng-Yang,

On Wed, Mar 18, 2026 at 09:11:29AM +0800, Cheng-Yang Chou wrote:
> Hi Andrea,
> 
> On Wed, Mar 18, 2026 at 01:38:42AM +0100, Andrea Righi wrote:
> > In the default built-in idle CPU selection policy, when @prev_cpu is
> > busy and no fully idle core is available, try to place the task on its
> > SMT sibling if that sibling is idle, before searching any other idle CPU
> > in the same LLC.
> > 
> > Migration to the sibling is cheap and keeps the task on the same core,
> > preserving L1 cache and reducing wakeup latency.
> > 
> > On large SMT systems this appears to consistently boost throughput by
> > roughly 2-3% on CPU-bound workloads (running a number of tasks equal to
> > the number of SMT cores).
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext_idle.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> > index c7e4052626979..e0c57355b33b8 100644
> > --- a/kernel/sched/ext_idle.c
> > +++ b/kernel/sched/ext_idle.c
> > @@ -616,6 +616,18 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
> >  		goto out_unlock;
> >  	}
> >  
> > +	/*
> > +	 * Use @prev_cpu's sibling if it's idle.
> > +	 */
> > +	if (sched_smt_active()) {
> > +		for_each_cpu_and(cpu, cpu_smt_mask(prev_cpu), allowed) {
> > +			if (cpu == prev_cpu)
> > +				continue;
> > +			if (scx_idle_test_and_clear_cpu(cpu))
> > +				goto out_unlock;
> > +		}
> > +	}
> > +
> >  	/*
> >  	 * Search for any idle CPU in the same LLC domain.
> >  	 */
> > -- 
> > 2.53.0
> > 
> 
> Overall looks good, just a nit:
> 
> The block comment at the top of scx_select_cpu_dfl() still lists 5
> steps. With this patch a new step should be added and the numbering
> updated accordingly.

Ah yes, good catch, we should update the comment as well. Will send a v2.

Thanks,
-Andrea
