Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B283364050
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252302; cv=fail; b=uQNN8s5rstYVh7+9EA+ucXA/gA9QPcEBoaOJPWgBuD8se96UtGmqJ9L3jRlJpo/ti59wzho+Ps2XmIPhU4Pyr1g+y44weg5ssOJ2VABPPhGk13YhRW1oAxuPj9zxOjKL9G4peqSVTolmnLv6X7nBbnzbtvLeSzEdtc1tDLO4LNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252302; c=relaxed/simple;
	bh=o40/X7xH2t5arDCMItJom7AenycYLY0y4/9Nhyp5Cf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YewYsHhtOwF51xytQm1b6stHbxSoafXv4pwhKkEAu1nchc2TXQvY5L1i9fI+15VaNDtPVrhAGwjG9l+yMgHdtFPeiRHO9CEHh3+bJT4U/YRSuIjFSjhQ8H+wkKyVl33HWHocKTwrJqG3Bm13H8Mm03IF6KALk/FMWLS1TZE4mwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mU3EbJdL; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mU3EbJdL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEWTjH505r0TD0T4gi9J9pA65VaSkF+rYExqIpH2W+XDzJ7/UezqytHZSsSuSCCMw/9bIWAelX5N/VYuGgmp4ZvHduXLGqpFpvqW/+LdOUO5QanSy/kHfyi0uROR3PpAKWhoeEDPy+S2IihFpFsb0S3FmcBCqkhMROaOfQjDLn+3W6Q/032FNeRqtNFRXGpNsgcsMx8rbuP62tac/9POWBwdrPe8iTJvWE96OVl5p3/vwuHJbVzE6eB6fffSg5nt2Ld/SvUGnm6otlS7PtlH30OnsrvFSvqkqtYvNigc0Q45dP9uMhM8dyLHbgwQvJNpHkkK3JAnGz5VlsEGXHgPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09onMkrg5Iry9nLWOAOg+w7Kd33S6Iu0NvnRBQvjSy0=;
 b=rjb9qR6tsCKQgUAkfesuvjjou3QgYMRyhXN0qt8OXpl02JMp3AXVsfFoFWdm4dE7LU+Sg3ZGzADAglVi+gonE65zaOb+HIZmlcjgttMuAqn5Rw8kKc3saMGtaz3zxL4kUjNhA/4f/xghj2LedYduGBefdKQTxcNg6JvekdjYXm1a2LC80DrXndKwn3/0bf1pOlv6wLNp68oJgBLITLvI1fpcUysOEoWVUYil2AgS1l4Yv1SJhGNaCb9dDHhlZr9BF5BFKdws61e15H+kQIWE/Vyq+6tiJA9+bPXN95zYM5hJlZN40rOzmeX4I6bwZq8/ITGkqnkoBvMUE5vZs4Thyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09onMkrg5Iry9nLWOAOg+w7Kd33S6Iu0NvnRBQvjSy0=;
 b=mU3EbJdL7PE1qeEAUTv/CFseA0NmvxycR7gtzkEAKZCZLqNT4PMlrljBFDxCNYJjSk/pGJaGHt7MhHVl8qGzcTkkfAAzvNN5X130he/5cAdhvGXXUeMD8V6+b2qkhcS3yrWXXZevDQH7Z3sceqBJNdvGrcoeGx01H3Vq8QeHQNYXW5mqouWRdgBQuVVJP6J7DzmDLvqSucJpojP/xPmzW00Lx9DZLDaBvtUXWrnhi7CSL8bReROdoDHAtdWE9lCpAQCcL2XXBJkRJNbY5MnXiPKTNA+jVoLFDiUJJD/PVqsKX56ORMuk+7aqS8wRYda8NuF4YNPFJR6lRBKdiYpxEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 07:51:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 07:51:37 +0000
Date: Mon, 23 Mar 2026 08:51:28 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Add __COMPAT wrapper
 for scx_bpf_sub_dispatch()
Message-ID: <acDxAON9TXIZDems@gpd4>
References: <20260322144433.1649092-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322144433.1649092-1-yphbchou0911@gmail.com>
X-ClientProxiedBy: ZR0P278CA0123.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe883c3-30b5-4f22-d6d2-08de88b1030e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2QmHA3kXIPwFGNeyF/IX+8fSzdOVSbcCKQZxAoFs44ftF2aUBpDNdks1WInuIAEUtCK5PzW+UjTcvZgwiUFBuLcMZbh+MzuVdvnlGG9EYhylklYZKZy7sznKWaUhRf94b8bgfJSZWu8YwLDdmcmXqRk/7v3JzKyLnvk/kRFzIrXGuH2cotlOwxtjZeF6eYugXssQuQAZcByKw8vmp2WwuK8IclV81GBGXy5MNzWwJl8T6JfNJKLcps+/475BlM2Q7iFvuDWoiZp+K8yV3wsLD/D6pBR49C+Zdxj3TmZVQNvpFjCgFNMw4MssKPYA8/LgzLx8N2xtiUrScre53I+4fwhp6lhwj1EexUR/8lPACAMC3nRle4weFxvy7/hE0oretbB7sv2+SbX6Zb53ifyWDbmRYwjOf5dunCu8uKXEXSbn2+fYKLqnJW2CtFpSqC+ZZWh06ihdx8S2TR+XO0yEsmG+bMb5v9ufwk7bGARv7OJXT6UT4pMNMar57qYDlPSJLJlyh5+ltOx2444nEyQBi1wxmKo6+gh2GBgmNs+hqLr/Tloqg7HqPCBfwf4X/7DEEhIah2A1a1BJJwDkLwydXwpXgEGDTU/nM8zdyiVFJFyUCL1mwdYfCKcqSSCdTChqWjzpRS4+dZtu1q6GDqmgg29x1QAYP+NN9G+jg1CiQNvCRIcDqYCYQtGzKjzyr0RK/oB4rP8t95B9d6sQ5HVC/2o47cmDXyzZrSm/RhGNItc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XlFjBvKP3jlXQ7UBhT162rcChD2NwNe00hVeXLOnwxH01MlDrpLwLHxsLV3T?=
 =?us-ascii?Q?8eI2tSPwH9+xqDw7kUSE9tbZZMHrFxzj2CJFbvtfxWVGDPKVTrEe3/nWADGo?=
 =?us-ascii?Q?HSPnYPLkKRW85C1Pt5mSv5r/4HABRdlK2Hok4riyoKOgE9xy8PHniVTaV3l0?=
 =?us-ascii?Q?PSzxEJVD6LKmWqbt0LAs5eVAxNv4EqHkoP3TspCQ6s3eftY7KDuqzY5VsMfY?=
 =?us-ascii?Q?iVzK0AXRobYDjY1Gx9/5zQEBs5fzYE+3g8zi3cHJ8DOdFVu5svgEW/pOXLb5?=
 =?us-ascii?Q?WEzUIbpXGnZbF2yGtU1yJ37AXMXp4thr0DfkafP1XFdNlXGWL3G45luCvAYn?=
 =?us-ascii?Q?hsAe4rYLiat/v2X2BlxRhpA09cY0y80VJ8omS3EUHsTg0avGHBop8/ntBq4Q?=
 =?us-ascii?Q?Sknt6s+y/FkGTc3aT6TyCvTnlEU0QbewlBzoh2+0p8vJ0ko5Y84Wtws9s1B+?=
 =?us-ascii?Q?yq70rDXKKyJ5jlhW4FlwHpYFuhYMsRybdlTa/exncr150ebdK6sQ6M7GAXHt?=
 =?us-ascii?Q?5AfwGjZZgJfkd44qvx3isz8LH47tSVM0nA+UKCPaexzJNB6xyNsHHujqS6SP?=
 =?us-ascii?Q?yFk0RtUNcV+duJeTHwN/rOGZora9xjE5eRKg26Vpj72n467agPK/yk6t3wNG?=
 =?us-ascii?Q?Y9qhfNpp/mTY6PPCespNCIruWa1BM11hbQnzeKtIG+GOQqFtfdf/olfM0D6Z?=
 =?us-ascii?Q?MaoaeA9TGZok7+dirIDo0oHBlp3mzgHahcqhWk/pkyMxCGCn0LoRZ2JFi2zg?=
 =?us-ascii?Q?GFFl+pQmSKmTQ2zR5p0Acl3IrxyuUvMHae5IgeHukLv8KzTNHFerOYZur1gT?=
 =?us-ascii?Q?+f2LpNdIsFvyP2v5x3EyYnDi5Dff5nlDgk2pKuti5iAyif5gx278Kf1pg5FX?=
 =?us-ascii?Q?pk7/bkKDPfgvmmBNulkYGbl3PjgSXFjIGG1N/3o2Wc5s0lvMvu63aPCYdavN?=
 =?us-ascii?Q?g4utw4CnwoZz82ZHEwvTHL4012ooCJp7Lho3DcQq1CrHsfKg5n4ntOgbMIqQ?=
 =?us-ascii?Q?w8AzEzftJptO/cmsAtk9zgmZxf7IUM461NACjZ2zewRZI+oXoOG2pp/u8VfC?=
 =?us-ascii?Q?yHT+rRGtKsqDy9AJD0mqFnDzZ5ie8MvnLWEFGxUSkRJclbWLkK4Uzsr3vsEP?=
 =?us-ascii?Q?Md+Q61TDurOBnkjSq9KnqhNWvqOlEVbHaAqYTSjKoZa3thvmRGnlcpdXjOoK?=
 =?us-ascii?Q?+fmyYGJPJqqE5SzpbF0fT3HpRzsimXHa0bAQLi3A1n0uQlOBtiJG8VU3RlRy?=
 =?us-ascii?Q?PTQHacoyptpx9ahHxQXOCK/F+UN7wx8/khnWWy9n7b3jXF7h+4/iy91vI0az?=
 =?us-ascii?Q?VyN9dIboe4GBMJkasXsK9JXEcwlYDpV0y9/VNdLK/okWuEjrd+lqnup+2CgS?=
 =?us-ascii?Q?58PVxIWtnr1OXGhqftbwgL3PCKFSnp0SjCavoTUTimcX6QDNlbXUWqVTVhd8?=
 =?us-ascii?Q?X6V/VeC6GVZOGinYDkcIY24wQti4LyD3ZrtIBuSJHztGWBTUXlGPNhG7R1GI?=
 =?us-ascii?Q?dW13yEQM5Et53d6VRzZiM4jVKAfnTjC1lWq4j3iFr6BPN6A4Z2x9ygRejHjv?=
 =?us-ascii?Q?XL2wRUNG35cUtpRJutl6m0atMB8jR0fG/zGQ/VQd4WbHzswmEXfTPG7YBxtY?=
 =?us-ascii?Q?HsCJy3VNlnuQ+QAjoFY3/f26pwEMmqU8Wyy+TmR4Sk6vSsp8Iw94kzxzgzMJ?=
 =?us-ascii?Q?Ts7Oczo2nSeoJ2+gom0di70nzwDSWEpcZyygUybW3YIMKyr/gd5SXM0pLy4t?=
 =?us-ascii?Q?fPKUf+Kb3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe883c3-30b5-4f22-d6d2-08de88b1030e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:51:37.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5xx+ejWPV2VUuRQ7Oo4AUunfEFwe1t4I6lKE6y11Bz1PUP/JM+mx7ztNVs3FPqOGhj1g4EM9mnAiejKXMuzrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186

Hi Cheng-Yang,

On Sun, Mar 22, 2026 at 10:44:23PM +0800, Cheng-Yang Chou wrote:
> Add __COMPAT_scx_bpf_sub_dispatch() to compat.bpf.h so that schedulers
> using sub-sched dispatch can build and run on older kernels that lack the
> kfunc. Guard the call with CONFIG_EXT_SUB_SCHED and bpf_ksym_exists(),
> falling back to false when unavailable.
> 
> Update scx_qmap to use the new wrapper instead of calling
> scx_bpf_sub_dispatch() directly.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  tools/sched_ext/include/scx/compat.bpf.h | 13 +++++++++++++
>  tools/sched_ext/scx_qmap.bpf.c           |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index 83b3425e63b2..f24b9a1c75ad 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -108,6 +108,19 @@ static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
>  	return p;
>  }
>  
> +/*
> + * v7.1: scx_bpf_sub_dispatch() for sub-sched dispatch. Preserve until we drop
> + * the compat layer for older kernels that lack the kfunc.
> + */
> +static inline bool __COMPAT_scx_bpf_sub_dispatch(u64 cgroup_id)
> +{
> +#ifdef CONFIG_EXT_SUB_SCHED
> +	if (bpf_ksym_exists(scx_bpf_sub_dispatch))
> +		return scx_bpf_sub_dispatch(cgroup_id);
> +#endif

Isn't bpf_ksym_exists() enough? The CONFIG_EXT_SUB_SCHED guard takes effect
only when we build an scx scheduler using __COMPAT_scx_bpf_sub_dispatch(),
instead we want to build the scheduler anywhere and then the BPF verifier
should evaluate the availability of scx_bpf_sub_dispatch().

Then the symbol will be resolved by this (from include/scx/common.bpf.h):

 bool scx_bpf_sub_dispatch(u64 cgroup_id) __ksym __weak;

So, IIUC the #ifdef CONFIG_EXT_SUB_SCHED guard is not really needed here.

Thanks,
-Andrea

> +	return false;
> +}
> +
>  /**
>   * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
>   * in a compatible way. We will preserve this __COMPAT helper until v6.16.
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index f3587fb709c9..dd44d8db0341 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -490,7 +490,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
>  
>  	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
>  		if (sub_sched_cgroup_ids[i] &&
> -		    scx_bpf_sub_dispatch(sub_sched_cgroup_ids[i]))
> +		    __COMPAT_scx_bpf_sub_dispatch(sub_sched_cgroup_ids[i]))
>  			return;
>  	}
>  
> -- 
> 2.48.1
> 
