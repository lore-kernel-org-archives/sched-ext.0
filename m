Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793129326;
	b=HuLFTqWJmG5Wxo1TswWT78iOTCVfPnEN18NGgYBxESm9IVilgW3KDehrb5zAMbN06cMk
	 Kx1hENLE9gpPLt4FW8ZWIkezEQsM60xbwlpI+B+z+Qjz+9q367AZwM8zXKmPZqvfHNY0/
	 SK17OaD8pcOAqb2sup6+P5inp+dqs1mRi0pols8xWoxXFgKzFDiEHuM6/mlr2+OBG/TWq
	 CE4KHCFmjTLgXmxFqfrrwFJoTC7ZHaWiFtPIHtuKxWGv69QlVClkq9U5ir7vAAvSw7YaU
	 2p3fHAB8MeQ+Mlo04l3BjdJ2mLIBBhjCR9zAk1N2iAaASUQ5jS41R8VRdcmDOnWueRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129326;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8/caUTX58zWDCglDB4RIwauzKmFBtvDPs5tNC2GePwE=;
	b=voisES+wCwLhbRRqIEy8Z8bSL2kV04xN+6IovlpzjshmQ1BMpHC2O1UcShRjoceouzSM
	 jfNUe5n+TbKW7bn69PHcFFyKg0PS86B9EOVCSC2eeJQQKUVVYBt4ntWUHo11+eUoJCXhx
	 OrAhdON8Q24qRn9v1lKnACCq8F8P/+3D1KcVSgUgpwdQvhamgrJMpj9jWR5cS/7rA4Moa
	 MVW3w4lxr8nHhvSv9UBk5Bd5RYHYTPv7EGQjCVpesPGfoE+NL0hSngoAaXKh9UE7LDv+a
	 XdehM+0AFZJXlNvs8coBhhqsNuf9YDNlCjMLVjitoMK8HS9MYRvUXr8LdgasvY2ql7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hNHGjufq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.57
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D2606A329
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 19:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A0D2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hNHGjufq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dahVSYxhbPxPjeS+vdgz3JssZcQkATbRsHSmyMUk413oaMFRKRko1yJWsjQ4uLdwXLtdUztWeFj//VItt2QQMV9ThVm3tFVnaoduGIzxQmeSxs8bl7GxWwJCD+/Q8cc6EYdWDKJPKuWoN1tiqafVojzMcv7VK8z8cPBXWyiu/hobcrK13ZZcsKKINpkJbpT+rj40fp5gsqu+FhDPTGEJjQ/N66O8UPgEXZNWkPwHhOXFG9lWRIt1hnioCaJSzqz9UuSgv6juaijnWp/javjDD+Y5a2A5htEzalxU5goS6bxnme8gk7zg7jFdgA+GU+HqwmC/cYsOXccIIv+PDgW0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/caUTX58zWDCglDB4RIwauzKmFBtvDPs5tNC2GePwE=;
 b=w4vzC7KDO0iV/LK7kXAPdxlAqxxppZO4rGyBI6j2bBvg4LHhJUi8M71Eatyc2vztGJ3cexzd7pFZooX4g79H8F6qM+T+oKuxjMzeyhFZRAr/BEP/g5A4nY/jVmwr4kABBzn+DIWMsf/Ey4Z065ZySil0dJP4DSClu8YgRMaKdc25W4c1P6/AkxOtL1Pzx/OEhaL/tkjqz/sTRd25tLlpQkZj9zUxZzjngUHj1s3/usKkf20i+oqtifH61T+M/rh6KDHyTyra4KnUbbWi8XAiTDcBrZNKz4yTOQc+SiAqbguHRDXX3Dmy2/XI0JGT+3xhZky1A8gsEKbeTre/4HJa8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/caUTX58zWDCglDB4RIwauzKmFBtvDPs5tNC2GePwE=;
 b=hNHGjufql4zhQ0UJIjes8MkYfo8ldkvFVr/UQDl9Aj+wff7Nq8rfd7vy78brSC0C7zO2jcBEd9IR+vpfq/mY1wKmHLMdTCo9msLaVRU9NGTK1Wg1RcdkLM2lW3oF3T3VPZfezmbamyRM8wfMub8ptWF1to4I5vY6Tuf1njShdJCITXk/HecWF9B/mgkWRp/s2Jt9rE6zpMP/ItyGQ8/exvhhYhxtL/77HhU1BTrK2PxByjbTl7OfMcckjhmNCQTecXf8y57ztHWc9fHgU1WcIaY7VYvClwlJTOb5SDx81xZBGFqQIV95GRDMen2R9Q5lEWOhs3IvLpUN1VxXuZHPuA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:28:42 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 19:28:41 +0000
Date: Tue, 27 Oct 2026 20:28:30 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v4 sched_ext/for-7.4-fixes] sched_ext: Fix bypassed
 sub-scheduler tasks stalling when the host lacks caps
Message-ID: <auD7Xv01uNLBEhyF@gpd4>
References: <20261027001749.1821379-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0149.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::11) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d1aeb4-3295-4038-c22f-08df346081e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|6133799003|261026121527099003|56012099006|11063799006|10067099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	WdrirTlONy+m3woOJj72EAS6Hvpamf3jyRd42bnCZzHZzorDAuVX9HuQZY3H8DGCoCx/leEKBLx+FYlkUWbhxVFEuNFuTN1tBYjk90y8fWvYNjfUNGH11CNdrWDkKHBDfzU4B3efpr891Me4TXej16X8fX+x4kEUpvSS0XW/cg3ZPjGYv/+tnhqEn/umPqYZ0L71F3RODuCheM3Z2NdVVRKtFtM8QKHehw5XDxTA9OZqRKQ2Qw13FSAK/CpEKg9PYizhqx6QaURoa9zLvt/Akah3kc5fCKfDx8a8JtZRyQHaMIk8fw4UT5ghqkQkTMTrnOSN2/zZNdW3HfAl5VueAP4Q11s36h/pIfUzsM000Ot+14H1U3GC11h1kADyCjEi827NiFgJiBiXfpJ2DrLsqynJOpdtpPCaodRjmDazlNML+JgQ4hwpq7/9XjhWyCSxAM3oIumnnblt7oBTaipB6tekJ68uqtYpWc6Lq72V8uaTdlOSXQArwgmh8bhVpEGGeB7ytIRE5Oa0+rgo3JGQFbLPTV0inYbI2zK756TifrRBFXSna1RknwNPnWLnXYVF7ekkmOk8Ux9PtTYaOMiNsh/b9CQx34+Em4yECVoW2z+AUMD4NIAkXcgMv+TvYUGw/dIz5J93+LH59fFqz6fZC7+qsmdhZnmXAxnsTKfX1G0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(261026121527099003)(56012099006)(11063799006)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7EV1kQkPNny1E8eA/96cfVU9sM/Ti1sJEfzVRxNL+YhnAsdtgpKIZ01Mxc+B?=
 =?us-ascii?Q?ub5Qb4HW7dyaj+luuOSP6fzJZ48Y+9yOsA+2Nx7l6pnydNVWlJ/uWV2pGOvP?=
 =?us-ascii?Q?dlLefTi9sfRUV7SruPP7ty4XyhkJ3+OhLHgMH0c1HoiQiHo16jyHaZIPwo2W?=
 =?us-ascii?Q?OvKnEtqbTb35USuq/rdXxRIG4GZddFMnzageF7wkBiMyVZa2enmCn/FyxLfg?=
 =?us-ascii?Q?HnBq/NAJubfRnAaJ/t/o92asnSrxRRQIIabUbovhx7ld8ZL8BVTsxNofschz?=
 =?us-ascii?Q?WqYE0DRFdtdUFVLDkBq3lCmw4o/2z9nahTzD26TKdNclxK0/C7qBkKGg2ZH0?=
 =?us-ascii?Q?fTKlZ5LzgNF96SXQeRYTQFZ7ZL3ENSgCYcf2qISK6m7fRXrxeHg0YB6hThUr?=
 =?us-ascii?Q?f+ed0/LCCEUT5lJIUcDumLOS3/ErNpzJrhy+QsHT1e6eF7NYFB4B7SvExBVA?=
 =?us-ascii?Q?XEoSw6vL2yPa1JFzGyav92mJ0yZJ51c9aVZmx9woCJYlkSnT90o4CUkOA9xe?=
 =?us-ascii?Q?I7LOwMukl1kajoCq3fpFyX4nwOHbPoePOISA7pftrmvjsW6P0tERqRpt97rP?=
 =?us-ascii?Q?lngHq6O3l5ao2QDM/2XnaNJokFYez6c1/VqQIL8t7LWDu/1zBsupmVH0o2Oo?=
 =?us-ascii?Q?WSJvuExXn5J3bH7ew6m6K67c3KwTvTas77X9I5DHRLIDYbVXL068GjuwTxFX?=
 =?us-ascii?Q?t+JT9kkuQKp4q9U72RAHL4JoxRhRf5f7ygzSrBDxWq9uXfugFj3SsxdVvAdy?=
 =?us-ascii?Q?OhIwBkPIY58VQsD+xyEu2mdP7TN4KYp5qMPaNMzkCEAoBK+tH/Db8LMyh/B7?=
 =?us-ascii?Q?KpvwboBdc02bvz6ZMZYbPj8wImdQJdIeFP2yWxeh7Ixyy436pNJyJMoi5oFM?=
 =?us-ascii?Q?XzMVwG+94eMZQkkG99EfSS8HTzH1KLMKx82kLO83lzHwThg03IP+of/cEMQt?=
 =?us-ascii?Q?uVd39wg+mUyEdkC7LvNTfb1UV3cc10P0qda6ahd8Wv4YzmfikUdIQamL0OK0?=
 =?us-ascii?Q?6fDtro+BhtQmy2wUeSh40ZpQAPpXMd0gLOqT8HhtDXzmAtb7I6P9u5IBE8uz?=
 =?us-ascii?Q?ot3ea/Dq9KnL685XTLc/blvDdWe/WV0KFwUz6BFKxrXo3PkPtPjVeb4gNOoZ?=
 =?us-ascii?Q?9zJjghC8dEljQldupIxlyopNnT/wkVsTowznErtJ36fpx5YudrhhWqv+nSGY?=
 =?us-ascii?Q?Voqcy8MVZ7Tjypxr0t38Na1atG51C8TdGGHLY7kFiLzaNUNsKDjy4nDUrbks?=
 =?us-ascii?Q?vnatPSyTkG+QEABUCQAkx4Fuzc3LMfG0aY4U28M5diHX9E0dC1+VIvi93C4R?=
 =?us-ascii?Q?XIow1oiJhPeb1duwQ3sAwZChcBxGQHMctpxVuGWqstN9FND/YTDm/H+YqwdI?=
 =?us-ascii?Q?RwJGX61hhNlLrOAwBvOzoozRuUh9A+hPjrb+8SlLQ+yAvv+cg+0xbyjCNncI?=
 =?us-ascii?Q?urFLpxTDRyWrsOYr1ubusffYm/cCniA3sEdk8EiVsYKfsKcUQV0rtSHISYoG?=
 =?us-ascii?Q?vJ7tqgvZ2uRawbGQslI+FJDUfG6nmGuz5+76bKe1a3blMbzyj/yGshcBfsME?=
 =?us-ascii?Q?jV80ympUunFe4hSKmkzPZhlbVS2XdDi1UJ0zE2vuVawfiAIcFH2uiJauK6Dc?=
 =?us-ascii?Q?vdmp1QlesnUNBenSWx6R6hkGF+u3yg8JBnTPqy+92LgvA/4wPlfdbR0Amdkw?=
 =?us-ascii?Q?SgcQaS/R/Ybcs7H/WHlstX4KAo+xmFInv+Mzn5W0wjZ0u5nvbjK6cLb3dmAz?=
 =?us-ascii?Q?mQxdAyxYTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d1aeb4-3295-4038-c22f-08df346081e3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:28:41.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XJC4mB01OK9c1gtSGewFy4TUFM+mfB+x/txHqfQv788ZNz2ncwcwAyFwwuvOYPetzqAonc2LuB5CSmUijPNAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094

Hi Tejun,

On Mon, Oct 26, 2026 at 02:17:31PM -1000, Tejun Heo wrote:
> Hello,
> 
> v4 (rebased onto for-7.4-fixes, the stall watchdog fix posted separately):
> - Rebase onto sched_ext/for-7.4-fixes, as for-7.4 is in mainline.
> - Depends on "sched_ext: Fix the stall watchdog testing and blaming the
>   wrong sched under bypass", posted separately for sched_ext/for-7.4-fixes:
>   https://lore.kernel.org/r/20261026204300.3618150-1-tj@kernel.org
>   It replaces v3's 19/17 (the stall watchdog blaming a bypassing owner),
>   which is dropped: the watchdog now blames the sched running the task and
>   tests that sched's timeout (Andrea, sashiko).
> - Fold v3's 18/17, a NONE rescuee leaving sched_ext with rescue.curr
>   dangling, into #13, which introduces the bug (sashiko).
> - Add v3's 20/17, a lone IMMED task waiting behind a kept prev, as #18
>   (sashiko).
> - Skip a task the donee would refuse on a balancing donor instead of
>   reenqueueing it at home, where it went to the tail of its own DSQ on every
>   pass (#17, Andrea). Correct its kerneldoc and condense its description.
> - Update descriptions and comments (#3, #13, #18).
> 
> v3 (uncounted reenqueues under bypass, served time from the charge):
> - Add a patch testing bypass before the reenqueue count in
>   scx_do_enqueue_task(). A bypassing scheduler's reenqueues are the kernel's
>   placements, and counting them could strand a bypassed task and deadlock
>   the disable, which relies on bypass keeping every task running (#3,
>   sashiko).
> - Add a patch counting rescue served time from the charged runtime. The
>   rescuee's sum_exec_runtime follows the mutex owner under proxy execution
>   while the slice follows the donor, so the two disagreed in both
>   directions. scx_rescue_keep() now WARNs and ends the rescue if its restore
>   is refused (#6, sashiko).
> - With rescue disabled, admit a migration-disabled or migration-pending task
>   to the local DSQ on a cpu where the host lacks BASE instead of leaving it
>   on the unconsumed bypass DSQ (#13).
> - Update descriptions and comments, among them #17's rescue-off and
>   zero-interval cases (#4, #7, #9, #10, #11, #16, #17).
> 
> v2 (keep a bypassed rescuee in dispatch_one()):
> - Add a patch expiring a bypassing prev's slice in dispatch_one() before
>   its keep test and dropping the bypass test from it. A bypassed rescuee
>   now keeps the cpu on its kernel slice and scx_dispatch_sched()'s
>   post-dispatch test no longer keeps a prev that dispatch_one() declined
>   (#10, sashiko).
> - Cover a rescuee that passes the keep-last test in the dispatch_one()
>   comment and description (#6, sashiko).
> - Update the descriptions and correct the refusal causes listed in #15
>   (#11, #15).
> 
> v3: https://lore.kernel.org/r/20261023175608.4120910-1-tj@kernel.org
> v2: https://lore.kernel.org/r/20261023052452.2889061-1-tj@kernel.org
> v1: https://lore.kernel.org/r/20261022213836.2259069-1-tj@kernel.org
> 
> A bypassing sub-scheduler's tasks run through the per-cpu bypass DSQs of
> its host, the nearest ancestor that is not bypassing. Caps are per cpu, and
> a cpu's dispatch descends into a scheduler only where it holds
> SCX_CAP_BASE, so a bypass DSQ on a cpu where the host lacks BASE is never
> consumed. Bypass placement and the bypass load balancer ignored that. A
> bypassed task could be queued or moved onto such a cpu and sit there until
> the host regained the cap or the bypass window ended, and a host holding
> BASE but not ENQ looped a bypassed task between its bypass DSQ and the
> reject drain instead of running it.
> 
> The fixes make SCX_CAP_BASE the one cap a bypassed task needs and keep
> bypassed tasks off the cpus where the host lacks it. A bypass consume puts
> the task on the cpu being dispatched for, to run right away, which is what
> BASE grants. Where the host lacks BASE on a task's cpu, the task runs under
> rescue at bounded bandwidth instead of waiting for a dispatch that can't
> reach it. The bypass load balancer spreads tasks over the cpus where the
> host holds BASE only, and when the host loses BASE on a cpu it drains that
> cpu's bypass DSQ to the cpus that can still run the tasks, or sends them
> home to be placed again.
> 
> Running bypassed tasks under rescue leans on the rescue slice harder than
> before and exposed gaps there: a cpu could go idle with a runnable rescuee
> queued on it, the kernel's own slice writes under bypass served the grant a
> tick at a time, and a scheduler could extend the grant past the rescue's
> bandwidth. The grant is now a kernel-owned slice that the kernel's slice
> housekeeping leaves alone and schedulers can shorten but not extend, and a
> cpu no longer idles over a runnable rescuee.
> 
> Tested with a three-level hierarchy cycling bypass under pinned spinners,
> fork and context-switch storms, with caps revoked under queued tasks. The
> balancer's remote move and the drain were exercised, and the holding_cpu
> handshake, the cap-revoke placement and the rescue keep were model checked
> for small cpu counts.
> 
> Based on sched_ext/for-7.4-fixes (651694bc47a1) with the stall watchdog fix
> above applied.

For the whole series:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> This patchset contains the following 18 patches.
> 
>  0001 sched_ext: Pack scx_ent_flags' multi-bit fields at the top
>  0002 sched_ext: Clear holding_cpu where the claim is confirmed
>  0003 sched_ext: Fix bypassed tasks stranded by the reenqueue limit
>  0004 sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
>  0005 sched_ext: Move refill_task_slice_dfl() below apply_slice_vtime()
>  0006 sched_ext: Fix rescue served time disagreeing with the slice under proxy execution
>  0007 sched_ext: Restore a rescuee's slice after ops.stopping()
>  0008 sched_ext: Fix a cpu idling with a runnable rescuee
>  0009 sched_ext: Mark the rescue grant as a kernel slice with SCX_TASK_KERNEL_SLICE
>  0010 sched_ext: Refuse extending a kernel slice
>  0011 sched_ext: Fix a cpu idling after put_prev_task_scx() queues its task on the local DSQ
>  0012 sched_ext: Expire prev's slice in dispatch_one() under bypass
>  0013 sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE
>  0014 sched_ext: Fix the bypass load balancer stranding tasks on cpus where the host lacks SCX_CAP_BASE
>  0015 sched_ext: Factor out bypass_lb_move() and insert with the donor DSQ unlocked
>  0016 sched_ext: Let the bypass load balancer move tasks homed on other cpus
>  0017 sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_BASE
>  0018 sched_ext: Fix a lone IMMED task waiting behind a kept prev
> 
> The patches are organized as follows:
> 
> - 0001-0002 prepare: pack scx_ent_flags' multi-bit fields at the top so that
>   the single-bit flags stay contiguous, and clear holding_cpu where the
>   claim is confirmed.
> - 0003 keeps a bypassing scheduler's reenqueues out of the reenqueue limit,
>   as the kernel places its tasks and a strand under bypass can deadlock the
>   disable.
> - 0004 consumes bypass DSQs with SCX_ENQ_IMMED, so that a host with BASE but
>   not ENQ runs its bypassed tasks instead of looping them.
> - 0005-0010 fix the rescue slice handling that bypassed tasks under rescue
>   depend on: count served time from the charge, restore the remainder after
>   ops.stopping(), keep a cpu from idling with a runnable rescuee, mark the
>   grant as a kernel slice that the kernel's slice writes leave alone, and
>   refuse extending it.
> - 0011 reschedules a cpu after put_prev_task_scx() queues its task on the
>   local DSQ through the plain insert too.
> - 0012 expires a bypassing prev's slice in dispatch_one() before its keep
>   test instead of refusing to keep it, so a bypassed rescuee keeps the cpu
>   on its kernel slice and the post-dispatch test can't keep a declined prev.
> - 0013 sends a bypassed task to rescue when the host lacks BASE on its cpu.
> - 0014-0017 make the bypass load balancer cap-aware: capacity and donees
>   from BASE cpus only, a factored-out move that inserts with the donor DSQ
>   unlocked, moves of tasks homed on other cpus, and the drain of a cpu's
>   bypass DSQ when the host loses BASE there.
> - 0018 schedules the IMMED reenqueue in dispatch_one() when dispatch keeps
>   prev, so that a lone IMMED task queued during the dispatch doesn't wait
>   behind prev.
> 
> The patchset is also available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git bypass-caps-v4
> 
> diffstat follows. Thanks.
> 
>  include/linux/sched/ext.h                       |  22 +-
>  kernel/sched/ext/ext.c                          | 603 +++++++++++++++++-------
>  kernel/sched/ext/inlines.h                      |  15 +-
>  kernel/sched/ext/internal.h                     |  22 +-
>  kernel/sched/ext/sub.c                          |  80 ++--
>  kernel/sched/ext/sub.h                          |  16 +
>  kernel/sched/sched.h                            |   2 +-
>  tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
>  tools/sched_ext/include/scx/enums_abi.autogen.h |  29 +-
>  9 files changed, 569 insertions(+), 221 deletions(-)
> 
> --
> tejun
