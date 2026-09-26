Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA290353A7E
	for <sched-ext@lists.linux.dev>; Sat, 26 Sep 2026 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790451773; cv=fail; b=dIis8RA4qipIj0rAdUq/zNRGvfff2Aza/72d9XWpOVQuq4dOYPA4kF1igGF6p4IlWjz9LVQsypPe2rg8RbYFBHKTRjFl7q3WcVx9mS0duKKcqXOLXfaotMkUXaAExao9vk2URlZ0ZwwCjuruF2BrFCKMMcfgSDQxqWYoOL2P6Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790451773; c=relaxed/simple;
	bh=hglsbOT9bVjHBdGLszhXes6jZeeFeFWbChvShibaeRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Py1U/J1hVep75dkX7nn1cUTK5qh13ghDdZo1Oz6SNwHuschxrfattY3Sg7ncA/R8dAnuG45SKFh6+3sXQENudV1mT4rWv2wpLb9YZ5I3Fnw3fB1M8GbpqFrok3FUu7A0atg/hiEjeFO6cPI7QMZLjCG9/93PVLIAdK3+sFY4aTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X7H4fCrK; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X7H4fCrK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAZhxI6dHOSP42xjMK+OELK27Ruh5mLrqC/Uevd9T3xpe2KLT4PywUTvCeivjzn8i4RlY7YFDaQcSlOdvZgeJpQc1wus1r6BzlShGNtGsGv2u8kibork83fRbPq9dL1VrQIXG4/0PZoMGTJNFnFIRSGAQUVQPPBDQUQLqaCFlFDH6ftu5/43/i7GmzrixgnFbmzjdlLeHXyc/frLHZnlw/NLIh0fYbub4OtP1i2tjOArtbiMUsOvIqCdTg+d7WCjHVAI8Xh6znCB8Sh8zV+fDcvVhcyY1jddMV4xKZRrOyS2yUrLBLkxnaBTzHxmxA0wDKeefpxu9hrf0Y/plEdgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lGiUpfixokXx6MyQcjcWV/LEG0+bUCkQLYgIHbKXSk=;
 b=w2SUv8bgqs6Cqje21BwqWP2O7ZmDPkO+RSktZGyZfYm+fzFA2R2TOGMP9wKT11zDP3JoNc1sMSH1qdHbZHetLbiX1fZJntnQ+StV1sfZx9Kmt9FkmV6V0KTbDc6cxzKUv1UC9DnjYH11FY0IvmbGctnkqo0dK2dofe1okI5BIbnZ/+eVKdMbctTh319fMq2v9gFcZmhBZ+ZHi43t/znkb2vIIE3pjldAacbZo/dh+SryAjMnk+nQCgCkPNKTb+r6ChC1irILUF6uwNFxQVJptwVAKwg3PKU9o9DtStYGSEEJLG4qGfZC83f1ejU1nnmIa6oH86sAK4ozqinEQCC83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lGiUpfixokXx6MyQcjcWV/LEG0+bUCkQLYgIHbKXSk=;
 b=X7H4fCrK0/Icj78R6cbSc7dBmgGU/sNOsTJNL1e2u0+VoykiDwqO+qVosKx5Xzq0/+8pCwPgixnxTI5/ZcmAybDfqa1E6b+zzCYtCUxflhyoMSH8leY3U+4rkL+aJk7YDJG04H+JKVjFG6WLq7oBbNzITrHubQb3zaq6JzL6E5VliaXYvKAcn/MjiNV+KEbTPBz7UjB2/8LNuYu2pzupGoi2KkyKAaE/0GnJKbOJNPU5duO16w7M6vLP2JSBg+YfdFvWPaQ4l+GuAfNT/bEwC3C0mnGkGy8sHxE5Rok/XzbgSN6na50s1C82tiYnKZaUSnHzAR3QzkeKP/9j/DM4sg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 19:42:45 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 19:42:45 +0000
Date: Sat, 26 Sep 2026 21:42:34 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Add a size argument
 to scx_bpf_cid_topo() so struct scx_cid_topo can grow
Message-ID: <arggKqtys5jxn47h@gpd4>
References: <fa6479d36b528573565ca22914451317@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6479d36b528573565ca22914451317@kernel.org>
X-ClientProxiedBy: MI3PEPF00007536.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4c8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 1824684e-e7ce-4b4c-a0d7-08df1c06560a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|5023799004|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	AoJNrzTbgAbmSNCsEwbwNuFYAwdfIXWnsDrKRC7em/p51+xMfnWCGfMbp328OeBYHmthwsRME/JfQDvlsNX1aP67p8ZaEDoHQmI1nEbx3WWnMGxJdG3oo96xo7D9Af5/dDxGaQpsrW6JrNktvfyvqElr7h/J07AE3at6UNgD/nQo/NxtfVBoxoqV+ZbNT4Vz7qEj0sRfL5OvsANrfwAWC9JHWPiuOYIHMJtmXJtKZjqB0XFECO5tE14b9bFDMH4Qo5/wZl/NW/RIOLED5CE5HZp9lnS6Jcwk7pIq3D4W+OwxwIw73jjjmUrZKa38vIpH2QZxf4JD3pJc09w25DiQdMwMcF/ZS81orYWgV5bz1s3jMQXUu/A7I8Iv1/oLJWAM6dVSymuSE/GunqglrjkGk5GzkR/50pYJcc1+0PZMA02MF3re6hwWKUpDQ7GUt3f4aqy09rtn+IC2LPT+aKmgfiqNqS9L715LWV902GKV/H23XuEamyy8x7HMJvTmiGTH/6E8U9lfNy0/Fu5PreH71zo7S0UP/zfVGpVkWmbCH4XYQ/04ZTAqWkLiPG4fABg8XZ4YhV+F2UqUA1Cy27lneqTlNnnJxoVEHPzZ+4cdeJNFSvS4mM5TvgcXDzU+8s8geDl28vkF69tW9OhnceCaB06A4I0y7q2wsk8GAHgDHyI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V9GLVmVg+q4cKNROQnWU56KQhTNri9He+OwVFQoZQb64hIZ0q25YDwfzmUjo?=
 =?us-ascii?Q?lnCVXA1rxvy07q1CZN0f965Bd3mBDy/nvzAh6NX02LL93Lki8KzWX3gCQfdd?=
 =?us-ascii?Q?8L99TaRJ8OAWGtBBmHGFfRu6SM9RMy7s+p8LrCLz2QZdzi8GnG9YQ1VP2tb4?=
 =?us-ascii?Q?It9CZaw6zd2vBybqRl38DCpMCrfk0ugUEuJJwF8PgNNiZdf6d9vU8lMlHRjD?=
 =?us-ascii?Q?s2H9OzVZlnJ/uZhf+Eflv2n6FjwRfq45A3w1QovL5WwbkWR43/sYeDbqchr9?=
 =?us-ascii?Q?oza3pnCKTmrJoDqawDdw6ZHzxCXaLxd1+R7q1pdI4vg/Ek0W05aGwcmI58pU?=
 =?us-ascii?Q?CHWiexMrCi1P3lfOFndyNIasy68Tj68gP8UCWzMilE3uBfjEFSFYjzx3FR1H?=
 =?us-ascii?Q?PGOH1lbJ+cGrijGZTIZoDoQo6mCDUYERyHdp/HmEzuwv21+bl84V9uQA3yuV?=
 =?us-ascii?Q?vS166/nI/rpF03UkjdCelrfSTK7kJ92OaQE1UMKKA5KHueQMHM7nRygLU1/l?=
 =?us-ascii?Q?xwj7khWDhV6wR4g7tx4AOkh0T7JxGO60u8GN1eg+/uxJD3sWo5W763GOw+5G?=
 =?us-ascii?Q?R1BQhVfa+hxl4FM4QHTEZUrGxM/07yyunFxcvhn1OxipSaG0dI4Ek7dSnldW?=
 =?us-ascii?Q?Wic0oBltEz+prkHJIwGNJdfcAKdC2msU9F4y0hL9rike/d7HdFYHpNY073eb?=
 =?us-ascii?Q?w+zgBYLIe6yJzAoWC7b2HzMWKNOcRQxA9mqN/pkEAt2jnuRAVt6qV+RrSdK7?=
 =?us-ascii?Q?AVh1Ys70bJIRMOiaVXuVHyDABqSaY/NY0WFetWzM+zVwvJxrSqagbLt03pYR?=
 =?us-ascii?Q?GZsY5jorU0siKdx2c63WA9isSamlUjeJGC1UjJ4pC0wW1x2O37Tp3E8RskWS?=
 =?us-ascii?Q?7lsvOThHTsoS0bd5BLb6k7/B6W8IPo2zsZ0AggesW1O8FgLc+bWGXJvcWZ9T?=
 =?us-ascii?Q?EexWKCU4RQghHngdtJFJAeG8wDpJ0zeeXo6Tc+panAjRmLP6Wy0Lq8VkpYnS?=
 =?us-ascii?Q?qO6YD2vA29UOFLoE0YAwRawDqTyh6MMFvMFHDXuWMByaianb1mv/LTOe2iVW?=
 =?us-ascii?Q?dDp4FdEIRJv7MUDJkFapQwOdsnMiJObawHI3ZCkZ+w0j0NhuwL6P4cWWblCW?=
 =?us-ascii?Q?ScwY2I5GraxOKY8CvfU65ZXOPwExsZ0+OKicV9QgaBH1bOaaFbBnEOX5CpLK?=
 =?us-ascii?Q?OvM1FsHEHz1FHQPPlllKCo6OP2EpRyMoBtjkaCIvJxctzfvcCNlCxJKUmplG?=
 =?us-ascii?Q?ChPNjsQeDUkmFK3bPL4Pf5qvDnQzL8EriFcx75gMuP0pil5X7mz2AHrWkRJs?=
 =?us-ascii?Q?TU4qdKHUgaqrkRIy2TQbpOghcX+EsFarSEP/Vxqt1nCxOwI6/rpsV/pGOZEf?=
 =?us-ascii?Q?f5oSYxHzzGZK1IVqbF2ZF2PWqi61/PtygPKm2laSg5rS8wjWZENVuIW4wvHY?=
 =?us-ascii?Q?1gAlgiyzmljV7a6xe2+/vZm6LOvAP+fSISHykxgzNJMkm6aFh8cLYPuXvdR7?=
 =?us-ascii?Q?nTM1tknChFBmljUmzKMZF1a/2xWm9ZVI0Ln8N/BvD55gtL9Bql+cB9zqgAqi?=
 =?us-ascii?Q?iu4g0R6cabG39fUT4iOVJabsrU6EmCrh+Hio+y9VjmullNR9Afut20y7c6xp?=
 =?us-ascii?Q?QwN7B4OS7WEd4zHcX8uT7hDHlL3ituXgSupqFM80+csIcLhYH4xnpuxv3pSg?=
 =?us-ascii?Q?SRv166OdhnTjT7zusMhsYIPi2MxXQeVpRekFfRrQrXIWjm6Uu4ZjfbhUwAE+?=
 =?us-ascii?Q?GRgpeXvPOw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1824684e-e7ce-4b4c-a0d7-08df1c06560a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 19:42:45.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vD41LCQAxtYZ5/3KFf7BPWTooMvrLZwb+mjEsBL/b43fzn1lG2YUv4orWmpJKUTgxcF14yPgfl8+/74bb1vtxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

Hi Tejun,

On Sat, Sep 26, 2026 at 09:23:02AM -1000, Tejun Heo wrote:
> scx_bpf_cid_topo() copies struct scx_cid_topo into a buffer the BPF program
> sized from its own vmlinux.h while the verifier sizes the write from the
> running kernel's BTF. The struct may grow and each growth then breaks every
> scheduler built against the older layout, rejected at load or written past
> its buffer. This is the usual hole for a struct handed to BPF, closed
> elsewhere with a size argument, and it was missed here.
> 
> Take the buffer size, copy the smaller of it and the kernel's struct and set
> the rest to -1. Accesses to the copy are CO-RE relocated, so the struct can
> grow by appending fields, which its comment now states. The kfunc changes in
> place: the cid interface is still being finalized and no released scheduler
> uses the current form.
> 
> Fixes: e9b55af47edf ("sched_ext: Add topological CPU IDs (cids)")
> Cc: stable@vger.kernel.org # v7.2+
> Signed-off-by: Tejun Heo <tj@kernel.org>

Makes sense to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/cid.c                   |   26 ++++++++++++++++----------
>  kernel/sched/ext/types.h                 |    4 ++++
>  tools/sched_ext/include/scx/common.bpf.h |    2 +-
>  3 files changed, 21 insertions(+), 11 deletions(-)
> 
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
> @@ -912,30 +912,36 @@ bool scx_cmask_empty(const struct scx_cm
>  /**
>   * scx_bpf_cid_topo - Copy out per-cid topology info
>   * @cid: cid to look up
> - * @out__uninit: where to copy the topology info; fully written by this call
> + * @out: where to copy the topology info
> + * @out__sz: size of @out, the program's sizeof(struct scx_cid_topo)
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
>   *
> - * Fill @out__uninit with the topology info for @cid. Trigger scx_error() if
> - * @cid is out of range. If @cid is valid but in the no-topo section, all fields
> - * are set to -1. All fields are also set to -1 when no cid tables have been
> - * published yet, which a program may observe while racing the root enable.
> + * Fill @out with the topology info for @cid. Trigger scx_error() if @cid is out
> + * of range. If @cid is valid but in the no-topo section, all fields are set to
> + * -1. All fields are also set to -1 when no cid tables have been published yet,
> + * which a program may observe while racing the root enable.
> + *
> + * The program's struct may be older or newer than the kernel's. The smaller of
> + * @out__sz and the kernel's size is copied and the rest of @out is set to -1.
>   */
> -__bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out__uninit,
> +__bpf_kfunc void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out, size_t out__sz,
>  				  const struct bpf_prog_aux *aux)
>  {
> +	size_t len = min(out__sz, sizeof(*out));
>  	struct scx_cid_topo *topo;
>  	struct scx_sched *sch;
>  
> +	/* the error cases and fields the kernel lacks read as -1 */
> +	memset(out, 0xff, out__sz);
> +
>  	guard(rcu)();
>  
>  	sch = scx_prog_sched(aux);
>  	topo = rcu_dereference(scx_cid_topo);
> -	if (unlikely(!sch) || !cid_valid(sch, cid) || unlikely(!topo)) {
> -		*out__uninit = SCX_CID_TOPO_NEG;
> +	if (unlikely(!sch) || !cid_valid(sch, cid) || unlikely(!topo))
>  		return;
> -	}
>  
> -	*out__uninit = topo[cid];
> +	memcpy(out, &topo[cid], len);
>  }
>  
>  __bpf_kfunc_end_defs();
> --- a/kernel/sched/ext/types.h
> +++ b/kernel/sched/ext/types.h
> @@ -70,6 +70,10 @@ enum scx_consts {
>   * smaller shards if the LLC exceeds the target size. No-topo cids are packed
>   * into their own max-sized shards.
>   *
> + * New fields are appended, never inserted: scx_bpf_cid_topo() copies this
> + * struct out sized by the program's own layout, and an older program's copy
> + * must stay a prefix of the kernel's.
> + *
>   * @core_cid: first cid of this cid's core (smt-sibling group)
>   * @core_idx: global index of that core, in [0, nr_cores_at_init)
>   * @llc_cid: first cid of this cid's LLC
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -106,7 +106,7 @@ u64 scx_bpf_now(void) __ksym __weak;
>  void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
>  s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
>  s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
> -void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out) __ksym __weak;
> +void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out, size_t out__sz) __ksym __weak;
>  void scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
>  s32 scx_bpf_task_cid(const struct task_struct *p) __ksym __weak;
>  s32 scx_bpf_this_cid(void) __ksym __weak;
