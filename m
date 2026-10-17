Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB438F950
	for <sched-ext@lists.linux.dev>; Sat, 17 Oct 2026 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264322; cv=fail; b=Ot3Fq+d17dHpqPGe3thvBgOCXz/Jf+FsxGiBVy1EJI/9Bq4zMFkjk6uiGp+VKXxTODQnwhpAK/VEpdJbSPBqhdT+PfK0sROIm/HV7f8vEDk3Pdi0Ic6caq/J0NojPzRvPBMphvY9kTSprfjLFS1QY7NQqPeVVDhqFYp81edJ0zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264322; c=relaxed/simple;
	bh=jDKoKYyujan5NbRaILO7BB92A4Kves8VL1Y45EVN2vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JgH902YNGkILfpfEFe+QyfF2d3zW2UT2VpUKqulynOWMzoGhnzl7eqXp4s+1YNzrCYLKooE+6O/N7kTv4HT/d7bGxmlleC2GscdPTRFmtLSSVaXOBZuYR3x+5DTDURlZQMGj8zxzP0vg4nO6lbuNrLGn65U/k9PMqO1G8VfHpws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NK16TMWt; arc=fail smtp.client-ip=52.101.52.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NK16TMWt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPKfOorCtZhmbk4oEbml5U5L5jabuSgr7AzmR1GqBR9/mxs84JueyjTMrf3hWVVBQohm39ZADplh0P6UOGp00vBVwYq5ovi2XSjxpR1fqcQkyxxyPCiNAeJmwfR6Sl0HYEJIiN6ExPbMpwz28HJrtX+5xJXR1gfaa6IzkFv/VzcvaMkAsJrySB2RSNNCkAhqHYO6R7U/eJxVP8Ow7T2LoU/RcneAvWekHHVY59ZszPjntn61I/rBBWZjEHBlaZdej+W91BuYGC+X42pQcmKw5vgN8atQeFkDxJcFbyNb7MXTIS+n2ZepeJAYZDC8PkJXGZ2PHHSetrJBSdzcameVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yObUqLZZnbDj4OuPuSHhwiSqvE2/FY5vI2shDgzWfTU=;
 b=dNSRdNqd+d12/URb91UGztUPcScXL7lQsv1Whr5RGN8gGSrPYpA1xyHoa6RlMBfwTX0Oan5BbrI0p+nv8lpftesU+8QfmJcq9n0zvCiY2mIaNDfDIi10pY9Qk6RDDsfIJvPybwBZWGN6XSVj3HOMNWgRL6pAfJCx5rGWh7NkIM7LZWTCYG6ppMNiKfpQYpOsY/E6vQsEoxFZLH8ZJ7JAOI9AxAgnEzZN9QuC1RqQdg2E35EEVoQktxpMVpbtb3cPM/mYsS/9e/EhzZ83POJMS7eHUF4hC6vsCHJ9Sp+N1BQ3zEYLQoMcO4IaC8Y0FmmcK/LNGFHwCFco1JBfCJ6JMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yObUqLZZnbDj4OuPuSHhwiSqvE2/FY5vI2shDgzWfTU=;
 b=NK16TMWt7g8F/zYHKbZcfb2AgzH8jcovTihjKt9PRT53bbI0+K73LZaGylmSeKOlETb14fWaqYzSOhA/mItRnTu+9iw7xNhyvTRxhNgZIVmQAPBlLR3mxutJ5eWg+fRUJIfrxOc5S1CWZdUDXMSN6PSNY1T3MvHsNP7wPauEcyAJsxHTm67vIPFnAINoqXp36gCc8+MinYVmZujSETJEc4f1XF8AnHXREU57RKOsLSi3wZTMlhYPnTwW2pw8P80Y6fA66NEc5AZ740y3j0Ord6Ma/3d3pxTwgxyrx7m+DtZQoOvPekZHitUt6elvRhZa2A6V2LEvpDGVhBmBCJokuA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Sat, 17 Oct
 2026 19:11:58 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 19:11:57 +0000
Date: Sat, 17 Oct 2026 21:11:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3-fixes] sched_ext: Don't leave
 balance callbacks queued across a pick retry
Message-ID: <atPIed9UKQfUfiuB@gpd4>
References: <20261017152226.3690249-1-arighi@nvidia.com>
 <fac1671153b59deddb9847f2c5d946e1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fac1671153b59deddb9847f2c5d946e1@kernel.org>
X-ClientProxiedBy: MI1P293CA0009.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::6)
 To BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 914b8632-9c17-4e48-83bf-08df2c8283a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|4143699003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OeddFjzjthg0y/OWGcFMp41R2qq7DgO8MRtO/lVU26AzrwIBNy3J3MzTCwkemHjWC3NN1uiAhW97hLMn6rgL+T7yt37KV7MQqmMcKXO0yJ9NVdbXvi0MuN87wrGOsExr3nQICL4Q4/ezYVMdgx/vSAKcVQwLOOEMhJj037j8v1vjYdrv+pfn9+LeFGY6raQ/JKtQA4p2Adm1LF54I+BsrW8BhHdv5V8BjsPsXgLkbsEm9haVsGgJj2SA+E94sR/ZpcdDiiclGaV0PYVZD3x/btVK0QS+wUcl7Cl39yas69uASDFXoDEYvt2Ce8vixkKBbOete1pCjsO7qikOMSEAzyOB/R+QHmD0Te78oetXj+WYcUWikBVQVWwed0s9StyzrE/xxXwBla3sNtT+VgOCiNCtGUmnKvzalTp4K4FHwIRTraikgQlQ5Iw5GJ0WHxVgMW/8JxPyMe8ry0sbOYhWj9DCAL98rgZ9jmdVqeyc91gdhKanNNuuR4/il28Tg1jWl0RbotvEgWySGAKS6sG8xqPL5z4Trs8xdk+fUL4NS6HlD3fErluDj9EsqrZm1mBHRGgYRbEiqbeT+EDDwnMS8TD4pFP3M0K9XO4wQoE4FyMKbQmHRBGTw9ty9Bcf6Ev9irTeisqLV4eCGHnHJmmDEE/BmFzkRjtFJqBZ2mAegFo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wWx2vn/Plsu1q7Bw8GkIFlaSt6ZrFiyeYMGPca05kgkLP/seF4+ppYXNcoGl?=
 =?us-ascii?Q?T/4/2lkaD2IdCNBobPRuDjqHtGRN5R9xULrMKaCENsS+K/TmIsR8zovETmwq?=
 =?us-ascii?Q?zvCqxmgycs7GpG4WmqAYXDI0ZZWxNWmWjrIw/cj8anKJousJNE1DxAD/zuLG?=
 =?us-ascii?Q?lZ+5M79lthLts9ciAhfSBFH0DOlBqn56vHmNkzI1xfVdGF1G2HbsV5UC9TNz?=
 =?us-ascii?Q?5cR2ZR8wJ8hKOLMhlHeVrDRPLmOBCc0SzsqjJRr0e12xO99aV6kpJXSABQUL?=
 =?us-ascii?Q?jnNQrb0pqIwj/kQS8u8HIqkizE9gIwApy938ymXSaJLH6b9E3FKqHhS9iea/?=
 =?us-ascii?Q?9uxNooebPrMqFCvXCUx3fyyjq+IRL9fqTo66RCl2wPvvB8Ip1cF/Aq43+MV/?=
 =?us-ascii?Q?RucMvz7l52U1kbNW9FNUZuftxQRCuswHWvhmp5/NOiVzoJxbhtiZkenhOzHC?=
 =?us-ascii?Q?08P1X4jAjqweYECc3d8ZgIbMO4dY+oZzthAx2AexYmsnZRC4zO2uQhw8Fj/o?=
 =?us-ascii?Q?dZ5su7Yg8pzgoRLMkHbvAcipDtmOEFFKTpSccaXsK05zFh2wROYdnM7xToIg?=
 =?us-ascii?Q?Q7hg+7gtA62IzsNRNXdOkaplJAyuEnbNUtLRS/TsfGLgCJLvdGAqcY2baEw8?=
 =?us-ascii?Q?jZABN2CaE+rbgG1gysZdgzbY60T4oaXvugiv9ZYdmlHIX0YEAiXk8qtL6OdJ?=
 =?us-ascii?Q?QbpMEu2v5O0CZTAcfJ8Bj1sqkfvrzcx7nedJuwdeEdcldGWHOXipjPPd2bkj?=
 =?us-ascii?Q?/0IlykDfRDZj5TqGQejtBaqDJ8OPrkxN98Eamtdex8+oEydUFlgzQVVtPv1Y?=
 =?us-ascii?Q?IcQIZXLViyC/X25/Mx2A77P5cDcRbX7tVDvRY3lcXCdnnjZMj5zeEn2qlMH4?=
 =?us-ascii?Q?WM+UhKY+dK+/a6UGOFnuxP4s7Fe4Y76ME7QFUEXqEmxiKNuX3A2U2ZcPaVHS?=
 =?us-ascii?Q?Xd55P4dRGM9wuoCYRYCbyxwrpe5lQfXEJypT1iGWvYGF0kXnVcgJZvvO86BU?=
 =?us-ascii?Q?Fb0FVqZxL1HYl+3OpAJ72ZHfJ38lu1k4W7z0PIdaovri5tXaPD7RKDA7dEzR?=
 =?us-ascii?Q?g2tnLkODgSokffd6xV0Tg2wDPnqqc9mdg/9BRxxD9RakJDAjePaDTvZzM3Ek?=
 =?us-ascii?Q?x8FP8+/eHJIEUsP5Bw0aILcGEtxGZCKWvlJbsPVDKftdmPMs4wQTgexcGRBW?=
 =?us-ascii?Q?3O24TJ+v/7H7j6fClleMoYnU/OGs8EMwsC29kswyqGbwPfCWe69ul3n+WW5V?=
 =?us-ascii?Q?DRMJMfcn13KSDWNT+tdNBhgM9Uk2hZ8JCPrCiu/hQfTBKtRk6Yz2RNtnFsI0?=
 =?us-ascii?Q?hZIAfXBXCXzocg2WTxZA+gloTSL1SZbAUwqbkSmTqkdf9o/Zk0pjkzrbcrwk?=
 =?us-ascii?Q?lycBDu5iVLGHb5VeVYqpttj+NBYH7EfNkdLOZuRIGwe4RnrVSC7XI1XLRswE?=
 =?us-ascii?Q?0JUXThB1GMV8LfVS7pfe75CGll3YSBW7vmsBXfw/9OzAKTlVkIymaT71E5Vh?=
 =?us-ascii?Q?RJfuh8SSICH0c/XZAfVaGRGTYcSh/CYc8TvQ79hOMgMNGZvY+YSuxD4eOv5P?=
 =?us-ascii?Q?suqBdP7A9HctdMZQYfHaA0DRpIJTr0ZMP1JOLa1Pn02UdJxFWijABsAFKH+b?=
 =?us-ascii?Q?cZheLLqwrN82SLCnQc+9BSvkvAFoXR1PA952dQIeKprOVoTSyj/QaMxOUEsk?=
 =?us-ascii?Q?pp4F3O5toLVJWi5HcemdgUdgODasvkAgrN7hwjuJP9xAgNv8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914b8632-9c17-4e48-83bf-08df2c8283a9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 19:11:57.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWiX4xJ+z8MXYbY+bJ47HLcCbi4PXqWSURrBa7bZXTH+q8kyY1uPoq5grUN09CLkhDHMaSi9iBiaQyEexojOYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115

On Sat, Oct 17, 2026 at 08:44:54AM -1000, Tejun Heo wrote:
> Applied to sched_ext/for-7.3-fixes.
> 
> Thanks.

Oops, I was going to send a v3 based on the review from sashiko. I'll send a
follow-up fix then.

Thanks,
-Andrea
