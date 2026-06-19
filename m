Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7A29B8E1
	for <sched-ext@lists.linux.dev>; Fri, 19 Jun 2026 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781895253; cv=fail; b=D3QRa8JHOQSJuR+tajshc5xNPq/zEB2IuvmvUD+4KHPMReYJIxyRpaXaj0Zn/qDI3UxrpMIE8M/IOf0yG8fx2TDzYvNqMTynBrwVyUrZRNNWYwXTGJtbSE5sKZS7BW50Zw5kcpc89G6Id9OX4lQTtQ9RPPWeGs4Y2OQr9+J4xvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781895253; c=relaxed/simple;
	bh=piEe2dvh5m+Juj/D1yybLSW/tNX4X8vBd66HIqy7dds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NFUwaeMQhaQorhERplF4Vkh2UzIu3K8VO4c2ZXh3bMlsMVVidFS8YCyHzP4+xYzp6/lOs70ibLhiNWFaEvwKlGzBna8jgLqnvMpP/JvB6km7Oc0vMjnjPEkCxOPxaWluvzqF8qLRkq3CYlFSTe62I8anZSSvaunCdDnGgnTVBIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QycieqrN; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QycieqrN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7OMDarkjUJKtESCJtPKD5MJguF4psHgGwzkYAzda5oMXeJVS91oKtBEd5ZTssQkXh4Nh0HiAAkgnatPqfkFaJP/uCWnIGTMZYz36YGUeuCMOBg5TtRLTAZEUDz8riyt9FKzZIvLixS6gsRzsniAfiOPxD+sqVZBGpDvuvFBQ4e8ICD0npMWtUoWLlVWMA2+WqcDr/VE7kSzOiDHF+qHchr/uX4GhrRKMOxrI2FHQ/QzqDmfx4ng0KNMcSi6325QHti+UgMuMZtTVhBCXERSziaYLporvp/8yGO705V2BqOfCFFY+ZzKzGqMkXv3a9DhhfNFk8HM178ufpW7O1kk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZmtORBl8AaDozUlaVLyuvEAAQcI8WrT/X0tPPdlwGA=;
 b=fvzcwy4mYMIsTFyIZ6qdgxv2OWmqHtGca8Vw9tLBW+HReIb+8mqt1GMn3LVtL0BdnVql7amKobGNTJkNEgr/rb1o6fx94UeuRYbwsWM+gS4cDk25ntAcXoWX7NJwAcPPVgJb/1ag1GG4IuvZB90rH0r2zTYiyQ5RrmuBkuPk4wt5OCqc55GZ9eJ0x0HpH8YkK0r6oSdFJLrp9D9jhU0DfMkTE4or49QtGugAl95+MbjFAwClTgRg31pBL3MKSmHIa+KjJuZZgtb1h5cQbkHw9grxHViZ+NrMWEkidFRa7lwL7JNJNEESAqUgKXs6vuNk8OG9pWk9HOvL3scFVVdPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZmtORBl8AaDozUlaVLyuvEAAQcI8WrT/X0tPPdlwGA=;
 b=QycieqrN5vfFexwErhrmhAo4u7nqXUL0PCZBNZz7C4Ybrt4qbm+kwGBZsxNANW5U7oYqBVtZIha8o7iKe2g8szOdhWZnvvQyGPR+qymqMoV5ZyZe97/HRi6PRsMwKP2iwq2oTv/5EZKyWYKE39vGddPATxKELJd78rrPYiQr8o7PE9tQTD2MrMS5QMZCgxe6UiTzgoFNbBIFSemcwEtPrAa3m3cXDOmL/837K57E3Xvmu0gtQOPuoOICgkI2WjtMkiGpls4/WfBVu6IFtGKFPHE9vCpkNj927aD1sCl80MxPAO50fW/NgZqKS42kOc1u4TTjLl3xtuXoAwZVRfEPtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 18:54:07 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 18:54:07 +0000
Date: Fri, 19 Jun 2026 20:53:56 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, tj@kernel.org,
	void@manifault.com, changwoo@igalia.com,
	gnq25@mails.tsinghua.edu.cn
Subject: Re: [PATCH] sched_ext: Remove deprecated scx_bpf_cpu_rq()
Message-ID: <ajWQRLnfpnFtHmTs@gpd4>
References: <20260619155920.156257-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619155920.156257-1-christian.loehle@arm.com>
X-ClientProxiedBy: MI1PEPF000008CC.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::43a) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 9429e8b4-dc1c-4a0e-5adf-08dece3423ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|5023799004|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	y2tu+GoBPYFOAtd0+jiK4K0cJbdYL4x6erNDvrZ8VuOYAjG7PyiNULFe6aTNCQE4klzBNr1DYqMiA2uCF2/Cb6TYafoS1/Zlelq08W1KKA3Xun9Lx8AZS/uKfsEnSpORmQ7NfukSObVEuYZdftIa+LIv1bmKnSBmoSZIBgNFt2X5yn0cmLKGHiVD6jjPR+cHYh3kqVnLfbSAyEzBbr+JXjDmbmCJC/qJ033c3fDpAWpJXPwRLf/Jw3A6vg+vnK7CAjmvnS1gxi58JbdGu1ibj096ISjnRUAU0vSc7QoK//efGXaeOTCIPHNx5icMGsHyW7MVuXjC3WxQex5v6/EYBQY1TuGeRmUF+J6MOjQSKF2oVGbfN8p44Ioy8FgtGtFeJ2NPfwvJPiaRwjVDIMzHSsCdsUs2RO8UK7sAhlGIN01JNmJTaFT2d0/ikmD6HJZs7KkYRI0eG5/IVeqCq5k4A2FuLKZybiUVKm+XV3nfU6Qg55Zy+rKi2Atn37X/hYAW3Q+81+38H49yQqWqnBTTUJvPC9ofZvo0Hn7XnliE9ZrqDehDSIoep7dYuVXvygR34MIIJVX8Ct2zyESGhji/BFhQLp/bSK/qeV2aXwX8TyDns5juTAQP3DxDwCozwkWwFDAQjQvIhcsngJYYUbZzx78HrW1S04FxhSMUlzkmgWE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(5023799004)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Umwmid6fwbFRdb77XqdpfvoLa6O5VJqHvy1qrDbaz9xPeu7fDeR+1aw+R8LY?=
 =?us-ascii?Q?V2yQPC2jqBeRfwUXtz/vpIHfZvPQzY2UA9fWXoupRHuHFd39dbPmfiCGZsJR?=
 =?us-ascii?Q?sb6iNxyzrL6rrz74EKt6jiuuHuEYjaCTFQVNZmGzr9PoQE5NiTkRevf7+PCo?=
 =?us-ascii?Q?iFZB3e0RUU48FZtQp6n5WTNpUmrmYafMpZJhqhKkF1+SNdqLM5JJCsYpzaZx?=
 =?us-ascii?Q?I7ydy/TnIatZbROVUj86AMFAc+JXcxBz3TYmQOCo/kzrFTh6NOQrwyMmxGc4?=
 =?us-ascii?Q?82pv2jyhoRt+VVy6WQocFgGUCZmQe2PIm+NdLBQTIa8jeDrLdCZKJYLa7U4J?=
 =?us-ascii?Q?orwfRRZ2vKCB1h+4DFDUf0x5f2JKG3d/gthywL51/tRRybILjjzAC2R/qLVW?=
 =?us-ascii?Q?t0k2y6BSaL8yqN4YL9l+9RXn86Rmn5yvPbzJplUCwYc7mZRxAxQ0sQWcI/xo?=
 =?us-ascii?Q?HJGIFh+uwAlFVxTwYfG/P4FKj8owWJ7q/BCmy7QfV+LWDa7QSi2K79XqQ9E1?=
 =?us-ascii?Q?+ld5uYxsQ16IIvIQmjJfumQVJ8gaAgn8WyzxbnijEWEIkN50bQYnf4FoVU6c?=
 =?us-ascii?Q?x20xu9XgBIYfUde4TLuKFvIbNA/EDMn8bu4lJXs3rxbFPjCUuFkm29uKSED1?=
 =?us-ascii?Q?yzdwlKImSYO0oktddjYHcaZJ3K8PbPgEqf0Ghs6IXktXP7wuiZEG5fUGBwUj?=
 =?us-ascii?Q?vOA5SEu5r3Oym7QmallRaTTY/uhz8FeZojbqXzDZg8zFD88ZhOnggTeXw1rI?=
 =?us-ascii?Q?guPrL2WMqO0KssrYI78E5kvATYMTMmiqnRdhtjaqUG8+jEF1c6o6YWRv5V2W?=
 =?us-ascii?Q?NOBBuGe7/o0MP50S2vz+J7sin75aty6cLoIvwJHibpv65abuMOChjhhzEO0a?=
 =?us-ascii?Q?+OWIEyfc2FZNX+H2HdWh6cYi1RIEQ+SrjuH+GajTvs+THR2V5vHMzKflYUf8?=
 =?us-ascii?Q?79irDRh0lDKySOyyKK/LoOkhtveyx1PFDmrblVB7JkQ6wVsu01f8IviqBDKG?=
 =?us-ascii?Q?6pp5q2cj8l7PePBvOIG+3s8y4YaQ5bDSACs+eZ6cy0rlFWfI2nKeEUpL8sjb?=
 =?us-ascii?Q?ihZXQD5bRCVFjBXAYssKw/zlAyMMgFZUAksAbbrtKj5gCS7FXWkkcqVgxSgK?=
 =?us-ascii?Q?502SlO2PTN7oRFzAIgXjpddvgZDq46Kvlnk0LcyFVuNKDptnpOhyzmrnKfTy?=
 =?us-ascii?Q?ZrZwZlik7pj9F8PqrqcZrL9up9aUqJ6DJSCehpjnX5KRpOytInuYIi7kqnQt?=
 =?us-ascii?Q?b7POqTuItxHaQ4yYIhZxecSSotphxSStflFDJ2V+pGcG0hF0jFZ9SkjSuzQH?=
 =?us-ascii?Q?au2mNBoph3Svn8GNm349w9H3mCeyZCRhBEohj7VSIuDa0fF0S2csdAWuFbaf?=
 =?us-ascii?Q?Q0BGo78UkmYlQKgh788utTJxc6sFik/OCKfhlS0uA+13RlZai4fDVf3RBiCE?=
 =?us-ascii?Q?TgBbP4tbGRFa3qBT8FPGf0iin/A+GbcogE2Cvgm6V2j6MnxQJzTCgLPkP1wu?=
 =?us-ascii?Q?i3loeS5oouh12ZIeJ4Sq/syU/26LiMyFVI70RQCMuxZ9L75BX6db73zs8rog?=
 =?us-ascii?Q?cz4SN2EqaPU5wPe/sJAy740GWvjd68HXF6oTbzR/z1h/GyLHZ5u61sPvCiGl?=
 =?us-ascii?Q?RR0rm2jZ+sYZFtrkdVc3XOJ9jJFevVWxhtzm/20UqF/I/puhCYrBmXCdSCAs?=
 =?us-ascii?Q?4hqWKLSXOefLkTaSO0RDNKPokNBS6cfiHvg8K4XnSs2ZC7GLSBqTlQxhspCi?=
 =?us-ascii?Q?Oo1M9KaOKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9429e8b4-dc1c-4a0e-5adf-08dece3423ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 18:54:07.1664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASQeEkGxOQ0Tpb1XNKwqzw5uaDKvioxpVwSJQ/w+P1a7ey5zIP5KxX8K9b6QmZiMnIaaO6JBGuo//fNiBhTsGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

Hi Christian,

On Fri, Jun 19, 2026 at 04:59:20PM +0100, Christian Loehle wrote:
> scx_bpf_cpu_rq() exposes rq pointers without requiring the rq lock and
> has emitted a deprecation warning since commit
> 5c48d88fe004 ("sched_ext: deprecation warn for scx_bpf_cpu_rq()").
> The supported replacements cover the intended uses:
> scx_bpf_locked_rq() for locked rq access and
> scx_bpf_cpu_curr() for remote curr lookup.
> 
> Remove the kfunc, its BTF registrations, the deprecation warning
> state, and the BPF-side prototype and compat fallback.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

It looks like none of the schedulers in the scx repo are using scx_bpf_cpu_rq()
anymore, so I think we can safely remove it.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c                       | 30 ------------------------
>  kernel/sched/ext_internal.h              |  1 -
>  tools/sched_ext/include/scx/common.bpf.h |  5 ++--
>  tools/sched_ext/include/scx/compat.bpf.h | 17 --------------
>  4 files changed, 2 insertions(+), 51 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 0db6fa2daea3..72d99dd3fe89 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -10222,34 +10222,6 @@ __bpf_kfunc s32 scx_bpf_task_cid(const struct task_struct *p)
>  	return tbl[task_cpu(p)];
>  }
>  
> -/**
> - * scx_bpf_cpu_rq - Fetch the rq of a CPU
> - * @cpu: CPU of the rq
> - * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
> - */
> -__bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu, const struct bpf_prog_aux *aux)
> -{
> -	struct scx_sched *sch;
> -
> -	guard(rcu)();
> -
> -	sch = scx_prog_sched(aux);
> -	if (unlikely(!sch))
> -		return NULL;
> -
> -	if (!scx_cpu_valid(sch, cpu, NULL))
> -		return NULL;
> -
> -	if (!sch->warned_deprecated_rq) {
> -		printk_deferred(KERN_WARNING "sched_ext: %s() is deprecated; "
> -				"use scx_bpf_locked_rq() when holding rq lock "
> -				"or scx_bpf_cpu_curr() to read remote curr safely.\n", __func__);
> -		sch->warned_deprecated_rq = true;
> -	}
> -
> -	return cpu_rq(cpu);
> -}
> -
>  /**
>   * scx_bpf_locked_rq - Return the rq currently locked by SCX
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
> @@ -10540,7 +10512,6 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
>  BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
>  BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
> -BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, scx_bpf_cid_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
> @@ -10575,7 +10546,6 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
>  BTF_KFUNCS_START(scx_kfunc_ids_cpu_only)
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
> -BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, scx_bpf_cpu_node, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap, KF_IMPLICIT_ARGS)
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index b04701190b23..38f099ccd24f 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1165,7 +1165,6 @@ struct scx_sched {
>  	 * but it doesn't really matter.
>  	 */
>  	bool			warned_zero_slice:1;
> -	bool			warned_deprecated_rq:1;
>  	bool			warned_unassoc_progs:1;
>  
>  	struct list_head	all;
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 9591a6e778ce..bd51986c4c42 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -96,7 +96,6 @@ s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags
>  s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
>  bool scx_bpf_task_running(const struct task_struct *p) __ksym;
>  s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
> -struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
>  struct rq *scx_bpf_locked_rq(void) __ksym;
>  struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
>  struct task_struct *scx_bpf_tid_to_task(u64 tid) __ksym __weak;
> @@ -983,8 +982,8 @@ extern struct irqtime___local cpu_irqtime __ksym __weak;
>  static inline struct rq___local *get_current_rq(u32 cpu)
>  {
>  	/*
> -	 * This is a workaround to get an rq pointer since we decided to
> -	 * deprecate scx_bpf_cpu_rq().
> +	 * This is a workaround to get an rq pointer now that
> +	 * scx_bpf_cpu_rq() has been removed.
>  	 *
>  	 * WARNING: The caller must hold the rq lock for @cpu. This is
>  	 * guaranteed when called from scheduling callbacks (ops.running,
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index 87f15f296234..133058578668 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -233,23 +233,6 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
>  	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
>  	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
>  
> -/*
> - * v6.18: Add a helper to retrieve the current task running on a CPU.
> - *
> - * Keep this helper available until v6.20 for compatibility.
> - */
> -static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
> -{
> -	struct rq *rq;
> -
> -	if (bpf_ksym_exists(scx_bpf_cpu_curr))
> -		return scx_bpf_cpu_curr(cpu);
> -
> -	rq = scx_bpf_cpu_rq(cpu);
> -
> -	return rq ? rq->curr : NULL;
> -}
> -
>  /*
>   * v6.19: To work around BPF maximum parameter limit, the following kfuncs are
>   * replaced with variants that pack scalar arguments in a struct. Wrappers are
> -- 
> 2.34.1
> 
