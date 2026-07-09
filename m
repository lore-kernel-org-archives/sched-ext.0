Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA011367B69
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629597; cv=fail; b=Jk+f6PaI4E1Ikvp7Sw32YVCCezl/4yZX+XFpjaFfEL9bvTPMNAf+cF6KBNaI3Itw/FJUQGeqIW/gOLxFhUnUuzTbDvGbL+Z0LpqS+aU3iGsECuIj0+/S5LQ2DmVDCrf5/J6yQD0z9x/ERoh0ERiWh2y5HH6jVUftJCQ2P4OggTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629597; c=relaxed/simple;
	bh=gnol7qqSYSy82cQxLdpHt6aCbj9efJmR9YEgqf6mRHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LnkyczD1NlPt6EvHyThuMF6OLgsVlirQUUIhbMKheyjbEi2xuv5YYsMgeiSNk/Eh9DqPqY0T98gpmaMJ5N+F88hWQJN8lq4ISwKUYjynD5W5YPHqdNNPKKUlodSnYaN7pAzF2scwMRr7MJvBSbFYsmtRsG4mJbpcBPP9dM10Y74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ixia4Mpx; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ixia4Mpx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxUVtGdSa/tYoijWDxEkg41zWB+pmNdqh7w0R2NNfiE032u5W7nTMlhbLFoNdwtpLMkdDrRiODgmLVDw6x7YgHXrLtRArQyL/48GiO/8wJqSWzlkGzTWWSxkGK38vsd8xo4URBaRQdCJ0h2N1RT+OPEAamvACl+6LB9NfiC2SYhqs64QEO/SOJ/u63XXr90IbUw5n7yZ+hb03aB0JeSwySCH25tihxbP6yqdfTaCr3xgru87vuD4q/SumzfdeyyI+uVHgoPn9cnlVZChtEeqL/l74jvsTwgEXBJ4aNKU0m17XPWkmIAExaEl77l5XWvTCfDIc6Hp2CShI5LO/7OH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP7hQUiKvHatt6CAgtpgaJIqp/FcXKvr54Zm4gd92Iw=;
 b=g5YT8yA3IuaVh0XnoajHc87zz1/5ryBsdXLAW1l8fo4SyPH/d5dXQ7+Dzy8Sha0vLaT+E9cywQyWaqsql6I3U7f6X/vWcYIysI/cRgW9w3Foe3Oim/GDYJOg/PjYGV53IqCa+PreQEXi/QvTLBVwtNzarnNKpDY3A2iRP/jZ29VJHREPJDGRk08P8mJZmZm0osQHEb4Dyy+m779Knz4DiHFmCpIIbl5DaBikWpuYS1NlyN0p61ofcINZiYn6/YAw8kmiYV6uepB/5KJCrxrPV6ix6X0RxNVT16qdt8tsqA5ByR7wW6A6laj6Mdgf0AzBSKqOwubEqadsS5GwypcOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP7hQUiKvHatt6CAgtpgaJIqp/FcXKvr54Zm4gd92Iw=;
 b=ixia4MpxgdhcUTZRMjrgWMNiu6l8arMGKyqH6e8I1XGStyim2Pr7+poH/K9Wjw2K/ekB+ViEAPsIZIx+Y5ucGKHWvnaVHUHOIGNcmnxXLcP8oS366dvJLsI0zrXpe74tDhhxkKBJd67+TcNrPyS3qDFEQsXKi7AaFJl4K0Ql/wMNaAM1RbI/HXyeZKh+eLINyd5cS/mvhuqT8BtZgc9/e3W2Fj1gSC9rtTRlpif2LaP0lL8po1vLKkXffK8oajxoREeggiX2mB5vUgCZKZ74C8Y68wc3aanYGna9FT7BFFyyZEBeCxhrFcyN6EoCmrccf+oFQ41bCrsZ3TEkz0xn5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 20:39:48 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:39:48 +0000
Date: Thu, 9 Jul 2026 22:39:40 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 04/40] sched_ext: Use
 READ_ONCE/WRITE_ONCE in cmask word ops and drop _RACY variants
Message-ID: <alAHDEMhs-sN4ypA@gpd4>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-5-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708212429.3405787-5-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: b5cbbd41-cf3a-4624-e47c-08deddfa37d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|4143699003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	FaiS/0ntc8NRCoJ/KXQ4FfcrKjuKksSwSD5SMWVMnVv10i8QcsanrQctMum1EM8/+yH+kcKJOWjHrinrEgvec0wCuMlsMQmrczR7Vcwp3b7bivjHfRGIheBKUletv2AZEdl5M3/V2pjhHA8NM3qjdKEM1CWSR0ojxYr7fUNR5VvqEr+V5ZgQVtOIyyDxCyrOSIkp7CSJCC11ICeDqrkNjHkEmYIDiSizsznzYEhpwBjDFFKj5/XqWHIZF2U/b6WN5w4+IR8Vd+t1DgFE3PuRLSsrsCTQXJr8/mLmS0DLi7uJ0rd9SDSdvvCKzRNg14LfEyb8D5eYQfYOBKvhbQWGPzQg71DmrVj/rzVp/FecZaurWY/BELPdb5ldD9zmy8UaXleMEX9p417UNO7JAt0ZrBi7XbjAI9D+yRoKEP6j60IARCVo8KK6c0WuHLO9v9kK5bf/PXxrzRVeYwFAh7Lh8EJvCQpqL4nEgRBDf2bKO3Z2jbDkAZ2yb/DELIzl0AfgY7QURWtk41du4X4zGCcg2+OngZjttRraht3FnqF/1h7XnpXjl33FQP/oh92oRrAOngi4NkJwCRmh3FHBscEKQ/FH1agpmMOOav4KwLcLot1fGX+QyrrsOWb72I0V1eNLGCCtg4vq8/5h/lhN3fCMYMZrxw+k6ZIyymDw6zT7rRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(4143699003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?42p8TT1UZJOJFBHTCpuhMgM955MocDBLuiGksTOvrysvq0+M1hxotSh19Th1?=
 =?us-ascii?Q?flfamPHQ8j1mQ2SUICadwsEhihF1qoxpG+kwMH5eDtWkhJd3WeX3h90tmdqp?=
 =?us-ascii?Q?GtgC8X0f0EWAsh1a3wvMvy9+bUKbymEWL8IbUfh/FGpnTrr/HCG4qbDsg8bH?=
 =?us-ascii?Q?Tw+b17YrzfFP9rZlRecu8200QfwkbtH3uNScTP1OY6bK2FsRiGBAnWO3LXd3?=
 =?us-ascii?Q?gF4A+BdBfZVNd7aQkJTHbD71lILc9IWcvp1j/KZXSESQerPvW50/R7Sddym2?=
 =?us-ascii?Q?kzwWWUaPC7XNCbQO9dubPOXYQhv4lt/xpH9Cs5BDQFNhwtBufN/uq4vav06S?=
 =?us-ascii?Q?PT0igfIk1wOMvBdhB8cbGb2l2lms2ItVcbFqqEBIDzuwds/Hrnxk9hiIJRc6?=
 =?us-ascii?Q?zS3JSSN7XaKcddiWOPc+oS++8jUp+bRL4tbXc7O8slr1O3CBLVWdRI+FkK/M?=
 =?us-ascii?Q?EXdF0UF7igUHLAOUd8CKFdkk2igVy91R09a6kv4B/IvFQuCNLJv4uhKTEykq?=
 =?us-ascii?Q?btXKL6jXuD46ieHEr31ixmlHxxLg9pglNKu+bn+dgYWFQU5qBkj6YE+5vtwV?=
 =?us-ascii?Q?VNbmEL0H9vZAAuuwmlRFNry/F8cGsmigEu2C+OxiOd7+73KfofTjAlFBthVp?=
 =?us-ascii?Q?SYTA2aLqcpDpLpXRrQyKT91YlFiGCjqCsYotLf+MSif2QGXP1/ALVVRRrCzd?=
 =?us-ascii?Q?YvSM7ryDju1mvzktIcnbYmE/BaU3corZifGK8rzvx4lRwYCAICRXw8LnBpsu?=
 =?us-ascii?Q?+las9r/wDFN6ZzI/fG/k2bJhHcxgdsx/QRdd226eKmUlBb4kDQ3+Lf58Cu06?=
 =?us-ascii?Q?7qm47wOng4Ieh7Jxkxh9X48PuVay5xx/Gvr71DiXbF5JLh0h2twPuDw/WaU1?=
 =?us-ascii?Q?D1OSr4C+etY5r9dTS4Had6tbKWYDDyZlhO7SPW1dowyFo2xcdZB1SKLCRFU5?=
 =?us-ascii?Q?FPrxtNwtKLBb6EF7N6BI3atjyDu1Go6NxoPlzJ5g4K/mHiPykJOdHOKxKxn6?=
 =?us-ascii?Q?OlP5pkM4vpHSbuJel0LxeTK0iGk95/4jpVGQTsAlltssxabwlLd1xG+tf0Ht?=
 =?us-ascii?Q?2UEGKzDYekOvsuKdyZs8VAq9Dsggw9rZx+bsc1PfvNjnOJXWPmdZjcZcGy2u?=
 =?us-ascii?Q?GJlzcXYVLf8MHl6ngt7RWhj5ilCvRsrpJoBn/U8hmnK9WLIdzdL4kb2MU5/A?=
 =?us-ascii?Q?YbrCvg8jO01xiokuKIJtHnsmz61mPJUxKbKTB/3F94U1owin/wd+ekKGkyDe?=
 =?us-ascii?Q?AbDV6p4/RgFhXBfzcgpCKtjCIt7kmYbovy1Ss54UodS/hr0cmG0xtkfEMCMs?=
 =?us-ascii?Q?jvG0yDOCvm99hUd3RSsaIHbIxsJbMnw4T4djpozHxwaKEgliry3gag15s9G+?=
 =?us-ascii?Q?cD0DOOFskNdj76z4o40lIiWJHbbSxgCiWHq3b2UbNA3wSwpu7kNgSWQXCNJc?=
 =?us-ascii?Q?IhmvluRSKnsQUs4AgasAUHtdOIFcJhhzu7B455nWpd+DxyJqaI9b313Go7hI?=
 =?us-ascii?Q?yOJrix2QfbBE5RRb4W+M5Tc8OyQArhMxvucy32CBCkpERmP9JdRW2AtJ+gjr?=
 =?us-ascii?Q?9uMZG8YxMxU/EqJRiPOLsx43SkKqRLZ+EUP0yP6NXZ4QhAwYvlvmyYwe5O49?=
 =?us-ascii?Q?rOUJ5H2V4+d81WGkqvheB6vic3W92TcaT5xhgm9t/34XwmjGK2sglHRT03V7?=
 =?us-ascii?Q?wv+/LZGG4OwkAQhxZREeSrEHzbyO1SkDey1WuZ404lVHY3QIcpStq5tSsM/v?=
 =?us-ascii?Q?vsO7B+pQlw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cbbd41-cf3a-4624-e47c-08deddfa37d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:39:48.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhs9H6gWIAuaQJzAGLExwXoGUdExCncS+vboYHsu/H0fwdGRrH81wjxCkmQys48TMFk3CA2wlsKO3Ntm9g128g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487

On Wed, Jul 08, 2026 at 11:23:53AM -1000, Tejun Heo wrote:
> The cmask ops can operate on BPF-arena cmasks which BPF programs may read
> and write concurrently. The _RACY op variants existed to make such lockless
> reads explicit but this turned out to be too restrictive. Mark the word
> accesses in all the two-cmask ops with READ_ONCE/WRITE_ONCE instead and drop
> the _RACY variants.
> 
> v2: READ_ONCE the cmask_word_op1() ANY_SET read. (sashiko AI)
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/cid.c | 55 ++++++++----------------------------------
>  kernel/sched/ext/cid.h |  2 --
>  2 files changed, 10 insertions(+), 47 deletions(-)
> 
> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index af83084ec740..f31113b080e9 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
> @@ -395,17 +395,15 @@ __bpf_kfunc s32 scx_bpf_cpu_to_cid(s32 cpu, const struct bpf_prog_aux *aux)
>   * bits outside stay untouched. In particular, scx_cmask_copy() does NOT zero
>   * @dst bits that lie outside @src's range.
>   *
> - * The _RACY variants are otherwise identical to their non-racy counterpart but
> - * read @src word-by-word via data_race(). Memory ordering with concurrent
> - * writers is the caller's responsibility.
> + * Word accesses use READ_ONCE/WRITE_ONCE so a caller may read @src
> + * locklessly. Memory ordering against concurrent writers is the caller's
> + * responsibility.
>   */
>  enum cmask_op2 {
>  	/* mutating */
>  	CMASK_OP2_AND,
>  	CMASK_OP2_OR,
> -	CMASK_OP2_OR_RACY,
>  	CMASK_OP2_COPY,
> -	CMASK_OP2_COPY_RACY,
>  	CMASK_OP2_ANDNOT,
>  	/* predicates - short-circuit when the per-word result is true */
>  	CMASK_OP2_SUBSET,
> @@ -422,28 +420,22 @@ static __always_inline bool cmask_word_op2(u64 *av, const u64 *bp, u64 mask,
>  {
>  	switch (op) {
>  	case CMASK_OP2_AND:
> -		*av &= ~mask | *bp;
> +		WRITE_ONCE(*av, *av & (~mask | READ_ONCE(*bp)));
>  		return false;
>  	case CMASK_OP2_OR:
> -		*av |= *bp & mask;
> -		return false;
> -	case CMASK_OP2_OR_RACY:
> -		*av |= data_race(*bp) & mask;
> +		WRITE_ONCE(*av, *av | (READ_ONCE(*bp) & mask));
>  		return false;
>  	case CMASK_OP2_COPY:
> -		*av = (*av & ~mask) | (*bp & mask);
> -		return false;
> -	case CMASK_OP2_COPY_RACY:
> -		*av = (*av & ~mask) | (data_race(*bp) & mask);
> +		WRITE_ONCE(*av, (*av & ~mask) | (READ_ONCE(*bp) & mask));
>  		return false;
>  	case CMASK_OP2_ANDNOT:
> -		*av &= ~(*bp & mask);
> +		WRITE_ONCE(*av, *av & ~(READ_ONCE(*bp) & mask));
>  		return false;
>  	case CMASK_OP2_SUBSET:
>  		/* stop on the first bit in @sub not set in @super */
> -		return (*bp & ~*av) & mask;
> +		return (READ_ONCE(*bp) & ~READ_ONCE(*av)) & mask;
>  	case CMASK_OP2_INTERSECTS:
> -		return (*av & *bp) & mask;
> +		return (READ_ONCE(*av) & READ_ONCE(*bp)) & mask;
>  	}
>  	unreachable();
>  }
> @@ -504,7 +496,7 @@ static __always_inline bool cmask_word_op1(const u64 *ap, u64 mask,
>  {
>  	switch (op) {
>  	case CMASK_OP1_ANY_SET:
> -		return *ap & mask;
> +		return READ_ONCE(*ap) & mask;
>  	}
>  	unreachable();
>  }
> @@ -556,39 +548,12 @@ void scx_cmask_or(struct scx_cmask *dst, const struct scx_cmask *src)
>  		       src->bits, src->base, src->nr_cids, CMASK_OP2_OR);
>  }
>  
> -/**
> - * scx_cmask_or_racy - OR @src into @dst, reading @src without locking
> - *
> - * @src is read word-by-word through data_race(). Same per-bit independence
> - * rationale as scx_cmask_copy_racy(). Memory ordering with writers is the
> - * caller's responsibility.
> - */
> -void scx_cmask_or_racy(struct scx_cmask *dst, const struct scx_cmask *src)
> -{
> -	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
> -		       src->bits, src->base, src->nr_cids, CMASK_OP2_OR_RACY);
> -}
> -
>  void scx_cmask_copy(struct scx_cmask *dst, const struct scx_cmask *src)
>  {
>  	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
>  		       src->bits, src->base, src->nr_cids, CMASK_OP2_COPY);
>  }
>  
> -/**
> - * scx_cmask_copy_racy - Snapshot @src into @dst without locking
> - *
> - * @src is read word-by-word through data_race(). Head/tail masking matches
> - * scx_cmask_copy(). Each bit in a cmask is independent, so partial updates
> - * just leave some bits fresher than others. Memory ordering with writers is
> - * the caller's responsibility.
> - */
> -void scx_cmask_copy_racy(struct scx_cmask *dst, const struct scx_cmask *src)
> -{
> -	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
> -		       src->bits, src->base, src->nr_cids, CMASK_OP2_COPY_RACY);
> -}
> -
>  void scx_cmask_andnot(struct scx_cmask *dst, const struct scx_cmask *src)
>  {
>  	cmask_walk_op2(dst->bits, dst->base, dst->nr_cids,
> diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
> index 9c4f4b907f12..54b10df32fd5 100644
> --- a/kernel/sched/ext/cid.h
> +++ b/kernel/sched/ext/cid.h
> @@ -57,9 +57,7 @@ void scx_cmask_clear(struct scx_cmask *m);
>  void scx_cmask_fill(struct scx_cmask *m);
>  void scx_cmask_and(struct scx_cmask *dst, const struct scx_cmask *src);
>  void scx_cmask_or(struct scx_cmask *dst, const struct scx_cmask *src);
> -void scx_cmask_or_racy(struct scx_cmask *dst, const struct scx_cmask *src);
>  void scx_cmask_copy(struct scx_cmask *dst, const struct scx_cmask *src);
> -void scx_cmask_copy_racy(struct scx_cmask *dst, const struct scx_cmask *src);
>  void scx_cmask_andnot(struct scx_cmask *dst, const struct scx_cmask *src);
>  bool scx_cmask_subset(const struct scx_cmask *sub, const struct scx_cmask *super);
>  bool scx_cmask_intersects(const struct scx_cmask *a, const struct scx_cmask *b);
> -- 
> 2.54.0
> 
