Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE91158874
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829715; cv=fail; b=sN2gTAWgmhP2rhblkkiHmYoCYaiPgl8YhCrH5pJ1i4zoHqyCc4KO5mGbBXN8PB0GvU6rq11/SFYGSW3Ta2fVH4nEEfQYnfNU/hhxxot2NaozooBYD3Cpv0U32PRwHgOLa5XMOrSWsrwFJ3iZrMtXB/rMg3rDlIqLe7mUZ3EOXz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829715; c=relaxed/simple;
	bh=DyazX+5XHUbiZTaH6FtAwQEUVx3VlEuFqQUv0iA/U1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sBxOeGjjVGWINqUEnQt3//0sWDvG+6dkDBSMIfA8AzVuGZ2YXDa8HCdAyuxQxqRl/4r8pXtngs5RTJmIHRvdnBEjjmqa4zIewJgbYLwTutpaLn70HmX28nwgxFV4g+9gMxbIsy5BxvfgytNUCaFGa/VkgfZ79BfsO1O1dnLvlGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hjz7Oma5; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hjz7Oma5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj44ZXyBEAEkVRM5LXwFJdy8Q5bl4Wn06i1oQObUaLXrTPc1/XP3E/BbAmPCme+ltz8yeLn3fr7o/tNfl4/AvhZVTDV2hf5CB/SGfQTq+4aO6hc25C6JtWxFvNWXg4PH2T1WH5hF/1DGSQHMzqyaT2OZn03W5glM3wk0vvJvAnY3peXjha97ZNdAzDxS0C48W9mnd6niqxAC+6ivD/Y9UtTGH0UujopV75CHyHp3xNuashsEifY7olDVB3fOEKl+2o7OJquLy/5IbC83iGChjMSLcLqMUKBlI8VMErzaoZs3q+qEAwXeb04cb9dxPY5C+/5yuQ8uiEhpibGQzZYFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDy+MsATGprWM7F0PaK8dXYSetOr+54NJPB7HVV26OY=;
 b=TNpLHaMWRG6keaDVOgcPLV4kPuldYByRbeUBviMr6UeHqP/5iInvmMus3Y3ZiwKfeRKB/4vhjwX+x5xL/KGtSSAWFXJQSfKoBkTCbkuqt90P6A+YYl2h5xFQED18Exp1rIiQhJhWfiHWkrtEQZdvXeXVJo7sN1R6+Jdu9hFkHYV2DpsM3R0m619B3Mgrnkace3Z5AaMej4+NNU2L2jSRZr5AeyUOSYJuCphHkvQP1hq3mCCN2HOHAR0GTWpUwawmrLQNYDb6tlvon1Odb0V9kaIV1XW320ZLV0p2dcfKJUFxWpYD/zphB7HO/ZVABGoaBOjFFv08SoK44iTiN1CAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDy+MsATGprWM7F0PaK8dXYSetOr+54NJPB7HVV26OY=;
 b=hjz7Oma5rz5BaZgzbNPREn8Lr/NzoNUdIxO5fgPDofkpnCi0rybjbLhatZVu03gqAjwnRDl/IwtNNadn5l+FNlmU0pLwIVFIczD+E338C1lfV7F2cHsSCy0z7OdRuuTQRhgj6iG0l9jLvAh2TzZwaFEjy3lRSBDryvT8YpPvk8cdyCS8o7upddvFo4tMF+PhmftE/UUpzRFRJGy3xTR1MMTzPHSkPMMCQBl/b0n3fH/ROIff9+qKY1SFN0h0TZ2ixjRN4KnLrSkLpP88UUA5C4P9PJNGidSUTPRj1PUIY9iG1WLWJx1nzmmGP7kcdUPInl0chRipbl6g7UKMrDoNCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 09:35:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 09:35:04 +0000
Date: Tue, 7 Oct 2025 11:34:56 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/4] sched_ext: Add scx_bpf_task_set_slice() and
 scx_bpf_task_set_dsq_vtime()
Message-ID: <aOTewKyj8-0ub-23@gpd4>
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-3-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007015147.2496026-3-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0110.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b6f703-a01f-4e81-2989-08de0584cbcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YrdFUd8+6Em/bsDR8aEqG7QYw06XZHHNjqwAu67NuKin3pNNsLVPbs9SGyId?=
 =?us-ascii?Q?balgkpVCt5qdnxZtvQ28EfcR9D0Z/07lEsDemEZw39svsLhbyqXur55L6WI7?=
 =?us-ascii?Q?nbxkYexRwhraHTa0RdYPzehWjXA980r0kGJU4ISoUPBLPh7Brdkhyl5ndmV/?=
 =?us-ascii?Q?csdt7L12zlL7OACufQTTmS2z/3owy0QlzdTdH3iHIvTvxFPjFDYaFxdwLxyR?=
 =?us-ascii?Q?TbRBnvQlLH634Uz13fYhNv0614Bh6wD9dNMikLfZrbrAieaqZ9hhT3lIzAz+?=
 =?us-ascii?Q?cYAqKSfBYd/LDt7zhCfSd+yjX70m9xaNXbSZfDYfUmLb92AaV6QjK8B1I9nm?=
 =?us-ascii?Q?v5AWK3LzmZwdWlUIGhlUOHYHWgVras3ZJx0fUzlcZg/Mj5P/I+z197NfStox?=
 =?us-ascii?Q?yeJUiqntc9FzR8FbWNQY24jOcwK6mlN8zcdzPM4JPvxutsoK5q7niJD55wPN?=
 =?us-ascii?Q?WaqGxIO3lWTf2GiPbhBmgAXoHuQI4ZNUpSHI1NubN8RVTUi+J+MUD5cfktcj?=
 =?us-ascii?Q?pRFCYKVRLbfYbHM0vD9bX/UQCcGlpI2be6KMlNsxvT1PNvBJYc/Iq1qunT2S?=
 =?us-ascii?Q?9FcAeg6j3bhLTv9MvyOIzLWxolVnxn+NNb5nesOOe81y5rs7BFIQLuoPG1/9?=
 =?us-ascii?Q?PD1Z8aLD/TYnx8QmuWWZ9bjnXes09XNyUb0//R2AtgWlhnMrwv2w7C7XFTK8?=
 =?us-ascii?Q?E8JoxwdawBQS/iAPCyqgpZ/hOBUABFAGzJkPoskexkKHoKhVIfgMDbjoGC/e?=
 =?us-ascii?Q?r6YRiuO4sTuUIYayUsaNuDismmoovT3WcsvMkHCtKZAuPgSNUpYrDvKqb4Qg?=
 =?us-ascii?Q?en9RcEaDQ52y5iWPx+DV+beeAerOWVtGSi+JrSiFNhPKwOEhZUuvlCwDpqs/?=
 =?us-ascii?Q?JP6NSvo3QgxnRjK7O9mHa2+1n9T3LLuh2AjT1PlT4SPRu8D8+XcPd5klKnHo?=
 =?us-ascii?Q?i9OwCohvXSEHLEJnQfePx7kyPOh+bKFGlds8p9NjucwgDgHK4UqFYJpBHkbL?=
 =?us-ascii?Q?0e+ulgRRFr5fxGRe8TjRn7kIaJOchsrHA2Ffujh69r4gIDEORZJmLw6XeEbT?=
 =?us-ascii?Q?hGfH/fWhK6UTit3Dy81PYfnPaRX3MoiQiQQs/QgCkkygTnd12UOp+Txa3h+e?=
 =?us-ascii?Q?LrXkzrEp/d/XHBDnT7kQIKJlpj2aPFVCOJdWYq9BngOI0/q+CZOsZXegyN2V?=
 =?us-ascii?Q?cg0Wuc/joue8BYGAMz+Tz0D6S5uXf766LKj96f4AEeyHEkwj0IWU5K0B/zBM?=
 =?us-ascii?Q?YLo+LS9WWLVgvr5irWNQtxQ5qztqURX/BhwlExfyPwntt/BLHr4p/kVK87Ew?=
 =?us-ascii?Q?Dm7uEieAw+x04W9GkBjgwMpngJy2nKswQxjWRHAr29ECYJTOOF9fpKQYqcwo?=
 =?us-ascii?Q?MOVwnz3ccysafBsO0cpYjSe2ZsebflcNdYYYQaiWglipo8UrRv6NCzcrHt9T?=
 =?us-ascii?Q?1QVPT1WKFh1T+GHaJ7y35AzUAtkZRs6b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k8jjPhV7JTuidrjyCb4Z4YlmUtX12P/xV4BDo1XZCzVjIiqxPfJyBU+TfQ9f?=
 =?us-ascii?Q?qCqdBfrdhuB4KpbUE8tYCsa6ANY0T50NJllhUMDncvWQnxI13lo0r9MgKKdl?=
 =?us-ascii?Q?NeKXLbH7uuC5CLj0RyTrbEjoHclJKhcqkO+JJjDuXgltORqm68CYU53MCrZY?=
 =?us-ascii?Q?kykawNtQeNsdx+B8Dz2MGW9fRRWiiHKVsIOWUfDYo/7S+LqsfzdEBAg3aFeT?=
 =?us-ascii?Q?r8oudmWakMWGig0Z/n7uvbcIfwOR7zrMs9lh75QgvihRA/xFiy2n8+/g1wZq?=
 =?us-ascii?Q?7GNWCDlPcVh5MIV+yju4VDGXDNgyD/TUA2OKraS/+ng7O2FioYNI9kLZTLJo?=
 =?us-ascii?Q?+U03Zu5UJvp9MlLrOpOmrLLA2unYODpzcuKo+xGjkSsBQLyjnjWL6SBDXviU?=
 =?us-ascii?Q?YLihsZTVxAPn2Lx+SJdE5iay/IeDuwRYn9F9icWFxZlbT0h/gWw5s9g0Lw+m?=
 =?us-ascii?Q?6Yz2PxfwrKpSr0siJdEmjShveyWeFUZHdzvjtPDCJNCl3Kniwq4cK496yI9L?=
 =?us-ascii?Q?A42jEMc8/iaaD/nAiAcdRr1Maj0+/jwzK4mSH8zonRuz4fIBWAlcU30OXA27?=
 =?us-ascii?Q?PbEFUdT7x60ClgN8U11NOLB63nHJGsNWCEbDnlicAK23o/vVdJIzYb/HrQsm?=
 =?us-ascii?Q?junvMkPVG42+iu8/rmIi2JHpTlwN/TOn3IVHCNH4qk8mOU/fx5C7fWvwNjk5?=
 =?us-ascii?Q?undtauZzMKfbgI4c/VAHSWKy7Go3VYsj0Gfvw3qTknbTjuPsV5/5gZguLBrM?=
 =?us-ascii?Q?qp2IooH7/HG0PB2wCVP2qkS07sYCUQNZlMbSQbi20umdhmJ8OhiZ5pbzJQA6?=
 =?us-ascii?Q?Jhv6XNvb9gTzT2JG1MOM/sm1JMHVbhP6BYV9UACq/yeQk8R2OhXSjPqaIsG3?=
 =?us-ascii?Q?OcqYxL0T7DrLnkf1GbYVT7+4BhzxXSny+ERz89IvaFAUoNhE2gkGKn2BlxPn?=
 =?us-ascii?Q?T13V/V4yIG0XxwQqsobZzef5ockb6CaBn3mKkdVmorXBeXw6GuuYXKvfX/0O?=
 =?us-ascii?Q?h9VXgyTfB64Xre1HD1V2m9L3LOD5wFs/CiTPOucUhdF5WbsmMotvK7328080?=
 =?us-ascii?Q?7C+KvrSFnXXiwGhnmRyZcbl2cXy/j0gDV7qfp26NMiAgn0VGKrv7KEZB4ecW?=
 =?us-ascii?Q?YXovKdsCo/7NsL7WReK0ouCRQ4DeuZz7j5tJfm31rog4AqPztiQW+v9j+Qzm?=
 =?us-ascii?Q?M1owB5cAuWRdbfl70yIUxYE+JNdviUp2B8rpkNlkIt2CHX/C2oChVOJ3DB8o?=
 =?us-ascii?Q?iWMGVkeHPwtIaTBYlNSEIpRhEAqJIDo35ZySmVUrix+YzH/ymVhu08C02rie?=
 =?us-ascii?Q?2FCvOsp5d1ZwKJKNqGpcN2PrW+GhQUS+X2Uk85IKcyHaFqg8luZvSkdisMZT?=
 =?us-ascii?Q?f9JfdDkMZ9sZkHgVvXbKzLZqrAEpyhZcERl29XVjacxNmSBRL24F/+U9nYv4?=
 =?us-ascii?Q?p57TLdouf2SGathlIAinRI/DqUmzVlw6W/QkXRyoIUfdMbbpj4zjYfoRBpBL?=
 =?us-ascii?Q?3/ubG7bX07AeVAvaGJUSrt8IcrMTZ53xM/dh64W0ruPGrNs5SosmzNrGl73j?=
 =?us-ascii?Q?CK9gN5bxlDNmqyvIN6y0mWhVqfaaLp7/HvWvop2P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b6f703-a01f-4e81-2989-08de0584cbcf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 09:35:04.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKKQ2B2P3ZCzo8CHBr/W3q14RpfXNlMecoNUMAY6z+B/olBOvJx0iHJmIh6VNVzT+fd79Kh37tj8Na1EPdx7Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

Hi Tejun,

On Mon, Oct 06, 2025 at 03:51:45PM -1000, Tejun Heo wrote:
> With the planned hierarchical scheduler support, sub-schedulers will need to
> be verified for authority before being allowed to modify task->scx.slice and
> task->scx.dsq_vtime. Add scx_bpf_task_set_slice() and
> scx_bpf_task_set_dsq_vtime() which will perform the necessary permission
> checks.
> 
> Root schedulers can still directly write to these fields, so this doesn't
> affect existing schedulers.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

Maybe provide __COMPAT_scx_bpf_task_set_slice() and
__COMPAT_scx_bpf_task_set_dsq_vtime(), but we can do this later.

Thanks,
-Andrea

>  kernel/sched/ext.c                       | 30 ++++++++++++++++++++++++
>  tools/sched_ext/include/scx/common.bpf.h |  2 ++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index fc353b8d69f7..6d76efaaa9b2 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5833,6 +5833,34 @@ static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
>  
>  __bpf_kfunc_start_defs();
>  
> +/**
> + * scx_bpf_task_set_slice - Set task's time slice
> + * @p: task of interest
> + * @slice: time slice to set in nsecs
> + *
> + * Set @p's time slice to @slice. Returns %true on success, %false if the
> + * calling scheduler doesn't have authority over @p.
> + */
> +__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
> +{
> +	p->scx.slice = slice;
> +	return true;
> +}
> +
> +/**
> + * scx_bpf_task_set_dsq_vtime - Set task's virtual time for DSQ ordering
> + * @p: task of interest
> + * @vtime: virtual time to set
> + *
> + * Set @p's virtual time to @vtime. Returns %true on success, %false if the
> + * calling scheduler doesn't have authority over @p.
> + */
> +__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
> +{
> +	p->scx.dsq_vtime = vtime;
> +	return true;
> +}
> +
>  static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
>  {
>  	struct rq *this_rq;
> @@ -6638,6 +6666,8 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(scx_kfunc_ids_any)
> +BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_RCU);
> +BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 06e2551033cb..505231b7b7ae 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -102,6 +102,8 @@ s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags
>  s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
>  bool scx_bpf_task_running(const struct task_struct *p) __ksym;
>  s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
> +bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice) __ksym __weak;
> +bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime) __ksym __weak;
>  struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
>  struct rq *scx_bpf_locked_rq(void) __ksym;
>  struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
> -- 
> 2.51.0
> 
