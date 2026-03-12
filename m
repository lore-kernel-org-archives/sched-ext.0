Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C01039768A
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349081; cv=fail; b=Ive4Ib1VE2j2CVr8W/mdmxvdJnTb1TxhzMrdiUMz1aWtybmneha3A32EabAXLkkVkdTzUfHy9BKs2vDd78pPspuWbB4SisjdIgXFxpP3+DYIDkm5VZoCfn53AvcxhGdnySN+dS1FAwZi1qCGZeWQCWLLDdWZhW2Zh/y1OhfOV5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349081; c=relaxed/simple;
	bh=ALFAQjvvXfLjuW6uIn2dKPUYWkBPpnjza1aLm0wmZM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lvcsl0cZUVSQ9c+YK8c+BcWWtENv5a1shObe3G6pQO7NOe90cp/ubQ0sVwSJUb2VuCGh6955TRVUHEC4TiJ1FvlBPrUYPZy1Im3mqWCEMwi1ngfeOjY5ntXbkWhbUoUBglUsjZDAHU03sKPWDXg5KwH1ArcMtwgrw/UlmHXPg9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=azbDdfk4; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="azbDdfk4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmKLiNZK+zBnfjeZTG2z5WE8Vlg0+//JOIrv7ppLUtN8PfnB9hzcjRpLzWzwkSml64W+98UmT4BTcO5Df4fS5gQ42jkmp9RRzeB4zm+9ufhazK6zIM1QdCgwwYymdkmRnc2lX1in8orbhGTVrMRl66WxlrOOKt79htIzQHHOhR5wV2J5r7+B+o/jsl0uEXceQZ15PQXmKw4ihyyn7lRrC3tQqB5h6TVUAixmodLF8IVo3M15KM8N2+ak5YmktES2nGljfouGKeXFd+d4lsBbJbK/CPjAPMipBT02ftAJEd1KBSXlMsB7IH0l5EmRCZgEdhlNT3o47qp/VxhKWpJOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RvgD6YKhjNWCKVi98aUZDmcpR5BH+xdBtDisUIJxqc=;
 b=d+FYJZn0u/l6Ok0SiPlUvj1uHRHoDcPQVUuDSeCUB6i2WlBgV2hblh2sBEh//0Pmof5rZ2UDGDJAfK1Bozz08FJC7ry+GzDVJyhgo8XaSU6sXTSKeuWB0qmGV56l9ZlLm3ZKiQ3St5Y9CqJfXbC36lOFVsSlsz7DUMtS7CYzCJZPU3ZLbqUKrQCTpOCxgNuTEoul7KSgG5GG9/cGM5T0Zo6lmlFOUivftMy8DYw2N5lYGFIl8Zd0WgGo2wdjGCkukz4RDE8RU2UEwSuJ8q+Lr7CK4lpLjQHa7yg4+Q75GBohIvGN7f4XxrLq/tFsIiYpoDykX6hyKPobanOJ4Isbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RvgD6YKhjNWCKVi98aUZDmcpR5BH+xdBtDisUIJxqc=;
 b=azbDdfk4YvYxy6bTyPHuDSVWSD+QKwcRgvAE/RGqYzO77DJaqcAEfG/rThFsBl+AU86VCU6IcXy2fosam0YNwczAZfgxXlglyftRiv+zjJ+SP+avrmd9EtcMmp3HU+czyZJ1u8Nu9eCTtlRy30OfhM2YunxuXbd7iTHuu9ZPkH0DoacoLuYUbCMkc5suIRO4OnGAnRlP5/Je9mtGSTAM36XVPkxtCgn4EBlUsa6cAmJygnFlwsyrthy0gyJ8UR2ONOOFpaYf2788eLjgUC/VTI1XFtz7fk55zrneRuoseXq6YLJPLPoAGUcLyssJIpn4daAEUA0JPWEiiXZBxsHwjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 20:57:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 20:57:54 +0000
Date: Thu, 12 Mar 2026 21:57:45 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 1/2] sched_ext: Update demo schedulers and selftests
 to use scx_bpf_task_set_dsq_vtime()
Message-ID: <abMoyauzdQlqUxz3@gpd4>
References: <20260312175527.1220540-1-yphbchou0911@gmail.com>
 <20260312175527.1220540-2-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312175527.1220540-2-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 738a28c4-b4e1-4dad-f55e-08de807a0836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/yNII5j2oR5BtpTL8sa2d4wrzrzYKJse6ewa/aXR3BXr00+TnSspRr9/RjZMzM2x3VbSRHKRfA3eJA8Hh+wj39jHd6IXBYO1F88EEngIpDJjUz+gMBc5YBL1tZH9q7fK3n0bMTbxHuQyHYuqh1jILDhW12bei7y6nx8wNozD7lxRYu8BppJRR03iXfer2qc5qIM2KbowcJc2gzvherPdLJz0i8IrZixLEMORHrmY13kk2KMmGu6gYO8hYBsrl50EacJZxfpEyv8YzWtoNs9F7qmAdsiOM35SF9Coxh0KIF6IUSstMm8RovoHeB75FKGjxYkF7cE2rpnn6HEpRV0W5wrxmAhj4PdGyFshJyDQKEQaxe+/JqyaNKPh4tSpq/0T0bAFW1p/y1H+yXULKPc9D1TpGZE2hl4+h5pl+HnJAjpfmOJZ9Z2wpRX91oXIbzpwMi1pFUdeUajsH/I2s8sw0yI+KdX6T8VTWQrE/DrFF26psedsZWyKFgJ7ToZNSThk+JBMsgPEFzK3lusB5uBsbzg/7qpQ6fzGVO934ZDwaGlA0bnAoNrV3YQrBfvnHdbEF30k17ZRQgdsFUJsA1CTNyCtoh/wC5BPMKoVLWb+vliS4rY44LnnJ5FeSeZvwjIkBcKVlbTGGglH0SC0ZFeJUxAJNwRM3dqPe2CWNQEz5kFG++Pw6pPR8WGEELu00YPpi0LntHbs3QQ0YHADyjiP4LZZ20S3VYF9NdMYX0IxGpI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7/hAjK6AeWUm9O9Ymr+sMYrHEn3/FY+JW9wCkhThZw51h6Bd4GYspkt7yERz?=
 =?us-ascii?Q?inH323u+OSA3DCuuzpA+MMX2iO3n+KjQEE5ZhGPzt+PGKsfX8Q/O8uue0BB9?=
 =?us-ascii?Q?lxMO4Cb9fxICpymzMgo0d6lRY1NfFNLVJ+ogONyl4YRoDKJOEmd+GkT+pY3U?=
 =?us-ascii?Q?NOCAIKTtcwjjNBwBAKMM+BGhquNn7moTqzXL87Srv/e4qzhO40Fm6PU7pqaT?=
 =?us-ascii?Q?Ka+3NT8d4GBBawuVBRR1aOgBL7PhH0u5GTn1qx5yForIQhtqjUsxoP/PAtFn?=
 =?us-ascii?Q?AEvrdiVSKzwp7Xfp0fawxYhhm9s9fPSCXKPI9aU0W092S3nQur0SElphYRQh?=
 =?us-ascii?Q?IetyMOcfJg5hejhbtYTjXJJL59cRNH1QBvB3fcOaJGFmtdGfeCCTDUuvWMq0?=
 =?us-ascii?Q?cPuuaa2oA7aPHJu3J4D7Pt367Hl0y5rnEpHbLzZnXp7OfMVThe9IBAZuHMIL?=
 =?us-ascii?Q?QGGMaiqSEygU6pmUtXiZImdWxkHlzKq9TmL/ixXenCMP22hxf23LLk/4wH2d?=
 =?us-ascii?Q?qI1oFLxjJkpR9iRNKvBVTrZeMNwSAIuyozYSRIQ7fpmf99NLiN5B+r90/8q0?=
 =?us-ascii?Q?v38bSIMFNlau1FbvJQY+VlwSRgSRmjEP0lkzuPVut1I1Av/pTJV6Wsh36T/D?=
 =?us-ascii?Q?MAxuce0IbQrhlmajP5ZzTq9IXxf6tfnMDRAbRJ72ST5n6/Gg6EWrECYYqulz?=
 =?us-ascii?Q?KKEyrIu4bKcrmlrs1B/UReceFBzdNVSEMaggowCimCEB9xIYpmz0cUx7vy7/?=
 =?us-ascii?Q?KwfFX5pSQRGfschFYMiFtNiVPB8d6m1pL2R4FpISxWJTrOBHVtNM6zGxPrbH?=
 =?us-ascii?Q?Junpvdq+cjhdS6Gu2zAqRGW0rxrFFsRKmpXSgTdnFtwlRR6VjVKzfR0M/xVq?=
 =?us-ascii?Q?3NYuiVaWe4PfkuGMscs/SjqaeyMw7YPErbM1yVGNIuwsKohJ4Gwop8/5fPgD?=
 =?us-ascii?Q?Xn7RRJfnGEzRv/oxeGbzU6JCLoqTHL5l6apHN9MtclogGBZhv8ecGu2QrjqV?=
 =?us-ascii?Q?cSE/8twbpqrCHjwMU3feRF3QKaxMv5wJmpeqN/KC2v1EhS6G6its0cGm3qG8?=
 =?us-ascii?Q?uAKxkp2D4BVvghdMmkAdgB9aVVgEni2B0yyXsXwQ9pFS9CO769xCx6B2mDhI?=
 =?us-ascii?Q?ysmky8vSoL7quaYigeA3eF0vb9oTkg1JJ0rz/riUvPeMbchWPrVj5z9wQzbC?=
 =?us-ascii?Q?WsBrO/E5/OhtWXBaRCj8UQSHhDZuDNIMtwfAMliRCn0yYZ9Ijjk+U4yXJlrA?=
 =?us-ascii?Q?cKuXuYkm8pwG4RyQkfrJgfwTj/WqBZp0d/pGlFv6NNl5sDB9Rwlr10RcpEUl?=
 =?us-ascii?Q?ugZvcgUA41vJSt1WFOOHyaR+NkmukAqmNYT4k+ymvZWxoz+wvPHGnZxj99pU?=
 =?us-ascii?Q?LkenRCKog9BG6KIfNNTdprAFDCXUEYESVmR8DbjA/L73YLPl/5TCq/uzuufF?=
 =?us-ascii?Q?BbcKvs9zJDeVKvAsjKk3sE6gctVw0WjAAAMXtkTaxoNYP7pSJ6G3ckw3cSH2?=
 =?us-ascii?Q?XPSh7L2w5I2J+p1gyRKoYt0NDgCcwEf7MnTlvKJZ2uLz/+a6pAkfR6amQRgO?=
 =?us-ascii?Q?UAOVIwsih8g/bIlJ7GBhhFANAYUSTo4kg2wpc5T67laoCWwhJpsHnyweHINb?=
 =?us-ascii?Q?/Hqcgv8NyMBVZtsd6hwLkUecU/jFrczhFB06ijJgQ4BN8Szl4+ISYYzZReXf?=
 =?us-ascii?Q?G0k0DlmoVlzRCMd8AAyoerZcV+L0nS7hOd1r+vm7GKMUFsyZ/wUq7YhHJTK+?=
 =?us-ascii?Q?Yc/uXd+c7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738a28c4-b4e1-4dad-f55e-08de807a0836
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:57:54.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pm/cCRfEhI2wRu8fBWEYWLMXDcDcHH6nz0BEfXPsfKdxBXER2NdDKQDICcKkqBwkZYX5onudRVFbXt+7vin1Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911

Hi Cheng-Yang,

On Fri, Mar 13, 2026 at 01:55:26AM +0800, Cheng-Yang Chou wrote:
> Direct writes to p->scx.dsq_vtime are deprecated in favor of
> scx_bpf_task_set_dsq_vtime(). Update scx_simple, scx_flatcg, and
> select_cpu_vtime selftest to use the new kfunc with scale_by_task_weight.

Sorry, that's my mistake, we should use scale_by_task_weight_inverse(), not
scale_by_task_weight() as I suggested in my previous email.

> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  tools/sched_ext/scx_flatcg.bpf.c                         | 9 +++++----
>  tools/sched_ext/scx_simple.bpf.c                         | 6 ++++--
>  tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c | 7 +++++--
>  3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index a8a9234bb41e..5cb92b4f1635 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -551,9 +551,10 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
>  	 * too much, determine the execution time by taking explicit timestamps
>  	 * instead of depending on @p->scx.slice.
>  	 */
> +	u64 delta = scale_by_task_weight(p, SCX_SLICE_DFL - p->scx.slice);

Here.

> +
>  	if (!fifo_sched)
> -		p->scx.dsq_vtime +=
> -			(SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
> +		scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);
>  
>  	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
>  	if (!taskc) {
> @@ -822,7 +823,7 @@ s32 BPF_STRUCT_OPS(fcg_init_task, struct task_struct *p,
>  	if (!(cgc = find_cgrp_ctx(args->cgroup)))
>  		return -ENOENT;
>  
> -	p->scx.dsq_vtime = cgc->tvtime_now;
> +	scx_bpf_task_set_dsq_vtime(p, cgc->tvtime_now);
>  
>  	return 0;
>  }
> @@ -924,7 +925,7 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
>  		return;
>  
>  	delta = time_delta(p->scx.dsq_vtime, from_cgc->tvtime_now);
> -	p->scx.dsq_vtime = to_cgc->tvtime_now + delta;
> +	scx_bpf_task_set_dsq_vtime(p, to_cgc->tvtime_now + delta);
>  }
>  
>  s32 BPF_STRUCT_OPS_SLEEPABLE(fcg_init)
> diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
> index b456bd7cae77..a61a7df81e49 100644
> --- a/tools/sched_ext/scx_simple.bpf.c
> +++ b/tools/sched_ext/scx_simple.bpf.c
> @@ -121,12 +121,14 @@ void BPF_STRUCT_OPS(simple_stopping, struct task_struct *p, bool runnable)
>  	 * too much, determine the execution time by taking explicit timestamps
>  	 * instead of depending on @p->scx.slice.
>  	 */
> -	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
> +	u64 delta = scale_by_task_weight(p, SCX_SLICE_DFL - p->scx.slice);

Here.

> +
> +	scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);
>  }
>  
>  void BPF_STRUCT_OPS(simple_enable, struct task_struct *p)
>  {
> -	p->scx.dsq_vtime = vtime_now;
> +	scx_bpf_task_set_dsq_vtime(p, vtime_now);
>  }
>  
>  s32 BPF_STRUCT_OPS_SLEEPABLE(simple_init)
> diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
> index bfcb96cd4954..63e03fe5d983 100644
> --- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
> +++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
> @@ -66,12 +66,15 @@ void BPF_STRUCT_OPS(select_cpu_vtime_running, struct task_struct *p)
>  void BPF_STRUCT_OPS(select_cpu_vtime_stopping, struct task_struct *p,
>  		    bool runnable)
>  {
> -	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
> +	u64 delta = scale_by_task_weight(p, SCX_SLICE_DFL - p->scx.slice);

And here.

> +
> +	scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);
> +
>  }
>  
>  void BPF_STRUCT_OPS(select_cpu_vtime_enable, struct task_struct *p)
>  {
> -	p->scx.dsq_vtime = vtime_now;
> +	scx_bpf_task_set_dsq_vtime(p, vtime_now);
>  }
>  
>  s32 BPF_STRUCT_OPS_SLEEPABLE(select_cpu_vtime_init)
> -- 
> 2.48.1
> 

With s/scale_by_task_weight/scale_by_task_weight_inverse/

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
