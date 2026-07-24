Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520F4483A2
	for <sched-ext@lists.linux.dev>; Fri, 24 Jul 2026 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923049; cv=fail; b=XyKB6YtkjYDQDpFfYYHSSogPJl6ygRSQyCFBpPTnEq7HrOkJEyr6iVVDb/P1vKG8f1lBn8i7Jyx6fsIgjnRwLBrHWjfNGORbwJEuoDEyt5DrAd31YOreXFDdSWKSf6/UNm9u5jQZL7QaaghgLvpgVPld6+xZ1ymT3FirZgnDzQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923049; c=relaxed/simple;
	bh=lRVLq6plqLyydYqPEdqnKn4SmHe0CA0QgOawWjlkCBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=snVkW89J0YOQObNUJObXwtTIpncYI+msdXWwoTNcgpB5w11qR7DYIC67iMSsgc+KmxMgbTz173nlTc+mKYPODuyNLsFQkbOMuYszcig1gWk1lwH8brHEjM9OMiLhvAS9XsgSZkSLDpfKgX7mco6JLlw5gA4qVBwhZdumullFbJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HB4p0vez; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HB4p0vez"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn70642YykkvQGLNDAiHO+BtbV8MkyR4195pal8DU68Ce4YFpjSYznZjfZnHCCyoKFTtSHChjsRd64uT/SmeE6pSo/5ya9fqbfyEtN6TM6sGHFbnbS/UAiaFQ4w2oXgsEBVmPhfaiBNtpQXFP9P6k4Fa4Sxd6nOIFT3GTa657nIuFOmxjloBV3qr9/mAxI3z6PRjnr7Ybxp5j2DWkpJCM9BkDhhoQQpgwUM/x5iD6F499fM17mgz172QXeIdDQ80UlrmYgdZX5AUbTboRl+4TGGsDj+nlIf2gKBF1rNpIhuXyXc2yuOQOEo3QsC31yEN+njLNPgSH1jMAgghYJfO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stbCF81a9BjrPHMHug/pf8aJw2FStBec45h9d3wCI8E=;
 b=qm7UEfNF4nyd4sYseHW2iDl1pn5G2EpcpfG3vonTRosBHiidW6qV+JPSDxnHBziYBjqZ2nkHpgocT9XRUGY8aiTz8+q0K+tthyEyV6JErbBfIuMdg0N+FjLENIN6nj67zMJOoi7yEYlNbVC71DC5yYX3f064Hhz60RzwgI31dgc+fE2xIYVVHu4oOnEyNaf/2d5KqwE5V+cwS7RdqY/u1wyJE1ZY/rtLrylxnPL+PWI0/WqhI6aaT19E69TObwnMM583irpcguvBYfvrZCLvAVz0h/EuUl0uF/MPsQD/cXTFLWBiw1Z0xGb9jCRDCZgUpvaKlPjY9lriPFjVeAqjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stbCF81a9BjrPHMHug/pf8aJw2FStBec45h9d3wCI8E=;
 b=HB4p0vezdnWIL4Xcu3I7lNGN/1X24SPmGoQ96wxAKx/H8qHzKwrXkZHtQ94iXdxkqU1WmUq9zUL/eWLaOIMJWOa/URLX7xnZ2eJ6vjXmZJkl+VFrbQOTYiGAEX86gpBABO2y8qWmA5Qh13DFcKpUE7F7FmbGvwTGg3Jr7/a6u8kNoFSrbYc2Nf1XPmpZRIU28wpqOJvCsg5Yw1u4uTK2ajvsLqfjrIH85+nU7on6oFfNpAXEX1wyYhze8P0EJ7stA5y6I4J+rhzbDI0PXx5yLMU3gpbDbXVa4UhR1VTetLid0QN6ngny32Q7iznj6cnu1qM4OBFsWyC+byKhCcpRLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 19:57:23 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%3]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 19:57:23 +0000
Date: Fri, 24 Jul 2026 21:57:10 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Follow-up fixes and
 missing cap enforcement
Message-ID: <amPDlu-wZrkwOFFX@gpd4>
References: <20260724191651.1040227-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724191651.1040227-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ac78a8-3f4c-4045-1d1e-08dee9bdc70c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	KN9R5SdPax0sfqFZrL95SKG2fZ1cn+XKqcS3H0N+nCdUpI+wUXF489yPgxEPQpDRVtqT3ZoUwkaw7EHuY94NC+z38TdgNzygdKRcMu7IwD1LAoCHZZ1zLcsJ52ub7AHJSMB6XKHTGqHt+bukICho6lJu3ol/44yOvqtHUL2QHOdLuNHDWBctVJSOYxyeD/UOjak8++0dvp9lJCs0ZhHKwd4pQEhYdF/RQAmSwtVeZ4aL+L3TUbFE+TmGFSXZbg84eCLT84sDeJsAEv9MALMdYxdpk2Z0IIXiwBoygIl/NykR7EQkAmSBAfANvmTLRXoOE1lwupgWFjGincIN/WCeTtFmOnywYUg7tazS4px1hsZegHyVo637fHokmKNdeMwgCv6phNVFdbqBeEOQdB7Yo64sIsEliKN2LylZYtRtP/WiH97oAYxa48FMHr05GL6HVOtd8aAVAu/Qbp6oIu0ghJQ/KuwNvX2J5RZHg45baBoYTCvcs3wCCGJfG+B4W7kS5Bf6IGMVNPVysFMOIMO5hP9/V4fd/hzAeNL5n24/8zc5MMIA+5y16JFbA54jzO+FD5I1mzerq4xpou6IEv6Du7D9QeMSaD/7yGh8+6XzuDrPiaiSnqBkVTdUhjJ59cVm2Pr/gIUws+OAnZ0b576D7xf5Zm2Vm+RGvYTCv6tP/FQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG9Gb3JnVzV5UUovRTR1VmJyYmNpOGhYelFocEc0TCt0NG10anJsS3hUNGlC?=
 =?utf-8?B?L3cyK1lRdXg5ZllkdjdyOGRpOVlDSXgwY0xPTURuMXJxb3BJRXhOU1FsY05y?=
 =?utf-8?B?Q3VvS1M3TitTY25NMTZXblRKSUNvMURFYjZINndTZjJHNXJTcUpOa044Z3J3?=
 =?utf-8?B?c0o2VjhxRFlIcG5yNHlKa0RjL2lheFMwcGFJUkJzUzR0RDNPcXZQMjRIUnZj?=
 =?utf-8?B?amJETWVLRy85VjAwbXBCdXVqYjBvcE53WWx2d2ZzWFgyaUw4SWNtelNSc280?=
 =?utf-8?B?OEJsYWxFakZpaHovN3YvVHZiN01lNEMwdnRDcGpYOGZiODlDVTV3R1JHVkt5?=
 =?utf-8?B?em1vM3V0RnR4czVPcUtlTzlNaDNyVjBZd0VhODRMd0FWb1lha1M0akV3UDli?=
 =?utf-8?B?aUtrcm9iRUxrZzJpcmxxaldNYlVJNXBkbDBHNktJZkhSNjg5V1RTdUxMT3ZO?=
 =?utf-8?B?b1FRZzhXRTVKSHI0YVE3ODFIYnNtWTFJZm1rVXJkM3lRNnEvMG9hb0FkdHR2?=
 =?utf-8?B?RnRNZjBEajBaKzV3MEdnSGlhejZtbHBKWXl4b0oxZldiRGY3b3dpV050dWhD?=
 =?utf-8?B?Q2ZaR29JTE81SDZlOFZZbkE5TnY3VUdnaSsxVTEva2lCU2djOVkzNW1zOXF6?=
 =?utf-8?B?TXZDaTB2TmRvVllCR1p2WU13SWMrODI4aTFzQlVzaVRnQnMrbk9VQW5OUjEy?=
 =?utf-8?B?YzZSRHpMVVlsajBwZW1kb0ZiOHRpdDZCQVBoeVBXQ3lRM0NBQndjcmFDY0la?=
 =?utf-8?B?TFFVWUFIMmxUR1BnUUFYakR5OXZVMmtRU21Vc1hDcEthdm5heEEySkY4dW1x?=
 =?utf-8?B?L3NuZ3RGWUdVK0hBeXZnZEVqdk1IcGRVbThOeGJjV3I4UGo5YXRXSThWSHRn?=
 =?utf-8?B?OUNHSkRZRnExWjEzTVpUZmtlemJEZUFWTmJrYjg3Vm9veHBrSUxpR3hWa1NH?=
 =?utf-8?B?bXRzbktiYUtLZDU5WEErVjNxQy9hSnoyblZ3SWIvTzZRaGFrTnZnSENwOVpF?=
 =?utf-8?B?MUNtMWMrOWtwSDZTTEp3elhCWTgwNjByMTlaZm16dS9Hb2lQT1hOTm1HV2I1?=
 =?utf-8?B?aWZQYnk2Rjc4Q2lsekdtZGUybEYzK3prYkhLM2JFWExobmFEL1hvNXRieCtU?=
 =?utf-8?B?ZWJ6eFF0SVMzY3hpM3RKVWRXdEF5MmxpSVNYYmpkb2FIUFU2MDRiSnc0a28v?=
 =?utf-8?B?TThpUDl2NDJQTERjL0VNaUplbStMa0pQdGRBdURNQ3BnR2dBVU05SnpuQnBV?=
 =?utf-8?B?cTNEc2twVWx4OTFBaVUvN0locmRWWU5FZnNNa29HT05HTmpIQjMvU0haSmM2?=
 =?utf-8?B?RzFydkNkWmxtNkpFVnlKck1oRHUzdEc3alZzamVyYlByaHg0bzZnOFpzR2Zj?=
 =?utf-8?B?bVVxWER3Z0Y2ckRWSUtDbGk1S1FCUkk4UlRWbTk5WDN2VFhsQnI5TTJZQ2RW?=
 =?utf-8?B?OUR6d2FQNnhCQXlQVUFuTDArNXo5Ly9tOUFXdjBDS2pKMmQ0NDRQNUo5Y3U0?=
 =?utf-8?B?Ymdma0swOFR0K0J4T01CYTE4TnlPR2FuTGFSOG1GMEFPTzd6MkQxVitJNWhT?=
 =?utf-8?B?NUpldXpRTHE5Y01lMWlsTjh1bDNLRFd3QUhmYWdtblJFcUN1ZFIvVHBYcVJW?=
 =?utf-8?B?QkpBMnNqVmtnYVN2bHVLcThwQU05WmJWOGNVY2k5UXBTdDcvYllHTnpSc1lj?=
 =?utf-8?B?b2kyVEZ3b3hnUjBsOTJmTTVDVWJLL3liYUNIWEZVd2crcVV2dEtPNzhsUFRn?=
 =?utf-8?B?RkNrbmdrQ0ZMWjNXbWZzdE16cWEwNEF5b2xpWDRrWENHbnNFVGRyWUlnQ2U2?=
 =?utf-8?B?ZTF4bWVjMldMZGZwSVhzcDlaOFVxSFQ0SG9sRHpXdzl4b1kyOEg0Q3ZiR3hW?=
 =?utf-8?B?WktuR3ZtWDNWelpkSmNuek53b25tR1JjVENCSUZuRCtmMXVHYTJsYUNxeWp4?=
 =?utf-8?B?M2w2NVc1bENIYUZCekdFQkJiQ1ByTDV6clZrL2FvdFRIT1ZiVHRwVGg4ak1F?=
 =?utf-8?B?bjhjTVhxaHhETEFqMmpmOGJvYnNpdkNWZnMra2w4QWxETkFxVGFlbHdBbmpE?=
 =?utf-8?B?L3Q1T1NCRmlqc1l5NW1JYlBRODhmNzc0TVowaTk3YXBORlVpU0xsR2NZQWlo?=
 =?utf-8?B?L25pbURCZytwcXh0ai9weURLS0IraXhLUWU0NUpNamdRMkNsVVJEeCtYd1Rk?=
 =?utf-8?B?SnF5cWwvRXBPbnQ3bjZJQmZxZlNpRzdnZkc0WmYvRk5RTktKSERXNm1PdHhq?=
 =?utf-8?B?aGY3dzRxUFV2NjFmUThrR29oWHdrWitpczNEVW5DV3d6RGlBVXZVQ2lNUTky?=
 =?utf-8?B?SGtWN2tacW9jbWk2MmM1QStmU1RoWEFDZExTeUY4MDQySnFpUmF5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ac78a8-3f4c-4045-1d1e-08dee9bdc70c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:57:23.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEKmwvQP/bhk/IMheUGvWw4463GlESYMmnRKuWgQNM7iLyw7dpLYCSLx8y8V+d2x3J18QJzk/rcpTeoXclgdCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568

Hi Tejun,

On Fri, Jul 24, 2026 at 09:16:46AM -1000, Tejun Heo wrote:
> Hello,
> 
> Follow-up fixes and enforcement holes plugged from the recent
> sub-scheduler work. The first patch fixes the tools' restart loop
> clobbering an exit that was requested while a restart was pending.
> 
> The rest tighten how cid-addressed operations from sub-schedulers are
> handled when the caller lacks the necessary caps. Reenq to another
> sched's local DSQs is now denied and counted, and a new event counts
> the already-denied kicks. These checks are lockless - transient false
> positives from cap rotation are harmless and false negatives can't
> happen by visibility. cpuperf control moves behind a new SCX_CAP_PERF
> which only the root holds by default, and scx_bpf_cidperf_set() reports
> the result synchronously as its check is authoritative under the
> target's rq lock.

I haven’t found any issues in this series, everything looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> v2: - Kernel-doc comment moved to scx_bpf_cpuperf_set() instead of being
>       left attached to the factored-out helper (0004, reported by
>       sashiko).
>     - The versioned scx_bpf_cidperf_set___v2() interface and the tools
>       compat wrapper are dropped. The cid-form interface is still under
>       initial development, so the signature is changed in place to
>       return s32 (0005).
> 
> v1: https://lore.kernel.org/r/20260724182125.985061-1-tj@kernel.org
> 
>  0001-tools-sched_ext-Don-t-restart-over-a-pending-exit-re.patch
>  0002-sched_ext-Gate-local-DSQ-reenq-on-baseline-cid-acces.patch
>  0003-sched_ext-Count-kicks-denied-for-lacking-baseline-ci.patch
>  0004-sched_ext-Factor-out-scx_cpuperf_set.patch
>  0005-sched_ext-Gate-scx_bpf_cidperf_set-behind-a-new-SCX_.patch
> 
> Based on sched_ext/for-7.3 (c509d8107026).
> 
> The patches are also available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-cap-gates-v2
> 
> diffstat follows. Thanks.
> 
>  kernel/sched/ext/ext.c                   | 139 +++++++++++++++++++++----------
>  kernel/sched/ext/internal.h              |  31 ++++++-
>  tools/sched_ext/include/scx/common.bpf.h |   2 +-
>  tools/sched_ext/scx_central.c            |   2 +-
>  tools/sched_ext/scx_cpu0.c               |   2 +-
>  tools/sched_ext/scx_flatcg.c             |   2 +-
>  tools/sched_ext/scx_pair.c               |   2 +-
>  tools/sched_ext/scx_qmap.bpf.c           |  17 ++--
>  tools/sched_ext/scx_qmap.c               |   2 +-
>  tools/sched_ext/scx_sdt.c                |   2 +-
>  tools/sched_ext/scx_simple.c             |   2 +-
>  tools/sched_ext/scx_userland.c           |  11 +--
>  12 files changed, 149 insertions(+), 65 deletions(-)
> 
> --
> tejun
