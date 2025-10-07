Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2D26059F
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830154; cv=fail; b=hxj5oj5M+WS527xVUPlkU4yyPhz45tq/FIbdjqShurvkiHXGCAfXLu9xxFiCdh+aqOtrmqtKNrgmUe3/lJYUmfCV03UNa09WFHu29V5wL6pyL9QxdRHTWoyZhSaeCyvdvyYD5Sq/2DRU9VP+Cb2RcNVPKK74FFDtI791w7lkzHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830154; c=relaxed/simple;
	bh=YqWaAbFQQomSdHASdjSzY8jiWRPEIUl1E6suoIW8ESQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ByvFAnnhuVdXrFG/CYiSITGx2fGgJ/HWfilx+NpqRdf8NoY3OoYMtDW/wOpOfAarTHOu/O/PnqeBiBu7w+6IG6d9PUcXAg/An4S4+gJxyIlxFWueX6cEgzSFQAvN+Exi1wq52cIodh/UgL0rOQy3bB5y3BsvWIGhVamw2ytZ1uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WQQsqtut; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WQQsqtut"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGkSvpFG2/dbwy2dQur4psuYPG292U/scHMxvnvfNaVULFg3l9+qr00wK8BbwbMsMccwPTDWoZopHCiZBy4OZ6VGRQpuOb/ejFsFOzoweYxIQYYa2oytMzH4eU7INuiTtUji+miImdky6Q7AjGAn2uobhUGJE69Vs7WycbqCZ91H6pB2t2TucfylW3S84mGExWSzprOKrJdEvWSH+wB4q59NaBs4wxBqg19MklID0rnqc4I8M7ZHfmcHzDdoTn11akbpo5iwuUPxBpxGqGRfY14ggh1ez2Wr2gUiBsRYqz3Zcm5l5VgnxATBYEcFC9pKrtrLjQ6p93q2tDuJCVSubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wwv/J1qSzIlFmqSIv1rzbTToAIMRRUlTUw5hDWPIgPc=;
 b=XBleRopO7X8vA1l8U3vB5jOfWBnr3KNAQs1qt8/P2gHK2fzs9GLgF/o7QsCN4jsuIeiaUG4ubmc8rWEyEowK9HYCsym3fuPasqszro27XosAPmE/9P5VDE86XPMmaFK87GpbzFm3ZTOd47q16MQMJj7m6/xHqnEMKK+OZlaorIrevLI931UhPh7CcG7t21KcjI3oM306IgFRZObD7hE7WofIlfieB7UFuE7InOfT48saV3e10z2iqM4/qrB6OEhAnD/IxVnZyvdzTE/e+coyrCqbi1VF8TqfR26xHOq+XcPUykslyJCz7rcBNKtngrbFDPTMlTdPY9f+Hje10dRJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wwv/J1qSzIlFmqSIv1rzbTToAIMRRUlTUw5hDWPIgPc=;
 b=WQQsqtutLM10bRV/NJH1e/LCGxjfJ/8VsWlTBn+ORZ9bhgvTsxK9FJEzVbKUxjyDvScO2WW5QgSZFExfFuXluO9GNmF/cp5fXa4QgOCt2s1lzpH9xRAGjlld7KiZI811HmO4ewKA1i4lwUxXadrbgahO73F2v9vjevldbmoFSbfGkpC+qWhgRuToMjuGpjbskB1434gR3D5JFlsjjy3fHXYzgSlakgdTLnbOdhal9pziBI46sBuvNu9Tw2580CL2wYRvteC6yUkdU1c5Vvb78zVSRTjbwRZ7vSIGsEoGhw6aVFN9DoH7F0FSuH2jVLM2aaI9S+KN6K22SIWCR2DJEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 09:42:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 09:42:25 +0000
Date: Tue, 7 Oct 2025 11:42:17 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/4] tools/sched_ext: Strip compatibility macros for
 cgroup and dispatch APIs
Message-ID: <aOTgeakQYcCIk-QO@gpd4>
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007015147.2496026-2-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 44210565-8ee3-40fc-cf69-08de0585d224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KHBtxdylD7Cv82jxNOJQ33oTnIyJ+aPe83AfUqC0ywm+hkRMgWfPrW8wc11d?=
 =?us-ascii?Q?H5WfnYNnq/j1MLix16xA9KCm9/oP2paDVZReRN5wWYxvyA37h+GxWLeSUbld?=
 =?us-ascii?Q?XHIhHcqBCoEAXRNUnx22jPRsAEOruiR/GFQfEB+JYULySQitsBAN40Bg8gXe?=
 =?us-ascii?Q?0z4ImxAizuOUHegKi24OZZJ1HTXafBIwb+5cYGRas6d5IFC83HxHAFW3ckPY?=
 =?us-ascii?Q?FGkG5plrKAX/8tP+okS5XtHInYOroAaor7jN2wmS8ABOwXVgsVCEfiefL3qu?=
 =?us-ascii?Q?4laY//ToJTZMktHOZIiJN8iJwmMX9p+1UQe+ZvWq9eWjQXWnfMho/X+0uMkx?=
 =?us-ascii?Q?Ni6FvLuDAH/MEsSsAknpOYOYH4tMRzOhtoH6R6879vXHJbo2nic7aWVsznf+?=
 =?us-ascii?Q?jbXgZxzz+tGpZpQxUbQ8TG4xBCMQbLBswOHw6jo72DAeD529S3F6ECUvM3yf?=
 =?us-ascii?Q?h+aGB0yx1kJGvehvtB54U83VhbGbaj8rYDHmhhiA6Rcr7pz+GHhBHhzetgIq?=
 =?us-ascii?Q?3lNMMIMiAdayccvgI8R3VkDHS3KWUQg1bkaQSBwpmpJcgsJduFIA3/96pKAo?=
 =?us-ascii?Q?PQWUPGhCqj5lCrojZWiWTj/drrsDwt+JjB26hGMQmbUA61jaxxCZcbO/ueHL?=
 =?us-ascii?Q?YCC01WfVNSl9OeWinNIb5wr8wjAovvHHcYgIbDkKDCXSac9yMSQaIJTn/s23?=
 =?us-ascii?Q?iltgrr9auZfhQGm3YDsWicRYb/4J36C4bz1Q+ADSYZrbASpCXmvOXYWrD3Lm?=
 =?us-ascii?Q?59wCwr3D93SLbsmGsOi39p+SbinfDSUA3ShG5Uj/HZCChB5DjCILfnhP7DOB?=
 =?us-ascii?Q?yHzHZygeTLouSCEymCGal18Lu0jUu6eT6IP06U+UqzrAN8An5zjJsHYp1i2x?=
 =?us-ascii?Q?Be4zefksFRRyj9LVfJgRTY1FG5DH7zsxtzIFk79zap6a76OpQYVWt1GGtel7?=
 =?us-ascii?Q?Y0k2HJm2Q4sd/VXUA08zh1J3JOW6lq1cekqZrI2MFVhihEguOK4i8lkw0i5Z?=
 =?us-ascii?Q?ljkSd39GTZyG7h10MSRv6oFaALg+TQPI6WWNQIcx/HC7aG7gjYPpKa/lVOcn?=
 =?us-ascii?Q?/FjX2pIU0hEPJzIhy2cUDiKL+T4/HCy//e6o+aHUO7E4QmVskYv42mbYHI42?=
 =?us-ascii?Q?Ycn8jxSpI0eJABZgRQCBvAyva4jywdKNRHxkV3sbGBiMIBJDPteQZ1tzTW2C?=
 =?us-ascii?Q?sX19ZoF03jUVDcyPgTapKwB6kSjHJkRrY70dgvLm04B7zxCcXhX6WWdv6dAX?=
 =?us-ascii?Q?/rzii67FjsVyMPi/yHv+4AtrwjnQQbkfZ+3fHiRfZqE6PXV74buyLfnHSz6m?=
 =?us-ascii?Q?+HSh2dpVt/ZYNVHcIA2jCEGWs022K67BO07xfLZYpvlO9Cupx3rvN4M2Jil7?=
 =?us-ascii?Q?Z53Jj/+fbChf51hpWgh+KVF65EUr/e19zorEK6gQ0fL2KL2WchwuoaMQi3wV?=
 =?us-ascii?Q?DrPPJyRpWmpAZfJKnoe5fz33AKAyXNrL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?30C/Nvg/8kSRXwb5nwPbthmJD9iM9M5PQch9pMiZhnHcxsigfty35CDFj820?=
 =?us-ascii?Q?2r8ioCvwcr86kcbXHKaChwKW8awWjYN5JveOyxUPX+lRMYHhm/8XMTsgJyyH?=
 =?us-ascii?Q?LBlc6GzGeN3/JuK3cAJa7iOzbXYDB5hrqcg4XQTzht+6QFqKNw7sda+iCCA+?=
 =?us-ascii?Q?5v/Rvhbne2iFBZTmVbWD5auIyB2ax1dC8DOFUYVJQy3hYFruRxWG1a5psRgX?=
 =?us-ascii?Q?+IB3ypw6hZYbyZ0tqRa4LBDx6gRfzbZv06xQ+BDJrjoNoyDzYW7qw6PPUeTF?=
 =?us-ascii?Q?CcfxdNTBYSAsBx947Qoio/jNwTzhVphf5UePmO8sowjPK3OpeCXlwqBehqiz?=
 =?us-ascii?Q?AF/G7AhciqvB16xxEekph/ukT/WzXiqQQyIbmeb/hfEiENssZUnJG662D+Ik?=
 =?us-ascii?Q?qyxarhmS5i1obSTDRp5Jyo/ndw884xylMnIUhXa6pVBFjCDCNA4Wlwl0CUSb?=
 =?us-ascii?Q?f8Rl21K9KuLqWwBC2uRVx+1lFczknzBkkpAOkCjiXO3RyyUWOs0ppm1adeL2?=
 =?us-ascii?Q?SYHXnWqZBSl+PfJDK6iv4Qv4VfynEIrC89FZUN971654EHTnlUHo297eBNIb?=
 =?us-ascii?Q?gIUoB3DyB1BMab5uIN568/Bq/hAVQgnX/KZpWmF7kFHA5a8QKkzkGQhzxuee?=
 =?us-ascii?Q?C5/zXtH3R2VszTFOnrimiFyBJAiBEItP+L/ycZFfhahGIkBbKN57wS10/iPt?=
 =?us-ascii?Q?LOpjiLvUOCpKo3wngIGpvQ8OhVmCJklUatzR/xV5j9vqvSj0p3zbMaEy491o?=
 =?us-ascii?Q?zLmBUymIoUv6eqqxcSnQa9Z3Zt8pwVEG1Kz/JHJcEZXIopq6SIAyTqH5pZ7g?=
 =?us-ascii?Q?FnP9LXMB/tGUWQQNupcNH2y3wLnT7FDt2gZqoC3CVG+aLtEMj6ObZ1u6VliA?=
 =?us-ascii?Q?CiCW+EZe+z81mjQsHLQaJqf9pgzPC7qCRgLKaXEKT2Jl7fQIjTsMzCHF1YQW?=
 =?us-ascii?Q?fVHQaI7YheTfVtaqTcLNWjdmcChJcXl+aRycAKbMzmVxRgDxidDwSZRRx9rx?=
 =?us-ascii?Q?CeWf5RThnNsR12K73+9Q0kARJcFpUxPCie/Eg/1cTqcZb2mMfoIY2Q+0cmNP?=
 =?us-ascii?Q?FjN7A58oYCNgFt44ptJTV/PQLFetVMXJPGrdKtFRqXkYT5SoEniJ+lRUEN56?=
 =?us-ascii?Q?kn4uO9GspB5y6xLgRmCglQS8H5GBgq7ivjYtN1KKLfXszejcA+IMF6d4LLXg?=
 =?us-ascii?Q?rKZasgipzcMoIaIksNk5tN1TI5GtFco1dzE56ZPnkZFgM+wZ3NXFrU5W/3mS?=
 =?us-ascii?Q?BqFGAfvGVkz+wcSXwo+0XxFGyZc0AAlhb5FR92W8qvgigI5LVrRnzOr2Owlw?=
 =?us-ascii?Q?cw9ypL2X31IhyKURS0TetEQy6/ZErSCyy6s0Zwm5i8Z9HLRhIxJqZNxsr1uK?=
 =?us-ascii?Q?/E38oM4Yi0k+GYLriZpFz9vjade9QYV/nnd5E1Wk6BF4bF1WRZkhy8eNoUPL?=
 =?us-ascii?Q?1SGenZMNqmYRCOvg6ci1nT+BoYYAfRb3rViIwFIsS0zWc9WBcxupwIaqE2z2?=
 =?us-ascii?Q?kPSPyP3hPWtJUe4EwLS0qasSrJbZLzbmgoIQkHdraq5+eC1wllQmDM4ILRCy?=
 =?us-ascii?Q?hU8m9D3YKhQqGSmqKPPmX3aC1VYQT3ewbj+oBHgv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44210565-8ee3-40fc-cf69-08de0585d224
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 09:42:24.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCt6AUYmNaRlmd5opkuAID5HDPh3XmsmiQB0mZWchdLM8dYFRH5kQaaoeI+0g8rRTRuaucezAVofPvVFpB6YVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

On Mon, Oct 06, 2025 at 03:51:44PM -1000, Tejun Heo wrote:
> Enough time has passed since the introduction of scx_bpf_task_cgroup() and
> the scx_bpf_dispatch* -> scx_bpf_dsq* kfunc renaming. Strip the compatibility
> macros.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/include/scx/compat.bpf.h | 108 +----------------------
>  tools/sched_ext/scx_flatcg.bpf.c         |  10 +--
>  tools/sched_ext/scx_qmap.bpf.c           |  14 ++-
>  3 files changed, 12 insertions(+), 120 deletions(-)
> 
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index dd9144624dc9..d979f16a3ae2 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -15,121 +15,17 @@
>  	__ret;									\
>  })
>  
> -/* v6.12: 819513666966 ("sched_ext: Add cgroup support") */
> -#define __COMPAT_scx_bpf_task_cgroup(p)						\
> -	(bpf_ksym_exists(scx_bpf_task_cgroup) ?					\
> -	 scx_bpf_task_cgroup((p)) : NULL)
> -
>  /*
> - * v6.13: The verb `dispatch` was too overloaded and confusing. kfuncs are
> - * renamed to unload the verb.
> - *
> - * Build error is triggered if old names are used. New binaries work with both
> - * new and old names. The compat macros will be removed on v6.15 release.
> + * v6.15: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
>   *
> - * scx_bpf_dispatch_from_dsq() and friends were added during v6.12 by
> - * 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()").
> - * Preserve __COMPAT macros until v6.15.
> + * Compat macro will be dropped on v6.19 release.
>   */
> -void scx_bpf_dispatch___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
> -void scx_bpf_dispatch_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
> -bool scx_bpf_consume___compat(u64 dsq_id) __ksym __weak;
> -void scx_bpf_dispatch_from_dsq_set_slice___compat(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
> -void scx_bpf_dispatch_from_dsq_set_vtime___compat(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
> -bool scx_bpf_dispatch_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
> -bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
>  int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym __weak;
>  
> -#define scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags)				\
> -	(bpf_ksym_exists(scx_bpf_dsq_insert) ?					\
> -	 scx_bpf_dsq_insert((p), (dsq_id), (slice), (enq_flags)) :		\
> -	 scx_bpf_dispatch___compat((p), (dsq_id), (slice), (enq_flags)))
> -
> -#define scx_bpf_dsq_insert_vtime(p, dsq_id, slice, vtime, enq_flags)		\
> -	(bpf_ksym_exists(scx_bpf_dsq_insert_vtime) ?				\
> -	 scx_bpf_dsq_insert_vtime((p), (dsq_id), (slice), (vtime), (enq_flags)) : \
> -	 scx_bpf_dispatch_vtime___compat((p), (dsq_id), (slice), (vtime), (enq_flags)))
> -
> -#define scx_bpf_dsq_move_to_local(dsq_id)					\
> -	(bpf_ksym_exists(scx_bpf_dsq_move_to_local) ?				\
> -	 scx_bpf_dsq_move_to_local((dsq_id)) :					\
> -	 scx_bpf_consume___compat((dsq_id)))
> -
> -#define __COMPAT_scx_bpf_dsq_move_set_slice(it__iter, slice)			\
> -	(bpf_ksym_exists(scx_bpf_dsq_move_set_slice) ?				\
> -	 scx_bpf_dsq_move_set_slice((it__iter), (slice)) :			\
> -	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_slice___compat) ?	\
> -	  scx_bpf_dispatch_from_dsq_set_slice___compat((it__iter), (slice)) :	\
> -	  (void)0))
> -
> -#define __COMPAT_scx_bpf_dsq_move_set_vtime(it__iter, vtime)			\
> -	(bpf_ksym_exists(scx_bpf_dsq_move_set_vtime) ?				\
> -	 scx_bpf_dsq_move_set_vtime((it__iter), (vtime)) :			\
> -	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_vtime___compat) ?	\
> -	  scx_bpf_dispatch_from_dsq_set_vtime___compat((it__iter), (vtime)) :	\
> -	  (void) 0))
> -
> -#define __COMPAT_scx_bpf_dsq_move(it__iter, p, dsq_id, enq_flags)		\
> -	(bpf_ksym_exists(scx_bpf_dsq_move) ?					\
> -	 scx_bpf_dsq_move((it__iter), (p), (dsq_id), (enq_flags)) :		\
> -	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq___compat) ?			\
> -	  scx_bpf_dispatch_from_dsq___compat((it__iter), (p), (dsq_id), (enq_flags)) : \
> -	  false))
> -
> -#define __COMPAT_scx_bpf_dsq_move_vtime(it__iter, p, dsq_id, enq_flags)		\
> -	(bpf_ksym_exists(scx_bpf_dsq_move_vtime) ?				\
> -	 scx_bpf_dsq_move_vtime((it__iter), (p), (dsq_id), (enq_flags)) :	\
> -	 (bpf_ksym_exists(scx_bpf_dispatch_vtime_from_dsq___compat) ?		\
> -	  scx_bpf_dispatch_vtime_from_dsq___compat((it__iter), (p), (dsq_id), (enq_flags)) : \
> -	  false))
> -
>  #define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)		\
>  	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
>  	 (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
>  
> -#define scx_bpf_dispatch(p, dsq_id, slice, enq_flags)				\
> -	_Static_assert(false, "scx_bpf_dispatch() renamed to scx_bpf_dsq_insert()")
> -
> -#define scx_bpf_dispatch_vtime(p, dsq_id, slice, vtime, enq_flags)		\
> -	_Static_assert(false, "scx_bpf_dispatch_vtime() renamed to scx_bpf_dsq_insert_vtime()")
> -
> -#define scx_bpf_consume(dsq_id) ({						\
> -	_Static_assert(false, "scx_bpf_consume() renamed to scx_bpf_dsq_move_to_local()"); \
> -	false;									\
> -})
> -
> -#define scx_bpf_dispatch_from_dsq_set_slice(it__iter, slice)		\
> -	_Static_assert(false, "scx_bpf_dispatch_from_dsq_set_slice() renamed to scx_bpf_dsq_move_set_slice()")
> -
> -#define scx_bpf_dispatch_from_dsq_set_vtime(it__iter, vtime)		\
> -	_Static_assert(false, "scx_bpf_dispatch_from_dsq_set_vtime() renamed to scx_bpf_dsq_move_set_vtime()")
> -
> -#define scx_bpf_dispatch_from_dsq(it__iter, p, dsq_id, enq_flags) ({	\
> -	_Static_assert(false, "scx_bpf_dispatch_from_dsq() renamed to scx_bpf_dsq_move()"); \
> -	false;									\
> -})
> -
> -#define scx_bpf_dispatch_vtime_from_dsq(it__iter, p, dsq_id, enq_flags) ({  \
> -	_Static_assert(false, "scx_bpf_dispatch_vtime_from_dsq() renamed to scx_bpf_dsq_move_vtime()"); \
> -	false;									\
> -})
> -
> -#define __COMPAT_scx_bpf_dispatch_from_dsq_set_slice(it__iter, slice)		\
> -	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq_set_slice() renamed to __COMPAT_scx_bpf_dsq_move_set_slice()")
> -
> -#define __COMPAT_scx_bpf_dispatch_from_dsq_set_vtime(it__iter, vtime)		\
> -	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq_set_vtime() renamed to __COMPAT_scx_bpf_dsq_move_set_vtime()")
> -
> -#define __COMPAT_scx_bpf_dispatch_from_dsq(it__iter, p, dsq_id, enq_flags) ({	\
> -	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq() renamed to __COMPAT_scx_bpf_dsq_move()"); \
> -	false;									\
> -})
> -
> -#define __COMPAT_scx_bpf_dispatch_vtime_from_dsq(it__iter, p, dsq_id, enq_flags) ({  \
> -	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_vtime_from_dsq() renamed to __COMPAT_scx_bpf_dsq_move_vtime()"); \
> -	false;									\
> -})
> -
>  /**
>   * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
>   * in a compatible way. We will preserve this __COMPAT helper until v6.16.
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index 2c720e3ecad5..43126858b8e4 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -382,7 +382,7 @@ void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *p, u64 enq_flags)
>  		return;
>  	}
>  
> -	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
> +	cgrp = scx_bpf_task_cgroup(p);
>  	cgc = find_cgrp_ctx(cgrp);
>  	if (!cgc)
>  		goto out_release;
> @@ -508,7 +508,7 @@ void BPF_STRUCT_OPS(fcg_runnable, struct task_struct *p, u64 enq_flags)
>  {
>  	struct cgroup *cgrp;
>  
> -	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
> +	cgrp = scx_bpf_task_cgroup(p);
>  	update_active_weight_sums(cgrp, true);
>  	bpf_cgroup_release(cgrp);
>  }
> @@ -521,7 +521,7 @@ void BPF_STRUCT_OPS(fcg_running, struct task_struct *p)
>  	if (fifo_sched)
>  		return;
>  
> -	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
> +	cgrp = scx_bpf_task_cgroup(p);
>  	cgc = find_cgrp_ctx(cgrp);
>  	if (cgc) {
>  		/*
> @@ -564,7 +564,7 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
>  	if (!taskc->bypassed_at)
>  		return;
>  
> -	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
> +	cgrp = scx_bpf_task_cgroup(p);
>  	cgc = find_cgrp_ctx(cgrp);
>  	if (cgc) {
>  		__sync_fetch_and_add(&cgc->cvtime_delta,
> @@ -578,7 +578,7 @@ void BPF_STRUCT_OPS(fcg_quiescent, struct task_struct *p, u64 deq_flags)
>  {
>  	struct cgroup *cgrp;
>  
> -	cgrp = __COMPAT_scx_bpf_task_cgroup(p);
> +	cgrp = scx_bpf_task_cgroup(p);
>  	update_active_weight_sums(cgrp, false);
>  	bpf_cgroup_release(cgrp);
>  }
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index 3072b593f898..c67dac78a4c6 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -320,12 +320,9 @@ static bool dispatch_highpri(bool from_timer)
>  
>  		if (tctx->highpri) {
>  			/* exercise the set_*() and vtime interface too */
> -			__COMPAT_scx_bpf_dsq_move_set_slice(
> -				BPF_FOR_EACH_ITER, slice_ns * 2);
> -			__COMPAT_scx_bpf_dsq_move_set_vtime(
> -				BPF_FOR_EACH_ITER, highpri_seq++);
> -			__COMPAT_scx_bpf_dsq_move_vtime(
> -				BPF_FOR_EACH_ITER, p, HIGHPRI_DSQ, 0);
> +			scx_bpf_dsq_move_set_slice(BPF_FOR_EACH_ITER, slice_ns * 2);
> +			scx_bpf_dsq_move_set_vtime(BPF_FOR_EACH_ITER, highpri_seq++);
> +			scx_bpf_dsq_move_vtime(BPF_FOR_EACH_ITER, p, HIGHPRI_DSQ, 0);
>  		}
>  	}
>  
> @@ -342,9 +339,8 @@ static bool dispatch_highpri(bool from_timer)
>  		else
>  			cpu = scx_bpf_pick_any_cpu(p->cpus_ptr, 0);
>  
> -		if (__COMPAT_scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p,
> -					      SCX_DSQ_LOCAL_ON | cpu,
> -					      SCX_ENQ_PREEMPT)) {
> +		if (scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | cpu,
> +				     SCX_ENQ_PREEMPT)) {
>  			if (cpu == this_cpu) {
>  				dispatched = true;
>  				__sync_fetch_and_add(&nr_expedited_local, 1);
> -- 
> 2.51.0
> 
