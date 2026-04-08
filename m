Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7743D75CB
	for <sched-ext@lists.linux.dev>; Wed,  8 Apr 2026 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669680; cv=fail; b=P06145OgMs/6z5T+kQ8xype20fMPoT6pJOq81q3qnS76S7VZKHtvjUCY86sjcA4H/UkqY6Eto1j+2JTmyT9iFuATNEM+D46ToZ98oqVuzu1gjAZMJLqookfOPcgAePEWTce6JeGSP4gXixYrIeAcLgycEBUb/Bk6lkqkYcTo0MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669680; c=relaxed/simple;
	bh=IPldVEEMf93sB1SdZB7aruhEzAIGwFKKc6SFFOmn/co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MfsJ4NALoR24X0qlC+mDzqaWEN0kQT1C0dcDN4uglkE6Gqh0CMAx7vdIJ13xuzo/PMR/RmfyviTo8/4bRPaRwDOMGGjc8k2iVZ53MfmtKVa8xwjSggB5kPozMsR0j00oyBz+2Pb61FAcI4FcFTHPr5eoFSvRl6Ra1K/BVio2Qx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BKqI3MSL; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BKqI3MSL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YowQDXhGWvZykz76lWiP9MhrGiLPiQmIwStqMKjEIklW8rrVjbKDlRQJiU8l+tGPHn83rdTVWAmuehmgpT8xQjESeHY7VnxJuDb1HcBuU6ZNG/2ay1/T3JGDCdyFeIobIoA07HT5hwOPhUNZIevTXz1mYUDaHR2CZLuzR/vW3Esnzp2oqckh/iIPSAl1rqi7sBscmnIjvJEdHDyDLNmQxlEynLGCSAVhuTIWnDJCH95yZMC/47y9l3xH4ZKsY4yVIcHVX1GQ4/38FqnX+U6gElfzcroot2ogYE/PV2AeIOMjEVwm3nadWaWSwcSBfTBbczvdJ+HyWZekWc36ob7wPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eeSLSPCa/BFSA8Ia7bOf5lfXzSrJQY1B/h+zwXCJxo=;
 b=SUkBF8RsMUjFuZx8CsZwW3JhPrrHRPONWkoMoVqRxRzgqCxlKku5/HBQM2Zqrhffg6qAJxY2Vua5xDMOGKA1zMKH13TXfXN/FvRneTrrfP8f/A98dTZunmQDDqa+/MDfTC0MbZIrAsoU3bFKnr/4NxOAhGlSjbdeovMB32PTfw2ld/6cvUI0PdBrNH8DB92XOpMDxBTSQdjetwQJCxuH3TCfw5bURnYhuaSalo5ehcNI273t6lk7rFodiX5xAwsP/SqFG3+q5625SQyq8bpG6dirLhqDj2p/aFe3QIApvqmjUSiYSzk9M7vIeOtNGVqh16A0P+Nm9lh4eiQnmkSHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eeSLSPCa/BFSA8Ia7bOf5lfXzSrJQY1B/h+zwXCJxo=;
 b=BKqI3MSLUSQw6Q8/hRUrfmI4qxfeWJTs4tvAPQLSuxSCZpkKIPzEzSH5SO/ivH5vYaxeqwgAwJo5kwh8O/MxnsXpL/OfsVgHm2wLSYCR6MM1V+gWJlWCYpWEdTcs/3MQquWOXe72/JPsiUJ/jDHAcwhNHlx3rf3zVHbrZrfdHre2TA3zEehJX8/vs6Y5jNma5sdpYh6OxbQpXQWjoA3jzFR4b10H6FNI3cT3eDHOqF74H/gD0IRYNb2BMOc3JSAbASMM8/VSBD+TizRGTY2U1IvlvoMkenKgS+3TRCiOmvfcIXAXFltw9cyo67wzCqpaz0gO1+W9RCFFhfVzYnxfYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 17:34:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 17:34:25 +0000
Date: Wed, 8 Apr 2026 19:34:19 +0200
From: Andrea Righi <arighi@nvidia.com>
To: KobaK <kobak@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/ext: fix cpumask leak in scx_init() error path
Message-ID: <adaRm4qj6TbbAR7t@gpd4>
References: <20260408172312.2178104-1-kobak@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408172312.2178104-1-kobak@nvidia.com>
X-ClientProxiedBy: MI2PEPF00000B7E.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::412) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 4909c4f8-45ce-4c22-39e5-08de95951434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	P+5cgLsCP+/YfXTWj5Xztb/Bv/8f+AJqtfS9LSe7UImvPoriQ8lbRJe4Agus+QOC7NDlmMDDNBDooqjYgF2jKTe2E4gWorM+Uo8ioNfsvSHGk+g4VBKCAPmpyyQxChp3lrFKYEhet/fsU8chY3Cmr1Vy1u6Erhit2EJhYJbz1JGvqS8sAgsDhP1myszR/EhJamrBvLiVZsB9eaoSYENCq55s4jEdvIkj283fDb+u4txZv2+LdoJcVqESu5D6BzO2Ue8Ajh8SxNy2kyTsJM0KCHt4nilRRluvscXjHQu6/eXh+f8KoaZt6E9XOcwe8gdroY6pUILiEDqfx+0rYp7mhOEexXMYcBVXGdj6hiJR/No7OB4l7L4PorJEV0E2K2+15SKcMmmsVb3uxr2zlf5TqwytOMfjanEPMy7XznRQ3hwbvtsiqQ50eiaWM0jztKsYH4AfCjAzjz+je3Hi+HaDwyiEW1XhamdKMut5w28RLkcxZPyxBm/LuifNUXDtO8uuNyteSwOKrFbLOzLMF6ixwW7ApcI52oBnR+aeeDpFxQobbnspMvWrUCYplvj6KUlN3SP41FzxuMjgwGMwNi8/SFNQLXZEbssLhQlNv816fizPD6YMbaZA0dGPtePsTwktj70vTKglt1EtJooiAf68CvCWmaTK0Mu8Mbo1RgFr6/Cyl/X6vlJkBlt1VGnOcyjTswSa8GBLDTLSXs/2WJSG3cvkgwZPodr3pnvoQIT6tiU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V419SdH0XPKw5Wi62Byv5s1bV2acXrEmVaboHsfa05S56CJuhEtzh/Bfuc+R?=
 =?us-ascii?Q?5x5APtKNvFVOSVz6sgX7ldyDnLvtbA3YggItK+LizAuBCs6pkoDN4GRU0q5/?=
 =?us-ascii?Q?001Pq2MhAYDoKTD82DEWRtdK5Fxo8kDiGXwFMGMphd820fsoQ5bdpPj2Jrom?=
 =?us-ascii?Q?/eZoKJZhvqeZ4NqsaMixOd/A2ymumkTEMsj5zXynfwVZ1VSIHO8s/Xs1+t+N?=
 =?us-ascii?Q?9c3GoRURQMD4FSmA2K1nWeaD3eVlcKGsn0jiw7cW4bovSx9UzUf4P01UbyW5?=
 =?us-ascii?Q?VZtD1R7bFBt7nWkiXlrnrSF31J0xzCtpSZWGhM0J1ljIga2y0fL/k16vOLFu?=
 =?us-ascii?Q?pNoELckNn2vUfZn9fq/K/bgL9pg5YqB3p+IpEmr0UJTDXrTmkKzdnWRaNmNN?=
 =?us-ascii?Q?oOBVbn9QTXeK3lJGUlIMFYP/W1u/U1ldwtUbrmp352u220j+aznGi8z2ysey?=
 =?us-ascii?Q?xsKwi26k+u6W5JmHmH02NsN68uCec2glQrIPkqChMBN9Jz4pYCvIhZ9a/90R?=
 =?us-ascii?Q?pItuibFk8zqDtdzZLuNvSiSwRrhXI0jiOf3U4bcz2yOMqEdvzmN81fuZI6Pq?=
 =?us-ascii?Q?5lT3Qw36M1I+rXNhAVuLG+66xXkp/u4dZ1X6e1kmjU5zjd124N1AtsqZgoTk?=
 =?us-ascii?Q?vxRgJxmMyrXs+EkRLABqhW51YjXkm87jAD3AKeyte3a6ThXqD2jrBGjWk1My?=
 =?us-ascii?Q?ce7LIQnWo+n+0nSB2AjNRfIm0yGCyXVWbFU7cX/dGP0/buIAv8CHINxV/K40?=
 =?us-ascii?Q?Y/faANCgdMM6Pq8UdHAC+V5+071KAFhRlSjaPIZZ6TcqWYIZJKnwuYLbTWrR?=
 =?us-ascii?Q?3QzkUXby4JFHAs2m/cUj1GctRO6aFu6HH/OuLhXwbIfPxGDWVhE3DwAzt8Vy?=
 =?us-ascii?Q?tUU55DshAXdOe8uY45DBwozive8vuFa1ucxldBlHrOGDOXZZBOnGvtdXbX+6?=
 =?us-ascii?Q?lnHrnkNY5E1Vmi5mwfhO9sBTBKH+8+gtARVIU0LZW2uxjFRFjllizvME83bq?=
 =?us-ascii?Q?JQu9WCuvIelOA2plhp6Ait/yNTcdLRpZVYejxaK/WPI5Mn71x2vOZnxc0Al9?=
 =?us-ascii?Q?ajD2r6LafDD9hkUsAWLyDUyqkUVZIPW4YnU4p1CKCRTN/r/mc8DmlGiIdTlK?=
 =?us-ascii?Q?XxXP3Hritfhmui/JtW8udn7CjskM7gPei98ZrdEzeiVXm8q4Zcu2jVxviNlY?=
 =?us-ascii?Q?cJQWGJe3qkNsSC8YspuBXccONqXCIn86M+oscuzpli7nmHu30ljSjqA24E6h?=
 =?us-ascii?Q?WEsKajFxSjXHS1Sgy3rJiG0CP0ld9ptdJ+O96GnxeUX7Ehx5XZ+e/40jMoyM?=
 =?us-ascii?Q?FedT75MtMar5NgI7rXFh0lw1DYHP626ECh47swcyognDY7U2LWr5cioi87Ta?=
 =?us-ascii?Q?7aj+WBJaHNzu6JRDX/YTnNtdGi7H91BDZNeMDqTez3y4b1H1mBxKSgHwxT2V?=
 =?us-ascii?Q?koCGEAVWF9+DstD2EiPVuvxkcxY5zET5qBRRCOcphSpDdSuPVPV1p5Ww4yt6?=
 =?us-ascii?Q?KAOFrt5jql+MX3FM6zPCaYiG4iXNLX0o4iAyIAdCtf6MIzLjZKIupa8kiuX4?=
 =?us-ascii?Q?m4BDtdFz3nqsDU/zX5OjjKgpD6R7fKiWSnIIWUkslcTxBLuEqiz34OVzf4g8?=
 =?us-ascii?Q?U018DSlzZlFKRdODFwXEYqz086mofhf6MyKc782SMVd1bx54wdMDmYYTSRwD?=
 =?us-ascii?Q?Ihmgyz2zBTFW94zXR3YLCrDY/HzfnUBCFBDdPQ6NlFLO5foSBXQg7t6K8wV1?=
 =?us-ascii?Q?RbM3PtJIiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4909c4f8-45ce-4c22-39e5-08de95951434
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 17:34:25.6047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: La8w8Y67/5HZyXA9ff9uUC294eo8NCj9nbyRDqGsmsfPyDuQwuqGwW5qB3GAt3rRWhYus8sIYYqA7vb1x7NCLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727

Hi Koba,

On Thu, Apr 09, 2026 at 01:23:12AM +0800, KobaK wrote:
> From: Koba Ko <kobak@nvidia.com>
> 
> In scx_init(), two cpumask allocations are combined with || short-circuit
> evaluation. If the first alloc_cpumask_var (scx_bypass_lb_donee_cpumask)
> succeeds but the second (scx_bypass_lb_resched_cpumask) fails, the first
> cpumask is leaked.
> 
> Split the allocations into separate checks with per-allocation error
> messages and free the first cpumask when the second allocation fails.
> 
> Fixes: 95d1df610cdc7 ("sched_ext: Implement load balancer for bypass mode")
> Signed-off-by: Koba Ko <kobak@nvidia.com>
> ---
>  kernel/sched/ext.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b757b853b42bb..0648088a76f09 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -9662,9 +9662,14 @@ static int __init scx_init(void)
>  		return ret;
>  	}
>  
> -	if (!alloc_cpumask_var(&scx_bypass_lb_donee_cpumask, GFP_KERNEL) ||
> -	    !alloc_cpumask_var(&scx_bypass_lb_resched_cpumask, GFP_KERNEL)) {
> -		pr_err("sched_ext: Failed to allocate cpumasks\n");
> +	if (!alloc_cpumask_var(&scx_bypass_lb_donee_cpumask, GFP_KERNEL)) {
> +		pr_err("sched_ext: Failed to allocate donee cpumask\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (!alloc_cpumask_var(&scx_bypass_lb_resched_cpumask, GFP_KERNEL)) {
> +		pr_err("sched_ext: Failed to allocate resched cpumask\n");
> +		free_cpumask_var(scx_bypass_lb_donee_cpumask);

We should probably do a proper teardown of the other stuff as well at some point
(sysfs group, kset, PM notifier, etc.), but this looks good to me.

>  		return -ENOMEM;
>  	}
>  
> -- 
> 2.43.0
> 

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
