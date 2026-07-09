Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA7352006
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630627; cv=fail; b=qhTMAY1YZnMLSu9+CyDjmiiKs61xJrszzNX7J0O2Kurn3v56+JUT0BY09ES3R9OLIWu+OosBAfMeuCyPN7jlmWtJ8l16UhkHfVXI9xVGY7YlcOTFyU0zl+b7e+bVaRPMLv9O6/S2CFtwuGLlNg7eehpcN0Vrdqd/k38FmIFyMME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630627; c=relaxed/simple;
	bh=6z/MtTFlWy6wtUleuAvN6zZbTHJAA75ex1ccT9WGO/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JEpt3kGG7eQfr9/s8oteB6xnZlBIyIn+JMLLPAIMkdQ1lhTMGGrsNuR0/y90OvCXfo36umBxV8C2ib4BbFOyL/dH+UklK5Y+w/AY1aAA81Uap1KlfsIUeWLrqZrvh5FUPYapjBohVz/7rS61GavjtPG3YmAbaXfM5+0xsDioG+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jPvCK54E; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jPvCK54E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmbLEP2IatJNHHoxjV12U11+3o8lB30OM4+PmckbMDdz9Mzv4q3mh3Mqd7TlbFDclmmkHIr2Rq0dN31NZ+JBFAikYOz4NohJ0/9xlnoruY7ZisDyUWbHfy0/c3gPHJWFiNu6k7z+YMgSfk8yjAHdHPTmujAP41GImGtIysgaUvzlRVaiUdsb7fYEl1LA647LhwIuVSP/Z0ba24uRWKGJHw892jyHK8SnIk+4JdvTgOgSEoKWHzWlN8dqTKJR9pJY6e8wj/R7c7A1mTRuuCkNtMEzdALab/SVefxFw3EyfnyrVfncjV6heTt+4C7j0HwI5wGgQb/GEiWTuCQ8gXcC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0zAzm0pbI2iBRZUjxW1iV0n91api0g0c0vgkvZ97SA=;
 b=AVvzqyTZm1OjF+GRjyy4Vz3uB0Un54B9b0bukh3Kstt+6Fh3+lqdIisbGGOc8SEF1e1aRohA/gmoUCxzrZ47BzMn4NLIIwU4bIpKNXDeqboP+KYF/iBkNOZJrjv4HI3Ywaub+8mxafKk8I70pp0IdDOxuBSDUgewKIOq9QiuoxiLa7ok9D204CcGXOLc/m7U5+J01Ov9gyoMx+bm+VxtCPyUYDxjTHPhp/6kgK9LH5loMy8ljWZMkAiI0ckIVRVDCOtex+yWz6YjpOi99EY9qSak6q/aOnSGwb8v2wsIVr6qlzmUvU76e/KkqAF7EXSgHSEqgtONQSv7d0qmzgDGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0zAzm0pbI2iBRZUjxW1iV0n91api0g0c0vgkvZ97SA=;
 b=jPvCK54EYnBUTRxYW0QtYvMGov3qXVUMYSqia1YfKY0vfy3rv1l69SjAM2ftHz4z30RjTxRVJZAr0rJzfPUei0hSNn8lnvf7FuNt+lTNph117zfUExXzUYObEWrc50vdzhXpnLJXEBq7gFeigBjdvxcwGNpPb2XoCX3koPoSpBXPrTXxUEkEzLa9ntLjnwbq1lu8kr7HMDT3CSZpTm1G8K0PIQJSBLt70u1AhDIpU9pGauUZXe1qBXdP4hgnqAV/llyTVUPyZgc0dylVaFk+AA53i+a+tXASD6P21sOr3T9uYVPSysT9PPz9VvOLtI+3IvhM5SVqL4XJh6W+/vVMKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 20:57:02 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:57:02 +0000
Date: Thu, 9 Jul 2026 22:56:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 08/40] sched_ext: Reject direct
 slice and dsq_vtime writes for cid-form schedulers
Message-ID: <alALFXPBJpxcQWw5@gpd4>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-9-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708212429.3405787-9-tj@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B8D.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::414) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: f2abc5ea-872e-441c-b782-08deddfc9f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	+sh8OJu29e1UJsceX+VzZzytFGl58TYD8/dvHt+fHLAHrbJFJf1eEuujXccSHR0FXiqLpXcf8+9Lmnh3ZtbMq4lYcIlvLapPaSezbI3E0O+nFTrE8DLjoF6iSwBDSfdCdzq6j/Vy0f5mznxsczKIO6nkK6zntrOGU3eHEHYuhi0/+XJ4ztxygX30Ig6KcnrYUztLwrdoImKOFiMhBGnjhvpUfzMWbhczcpeyE9fgGnnWEpxVUWX0VoVMRBAJ9me5d30XXGSkciMU/CtfQrlZzKz3Q7YSpD0xfMOy1wdZozKoszuCTAfXIP1Rrfj2QMuBkQMYx0NhJyzjCfAmUuaDkD68uu/fNAMlNKL1dlswXIb5xIjSgzJp7DjL/RDYOoCaXQQRpIFZo4aNVh/mnnYMBEo3nJkBSFwMIWDqwQtqx7iayl2DNAsB6gTxDL8evl83IcnU0/oe++f0m9BohroDtCXdX9FDq6IUFjUwss3E+cOC0hv/zXs3Lr3A3m6LOGL/AU3w9xCggh3u5azhENzrgmW6sO6ov2J85RAGDbs6sq4fX5QsQb2JzMdp4YWmDOMPkaryjZ7fIwi7O81WhU56On2RiS0kUw6SRzyyQ9XufIddfvScNs1Xl/ZqO9YknqeSMNOW2mKpAqg0x7crGcEjKK3J8Xa6HWUCAP0qN5sD/wc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PwklEbJ6HOan1DvlsAm1GoX/6IphaQv/cDWpvJiqLnjGZnotYjqBbF4xvHvS?=
 =?us-ascii?Q?Fs7m3XY0OHQlAYB8+D01Jd5wz7sQOCFishxk+gTkIKONoh46W4jpgLZo4XVX?=
 =?us-ascii?Q?JoDL6B5S0g+oyjXVmt7tN4TSEl6A9E+L69Bg/qe1B420L1VmAeA4H6uo9KcQ?=
 =?us-ascii?Q?5332ckDv4iphXhvUaCLuSpZyV7ODR3GPvfcdJcyh2mWOaNits/97fVz/PoXk?=
 =?us-ascii?Q?4kTblP3SGtgdMegwnIRTYNCXkeK6rZaFssZ/y2Qv1j04Pf1vd5NSoOZqIMkl?=
 =?us-ascii?Q?2x5pMJclpX4xjSYyokO2xKndpEwdVL+n8/7KP5MAlMPoDyT1Wb8w/UwzGSK9?=
 =?us-ascii?Q?H5yzSXCMSonI4AZ1mzYnyX4EvRgSyc2xWh4iQfdTwtOay8V9zuuROJ4pbqJx?=
 =?us-ascii?Q?SddZGHfqpcFe/EZjZludhZr3dtfma9eeX28D54TzvnHDAW6/mMDFbUDRaYq4?=
 =?us-ascii?Q?/vnkzxXhx5rp0PcJ4FQa5ZQydk1qmIQwm/mE3TohVDpUFOIF//IkCqnrkUqq?=
 =?us-ascii?Q?ql8gJaasB/6y9JPuguj/afAZ55w7fNwacLLs0goePxKPZc0oY0OFv2+qFPhR?=
 =?us-ascii?Q?MuxVHVeqsxqMkxUHN8AaIHq3AXmvVeXand0n3syC+HFYChVeLXxWxQoOkqz6?=
 =?us-ascii?Q?U7FNbROT3MgatdeGWxLx6++Ep+3HoHCRjOfy/FwrSQoXdOf/F7yvBWqBDoR7?=
 =?us-ascii?Q?4TBq+VNjaqYYfFUibrQWPvvmRDb2hBbwOIK+/oDKM613SqHwwwbB+S1kH0pT?=
 =?us-ascii?Q?6g823YWkUFq8uVwp6wNaId8tvh9mNJpv0IFmroWk8r6ciSJ+T7K94MewAoFR?=
 =?us-ascii?Q?AZ/4amnD+7r4FXx1oF0S2onz/90JUzU/0KR/qVicDmVau0m5i4y2p3cYljLK?=
 =?us-ascii?Q?v567h97a46rbzWnj1n80b1YX2C1K+YLCe9B/c6SEc4KIWkcyuRJZu3bD903i?=
 =?us-ascii?Q?0UWSrfhHs1mEAOiBvlBPaV2y2N9FVu3Ee4uzj+/eZ2QXyV1KHO1eRBiw5sTl?=
 =?us-ascii?Q?ZYmTNww5cbs95vOXyLHbu9GubSdXHWR0T92n1lnkZl5TFPlsMoh1PbGer3mu?=
 =?us-ascii?Q?E9pxVOLVY/h6JGBBxX3nsyLdZBTsV7aoQcH0dNjpE1qDrTh5JkwOn/mkM+8E?=
 =?us-ascii?Q?x54Lk8Xizr0ZNEIhKGj73ZWe7HWaze3Xy5fnYCgUYJngt5TyWInTtSh8dndX?=
 =?us-ascii?Q?O6xJ8h90oC/JHdQ+cOPG96/m1GZPeKBXGDIRMCrI+W1DDsAILPlvHWG/KEda?=
 =?us-ascii?Q?QP+rqeaFOEmbMGTEW+a2kTgjpcI15Rb+wv3vapgkc17+UqBUC5Qp9AMBv8d0?=
 =?us-ascii?Q?TNn/u2He4baueROTzX5khvJcvqElA84/noeKzG04nJbW+Fn5LXBKhm6s5+DO?=
 =?us-ascii?Q?qsPUZiP0CgxZcfj6WX4fpVXf6LcgjtR/2bBM9F0tepezto5soLs3qP7RBrJ+?=
 =?us-ascii?Q?ISYw6mrsHo2Vm8Ge+c7zyf2FLNFfbEmoT5d1/58Z4RC8vRt+g3jKwhSdOkP6?=
 =?us-ascii?Q?msUCSBs+XjRubkqQ7ZY3cUiISIOYb06OkhCs4dPOEWE/Kfvp8FytiBNkc0ZI?=
 =?us-ascii?Q?o2IhEHPW7CN7OnKwpN9YXiRK2sSZdetXNlkEkn9IKxO5GkRoSfaRt3YqagtK?=
 =?us-ascii?Q?uCPaKlKzsxcPGYVWJhvR1di+ewpWP7oGHD1ikzfrSqXyIytt4WQ2ocVMO74H?=
 =?us-ascii?Q?SyP8kQQ3wbfFHgaDZimE8SQwT3cfhuOBdU35Vh4h/VBMTvPXtP355g231nhi?=
 =?us-ascii?Q?Pz3DDOuK/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2abc5ea-872e-441c-b782-08deddfc9f7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:57:02.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJ/m6xQXmItqIAVl8lOe7sNSVpnM7wzmjO2lnbJZf+HhyOs+BYBJUwiPvbFbCC6ppmjEUYTXHApID6S8/kbLaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480

On Wed, Jul 08, 2026 at 11:23:57AM -1000, Tejun Heo wrote:
> Direct writes to p->scx.slice and p->scx.dsq_vtime bypass
> scx_bpf_task_set_slice/dsq_vtime() and the authority checks they carry.
> Those checks exist for sub-schedulers, which attach only through the
> cid-form struct_ops, so the direct writes only need to be closed there.
> 
> Give sched_ext_ops_cid its own verifier ops that reject the two fields.
> cid-form is a new interface with no legacy users, so there is no
> compatibility to keep. The cpu-form keeps direct writes, and the deprecation
> warning they carried is dropped.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

The thing reported by sashiko seems more like a BPF issue. From an scx
perspective this one looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 44 ++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index be75bdc9ada2..bd3cb59b1dbf 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -6995,6 +6995,21 @@ static bool bpf_scx_is_valid_access(int off, int size,
>  	return btf_ctx_access(off, size, type, prog, info);
>  }
>  
> +/* common to both forms: only scx.disallow is writable */
> +static int bpf_scx_btf_struct_access_common(const struct bpf_reg_state *reg,
> +					    int off, int size)
> +{
> +	const struct btf_type *t;
> +
> +	t = btf_type_by_id(reg->btf, reg->btf_id);
> +	if (t == task_struct_type &&
> +	    off >= offsetof(struct task_struct, scx.disallow) &&
> +	    off + size <= offsetofend(struct task_struct, scx.disallow))
> +		return SCALAR_VALUE;
> +
> +	return -EACCES;
> +}
> +
>  static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
>  				     const struct bpf_reg_state *reg, int off,
>  				     int size)
> @@ -7003,23 +7018,22 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
>  
>  	t = btf_type_by_id(reg->btf, reg->btf_id);
>  	if (t == task_struct_type) {
> -		/*
> -		 * COMPAT: Will be removed in v6.23.
> -		 */
>  		if ((off >= offsetof(struct task_struct, scx.slice) &&
>  		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
>  		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
> -		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
> -			pr_warn_ratelimited("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()\n");
> -			return SCALAR_VALUE;
> -		}
> -
> -		if (off >= offsetof(struct task_struct, scx.disallow) &&
> -		    off + size <= offsetofend(struct task_struct, scx.disallow))
> +		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime)))
>  			return SCALAR_VALUE;
>  	}
>  
> -	return -EACCES;
> +	return bpf_scx_btf_struct_access_common(reg, off, size);
> +}
> +
> +/* cid-form rejects direct slice and dsq_vtime writes in favor of the kfuncs */
> +static int bpf_scx_cid_btf_struct_access(struct bpf_verifier_log *log,
> +					 const struct bpf_reg_state *reg, int off,
> +					 int size)
> +{
> +	return bpf_scx_btf_struct_access_common(reg, off, size);
>  }
>  
>  static const struct bpf_verifier_ops bpf_scx_verifier_ops = {
> @@ -7028,6 +7042,12 @@ static const struct bpf_verifier_ops bpf_scx_verifier_ops = {
>  	.btf_struct_access = bpf_scx_btf_struct_access,
>  };
>  
> +static const struct bpf_verifier_ops bpf_scx_cid_verifier_ops = {
> +	.get_func_proto = bpf_base_func_proto,
> +	.is_valid_access = bpf_scx_is_valid_access,
> +	.btf_struct_access = bpf_scx_cid_btf_struct_access,
> +};
> +
>  static int bpf_scx_init_member(const struct btf_type *t,
>  			       const struct btf_member *member,
>  			       void *kdata, const void *udata)
> @@ -7368,7 +7388,7 @@ static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
>   * verified to match by the BUILD_BUG_ON checks in scx_init().
>   */
>  static struct bpf_struct_ops bpf_sched_ext_ops_cid = {
> -	.verifier_ops = &bpf_scx_verifier_ops,
> +	.verifier_ops = &bpf_scx_cid_verifier_ops,
>  	.reg = bpf_scx_reg_cid,
>  	.unreg = bpf_scx_unreg,
>  	.check_member = bpf_scx_check_member,
> -- 
> 2.54.0
> 
