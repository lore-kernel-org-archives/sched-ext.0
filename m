Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD2244661
	for <sched-ext@lists.linux.dev>; Sat,  7 Mar 2026 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772923027; cv=fail; b=BsExOqGCuXDXMSE8xVHslTwqA8sGeTIFUCAe+zWzETrCmRJHi9DuCMs2i1mlfGx7MUFuN/3cBqqcHE9YvzNTC8eSIZENWmb0ES079ZWcUkbnGJLarQsZnj4aRfBWATAnZCCadAb+2/WGCeABlY4M2pjuqt3Zrqj+rqGEZAAXCyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772923027; c=relaxed/simple;
	bh=RqOD/JadoznMX7/twbP2YFxrly4vLt3RZhi/utCRvHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mS/7+YF3dE111GbmD4CfPEWeMR0jWu5wiy0Q1iAigvXDTdk0kfV0HovsfuiSVoILQXQm6adVNl4OO7Ska3ETkmyiWK8SO8I9k541WqttmtlujNv/UHA/aaxWS0vV4kmDb4gLhlpsnu3+g5X4VoZlVlXKupE8+4IsWmsTmyvlHJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RawOCE3P; arc=fail smtp.client-ip=40.107.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RawOCE3P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy0UaIixxgpLO27BZHAeqlyrohQYCOKYT+hXFjnLAWo2z0ohyGRHm45JPKrxfMlbyqXwqnLJ1tU87hDGxVGcBca4MDUuxnsmOMeWNUxvRq+rqXG+KAMOrzD8gx0Ok+rBrJ/rqREBhv9NOoFt3kzSkXg9MS1JkslUWyDLZgeJRRYdoZdPMO4frDvKKGpEn6jFBW7iziSbr9XKfeEx9sw6WeR1kQ8lt/QG7DFtc8nWW+g3+dJPkcl1e6UQ0Kd3FLh5Ji0E7XOk/JE1K4UhwDH1ncyRMC1vnRuvjufJO30bKlMi7CU8daf6CJ66er/c7NntBDpT2/DYtlLGzHjRuB+L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmTJ+PyDpYYwi1v6g2U43IOwV7s6NYBsGHhD26waris=;
 b=y/gjDjmLDPc68UABERFRwl+soeUSAHbK0z6TkzriN9xtvNmC2cAhaA2IgST47nM7bjCkGj6Txh1TpU294h6ihLSx4BCJPDbp95hcCeTTrepgsEHGQSkMyFoAmYh31BbqBvCbSmja+WXqzNVoFQuzUUHLehUrB5lCeJThU04klusfbadzt3hx0Xegg3Iw5MVQBdyAEndl0sjwgTB/zTgXGaA9fVmqeHPN4Aw25eyhVwGSj4ragFx2tmM0+JqyU4dk1ilZw9L+fjGTPazH27ntvfPAnejg22l+ZUVCbQBN9PwV0fwBcrPmJsZuk4+e4tdVuH0RrNURLwQwAypbmVEg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmTJ+PyDpYYwi1v6g2U43IOwV7s6NYBsGHhD26waris=;
 b=RawOCE3Pcdi9qjLbMxNSw6pPWYKC00G/RPjQN9E6GSSuYaOtN2FSOz3u9A2K2uB/+/v8FWwHz57K+VALl3a/7/7IpwuRirYkrYoPENbohC/WdfYiCzxZkBfRrTj62CvebcOJEn2GpxPn6GPAfjpagOPGvaFpyvdhx95Oab5hCQku7jtTJZ5JYnCuN+ihFYJp/aB4qKLkUQwfPUdmfprsAzM3hZx6TR1DwUtGzGygwkZ0O3ZAxp+kCAvNFL45xvizbeLaJdjWfYeTMT2qVEzxK+zCCzLJKrvGeI3CmL6UalZL+RxKgzpzahmV7es7vFNNO8s5rz4x+zp5IONJsTEtXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Sat, 7 Mar
 2026 22:37:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Sat, 7 Mar 2026
 22:37:00 +0000
Date: Sat, 7 Mar 2026 23:36:46 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1] sched_ext: Implement SCX_ENQ_IMMED
Message-ID: <aayofhyFFX9jng1h@gpd4>
References: <20260307002817.1298341-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307002817.1298341-1-tj@kernel.org>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 7425d545-f9e2-490c-4819-08de7c9a0bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	ab0wi7HFX+1y362c5J19AXEWXNINZRGHsCx8le6fTwLB1KyKlBl2xW4vZ7egfNVrX/aCrpvoCjZUhrsX7NtVbRc1lEDM/R+uKPZcwyotx9LaCurFf9J2cPfIm4QeAjpqAEZCdDocbwJ79fXVv7emMfY18VaGIQX/21YLQK8oIArH/fNdK4BNARkPhNMJZHf9L57kk/r/KUgTuOfcZBKt+eChb3i7y6YtzgijSNhONH4zhOmcfx6q4rmKsH2tqGeo7DrLu6V5AcEAt6nQG+nKXCtLGNKe38N11krPHWoUjxCVm/37UYU1nkOtLHpA4uBBMCdSFDpH/xcDcSvEdn3gIslBrXARRC4mAPznNYdnszXZCEWGhfWFYXkGP9+AQXq0492Mw5mk26eoF/74Jj6dNbQwdE1FKY8ToMx43xIhOpTg++qX+rUcAnRIs7ICZprXx6Wy2EtVO89D983g6e+oYaiVOCGyjTG4anEtus6J+twCysKh1tUM4LqxvFj9aLSCNoGqyYCm9OuKmmjFAUjxoi4aO7IsHu/afM91T2qOFG7VIDesuyUKHSLU5CUU9BAC/EOGZzq2FSV9cUCmR+wTL6Ba52+dqki6uI44fEqsxzCzKGV43doxKabU704kZo564Hx4FXnRyHoMKPF1SznNv9D/NGJKOJLxfaYN3VGlVa+FpSgXdawz2xnLWm8WfzTCoot1SXvUTEvQnJQQ+4cpkcIZB7w1udvjxdBRVkOadLU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HGz8E7v1NF7BoJnOrnUDoQgTSkyNxcp0BNKt51qbpvCgSYxJ6vze5c3E55bF?=
 =?us-ascii?Q?QyS6px6BWLcJBqLrXpuulsGCpxp7edMVk0Cx4bzGmyn3oJWHlMJmJx9wgwiY?=
 =?us-ascii?Q?i8L4yoDJ2KzYoEcxqE8snyALlVCZN6w0sX8Fofj3To+1zp8aIBOxN2e0bYZX?=
 =?us-ascii?Q?RnMKGw+4IEdycuok6ahJklTJrpvlulDtNgvG2jaKWGWPwROiAtEz8YGvNQ/7?=
 =?us-ascii?Q?lIlTlxAsS/Bk7g/woqdTsRP2/7J1RkqHT4zRHsWO7nZAyGSunEPFIwim1sys?=
 =?us-ascii?Q?UNKf6KA4ygKXjgOiTXSJ70ramHHaEQlAx1sp4aYokxeaWG6Oxx3Kb2S6VK66?=
 =?us-ascii?Q?gxWhw9ckiqjBvXhK1nxC7pd2PDqMYjTotI9x8QW+iZuEGiwBfyFn+nCMKhmw?=
 =?us-ascii?Q?Pwy7FuoHQMIDjnLJXX7ethemMUtTTi6bBsOES2l8nVECjZdTdZ0pTmaPSIIj?=
 =?us-ascii?Q?MYDqkhAw4t5N0IhmGgJBYh1RNLSc4Ripa6daXJ6VKAaj43XlX1WsYwxAOSWF?=
 =?us-ascii?Q?OHoyf4/Uhnd0d6y1M6qG1xkK4zCeAomzh/EAF8Z9Zwm+2etUnWcq1kQOXR8/?=
 =?us-ascii?Q?NiKhq9T0Kt/wR4rEu041PPg2wJ+IKj8bPy4jXahHc9c9MsuCvAqSFESQHVG4?=
 =?us-ascii?Q?8AlKrMpEdc//rcwbjS7fC6qVZTUAj3IvFPrqTWGxW253V+MajvQrIgG9np1h?=
 =?us-ascii?Q?jbwBkt9Ri15jGyjcWu+FUOZSkg3aSkD74aVYPDzLiBoljrUbK4dfqDS+9wV3?=
 =?us-ascii?Q?mvQJ74tVfJBW40hzG5Uv0i+IdAdHR5Ncf7cF2rhKc7SQgr/DpcAS/xI9xmkv?=
 =?us-ascii?Q?+LO3iXBcxMP2X6S1ZhTztbhEYgAslmI9zZ283dYVnlAokgP2i3M0Lw9p6vit?=
 =?us-ascii?Q?fiOkBUwrC308YPOFKTcJFAEF5TsvSF18KRWaDAjZrme6j3EsLcoZ18R7I/US?=
 =?us-ascii?Q?SDxMMjiogfJ7clJsaZ3kwtnQi3wOjuAItAPgWuS/U97JW3J2GznzjfR7uv96?=
 =?us-ascii?Q?JXZIzJfxp753811SG2EPwuvI7G8ZsYrIQsU3zZgV0PSHw7nTlhDZ8DnvEmOd?=
 =?us-ascii?Q?cSD2mg/QXCz2GrVQyhicRbZiT6u40+kQHExxoynGRT7TfNTwKwmO864atB21?=
 =?us-ascii?Q?C4bKzY4PLZNLz3GX3R4SQ9GfsdXAjIyYit4Ns8Kc1jTV+yr8vF5RMV6MG2dF?=
 =?us-ascii?Q?Z4Km+23iZJTOUQUcZUL0EwD+hiP//WHjb7Op03jRypJYYimMo5npAbI5rw4z?=
 =?us-ascii?Q?ULuNMiIHsxriNUSHQBfr4nUpuVdXzmbeO1uhOOD6i1m66fUwF7aT6YGSdFRI?=
 =?us-ascii?Q?ZB7/pfDF92THWIUmmg91x5Tvn/e2LSmfohI37SjHT3P/Cg3kj2dVVr8GPUWL?=
 =?us-ascii?Q?2CDyFGO+u9YHJLB1cSf/ia+NYctWx8UrR4VIBpshgBA/eXWOcgVhw+UnOUro?=
 =?us-ascii?Q?OyoWXx31zxgVUdXG8P3l/iXZWNqo8VqAU4Yeu7Hfxd9LELuvGMUvR+5Ardln?=
 =?us-ascii?Q?dV8ucQFCTSKI0pM4f+Sf9I52d4bV+4RKoZVZby9Fv9HVemxZABNLRRgxOZBs?=
 =?us-ascii?Q?NijiQSKHJX/JnUfdZvIcL+lxUlmOJnydNpqhkLoOIqgTtjOCq2r0yUM4JIll?=
 =?us-ascii?Q?QlX/f4e1WXg/+aB07JFgQqivmDAuhly4vNA1eB6St4ExX+0ul946bmilNlCi?=
 =?us-ascii?Q?YbUFkpk4u0nlPCb9jRqHTW/bV9UfFapjcmJo8RoE4OIxQXRTC62rY0rOcnnr?=
 =?us-ascii?Q?gcstu3K1EA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7425d545-f9e2-490c-4819-08de7c9a0bfa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 22:37:00.5958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoTpuWdmTbuBsjkYLu1JpI45ohv8nOqptNiBLDndyG4dHPZ/xgk5gdKmQmnmzhV6okLBXjCaMGQtAQgyhg1SZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179

Hi Tejun,

On Fri, Mar 06, 2026 at 02:28:14PM -1000, Tejun Heo wrote:
> Hello,
> 
> SCX_ENQ_IMMED makes enqueue to local DSQs succeed only if the task can
> start running immediately - the current task is done and no other tasks are
> waiting. If the condition isn't met, the task is re-enqueued through
> ops.enqueue(). This gives the BPF scheduler tighter control over when tasks
> actually land on a CPU.

This looks interesting, but I'm trying to understand the typical use case
of this feature.

I agree that we need some kernel support to "atomically" determine when a
CPU is available (it can't be done fully in BPF). Initially I thought the
main target for ENQ_IMMED was to improve latency-sensitive workloads, but
this actually hurts latency, due to the additional re-enqueue cost and in
this case it might be better to be "less perfect" and not use ENQ_IMMED.

So I'm wondering if this feature is more focused at the multiple
sub-scheduler scenario, to prevent that a single scheduler can fill local
DSQs (effectively monopolizing a CPU while tasks sit in line). With
ENQ_IMMED, instead, we can put task on a CPU when it can run *right now*.
So the benefit is more in terms of fairness and isolation between
schedulers, rather than raw latency or throughput.

Am I understanding correctly? If that's the case it might be useful to
clarify this or describe some use cases that you have in mind.

Thanks,
-Andrea

> 
> - Patch 1 disallows setting slice to zero via scx_bpf_task_set_slice() as
>   zero slice is used by ENQ_IMMED to detect whether the current task is
>   done.
> 
> - Patch 2 implements SCX_ENQ_IMMED with reenqueue support and loop
>   detection.
> 
> - Patch 3 adds SCX_OPS_ALWAYS_ENQ_IMMED ops flag to automatically apply
>   IMMED to all local DSQ enqueues.
> 
> This patchset depends on:
> 
> - "sched_ext: Overhaul DSQ reenqueue infrastructure"
>   http://lkml.kernel.org/r/20260306190623.1076074-1-tj@kernel.org
> 
> Based on sched_ext/for-7.1 (4f8b122848db) + scx-reenq (a41719e6ae12).
> 
>  0001-sched_ext-Disallow-setting-slice-to-zero-via-scx_bpf.patch
>  0002-sched_ext-Implement-SCX_ENQ_IMMED.patch
>  0003-sched_ext-Add-SCX_OPS_ALWAYS_ENQ_IMMED-ops-flag.patch
> 
> Git tree:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-enq-immed
> 
>  include/linux/sched/ext.h            |   3 +
>  kernel/sched/ext.c                   | 208 +++++++++++++++++++++++++++++++----
>  kernel/sched/ext_internal.h          |  43 ++++++++
>  kernel/sched/sched.h                 |   2 +
>  tools/sched_ext/include/scx/compat.h |   1 +
>  tools/sched_ext/scx_qmap.bpf.c       |   7 +-
>  tools/sched_ext/scx_qmap.c           |   9 +-
>  7 files changed, 250 insertions(+), 23 deletions(-)
> 
> --
> tejun
