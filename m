Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D6372B57
	for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778478085; cv=fail; b=eJiQFkpx9IIHRd2pmc4JrQRcE6w0Q0EgQxIBBnP9Qj7pwEu7rc1pbZiJgXUcpk/NlAcEJtfnh0JPgsWEPbpV+04FgigUbO6Kv/6dB+13/jPdG7Mg1aU4C82dMpueCeYT8d7spFgPYN2dVpoKB5hXDaAcx8r+BhGAYuANh1nVnX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778478085; c=relaxed/simple;
	bh=L7LcecjQ+AheGm2Zg6caju4XlcJ9DO/x7e0ZQid4edE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LGrgSmMWf2BiP0u3Du5SC4lX7ihmLsQIyvgmwvf5xjZivBSrcNQObwlYijBuxzu8pmRCq3ZrqJbAu7kcbEARvu4HcBnjp5iYSktpxplz0e/FCxzB4SoU9VDBkrYjFZ28jja4VRXzcjXL0CFmvTcIyMOtFaTbYP3DiOuD7XR8qN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Po6kK41d; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Po6kK41d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJqFvOu6XOdZKrmpNqehYoE0D9ofH2tCvNkt1uOCC2OgYtwp09twusIBCkAPxUP17wd3eJ/95tdYUzd7EYireFK8OEWeVQ2n2tDiUyaGhM7dkSKP4eZDqs9vENQ965KKncFoDTs4XrWavElDcto/2hqOwLLrEtH/jsquHl3QFTj5Xly7AxcePX3LLvUZbTr7e/99wtJBXdSgeUU41PnARdZDZkXwK271B+OQQijjvIVYnV7LUtt+bqquivNs2GsItjmfkUcRmaepG4AJ2qHzNW/gROIiGhO4HESDKkr69GOTe/sN7QKRF0/Mc1XCqNsmR3aCiTKoAoJdxms1FIEt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZYcwTAdH0GqvnMo4OsPmP+UE/wE8OUVwq40WCBWYxw=;
 b=HhvVYCbLzDQGNSW9km2sBCYM/xgWODyQA81AISfBzysxIrUpwYqGayajfZJ9MyuohTmDA244xfOIiGCaaJmE0tf9Mv0vttGvXKpJQMFWJ34qwonvHwEUQZRVaO7c6huUySNltqixOPodRQr1UI5KA2VZxp1b9DHT3Uuh+nBMMNHQ6ds0BhhPEuXqso9Ow9qeDsZ4fys82njbdZHBS0N4CrSgimPW5P7g/GTV5r2kQRK12/yML4bzWKKDkOPWCoI7EyHKeTxou3SM4Wrx8IuaRMD/hLy65V48zHhzO2rCeNuvshBPN9+2gD1LMavOBWz8p5rbSrmNaRZutWc6YL+SWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZYcwTAdH0GqvnMo4OsPmP+UE/wE8OUVwq40WCBWYxw=;
 b=Po6kK41dvOIMNlWOk5bk+hxMjVFeutWWoGN6ZLh75pzxbpnIzdmZfsZegSv6e0Tld9PRh9aGpwvVQCzns8EsxE3mbPXgEeHyPGvWly9leB/IVDWasEiftp2pbHSguCO+qBWQ7nUm8hTT+6kZUhE529GAYSbA+wP99HkzfXvX0YtkBO1N9YMWKXdhlnphNfcjIJvOH8O76Jpv3XDbtX6zO4fhD/HtvOzu4bxTBIANCS0tlTO5sLXNjESSTYbWAC4LI/VhNS42o7IAcQynQ+/PgqsScBB5BoNQJ+2u10m8p7KtxWAXLYeL12N9n/r3Ck6ekTmiXoYjsjm6WTkPcjuvuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 05:41:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 05:41:18 +0000
Date: Mon, 11 May 2026 07:41:15 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix ops->priv NULL
 pointer deref in bpf_scx_unreg()
Message-ID: <agFr-3LePqqQQ14m@gpd4>
References: <20260510224332.2011982-1-arighi@nvidia.com>
 <a9e31398c4fc7b6ad21f4d9817eead12@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e31398c4fc7b6ad21f4d9817eead12@kernel.org>
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: a29e3523-0f6c-4cee-8d29-08deaf1fece0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KSD5SDiWPGkg052L43jL78bQLcJtICPu9elp04cZ+zca01AnbtVa6PCQCV5JhCt0yycpPKwhqTDsjDd3bJPS+0HyfIl2orh0JfCjsxxxssIBaBgCy+SxXe2zYXDF469ebyU6SS1aiZHLfeYw337pb/xwv3Ivw5pH220msY67NfXD/0ZU6tcZN0Vxgsi93K5asQPpxPPhNZ6KfeFhJMeZ1326fKwFwVUQ6PatBQFnsxtGzMjB65VI2PZP98sXsT6uY712p9WYggiK7yLfIoG/9aicecsViHGCJT3WlzjMpaiuymRiezw1Z+XhnXZvm6JW0yW08SkJNPic/pJpXDJAP6vIa2ddaILpIF3ZtYC07Zt4eMaGJJRCzCkqDqWM5+EMUQ4opard5vUnOrPjDDzaYsxQdR5ZIr2rfa/mMJ6FSK/8CSJUaUroN8YNehT4d6dmVi6EWC0rVzbcfS+uixn6BqwlsfCqFQHxWpwgrBI7b+RfTtVtMGJE9jNRZURZU5kxiI1IOl5eUgNUkhEJo8qmkx7Cu/tonJuBfJRnfxSu0agCjnpJuL5lZlkFIsrIixfTL+HGSATH+88sMLgKq0agIW5t9oDqOD8W3OodIeMY4CFKIIHuzUGtlFQQY9SuGl+HCrIvICXd0KW6JYjlEojedv7sHmdHoSyLP28RHxy8YR5hcTtpaSW8rajGhPVIVG2z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?knWw6MbdRhBtXlfOc0PtoxDB78KDUo3HbbLmmBXZ3ugYUNy90xAI1U17KohQ?=
 =?us-ascii?Q?IDxniOBzY0Q1fsA9YbxIecy4VZKoU90ZbTWQaGvA70Pu7ocV6Js/Gs3s/H5U?=
 =?us-ascii?Q?+QdFXc/omQwlv9knz7yNYiN8lJVezi5IXHf2+nklpPTWLw+xok6hoVKAYVOK?=
 =?us-ascii?Q?6dxaaPxqCevdA46D/jGPJVZPe9+q3/PXyb+Y7ARXp60HnA+LRLF6X+xvbouJ?=
 =?us-ascii?Q?YUdIEDfR3yLqXqRJxDzxpqFLhNn6eiIjT5FcPs0K1LHrlHJm/yNxrFZyJ3iF?=
 =?us-ascii?Q?f/sJ2aNpDmnsZN3aoyxoY8XDDzGqkjy4KiWDgvfeeLZNCE7iihRRSSePDGti?=
 =?us-ascii?Q?nF2JsfoiiRVo/Zt+AWDEqfJNKKt0BErhjct0QNX7/s85w7SnTYklOp1DMkaI?=
 =?us-ascii?Q?7hp8huvk03Te8viwIuvHeWLswTEQc1cR5MNO8MiOfneEyf3wMHbyVUXHXQlO?=
 =?us-ascii?Q?Zb2GbnzRI+LLSOEm+lnYWBwNzLimPxAfxd4A8XCBUYNYkeDFdYxliNt0BdmH?=
 =?us-ascii?Q?hlHMJP3r9kRlHa+kee9uyiZfdxUXURbuVauvJhNE6FLdT0fj8BHzkGxospfu?=
 =?us-ascii?Q?JvJKXOCfqpBZBsfqIcqGK2qzcFeteUp6EOxRxTnaZ66eQ9227qikGqBepSGi?=
 =?us-ascii?Q?dXnz6DPqLCzifqoKfiZPDrsvL/OnWZuvJGaNne6vXguPbWbfXfgcYf6I9k6i?=
 =?us-ascii?Q?vw7/cayktf+7qbSxduD4V8BDkJh2WGVpfQCjZw593fBKwvTVdUgQy1YvuFbR?=
 =?us-ascii?Q?ln1YKvGJ8Ol1LEVjnaUoPahSBlRBYjKD/SKCkwC6T90aktfBEMcI6DwP978Q?=
 =?us-ascii?Q?MbdsONRCm/oVciDipNgoyIaeyldHenyF53HXlGevdzCPeWoP4aGnkPTSzJXl?=
 =?us-ascii?Q?AYAF0RiS/WB3V1633KdvYKU7hzNxWde+3XQgGtZXOic1sSSGQ4YYGuZPXSOP?=
 =?us-ascii?Q?kHjI4nC5zLjvjbGA6Ps2wbW3CtaRFafv0KlFtCyuMwXhfSa/tEkW6nt7CCJl?=
 =?us-ascii?Q?TDa1lXnDh110GzIgzJQjnyUkBFTdmUZOXeJGO3snba8NomdOWgXTpaN1I0RU?=
 =?us-ascii?Q?aEFzS9hLqVJwf0nHpmAic1d0i4NM7APActcld4t8Wr98z5F9W9mWju5OuS6s?=
 =?us-ascii?Q?6dcrNPKJSLsEyHHCTi6bX3CK1WN42kgaaLeykop+QHwa/V7P8ZkA5ckmkw6W?=
 =?us-ascii?Q?kWRx6hABZnk5Uzl9p8hx64Tc6GHb5TmoEaw1olB8sBV+Qlc3n3i7jCd3aE2h?=
 =?us-ascii?Q?T2Pfo5YfDJ6Ys3nMVVzajCIF1ZExcYUglpqA6ZjOLcLtOxZ6CvYX2tLvAe3T?=
 =?us-ascii?Q?Q9/eshjxdFJW8SlRZ6JwWwQPzRyDtUC6POaNfyQimDhbOF812x0W4nYPlOn2?=
 =?us-ascii?Q?qs1z3uexoxuyTYMBCByKn6SMEpaogb/EqfkfgJ+vY0LUIh/fiuYxypyfJrJA?=
 =?us-ascii?Q?N/j95LzzTonYfi92iaev0A54/k/Lb4JBXFRMU9Vt3MCFK/7/i+FZN4SXEOve?=
 =?us-ascii?Q?1Snh/EDyS9QLQZHM9ZKawaDHnizplYMg8/HRo6zMAQpE/o18ORmVclUH7/my?=
 =?us-ascii?Q?7aMTpBhoYjnKZ7QwCm8LLOjMWXE4/DUFPKseiNrVIyKU3N7lt7pLt90Wp4U5?=
 =?us-ascii?Q?+gdUTyApmFNBQKztPbtFG538Y0KnOWl0l9wjsWcX8HVZeffi4DRBYUnM+weQ?=
 =?us-ascii?Q?Q6dVaBV95o06S0KOb9hMHCE0YNYrqNBtFIaJuK2hr6zab9RG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29e3523-0f6c-4cee-8d29-08deaf1fece0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 05:41:18.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxOwjbY35O8xpyGEQj718wFpWVssni+1lXJ5Ep/QtlJYZHUsWJiYI1NO84PrMm2p0XNpzJSXzDiy2EYKXqbdSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244

Hi Tejun,

On Sun, May 10, 2026 at 04:55:30PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> I traced reload_loop with per-CPU ring probes around all @ops->priv
> and scx_root assign/clear sites. The race is a stomp:
> 
>   T2 unreg(K)                       T1 reg(K)
>   -----------                       ---------
>   sch = ops->priv = sch_b800
>   scx_disable; flush_disable_work
>     [scx_root_disable: scx_root=NULL,
>      mutex_unlock, state=DISABLED]
>                                     mutex_lock; state ok
>                                     scx_alloc_and_add_sched:
>                                       ops->priv = sch_a800
>                                     scx_root = sch_a800; init=0
>                                     state=ENABLED; mutex_unlock
>     [flush returns]
>   RCU_INIT_POINTER(ops->priv, NULL) <-- clobbers sch_a800
>   kobject_put(sch_b800)

Ah makes sense! Yes, that's the case.

> 
> Reachable because the unreg waits on sch->helper while the next reg
> runs on the global scx_enable_helper, and scx_enable_mutex is released
> inside scx_root_disable() well before bpf_scx_unreg() reaches its
> RCU_INIT_POINTER. My trace caught 11us between PRIV_SET sch_a800 and
> the clobber; nothing bounds it.
> 
> The posted patch suppresses the deref but leaves the stomp. Each
> stomp leaks one sch (the "sch's base reference will be put by
> bpf_scx_unreg()" contract assumes ops->priv still points at it), and
> in the case I caught, sch_a800 is already SCX_ENABLED with scx_root
> pointing at it - the bpf_link is gone but state stays ENABLED, so all
> future attaches fail with -EBUSY permanently.
> 
> Suggestion: make @ops->priv the lifecycle binding. In
> scx_root_enable_workfn() (and scx_sub_enable_workfn()), after the
> existing state check and still under scx_enable_mutex, refuse with
> -EBUSY if @ops->priv is non-NULL. Unreg side keeps its current
> ordering.

I'll send a new version implementing this.

> 
> One question: are there other paths that write or clear @ops->priv?
> I only see the rcu_assign_pointer in scx_alloc_and_add_sched and the
> RCU_INIT_POINTER(NULL) in bpf_scx_unreg().

AFAICS there's only the rcu_assign_pointer() in scx_alloc_and_add_sched() and
RCU_INIT_POINTER(NULL) in bpf_scx_unreg(), no other writers/clearers. So the
-EBUSY check should be sufficient to close all the races.

Thanks,
-Andrea
