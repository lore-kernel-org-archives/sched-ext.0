Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793433502;
	b=ULLOdueKfG5PwybRxY3dL8wKYe6MLDwyXwKwTLS8Zz1CjGDupRo7xZpjubZvN3Z2VqZ+
	 4vG+Mcr2w0rREfyfKx329U2PtRU+yN/v42yy+vPEMpGlEa81rjUeKYgbx6T3qAi0E4DTx
	 XeV2+eLtutyY5DlnISFk1vgsEHTRpnJEhj+Edg6vUmcUGC4K7uu7LNcG6QXKfYocFNtyy
	 9d73UI9Ac+NeyjstwYP3K70dMZhk1+79I+h5+f/D1bKGf8C7PQb9RGCCYSf/B6xNTmvVB
	 NQZXl5RsqzpPw7TB2CZn1o9RSvfZdhm2QqnG2+vWCzmLKqokkzifUskm1Vw4QIHuJcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433502;
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
	bh=MNgVwV2x22ON2fi1bjk8Uji88lI3i0V2Wht/E/F0f7w=;
	b=Ne4MCrffVLN0NdbaTjnqeYyS4HX3jzeb/6Tbj+LyBWzTPWTxCIxwUZ8EYzrGwFl/XIbS
	 iwbJBxNmw/FbkpHCz8Y6u84tpMU4PbGEt8eN669jWMRFpe5XyC6OGi/bHcF0WTkNGcx3h
	 SGaiGb8XechTCqeRzbkSw/7dNZyAyyivIFVv99dTtxiPoR47hb0ZXUmnyQmkvCi0TM8cM
	 OFFQWy+hdlRQ36TE0jFfbylSZRotDKd4AdxBCoamYyCK7mF6tC9lrop0DU7UgYWR9rk6N
	 pgyhLM2p2PjmjNiO18NUWvYuF1XKMKmSQ9qGpJ2jBXvwpf9I8WaCtdLggzA7dbwr1DQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y8QkdOgd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.2
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604B606A31A
	for <sched-ext@lists.linux.dev>; Sat, 31 Oct 2026 07:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D604B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y8QkdOgd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmztaCeC6araaXcZMdy5f7SArvk8q+7XK4lUgCJhr9Eus8oDcdEz0vDRSQTBaI1SwilK01zSsVMRQasAN0cqC6A66Y5AZAGZktXIlS/fWLL+Z0FFqSXLreKTCsViVozQ/junVpfsdPkC4mXzpRwJvWkGHWKD+0F73SxV5NOyXZuKuXMMDKeIj8PuhjSViNXZWWmhx7L96esUi8qTC7ElkI6ki+KSTx9M/Oi8EkhSGkTkg2H/BoO+kuSFZ0OL5VaW+tpjTZ/700ssjaNTBPXKWKaLYZnAoIWolqQBvUbJE8DmTXC+nrD3Wl0PbFMJLGet3wgH1YBw3pNo2opcVtm9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNgVwV2x22ON2fi1bjk8Uji88lI3i0V2Wht/E/F0f7w=;
 b=iDRdYG+uxk/d+YHvIW18QXz7asIlLrAbhw18blbsTCrO7doY9T0K1H6CiGg2BJKIrSfOe8bTsubeIa40I4I9tB6PtyaEb+yi2/9dopDcD6h5Y+Eo1IksDsC7ic4TYZtrtbC4MhGcu6vYsB0SeBL/1A3nOYcWHh8+GiQPg/aDU6dZiKPobx9pNaNcDF+mth1umKOsPrdjTSIKbQEi8dLbYmSYVFl29J8A4uH+Zj7w8d0pFB3WFM+oQEfxMD1tTAmmV2TkY008dXhTCCJuk7G+93KW7UCZFluQ9UvbT69VUIcCxDdbEeka71/Syo/CVoXWpDmZITREjDF/ano/SZ2ccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNgVwV2x22ON2fi1bjk8Uji88lI3i0V2Wht/E/F0f7w=;
 b=Y8QkdOgdIyzTbUQ4tmZ/xN+QgR0eEi8x4eKNeS/p9JKFbypfPPW3EyFMyl4c8yLK9/RRtpCbEPzEEW+EKkoAJIZZzyjzag12GHHMhocjZIEG15m93g//wSmWggR1dKySviqCAKjaDMJzRsb4kYj45jd3ssXvJe7VOnUq4qpTPB7Prf6rIdtupIThT1kl0Ifm5grXvKJNYQiSEwn5aEblUVdk2zoRf5pgmni/gcBdf00rqwFnIBhZIjWRuGN3hnYjLMJfR95PRVT1gYTjsUUTyBM996i4g6fv4cETWp+hiR5zpWIuJzyqbTtbBsw227MjHcqSBsIaZxKghRReISST3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Sat, 31 Oct
 2026 07:58:17 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 07:58:17 +0000
Date: Sat, 31 Oct 2026 08:58:08 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.4-fixes] sched_ext: Fix stale pick
 when a wakeup resets the donor during dispatch
Message-ID: <auWfkN-V0vcuyPwx@gpd4>
References: <20261031015414.219280-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031015414.219280-1-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0115.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::12) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da47e6f-9a4b-4e30-96f1-08df3724b7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|5023799004|56012099006|261028144727099003|261026140227099003|261009223027099003|261026121527099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rx1UQpFd+tBm/Bm40fgNO1BSjJpkpsGB722C7JM89A8xOdNVY2IQdhzbpuCpNGBVHU++RbyTRA98w/pMZ2YuzyXCD7cJIu7G2WS2B06/H0QKFko3jI2SpJeVBZyy6LobYOPVMshmkI/83MFnaqYHY///8ojLxlu5sJh7okCbp0wBARiGSVeu+yAnWtUzw1xH0aJ0qnRhiuEFp8wkBGi2uT1hK0vxVDmOhnApxPP15/FAPO6a6u/z+FcwaFc1TCjFcLKrey3bjIpbgDd66b/42ETZzK4XgIHLV822o7q70UcIhBQ0UlOg06AakHoip4/ujyqZtSMVCnOFg/QvV0+72dwPdsWe3ufTEWCVXV5vQS8plBhAUKEwRZfTNYVqoJb4LYICtw8OZAa3ehOBtEk7jvrTfFqLzhdj08Z4SNcOjXmKGYyl3BwLM/nOZvzNRtbs9u04OgTEMsePKXUlHQajzL7ZzCDR5of6Yq0DDY4zR+dbhXgDh7VJKY8gchFhCx9O+1A8teNxmbvBiHKWfFvPs3a6viQ69rPCOJS313m91vdal8slrbpo1DwQvy/2k0TLN03rYywNMKbSFsu2k95wSTnRGZsH7dH01GRllhAQi25MD3ONQpMUBPwwNwGUDIXTaVadhlBFTJrOILx13BnZtnI0KAaGE7FK8/9O4LQq4Yo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(5023799004)(56012099006)(261028144727099003)(261026140227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h09IGDNq6kXycjpN+id8bZDmtNzuQS74R1vWje1YcNqAqIbyEU3iKpGAer5t?=
 =?us-ascii?Q?k54SBT9cSqarxOnk1bQaIW3TpY0hC8kjkWpZV5SZdIGIr8J8sYqnqZlKX9jP?=
 =?us-ascii?Q?YHk/u6XRjQYrn+8aYpR+9TWygSQ5LY5xq3Kw7oTWRElcUngOdPkYxRiaF0re?=
 =?us-ascii?Q?ozvwCfUt2gPi9SSGZEBy+J+Wx68XzW2+5eDV0zlYfoVq+BJPQjY99ILxKsW3?=
 =?us-ascii?Q?cGfK1hwZLBmMHPvxPlgLD5T+Jl0lzI6HTawa9jzxg0J3fs9KtBGGnI9J4I0Q?=
 =?us-ascii?Q?I3wAcwNfdVU3ppyDqMOtmpCp2NOKLt+9nZP+hGi2CEaAjoa7vHqQ0kYDNVxK?=
 =?us-ascii?Q?pE6lUnMddFjqh9JmzdVV3Kyokz308qvT8R8Ky6BKHbpuYbMEwv68BQCoI5YL?=
 =?us-ascii?Q?3qZKck3FIWOTj6pJoEoa03GHbyGk9R2i3zecDPXEhyuvJ7WeNq+GBuMfvu5c?=
 =?us-ascii?Q?rYLPH11YI7rZ1lPK8xa1RdFdGGJbs3PxyIh+0qvJAWY5/otvrxuN9n/7poCe?=
 =?us-ascii?Q?Xq4/v6kYlXpCssOxhxXyZE5/xnTbVWyhxylLVK0/5s2jh9LJ2G2+PpET2eq8?=
 =?us-ascii?Q?bXjvaZeTTJ/S228m+KqwVe7QsBY+iJ37k/6CxHvfXrCMhXKMBFXZtcqt7kbM?=
 =?us-ascii?Q?NgC4nRJALMF0zQmdYDVkjGs8balZhxKk4okDoxrdUe75mvUTj5lPdxj6YY1v?=
 =?us-ascii?Q?PZPW21nTEg1CHO0DVrmY6Ze40TX5nQVLperGRBDaGhmvK6AAdLL+apzSL89r?=
 =?us-ascii?Q?70n/Xqa0t/7wnVWtiZdd4YGH3xhdJJseyZCDi8Hl+kdqe/WzWaHO3lx3yl5I?=
 =?us-ascii?Q?ls35cxPitLMyG6n7JKIhl7psZuxTnXKP4m5owDeXnp7yULQPo1474GbzaZ1Y?=
 =?us-ascii?Q?DALiAXzV6KXZlanu6rZjZEVR0k7u3Ka41s2qeBQOCbjDxCy50smtFiph9Rzc?=
 =?us-ascii?Q?rZHa/dWOiQIdh2Q/w382A9gEgLDP6tUbJhaBJuGYQKjWvbNtVlAvRElB6acx?=
 =?us-ascii?Q?tuK3EBwJSXQzSZ7moEJHXaBw7A2+/6qZslVvXVDLAvNrKE1Mta5m1XfD76j3?=
 =?us-ascii?Q?S9RqgpULYbvF5Qesi/wsUhkBYby2Cj5NjRzHvVuYkeT7wRAqEAONwJxc+qLH?=
 =?us-ascii?Q?Xdnn0y4a9dhDfcJ/9PaHcwtmKBuMRL+Rm0gq98rfDQN4s35znFa4lI1ns+i1?=
 =?us-ascii?Q?exI9BpWMmDrdISHV/lqrii7bqJsnLvNGYqJdxbsb1Ph18DrsBRcTKiT0VwJ5?=
 =?us-ascii?Q?dWTZaV8hbrQFp4cRk8+dinNq70C9vjU9zC1wN7l3XvBQVxZY5c6otmyxQCLC?=
 =?us-ascii?Q?aeO8Vt+k5Qdb/r3wYfrEzGtQfdq/8SwRnjVZN2oJ3LE0FMLfuNIQMfEWZQBN?=
 =?us-ascii?Q?BqRL8DfvP1zJGxFKcVAGWBN16o7Ch9UxPO29oZbXGYUVuRQtC0LAQkJZnBeS?=
 =?us-ascii?Q?fFP6JNMR7Vfy1GygeN3rhmE6aB6A3iNhb/sf0/A0yRzFXwf3uKu+GiifGgwj?=
 =?us-ascii?Q?F/k3uinleKl5nAbgLIUuW2LE9m06dZiuRJA+lEz6i4sibpR5sDM00c+X87z5?=
 =?us-ascii?Q?288rrVOpo3sLquQzi9PEUsxlrifABbLauTcuAo74KQNurgBu1HIAQAf3hJjQ?=
 =?us-ascii?Q?4k4SGkef/I7hCQ1U4loFzqemPE+WJvhWH4Lq4mc+Se8JkA117+GLH+3i8jPJ?=
 =?us-ascii?Q?3UYplTbOd6eb8LcCF1MYMDnG18KWHdi/2pSx09Hqw7urDQYu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da47e6f-9a4b-4e30-96f1-08df3724b7ee
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 07:58:16.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOYhlJwlp2z4088k2a9HNWDX1O71Xilcjt3qqLLswhnEZixuLsu99VDicGEdTZBNZxJN28T8usMP7xGT0dUY3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100

Hi Tejun,

On Fri, Oct 30, 2026 at 03:54:14PM -1000, Tejun Heo wrote:
> With proxy execution, do_pick_task_scx() passes rq->donor to dispatch_one()
> as @prev. Unlike rq->curr, the donor can be moved to another CPU by a wakeup
> while dispatch_one() has the rq lock dropped:
> 
> 1. dispatch_one() drops the rq lock, e.g. to move a task from another CPU.
> 2. Another CPU wakes the donor, which proxy execution migrated to this CPU.
>    proxy_needs_return() dequeues it and resets the donor to rq->curr, and
>    the wakeup enqueues it, possibly on another CPU.
> 3. dispatch_one() sees @prev queued and returns SCX_DSP_PREV.
> 4. do_pick_task_scx() returns @prev, and this CPU runs a task that is queued
>    on another rq.
> 
> sched_proxy_block_task() resets the donor the same way when another CPU sets
> @prev's policy to SCHED_EXT or moves it to another BPF scheduler, and blocks
> @prev instead.
> 
> Whatever dispatch concluded, and whatever it does with @prev after the drop,
> is about a task this CPU no longer owns. rq_modified_above() catches the
> reset only when rq->curr is in a class above ext, and the dl_server pick
> skips the check.
> 
> Restart the pick when @prev is no longer the donor, as dispatch_core_pick()
> already does after a lock drop. dispatch_one() tests after each step that
> can drop the lock, and scx_dispatch_sched() decides per ops.dispatch() call
> whether to hand @prev over, which also covers a class or scheduler change
> across a drop. The donor only ever changes to rq->curr during a pick, so the
> retried pick can't go stale again.
> 
> 7a3a6bfbd62a ("sched: Rework prev_balance() to avoid stale prev references")
> closed the same window in prev_balance() by reading rq->donor instead of
> taking @prev. That doesn't work here, as the dispatch never evaluated
> rq->curr, which may not even be a sched_ext task.
> 
> Verified with a synthetic reproducer.
> 
> v2: Also cover rq lock drops inside dispatch (sashiko).
> 
> v3: Don't keep a stale @prev after ops.dispatch() (sashiko).
> 
> Fixes: c6fe97c34a1a ("sched: Allow enabling proxy exec with sched_ext")
> Signed-off-by: Tejun Heo <tj@kernel.org>

The dl_server finding reported by Sashiko is valid, but, as you noted,
it's a different core scheduler bug and should be addressed separately.

For this one:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c     | 20 +++++++++++++++++++-
>  kernel/sched/ext/inlines.h | 33 +++++++++++++++++++++++++++++----
>  2 files changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index cd923f9f1f2a..43cf98c1d511 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -3407,6 +3407,12 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
>  		rq->scx.cpu_released = false;
>  	}
>  
> +	/* the ecaps sync may have dropped the rq lock */
> +	if (scx_dsp_prev_stale(rq, prev)) {
> +		verdict = SCX_DSP_RETRY;
> +		goto out;
> +	}
> +
>  	if (prev->sched_class == &ext_sched_class) {
>  		update_curr_scx(rq);
>  
> @@ -3449,8 +3455,19 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
>  	}
>  
>  	verdict = scx_dispatch_sched(root_sch, rq, prev, false);
> -	if (verdict != SCX_DSP_NONE)
> +
> +	/* scx_dispatch_sched() may have dropped the rq lock */
> +	if (scx_dsp_prev_stale(rq, prev))
> +		verdict = SCX_DSP_RETRY;
> +
> +	switch (verdict) {
> +	case SCX_DSP_RETRY:
> +		goto out;
> +	case SCX_DSP_NONE:
> +		break;
> +	default:
>  		goto has_tasks;
> +	}
>  
>  	/*
>  	 * Didn't find another task to run. Keep running @prev unless its own
> @@ -3517,6 +3534,7 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
>  		     rq->scx.nr_immed))
>  		scx_schedule_reenq_local(rq, 0);
>  
> +out:
>  	rq->scx.flags &= ~SCX_RQ_IN_DISPATCH;
>  	return verdict;
>  }
> diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
> index 1e39d12678c4..87b8193785d3 100644
> --- a/kernel/sched/ext/inlines.h
> +++ b/kernel/sched/ext/inlines.h
> @@ -18,9 +18,28 @@ enum scx_dsp_verdict {
>  	SCX_DSP_NONE,		/* nothing to run */
>  	SCX_DSP_LOCAL,		/* local DSQ has tasks */
>  	SCX_DSP_PREV,		/* keep running @prev */
> -	SCX_DSP_RETRY,		/* pick helpers only: restart the pick */
> +	SCX_DSP_RETRY,		/* restart the pick */
>  };
>  
> +/**
> + * scx_dsp_prev_stale - Test whether dispatch's @prev went stale
> + * @rq: rq being dispatched for
> + * @prev: @rq's donor when dispatch started
> + *
> + * With proxy execution, @prev is the donor and may not be the running task.
> + * Another CPU can reset the donor to rq->curr while dispatch has the rq lock
> + * dropped. Dispatch restarts the pick when that happened and doesn't hand the
> + * old donor to the BPF scheduler.
> + *
> + * During a pick, the donor only ever changes to rq->curr. Only __schedule() on
> + * this CPU sets a different donor, after the pick, so the restarted pick takes
> + * rq->curr as @prev and can't go stale again.
> + */
> +static inline bool scx_dsp_prev_stale(struct rq *rq, struct task_struct *prev)
> +{
> +	return sched_proxy_exec() && unlikely(prev != rq->donor);
> +}
> +
>  /*
>   * One user of this function is scx_bpf_sub_dispatch() which can be called
>   * recursively as sub-sched dispatches nest. Always inline to reduce stack usage
> @@ -33,8 +52,7 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
>  	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
>  	int nr_loops = SCX_DSP_MAX_LOOPS;
>  	s32 cpu = cpu_of(rq);
> -	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
> -		scx_task_on_sched(sch, prev);
> +	bool prev_on_sch;
>  
>  	if (scx_consume_global_dsq(sch, rq))
>  		return SCX_DSP_LOCAL;
> @@ -106,6 +124,11 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
>  			rq->scx.sub_dispatch_prev = prev;
>  #endif
>  
> +		/* the dispatch so far may have dropped the rq lock */
> +		prev_on_sch = !scx_dsp_prev_stale(rq, prev) &&
> +			      prev->sched_class == &ext_sched_class &&
> +			      scx_task_on_sched(sch, prev);
> +
>  		SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
>  			    prev_on_sch ? prev : NULL);
>  
> @@ -116,7 +139,9 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
>  
>  		scx_flush_dispatch_buf(sch, rq);
>  
> -		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
> +		/* ops.dispatch() and the flush may have dropped the rq lock */
> +		if (!scx_dsp_prev_stale(rq, prev) &&
> +		    (prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
>  			return SCX_DSP_PREV;
>  		if (rq->scx.local_dsq.nr)
>  			return SCX_DSP_LOCAL;
> -- 
> 2.56.0
> 
