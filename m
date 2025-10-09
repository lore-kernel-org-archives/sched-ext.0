Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F442AD16
	for <sched-ext@lists.linux.dev>; Thu,  9 Oct 2025 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759992221; cv=fail; b=NTfmt32kqZpIaWJNR6xKNBOPxvf50cy1EsdDzdLvRl515UUZTJguQVb+sgws+C37IvJyKcXKrKAz+f0UX1PzOeqDlH1d+F0VoKX8+dOPCs0n1A7A7iSeYQJz/GrikP2CLdaud21hHTswQvGJsFtYkJ5SQk9KmGNJeX77v6qXK8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759992221; c=relaxed/simple;
	bh=de80JanFNv2GKzeKTGEVp/VwKqslJ6+sRtueDLyO+yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FrDhYNtYmlKhT+gDQJ0RraV1zBQ76wu08wg4slm7NoO0sN4Z3Aoz2XkFjL6Ka3ElcsaVxwKYe9BjbrnHUVJ3frn7nwmKJ5kE9stwALBr4nHJ7XPWkMbIjY14IyBKDt0oRug3fdVSxvy0bNHRVY42/sslsgnFyAZaznloqpdu3js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z3LyGm6B; arc=fail smtp.client-ip=52.101.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z3LyGm6B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsE5PqSpTUgNf5YqecGXtcPpUy48U6vLIzhwfG8+2MColDvBreYJPVEqblamahNKKYijT+oazHHqUgqwusXMo/xcnF9tJ9PqcjTK528s8Uy2jK6MnnUaK36rCqJGuOVuPHL7bFsOGZoiZ1/HCS9oi+E0LRKavjn3b5Fz4pxWSfr1GGX4/NdBFbFvxMqu7QymwDlPJ6mhgAibh24Nd+mTWNpvstdTQY13XcuwwGMwCNBDcQkoW9R+xSjU7BxijfvUV5c7iw24+JVzedBH8vxV7B5GZI2pPjLNYccqgvj6N4n+djQ6uAqWONZeHxlF16EohDQaGYknJL+PUp8PPOcWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c7CYDBx+kb2Ju0cjGWyRev9IAL/2/RprI+sgCMgX4I=;
 b=k6oEMRSGEAbcTnalr7abZgu25oDQax/o1OdNVNhvuo0Nj6Vjrhj4fYfkuIOg7zVpkosu+iDWFE9m1kpMuKg/GEA+HIjUmWY3HCx1yNmURCX+8DUqb+ehBNTAwHymYAS29EpkdDhb6axRVdhCwYVRCAFjSNoQvUTtEqtq+gS0p7VhryQTdJGWBTalBtyTHOiD1Q5xT8cDK6+YVghXGDyWu+FinmLMnyIs2k0TDzrx+cPeF1XSqc+wCnOzEJPbn2FsVjQ1QT+5JvB7nmgGgaEd0dLliBskRnA3SG8H9hQ4F/CYm/zYOTl/SE5r8xAjAh1cNgfTsQ3WzpEkom0SvQceqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c7CYDBx+kb2Ju0cjGWyRev9IAL/2/RprI+sgCMgX4I=;
 b=Z3LyGm6BQRGTn/pEu/1Dj+ZspLuCu2gr/2demykp3jQc/NVfCOjBSmWm4ZfRlVKaOBa7YYkZiaDEboq2lEQwqoAN+fL6MsuMfP946G4TtLISpQDket7XBx71t9QYLsoja1Otmc522CQEnuE2IvTlrOawn3ffSxQ/sFvMVPHcNiVI+554yzz9YDzz4mnSni0ijleOTg2MPMv20OCfgSOfvsGpzwLJB8jQxnDIh2J3hFunmsAg+jm7MRIj+OVPGDAKJCGpSAfjXRbT1Di+dlyS+BzTA94P1hafryW3wNWtb/hUrDNnPZcvV1LrZCwSLFkdsUys+8b3r3vXEWUiGOP7LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 06:43:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 06:43:37 +0000
Date: Thu, 9 Oct 2025 08:43:27 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Phil Auld <pauld@redhat.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Subject: Re: [PATCH v3] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily
 using kvzalloc()
Message-ID: <aOdZj3ERqEeNJ3OP@gpd4>
References: <20251007133523.GA93086@pauld.westford.csb>
 <d1c0eda5206b01fd670e148bd5ea0d56@kernel.org>
 <aOYAV2ZQvMt5aZxu@gpd4>
 <aObPQF1-o-Uek7bd@slm.duckdns.org>
 <aObcIMFpUoMy7vJI@slm.duckdns.org>
 <aObkkKf_UCHySRGz@gpd4>
 <aOb1e7R1lAGVGH-2@slm.duckdns.org>
 <aOb3Hv0uPv9G7N33@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOb3Hv0uPv9G7N33@slm.duckdns.org>
X-ClientProxiedBy: MR2P264CA0027.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::15)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 06712e5d-c24e-4fcd-0225-08de06ff2ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SqSZLhrOqCjcpJ7SK4t7oQ4PyzmhK7wn7N9aSRcb10IlPi7WsLJ8Z76tpo9t?=
 =?us-ascii?Q?if8aIg7XXclLTzQXz3rZhKKr0/lAhnXe88jofQuXBqvz1Y3WSv9eQBrX4cps?=
 =?us-ascii?Q?6o8qi5dPbkQWtRPbAhze5D95qZJqKXNlQx2rUx0JYNJFTlltC9vFpfyC9JD3?=
 =?us-ascii?Q?q+tCY59/GYzYed/lygOMpbrAh1/QEW0XRiR/QZvZMzdaA+9cU1GUWcdq3v1X?=
 =?us-ascii?Q?cysRv52UCPXi0zkiGohBERKCa0PZ0wcjAUIu0bMRjs3XB3atn/QraSCLlBqe?=
 =?us-ascii?Q?osy+5Drx/3dSDCFVm1HRR18dmKPTFDjDfSwkJ7NqAfBZr3kdJByFmDE/YWju?=
 =?us-ascii?Q?N9hrYMV4tMtRYHTKu6ICKy5yLozFoXP6a3+HMo5BxbUlxSxoTEkO297SFVV2?=
 =?us-ascii?Q?CVV7f12Z3pLkGvi1f1gN5SxsuZAbrK6h1UzCM9eHJQxC0hpG2F+ZGFWmEeDd?=
 =?us-ascii?Q?jo7iNR3f5iEgPLlBoT2DJE5rtRsVjcGscihoZntNh4uYDJPSKCTEMRaClqDp?=
 =?us-ascii?Q?Z4rXGiLof8Jq191BGy9yd0t7Ip53wza52GuZaCX9FfIrg6ao5GU53vSY6vsE?=
 =?us-ascii?Q?IccR9bMEH0BxNVzJ9P1xg5tZtq3afXlAprEy2dcrpv8h3AcJMr+uCyAhCchB?=
 =?us-ascii?Q?2p4K0Rdpv4MuAM58ji/WW2QEnOVThzA8sg8lWHvQL0sfxon+kWfl0rwcjGDL?=
 =?us-ascii?Q?DUtr5URP+Dj8EPLQwo1JoibwV5++5BZULWh/taYXj9wxEMQheh7+el2ajCjN?=
 =?us-ascii?Q?0QNxqB2jWvW0adgd4XgNf9lY1Ue9d1fgRt5A+mOEO9Z76jGMwRwSdIhj/48B?=
 =?us-ascii?Q?xOouyS7NI1cPJWfDPcm0b0tyaH2ONp9zNG3vk5nQFC1HxLVx1xTzdZF7m0kz?=
 =?us-ascii?Q?P/m1JhmZQ/91fZjpeeCYAbODMmInkFh8Kbty3aHr3LB1M3EDjs5sfuLlkGd/?=
 =?us-ascii?Q?/Q4uHRGcg1VEoE8ujiTXefUZi+DESLNhFo+d1YpLVNkGnT6jXz25Ei2hTXa3?=
 =?us-ascii?Q?H0jcTS+y5yCZ+IXaxLu36eKnDpqcoq5oDZFT/he6xrRUVcy21kiaaMO0VptM?=
 =?us-ascii?Q?U37NUUy8HgZqUaNLKOiFuiofBUMmHREuNOzjkm9VsTVPLJz4KGdIOgmL/BNM?=
 =?us-ascii?Q?n/JT0hqi8kLikfB/GTF1/MYmc0qAza8BORCRYu6Bt8jL/T3DzFWnvjIbiSGU?=
 =?us-ascii?Q?tM4EVW4B4OoUymfLkypo0K3A4vXGz4KtMNJuodJzut93UV978NefdKa9KYuD?=
 =?us-ascii?Q?qEwKBKv2lYQT7j6WYHmK7OIVDqhJDs4BXHwu0d59U0Ud8UzLoOdALwMJdqb3?=
 =?us-ascii?Q?VdfEuX4gN9DAAoKlKgbzVd2DCGkRGbM7ShfwAYRwbFfyTG2XEPMrY8ITw89C?=
 =?us-ascii?Q?lSx7Zz9vlcZDenVY/OvMxWtyP39Xjg+zRLR1S0KG6xrKoQUGgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DqG7PvPd2C7Y00qXsqyYx9eO3cIzOkrfTsa91t2pGH9pIXtqOxWYmluTnsPq?=
 =?us-ascii?Q?NklBSg13T2OweZt3hBUt05qNpjaXHjeAqdVsOy3oP6T/VECRMPpufYEmGVgb?=
 =?us-ascii?Q?CsspbdCbYm3vW5qex8JEwbdbFg142mRZcBfJfh17/U3qq8Q4Jnz9G/nkIBmI?=
 =?us-ascii?Q?XCRHr0144pTQwbFdPRTIkE0iYviUo8N7lvvPaJC6p3jLNhVip3Vw3PDAXCmt?=
 =?us-ascii?Q?m01aiCRfZamQutXfigBJLg9mwUao8fUBJsECweEbIYjf+FjRciLALBAPQhK6?=
 =?us-ascii?Q?yvCfHZuzO/vyQqOitf/qcTwnGKKgfNIG5JLuECo7AcykDVuE0DnyjjaABbhM?=
 =?us-ascii?Q?qsp36oalglrxA0bpQvEh0K7dhdYfG6Uy2nYa+RdPTjTU7IWQNzxi4RJ3P1Yb?=
 =?us-ascii?Q?oIm8Tj2LGZIv6EoxrdlKDDzOxkpRRx4Hdl+bDsoYECT35OKVteYIydpUQV1I?=
 =?us-ascii?Q?xvKrYrDbY8RJfCEi7u48Dm632hPw50/xNPDj4appBO3820uVmeHXTfk8iilN?=
 =?us-ascii?Q?wmhpIFEzTjXdiFvxrux0gF8C7iGoTttbAbELhbJo+sW0KAIje/4fhdkhvWlv?=
 =?us-ascii?Q?T2M/LUtmatq+iKWmpOaY1vXWPiQbe4LEeXhIxqWzAJxvQmExzmalK30/q7Hs?=
 =?us-ascii?Q?Wp7qUNLw70TchvaDHmK0ZjWdVbmmJXp4v5LQTyJNEqk43D0vNHcesWksChLd?=
 =?us-ascii?Q?RBuwet8WDvKIpUB4QHNA0fA3x5FIFckyI6wGVhvz6CMDHQeVhNSSiVr2nYLz?=
 =?us-ascii?Q?OHfm8bLq/2wOliGY0i7f8lHs39kdj4P0qYxG5smvc1XQgxpz13JOY3HemhNJ?=
 =?us-ascii?Q?0yUSYMHMqwAE3LVCtXOAhSGlbANBS5RfG5VTnrDWu8dN995hGivsaDIwUCAD?=
 =?us-ascii?Q?3x3a4falmCO9NcXu7ANcRfB9pl4JmrRs717SnvWnwxH3XQQxwuV2mgUboTvt?=
 =?us-ascii?Q?KXmZFaQl4LjVAiNFaiQt474AEppaoMbRx0qQDzmUd7/kDuWEUDhssUuzMzZJ?=
 =?us-ascii?Q?1Ij+c5usVB95TYYJHWr3YKgLPBAEHlp0attBBOqKh5cp6lF3jfPevTqGeX2A?=
 =?us-ascii?Q?6zYajtMaWaQYYxG15qx1ERhiyxHDiTXu34S20qUOWBhrzNsxQ+S8qQ13RGax?=
 =?us-ascii?Q?tWKYPcWLFIyuADVCrcYlm8Oflq1YsT3SOgHFlCV+SWH7LkbJRnANSpuYmIhM?=
 =?us-ascii?Q?Aml6luflfa9mNkoYNV2Gk5YgDcxoQGHkOy0OvD9KRUe51/d2SlfN6Zf1EzXc?=
 =?us-ascii?Q?D9kdFmJ6y7tBh8YkptNVeMdl8cCoaFClZWhlrWfyQ9T6lmk6BAvfpAnndNi2?=
 =?us-ascii?Q?mWSuWbVDOcUPFBp7yGSq0QhQ1Ltzs32J4RuvmZYNngz+rs0eeN7WpC+oknmz?=
 =?us-ascii?Q?KmZsYulOomv5J58u4bYA370bLAyu8CsRBId+egfsRBIznDXYLTpoTc4T8Pon?=
 =?us-ascii?Q?W5doVqCXs4sidav8bwfCi2LE3zVq43MT8tb5UNFn6kYTaMRktoamBiEQYwjF?=
 =?us-ascii?Q?rEzQmepB9jAz7d3G1+hMP1LR+3oRnMcxm2n/VpQycofacMWi0mRt4nCmNL1T?=
 =?us-ascii?Q?1bIjvFXgZy7rEGp0Pz5jTiqpBOetd6INARNTDT4b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06712e5d-c24e-4fcd-0225-08de06ff2ca4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 06:43:36.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwFQYCOmTTDx4OJzSEJjvvbc0Ry7x11UpPhvya0+LizaYhcdn1sLn3owAd01BdZXsXEGnyhUMiGASCgXk9VOEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675

Hi Tejun,

On Wed, Oct 08, 2025 at 01:43:26PM -1000, Tejun Heo wrote:
> On systems with >4096 CPUs, scx_kick_cpus_pnt_seqs allocation fails during
> boot because it exceeds the 32,768 byte percpu allocator limit.
> 
> Restructure to use DEFINE_PER_CPU() for the per-CPU pointers, with each CPU
> pointing to its own kvzalloc'd array. Move allocation from boot time to
> scx_enable() and free in scx_disable(), so the O(nr_cpu_ids^2) memory is only
> consumed when sched_ext is active.
> 
> Use RCU to guard against racing with free. Arrays are freed via call_rcu()
> and kick_cpus_irq_workfn() uses rcu_dereference_bh() with a NULL check.
> 
> While at it, rename to scx_kick_pseqs for brevity and update comments to
> clarify these are pick_task sequence numbers.
> 
> v2: RCU protect scx_kick_seqs to manage kick_cpus_irq_workfn() racing
>     against disable as per Andrea.
> 
> v3: Fix bugs notcied by Andrea.
> 
> Reported-by: Phil Auld <pauld@redhat.com>
> Link: http://lkml.kernel.org/r/20251007133523.GA93086@pauld.westford.csb
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Andrea Righi <arighi@nvidia.com>

Looks good now!

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 89 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 79 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..01010c3378b0 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -67,8 +67,19 @@ static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
>  
>  static struct delayed_work scx_watchdog_work;
>  
> -/* for %SCX_KICK_WAIT */
> -static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
> +/*
> + * For %SCX_KICK_WAIT: Each CPU has a pointer to an array of pick_task sequence
> + * numbers. The arrays are allocated with kvzalloc() as size can exceed percpu
> + * allocator limits on large machines. O(nr_cpu_ids^2) allocation, allocated
> + * lazily when enabling and freed when disabling to avoid waste when sched_ext
> + * isn't active.
> + */
> +struct scx_kick_pseqs {
> +	struct rcu_head		rcu;
> +	unsigned long		seqs[];
> +};
> +
> +static DEFINE_PER_CPU(struct scx_kick_pseqs __rcu *, scx_kick_pseqs);
>  
>  /*
>   * Direct dispatch marker.
> @@ -3850,6 +3861,27 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
>  	}
>  }
>  
> +static void free_kick_pseqs_rcu(struct rcu_head *rcu)
> +{
> +	struct scx_kick_pseqs *pseqs = container_of(rcu, struct scx_kick_pseqs, rcu);
> +
> +	kvfree(pseqs);
> +}
> +
> +static void free_kick_pseqs(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
> +		struct scx_kick_pseqs *to_free;
> +
> +		to_free = rcu_replace_pointer(*pseqs, NULL, true);
> +		if (to_free)
> +			call_rcu(&to_free->rcu, free_kick_pseqs_rcu);
> +	}
> +}
> +
>  static void scx_disable_workfn(struct kthread_work *work)
>  {
>  	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
> @@ -3986,6 +4018,7 @@ static void scx_disable_workfn(struct kthread_work *work)
>  	free_percpu(scx_dsp_ctx);
>  	scx_dsp_ctx = NULL;
>  	scx_dsp_max_batch = 0;
> +	free_kick_pseqs();
>  
>  	mutex_unlock(&scx_enable_mutex);
>  
> @@ -4348,6 +4381,33 @@ static void scx_vexit(struct scx_sched *sch,
>  	irq_work_queue(&sch->error_irq_work);
>  }
>  
> +static int alloc_kick_pseqs(void)
> +{
> +	int cpu;
> +
> +	/*
> +	 * Allocate per-CPU arrays sized by nr_cpu_ids. Use kvzalloc as size
> +	 * can exceed percpu allocator limits on large machines.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct scx_kick_pseqs **pseqs = per_cpu_ptr(&scx_kick_pseqs, cpu);
> +		struct scx_kick_pseqs *new_pseqs;
> +
> +		WARN_ON_ONCE(rcu_access_pointer(*pseqs));
> +
> +		new_pseqs = kvzalloc_node(struct_size(new_pseqs, seqs, nr_cpu_ids),
> +					  GFP_KERNEL, cpu_to_node(cpu));
> +		if (!new_pseqs) {
> +			free_kick_pseqs();
> +			return -ENOMEM;
> +		}
> +
> +		rcu_assign_pointer(*pseqs, new_pseqs);
> +	}
> +
> +	return 0;
> +}
> +
>  static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
>  {
>  	struct scx_sched *sch;
> @@ -4490,15 +4550,19 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  	mutex_lock(&scx_enable_mutex);
>  
> +	ret = alloc_kick_pseqs();
> +	if (ret)
> +		goto err_unlock;
> +
>  	if (scx_enable_state() != SCX_DISABLED) {
>  		ret = -EBUSY;
> -		goto err_unlock;
> +		goto err_free_pseqs;
>  	}
>  
>  	sch = scx_alloc_and_add_sched(ops);
>  	if (IS_ERR(sch)) {
>  		ret = PTR_ERR(sch);
> -		goto err_unlock;
> +		goto err_free_pseqs;
>  	}
>  
>  	/*
> @@ -4701,6 +4765,8 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  	return 0;
>  
> +err_free_pseqs:
> +	free_kick_pseqs();
>  err_unlock:
>  	mutex_unlock(&scx_enable_mutex);
>  	return ret;
> @@ -5082,10 +5148,18 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>  {
>  	struct rq *this_rq = this_rq();
>  	struct scx_rq *this_scx = &this_rq->scx;
> -	unsigned long *pseqs = this_cpu_ptr(scx_kick_cpus_pnt_seqs);
> +	struct scx_kick_pseqs __rcu *pseqs_pcpu = __this_cpu_read(scx_kick_pseqs);
>  	bool should_wait = false;
> +	unsigned long *pseqs;
>  	s32 cpu;
>  
> +	if (unlikely(!pseqs_pcpu)) {
> +		pr_warn_once("kick_cpus_irq_workfn() called with NULL scx_kick_pseqs");
> +		return;
> +	}
> +
> +	pseqs = rcu_dereference_bh(pseqs_pcpu)->seqs;
> +
>  	for_each_cpu(cpu, this_scx->cpus_to_kick) {
>  		should_wait |= kick_one_cpu(cpu, this_rq, pseqs);
>  		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick);
> @@ -5208,11 +5282,6 @@ void __init init_sched_ext_class(void)
>  
>  	scx_idle_init_masks();
>  
> -	scx_kick_cpus_pnt_seqs =
> -		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
> -			       __alignof__(scx_kick_cpus_pnt_seqs[0]));
> -	BUG_ON(!scx_kick_cpus_pnt_seqs);
> -
>  	for_each_possible_cpu(cpu) {
>  		struct rq *rq = cpu_rq(cpu);
>  		int  n = cpu_to_node(cpu);
> -- 
> 2.51.0
> 
