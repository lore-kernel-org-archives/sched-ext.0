Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515FC379EE8
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629762; cv=fail; b=oMP456/234+CX7Vd49bE4sEpeTg2J0p1J7px4kV3VB7ebZCVKIJFbh9vxilPuDRxwmBpYByWQLfdLKuEgVT/YdhrDTad4ibHJ3XybsJo11hgvDk1gKx37bDpd0hUgoXPaPmMuhDlDGTwdP8OHwfUQ2wi4t8JdDlrb7eCjw5T+2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629762; c=relaxed/simple;
	bh=FXlcy036u/KsYGwv5AISLZ4bAmTh35GjhjatfI2yhEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UjSNq7M10L0BEzIbEPJVIKNEmHzQRHovjM1+6jvvAQ6Dx6V3INlbubJBYeeNYwSNP3iE3dhN/N08HK75q+ZmS+hxcyImiHiX5JljML/HRM+GObdUxeiaWiSCD0rJF5bPQo9sJocZudf6CrOYYs2d1d8KnZYinl9sPttfCm0vr0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k2306IRs; arc=fail smtp.client-ip=52.101.57.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k2306IRs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/o+brMIDaARKatdMHOr6izkxSMpiq0ZcNk2OPZdGDgK7XsxDtlhV3/sgbIbqP8GtcXAjvhz/MdMsgA2/Ody8GqxdneKMxM+Kq2468jBZk7XtDWx5J9EB859/LV+Rdi1A6USkns1sE//+bTh44uH6tgLcb8VSgfztSTBOBenSNPBB+AxYcCGrcNj0uj0oWQK4AitFuypjcH0579ObYdhC9NSeDjOJX6LXNgv75DBMHaSCAcIJPbmjdW+NRAdwNKG86dLOirHlMekxnNkmXbZlWRZnhNpVNGzhy0GiJmsrb8gm7Ip5up+L851xmbWOndV4INdV/xegEKm1T2uW8VCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yteHY8GCrXMsqw/oRKWGS4APEivAFCygsLIHiwwdNFE=;
 b=Zo34tyekJXNHzFzg5stbTMvEecqExt7WPw2DUp0W+dx3eMMsy1B/xops994RyA/hObMY6Q0dZfJCgkGbIiqDt33plb6xD2V5kCeDWVHjeUYVLuBER4xkPfLxzgRK0n7ge30avTutBAxxO93J5jtHqQNfsevYoN/6xgFV88f18AbQisPndatr65V4wcqIoj0beiuzUr2KRCsKLMVpYnveh6KLrUt2kU7ERK5BXQtlFSN1qYhnsTAIVjW8x7M1eii+A2SgCSbpsBgfupi82+WbtzZBw9Ro5k0+fKju8UyZI9kM/w0pw8zo8nx2GfP9OQmzjCphviX1/ezqhpKhKqLFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yteHY8GCrXMsqw/oRKWGS4APEivAFCygsLIHiwwdNFE=;
 b=k2306IRslPCyaqUZ868fCZwisfKtg2YYpC7UpRe04pIM1w9zK37H0m+XZVL3bDORymWBlHtwrCVmDCzaT9LWdjm5qVOJWlTSu+Aw0h2wjO7o0ERxmUzd23kNb0B0IEt0Q3JEGOtn9AkcZ6CAv2mAe7sWxQ8Px6XM+/yD82osM1OaWNmfvP6l5rFNBJccDohNSmxDs2w99m6WNGrfLinyOxnEthJmV2aV99UCr1WSkgtUxqVsOjX9uHDo0DEhJwzvsdcli/5qZQH0s4t3GYjJWDrfVjUTwWFMjuTBzzp/IzCFSYb1PWCH7UE6ekPUhcdHWbpBJdjM654S/h0+poi1VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 20:42:33 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:42:33 +0000
Date: Thu, 9 Jul 2026 22:42:25 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 07/40] tools/sched_ext: scx_qmap -
 Use bare u64/u32/s32 integer types
Message-ID: <alAHsY94lkrpAjEA@gpd4>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-8-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708212429.3405787-8-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e45d9a-f045-4f23-31fa-08deddfa9a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|4143699003|6133799003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	3ZIjv3H2IACy5ia/kqRlzImiTK+U/fEMBtCRMaAHrKpUG/muqidAky6AFI1OBaNQd00rI1f5dJa28pHaEf6NbFQT6YTno5eoJ6GqbNbHx/mgo9hpWgIWjaqawZRmHU8Y9XlkLBCWnujt3oue41o9Q1+Af39+oc8Ft/+Blm4qHR01mhwR70bWBDhXuLOf4mhS56cr2tihyPfXDrfTTwXIPTRer8DUv3G5kFTkIZoLyYfcMpuLRzwjtxjsHbFSa0o2qlcrcj1ygp4ZYxPUd9jNjftBljRQWOLC5FW4ajH9YlA4Ys/12HXi/7VBw66fZbeFDGej9mMMFQwG1qrEnWWKBC3vbghx7tuHaw1q4k2XvjEPLQn8zTT2bd9cA86ap0zgQcgIo0hU39JaOeelX8GqU9fVpujz9hDVTUDPaAgBoEEfgUiU2t4ROi6i2nIu+apSDIP6BP7ysC3x39uEaSae/gBp0bzYE1bx8ImzgwnBJM9W9rA5GOKLiHRfw4Jf/9CE+YKCzSagv8yNHmYD9PheDmyc25K1FKkZTEIOp8iqmC4GEXM0u6GVqL8Shs+reQ4K58sFgC7+zNfVzE+fawg7XvWliXBGKDp4BeIzfklqV3Vy9e1aWZAsP9Z7SkaArP4VOuyMlR12fzJ1vEt9/YQCovbRu26E07n1JuqY/bVztTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(4143699003)(6133799003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IO288YNSLWgpAda/s+LA20es2UZ072/ndvyWeUIb5dpnzhLOMmYqq59+PemJ?=
 =?us-ascii?Q?dbe3kofuYnRBcaBJPLVKmWcOk1dpOjX9BsR3LH4gXVfpwLs/oEgqejbUkAOY?=
 =?us-ascii?Q?Lu3RRHNiBuVVzHWlpy0QZfIcELV0OqAyg+3CA0rDatjBm408zYktWiSRMBeh?=
 =?us-ascii?Q?JxTLwK3GpGCkHMCCcDslGX7pqwXYnvwyb/C3NXqoAEonAcYknALNMPceucbo?=
 =?us-ascii?Q?cY7GQH+fe98lSDhdw6Bvy08/pTu5ii0bLqFWj04NJGWvJ9qTp+MXt5kF/JRH?=
 =?us-ascii?Q?pCfrQ9hVKKJuRhiAF23hB259AvxHRX3VBR5SyA9/+o90tYGYrHcK/xPjle5m?=
 =?us-ascii?Q?ROO9ylvF8J88+FrhcKWnykjCDa5YIK3APP0xBPkMgh2WufT8911PPZWpMlW8?=
 =?us-ascii?Q?+azJJKRjPTj7txSJUSmRVw6Cc5YM97ScE8hQMUyJXk/c49/Us34GiOodefmN?=
 =?us-ascii?Q?KsoJ1MjayeHNKsaZrEZFpgijadJ3BNv51R6j3KYjnnZ5tOzaMPJObpk/tojj?=
 =?us-ascii?Q?7tNyjJL862mGuckNqP7yriGmIefkX6NCZQDbQJESUMeFiXZyGbLMvBNrg8E3?=
 =?us-ascii?Q?KP9W/TL1nNyTm2wySYXXRGS49Wg6au/oin1fs4SmOnDlU4DovgIAPq99pxNf?=
 =?us-ascii?Q?FVXANDzpOAu48kq5zcrnG516WxmhSpBHC7QVMMKnA4vn9WekKkpnyoH4J4JO?=
 =?us-ascii?Q?oBigj2rKy0sVjIJojo23WANygrNhrUvDdnRRC5qjdNw5KHeF0lvXDMbRGkTC?=
 =?us-ascii?Q?3YQGlzEqUH+04yw4h1opS7l09aH+usWF3suHc69EymnIB7AE8dK2iTTWznZb?=
 =?us-ascii?Q?SGpVUns1nOlw51B3cPL9H/0WvDQCuC7Z+Yp63xstzcX3hE0LtMgyYCyVI0g5?=
 =?us-ascii?Q?Tynof3vPL/HoWOvRbt3VbIWyvlRmSK63R+nC20u3Oeuss00e39Q1yC4ddXi+?=
 =?us-ascii?Q?AA5V141t6hAOHKecWUmSixr8ZiC0zLP6l5BH5q2drVr/0RDhbse3GyyIIhyO?=
 =?us-ascii?Q?kKHdC2aPsS7Elt4NOLzfblt8bjiS1U8ZXO81uyKyH7jGZOvsYuAGxgwa0ozx?=
 =?us-ascii?Q?o+qK2ElZ8Z5cGDEoMSlXTbkyp+BtFVeb6N4RJuA40ZRNBSoxkVpdmsJ106au?=
 =?us-ascii?Q?W1LuBP83wE4t1xregJECrPGjMNgB8BXBUHDU+atlFfv9Z1ugKt8/1UNa/O4r?=
 =?us-ascii?Q?1IW7kby46aQrn5W+rcanIwKKCPB2E71DWkCosfy0o6Ttu01rVU8PV4vGQGLp?=
 =?us-ascii?Q?VCrU98cMn/HvWtpXuR+qACb/y0OrHPz4XPV/rXYrh5Ulg3vNPpfbQwPowp3V?=
 =?us-ascii?Q?JzYrPuTaE4p6sE3q/Cd59iayQQNhviyq/1YeEfGJXxv4Ag8OWxiZ0RpVzhm2?=
 =?us-ascii?Q?q4S2dtuOJbJ8EGs/7NfCc+hzuTfpfsG2BEBf4D5iISwiN9P5Hwe0WfFEAm+J?=
 =?us-ascii?Q?xj2oRWGsK2QvK7hqx92JHClLMo99zkHwF0Il82+EwpEyPexG+GX+Cc+nP1KQ?=
 =?us-ascii?Q?Vj5yLFo+xpyUIA/RDGlrcW8+VJ5X4dLhHJfGr2Ekqj6HILBuMpNUOrofasSd?=
 =?us-ascii?Q?8ZFfapm/cy5W9VC16zdZJcGE5VtA+W7wjHt6/fYe+Ia7OSdRlhJJtGPGrTxn?=
 =?us-ascii?Q?NirL1eI/tCSYPF4QheTQjwBtH+wpiTCTjnO9Oht38dfG3ywSHieupvHASbao?=
 =?us-ascii?Q?61XmPNbz2Tyudpl/aDQLpd/S5L+BuQueY9RCyd+NEnOyG+yvncujykgUeeJN?=
 =?us-ascii?Q?m88crbTcdg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e45d9a-f045-4f23-31fa-08deddfa9a0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:42:33.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWUxySZFDdiiprfz17c2oEylc4kHF2Sz+S6T5v9BX53R9w+Tjja53SXViF4GN0/2k8YJSsDrWYZicsK4dKkAMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487

On Wed, Jul 08, 2026 at 11:23:56AM -1000, Tejun Heo wrote:
> scx_qmap.c and the shared scx_qmap.h mixed __u64/__u32/__s32 with the bare
> typedefs that scx/common.h provides. Convert the remaining __-prefixed
> integer types to the bare forms for consistency. The struct fields become
> bare u64 (uint64_t), so the stats printfs that fed them to %llu now cast to
> unsigned long long. No functional change.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_qmap.c | 21 +++++++++++----------
>  tools/sched_ext/scx_qmap.h | 34 +++++++++++++++++-----------------
>  2 files changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
> index 67ddd483a4c7..f1eaebcab5dc 100644
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -67,8 +67,8 @@ int main(int argc, char **argv)
>  	struct scx_qmap *skel;
>  	struct bpf_link *link;
>  	struct qmap_arena *qa;
> -	__u32 test_error_cnt = 0;
> -	__u64 ecode;
> +	u32 test_error_cnt = 0;
> +	u64 ecode;
>  	int opt;
>  
>  	libbpf_set_print(libbpf_print_fn);
> @@ -202,15 +202,16 @@ int main(int argc, char **argv)
>  
>  		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq/cid0=%llu/%llu deq=%llu core=%llu enq_ddsp=%llu\n",
>  		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
> -		       qa->nr_reenqueued, qa->nr_reenqueued_cid0,
> -		       qa->nr_dequeued,
> -		       qa->nr_core_sched_execed,
> -		       qa->nr_ddsp_from_enq);
> +		       (unsigned long long)qa->nr_reenqueued,
> +		       (unsigned long long)qa->nr_reenqueued_cid0,
> +		       (unsigned long long)qa->nr_dequeued,
> +		       (unsigned long long)qa->nr_core_sched_execed,
> +		       (unsigned long long)qa->nr_ddsp_from_enq);
>  		printf("         exp_local=%llu exp_remote=%llu exp_timer=%llu exp_lost=%llu\n",
> -		       qa->nr_expedited_local,
> -		       qa->nr_expedited_remote,
> -		       qa->nr_expedited_from_timer,
> -		       qa->nr_expedited_lost);
> +		       (unsigned long long)qa->nr_expedited_local,
> +		       (unsigned long long)qa->nr_expedited_remote,
> +		       (unsigned long long)qa->nr_expedited_from_timer,
> +		       (unsigned long long)qa->nr_expedited_lost);
>  		if (__COMPAT_has_ksym("scx_bpf_cidperf_cur"))
>  			printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
>  			       qa->cpuperf_min,
> diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
> index d15a705d5ac5..808237540f5c 100644
> --- a/tools/sched_ext/scx_qmap.h
> +++ b/tools/sched_ext/scx_qmap.h
> @@ -28,10 +28,10 @@
>  #define SCX_QMAP_MAX_CPUS	1024
>  
>  struct cpu_ctx {
> -	__u64 dsp_idx;		/* dispatch index */
> -	__u64 dsp_cnt;		/* remaining count */
> -	__u32 avg_weight;
> -	__u32 cpuperf_target;
> +	u64 dsp_idx;		/* dispatch index */
> +	u64 dsp_cnt;		/* remaining count */
> +	u32 avg_weight;
> +	u32 cpuperf_target;
>  };
>  
>  /* Opaque to userspace; defined in scx_qmap.bpf.c. */
> @@ -40,25 +40,25 @@ struct task_ctx;
>  struct qmap_fifo {
>  	struct task_ctx __arena *head;
>  	struct task_ctx __arena *tail;
> -	__s32 idx;
> +	s32 idx;
>  };
>  
>  struct qmap_arena {
>  	/* userspace-visible stats */
> -	__u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cid0;
> -	__u64 nr_dequeued, nr_ddsp_from_enq;
> -	__u64 nr_core_sched_execed;
> -	__u64 nr_expedited_local, nr_expedited_remote;
> -	__u64 nr_expedited_lost, nr_expedited_from_timer;
> -	__u64 nr_highpri_queued;
> -	__u32 test_error_cnt;
> -	__u32 cpuperf_min, cpuperf_avg, cpuperf_max;
> -	__u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
> +	u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cid0;
> +	u64 nr_dequeued, nr_ddsp_from_enq;
> +	u64 nr_core_sched_execed;
> +	u64 nr_expedited_local, nr_expedited_remote;
> +	u64 nr_expedited_lost, nr_expedited_from_timer;
> +	u64 nr_highpri_queued;
> +	u32 test_error_cnt;
> +	u32 cpuperf_min, cpuperf_avg, cpuperf_max;
> +	u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
>  
>  	/* kernel-side runtime state */
> -	__u64 sub_sched_cgroup_ids[MAX_SUB_SCHEDS];
> -	__u64 core_sched_head_seqs[5];
> -	__u64 core_sched_tail_seqs[5];
> +	u64 sub_sched_cgroup_ids[MAX_SUB_SCHEDS];
> +	u64 core_sched_head_seqs[5];
> +	u64 core_sched_tail_seqs[5];
>  
>  	struct cpu_ctx cpu_ctxs[SCX_QMAP_MAX_CPUS];
>  
> -- 
> 2.54.0
> 
