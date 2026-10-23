Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792734368;
	b=UnTG6q9HS7+WRGIr3v3dtNPo8h0JRhw0tmvMVJzNwxwgvTLvQ/Ms3fWcrSfBlgFw0zNS
	 2VpjlxsYo356IhaIHXzJkiohbaXPSU1aNiC9v8JhfoeQGuebJQkpWpUT8aBDHtJipPKem
	 sxJiUehHXRfKaOpRUH+uV/fYKNtnvCay/ExfBk8EjagP+bgRmPISCpebNtxmj54JViee8
	 OS6Wz2R1sMWoJYweHZC7Bxp25QQBumT163Pk326vjc9qLGMCNZbmwwfmtlWN2IWFfLsx1
	 etQZMm0InhH3T94zcmKbuXx7O/+thnhhOI8z1PqHa0K9APSEGU413xGWHOzmpklWfTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734368;
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
	bh=8U1YG8QWpK1PZXUFavlaWOThohr5+MJVVoLtmXeeTcc=;
	b=5EW9jb/dJOXJ/stA7KiCrG3uBDmABhQ2dYezuI977CMh/VIZwIkMw8C4J03z2KZtWz4K
	 Z3sxaquAAfKnWVE2mgDBINvOkyPr9K/SO/sHOj3j+EVMw3sR7rdiAoM4kKY/9JMaqSikM
	 HCALK1In0wOWvfYxzaASg+h7Ux4Rb8I91FqUmDmVrHQ615BAsYJXamG3YlzyG+hUrakvs
	 VbNWdkx3zalEFfmueVpYGPTSVYhsU+uaIaPx8CJnWlPaBjkAPtQ15JOThohmqD1GJQsec
	 156cQ27bwz1VDtI4ki4PymXKoiUtQWJyXQtS3J96SD6oMBromLke/O+9L3n23LkclPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SqlsijhA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.49
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C75606A31B
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 05:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C75606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SqlsijhA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNuSFSi5Gwkc9vaOLYRsGTkw5FB0jcf5EUNgrY8Lnh9lrveG75bhzx9+Q5xcus1dhAfylckH3Nnl/A1H/RNzSCs8H5wwA9npUhOWjIRBY0OKcIv7Ivv32P08E2X/64uCneLNNaIIohj4DEzZRuXlYAbWd3UV+fRsnKW9DouLkRKRPNtP1kprN1SG5FEogVzO2TZ23I9R+yMt1qSKuLqiJoeHMO9W4MUO84RlY7+/6UoFL4i+rlqiHv6ujxtJpLcID1t/vHFHA5l+8M6YaaYLxoC7uvv7C2Rroy7xNK8KObhvT1xfSJyebn2bvvrQK/JAaNpKE8z/+n3S621avd2j4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U1YG8QWpK1PZXUFavlaWOThohr5+MJVVoLtmXeeTcc=;
 b=kMbatyPHIelB7Zse5LJPsoXgEpWs/X7rV5ftdNCsQ+m8iqkalTQdW+yQ3+4B0CtNyhhKQlWRexWDMeE6bAbWN8zt/NrYM+EfgXqy3uF91rCMo+JR7qmeEU84OyJVp+tiBJPxg4Dcsc+xDTsU300f8hL7nZ5U3T5TOPDCFX9sJH78kHyWYYNbosOYolJltpbOq/tAnzqt+U+6oklPYvElP/zQEW3ecDlDjGA4W5FtLOqISeKZaSf8j+effFTRjYyHaC1io2FamwIh68fc9gvPIrLyuXvQJcPSFEN/Taio9uJ7CmMy40k/SF0utZXzUIBfxjs0c8OkbF0VOAx0rODLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U1YG8QWpK1PZXUFavlaWOThohr5+MJVVoLtmXeeTcc=;
 b=SqlsijhA7YxyymPFyrdprPlofZIKColVEkjKpAlBFj1OdBiEHdICBuUIBOOs/fsf9V4UcAmEOIAGQw6Ez/XxRb+srfYl/sUyS8XhbToVY2IfbdZVVod+li/Wmgx1jiqCyXcgmps5VIKNyjDZQox//8uuT9aZxRhXdmzTPTIwFB7AZ9ZzKuZFmvnqlWrHOlurGe+tveIbG0RTMrtSxAN7nHnrtkrkjhZ/bcWPQ+zLBUBgVOjzsiSgvSD3L6auSyjqMIcstXEMta2K0x72UhDlB/prlOb3L24aa0I+CqQLoUtEcgdLaFIwH/KGoLPyt9qIDJWLTSvLh6YIxXozCrmiGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 05:46:04 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 05:46:03 +0000
Date: Fri, 23 Oct 2026 07:45:57 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: scx_qmap: Read SCX_RESCUE_DISABLE through
 the enum lookup tables
Message-ID: <atr0lZ5dHdoZRz68@gpd4>
References: <20261023000348.2726436-1-tj@kernel.org>
 <20261023000348.2726436-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023000348.2726436-3-tj@kernel.org>
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 02606dc4-61fe-4e12-9860-08df30c8ecc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|261021123027099003|261022105027099003|261009223027099003|261022075727099003|11063799006|4143699003|10067099003|18002099003|6133799003|261021121427099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	I/lnqvSYihpIF3M7rVLcvFPhp8b0U5PeUOyF2OYVGtEqrORa8x/oLpC7lL5YDu4dX2RCaIOaL14RL6m67UtzikGmGZ1NsPrSfBdafxzCBnXbeJ7dmYNgmdQPQFjuAWavL0GSVGs1k48c3PN3u+3EXnU1GYiCM5O+P3Vu/720hRtVkPgSTvSsV2C6/1U+iYgpjiz1aWJLFA1850iei298IO179ZXWalJYJ2EWhgvOuyGl4Xug0n/459jnRtc2YJiM1rrZhRatPaEGk/e6d+3x/GGM/RfmXUoJoy5fOzRXxQXPRIrDfAEyevnGU0WJYB8+KtUUbKSNZSvxpdmYlgX1EnbKekytq86yHmhTksYm4faSXsPhtMS+IxCwqhClgtRUH3iMvl+f1zhY+i72+jLRMd85xrHFIXMnUEkJSeRd8rdjUmPvcIr7gikgrm0gIErdlEnfR+ylIIRZolxVF+DWNAO6O6lFP5A+8MmLQcPSgxWabq68XWcUUu4oZs8t4aAddAXekR/ZPFo9Y+uFMLFjH7e5pyet0IMMD+jvqD/SCe7nqstujPo/k+XUmkq6yAk6ue5aEESvH8VjWWbbyZ6bIrhUqth/sa3opCE7HPGsOEsZ8LKEFJ/kl1Ev6z7CeVaglj9iCqemVRVETlTPohcVjs58B/I+YN6F9oSoB1jhBQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(261021123027099003)(261022105027099003)(261009223027099003)(261022075727099003)(11063799006)(4143699003)(10067099003)(18002099003)(6133799003)(261021121427099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zmzoWJxHKt0JX3DVwaqGH4ZYYGZLcrMo9dZ2ge9kyUhHHgV3aRsECSh9MKOP?=
 =?us-ascii?Q?KKCi1fuv671hoMwTDEwVfhFOflA6QYhlEXu9VcPLkPPwqZK22dC9qnKcv11P?=
 =?us-ascii?Q?HU+0n/Bcl0rit1HOKyhABkrW1d4YogbrsuKHa+HvnxZEvNI/Kjxg1FAEtNUW?=
 =?us-ascii?Q?B0wXZ9gP9oPTZ926q2BbRZwarHf4Znnro4xHCR1DPqMrMGNKdiZmgau234UP?=
 =?us-ascii?Q?wc+tkQ+fgAsUoM5Ap2WIEzggjSc4yJC209VWn6axIZphHuDysWNncGiyh71c?=
 =?us-ascii?Q?4X6p+BOXBzOrrgfpxM3+qqPB4cyr59D4MFXn4nutLFweHD5XMYtc1LEjLykP?=
 =?us-ascii?Q?btbIPMMc+EMkL/G0e2VzqKBwFu5agLPf2fE4PtbwLIsSoKNFzdTX3OT9+xyw?=
 =?us-ascii?Q?vCFBO35NQNKVPKFCx4EzD3PkQHZIcBgkSA/Zu7Prib3uBgWrTd1OLs0SoYl+?=
 =?us-ascii?Q?nNS8KUcibk/vpIaYwfqe717yUrcTMFvJx1e5WH9WXjl1CXpQEQBW3e85CkTI?=
 =?us-ascii?Q?ykNi80YFip1A5I/AaxZsmsWZm6FmWkRi2Nr8A3g8y6R63jovs/cdC+bdKA7u?=
 =?us-ascii?Q?2F1R2MDxJqlH+QFXY3XGybTWtfT629Vxa1HUFz56kVrDMrTD3NcxosYrH4xF?=
 =?us-ascii?Q?lJRkRQ9k4lepz+7TUv+sCw7b/OY9Apr0EV/Bhjo7aVfQaOV7nfH1ucPlwC6K?=
 =?us-ascii?Q?0It6ddbd4ic5EsK1uk8+E8RkH54freyM3hcl2cgrHcgSNh+dVNi3j2m8geGf?=
 =?us-ascii?Q?SklHC6PChMRNxDi3ICz6KQZhU65d4VqbNk+1fsoNvM/M0cX5sjR3kE/rUj9H?=
 =?us-ascii?Q?4/meN/a1EA2aytNQo5vegbrLXHtjiwgu3yz7EkwX+afPAUetiVlIMLWHXdKL?=
 =?us-ascii?Q?0S+kRUdFodsJXrtqIK+LnqXZP25AE+eOtJ5YAS94fGtEKOWD+bREaeY+uoF3?=
 =?us-ascii?Q?aYOBq9CQQX7YM4yuRkMtiJqEO+6m6N3inM2ePhw46lQmiHJ9Ounb1D1GYYxH?=
 =?us-ascii?Q?fMgyIIl7RkwE0dH7vdYUq9EfZmNdsKjxpCxOeMNasNXbfumZQwIYEfzk8FqH?=
 =?us-ascii?Q?c5mfd7DyJobjvi+H9MIKXgCuunMZzAwVZk7hRY1Ae+Fm7WkOuZKFqae58wv2?=
 =?us-ascii?Q?Bfv8fRBSIWXqJD5axIJ6XwlMM82JFlzwubrTB6QUXq2inN6KI1p9h2yfYhPB?=
 =?us-ascii?Q?OKcehZsY/GxAyawWfIWzvXe0uUB9GJq/cBMbj07NpPY19poSzAyNpjgO3lhV?=
 =?us-ascii?Q?t1oqRUTL/BlajzO4Vv3AIDKhdXlmS5MtdmCCe8yuCFSMrhYhl4Bn6YN7w/Bm?=
 =?us-ascii?Q?zZ4hStKFnVIq1UQfiHHWzEk7zRcZIvjJWH+kWDw4LQnFPBa7UA2wuRGxTz1l?=
 =?us-ascii?Q?vWaEtf2ScvuqmPXlN/8qjX9ndsmtS2X9zKDigGPw5PeQWcMZK28JsOrmgcXV?=
 =?us-ascii?Q?qpVibCxdhhjA0bFk5YA+bxF9stplCpiYgvhf3M6iyN3oryBEkkLmDuP+sBrn?=
 =?us-ascii?Q?Ze1fU/0Rw1SLlgi2yMER6wASwXbDwvdsphVDJ9IlhctGcRKxAkMb4ED/4RQ/?=
 =?us-ascii?Q?CvFsTobDFq6WHSneu0FRHMkvpUSQ9ARc82mjOIJNnawk+cIRb3Ff7z0NzPI+?=
 =?us-ascii?Q?a6glhu/JS2jp41FLUMEWO2e1aSLuGeYiglQBiFca8IxOmVNmxMdjJvDD36y6?=
 =?us-ascii?Q?1NdLdqVvQVZGni1V73BgSpcIpYPb/EGyMXSgnTR2YZTrWo5d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02606dc4-61fe-4e12-9860-08df30c8ecc1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 05:46:03.4335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZUl7jHG+nHqpaux0azi6Tov8TVrpA9WUD6/GB7bunoF9h1FpvZqjUQI6+GWzaca7boevtL6UU75OyfJym4uFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403

On Thu, Oct 22, 2026 at 02:03:48PM -1000, Tejun Heo wrote:
> 788b494fab1c ("sched_ext: scx_qmap: Drop the compat code") left one compat
> lookup behind: the -B 0 case reads SCX_RESCUE_DISABLE with
> __COMPAT_ENUM_OR_ZERO(). Userspace can read SCX_RESCUE_DISABLE only from BTF
> as it is in the kernel-internal enum scx_consts. The enum lookup tables
> already read their entries from BTF for every scheduler at open time.
> 
> Add SCX_RESCUE_DISABLE to the lookup tables and read it from the skeleton's
> rodata. No behavior change.

And, as a reminder, we should add SCX_RESCUE_DISABLE to the scx repo as
well.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Suggested-by: Andrea Righi <arighi@nvidia.com>
> Link: https://lore.kernel.org/all/ataTuzRFTRm_pax6@gpd4/
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  tools/sched_ext/include/scx/enums.autogen.bpf.h | 3 +++
>  tools/sched_ext/include/scx/enums.autogen.h     | 1 +
>  tools/sched_ext/scx_qmap.c                      | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
> index 405a3e6b8f33..d0c37018659e 100644
> --- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
> +++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
> @@ -13,6 +13,9 @@ const volatile u64 __SCX_SLICE_DFL __weak;
>  const volatile u64 __SCX_SLICE_INF __weak;
>  #define SCX_SLICE_INF __SCX_SLICE_INF
>  
> +const volatile u64 __SCX_RESCUE_DISABLE __weak;
> +#define SCX_RESCUE_DISABLE __SCX_RESCUE_DISABLE
> +
>  const volatile u64 __SCX_RQ_ONLINE __weak;
>  #define SCX_RQ_ONLINE __SCX_RQ_ONLINE
>  
> diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
> index 7ec2e5e41cb2..c4a7260f0983 100644
> --- a/tools/sched_ext/include/scx/enums.autogen.h
> +++ b/tools/sched_ext/include/scx/enums.autogen.h
> @@ -9,6 +9,7 @@
>  	SCX_ENUM_SET(skel, scx_public_consts, SCX_OPS_NAME_LEN); \
>  	SCX_ENUM_SET(skel, scx_public_consts, SCX_SLICE_DFL); \
>  	SCX_ENUM_SET(skel, scx_public_consts, SCX_SLICE_INF); \
> +	SCX_ENUM_SET(skel, scx_consts, SCX_RESCUE_DISABLE); \
>  	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_ONLINE); \
>  	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_CAN_STOP_TICK); \
>  	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_BAL_PENDING); \
> diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
> index 9b1cbe187ebd..fe2f206f5c8a 100644
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -427,7 +427,7 @@ int main(int argc, char **argv)
>  			u32 ppt = strtoul(optarg, NULL, 0);
>  
>  			if (!ppt)
> -				ppt = __COMPAT_ENUM_OR_ZERO("scx_consts", "SCX_RESCUE_DISABLE");
> +				ppt = skel->rodata->__SCX_RESCUE_DISABLE;
>  			skel->struct_ops.qmap_ops->rescue_bandwidth_ppt = ppt;
>  			break;
>  		}
> -- 
> 2.56.0
> 
> 
