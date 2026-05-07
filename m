Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325C27FD6D
	for <sched-ext@lists.linux.dev>; Thu,  7 May 2026 04:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778128282; cv=fail; b=jVbjmo6JzIRWEXITq+utTlBtq2tB8F1jGSbyjgW67Km9w1+v7pBIp/FJlc140IR5EuOMaUIdmj+YklmN8VaxmFZY1FDDFu2muzXgnc8dVn5Tf+UgHY2WCJVaLZQFRspOag7/dXWAFV5Z4/F1kJFTuCexYIivIBy4RqDFc0md9qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778128282; c=relaxed/simple;
	bh=Lw8LbEpyaLoMyZTjoLqTyIANT1tXHl+pUeuUPOzI3E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tZXzJzlfnsMS5ilr9CnYmqmbSWjMlwD7tEJoGRsdy7Gc0tggosGK73oinoTD2R6lXmjD59PDXLUOYewBNeozuqH3gAGS46I/nwQJJbSZW1m5gJ+C4stF3I9eh59fqL5OGTHR3HsQ4U9WUYi+WQymzeTNc8XyP/TD47WURJAvQS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AyfAFXHC; arc=fail smtp.client-ip=52.101.85.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AyfAFXHC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuLbAJQf9Qkd/dR8bt7f68W7EhVtjaUvsN+XPJqZZQ+RizhSrl+FevgplqnWuVlOmpZ1DBG+ePjTfvR1QaJZiil7bj/YSeHTGvLfkk08uRJqGxVVGw6SHWiOYmpddB2eN30zS0EyBWFfQjJ7Dc0FRe3u+XmV/FvXes/Vef/tAkXsxTnGW7zsmktyswixJOgSgZdSCz13fNcY35zYf3hrzU0K7+E0mEQc4n6EXtGTilIvilxA2sSF9yMHa/5e75AEHVcmiPboPx3nmPJLgAn7LWU1xq5WrYe1b0L+7H7rofQYjgqetDh6qBi3ebfPtesUXJhXaya/Eb44NP0NbKkKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdcYI24RsO9advHG9V4r9TxcArMw47sJdaD7Qev4FR0=;
 b=qfGNdJfj1GvjUWxkaDii2ni6A3Hx6+E+30X3R7c/SZCPDBMJZpCIUUE7ZQ88aLFT8UDVsJVCzCDppgW2oQR4CGxkHqQDpCRMCe/XVbNW2CgUYwztojcNvNIoZZBQCz/pFsluAWzBIuHla5LLJVc9Px/1WBUxCbi1fkE3qlS3T8skvHpzEFgaJo0gtMI6nCN72ZdKGeJJ7VdmU9M6gRSqMcEG/dayVY/XDPriHq4Xg4JYBSsTlMzvJkaz06MJjsc2QOz+HDtaSFo4DMLAVAbt9o9H+c7Kw6AcmMdl3+oVGepDVK+WShuvlkCo2DJFUoVGoQF0LtvNt2ChtuxxQNRZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdcYI24RsO9advHG9V4r9TxcArMw47sJdaD7Qev4FR0=;
 b=AyfAFXHCeqoYPwP6P7eDsUsodGoX3RgfZya4v+f3fFh5RIUPMICrq5R6LzXNyLmWZYO1cH6ojKpmubCb6qrbShJE3qWeFCqa2Ydq3caDkE7Hm+ClHCdPW2SNXswnoMzSYylFKtk53r7AvssFm/GeLB1BjNhDP/ah5zsB1uSHLzizQaTfnKEZJc5qh7ynbrBSkQ3dhFNfMgslym4v3RyrBMtpotBWwGwbhiPMJ+V0Y+cC29InqDpBJ8h6OQ9Xnqwf/sQs4bJIre9ecQRdrvJS0FN2wQUMQcPyy86FoB2bVaQzsOWkniAu0BOL5CoXRVMxT+Do6KLD+hp63PacToKCyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by CY3PR12MB9704.namprd12.prod.outlook.com (2603:10b6:930:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 04:31:18 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 04:31:18 +0000
Date: Thu, 7 May 2026 06:31:13 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Move scx_error() out
 of scx_link_sched()'s lock region
Message-ID: <afwVkU3160Ws9weF@gpd4>
References: <c14dc57cf2227c29e315122d11902a1a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14dc57cf2227c29e315122d11902a1a@kernel.org>
X-ClientProxiedBy: MI1PEPF000008D5.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::430) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|CY3PR12MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: 419d4b35-4ab3-4292-ce0a-08deabf17b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jctXh15g5fdVkxrX4g/t011cWAnj/UG0rDDd7YNAIOEewQY04JoCYolCyJRsHeMmjq2CVMunNhczXkcX25VI4lVXg8lI3ybzZdqvCXisMYTfL9nDz4UVnG67XpLXfpd+2Ciiz/DnA4+hJn/1Nj+G1fjmKUeF6thTH4DdXR8A95gqNvAncV3+NSr/qM0MShHJXQlRxieeFTl+rkxQuBA2Mgeo3ce4xF3SgZutuc4lw45A4361vFZz9+taJghxRcS28rAWxXZXXVfClaFFxuPc2bCnIaLjqFr+jl1Nrvvyj4pdfSjyEmyrSVyjgBo6hSswLZukZe582Qu26o0RdXIDwOM2pqbqiT/rwFb8rYnsWOLIw9yWVZy1+Jh6msjdZYMtPPlwqBmeWxlPxsK+6Ftt7Ew5SUojupsRiFWEdHIugT3FP7Xkpo1uLpJi2ucE00UZygki7XDvPsMFov9Chs9TRZxwgM6dQvumDBLkOUKBfPcMJjqKl1XgORkdkfDTWB5UVFpAedvmq0iQUjbpThudl7ekVLmw+KPCETAALMuuewVRLGkh3+sl1Q4bx11enoodnVCc95Ad5Lukfo2tpF25eU343QS8hLWcgFcMEAorYO+u/plsJxBdk55fXlUctGBBBwdz5Ie+r5JBm4ReC8meDBFnGWPD1H2fs4BNkX42kkP0nuGUk1n6d8z/KJhP1c5s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Mcm3TPg+oBfdACqiyprPoIShDrlBnVCxyqhADjyW7MHop3F2USkUsahPjsh?=
 =?us-ascii?Q?nvEPRgm3DHuHDfFXDqNENop7eBnWiLM2Q2Oa9TBlihebOiMipSp6h7zyrD2A?=
 =?us-ascii?Q?uYmxakUMi0QOB7xqti0HuYdZzjAgECJtk0QQUTOnq2On1LMbY1eOMGDuUKdH?=
 =?us-ascii?Q?xSm0ECIMJrajSyJNkTEhNy5OR62MFpaKKVcuCtXCioD6g3GL4CAFQOXskl7t?=
 =?us-ascii?Q?h+hXbl1dlMPZMEBctmU2xepk99Er1wfM9Zc6d77l2gfqnjAIAhUaw4frbS1l?=
 =?us-ascii?Q?7RDDAzPz4TtOoSWLHtO2828tJAlKlVNKljVCxqMGi9dY+Onm4minNJ3P12FA?=
 =?us-ascii?Q?SJNyTyDlzrEIuivbGXJmzxH9ulYbKq3B7qKRnGBu2c/w9h7D9RPHR4zGi2up?=
 =?us-ascii?Q?kiGLOx6PRU+hpg5VdIWTku8JgazIyBdVOefoDW6gFgUJ+E5a9W2Ljc81WfH8?=
 =?us-ascii?Q?CU9m3piYGpEnV10OdCSfJsL7R7QSpgHFbaaF3wc34p5J+HOBVOZOxGQQDsO/?=
 =?us-ascii?Q?Fll3sTCGTAVlIgYdkpy9o0nu7e2LHLKZttzJrzU15upF36e5DOFN0bUBftj3?=
 =?us-ascii?Q?cMJqzUsjYxpZq7eYbkJXOpSGyqPBzatH75K7aAio6Ditla0CUUjaf8SCRsUc?=
 =?us-ascii?Q?zwhlkmjPs2Y8SYbbaA8C/uJaQe19ZeXEIT78X4XQfX1rDLsF9lPtBxcxduHi?=
 =?us-ascii?Q?+1dpA+FJNdq+XMLCbhEfxBNlv/ICCUioue8r38bBlABVg7MuKHR40cuwU8or?=
 =?us-ascii?Q?Yjv8ndYiNouqA7nczwUhx4InfwupC9Zo65fPQifDL247D9LlgxIXPziuadKh?=
 =?us-ascii?Q?6P/0vFCBCjAoVGWh4tQeLoQnmSq+Z3kUrXo58ORfkuKp6PTS0yes+v7V64xX?=
 =?us-ascii?Q?osNNa5e3atk7D84h20g7JtShHDzWqr6YNcIVJG5WCbjFHWuOGU78Rs+x36Hm?=
 =?us-ascii?Q?634Wtr874pSow9eemdJqwIDWVySBhC9xNahNlqasqf902Uv4vf3t8Ijb+ppT?=
 =?us-ascii?Q?Te0IHZWCXLsdJd08f0vnr7nrlgnDI4OqqOh/jDzu8ljE08aZ9tEs4DTYJMy7?=
 =?us-ascii?Q?6i/1c9lyrA5/q9VhC62Zi7VNpJHz6RwkltYcklOO7/Zqf7o1L/jE2knoZNNp?=
 =?us-ascii?Q?2iMlL3Xw36WSvqcUP3Xgno8ybBzhGBCojdCowQJkt+2NNfxtLLe3VBSQ+Z5G?=
 =?us-ascii?Q?IGhDWVBU683Ht1En6ve776Fz9p6KDVCUIPZADciF2QS+YDqmaYyb5I94Zzsu?=
 =?us-ascii?Q?ylReYfFE6+dD+eHwWMrDCX8H0OxpBWIuUZEwBL8s+sYNb8ms/zD6fsNaueb2?=
 =?us-ascii?Q?GcoBHNHVSLZ4ZHNXmPjR5lvdtQdoh9ZIgPrF29OgvB8UnvLvZb5mWWQpQt+I?=
 =?us-ascii?Q?xettoaE8oTfuXAxUhNqJ6PFLRlauBKQGNzHgUt8na1b6/9Z8mJ8rLdvPwRJS?=
 =?us-ascii?Q?9G8S+gPzNxWbhD0K8oUF2i3ArkfIsAliVgEoPmyyCnMMXi1o6wKFEdffu6jH?=
 =?us-ascii?Q?r6Ul5XjGVQW01aL9xPMSeI2cAfYlEn0UIXOlCRSkRFBONP5x8lR4j8Z2YMA2?=
 =?us-ascii?Q?sVIqchtt1ivjrSU+7hYXrLjFw0u0YO6DYK3a2mxl/RZVuopTwxTZ9kOpP3PZ?=
 =?us-ascii?Q?Os6iPer+oLMu//Uqp9mfBd/2LyVpoMjL2VIRfLNbynJzCmCqsnyd90LEr+X7?=
 =?us-ascii?Q?xUz3YEQhiCDqyjR96fqST+MiiQLo+gfTFvnWAUWyWNF9Ug28y37B3U7jPhju?=
 =?us-ascii?Q?TTXznqy9Bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419d4b35-4ab3-4292-ce0a-08deabf17b58
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 04:31:18.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zj7fYnlo2VqRhI4TCo5YK8rAIafdyFzHkEHKt6NdkREagHfRwx+eWAnK5rRerF4xX+KWty6GE7FeaIQNekXkeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9704

Hi Tejun,

On Wed, May 06, 2026 at 08:02:46AM -1000, Tejun Heo wrote:
> scx_link_sched() holds scx_sched_lock. The scx_error() calls inside take the
> same lock through scx_claim_exit() and deadlock. Move them out of the guard.
> 
> Fixes: 6b4576b09714 ("sched_ext: Reject sub-sched attachment to a disabled parent")
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c |   22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5661,10 +5661,12 @@ static void refresh_watchdog(void)
>  
>  static s32 scx_link_sched(struct scx_sched *sch)
>  {
> +	const char *err_msg;
> +	s32 ret = 0;
> +
>  	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
>  #ifdef CONFIG_EXT_SUB_SCHED
>  		struct scx_sched *parent = scx_parent(sch);
> -		s32 ret;
>  
>  		if (parent) {
>  			/*
> @@ -5674,15 +5676,16 @@ static s32 scx_link_sched(struct scx_sch
>  			 * parent can shoot us down.
>  			 */
>  			if (atomic_read(&parent->exit_kind) != SCX_EXIT_NONE) {
> -				scx_error(sch, "parent disabled");
> -				return -ENOENT;
> +				err_msg = "parent disabled";
> +				ret = -ENOENT;
> +				break;
>  			}
>  
>  			ret = rhashtable_lookup_insert_fast(&scx_sched_hash,
>  					&sch->hash_node, scx_sched_hash_params);
>  			if (ret) {
> -				scx_error(sch, "failed to insert into scx_sched_hash (%d)", ret);
> -				return ret;
> +				err_msg = "failed to insert into scx_sched_hash";
> +				break;
>  			}
>  
>  			list_add_tail(&sch->sibling, &parent->children);
> @@ -5692,6 +5695,15 @@ static s32 scx_link_sched(struct scx_sch
>  		list_add_tail_rcu(&sch->all, &scx_sched_all);
>  	}
>  
> +	/*
> +	 * scx_error() takes scx_sched_lock via scx_claim_exit(), so it must run after
> +	 * the guard above is released.
> +	 */
> +	if (ret) {
> +		scx_error(sch, "%s (%d)", err_msg, ret);
> +		return ret;
> +	}
> +
>  	refresh_watchdog();
>  	return 0;
>  }
