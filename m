Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFCC2F261C
	for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244720; cv=fail; b=jwXOiU2dJTXttFqNtCYtilJtgWA4za6JilIb6kqmojLOYMJA/zluwwNzLsGPQ22PtYYANT2AUtfb561h2s6oIs91JqY3n9/v6CTzqCi52zxXmSPwC1XmsUdmqg+sSiTzlbZuG7C9ep86ME8ooauzi/CZ8dnLTyskOu+oSkvSdiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244720; c=relaxed/simple;
	bh=EfSWq+VPgXv6j2YxEDMG8fcH8IbSjnYWtlK6Zuh1SYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M87l8zb768/lPVcUKQyL6XMg+MIVYg33UtjULFY3PVAYkAFA1M8ErvjKQEyZBxLdZBeZDA0D/4Vz4W+KnEyPPZUwjJAqh/czLdLXXQ/WVMluduc8TA4zgv8+6nzByr1BH07hMuoRpRQJVZmcBGEWSLnjeYkaQAkI4rlRpruzL5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eJMIouwp; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eJMIouwp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhmL3xE8Fm8Mn0HWPl4uwdvvNMwBE7584xm5/XUImFgazfg8FLvHcffcXCETpmQoYgAdD+RryW5c0XAefOfGiO4owyZ/3q7mk6wmgSprdK02Mt0whRwe+w9YXE7Gi7HzwowG6XofChRUQ5QiugWqnwAKGRqR7JSO8Rd0PF/WSWgIM9DL1nG8CHDMV5CysGI1V9FkYCBJEBBEGeiu4jp7x4LcVlEKXogP0NWSSQoZ3UJB+qiaFuENpCn5Qs/UXIu6H0/9MHirR98VYRwlgYpTY7p4fXGEvQlTKfXjWQl1TANKXgb6F7ZqZ41Zk0Q17eoR+vjLAfI+w/CPoj2Sd3E6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX6W38MHhRKM/lRKSTQf8L56KAsi9LIyI2CwIjluoJg=;
 b=R14JE8zppyLZyRlia0XUA4wzMlIHI10QkJ2205MCF9hYgmMKo9DNHmTyLR7PWOFmbPJjjAviOMkJuHI1agO5NQ85cX9iJh7+ewuGfGrzW2aeiGTSb4iq0okuLJe7w1dFWIQHMB8NynoijAC1hppxAO/qBtQkzVz6y5jXLiZfenkVvOYO+W2vcpAfuZIVHaDND956AUlgl3YcT4fMJNJosAep8sqvMLruPnhS5cFgeR5ihMn3t1OG6JKmNQAs41ktViFp5W77hHlPU7e9NQSkz3lfCYIr9kMkBUBWeDzQ1gqv/yOPF9V2ZH8luoOmC6t1B8h34Z6b3t/DosSLHCPAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX6W38MHhRKM/lRKSTQf8L56KAsi9LIyI2CwIjluoJg=;
 b=eJMIouwpCkYYMiMFsUBvkCCZUajIShlqIFbPhf6vmBLYl5Vq0x35zDevltXQYLO7+Uw0zKGVil5/XFC1qCq1QnTIMId95WGtm0d/3LpcaWEMSbFaJV969LA+MAswOSPNdEPPkP1sesYcRtvcEDs7kA1RYdsJ1so1Ej2zlGIXY44svEAW+iYB07bnGXS+n+x/hekkBkLylzUHG+9Sv8rxO3Rnoax8kLOIOle3DGdd4UmMgzZyvaHvJlqoQBvGqR9fK/r1emYAjODk4rivlGPVbndDhjV8m1GZFodHBRWHBa0mVAYmGuiwb5ZU1ZjGZ1hGyhUlAocL0Qj9cZc/e9ybmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 15:58:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Wed, 11 Mar 2026
 15:58:35 +0000
Date: Wed, 11 Mar 2026 16:58:27 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] sched_ext: Add scx_bpf_task_add_dsq_vtime()
Message-ID: <abGRI8SRYT3BKILf@gpd4>
References: <20260311153957.699608-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311153957.699608-1-yphbchou0911@gmail.com>
X-ClientProxiedBy: ZR0P278CA0166.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2830e4-a4de-4632-322b-08de7f870d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sn2OrOQHRTuW8qEZNd9H8+A44c6UqqHcoKz9F6Ugk3QIpM1AS/TrZAvrIOFYsgxaW8nPrvuttIDLok/7DXpPtZVGcikvGNHuB4ebKmhJ4F2V7v1lZpd+YVwsaVPkcNf9QQ8CLubJ4Dh4070gRRecn71KCMos0wxdPvWL/Jy/G+RBW8ULPfXzlH6xC0guY1K+v7nhey9sewfGj5T5mzsZl1PfDNTv6/zaVloGUoMRsrSVEhRRmlOINl7UAkUfu9Lap9jdfcS+ROt+et5XuLzOeRBuR/t/ME7WgCy++kTpwUnh2KcOPiJNRRIJ10yI8jCuCulEaamdUi+FlVmNChnbRfdVpmSR/AQBcU6CYN167sl1URqSeY71d2/6SjbP6AraWeP5RgpKenbQBbjHbGJdMhLqcPgHurcGn8L+oitB0kKHSD0D6zCOoNUwADGdqV69427rNudZErwSMaxq3QXzXTX9NUBdtZHtcZluKdgPBXwvH3XZYfbbCfPFuWxkdGMQj8022laakaA3BmYpPXhThc5KHvgYU4B6HHpPMPZ1mM0hqfNMiO5F74wxKOfN4hUQEcC8mleXDm4rBpGZqU46VFYFj5vTok5oRgyVdu9JQcu6PrvrapXEJPhJNTe79+WxVERPnkoF7puzE37869Mef7i/rBVCYvBTMqpntL2L4VdEGROgfCYVAzk7g7PfFgXuPEZgjPeWTawcuMdzIUPub4L+Her/2xCPEMft18bCG4BF8IHPRqM1LJq+qslykwIW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Fk2TZ/5n2++WaQ1MNYpojqSOkWs+VukG7tRa49XDwc0Vx9WS8TOvqJe5HnW?=
 =?us-ascii?Q?iF0s2rqaQNt4iGqbphxrwFpCK0GzcF/jb2+Cmff2E7sNeLeqSTij0ztb9cvy?=
 =?us-ascii?Q?P80CIQVAheGEEvMbaPlSu7L41o4gzH77BsvspxrIPVLBKphvo+gLW9gcA8oy?=
 =?us-ascii?Q?wvSYiHtFuft7F40/eCmDX1qdX6wqUSs0n55OJdCNHBnNy8ajDsFfMf/LlAss?=
 =?us-ascii?Q?trMi5fQzJMvTCbIPz+0Llyu6j7XP0AaHOyH8Pq5Q3QSMQR6qAWhn213p5c2w?=
 =?us-ascii?Q?NFCdb0zaseA6/RjZ3vbtEcGUZa00BP498qbwFpNWuT8XyGxd8kL/LuAzizjC?=
 =?us-ascii?Q?EPqOkfebdsXtu0d/uBCluO+jd5HeSwpNdjsanQNE5M91K/7RZT4U0ptkcCEC?=
 =?us-ascii?Q?OHliBYB5Yjku+wPXFZ8nPBNeJ47VobswD4DmSCq2Spa0cdFnBetkLoxUfa1b?=
 =?us-ascii?Q?2p3u94OLautkTHv2EXEn0yeNCOElX/OCrwxdx/nwZfZU0p/dfuSZuRixRjoX?=
 =?us-ascii?Q?z9J5oFge0E8mciMnYUHwR2wbDoVN4tDmC4EscrnuedH/PQqQScWVqiviXevX?=
 =?us-ascii?Q?Ze44eMLijIHtNkx3aTnC7OcQF1DlOoDQNDyCLTpQKAyFrdyi6nnT5lbvVCxx?=
 =?us-ascii?Q?ASIcbBjPwk4oFVx6uvjmrToSFKpzV2gMxCj21djgZ87yWvpBfkOWP+E/6vtO?=
 =?us-ascii?Q?doSwd1nUsiiW0tUbLGq1b1S3GI2ZylK4ejEXXDEtL6Iya0UC4mo1VeZciRKC?=
 =?us-ascii?Q?3yYKwyNfdbnn4S/ygefncv4xYJNzmDrokoCxRUDRgDc/A6KO50No0X8T0kbB?=
 =?us-ascii?Q?OYyCIbtzaNj6pnf7R/i9mgSH8EY6/7qLOEtb/1XyiBO055Yml+JaUuhcBhRI?=
 =?us-ascii?Q?JcrHUlPEw3ap12DdsjPH0hmlctAOwI4o/QXHkSucin4S89mS9N8yO+K6X4Xi?=
 =?us-ascii?Q?idljvlYJ8JAD0amwLbSSVjJI/voDYxUe4I8coBZuuakq2FXaeZ1MKzDRm64L?=
 =?us-ascii?Q?RkQESMlbs0BRKIogDGkG+FfBm0fwofOKdvBe6ppScyqFQ2vaVYdytLMW+OVE?=
 =?us-ascii?Q?qJBlOU6Pz6kg061jXt99hEFLtpqCEBX4QYMflFM8UcvUsnTvlA/K2+taT0eD?=
 =?us-ascii?Q?77IBD5PSZQIau5ASVSr4ARGUX2W8fCV3DA6Wed8PNmdDz1boS0GBatJEYUn2?=
 =?us-ascii?Q?8t/2EJESs5lb2E1cRT41u0w/z8o/AKY9XyiosAFrwUf+TKdlsBVxH/fyxSC8?=
 =?us-ascii?Q?GI6dKF6pMky9RnJ7Cqp7eliuFp8zyGsQseRJVJfvM88kLSJA1Tb36R1GD1vg?=
 =?us-ascii?Q?BWLU/ksolhbCy+bhsKJ20WyxoHrh0k0Mm1Sec4d7hoNw92bouB6I1XGBO3+T?=
 =?us-ascii?Q?I9Er6L6l8MLOt6dBz48wRlDbgqWxbSW0+7LnET4McLxXdO+Kztvr2vhFfv/H?=
 =?us-ascii?Q?mM2jIUDnfvdMuyg0RDWBLqXej0nt6Qd9znIuognNvtYpoC/H6jZzNzokc0oq?=
 =?us-ascii?Q?CGCdyVNX3O/vlbWfXFUuh3JjkB1vieft9RlBR7fZyW+T7Jv7pBhYA1cMt2S+?=
 =?us-ascii?Q?it8S21w2uWADLmxeTWZKqzdvD3GVn8/I33L9RpRE5iprqhfgDtQiZXJpLzZz?=
 =?us-ascii?Q?Hj4vQZkXUw0x4Mqh6ypuyqVjDTg39oEs3YbhhPJ7wzFGsHcX+tPqhgOttNcR?=
 =?us-ascii?Q?GH1ZzC0DoumopQNLVhhpdt5Liqd8bsdD7LSZ8FgoCAzWI0TtCqMkYMxNz7l9?=
 =?us-ascii?Q?ncu3RUf15w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2830e4-a4de-4632-322b-08de7f870d20
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:58:35.2276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFH+rSteEMYKURkgCNCA/72s4izvWimiB2UvylbCmQYx/TCbqfUH6fiMSOdR6SIJRbZr3iBqfdS/zlRgOi7ffQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036

On Wed, Mar 11, 2026 at 11:39:57PM +0800, Cheng-Yang Chou wrote:
> Writing directly to p->scx.slice and p->scx.dsq_vtime from a BPF
> scheduler is deprecated. Currently, if schedulers want to add a
> virtual time delta, they are forced to do it directly via
> p->scx.dsq_vtime += vtime_delta.
> 
> Unlike the existing scx_bpf_task_set_* helpers, this direct
> modification bypasses the scx_task_on_sched() authority check,
> potentially modifying tasks the calling scheduler does not control.
> 
> Introduce scx_bpf_task_add_dsq_vtime() to provide a safe and
> approved API for schedulers to easily apply a delta to p->scx.dsq_vtime
> while ensuring task authority is properly verified.
> 
> Additionally, update the deprecation warning in
> bpf_scx_btf_struct_access() to suggest using the new helper.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Hm, I'm not sure we need a dedicated kfunc for this. Sub-schedulers can
read p->scx.slice and p->scx.dsq_vtime from any task, they just can't
modify those values for the tasks they don't own.

So they could read the current value, apply the delta, and then use
scx_bpf_task_set_*() to update it.

Am I missing something here?

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c                       | 27 +++++++++++++++++++++++-
>  tools/sched_ext/include/scx/compat.bpf.h |  9 ++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index e7ab3647e35f..26a85ec58d31 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6963,7 +6963,7 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
>  		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
>  		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
>  		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
> -			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()");
> +			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime() or scx_bpf_task_add_dsq_vtime()");
>  			return SCALAR_VALUE;
>  		}
>  
> @@ -8281,6 +8281,30 @@ __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
>  	return true;
>  }
>  
> +/**
> + * scx_bpf_task_add_dsq_vtime - Add to task's virtual time for DSQ ordering
> + * @p: task of interest
> + * @vtime_delta: virtual time delta to add
> + * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
> + *
> + * Add @vtime_delta to @p's virtual time. Returns %true on success, %false if the
> + * calling scheduler doesn't have authority over @p.
> + */
> +
> +__bpf_kfunc bool scx_bpf_task_add_dsq_vtime(struct task_struct *p, s64 vtime_delta,
> +					    const struct bpf_prog_aux *aux)
> +{
> +	struct scx_sched *sch;
> +
> +	guard(rcu)();
> +	sch = scx_prog_sched(aux);
> +	if (unlikely(!scx_task_on_sched(sch, p)))
> +		return false;
> +
> +	p->scx.dsq_vtime += vtime_delta;
> +	return true;
> +}
> +
>  static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
>  {
>  	struct rq *this_rq;
> @@ -9167,6 +9191,7 @@ __bpf_kfunc_end_defs();
>  BTF_KFUNCS_START(scx_kfunc_ids_any)
>  BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
>  BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
> +BTF_ID_FLAGS(func, scx_bpf_task_add_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index 704728864d83..06f298f6909f 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -343,6 +343,7 @@ scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags)
>   */
>  bool scx_bpf_task_set_slice___new(struct task_struct *p, u64 slice) __ksym __weak;
>  bool scx_bpf_task_set_dsq_vtime___new(struct task_struct *p, u64 vtime) __ksym __weak;
> +bool scx_bpf_task_add_dsq_vtime___new(struct task_struct *p, u64 vtime_delta) __ksym __weak;
>  
>  static inline void scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
>  {
> @@ -360,6 +361,14 @@ static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
>  		p->scx.dsq_vtime = vtime;
>  }
>  
> +static inline void scx_bpf_task_add_dsq_vtime(struct task_struct *p, u64 vtime_delta)
> +{
> +	if (bpf_ksym_exists(scx_bpf_task_add_dsq_vtime___new))
> +		scx_bpf_task_add_dsq_vtime___new(p, vtime_delta);
> +	else
> +		p->scx.dsq_vtime += vtime_delta;
> +}
> +
>  /*
>   * v6.19: The new void variant can be called from anywhere while the older v1
>   * variant can only be called from ops.cpu_release(). The double ___ prefixes on
> -- 
> 2.48.1
> 
