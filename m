Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD72D77FF
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077750; cv=fail; b=D/QrN1o+fYHtWthbVKZ95mK677spQrbOWNU/mL4YvO4F6fICUYerVJu9Lw+6ovtuUndNI/n5nbQnIfv4UjRP8WfosHQQOenLBjXJ9rzY+0EKpR690yNInWSB7gpcduA+zmk0usi9S7HbnRBAUucBV19+0++gYgdNOtTRkSQ7O2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077750; c=relaxed/simple;
	bh=MHoZN01bt8j5Xz9PGkbznYtPBXBxXZGKmXYGEwn+TuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qsj+99maVzzjFmwZ8EScjZmb4k52bsl4VD20Ejm8CAXyH2U7oHzPS5EYcFRe7evuSA86TuwpLNWCbE2BsFr/tVEpsTleH0Pq5B4xjivwfti4KRjmD740vtm/S8mbrJH7UYX1dIHYXiHyZ+r3UikrXt9/ngxBdnf8c9yztqDpOQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BFcoX5sU; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BFcoX5sU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKRLOHNr5ZXMuz4oMW/H/glikLGLrHvL562D1D8SZQHZeJoNT9qkaAOzWEdsjHJLNB+wof3e/kjKzMloNf5Mx2nlPW7UM6BqH4z9rtF0W3mw57zdMtj7E/75GfJMaE6ao0PaGhfQQjoIt7DtVDNyzXcDt1aYsmpvKjylXNpnSrXWIUGgWE6UHE9+moGPfb6TcGJhT4XG97rkLagYh4+GwGAUFHy4WqU5KdFxamJH9Yk13K/TFVBFqQpfr38RQq7ALF+lXLOxIYTdUHKCK6uaYbqUj5XWFPC0sBrUzthbEzPvPLnEmy4iQXYzoqPaXimgkPzN9sgWXqIFbvTDN6ytSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFRaISW/JN15xjLTCizXZ5hGtdf9iRuvZULC2j6CXF0=;
 b=Y7myfXgQvI8ln+n2Z0u6zfLIaI6dlh8tj5y/DLUTmr4nISX8Hu3ggj80i+cU1UEb38+n0MQUIGc1TtPBgd/5zN0OWu1TSKf382sVF0jQcQZn/upusNmx9r4k8MIQM0+5ZFOhFBo75v7LYBky8TNrvL+PcNkFxAFA5E4t2MQmdIEY6Ux497wXN1LzrUIUSz8kVjhsUMw01F8wA4I+1bRCgqHgWxtZuLMS80Aey8GhtXtpoXwgJZ9Yz5CGU1RPhA1n5x86PUaMHmyDxXqkz4W1D8xrA5DGqjVrnz27OfYx7oLEfUJ9EZl+xe6D+Ff1j1fmDr1wh4bv5HsfkgRFChx+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFRaISW/JN15xjLTCizXZ5hGtdf9iRuvZULC2j6CXF0=;
 b=BFcoX5sUwWVzkOz61JzRgTDytlfp8p2Qa/Ut5HTJiO0vBdaK8g+6ehbGZlsus+QLWzsfR1PHLj8WtvLJ7cvGiHKn7KeMX4dOU6QJoN9iovbw3/Hj9p/3AS4F7uDxbghNHVum4D7s9HWFAUyu1Sz5JrpMiN/rbvBU5nWqNiLRBrkmJJQmKgMT0Fy2zwUVv1cxc6Aqd3q7X4h9wStjIoR9Zy29P2Yam2H3uvknzOFkYFHo8UJVp2lUiiD8oUVJWVkDSDYAE3taEK1SN+TqS0e31/6a72UsKZDYRYJSYBLSstGOMKGwSsCjKJDhCVHc4tBI5L1xcESmspZv5UsnyTQqfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 17:35:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Mon, 9 Mar 2026
 17:35:46 +0000
Date: Mon, 9 Mar 2026 18:35:37 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Implement SCX_ENQ_IMMED
Message-ID: <aa8E6WauTRALRCqs@gpd4>
References: <20260307002817.1298341-1-tj@kernel.org>
 <20260307002817.1298341-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307002817.1298341-3-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd503b1-c643-489c-4f91-08de7e024bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	VzFE5zpg8NF35EByuimJNO+Ib3r4CedGNRaasY2gy+DWrQ8hwhPyupBcixYpAlt4Pl9phgs2wwi4KrJnOYzpDdIw/St50N98RsvlNExc9QFCh49EcSK3FuzscFs0CXGoe5pfO4AwxbvihBWd5DiDEHPpaRZjP6Lfhn8cULKuTjl940QQfFIDzorXfLwSc8Wr/aC3N94H45o7EKf3HbWJfWgqWwhqryV39Ck3OZrms/0goQ9Ae5N/9NpZ8Yns05v0KA9DJ7g3ldukOBCnXVqOyzzuehMxMgVaItjkvZ2F1nbZTbKvr3IOMQ1WM/0sg1CqvYFZCw/Xbq05TefSR8smcb0W6N3S8ssDU9FhRbehdi2pWNc7aA2+OZPsGiIYQwmYj+4fOe8zdprwNFON0VMXpQh4DAQoGXQzBZ4x0J0jaV74KBAnFErvb5lrOrG630g02LZCaRVvMemM9o5nozWbXDzdpyiSVN/P0WFHeNSdxjNsZldd0X3hM3gomMAqtd7Db97+aCfBOe77pi0RvuhLGB6Ao0HbFu21yK5zFP0L8oz7jrfx4ijQ9HbPwbX0o36opkAaj3udnBmLZ8I3TL/etYKun7782eqDh3em+3kxAsT6cnzy6KXvbtg36fVWBN8SeQx2rmEKi559ljXT+fffQdGq3cQbLchbCcWbSL0+ptBnwneRXtuOonHvbWgh69O4h76sZ1kxG7EeGIyDks/UF9vKXltL3VR7CRVgveBM2aE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vafU0v45gKV5O9kc/FDXTuA73l+Q2xEmYxyztbz1A0EDukGtfp2WMOCjdeSa?=
 =?us-ascii?Q?Lju8SIByWs7a5A+/OMX7NgZBPuE9O++kCOygKRnGMZcc0QozSBbf4rpLdOaX?=
 =?us-ascii?Q?PJjfeUHLmg9+XnRZUq4fLGaRvzAAl2K87DwnreyGNXHtBegMt8uPAPyY79W+?=
 =?us-ascii?Q?KvQ92MHi2XSvccJNMqr7IR/UAv2+TjEAgbDW/1OCvrI1B0iJm3sn5PBUV275?=
 =?us-ascii?Q?jWuhVINUuIRgQZ6kbhMTp9+X11iKYw3JSBtNxPnGt0wSVM3GFwuOK1iwdSYl?=
 =?us-ascii?Q?0P/Fc+cEisTYUtjugOiwZy+n1WH01wFJ3dl5CqxRnzlKsPoaOE2Q5pmey/LF?=
 =?us-ascii?Q?mIS+wb66gA0TdN0LoBa/3xJEXRK3kxz2uFApXoZQAxDPesEbfl6nnFQCMU+D?=
 =?us-ascii?Q?aKkC9PzNeEPn8R9F80mavgATvr+Pmv3X0j33oSJ/Hki++mxAoSF6kyBvx0mL?=
 =?us-ascii?Q?5hzrrPe2b04AtMrMG/Zp0oUnNLHasPjtuz0mNndkHis9QsVhRt2HwYaF2FW2?=
 =?us-ascii?Q?g+981Bf5ebL8hlCpl8j45SgJiSzR6gZnJj4mB3my8XZy0Ua08doAU1OXkTLE?=
 =?us-ascii?Q?hl0SV8r3v7uvFVONrlRvN+QySEC+y2wedTg+DPOpB0ozW6n9pRYbiiZhBHfJ?=
 =?us-ascii?Q?56vbVmPxjNu/Cmxgh+vvsPHY5Mi4RC4l+XHjfa2CBGg1crUrRy1j5UfiVfI1?=
 =?us-ascii?Q?coNf6tzNzvGPP55TTcXWl5hznKu0Z0/+QYThk1GGJK8t0K7oVGJO77H2HSQu?=
 =?us-ascii?Q?RFiKvHUDE/JFfzkV4x5aSHT2lNsKo2PFuZDCsBRtQriUE+5UuDfI3Rnx3csR?=
 =?us-ascii?Q?DzsMQqhnVYhLsOoBnH1rmKz26noxOTeZeO0XhJnE1hUAflyC6eFmCS+cYf+g?=
 =?us-ascii?Q?SSOyYWR/ndFaaJMCe7ETPFRfhQp65iP+6kb6oQn27dmICLSVIRVIh5Y96dBo?=
 =?us-ascii?Q?aEOOU7I5lkeBb4KSMgMy80MMUlfhNBNA/byiy9E+KSQOS+mRMV7Uuz/CyuO2?=
 =?us-ascii?Q?Ji7LSf/SzzUMIj9F+cQhI8tAHlNnMFwLKdoy8T+6Vm6FyeB6EhJ4clJYx2kT?=
 =?us-ascii?Q?AUBUx2yu1BkUxUYq19R2k9u8eZqRWKHPA874z0E+QzST0zzcQdbs7aXM/7rb?=
 =?us-ascii?Q?+59SfPZ8R2O5Jjn9w2cB10PYrzm3d1rPtBFlW8BUj9ZObSQLbaXXUB1i8/KY?=
 =?us-ascii?Q?AgW5SJJFCMDQ68uZAhRYIMOETWKlozEx1jdiykflU3jTpXw7MdQHMWWRd9PB?=
 =?us-ascii?Q?/WEkD1T7kMFFr1G9k+hWiC9CL4PDERxZCveOsQjOx7V5yZ3SQCsxXvGcyR9u?=
 =?us-ascii?Q?XzXtfXG9h4q9h1xJPgCgTtW7VGYnuu+Dvf+TfzmROUcn1kc6s0M/48OnDqTM?=
 =?us-ascii?Q?BJmG3vaG59hrUj9wl2jfqn36HRNWr/PsJQX9dAKyMZaynGuU2QoiofnSHiru?=
 =?us-ascii?Q?zed1MwDoP1NBDK9RHzwLERYWuRd/3RkofmqdjN/I0LPPw9SIPmmgGwCLr5RP?=
 =?us-ascii?Q?WoMlfbQuUReafc86T0wXbHCytQGD+fYMz+XSgvw/YXTAVn5VicCtx7LclwRi?=
 =?us-ascii?Q?JzvMBt54E19xlAhkkNU8RrGub1WrA5PrqoybbXXdsE2Aj5PTSkX88RLpZOh9?=
 =?us-ascii?Q?QJe1xM0itR3yR0K0NVBiYdbF2cvFmCCozRoLm6sI3Nxywv7E3yn7+8NdeP6O?=
 =?us-ascii?Q?LigweQ+Yx8mFnwhvqCMl5H2X2aKS883UIpau9GkNrWG3xrXlus+R2TUH6TZU?=
 =?us-ascii?Q?dNivDlADgQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd503b1-c643-489c-4f91-08de7e024bae
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 17:35:46.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uviU/eR9pNcH7FxcPZkleFtXgLcNKTC8Em887pt0bRAjPU9wt1ON8BFcVdMw4wrd7gh+TzVw/zOwR/CyD5lnog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479

Hi Tejun,

On Fri, Mar 06, 2026 at 02:28:16PM -1000, Tejun Heo wrote:
> Add SCX_ENQ_IMMED enqueue flag for inserting into local DSQs. It requests
> that the task be queued on the CPU's local DSQ only if it can execute
> immediately - the current task is done and no other tasks are waiting. If the
> CPU is busy, the task is re-enqueued back to the BPF scheduler with
> SCX_TASK_REENQ_IMMED so that it can be dispatched elsewhere. When multiple
> IMMED tasks are inserted, only the first one stays if the current task is
> done and the rest are re-enqueued.
> 
> One intended use case is enabling opportunistic CPU sharing across multiple
> sub-schedulers. Without this, a sub-scheduler can stuff the local DSQ of a
> shared CPU, making it difficult for others to use. More generally, multiple
> tasks on a local DSQ can cause high latencies, and stricter control can help.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
...
> @@ -3818,15 +3929,31 @@ static void process_deferred_reenq_locals(struct rq *rq)
>  			sch_pcpu = container_of(drl, struct scx_sched_pcpu,
>  						deferred_reenq_local);
>  			sch = sch_pcpu->sch;
> +
>  			reenq_flags = drl->flags;
>  			WRITE_ONCE(drl->flags, 0);
>  			list_del_init(&drl->node);
> +
> +			if (likely(drl->seq != seq)) {
> +				drl->seq = seq;
> +				drl->cnt = 0;
> +			} else {
> +				if (unlikely(++drl->cnt > SCX_REENQ_LOCAL_MAX_REPEAT)) {
> +					scx_error(sch, "SCX_ENQ_REENQ on SCX_DSQ_LOCAL repeated %u times",
> +						  drl->cnt);

Instead of triggering an error here, should we simply accept the task into
the local DSQ and ignore the fact that the CPU is busy?

I'm thinking at the SCX_OPS_ALWAYS_ENQ_IMMED scenario. In that case, the
scheduler can't clear the ENQ_IMMED flag, so it may hit this error loop
limitation, unless it explicitly bounces the task to a non-local DSQ at
some point.

> +					skip = true;
> +				}
> +
> +				__scx_add_event(sch, SCX_EV_REENQ_LOCAL_REPEAT, 1);
> +			}
>  		}
>  
> -		/* see schedule_dsq_reenq() */
> -		smp_mb();
> +		if (!skip) {
> +			/* see schedule_dsq_reenq() */
> +			smp_mb();
>  
> -		reenq_local(sch, rq, reenq_flags);
> +			reenq_local(sch, rq, reenq_flags);
> +		}
>  	}
>  }
...

> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index f8df73044515..cd4272117be4 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -31,6 +31,8 @@ enum scx_consts {
>  	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
>  	SCX_BYPASS_LB_BATCH		= 256,
>  
> +	SCX_REENQ_LOCAL_MAX_REPEAT	= 256,

That's a lot of re-enqueues. What if we simply ignore SCX_ENQ_IMMED when
SCX_ENQ_REENQ is set?

This would solve the SCX_OPS_ALWAYS_ENQ_IMMED issue and naturally limit the
loop to a single retry:
 - first attempt (IMMED) fails -> task re-enqueued with REENQ flag,
 - second attempt sees REENQ -> ignores IMMED check -> queues normally on
   local DSQ.

This approach seems more robust and would avoid the latency overhead of
repeated failures (the re-enqueues were actually the reason of the latency
issues that I was experiencing). If I don't use SCX_OPS_ALWAYS_ENQ_IMMED
and I selectively use SCX_ENQ_IMMED with just one retry I can actually see
some small, but consistent, benefits with scx_cosmos running some latency
benchmarks.

What do you think?

Thanks,
-Andrea
