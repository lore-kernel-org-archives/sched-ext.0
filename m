Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1243355F49
	for <sched-ext@lists.linux.dev>; Tue, 28 Apr 2026 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358788; cv=fail; b=ThnHVCOmRCz8bdC5G0yWL3LIho+AeQnnfP5j9W6L8+EKLdrT3r+Tx4meDgFz9rlotLPjMZ4SHCbUpyRqVC/+Fr6+OZ8mmHQBxGzhSYQ1sq3hZBxz7js3v+FWl7H3YNcd+9Nral0JGbif9wWeorPH8jHmlLgjowLYdFBZgaYPSlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358788; c=relaxed/simple;
	bh=Q5ibMRzozSFAASmjB4h+9VHOvbmI6Gv6CAGIbwSnOsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pd4sCs4HYqogLPuCvMJ0eezsyGcjVjxaa9/dvhAViwUn66/ML5oOiVNI/QbjlEHnGiwXcXmuGVOxYDEhK4e8KMolXCuYXuLTuJPdzmjnp9actOSHyOC1y/HkvhNr2AOlWrEpFBMhqN0mWhosusukk6SySiPWYQ1GCvkSzerkV/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c6EpDWPw; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c6EpDWPw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVNYih9NokcNrqslu4JryrD1iOLymQT9StYBzTmfEvWWLr8K8ANz1FSUY6jxIlNvg54szU43BpRi2xNUcmBuHISTy7jbMrzXEypOnE7MueVZ2PTGuYM0KMrA4+O4OwBopykuLJWwgNEsLltcY69+kjHx+puSLt6HCG6OQXdgVfZ9i/o0N8K+EoUW8YLbF9W5y4yp/nUH6JvNCSBS/JNeZJFt4jIk8ZkdCMeGHBYwUvdVM/C0TAbmyJUo9y3/cj2SYFe+cUUtlOXENXEdYtFEVoeyEfKuYOkQ7MR8UJjnslC1BEBjcg3ZHRyeasxfapK9ny5tM5cefConD1RPLdyFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l40W5+Da40/QkRUmo2NTXQ8+N3SK01bhBRyvobUKA6c=;
 b=nYMWPTl2YoCQGZATqGchnaQ7vHV8ZXivH4TTD5fzO58FNYvI2UctyDwvr9cHm2Mf5UAhGqAvV+cHoHCAti4T8SBZ/HKqIy1xwC/NmAA4Z3jiSf5oGoX21WzukoG4+asiTsVvFRTjHTt3tUD6bKz4hbzYEXlJ5ladYXqwPdm0c3XxDPpfWtWAHb3SCIWMoNnrAq5bD9x1yDsxkThqLiux/pJE/wuBO3LDcLJJE+UJ03fN10+0FEXNlExvKvyDbP2N8pYqUnT5QI8dSRLPph2f0ALJyfvFsv6CWy9sBCzHbPt634fJaLpG1Py22rLtqVO6/muAdo9hvsy3QgQBi2wcbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l40W5+Da40/QkRUmo2NTXQ8+N3SK01bhBRyvobUKA6c=;
 b=c6EpDWPwi6gskMi/kxpeLJyJ5if8br2a+IpkbcisaSPr3kcdic8O/aVvfm2Om4KIqVBM/8yJGntTKfzrvz/o/VMOSm8JWfchW8cH1Y+YYK7PTrZWWLG+CmruJcu28uWnH2gr3tuQRFWyGF2z2nyIHvT8PL+kFqHbfAN4cOapE1K7qcoqY96jQQNjBTrahpjNmOfymzFUY6f56foVxhTnuyr0TbzJHKCmlfcwBXkFUlomjqaWC1MyfxyahT8/BQoGTAVhM4JmZPgPtQgKFDnf4Bl+wp3TS61dGo65gCkpMGpiQPzTjXP9RpYaAnV8cK9G6v85+BOANV4GDu06ASjKtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 06:46:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 06:46:22 +0000
Date: Tue, 28 Apr 2026 08:46:13 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Collect ext_*.c include
 headers in build_policy.c
Message-ID: <afBXtdkYkZfoNI17@gpd4>
References: <b7ce63c1c16b6a21106b4fde986c3778@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ce63c1c16b6a21106b4fde986c3778@kernel.org>
X-ClientProxiedBy: MI1PEPF000008CA.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::435) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a7f201-a57e-426d-46f6-08dea4f1dc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uSWwhP7VyavxIVDzc//ufUgaG5NxXTCTt8U8UcHj9FUNPfTdn4f92xca1KWYw2/lafxfDPSzdXabIbXNCdxHSvsYS2D3i9BCkQT1D66gYSJnQ9wddesaYlwpv3i4zyJgWgZbfDsilZ5Hja89z/mqdK+8KpHO69c8A/xZefAAg4G1bK/+g86kHf9aplGvXR2a2OKXdXwrujMHTAvO7XkGfpPskSUeChtDFU7hDi5OHo+rHA4EMPrxcPJHzp3MJNweynSiOnApD4a8Ls60v1hUpvhZiGsJfJKKsR7599A6CTzQHxX/AQ1r4G+O2Rpzm96PdHRQAs5RzzXuMep0NFTI/hUh4gcoJN/NyCDA8Sp4oY82CzIgyRCTnkuFUhZwemgFmuGvDAHjypKtK9S2JNdlssZsQsfvK8cZDPxudDsAND8AMJFbTxD22ucD6bfYES0dkn19Wo3Ra9t1mcFPf9lyzWYHN6RmQf25fubIyqib58iI4Ax/u6kzEcECk5qdIhrvqBlxjvbXeqH6JsqEkuBWoj6P/LxudVv9i0EsESuukRG+hBogFy1kMA7Aejfxf1uRq3K8f8zNHG0wgVLtWM2dZq6YIEG3NGFOK76nililI8gs2tYbDumsE2tYS1NRXgylneHjvjGchBD9+wnIXFvwwa3eczbsVvIRUnY4NC8ArPHARh9sTm5/lBNgtfwFiLl4WfcdKP9tcgwNVKxQWmeEnXkKujfKguwNdLNCNV/7fpw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ov/w9Owa6ywsgPLxa/Y38zEEGQ72qiCvoxfdnIbA2auIGMQ6MtJvSB8VIWRH?=
 =?us-ascii?Q?pF062QLMW0uLafv+05yd5b75miJ9m334ixavd+S3iCm5OzzS3Fv4Y753yuLl?=
 =?us-ascii?Q?zLlNOvzBJJLy8RBioq5ACL6+WWKr6osHlkqjVSeg9jQ/IHJ7U8SL+AlqFtTt?=
 =?us-ascii?Q?y1aG4Zd1G5Gnv48UxReKJmXy4Q5Q+QeUdrUK3X93emsYwgvVrSXAVC5HVw8j?=
 =?us-ascii?Q?Br4yiojWRb+k+zyTbM1N1kpzaynShvo8C9KLnOxNYg9b9kyHgwUp6RppaXz7?=
 =?us-ascii?Q?XnHndwiT8ie7fxoAQ4PUHhVr8BCYALNckcfriDbZlD8WGA9dbMJEHZEKAQja?=
 =?us-ascii?Q?KuuoJJf0pU6GL1nLuxr9rZTYHwc8EVxn6FvfF4fBKxwJzhaglejNN9OJZD3u?=
 =?us-ascii?Q?rXVTxy4diIw7CAjQpbzyCKJbOYmhneGyw+pe1XTCRSQar1LFRbMSiBc3V6VP?=
 =?us-ascii?Q?/WDRYavJb3Y6IOlZgwMaBfzKXkG1mrUNH2/gn62ffft5eCnPCpIJCU/W8Oa6?=
 =?us-ascii?Q?+7skRFpdjNWszQ2p++vM9tmvu1oXWVVsjRIHb9jymODC/h53+0wFEsNTSpOb?=
 =?us-ascii?Q?wd0PkhxM5Z25zOykxgMvjm0Qvoz8NK4MJ3UTvFkZ8xA424fUq3FWf9HUIc+R?=
 =?us-ascii?Q?Lrbf3SEK8DLCf/OBb5S7td6WtCm5zP0QX2rnvVvbhCWHPwfxyU4q+ABlh/Vg?=
 =?us-ascii?Q?hObopnmyCLpWAzVPrUaB3zmtxeTLHhajomIrsjGQHcR36L7bAdGvuB9mzrSr?=
 =?us-ascii?Q?c0jjUWAQEL42Iv0RxdLKFAJ7BYrY6vj7/3qdQLVDHZ71nMO74Be3X8CI3q8C?=
 =?us-ascii?Q?xMrUWmudmSfxE3I8Kdc4ruews1P5qnhi5WYunWDYJfvzattXI68nFhIXJzGj?=
 =?us-ascii?Q?aZZODUCjx0t39EXeJJzwmMKOrQIMQyEzpZ9yb7sjM4LhpRf3wNNkeEkUqbgS?=
 =?us-ascii?Q?Rhvi/m36I2ESWLNp9p3H5OOdZTShq0kuFIXnz8ljlzzjOGFhiNvfEEy2ZOth?=
 =?us-ascii?Q?Jw8SkKfM80ObVhgsTo97ep5tTmkGNuvO1G9fYkWmTAFfem8dFTPxIAYx3bLx?=
 =?us-ascii?Q?qQv1ECePnPz463c9/N+IjEJUcwd8cKLHayZbLjn79/5iXp4R+Nq7Umd5j/I5?=
 =?us-ascii?Q?pWrr/gr1jvWzdiyMqwqGgGP6K+a0IHba3hm243xtDRrEY2j9SnSRnqEvbrqF?=
 =?us-ascii?Q?/JskQC8HtxVD9Zdmp9TpKJwLht5N8jJHDxkPlUsSn7PXGguXViJu2Exy6xrW?=
 =?us-ascii?Q?aFYlXGGXOPx96VhXD3+rV9MXEIIfSaoQSFdaX18taRsHTAI11piLd96ueqnq?=
 =?us-ascii?Q?jq6KmdzzetRDVS97lWj0Oidu/67r/KwH+001GFLft5Rg5Tyg4pREAPWgKx2Z?=
 =?us-ascii?Q?lEM0yAFqOyGfEY0c6DpxZKlp7+6lvjMMD677tz5c3O4pmxlDqOMC49NeoCEL?=
 =?us-ascii?Q?VNZEHdG/NFj4VCJdDnS1847MyA/7BXxi8b3TIDdGQPRw+kGn4L4zK0v/qFgr?=
 =?us-ascii?Q?fINonmKEZkJxkbSOdTvx+y9jSkKwpZAHfIx9cCVdO8nk3sP4x7I4btUsdxwB?=
 =?us-ascii?Q?11Ddw1K/xv7nX5Fil/gm+H41BMPN4/We3B0eXLqIboGszOgBv6ot2dWdnHm2?=
 =?us-ascii?Q?BQcigKGHzr/70nlQQeHQ720Op3l9RQ3FY8J5XJlxvCTHl846TlV3e8y3Lrr0?=
 =?us-ascii?Q?4yIdlCa4cqo4pzKkx9pPj6x5D07Xsu1tTxmoUwADAAdq7MmauPEaDslAbj6X?=
 =?us-ascii?Q?8JT9Gf/Nwg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a7f201-a57e-426d-46f6-08dea4f1dc80
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:46:22.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAS6UGeKNFiAaeMO1l1RU7gn2H+e2wx9exNPpJ43f8pdfnOvUU4azhQXEBPOJUx8knEOMOThpV49k6FG1y4AZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945

Hi Tejun,

On Mon, Apr 27, 2026 at 12:26:55AM -1000, Tejun Heo wrote:
> Move <linux/btf_ids.h> from ext.c and "ext_idle.h" from ext.c (plus its
> self-include in ext_idle.c) into build_policy.c. Subsequent patches add
> their headers the same way for consistency.
> 
> No functional change.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/build_policy.c | 2 ++
>  kernel/sched/ext.c          | 2 --
>  kernel/sched/ext_idle.c     | 1 -
>  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
> index 755883faf751..ffb386889218 100644
> --- a/kernel/sched/build_policy.c
> +++ b/kernel/sched/build_policy.c
> @@ -58,7 +58,9 @@
>  #include "deadline.c"
> 
>  #ifdef CONFIG_SCHED_CLASS_EXT
> +# include <linux/btf_ids.h>
>  # include "ext_internal.h"
> +# include "ext_idle.h"
>  # include "ext.c"
>  # include "ext_idle.c"
>  #endif
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index f7b1b16e81a5..11893f00be06 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6,8 +6,6 @@
>   * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
>   * Copyright (c) 2022 David Vernet <dvernet@meta.com>
>   */
> -#include <linux/btf_ids.h>
> -#include "ext_idle.h"
> 
>  static DEFINE_RAW_SPINLOCK(scx_sched_lock);
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 7468560a6d80..f0f4d9500997 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -9,7 +9,6 @@
>   * Copyright (c) 2022 David Vernet <dvernet@meta.com>
>   * Copyright (c) 2024 Andrea Righi <arighi@nvidia.com>
>   */
> -#include "ext_idle.h"
> 
>  /* Enable/disable built-in idle CPU selection policy */
>  static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
> --
> 2.53.0
> 
