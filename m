Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792943235;
	b=o79wTZmPp3AT5R6rPQZdAEgDr/UZ1Len1TEMHnVAXliibgIBebD/d3/2S9y9YKxI6FpK
	 7pMKGQYBdDc9ALoDdZuGzQH9fWyb+wIFE4n6Dr+M6uYOglcOyUyk8obqRRnD42eXupl21
	 uf2sYk7tdHOavGjL+5Zkm2MjaEFfdx6Fw7xYIltt8Se15IcPSdKwNay666TaHXgMVGJoY
	 +RM1obOaH7EQlRPtoDPqdY4JAWbDnC9KnnRy3xzCyhuOam2qlzZgNGRZJ3J6u2PgGpZlo
	 DDmIYhhJXczXyr6A86/inTIzSwd3l273O2oyUj6MbV1Ncmg74y++1JG7mFC9/Rh2kbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792943235;
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
	bh=cIMAxcDIDOWcpd06Lgkq331vUK9QS2aVLxY2Cf5i/bs=;
	b=eTc5tqHHzgDLtGXJWm8Ik9cDSxfjigp21+qziw0Ka0Z1VonCY0KMNHVmsB4CPFK2vYJV
	 bH58QM3jKJaPhkuUflvgO38zMgGq5wc4cP5Tm7F+uJUyiTUQEBavU849mwDZIxIdQfcdJ
	 8RQBa2nwigLQfs+Iysuxy0Ldyqopc5SKTtfAkqn0QLJt1l1qq5xgSFOb11Cxe5oqg6lER
	 lvpZ7vgZ7c51J7LzcxaJQ6t1fA+b4b2lxjqmDbo6zl5LW2BAY4kQOE+9vv17MhU1b03BS
	 DCVMU+B50m1ooHtL/nbki2hTFSwhyjyx4iJSh/pkz3kjlib/+V/7dzQdqOGQ7xzWJ2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p74ewf91;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.30
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B3606A31A
	for <sched-ext@lists.linux.dev>; Sun, 25 Oct 2026 15:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C5B3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p74ewf91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjTM6AkuVaFGCS/pWD41eRoR0ENiymnRRI5ky8v0i56oytTXUkIjpz8brg2jbVIRINvolFPqNjlEDLJyOxAQ1huQeWmsFxPnjKUF25cr/pgerBFbn4kWjl+HeJ4K4KRibcOJIQT1b4HpJWpBCRJ+w7Y2oQfhNThs8WqxrcsSb/fN8pIBtY2hTb4EeE1T/5tUQf8ePqbcdsKXvW53CSWVoiKNSdxp71Pe/7RBKBb+8w4Y59dj7W7omXFZzwRTpu4+gKojEixnDrDQ60GiI5ttAJ6/ova5BzUq2LLehi6qT6a9U+4uc3pODLDI+Rn4IItUlQ27kq6Kn9davDA/PlRp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIMAxcDIDOWcpd06Lgkq331vUK9QS2aVLxY2Cf5i/bs=;
 b=AlPAzW7hp6uGxDMtFemqo/ugEVYD8uaYJNSv8PBdmjD3BHMZNuukhJHSBWausxRXbznkG5MFndkxE8tsIj1laQgiYuhP5LL+U8ZM773+bVVtnJIN4EItVS9vFOOg+fjgjlyJXrsG7Fur/bZbNUoBNhHA3WHERZCLmYxqnp8IAHaQf66naGNuQOr8R+gepAWcO+aHF2ErKxosPGyWJdrmwLdAE7gT7qcFUUjKR7v0gTlRMqxe5zzVitZe5dNbsJbb30FghaC835UZTSrLs9vuMslFxFrRyodxj1Xq15m/V3px0UbXOKLu0Qh5VibeXQLgL/axD04S0KSSCNFx3vxRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIMAxcDIDOWcpd06Lgkq331vUK9QS2aVLxY2Cf5i/bs=;
 b=p74ewf9169i+Vmiu5/4zyJ4tXNAu9bY/pzTikwnToozCst9BcP/wPSPIOt4s5vuw8AJrVTeuDeDr47wgaDX+Dd8Iq+eWRYkUShgDnp9J8Es0lUgqIYYYXDHWaRVo1dEvZPy8aav85jUHTGDQ5ulRqlC+Txfok269lmGTHgsJ+7/lPp/mtcqP4sh5adM32yRbxwMfTLIK3uoEliiD8+kSa3V3y4st8dZ5VNaOLaN5+Mcg6Yqn2x2P7H4J37Ya3XDdna6eMDveuspl72S/YH+4LeaoZxxDkgC4UztiHlADYMQRipSzjm29YzgCIApTBB/RUtDeLDwP94kDiWi6ED5SkA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 15:47:11 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 15:47:11 +0000
Date: Sun, 25 Oct 2026 16:47:03 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] sched_ext: Fix queued bypassed tasks stalling when
 the host loses SCX_CAP_BASE
Message-ID: <at4kd-78BbpBX-_4@gpd4>
References: <20261023175608.4120910-1-tj@kernel.org>
 <20261023175608.4120910-18-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023175608.4120910-18-tj@kernel.org>
X-ClientProxiedBy: MI1PEPF00000AE6.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4b8) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e514f9-e9d3-45f2-51d7-08df32af3b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006|261021121427099003|10067099003|261009223027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	XQfszIC3URpGW8cChgVJnjXBpPd9c0LVT9VnqiWmHnOTtPapLq4v3h7Qi+LeIEWS4rBM54jPKUXTKe7iYznUYe5RgrWJ2zZX7lun4+D1nlmwzFz14jf/u/x9IMXsKco9jMJBkWewSqu4UAHmAjpkpbwQUWFzCDGneHANEhfBmFrG7j4IaaEwfH17FvstsYplyBFKZ2e/1dfIvOqiu++j0GWnwFXnT7aA+v5DVpR/nf4FNlycH6+tdaAh1Kd0HsPcTEnbJ2EqdG4+BxH0DbFF60pZqlcqy4MEaZECNJPuiWDddo+HGsdxcmi3gJjeSmFbU+WiVJo/uB0RRGiCdRgSgEDUdaUdUBo9TeBI2jy1okw254gSs4jA1br6HBr/krns6GNQ1UYW51yuxVaRfOM1U9mfq01/LaTAXuak+u9W2xJX0g75vQ6BXH+4fTNwC/mF4DIi76ZAhbxkBucF29cFxBjkiaq2f0bdRgUibbuSHDhJMWourVaXGBMC4dpdec+jGeb47vuqghOAm6GbWnQwLALWVga3UVXf5kCwb1WKB92ccM8DfwAWMGhqZD8Djkb6URR6An0E1DwMyFm71JWgoF+QGspZSPQp4HXCokhxnYJGmeBdBDYvbw/6GNPHC4DKd6m2O17rlGRoaFQk6ywcizU4fiOhspcFeBnLETqqS9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ubhlku5pGMlP/1CukSI95icFmNbrtE8CsxKU9u7eKpmbx+GMtrXHs9S/eEvG?=
 =?us-ascii?Q?Yf2H9tbxNxCo/QVdKq4KnU4V1nSBOBIfM77r5QggCBRf/3tgi7XI3cm3YKeS?=
 =?us-ascii?Q?AL324LURhycYQUXa3WZWjdy3pWT7RgQvGWF3oAF3Z6rWJr4UZFQ703Xtw+d3?=
 =?us-ascii?Q?4B71WdIqYP3xZNtxVmmgvGlKqHmYSCAfbB5l3HdSTCSNT1q4z/puIwUL2swf?=
 =?us-ascii?Q?Y8L3b7szH3VwWaEQ4QTkxnkY13YOsE8SO+RW/AY9IybkWcJxPKxMeH+qH7MG?=
 =?us-ascii?Q?LdcO5nJCj2z61UANhRZtdt+c7D8ble3jyS3LH3PS3SAbNByvOTgJ0Z2+FqYA?=
 =?us-ascii?Q?vkIfzm0IbAVFMxo3BN45PU35XsR2D3OdBDDq8zKkXKKO++zgFjf5R2xyPtL0?=
 =?us-ascii?Q?wiLAZISorZcG77T/SnwvwpJSQ4wxuXt0D38LUKGvZsMvPU0e0ELov0TdLbgo?=
 =?us-ascii?Q?cPTm4cdiF/0eImaqfdgfn+yZNn3OPKBJoRpIZ1OBJDJ2irrI9movIb8dNiv+?=
 =?us-ascii?Q?JlLBh9X5N8Je6TznYewh4vZnHy9MOARZrbhJkNx5RQtPfUS5VqZLj3LEB0s8?=
 =?us-ascii?Q?B1q6IFY2jxGj+z5awsMqRohecnPExbS3Mzt+mktY7qr0XPZJEQyobDozSDaO?=
 =?us-ascii?Q?CdG0g3D7/7QDs0M4Ezr5jfMn8zj0uvJP9c7QX1g6jMa527h97pL+F+tYYr3m?=
 =?us-ascii?Q?zEO8oGDBAExmMPbq7eV4ohoAfQlr45hC/WUMQyrE5IfASdZT1t1YMSUUqSO5?=
 =?us-ascii?Q?fFinKH7UPhVJ185TB8r2Bc3EGx2QSEVJ6lfbz+KG3FC4ejlLv8QmYlUzWVwz?=
 =?us-ascii?Q?GPsPIGo0eHx4CpIA8bmMZ73ItJEhzLSmWnGA/ROYxGPBcH8Hn0Fp2Y5USriJ?=
 =?us-ascii?Q?Hqn+IBd2JSl0Bc45RgUD+lc/KayzEiPnBup1BViQHYPl98NWGn+8h6UmWh7u?=
 =?us-ascii?Q?r5GHTOG90JVd7aTQXkOcQAg6tni2Eg96HNm9Bg1xPd6CEzeT5B2uv/ylKNkj?=
 =?us-ascii?Q?xr5pagu6yf5vILCDo7siP4r7/HbFS7g0IgwEzUCaLNhg77a2FlgdRDiqgwCc?=
 =?us-ascii?Q?JV5Slkg3tn78crv/zMyOSAfkndc136PBa6w8H5cXVhFNfvYltLSIRXFpInpA?=
 =?us-ascii?Q?L6qjMwu7ssCHLlZYrzJgdEokwgKxTMBK49QXxeyvu/2Fb56tnbY8VjRfZFbg?=
 =?us-ascii?Q?tPly0t61/A8sVGYuOh8TPp92DCoB5WgGPyKof/lGRNg0Q0zKNYdhrFfjlTD3?=
 =?us-ascii?Q?xMefHKOTEzlX6r4aaf+KR3YQtHhEH/uuwzJunqNm4AHqouuzPlvMnF7uCYmq?=
 =?us-ascii?Q?UIObd6ElHFDz8y+c4nkcWy4LwHORZxSK/7ANsdyA/iBsOHttvMLEqEVUxmex?=
 =?us-ascii?Q?7cvU12FUdEhQhiHn9GaQLHBaf5xKkXAU9+I+pEkvfYjmya6j1k+A6bskakOx?=
 =?us-ascii?Q?X7jLnda8Of7ICb0oJXfV7iHvIou6mTrK/dpUdeordM96RYXJEoYq2ywe3O6b?=
 =?us-ascii?Q?qeW0hfY+d6a0D8DmxVKVgs/hcAAQxcW8QrIbqYNcUhYUEyhdG04U2popqRST?=
 =?us-ascii?Q?CHui8cq3Gf96rMrDV46jz4kzwDLZccQyqpsOdkMfTTITuEewUnKuCwvihS67?=
 =?us-ascii?Q?D7y7OXTvR3M6c2NP7613PMVSRcKTpxIHBXqeb8bp6t3Jul/Aa2W4PGNntnAk?=
 =?us-ascii?Q?Z1Vvv4YbKhIQNc78nmyS3atvvhftTzicBZ5cbAdAVk3370Oe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e514f9-e9d3-45f2-51d7-08df32af3b43
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 15:47:10.6245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPFadppBk9iRzd5AihRjjFyAKg7iE1yv9bFeu7KLAex5NqeqKV+/byusT0Z3znSVGHQ9G+q1pSWMwPfHhzvDnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

Hi Tejun,

On Fri, Oct 23, 2026 at 07:56:08AM -1000, Tejun Heo wrote:
> A task already queued on a bypass DSQ stalls when the host loses
> SCX_CAP_BASE on that cpu. The cpu's dispatch no longer consumes the DSQ, and
> the task sits there until the host regains BASE or the bypass window ends.
> Sending a bypassed task to rescue at enqueue time covers only a task
> enqueued after the loss, and the balancer no longer donates to a capless
> cpu.
> 
> Have the bypass load balancer drain such a DSQ: a cpu where the host lacks
> BASE is a donor with a target of zero. The target already counts its tasks
> against the cpus that hold BASE, so the donees take them under their
> ordinary fill. The queued-duration threshold doesn't apply to a zero target.
> 
> The balancer reenqueues a task no donee can take at its home, under the home
> rq lock the move holds there anyway. The enqueue sends the task to rescue
> when the host lacks BASE at home and rescue is enabled, and to the home's
> bypass DSQ otherwise. A task that must run at home, migration-disabled or
> with a migration pending, is admitted to the home's local DSQ in either
> case. Every donee refuses a migration-disabled task, so it always takes this
> path.
> 
> The same reenqueue replaces the put-back for a task that can't run on the
> donee the walk picked for it. That is a cold path: the donee went inactive
> or the task is a proxy-migrated blocked donor. An affinity change while the
> move is in flight dequeues the task and the balancer loses the claim
> instead.
> 
> Without rescue, the reenqueue of a task homed on the drained cpu lands on
> the DSQ it came from, apart from the admit above. A task stuck that way is
> reenqueued once per pass and waits for the host to regain BASE or the bypass
> to end, or for the stall watchdog to eject the host, which it blames for a
> task stuck on its DSQ.
> 
> With a zero interval the stuck task is reenqueued once per BASE loss, and a
> task that lands on the drained DSQ after that pass waits the same way. These
> reenqueues, like those of a task refused pass after pass, are not counted
> against the reenqueue limit, as the task's scheduler is bypassing.
> 
> On a BASE loss, scx_bypass_lb_kick() sets the balancer's timer to expire
> now, so that the drain runs before the next interval, and runs at all when
> the interval is zero. A donee can lose BASE while the balancer is moving
> tasks onto it, and the kick from that loss covers it.
> 
> The balancer re-arms with timer_reduce(), which only brings the expiry
> forward, so a loss during a run leaves the timer at now and the next run
> sees it. The arming at bypass dispatch enable uses timer_reduce() too, so
> that a kick landing there is kept.
> 
> v2: The description drops an in-flight affinity change from the causes of a
> refused balancer move.
> 
> v3:
> - The description says that a stuck task's reenqueues are not counted
>   against the reenqueue limit (sashiko).
> - The description names the stall watchdog as the way out for a task stuck
>   without rescue, and the tasks a zero interval leaves on a drained DSQ.
> - bypass_lb_reenq_home()'s kerneldoc and the description give the placement
>   with rescue disabled and for a task that must run at home, and the other
>   two comments on that placement point to the kerneldoc.
> 
> Fixes: 147d1885f390 ("sched_ext: Add the SCX_CAP_ENQ_IMMED cap")
> Signed-off-by: Tejun Heo <tj@kernel.org>

...

> @@ -6579,20 +6602,21 @@ static s32 bypass_lb_move(struct scx_sched *sch, struct rq *donor_rq,
>  	/*
>  	 * @p's affinity is stable under its rq lock. A task whose donee is its
>  	 * own cpu can always run there, and task_can_run_on_remote_rq() warns
> -	 * when asked about a task's own cpu.
> +	 * when asked about a task's own cpu. A @donee of -1 means none, so
> +	 * don't pass it to cpu_rq().
>  	 */
> -	if (donee == task_cpu(p) || task_can_run_on_remote_rq(sch, p, cpu_rq(donee), false)) {
> -		dst_dsq = scx_bypass_dsq(sch, donee);
> -		enq_flags = 0;
> +	if (donee >= 0 && (donee == task_cpu(p) ||
> +			   task_can_run_on_remote_rq(sch, p, cpu_rq(donee), false))) {
> +		scx_dispatch_enqueue(sch, rq, scx_bypass_dsq(sch, donee), p, 0, 0, 0);
>  		ret = donee;
>  	} else {
> -		/* back where it was, at the head so that the walk skips it */
> -		dst_dsq = donor_dsq;
> -		enq_flags = SCX_ENQ_HEAD;
> -		ret = -1;
> +		/*
> +		 * No donee, or @p can't run on it. Reenqueue @p at home
> +		 * instead, see bypass_lb_reenq_home().
> +		 */
> +		bypass_lb_reenq_home(rq, p, cpu_of(donor_rq));
> +		ret = cpu_of(rq);

Not a blocker, but I was wondering if we should preserve the old head or
ordinary balancing when the donor still holds BASE?

If a selected donee refuses a task homed on the donor, this can put it
at the tail of the same DSQ. A proxy-migrated blocked donor is refused
by remote CPUs, so repeated balancing passes could keep pushing it back.

Thanks,
-Andrea
