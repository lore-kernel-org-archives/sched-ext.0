Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D331A9F82
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630692; cv=fail; b=oEuEI9yvJUJJZ28qEyeQWw1vsvEOFgSVAjhhaY7/o+ZepA7aatWjm4LHVWIC2kn0uKgDQ7RAnS+z7WM0b7GAvupU/U9SoTkw+bUgmjDjC/xzKqxoDE1Kn6wi+/tGRI3Fkl022kGkx3sBleEi/G7e15Gwyt9kWmupFe4Q1QEA/Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630692; c=relaxed/simple;
	bh=EgQ6Y8N3keFF7aBa9iMxB6T4CZ9vGWV+N3T7Owsijjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dVXK01TlKTVnOp9jxVWSD/Fgkv6kEmGIX1HHh51XVGV/437++5slna+/Izf4OzNDQfPPDTcX1ZmYaAYsPNP5shuiFn+DXhFI3W0iZMKwrQvD2u0SmWMu14KnDXS/s8mSAxDp7CGRQKybvX2E6FBF0kOBjYXLnbXmPm5QT26cdbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AwxJsmEa; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AwxJsmEa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfMF1fpQiAMmWZLg8y6SdRVlG3EOEDoUs4ZW3z5IA8A2nRqewFJJPnQ7BaqTzVZB0N5Wergx/WRgsJ5t1gMXof0ks/b+bypyHaYSrRR2cgcd83EajLsNnIqTVkCB403aGVPL/iE6N1UVsA/B2vk7DXLinL3MrD18Nl8alj0aAxWPA5wTFTt9Id6kuhkqdtKzsnfIcCVLPMBQf9jk1E/0CZ07/SaQp1Gb3NcAUBVcTZQFbKL2x40ZTGdtVidtGMRqg0fsSvYYsTN7nOlyMTBOHCBsmRNfc9GLQ59HO4jqipjYF3X6bJu2HqqMCSwGGfaGMSEmiAgc4hR6RD+W66YJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br6EeosmQhrWEXnPnkzvCvCW9AiR886K/iQABjZkjBg=;
 b=qZgqluZH79YyQqTLL7HGdABphTxcqHWszqTPQv2GfchpYltQVSiJZ2iH+Oz2BtyzmKFAwaOVMb33ZmpozK5buPhXDccIU77mfx2wmsQlGWWQlnNEv0E2SBMM/NrZw6o/9pkFgxXsnuHFVk11VpqLgss7BHU2jX+vsPI71x65CdfbHSErGEbdDp9Uvp/mf2iXRjG+8rsUy2ncVoszTg1PO2R14lOQLwPTETumhaJ7XCEGJKXhv8fLCjbNMtFGMFZtRf/go369CHYlyw+PaEdYIaIR8amcT1xZU0edLNsmwe9d6r8EnGsHZDnVeKOe7GyuKg49/XU1WdS4hYONx7B81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br6EeosmQhrWEXnPnkzvCvCW9AiR886K/iQABjZkjBg=;
 b=AwxJsmEaV+Fmbv3cxrGE44OqLqoi8igQRytM+S/9yDLAg/32LYgSJC1EkLWUZMe91B00JyYw5UJLudng2fOO7uL5Cm8LgcVMMjoCcRpVui1CV9HwDDdbqWoolBw2aggsLkz7E/Z4Tup7HcL/BRzpP2PyaNq+PLj7RMbQKiQdJJrP6rX2o91tsJLqaJcg+CEVwzTcAB7ZSztjAc9TwOxLwCqxe0d6WUQBrQqw4LDcgL1s4v8fyhalVTvuI6AYr0icMdLiyTiVKsUxuLFwKLArVPqGrwfQ3ZkcjfLAMR06s9aP/7iQsXzFlNNL0j49ObijpLvK0sfXLdm0THVkCD05hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 20:58:07 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:58:07 +0000
Date: Thu, 9 Jul 2026 22:57:59 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 09/40] sched_ext: Make
 scx_bpf_kick_cid() return void
Message-ID: <alALVwUhMvxFJsqi@gpd4>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-10-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708212429.3405787-10-tj@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA8.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44c) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 6696453c-fe0c-45b8-89c4-08deddfcc709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|6133799003|5023799004|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	FeUj6tuJQPveqAOXt/ecFeNT8RO144iqhsfq7rc9RSFRL8kgIWIuJ2k2xYJYPuGH9mXK18oJ5X3G/Nm7kZe481gVn5SN0eJYIbgZDUXZYq3ZN8gwXV5R7ZYHcKjprA0qS7xk2CW6NrwXXBEXxzXLmYQWfCiqzm3KrMu2h3ek9ms9uzhrpSmKokUFeE/exy+7DIv9MPke0jmHphd30/DEHAp2DxB/CUGMPaMKSS2WgtNccJoCMsvWea+Sj9OH65T2uzA5gNZYSR52asHiMPMXiM05p0yNwsXt//1Zle3cB3ttzQW5WP1ueQ/s2dDppeS0RUXNRvfbBU02XTvNUoaZhFe00voixkHE9JWR8Wuv2z0h438Okp2Vcvp3wrSnGujG4QRh65wZE0tMIINi2pA9KoTV0kKprQ+TeQf4ue5maHp+YXghiGNGMAMxRGL4zrXNycoFYklMS3097GbToDdndA7QYzzRuUXtiOJ85qY7CM2DKliOvajczQckdE9+vGI+IFIGeGUGKJB71UwYsw8rVZ4HUJAZRUBDS9LZOnP9SdMe4jrypGHCNNJb6mKrtxHJuiCWny349H6CKwgUnYGDR6lEeC/cfyiZtrbV94v0B6qBTQ/KsrK88TlkVzJjPdG5McQnRBAm8jrowa1oZoHGWRP93koouK1rKge52MLXhUo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(5023799004)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fBb6MY508UQPx6Y5kYCrMkQ1jPh39pvn0K0GLhVOEutF8eG1XMXS7DUoJgqT?=
 =?us-ascii?Q?Lu/bFiaV920Ioo6haPV/C4L8GU7pU2yCftWFUqAa02giuFvQcX2yUnrOG6K+?=
 =?us-ascii?Q?Em21Xlic6GpCf8undvCrdWKxCxrVlOL3yN8LaCBAotY+Qzkw2M5SU1iNwDdY?=
 =?us-ascii?Q?XYHKJhoCh1BAHRS79lQeks/M/Ys3iirUFzOxk4BXW57HVXi3myo6Opaw2ieo?=
 =?us-ascii?Q?CJ7eO/GFjD7TSr1Dw3bbcQULhY+y7rtDtFmP/KOPd4fSVbHi1Cefcj15lPAO?=
 =?us-ascii?Q?vuCD+d26gKze82qryWbs37KLZyVx7LYKxhWZ/abmDfPCNkGLiRkIgOt7nwA7?=
 =?us-ascii?Q?+tz9yKzjZ5dVJ8B2hR2f3Yq/091YtzTkqRtHEGS5B+Q8l4Sb+gJ4EZXrt2bU?=
 =?us-ascii?Q?QxhNFvsMOoQg5WmLNSon3eZBTltUyFyyEhLvyx1jr/ReaE26Us5s+G5x8L+v?=
 =?us-ascii?Q?lBWclATa4kbLLaa4RjFUglTFQiGxb1Ct0LDd+WEWvGF2vu3kvU16wdSnkP04?=
 =?us-ascii?Q?hrYixxVyebOND3m+4iVpKvMxTmoQ8Lbiju/OBpL46/bbIem2vofgqWQ7EiB2?=
 =?us-ascii?Q?vVWQDa9cL/zu/U/gtyllp2Ff+ptZOkL+weFO8MifcGlq5lobcHjMfQ904jcE?=
 =?us-ascii?Q?CVrxLnbo2jIcIbX7d9BYuQits2sNVdKROyjYi3rrz0mlmmAu4yKHrE43LOYT?=
 =?us-ascii?Q?BS1IOEiv/tjyYsNGrHq8heORNZ0yYo2drGBGSaDGwnnEMfvO5nfcHa8rD6I9?=
 =?us-ascii?Q?rneUv32/O+ZJIGAg6MrZt4P/dgKseizDe0aELkT3jVmdWRxZd6SARfJHG01M?=
 =?us-ascii?Q?JD7uWF06hxVpIQ2PGKsu1ZU/fL9K7CO6aYw3G5vdXxYIwwm0gyQxZHoxbi7G?=
 =?us-ascii?Q?jH9+LtzSbjwAgOX4+w5s1PSHbTiltxFI337auHA7UPW8z9+OoXS55LcNC+3R?=
 =?us-ascii?Q?PdGZGTRGe9tv9m6PtPK8fSON4gE5Zxh+sQdqCUGlWzsgss4FeKuDgearhNYw?=
 =?us-ascii?Q?cMUdYjF/2IWaCicrofmsQNgb3lQubxH+EzHjUF9N2S9w81hI/u13DNaI46CQ?=
 =?us-ascii?Q?AhNY8JWmbTKopffJ/CWCdPOEwIlCZi5tDUyzYiCEaQgqgy1J0QUytb6z2UP5?=
 =?us-ascii?Q?oZYh60XnHZU9QE47dZOon4kkCZdByC2hc7T3ZR4xc2dEYd9Z9RxXmNKYDM5B?=
 =?us-ascii?Q?WmhaaBwS8mHsSNsT3wynkwxWSFqK3bvvvO28MyintxbqDy6CFnmMOqAciLvu?=
 =?us-ascii?Q?NadqxcmvJixYazg/NJDWRnMu6arcBriis5Ui7QleFV5geO1s+MY8ImUB62Lh?=
 =?us-ascii?Q?T+4JGT0Sgg0SOvPjqBVFD+M112r7hcA6Xn2XHiAu2p8x3kIqSXlf7A2ecwhS?=
 =?us-ascii?Q?VhScRciFxB/ZQK1kIHU/TJWyOo9Q7iv4wCjbXVGRdRCLprevQ0+P9oQbTo5h?=
 =?us-ascii?Q?GHBarTQLFciK5kgpRU0AGIHAH9r+jBwn1v1ryEM6xs+/iglkydb+lEEoTERQ?=
 =?us-ascii?Q?atitGnWl8MMqprlIahcDr9+GMl4Y7FI2208fxg2HFP72uYya4G5IYnbe1E+U?=
 =?us-ascii?Q?5P/PdImNBwKBEklLeSyn3ARW+6pgwhVK8rOI4QhUyLxhzvBgIZW1ddNBUsRg?=
 =?us-ascii?Q?hiQnjRm5Ygwi52A8+4Y+gC+xM2UmwE33ZIuR/yeplg/JFbM7CzvuoqIe5pkO?=
 =?us-ascii?Q?EfslHuA8G154rZTbF+60iFdn2xIL15YbrFI4Ija9lHQgAuPm3J+QDS6sVYuA?=
 =?us-ascii?Q?pqg+ENZqOA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6696453c-fe0c-45b8-89c4-08deddfcc709
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:58:07.5793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR4cnKjlqrAWevApJUOO70Qh0uHhShjEYW8fBAu8yavZ1SeibowVeXa1I+Ll+GBW9qtfoouq2SwBeONUR32bIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480

On Wed, Jul 08, 2026 at 11:23:58AM -1000, Tejun Heo wrote:
> scx_bpf_kick_cid() returned an error code, but the value conveys nothing
> actionable and no caller consumes it. The kick is asynchronous, so a
> successful return only means it was queued. An invalid @cid is already
> reported through scx_error() by scx_cid_to_cpu(), and a missing scheduler
> leaves nothing to kick.
> 
> Make scx_bpf_kick_cid() return void to match scx_bpf_kick_cpu(). The
> cid-form kfuncs are not in practical use yet, so the ABI change is safe.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c                   | 11 +++++------
>  tools/sched_ext/include/scx/common.bpf.h |  2 +-
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index bd3cb59b1dbf..187754d0c3c8 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -8533,10 +8533,10 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
>   * @flags: %SCX_KICK_* flags
>   * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
>   *
> - * cid-addressed equivalent of scx_bpf_kick_cpu(). Return 0 on success,
> - * -errno otherwise.
> + * cid-addressed equivalent of scx_bpf_kick_cpu(). An invalid @cid aborts the
> + * scheduler via scx_cid_to_cpu().
>   */
> -__bpf_kfunc s32 scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
> +__bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
>  {
>  	struct scx_sched *sch;
>  	s32 cpu;
> @@ -8544,12 +8544,11 @@ __bpf_kfunc s32 scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *
>  	guard(rcu)();
>  	sch = scx_prog_sched(aux);
>  	if (unlikely(!sch))
> -		return -ENODEV;
> +		return;
>  	cpu = scx_cid_to_cpu(sch, cid);
>  	if (cpu < 0)
> -		return cpu;
> +		return;
>  	scx_kick_cpu(sch, cpu, flags);
> -	return 0;
>  }
>  
>  /**
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index bd51986c4c42..e7b3ba491c5e 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -104,7 +104,7 @@ void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __
>  s32 scx_bpf_cpu_to_cid(s32 cpu) __ksym __weak;
>  s32 scx_bpf_cid_to_cpu(s32 cid) __ksym __weak;
>  void scx_bpf_cid_topo(s32 cid, struct scx_cid_topo *out) __ksym __weak;
> -s32 scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
> +void scx_bpf_kick_cid(s32 cid, u64 flags) __ksym __weak;
>  s32 scx_bpf_task_cid(const struct task_struct *p) __ksym __weak;
>  s32 scx_bpf_this_cid(void) __ksym __weak;
>  struct task_struct *scx_bpf_cid_curr(s32 cid) __ksym __weak;
> -- 
> 2.54.0
> 
