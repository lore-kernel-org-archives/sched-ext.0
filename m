Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252882F7ACA
	for <sched-ext@lists.linux.dev>; Mon, 22 Dec 2025 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766427399; cv=fail; b=jyhzoZui5i4KbqyPCQsaXZUy8IP8K/IZirOFuMOqWqFWgzccpzOj36UTOe7j7QoGYDNzaYfBRQtMi7+EIw+AvUYBV8qvXLi7v3Fx9N4xKJOu3UvdFVf7n0EePg7vKlv0qF2ucdNmaQVwj1pEI8QHeUkFVKfXITYZDzDgZRa61O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766427399; c=relaxed/simple;
	bh=Lbk1B+1+3QDtLVKxz36QP8hMny5hHxc2FgMNwEVN/PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PcUpGjYmPbo4jKifhRMjz2yInBIlj7vnorbFnFaV7e8aC7g/Vt2Q5V0O1686fTQIzNVIWMf3IPEp0EWUAJ4mKrbPjkjH7ZGFGmTHxw51ti/kkYQ9mF78RdY9R3su7qGeTwycOEnKD+f39eFVK6h62H5Al7+JF7YsFbVVBEdY0ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ApytA/VV; arc=fail smtp.client-ip=52.101.85.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ApytA/VV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+N5wFhseWWXkjye6DzvoG7ozq7fKFcw6RlGsxonxLOBeXXoAjeBpYkUA93IHFG7xOqEy78VhLuw/fe6gaJuI5g4oKUvdtZyrlp/sNyq35O8oqjSx01NdnRH5Nqk6u1PX4lwTB6he0GtrgYbRcUxPeDfiIM8IgVP4dn0NIr2kzfEWIS2gEqMzmFuSXMnsmDiZ3q5IpD0QQJ5ZF6WhsBJyImhfS2A1jtmjsaYL00tcbS7hNUywWjY43R7JYEmrKE1kbj5fw48GXvXV0AvJ7lEHu75Du1PULW5/SGxBmG4j5AgRdd45Kss5je/S6qt9SVcx26MXfBorfEh8SVcr/wF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+k8K75tQ/238E0ibEq/1CsbIh3jANHPhcnQdMQ1ep4=;
 b=Ul8OkrVHhTPUYNJqQqwgQB/nmBBUCdq/3/TTlDQpUthsyHrprWx9i49qOb318hKJgXGy8tXbgC8VGTyGyj+qaOk/ki0i+Ng5uKtf49ebuyUH6yCljmkuhzHg7d7+qS09ClWyrAoWj5Ipcc0SBBQ1hKDthWMKMlfKI3IXZ0Ul3aqDUzO/+k3/4sV9lMV6tp4ScLWnk/3Ttc3Oow3saW5eTqduWwT4U0w5wI18/l7si1OWV05TNAyVuypKX0qaI5c9Fb6UlDR3phMCecFPL5foAvZiKHSIk6XYWDD8xFNsk+qWX/cAPNUvcoZSci54J4eFQJK3bl3OTCp2V4ar9OQtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+k8K75tQ/238E0ibEq/1CsbIh3jANHPhcnQdMQ1ep4=;
 b=ApytA/VVGgFVu3tt1By53w7yusX9QivJkKN4+Ymp299aEbksd1IYyrGlPD1UhI7z0QiM4UjSKvqVkwz+GamXILQ9cODuiuUeb/53aPVzN2cYtVACmvT9I4iDMfsxA9+1R+G0pAtd+xfTY0f8qYSp0TR2xcwujBEJVBP2UF75IEyruwd5pOgsKg/Hs2RJ99Tp4iyDxWeLAzmIRrCiH7ZZQKeiTRwGaemqaXQJcVGStLBTXq5QEoIHX1uiXRxjKdUB0B1/UMN1+xY5uy8bzAuDpRbxBEywPkHw9If4UBZGa9LdwXUfWFvbX/O+XTOwEpIeWsmmq1TbfP+DBie/J3x/Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 18:16:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 18:16:34 +0000
Date: Mon, 22 Dec 2025 19:16:26 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Use the resched_cpu() to replace
 resched_curr() in the bypass_lb_node()
Message-ID: <aUmK-moSOtQdD2VJ@gpd4>
References: <20251222115318.18997-1-qiang.zhang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222115318.18997-1-qiang.zhang@linux.dev>
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 03226296-7400-404a-9702-08de41863d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?quWt/rVhyYpM8Lj4+43FArmrl8IzN5QMjSDq0UsheahJl19Hx6xF29cIeL02?=
 =?us-ascii?Q?PizE9/+gXcHcShkveTt8IBJRIgcLSLVtz+XlcRLrMks3jxQn1Nt/Y431s8Eq?=
 =?us-ascii?Q?EsMd5cC5hvAizmapNJS7S5ZDdixrYo1YfHBzDzxRCtRiLGORkf1m0/k/AhWm?=
 =?us-ascii?Q?vrXwYGtc+6rIRd1ZolxUFYugQCuImso8pCorm3sDrh4wmpx4rWO9SMBwYAh0?=
 =?us-ascii?Q?eGdpGMS3Q1lcCqqbH647MTLp7iNrLWa+liboqXH9O9/P7jAS3YbRv1F5o2pX?=
 =?us-ascii?Q?e4baz7F9Nlv6Ck+tI6yTO9TgjZELRk3Q4g7I41y4TrW8JWa3bZ0Uqol9bEkc?=
 =?us-ascii?Q?1hHa39/yOsfppdakjwyA6Q2XBv74ucUXWv+iTwKJfJewdM9qr3kzQlJoVZ4S?=
 =?us-ascii?Q?yGX28s9ew7rDkobIfILolOtmQbimANenG1WwslJIdu72OsaKbqyNghE9nnT7?=
 =?us-ascii?Q?/LKQhvmFhrtXaa7SuTot8fA8bF6LhEBxlXrSqwRVrO09enuaVzcUOib62JPL?=
 =?us-ascii?Q?CS4HjYDa6DiuUqAw8jp1RyzkQRC2IpomFBzZZlQOj7XkqljrNpzcq1PhAuUn?=
 =?us-ascii?Q?VHp6ZDbjHKNMXFc0JtUnlf6hOdM9wLLEVJx0msEVp/1DaBMsaL+3A+8ZGfA8?=
 =?us-ascii?Q?hjz+ktxHBPbLt7+yzAwpom0PIAYBrcPBhJ3P/0/AsKe9r1zqCLdaQUmpeMHq?=
 =?us-ascii?Q?fCt+jXL80c02CN7/cAeDW4vydTerKnCvhG4qvlTR7u2h3dgtFrNNsYWZw/IU?=
 =?us-ascii?Q?pPUZtEtDv8YcAPQ4zbNkISLftcjrUZUIJ5Co7yjUH7beazh6YgJmobdrE57D?=
 =?us-ascii?Q?hJ0SfDoTMFW1LJh3Nln0FvHeoOmxz4oa25pK8q7aboLZ28889ma2LCEEeuk3?=
 =?us-ascii?Q?eU9QuSnTgUyym1gTR5q1xd95bJtVfSsgvv+NwYMNCzezPvUVO3sONZqj/a6B?=
 =?us-ascii?Q?MqxbOgO+cc0xan1tpgOENRdJdzdxDDchBu06eFfXauB7ve+ZvgHCijPmy7ct?=
 =?us-ascii?Q?Q4PgAjL2DMQSrjYQpeI4dvHg2Ww+aZ9SvShrUrNpeG4xexQINJEj7xq10Dra?=
 =?us-ascii?Q?SA/LjyfDNBwATC2huOQoLcmNwLZPaZ7gd3BCi0kuGAuewsgEt/eDyfTWV+D5?=
 =?us-ascii?Q?1BDZmQwVJ9OOe9p6evTFfrU1daqfRnlGSUyhA/ux7x9px2ZqS4q4jONNoif4?=
 =?us-ascii?Q?waJEsuyEPNXMEJ8gzAVx0IQB1Bbqf9ZBPA/JZ26NNScu3qzfwbC6J98dJ30p?=
 =?us-ascii?Q?6J/DcArvRm+kOOxT/N4jPBk02/RCMEbFJz31Kuvqoob/C99rTftYmoET6CjS?=
 =?us-ascii?Q?PDQvS7TA+am+Fbf+1J+MI0LF2fJ9KgOHQB/Aidij55K8PMLI9t8fqDTP1kAO?=
 =?us-ascii?Q?CNhgshl7hQ/qu/mF2ThjKLL+sgVXPTp405pnkMDDFHgZJyPBzxc+CsdTdDGn?=
 =?us-ascii?Q?pIuSxlgt16Esp+IgkWIqUsyqAcI7pTa9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dfzs2suEurWpb/mTjM4jaLnOVArFxgoIxPTjK8W7WhlA7oGCS+PIeoKiE9So?=
 =?us-ascii?Q?zXwMhJVzGtmeca5CaNK5ugI4hHsaicJGz6xH2B1ub0xxlB47oTWagV5eopDR?=
 =?us-ascii?Q?Ujmn76lyceIKSruZ01lyyGqBzhuVUoBLEhuzceApGd+RTRBNaT9Y7ugPKyyN?=
 =?us-ascii?Q?N5k7+m7I6PkWZUlb9U5jOynWjH4Q6YxcuJB9d/pNwCWKx35w36fLnPWbmnhF?=
 =?us-ascii?Q?gGBuvr0NOlIFga9Bh0K8aT/cp3zliwo+bzVY37hB7Av4QkhGFikCEBx18lP2?=
 =?us-ascii?Q?UzPK9gxVt0WRfNQ4lsv0zHry6NLdc0oxqd5CNO7gaPk4OIVfeBBbf7GnY0tF?=
 =?us-ascii?Q?/xb1ASO6HpzoTXDWez2vnQyTHM7sOfZ4qoVKgg++wVIay844/ehNaEHGmOXJ?=
 =?us-ascii?Q?cQlt1ljK4COsP9e+9xbMIgMVTlHu0zrBezjjXNKAdFRmALatS2oUmwEjT0sO?=
 =?us-ascii?Q?JvY0BGA41FX8eOBDcPAORs91wdGJsWZL6J/bbgb59P0mMY1v0O8ByeseO/BU?=
 =?us-ascii?Q?pXl5qzmN9tFiECegsr5F6N9m7c7sNU7DcBguBp6VPol7YlXo2Un6mXEkhZeP?=
 =?us-ascii?Q?2Jhn/8WVyuZ5weiJNO9JnTjgr3tcsMrOwXgQuSR18QStUszqrl09BOHXKz3e?=
 =?us-ascii?Q?1h29S61gLDg2quzeRnoPWshkal7rCoS5P0mO6GU9SERe92U5zghfDAGsfZbo?=
 =?us-ascii?Q?DHYnhIDVF5fbJM7YtPPQMwsFZ41V+6lDCfkyxQRVCVMBpIpeY1PuycM6g1SW?=
 =?us-ascii?Q?aqM1INxea+nofHTCdys14l04P23D3WQYBo39iaNf22P90bbaPnujf8qziI10?=
 =?us-ascii?Q?FfEtQ+jyOv2pG+3KT5sQLYp0v0EjWnGJ5iawdF94EDz7+l59vHLFK3ETf9+T?=
 =?us-ascii?Q?v/YtSUKc1NH9toMdUtoa99APSMngxlmhhlil3FWK/msCjm+eIxdlOwt618mS?=
 =?us-ascii?Q?upqi+VX2Pd7kGg54B4RU/xkFHYlPEWHt31rgTvfD0lL/cux2//l587Kf6qpP?=
 =?us-ascii?Q?HDXiqDTAdNEQRk8IpP4Su8kruNIp3WkoJtoaj1f3yY5wImBUTkYWfi6e96jB?=
 =?us-ascii?Q?/lf+wrdx4YFTWMv2f2rIhNxPzQT8Y1gyFurxohDTw07f5yVYaaYumeW3DUoF?=
 =?us-ascii?Q?LotuHXuSpyxCpzsAyP9HJakeKPysBEsE+R3NN7P2taYQzaEyQgr6R5+KUgFD?=
 =?us-ascii?Q?1cFlr5eAfzhrjg4o5oHPi8B2KNOF8BzCZIDIgnFDdLLfVD6EDqM8sT1s/JGr?=
 =?us-ascii?Q?fb9ZTSyIbcWHfAndCIWzSmPyNVDjlJjSTwbWpgRqyDhZ1TPLPgidXMXwAm0O?=
 =?us-ascii?Q?DQm/09w71+993JbSCmOO56ExqBu18gZAZ/+0Dc4cWsyr2EeMa29K3ahvHKs8?=
 =?us-ascii?Q?26HGacd2i+4qEs1znXCrk+hFvHQN20OhfhQDz2bVFNv2wwcGM9x4BzrAzQiO?=
 =?us-ascii?Q?8hm122W07xiHkzG8+w4kpxg6Vv461HVNJWGwIB774lWUcVMO6si5lkHO+6JG?=
 =?us-ascii?Q?cgHvsXgPCY2BIdurCB6+FKYbGMeE+4YnI7HPdnI2n6cE4yDC832SaX1Tn2by?=
 =?us-ascii?Q?pjclD/sASFEy33XyqnTWBXmPFW1O4fuErCqncjki+VVclFkYsqilOT3doaiz?=
 =?us-ascii?Q?NnzZb/PV1qwwDxpnvifiBAEEpYHXOGy5rqFpVGTwLuuYXl3gB6M2Phm0Zdr5?=
 =?us-ascii?Q?N+LRgMuUWDIhtu7vQTzEbWiOo/mTomhFTFMMD4/xA3zDbkuSa4dbAYmc31jd?=
 =?us-ascii?Q?8UGEFpB/wA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03226296-7400-404a-9702-08de41863d39
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 18:16:34.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwWi6owYqQj+x/a3mHo69lHaioo6yjt9TrF1sxRn9j/ROudqgxiW9wWPaS9vmzTHM+EO9BjnIniXjlJ6lSMPVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162

On Mon, Dec 22, 2025 at 07:53:17PM +0800, Zqiang wrote:
> For the PREEMPT_RT kernels, the scx_bypass_lb_timerfn() running in the
> preemptible per-CPU ktimer kthread context, this means that the following
> scenarios will occur(for x86 platform):
> 
>        cpu1                          cpu2
> 				 ktimer kthread:
>                                  ->scx_bypass_lb_timerfn
>                                    ->bypass_lb_node
>                                      ->for_each_cpu(cpu, resched_mask)
> 
>     migration/1:                       by preempt by migration/2:
>     multi_cpu_stop()                     multi_cpu_stop()
>     ->take_cpu_down()
>       ->__cpu_disable()
> 	->set cpu1 offline
> 
>                                        ->rq1 = cpu_rq(cpu1)
>                                        ->resched_curr(rq1)
>                                          ->smp_send_reschedule(cpu1)
> 					   ->native_smp_send_reschedule(cpu1)
> 					     ->if(unlikely(cpu_is_offline(cpu))) {
>                 					WARN(1, "sched: Unexpected
> 							reschedule of offline CPU#%d!\n", cpu);
>                 					return;
>         					}
> 
> This commit therefore use the resched_cpu() to replace resched_curr()
> in the bypass_lb_node() to avoid send-ipi to offline CPUs.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Good catch, resched_cpu() checks for online CPUs, so makes sense to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5ebf8a740847..8f6d8d7f895c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3956,13 +3956,8 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
>  					     nr_donor_target, nr_target);
>  	}
>  
> -	for_each_cpu(cpu, resched_mask) {
> -		struct rq *rq = cpu_rq(cpu);
> -
> -		raw_spin_rq_lock_irq(rq);
> -		resched_curr(rq);
> -		raw_spin_rq_unlock_irq(rq);
> -	}
> +	for_each_cpu(cpu, resched_mask)
> +		resched_cpu(cpu);
>  
>  	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
>  		u32 nr = READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr);
> -- 
> 2.17.1
> 
