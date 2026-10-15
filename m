Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0647CA7C
	for <sched-ext@lists.linux.dev>; Thu, 15 Oct 2026 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053266; cv=fail; b=fSpFsBvJO97/7vmNulaBZdr4Y/LT+F0AHalsW8sTLrxSarQFoY0PSnbHUd3u8HyFk7QcBjiWleuN8jDeoFF3IZ23lJFs7DC9x86sPF/kM2WKM/daxO3z6k5qOXyKB/WZuF8vyoXp0kBN1C++yY+rUaVDc955R+fCmPO2fjMPsIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053266; c=relaxed/simple;
	bh=IifIHba5oIts06acrICBBI8BvUKWRK88IxVjGpepD2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IT5eGzS2QPMWGvo0yTZ91fzJrt3gFWnejWT1sJ8izc2c0AoB25kc0XUGkRr8YFkiKIIV/3temIe/cop/YQYrAYzMNK7eYfS3yCRZWXOZZA4CdUNuWruRT6ILt0oY01+HaN+3FgupKSxLssd2I25X3obJ6QCfgqsBL65sLxJ7Stw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r3lnKhEw; arc=fail smtp.client-ip=52.101.46.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r3lnKhEw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYexFD/cmGfr+hwhXsWGgRwRSLtFpey83GS4Ikw5nH1eeb3qOzyslH9eDUPDsl568ngh6qo2YUSxCqNVfHglGstBERAlH/3Ip6IsLFpSYSmMy5DaQYXrXEygSutdCfSSK6eoXs/eZRq8Nc+aVLoTl9sRBRD9qNsGSXnqH3Lnz2p5RMVTBHXikUejgfHKn3EiMOLurIWGBnuEIj2cHAB1dHN1NuT7pHZIXzRyIiT2+TEmIGwz7KUdZNN4yxuue0AeaSkgWYbF/7JzZkHQSdFgUeZDKdBzjDvAlEP9/n+gc7RXZeKwciaRRWn3vvJZQU+sbg0xNNeax3wA+80NZuXHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqK4JNRQO1qVY/F84VBw33tEE7h5eWHJP1iXSmVEJLU=;
 b=vr34qknSetfGlXD3Wh7vmqbpdjcQOQQWBqX7utBX2vaCJdYmhKvKeqAgE9kf3RIZxz+amxdUltOY/1WmfU725uNA57LlSDWHP+xXO+KvN/62YsMI/HfpLatzEpSwATO4kG0JGzxf4gVOroOwrMYYzaphVnAxPlM01vo+pr9OuufoODaApUAtW58SwyiP7LvJtApz192RxpjdcB61p0a6zQ2aA0/O4MhhBOQUkQhk39XTv1th+/lIByYAS74w+0kPv6tLou3oSz2Q6y6jVkOVhKuCTmi7kxNb067VUVmXZlVZCcixC7vc1WJditZg3Xe1Y/MPN8s08tA/azIbKOBvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqK4JNRQO1qVY/F84VBw33tEE7h5eWHJP1iXSmVEJLU=;
 b=r3lnKhEwctvKYWj2GZ+SJRWjh1YtBIMxjIK+Axd2Ve4OW+Xov00RmUhYW/llEFJduFaJ/P5ajU3sGFEOXHgsX9+a+acGzaR+f436Zf5XbaqX+PHkEE2P+nL0ilJCoLLV7lsLv+naLSz2Gs/kZDNXe2fMxwazb3w55MK/0H1jLXEw85dC6dIBuwctz3x2bxzc4QHw1XOWsGiKcqE/oI6fiW7FTVCgUj4n2lir+oYIG5YeA+cKrdSyER6YRdXG60jERbDmquvYaTeGHNCn+Etp+iKwAwwkL2DxaMAcqkAJCzdwShyQxl0I/LH1f04oxL9nVcgrvLsyxg42OQSxFOeqqQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DSVPR12MB999193.namprd12.prod.outlook.com (2603:10b6:8:496::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 08:34:22 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 08:34:22 +0000
Date: Thu, 15 Oct 2026 10:34:15 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.4] sched_ext: Keep proxy donors with
 slice left on the local DSQ
Message-ID: <atCQB_nF5di8pgUN@gpd4>
References: <20261010090621.184717-1-arighi@nvidia.com>
 <5b3d2c576222c62738b7006d85f96a23@kernel.org>
 <1548cc9309a6e0894e358262e0b3d4ee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548cc9309a6e0894e358262e0b3d4ee@kernel.org>
X-ClientProxiedBy: ZR0P278CA0136.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::15) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DSVPR12MB999193:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c7933f-594a-4eb2-e712-08df2a971c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	bp5qSkA4+39onpk6a9Fq1OVsoOmHP7vEu6TIQ2OfZhuws82raaMcuHeRpdHVXC+M5aSfhJv42D7pT+pkRwmu4nisXIlbWo70cZd0aXdjlkhsvf24OogUxrqZ3Ys/VQb7NFKz1Gyr7uSwraWySdzaVItvnp7pa/wdA+WjrJE7Tkgcyj4yrF8tP7StMDb90X2nz/JDB4U7DNPiZ3wsroSQ5LgT3sKHwEdGJHuE5Xiyg/oJXyHpTEFm0guT5Y2LWeOAUzcQUKXgta520eLM5ZUl68uUe9cQ7WK2BTenB2J8lR2wN/NgEGJNKYGEhEw9QAD6ulXfgTeTiHpK+T93h2j6oiDzX05OqjO2uo15Hy6RyOoeu4Uv/D+Qjk3eHj1Q0ckDnUiqqH1NBVlYOTQYbOoNEyj5FzuhNrtOv3SyAlPhuY9UxB4nfX0TKck2xEcLqpagaQOFGFVsPIL0SwYEpz+EsU4hWckyvTw8f7ouskX9oGoulLZu35yNuCuERJD1dMy3IEbCDqIVHmcUmCPmRcM5fa7bqxOmwso3143HD2hbBqkIbbXugWTXIiUzphw692vulAGm5+wY/tOLKl/g5bzV5Cg95GoHUu/N1JElSYHv+k+W8JWc/HxZDIhup34Y2j7rQgzkaCWirqXPXiOpIlXUGnSUj9GUqB1dUBKdAZgT/Vo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?02b4/i9B6r0m1s1Vka6n63oK8TZvI/cTAi/AONRkQsTW4xW3+lKHSahUIucu?=
 =?us-ascii?Q?p6Lv9gAIVoVerVuR+kCrGHPGSxjWw/3xF6SirT1y2Ik3kCQPKZ8uaQ62tiZb?=
 =?us-ascii?Q?2TKNE6U6pNWTLUUPoo4bb5CN2z9bdyb38f1uSlFTobY5tCf0S7EvAFChNfKq?=
 =?us-ascii?Q?v/FdIOKcoQnYpklc9rSMkQcsnV1G/WxxIGWQ5gQBQsZ3LavS3/8ZqaE2iWEB?=
 =?us-ascii?Q?cILn4R+lQn/hjYvavuOl0pCORPULMD9LFZ3lK0ji0Gsj4UnzOPVUu3Ub69vs?=
 =?us-ascii?Q?YhbIRtRrQQmchDGSxFJCUbxZZwWX+6lr6NfmXMTFpTSy8pBXvEmtTpPLZ28a?=
 =?us-ascii?Q?u2X+Utt+zd9LAvt3aVSedf9qfyfdTa+9PxZktfkngq5San0oPVKMHUCj8ZUW?=
 =?us-ascii?Q?3GRPzAx8H+EnEznO8yVmaUrxZLWCLM2zijAf+1X8LBTHZWBD+oHGOtnorwup?=
 =?us-ascii?Q?MykfDQls7ZOWo+cukPwZhbN3EiyD19S4/S8rvvK47PMzSvrTkoF65WqCwMcg?=
 =?us-ascii?Q?bObl+p/8tg7+ZnRNP3TQ9O9BLg4PbXioRjWCInXMiq/ySX4jGvznmeurhKWL?=
 =?us-ascii?Q?+HgqgQ2/p/Z6laXFoJJIPyshv3mIcXQmqfaoX0ljvnpyCxfyxh1XnBTl4+wr?=
 =?us-ascii?Q?Hk/T8Dq9rdhvlVcxqU/s7A07zjVfrv000ZQvHqLiDCBBdzHIinBPDpi9F1AA?=
 =?us-ascii?Q?ftQpNk6ZIUVPLrvitBciBVuNemsdFVzFeQ8x0sW7l2p/qeRm1HEkhSX+g0GJ?=
 =?us-ascii?Q?cr4438RBeZIj1A5cNBsVYL+69mxJomYzstZFu3GoMXSyWkwrqak9Oux+KKiQ?=
 =?us-ascii?Q?hbgNxIYN/dmmQCTD7H0y6grRv9ZL3l17H2VCOmUnOL2PObnamNqzi9mIfckf?=
 =?us-ascii?Q?t1URwShG2cwaU/DgDXhbt6VCgUMM6NuI2bbCYiRmmncH3zI0UvhDCl1s8EWO?=
 =?us-ascii?Q?MqsugDPLQKe85xQ05CoFXXZbza3axXKGkiQPE9dPfn/64FgsALx1TQGDJXtP?=
 =?us-ascii?Q?n7j5GgqesmJvc4yqrpaXgOYSQbxh3uOq6KRxewEnFcxBdUJiOHJp5lCELVWT?=
 =?us-ascii?Q?lrlVMZHIkKCB9fIPh1sMIdvidIjKmvz8Ijb7wGUMAVR/UDSjRGV/YDEGo/Cq?=
 =?us-ascii?Q?qpxfAnDfAIUApNvCZOzs8TZLYOP0Z3IH6ePFfPn1rXUT7kdCQbgC2kJJBFOW?=
 =?us-ascii?Q?JQWUSp0T5lTFoowXE48dLzWAtfYKAprP3pND0YEjwesWSxldo7GvZw1vZanr?=
 =?us-ascii?Q?VxUANRQRyxKhl2DIvK1oruKppWLqRBBPLvsRm9iLLfCkcsA+zIHxmTbixCQS?=
 =?us-ascii?Q?SudIIq0wxl1/yhDyotnoP7Gi6sAnuXnzBsRBD7ZpqTS/SoU8uW6vtSu44Azh?=
 =?us-ascii?Q?BvoIg+l4e4RDEztTdyK2xcPR94qYNpCbEff4X2iqVfNrELTegn4+TGjDC+XA?=
 =?us-ascii?Q?9qxci6yTlk0ueC9ggY/Pe5JMluK+wOsm3gbNLLqj9suI80fRmegbnVEW2uaX?=
 =?us-ascii?Q?SahrJOiNKQCsJ0w6TnewX+ajBXZPePW8wqtE2Cj4USPdw7S2xHWUOy7s7M9F?=
 =?us-ascii?Q?vD+5s2/OCoeGKelDFZbQiZUjgHMxGbf65tUILzPdeLtc2NBqO1F/aFddlRzN?=
 =?us-ascii?Q?MpUoHJM4p51d1jdyoD18sJ106MLSHQ/oKILlziOjqEEeb7oN9s7x4VnAgMja?=
 =?us-ascii?Q?jt95/Immspo1pexBRHTYOvUVW8aHxjjPwdre9OlfG92rITUI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c7933f-594a-4eb2-e712-08df2a971c96
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:34:22.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSzSE4M6lfcI1g+mivL6ft3aPDRy/0s3iNbb5kNKOh7fr2FYNwSzj2XelhH2/6FFyJDveEAqYNvaniYtkgubLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999193

Hi Tejun,

thanks for taking a look at this! I investigated both cases with a reproducer in
virtme-ng. Your second finding is reproducible, the first remains a plausible
path, but I haven't reproduced it yet.

On Wed, Oct 14, 2026 at 12:10:44PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> The following is a Claude-generated review.
> 
> Two issues found while going through the patch. Both are from reading
> the code and neither has been reproduced.
> 
> SCX_RQ_PROXY_PENDING can stay set into a core-sched forced idle:
> 
> 1. A blocked donor is picked and set_next_task_scx() sets the flag.
> 
> 2. find_proxy_task() returns NULL without putting the donor because
>    blocked_on changed or the owner moved, and __schedule() goes to
>    pick_again.
> 
> 3. On the core-sched path, a fair or RT task wins pick_task() on this
>    rq, so pick_task_scx() does not run and the flag is not cleared.
> 
> 4. The cookie does not match and the CPU is forced idle.
>    put_prev_set_next_task(rq, donor, idle) sees the flag and
>    put_prev_task_scx() takes it as a bookkeeping put.

I was able to force the abandoned-pick path, but I haven't observed it continue
into the false bookkeeping put. Looking at the code it seems legit and the flag
can be stale on that path.

I think we can safeguard put_prev_task_scx() by treating the put as a proxy put
only if the donor's cookie also matches the CPU and a cookie mismatch takes the
ordinary forced-idle path.

> 
> An IMMED donor then stays on the local DSQ through the forced idle, and
> a donor without slice goes to ops.enqueue() without SCX_ENQ_LAST. Maybe
> clear the flag when find_proxy_task() abandons the pick?
> 
> On an IMMED bookkeeping put, the local DSQ insert always queues a reenq
> scan from dsq_inc_nr(). rq->next_class is still ext there, as
> proxy_resched_idle() lowers it to idle only after the put, so
> rq_is_open() is false. The scan is a no-op once the CPU is in idle.
> 
> However, if an SCX task wakes up on the CPU before the scan runs, the
> wakeup raises rq->next_class back to ext and task_woken_scx() runs the
> pending scan, which sees the rq closed and sends the donor back to BPF.
> That is the ops.enqueue() round trip the patch is meant to remove. Can
> you take a look?

I was able to reproduce this one. In a baseline run, I counted 174 across 2000
measured mutex trials.

I have a local prototype that sets a flag (SCX_TASK_DSQ_PROXY_IDLE) in
p->scx.dsq_flags for the donor, when a proxy put parks it on the local DSQ and
clears the flag when the task leaves the DSQ. When the rq donor is idle,
rq_is_open() checks for that flag on the task at the DSQ head and also checks
its core-scheduling cookie. This prevents the pending scan from sending that
donor back to BPF. It's yet another flag, I know..., but in this way everything
is self contained in ext.c.

The prototype passed the reproducer in virtme-ng with zero blocked IMMED
reenqueues across the 2000 measured trials in all configurations: same-CPU and
cross-CPU owners, with/without SCX_OPS_ENQ_BLOCKED.

I'll do more testing and send a follow-up fix.

Thanks,
-Andrea
