Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826D32DECA3
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297724; cv=fail; b=hl/qPpQxmFqgERvi9HZg4q/vdd/lNJ7bJdaz+O5WJ4Tfu508EQRlTqg/AGIw6uUNw2SQjCehGDZuuU+a7rYOoZ5XjV4HG0hH0EsyALMvzcQGcojsSPKZ6Zh34iQTIYCoRY2jem3ENKuM7Igr4oUoSVsEQfQXc6SAo4kO7cuYK8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297724; c=relaxed/simple;
	bh=PCs8MzSExnOpACsTbxI/b2aXEPi3o+uD+zzcCttW6Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eQfJcpub367h611GU+IeXj/d1T4qOkym6ha1JhoL3BoihpeiH5JgNv6yw2q5tqJaJ9S9xolWpolWZ3rWLRQf1sf9udQKHtwMJpAy2cx+0/RkwPaVBfCZyEceYdEnDtbp4/JN3xD5zXW1ssIeBZocpijPzNswZiRl1iaUkjRfJvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pnPK7IlI; arc=fail smtp.client-ip=52.101.57.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pnPK7IlI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+Y79To3FEe83pPzV37Shq7Ztqzf/sHovxGpP5T7R/B8Kat4xQKgdqeGKlXBOK/BmiB6OubDaqk8PtOEhH65gLjSUEQkPJjR7cgUBJ8P8c78Se6ZHMlC65DR5gH67HP4XPIn0sJLOxxU5Bq1VO3r93WYoXTRZ07dWAJaf+L85DullaZ6RtIiLPxc+bHHKUXCJ/+u0uTvxiSIiwN6g/jKx3GMvKTV6R23SdOYIsr4lMudQJttvlsEMPMmMaUmHOPHXJG5JS7cw4xf+m+0PvaDTA7KGINUcewj2bOD1TElgn/5udc5HwoWo8YoEnqMI41buILnacw0AzO5DJhU3gL3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDDr0P10UDBDz1x/hjOjlLggm0AiTM//jID4xSM1YpA=;
 b=CiuhISIoIvUMYH6j5eYHp4YB1k240jYZ/8bZbo9xNdG5JxQLKpf3GX6aCQ5tuhKTE3QvPdB5+F31IjRInIR2wXHR53psYkUHcaDGe7RDCFKqRcuWknnKAyTwHPgcKGag2Eovpq4X5+RUa3QjH/ZYiGwdlP86AcWD3ipqIRfPkywC7uWwh4Ar8vvFbtZ9g0y4x++K6zLzwK4WxzYFA8DtNc3xN4wl19jhkIMo35CfjzhccstfOgLYxCnnv9xKdJ5bLik31QFGv9JoGh6eIaEESm6IZ0sYLyRmyGakf+wCOmvXhyc9sE4QMkEvjORVZYImREsN+GqbkTLNevqyIrXWcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDDr0P10UDBDz1x/hjOjlLggm0AiTM//jID4xSM1YpA=;
 b=pnPK7IlIw89/iNlQJ8dzIFfadcU+ziiLaC59DA91gxoHyI1A7ZIecjXkpbdN7CVVBu/T2I1NK9xBByaDnSSgB5ghwReotr6IaReeT6KPmXTn+5uYm93zgaepb0vZ6rDyWSVfjGZF7qu/ffn0B3J5gceFp98rjUSJFgIhpn1YEymRuvZ0cIkCoQEj454bHpmeV8AudYoI9iJ82Vw7z9443nKCh0QMvrVLmaDy1SVJzWv2RzpK06vXVFr46p3nUcV4J/LI68urgZoBNTiYWyUl7NGCmLp/E6N3LrBOqyxJLQveZoWaqQFe+1DA1dbjBvNIMWVsMxuDuN2uV/AcUwLy4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 06:42:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 06:42:00 +0000
Date: Thu, 12 Mar 2026 07:41:47 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 1/2] sched_ext: Update demo schedulers and selftests to
 use scx_bpf_task_set_dsq_vtime()
Message-ID: <abJgK3m8Z0ELfGrF@gpd4>
References: <20260312042001.955675-1-yphbchou0911@gmail.com>
 <20260312042001.955675-2-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312042001.955675-2-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb902a1-194d-47a7-e2d5-08de80027657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jk6xdZutyAbYGnYXP1/jFLBCm4o9i/37avIExMDjzBkcdEa3lTqeh9A5+j1IW07zD0Zf/Dfwmh9WSIQSJsmuvjBs+kRIYSL5Ph2VE0vriRbov8c+sOEPy3W1NjhPqZ6tHIRIy9M6+JKAvGFhm0gS+KdcUvYRSTmDkdvvCabJb0tYQp5/IRuf0mg5g2y9zrFmV8UX9ka7uZV4xPq55dddVWaOam2I/3pph49wfJpbh4NXDjsE1ZbocV9IR7xxNnExmEQAeMSt3jqvAV4J2QpTYMKutmH8Z8HlnYuWPMlh6ZSFdQ6JQucRn/jUd/VEbGQ8fKISrSlNkmbjqZDo2mSaT0VLmFsz2thfOuQrO0KL+GtyDkic8Kewv6vBOs8SXAozz/kFn2pZl6KNFDWHDGyNsR2KZFpU8+4JR+fBapX7RaXedygJrFigIaXR17+4NJ5fXLS+ISRMVeg5fn88CHQltuj/6pkutMnlEa1MSO5x5RhTd2pl5WAmEBufMAOLgHjkQzSXwj78yeHnJjI/Z18nSeLXHQb5L94T1pxeSBoaEm52GlNsE4oiVioybKzeWcVyNE/ClC8/4V0TKA3JkeWZ2mS9s/tkfbWd8hgJ8rilkNdlNGymTubnuTQXc9wUfwexOUI8DXTuEmACF7Or9+CoE2NBugcGlRxysVDH7yjDI9nCSmhKUeUPnBjgAMT4ENjmP3KHUs6UgpN6ilEvGhsrwmP1I8wgJuNN6XyFwqaJSqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5OUAX0uGOd5RxSEXbJBQ+oeuklwI9o5f1EWp3r/orvvUDHha+UtjF3F9jDQJ?=
 =?us-ascii?Q?wqR13bNjwxzFsQPOFhWrse9CUDDbH8cCTZscbZy/ou6sTmQGhYlc9jMBvdHH?=
 =?us-ascii?Q?Zy6ExWcp3YNErqULnOMCN9sEKYpahgpoWOo1AapyHI8LpYC8R2OIsWT3iVd7?=
 =?us-ascii?Q?yLMu0VVUW685wjJnhr0QEyj4cSgLHKesFmik1H2mTzemnOkuFnQ09etrWu2U?=
 =?us-ascii?Q?L1RZ6HhlC/ojGG0lCgCfMprZaMeySrYMVusZ93jJjF+hts+Lb0VOgJzbbHr5?=
 =?us-ascii?Q?wP5qt9oXY0oOY3QuIauDV+LCiLPF+4EF+lP5nDryCS1anKOf8+CW3EEEpVmR?=
 =?us-ascii?Q?vIXSPCx3VSF+BEWwewEjfGXP8qJ1N+9eEkMgO73wUzwZpusDQn6PK8/EELBm?=
 =?us-ascii?Q?DMxR60/yTAUkB58JN9WzlVq4wRjErpMV6CrmeVYoYDD3ekaUuv/qtB5TrKpt?=
 =?us-ascii?Q?eB8z7xOyvxipMz0LEVV+irV8NWqOIjcwa9vjqmNsthbxmS5CfajW2sZlv03x?=
 =?us-ascii?Q?z1gBIN3V2rN7sBaEO/hoZqH8PX7sdZhmwn7jT0pOUb0KtwavUOJl1bRWHCHU?=
 =?us-ascii?Q?SY0qOz2Rhfy8EA+1v3/EzNOBKhTclZZ6fkJnyjCVa07IM+8veA6WMp0znSSn?=
 =?us-ascii?Q?klmJGCu2sCZ+kYErFlx+bqbFjYqD/6ycVkt/E1wJFEWn6ZlNx1FMLXgqslla?=
 =?us-ascii?Q?W9tBwrs/8Keag6hrEDmkuHIl8Bo/aWEdANAx+6P1F7Gxp0DyRNgIgLwpkcfy?=
 =?us-ascii?Q?TnjnFPwtdY/AWT8bylPTw4MieWrUdyYqBRvymZl44dv2xE3iGO+d80eSEr3V?=
 =?us-ascii?Q?M0hYxbSowi2P30mMsQBHHKXBZ3s+37oTBNZJUnXQc3ai2i8+b2rpRcXAeFWM?=
 =?us-ascii?Q?paKhu0DM+N0VfeNHrPxJpjDlTFLlSQCehGSXWuEUrmfeNVefK71riXFQeZTC?=
 =?us-ascii?Q?ve9Cm5FWNgvBFYTPVHmVZ6qFuUXhTBecVnZgc0ILcgStU2s3eI7GDiE7TIMG?=
 =?us-ascii?Q?FFHPY81oVulbbDaXmSrsha2vwcNEupRkcLWo28YPktL7hqpMaUYislH6rBSN?=
 =?us-ascii?Q?h8umRMP1tpIPjMnT+yNRpN1T7OqGFZIt495VcSY+fl8RZJN6b0Mvfs8LA/bH?=
 =?us-ascii?Q?bmFCfgxN77FRKzOiPbCP9OrNrerhX3gSm00lo89Xqy9oLK+IBY4Dj8ycPiAE?=
 =?us-ascii?Q?veac/yu8FNhxeaTY5O6D73pQWkRscEZp8QOvWzTs2qby533TnKGM/M5eSRHw?=
 =?us-ascii?Q?v2AEaCmiNJvCS80xoV82dDQHv5cJ7P4tNp658fwdiJkyOGDUacLQRXcxksSU?=
 =?us-ascii?Q?/f9lkqvd7zRqs3TSnKncgbDoqb/jacr3SZDA5CgvQhNgoWl+c4RmzC22D/2q?=
 =?us-ascii?Q?kjpHmAnFQ3etfPIXPoWCAAHeVvUgCJ+3CxcBtuFHFkxyPmuPmzWBSIAJn1VQ?=
 =?us-ascii?Q?SJn4OCxcmmuXneG0tkWfFJ+k0KafEUK19JtGH/8UmOJPhxohWtAXCF7SOmWc?=
 =?us-ascii?Q?2CUeS/3oVUokBCgvHX3bppEHmFDJ4vaYrnCAAA/2EEyZaMitwWwbyGibBfdR?=
 =?us-ascii?Q?GdW15I3PqFg3flc/qoLCqQYXdKi753rZYDvez8wmbFAwffC4AjrJhdT5sVPX?=
 =?us-ascii?Q?ECloAJs0/xG/C4VIVNZ1Ljxm72S57gi9clrwtZjcJuyYYAb5dP3xN0HiT58v?=
 =?us-ascii?Q?OPOjoHTFo2RNyx0CaFzE5qSfRfdLh8Ix5hIbJRPkf+Rqk70JTVURvKYeM0B9?=
 =?us-ascii?Q?HtIKRSQjIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb902a1-194d-47a7-e2d5-08de80027657
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 06:41:59.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfXICPNJwv5w9pGfSDNlfn8ra03nV/4n0Dh1TQroFLv2yhdkMbhlVhxAzEgZGLVTExSLEJqMvLu18XIzXYOhsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146

Hi Cheng-Yang,

On Thu, Mar 12, 2026 at 12:20:00PM +0800, Cheng-Yang Chou wrote:
> Direct writes to p->scx.dsq_vtime are deprecated in favor of
> scx_bpf_task_set_dsq_vtime(). Update scx_simple, scx_flatcg, and
> select_cpu_vtime selftest to use the new kfunc.
> 
> Use bpf_ksym_exists() to fall back to direct assignment on older kernels
> that don't have the new kfunc, preserving backwards compatibility.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  tools/sched_ext/scx_flatcg.bpf.c              | 21 ++++++++++++++-----
>  tools/sched_ext/scx_simple.bpf.c              | 12 +++++++++--
>  .../sched_ext/select_cpu_vtime.bpf.c          | 13 ++++++++++--
>  3 files changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index a8a9234bb41e..27d99bb1e60f 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -551,9 +551,14 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
>  	 * too much, determine the execution time by taking explicit timestamps
>  	 * instead of depending on @p->scx.slice.
>  	 */
> -	if (!fifo_sched)
> -		p->scx.dsq_vtime +=
> -			(SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
> +	u64 delta = (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;

While at it, can we use:

 u64 delta = scale_by_task_weight(p, SCX_SLICE_DFL - p->scx.slice);

> +
> +	if (!fifo_sched) {
> +		if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
> +			scx_bpf_task_set_dsq_vtime___new(p, p->scx.dsq_vtime + delta);
> +		else
> +			p->scx.dsq_vtime += delta;
> +	}

No, let's just use:

 scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);

It's already doing the bpf_ksym_exists() logic internally, see
tools/sched_ext/include/scx/compat.bpf.h.

>  
>  	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
>  	if (!taskc) {
> @@ -822,7 +827,10 @@ s32 BPF_STRUCT_OPS(fcg_init_task, struct task_struct *p,
>  	if (!(cgc = find_cgrp_ctx(args->cgroup)))
>  		return -ENOENT;
>  
> -	p->scx.dsq_vtime = cgc->tvtime_now;
> +	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
> +		scx_bpf_task_set_dsq_vtime___new(p, cgc->tvtime_now);
> +	else
> +		p->scx.dsq_vtime = cgc->tvtime_now;

Ditto.

>  
>  	return 0;
>  }
> @@ -924,7 +932,10 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
>  		return;
>  
>  	delta = time_delta(p->scx.dsq_vtime, from_cgc->tvtime_now);
> -	p->scx.dsq_vtime = to_cgc->tvtime_now + delta;
> +	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
> +		scx_bpf_task_set_dsq_vtime___new(p, to_cgc->tvtime_now + delta);
> +	else
> +		p->scx.dsq_vtime = to_cgc->tvtime_now + delta;

Ditto.

>  }
>  
>  s32 BPF_STRUCT_OPS_SLEEPABLE(fcg_init)
> diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
> index b456bd7cae77..61d3bcf54ce7 100644
> --- a/tools/sched_ext/scx_simple.bpf.c
> +++ b/tools/sched_ext/scx_simple.bpf.c
> @@ -121,12 +121,20 @@ void BPF_STRUCT_OPS(simple_stopping, struct task_struct *p, bool runnable)
>  	 * too much, determine the execution time by taking explicit timestamps
>  	 * instead of depending on @p->scx.slice.
>  	 */
> -	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
> +	u64 delta = (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
> +
> +	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
> +		scx_bpf_task_set_dsq_vtime___new(p, p->scx.dsq_vtime + delta);
> +	else
> +		p->scx.dsq_vtime += delta;

Ditto.

>  }
>  
>  void BPF_STRUCT_OPS(simple_enable, struct task_struct *p)
>  {
> -	p->scx.dsq_vtime = vtime_now;
> +	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
> +		scx_bpf_task_set_dsq_vtime___new(p, vtime_now);
> +	else
> +		p->scx.dsq_vtime = vtime_now;

Ditto.

>  }
>  
>  s32 BPF_STRUCT_OPS_SLEEPABLE(simple_init)
> diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
> index bfcb96cd4954..17ed515c3e25 100644
> --- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
> +++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
> @@ -66,12 +66,21 @@ void BPF_STRUCT_OPS(select_cpu_vtime_running, struct task_struct *p)
>  void BPF_STRUCT_OPS(select_cpu_vtime_stopping, struct task_struct *p,
>  		    bool runnable)
>  {
> -	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
> +	u64 delta = (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;

Ditto (scale_by_task_weight).

> +
> +	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
> +		scx_bpf_task_set_dsq_vtime___new(p, p->scx.dsq_vtime + delta);
> +	else
> +		p->scx.dsq_vtime += delta;
> +

Ditto.

>  }
>  
>  void BPF_STRUCT_OPS(select_cpu_vtime_enable, struct task_struct *p)
>  {
> -	p->scx.dsq_vtime = vtime_now;
> +	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
> +		scx_bpf_task_set_dsq_vtime___new(p, vtime_now);
> +	else
> +		p->scx.dsq_vtime = vtime_now;

Ditto.

>  }
>  
>  s32 BPF_STRUCT_OPS_SLEEPABLE(select_cpu_vtime_init)
> -- 
> 2.48.1
> 

Thanks,
-Andrea
