Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792734256;
	b=B39tm1KMFA9tguhYo+k75WBMdVWpaL/wYP6lkTl4nSYSKCwYN70WonyyVC1oifk5YufU
	 7j7CjiFjif146b7P7Su47nRnmt901D3oStIdGUT83iGNJcIkRq6QZIR3FUkLoBuYeWYs7
	 iUITneSD1A2IH6GovCx6v2ZYVr/nArU0loC0Wfm6De/+wResxCfCd/zYm2OklAQK7Q3l8
	 4tddHg7YjyMJtOnDzMKC/I7etmBsCENsF0+M1rP4yqM57MqOlu556zgjMWeBEST2kgxWv
	 jh4ztzXCIMJaOiQjlzMna8ieStVCWDGYJd9TTyM74e3w/C0UTR+ccTqHEV3VtF4ZrUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734256;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Mcv+4+g5XB9PvOQyZL3x+dsUB9EkaQEXhZ26OECvUiA=;
	b=Y60D1vjdwR5BoIaJ5lf2DC3WZMUyxA83kG6xAsy6f6wNL2eDOvevieyw8vwclPHsH6aO
	 FBpY5E7y98evQK0SLJwOp9OZGZ6FQNreIwYYWrSrh0JHvYb3kSSW6KMPc9VybEwrmwpTK
	 LKbAHhLy1r4h3iQNTLOjsk3G8+iZiNhjCJlDniJ2RauWi2cQTeNQdiQflms7lQ75d7RCD
	 TQ2oqTHp8+4prNWkJM2b5zZxOsnYcpy+Y9HohgCOnHhtJJRm0LO3/PXQchypKOKzONVnO
	 42rbQfisbiTybuvJ61BcFXJiEmb1jiiZ9GbIiDRkdH9Is6KW+mNDdmZPvRBAHJ/Eu5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dOXI94if;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.32
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03020606A31B
	for <sched-ext@lists.linux.dev>; Fri, 23 Oct 2026 05:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03020606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dOXI94if
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhHMPxg2CxMSJ5zAf9eIlViOorskKO96yunwDDzTVrXTi4pKnkUAwk4fvN5ZFcis8dQ1UFB60POcWPwLOx8AAwl3+39Qw3zoJrqtcxflSquQhNjLGv74k7QZOAmCKARIYEUK0QkfCo/llsKX2kO+PwMqS5QokgsOq3ojIZmy7l77l7kG0i+LEXwuk8MogDRem3pmCCSoKwr7UR2x714WTZh69J2tatPvKG5PDak+1kULdcsENIO3stHFB8YeIxZIBhJ5fAyZtETz+1s0TesvDufigurkbU0uNB+nztolr9OrH904Ml/9EogFlPHrRWAtsp/oaq6jUWIoGLB5Z1wKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mcv+4+g5XB9PvOQyZL3x+dsUB9EkaQEXhZ26OECvUiA=;
 b=AOR3Rao4N8idsDU+AqEwFEpmIMF3GZ4Oxtm6YTXVPEsdf6/ZI/2vvtqR/H7Q6qcgAfbABF3/zZLnou2uuk3/OZmTy++s1mQZqzA3JxNOkWzBYs04CaFseJBEBLD70Tx4wd4l1Y53Jmo/WO/3MYzLjsbffmSVKPP+MdxcGPNHDT43E2rj1f74X0+U0E+GgI1MKd5MbF5WlU6Jvp+i2Umn+OO7iCBUx0KD7c7CIzcQTmMhOG7jUlPk+usG6l5DcowKTg7NS4L1faXBPTV0wAuRHRuk4T7UD3y1wlPcdNxHGBXRT6uOwxDGBhRyZd50xJitvNEjVhMlgg1/E2XtY6eXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mcv+4+g5XB9PvOQyZL3x+dsUB9EkaQEXhZ26OECvUiA=;
 b=dOXI94ifm/62JnRfgKcLpnTMy515n5o3Kwn2dvhpjrbFnNcy9px7h8slHaANEOngpn0fgFJqQ2Z0n89LtAK5AZeQF+PxzrPA7aQj/TGFgQo3AOd0AwNb7rY9hbkpMhf+44x08cHzBDVzeIc4uqkgn05BJK8WoXObj1F0vnlb6gAlFYeP5KxLp2oAUwBtx6HGW+kADwkD7+GR9SIPWxZ+qi8XFycEWJ6kTmu7u2yi3frbaiZuiMBt/LBH4UO+1VpsKIq1owtmiVLdm+j4lB3PvmlTWlB1o+OGiSGKBhAxLAiUpwWsi0l3W+ccDGp5SC0nt0Da26Ku24nNZ6VNqql/CQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DSVPR12MB985431.namprd12.prod.outlook.com (2603:10b6:8:4fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 05:44:12 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 05:44:12 +0000
Date: Fri, 23 Oct 2026 07:44:03 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Regenerate tools autogen enum headers
Message-ID: <atr0I5EF7hmM_m7Y@gpd4>
References: <20261023000348.2726436-1-tj@kernel.org>
 <20261023000348.2726436-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023000348.2726436-2-tj@kernel.org>
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DSVPR12MB985431:EE_
X-MS-Office365-Filtering-Correlation-Id: f373c9b7-02c7-4259-7252-08df30c8aa0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|18002099003|22082099003|261022075727099003|11063799006|56012099006|4143699003|261021123027099003|261009223027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zx+gaBgYHCJPtLXIkQjSIGQyxJYtG6KygOMd7a/cwz9r+EEcfIZgCL9X33t71BCLznFMfaJfYiAE5O1iVg2znLJq2EHjqTxG1a2vUo2Ly9SV8U9pJthvquuP9E6xBxrUxCuQNmHou3/7o3sXxg472RSvo7k4c0ZrZQ6mGPw6fOtDByhFROgY6hcQyX8FKZSlnAJ7+vC6CSA8doUkL/asoRPX396NyokFyPxqc4vl7i9+6Ui3jziZCmTqWdrJREwx4vBr7Z1mGQLbQiZ3TwpvNa3kxiYHQUKsow+huUtIueZCIAoYxGAQ9ojusd/LE767YqZJuf8LGzcPWLaMGhklcQWgTolo1ccGAVVzpMES4NUI4a6fKT0rr/r8HdqbmMHLJG7exdOCP3i5gyV+38OmBItqRy/LL30Rfj3Am4Z3FEEmJeZH+7fLbXton+3Jw/lE99lYCvdsjDy3bcmqAIdCvyGQCDshN7HnJiESyzGQQWGjoA+JkCBg/L96GYIokR2EEv9fDNkWerVXVYblaR/3BH/OfgDb/sI7tSTB6gtATi1Cub5CR6Bn0kUp539riMuPwQcFKlizGK15wIlGr4J9NzihvCRCdVIeWRD8Yv2wF+urYtRME4KSe+Uc4eZ+Im5v88C5zl7j/x9RvO+nifSGZR6fTRTu0er0kLtVY0cJdyI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(261022075727099003)(11063799006)(56012099006)(4143699003)(261021123027099003)(261009223027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HizusZ0NYnVnVvrjBTLu0pnzVVUQmHMF7xOvwLr1NpMcXOBnWKjXzaU1A7aU?=
 =?us-ascii?Q?fbm5PZGA+t4S/Erk4x/mRtYttj1M7JOg3Td8QDgW2pIttbWfas8NXJRT1p1K?=
 =?us-ascii?Q?HvRCmdekyZwGZ2kLIULCpSQpzfsYgDmSpUdAu41TdJ2jl5OQbiKU4X7rqute?=
 =?us-ascii?Q?3fBo5oCHqXElbvNvAib/VjUfUyeG5diwplQD9j/e2j4gwa50MqDpIjlNMLl3?=
 =?us-ascii?Q?6v9Zy3PYRb6HyCnbD6tvTeosl4zeurvyxXX6LolWtsoWdbOAwuljia/B+LXd?=
 =?us-ascii?Q?SY3JCN8BWRsQlOobGcSEndy5G4ViW8se8LHm2sThxnDSh6M21hOjzrCu8gag?=
 =?us-ascii?Q?cnNQ61WSTJt37EesUUWUJGQ00CFlBqaDVtQrMA5SNUP89VhUSUVk5/7e0nAz?=
 =?us-ascii?Q?c2m3tkIV5aLi7fiPpi5lD+fCT/3LF9I/R3y4/qD3pZamYKJT9yK9aJgEbekp?=
 =?us-ascii?Q?iqNGCrRgqp5/CzycWFJmsMoaHe+gBkO47pwvXwlsxQv6wbkeI1xu3rdqNJa+?=
 =?us-ascii?Q?PKM1GHZPZUl4PYatV8myJ9+dMea8SWFSgsM9bvMhFfT82aJV+qsQAnlYmlti?=
 =?us-ascii?Q?TtQLbiCjDQGUtLXZizyhoOKx+CWhf4sM/6Y1YS5zsZXBeNAPBdYXnPQ7vs21?=
 =?us-ascii?Q?vFFizKWN2cVjQhEFtnrVc8GEg1x/7gx2CJKIrztCOZHoHMfPBO8eDpj2CwEi?=
 =?us-ascii?Q?bupCSi7GQbXAjRcSNnwnTGuqaayEGWF5FhubwT+8Os8nxgv/8A9YuSqn9Sip?=
 =?us-ascii?Q?PZl5mISD8mjULqj2SP5nl5nbyt9FCUmmsPKjQPw9GMnRhhBv/FzrVTuffYfX?=
 =?us-ascii?Q?TwfvlkJejK5ZmEm14gyV7QTdqfLpu+jMSCv+usn4XvTbN+I+qwyt9GdMYOQ6?=
 =?us-ascii?Q?pDio31SutBDIAMiuZzqRjPP4n+5ai5yIb1GbBXKKGzAYbtEdUFEGx4yR9nYH?=
 =?us-ascii?Q?X1bZGyoZHjT5JMbMQi0n5ZN/Yn65Y7tBrT2qDLJLabYeujg5ze1sbebhZfGB?=
 =?us-ascii?Q?uXUcg5ZjaeGdzExm4danu6LfAw375GaT0S7dKMXTUIZEYDub5J0QKFQOn5CD?=
 =?us-ascii?Q?wezAevER52uNeyKtL21KM+y/HVLjn0voNSo01QEgjtplgVHCFbqnQaqhi+BE?=
 =?us-ascii?Q?I/RybjNLWb3YNZ4wkj8Qs3io127rON67sPXi8ZYqx3E/2nVR9lVrl818YQhu?=
 =?us-ascii?Q?1f7zqORU77gYcgfRWxv/gh3QO+bxOgd/9Ui34wnsdItolYGV4Kzv6wZSH1HV?=
 =?us-ascii?Q?meKuURt6SajAlw06+ptAkX1Mo3lQ4heeT5tEXQ2cK9oj4WkkR4kSIEGAKar0?=
 =?us-ascii?Q?HRVuqrJE+63rK0VBX6fpCm3+cxORKoxL8wAHl0W0fHZrMYYNyZRXBB7mLUjq?=
 =?us-ascii?Q?dmajI8u8bRMmyM06K4yr6nIBOijQKBDc4jUb+QAECXjYwPItxqXYM3G8rgnV?=
 =?us-ascii?Q?+O5XVYJ2qobX7D40hsy52imeDMYuYNbtoKQS9isqJmH8WxQLUonu9nyrpmpO?=
 =?us-ascii?Q?jJ1bY81r4IlvFOgoXu1jFTLFEpcpZ+4rcx7acBh4wNx5v46pQwWp3JdPvzV7?=
 =?us-ascii?Q?yndYfR6pRID48cGCAiXk0KrooMG4UD+80Y1agC3FVVmgG2/PhS2s5EQGCjmY?=
 =?us-ascii?Q?688p2B/6kHfiqKZStVtDLN72wJPWbDIxo8cmemt6Nuv6E+w3L3asp3d7dR52?=
 =?us-ascii?Q?SDj0sQjvX70KeQwdjyGzb2lsYSPbqWrHdzUxURDyqdFJAvuz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f373c9b7-02c7-4259-7252-08df30c8aa0e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 05:44:11.9173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+KkxMpA5yRx3gx40sMwezAKbSNdQgRCWWjCWkqJmOYO+89XbqBNDe97823F2A6pGXnvIy15VDaZTs8WpeBFXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB985431

Hi Tejun,

On Thu, Oct 22, 2026 at 02:03:47PM -1000, Tejun Heo wrote:
> Regenerate enum_defs.autogen.h and enums_abi.autogen.h from the current
> vmlinux.h. The enums added since the last regeneration lacked presence
> markers and ABI values.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Not a blocker, but while looking at this I noticed that enums.autogen.h
(and the .bpf.h counterpart) still carries a few entries that no longer
exist in the kernel:

  SCX_RQ_BAL_PENDING
  SCX_RQ_BAL_KEEP
  SCX_RQ_BYPASSING
  SCX_RQ_IN_BALANCE
  SCX_TASK_NR_STATES

They're harmless, but I think we can drop them, maybe as a follow-up
change.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  .../sched_ext/include/scx/enum_defs.autogen.h | 11 ++++++++++
>  .../sched_ext/include/scx/enums_abi.autogen.h | 21 ++++++++++++++-----
>  2 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
> index 4fa82033b99c..27b45040c88a 100644
> --- a/tools/sched_ext/include/scx/enum_defs.autogen.h
> +++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
> @@ -23,6 +23,8 @@
>  #define HAVE_SCX_CAPS_REENQ_ON_LOSS
>  #define HAVE_SCX_CID_SHARD_SIZE_DFL
>  #define HAVE_SCX_CID_SHARD_MAX_CPUS
> +#define HAVE_SCX_CID_SCHED_NONE
> +#define HAVE_SCX_CID_SCHED_SELF
>  #define HAVE_SCX_DSP_DFL_MAX_BATCH
>  #define HAVE_SCX_DSP_MAX_LOOPS
>  #define HAVE_SCX_WATCHDOG_MAX_TIMEOUT
> @@ -71,6 +73,7 @@
>  #define HAVE_SCX_DSQ_LOCAL_ON
>  #define HAVE_SCX_DSQ_LOCAL_CPU_MASK
>  #define HAVE_SCX_DSQ_ITER_REV
> +#define HAVE___SCX_DSQ_ITER_HAS_REENQ
>  #define HAVE___SCX_DSQ_ITER_HAS_SLICE
>  #define HAVE___SCX_DSQ_ITER_HAS_VTIME
>  #define HAVE___SCX_DSQ_ITER_USER_FLAGS
> @@ -100,6 +103,7 @@
>  #define HAVE_SCX_ENQ_APPLY_SLICE
>  #define HAVE_SCX_ENQ_SLICE_DFL
>  #define HAVE_SCX_TASK_DSQ_ON_PRIQ
> +#define HAVE_SCX_TASK_DSQ_REENQ
>  #define HAVE_SCX_TASK_QUEUED
>  #define HAVE_SCX_TASK_IN_CUSTODY
>  #define HAVE_SCX_TASK_RESET_RUNNABLE_AT
> @@ -188,6 +192,7 @@
>  #define HAVE_SCX_SLICE_INF
>  #define HAVE_SCX_REENQ_ANY
>  #define HAVE_SCX_REENQ_CAP_REVOKE
> +#define HAVE_SCX_REENQ_MARKED
>  #define HAVE___SCX_REENQ_FILTER_MASK
>  #define HAVE___SCX_REENQ_USER_MASK
>  #define HAVE_SCX_REENQ_TSR_RQ_OPEN
> @@ -195,15 +200,21 @@
>  #define HAVE___SCX_REENQ_TSR_MASK
>  #define HAVE_SCX_RQ_ONLINE
>  #define HAVE_SCX_RQ_CAN_STOP_TICK
> +#define HAVE_SCX_RQ_OPS_ONLINE
>  #define HAVE_SCX_RQ_CLK_VALID
>  #define HAVE_SCX_RQ_BAL_CB_PENDING
>  #define HAVE_SCX_RQ_SUB_IDLE_RENOTIFY
>  #define HAVE_SCX_RQ_ROOT_IDLE_RENOTIFY
>  #define HAVE_SCX_RQ_PROXY_RETRY
>  #define HAVE_SCX_RQ_PROXY_TICK
> +#define HAVE_SCX_RQ_PROXY_PENDING
> +#define HAVE_SCX_RQ_PROXY_BLOCKING
>  #define HAVE_SCX_RQ_IN_WAKEUP
>  #define HAVE_SCX_RQ_IN_DISPATCH
>  #define HAVE_SCX_SCHED_PCPU_BYPASSING
> +#define HAVE_SCX_SCHED_PCPU_ECAPS_ENABLED
> +#define HAVE_SCX_SCHED_PCPU_ECAPS_REPORT
> +#define HAVE_SCX_SCHED_PCPU_ECAPS_OFFLINE
>  #define HAVE_SCX_SLICE_OOB_DUR_BITS
>  #define HAVE_SCX_SLICE_OOB_ID_BITS
>  #define HAVE_SCX_SLICE_OOB_DUR_MASK
> diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
> index 1186daa9cb14..5cf54dcf5ffe 100644
> --- a/tools/sched_ext/include/scx/enums_abi.autogen.h
> +++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
> @@ -35,6 +35,8 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
>  	{ "scx_cap_flags", "SCX_CAPS_REENQ_ON_LOSS", 0x3LLU },
>  	{ "scx_cid_consts", "SCX_CID_SHARD_SIZE_DFL", 0x18LLU },
>  	{ "scx_cid_consts", "SCX_CID_SHARD_MAX_CPUS", 0x200LLU },
> +	{ "scx_cid_sched_consts", "SCX_CID_SCHED_NONE", 0xfffffffffffffffeLLU },
> +	{ "scx_cid_sched_consts", "SCX_CID_SCHED_SELF", 0xffffffffffffffffLLU },
>  	{ "scx_consts", "SCX_DSP_DFL_MAX_BATCH", 0x20LLU },
>  	{ "scx_consts", "SCX_DSP_MAX_LOOPS", 0x20LLU },
>  	{ "scx_consts", "SCX_WATCHDOG_MAX_TIMEOUT", 0x7530LLU },
> @@ -83,10 +85,11 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
>  	{ "scx_dsq_id_flags", "SCX_DSQ_LOCAL_ON", 0xc000000000000000LLU },
>  	{ "scx_dsq_id_flags", "SCX_DSQ_LOCAL_CPU_MASK", 0xffffffffLLU },
>  	{ "scx_dsq_iter_flags", "SCX_DSQ_ITER_REV", 0x10000LLU },
> +	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_HAS_REENQ", 0x20000000LLU },
>  	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_HAS_SLICE", 0x40000000LLU },
>  	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_HAS_VTIME", 0x80000000LLU },
>  	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_USER_FLAGS", 0x10000LLU },
> -	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_ALL_FLAGS", 0xc0010000LLU },
> +	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_ALL_FLAGS", 0xe0010000LLU },
>  	{ "scx_dsq_lnode_flags", "SCX_DSQ_LNODE_ITER_CURSOR", 0x1LLU },
>  	{ "scx_dsq_lnode_flags", "__SCX_DSQ_LNODE_PRIV_SHIFT", 0x10LLU },
>  	{ "scx_enable_state", "SCX_ENABLING", 0x0LLU },
> @@ -112,6 +115,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
>  	{ "scx_enq_flags", "SCX_ENQ_APPLY_SLICE", 0x2000000000000000LLU },
>  	{ "scx_enq_flags", "SCX_ENQ_SLICE_DFL", 0x4000000000000000LLU },
>  	{ "scx_ent_dsq_flags", "SCX_TASK_DSQ_ON_PRIQ", 0x1LLU },
> +	{ "scx_ent_dsq_flags", "SCX_TASK_DSQ_REENQ", 0x2LLU },
>  	{ "scx_ent_flags", "SCX_TASK_QUEUED", 0x1LLU },
>  	{ "scx_ent_flags", "SCX_TASK_IN_CUSTODY", 0x2LLU },
>  	{ "scx_ent_flags", "SCX_TASK_RESET_RUNNABLE_AT", 0x4LLU },
> @@ -169,10 +173,10 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
>  	{ "scx_kick_flags", "SCX_KICK_ALL_FLAGS", 0xfLLU },
>  	{ "scx_opi", "SCX_OPI_BEGIN", 0x0LLU },
>  	{ "scx_opi", "SCX_OPI_NORMAL_BEGIN", 0x0LLU },
> -	{ "scx_opi", "SCX_OPI_NORMAL_END", 0x21LLU },
> -	{ "scx_opi", "SCX_OPI_CPU_HOTPLUG_BEGIN", 0x21LLU },
> -	{ "scx_opi", "SCX_OPI_CPU_HOTPLUG_END", 0x23LLU },
> -	{ "scx_opi", "SCX_OPI_END", 0x23LLU },
> +	{ "scx_opi", "SCX_OPI_NORMAL_END", 0x23LLU },
> +	{ "scx_opi", "SCX_OPI_CPU_HOTPLUG_BEGIN", 0x23LLU },
> +	{ "scx_opi", "SCX_OPI_CPU_HOTPLUG_END", 0x25LLU },
> +	{ "scx_opi", "SCX_OPI_END", 0x25LLU },
>  	{ "scx_ops_flags", "SCX_OPS_KEEP_BUILTIN_IDLE", 0x1LLU },
>  	{ "scx_ops_flags", "SCX_OPS_ENQ_LAST", 0x2LLU },
>  	{ "scx_ops_flags", "SCX_OPS_ENQ_EXITING", 0x4LLU },
> @@ -200,6 +204,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
>  	{ "scx_public_consts", "SCX_SLICE_INF", 0xffffffffffffffffLLU },
>  	{ "scx_reenq_flags", "SCX_REENQ_ANY", 0x1LLU },
>  	{ "scx_reenq_flags", "SCX_REENQ_CAP_REVOKE", 0x2LLU },
> +	{ "scx_reenq_flags", "SCX_REENQ_MARKED", 0x4LLU },
>  	{ "scx_reenq_flags", "__SCX_REENQ_FILTER_MASK", 0xffffLLU },
>  	{ "scx_reenq_flags", "__SCX_REENQ_USER_MASK", 0x1LLU },
>  	{ "scx_reenq_flags", "SCX_REENQ_TSR_RQ_OPEN", 0x100000000LLU },
> @@ -207,15 +212,21 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
>  	{ "scx_reenq_flags", "__SCX_REENQ_TSR_MASK", 0xf00000000LLU },
>  	{ "scx_rq_flags", "SCX_RQ_ONLINE", 0x1LLU },
>  	{ "scx_rq_flags", "SCX_RQ_CAN_STOP_TICK", 0x2LLU },
> +	{ "scx_rq_flags", "SCX_RQ_OPS_ONLINE", 0x4LLU },
>  	{ "scx_rq_flags", "SCX_RQ_CLK_VALID", 0x20LLU },
>  	{ "scx_rq_flags", "SCX_RQ_BAL_CB_PENDING", 0x40LLU },
>  	{ "scx_rq_flags", "SCX_RQ_SUB_IDLE_RENOTIFY", 0x80LLU },
>  	{ "scx_rq_flags", "SCX_RQ_ROOT_IDLE_RENOTIFY", 0x100LLU },
>  	{ "scx_rq_flags", "SCX_RQ_PROXY_RETRY", 0x200LLU },
>  	{ "scx_rq_flags", "SCX_RQ_PROXY_TICK", 0x400LLU },
> +	{ "scx_rq_flags", "SCX_RQ_PROXY_PENDING", 0x800LLU },
> +	{ "scx_rq_flags", "SCX_RQ_PROXY_BLOCKING", 0x1000LLU },
>  	{ "scx_rq_flags", "SCX_RQ_IN_WAKEUP", 0x10000LLU },
>  	{ "scx_rq_flags", "SCX_RQ_IN_DISPATCH", 0x20000LLU },
>  	{ "scx_sched_pcpu_flags", "SCX_SCHED_PCPU_BYPASSING", 0x1LLU },
> +	{ "scx_sched_pcpu_flags", "SCX_SCHED_PCPU_ECAPS_ENABLED", 0x2LLU },
> +	{ "scx_sched_pcpu_flags", "SCX_SCHED_PCPU_ECAPS_REPORT", 0x4LLU },
> +	{ "scx_sched_pcpu_flags", "SCX_SCHED_PCPU_ECAPS_OFFLINE", 0x8LLU },
>  	{ "scx_slice_oob_consts", "SCX_SLICE_OOB_DUR_BITS", 0x2bLLU },
>  	{ "scx_slice_oob_consts", "SCX_SLICE_OOB_ID_BITS", 0x14LLU },
>  	{ "scx_slice_oob_consts", "SCX_SLICE_OOB_DUR_MASK", 0x7ffffffffffLLU },
> -- 
> 2.56.0
> 
