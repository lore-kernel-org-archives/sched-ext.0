Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795507232;
	b=R5Ya3eSnlaJ0hLh0FnwNcLniVZUzlsmJOQ8l1rr+zNC/AvJBJC7dzYnkALo13XzaBabD
	 zyGX3ZdeDxOATxPeKIkPbX7sUTJKGj8WJwBlbg2GopQImdMy39E70YIWypDpRgDeTaHLa
	 Xu5wd+8Wyursiq9o8qAlP4z+mgbCgYMQy/DBYigsAjMR+TYP3Ftt3/d4xh/t5IuUK+rFb
	 YN/IWLz83CbPvg7aMbaHEKjopPVReTa54nKPtjtbUjgthiZr+uOjGxqshgXWZvysB9vl+
	 WcJTdhy+O8mVgVY+gQIpbAqGeUkWgkI9hyxOFa61AtxB5fnH20wBpXwFVJQvZ9D4k6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507232;
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
	bh=GxzyGzYqZPTMSiJlbLpDcxXfBprPyqb1PlGHq9YHEBk=;
	b=F/ZxV0Kgrg4YvD973l4Ez9m2sU3iOoHEb0VwEDh4ihLvpCA16jrW2bjZlk0aGqmaljSx
	 E0SlPDVtRhIsZ6F0vxbEIr7gm/JMTeuZ6HwCOuRGE645xNFOy9Cr4mW7IDoqpDpa1f/V4
	 bYunJKtN2j3MPBMR3koSAudHszhuMras2FFeQ/gS5q/5/OBsQnM9lxV9KgF9BvnumNA4Z
	 rAFv/0f5hlS3fJE7pP59NAECJ0OmXww6UfwzT1bKwpfqpo9XNkZ8arbKCYqWQA5GWCHgv
	 M+GSaWDp0BSHFy0gw6JaiEm/tGE43/qsvYrrUq0acXLnBr1MhSEURh2EfHzmpe8/FBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=amRNl2K6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.42
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F89606A322
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 08:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07F89606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=amRNl2K6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElnD6tfTwqx/oTBy5GbfefrriiYjFXVud6z/hW0ZFXtLAAPkz4Cg8uewMda9IVSKr7qjvGXsozH+M8ybBsPqBucOsG+BswQT0Up87p4oHJ/L3+CMf13j6Lp/rwuLG1UQl/41W2yVAAx/NeExai6BTuNmr9Npo++mCwSd0wKk87EYKOfPZJMPP6ZEl6p+GSwYfOqZsWZy9L4IfcMJUBR/M3ZXMXZjyRIeDw7o8XtJjJM0W1lzIsoroC9YM5SGedljHIsxKTPZV0BcCdnEA73GPou4c2j3QhLOoKLZtnQB9XGMeSmQgQIUrDbpUvR6RqujeMqJdN9cHckY1KJnfKiV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxzyGzYqZPTMSiJlbLpDcxXfBprPyqb1PlGHq9YHEBk=;
 b=LQtDuII7kCuwMDqEOk06Wb0RkpEghak+mEBp81yPx0+OSg5wr8TTPC+kIPJha3csw46lpwq+h6s5TGV5JDox3m1nMfZ5ww2QFYCW6qH5fUl96REp2w1T0AnaZ8b3Sa5Y6lCbULlshKQwNwc6H+1//Ce4TXs9r+s8A5X1lFOcT2rx8E7Fx99ScOeI1JOx5qbOuy3bkVr1pM2AzyEeMcukZMKsL5WMyZiJ8WMPtG40vZxL7mc4eW2QdO+zvw+80YUoDu3CpNOIxtfO5WNAp6nGfOyuXICbJQpcuu61h51WY5cH3+TclsD19uqcKfpoBgdEYfbDAgEUoP2Jg9BLqQmBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxzyGzYqZPTMSiJlbLpDcxXfBprPyqb1PlGHq9YHEBk=;
 b=amRNl2K63UYOyiCLZadGTVhlPyRUV2IkhmMmlz15Rm8PBrYkN0IYJ4M58rp3x57Nfnm1BiOn1JwWoyA9RMoeoiwDxUdgefhO09ldmQgfC+rFXRJnCteksZLACANXtWD9NSe90jyWJmkS7Gh3FP1Iskc5F9GvvadstzZod2ZHHFbtY6kcXozUeFnrkZpYYQ3+OriwBK7fQeXl4QlvTzxTxQvU8A4+OMNtI+cQzoYDFmiszSBTQCU2d3BPpozrNltqyK1Z+I9vH70TZdXN9efa1qfG4G09fi0QLILeKXV7Olv9GcpxBkuvvIBtCS1WuvZZa12KqQmFlhzKJXidND6Waw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 08:00:27 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:00:27 +0000
Date: Tue, 24 Nov 2026 09:00:20 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ryan Newton <newton@meta.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix suspicious RCU usage in
 KF_RCU_PROTECTED kfuncs
Message-ID: <awVEFDoGl0ZqiHN_@gpd4>
References: <20261123145927.577162-1-jpiecuch@google.com>
 <20261123145927.577162-2-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123145927.577162-2-jpiecuch@google.com>
X-ClientProxiedBy: GV0P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::15) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: beba1778-1244-405f-85aa-08df4a010028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|18002099003|261009223027099003|22082099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|56012099006|4143699003|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	45np5S2E03+ubBPzG8OhzEjuAe3HEpAkdKv5i7oOV5P+JRWWDgEQhzpPI4KQKOKfbi4Do/7qHNkFOSCX0QfoUe8oHfEWbivMsm8hgLUSzRiQCiv3gduMzDHMdhh/jAm26t0J1OTQwzKOPSY8O7OM0YXsKZnaGsruZe3sAUySa1e0QKKSCty/M7lHwUspXSdrwzdrWvYBhTusFbs/X6RbpSUwI50Dgfafp1lDUEbzha66rihZL2CJQo+rGJTHaJUpH/v8PnlWvtwZhdIVXQC2zb7dE5YZ01kiM22cGAHvWsXzehSK2spqT5j7tVyxTBkWJeGh/0TkNVj8r0SQWfLRbcAV/GakfAHNm3EA2IkAJJFBQsFyLfgR1byMcQ0apjnDzcipddHPma3MEk8wvX7M9Q2OR8pMTHs6RFfcoZQ26DV9by6BNd6QUNVu6AYT3G9AfamjWwYwLRi6luOUjbYg3xmEAG/YHFEAvM/CmX7kr3EclWBpQ/ieucj6gz/6T94xnR82qDn/KCcASqEAh9v1Fz8wShN5g3NXMO2K7UfaQ+P7plAcmIuxKTktNaiaLFBynEHL4SKJaP/SMHvB0LpfsKQRYGpGj+fHHDGCDKbLGdcKqk2ecRRVXMmzh5JlSvadmnTeaV0Me3NcdTbd/4/P38NUQ6F0OYfeI1PWLdTr0vA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(18002099003)(261009223027099003)(22082099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(261102123227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PYALY1hQ4LrPMEAR+rmtEqi5Dbm8q6zF8jTR8sZCyTCY4ooUaSFA8qwfbaam?=
 =?us-ascii?Q?a7Ld9UwQS/IjvY8AXd/pSaf6xn+6P3O7THmrFy0Y8NGpeUWsrG+CCYOX90kC?=
 =?us-ascii?Q?TIA39Rd00cYoTqOXpkdjwgtMLqixnnXUlkDKzko0kCeCyli9/wAxuoNkRSzV?=
 =?us-ascii?Q?c1n9ewkkqKU59X2uXehMTujmphBxhs2PjovzV6eJhhs/ddNHrYQK99h9tDcc?=
 =?us-ascii?Q?ykPibOgnmiJ2rSeOO7HlSrOUrPywPXIPcESMPg6093vfx+WvYnJKo59JuOHl?=
 =?us-ascii?Q?0G9WpEqcU5RujoV4/83RV4mW2OBqEV180PuV4v1QCuv3bTqilJdxOog/s+pu?=
 =?us-ascii?Q?3JV5OPTaS07iPvuKtPmhr0uhrRo4LP70QNURdXegY2Il4hA8hcS5iHJrerJJ?=
 =?us-ascii?Q?zKC8ybkvYhWHTIRN36ZLvycQsFsNe8tR9LeoLZraKIDThmWLdWHiIJ5Kvl6N?=
 =?us-ascii?Q?1M4f2Vf409cO0w7iYg+up7YIyOX1DbriASu3daRl8oJ9YRjsEwfSMrr3d6t5?=
 =?us-ascii?Q?jnsc6d5e9SCp2oA/z5NENMBPov9gZIz605ghIaOMPvvywShD+Wul5DeMlOOn?=
 =?us-ascii?Q?CdmLhUvFwGxdUNXMw++Sn06p522ODJRhu9JlADOkGxUlKJlLt1UNBCZvhSTc?=
 =?us-ascii?Q?idJZBf9PiAa7jOw7Fxk7TSXfguzuPfCCCYOaWa/5Uw5VG54a3jUByMUo7kw1?=
 =?us-ascii?Q?/xgluloW//K2RyOlPL4iKCnSl/waL+5yEZraCs6NAuRbYgiAM9ILhzTPIJeG?=
 =?us-ascii?Q?tyIIMPXLoTMeZ0q4Xaz+qQl6CfoIXgSJ70EMysz3+LeKQg8Sk1+2e4HLkVKK?=
 =?us-ascii?Q?s2U4EJT7s9fKZWRX9ErcpMkavXHbDBAcD90DcKS4sJVPjg6AHWD906gr5gkN?=
 =?us-ascii?Q?6rhGRGQJ57KREBysUXRbGnr1oyYQ/BkaVJ+x8ilgExB6tScurLm1GWmsfrwD?=
 =?us-ascii?Q?xvpsfD+4zoXFLQuc+ZBcrqdpQZigiCAMGuheXKOLai0BvLH8svfDlLPIMmht?=
 =?us-ascii?Q?KD7GNn05jz9cVW3Y7cQocd38aKc3QmrLPkVXUvQcsPFohuPDGoS/qDmYjrv3?=
 =?us-ascii?Q?nUIlrIiRhXmujLVNNIDb85lxmlrmK1aZsg5/jKwQBkl0pqfnaU0/9gzxQH3o?=
 =?us-ascii?Q?fWgKkLXJY7/EWi2we0iAkGXdBF7uRxA32Eq9D7htUXvQ0+UqTarl/RpkGY32?=
 =?us-ascii?Q?E17OnABVzTpN1gg0xo3tm7f+YPJnYwLo/e0wOO+/BzM0mAhG9N82XIFCm7ZR?=
 =?us-ascii?Q?Lw6xnxiprQB944jSu/NXwkFNen+yUew4JtplIz7C1LSC92ZpwWXu508vGnpP?=
 =?us-ascii?Q?0F4cufulxL5797KL3WHhXlPXGz6wSdYfYlrm7efZDWxw+V9gAdzsi5ElD/tm?=
 =?us-ascii?Q?DiUFmOT7mvmxEVXgFbmj+6/zqjcyCzGY+fN2NZ/HVY1VWKVZ5/dUNvFOPKQg?=
 =?us-ascii?Q?QhpmF0JtD6NnjVE01FfURnB30a1vxSEfvGKEOUYhU7EsnW/AGwX4KnQDqSIg?=
 =?us-ascii?Q?7OshAuXxBmZ4oWhA668X9zRhe3W7dzN6ry2L3mUESHVDV+KwRJosU50VYxRZ?=
 =?us-ascii?Q?4VNHEGTr1oHqmFQprkJ8hhP80OzJb1n/U56IqFBEj4AkUQjNRDueEDX5rTww?=
 =?us-ascii?Q?8yWlk4lA20UcUY0b9uMKxcwBQugo+p+t2cY/P8lr1SUlCMtjw9hX9YPwgxv+?=
 =?us-ascii?Q?NbcOGApgfzc6yi8kDww5rXWyIiEadSDerRlVgif6lltEJ/w0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beba1778-1244-405f-85aa-08df4a010028
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:00:27.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSppu+uKtCW1zxA96bMb4uHAlRtWGkoPF9fi72uWSBHhEPzvYDEnDSyXVD/qnONvW9tvyyBLxoJw8CpI44duVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

Hi Kuba,

On Mon, Nov 23, 2026 at 03:00:37PM +0000, Kuba Piecuch wrote:
> scx_bpf_dsq_peek() and scx_bpf_tid_to_task() call rcu_dereference()
> without taking rcu_read_lock() and rely on KF_RCU_PROTECTED instead.
> However, the verifier treats every non-sleepable program as being in an
> RCU read-side section, including bpf_timer callbacks. bpf_timer_cb()
> runs those from hrtimer softirq without rcu_read_lock(), so calling
> either kfunc from a bpf_timer callback triggers:
> 
>   WARNING: suspicious RCU usage
>   kernel/sched/ext/ext.c:11170 suspicious rcu_dereference_check() usage!
>   ...
>    scx_bpf_dsq_peek+0x7d/0xd0
>    bpf_timer_cb+0xf9/0x130
> 
> The same happens from a sleepable program inside bpf_preempt_disable().
> Both contexts are RCU readers, so this is a lockdep false positive, not
> a use-after-free.
> 
> Take guard(rcu)() as scx_bpf_cpu_curr() and scx_bpf_cid_curr() already
> do.

Can we express the existing protection in the dereference checks instead
of adding an RCU lock/unlock pair to every call?

> 
> Fixes: 44f5c8ec5b9a ("sched_ext: Add lockless peek operation for DSQs")
> Fixes: 41e3312861ea ("sched_ext: add p->scx.tid and SCX_OPS_TID_TO_TASK lookup")
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
> ---
>  kernel/sched/ext/ext.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index e8c30a21e03e..2b9324c31de9 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -11152,6 +11152,8 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id,
>  	struct scx_sched *sch;
>  	struct scx_dispatch_q *dsq;
>  
> +	guard(rcu)();
> +
>  	sch = scx_prog_sched(aux);
>  	if (unlikely(!sch))
>  		return NULL;

Can we use rcu_dereference_all(dsq->first_task) for the return instead?

That accepts explicit RCU readers and the implicit protection provided
by disabled preemption, softirqs or interrupts, while retaining the
pointer-access ordering and lockdep checking.

> @@ -11957,6 +11959,8 @@ __bpf_kfunc struct task_struct *scx_bpf_tid_to_task(u64 tid)
>  {
>  	struct sched_ext_entity *scx;
>  
> +	guard(rcu)();
> +
>  	if (!scx_tid_to_task_enabled()) {
>  		struct scx_sched *sch = rcu_dereference(scx_root);

Likewise, changing this to rcu_dereference_all(scx_root) should be
enough.

Thanks,
-Andrea
