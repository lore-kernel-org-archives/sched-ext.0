Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585B2494F0
	for <sched-ext@lists.linux.dev>; Sat, 21 Feb 2026 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702667; cv=fail; b=Xh8IIrxLlVFn0hA2XSNg+64pVUa5Do37ssg/BYgzHzsb9so4vzqXt5m0hwziS0RGHs6kUaYJCUbNEKxaYn/npTpocfotdPuOlUFowXVMNk/HEZ536xSW/FgkEeVvCXHIfNcUSwZZV4NgeNNnqWz6wy3whIH7mguZAZ4Z1SJri9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702667; c=relaxed/simple;
	bh=q+Jf2mUjEyQ6jX0XRls1JbqWtq0E12RKkKG5CrcMCS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p6kqzooTN5DnY7LgT4FFF4vPjwNjIdA4D3rxM97G6cWA+q8Pq+fWeeW0bmVq9v4YExtM07C3oBjzqQcrohW+07GXrGV5tG7W3vXqSZoOI43QTLPke4OtKtseszGv7/RfHSfhs6vpc+TQuk/9FM8IM/SCAH7fPldwtR/bCMG6WOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GJaI/FOm; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJaI/FOm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNuyRUIrxRS3BfTVBIhTsRaMxPDR6mYVBvoVTGjbiwnnxb6POewX0pOMjrkzPu9PvrNdF1XkQOAOXKU03z46/YZfsvbO8ta3KTE/lAUFsMXSVpTLwAF9ZsxlaMklJ4ikQMZngWobXUaR1TLATKxHYGRWFvexBTBFBqji1R28rXIBtEUrMW4KPee42uGEXEXQygiPvE6zUSo18TTInBMWShus38VJUzqF8tFrc7aMu6nHV94SCKcNpSGtrv10wHEb37X3BPNBKW9cGW1s9ekDQKpHnCB80/PQO68poBMryWmqgUcZrtvpUwP6NjSL5Q+Em5MEVPmPqUV5HtDtnQ+qSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KKxopwjwpo3UZR/zxmHBc5wnhL7A9a2Ka1CABg5Z0Q=;
 b=A1BmEQOIiLJc0NNprDnvvqpIQNZvSI24cGu6UlkUzFmTv7WlfHZGJnk1VOtHidY5lf5zDVLwJcEWcaILXULqeFQPADauUyBSLjlvZcA2EgYZD7R4nwOocd/SOkAr4Zn3CUz9XX8YyY76wQ0RxTpl9OgiBoKvA6vkPzWIl72tUk8eWVnB6uSaZ8JlxbxrAlOUA+fcFZPj3Wh2GIdSJtKMjT/CeTcCsBnS/kXmwZwGeAH9M7346ZaVQ7Xw/11bp16umhI4S8qK5EbGzIZPdL5KxPcKy+oGbuEBg054J5S9pLyD7wiucs1CAcggKuu10/A2OESnXLQ9tDYVsXCbhrWExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KKxopwjwpo3UZR/zxmHBc5wnhL7A9a2Ka1CABg5Z0Q=;
 b=GJaI/FOmLp5R9mMfwLXXxyHmBA3p+wB/eG2gHSdmqhsZ3vrXvJwBkbLqUoN1A1T4Iaio558JFXQbiPofHhbmRSfosPfp8/2BlcGuhaITgJC5M131AGixyM6yjRnQh/FCw4aX9sNYJ41buH7QhNQ2L4Ib03tPP9bIgmiILmm0roo8uFUAkY9NrQ5NejvWlLmRvEBYcgnSXapBSGyj5bY5nS5SV8SZXC8tRP8wAF0EITLc1uauSS02kjZvA0OQhlGu3ka6vw3ByzbaJM41zJEVXD1+fe7SzHO2KyWzgAAc82+45emWQz+NamVtg0MJHDXU7pT+yqk+ZKIyjmJZ6Mi2eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Sat, 21 Feb
 2026 19:37:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Sat, 21 Feb 2026
 19:37:41 +0000
Date: Sat, 21 Feb 2026 20:37:38 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 1/1] selftests/sched_ext: Fix unused-result warning for
 read()
Message-ID: <aZoJgm2FS2MPvqyO@gpd4>
References: <20260221125615.1119571-1-yphbchou0911@gmail.com>
 <20260221125615.1119571-2-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221125615.1119571-2-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd6c853-8dba-4409-b89e-08de7180ad59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nme8jrcq0QGMhI+ekBC6Goo07RNF2eSgr2FH9ywoEAujsWoEALCNKM9Ypv9G?=
 =?us-ascii?Q?cd8qL9sC5DUqDO6mNXl75YphdI0S3fYpdf9gsUAR2E0R9hgu9G7GmMUdG2La?=
 =?us-ascii?Q?2+fu0PMxduTdxRegHNcb7ccnAKWdAAf6FVuocH3qarWF0+f2/+8JGC2poVuM?=
 =?us-ascii?Q?+8owVKCSwCXQWo09j6wgj0Gww5+lOUACNTAnRnhIzasp77khNDE2i7HeEfHm?=
 =?us-ascii?Q?zH1+25CuWsMIk0YeA3X8EMXUSGCbN8y/1QU/pQwSyP8k4as2acTys+BL3F3z?=
 =?us-ascii?Q?VLR8iHx4i6V5Dfsfy1LOikbGzYBKKkeia4nqQ7jOAm6g0bNV6Oww3rTi3uIT?=
 =?us-ascii?Q?py8U3aBILfTcGnQugHGoTsskZggMN9DiAs7qmrvQU/0e9VoqCx/qVDMHxDz+?=
 =?us-ascii?Q?BigiQ+WLEAGnI1gSWKGq+4Rht8jciDEjtZbqk/XedZJjG3and9Bf7UdjbDeH?=
 =?us-ascii?Q?7H/T/zfvHQB57fB7feJnKb3PFAGKt+EJRY1bkdTZCtCn4uuYQHiLSZY/Lotk?=
 =?us-ascii?Q?6x1/ee/KOQU7BTWZw2DFPdio2Zoy4y/suQC/MOdUvsjZO/CWO8/Wk3CbkN5Q?=
 =?us-ascii?Q?H8mrczXyPzoVgEZzRiew2LycM4cmgPUvST8Wcu2egZ05nxSvQM5RUryUYBWG?=
 =?us-ascii?Q?KNiyW7ywnRnw376OzgNULoXj5YgX+7Omw791TUhP/0e96c0oD3iVVAdomvzQ?=
 =?us-ascii?Q?GR3QfTdwjuZv7y+ntC1vp5qY+QBxF6xVtmJWrqDWiK9bL0rzuu65Z/0WWHym?=
 =?us-ascii?Q?lJp/5stT5IcXRVCRZ+9V0IceRTYtVRHv/e5w4F+vG32iEbcak1ATE0iTkTtZ?=
 =?us-ascii?Q?pHzRqYG3bx7Bg5toLqyHQNU94GaSsAZuCrDS+E4AUzZR2GAvvbbCETLfuBZy?=
 =?us-ascii?Q?kNAfff6vw289X6xhFuOXAf+8AOgJFZSl31NpuqWFbDWlvcGMyYc76AaOf49C?=
 =?us-ascii?Q?VYrkPhPRinOnGcz7SpNOCiCnf+GikN6zn1lA94sOoGZaJynuV0O0zrR8hCVo?=
 =?us-ascii?Q?aQ+k5Zw+VjMVWx9C2+5QrjgbJG9+upgTYPEFInV0nrCmPYb9kj6K0U7wjkqG?=
 =?us-ascii?Q?rPWXgHSdsK6yuSbdsWwUUijUlKEwzOqjdUz48GqciFYDmrFXvuiWDpa+k3Zf?=
 =?us-ascii?Q?2vEmwpKXfdgxHEleZNAR7mum38h9pNTAigVlf3WMe4JYD7FP2Ohv5Cq8TKTu?=
 =?us-ascii?Q?EHjDRWYM66+mNIUhWxduAIiiupAVYyTfAXBji/cFypd5pntvXnZZjl10t558?=
 =?us-ascii?Q?+C/EN267ZusE92/Yzj4+6vp4LzMFASW0rWiBUHP3UpswOeOF1qWQdHJhNPaq?=
 =?us-ascii?Q?/R4+HOxbi3V3ELUzaaJECinocxHaQmpxBNuVTkOu+As8XZ21Ox1a+gunMYWI?=
 =?us-ascii?Q?OIylif/hDJ2uxZr0bfgErwYUgK4avctw+EgAbAgZiMVZcDivnmsA2V+D28v4?=
 =?us-ascii?Q?vccNgCo9lnfmTweugA98UYzHt3/6NJLH3zJPDxGZ2dHYZZmeuLL6bgATGqT7?=
 =?us-ascii?Q?kWO8LfIWJiIAF6XzQPV2QCteBY5JmC+Cqt/vlg0WD8JDJWNNQPtLzptRB4rL?=
 =?us-ascii?Q?b3hhOXlQcIO1HFwDxzk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gD4b984qgRmO5xnZVKra5wie4EGlOT3W9hmVsfWgeRopyeyn8d8hiGwTToK4?=
 =?us-ascii?Q?RKNMbHwRF4Z/sJqDaWQbmI3KKmgthzHbCxeR8Xm2f0j/oYC8s6ZRZwO/Hjc+?=
 =?us-ascii?Q?/Zy3HVHlGdgSbadwaUldb4y5Spf5mCFWybWNDwd/ga5dh9LOIzGkinPVz15v?=
 =?us-ascii?Q?AKJ1ZFYdk+ZID3vXLsJTzFFL37tgrv4uvsUXHsT0DTz9R3P7HFkg15HMcCnn?=
 =?us-ascii?Q?vo49fVgrIIkoY8IcccsxlyPf7lVW5pglObXcu9o/q9QuHOPbCzOzg2uRTUCG?=
 =?us-ascii?Q?5OaraTnfoakpoCkqUkOOc10IqbljZFDcieLI89Yti8A6TgOVpXXVFOOaILRq?=
 =?us-ascii?Q?0RXpPNVP8s12k7zgvDye6lz2gc3nT2PwU/O/6BCqeVOlP5l1zPB7yLZRdTBV?=
 =?us-ascii?Q?D8zVYF0y8MWHGq0Eiyja6+VYp30Cig1f2kDFSazokry8ALzTUdi5cnb2UhUF?=
 =?us-ascii?Q?iOU7LHgTaNfZWSjPKBp2DmQh4mNIZzB0taamdAoV8bmpy8rcpJbPyHWuWdZF?=
 =?us-ascii?Q?1U8ihNakn0RR4jDfBEgQib21VGTH5UpVGdHr0A00IBQsaFWGKLq3HCWbGJJQ?=
 =?us-ascii?Q?/X8TypBwX5+PmGgwz7TWgfSwf4qWM7DIZQMwMWr28noDwPGRn4La7t+043RJ?=
 =?us-ascii?Q?EEZpqXLli+eeoi5RYKJ+v85fsUEzpJjFk0cohgpagFbx0fx/LuE4r9Ba5f/+?=
 =?us-ascii?Q?3Yms9MESsS4N6nX4ntVUPd9+FUZOgndLTkL3hWiYABAdcYxNtEEa7X+4k1JD?=
 =?us-ascii?Q?O9rZx+O1e8T0RlDZApwdExGVDlQdGfzqEW6isBXXEn8e6gPsYS3hiq1IotrE?=
 =?us-ascii?Q?J6QW3b/4ZLV8m1RTUlJcHOxop5DkEMS7cEXPxQz68UvOm+CSSRrl5lzGLWOe?=
 =?us-ascii?Q?k2Xg+054vgZ6DO2N5PMzqHoQyGrW1oRliFr7wYorBvp3a0Py5DS7Ifm12Glt?=
 =?us-ascii?Q?qqq2HTWaeuW++Q9IyjrG7oMLHoolfED8Sx2AAlJzrEG7Wxs13OkDA/d+vRkS?=
 =?us-ascii?Q?S8BVw5AUkrk7VIAXvItdyaiTDtlz1Ug+BNAYVPV1kkDnCRE1ntrzcN58QS4I?=
 =?us-ascii?Q?uUVZOF1CZdb/IhQf38/QlkvTEAtVIxIduQ4HAb/PTw87YjKx0moZ+i6+83ah?=
 =?us-ascii?Q?vMytHc+foRYaV4cHBlHs4pcmksLnNpO/VAzLXEFQMlh+uDtEOuGGiHNeVkgK?=
 =?us-ascii?Q?3BntToMYPsgw6VQcoztmD5GoTQ+UwXcTaL41ced02Ekkc+gOG7dgxPOQPB7z?=
 =?us-ascii?Q?qM43aW4Y/cYBu7NN4iDQfE+ZoRsdlHGvJpCmwN5f+Dhv0TwXNvtZhX0zt0k4?=
 =?us-ascii?Q?MyUoAF5tTU3CwuKvTDZCaBQjh1FposZleTT7IQCZgBJrkjwOO8RkcVPvFZ0t?=
 =?us-ascii?Q?+pmGkxYZws4e9InGNbE2LGv7nY2zo+uCmZ8CG6PvI5qaqbR6kGjRJJPSs+U0?=
 =?us-ascii?Q?lYrBnHCumB/D2ndNPO9eyCB99WpRUvSGs844+R4aetxLP4vQ2nGT2//8ms0n?=
 =?us-ascii?Q?YA/KYRzNpn8LQ7X0zwgEXs4SBCwWwn9mEe13GXt4/qzXGbI5+uQKmQrc5uaN?=
 =?us-ascii?Q?oqRPZzUFjbqm8emnhM4TyctxW6R/91+41siStDRM6XgFeKoZisxSzbagskBA?=
 =?us-ascii?Q?PdGg2SRVYCQKrBMO+LUDEskZUCxDGlnjmOY2HGeGKU3HY/dm3KTGbd77A/qG?=
 =?us-ascii?Q?QlfPAdzFqLlL2K/xNXHayln+hG3h+bm/YNebz0LlYCHjK7Ah?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd6c853-8dba-4409-b89e-08de7180ad59
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 19:37:41.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LhprF7xVU4e336mHCcn4zSeBkABSB+4VktE02AbtABsWEYLnifzLNhYxG0WF19GQcECCdGCju1k3fPVn8Ap6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877

On Sat, Feb 21, 2026 at 08:56:14PM +0800, Cheng-Yang Chou wrote:
> The read() call in run_test() triggers a warn_unused_result compiler
> warning, which breaks the build under -Werror.
> 
> Check the return value of read() and exit the child process upon
> failure to satisfy the compiler and prevent unexpected pipe errors.

To be really picky I'd rephrase this part as:

Check the return value of read() and exit the child process on failure to
satisfy the compiler and handle pipe read errors.

"Prevent" suggests avoiding the error, which isn't what the patch does.
But it also looks good as it is.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  tools/testing/selftests/sched_ext/init_enable_count.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/init_enable_count.c b/tools/testing/selftests/sched_ext/init_enable_count.c
> index 82c71653977b..44577e30e764 100644
> --- a/tools/testing/selftests/sched_ext/init_enable_count.c
> +++ b/tools/testing/selftests/sched_ext/init_enable_count.c
> @@ -57,7 +57,8 @@ static enum scx_test_status run_test(bool global)
>  			char buf;
>  
>  			close(pipe_fds[1]);
> -			read(pipe_fds[0], &buf, 1);
> +			if (read(pipe_fds[0], &buf, 1) < 0)
> +				exit(1);
>  			close(pipe_fds[0]);
>  			exit(0);
>  		}
> -- 
> 2.48.1
> 
