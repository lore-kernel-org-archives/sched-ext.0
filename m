Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313D3AA182
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805730; cv=fail; b=ah0kHxxHmSRkCL25tCOtFI/SZF2iPDwkoGoFbeYA0PRDx/JsXolL4ONDz4UICZnGESmgbwHRpSFpJZNdX+xjh6rtVtwZrnVQ/uyJvlonDY2akF7K8d6aOA67d3leyyeaoi1hRGjf5ebhMcuK5pbbcdLUwHu2pFH5TH6EchQcVCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805730; c=relaxed/simple;
	bh=ScJFd28KSFSB6gkUrJJXLJzzCSyLvAsoVPbuSPK0wUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K4Lcda2kW4Vz4JH0GIj5YharxEIPEbXjwaW6om6gQFTurKYmObv+lhnE8KMm99GcvVLvrLyk5SGHuv8m6se8XRaQdJkPCWRixYeCKxFP1CQt1DkkgxPGzximOgLWSiPEaCkqIlg79NKIFytjW69LJItd3OXVPEesiABk3Qw2sk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NzPa5J6O; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NzPa5J6O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrmKdBrJ3iQTudyCwHxKlh/KiGySKXattavb6vUu6TrgMgWTJGguA162PfW5xHiB8oOoAnIP1Cvgc/pAdHVM5i9JLqW8iQoMntoR28jI8H5RaqsMyj8ei8sYYg6epn+tGm93eWBZ7BrFIISsyOvGBME4Dqbh6hxlBoAT6KOaLTCiF216brPjGIkzmuJKT3Ik36+iU3+FoFurRmnDY8mlj3cSr7yQmypVCOSRA3FkOcHjMdj1nu1MWYaKw9yVPtgM8TxChEOvPIq6FJk+b2vx+A9eP8dLPbkVvja4CYcgPcRs9bnj/IrL35nuaB/yCfPCvO6h0WiJpA+S+7lF0ZqxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAk37lrGEyfZrSBKZZMXXd4PKiqAXOtOZu6nJRCIePw=;
 b=ZPRlXcMJgacSogS0tkBUmwho5F1j5uGKBQKat90ik5wQLc6zCTqjAyyQ9SHVrolDwjkyLhXbiqm2Kl0ZLeM+rRJCt8gQumCuTzr6K3cFvxMPL4fPN3BfNvjeQN1PdlGTDNwkdUTMS5FdC2DKYrifnNTK8bLDM78W6PtTjrV1wYQjrePIQ5Xn9sarjl6pkFzSM9T39FsyfPWC9rHp1iQEcUap7R0peBKlpUmVNKfTqV9gg2oBMwuGrASbeghu+pWvw6IDXxSPql+NmpoSlS9pcwOlzUDqLkNa67DoJC91tBcSUmfGCkb+GnE6qz+ntPjguTGFPTBeyOjoB2Wr+qCwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAk37lrGEyfZrSBKZZMXXd4PKiqAXOtOZu6nJRCIePw=;
 b=NzPa5J6OiW9QEuOCJCelBzUDwTBnpH9uH06jhCjB5/2jJ9BAgJDN2zJvxcwRKNHek77o2ONKDFZbEqWKDf9L21rdN2t9m3a1NsaH815qP+qY+QvGGgmyqkUVmP5GGS9jgx+LIi7ItXizo++ggTaKe1OFyqExek8OnxGXJeOT2VTuKdnYDNyDvfbcv8q+HnyfUFCHYOHkGuLxGjh7AzIcjfeiPS44JKdvLHYQ1w8kSNNSvf3nOdo0U3v8Xvp59pYuam+0Qu5rRV4m/c4KtukQ+Ztltr6/dvgVsrx9Hn+Mn573QyFbv+Ee3Jc+XB5anrynKRxh0HQvcT/CuvsEJRvMHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Fri, 6 Mar
 2026 14:01:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 14:01:56 +0000
Date: Fri, 6 Mar 2026 15:01:49 +0100
From: Andrea Righi <arighi@nvidia.com>
To: zhidao su <soolaugust@gmail.com>
Cc: tj@kernel.org, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	void@manifault.com, changwoo@igalia.com,
	linux-kselftest@vger.kernel.org, Su Zhidao <suzhidao@xiaomi.com>
Subject: Re: [PATCH 1/5] sched_ext: Remove deprecated
 SCX_OPS_HAS_CGROUP_WEIGHT flag
Message-ID: <aareTeuAos9-Mg2c@gpd4>
References: <20260306124901.2653465-1-suzhidao@xiaomi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306124901.2653465-1-suzhidao@xiaomi.com>
X-ClientProxiedBy: ZR0P278CA0068.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: fd854555-4964-48b7-1e3d-08de7b88ed75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	IiiHnPX7eDB5m0hhHkFUFF05a+Qjg50+vG5ptYQawaUvUGv5D6y3YKF5F/uVqtKQS3ClCPYlpbrSayr3dHFlyVcQIwzvbWugWceEKFOvy4x9dTknYlLeP0Y3EtVNQb5tfZho46hS/4RyD50FumAHEcZei6sLyffassAkOSIbdl7pG1OgUJeLsVdw0W0OZRwf6hxa2FnfyuXui4Bsy+bYqUqHYBP+CLa1LSIXjKYcCdWSxLly0bCgeJS/abImPFxyU4cC1TiBwnaBbPSDZRzsSnBlTaGHzZlVOYmDR5s2urhTEMEJC2ysgsIuTsAsZGVA+j31+VCL+dqgKXFb6MHm7jf6Leb9zegLq+XdiR+pZ7t2XjJ34hfy9bwle18Mz4xd7pdbmLKPV0Q4tqAUsE0uhfXa3/321KVcYZZy9k9lwB3nwQraAdrs2GiR7Vw4Ue0iIvz341Db4/YE3cj25AJE7czgFvzZYgyrIDCo+jC1klCDXBMCDOgTYCHY85AOMYPYohOvslZsW7TnFft1QuokOZbnrxQ4Mhp3Qn3nOBLhu90OgYIBwC2XkLDMolY1Myj8FgvEB0LrJ2rRFT1A/ORglJ3ZF9L/7mfoz8WaBGy+8yi7JaBxi45U7qtJ+7nw8+BXoGUXVP/sJz+mz69ikm4j+8535zUWzRbZATVzRTSC2Q4BDjgNP0iqiZjWRdofAJKBOpZ9ACg7vcpKBxyqBldVWoRF70Rhn1spSmMoEs5esRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3pFwdfbBZXdpAg2JPq0AJ1f5aPQ86yJNigtG0e5jTK3+qhvR3kuI/bLmODuv?=
 =?us-ascii?Q?AGWnJCFr+GZQIF8vTzS+4PFyZXUDUVupLgCoq6OsSl/G1xnSTDWyG8Ij0Uvq?=
 =?us-ascii?Q?d9l/GMHTmIfnyIBA/ZACUd0tgx6AjWpVjlT98JeS4DnyPRMFy04MxRpS6uUE?=
 =?us-ascii?Q?CpTPiMgGJFVphbt2GgHnAY3gZqGcRAHDJVgQbLUeyejvYPzYjL0yo6UQc6sL?=
 =?us-ascii?Q?vauhKpS0L6s35OzIs4HTsms6Qus3xOGpCT7TW0wm3Ov47jS4jd2HM4uSfHok?=
 =?us-ascii?Q?yUqZX14Ooa5wdhskx2tC8A/sqU4IfmAO/a+GFNiWN5T9TzYUZm/oU4Uu16h/?=
 =?us-ascii?Q?GoJZLW4xbvkGTdOB3CUp+ABzd9RCNDHqekmyMHdIdi+OdDv0ulFHi91qxBsS?=
 =?us-ascii?Q?rb32dBwffmpTiOe7bwSUDFoZ+ccg5vUY0Gda6HfkSvnq8gwns9nii/2JHOQ5?=
 =?us-ascii?Q?MG6sTAZP8U/DfpSIlXwmq5vpJZ4NuGHHCtq90ywDtdpjvg6VuZWtPeGdYzjy?=
 =?us-ascii?Q?XonOO0SeaAGygylTvEN+5FS8qKIcj5fZrCYOcu4tRC8ymGFNUeDWuHE0pEgG?=
 =?us-ascii?Q?fizWTle3aSsFbZN2inFJRh2DviHopPpm5xB3B33Fzm/ybZ7YK15WZklMKqM5?=
 =?us-ascii?Q?miLU04fi+zawVUqg+sCQxVElNWV4FzN5H+yym3m6lkGiFzWoUNXwV+dQ6oQp?=
 =?us-ascii?Q?lopgbaoRgofx1sI8tWHR18G1ghs04yGoEbrL0QuOSet/uB+FicNit/j2425X?=
 =?us-ascii?Q?V0W1M5mrh+76ekg/nbB9mUAkFFHPjLBXzQC6jMSqpDsklYh9FBmOblf9NcLx?=
 =?us-ascii?Q?waDkfoJd0NIuiyVd2gfXpwLZCto7U0oS5yBjSj0UgMOxOPr5AJuEMTmur0hD?=
 =?us-ascii?Q?QSMnKv/gjk0ugYe3Emp8kqzv/KqVodnfE3hhtZ1HVdvSqZdQn48/qcLjBSN/?=
 =?us-ascii?Q?EVgG3PA493bYngkoHBGWd+zRoVlPoHO3JrhfTHM9c5ylh3FGItoKZcMuE+sH?=
 =?us-ascii?Q?skGC4a54jGpwE+IoR9BXRbd5ixLsZ3SADxqhO+h/NyEbAuCIFeo/ZshWIEVl?=
 =?us-ascii?Q?WN8/tMsH5lRvz2AIFjYqOyv+xaZPBfTkvXPV6TbDgpbe2ugJJ8h5WvHe3k8m?=
 =?us-ascii?Q?IAgd2ghLqK9/LtM6+Ng7lQ0ExB59gN4jQRXSJ8FfAwJaDeNI0Cl4o/13Os6e?=
 =?us-ascii?Q?StmG/kKgvFODqldWv/Hf+vto1RsZpBNw999WvngrJAXT8mgABzp9/wdhL9vF?=
 =?us-ascii?Q?/dzWSHizscoDGkFz35wP/K4d0j2wOqTqioPpSrcUdQV2hwbPfnsUZW26wDbt?=
 =?us-ascii?Q?pvg6bt+bRtugtwAuqh73CnQ7hsXPjkrTKNUP7pqgFNVV16hiRximgf4qGjaK?=
 =?us-ascii?Q?Sln/H6BJNr9RtwI1TFrqV82IgkZ89SobLSOkvUMqtRVo4153QPAXdXNOacDc?=
 =?us-ascii?Q?qkM6WUpf5py9e1/PAvrLJzf1kJzXDG3s9M+dRbR3+xh5EaoJCTf/K4oygdw4?=
 =?us-ascii?Q?PBV/D7MPuPpxCag2zBOST9QdIWxB5GNILLMSACSZ0TGEayWZshdDQyZQxPTG?=
 =?us-ascii?Q?Zcht3KRHJkFP+O/4NxZAPjqD6cazdBqzSz6IP4WGwHprOocczl+hYh+3kDbN?=
 =?us-ascii?Q?TjTnbNE6Al7ReWD8eF05AyDnccIGBuIVbbPrikCR9N8Gy+5yxqRh9ojh+Nh4?=
 =?us-ascii?Q?cGf3K6fbWlMKtdbovbLxtrUdE/PphInE99C4FXF0P+96gJCo/NvtYqvPLCwV?=
 =?us-ascii?Q?WDPJwynpmQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd854555-4964-48b7-1e3d-08de7b88ed75
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 14:01:56.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0cHVDq1DKEAZLk5yZ8uD50O1Ay/afpSUyplyBX0Mx0jd1X75TOA5Wjpc3RjkbJ0iloyBiucOVrAuXKpsLhXQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459

Hi,

On Fri, Mar 06, 2026 at 08:48:57PM +0800, zhidao su wrote:
> From: Su Zhidao <suzhidao@xiaomi.com>
> 
> SCX_OPS_HAS_CGROUP_WEIGHT was deprecated in 6.15 with a comment
> 'will be removed on 6.18'. Now that we are at 6.18, remove it.
> 
> The flag was a no-op and only triggered a pr_warn() on use. Remove
> the flag definition, the warning, and update scx_flatcg which was
> the last in-tree user.
> 
> Signed-off-by: Su Zhidao <suzhidao@xiaomi.com>

Please, when sending multiple patches, group them together in the same
email thread with cover letter email, otherwise it's very unpractical to
apply and review them.

See Documentation/process/submitting-patches.rst.

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c                              | 3 ---
>  kernel/sched/ext_internal.h                     | 8 +-------
>  tools/sched_ext/include/scx/enum_defs.autogen.h | 1 -
>  tools/sched_ext/scx_flatcg.bpf.c                | 2 +-
>  4 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c4ccd685259f..56ff5874af94 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5061,9 +5061,6 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
>  		return -EINVAL;
>  	}
>  
> -	if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
> -		pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a noop\n");
> -
>  	if (ops->cpu_acquire || ops->cpu_release)
>  		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
>  
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index bd26811fea99..3c86c53e1975 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -174,19 +174,13 @@ enum scx_ops_flags {
>  	 */
>  	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
>  
> -	/*
> -	 * CPU cgroup support flags
> -	 */
> -	SCX_OPS_HAS_CGROUP_WEIGHT	= 1LLU << 16,	/* DEPRECATED, will be removed on 6.18 */
> -
>  	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
>  					  SCX_OPS_ENQ_LAST |
>  					  SCX_OPS_ENQ_EXITING |
>  					  SCX_OPS_ENQ_MIGRATION_DISABLED |
>  					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
>  					  SCX_OPS_SWITCH_PARTIAL |
> -					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
> -					  SCX_OPS_HAS_CGROUP_WEIGHT,
> +					  SCX_OPS_BUILTIN_IDLE_PER_NODE,
>  
>  	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
>  	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
> diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
> index dcc945304760..80c885f781ba 100644
> --- a/tools/sched_ext/include/scx/enum_defs.autogen.h
> +++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
> @@ -91,7 +91,6 @@
>  #define HAVE_SCX_OPS_SWITCH_PARTIAL
>  #define HAVE_SCX_OPS_ENQ_MIGRATION_DISABLED
>  #define HAVE_SCX_OPS_ALLOW_QUEUED_WAKEUP
> -#define HAVE_SCX_OPS_HAS_CGROUP_WEIGHT
>  #define HAVE_SCX_OPS_ALL_FLAGS
>  #define HAVE_SCX_OPSS_NONE
>  #define HAVE_SCX_OPSS_QUEUEING
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index 0e785cff0f24..a8a9234bb41e 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -960,5 +960,5 @@ SCX_OPS_DEFINE(flatcg_ops,
>  	       .cgroup_move		= (void *)fcg_cgroup_move,
>  	       .init			= (void *)fcg_init,
>  	       .exit			= (void *)fcg_exit,
> -	       .flags			= SCX_OPS_HAS_CGROUP_WEIGHT | SCX_OPS_ENQ_EXITING,
> +	       .flags			= SCX_OPS_ENQ_EXITING,
>  	       .name			= "flatcg");
> -- 
> 2.43.0
> 
