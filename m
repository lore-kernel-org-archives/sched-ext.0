Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012041.outbound.protection.outlook.com [40.107.200.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F203383300
	for <sched-ext@lists.linux.dev>; Mon,  8 Jun 2026 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898318; cv=fail; b=aS03P827gMPgOmTRJRe3DWjMZKBcN8zI8nUBRfRPBuQrYX/zEwLwN7uwCViSSLEcdOGL7L21Lz4F249JMqkswnRSEetg0S+erV6E5W5rwxZi7qOgfVaopEbmPikrAAMmin4T7OunfMF/YtR7fM6dgEBYlF9dEprDupX8LL32J7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898318; c=relaxed/simple;
	bh=cTSsixLS5A8JzW9158LI6iNUlCG4x4HkH1RuZJlG4Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e+Er9oqsOOAUKKlpcPc+23LvlLACWw8IvOSkMXM8zIH+VFzQxTmB+K5m4TLXPvJ28owcCFx9MLeli/Ezc5t4iOHyG4hYvdeUmdsftJPoAB1ASfSWM7GrDfyBGjW/veG62O1x5MAecJhxnrXIg4/N2ucTR0JWdYgW279yn5ldaxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TpU3tmlC; arc=fail smtp.client-ip=40.107.200.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TpU3tmlC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEijxeKxL1BDlsg5sbhmkgt/jspWrp/19PVvXSznytUBOCSzt1e9TV0Nt4Gy8xH54H4KHhm3TWziI1l/ofsblkX7Q5zli6njSukur5Ln8nQli1laW8SVf7qQU5bHco8SA5f8s33fdaR02n9/vUpY+czUkERIxceuoof1yoGQEwq2IJh6HVmC3KBcy5eqliTfn3n525LLJ4evOi4N254Q5FT9dzK9OentbBxdUcC+K3ddy97eX3MKx4RFTbUuOvcyNHmsGqtfksXPUtI9oLYw4sQwie6cbK8U8+ofU9/sRf9yZJDtxbrzweuO7mF5WCl3SNLUWB/eaObjiblr5geX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPhCN0AA4hBlWU6Dlildnd1SGyNOf6pM8xP6KU3nJp4=;
 b=YVBTHlBFBrT5OlMBPvfsH1ZIoIcQkps1SOVaDOBY+VzZvBE4Dx9Cn3yQNliSC07bPuMmHCrbpZAd0vGKGSGhFgdJuOryJk8iDzuDt/O650V7e//PcXo/1yHYM6kvF6cv8QXfAwxBLNaPm0DKloxRiI60Mho68/ChKFwlPYGpw0LEzRwkQc1GNjHPPw/2xzOg+sqbWIhg8hCdYhf85WMNS3SDYXEQVwpQh++6CcszrgzLv8ICXMzn4v5VOceCULuHSb9IKYM8grutY+LUcBrBFsa2L0QMNynLCInn0/62y2BmHRxSAZpi0Y3gGmPK9l6Z9QNTrFiH939LTHg8YPt4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPhCN0AA4hBlWU6Dlildnd1SGyNOf6pM8xP6KU3nJp4=;
 b=TpU3tmlC1k3uSI9uYilRacvJlzEvFpvcoQEo+zm3uPmPSNSRVKwBkBO2jKtISX6whO3GWaYGLjBc58+ikFDjCnxq8emtwZVGCog8t02ukHjq1hb6qF2PTEBavpIn0JDyAtjjbqKbIP1uRCRiQJQf27heNHub4CcFlyN/guK2GgOrItnUSz2rGDlCdsWU1PK8j3hLXf4Xp+31y7OGQhuFsDevbHBFu1HsuqqEAg49G3pKSqBNerM7eesYyG+Sy0cW64IbC3bRAWeKpe5Q9iQ8tfOqvqehJuKT2f+O9sx1Oez0TTj0xQ/Xiw1Hr1ZjryJ7EdgWRR1zoNhjqR2AvnzLVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 05:58:33 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 05:58:33 +0000
Date: Mon, 8 Jun 2026 07:58:22 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Wanwu Li <liwanwu9113@163.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, linux-kernel@vger.kernel.org,
	Wanwu Li <liwanwu@kylinos.cn>
Subject: Re: [PATCH] sched_ext/scx_flatcg: Fix cvtime_delta race and add
 hweight scaling to bypass charging
Message-ID: <aiZZ_paznyjZmGBJ@gpd4>
References: <20260608042230.3-1-liwanwu9113@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608042230.3-1-liwanwu9113@163.com>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca23e1a-947f-431c-7635-08dec522f8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OE8FHaAAkZJCSx0kGofsm8ZI+0sS9HXOcex2J3329jigbBWgT+NmP47FLlcRaCM+O/e0f6ebiyAm1LkFgbEuezbOmv07OwGlOlM6MIDfE9KbR5PIY3xbwyZgsBvdijHwGl/uc/Hl7j/uYBhkSNGdL55Pu34CYF9TQAHYTTvxpliNTHVrUAfjspdWS4w3Dp/7mr3QvRd+sh7M/tDCg7cShCZ5/NgYvau5OCxdICsfLGEcNKo6msv1r4aE0jsnBDOaBngE4EEuISdA1hUZ0+oWbxSJ401WoFjSInWoB8tnRTXca+/ROjBdOf50Hw6T3EnfI8ILOjb11Y30Pb+/paR8c0cB4hwzS1lMuN8iGDxmDzENF0cFFSJMRTz7b2U/dRPPO2wTpCxrhbIgEG/mc1ln80OHLQk/w+pX0DbiSRjeHsC52A9qgK0B6Gq3b7pVLbMGsBvpF75a89+TP0WOqSv9zTK2+JSCAki7xiDuet6r5nwjE1TXHuL8MsVxpWbHAFWi4IO6iAJBvI52sgBgRflCHOt0qIkis8LgM2M17dfxy1nqnYyblSWFjHxY5BpMpTkfn2TALCWi86x5IqGzMDKDJDd4yljOAzizTGqqXkhdd1zeVMjQM7sPmraSvN1+udFnQbUYRXbVO4KaSqdkV9jABxSnlCi/VBDAxRZuRqpXn4O98lghHU3Bcipv17G7CeJG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YEf+eVZ8fNsL6BZ19J0NyLqug3hMSqc7EgVpynQApuBFOWTrzJsEWl66QNd/?=
 =?us-ascii?Q?/Pp77/Ld9fT+ib6IUGLG4jzTCaMRhozAXrWk1iRbn7Zlrf//ZAxwxp/xJGQg?=
 =?us-ascii?Q?mJtrQV5nUa9xt7RCYrY1LrtJfR3twkPqvHiJ+RmnsgVc8e7fFkiyPNDUGKmF?=
 =?us-ascii?Q?7x8DZWPCLu0ysSxqeWqH8LABpNsQIg5bDQYEsut5PxxTq0EegxixwOfjUL+w?=
 =?us-ascii?Q?6jP4A4U1m8Okyr+dpmWoadhCLxTIBz4fniuXIXFl5FeDW91YM2k/0cfT/NxG?=
 =?us-ascii?Q?drRMA0JHJ6P6+xZkTfg96KvT8cH+2MINpsmRdCb0umi8kuViJy589uDyeLsR?=
 =?us-ascii?Q?zGD0kkAGSTt4tB5LQoBaEw/zj0umwt2kZ6Mm4fb0dy1YsK8Soc3qM+Zo7FhJ?=
 =?us-ascii?Q?fVuDajNA6k3zJLzRCSwdtiQhwMIsX1T6nXYUUPvHfsrXBE3FNS66SLFVJ9O/?=
 =?us-ascii?Q?DR/KRYKTCvbkI26K/8PYE3pgqp0VJWhs6elv/NDAaSuVAQHI4qOsyt6JB5zO?=
 =?us-ascii?Q?W1/LoCBw8unOq84AQKTNJZQO3oCm/XBgpBWeDDORbCiybdHq1IUabSmtuCbj?=
 =?us-ascii?Q?mSua6D2R/U1/y8zgveLsjFyM2GmjnmWXVF2Qhh/aygGoJcCx2BQibnX+eN5W?=
 =?us-ascii?Q?VqV3Oeo5IgvrmDA4T1QPWSGuizVU7Y3Hmqr0a2kiloPDQ04BvCn/WWreA6CM?=
 =?us-ascii?Q?icVZdVGfnSEBsmqMgWJpPEV32G3gXQ9SWNQL6dZ71UcVJFJ4BdYdf6sFcsrd?=
 =?us-ascii?Q?U5Op1afoONsQ9poylc+18bR8GOl6reCEkZUMxdC6yybuHYUwhpJJh0zVuV2c?=
 =?us-ascii?Q?OPWR3fPGFbuvzbPREndCcbfzXpS2phimy029iH7O2Rcq3Ly3ewMFde8568q8?=
 =?us-ascii?Q?k2BTA2orYfRaJcYV8gnHgHet8LlSbDGT0aujOEV40a8FE2IKcZLzdauxgEkm?=
 =?us-ascii?Q?7fCfQrKo33VAgwUsX6g10TJ5E/0G51DqOtZ4YC+tE7ZhIiK63ARVC6yb54I9?=
 =?us-ascii?Q?WznziQ0QzFGbLH/FFpa78DuyZXiCwV7IqidN0wv/Y757WfSHgOo6PehhADU5?=
 =?us-ascii?Q?C+b9WkD4C5+bsDSGcXlys3juH8icNwNPfzNgSFsu2i7S1WZtJX+1UoynhI0s?=
 =?us-ascii?Q?voyGGovYY3WdnqT3O8cQIilVAwxc2wZ0acWU5g+RocJfzjeQ4/icZ72fcF/s?=
 =?us-ascii?Q?j5piaZFRMRdM50Tox84k1h/bCLa6x02Buslhkj9kSWbt55vnupAPdDLhby97?=
 =?us-ascii?Q?iZR0gtAxMo7x1qawvzw3iodmA7MqGKnthQVRHd8amYIfPki8t0ufuFHwUMcr?=
 =?us-ascii?Q?b+0JDgcjBirm1R81/JWtUQItvRgN16rbCy4/wIfxUQpzuiOKcA9K2VUQj8rc?=
 =?us-ascii?Q?Cpj5NVAgOuoJ66tfMXQs9fVbaU4H/j5WDWtiKhm5+A97JoD/qxLboxtzO7Ui?=
 =?us-ascii?Q?8m9EGYuGcrXk66KSPnSxs/Qv+fuLp6oKeTebTNabW6cJcHi0yK555z0hTGmj?=
 =?us-ascii?Q?IfGOIoDclQrVTmPf+eBlIitxZu90aHUx2+GuVlm0ISv0KpG2inFygam48xlO?=
 =?us-ascii?Q?Ft/Gl6wDVc60lynJPbfiMSECfBHKrO2IeqM8wVoaHQkbj/njVKUjHDWTrsYO?=
 =?us-ascii?Q?CNl0pLmScO3E4TFN0X+ERR+p3RG0euB2zARZJBdMQGcqvmGH6hBuLc1DX/Qs?=
 =?us-ascii?Q?xp5HLAP1J+YYsu3Of5zYUK4zuFIuT24gOE5MBQDDLyVFBkJJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca23e1a-947f-431c-7635-08dec522f8f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 05:58:33.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68hsP9ZDKelrCsQv5G+8V6CWbcVCxsIEoWuIjfrfNbgOYzILsO2z0YZ8PCKK4qx9+9JJzbyBTuHV4Ammr/ndKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649

Hi Wanwu,

On Mon, Jun 08, 2026 at 12:22:30PM +0800, Wanwu Li wrote:
> From: Wanwu Li <liwanwu@kylinos.cn>
> 
> 1. cgrp_cap_budget() used __sync_fetch_and_sub(&cgc->cvtime_delta,
>    cgc->cvtime_delta) to atomically read and clear cvtime_delta. However,
>    this is not a true atomic read-clear operation: the second argument
>    (cgc->cvtime_delta) is evaluated as a normal read before the atomic
>    fetch_and_sub executes. If a concurrent __sync_fetch_and_add() happens
>    between the read and the sub, the added value gets included in the
>    returned delta AND remains in cvtime_delta, causing double charging.
> 
>    Example: 
>    CPU 0 runs cgrp_cap_budget(), CPU 1 runs fcg_stopping().
>    Assume cvtime_delta = 100 initially.
> 
>      T1  CPU 0: sub_val = cvtime_delta = 100                 cvtime_delta = 100
>      T2  CPU 1: __sync_fetch_and_add(&cvtime_delta, 10)      cvtime_delta = 110
>      T3  CPU 0: __sync_fetch_and_sub(&cvtime_delta, sub_val) cvtime_delta = 10
>                                                                 returns old=110
> 
>    delta = 110 (includes the 10 from CPU 1), but cvtime_delta = 10
>    (the 10 also remains). The 10 is charged twice: once in delta
>    (applied to cgv_node->cvtime) and once in the residual cvtime_delta
>    (fetched again next time).
> 
>    Fix by using __sync_fetch_and_and(&cgc->cvtime_delta, 0).
>    Disassembly comparison:
>    (1) delta = __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
>    228: (79) r7 = *(u64 *)(r9 +40)
>    229: (87) r7 = -r7
>    230: (db) r7 = atomic64_fetch_add((u64 *)(r9 +40), r7) //r9 may be changed
> 
>    (2) delta = __sync_fetch_and_and(&cgc->cvtime_delta, 0);
>    228: (b7) r8 = 0
>    229: (db) r8 = atomic64_xchg((u64 *)(r9 +40), r8)
> 
> 2. The bypass charging path in fcg_stopping() charges raw execution time
>    to cvtime_delta without scaling by the inverse of the cgroup hweight.
>    Since cvtime_delta is eventually applied to cgv_node->cvtime which is
>    in vtime space (weight-scaled), the bypass path should also scale by
>    FCG_HWEIGHT_ONE / hweight to match the units used by the dispatch path.
> 
> Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>

We should probably add:

Fixes: a4103eacc2ab ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")

Other than that, looks good to me:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_flatcg.bpf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index fec359581826..ffabf0d9f32e 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -256,7 +256,7 @@ static void cgrp_cap_budget(struct cgv_node *cgv_node, struct fcg_cgrp_ctx *cgc)
>  	 * and thus can't be updated and repositioned. Instead, we collect the
>  	 * vtime deltas separately and apply it asynchronously here.
>  	 */
> -	delta = __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
> +	delta = __sync_fetch_and_and(&cgc->cvtime_delta, 0);
>  	cvtime = cgv_node->cvtime + delta;
>  
>  	/*
> @@ -570,7 +570,8 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
>  	cgc = find_cgrp_ctx(cgrp);
>  	if (cgc) {
>  		__sync_fetch_and_add(&cgc->cvtime_delta,
> -				     p->se.sum_exec_runtime - taskc->bypassed_at);
> +				     (p->se.sum_exec_runtime - taskc->bypassed_at) *
> +				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
>  		taskc->bypassed_at = 0;
>  	}
>  	bpf_cgroup_release(cgrp);
> -- 
> 2.25.1
> 
