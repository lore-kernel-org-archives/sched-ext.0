Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795011657;
	b=sqtX6ORezyyXQFA/VP/T7yBPzr7LU/4+grOyKxghHPpTeSamzvk/xGXbgci8oJonsLM4
	 4H0aeS5qTMKipAWixzO5XEqs2y7ZsXyPIwwp8XnG3qiNpu1/rkCz75uqPH16/ZTmlukzy
	 Hglb3sGXaxc1QTgJJQFznEMC5bIR10UCgPiGe3kHetJVkEGozWgKcHVrAW1JOZhvqa5+n
	 QPiijWhXbh/CxOhblJhoB4E1ub+rZNC6afladuY3rXDtTwQq0kk5hHPvPX0rnc1MNSpGZ
	 zoRcqUHY95htaTrFNWhSRPljyUrJYTHbwMUq1rxT0jjotJvjXUl8vNviUHGN9wfYjpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011657;
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
	bh=m5s+JDioHhNUj6WIauuvxxjWFB2cQEmZwHCv7o0M+pM=;
	b=lBeQtaXuUMqsi+JvAF8t8Jro/Rit9rvTVIxmX+nrTro/uPaflSbTzOuRp3oxJEb27aMI
	 jH3/ehozuzYeyjxqu7Kw5bJmmC6Vuv2/+xvnHLWx4Vv62gD01fUMcYfXNHNJJYEEEF/Zm
	 sgvq0l0KxQhE3XP95yp7f1px/lFRRGyi8AN2t/wryla/QKTYtsuqqPlumddYv5062qv/x
	 29jvYGkCy+2wIlL5FhTk1OYLYniD4Vi7W+eQfekISDur5mcniAxubm6Hue0lm+jryBj8i
	 DDLKEYmN860zKuALumDJ3vAHMAYhMA4kAQN3y53O6HoNzR+88wpLI+A7JGsNiiWzq8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fMQSC3Mi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.23
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F250606A337
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 14:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F250606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fMQSC3Mi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvew2pcQWtgoYLSXE/gFIl4GIhMhUOmqEaGO5yWQx3iXWg6mCw5sHjPfILFNLd1MLXrABW9omr4I4TNeMiiOK5MtB55JAoKoZtW98LxDOynFquQIQve08Dpf8SzNU5ND2FVSuf8bNnYfikzAXENbhUQsetPFeJZEibc2Se2kFkIXbqXLMudQ9E1dWPcd3uSHHTjuDy0TUqoQPQSY3Dy2ko7BTKx0ibL8n1Pu+40nlmGBX7q/UUoo4Bw7ulBxWiY6VUMFmTD9IBezIH6bELqA7HEOP1AlwuIDr6dAWOhLI+AXNaJ5nddDq/D4rsWj+ZbGLvi3LRH5NcyHgFtPJ+8KKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5s+JDioHhNUj6WIauuvxxjWFB2cQEmZwHCv7o0M+pM=;
 b=U61IpsMwIaqQrlIAXgTOuERjglzrUhX9SpLWAlx2hPLVGEN1b8Q1nMxsU/ZogfDEKrYb2IxhwWbYEQ6GbWYT0p8XRrQQTgeAluVHI+vSEDjUGPuvcD+hgHVmfD0J/B+Znxyv/VwRMhfPthvOQHp0r5Hy1GNujLjiJ3v13yMzJbwDdCQps8V6XT8kQywiKVYqxHPw4+057pM1nnVMyaEZkCz74dHhkbIAliwlUWUZdQFVpqHX1DGvnuq5xwdT2DV0fXwKwNWihv8vjNtXgfD7UEMxQbvy258B7K3aqzgdr0mTiqyh3kSc7A4ySp4iswRNyxvrfdnbRP0ks5gU1k6Ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5s+JDioHhNUj6WIauuvxxjWFB2cQEmZwHCv7o0M+pM=;
 b=fMQSC3Mi2wvzcYSMSKUOJgh7Ks7j9Y5HIdLzx9TVQm7NF3G3AwFMfyBpfrVDOxrN3bSuzTqa2lIIfZtcXtrCSEdqQxh3ox31ZzrhvuaD9hR+Uk1g7XwEBiMcZnpF4jdn3NiTJPslt17FAuX9Agltd2selJuHsfCnCCVLxrqekCDeGMKfL1blhVYTxymIwam2BBqB14ePb8UWra6ME2czDle73Nr0aIfdMCZWTqLdEmnad95OQ3kKOKAlllTkPC2knHnF8XpxyiJXsG0XJEhZhI+kCdrJ+W31pSfUucxnTPzGT4mh/8/ZtM6YjE2k0oRiBy4sWOYzOr3ud1sdvUysVQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 14:20:52 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 14:20:51 +0000
Date: Wed, 18 Nov 2026 15:20:44 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Don't route tasks to
 SCX before __scx_enabled is fully patched
Message-ID: <av20PBaLcuPwDf_l@gpd4>
References: <20261118102453.1315267-1-jpiecuch@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118102453.1315267-1-jpiecuch@google.com>
X-ClientProxiedBy: MI3PEPF00007544.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cf) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0d0990-c606-4476-24a0-08df457f2646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261021123027099003|10067099003|261022075727099003|5023799004|56012099006|11063799006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	C0+euruo811qJJflAQz3eZXBhTtetxwdXy3wRiuUFuGB4PigQpaZRTsoudglA9jf+VnitOjBQu/+EbWn/Ql0NKx01qNDCsRTXxhRshJEz8xRnBVs90P2TpOU2zbD1mT42vui1H3SgHwMeGglGWy0Yjo9K0x/QdGYGED/rFtwqUB79i1rVCFJSU+FuoZcTBFVWqebiBiMBFD8OGdJ3ZbZrhGS3LTG00PQnTztZC16YWg6gnoWAFVhkFXkIAY7NBeziWxvD3Smqc9C4EY9LHm8eTUMjHGq1CBon3mSGUetGCl1ZLeyF4Mqcl1jXDe8nwcA2f1feSeRZwyv7qq5WnSX+8om6Ugtva4ImFwtSBYCWbNacWVScJlnULHr71UBVBXd4hkVN1M9A4OeFgDbPyxKlC95Y4SqEFC0KKgpuYZ53pllo8fd+SH9mHAJ7uqupZaM8aADnpWa/FB1lDB2OO7I8VV9AtreBTz/19vvR8tFIgvmu9h+UffpPuyPRCOjonyZQV/dgn2epw8lZTm2nOzsoZywK2p+2F1fP9D0y2rynzbySuxofTWBCQuGDi+zB3gKSruuXafFEKPszG4zEcNq+tr+37S0B2yqcHALlvBoEjaKhqhLYWHRYMNRYGL1oYPj2XXyaG/cm5Mz6TApsbWpO4+Jgfhr9ZrzrlJIvAcwCJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261021123027099003)(10067099003)(261022075727099003)(5023799004)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AyoocBPS5+ksUE3po0Tek6pfiTdnwxKkt6ZLAqvVnO42WZn2tuTKd0nACFVH?=
 =?us-ascii?Q?lyDV+vw0kEoM3CX7dum9q60J6Sh/MGkBorW6321EdTS6lUu6zfukl1VAc6gp?=
 =?us-ascii?Q?Sd6VXaR5KP9bSVvUdbYEvFmI5c0FNofy4onR4LJy/fwlGz7VbWiznktN+IhP?=
 =?us-ascii?Q?E5j1uBosRQzHZ/nNUsIffyF2hp62V5CJZR+hXxfVWrIqRih3qNudcrdFFMbr?=
 =?us-ascii?Q?4T+ciA942/ZI7yQ0rJMs+rk6IGSn2z6Z2/Fm+XLMGjDnrYL7P7taOKhDIfWE?=
 =?us-ascii?Q?PZZV3athWah1RQf6zuY249hO2+jkfHNhf5R4TQQ2p5bdVCHlQabjziBup6VK?=
 =?us-ascii?Q?RwrOUJ56dHx3raEMXch/WNMQi8O3t9UCi4XcleuKMdt4yyQT67A8gp7kuck5?=
 =?us-ascii?Q?YG3+d+cBj4dYiN8orxs2AwdCnPhQgEgzBmIkIlrcY295TMgOdxUA5kd6LUsR?=
 =?us-ascii?Q?UOIjXgYt7+PJ0p6w/CCpuHr8SDcT1gRgDnA0Y9Nut6HN3dvEvnbCYN4LLm6c?=
 =?us-ascii?Q?w/+1r/w+aS2Zb1mT2fuHdgtpyfwymCUo856/rjvQQewVRx0KTI4UoTWmrycx?=
 =?us-ascii?Q?/wqLt6ExPLmEAaHe2ZsFUSwnpa4XevyVOz/cArx4E+YVr7ON5CSJms/vGtpn?=
 =?us-ascii?Q?naxsjyqAh4G+s2a6pTE7rmtLm7phV31rQy1EdKcBy3Viet5fx/XcNfaV/Dmh?=
 =?us-ascii?Q?iQvkeqVmTpTA/JMSKbPRVHBKYvaYHrGXAbJEYwbjhP3Q2tTe25ZOp+buetq+?=
 =?us-ascii?Q?NY6tsWM3RG/Mz4ya1tFo0lSqFOWnfdrLag6nt2JywJsEBZMS4HV2MFPKm867?=
 =?us-ascii?Q?RP7SUPdqMsBTyWuK8rUBn/NCvMgyGI4O07wU41Pl2IYvmlpTNVgULi0jHF+7?=
 =?us-ascii?Q?DI436Hfui9hhdOl6Oez3vZVyqQNx/8ECfAUmCrPcVzrrZZstxBvpAm/MTIqW?=
 =?us-ascii?Q?BXghmvExmkH4b9jRdx4MjpN6L6MqGiorlZwFNng1Le9Tjftco5HcuzRznnBF?=
 =?us-ascii?Q?thO4Nmdymco5vKOdN4W5HY1HJkAqa+Yc+07L21KUgPk+KwcFouRFHj/4kU0K?=
 =?us-ascii?Q?33Jq67RLmW3qkGq0+6EveqLtaMuPTJO7IT7h6ADPa/h6dR3h9TQGHGw2QRWd?=
 =?us-ascii?Q?dJyVWo1yUCvGIF4TaNafjepvxK8FOlAOXPxnLWKM+N4L5OjCn6o46FXtGmVb?=
 =?us-ascii?Q?QIVPKSdQW6a4aaXRZV2uCQkrWghHudK8Lr7Ky31Th16adtSiWq1llKUcXQtl?=
 =?us-ascii?Q?w2d5PKpDAZGOBRFHRuQoH+XhJ/fuQnbdMhkpZXH+0ZFAcTc3g/sZvrnLdT8x?=
 =?us-ascii?Q?/o8saNaLk9N1GYzkFKEv7+Gq/O9VW7k9ZwqsV7ME9kSd8CEePedA4soZUhsh?=
 =?us-ascii?Q?WSrqp/tQFnB6gMc8QbkWI2ODI5DoUFtQ9Gpe83y7BzKaHlG6F8n/YuIydAzP?=
 =?us-ascii?Q?4R13noeHD7RDDzW8QI11pMuuUXgqOCPqV2/0NFzacNZC9SU03WEdfAla1O8y?=
 =?us-ascii?Q?X91abfsbobehoXnSwalTFNgwYdK8DkblkGSw0P16z30PWZAa1QIgXcYFPCgW?=
 =?us-ascii?Q?zVr0BrngQsMAHCs0K4j4p78SZrpXDLppxP30PirnT5Tzis4Ag8JbUEDtobCu?=
 =?us-ascii?Q?KyrwyjM9oo/k2QiH7p6FN+1K36py6hMeKt6PHOcNeEAnlxTzCqOdfjD5ow7r?=
 =?us-ascii?Q?vbcYTeHAc9aF2LCjf2dsPP9Mj6jPI9DFfT6M07GnsXnMZXEp8EActQ7kHcqx?=
 =?us-ascii?Q?nLWkQjblXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0d0990-c606-4476-24a0-08df457f2646
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 14:20:51.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cK22pgM0PO0nbZ0B7c4ttbeHQRbtwpihV+OB7FDaXO49EzJVDRscUbGfuu+GIHy0shle/f0G0Vv6KW20VnWaKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030

Hi Kuba,

On Wed, Nov 18, 2026 at 10:24:52AM +0000, Kuba Piecuch wrote:
> scx_root_enable_workfn() sets scx_switching_all and calls
> static_branch_enable(&__scx_enabled) before switching tasks, and
> task_should_scx() gates only on scx_enabled(). static_branch_enable()
> patches jump-label sites in address order rather than atomically:
> task_should_scx() may be patched before __schedule().
> 
> If a concurrent fork or sched_setscheduler() runs in that window,
> task_should_scx() observes scx_enabled() and moves the running task
> from fair_sched_class to ext_sched_class, setting need_resched on the
> class degradation. The following __schedule() can still observe
> !scx_enabled() in next_active_class(), skip ext_sched_class, and pick
> rq->idle while the runnable SCX task is still rq->donor:
> 
>   WARNING: kernel/sched/ext/ext.c:3840 at put_prev_task_scx+0x405/0x7a0
>   Sched_ext: enq_select_cpu (enabling+all), task: runnable_at=+0ms
>   Call Trace:
>    __schedule+0x5cc/0x1100
>    preempt_schedule_common+0x12/0x40
>    preempt_schedule_thunk+0x16/0x40
>    __sched_setscheduler+0x8d8/0x920
> 
> Gate task_should_scx() on a scx_task_switch_enabled flag that is set with
> release semantics only after static_branch_enable(&__scx_enabled) has
> finished patching all call sites and scx_switching_all is updated, and
> cleared on disable alongside scx_switching_all.
> 
> This bug was found and the patch was written with the help of an AI
> coding assistant.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>

Looks good, good catch.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 10de6bd865e8..e8c30a21e03e 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -134,6 +134,7 @@ DEFINE_PERCPU_RWSEM(scx_fork_rwsem);
>  static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
>  static DEFINE_RAW_SPINLOCK(scx_bypass_lock);
>  static bool scx_init_task_enabled;
> +static bool scx_task_switch_enabled;
>  static bool scx_switching_all;
>  DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
>  static DEFINE_STATIC_KEY_FALSE(__scx_tid_to_task_enabled);
> @@ -6493,6 +6494,15 @@ bool task_should_scx(int policy)
>  	if (!scx_enabled())
>  		return false;
>  
> +	/*
> +	 * static_branch_enable(&__scx_enabled) patches call sites one by one.
> +	 * Wait until all sites are patched before routing tasks to SCX, so
> +	 * __schedule() never sees !scx_enabled() when a task is on SCX. Pairs
> +	 * with smp_store_release() in scx_root_enable_workfn().
> +	 */
> +	if (unlikely(!smp_load_acquire(&scx_task_switch_enabled)))
> +		return false;
> +
>  	/* scx is taking over all SCHED_OTHER and SCHED_EXT tasks */
>  	if (READ_ONCE(scx_switching_all))
>  		return true;
> @@ -7568,6 +7578,7 @@ static void scx_root_disable(struct scx_sched *sch)
>  
>  	static_branch_disable(&__scx_switched_all);
>  	WRITE_ONCE(scx_switching_all, false);
> +	WRITE_ONCE(scx_task_switch_enabled, false);
>  
>  	/*
>  	 * Shut down cgroup support before tasks so that the cgroup attach and
> @@ -8965,11 +8976,14 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  	percpu_up_write(&scx_fork_rwsem);
>  
>  	/*
> -	 * All tasks are READY. It's safe to turn on scx_enabled() and switch
> -	 * all eligible tasks.
> +	 * All tasks are READY. Finish patching all scx_enabled() sites before
> +	 * opening task_should_scx() and switching eligible tasks.
>  	 */
> -	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
> +	WARN_ON_ONCE(scx_task_switch_enabled);
>  	static_branch_enable(&__scx_enabled);
> +	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
> +	/* pairs with smp_load_acquire() in task_should_scx() */
> +	smp_store_release(&scx_task_switch_enabled, true);
>  
>  	/*
>  	 * We're fully committed and can't fail. The task READY -> ENABLED
> 
> base-commit: 700a332c3fe33014bbd5ae852d71ba679fc29e0a
> -- 
> 2.56.0.679.gc527c65306-goog
> 
