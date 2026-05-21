Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D501E51E0
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779342826; cv=fail; b=mQPB82hEurcjYpd/n3JcL0f2fMC5SU8dmfkaybWZXGSd5YKVnJzyM8TvtiZzIOr0Hiz9gEkA6PXymRvdYZjR0jKIzTmI48Yg3ecjuMRTeQRpp2d/bxOfP3SOzQBep0f9DaFtARdV7nSGPqVXFAayPp50ctSPvOtiq6+ylowsDqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779342826; c=relaxed/simple;
	bh=S2tvoZdXp1EYVK0qiSpwbetkY46F07AlzVQC6zqNu0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ctGDvMG1NB/K6ASx6qBnyYwOY/9pfUnCT22IeOJVQNeXWmg6UmB8bG6SElzAqy89YRLi+Qm7FWmggduIA2dTopw2MVyZpkAOBQGAC9nbf1Rfv8WJbuxwQKao7UsGiE0/4Tp9TZ7qQCSPrv14+hkEhCsrNzMnG6HfBPCWgE0Df5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hyUJIqDC; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hyUJIqDC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezMM2B25/KIe06NTEYBDMKevvvqXShs452L+Gdrjco2s/ykv10M5Umk36H6j1Ur5xw97FMEnCOjGwrnk1jAH2kpb0giQ2ELrYzYcvPDgSltkRRUz9ZMVSPeNeCjCIBRB6BYv5DMGNTZ5SyfEL2RuhCkgTlOUUKMjGypGz99E2ul9MDJCbdAVq7G1fN85bwQ9NFXYTgx1ssmDIi4fC7hosRzej3Kx0HjPgZNR+nIMUqd1jMcAO0cg2J2DeR5bIJ5MW5MdXLKsoa4Y69zFabqGJMZiIVISCmASvKiNPmOPdEKiEnz6R3392lxLpaW3oRpCxoQ52eBvTDOcv7xvWsQ84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObkjtilisUf8BdsgxqXOzRmIo/47AIdt7GjsCct16IM=;
 b=cNyFFftVsvBDC29qDVff+E+CnGE9BHJB3RCMXaEjQCRxU2hf067w3D3SOVswxAIhNKF7Xaq22K6F3hFbC4VqLzhVY4m2hoqGGhLvBL/Ck82qNct0a55G90wYa2Z5lviLW2PcO2gy41leXBFN2yt891w903hBOCKMdGNUGQ8N1W5U09Cq0df8PwRq1K9LGBz1WmsFjdaMTUPI2KrceTog0YpYre04g0tF7ukCRz2V4yktCJUhjl7s/PX6/sMBnJy7u41WQGYrMQ0HCXvcQdzuB1M+C6sllGpn3Vg51iJLolVQfisebfD87NSO1YOmcgYJC++KSCM1j6yjojZj1nqfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObkjtilisUf8BdsgxqXOzRmIo/47AIdt7GjsCct16IM=;
 b=hyUJIqDCNfLx9gkZ9lJJIziB+SjnQRMr4gp2BrY49uEeqcDMSv300gerkaW7/1L06L5FLvcHme4ft8/WgzuiUuqkHLRkS7l1GVM93yS5If48uNVqOdalKh7HaOTUGfiQg29MrUb0W7FRwzCXFTiGCsEmeU/O4cehPQ80+X0DyPbp1TdslDcpY5qTs+/XgQa3DAHXyyn8QSeioZTyX5eHK0qxvDdbBaR4RNTGrLyFR9Kyp+xhDSTNAuj7n424tJypvhy4YOwxtJIbb6mlopuRhgcSCVN57tkRlgIB5xyiRyi8iyjQT0sgPrrPeRNzjaZM6gzoKVzNiIRiYm7k1wuMFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 05:53:41 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 05:53:40 +0000
Date: Thu, 21 May 2026 07:53:31 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.2] sched_ext: cmask improvements
Message-ID: <ag6d207V5CAVJXs5@gpd4>
References: <20260519075838.2706712-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519075838.2706712-1-tj@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B7D.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::410) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: e08145ff-c6f7-49dd-1734-08deb6fd4f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|6133799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	gejNEBxhpPjSGHsUwAp0h/MbdjdBqL3FdkM29en/FwEYkgBT+6bGAMMAKD95bnzaUt6HJxR94360Z2q3Q2+oWlj0PN+qt3YCUpUq6cCws4qMyHr90HuJmXwaF1qnaKU2Hq8Igg8PXZPnNQO3OK6fbKS6gAjZ3tH1G+JgKHf+zGL+J7mUyp3rLN1urf5ey40umNkKDIvONULeEnNQMl46vqS+Ya0UgnQ53X9nqb4JXWOjRrGnQEZIPcer2LzP/HoBjAIL2txaZl+4E5mvXX5F6447WZ8UJEJ/c3BLj+7xWKV5fSpX7MiUXJqMfz5R3ib4bc9TXJX9cM66INSTioVxQATODP08VR6Xun7+0NTwoL5K5akScKugWrXXB8wlXERO5ImXg2RY4AE/5HN2qwKB5fLDbFsFX8lPCaXH9/IkvP20F0MlBW1mbZyFKyQeS5HtYXFgjx2URIMyAfvf3/yRUVhmVM90R/rk9y+ah0LO/shPiqqSXGbYZBTJl5h8V14rNH9Zvhei8jXwf332pzznkj2vbouQQcTb+q5PF8RqnSs+Mrn361SYsLdFyOL41ODLxiE+4BkS6OKFMkL4cmDJc0tHXeokbKWJf3mJdtaqoeX/WgvFc3ESSVKdOtteHgqxA6DRfxQ7CcITkBWIxycQPIvzpj/YZoKxAL33+Kh9E0DVUEW2iyX0gr9WSiHAafbJVA4SRT1lKEEfk72G+iB3QQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f08cjmplgiOqH1GO1UYjzZ+V6mqaK/YUXIyEQmw5wYyJSV9QYORXJe/qjEgO?=
 =?us-ascii?Q?0zQKA7kLSOL5kRyO0F2rwdXhf8eihgUhf7Xp/sD/eYFY6MNKnTYUr+Z2u/zk?=
 =?us-ascii?Q?HrLpq9G5Gxyl4LtC3LpazdOj9SpccVAyJLoex0uB4WAuOpHLHlDOOBuytx8C?=
 =?us-ascii?Q?h1CC/Rvh0+ihQWEwj+wNYP2s+A8uvLQ/nSKoveTp2uVKjojGbDQptsOCHnP6?=
 =?us-ascii?Q?K1PnH3sbAhCuwo6v7FiXOGnXG/I7si3R9/CQt3zjWuvvbel6op2H4eCUWKfg?=
 =?us-ascii?Q?ZNixdDOqAc0ae4DKoU2e1yyQQnKXY0yjed2ostrIIDyGv1nON4upX76RymA3?=
 =?us-ascii?Q?3AfJ/KZ9T1e+e21naE8KNIgV1OGhBnoUXlutiETEyYrM135gaft7JPtZm63q?=
 =?us-ascii?Q?ns9WDipikoENYsQ4rEQH3U5C/+laFBNfTf0F254d1wH/2eJUOYsxHMUUA+pk?=
 =?us-ascii?Q?MZ5zttdHBccfCThi6S1xvmeKdyWfhIInPDiE6KbPs32EcD8jOtHklkWf0r3G?=
 =?us-ascii?Q?zvL7HDsnrwIJyLZm6YT+Oz3FJIK1bKm/t2JmFTah4wq7oHIX/+U/No5xcLMv?=
 =?us-ascii?Q?gkaQcNuT8ZTWK0m6OIvsdfT25Gv6JTM62sKqXUxXmrLqDFnt/A7QF/2kxrBE?=
 =?us-ascii?Q?mJYY1h0Zc7wDwSzYa4M8DrwSI4khPjFcdn3EzNPSs1LQK8Q4lmhpT5M9qfdE?=
 =?us-ascii?Q?ebD53USN4PwIIpIJh5XbzlhHG3bh5rGzf4DIiO7+iYeb70pYfz+x5I6NAXT8?=
 =?us-ascii?Q?gpI1l4up8gsFNcmhNblYB3gqP3PGUK0CEIEbYjH8DWQhLRzJN6StZzAAMUhZ?=
 =?us-ascii?Q?HoNg/AwEdcn7AWEcjIvSFicnZR47A5cdrSimeOMegktUrAj4gW91YtIr2M3e?=
 =?us-ascii?Q?l9lqTj/QQZgKKrhgeIRVZl5xKR0FeZwjZNc89bgoM8gNWcTG9GzD4u063/MB?=
 =?us-ascii?Q?gy8xcnuiGqJCWgN0hIceqrQ9JDMWvZTW2CiiwMMeel/gxejScElHfoWUFtJ0?=
 =?us-ascii?Q?7A+swDm1G+QVsa3+MwN4fVjg7+p+CHT9VQChLBl4xCUHMnUgMycEcSAebwdo?=
 =?us-ascii?Q?QIjxYACo3SSYXclAbc58isrsgxma4C2akfGLxHDqmpPtlQwiiM3oTrZK9ZeS?=
 =?us-ascii?Q?e86KIvWenCxNmQ/ONpGERbrxa3LmwB8jzHXTj9NEJPkPcTQim6O+WG+aev13?=
 =?us-ascii?Q?N9J1tNjDuqSSQoFIZ5Qeb9jGKGHh12oMJod0lvBRHiUbaMBTWgz52eiGjS97?=
 =?us-ascii?Q?BWtPB1oO2L50YeEHkM1WgLAdX8oSRAAch/3BgCp46rR4ybwOf1bYqg3SS29D?=
 =?us-ascii?Q?v6jhtdRup7O9BwdMYVoh0emA5DYI+uoLt6CHp4wu0ZBcevKpQNyVfnk6+bZw?=
 =?us-ascii?Q?tJBrDSs2PvDoTClaEuupozgIBqHUCnJEsTMkzhRNKXzs87gi7kejPoTOFm3p?=
 =?us-ascii?Q?2G6ymWXH0J1yvyMW+3oQfl5Zz9CVdxl4ZZ3mZ+RlUVL/oIKUdbx3xuEe0Vbg?=
 =?us-ascii?Q?NchR9DOiTdfqLZc8VVB3bV26y3Siva75pd1F6MTYcFwkGS7VjqQwjhOueiA4?=
 =?us-ascii?Q?6yNRIXgyPrg4QLVFfdk4bql+2cJe2CQ73z5n4WW4S+4f4T5pcbb9ibI7Zbpz?=
 =?us-ascii?Q?iyk0P2bMwZjblLWHXWgR5dEqQHYqPP3nK2645jSYar/W9nFM60qg1y1kw6xK?=
 =?us-ascii?Q?afflpfYw5vTucOFL2kRx8K2uPX8Y5+MAi9ZL/c7sUCmWUnHy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08145ff-c6f7-49dd-1734-08deb6fd4f0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 05:53:40.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujvB688+SxHBnML9JMapCM3HNPuJ/W+PrtK+WGBCoxaLfYpPC9FJxrTkv2EQEiyUTCommy9Vn+cQGEkHJrf2qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852

Hi Tejun

On Mon, May 18, 2026 at 09:58:35PM -1000, Tejun Heo wrote:
> Hello,
> 
> v2 rolls up the per-patch updates that went out in reply to v1 and
> includes an update from Andrea's review on 2/3.

This one looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> v1: https://lore.kernel.org/r/20260517183614.1191534-1-tj@kernel.org
> 
> v2:
> - 1/3: Also rename nr_bits in cmask_copy_from_kernel().
> - 2/3: Init scx_set_cmask_scratch. Bounds-check __cmask_init().
>   Widen *_CMASK_NR_WORDS() to u64. (Andrea)
> - 3/3: Add scx_cmask_empty().
> 
> Three patches for cmask: tidy active-range bookkeeping and add the
> mask-on-mask op helpers the sub-sched series will use.
> 
> Not backward-compat with the current scx_cmask layout/API, but cmask
> landed in for-7.2 and hasn't been released; scx_qmap is the only user.
> 
>  0001 - sched_ext: Rename scx_cmask.nr_bits to nr_cids
>  0002 - sched_ext: Track bits[] storage size in struct scx_cmask
>  0003 - sched_ext: Add cmask mask ops
> 
> Based on sched_ext/for-7.2 (1136fb1213d1).
> 
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git cmask-prep-v2.3
> 
>  kernel/sched/ext_cid.c                | 322 +++++++++++++++++++++++++++++++++-
>  kernel/sched/ext_cid.h                |  72 +++++++-
>  kernel/sched/ext_types.h              |  68 +++++--
>  tools/sched_ext/include/scx/cid.bpf.h | 144 ++++++++++-----
>  4 files changed, 545 insertions(+), 61 deletions(-)
> 
> Thanks.
> 
> --
> tejun
