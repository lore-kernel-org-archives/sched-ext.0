Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10C3546EB
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479345; cv=fail; b=X8/70sSeQJHCMK6r7Q6Fth+NKPR8b1IxCHE//bvfa2mDYW9G6uMAkSyN4TxCTXK6AFkeDqJhmeUeJY5jQuSTenNOiprQ22wyA5vlWXg1kLLQDqvGnLMQT+CTRGyW98dqG5XUxZI4Jcn5gFO+a8YEIVpda3lyWTkHjaoUlfRxGq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479345; c=relaxed/simple;
	bh=aqQgcaPUUk0teXvv4hHNJ5tBdh2jRTFXSYvKs6dvmDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T5w+eR9zLiaa6RaL3iq9h/6X/DPN03eMxN3/czGAcmv7pcuHfqtff4DAGU/wvJtifFioy70sMAEG9q7cd6HG+G7Cita6IdBcfK65CnFagCyONgBkjvJ13AA4wV3HLLVAJnUgK/ojw8xly6kYA2D6Y0eB9jKVla5lIC0MApep3ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N2bUJ84p; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N2bUJ84p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIgdBz2GzgvUkcPandvxG/HK8Xbzx2J1Xvom8dNKc0ajTBUbjWv0waL8OlcHQKIejt9SdKirR/QwunZimt4b9t/IBPbPxRU8XqI4NIINutwlmCZNbvPJ1R0ldIxOp6XH17dDAnOuZXT8dUOZ09f94JKUqqEDo3fjInR/hMo9hJtVK6e9JqWCs0K5TMjcsB7/C6BI3romZ1PRKf9qeJ8+liQAmxGJSnr8dulopyoBfa6/VewySf1RH3J74LvEhQiiHlL7k5EyZK9IY5lvmQL6mz3+MrbqVOVwZqqEUNYSpwQV7+rvfEedbISQvLvOeEhJrTq6d/KAdVYGnMLrLMtB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20Gys+Luuwi0Gy6eHj+vOBys+GAMZ/wYvFbxaaBgm1Y=;
 b=vFtQ7MEJGQaQ2KLcvWE6qjR6+SYQWX0tjAlIJTnm73JqTdfNligzlR2tjInwvYcF07tTGjmFnHbc3PnmFnJcjMw8axHEYRXmlJkAXAwWy9fY7J+M9zTecqFb3QIFkt8Ebq7WQLfpDZv2xfXlRkrF1wrQkGUbl1+rCM7YpPEtfLdNO/JDiBi8/quCFvUSZZnOhIZP+gEBLTVIbgwOJDZi/6Z+FKqZ3AY72Hrw1ZWH1dZC+7B9EtjwGqL4nE1KMtigT+WZiOVkKNoxFeiojvUiHg1OKIpN17mUanKAyHx+16FX/p7QwepyGHj3tzbe88nhgkBCGC6rr3QUXD1gyFmlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20Gys+Luuwi0Gy6eHj+vOBys+GAMZ/wYvFbxaaBgm1Y=;
 b=N2bUJ84pPr7So0xBrXe/ZTza1mPmGKvqwgN8rn2YxyTNIh8pTHqamyW0vuwilTxLks6oLhLL4Xuerl7mPwgWbF12DJIhVvBlbbK0Bbw1AeiR372VtXdOcGeh8oX/bVgYjcv6osGaEA8bV1VlKDftXqIPwTH2sl3qVIFPnWf6sISWu/Rvh4CIOu+6vwmG3+RIc9/UgMXBSzLGeeHQjujOzEhqXp0d91iSHGhzIeDLMi1nFyYT3WA3l7VpfxEtpSxt0hIBeuShuiKNvImgaCXmh4o+YBanxafneRrQEyCN+HjZB+dzjdIVjyEeAPQ5O+fgBVutsPy30ZXqwPecRsvYmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 13:35:35 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 13:35:35 +0000
Date: Tue, 15 Sep 2026 15:35:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add lazy preemption tests
Message-ID: <aqlJnaPRbhncTbcQ@gpd4>
References: <20260914084955.1798562-1-arighi@nvidia.com>
 <20260914084955.1798562-3-arighi@nvidia.com>
 <20260914225115.Gb03c@cchengyang.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914225115.Gb03c@cchengyang.duckdns.org>
X-ClientProxiedBy: MI1PEPF000008CF.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::42c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 899d71bb-f7d9-4f87-88b8-08df132e3807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	WX2iKZr6jw3Z54bkTnjXq7xmVzXC8pN/TxWm/uxkF1F5ShO+rRh0cwQVfehv3Z7yFI7EnV8NTk7xwA0qUqB6xuRLjLpp/44ae+i/1ywDGJluki+95dcgbMMxRBhVY0XCiMulOBVPLhe+RBnd3ABV21mc+G8A04NOq3mQBln9yU/qO6Rll+r+ZRnjjE9nlqPUfey4sVlbCh8ry9UA2mqsQGAEjLM5P6eZYpAtfHJQ8LmcFkC4sip1P9IUZEIFgTpWmQZe1XoBBx/LkYnCKySk0y/+qEg4WtKpkPTer8Po8Jk1QnFNVMCTBw23lUU0p2idAeqZWaN+jNPMS62ZAhZ43J8pKR8eHZHifxCJ1ZV05fcmDbMu/bcABP3Wsq/NTrqODvn54qFNvziS/9BLwdCOu84alxMjLcxuFP0i5fI6fzVcD4t/TpRXjjeD54JnJzFzcPXt4KA7GY0X+Bs5NOfG1NSGnIXrMAJMgzQfcttZUbWq2Ufv5hNuvzIqc4snsuqrgD/JCe8iJhosvtyfbXr66CtBS1D1WXiUacL2+3siNR2XRGOFPbRA8WrdPJa1o+G0E3OKNXM+i/FrCjJJeneA6B3SeIApJp7HSg2SmREDWJACMolyGUaHPwpRh9+dnLBwVlTyeL6HZI8g2xthxaIlWITQmZsm020nw/rBauJoI/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7QHbPGLqK7qHJhwdv/6xOIbcX7msCnMH4z++nAgbCzDooK2IA5c4G8zM4UH8?=
 =?us-ascii?Q?FYAy8FxmgBxGCRURWR2A9fUGo3Dpvz2Uraa4+du015iTOgZiEu3xvl5wJJ7N?=
 =?us-ascii?Q?F7A4YtrRsJC0bD1V2s2HGTPoptn2VOBX21Jam9iYOY28aZfR5jRatO72a2Pm?=
 =?us-ascii?Q?0MzlPzxXafItN9+LanAeqGgI5VqTu24LGbs4Vz5TAfD2mCawdMXKKAZ5Kpc+?=
 =?us-ascii?Q?QyNaetkFMGHQxSsI9Y39qqua4yBsauYCGQpAqomV+a0J6dJqALAT68yognZQ?=
 =?us-ascii?Q?3jnIeIgZq3rIbL+Xz+z3OBPwgJyc6x4W/OpbB8W1SDTkcgE0BoMT02t5rkzT?=
 =?us-ascii?Q?aWUTkQATjvW4JfVgYmmSbv0IW6H+qcg5LCBk89iipV7qjVBM6mGcAX8u53TU?=
 =?us-ascii?Q?4llThBuSWx9Ue0u5UJx1ugZZ6QpWEwFTshfQHc+48oqAvxoMYiwuAcZyIvn4?=
 =?us-ascii?Q?SQEi67UgTP40/HaHsz+lbyFXDnYslZMnZ3NcVtEmvIJ1M4U/ETnB3uf1gVzs?=
 =?us-ascii?Q?hLM7xPIU8eyzaAnek9tLgbVbE4BeLqlF+qPoMTdAZFlooy+piNVHXZf3ufQC?=
 =?us-ascii?Q?/eSByAnLp6MamFGJ5SOKS9TatmjEVwnj8L8PUDKn2HktDYumEysOf0PSTDtL?=
 =?us-ascii?Q?bL7kLT/zURtzbXEX17AMiI6zMKtNS9CLGfhE+FDxuRI3WuDmX0WI7NgwQKXx?=
 =?us-ascii?Q?haZ5QYpZWlvluu+5ts8V2D4F0E/EF0mIZTujx5JSQYfjNA4SJnKqTx6bl6dN?=
 =?us-ascii?Q?kvLxGU0EuOFP4ceSOw4dg8cfVRYQVx8D4EYjtlF1/cFmJWiSyJKb6kwiIUCs?=
 =?us-ascii?Q?XPXHO1eoIvgfg+4nHcxwTjV2kG6DThGxotzh1GpPLd04eotDmXwSrvw9cffk?=
 =?us-ascii?Q?fsmT6fviQc3ktYL/kXm5oD3kKpyZdRIyfE4aduskc+BrUmrjcE9I/3mHED0b?=
 =?us-ascii?Q?dXCMEIVUEyb8/49G+ZADqv2nqZGjWM0uG31nGNhY8PpBxpHrlZafphtTu8ym?=
 =?us-ascii?Q?BCpbpEGhs4O4x+7ncAJ8QT57wEAF73p6H/up1stvUncj3dUGq1tMvt561Q0+?=
 =?us-ascii?Q?VVpkSTZNBkIwgcu8b6Us1nVIlItvWmY8C5mYbn2C80wnJzGt8dBTD1ZihLyU?=
 =?us-ascii?Q?Ci4sBz/xC3p+EHbD7YDuEQid8IeeL1Vy/rcVRp+fAPc66rZhYAnA03vomTGX?=
 =?us-ascii?Q?fBAo/sFLOx5ooLpDFU4BL1ze6DOeR2VVSw1S8+Xe8ceekaFuvDvRZ9tmm7QS?=
 =?us-ascii?Q?ufwcjQ4hUsPPEi3vYfDgOoJg5NfiGYAGk/ZdHTrjGjFV6CHgVgO/W1A9rbRH?=
 =?us-ascii?Q?xpH46N+7jTt638upCzYJ3vTRuZA0mWA1ID7ZOBiXyeUWJ1lziYeBI2Pvk88C?=
 =?us-ascii?Q?4qEVY0u1AKWAL9XNAgpnvEu4gWD6kwHxQB/z6NhWhHirTCoupyUsaZR78nvn?=
 =?us-ascii?Q?xLMoSkykdOakZn4n8aOMM451cVNxLu73m7CdrXxXUS6EJhQjDCmDz1V7psvr?=
 =?us-ascii?Q?6+KCKiCqRXTSDB3YtTDbxbAfI2b24+vFRFqsc4JSQg8MB3k/u1BCv8YvD7Tn?=
 =?us-ascii?Q?mbDCrcyWqeOQfBnkOlikT0avMKKCIxkiGsqo49xNJJYPJmEUH/Y/rEBLL8At?=
 =?us-ascii?Q?2adFzouC93B4DTU5ta8vCLtTrXK/OcSmrY3dvpLOlJPMA5JFXeW8JhpSO+Oa?=
 =?us-ascii?Q?3BvuP3oXF9cTv4xXfFDSU/Lu2Fjwmt0awMFe47/zxDTCe8fC11vPEIyEWiE5?=
 =?us-ascii?Q?kdTx/Edm2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899d71bb-f7d9-4f87-88b8-08df132e3807
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:35:35.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h24+BK/2WRfYhZgGzlV3+rq1euFG/M90flig4ap8jTjLztQx3RY2e5pHGYbRRhj4+4C0YdRhguFifESTusvgwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279

On Mon, Sep 14, 2026 at 10:55:56PM +0800, Cheng-Yang Chou wrote:
> Hi Andrea,
> 
> On Mon, Sep 14, 2026 at 10:47:46AM +0200, Andrea Righi wrote:
> > Add trace-based coverage for immediate and lazy preemption. An fexit
> > probe on __resched_curr() records the requested TIF and the current task
> > slice, while the stopping callback verifies that the task reaches a
> > scheduling boundary.
> > 
> > Exercise kick requests individually, in both orders and combined in one
> > call. Verify that immediate preemption and WAIT take precedence over
> > lazy preemption, and that combining immediate and lazy enqueue
> > preemption follows the same rule. Also test overriding the expiry
> > default in both directions through scx_bpf_task_set_slice_expiry().
> > 
> > Extend the NO_HZ_FULL test with infinite-slice victims. Verify that lazy
> > enqueue and kick requests restart a stopped tick and make forward
> > progress. Keep invalid kick flag coverage and skip modes not exposed by
> > the running kernel.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> 
> [...]
> 
> Didn't have time to go through the whole series, but I applied it on
> for-next and built with PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n:
> 
> 	INFO: preemption mode unavailable; lazy TIF was 5, immediate TIF was 4
> 	ok 2 kick_lazy #
> 	INFO: preemption mode unavailable; lazy TIF was 5, immediate TIF was 4
> 	ok 4 kick_tick #
> 	PASSED:  6
> 
> > +static int active_lazy_mode(void)
> > +{
> > +	char buf[128];
> > +	FILE *file;
> > +
> > +	file = fopen("/sys/kernel/debug/sched/preempt", "r");
> > +	if (!file)
> > +		return -1;
> 
> sched_init_debug() only creates that file under CONFIG_PREEMPT_DYNAMIC,
> and PREEMPT_LAZY can be built without it ("select PREEMPT_BUILD if
> !PREEMPT_DYNAMIC"), so the two tests pass without comparing the TIFs.
> 
> Would something like this work?
> 
> 	if (!file) {
> #if defined(CONFIG_PREEMPT_LAZY) && !defined(CONFIG_PREEMPT_DYNAMIC)
> 		return 1;
> #else
> 		return -1;
> #endif

Ah yes, makes sense, we can include autoconf.h and check that.
I'll include this fix in the next version.

Thanks,
-Andrea

> 	}
> 
> Thanks.
> 
> > +	if (!fgets(buf, sizeof(buf), file)) {
> > +		fclose(file);
> > +		return -1;
> > +	}
> > +	fclose(file);
> > +
> > +	if (strstr(buf, "(lazy)"))
> > +		return 1;
> > +	if (strstr(buf, "(full)"))
> > +		return 0;
> > +	return -1;
> > +}
> > +
> 
> -- 
> Cheers,
> Cheng-Yang
