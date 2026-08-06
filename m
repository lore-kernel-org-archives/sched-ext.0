Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430E3D903B
	for <sched-ext@lists.linux.dev>; Thu,  6 Aug 2026 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001314; cv=fail; b=n3dCv3M+SUs/Xm7VdvUFjT5KX13a3P0ulVq35NVUL2aSC9iBUEHLh+byRmSuH/x946MDvB6OzHUo+mGueeX1+nSBBPen2i/eta6fA4vrjwDqU7+A5QKmY8NCZ7XyQ05ZRdCdbaHO1NsyUfD0EFSIht7FSo5g6ut8VbR4L57i4ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001314; c=relaxed/simple;
	bh=+tAOnzbzvARTdTzONa5sRu8sdGpW0PW3DFebFDoLcOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vpz0NOHGL8FVCkbskuyhldO4j9xYHn/duC8Rr+qluGB4UXsjvTVpGVVq7tY/EJAiHY+ibqdPSM2WPnEXUApQBCWXCPRBjhPN9ECuBX04pe585IXrbkXesAPTTj3JiYOz3gMuvnQThCMUsx83dBky5jgG1Zt455pu3JodFsPwudI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gFbxqujj; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gFbxqujj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwsHT+kQTFo1kguZ+e0p/bbXKEe97CCHiEKg+/5xGrNfCJJZ3B69q6zO3vwmSC9/mrg5+uzzat0iXUZUdQhWc1+rW4MFUuDtDwV0csrvqpAn7bBCD9xupGVTyHeCjtCqNO8JdPM/1LXxwlK5CjMCNbo/aFKsMZ3W8NLj85oEEmrYwUwZ/XFP6P0GUNr2/QSqLK3896xcGY+do8Q70wB9jgE0hwivUIrqLMgrl/QP2OAPPfVLWwvKElvMDcXSvlXd5SM4Nbhd2A/5SsdP1kRwbavWGofiUYyd/Yp8fvqlmxc8+o89wZSXzpRf6hHjW13fD0SjchhG6FGuJ/AP4LLjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVW+mtJ0jeiaELk6kKNNk0YHJ3Jvt7Dn9GC8PJ+8aEU=;
 b=YQJP3D/d3KOxLAbG/1imsiF4wsF3wqdcDvt+kN/aV+NDizd4jLHqptCxT0LWZgKNn+MqR0vaVHIm+3CIef1YRTZ3mvgzJenuKM+d5IpiVtHaaX8eY+0Xbw48lxHvHjSc/K8s2M0s3GLPytCkeALbdR7fvPleioktMcUM9fLTb/APGhTSAZlWNHsV3x/dpOUQ1DU1v8Xk+iJl1l3/xo8tnU5f3uJuPIzMkQ5IICWOPgWiwkMaOgCRENogER4BfJUtDXbUqDR+W+4ClS+kWr+JK+9EtIuKgrYWqbZlb8wSzCPYNBgV/c6w6OYWfp2A7hRoIrHlAa8/2vk0iYYAItJOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVW+mtJ0jeiaELk6kKNNk0YHJ3Jvt7Dn9GC8PJ+8aEU=;
 b=gFbxqujjCnmXjVIQixNM/DwAzZ2zD0Ao92QSykXtZvobDqgNpB7Cq/7oOt3R5Q9kDJyGWNY9/wZVAmcYDcq2QC5wBxi4nD7PhYGH1geMuQiGV/DCgciTljr1zcC3/htQKIJiuHBSsnMNReAfhnVn7rqYxODY274kHSbPgUFDvzj/0DlPKKLHDEhozg6fyRhmkQx/zBqR7EsFR+eEHtSLTRuBIC9F2147qLyNcq5HElzwiJQXCON5s+E2A74/835ZU2Xg1lVigTfNfUERyoZNsd0zG9FcsMGSmhRTiZtEn/4aTVFf7cQCvGWuf0aNtC9tkhW5VdKVzLI4glNbfIyiyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 07:28:27 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 07:28:26 +0000
Date: Thu, 6 Aug 2026 09:28:12 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] sched_ext: scx_qmap: Add proxy execution support
Message-ID: <anQ3jK53Pb0JFoc8@gpd4>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-15-arighi@nvidia.com>
 <anEUoyw_JnTpUQZZ@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anEUoyw_JnTpUQZZ@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|IA1PR12MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: e215b176-05a1-4227-5811-08def38c4dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|56012099006|22082099003|18002099003|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	2AB+u9WWeSQRkOQLDuhNcI1HfV/QgqLeBtHb5OmPxuCYkFe+a1bSBfc6HwWS0iLoe0V1s65ny6kz/nvvwg8CY1L3dKUXNMHwBk+GiBAYPdkaVDC0CdD8p2nb/f2AxOS1BBSgxewbavsGm2pMCP+m9Vo5uE8qPo8EeoRu5d7olS0FKtQqKbZvaFj1RiMKsb0mgQSLu6UyC88+wnxroETjCwo+OTvcJlRjE9RY2fFpHW4FDg/zOK3vhh3NDCQOiZd5uCkWWc9F3RlrbR5nH8bO51mlN3T+M/+09YGf0vQZMaLDHTHuhAFQbPrtOfP9+b99MEGP1YKegvZ1SIqvhqOLqr5K35oxRY5T8lEPkw9WGn1aXeioznLu51MSlxkRR/foPtsSfrRwI/Akrrpe+Y700KxnfPC9eJsGePagaA8lJ1skglWLV4iPnOeuDRSwPPOKoEvHy8V+dY+mWtHkZ372zYeDXoOWcpuRgOrIpGx9TyMnLCxBP5PBQbgccCgXcbnAYdjmY+yJ1xvlnqUPUOYeJxVfMl69nJbEskWi+UlZ+wK8yYKAp1YSPWgAyDcif8wj+1kwqSNm8zbwUnhmilLeGkeGsaCdmrHiSktAiAtT/mrx28g8cVxmaShBTPe+uYxPSPxp/OLx6OUjqnZmlw7zL4AZXdRK8ZCrVvZ+VW+JXBs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(56012099006)(22082099003)(18002099003)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kOk53hUR8TKAM7Itg7C0VjfsewPX6WzMcE+PR8SyFKdLSG6nCSLgSxgP1Oze?=
 =?us-ascii?Q?L3nXEYS/YLIog2thav6B+0KEM8mkNy+Cy+jPo1h8Byyz4smfdsNnbnCHvZGk?=
 =?us-ascii?Q?aOIO+rXxOrgmee0UTnK7Wj/WRUPY5nyF2Ar94KOdwzpCx86w4X0UOHVD0nqV?=
 =?us-ascii?Q?4DTdj1+m07be9A8moD6lzd4HOk3ymSm64mXzqWnFgGk8uaWhNN1Xa4PDEczi?=
 =?us-ascii?Q?0rOfX7VcumHAzmiZyldrbRmqOmkTenA77DKvEZS4LwNzozGL0H0idZnsPVqn?=
 =?us-ascii?Q?ajpPz04N7+23vHKkjOdn8lbmfAxnlWfLJ+15JIB1Ra0rDm0vqa+ykrd2Owx6?=
 =?us-ascii?Q?XkuKILHysO6JQrhI+NJZkon8f14yKbyUW1D7tGJls7Y9oKt+TxuRP+ky45+M?=
 =?us-ascii?Q?f4oO4G+3mmllBHjN7cprl2W/GVaElkodKvgL1bnSYEefEjPd26Z4ED1fgvQa?=
 =?us-ascii?Q?Oc4ulH89mB74J7ckbr7A+FnGyRiD179vT6Ed2UOh9G47H1E0CD49R3yTWrmp?=
 =?us-ascii?Q?7yznCkSXGcTwGa31zF8n45FCxk965akFHM/FIyC9ycWOUOcFwBCChbqL0evT?=
 =?us-ascii?Q?sBjG9on/BX67Cps1uAR3x2a/2UeC5K72j87lds+Sp98kRapcF7t1y3CUyq90?=
 =?us-ascii?Q?tnQRWqME8l/wOGNlZnW+AY91G89AR0Otl8ibrDVughj7fEqzw2XsV27C8XVj?=
 =?us-ascii?Q?zNpISLvdCLIwTTWOLY1q31xAIUZ/96Z4BfxMMBKpE5/y0zlj5F4JtgwTgI6R?=
 =?us-ascii?Q?pt6VyFOyvu3qPofk1bjn/hkPWrl2A1khdKDQCwXRvfffSnYeeAd8kpgvf2E+?=
 =?us-ascii?Q?PQl1BNc3o0b9EPECbAZRB3lEwHm/cRl/bVGzb0rqsyKDsR5iNMYqkotMn7Xv?=
 =?us-ascii?Q?Qs6cGDIbtregAXjIvZ/04EkVbMuPZLQM8efRmYPQaupJRgu8/qBlSfEL24P6?=
 =?us-ascii?Q?sDNhsMivpZUzfiI1elY4EaS/2HD13mjavA+awehS58jdvXVEJmhGyIY0ZZJ7?=
 =?us-ascii?Q?KnWiv+vo3bMpcaoAoPLY2CCiwlylThp10LacCWpA0T5XyPG9GSB9h1JuWQ5u?=
 =?us-ascii?Q?XZPwoKCP8qumWNEkQMGnJp8VhsQp3YLnFAc6iRluig+jV2iCdd6yMDWgeqIf?=
 =?us-ascii?Q?yhROO6hFioqEKAGUv+/vsxlDa5fWaPbAsOzRDDt3NyYkuzs0NB13Qbv/sBtC?=
 =?us-ascii?Q?5722jAf2t5MMPDkShsTsJDCiLHsxaSYKrEB/ANu8TYLDVWjpLRP+58zpN+ot?=
 =?us-ascii?Q?ZgrdT7ypXMkftvLqPoRxC4ob3aejFaOej1C4Umd+1E6XTezCj9hLtKMNmMU0?=
 =?us-ascii?Q?UfBwcrOC9d/skpYiChkG8EfACP3LklBY4Sf6xM98G+7PuSWUAhnIoDxTqdFU?=
 =?us-ascii?Q?jVOykx9O+NYNquIuhuycfaoHRhK0iWg8OTuOEk+Dw9eX0lFkvXOCObkFmivr?=
 =?us-ascii?Q?Ng8FJ26JPCTr9tjxUq6HAh/QmfgZ9Vo4RYay51Njjqmro15RIr/8ur3kjhyh?=
 =?us-ascii?Q?2Ic9Pc3d1xFlNsyZ19VzlNcGNHwRup6/9QNqwAF0Bpzrenb8maLidVwjwHMW?=
 =?us-ascii?Q?nEA4dyx0+Y6XjjuqN83plnofAQ6Tm+vOguriBHTntZXM1lDKcNGRdkGFXMBt?=
 =?us-ascii?Q?qt1bJkPHTdVZw3qq4bPlGju3QjpfSEm2EvEigR4Z66JPGoLFgBkvhaqtEcao?=
 =?us-ascii?Q?BdbfWitoPKe+tQ2X3OXbOB71ARv4T0VmmeZWDA3h4p2/o6o+La5pizcfv3OG?=
 =?us-ascii?Q?/7G7P16Qeg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e215b176-05a1-4227-5811-08def38c4dff
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:28:26.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMK4/yRkGvifHtKhz5Wpt8aEERkygsAxHBULcSy/ZYwlB748Sm2b6QyTSwPfw5TrkUs4ip+Uul5/VNRIWpYGrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467

On Mon, Aug 03, 2026 at 12:22:27PM -1000, Tejun Heo wrote:
> On Tue, Jul 28, 2026 at 05:43:32PM +0200, Andrea Righi wrote:
> > +	 * A blocked donor rejected by a local DSQ must not be dispatched back
> > +	 * to the same DSQ immediately. Move it to the global DSQ so another CPU
> > +	 * can pick it up and kick an idle cid to accelerate its consumption.
> 
> My mental picture isn't complete. Can you expand on why this block is
> necessary?

This was intended to support SCX_OPS_ALWAYS_ENQ_IMMED. A blocked donor is
inserted into a local DSQ, but if the donor can't run immediately, it goes back
to ops.enqueue() when ENQ_IMMED is set. Maybe we can move this condition in the
main SCX_ENQ_REENQ block at the top (explaining this special case with proxy
exec)?

-Andrea
